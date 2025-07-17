Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE34C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 10:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9773D8338C;
	Thu, 17 Jul 2025 12:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nEkIASrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 982B783390; Thu, 17 Jul 2025 12:50:54 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B9683335
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 12:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-32b78b5aa39so7787761fa.1
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752749451; x=1753354251; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/py0OkqBOGSbbTFjDFIYtq0K60IiVwjoA7KpxBSn8tU=;
 b=nEkIASrK7xS7+2lGIql4aLVe5bFzknZlcA/Dpkkg/EOEvoZVkI/9PfNXqH4Q4pkjWZ
 2qwgH46Kh1MmpvyHByJNvaPS22z3UDUABRtDFEsRTVbnYeIuOMvV0kGu58c1K09el9u/
 409prt5gD5Bn4FB18snydleVz6mRGII/U9L3L046gzWPkIy/coJCubsSED5/qZQjLkaw
 yyKlNnht9i1VONaO6vUWXkcuA5VxnFX2W1kcJ+kHJvU/eHcjdLycyJBmZCPRja4h70IS
 VoPjxUJ9tP+jtzrJeIlTR+DK7mpAHU6Lykjmh+6KvX+BPRDU0DXBveA8tSDZAb6n+JO4
 A3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752749451; x=1753354251;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/py0OkqBOGSbbTFjDFIYtq0K60IiVwjoA7KpxBSn8tU=;
 b=Yiw/8lGfEFsPFD4YxgXguJATSGFgA+vx9JoB+h6t0KXnlxNYxiEQPVhsrEwf+16L72
 kJfc/FdJTdSmlDUzK7JcLbhPHOcNoShRn0sx3x8wvKlPmfN3Pl/6lPDNjl8JTjOnTgqb
 YCd7GnSgJ0d0OFhgwY+bpMq2EkR3VjSmwIKzW6q4lBeULW9jb+pDmnGIzurKRXHLzcro
 nqOL4TSrxDAuhMEGoJ2bt/MfcdO458hTl1nQTD+GSePTdklIGJhJ8vV1CRLr1eeifvW9
 SoHvBS7S+BAfEdC4sUL1g7ndhsbzOEjVYvewBSt/4QBOJXq9oeKoxUHc+6Bd4+Ec/A1/
 f1qA==
X-Gm-Message-State: AOJu0YzC70mbcBhiEFLfYZE16XJ2reHVOjMcccIzOzdgfCrzo6tCA7yd
 S1Rd1ZejEQNa3A84Kc+Pa/CVtN80Oa+HH639XLXXr4ZZNIaFPpn6k1fjlO82ZhA/UbjDicOlAMv
 y2fsu
X-Gm-Gg: ASbGncu7tgZWRyXMyaCdzqsZwEEqd3/WUWpnG6Zs6tolgj2pLbh4tJyWRQ47v/Gnyfm
 xld/GGdXUaNidH4oYECra2baHQhHBXnKvr4ySPmuhpHU3C0SX9AtrMDuq3z9aOVXVYnuOAvA57Z
 v+VYlbn/Ok1EhINbI/aA70DzMA0Ko+AbAzKCMo8HGx3nbCMMycuw1kIIhpbr2oh81bJXgVC/+Mz
 BABQXc2evPvdaMQVxQ55uTMT2CRU0nHsOTPmEMuL2JAM+T7+cBl2qKbfrudb5Ak81gF3tRos7HY
 WVC+Nf8bwDdFJM0fyvJpo3ywAcr/LX+TxIfnV1x0TtvHa/lvHqosXOWnn23FOG79OPq1y6aqb+x
 QxxLQtLvy5D/KMO9KmSmxr0FCy33ZTJdptVxu9ACYnxpQfh+tg5Z/zdQdL4u5EKPRNw==
X-Google-Smtp-Source: AGHT+IGyhS82tvgLus1gAVqwSbOTsdIF4qvIdrgc/XGiId1rQeUF0STb4vKUrjCJ8o+oNWOdI+vVog==
X-Received: by 2002:a05:651c:1102:b0:32a:651c:9aea with SMTP id
 38308e7fff4ca-3308f600591mr17814521fa.34.1752749450460; 
 Thu, 17 Jul 2025 03:50:50 -0700 (PDT)
