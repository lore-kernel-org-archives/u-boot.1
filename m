Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE93C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 08:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B64A282D06;
	Tue, 29 Jul 2025 10:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a1zaSM28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D6C982D21; Tue, 29 Jul 2025 10:19:34 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0777882BA1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 10:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-33216091f46so5811221fa.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753777171; x=1754381971; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7aNGj5PCa3GegfTEKV28D3VVB007ToWmELvayelU+dg=;
 b=a1zaSM28N05mM0+D4lb0Weosv6COtoX3lNpmzfN+dcdzT+JJxQlC9/gPSwXu5Zp47l
 v3I3N+bUACZtdYhdQWbD8pYI3MktYX1+WWE40Lq5ld2j7tC3vX+CuWjPzJOCQpNjq0HJ
 sv1lUxr2yqP7+gswJ5WlknNZNkiOTmcIxDrQQi0eKRflyFIpajZhIINmWrSothGhgOST
 ThVqWW2O0N30yvr+MT3p5BZRPqPLMGYK4G/5qlFFeGnPwen1twoBHcLxwbGyp5suskXq
 Bs4HcPmBYsQ8Zsk993dUiWde0rE2wZYfByMuCQKqUds4ydqxb1AkP4szft+/KOsaFQLl
 m98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753777171; x=1754381971;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7aNGj5PCa3GegfTEKV28D3VVB007ToWmELvayelU+dg=;
 b=EVN1WmDtFCbBKRd5Qv0p0JhKSdanRRlEeIhRygayw0NqS1d8nOl/8k5qkWQUUO21UN
 /ow5BoLIR+Uy58lUvV+aEnBNgPP1elAwczRTn8bk7p7XQpEnJ2S/JNLIcpRS17IznoWF
 zu3vjJ1BnrALI9UqYGJqaMU99JErFMNIx5tK8koqmariRgZEvmsQ73b1b+JHef7oSCgO
 dExqRdtCxvyN9PmPA/cyxhBNeTql94VHPb94LVtyKt/ECaQ3KDzy8dXDP6EUWJyinpKT
 8Iq5LB8iB4QvSM07VqTmvCAy6HrtppFTCoJlekzF9QJhdS8Vbk1rzqajWITc6BD91kxK
 wfoA==
X-Gm-Message-State: AOJu0YzCyBJ9VmVAwt8kZu985fSEK3+zBOq7RTHwZvRKuNopV6GJHIeh
 pQbYKDpq8Lh4fTFK2QmyeMzrbaeW8NXAKE2oMsaXZinwTu2g9L5bWMNL2rZaOTteKJZtzKU+hDd
 jSfTs
X-Gm-Gg: ASbGncv3/uoDykXmauQGi4aJagSwCfUA7p33eYQnjtY+OeZo2ad8TQBKbb/Hi7bG8e0
 IW9DS9eZp4E3iGUTPFOX/32NqBw0L/JHJbv3ISFWy3kLzMXjj+L5bGBV9VowjlS20d7tcAmYdKP
 azita0neFuyYKen1RniFqMcgOzXVKGaqOWrpwINHAgEKYxIU0ARcPDkHi/CoUK+EXebcCKaAltO
 FA/Ye4rGmWox3+SEx+lmkbBv75hovMHoGgkbz13CcpDKqBdZAO0EU5QrCDx/Ayjh0FwTVQxoXiu
 FOklxkFI7dt4z7VbWDSK77t+rm/clG1og+nNX4+Gg/yetCz6jTBA+GTLWiyErvdyb4QBh+85IML
 BW9M7FDH5DIWUReWyqvyYBaRrpVPdgigLCy/pImHhvHN8F23F0VklW+I=
X-Google-Smtp-Source: AGHT+IFrlIgyOOEH9DP2pMdNOfaArQ4cBLmLGCifjb/ZA+YpEzl3oynLX/3d3+t2pbSwTNS4yvkJXQ==
X-Received: by 2002:a05:6512:3daa:b0:553:2668:6f34 with SMTP id
 2adb3069b0e04-55b5f4aac43mr3740660e87.45.1753777171240; 
 Tue, 29 Jul 2025 01:19:31 -0700 (PDT)
Received: from nuoska (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b633760e6sm1566129e87.160.2025.07.29.01.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 01:19:30 -0700 (PDT)
Date: Tue, 29 Jul 2025 11:19:29 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 1/2] Makefile scripts/Makefile.lib: fix *_efi.so
 dependency to PLATFORM_LIBGCC
Message-ID: <aIiEEUsOmqOMLS_d@nuoska>
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

Ok, I can add a cover letter but details need to be in commit message too.
I'm surprised how many things have failed when commit message has a diff
but I will describe the test in some way there.

The issues seen in yocto autobuilder are fixed by the first patch.
Second patch is for the failure I saw when building with the hack
which delays linking. This breaks the EFI app builds and I can
reproduce that. The patch is somehow wrong, but without it the artificially
delayed linking step fails in my test builds. I'll investigate this more.

Cheers,

-Mikko
