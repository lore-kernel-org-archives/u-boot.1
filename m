Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CEEEE6446
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 14:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84CB0839DE;
	Wed, 31 Dec 2025 15:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SuAPWHGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3FA984081; Wed, 31 Dec 2025 15:49:29 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B7D83700
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 15:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c76f65feb5so8165640a34.0
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767192564; x=1767797364; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=07QZdLO/l1m1pH+g8EaRp5CVhiNTt/GuAINGpOPOYAs=;
 b=SuAPWHGCP0tIh23/8FUvqVZbdO3bNulLDbLSJypiSdE1gs1VFHaKv5WsSFwcaCc1Ta
 h52/3YwkzDjyqdrOH2NDHmeBvQcdryRC4gC+b8myqL+5sXa7D+goG/w1Oi2fc80cPV95
 d1a9D92lb3GZaKox86aL1Yw+LJjooQD8jFo/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767192564; x=1767797364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07QZdLO/l1m1pH+g8EaRp5CVhiNTt/GuAINGpOPOYAs=;
 b=sHaqBdIbKgQbPhwwahpz3hoL07GV2E1XvZdym3Kkxavt8/9h2xYHLJwOlc2Urzy8jV
 GOoWFnP0aVQiAUUUweah8IIZqrSsvXX7tPlCIgpdKXyjkKkk/LgRnqB6JDtBRdOlv2Ev
 oATHXn7donjrCAUaPWeFf2lpvEc1VWJduEaDYAZW21USeXpA6/zrgOpwGW58ABWX+4jf
 zS2pyVzZWMnwzU90MbXEBkYvGQfC4mCg/U68cgu2vOhYiM0Wn5XdPaOX/XO84QKet4Tf
 rHBN+Brd8DrAcis8rcc2Zl4dfYYs2NssyTcxZ4OzMGpnvO9BnI0lLhq4/meMVYiePQnO
 0o1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK322sqaRnSCu3tST2FJiyDwGogG7C8ebubI3KAmdiKv7ghlkc1l1HCArGycxLtc3jHTu+0/U=@lists.denx.de
X-Gm-Message-State: AOJu0YyzqovihHeR7ol9kennNQ36z1Fp76HZwBJ286qE60sv7gOi2aTq
 ltIGNVA+cn+vZDrrUV+BEShoDKlsOwK8SlmvaJSgkKllqBCjxnTFALXdm2lvEuVgRzM=
X-Gm-Gg: AY/fxX7oX4QshhhqnxbTzaQbsUV5sJDHlFT6Ct1CbwurQSB/kk5h3FzzDfofS9U3ob9
 cyjlZibxbrLJpXo9eWd8m1fsacpSxvffApEP011LAhZybtvkwIkbR1XqGcj+XVGQPKzLXb+D+rM
 ZPBY92uCskTitjO9hmJQAM6yZ5rjfUZJVsPo6VCNX1Ls+khURKuICogVpSj5U4MXjnupReMGKAG
 cCFX/SnSQdGTar1wlc2/vmPIONBcRSABHOhnQ4wIie+CtzT45SxLeB4v9HQp+TnPPXgMbVeuGKZ
 2c+MWUdcHMB6lLFBSak358EzppXsyGvQnhIYJQQpwphI8hK89g0ZwgxcnjVJSIFyj9pjIpuoj9D
 no+mVTsQrP3aPOB1EyMWdLN1rPNL6f3uR4T2H1pGEkWJPcUag2iShmEk76FlTEIVstas6506PKn
 cSjnUJqgbInkj50pACjM0o7/4BICIs1p7RcHVIezoKY631LgMSi7not+8uz1FH4t0Ovq/x6dLbP
 OC2KqRRvRF/h3mTjW8U1vYjhkMcwXA3WxF3n8c=
X-Google-Smtp-Source: AGHT+IGWFFxOnIu3hcbMuB1oPF/2FtzdoG0BvAOSKDfKcvMImF8PKBXjpnDyTDBEGHAOHuGEyNKGYw==
X-Received: by 2002:a05:6830:2e06:b0:7c9:596c:a7c0 with SMTP id
 46e09a7af769-7cc66a4f398mr20457282a34.36.1767192564546; 
 Wed, 31 Dec 2025 06:49:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9201sm24521534a34.26.2025.12.31.06.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 06:49:23 -0800 (PST)
Date: Wed, 31 Dec 2025 08:49:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Luke Wang <ziniu.wang_1@nxp.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "bhimeswararao.matsa@gmail.com" <bhimeswararao.matsa@gmail.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "kauschluss@disroot.org" <kauschluss@disroot.org>,
 "andrew.goodbody@linaro.org" <andrew.goodbody@linaro.org>,
 "tanmay.kathpalia@altera.com" <tanmay.kathpalia@altera.com>,
 Ye Li <ye.li@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [EXT] Re: [PATCH] mmc: Add power stabilization delay in
 mmc_power_on()
