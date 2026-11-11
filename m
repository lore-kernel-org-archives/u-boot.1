Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2C606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=034Gjgxc;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NYiUOIjq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEB4E605D2;
	Wed, 11 Nov 2026 12:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XliQRjmXAAwW; Wed, 11 Nov 2026 12:08:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E03960796
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794398909;
	b=QdW4KhA/KnFIPbTgNxcw/qZf+LB2DHXerXUM+Rk0B50PQfK02A/dQpNISWlx6Ph2QhaD
	 7yMxnOjVb+eepxrUj9Fj91/fpmaNU4zuKhVPNlu6MKYjOZO0RispdsIC2mvuRJWovDACA
	 i8x6f39UXkD4DNOv+kA6486HX+8AkoujcVFDWpT69Gp9qnTH6jMkMOyBSLrQsVlAXTU0N
	 XnaQyQXU0dJIAOeKBENJQbignY1VZMxAkaUds0nA/1dXMXvWCNy5qk9DlujJEsOb8n6aq
	 s/mknr1fqH8lc2DVnQ99XlTGK/xY/b+GQ2lPBjEuX0Stg9GwMvCj9RMMQcXUThJ+XCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794398909;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=syG44tx5b2Lfo7l7s/fsxCtjlyhKgNrOdVcCgy87CNI=;
	b=qoRIYhvDQnlqXYbVIzMZmtpv+p/HxnBBzomPMSUaCtqs/AnkkNsPFw2TO7X+PFzNbD1D
	 fmfjujB0+a7C3tLMFVhTM7JnwT2eAYFXYp50DMjCRiGQPOhWw+U+pnGZ6EkC3sMpwkRAi
	 gkAv44wrRVgeQ8Y1HBrNOb59ay8ty3Fjl0iFt3mMDt0cr5u3nDNvYeDFRMPTciSUo1RYU
	 nTiCid7bn7xYDoNqk0ndQs11CpNoz6TZEgqN8UAQDP9plzxbPnPEn7f5UtZYcvXVe8T51
	 dXVWx3tOno8cQt6HTCIxpy+bjx2ngSURxWqy3aHS86auAqX+0egjtduO9CbaXt6HRSw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794398909;
	bh=syG44tx5b2Lfo7l7s/fsxCtjlyhKgNrOdVcCgy87CNI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=034GjgxcXiOeKClGD0z0bT3sVcz3ps3cWfFva7ErXGL9TkRxVfgholKO9fKOI7QYA
	 afZq3rv89emZ2HgZYTrLHAgeeNn/mEaamiLYQbsxaZgUabBkpVm7XPmm5aKbL5W7d3
	 hSSublrQwbHIl+C3TLVCzNieZpHN4FDvthUgrME7i5L/BVVx64AnxLX+3HUoDG33CM
	 LKbS0tibsO+TYwxIArZ0Y9G8smahO3H46U4ugYd9E/mV+dLbTNYxzlY+2WZfWxuxfV
	 3L/+QgPQ89k+IPOtSbvx8u5wCeEFy6qFwgitIReBZn1SCrMih5vsFJiPOlfbEBNyqw
	 WEzVCdxdxe0XA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E03960796;
	Wed, 11 Nov 2026 12:08:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 58D1117CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E9B140B04
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dOqCGJcFzMIX for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 12:08:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8639940AE7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NYiUOIjq
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8639940AE7
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syG44tx5b2Lfo7l7s/fsxCtjlyhKgNrOdVcCgy87CNI=;
 b=NYiUOIjqLCuv4zRDF1ELa5KwSyVNQjK3KM+7FUeIHBC02HiiKcwDG6SwLKP/YjT9CDRqrrvxQ15tzz4bI8gvWHaF/GX/vyUtMPiiP1Uo/Y8MYnob5MmDwi6re9n72mCR3zvMuxFaAUfpJ3piMRMl4A2NTYJJFS33qoxcxYDvVWs=
Received: from BN9PR03CA0429.namprd03.prod.outlook.com (2603:10b6:408:113::14)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:08:21 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::60) by BN9PR03CA0429.outlook.office365.com
 (2603:10b6:408:113::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 12:08:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 12:08:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 06:08:20 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 06:08:19 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 11 Nov 2026 06:08:16 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Vignesh R <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] mtd: spi-nor: Disable chip erase for n25q512ax3 flash
