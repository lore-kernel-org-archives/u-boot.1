Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2046C44532
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23F5C408BC;
	Wed, 22 Jul 2026 10:58:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ud3GUhSfubS4; Wed, 22 Jul 2026 10:58:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CE8040880
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717910;
	bh=S5VoG5aDqay47lrzPhicnkfafkMNyHUm3c+lF6KGJT8=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uk67pvd7jiORvQIirqgZoCoWm8kbfDsitXXr5+MKBIS5y0XOYaq30TaYqiP7rC+xU
	 5mHTwAKX10MqMvEA9o0NbvElq2BXY0TroPa7Xv2RNz64sDurKrzO6eJ8bAxWN67cYB
	 HIX41C1XdFuawy98ddrx/jYYBY5paLyhYqKnM7Y1kq8SPP+g4vF8f52naglBMmB7ez
	 4y9LEhctT7Jr2TdYNyf294yuMOuaW+8nEaz5deTzsgNhG5h7MN9uDg5dbpnlOYAHKL
	 tKeplpoK9R5a4dub6mg4wnWhIUwW9uUgwlMs73eroarEz1k7YHepR/RBIxYZD3xtcQ
	 Kxm6EaAvCZ5Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CE8040880;
	Wed, 22 Jul 2026 10:58:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23B50109F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A097607DC
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9JLs9NUBDw6 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:58:26 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 968C9607D9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 968C9607D9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 968C9607D9
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD58B84A0B; Wed, 22 Jul 2026 12:58:23 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64348803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:58:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyPME363cqEW4UJDbPNRNrBrMg1PwbrqM/6YXJurTZ5Xp9owl5wb8FA8OccPHMzW0fYYZzQT1bn+Dzh0c6n+W+OrUcO1TSy6j16SBJ2uPBggVLGmN/Mq/Q/YSOJ6vLidOb7/LP3P97mQUMmDtnanlbq04W56IhfB+a7f0NpKIz15gNp3jbQiiuLH1gOYccGWaNJu1SRb4+yioCrxdKcVVq1TBv4Ixs7NsUI8sCOh688sDB1QMTOdl7Uq8P7LnWMFzwoP6uviQD3S8kwws9hnF5UaawMgaUms5enPvBHSOT519RDoMwxcxlGJ3DbMZ2OZCexkf7fs8oUNuPDX069nXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5VoG5aDqay47lrzPhicnkfafkMNyHUm3c+lF6KGJT8=;
 b=PBdRaE/qCJYBcmucfjKO2c5atICHLwZKv/Q/edvSOK2NivsK4D5Odw15biRBb+UZDUgWt7uai1oKuqU1Jku2xLU0/yhu2/wF9xkd9ARsCAiaCOZKErb/h4Ya4UqxdoEB9jZI5sOg08vL5izXpRSwPU7jw21aK6JhtC+iOutNwmxAWxK7p6Q0XyYPYOEIBPScS9gwhUlzwG0jrUVtjIvoTIS9o1PsGmHPJmr3kheREHaxBYPhc/8swWwPdLhRff5tZl6HUapwvj2yuJCjA2YoRlXu2R+3v19sJHpQBB1017i2jysN1h9I7Wp/fRIhLXkhROrsN+awbdG7LH9B55O4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.84) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
Received: from DU2PR04CA0162.eurprd04.prod.outlook.com (2603:10a6:10:2b0::17)
 by PA4PR07MB7565.eurprd07.prod.outlook.com (2603:10a6:102:c1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 10:58:19 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::84) by DU2PR04CA0162.outlook.office365.com
 (2603:10a6:10:2b0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 10:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.84)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.84; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.84) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Wed, 22 Jul 2026 10:58:19 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id A0B7080000B2;
 Wed, 22 Jul 2026 13:58:18 +0300 (EEST)