Received: from nuoska (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-32fab8ed429sm24517821fa.85.2025.07.17.03.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 03:50:50 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:50:48 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: u-boot@lists.denx.de
Cc: Adriano Cordova <adrianox@gmail.com>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] Makefile scripts/Makefile.lib: fix *_efi.so
 dependency to PLATFORM_LIBGCC
Message-ID: <aHjViKMwnaCIAn3N@nuoska>
References: <20250711065149.350463-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250711065149.350463-1-mikko.rapeli@linaro.org>
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

Yocto side testing shows that this patch does not fix the race
and missing lib.a:

https://lists.openembedded.org/g/openembedded-core/message/220519

Builds failure logs:

https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/2984138/raw_inline

|   arm-poky-linux-gnueabi-gcc  --sysroot=3D/srv/pokybuild/yocto-worker/oe-=
selftest-fedora/build/build-st-3774036/tmp/work/qemuarm-poky-linux-gnueabi/=
u-boot/2025.07/recipe-sysroot  -ffile-prefix-map=3D/srv/pokybuild/yocto-wor=
ker/oe-selftest-fedora/build/build-st-3774036/tmp/work/qemuarm-poky-linux-g=
nueabi/u-boot/2025.07/sources/u-boot-2025.07=3D/usr/src/debug/u-boot/2025.0=
7  -ffile-prefix-map=3D/srv/pokybuild/yocto-worker/oe-selftest-fedora/build=
/build-st-3774036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/build=
=3D/usr/src/debug/u-boot/2025.07  -ffile-prefix-map=3D/srv/pokybuild/yocto-=
worker/oe-selftest-fedora/build/build-st-3774036/tmp/work/qemuarm-poky-linu=
x-gnueabi/u-boot/2025.07/recipe-sysroot=3D  -ffile-prefix-map=3D/srv/pokybu=
ild/yocto-worker/oe-selftest-fedora/build/build-st-3774036/tmp/work/qemuarm=
-poky-linux-gnueabi/u-boot/2025.07/recipe-sysroot-native=3D  -Wp,-MD,lib/ef=
i_loader/.testapp.o.d -nostdinc -isystem /srv/pokybuild/yocto-worker/oe-sel=
ftest-fedora/build/build-st-3774036/tmp/work/qemuarm-poky-linux-gnueabi/u-b=
oot/2025.07/recipe-sysroot-native/usr/bin/arm-poky-linux-gnueabi/../../lib/=
arm-poky-linux-gnueabi/gcc/arm-poky-linux-gnueabi/15.1.0/include -Iinclude =
 -I/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/build-st-3774036/tm=
