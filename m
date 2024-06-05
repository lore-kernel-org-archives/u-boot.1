Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B56DC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 14:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3CE088313;
	Wed,  5 Jun 2024 16:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yQKuZciS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 539D78831D; Wed,  5 Jun 2024 16:55:55 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D399087A9C
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 16:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dr1Es/KEJ21n7Gs0fNt08Po/LWoUInsXKUH/e4cm3+zA/AwO8jyu9nx9LROLnRRdMEAeL945jDrYrRWgkxHcVmT/KkHEfpO6APujzDPTYa1rEdP0HJRvmX9XUWn44R839n6CcXpQw7JgZIHE7cwBJG8aHRDB3RfEPjFltS25sdk0Z3I70R0kpz9UgOvsyNWSTuhw4BpfqOKU4A/sZwfQ23KLbHsVfToIa/7+q4tuQdQMxAeBYwXnz3b9PDcD3IMuJqDtHxNN8rEvn5FYxmkXY2z2za05GLZSi/5V82q1CD9Qymv7EFh44/VZuDljA3NGXEssk+SCQ/+7KpcjF5lPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0cu/8z2K3+aD7ePW+hQzDywNP3FdddbhSL88B4fisE=;
 b=bqm8b/zzyv6HfXJmxrTSuUT8pfI63pvN0DitwkH/ukHzNBqVExlY3M5S4zQbadUTYXA7xGsNkFUBowLTe+kA58Q5/ca7nizjU9KGHQhJBuHF4lzP7/QC/wLgdEnQdzqYo1/+xTvf+EsErHtm5E1aYtaXeZcx/5d/EwDxEaSYMz7RZCeIxVfMjjeDoAHXuVCZsHpxV0N89JUioCXcpzZUnVKjsk1HxD+Fp1adUL5QMQCmtpfz5UkWLkSXRFQCKIo2JyEPoIJKYDzWCohgE+VVo/Cbmo1NmgERQkKcWy50OawLa6kNcaBoeJQWdBsELs6Ac6qQQB0ZHv7qTi2vIEqCmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0cu/8z2K3+aD7ePW+hQzDywNP3FdddbhSL88B4fisE=;
 b=yQKuZciSserPZcD3bZ3bOOcGvCcYLX2yE6U63QiMRU1gk61pRATnwrmv8F3qbpNTtvzTmSihbPBuRkqBAA1jhSx2pSDUh1JaBMQmhElCHqlUExMzkW1oimY7lNijjzolEjTS9hNTyO2lXhJ/cXZa2v9jjYAB5F6MetGGp4496tk=
Received: from BL1P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::15)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 14:55:50 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::94) by BL1P222CA0010.outlook.office365.com
 (2603:10b6:208:2c7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Wed, 5 Jun 2024 14:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 14:55:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 09:55:48 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Etienne Carriere <etienne.carriere@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH] cmd: fwu: Dump custom fields from mdata structure
