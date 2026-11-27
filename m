Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE01E606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V9xWnrTV;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=I2Mtn9hN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D30560A54;
	Fri, 27 Nov 2026 13:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c6a0VQuCUbuV; Fri, 27 Nov 2026 13:04:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE16160AC2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784675;
	b=PCYzz9ahVpRQ/Zzs6cyXMSAvb5KWZLy0V04uxw5/IbZ1a3tZTWst8obrKuX8kqT6JtWr
	 WTlpSJvKdy2VaxFj91gIFd8zIRjt6CMuMQ3BO1lYUlpxAMNdf++JVzwg7prsBLrrcFuLY
	 GKENEYyU5cqBPsbihHQqoJqKZNdHruRqubZoij1K+cbrjWin6UXUtuW3J7piRqRJ0pwAn
	 emACTFo/ui7kHNQ1Lyl69Ia38XtCY5JdNtM3S9XzRi7Yahng96VLfOegbJoWfLV+D56OY
	 zP/4OE6/EbPZxVm7FYzhmrLx9bhaDqVW11v0+VaULvwsXvvw/ZeudG1JsxK4XVEqiaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784675;
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
	bh=D39GWCnc8CrxFwvXt9EHKBmoKuwzOucMgquMYealjVU=;
	b=O76LqbVJuG05fVuNrIE/r09Orw08I3T5MgSYh4cRrw4LTu9YaziNmtViHoEFE92utLmq
	 xG5pCVBkxr/jtV/EA5ATGuMkJc/lZ98qChcgZo1hgxMcMhu/eJJijgvvuCWBLmfv3PYP0
	 gngZl/BpSWekeRqHUZk39/OHfeFDI4I5pqa4zP/TE2VGCJUuETmZcY/uTHtUbD4eJ0D+l
	 3+lKWgwVYVRUMFXzfWwiqnnsJnzDmeKfJS6vwDFh3skmiC4auEQqI+4m5cpBfbwk3HbnN
	 o+7QJ+Xo7zaqoPlISiK8G2rUYQBS8I+SnsGWiETlqzfUI8019DqmnDmETyc5qCGf47g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784675;
	bh=D39GWCnc8CrxFwvXt9EHKBmoKuwzOucMgquMYealjVU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V9xWnrTV+ObGOVUVQG1yNDCnUSYh0XSe69/CjkTfEkvBh12ByXxQNqiB4tcrNcbRk
	 MUXCvO5nIXTKFTOy4Y21r/6rPFbpJp+CW8O329IHYwwmZDnNb+JDCxcj7npqSttPhR
	 luhtjuFGRpcPCbDyoHMJ0sOk2jjFVsjrT4nxC17vPctfcPkAZUR0/Ea4pSawVWaYpx
	 nzp1os49QmiZ5KqlO+dCOFOtQ7OYr1Rqv7O33WUp1qVEAHgRAvqKS4u6LP2YP6leJc
	 oF0HU1qqCZB7xCkXhvLPsXf/j1KL9o/1NZvfl3LePpKvJFJOLm7kHzKJAVMhPHegbD
	 epZr0KwGEMYnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE16160AC2;
	Fri, 27 Nov 2026 13:04:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C09D373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6694640952
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VQnqa1SNbKZz for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:04:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 87E8F406C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=I2Mtn9hN
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87E8F406C7
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D39GWCnc8CrxFwvXt9EHKBmoKuwzOucMgquMYealjVU=;
 b=I2Mtn9hNPBfjyWgVPBql8E+OcPXAqQo0f98Uvr/4fPT81PAnn+WwB3T3VhoYTS2TqNGpWkezsxywT7nTp3lH0tna2auzodxa276LLJs5+/INULHKLEK2QvM8LnIglHGycaNicb8wwiw+91syB0+z1RnPY/RQlXRsLXCUWObXDNgmThooIBi271iY1JT9x+mnqBHsHtjON6fOUFZHWt2GQUuCr6N+MxBgBupGH+GFgaP7KoHV5DvxJxf5iT5qYWnT2CXzabAUp2JtUwfPGSth3oRkaj5bTzsbHjjRaZSxxn14tl+nYbS10MTY0oCl4eykU8LsUhLb87NdzyjcJ/JW0Q==
Received: from BE1P281CA0083.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:78::9) by
 AS8PR10MB6724.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 13:04:24 +0000
