Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E173C678DA
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 15:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D879582AA7;
	Mon,  9 Jun 2025 17:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jp3NmLRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A0F82B07; Mon,  9 Jun 2025 17:40:55 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3150082998
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 17:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 350C1A4D4C8;
 Mon,  9 Jun 2025 15:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34976C4CEEB;
 Mon,  9 Jun 2025 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749483651;
 bh=l6dkB+sC54NtfjNEwMsEftTQcTGm8ACkByxKIngtHAk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jp3NmLRcPBQza3YcVRZabj4PzjTflT5Pte0wLgnPeWjQ463xu7pGEC7bfwCz2IBuj
 HWlZ94C59d9HMuTvpX3nMetNCMhu9JRhVw44nviYHEM6ItjeV0h/I4RdHynC/SNHQ0
 MqGADy5OPCt7/oOsOCDZ0cH6AKQ7tK2o69mfCckg+Epimced/4VCclsLKUEiozLyZV
 fcQIleOm+NzHtgJJBif1EcNcGuy5FDNUkKHQ+60zPdFhIEXj7klkffjXSBL/lR3C8E
 FQPYot7/MMcdRd9f/5sjZnUEd15NUx5L8Ka2k3//vI3IMzGARX60K1u3mbBnZ0PA5r
 EnN6jbQsvlA7w==
Date: Mon, 9 Jun 2025 16:40:43 +0100
From: Sumit Garg <sumit.garg@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com,
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
Message-ID: <aEcAe80kh66cf0_c@sumit-X1>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <dc8bb4a3-c465-4ae0-a61d-bb2f74a42b64@foss.st.com>
 <aEbgxo0WUDPd-S8Z@sumit-X1>
 <CABGWkvox-1a1VSGjX8toQ=WsVTma0JcL8su=MGWaAwq4UZFkrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABGWkvox-1a1VSGjX8toQ=WsVTma0JcL8su=MGWaAwq4UZFkrQ@mail.gmail.com>
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

On Mon, Jun 09, 2025 at 03:46:27PM +0200, Dario Binacchi wrote:
> Hi Sumit,
> 
> On Mon, Jun 9, 2025 at 3:25 PM Sumit Garg <sumit.garg@kernel.org> wrote:
> >
> > Hi Patrice,
> >
> > On Mon, Jun 09, 2025 at 03:15:14PM +0200, Patrice CHOTARD wrote:
> > >
> > >
> > > On 6/7/25 11:37, Dario Binacchi wrote:
> > > > The series adds support for stm32h747-discovery board.
> > > >
> > > > Detailed information can be found at:
> > > > https://www.st.com/en/evaluation-tools/stm32h747i-disco.html
> > > >
> > > >
> > > > Dario Binacchi (9):
> > > >   ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins phandles
> > > >   dt-bindings: arm: stm32: add compatible for stm32h747i-disco board
> > > >   dt-bindings: clock: stm32h7: rename USART{7,8}_CK to UART{7,8}_CK
> > > >   ARM: dts: stm32: add uart8 node for stm32h743 MCU
> > > >   ARM: dts: stm32: add pin map for UART8 controller on stm32h743
> > > >   ARM: dts: stm32: add an extra pin map for USART1 on stm32h743
> > > >   ARM: dts: stm32: support STM32h747i-disco board
> > > >   ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
> > > >   board: stm32: add stm32h747-discovery board support
> > >
> > >
> > > Hi Dario
> > >
> > > For the whole series
> > > Applied to u-boot-stm32/next
> >
> > Please give some time for other maintainers to review this patch-set.
> > The dts/upstream patches in this series aren't clean cherry pick from
> > upstream.
> 
> All the commits are already in the mainline Linux kernel, specifically
> in v6.16-rc1.
> If you're referring to the fact that the patches can't be applied
> cleanly, I believe it's
> because the target path in the Linux kernel doesn't match the one in U-Boot.
> In fact, the DTS files are located in two different relative paths.

That's exactly why we have (refer here [1]):

./tools/update-subtree.sh pick dts <commit-id-to-be-picked>

You should have waited v6.16-rc1 tag to be synced into
devicetree-rebasing [2] for the cherry-picks to work. This way of
manually patching dts/upstream is not allowed since it is going to break
DT syncs in one way or another.

So I would suggest you to wait for v6.16-rc1 to land in DT rebasing tree
and then send v2 with proper cherry picked patches.

[1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
[2] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git

-Sumit

> 
> Thanks and regards,
> Dario
> 
> > This has to be fixed as otherwise random patches are going to
> > cause DT sync issues.
> >
> > -Sumit
> >
> > >
> > > Thanks
> > > Patrice
> > >
> > > >
> > > >  arch/arm/dts/stm32h747i-disco-u-boot.dtsi     | 104 ++++++++++++++
> > > >  arch/arm/mach-stm32/stm32h7/Kconfig           |   4 +
> > > >  board/st/stm32h747-disco/Kconfig              |  15 ++
> > > >  board/st/stm32h747-disco/MAINTAINERS          |   7 +
> > > >  board/st/stm32h747-disco/Makefile             |   6 +
> > > >  board/st/stm32h747-disco/stm32h747-disco.c    |  42 ++++++
> > > >  configs/stm32h747-disco_defconfig             |  35 +++++
> > > >  drivers/clk/stm32/clk-stm32h7.c               |   5 +
> > > >  dts/upstream/Bindings/arm/stm32/stm32.yaml    |   4 +
> > > >  .../include/dt-bindings/clock/stm32h7-clks.h  |   4 +-
> > > >  dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi  |  34 ++++-
> > > >  dts/upstream/src/arm/st/stm32h743.dtsi        |   8 ++
> > > >  dts/upstream/src/arm/st/stm32h743i-disco.dts  |   2 +-
> > > >  dts/upstream/src/arm/st/stm32h743i-eval.dts   |   2 +-
> > > >  dts/upstream/src/arm/st/stm32h747i-disco.dts  | 136 ++++++++++++++++++
> > > >  dts/upstream/src/arm/st/stm32h750i-art-pi.dts |   6 +-
> > > >  include/configs/stm32h747-disco.h             |  32 +++++
> > > >  17 files changed, 435 insertions(+), 11 deletions(-)
> > > >  create mode 100644 arch/arm/dts/stm32h747i-disco-u-boot.dtsi
> > > >  create mode 100644 board/st/stm32h747-disco/Kconfig
> > > >  create mode 100644 board/st/stm32h747-disco/MAINTAINERS
> > > >  create mode 100644 board/st/stm32h747-disco/Makefile
> > > >  create mode 100644 board/st/stm32h747-disco/stm32h747-disco.c
> > > >  create mode 100644 configs/stm32h747-disco_defconfig
> > > >  create mode 100644 dts/upstream/src/arm/st/stm32h747i-disco.dts
> > > >  create mode 100644 include/configs/stm32h747-disco.h
> > > >
> 
> 
> 
> -- 
> 
> Dario Binacchi
> 
> Senior Embedded Linux Developer
> 
> dario.binacchi@amarulasolutions.com
> 
> __________________________________
> 
> 
> Amarula Solutions SRL
> 
> Via Le Canevare 30, 31100 Treviso, Veneto, IT
> 
> T. +39 042 243 5310
> info@amarulasolutions.com
> 
> www.amarulasolutions.com
