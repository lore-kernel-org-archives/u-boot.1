Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBA0C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 23:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4FF782D17;
	Thu, 17 Apr 2025 01:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lV2PfRiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52AED82DB4; Thu, 17 Apr 2025 01:14:56 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF7A82B3F
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 01:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30c091b54aaso1558571fa.3
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744845292; x=1745450092; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bSvH6izHixUOev+07Yko1Cf88I69nuZqMjgXKPvxzo=;
 b=lV2PfRiY8kZVY2bl4zqWQDCnZ1J2bsfyHLq7BhwAtzkZkVK+EgGvqPkrtWmvxFRNQl
 jubNasDrJ+ZDInp5SrD1fh4g/Eo9KwxCjFxZggu7qyfFPW3rKwWpAVJAg7PkV4oI+kc1
 +C4fBL8S5tpFUz5L9FJev1n+jXkcAUZhh7pwDiCTZSDlUBLGI2yv2xYwQQCjZY8uVVeS
 cwaUaSCbro+TH4TRNZk6TjsyGdJfTcy794b6zpec6jdBBgdeb24bi0Stx8gkqXWQTeFN
 MJuqPdy278e0ObEInkGNk5cg+OJiofTNZafWC+bT7gnArmaA8uPRqYybEUKVXBzG5R/n
 Bddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744845292; x=1745450092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bSvH6izHixUOev+07Yko1Cf88I69nuZqMjgXKPvxzo=;
 b=n9Qay2qRp3/YqaPiO7sPea1fUcBPuzjLZgJY3ZpTihq+XmepMzRP5Vg6IjmkLt4QO6
 PVlQaDV4vR2vf62m5SW5ab4CWtFszk9NPewo+Q2Me0fQkgDwQIxjhlV4eYSvGGj19XG/
 cEAY3cEsPWS6z+Db2ZWdD4bIm/zaeQXqX5CbAIzOKYGyxA/172rfnzAFRxoDbCfsl14+
 dFuqmVHMXHesUKouJS6vDHXZhDknXhUlpF8K05pL8az1AgPpVU3Ow2sIlsIRWAPd/NDJ
 asr9srPxdx8I0HVIbZZD13EDurhLLC+khGFOsyMSiQmh+52UK1iX/PE+AS5BbCsIBbQW
 vhUA==
X-Gm-Message-State: AOJu0YzUOtA1Fj5I1PJ7Wiq0/+pvwJf+R/rtjvGwaHMyVPzI3jNSvoqo
 0iCNdlDRCBiD1IF0qgG73OVqDL9WLonwSofHCwNLe8W/NQ5i3SoXuMlwuyQiR5iIdxOFBw+cwp6
 GCCZx/7oHi8mXshERVRy57b4Fqno=
X-Gm-Gg: ASbGncsTgk4QM9XnMDEilNM/Pdf9fH6hYdZBqWNGkdUY7p8F8UO4lu7A/+bLW7CL3kb
 loBI6+WekxJ2t1tIrE6WwD9CEW0EkWQo+huQX3b5gUl/ds1dRTtB66mh6RHMUVTax3ruTla1K7R
 FdcCvhShF26qDyztzePDxomD5OFgV3MWB9vFin3zRlgxKAm8GiZ45waw==
X-Google-Smtp-Source: AGHT+IHTk7IRaVPNIrwidNCpM63hb5sQ71RHr3h3Xr61RZ0iRGpW8ho6fMsRHxxUb45uQmuH6ydpFG7BDMwMwMKIH2A=
X-Received: by 2002:a05:6512:33c9:b0:549:8c86:7407 with SMTP id
 2adb3069b0e04-54d64afda38mr1130248e87.52.1744845292121; Wed, 16 Apr 2025
 16:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250416215524.3963310-1-aford173@gmail.com>
In-Reply-To: <20250416215524.3963310-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Apr 2025 20:14:40 -0300
X-Gm-Features: ATxdqUGLLmyDOloasej1MVX8veXOU4wRRpvNLr8Q-lddtORm3E4-kIxBL0exOWI
Message-ID: <CAOMZO5DB=2VxnnLz5A-C77kZigPOrf92SbFoQEU6w6rgx-CcMw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: Finish converting clock-osc-24 back to osc_24
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 cniedermaier@dh-electronics.com, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Adam,

On Wed, Apr 16, 2025 at 7:12=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The UART clocks were added around the same time some other clock
> updates were happening, so converting clock-osc-24 back to osc_24
> was missed on the UART clocks for imx8mm and imx8mn, so update
> them here.
>
> Fixes: b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Thanks for the patch.

Reported-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
