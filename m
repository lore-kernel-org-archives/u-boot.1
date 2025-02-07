Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC42C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 06:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE71801DE;
	Fri,  7 Feb 2025 07:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cDfI8qy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B4D80207; Fri,  7 Feb 2025 07:43:40 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2812801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 07:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSx07uTeGbFHqgqdvyPLJA7QVGNBLj9Ra72ZbEVnhgVnu3tIIG9Hdvf+WwGJ9wsdv+EAUPHRMrQ1FtgIYa3wcAdNxFzXY/+Si1bHjZhlQmhaCgQfLB5VmKnqQFEDu3QrGAzJmlAgARErEhdI9/obrGesE3MAzlxjB7DlGZnpGohpXPr/PSp4llC9GYMQiGhIVYeNKyyefwwAExPyoMoNoxSK/phOQmnrDCWZkfa5dfxU39rDioW5RdTOpRKWPATGZ7KZBNdZtp8i8DwaPxxTvOoFKil+3F1swG94d8Vls1U2dJmXFjXLfKDBgOzZiYRvYOpiYQoGhrQxrkCHHWJuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Tf2vbU5Ot/UQ5mzSvHFeIFVv1ZXKnxvv1nlKtqioK0=;
 b=baPekLQX5XNkVPuWlchkVS1t5Bf+AS+YrQNjQ5+3lvzlBkkry1FkFoGVp+Ix79wDRJVhzYBmjoWADI1L3s+XlnBm9NZbi0oloz8pkX/nStx/5dfgg39JQxEd3dIppmIrCTLfeDHsrR0do2skizuff/Yafr4miLAv3c1USIx4uAfPNKoQJpZcVEljx35lQH+ZXWZovU4Mu9TpsPvb+C6tLQielxJhJdUZtjFhDxVcRjFD4fyEJK2KagvKdX2DspizjhbPViqy/BRY5Y7wKvZG/JdfmFocJoh6h5W9zOwNPdtXdosH1UL3G8OrlmgawmrhtDxbEyOvxrMgraVQHFSYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Tf2vbU5Ot/UQ5mzSvHFeIFVv1ZXKnxvv1nlKtqioK0=;
 b=cDfI8qy+Xm+Z7bFxz8QGxN8iboioaXbeyVgzKjA3PSMrWgh1mr78zZdfPS78AJmVGEo5tocB4KqtGH8xRmerOdlgmWHuEmewT02Tql/9yBm5E0bJl8L8HOJEX5TdMXs6GeZRuFR+cXoN/Slvm5UtlZgnijVCbVzBlEfwUeKVsoI=