Date: Wed, 5 Jun 2024 16:55:45 +0200
Message-ID: <75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717599342.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Edgc3O+T+BL7buUabJZRYqSJN1Wr6RUrl0F7R1yN1aA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSEmrxLRs96739ynKQamLjRLIe9Oc9YuWz3a1M5g4cNL
 2dqRkZ3xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIlc2csw3/mJsam0ym/RH99U
 nxRop2cq/2erY5jve1zsDft2BS69rwqRVyNrrnVp23gDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: c80ee3ba-6b1c-4fca-1d7c-08dc856f96d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VYSi09BlwAfLuhDMStSik8B1MWGWUq1NfJ/JqMQUuDNaEwpW5aqkiVwbVj6y?=
 =?us-ascii?Q?z7gxKyLhsLdNa78bQ+Fusdd4MHly3jyQAfmVZ/6kJWpSzkpviicE2BDE8vG6?=
 =?us-ascii?Q?hlH+uHZilWH6oVRkGfU7Nb6fvSM7/WmMtWxt5rDx2x1plAyLCNnENmG0W4ET?=
 =?us-ascii?Q?/CYiNNnpUR5NxFvbruRAJ3x+qqmqEQIR7+Yzodz0/0J33IMPT199+2TM11qq?=
 =?us-ascii?Q?sNjC1I2WppCJLa3Fa18s7L6Y3tLWh/z/5mcphmJlyKiSWiUexfjwmIV77aL5?=
 =?us-ascii?Q?jyoGTfp2paKCq8OhZrQeVX3U9IL/ZC0zAleAOKhcFCeWjxML+3+wRaN7NfH7?=
 =?us-ascii?Q?nRNeQRuygevWegUDYEuuoQseW2wJbcdLItkIdFt7WvzvTlLQYwjxO16wTPHa?=
 =?us-ascii?Q?m5+4cqcpt4sm9/ofGjL+cWVAXPPxPMgfgr8NHunUKnUKM1Ze9WS7T1DRs3AU?=
 =?us-ascii?Q?19CdKezbOx7W6iwOSDy+uHBOSRE+wF4X0R96IUmGybkNmrGVSF3bmSDWhScD?=
 =?us-ascii?Q?t8tfejGlkFl12X2tGHGA0/nu7WEGecukkwuEtnfDMzUDMZtOHrfqo/jNxgaH?=
 =?us-ascii?Q?CCmm4M3Dk2mn+v1NBoD3tuEQ+zo85Lr9+4J2+kkYUv2N15d7N5VtTwNXY3C9?=
 =?us-ascii?Q?OvFPQkkV+FXcJZP0zuCMKDEp4U6kZq40esndWQMQVQomWnjiXXDFSD4mwueY?=
 =?us-ascii?Q?Hh7TLyvNaLN5CHLACC8SyAKeWD5jCbJJuZuU+JTLb5hkY227WsmVjGnBavCh?=
 =?us-ascii?Q?hEkFdJrPo630MWAttXY4L2K+A03O1Kz+wqmLAcpH46sFv3djGTsRT8pgr8ii?=
 =?us-ascii?Q?yBGzotZM+cH2r8ihFyw8RM+j6FFydnXCwLRcJvY9K/+FR9RbuXpx1YED1+1R?=
 =?us-ascii?Q?HFlAUEyM87XOktV+BGw64a4UETLi5yGkSHn29sSacC/zahEgL2wXJ3NxhROr?=
 =?us-ascii?Q?jJwke2jJZaVoMoFgYTR98UiGGkyFcS6Vq+Ku6dQhdF0eCIWb6fKVr6o0sjpm?=
 =?us-ascii?Q?KW0ytukdPwIlqEsrPiiLqKxD+jLC6t15A0/4LFEhYwqCy6N9RL4yXm7GaQ8P?=
 =?us-ascii?Q?lKGuX3fJcSWJeAD/qh10gXbpmqqwCbgMV3uGGPirZ20wK0XagcdFlI93+uuQ?=
 =?us-ascii?Q?lD/5Wh45kQ/1HOmGbOnpabu5CVAc8LXTOLLFO+v6kcD92T7YV0P4TI85V2Ss?=
 =?us-ascii?Q?80KU77oUBqCGlpBvvCAjvY4C+mKVVWXb0ou4m48CpSu2B+xizG/Xxvekn8u3?=
 =?us-ascii?Q?1UDTY0CuMRVsOYZT+2wrAr3+ISXR/qEiVb7gs5GUR7zM/e8zfscngVC0tp33?=
 =?us-ascii?Q?nfBIBClzy8DBhmfl9qkBe4GsAmWopj1zaW1AX5Y5ZwsrIDQhGe6pfKGpIl8H?=
 =?us-ascii?Q?BqSH5HrqsiaTENzukuguj5JCmdQt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 14:55:49.7687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80ee3ba-6b1c-4fca-1d7c-08dc856f96d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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

The commit cb9ae40a16f0 ("tools: mkfwumdata: add logic to append vendor
data to the FWU metadata") added support for adding vendor data to mdata
structure but it is not visible anywhere that's why extend fwu command to
dump it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

I am using this for some time to check various configurations that's why it
can be useful for others too.
Sughosh: Maybe there is better way how to dump it.
---
 cmd/fwu_mdata.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
index 9c048d69a131..ff6435505167 100644
--- a/cmd/fwu_mdata.c
+++ b/cmd/fwu_mdata.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <fwu.h>
 #include <fwu_mdata.h>
+#include <hexdump.h>
 #include <log.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -45,6 +46,30 @@ static void print_mdata(struct fwu_data *data)
 			       img_info->accepted == 0x1 ? "yes" : "no");
 		}
 	}
+
+	if (data->version == 2) {
+		struct fwu_mdata *mdata = data->fwu_mdata;
+		struct fwu_fw_store_desc *desc;
+		void *end;
+		u32 diff;
+
+		/*
+		 * fwu_mdata defines only header that's why taking it as array
+		 * which exactly point to image description location
+		 */
+		desc = (struct fwu_fw_store_desc *)&mdata[1];
+
+		/* Number of entries is taken from for loop - variable i */
+		end = &desc->img_entry[i];
+		debug("mdata %p, desc %p, end %p\n", mdata, desc, end);
+
+		diff = data->metadata_size - ((void *)end - (void *)mdata);
+		if (diff) {
+			printf("Custom fields covered by CRC 0x%x\n", diff);
+			print_hex_dump_bytes("CUSTOM ", DUMP_PREFIX_OFFSET,
+					     end, diff);
+		}
+	}
 }
 
 int do_fwu_mdata_read(struct cmd_tbl *cmdtp, int flag,
-- 
2.40.1