p/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/sources/u-boot-2025.07/inc=
lude     -I/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/build-st-37=
74036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/sources/u-boot-202=
5.07/arch/arm/include -include /srv/pokybuild/yocto-worker/oe-selftest-fedo=
ra/build/build-st-3774036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.0=
7/sources/u-boot-2025.07/include/linux/kconfig.h -I/srv/pokybuild/yocto-wor=
ker/oe-selftest-fedora/build/build-st-3774036/tmp/work/qemuarm-poky-linux-g=
nueabi/u-boot/2025.07/sources/u-boot-2025.07/dts/upstream/include   -I/srv/=
pokybuild/yocto-worker/oe-selftest-fedora/build/build-st-3774036/tmp/work/q=
emuarm-poky-linux-gnueabi/u-boot/2025.07/sources/u-boot-2025.07/lib/efi_loa=
der -Ilib/efi_loader -D__KERNEL__ -D__UBOOT__ -Wall -Wstrict-prototypes -Wn=
o-format-security -fno-builtin -ffreestanding -std=3Dgnu11 -fshort-wchar -f=
no-strict-aliasing -fno-PIE -Os -fno-stack-protector -fno-delete-null-point=
er-checks -Wno-pointer-sign -Wno-stringop-truncation -Wno-zero-length-bound=
s -Wno-array-bounds -Wno-stringop-overflow -Wno-maybe-uninitialized -fmacro=
-prefix-map=3D/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/build-st=
-3774036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/sources/u-boot-=
2025.07/=3D -gdwarf-4 -fstack-usage -Wno-format-nonliteral -Wno-address-of-=
packed-member -Wno-unused-but-set-variable -Werror=3Ddate-time -Wno-packed-=
not-aligned -D__ARM__ -Wa,-mimplicit-it=3Dalways -mthumb -mthumb-interwork =
-mabi=3Daapcs-linux -mword-relocations -mno-unaligned-access -fno-common -m=
soft-float -mgeneral-regs-only -pipe -march=3Darmv7-a -D__LINUX_ARM_ARCH__=
=3D7 -mtune=3Dgeneric-armv7-a  -I/srv/pokybuild/yocto-worker/oe-selftest-fe=
dora/build/build-st-3774036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025=
=2E07/sources/u-boot-2025.07/arch/arm/mach-omap2/include -fpic -fshort-wcha=
r -Os -ffreestanding    -DKBUILD_BASENAME=3D'"testapp"'  -DKBUILD_MODNAME=
=3D'"testapp"' -c -o lib/efi_loader/testapp.o /srv/pokybuild/yocto-worker/o=
e-selftest-fedora/build/build-st-3774036/tmp/work/qemuarm-poky-linux-gnueab=
i/u-boot/2025.07/sources/u-boot-2025.07/lib/efi_loader/testapp.c
|    rm -f lib/efi_loader/built-in.o; arm-poky-linux-gnueabi-ar cDPrsT lib/=
efi_loader/built-in.o lib/efi_loader/efi_bootmgr.o lib/efi_loader/efi_bootb=
in.o lib/efi_loader/efi_boottime.o lib/efi_loader/efi_helper.o lib/efi_load=
er/efi_console.o lib/efi_loader/efi_device_path.o lib/efi_loader/efi_device=
_path_to_text.o lib/efi_loader/efi_device_path_utilities.o lib/efi_loader/e=
fi_dt_fixup.o lib/efi_loader/efi_fdt.o lib/efi_loader/efi_file.o lib/efi_lo=
ader/efi_hii.o lib/efi_loader/efi_hii_config.o lib/efi_loader/efi_image_loa=
der.o lib/efi_loader/efi_load_options.o lib/efi_loader/efi_memory.o lib/efi=
_loader/efi_root_node.o lib/efi_loader/efi_runtime.o lib/efi_loader/efi_set=
up.o lib/efi_loader/efi_string.o lib/efi_loader/efi_unicode_collation.o lib=
/efi_loader/efi_var_common.o lib/efi_loader/efi_var_mem.o lib/efi_loader/ef=
i_variable.o lib/efi_loader/efi_var_file.o lib/efi_loader/efi_watchdog.o li=
b/efi_loader/efi_disk.o lib/efi_loader/efi_net.o lib/efi_loader/efi_smbios.=
o lib/efi_loader/efi_load_initrd.o lib/efi_loader/efi_conformance.o
|   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -znor=
elro --no-warn-rwx-segments -L /srv/pokybuild/yocto-worker/oe-selftest-fedo=
ra/build/build-st-3774036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.0=
7/sources/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared -Bsymbolic=
 -s lib/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/efi_loader/ef=
i_reloc.o lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a -o lib/efi_l=
oader/helloworld_efi.so
| arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such fi=
le or directory
| make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.so]=
 Error 1

https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/2984135/raw_inline

| make -f /srv/pokybuild/yocto-worker/oe-selftest-debian/build/build-st-368=
3036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/sources/u-boot-2025=
=2E07/scripts/Makefile.build obj=3Dlib/efi_loader
|   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -znor=
elro --no-warn-rwx-segments -L /srv/pokybuild/yocto-worker/oe-selftest-debi=
an/build/build-st-3683036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.0=
7/sources/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared -Bsymbolic=
 -s lib/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/efi_loader/ef=
