Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ECBC5DF67
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 07:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E0F080FB5;
	Tue, 18 Aug 2026 07:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eviZFW-QnZN8; Tue, 18 Aug 2026 07:43:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E98E380EF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787039039;
	bh=kXumPUy5AkX2CfI6ct7rBpTRPY1gksGQwUdiz6kKgvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QPtzvEIhwhNnfG707VIv2eVbPH2xqVhEST9Q8tq8OfMiFnXTVh0sLrXZnmR6TwnC/
	 vSPEuO2xh5/neOB9VjBV3EyI2/w7QwkFgYOmf+WCgjO9dwy/HODAF+LdBoAWwUIhS0
	 JmyeeCtsNg72LjzQKQIs8o0W9yufTvKZ6TJLwZTCWsZH/VYUNNMdXWk+4N/5lBrG5i
	 NZWX64COMi894cZP3I6GgQ8CukQP0AkYDTNlKZ6oASc6NCzDanCnaPnxes7fP3eKn5
	 j6OD80Zvju5MfMzpYUL3l0xfXhr1W52rsi1ylHCrHlopxUC1yxWDGjqdSV2f+IndGr
	 JVX5g0ukA+L/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E98E380EF8;
	Tue, 18 Aug 2026 07:43:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ECA112EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2CB8607BC
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NfYxk0HKkPKc for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 07:43:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B7F45606C9
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7F45606C9
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=uYBkRlkE
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B7F45606C9
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJTyFoOMzywECQpd1pySI2yL6mKgpxPXl0Hc4tTCPxWXUzd/0vefxH2YGMW2phjqVHeGo1FFg1UMq4Ko4DjfAyTR0cav4L1UuB1b69oXLYjT4EoDngUmgkp2zs3JufHdzuoy4wb1T6gdR6QHEvzaJFqSoimBzb5GcWxjDV8xammytyy0FNc32AjxWQJQOVnvFQRPZCnqac0dyO5gDfBOQiiuOJ04z4AqwdDkShZaPgQivMufmRUkloBYHo9djcmrx0+KXHjlf+bYgITIyqqJmnzyOlRsOmnovBX+YJt+Sk0MkMd6EZpygQqqEoeZ7EdW2TfvCBZBgu42OePp1NOUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXumPUy5AkX2CfI6ct7rBpTRPY1gksGQwUdiz6kKgvo=;
 b=YKIQiS5QpE3KhcNTQJOkn+eTaEjjNmMa7zOgixqGaZZdJlFY0kDultPVeqRbv8//Ahk0clUl2BrhF85TiZu2m67J6Wf1r9SkQbbG1LdkNQ1KFC1yXTFNwXuovzWXIhVTVPXSzjkSBuT7litmnUWvEcBgy5oMtzZ12UO0vzlon8/MayCcw7B6OMwOf6Pr8A8ga9hXQxHlNWUVZ63FR6zODue9zmdeJ8jJlLPDNz9c0Y0cmJnze5cpmPE1t0pFxzDXdc8Huifjvz9uZQgDTJ/6EzXNyWWYqZ4erDuV9IS03Gj3X9M0hsKz+Y0LMWXsFyFVDoaEXyJG5RHg4AWZnHUvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXumPUy5AkX2CfI6ct7rBpTRPY1gksGQwUdiz6kKgvo=;
 b=uYBkRlkERGirouzIq3Aj9mePglJ5jpBz5aTzZzMPAHdU+a4Vj9RFJ8KNWGiOo2PnYzWAm4OvIpUIdgYIcXnHXbKhz6yYpjlB9f/1hlScL9VMb4y338/6DTh/mCG0vYAZJgYqQE5d1YWz9jBGmjkAUFp3AMqw6VshFSBTiN1su48vyY6gQTvcW1QvhL6l64B1tskP8LJSn3yYbp9GKEnCRQiNcKCTCP2VFDvu8dq6tpMB1IURraNRmd9vUUNVwRMx9EbnYHm4abeOpK6MPXSomr/88EOjWkotN/26mkaW6+cLkTN2kJFNDGMp3s+JTKFJs3A3pU9Tgo5I0YJ8nRto6w==
