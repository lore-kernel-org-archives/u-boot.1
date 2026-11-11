Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06365606A8BE
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zfKArcRD;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=D9gidfeu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D190340A9C;
	Wed, 11 Nov 2026 12:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRgFEfPHrsZL; Wed, 11 Nov 2026 12:08:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 183AD40A36
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794398883;
	b=e5itm05utX6meG0ow3xRXl/7H1cb98lvQ5OdYVGI5MR4Py9l5/mb7NSFakNGjlLyKtFJ
	 SaOIcoWY536t/9uNNIYKt6Se+C53/GdvkibZOtJut1k4MTRs4nM5Rw2VCxIWM+oMK/RTs
	 p1EbL7zzeHCB8MZ50jG0szY9vcbFyDHbdHD78SS0bAv+4c8FDg+UnV+FNlkrGPymJgohE
	 YpazDdqxUkWLZ1E5WkHoza19oziGRSAV4T4NTvdQT4XAYS8A2fncYZIbcsV3GrXGrNVEB
	 2O7/dy90L6x95Tz19VzEhlFKhucYOVRjtdyDXB65BHgAB50lycX2Lt6h0gCJXj6/LyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794398883;
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
	bh=R+rCQU29XjemWWT6PYawapVbbTC1kNSRNFXh8Q1Jmts=;
	b=pyKIpP8bJhuGj8T0+IYZg1tEhunQ2h7xShcnDz/2gJzoQHwxB3oc3/EjlRZVDRGF0yI3
	 aJPIFofKrCk6lljlrFnm3SrDaH7ZSs/hHCnkxpBSMYlon0G1Y9Vq6iOnXM6Dnb+32Kifi
	 39Cn1WdOiZEG4Phve4W83slG3IUUMbmW28togZ+P5ajfKk7jvXVSMMkYqFacGaryOEVdZ
	 EZewSUYaAV2N5tPnm0DJ7b4eYy8VeX9n8UDC2XwvNOmecB5xpixL1Jpj74JPB5+79poVK
	 gUDG3vfWEbomoAdIsMGJTW4e0V6nY8uHKu4HxF3GmRctLxvlMBupR8xjTs3qkI6Wpvg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794398883;
	bh=R+rCQU29XjemWWT6PYawapVbbTC1kNSRNFXh8Q1Jmts=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zfKArcRDbDLXvloWAhXZhSJIFroloH0ev+VlFqs2ra7Zyq6lL3Y462VTNhmJ1ZLh5
	 BBN5AY5nENzcZGocjNUDsmVKK1t/johjB5PxU8hrbXCqVgCPK908FPIMdZNuJKTCwQ
	 KhpEwaI/y4u1UC2dUCuS+3PL9Od4ncVOkmS4LBGjQ+/4erLFazHXN0bIZ6UFLeSMbv
	 t0wHn+Ke/jkn1iCkEyhwgmuvcMetmdUIcM7qgwJp4QpRxlZv09UD97Oj+AjYMiwfd6
	 Upvxk08Vb4bp7pfEoyCeJL2OKCCHjxKGepPQtyIJoM2FtU9PYwJ7jiIEhc+0Z5PwVA
	 WPjQp/XqgfNkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 183AD40A36;
	Wed, 11 Nov 2026 12:08:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DC9C317CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE92181187
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:08:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtQEI1SQD410 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 12:08:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1456E80C04
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=D9gidfeu
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1456E80C04
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+rCQU29XjemWWT6PYawapVbbTC1kNSRNFXh8Q1Jmts=;
 b=D9gidfeu2/F3grSGvPFcCAwGReCQbh9u6LhORIpPjbN9Kn/4Tisn0Z0L8OsvA44l/H8e90yH6kNXBaqnsmlYZDtCieY+bi2YwnGdu5PWH3ZEJj7b6/B0MWRu4aJ8WyqQEhe4boVPDB8FE0gO5wyG1qQRYSlHTJErFOG7iAoLcRA=
Received: from LV3P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::17)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:07:51 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::5f) by LV3P220CA0012.outlook.office365.com
 (2603:10b6:408:234::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 12:07:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 12:07:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 06:07:48 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 11 Nov 2026 06:07:46 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Vignesh R <vigneshr@ti.com>, Takahiro Kuwano
 <takahiro.kuwano@infineon.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] mtd: spi-nor: Add Macronix MX66UM2G45G flash
