Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ED6E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 10:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5000189400;
	Thu,  5 Dec 2024 11:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rn/cIiXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFBF589448; Thu,  5 Dec 2024 11:38:36 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81848893F6
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 11:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on0d3Xjq13H29ub8+EIK1eJ95blmj1zbQmfxX2nqBAbjOq11yoCuURhh9iVd2B9/pDL9zeVbHISiYPTBFpp/T0L04RCkZLSVCiSdes8NbObHXEpwOmZ+0hzenne3lEWPQhNqznWoU76gger/+irjuRCzt+OSkjiaVPQ4VISX7b4bQAPbXGeFqEHKb95u52UEDaZZEBEIzeD7gVchdiQo1pYtE6LNmGtQbRAjh33j1SkuA12anvRqcZdX7tOyFem1jQhW8k2QjRUXhvV/I5UgDb3aioONLE0jeZ9Ocv6qgGXs9McPXWM0aSSHi0M7X3ADkppqb0hTqRoBY8I7JNhKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1UxujpCaJ6R0mAB5W2rC+3V0Ljrd8I/1ieSVzDvUHw=;
 b=yy16fhgAdkAIU4tT0rQpu0zWnJ5tfez1t1eXwTjJCINOQG265DYwgNR+kt83aNvZYB5kQ4GfMhOIMsr2ktehn5fteRmEjE5vPG5DxICcdWaNIqsCWwqyyi9uj/s+uZM9utT64O2wa9Pt5CuGEqaSajBdmwneL7p/YJsD4Sr1AEh8QKIf+6NIaspD9aI9SclZt9ZFmNVSbmq053UPJeyUHbpDl2yV5vhqG7YpAH+BodIdyyOK8qgMq0gcgVVEAOEA7GR/uRy+IkXUZ5Q8kjVVtmV1gNTM6PfBgLBkxZxDklX75ZAgYjncwP8l3iSIdbfjtCVCHGxFYQ7/jFQiBo5okw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1UxujpCaJ6R0mAB5W2rC+3V0Ljrd8I/1ieSVzDvUHw=;
 b=Rn/cIiXW3VRvJ9xhGURuGCrL7SDIOl8huXmtV3RzxNve6qWg8OlsMBUDOQkd3mraTSSYvowM8ldwZLlPNGfYUAR8vuRfrgMkdlqdlhiTZuspISOyZBOr/Q+UQyaoR7nA8IS0qiHfjmLpEQ/dIHSx7KVqUHg9idykszdnKnv8IUk=
Received: from BN7PR02CA0021.namprd02.prod.outlook.com (2603:10b6:408:20::34)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 10:38:30 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::92) by BN7PR02CA0021.outlook.office365.com
 (2603:10b6:408:20::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Thu,
 5 Dec 2024 10:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 10:38:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 04:38:27 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/2] arm64: versal: Support operations around multiboot
 register
