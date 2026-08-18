Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBC5C5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 07:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B1E3607DA;
	Tue, 18 Aug 2026 07:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KfRj8Eia1D7o; Tue, 18 Aug 2026 07:43:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6AE5606C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787039034;
	bh=nYpTvmYLwYWWuW726IMVn0YqnYTUkikeZxl7VIXyAh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CWJT4chfQtgTJeNeo/mrudVchAcWDGzceVJKMKO8PXu9/AiDoaVTIB+n8OEm0fYVG
	 89ONqQovJw9TYG1ovxmAjiPsN+qPZ9rUcEmnEH7Z9dzX17wFbAPCFg38KztKCAQgLG
	 CsJuKLR6RR6SuNXpJZlW4EQ2yNUNj9S7IZUjfyPFfvWPGzhJsYOp/fnSdzi8l3ROXm
	 1qyP8gjTQI84UE1mAHA1yl7M9Xk/uaoQtFhL5yYu/2dCMH9MQqWq833m7wYWlm5k0q
	 SniLX9a4i4o1ZOt5HeC1dRWK1KmK+2SsKTdQtV4FBPPjDG/TtguMMwXhGGraDjui5F
	 bLEJemSPvMMCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6AE5606C9;
	Tue, 18 Aug 2026 07:43:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 31AC92EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 174AA40103
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JqM4rTjWdOS7 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 07:43:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 976F14005F
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 976F14005F
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=J1WU5CGE
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 976F14005F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dgt+XEwgCtMqJhgsywxpCh8BcBiO9f1Truv6Zv/N8FWReieVf/poU2ASc6yiGUT7X5U0xnkfezZi3/VJ2Q1l9Tos7/DMBX7AvusfJAsljY0tI+bqqxv2y2NCCtBE/75GE0ArKZgnddKvSHQB8rL92Lx2eE92n/5bL98kHOv6gUaQ/LhdVTd7ylqP0j8pK0GNknZPnFqAHTqPoSW5v6IXpKOGh2ow3L/N+1JR1/JhMCGV3CibxDsBM9LeiUoFbwTwIr88rBkG1JYtOCY7RczUJTw2EW/uWY48O6twAKb1e37WWkCQF+lZTbl+Jem4p+qmbsy7JqF7vgYxRCJXwlv1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYpTvmYLwYWWuW726IMVn0YqnYTUkikeZxl7VIXyAh0=;
 b=XL+7BdI2P+zg+EyQzNo/WyhAEvgYvHtLIgZJ3W9GH2PlXWadYlfBeOErWUR9EqgBcTsekXQilOMoqVbVKwuBr0Sfsg11+d2FnhuEyF5s9PGtYSzhJGO11Ck/pCNaFrOduNZUz2Md/P9q5/sXYY0361H2JQsTVijETijtByql5NjdVm2YC4hcX9IvBlyky7vpmlO7n9AkA+Lcf54VAyd2ndFyu1JEi8V9anT/pqAdRF2jXwNbn4po/grw0U/ZRw1CNDZ3u3B6Ep+jpw84H2G+nhHsv9SOmpmESQcXBcI5mYXpH+f2X/XHFTFgpGELAgtzgExQVG1LZ0Y/vdY3iOpBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYpTvmYLwYWWuW726IMVn0YqnYTUkikeZxl7VIXyAh0=;
 b=J1WU5CGEQSvts0rMX7jTKCTY3MfcFVVsFofnsVAr+9rOS7dQsNKUWV6CdJLN/0/dPACdJ69nc0EnsT56T/B+5rlN0szRb0xCrjbG53OcdMi+Wtijigq5OKZwgQcvCEkdX+9eyXGYYRlx6VTJQ2k5IHA3bu8Tkauso9S+dFskYVzjkrY0nafJjc3MPOZnaDDfNc0cSl76/7dBLvzPbjP0A8cGBGb8SzYrFv+lDiXKYh/6/gUuHpkSk2keaUGfbyWRLp2QDWZMMr3/5aawzh6DHnjzC5CZUi4IpP5RH6gIlLp2819Xb9C/x0TyreTCRyLxB+fjp0elVhUSsQsJoMtMiw==
