Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40E8C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76A5D4057C;
	Tue, 28 Jul 2026 09:21:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xyU0kB2u2t5X; Tue, 28 Jul 2026 09:21:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC3A1405DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785230472;
	bh=ve2SR/PzPMubSda1GMYd+vJCnNS1Ivj0DjgD96xqRN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FCI0xYb7fF9+7yX+8ouEiheTGZtzcpQaV6gYz8iPSB2pG4CaxipFhs+BCNtbJqO7G
	 XPg2qb9TGwQCdll4xaJKSPlafdT5i5hlI+MNKTQ1HkLlx5paeUYZZ75tTduNkEC9om
	 h4Uc7X94Eh8ROZXJTir8F4PSVBvWqGxdaJ0h++7gEgGNtrQLUKlScRUBVjxjDWRtmy
	 4T5uYdivA0A6AdruQZ+eGUzG/vMhlptppn6uGenNBcljuOUeG5CX7xQGyCLQ0Pgk1w
	 KW/4nnCOFdYQE2n7Rw0yAX9VCTeeiJc2JKVOJjriQya+iy95k5bRMS6QKKKaokfhVZ
	 PRbIjKH7Hkz5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC3A1405DD;
	Tue, 28 Jul 2026 09:21:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 975462E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89A7981287
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:21:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vGJohzcaCAus for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:21:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CA9F281285
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA9F281285
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA9F281285
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:21:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E9B584873; Tue, 28 Jul 2026 11:21:08 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96C082991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:21:05 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E29260A76;
 Tue, 28 Jul 2026 09:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C891F00A3D;
 Tue, 28 Jul 2026 09:21:03 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 36/75] usb: dwc3: import from kernel v5.12
In-Reply-To: <20260716134305.614278-37-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-37-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:21:01 +0200
Message-ID: <874ihj31xe.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785230464;
 bh=ve2SR/PzPMubSda1GMYd+vJCnNS1Ivj0DjgD96xqRN0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=UDUziE/jDGZSNYc98L+6ZcHm3TPOmed53ljgLbmLnnMWtPEIHDCfcaJaWAtbvW5bx
 z1ZONodscTuY659CLe1HsYRRUjx+lHET6/S6jlIFMYXSmdY9qUlmjLKYB9M7hYo7my
 gGgufHN3ThxPr14zjQr8qOBEc3wQeNDWDN7w3leEUUiwMuz39FmVb5muTls+Mp9cLC
 ccAxSQqQSjVna6MM7mkn10c4yX6ZfqHkmyrO/S9DHbWocU5USv818/TrbytbMXC82j
 sdNHIjkZbBM/4aY67Os8TBJdefTBZjv1bwaEKxi2GjSVQwHMsU2mTKcqkAajBYVXV1
 hfCdJIU8C7aSQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=UDUziE/j
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="UDUziE/j"; 
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
> Sync Linux kernel dwc3 changes from v5.11 to v5.12.
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
> List of commits: git log --oneline v5.11..v5.12
> Commits imported:
> 5aef629704ad usb: dwc3: gadget: Clear DEP flags after stop transfers in ep disable
> b522f830d351 usb: dwc3: pci: Enable dis_uX_susphy_quirk for Intel Merrifield
> 93f1d43c5767 usb: dwc3: gadget: Use max speed if unspecified
> cdb651b6021e usb: dwc3: gadget: Set gadget_max_speed when set ssp_rate
> 5e4010e36a58 usb: dwc3: qcom: skip interconnect init for ACPI probe
> f09ddcfcb8c5 usb: dwc3: gadget: Prevent EP queuing while stopping transfers
> 1cffb1c66499 usb: dwc3: qcom: Add missing DWC3 OF node refcount decrement
> 2664deb09306 usb: dwc3: qcom: Honor wakeup enabled/disabled state
> 1edbff9c80ed usb: dwc3: qcom: add ACPI device id for sc8180x
> 83c4a4eec06a of: Remove of_dev_{get,put}()
> 4b049f55ed95 usb: dwc3: gadget: Fix dep->interval for fullspeed interrupt
> a1679af85b2a usb: dwc3: gadget: Fix setting of DEPCFG.bInterval_m1
> 8cf9045b9138 usb: dwc3: gadget: Remove check for bounded driver
> 450b9e9fabd8 usb: dwc3: gadget: Set speed only up to the max supported
> f551037c0770 usb: dwc3: gadget: Track connected SSP rate and lane count
> 072cab8a0fe2 usb: dwc3: gadget: Implement setting of SSP rate
> 678481467d2e usb: dwc3: core: Check maximum_speed SSP genXxY
> b1638ee56c1a usb: dwc3: host: Use software node API with the properties
> 8dc6e6dd1bee usb: dwc3: qcom: Constify the software node
> efc9812edc61 usb: dwc3: haps: Constify the software node
> c25c210f590e usb: dwc3: qcom: add URS Host support for sdm845 ACPI boot
> f08fc2c30e78 usb: dwc3: pci: add support for the Intel Alder Lake-P
> 73203bde3a95 usb: dwc3: pci: ID for Tiger Lake CPU
> e492ce9bcaa1 usb: dwc3: pci: Register a software node for the dwc3 platform device
> 5dc71f1eb870 USB: dwc3: document gadget_max_speed
> 132ee0da6e9f usb: dwc3: gadget: Disable Vendor Test LMP Received event
> 0c0a20f6da04 usb: dwc3: Simplify with dev_err_probe()
> 370e3d5b711d usb: dwc3: keystone: Simplify with dev_err_probe()
> babbdfc9d229 usb: dwc3: core: Replace devm_reset_control_array_get()
> 7c9a2598463a usb: dwc3: gadget: Preserve UDC max speed setting
> 77adb8bdf422 usb: dwc3: gadget: Allow runtime suspend if UDC unbinded
> 82c46b8ed9dc usb: dwc3: gadget: Introduce a DWC3 VBUS draw callback
> 6dd2565989b4 usb: dwc3: add imx8mp dwc3 glue layer driver
> cb4d9b52ec06 usb: dwc3: drd: Improve dwc3_get_extcon() style
> c824c73a5e08 usb: dwc3: drd: Avoid error when extcon is missing

Drop qcom, host, haps, pci, drd patches from the changelog since we
chose to skip those files.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

