Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AC8C47073
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 01:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4725C87823;
	Thu, 11 Jan 2024 02:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P7iIi+Cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87A66876EA; Thu, 11 Jan 2024 02:53:54 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B9785E44
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 02:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a28bf46ea11so843567166b.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 17:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704938032; x=1705542832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9etXP/IMU8jyAurGO16YHfdU47r81P+YNv4bT4dOiIw=;
 b=P7iIi+CcP8oKPEWQetADgV/fc9WepIa5YK3D60rbAU1TP4FltwrqvyQr+8qmz7+SeM
 KWxIPIic93No3UGlEtWMkrShrdnC8Lkztf1QQqhZkBnW0NOMdWCKXGJGakIzc1TxKooK
 hL48oHdzdYtOo7wj1HZOhL04z5hLBGbb7RjyJYrIUL0rEKJUS/MtG6jbXGkMAb3NfRAd
 lIGyF3RWghKMbT8WN2VLJlCI2YyP0s6pF4qIOzocLB04Vfm+gLAidiOH9PamVKA/YPMF
 bXyNCJhc175NcFXF2M/3NRb7QaC2cZQ4b2YE5rF0eIJQdA0PDGo1eUysEf/iCph6jBl/
 Up3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704938032; x=1705542832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9etXP/IMU8jyAurGO16YHfdU47r81P+YNv4bT4dOiIw=;
 b=XYopRK+tOjk/sW4FgkKxWLlnuwnVBcMfDNjrIY7bJyEi5sV9xNzhPQOeVzoMOOkNmj
 zBiecc/QGd8B0B17EazC5bgC+jQGep0+i/AjqOzZkySpQbkttzURlRN2JibBl/3+c5Cc
 5dnKIbtTkBtlAI4y9sp1m6bY17rPk3t8wOXf+uFGWJ1dXbCNaaZ5Pox5/m046XjiXrHr
 hQ88OTuZfYbRL8Lm8iEMPAD5XkqbQi2F/snDAS1UODKceihv669bczgVVeEsUhBHcoZg
 FClJJRDtVeYMB0iomEmj/X6EQMkjvlDO5Ezkn6evYzt8vYfafGLUHOpS+mUnZhu9cvKn
 K8eA==
X-Gm-Message-State: AOJu0YzNRxJxyEOUkHI1B5LD0l11SNEiFJrfugqr7R0XI4iGLyIsok4u
 YtzrMMJqr5q7n14xwv6CDeAWfEIIsMM3b2bP29HrZCTjdPMwLg==
X-Google-Smtp-Source: AGHT+IEAaJGvg07PN9u0gLLT+S3+6hZJAts8Zoa3b8rtuLJbrm1VAKB4F48H0fUShSnzObj4olsmXZpcDEkr946yNwU=
X-Received: by 2002:a17:906:7144:b0:a28:c04e:315b with SMTP id
 z4-20020a170906714400b00a28c04e315bmr15122ejj.13.1704938031874; Wed, 10 Jan
 2024 17:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20231221095258.592275-1-masahisa.kojima@linaro.org>
 <20231221095258.592275-3-masahisa.kojima@linaro.org> <ZYw_UqZ_wj-htZvI@hera>
 <CADQ0-X8fBNDCrWkbZWwxYJaovradmMCM+vDt3DEJF2p9X2fgTg@mail.gmail.com>
 <CAC_iWjKBgezN_R54qsyh+WxcbvU4vRuCvyyNiHB-eQgFabBUig@mail.gmail.com>
 <CADQ0-X_mBLqU-hbTaj9Ukg6pMt==poCZeJ8osX52ka6KQjMYaw@mail.gmail.com>
 <CAC_iWj+Ai8BussULexgUz-JRyuxra=AiCoCaFD8q1x6tE7B_mw@mail.gmail.com>
In-Reply-To: <CAC_iWj+Ai8BussULexgUz-JRyuxra=AiCoCaFD8q1x6tE7B_mw@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 11 Jan 2024 10:53:40 +0900
Message-ID: <CADQ0-X9wbVRZNUhQnQJNz59x=FCAQ9bb0cvhWdvEWjM0c9yGkg@mail.gmail.com>
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

