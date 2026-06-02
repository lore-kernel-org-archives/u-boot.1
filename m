Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC0FCD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 11:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABC9984903;
	Tue,  2 Jun 2026 13:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="J8IT/R4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC5FE8489D; Tue,  2 Jun 2026 13:58:18 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4116D84881
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 13:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=PC77cUXbENPrXFeSMnlrG3KI84Z0HWCT1vHhe4RRbPk=; b=J8IT/R4TQdpU50utovZlWMJYnK
 k0kK1OB00IXhBFBwcfm4X/9viUpVrA1h3oJ/kNALzF7XJrrlZpQxV0sy+6HSopYKunp/SzfhKV2+M
 BzdnPBqMn+fVwG+ZEDEn4seFoNVeqEufOiLC3Sl3qaUsl9MnctKVYqb8Xa3j2gHvSOqsa3CxPIDle
 k24ajvqiFrBsNGy6ZklILw68nRMKBYDQqbhgSZAwfbdkl554pMTZrOkG01q2en1tyjq2MvEeRArCJ
 xd1NTeTcNq7Sm3iL9JGDVl47Yv4H8jLdColhjQlb5WOO/1YUOOlEPT0tF1DN88MzNdadaB+G8zPTo
 yVXEJ3IA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl7-000Ljq-30; Tue, 02 Jun 2026 13:58:13 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl6-000J89-2j; Tue, 02 Jun 2026 13:58:13 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 7/7] boards: tqma7: call tq-sysinfo setup
Date: Tue,  2 Jun 2026 13:57:55 +0200
Message-Id: <20260602115755.371164-8-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602115755.371164-1-Alexander.Feilke@ew.tq-group.com>
References: <20260602115755.371164-1-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Probe TQ sysinfo drivers to print device info from eeprom during boot.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 board/tq/tqma7/tqma7.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/tq/tqma7/tqma7.c b/board/tq/tqma7/tqma7.c
index 30bd155713d..ccf805d5461 100644
--- a/board/tq/tqma7/tqma7.c
+++ b/board/tq/tqma7/tqma7.c
@@ -17,6 +17,7 @@
 
 #include "../common/tq_bb.h"
 #include "../common/tq_som.h"
+#include "../common/tq_sysinfo.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -54,6 +55,7 @@ static const char *tqma7_get_boardname(void)
 int board_late_init(void)
 {
 	const char *bname = tqma7_get_boardname();
+	int ret;
 
 	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)) {
 		struct tag_serialnr serialnr;
@@ -65,6 +67,10 @@ int board_late_init(void)
 
 	env_set_runtime("board_name", bname);
 
+	ret = tq_common_sysinfo_setup();
+	if (ret)
+		log_err("Sysinfo setup failed: %d\n", ret);
+
 	return tq_bb_board_late_init();
 }
 
-- 
2.34.1

