Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ECAC55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2FDB407CC;
	Wed,  5 Aug 2026 17:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nk3Dr5KqnnSN; Wed,  5 Aug 2026 17:51:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C3C5407B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952287;
	bh=PznZt9aT6yGlHvDXAyvO5lwXS7p/nHkRNBFlUWy63yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rKAQzr/IKtum1l84CzuHhono422xEBWz3vaQ8SFDcHCDdmVAihSWYu549iOI2egZX
	 PDEKSYp3ZzYhyYAwJU807INjBepvKdQtJTMVSIeEBeC/s6ZCk+F3MGOqNBIOSglFGz
	 9tbhFvZqWxPER8jVIiKAoqusQKGoUCgrliQM+qz9iMw3pFQ54sInzbiwepKm4C3yGC
	 hO5PsxDmy5X6n5vl7DkaOLtf1llFM4OpK3ZFV4uR1eAaJk1k2HNF80JVzULNI6+Ggx
	 7ISbwdoOfUlKdWS4oasVTpTTEhQxS9p3rLSOTNk4zdvVNlFBZNjJn1LH78N9fEtkIP
	 ay1y3q4MPv/aA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C3C5407B9;
	Wed,  5 Aug 2026 17:51:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A38C218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 807F560661
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FksKkUIJkEbL for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:51:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 378BB60786
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 378BB60786
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 378BB60786
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:20 +0000 (UTC)
X-Forward-Email-ID: 6a7376ab5694ca629d62b9d7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.8
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
Subject: [PATCH 01/30] sysreset: rockchip: Add rockchip_sysreset_bind() helper
Date: Wed,  5 Aug 2026 17:44:32 +0000
Message-ID: <20260805174509.2968252-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952279; bh=PznZt9aT6yGlHvDXAyvO5lwXS7p/nHkRNBFlUWy63yg=;
 b=G+5UoHnAwrTCW/NOrjY3U7++6PazjfMvgxMlVWJW653crYYgcBJ/io54S+4sWUMp80e5PDeGz
 IFbgi1YJr7FuuIAtg6XP3M7mLq5CcjxnMXrb7iLgziuCMMNLGoHpVWiR7CBLCwPXpCC7XToJL4G
 Ie5fN+rpY12CJLqOMFe6yj0yKjO2GPoc/9gQ6FvCjHSf5600tGOYuCTlFBuSzA9WXuzFxr0Mglu
 EQjff03ZC14vqNItV7eoFf0QZUhax7WYZr9vsYn/Vc5dJvKnrmXqlnhlsebpd1Jcw4Xe8ooD1Ic
 6gcb4r8d2VJEc4kWlZtC8WnnriqCmtmc4h8G5zzutYyg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=G+5UoHnA
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

The sysreset_rockchip driver uses the rockchip_get_cru() helper to get
the CRU base address. However, use of this helper adds unnecessary
abstractions and limits the driver to only work for a single SoC.

Add a rockchip_sysreset_bind() helper intended to be used in clock
drivers. This helper expects the CRU base address and the offset to the
global reset state register as parameters in addition to the offset to
the first and second global software reset register.

The helper wraps similar handling as existing clock drivers, and will
be extended to make use of the CRU base address and state register
offset after all clock drivers have been converted to use this helper.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/clock.h | 15 +++++++++++
 drivers/sysreset/sysreset_rockchip.c       | 31 ++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index cf8bb0f04636..1b12867b489b 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -186,6 +186,21 @@ void rk3288_clk_configure_cpu(struct rockchip_cru *cru, struct rk3288_grf *grf);
 
 int rockchip_get_clk(struct udevice **devp);
 
+/*
+ * rockchip_sysreset_bind() - Bind system reset device as child of clock device
+ *
+ * @pdev: clock udevice
+ * @cru_base: base address of the clock/reset unit registers
+ * @glb_rst_st: offset of the global reset state register
+ * @glb_srst_fst: offset of the first global software reset register
+ * @glb_srst_snd: offset of the second global software reset register
+ * Return: 0 success, or error value
+ */
+int rockchip_sysreset_bind(struct udevice *pdev,
+			   unsigned long cru_base,
+			   unsigned int glb_rst_st,
+			   unsigned int glb_srst_fst,
+			   unsigned int glb_srst_snd);
 /*
  * rockchip_reset_bind() - Bind soft reset device as child of clock device
  *
diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
index 00308f9a33b7..39cb16ec5456 100644
--- a/drivers/sysreset/sysreset_rockchip.c
+++ b/drivers/sysreset/sysreset_rockchip.c
@@ -4,10 +4,11 @@
  */
 
 #include <dm.h>
-#include <errno.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <stdlib.h>
 #include <sysreset.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru_rk3328.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/err.h>
 
@@ -42,3 +43,29 @@ U_BOOT_DRIVER(sysreset_rockchip) = {
 	.id	= UCLASS_SYSRESET,
 	.ops	= &rockchip_sysreset,
 };
+
+int rockchip_sysreset_bind(struct udevice *pdev,
+			   unsigned long cru_base,
+			   unsigned int glb_rst_st,
+			   unsigned int glb_srst_fst,
+			   unsigned int glb_srst_snd)
+{
+	struct udevice *sysreset_dev;
+	struct sysreset_reg *priv;
+	int ret;
+
+	ret = device_bind_driver(pdev, "rockchip_sysreset", "sysreset",
+				 &sysreset_dev);
+	if (ret)
+		return ret;
+
+	priv = malloc(sizeof(struct sysreset_reg));
+	if (!priv)
+		return -ENOMEM;
+
+	priv->glb_srst_fst_value = glb_srst_fst;
+	priv->glb_srst_snd_value = glb_srst_snd;
+	dev_set_priv(sysreset_dev, priv);
+
+	return 0;
+}
-- 
2.54.0

