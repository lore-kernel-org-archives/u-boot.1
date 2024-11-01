Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB06E674BF
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 09:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA13388FBB;
	Fri,  1 Nov 2024 10:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Zm5Y14w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 437CF88B8F; Fri,  1 Nov 2024 10:18:18 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A17F3891DD
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9NiCjbOJB4FQmhKETVkZws/u5/PddKvkcL21OQr0mE8UPr9SVTxLEaEFbXpzx5Bleb1E2g10/yUfDWru/Hb/8yWwRIGSq8hi4JSROLNbg+FIanQIRGIQcV5u4j1NyH549NiNFc7fM5At93nBgjCnHG7GA+vvFylLA+ds8oZ/tKPkMCc0/f4TVY/mvtgqmy2DDkurVBP68sPX1SEfYUyQXZIC/oFyCIWIGTTx4K22SVRquqsTPUXWZW9QaxlwGY5p5qCbPTAlZm/X9/vpaWK6CTKkypV2pXvYKjbUrxTe1QphJbuhAEEDO+iJ5O3U8ldeXypM+GrX6W/8olPIIePbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjvgpLaeboaCFFafzbhTZy0Gz//3tBnJahArYDInxHQ=;
 b=gPJTmNSE8thJY8/7+9zpgDaCj0MFp5EDxIcppydnsJznEG6dCS/vdOERMBGZpEVYSg7TiEd2hEukoQgz5BlA1aNxCQQXv9+ZKZBSoAS/wXlmJ/VHhfkb+PygyU1apBoH9cBzErhHMC5Xc9WKTOOb1F5ZYfJkFfxZaG5wUCcahGXULALSHmC3cXEsBgEV/C/rKY4lDotY7LqEgrip/VItMC5jWNwnDqepHhxeO+5nrIOaT0tVQ58PMpWq3BAVu6THYVthlp2dkM5k2c42BoARUPIcMlIj/51074NK7T1h/RVeaRDkks4XLz/Z8OmnL/w69k5l3oFreWP8HgNXdrYRhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjvgpLaeboaCFFafzbhTZy0Gz//3tBnJahArYDInxHQ=;
 b=3Zm5Y14wJJWOENzQPE8Uv6rv+2oeq+LOlxykFYnLJLbXRb3gC3RhEltod3avWrUgHREblGeMB4ZC3K1BrkV+XZquiPB9i7/Fv+Z+scUXwDE9RfGloe1g+40tg8uMbeVDITuSKnK3Cyxc+Ky2sdudUTeD8720DSr7I/rk7MlRR6o=
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.27; Fri, 1 Nov
 2024 09:18:12 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::8b) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Fri, 1 Nov 2024 09:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 09:18:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 04:18:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 <neal.frager@amd.com>
