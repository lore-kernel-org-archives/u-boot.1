Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC5FC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 07:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D812683297;
	Fri, 11 Jul 2025 09:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ahBWFltR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C92F83429; Fri, 11 Jul 2025 09:10:19 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7184683278
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 09:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-710f39f5cb9so16823387b3.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752217815; x=1752822615; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSAcDTkDvPHst+itaDcS9UNzq1dnQKXFO8iLRXjITmk=;
 b=ahBWFltR3a/GZ0Vf+jSgFQ01t8alNsmRs8OC4Q0RvZjkQ5K1XISZiqa5UFlaYZciOW
 wx6i/u0irw8uYxB9HoaFPElhFzS64jneO2zMWavmyxxdezaPrkXPrBCS+TP8hgHjyoEy
 PDpxkdC7pR/lqS0GTpYbNZkrs0WWX7hv2b7cwsY6tX4BuvIRhZSTRLMBHF0yCrc5U2Wi
 WM2ANji9rm3akgbmAX2LFfwLQqP+/rRsaRHAXFWT60fo6oHM0bspKot04UkXdB7AufmY
 T8mU4Z5jPQAVoPBAVV/vTDnDUheEdWGYm2dJNTbci3urO8nuf8H0ysNGliAJ+Is7QJfb
 1WOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752217815; x=1752822615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSAcDTkDvPHst+itaDcS9UNzq1dnQKXFO8iLRXjITmk=;
 b=G9f2C3wL5CcNWND2RYPDpwicNjrxRx8ZChNhbhwv0j4i0i68ux44dcUuc99zyLucAl
 j8UwckIMzyP/CCZ2gwqgmIzzQeOQ6F2vYBfdlG39iGBazR4mcvpQge5fFJcudwg/+ljc
 IobbObU/j4BQPJR2HyK1kGdjU1WZzLiCVPtAROoPTnD+9Z3CZbH/XkynBVnvsSiuXSiV
 Cp6upD2ZTz4IaGrMbx4zsTZpn+22A8rGLpG38zNd5n2abMPQT0VqXGdP9LtbwIaN33xV
 LPvtU7ybsnj0LZvWUDQ1hWkPgN42dRRb0f4o6/FzQShMa980Ed4XD0oGd4agV70bhxyT
 cM0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk8YmXkRar/nC1nfP7v5XbF7BMtmjcFBEeZ2/L+XOX7pTE6O8CXCCOXXxCyFw/xhmExZNMpqY=@lists.denx.de
X-Gm-Message-State: AOJu0YwaFhNg0cBwCfcwWt4vzDIhykKY0JmQAcLqvSaMEZ86QJC06IoM
 FAObTzABH/kLT+IqpjV9t8GqQ7GBLVYYTdrbJGhpVwF7gqXCDY8kE/6NzM3HjcJc/ZdLriYyGgV
 czLu7gjxjnWM+2EsVxGAA7PIlrJhxtXWzqU2Ye6d1jQ==
X-Gm-Gg: ASbGncv9fmUFFV3LC9Tsj5FpCM3O+NmxzaQDKuRQY4fn1nMbfvUioxpmjsyuPEUe9Kd
 P4XKS5hrRbaH8+4nkeKcpBMK8JU3d26Ir85VZRTKBHS3ikuIGI4hjmNxx6dy1WwaNp6YZXq1w1G
 gcQau0/occhiqrtY6eJurC8+Ld8ppKEpPxK1jV7kgecNcFtOeWoS3xXVZZRM4mtgky18eEmGqqc
 OMUTuk=
X-Google-Smtp-Source: AGHT+IG3EfdWJRfH06eDxGEGI9ghDWpCdDGgigFfmOhDUAeuqeBgrt0mRZVfk6ChJ8OhdpOFuVXG6igFKuCoy95HTaE=
X-Received: by 2002:a05:690c:6e8b:b0:70e:779:7e84 with SMTP id
 00721157ae682-717daeb2ec2mr17568957b3.27.1752217815029; Fri, 11 Jul 2025
 00:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
 <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
 <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
 <8df9cfba-662d-416e-ac21-5ae6d4448708@amd.com>
 <20250710150154.GC6424@bill-the-cat> <aHC0oK7symjF2hEO@pie.lan>
