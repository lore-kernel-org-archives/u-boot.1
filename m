Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CC3C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 07:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A88B83759;
	Fri, 11 Jul 2025 09:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="zj6Whdml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E386E83759; Fri, 11 Jul 2025 09:02:23 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E02783753
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 09:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 887B11F994;
 Fri, 11 Jul 2025 09:02:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1752217339;
 bh=wBKTJZqNt0Lkg4Pya+XC55ptrwTf/NO0E37vdZqW2t4=; h=From:To:Subject;
 b=zj6Whdmlk6dSYsI4V/8YJTEFKW6+/HS2wHoF3eFCWumUfAgsoZURtiGxsGbzPKM3C
 lEMOvi417XWh+X0HOERdHFlyt5TO3I7YLD6vTx02p6Cg2j4ioCwUHEEKXnD6wRGCg5
 3VED3Ke+fJYO/iU7na+t1eVQqm4rmkBb+VzU9BWYP+aXvCg0RflDdTqpPGwriSMRdW
 vscdq3rKEmZ2OqZl+hUXzxyUwmgomvkZGN8TQ8mt1E3fawZLwyM3j3XY63n8ijgN+J
 MoJE75ryi/mxh5oHQ+869c2OMLdSRzDpaYSAqvGPyrXcfYlkgETOdOzybDKPt3SHTI
 qHlANCRTxI+0Q==
Date: Fri, 11 Jul 2025 09:02:14 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>,
 Michal Simek <michal.simek@amd.com>, sughosh.ganu@linaro.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
Message-ID: <20250711070214.GA5191@francesco-nb>
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
 <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
 <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
 <8df9cfba-662d-416e-ac21-5ae6d4448708@amd.com>
 <20250710150154.GC6424@bill-the-cat>
 <CAC_iWj+B2p-xfcdJS14LZAAjxGsxXeuBbm0CxJf_DL4E-0ytFA@mail.gmail.com>
 <20250711052705.GA5353@francesco-nb>
 <CAC_iWjKXpE=M9VjEjr2ZBdTjzEPudXNFa1ARENVc2VyDJ0XR3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAC_iWjKXpE=M9VjEjr2ZBdTjzEPudXNFa1ARENVc2VyDJ0XR3g@mail.gmail.com>
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

On Fri, Jul 11, 2025 at 09:17:23AM +0300, Ilias Apalodimas wrote:
> On Fri, 11 Jul 2025 at 08:27, Francesco Dolcini <francesco@dolcini.it> wr=
ote:
> > On Fri, Jul 11, 2025 at 08:15:25AM +0300, Ilias Apalodimas wrote:
> > > I can't reproduce this on my Ubuntu and Debian boxes.
> > > Can you paste your Ubuntu, make & gcc versions?
> >
> > Our CI is also failing builds.
> >
> > We build within OE master, no other changes on our side.
> >
> > TI platforms are affected in a similar way
> >
> > | make[1]: *** arch/arm/mach-k3/: Is a directory.  Stop.
>=20
> Can you extract the make commands used to build and paste them?


[2025-07-10T18:21:04.585Z] | DEBUG: Executing shell function do_compile
[2025-07-10T18:21:04.585Z] | NOTE: make -j 32 CROSS_COMPILE=3Darm-tdx-eabi-=
 V=3D1 CC=3Darm-tdx-eabi-gcc  --sysroot=3D/workdir/oe/tmp-k3r5/work/verdin_=
am62_k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroot  -ffile-prefix-ma=
p=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/main=
line/sources/u-boot-toradex-mainline=3D/usr/src/debug/u-boot-toradex/mainli=
ne  -ffile-prefix-map=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi=
/u-boot-toradex/mainline/build=3D/usr/src/debug/u-boot-toradex/mainline  -f=
file-prefix-map=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boo=
t-toradex/mainline/recipe-sysroot=3D  -ffile-prefix-map=3D/workdir/oe/tmp-k=
3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroot-n=
ative=3D  HOSTCC=3Dgcc  -isystem/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-=
tdx-eabi/u-boot-toradex/mainline/recipe-sysroot-native/usr/include -O2 -pip=
e -L/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/main=
line/recipe-sysroot-native/usr/lib                         -L/workdir/oe/tm=
p-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroo=
t-native/lib                         -Wl,--enable-new-dtags                =
         -Wl,-rpath-link,/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eab=
