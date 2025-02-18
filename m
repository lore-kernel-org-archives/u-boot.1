Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF1CC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A8EA8043C;
	Tue, 18 Feb 2025 09:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MvDnioQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5ACC807F1; Tue, 18 Feb 2025 09:11:10 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC31480104
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so3906075276.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 00:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739866266; x=1740471066; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ra6BdgehKTkxAlAJNZSIulgc+WXJucWn1MbPxGsyDQ8=;
 b=MvDnioQU2+9qGH6MVE7HONSBZZF2XYcww2gNXaQtaIdPkPWoz7amxoZuxZ58OUDIuo
 r3x6UoQcL/koOAS3oDZ6vOMsGY7jDGL+T5H6zaJAv40llo4mvE6F8HSxgHGkOfV6GgTj
 TYSvmAnsyB+vXXbWXrulne1TDi6E3N9N56+4WlmDvetlkWkgCWZBzioWO2Xa8iyHrPxV
 57lo014iNSYv3r144I1DwY/LVOGXM8DRGAYQ2h48ydc/a6L9mDx8+4eH9Yx4t+ujYxrd
 j5MutHWqD6hSbLP0lMDadEYvmicHqZiYaajhwoBQwoj8rUO53Cm0RjDnqQi9iGa0iNdP
 9XGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739866266; x=1740471066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ra6BdgehKTkxAlAJNZSIulgc+WXJucWn1MbPxGsyDQ8=;
 b=HWpBw8WaKK/TK47RrGInvt8IyHt15V+pLdbZEotjRnBe106ZAvj7mTpQ0P10H+3htH
 +BXpk6nP7yLI5TpVrZUHEJ69jMEOwyZn47Q6ISXFNoMkOPlQlt1y63za2J9Wsbr6hgOO
 ZSGJ6B8M5btrlQUfA0RM4eDhYZJfHSemMHuGChQowJ8eklPp+2fByRYHGC6maE+3fciL
 szc1jOHlHpA6Upia+yUq0cg9leQgcBIfFlpbCHeXdtL5gOFsX061Sk+qNg0yiJ/7Oh7N
 NE+1HdQzqq2iOI173Pm4EBchHYN30hNx6eBJQ7aIX08NCrYXvqaWtCoeIOWUxevMTnhM
 Jm6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJeQRMO1hbE5WYT/Mhrrcjpi22i8l2gyFGRHqQis0DLRBC2m83hFB1hg0qPh8+DNoRFgNb3dc=@lists.denx.de
X-Gm-Message-State: AOJu0YzrYwivWMnTSIcbXQYXxjp04siiKJNNl5y+YiyCqc8YRts+TOFr
 xWoIkIyjJ42RFr9Duerfns13tZ5rQ6SmqROfJgq4zz2mxi3EmKJygiGl32Fgkemz3KCqeFeGuTR
 E20xJZJwtenFTgOXVsQnNbnTr0yXBdRRmD+ZNMA==
X-Gm-Gg: ASbGncu61dVuwsLvU1fJoE5+chc3StYsn7kbD5nnKSDEFOUAIrYiyN/YdVvX7zWT1l+
 9XW0s/yEAq+gxf0EAueYbIf5R5yM22doypVOYb5WmcTi9NdhnYl7O1a3mNDEb2DfWyVC6MqVoRA
 ==
X-Google-Smtp-Source: AGHT+IGsArl5QR4x2mWEgXE31NFy40dQ/3JKdha0C34S5e40OozUIE9qEwpqxqaDT+RStJ15FTqcPib+A6gORpehnEo=
X-Received: by 2002:a05:6902:11c9:b0:e5d:fb92:cb0 with SMTP id
 3f1490d57ef6-e5dfb92430emr2641483276.12.1739866266542; Tue, 18 Feb 2025
 00:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20250213195351.3518305-1-j-humphreys@ti.com>
 <20250213195351.3518305-4-j-humphreys@ti.com>
In-Reply-To: <20250213195351.3518305-4-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 18 Feb 2025 10:10:29 +0200
X-Gm-Features: AWEUYZmtxAVm22nDOX27j1OsADLMia_EEXTXCKIKxXpXSF0r0rycjM2jrZexzvM
Message-ID: <CAC_iWjL8gH0kwZg4rtN+u31_pA-v3N74i-4t3C+7VgNzLrSCEw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] board: remove capsule update support in
 set_dfu_alt_info()
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Udit Kumar <u-kumar1@ti.com>, 
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Daniel Schultz <d.schultz@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Lukasz Majewski <lukma@denx.de>,
 s-vadapalli@ti.com, u-boot@lists.denx.de
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

Hi Jonathan

This is a nice cleanup.

[...]

