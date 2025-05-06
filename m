Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C598C3ABBE
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 17:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45794820F6;
	Tue,  6 May 2025 19:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jWB6M7T0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E578210D; Tue,  6 May 2025 19:52:49 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9443B820EB
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 19:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3feaedb531dso1360288b6e.3
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746553966; x=1747158766; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3+XBDkyLUj/Iu8p9/8zRnoWS0hxbD3/s/c32egj5gZM=;
 b=jWB6M7T0sTjDFT3cSZfiste0UE7YvyKJI2x8O/iH6ez2F6Su3EBZDgJljyPECTyJeF
 hbucKe4x4GEZKTTQ06vRy5fQ1qisbGxAdgggDmbCCQFnrCabi3o4cKHhQ+Bw1sFp6F9P
 DSDdHXZl0/Ko9n3wnwan3PJaiA3ai3PLvIORg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746553966; x=1747158766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+XBDkyLUj/Iu8p9/8zRnoWS0hxbD3/s/c32egj5gZM=;
 b=EX71rbIKckanLZTC5AsuVx23WsuizjNZhsB2qjRMbTZTSvZGON7fqzgNpb+TavPRmt
 XAbAqZc8vaazhmtJAD4t5YqXuK9zbaCE+JCQH9Imu+VBrzEeyuvuNTpqyzMGBx2Y7Z10
 lMshcoVKQnXcNFt6KX1qDvSL0JccJ9nyECYLSWxZTls7rjJy8ARysWM1bJTQsc3Ilfsq
 9DqKTC/B2NWF9Xvkx1NbMmL8eeZGFwEWg1oxuAxNWDQz72X+lzak5aVJZIw0/yYlax0i
 4DrESQk91OW5eWiv727AaJMxTwr7AZwSv6pymQYusJmv1EBQrz/l1EpGld5dwamItxIz
 haSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqJXZpHjdexGTZrUdzs9Aei0rHGmIn2WazbuiDgjHECyLtrkJn9jzNifW1bN7/mpYmQZa6J9A=@lists.denx.de
X-Gm-Message-State: AOJu0YznhaJNEDtjOFGYcUbqnBpP8MfonKqIMw0rKH3oRJQLspLYGMlk
 XyP2taRUQeKIk/TMV+U1rJ0cDmErwG6sXzFk84N+ujHv65uLCgQlrE5q/ePLJ84=
X-Gm-Gg: ASbGncsBdzTXtvrKGsFg4p+zMYoPyqWBZz84pHhCSDt9hDRVY3RctXXZVuHFAluvbDa
 sfSdRYs2IDzdCnBbhOUMg2d37DewMogVnn4oQe/l72mwBezNUUQeuDQmTOSlfmxMRjZMJ0afvhy
 btf0UXq1L59hDuLf16qE3ARWhdqJcX42tA46hHTsGDuTKxO+u8tD6u2terDJQDvje1DkuKREhmp
 Xuxk69s9rMOhjiyPrLEkExOFExCamsmCi+NaBsSTEXeULV7dd6ZYNBsKVQwLqI2+Dh9zUnSEOzX
 LpxOsTDvl5pngItNgMCRpNtuD4hqb5BYHQHpaRGfWAt60cqZ5+VHX7gIr0FwqgwrRdzQKrFXc65
 FtA==
X-Google-Smtp-Source: AGHT+IF4eJFcceb6S4E55gTPvX+GzUawRy6mLlteFck5WevzqQSTX7URmhIjMJDVM1NNQOxKv2j8Ig==
X-Received: by 2002:a05:6808:10c2:b0:401:16e:918e with SMTP id
 5614622812f47-4036f0697bbmr195530b6e.8.1746553966169; 
 Tue, 06 May 2025 10:52:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f3870ccsm2255b6e.35.2025.05.06.10.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 10:52:45 -0700 (PDT)
Date: Tue, 6 May 2025 11:52:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, brunosampaioleite@gmail.com,
 u-boot@lists.denx.de, probinson@gmail.com, mbrugger@suse.com,
 clast@prevas.dk, brule@prevas.dk, pbrobinson@gmail.com
Subject: Re: [PATCH 0/2] Add rpi5 specific defconfig
Message-ID: <20250506175242.GE5430@bill-the-cat>
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
 <20250502144031.GT1261075@bill-the-cat> <87frhj5r32.fsf@prevas.dk>
 <20250505134843.GK1261075@bill-the-cat>
 <87zffq95f7.fsf@bloch.sibelius.xs4all.nl>
 <20250505212816.GP5430@bill-the-cat> <878qna5h8c.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KEYSp253emsOzmxc"
Content-Disposition: inline
In-Reply-To: <878qna5h8c.fsf@prevas.dk>
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