In-Reply-To: <aHC0oK7symjF2hEO@pie.lan>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Jul 2025 10:09:38 +0300
X-Gm-Features: Ac12FXzKrdxldsLlphBYVlb8K19KNydQMIGku9Q-31u0-itnRTLBSjL0_ANMRws
Message-ID: <CAC_iWjLMU73F0wQB9Q1YxzHO_VcqqPmy3WOUOE==4k4CeU2BaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
To: Yao Zi <ziyao@disroot.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Fabio Estevam <festevam@gmail.com>, sughosh.ganu@linaro.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, 
 Olaf Mandel <o.mandel@menlosystems.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>, 
 Prasad Kummari <prasad.kummari@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Thanks Yao,


On Fri, 11 Jul 2025 at 09:52, Yao Zi <ziyao@disroot.org> wrote:
>
> On Thu, Jul 10, 2025 at 09:01:54AM -0600, Tom Rini wrote:
> > On Thu, Jul 10, 2025 at 04:58:00PM +0200, Michal Simek wrote:
> > > Hi,
> > >
> > > On 7/10/25 16:34, Fabio Estevam wrote:
> > > > Hi Ilias,
> > > >
> > > > On Thu, Jul 10, 2025 at 11:28=E2=80=AFAM Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > > Thanks I'll try to reproduce it later today and let you know. Do =
you
> > > > > know if we build this defonconfig in the CI?
> > > >
> > > > Yes, mx6sabresd_defconfig is built in CI, but no CI error was seen.
> > >
> > > I have seen this with other targets too. Toolchain from binman has no=
 issue
> > > with it that's why I expect it has something to with different toolch=
ains
> > > builds.
> >
> > What host OS are you using, and are you using separate object
> > directories? This feels like a "make" issue at first glance.
>
> I could reproduce the failure as well on my Alpine Linux, using simply
>
>         $ make ARCH=3Darm CROSS_COMPILE=3Darm-none-eabi- mx6sabresd_defco=
nfig
>         $ make ARCH=3Darm CROSS_COMPILE=3Darm-none-eabi-
>
> No separate object directory is used.

This helps, although I still cant reproduce locally. But my compiler
version differs

$ make --version
GNU Make 4.4.1
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2023 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.ht=
ml>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

$ arm-none-eabi-gcc -v
Using built-in specs.
COLLECT_GCC=3Darm-none-eabi-gcc
COLLECT_LTO_WRAPPER=3D/home/apalos/work/toolchains/arm-gnu-toolchain-13.2.R=
el1-x86_64-arm-none-eabi/bin/../libexec/gcc/arm-none-eabi/13.2.1/lto-wrappe=
r
Target: arm-none-eabi
Configured with:
/data/jenkins/workspace/GNU-toolchain/arm-13/src/gcc/configure
--target=3Darm-none-eabi
--prefix=3D/data/jenkins/workspace/GNU-toolchain/arm-13/build-arm-none-eabi=
/install
--with-gmp=3D/data/jenkins/workspace/GNU-toolchain/arm-13/build-arm-none-ea=
bi/host-tools
--with-mpfr=3D/data/jenkins/workspace/GNU-toolchain/arm-13/build-arm-none-e=
abi/host-tools
--with-mpc=3D/data/jenkins/workspace/GNU-toolchain/arm-13/build-arm-none-ea=
bi/host-tools
--with-isl=3D/data/jenkins/workspace/GNU-toolchain/arm-13/build-arm-none-ea=
bi/host-tools
--disable-shared --disable-nls --disable-threads --disable-tls
--enable-checking=3Drelease --enable-languages=3Dc,c++,fortran
--with-newlib --with-gnu-as --with-headers=3Dyes --with-gnu-ld
--with-native-system-header-dir=3D/include
--with-sysroot=3D/data/jenkins/workspace/GNU-toolchain/arm-13/build-arm-non=
e-eabi/install/arm-none-eabi
--with-multilib-list=3Daprofile,rmprofile --with-pkgversion=3D'Arm GNU
Toolchain 13.2.rel1 (Build arm-13.7)'
--with-bugurl=3Dhttps://bugs.linaro.org/
Thread model: single
Supported LTO compression algorithms: zlib
gcc version 13.2.1 20231009 (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7))

