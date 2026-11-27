Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB28606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nFwRrnAd;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Fh1YW0sS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2422340A3D;
	Fri, 27 Nov 2026 13:04:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVSuQjGpem35; Fri, 27 Nov 2026 13:04:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6638C40952
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784672;
	b=D9U8lWnfvhEWou6ruZB0asuYd5AlUxLMXdJGcA0eo4FMWZU6ELKUB0wa1kx42hMIURRZ
	 sIWLnIpxbnqP952pSKyHL6mfsUFcbkVGIPWVuW9XxJCnHixbNDr7UIG02NW2g7blsxO+X
	 /wxdZM/wBVWHOLTohIKhHImBUFRBpzuNOMKPmlVmhk6iyNvVmra7Aaaq72EXuoOCpwzGR
	 lITm+/VOtZZXylxhUYdQfm4olgnm9sFRhdKGwwOjIkHhPKnqzfKxXG2um+pFJfuXmnAgC
	 khFw3qJjidGUgxzHJXLtsoCcJ+xfFtNbpEoX2nsFLlx8yKm1NTfAdct1GiTh4DByt5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784672;
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
	bh=pXWUqM9CFrOltIBpKa6IrJkfokktuYQ50gJH46qqIqQ=;
	b=ScnPwnwF6fk8dqmP68C5YERCll+OZmGTXJqt6Ro2tVf3kpR1U4bbzYTsujktFhECXK/I
	 fRRUaI7U5iVv2aJMpWHbMjruxtAS5n9xhOeHtTtcwsT7IgbGavPSbf9X400tCbwitQvyy
	 mebiCi3hCyp+jTqWxcFk/Zq/Cjk+s2JzXNQsDF/Qd3va99LOehzErfeOZ2zzUgSS2x3+u
	 B8OVOLT57MszsAsCwQVt0DaXOwRMAoY9EPphKhCWMSUn07uLqqO109+AhgbcIeVFZ1ODs
	 R3sCH4ZfhWI/SEgL20IBQr1962FlDQwPVOebT5d5GKZG/YzOiJIx55O8Ulgi6EojBrg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Fh1YW0sS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784672;
	bh=pXWUqM9CFrOltIBpKa6IrJkfokktuYQ50gJH46qqIqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nFwRrnAdxfeqkx0SAV4Q94me0ySIbFJoJnIBj6cpPBtbbQ14qpmD6es+cwO7lEwM9
	 08q6oiRjKGQ8VPalvEMLH3dGOyrbdGWjj2DWX0E0rdVukhRip15GFTNfB61ICQvR9A
	 5SHZ3jH6O9sF2dlAPUqQk3FJATDFuxdbN75An/uIaq8ixVzbU2mxd4XbXf5nyno4Lw
	 YYfBx/PSwTyi7NnKIxPsqlRSmj50HCj6v28PfY6YObg858WRQ+A6rWBG6bFIholEUQ
	 w5ip27qOUOTgu2V7B48DDjyQpeWYXBLd/Rwvm4+kX2qEcuPu0P3ivEVXbM1mePwF/T
	 dyB9QCdDq6D8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6638C40952;
	Fri, 27 Nov 2026 13:04:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E3AA226D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D575F408B0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JHM_JPz-RpGm for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:04:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DB20E406C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Fh1YW0sS
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB20E406C7
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXWUqM9CFrOltIBpKa6IrJkfokktuYQ50gJH46qqIqQ=;
 b=Fh1YW0sSdnlXMnWxuUQsJmCHDv1ZPCOurRfB4HvJYIwjn9pRCDAS7m0tS5Wsd44TXWbnZItXF7psMleCMAYnWlfV+BdQJyoayDjXbWfQYupVz2I00Af3xuycgpi+jANZp4dNpO8ImQ9xxOpDxEM8w8M3iuPEujXxjGRqi9nKg9/49gcodXHZLkIrZdPBn93Lqpcm9WUoDg+0vZWZyavZGYWFKlBbEWpiAqF9uUGjbY85R/9bHme3yMd4bwkeQqcYrdjvFtOAnBxEh9+dmekPVsRdh6GRlolH3bCh2BsOinQ9GPN8AGfL7Qk1Zqb+bTsHQBnLY+n6kp54ir5zdIqasA==
Received: from GVZP280CA0086.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:275::16)
 by DB9PR10MB5833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:390::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 13:04:19 +0000
