Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B848CCF9EF
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE613838CE;
	Mon, 27 Oct 2025 17:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W2ZAWHM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C13838DD; Mon, 27 Oct 2025 17:49:34 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7603882E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-654eb334b58so1499473eaf.1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 09:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761583771; x=1762188571; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AT8H1j6Y6qKkn1Lt8ozFK/JTt6z47xcUImwbZAvOzwY=;
 b=W2ZAWHM1HhwhkhzszHIwSG4dBExTeIzvI4FnxSB3TqOWrrr559WvuSpyXPW7lThnAG
 IeHNJRayiGo3Vpa5WKPWfbGUd1vlccP/2DFSO8pvcXedzNaMev5IFUJ/cEosg2WgqqrY
 3XC+V3w+SkBskD5eCXaRrbJb6YmWVou5mQSzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761583771; x=1762188571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AT8H1j6Y6qKkn1Lt8ozFK/JTt6z47xcUImwbZAvOzwY=;
 b=YTvq2gInxxTfNe+nzvON8n40hs9SyeZxmcrYePEVcmxlECbNBU5ifpVi37xADezoeC
 Gcfp9qkzDlQ+H2GiOX5XzCf7+400xKsN2TK/RuabH4qXvUEup7quL+0O9xsJbIwlixFO
 JKO3bwfECyenjiPkRK5KDPdSaJvGi3e3ua68ol5/VzQ9g1m++OX4l+a564ZqRj5vGikt
 imRNxfXqKpCfkJVBeAqI6N0c4/MdiJ8u/zlwrW88dulH3c7qNP4wC3fnCZDEqVon/Nnv
 3mjRw3X+pLa9Alt6kuYiIad5F8b6wKrXeG0RYEHNYvBYkEb0+juwWA2vwlOwIY7ehoGw
 f06A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTdjQvb+S30TyMChpa+BPqPA+HsdlogKT9zKESH+bJmpT+NliKIRmbuTwWOdXvSwkcpgGm1q4=@lists.denx.de
X-Gm-Message-State: AOJu0YyFrT81CnSmGlSivCC5TC5WCXUmMrH70a0O6zC93NYsOCYW/jdY
 V5AN0T9anOBQu12T/nA6/nnBJUaKzbIFOKy/YbUZ+ubRWfEr2VxnILJKEXaf1qrPwks=
X-Gm-Gg: ASbGncsWoQofrGCLjfp9mfdD5wEnoZo7GFsuxxbC6eiS+KnBmBHe2z7WbyBYS4JFvJT
 PswiL1hK5Gs64dYX6nB6w9AjsmOMZiLMDs/s0texAYagAN9urHehHQBFex/vb4PgNdY9BmA6TeL
 G9p3lBAGqtqa2mJSCgVfrWyofVTkcmD2rNdRiXkUrbJOlYg6dktBlZcJai8PM6B5p/g7/4WhX6a
 Z86oCA4EC0j7igVqe7+ahGdWV3Yc6nEHlPkjaAChwarIf1sq6endznMvgksnx92dTv9lSw4SDtz
 G/N1iDdUzalyQF85Q2B7nNLvU/ZJg0S5HhHJTh/2HnGhHa+4Fc4wzXKTIiXbmPF91ExwMyzxI7z
 aio303GgY6akHPeB8mnDi42ZyAD2RdSoX3R7QXu7ja8uU06H/kvhOlTmyDH0pKl5GhyGdc0j5fI
 OtZO4YFtOGdTw4DXoxEYjVKIDThH+ZvwV7FHH4S34=
X-Google-Smtp-Source: AGHT+IHCnyNhIaqKtVjPebLXw2s2NH0jDwc5P83SxOqEbNVOH768HaGPdvWt3NeW4M0fbOS/GG2zvQ==
X-Received: by 2002:a05:6820:169e:b0:64e:ad23:bfa2 with SMTP id
 006d021491bc7-6566f2a12c6mr308019eaf.3.1761583771160; 
 Mon, 27 Oct 2025 09:49:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2ccd5bsm1899369eaf.15.2025.10.27.09.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 09:49:30 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:49:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, u-boot@lists.denx.de,
 u-boot@schwermer.no, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and
 fix comments
Message-ID: <20251027164928.GY6688@bill-the-cat>
References: <20251027115638.1186252-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dRQyK2VM5TrZKU1Z"
Content-Disposition: inline
In-Reply-To: <20251027115638.1186252-1-festevam@gmail.com>
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


--dRQyK2VM5TrZKU1Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 08:56:38AM -0300, Fabio Estevam wrote:

> From: Ye Li <ye.li@nxp.com>
>=20
> The change in commit c1af358cf51a ("imx: mx6ull: fix REFTOP_VBGADJ
> setting") is not correct. According to latest i.MX6ULL fuse table,
> the REFTOP_TRIM[2:0] fuse is defined as below. So the previous codes
> are correct, only need to fix the comments.
>=20
> Set the REFTOP_VBGADJ field in PMU_MISC0 register based on the
> REFTOP_TRIM fuse:
> '000" - set REFTOP_VBGADJ[2:0] to 3'b000
> '001" - set REFTOP_VBGADJ[2:0] to 3'b001
> '010" - set REFTOP_VBGADJ[2:0] to 3'b010
> '011" - set REFTOP_VBGADJ[2:0] to 3'b011
> '100" - set REFTOP_VBGADJ[2:0] to 3'b100
> '101" - set REFTOP_VBGADJ[2:0] to 3'b101
> '110" - set REFTOP_VBGADJ[2:0] to 3'b110
> '111" - set REFTOP_VBGADJ[2:0] to 3'b111
>=20
> Sven Schwermer reported:
>=20
> "These are the symptoms: Very few of the thousands of devices that we
> manufacture (< 1%) fail to decompress a large XZ archive once in Linux
> userspace. We have not found any form of memory testing or other load
> that reproduces this issue. Reverting the offending patch fixes this
> behavior on the affected devices."
>=20
> Revert the offending commit to fix the regression.
>=20
> Reported-by: Sven Schwermer <u-boot@schwermer.no>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> [fabio: Fixed checkpatch warning and added Sven's report]
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

And after reading the discussion on the older patch, this does seem to
be the right way forward.

Reviewed-by: Tom Rini <trini@konsulko.com>
Link: https://lore.kernel.org/u-boot/1646721735-125430-1-git-send-email-ye.=
li@nxp.com/

--=20
Tom

--dRQyK2VM5TrZKU1Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaP+ikAAKCRAr4qD1Cr/k
CsjkAQDH5+AARiL5DwCJ0Ckqwh0t4nT9ZBnCMM+6j1WV2JmlQgD/UEuL96N32NOO
tl3JVv0fPbF+s3QezMPWc8oyghfMWQQ=
=tWIe
-----END PGP SIGNATURE-----

--dRQyK2VM5TrZKU1Z--