i_reloc.o lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a -o lib/efi_l=
oader/helloworld_efi.so
| arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such fi=
le or directory
| make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.so]=
 Error 1
| make[2]: *** [/srv/pokybuild/yocto-worker/oe-selftest-debian/build/build-=
st-3683036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/sources/u-boo=
t-2025.07/scripts/Makefile.build:398: lib/efi_loader] Error 2
| make[1]: *** [/srv/pokybuild/yocto-worker/oe-selftest-debian/build/build-=
st-3683036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/sources/u-boo=
t-2025.07/Makefile:1920: lib] Error 2
| make[1]: Leaving directory '/srv/pokybuild/yocto-worker/oe-selftest-debia=
n/build/build-st-3683036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07=
/build'
| make: Leaving directory '/srv/pokybuild/yocto-worker/oe-selftest-debian/b=
uild/build-st-3683036/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/so=
urces/u-boot-2025.07'
| make: *** [Makefile:177: sub-make] Error 2

https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/2984171/raw_inline

|   arm-poky-linux-gnueabi-gcc  --sysroot=3D/srv/pokybuild/yocto-worker/oe-=
selftest-armhost/build/build-st-1802970/tmp/work/qemuarm-poky-linux-gnueabi=
/u-boot/2025.07/recipe-sysroot  -ffile-prefix-map=3D/srv/pokybuild/yocto-wo=
rker/oe-selftest-armhost/build/build-st-1802970/tmp/work/qemuarm-poky-linux=
-gnueabi/u-boot/2025.07/sources/u-boot-2025.07=3D/usr/src/debug/u-boot/2025=
=2E07  -ffile-prefix-map=3D/srv/pokybuild/yocto-worker/oe-selftest-armhost/=
build/build-st-1802970/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/b=
uild=3D/usr/src/debug/u-boot/2025.07  -ffile-prefix-map=3D/srv/pokybuild/yo=
cto-worker/oe-selftest-armhost/build/build-st-1802970/tmp/work/qemuarm-poky=
-linux-gnueabi/u-boot/2025.07/recipe-sysroot=3D  -ffile-prefix-map=3D/srv/p=
okybuild/yocto-worker/oe-selftest-armhost/build/build-st-1802970/tmp/work/q=
emuarm-poky-linux-gnueabi/u-boot/2025.07/recipe-sysroot-native=3D  -Wp,-MD,=
lib/efi_loader/.testapp.o.d -nostdinc -isystem /srv/pokybuild/yocto-worker/=
oe-selftest-armhost/build/build-st-1802970/tmp/work/qemuarm-poky-linux-gnue=
abi/u-boot/2025.07/recipe-sysroot-native/usr/bin/arm-poky-linux-gnueabi/../=
=2E./lib/arm-poky-linux-gnueabi/gcc/arm-poky-linux-gnueabi/15.1.0/include -=
Iinclude  -I/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/build-st-=
1802970/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/sources/u-boot-2=
025.07/include     -I/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/=
build-st-1802970/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/sources=
/u-boot-2025.07/arch/arm/include -include /srv/pokybuild/yocto-worker/oe-se=
lftest-armhost/build/build-st-1802970/tmp/work/qemuarm-poky-linux-gnueabi/u=
-boot/2025.07/sources/u-boot-2025.07/include/linux/kconfig.h -I/srv/pokybui=
ld/yocto-worker/oe-selftest-armhost/build/build-st-1802970/tmp/work/qemuarm=
-poky-linux-gnueabi/u-boot/2025.07/sources/u-boot-2025.07/dts/upstream/incl=
ude   -I/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/build-st-1802=
970/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/sources/u-boot-2025.=
07/lib/efi_loader -Ilib/efi_loader -D__KERNEL__ -D__UBOOT__ -Wall -Wstrict-=
prototypes -Wno-format-security -fno-builtin -ffreestanding -std=3Dgnu11 -f=
short-wchar -fno-strict-aliasing -fno-PIE -Os -fno-stack-protector -fno-del=
ete-null-pointer-checks -Wno-pointer-sign -Wno-stringop-truncation -Wno-zer=
o-length-bounds -Wno-array-bounds -Wno-stringop-overflow -Wno-maybe-uniniti=
alized -fmacro-prefix-map=3D/srv/pokybuild/yocto-worker/oe-selftest-armhost=
/build/build-st-1802970/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.07/=
sources/u-boot-2025.07/=3D -gdwarf-4 -fstack-usage -Wno-format-nonliteral -=
Wno-address-of-packed-member -Wno-unused-but-set-variable -Werror=3Ddate-ti=
me -Wno-packed-not-aligned -D__ARM__ -Wa,-mimplicit-it=3Dalways -mthumb -mt=
humb-interwork -mabi=3Daapcs-linux -mword-relocations -mno-unaligned-access=
 -fno-common -msoft-float -mgeneral-regs-only -pipe -march=3Darmv7-a -D__LI=
