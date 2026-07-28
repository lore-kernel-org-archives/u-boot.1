Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6785CC54EFC
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 08:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFE0C812E6;
	Tue, 28 Jul 2026 08:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HV6pzMHgNAWm; Tue, 28 Jul 2026 08:51:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1ED61812E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785228672;
	bh=cvE64aXT2RSZ0cSgG1dJJOiiqDyGes5Ezq/yh322bZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wpJaW1tdkOiApD2o2xRBpS/P3qz4lZH3Xr4ZS6oW9If8d5agAyW2o5aWBo+HqXFom
	 ozS9bvMC11DKY0daUGbQIhXCr7udl8DU3fOVPHnG9krPR2OWPaBsggUxPxhIU4eUbw
	 TlH/cPggG9A84F4uZFRfHiTPbDkc8MPfB4Wq1rKd42alM8G6FAX4sknpKvdtD4KbNE
	 C544TiCd1KljjhhiGCj+vHCoUXR0a5y1PfUwDwG/vQOxEaiML6iKKTWcZ8Zz0DrJQL
	 NyMD50zT9Of6WX6wtVTI18ennfTAIOEXRfQhYW7doJvp0bTjUJzxCW4ShGYu8Ak5/u
	 AwKEbZxiMjLJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1ED61812E3;
	Tue, 28 Jul 2026 08:51:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F21DE36E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8132405AC
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N1bTH4qQ2bYT for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 08:51:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7C07D40585
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C07D40585
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C07D40585
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:51:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 208AD84873; Tue, 28 Jul 2026 10:51:07 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43DCC82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 10:51:04 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87AB54148F;
 Tue, 28 Jul 2026 08:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F541F00A3A;
 Tue, 28 Jul 2026 08:51:00 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 31/75] usb: dwc3: import from kernel v5.7
In-Reply-To: <20260716134305.614278-32-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-32-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 10:50:58 +0200
Message-ID: <87ik5z33bh.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785228661;
 bh=cvE64aXT2RSZ0cSgG1dJJOiiqDyGes5Ezq/yh322bZE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=dowtV28vv5umhb0nUlXIPaaFQHrCKWoTqwT4i6jea/GCAvFxNdER31jXBTwsbGLky
 AB4RHhJIePdCqsFBNIdvSeDssjSeeARomj5xCdqfMu5Qt0igwez17MGdT1GxoF19lC
 Q/j3fwy9t7YcVuGsFOf/po0XGOvGIQV3uKDWVAYADxCu0sOqZZzpegwBRDocCKr/M6
 n8fNfF5G3Kgij1B2P/t1zVKJUGoSFlG2QBu+6ad3JT+bLZ1JMr9EWWyfIkMbGESDlq
 pIuPGGWn6ol3hG7Nd+2O4ApqhbVO23QhJLf07z6X9chkGhny3xmH+lH0L9hiZP+eZX
 fJiF6ZnSKGT1A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dowtV28v
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="dowtV28v"; 
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
> Sync Linux kernel dwc3 changes from v5.6 to v5.7.
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
> List of commits: git log --oneline v5.6..v5.7
> Commits imported:
> 4748d396399a usb: dwc3: select USB_ROLE_SWITCH
> 066c09593454 usb: dwc3: pci: Enable extcon driver for Intel Merrifield
> 00e21763f2c8 dwc3: Remove check for HWO flag in dwc3_gadget_ep_reclaim_trb_sg()
> 49e0590e3a60 usb: dwc3: gadget: Fix request completion check
> d0550cd20e52 usb: dwc3: gadget: Do link recovery for SS and SSP
> d94ea5319813 usb: dwc3: gadget: Properly set maxpacket limit
> 586f4335700f usb: dwc3: Fix GTXFIFOSIZ.TXFDEP macro name
> 0339f7fbc82e usb: dwc3: fix up for role switch API change
> 201c26c08db4 usb: dwc3: qcom: Replace <linux/clk-provider.h> by <linux/of_clk.h>
> 0227cc84c444 usb: dwc3: core: don't do suspend for device mode if already suspended
> 4a1d042af420 usb: dwc3: Rework resets initialization to be more flexible
> 0d3a97083e0c usb: dwc3: Rework clock initialization to be more flexible
> 98ed256a4dba usb: dwc3: Add support for role-switch-default-mode binding
> 8a0a13799744 usb: dwc3: Registering a role switch in the DRD code.
> 7ba6b09fda5e usb: dwc3: core: add support for disabling SS instances in park mode
> 2dedea035ae8 usb: dwc3: gadget: Wrap around when skip TRBs
> a114c4ca64bd usb: dwc3: gadget: Don't clear flags before transfer ended
> a33e5d639c9b usb: dwc3: Remove kernel doc annotation where it's not needed
> 11c39809070f usb: dwc3: Add ACPI support for xHCI ports
> 07f6842341ab usb: dwc3: exynos: Add support for Exynos5422 suspend clk
> 238d76021654 usb: dwc3: meson-g12a: Don't use ret uninitialized in dwc3_meson_g12a_otg_init
> 1e355f21d3fb usb: dwc3: Add Amlogic A1 DWC3 glue
> 30ad6273adad usb: dwc3: trace: print enqueue/dequeue pointers too
> bce3052f0c16 usb: roles: Provide the switch drivers handle to the switch in the API
> 882f7a4dae1d usb: dwc3: qcom: Replace <linux/clk-provider.h> by <linux/of_clk.h>
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

