Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F168C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 11:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756A187C37;
	Wed, 24 Jan 2024 12:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EudfTCWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 044B787C37; Wed, 24 Jan 2024 12:25:21 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B62218786C
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 12:25:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55817a12ad8so6045450a12.2
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 03:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706095514; x=1706700314; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tu5C0VVE7ea2RWIVKdjLka0E4Tw1KGDZHn5sRxkMCR8=;
 b=EudfTCWKlqDqzjSdEUborQEnWQujIUM7eVGQEbm461FjgxmMoN/fNmh7mdYj9Cg1X/
 C12hM0E7YMDTLOwdMQgTb94diOXpLG/DJ4spAO0dNLPslDtu8Qb3pxQsdQa9XSw2x/CG
 GXqKtixuNnQw/uKFfrTKjNnfR9uYxxZ0OlN0AdZ0fnl8jYOgOB1z8/8wfkgbqSRPsjl/
 iOirDO1cg7TSOh0DGj6gmVOBLbNCj5YzNMuo4rbrBVLv/qQhBDTFPbPOABIwF21yo+Oj
 8f4mcfpTdbdMT/iuVjl5QOVb2AwIOZXU7PxAaW1IwldPAwcHbhL4QXPg5fLnwokEtu45
 8msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706095514; x=1706700314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tu5C0VVE7ea2RWIVKdjLka0E4Tw1KGDZHn5sRxkMCR8=;
 b=wyGaWAbDB0GFd0wmnntayOcC+1dgribXjDt+28twwX0iuQCpfsO/ATRQ8pIcHXEAre
 gsRBDD4nT7C/4BmIrAblSziZkFgRubTXFXlKWJcKgieKfadXzbmLKZXjsSCtdKuCgM8z
 +mL5n7TOfPDyQ3PXTuWtik+Y9MeAdZI8mWnMuKtJOgai0+8OW2j3QMN3tlfVf3k0HCft
 1eKJL9OA9mY1bBj5BiIwK6Ei5w8L1qGq3G4d4kPFchZm89dbdNA1onmkXhnHufUelYNm
 COcpBttuam8CtrGVo94WKVysbaxhzovi3WedQgyUGzh/QVjFygI3f6o2iSfxC2exs0p1
 06KA==
X-Gm-Message-State: AOJu0YxUJ6PbjbLS3HX1Wsw2vKpWTUt6PO4tuUxZKiJQyoth7tygvfix
 HP3608+A8JkXvwxvXyyMHd3J3QR5K6dRbHwK3m42SAwOmBayEt1sMVE1b3r05pw=
X-Google-Smtp-Source: AGHT+IH/NLoqmp2/Sv5ti3fxP51Fga9E1FwUPxFotML/BHO0dkoTb02IxY9WV1FnvM2mA67tNJINBg==
X-Received: by 2002:a17:906:b88a:b0:a27:7075:7613 with SMTP id
 hb10-20020a170906b88a00b00a2770757613mr632828ejb.67.1706095513985; 
 Wed, 24 Jan 2024 03:25:13 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 tl7-20020a170907c30700b00a310a3548dasm744504ejc.177.2024.01.24.03.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 03:25:13 -0800 (PST)
Date: Wed, 24 Jan 2024 13:25:11 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH 01/18] configs: fwu: Remove FWU configs for metadata V2
 migration
Message-ID: <ZbDzl9Jcg4cbHpp6@hera>
References: <20240122115439.653871-1-sughosh.ganu@linaro.org>
 <20240122115439.653871-2-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122115439.653871-2-sughosh.ganu@linaro.org>
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

On Mon, Jan 22, 2024 at 05:24:22PM +0530, Sughosh Ganu wrote:
> The FWU metadata is to be migrated to version 2. Disable the FWU
> feature on platforms that enable it for the migration.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  configs/corstone1000_defconfig           | 2 --
>  configs/sandbox64_defconfig              | 1 -
>  configs/synquacer_developerbox_defconfig | 4 ----
>  3 files changed, 7 deletions(-)
>
> diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
> index e45415b90c..24b7984959 100644
> --- a/configs/corstone1000_defconfig
> +++ b/configs/corstone1000_defconfig
> @@ -25,7 +25,6 @@ CONFIG_BOARD_LATE_INIT=y
>  CONFIG_SYS_PROMPT="corstone1000# "
>  CONFIG_SYS_MAXARGS=64
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
> index 996bb7aa4f..7b5888af38 100644
> --- a/configs/sandbox64_defconfig
> +++ b/configs/sandbox64_defconfig
> @@ -274,7 +274,6 @@ CONFIG_EFI_CAPSULE_ON_DISK=y
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

