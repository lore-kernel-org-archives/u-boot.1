Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49ACC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 04:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE66871A6;
	Mon, 11 Dec 2023 05:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lv8fmx9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221AC871AA; Mon, 11 Dec 2023 05:37:40 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89EE807AE
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 05:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50bf2d9b3fdso5159429e87.3
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 20:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702269457; x=1702874257; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l3SNnFosdtLTK9HfWkzSH/2nyn2GEIcPgfj+6UF4OAg=;
 b=Lv8fmx9pxHkGPjcekzDsa7AfQjyeIGjUw2NqWMl6WL+TbPc+Dv9+Yof9LapMlxDbdY
 ITAwvDDJ5Y4aEk4l/DCeNRm8jGDHVB/Vub7QdSq9cjR+I1pSMri+sNYAGnZyBYPRhHEj
 AJv1PAvvHx3dztVPosNWktJQBb+mLc8we+x44yn0RgqUTZTahI1UodIXzV9kScP0EsxY
 zLT6mYZEQcaatyag2oRrUkoUKzpMwCZJX93XCoiL71vWDcAKdi3UrExrrH2faee9jyGo
 C6w0aKEvPQDjJ2VrNrm5fXDeUFSMgXBJdJ/1md+eS93o8o/FpfmZfI9DnVovzTukeIyp
 thcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702269457; x=1702874257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l3SNnFosdtLTK9HfWkzSH/2nyn2GEIcPgfj+6UF4OAg=;
 b=Y3T3vHuCdT6CWFMqWa8rT0ojF/vgd4plKNMjLovnftkWOrWT9ZToVAez5vjh/YUrHw
 prMiYtTJ8W9ITlIrRqMoXJGCmmdmKlbhBjZUkuwuVZse4uwkMX31FH7NjuM3ylWbzoia
 pKFoQbi5QmJZeGK7ry8bfQI4FIjXdO/ztHNAVjlYBEfbfv/4V7kcPOJZJOTAiJdA2vsC
 i3wUrLsb+m+LgOC3IhD73GiXsmBjOkP9thxE1CTmmiQDGLs9qBX5x9eMy6slRMztTead
 cCBF9LX/5Lmi28umaWLoefFL4fZPX40Uqihs7xkWxC5RoiIij1tQYXlD72mPkejZ0pL2
 BIjg==
X-Gm-Message-State: AOJu0Yytib3obmhWJYTyD4qb6At5e6QL1qjA9/7vEhI6Rac3976s9OZf
 x0F8yv34iG0ELLDHo5r6ED2TXq67/OYXQyr9nQa7HYoibS8mz4D8
X-Google-Smtp-Source: AGHT+IEfVBQAkHLIUK6NSKo0so0j6WIiCbiyjrA/7QhmDDNLszOG1GoVc2M1vzWPpMhYVxf7UjDbDPpu39iOc2qTpHU=
X-Received: by 2002:a05:6512:3a90:b0:50d:23e4:fe9c with SMTP id
 q16-20020a0565123a9000b0050d23e4fe9cmr1465378lfu.64.1702269456822; Sun, 10
 Dec 2023 20:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20231114092508.3955838-1-masahisa.kojima@linaro.org>
 <20231114092508.3955838-3-masahisa.kojima@linaro.org>
 <45ff39a5-0234-4fae-a174-732725e6c359@gmx.de>
In-Reply-To: <45ff39a5-0234-4fae-a174-732725e6c359@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 11 Dec 2023 13:37:25 +0900
Message-ID: <CADQ0-X80HVmMc=T3FQM4n9ucNzak6aShApG_DUFURXVt_399Jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: support FMP versioning for FWU multi bank
 update
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Jassi Brar <jaswinder.singh@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

Hi Heinrich,

On Sun, 10 Dec 2023 at 00:09, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/14/23 10:25, Masahisa Kojima wrote:
> > Current FMP versioning uses the FMPStateXXXX UEFI variables
>
> Do you mean FmpState####?
>
> > that XXXX indicates image_index. When CONFIG_FWU_MULTI_BANK_UPDATE
> > is enabled, U-Boot instances installed in different banks
> > read the same FMPStateXXXX variable and it ends up with reading
> > wrong fw_version.
> >
> > This commit includes the bank_index in the FMPStateXXYY variable.
> > XX indicates a bank_index, YY indicates an image_index.
> > With this, it keeps backward compatibility for the case that
> > CONFIG_FWU_MULTI_BANK_UPDATE is not enabled, bank_index is
> > always 0 for this case.
> >
> > The bank index size is defined 4 bytes in FWU-PSA-A_DEN0118_1.0ALP3.pdf,
> > but 1-255 range is practically enough big. This commit adds the range
> > for FWU_NUM_BANKS since above XX(bank_index) has 1 byte.
>
> Who would need more than 16 banks (i.e. more than one digit)?
>
> What happens when the image number reaches 256 (or 4096 for 3 digits)?
> What happens with devices out in the field that already have reached
> image number 256?
>
> Why don't we store the fmp_state of all banks in the same FmpState####
> variable as an array? This should have a better chance of backwards
> compatibility.

Thanks. I will implement the next version with the array of versions
of each bank.