Received: from MW4PR04CA0208.namprd04.prod.outlook.com (2603:10b6:303:86::33)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 06:43:34 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::c3) by MW4PR04CA0208.outlook.office365.com
 (2603:10b6:303:86::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Fri,
 7 Feb 2025 06:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 06:43:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 00:43:30 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: zynq: Guard code around SPL_FS_LOAD_PAYLOAD_NAME
Date: Fri, 7 Feb 2025 07:43:23 +0100
Message-ID: <f15a9762494945814b06a71db90ee4db59dd17ed.1738910601.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=13x6prEQbUFMpYhaDFC5JxkIVgmp/g3tzjJfUGAZbcU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSlq7tjg2+qWvS7iLnGrEtuuey1bdfJ+NCAOwdmODp4y
 Lns927tiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABP5PJVhnrqu3Ndz8069rCzo
 mhT1LWPz7vv/lzHMM026uPf+uz7l0sppD0Q8Jj9m3Vi6GwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: e82b8920-9005-45d6-ad32-08dd4742be57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lY978WrMco4CKdfuTKKMmhk51oIsF3do06mPcJ4IJTc5tAtEilPkgCRixq1h?=
 =?us-ascii?Q?HCIJI+R48lxvSR3NiHwp7/ek6KihOqOuvSRD9tImbglZp+zl55MOFycChJ2x?=
 =?us-ascii?Q?2vlR+j3U7kknDVCJu7Y4fxBvF/EYkGIgxsn/eW1NO6PCy3Icv4rOtEBFkigz?=
 =?us-ascii?Q?1xHcbEFkGnqXUi8fhjMwYj+kD9eSycdwgPvNWF1JABKPqFjRFJJWdrdd+kd1?=
 =?us-ascii?Q?Wom8DctDHK25hk97GUxtXfX4ZhF+6vht+p6zLoFXaslmNkM4tBvTaQ3PzV98?=
 =?us-ascii?Q?Y5Rr4N0wQ2Fv/bgC0Cp3K/MZ9fBTgfRUclPq4XXxkERBfqdsLtA+YJG/DmIV?=
 =?us-ascii?Q?0jXoYq/U4E9Y0HCkaTArVHvIOXZk/mxlj+U4RQgD/v/Mhtj7uPqIwDzcNg5Z?=
 =?us-ascii?Q?octOoR8PVC/7pecuAub59Hobj7D7YKLX2y3hQctNtzHRRNWE0NpZA9X5uM3D?=
 =?us-ascii?Q?9HnE45O+84s0D8BChbp+PUMziS2rD9kJJ2SK6ETSAqMJp6oahGL4zXKAkeXr?=
 =?us-ascii?Q?hdUohKmvclfMYQ5DtTJMbDaUjSpG1Y78Xa4hSs9dXEayh2iz/IF50wrOp33E?=
 =?us-ascii?Q?yVOaK9dWuzL1uAonOjdFxctwQcsL2KL6DxvLUYIuCMzNM9y+y+ovxSzc633F?=
 =?us-ascii?Q?bgbqEOz+sMRZGNyiLKNqM01uVQTwEFzHFbEfuxnb7IOLdpFy6FNlziSMZkUh?=
 =?us-ascii?Q?isRtSd4D9sLyCcl6Wo2IK9nGVYzYd/lzGeucXLJHUBE9P2YtEeFndj1zQ8nH?=
 =?us-ascii?Q?eYhUndlvZ31ZWAMlve9HJTNZ8fvqoI0Da+qo3W2BAvv1rZn48v9cexJ6zgml?=
 =?us-ascii?Q?Kw23/hK2YDUll4X92inYbzNBI4asvtbR+aczRnsFzzdX4v6Woc4y6qlMFPXa?=
 =?us-ascii?Q?b+4ALd3L3zL9jToytj7hNfaAOkTkKFjTUOlgnkn8Pef0o8zSbt0UTD6Xijed?=
 =?us-ascii?Q?Nbd4PHDKXgt7r1qGTyfS1bvfCb3xvv9eyR9nN07vU7a5ABF0AQHrsAzxtnAh?=
 =?us-ascii?Q?8ElhbrtRiqeeRZ0DNOgjbhQeZ+vtyumGRLge3ZKPdWkXo1c2Sl5cC2iD2DE2?=
 =?us-ascii?Q?9DdPmYhcxRWk/iZlgxveZ6CEbu5lm09+p9WhnZKlBBP7deIlmEyrm+r2ieaK?=
 =?us-ascii?Q?G/CKv57lBTTrvcyWN+q0gbOpDYsh7ytMXvT/5k5vA1ZaJo+U2xGcnDtM8NkE?=
 =?us-ascii?Q?T8admN4sM6sZ+LZvtZvEhmQrmP21GsqBz/lmZKM8ZOvXmW+Bfd93AOaRdfj9?=
 =?us-ascii?Q?0TBIBYJZnBYsDV/eY1eaVwFEowTMagLjzrqoeYyWU5etTq0WaHfp8jk7SpgC?=
 =?us-ascii?Q?cIc8QTpl8JHgF/UJr78tLSMbS1FV7/u70BgDPNB7qm+6nv/bkJ83j2HO9LS0?=
 =?us-ascii?Q?bmZMVjzmCkZsejPzQE0HmLKJJAlwV6vPdzRR4WCKQxBpwvKUEMdV55rtxLg0?=
 =?us-ascii?Q?7cX22VbABb6chVjfS7KJC5IrB0i5loiegsvpn+FrZA2jvK24d23XV0lYvVmF?=
 =?us-ascii?Q?1/uo5riQWY4JDjY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 06:43:34.1746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82b8920-9005-45d6-ad32-08dd4742be57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171
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

Guard code around CONFIG_SPL_FS_LOAD_PAYLOAD_NAME usage to avoid
compilation failure.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynq/board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index a852d5b8ed53..8dbfa5604231 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -179,6 +179,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 	memset(buf, 0, sizeof(buf));
 
 	switch ((zynq_slcr_get_boot_mode()) & ZYNQ_BM_MASK) {
+#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
 	case ZYNQ_BM_SD:
 		snprintf(buf, DFU_ALT_BUF_LEN,
 			 "mmc 0=boot.bin fat 0 1;"
@@ -192,6 +193,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 			 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
 			 CONFIG_SYS_SPI_U_BOOT_OFFS);
 		break;
+#endif
 #endif
 	default:
 		return;
-- 
2.43.0

