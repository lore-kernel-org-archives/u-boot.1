Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D222EC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 16:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A07784085;
	Fri, 11 Apr 2025 18:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Uv2w99Yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA3182AF1; Fri, 11 Apr 2025 18:42:57 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651D982A80
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 18:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3f8df49e75fso694677b6e.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744389772; x=1744994572; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Guk33+6fIHHa6C24FxuYsYrvb95cX8gSzFioNuN3NWc=;
 b=Uv2w99YvIe6pZ+G2ZqvAF6sHR1xwUPyVVxOhNYJhWwg7Y4PBhbRFHFXmGQtaqqPrDQ
 /CafGvyL9GBmFGkLJtZxYrCxprC3bDMqb64bpCHOqTzrDkxVbfA1Uzb3dUp54y7t0iTA
 46swy2rws/X4P2yZq0ugwbVXV3C2R2P2+hd8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744389772; x=1744994572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Guk33+6fIHHa6C24FxuYsYrvb95cX8gSzFioNuN3NWc=;
 b=jcIBp0WEPYgnbfskcpCH1uc7znrXfyllZWa7jjOaie1eU8wIRcqbZoOGxopTm4pDZx
 Gpsu0nMQumzKDkaWbeTMkJHisLA3uSMuTpavciawZuoJLMqP+zpxoTYvP2kvZN8pX5zb
 hhlM8/XEvqzCOAK3AzTbOu6pFQQzwITGUVP2x7mtfVlO+JqKG0sOh08+TGOJ/cVAi67s
 l41UCytKUVv3u4V3RqrwLXEQmKw8FeW+IWOTR5zuu4sJRewRIh6Dq8ffTt/kJ+rBpyO1
 YX66RJNCI8njAD1oRKaClYgF41opP85pKR4yMwqDjFBTQfZ4k/aLiEcWExZ0yFKVWItU
 BhnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9okIy1D6W5fkPLDWUYPNnp4QZ3LxTtx2cgLxs/ZvjAWHt133DcK6bxP3lkH80O5ayG5syR+k=@lists.denx.de
X-Gm-Message-State: AOJu0YwMVh1NGz3EkWSP0tBFBQVqdu27AIMM3feYBXELWjwvOih7sdXO
 vAnxt0r++uP1GXYhvt+0bunvKoytSD3KN/APY/SS/W8htU94FkY/lLXzaAepx3r6eHqBtZt2oir
 LmdA=
X-Gm-Gg: ASbGncsTC4Dlqy85cBRKLh4It0oLNab0MPYosBfFhwDaJ3t76wpwg6F852y46i/IEQ+
 rQ9pxKjwBTUgDfWXFrcl3R97w7xQqq3Mf3i09rSfgbQKdAYJBMD9LnydyOermuGwqNHHAOqMOSU
 U06k9udS6/xrCbbg6PsVfNh3grBjg1Z5Ln+amcTEw1UhEnJGG77pjUQnDPphPS3x0IGWz+fSNA9
 0jedY8GTM446kXXDfU1FUgwgSnwUWC/ujfBN8sMXLBTjaqs37CadeLKWb1rDTGKaSP5oC40oQ6u
 Rgs1Y46N8Fv3ZU4jfWQJ0nWykZ7NjnC9GC1I7m0BBk7e3iRUNvzsg4VwxnGFj7ZWjwPkNtbBL+I
 HYQ==
X-Google-Smtp-Source: AGHT+IGlIC4jC6HQER2JpiA3TF2UQmcaSrE61kztHGkOELKyzC090E966QHWp1O3P7gSY0pHaztsXQ==
X-Received: by 2002:a05:6808:1a12:b0:3f9:bc8f:8145 with SMTP id
 5614622812f47-40084e39511mr1822251b6e.0.1744389771994; 
 Fri, 11 Apr 2025 09:42:51 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4007629efc7sm983839b6e.14.2025.04.11.09.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 09:42:51 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:42:48 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>, Eugen Hristev <eugen.hristev@linaro.org>,
 open list <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: Gitlab runner timeout on evb-ast2600 ?
