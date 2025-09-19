Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2537ACAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 14:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B160E832DA;
	Fri, 19 Sep 2025 16:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jnw3dpPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E488319C; Fri, 19 Sep 2025 16:11:17 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD2D8319C
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 16:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30cce5be7d0so994910fac.0
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758291073; x=1758895873; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xRr8d+1QAgClDJCADiKo+BB8hr9kKqdHnu3q3Tu5dQU=;
 b=Jnw3dpPcup1OGy/a7TddXEsZ4HOhTVwv+8zi52PJhz/E2yIXa4nFLoEUd6jxENZ1N6
 fagIL9vvi1nieN2xavE3unj/aJesEd1GAI73ty1ennpB49Z0ZNc2E9qw3A8lMQw6qkEV
 Yy6Rkyj9AB//3HaMVOau16Mq+fjvdJhZ5Zq+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758291073; x=1758895873;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRr8d+1QAgClDJCADiKo+BB8hr9kKqdHnu3q3Tu5dQU=;
 b=Qpt5rJAFqiisOF9grRuRInCjEyEQ4uK64OTD07lf9rTfCr3ej0IJrz6FzXVG+q7U4/
 9k80W6brPZKf0jrr/gSHeYoaMHCb6Cmn66oHNVXP1X/K3DdsmL9LiLCcY4L3jRgryen6
 +T7ByCbb6UR4WCJRcIwlKS571Vepu/P+H5XQdIHIDpgnSwehJMtuXstLLrG1xL7HBMto
 2TLaiQtOYZMrEZ5U5pNOiIbiYXrTMv2u/HjhX8IMyVLgxLA41904YjcpIUtnDIVWbINL
 SzdvQVOwa0KP+0pEyhCCHDIW9Suc8fLlzbZu9C/ej3AbETMCFn/AdIgaxQ+9D4xBJOSP
 FyYA==
X-Gm-Message-State: AOJu0Yzlj2zaZJzVLlxgh3qYE9lAaJMeerouzTxZlbCf/BMD/5ipNRUS
 4p4mD71VCX5pgpPSPbWTF3eL09cwukIjpzACkNTuvnrHOMan7yAMzJkDmKzs9VzJUyUY10A106c
 1KMozmUw=
X-Gm-Gg: ASbGncudYixtvn9CgWihInJhMii39mqYy6qWDmyW0ew4prAJ3ALMzfXcUSRmuhZFQ50
 n+tY9TWZEt8p/rcCqrH83/tsaBNoZDuFk/VxRLvWp/B0z8leVcH2tHz8jgTJDk7EjBtZ9v2gjgy
 Wl7HFhMbUK90nbTv2t6XM29+CehZaYrVHtEYHF2mGjMdiUp8GLx6gZLLD7lqh0jljmHnQXulwJr
 TiBcH/mfGzXgi2Eh7y60YQHz7nmklAuae+lx4KUYKzNiQ0GqxL0mEibFPZDj+ypyDH+OG/0mN4Q
 FTPc/f2rhiGw6BDRqr3VlPpUKTBIRNkPhIOgLluMWVv5vTzGsmls+PfykMIzmlqiAmvDVtCpu0/
 mMyQALmh8aef8lRYW7uJ8wEU7VO6/XFra3Uh7i0kgWqpRq+Adka4E3TTW
X-Google-Smtp-Source: AGHT+IGkGJ/KzarLvpC2gdcKobrD+3pbV8b01FE8bETmixaoFLVqZHbTrtz4hH7CX8Wm6uID73KLpg==
X-Received: by 2002:a05:6871:79d:b0:31d:8a1e:78ce with SMTP id
 586e51a60fabf-33bb4101b5emr1842429fac.16.1758291073375; 
 Fri, 19 Sep 2025 07:11:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-336e5f5464esm3203044fac.25.2025.09.19.07.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 07:11:12 -0700 (PDT)
Date: Fri, 19 Sep 2025 08:11:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot next / v2026.01 =
 u-boot-stm32-20250919
Message-ID: <20250919141110.GU124814@bill-the-cat>
References: <e7ce25bf-c64c-47bf-be8a-158756058ead@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yepcOsIdH4HAwZMn"
Content-Disposition: inline
In-Reply-To: <e7ce25bf-c64c-47bf-be8a-158756058ead@foss.st.com>
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


--yepcOsIdH4HAwZMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 08:36:18AM +0200, Patrice CHOTARD wrote:

> Hi Tom,=20
>=20
> Please pull the STM32 related patches for u-boot/next, v2026.01 =3D u-boo=
t-stm32-20250919
>=20
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeline=
s/27668

I just noticed to start looking at this yesterday. The 'tristate'
keyword is meaningless in U-Boot, we only use bool. I've fixed this up
in the merge commit.

--=20
Tom

--yepcOsIdH4HAwZMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaM1kfgAKCRAr4qD1Cr/k
CnpoAP9WBsHruv18znFfp4ARiAViHqwG4MyZKh272malQuVwhwD+Mx/FPOrxGWqW
ikOgbZeVdnrdzAEgNZhI+geBwjRfuAE=
=yX7k
-----END PGP SIGNATURE-----

--yepcOsIdH4HAwZMn--
