Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E939EC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 10:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30CA082B34;
	Thu, 15 May 2025 12:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="wVtYXynT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E4E82B37; Thu, 15 May 2025 12:19:07 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45DEA82B2F
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 12:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 2A04A229C6;
 Thu, 15 May 2025 12:19:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1747304343;
 bh=TdkEDtyWfEiPbRyTVa90NSwyn+5I2tRsXlAe5ER5nGI=; h=From:To:Subject;
 b=wVtYXynTexii0YAjC1aJUxYchCSSh5734L22k2MT5+ifSHdo2ZS+PKaqvzvB61FeA
 AOmXWEXFFgvKLpxb1itUTlwJAt+7XRKMzAKnbDVSjAwAqjXzm43MdqaO/OvhdrRAfl
 GvSmCT5SNscObpxYQ0f4Gdn6rrAcr2iK99j3lYFLf4N6NxPmQRdLcc2Pgjb5N1rA8a
 nXkMSQepnJc5NkmlqGYyYBFC6+/mHdcZlg5NjJznsCs4I8zuWfWoUIp8zTrNZZg1Vx
 5hX2fS0vuzBX03H3HHe8hns9HffrbeNVm/wHneDPG490ZToU7ki2zOlnfkPPrMzuOa
 8pQxqskMertcw==
Date: Thu, 15 May 2025 12:18:59 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Vishal Mahaveer <vishalm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Chandru Dhavamani <chandru@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Vitor Soares <vitor.soares@toradex.com>
Subject: Re: [PATCH 1/3] arm: dts: k3-*-r5: Remove clocks from mcu_timer0
Message-ID: <20250515101859.GA43440@francesco-nb>
References: <20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com>
 <20241121-b4-upstream-pll-fix-v1-1-904f618897a7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121-b4-upstream-pll-fix-v1-1-904f618897a7@ti.com>
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

Hello Manorit,

On Thu, Nov 21, 2024 at 05:32:51PM +0530, Manorit Chawdhry wrote:
> Updated PLL driver sequencing requires us to use udelay in the PLL
> driver as there is no poll bit to get the status of operations.
> tick-timer(mcu_timer0/main_timer0) setting up the clocks for itself is
> something that won't work as the PLL driver will be using udelay and
> PLLs are configured during clock probe which would end up in a recursive
> probe.
> 
> tick-timer being used by K3 devices are configured by ROM and we really
> don't need to configure any of the clocks.
> 
> Remove the clock dependency from R5 stage as we don't need to setup
> clocks for it.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi         | 10 ----------
>  arch/arm/dts/k3-am62-r5-lp-sk.dts              |  9 +++++++++
>  arch/arm/dts/k3-am625-r5-sk.dts                |  9 +++++++++
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi           | 10 ----------
>  arch/arm/dts/k3-am62a7-r5-sk.dts               | 10 ++++++++++
>  arch/arm/dts/k3-am62a7-sk-u-boot.dtsi          |  5 -----
>  arch/arm/dts/k3-am62p5-r5-sk.dts               |  8 ++++++++
>  arch/arm/dts/k3-j7200-r5-common-proc-board.dts |  4 ++++
>  arch/arm/dts/k3-j721e-r5.dtsi                  |  6 +++++-
>  arch/arm/dts/k3-j721s2-r5.dtsi                 |  4 ++++
>  arch/arm/dts/k3-j722s-r5-evm.dts               |  8 ++++++++
>  arch/arm/dts/k3-j784s4-r5.dtsi                 |  5 ++++-
>  12 files changed, 61 insertions(+), 27 deletions(-)

This change should have been done to any board using any of those SoC,
correct? verdin-am62 was not changed, for example.

Francesco