Message-ID: <20250411164248.GS5495@bill-the-cat>
References: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
 <CACPK8XeCDU+-6+zzJe4=uj=Lduh8nGx6pNr=yWCsM+k-rov2UQ@mail.gmail.com>
 <20250410231444.GK5495@bill-the-cat>
 <89f2eac8-4e76-42a6-b56e-fc62abdaffe9@kaod.org>
 <20250411150120.GQ5495@bill-the-cat>
 <ef7019b2-1a81-46b2-8612-ead1139b742e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K21HCNwhbUVt4Xx/"
Content-Disposition: inline
In-Reply-To: <ef7019b2-1a81-46b2-8612-ead1139b742e@kaod.org>
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


--K21HCNwhbUVt4Xx/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 05:26:55PM +0200, C=E9dric Le Goater wrote:
> On 4/11/25 17:01, Tom Rini wrote:
> > On Fri, Apr 11, 2025 at 09:23:59AM +0200, C=E9dric Le Goater wrote:
> > > Hi,
> > >=20
> > > On 4/11/25 01:14, Tom Rini wrote:
> > > > On Fri, Apr 11, 2025 at 08:07:15AM +0930, Joel Stanley wrote:
> > > > > On Mon, 7 Apr 2025 at 23:25, Eugen Hristev <eugen.hristev@linaro.=
org> wrote:
> > > > > >=20
> > > > > > Hi everyone,
> > > > > >=20
> > > > > > I keep getting an error on running the CI loop on -next on my t=
ree :
> > > > > >=20
> > > > > > https://source.denx.de/u-boot/custodians/u-boot-at91/-/jobs/109=
0517
> > > > >=20
> > > > > Thanks for the report.
> > > > >=20
> > > > > >=20
> > > > > > ! _pytest.outcomes.Exit: Lab timeout: Marking connection bad - =
no other
> > > > > > tests will run !
> > > > > >=20
> > > > > > Any clue ? It's been like this for few days. It doesn't look li=
ke a
> > > > > > faulty patch.
> > > > >=20
> > > > > I can't see that link you sent me, it 403s.
> > > > >=20
> > > > > Do you have any other traces or information to share?
> > > >=20
> > > > It's been intermittent recently. I was able to put qemu + gdb toget=
her
> > > > and see it's one of the early initcalls that fails and hang()s but
> > > > didn't see why. You should be able to use commit 1f0281294d8b ("Mer=
ge
> > > > patch series "Annotate switch/case fallthrough cases"") as a starti=
ng
> > > > point of failure.
> > > >=20
> > >=20
> > > Do you have logs ?
> > >=20
> > > Things look ok from the QEMU side (latest 10.0.0-rc and 9.1) :
> > >      uboot_build=3D/path/to/u-boot/
> > >      flashsize=3D65536
> > >      flash=3D./flash-ast2600-evb-uboot
> > >      dd of=3D$flash bs=3D1K if=3D/dev/zero count=3D$flashsize
> > >      dd of=3D$flash conv=3Dnotrunc bs=3D1K if=3D$uboot_build/spl/u-bo=
ot-spl.bin
> > >      dd of=3D$flash conv=3Dnotrunc bs=3D1K if=3D$uboot_build/u-boot.i=
mg seek=3D64
> > >      $ qemu-system-arm -M ast2600-evb -net nic,netdev=3Dnet0 -netdev =
user,id=3Dnet0 -nographic -snapshot -serial mon:stdio   -drive file=3Dflash=
-ast2600-evb-uboot,format=3Draw,if=3Dmtd
> > >      qemu-system-arm: warning: nic ftgmac100.1 has no peer
> > >      qemu-system-arm: warning: nic ftgmac100.2 has no peer
> > >      qemu-system-arm: warning: nic ftgmac100.3 has no peer
> > >      U-Boot SPL 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 09:08:40 +=
0200)
> > >      Trying to boot from RAM
> > >      ## Checking hash(es) for config conf-1 ... OK
> > >      ## Checking hash(es) for Image firmware-1 ... crc32+ OK
> > >      ## Checking hash(es) for Image fdt-1 ... crc32+ OK
> > >      U-Boot 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 09:08:40 +0200)
> >=20
> > Please note that it's inconsistent about what commit fails. I would
> > expect 1f0281294d8b in U-Boot to fail but I don't know about
> > cb7555e93075.
> >=20
> > Also can you please check QEMU v8.2.0? That's what we're on, and I can
> > try and test 9.1.3 or 10.0.0-rc and see if it's a QEMU problem instead.
> > Thanks!
>=20
> Same result :
>=20
> qemu-system-arm -M ast2600-evb -net nic,netdev=3Dnet0 -netdev user,id=3Dn=
et0 -nographic -snapshot -serial mon:stdio   -drive file=3Dflash-ast2600-ev=
b-uboot,format=3Draw,if=3Dmtd
> qemu-system-arm: warning: nic ftgmac100.1 has no peer
> qemu-system-arm: warning: nic ftgmac100.2 has no peer
> qemu-system-arm: warning: nic ftgmac100.3 has no peer
>=20
> U-Boot SPL 2025.04-00881-g1f0281294d8b (Apr 11 2025 - 17:23:25 +0200)
> Trying to boot from RAM
> ## Checking hash(es) for config conf-1 ... OK
> ## Checking hash(es) for Image firmware-1 ... crc32+ OK
> ## Checking hash(es) for Image fdt-1 ... crc32+ OK
>=20
>=20
> U-Boot 2025.04-00881-g1f0281294d8b (Apr 11 2025 - 17:23:25 +0200)
>=20
> Model: Aspeed BMC
> DRAM:  already initialized, 1008 MiB (capacity:1024 MiB, VGA:64 MiB), ECC=
 off
