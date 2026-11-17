Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9A606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c0HvDjmY;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=ZBvhoG1m
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 333CA80DA7;
	Tue, 17 Nov 2026 13:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kdb7_1VrN6Yc; Tue, 17 Nov 2026 13:51:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5076881130
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794923517;
	b=G7UqLNgkrIi6ZeT4QWrZANk2eXUc34/jMp9EKmOwwM/CS5iA3R7KalIbcb7r/rt4qUkR
	 lENfEoC6ZMdMX1bfe9X7jHndQ58QVe4z69bOxgxmCSvcxOSaGW4rDgAGEb0VaBuzdURnE
	 W8mX4cgnkXZwV90+wMuVyDlIN8qdTqsN/F5bfLpn5ku4xNHv+m3nk1WLMOg2yNGS55ViE
	 x8UnEavtts2CO6/35SNhjMEa4IAGmRltcUMWiI2bwl/i5zp9rnSPjy6ZbgHR6Mf6XefxT
	 xfXeqFsSoF6QCAXqSkcELmzaIm+FMQVvOteFIm8ImzRvqwsKLjvHKhwYGp+r/A/dIuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794923517;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2SszSf/Wq2CP/QGXv/ITu/sXR8iArONjHsdtmgjZ+kk=;
	b=LXRXJiCu0V5twgu6M5/vkGeH+r6nLY7MaAicZndm4iwBhwDa8FYTajceR2CxmfgGzVGh
	 HV6FC0tvN4lgKuCy9ZliyytEDc47pRueo+I84j9ZIYcNkQIU48f/Hr/XlRZV9Jk1XSQgY
	 Alb3q9Iaf78sb2ScLDh9H8kMCUsSMrZHKLjwrZbBMgxTo/WBNdMHtaCZQjNIVlorenocp
	 XM1CWqmaSvFgTjJH53uApR8lNqOQ/OpXEAvGFUEqHx4jBLeEqJXscACIaFibpuvvcwIX4
	 WOCrBnJPva72HPQTF6FRbvPYxZ0K10lym+/TGZqnZ5W0nseA4WAi6lmZ6mCHYd0Oicg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794923517;
	bh=2SszSf/Wq2CP/QGXv/ITu/sXR8iArONjHsdtmgjZ+kk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c0HvDjmYScb5joGQYfuAhxXZRBfOsiE59ajRXxc0Pp9qe+Wo2aphIPVfmDl4KhA9j
	 ypBjO2+Ab1o8Ily37AZfnFT+CWwv21A1w9alKfduKCMthCl0KcXfH2oVbrJYvBxSZG
	 wXyVtxeZSTQZkUFjaGQtuKML+QnOkuvRXfeu19hs5n2sn3SGW3CUvbju7Vv1WouLiL
	 +fCuofz6feW1h7mr0t2y35pO+J+FW/cXeRgyjKHOrgVA6jf+yCjorha2+wVwcQ7ANc
	 jPZvYq7IliCgcqMyCtL+yVaLF+2xR132kRJoW+mceDRuGfOT948k27fd7Q1q/VFPhv
	 WMKHRxBWzm6OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5076881130;
	Tue, 17 Nov 2026 13:51:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 02E6B2FB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8D1660873
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wuyqdnlybij for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 13:51:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CD50F6079A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=w.egorov@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=ZBvhoG1m
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD50F6079A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SszSf/Wq2CP/QGXv/ITu/sXR8iArONjHsdtmgjZ+kk=;
 b=ZBvhoG1mk/Z4plkDODop0tzSOfxQRY1xBa6/WNs7DKA89zxP3ggHuO5VWjVj6YFjQZ7OOPYvoMuk6wvSZ71SFBuM3WvMkmeNMcXXmcf6sTKX7C9RligfqbnTBz+ljZO6a9GhGHVD6u02gJNpMQBLNNrMkCPWC1fSfbKBLuuRPQQMMrqXlsjyagEKaa/iWPJbWBcfYqOnwx2sJZCOaLjkMZkiQHAcaRlYWyu7dbHTkjAqxYNiNpeLldZvAeaCD8KPQQ4x8T+VYnHyhuUOTNl0RXLk5pC6u0/PgrhZSf2b9gZHgwIqEqUlpua0KaWoNQ8BlIkL5EZsmMhN/qMiMcBwnQ==
