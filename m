Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77B2C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7781A80D22;
	Tue,  4 Aug 2026 21:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1hq2pera3NzV; Tue,  4 Aug 2026 21:45:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C126980D39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785879901;
	bh=7GixSGvWurvFAdLOcY3W9riMihw78mZRSq+QVtjg0jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pj6jUE8QKY7EOFpKQRVfjSaGxL70s8/4uxXMq7KRVfcavHjN5smvpezWW3Bqnn/qp
	 DfmanndGfLIE8ou0LSHkykLFdF2nr7wHy4Qfk7BLJMi5QAGkOZ2tnimUdp+mZrv6dj
	 gH1wZ+g8fLhyQf7j9zhR8sZTJHhEUyg1JBkzziZgyKV16yH0j0k7Byv6CIGCcYhgsz
	 ZZ04Uo2WR6ZeJGZAfHAfldfCQJeXoZucjzoFILc3fx61g2ABdMwqA0CT3xidfeE7xb
	 HrUg4JemjdHamk/VAxkqqm0hlAAUqk6lNIYpEgMmMcKUYVjJrUNfgUxNaQ8okiBl6h
	 Gs4yOvbOBQWmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C126980D39;
	Tue,  4 Aug 2026 21:45:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E19E43FB
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D038340571
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AKa0SKECL3kS for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:44:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0FA214059E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FA214059E
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FA214059E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:57 +0000 (UTC)
X-Forward-Email-ID: 6a725d5896269bde08304508
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.5
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
Subject: [PATCH 03/10] rockchip: rk3568: Use fixed CRU and PMU CRU base
 addresses
Date: Tue,  4 Aug 2026 21:44:32 +0000
Message-ID: <20260804214442.2592597-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804214442.2592597-1-jonas@kwiboo.se>
References: <20260804214442.2592597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785879897; bh=7GixSGvWurvFAdLOcY3W9riMihw78mZRSq+QVtjg0jE=;
 b=DPZ1B2oX/xO8arcH7giKc7kYSJpFCEosYQihzyrd6KRDHeufzFIlZ8sRYYLABwz22ZhzMqaPJ
 UeJZiAdYbinX7rSWM53TPb/GvCPFVPzqInidutulpr3aWNbHiJ0JmVpX7JI7+S+UOHjWFJqecyC
 mwHVv9bGvNXDPaYUt6m6wYfkkJ5+LXvJvvGVS8HU+TjErz0cvPDEj+tjeukReG/y4GzweY7q3Ki
 91+OT/1Xc5cCEte222itSLHq/DAkVbQWZKnYrbxJi0qYaNCd/GBhEDvVxOyCPJWdGcoGFf73Mhq
 3s8Nq+CijwRvpD0kr0Zo3fDf+NZY4pS1s70AoMh9E7kA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=DPZ1B2oX
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

The rockchip_get_cru() helper is used by the sysreset_rockchip to get
the SoC specific CRU base address, and the rockchip_get_pmucru() helper
is only used by the RK3399 specific RAM driver. These helpers may
trigger a full clock driver probe to get the fixed CRU base address from
the clock driver private data, something that can take several ms.

Change to return the fixed RK3568 specific CRU or PMU CRU base address
directly to simplify and remove the unneeded complexity of using runtime
lookup in SoC specific code.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../include/asm/arch-rockchip/cru_rk3568.h    |  5 +--
 arch/arm/mach-rockchip/rk3568/clk_rk3568.c    | 33 ++-----------------
 2 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
index d72f241d0150..e2dc3cda5577 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
@@ -35,7 +35,6 @@ struct rk3568_clk_info {
 	bool is_cru;
 };
 
-/* Private data for the clock driver - used by rockchip_get_cru() */
 struct rk3568_pmuclk_priv {
 	struct rk3568_pmucru *pmucru;
 	ulong ppll_hz;
@@ -120,8 +119,10 @@ struct pll_rate_table {
 	unsigned int frac;
 };
 
-#define RK3568_PMU_MODE			0x80
+#define RK3568_PMU_CRU_BASE		0xfdd00000
 #define RK3568_PMU_PLL_CON(x)		((x) * 0x4)
+#define RK3568_PMU_MODE			0x80
+#define RK3568_CRU_BASE			0xfdd20000
 #define RK3568_PLL_CON(x)		((x) * 0x4)
 #define RK3568_MODE_CON			0xc0
 
diff --git a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
index 1c6b2ece602b..ccd98a91cd16 100644
--- a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
@@ -4,10 +4,7 @@
  */
 
 #include <dm.h>
-#include <syscon.h>
-#include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3568.h>
-#include <linux/err.h>
 
 int rockchip_get_clk(struct udevice **devp)
 {
@@ -17,36 +14,10 @@ int rockchip_get_clk(struct udevice **devp)
 
 void *rockchip_get_cru(void)
 {
-	struct rk3568_clk_priv *priv;
-	struct udevice *dev;
-	int ret;
-
-	ret = rockchip_get_clk(&dev);
-	if (ret)
-		return ERR_PTR(ret);
-
-	priv = dev_get_priv(dev);
-
-	return priv->cru;
-}
-
-static int rockchip_get_pmucruclk(struct udevice **devp)
-{
-	return uclass_get_device_by_driver(UCLASS_CLK,
-			DM_DRIVER_GET(rockchip_rk3568_pmucru), devp);
+	return (void *)RK3568_CRU_BASE;
 }
 
 void *rockchip_get_pmucru(void)
 {
-	struct rk3568_pmuclk_priv *priv;
-	struct udevice *dev;
-	int ret;
-
-	ret = rockchip_get_pmucruclk(&dev);
-	if (ret)
-		return ERR_PTR(ret);
-
-	priv = dev_get_priv(dev);
-
-	return priv->pmucru;
+	return (void *)RK3568_PMU_CRU_BASE;
 }
-- 
2.54.0

