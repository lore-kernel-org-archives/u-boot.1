Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA55C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 04:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD29876EA;
	Thu, 11 Jan 2024 05:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="szZBj4TO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1E5487A77; Thu, 11 Jan 2024 05:57:29 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AECF6876C4
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 05:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50e6ee8e911so5386731e87.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 20:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704949047; x=1705553847; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hhLYrF4aGWKJ5P/TQjyCcaCITtIHuzNpvaN7BDTO/tY=;
 b=szZBj4TOiTKAzw7ZB2C4Rqm2Jd8iMBOCAyZVFAR5+r9UggwYlpVY22FFBjODyvnvif
 ugFiEfUL8ecROuOqu7bXtV+gCHcgH7cfNzQxzOPMu7eAJeMeprEt1aAWk5Ur1nYIerQm
 jOtyUsrNC7ezORC8h0XMZtAAa261pFmVqwVcw698dL1O0Yi3nYF4Facz0GGFPEqagKqE
 4zX1Pja5JjuKk7XYwLfbrdV7/D1jptFOnjdxcUEbRmy3h8UROOMJrKkYcITpH8L1bun+
 Cu3ZUghkplwTMqlOoH3qMwoAQEI4CKQnSKiAF2/4DuDAbVbrBA18cdw/v4dXqLExyuli
 ao0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704949047; x=1705553847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hhLYrF4aGWKJ5P/TQjyCcaCITtIHuzNpvaN7BDTO/tY=;
 b=MpC04xzzTRinaxye9y6QBpogF0/LZBh6x1EhSOvdxLmDQvxCdnLuz+gQHups7XtZp+
 HWIUSGnsEN0QqdF/ZVCqtN7ikvzgl7l4WPqcjqKX4H/hSagGTWxBZxpoWkDXI3Yk0Qes
 L70nr+hWoekZFWDzKUG+/t2g22czzbS/6VVBJCAZ1S72K6y5EKNLKb/s1Uw6TQf10Bg+
 h4A6kr9857p12Cm/gYcaGQ3QKMKCj3jAs3o5xSK9HswFgX+oPYCNCIH8lp/ZtKC/qumV
 OiEneCyD+QPJNGbbawSoOw8m2ItLiJiUW+htiZ80znbkTG9xkuhKRhuEho9TMEWVDiw5
 TSpQ==
X-Gm-Message-State: AOJu0YwsAl1nWA2eqJRTiUnynfqYAJeygeXPlINNt42UHwE/jaHhB1Z3
 ro3/go027VkX7EziV8fy6EXkt3oq9wSVpY2pbwHXmR0XamSxVw==
X-Google-Smtp-Source: AGHT+IGpdmfduUU4VZts3gqAkHji/NafF+GY/XeAsC3DG6BcS4wvohpyGEMJSSi4Wn+7VP3/kbSHsyJrpgSxLJjYgB4=
X-Received: by 2002:a05:6512:12c5:b0:50e:aa04:b2ee with SMTP id
 p5-20020a05651212c500b0050eaa04b2eemr292670lfg.95.1704949046900; Wed, 10 Jan
 2024 20:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20231221095258.592275-1-masahisa.kojima@linaro.org>
 <20231221095258.592275-3-masahisa.kojima@linaro.org> <ZYw_UqZ_wj-htZvI@hera>
 <CADQ0-X8fBNDCrWkbZWwxYJaovradmMCM+vDt3DEJF2p9X2fgTg@mail.gmail.com>
 <CAC_iWjKBgezN_R54qsyh+WxcbvU4vRuCvyyNiHB-eQgFabBUig@mail.gmail.com>
 <CADQ0-X_mBLqU-hbTaj9Ukg6pMt==poCZeJ8osX52ka6KQjMYaw@mail.gmail.com>
 <CAC_iWj+Ai8BussULexgUz-JRyuxra=AiCoCaFD8q1x6tE7B_mw@mail.gmail.com>
 <CADQ0-X9wbVRZNUhQnQJNz59x=FCAQ9bb0cvhWdvEWjM0c9yGkg@mail.gmail.com>
In-Reply-To: <CADQ0-X9wbVRZNUhQnQJNz59x=FCAQ9bb0cvhWdvEWjM0c9yGkg@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 11 Jan 2024 13:57:15 +0900
Message-ID: <CADQ0-X8QSd+sZSxrb55La7r85nZ3eYQHJkt_mUZOvP3ZghMkgQ@mail.gmail.com>
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

