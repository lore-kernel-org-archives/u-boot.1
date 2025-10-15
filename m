Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5E6CCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 22:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DDDB8323A;
	Thu, 16 Oct 2025 00:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UJZDkBvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7AE829E7; Thu, 16 Oct 2025 00:19:39 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13BDF829E7
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 00:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3799fc8ada6so36860fac.1
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760566776; x=1761171576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hpiHJQ90iSDFTRhYv8QTU73TkuVEd9ObQkHs6Bk71NQ=;
 b=UJZDkBvQGCfrIv/WyLbK6YjkFMZVl+DhB8p5ShZ9oCh44xpyykN936cIUp+NZB+3SI
 tcuPLwDqygS7SJVwuukwIPDV6nIGBxmD8M5ARH/36na5iVXHYU40Hxq8mLcXv3XxTu6W
 XJFXVzJRkZrupKaPmTJIGSVGYK+5vQ/JbMCaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566776; x=1761171576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpiHJQ90iSDFTRhYv8QTU73TkuVEd9ObQkHs6Bk71NQ=;
 b=BjRRGgTP8n5CrNCOsRc7ZkmMfA540mocK4AIOKNz55ZR+Y9uRtI02Zvmr2C3dHDAFv
 X41+S3v14rXS2oAPHrexUhx1wE3OF1WMisvmo5QQorXpye8i5mjhN77JHgTQj3i5LkOU
 8rXFbgwJ9m/8AAxtPl0+RTIS9+sMTrx/dm6nnAkZLjVI8EI8NAS2eufDT8ecjFowXCe8
 5Inq7+wcp7aOk07oJAiuIs5/T/3iCbK/4LSWENa11MYHstTTevhrnXolALT5EIF/3n6O
 wvgKOjl1gkJk2yu+z3ELgc6M0wlPJYFY7kEvxALU1g9DxBmzwWWJLm9011dEa96U1k/o
 i0vA==
X-Gm-Message-State: AOJu0YyovNEqSdSll2po+hde4MOIvHRpLYq4brJ5yYzQL5h7FEcltDHR
 GZp0n/S9V2jAmzqU26HHqqHyJs7dl1a3WBtTpiKfsFtkgBac0oO4LFZ2ZyPlvQapYOA=
X-Gm-Gg: ASbGnct15rx01nA7tMGUNqA4Ij1fbUwlsO1INcgZQatCrzjhBf6W8mlxBBmnbiAztzT
 cOevyztPFyaekTznC0INSJEld2z1fCoM0JjPlslWlCYrwbESuwaPRB0q/HqweBWWsO7sJf3qKcm
 WyBKV2hELciyM6NAUziB9qZJJQ4b1KEiMBZC3j/zMNJPeo7jm2q7Jdu1nHG4UOcvnIrbYxYyfFy
 znK5ngrVsuE0IlzZzkkZzFe/5QykRkDlV0u2UdihumETPD5RB9IuuCvfRKSb+kgmIUsszcRr+oD
 i9vSuq1Okj7tssKlYEUtRWO9O1NlnwtISn3FOtOoU4WEgr/nYxhsGcsp1ANPuj4LY1vIQY26Z++
 QfjDHDkvUoxBUmGdh/ZmlTAoD7yhPMd6/wMIVsMt5Zmri2ZKdyUFOyF2GlN/Avp717x/Vm3Uc4A
 untYAAyYFq7Ju4khLoph5gAr3BAkhRO61C+symzzM=
X-Google-Smtp-Source: AGHT+IHDZ4sNvyrhvdmP3QnPVLOukWQZdrXidG9padQ5QLFPJyPHzg7DxOvlTIcZXyXp8xBYwihyww==
X-Received: by 2002:a05:6870:17a0:b0:332:8989:4ef8 with SMTP id
 586e51a60fabf-3c0f6d386c8mr12321941fac.31.1760566775783; 
 Wed, 15 Oct 2025 15:19:35 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8b69aa7sm5737658fac.9.2025.10.15.15.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:19:34 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:19:33 -0600
From: Tom Rini <trini@konsulko.com>
To: "Manea, Alexandru (Alexandru)" <amanea@avaya.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Uboot upgrade from 2016 to 2020
Message-ID: <20251015221933.GW6113@bill-the-cat>
References: <SJ0PR15MB475808D1A536E7E2993BDD1DDCEBA@SJ0PR15MB4758.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bkYH23d5+kddtODb"
Content-Disposition: inline
In-Reply-To: <SJ0PR15MB475808D1A536E7E2993BDD1DDCEBA@SJ0PR15MB4758.namprd15.prod.outlook.com>
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


--bkYH23d5+kddtODb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:21:37AM +0000, Manea, Alexandru (Alexandru) wrot=
e:

> Hi,
>=20
> I have an issue with upgrading our sources to use the 2020.04 uboot rathe=
r than the one working now on our system which is 2016.
> After adding all our board changes, I can see the SPL loading and setting=
 DDR and TLB entries but once it tries to jump to uboot from mmc_boot() it =
hangs and I can't get to see anything...has anyone encountered this? Is the=
re something I can do to make sure uboot is actually being jumped to or why=
 the hang? I've set the offsets to go to the _start_e500: instructions like=
 the old uboot. I can share the traces I have if needed. Looking forward to=
 an answer.

There might have been some issue with certain PowerPC platforms
introduced after the v2016.xx releases and fixed later than v2020.04,
and git log might help. Of course, it would be better still if you could
move to current mainline and then help with PowerPC maintenance, as we
do need more people helping there. Thanks.

--=20
Tom

--bkYH23d5+kddtODb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPAd9AAKCRAr4qD1Cr/k
CgNDAQC3dKDtFp1YKQ8fOf0gZaB2KGoubnWWJtEHj+klN6X41AD/cNi8XhWe2DdB
fHZErunR6sB7EFCuwXurAuZ2QVQXAw0=
=KIF/
-----END PGP SIGNATURE-----

--bkYH23d5+kddtODb--
