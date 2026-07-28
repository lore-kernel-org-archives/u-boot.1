Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF1AC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59E128134D;
	Tue, 28 Jul 2026 12:16:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BEwBfmucc4UE; Tue, 28 Jul 2026 12:16:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7DD7581346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241001;
	bh=nhelk/LEh+eDhqwliWEvAGvLFqkuhToVbgr1uiHrjd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X7A4JTecLCsFu1KPivrKXd8sTr5dlizqDOcNVjuFCeAVxdcfJsTWikpYKqMBjfWMN
	 Ktt2SIE9gcFjJWYNHMxaXS1ZaSLeFv0doj7KNa02EqdxnUfwRZ6t1hptDKW48zOyuk
	 F6mf7tIwH83t36Lo3fuyh4e2oKE043YgrEPFBRlfKToQ6Uf8EvZx/LSQ1WkPrGYG68
	 Tqbh/sKIPka5a0iPhhAKo/4X5yLQXu+GZ+A6h2V2QLeXonLGHMJw8n9UcdFbQbHnmJ
	 6t/dOjktkE4z14hkFjK+EYcO3BIRMozV+3XxIkm8AgYTYt2RKeHrGASWMA8stCcHvB
	 aDU03nGAwxhUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DD7581346;
	Tue, 28 Jul 2026 12:16:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C083C350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2F2A81346
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GnGUfzg6Q4wG for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:16:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3A3F181340
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A3F181340
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A3F181340
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:16:38 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568658494B; Tue, 28 Jul 2026 14:16:36 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF1582991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 14:16:34 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3362B414E0;
 Tue, 28 Jul 2026 12:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E11F000E9;
 Tue, 28 Jul 2026 12:16:31 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 48/75] usb: dwc3: import from kernel v6.4
In-Reply-To: <20260716134305.614278-49-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-49-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 14:16:29 +0200
Message-ID: <8733x31f8i.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785240992;
 bh=nhelk/LEh+eDhqwliWEvAGvLFqkuhToVbgr1uiHrjd8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=HOkThQfl9bGcFDojBHAnRce5h2WIhDlczPVQ7BgV+4VtDkJYolitw53kou9MiGNMm
 xe3wTgp1AojXdzcXam/BX9HH+fmazVKkHNgsAFoP5Qcj3tJqtbYHG4Gy/iiVmemxq4
 3elVYFI+7GwIOzjMxLbnOvZs/7ikJx4HGMJ3YcOMhgFOmSIsiteyFiJz7oh609cSzE
 nTVu9iVK9a8j8/Ppx1ax8lUDMNkAT0vM0UYmirc6HbNmXmgabFLQf37JG3Qve7mQxX
 rmtYcmprwZmJ96UqcXqBjl9j+9i3rqW5bK7LaNX6IcB6wml9FTEuKtX/EiT+KyhQmx
 hIoYsW5dFogTg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=HOkThQfl
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="HOkThQfl"; 
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
> Sync Linux kernel dwc3 changes from v6.3 to v6.4.
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
> List of commits: git log --oneline v6.3..v6.4
> Commits imported:
> e3dbb6575715 USB: dwc3: fix use-after-free on core driver unbind
> d2d69354226d USB: dwc3: qcom: fix NULL-deref on suspend
> 00f8205ffcf1 usb: dwc3: gadget: Reset num TRBs before giving back the request
> 8018018d9c56 usb: dwc3: fix a test for error in dwc3_core_init()
> 614ce6a2ea50 usb: dwc3: debugfs: Resume dwc3 before accessing registers
> 4e8ef34e36f2 usb: dwc3: fix gadget mode suspend interrupt handler issue
> c8540870af4c usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()
> 8f40fc080813 usb: dwc3: gadget: Refactor EP0 forced stall/restart into a separate API
> 39674be56fba usb: dwc3: gadget: Execute gadget stop after halting the controller
> 02435a739b81 usb: dwc3: gadget: Stall and restart EP0 if host is unresponsive
> d21a797a3eeb usb: dwc3: core: add support for disabling High-speed park mode
> 9a4d7dd19903 USB: dwc3: clean up probe declarations
> bd82857424d3 USB: dwc3: refactor clock lookups
> 1d72fab47656 USB: dwc3: refactor phy handling
> d2f197822d58 USB: dwc3: clean up core init error handling
> c8e9eccf6ed2 USB: dwc3: clean up phy init error handling
> fe296046c721 USB: dwc3: clean up probe error labels
> f56d0d29b018 USB: dwc3: drop dead hibernation code
> bdb19d01026a USB: dwc3: gadget: drop dead hibernation code
> 6b3b2402ca5b USB: dwc3: disable autosuspend on unbind
> 44d257e9012e USB: dwc3: fix runtime pm imbalance on unbind
> 9a8ad10c9f2e USB: dwc3: fix runtime pm imbalance on probe errors
> 091b813d3d10 usb: Add explicit of.h of_platform.h include
> 917dc99b6591 usb: dwc3: pci: Change PCI device macros
> 92c08a84b53e usb: dwc3: Add function suspend and function wakeup support
> 047161686b81 usb: dwc3: Add remote wakeup handling
> 2926c5275028 usb: dwc3-am62: Fix up wake-up configuration and spurious wake up
> db2c2b161d4a usb: dwc3: host: remove dead code in dwc3_host_get_irq()
> 8c4853c48d6c usb: dwc3: add several registers dump for debugfs
> 4e3972b589da usb: dwc3-am62: Enable as a wakeup source by default
> 84364a00b264 usb: dwc3-am62: Add support for system wakeup based on USB events
> 4fa1387261e7 usb: remove dead code in dwc3_gadget_get_irq
> f09d24aa463c usb: dwc3: change some trace event __dynamic_array() to __get_buf()
> 4decf4060ecf usb: dwc3: gadget: Change condition for processing suspend event
> b84ba26c922a usb: dwc3: core: add external vBus supply support for ulpi phy

Please drop the commits that were not imported (for example qcom ones)
from the changelog.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

