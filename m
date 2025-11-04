Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B82CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 12:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB92A8004F;
	Tue,  4 Nov 2025 13:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lwddUsII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 854F9808AF; Tue,  4 Nov 2025 13:58:19 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FF098003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 13:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvZeLBtWoSqvpx5mVPCmytIOHIh8pB2n86LoE+9bTkWFEz0C6T3+/Ee66yZ4/O0zBFhgQsBsBmwTeV5rOiTAh+kzG5FCZtWGO6l5i8/UxJdGjaFa+JGcq1rR6OwdLfJUqqt3d0uBsngX1cwqNCG5Acdj+KceElHiBZY3OYGsBXomGmy0gZzxXHDCcnrmGEfJdSTDfjlduKV0Aq/ornxWui39+B1KK0lkjAr1J+gVUHrPgLaSPADG+2Q7znLQ3ewoNfI2kM3TfI2dFftEmM9Mjf1v7UNxG9DWrQYmpAtj7W03qI/DHLhoRo906q6HLiTQlwBbpQGeT7RcKPBMYfs7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCB3rKeKlEAdra5UCkYhRW/W03sOpQX0EgmA0T2r94k=;
 b=k1coof4ORhEJ4XUdMvHQXwCE1HmTsDiWd2UCthUxZBhh3epghrpnn/40QnXjuiSgxSgl5ld0kBOUJTfUzVJV9m17YGNRrs1rEXfxrseGUMwmpokQI4yNjY37yjpE6N6hqMXLC3zbF1B8wZ0YcAVHvKN9HbVVk+zvyMT/z6/6j/0WSq2Ikps5QK0Eq+NpY3OcW1ncyFe6g2pVLuB8JZVmOeB1jjiWjMvC6tLPrilil97rgch+C54kSw3ZiJ5sV1GxnyMjQfOxHLVhdgLlHGszyK2LxbK2sO5phJ7VTnRRMt73ymlJ0dRiZdinsZrlv/BEg+q8mf1cbQMPeHWSWvgM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCB3rKeKlEAdra5UCkYhRW/W03sOpQX0EgmA0T2r94k=;
 b=lwddUsII4tSd8rs5xX7dafj1enZF2QKu2yEpDSNl6ss7qpoxKOtWR/tTIKOZXCefh6q0PHeFBlasPtKJSGj9z2VDUYnEdaTzSoi5NEr055wI7EXu0cV0lvePlOmgxOIFDQc91mflO+66w3gXp+Bn3rs1xsHe882jtRygoa0WwVE=
