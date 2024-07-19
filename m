Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7620CC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3770288C25;
	Fri, 19 Jul 2024 17:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a5LVzHOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4686A88BF2; Fri, 19 Jul 2024 17:05:37 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 310B088C1F
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b7a3b75133so10838246d6.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721401534; x=1722006334; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y25LCJxgr3g60E58hLn4n+uGc8NTGd6TkeiaqdwV4II=;
 b=a5LVzHOFZ56PoSFDurMwYGuMYtnkgUN9EIFIxrp7qvqmJrA0oQkCzbMOCvPSs9Thhh
 9UBeoTkFkPzy/cIk6pTxKSWlcBh3JW2zHLf6fymPV8x/cg9z8aUHQElk4gkO2KADYWEy
 m7K5wbLKpYVY6VrEGjwklvt8NhtdCCCTa2CXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401534; x=1722006334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y25LCJxgr3g60E58hLn4n+uGc8NTGd6TkeiaqdwV4II=;
 b=EVVEbevo6At8mRia4i3klUe9AV9+PsMCs1G7fawqvAfXj+9PSb4Si+SWs5lppAbALZ
 qyQGj6Kc1P7LO/ooJ+zNfmWORrtzO48/O1AvPOiaEZGo2igFqVJkTYzSZJckKeUhP0z1
 /BqnM7dEPJOOyTb4CdKOXXj4RvF6hxeYwV+iy5ilagFvjQf2RcqyQiMnUkXvlBXkwAnP
 kksgZha2ZSnRybkiQb60CAQmhwdH7mCxO7PUyJLZNy1CUne5041f/QyEGCNUc6HGSWr7
 II3SDZie+64K0T1wzG2JxMKErvgF76OZt0WeGKUcpctPdWTmX1EX2S3aph2XuwCZDu7t
 Oihg==
X-Gm-Message-State: AOJu0Yx0qE7z7Q2eHY1l7YcVU8DQyct0PC18TQA4S2ybhYEPDJzmxal4
 ZO1vtgj7CUFonVO1kGlfAzT2Y7OQ7zoDRz/ZYb7XVsyq6zERd8rco7t4YGbuHormXEfWcH0xIp5
 XGOwTAyx0YTqV+13Wb0y+Zj7KXhRP1EPbRgn7
X-Google-Smtp-Source: AGHT+IHuoE3jben27XeYFZ8j5ICZgQiXZMXFwO4vPRr4we8POxQNQj0SIRCTV0t/chiufSjRM2NXgCLuCbyph3ASBGA=
X-Received: by 2002:a05:6214:21c9:b0:6b4:f9b0:e8c4 with SMTP id
 6a1803df08f44-6b94f02a935mr3706836d6.10.1721401534039; Fri, 19 Jul 2024
 08:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240719114850.28134-1-Zhiqiang.Hou@nxp.com>
 <20240719114850.28134-2-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240719114850.28134-2-Zhiqiang.Hou@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jul 2024 16:05:23 +0100
Message-ID: <CAFLszTgmhnQBO4LtXfY_COuVWPA1TANQwGASDCpf5bm2OFd5xg@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] mp: imx9: add cpu command support
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, sbabic@denx.de, festevam@gmail.com, 
 uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com, 
 Tao Yang <Tao.Yang1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Zhiqiang,

On Fri, 19 Jul 2024 at 12:28, Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Tao Yang <Tao.Yang1@nxp.com>
>
> Implement the cpu command to kick cpu core to run barematel or RTOS
> applications.
>
> Signed-off-by: Tao Yang <Tao.Yang1@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  arch/arm/mach-imx/imx9/Makefile |  4 +-
>  arch/arm/mach-imx/imx9/mp.c     | 81 +++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-imx/imx9/mp.c

This seems to be adding more code to a deprecated API. It should use
UCLASS_CPU and driver model. See the comment at the top of cpu_func.h

Regards,
Simon