On Wed, 10 Jan 2024 at 18:10, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 10 Jan 2024 at 02:53, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > On Tue, 9 Jan 2024 at 22:02, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Tue, 9 Jan 2024 at 03:00, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Thu, 28 Dec 2023 at 00:14, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Kojima-san
> > > > >
> > > > > On Thu, Dec 21, 2023 at 06:52:58PM +0900, Masahisa Kojima wrote:
> > > > > > This commit stores the firmware version into the array
> > > > > > of fmp_state structure to support the fmp versioning
> > > > > > for multi bank update. The index of the array is identified
> > > > > > by the bank index.
> > > > >
> > > > > Why do we all of them? Can't we just always store/use the version of the active
> > > > > bank?
> > > >
> > > > Sorry for the late reply.
> > > > When the capsule update is reverted, the active bank is back to the
> > > > previous active bank.
> > > > So I think versions for all banks should be stored.
> > >
> > > But even in that case, the active bank should point to the correct
> > > version when the ESRT tables are generated. Wouldn't it be simpler to
> > > just set the FmpState variable accordingly when that happens?
> >
> > The fw_version in FmpState variable comes from UEFI Capsule Header and
> > FmpState variable is set when the UEFI capsule update is performed.
> > If we only store the fw_version of the active bank, the fw_version of
> > the previous active bank is overwritten. When the capsule is reverted,
> > we can not get the fw_version of the previous active bank.
> >
> > Thanks,
> > Masahisa Kojima
>
> Ah yes, that makes sense.  In that case, the patch looks fine, apart
> from the return value of the getvariable call which is never checked
>
>
> > > > > >
> > > > > >       image_type_id = efi_firmware_get_image_type_id(image_index);
> > > > > >       if (!image_type_id)
> > > > > > @@ -372,19 +392,38 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> > > > > >       efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > > > > >                               image_index);
> > > > > >
> > > > > > +     if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> > > > > > +             ret = fwu_plat_get_update_index(&update_bank);
> > > > > > +             if (ret)
> > > > > > +                     return EFI_INVALID_PARAMETER;
> > > > > > +
> > > > > > +             num_banks = CONFIG_FWU_NUM_BANKS;
> > > > > > +     }
> > > > > > +
> > > > > > +     size = num_banks * sizeof(*var_state);
> > > > > > +     var_state = calloc(1, size);
> > > > > > +     if (!var_state)
> > > > > > +             return EFI_OUT_OF_RESOURCES;
> > > > > > +
> > > > > > +     ret = efi_get_variable_int(varname, image_type_id, NULL, &size,
> > > > > > +                                var_state, NULL);
> > > > > > +
>
> We should be checking the return value here.

I will fix it.

Thanks,
Masahisa Kojima

>
> > > > > >       /*
> > > > > >        * Only the fw_version is set here.
> > > > > >        * lowest_supported_version in FmpState variable is ignored since
> > > > > >        * it can be tampered if the file based EFI variable storage is used.
> > > > > >        */
> > > > > > -     var_state.fw_version = state->fw_version;
> > > > > > +     var_state[update_bank].fw_version = state->fw_version;
> > > > > >
> > > > > > +     size = num_banks * sizeof(*var_state);
> > > > > >       ret = efi_set_variable_int(varname, image_type_id,
> > > > > >                                  EFI_VARIABLE_READ_ONLY |
> > > > > >                                  EFI_VARIABLE_NON_VOLATILE |
> > > > > >                                  EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > > > > >                                  EFI_VARIABLE_RUNTIME_ACCESS,
> > > > > > -                                sizeof(var_state), &var_state, false);
> > > > > > +                                size, var_state, false);
> > > > > > +
> > > > > > +     free(var_state);
> > > > > >
> > > > > >       return ret;
> > > > > >  }
> > > > > > --
> > > > > > 2.34.1
> > > > > >
>
> Thanks
> /Ilias