Received: from DU7P189CA0016.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::28)
 by MRWPR07MB11731.eurprd07.prod.outlook.com (2603:10a6:501:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 07:43:45 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::3d) by DU7P189CA0016.outlook.office365.com
 (2603:10a6:10:552::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 07:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.101 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.101; helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Tue, 18 Aug 2026 07:43:45 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id E44ED1C004A;
 Tue, 18 Aug 2026 10:43:44 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Tue, 18 Aug 2026 10:43:26 +0300
Subject: [PATCH v3 2/6] watchdog: wdt-uclass: report effective timeout in
 start print
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-rinta-watchdog-gettime-v3-2-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787039024; l=3740;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=4e4rGJfCzq5jft6LM5HLS8hfimy7o2lv4wecigwe1cU=;
 b=pC/ZzKeIW7kpaaT4m2UvsGXScqx0gK+CS8vE0BFMaUsNoAOqY0mupr6kstTEekcpSwrrMkcxp
 ruSW3+f4ez1BxHPQt45elNRyCSI9ga2EXYs/r4hAxtZdf4u7gwm/VoL
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FF:EE_|MRWPR07MB11731:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1dd551-2bf8-44a1-bf92-08defcfc6ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BfNPRHSIMSpyZrIzzU8FMsvHeQBjYsvY2YWpgZ1WKXeXZUoBVKgSXfzs3fEwve4cpRJFdNwZSJ/0pBOF30MFzNWFQ+Wp+kHZBcsqtJKcVz+Vqb0DlcOtXh83XU6PuG8VxQU8I2mPLSqCJNeK6RUXfzJy1An0OiqlMhCXHzVwhDNw8a6fZ5n60vgA2YqECjHIwV5Yb9kYuvoh/LIuF+W+sOv6NQgImNJyHJ2x6JT+5m39t4DsXk8UIuoG4eQjgvINybJQZ4bBFowNDyWr1OtpK5DIlJ95BuOxNOApXO1ozJFxqwu+H3BxtQbwPYQVkjFO2LH3xo1pbOgu7NIZknYvyfW1M4+LS3TI/QEMGL/VjSwx0w6wq3Ua9qCUJENml9oLP1vW0azA8BMW7YVTRtYwWPrQ+dg7Cub+Xsryk7TsF9TeOIHq4FEMtbgv1lL6qssD2QXefKntDFzuelQDOUYQizFJ/9J/0sdaEvIqr9baF9yeVyF7x76GCIH2KX51AsFUriBrpB86iu2sj6NrPwjb1QWBYpEImReXWe7pQjjk7w9A9+uoCRQnIlDgElm/f2Mbi2O1pWbNhZcYjhIGb99juBfQ1n4+AZowm+7TWmNyjRZ+KxqI/rmaAs3E3gaod/DprgQz3dj7zX2lpy0yY6nSeUtwo4LeCnw1Mc8AE4b1OuXCjdeO2aT52MZnC+Tc6J4hd4X81SKxRCYAGEomfN2OCQ==
X-Forefront-Antispam-Report: CIP:131.228.6.101; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fr712usmtp1.zeu.alcatel-lucent.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: afVD5T45sNlP5ZC5JEnXyp6LfKpey6WZIF9SR4TkCbgga+tYaYpe5/rSx5LAVHlBVxRN/2KZfdaU63m/6gX4ey51MdXhkI34aFkxeTWAn3BVon7wy7FE9eIHQytN0blRlJrd/IHITYh4VQd9Lx52C1lO0hzuptVhgaZAnLA4GU2dSMuW8LHRecQpuonAnD6npjDASxwhUhudGtnNLKC3mumV4HuBWXJXnH3YZunIaVMIsMUQbQCuFYHjn9Tfa5L5bYt4KyvnzJs8GhRwnft9AFBROEqHshJ7T9Xi+Fr2tNNtKnfJ8HN/5jhNvcPblzL2Tb4+VBvwDnWNYj2EYBIdEeIIfaNQSu6y6p/9x3S9rdMuZOQnlrwwpMsSsGCvcR9BlIiz7a/GcpNXz1TPDNrQR+qnLYvKso4g64BmEF+KHzo29lZuSFRw4RI1GG+3Bb/2
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 07:43:45.3844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1dd551-2bf8-44a1-bf92-08defcfc6ed9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.6.101];
 Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR07MB11731
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

The wdt_start() function may be called with a timeout greater
than the hardware-supported maximum. This in turn can result
in a bogus print, for example, if the device clamps the timeout
to 10s but wdt_start() is called with a 60s timeout:
Started <watchdog@> with servicing every 1000ms (60s timeout)

Add a max_timeout_ms field to uclass-plat data, so drivers can
set the hardware-limited max timeout value there during probing.
For drivers that support this feature, the wdt_start() function
clamps the timeout_ms value before calling ops->start() and the
startup print now shows both the actual and requested timeouts, e.g.
Started <watchdog@> with servicing every 1000ms (10s timeout, requested 60s)

The timeout comparison is done in whole seconds to avoid noise
from sub-second rounding.

The value defaults to 0. For drivers that do not support
this feature, the resulting print remains the same as before.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/wdt-uclass.c | 23 +++++++++++++++++++++--
 include/wdt.h                 | 11 +++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index cce874dc000..418f1023a85 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -119,15 +119,23 @@ int initr_watchdog(void)
 int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 {
 	const struct wdt_ops *ops = device_get_ops(dev);
+	struct wdt_uc_plat *plat = dev_get_uclass_plat(dev);
+	u64 req_timeout_ms = timeout_ms;
 	int ret;
 
 	if (!ops->start)
 		return -ENOSYS;
+	/* Clamp to max timeout if reported by driver */
+	if (plat->max_timeout_ms && timeout_ms > plat->max_timeout_ms)
+		timeout_ms = plat->max_timeout_ms;
 
 	ret = ops->start(dev, timeout_ms, flags);
 	if (ret == 0) {
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 		char svc_str[16];
+		char req_str[32];
+		u32 req_s = lldiv(req_timeout_ms, 1000);
+		u32 tout_s = lldiv(timeout_ms, 1000);
 
 		svc_str[0] = '\0';
 		if (IS_ENABLED(CONFIG_WATCHDOG)) {
@@ -144,9 +152,19 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		}
 
 		priv->running = true;
-		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
+
+		/*
+		 * If the requested timeout was clamped, note the value
+		 * when it differs at whole-second resolution. Sub-second
+		 * rounding is ignored to avoid noise.
+		 */
+		req_str[0] = '\0';
+		if (req_s != tout_s)
+			snprintf(req_str, sizeof(req_str), ", requested %ds", req_s);
+
+		printf("WDT:   Started %s with%s servicing %s (%ds timeout%s)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
-		       svc_str, (u32)lldiv(timeout_ms, 1000));
+		       svc_str, tout_s, req_str);
 	}
 
 	return ret;
@@ -269,4 +287,5 @@ UCLASS_DRIVER(wdt) = {
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

