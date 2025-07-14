Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0997C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 14:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2759883020;
	Mon, 14 Jul 2025 16:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EE+CMj9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C3E583020; Mon, 14 Jul 2025 16:58:28 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CDC382CFA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-735a8be4ea9so792195a34.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752505104; x=1753109904; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5cYDpDUqmDxvlZ1V6qTpMYM9i6BaO1TZkZ8sbsTwJ28=;
 b=EE+CMj9GzkSkFMEYnEs0P5CZUThwJsp4cdtcNbqtgvUHlJI4SSMA+H7o9x0XgAh4UD
 IsGX2L9aRlRZyM6aTAYD93c0NWmbrIbe5u4cY3cyZ4vnbenwpmBONWfU72H/Nxhcl44X
 3D4PpWj74CFtbg4qzLAyO/qCny00Lsv6Co4PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752505104; x=1753109904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cYDpDUqmDxvlZ1V6qTpMYM9i6BaO1TZkZ8sbsTwJ28=;
 b=KVPnszYJoEZn4J0eEczJVIG1muh2QV2LJtgFJnJ7vR4VjvR4NJBfaV7aJQOScuaMJZ
 HRHE/l82F6vAs7UdyuXNlBsltYdv8NY6A3hQxzpf1360wh7qZxa1r6+0a3yrQ4gu80Mq
 PW6KkGP0wRj5TnykqSYS9pm74rZbgxc9Wd2JDRgxh6qEvrtVrWBNbSuH0soadvmi+64y
 AKvFAgZXqkHtJUpy/0JORV1J/tGpNAh6VAV3j4zmkmAKmW2JKsamh+Uue3hkCKeDwRf9
 ubQ8jytSsaqxCfsX4XAzRSnhh85MvJFzm+4G1iWPzNXTn5MXqvmxnkOsrU5btxkqG01e
 aqoQ==
X-Gm-Message-State: AOJu0Yzqb0U7SUP/9NNCMl8EWLVe7fZiRrPToBWk0Gxqaf3E21d6mPFA
 LWSgCH04eC71NsHK5qlUKDWnmJTrkJL9+qebT/1n+0/FMvefR5SnxdvzLPJdMURr5o4=
X-Gm-Gg: ASbGncvAhXPEB8MOKFZmtZujrafPG5mpH6pDqI4/NYLyknNeP3UfL/UQRYSp6My5U8G
 KphKw4gmK/+EJXtw9Kreum9nZJ5+fAimcAM18U2phKth/4nVA7AMdo5sqm4hKiZyvObfRs/vaA/
 YadlyhmT8HBcIRuGXL2VCiQsm0m9Jjvm1I3b6oOqOMCnwRxIm0SWWC0apoW55vpWh5G5HHWAA8w
 f/FjJ7MB6c1sCtRh+9ezHeuriGiQR+6nQ096vzVkzkd4BffYJJ6qMWlXZvodBwfjUgC2OiWG79p
 FPpwlfLknCu7UFHe/npto8zdn/6Uav1BAELP+BUnqjvreXZUkimP/O+ubFEDZ18gKjqQbRVQG+q
 z/AvmzGinwM09Bb+oiTNf2ICKlF1wKVUjZvnrv1h+QRc4QygBVwACDipg
X-Google-Smtp-Source: AGHT+IE9d0RlvXwuA/6tme9Vkxix8aagW0a3q8HEnLSTFHD8E6DvqWH8G8o3DHa5QFVNVvp/KWAwEA==
X-Received: by 2002:a05:6808:3505:b0:401:16e:918e with SMTP id
 5614622812f47-4150d645624mr10585797b6e.8.1752505104008; 
 Mon, 14 Jul 2025 07:58:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414196c7484sm1558660b6e.15.2025.07.14.07.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 07:58:23 -0700 (PDT)
Date: Mon, 14 Jul 2025 08:58:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: Re: [PATCH 2/6] km: Kconfig: set KM_RESERVED_PRAM to zero for all
 designs
Message-ID: <20250714145821.GG13084@bill-the-cat>
References: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
 <20250714132221.2471558-2-holger.brunck@hitachienergy.com>
 <20250714145212.GF13084@bill-the-cat>
 <AM9PR06MB7843D024FB26194DC5AE943CF754A@AM9PR06MB7843.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7xMbEQMUlSrzwzEv"
Content-Disposition: inline
In-Reply-To: <AM9PR06MB7843D024FB26194DC5AE943CF754A@AM9PR06MB7843.eurprd06.prod.outlook.com>
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


--7xMbEQMUlSrzwzEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 02:57:41PM +0000, Holger Brunck wrote:
> > On Mon, Jul 14, 2025 at 03:22:17PM +0200, Holger Brunck wrote:
> >=20
> > > This area was used for special purposes on kirkwood. On the current
> > > designs we don't need this anymore.
> > >
> > > Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> > > ---
> > >  board/keymile/Kconfig | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig index
> > > 41458813858..3a66b2915ac 100644
> > > --- a/board/keymile/Kconfig
> > > +++ b/board/keymile/Kconfig
> > > @@ -31,8 +31,7 @@ config KM_PHRAM
> > >
> > >  config KM_RESERVED_PRAM
> > >  	hex "Reserved RAM"
> > > -	default 0x0 if MPC83xx
> > > -	default 0x1000 if MPC85xx || ARCH_LS1021A
> > > +	default 0x0
> > >  	depends on !ARCH_SOCFPGA
> > >  	help
> > >  	  Reserved physical RAM area at the end of memory for special
> > purposes.
> >=20
> > Can the whole thing be removed then? Thanks.
> >=20
>=20
> Good point, I can drop it completely. Should I send a v2 for the whole se=
ries
> then or only for this one?

Assuming there's no conflicts, v2 of just this patch is fine.

--=20
Tom

--7xMbEQMUlSrzwzEv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh1Gw0ACgkQFHw5/5Y0
tywzRgwAnn4BCMClla+h+0x7NgfCjcj/gAs0MTNVHoSGgXpV6qzMc6aPFFxuckn2
v/bQ9mrrom1y7GAllsLHhtrDbF2sNi/Wc0xcT8asMVZZDIvTZAlNDr9j9RrvoWQv
qBlTfZ3F2gQgH7zDdnXGat/4R9GMVopSX1/WzASursUSToDD7Hg7K7gZBZNqpQrN
6s4UeZ3NETm/UpAb1FOB+VzM1RfUCddsbLUDP9wf2Wy4PjSRw8eOiTb7XMa12Qn+
xbpjxPslZb2nEEbq2W2Z86kv0X0EZFrGa7tAkCCUmdpi23i3llcboIN5kcMjwmn4
PQ9WRBAAJSiw+0Lf7aCNF39+4zzZJcHhpVHGWqioquFbE8Z9rHpnwkPJpc2CQa19
rcbsMrs62c7/rai6Ek6P8osFI1zRhW3k5Ia3xYk0p3T1ssOBwQIHGGwmcyZffBUP
fEJtVt/qFXKM2SOlIDPu7EXHUUkcY7rbIjZ6P/RVN1HaP3jxMSYUtmatG9Ocu+Cx
y+3xzTig
=b0eS
-----END PGP SIGNATURE-----

--7xMbEQMUlSrzwzEv--
