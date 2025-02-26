Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31535C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 08:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419F5801DE;
	Wed, 26 Feb 2025 09:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pUYjA7/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F1F38081A; Wed, 26 Feb 2025 09:55:09 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C436180077
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5dcc411189so5907497276.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 00:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740560105; x=1741164905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CJtzXU1YM1JrQ5JzquPJxh2f06GK5hjv6IhOgoamtPA=;
 b=pUYjA7/MoaZcQOzqjNFKIOydA30pa7QnlFkBJf+WR/lyKNWKkJz8sZpEpzzK0E4rxo
 JeFU3wDxThIQAkycwU5uKdrVlX6ATR7iC9EZYlraiZIqtzPV/KWNI1d29bIrpOq5leKF
 DmO5/LR6Fd4I/Gvqrce2LVB0Aopwqq93v10DJ7ajdpKbb7WSQEIivq29Ahhlf/aCGF62
 bT5WOLNdoo/mjm7BDQFDSEh4CgPLsBj+X9ELE9kUbjN2ytHBd4mYphv49/eWf5zKfpdR
 pmIfYj1Hy16+f9CG8iF0cZw8WkZJpA3M90Y1ukauIpe92DtKFmfEpVVyHpbz5jVoFNjL
 B+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740560105; x=1741164905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CJtzXU1YM1JrQ5JzquPJxh2f06GK5hjv6IhOgoamtPA=;
 b=nDfR3MHJ9T/cbixYHi8wSgRtrRYcXlQvM3e0Fq2q2Vopwwjb6OKm1G+P2CCXVMu73h
 6x0FvdTcUwWQPV0eHmUmiFveIpbjgLguP28R2stfXyueOWqqIEeeEQCBsgh9vE8vKo2c
 MBuDFAKPolZnzQ7rpmF9DOZ6qqf9FgHFZkl/7gYBXYcNHfOTW53xhgXe9ScG0KS/q+qM
 OJmcIaUHfepkVxHRpJkrydfQkZtBe8wA92TBIIc8OVEOgJcIAo9G+doyfl60n7RIkgMr
 SvjUewqnoEIBSGCrth0pj8RkG+WMxnCVQ0RYsiIuumeD6S6Z5CYEdUo5UMspMw4iQ56Z
 cF8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmZJFe/LGZepVgTZ6DkNb0I+bIehvnBRlXyKoy0UONrbn9AUrKwUt5mXq0fbQEyCXVTbLvbVk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjr1+VfdO/9PW9vzixu07AO0XFGXge+QgELa4K6XPbYH5kXkkH
 EdLYfJrus/T7r/4tdbs9fZ4hOR4YYk7pOr1l85Fxn1Ix23zR831p6FBukZDpxOD0caCoyUFNLrd
 GmqXdARTcugNX4tsGdlr3uSYotKkbLRD4mqvuvg==
X-Gm-Gg: ASbGnculkY2HdgSmAT+S8Y1RfLnE8EJOS+0fmHFWUUnqX7ZgTl9O4XiLwF3oCaYcFPP
 2XU9xrB69hDoT5Bv02JqAZHYJJYZr/lAgtarcEBmKXmnjGGsm5wEhY1LGetW1RWIseI0sSeEEqo
 daHsAXvAOE
X-Google-Smtp-Source: AGHT+IEGwNQSBaQAB/3UmaVTwHQGmYJyNO+tohkya/PQxSmmYpitedXOylszO4328Ic6Ca6qxgNS4qvPK69ihsr2Z4I=
X-Received: by 2002:a05:6902:cc9:b0:e54:9cb1:21a6 with SMTP id
 3f1490d57ef6-e607a4f2658mr5065134276.11.1740560105540; Wed, 26 Feb 2025
 00:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20250213195351.3518305-1-j-humphreys@ti.com>
 <20250213195351.3518305-3-j-humphreys@ti.com>
 <Z7Q8t2lCXjikVSm0@hades> <86tt8knk2x.fsf@udb0321960.dhcp.ti.com>
