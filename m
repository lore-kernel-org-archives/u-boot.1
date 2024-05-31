Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0E1C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 11:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CC5388765;
	Fri, 31 May 2024 13:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g6HZbjkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED1D88774; Fri, 31 May 2024 13:48:43 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E63885FF
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 13:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2c1b9152848so1064446a91.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 04:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717156119; x=1717760919; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kx1yzZwdSaUrP5KBRb/0IkTVwFzRnGAoNn0IuNRkiOo=;
 b=g6HZbjkwBsYg+NuEcA0/RovyU5qE1VwftPRnoMGDVBQlbWOtBQoBObLwGNbCBuSu8r
 QHiJUMsFMQ/TI3OMfFhcKw1TJO9GWsmMaBF8TkirUugU6a5bTz4nsx5V8fN4IoXF86Yv
 9Sy0epPqndZsiR7g2v/8nEd6vm74awlC1ENA/lc+9pt8eQHPOVw93JizY9Z30+AqPieo
 54GU5uOPyNpSb+BVrCSkCdBvjrlWCt+bfDSWZ1mpf+7f0P7G7phGWSnjbVXRaxntkDkG
 /hiGY47VbkkEur7qKISxz3cK4ajgQTIkOoSz7EwktsdSVU7A5cZKRWEiJfEZQ+a29pug
 8QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717156119; x=1717760919;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kx1yzZwdSaUrP5KBRb/0IkTVwFzRnGAoNn0IuNRkiOo=;
 b=MX9JuAoOoihVGcu17lv+bh0g7aY759PvY/ftMByIANQbpKGBRVgkrQL5N6EreMjfdi
 sZHjzY50gh/Cib/79AtXoSNYNb251o/IUPAI9PMcUlR9bxhmiXeJ+xMcnvGp6cwN7B8b
 KjycAZ0LxADIqXVdaIZJourjO0qN33g6PifHbkZOYKQrlSuj67NKhmkZc7E3BqiCQTCs
 PojPd4r5j8hjYi9NBLlQFHPU3UCU3IGUyWQDKQ2AXzGt5nNt21d2qOVeq7Fph4KYpRWf
 /gDG3pj9xqsPqQ/bDZ/Yk/Y4kjrvHgImkbF5Q0uTULZZU4CE/PbEco83KV7YesvPKWrb
 RxSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhEZbgpzjzCmJibTriuRutyb3gHFSe/X92WsfXA/l1cnExaw+LrrQ+ydY3Aa0K1/aGMDEDvbWqBotiZZt9XefRsMWSkA==
X-Gm-Message-State: AOJu0YwdGSjLjeikcIcMcpsaAde9Dg4lv1siVQh1iCtBN+yiCeI1zN6v
 pGpTDFalrRfXcElkyQ2IZ1GEV9iR6U1MGf2fxianhxqXwEGxpQqMPKiPZoWsvKAJSeEfaEs1I6f
 9JPRqpOIvmKT+SCStMgJ5w3H922aAfEXurRSdNA==
X-Google-Smtp-Source: AGHT+IGiLatAPpPfUnawv3fN6M/JG2GNtN+3CLzlfeGXedERYcVYUovj+wOJOZT/5qn2dLzmAEzqW0XOADKVGRNNIHQ=
X-Received: by 2002:a17:90a:de03:b0:2bd:e947:aa21 with SMTP id
 98e67ed59e1d1-2c1dc560191mr1418684a91.2.1717156119170; Fri, 31 May 2024
 04:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-2-c26f31057bbe@linaro.org>
 <CAC_iWjK_3ZFzeFN-Ej-OAhB8EDzkywy11j6dL3qNhAELz8r79g@mail.gmail.com>
 <ff49dafd-4550-4680-a4f0-b1808718dd51@linaro.org>
In-Reply-To: <ff49dafd-4550-4680-a4f0-b1808718dd51@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 May 2024 14:48:03 +0300
Message-ID: <CAC_iWjLLB_crEDQJBBA8+5Z2AFjWtaRr1TJELZiGZbSk_f208g@mail.gmail.com>
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

On Fri, 31 May 2024 at 14:26, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 30/05/2024 16:56, Ilias Apalodimas wrote:
> > Hi Caleb,
>
> Hi Ilias,
> >
> > [...]
> >
> >>
> >>   #include <crypto/pkcs7.h>
> >>   #include <crypto/pkcs7_parser.h>
> >>   #include <linux/err.h>
> >> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> >> index ba5aba098c0f..a8dafe4f01a5 100644
> >> --- a/lib/efi_loader/efi_firmware.c
> >> +++ b/lib/efi_loader/efi_firmware.c
> >> @@ -244,8 +244,71 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
> >>
> >>          free(var_state);
> >>   }
> >>
> >> +#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
> >> +/**
> >> + * efi_capsule_update_info_gen_ids - generate GUIDs for the images
> >> + *
> >> + * Generate the image_type_id for each image in the update_info.images array
> >> + * using the first compatible from the device tree and a salt
> >> + * UUID defined at build time.
> >> + *
> >> + * Returns:            status code
> >> + */
> >> +static efi_status_t efi_capsule_update_info_gen_ids(void)
> >> +{
> >> +       int ret, i;
> >> +       struct uuid namespace;
> >> +       const char *compatible; /* Full array including null bytes */
> >> +       struct efi_fw_image *fw_array;
> >> +
> >> +       fw_array = update_info.images;
> >> +       /* Check if we need to run (there are images and we didn't already generate their IDs) */
> >> +       if (!update_info.num_images ||
> >> +           memchr_inv(&fw_array[0].image_type_id, 0, sizeof(fw_array[0].image_type_id)))
> >
> > Why not just go a guidcmp()? memchr_inv() will return the first
> > invalid match, but we don't need that
>
> guidcmp() would require allocating a zero guid to compare to, this is
> just a check for any non-zero byte in the GUID so memchr_inv() seemed
> more fitting.
>
> I can switch to guidcmp() for readability.

Right, I misread what memchr_inv() does, keep it as-is it's fine

Thanks
/Ilias
> >
> >> +               return EFI_SUCCESS;
> >> +
> >> +       ret = uuid_str_to_bin(CONFIG_EFI_CAPSULE_NAMESPACE_UUID,
> >> +                       (unsigned char *)&namespace, UUID_STR_FORMAT_GUID);
> >> +       if (ret) {
> >> +               log_debug("%s: CONFIG_EFI_CAPSULE_NAMESPACE_UUID is invalid: %d\n", __func__, ret);
> >> +               return EFI_UNSUPPORTED;
> >> +       }
> >> +
> >> +       compatible = ofnode_read_string(ofnode_root(), "compatible");
> >> +
> >> +       if (!compatible) {
> >> +               log_debug("%s: model or compatible not defined\n", __func__);
> >> +               return EFI_UNSUPPORTED;
> >> +       }
> >> +
> >> +       if (!update_info.num_images) {
> >> +               log_debug("%s: no fw_images, make sure update_info.num_images is set\n", __func__);
> >> +               return -ENODATA;
> >> +       }
> >
> > [...]
> >
> > Cheers
> > /Ilias
>
> --
> // Caleb (they/them)
