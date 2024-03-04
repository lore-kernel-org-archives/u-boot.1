Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5E2C54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 06:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C41D687CDB;
	Mon,  4 Mar 2024 07:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sMcdqNbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D8C87F51; Mon,  4 Mar 2024 07:40:35 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D5EC87CDB
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 07:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7d5c40f874aso2354433241.1
 for <u-boot@lists.denx.de>; Sun, 03 Mar 2024 22:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709534432; x=1710139232; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YsfMBwNeRQOvjWBYv/iz6aYxeEEWgN0VFvWq2ojn4Rc=;
 b=sMcdqNbNWkrrfjy94uoBxjKlbkZT9EfJG+mYLITt07jjzf5RW0/Zmxr/Z3ZGIQmc7F
 7b3ZgzwEs+7qLd4mg0x1eLzmgWFcPyV5wKv6Pt5prUziAKtWHGFHz+HbbgRnNNaXBYTU
 Ocp19jotGlN4D4E2+CBR4rLTdZ3ge9MTn0+f/UTqvy92C276YDmRhZk6Uoy/6zcIbeas
 BQnDGfMKx8yN/duKGXI7Stv1nJKx++BAVlAPkEQvuPjaXoW3+mC4t5KlTdY0GEJdrnIM
 MmxRsT7ivc3FLb9G3Z3L34UZX0GNQegWLwBDoADRqhE6QYdY0ZPYmOz4ml5SxxY6M8aB
 fsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709534432; x=1710139232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YsfMBwNeRQOvjWBYv/iz6aYxeEEWgN0VFvWq2ojn4Rc=;
 b=jJ4AA9NtZ9fmnN7xJ0fLqvsNbem+p/k1bmLd3ylwzcsSRnSBOFsjh1eB7mYj6lrq30
 yeTNpydCYeJgmNoI5+uHWdAfOO7cOrjwqBdJo84GZbMzxJgbmb2g6t4ns5bKTJ/6u37S
 nn+JVPjbz0peEMybnNjxxjblFwxTrWvhmo10amIEOan8s9I4WG8mA07gCsTkR5Kmpr7p
 hh4RCfbnpDqnqbgRJMjvhSofIn20DTEf2q1MXv2sJi1L4a/3OE0KD3tNbF0ZGCcJPtNv
 MDoaNM7XzXJQHSqyyrLYFE8NZlrTo66R6/2/vd8x4n0vdfLlE87w0Ybeyd3LAfDB+Egh
 FYPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJU1tZ0grLFNYapSSfny+EKJZ0wDAtfZevLs34gm7VYlj5vuQI7IAhV8//GFATBPz6faWTb1STpwLNRc3j59aHNJ0rcA==
X-Gm-Message-State: AOJu0Yy+UkkEdJTW29bifol3YTSxe/8EDSmTAxfSOv/GbQetwsh5xFCq
 FfwqilPDNYERE8YX6srIp7rByMOaBeiW/aFPnZHeuwPb9hylNVVye/pofCB3NTGvEpwJ1xyIeDs
 hQ1PsisYlfdrAwsrGSWoq53vU7Sj7RBg2RPukgw==
X-Google-Smtp-Source: AGHT+IG/u7yZne9Xsbeg8YQo7RlKA4iUHpnFPl66YK0+qKuDluVoAujnAouUMDTiOWJ3i0s35fXUD8HMijOeAvuOUpY=
X-Received: by 2002:a67:f111:0:b0:472:6b52:1a3c with SMTP id
 n17-20020a67f111000000b004726b521a3cmr5209380vsk.15.1709534431960; Sun, 03
 Mar 2024 22:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
 <20240205-am62px-wip-rebasing-v3-11-04cbb42eaa6f@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v3-11-04cbb42eaa6f@ti.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 4 Mar 2024 12:10:21 +0530
Message-ID: <CAFA6WYPxXM5d=kpRTmEV7+8gYhgQr-rbX8hp=raOXmC79fSu+A@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] Makefile: remove hardcoded device tree source
 directory
To: Tom Rini <trini@konsulko.com>
Cc: Bryan Brattlof <bb@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Nishanth Menon <nm@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, 
 Hari Nagalla <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Fabio Estevam <festevam@gmail.com>
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

+ Fabio

Hi Tom,

On Tue, 27 Feb 2024 at 02:49, Bryan Brattlof <bb@ti.com> wrote:
>
> Some boards that choose to utilize the OF_UPSTREAM directory for their
> device tree files will need to specify that directory instead of the
> traditional arch/$(ARCH)/dts/* path.
>
> Include the correct path to the board's dtbs depending on if OF_UPSTREAM
> is selected or not.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  Makefile             | 18 ++++++++++++++----
>  scripts/Makefile.spl | 17 +++++++++++++----
>  2 files changed, 27 insertions(+), 8 deletions(-)
>

Can you pick up this patch independently for -next since it's needed
for other platforms to switch to OF_UPSTREAM? However, if you are
already planning to pick this series overall then I am fine with that
too.

-Sumit

> diff --git a/Makefile b/Makefile
> index 0f0c7f30d2717..51b57d26857f1 100644
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
>
> --
> 2.43.2
>
