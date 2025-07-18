Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BDDC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 08:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2A29835D8;
	Fri, 18 Jul 2025 10:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C278357F; Fri, 18 Jul 2025 10:30:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 31E99835BF
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 10:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sudeep.holla@foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F5B2176C;
 Fri, 18 Jul 2025 01:30:13 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FFD33F694;
 Fri, 18 Jul 2025 01:30:16 -0700 (PDT)
Date: Fri, 18 Jul 2025 09:30:13 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sughosh.ganu@linaro.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
Message-ID: <20250718-knowing-ludicrous-myna-ff5d69@sudeepholla>
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAPKp9uZPPOdQi_vFKEjTA4NE3oy0WPth-ugc21wKR7GPu4OD1Q@mail.gmail.com>
 <20250717174148.GO193579@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717174148.GO193579@bill-the-cat>
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

On Thu, Jul 17, 2025 at 11:41:48AM -0600, Tom Rini wrote:
> On Thu, Jul 17, 2025 at 06:03:09PM +0100, Sudeep Holla wrote:
> 
> > Hi,
> > 
> > I see build break with clang after the commit 5f520875bdf0 ("kbuild:
> > Bump the build system to 5.1"):
> > 
> > Build command:
> > $make -j`nproc` ARCH=arm64 O=$BUILD_DIR
> > CROSS_COMPILE=aarch64-none-linux-gnu- HOSTCC=clang
> > vexpress_aemv8a_semi_defconfig
> > $make -j`nproc` ARCH=arm   O=$BUILD_DIR
> > CROSS_COMPILE=aarch64-none-linux-gnu- HOSTCC=clang CC=clang all
> 
> Does it still fail if you don't pass ARCH=? That's not valid in U-Boot
> and can lead to breakage.
> 

Yes it still breaks. I wasn't aware that ARCH= was not need in the build
step, thanks for that info. I always passed it AFAIR.

-- 
Regards,
Sudeep
