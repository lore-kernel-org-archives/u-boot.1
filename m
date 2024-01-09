Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FDAC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 13:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0972877F9;
	Tue,  9 Jan 2024 14:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LLt8aAPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C358687800; Tue,  9 Jan 2024 14:02:51 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AECBC86E82
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 14:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e759ece35so3109167e87.3
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 05:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704805369; x=1705410169; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tvrFgKkSwxEG0W3cDS2Rjcp1RLHnovalUMSrD9hfS6c=;
 b=LLt8aAPQGGezQYrtpHSM5MOoZvk4eIcs8AJnTsj9IrpDFuOZlF7EHNHQKJlKYBIFjU
 BoksrK8pj5vvJ2/SxIcCY+1fzCsiKThKx+jTTeOK8aXa4mM1rWjV2y4xmSrsEpH+81/S
 Ibd7A2xPVOhEq1REmF0/uoMsZm5zwdZLXVQsOPmHvom2XREyvIIQz2r8Cv2XTEskvO7N
 whWoFpj/34u/6SViepJiXgm/2F36Yfe8BNxkuXklcWWJLGgCLqRGt289iSwbraM/K45S
 67ijqprYVTJ0ZmCw3n3SsC7tyCqQDhrkoxYFrlHYEbcvxJNefsT4BdNuSuNA3yNWHQeY
 6LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704805369; x=1705410169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tvrFgKkSwxEG0W3cDS2Rjcp1RLHnovalUMSrD9hfS6c=;
 b=XJz1F7uwMMtYTkXn11ldJrRqXgCEIUvFxaHrZECjqAmdSL9OrOWIIwnfrVIP80kPsb
 /ihWjjVNMwdudPWHpnKLQ7zt0F7hshHCVuTCyU8VZIKd3FJGQB0jtOL8HykpyayczK2E
 PdgMiXXH7JLgyz0vvGtw0GFU3eZ41SrasPbktnSJQb1m1+rhMQOpTruV3muP4vpQBj32
 45fAAtX643dTuD9Iny+So78NaY9XYdJE7cXGYK0EBu6b9/1g/A8GFr3c14SKxIgbwz3q
 h0F7Y0lZxssLMvRU998omTKDn7jl/3UWW3fDCN4aWnRvefhwhrI8abV9rfMlQmK1OorU
 mURQ==
X-Gm-Message-State: AOJu0YzFx2eutSMXkFoA8DzFUjRkPNoJ2g4NADOFzQlh7m2V0asrQtDM
 7JoDnGy0NFwxNhrLWM1Pg9oOiWDadY2HQeW+c9DwReEyoiIu+Q==
X-Google-Smtp-Source: AGHT+IHF+CFHOUhW8FVRkrNFV4fRh5YL0lfswRFPSpuFwP+kK42s3q9BdpmOHZN1DGW7zcog57yHVsFrE+tKmBX/Pq4=
X-Received: by 2002:a05:6512:2394:b0:50e:7c70:fbe1 with SMTP id
 c20-20020a056512239400b0050e7c70fbe1mr2411285lfv.100.1704805368751; Tue, 09
 Jan 2024 05:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20231221095258.592275-1-masahisa.kojima@linaro.org>
 <20231221095258.592275-3-masahisa.kojima@linaro.org> <ZYw_UqZ_wj-htZvI@hera>
 <CADQ0-X8fBNDCrWkbZWwxYJaovradmMCM+vDt3DEJF2p9X2fgTg@mail.gmail.com>
In-Reply-To: <CADQ0-X8fBNDCrWkbZWwxYJaovradmMCM+vDt3DEJF2p9X2fgTg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 9 Jan 2024 15:02:12 +0200
Message-ID: <CAC_iWjKBgezN_R54qsyh+WxcbvU4vRuCvyyNiHB-eQgFabBUig@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi_loader: support fmp versioning for multi bank
 update
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Tue, 9 Jan 2024 at 03:00, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> Hi Ilias,
>
> On Thu, 28 Dec 2023 at 00:14, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Kojima-san
> >
> > On Thu, Dec 21, 2023 at 06:52:58PM +0900, Masahisa Kojima wrote:
> > > This commit stores the firmware version into the array
> > > of fmp_state structure to support the fmp versioning
> > > for multi bank update. The index of the array is identified
> > > by the bank index.
> >
> > Why do we all of them? Can't we just always store/use the version of the active
> > bank?
>
> Sorry for the late reply.
> When the capsule update is reverted, the active bank is back to the
> previous active bank.
> So I think versions for all banks should be stored.

But even in that case, the active bank should point to the correct
version when the ESRT tables are generated. Wouldn't it be simpler to
just set the FmpState variable accordingly when that happens?
Am I missing anything?

