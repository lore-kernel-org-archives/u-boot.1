Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF8CC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 04:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D54928498C;
	Fri, 10 Jul 2026 06:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="tZ0q309g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1399A8498C; Fri, 10 Jul 2026 06:51:49 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60CE2847AF
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGzDTFrS4JsSwT6wLqw1RsiL7Rmn0VIQTGqo1Jx/h2nJpuLpu8Nqtg7F0x/8LCDDCUjn9Khfyikn7xiraNgZYJIXJtg/vChmOxchvaYs0Cj1WyU2i6rT9et4uXCFEeYH0M66wSQ4gQsBh28D/Z63PCrhJUjob4J2NH0mIGW30BfZZYGovbeh18+cDIYAzioRRINY8AmPlVGRtU17e1yeUESZx32561nUNOGQh05aUlSzXFznE9onwDEsMs23B4W5kgsnrH5ZcSv6I7uG/ySxZ4GGwzClhgEH0EDsAz88Liz9ZCD7QKQpWmjLOpvWJxc3m9lkfA2p1qdE9faf2eABag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/PM+9gfVv9Lrq/g//N6TJ6IYMNp6/Nfavt+sPKEpWU=;
 b=WOVhQgkxpMsM/xN+3RfKs371H7Z4wqlXKeMax+X/EDqxCkNeZs0xVFEHz77nrK2AWdo8+tgst5mYOZRNE9tWyD7XRQ7k3RllsPrKUhArYf3MXMLJQSJkmoiCgi4zIF0vz0WaVors+px3IvWrls84uBa0RD9haxiPxw7g1nyGLZaGEuOX47kwGFlnVoT1sNH+wWCF1FFF7lIbwindiUD0A4VckZZmFb6PCoYyIQ3nsbd4oSZ5iKqobSJWrNMGrJbSwsGbyb+FlxVzhrNROgA+1seDGIDsl5b5O+5pU/EPK9KLdC5vAlhhu3T/MCImYT2VaWMe0OpCWb+HECnEfbqvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/PM+9gfVv9Lrq/g//N6TJ6IYMNp6/Nfavt+sPKEpWU=;
 b=tZ0q309gxXOeWYkfh0Utbjs2C8wmZqZU6iKmNddZpnlrEYvAl2c19tgNSA1RziFHN8r0xn8v8DWClIcvUlZykaOD0RyQXJy8p3mwRrxGbarB1KW40wcAx6dJxGmU1VujUpyDN2i41OI6iNa6s28pUoRawU7AENnrRzZGix3+OAc378T/JOEx2YfGPTBZw/Dp0UtMLS22C0xp9hL2uPlzLZYvV0GLb+RpUi3JPEe/7jgqChA4rB8rrOXM6mtknDwXEkaoorOEOn8WZTvH9HsN9ZNWvuIJXYTKTRDcODWhF2uGHuQexfub5dpATRY6/pEKo2dT/ojzCojoT2unJe1dmg==
