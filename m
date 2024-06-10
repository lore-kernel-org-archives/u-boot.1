Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94677C27C65
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE5487D43;
	Mon, 10 Jun 2024 11:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hVTMzGCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE97A87C40; Mon, 10 Jun 2024 11:32:40 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947F787D43
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f65a3abd01so38998315ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718011955; x=1718616755; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j6MFxTqVH7Sq9HWIsaL1VDd9DzGfLCralZ+/l7payzg=;
 b=hVTMzGCmx/HlWAKsUNK4k8tFrMt6yEwe41JZ5EO03jdvnZLOh4D/PuIpIFRqk3UUdn
 WG3BQuCCz7ojx79UgFeHpJTsolUtEfRBNuIDtPJFOjKF3bGNCiElMHIOdJwN9ILVwkf3
 xE3xdcHRNd2JWiQBF2VQGB/ZBzOQJU1Oh6K7m7Iz/CNWuXs0ouAJSIqT02ZGEkDjpRI3
 emcEHWSG32Ohe/ghTt7y1mUm92QDPOqPWhkjohGqEyD1zE75LnStegslUBMC9mytp1fu
 2rse3pbRy1sObq5mtOdE/moij3vtBk1Dy+wUNyRWZgdk59tL6ti8LP3Ekg4Ap62rWWiU
 Ll9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011955; x=1718616755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j6MFxTqVH7Sq9HWIsaL1VDd9DzGfLCralZ+/l7payzg=;
 b=NWSU6yNAb8bJvZnG6/0LKzknUILq5blRF96sAHEDgwnZ3F27APC89ANhZr+DoKQh7W
 D3S7kd2BhaMn31qKMFhunWc5R8vuCZ72om3EJFDS+bNXDg+xm5sbglNDoQXlnlOOmdFO
 sruXqwPgaWNhen++0NL8VzUIN13MPrYRc94RwubW9BMLn1ejOVrVLVA/my/0B3LNU7VB
 DKaC1YyOq668G5HuIdjPGE5Mrma4zdIrs3uw/XGkYnE3DYcC+r4OsNFZN2Hq8g0M2KNv
 mNXvxfpkLwHRVm3dKuZSDpP7qfonfx0u0SzOOn97U8BEZbZlvBrK5pc7vk5sE5SCINXE
 SuwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULLcDy7C6ywCFBgwS69BcCv1LgaWAhLLuldfDO5aTwXRlRV9d3yMsDr5H+bt8+FtvI1gdPvXE82v40nTo6e6OFJNlDag==
X-Gm-Message-State: AOJu0YwwFw0SIDJcn01rNG+f206H+lVum6N3TyjKFvMT8LHa3hFnlPY/
 IE/DNm9G1vQ97XCtJLyjglzqZqn0rPZbKGpmp7+QvYBR7ZmhwYeCh033Nrdp1xssNVpzAylwk0P
 JZiJ6luiCaL5UsUohMRqrGDdwIlkB8m1lbtXWoQ==
X-Google-Smtp-Source: AGHT+IFyerAf+RucB0f2A9mzDHu2TfBewKFY11MKFpJaDa4vlTdXCaWZSEFNs3TfS7/oytqbOVMlaEeZgsjoyBZ022c=
X-Received: by 2002:a17:902:e5ce:b0:1f6:f96c:2f20 with SMTP id
 d9443c01a7336-1f6f96c38ccmr47702105ad.36.1718011954923; Mon, 10 Jun 2024
 02:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
 <20240610091057.64463-10-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240610091057.64463-10-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 12:31:58 +0300
