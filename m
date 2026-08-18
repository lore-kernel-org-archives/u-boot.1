Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE442C5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 07:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B74A608CA;
	Tue, 18 Aug 2026 07:44:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cjo1ttwOLy6y; Tue, 18 Aug 2026 07:44:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE0C4608D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787039045;
	bh=i9ugc8m+HkJPL0j6pw4Z8MOsJElXfCyabenxZWcmZOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TI94n0jYhFaevaJ/MJ1fQBcYgDPADoIEd730FgSyg678DhLrvP4ITqSNRrPbC5iWi
	 3GSvS+YFjsWYtwdyN1K3APw6XanoCRFsQ7zLC7Pmjl46EmpG7X8cXOpfI+Y+4cN/sN
	 lpTkAIW7fr1Yl4Fjlcne5PBsylwnPLj4e/o9cRnLMZKtZSfSinkP8FVyo7YgPxT5GF
	 1+ffthQ75PAoIXwe8tlQd/qh5HKXGgQmgnGsIAWxQTtsyaR3BaoOgHeTAYiJaB8XVp
	 YFKuXuJaELTQjZ649cn+sJi4xudwYVGIh2XRT5GX/hQihUNXJoi+JveBPcDAOSvrqQ
	 u7GS8bPwAI4cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE0C4608D2;
	Tue, 18 Aug 2026 07:44:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 252532EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B795406AB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RGXML1wfIdBG for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 07:43:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BD91040633
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD91040633
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=NQAeknMx
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD91040633
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQkBp+9gJpglDKC2L5L0BzZmFgy6/4n/xrfxeQxyOQZS71U9ql8UuAU1vhtoinCHLMenKTEBNfZW6eQUpenuZKn2LAHeL9AW+bpbJPEiVcDXgiXSDCqNZTRA6pRBTLSPqcKs/TCUWNEG4DFatFTz/+3gUBiTIEK8iTcnKOP0JEKq+obd6jYv+XTn80aoNFIfQlMIkf6Kg4S1XNKQoXBJUp7D9Kq1ssQDd1vNBfrF2e8M0i1S+lFb23nX65wBahUtCHDdDggst6RKHO1XpKidvGA9jwF4P/yHCnao2RFB6z9HfoiByBqYSE6jGOAmSaODew0+80YKlHjQASqsyzxfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9ugc8m+HkJPL0j6pw4Z8MOsJElXfCyabenxZWcmZOg=;
 b=ZnJdEM5bQHjWGhtBGEPm1x7cQP4yAeDKLpn9FGpQqnQGDXO66gA5EWQ6RdKt6xbB6rud8oWC5UCcIh0XZZgz5WaeWDTxOZRwOVWj9W8QFjIKoY3kavD4H2bZnf8zkpDxfDSfNdCPMDPfB+wL18l57YESN5ggrKz7oIuZnqOIo5LHXUiOWBpCxFdDSxDQE5OSkP3Keg/D7pZQu7dHvLzGNmioRqz/+qEozoiUe5raOM/FkZXwxEIpA4SEby5hA1xlKsEuIwVoCaE7QJ2J/c6d+Ib6Hly0870WyXj9h9BtpX1kGRGMvG+3lVArbcIcR5Kp1OhTIo1+iOj4ML6EKZGiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9ugc8m+HkJPL0j6pw4Z8MOsJElXfCyabenxZWcmZOg=;
 b=NQAeknMxpiiOZUKQhLdCLSzrr4kUuZ4phPjgqyy26rSTQOll4HtzNtxLy8WSVhjyji61PFKBsm71CDMPbCOxoLw6yT5Bporron2Mpm2BoVkZ8CjjePLQ1XyGBLVYycVCJrAf3928DGUgqxu9xw9ROY+50j6FfpcIRQsEdOqbKD+Gva/0o4gsG0Zsy2bzEhdYBCC0ueY+F8wglT9NwmZ1/bzvXMGvgBZ2QBRymg860ic/vC/zVNh7V6xA0ZTDuko7WNQdaLwXlHQXewCpKVlQy5NaqmhQCIX/junGK/JMrSVe05qPtBrhzE6Hcc/SkavKiehkE/ZU6H3mbAAZ+z7DkQ==