Received: from WA1PEPF00009B3E.eurprd05.prod.outlook.com
 (2603:10a6:b10:78:cafe::81) by BE1P281CA0083.outlook.office365.com
 (2603:10a6:b10:78::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.6 via Frontend Transport; Fri, 27
 Nov 2026 13:04:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF00009B3E.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:04:22 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:05:09 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:04:19 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 27 Nov 2026 14:04:16 +0100
Subject: [PATCH 3/8] rng: stm32: add STM32MP25 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20261127-upstream_stm32_rng-v1-3-b8b4a9fdc8a8@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3E:EE_|AS8PR10MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aaa2a6b-6941-45ad-0c48-08df4c86f4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|6133799003|261009223027099003|261021123027099003|56012099006|11063799006|261021121427099003|261022075727099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: KyTVAWirbTWNjgnqsPQY+hELrI4+Te7P4cn7yBXFjZSVGHggnyXvb58rWqfZh1ZWYH5m9s1pR4yyGK9WnNEM85aZp8Dub1h5FL0Fi3QJWuShL4mqWNe3JfBec15FEVZG2tgybN8EyoExuwXqJZ63OTCsIeAI5t4HIWVrfMeP0SvEF86AX5ITUXDpABiR9rPb+XxF1ywTNxpg4sYq78D982FE+VFysCXO+438yr8v5UjSwophrd8bfZoqUAf8j+bF/UUc1qeYhz0hlbxTDG2loYhW4H59IXua6mI8ULryTd0KPzo0eKf8I05hvkIN1BduwX20tZh1nX0Vz6asFGFrixfIRuMfFJFDhUvG8sPxQJxaS6P5DHw7LIRS1VvvOz53/9iwt8JI1GI2qEd/in1uh8l0dc+twXdTpE8dxA1/+n4EuGKcACMVf1PssoHq8/JWr8EpBMDrdlS/VPH7QXaEhpxMCHj3UZyQlDBcnoADM7mBroPTI69DtfwYmCO/5YHpvvwgaj4MS+6gscuMgeh2cE78lcpY+iOjyVD5FMgVFG3kbZcA+xoXjiP47r9qMVFDAcdMaLhWVJ3HKeoxDLAFFXCsQPOEuyfPPDY4f9weelIN6r277hSNW1fE5EoAi1viJhwhG1A7mmOgekvvTEnwTTybpHFKHGdT2kE5XM70RwRe7Ydc9Qc2aPCIk+wULURNBuP/8hi52L4+V/6d596lUA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(261021123027099003)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /tbnhJaVV15cg0mQyeD1XOHujkIvr1gyrTsPHLz7oPZeKNV/y15k1tyOVEV/2AXq4R2DQoaKCeGzssp+pfqRKmS1bgDAMGW4ULqUvxOjSjtO71ux3Py9oB8DPN+niE56ySDCUKRd1yZ4/k7ajyfOI37ezyYCkfb8xvmHoL8NsNO0FF2BnalcXBSJRG8q8YVsveqWh2J0mCgaOqdwrgPMn8xruPvohCf4I2P4t2U9lCcX55tIm/bJGVUPKjP1DlhsVxWdqiWJoVv3n72v/ZtHmUdy+/a3PzLNe8FbCQ15K+DdoRBZfX60bgzULsqzaGeWWp64NDhaY2gSfKjwDDNhXpqWGpmlKp4q54tzllWnBLkfedeZLYzj1w+VzVMTOa2ykZ5VbxNaLE+FXavK5jFw8Q8xDmSTJ99mfbgEf7EviRtjBJhvj0OXqqBs1b3TbMB0
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:04:22.3861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaa2a6b-6941-45ad-0c48-08df4c86f4ba
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF00009B3E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6724
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

From: Gatien Chevallier <gatien.chevallier@foss.st.com>

Implement the support for STM32MP25x platforms. On this platform, a
security clock is shared between some hardware blocks. For the RNG,
it is the RNG kernel clock. Therefore, the gate is no more shared
between the RNG bus and kernel clocks as on STM32MP1x platforms and
the bus clock has to be managed on its own.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Signed-off-by: Maxime Méré <maxime.mere@foss.st.com>
---
 drivers/rng/stm32_rng.c | 55 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
index 503dc545444..d96485a64fb 100644
--- a/drivers/rng/stm32_rng.c
+++ b/drivers/rng/stm32_rng.c
@@ -48,6 +48,7 @@
  * struct stm32_rng_data - RNG compat data
  *
  * @max_clock_rate:	Max RNG clock frequency, in Hertz
+ * @nb_clock:		Number of clock to handle
  * @cr:			Entropy source configuration
  * @nscr:		Noice sources control configuration
  * @htcr:		Health tests configuration
@@ -56,6 +57,7 @@
  */
 struct stm32_rng_data {
 	uint max_clock_rate;
+	uint nb_clock;
 	u32 cr;
 	u32 nscr;
 	u32 htcr;
@@ -65,6 +67,7 @@ struct stm32_rng_data {
 struct stm32_rng_plat {
 	fdt_addr_t base;
 	struct clk clk;
+	struct clk bus_clk;
 	struct reset_ctl rst;
 	const struct stm32_rng_data *data;
 	bool ced;
@@ -258,6 +261,14 @@ static int stm32_rng_init(struct stm32_rng_plat *pdata)
 	if (err)
 		return err;
 
+	if (pdata->data->nb_clock > 1) {
+		err = clk_enable(&pdata->bus_clk);
+		if (err) {
+			clk_disable(&pdata->clk);
+			return err;
+		}
+	}
+
 	cr = readl(pdata->base + RNG_CR);
 
 	/*
@@ -320,8 +331,16 @@ static int stm32_rng_init(struct stm32_rng_plat *pdata)
 
 static int stm32_rng_cleanup(struct stm32_rng_plat *pdata)
 {
+	int err;
+
 	writel(0, pdata->base + RNG_CR);
 
+	if (pdata->data->nb_clock > 1) {
+		err = clk_disable(&pdata->bus_clk);
+		if (err)
+			return err;
+	}
+
 	return clk_disable(&pdata->clk);
 }
 
@@ -329,8 +348,6 @@ static int stm32_rng_probe(struct udevice *dev)
 {
 	struct stm32_rng_plat *pdata = dev_get_plat(dev);
 
-	pdata->data = (struct stm32_rng_data *)dev_get_driver_data(dev);
-
 	reset_assert(&pdata->rst);
 	udelay(20);
 	reset_deassert(&pdata->rst);
@@ -354,9 +371,21 @@ static int stm32_rng_of_to_plat(struct udevice *dev)
 	if (!pdata->base)
 		return -ENOMEM;
 
-	err = clk_get_by_index(dev, 0, &pdata->clk);
-	if (err)
-		return err;
+	pdata->data = (struct stm32_rng_data *)dev_get_driver_data(dev);
+
+	if (pdata->data->nb_clock > 1) {
+		err = clk_get_by_name(dev, "core", &pdata->clk);
+		if (err)
+			return err;
+
+		err = clk_get_by_name(dev, "bus", &pdata->bus_clk);
+		if (err)
+			return err;
+	} else {
+		err = clk_get_by_index(dev, 0, &pdata->clk);
+		if (err)
+			return err;
+	}
 
 	err = reset_get_by_index(dev, 0, &pdata->rst);
 	if (err)
@@ -371,9 +400,19 @@ static const struct dm_rng_ops stm32_rng_ops = {
 	.read = stm32_rng_read,
 };
 
+static const struct stm32_rng_data stm32mp25_rng_data = {
+	.has_cond_reset = true,
+	.max_clock_rate = 48000000,
+	.nb_clock = 2,
+	.htcr = 0x969D,
+	.nscr = 0x2B5BB,
+	.cr = 0xF00D00,
+};
+
 static const struct stm32_rng_data stm32mp13_rng_data = {
 	.has_cond_reset = true,
 	.max_clock_rate = 48000000,
+	.nb_clock = 1,
 	.htcr = 0x969D,
 	.nscr = 0x2B5BB,
 	.cr = 0xF00D00,
@@ -382,13 +421,11 @@ static const struct stm32_rng_data stm32mp13_rng_data = {
 static const struct stm32_rng_data stm32_rng_data = {
 	.has_cond_reset = false,
 	.max_clock_rate = 48000000,
-	/* Not supported */
-	.htcr = 0,
-	.nscr = 0,
-	.cr = 0,
+	.nb_clock = 1,
 };
 
 static const struct udevice_id stm32_rng_match[] = {
+	{.compatible = "st,stm32mp25-rng", .data = (ulong)&stm32mp25_rng_data},
 	{.compatible = "st,stm32mp13-rng", .data = (ulong)&stm32mp13_rng_data},
 	{.compatible = "st,stm32-rng", .data = (ulong)&stm32_rng_data},
 	{},

-- 
2.43.0

