Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36808CE7B12
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947E5840B5;
	Fri, 14 Nov 2025 15:16:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nrL07CeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3331A840BD; Fri, 14 Nov 2025 15:16:04 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1690883EF2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-44fffff5f73so1526549b6e.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763129760; x=1763734560; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ub5Jv6rhU3EbLj80BbO1rDhMy7xJix3Lv4EV9iHOLAw=;
 b=nrL07CeJhg577snv9bmKhGqvceNRs83TteRWVKSB4GOsMrFXPNbOHiNQ5FmxpPv4Tf
 qKYuQUU1GZLsh8t/F9ZL1GQvCCtbUo5gxuryY4mPYu+X0T7lYBSkHYgtfwv6zEF8tBvg
 D3okejhe5H3rFNGedrQnn+lR7aM3V4Wng56ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763129760; x=1763734560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ub5Jv6rhU3EbLj80BbO1rDhMy7xJix3Lv4EV9iHOLAw=;
 b=vm6yDrjVKHhjbLucho2v0WlADvcWnCv6PRtR9WtVyaWRrVwH4IRbd0qNaNPCCbEtJK
 +t4PNwqwNrxIvMxn0GaeOf6TU71AzUAlaYoxq3pv2gb3sk6P8HS5DdPUb9LJQlQ5foVq
 6Nhz+kMHjPeXLEECrO26YkLJAt0QTHThItm64IzUFWmJEM1JjwAhEXEzJI6feMmGmfvk
 gnlylX2RpcrWJgzimMe9/cYMdt947cTWmfMDLXgYwUKzG8AMezhOsF6SzMlBq8/fuoCY
 V6kILmRPy/ZYVStQIqHoplRicCQ4JtYWHfzK6q1SkiP1e8zb+0CVavM+AhrYVXW/Jpzg
 JrVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnZV4hhOMZn5h+DO37O+YUn+nqXBELYYnT98SvIt/qV83b4hLZNkvSJEmljSrdbD3OmOWI1Rc=@lists.denx.de
X-Gm-Message-State: AOJu0YzuppaKL4v+HTCVocDjSjwFDVheo0ILv2vxLygnToyWoeCz7K3r
 MXP7TAhRBM3EZxlFz9KkCd7IDKRw/nZ8EsJH7W2xmJ+B6kWZas1pjQcgxUXd1Uk2UjE=
X-Gm-Gg: ASbGncuSm0Tlu4hNHBB3PWg7kwui6QGn/Eat7+wImX20sZQ0b/+Jsp0ViulXvyoGXM/
 30hkkazOze/N4nkvU0uCFa9hrYRCfkyxnPxeoGs8oXgnWgbsqBSBGFKXRiNzz0Cam9tHiJIFxtl
 xjyd41jPIMpOycuH19pvpj+ka0aVrPWSDQQu64OUIOSwJdlpfb19QwtbrFoW9nObtCvAJU4Eczx
 BycLo91zbypmfoXQaESIN0jbQ/E9etIXvv8ZAhJ1JjT+m5p3ov2xl9ZSLACyDmRI21r9Rv08ZFb
 MrUwcpHYia+0HT7FmE6c2uGKPTyAp+sc/LzL+4tDEHWt+EP5/8BHB1B/nc/CEmb4fuXq6Xm9gZR
 9kCvBGpjI8B6CzvkCfrOa/z6BD0nIexRSb51onaD2g9ez0mvZoPGUlRCe31qkia51Fz706wWS0K
 jE8pKwbK4DiyuhHLV1yl3oxV0it++RbsrFNzot15g=
X-Google-Smtp-Source: AGHT+IGz0SM7MqGJVln8+E/GZvYnqlJNFdVqn58aab/TkVa0xXfeTpk0Xtj+AB9oM5k4mjJNlvK9vg==
X-Received: by 2002:a05:6808:2208:b0:450:5e3a:6f0e with SMTP id
 5614622812f47-45095d11070mr1801528b6e.9.1763129760379; 
 Fri, 14 Nov 2025 06:16:00 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a6df248sm2003666b6e.22.2025.11.14.06.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 06:15:59 -0800 (PST)
Date: Fri, 14 Nov 2025 08:15:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>,
 Simon Glass <simon.glass@canonical.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Claude <noreply@anthropic.com>
Subject: Re: [PATCH 2/6] fat: Separate fat.c from fat_write.c
Message-ID: <20251114141556.GT6688@bill-the-cat>
References: <20251113064656.245394-1-heinrich.schuchardt@canonical.com>
 <20251113064656.245394-3-heinrich.schuchardt@canonical.com>
 <GV2PR05MB11941F7E4872C47E87283CCDB83CAA@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <3090dfe9-8f44-459f-b2c5-193b9ccda5a2@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QcgG5nxszBTC7v6m"
Content-Disposition: inline
In-Reply-To: <3090dfe9-8f44-459f-b2c5-193b9ccda5a2@canonical.com>
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


--QcgG5nxszBTC7v6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:49:47PM +0100, Heinrich Schuchardt wrote:
> On 11/14/25 11:55, Maarten Brock wrote:
> > Hello Heinrich,
> >=20
> > Don't you run the risk of getting into namespace problems when you make=
 these
> > static functions and global variables non-static? Esp. the ones without=
 the word
> > 'fat' in them seem to be in danger here.
> >=20
> > E.g. downcase(), cur_dev, disk_read()
> >=20
> > Kind Regards,
> > Maarten
>=20
> Thank you for reviewing. You are right. These functions should be renamed
> with a "fat_" prefix.

I'm still working with my Claude-using friends, but I'd like to point
out that it too doesn't like the namespace pollution this series
contains (and so is part of a higher level problem I have).

--=20
Tom

--QcgG5nxszBTC7v6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRc5mQAKCRAr4qD1Cr/k
CtdPAP9nZt01+cvV9K8qG/lboKp5i4NMdNttDUhnt9W3MnqL2AEA0OqjEtVhB/sT
/4CXAfEPouK1eUVjjbms11+CO0WZTgY=
=o8tW
-----END PGP SIGNATURE-----

--QcgG5nxszBTC7v6m--
