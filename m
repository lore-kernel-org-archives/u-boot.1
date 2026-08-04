Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C669C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 10:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DBBE40750;
	Tue,  4 Aug 2026 10:58:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JofMtUYQmsI9; Tue,  4 Aug 2026 10:58:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19C9E4070A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785841081;
	bh=SmGNQJ1CozqpGHhX8S6R+2JYbwouHF+kx9uvY430C4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aB3yiUL0gSjRcLBx5u1XBBygh5nYN+SHy9+2rRvU/u6SKcy1Lt6dJis9FiAko3nUS
	 7knfKhk2ORzzD6jXheNXv9RtUp3W+g6VInh3ioPbSUfsdAD8q32GI2dsjAYvk3HF2H
	 dbFmIzJNqvmz1T5VYl30H1O1P82R6yG0yG/PuAesv6pFKL9QLgEc8qs8gFQZrm/EJA
	 uWrMulp9Qxh4Oa4iJzIlU+4umIP12iSCFiQ33dCp1Qo4miKDz34eWpLUAy6HpP7A1k
	 mxdAITQWeotnTwmGzrPQMNFtqydbBLDkSM70wbK4q6hImDDLhYdOWZ6TTctjKF7ipm
	 U0pCUghu8pXwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19C9E4070A;
	Tue,  4 Aug 2026 10:58:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE66F2DE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE28980CD2
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s3D-asWl78Hy for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:57:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4B51580CB6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B51580CB6
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B51580CB6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:57 +0000 (UTC)
X-Forward-Email-ID: 6a71c5b3e481fa9c5d58fb4f
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
Subject: [PATCH 7/9] rockchip: rk3528: Remove unneeded syscon driver
Date: Tue,  4 Aug 2026 10:57:16 +0000
Message-ID: <20260804105721.2402406-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804105721.2402406-1-jonas@kwiboo.se>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785841076; bh=SmGNQJ1CozqpGHhX8S6R+2JYbwouHF+kx9uvY430C4o=;
 b=YT/x47bETyxPOC/5ltTAU9T/+Wg2XIRm7hMaPbzdvoHNs7p26gAxyHzl0WOoaHMZGT/O1VeOr
 F44FQi/DUO8qpAmJNN+ULtiCeKnclQm3ZonTemDZYiVyZzPX6kvCzahJ3+evIXsDltY9TgAfzxq
 bCcEcW6ZkJbj6bmvRF1+fPQ0pzs+rkbxIc2U6RhglW5n1Pso5sgvt0cEylB6onXur5nQON1mjGz
 pbE5qs+8sIrHFNfddsq0AtcGbqPGqL5KNunAyXoFcgPec5vf2SmPhTPCexePOh3H7UObJZeY4Yu
 vYWiQKiU2cbc/lqzr4q8e/3PkWl9UOYLViZ3lWTuseMg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YT/x47bE
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

Remove the unneeded RK3528 syscon driver to discourage new uses of
syscon_get_regmap_by_driver_data() or syscon_get_first_range().

The generic_syscon driver will instead be used for the compatible
previously matched by the now removed driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3528/Makefile        |  1 -
 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c | 19 -------------------
 2 files changed, 20 deletions(-)
 delete mode 100644 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c

diff --git a/arch/arm/mach-rockchip/rk3528/Makefile b/arch/arm/mach-rockchip/rk3528/Makefile
index f0c18cd39d29..150536f59025 100644
--- a/arch/arm/mach-rockchip/rk3528/Makefile
+++ b/arch/arm/mach-rockchip/rk3528/Makefile
@@ -2,4 +2,3 @@
 
 obj-y += rk3528.o
 obj-y += clk_rk3528.o
-obj-y += syscon_rk3528.o
diff --git a/arch/arm/mach-rockchip/rk3528/syscon_rk3528.c b/arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
deleted file mode 100644
index 4a32a5f732e9..000000000000
--- a/arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-// Copyright Contributors to the U-Boot project.
-
-#include <dm.h>
-#include <asm/arch-rockchip/clock.h>
-
-static const struct udevice_id rk3528_syscon_ids[] = {
-	{ .compatible = "rockchip,rk3528-grf", .data = ROCKCHIP_SYSCON_GRF },
-	{ }
-};
-
-U_BOOT_DRIVER(rockchip_rk3528_syscon) = {
-	.name = "rockchip_rk3528_syscon",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3528_syscon_ids,
-#if CONFIG_IS_ENABLED(OF_REAL)
-	.bind = dm_scan_fdt_dev,
-#endif
-};
-- 
2.54.0

