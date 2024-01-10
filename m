Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B915BC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2AF87B03;
	Wed, 10 Jan 2024 10:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cBHpy2kc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0BA87AD3; Wed, 10 Jan 2024 10:10:57 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7B78797B
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e759ece35so4336206e87.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 01:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704877854; x=1705482654; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bR0FLKjdW/DQnvSR3BoqjWNLByy8bv78w5zZj3m5USQ=;
 b=cBHpy2kcVdSs1R15pvv+qBlppZsEr4AckxiidocpkS9P2eJ6j4JmBLezBuoGb4yhU8
 W5uuWOtFF/7UWrXZKkHj05E8dshDK81oTmz9cD5OyKcJm+izK1bEvZW0esV4HurliZPf
 1d7BRHrTuajoT1M1rn9qOZXhMebnRyMsZmrYuV0HP/VjmHUIKQF6cPHUspDQZGB0H7me
 51RUQAmz8l2VyhVIRBzGwURED2pF5eE19/sEnc7fyc2LKEv20qLFXNibpzcilT5aKb9q
 gAAjMwcGGEdnoFb8gP/FewSw2ethdrRPYdbKn3tJ4x2kK/myI3tixTv2HxES45HGODfU
 Oazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877854; x=1705482654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bR0FLKjdW/DQnvSR3BoqjWNLByy8bv78w5zZj3m5USQ=;
 b=rm5AOiZNweBBjiQh+YsakwbjIrUgTMiVepJdFA0VJTWy6TBQCtgCBxhES6xmZHP4YW
 xP0jlWd9DhYQgarJK3kBYu4JjPzv3YsWqGCbzQTox1nGwovSJEKLc8udXZvHsXjjPIOA
 3rg7e/G9W2vo6+1n4+L67vP9AxHg/QAqG7H7xe4+q3RSa6cdKrKCJUbwtco+VlBY68vH
 ic4JatTeJL8pFD7znepQsAQ4r6pgP+3NsXDCoU+Y1CWKbh4DcaOUZVHw4fDP2iC+rsH3
 9PuWTSosJKoJmOYrIcuAs1eLzrju3CWLy9PXb2xIClhF1ceJiINU5TDplLWDvsEDc5XO
 Dl7w==
X-Gm-Message-State: AOJu0Ywh1bHui71mURgYoTwSCXcRYRQoIJRaAR0PftZ6qUi+WP8jNJEl
 xiJvnBoJDtaQQ5hT+ukDUz0psOl2FPKGUEv5neZTCg+8E8Qosg==
X-Google-Smtp-Source: AGHT+IGXKm+iDu7iknMWL8WaDKeSiFwstlJYBxbq1f82jrU+o19ZoZ6Cu+q872TRe0b53py0ShgBm3SNl2y+s7m0tvw=
X-Received: by 2002:ac2:4a78:0:b0:50e:ac2a:6b59 with SMTP id
 q24-20020ac24a78000000b0050eac2a6b59mr204900lfp.120.1704877853849; Wed, 10
 Jan 2024 01:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20231221095258.592275-1-masahisa.kojima@linaro.org>
 <20231221095258.592275-3-masahisa.kojima@linaro.org> <ZYw_UqZ_wj-htZvI@hera>
 <CADQ0-X8fBNDCrWkbZWwxYJaovradmMCM+vDt3DEJF2p9X2fgTg@mail.gmail.com>
 <CAC_iWjKBgezN_R54qsyh+WxcbvU4vRuCvyyNiHB-eQgFabBUig@mail.gmail.com>
 <CADQ0-X_mBLqU-hbTaj9Ukg6pMt==poCZeJ8osX52ka6KQjMYaw@mail.gmail.com>
In-Reply-To: <CADQ0-X_mBLqU-hbTaj9Ukg6pMt==poCZeJ8osX52ka6KQjMYaw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 10 Jan 2024 11:10:17 +0200
Message-ID: <CAC_iWj+Ai8BussULexgUz-JRyuxra=AiCoCaFD8q1x6tE7B_mw@mail.gmail.com>
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

On Wed, 10 Jan 2024 at 02:53, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> On Tue, 9 Jan 2024 at 22:02, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Tue, 9 Jan 2024 at 03:00, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Thu, 28 Dec 2023 at 00:14, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Kojima-san
> > > >
> > > > On Thu, Dec 21, 2023 at 06:52:58PM +0900, Masahisa Kojima wrote:
> > > > > This commit stores the firmware version into the array
> > > > > of fmp_state structure to support the fmp versioning
> > > > > for multi bank update. The index of the array is identified
> > > > > by the bank index.
> > > >
> > > > Why do we all of them? Can't we just always store/use the version of the active
> > > > bank?
> > >
> > > Sorry for the late reply.
> > > When the capsule update is reverted, the active bank is back to the
> > > previous active bank.
> > > So I think versions for all banks should be stored.
> >
> > But even in that case, the active bank should point to the correct
> > version when the ESRT tables are generated. Wouldn't it be simpler to
> > just set the FmpState variable accordingly when that happens?
>
> The fw_version in FmpState variable comes from UEFI Capsule Header and
> FmpState variable is set when the UEFI capsule update is performed.
> If we only store the fw_version of the active bank, the fw_version of
> the previous active bank is overwritten. When the capsule is reverted,
> we can not get the fw_version of the previous active bank.
>
> Thanks,
> Masahisa Kojima

Ah yes, that makes sense.  In that case, the patch looks fine, apart
from the return value of the getvariable call which is never checked


> > > > >
> > > > >       image_type_id = efi_firmware_get_image_type_id(image_index);
> > > > >       if (!image_type_id)
> > > > > @@ -372,19 +392,38 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> > > > >       efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> > > > >                               image_index);
> > > > >
> > > > > +     if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> > > > > +             ret = fwu_plat_get_update_index(&update_bank);
> > > > > +             if (ret)
> > > > > +                     return EFI_INVALID_PARAMETER;
> > > > > +
> > > > > +             num_banks = CONFIG_FWU_NUM_BANKS;
> > > > > +     }
> > > > > +
> > > > > +     size = num_banks * sizeof(*var_state);
> > > > > +     var_state = calloc(1, size);
> > > > > +     if (!var_state)
> > > > > +             return EFI_OUT_OF_RESOURCES;
> > > > > +
> > > > > +     ret = efi_get_variable_int(varname, image_type_id, NULL, &size,
> > > > > +                                var_state, NULL);
> > > > > +

We should be checking the return value here.

> > > > >       /*
> > > > >        * Only the fw_version is set here.
> > > > >        * lowest_supported_version in FmpState variable is ignored since
> > > > >        * it can be tampered if the file based EFI variable storage is used.
> > > > >        */
> > > > > -     var_state.fw_version = state->fw_version;
> > > > > +     var_state[update_bank].fw_version = state->fw_version;
> > > > >
> > > > > +     size = num_banks * sizeof(*var_state);
> > > > >       ret = efi_set_variable_int(varname, image_type_id,
> > > > >                                  EFI_VARIABLE_READ_ONLY |
> > > > >                                  EFI_VARIABLE_NON_VOLATILE |
> > > > >                                  EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > > > >                                  EFI_VARIABLE_RUNTIME_ACCESS,
> > > > > -                                sizeof(var_state), &var_state, false);
> > > > > +                                size, var_state, false);
> > > > > +
> > > > > +     free(var_state);
> > > > >
> > > > >       return ret;
> > > > >  }
> > > > > --
> > > > > 2.34.1
> > > > >

Thanks
/Ilias
