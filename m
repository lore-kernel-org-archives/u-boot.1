Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4750D17121
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 17:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14CA088D56;
	Mon, 21 Oct 2024 19:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bUJGyYJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A217F88DB5; Mon, 21 Oct 2024 19:57:57 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE59D88D51
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 19:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c94861ee25so2419756a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729533475; x=1730138275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b1ifdON4eh/u5fY3MrqRCTjWGevh8FxLOdp4ppnwvkc=;
 b=bUJGyYJRvcSIsdubyx0eZY6JmUy/L041MS3MLIprXBzF7Zm7cNWX+uEYKtMdPA6h9N
 +XOy3HQDKscP7cwVhoByVYYKi/plKCueMePY61rfkt3JpReWDC+KNzNw12O4N4e2mPmU
 78ZuI5bT9o0V6pcWILUqC/S2qV8a7dYvW5JxRzfMfmC7y4iwXxlcl8kjIGaOqLOki4zW
 zangMLVUbXO94A4CMaZ0eq3CX4+VCLaZOIXKqYphHWZdRiSUveqJ+7g8eenzfyL3u8SO
 zJW+fps7dWARjXdLDJ9JC8ozQUCA3BGgOeeaVkgAYlDp+flKTQoVD6rB5RnAEVQAB2Wp
 t0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729533475; x=1730138275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b1ifdON4eh/u5fY3MrqRCTjWGevh8FxLOdp4ppnwvkc=;
 b=LDyfHDEm94xqNyerhINNcCo43eE2bl1SgVPmxTXAC7OTni7tMuBawP8m7tVKQ6fJxn
 M8XzEjTZUbw6Jpc6k6y4TY9oKqCMr7pUcmJPf2IXQ1ieeuf3H45qd7JbAZBqei5ANFZD
 K4oZeXJAy9U2T0xzf4ZkQvYLMpi/9E+z+D9sDCEZgFldnDEVRSy0NPpmVu81PtPWdt3Z
 O12X041VrZGjZePvhMu1qozufcQ5SeTqPlkDyw+H7e1CV2ukyjOwjSDhIuKNiTv84V6G
 34iGW6uBZzgb8wRbKZA3NMiKo09jIfIysrKPtc7F4g9NRefTb24d5WS1SewIrKRMiS/P
 1UUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHNSSfcqbAgFYZiF+q8prtnNvzMEzLTJ92zbdsFbT25AO+9mfzfYCVwb1mwq4vFS1vmucEK18=@lists.denx.de
X-Gm-Message-State: AOJu0YzDOEZD70QM2/NHr7Zf5meIrr5pMi8DgtHisvVpO0HBMQBctAGA
 S1zyquwiwIIcJhmPK8blH8JeevgwEkvGRFwf1V2FGqFxjnLMORIX05BhOZqrZp3bG9Xlb2zvADN
 N0GRIQ8MSS8tn+kSgPEls3bw2ShU=
X-Google-Smtp-Source: AGHT+IFW1zvlp2HlIOHfjmyNzv7TX3z0W+1p7fBqXXB3xdwmNPwA0PFnWRuImB5wo7HayPPk++WhjmuQdrLp1Af9xqE=
X-Received: by 2002:a05:6402:51ca:b0:5c9:5928:970 with SMTP id
 4fb4d7f45d1cf-5ca0ac61c0bmr14063909a12.19.1729533474949; Mon, 21 Oct 2024
 10:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com>
 <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
 <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
 <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com>
In-Reply-To: <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Oct 2024 18:57:43 +0100
Message-ID: <CALeDE9P04s7uX0Egq+seDbHyn_QXgz+NWPHtJ2W1CGKtATPLsw@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>
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

> > > > Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
> > > >
> > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > Cc: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Changelog v9:
> > > > - default to BLOBLIST_ALLOC on arm
> > > > - Move default for BLOBLIST_SIZE_RELOC up
> > > > ---
> > > >  common/Kconfig |  2 ++
> > > >  lib/Kconfig    | 15 +++++++++------
> > > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > > >
> > >
> > > This is fine, but please disable it for snow since it needs the FIXED
> > > option for now.
> >
> > I cannot follow. What needs the FIXED option and what to disable?
> > I run this patch on the CI and test_py_sandbox tests are still working.
>
> I mean that snow cannot use BLOBLIST_ALLOC and needs BLOBLIST_FIXED so
> if you make ALLOC the default you need to change the default for snow.

Simon by snow do you mean the device (configs/snow_defconfig) snow, I
think Patrick doesn't know you're referring to what I believe to be a
device config.
