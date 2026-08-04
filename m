Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1FAC5518F
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 10:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21CBB4073C;
	Tue,  4 Aug 2026 10:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s2PnT1OgVvN8; Tue,  4 Aug 2026 10:57:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD96740733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785841075;
	bh=AUtmazXP6HGDssEegnBg/jpqGdzNS/y93uPnHUrC12w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q4J8nNmhwQwH2cZPk2QSL47PS3tSdLU5nLx2tLWAvWzsUj2a6arq+CTafU5g5gnT9
	 LLv7BI3I1F2xV5SrLZ+XVccqVvTymByB01b2C6NKLHW+UAxJJa5mXRp2f1MDzA7Hz6
	 P9HxSk34kXerxsBbjPyCFYtkbHGilZgL8HqqWVb0HXCBvn1w9xCESuSaASiX80iQXx
	 eG3QRfJkm4R4DiyzW2KFMwFXX1DpSquOHkDrV80Kuz0CELcqK+5QmxJYsdXZ8UPdhd
	 2wp1B8UlJ2uEhYVGpsD4wYXFMCYCV/GSxqPgakjDcGYl2qT0yF7prA+S8UVl7t1kgy
	 WON5879wqPbVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD96740733;
	Tue,  4 Aug 2026 10:57:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5272350
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B704980CAE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ElRGQ7vs9V1C for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:57:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A92C680C8D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A92C680C8D
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A92C680C8D
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:52 +0000 (UTC)
X-Forward-Email-ID: 6a71c5aae481fa9c5d58facf
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
Subject: [PATCH 4/9] rockchip: rk3568: Remove unneeded syscon driver
Date: Tue,  4 Aug 2026 10:57:13 +0000
Message-ID: <20260804105721.2402406-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804105721.2402406-1-jonas@kwiboo.se>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785841071; bh=AUtmazXP6HGDssEegnBg/jpqGdzNS/y93uPnHUrC12w=;
 b=rzFVAXGHpETkd1Man/wwLG1zTXduIcKUMFq98IxVoUD/0sHCLdT38/xx5kdSbKa83G+e2pCYl
 snJ7CJnVO3uoZE17HklHpySjNe9prJKT+kNf6uY4thyQ/mlOA3Or1RK406AKco/RrQyS4Rk7VDh
 /8bq96cSId54lkKjcktZwKsA+4q/gWaHVcxOq4V+FmEvrN5n6BamU//m65bYAqlzY78jp4u4RGF
 vJk3hp5PPMXxkvX70HAJzOszt3MiicTEjxPA76fp7w1RUwPQ9dc2byvQbosypopDt44Y7EHM3S7
 uLxDeYr/RagsNXihBHyTo7IA4m6cLCqn2azimr5fB9fg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=rzFVAXGH
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

Remove the unneeded RK3568 syscon driver to discourage new uses of
syscon_get_regmap_by_driver_data() or syscon_get_first_range().

The generic_syscon driver will instead be used for the compatible
previously matched by the now removed driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3568/Makefile        |  1 -
 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c | 23 -------------------
 2 files changed, 24 deletions(-)
 delete mode 100644 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c

diff --git a/arch/arm/mach-rockchip/rk3568/Makefile b/arch/arm/mach-rockchip/rk3568/Makefile
index 28c1f4ee5c9b..610d2a015587 100644
--- a/arch/arm/mach-rockchip/rk3568/Makefile
+++ b/arch/arm/mach-rockchip/rk3568/Makefile
@@ -6,4 +6,3 @@
 
 obj-y += clk_rk3568.o
 obj-y += rk3568.o
-obj-y += syscon_rk3568.o
diff --git a/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c b/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
deleted file mode 100644
index 255259eabfda..000000000000
--- a/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2021 Rockchip Electronics Co., Ltd
- */
-
-#include <dm.h>
-#include <syscon.h>
-#include <asm/arch-rockchip/clock.h>
-
-static const struct udevice_id rk3568_syscon_ids[] = {
-	{ .compatible = "rockchip,rk3568-grf", .data = ROCKCHIP_SYSCON_GRF },
-	{ .compatible = "rockchip,rk3568-pmugrf", .data = ROCKCHIP_SYSCON_PMUGRF },
-	{ }
-};
-
-U_BOOT_DRIVER(syscon_rk3568) = {
-	.name = "rk3568_syscon",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3568_syscon_ids,
-#if CONFIG_IS_ENABLED(OF_REAL)
-	.bind = dm_scan_fdt_dev,
-#endif
-};
-- 
2.54.0

