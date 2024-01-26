Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1104CC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 11:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B6E287C10;
	Fri, 26 Jan 2024 12:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rKW3cBW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA35887C08; Fri, 26 Jan 2024 12:36:59 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DA587808
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 12:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55a86795a3bso172572a12.1
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 03:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706269017; x=1706873817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=odWHHLOAfKoziKxHV7BnTgdbKf83b1odaSGj6R93j48=;
 b=rKW3cBW3+R7T8hy2tO8Q/Ot3y4y/RVZr9LSQtqdjxTYq1e4Ua1acf65Mtl4W2oJslD
 r7Q5PMoKdLFDLddMMMy1ir9tzyzvpVmtfpoR8Q+Ay0vVFDrsauxveoP0HRyt4hP5b6Vq
 A2kJqldpi6hLoRZmi7kIqBE7iV2XcHaBBGC4OB44kNE83xzoPk+Oi6+JoMstourzpwbO
 wkimN6QN1Ubne1reMveYIkC9HbGTIm/ajYm+pgBMVA0bzCuYZOeJ91gVKtca8p1y3oIx
 J++GNdZrqPqWgCS8kKWwmoHnKFEF+0C5UEb80JoZLmCYjqPQwETkQ5oS6FW42VhBslQg
 9plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706269017; x=1706873817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=odWHHLOAfKoziKxHV7BnTgdbKf83b1odaSGj6R93j48=;
 b=PNKwV+1ogh49EQENIgpnRk9UyBRJTRz7E0Pxnpcbzxq1Q1CjWjh9sb3fxJMtarnZwG
 frCoqKI7xBn4es6wYcobAABRYMy6DjeK0SqcEVTVNrXXjjZhxj1yz+VfD6lIeOMDiHYn
 cTm0BI8X3e4Nesm9cB+M2Fld9R3+ot/BLX+LCC4tv4FFLkJXz3BESqHZhepGD4r8W0qJ
 jQqDlgAOYq2lHx9YlwXKvM0rrjlwQpF0zDdll6Blsqxsf/1RdKX/XJaMQE5TwscvD+Lc
 0x043vT2Nc/8/KWK9p5QPXJo1W+FFv6xbCR60KOlJxE3nFshrWD/1LhR4m3wayTL+NCO
 duiw==
X-Gm-Message-State: AOJu0YwRF+6cltScdVHbv5FFBunAQLcQLbD1uOrNEJi8D5V2M2YI0nGo
 N1BKhOq7oDYr5IuiaFBda7eeeQh9ftxo6gBgncbTDViWEcocpSFqsWtEYLU23C4buJG8xa/HnYL
 Tmtv41wgXCfLZ1Cftt53uSk0rNFCR5QJjnYOq7mlnsCH5/LbT
X-Google-Smtp-Source: AGHT+IHBY80ZhcQJJI6Uho1OTdOzGdQhfH5s1DPK4S6kDJOJOZJ3wnt5AE6G3eMkUlDvE05Rux26gfUXHPoUFG8QhJM=
X-Received: by 2002:aa7:d607:0:b0:55d:2f63:8b33 with SMTP id
 c7-20020aa7d607000000b0055d2f638b33mr446763edr.1.1706269017002; Fri, 26 Jan
 2024 03:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20240122072617.1104227-1-masahisa.kojima@linaro.org>
 <5da90978-3d5d-4458-b2c9-476a7e390406@gmx.de>
In-Reply-To: <5da90978-3d5d-4458-b2c9-476a7e390406@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 26 Jan 2024 20:36:44 +0900
Message-ID: <CADQ0-X8mRuLnG132hhNr4tZF+9neb=8wjrjBXbJ_bx8LfdhL2w@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: check efi_get_variable_int return value
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Fri, 26 Jan 2024 at 16:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 1/22/24 08:26, Masahisa Kojima wrote:
> > efi_get_variable_int() may fail, the buffer should be
> > cleared before using it.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > Addresses-Coverity-ID: 478333 ("Error handling issues")
> > ---
> >   lib/efi_loader/efi_firmware.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> > index 9fd13297a6..fb83fa8113 100644
> > --- a/lib/efi_loader/efi_firmware.c
> > +++ b/lib/efi_loader/efi_firmware.c
> > @@ -407,11 +407,11 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> >       /*
> >        * GetVariable may fail, EFI_NOT_FOUND is returned if FmpState
> >        * variable has not been set yet.
> > -      * Ignore the error here since the correct FmpState variable
> > -      * is set later.
> >        */
> > -     efi_get_variable_int(varname, image_type_id, NULL, &size, var_state,
> > -                          NULL);
> > +     ret = efi_get_variable_int(varname, image_type_id, NULL, &size,
> > +                                var_state, NULL);
> > +     if (ret != EFI_SUCCESS)
> > +             memset(var_state, 0, num_banks * sizeof(*var_state));
>
> Hello Masahisa,
>
> We allocate var_state with calloc(). So it is cleared before we call
> GetVariable(). Do we have an implementation of GetVariable() that would
> fill it with data before returning an error code?

No, current GetVariable() implementations do not fill the buffer
when GetVariable() returns an error.
This is why my original implementation does not clear the buffer in
case of error.

Anyway, I agree with your previous comment.
I think it is better to clear the buffer in case of error for safety,
because UEFI spec does not say GetVariable() will not fill the
buffer in case of error.

Thanks,
Masahisa Kojima


>
> Best regards
>
> Heinrich
>
> >
> >       /*
> >        * Only the fw_version is set here.
>
