Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B53C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 13:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB14826AA;
	Mon,  9 Jun 2025 15:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NBy/Q+ks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B55382998; Mon,  9 Jun 2025 15:25:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEEB9811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 15:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A50785C2711;
 Mon,  9 Jun 2025 13:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4021BC4CEEB;
 Mon,  9 Jun 2025 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749475535;
 bh=fk46SS2+TkzfYcriC5jAB6eG6XDHbn1d2BzamCV30vk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NBy/Q+ks8LRivwYCa2EF6kgOtXZsEOZJNw5UoH5wrX5SFGJqyK1cLpmfO3nNnNiF8
 dAmapUaJhp4YPR9XdeFv0J8+OIyYbJo1/xWLyS8xFOYzEG9Om18fts4By8Nmig/nH/
 hdycqEvwgrXMMtwCof/QXlMbjORoHK3KgXmCxzh0jIXpXrjztmSNBCXhaIkZnsT02h
 IECLLGo7xVFHZHG4CM/zKSWsv20EAe2p1etLZQMPW5C7tjgzdC5E6AhkdR0MSh5O2o
 CBJERZ9Eg68vm2l0P4zkphdSkFODXliX67oXXz/OYNqpuGOmVbPewlvUz0Ua7OT8nn
 R65Pc5tD9CX3Q==
Date: Mon, 9 Jun 2025 14:25:26 +0100
From: Sumit Garg <sumit.garg@kernel.org>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, linux-amarula@amarulasolutions.com,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Dillon Min <dillon.minfei@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/9] Support stm32h747-discovery board
Message-ID: <aEbgxo0WUDPd-S8Z@sumit-X1>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <dc8bb4a3-c465-4ae0-a61d-bb2f74a42b64@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc8bb4a3-c465-4ae0-a61d-bb2f74a42b64@foss.st.com>
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

Hi Patrice,

On Mon, Jun 09, 2025 at 03:15:14PM +0200, Patrice CHOTARD wrote:
> 
> 
> On 6/7/25 11:37, Dario Binacchi wrote:
> > The series adds support for stm32h747-discovery board.
> > 
> > Detailed information can be found at:
> > https://www.st.com/en/evaluation-tools/stm32h747i-disco.html
> > 
> > 
> > Dario Binacchi (9):
> >   ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins phandles
> >   dt-bindings: arm: stm32: add compatible for stm32h747i-disco board
> >   dt-bindings: clock: stm32h7: rename USART{7,8}_CK to UART{7,8}_CK
> >   ARM: dts: stm32: add uart8 node for stm32h743 MCU
> >   ARM: dts: stm32: add pin map for UART8 controller on stm32h743
> >   ARM: dts: stm32: add an extra pin map for USART1 on stm32h743
> >   ARM: dts: stm32: support STM32h747i-disco board
> >   ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
> >   board: stm32: add stm32h747-discovery board support
> 
> 
> Hi Dario
> 
> For the whole series
> Applied to u-boot-stm32/next

Please give some time for other maintainers to review this patch-set.
The dts/upstream patches in this series aren't clean cherry pick from
upstream. This has to be fixed as otherwise random patches are going to
cause DT sync issues.

-Sumit

> 
> Thanks
> Patrice
> 
> > 
> >  arch/arm/dts/stm32h747i-disco-u-boot.dtsi     | 104 ++++++++++++++
> >  arch/arm/mach-stm32/stm32h7/Kconfig           |   4 +
> >  board/st/stm32h747-disco/Kconfig              |  15 ++
> >  board/st/stm32h747-disco/MAINTAINERS          |   7 +
> >  board/st/stm32h747-disco/Makefile             |   6 +
> >  board/st/stm32h747-disco/stm32h747-disco.c    |  42 ++++++
> >  configs/stm32h747-disco_defconfig             |  35 +++++
> >  drivers/clk/stm32/clk-stm32h7.c               |   5 +
> >  dts/upstream/Bindings/arm/stm32/stm32.yaml    |   4 +
> >  .../include/dt-bindings/clock/stm32h7-clks.h  |   4 +-
> >  dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi  |  34 ++++-
> >  dts/upstream/src/arm/st/stm32h743.dtsi        |   8 ++
> >  dts/upstream/src/arm/st/stm32h743i-disco.dts  |   2 +-
> >  dts/upstream/src/arm/st/stm32h743i-eval.dts   |   2 +-
> >  dts/upstream/src/arm/st/stm32h747i-disco.dts  | 136 ++++++++++++++++++
> >  dts/upstream/src/arm/st/stm32h750i-art-pi.dts |   6 +-
> >  include/configs/stm32h747-disco.h             |  32 +++++
> >  17 files changed, 435 insertions(+), 11 deletions(-)
> >  create mode 100644 arch/arm/dts/stm32h747i-disco-u-boot.dtsi
> >  create mode 100644 board/st/stm32h747-disco/Kconfig
> >  create mode 100644 board/st/stm32h747-disco/MAINTAINERS
> >  create mode 100644 board/st/stm32h747-disco/Makefile
> >  create mode 100644 board/st/stm32h747-disco/stm32h747-disco.c
> >  create mode 100644 configs/stm32h747-disco_defconfig
> >  create mode 100644 dts/upstream/src/arm/st/stm32h747i-disco.dts
> >  create mode 100644 include/configs/stm32h747-disco.h
> > 
