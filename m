Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698E4C5DF67
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 03:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01E2D81397;
	Sat, 15 Aug 2026 03:42:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QFQ1XCIAhjTm; Sat, 15 Aug 2026 03:42:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17CEB8137E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786765338;
	bh=VM/HFG4pguBeHH2hDdGFNSGbUWeiHY9K6Hblg9XfeHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aq2gwPET3U4KFI4vTKkAofWIPw4LoDTfGv/Xmc/I/a3DJHsG4npDXx2X8/dwodiv7
	 P3XGfvDqS+V8vCVkghwm2Lw7qWe4FC3YEHb5OyILD6nQ1lZpiexO/XfxtsrXnRcV7m
	 qnBFDOe4X6BHtLM74+J0EDXpV4/kiA0fK/M7zeRhv7ijRuTZXGMCo674dTTDMVKOL3
	 coL5+oRJGPCYafu04DADaL7PsxqLoOihPWbHtPfO9KsZfFWKagmr5m0/vGibDbUnKu
	 vx3fk6Hbz9VB+1OSqaAwTG2f4lDXwSahi6HvREy8zQtBOQ9bKSEaXAyn5F2f9vhD12
	 O72cyu4H8+Rog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17CEB8137E;
	Sat, 15 Aug 2026 03:42:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFEA12BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A633640085
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I0RKuezVf5t3 for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 03:42:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AA9E04004E
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA9E04004E
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=IVfpw8HJ
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA9E04004E
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786765311; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cDOzmkyMstvj1F1Fz4CcrUUcVYvq9EJsK+2ypNkbvNeYxedFfyHM4m2UwxrIC5vdBcyH3fFtjAaxy/e4rEK8bWa8AiynhcStnBiHAW+Pt8OYcTdk7EmfxK9R3iWgU6zLtRxy8a6Sc458evD2hTVghdq6cfR/EeoUXMvwQyi5Sxg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786765311;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VM/HFG4pguBeHH2hDdGFNSGbUWeiHY9K6Hblg9XfeHs=; 
 b=DXqbxFnz0uRzAJTasXDu+PqR5b6PWAjL/EMrWWMEt2Sa6m0M3zw2WIWX0l7UTqB3/Dbf6Gpx4If3mVIKGwMsVCvnCYRqGZUVhaFDEhK1tgemFQFeLLwLvn8ztBOH2hpJYXUYRz0lc4/NXYnMBoCr6Dqkybte7eqhTXwcC+roCC4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786765311; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=VM/HFG4pguBeHH2hDdGFNSGbUWeiHY9K6Hblg9XfeHs=;
 b=IVfpw8HJmLQlhG7JFTFeblWa4iSwfI4Skmvjsz/MDAp/fPyxXoQB37QMigthz0As
 8N0br3pJqaLGkI1bOA5fKE91TbR3Nz2Zpq+ylMnZl5kwWG5svx9iL2Ipq1vR8Et2+HD
 rj1G4TO927jYdCM08mSowN2RAiNV3dkukCjdI3MM=
Received: by mx.zohomail.com with SMTPS id 1786765309605487.7911858827164;
 Fri, 14 Aug 2026 20:41:49 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 15 Aug 2026 11:40:24 +0800
Subject: [PATCH v2 4/4] clk: spacemit: k1: remove bus gate from TWSI
 functional clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-k1-i2c-fix-v2-4-7d2a48607233@pigmoral.tech>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
In-Reply-To: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
To: Heiko Schocher <hs@nabladev.com>, u-boot-spacemit@groups.io, 
 u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=sQtf5ZCGwe255i6weitw+RIh3qxYQBbmzOHmoaaD084=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLq798JrpeW22vFI3wi1MKht/LypazVLl/mrnI8/9jQ1
 Cs+rb6ko5SFQYyLQVZMkYXLX/yftQ7PtyMCrfdh5rAygQxh4OIUgIk8Wc/wT7Xk3N+PvyU/ce1J
 SPgS1eWUGts6Q6hnQ8D0B59VfhyMVGZk+Lbf66RCw2yT3w6dV33FE2u3x3WXzz94+uL6lRLue7c
 b8gIA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
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

The TWSI functional clocks incorrectly include both the functional clock
enable bit and the bus clock enable bit in their gate masks. The device
tree and the full clock tree model the bus clocks separately.

Remove the bus clock enable bit from the functional clock gate masks so
that the functional and bus clocks are controlled independently.

Keep the combined gate for TWSI8 because its clock control register is
write-only and therefore cannot be safely shared by two clock
instances.

Fixes: 3aa2882a3e1a ("clk: spacemit: Add support for K1 SoC")
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/spacemit/clk-k1.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
index e239ffe6ba0d..20b8595aa3c4 100644
--- a/drivers/clk/spacemit/clk-k1.c
+++ b/drivers/clk/spacemit/clk-k1.c
@@ -314,7 +314,7 @@ static const char * const twsi_parents[] = {
 
 CCU_MUX_GATE_DEFINE(CLK_TWSI2, twsi2_clk, twsi2_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI2_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 /*
  * APBC_TWSI8_CLK_RST has a quirk that reading always results in zero.
  * Combine functional and bus bits together as a gate to avoid sharing the
@@ -345,7 +345,7 @@ static const char * const twsi_parents[] = {
 
 CCU_MUX_GATE_DEFINE(CLK_TWSI2, twsi2_clk, twsi2_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI2_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 /*
  * APBC_TWSI8_CLK_RST has a quirk that reading always results in zero.
  * Combine functional and bus bits together as a gate to avoid sharing the
@@ -467,22 +467,22 @@ CCU_GATE_DEFINE(CLK_RTC, rtc_clk, rtc_clk, "clock-32k", APBC_RTC_CLK_RST,
 
 CCU_MUX_GATE_DEFINE(CLK_TWSI0, twsi0_clk, twsi0_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI0_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 CCU_MUX_GATE_DEFINE(CLK_TWSI1, twsi1_clk, twsi1_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI1_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 CCU_MUX_GATE_DEFINE(CLK_TWSI4, twsi4_clk, twsi4_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI4_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 CCU_MUX_GATE_DEFINE(CLK_TWSI5, twsi5_clk, twsi5_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI5_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 CCU_MUX_GATE_DEFINE(CLK_TWSI6, twsi6_clk, twsi6_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI6_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 CCU_MUX_GATE_DEFINE(CLK_TWSI7, twsi7_clk, twsi7_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI7_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 
 static const char * const timer_parents[] = {
 	"pll1_d192_12p8",

-- 
2.55.0

