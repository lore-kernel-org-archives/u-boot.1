Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10606CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 854C183C70;
	Mon,  6 Oct 2025 17:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fHR5Fvqi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB01883A8E; Mon,  6 Oct 2025 17:33:42 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D1283A8E
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-91524f5e6a8so433810439f.0
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759764819; x=1760369619; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hV/03utq8lkAYr03ncAlIurRZqCy/+9rIiKqRshVgW4=;
 b=fHR5FvqiDw4FgfdWIL/or+7Rk6AzHPdpl9Df2CSATgqG/L01SgBmF5yxFrRD+ADbub
 KP9dppQnhx4Iuy1BUPnf7pynbhtTZI+pmJNnlkRc9+9C4vQvPFQFlo0mpV55ubrLaFYd
 saa9incQN52fDTBkLJ+WkaOOKFIjK6fQU0IW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759764819; x=1760369619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hV/03utq8lkAYr03ncAlIurRZqCy/+9rIiKqRshVgW4=;
 b=r4pIAUUxWD7HMfv/vtGFv6IgGZSFWARUD4g98p3QrqUr981efO9Ou59VusCBed4JEp
 fS+cv2oZAntvPBNZ7MeQgyBva0fagnP0jKzBALG3rdWTmnuj8vKS/25ZdQOlhadoK0wd
 et4g6KejGuqPVeLzU5g5TxZOOiyJqGunBtAwxPU86V0+lGqvBy8K6yd2j6LojCakPgPM
 Qo97ax25wg4dWkhXx+QAiwx/al8uPNDk7J7zqE1H14PpNCmpiJfsGIgJdAh83uQZwsqq
 6G3BK8q39dC+X9boCdFSVg79BTOoaSOMv5acx20GYaaHixMH1W/LYIOTDBVCKeulP4de
 9qhg==
X-Gm-Message-State: AOJu0YxvutSVCuU5DFA9r7dKD/sY4i4fBKkinj/3vp+aBiZvxB7nKMoZ
 235aYczXENjvfk6JKrXOn+zGOHw4Qg+0PUZE7EV1kM31sWJtOgmwAdRUBG5rc8nqsJ8=
X-Gm-Gg: ASbGncuWzrekGFUFFjpm+nAsfuM5sAOvITE0O0mbQ8KA0JXjk0DhsCxwBYVK8N6LHxG
 6kTwMnFQicz+D1dXpAzyQ/pCwGFTVmU93ENitX4XG4mHO1Drm4zohAVTyVdb6KnGknqghKj1KjP
 5AUJyMUgP21JE35BHPqNg8/O9tegF5YmcqxNZ0oyolL8k3WN9sCNcJchSnSk1oXG+RWgQmFn9y7
 s0JYwbmGQ10tCL6R2QeQwAHMiwFbVrwoNvNB80m0++QQwlRCWtK0zbAjSSGS29A579+FIkhjOXr
 nB55LuDkMn2rOcheQ30pcE87TeZEvZjQ4Nv1aG4oeLtTNiSr0ZvRv9V9Czf+Jnn9AJ/1D0/FrmJ
 +iuc92GWIY/Gcb7XtY6k8a9qkeSwPBfX/1kzQhW736KPpW77PitCWw64Jvg3r+dOlaOobxYaCva
 q07WOGz/AqBA==
X-Google-Smtp-Source: AGHT+IFhinaFp4vNcN6dk/WElaVoA0wj2iczZMaTkJp0Q4olazaM1HXaqmycgcUuq12SPV/m8n3Xeg==
X-Received: by 2002:a05:6e02:3784:b0:424:85b0:e1cb with SMTP id
 e9e14a558f8ab-42e7adb36cbmr171174735ab.31.1759764819275; 
 Mon, 06 Oct 2025 08:33:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ea31448sm5075529173.29.2025.10.06.08.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:33:38 -0700 (PDT)
Date: Mon, 6 Oct 2025 09:33:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] boot: vbe: Make BOOTMETH_VBE_xxx a choice
Message-ID: <20251006153336.GB6303@bill-the-cat>
References: <20251001203059.2828551-1-trini@konsulko.com>
 <CAFLszTg8BFgpeYj7Gz-9ac5TVLaJJ5fs87oSeOfurSNT6dCa3w@mail.gmail.com>
 <20251002170352.GM6093@bill-the-cat>
 <CAFLszTjbcnUXzph86i4H9SUU8gZB32yUKMVZzAges_jo9BA16A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TFMminmlTzSDrVnI"
Content-Disposition: inline
In-Reply-To: <CAFLszTjbcnUXzph86i4H9SUU8gZB32yUKMVZzAges_jo9BA16A@mail.gmail.com>
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


--TFMminmlTzSDrVnI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 06:26:20AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 2 Oct 2025 at 11:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 02, 2025 at 10:29:58AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 1 Oct 2025 at 14:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > It is not valid to enable multiple BOOTMETH_VBE_xxx methods
> > >
> > > Why is it not valid? That wasn't my intention.
> >
> > They fail to build because they both declare some of the same binman
> > syms:
> > $ grep 'binman_sym_declare(ulong, vpl, size)' boot/vbe*.c
> > boot/vbe_abrec_fw.c:binman_sym_declare(ulong, vpl, size);
> > boot/vbe_simple_fw.c:binman_sym_declare(ulong, vpl, size);
> > $ grep 'binman_sym_declare(ulong, vpl, image_pos)' boot/vbe*.c
> > boot/vbe_abrec_fw.c:binman_sym_declare(ulong, vpl, image_pos);
> > boot/vbe_simple_fw.c:binman_sym_declare(ulong, vpl, image_pos);
> >
> > Enabling both leads to link failures.
>=20
> OK, thanks. I'll need to fix it at some point...

At some point is fine, thanks.

--=20
Tom

--TFMminmlTzSDrVnI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOPhUAAKCRAr4qD1Cr/k
Cs8xAP0amjDJB8r1NHyw2HTF0xDoRHehuJPULTO1HvAzZaZahQEA2Y0TdQpPV5ai
41q9b/d9ITd1A/8h84Zi3wyYxTTuzwY=
=2EjY
-----END PGP SIGNATURE-----

--TFMminmlTzSDrVnI--
