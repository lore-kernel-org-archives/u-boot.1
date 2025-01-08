Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D7EE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291C680740;
	Wed,  8 Jan 2025 16:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rsqVVIBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9EAE8006D; Wed,  8 Jan 2025 15:04:19 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 657D980601
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOUzbJDmzt1TqDf+r4jeJV/LSX08uV84Ia2vJAAqysnEPZoTWWn00V16BezF5b/0286H/6JNHNdtR/yY8exml8TEvk1Vt2xrO9xpU7RJ+oeLWw+eL/FbM57Ew9RSnVki1AtdEiv8Boora4VuOwb8O+H/IuOKa0GPg4qgafyrec9dA1JYpxDYEMO2PCztHdWg/qtvY6aPwE8OYZrLCtUm9P1u3rS4YTKL441kUhWW0sCx2QcbMNmjJfLbzBIqhWKx85twtr9MkdAInkFWxwzv8xAkwAZfrLBA2zXAl0GqNplU8sVec8PPlsNHmmw99JpMdvQrFDtqVAuzJDZG7ewpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoLvJUpCYBoYOU7ZouiryP4YF4MQhzMR1E3H4cC5CGQ=;
 b=brkceIMo29/oZYTzrYkQsN0pSAPdYK21NkzV3YzGP/Ud9/xRk5DfXdAi5NxLzNI8wmVKO1GNzXGpSVjJiRp7ZHW2ri0Cw3x3LjdJW514B7qR0DIiul11GQe2N+e80vqZkT+fYE/7PMbcF6XRdPZcomlezjOxZck8x7LgTTqdEI0AInBuzFHxd5ZpL2IhCFVe24Mdh7s8Ta4X2fqwW68RjOlNMizWYOVRLIKbN09EIOgnDvj21Hb4fFP2oVswF34eAuiHZSSNTvY3CvcqRa8eoAcHPxqh9/ylWrjkZoptaMkJWiqs6QGzB4xZA5ugJxbneISZAIxu/9jkfIQO8V3x/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoLvJUpCYBoYOU7ZouiryP4YF4MQhzMR1E3H4cC5CGQ=;
 b=rsqVVIBIRDcVg9/vM2ESpK8u29Q0Dv8z9sFtNfA5i4H4/jfBOScF6MTcegE6MyaGYgg4QtSAdnw8nOd7VaBhohkC1sENONZ6gLGQHKbR/OlD/xixUDdONlwqo2t9tRX98H73EFTRNl54z71SNkNfju2HEjVoGFFNARlRHkFxjpA=
Received: from BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::7)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 14:04:13 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::32) by BY1P220CA0009.outlook.office365.com
 (2603:10b6:a03:59d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Wed,
 8 Jan 2025 14:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 14:04:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 08:04:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 08:04:11 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 8 Jan 2025 08:04:10 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH 2/2] fpga: improve loads usage information
