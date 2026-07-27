Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B338CC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1D706065D;
	Mon, 27 Jul 2026 08:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uhuwEg4cKTDc; Mon, 27 Jul 2026 08:57:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AC306066F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142620;
	bh=mEYZyTawxnHMjtrbSElWnACgizODDezTMZhDCGSuKXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VerI37m4ma3R1y+7LXanLhFp9xW9vP3Mzih1dCOIRBIO1CR3ZoN6uQ5zqCrY1Y/E0
	 dYMYY/5HXX8P1gbKtrtSYrSpJV92XEAIrHksqI07cA94ooveIuHPDIoWKwziJmXbYP
	 THf+6cMfLjbf0xqCxUH3onmmfBhuAIReLo1WfyO6xYkp2FochyGIBmEwM7xauoVkkw
	 f6mG7gKsfINkkho7hMZGlN5M62H0TriJVyP2ICCSM0mN2A08RGn3xA9/dYqyS2oxs7
	 fZj03iqhDfAUXFRbkh7hwgJ8lB1IropdBwUG9jP/+U75Xwk4UTfkUbjUUz33z+o+RK
	 3nD7TYpOoTE9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AC306066F;
	Mon, 27 Jul 2026 08:57:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3802F45B
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29C956066F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id quiUDb6Z2oIW for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:56:57 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CC01A6065D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC01A6065D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC01A6065D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DDAB84671; Mon, 27 Jul 2026 10:56:55 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC4A82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:56:53 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0506760A59;
 Mon, 27 Jul 2026 08:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259DE1F00A3A;
 Mon, 27 Jul 2026 08:56:50 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 10/75] usb: dwc3: import from kernel v4.7
In-Reply-To: <20260716134305.614278-11-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-11-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 10:56:49 +0200
Message-ID: <87ik606ca6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142611;
 bh=mEYZyTawxnHMjtrbSElWnACgizODDezTMZhDCGSuKXg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=M2n0AFkv11GYxdVVbVCWARZ//YmnJiLZ0Dlj8tliPVMeLU3CUYyC0FFgbqfaIWJG9
 yHu3GlXaOq8oLnyh8vIc568N66qUxe7hKFBoowJS9tJjHMWbvXszDFkYz1RlZO3IJn
 PQ1ftEgP87K83Wjp2e0AecIWP/aeULx1sWe0AcgBylLvegqEF8LM5nqZp9naBCIW8/
 QngCvNnRzYAM/hMp2Fo+eyryxCu6BIy6lrxLgBYS/35AdMMFLaJGo32xG8loI6tJG4
 +f5t7iZSV+F2PgJzZIBLWpsFRm7LRjiRRPIjv0LdUe/A8wWZU0r9J93VeAj6rM3oRd
 Zh55CYflKgYLw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=M2n0AFkv
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="M2n0AFkv"; 
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

On Thu, Jul 16, 2026 at 15:41, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v4.6 to v4.7.
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
> List of commits: git log --oneline v4.6..v4.7
> Commits imported:
> 5baaf3b9efe1 usb: dwc3: st: Use explicit reset_control_get_exclusive() API
> 002f17bc54ff usb: dwc3: st: Inform the reset framework that our reset line may be shared
> 50c763f8c1ba usb: dwc3: Set the ClearPendIN bit on Clear Stall EP command
> 27a0faafdca5 usb: dwc3: st: Fix USB_DR_MODE_PERIPHERAL configuration.
> 4879efb34f7d usb: dwc3: exynos: Fix deferred probing storm.
> 973986126a41 usb: dwc3: gadget: fix mask and shift order in DWC3_DCFG_NUMP()
> 2a58f9c12bb3 usb: dwc3: gadget: disable automatic calculation of ACK TP NUMP
> 676e34974481 usb: dwc3: gadget: update DCFG.NumP to max burst size
> 7b9cc7a2b101 usb: dwc3: gadget: give better command return code
> ce046d323d74 usb: dwc3: pci: pass the platform device as a parameter to dwc3_pci_quirks()
> 474799f07376 usb: dwc3: pci: make build-in device properties available
> ae4114137607 usb: dwc3: ep0: sanity check test mode selector
> 818ec3aba883 usb: dwc3: debugfs: dump out endpoint details
> b058f3e8a399 usb: dwc3: core: add helper to extract trb type
> cf6d867d3b57 usb: dwc3: core: add fifo space helper
> 4e9f311833a9 usb: dwc3: make dwc3_debugfs_init return value be void
> af566a0be6e4 usb: dwc3: omap: get rid of dma_status
> 8e7046b71dae usb: dwc3: gadget: don't interrupt when chained
> 052ba52efa17 usb: dwc3: gadget: remove newline from trace
> 36b68aae8e39 usb: dwc3: gadget: use link TRB for all endpoint types
> 4faf75504a7d usb: dwc3: gadget: move % operation to increment helpers
> ef966b9d3353 usb: dwc3: gadget: add trb enqueue/dequeue helpers
> 70fdb273db37 usb: dwc3: get rid of DWC3_TRB_MASK
> c28f82595dde usb: dwc3: switch trb enqueue/dequeue and first_trb_index to u8
> 5ef68c56e169 usb: dwc3: core: document struct dwc3_request
> 53fd88189e08 usb: dwc3: gadget: rename busy/free_slot to trb_enqueue/dequeue
> 495dd5f78145 usb: dwc3: omap: drop dma_mask configuration
> e58dd357741b usb: dwc3: add disable receiver detection in P3 quirk
> c36d8e947a56 usb: dwc3: gadget: put link to U0 before Start Transfer
> 218ef7b647e3 usb: dwc3: gadget: extract unlocked dwc3_gadget_wakeup()
> 2b0f11df84bb usb: dwc3: gadget: clear SUSPHY bit before ep cmds
> c0ca324d09a0 usb: dwc3: gadget: combine return points into a single one
> dea520a4a283 usb: dwc3: gadget: pass ev_buff as cookie to irq handler
> 696c8b128220 usb: dwc3: drop ev_buffs array
> 660e9bde74d6 usb: dwc3: remove num_event_buffers
> aa3342c8bb61 usb: dwc3: better name for our request management lists
> 8495036e986b usb: dwc3: increase maximum number of TRBs per endpoint
> ca4d44ea2a91 usb: dwc3: gadget: always enable CSP
> bc5081617fae usb: dwc3: drop FIFO resizing logic
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

