Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6B7FCE096
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 14:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E4583D1A;
	Thu, 26 Feb 2026 15:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="URHEvQ1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F4383D1A; Thu, 26 Feb 2026 15:38:03 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A75983AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4ba9abbecso955658a34.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772116680; x=1772721480; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6IUyz6T4SyeeBMYmDS7C8X32VIiCM89WBrbeFCtfFuo=;
 b=URHEvQ1hpycq7ozeazj1p+wonMcu5dzbMuqO2LBN3N5F5IWB9AmfAsIvmLlYGi5+6P
 +j1JqnqI1pJYwr6eOiDsCFi5lYiPwn2SSzfp3SueR83rUwqiBNx2KBmfNTM4S3agkdYz
 dD2PMuC0+QWXqsv1yyzYUr+9/+hfuptCVIB/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116680; x=1772721480;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6IUyz6T4SyeeBMYmDS7C8X32VIiCM89WBrbeFCtfFuo=;
 b=C6n6wSC/DMCErOPdiE1joAfvsta0gOnLu/s9paATqclREOPUwe0ly+hcbkCo/v75WT
 GLrDB8CFkitC3PmAmo+7nGEIw1t8BzC+ZLTcz+NXeVb+Ne97TVSxx420g+FJ0lmKW+qL
 ObMst7Xe9yKR6Hj5q6ZhT4B2yf5D39U6BIUEThdt7Uesc/z8P/HKjOTcMi10cbJadSbt
 1ZJkIINbgNJElofGBR30VA4EETduz+4CRd0r1I0IVUhHFSR+4gHaoMP2cIQBocbWjcn0
 NlBn3o25wpPxEL78dGfL/6DeOzWNZ1o28RXcP4Jx0ss82T9nBDS5W/NgOLfKpq5DmcOD
 2LPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkXgPpQrBg2jenCQnF0xVl6SC/8M+LAPk4ofowQDifzS4fa1L9nl7XNeUMnbrM91Op6NyHbpI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5oL9PDUzdvplcRF/tTKp0rtjlkyqu2qiX4Tn0FvDs5VpbXxuT
 tDUYQp+tBlsYuD9tDkrTap+eOi0YgOSi3Hy3gZ83/twurm+ojD0M9yOMdRjENoDaAuA=
X-Gm-Gg: ATEYQzyalZqL/ZNm36zatVaSZQG35Ac5w53QRlW7p+3+Rj6pdZYa16rkV+UVji4V+h3
 S4XoTHQPCmglJ7tqTqybXa7VLyRtHcau3QXAdeOUI6iRqlUWZNIzo153XgWfh8qWvSXH6P3A4K2
 hfkPR+alNiFmz13c5PkYdIVBq8vAwU8PXz6XFk9B5M5mh+5aeN22z7ZGWrCd6buzW+d/FgVPIPI
 8gzpHfCy1GiY2RYwwk/3/DRwkgEHKCQu+arHwj5Oz7+zUFzHiI4kS2p8AsOi9Gh00SR6Q5JBGn/
 N88iAaU0N2faqT+aj6FKoOCHOgxM4g1c0dDDufiQaYkU0vs8GZVuiqKPQPJHuXM6fzjwhKYODq/
 5PJoQXie4VaNDeJYAj8qphu5nasTWtvzropAXeWY17UnOMCJVnyEgSV2E7mMBtxR1Agh09eLHzj
 /skk3i/Q7Ddt7T9UFsvSLDub4uic9TBKbiZrYqrEQt/vRgnQANP2Te6pPx2uLDpokAWj9iSut15
 3Nt33ZcNYzCmYlHqxtH60U4ttPkfRtlvhq1l6X1XJqnC+qVi74=
X-Received: by 2002:a05:6870:e243:b0:329:7f93:2b6 with SMTP id
 586e51a60fabf-4157b10a9eemr12329753fac.29.1772116679713; 
 Thu, 26 Feb 2026 06:37:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160d2cf00fsm1952068fac.20.2026.02.26.06.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:37:59 -0800 (PST)
Date: Thu, 26 Feb 2026 08:37:56 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de, nm@ti.com,
 heiko.thiery@gmail.com, m-shah@ti.com, j-keerthy@ti.com,
 n-francis@ti.com, bb@ti.com, Diwakar Dhyani <d-dhyani@ti.com>
Subject: Re: [v2 PATCH] mach-k3: Defer CTRL_MMR access until after TIFS
 version response
Message-ID: <20260226143756.GC1593142@bill-the-cat>
References: <20260225051559.416445-1-u-kumar1@ti.com>
 <50d29e78-1502-4dbd-ad24-a1025142947d@ti.com>
 <f21a0fba-0a19-4f95-88c3-41e0728fb888@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0NbWZ1VJUHCv2wnI"
Content-Disposition: inline
In-Reply-To: <f21a0fba-0a19-4f95-88c3-41e0728fb888@ti.com>
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


--0NbWZ1VJUHCv2wnI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 10:20:11AM +0530, Kumar, Udit wrote:
>=20
>=20
> On 2/26/2026 10:04 AM, Vignesh Raghavendra wrote:
> >=20
> >=20
> > On 25/02/26 10:45, Udit Kumar wrote:
> >> The CTRL_MMR registers are firewalled at boot time, and TIFS unlock
> >> them as part of the system firmware initialization sequence.
> >>
> >> Current code assumes the CTRL_MMR space can be accessible at early
> >> stage of board_init_f execution by unlocking them.
> >>
> >> But on HS-SE devices, TIFS takes more time to complete initialization,
> >> and CTRL_MMR registers remains firewalled and not getting unlocked.
> >> Which results in any write to these registers are ignored.
> >=20
> > Hmm, this looks like something that can happen on other K3 SoCs too.
> > Should we update all the other SoCs to follow the same logic?
>=20
> Yes, we need to update all SOCs,
> As Bryan pointed out, this issue is seen on other SOC as well[0].
>=20
> I will post for other SOCs as different series.=20

Do you mean another iteration of this, as a series that addresses all of
the SoCs? I'd prefer that (and cover letter explaining the situation) if
possible and reasonable, thanks.

--=20
Tom

--0NbWZ1VJUHCv2wnI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaBawQAKCRAr4qD1Cr/k
CnBYAP9qWJR+GvMGpMyzyKoxjn+VfODZJM5dTep+thmViN/nAAD/aloe1V5ccPfF
tEdpAqd5RQ56Ov9sKa0XX6EPoJMc3g4=
=5Aqt
-----END PGP SIGNATURE-----

--0NbWZ1VJUHCv2wnI--
