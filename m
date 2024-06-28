Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E79DC2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 07:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703C78857D;
	Fri, 28 Jun 2024 09:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BsKivL3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC4A7885A3; Fri, 28 Jun 2024 09:33:16 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED1F188261
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 09:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b4fe2c79fdso1924826d6.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719559993; x=1720164793; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VLK6Fe7ozgs9nx0YImc0xVL+BjMNTvG9aLXQirts+Zc=;
 b=BsKivL3CdDCj4C372D5VADdgS5O1Q3C5V80F7pzmDOapJAMnPEE2XYfmklrWjiFKD7
 vk6PPomNJcx7qi4bd6VgD+b5FBQMR+ERFanNfJXaKzowyDc7Yjyh7HEbXhjZt59MOWcS
 7We0lWcho/oB2jPp7+dktKFkNi4vXrrnlLJ0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719559993; x=1720164793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VLK6Fe7ozgs9nx0YImc0xVL+BjMNTvG9aLXQirts+Zc=;
 b=wx1SWTLB0iuNkBXYjgLnG6QjKgQZImucgrWcH3sAemhxbkN6vusooLid/ag8hpdO+/
 d8u9bDKpV//k/1oXcVz5saYTRLg4WeIjfc0pAywfyzXMjToIHsbLQzyPDl/S7zXP2p+I
 +XY9QHZFW8GS+K+hSfDRGjj7yzvPQQoghJGQuUuhgKr18lmza/fva0GT4Vmh3pejbooz
 gYyA/TFNqBVtjEA8wg/bsMv6GIK8liPQ/bHTRZ6S9d6Jh5YgOOhjfsEpjN3tnhy/ASS9
 y5ICLMWXkO/S8xUlMOA+dFEyjN/5G0Cm29cOXTrj1jwVfmOx9//RxDFDfgRvSqJogwUS
 UBBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOCgIdC8NLX7cD8HiuuGLXRKNHHu3eE5G+w9L6jxMI7tR5E9Q9NFzj0eaEDSKBqphIFCAtyRBv3qLhersqAbPQ9+6DWg==
X-Gm-Message-State: AOJu0Yxrn9D7+bmUY+rtS266X3SioYXeQ5x32p8ML4QyA9YxE2tjrocX
 JVHO2TJtm5wT+u65CUtbiLb3VZdjDDUNb2OpI2SyOCaF/vwcdzdr12T84F3MyGL4s02JrqmkyXV
 pC/UggJahsfMn0TTKTn4IZMBW4MjvZm69c+HM
X-Google-Smtp-Source: AGHT+IEvArYTr5/lwbU/7VARa6k5sShQLCUWrWnJ318d5VfJKD0fK26/qzX6ITcuq1zqCFxoUdusKNMrd8mVxgm0OJY=
X-Received: by 2002:a0c:e4d4:0:b0:6b2:de9a:409e with SMTP id
 6a1803df08f44-6b53c035f0fmr161624106d6.65.1719559992888; Fri, 28 Jun 2024
 00:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240627113546.100333-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240627113546.100333-1-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Jun 2024 08:33:02 +0100
Message-ID: <CAFLszTi+uhnV0HW-XeafPd5Ra8bOX8vMh-bcyZ3LGOdZ0h09Yg@mail.gmail.com>
Subject: Re: [PATCH 1/3] fit_dtb: relocate whole fit dtb image instead of
 selected dtb only
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Chanho Park <chanho61.park@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

Hi Mikhail,

On Thu, 27 Jun 2024 at 12:35, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> U-Boot with linked fit dtb image may be loaded by a bootloader to
> a low memory. On a later stage U-Boot will relocate itself and used
> dtb.
>
> There is no problem until we decide to reselect dtb on a later stage.
> In this case dtb placed in the low memory address may be selected.
> But this data can be overwritted by flash reading or network file
> transfer. Thus we will use damaged dtb.
>
> To fix it move the whole fit dtb image instead of just used dtb.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  boot/boot_fit.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  common/board_f.c   | 34 ++++++++++++++++++++++++++++----
>  include/boot_fit.h |  8 ++++++++
>  3 files changed, 86 insertions(+), 4 deletions(-)
>

The current mechanism is in reloc_fdt() but it only happens during
relocation. What is the later stage you refer to? Is it after
relocation, or before?

Regards,
Simon
