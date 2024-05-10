Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737E7C25B5F
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 13:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA62288669;
	Fri, 10 May 2024 15:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q7cUedcT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF7A88577; Fri, 10 May 2024 15:08:31 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73184884C7
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 15:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-792ba098eccso144445985a.2
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715346508; x=1715951308; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zXDjMCfc8BSuZRT8mus4PhXHasLoYuNP5hfgdfQfI1Y=;
 b=Q7cUedcTYzMeTMyNAN4ckq4tlSe357+AtGX/xBrrKBURamtiCVKQqjIDXbLJ8oMENY
 T0yKeYTo9YZPe/CRQq1mqj2JHE04Q6OTl6zGLWgQFImghFmxQEdBn+cxwd799oSRiYgq
 7f9rjwE5A3VMNAX3gGb1fjr6PmsAITz2dgAJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715346508; x=1715951308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXDjMCfc8BSuZRT8mus4PhXHasLoYuNP5hfgdfQfI1Y=;
 b=aX2enCqFZQ0skk3zW24Ef7eeTAjmNjXIGFgTG8CO9jbsID7UUP+ataQ+EjDa4BPX5q
 rmMuoJY7EQy69GASv7h5QDughj5rUPwFyrbLUNnE+i4SW8C8q4H0mGj8g/0pg14NSqRN
 m88copKAwpc4OZpGdEXQlyg4ZCpBcViONqn984cDSGeO70+SXWoB0dVzfrZGCDEZEUHx
 ZI8AQUw5wyRD4ZjXBIoC+c4GIHDqkc539N1DSn/iMT0j3SsryY+r1loPxptkYl5CEsYK
 dGhcbmIqw6zi3+dSbUHQ1YqMMi0rHzPgQNeEIeOU3eCx+eTDGubpbk5Az4so19EY7d2D
 2uiw==
X-Gm-Message-State: AOJu0Yys8F+GXt8Wh2nLTLvML6cayZ8UxtvTaAhmlqe8TwJVE3uur/v3
 1KOq27TYJYbo2sKgjmJZLMKsExziGyGZZ+7QLSHFfdQzJJua8aVNyZ2zACaLxV7mgQGzFcGIahO
 aPGE=
X-Google-Smtp-Source: AGHT+IG6uW+P53/VKMMnvr6KzbZCqT/FqVeG1TtvoTK9zl78700Yij0ZEV9664/RsK4aKNpJQdGtvw==
X-Received: by 2002:a05:6214:2d48:b0:6a0:af07:1076 with SMTP id
 6a1803df08f44-6a16825d792mr25133136d6.60.1715346508328; 
 Fri, 10 May 2024 06:08:28 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f18543fsm17166906d6.34.2024.05.10.06.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 06:08:27 -0700 (PDT)
Date: Fri, 10 May 2024 07:08:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] doc/sphinx: Bump Jinja2 to 3.1.4
Message-ID: <20240510130825.GS2568172@bill-the-cat>
References: <20240506212230.2948754-1-trini@konsulko.com>
 <d36435ea-74ac-49b8-9d16-9494e8ed2cb1@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Uj59uChdfCszzppG"
Content-Disposition: inline
In-Reply-To: <d36435ea-74ac-49b8-9d16-9494e8ed2cb1@canonical.com>
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


--Uj59uChdfCszzppG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 11:32:10AM +0200, Heinrich Schuchardt wrote:

> On 5/6/24 23:22, Tom Rini wrote:
> > While we unlikely to have an issue with CVE-2024-22195, it is simple
> > enough to bump our version of Jinja2 to receive the fix, do so.
> >=20
> > Reported-by: GitHub dependabot
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>=20
> Hello tom,
>=20
> My review queue is rather empty. Do you want to pick up this patch direct=
ly?

OK.

--=20
Tom

--Uj59uChdfCszzppG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY+HEkACgkQFHw5/5Y0
tyxmNAv/RwN8iXVXj8iZj9/C0rv+1mLIiaWAGpONJEwCCmrKdv53cjQOv7+ob1A1
pk7qpP9ZhJxFMakLlFI01OSETPoq2aST78g9/3a6Kp4dsWdPKW1XSxELBAzvCOYQ
6F9bhvTIx4Oj/QY48Xreg212aJNE5ESakvqHBVaB7K8fTx9X5r4igZzcKTFcY+uM
PYS6RT0EyPRxyMtbHzr7RAzs54cnZPZGcVYheVmvabf1plPlKeSbtb9rvlyNpp1i
FwkVVv0Rc1HIpl1jgVQrP+1RA+Ie0qN/y2pQ5+OkJLRROX5kWtAmE1OlATf2FnPX
QdKrHC+t9xJg8xmH9Z/gOKkUgiH82HL2PvWUZDSoSbXXiM5UvqiuFDnevgYmlaIT
Og74TsOJzT7T+pyKbCs3gz1DHQdpG4SFfHTIpVDRTf0bnXmXoXQycL7RTdRWwW7n
rdpUjPYUK8ry44i3Hne8XlT5cDwMmZ87uuhTHodtnZyxW36cqOdqOeDnZXOqxk9y
nnTEG8nx
=eg5h
-----END PGP SIGNATURE-----

--Uj59uChdfCszzppG--
