Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42571C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 11:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D5C8798D;
	Wed, 27 Dec 2023 12:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WYt3FMO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F33138798D; Wed, 27 Dec 2023 12:16:28 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BD6887837
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 12:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50e7e55c0f6so1505145e87.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 03:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703675786; x=1704280586; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dPYlyzfv9pXcUeJSYn/K4JXmBbCbS4sN/9goKGWEo7Y=;
 b=WYt3FMO6OtVUWQ6GjEC0PRXuaXe3sQQllnnD2BdYPSKJ0+B9kh6MaEoDH+CqQD0+ao
 tRkp+Ngz5F9DnHte5bW51wZePHspDjYEQqY4ZkYDAnGI21aA1FGxmasOOj5jRL6m3Dwg
 U/ZbTn4E1hPW3RZuX/mQRC5wtsX0vXHUT30OSroOJFGlyCSCXOl/roRzlcG48w9tHlCT
 d4yNqvIVDG0b62or9jYZzI2QA7EpQEjbtlLeZ4+xzhfXmTwaQMQGd2iOTQYsAHHLMYZB
 Kq8F0zGoHR6MX77OTlnPrBitezoIlPVdR1TqAzE7S6rbyiqSBZbeBnK0dodZ3EltxQBb
 i6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703675786; x=1704280586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dPYlyzfv9pXcUeJSYn/K4JXmBbCbS4sN/9goKGWEo7Y=;
 b=B4kd6pNp140bmc+dsKOstv6ybzvL4qfezTPWwnvIJJQGtrVSVzbM5jtM7p69uGpg7x
 j7bO3OlsquplxTMCfLx7gGFgy6OfWmNFHXl3kv+Y1c5V6PAR7m6KNExP6r9h4r19BdFx
 DXnONAyjWr+mFoqiQx1vLG0jJausC+7VBQn9Q/a+OC2tC7ujoxxny0f24+JG4AUuylKC
 Qs5KwpBY34IX0fC7w2TEGXomm+P2EdoNIsX+dMValaHXiDtoNduv9Yy/Fcno30jejsmC
 5zT6xTKSylX2sC/JsrJ8gYPehnzkcC1LSKgIPTwWGK1x3evtyF9XUDwoF4+8YcahNrf8
 VWVw==
X-Gm-Message-State: AOJu0YwD4RDKtTX00FrA20MmTwYfF43/KoUNNLx5KhFSqTcS27in1w7i
 58O1nO5xKSOCSHMX/dKdqp9oXvd9Gq6kG0nAylS7z276HYLsvQ==
X-Google-Smtp-Source: AGHT+IG9xcjK1UwOj4uOnT+E9Y612B7N9Yk4pt+ulPWCznYazNHIsbW/GYlW9BPPsUsJLFkP2IiHB2OkV8B06aW2nXU=
X-Received: by 2002:a05:6512:419:b0:50e:66c1:f886 with SMTP id
 u25-20020a056512041900b0050e66c1f886mr1492687lfk.148.1703675786329; Wed, 27
 Dec 2023 03:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-7-sjg@chromium.org>
In-Reply-To: <20231227074025.2178825-7-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 13:15:50 +0200
Message-ID: <CAC_iWj+fbTJHrF_N0FJDA2jGaDvg-=2jYyLZw+=Rdt5DK+T9CQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] efi: Use the correct GUID for the SMBIOS table
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
>
> EFI does not use the 'anchor string' to determine the SMBIOS table
> version, instead preferring to have two separate GUIDs. Use the correct
> one, depending on the table version.
>
> Call unmap_system() to balance to the use of map_sysmem()
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add a note about why unmap_system() is called
>
>  include/efi_api.h           |  4 ++++
>  lib/efi_loader/efi_smbios.c | 12 ++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 0e92cb8a7f6..ab40b1b5ddf 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -433,6 +433,10 @@ struct efi_runtime_services {
>         EFI_GUID(0xeb9d2d31, 0x2d88, 0x11d3,  \
>                  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>
> +#define SMBIOS3_TABLE_GUID \
> +       EFI_GUID(0xf2fd1544, 0x9794, 0x4a2c, \
> +                0x99, 0x2e, 0xe5, 0xbb, 0xcf, 0x20, 0xe3, 0x94)
> +
>  #define EFI_LOAD_FILE_PROTOCOL_GUID \
>         EFI_GUID(0x56ec3091, 0x954c, 0x11d2, \
>                  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 49adc87e45a..5cbce6dc4eb 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -14,6 +14,8 @@
>  #include <smbios.h>
>  #include <linux/sizes.h>
>
> +const efi_guid_t smbios3_guid = SMBIOS3_TABLE_GUID;
> +
>  enum {
>         TABLE_SIZE      = SZ_4K,
>  };
> @@ -25,8 +27,10 @@ enum {
>   */
>  efi_status_t efi_smbios_register(void)
>  {
> +       const efi_guid_t *guid;
>         ulong addr;
>         efi_status_t ret;
> +       void *buf;
>
>         addr = gd_smbios_start();
>         if (!addr) {
> @@ -42,8 +46,12 @@ efi_status_t efi_smbios_register(void)
>         log_debug("EFI using SMBIOS tables at %lx\n", addr);
>
>         /* Install SMBIOS information as configuration table */
> -       return efi_install_configuration_table(&smbios_guid,
> -                                              map_sysmem(addr, 0));
> +       buf = map_sysmem(addr, 0);
> +       guid = !memcmp(buf, "_SM_", 4) ? &smbios_guid : &smbios3_guid;
> +       ret = efi_install_configuration_table(guid, buf);
> +       unmap_sysmem(buf);
> +
> +       return ret;
>  }
>
>  static int install_smbios_table(void)
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
