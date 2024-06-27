Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A7BC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 13:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEBE488528;
	Thu, 27 Jun 2024 15:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SN2Uy1cN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D30448811C; Thu, 27 Jun 2024 15:57:56 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F5788093
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 15:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-25c9786835eso4070717fac.3
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719496673; x=1720101473; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x7AtLXSQhdAdSJMORx7r78eKrBtp5eb35woLesCe2Oo=;
 b=SN2Uy1cN+zLVBbtZHTxUL6EgA7cvtbpA3dx9mE+F07MTVfW4WOoKCsqY6s8a/+2ylx
 UhZH/xqJ0G2wRH3w/4Hjr1Owf/Ksg/bd8ormh5YOwUDRD3rGQO+E3p5XVDRKvBvW3zgf
 5ATUk4TVlzpfZAF7x98PPZcYt9wtQR/IfRHAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719496673; x=1720101473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7AtLXSQhdAdSJMORx7r78eKrBtp5eb35woLesCe2Oo=;
 b=C8DuFDECyYlfNnFN0DMGwZMzy1wrGyK6HH1L6QDJjbsdvtVyWvV/uwFdUCSBw7ZLZP
 TQ2dHYV/rX5eYXYpwIK/+DfFRDExCVQR9SVK6HrM8Bzf9xc32WQSceT6Wsm1oZAWt1lQ
 ln2sGry3ioDyN/63Tu5uZ8gId1nbIogOIRccyKjy2/yfbzMndEj+0ru/mVOEvfs2wLWQ
 /2OnmFD2jCDY96pIs/hWl88caURHbzyK/PAXJBDeF5m65Nuq5tOceqF2M2t3g+c/SSQv
 py+PkwflFxGSe5TFhZOvPAAoIN9HUdANmMN8odJjvCJ99pCQRcXUei/62q+V72p+nLcW
 p/TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBqVxlh15h6GaTTTNl8GQtJ1FEVVC0Td0jGoH32HiCFHejgSD9DRf7DJRKuxM5vHI4f1GHcVhpFjIP6jMicqM5IRqjTw==
X-Gm-Message-State: AOJu0YxE6BXcCvA6+h4hPgkRsaffWjPO7sCHUUtgunq4/EwAkxR6QSlb
 2Q/IOrlEioYmtZcinmVemf21vdfrj4FvWnsTY4eHVUL9DhXnaX/MglIbKjpSiCw=
X-Google-Smtp-Source: AGHT+IHaEqvfZMuvwf50gNDC3Dg5d3f/jjHR180lhemv0MX/weDLL0wpcbDJPBiUSsr7Lgro4Ws+cQ==
X-Received: by 2002:a05:6871:892:b0:24f:d9de:3bed with SMTP id
 586e51a60fabf-25d06e365d1mr14433087fac.41.1719496673048; 
 Thu, 27 Jun 2024 06:57:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d72dd61b6sm362148fac.47.2024.06.27.06.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 06:57:52 -0700 (PDT)
Date: Thu, 27 Jun 2024 07:57:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] zlib: Fix big performance regression
Message-ID: <20240627135749.GZ38804@bill-the-cat>
References: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GEh7dmt2Evknk3zw"
Content-Disposition: inline
In-Reply-To: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
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


--GEh7dmt2Evknk3zw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:25:21AM +0200, Christophe Leroy wrote:

> Commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> brings a big performance regression in inflate_fast(), which leads
> to watchdog timer reset on powerpc 8xx.
>=20
> It looks like that commit does more than what it describe, it
> especially removed an important optimisation that was doing copies
> using halfwords instead of bytes. That unexpected change multiplied
> by almost 4 the time spent in inflate_fast() and increased by 40%
> the overall time needed to uncompress linux kernel image.
>=20
> So partially revert that commit but keep post incrementation as it
> is the initial purpose of said commit.
>=20
> Fixes: 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Good work.

Reviewed-by: Tom Rini <trini@konsulko.com>

And can you please head over to https://github.com/madler/zlib and file
an issue, or pull request with your changes explaining why? I would hope
they're interested in performance regressions on slower parts still.
Thanks!

--=20
Tom

--GEh7dmt2Evknk3zw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ9b9MACgkQFHw5/5Y0
tyzGWwwAs5K6PuFzTLGqmGKuXaxLdvdks+xykS7nLxMBpvpcxg/PCjG3IqmwAcxs
toxNaUBPkjpd7Tttp9LVXew3MDMiiViUBLb7/YLBtyYVBXNV0z168enrJPZ1EaJZ
82zte1Q8Cld1SD9Fyi9GNEpirUnPNTgfz+PxSmDpPCV3SjROX2vNmX4v67r/8gzp
E8Akao215ezRSzihiC6f2kgR1m+DfmWbN7Pcgufgcx286i/SKLOgyeFnf10ZZP2C
eWJ2BG076bNeqBpuwCn/zvBIyDsKk28kQy2aeUvSgBHgitfsuPkN4vsA2qX/0Mzt
mZyLHpW/x/opdh2+MyIb1t5S7J+/cZXi9cXAbiY4bYnSB64Dr/Ss/KbMfELRuZhX
3d5eLO259GjfPMw5yWBj1N+oXO2FVoiNxts0d/foSxrZX7nonGD+dDJEXA4kS5jc
jX7W+NL+0TkYMgE94VmdlSWz8ORKzRJ2bKQPJJqciadz7AcDtqMy//6f68W7wmKW
sW8SZPkf
=5P2g
-----END PGP SIGNATURE-----

--GEh7dmt2Evknk3zw--
