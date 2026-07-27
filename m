Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592D6C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11A4980C4D;
	Mon, 27 Jul 2026 09:12:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id km0YJqSogFGC; Mon, 27 Jul 2026 09:12:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FBBB80AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143547;
	bh=qlzpmVVCj7UB2+7601r+s6oSjWgr89fbvtGryPNIHyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v9XqOmfq+CFP0ob6Es5zwfQFQH1R88oBwg5mnAu3XtKQTgJlgsftlIDi0gCO8thpF
	 raQIWtNdrxgSr4lxJfqE5lUqQovpyz0eZzAiXa1LOmboCiFq4x7RFUiLXtADco11in
	 ynp/xN8GSd6rzwZDe8HkIN8aCg00eTQLdQK6l6WhTdS78c/0dXZIUpo6P19tK5QyUB
	 eqMfsXBNAsbrizVjGuj9w6iMn8xsixhvHmzym7YAILFGywjcy8w7GUtoBiJJ3nQLpp
	 ESOh7Q1DnbQHh/n7zLdHNTCb29NfqR+3x9uFxeqLmEk0fIYjFwF3ggiGlcVUpC0aU/
	 C1YB7duP0CHvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FBBB80AFB;
	Mon, 27 Jul 2026 09:12:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A462F3B1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:12:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96BDB400D8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:12:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UnofxN4vZ3V0 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:12:24 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6870D4005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6870D4005F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6870D4005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:12:24 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCB8184671; Mon, 27 Jul 2026 11:12:22 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9030E82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:12:20 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32589408F8;
 Mon, 27 Jul 2026 09:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A851F000E9;
 Mon, 27 Jul 2026 09:12:18 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 22/75] usb: dwc3: import from kernel v4.19
In-Reply-To: <20260716134305.614278-23-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-23-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:12:16 +0200
Message-ID: <87ik604wzz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785143539;
 bh=qlzpmVVCj7UB2+7601r+s6oSjWgr89fbvtGryPNIHyc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=dL9IBKxEdn7nYut1Wp40dpOCaqdefHWNd/ThR/+dS1SSPQlUmmwG5fA7xJD8juHpE
 XW+Hs6Z9GINhpZt0ZqUC99ItBP72xMIPlqm9ZIqHixb7I80QtQ0NjbEmi1OzcTigk+
 zMaCkNUugnHTmwbNwZgwXWmpt8bdrinujjboZlRdNLca3AvjsOcO9rVbtm3+21nove
 6iF1PdYGJ3Si/r0GXGY4dAPveNRnkznpa0nGbl85XRBsbphdNNPDlHL9R1VTfaq6Jp
 QcuP6+GV2O38rSK3uMLBGcl7w9gAd+rUcaCQfQfHAqVDVXulAruNR7aciJmRpxH4EK
 0u3kh1Km6KdYQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=dL9IBKxE
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="dL9IBKxE"; 
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
> Sync Linux kernel dwc3 changes from v4.18 to v4.19.
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
> List of commits: git log --oneline v4.18..v4.19
> Commits imported:
> 4e3121abcf53 usb/dwc3/gadget: fix kernel-doc parameter warning
> b497fff6f59e usb: dwc3: pci: Fix return value check in dwc3_byt_enable_ulpi_refclock()
> 66174b6998a6 usb: dwc3: of-simple: avoid unused function warnings
> 4ea438da76f4 usb: dwc3: gadget: Check MaxPacketSize from descriptor
> b138e23d3dff usb: dwc3: core: Enable AutoRetry feature in the controller
> a77004681148 usb: dwc3: Set default mode for dwc_usb31
> c31d983beaf0 usb: dwc3: pci: Intel Merrifield can be host
> 1a7b12f69a94 usb: dwc3: pci: Supply device properties via driver data
> d9612c2f0449 usb: dwc3: Enable undefined length INCR burst type
> d635db5508b0 usb: dwc3: add global soc bus configuration reg0
> 87d852de94d6 usb: dwc3: Describe 'wakeup_work' field of struct dwc3_pci
> 9a7faac36502 usb: dwc3: change stream event enable bit back to 13
> 76251db86561 usb: dwc3: of-simple: reset host controller at suspend/resume
> 211f658b7b40 usb: dwc3: pci: Use devm functions to get the phy GPIOs
> 7740d04d901d usb: dwc3: pci: Enable ULPI Refclk on platforms where the firmware does not
> 5741022cbdf3 usb: dwc3: pci: Add GPIO lookup table on platforms without ACPI GPIO resources
> 3fe314ca8c97 usb: dwc3: Add a glue driver for Synopsys HAPS platform
> db9fc500e85a usb: dwc3: gadget: remove redundant variable maxpacket
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>


