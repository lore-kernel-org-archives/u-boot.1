Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0D4FEFB77
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 18:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A86F683D1A;
	Fri, 27 Feb 2026 19:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aHZ9eCmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C0E383E81; Fri, 27 Feb 2026 19:42:11 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D9BE83CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 19:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-463b3697846so2910154b6e.0
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 10:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772217725; x=1772822525; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hZB7LLhLBUomKbTlZAt6Ncc/VT+TqQsiMG1l7X87wE0=;
 b=aHZ9eCmivLda2cCAz55do3MmGpU/khxdfP519QmE0HGxq0VTn1aRcsv14rrBw8/nas
 X89rRIDPg2s/gS/chFfKaDiaII3c3IjEq4jexkTLh7hFRf452TZDhSRV+K/pKWYKDHmK
 WD33tqDzWvMkgY3wTsnCHYmS8QybwTzaV/CZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772217725; x=1772822525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZB7LLhLBUomKbTlZAt6Ncc/VT+TqQsiMG1l7X87wE0=;
 b=TzuNJP+Ix+TSgelTjBNp3hUVzB9Op4sbiguFtq4LuN0N9pDx0mH6Y+R2xQguJV0BEE
 E5wGKcTXYTLIqO2ZgXQ3UEcVLFK/8L4joHxbQZSxw81SAywzVQZcy8HRRIFIQ+ZZlisC
 sr418zJoHcc/zOWS0EN7PG7naLDRmH3l0tGNLnmPpEOXm7tgzjNZO0c6XLtm7nFdGVpv
 07y5ypAn3wBTF4rImW7vKgKTXrAyRjUw3qvz0f0/3Gd4kD5CB0kSHmIIjTP/qqhLWRkA
 dmYMAadE/3hRsnipuWlnXoih/u17E77jdyljmcRJHiSx6vtBAlecErjFTmeSt3ZuQsVI
 /H6Q==
X-Gm-Message-State: AOJu0YxNn1be/qJoNEJgxgjr2MMXm4VzzTTvnaQDOL6/JcLNzQf0k42V
 69+dBPfntyZbCKs01t24VZ5OWN9lpB3q2eKXlognxqendaAE8cvxt8wnuBl1hdAq7u0=
X-Gm-Gg: ATEYQzz2FJ+Y4ZRV95jr/oZiP1DB4GlOMYazjJgN4ZZa+UBthCMjj0G2DsYnHPxFCil
 HlKqBeULq161itYvGVToZDxuD3LQi7XbMjJw7DFa+tA2dVsKlQ/ZXskksS/Vo1vQaF6YJQ/SEwa
 1l1zlJ9bYFbXkiclCX1gy0XUSIvRbHGCBMqK+5t9ZHURtReIsU73dPXzrIjWpG8f7bu+UcFlgIV
 DB7cAO0U5TgUoZtdLNooQ36OE6AfLgT6yu4zwy2/Mz/zLdrovlWKikbrg4s0PtHstZP2KjvCGjk
 zSDN/bG/TgrNPtbmjDaaZkZe5EX9JOQ4sKipb4I94btli9d3OwHkeLGi+TV7XbGreWiKk7e2CX2
 SwDUhggL/vMv+b0xZSZ8npm+DPXZtJEAQf7Nrtu9VwgAJWHIM2+n+DmDuqsVxZMNfWHrPP04fvB
 o1FUY5gwkHDBDF28jQRzrlIWKVYIprBWHxfwChjqNxDhTbgmKyPmHZcChMFjgW5a+KVA8UENyQu
 0FkPd4NYWqGEbZnSkUdZWKLKbtEKa6kP9e3g/Pco+j5vzuXoxY=
X-Received: by 2002:a05:6808:1705:b0:45e:f062:8369 with SMTP id
 5614622812f47-464bed6e95fmr2097440b6e.12.1772217725368; 
 Fri, 27 Feb 2026 10:42:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb59b66fsm2541713b6e.10.2026.02.27.10.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 10:42:04 -0800 (PST)
Date: Fri, 27 Feb 2026 12:42:02 -0600
From: Tom Rini <trini@konsulko.com>
To: "Lee, Sin Liang" <slee3846@gatech.edu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Kim, Taesoo" <taesoo@gatech.edu>, "Zhang, Cen" <czhang887@gatech.edu>,
 "anshuld@ti.com" <anshuld@ti.com>, "bb@ti.com" <bb@ti.com>
Subject: Re: Security Disclosure: Multiple buffer overflow vulnerabilities in
 NFS client
Message-ID: <20260227184202.GZ1593142@bill-the-cat>
References: <MW4PR07MB86367A3DBC308E10144FE6A6AA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n5n/XRN52MBhifhG"
Content-Disposition: inline
In-Reply-To: <MW4PR07MB86367A3DBC308E10144FE6A6AA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
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


--n5n/XRN52MBhifhG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 06:25:14PM +0000, Lee, Sin Liang wrote:

> Dear U-Boot Maintainers,
>=20
> I'm Sin Liang Lee, a member of Team Atlanta<https://team-atlanta.github.i=
o/> from Georgia Institute of Technology, winners of DARPA's AI Cyber Chall=
enge (AIxCC)<https://aicyberchallenge.com/>. We're reaching out to submit a=
 vulnerability report that we identified using our system, ATLANTIS, in you=
r project. This effort is part of DARPA's initiative to apply competition t=
echnologies to real-world open source projects.
>=20
> We have built an AI-enhanced CRS (Cyber Reasoning System) for automatic v=
ulnerability detection and repair. Using a combination of targeted fuzzing =
(via OSS-Fuzz infrastructure) and AI-assisted static analysis, we identifie=
d four buffer overflow vulnerabilities in the U-Boot NFS client reply parse=
rs (net/nfs-common.c). These affect the current upstream codebase and inclu=
de a signedness bypass of the mitigation introduced for CVE-2019-14193.

Ah, so that explains the squashfs report last week. I am glad to see
that part of the challenge now is fixing and not just reporting the
issues. Please see
https://docs.u-boot.org/en/latest/develop/sending_patches.html for how
to correctly submit patches to the project. And while we do not
currently have formal guidelines around AI-assisted contributions,
please see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/coding-assistants.rst
for how the Linux Kernel expects things to be attributed and note that
we also are requesting that the commit message be human and not
AI-written/assisted. Thanks!

--=20
Tom

--n5n/XRN52MBhifhG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaHldgAKCRAr4qD1Cr/k
Cnh5AP9j73OGQzKKxCCLZtHdmpMLGplw1OG8M6RZZmYi5Q8QUgEA9akyoAHe9ADS
xaRRKbgwxpNZEVeC1OUeGaapWj10bQU=
=aeCG
-----END PGP SIGNATURE-----

--n5n/XRN52MBhifhG--
