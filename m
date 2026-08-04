Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B894FC55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 460DE60787;
	Tue,  4 Aug 2026 21:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGbV70XOdwvL; Tue,  4 Aug 2026 21:45:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9443560618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785879900;
	bh=W9j6H9Z2vu6onx4u7zQ2tk3v/kQ4s91BqVno3sCrHGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u0tiJl3J7/7Aq/pwvdGtsbSHex6gdEZHxI9qpiNYxK/itmUKOF/f0iKHT6OuvWq+G
	 m8zkH2MTnt64K3I/l7tj0dJhiUbTAd7kDhxtpI5O/PxsDEBRmbKHb3eEJXPUozZQLL
	 dhJSfghDHUBTUCPw74sLoMsGpmWXP9heTxlTedOPK6UQYb73pA+8HKyCqhuy4IvPPs
	 ZIWRaXYP5o6ShvMXEdxnAtjURqXtS5r749YAG/nE6Ds/riSFMgaeEnKpYkrJyMaj9U
	 PErWgGGfRaIFyDBhSJUhGpIz8nOCBzkwePUfjf+bX2YmvTGz3VglfqPEv40gO6dkLJ
	 sOtHx0tb6jK6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9443560618;
	Tue,  4 Aug 2026 21:45:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE489270
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4627405D0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DscfHUkOuXCb for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:44:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0BCD240571
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BCD240571
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BCD240571
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:57 +0000 (UTC)
X-Forward-Email-ID: 6a725d5596269bde083044ea
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
Subject: [PATCH 02/10] rockchip: rk3588: Use fixed CRU base address
Date: Tue,  4 Aug 2026 21:44:31 +0000
Message-ID: <20260804214442.2592597-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804214442.2592597-1-jonas@kwiboo.se>
References: <20260804214442.2592597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785879897; bh=W9j6H9Z2vu6onx4u7zQ2tk3v/kQ4s91BqVno3sCrHGk=;
 b=Lw/JeqnwOWzC9F1lAsaDkcO+gidlKjai4ttGSLXLQt7cWcSO0ciJV00b/5BTINhntckwgjinf
 Cp+cyrOTbczbJFUfHBdPCeCTCbJo6dcpxAs9c7NelCs6yRJMitjwaMXXuCqKYszZi/eULxGMKSt
 es60fKZoeCLbq1mZoQUWfmma7yUYcFfKF6jr6oiYwXH7bTTeSSrBuOx9LcjaLMRWc4Rr0G14beM
 POfjOWoZGz86zmaGTpzGsmzLAIuReV3pOPo3AQa9D2/1CTKH+wTSIvfepnp4ASI5meTObHtW/nh
 X39PXRZ8xjwwim4jinHbzuMgdFB5iz1qQhC0Abkf0q8g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Lw/Jeqnw
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
the SoC specific CRU base address. The helper may trigger a full clock
driver probe to get the fixed CRU base address from the clock driver
private data, something that can take several ms.

Change to return the fixed RK3588 specific CRU base address directly to
simplify and remove the unneeded complexity of using runtime lookup in
SoC specific code.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3588/clk_rk3588.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
index 250ec423bd24..9b112e45f1de 100644
--- a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
@@ -4,10 +4,7 @@
  */
 
 #include <dm.h>
-#include <syscon.h>
-#include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3588.h>
-#include <linux/err.h>
 
 int rockchip_get_clk(struct udevice **devp)
 {
@@ -17,15 +14,5 @@ int rockchip_get_clk(struct udevice **devp)
 
 void *rockchip_get_cru(void)
 {
-	struct rk3588_clk_priv *priv;
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
+	return (void *)RK3588_CRU_BASE;
 }
-- 
2.54.0

