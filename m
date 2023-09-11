Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3D6EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 12:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D223F86E24;
	Mon, 11 Sep 2023 14:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A6xOnliY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A83AE86E1F; Mon, 11 Sep 2023 14:32:47 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF4786D14
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 14:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzbNepPCw3aveTByuGz5MLPU/gFvXoL0DETr83puwdMvgQLZ4g3YyFssDUtQ9V/B7L7jeUoy1K4h5qfC4I+sset76jNV5byLtobCEYD0c48bv2VZMmmH3IbW2t3Vys5OgHAUXareujb91D5N6pHlSrCV+wUm4/o7WLKwpqDH1LKiGp+p6K+CcHiGGmhJNL3IBmxg4rG4f5l0S383YkhhwW6JtjIAjI7bffj02agg7jDyhO40cgphhDRATUdmzreVOSZqdJ//i0yFUp4CzecFGxCPRKglcHm+6LizbCiD6VPD5A8298zgTlW5WcwFVHJlHtTzN4X14RpxdU/xwC4wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rkg7brRnl6FnOmNpRfp3ybvPxq7XPVQyH6P5oHDGHo=;
 b=aM97soUIZmKisrUdz3h04YuQq79gpSgyKwqACNY9HY2tY6vyRJFwh9BeZ2ZyTC2OBo6M9kt2VioF0W0+CeRkWCbf8osucZrxFyOmsqWwBUoh4l1YAqFcBXARbtXT88T2GDAwLN67Y1lscBd+IfhNSaEf0XGz72vbjDVcGA5HG+JdfnbBq9el6JypDwPo2IUJQZ+f9AZDZ7tPKhqAWmsVgWQZdW1ZVquuOYEubYOQm8TkxuQ5N+g2ak2kIemCsBlh18d80atNWL8YEswO/n02OsvdhvhIhVtjeITK/qoD2JoBxAGynsDbdn9T9wdGn1IVs2PJX9jWlukm2foq12blUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rkg7brRnl6FnOmNpRfp3ybvPxq7XPVQyH6P5oHDGHo=;
 b=A6xOnliYJfe4/BC6ljkSN3nhXYTKLJ6gRgez3Dt4dj06il6ogh9KNcyIny5LaFM3ieV/mqLhPdtdElLQoXLnt/zijiADBakYo4GEbGuCpkoPQWWdL/0tyj5VCvAN2y6umPKDl1BV4mPNKcNtzWr0HmlX58nImb6IaLEfYPHcyNI=
Received: from MN2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:208:134::30)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 12:32:40 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::71) by MN2PR16CA0017.outlook.office365.com
 (2603:10b6:208:134::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22 via Frontend
 Transport; Mon, 11 Sep 2023 12:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 12:32:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:32:38 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] trace: Fix alignment logic in flyrecord header
