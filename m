Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7235BE8FDA3
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 14:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FF7839A5;
	Fri, 26 Dec 2025 15:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Flx01oLp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B216839DD; Fri, 26 Dec 2025 15:56:36 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE5EF83990
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 15:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45391956bfcso5955220b6e.3
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 06:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766760992; x=1767365792; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C8gHSovQ2IAtTv5pBMbPiH4CKz5ETAQdXJcvTXVoxWM=;
 b=Flx01oLpCSSWxzzjAjQQSnDjTtkvlcFYTSa/x0WzF9xNfr1Cu60a40fSyE4R2ic1Hs
 rmDJ5YWsHsVy2PKGNNhw11CclOy5gFKtYzNpY9DE9i5MSrcqlxoP7F8o/JESmiooDm02
 22Y0kpY+1QveOGbgAXudbdSIXnEMxonEZ1Yc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766760992; x=1767365792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8gHSovQ2IAtTv5pBMbPiH4CKz5ETAQdXJcvTXVoxWM=;
 b=FvUENJ/gaEmjm0lXYssGaqKnMrbhZ0rUKhGfujv4fpdfxOYrGifeNl1DlEA1bMcxMs
 /f23GzWZdR3KOjqmb+kMmiVZc0fQCQ+8eQFtIFGbrqcxj3VpIGwFGOzZbeWETTrU4vFZ
 XExqV2bxOsAB4qm7rwkMLq4+wckTj5TIy9Q+1t6jNNEozBOe/CIqhzh5Vz6y5GLqE4p6
 oIy8Ns4t2377HU3dVYZ/RI0kid/qg+1IQWbwWphK102lZWzURjNeXdwRW9FhaPs0zSgX
 MHIsp1dsyP8JLKr5FDf0qc7h30TsE9xhn2I0a66zg6dLdzZXnAtGeWKlrKZe3k6CKfVM
 9e9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXinJtkyw11cFfnEUNo0dlLB9y61PXtTx1nWGMvmFUVCvC3e6aatFYmIq28YOo6Bv/EjeOcw4=@lists.denx.de
X-Gm-Message-State: AOJu0YyUHI4MJ/4ARvWBd0wViFNEWPI8FymuJ8qeaZR+cEITW0x/W1/i
 Dujqbd1jb7HIVejpDaPhzZ4YpKSWzv2VV3/OltqgaB2Kmog0V2pAHMPrIBYJqkmuskU=
X-Gm-Gg: AY/fxX4ahjo/5RL8RhWPl37UWlAH4gync8OSuanQJzYHB7iolk+Geg9WoFwPY0Mgryw
 vM9WoUe1YoPNMejzWiqbHDAslIVGEd1bVLQq1Dv14+7EObj92Vr/g5Q3bNMGjFDd2O+qsOvYPUi
 LuHNPYa18qzrD02DSm8i8UgDaWSqAzSdyEVEIM11kb2h8JsVLLJ2bnuB8kTHY3ZVqMhEbqsIKOw
 2Vc/3zp0Vcc0VEBRvzDIRPeapMS+AubiSMxGzKgsdOYlxnG6zK6evhmR2OLbWwHJ8Ewq4Ol5QNV
 WPUCMXG1ruNN2j9wJbEcfeSjIYbaxL3PYz4gTP0mq9HCy0x8aTTkj3ttqXOc0SQ983+A0Sm3Bxi
 17VZuzlw8ILzxtdPzvZaZNiqztCw+6AknKKYa4lMqlGYVGYnMWZ2Vey2VX+OCL32hJabgQ2WycB
 6Zaz4LuX0pLF/d5z4vEkDT9lZqj36p2uWh9czapBr3+nd84ZaO/A==
X-Google-Smtp-Source: AGHT+IFslo3ZXOBMuC3WHo8eW1rdBnUaLjsOZujFk7br6ObYL0VdAQmi6XEb2CRf01docqY0/bXgFQ==
X-Received: by 2002:a05:6808:319a:b0:44d:a8aa:f0ce with SMTP id
 5614622812f47-457b20eb677mr10564021b6e.6.1766760992541; 
 Fri, 26 Dec 2025 06:56:32 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673bc05sm15266411a34.8.2025.12.26.06.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 06:56:32 -0800 (PST)
Date: Fri, 26 Dec 2025 08:56:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, alexeymin@postmarketos.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/2] pinctrl: qcom: Make pinctrl drivers default y
Message-ID: <20251226145629.GC710860@bill-the-cat>
References: <20251222115144.2146964-1-aswin.murugan@oss.qualcomm.com>
 <aU5JPlsbh-ER7Den@sumit-xelite>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RqRMJBW51F/PjUV9"
Content-Disposition: inline
In-Reply-To: <aU5JPlsbh-ER7Den@sumit-xelite>
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


--RqRMJBW51F/PjUV9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 02:07:18PM +0530, Sumit Garg wrote:
> On Mon, Dec 22, 2025 at 05:21:42PM +0530, Aswin Murugan wrote:
> > This is a follow-up patch series to address review feedback on the
> > QCS615 pinctrl driver addition:
> > https://lore.kernel.org/u-boot/20251112164758.1560041-1-aswin.murugan@o=
ss.qualcomm.com/
> >=20
> > During review, it was suggested that since all Qualcomm pinctrl
> > drivers are already within a menu conditional on ARCH_SNAPDRAGON ||
> > ARCH_IPQ40XX, they should be made default y based on the appropriate
> > architecture rather than requiring manual enablement in defconfig
> > files.
> >=20
> > This series implements that suggestion by:
> > 1. Adding 'default y if ARCH_SNAPDRAGON' to all Snapdragon pinctrl
> >    drivers and 'default y if ARCH_IPQ40XX' to all IPQ pinctrl
> >    drivers in the Kconfig
>=20
> I see the usefullness of this feature but in turn it will limit the
> capability to reduce U-Boot size to an essential minimum. In scenarios
> where there are contraints on flash size or on-chip RAM for U-Boot SPL.
> I would rather favour something like following like:
>=20
> 'default y if PINCTRL_QCOM_GENERIC'
>=20
> where PINCTRL_QCOM_GENERIC can be enabled from generic Qcom defconfig.

If something is merely "default y" it can still be easily turned off. If
we want to make the "if ..." part more precise, OK. But I don't want to
go back to (nearly?) every snapdragon and ipq40xx defconfig being
modified, as it was in an earlier iteration.

--=20
Tom

--RqRMJBW51F/PjUV9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU6iHQAKCRAr4qD1Cr/k
Cu24AQDjerWbzxCrRnQc6aKc2+unf88efgbd9QEvfztyUd/G9QD/Xfx8MXZXxEiP
sbv8g4L4DnIt3O9pIAag+8YwsyWjOw0=
=A9Dm
-----END PGP SIGNATURE-----

--RqRMJBW51F/PjUV9--
