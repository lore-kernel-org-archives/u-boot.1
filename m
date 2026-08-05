Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92751C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35400407A2;
	Wed,  5 Aug 2026 17:50:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 628Cq2ZoWRqU; Wed,  5 Aug 2026 17:50:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B6284079D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952232;
	bh=CBpS8F9THqPoqjw3gitd7LFSdmDlHizShLO67a9vLT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LK6D8wSPWXo5vU/v5kOw3LaQBhuIdx+jnZ1xQJliClGLNgQrIgAyCf6h8qa+PK3/c
	 fNRTCwMjNoWUfwZ94Evi6gBh1QMWuT712BHdFl5jhn0oDDPaW3fX00AEYeoU9DauKj
	 9PVzQ+lUkP3UMLwLod+2Pj2WUsV6aSAL9l5SXfWrawC6KrOVsMW4TzXn5VOgRvvlYS
	 KDSn1zWNQX/1CYFEcfsagG+EIBOBgl8vwSy1Fr9GEuDYzKG/aUHUBp1yvegd0+F5Av
	 6SAiXFhgy3ueccrdoyjAhis3ydUSl7dsU1KyLm9s29cx16cPOWTwISkZp3b4RdwO9J
	 mV90wE0kZ8VSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B6284079D;
	Wed,  5 Aug 2026 17:50:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78EFE144
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F6EF60786
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:50:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kCLk5XOOriIX for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:50:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CEBF06076B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEBF06076B
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CEBF06076B
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:50:29 +0000 (UTC)
X-Forward-Email-ID: 6a7376d35694ca629d62bc77
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
Subject: [PATCH 23/30] rockchip: cpuinfo: Use sysreset_get_status() helper
Date: Wed,  5 Aug 2026 17:44:54 +0000
Message-ID: <20260805174509.2968252-24-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952229; bh=CBpS8F9THqPoqjw3gitd7LFSdmDlHizShLO67a9vLT0=;
 b=joZUE7s5Ji/1EMtnqYQGt8yLeDBaX6Qfw5XWrbLErS7kAjyN1/ct6eUXCmXb90mFMtMDH+raz
 TCsHlRgEeQXyiEsV9fA2YZ0bYnimY00fEEiosKBVcRevgRhXtHBnKWC2dartx6Kq0Iv8Idv6xZX
 c4F9iIGvw4rCVX6naclUXLLU4RT0uuKNkJHGhDJMdsQOQFE3N6Vdr0J2cuVvzC7tqiCcEKCCboM
 GgJnWQrCUXOwFShrIPQWOe/168hlCo8xM+8JK3dD0hx3Q2yogb+oCzgMTkT/5hcxPEjSsIeJnmE
 kPJLXFsUTpb2P9gFLZlQrvGZ8SjHF3hw9UxNS2dggcQA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=joZUE7s5
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

The get_reset_cause() helper only works on RK3288, RK3399, RK3568 and
RK3588 due to its dependency on rockchip_get_cru() and the glb_rst_st
field in struct rockchip_cru.

Convert to use the sysreset_get_status() helper now that the
sysreset_rockchip driver implements the get_status() ops to remove any
dependency on rockchip_get_cru() and the glb_rst_st field.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru.h | 13 ------
 arch/arm/mach-rockchip/cpu-info.c        | 50 ++++++------------------
 2 files changed, 13 insertions(+), 50 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
index c3259b8e7cc0..b583d08a50c3 100644
--- a/arch/arm/include/asm/arch-rockchip/cru.h
+++ b/arch/arm/include/asm/arch-rockchip/cru.h
@@ -21,19 +21,6 @@
 #include <asm/arch-rockchip/cru_rk3588.h>
 #endif
 
-/* CRU_GLB_RST_ST */
-enum {
-	GLB_POR_RST,
-	FST_GLB_RST_ST		= BIT(0),
-	SND_GLB_RST_ST		= BIT(1),
-	FST_GLB_TSADC_RST_ST	= BIT(2),
-	SND_GLB_TSADC_RST_ST	= BIT(3),
-	FST_GLB_WDT_RST_ST	= BIT(4),
-	SND_GLB_WDT_RST_ST	= BIT(5),
-};
-
 #define MHz		1000000
 
-char *get_reset_cause(void);
-
 #endif /* _ROCKCHIP_CLOCK_H */
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 14c7331e1ab2..9be523b11003 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -4,48 +4,24 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
+#include <dm.h>
 #include <env.h>
-#include <init.h>
-#include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
-#include <asm/arch-rockchip/hardware.h>
-#include <linux/err.h>
-
-char *get_reset_cause(void)
-{
-	struct rockchip_cru *cru = rockchip_get_cru();
-	char *cause = NULL;
-
-	if (IS_ERR(cru))
-		return cause;
-
-	switch (cru->glb_rst_st) {
-	case GLB_POR_RST:
-		cause = "POR";
-		break;
-	case FST_GLB_RST_ST:
-	case SND_GLB_RST_ST:
-		cause = "RST";
-		break;
-	case FST_GLB_TSADC_RST_ST:
-	case SND_GLB_TSADC_RST_ST:
-		cause = "THERMAL";
-		break;
-	case FST_GLB_WDT_RST_ST:
-	case SND_GLB_WDT_RST_ST:
-		cause = "WDOG";
-		break;
-	default:
-		cause = "unknown reset";
-	}
-
-	return cause;
-}
+#include <sysreset.h>
 
 #if IS_ENABLED(CONFIG_DISPLAY_CPUINFO)
 int print_cpuinfo(void)
 {
-	char *cause = get_reset_cause();
+	struct udevice *sysreset_dev;
+	char cause[16];
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_SYSRESET,
+					  DM_DRIVER_GET(sysreset_rockchip),
+					  &sysreset_dev);
+	if (!ret)
+		ret = sysreset_get_status(sysreset_dev, cause, sizeof(cause));
+	if (ret)
+		strcpy(cause, "unknown reset");
 
 	printf("SoC: Rockchip %s\n", CONFIG_SYS_SOC);
 	printf("Reset cause: %s\n", cause);
-- 
2.54.0