Received: from BYAPR02CA0070.namprd02.prod.outlook.com (2603:10b6:a03:54::47)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 12:58:12 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::5d) by BYAPR02CA0070.outlook.office365.com
 (2603:10b6:a03:54::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Tue, 4
 Nov 2025 12:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 12:58:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 4 Nov
 2025 04:57:34 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Nov
 2025 06:57:33 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 4 Nov 2025 04:57:32 -0800
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH] board: xilinx: Update ESRT after copying GUID
Date: Tue, 4 Nov 2025 18:27:25 +0530
Message-ID: <20251104125725.1628068-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0dfa9d-c078-4aea-d2ae-08de1ba1cfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RAf9rl1wEXozYL+c5Hb8CnOSCuHnF5qX0M+8NmMRpQqSemF1gSoy2vhh1NuP?=
 =?us-ascii?Q?TcYkK3WE3Qp9UByfVlJWl7k/Cqf11WpfODlOHAEHyiJ9lk+/oAGmKrlTtEcu?=
 =?us-ascii?Q?nZntWqw9sL7icHmrdW/1IC7dgfOQU0KIanxcuXYCZWmcELpwEQYkHuYzOVxB?=
 =?us-ascii?Q?yjySApMlvNxsPJ7shMH7piDqx8DIYIHs9+ToMPqQVo9Qhp4xP1IKK6BT6HsA?=
 =?us-ascii?Q?DND4DBiLmJI8+rYugZWh96SKP0o8SKHA9i6Y2WHonZV/x7iS+KlVqWVurkKn?=
 =?us-ascii?Q?XC/72X/kCKoFfaXJlAFt9Bi3c4qRnOwFnggvLpUm4V56y91GTbqb546838kF?=
 =?us-ascii?Q?shnvd7BWknUz4dwbJIdd83ux4btRr/evZ/oNQ0qwTinFzEyJEK8oY0rIodQ3?=
 =?us-ascii?Q?a2QSWT7KRDrbh7Iv3Sv1c8/TBYPfH+5gkfNmUiMOUUMXanrk+U+Mk+AiaVMD?=
 =?us-ascii?Q?7ZyGrBqIkRxtUWAUMB6C2P7h1Fi+CawrLVl5vhQY7hDL9izCfuKKMPUry4q3?=
 =?us-ascii?Q?S5PPZkehNO2od1PddWEFRoQgC5F+6joqlGnb2Byq+0Og7D4r4tKABEsWElvM?=
 =?us-ascii?Q?h7gBlwfzb+ErGss0Wy6g5PYKHw8LwFRHAeHeUiCbQBppYVw/RAiXpg3SPu39?=
 =?us-ascii?Q?ASSA7uMcFR4LicHsIMFqihjHqxuNfH04y19uW4zkZQD+3S8EA7VdIg18busr?=
 =?us-ascii?Q?cEKCNQUhSyv+v6whNxroN+lkKMPFpzrV++7+m2rQpiQitcNkC8R9JNrQOXzv?=
 =?us-ascii?Q?HoO7if5rQL4E+RFV6cxUclJAGJBTMOqEMlOP3hXJAtmI8rZJHISvx0FgWf/p?=
 =?us-ascii?Q?WJYH15eIbJ+enfONaqyqlhxm27vlOap+qBWDWjTjgI93BbgemtA5I5ZNFkpI?=
 =?us-ascii?Q?bDjJshSmxm0I37EYvS5TG99Qh/+X884H52iIWLYSgYDBTlCT4fx+Qbb+VLEH?=
 =?us-ascii?Q?Mgyk50oSi9wtKGrQh/OO1ENlEt4ACJVmMuFmdb4p11fSUMqbT+2xLkA1Fho1?=
 =?us-ascii?Q?7f+wcl+GCjW/hh7vNXFJM9kYJgs5+8FLxaenL/MeGCCYbZewsMVhkYbykHtp?=
 =?us-ascii?Q?fMipdlTFDfoVg0VXJs5YfHxvtTn9je70FZW4i1iiuhPrfPgI4XY6QBhjKZkH?=
 =?us-ascii?Q?wtY0Z5e1LQEiGvjIZTbNwKEUh/i5wlOc5Nlb/b9mwy4sLnZ13wWrq9MeN1lX?=
 =?us-ascii?Q?rgstjtOEwQGze/09IL6fP4RBBjEUtS2bE94AZOUQCyq9zRzNk8OgONKZj9sL?=
 =?us-ascii?Q?i+4KvPTV6LX4Zc4mqfdLJLax9yZKDqFPcN+M6fJP1+z2H4cVeDhIJPjt5BxH?=
 =?us-ascii?Q?g4+D4U18mk27g6QhbKL7sbXpUeOZHldqXkjiIp3d8QPDYTgfMw0/2T12bFtM?=
 =?us-ascii?Q?4r67WVR2vu+kzvGyeu2sPsfdXv25vrz0E92iT+XAHRZKx2kkxu22zOir1xTp?=
 =?us-ascii?Q?RK257fwhHrHn3zeaOavpTV9pyEcasAbk095URg2ffA9B6USI3CtDTNdbtUWJ?=
 =?us-ascii?Q?iIdS7yWH7bksbte74L9v834D+wkp6vd5tZtKpDlprAbLTJY2wulhDVKRhyV7?=
 =?us-ascii?Q?r8dLKcl7lvHHe2yZvUo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 12:58:12.1574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0dfa9d-c078-4aea-d2ae-08de1ba1cfc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826
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

The EFI System Resource Table (ESRT) is updated after the firmware
image GUID is copied to the fw_images structure. This ensures that
the ESRT accurately reflects the current firmware resources.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/xilinx/common/board.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 26facb6daea..ab50a795e6b 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -766,6 +766,17 @@ int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
 	/* Copy image type GUID */
 	memcpy(&fw_images[0].image_type_id, &img_entry->image_type_guid, 16);
 
+	if (IS_ENABLED(CONFIG_EFI_ESRT)) {
+		efi_status_t ret;
+
+		/* Rebuild the ESRT to reflect any updated FW images. */
+		ret = efi_esrt_populate();
+		if (ret != EFI_SUCCESS) {
+			log_warning("ESRT update failed\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.25.1

