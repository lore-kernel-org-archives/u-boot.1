Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905E606A324
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EIwEPFn3;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=kzBdxxvY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B28B581188;
	Fri, 27 Nov 2026 13:04:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZAOToIKgyLB; Fri, 27 Nov 2026 13:04:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EEFD681222
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784680;
	b=iv2yBKjFWfSSNMZ2PMhIuvVt3rBJqFg2YSZhKINOghXsvkQbSHYvB1kJkqb4JXC4xfBp
	 jLZia3XkKpUvcnZo239LQEH6E1+10OYbuRSo4IuVP65UDMGLt1WxgUfPlLk2wzKNdPeXn
	 DyW81M9RYRY3KE2jgfAL8diBpSalOnjdg8Byqfv5kdoB7iyx6zCZy1+/Btel5lcIEmqDC
	 kN26wCeiZBTWNjT+gStRwqvf57ocJWbn5dglI9EFP2O3ZM47F6Oxe1kIeKXX295mSL+Jt
	 75MHRXHw7eNYhT7I8RgybPYrNEa/DA+0Kp1jBwCOQza2fBZdjgL2//v5EnAZb0QgxbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784680;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
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
	bh=s62w8VBvnhVtlXw6qurVGsS5p8ByyHa6kbzkdJLhEng=;
	b=OnDqpfYTjcKbFhNjvkQwgDGjjSUboXdZjg0hP1Rjy/nQrNf9D1loQ1hpOX6lKtNtoQgP
	 +KE4m/bD6I4IpMKyMD8AJNJwOn+EAfWKtr8qNoNNLEEpmD6teYj2Ueg+0bjRIVXjm0M0e
	 oYHWQZKkQBgliHmdd7kTWduA/ZDY+AkR5LvLlP62oY2nroxb6+Y4kEr0nVEm0EZJan/zz
	 C0wKlBGjVdQQx2mgx+8au0M+h8IFiEaKkNYjXFStV9xHpMXRDVNH5m8urTbcMFcDdH5BZ
	 L/6B3omdu2PiFokWbFp7YezOPdW7ZUHTCy+2xdCI4Zpcm1EB4Ggzvw4uBCZPJPDwPNQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784680;
	bh=s62w8VBvnhVtlXw6qurVGsS5p8ByyHa6kbzkdJLhEng=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EIwEPFn34nVdAZubHk7GaVkZwO+Qkod6bUjWnKSGXDBZbIcRTMy/PwkM6ROaZHqsX
	 bacxo8WC6msdRxJ+vA7Viia7+Z9w8SN56e7rod+sV19aJHQBqnfuoJgKHkDeCPnipF
	 dh6mStTJ+csHZFaBrllNjSQvrYyz/+Z1whQp/B7N+tzHsKjH3D3SMRPIA5NJuWeJmK
	 zDl9+tQ3oYiMKkafQDoL355OxgqZBJQ2JLcX5TW+qSnFxjiLAKQ/s5jqYf18QYAo2r
	 63LSOZ2cdjNMFfUYBY6esvRnY0buxoUUBH8+G9q20KincWhN/nwb+n1LVBAmGWMKs6
	 r29yD08uTDEUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEFD681222;
	Fri, 27 Nov 2026 13:04:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D8C2E26D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA21960AC2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bx76SCbCZeuU for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:04:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DDD5A60A54
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=kzBdxxvY
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DDD5A60A54
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s62w8VBvnhVtlXw6qurVGsS5p8ByyHa6kbzkdJLhEng=;
 b=kzBdxxvYM9yLSW/ikun4PRafA7sHrEWwtMotLwjaMRMO8FhQPL+L0P7W/GLjq9qMJT8FtX3xsfFQmxGTevgsrlICJqN0iBMLMT6N3dw4/F+OIkdAWR9cnlV8Y8ZpjqneA9J8h3zoTFPjObi1O6nfshxYTdv9gWSXwNYIZ8Rhf/9Myw9gxDVkmdcqm1Gry1eTPeRncr25BJifHlOaDYwEapoONsl15VnCGcRKc8MFS9zte/RlfAe4pYS7R/8o0LKubWonvUtVfyWcLQQcocSI127Ri0gbIgw7cFdT6zo6a2Vy1kVWjkUpo15nPeO709ygHesnwHyYoFxnX7IfqFxUhw==
