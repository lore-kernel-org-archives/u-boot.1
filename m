Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC02C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 10:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 586F7605EB;
	Tue,  4 Aug 2026 10:57:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RhvsjwSE2VGB; Tue,  4 Aug 2026 10:57:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9626160747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785841066;
	bh=seHnUV5t0SBbHylUAzDoti9RpgEh7THpr9g8velhDHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rTunAAmxDK7Y6Pn0qevwgMmtGk+/RTpIN6Sb2OQfsrpxcDlICkZWoEzQS/5QFba50
	 P7+iDl53mImmzeuzv+EwHeWof5Cb1NCulLnXoV3I0mR4ZCPb7MAjzX2HJGnCboCTor
	 mMffYrmysoCgfura2HtcHfAXj2DY/685oFSFox4B78QH+XVbleyb8r+UBL3JjITJnC
	 +of7HF6ha3uDfKnuzCrkxDq8zkeBXf2qUi6PN8X9zq/R/tarJ0nG2fRpNKtPULnhzk
	 oyvIQuH5GBv9UpwEHqE1GGCTrzcosiUJNnaftlpf3Wce9/HpKKq4YJej0LTon/Z75D
	 7/uSSpGlHJpAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9626160747;
	Tue,  4 Aug 2026 10:57:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 120C42DE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03E3580C8D
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0rYRyloGJ7KW for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:57:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 54B1380C86
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54B1380C86
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54B1380C86
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:42 +0000 (UTC)
X-Forward-Email-ID: 6a71c5a4e481fa9c5d58fa7f
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
Subject: [PATCH 2/9] ram: rockchip: rk3588: Simplify get_info() ops
Date: Tue,  4 Aug 2026 10:57:11 +0000
Message-ID: <20260804105721.2402406-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804105721.2402406-1-jonas@kwiboo.se>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785841062; bh=seHnUV5t0SBbHylUAzDoti9RpgEh7THpr9g8velhDHw=;
 b=Z6roNMjX+rmRXfHBuirnCUG3kADTk7uJYTpuVZwVJcIQQPf4N5f7Sk35eG5jpcpNJFNUECDD9
 P2oDlPKGgi617ft9GyGgjSvXk2xS8DOPf89Z9niiPrs+oXytEQuPbx2JwXSr8tWsk4/899oxpN/
 owSZsUI4QZCcsYc45WTd8TDGaGS/MENFx8vM/I87bAtzRHybqYTF2Ey+wHSd+htKu3rHC+GkgDU
 6wbx8DNvp+cGs6dyLyf3XLX9jQms3xu40ixSOptz5pCU8T4iSIUQXpAn3mnNmKbbAymYcFA98rC
 d81/mebx1jfoyZGKcyePzQhGcZuQIY1fJEQQ62Xu1sUA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Z6roNMjX
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

The PMU1GRF base address is fixed and known at compile time. However,
the base address is read from DT at runtime in this driver, delaying
reading the four HW regs to determine RAM size by several ms.

Change to use a constant for the PMU1GRF base address to speed up
reading RAM size and simplify the driver by removing use of probe and
private data. The driver list entry name is also renamed to match the
compatible, for possible use with OF_PLATDATA.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/ram/rockchip/sdram_rk3588.c | 31 ++++++-----------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3588.c b/drivers/ram/rockchip/sdram_rk3588.c
index a144b432d76f..c572f602630a 100644
--- a/drivers/ram/rockchip/sdram_rk3588.c
+++ b/drivers/ram/rockchip/sdram_rk3588.c
@@ -3,37 +3,20 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd.
  */
 
-#include <config.h>
 #include <dm.h>
 #include <ram.h>
-#include <syscon.h>
-#include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3588.h>
 #include <asm/arch-rockchip/sdram.h>
 
-struct dram_info {
-	struct ram_info info;
-	struct rk3588_pmu1grf *pmugrf;
-};
-
-static int rk3588_dmc_probe(struct udevice *dev)
-{
-	struct dram_info *priv = dev_get_priv(dev);
-
-	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
-	priv->info.base = CFG_SYS_SDRAM_BASE;
-	priv->info.size =
-		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg[2]) +
-		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg[4]);
-
-	return 0;
-}
+#define PMU1GRF_BASE			0xfd58a000
 
 static int rk3588_dmc_get_info(struct udevice *dev, struct ram_info *info)
 {
-	struct dram_info *priv = dev_get_priv(dev);
+	static struct rk3588_pmu1grf * const pmugrf = (void *)PMU1GRF_BASE;
 
-	*info = priv->info;
+	info->base = CFG_SYS_SDRAM_BASE;
+	info->size = rockchip_sdram_size((phys_addr_t)&pmugrf->os_reg[2]) +
+		     rockchip_sdram_size((phys_addr_t)&pmugrf->os_reg[4]);
 
 	return 0;
 }
@@ -47,11 +30,9 @@ static const struct udevice_id rk3588_dmc_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(dmc_rk3588) = {
+U_BOOT_DRIVER(rockchip_rk3588_dmc) = {
 	.name = "rockchip_rk3588_dmc",
 	.id = UCLASS_RAM,
 	.of_match = rk3588_dmc_ids,
 	.ops = &rk3588_dmc_ops,
-	.probe = rk3588_dmc_probe,
-	.priv_auto = sizeof(struct dram_info),
 };
-- 
2.54.0