Date: Mon, 11 Sep 2023 14:32:29 +0200
Message-ID: <ffe462a5a535018833443821880becf3bb366564.1694435541.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1694435541.git.michal.simek@amd.com>
References: <cover.1694435541.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2396; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=qQ/wB0IeB1TTTolB0aH6qil/jBNS7mtZbzBoph3mXjQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT/HLcizvyrSXh5cEPX7BduE95zt4etOLZgSsmrhowHq
 35a1qxg7YhlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQAT+X6TYX4a142NP18eP9b9
 6qCK66fuNPH9nRcZFrR/NIi318rYXzt9/+YP/RK7+sWvngAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd2c88d-f08d-4e05-5153-08dbb2c3303c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vq22KeJrY4ST7mmqX0DS2MUhin0Zhfq87fIfBaV7KhSCKB7tkmDrmCXS5PRKIBZ1z+0mA7zmhbZvruTehXbynRqXeKl/Vyb4sXH/d/pKQU4ONKiZsGnJhtLoH5LwLtyK1d02xjGQsqONDspFEhW35KN68fxQPTr0yKJndzqyaOmKvb5qx73emqFH4FMBKmg5t9ZI7gsJvzqH0Ib1bXEjtDvFbbF8uh0PLimtXfsl8I1Na/sBFkm4Udkte09AOS4saa8B+Z09J5MdVzEIQvofSCeumhqyBIbNJQjyphDVePIPo/I4mzfiR+mJd7KV/YbfudiMGN+Z0KlthTXWIabyvDgBgmen3hWC/hMDWFq50CZ5KZafVK1haVDdbrqhgSoopPx1HgmI3tdHC48pzV7q9z/MYe8na0YEcmGLkqaAg+v55LkabK0Y8+QEo4RYcsi41uRh2d9pt1Xr9z216A+w5lsUQnwx7OgzchhlaVFbDFx8CYZyjf68LhHBFGQXgUFExPrdUgSkDsaGRt755TNyjFBC1PjfksfN9OGVa9/5UfLEZYQT6mLRUqkY6hILq5jP79Y6SbRXzFTVdbKTVBepCkoFtwDxEbcEKK6rjd1jMVmawoneTxdohGUfCIbmEh8fqqJ0DwkLQfIGeVs4r9hED6/EFx2jCZ5SCsF6bWKHBMmAOF2+pf2Jspzv8TVbEpJfi1hDeRSV2WEDLA9tFK9xUb+0ZTLRy0eAh7lsTQjmawhCpz2/XAqMLXhr4MSv+JEsQUR+aLQ+o91I/AI/MHT0cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(6666004)(478600001)(83380400001)(2616005)(426003)(16526019)(336012)(2906002)(26005)(44832011)(316002)(70206006)(70586007)(110136005)(5660300002)(8936002)(8676002)(40460700003)(36756003)(86362001)(36860700001)(47076005)(356005)(82740400003)(40480700001)(81166007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:32:40.0214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd2c88d-f08d-4e05-5153-08dbb2c3303c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

Current alignment which is using 16 bytes is not correct in connection to
trace_clocks description and it's length.
That's why use start_addr variable and record proper size based on used
entries.

Fixes: be16fc81b2ed ("trace: Update proftool to use new binary format").
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 tools/proftool.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/proftool.c b/tools/proftool.c
index 7c95a94482fc..f79128169e68 100644
--- a/tools/proftool.c
+++ b/tools/proftool.c
@@ -1493,19 +1493,43 @@ static int write_pages(struct twriter *tw, enum out_format_t out_format,
 static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
 			   int *missing_countp, int *skip_countp)
 {
-	unsigned long long start, len;
+	unsigned long long start, start_addr, len;
 	int ret;
 	FILE *fout = tw->fout;
 	char str[200];
 
+	/* Record start pointer */
+	start_addr = tw->ptr;
+	debug("Start of flyrecord header at: 0x%llx\n", start_addr);
+
 	tw->ptr += fprintf(fout, "flyrecord%c", 0);
 
+	/* flyrecord\0 - allocated 10 bytes */
+	start_addr += 10;
+
+	/*
+	 * 8 bytes that are a 64-bit word containing the offset into the file
+	 * that holds the data for the CPU.
+	 *
+	 * 8 bytes that are a 64-bit word containing the size of the CPU
+	 * data at that offset.
+	 */
+	start_addr += 16;
+
 	snprintf(str, sizeof(str),
 		 "[local] global counter uptime perf mono mono_raw boot x86-tsc\n");
 	len = strlen(str);
 
+	/* trace clock length - 8 bytes */
+	start_addr += 8;
+	/* trace clock data */
+	start_addr += len;
+
+	debug("Calculated flyrecord header end at: 0x%llx, trace clock len: 0x%llx\n",
+	      start_addr, len);
+
 	/* trace data */
-	start = ALIGN(tw->ptr + 16, TRACE_PAGE_SIZE);
+	start = ALIGN(start_addr, TRACE_PAGE_SIZE);
 	tw->ptr += tputq(fout, start);
 
 	/* use a placeholder for the size */
@@ -1517,6 +1541,9 @@ static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
 	tw->ptr += tputq(fout, len);
 	tw->ptr += tputs(fout, str);
 
+	debug("End of flyrecord header at: 0x%x, offset: 0x%llx\n",
+	      tw->ptr, start);
+
 	debug("trace text base %lx, map file %lx\n", text_base, text_offset);
 
 	ret = write_pages(tw, out_format, missing_countp, skip_countp);
-- 
2.36.1

