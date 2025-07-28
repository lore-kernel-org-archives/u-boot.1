Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAF7C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 21:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F118882D06;
	Mon, 28 Jul 2025 23:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sc0KeClm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28F52829E7; Mon, 28 Jul 2025 23:43:57 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 022AB82D06
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 23:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2ff8d43619cso3311591fac.1
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753739032; x=1754343832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AaXV4nzVBHRh3iFuUMQgLvHFP7WTvp0aHytgTklls9o=;
 b=Sc0KeClmmq8Dp9OtsTcfEZIE6iQvrv0k2jJk3ZQngXgwh3PURqjUADHnAfvtxp2A4e
 CxdbZTvoyEKEWTX2pgvobv5I2D9Vb0fI4A1+aT0Ws03/FCKB2fgwSqd19Qip4rppqWOC
 tZZHP5h2BgB2NNW4n/rK5MeaWD6IY9UbCkaiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753739032; x=1754343832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AaXV4nzVBHRh3iFuUMQgLvHFP7WTvp0aHytgTklls9o=;
 b=oz2B9+bXWrreOMnbooI6vFk30GvT8vM+bGmePTJmwrLNcZuMf0hL31o/5uW5ZqiQE9
 WsRz7SG7qbwZZQg/p61zDSCYs6XjltApufEeeD0yGH3lXiya6VNTMKfLT3HzbjQXVCTz
 ZwrVEfvyuDf30SIsw4+tU9Mtat8r/MnVuLrgGOXAmwLEVv3JAWZ6FRqPExn2iVxLSpyb
 dIrWY/gva0e5/hlU2eHH35/ln160Wx7n8NNRRp8mxnS/g3HlnZ7vgwzXTkl9ofzoM/dr
 JJYtR9Y/JOorY6YjESyqBqqTHYjd5Kx1JcCWYLLd7xp3WwTAIx+AxQ+JRxiaima+ix5p
 7rcA==
X-Gm-Message-State: AOJu0Yzna+VLtDCJ2hkoiLnZmsjp7LoGK3lswQPBAu1ZLVdFfihuEAKP
 0HhRoSTq6IsK5L/1l5HSxaEzK0Ydmem1PyICQOjgXaF26mIVcxRJym+gjOZtm6fnbP0=
X-Gm-Gg: ASbGncsoJVsuvwRnVs0gRu+f9iU9QTuT5RHqUTFlX1frpjuZFnP7mX6tU7vl1PKunGW
 hwx6BPLzDWOX+iPa4PUt1fjUzhrJSbR7o0yTvcieD8FVjUjgo1OufQQc8larKA/hY6a6//7wGlE
 3mj4IVhSwPhhzwYkSHdEQtCj3JxKXPJx5oYUvZeq7jogbEbAB8RPSGrIeKzv5d4zJFwmP3tB3mT
 e09jCtut1EEsrB0jr7CmccxxjqPcJfpMhes8gkK29a892EjGPHbhZlQ3Bd58Lyljr1wxZB9R7WC
 VmOzhS5yhtSmXnUCnw5s2CwxaWovVIJ6wuDWclzXEKgUr40MvycFkyCFmoPK9IDWVOOogPr2tPp
 pCnRkVd1j9LZE+e0A1A+ECRuOv79bNTxJ02VrBBILyFKurCeTASVAa6Vl
X-Google-Smtp-Source: AGHT+IFcKlvjbPD6HjoAz2FMEtEvtLFlHYFyprqoNbHU4WocuhYnPczqarSsgnSacSNHUGlGlBlR2w==
X-Received: by 2002:a05:6870:3854:b0:2f6:c9a6:4f7f with SMTP id
 586e51a60fabf-30701bdf3a3mr8689784fac.39.1753739032450; 
 Mon, 28 Jul 2025 14:43:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071316fd0fsm1828312fac.3.2025.07.28.14.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 14:43:51 -0700 (PDT)
Date: Mon, 28 Jul 2025 15:43:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 1/2] Makefile scripts/Makefile.lib: fix *_efi.so
 dependency to PLATFORM_LIBGCC
Message-ID: <20250728214349.GA1750405@bill-the-cat>
References: <20250718082959.416152-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fT1dHxevz86pcQ62"
Content-Disposition: inline
In-Reply-To: <20250718082959.416152-1-mikko.rapeli@linaro.org>
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


--fT1dHxevz86pcQ62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 11:29:58AM +0300, Mikko Rapeli wrote:

