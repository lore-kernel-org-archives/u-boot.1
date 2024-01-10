Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFBCC4706C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 00:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E38A78756F;
	Wed, 10 Jan 2024 01:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ylJNcZIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2663287855; Wed, 10 Jan 2024 01:53:33 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BD4987509
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 01:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e43e48a16so32441855e9.2
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 16:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704848008; x=1705452808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NHVisfHPWXJy8EzHyS/ueL8yxRB+dfVCuCSrAtMmJW0=;
 b=ylJNcZIRx1m69zzHAx0DqaUD6IiRz5Qv055UxnO9MQdbJKXcmmS63VmLtD32utxvhK
 pyXQQG4wnAzo/B31igBDW5ELdLUafTa7+SXwl/DDxp6qWWdUvyjVVFmnbPYsaydka0MV
 LyqDyJNUcnUT/4f4FlH29AgDNRDE3MgeSYOBCIS5XT+53rV0+TohFZGYcI6Jc0Z9M9Ga
 OK4hk/GWbzkU87jK7KkqRCTVXGPanya4DC5sv0L/vpWnkYAMxfYZUIEVs997SDobqV5X
 12IcakYsWDQMQ9BXSsXOwb50wRXmatBOszitW4r8f3R6VUOuE/U6h3q2XvNons9fr9zK
 Qbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704848008; x=1705452808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NHVisfHPWXJy8EzHyS/ueL8yxRB+dfVCuCSrAtMmJW0=;
 b=vJnYEtvD+oOgZfHr6nKryIqdPeI0ElRBQJ6BTP+YVpLd+DkZ5PoiFxL4ilChHVMNEw
 26PDp5AOpHZiex2HSmtZ+u1HIxUxVjsUHMb7N2dQKqXN92EiSZyN0oGJT3JKZnvVcyZz
 8bXSTtTNWUb/yuiAnzLmJ46iEoEtBFHSJ++A1opz+YbT/sBx/ziubudbwq5vIRzAvV2+
 Nrb0k2QMlHY5TOLlLFqSRBng0//Usx+bqnf3lNYkBwUd0WcwK3Z6UYNz5w4wS1nCReVx
 gwUzKYaIDJ35ybLAax4i5s6rOQHrhQmUTT86foA291ASKi9rhvyVbGh8qLQwLmxpYIjX
 rJcA==
X-Gm-Message-State: AOJu0Yy2t2j93ySnWuRkmJhaRNABRKvYaYzqoEYCQwDvzqKRSn6y94J6
 x3uAktmbc6eD8r4e2yCH20Jb6ouMobUQrR2dGRaTnfMlvm1h0w==
X-Google-Smtp-Source: AGHT+IHw/RjJTSPFgGX7JjCSG1vqn2J0RTqf7PKI3IYlEMfHZM2GrhHV5OLg0kaC+yqmIWzVqj4xBoNf9uNE/e2dLqo=
X-Received: by 2002:a05:600c:1ca3:b0:40e:365c:b452 with SMTP id
 k35-20020a05600c1ca300b0040e365cb452mr80587wms.129.1704848007081; Tue, 09 Jan
 2024 16:53:27 -0800 (PST)
MIME-Version: 1.0
References: <20231221095258.592275-1-masahisa.kojima@linaro.org>
 <20231221095258.592275-3-masahisa.kojima@linaro.org> <ZYw_UqZ_wj-htZvI@hera>
 <CADQ0-X8fBNDCrWkbZWwxYJaovradmMCM+vDt3DEJF2p9X2fgTg@mail.gmail.com>
 <CAC_iWjKBgezN_R54qsyh+WxcbvU4vRuCvyyNiHB-eQgFabBUig@mail.gmail.com>
In-Reply-To: <CAC_iWjKBgezN_R54qsyh+WxcbvU4vRuCvyyNiHB-eQgFabBUig@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Wed, 10 Jan 2024 09:53:15 +0900
Message-ID: <CADQ0-X_mBLqU-hbTaj9Ukg6pMt==poCZeJ8osX52ka6KQjMYaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi_loader: support fmp versioning for multi bank
 update
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Tue, 9 Jan 2024 at 22:02, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 9 Jan 2024 at 03:00, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 28 Dec 2023 at 00:14, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Kojima-san
> > >
> > > On Thu, Dec 21, 2023 at 06:52:58PM +0900, Masahisa Kojima wrote:
> > > > This commit stores the firmware version into the array
> > > > of fmp_state structure to support the fmp versioning
> > > > for multi bank update. The index of the array is identified
> > > > by the bank index.
> > >
> > > Why do we all of them? Can't we just always store/use the version of the active
> > > bank?
> >
> > Sorry for the late reply.
> > When the capsule update is reverted, the active bank is back to the
> > previous active bank.
> > So I think versions for all banks should be stored.
>
> But even in that case, the active bank should point to the correct
> version when the ESRT tables are generated. Wouldn't it be simpler to
> just set the FmpState variable accordingly when that happens?

The fw_version in FmpState variable comes from UEFI Capsule Header and
FmpState variable is set when the UEFI capsule update is performed.
If we only store the fw_version of the active bank, the fw_version of
the previous active bank is overwritten. When the capsule is reverted,
we can not get the fw_version of the previous active bank.

Thanks,
Masahisa Kojima

