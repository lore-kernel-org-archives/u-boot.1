Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480DEC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 16:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E7E82BB4;
	Wed, 30 Apr 2025 18:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b95Gb4Vg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323EB82BDA; Wed, 30 Apr 2025 18:32:03 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E60908215E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2d5e5e21b92so67218fac.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746030719; x=1746635519; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U4d8hR1dgSD0e5hbZx9v+oH1/Nglw0X241uwebZU7nc=;
 b=b95Gb4VgJBCZ7mFKC98B+XaUc7jqYv/JxmVpx4lMx96qNMO+h+W6aqP5piVc2LycGW
 zw9MwVLlX7hKM0T2HIxLsJXXCvM4goWQdv0nTNN12NRG3svoExur1zYKcpikpog74q2w
 /bMlLzcaFyejK/Etg0X+QzIYAr1UMtXswUjVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746030719; x=1746635519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U4d8hR1dgSD0e5hbZx9v+oH1/Nglw0X241uwebZU7nc=;
 b=b6Gq3HrnDAALtE9QUEv86JDTrPVO94e0FTBUhH2wxDhAP9HkJcliV18X28Drij84eD
 eTWl6wGGolQA9tHe64IlwnDZt8pxO9MK1dWOQ707DW3wrCcKgb+tIx73uprWXPQErcoa
 8zcv0aFe8SHjm5GlDuLFYIbGI9Y+BohKDMwHR3BedBrbFrjtUTT4eyN+3wv9r8r/Kc6o
 g5zDckV/zb/rc6diIxr6fNDx9xyISBHIk8NXfqcaK06dRtwfxug5tUa5xvweET1qU/XX
 VdWjFdZKYzEUPfqX/15UhDqsY+WnHsGlm0fw6abSHyVjhEgAhj5UEkV7mceBQX/38mBP
 pyvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDD3+KFou9buzsexV8VWEHepz5rqHXY3V+wi9mumag0+TBPUZrFjGV/uF+d9Wj2GcjigGr4cE=@lists.denx.de
X-Gm-Message-State: AOJu0YzI7PamJs5/MLqE8L+Z60KjsmqSaqeYHMAwGMFQX7UrThON1sft
 bw5v7kJgqqaJikN7MUqLj20PvrxXaGCzRUWX/iA+uYusrxPvZJw97G4zbV8gpUg=
X-Gm-Gg: ASbGnct7Pgrn09t3gtBp1vtakpJd65GnKT95+l2PruPT2oe3QPQ5l5uZfUCyurGGc/a
 +sH00DIwEjirRqMvXmil+E+hlSuMFRFmdo8Dr1ApBNpTs7VJxin/mmgYaiAuZ4KfVynYjGwOgoG
 1i4Ih7OH3tAw7Y9kfJvYOe2D9kQAo+SZ68aLS0K+4KI+9YJLeb0QpctAZB+G2VOyhPXx/CnRpoe
 m0TicDhm+OoH8Kmvz5vTvlplzvxLAGSRJeZZUF6SC/2yS8vnNE4ONLRhp9BZFQRB+TcI3XX+dw9
 K90yqoOn5Q0Nj8/gLxjneRBX8W7472b5IiX8ZHqfyLyD2XCkU2yWYOzcmRAttilKX3HaQJh7zIl
 fig==
X-Google-Smtp-Source: AGHT+IEQeJ7WIuyHXMJlX3wYI6VCBpzGq4fwO8OVlc9Vv11fjXdc/66e/QAvs+ysW3L02n1x/4e+uw==
X-Received: by 2002:a05:6870:c6a7:b0:2b8:f595:2374 with SMTP id
 586e51a60fabf-2da6a3ad048mr2362035fac.36.1746030719459; 
 Wed, 30 Apr 2025 09:31:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2da6e0523d6sm514308fac.6.2025.04.30.09.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:31:58 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:31:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
Message-ID: <20250430163156.GV1261075@bill-the-cat>
References: <20250430135751.2626849-1-anshuld@ti.com>
 <20250430162904.nmjqomr2kmxhllfc@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0HcgcP5Z132W98rK"
Content-Disposition: inline
In-Reply-To: <20250430162904.nmjqomr2kmxhllfc@bryanbrattlof.com>
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


--0HcgcP5Z132W98rK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 11:29:04AM -0500, Bryan Brattlof wrote:
> On April 30, 2025 thus sayeth Anshul Dalal:
> > As discussed here[1], the go command causes undefined behavior when used
> > for running custom OSes since the icache might hold outdated data. OSes
> > usually also expect the MMU to be disabled upon execution.
> >=20
> > Therefore this patch adds a call to cleanup_before_linux before we jump
> > to the loaded program/os which disables both the caches and the MMU.
> > This makes the go command's behavior consistent with riscv platforms.
> >=20
>=20
> I know quite a few other OSes are beginning to use U-Boot (QNX,=20
> GreenHills or all the other RTOSes) each with their own requirements=20
> from the bootloader. I'm curious if we should make boot* a little more=20
> generic rather than abuse the 'go' command.

Well, that's what bootelf is for :)

--=20
Tom

--0HcgcP5Z132W98rK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSUHcACgkQFHw5/5Y0
tyz+/gv6AgOApX148b7Wfnj7erpbSZM+kTcXGI2WYczdWYYZAkZRf+RKLUEPHVlM
bxVI8M1qXGFQ+hBS39Tgp0f+HF1S9Ye6TKs5OsbKgJMPnFkeQ8farjnNCD4n9/6F
e8pJoV19Xo/zfz/75imWKw48YJe8aeWSeSW7ulmDrRmFgIyjVqEx+yMDW1+EgtMM
jQsk7e66ILG1HsZQAdtP2Wt07tkRBgSF/laInt90f5IhnHjXZuv92iLroz13ee2b
qdZMpTe7+wmzusi1IUFrAct878/SRmpSaPLDOA/HBqKx5hm6yzEgBaSl4aiJv0qk
REh/cY9DComp78Yvd+/vKlw5d59oHubxz6HSvG3OKdJztM+M/y0fPEMaIrIvPgjP
QnkgHkBrMys69FtYUVIE04EjUuiJGkvp2SCmw8ObCCvnf4b+JzUDjHJXihzwTLf2
3pofAEp+4FxpTvsatLzvgDYuLCHen7Aq2GnbA8cEMNeZkskfsMd55xr1K0czSSCS
GK7tnIBY
=RQVU
-----END PGP SIGNATURE-----

--0HcgcP5Z132W98rK--
