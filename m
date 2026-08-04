Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7EEC5518F
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 10:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28AE76077E;
	Tue,  4 Aug 2026 10:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MDe2bsOBAPo0; Tue,  4 Aug 2026 10:58:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5590860756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785841086;
	bh=g0p5F0ug/rrjD66vRnNaFUxPTyrn/JyhyP0cewf7rI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/g8d1BjPSidm7b28TjoyTQQocjAzuaK7b/1IjNZQZ4VDGhth6h7IFTAbt68Pw8wp
	 bNFrp5qgG2Ipqzh3sHkTQ7oAUcPwaEzs/UFBEdVPIvsojVQhSh0JJUpVVMwfLAbNt7
	 by4Klwtuaqk7RaHUgT+N4BCJFDkK6yidJZzxY3ADE5qpbxh9PnBBMsJdfFgbo+llVm
	 q2VP/JTC/RZWuVVqN95WueZpjhNChf11UT2GgkH0JOKxtzOJFZeCFtKJSlZgs51VpU
	 73c4/lCNYtVSXG4TX3FS+WiRkR6Xlm7jLHFX4/sBlzzAPGX+Wme/902ro8mc3H9vv5
	 w/hzQUL8NlsbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5590860756;
	Tue,  4 Aug 2026 10:58:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 50067296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 363E180CA9
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LfsGyW8OUw39 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:58:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5B36480CA8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B36480CA8
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B36480CA8
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:58:02 +0000 (UTC)
X-Forward-Email-ID: 6a71c5b6e481fa9c5d58fb6d
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
Subject: [PATCH 8/9] rockchip: rk3506: Remove unneeded syscon driver
Date: Tue,  4 Aug 2026 10:57:17 +0000
Message-ID: <20260804105721.2402406-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804105721.2402406-1-jonas@kwiboo.se>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785841081; bh=g0p5F0ug/rrjD66vRnNaFUxPTyrn/JyhyP0cewf7rI0=;
 b=i7A/+OACmO/OpN+2LteiCHbh9Arg7bvH1mjhjfFNeMD792pysHBOPi4mD8ayW4RgeZoMVw6lL
 9ynMb8YFtdG0td/ueaMhDPp6a+kHUDN0lz5wWnK7b/CiHAyi3YuGKd/6yLx1JHf8EeRTkTQpCP/
 EEinbrmXLRLjHYGyxjhRlW0dj+0vCC2rENo62wFnaZ46ucqIQr/a9IX25sICCJgCsKdzgGegiFC
 hDGLbR9Fmb/htHxBSkls2eN8NSaczq2RHd47j32yL9CWD2JJg6vMR4pouds0eiwyLkyeEj3+vgC
 peanZ50LOrg87PyKkGjA5uVNLvfdAw3vuXu/FyMvOj9Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=i7A/+OAC
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

Remove the unneeded RK3506 syscon driver to discourage new uses of
syscon_get_regmap_by_driver_data() or syscon_get_first_range().

The generic_syscon driver will instead be used for the compatible
previously matched by the now removed driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3506/Makefile        |  1 -
 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c | 19 -------------------
 2 files changed, 20 deletions(-)
 delete mode 100644 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c

diff --git a/arch/arm/mach-rockchip/rk3506/Makefile b/arch/arm/mach-rockchip/rk3506/Makefile
index a1760bd0f0a3..63a6c2c2d18d 100644
--- a/arch/arm/mach-rockchip/rk3506/Makefile
+++ b/arch/arm/mach-rockchip/rk3506/Makefile
@@ -2,4 +2,3 @@
 
 obj-y += rk3506.o
 obj-y += clk_rk3506.o
-obj-y += syscon_rk3506.o
diff --git a/arch/arm/mach-rockchip/rk3506/syscon_rk3506.c b/arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
deleted file mode 100644
index 2548b0fa2d3a..000000000000
--- a/arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-// Copyright Contributors to the U-Boot project.
-
-#include <dm.h>
-#include <asm/arch-rockchip/clock.h>
-
-static const struct udevice_id rk3506_syscon_ids[] = {
-	{ .compatible = "rockchip,rk3506-grf", .data = ROCKCHIP_SYSCON_GRF },
-	{ }
-};
-
-U_BOOT_DRIVER(rockchip_rk3506_syscon) = {
-	.name = "rockchip_rk3506_syscon",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3506_syscon_ids,
-#if CONFIG_IS_ENABLED(OF_REAL)
-	.bind = dm_scan_fdt_dev,
-#endif
-};
-- 
2.54.0