> Core:  266 devices, 24 uclasses, devicetree: separate
> WDT:   Started watchdog@1e785000 with servicing every 1000ms (60s timeout)
> MMC:   sdhci@1e750100: 0
> Loading Environment from SPIFlash... SF: Detected mx25u51245g with page s=
ize 256 Bytes, erase size 64 KiB, total 64 MiB
> *** Warning - bad CRC, using default environment
>=20
> In:    serial@1e784000
> Out:   serial@1e784000
> Err:   serial@1e784000
> Net:   eth0: ftgmac@1e660000, eth1: ftgmac@1e680000, eth2: ftgmac@1e67000=
0, eth3: ftgmac@1e690000
> Hit any key to stop autoboot:  0
> libfdt fdt_check_header(): FDT_ERR_BADMAGIC
> Error loading kernel FIT image
> =3D> QEMU 8.2.10 monitor - type 'help' for more information
> (qemu) q
>=20
>=20
> What about the compiler ?

It's:
https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-g=
cc-13.2.0-nolibc-aarch64-linux.tar.xz

--=20
Tom

--K21HCNwhbUVt4Xx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5RoQACgkQFHw5/5Y0
tyz+fgv8D0K6Zt/HvV1HcUC5JikWa2LCOqAM+iwq5PhMBWRXrBJuSIhlWQ1ndggF
GPkB/dp339PcJZlAJ4Nb4DG6DfST/6+O7VWbT8rS0GBCXqdqy8lYS8K1rzvivWxb
+uDYcDJ6bstxuzcceMmjZQvZxBzKvH6uRA4Y7e0EHyTPh/qHLiK06BdEDXhvmN/y
/eWxEOQAoPqCI0S7K4sVNBmfWx2tufPVxcRMwZx6Iqmp88yynjCsawmrsJKlL6v/
m30HmIRI6S2clrWounThdwStrTtHoZ942sSNUDlO54KYZgANFS0JrwSzGC0OEG/k
2tbCwuDZJOi5O9EmoN1pmrJdMOp+Oe0gtAYTyrrgbVpbnf3eL1dIGVKLMwrjtp88
ro/hHRFkqFkVWq+E0mJ0GZfd+FLR938kr9dB/1+hVjL6J3wCCTOuNItWIBC4Xql7
naGMkVQTFA/f5Ma7S0IgIPLNDHQhZjQ5wRNEj/0aE9Eid4xn+S+i9mwHjVo2AGmD
/ZgMnzX3
=xAUS
-----END PGP SIGNATURE-----

--K21HCNwhbUVt4Xx/--