i/u-boot-toradex/mainline/recipe-sysroot-native/usr/lib                    =
     -Wl,-rpath-link,/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-=
boot-toradex/mainline/recipe-sysroot-native/lib                         -Wl=
,-rpath,/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/=
mainline/recipe-sysroot-native/usr/lib                         -Wl,-rpath,/=
workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/=
recipe-sysroot-native/lib                         -Wl,-O1 -Wl,--allow-shlib=
-undefined -Wl,--dynamic-linker=3D/workdir/oe/tmp-k3r5/sysroots-uninative/x=
86_64-linux/lib/ld-linux-x86-64.so.2 -pthread STAGING_INCDIR=3D/workdir/oe/=
tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysr=
oot-native/usr/include STAGING_LIBDIR=3D/workdir/oe/tmp-k3r5/work/verdin_am=
62_k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroot-native/usr/lib BINM=
AN_INDIRS=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-tora=
dex/mainline/recipe-sysroot/usr/lib/firmware -C /workdir/oe/tmp-k3r5/work/v=
erdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mai=
nline O=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-torade=
x/mainline/build/verdin-am62_r5_defconfig all
[2025-07-10T18:21:04.585Z] | make: Entering directory '/workdir/oe/tmp-k3r5=
/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-tora=
dex-mainline'
[2025-07-10T18:21:04.585Z] | make \
[2025-07-10T18:21:04.585Z] | -C /workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-=
tdx-eabi/u-boot-toradex/mainline/build/verdin-am62_r5_defconfig KBUILD_SRC=
=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainl=
ine/sources/u-boot-toradex-mainline \
[2025-07-10T18:21:04.585Z] | -f /workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-=
tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/Makefile a=
ll
[2025-07-10T18:21:04.585Z] | make[1]: Entering directory '/workdir/oe/tmp-k=
3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/build/verdin-am6=
2_r5_defconfig'
[2025-07-10T18:21:04.585Z] | make -f /workdir/oe/tmp-k3r5/work/verdin_am62_=
k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/Makef=
ile syncconfig
[2025-07-10T18:21:04.585Z] | make -f /workdir/oe/tmp-k3r5/work/verdin_am62_=
k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/scrip=
ts/Makefile.build obj=3Dscripts/basic
[2025-07-10T18:21:04.585Z] | ln -fsn /workdir/oe/tmp-k3r5/work/verdin_am62_=
k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline source
[2025-07-10T18:21:04.585Z] | rm -f .tmp_quiet_recordmcount
[2025-07-10T18:21:04.585Z] | /bin/bash /workdir/oe/tmp-k3r5/work/verdin_am6=
2_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/scr=
ipts/mkmakefile /workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-=
toradex/mainline/sources/u-boot-toradex-mainline
[2025-07-10T18:21:04.585Z] |   GEN     Makefile
[2025-07-10T18:21:04.585Z] | test -e .gitignore || \
[2025-07-10T18:21:04.585Z] | { echo "# this is build directory, ignore it";=
 echo "*"; } > .gitignore
[2025-07-10T18:21:04.585Z] | make -f /workdir/oe/tmp-k3r5/work/verdin_am62_=
k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/scrip=
ts/Makefile.build obj=3Dscripts/kconfig syncconfig
[2025-07-10T18:21:04.585Z] | scripts/kconfig/conf  --syncconfig Kconfig
[2025-07-10T18:21:04.585Z] | make -f /workdir/oe/tmp-k3r5/work/verdin_am62_=
k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/scrip=
ts/Makefile.autoconf || \
[2025-07-10T18:21:04.585Z] | 	{ rm -f include/config/auto.conf; false; }
[2025-07-10T18:21:04.585Z] | mkdir -p include/asm
[2025-07-10T18:21:04.585Z] | if [ -d /workdir/oe/tmp-k3r5/work/verdin_am62_=
k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/arch/=
arm/mach-k3/include/mach ]; then	\
[2025-07-10T18:21:04.585Z] | 	dest=3Darch/arm/mach-k3/include/mach;			\
[2025-07-10T18:21:04.585Z] | else									\
[2025-07-10T18:21:04.585Z] | 	dest=3Darch/arm/include/asm/arch-k3;	\
[2025-07-10T18:21:04.585Z] | fi;									\
[2025-07-10T18:21:04.585Z] | ln -fsn /workdir/oe/tmp-k3r5/work/verdin_am62_=
k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/$dest=
 include/asm/arch
