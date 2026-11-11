Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCED606A33E
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JCo8edX6;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CHwNFF54
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98433606A2;
	Wed, 11 Nov 2026 12:07:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZOhTttBtGr2X; Wed, 11 Nov 2026 12:07:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DA22A60796
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794398878;
	b=GiQ8ff5ZqQeX9WzgxPspPQ5//b1FSAh1lAXxlfXPkpHM7GZoJ64wYkKcm5dy4reZk8VL
	 Cy1kahFjuDf22O2A/M+VNcDcSiCkuJKNz7/2pi3szF0EFWWXNg/2KrjFzOy3LKTXc4tOZ
	 5ZyYp4akvKb5IVofjjNs62akl1Mn+EJIZgDTLGry0H8GlE3r69mvpLb4qJ25vuo0Z1r5y
	 V8BpJb3Z0O5nklDoxgBn3KlLl/VxHDT5fZJWZ4ayH7yb8FtRmMh3N4Oq9/JKMXk9ENIUd
	 U6k8msNegxm6NtqyIAGBUqjhDnqG1XrP38/D8jmWMVGOUAR+rkWJcGkGJbBxUbHyQ5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794398878;
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
	bh=vqv4SPVGN10NxMx/1Nshb/83oBk+q4eFM2blzQFc+JI=;
	b=TpqI6o4YP/kczxlVvBh5Q5fhfNFPsucD1RIrflRVtEioWpcgL7wjA9uQmNqcntiUryii
	 7bbhY+iQKY/aaL/049C4INCdsn6yhG8TAxzQk3aUWvKt4c7K1w05NRsya/swPqUG+V4H+
	 kDrDS5P8AIcCh5N17nA0E4Nrl3hsQQYSJYwZVEojkKgRr1Y6o14Rooj3cpR5+8ruE4evv
	 L1EAPSW5tgbWRrnJbx8LiZV+YRPZmhVdedS6Ip0sQYlIAS5BfvxqlUVVesNuJ5tpVwael
	 j9f9P95hgMluZoXyPW0gzZQUt2RR9Jx+hRgm8dN+g2kdfCev2EvdWqU4pwhAW/Qt7FA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CHwNFF54;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794398878;
	bh=vqv4SPVGN10NxMx/1Nshb/83oBk+q4eFM2blzQFc+JI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JCo8edX6DLt1MrhBd0Iz4Y8HmSddQ+jbNs9eskH+SLTMuY5gz4tgu7nM46sVhjH4C
	 yIG+fTuL6ZaTLYLejon+GSyHEBKpgCj4VaxHqyh6bw9kdCbRGg8pGYZVaKyMFd5K49
	 AgYBeyKIi7IPk9DjbHD+pGR5K3vepOpzw5aBHJrJuyMQ41E+ezhqSBPQvmd1nhxzYe
	 jm2+cjdJBnqVrEoXBC6zE2KJB4jih+6tJe8BBXlHgep5REY+lwOlDtND9FvbiYo2Cz
	 ugGmwlPNDRfUrEHBCQgnffdVr7NQvpOhhC3IUe8GDCvm+8sjc1BbQVH3NsezkuO8mO
	 6lo73m/ROeSTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA22A60796;
	Wed, 11 Nov 2026 12:07:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C03117CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CE9A606A2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3WPFCrAqd57H for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 12:07:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BB99160796
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=CHwNFF54
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB99160796
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqv4SPVGN10NxMx/1Nshb/83oBk+q4eFM2blzQFc+JI=;
 b=CHwNFF54119waO7yDBk7+EIiyb1Gu3ogPLH+ZZBbCL3J89CoKcybhSAdedyNNi9TMTIOamlwlwNWLWSrZKiU0Ib3obvePEtnnmsQQsfLxE4SI1BzwpSZZwJDroH9es/6QJdFf9RaLwcI+m+c7ynqitzFDsA3wgsSFilA2x/Yn3g=
Received: from SJ0PR05CA0160.namprd05.prod.outlook.com (2603:10b6:a03:339::15)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:07:49 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::a8) by SJ0PR05CA0160.outlook.office365.com
 (2603:10b6:a03:339::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 12:07:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 12:07:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 06:07:42 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 11 Nov 2026 06:07:40 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Vignesh R <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] mtd: spi-nor: Use mt35xu512aba fixups for other mt35xx
 flashes
