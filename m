Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF7BC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 16:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 373CF841D6;
	Fri, 11 Apr 2025 18:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lJBpmzy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E34841DF; Fri, 11 Apr 2025 18:59:29 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0FBA841BC
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 18:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-603fd257386so522543eaf.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744390766; x=1744995566; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CWsa5IC6Py43OE5kA8i6+BFQkzpFacDDOz6MrQWuV3g=;
 b=lJBpmzy1tmhJqDWObQ2SHPLNhPWJ0GRVAQri+18i+x4dMn//tIN0cr97dON0TRBhDi
 VbQg86DC6Db0ZVOVXGXLVuxFIbeEuzVd7Nde5R26qn5k9ybep9INXbjwWb+T8ngGDZi1
 knWj7nMg7IRaN/QoMjYfyrq2Q4juAvaCPhaAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744390766; x=1744995566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWsa5IC6Py43OE5kA8i6+BFQkzpFacDDOz6MrQWuV3g=;
 b=TLRAjaTSGdkeymhjA0UHlaeQjqCVm843wVtBwA8PmdqmzZON9ydKnbsnufN6jTFoKV
 MhSsvPjuUfjgIwGlHvMdBI4+W2KSoJwrWVsNPnR/7LItwGtvwF13zB9C0+zMtvhSYm9E
 iTnvWDy1Szf0VfTap4AUI74yYhOHIDlG+ECXhog3b8kRHVFeEn5Hp5mNNFAv6gkpIdfN
 iU3FAo9NntJjCQ+6b78s4tiEDO5L2ZT70jC04xTQrSGJJ7AL82VwGrCTMinARmLZetUQ
 eJhcVgbjv9bmz3lrj8BdN4vHCNYpBmYLWKjMLuwqpUAyCK5pPIV0bUn5hjLSj5omP4Mb
 pFlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU03bEMi6wXrXCxSeX5bpPSpkF5z9H3ZFjSK5VY8IVfWD0xEYSjqrXyrD/A9ekjkY2BGHwKxLc=@lists.denx.de
X-Gm-Message-State: AOJu0YxrWB5Gwj9fQsMeJL4pPa9Akt7119E5xs7YqyC9l62jYLHLkT5z
 SVVj/xN1qEKastXnprLDDAq/aa5nz6WQGOc9HdKAOmAu2+WL3OeYcIxUZxIyMGk=
X-Gm-Gg: ASbGncuy5yOR1iYavv/jApvJ6lLw2eupht49G1/Z8PVwt9uPrk4LxAUce4qw2ZjrWUd
 3sw/VivuJHcPuoCDEkGzQwPh9EHWnQvjBb78mu4yMDUVdHZMGWbOe+u5QpH1rPNRTHTIzlgHoVA
 M/AuRsPDmTVSOpALKEJ/wuppEBJDuYJKIBk/wZHPMkCJarMw7HftmdK9O50I+ydIDsEeH+5AGQ0
 abu7DB08vOEivrXk3KTAFslSolPVmPzRbX04/0LaDrbdRG/gNV9x52NLvX6xXy3/Dv3IgiYy7uC
 9dVOr+36wSGJRX+2lznLkib7aseRcA408AAGYhv3eQW8amV6surfNipU5GD1YMt9sSSSY7xY2tH
 3Aw==
X-Google-Smtp-Source: AGHT+IHTNVOMkWb15zktF6djCWShQhKr96h8Fc0/eSvCSgS4umN1LWhve/+t3MSoY7Au7H5MpYp7Tw==
X-Received: by 2002:a05:6820:1606:b0:603:fd3b:aef6 with SMTP id
 006d021491bc7-6046f5cc933mr1792556eaf.8.1744390765609; 
 Fri, 11 Apr 2025 09:59:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6045f522cfdsm967212eaf.9.2025.04.11.09.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 09:59:24 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:59:22 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>, Eugen Hristev <eugen.hristev@linaro.org>,
 open list <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: Gitlab runner timeout on evb-ast2600 ?
Message-ID: <20250411165922.GT5495@bill-the-cat>
References: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
 <CACPK8XeCDU+-6+zzJe4=uj=Lduh8nGx6pNr=yWCsM+k-rov2UQ@mail.gmail.com>
 <20250410231444.GK5495@bill-the-cat>
 <89f2eac8-4e76-42a6-b56e-fc62abdaffe9@kaod.org>
 <20250411150120.GQ5495@bill-the-cat>
 <ef7019b2-1a81-46b2-8612-ead1139b742e@kaod.org>
 <20250411164248.GS5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xo2dwsX9KL0ZpwFU"
