Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E59C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 16:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D7E8309D;
	Thu, 31 Jul 2025 18:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C9cGkiqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 245288309D; Thu, 31 Jul 2025 18:05:49 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584F083929
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 18:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6195f7f9b67so118837eaf.3
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753977945; x=1754582745; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ytr5NbyYNQnMCmegJw2n0OmQJhawAgxqvxVEkhS614I=;
 b=C9cGkiqPxpijYwN7iiQ5707nIspJlwR4068yq9r2aFOJ6oX8N8bNBigF4qXJcNmJiI
 3zoagrq3oPlfv4zEicsT9lVb4G18+sMD/6ZX/XZla5RUTDUNVyYkrGQEWQ1UABNsdsB6
 pfQT2Rooo1PUwsmWuSY5GWX3X4CEJjQMJ6N2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753977945; x=1754582745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytr5NbyYNQnMCmegJw2n0OmQJhawAgxqvxVEkhS614I=;
 b=d8fjhfHsVZ4E1aCvCIHY0Z6R0s7eLXvE6bZVh3aTwAydlkTrRJN8DdjDDH/kdHoZV2
 DSZ8U/qaHXPr2sB1jwn1je/2kCXbLrvwa5Ntecf5gQPbSmJLfZ2OQb/GnzjYarKzM6EU
 gjwIUGxKM9m2DjApQQBpA2Gh4j7mXnbp9NzoIGGLiBG6sLaI34ItfY/iR7mVga2/bsq0
 H6knmV1DB7RLThvTMZEpOF0c+0SIdPXUusB0j3WQlZ33QPMD2wcc2xawm04mzM4sIll1
 QVX5Ov0OER74XEEsTF4ilAJ0a4qkUEIIwJPNCE8rPUFH7veiGJonQ/OA5u8doTLVhCvH
 zWKA==
X-Gm-Message-State: AOJu0Yxc9il/TxOiwBx85ORWrHGp3ZRTHl1/PhLNSgIg4DXC+kEwjeMJ
 2Hb97leuHDGAHEC2gPlijmB9KV6fnEroPL0ovab7/jh2NBu/FTHWZLIr3kYjoYwcXN4=
X-Gm-Gg: ASbGncvD31mct63Hwefhj8wq5yEarFF08qRu22qNVyrv7QnvL00X4USQK42+xyKyWMe
 /3YsyAoLlaBpv9NmNuDegjox2d6jy5OKTTdWz6yQXC3NqYC6kpMc+AKfWKlYykkPnCoBKTiP6XO
 q3o3D/KZZIw6Ka7fzso/t6R7NNu8cvadZ4zrMVPitaIubxv+fZ4/80VT4rHOGKUKbDtjIsFYiJw
 h4FyOP9p0fCAtf8O2+XHs47l7gjZoR/bFvNUuXRZtRXk3m9DcboduCWDBBijzr05QpaksaA7eUK
 vcr5s7fOch04IQCEiEhpan6K7OFJ7DMGJrNRjeeUqojaYpCMSjbWD2DIcL2KhuZH1l0WlhnJDg7
 2Nf0/UyOj1E/Yi56+V96HO9If/Bdn66x5pXHS4CU/ba5fPX5ijm1H4vH9
X-Google-Smtp-Source: AGHT+IGPp0WjJ+kZGVtmmMpVkTlcMr4wvjeW4bSpnMLRKKcmjil1XGA0fu8TxWFE9gMy6AOJuWBkig==
X-Received: by 2002:a05:6808:2018:b0:40b:4957:23d3 with SMTP id
 5614622812f47-4319b249845mr5486062b6e.20.1753977944844; 
 Thu, 31 Jul 2025 09:05:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-433568ea5fbsm322567b6e.2.2025.07.31.09.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 09:05:44 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:05:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v3 1/2] Makefile scripts/Makefile.lib: fix *_efi.so
 dependency to PLATFORM_LIBGCC
Message-ID: <20250731160541.GC1807455@bill-the-cat>
References: <20250718082959.416152-1-mikko.rapeli@linaro.org>
 <20250728214349.GA1750405@bill-the-cat> <aItY7pLA59ejo1Sa@nuoska>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RSXK1SiKjOCt0rNX"
Content-Disposition: inline
In-Reply-To: <aItY7pLA59ejo1Sa@nuoska>
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