Date: Wed, 22 Jul 2026 13:57:59 +0300
Subject: [PATCH v2 1/5] watchdog: wdt-uclass: report effective timeout in
 start print
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-rinta-watchdog-gettime-v2-1-39e249500543@nokia.com>
References: <20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com>
In-Reply-To: <20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784717898; l=4127;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=UEtQni8rwZfuYxTcg3xrmdc71AbDgK/ztwGyfEgrL1I=;
 b=icNDoZfHzlAQ3WZJyptx0GKNdjgFUiDVYKrLt9zVdIUNwe1hyACZMKsgmUv4kN1nGAhQrjQpO
 NlsQ8d0oxZ1DBVCZwkewi07b4+7UxEnAB973MJa6mPDv+INDwqcVLGh
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|PA4PR07MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8a43f1-8602-4beb-3913-08dee7e023ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: P+wrE13kpiNCtG7DGcforN9+XjhsjQIN+atN/IrcjWh67bFblhH2TMBOktJtZ5g+vs4qka3ohidUAADi0MFWLK9diTUM+/+C1gG6vbwdrsks9urYdAl1otz4fUg20Mq+5zJ4aE4C1Q5VksZ9su1NvUgTldGty0qw3NxWI2J4bQFdoiLE3hMQHJSpkpljUaXPxSEZErGA86FQ5I2WbqxC1b6MWcuagoV91mEni3NjLvDeVcVt5QASs9tEdSfgz9IlEW4JVIjoAeyeLelHOG0hGjS/+ha9qd6BtUjd8xS9hWOdD3ycvgYszzn9nk2ePPqaOi8vFErZCegFnb6NU/7M50x9cA756Fq5PTXXT4nDLi5LjGbVDSoBH2045c8u8MbvHitVl9tVHkII6egtm4WIJbM9fvX5IYyIKu/E0S9MkT2z0bj3MqjG+HCLNioDAiCpv7nHZQx7ztzp78BUarOZw7T7ZX1VRlC+J6xC12oyct7UkwVnG9jPQAibaYSapzkit4DHDdfF1ZMZ9gN8jI13PPFY2ngG4+ZHK/PfZfcrxudU6oK6c+LF7r65vjyRopuvi1ppVjvSoMIQRtPOwY3Pv+Y9IV9ddpT2sagISyWTqU0tREp4vnx57owvNGQX3y/9UvT5oG1zw8Fop8nB3FmLyDsVU4HL1gr9XG9lh0iUC8k/KOvHp5+P+ItBNjNHxy6TquKmUAfzm5wuwq9lCjJtNA==
X-Forefront-Antispam-Report: CIP:131.228.2.84; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe01smtplvp01.emea.nsn-net.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rTS0kgPNz0BLzdCYHg8NZK1ReSFTVUtTuIQDarJbPFvcJXsjKqhj7m7jCJM4qLrFCnxJXGLhByHmOsnRWq1oynyP9fFweHtdcbko5da7Bb23vN5y/0wPBtuPECC7gUYp+dDp/+QSZ/oTMmT3MGBw5kJOlIF7O+7etcVYC/eTN75MhLMTealv43V5h90yBvwfr3x4mcsowtoECuIUvYbxH+0zZ71DEQ4CTZYPWPR2cFe8tuKVqrIKIMjt/fY56vJ9useju01zjVzXb2lerb1zx6pwbiiOhrtibpcVICGniCJqnleXZkJqsOKBZBYA0CBevTncWV39bI4BrUY63sq4thXnErIYZ4afs84Oy1MmiUE5bIadsuPHKivb/edPMyHQNJ7F1HUXFZPIz/Tu8OgtkUsmhfKebyE/F3io6QpHBzSh3UbG/CcH+LQ98G/vz85l
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:58:19.1145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8a43f1-8602-4beb-3913-08dee7e023ca
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.84];
 Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7565
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5VoG5aDqay47lrzPhicnkfafkMNyHUm3c+lF6KGJT8=;
 b=sOukCpHdoOKLirr97lYiGsY2A3YNYy9llXZFchejQHtLB9eXtOZJ3udq6SuPIE/rZtFOTBEC4FWKFfkRIu0XNH+1bf1Hi4758nuYpUXcV7/nn7ARpmL20MCNnCEDJWc5if6JQsZLQ5uJ3ZDK0TUKTABuIf4y8oK+ViWV+6cJezYiHpBUlet4VSb7E6YiG6FYm0M8gxqX+SmKyxvk96JbajBvdKKqlnSsTkqLcsPdxfsMTeXu9igCMo+BZpdW9zytQ1wPKbpWPdWbr1sGl4IKpxD46ZVX4b4irwwTLi6IaxGgIt3CMlJ2vAPkN9NNSzXKrfWubAF/S5xU/O4AtiUZ9g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=sOukCpHd
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=juuso.rinta@nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=nokia.com header.i=@nokia.com header.b="sOukCpHd"; 
 dkim-atps=neutral
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
From: Juuso Rinta via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Juuso Rinta <juuso.rinta@nokia.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The wdt_start() function may be called with a timeout greater
than the hardware-supported maximum. This in turn can result
in a bogus print, for example, if the device clamps the timeout
to 10s but wdt_start() is called with a 60s timeout:
Started <watchdog@> with servicing every 1000ms (60s timeout)

