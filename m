Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F09C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7A9080B9E;
	Sun,  9 Feb 2025 17:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YDDjr/Rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B3380BA0; Sun,  9 Feb 2025 17:49:52 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600B380A0A
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so2818563276.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739119789; x=1739724589; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ekhDDgKGNn6Wa3gus4uCQMfs9DPpgEtCvZD0hX4tNE8=;
 b=YDDjr/Rve9titoHrcVMNvGG7QJdc1gi0/EwBJbLVsM2Ui6p/IJIRKqN6Q5Nucwf+4+
 liWxmNLc+zSe0DmGXLLWGJkFUkoqW7cAx2HzrVnwQHKgayZst2vK7VW4JZEYzNOuyEqO
 HjvJ7GHOeOTy2A9006Ebgfia4CA1EJ2bCFPzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739119789; x=1739724589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekhDDgKGNn6Wa3gus4uCQMfs9DPpgEtCvZD0hX4tNE8=;
 b=gNFpUAm7PwFCBdXLFKynS/tbPoPXcd8sYEk3PjyktirA9bDOaklfnCssxdUqSNxu0R
 i3WZcnq/aA19nwfAJugJDGLV9JnGGcKVL6uHFfVb8Bajk2oHC1U9f6jXRrVGyZ+zZBmA
 cDEuYYPeiUTJa6Uv+l7SJ/5XPaLdT/ElrhCnMeIPLba6hb9Tys0EnKECBZXk47gyRHKY
 Robfq3vbSE6qXeh6b2iPuqkHIWxw3uw9x4rWqk+O3PvP4XESVUNU0L5oivBG5zTF1jse
 9YoxED/vqq10stbGOBIZ1QLomIcJ+PnFAUCo9fjKc1e0BfQfQ1qzFCy8Ix1Xug51vyrt
 9HWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUUHcydKcEImUHEwewSjbdrTHaeG2cl8TiU+9dgju1ppcw+rRpQryp+vIOHU73KlqyIG8hQsk=@lists.denx.de
X-Gm-Message-State: AOJu0YzONc6djOWmnVl1PWzsqUvaNRBXb947/RuikKhezIbEeanrAOJE
 j+J8lkVPaKiB1U1yY0UraYjL4O5UDXFiKKj9etLB8zmTmBuuIdk88AfmSBsu61A=
X-Gm-Gg: ASbGncsddZb4Zj6TcH2v9YyzzNM18nnvYfloj6Mvd1haDQr86I+Xl95uAtsJSicCFsN
 3c8UmS2auVth1cpM1/MehVhHDTmDNZGFnLnfGthwz2O0sLXtCNddkonA/br+HLJ/LB4O/RMjr+k
 mTRCABQa/bZ4HyRpZyoF90q1ntix1Zt1IeGuhB8yMLZFhuueQTrFx/1qDnnIL7JcSzaHtslPpNf
 ozIbcumVtNwCTe+LNxHj1NyGMFEjDTBkQYtWjPacMxnBgl4INZuU/UQKsimDYw8FQ9nLm6NVaYD
 XmgFILFwIGUeR7U=
X-Google-Smtp-Source: AGHT+IHC3lcWQzuVE7IwGw9hl6NyicHN1n3tGR+xcadUjUNsUn16T65hgWMFytFp4acLELgYntSC/A==
X-Received: by 2002:a05:690c:6f8c:b0:6f2:9533:8fba with SMTP id
 00721157ae682-6f9b27e8c97mr95117197b3.1.1739119789209; 
 Sun, 09 Feb 2025 08:49:49 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ffc2a32sm12595907b3.110.2025.02.09.08.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 08:49:48 -0800 (PST)
Date: Sun, 9 Feb 2025 10:49:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/12] rockchip: rk3399-gru: Include binman generated FIT
 in u-boot.rom image
