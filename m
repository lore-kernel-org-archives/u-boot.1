Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD4AC5518F
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 10:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAC2B60760;
	Tue,  4 Aug 2026 10:58:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CoN9IjM-6efb; Tue,  4 Aug 2026 10:58:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E61AE60741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785841080;
	bh=OtJiyjazXCrUg4MPBB7JaIIy+Z5kxxTiSnTFl1uOVLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VANZNNoud90cTRQeroAbsjon89aCYm2QFlZJzr17eVc1rhGWTMgGfxE2zYhWHcgO6
	 HsECArANgJo3oIIBup4mgvX9b+jm0UbaT0s2Qrz//yoUY34H+2v+jhkpnzJcLzWf2R
	 HL4PP98dd15+RjeqkN0SQQdl+/1IJB3dohu4oyNiDeY1/rTA3kisqCKqmSRmPFBKTP
	 bptzUDVQCYHk9adQ45vI3xg6u3r6AmnFERBxwd2dJhPp91c4to7eT7VwDTDhclly6+
	 ztWGojl6zzzji5N1crl422AIRUbq4quD+7tlBR0Yy7oHF2tz5o81zwxTJaCYBSE5LL
	 BQcaxJpjMy0NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E61AE60741;
	Tue,  4 Aug 2026 10:57:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 550462DE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51C7F80CAE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DhD_6rTLgIGb for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:57:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2BAF580CA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BAF580CA9
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BAF580CA9
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:57 +0000 (UTC)
X-Forward-Email-ID: 6a71c5b0e481fa9c5d58fb1f
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
Subject: [PATCH 6/9] rockchip: rk3576: Remove unneeded syscon driver
Date: Tue,  4 Aug 2026 10:57:15 +0000
Message-ID: <20260804105721.2402406-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804105721.2402406-1-jonas@kwiboo.se>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785841076; bh=OtJiyjazXCrUg4MPBB7JaIIy+Z5kxxTiSnTFl1uOVLE=;
 b=tGdFvHV3kmf+lfUs9kTlpc7gErsKIbYXM9Re6IrlEz5L0D0p1Xezes/8wUQD53KAEOtMLkw71
 FMZNQy7mv+G26wm/44mE0JanARuvglMZPjVdLsP1OIK/lQmB9X8HkOu5iLNTaybfDsa+Js7yvc3
 /YPcWJomHicJqelRa7djvpWqw9uZFQwSf7+bUW0Sgf2/IMhNm0NlparURcydYHOoc9BiCTh0wXi
 CEaEePF6gGwmykXE8LiTwfyiDaAF9xrsWpE0y/SxAf8oq7dXE36/RZVr39aWLYu+wEiKjHSj6NC
 oOf7e+BzNVcD9T2BqOsWLkWf5ADdusKwo7oTwFRNlJXw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tGdFvHV3
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

Remove the unneeded RK3576 syscon driver to discourage new uses of
syscon_get_regmap_by_driver_data() or syscon_get_first_range().

The generic_syscon driver will instead be used for the compatible
previously matched by the now removed driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3576/Makefile        |  1 -
 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c | 22 -------------------
 2 files changed, 23 deletions(-)
 delete mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c

diff --git a/arch/arm/mach-rockchip/rk3576/Makefile b/arch/arm/mach-rockchip/rk3576/Makefile
index cbc58257deba..bd7399cddaac 100644
--- a/arch/arm/mach-rockchip/rk3576/Makefile
+++ b/arch/arm/mach-rockchip/rk3576/Makefile
@@ -6,4 +6,3 @@
 
 obj-y += rk3576.o
 obj-y += clk_rk3576.o
-obj-y += syscon_rk3576.o
diff --git a/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c b/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
deleted file mode 100644
index 0dbf8f8d9c09..000000000000
--- a/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * (C) Copyright 2023 Rockchip Electronics Co., Ltd
- */
-
-#include <dm.h>
-#include <asm/arch-rockchip/clock.h>
-
-static const struct udevice_id rk3576_syscon_ids[] = {
-	{ .compatible = "rockchip,rk3576-sys-grf", .data = ROCKCHIP_SYSCON_GRF },
-	{ .compatible = "rockchip,rk3576-pmu1-grf",  .data = ROCKCHIP_SYSCON_PMUGRF },
-	{ }
-};
-
-U_BOOT_DRIVER(rockchip_rk3576_syscon) = {
-	.name = "rockchip_rk3576_syscon",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3576_syscon_ids,
-#if CONFIG_IS_ENABLED(OF_REAL)
-	.bind = dm_scan_fdt_dev,
-#endif
-};
-- 
2.54.0

