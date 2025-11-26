Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26521D1118B
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 17:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EAD483923;
	Wed, 26 Nov 2025 18:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="sMrd2UHj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF18683966; Wed, 26 Nov 2025 18:54:57 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A838383869
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 18:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 35C55C16A0E;
 Wed, 26 Nov 2025 17:54:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E41C560721;
 Wed, 26 Nov 2025 17:54:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D0AFD102F1D8D; Wed, 26 Nov 2025 18:54:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764179693; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gThDhuFJicwDxEaTNT1+5E0unMB4rNvNF2PVidpKDtk=;
 b=sMrd2UHjktfgR6CHxVPcTWZ+C1eOzYC0ewHXb53t/Hq0Z0VdtOaT+xSaOTZWtGvsu+o+JL
 mTstHnbcaYxVNJdYm7QAnL5hraQNc6hmU02xUVEWdBharfmG1laNBOMT91msuRcwbdEbHD
 AAbRO5e+Cij/fBUdJ9sVI9hl3qNBl2ta2xRFHDLtVIo9Y83AQYC2SOCLH9ZUcaksjTCjmS
 Zo6pVeMcAh71PMW93Gagy8G1+WwC4m1QVn2/Y++KDt2ESAz6ZU8bxpVBZomm6O3ARmwkpg
 2aK62susBSqTnufIuyzrAgY8EY/2JPIEdNjAKkoFIN19ThGCQoKdelZK/oPq/A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Nov 2025 18:54:48 +0100
Message-Id: <DEITI8FI29LO.GOPV4GAORCZD@bootlin.com>
Cc: <u-boot@lists.denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, "Anatolij
 Gustschin" <ag.dev.uboot@gmail.com>, "Tom Rini" <trini@konsulko.com>,
 "Stefano Babic" <sbabic@nabladev.com>, "Fabio Estevam"
 <festevam@gmail.com>, "Simon Glass" <sjg@chromium.org>, "Francesco Dolcini"
 <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 5/5] board: toradex: add splash screen to Toradex i.MX7D
 Colibri board
From: "Thomas Bonnefille" <thomas.bonnefille@bootlin.com>
To: "Francesco Dolcini" <francesco@dolcini.it>, "Thomas Bonnefille"
 <thomas.bonnefille@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251126-repair_imx7_splash-v1-0-d3877afb7381@bootlin.com>
 <20251126-repair_imx7_splash-v1-5-d3877afb7381@bootlin.com>
 <20251126115931.GA26872@francesco-nb>
In-Reply-To: <20251126115931.GA26872@francesco-nb>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Francesco,
On Wed Nov 26, 2025 at 12:59 PM CET, Francesco Dolcini wrote:
> [...]
>> -
>> -	return 0;
>> +	enable_pwm_clk(1, 0);
>> +	ret =3D pwm_init(0, 0, 0);
>> +	if (ret)
>> +		return ret;
>> +	ret =3D pwm_config(0, 0, 6666666);
>
> You are setting a period here for the PWM backlight (150Hz?),
> considering that colibri imx7 is a SoM, e.g. there is no actual display
> part of it, is this number generic enough?

Indeed there isn't, however for my tests I used the Toradex Colibri
Evaluation Board with the Toradex 7 inch Capacitive Touch Display [1] that =
is
meant to be used with the Colibri Evaluation Board.
This display typically uses a 150Hz PWM for its backlight so I chose this
value.
However there the pwm_config configure a 150Hz PWM with 0ns duty cycle so
in fact, no matter the frequency, this pin will act as an always off GPIO.

1: https://docs.toradex.com/104497-7-inch-parallel-capacitive-touch-display=
-800x480-datasheet.pdf

Thomas
