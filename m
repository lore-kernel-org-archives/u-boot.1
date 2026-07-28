Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B4EC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1C8B8128C;
	Tue, 28 Jul 2026 09:23:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D06gffUp-ioG; Tue, 28 Jul 2026 09:23:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1044B81287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785230587;
	bh=GSjx4ZEn1xGSQ4TUEVeDG76wPd3t/XhzSuE2URJ/v6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JX58R/0ZU1Bbtf9iN58A1yIFuWYRPD5eYIGGGM8EKq1dzsp6qkj02CLYGt+oqH1L3
	 HUUyAyil3jpdsX6Bdfj03em4BQYz64w/suMBiM/QY9xgGLDlAyG+haV8uPSDQcnKu0
	 OiNLtj66edcGdFvHQ1hCKudKZVAx7CBMIlilAUcXqJUr6HJqm7CTdGbw8fxQEfLO+w
	 LC0GCDKFWCyPkfLIvX1KtnmEEuhpheVfepl/XY7OLtNY8dxFa3qhvPiE7kruFlFU1B
	 QQ7FO25jm1P+c4INTJKP08VKEUGPyA/qB7i6R1+yb2YjHRxO7zEv6dOzLvz8qmyH3j
	 baI64RL07WBIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1044B81287;
	Tue, 28 Jul 2026 09:23:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B42C126C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3763401FC
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JhWTtP5C4X12 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:23:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3B70C400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B70C400D3
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B70C400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:23:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0AE384873; Tue, 28 Jul 2026 11:23:01 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D0AC82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:22:59 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F387160A66;
 Tue, 28 Jul 2026 09:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ACD1F000E9;
 Tue, 28 Jul 2026 09:22:57 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 37/75] usb: dwc3: import from kernel v5.13