$ cat /etc/os-release
PRETTY_NAME=3D"Debian GNU/Linux 13 (trixie)"
NAME=3D"Debian GNU/Linux"
VERSION_ID=3D"13"
VERSION=3D"13 (trixie)"
VERSION_CODENAME=3Dtrixie
DEBIAN_VERSION_FULL=3D13.0
ID=3Ddebian
HOME_URL=3D"https://www.debian.org/"
SUPPORT_URL=3D"https://www.debian.org/support"
BUG_REPORT_URL=3D"https://bugs.debian.org/"


>
>         $ make --version
>         GNU Make 4.4.1
>         Built for x86_64-alpine-linux-musl
>         Copyright (C) 1988-2023 Free Software Foundation, Inc.
>         License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licen=
ses/gpl.html>
>         This is free software: you are free to change and redistribute it=
.
>         There is NO WARRANTY, to the extent permitted by law.
>
>         # Installed by "apk add gcc-arm-none-eabi"
>         $ arm-none-eabi-gcc -v
>         Using built-in specs.
>         COLLECT_GCC=3Darm-none-eabi-gcc
>         COLLECT_LTO_WRAPPER=3D/usr/lib/gcc/arm-none-eabi/15.1.0/lto-wrapp=
er
>         Target: arm-none-eabi
>         Configured with: /home/buildozer/aports/community/gcc-cross-embed=
ded/src/gcc-15.1.0/configure --target=3Darm-none-eabi --prefix=3D/usr --wit=
h-sysroot=3D/usr/arm-none-eabi --with-native-system-header-dir=3D/include -=
-with-headers=3D/usr/arm-none-eabi/include --with-python-dir=3Dshare/gcc-ar=
m-none-eabi --libexecdir=3D/usr/lib --infodir=3D/deleteme/info --htmldir=3D=
/deleteme/html --pdfdir=3D/deleteme/pdf --mandir=3D/deleteme/man --enable-l=
anguages=3Dc --enable-lto --enable-plugins --enable-gnu-indirect-function -=
-disable-decimal-float --disable-libffi --disable-libgomp --disable-libmudf=
lap --disable-libquadmath --disable-libssp --disable-libstdcxx-pch --disabl=
e-nls --disable-shared --disable-threads --disable-werror --with-gmp --with=
-gnu-as --with-gnu-ld --with-host-libstdcxx=3D'-static-libgcc -Wl,-Bstatic,=
-lstdc++,-Bdynamic -lm' --with-isl --with-libelf --with-mpc --with-mpfr --w=
ith-newlib --with-system-zlib --with-pkgversion=3D'Alpine Linux' --with-mul=
tilib-list=3Drmprofile
>         Thread model: single
>         Supported LTO compression algorithms: zlib
>         gcc version 15.1.0 (Alpine Linux)
>
>         # The distribution is on the latest edge branch
>         $ cat /etc/os-release
>         NAME=3D"Alpine Linux"
>         ID=3Dalpine
>         VERSION_ID=3D3.23.0_alpha20250612
>         PRETTY_NAME=3D"Alpine Linux edge"
>         HOME_URL=3D"https://alpinelinux.org/"
>         BUG_REPORT_URL=3D"https://gitlab.alpinelinux.org/alpine/aports/-/=
issues"
>         $ cat /etc/apk/repositories
>         #/media/sdb/apks
>         http://mirrors.ustc.edu.cn/alpine/edge/main
>         http://mirrors.ustc.edu.cn/alpine/edge/community
>         http://mirrors.ustc.edu.cn/alpine/edge/testing
>
> This seems to have something to do with the RISC-V failures I tried to
> fix days earlier[1], cherry-picking the patch also fixes this failure.

That's interesting. Can the rest of the people that reproduce it apply
it and try ?

Thanks
/Ilias
>
> > --
> > Tom
>
> Regards,
> Yao Zi
>
> [1]: https://lore.kernel.org/u-boot/20250709161418.21287-2-ziyao@disroot.=
org/
