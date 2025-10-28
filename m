Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A420CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 15:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E629E832AD;
	Tue, 28 Oct 2025 16:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VgR1PUE1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A54480422; Tue, 28 Oct 2025 16:36:48 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C46D80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-44db11c7ed6so1506316b6e.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761665805; x=1762270605; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L28LzwirpyRzMzW6QQPt8r6nQJ4jsdVR/B5JYnlQ+hY=;
 b=VgR1PUE1vfHI/ya+e0v4QzoLj5D+9tgshR6mgG5kOuQz5i2by7iDB7U+RBUdGtnYHi
 CfE1YG5usX7SenGz7n/t2tT7QLs3tYfHdP3LqNpEIhaQ7e5Decq4P3DffY4TiXHyfAOS
 RoFhvCt+aGi/CH8d3QzWRS1qolILdLiCZSrbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761665805; x=1762270605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L28LzwirpyRzMzW6QQPt8r6nQJ4jsdVR/B5JYnlQ+hY=;
 b=UD15P4u5xZ1byoEPRrqDosEownSSK1BeCxgWjQm28ZG7uxAro6BsukMAR0iCwJ650H
 uU6rnFT37GQJ0MNCYvKSOj8USFQuL1UpWgww89ve0897WTyuYJaUpIjpD0p8baqC1+vc
 KPS14VnmaemuLByZBqr0KxDj0ZOmB7/BkE7IYEjlWRCr8DwF8uKj0enrXYsFxEOOfa+j
 L5WNfbrojJJjNQ8SnXVtz2pVNO4UjDN3vO9dIt4kdNbD5gj83bIGzPNzVHARzMU2BY0n
 iK9ngytt1JH2M1qgQSo9OQ0nylR/OVQC3P5fKSDYDuM2Yo6mqu5kw0vQXMVFtQ70ds7z
 SO7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzlLv+uBdf/NfkDli0FKiA1nVQx+T0ZqlnM6mcbsG+ZiXXo0W7N2cNyM+HFpONvHoe3HkjzyY=@lists.denx.de
X-Gm-Message-State: AOJu0YyS6DTv3eSy3W02PjB5K80MexKHBQegxtO2Yibo9acTtKhbVn6o
 VJt6tyJ+ZT6HmGSluCH1u8Ck52tVpspX2DPEAnDuAbjLLr4y6ne50/EyUtxRqk84Yr8=
X-Gm-Gg: ASbGncuAViKk5SjfEwo0czVE0d+L/ocYnOFIsc57QNB44i9SNPuGE7spR01sZu9WaAC
 W0PSDVMOKFci9tcddmB/k8Wz8Uvckj4+B2IxeHOw/WeiUIz4+XyIUYpv7DqoebzxXzzxyI7XFN9
 jFbXDu6XVP6WiAfSR4XRotU6jvXHCdSR8rOTltYRfuF/AIsP1nJG9H/NjZMoBF4qnQ4KyPJPW3Z
 IuVOGykcyW2Io/lzKcA7vzr2Oxu2R7/SvJqwuMQrFF1VtfYZw0fBqz9RbcmjbDI3NQSZfC9f54B
 hcxbS00eFLxbnmGrH8hLi2lGKliSIvNY2kioNNMlihOZSvEIYOpFgLo9R6SDJUJ4MlLtFaJdkVd
 p5DEA21WrGUu2Qnb5ppp3tBOBgoWlEVh78RscNV94WFMhu/y++NYOsZ7OJecdNa36mG3Qqcw+wp
 Xv5NiKpI4QaWUEFfT5svk4ecWCug97gFH+4dcWcAc=
X-Google-Smtp-Source: AGHT+IFeXxL9cr0ucFDsAuJJJFc0rBqGGnEJ4uauMPggMHAkKhbNFdl1ymYNl0Yu7USVVesawQ8/RQ==
X-Received: by 2002:a05:6808:6f94:b0:43f:b74b:ac43 with SMTP id
 5614622812f47-44f6b9fac4emr1780309b6e.27.1761665804644; 
 Tue, 28 Oct 2025 08:36:44 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e59a15sm2664185b6e.8.2025.10.28.08.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 08:36:43 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:36:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/2] ARM: bootm: Add support for starting Linux
 through OpTee-OS on ARMv7a
Message-ID: <20251028153641.GA833321@bill-the-cat>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
 <97DFDFA0-80F7-462B-B2A9-BDBAD42A191A@gmx.de>
 <20250630194711.GA523899@bill-the-cat>
 <9c9317eb-7d14-40c8-9955-c69a6a5a3bcb@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UruqfM7Wrhr/TBto"
Content-Disposition: inline
In-Reply-To: <9c9317eb-7d14-40c8-9955-c69a6a5a3bcb@mailbox.org>
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


--UruqfM7Wrhr/TBto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 04:11:38PM +0100, Marek Vasut wrote:
> On 6/30/25 9:47 PM, Tom Rini wrote:
> > On Mon, Jun 30, 2025 at 07:18:33AM +0200, Heinrich Schuchardt wrote:
> > > Am 30. Juni 2025 02:08:05 MESZ schrieb Marek Vasut <marek.vasut@mailb=
ox.org>:
> > > > Add support for jumping to Linux kernel through OpTee-OS on ARMv7a.
> > > > This is only supported if U-Boot runs in PL1 secure. This change ad=
ds
> > > > two components, one is fitImage OpTee-OS loadable handler, which ma=
kes
> > > > a note of OpTee-OS being loaded and stores the load address for lat=
er
> > > > jump to it. The second part is the actual jump to Linux through OpT=
ee-OS.
> > > > The jump through OpTee-OS requires set up of multiple CPU registers=
, r1
> > > > and r2 are passed through, r0 and r3 have to be set to 0, lr is set=
 to
> > > > Linux kernel entry point. This setup is done by new assembler funct=
ion
> > > > boot_jump_linux_via_optee().
> > > >=20
> > > > The boot_jump_linux_via_optee() also includes STM32MP13xx late TZC
> > > > configuration write, this cannot be moved easily, hence the ifdef.
> > >=20
> > > Hello Marek,
> > >=20
> > > Could you, please, add a documentation change to the series. This wou=
ld allow reviewers to test your proposal.
> > >=20
> > > Furthermore, please, provide tests on QEMU.
> >=20
> > Documentation is good, also wiring up this use case for testing in CI
> > via QEMU is a rather large ask. We're still on needing a general boot OS
> > test or two in CI (and Ilias noted either on a call or IRC, I forget
> > now, that there's been some progress on making up a small enough generic
> > OS image to work from).
> I would really like these two patches to land, it is the remaining piece I
> need to make STM32MP13xx usable with pure U-Boot. How can we proceed here=
 ?

There was some minor rewording requested, and adding documentation is
also good. We can't reasonably add CI testing here at this time, yes?

--=20
Tom

--UruqfM7Wrhr/TBto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQDjBQAKCRAr4qD1Cr/k
CiWZAQCIPqzJ0eKlWuPXbRUFqm674RRiX1ZXlaJ9GE6p4+LhKwEAh7GUXCF/Vf2h
2mQdhjWC7PkZBG1X+erW/FtD0LWlvQo=
=ABfN
-----END PGP SIGNATURE-----

--UruqfM7Wrhr/TBto--
