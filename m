Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B09C79F9B
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 14:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CEF98399B;
	Mon,  5 Jan 2026 15:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y1DtSgr8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E668399B; Mon,  5 Jan 2026 15:15:53 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A9D83700
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 15:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e8819eda8bso5125335fac.3
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 06:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767622550; x=1768227350; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PMJo05SafHS2RgrNkiaShqGEI7d25fXCnQzuY/xJnJc=;
 b=Y1DtSgr8k/pHVrc8mL6OhKn6nQ511QX1TG2Zoi5Q0jGySCm4YBY5A8kKOhPOugVccf
 +4ELAstFyiLzGP/UDY6gOk27Yc+EEtAexl460Cn25L7qGUNVv7NFU7eUD+iDXN7INY8u
 U3zgEXFvFa/tPkQwSyPDtbDI+O9v9/BBbP8Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767622550; x=1768227350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMJo05SafHS2RgrNkiaShqGEI7d25fXCnQzuY/xJnJc=;
 b=MQxfR8Yrj4HkQkTcAiNZnprUX9X2B+GPVIrIyS+KFSJ/BQw4bIqfdo35nRw5EfTBwE
 xgWEl7M+yGwqXpbtHAMPhoXJ6iWuQ4T+a0xdLnK7JOnyllMs6cLDW3iiNh4rq1xoXfUY
 Bd33o6MnEND2j5wd0bb8dVBQDgPIGCRmfcMAG7II6ajUedKIcDI/GRvgyQr7nUnVFbv+
 Jjpz7Ipcj2RglN2F61b9MlhC8/p+qa+DewXzUwlACt4eb3R8yidFE75dsY3dWJW5VO0s
 W6mwe7w7SMPLPnNoi9E52ik4csF/STZs3fUj6JaHAQZ5lRUNxq9q9GL460NG1j6HujKV
 WnDQ==
X-Gm-Message-State: AOJu0Yzzem1CshI3kSDwnwpp9Q+oaGfCl+w12z4b9cYK9eBHMaeo39fN
 xYMSldoeMLhQmDK665E1lOyXvYPajSkPk3JlBk4tBIiat7N47t6XtZUl87G1GOtAXtTA+U6zR+w
 B+i/jzKg=
X-Gm-Gg: AY/fxX6Tjip0kx1fxbUZSa0xQlME4ta8eDkU1VkIBrKRjFLNJZ4qKfOEqOZ8JyIDhg0
 p0lF2B/fE9WVJMSoCaHutrPVN7uX3DGwCgMOZKy1KCqAYrDavp0TLhqNgzqpU8t/AvGdgLN4+Hf
 YHCSzW3pN7k0X0zcLU+ciUS1tYd4G6eGtoCa1izAD16B2t4XFN6j4MsEGQGDUumxcd0Kj7kk9h7
 Au0T2wON7KhXVK4AUQbEyrIjfXv4P94GuKGWuslEPLVVhuQn9J7p6d+RUcjxJRXNgj/Y43nBMhs
 oXoKZpMDuv89rPHU/vup7m38V/Qb7TF14QvlNmbTHe5GFwIwr4M+AuLEdxszFY9BO/yM0TTQqpg
 JNXTCG2mL/r9j6Pjn/tl63wi+sQsXlus1/3CGSdf60cjlu1mF8IeSUQG8QeVaH8OtAoSFENhAeX
 YV9E6L4vnaDtTMWplV0R0qsYPmZek2krzMDQd6Jk0rfnTVc0+Z0wT9x2tsBzGXPmslkaayBiYVm
 gG+PR3xPasjaA9EDIm8hCZ++6LO6ZzegVfj5IE=
X-Google-Smtp-Source: AGHT+IFZn/aB292tlfjatt8BRJYaCeLXvaB04aTVxgsCOHUV0dqFXif0DRZeRacfwvDfqu1uZxmMpA==
X-Received: by 2002:a05:6871:385f:b0:3f5:4172:1d with SMTP id
 586e51a60fabf-3fda5944ba2mr24018847fac.58.1767622549673; 
 Mon, 05 Jan 2026 06:15:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa931b0esm31073363fac.8.2026.01.05.06.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 06:15:49 -0800 (PST)
Date: Mon, 5 Jan 2026 08:15:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Jun Chang <jun.chang@metanoia-comm.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Subject: Re: [PATCH 1/1] board: mt5824: Add initial support for Metanoia
 MT5824 EVB
Message-ID: <20260105141546.GJ6124@bill-the-cat>
References: <20251230030328.215240-1-jun.chang@metanoia-comm.com>
 <20251230030328.215240-2-jun.chang@metanoia-comm.com>
 <20251230153115.GR710860@bill-the-cat>
 <e4a70eae-37fd-4648-bb17-66975c6d09af@metanoia-comm.com>
 <20251231143404.GX710860@bill-the-cat>
 <c3d448db-54ce-482a-9d34-47395e415881@metanoia-comm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/Ry+arS8gLnbtF00"
Content-Disposition: inline
In-Reply-To: <c3d448db-54ce-482a-9d34-47395e415881@metanoia-comm.com>
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


--/Ry+arS8gLnbtF00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 07:39:44PM +0800, Jun Chang wrote:
> On 12/31/2025 10:34 PM, Tom Rini wrote:
> > On Wed, Dec 31, 2025 at 02:32:45PM +0800, Jun Chang wrote:
> >> On 12/30/2025 11:31 PM, Tom Rini wrote:
> >>> On Tue, Dec 30, 2025 at 11:03:28AM +0800, Jun Chang wrote:
> >>>
> >>>> - Add RISC-V target for MT5824
> >>>> - Add board defconfig and DTS for MT5824 EVB
> >>>> - Add SPL and U-Boot board support for MT5824 EVB
> >>>> - Add DDR init for MT5824 EVB
> >>>>
> >>>> Signed-off-by: Jun Chang <jun.chang@metanoia-comm.com>
> >>>> ---
> >>>>  arch/riscv/Kconfig                    |   4 +
> >>>>  arch/riscv/dts/mt5824-evb.dts         | 232 +++++++++++++++++
> >>>
> >>> What is the status on upstreaming this device tree?
> >>
> >> The device tree is able to boot to U-Boot with shell prompt by the JTA=
G.
> >=20
> > Since I wasn't clear enough, I meant the status on getting this in the
> > linux kernel tree so that OF_UPSTREAM can be enabled and we use the copy
> > found under dts/upstream/src/riscv instead.
> >=20
>=20
> Thanks for the clarification.
>=20
> The device tree for Linux kernel is not yet submitted to the upstream.
> We would like to go with the U-Boot first.

It will need to be migrated over to OF_UPSTREAM and really should not
just say in U-Boot only. Have you at least started the process
internally and for example run "make CHECK_DTBS=3D1" in the kernel on this
to catch obvious problems?

--=20
Tom

--/Ry+arS8gLnbtF00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVvHjwAKCRAr4qD1Cr/k
CuiTAP9zS9U9OFTMEXZ5PvwleIAiJOASF85+3lERCZvi48Uj0QD9F77aDl13bFVp
Qmz7qEpjf/Uqe9Whnsadwzfk0NTlYg0=
=NSCs
-----END PGP SIGNATURE-----

--/Ry+arS8gLnbtF00--