Content-Disposition: inline
In-Reply-To: <20250411164248.GS5495@bill-the-cat>
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


--Xo2dwsX9KL0ZpwFU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 10:42:48AM -0600, Tom Rini wrote:
> On Fri, Apr 11, 2025 at 05:26:55PM +0200, C=E9dric Le Goater wrote:
> > On 4/11/25 17:01, Tom Rini wrote:
> > > On Fri, Apr 11, 2025 at 09:23:59AM +0200, C=E9dric Le Goater wrote:
> > > > Hi,
> > > >=20
> > > > On 4/11/25 01:14, Tom Rini wrote:
> > > > > On Fri, Apr 11, 2025 at 08:07:15AM +0930, Joel Stanley wrote:
> > > > > > On Mon, 7 Apr 2025 at 23:25, Eugen Hristev <eugen.hristev@linar=
o.org> wrote:
> > > > > > >=20
> > > > > > > Hi everyone,
> > > > > > >=20
> > > > > > > I keep getting an error on running the CI loop on -next on my=
 tree :
> > > > > > >=20
> > > > > > > https://source.denx.de/u-boot/custodians/u-boot-at91/-/jobs/1=
090517
> > > > > >=20
> > > > > > Thanks for the report.
> > > > > >=20
> > > > > > >=20
> > > > > > > ! _pytest.outcomes.Exit: Lab timeout: Marking connection bad =
- no other
> > > > > > > tests will run !
> > > > > > >=20
> > > > > > > Any clue ? It's been like this for few days. It doesn't look =
like a
> > > > > > > faulty patch.
> > > > > >=20
> > > > > > I can't see that link you sent me, it 403s.
> > > > > >=20
> > > > > > Do you have any other traces or information to share?
> > > > >=20
> > > > > It's been intermittent recently. I was able to put qemu + gdb tog=
ether
> > > > > and see it's one of the early initcalls that fails and hang()s but
> > > > > didn't see why. You should be able to use commit 1f0281294d8b ("M=
erge
> > > > > patch series "Annotate switch/case fallthrough cases"") as a star=
ting
> > > > > point of failure.
> > > > >=20
> > > >=20
> > > > Do you have logs ?
> > > >=20
> > > > Things look ok from the QEMU side (latest 10.0.0-rc and 9.1) :
> > > >      uboot_build=3D/path/to/u-boot/
> > > >      flashsize=3D65536
> > > >      flash=3D./flash-ast2600-evb-uboot
> > > >      dd of=3D$flash bs=3D1K if=3D/dev/zero count=3D$flashsize
> > > >      dd of=3D$flash conv=3Dnotrunc bs=3D1K if=3D$uboot_build/spl/u-=
boot-spl.bin
> > > >      dd of=3D$flash conv=3Dnotrunc bs=3D1K if=3D$uboot_build/u-boot=
=2Eimg seek=3D64
> > > >      $ qemu-system-arm -M ast2600-evb -net nic,netdev=3Dnet0 -netde=
v user,id=3Dnet0 -nographic -snapshot -serial mon:stdio   -drive file=3Dfla=
sh-ast2600-evb-uboot,format=3Draw,if=3Dmtd
> > > >      qemu-system-arm: warning: nic ftgmac100.1 has no peer
> > > >      qemu-system-arm: warning: nic ftgmac100.2 has no peer
> > > >      qemu-system-arm: warning: nic ftgmac100.3 has no peer
> > > >      U-Boot SPL 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 09:08:40=
 +0200)