> When PLATFORM_LIBGCC was added to linker command it was not
> added to the dependency of the .so and other rules. Thus a build can
> try to link *_efi.so files before lib.a from PLATFORM_LIBGCC is available.
> This was seen in yocto autobuilder builds with u-boot 2025.07
> update, see https://lists.openembedded.org/g/openembedded-core/message/22=
0004
>=20
> https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/2914600/raw_inl=
ine
>=20
> |    rm -f lib/efi_loader/built-in.o; arm-poky-linux-gnueabi-ar cDPrsT li=
b/efi_loader/built-in.o lib/efi_loader/efi_bootmgr.o lib/efi_loader/efi_boo=
tbin.o lib/efi_loader/efi_boottime.o lib/efi_loader/efi_helper.o lib/efi_lo=
ader/efi_console.o lib/efi_loader/efi_device_path.o lib/efi_loader/efi_devi=
ce_path_to_text.o lib/efi_loader/efi_device_path_utilities.o lib/efi_loader=
/efi_dt_fixup.o lib/efi_loader/efi_fdt.o lib/efi_loader/efi_file.o lib/efi_=
loader/efi_hii.o lib/efi_loader/efi_hii_config.o lib/efi_loader/efi_image_l=
oader.o lib/efi_loader/efi_load_options.o lib/efi_loader/efi_memory.o lib/e=
fi_loader/efi_root_node.o lib/efi_loader/efi_runtime.o lib/efi_loader/efi_s=
etup.o lib/efi_loader/efi_string.o lib/efi_loader/efi_unicode_collation.o l=
ib/efi_loader/efi_var_common.o lib/efi_loader/efi_var_mem.o lib/efi_loader/=
efi_variable.o lib/efi_loader/efi_var_file.o lib/efi_loader/efi_watchdog.o =
lib/efi_loader/efi_disk.o lib/efi_loader/efi_net.o lib/efi_loader/efi_smbio=
s.o lib/efi_loader/efi_load_initrd.o lib/efi_loader/efi_conformance.o
> |   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -zn=
orelro --no-warn-rwx-segments -L /srv/pokybuild/yocto-worker/oe-selftest-ar=
mhost/build/build-st-3119200/tmp/work/beaglebone_yocto-poky-linux-gnueabi/u=
-boot/2025.07/sources/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -share=
d -Bsymbolic -s lib/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/e=
fi_loader/efi_reloc.o lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a =
-o lib/efi_loader/helloworld_efi.so
> | arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such =
file or directory
> | make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.s=
o] Error 1
>=20
> The issue is hard to reproduce but this change can artificially trigger i=
t:
>=20
>   --- a/scripts/Makefile.build
>   +++ b/scripts/Makefile.build
> @@ -353,7 +353,7 @@ $(modorder-target): $(subdir-ym) FORCE
>  #
>  ifdef lib-target
>  quiet_cmd_link_l_target =3D AR      $@
> -cmd_link_l_target =3D rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)
> +cmd_link_l_target =3D rm -f $@ && echo "HACK, delaying build!" && sleep =
60 && $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)
>=20
>  $(lib-target): $(lib-y) FORCE
>         $(call if_changed,link_l_target)
>=20
> Then run a rebuild with:
>=20
> $  rm -f $( find build/ -name lib.a -or -name helloworld_efi.so ) && \
>    make
> ...
>   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -znor=
elro --no-warn-rwx-segments -L /home/mcfrisk/src/base/repo/poky/build_bea
> glebone/tmp/work/beaglebone_yocto-poky-linux-gnueabi/u-boot/2025.07/sourc=
es/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared -Bsymbolic -s lib=
/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/efi_loader/efi_reloc=
=2Eo lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a -o lib/efi_loader=
/helloworld_efi.so
> arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such fi=
le or directory
> make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.so]=
 Error 1
>=20
> Fix by introducing PLATFORM_LIBGCC_LIBA variable with only lib.a
> filename which is then used to add the dependency in rules which use
> PLATFORM_LIBGCC. This should not impact builds which don't set
> PLATFORM_LIBGCC_LIBA and PLATFORM_LIBGCC usage stays as is.
>=20
> Fixes: 43d43241d1c9 ("scripts/Makefile.lib: add PLATFORM_LIBGCC to efi li=
nking")
>=20
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

So, this series needs a cover letter. And to reword the commit messages,
so that the diff to make things fail shows up below the "---". But the
fatal problem for right now is this needs to be put through CI next
time. This seems to cause some of the EFI apps to not be built now:
https://source.denx.de/u-boot/u-boot/-/jobs/1209924

I assume Azure would have failed too if I let it get that far. Thanks.

--=20
Tom

--fT1dHxevz86pcQ62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIfvEQAKCRAr4qD1Cr/k
CqjaAP43WQP0qtRjxTZ3D6toH54XkzFPDbUk0fQzvL2384kttwEAkGT0m+Z92Pud
6O8GqJvu3Cx8hNn5HJrJPl9wnnSEbwQ=
=aecf
-----END PGP SIGNATURE-----

--fT1dHxevz86pcQ62--