[2025-07-10T18:21:04.585Z] | set -e; mkdir -p include/; 	(echo "/* Automati=
cally generated - do not edit */"; echo \#define CFG_BOARDDIR board/toradex=
/verdin-am62; echo \#include \<configs/"verdin-am62".h\> ; echo \#include \=
<asm/config.h\>; echo \#include \<linux/kconfig.h\>; echo \#include \<confi=
g_fallbacks.h\>;) < /workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-b=
oot-toradex/mainline/sources/u-boot-toradex-mainline/scripts/Makefile.autoc=
onf > include/config.h.tmp; if [ -r include/config.h ] && cmp -s include/co=
nfig.h include/config.h.tmp; then rm -f include/config.h.tmp; else : '  UPD=
     include/config.h'; mv -f include/config.h.tmp include/config.h; fi
[2025-07-10T18:21:04.585Z] |   arm-tdx-eabi-gcc  --sysroot=3D/workdir/oe/tm=
p-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroo=
t  -ffile-prefix-map=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/=
u-boot-toradex/mainline/sources/u-boot-toradex-mainline=3D/usr/src/debug/u-=
boot-toradex/mainline  -ffile-prefix-map=3D/workdir/oe/tmp-k3r5/work/verdin=
_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/build=3D/usr/src/debug/u-boot-t=
oradex/mainline  -ffile-prefix-map=3D/workdir/oe/tmp-k3r5/work/verdin_am62_=
k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroot=3D  -ffile-prefix-map=
=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainl=
ine/recipe-sysroot-native=3D  -E -Wall -Werror=3Dstrict-prototypes -Wno-tri=
graphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dim=
plicit-function-declaration -Werror=3Dimplicit-int -Wno-format-security -st=
d=3Dgnu11  -ffreestanding -fno-builtin -fno-delete-null-pointer-checks -Wno=
-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool=
-context -Wno-address-of-packed-member -O2 -fno-stack-protector -fno-delete=
-null-pointer-checks -Wno-zero-length-bounds -Wno-array-bounds -Wno-stringo=
p-overflow -Wno-maybe-uninitialized -fmacro-prefix-map=3D/workdir/oe/tmp-k3=
r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-to=
radex-mainline/=3D -gdwarf-4 -fstack-usage -Wno-format-nonliteral -Wno-addr=
ess-of-packed-member -Wno-unused-but-set-variable -Wno-unused-but-set-varia=
ble -Werror=3Ddate-time -Wno-packed-not-aligned -Wno-pointer-sign -Wno-stri=
ngop-truncation -fno-strict-overflow -D__KERNEL__ -D__UBOOT__ -D__ARM__ -Wa=
,-mimplicit-it=3Dalways  -mthumb -mthumb-interwork  -mabi=3Daapcs-linux  -m=
word-relocations  -fno-pic  -mno-unaligned-access -ffunction-sections -fdat=
a-sections -fno-common -ffixed-r9  -msoft-float -mgeneral-regs-only    -pip=
e -Iinclude  -I/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-t=
oradex/mainline/sources/u-boot-toradex-mainline/include -I/workdir/oe/tmp-k=
3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-t=
oradex-mainline/arch/arm/include -include /workdir/oe/tmp-k3r5/work/verdin_=
am62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/=
include/linux/kconfig.h -nostdinc -isystem /workdir/oe/tmp-k3r5/work/verdin=
_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroot-native/usr/bin/a=
rm-tdx-eabi/../../lib/arm-tdx-eabi/gcc/arm-tdx-eabi/15.1.0/include  -DDO_DE=
PS_ONLY -dM include/config.h > u-boot.cfg.tmp && { grep 'define CONFIG_' u-=
boot.cfg.tmp | sed '/define CONFIG_IS_ENABLED(/d;/define CONFIG_IF_ENABLED_=
INT(/d;/define CONFIG_VAL(/d;' > u-boot.cfg; rm u-boot.cfg.tmp; } || { rm u=
-boot.cfg.tmp; false; }
[2025-07-10T18:21:04.586Z] | mkdir -p spl/
[2025-07-10T18:21:04.586Z] |   arm-tdx-eabi-gcc  --sysroot=3D/workdir/oe/tm=
p-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroo=
t  -ffile-prefix-map=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/=
u-boot-toradex/mainline/sources/u-boot-toradex-mainline=3D/usr/src/debug/u-=
boot-toradex/mainline  -ffile-prefix-map=3D/workdir/oe/tmp-k3r5/work/verdin=
_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/build=3D/usr/src/debug/u-boot-t=
oradex/mainline  -ffile-prefix-map=3D/workdir/oe/tmp-k3r5/work/verdin_am62_=
k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroot=3D  -ffile-prefix-map=
=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainl=
ine/recipe-sysroot-native=3D  -x c -DDO_DEPS_ONLY -M -MP -Wall -Werror=3Dst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wch=
ar -fno-PIE -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int =
-Wno-format-security -std=3Dgnu11  -ffreestanding -fno-builtin -fno-delete-=
null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-o=
verflow -Wno-int-in-bool-context -Wno-address-of-packed-member -O2 -fno-sta=
ck-protector -fno-delete-null-pointer-checks -Wno-zero-length-bounds -Wno-a=
rray-bounds -Wno-stringop-overflow -Wno-maybe-uninitialized -fmacro-prefix-=
map=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/ma=
inline/sources/u-boot-toradex-mainline/=3D -gdwarf-4 -fstack-usage -Wno-for=
mat-nonliteral -Wno-address-of-packed-member -Wno-unused-but-set-variable -=
Wno-unused-but-set-variable -Werror=3Ddate-time -Wno-packed-not-aligned -Wn=
o-pointer-sign -Wno-stringop-truncation -fno-strict-overflow -D__KERNEL__ -=
D__UBOOT__ -D__ARM__ -Wa,-mimplicit-it=3Dalways  -mthumb -mthumb-interwork =
 -mabi=3Daapcs-linux  -mword-relocations  -fno-pic  -mno-unaligned-access -=
ffunction-sections -fdata-sections -fno-common -ffixed-r9  -msoft-float -mg=
eneral-regs-only    -pipe -Iinclude  -I/workdir/oe/tmp-k3r5/work/verdin_am6=
2_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/inc=
lude -I/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/m=
ainline/sources/u-boot-toradex-mainline/arch/arm/include -include /workdir/=
oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/=
u-boot-toradex-mainline/include/linux/kconfig.h -nostdinc -isystem /workdir=
/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-=
sysroot-native/usr/bin/arm-tdx-eabi/../../lib/arm-tdx-eabi/gcc/arm-tdx-eabi=
/15.1.0/include -MQ include/config/auto.conf include/config.h > include/aut=
oconf.mk.dep || { rm include/autoconf.mk.dep; false; }
[2025-07-10T18:21:04.586Z] |   arm-tdx-eabi-gcc  --sysroot=3D/workdir/oe/tm=
p-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroo=
t  -ffile-prefix-map=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/=
u-boot-toradex/mainline/sources/u-boot-toradex-mainline=3D/usr/src/debug/u-=
boot-toradex/mainline  -ffile-prefix-map=3D/workdir/oe/tmp-k3r5/work/verdin=
_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/build=3D/usr/src/debug/u-boot-t=
oradex/mainline  -ffile-prefix-map=3D/workdir/oe/tmp-k3r5/work/verdin_am62_=
k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroot=3D  -ffile-prefix-map=
=3D/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainl=
ine/recipe-sysroot-native=3D  -E -Wall -Werror=3Dstrict-prototypes -Wno-tri=
graphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dim=
plicit-function-declaration -Werror=3Dimplicit-int -Wno-format-security -st=
d=3Dgnu11  -ffreestanding -fno-builtin -fno-delete-null-pointer-checks -Wno=
-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool=
-context -Wno-address-of-packed-member -O2 -fno-stack-protector -fno-delete=
-null-pointer-checks -Wno-zero-length-bounds -Wno-array-bounds -Wno-stringo=
p-overflow -Wno-maybe-uninitialized -fmacro-prefix-map=3D/workdir/oe/tmp-k3=
r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-to=
radex-mainline/=3D -gdwarf-4 -fstack-usage -Wno-format-nonliteral -Wno-addr=
ess-of-packed-member -Wno-unused-but-set-variable -Wno-unused-but-set-varia=
ble -Werror=3Ddate-time -Wno-packed-not-aligned -Wno-pointer-sign -Wno-stri=
ngop-truncation -fno-strict-overflow -D__KERNEL__ -D__UBOOT__ -D__ARM__ -Wa=
,-mimplicit-it=3Dalways  -mthumb -mthumb-interwork  -mabi=3Daapcs-linux  -m=
word-relocations  -fno-pic  -mno-unaligned-access -ffunction-sections -fdat=
a-sections -fno-common -ffixed-r9  -msoft-float -mgeneral-regs-only    -pip=
e -Iinclude  -I/workdir/oe/tmp-k3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-t=
oradex/mainline/sources/u-boot-toradex-mainline/include -I/workdir/oe/tmp-k=
3r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-t=
oradex-mainline/arch/arm/include -include /workdir/oe/tmp-k3r5/work/verdin_=
am62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/=
include/linux/kconfig.h -nostdinc -isystem /workdir/oe/tmp-k3r5/work/verdin=
_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/recipe-sysroot-native/usr/bin/a=
rm-tdx-eabi/../../lib/arm-tdx-eabi/gcc/arm-tdx-eabi/15.1.0/include -DCONFIG=
_XPL_BUILD -DCONFIG_SPL_BUILD -DDO_DEPS_ONLY -dM include/config.h > spl/u-b=
oot.cfg.tmp && { grep 'define CONFIG_' spl/u-boot.cfg.tmp | sed '/define CO=
NFIG_IS_ENABLED(/d;/define CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;'=
 > spl/u-boot.cfg; rm spl/u-boot.cfg.tmp; } || { rm spl/u-boot.cfg.tmp; fal=
se; }
[2025-07-10T18:21:04.586Z] |   sed -n -f /workdir/oe/tmp-k3r5/work/verdin_a=
m62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/t=
ools/scripts/define2mk.sed u-boot.cfg | while read line; do if [ -n "" ] ||=
 ! grep -q "${line%=3D*}=3D" include/config/auto.conf; then echo "$line"; f=
i; done > include/autoconf.mk
[2025-07-10T18:21:04.586Z] | mkdir -p spl/include/
[2025-07-10T18:21:04.586Z] |   sed -n -f /workdir/oe/tmp-k3r5/work/verdin_a=
m62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-toradex-mainline/t=
ools/scripts/define2mk.sed spl/u-boot.cfg | while read line; do if [ -n "" =
] || ! grep -q "${line%=3D*}=3D" include/config/auto.conf; then echo "$line=
"; fi; done > spl/include/autoconf.mk
[2025-07-10T18:21:04.586Z] | touch include/config/auto.conf
[2025-07-10T18:21:04.586Z] | make[1]: *** arch/arm/mach-k3/: Is a directory=
=2E  Stop.
[2025-07-10T18:21:04.586Z] | make[1]: Leaving directory '/workdir/oe/tmp-k3=
r5/work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/build/verdin-am62=
_r5_defconfig'
[2025-07-10T18:21:04.586Z] | make: *** [Makefile:198: sub-make] Error 2
[2025-07-10T18:21:04.587Z] | make: Leaving directory '/workdir/oe/tmp-k3r5/=
work/verdin_am62_k3r5-tdx-eabi/u-boot-toradex/mainline/sources/u-boot-torad=
ex-mainline'
[2025-07-10T18:21:04.587Z] | ERROR: oe_runmake failed
[2025-07-10T18:21:04.587Z] | WARNING: exit code 1 from a shell command.
[2025-07-10T18:21:04.587Z] NOTE: recipe u-boot-toradex-1_mainline-r0: task =
do_compile: Failed
[2025-07-10T18:21:04.587Z] ERROR: Task (mc:k3r5:/workdir/oe/build/../layers=
/meta-toradex-bsp-common/recipes-bsp/u-boot/u-boot-toradex_mainline.bb:do_c=
ompile) failed with exit code '1'


This is the complete log from OE, failure should be at the end.

https://gist.github.com/dolcini/3bd7417724bc9f616d97a5d0bef68c8b


Francesco