Message-ID: <CAC_iWjKjU6K3T_ZcUr3Z+xPin9YysBJE=YJ7crF2skPevGTckQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] efi_loader: rename struct efi_initrd_dp to
 efi_lo_dp_prefix
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Mon, 10 Jun 2024 at 12:11, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> As we now also store device-tree device-paths in load options rename
> struct efi_initrd_dp to efi_lo_dp_prefix.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         new patch
> ---
>  cmd/eficonfig.c                  |  4 ++--
>  cmd/efidebug.c                   |  4 ++--
>  include/efi_load_initrd.h        | 12 +++++++++++-
>  lib/efi_loader/efi_load_initrd.c |  2 +-
>  lib/efi_loader/initrddump.c      |  2 +-
>  5 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index a12df1e7d59..530eb931564 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -1402,7 +1402,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>         struct efi_device_path *initrd_device_dp = NULL;
>         struct efi_device_path *fdt_device_dp = NULL;
>
> -       const struct efi_initrd_dp initrd_prefix = {
> +       const struct efi_lo_dp_prefix initrd_prefix = {
>                 .vendor = {
>                         {
>                         DEVICE_PATH_TYPE_MEDIA_DEVICE,
> @@ -1418,7 +1418,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>                 }
>         };
>
> -       const struct efi_initrd_dp fdt_prefix = {
> +       const struct efi_lo_dp_prefix fdt_prefix = {
>                 .vendor = {
>                         {
>                         DEVICE_PATH_TYPE_MEDIA_DEVICE,
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index a25ebd2061d..846d6b67a48 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -685,7 +685,7 @@ struct efi_device_path *create_lo_dp_part(const char *dev, const char *part,
>         struct efi_device_path *dp = NULL;
>         const struct efi_device_path *dp_prefix;
>         efi_status_t ret;
> -       const struct efi_initrd_dp fdt_dp = {
> +       const struct efi_lo_dp_prefix fdt_dp = {
>                 .vendor = {
>                         {
>                         DEVICE_PATH_TYPE_MEDIA_DEVICE,
> @@ -700,7 +700,7 @@ struct efi_device_path *create_lo_dp_part(const char *dev, const char *part,
>                         sizeof(fdt_dp.end),
>                 }
>         };
> -       const struct efi_initrd_dp initrd_dp = {
> +       const struct efi_lo_dp_prefix initrd_dp = {
>                 .vendor = {
>                         {
>                         DEVICE_PATH_TYPE_MEDIA_DEVICE,
> diff --git a/include/efi_load_initrd.h b/include/efi_load_initrd.h
> index be5d5a7acbe..9feafb18c86 100644
> --- a/include/efi_load_initrd.h
> +++ b/include/efi_load_initrd.h
> @@ -18,7 +18,17 @@
>                  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
>  extern const efi_guid_t efi_lf2_initrd_guid;
>
> -struct efi_initrd_dp {
> +/**
> + * struct efi_lo_dp_prefix - separator device path used in load options
> + *
> + * We use vendor media device nodes in UEFI load options to separate
> + * the binary, initrd, and fdt device-paths. This structure contains
> + * the vendor media device node and an end node.
> + *
> + * @vendor:    vendor media device node
> + * @end:       end node
> + */
> +struct efi_lo_dp_prefix {
>         struct efi_device_path_vendor vendor;
>         struct efi_device_path end;
>  } __packed;
> diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
> index d91135436c4..2f0ee1ab4a1 100644
> --- a/lib/efi_loader/efi_load_initrd.c
> +++ b/lib/efi_loader/efi_load_initrd.c
> @@ -24,7 +24,7 @@ static const struct efi_load_file_protocol efi_lf2_protocol = {
>   * Device path defined by Linux to identify the handle providing the
>   * EFI_LOAD_FILE2_PROTOCOL used for loading the initial ramdisk.
>   */
> -static const struct efi_initrd_dp dp_lf2_handle = {
> +static const struct efi_lo_dp_prefix dp_lf2_handle = {
>         .vendor = {
>                 {
>                    DEVICE_PATH_TYPE_MEDIA_DEVICE,
> diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
> index 0004b6b042b..7f4ea6675a8 100644
> --- a/lib/efi_loader/initrddump.c
> +++ b/lib/efi_loader/initrddump.c
> @@ -33,7 +33,7 @@ static bool nocolor;
>   * Device path defined by Linux to identify the handle providing the
>   * EFI_LOAD_FILE2_PROTOCOL used for loading the initial ramdisk.
>   */
> -static const struct efi_initrd_dp initrd_dp = {
> +static const struct efi_lo_dp_prefix initrd_dp = {
>         .vendor = {
>                 {
>                    DEVICE_PATH_TYPE_MEDIA_DEVICE,
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
