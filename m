Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D101EC47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 07:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 342AB8753E;
	Fri,  2 Feb 2024 08:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pNBP9zID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08DA187527; Fri,  2 Feb 2024 08:58:04 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53DAE8753E
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 08:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7ce55932330so764575241.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 23:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706860679; x=1707465479; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WAXOpiTgACV8nOBCJwbaF0ENA1/AL7wZwKjwzdeYb48=;
 b=pNBP9zIDR+EXBJM+xtjXB7SCAE9dOUSGY4WC08zV94dNS7GTm+BzEpSZQac0liJcyl
 AwrkhPHb7U51H+lEaXj46BCfYj4g+Lr4riLNmnafqeSYUP0hfrQAJgrD05rGaIv17FCk
 +tInLIJaWGB4ySmpue2+2PevFRDOPecmHUKo0FyKATVcFW6dGS3grPpSe1tDNA3xdxud
 FLvZ6Np1G/zrYV0fSqc1kZUt4GD5igS93YHyad1GFq9FTZJTlCrqT1CFQHimuPufSDpF
 yIm8AXzQj30Ht9gV8VXsSpNtKmfCo2jaAZPA7nbVLLvBRJbh/i/H081r3OVNvS5uedS4
 b/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706860679; x=1707465479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WAXOpiTgACV8nOBCJwbaF0ENA1/AL7wZwKjwzdeYb48=;
 b=mrpEbJVnkwu7f11zGS4Sc05veRN8FarpgcK9S2f4ZbSfMkU4bn4QURktCiLEH8SAkC
 p6nd8ZhhNCrjX6/WujqwLcRFHbzlOHNTc/KbDKDr5JC71Ckw48X2AIyFAX9PH4A3ff0d
 I5ggccGM16tj/RAqb5kH5Q3Ekl/FMSf0A8PDnHjgWKzAtJRQ5ZP+aDvoDFa2YV6X4vyp
 tYeoyNMFF9r5fLzfNZHkJLDPzpdWGLKYCX7q1Esy4ApwB+vbNERotW74QD1GUf+3dP9g
 q3zZUWZDbJ6HtUqIMeShlH+oaiSwZyjraG76pmlce39ETCiE+SVWwStbsG80HLEPfWpH
 Q1/A==
X-Gm-Message-State: AOJu0Ywj5hS69VvUKJnrnhAMqeg4C15BR1IxfLs8sKMLxw6FyKJEBgJo
 /XA2MUMiOGIX81bZBYYwMwkl264r5wix/kt28mx1bL8aPMfleuPaao01KtxaM4LU89eOmgy0W5T
 3+r9/liyB6ygjtOgm4k9oxXm8s7TIIdx9zlvv/A==
X-Google-Smtp-Source: AGHT+IF/Hq5DP4VN63C+I9RZ05KUJ5zGQMnWDilWqlSV7SXPkAbROOHjV4CcV5ooXFL6z8TsqN+xREohXEubLt6wG/o=
X-Received: by 2002:a05:6102:3977:b0:46d:5da:f92e with SMTP id
 ho23-20020a056102397700b0046d05daf92emr279718vsb.33.1706860678934; Thu, 01
 Feb 2024 23:57:58 -0800 (PST)
MIME-Version: 1.0
References: <20240201030634.1120963-16-bb@ti.com>
 <20240201030634.1120963-28-bb@ti.com>
In-Reply-To: <20240201030634.1120963-28-bb@ti.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 2 Feb 2024 13:27:47 +0530
Message-ID: <CAFA6WYNuc_-Mk7GKGe6U8UiGwOVVT05xVo-avQfG_HkbbshGDA@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] Makefile: remove hardcoded device tree source
 directory
To: Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Nishanth Menon <nm@ti.com>, 
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>
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