Regards,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >   lib/efi_loader/efi_firmware.c | 63 ++++++++++++++++++++++++++---------
> >   lib/fwu_updates/Kconfig       |  1 +
> >   2 files changed, 48 insertions(+), 16 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> > index 9c1a273926..6d3620a649 100644
> > --- a/lib/efi_loader/efi_firmware.c
> > +++ b/lib/efi_loader/efi_firmware.c
> > @@ -205,13 +205,33 @@ static
> >   void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_info,
> >                                   struct efi_fw_image *fw_array)
> >   {
> > -     u16 varname[13]; /* u"FmpStateXXXX" */
> > +     int err;
> > +     u16 varname[13]; /* u"FmpStateXXYY" */
> >       efi_status_t ret;
> >       efi_uintn_t size;
> > +     uint active_bank = 0, var_index;
> >       struct fmp_state var_state = { 0 };
> >
> > +     efi_firmware_get_lsv_from_dtb(fw_array->image_index,
> > +                                   &fw_array->image_type_id,
> > +                                   &image_info->lowest_supported_image_version);
> > +
> > +     image_info->version_name = NULL; /* not supported */
> > +     image_info->last_attempt_version = 0;
> > +     image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
> > +
> > +     if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> > +             err = fwu_get_active_index(&active_bank);
> > +             if (err) {
> > +                     log_debug("Unable to get active index\n");
> > +                     image_info->version = 0;
> > +                     return;
> > +             }
> > +     }
> > +
> > +     var_index = ((active_bank & 0xFF) << 8 | (fw_array->image_index & 0xFF));
> >       efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > -                             fw_array->image_index);
> > +                             var_index);
> >       size = sizeof(var_state);
> >       ret = efi_get_variable_int(varname, &fw_array->image_type_id,
> >                                  NULL, &size, &var_state, NULL);
> > @@ -219,14 +239,6 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
> >               image_info->version = var_state.fw_version;
> >       else
> >               image_info->version = 0;
> > -
> > -     efi_firmware_get_lsv_from_dtb(fw_array->image_index,
> > -                                   &fw_array->image_type_id,
> > -                                   &image_info->lowest_supported_image_version);
> > -
> > -     image_info->version_name = NULL; /* not supported */
> > -     image_info->last_attempt_version = 0;
> > -     image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
> >   }
> >
> >   /**
> > @@ -353,15 +365,20 @@ efi_status_t efi_firmware_capsule_authenticate(const void **p_image,
> >    * @state:          Pointer to fmp state
> >    * @image_index:    image index
> >    *
> > - * Update the FmpStateXXXX variable with the firmware update state.
> > + * Update the FmpStateXXYY variable with the firmware update state.
> > + * XX is a bank index, YY is an image_index
> > + * When CONFIG_FWU_MULTI_BANK_UPDATE is not enabled, update_bank is always 0.
> >    *
> >    * Return:          status code
> >    */
> >   static
> >   efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_index)
> >   {
> > -     u16 varname[13]; /* u"FmpStateXXXX" */
> > +     int err;
> > +     u16 varname[13]; /* u"FmpStateXXYY" */
> >       efi_status_t ret;
> > +     uint update_bank = 0;
> > +     unsigned int var_index;
> >       efi_guid_t *image_type_id;
> >       struct fmp_state var_state = { 0 };
> >
> > @@ -369,9 +386,15 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> >       if (!image_type_id)
> >               return EFI_INVALID_PARAMETER;
> >
> > -     efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > -                             image_index);
> > +     if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> > +             err = fwu_plat_get_update_index(&update_bank);
> > +             if (err)
> > +                     return EFI_INVALID_PARAMETER;
> > +     }
> >
> > +     var_index = ((update_bank & 0xFF) << 8 | (image_index & 0xFF));
> > +     efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > +                             var_index);
> >       /*
> >        * Only the fw_version is set here.
> >        * lowest_supported_version in FmpState variable is ignored since
> > @@ -563,7 +586,11 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
> >       if (fit_update(image))
> >               return EFI_EXIT(EFI_DEVICE_ERROR);
> >
> > -     efi_firmware_set_fmp_state_var(&state, image_index);
> > +     status = efi_firmware_set_fmp_state_var(&state, image_index);
> > +     if (status != EFI_SUCCESS) {
> > +             log_err("Set FmpState variable failed\n");
> > +             return EFI_EXIT(status);
> > +     }
> >
> >       return EFI_EXIT(EFI_SUCCESS);
> >   }
> > @@ -643,7 +670,11 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
> >                            NULL, NULL))
> >               return EFI_EXIT(EFI_DEVICE_ERROR);
> >
> > -     efi_firmware_set_fmp_state_var(&state, original_image_index);
> > +     status = efi_firmware_set_fmp_state_var(&state, original_image_index);
> > +     if (status != EFI_SUCCESS) {
> > +             log_err("Set FmpState variable failed\n");
> > +             return EFI_EXIT(status);
> > +     }
> >
> >       return EFI_EXIT(EFI_SUCCESS);
> >   }
> > diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
> > index d35247d0e5..eb42f25fc0 100644
> > --- a/lib/fwu_updates/Kconfig
> > +++ b/lib/fwu_updates/Kconfig
> > @@ -14,6 +14,7 @@ if FWU_MULTI_BANK_UPDATE
> >
> >   config FWU_NUM_BANKS
> >       int "Number of Banks defined by the platform"
> > +     range 1 255
> >       help
> >         Define the number of banks of firmware images on a platform
> >
>
