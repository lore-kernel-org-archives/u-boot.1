Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBB3C3ABD1
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 10:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1276F8857C;
	Mon, 16 Sep 2024 12:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T35iEyjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B1B8857C; Mon, 16 Sep 2024 12:02:36 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0286D8857C
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 12:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d86f713557so2785984a91.2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726480921; x=1727085721; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FUNCq/Bym/5pya1wBmlxBtW7izxYsMhCT+/QGvBsK0Y=;
 b=T35iEyjUxTFEEZR+vszg7KE4AVakcNFbBXaMTg6VSRTVJ4vWlkjpGVkSUFiST9b4tA
 dnfiBlD9ljcqkH9JNMrLe+/F+sl8BZkWfTbo3fPWn+eju7tEiC2zFAPS8Rk4svruGgO1
 RyGWo9InwK1U7wR/Yq7gKmzyl+viNSxULGz5ay0SwJGMjZBXboSC13Z2/2Msm4Xyfler
 yQdnuq1qE3H0ZHjdIelbl7l+fw2qwvGp26aZhBEN59GAcftyF6UlXBiJfUwAALhD2iGd
 9i0Fg8dWHB+CzI90O4VZrHVNf2/TAZgVRJljoyUkadE9L8IDSr09GEnLfvcC8csy88qn
 xe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726480921; x=1727085721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FUNCq/Bym/5pya1wBmlxBtW7izxYsMhCT+/QGvBsK0Y=;
 b=KdKw3TooZNNho3hdzqnuXTOGBaM+XnvozyM/nuIm6i0AEKFo+bQJZDyzJdoTAekisb
 8lStJfiyD8KvqLVzbD9HSzAF60W8BluMcl1GVcO23FSu/zEDAZCzdPhmL2LIMsMy3R77
 kDBKNJIUGu/Jj4Hvm87mHe6EKSUs5MsjEsVLb4GokRB8OHiBbIc1C+1GcTtFU/duLkXN
 QgRoblLBm0eaMpvpyzXiqQbLMMHg/5zVitHOjoHGSUzDSb/T87gpc3rmEKGsmWj3w2lK
 Qh5kOBS41hTk9aYOJSN6WLo0HM3NB0eoFFSf7Rz/xI4fuuz1vK/l6QyyiDI4RQ+M1Gcz
 ouGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAdT0a599Uap+nVMLDFE8LYKB6jUxme4XVzM3judC53x69Dl5AVhvzTKy1Fl1OOWcSO6NQImg=@lists.denx.de
X-Gm-Message-State: AOJu0YzHTIlGXmjZGxmi8kEkjOY82mSdfIBiLiHpgmQqy9Gkgc94D83s
 z+YEPtw9gwwaK9Dt2LSgkD3mXx9YExWE0PXuZyrcSRVxWkbRNySaWKuYrOzQETSINqgKbfsnYYJ
 CS4UU2fM2sr5zXEPz9WcgVCF5dbnLo/TrwhFX4IwzWyvNlxcfNIM=
X-Google-Smtp-Source: AGHT+IFI/NIjPOYkJHDsBH99WqZFOUC66wqvtzLeCntW55cBlLranQhWHIKOYkB2a3CZLqO8kEeFrVrg8on1XnysCv4=
X-Received: by 2002:a17:90a:890d:b0:2cb:50fa:b01e with SMTP id
 98e67ed59e1d1-2dba0093514mr15158197a91.41.1726480921169; Mon, 16 Sep 2024
 03:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
 <20240916-u-boot-topic-dynamic-uuid-v1-2-7e4f48542a0f@linaro.org>
In-Reply-To: <20240916-u-boot-topic-dynamic-uuid-v1-2-7e4f48542a0f@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Sep 2024 13:01:25 +0300
Message-ID: <CAC_iWjLY3V=CGFDzXv38r0_oZjhMC5T=hzxHNDCEbULw0Q_FuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] board: libre-computer: aml-s805-cc: Enable capsule
 updates
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de, Da Xue <da@libre.computer>
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

Thanks Neil!

On Mon, 16 Sept 2024 at 12:41, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Since the aml-s805-cc works well using EFI, and now the capsule updates
> backend has been merged, let's enable the missing configs and add
> the required structures to support it.
>
> The GUID is dynamically generated for the board, to get it:
> => efidebug capsule esrt
> ========================================
> ESRT: fw_resource_count=1
> ESRT: fw_resource_count_max=1
> ESRT: fw_resource_version=1
> [entry 0]==============================
> ESRT: fw_class=B8079027-9B2C-57D4-86AA-CC782ADA598C
> ESRT: fw_type=unknown
> ESRT: fw_version=0
> ESRT: lowest_supported_fw_version=0
> ESRT: capsule_flags=0
> ESRT: last_attempt_version=0
> ESRT: last_attempt_status=success
> ========================================
>
> On the host (with the aml_encrypt_gxl result binary):
> $ eficapsule --guid B8079027-9B2C-57D4-86AA-CC782ADA598C -i 1 u-boot.bin u-boot.cap
>
> On the board (from USB disk containing u-boot.cap at root):
> => load usb 0:1 $kernel_addr_r u-boot.cap
> => efidebug capsule update $kernel_addr_r
>
> The binary will then be flashed on the SPI.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 14 ++++++++++++++
>  configs/libretech-ac_defconfig                   |  5 +++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> index ae9834c0bf8..ba14df54967 100644
> --- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> +++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> @@ -8,6 +8,7 @@
>  #include <env.h>
>  #include <init.h>
>  #include <net.h>
> +#include <efi_loader.h>
>  #include <asm/io.h>
>  #include <asm/arch/gx.h>
>  #include <asm/arch/sm.h>
> @@ -19,6 +20,19 @@
>  #define EFUSE_MAC_OFFSET       52
>  #define EFUSE_MAC_SIZE         6
>
> +struct efi_fw_image fw_images[] = {
> +       {
> +               .fw_name = u"AML_S805X_AC_BOOT",
> +               .image_index = 1,
> +       },
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +       .dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
> +       .num_images = ARRAY_SIZE(fw_images),
> +       .images = fw_images,
> +};
> +
>  int misc_init_r(void)
>  {
>         u8 mac_addr[EFUSE_MAC_SIZE + 1];
> diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
> index 11d9795e05d..f146a495654 100644
> --- a/configs/libretech-ac_defconfig
> +++ b/configs/libretech-ac_defconfig
> @@ -35,6 +35,7 @@ CONFIG_SYS_MAXARGS=32
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_ADC=y
>  CONFIG_CMD_DFU=y
> +CONFIG_CMD_NVEDIT_EFI=y
>  CONFIG_CMD_GPIO=y
>  # CONFIG_CMD_LOADS is not set
>  CONFIG_CMD_MMC=y
> @@ -42,6 +43,7 @@ CONFIG_CMD_SF_TEST=y
>  CONFIG_CMD_SPI=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_CMD_EFIDEBUG=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_OF_CONTROL=y
> @@ -49,6 +51,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_SARADC_MESON=y
>  CONFIG_DFU_RAM=y
> +CONFIG_DFU_SF=y
>  CONFIG_MMC_MESON_GX=y
>  CONFIG_MTD=y
>  CONFIG_DM_MTD=y
> @@ -98,3 +101,5 @@ CONFIG_VIDEO_BMP_RLE8=y
>  CONFIG_BMP_16BPP=y
>  CONFIG_BMP_24BPP=y
>  CONFIG_BMP_32BPP=y
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
