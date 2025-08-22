Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07D4CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 21:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2974080422;
	Fri, 22 Aug 2025 23:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fifSVwUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA1F829E7; Fri, 22 Aug 2025 23:40:52 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51E688006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 23:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3e67e6a1cc8so14132215ab.1
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755898849; x=1756503649; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=honG4O3dz8vfvXMgrR2G+8IKoeQksaROY5ZQd6HULT0=;
 b=fifSVwUsgIa1xFM3umNp2Yriewaf7TqSxkdyZ9TPVeNr9YurQBu3QTBocXHmtle+ux
 9ueDdh8JzcVzhBUy1eT4IVmDkPRpsLzdedQKWf1aLMaBRk5+gXoPdBd+J2IYaeakIsKR
 TjkaC9Ou10yZhQJOa8b0Numqw+9sS60lG+w+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755898849; x=1756503649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=honG4O3dz8vfvXMgrR2G+8IKoeQksaROY5ZQd6HULT0=;
 b=YEZ8WwdpAuQJbUgtGl3JLGNSve+em4oZdnxZ7AqDCYotNU5cZnIiHVXWlsULCyBPyc
 B44UT7s9A2ug1q1T9c5sIQNr1Cppxk1gu13j3s5hdQ70rMgXNbqfCQ97xON8DRrwBTF4
 GVQCckqjbW6bWLerQslZwFGbG9CkG2Av7az/0ykqpKIWm9wzv5X/D/DoUD3XuLxlnrTf
 ca08w+rXvI7Mxe1ecbsjBfj7tTTEJ/QB2ARyH5bansiXRNBmcK3Bg1ZA3hT8JmMob/WP
 1z7CJY4QdkzAySLb3+y2gNZ640X3YcaENt5OtfWjB0QEVipD/5NlsODVmrXmz8gbhxTl
 XMcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXitZRjiORHXYeIvLzZgPlRQO6GItldsB217MM7LoAhN+fXDfs8M0oJCzy3oiWOiaNjzBncsL8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzwv7SyUnUKG1oVCr99m3PDaaflYmv8WnkmQ5BIkmHTedcPmzcY
 kjUUmJs4GfHJ8bYkbbdp01SAPbaEP9WaEGThbgrDS0mx9R5DxLWPUAGhGRypMkECCbpxKD8fDs4
 tPE30YQY=
X-Gm-Gg: ASbGnctWccFweAt9RYyPElbJUe3ZfOu7i+WFJECuueQo885i2qQmhB39uA4eqamOqzF
 +vJFS5707bmtMg3ji8VHl8A59GwezcSBWYlODFBWWPW63gUgC4uJOLlOcHReelYGWADYighOYNL
 BeeWRQ0RLm8GnNaZTIvFmjLLaTx7QzesMZ8bvU+/5gwAuF7tTv2BVZ189dqMFEwk8R94dRek9Ds
 PMxAFCGYnsZEqYgXKejq1Sen4/KVLGTW61zs/i3/QzVyMYe6lsG9n5LgRYQJVLWdd526ZG253TB
 w+Dk2NNfh1mhlNWU4vm2vCMa7yABi0RmLFPE+5nTErBD1YYe4jQgdjkc4a9VRCB4HtxpG7TI+hg
 cRlF24IRMXHpmRREGfgW/k5Wm5d2u8Yt9DV7OrTe1P0U8kGUZgPnld92e
X-Google-Smtp-Source: AGHT+IFzGaWzS0s5gTr6dPKqt5KobQTJ78wG3Ii+Jy/g+fiziV00KlC7R5x17HqaA+fJayiezLdiLw==
X-Received: by 2002:a05:6e02:1a43:b0:3e9:e4ca:4aa8 with SMTP id
 e9e14a558f8ab-3e9e4ca4fe2mr37517815ab.25.1755898848709; 
 Fri, 22 Aug 2025 14:40:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-886c8fa400asm71287239f.14.2025.08.22.14.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 14:40:47 -0700 (PDT)
Date: Fri, 22 Aug 2025 15:40:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/10] doc: Add riscv to the list of architectures in
 tools/buildman/buildman.rst
Message-ID: <20250822214045.GP124814@bill-the-cat>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-7-adrianocarvalho.pt@gmail.com>
 <b8fa5fa1-0028-43e5-bb14-db94fd16bf3c@gmx.de>
 <CACAHuLDQ9gp6G1KnbPTH2bcdFChY4x_M1HC0fJU-SJ0ozkghKA@mail.gmail.com>
 <CACAHuLD=fkEKq9e83f3ePQHO1N5dnVsRuFHwR6U12jv2EBJnew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JFH+qey3mkWn/0rU"
Content-Disposition: inline
In-Reply-To: <CACAHuLD=fkEKq9e83f3ePQHO1N5dnVsRuFHwR6U12jv2EBJnew@mail.gmail.com>
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


