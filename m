Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD3BC8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 05:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B06283423;
	Fri, 11 Jul 2025 07:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="OrJvxDcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5648362C; Fri, 11 Jul 2025 07:27:13 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8162A83285
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 07:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 32A6C1F91C;
 Fri, 11 Jul 2025 07:27:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1752211630;
 bh=xYR3xWP+IrEsHwG1BGoB4x8MPpAq8BwdqAD/vZk1wjY=; h=From:To:Subject;
 b=OrJvxDcQDJl+Ke3kf3oPa9uUDjc7J/34VOTVY0KyILGLNFjqDsmQulOa/dc/CjnzN
 VmSX/VdgxKFZK59ZFvYmAuoKMHSeeuBKZIykz+Llr1hgFMYuRMrd7alvZ9bAgHUpUx
 jkiZXGT1OJ7y8C1QhIVq3Q/DV0Gitd3Kd6ahamc5x3KQrQldfihcyNDpRDcBVEKIdn
 +WSEUA4x1eeZYTLC7iA1RCvcQDdxr3HbCokX8g7aWEuB4fJL9QQm3QTnTlFmdW1FQD
 XFfRunrYLaq4QyyW+m3ha5Tik/jBXOaf+qdCvd21fJrBLxnXwkjxR19RXl/s0SBAnv
 WfeVZ0yCuINJA==
Date: Fri, 11 Jul 2025 07:27:05 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
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
Message-ID: <20250711052705.GA5353@francesco-nb>
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
 <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
 <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
 <8df9cfba-662d-416e-ac21-5ae6d4448708@amd.com>
 <20250710150154.GC6424@bill-the-cat>
 <CAC_iWj+B2p-xfcdJS14LZAAjxGsxXeuBbm0CxJf_DL4E-0ytFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+B2p-xfcdJS14LZAAjxGsxXeuBbm0CxJf_DL4E-0ytFA@mail.gmail.com>
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

Hi

On Fri, Jul 11, 2025 at 08:15:25AM +0300, Ilias Apalodimas wrote:
> I can't reproduce this on my Ubuntu and Debian boxes.
> Can you paste your Ubuntu, make & gcc versions?

Our CI is also failing builds.

We build within OE master, no other changes on our side.

TI platforms are affected in a similar way

| make[1]: *** arch/arm/mach-k3/: Is a directory.  Stop.

From a quick check, with arm64, everything is fine.

Francesco

