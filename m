Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4DAC531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 14:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D48588B23;
	Fri, 16 Aug 2024 16:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XoYOyur2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221C988BA7; Fri, 16 Aug 2024 16:49:42 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F8988A99
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 16:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso1616074a12.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723819778; x=1724424578; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GeauYuSIosPH/xR9hWDBKc9Z23B6Ob4p1yjVsUHt+88=;
 b=XoYOyur25057cBkZpzeROhCrXfYKY/bT+CNm64up02nI50U3jjZ524R7WuNJrHDrUU
 q7RxXgcMchRNamYU450pq+ZDPR3Zuu6CUJjAObPRjPDbD9aUJExpn1c8BUeILcOMCLBi
 hUmSkPU8DqmDDbM5iAX0loeP5eGUKdW/DbojU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723819778; x=1724424578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GeauYuSIosPH/xR9hWDBKc9Z23B6Ob4p1yjVsUHt+88=;
 b=MIaEYkLL+4YdTxqf5Al2Z1JS8CaY/W8oruOiK49h1CVrAsxGfTUhtzQsAL+GNcctgq
 4wm56kSl8M7oEgNY4Rbia7h43t0ejs2DVGqpm0BGcpmeJopckIfLSeu3DCeYmiQcVscx
 JJYYf52vYmwbcAYYl0Olk3zlnE5ubRlRSt/jF/ScNMi7OdJQ+nP+AZ1ujUmMehftFVm+
 ARmszD30DvFYxiKbMLmh7Wwgjrl7ZwBrEqH9IHEv3z1Le4tj5EP3O7Vti4JB4TL+UOK/
 GulXseT28zyQAhw3go5QweDUwaFzQ1eUeJTWuJvyGop+EckEhH5Rca1tv66VTFZDIhY6
 DP4Q==
X-Gm-Message-State: AOJu0Yw1ShIhL25Ls7QLU6EKVFDTFGJfH0uia6PUVdDl0PAZE7zQVJG/
 tYtIp2Bl8TcFqT5luFcxbzmJ2ONa4rbbzPKOcU0QqTsyAhTJ60El3qCEmxsmSMSOzpVpwl03s7x
 o2WJjKSY7zRod7+j6u0w24eJE/PbZuLrWXKBIimVazG/gvBg=
X-Google-Smtp-Source: AGHT+IEuPBJ3ihYLsVkyCBwAF10PHU6gDdMmGjXhXwo/wDOTQ/UrPaKwAO1FQh9Ny4IsqjPms72wQDcK6xjgp4Dvp9o=
X-Received: by 2002:a17:90b:4b47:b0:2ca:5a46:cbc8 with SMTP id
 98e67ed59e1d1-2d3e00f01c2mr3519247a91.26.1723819777681; Fri, 16 Aug 2024
 07:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240816034905.3541020-1-trini@konsulko.com>
 <20240816034905.3541020-3-trini@konsulko.com>
In-Reply-To: <20240816034905.3541020-3-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Aug 2024 08:49:24 -0600
Message-ID: <CAFLszThuk3HbL7zyLKN12R9COt8QbjuWo1O-6R_O=cyY8Oy0dQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] test/cmd: Move wget test to under a sandbox guard
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 15 Aug 2024 at 21:49, Tom Rini <trini@konsulko.com> wrote:
>
> This test is sandbox-centric, so guard it so.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  test/cmd/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index 478ef4c6f057..8f2134998ad0 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -30,7 +30,7 @@ ifdef CONFIG_SANDBOX
>  obj-$(CONFIG_CMD_MBR) += mbr.o
>  obj-$(CONFIG_CMD_READ) += rw.o
>  obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
> +obj-$(CONFIG_CMD_WGET) += wget.o
>  obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
>  endif
>  obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
> -obj-$(CONFIG_CMD_WGET) += wget.o
> --
> 2.34.1
>
