Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C02C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 06:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 884E687D57;
	Fri, 24 May 2024 08:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z6MJ4P4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318228863C; Fri, 24 May 2024 08:14:19 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F26DC8785E
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 08:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2bdb57f496eso1697136a91.2
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 23:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716531255; x=1717136055; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gm9cdofK/K14oQjOK/g6F1DWrBgaO7nHkvqhjlW38Bo=;
 b=Z6MJ4P4XiCGr2CQrGOzV8AA6GXHgcT077pUCDWuygqR6zw986evfsLl88XzJhijK0O
 ZL0f41nzei6/iJ1SgVQnPOyhc7EHYQueIYTnV6U6fdZ7N6un+ktMP6iXVs6oXU6k+QGx
 SCO8tA1lJqZIV3OWB1B9gJ9/OTU9VxPu8HLjkSRI2MdArxMCT7Opr7x7nUQdlaoM+WA4
 wbTq7uA5IClh/aQ5lYztJBoyRgwuH0KFjl4usMxv79U1awBChBeQBR9Kdfo+vLCdgCGP
 YcM8sJEtq7SECxW4aZ1bPdKdIswT3cc+TpSO5Hq8vuSzrVJp5PeHBSbEctG/e5AwjSsN
 llgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716531255; x=1717136055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gm9cdofK/K14oQjOK/g6F1DWrBgaO7nHkvqhjlW38Bo=;
 b=UAS94aAZKIDQUAQmAQDW+XK/jEU8gaQNX05iZtuuMx3FrrgFnGTxHcY8ciw6iv+cHw
 sVfSj4j9eGAq/k7hPHOpNYj+Pq20eHS1gnZAlBFfbTEE4MS7aK0Q//JLe4ahCf8f2jnC
 Gl6L6u5bS43j3M3QlEjaYku771l+7Ecdlwz+Lelmi7Sd2xug9SkYF58QDrrgUFv8/9yp
 1/kAHX8np9vQi4KSemKws+3d+s2ZK411Zh5g1eyVPposFsAh3sCkRN9TeRz5b7NPMwC0
 /OQQbdb78bdT/eWgiY26sHWGRleW2poCRb8sptJk8Ta3jUtqb3BojnSdX86mx+Jo7880
 CiEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuW+iNT/0BpQCbEi7bFMEU2AV9+icFwiCj35Brhr5DZFELqZolctTuDnO/vDm1sgkPftpFccv6oO6xiaKKza8NloRBzg==
X-Gm-Message-State: AOJu0YzwwSSdavDOEvD2lwRV2Lm1SvsB3fFK7r+moFs9nPJ5FR2KjVRv
 Zo5Cm+iOkATGqicMlZ65CjZRZdSHu4HDNtCxSs39adXxT1Ip7rxEpTP+7JpwrIeblKNIGBKG3+j
 PG1g0AjLhRIZAtyeXmu1AExuu0OP7oZoSjTtWEQ==
X-Google-Smtp-Source: AGHT+IHUTfrTaEt/iUzb3eQ6womTa7s7UHmsp3eBfpf5oEEOUjP4PrZNMWx67oApRrmzbsXPX8KChfX+vdvGpqFJgn8=
X-Received: by 2002:a17:90a:ec03:b0:2bd:e917:ffd9 with SMTP id
 98e67ed59e1d1-2bf5e84a944mr1536307a91.2.1716531255503; Thu, 23 May 2024
 23:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
 <20240426-b4-dynamic-uuid-v1-4-e8154e00ec44@linaro.org>
In-Reply-To: <20240426-b4-dynamic-uuid-v1-4-e8154e00ec44@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 May 2024 09:13:39 +0300
Message-ID: <CAC_iWjL+6Czavcs5G4T=AGpoqvgN42s7AeabTSSrC3gYNbc59A@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] sandbox: switch to dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 26 Apr 2024 at 17:19, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Migrate sandbox over to generating it's capsule update image GUIDs
> dynamically rather than using a set of hardcoded ones.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/Kconfig            |  1 +
>  board/sandbox/sandbox.c | 28 +++++++++++++++-------------
>  2 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index abd406d48841..0558c90540b6 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -164,8 +164,9 @@ config SANDBOX
>         select SYS_CACHE_SHIFT_4
>         select IRQ
>         select SUPPORT_EXTENSION_SCAN if CMDLINE
>         select SUPPORT_ACPI
> +       select EFI_CAPSULE_DYNAMIC_UUIDS if EFI_HAVE_CAPSULE_SUPPORT
>         imply BITREVERSE
>         select BLOBLIST
>         imply LTO
>         imply CMD_DM
> diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
> index 802596569c64..68a99ce1fc07 100644
> --- a/board/sandbox/sandbox.c
> +++ b/board/sandbox/sandbox.c
> @@ -31,36 +31,24 @@
>   */
>  gd_t *gd;
>
>  #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
> -/* GUIDs for capsule updatable firmware images */
> -#define SANDBOX_UBOOT_IMAGE_GUID \
> +#define SANDBOX_CAPSULE_UPDATE_SALT \
>         EFI_GUID(0x09d7cf52, 0x0720, 0x4710, 0x91, 0xd1, \
>                  0x08, 0x46, 0x9b, 0x7f, 0xe9, 0xc8)
>
> -#define SANDBOX_UBOOT_ENV_IMAGE_GUID \
> -       EFI_GUID(0x5a7021f5, 0xfef2, 0x48b4, 0xaa, 0xba, \
> -                0x83, 0x2e, 0x77, 0x74, 0x18, 0xc0)
> -
> -#define SANDBOX_FIT_IMAGE_GUID \
> -       EFI_GUID(0x3673b45d, 0x6a7c, 0x46f3, 0x9e, 0x60, \
> -                0xad, 0xab, 0xb0, 0x3f, 0x79, 0x37)
> -
>  struct efi_fw_image fw_images[] = {
>  #if defined(CONFIG_EFI_CAPSULE_FIRMWARE_RAW)
>         {
> -               .image_type_id = SANDBOX_UBOOT_IMAGE_GUID,
>                 .fw_name = u"SANDBOX-UBOOT",
>                 .image_index = 1,
>         },
>         {
> -               .image_type_id = SANDBOX_UBOOT_ENV_IMAGE_GUID,
>                 .fw_name = u"SANDBOX-UBOOT-ENV",
>                 .image_index = 2,
>         },
>  #elif defined(CONFIG_EFI_CAPSULE_FIRMWARE_FIT)
>         {
> -               .image_type_id = SANDBOX_FIT_IMAGE_GUID,
>                 .fw_name = u"SANDBOX-FIT",
>                 .image_index = 1,
>         },
>  #endif
> @@ -122,8 +110,22 @@ int dram_init(void)
>  }
>
>  int board_init(void)
>  {
> +       int ret;
> +
> +       if (CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)) {
> +               efi_guid_t salt_guid = SANDBOX_CAPSULE_UPDATE_SALT;
> +
> +               ret = efi_capsule_update_info_gen_ids(&salt_guid,
> +                                             "sandbox",
> +                                             ofnode_read_string(ofnode_root(), "model"),
> +                                             ofnode_read_string(ofnode_root(), "compatible"));
> +               if (ret) {
> +                       printf("Failed to generate GUIDs: %d\n", ret);
> +                       return ret;
> +               }
> +       }
>         return 0;
>  }
>
>  int ft_board_setup(void *fdt, struct bd_info *bd)
>
> --
> 2.44.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
