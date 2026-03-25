Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CA8109C04D
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 17:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60D71838BB;
	Wed, 25 Mar 2026 18:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jbPuQwKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5681C838BB; Wed, 25 Mar 2026 18:56:41 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B81A80077
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 18:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-668d9dba217so107572a12.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774461398; cv=none;
 d=google.com; s=arc-20240605;
 b=OMausVs9r29NtjXhDkwlzrWD+Ub7CG4tBC+k7KqCQ4b7ffRNYJCpcddrF5U2jZ9+ml
 ypE+y+YEQ2XalSpyTatcvUDRRZ1izzeL+mq5ijOFCUoSxEqJUr2mxQaPGaKymFD0ySzD
 JfVKba0reQ65B/zobZ6DiWMFNme6mFUb6jnYNLdD4gqcZBO8eXJUbi1f1lvD6H7CzJRP
 cixnQFKWcQP4c97+DJ1yVdsaEnFF8kG83JTLIcE0K2FzfRZXj3LNhikZxbsbr6c5eOOP
 MqwMzTIPpQcDrZ6PMkhg5r44htVorqhBcAlI2YKRonDDjZCKyrP3/YuNWTV5lD1kE5Yd
 yrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yaadQfrj0Bg18mtrQ1KiiZNxrWEXRPjLqFxP7YvLTk8=;
 fh=guwS4J7GZFIGvIlsDVIdVCoQAsgOEMPkxhS89hCiWqE=;
 b=JAa9AAfsRc6tGszacP5hSMm0h4axA3yajNwNdbANxNEW4kvwYhgJJrTK4jaF5RCpGi
 UPl2/71hfY1YtjM9APW3J90idjEg059f/2Ieo+gZx42pkg2dzE8jf7i90xC2yzH/VpZV
 P7RWG0xMi9Nr97l+EcC8xyOhRuGAhPxt2fm4I9C5Ug/KRDdUvEMSW90tDYmpNiiw4Qof
 lVczwrusDcJR2Njmx/WEzkuUw6vWC7CfUgh8S+CiH/knbgHhXuSRCN6hz9lwox5+hkXs
 gFHdTBWqUYiEAycbMw3YUOJBz5bAUdu0AE57H5Z3qXlhDZfqBt9C9SMHBuAMefsEnW1t
 vSLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774461398; x=1775066198; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yaadQfrj0Bg18mtrQ1KiiZNxrWEXRPjLqFxP7YvLTk8=;
 b=jbPuQwKEcxN6RB+patDCOR1XT6oCRgEfoJuj0ZoWlO9Yi1EisL5xk9vy9kZcVT7GhU
 rX4X97IBNK3vlzT/SCQilSlGEzzHVcbtAJx0bV+cTHIBM+F9FFn3Ob+9PdYqllo9gVkO
 MqxAJtMQXO3EbY1ZksmecZCkBfqMU9gTpaxhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774461398; x=1775066198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaadQfrj0Bg18mtrQ1KiiZNxrWEXRPjLqFxP7YvLTk8=;
 b=bvbLKcxIEDRFWggAtmCZhHdeKyBRfO0fepxMrh3FAy1M0iMhvA2eC7xgRjQ04AAnZt
 Gooxj1fk+Osv4+6YnnzcFJenqXSsE/5No5MVok5eg3tmyz3SDjHX4GcgjjQ815b7efes
 aArYe8+XJivEcNrjKo4Lcinldm7EzZVAZ707YKJ2C89b4QB5Sz8YOtDxHFLO3wJwmG+L
 Hid+/N1/R5NU3iU3kgTRhHaauIjwV5P6UR/N0EAbiDt21pWUvai5u+vtJoP8dSXdA/63
 p8F15jPzVWsHy6Mfrk2XsRWZGxIvDDPceLw8OPt0zeT0kevtv1AqsWUycvvipXvgOq4F
 92mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtVcap2tIxZas6NUs//FUhnDmCYVVqJc5BIysRtEgh/37SGD4P/8ybSGUkssyq/Ddw0BlBsBE=@lists.denx.de