On Thu, 11 Jan 2024 at 10:53, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> On Wed, 10 Jan 2024 at 18:10, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Wed, 10 Jan 2024 at 02:53, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > On Tue, 9 Jan 2024 at 22:02, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Tue, 9 Jan 2024 at 03:00, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Thu, 28 Dec 2023 at 00:14, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Kojima-san
> > > > > >
> > > > > > On Thu, Dec 21, 2023 at 06:52:58PM +0900, Masahisa Kojima wrote:
> > > > > > > This commit stores the firmware version into the array
> > > > > > > of fmp_state structure to support the fmp versioning
> > > > > > > for multi bank update. The index of the array is identified
> > > > > > > by the bank index.
> > > > > >
> > > > > > Why do we all of them? Can't we just always store/use the version of the active
> > > > > > bank?
> > > > >
> > > > > Sorry for the late reply.
> > > > > When the capsule update is reverted, the active bank is back to the
> > > > > previous active bank.
> > > > > So I think versions for all banks should be stored.
> > > >
> > > > But even in that case, the active bank should point to the correct
> > > > version when the ESRT tables are generated. Wouldn't it be simpler to
> > > > just set the FmpState variable accordingly when that happens?
> > >
> > > The fw_version in FmpState variable comes from UEFI Capsule Header and
> > > FmpState variable is set when the UEFI capsule update is performed.
> > > If we only store the fw_version of the active bank, the fw_version of
> > > the previous active bank is overwritten. When the capsule is reverted,
> > > we can not get the fw_version of the previous active bank.
> > >
> > > Thanks,
> > > Masahisa Kojima
> >
> > Ah yes, that makes sense.  In that case, the patch looks fine, apart
> > from the return value of the getvariable call which is never checked
> >
> >
> > > > > > >
> > > > > > >       image_type_id = efi_firmware_get_image_type_id(image_index);
> > > > > > >       if (!image_type_id)
> > > > > > > @@ -372,19 +392,38 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> > > > > > >       efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > > > > > >                               image_index);
> > > > > > >
> > > > > > > +     if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> > > > > > > +             ret = fwu_plat_get_update_index(&update_bank);
> > > > > > > +             if (ret)
> > > > > > > +                     return EFI_INVALID_PARAMETER;
> > > > > > > +
> > > > > > > +             num_banks = CONFIG_FWU_NUM_BANKS;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     size = num_banks * sizeof(*var_state);
> > > > > > > +     var_state = calloc(1, size);
> > > > > > > +     if (!var_state)
> > > > > > > +             return EFI_OUT_OF_RESOURCES;
> > > > > > > +
> > > > > > > +     ret = efi_get_variable_int(varname, image_type_id, NULL, &size,
> > > > > > > +                                var_state, NULL);
> > > > > > > +
> >
> > We should be checking the return value here.
>
> I will fix it.

This efi_get_variable_int() call may fail, EFI_NOT_FOUND is returned
if FmpState variable has not been set yet for example.
We can ignore the error since the correct FmpState variable is set later.
I will add a comment.

Thanks,
Masahisa Kojima

>
> Thanks,
> Masahisa Kojima
>
> >
> > > > > > >       /*
> > > > > > >        * Only the fw_version is set here.
> > > > > > >        * lowest_supported_version in FmpState variable is ignored since
> > > > > > >        * it can be tampered if the file based EFI variable storage is used.
> > > > > > >        */
> > > > > > > -     var_state.fw_version = state->fw_version;
> > > > > > > +     var_state[update_bank].fw_version = state->fw_version;
> > > > > > >
> > > > > > > +     size = num_banks * sizeof(*var_state);
> > > > > > >       ret = efi_set_variable_int(varname, image_type_id,
> > > > > > >                                  EFI_VARIABLE_READ_ONLY |
> > > > > > >                                  EFI_VARIABLE_NON_VOLATILE |
> > > > > > >                                  EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > > > > > >                                  EFI_VARIABLE_RUNTIME_ACCESS,
> > > > > > > -                                sizeof(var_state), &var_state, false);
> > > > > > > +                                size, var_state, false);
> > > > > > > +
> > > > > > > +     free(var_state);
> > > > > > >
> > > > > > >       return ret;
> > > > > > >  }
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> >
> > Thanks
> > /Ilias
