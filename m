Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B005CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 23:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C485838CE;
	Tue,  4 Nov 2025 00:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IdviI9Rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B166883927; Tue,  4 Nov 2025 00:05:47 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F34B183923
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 00:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3e085513892so38243fac.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 15:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762211144; x=1762815944; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pCSqCkgx0TgAeVDuIeHg5m8HS4+99v1w5irh8Jv9kNc=;
 b=IdviI9RgXolJ5T68G4u7aeaFddL6woxUX7JRJY3PQzBCZ6iyd0sg0yeBkPHjuF6SJO
 WXZ4or8OhSICLf4P3RnrmZwUwoYqbrJR9jQVoTA5YY9UCoX97ruT4DY2DwdKTVtt2Y5K
 kufZfFIhi1gts7BAIzKZAzEWvHMVj3QCjiLZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762211144; x=1762815944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCSqCkgx0TgAeVDuIeHg5m8HS4+99v1w5irh8Jv9kNc=;
 b=SFJi1yMMqJWB05D6EMQzklC2yr+1Zi15j8MamSws4CmRK6fduVVXDpQTom/FW5bGEt
 8pbzFuOdb0q+hruUMWGakwCYtyJIDJPWR4MqgsrQz6kgPx8kwRsOOpczKyPdRRinCu9W
 D48Ha/oUYJ1AlWqj4wGv1ARJ/20/jEvI8SJu2A8kzYOjVriHEMI5+bclLjy0YSizajDq
 HFUaLVgla+tTu4nEWfMBdA0i7VMeo4chHeUHiWsiHVU83DykSI/RcUdAxY7yr0Tm984t
 M64CBJKEiYtqZU8zbdl2tu8ersiycKT1WJOeOYAjqaxxvBAqBukHRJbpCWvI4CC2uoMo
 KjMg==
X-Gm-Message-State: AOJu0Yxf+LJihaWtWqwrKXH5SpiCYYTPDG8TmbwjP4TvxbjfZl8ugdyT
 9FjJtdaELPRG3baPaXoFqkbXdUGjr+/5cNg4MXbUqs2YGvNc81KM0lxxWczCmQIFQTk=
X-Gm-Gg: ASbGncu+2FQ+R2rdeKwdl0iE6QLGLp7iH3C3bFaCaqMoVfAV7wAsSvkD0VPrEqk6/9M
 kmfzPHCsqJ7zInOEsvs4Lv1JrvK6UZybtWQfgN3oYUninlssXhZk+dimVY9tYm+z57X8ImmMle9
 BwkWtCmZ0uM1USPzkF21dnLdD9XQ1GZxFMEHvsTZJqmEiBXyZuyvqmbjsAPaNIkiWep5nWB3cDr
 WK9Ba40GivGbMuaWWwP0fneBTpjvnVeIJvdGE5o5nq+6cziau5qHJzthQj0D6+3mM3X4EsuX21o
 Fti/rkWqpGBsh71t4WS2EkpEBaRYNG9zMtBh+At8xRrjfrl5QpvW+7Z2h0FujnjpiiSvsacK0db
 9zNgT9VXmS/cQChKoecCMGq9C7Iew+hXyIDUc6WFqLbY+4hJ73NdNV94wVVCp+aToeV1ZMjzr+X
 M2vRsW33Uxkx/K0ETPLwD3AJuq6cjk5pBw/9ErZu4r5X1aXy9cMA==
X-Google-Smtp-Source: AGHT+IFcrV2ijGDO5nkN7vFMGc5YyW3j+K1B3foA0zqNwWL1Kk+0cto+7hhCyd34MnDCH4WMozYA+w==
X-Received: by 2002:a05:6871:3305:b0:35d:ea5:6be5 with SMTP id
 586e51a60fabf-3daca82b544mr5833797fac.20.1762211143673; 
 Mon, 03 Nov 2025 15:05:43 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3dff7965307sm501646fac.20.2025.11.03.15.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 15:05:42 -0800 (PST)
Date: Mon, 3 Nov 2025 17:05:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add make feature support for SoCFPGA Handoff
Message-ID: <20251103230540.GV6688@bill-the-cat>
References: <20251103222840.458-1-briansune@gmail.com>
 <20251103223346.GU6688@bill-the-cat>
 <CAN7C2SB7qeXQB5=VHZ_DaE-ov4S7OX2hSyYNhb4SWv8-k+J_9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AocpoGpRn53AWgs+"
Content-Disposition: inline
In-Reply-To: <CAN7C2SB7qeXQB5=VHZ_DaE-ov4S7OX2hSyYNhb4SWv8-k+J_9A@mail.gmail.com>
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


--AocpoGpRn53AWgs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 06:52:14AM +0800, Sune Brian wrote:
> > This won't work with separate object directories. Please give things a
>=20
> I am not too getting this, why? The checking stage is not enough to
> block the below script execute?

Because ".config" isn't valid, you need to have $(objdir)/.config be
checked, and in turn that has to depend on the appropriate target (we
have some stage that says that we are configured, I forget which).

> > spin with "make O=3D/tmp/somedir". It also looks like it's going to imp=
act
> > every board, and either fail or add some build time? Make sure both say
> > "sandbox" and "qemu_arm" both build at least, if not a full CI run.
>=20
> For build time -> There could be 4 line of code to check.

I do forget off-hand which methods of doing "something" in a Makefile
are cheap and which result in firing off a subshell. But for a handy
feature for one SoC I want to make sure we don't slow down say the world
build of all 1400 configurations. For a maybe useful example, see how
the "checkgcc6" target is handled, and maybe we can move all of this to
live under arch/arm/mach-socfpga/config.mk and so only get invoked at
all there.

--=20
Tom

--AocpoGpRn53AWgs+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQk1QQAKCRAr4qD1Cr/k
Cqj4AQCmvTsJjozFjDz5oqI/CsNH2chyMKHobE6WpOa+ddZwcgD9G4klS+yfVRgU
Z5PAwN4NWZSSZNjwcofKWIalE/+6IwM=
=q0H7
-----END PGP SIGNATURE-----

--AocpoGpRn53AWgs+--