Add a max_timeout_ms field to uclass-plat data, so drivers can
set the hardware-limited max timeout value there during probing.
For drivers that support this feature, the startup print now
shows both the actual and requested timeout values, e.g.
Started <watchdog@> with servicing every 1000ms (10s timeout, requested 60s)

The timeout comparison is done in whole seconds to avoid noise
from sub-second rounding.

The value defaults to 0. For drivers that do not support
this feature, the resulting print remains the same as before.

While at it, rename the string str in wdt_start() to svc_str for
cleaner distinction from the new req_str, replace its memset with
svc_str[0] = '\0', and use sizeof(svc_str) instead of the magic 16
in the snprintf.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/wdt-uclass.c | 34 +++++++++++++++++++++++++++++-----
 include/wdt.h                 | 11 +++++++++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 438833b2245..1a58256217a 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -127,9 +127,12 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	ret = ops->start(dev, timeout_ms, flags);
 	if (ret == 0) {
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
-		char str[16];
+		struct wdt_uc_plat *plat = dev_get_uclass_plat(dev);
+		u64 effective_ms = timeout_ms;
+		char svc_str[16];
+		char req_str[32];
 
-		memset(str, 0, 16);
+		svc_str[0] = '\0';
 		if (IS_ENABLED(CONFIG_WATCHDOG)) {
 			if (priv->running)
 				cyclic_unregister(&priv->cyclic);
@@ -139,13 +142,33 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 					priv->reset_period * 1000,
 					dev->name);
 
-			snprintf(str, 16, "every %ldms", priv->reset_period);
+			snprintf(svc_str, sizeof(svc_str), "every %ldms",
+				 priv->reset_period);
 		}
 
 		priv->running = true;
-		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
+
+		/*
+		 * If the driver reported a maximum timeout value,
+		 * check if the requested timeout is clamped
+		 */
+		req_str[0] = '\0';
+		if (plat->max_timeout_ms) {
+			if (timeout_ms > plat->max_timeout_ms)
+				effective_ms = plat->max_timeout_ms;
+
+			/*
+			 * Note the requested value when it differs at whole-second
+			 * resolution. Sub-second rounding is ignored to avoid noise.
+			 */
+			if ((u32)lldiv(effective_ms, 1000) != (u32)lldiv(timeout_ms, 1000))
+				snprintf(req_str, sizeof(req_str), ", requested %ds",
+					 (u32)lldiv(timeout_ms, 1000));
+		}
+
+		printf("WDT:   Started %s with%s servicing %s (%ds timeout%s)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
-		       str, (u32)lldiv(timeout_ms, 1000));
+		       svc_str, (u32)lldiv(effective_ms, 1000), req_str);
 	}
 
 	return ret;
@@ -268,4 +291,5 @@ UCLASS_DRIVER(wdt) = {
 	.flags			= DM_UC_FLAG_SEQ_ALIAS,
 	.pre_probe		= wdt_pre_probe,
 	.per_device_auto	= sizeof(struct wdt_priv),
+	.per_device_plat_auto	= sizeof(struct wdt_uc_plat),
 };
diff --git a/include/wdt.h b/include/wdt.h
index 1ef656585c4..db1faa321b3 100644
--- a/include/wdt.h
+++ b/include/wdt.h
@@ -74,6 +74,17 @@ int wdt_reset(struct udevice *dev);
  */
 int wdt_expire_now(struct udevice *dev, ulong flags);
 
+/**
+ * struct wdt_uc_plat - uclass platform data for a watchdog device
+ *
+ * @max_timeout_ms: Maximum timeout (in ms) that the hardware can honour.
+ *  A driver should set this typically at probe time. Default value 0
+ *  means no limit set by the driver.
+ */
+struct wdt_uc_plat {
+	u32 max_timeout_ms;
+};
+
 /*
  * struct wdt_ops - Driver model wdt operations
  *

-- 
2.39.2

