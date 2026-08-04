Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20D4C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 10:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3DDB80CBF;
	Tue,  4 Aug 2026 10:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n5xpxXWDTOU7; Tue,  4 Aug 2026 10:57:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5BF980CAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785841076;
	bh=qKWSt4/JyVGxyOJhTiDD+KdWiBGgl7WjMjwRBHpM6Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ueFVUvoUtANC7WMwrvU3Ze+hczY9/1/m5gQICGnDDfAUD0T27lL4EmMUlNv2kRv5W
	 5XGf2zBJsoIiH5YLD8kW59sJ+CLwT3imJUMXnd1Orz13il6dVd3m/r6vvpvhAmBpuo
	 TOX78jjQXfDQyXSC3/Gs7eQDGXeJWWGhPF30VMXTJJgkeQn76h0Qll4yc8MHp1f3nK
	 dIFLc2Sb4k0T156Y3mPjR5d/lT8aEUTlz3DXIb1CSuJ6UhWWz3ujtjF7czAoVt1fyb
	 9ZtiV6Jdn2HS0wbTWYl3KlkzxVgbGIwaXPDcqAbunR6f2hsIslSrdM9/kAKFmmU/IE
	 GOzmdqeNjYKLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5BF980CAE;
	Tue,  4 Aug 2026 10:57:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A772D2DE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9957780C8D
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K-jyPEnxLugf for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:57:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BEC6C80CA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BEC6C80CA9
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BEC6C80CA9
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:52 +0000 (UTC)
X-Forward-Email-ID: 6a71c5ade481fa9c5d58faef
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 5/9] rockchip: rk3588: Remove unneeded syscon driver
Date: Tue,  4 Aug 2026 10:57:14 +0000
Message-ID: <20260804105721.2402406-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804105721.2402406-1-jonas@kwiboo.se>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785841071; bh=qKWSt4/JyVGxyOJhTiDD+KdWiBGgl7WjMjwRBHpM6Q4=;
 b=FkkR/GzB9Hz0pfbsJHokFdKtVG5FjbR0Eaz+DnTrBJCmophMe3PpFaJ0fXdzqS+uiqTiwxbsJ
 Yt41CRLjNHCOHAU9JzSkwi/m/bistotKqkgo8csFlYNxGjFxT3mJ+6E9IPjHra5XOcxv+WznUUs
 AChp/v3kQSkC4sbgzIZqzAGJfXPRfAmTC8wgIp26XLXeUHf8j8Yaw2LIy2HeBXVMwnZ4Wfhdxe0
 mlXwL4QrNDPjn4vqNWWMcmJ5UJ33N7I6Pb4t66iO/0Gr7WIsgQVi7488c53U5zpYJs6jMIZho5H
 QEq7D6bHhCJ5CANRDlxN2ywfX8qFxMG0qbgzD5NrSI4w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=FkkR/GzB
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

Modern Rockchip device drivers use syscon_regmap_lookup_by_phandle()
to get a regmap or use a constant to get the fixed base address.

Remove the unneeded RK3588 syscon driver to discourage new uses of
syscon_get_regmap_by_driver_data() or syscon_get_first_range().

The generic_syscon driver will instead be used for the compatible
previously matched by the now removed driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3588/Makefile        |  1 -
 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c | 31 -------------------
 2 files changed, 32 deletions(-)
 delete mode 100644 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c

diff --git a/arch/arm/mach-rockchip/rk3588/Makefile b/arch/arm/mach-rockchip/rk3588/Makefile
index 4003eea87a11..576ed06a2eca 100644
--- a/arch/arm/mach-rockchip/rk3588/Makefile
+++ b/arch/arm/mach-rockchip/rk3588/Makefile
@@ -6,4 +6,3 @@
 
 obj-y += rk3588.o
 obj-y += clk_rk3588.o
-obj-y += syscon_rk3588.o
diff --git a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c b/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
deleted file mode 100644
index f86567fcaf4f..000000000000
--- a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2021 Rockchip Electronics Co., Ltd
- */
-
-#include <dm.h>
-#include <syscon.h>
-#include <asm/arch-rockchip/clock.h>
-
-static const struct udevice_id rk3588_syscon_ids[] = {
-	{ .compatible = "rockchip,rk3588-sys-grf", .data = ROCKCHIP_SYSCON_GRF },
-	{ .compatible = "rockchip,rk3588-pmugrf",  .data = ROCKCHIP_SYSCON_PMUGRF },
-	{ .compatible = "rockchip,rk3588-vop-grf", .data = ROCKCHIP_SYSCON_VOP_GRF },
-	{ .compatible = "rockchip,rk3588-vo-grf",  .data = ROCKCHIP_SYSCON_VO_GRF },
-	{ .compatible = "rockchip,pcie30-phy-grf", .data = ROCKCHIP_SYSCON_PCIE30_PHY_GRF },
-	{ .compatible = "rockchip,rk3588-php-grf", .data = ROCKCHIP_SYSCON_PHP_GRF },
-	{ .compatible = "rockchip,pipe-phy-grf",   .data = ROCKCHIP_SYSCON_PIPE_PHY0_GRF },
-	{ .compatible = "rockchip,pipe-phy-grf",   .data = ROCKCHIP_SYSCON_PIPE_PHY1_GRF },
-	{ .compatible = "rockchip,pipe-phy-grf",   .data = ROCKCHIP_SYSCON_PIPE_PHY2_GRF },
-	{ .compatible = "rockchip,rk3588-pmu",     .data = ROCKCHIP_SYSCON_PMU },
-	{ }
-};
-
-U_BOOT_DRIVER(syscon_rk3588) = {
-	.name = "rk3588_syscon",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3588_syscon_ids,
-#if CONFIG_IS_ENABLED(OF_REAL)
-	.bind = dm_scan_fdt_dev,
-#endif
-};
-- 
2.54.0