In-Reply-To: <86tt8knk2x.fsf@udb0321960.dhcp.ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Feb 2025 10:54:28 +0200
X-Gm-Features: AWEUYZlnWPgzfm6bI1XCdeQpYRoTawjV1rHbAl5u7LnFuYmkMXGtGSk9vSRt35U
Message-ID: <CAC_iWj+TRuaHX+_rxmkJvRMgebvWQ5act5P-tpsrJmN8W3mu3A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] efi_firmware: set EFI capsule dfu_alt_info env
 explicitly
To: Jon Humphreys <j-humphreys@ti.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Udit Kumar <u-kumar1@ti.com>, 
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Daniel Schultz <d.schultz@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Lukasz Majewski <lukma@denx.de>,
 s-vadapalli@ti.com, u-boot@lists.denx.de
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

Hi Jonathan,

Apologies for the late reply

On Mon, 24 Feb 2025 at 04:38, Jon Humphreys <j-humphreys@ti.com> wrote:

[...]
> >> +
> >> +    ret = fit_update(image);
> >
> >> +
> >> +    if (env_set("dfu_alt_info", orig_dfu_env)) {
> >> +            log_err("unable to set env variable \"dfu_alt_info\"!\n");
> >> +            ret = 1;
> >
> > This will work but for consistency just use an EFI defined error e.g
> > ret = EFI_DEVICE_ERROR;
> >
> >> +    }
> >> +    free(orig_dfu_env);
> >> +
> >> +    if (ret)
> >
> > I am not 100% sure this exiting here is useful. If fit_update has succeeded
> > we have updated our firmware. So I think we should just add a warning here,
> > that resetting the dfu to its original value failed, and any further dfu
> > ops will fail.
> >
>
> Hi Ilias, thanks for the review.
>
> The exit here is for either fit_update() failing OR we cannot restore the
> original value for the dfu_alt_info variable, so it is needed, at least in
> the fit_update() failure case.
>
> I was trying to keep the control flow simpler by handling the 2 failure
> events together. Are you wanting to separate the 2 failure conditions, and
> return EFI_DEVICE_ERROR if fit_update() fails, and emit a warning and
> return EFI_SUCCESS if restoring the env variable fails?

Yes, I think it's better

Thanks
/Ilias
>
> Jon
>
> >>              return EFI_EXIT(EFI_DEVICE_ERROR);
> >>
> >>      efi_firmware_set_fmp_state_var(&state, image_index);
> >> @@ -717,6 +734,7 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
> >>      u8 dfu_alt_num;
> >>      efi_status_t status;
> >>      struct fmp_state state = { 0 };
> >> +    char *orig_dfu_env;
> >>
> >>      EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
> >>                image_size, vendor_code, progress, abort_reason);
> >> @@ -747,8 +765,23 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
> >>              }
> >>      }
> >>
> >> -    if (dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
> >> -                         NULL, NULL))
> >> +    orig_dfu_env = strdup(env_get("dfu_alt_info"));
> >> +    if (env_set("dfu_alt_info", update_info.dfu_string)) {
> >> +            log_err("unable to set env variable \"dfu_alt_info\"!\n");
> >> +            free(orig_dfu_env);
> >> +            return EFI_EXIT(EFI_DEVICE_ERROR);
> >> +    }
> >> +
> >> +    ret = dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
> >> +                           NULL, NULL);
> >> +
> >> +    if (env_set("dfu_alt_info", orig_dfu_env)) {
> >> +            log_err("unable to set env variable \"dfu_alt_info\"!\n");
> >> +            ret = 1;
> >> +    }
> >> +    free(orig_dfu_env);
> >> +
> >> +    if (ret)
> >>              return EFI_EXIT(EFI_DEVICE_ERROR);
> >>
> >>      efi_firmware_set_fmp_state_var(&state, image_index);
> >> --
> >> 2.34.1
> >>
> >
> > Thanks
> > /Ilias