Date: Wed, 11 Nov 2026 17:36:43 +0530
Message-ID: <20261111120713.1526940-4-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111120713.1526940-1-padmarao.begari@amd.com>
References: <20261111120713.1526940-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afcfa8a-9617-46f2-7c03-08df3fec6775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FEFfONDwKNo5+SGfbgeajTXbhYx+1Oit4zdQekW6/txpGz+TrP4mrI1Y6ys2T+DPvQDx2gy0MaJp9WjDPdhPEhA/rCJ9xIzLrZo9WF6giEP8fk5NhKbu2IUh4rBncVCg1iWRtpOiMWREET4X+n7iBUpxukFhsSa3XJOfpOzHeZ9ckJkhTKhYt+rc2iRUuuiYjQJu4V6apym7Ua0AOug3XMrH2Sem7iGhMbsJ2THFuPkcQXLXHYJRWpqfE+3CmNHiYqte4xH+yFkTMjnv7KHmgcHFaa9GADwp3ILpGUn7bFLECqZEb5aHPqrOdH7L83EDEUyphiW0a/Y+CJI2A7W+142V5+0irFX8HMiitG87xzqtF1WToaiG/GcTtrUZivfcCN3DkNpC9wvkNxy7nY1MLLjIHhUFcoQoGBkXjDuL4tpFar36k/YZ8dDVMJ0A/yw3aODCdyxe1W2yNxaBaKbfZ4Zv94DBc4GDjrRyF895W3eRSYuqe5Q7LmJaZBQqcSlW0HS+8gjrkonnF8bm9mwhyjWANy3bj8+/LT0YSRrDnwJNrKSmmIUnAjmOWDvdQYdySuMh4oxXgQotCTLv9XytgtNtSScumo6m4a16Oaj2ohMjcojag7NM2dWdBpmDZkNnPkYYVAwG12Z/R4F16ynuQXjickSelUFl1atTjbuqpT9Mq4GsvlWnw7NONyb9SBcjCSVuTM3Z1o0osNNkn+5/KQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t/XaQsTE+FxXxEemWZ/uQerac6bfElIpFFEy2fkg7+it02NB5M0M1bgwzFmBs9qR7r464erhWO1YveqTFWlxf8I9YKfIEu1/nCzDXs+xME6G287QCLF3CvpPnqJ10FZa6/6SelnujFnCjXvzw7qZ87N+wU0LUPp8ic32j3jeVuFXshsrWzXMgCrl5oXbscAZ4Yt8kcJbwDCarsuqFpfvcbSRvpJnDDlRE3l7+TKvmVl9k9G2pi7D389l0iTD88POP46nNIGYgshVXkVADChsTe1hC/VYgy8uagUWTLLMbhxqPjTKDhunD8T6FLlXQfU8VyGlQKAS0W3n6yWLTEZOxmU1M6cqCLNeW/Fu8BufaRwGvcvYWzl7XKV1aHNXFmGPfi8QjG3aQNPeALH5oZ5L7RRezP2yFdHwvODMyS4ayGO6VqrpiIlYutb1V4aLKm7y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:07:48.9466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afcfa8a-9617-46f2-7c03-08df3fec6775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
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

Apply mt35xu512aba_fixups to the mt35xl512aba, mt35xu01g and mt35xu02g
flashes too, not only to mt35xu512aba.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index c73f2c7c3f8..130c32e7286 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4539,8 +4539,12 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif
 
 #ifdef CONFIG_SPI_FLASH_MT35XU
-	if (!strcmp(nor->info->name, "mt35xu512aba"))
+	if (!strcmp(nor->info->name, "mt35xu512aba") ||
+	    !strcmp(nor->info->name, "mt35xl512aba") ||
+	    !strcmp(nor->info->name, "mt35xu01g") ||
+	    !strcmp(nor->info->name, "mt35xu02g")) {
 		nor->fixups = &mt35xu512aba_fixups;
+	}
 #endif
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
-- 
2.34.1