Thanks
/Ilias
>
> Thanks,
> Masahisa Kojima
>
> >
> > >
> > > This modification keeps the backward compatibility with
> > > the existing versioning feature.
> > >
> >
> > Thanks
> > /Ilias
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > > ---
> > >  lib/efi_loader/efi_firmware.c | 69 +++++++++++++++++++++++++++--------
> > >  1 file changed, 54 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> > > index 9b8630625f..5459f3d38d 100644
> > > --- a/lib/efi_loader/efi_firmware.c
> > > +++ b/lib/efi_loader/efi_firmware.c
> > > @@ -207,18 +207,10 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
> > >  {
> > >       u16 varname[13]; /* u"FmpStateXXXX" */
> > >       efi_status_t ret;
> > > -     efi_uintn_t size;
> > > -     struct fmp_state var_state = { 0 };
> > > -
> > > -     efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > > -                             fw_array->image_index);
> > > -     size = sizeof(var_state);
> > > -     ret = efi_get_variable_int(varname, &fw_array->image_type_id,
> > > -                                NULL, &size, &var_state, NULL);
> > > -     if (ret == EFI_SUCCESS)
> > > -             image_info->version = var_state.fw_version;
> > > -     else
> > > -             image_info->version = 0;
> > > +     efi_uintn_t size, expected_size;
> > > +     uint num_banks = 1;
> > > +     uint active_index = 0;
> > > +     struct fmp_state *var_state;
> > >
> > >       efi_firmware_get_lsv_from_dtb(fw_array->image_index,
> > >                                     &fw_array->image_type_id,
> > > @@ -227,6 +219,31 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
> > >       image_info->version_name = NULL; /* not supported */
> > >       image_info->last_attempt_version = 0;
> > >       image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
> > > +     image_info->version = 0;
> > > +
> > > +     /* get the fw_version */
> > > +     efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > > +                             fw_array->image_index);
> > > +     if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> > > +             ret = fwu_get_active_index(&active_index);
> > > +             if (ret)
> > > +                     return;
> > > +
> > > +             num_banks = CONFIG_FWU_NUM_BANKS;
> > > +     }
> > > +
> > > +     size = num_banks * sizeof(*var_state);
> > > +     expected_size = size;
> > > +     var_state = calloc(1, size);
> > > +     if (!var_state)
> > > +             return;
> > > +
> > > +     ret = efi_get_variable_int(varname, &fw_array->image_type_id,
> > > +                                NULL, &size, var_state, NULL);
> > > +     if (ret == EFI_SUCCESS && expected_size == size)
> > > +             image_info->version = var_state[active_index].fw_version;
> > > +
> > > +     free(var_state);
> > >  }
> > >
> > >  /**
> > > @@ -362,8 +379,11 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> > >  {
> > >       u16 varname[13]; /* u"FmpStateXXXX" */
> > >       efi_status_t ret;
> > > +     uint num_banks = 1;
> > > +     uint update_bank = 0;
> > > +     efi_uintn_t size;
> > >       efi_guid_t *image_type_id;
> > > -     struct fmp_state var_state = { 0 };
> > > +     struct fmp_state *var_state;
> > >
> > >       image_type_id = efi_firmware_get_image_type_id(image_index);
> > >       if (!image_type_id)
> > > @@ -372,19 +392,38 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> > >       efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > >                               image_index);
> > >
> > > +     if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> > > +             ret = fwu_plat_get_update_index(&update_bank);
> > > +             if (ret)
> > > +                     return EFI_INVALID_PARAMETER;
> > > +
> > > +             num_banks = CONFIG_FWU_NUM_BANKS;
> > > +     }
> > > +
> > > +     size = num_banks * sizeof(*var_state);
> > > +     var_state = calloc(1, size);
> > > +     if (!var_state)
> > > +             return EFI_OUT_OF_RESOURCES;
> > > +
> > > +     ret = efi_get_variable_int(varname, image_type_id, NULL, &size,
> > > +                                var_state, NULL);
> > > +
> > >       /*
> > >        * Only the fw_version is set here.
> > >        * lowest_supported_version in FmpState variable is ignored since
> > >        * it can be tampered if the file based EFI variable storage is used.
> > >        */
> > > -     var_state.fw_version = state->fw_version;
> > > +     var_state[update_bank].fw_version = state->fw_version;
> > >
> > > +     size = num_banks * sizeof(*var_state);
> > >       ret = efi_set_variable_int(varname, image_type_id,
> > >                                  EFI_VARIABLE_READ_ONLY |
> > >                                  EFI_VARIABLE_NON_VOLATILE |
> > >                                  EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > >                                  EFI_VARIABLE_RUNTIME_ACCESS,
> > > -                                sizeof(var_state), &var_state, false);
> > > +                                size, var_state, false);
> > > +
> > > +     free(var_state);
> > >
> > >       return ret;
> > >  }
> > > --
> > > 2.34.1
> > >