Received: from AS4P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::16)
 by PR3PR07MB8052.eurprd07.prod.outlook.com (2603:10a6:102:14f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 07:43:45 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::a8) by AS4P190CA0027.outlook.office365.com
 (2603:10a6:20b:5d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 07:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.101 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.101; helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Tue, 18 Aug 2026 07:43:45 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id DE2B81C0047;
 Tue, 18 Aug 2026 10:43:44 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Tue, 18 Aug 2026 10:43:25 +0300
Subject: [PATCH v3 1/6] watchdog: wdt-uclass: rename str to svc_str in
 wdt_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-rinta-watchdog-gettime-v3-1-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787039024; l=1473;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=Lt71VOYoBULxJ0T9jjgZ29nDXS87W/t4C8FXpA5bGoI=;
 b=WEtIGDtiHFBzq+WVFrrwLPfKZrjH6dORgwLI5nWrs8itGqMx6xAuBWizMOEETkI7BdqHcxVqZ
 5abIePTtn3ODnWeuBpNWL+1m95BLu+i4PyFp034zGMPW/tFaTnXpupr
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000043:EE_|PR3PR07MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1ea7dd-e468-4506-469d-08defcfc6ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0QU4OwWCH3ziLO8biiHn7dPwSk+a6oERdYdK2oAOIMD58WGmcFRzyYPjOSCCXhyiNVIQO3cdn8Zdn1zQFWz/0GwNSoa6lxBge89oc57OeHJ2wjtzKezS08Fhsib767XQcZWumisGUVCXjRP86rEbokmxPIRehNjqgn5No3ttWBeP4C8RjuNzs+U0jv5YqcGi0FTxeSLvmzIT5GdTKCyoHfH3VYghl341PDatPBYJLqy6KEbZBuhaUDeLHFXPdaUzXuXLKTX6GbBBCaJoi+M5PBP7ZsR3guboR+UcMq//op0U0PnduNy02cWpd9EanHqM6USE8bM+4bWc3dDj80pBuAACH7z7nKggNw0q0XzkdAK7dhfmIrbelXmGp5vCUMygtxyZ9ucS0zfL48KDj2CTPHUrjnXDd42t8wk75xGSCrOSTCeVuRQgPAcppAVEn+Z2Djb6UcAAro1d0Xg9o2J/uGO+sk1fbWYP4O2LGfKw3uj6BKvzyuwLmC9rg0ZkFrx/fQKnjdT3n6EjrBvw9QJ+UfvmYEaXLEanccG0ziJJZeLIO0yFMQvefKbXxLK9Dmf/squ6sTiyCew3uMBzBuYO9g2G/AVWyMj1Oa98bO/e/HxsXjcVEOs+TD7+8f4Ev+ZmIbrZLcd/U2gTAlO0yRYskCnjn6QhmjVQR/JxC2kdP4cfAEd2xMaUpDUA6mZqxpp9uiOCNpxVXz5ljqu5if4kyQ==
X-Forefront-Antispam-Report: CIP:131.228.6.101; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fr712usmtp1.zeu.alcatel-lucent.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZyZgKOoiFBkyCwEklJmoa3mPohjzXmyd3tSEscDXdLqdhi+JRPZL541ri+tqXRT9eJeBkZqHqL5USXwX+biCP+XiD4IERJzy3FZElZEVVJHiA7BPQw1DEifryUQulseD9ZxVKCSLfGFsgYw8vRr5Bsi96pqs9bV9rTXcAHTCc4vf36ZvsPouFjIQ/7v6nBz/c2fJ+PjNMi7FQEDNIEBcPLcKkFvaGPgS50T3lyJJ3zsvtwdgzCvRx4gIrKNTKL4FTzg4xZChigcY4J5H5o9Qsz55ZXcK9PAWi/OPrW2QFzInPz5ZGJ14s13CcU4TqMyZw5Nj2w3pmIfOjnH61Q6F1GuLG2LWYaiDMbGvgBspLRyw/cNEar6LTuxHuAh4D6BLOcm+cV2hShni1e31SPK4BKXa9TRR+mWPEyHLZu0IvRmK0A/RgnmBmvZrJkJpKuE+
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 07:43:45.3161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1ea7dd-e468-4506-469d-08defcfc6ece
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.6.101];
 Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8052
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

Rename the servicing string from str to svc_str in wdt_start(),
replace memset with svc_str[0] = '\0', and use sizeof(svc_str)
in snprintf.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/wdt-uclass.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 438833b2245..cce874dc000 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -127,9 +127,9 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	ret = ops->start(dev, timeout_ms, flags);
 	if (ret == 0) {
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
-		char str[16];
+		char svc_str[16];
 
-		memset(str, 0, 16);
+		svc_str[0] = '\0';
 		if (IS_ENABLED(CONFIG_WATCHDOG)) {
 			if (priv->running)
 				cyclic_unregister(&priv->cyclic);
@@ -139,13 +139,14 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 					priv->reset_period * 1000,
 					dev->name);
 
-			snprintf(str, 16, "every %ldms", priv->reset_period);
+			snprintf(svc_str, sizeof(svc_str), "every %ldms",
+				 priv->reset_period);
 		}
 
 		priv->running = true;
 		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
-		       str, (u32)lldiv(timeout_ms, 1000));
+		       svc_str, (u32)lldiv(timeout_ms, 1000));
 	}
 
 	return ret;

-- 
2.39.2

