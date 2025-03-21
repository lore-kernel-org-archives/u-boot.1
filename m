Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C41C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 10:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C824808A2;
	Fri, 21 Mar 2025 11:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gcQpdZqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B80810FE; Fri, 21 Mar 2025 11:26:09 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D143805C8
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 11:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+Ta/hCNsAtAw62kW8srOsR/GN7gS27X/3QPYBjOES3zVp3Q4MLPwQMF1YWFEKQYz4CbO/nNuq3hSCT+WI9KHIgB9NJs/xh1WMyb7NeCuVWRgIC9CjvvO1F/q+Xex3ycKUy8tOa+D03ghdD1zgxXQmuOrVoamDTYckMMog+Fzlxka0qiP73lCMRin0tJVUxOpHdLrVw+Iiu2qTK5EEv6aZHhoRszMrtJLYTa4PmITFWRHhfveu2qE6h0mcUNR1e4SQv7QTCZMj5XEluNAmS7KyNSTOm5nfxK7sqr28yMKNjV6QA0KQqKsKnOBrfVQyQGsHCJ3j3+QYv9OWnqRpSbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UK0aojsaO7Hfk9/5+/EiQ2rbqmdpFvnfPwlqwVtfcA=;
 b=AkLSZEVDh9OjzIurLjTek8t1F2OYpf2xolxY6HJ0FRVa3EwzM9qYUX0h7LEYdV4HXKWbF9HS/JPrnq2mvQEZKHKyAsfvSB0zfCCJXO+cjVsBtAZADiF1yJ8Y6blaOrl2FoCN3SsuVzU2HL8BU9XmPnMd7B5RBg9JTb/6m/ZVn8/AZ1Ea0I9KHwYXTbkKiBBYa9poXIplg1LDPA7qo2mhXDuuvjgEOohkM/XyezggKrrYZjrogl79HbR6wrYhxJkUDrMQXlE2pYIOKbGJ9Vkb9RXw1ncje0ycwCUd/qpRPwi/q/HMgFtk3CgE2x7JTXqp9l/x5yFK5lcEqNFUj5+cgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UK0aojsaO7Hfk9/5+/EiQ2rbqmdpFvnfPwlqwVtfcA=;
 b=gcQpdZqPcu9/vbq828vA7t4AAXIHUQ4ke3G5k4yUHJ3bYFuv7pL21OlfsmNFR/kYJTbNct8fwa9UWadJAYsjiFxMkcR3yEzOG9XLjTXS49wFg52JDflZ3xdl6/3+kA0UGJr4BYGET9/7iuz3O3Gi7rlAfcRwGoRtqVyv1KAfBRA=
Received: from CY5PR13CA0065.namprd13.prod.outlook.com (2603:10b6:930:a::18)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 10:26:01 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:a:cafe::b2) by CY5PR13CA0065.outlook.office365.com
 (2603:10b6:930:a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Fri,
 21 Mar 2025 10:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 10:26:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 05:25:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2] cmd: fwu: Dump custom fields from mdata structure