Received: from GVX0EPF0005F693.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::13c) by PA1PPFF32EAA739.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:108:1::1e8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 13:51:48 +0000
Received: from WA1PEPF000099CF.eurprd04.prod.outlook.com (2603:10a6:1d8::167)
 by GVX0EPF0005F693.outlook.office365.com (2603:10a6:158:400::13c)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.10 via Frontend Transport; Tue, 17 Nov 2026 13:51:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 WA1PEPF000099CF.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 13:51:47 +0000
Received: from ubuntuvm.tail7493ff.ts.net (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 17 Nov
 2026 14:51:42 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <u-boot@0leil.net>, <quentin.schulz@cherry.de>
CC: <kever.yang@rock-chips.com>, <anshuld@ti.com>,
 <aristo.chen@canonical.com>, <alchark@flipper.net>,
 <u-boot@lists.u-boot-project.org>, <upstream@lists.phytec.de>
Subject: [PATCH v3 1/3] fdt_support: Add /chosen/bootsource fixup
Date: Tue, 17 Nov 2026 15:51:22 +0200
Message-ID: <20261117135124.207113-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261117135124.207113-1-w.egorov@phytec.de>
References: <20261117135124.207113-1-w.egorov@phytec.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CF:EE_|PA1PPFF32EAA739:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0d27ad-cc04-428c-df50-08df44b1ec92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|5023799004|261026121527099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1yCV2bnThkF3cjl1hiP05Sx4bcV0Mm302Q5cI18We8LF2wCwJ+qJ/UBBwt5W58wi8rlggwunlMiQa9olZZE/86m47aIiWas+No6u+UYa8AYagjm3AseCbUwc5k8BUnhRptCqTOVbqE9xDUW3r7RK3qTSeplx1hSeMEnjNw66eOejKE9mPkExTz/4aYaa74X0BBTxAW5vuRX/C043i5ZUwIIWopTKdMZQpeI+Z9w1yIGzNAMPTPD3mzFXX31aMmEVpgoxXyOz0Ji8p8fnNLaeuFiAK8PxrP3Er9G26ib+28EVa3ne7XRhME8+IlVWYWvzdfA1t4eqfGxYLV7aB7bGsJVkh96MJ3pZ9aMsZtLzP1wPY/9g63xD1h4JOu3f0UCwDaq/wblofJcAzDEYL/3ASmUf4cMT4C5APD2J95mk98RQ6hERZZyLnhvy3yuQriKnVldYr67Wh3BNVMWUgXDfLOhnY+8BecWtClTjrG4uY1i03dt/Nkc5lzBGN6C4RFEk7h9dL6nFKVy3iwt684vZuTnz/5cLgDXzyqBZ9YFM/nyPENpzrLlXmBWdkG09uDNEdsBgDWkgiNc/HrHG/MHqZsQ1xuQ1PBS+qiB7hydAV584I66/vYfMdw5pAqcopIfhCX+iOO7eIZJQMHe3GohN+nlTHKjj7zvBvX7CwkMTBZvahpztVUX/yL0Klx4Jq7LOnW0m8KYT3PNs+d3a8tqyyA==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(5023799004)(261026121527099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p0LkR3mYulXI/9UA2E+ealssZAZzoYXKVsqzgHROXMNNBfCpl1SHo49VqxwoTdt2Cf+ou7vnO8RsHJ/DXrHNpkyWB5qyf29CJIlr3Xx4sCaVPi/QFAncGNbBacfNaCQxwS4T7suTYz4Vww/K6ymbIZtIRzpW5nsNg0igfDRzE/2CaXrovb2v1ufcvhRw0c7ruNG4MKED5isi7A2iAIiRrA7OBBtc2XXYhSMYKHGgN2VJcLPo+g/JnWmUGb1oQoWoz9nnHjV6rJ2/arG967GRYJV9SQqmSj06oCIwKYA9L8fgwB7vd3IyjtNool1Aajtyyx0WlQE1LpRd89sUMV6IlOxrPa384RgwpOviUAbLxYYxJpgEXPknoFHS+MyHyD/CwyNOeKxCw+yFr/CNyeWzAN4kjdK0z7sOdue1mTxX/bArFGLPckQVmroHKUokqinq
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:51:47.8277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0d27ad-cc04-428c-df50-08df44b1ec92
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099CF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPFF32EAA739
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set /chosen/bootsource to the node of the device the BootROM booted
from. Platforms provide the path via bootsource_get_ofpath(). By
default we pass on what a previous boot stage has set in the control
device tree.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 boot/fdt_support.c    | 35 +++++++++++++++++++++++++++++++++++
 include/fdt_support.h | 25 +++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 2941df55996..0557b4d8506 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -334,6 +334,39 @@ __weak const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba)
 	return env_get("bootargs");
 }
 
