Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5CAC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 10:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C98B080C94;
	Tue,  4 Aug 2026 10:57:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4yyKL99DR0wX; Tue,  4 Aug 2026 10:57:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D406980C88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785841069;
	bh=pVVjY8XSrKNCDlSm8TaFwERJpenggMOyg4AEB1E/Ne0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GoowGHQVOk/ARCJDsVY0C9CrrvU92bH7snQfxnYcNiFmRT/fgh/9gYKgcXYxPDAdi
	 d6cY9QbHeys9BDYZQIqKxOvR9K4YZyDXtU1Y4vTuFnzD3Yyv3/NNKBDB6ppC1UDPT2
	 b095u/aN1orLtr9Z+Sg2Uk+Y0zNEgqPbB96DQrT+3Pem7gcNp4XQ9MiIElGKhmi8FK
	 Sw7LJ2tmtYZemNLlMZjvyoENblpjWF+IlHL5D8+zbLGxCbq7IkFl1yVo+X3PH4VSPu
	 oRoKU+9PKB9+AbyOhr4o4zRJwXR6LyUsiV3/3tyTVhGREAezgTMFDIgiR04AOckNtg
	 fzMMXIcx2DCOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D406980C88;
	Tue,  4 Aug 2026 10:57:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BFCDF2DE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B179180C86
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ekP_lQgMTUmu for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:57:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5A88680C8B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A88680C8B
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A88680C8B
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:43 +0000 (UTC)
X-Forward-Email-ID: 6a71c5a1e481fa9c5d58fa3d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/9] ram: rockchip: rk3568: Simplify get_info() ops
Date: Tue,  4 Aug 2026 10:57:10 +0000
Message-ID: <20260804105721.2402406-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804105721.2402406-1-jonas@kwiboo.se>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785841062; bh=pVVjY8XSrKNCDlSm8TaFwERJpenggMOyg4AEB1E/Ne0=;
 b=rKR61MW/vR2GFTmLLLWnRzyiegEJiZfJG2mAmQINWEQGyWV51bsu/7vqI6aenN/Sz3YcG+dMT
 glVBbc+uU5rH3c7EqVw3/EqdIlERv0lVwSbNHUCSx4d4oDuRca840bYLugsQCCyQOD3mCJk1/lc
 3b6IkKgIEU16BTb9V+B3/R0r9eKZAa+XUHiRRnBq6hTGcEq90fRYXZObp2/4ABJZ1Fsosv1CwFV
 bf0eqHFJE01BLBXqYbv58gcyakD+0Kor+U+lCJnC+HPkxQjWLzy7hITE/WmoL09hyu06K/9V0/T
 aGzLO6qDIuF/twTHxn1Y6hCkj9IjDyswRNLySLNP79Kw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=rKR61MW/
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

The PMUGRF base address is fixed and known at compile time. However,
the base address is read from DT at runtime in this driver, delaying
reading the two HW regs to determine RAM size by several ms.

Change to use a constant for the PMUGRF base address to speed up reading
RAM size and simplify the driver by removing use of probe and private
data. The driver list entry name is also renamed to match the
compatible, for possible use with OF_PLATDATA.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/ram/rockchip/sdram_rk3568.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3568.c b/drivers/ram/rockchip/sdram_rk3568.c
index a252d5c70106..d768b849a0f7 100644
--- a/drivers/ram/rockchip/sdram_rk3568.c
+++ b/drivers/ram/rockchip/sdram_rk3568.c
@@ -3,36 +3,19 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd.
  */
 
-#include <config.h>
 #include <dm.h>
 #include <ram.h>
-#include <syscon.h>
-#include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3568.h>
 #include <asm/arch-rockchip/sdram.h>
 
-struct dram_info {
-	struct ram_info info;
-	struct rk3568_pmugrf *pmugrf;
-};
-
-static int rk3568_dmc_probe(struct udevice *dev)
-{
-	struct dram_info *priv = dev_get_priv(dev);
-
-	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
-	priv->info.base = CFG_SYS_SDRAM_BASE;
-	priv->info.size =
-		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->pmu_os_reg2);
-
-	return 0;
-}
+#define PMUGRF_BASE			0xfdc20000
 
 static int rk3568_dmc_get_info(struct udevice *dev, struct ram_info *info)
 {
-	struct dram_info *priv = dev_get_priv(dev);
+	static struct rk3568_pmugrf * const pmugrf = (void *)PMUGRF_BASE;
 
-	*info = priv->info;
+	info->base = CFG_SYS_SDRAM_BASE;
+	info->size = rockchip_sdram_size((phys_addr_t)&pmugrf->pmu_os_reg2);
 
 	return 0;
 }
@@ -46,11 +29,9 @@ static const struct udevice_id rk3568_dmc_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(dmc_rk3568) = {
+U_BOOT_DRIVER(rockchip_rk3568_dmc) = {
 	.name = "rockchip_rk3568_dmc",
 	.id = UCLASS_RAM,
 	.of_match = rk3568_dmc_ids,
 	.ops = &rk3568_dmc_ops,
-	.probe = rk3568_dmc_probe,
-	.priv_auto = sizeof(struct dram_info),
 };
-- 
2.54.0