Date: Fri, 21 Mar 2025 11:25:48 +0100
Message-ID: <1254c3c538facb1a124865aede861f399cf524df.1742552744.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2288; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=l0pYB8mlT7u2gOV4HoKb59yND1K7A6oJUlp7h9it4Ps=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvS7dmv3Mb79uZX/Tu3fFzavuSRfXWpnt+j+vfCu3uNJp
 55llRU1dMSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJ9N5nmKc/+e6BPeViN3bO
 9Fgobf5mS+AnnSMM8+sdeRrvtaZaeRjIRC7Onrv1wwqJSwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d08e3f7-c5da-4969-7a2d-08dd6862c6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1z1vtmoR+Vlk8duxnlVkhDAtv//g3qc/VqlHvmJiWFnyQeNkM4yn9lcImMRF?=
 =?us-ascii?Q?NpTfwMVUjjIyaXx1ZeJb43SooR2lXqC8B3HnoSjyxhHxvzA1ZbXZDBmzU8V9?=
 =?us-ascii?Q?NCLojSD7fVJiR8pxuLg6ySCHMW4tey3o/06JjPpuXaH9R0YEmuPxahr9Hcwl?=
 =?us-ascii?Q?puAjcxvFdmFshJO/ekHB1b6zo5MO6w5bTDEoiy8kPnRTH6NB/DXdtR2AY0os?=
 =?us-ascii?Q?TT2ELIjzJfhv+jKu0GiCj5dKdT0hFV/i6n31DuUCsHMTMJ9D4LH8nHila9hY?=
 =?us-ascii?Q?IWgPLgIV1SUrKju6zHsWoO8UpByde6D1bZmWAxFsXN+4/4SC1wc4YxTNbVSp?=
 =?us-ascii?Q?2pyrehxjJtFBSjDUlI5MCtgK8Z9D1uY0xcfmomHgBAk5pH+MWCQmyA1Z+cPl?=
 =?us-ascii?Q?EaNHggsV5h89Lwq78NXyF2hUd2TfMUxkW1UKKdOiRnVCkJk9m9x6GQlpO+Qw?=
 =?us-ascii?Q?rZekzXoj4PS6n2em0E0n9ZzIxZm/T8NIjVJKlUdj/wQZDxHvrGoBOl1gyVMG?=
 =?us-ascii?Q?D1xyJnmEi87/BXZWzDPQMPTLvg5qg/wcYt7kBoUg/2HuygXtUG6t44zgVQW3?=
 =?us-ascii?Q?7r6e7tceNRM/MvgLQqlnuGDqMmJ3ig9vQ45vG1UMzPzGCWMVN0vS1WwRfCj5?=
 =?us-ascii?Q?o23INCb6Fn0mu2LGn/4MkVRTvEA9i9lAZ5o2o7iDx/iCP3lA8Hi5LBeJ9bB8?=
 =?us-ascii?Q?OB2T1OXDIUs43r+MOr3k55fE1BSP3J21bw602OTH/S9wRdV+Xluo5S0J71gv?=
 =?us-ascii?Q?cW/rUrdSuruIjmaP1skGS66LpKOBFyYIdyn5P9wyAk44UmuVgLsSW1USP/8U?=
 =?us-ascii?Q?R7NUczLZgZxM1v3dZiPKDOAqN9zxo+FB5ulaMbHaah1gH1RJh3gVE+EbbQVv?=
 =?us-ascii?Q?9SVooMbOz1fbJcJz3Tt9NZ15hAvcvLuZse9qNJPDiiURIcmGAi+ZArxBv/aR?=
 =?us-ascii?Q?WVLlMCeNeHxVmCv5nAtvzRkgteMb6SyZ95n9WYBauOEYji4LeJO5S6L8eAtp?=
 =?us-ascii?Q?u7QXBCjYFwKoD3dL4zh/2XG1YqCO9fA8l2XvONnRa2FIGmSDuXkkOP5VAPHv?=
 =?us-ascii?Q?utTTghOKDqZZdgq0LSyvhr3svQUfy4XPGcTvCYNnBbyXUuCaM07PG23Wqxh8?=
 =?us-ascii?Q?tZgRCjyK1Qf9iIBqh4t4V7WmLnW7HDASxGR149VjtD7ot7qBa/TNEdhAh9sj?=
 =?us-ascii?Q?UjB33tm3QH8/m8Ih4M2DuOKVWdjCQKWCDnS67Iu0td7BwSTN3RYmnpit/wkf?=
 =?us-ascii?Q?Tjqzaqp8zYGmQy2WgtlL/UcaN0e9eonhdcjoCBvprZQAB/jb3a+lGwzTHKRm?=
 =?us-ascii?Q?ZPh8X2FITc9kIzGfniAuKyDblwS1CjwoLR88GtliDdT8DsEza8n3rWBxTfjm?=
 =?us-ascii?Q?pwLz/BZVIJBj24Fis0sMpwMCupHkiTHbkVdh03vrDXzEDiwGJxdMS3UtURv+?=
 =?us-ascii?Q?sgszszyWR9/+uNyi2slEekCe+6rsvWCdlWolsdcGoA2WHsHUGVmCUE2U9jyN?=
 =?us-ascii?Q?uE9Oy0lTOxVjzH0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:26:00.4806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d08e3f7-c5da-4969-7a2d-08dd6862c6b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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

Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Extend print message
- Cover hexdump dependencies

RFC:
https://lore.kernel.org/r/75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717599342.git.michal.simek@amd.com

---
 cmd/Kconfig     |  1 +
 cmd/fwu_mdata.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 642cc1116e87..1f8aa2521a8e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -185,6 +185,7 @@ config CMD_UFETCH
 config CMD_FWU_METADATA
 	bool "fwu metadata read"
 	depends on FWU_MULTI_BANK_UPDATE
+	imply HEXDUMP if FWU_MDATA_V2
 	help
 	  Command to read the metadata and dump it's contents
 
diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
index 9c048d69a131..5b5a2e4d1cda 100644
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
+			printf("Custom fields covered by CRC len: 0x%x\n", diff);
+			print_hex_dump_bytes("CUSTOM ", DUMP_PREFIX_OFFSET,
+					     end, diff);
+		}
+	}
 }
 
 int do_fwu_mdata_read(struct cmd_tbl *cmdtp, int flag,
-- 
2.43.0

