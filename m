Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AED5C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 16:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88F39810EA;
	Thu,  3 Apr 2025 18:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GyxPSSOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B1D181CF0; Thu,  3 Apr 2025 18:47:35 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04820809A5
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 18:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e63504bedd0so902324276.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743698852; x=1744303652; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jet44ZJOW8cRn0vJwMQ9JboyUqvWM2ML+hC19ZB5G5A=;
 b=GyxPSSOxqtq9iXS/UzT8mxK0aZSPl0pRMJzlZF6/fKwbtANu6yzQYCKSFvYtYIaqXr
 ykSKCAGtvNLtBgWei+YdKMxu5o6St6eTPpkQHUQoPQ3uq+IXmhGrSd4Eb5j7N7hT8kQB
 AL6TgaFZlyH+bRaEXoFocNfbMXDW8A2ZdaYR7iF47pOFv5qJk0FIGldHXngc+c2mK35V
 BxoVtDfB4vRinjEFbF+vFSlR5IfMAf/3c2/XI+Dm3P59je2tr4kXkQHRAMU4vvYAy9+z
 34DBln5dUq4klzks5dhQJc9rwym2q8aYYnDpiLFxNwUkwhdRp4QWym4kzlXjFLvDBYbm
 7/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743698852; x=1744303652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jet44ZJOW8cRn0vJwMQ9JboyUqvWM2ML+hC19ZB5G5A=;
 b=tQXF6/CDkP8TB1GDHQf37q1aodjez5zgk9tKlOpfLqar0Ls6Tdfoe+FjeRTi/Dmx1p
 aQ0rEQztcS4iGiTFhA5ZUGTsERUxd/ZY5vNXbHN9WtLz94F78ImbpvxMfi37tT0Z3o3z
 P1FQhAgfVxcxfV2O/ZMsd3jaMqgsDzDrQ0SlW79FkDZEZzDRP/3jDKiTi+GI2QOPqwBc
 dMdO/HkDrM5RBAlL/UqAMQZn4gsmopYXULUEkfQQbDSVjRjQ4OPeLRuqI16EDQgAlGPN
 BSsOTIhm73erdtdPLXKP2O+UcZULtzvx8lkvGaiq1cR959wyKxXqJ5o4Okah8SABQMGp
 KEYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9B9/kQAwjePO4t8uDhVlGDoQSsYs0GFs0qv02jOh7J5oFZg9kDxmtitx08txUsX3b+04HBYY=@lists.denx.de
X-Gm-Message-State: AOJu0YxcTNsNaL89OZk5FvgENmh5XgauAA7JQse90BLjedB1fMOKKP+k
 XVXHiPBr4QmdxBy0Nkqx3P2a0ZnILjBfkY91zT0PC3n3Q1hSoQj9ebLLFVRbO05S9XM8tYEbHUz
 srMH5Zh/OuP2WHEamrCJCdoekkRMMboqiQIBosg==
X-Gm-Gg: ASbGncvXosDQtbLwpxsHBbZUaxiiSjc0kC1Kfe5xBrgbO5zVGKji2vFBqZ1TfXkC3vU
 s/ugscIclBKmvFM9Iuqq1Cf9o+krSrp4g/W9ItpRVDApm4x5UikOSgCD+gO7DchzSHTQc6INcEE
 SQggVjOtCLqjc/Jnjn9vBc866A
X-Google-Smtp-Source: AGHT+IGLlSHgm2s6LFzzf2DsFPNCiTis43ZyTiFgv4pwJZvmMFK7ctKZ04QPxK6Y4ubMhov90yK4YuQXCdZ0Q0AQ6PE=
X-Received: by 2002:a05:6902:2101:b0:e6b:8329:bf3c with SMTP id
 3f1490d57ef6-e6e1c48bb60mr387714276.45.1743698851753; Thu, 03 Apr 2025
 09:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250403-u-boot-fix-set-dfu-alt-info-interface-v1-1-1fdd12463186@linaro.org>
In-Reply-To: <20250403-u-boot-fix-set-dfu-alt-info-interface-v1-1-1fdd12463186@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Apr 2025 19:46:55 +0300
X-Gm-Features: AQ5f1JrWFGCPoNDuvTsf-GUeXCL-km5Hqn3JS7yWOOodntR8xVmyqB7k-8wma-I
Message-ID: <CAC_iWj+PVY3ynmGZ97iutp1d6NsBL606dgXmxRVEpXCACNW=3A@mail.gmail.com>
Subject: Re: [PATCH] board: libre-computer: check interface before comparing
 it in set_dfu_alt_info()
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Thu, 3 Apr 2025 at 19:03, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> When set_dfu_alt_info() is called, interface can be NULL when called for
> the EFI capsule, so check it before calling it with strcmp().
>
> Fixes: 12ea40d29dc ("ARM: meson: add support for Libre Computer aml-s905d3-cc")
> Fixes: 9e6e6b034b1 ("ARM: meson: add support for Libre Computer aml-a311d-cc")
> Fixes: 75c87c6cbc0 ("board: libre-computer: aml-s805x-cc: Enable capsule updates")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 2 +-
>  board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 2 +-
>  board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> index e45cfd5d8a3885683dd6b1d0eea03084dc6dfdb5..294f78858a7848fe8255c9b9b42e2f556a6e05d1 100644
> --- a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> +++ b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> @@ -29,7 +29,7 @@ struct efi_capsule_update_info update_info = {
>  #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
>  void set_dfu_alt_info(char *interface, char *devstr)
>  {
> -       if (strcmp(interface, "ram") == 0)
> +       if (interface && strcmp(interface, "ram") == 0)
>                 env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
>         else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
>                 env_set("dfu_alt_info", update_info.dfu_string);
> diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> index 94cf5b4361fac5003dded2f8dc2bfc9be7630099..1ec9a5b401e210045f1b13720f1e5c16e1f7f86b 100644
> --- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> +++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> @@ -36,7 +36,7 @@ struct efi_capsule_update_info update_info = {
>  #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
>  void set_dfu_alt_info(char *interface, char *devstr)
>  {
> -       if (strcmp(interface, "ram") == 0)
> +       if (interface && strcmp(interface, "ram") == 0)
>                 env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
>         else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
>                 env_set("dfu_alt_info", update_info.dfu_string);
> diff --git a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> index f641db5a494f358ed89591fae06e66eb18f85709..b552035ee03a7b848455ae6564688b4a12e02326 100644
> --- a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> +++ b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> @@ -29,7 +29,7 @@ struct efi_capsule_update_info update_info = {
>  #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
>  void set_dfu_alt_info(char *interface, char *devstr)
>  {
> -       if (strcmp(interface, "ram") == 0)
> +       if (interface && strcmp(interface, "ram") == 0)
>                 env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
>         else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
>                 env_set("dfu_alt_info", update_info.dfu_string);
>
> ---
> base-commit: f59fb9846c5a1d129f78b2945a094477388fd346
> change-id: 20250403-u-boot-fix-set-dfu-alt-info-interface-9be8ea5e2bc1
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