NUX_ARM_ARCH__=3D7 -mtune=3Dgeneric-armv7-a  -I/srv/pokybuild/yocto-worker/=
oe-selftest-armhost/build/build-st-1802970/tmp/work/qemuarm-poky-linux-gnue=
abi/u-boot/2025.07/sources/u-boot-2025.07/arch/arm/mach-omap2/include -fpic=
 -fshort-wchar -Os -ffreestanding    -DKBUILD_BASENAME=3D'"testapp"'  -DKBU=
ILD_MODNAME=3D'"testapp"' -c -o lib/efi_loader/testapp.o /srv/pokybuild/yoc=
to-worker/oe-selftest-armhost/build/build-st-1802970/tmp/work/qemuarm-poky-=
linux-gnueabi/u-boot/2025.07/sources/u-boot-2025.07/lib/efi_loader/testapp.c
|    rm -f lib/efi_loader/built-in.o; arm-poky-linux-gnueabi-ar cDPrsT lib/=
efi_loader/built-in.o lib/efi_loader/efi_bootmgr.o lib/efi_loader/efi_bootb=
in.o lib/efi_loader/efi_boottime.o lib/efi_loader/efi_helper.o lib/efi_load=
er/efi_console.o lib/efi_loader/efi_device_path.o lib/efi_loader/efi_device=
_path_to_text.o lib/efi_loader/efi_device_path_utilities.o lib/efi_loader/e=
fi_dt_fixup.o lib/efi_loader/efi_fdt.o lib/efi_loader/efi_file.o lib/efi_lo=
ader/efi_hii.o lib/efi_loader/efi_hii_config.o lib/efi_loader/efi_image_loa=
der.o lib/efi_loader/efi_load_options.o lib/efi_loader/efi_memory.o lib/efi=
_loader/efi_root_node.o lib/efi_loader/efi_runtime.o lib/efi_loader/efi_set=
up.o lib/efi_loader/efi_string.o lib/efi_loader/efi_unicode_collation.o lib=
/efi_loader/efi_var_common.o lib/efi_loader/efi_var_mem.o lib/efi_loader/ef=
i_variable.o lib/efi_loader/efi_var_file.o lib/efi_loader/efi_watchdog.o li=
b/efi_loader/efi_disk.o lib/efi_loader/efi_net.o lib/efi_loader/efi_smbios.=
o lib/efi_loader/efi_load_initrd.o lib/efi_loader/efi_conformance.o
|   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -znor=
elro --no-warn-rwx-segments -L /srv/pokybuild/yocto-worker/oe-selftest-armh=
ost/build/build-st-1802970/tmp/work/qemuarm-poky-linux-gnueabi/u-boot/2025.=
07/sources/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared -Bsymboli=
c -s lib/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/efi_loader/e=
fi_reloc.o lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a -o lib/efi_=
loader/helloworld_efi.so
| arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such fi=
le or directory
| make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.so]=
 Error 1

In all cases, lib/efi_loader/helloworld_efi.so is getting linked but lib.a =
was
not built before it. u-boot config is "am57xx_evm_defconfig".

