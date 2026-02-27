Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458CB103FFAC
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 22:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD6B083E81;
	Fri, 27 Feb 2026 23:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iWh1+uqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E7A883E96; Fri, 27 Feb 2026 23:07:37 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B24F83CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 23:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-662efd1bdd4so1734030eaf.0
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 14:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772230053; x=1772834853; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lk5KNevGtsQEnRvKx4vuzlPuLBRQnqU9GjlWj1L81E4=;
 b=iWh1+uqC57kegYgRxqvsZliECl3CvL6Aggxw+cR33qhWlYyugPficll7pFyEC5P8Sh
 dbziN54oNGeX66Sd4c7Bjjph4scFa59l0BckTu/Gy49ATZR4OmvhvYAIBylyQd60nLIJ
 9kioGr7bi2jmIvgyBDuC2y3V1PC9KEX6DHcdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772230053; x=1772834853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lk5KNevGtsQEnRvKx4vuzlPuLBRQnqU9GjlWj1L81E4=;
 b=o9WzQJypJ9Pp2N6WvV9fxbDbcEuvTVkOHc3qMcbHCAYbWTvq1H9TRpigl2/ApVTtkU
 KB8rNop25K+Dlzx+rHUqGe0fZKZ+rjxHz+0i1e5SAQW9mscScA2uNKK04DJw0wyJifl6
 RJIzvCfhN2zrjIpDxFYxHfEqWzaE/b5kTZvoKloLDpyY9/myg5WHEmwQ3T2w20twblrH
 KLFriyAwy9l93F9S4zEGX9mVjeMGVcP4BV0xc4QLyEX4SKJZK1Bn8jcqDg1pLFzH1DD/
 vhHqWvLBzAkcZC0zIR/AQBuZGIXTESEoc0MA7LSZkGzQQIyhsVNen1QPJ9TcGD9gf4JX
 QvIQ==
X-Gm-Message-State: AOJu0YwQIHAfvQFN8WYI4X2QL48rElQ4hzYEAP0XuwWLkYVwwXLIB1TF
 zniOxsjmT30prtjnBJ2Da9mur9F/hWv0zy5NoR+TVomuHYbdfTLmb2ibdxisn3g6axQ=
X-Gm-Gg: ATEYQzwvGMi1MRmjTDzq6JESPkLtlCUP+9cYJkCNPiYh9m2FhM5A0Z6TpOoyAE4yLHJ
 XhWvDGVNGaZAURdQaILNd3ewxFStVn/tZQI4oHroZP0NafNAmnh7jRDTeHBJZ9RhAa4URDFyx5Z
 dJUPyVcoEYeyblOscsRGNVQoEQjxSZXaK79sNAitS2fwg/tV/uIa9CUSwZfMLtHIvWuZmkK7e+x
 lOa+laXcviQNkRvYfZgzKALffqGX9i4IerLVnilV5FtSipV01O3rleVAHwuGh7T+v3i5VVmK0X+
 EKQs2vEzDFjZgaOTqcH4G59p1ztT7wX42RP8v4+NDJW3iXxaHD8PDyxGAaH47yOMeZv1WS4jkFY
 8iFtP3mkI9zY75Uf6aiVcbyiPqv+Fd8UQnLOY5A9CNcEzbS3sctwyYtCvMZILC+gQMECbHsovUg
 QrpsDnhk5rU9ZkyseS3HFoLNTHXMA4DgJE0YM3ZHrDMiCJ76AgYJ5oq4QJCmwtr6i31VMQxea0m
 cgYvFcDMRxjgsnCLdIT0szDmkAQhutLJOxPeityrR3FRPvV03s=
X-Received: by 2002:a05:6820:4413:b0:679:97b8:848e with SMTP id
 006d021491bc7-679fb5dbe68mr2276706eaf.34.1772230052986; 
 Fri, 27 Feb 2026 14:07:32 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2d9e8d6sm4084460eaf.13.2026.02.27.14.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 14:07:32 -0800 (PST)