X-Gm-Message-State: AOJu0YxuPA5GAym4RECbLXJ22jl73y15ABFwIhVSgE2muCuCOgTLOLjp
 0y8i4YI65AKvy4VE5qGEpjzm4LiLhQFcBTTj5egB9Zr9VLATjdbSnyrfFKbhjfDMzwkuN6Qxcb9
 DFctYIhONutqlXTWfW1bJF+WQM1QwPzhz6w3GviYw
X-Gm-Gg: ATEYQzzaZr5AiOKoiB3wAr3q15de//BLj0T5M4uV2yn/UR2wqBqXgSD1nwJhnlq9J4l
 RgUxSDtwHFlHDeI5vzMaxTmq3NrfSqAo4k/rlvRDFrhTTzWhftO0jI/9oikJAwFkD3i0JdAKrCT
 cHJqCqr/chhEQBurnB5LBsyUML6FqY3cSZ3PYvvB776DmrOwmO6E+Fix/Jy3+25/uDmfMBC0a7Z
 cAk+t7ykWPUGwVgmrt54rNicQ79iQD0nDWcwxYhaP0xq5WqqLe2Tufw6DHowqT+iJfaTRAwWQWI
 x5KPhTM=
X-Received: by 2002:a17:907:c08:b0:b98:6984:661c with SMTP id
 a640c23a62f3a-b9a3f14900fmr322636966b.10.1774461398470; Wed, 25 Mar 2026
 10:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260320214518.GD502704@bill-the-cat> <acPEoC0W8DJMnYfd@shlinux89>
 <20260325165231.GS502704@bill-the-cat>
In-Reply-To: <20260325165231.GS502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Mar 2026 11:56:25 -0600
X-Gm-Features: AQROBzDvDIrOdgNHyQk5e4_AUjdN7pZIw6TX_--6ps8OUoyfwP9eDSOa_iNcn00
Message-ID: <CAFLszTjJG9Gj7Q+31sypFBRnS3g4NYT+0-t06dxQMsw8ekJMSg@mail.gmail.com>
Subject: Re: U-Boot and legacy SPL power control on modern platforms
To: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, u-boot@lists.denx.de, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Teresa Remmet <t.remmet@phytec.de>, 
 Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Heiko Thiery <heiko.thiery@gmail.com>, Marek Vasut <marex@denx.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, upstream@lists.phytec.de
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

Hi,

On Wed, 25 Mar 2026 at 10:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 25, 2026 at 07:18:56PM +0800, Peng Fan wrote:
> > Hi Tom,
> >
> > On Fri, Mar 20, 2026 at 03:45:18PM -0600, Tom Rini wrote:
> > >Hello,
> > >
> > >As part of the work I've been doing on clarifying Kconfig dependencies
> > >I've stumbled on to a number of modern boards[1] that are using the
> > >SPL_POWER_LEGACY symbol. Can the maintainers please update these to use
> > >DM_PMIC, DM_REGULATOR (and SPL variants) as needed so that they use the
> > >modern architecture, or let me know what's missing here? Thanks!
> >
> > For i.MX8MQ, I think we may need to leave with SPL_POWER_LEGACY,
> > the board has 256KB TCM, but u-boot-spl-ddr.bin is almost using all
> > of them if enabling SPL_DM, other SPL_OF_CONTROL and other DM drivers.
> >
> > u-boot-spl.bin itself is 90KB+, but ddr firmware and hdmi.bin are packed
> > in u-boot-spl-ddr.bin, the image is a bit large.
>
> Ugh. Does CONFIG_SPL_OPTIMIZE_INLINING=y win us enough space here to
> matter? Changing CONFIG_SPL_LOGLEVEL rarely is enough of a win to
> matter, so I don't think that'll help. Turning off CONFIG_MMC_VERBOSE
> sometimes helps, but only a little.
>
> If we really can't make it all fit, then renaming some options needs to
> be done once we remove the legacy portion from full U-Boot (of which
> there's a much smaller number of semi-modern platforms enabling it).
> Thanks for checking on this.

It is pretty ugly, but there is of-platdata

Regards,
Simon
