Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C10C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 06:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 807CE87D25;
	Wed,  6 Mar 2024 07:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VjsSnI6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8782D87D33; Wed,  6 Mar 2024 07:00:37 +0100 (CET)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 679D686F6E
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 07:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7cedcea89a0so3958622241.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 22:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709704834; x=1710309634; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=THIRWzfgfc2KOZnMb7HAaMhUCMHxu616izXyZT+zDAQ=;
 b=VjsSnI6FptwAwWQE6/c1Duy+TIey4gI5+UV3BaQX6HsNwiXB35cTl8OZDMq7v7NYAQ
 Wfd5a46kCBRJavMhS32ZMT3ZN0X2LBJos434FJgCYRDHdBSTeDQvlxO/7Vs5a3LjSCbU
 8oOVC5nsCnd67ku0ePlmPOxGcQvqruRF2zTpEx9kScIDz1Rwayb6GbXU/fYteux65/KK
 fSZ+GhU6PfDo2Q0x+DRRp0pkGkhjO+zwZzXMHvDXP6GUgtj1YEBBUNIw9r6XwuX/VR+L
 wH8+usbUaSvGxblbc6kepGqggM/y0NGvPCOrnl/xQCTtwuxOhdkqJKq5eBFUAgpiwycw
 YHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709704834; x=1710309634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=THIRWzfgfc2KOZnMb7HAaMhUCMHxu616izXyZT+zDAQ=;
 b=TGYLNpJWaeOVypIqRAyeuDQC9gs7fSnCIxaxx4SFHDJJ4nZwxPaiC+9q/J2PycC3Kz
 m3Ooh8N+vPjOK72GM7j1aY6WWGh2AHRotSNseDGB4Mg1kG0OWSI25r7PWC/m7jU1p3f6
 A2RIBq1dxirHkBfzT5mqO/5+sPI68mBaT6x0VUZPi/C1hLaxZCXudVRlFtnS93uwNpWK
 h4ssndhrXaljneLao162DO3RZAMwsY77vqowc8SSRZuS8DiaJ8CkoUBiYvmakEg1C0BW
 2nf6EjsOnDjtH+GQwF0bEOp0Mb+pFJ8a3mVmdoTGt48ClvhwY+LDcMK5HIwofLLcBX1w
 EBaQ==
X-Gm-Message-State: AOJu0Yy/JAbFnkrIB58hyUP3JGNni2uZbdPw6i7Y/Tz5Y7B1l40O3vcf
 /GfKA2Z8JorQDOhDPEfLW23+Xv0BlzZkqZ9gf5yKEDSafs28b8G6fr4++AJze4OtqyAuzIUIi8r
 gtAF6YaipVHBsvQ8fyY0h/zFbK+VsUA9SDp4mqw==
X-Google-Smtp-Source: AGHT+IHdBcwq1nHRju5t3egHPoZqWQBl+XkHzWXYvOzbvbfmj1R4I5EKTm2YH530KJBcHsa0Ivj4sUNVHM+Nw4tJyrA=
X-Received: by 2002:a05:6102:6c9:b0:471:d67f:ea2 with SMTP id
 m9-20020a05610206c900b00471d67f0ea2mr4727803vsg.19.1709704834072; Tue, 05 Mar
 2024 22:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-2-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-2-volodymyr_babchuk@epam.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 6 Mar 2024 11:30:22 +0530
Message-ID: <CAFA6WYNRQnm=isav4RLa0=wCK50iTYrxNSR6hUx=_5vPhjQe3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] qcom: board: validate fdt before trying to use it
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 6 Mar 2024 at 06:23, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> There are cases when previous bootloader stage leaves some seemingly
> valid value in r0, which in fact does not point to valid FDT
> blob. This behavior was encountered when trying to boot U-Boot as
> "hyp" loader on SA8155P-ADP.
>
> To be sure that we really got the pointer to a device tree we need to
> validate it with fdt_valid() function.
>
> Note: This approach is not 100% fool-proof, as get_prev_bl_fdt_addr()
> theoretically can return a pointer to a region that is not physically
> mapped and we will get data abort exception when "fdt_valid" will try
> to access it. But at this early boot stage we don't know where RAM is
> anyways so there is little we can do.
>

I suppose this approach allows us to reuse the same U-Boot binary when
booted in EL2 more or when loaded by ABL. So I am fine with this
approach.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>
> ---
>
> Changes in v2:
>  - New patch in v2
>
>  arch/arm/mach-snapdragon/board.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index f12f5791a1..10eec47ada 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -24,6 +24,7 @@
>  #include <linux/sizes.h>
>  #include <lmb.h>
>  #include <malloc.h>
> +#include <fdt_support.h>
>  #include <usb.h>
>  #include <sort.h>
>
> @@ -93,7 +94,9 @@ void *board_fdt_blob_setup(int *err)
>          * try and use the FDT built into U-Boot if there is one...
>          * This avoids having a hard dependency on the previous stage bootloader
>          */
> -       if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt != ALIGN(fdt, SZ_4K))) {
> +
> +       if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt != ALIGN(fdt, SZ_4K) ||
> +                                              !fdt_valid((void *)&fdt))) {
>                 debug("%s: Using built in FDT, bootloader gave us %#llx\n", __func__, fdt);
>                 return (void *)gd->fdt_blob;
>         }
> --
> 2.43.0