Message-ID: <20250209164945.GN1233568@bill-the-cat>
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-7-jonas@kwiboo.se>
 <8a6bb542-aeda-4d74-bdcc-8eace71eaf62@cherry.de>
 <c3cd2190-096b-4f5d-a5cc-481cc44fa11c@kwiboo.se>
 <CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y3a2beCV7muuyLyh"
Content-Disposition: inline
In-Reply-To: <CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com>
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


--y3a2beCV7muuyLyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 07:27:37AM -0700, Simon Glass wrote:
> Hi Jonas,
>=20
> On Fri, 20 Dec 2024 at 09:50, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Hi Quentin and Simon,
> >
> > On 2024-12-13 15:30, Quentin Schulz wrote:
> > > Hi Jonas,
> > >
> > > On 12/13/24 12:57 AM, Jonas Karlman wrote:
> > >> The u-boot.rom image contain u-boot.img FIT instead of the FIT gener=
ated
> > >> by binman for the u-boot-rockchip.bin image.
> > >>
> > >> Change to include the binman generated FIT for the u-boot.rom image.
> > >>
> > >> This change result in TF-A being included and the use sha256 instead=
 of
> > >> crc32 checksum in the u-boot.rom FIT.
> > >>
> > >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > >
> > > IIRC Simon was fine with removing u-boot.rom support for RK3399 when I
> > > asked months (probably years?) ago, if that hasn't changed, maybe we
> > > should now.
> >
> > Good to know and fully agree, we should try to remove it now.
> >
> > I did a compare between u-boot-rockchip-spi.bin and u-boot.rom and after
> > this series they are now identical for the full size of
> > u-boot-rockchip-spi.bin.
> >
> > However, the u-boot.rom also has a copy of ~u-boot.bin and a fdtmap
> > starting at 0x300000. I have no idea if they are used for anything,
> > if they are it is probably not for bare metal booting (TPL+SPL).
>=20
> I'm not sure about the extra u-boot.bin, but the fdtmap is so that
> 'binman ls -i xxx' works.
>=20
> >
> > Regards,
> > Jonas
> >
> > >
> > > Especially since the only RK3399 with CONGIG_HAS_ROM set are Bob and =
Kevin.
> > >
> > > @Simon, you said you tested the patch series on them, with which image
> > > did you do that? Are you still fine with removing the u-boot.rom for =
RK3399?
>=20
> Yes that's fine.
>=20
> Basically all my testing is in my lab now, which you should be able to
> use with gitlab.

I really wish you would use the community gitlab instance and not
encourage people to use your personal instance instead.

--=20
Tom

--y3a2beCV7muuyLyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo3KUACgkQFHw5/5Y0
tyyaqQwAqQWWwXH0W35r1LptIbkU6SJxNkwOGpWCz1mrO6IrlKsMK5t2nD2Qdhez
qH1hAKCCZDN+8/SiklKtGmfeM44b/8TatXALRBdkiRG0CrYYX6T9iB+UmSZpPUTI
ZGEvk0SBLbILaIICMiPkIuRH+20PFwN6Wh+3N3sGYXSJiuDz8l4V1xSkxJ28gBx7
3q2CfkdWwmMuJA2bhZLwmm56Y0fjNlZcRilVyDbUYNEI4FKkXO6oWuxM4K4xRgOY
jOQvqH97rCeL7ZF/wh94flJgHqg+F+1CVKR5cW4qzpS3xWGerDkHKwZRZMMB+wSr
ykx6qRqfgMLvWWR5m//Oau11RmSrCZYq1J9mfcw/2bdz41Xn7iucBgsFax0IlDdD
oyzYn628mbe5TEWlKNAX8Uahe8eL8aGxDg+Gnep81Z8YEutLb+2HbIk6YclB6GcN
zZhrBq10jm9PnllqJA1/Pm7o828eGOeUxQvHy+ZyJ+2EWSzshQ9ZYpuo8NYBEF96
TOI8AeP1
=j0wY
-----END PGP SIGNATURE-----

--y3a2beCV7muuyLyh--
