Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268CFC87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDEA83857;
	Thu, 31 Jul 2025 13:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YaSYpW8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E148389A; Thu, 31 Jul 2025 13:53:14 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B0983852
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-32e14ce168eso7557461fa.1
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753962738; x=1754567538; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nio0j49pSrqmq/7Ca55B42BZGKgT2v/vpoF1mqezeYI=;
 b=YaSYpW8nukbr+Ll+84RA3CRXdhn5KEdHQPDpDYzQqybVV9X2+5x+SYt7/hzkKjZFyk
 ep5WEeRtoLMMvWAidIZB0Ojk30T2dgruf9NJmwDtthweWI8FAASHLfTeD2fyVnsocp8r
 ts9D7eHli+TUUux45TeU6lCGHlqv84U5B3BEOBVDwBnA5yDpTuEsoqyjt/2hN+zDQmbp
 NPJ3HmhTXYcM8VjEKG9v5IeF9p1wZDf7d3IYi3dRLkHP770HmHie91sMaYqpFI2TgoCZ
 /awNfGywG1CY9CDnLdbaBkDLH5t9GFD003gKG8hznZXDRZa4JmUWab9jnwBGHvR9qZ9u
 8K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753962738; x=1754567538;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nio0j49pSrqmq/7Ca55B42BZGKgT2v/vpoF1mqezeYI=;
 b=aY4fn4IcPbOC5yBXcmKBo1FrcHRLt4d3NSdyg9jx9TrX9KX01+3Q+ruImStENZUabb
 67A03myuAYZbC5ST7E46ORQqIWgrDscGdgmfPWNKcle5q/csIzGuTue5voInLzNwMAD5
 Z8ko2iddlAozfLyjo92xrv6FlSdCrQ2Zl+gY12/pr2GEFWxqwxpZGwzwJ34qhCBIqVX+
 Vdi1nCmruLdKiNw40rMvWLyVXixg8RAkaI2MHp6LGkJYffcbmQKciwpN8TsojD3IVXKJ
 PjmPYlOYfyIVuWWKQfM3wxD+H5+zP2YHT3tL7FR0kwaJTz9d5KVUxEinsvQ9Eyqy7xj5
 qaYw==
X-Gm-Message-State: AOJu0YzftDN5eGv6NW7lZ4QC88AWROeAfY5IafU5o6kP08MLxJlMr/Nj
 lbD/1fGQZSM/O1oeuKuA7Xe7HFw2mjQiCh/mf1dKxw23UDpBVQMyQ1DpZTwZMV7Jt0Y=
X-Gm-Gg: ASbGncsah6cSGFdf5n7lUhxD08EP02Hrij6DHrudVVHrL9i11LbZ8T1epP9TLIzSo20
 ouL5OWyB+66T7iC6frS0ZJeh4oQSG5VksNyb1H6aSWewYZnz+z8XrAuLKunKhFeEtKMkBvYJYOr
 9a+kGZTKQ1mrf5zY0+qXT/VOR9HBSAZ/xrs5kyDMQn2XO4u/dq37bibIlCdmQ+4ImA+YYq1zphr
 rKBZwR5JGH8QgF24iY1PZt1QbVMo3gfJEcu/Qe3b/RAcaAskhHbqxkkWf/tgI7CelyUonfyG1DQ
 HPGhMgx0Xcc+n8dQuyDla5QUC0mhoIu/JMK+H4ELzxiLgYzj4VoONiOG1NSG1RBdflEzN1kP7dc
 7Jf8+zmmBAYliWMD10XRUbK0+oToAnYvU4OUFGzNeJnceVuxwkenA114=
X-Google-Smtp-Source: AGHT+IFkK4ZPTdYzDOuRRvjcJ+QlddQlal3nAVTX1PR1hm6Htk4kHcSp3wvEahS9qgiVqzLfjBORQg==
X-Received: by 2002:a05:6512:3402:b0:553:2a6a:884b with SMTP id
 2adb3069b0e04-55b7c042d7amr1996488e87.23.1753962737531; 
 Thu, 31 Jul 2025 04:52:17 -0700 (PDT)
Received: from nuoska (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b8898bfa4sm206104e87.21.2025.07.31.04.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 04:52:17 -0700 (PDT)
Date: Thu, 31 Jul 2025 14:52:14 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 1/2] Makefile scripts/Makefile.lib: fix *_efi.so
 dependency to PLATFORM_LIBGCC
Message-ID: <aItY7pLA59ejo1Sa@nuoska>
References: <20250718082959.416152-1-mikko.rapeli@linaro.org>
 <20250728214349.GA1750405@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250728214349.GA1750405@bill-the-cat>
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

Hi,

