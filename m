Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFC9C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 057E080D81;
	Wed,  5 Aug 2026 17:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KwkOvQy4R4W8; Wed,  5 Aug 2026 17:52:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BF9A80D4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952369;
	bh=pI7kq8UEaqR8iHOUFFmSW/a1775zuact8eSVgQC6J1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NKpA0cmEAyjfQQALPKoONhD/hhIZYWv6Tk7JYYL+x8VweaWS4+DhUSsRg0cQjHNOK
	 Ucz83gTyNWt82H0A813Of9UaYjyq6i78o5zlnQqmVgBtfvBHiuB8m+KACVZIYC9i0L
	 q7xgnKtu4rFo2Ic/CyLBdPRV8c84ydMOWGKOsAwFPot0J0dcDXzRF5cId7HoUSNF6r
	 wdpgJQLEcBNyw9D90l/LDSRN1q+mnr+RHVnmrxdebWv5N8t4VVNYxR0DqoELh93q99
	 y45KoPdGtPwKP0ksoKOTL6cGrq8BJ6KDPnIreD+WDPlBlzVk1L7oR/PsPl2FjkGKJo
	 44vM4IX5IvnZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BF9A80D4A;
	Wed,  5 Aug 2026 17:52:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3280F144
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24631607DC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xw3j5delOunu for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:52:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E3357607CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E3357607CA
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3357607CA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:45 +0000 (UTC)
X-Forward-Email-ID: 6a7376cd5694ca629d62bc1d
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
Subject: [PATCH 20/30] sysreset: rockchip: Remove use of rockchip_get_cru()
Date: Wed,  5 Aug 2026 17:44:51 +0000
Message-ID: <20260805174509.2968252-21-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952365; bh=pI7kq8UEaqR8iHOUFFmSW/a1775zuact8eSVgQC6J1o=;
 b=qRNIRJRN7AVGZU+f5/Z/uxXkS2143ckdsHrWK3SAfeQMYnjdOAOB6X0AOS0qGSXEd/LBoWD9R
 /XdSSKiprDcDuM9cTeK+Hk/5krQB1hLRXgztJmeMKy3xzzNeotg2BDYB3vTvIoK/Y1GJItN/tH2
 K4TYjMF8XGlsz1SGy7Y6yVZmPoVY6U1dXpdNaOYhP1mBOrEmTJZFTyoOxuBlbvSZ88/BQMozxVL
 P9TbHLnmGZMtyivoMVdIgPcA9q0PTDo5mLjGeyBdQXLnnA7VKzY+Y+y8PmN9LdXfK3MUODHqtwf
 tDxWgcxy7P4ZfGVb45T/T39T/D46r4HzZm9F36wqf18w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=qRNIRJRN
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

Complete the transition to use the CRU base address parameter instead of
getting it from the rockchip_get_cru() helper now that all clock drivers
have been converted to use the rockchip_sysreset_bind() helper.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/clock.h |  5 -----
 drivers/sysreset/sysreset_rockchip.c       | 25 +++++++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index 1b12867b489b..98fd8cd28ff3 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -140,11 +140,6 @@ static inline int rk_pll_id(enum rk_clk_id clk_id)
 	return clk_id - 1;
 }
 
-struct sysreset_reg {
-	unsigned int glb_srst_fst_value;
-	unsigned int glb_srst_snd_value;
-};
-
 /**
  * clk_get_divisor() - Calculate the required clock divisior
  *
diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
index 39cb16ec5456..27ba4ee0667c 100644
--- a/drivers/sysreset/sysreset_rockchip.c
+++ b/drivers/sysreset/sysreset_rockchip.c
@@ -10,22 +10,26 @@
 #include <sysreset.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
-#include <linux/err.h>
 
-int rockchip_sysreset_request(struct udevice *dev, enum sysreset_t type)
+struct sysreset_reg {
+	unsigned long cru_base;
+	unsigned int glb_srst_fst;
+	unsigned int glb_srst_snd;
+};
+
+static int rockchip_sysreset_request(struct udevice *dev, enum sysreset_t type)
 {
-	struct sysreset_reg *offset = dev_get_priv(dev);
-	unsigned long cru_base = (unsigned long)rockchip_get_cru();
+	struct sysreset_reg *priv = dev_get_priv(dev);
 
-	if (IS_ERR_VALUE(cru_base))
-		return (int)cru_base;
+	if (!priv->cru_base)
+		return -EPROTONOSUPPORT;
 
 	switch (type) {
 	case SYSRESET_WARM:
-		writel(0xeca8, cru_base + offset->glb_srst_snd_value);
+		writel(0xeca8, priv->cru_base + priv->glb_srst_snd);
 		break;
 	case SYSRESET_COLD:
-		writel(0xfdb9, cru_base + offset->glb_srst_fst_value);
+		writel(0xfdb9, priv->cru_base + priv->glb_srst_fst);
 		break;
 	default:
 		return -EPROTONOSUPPORT;
@@ -63,8 +67,9 @@ int rockchip_sysreset_bind(struct udevice *pdev,
 	if (!priv)
 		return -ENOMEM;
 
-	priv->glb_srst_fst_value = glb_srst_fst;
-	priv->glb_srst_snd_value = glb_srst_snd;
+	priv->cru_base = cru_base;
+	priv->glb_srst_fst = glb_srst_fst;
+	priv->glb_srst_snd = glb_srst_snd;
 	dev_set_priv(sysreset_dev, priv);
 
 	return 0;
-- 
2.54.0