+/*
+ * By default pass on what a previous boot stage recorded in the control
+ * device tree of this stage.
+ */
+__weak const char *bootsource_get_ofpath(void)
+{
+	if (CONFIG_IS_ENABLED(OF_REAL))
+		return ofnode_read_chosen_string("bootsource");
+
+	return NULL;
+}
+
+int fdt_fixup_bootsource(void *fdt)
+{
+	const char *path;
+	int chosen, err;
+
+	path = bootsource_get_ofpath();
+	if (!path)
+		return 0;
+
+	chosen = fdt_find_or_add_subnode(fdt, 0, "chosen");
+	if (chosen < 0)
+		return chosen;
+
+	err = fdt_setprop_string(fdt, chosen, "bootsource", path);
+	if (err < 0)
+		log_warning("could not set bootsource %s.\n",
+			    fdt_strerror(err));
+
+	return err;
+}
+
 int fdt_chosen(void *fdt)
 {
 	struct abuf buf = {};
@@ -353,6 +386,8 @@ int fdt_chosen(void *fdt)
 	if (nodeoffset < 0)
 		return nodeoffset;
 
+	fdt_fixup_bootsource(fdt);
+
 	/* if DM_RNG enabled automatically inject kaslr-seed node unless:
 	 * CONFIG_MEASURED_BOOT enabled: as dt modifications break measured boot
 	 * CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT enabled: as that implementation does not use dm yet
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 47b8b63d13d..f287c81e755 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -55,6 +55,31 @@ int fdt_root(void *fdt);
  */
 int fdt_chosen(void *fdt);
 
+/**
+ * bootsource_get_ofpath() - get the path of the node of the boot medium the
+ *                           BootROM loaded the first boot stage from
+ *
+ * Platforms implement this so that /chosen/bootsource can be recorded in the
+ * device tree handed to the next boot stage and to the OS. The default
+ * implementation passes on what a previous stage recorded in the control
+ * device tree of the current stage.
+ *
+ * Return: full node path of the boot medium, or NULL if unknown
+ */
+const char *bootsource_get_ofpath(void);
+
+/**
+ * fdt_fixup_bootsource() - record the BootROM boot medium in /chosen
+ *
+ * @fdt: FDT address in memory
+ *
+ * Sets /chosen/bootsource to the path returned by bootsource_get_ofpath(),
+ * if that path is known. The /chosen node is created if necessary.
+ *
+ * Return: 0 if ok or nothing to do, or -FDT_ERR_... on error
+ */
+int fdt_fixup_bootsource(void *fdt);
+
 /**
  * fdt_initrd() - add initrd information to the FDT before booting the OS
  *
-- 
2.48.1