Received: from DB8PR04CA0025.eurprd04.prod.outlook.com (2603:10a6:10:110::35)
 by FRWPR07MB10659.eurprd07.prod.outlook.com (2603:10a6:d10:16f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 10 Jul
 2026 04:51:43 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::7c) by DB8PR04CA0025.outlook.office365.com
 (2603:10a6:10:110::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Fri,
 10 Jul 2026 04:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 10 Jul 2026 04:51:43 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 942A123CCF;
 Fri, 10 Jul 2026 07:51:42 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 10 Jul 2026 07:51:20 +0300
Subject: [PATCH 4/6] watchdog: octeontx_wdt: add get_timeout operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-rinta-watchdog-gettime-v1-4-9a982fb93f49@nokia.com>
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783659102; l=2338;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=iwxwlaOxw+rggz1PuuY4ZNzl4WopSVA6+jBHo0sgRrw=;
 b=alLcqDOQd0rc81SlZQr0eBFjiDuGqh9P5wTTuqrQdqqgL4thvYEldDoM3fn6cJiROleYGfm6A
 Q10eTwgQaYoA7q54QC7WILQ5PccJACoc35N3MUwLGcP+GWTT1dS7ikT
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|FRWPR07MB10659:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2c4bc6-e2f1-44d4-8cc7-08dede3ef02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|11063799006|22082099003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: BKkfzaYYM9ZrNuLhehDlCQ3phdnkAwFDFK+puh6PmWNvjvye14MVt1ik5nmwDnFMszOUMgEak39Xf/UBbvRiO4JkvWSU7Q+FJGJFx58MDgKYVvZpEzvkOnhlR+HsFPMtnYRzaeUoWR+QJuZKmEEL4XzH4wmDD7oQf1VCIn+X/S2NNLgLFDvkxFDAWGYATcKOBoAK/q2IBVHHJ2IfRdwJbf2nY1gHpg1dUlTefxGPg4kMKvQQSTb8xcJ8IeePhB5rREhj2p2zlUZPykQRrBDeuMlJ0Ycvwcohh7C0ehUdNUhsqoOvIjSEQWnETZIyOYdXqS0sEISAhkF127Q04g9GkXIvvffIQWiKPtxuabeon568aRUaUC2jak/WLyi4t5ZUSnGrhMTJrd2KOPc3r3ZrKTayuzIpnyOltS98p8Acu7nUbwvLiZkU8uKWITXF88VO8WQKSjLT827+hec6tFoO4BwGH+1/MRmqPzOmtPlEHwfHTUqDJvu/IAN+CPqETCW7L7IZ+/CquS5BXVndZu2GZHu7OlnqWx50ZUu1wkHpXSoF3JjZw6SciZxWVnxx4ZuGLfI0pnWD/PjeinyWvmFqcR5r0/nOjgeeCmHULjvWfOS5uD3WMa/FQ2uT94NhuoQOEplc7Bq1YVuIUIyoUPZ6pqUeH9mkMn7Kc4qzlTPVlnlI65V91OlNx7Zeq+MRLaJVD1rmxRcDKMTo25ZOp9qRDQ==
X-Forefront-Antispam-Report: CIP:131.228.2.240; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0735.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(11063799006)(22082099003)(3023799007)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O/ZsfEwwiB1jvVmA8SqcMb62lsUQ9jsmgb6kuQResZAMuKlrAXJPjVvRQ8y/uSIEOtGEtqw872qtNGMxtC9UzOOOaL2/4tYzUQBGXaKqPjtLeWEjalAZ6iXBEE/LR8UPcPkkV9dFFIZhBg4MZRA81y3oC4M2p2OB+fOAEUCTOyNPoprhP1mqArB4PDL6cY5N05iYMxptgfPFYTWpDiG7A3UbuE2cyFb7DOlaPtzEAhtJvkR1YSa/hBT2BLVqo0G3JkwfHaq2yKGQvvih8uFo9+Y74R6Z+7Yuv5Xf2jVWKoYLR+x1wRIIckCx1AbnXaVSKddyCl/4cGD32Ggd+QoSyrYnGSPnrInFu9eZwSxc8u7aQ8exXgyb/32y3mFZnLoxsmcXv+NzPH/w6DLb6ZQq5CRLZ+Ntmx/tW2QYfz43nGFIfacnVch6UkTYTusG7PdZ
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:51:43.0922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2c4bc6-e2f1-44d4-8cc7-08dede3ef02e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.240];
 Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10659
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

Implement the get_timeout operation for the OcteonTX watchdog driver.

Add a timeout_ms field to the private driver data. octeontx_wdt_start()
stores the timeout after applying overflow clamping.

octeontx_wdt_get_timeout() stores the effective timeout
in the timeout_ms output parameter.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/octeontx_wdt.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/octeontx_wdt.c b/drivers/watchdog/octeontx_wdt.c
index 7299a9f9739..e1286ac165c 100644
--- a/drivers/watchdog/octeontx_wdt.c
+++ b/drivers/watchdog/octeontx_wdt.c
@@ -31,6 +31,7 @@ struct octeontx_wdt_data {
 struct octeontx_wdt {
 	void __iomem *reg;
 	const struct octeontx_wdt_data *data;
+	u64 timeout_ms;
 	struct clk clk;
 };
 
@@ -38,7 +39,7 @@ static int octeontx_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 {
 	struct octeontx_wdt *priv = dev_get_priv(dev);
 	u64 clk_rate, val;
-	u64 tout_wdog;
+	u64 tout_wdog, calculated_timeout;
 
 	if (priv->data->has_clk) {
 		clk_rate = clk_get_rate(&priv->clk);
@@ -61,6 +62,11 @@ static int octeontx_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	if (tout_wdog >= 0x10000)
 		tout_wdog = 0xffff;
 
+	/* Store calculated timeout in milliseconds for get_timeout */
+	calculated_timeout = (tout_wdog << 8) << priv->data->timer_shift;
+
+	priv->timeout_ms = clk_rate ? calculated_timeout * 1000 / clk_rate : 0;
+
 	val = FIELD_PREP(WDOG_MODE, 0x3) |
 		FIELD_PREP(WDOG_LEN, tout_wdog) |
 		FIELD_PREP(WDOG_CNT, tout_wdog << 8);
@@ -88,6 +94,14 @@ static int octeontx_wdt_expire_now(struct udevice *dev, ulong flags)
 	return 0;
 }
 
+static int octeontx_wdt_get_timeout(struct udevice *dev, u64 *timeout_ms)
+{
+	struct octeontx_wdt *priv = dev_get_priv(dev);
+	*timeout_ms = priv->timeout_ms;
+
+	return 0;
+}
+
 static int octeontx_wdt_reset(struct udevice *dev)
 {
 	struct octeontx_wdt *priv = dev_get_priv(dev);
@@ -142,6 +156,7 @@ static const struct wdt_ops octeontx_wdt_ops = {
 	.start = octeontx_wdt_start,
 	.stop = octeontx_wdt_stop,
 	.expire_now = octeontx_wdt_expire_now,
+	.get_timeout = octeontx_wdt_get_timeout,
 };
 
 static const struct octeontx_wdt_data octeontx_data = {

-- 
2.39.2