Date: Thu, 5 Dec 2024 11:38:16 +0100
Message-ID: <72ba2efd0fb7b66a86b409a1521fe288a4dd3453.1733395093.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67ff88c8c7186138353c0b74ed37a318fb4b199e.1733395093.git.michal.simek@amd.com>
References: <67ff88c8c7186138353c0b74ed37a318fb4b199e.1733395093.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Ee0SjLzekv7GvKX6RLCA0aUFXHnPzN2YEhsyjFOKyYM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTApjlsPjplE9XtWI4vmK92efo69V9+b20rBSsPiHAXH
 93Bv3hTRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhI9SOG+Zn2LecrDzCbilge
 vXc8XenyoU97LzHMz9GyqM+6v2OG/4/Lc3vjJylH++/yAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: adecebd1-f2f9-4de1-e738-08dd1518f557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cBp0oHWMlfVax8ePMW9QPFAFa+rDwYp+D4BxtKnCKyzqJtteFLtRoWyRe8oz?=
 =?us-ascii?Q?mE8c74A39lZL9Qiw4eswKahRD2n7/0YYEvz6Z6xe0jlyfGQAUhcBRBuxyIw4?=
 =?us-ascii?Q?Cm0YK1DihmCOgdZ5kXeDTdzE14/HL4bRXXsXGIEu/ZzU2SzU90LdeAwKWi+l?=
 =?us-ascii?Q?8Tf/WdNyykRgR8fuD7m7lLElsPYsbcyTA3G1Qb5vQHF+nyaZLrZbWhDZJ1sV?=
 =?us-ascii?Q?UVrMQ3J+3P4Mzzi7SqMI43XSU2XTiRyvUq8IjpWe7ezSWC+8IcOJJFfC49EI?=
 =?us-ascii?Q?5YaA8K4wgeJ0bB/k03iFKYWknFXAxmubzOI8rxud+1AYK1cIWXU/w1YVGtTC?=
 =?us-ascii?Q?OFKfQYsnfJzfmmYmQS4Pv+ilV7APXM1rtAL5nXLcTDHFWC17sOE8EUkTgxEU?=
 =?us-ascii?Q?ypvRj9uBDcAXThI3OdIUI8X45VzkiTYEkfYMAq5T4gg9aHd6GUytV2HnY3N7?=
 =?us-ascii?Q?1GPSLXuJRXIQ5ElXH5ws5sdtYthZGhx2htWc1dk+B3G/nKfPFB0obQfCuy86?=
 =?us-ascii?Q?K+ja5WVn3uNZG9LGJ+W7sSAtCaazJUzErV0UPjT4XcDqfGvL/1Xm59OQ3KGe?=
 =?us-ascii?Q?iXW0/UOd1gPHVodTmqmB7d9kiZT0QnNq6KujvF/6ASgfy1OKzYEjC6dpKwl7?=
 =?us-ascii?Q?K3BI0cdypnjGgnklyT8l1g1GYKCZ9R3gwpkWlhApYN1qRdSuz0Wr3SKtrdII?=
 =?us-ascii?Q?SH9wJ2SGCRc4RxCNtwnTRS9EHb2JT1DOtA37IG880f0k/7BNmAj/OMOm/eBr?=
 =?us-ascii?Q?O7rySdpqph3U2QVXYlZW2D6QUQxAjtXn01yKxRiZhI1uT7pj6/eaDYDGnc+B?=
 =?us-ascii?Q?oBwBrIHI6u/nqTKGYWZQb6X7O6d8oUWV+LwynYmpkslDp2N3YfEfQS+BbXB2?=
 =?us-ascii?Q?4jSxZc/Ug/mdyQEk9TsZmgmRtPm0bOZdFcvC4E05dbO050iAOnpU9Pn5Z2a3?=
 =?us-ascii?Q?055IKkZcBbXHNb+SQxVCe9KxJktJsxt/wzekAcaOZzPmjUVgL/OEV2kXBjmG?=
 =?us-ascii?Q?HhPRX9Uj9DcK5cW8kCtzPY+mA4TCy1e1ltqX1WE0NF23bu+uPqZAWhK1R+J8?=
 =?us-ascii?Q?uunMqIv6ZW9AmV/71q9avH2JwwRMx0G+AZW91ycTWroTD7R5l/XuJq+i3NzA?=
 =?us-ascii?Q?S/w0DQCmcZdbmBiK0kUlV9TjF10GJPzRxLwZ9o2ip/RvaGLVfYCa4IT0syT1?=
 =?us-ascii?Q?bUyiX3Hyp0Va4R10t8fH6nTH1Kck65WIdOgm38JAgKtx1CgH2EbiqXOhR4y0?=
 =?us-ascii?Q?VDWhgFrHKyk5jyHQ3sR0wYyd+0xxDzQ7BIjnHx/yTAVZDRSCMApjIIqMPyti?=
 =?us-ascii?Q?foohNtsm3Zmj/izSkxhyD7SKGbHK7AZqWgi3XJLKLLJqQA5fSSgCn9TIfqqG?=
 =?us-ascii?Q?RogVfgNjT0EZKhVhjuCk0mdZ+FFBVq1X5NfuptTPCXJMDt9nUAex+cmOHIZ7?=
 =?us-ascii?Q?K70h3Xj4iXiCj7j3EdwVNHdR/6qZfH/R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:38:29.5274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adecebd1-f2f9-4de1-e738-08dd1518f557
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

Read multiboot register and show it's value by default.
Also extend logic in dfu_alt_info string generation to support capsule
update for different offsets.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal/board.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 964a779b5f19..d05220f96ffd 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -36,9 +36,15 @@ static xilinx_desc versalpl = {
 };
 #endif
 
+static u32 versal_multi_boot(void)
+{
+	return readl(0xF1110004);
+}
+
 int board_init(void)
 {
 	printf("EL Level:\tEL%d\n", current_el());
+	printf("Multiboot:\t%d\n", versal_multi_boot());
 
 #if defined(CONFIG_FPGA_VERSALPL)
 	fpga_init();
@@ -375,6 +381,7 @@ static void mtd_found_part(u32 *base, u32 *size)
 void set_dfu_alt_info(char *interface, char *devstr)
 {
 	int bootseq = 0, len = 0;
+	u32 multiboot = versal_multi_boot();
 	u32 bootmode = versal_get_bootmode();
 
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
@@ -384,6 +391,8 @@ void set_dfu_alt_info(char *interface, char *devstr)
 
 	memset(buf, 0, sizeof(buf));
 
+	multiboot = env_get_hex("multiboot", multiboot);
+
 	switch (bootmode) {
 	case EMMC_MODE:
 	case SD_MODE:
@@ -394,6 +403,10 @@ void set_dfu_alt_info(char *interface, char *devstr)
 		len += snprintf(buf + len, DFU_ALT_BUF_LEN, "mmc %d=boot",
 			       bootseq);
 
+		if (multiboot)
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+					"%04d", multiboot);
+
 		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
 			       bootseq);
 		break;
@@ -401,7 +414,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 	case QSPI_MODE_32BIT:
 	case OSPI_MODE:
 		{
-			u32 base = 0;
+			u32 base = multiboot * SZ_32K;
 			u32 size = 0x1500000;
 			u32 limit = size;
 
-- 
2.43.0