Received: from AS8PR04CA0026.eurprd04.prod.outlook.com (2603:10a6:20b:310::31)
 by DU0PR07MB9220.eurprd07.prod.outlook.com (2603:10a6:10:42c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 07:43:45 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:20b:310:cafe::99) by AS8PR04CA0026.outlook.office365.com
 (2603:10a6:20b:310::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 07:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.101 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.101; helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Tue, 18 Aug 2026 07:43:45 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 019FB1C0051;
 Tue, 18 Aug 2026 10:43:45 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Tue, 18 Aug 2026 10:43:29 +0300
Subject: [PATCH v3 5/6] watchdog: sandbox_wdt: set max_timeout_ms in probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-rinta-watchdog-gettime-v3-5-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787039024; l=1736;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=HbqzQJNchO31RM4yU1oVxhEumQXUNqj3mJ99tSmktOY=;
 b=b5DS6SoLwn1l4wBRStQk+SAfnK+1HELvXLHWqoQKu3Rwsgwi1ZTQ6KM/ndOmLQCCPQsLCKJmA
 YETsyBXP1NQCE+Whv3GFKuMPeip/6Ugs19O5E1Q1zEgf75c9q3BQeHq
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|DU0PR07MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b47c5d-7e01-474f-2d6f-08defcfc6ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6BzDiHqclBNw+S9f5rthlWCGXRuBf5s166hjkHp863L+Ev1I0OnemQXTU6Be4z6OZ6HLfeYd7UTNVD6i0DXnhmhUaqLGzsW9I4gUz2C6Pdj3j5y8TG5sfqJtSg4GdWKYHhp6cbvTE+jeR3kSLqkZPHy0gAt7gbLeNBmofU9dz4vvK4UQJbCWcJ++MEybOLyqw4hYAVPpME9Y3dUKxNviQmKFMegnljJTqfqiQ+kNrxuM5KoHAUSuFpOjemYWPt66dxY/rF4lRToZUvF2J206bRIJbopiqhrwA06ktTAjWjCENc4EhzfaIT+13YQhCw0IHQRlCBahWBJMmUvCJ6NOmXb0vbnzWMFyEoKlTIGizZ4iEvmqZbu711pKepvKiD0+JRYuPLEgAl35CU7qxJGKLoloJd/BWaJa58yBujRKiCTT5179/ns0TsLOL/UDWmynvTGXJ7gD2a/3PnUcE7sgJ86z2VsqwIpfFvywIXqHbegxFy3uZHI6QggYi3Q45fW1M5IJ9iY8TGFBCMR0zJX9W1ATZSZ0qP2P3uHLqS6H3c9de6A2mmsQ9p6Lc3+ATQRQa6C3payQhmitXYqmM6LMC4HTQjeGtz6zkq/D8uZzLcLZaeGvT9Y07jn3vEHFA9LYr6A3PPf0Fbs9jH8e79fhC2N5QUekrSBJR5F+b+C5mouRuTDgbeb2YMjtHocFvVh+p8uc8VEu6kaKcR4Td/hOqA==
X-Forefront-Antispam-Report: CIP:131.228.6.101; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fr712usmtp1.zeu.alcatel-lucent.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fmhxPBLw3Uy8Uqw/CfCeWkqB0E6UkfvsNUJd6XdKLguPtknkd8f+kVj94c5EH/5kkdd5WG66eJVCJ46tHTByj7w9NIjvGoO4Tnwk3nBWgyJcTZHxf5m2O0/vd44HjvsqeIun6I9isn57jRSZXAN8dnvOr0+8m5xXyh3z4IJO9NeXgCxlX0+Tdx0RatFdazz/krCBa6O04Q8qw+gNM7RTwptQViLweuaniQ0CvyUEegMv04ULSOpohRerRCNfQEMeJsUTK+duiOGPIvuOH9Zu02mJt1ExeLcRXxBLCdQsV7pQ+5SFGcOkDzs8y7jDzckQkQH/22jVjEdEPGLMGUWh/mQ5QHOc6abviJibY7dSvNABtEJRDEtI1YjT2Mrsm86x1bEXQV85vA0qb7Q7BbqR7bMOcBsMAeL4TltPxZJOe8QW9FK8sYGzafpBiqv9ZgEi
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 07:43:45.4782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b47c5d-7e01-474f-2d6f-08defcfc6ee6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.6.101];
 Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9220
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

Add a SANDBOX_WDT_MAX_TIMEOUT_MS define to sandbox asm/state.h
to emulate a hardware-limited maximum timeout.

Report the maximum timeout value to the wdt uclass by setting
max_timeout_ms in the per-device uclass-plat data during
sandbox_wdt_probe().

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 arch/sandbox/include/asm/state.h |  2 ++
 drivers/watchdog/sandbox_wdt.c   | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
index 9dea0980bfc..742e4f5c6e9 100644
--- a/arch/sandbox/include/asm/state.h
+++ b/arch/sandbox/include/asm/state.h
@@ -38,6 +38,8 @@ struct sandbox_spi_info {
 	struct udevice *emul;
 };
 
+#define SANDBOX_WDT_MAX_TIMEOUT_MS	30000
+
 struct sandbox_wdt_info {
 	unsigned long long counter;
 	uint reset_count;
diff --git a/drivers/watchdog/sandbox_wdt.c b/drivers/watchdog/sandbox_wdt.c
index cd5eadbfd21..9a0cdac232a 100644
--- a/drivers/watchdog/sandbox_wdt.c
+++ b/drivers/watchdog/sandbox_wdt.c
@@ -43,6 +43,16 @@ static int sandbox_wdt_expire_now(struct udevice *dev, ulong flags)
 	return 0;
 }
 
+static int sandbox_wdt_probe(struct udevice *dev)
+{
+	struct wdt_uc_plat *plat = dev_get_uclass_plat(dev);
+
+	/* Store the emulated hardware max timeout in uclass plat data */
+	plat->max_timeout_ms = SANDBOX_WDT_MAX_TIMEOUT_MS;
+
+	return 0;
+}
+
 static const struct wdt_ops sandbox_wdt_ops = {
 	.start = sandbox_wdt_start,
 	.reset = sandbox_wdt_reset,
@@ -59,5 +69,6 @@ U_BOOT_DRIVER(wdt_sandbox) = {
 	.name = "wdt_sandbox",
 	.id = UCLASS_WDT,
 	.of_match = sandbox_wdt_ids,
+	.probe = sandbox_wdt_probe,
 	.ops = &sandbox_wdt_ops,
 };

-- 
2.39.2

