Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75FFC47258
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 02:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21AE787BAD;
	Mon, 29 Jan 2024 03:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jUISSsKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9C7387BCB; Mon, 29 Jan 2024 03:22:51 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7FA862DA
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 03:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cf2fdd518bso17764271fa.1
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 18:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706494968; x=1707099768; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SDAMVeWqIjHRK/oQKKH0OFg1fblTfXuOLP63f3JQkuo=;
 b=jUISSsKatDGxV4xRUR1g6nD5t1DGYWMud6lDrNbxOFt74tpwOH6+CS5CJJZinvDp/4
 LWPKDY7bBTouV/BU5rCjL9Qf7EqCC1BeRJrDW0Hw8ldBz3Wj0FUWO+vC6dtOziisBpru
 L86LhzQoptPr8m1Tz7IfVgcL2B7mFwuykNMDVkgWylJu4usjM91laYgCdOqboMoqYtRJ
 DIY8PWW8jJt/OWn3+zbbmiqvLiY+m/7fA8HBE1sNvRYnhcrVJ2avHFmgXeovbQnV+aLq
 8mcIJ5oAa5wnZUEFJ7kZXJ7hCaDPsKu3MJzXPi7XcnM6PX8S4urfQg5q2Cru8YVwHtHm
 SAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706494968; x=1707099768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SDAMVeWqIjHRK/oQKKH0OFg1fblTfXuOLP63f3JQkuo=;
 b=eX3On4T9lvXyV6cjz4P4+ll8X7BlLixl9ksFK92gz/1mlPxoxvwJhiYrcQ9XFMUWkl
 mmO9UFBQzqGn+72DyIxnH8Z+nYBAf5NdhaGAEicoT5frvBACzBm898uGn/SR0nwe3AN3
 iHVsccCToTrwXXPJSNV4orBHtTk4Fc6/3eHMh3soflp+RSHy3KJhuhXC+mLM2CR/XUuh
 NjyKAHzlRKlztEV0JDyccVSdBIlasI7kodjxHGsRPh2uOwRJLwQCzKn8oyg8ZDNnVvLK
 ieBMFshcyUIxKfdd9j3cg2ZaLtbz+ImJ78PgW56pa5sBVYjBiKRwKvgmxz7SlPUYutD8
 dgRw==
X-Gm-Message-State: AOJu0YwyT/KQiwn76TcmeNuonK65C5727XY9lc5E8C61uttKLe1nzuJM
 N2yqRIWcwRImf3fMIJgImzmKsi59B+MuBx87snEin1DVxqaeMF7LQxn9OZ6i1gSti8zokWowdeF
 7xViBKMNcI/6wpUI7K55q3SkUZUQMM5BWlbRIKg==
X-Google-Smtp-Source: AGHT+IFKlJ3tFhHX6KDZwHQ6LL/OkmWg2tjxYgb5hcaZ7h6dIs4HihsToVKU6KupXl0f6meQjuRduAyQaMucLkFjB18=
X-Received: by 2002:a2e:87c4:0:b0:2cc:830f:69f8 with SMTP id
 v4-20020a2e87c4000000b002cc830f69f8mr2542096ljj.11.1706494967927; Sun, 28 Jan
 2024 18:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20240122072617.1104227-1-masahisa.kojima@linaro.org>
 <5da90978-3d5d-4458-b2c9-476a7e390406@gmx.de>
 <CADQ0-X8mRuLnG132hhNr4tZF+9neb=8wjrjBXbJ_bx8LfdhL2w@mail.gmail.com>
 <f5dc6d03-985f-4ab3-a6fb-eaa87593d630@gmx.de>
In-Reply-To: <f5dc6d03-985f-4ab3-a6fb-eaa87593d630@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 29 Jan 2024 11:22:36 +0900
Message-ID: <CADQ0-X_1T9ZrvFKpxXGXYzPPixeWF64m7AB1Z1A5Yh=MqnVrzQ@mail.gmail.com>
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

On Fri, 26 Jan 2024 at 21:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 26.01.24 12:36, Masahisa Kojima wrote:
> > Hi Heinrich,
> >
> > On Fri, 26 Jan 2024 at 16:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 1/22/24 08:26, Masahisa Kojima wrote:
> >>> efi_get_variable_int() may fail, the buffer should be
> >>> cleared before using it.
> >>>
> >>> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >>> Addresses-Coverity-ID: 478333 ("Error handling issues")
> >>> ---
> >>>    lib/efi_loader/efi_firmware.c | 8 ++++----
> >>>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> >>> index 9fd13297a6..fb83fa8113 100644
> >>> --- a/lib/efi_loader/efi_firmware.c
> >>> +++ b/lib/efi_loader/efi_firmware.c
> >>> @@ -407,11 +407,11 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
> >>>        /*
> >>>         * GetVariable may fail, EFI_NOT_FOUND is returned if FmpState
> >>>         * variable has not been set yet.
> >>> -      * Ignore the error here since the correct FmpState variable
> >>> -      * is set later.
> >>>         */
> >>> -     efi_get_variable_int(varname, image_type_id, NULL, &size, var_state,
> >>> -                          NULL);
> >>> +     ret = efi_get_variable_int(varname, image_type_id, NULL, &size,
> >>> +                                var_state, NULL);
> >>> +     if (ret != EFI_SUCCESS)
> >>> +             memset(var_state, 0, num_banks * sizeof(*var_state));
> >>
> >> Hello Masahisa,
> >>
> >> We allocate var_state with calloc(). So it is cleared before we call
> >> GetVariable(). Do we have an implementation of GetVariable() that would
> >> fill it with data before returning an error code?
> >
> > No, current GetVariable() implementations do not fill the buffer
> > when GetVariable() returns an error.
> > This is why my original implementation does not clear the buffer in
> > case of error.
> >
> > Anyway, I agree with your previous comment.
> > I think it is better to clear the buffer in case of error for safety,
> > because UEFI spec does not say GetVariable() will not fill the
> > buffer in case of error.
>
> In this case I guess malloc() is good enough. No need to use calloc().

OK, I will fix it.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
> >
> > Thanks,
> > Masahisa Kojima
> >
> >
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>>
> >>>        /*
> >>>         * Only the fw_version is set here.
> >>
>
