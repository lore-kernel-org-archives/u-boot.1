Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687F8C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB70640960;
	Tue, 28 Jul 2026 09:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 32baXnoVtoC4; Tue, 28 Jul 2026 09:54:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8916C408FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785232476;
	bh=4RRcLdGd2SpAZYAg8wnPGG2Qgg7yqZ1b35KBjjbcGME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vxMTcZy9lEFyUTPm9kTLHIETR34ONlqVcXvqAeFauswPCx7R4Fsk4clrNRUoxqJN8
	 ilPDVmjHMLZtBJFJGA/MjGTyhNbHR0gW5FcW4fY7l6rONuwhqCgLV26R5d7+qcwbIr
	 hzokAbU8yRisiqALHWtex/mJja3xEcMMyKPgXL8B65mYAVjKnraxXe/mgu/Uz5kT/5
	 ffk2tvCBdSPCZknvDofxhdd+a5V4rhB1fEztMqKM4M493uETHmXBaGPoRdPgXzLVX7
	 rEn1znjSyAVaTup0qGjCgTWwUXSduN83/erHUmypxcg1Ag7PORUhFGTRW/2RA2k1OG
	 4xcam+28jP04w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8916C408FC;
	Tue, 28 Jul 2026 09:54:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 08643350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF00460820
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xVgCkUDMZX4I for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:54:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 94AAD60811
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94AAD60811
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94AAD60811
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:54:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07BBE8494B; Tue, 28 Jul 2026 11:54:32 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61438848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:54:29 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36C2C60A8D;
 Tue, 28 Jul 2026 09:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E90B1F000E9;
 Tue, 28 Jul 2026 09:54:27 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 43/75] usb: dwc3: import from kernel v5.19
In-Reply-To: <20260716134305.614278-44-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-44-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:54:24 +0200
Message-ID: <87jyqf1ltb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785232467;
 bh=4RRcLdGd2SpAZYAg8wnPGG2Qgg7yqZ1b35KBjjbcGME=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=D08KvQG7+vjmmKXYyEgsjNaWo59Gtmvjxkb6aOt+I/JAbC40r2n0D1NuvL+rrlT1o
 qCvEjtZf/ChMtLFzfipjiAQdCZxpltadna/BWoK3CXv0Y/rO2tzG+FhsdUFPM/vHTe
 lJ9obXHwUJfH/mADtZh4HwvcjOy2yfObL7s89Y2DhK/f0K+smVGDWym8gJqkjfaoAy
 79AwDp1uWCe8vPtLjC7H3VQ0o/Vze8ffLYp2MRE8gK5gqpgwHfcu7OWso+2baJaVYx
 MSzC7F+A3OkumSb0zIqiTlpu/v5ywnRzteAhkoA2XmDzReNBqRaa6/atIX1AEtk9Cb
 fW3fxy8Ryo9gg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=D08KvQG7
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="D08KvQG7"; 
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
> Sync Linux kernel dwc3 changes from v5.18 to v5.19.
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
> List of commits: git log --oneline v5.18..v5.19
> Commits imported:
> 5812175389e2 usb: dwc3-am62: remove unnecesary clk_put()
> 7441b273388b usb: dwc3: gadget: Fix event pending check
> 8bd6b8c4b100 USB: fixup for merge issue with "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"
> 7ddda2614d62 usb: dwc3: pci: Restore line lost in merge conflict resolution
> 9c1e916960c1 usb: dwc3: gadget: Fix IN endpoint max packet size allocation
> 859bdc359567 usb: dwc3: core: Add error log when core soft reset failed
> 3c5880745b44 usb: dwc3: gadget: Move null pinter check to proper place
> 9d778f0c5f95 usb: dwc3: Fix ep0 handling when getting reset while doing control transfer
> d090c7a2ab84 USB / dwc3: Fix a checkpatch warning in core.c
> f66eef8fb898 usb: dwc3: gadget: Delay issuing End Transfer
> ace17b6ee4f9 usb: dwc3: gadget: Only End Transfer for ep0 data phase
> c96683798e27 usb: dwc3: ep0: Don't prepare beyond Setup stage
> 8f8034f493b5 usb: dwc3: gadget: Don't modify GEVNTCOUNT in pullup()
> 861c010a2ee1 usb: dwc3: gadget: Refactor pullup()
> 69e131d1ac4e usb: dwc3: gadget: Prevent repeat pullup()
> ca05b38252d7 usb: dwc3: xilinx: Add gpio-reset support
> 4ea150889ad7 usb: dwc3: remove a possible unnecessary 'out of memory' message
> 7fd069d65da2 usb: dwc3: host: Stop setting the ACPI companion
> a03e2ddab8e7 usb: dwc3: pci: Fix pm_runtime_get_sync() error checking
> bf594d1d0c1d usb: dwc3: gadget: Replace list_for_each_entry_safe() if using giveback
> 2840d6dfcf43 usb: dwc3: EP clear halt leading to clearing of delayed_status
> 0f0101719138 usb: dwc3: Don't switch OTG -> peripheral if extcon is present
> 6a7c7df993bd usb: dwc3: gadget: increase tx fifo size for ss isoc endpoints
> 0fee30ab6351 USB / dwc3: Fix three doc-build warnings
> e8784c0aec03 drivers: usb: dwc3: Add AM62 USB wrapper driver

Drop pci, xilinx, host patches from changelog as they touch "unused
files"

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

