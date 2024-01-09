Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F14CC3DA6E
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 01:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488038767C;
	Tue,  9 Jan 2024 02:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bPpRH+ZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD81886E82; Tue,  9 Jan 2024 02:00:47 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1242287718
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 02:00:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50e7af5f618so2525449e87.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 17:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704762043; x=1705366843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ki1Z2fJCTmjSp4wXfOsI+9t1zzLp4D2s7eEIvsA5JfY=;
 b=bPpRH+ZWzql0BR0n5Z7e+bbtpj04DVydmvEt7TrDoE0ALiq2Xp6Kz+d+DdWMhZ/PZX
 V92Jvtl+bWRZlkHWabo6V3N9ndxNwaUblmF0sgBfs8mvyIT921/B9jft91IyncM0qw3a
 aWxCXmjhyWq9ws/aLl1+5sfhb4DWnHPAEQF4vCmIStjxDyoCaPRoU//qrojyj8EZX8Vz
 mip6GkW9WQALGdF5gTCIrLmkVoLN8URSFChpt6L2pNz3sXo208xnYBYYgWr0vsA+HLYb
 mTfwAUox2OeMGwKfwcoqhk+exXxwhxg7RUiZaj056DMboPvYCrDeY7juW9F9GfciBoQt
 AX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704762043; x=1705366843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ki1Z2fJCTmjSp4wXfOsI+9t1zzLp4D2s7eEIvsA5JfY=;
 b=O804EQYrkdgjguhG4KmHyWy+oR0Vg9Ryfnqa2R7O8zONXeVcaRCyH19EfLGdc2WxWf
 BUAAp2cOoJqiAVeU/MiO/SzH5BPILJN7jzCM+NfSoNcSiX/kX55G0DgYkoSXRsPdf06Z
 NXHsXpb+aelx+FboqFy+YQ0rZEGZVrCfmlhY9PrVUpC3A3YSAUq3HmM7gYek61AFgncW
 U8022zVnsy27iKvB3fR/aFjRBbJSSvmDa3qSjhojskOPoX2VGnXw40UzHHaYUy9MP4nw
 CEodgcRz5YkQx7n4jCjAYOQ0ZhdeEvVqVZ8yZCNZiE276HRo8GxqN0PJsyQXTCgfuEnn
 6KMw==
X-Gm-Message-State: AOJu0YxyfA4zxVRJ0706rtE5h+/ZIhEbM1BJEXAZhZbxw+gCWmwnP6I7
 gGLmf4hvyg0YqxxziNesdk3ud29aDxr3MXwHmjAaFG3fi2Vr/Q==
X-Google-Smtp-Source: AGHT+IEZzkQO0zuPL7VHW2MF0ITSibOJ0DgA566BhlL7z/nOAiOzsrQOIVhHc7SxHNYIXhPNNYCk7k3hOaMrgczNuZ4=
X-Received: by 2002:ac2:44cc:0:b0:50e:35a3:a90d with SMTP id
 d12-20020ac244cc000000b0050e35a3a90dmr1745438lfm.36.1704762043285; Mon, 08
 Jan 2024 17:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20231221095258.592275-1-masahisa.kojima@linaro.org>
 <20231221095258.592275-3-masahisa.kojima@linaro.org> <ZYw_UqZ_wj-htZvI@hera>
In-Reply-To: <ZYw_UqZ_wj-htZvI@hera>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 9 Jan 2024 10:00:31 +0900
Message-ID: <CADQ0-X8fBNDCrWkbZWwxYJaovradmMCM+vDt3DEJF2p9X2fgTg@mail.gmail.com>
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

Hi Ilias,

On Thu, 28 Dec 2023 at 00:14, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Kojima-san
>
> On Thu, Dec 21, 2023 at 06:52:58PM +0900, Masahisa Kojima wrote:
> > This commit stores the firmware version into the array
> > of fmp_state structure to support the fmp versioning
> > for multi bank update. The index of the array is identified
> > by the bank index.
>
> Why do we all of them? Can't we just always store/use the version of the active
> bank?

Sorry for the late reply.
When the capsule update is reverted, the active bank is back to the
previous active bank.
So I think versions for all banks should be stored.

Thanks,
Masahisa Kojima