Date: Wed, 8 Jan 2025 14:03:51 +0000
Message-ID: <20250108140357.969380-3-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250108140357.969380-1-ibai.erkiaga-elorza@amd.com>
References: <20250108140357.969380-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ebd4ca-ba14-4337-881d-08dd2fed54e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A6vzydGBKIBjxCVn/gZJdHBeznLHyRXAPVxQC1i0ysPNbwKaCENgnujY7+9K?=
 =?us-ascii?Q?NunN24dwWafNkDEPCbam/v6Jm+a7YstM/xU0VHArFCioKZdUN8dzNvSXspox?=
 =?us-ascii?Q?0StOT8qTYZ59iVbc3cinma29eGq91ThRTs2z+v6aaU5tt+12iaefkaA5avei?=
 =?us-ascii?Q?3H7c2KMjf8n24cpRWr/zK1DkloxwM4j/Zljq6LwvyhSTZRhxY/IyYySo0jLN?=
 =?us-ascii?Q?AYeASkh0YPQjq2+XtaI1KlEWrXNxVV8CtJBINSF7UFQu6Rwliy75PtGdE9jJ?=
 =?us-ascii?Q?0Sz8bFCav8sVLoc3JYodklwog8oT+lLyFR/X0HZ/TRtFs5lHx0iDCdX9dI7I?=
 =?us-ascii?Q?sSwIo612DXcJXWg34AIMdmSH+l0HBT2Tnwb7xVHvVcmpsBT6OSjVi+lbLgW2?=
 =?us-ascii?Q?CXMa2UcBLNfDHYc9AZqwR1GMRB7uOWHPHSOmX8tR2DS2G3n/0oKgLQrTQSsu?=
 =?us-ascii?Q?/6OXsYBrn6SIusMdtoSBK7i8YWgZkpUGeKh5+cBon6t1A7LVOL5QSDaHQdR0?=
 =?us-ascii?Q?W69aqQmwVQ4qBAHbr00PUv5p1nKiK29fg4KH1D84BZLb+7AS6UVtQlJ/3dvN?=
 =?us-ascii?Q?bp0XPVj9WHP9sZkhoXifrgwLDjpETxWtzLpNfIN3gfT2NCeh1uc3VsWrUJxr?=
 =?us-ascii?Q?6LCFup1xqMz/ePaSlc6+xQF0aN+gE49HGQEi3tjKPflAIn/6PznC9q2JgWJR?=
 =?us-ascii?Q?PhR33CcQXRd9Aa2npe1mcCDc8JIMqVejJL+LnaN46FzjdXhflt/ObyiUxtXS?=
 =?us-ascii?Q?zyjBqKJZExdwVtuH8ShtsJPWsgyp0kQuoHn19DOvxK7IFI4QiHkGjSJeGX/C?=
 =?us-ascii?Q?sRefiR5j1Gzjoxg43cYiGR37JG9K4tlyAn2fVaghSk7T94OSCBQ17LwOXQsN?=
 =?us-ascii?Q?MARIIiM+hl5mGzP6Yeqdf23y3pvkQeWt0it7tc6Xu3BbjRwi64CqhgYayZmv?=
 =?us-ascii?Q?42lPlmq1uR74rETMy/RSq0pLijjWOOy2CRHV14+o6YpglKaLPjD8+DZtOHtY?=
 =?us-ascii?Q?FlNxSqPVT1/1UkqPHN52wIBAr3JX0/KjA275HspQtm3p1ZmD76uohdbCDZCt?=
 =?us-ascii?Q?drYdBtcO8gklluFzMJkghqF7V7hdUkbR0zSlZvij/6Tf3UEBgAsFKaqP4b1s?=
 =?us-ascii?Q?gtAIgYD0A51cckSlz/7sgcaIP+WMkKIA9vqX7+m/ZW4vNcBbtOrbPrg5k10k?=
 =?us-ascii?Q?LhYcbYaPXJhtM4hcBQe586Ffmt7SwNsYuB73taYE94iPZc3BVEIYMeDLvTZs?=
 =?us-ascii?Q?i5ostfaabiSHS/NFT0/iWcI2kbpzGpm13DCZHqdoyXIS9HMbqzdw9clC3fy3?=
 =?us-ascii?Q?PCTFLJhbFr22ZnCl0XtRNVZTC1kgUAo2YeJl05iycER7IgonlZTyix/S1/oV?=
 =?us-ascii?Q?GN278wR/A+YDGOCTIafwiqrNzTe5ZIQBGJGvgqleX8CsW5pXnkCrhP7N+WgI?=
 =?us-ascii?Q?6RG8GQ2bv+MuFeIV4Vruw1RSqFN4yXP33tHD/j/RLDFBmMdk/ezx3ZBfLzfl?=
 =?us-ascii?Q?kD8CaA36UyVQDnY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:04:13.2712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ebd4ca-ba14-4337-881d-08dd2fed54e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:49:18 +0100
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

Current usage information for loads command is too verbose and long for
a command usage prompt. This flag simplifies the text for readability
purposes.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

The authentication and encryption flag naming is redundant with the
description notes included. Use authflag and encflag names for the
command pattern and use description lines for explanation.

New output looks like this:
loads  [dev] [address] [size] [authflag] [encflag] [Userkey address]
        Load device from memory buffer with secure bistream (authenticated/encrypted/both)(Xilinx only)
         -authflag: 0 for OCM, 1 for DDR, 2 for no authentication (specifies where to perform authentication)
         -encflag: 0 for device key, 1 for user key, 2 for no encryption
         -Userkey address: specifies the address where user key is stored when user key is selected
        NOTE: the secure bitstream has to be created using Xilinx bootgen tool only.

---
 cmd/fpga.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/cmd/fpga.c b/cmd/fpga.c
index cba38662958..cbcbe9c32f1 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -437,17 +437,11 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 #endif
 #endif
 #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
-	   " loads\t[dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]\n"
-	   "\t[enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]\n"
-	   "\tLoads the secure bistreams(authenticated/encrypted/both\n"
-	   "\tauthenticated and encrypted) of [size] from [address] (Xilinx only)\n"
-	   "\t -The auth-OCM/DDR flag specifies to perform authentication\n"
-	   "\tin OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication.\n"
-	   "\t -The enc flag specifies which key to be used for decryption\n"
-	   "\t0-device key, 1-user key, 2-no encryption.\n"
-	   "\t -The optional Userkey address specifies from which address key\n"
-	   "\thas to be used for decryption if user key is selected.\n"
-	   "\tNOTE: the secure bitstream has to be created using Xilinx\n"
-	   "\tbootgen tool only.\n"
+	   " loads\t[dev] [address] [size] [authflag] [encflag] [Userkey address]\n"
+	   "\tLoad device from memory buffer with secure bistream (authenticated/encrypted/both)(Xilinx only)\n"
+	   "\t -authflag: 0 for OCM, 1 for DDR, 2 for no authentication (specifies where to perform authentication)\n"
+	   "\t -encflag: 0 for device key, 1 for user key, 2 for no encryption\n"
+	   "\t -Userkey address: specifies the address where user key is stored when user key is selected\n"
+	   "\tNOTE: the secure bitstream has to be created using Xilinx bootgen tool only.\n"
 #endif
 );
-- 
2.42.0.325.g3a06386e31