--RSXK1SiKjOCt0rNX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 02:52:14PM +0300, Mikko Rapeli wrote:
> Hi,
>=20
> On Mon, Jul 28, 2025 at 03:43:49PM -0600, Tom Rini wrote:
> > On Fri, Jul 18, 2025 at 11:29:58AM +0300, Mikko Rapeli wrote:
> >=20
> > > When PLATFORM_LIBGCC was added to linker command it was not
> > > added to the dependency of the .so and other rules. Thus a build can
> > > try to link *_efi.so files before lib.a from PLATFORM_LIBGCC is avail=
able.
> > > This was seen in yocto autobuilder builds with u-boot 2025.07
> > > update, see https://lists.openembedded.org/g/openembedded-core/messag=
e/220004
> > >=20
> > > https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/2914600/raw=
_inline
> > >=20
> > > |    rm -f lib/efi_loader/built-in.o; arm-poky-linux-gnueabi-ar cDPrs=
T lib/efi_loader/built-in.o lib/efi_loader/efi_bootmgr.o lib/efi_loader/efi=
_bootbin.o lib/efi_loader/efi_boottime.o lib/efi_loader/efi_helper.o lib/ef=
i_loader/efi_console.o lib/efi_loader/efi_device_path.o lib/efi_loader/efi_=
device_path_to_text.o lib/efi_loader/efi_device_path_utilities.o lib/efi_lo=
ader/efi_dt_fixup.o lib/efi_loader/efi_fdt.o lib/efi_loader/efi_file.o lib/=
efi_loader/efi_hii.o lib/efi_loader/efi_hii_config.o lib/efi_loader/efi_ima=
ge_loader.o lib/efi_loader/efi_load_options.o lib/efi_loader/efi_memory.o l=
ib/efi_loader/efi_root_node.o lib/efi_loader/efi_runtime.o lib/efi_loader/e=
fi_setup.o lib/efi_loader/efi_string.o lib/efi_loader/efi_unicode_collation=
=2Eo lib/efi_loader/efi_var_common.o lib/efi_loader/efi_var_mem.o lib/efi_l=
oader/efi_variable.o lib/efi_loader/efi_var_file.o lib/efi_loader/efi_watch=
dog.o lib/efi_loader/efi_disk.o lib/efi_loader/efi_net.o lib/efi_loader/efi=
_smbios.o lib/efi_loader/efi_load_initrd.o lib/efi_loader/efi_conformance.o
> > > |   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc=
 -znorelro --no-warn-rwx-segments -L /srv/pokybuild/yocto-worker/oe-selftes=
t-armhost/build/build-st-3119200/tmp/work/beaglebone_yocto-poky-linux-gnuea=
bi/u-boot/2025.07/sources/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -s=
hared -Bsymbolic -s lib/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o l=
ib/efi_loader/efi_reloc.o lib/efi_loader/efi_freestanding.o arch/arm/lib/li=
b.a -o lib/efi_loader/helloworld_efi.so
> > > | arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No s=
uch file or directory
> > > | make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_e=
fi.so] Error 1
> > >=20
> > > The issue is hard to reproduce but this change can artificially trigg=
er it:
> > >=20
> > >   --- a/scripts/Makefile.build
> > >   +++ b/scripts/Makefile.build
> > > @@ -353,7 +353,7 @@ $(modorder-target): $(subdir-ym) FORCE
> > >  #
> > >  ifdef lib-target
> > >  quiet_cmd_link_l_target =3D AR      $@
> > > -cmd_link_l_target =3D rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(l=
ib-y)
> > > +cmd_link_l_target =3D rm -f $@ && echo "HACK, delaying build!" && sl=
eep 60 && $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)
> > >=20
> > >  $(lib-target): $(lib-y) FORCE
> > >         $(call if_changed,link_l_target)
> > >=20
> > > Then run a rebuild with:
> > >=20
> > > $  rm -f $( find build/ -name lib.a -or -name helloworld_efi.so ) && \
> > >    make
> > > ...
> > >   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -=
znorelro --no-warn-rwx-segments -L /home/mcfrisk/src/base/repo/poky/build_b=
ea
> > > glebone/tmp/work/beaglebone_yocto-poky-linux-gnueabi/u-boot/2025.07/s=
ources/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared -Bsymbolic -s=
 lib/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/efi_loader/efi_r=
eloc.o lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a -o lib/efi_load=
er/helloworld_efi.so
> > > arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No suc=
h file or directory
> > > make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi=
=2Eso] Error 1
> > >=20
> > > Fix by introducing PLATFORM_LIBGCC_LIBA variable with only lib.a
> > > filename which is then used to add the dependency in rules which use
> > > PLATFORM_LIBGCC. This should not impact builds which don't set
> > > PLATFORM_LIBGCC_LIBA and PLATFORM_LIBGCC usage stays as is.
> > >=20
> > > Fixes: 43d43241d1c9 ("scripts/Makefile.lib: add PLATFORM_LIBGCC to ef=
i linking")
> > >=20
> > > Cc: Adriano Cordova <adrianox@gmail.com>
> > > Cc: Fabio Estevam <festevam@gmail.com>
> > > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> >=20
> > So, this series needs a cover letter. And to reword the commit messages,
> > so that the diff to make things fail shows up below the "---". But the
> > fatal problem for right now is this needs to be put through CI next
> > time. This seems to cause some of the EFI apps to not be built now:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1209924
> >=20
> > I assume Azure would have failed too if I let it get that far. Thanks.
>=20
> I think I finally figured this out and will send a patch to Makefile in v=
4.
> arch/$(ARCH)/lib and lib are compiled by separate "make" processes started
> by top level Makefile, and both use the same scripts/Makefile.build etc. =
This
> threw me off quite a bit. And "make" does not tell which dependencies of a
> target are missing if the file level dependency to lib.a is explicit when=
 linking
> the EFI apps.
>=20
> I think the single change to build "arch/$(ARCH)/lib" directory before "l=
ib"
> in top level Makefile is simple enough to explain in commit message
> without a coverletter, similar to how "examples" directory is compiled af=
ter
> all other directories for u-boot binaries.

Ah, good job figuring this out!

--=20
Tom

--RSXK1SiKjOCt0rNX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIuUVQAKCRAr4qD1Cr/k
ClqcAP0ejTtTWKgQPa08aXZRmSG2T4YxpMjMTowajt2YXdZ3vAEA1imChe4MzF36
DzhDgpUKyW0ppg0FzfLJMSVzMkHEgwU=
=onsh
-----END PGP SIGNATURE-----

--RSXK1SiKjOCt0rNX--
