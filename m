Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A95606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dnGo5e8x;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RboApsU1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAB7040977;
	Wed, 11 Nov 2026 12:07:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R2AURxhX_eO4; Wed, 11 Nov 2026 12:07:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B52340995
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794398863;
	b=GjY3kAoHNoW6nOuWj2cZ3Qla3RAbMZ+KJXlKTZCAn6aicurlEzJhvDfTmoJuZrkI268F
	 CuLixdRHYtsyO8bZIx9An/oFi+A1hBsN3t5FN1PaW2TDlRsMJWPR98KvXF9j97YH4wksa
	 Vznrwz+pnixUcmHe1Vbkn+0mv5+BvuGJ7uz8TKvbUyZvpfw7WumJ86hiFwkzR/iH1BmVT
	 B+z4cdAfzDvlvYiGcPXZMWAvwC6f+MwjTHw0CUJU/6o8LpNU/n7IbXTvZtfMhAw25JTJ8
	 jywhMWI1M4Ddw1lBuVbRepxD1SbukAQ34IiRKkK9EKNWDem5vkbfuRtDDrfNzE0wOSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794398863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=QYGimvnkUHGruZLfL2IG1UBs8LCW5Ps7HZigtfjFq9Q=;
	b=pEUVCc0BR3iZscy3Y1KltEN4oH4Lt74O2GjAFRkvq3MW7gFnWcyOorOP10BaKGzzHXv+
	 3rI58T/TcATsSY0ssJz/rV1F1m/tjqMAOLPLzk2sfk+Hq5M9sFgRudsgaUORvyGhrM1lN
	 3w5rXsIaG94fM39UVdirGUGJBfXKd37WYm6jmqFBROc/V6l+0KQCc2DaarOU/3WUp/Ifi
	 biHSGa1N6h6PxNLWB0zoxX3+tEKjs5sPh5qFpXOA64yOG5qu7L5SOAthtmdcl/iAEA83B
	 skMyJecVlV7MrOphEwpE4Wj/2KW4N5Q41zmLFBFa6cyv4OoS+mg45V7lm59deLCw7mg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794398863;
	bh=QYGimvnkUHGruZLfL2IG1UBs8LCW5Ps7HZigtfjFq9Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dnGo5e8xeWbnouIXgStX0AyaLozW+LiU/9Q1B1czBR9NbVQMa3RapbhFensA85GVm
	 DaJb6VuC35x+dPgVS4uChRXXQ9mKCkrJ6W/FWaKssKmBk2AzXbqZ2MMLvrp1bUCcer
	 iy1yHI6HVNWjsi4CQjtggKIyE5/7Vk70JgoA4iEuRztO+eMvgJ4HhuH8mDTyZshr8y
	 cVEatVOON1V+NwLaovQgai6DP9nH7X8QRa/phz3iIZy1s61Br/aXujODPUafswweL6
	 tFZLeVsGRyeaKdCjEq45iVoGChCRY2AmJDnhAaECufVSTZv3Tq4sJSaIDfE2gvvpEb
	 lXxYQQe/p1JNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B52340995;
	Wed, 11 Nov 2026 12:07:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EAEB17CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 505BB40217
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xU9Q6GhXu564 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 12:07:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2D29B400D5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=RboApsU1
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D29B400D5
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYGimvnkUHGruZLfL2IG1UBs8LCW5Ps7HZigtfjFq9Q=;
 b=RboApsU1bj3x1qpOWyFmgIfH6q6oWyNR5pPZ3U09e8pBTLNknvVljrbjc+tnXvmt687mKeJDNVRJIwUE3KEuSFvNlyUV0zjhbT4JcMLdwT2L8Prl43dRG+Sv2fqbJsatXbJkJDp7mOvc1tjMtLPv3qPkfKX4oNeb0PJbZQ80za4=
Received: from MN2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:208:23c::24)
 by LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:07:33 +0000
