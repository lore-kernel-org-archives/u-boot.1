Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77158CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B867A838E7;
	Sat, 11 Oct 2025 20:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I3oV75Ei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7356C838F3; Sat, 11 Oct 2025 20:00:31 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E011D836F0
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 20:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-43f7e0494ecso1802920b6e.3
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760205627; x=1760810427; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HkxtLLD0p4FvnPq2tG0k3qoVAnfzfsgo0FRDwwOyOAs=;
 b=I3oV75Ei43jezP6dBIDfFwzR2No+bhy0ptrDjt4Sjyk74n70hzoZbsmaDrsv3JvbkN
 i1Q5LP4UB49NV21P7Hh71Cq7QmBlOQbAgebpYSfDJvpz66wmwbh8Ndx66HyW/hY0U3da
 dOrdduqba7qaxEhcIuEJm1KZEtK6hLL7Vb9nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760205627; x=1760810427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkxtLLD0p4FvnPq2tG0k3qoVAnfzfsgo0FRDwwOyOAs=;
 b=n7DXN1eIRBDrHK9jjItl5dCbIOB9n4SOt4Fqp4mmiWYRJU4CxHGchLXT/5xw4TE5E6
 BRNe+YiSShInLRKD/7Ak8BodAMHc9KOPPEb9Vy397m4d5o+HMnBL+42ujivhNgZ6jYsi
 5ec7U3Yk5Wo4W22eITtzAbk5iR/7zfB4Ic7xfShDKh/Sjo77eDay5n2hzGqhYu1kP+ay
 CLdan9T94M9Q7uF1sA5BBQLqeFnD8I9AYhTZ9ru38bzu6ZPUse4UfyCeWs4HWIFlhKqE
 GNHMeTBj3LcHuKrdYfRGRjbbdCx8DIoU0wl9c3NLd3DQ3W5kIzQ2nomqnvr9gQTS+aVg
 Q0ig==
X-Gm-Message-State: AOJu0YybB7+sKt6QLJAwd/UIDgFXBQHcqcLQDTm/mH78JPGZdoKjRPcz
 ExH0Lx8V7pnCbH9Nzsq27Go2lcCS84MOo3HNpv0yjoPdou6mbaSHpOIQFsS16iikBOw=
X-Gm-Gg: ASbGncv7oKehfYYYKN0CRho6RpjlRBncWoiyQFvwt7iOhJOgGS4JmZKY2jckf6rKv/1
 1Sjk+DtclrvHwTvC5RsSn8W+rZaDu9Q95QU5CcMSX4IZg4jfzE1K+ktBoyY68aKziSGohVioCOr
 6RiYZF3XXlqpGzvdlQBbokkByuaa7p7uU0XW4LlQBp7oAvZMOLPTFgCxuRePqkOOxOxx7dDnnpX
 1Vrm8s8noQbkYRHOUmuSwTVW2/IunXI3LD4r40NZdq8BAx4fI3meSUF0/9XtsQJZsg89FI1C6h8
 ZLUz+YkMiXcymIqukaoOUlNoHbqF/8IqgFKzUi7T2IVEVMGopr1C4LeI3M9bEiCur67Mr/84xUj
 kGucL8N+WYpbOjyuNpHd1lGdmNYwGZxdvGYnpsUWwz0vdFTA8kKN5R+ba37zQHe06hce6s0ppjY
 0j2CZA
X-Google-Smtp-Source: AGHT+IF6E4y04sBsX3OaVWOT0en/qfc8beHmMqh7YD6jX6db7ENvF+RwExeKFYCFSfbw0MqvUHw/mw==
X-Received: by 2002:a05:6808:218a:b0:438:2907:2eb2 with SMTP id
 5614622812f47-4417b417280mr7572142b6e.27.1760205627545; 
 Sat, 11 Oct 2025 11:00:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419893b4dcsm1329758b6e.16.2025.10.11.11.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 11:00:26 -0700 (PDT)
Date: Sat, 11 Oct 2025 12:00:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Marius Dinu <m95d+git@psihoexpert.ro>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] timer: Mark this as incompatible with SYS_ARCH_TIMER
Message-ID: <20251011180023.GL298503@bill-the-cat>
References: <20250813205511.3420638-1-trini@konsulko.com>
 <20250813205511.3420638-2-trini@konsulko.com>
 <aJ4OR2rhl6eFV3GE@GRAPHRT> <20250814164021.GM124814@bill-the-cat>
 <aJ4mqWaJuJ0Ka+28@GRAPHRT>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xXcA1Xkdth9aKMWQ"
Content-Disposition: inline
In-Reply-To: <aJ4mqWaJuJ0Ka+28@GRAPHRT>
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


--xXcA1Xkdth9aKMWQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 09:10:49PM +0300, Marius Dinu wrote:
> On Thu, 2025-08-14 10.40.21 +-0600, Tom Rini wrote:
> > On Thu, Aug 14, 2025 at 07:26:47PM +0300, Marius Dinu wrote:
> > > On Wed, 2025-08-13 14.55.11 +-0600, Tom Rini wrote:
> > > > The timers implemented under SYS_ARCH_TIMER are not part of the TIM=
ER
> > > > framework and thus cannot be enabled at the same time. Express this
> > > > dependency in Kconfig and add a note to the help of SYS_ARCH_TIMER.
> > > >=20
> > > > Reported-by: Marius Dinu <m95d+git@psihoexpert.ro>
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Marius, I ended up reworking things a bit (and also found part 1/2 =
of
> > > > this series) but please let me know if you feel this should retain =
your
> > > > Author and such instead. Thanks!
> > >=20
> > > No need for credits.
> >=20
> > OK.
> >=20
> > > I think you should keep the warning message in the Timer drivers menu.
> > > It provides a quick explanation why the menu is empty.
> >=20
> > I thought about it, and we don't do anything like that for other
> > either/or choices, and it's now in the help text itself at least. The
> > other thing however, is that a few platforms do allow for both, because
> > they play some games with CFG_SYS_TIMER* defines. So I'm not entirely
> > sure what to do here.
> >=20
> > > Bugs are reported in this mailing list too?
> >=20
> > Yes.
> >=20
> > --=20
> > Tom
>=20
> With the original patch I only tried to reduce the number of compilation
> failures. I encounter a lot. I'm no expert and I can only try to fix litt=
le
> things such as this one.
>=20
> I belive some people (like myself) would be confused by an empty menu and
> would not immediately remember the SYS_ARCH_TIMER in a completely differe=
nt
> part of menuconfig.
>=20
>=20
> I tried to find configs with both CONFIG_SYS_ARCH_TIMER and CONFIG_TIMER
> enabled amd I couldn't find any. So it's probably OK to leave the patch a=
s it
> is and exceptions, if needed, can be added later.

I haven't forgotten about this, sorry. I'm just debating with myself
what's best here, because another part of the proper solution is that we
should get the generic ARMv8 timer on moved to the framework too, but
it's more easily said than done, but I have asked some people to look in
to it.

--=20
Tom

--xXcA1Xkdth9aKMWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOqbNAAKCRAr4qD1Cr/k
Cr02AP9PxAp5hBa3cuz7IEbpJqVqScEY0TESajfdgOfIxIKATwEAhHfV6M2hbszb
C8MCteZY9si5jXL3vxn9D/3+6r/c2AA=
=z3NJ
-----END PGP SIGNATURE-----

--xXcA1Xkdth9aKMWQ--
