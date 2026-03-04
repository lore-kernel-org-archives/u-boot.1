Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B4CEF8FF3
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 15:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80A04838BB;
	Wed,  4 Mar 2026 16:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RdHviVev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D39DC839A8; Wed,  4 Mar 2026 16:12:00 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D3783642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 16:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c65d772cso6164291a34.1
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 07:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772637117; x=1773241917; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gl6qteV5dxg+/kysQ8KE6oXBFH6vfkLYuPPKhW2dtVY=;
 b=RdHviVev442nl0rHumh10pM0R+3GO43e/u2ARiCTTq7oGqjBnqMHAlz/Fs6WUqg0vL
 9QPcrU7LCo7dxYSOste7ApS898lbwXEQwFDQDZADBHFdn0KfZseWOG302TPsre/Vsmpk
 xznvkyuKZAyvzzqG3aEA2ZlEL8tAQHTtryY50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772637117; x=1773241917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gl6qteV5dxg+/kysQ8KE6oXBFH6vfkLYuPPKhW2dtVY=;
 b=D2T/9yKJvvuDZF0NHjg9r9NEfZtMBPdlH+GyufVg8HYcNLof0Hnewu2bnVAek+uuSo
 vDKSg17LeUnThP1x5LADhMMZu93vN+8werFSpcelVwBSW+Zgk7SkHQselWflfxKqHmG9
 Hex4OdIwkYAd/qbMBN5rlgtgFTxEc6fak3Ha+i8Na+pq3wYqU989BH60Mi247uNABBDL
 DcLDrGAZ6E9o0P4woEsBt+CJ8kHLZe5oZpBPkV2uEgX7HZ5YMqRMQ0FMEBfefXO52MzQ
 e7l7bPPZZV22/qscERHZ+9xm2OOdWXO9FWzhYV2oFM0eDHu8meC5GKtB2BbXpQbXyaz1
 lNAg==
X-Gm-Message-State: AOJu0Yz/5mwRtrzqPzHO7FX+43QuU8qgA2fE+/PzXHa6x7lE/H+xB+Lt
 ytXGCdaDfcRe9WJG+FVFH2OPK25/fFn0nRqdddxEDTLiDMGi1BHLWf15ZQrY32DpDYM=
X-Gm-Gg: ATEYQzxxxNYXnlnDZLH821dah/EoWh2dJXddBqOWB6n4rZ5G5CAhVv7uyuMndovKiiU
 edFoRYI0Q0mqODqwBBgZ0KtNrONd3cfE3vA7EqAW1yN3ZBGkq8f4S2AXOCyQP/mik342gK8zU4+
 grDACA1y1FMJbh9/JetbDKR/wv0adJtT86NMo7RGJ13gUDUX9zIMYQyLhRcmnnxF4H6hKpevPBy
 Ts/dJKTFK9y7ANoQyZluJfxK6FqAU0fIliqC5L60sIegNdNexy702NCBNlX0gq6rs1/Pf9Bm4cO
 /uSuBKpwApyqy1tln26mWmHlWRR7VqoteT1iPLnMWp/3Icq1sPH9y6uwnfHPOmu9pvTwI3miLW2
 Wozntz5rKmOMuxM0hvcMPZ7KIHgmSxuEZF0FzW88N56nFKru5xxK6jQcbdxuUmHauhREPbO+94P
 NyqFPgQmfMS9ljImKfgfIr9e7PfRkC6aTrysgtq/dOQDI/ifoAQG7ExBqjXv21bT40Lc/QnmC3M
 XGvyRLMwgd5SH4Sx5LTyZrJtGsC0s8GMM7czm1ojme88Q739xo=
X-Received: by 2002:a05:6830:3c8d:b0:7cf:e4a1:8a9d with SMTP id
 46e09a7af769-7d6d1361cf4mr1317318a34.14.1772637117000; 
 Wed, 04 Mar 2026 07:11:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d5866557c6sm15873035a34.24.2026.03.04.07.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:11:56 -0800 (PST)
Date: Wed, 4 Mar 2026 09:11:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH] kbuild: unexport sub_make_done to fix child make
 invocations