>
>  {
>         return 0;
> diff --git a/board/xilinx/common/board.h b/board/xilinx/common/board.h
> index 64d657673e9..cb86c4c5b91 100644
> --- a/board/xilinx/common/board.h
> +++ b/board/xilinx/common/board.h
> @@ -18,4 +18,7 @@ bool board_detection(void);
>  char *soc_name_decode(void);
>
>  bool soc_detection(void);
> +
> +void configure_capsule_updates(void);
> +
>  #endif /* BOARD_XILINX_COMMON_BOARD_H */
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 2c387630a61..05530736751 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -281,6 +281,9 @@ int board_late_init(void)
>  {
>         int ret;
>
> +       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> +               configure_capsule_updates();
> +
>         if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
>                 debug("Saved variables - Skipping\n");
>                 return 0;
> @@ -357,8 +360,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
>  }
>  #endif
>
> -#if defined(CONFIG_SET_DFU_ALT_INFO)
> -
>  #define DFU_ALT_BUF_LEN                SZ_1K
>
>  static void mtd_found_part(u32 *base, u32 *size)
> @@ -386,7 +387,7 @@ static void mtd_found_part(u32 *base, u32 *size)
>         }
>  }
>
> -void set_dfu_alt_info(char *interface, char *devstr)
> +void configure_capsule_updates(void)
>  {
>         int bootseq = 0, len = 0;
>         u32 multiboot = versal_multi_boot();
> @@ -394,9 +395,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>
>         ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
>
> -       if (env_get("dfu_alt_info"))
> -               return;
> -
>         memset(buf, 0, sizeof(buf));
>
>         multiboot = env_get_hex("multiboot", multiboot);
> @@ -437,9 +435,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>                 return;
>         }
>
> -       env_set("dfu_alt_info", buf);
> -       puts("DFU alt info setting: done\n");
>         update_info.dfu_string = strdup(buf);
>         debug("Capsule DFU: %s\n", update_info.dfu_string);
>  }
> -#endif
> diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
> index bd004b86a88..b1fd768a26c 100644
> --- a/board/xilinx/zynq/board.c
> +++ b/board/xilinx/zynq/board.c
> @@ -53,6 +53,9 @@ int board_late_init(void)
>         char *new_targets;
>         char *env_targets;
>
> +       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> +               configure_capsule_updates();
> +
>         if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
>                 debug("Saved variables - Skipping\n");
>                 return 0;
> @@ -166,17 +169,12 @@ enum env_location env_get_location(enum env_operation op, int prio)
>         }
>  }
>
> -#if defined(CONFIG_SET_DFU_ALT_INFO)
> -
>  #define DFU_ALT_BUF_LEN                SZ_1K
>
> -void set_dfu_alt_info(char *interface, char *devstr)
> +void configure_capsule_updates(void)
>  {
>         ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
>
> -       if (env_get("dfu_alt_info"))
> -               return;
> -
>         memset(buf, 0, sizeof(buf));
>
>         switch ((zynq_slcr_get_boot_mode()) & ZYNQ_BM_MASK) {
> @@ -198,9 +196,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>                 return;
>         }
>
> -       env_set("dfu_alt_info", buf);
> -       puts("DFU alt info setting: done\n");
>         update_info.dfu_string = strdup(buf);
>         debug("Capsule DFU: %s\n", update_info.dfu_string);
>  }
> -#endif
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 8060d54428d..33205d4cf1d 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -527,6 +527,9 @@ int board_late_init(void)
>         usb_ether_init();
>  #endif
>
> +       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> +               configure_capsule_updates();
> +
>         multiboot = multi_boot();
>         if (multiboot >= 0)
>                 env_set_hex("multiboot", multiboot);
> @@ -632,8 +635,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
>  }
>  #endif
>
> -#if defined(CONFIG_SET_DFU_ALT_INFO)
> -
>  #define DFU_ALT_BUF_LEN                SZ_1K
>
>  static void mtd_found_part(u32 *base, u32 *size)
> @@ -661,15 +662,12 @@ static void mtd_found_part(u32 *base, u32 *size)
>         }
>  }
>
> -void set_dfu_alt_info(char *interface, char *devstr)
> +void configure_capsule_updates(void)
>  {
>         int multiboot, bootseq = 0, len = 0;
>
>         ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
>
> -       if (env_get("dfu_alt_info"))
> -               return;
> -
>         memset(buf, 0, sizeof(buf));
>
>         multiboot = multi_boot();
> @@ -733,12 +731,9 @@ void set_dfu_alt_info(char *interface, char *devstr)
>                 return;
>         }
>
> -       env_set("dfu_alt_info", buf);
> -       puts("DFU alt info setting: done\n");
>         update_info.dfu_string = strdup(buf);
>         debug("Capsule DFU: %s\n", update_info.dfu_string);
>  }
> -#endif
>
>  #if defined(CONFIG_SPL_SPI_LOAD)
>  unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index d4f6b56afaa..1be11aed901 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -304,7 +304,6 @@ config EFI_CAPSULE_FIRMWARE_FIT
>         depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT
>         select UPDATE_FIT
>         select DFU
> -       select SET_DFU_ALT_INFO
>         select EFI_CAPSULE_FIRMWARE
>         help
>           Select this option if you want to enable firmware management protocol
> @@ -316,7 +315,6 @@ config EFI_CAPSULE_FIRMWARE_RAW
>         depends on SANDBOX || (!SANDBOX && !EFI_CAPSULE_FIRMWARE_FIT)
>         select DFU_WRITE_ALT
>         select DFU
> -       select SET_DFU_ALT_INFO
>         select EFI_CAPSULE_FIRMWARE
>         help
>           Select this option if you want to enable firmware management protocol
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 1a1cf3b55e1..3286c21a2b7 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -56,11 +56,6 @@ struct fmp_state {
>         u32 last_attempt_status; /* not used */
>  };
>
> -__weak void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -       env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -
>  /**
>   * efi_firmware_get_image_type_id - get image_type_id
>   * @image_index:       image index
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