Received: from WA1PEPF00009B3C.eurprd05.prod.outlook.com
 (2603:10a6:150:275:cafe::77) by GVZP280CA0086.outlook.office365.com
 (2603:10a6:150:275::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Fri,
 27 Nov 2026 13:04:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF00009B3C.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:04:18 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:05:08 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:04:17 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 27 Nov 2026 14:04:14 +0100
Subject: [PATCH 1/8] rng: stm32: fix RNG_CR_CONFIG1/3 definitions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-upstream_stm32_rng-v1-1-b8b4a9fdc8a8@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3C:EE_|DB9PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: ad31c864-788a-434d-a6ac-08df4c86f24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|261021135927099003|10067099003|56012099006|261102123227099003|261021121427099003|261021123027099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: CXkZ/wps9YFVnjyQuC86LSGvkoKt5AH8L+u0qMg0jeYnhL8THJhu5JLBk0uXAVGG0P3REBEQyfqok+94kt717r9ZUT/BqT80EhooxUmMQkLf9MRahYGN0485CzsmMxIztzCclAa6pXsmtQK8Sbo+NsLR6TslMTfOjSDYQ0sWnpglXL9cOW4RinVJ0gNxMEKL7JupnsJvaEXCyNje2K3CXR5/o7VlyLPKETag9h7w06dbwpZ508BQ3B5gBvZas6h+JFLiZv+IhziE4Zy09B6sC/AI1Ia3eMTUWJHnsVpKCwHW7Xjq9dF3Gm76JNVLVIAh2o12i5G5R19h1Wu9ubKWocOr6ouk6BNf0Wqul0Rexd1YvrboEEknMOi8YybUWOb4NvLSApVmJ73P0imcANf8bqvy1EbBC5UokFd30QMa4OnO0JsdCaZsJk6OzDRlXeo0pxpVqXrYKJZ2mwn31CWPjM5WkbSju8aVdzCNFNGVCkBRrvXxW671TgehCJ7mLcGfa3l19DsTNrfOxmlhUo/1C03ZBNadXlyiH2hzNk84w36ruIF9FrMsz8sS8FDOV8nTpL/Sar7Fr4gSui0i0b6qLqVilFQywKabNxy6znMFXAzMyn6cQLuBmKqCi65RKY5t2865r8dG63vxoBzZXZV804sdAqbhuQ9xjliKFqtSFitFf+3oDZQLkxG+QH3HKdNQkJWykddBIPf3ZAZQhPB7WQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(261021135927099003)(10067099003)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MHsW3tRoMO0YNpVV8tARpCfW7ZgyFF3oJezGGIEnVGNI76pdnosHD7rJzROxPFCayuwA6mqVT8nOLGPfAbTpC/78oZ0TnG8zRCl/s2b00YdxvP9ZP7Wdpa7z3NJJ+F8zvXcK7xamp8FMHNUYC2SQ+Puk4FcMpQvWX6SyO12EIWH1feKlWJmYacAwpNMX8e4b8OE5OHSE1ds1bPv9nnUitsNGutzlmOc+5agcSsMGD1lufat9VkjeK8pFpr/7zN6GXc/i6sGfFwKhPnLbvsc1oHrPZPA9ZofHEEVk8DVVk1rcUlt35uFXU0xwPs0iH8oUhIkBSxAHhj+JZuLvkuz0OSsJjDgOe5t/I3/vF3PQgZQY6JGeynuEgDuftWfZuclxm0UGTOC5P0Bd0lRH1eBRB4sFMkXWEcEYPy+l0XEYzsk9tiu3Wq2CjrzQ+KNfhu/T
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:04:18.3425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad31c864-788a-434d-a6ac-08df4c86f24e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF00009B3C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5833
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

From: Nicolas Le Bayon <nicolas.le.bayon@foss.st.com>

Swap RNG_CR_CONFIG1 and RNG_CR_CONFIG3 definitions to fit with
Reference Manual.

Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/rng/stm32_rng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
index 44e8a460752..2b2067a5285 100644
--- a/drivers/rng/stm32_rng.c
+++ b/drivers/rng/stm32_rng.c
@@ -19,14 +19,14 @@
 #define RNG_CR			0x00
 #define RNG_CR_RNGEN		BIT(2)
 #define RNG_CR_CED		BIT(5)
-#define RNG_CR_CONFIG1		GENMASK(11, 8)
+#define RNG_CR_CONFIG3		GENMASK(11, 8)
 #define RNG_CR_NISTC		BIT(12)
 #define RNG_CR_CONFIG2		GENMASK(15, 13)
 #define RNG_CR_CLKDIV_SHIFT	16
 #define RNG_CR_CLKDIV		GENMASK(19, 16)
-#define RNG_CR_CONFIG3		GENMASK(25, 20)
+#define RNG_CR_CONFIG1		GENMASK(25, 20)
 #define RNG_CR_CONDRST		BIT(30)
-#define RNG_CR_ENTROPY_SRC_MASK	(RNG_CR_CONFIG1 | RNG_CR_NISTC | RNG_CR_CONFIG2 | RNG_CR_CONFIG3)
+#define RNG_CR_ENTROPY_SRC_MASK	(RNG_CR_CONFIG3 | RNG_CR_NISTC | RNG_CR_CONFIG2 | RNG_CR_CONFIG1)
 #define RNG_CR_CONFIG_MASK	(RNG_CR_ENTROPY_SRC_MASK | RNG_CR_CED | RNG_CR_CLKDIV)
 
 #define RNG_SR		0x04

-- 
2.43.0