Message-ID: <20260304151154.GY1388590@bill-the-cat>
References: <20260214024736.3726811-1-simon.glass@canonical.com>
 <177256385549.3975993.592734328770415000.b4-ty@konsulko.com>
 <20260304-robe-praising-5509e3a984cd@spud>
 <20260304150145.GX1388590@bill-the-cat>
 <20260304-acquaint-wager-688fd7fbae6a@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fqvJwdy0SVDrERE0"
Content-Disposition: inline
In-Reply-To: <20260304-acquaint-wager-688fd7fbae6a@spud>
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


--fqvJwdy0SVDrERE0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 03:09:40PM +0000, Conor Dooley wrote:
> On Wed, Mar 04, 2026 at 09:01:45AM -0600, Tom Rini wrote:
> > On Wed, Mar 04, 2026 at 09:54:22AM +0000, Conor Dooley wrote:
> > > On Tue, Mar 03, 2026 at 12:50:55PM -0600, Tom Rini wrote:
> > > > On Fri, 13 Feb 2026 19:47:34 -0700, Simon Glass wrote:
> > > >=20
> > > > > The exported sub_make_done variable leaks into the environment of=
 all
> > > > > child processes. When make targets like tcheck spawn independent =
make
> > > > > invocations with O=3D, those child makes inherit sub_make_done=3D=
1, skip
> > > > > the KBUILD_OUTPUT setup and try to build in the source tree.
> > > > >=20
> > > > > There is a workaround that resets sub_make_done to 0 for specific=
 test
> > > > > targets, but this isn't great since it has tolist every target th=
at
> > > > > spawns independent make invocations.
> > > > >=20
> > > > > [...]
> > > >=20
> > > > Applied to u-boot/master, thanks!
> > > >=20
> > > > [1/1] kbuild: unexport sub_make_done to fix child make invocations
> > > >       commit: 4284306d22c5b6d64ecd62b462551d9d313c8104
> > >=20
> > >=20
> > > This breaks the build for me:
> > > make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- O=3Dbuil=
d microchip_mpfs_generic_defconfig
> > >   GEN     Makefile
> > > #
> > > # configuration written to .config
> > > #
> > > make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- O=3Dbuild
> > >   HOSTCC  scripts/basic/fixdep
> > >   GEN     Makefile
> > >   HOSTCC  scripts/kconfig/conf.o
> > >   YACC    scripts/kconfig/zconf.tab.[ch]
> > >   LEX     scripts/kconfig/zconf.lex.c
> > >   HOSTCC  scripts/kconfig/zconf.tab.o
> > >   HOSTLD  scripts/kconfig/conf
> > > scripts/kconfig/conf  --syncconfig Kconfig
> > > ***
> > > *** Configuration file ".config" not found!
> > > ***
> > > *** Please run some configurator (e.g. "make oldconfig" or
> > > *** "make menuconfig" or "make xconfig").
> > > ***
> > > make[4]: *** [/stuff/u-boot/scripts/kconfig/Makefile:75: syncconfig] =
Error 1
> > > make[3]: *** [/stuff/u-boot/Makefile:702: syncconfig] Error 2
> > > make[2]: *** [../Makefile:189: __sub-make] Error 2
> > > make[1]: *** No rule to make target 'include/config/auto.conf', neede=
d by 'include/config/uboot.release'.  Stop.
> > > make: *** [Makefile:189: __sub-make] Error 2
> >=20
> > That's odd. What host distro and make? I don't see that on Ubuntu 24.04.
>=20
> Originally my CI found it in a docker container with "from: ubuntu:noble",
> so 24.04. I reproduced it locally on debian unstable with make 4.4.1

That's even more puzzling (noble is 24.04) since that sounds very close
to our CI too. Can you please look more in to what's going on?

--=20
Tom

--fqvJwdy0SVDrERE0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaahLsQAKCRAr4qD1Cr/k
CuhJAP44HToy0SuDR/F0OLU6ius6oUdUAaNKOLDbX/c2aKO9aQEA9Yp3qycE48Q3
NzlFpFXdEtT/VX3MFyQgyU+dwpEZgQY=
=/BFZ
-----END PGP SIGNATURE-----

--fqvJwdy0SVDrERE0--
