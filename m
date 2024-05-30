Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF5CC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 14:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB5288705;
	Thu, 30 May 2024 16:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NKWir91M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8E88870F; Thu, 30 May 2024 16:57:25 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B3E886AE
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 16:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5b97539a4a5so510845eaf.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717081041; x=1717685841; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zcPLYmXi42fCTys+q3HEi32FcraCOzOgEtuYebheePQ=;
 b=NKWir91M6cAJ133l5CfbjIOA0xmJU3vF19SuruFx0Epo6zKnOefMyufti3IRhuvX+L
 YLYU+6sBDZvjHJdvNl9hilE+Wcks6oQha4mk9AKaR8hmqq3gxHiAY2eVkATj3GzQEz0J
 ShTMgowX7WqXYM7eqkAawu5OVbGp1SNbrDKYMPopC6FGNEQSLn/mp6DBy/FcsatHBaH3
 gpanEO6f9A+U4tCZ6+WrevrzjUnpcyAGIiA+CO4pPN88MdD8Se5eNWe0KZ4cSvOKeW0H
 509QSVbeSEPg7AcrAtWNlV8aQTnhgRWm4nYMN2KO1VIJVDkFUsqMRo3ffi94MGaRQEt0
 vWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717081041; x=1717685841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zcPLYmXi42fCTys+q3HEi32FcraCOzOgEtuYebheePQ=;
 b=msZXk0xJLV3xFSnR79UiEvs9IaRC+VnIf3rGMgOHrR+xJGx+BxIt0GBlKDZ2e6+X+H
 LSPC+2opv8bm+KzcatpFNdZVpXelj9yi1I5kHmd2AYx9eC4VmpcSIgNjyAScE66q68LM
 +nuIbRTcYVzsF3NWRsBuxi7pGLl9NjshzLrhvqGDg/SersSqVSmpbl8SuvanA7BUpmXg
 Y6SymBR3pRfU6FUA47OHL7G1D9zatcmzs0e7ZmtvYOuUk1TkO9LbVrFfpM0jmlitQoQt
 FTV0r+A7LcwFpJqzTlU8AQ+6fTtH1t38T6SvBmo6MURBiLGChZXFaTj9nbcMKLVaCPiJ
 Snmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM6PpuEsWtzfHKuIu1KASfY0JnIKpaGMqogSCqyZmFUxrpKd7UySLeY9DHEgXY0Xxb74+xx/Hg5JzD50uV5KOWzdQ7FA==
X-Gm-Message-State: AOJu0Yw1RzOlzBCZ+UBYx/vEF6brW+ZfGFh5Rfjwn1YKPWGnHvCP+EjA
 UKqJCLM4EssNLO3TZ8A0W1KPHNcYY+Pk/Vv0uRbuVyaFXw7OCa0ApKyFngq1h8Zmog4qMeA+mGU
 n/HVD6AaYmG0TUnSUIdRoggANSsqQHqjbLZilosBTLXcKbpV0CR0=
X-Google-Smtp-Source: AGHT+IGIhz/Z6AYHu9OeIBnd4sz6AUAH3IRkRoUpFP4t3n4DoltCwIDMMiKkFEzpkgq9PJQ3ZrqQ5e6WVUIF6UzaxNE=
X-Received: by 2002:a17:902:e746:b0:1f6:a43:89c3 with SMTP id
 d9443c01a7336-1f61a4d3a54mr27038195ad.57.1717081020568; Thu, 30 May 2024
 07:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-2-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-2-c26f31057bbe@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 May 2024 17:56:24 +0300
Message-ID: <CAC_iWjK_3ZFzeFN-Ej-OAhB8EDzkywy11j6dL3qNhAELz8r79g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] efi: add a helper to generate dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
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

Hi Caleb,

[...]

>
>  #include <crypto/pkcs7.h>
>  #include <crypto/pkcs7_parser.h>
>  #include <linux/err.h>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index ba5aba098c0f..a8dafe4f01a5 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -244,8 +244,71 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
>
>         free(var_state);
>  }
>
> +#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
> +/**
> + * efi_capsule_update_info_gen_ids - generate GUIDs for the images
> + *
> + * Generate the image_type_id for each image in the update_info.images array
> + * using the first compatible from the device tree and a salt
> + * UUID defined at build time.
> + *
> + * Returns:            status code
> + */
> +static efi_status_t efi_capsule_update_info_gen_ids(void)
> +{
> +       int ret, i;
> +       struct uuid namespace;
> +       const char *compatible; /* Full array including null bytes */
> +       struct efi_fw_image *fw_array;
> +
> +       fw_array = update_info.images;
> +       /* Check if we need to run (there are images and we didn't already generate their IDs) */
> +       if (!update_info.num_images ||
> +           memchr_inv(&fw_array[0].image_type_id, 0, sizeof(fw_array[0].image_type_id)))

Why not just go a guidcmp()? memchr_inv() will return the first
invalid match, but we don't need that

> +               return EFI_SUCCESS;
> +
> +       ret = uuid_str_to_bin(CONFIG_EFI_CAPSULE_NAMESPACE_UUID,
> +                       (unsigned char *)&namespace, UUID_STR_FORMAT_GUID);
> +       if (ret) {
> +               log_debug("%s: CONFIG_EFI_CAPSULE_NAMESPACE_UUID is invalid: %d\n", __func__, ret);
> +               return EFI_UNSUPPORTED;
> +       }
> +
> +       compatible = ofnode_read_string(ofnode_root(), "compatible");
> +
> +       if (!compatible) {
> +               log_debug("%s: model or compatible not defined\n", __func__);
> +               return EFI_UNSUPPORTED;
> +       }
> +
> +       if (!update_info.num_images) {
> +               log_debug("%s: no fw_images, make sure update_info.num_images is set\n", __func__);
> +               return -ENODATA;
> +       }

[...]

Cheers
/Ilias