--JFH+qey3mkWn/0rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:12:19PM +0100, Adriano Carvalho wrote:
> On Fri, 22 Aug 2025 at 01:04, Adriano Carvalho
> <adrianocarvalho.pt@gmail.com> wrote:
> >
> > On Wed, 20 Aug 2025 at 22:08, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
> > >
> > > On 11.08.25 01:37, Adriano Carvalho wrote:
> > > > Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> > > > ---
> > > >   tools/buildman/buildman.rst | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.=
rst
> > > > index d5d22732088..7944adcd867 100644
> > > > --- a/tools/buildman/buildman.rst
> > > > +++ b/tools/buildman/buildman.rst
> > > > @@ -478,7 +478,8 @@ Setting up
> > > >
> > > >      At the time of writing, U-Boot has these architectures:
> > > >
> > > > -      arc, arm, m68k, microblaze, mips, nios2, powerpc, sandbox, s=
h, x86, xtensa
> > > > +      arc, arm, m68k, microblaze, mips, nios2, powerpc, riscv, san=
dbox, sh, x86,
> > > > +      xtensa
> > >
> > > The output examples above this line should also be updated to show RI=
SC-V.
> >
> > Do you mean what's under "Check the available toolchains"?
> >
> > To reproduce, I would need to install quite a few toolchains. If
> > anyone already has all those toolchains they could just send me the
> > output. Do you know someone who can do that? Can you do that? Or
> > should I just install all those toolchains and reproduce?
> > [...]
>=20
> With docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025,
> I got the following:
>=20
> $ ./tools/buildman/buildman --list-tool-chains
> List of available toolchains (17):
> aarch64   : /opt/gcc-14.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc
> arc       : /opt/gcc-14.2.0-nolibc/arc-linux/bin/arc-linux-gcc
> arm       : /opt/gcc-14.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueab=
i-gcc
> c89       : /usr/bin/c89-gcc
> c99       : /usr/bin/c99-gcc
> i386      : /opt/gcc-14.2.0-nolibc/i386-linux/bin/i386-linux-gcc
> m68k      : /opt/gcc-14.2.0-nolibc/m68k-linux/bin/m68k-linux-gcc
> microblaze: /opt/gcc-14.2.0-nolibc/microblaze-linux/bin/microblaze-linux-=
gcc
> mips      : /opt/gcc-14.2.0-nolibc/mips-linux/bin/mips-linux-gcc
> nios2     : /opt/gcc-14.2.0-nolibc/nios2-linux/bin/nios2-linux-gcc
> powerpc   : /opt/gcc-14.2.0-nolibc/powerpc-linux/bin/powerpc-linux-gcc
> riscv32   : /opt/gcc-14.2.0-nolibc/riscv32-linux/bin/riscv32-linux-gcc
> riscv64   : /opt/gcc-14.2.0-nolibc/riscv64-linux/bin/riscv64-linux-gcc
> sandbox   : /usr/bin/gcc
> sh2       : /opt/gcc-14.2.0-nolibc/sh2-linux/bin/sh2-linux-gcc
> x86_64    : /opt/gcc-14.2.0-nolibc/x86_64-linux/bin/x86_64-linux-gcc
> xtensa    : /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-gcc
>=20
> Compare to the original:
> - a few architectures are missing (e.g., alpha, am33_2.0, bfin, frv, h830=
0)
> - No "Scanning for tool chains" at the beginning
> - No "Tool chain test"
>=20
> Have the missing architectures been removed since? All those in the
> arch folder and some more are listed.
>=20
> Has the output for Buildman changed to not include those lines?

There's a few things well out date at this point:
- The output from '--fetch-arch list' shows what can be downloaded from
  kernel.org. Keep in mind these are public toolchains, for the Linux
  kernel and are also fine for us. That's why it lists so many more.
- The section "Check the available toolchains" should be replaced with
  modern output, and you need to pass -v to get such verbose details now
  rather than simply a list of what would be used.
- The section "Install new toolchains if needed" should be replaced with
  output from using an architecture U-Boot still supports such as arm64
  or riscv.
- The "toolchain-alias" parts don't list what aliases one needs and
  since 'riscv =3D riscv64' is needed, rephrasing that earlier part of the
  document should be done too.

Thanks for working on this area!

--=20
Tom

--JFH+qey3mkWn/0rU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKjj2QAKCRAr4qD1Cr/k
CrcEAQDFpzgaQXj9AUhX/hjeTutBBTkxJ9TCm7HJShzb+Y4XCAD/ZwuM4qRf6Eaw
FY5ExE10vD0pm3b877gAFS8JLZoX2gk=
=T5KB
-----END PGP SIGNATURE-----

--JFH+qey3mkWn/0rU--
