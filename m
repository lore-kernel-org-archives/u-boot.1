Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09825C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8176D881C7;
	Fri, 22 Mar 2024 12:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V5XQcgTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71EF1881C9; Fri, 22 Mar 2024 12:41:37 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F25B587B82
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d4886a1cb4so27353061fa.0
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711107694; x=1711712494; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gUOGi7KIZOBF/veAZVf6YXkDFe19hHGBz0hzmc5vW9s=;
 b=V5XQcgTUhcu+Dr+qinM4s1F50J2eRTahc8xutQkoKjdS+qLdbUDCm59a5gWUanSFXR
 gm9U2mF/1XZ8AEsnnnWfHLlbD9bzByjF2NxUoBij/Dtz3SyTH1WydHZzdYzrabAVeuW8
 nEPrfuS+lAMc+Apfslj5QUq8OqLDISpTNiqUiGWwDSFtYuhkwp/PthmCgYXFYiwOQaeU
 lgS0QC23kAmInjjEbWL0Zmbpbsr8e2QVrwpgt9MFJXB9MFFbvXDekXYf0NUFRfqRcZmy
 q44AsfLkHoA6GK/RL7kk3iCAZBNSYkNDZfcl5SohqCQxBf4vHXgK6IruT6wyGIxl2a5c
 DLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711107694; x=1711712494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gUOGi7KIZOBF/veAZVf6YXkDFe19hHGBz0hzmc5vW9s=;
 b=rmIXhqu3xuWfKa4EoxJgYWazbpuxEZS38rwT5Im5zJLDECSSb2oMGiTDEnMXvUuXkj
 pMWDJrkwUInSBO2o4U+iauOCXaYwogojf6aY2PWe4tvakVg9VY1Q3bhpHZ2Ct/9dYLG7
 mf8lyk/7+Ll4Se4VdEeZu7fCGsbw07xQuZsz+McvCv+xVwc+Dsc9IvLkB+Uj2CIpJCWh
 mwyb0GQc6Iu6phwH2gtzBiJ7QQC4+26dlnrrRyQy9R4yo01NeM91qzUEGIi9J9Uvw2qy
 0LsV/wiIyOJ0gK0pyJqlI+qxqqCnKSwyKRZtMY03fX57KALA7lBLrZxjwyck+T3kL9uI
 /W+w==
X-Gm-Message-State: AOJu0YxuLKkdJIIQ9nj8abXrnmUs8/DKCrXkur6I+ERo4cJ2px3TySws
 KavWn6eMsUW90734+m55lSaUEykLDuV0MjBs8C1PhAhhTWmLBK1tcaa4EvNBXf//XlOeKNVgnV6
 y9/iS46UwEg0c/1LzHBGAxYVyfO577giK2pk10Q==
X-Google-Smtp-Source: AGHT+IFKogZkcLAOTEFqFrYDIsKXo72RQlDeDRjVeyo/CyaAM/J8ani2na2AcqC/cNSA9wXFPrY+3ZCd2c7uVgJ4GsY=
X-Received: by 2002:a05:651c:214:b0:2d5:7798:4efc with SMTP id
 y20-20020a05651c021400b002d577984efcmr1632658ljn.9.1711107693937; Fri, 22 Mar
 2024 04:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
 <20240322105733.203888-2-sughosh.ganu@linaro.org>
In-Reply-To: <20240322105733.203888-2-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Mar 2024 13:40:57 +0200
Message-ID: <CAC_iWjJYH4Az-1_T6=qTFRA5yAUZvsZWqc6k7yusmdg5FvrrNg@mail.gmail.com>
Subject: Re: [PATCH v3 01/20] configs: fwu: remove FWU configs for metadata V2
 support
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>
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

On Fri, 22 Mar 2024 at 12:58, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Support is to be added in the following commits for the FWU metadata
> version 2. Disable the FWU feature on platforms that enable it for the
> V2 addition work.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: None
>
>  configs/corstone1000_defconfig           | 2 --
>  configs/sandbox64_defconfig              | 1 -
>  configs/synquacer_developerbox_defconfig | 4 ----
>  3 files changed, 7 deletions(-)
>
> diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
> index 8b2f77f648..29d7550afb 100644
> --- a/configs/corstone1000_defconfig
> +++ b/configs/corstone1000_defconfig
> @@ -24,7 +24,6 @@ CONFIG_LOGLEVEL=7
>  CONFIG_BOARD_LATE_INIT=y
>  CONFIG_SYS_PROMPT="corstone1000# "
>  # CONFIG_CMD_CONSOLE is not set
> -CONFIG_CMD_FWU_METADATA=y
>  CONFIG_CMD_BOOTZ=y
>  # CONFIG_CMD_XIMG is not set
>  CONFIG_CMD_GPT=y
> @@ -67,4 +66,3 @@ CONFIG_FFA_SHARED_MM_BUF_OFFSET=0
>  CONFIG_FFA_SHARED_MM_BUF_ADDR=0x02000000
>  CONFIG_EFI_CAPSULE_ON_DISK=y
>  CONFIG_EFI_IGNORE_OSINDICATIONS=y
> -CONFIG_FWU_MULTI_BANK_UPDATE=y
> diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
> index 3be9a00a85..7e8200e70c 100644
> --- a/configs/sandbox64_defconfig
> +++ b/configs/sandbox64_defconfig
> @@ -272,7 +272,6 @@ CONFIG_EFI_CAPSULE_ON_DISK=y
>  CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>  CONFIG_EFI_SECURE_BOOT=y
>  CONFIG_TEST_FDTDEC=y
> -CONFIG_FWU_MULTI_BANK_UPDATE=y
>  CONFIG_UNIT_TEST=y
>  CONFIG_UT_TIME=y
>  CONFIG_UT_DM=y
> diff --git a/configs/synquacer_developerbox_defconfig b/configs/synquacer_developerbox_defconfig
> index 2a0407de40..616d410074 100644
> --- a/configs/synquacer_developerbox_defconfig
> +++ b/configs/synquacer_developerbox_defconfig
> @@ -11,14 +11,12 @@ CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="synquacer-sc2a11-developerbox"
>  CONFIG_SYS_LOAD_ADDR=0x80000000
>  CONFIG_TARGET_DEVELOPERBOX=y
> -CONFIG_FWU_NUM_IMAGES_PER_BANK=1
>  CONFIG_AHCI=y
>  CONFIG_FIT=y
>  CONFIG_SYS_BOOTM_LEN=0x800000
>  CONFIG_BOOTSTAGE_STASH_SIZE=4096
>  CONFIG_HUSH_PARSER=y
>  CONFIG_SYS_MAXARGS=128
> -CONFIG_CMD_FWU_METADATA=y
>  CONFIG_CMD_IMLS=y
>  CONFIG_CMD_ERASEENV=y
>  CONFIG_CMD_NVEDIT_EFI=y
> @@ -53,7 +51,6 @@ CONFIG_DFU_TFTP=y
>  CONFIG_DFU_MTD=y
>  CONFIG_DFU_RAM=y
>  CONFIG_DFU_SF=y
> -CONFIG_FWU_MDATA_MTD=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_SYNQUACER=y
>  CONFIG_MMC_SDHCI=y
> @@ -96,4 +93,3 @@ CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>  CONFIG_EFI_CAPSULE_ON_DISK=y
>  CONFIG_EFI_IGNORE_OSINDICATIONS=y
>  CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> -CONFIG_FWU_MULTI_BANK_UPDATE=y
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
