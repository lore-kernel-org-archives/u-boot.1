Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BA6C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 06:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421EE8349B;
	Fri, 11 Jul 2025 08:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="dYswU66q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A05278344C; Fri, 11 Jul 2025 08:52:37 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E343E8349B
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9583D20A48;
 Fri, 11 Jul 2025 08:52:34 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zhZcRFH6PmDr; Fri, 11 Jul 2025 08:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1752216753; bh=TMnCRPiBAUZiJ9XH9nhm1zUmoDaXaEOqX//H7WhuKpE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dYswU66qYrn+660jgUWviTj0i7z25Ys+0eYnL8b8Odzlp42XZrsMVOf4UEYDJzsxX
 ex5IimjFTKnMwh0xNr/6/kfWPJ8dE13ctRZvCJyzeoTcp21uMxEMkhRYbp+sFjtAHB
 zPR/S+Ub6R2QTe2Jro7Ee9B753k459npbnBJZLMb8u/78X95e2MJiBssHaudRKQXqn
 9wquo29XOxTp0afqWRDUBJql34CY47jnVFpPdhJuAkXnvR56TSxG7Dy15++29trJap
 GRDYoTZnO8v/T56GqqY25S1DzhulIs3c8764tVU8JFozYU70cu8eK18K1vj7fMSMrX
 jY2YsH5YYeITg==
Date: Fri, 11 Jul 2025 06:52:16 +0000
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, sughosh.ganu@linaro.org,
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
Message-ID: <aHC0oK7symjF2hEO@pie.lan>
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
 <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
 <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
 <8df9cfba-662d-416e-ac21-5ae6d4448708@amd.com>
 <20250710150154.GC6424@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250710150154.GC6424@bill-the-cat>
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

On Thu, Jul 10, 2025 at 09:01:54AM -0600, Tom Rini wrote:
> On Thu, Jul 10, 2025 at 04:58:00PM +0200, Michal Simek wrote:
> > Hi,
> > 
> > On 7/10/25 16:34, Fabio Estevam wrote:
> > > Hi Ilias,
> > > 
> > > On Thu, Jul 10, 2025 at 11:28 AM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > 
> > > > Thanks I'll try to reproduce it later today and let you know. Do you
> > > > know if we build this defonconfig in the CI?
> > > 
> > > Yes, mx6sabresd_defconfig is built in CI, but no CI error was seen.
> > 
> > I have seen this with other targets too. Toolchain from binman has no issue
> > with it that's why I expect it has something to with different toolchains
> > builds.
> 
> What host OS are you using, and are you using separate object
> directories? This feels like a "make" issue at first glance.

I could reproduce the failure as well on my Alpine Linux, using simply

	$ make ARCH=arm CROSS_COMPILE=arm-none-eabi- mx6sabresd_defconfig
	$ make ARCH=arm CROSS_COMPILE=arm-none-eabi-

No separate object directory is used.

	$ make --version
	GNU Make 4.4.1
	Built for x86_64-alpine-linux-musl
	Copyright (C) 1988-2023 Free Software Foundation, Inc.
	License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>
	This is free software: you are free to change and redistribute it.
	There is NO WARRANTY, to the extent permitted by law.

	# Installed by "apk add gcc-arm-none-eabi"
	$ arm-none-eabi-gcc -v
	Using built-in specs.
	COLLECT_GCC=arm-none-eabi-gcc
	COLLECT_LTO_WRAPPER=/usr/lib/gcc/arm-none-eabi/15.1.0/lto-wrapper
	Target: arm-none-eabi
	Configured with: /home/buildozer/aports/community/gcc-cross-embedded/src/gcc-15.1.0/configure --target=arm-none-eabi --prefix=/usr --with-sysroot=/usr/arm-none-eabi --with-native-system-header-dir=/include --with-headers=/usr/arm-none-eabi/include --with-python-dir=share/gcc-arm-none-eabi --libexecdir=/usr/lib --infodir=/deleteme/info --htmldir=/deleteme/html --pdfdir=/deleteme/pdf --mandir=/deleteme/man --enable-languages=c --enable-lto --enable-plugins --enable-gnu-indirect-function --disable-decimal-float --disable-libffi --disable-libgomp --disable-libmudflap --disable-libquadmath --disable-libssp --disable-libstdcxx-pch --disable-nls --disable-shared --disable-threads --disable-werror --with-gmp --with-gnu-as --with-gnu-ld --with-host-libstdcxx='-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm' --with-isl --with-libelf --with-mpc --with-mpfr --with-newlib --with-system-zlib --with-pkgversion='Alpine Linux' --with-multilib-list=rmprofile
	Thread model: single
	Supported LTO compression algorithms: zlib
	gcc version 15.1.0 (Alpine Linux)

	# The distribution is on the latest edge branch
	$ cat /etc/os-release
	NAME="Alpine Linux"
	ID=alpine
	VERSION_ID=3.23.0_alpha20250612
	PRETTY_NAME="Alpine Linux edge"
	HOME_URL="https://alpinelinux.org/"
	BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
	$ cat /etc/apk/repositories
	#/media/sdb/apks
	http://mirrors.ustc.edu.cn/alpine/edge/main
	http://mirrors.ustc.edu.cn/alpine/edge/community
	http://mirrors.ustc.edu.cn/alpine/edge/testing

This seems to have something to do with the RISC-V failures I tried to
fix days earlier[1], cherry-picking the patch also fixes this failure.

> -- 
> Tom

Regards,
Yao Zi

[1]: https://lore.kernel.org/u-boot/20250709161418.21287-2-ziyao@disroot.org/