Date: Wed, 11 Nov 2026 17:36:44 +0530
Message-ID: <20261111120713.1526940-5-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111120713.1526940-1-padmarao.begari@amd.com>
References: <20261111120713.1526940-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec09dbe-549f-4ad7-638a-08df3fec68d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|10067099003|261021121427099003|261102123227099003|261022075727099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0V5pXL+3eihGlw3TsMNlfCQUC5KxhFmJ4aJaQ376eTT6oQJT44VimBrOIyNzmpGL7Skm2pMAaLj9NA9I9bmUstPZM9rDxSRbQjxkLZQG/KMyfJd2RyOZNRTGD9nJd1C3Gv0ZDHay9fOiE7knN+Ok1PKRQuBCNCDrBN6DzVAYU2FQ3dN7OIwU6yyYb5X2LYDEBihQWRmIsME7ydJ9qMS8JsiDL2CXLm6pPiOculMArdpuBgIvOygWg2cDeW8y1g1p+9foBhA4NxeyKNlGx6oaHC4J6YyoWjILJBRL7WtgoLkhRiTe0rbKRdQl3+2vAy9COZlG45Ql7m7cSXMLmVPw/+SDSQLQV3veIc3llN5hA0xN2S/6k2s8NKnmRvJM4dleA79fqnuQ6+xIoG6Mb4KZeZ2m5NwVXQg+ot5ihTFkj7kacfKyX3oZQ+XFX/bEiXAfdXovK0lzt/Mos/iQRWRh9f8R1cyxU3guYCWhIssU9dWyoYTUpIMwc+i3VbWyrIkxvtiC/EHZHDuIDRpXeldv4Kp8Z9RRnWiaxmUtDCvRSPKMtVpN26nbGRMxgm8W2VbpupuoLZgGwsXg3jhXsvXbwqIx0i5DXBjo7GUuaaR7AbsacHtmnMqFEQaK21kk6T6WZcH0W5rMMSWgbTeYNgUzo9FA3K8AjZLNvJeRUss4u9sdbsOccWOvh9Va/g2UazptCBNqZrhxZsiBkxatdij3xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(10067099003)(261021121427099003)(261102123227099003)(261022075727099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3IVQXonIvH33FQjnBr8qju5nD980oN0gnYjwalNXsVWlZpQ+WkVPVT8fW2m+WPuCQ+HFD+k8wewB7usXCawFaHs0BarjjKBYgejDv7t0m5IuzjUH1znpW9bkx6pQ7YQomqwFvM0TnjKuN3zL5WDECNvm1cFb7V6VWn8wzWPa1mUMW+ozkEFVPQwGJv9cmqycADzw5ENNWGQBJk+1UOPUQa5ZpsSTG6T+H/y0cBPp1ORwOoNflafThA7XaVZcEhv50Wi1DKlPhlwWycO1CfBJwUExgOl8A6oMJoS9JxryI6XRHCdfHx13coqXgNji3/BHH/FhklaTjyhfvoppA7f2POyi61aHDl7bV7R9p1/u8cjR/GRwmQP5zav3F29jGwAybQ9n1UCb1UYXfZ9QrKAX70gLIKhLMDTZWsuiF+/2fV5igNHxuG8k0Yugd/jO6IaM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:07:51.3218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec09dbe-549f-4ad7-638a-08df3fec68d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>

Add the Macronix MX66UM2G45G octal flash. It has been tested in STR
mode with erase, write and read back.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index cca053ae9a7..ac3765ef7b1 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -341,6 +341,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mx66l2g45g",  0xc2201c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25l1633e", 0xc22415, 0, 64 * 1024,   32, SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | SECT_4K) },
 	{ INFO("mx25r6435f", 0xc22817, 0, 64 * 1024,   128,  SECT_4K) },
+	{ INFO("mx66um2g45g",    0xc2803c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx66uw2g345gx0", 0xc2943c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_READ) },
 	{ INFO("mx66lm1g45g",    0xc2853b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25lm51245g",   0xc2853a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
-- 
2.34.1

