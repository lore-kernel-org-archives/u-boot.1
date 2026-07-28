Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65CFC54EFC
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B7388127D;
	Tue, 28 Jul 2026 09:09:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yB90NGzSbSnd; Tue, 28 Jul 2026 09:09:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31CB481189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785229772;
	bh=5ywgG0yPI3arAq/iZGqrNed8nUZxqDyb7SQXBo09dd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lDplHPj8NWKL5V4TaxHjaMLricFORePAGA/2d2IKq78S1cc6i1+DXn5NA0AKF1bFb
	 jxZRUnihEuoUOSgMgJWbd9cZvs9DAHdFxiL5ndejt9h3/qWaUc6GpFW3P+3x4xCf8Y
	 X6eiDPSJbANmxMmB8nVU+U3rAHjKs2a1k8wH/pwWhAPeV8IZ6TY/yFiAJpzH/VPx4a
	 +qSvvCzfDq8SvOQuK7GtWsbexGTC7ojx9S6eVORYS35grCXlKmL5BqAY82p1AamNPw
	 gLYPuGo9+WD7woleXE52j9fSMMmeotHGiJzf1BEaA0wTZaudtlhJGi7fbna5LiUGWi
	 HoStTn+0Mh8KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31CB481189;
	Tue, 28 Jul 2026 09:09:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D78E42A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 839EA81208
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fcjKGXc5j-BC for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:09:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 16D0E81189
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16D0E81189
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16D0E81189
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:09:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B0584873; Tue, 28 Jul 2026 11:09:26 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3EDE82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:09:23 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FAEE4139D;
 Tue, 28 Jul 2026 09:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BE61F000E9;
 Tue, 28 Jul 2026 09:09:21 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 32/75] usb: dwc3: import from kernel v5.8
In-Reply-To: <20260716134305.614278-33-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-33-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:09:19 +0200
Message-ID: <87fr1332gw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785229762;
 bh=5ywgG0yPI3arAq/iZGqrNed8nUZxqDyb7SQXBo09dd0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=bN/X7pXj8yOA8u1ifUsVBl7rUtPjLGVg1MmBxUhyaEFelzfDm6C7+DPbo6knQUMM3
 oOI3IYNknuNxmEgwiwYq00G71fL+v203SBJq+S6G74w/tXIGBDoBfryOwZorPRRFVM
 DSYjCp3EUivljDbtUYu6/i3e1tw2T3xc6xq+7XgFpanB7gR9iaMyx5VVF5Dscq111N
 HoS8S2FAkH3Dc1GJNQgvjg34OPBddzWtKhXYA/2DsisuJ1xikFyKInjXyY/MlQzEuT
 Du7NPbG/IA+vvGsry0+a6ATQsd9N7+qsfuWM12ab42TS98F4q10QGby44EjpkGmQVK
 2nQH+gPbj8Dng==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bN/X7pXj
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="bN/X7pXj"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anders,

Thank you for the patch.

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v5.7 to v5.8.
>
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> List of commits: git log --oneline v5.7..v5.8
> Commits imported:
> e25d1e8532c3 usb: dwc3: pci: add support for the Intel Jasper Lake
> c3f595a81192 usb: dwc3: pci: add support for the Intel Tiger Lake PCH -H variant
> cd37c6976f6a Revert "usb: dwc3: exynos: Add support for Exynos5422 suspend clk"
> 2655971ad4b3 usb: dwc3: pci: Fix reference count leak in dwc3_pci_resume_work
> 347052e3bf1b usb: dwc3: meson-g12a: fix USB2 PHY initialization on G12A and A1 SoCs
> be8c1001a7e6 usb: dwc3: meson-g12a: fix error path when fetching the reset line fails
> 1c11e74e9079 usb: dwc3: keystone: Turn on USB3 PHY before controller

Is this patch really imported? It seems to only touch
drivers/usb/dwc3/dwc3-keystone.c which is not part of the diffstat below.

> 63c7bb299fc9 usb: dwc3: gadget: Check for prepared TRBs
> 1c0e69ae1b9f usb: dwc3: Increase timeout for CmdAct cleared by device controller
> b10e1c253577 usb: dwc3: gadget: Use SET_EP_PRIME for NoStream
> 140ca4cfea8a usb: dwc3: gadget: Handle stream transfers
> aefe3d232b66 usb: dwc3: gadget: Don't prepare beyond a transfer
> e0d19563eb6c usb: dwc3: gadget: Wait for transfer completion
> 3eaecd0c2333 usb: dwc3: gadget: Handle XferComplete for streams
> 548f8b316563 usb: dwc3: gadget: Enable XferComplete event
> 2e6e9e4b2ed7 usb: dwc3: gadget: Refactor TRB completion handler
> b6842d4938c3 usb: dwc3: gadget: Check for in-progress END_TRANSFER
> 4244ba02edb8 usb: dwc3: Get MDWIDTH for DWC_usb32
> 9af21dd6faeb usb: dwc3: Add support for DWC_usb32 IP
> c685114f63b1 usb: dwc3: use true,false for dwc->otg_restart_host
> f4cc91ddd856 usb: dwc3: of-simple: remove Amlogic GXL and AXG compatibles
> a9fc15e0fd78 usb: dwc3: meson-g12a: add support for GXL and GXM SoCs
> df7e37458151 usb: dwc3: meson-g12a: support the GXL/GXM DWC3 host phy disconnect
> 5b0ba0caaf3a usb: dwc3: meson-g12a: refactor usb init
> d9feef974e0d usb: dwc3: gadget: Continue to process pending requests
> f7ac582effc6 usb: dwc3: gadget: WARN on no-resource status
> 36f05d36b035 usb: dwc3: gadget: Issue END_TRANSFER to retry isoc transfer
> 9bc3395c2496 usb: dwc3: gadget: Store resource index of start cmd
> 8d99087c2db8 usb: dwc3: gadget: Properly handle failed kick_transfer
> 8bb14308a869 usb: dwc3: core: Use role-switch default dr_mode
> 8cc6d55bc200 usb: dwc3: drd: Don't free non-existing irq
> 31306821d877 usb: dwc3: meson-g12a: refactor usb2 phy init
> 8f5bc1ec770c usb: dwc3: meson-g12a: check return of dwc3_meson_g12a_usb_init
> 6d9fa35a347a usb: dwc3: meson-g12a: get the reset as shared
> 013af227f58a usb: dwc3: meson-g12a: handle the phy and glue registers separately
> 5174564cb915 usb: dwc3: meson-g12a: specify phy names in soc data
> fcd2def66392 usb: dwc3: gadget: Refactor dwc3_gadget_ep_dequeue
> 8411993e79df usb: dwc3: gadget: Remove unnecessary checks
> a7027ca69d82 usb: dwc3: gadget: Give back staled requests
> cb11ea56f37a usb: dwc3: gadget: Properly handle ClearFeature(halt)
> c2cd3452d5f8 usb: dwc3: support continuous runtime PM with dual role
> b33f69f56352 USB: dwc3: Use the correct style for SPDX License Identifier
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/usb/dwc3/core.c   |  62 ++---
>  drivers/usb/dwc3/core.h   |  83 ++++---
>  drivers/usb/dwc3/debug.h  |   4 +-
>  drivers/usb/dwc3/gadget.c | 469 +++++++++++++++++++++++++++++---------
>  drivers/usb/dwc3/gadget.h |   2 +-
>  drivers/usb/dwc3/io.h     |   2 +-
>  6 files changed, 452 insertions(+), 170 deletions(-)
>