Message-ID: <20251231144921.GY710860@bill-the-cat>
References: <20251230103950.1543515-1-ziniu.wang_1@nxp.com>
 <ce85424e-b18f-4dc7-b62b-a8220e9ed7a1@mailbox.org>
 <DU2PR04MB85677D23C8B9723BD6E525C6EDBDA@DU2PR04MB8567.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fnRJzimTDKPFOJAT"
Content-Disposition: inline
In-Reply-To: <DU2PR04MB85677D23C8B9723BD6E525C6EDBDA@DU2PR04MB8567.eurprd04.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--fnRJzimTDKPFOJAT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 09:51:13AM +0000, Luke Wang wrote:
>=20
>=20
> > -----Original Message-----
> > From: Marek Vasut <marek.vasut@mailbox.org>
> > Sent: Tuesday, December 30, 2025 9:37 PM
> > To: Luke Wang <ziniu.wang_1@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > jh80.chung@samsung.com; trini@konsulko.com
> > Cc: marek.vasut+renesas@mailbox.org; bhimeswararao.matsa@gmail.com;
> > xypron.glpk@gmx.de; kauschluss@disroot.org; andrew.goodbody@linaro.org;
> > tanmay.kathpalia@altera.com; Ye Li <ye.li@nxp.com>; Bough Chen
> > <haibo.chen@nxp.com>; u-boot@lists.denx.de
> > Subject: [EXT] Re: [PATCH] mmc: Add power stabilization delay in
> > mmc_power_on()
> >=20
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t this
> > email' button
> >=20
> >=20
> > On 12/30/25 11:39 AM, ziniu.wang_1@nxp.com wrote:
> > > From: Luke Wang <ziniu.wang_1@nxp.com>
> > >
> > > After enabling vmmc supply, add 10ms delay to allow voltage to
> > > stabilize before SD initialization starts. Without this delay,
> > > some SD cards fail to initialize because the initial clock cycles
> > > are sent while power is still ramping up.
> > Details please. Which exact cards ? With which controller/SoC ? Does
> > this problem happen on another SoC/controller ?
>=20
> MMC initialization failed on IMX7ULP-EVK with the SanDisk Ultra
> 64GB card (CID: 035344534436344785569a5ab5018400). However,
> SanDisk Ultra 32GB and 16GB cards did not encounter this issue
> (both have CID: 035344534331364780c86726e1012700).
>=20
> The root cause of this issue is that this SD card requires at
> least 74 clock cycles after power-up, otherwise CMD8 will not
> receive a response. For other SD cards that initialize normally,
> the initial clock cycles are not mandatory - they can still
> initialize successfully even without them.
>=20
> On the IMX7ULP-EVK, the SD power-up time takes approximately 2ms
> to reach VDD MIN voltage. However, the current code does not wait
> for the voltage to stabilize before sending the initial clock
> cycles. This results in the VDD voltage being only around 1V when
> the initial clock cycles are sent, causing the SD card to
> completely miss these initial clock cycles.
>=20
> We could add regulator-ramp-delay or startup-delay-us values in
> the dts vmmc regulator, but I have checked some dts files and
> found that many of them do not configure these two values - not
> just for the IMX series, but across different platforms. If we
> were to add them in dts, it would require modifying a very large
> number of dts files.
>=20
> Alternatively, we could follow the approach in the Linux kernel's
> mmc_power_up() function and wait 10ms after power on.
>=20
> This card does not encounter issues on the IMX8MM platform because
> the IMX8MM's SD power only needs about 0.5ms to stabilize. Sending
> 1ms of initial clock cycles ensures that the SD card can still
> receive at least 74 clock cycles after the voltage has stabilized.
> Even though no issue was encountered, sending initial clocks during
> the power ramp-up phase still does not comply with the description
> in Section 6.4.1 of the SD Physical Layer Specification Version
> 3.00.
>=20
> Additionally, I believe the 1000us delay at the beginning of the
> mmc_go_idle() function exists for a similar reason. Without this
> 1000us delay, CMD0 would be sent even before the voltage reaches
> VDD_MIN.
>=20
> This should be a common issue, not limited to the IMX platform.
> We can either add a delay in the code or add regulator-ramp-delay/
> startup-delay-us in numerous dts files.

Please condense this slightly and expand the commit message, thanks!

--=20
Tom

--fnRJzimTDKPFOJAT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVU37gAKCRAr4qD1Cr/k
CvA0AQCLXvHrNxdpCIJInK0Owl+3cza4BMNbjEP+5GBC4hbFFQEAg+Y1yPCCAt09
o5gysjwRzPxP9f/3Ow3cnZKzhG9ndwg=
=oxxU
-----END PGP SIGNATURE-----

--fnRJzimTDKPFOJAT--