> Am I missing anything?
>
> Thanks
> /Ilias
> >
> > Thanks,
> > Masahisa Kojima
> >
> > >
> > > >
> > > > This modification keeps the backward compatibility with
> > > > the existing versioning feature.
> > > >
> > >
> > > Thanks
> > > /Ilias
> > > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > > > ---
> > > >  lib/efi_loader/efi_firmware.c | 69 +++++++++++++++++++++++++++--------
> > > >  1 file changed, 54 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> > > > index 9b8630625f..5459f3d38d 100644
> > > > --- a/lib/efi_loader/efi_firmware.c
> > > > +++ b/lib/efi_loader/efi_firmware.c
> > > > @@ -207,18 +207,10 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
> > > >  {
> > > >       u16 varname[13]; /* u"FmpStateXXXX" */
> > > >       efi_status_t ret;
> > > > -     efi_uintn_t size;
> > > > -     struct fmp_state var_state = { 0 };
> > > > -
> > > > -     efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > > > -                             fw_array->image_index);
> > > > -     size = sizeof(var_state);
> > > > -     ret = efi_get_variable_int(varname, &fw_array->image_type_id,
> > > > -                                NULL, &size, &var_state, NULL);
> > > > -     if (ret == EFI_SUCCESS)
> > > > -             image_info->version = var_state.fw_version;
> > > > -     else
> > > > -             image_info->version = 0;
> > > > +     efi_uintn_t size, expected_size;
> > > > +     uint num_banks = 1;
> > > > +     uint active_index = 0;
> > > > +     struct fmp_state *var_state;
> > > >
> > > >       efi_firmware_get_lsv_from_dtb(fw_array->image_index,
> > > >                                     &fw_array->image_type_id,
> > > > @@ -227,6 +219,31 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
> > > >       image_info->version_name = NULL; /* not supported */
> > > >       image_info->last_attempt_version = 0;
> > > >       image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
> > > > +     image_info->version = 0;
> > > > +
> > > > +     /* get the fw_version */
> > > > +     efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > > > +                             fw_array->image_index);
> > > > +     if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> > > > +             ret = fwu_get_active_index(&active_index);
> > > > +             if (ret)
> > > > +                     return;
> > > > +
> > > > +             num_banks = CONFIG_FWU_NUM_BANKS;
> > > > +     }
> > > > +
> > > > +     size = num_banks * sizeof(*var_state);
> > > > +     expected_size = size;
> > > > +     var_state = calloc(1, size);
> > > > +     if (!var_state)
> > > > +             return;
> > > > +
> > > > +     ret = efi_get_variable_int(varname, &fw_array->image_type_id,
> > > > +                                NULL, &size, var_state, NULL);
> > > > +     if (ret == EFI_SUCCESS && expected_size == size)
> > > > +             image_info->version = var_state[active_index].fw_version;
> > > > +
> > > > +     free(var_state);
> > > >  }
> > > >
> > > >  /**
> > > > @@ -362,8 +379,11 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> > > >  {
> > > >       u16 varname[13]; /* u"FmpStateXXXX" */
> > > >       efi_status_t ret;
> > > > +     uint num_banks = 1;
> > > > +     uint update_bank = 0;
> > > > +     efi_uintn_t size;
> > > >       efi_guid_t *image_type_id;
> > > > -     struct fmp_state var_state = { 0 };
> > > > +     struct fmp_state *var_state;
> > > >
> > > >       image_type_id = efi_firmware_get_image_type_id(image_index);
> > > >       if (!image_type_id)
> > > > @@ -372,19 +392,38 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> > > >       efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > > >                               image_index);
> > > >
> > > > +     if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> > > > +             ret = fwu_plat_get_update_index(&update_bank);
> > > > +             if (ret)
> > > > +                     return EFI_INVALID_PARAMETER;
> > > > +
> > > > +             num_banks = CONFIG_FWU_NUM_BANKS;
> > > > +     }
> > > > +
> > > > +     size = num_banks * sizeof(*var_state);
> > > > +     var_state = calloc(1, size);
> > > > +     if (!var_state)
> > > > +             return EFI_OUT_OF_RESOURCES;
> > > > +
> > > > +     ret = efi_get_variable_int(varname, image_type_id, NULL, &size,
> > > > +                                var_state, NULL);
> > > > +
> > > >       /*
> > > >        * Only the fw_version is set here.
> > > >        * lowest_supported_version in FmpState variable is ignored since
> > > >        * it can be tampered if the file based EFI variable storage is used.
> > > >        */
> > > > -     var_state.fw_version = state->fw_version;
> > > > +     var_state[update_bank].fw_version = state->fw_version;
> > > >
> > > > +     size = num_banks * sizeof(*var_state);
> > > >       ret = efi_set_variable_int(varname, image_type_id,
> > > >                                  EFI_VARIABLE_READ_ONLY |
> > > >                                  EFI_VARIABLE_NON_VOLATILE |
> > > >                                  EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > > >                                  EFI_VARIABLE_RUNTIME_ACCESS,
> > > > -                                sizeof(var_state), &var_state, false);
> > > > +                                size, var_state, false);
> > > > +
> > > > +     free(var_state);
> > > >
> > > >       return ret;
> > > >  }
> > > > --
> > > > 2.34.1
> > > >