>
> >
> > This modification keeps the backward compatibility with
> > the existing versioning feature.
> >
>
> Thanks
> /Ilias
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  lib/efi_loader/efi_firmware.c | 69 +++++++++++++++++++++++++++--------
> >  1 file changed, 54 insertions(+), 15 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> > index 9b8630625f..5459f3d38d 100644
> > --- a/lib/efi_loader/efi_firmware.c
> > +++ b/lib/efi_loader/efi_firmware.c
> > @@ -207,18 +207,10 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
> >  {
> >       u16 varname[13]; /* u"FmpStateXXXX" */
> >       efi_status_t ret;
> > -     efi_uintn_t size;
> > -     struct fmp_state var_state = { 0 };
> > -
> > -     efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > -                             fw_array->image_index);
> > -     size = sizeof(var_state);
> > -     ret = efi_get_variable_int(varname, &fw_array->image_type_id,
> > -                                NULL, &size, &var_state, NULL);
> > -     if (ret == EFI_SUCCESS)
> > -             image_info->version = var_state.fw_version;
> > -     else
> > -             image_info->version = 0;
> > +     efi_uintn_t size, expected_size;
> > +     uint num_banks = 1;
> > +     uint active_index = 0;
> > +     struct fmp_state *var_state;
> >
> >       efi_firmware_get_lsv_from_dtb(fw_array->image_index,
> >                                     &fw_array->image_type_id,
> > @@ -227,6 +219,31 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
> >       image_info->version_name = NULL; /* not supported */
> >       image_info->last_attempt_version = 0;
> >       image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
> > +     image_info->version = 0;
> > +
> > +     /* get the fw_version */
> > +     efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > +                             fw_array->image_index);
> > +     if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> > +             ret = fwu_get_active_index(&active_index);
> > +             if (ret)
> > +                     return;
> > +
> > +             num_banks = CONFIG_FWU_NUM_BANKS;
> > +     }
> > +
> > +     size = num_banks * sizeof(*var_state);
> > +     expected_size = size;
> > +     var_state = calloc(1, size);
> > +     if (!var_state)
> > +             return;
> > +
> > +     ret = efi_get_variable_int(varname, &fw_array->image_type_id,
> > +                                NULL, &size, var_state, NULL);
> > +     if (ret == EFI_SUCCESS && expected_size == size)
> > +             image_info->version = var_state[active_index].fw_version;
> > +
> > +     free(var_state);
> >  }
> >
> >  /**
> > @@ -362,8 +379,11 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> >  {
> >       u16 varname[13]; /* u"FmpStateXXXX" */
> >       efi_status_t ret;
> > +     uint num_banks = 1;
> > +     uint update_bank = 0;
> > +     efi_uintn_t size;
> >       efi_guid_t *image_type_id;
> > -     struct fmp_state var_state = { 0 };
> > +     struct fmp_state *var_state;
> >
> >       image_type_id = efi_firmware_get_image_type_id(image_index);
> >       if (!image_type_id)
> > @@ -372,19 +392,38 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> >       efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> >                               image_index);
> >
> > +     if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> > +             ret = fwu_plat_get_update_index(&update_bank);
> > +             if (ret)
> > +                     return EFI_INVALID_PARAMETER;
> > +
> > +             num_banks = CONFIG_FWU_NUM_BANKS;
> > +     }
> > +
> > +     size = num_banks * sizeof(*var_state);
> > +     var_state = calloc(1, size);
> > +     if (!var_state)
> > +             return EFI_OUT_OF_RESOURCES;
> > +
> > +     ret = efi_get_variable_int(varname, image_type_id, NULL, &size,
> > +                                var_state, NULL);
> > +
> >       /*
> >        * Only the fw_version is set here.
> >        * lowest_supported_version in FmpState variable is ignored since
> >        * it can be tampered if the file based EFI variable storage is used.
> >        */
> > -     var_state.fw_version = state->fw_version;
> > +     var_state[update_bank].fw_version = state->fw_version;
> >
> > +     size = num_banks * sizeof(*var_state);
> >       ret = efi_set_variable_int(varname, image_type_id,
> >                                  EFI_VARIABLE_READ_ONLY |
> >                                  EFI_VARIABLE_NON_VOLATILE |
> >                                  EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >                                  EFI_VARIABLE_RUNTIME_ACCESS,
> > -                                sizeof(var_state), &var_state, false);
> > +                                size, var_state, false);
> > +
> > +     free(var_state);
> >
> >       return ret;
> >  }
> > --
> > 2.34.1
> >