CC: Christian Marangi <ansuelsmth@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/7] common: binman: Calling initr_binman() when BINMAN_FDT
Date: Fri, 1 Nov 2024 10:17:55 +0100
Message-ID: <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730452668.git.michal.simek@amd.com>
References: <cover.1730452668.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4iw/elgugLQIQnC7GDt34jkV7QIBSihmY7wDQvMUCJA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVOYd98585L8uaYjn5BIf0Ryf734++efw+oOH08YXWz
 l+NZoI5HbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiF3YzzNPhvS/4WserwWPR
 8sfzmPdYBqxdX84wV0780zkL8f7aScqJRkXMRdcM+6zYAQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d6e978-f526-434b-dd31-08dcfa561bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lQ8bjX/1sBEu9ROWW4PKxF2ZLuubnbCLp6sYnobcTVozRhSgonAjrMaktRfd?=
 =?us-ascii?Q?iPA+K5BeUD4GzoBZwNnoxU6lGa6hR0gXe86qbn3sKVPwGwoySd0fVXMuONIr?=
 =?us-ascii?Q?DJmuxeQ0F4edLE/19vYk9NeKC0AmTHwRG0dd1NkuG6EAfYFoBrbhdP9rjTfp?=
 =?us-ascii?Q?eIRvpxFy0QbIJrBnGKwaFI5rREyn/nF9sGEEmGnPm8uTIHLWTpuuNxndF5Kz?=
 =?us-ascii?Q?HJ7xRPdS6VyfYgdukzZaKVmvN9d+fx5Z7ezUlKS7vY8RdqV7O6L/Bi0i2i3X?=
 =?us-ascii?Q?JvGj0hyJ2f12+3CTMPD+601AdUr4kYAa2OIFV/iA774ivV4Jthb+6Jm/YPfA?=
 =?us-ascii?Q?j4mbuX1c0F29u0AD/gn+ExiWXB7buNn8eViAnNAoIqlj/acNcNG/kdYxNxOb?=
 =?us-ascii?Q?2mS3fY3WN0+7tjAwZ086tc8zqi8vptkrOUKODBP9AqKBANJCSfDScEy0qqtq?=
 =?us-ascii?Q?Qg+uobwReOTjP/mi4FLTCr+qO+LjlYtM6KNqsseCD5MWy7Y83EzIyp1y+ba2?=
 =?us-ascii?Q?X3PQwSgs/QU6v/x/CwAFHNIRTW7u/FqaBs2w6Xs43QukxvEu+WPW/1oBts5H?=
 =?us-ascii?Q?xZXds9Ty7x5wdpdD3WkkGjVdYBEXjnncexyTvBjDoRSviqg8ksIrecG8PWGa?=
 =?us-ascii?Q?/wqNEGQa6qYOaY5Eg87o9m4rrCMxdqlSbJ3dNiYMlpOTh1HemiyGdyfkpolz?=
 =?us-ascii?Q?nm0iSOx/Wuipv5rVk4d302uk5fiFjAlx6CFfpP82gcp/ccCk+MRQHtodvzO8?=
 =?us-ascii?Q?+vx1MjqA2RgByPUv0mgCfFLVKy3vdA1mc0lWLsv5D1IbIW2cZ54oK78B2wD9?=
 =?us-ascii?Q?L7GA9L6QR3JCK5HTqbBC8ZLmvn4Y3K8ITRn9DPobSulTpeOM4LGNB5X0EmX6?=
 =?us-ascii?Q?SPH/6eX+BYTPygCee+2O/fnNe8V4eGA0+no/Yf81QzECh5rRs2RlemGKQXZZ?=
 =?us-ascii?Q?DsEIS1jalB7DsQaaWC/wzHjnKnEamt9KLN6siVj8s9yf3MYT2MD7pkbf+lHo?=
 =?us-ascii?Q?8HAEGNBxlZA8jkfVnrquBF8vDgWV6rOQp6a4bEqW0w6x6JkaMeVB6YaI96bf?=
 =?us-ascii?Q?Pl+zH0B0UB6yZkPGX6jcjz/z2TSBX7heZs1brB3NSwt364lEgAX0l4y6WcGb?=
 =?us-ascii?Q?di19vzu8jHNKc4Y730UxJFatd3I2UBaAVhk2npt6UkYJ7lTxVYTKkAtSS8j3?=
 =?us-ascii?Q?t5mAAaisEJ94ajBzXnmunriryN27BWbceUD3wtTol558zGNtKBw6g9wrxBtK?=
 =?us-ascii?Q?XQqPGVGfRK2L/P4GyKWmE8uj/04uXY5mB00vzb79Eno0caPy6TQvfi/p7GRL?=
 =?us-ascii?Q?HiCxvoIH29xOliM7KSpXMf5U9YDWqFo4gweUOPbUwVsEeh+HsV8QeGWls9Uk?=
 =?us-ascii?Q?UMi39EGCjMuDvUIS8CUQLbC9OilyuW+meBsPqapDCPrcrG5BaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:18:11.9685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d6e978-f526-434b-dd31-08dcfa561bcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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

Calling empty function when BINMAN_FDT is adding +64B for nothing which is
not helping on size sensitive configurations as Xilinx mini configurations.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- new patch

From my perspective there is no reason to call empty function. It is just
increase footprint for nothing and we are not far from that limit now.

---
 common/board_r.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 62228a723e12..ff9bce88dc93 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -287,13 +287,10 @@ static int initr_announce(void)
 	return 0;
 }
 
-static int initr_binman(void)
+static int __maybe_unused initr_binman(void)
 {
 	int ret;
 
-	if (!CONFIG_IS_ENABLED(BINMAN_FDT))
-		return 0;
-
 	ret = binman_init();
 	if (ret)
 		printf("binman_init failed:%d\n", ret);
@@ -635,7 +632,9 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_EFI_LOADER
 	efi_memory_init,
 #endif
+#ifdef CONFIG_BINMAN_FDT
 	initr_binman,
+#endif
 #ifdef CONFIG_FSP_VERSION2
 	arch_fsp_init_r,
 #endif
-- 
2.43.0