Some other dependencies are not correct then.

Cheers,

-Mikko

On Fri, Jul 11, 2025 at 09:51:49AM +0300, Mikko Rapeli wrote:
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
> ---
>  Makefile                     | 3 ++-
>  examples/standalone/Makefile | 2 +-
>  scripts/Makefile.lib         | 2 +-
>  scripts/Makefile.xpl         | 3 ++-
>  4 files changed, 6 insertions(+), 4 deletions(-)
>=20
> v2: introduced PLATFORM_LIBGCC_LIBA variable with just lib.a filename,
>     PLATFORM_LIBGCC can have other flags too
>=20
> v1: https://lists.denx.de/pipermail/u-boot/2025-July/593982.html
>=20
> diff --git a/Makefile b/Makefile
> index 93e9f4018423..649b16643eea 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1072,7 +1072,8 @@ u-boot-main :=3D $(libs-y)
> =20
>  # Add GCC lib
>  ifeq ($(CONFIG_USE_PRIVATE_LIBGCC),y)
> -PLATFORM_LIBGCC =3D arch/$(ARCH)/lib/lib.a
> +PLATFORM_LIBGCC_LIBA =3D arch/$(ARCH)/lib/lib.a
> +PLATFORM_LIBGCC =3D $(PLATFORM_LIBGCC_LIBA)
>  else
>  ifndef CONFIG_CC_IS_CLANG
>  PLATFORM_LIBGCC :=3D -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-=
file-name`) -lgcc
> diff --git a/examples/standalone/Makefile b/examples/standalone/Makefile
> index 9b57f1c0c66c..aa9e3121cf9a 100644
> --- a/examples/standalone/Makefile
> +++ b/examples/standalone/Makefile
> @@ -64,7 +64,7 @@ quiet_cmd_link_elf =3D LD      $@
>        cmd_link_elf =3D $(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_STANDALONE) -g =
 \
>  		     -o $@ -e $(SYM_PREFIX)$(@F) $< $(LIB) $(PLATFORM_LIBGCC)
> =20
> -$(ELF): $(obj)/%: $(obj)/%.o $(LIB) FORCE
> +$(ELF): $(obj)/%: $(obj)/%.o $(LIB) $(PLATFORM_LIBGCC_LIBA) FORCE
>  	$(call if_changed,link_elf)
> =20
>  $(obj)/%.srec: OBJCOPYFLAGS +=3D -O srec
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5db2fbc418a1..24bff63d68e7 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -533,7 +533,7 @@ $(obj)/efi_reloc.o: $(srctree)/arch/$(ARCH)/lib/$(EFI=
_RELOC:.o=3D.c) $(recordmcoun
>  	$(call cmd,force_checksrc)
>  	$(call if_changed_rule,cc_o_c)
> =20
> -$(obj)/%_efi.so: $(obj)/%.o $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/=
efi_freestanding.o
> +$(obj)/%_efi.so: $(PLATFORM_LIBGCC_LIBA) $(obj)/%.o $(obj)/efi_crt0.o $(=
obj)/efi_reloc.o $(obj)/efi_freestanding.o
>  	$(call cmd,efi_ld)
> =20
>  targets +=3D $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestandin=
g.o
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index 03a2f151d916..f0fc7ae923d8 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -139,7 +139,8 @@ libs-y :=3D $(patsubst %/, %/built-in.a, $(libs-y))
> =20
>  # Add GCC lib
>  ifeq ($(CONFIG_USE_PRIVATE_LIBGCC),y)
> -PLATFORM_LIBGCC =3D arch/$(ARCH)/lib/lib.a
> +PLATFORM_LIBGCC_LIBA =3D arch/$(ARCH)/lib/lib.a
> +PLATFORM_LIBGCC =3D $(PLATFORM_LIBGCC_LIBA)
>  PLATFORM_LIBS :=3D $(filter-out %/lib.a, $(filter-out -lgcc, $(PLATFORM_=
LIBS))) $(PLATFORM_LIBGCC)
>  endif
> =20
> --=20
> 2.43.0
>=20