On Thu, 1 Feb 2024 at 08:36, Bryan Brattlof <bb@ti.com> wrote:
>
> Some boards that choose to utilize the OF_UPSTREAM directory for their
> device tree files will need to specify that directory instead of the
> traditional arch/$(ARCH)/dts/* path.
>
> Include the correct path to the board's dtbs depending on if OF_UPSTREAM
> is selected or not.
>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  Makefile             | 18 ++++++++++++++----
>  scripts/Makefile.spl | 17 +++++++++++++----
>  2 files changed, 27 insertions(+), 8 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/Makefile b/Makefile
> index 996a43c8624ae..f81d09c892b80 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1184,6 +1184,16 @@ dt_binding_check: scripts_dtc
>  quiet_cmd_copy = COPY    $@
>        cmd_copy = cp $< $@
>
> +ifeq ($(CONFIG_OF_UPSTREAM),y)
> +ifeq ($(CONFIG_ARM64),y)
> +dt_dir := dts/upstream/src/arm64
> +else
> +dt_dir := dts/upstream/src/$(ARCH)
> +endif
> +else
> +dt_dir := arch/$(ARCH)/dts
> +endif
> +
>  ifeq ($(CONFIG_MULTI_DTB_FIT),y)
>
>  ifeq ($(CONFIG_MULTI_DTB_FIT_LZO),y)
> @@ -1209,7 +1219,7 @@ endif
>
>  MKIMAGEFLAGS_fit-dtb.blob = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
>         -a 0 -e 0 -E \
> -       $(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) -d /dev/null
> +       $(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) -d /dev/null
>
>  MKIMAGEFLAGS_fit-dtb.blob += -B 0x8
>
> @@ -1407,9 +1417,9 @@ MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
>         -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
>         -p $(CONFIG_FIT_EXTERNAL_OFFSET) \
>         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
> -       $(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(DEVICE_TREE))) \
> -       $(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) \
> -       $(patsubst %,-b arch/$(ARCH)/dts/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
> +       $(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(DEVICE_TREE))) \
> +       $(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) \
> +       $(patsubst %,-b $(dt_dir)/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
>  else
>  MKIMAGEFLAGS_u-boot.img = -A $(ARCH) -T firmware -C none -O u-boot \
>         -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
> index 407fc52376a50..d074ba2350065 100644
> --- a/scripts/Makefile.spl
> +++ b/scripts/Makefile.spl
> @@ -559,9 +559,15 @@ FORCE:
>  $(obj)/dts/dt-$(SPL_NAME).dtb: dts/dt.dtb
>         $(Q)$(MAKE) $(build)=$(obj)/dts spl_dtbs
>
> -PHONY += dts_dir
> -dts_dir:
> -       $(shell [ -d $(obj)/dts ] || mkdir -p $(obj)/dts)
> +ifeq ($(CONFIG_OF_UPSTREAM),y)
> +ifeq ($(CONFIG_ARM64),y)
> +dt_dir := dts/upstream/src/arm64
> +else
> +dt_dir := dts/upstream/src/$(ARCH)
> +endif
> +else
> +dt_dir := arch/$(ARCH)/dts
> +endif
>
>  # Declare the contents of the .PHONY variable as phony.  We keep that
>  # information in a variable so we can use it in if_changed and friends.
> @@ -569,8 +575,11 @@ dts_dir:
>
>  SPL_OF_LIST_TARGETS = $(patsubst %,dts/%.dtb,$(subst ",,$(CONFIG_SPL_OF_LIST)))
>  SHRUNK_ARCH_DTB = $(addprefix $(obj)/,$(SPL_OF_LIST_TARGETS))
> +$(dir $(SHRUNK_ARCH_DTB)):
> +       $(shell [ -d $@ ] || mkdir -p $@)
> +
>  .SECONDEXPANSION:
> -$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, arch/$(ARCH)/dts/%, $$@) dts_dir
> +$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, $(dt_dir)/%, $$@) $(dir $(SHRUNK_ARCH_DTB))
>         $(call if_changed,fdtgrep)
>
>  targets += $(SPL_OF_LIST_TARGETS)
> --
> 2.43.0
>