Received: from BN1PEPF00018075.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::58) by MN2PR18CA0019.outlook.office365.com
 (2603:10b6:208:23c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 12:07:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018075.mail.protection.outlook.com (10.167.245.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 12:07:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 06:07:30 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 11 Nov 2026 06:07:28 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Vignesh R <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] mtd: spi-nor-ids: Enable octal DTR for mt35xu01g/mt35xu02g
Date: Wed, 11 Nov 2026 17:36:41 +0530
Message-ID: <20261111120713.1526940-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111120713.1526940-1-padmarao.begari@amd.com>
References: <20261111120713.1526940-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018075:EE_|LV5PR12MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dea36c3-b1f1-46fa-0c7a-08df3fec5d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261009223027099003|10067099003|261021123027099003|261102123227099003|261021121427099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QsSVjEeEHj/OU9mrRvCEZsIqs2YcWe0YRFOVdC1R9QtxDYJoc8ADLCGvNGApqFV09MF7sx5geJUTLgWb5F9/T9aW2VlANyRGbnTS5Ao05lUJUTZ1LASICYL0o3ZZmXm39UlIG1Wb2GRkA6E9LX30VviUv8nZdqyOj+i4VF+i/cK5ubbkaeFDztKYpbnwFXlZLoTEcPd2t4Mrzv0tbZr+x9p2Y9YIFBfMFdxGulCB+n6JQpDnBXAJQIdMcP9hJTSoaIJC0rNyOLcP95F8wkT0OwEcFO2g6rN2OyZEKnQfrR5Uw7w7t/ViMNrmMwXpPhNa5Drb3sRAIPY8mmtjlFe9mJQIoxNHuXK6l+5NFew217/0vDydA28SbvGzs2WTssR5IAndwV/EADNK/OnSlLuvv52keAcutIRBGIm2RoG3v7bpRkc69D3SlrswFoAa55uazXEZJO2KV3IF0NFnC0e8Dn8w7Nw3Oh9tv1p9T2E4Yo9gdh3R+vwlxVPdAkDziNNPub4rvIjsV4/s5NZYRmiOgsIiRa++CSi2Csd+OrJ1Wiy2gE7l9HTTDWY1Huw4oj9P1xFSgO5kxxQqslBJ5Gdar9KPM0vuUQZO5ybenrMuOND8SOQQZXgjNgPzdVDFQWQWUV6CfdlcOA7yplASMbadv6kkFGqByoasYGCF0Gdpwz/xbFy+720+FqPeO8cwuu75XA3ETCpTBGCa0IcojnCIAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261009223027099003)(10067099003)(261021123027099003)(261102123227099003)(261021121427099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NYFXS/e513aGAF3LA3LAAqbYA2HZ1eNRb51AQXxVu5d7+AMzARN3oz6sRLnHNP0Dsqj1dED3obC6Qk/WAYUHOMW3YiU1HTefvAMuoC+uCrj2HxBBRAO6/9FMtpGpV0Yxhq/MNPa/6n5TD54Br2e/T3l6CawChBxmZSpMXdxJABZUGrUAOwEDKLe0fwBf+wK9xURxHi9RW7HoXzOv/Jxtk0ZvNjiq5P3nFVpLezv4VhAb/24vkWPAFeOIq+Lz655r93BikgHJxMX1ddgrllkdeEqLin3p2ycipHmNQBxqL6IHC8e8+d4LSCLy3Wy8ouF32mK3M/hAAckkj0BX1fqcI5KKfTjvko0Km/bW0Eul9nSh+/pGY14nfm6lvbkVbQqx31iWq4DWx3zv0SJn/ujLoKgvRAOUJdVJyIVxZ3EcXbLMCFBXAWa4sOtuFUvwq3JE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:07:32.4404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dea36c3-b1f1-46fa-0c7a-08df3fec5d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Add the SPI_NOR_OCTAL_DTR_READ flag to the Micron mt35xu01g and
mt35xu02g flashes. Also move them under CONFIG_SPI_FLASH_MT35XU, so
that the driver can apply mt35xu512aba_fixups to them.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 67486d7a945..7be2d950367 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -438,11 +438,11 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mt35xu512aba", 0x2c5b1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xu01gaba", 0x2c5b1b, 0,  128 * 1024,  1024,
 		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
-#endif /* CONFIG_SPI_FLASH_MT35XU */
 	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024,
-		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048,
-		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE | SPI_NOR_OCTAL_DTR_READ) },
+#endif /* CONFIG_SPI_FLASH_MT35XU */
 #endif
 #ifdef CONFIG_SPI_FLASH_SPANSION	/* SPANSION */
 	/* Spansion/Cypress -- single (large) sector size only, at least
-- 
2.34.1