--KEYSp253emsOzmxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 09:30:11AM +0200, Rasmus Villemoes wrote:
> On Mon, May 05 2025, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, May 05, 2025 at 10:19:24PM +0200, Mark Kettenis wrote:
> >> > Date: Mon, 5 May 2025 07:48:43 -0600
> >> > From: Tom Rini <trini@konsulko.com>
> >> >=20
> >> > On Mon, May 05, 2025 at 11:45:05AM +0200, Rasmus Villemoes wrote:
> >> > > On Fri, May 02 2025, Tom Rini <trini@konsulko.com> wrote:
> >> > >=20
> >> > > > On Fri, May 02, 2025 at 01:34:33PM +0200, Bruno Leite wrote:
> >> > > >
> >> > > >> From: Bruno Leite <brule@prevas.dk>
> >> > > >>=20
> >> > > >>=20
> >> > > >> Currently rpi5 uses a generic rpi_arm64_defconfig file that bui=
lds rpi4
> >> > > >> devicetree. Add a defconfig that is specific to the rpi5 buildi=
ng the
> >> > > >> now available upstream dts for that board. The defconfig makes =
use of
> >> > > >> defconfig including that is now available and only changes the =
DTS
> >> > > >> related config.
> >> > > >>=20
> >> > > >> It is also necessary to add a more specific u-boot.dtsi to rpi5=
, since
> >> > > >> due to the ARCH_BCM283X config it will try to build the
> >> > > >> bcm283x-u-boot.dtsi and break.
> >> > > >
> >> > > > My question is, can we not adjust rpi_arm64_defconfig to be gene=
ric
> >> > > > enough and not have a problem on Pi 5 due to the default device =
tree?
> >> > >=20
> >> > > Not really.
> >> > >=20
> >> > > What we want is to have CONFIG_DEFAULT_DEVICE_TREE to point at the
> >> > > rpi5's .dts file, because we really want to build that and not some
> >> > > "random" dts file that doesn't have anything to do with the hardwa=
re. I
> >> > > know that kinda works for the setups where the .dtb built in U-Boo=
t is
> >> > > not used for anything, but in our case, we really do want to use t=
he
> >> > > .dtb from the U-Boot build - we inject various U-Boot specific stu=
ff via
> >> > > the EXTRA_DTSI mechanism, e.g. public key for kernel verification.
> >> > >=20
> >> > > And due to CONFIG_SYS_SOC being bcm283x, and bcm283x-u-boot.dtsi
> >> > > referencing nodes that simply don't exist when building
> >> > > bcm2712-rpi-5-b.dts, the build breaks.
> >> > >=20
> >> > > Perhaps the real problem is CONFIG_SYS_SOC being bcm283x for rpi5?=
 I
> >> > > don't really know why rpi4 is both bcm2711 and bcm2835 and what the
> >> > > difference is, but rpi5 only seems to include a bcm2712.dtsi which=
 does
> >> > > not include further dtsi files.
> >> > >=20
> >> > > If rpi5 has nothing to do with bcm283x, then perhaps a better appr=
oach
> >> > > is to ensure that CONFIG_SYS_SOC is bcm2712 when building for
> >> > > rpi5. Something like adding a CONFIG_TARGET_RPI_5 choice and addin=
g a
> >> > > 'default "bcm2712" if TARGET_RPI_5' ?
> >> >=20
> >> > OK, so I guess my next question is, is rpi_arm64 useful enough in the
> >> > end for Pi 3 and Pi 4? I would have expected that it doesn't matter =
what
> >> > tree we build in to U-Boot as we would be using the one passed to us=
 by
> >> > the prior stage firmware, and then update that at run-time as needed.
> >>=20
> >> Works well enough for us on OpenBSD.  And it would be nice if
> >> rpi_arm64 would work for the Pi 5 as well.
> >
> > But that gets back to my first question. Can we correct the code such
> > that we do whatever is required at run time, as the previous stage will
> > have assembled and passed a correct device tree already?
>=20
> I think this is sort-of asking the wrong question. The problem is not
> about what dtb the prior stage hands us or what to do at run-time. [*]
>=20
> The problem is to have a defconfig that will compile
> bcm2712-rpi-5-b.dts, as part of the U-Boot build. As I said, it's quite
> likely that rpi5 isn't at all a part of the 'menu "Broadcom BCM283X
> family"', and it's the CONFIG_SYS_SOC=3D"bcm283x" that prevents
> bcm2712-rpi-5-b.dts from being compiled (because the bcm283x-u-boot.dtsi
> doesn't apply to that .dts). Bruno's patches achieve that by adding a
> more-specific -u-boot.dtsi file (it doesn't seem that we need any of the
> bootph-all settings from the bcm283x.dtsi file), and adding a defconfig
> file that is based on arm64, but just changes the dt settings.
>=20
> Those who simply ignore what .dtbs are part of the U-Boot build and use
> blobs coming from elsewhere can probably use rpi_arm64_defconfig as-is
> for rpi5.

I think I finally get it, thanks for being persistent. I'd like to see
if we can solve this without making things less generic. In snapdragon
for example we've been making progress on having more (and different)
platforms work in a single build and this feels like a step backwards.
If there's not other non-Pi platforms for these SoCs maybe we need to
think less in terms of "mach-bcm.." and more in terms of
"mach-raspberrypi" or something along those lines.

--=20
Tom

--KEYSp253emsOzmxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaTGEACgkQFHw5/5Y0
tyz73Qv/TVS/o7klXOIB1HzgyaRfG91xcs4R2w2B8/IVNd+2p/DvIRt3jU4oDh6v
JXHy9rOlemw0dgr9Oijq3bE46Phun5QWX8c06VNLIOV2rFRcONxEP5h7g2GcXKBm
ztwqS7I73EDQ45AxdfGAXK5khbaaEDbv/JZ+8xN3ApYh5rNY9bs3iV1g3qpeJIyv
6FyOzktAG9m1M72djdafSkFtatKG8J/opM7pYXX4nYYG8C2badU1ZNm14M124eAZ
A/4/ALvmvx3he9uLNOLx51CCFcfWa4mQpQG6FR9YfiDgEoXmSZ6tRCEaGL8ch75Q
ER7+qHpResfHE332dSKtvamaScMMFbIcjpcbDQQZIsh0iWdtukuD+igJVgbxeqt+
V80Zbl6Tpiv/Idk0v/0KTrpnLTtNy0Aite4Bgu0E5+aJobFKfWe/6VNBAdNzxqBm
ncr8D50vHC1GqQGekJ6ePb7gj2R7ijB7Zes3gsBmMTFn3CBxmpeJ39lXblV+atH4
N/BEsaBg
=v0+g
-----END PGP SIGNATURE-----

--KEYSp253emsOzmxc--