In-Reply-To: <20260716134305.614278-38-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-38-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:22:55 +0200
Message-ID: <871pcn31u8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785230577;
 bh=GSjx4ZEn1xGSQ4TUEVeDG76wPd3t/XhzSuE2URJ/v6g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=DzmHqRa8Hic0Fyfb491PBzWopXcXovny9V+63Ok7IW/FlzAoD1zb/G1puR+vn/cZT
 476ppOYqr52peD7X5M3ZgYMpra/eVHiAPJxWGjCZKLTeBARvvjNSNL9lzyycyIi+sm
 OwBDSFJeobTZ5iy4JgJb7eY/A/uavOWMwbL9B+/tjKwgV56Vp1TDs04D/iM6ISVJCF
 r0GxyBVoW0EfffQtjY2wQKMifqt2fPV1issgSzJPI10SplJpw2PHn3f730wBWmZX+x
 jiiO5l6+R69rqslaOAqJ0J1dDwEfm6eG7GDOc8IxfQUnEcl04Cdf0BQCWwYjP90VCs
 zZV3N1zi/Yegw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=DzmHqRa8
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="DzmHqRa8"; 
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
> Sync Linux kernel dwc3 changes from v5.12 to v5.13.
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
> List of commits: git log --oneline v5.12..v5.13
> Commits imported:
> 4bf584a03eec usb: dwc3: core: fix kernel panic when do reboot
> d00889080ab6 usb: dwc3: ep0: fix NULL pointer exception
> 4d2aa178d2ad usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled
> 1d0d3d818eaf usb: dwc3: meson-g12a: Disable the regulator in the error handling path of the probe
> 8f11fe7e4068 Revert "usb: dwc3: core: Add shutdown callback for dwc3"
> 8d396bb0a5b6 usb: dwc3: debugfs: Add and remove endpoint dirs dynamically
> 03715ea2e3db usb: dwc3: gadget: Bail from dwc3_gadget_exit() if dwc->gadget is NULL
> 8212937305f8 usb: dwc3: gadget: Disable gadget IRQ during pullup disable
> 25dda9fc56bd usb: dwc3: gadget: Properly track pending and queued SG
> e17b02d49709 usb: dwc3: omap: improve extcon initialization
> 0b2b149e918f usb: dwc3: imx8mp: fix error return code in dwc3_imx8mp_probe()
> b96992081fde usb: dwc3: imx8mp: detect dwc3 core node via compatible string
> 18ffa988dbae usb: dwc3: gadget: Return success always for kick transfer in ep queue
> bb9c74a5bd14 usb: dwc3: gadget: Free gadget structure only after freeing endpoints
> 6f26ebb79a84 usb: dwc3: gadget: Rename EOPF event macros to Suspend
> d1d90dd27254 usb: dwc3: gadget: Enable suspend events
> 9cbc7eb17cdf usb: dwc3: core: Add missing GHWPARAMS9 doc
> 04357fafea9c usb: dwc3: pci: Enable usb2-gadget-lpm-disable for Intel Merrifield
> ddae7979cdd5 usb: dwc3: gadget: Handle DEV_TXF_FLUSH_BYPASS capability
> 16710380d3aa usb: dwc3: Capture new capability register GHWPARAMS9
> f88359e1588b usb: dwc3: core: Do core softreset when switch mode
> 3232a3ce55ed usb: dwc3: gadget: Remove FS bInterval_m1 limitation
> c560e76319a9 usb: dwc3: gadget: Fix START_TRANSFER link state check
> 475e8be53d04 usb: dwc3: gadget: Check for disabled LPM quirk
> 568262bf5492 usb: dwc3: core: Add shutdown callback for dwc3
> e66bbfb0fbbe usb: dwc3: gadget: Ignore Packet Pending bit
> 3db53374405f usb: dwc3: qcom: Detect DWC3 DT-nodes using compatible string
> dc1e7e9a27e0 usb: dwc3: qcom: Remove redundant dev_err call in dwc3_qcom_probe()
> 124b11cc4f62 usb: dwc3: xilinx: Remove the extra freeing of clocks
> 3a2a68ecb25e usb: dwc3: Resolve kernel-doc warning for Xilinx DWC3 driver
> 782de5e7190d usb: dwc3: pci: add support for the Intel Alder Lake-M
> 04dd6e76b228 usb: dwc3: add cancelled reasons for dwc3 requests
> 048b14e1f28b usb: dwc3: exynos: fix incorrect kernel-doc comment syntax
> 27088e00b623 usb: dwc3: fix incorrect kernel-doc comment syntax in files
> c9714d65eac8 usb: dwc3: st: fix incorrect kernel-doc comment syntax in file
> ed577c325b64 usb: dwc3: imx8mp: fix incorrect kernel-doc comment syntax
> d00be779cc50 usb: dwc3: Create helper function getting MDWIDTH
> 8a5b5c3c1634 usb: dwc3: gadget: modify the scale in vbus_draw callback
> 3fc63d0724bb usb: dwc3: trace: Print register read and write offset
> 71ca43f30df9 usb: dwc3: gadget: Ignore EP queue requests during bus reset
> 02fa4b980245 usb: dwc3: gadget: Avoid continuing preparing TRBs during teardown
> 84770f028fab usb: dwc3: Add driver for Xilinx platforms
> 0c59f678fcfc usb: dwc3: gadget: Remove invalid low-speed setting
> 064ece8d7ca7 drivers: usb: Fix a typo in dwc3-qcom.c
> 0f3edf99c239 usb: dwc3: document usb_psy in struct dwc3
> b0bf77cd389d usb: dwc3: Fix dereferencing of null dwc->usb_psy
> 99288de36020 usb: dwc3: add an alternate path in vbus_draw callback
> 6f0764b5adea usb: dwc3: add a power supply for current control

Drop debugfs, imx8mp, pci, qcom, xilinx, trace patches from the
changelog since they are marked "unused files" in the commit message.

With that fixed:
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