Date: Wed, 11 Nov 2026 17:36:45 +0530
Message-ID: <20261111120713.1526940-6-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111120713.1526940-1-padmarao.begari@amd.com>
References: <20261111120713.1526940-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 13758032-bcc4-41cf-22e3-08df3fec7a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261009223027099003|10067099003|261026121527099003|261021123027099003|261102123227099003|261021121427099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: O3gBq3vD4xltwfB7OGhPTWilfnL7zm1kibaQMdBrc5it5b0rMWBgeh0qjNDgDmsA/gGvs+F1OLZXRyh7gaFFq2fHQUwy+gYQqXHYaZ/PDH2j9HROoIDW7iXZ1gjlKY2c6K0a//kIX6m85X6lG2CuP2IqHGo36QT2bw5TTMzd71dRVSlzgqh05CLaZ1mexfDuNVsLoF7FJimgMJOkkYs5GLrI/uQiQdCTCByuNdSEyT4U5uNptTrfOBHe2720gaZE/ZrlFK2nWb5VVv6tCDrVwuX5qFEGa7eBxuBi2yWDn0McsMmLR47b5oKRQuPgfEsLwGGHic9Ss68+CbTi9YURNG6onEukNIrv6gx9hkBSy3UTISiIYepM2J8eMqP9CpLAI9Jkwv9Gfvanm/Wp7bAnnGk9eoIrFt7DxlCVd/YzYW+Ye2yUt72jytZrKcON5brAiYth/tuXc/JGM5L52eja6G83q256fE7HpEDWAZigGbfdDn8R+O25NGSrxZdRTI7xlP+XCTw4VzMaXPZDvRJML9om0oI9TXHRytMcYDeKcSeRkzq6HbBeEOxpvtmVnGQMuJUQUTzfTlmUfmRjs3/AiBj0a0RMnVGwo4zLON2OKk0kY8fw9ZiMfEftd1a6+qGDUIFK7LRPsyuRPd+MlwISlJASQLHM8QCUd0frN4/izgwIGUeNtEDyu9NL4jO5GbDpbVeXFXZATtF35lR1ECv1vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261009223027099003)(10067099003)(261026121527099003)(261021123027099003)(261102123227099003)(261021121427099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ChBKz5YByLCY2PyXyMOWrswFbGYYy4P7uRpk6vXSCUwhe2Cvg3U0vhTdmyJzzv2NuSmS7SaSHXPEgXpSdDIyLjj47uHJvuWHatZmfTexns29u3rsQbitDTlYNxnHdKuTz15pIrwntW3PG/6MpWzjWMfwak+9/Q1RHYyLhKRc7VD4HRDyiOb1lkZNwPGpaPoYYjrk1ciLtu4uf2TYQ/fRgGWUHNr/Ygh2Pq95XaBXyA6cmuPh0gJh7prFJhWKD8+33HTC6o3Cm5T2lz2j3gszzdff6CtypFx3LE8QQQXgKjeWKsV4zVwjOI5TQxxDo2QSUUxqrT90yhJTgG1vGJTe3yr6pJP5NpfL+4QIHagy5obZsY/jcxh5XIHi87NhsXHNZimY3D7wbYHwOKdudwO87GndrSTF8stTV44dDYA16EctU8qaouRD9LufqJxysyUK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:08:20.9233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13758032-bcc4-41cf-22e3-08df3fec7a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Chip erase does not work on the n25q512ax3 flash, so set NO_CHIP_ERASE
to use sector erase instead.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index ac3765ef7b1..fbcad9b3e60 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -427,7 +427,7 @@ const struct flash_info spi_nor_ids[] = {
 		 USE_FSR) },
 	{ INFO("n25q512a",    0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ INFO6("mt25ql512a",  0x20ba20, 0x104400, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("n25q512ax3",  0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
+	{ INFO("n25q512ax3",  0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ INFO("n25q00",      0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ INFO("n25q00a",     0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ INFO("mt25ql01g",   0x21ba20, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
-- 
2.34.1

