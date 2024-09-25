Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66428CCF9EB
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 02:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D74C088C40;
	Thu, 26 Sep 2024 04:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cHMlaRFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7490488B79; Wed, 25 Sep 2024 15:04:33 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C843688BBE
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 15:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso58558525e9.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727269466; x=1727874266; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDD++45rr4z9OpHh7T9S7/W/evwkqFgsBhhHyLXhORs=;
 b=cHMlaRFivnLObkAWnkM4DN7sQRhoNldp7+27BW957mItGyHm+E7TrpVoRiJPEqPdzu
 4KnFJ5fxy+FsLoVvlITW5WhkOzrTAlkCsVedZVvLyvqce0qf6m/mPDIVvek2eL61G3+4
 /jV8yz13ur0jmS7cT/JSUuLYOOB3dAvG2VlLpTnuayoXBlT/7iBYrI6r/McIBsNbVnzT
 mmCxUCoF0nJZ7TDrwTEfMQ3BLN+m02Y1SL0Np//dmlmmgRc9hVIiACxTR+MbfmWYqC22
 ijl9mnJukcSmqYDxmiNSK0b2Vxp8npe1me0HZHEZ6AVS8FhEOLA01EuK4bpebjbnEMeq
 3ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269466; x=1727874266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDD++45rr4z9OpHh7T9S7/W/evwkqFgsBhhHyLXhORs=;
 b=ufVIWsJ67+gfdBoPnrOnPWIERU4QfZgHKFizoyTbedJfnhu0Y/Zn7W8kOcT1BzL34x
 DpocEONI4vDtOEZG/fmSjrG64H2bV5azqBaq1lZKLLUNVFcpcABAOMCCGNHghjX1SFdG
 H2ERd258WJuvWFY+iI5ejYJfPboWr9gVvFBsc/KhmXPy9R0SZKl1RUwILBxfYjELkJuV
 LCtiz/T2fPRxrnBw3Cvwm+h0KNv5EFfggaFHA6oBeig/HMC4V5VDLBbJvVNV/ynzWr14
 CgQXoCKWY7Bk+rtB2x1PawL16rSqkj91JRWUISH6QPb3R90xA4OBKdB2HHTFwjeyJMf8
 thbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWAVV9CjzKEQdTpeCfq9q2wghVduRjhk/PATv05nXX2VDUP2JbEmla5vVsTRbm7reP+PzgnUg=@lists.denx.de
X-Gm-Message-State: AOJu0YwHzCmcjoZEqacS4LzAFShBDoNYCsB7VzVFYz0wxmHV9U7ZUmgk
 aR2gXbU+xUjc3BxDIpbQFcj9C5p9M349Ailo/79jABfDjIt2JPbF8prp1GVXwcetolruZV0n1j9
 v/6RJl3g3AnViy+Va8EafR2TqLsU=
X-Google-Smtp-Source: AGHT+IHn1pvV5x/oNt3LZgMPQSzEbkojqXRVdw9uB0ltNpEjyGBgh5zfEfz/KM16xNDY0NH3ndAcrgb3u04y0EKWcek=
X-Received: by 2002:adf:f14e:0:b0:375:c4c7:c7ac with SMTP id
 ffacd0b85a97d-37cc24ca3f6mr1734527f8f.49.1727269465909; Wed, 25 Sep 2024
 06:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
 <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
 <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
 <20240916162758.GE4252@bill-the-cat>
 <CAPVz0n1krz0GxwEXA+FFr1DHVz-c4R4zm++Ji1KhmBTab9m_2g@mail.gmail.com>
 <20240920164856.GI4252@bill-the-cat> <20240924234406.GX4252@bill-the-cat>
 <CAPVz0n09xf42O1X7QBO8nraDV86EEUOdw+S7qZdr327v0gcQ1A@mail.gmail.com>
 <5f2103ff-cc78-46b6-b008-127678c23592@denx.de>
In-Reply-To: <5f2103ff-cc78-46b6-b008-127678c23592@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 25 Sep 2024 16:04:12 +0300
Message-ID: <CAPVz0n3cH5_1iK+0PSW1mBFKQz13Z0DKJyi6GdsGpPQpvBQ7mg@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi <matteo.lisi@engicam.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 26 Sep 2024 04:47:21 +0200
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

=D1=81=D1=80, 25 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 15:48 Mare=
k Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 9/25/24 12:18 PM, Svyatoslav Ryhel wrote:
>
> [...]
>
> > Hello there!
> > I was digging this when I had some free time and found that with
> > patches from Marek the only difference is that function
> > i2c_get_chip_for_busnum is not called for PMIC's main i2c address
>
> Is it possible this is called earlier, before UART output is
> initialized, so it does not show up in the log below ?
>
It is highly unlikely, this function is called when uart is already
working and pinmux is set.

> Could it be that it is called before your pinmux is properly
> initialized, hence no UART, and that is why the I2C communication fails?
>
But if we assume that pinmux is not set, then how we resolve situation
when pinmux and regulator enable are both set by probe after bind and
regulators are probed before pinmux. Regulators will fail, they will
not deffer till pinmux probes. Or you propose return to pre-DM version
of pinmux? Inconsistency.

> So far, I only found Toradex Tegra T20 board here, no T30.
What do you mean? Specify please