Received: from AM8P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::22)
 by GV2PR10MB9723.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:359::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 13:04:24 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:20b:21a:cafe::13) by AM8P191CA0017.outlook.office365.com
 (2603:10a6:20b:21a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 13:04:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:04:24 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:05:30 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:04:23 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 27 Nov 2026 14:04:21 +0100
Subject: [PATCH 8/8] rng: stm32: update default RNG configuration for STM32MP25
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20261127-upstream_stm32_rng-v1-8-b8b4a9fdc8a8@foss.st.com>
References: <20261127-upstream_stm32_rng-v1-0-b8b4a9fdc8a8@foss.st.com>
In-Reply-To: <20261127-upstream_stm32_rng-v1-0-b8b4a9fdc8a8@foss.st.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Sughosh Ganu <sughosh.ganu@arm.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 =?utf-8?q?Maxime_M=C3=A9r=C3=A9?= <maxime.mere@foss.st.com>, "Gatien
 Chevallier" <gatien.chevallier@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|GV2PR10MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 77988f22-abe2-4100-139d-08df4c86f5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|261021123027099003|10067099003|261102123227099003|11063799006|261026140227099003|261022075727099003|261028144727099003|261022105027099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 011s+LSoR3uTlZjfUCFwtgWjJtPdDwVuKNBfBL6yZZSrXe+1Zt+aSnc018Cip0Z5pcTxCjuOKC/2K6HA1E9plwRnWn/x7LaK1uobZ8mUt/lf+yi84V7O1qW3QOC+14SWKuhkIX2E30u18N/MNdUKOuArE11e1Aoo46G0CRAlEVhtEbwkYl2Uq8wlkPTYPTxgXw2b8xej0tgwRqNpaFQzE4tjmNsl9XzZferf0dIXlq7WDC6xm8c3X/c35+IPPTTD28daqOHi/XuVvmE7ewJePAFgSQz/3x0XtObLCs1uHWmg29m2vsmQwZx3bCJ51LX0UJC1RvKmGZL4AA3eln5tE2oz6yz0Y4KUWCI7AG84/CsrPDqgq03vN0lyESRmoVu/5y7vsuaVFQ29HKkjhpuH8QS/Gwod8//2rMvjTmvgrSXoGfwObfPifz0XMxZbtts7O3i/gZEwQRWM/6DpNS2C3AC+MpJGgr0yfzDZInKIrsLjgzCQyIZ5t/CFNE4/gbexbc44cK/DqKXiQnrNr9EQmoztCGMnSpSVO2PA5078citzebgtSqVPhhB8OEu8kEG3OKAjJbaaQOddkISQKBPcLxXdeAsMj0VUvlCNljGwzjBMmcP6+BofeGmzDA/ZL5awADyr5N6Py4RI2d9OHy7U1BXOzevMfbanlcsIjX3HUTcGBPeLIlXDvtU0L1v8DG29ILxh69OQHY7+L8tnS3Ly6w==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(261021123027099003)(10067099003)(261102123227099003)(11063799006)(261026140227099003)(261022075727099003)(261028144727099003)(261022105027099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PnMk+vnEfJNJstMM16i8ej2UkXOTlfGMs/9eSJCESIUQ9S0Bl+Zy+ErUCzfcpp3hZ3WyQ/HEyv0WUlWahxid0ygrrg7GNvQ/FnAl2OD8BQvneMNMGIhz2/gjYdsiLN4K5fqHkZ2ezfm4uiIdmDj6YKeVPDHGQwIhAvvIxV8xG81aPDvHfOVERmnLVsfgORIjPL8T1t4scwvbcK19WleCSMb6ibljLpx7QGNfVoaJtoV5R3ZVp3LAjo4sT5JwgTnWqRjPUYXVzjUNPHrd8/n9uA2fU4zGIEb2WiVNAQ79ErD5YCwvEJQdhpGvAKIbIe8wxJz75F4ZlYpfQ+iXKHTXZn8T1zRuFmX+SK1ssFVlbi0QAx+Zln6HwiuEHn9IuNvcaUVAq6YvlPfyWU60ucK8ygpPeTpjIRX+YSxC4mhmQQmEFYzseM1929ciTP9MMl68
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:04:24.3094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77988f22-abe2-4100-139d-08df4c86f5de
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9723
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Maxime Méré <maxime.mere@foss.st.com>

Use the configuration used for the NIST certification.

Signed-off-by: Maxime Méré <maxime.mere@foss.st.com>
---
 drivers/rng/stm32_rng.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
index e3ef98e8d5d..27cebc3b3ad 100644
--- a/drivers/rng/stm32_rng.c
+++ b/drivers/rng/stm32_rng.c
@@ -26,8 +26,7 @@
 #define RNG_CR_CLKDIV		GENMASK(19, 16)
 #define RNG_CR_CONFIG1		GENMASK(25, 20)
 #define RNG_CR_CONDRST		BIT(30)
-#define RNG_CR_ENTROPY_SRC_MASK	(RNG_CR_CONFIG3 | RNG_CR_NISTC | RNG_CR_CONFIG2 | RNG_CR_CONFIG1)
-#define RNG_CR_CONFIG_MASK	(RNG_CR_ENTROPY_SRC_MASK | RNG_CR_CED | RNG_CR_CLKDIV)
+#define RNG_CR_CONFIG_MASK	(RNG_CR_CED | RNG_CR_CLKDIV)
 
 #define RNG_SR		0x04
 #define RNG_SR_SEIS	BIT(6)
@@ -58,6 +57,7 @@
 struct stm32_rng_data {
 	uint max_clock_rate;
 	uint nb_clock;
+	u32 cr_config1_mask;
 	u32 cr;
 	u32 nscr;
 	u32 htcr;
@@ -73,6 +73,12 @@ struct stm32_rng_plat {
 	bool ced;
 };
 
+static uint32_t stm32_rng_get_entropy_mask(struct stm32_rng_plat *pdata)
+{
+	return (RNG_CR_CONFIG3 | RNG_CR_NISTC |
+		RNG_CR_CONFIG2 | pdata->data->cr_config1_mask);
+}
+
 /*
  * Extracts from the STM32 RNG specification when RNG supports CONDRST.
  *
@@ -276,9 +282,10 @@ static int stm32_rng_init(struct stm32_rng_plat *pdata)
 	 */
 	if (pdata->data->has_cond_reset && pdata->data->cr) {
 		uint clock_div = stm32_rng_clock_freq_restrain(pdata);
+		u32 entropy_mask = stm32_rng_get_entropy_mask(pdata);
 
-		cr &= ~RNG_CR_CONFIG_MASK;
-		cr |= RNG_CR_CONDRST | (pdata->data->cr & RNG_CR_ENTROPY_SRC_MASK) |
+		cr &= ~(RNG_CR_CONFIG_MASK | entropy_mask);
+		cr |= RNG_CR_CONDRST | (pdata->data->cr & entropy_mask) |
 		      (clock_div << RNG_CR_CLKDIV_SHIFT);
 		if (pdata->ced)
 			cr &= ~RNG_CR_CED;
@@ -404,9 +411,10 @@ static const struct stm32_rng_data stm32mp25_rng_data = {
 	.has_cond_reset = true,
 	.max_clock_rate = 48000000,
 	.nb_clock = 2,
-	.htcr = 0x969D,
-	.nscr = 0x2B5BB,
-	.cr = 0xF00D00,
+	.htcr = 0x6688,
+	.nscr = 0x2E649,
+	.cr = 0x08F01E00,
+	.cr_config1_mask = GENMASK(27, 20),
 };
 
 static const struct stm32_rng_data stm32mp21_rng_data = {
@@ -416,6 +424,7 @@ static const struct stm32_rng_data stm32mp21_rng_data = {
 	.htcr = 0xAAC7,
 	.nscr = 0x01FF,
 	.cr = 0x00800D00,
+	.cr_config1_mask = GENMASK(27, 20),
 };
 
 static const struct stm32_rng_data stm32mp13_rng_data = {
@@ -425,6 +434,7 @@ static const struct stm32_rng_data stm32mp13_rng_data = {
 	.htcr = 0x969D,
 	.nscr = 0x2B5BB,
 	.cr = 0xF00D00,
+	.cr_config1_mask = GENMASK(25, 20),
 };
 
 static const struct stm32_rng_data stm32_rng_data = {

-- 
2.43.0