> > > >      Trying to boot from RAM
> > > >      ## Checking hash(es) for config conf-1 ... OK
> > > >      ## Checking hash(es) for Image firmware-1 ... crc32+ OK
> > > >      ## Checking hash(es) for Image fdt-1 ... crc32+ OK
> > > >      U-Boot 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 09:08:40 +02=
00)
> > >=20
> > > Please note that it's inconsistent about what commit fails. I would
> > > expect 1f0281294d8b in U-Boot to fail but I don't know about
> > > cb7555e93075.
> > >=20
> > > Also can you please check QEMU v8.2.0? That's what we're on, and I can
> > > try and test 9.1.3 or 10.0.0-rc and see if it's a QEMU problem instea=
d.
> > > Thanks!
> >=20
> > Same result :
> >=20
> > qemu-system-arm -M ast2600-evb -net nic,netdev=3Dnet0 -netdev user,id=
=3Dnet0 -nographic -snapshot -serial mon:stdio   -drive file=3Dflash-ast260=
0-evb-uboot,format=3Draw,if=3Dmtd
> > qemu-system-arm: warning: nic ftgmac100.1 has no peer
> > qemu-system-arm: warning: nic ftgmac100.2 has no peer
> > qemu-system-arm: warning: nic ftgmac100.3 has no peer
> >=20
> > U-Boot SPL 2025.04-00881-g1f0281294d8b (Apr 11 2025 - 17:23:25 +0200)
> > Trying to boot from RAM
> > ## Checking hash(es) for config conf-1 ... OK
> > ## Checking hash(es) for Image firmware-1 ... crc32+ OK
> > ## Checking hash(es) for Image fdt-1 ... crc32+ OK
> >=20
> >=20
> > U-Boot 2025.04-00881-g1f0281294d8b (Apr 11 2025 - 17:23:25 +0200)
> >=20
> > Model: Aspeed BMC
> > DRAM:  already initialized, 1008 MiB (capacity:1024 MiB, VGA:64 MiB), E=
CC off
> > Core:  266 devices, 24 uclasses, devicetree: separate
> > WDT:   Started watchdog@1e785000 with servicing every 1000ms (60s timeo=
ut)
> > MMC:   sdhci@1e750100: 0
> > Loading Environment from SPIFlash... SF: Detected mx25u51245g with page=
 size 256 Bytes, erase size 64 KiB, total 64 MiB
> > *** Warning - bad CRC, using default environment
> >=20
> > In:    serial@1e784000
> > Out:   serial@1e784000
> > Err:   serial@1e784000
> > Net:   eth0: ftgmac@1e660000, eth1: ftgmac@1e680000, eth2: ftgmac@1e670=
000, eth3: ftgmac@1e690000
> > Hit any key to stop autoboot:  0
> > libfdt fdt_check_header(): FDT_ERR_BADMAGIC
> > Error loading kernel FIT image
> > =3D> QEMU 8.2.10 monitor - type 'help' for more information
> > (qemu) q
> >=20
> >=20
> > What about the compiler ?
>=20
> It's:
> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64=
-gcc-13.2.0-nolibc-aarch64-linux.tar.xz

And part of what makes this a pain to debug is that trivial changes
break/fail it here. For example, ff0b7d741dec fails for me but if I make
a tiny source change so the version string is ff0b7d741dec-dirty it
passes. So you may need something longer for your ${uboot_build}
directory, mine is /home/trini/work/u-boot/u-boot.

--=20
Tom

--Xo2dwsX9KL0ZpwFU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5SmYACgkQFHw5/5Y0
tyyNLQv+IGdY/pod4HI9OsU3VRkGvX9QR3F6o+tvbEdidc6VR2n64tiX7m+8pTid
loRCS8qls7wB7tGjFuGMAh6PksqyOxpuhnuVNavP1f7YdHSeaDN4V5fShPECzOW8
kcl0k2ecrFXug6vsglniF99TjnSruZarGCReVtHrqQvUlxwn5YhKKtqKYQQ++yJ8
YinE8/OI5XeuM/xnccDDTdWKOdVRmH/zv2kw7nsD5GPsS/7h0a3wz/zlLoyGuucD
o1L6Rve3Jn0t694zIGxSaauRBy6N6azIAT7zQQ6EkkEh4RdyuM5n/XD6EPAqIM/T
JsEX16wQcw5/+7J2mB7bFDSmGg0kDGXD1zXKtARpCLbZWd/s3HgvL0CzBgv5n99H
k4heWjKg5Hm3eNk0od5RuMQrW8+RJfVZANOFsFPzhgS58K4gUgmRSivKdznDBjp+
LZ4yvjZjvrWKjB1EMVmoDkxju9klMQmaXwp+wb76R0vCJHy/n00XJny8oM8NxfyU
LohZQ8CA
=wu8f
-----END PGP SIGNATURE-----

--Xo2dwsX9KL0ZpwFU--
