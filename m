Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BBDEE6457
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 12:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD9D868D8;
	Fri, 15 Sep 2023 14:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kxheMEm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F6D8684C; Fri, 15 Sep 2023 14:12:27 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0FE3868D8
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 14:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVwo1mPxZXfMTIgDosLr11lzBTB2llNFa0Y2VDJPMNYiW1tsoIB4/18PmayR52aB9avrqc1aq4UT03Vt0e40vUsVuYVJzAA8R3OC9k/xD3wCbyDB84cb+cDWJSTOnavICglTkIoZqtTd7FNuZWVYKg1lvjmMaIY2UcVl4BBXXhbER57O66KZBdLGGy1Oa6e5beW3+3RcDCS+uDedMg3yILKfWE6y2emJJ8noCbsGBT8rl4POqwTQ0JMzqIR2+P3OgkQErynSpODIO3hKiqu5iIhCO74ZrltY/6D0vmu3TSB8aAq1txf670/je7C3sorcb4Bezj5hsrlOFInLztlgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CR/XOHuD5E2F61+7oHr6Ms3Jc4u4IRHS/UaHKKBaE8=;
 b=m1sHHov7ZbUosG9W3Pa1jVObaO/gd4nenyUs99D21Z9RSxyWXMAiv3Cp9cvT6P/oc0x+n7Y8B38IDL3DJN1oeag4vx/wm0OefCVA5iTxb7COXi5zp1UPHzN7BfUa8NZdMdmVGbQQlc+mIWdJomw1AoaWXYkFXi+KrKl/3mv4jFkwaw98Ibwys+2Z2UCPKDMVQorVt2XsJjzpbifw8BJSOAy/VG+RhZyGqz1EZZVwxrGsaxbozCaq8ctzbF7cV3G5goTupFwQX2EdRZO+DC/uvZ1/VMVaDSY6U192oXzvHU24MW6mZmG7IeueoPdvBYYecMgr3TZufg0yVPvTTr9m0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CR/XOHuD5E2F61+7oHr6Ms3Jc4u4IRHS/UaHKKBaE8=;
 b=kxheMEm6fYxbNVZ4Md2RCXuCCitRU1YLql+9CZBmQcyFco/53OG5hgRIIJ0HwEHope762onOnhyIhGpk46WbD7YzOQ2Qi7W2Wro5Yobm4AKrc3NSQaewddH3vYkLcMNE2EKsXyK8u5JyLUaWxAGtfgbUcPtBk6ROnpe8KfyY2ek=
Received: from SN7PR04CA0018.namprd04.prod.outlook.com (2603:10b6:806:f2::23)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 12:12:19 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::b5) by SN7PR04CA0018.outlook.office365.com
 (2603:10b6:806:f2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 12:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 12:12:19 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 07:12:15 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
Date: Fri, 15 Sep 2023 14:12:05 +0200
Message-ID: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1694779918.git.michal.simek@amd.com>
References: <cover.1694779918.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=z66pDckH1AH5tOCVd5nXrVNjzUp2xbQU5ktYfJhYp0E=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQWL+EUYW/D9hNi03KXyc/R2Wa3yHhBLkPD4+b4ao2eK
 2XeyZc7YlkYBJkYZMUUWaRtrpzZWzljivDFw3Iwc1iZQIYwcHEKwEReuzIs6Lvy7OD7GMcjv7y2
 cayd43zNwIXdgGG+W3rRTr+i6rtLnjcxHCvp2Vpc+dsRAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d07cc83-31d2-4cfe-073b-08dbb5e50258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xd+KRD3l6YIQYhom9Wyhs3AHtDjQ7NII8vvcnqOC/opFxmsQYmuy7ajKFgpFuTgLPKVR/25I6PbY008pvWd2guV1iAZ8ATF7rIVVKEa1krIMgZIUe0rweEgk+8mg+Stcc3ZeaEnRVXNVBzK9tmSbDjn2+gA7QNMVCD3aS9g9QHMEFYRQcpTV7M/N5c2CaiSrnsM/uaiGDQeNMDnw/Khfv3DXeDa90LvqUBbzzU3dd1dkCoHuduljSHfGYMtx2Z6xlSAaHIsern/cI3ku7TS1S+qCB/AaYoE79cZZrEs5GWLbpTYke6EKYXaohd3nSyHMm/pTSZXCHawq+pbbcRPBr7U8+dYSY/Sh2pKvdW9sVqQRogpsSEAhcxIbSxUxlWdLSg4uHl1+SrmRZPjrTy/wTODpZVcQ4AKPw9VEKhum1tprmWDpsdVov/3n5Mp07U0d1ZZa5k1xbUyim4GW74QhdHXFTUUNj4oLLv+t9qQZVSicz/xzAOw4vJsQ5BiNWq9EgoUPm8gRQ4nabo96v+YFiDjQFzgg4nMUQb3mGjHx0/ToIbJ6HG9YHp+/IBIhRZ/XULIWuxf2V7tkOQplrQxI5MGDSSdKUO2cpENapyvONt23EhKAG5JdvqemkhdvMxH44UO5ukccGq+bXMs2MZ5GJPFXBhzwyd++exdF1bdtP6bZHYKC2xdI/QZNRqtARviJVvzunGJaRGte/XnBWdHk9P2HpsLoOwfo+36tq8IhFFbmNI2zaAOQc7/BhKmLNVv9dTEEsO1bHgLrWfAuKWjQOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(1800799009)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(5660300002)(8676002)(8936002)(47076005)(41300700001)(6666004)(316002)(2906002)(2616005)(70206006)(36860700001)(426003)(44832011)(336012)(26005)(16526019)(70586007)(110136005)(83380400001)(36756003)(81166007)(82740400003)(356005)(478600001)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 12:12:19.3893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d07cc83-31d2-4cfe-073b-08dbb5e50258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- s/start_addr/start_ofs/g'

 tools/proftool.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/proftool.c b/tools/proftool.c
index 7c95a94482fc..fca45e4a5af6 100644
--- a/tools/proftool.c
+++ b/tools/proftool.c
@@ -1493,19 +1493,43 @@ static int write_pages(struct twriter *tw, enum out_format_t out_format,
 static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
 			   int *missing_countp, int *skip_countp)
 {
-	unsigned long long start, len;
+	unsigned long long start, start_ofs, len;
 	int ret;
 	FILE *fout = tw->fout;
 	char str[200];
 
+	/* Record start pointer */
+	start_ofs = tw->ptr;
+	debug("Start of flyrecord header at: 0x%llx\n", start_ofs);
+
 	tw->ptr += fprintf(fout, "flyrecord%c", 0);
 
+	/* flyrecord\0 - allocated 10 bytes */
+	start_ofs += 10;
+
+	/*
+	 * 8 bytes that are a 64-bit word containing the offset into the file
+	 * that holds the data for the CPU.
+	 *
+	 * 8 bytes that are a 64-bit word containing the size of the CPU
+	 * data at that offset.
+	 */
+	start_ofs += 16;
+
 	snprintf(str, sizeof(str),
 		 "[local] global counter uptime perf mono mono_raw boot x86-tsc\n");
 	len = strlen(str);
 
+	/* trace clock length - 8 bytes */
+	start_ofs += 8;
+	/* trace clock data */
+	start_ofs += len;
+
+	debug("Calculated flyrecord header end at: 0x%llx, trace clock len: 0x%llx\n",
+	      start_ofs, len);
+
 	/* trace data */
-	start = ALIGN(tw->ptr + 16, TRACE_PAGE_SIZE);
+	start = ALIGN(start_ofs, TRACE_PAGE_SIZE);
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