On Mon, Jul 28, 2025 at 03:43:49PM -0600, Tom Rini wrote:
> On Fri, Jul 18, 2025 at 11:29:58AM +0300, Mikko Rapeli wrote:
>=20
> > When PLATFORM_LIBGCC was added to linker command it was not
> > added to the dependency of the .so and other rules. Thus a build can
> > try to link *_efi.so files before lib.a from PLATFORM_LIBGCC is availab=
le.
> > This was seen in yocto autobuilder builds with u-boot 2025.07
> > update, see https://lists.openembedded.org/g/openembedded-core/message/=
220004
> >=20
> > https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/2914600/raw_i=
nline
> >=20
> > |    rm -f lib/efi_loader/built-in.o; arm-poky-linux-gnueabi-ar cDPrsT =
lib/efi_loader/built-in.o lib/efi_loader/efi_bootmgr.o lib/efi_loader/efi_b=
ootbin.o lib/efi_loader/efi_boottime.o lib/efi_loader/efi_helper.o lib/efi_=
loader/efi_console.o lib/efi_loader/efi_device_path.o lib/efi_loader/efi_de=
vice_path_to_text.o lib/efi_loader/efi_device_path_utilities.o lib/efi_load=
er/efi_dt_fixup.o lib/efi_loader/efi_fdt.o lib/efi_loader/efi_file.o lib/ef=
i_loader/efi_hii.o lib/efi_loader/efi_hii_config.o lib/efi_loader/efi_image=
_loader.o lib/efi_loader/efi_load_options.o lib/efi_loader/efi_memory.o lib=
/efi_loader/efi_root_node.o lib/efi_loader/efi_runtime.o lib/efi_loader/efi=
_setup.o lib/efi_loader/efi_string.o lib/efi_loader/efi_unicode_collation.o=
 lib/efi_loader/efi_var_common.o lib/efi_loader/efi_var_mem.o lib/efi_loade=
r/efi_variable.o lib/efi_loader/efi_var_file.o lib/efi_loader/efi_watchdog.=
o lib/efi_loader/efi_disk.o lib/efi_loader/efi_net.o lib/efi_loader/efi_smb=
ios.o lib/efi_loader/efi_load_initrd.o lib/efi_loader/efi_conformance.o
> > |   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -=
znorelro --no-warn-rwx-segments -L /srv/pokybuild/yocto-worker/oe-selftest-=
armhost/build/build-st-3119200/tmp/work/beaglebone_yocto-poky-linux-gnueabi=
/u-boot/2025.07/sources/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -sha=
red -Bsymbolic -s lib/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib=
/efi_loader/efi_reloc.o lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.=
a -o lib/efi_loader/helloworld_efi.so
> > | arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No suc=
h file or directory
> > | make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi=
=2Eso] Error 1
> >=20
> > The issue is hard to reproduce but this change can artificially trigger=
 it:
> >=20
> >   --- a/scripts/Makefile.build
> >   +++ b/scripts/Makefile.build
> > @@ -353,7 +353,7 @@ $(modorder-target): $(subdir-ym) FORCE
> >  #
> >  ifdef lib-target
> >  quiet_cmd_link_l_target =3D AR      $@
> > -cmd_link_l_target =3D rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib=
-y)
> > +cmd_link_l_target =3D rm -f $@ && echo "HACK, delaying build!" && slee=
p 60 && $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)
> >=20
> >  $(lib-target): $(lib-y) FORCE
> >         $(call if_changed,link_l_target)
> >=20
> > Then run a rebuild with:
> >=20
> > $  rm -f $( find build/ -name lib.a -or -name helloworld_efi.so ) && \
> >    make
> > ...
> >   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -zn=
orelro --no-warn-rwx-segments -L /home/mcfrisk/src/base/repo/poky/build_bea
> > glebone/tmp/work/beaglebone_yocto-poky-linux-gnueabi/u-boot/2025.07/sou=
rces/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared -Bsymbolic -s l=
ib/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/efi_loader/efi_rel=
oc.o lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a -o lib/efi_loader=
/helloworld_efi.so
> > arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such =
file or directory
> > make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.s=
o] Error 1
> >=20
> > Fix by introducing PLATFORM_LIBGCC_LIBA variable with only lib.a
> > filename which is then used to add the dependency in rules which use
> > PLATFORM_LIBGCC. This should not impact builds which don't set
> > PLATFORM_LIBGCC_LIBA and PLATFORM_LIBGCC usage stays as is.
> >=20
> > Fixes: 43d43241d1c9 ("scripts/Makefile.lib: add PLATFORM_LIBGCC to efi =
linking")
> >=20
> > Cc: Adriano Cordova <adrianox@gmail.com>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
>=20
> So, this series needs a cover letter. And to reword the commit messages,
> so that the diff to make things fail shows up below the "---". But the
> fatal problem for right now is this needs to be put through CI next
> time. This seems to cause some of the EFI apps to not be built now:
> https://source.denx.de/u-boot/u-boot/-/jobs/1209924
>=20
> I assume Azure would have failed too if I let it get that far. Thanks.

I think I finally figured this out and will send a patch to Makefile in v4.
arch/$(ARCH)/lib and lib are compiled by separate "make" processes started
by top level Makefile, and both use the same scripts/Makefile.build etc. Th=
is
threw me off quite a bit. And "make" does not tell which dependencies of a
target are missing if the file level dependency to lib.a is explicit when l=
inking
the EFI apps.

I think the single change to build "arch/$(ARCH)/lib" directory before "lib"
in top level Makefile is simple enough to explain in commit message
without a coverletter, similar to how "examples" directory is compiled after
all other directories for u-boot binaries.

Cheers,

-Mikko
