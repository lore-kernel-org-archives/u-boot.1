Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0721AC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 14:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD3D87D06;
	Sat, 23 Mar 2024 15:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XMFC6ugX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0CC879A2; Sat, 23 Mar 2024 15:35:00 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9396E87D06
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 15:34:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78822adc835so127213785a.3
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711204497; x=1711809297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WzMlDbz21c6n1sI3NX3jXZsIWch4VOe2jHFPif++00g=;
 b=XMFC6ugXOnGJl0ZGdp0ZrNxi/o5/0Wqk/q9m9+mBQB5wPu/o8PpR144asXNDM1shgv
 s7/ezNMaSSVNU3wyk636Ez6fVrS2oyCuWSsBh2Va/nLRvufBqA1Yc/eR7m4xOXzqW6WH
 qb+WCZ+UsK5G0v3v+GY5mr/gvI7nEqCFai9io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711204497; x=1711809297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WzMlDbz21c6n1sI3NX3jXZsIWch4VOe2jHFPif++00g=;
 b=D0EoA4y5d/Ihod24astd03ezccQYjhQt/7opL/s1xT6/UooW5dWkEeY9CAppFQMibJ
 zpgVF7kf+O5Yl+oaJUYlGFmqAz1k7+prpVTYk7DBJ8fCigYZnjCU9NHvGX1X5AeVWSaG
 wwrGvOpwvKOxFT13WyVED//+qxPs5UQyKdRoCJvQJJzAWL0xD7MCUBOfKAm4rpGuefQZ
 ZJMUoLmp2QC0a0SX5lQmVNzSsQI50VSAjGiOeORLs78Kv6dlv/Qf4VFZR4B5HTK1PxB0
 jqyFo3OAJCeqzRpHpQYBXLjbHWAk7iGvXHwfO0JyAnzA4Xx9bI3GjZ0T6os6uOlPa2F0
 ibPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlqE1xeo6gR8WwFZ8MVbKiaf3wr9dCFp3SferMmOIHKERfGi0GwfYPVRdd+5ak0uWE8wRdVS9KGQO99VX0K13PMEoPag==
X-Gm-Message-State: AOJu0YwkEC5jXkGEcWNtYhuZuoNDDCzuJIabTAt1b1CqS9LiCr6dKXzv
 nSxq481dm3ly/wehV25nkG14IsXGDDS09i1qPk3JKZcrOo4q/SXmEWaF+TbUysc=
X-Google-Smtp-Source: AGHT+IEddcojmB5Mlf3mBk5+tW7DhhgVuxvog/CFqEHt3NGwGB+MNA1taS8fbdutaTUzwti/BPVL1A==
X-Received: by 2002:ae9:f508:0:b0:78a:29e1:6255 with SMTP id
 o8-20020ae9f508000000b0078a29e16255mr2363108qkg.20.1711204497439; 
 Sat, 23 Mar 2024 07:34:57 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 v26-20020a05620a091a00b007887583762csm707910qkv.94.2024.03.23.07.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Mar 2024 07:34:56 -0700 (PDT)
Date: Sat, 23 Mar 2024 10:34:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Marc Zyngier <maz@kernel.org>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH] arm64: Fix map_range() not splitting mapped blocks
Message-ID: <20240323143454.GA3442575@bill-the-cat>
References: <43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5>
 <86o7bazheg.wl-maz@kernel.org>
 <qnca6it6fh6pznsvm33rwa3pf6ushtkpvyui6fds43fcdjxcz5@66tiqctl7arc>
 <CAOMZO5CNgJUbDGdyP4tS7YBXPqcmyT+FkhaF+phbR64grA2i0g@mail.gmail.com>
 <yltha7mziq43ke7kas433zlvxamri2p7h2p7oos3x4dexk2oct@gfhscvngsjcw>
 <CAOMZO5Cy9tu_kWDmZZjHa0PAH9+RjHrQKHMwqCPe7fFvj=W6wA@mail.gmail.com>
 <CAOMZO5B8fkS_MEry_8LnDmzLBJJ5N-03P7dZXFgnTVarcaZkcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B6+4VySNHEG1YFd5"
Content-Disposition: inline
In-Reply-To: <CAOMZO5B8fkS_MEry_8LnDmzLBJJ5N-03P7dZXFgnTVarcaZkcQ@mail.gmail.com>
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


--B6+4VySNHEG1YFd5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 04:33:03PM -0300, Fabio Estevam wrote:
> On Fri, Mar 22, 2024 at 4:31=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
>=20
> > As Pierre's explanation addresses Marc's concern,
> > do you think this can go to 2024.01 to fix the boot regression on imx8q=
xp/8qm?
>=20
> I meant 2024.04, sorry.

How much testing has this seen outside of imx?

--=20
Tom

--B6+4VySNHEG1YFd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX+6IsACgkQFHw5/5Y0
tyyn7Av/SmCJHq/NgUFy0+gTXEk+alZX8Bn8jKY94YCX4eV25tVWN+x8GUQ/LUsp
NUXAa6XqpAtB9zMf/oMoHe/szADY21QPVb4KSlvLK7FkMt/YHMvXv1hhth4hIlcu
bGP1zuOcNaKUwNywpb/6t40k4k96te9aGqITB3LbKLfwg1Po+Tc5oRe4RBrSZdl1
Shh4lgKKW1Yl1D3VZ0L7YnyAj/9BVbyxLC0wtbzBgJ8aT1OFIN7S8tYXx1Tl587c
tMXOg4BK4m9e52GB0ldE6Qb3TAjhv+zTOzRzY3vdsPNR9WQ7cNm1/ctpQ7CCDxGg
Gulh9Emat5+qfRXO5uq8r1t9B0TESYII9GyDfnB2PIv5aBd6zEbiMNlDVp9qmEO+
j3EnkdTQsARpcbUMrJSXz3J4Qa/ya9H99+IMBU+43tNRUQZxqZal5No1I3D3uiKg
gLwq/0rBNcjZnC8sEJ+Mk7OQFCp6CABgJoyxxxJeZHmDvF+RR3xhedURtjxJXs5u
yYrnWd4w
=n4Sj
-----END PGP SIGNATURE-----

--B6+4VySNHEG1YFd5--
