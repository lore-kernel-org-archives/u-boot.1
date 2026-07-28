Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E43C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7103160856;
	Tue, 28 Jul 2026 11:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id REa2raye8Ez2; Tue, 28 Jul 2026 11:55:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CBEF60817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785239745;
	bh=8bcSJD174zDXuYa5rSmgkdTS7DO3YZjXLbZ2VHCkqN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nXnGAwrZlDqi6jMUcv+Nkt22kIL9JqdxxXf8uLKbII5OLwfkbZKiJ+YiU28gjdsO6
	 zdIoJ7BVFAPDF+Ip+eJSHXHtymOkEcTeGvUAC/AStdkmcjYJ/CI+46FcKLrQwZFhgl
	 Z0fT2nTIpl0L4ndD30raLqHFkEkESAHRDXiKxDKsZxRG4ju5mhZSBXhY32I3PmklrM
	 tpOstWD6XPTPek3wZuQX6/l/ijF+TN08TOPt3ViJ2m0QNXvNQK43ushAdP7kmO2RwE
	 8clOT5wjr40Agg0T/vipjfis1Le9S6liDQHpV2zGIFy54nA8MSVpu0wySA5TdXnaG/
	 ZXkj/lKqI7aUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CBEF60817;
	Tue, 28 Jul 2026 11:55:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3180F2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2329460817
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:55:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Dubdg86j7gV for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:55:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8CF78607D5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CF78607D5
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CF78607D5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:55:42 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A398494B; Tue, 28 Jul 2026 13:55:40 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA11882991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:55:37 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E01860A9E;
 Tue, 28 Jul 2026 11:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457A91F000E9;
 Tue, 28 Jul 2026 11:55:35 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 44/75] usb: dwc3: import from kernel v6.0
In-Reply-To: <20260716134305.614278-45-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-45-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 13:55:33 +0200
Message-ID: <87h5lj1g7e.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785239736;
 bh=8bcSJD174zDXuYa5rSmgkdTS7DO3YZjXLbZ2VHCkqN8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=R5SUZBM9RfEuH/6LFfu0DcbB2fh/2cKKjyXiJImVrqiwlnR1e7jHC4ukXVNPCUWYi
 FE4uqfLX9XYzS8r9ozNKLIRqZ9m1fjUYp0MI4yAQ+EwpL7OfEhqg6BBsl1QMA/yl2H
 R2Wheq+EItf+33XdCBQR7MGnIP84qgEjNiuMDGNCwMrqFlJmZreNxz0CNYyTF8CP4Q
 u9T6ZGVWoSZAIE1Qt6zCDNFG2dso5gZ17BRuGG3s9rPzLNfWI+MI97eBqpAy4cctwI
 KRbhYNlM49+MT/DWr4pHg0ls1ThB4jXoN1nWpcDJ28PovlO4S9rB2QZeNL1le0R4wH
 JV/5K+w9mhV2g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=R5SUZBM9
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="R5SUZBM9"; 
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
> Sync Linux kernel dwc3 changes from v5.19 to v6.0.
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
> List of commits: git log --oneline v5.19..v6.0
> Commits imported:
> f5c5936d6b4d usb: dwc3: st: Fix node's child name
> 91062e663b26 usb: dwc3: core: leave default DMA if the controller does not support 64-bit DMA
> 6000b8d900cd usb: dwc3: disable USB core PHY management
> e41a88f38d87 usb: dwc3: qcom: suppress unused-variable warning
> 040f2dbd2010 usb: dwc3: gadget: Avoid duplicate requests to enable Run/Stop
> bad0d1d726ac usb: dwc3: pci: Add support for Intel Raptor Lake
> ac6928f83f8d usb: dwc3: qcom: clean up suspend callbacks
> e3fafbd8e365 usb: dwc3: qcom: fix wakeup implementation
> c5f14abeb52b usb: dwc3: qcom: fix peripheral and OTG suspend
> 6498a96c8c9c usb: dwc3: qcom: fix runtime PM wakeup
> a872ab303d5d usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup
> c06795f114a6 usb: dwc3: qcom: fix gadget-only builds
> 762e744922b5 Revert "usb: dwc3: qcom: Keep power domain on to retain controller status"
> d2ac7bef95c9 usb: dwc3: fix PHY disable sequence
> 69bb3520db7c usb: dwc3: qcom: fix missing optional irq warnings
> 07903626d988 usb: dwc3: core: Do not perform GCTL_CORE_SOFTRESET during bootup
> 5e76ee96be8f usb: dwc3: ep0: Properly handle setup_packet_pending scenario in data stage
> 8affe37c525d usb: dwc3: gadget: fix high speed multiplier setting
> 23385cec5f35 usb: dwc3: gadget: refactor dwc3_repare_one_trb
> babfcd947eba usb: dwc3: gadget: fix a kernel-doc warning
> ad44cf402486 usb: dwc3: document async_callbacks field
> d9be8d5c5b03 usb: dwc3: qcom: Keep power domain on to retain controller status
> 6895ea55c385 usb: dwc3: qcom: Configure wakeup interrupts during suspend
> 360e8230516d usb: dwc3: qcom: Add helper functions to enable,disable wake irqs
> 649f5c842ba3 usb: dwc3: core: Host wake up support from system suspend
> afbd04e66e5d usb: dwc3: core: Deprecate GCTL.CORESOFTRESET
> fb119dcb97f4 Revert "usb: dwc3: Remove the checks of -ENOSYS"
> 3085d1bd47f2 usb: dwc3: Fix typos in Kconfig
> d1b39dd5819a usb: dwc3: Fix a repeated word checkpatch warning
> ca80ca61863f usb: dwc3: Fix bare use of unsigned checkpatch warning
> df22ecc41b54 usb: dwc3: Remove the checks of -ENOSYS
> 3497b9a5c8c3 usb: dwc3: add power down scale setting

Drop the st, qcom, pci changes from the changelog since we did not apply
these to U-Boot.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