Date: Fri, 27 Feb 2026 16:07:30 -0600
From: Tom Rini <trini@konsulko.com>
To: "Lee, Sin Liang" <slee3846@gatech.edu>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Kim, Taesoo" <taesoo@gatech.edu>, "Zhang, Cen" <czhang887@gatech.edu>,
 "anshuld@ti.com" <anshuld@ti.com>, "bb@ti.com" <bb@ti.com>
Subject: Re: Security Disclosure: Multiple buffer overflow vulnerabilities in
 NFS client
Message-ID: <20260227220730.GA1593142@bill-the-cat>
References: <MW4PR07MB86367A3DBC308E10144FE6A6AA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
 <20260227184202.GZ1593142@bill-the-cat>
 <MW4PR07MB86365FC9B8024035576E2C7DAA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AiQmUQ9N4volWwD5"
Content-Disposition: inline
In-Reply-To: <MW4PR07MB86365FC9B8024035576E2C7DAA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
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


--AiQmUQ9N4volWwD5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 09:28:44PM +0000, Lee, Sin Liang wrote:

> Thank you for the quick response. We will follow the  submission guidelin=
es for our fixes and attribution.
> In the meantime, would you be able to confirm the reported vulnerabilitie=
s on your side? That would help us make sure we are aligned on impact and s=
cope as we finalize the fixes.

I'm adding our networking custodian to the thread, for when he has time
to take a look.

> Regards,
> Sin Liang
>=20
>=20
> ________________________________
> From: Tom Rini
> Sent: Friday, February 27, 2026 1:42 PM
> To: Lee, Sin Liang
> Cc: u-boot@lists.denx.de; Kim, Taesoo; Zhang, Cen; anshuld@ti.com; bb@ti.=
com
> Subject: Re: Security Disclosure: Multiple buffer overflow vulnerabilitie=
s in NFS client
>=20
> On Fri, Feb 27, 2026 at 06:25:14PM +0000, Lee, Sin Liang wrote:
>=20
> > Dear U-Boot Maintainers,
> >
> > I'm Sin Liang Lee, a member of Team Atlanta<https://team-atlanta.github=
=2Eio/> from Georgia Institute of Technology, winners of DARPA's AI Cyber C=
hallenge (AIxCC)<https://aicyberchallenge.com/>. We're reaching out to subm=
it a vulnerability report that we identified using our system, ATLANTIS, in=
 your project. This effort is part of DARPA's initiative to apply competiti=
on technologies to real-world open source projects.
> >
> > We have built an AI-enhanced CRS (Cyber Reasoning System) for automatic=
 vulnerability detection and repair. Using a combination of targeted fuzzin=
g (via OSS-Fuzz infrastructure) and AI-assisted static analysis, we identif=
ied four buffer overflow vulnerabilities in the U-Boot NFS client reply par=
sers (net/nfs-common.c). These affect the current upstream codebase and inc=
lude a signedness bypass of the mitigation introduced for CVE-2019-14193.
>=20
> Ah, so that explains the squashfs report last week. I am glad to see
> that part of the challenge now is fixing and not just reporting the
> issues. Please see
> https://docs.u-boot.org/en/latest/develop/sending_patches.html for how
> to correctly submit patches to the project. And while we do not
> currently have formal guidelines around AI-assisted contributions,
> please see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-assistants.rst
> for how the Linux Kernel expects things to be attributed and note that
> we also are requesting that the commit message be human and not
> AI-written/assisted. Thanks!
>=20
> --
> Tom

--=20
Tom

--AiQmUQ9N4volWwD5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaIVlgAKCRAr4qD1Cr/k
CvU+AQChtJcy1PX81i7ARVeQR50KyjFUW2J57TNM4G5p9i7j+QD/aZBhWIdRvKZI
5STe7mLGtcJxG9fzhKNz0Voq56krvwA=
=iE3Q
-----END PGP SIGNATURE-----

--AiQmUQ9N4volWwD5--
