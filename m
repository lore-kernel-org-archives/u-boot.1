Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D333C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0240807F9;
	Fri, 17 Jan 2025 15:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wNbK9Ot3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4E2B80748; Fri, 17 Jan 2025 12:26:08 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B9A280312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 12:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/jR43TDsTTNkUn/B2DqPT1xwFD4Uatv56aowivowc7v13l4uz65q0nu5bIgI80MoXiXNazL1xbMkRAReQ2RiGvCwHEWOGfdS4RZlt9yio1OwmYwp+A+bdoEJdgG/+vHyGoDf7fn5EiB3lDMX2C3/Dr/WK5BVvtbcjHTmEyyR6QEw5q28D1UrcXh05EWReqOdZmzi4lYakHWCtAi5EqO51b8sMjkx1AGMvfv+TKwD1N2t0+BdpRv0pNR3Pkamt6D93j5+M9PehdlcFVXR5GeC1b/V6jBZF3+ld4KyLNAmEinz4tlysT+wfCju+af9A29nfo4j6wvjRWopb3RlXytgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+rulP1jXW1jI5YiQxeiHJPdNVw2IFac710ae23mufU=;
 b=iW9AW2FxqhhTnclhB53UW9mUWILHV+P6CMz1CufOk9FTrC7VYQnGQuQeaDvfziqRfkYeiLhLcaU4ymb/Q53zTCZEBVbZu5SlhjX+D1oe4601kyWHA+AJKBGERR++EIHwf77bagrrXqb4Qi9kXSC+zetGD69M/S+ff9QOPbBfv1D8ZOjzsgff2k/AXu9BXruKZpihdRMZScB5BOX8KDMRzMw4FRVoFogeiGp9mqaU+4tMTGPMTi4Ng1o8QWkNe1ksNT8+NJrWb0fH9nmPOWlcatUYtw6qj1aR16ICebpOnb0f0jkdr9yXRFli1S4rrbX9D4ai/NmsdfelSMiR5wK9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+rulP1jXW1jI5YiQxeiHJPdNVw2IFac710ae23mufU=;
 b=wNbK9Ot3Szlip8jKbxJ+CrG7ais4iCYChOtFd1FDo63Ez0cz3pyv1MuiOWHV6oQv+SI2rjIFhkShPE9JG3IV2ojttoEdMgl/p+Ovf3iZfVAXkxcrIlf7jYtAReqtOD/Y9iWkMIxzlcXR4L1Kxbchz/Ml1bR2Mvhud1nk/rhbD7M=
Received: from PH7PR03CA0007.namprd03.prod.outlook.com (2603:10b6:510:339::9)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 11:26:01 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::72) by PH7PR03CA0007.outlook.office365.com
 (2603:10b6:510:339::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Fri,
 17 Jan 2025 11:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 11:26:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 05:25:59 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 17 Jan 2025 05:25:58 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v3 0/4]   Improve fpga cmd usage information
Date: Fri, 17 Jan 2025 11:25:47 +0000
Message-ID: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b2efa4-51b4-43bc-c831-08dd36e9b852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oTpqnQmHdsQdO8HV4pSXjVHk6ivwHRgyprIICd08/YVR2NqaoK1GieiNW3PC?=
 =?us-ascii?Q?0sjQVDblE3tSCUZFUbtL1qGZJ/sZa4HhSbHADwgC3Z6H25EO8cmQtK+L/9KA?=
 =?us-ascii?Q?i4sMZnYl+VAix4kY+KJRb+edFg3xFMnvv43EYWJ0w6ABdNrGbYRnxxofQVUm?=
 =?us-ascii?Q?FPg8NwwqURXuH7nKbD1x9bNBWZZk/p1NhUxAeov7TCAP5iQMPrtQ8BNZVn16?=
 =?us-ascii?Q?RXp1VR+LLFUo9R9Tyo0fAaO6W51sDHmJ6FWhWsXnpErJDNF/XzTLzwtHdFLQ?=
 =?us-ascii?Q?q333q21PrI6Cs7N+XzkD3sx5M/J3w2Hx5w8k546mE60O7DX1phmuPnyPMcam?=
 =?us-ascii?Q?JHegUlJtHEBgpglb8XBQ5wPQ2bA185byjHvR1g2urcC8BpX0EAMoTreRMcZN?=
 =?us-ascii?Q?eOATqoqkaIHY9uErVSR0ifY4C072Y8r+3xI2E1Dx4A/VyBYeYW3G+SMowsrZ?=
 =?us-ascii?Q?QDksbEEZZGJysU9KcQOyHpPOaz805+XJn70UvwpcmaH99OVQNjTTKmZjNz1t?=
 =?us-ascii?Q?5GKDbz3VaO7qGfcJBX2BQrUX6Jh/Av4oy0ba1gYt2GqMd4j84XbipauJOyJP?=
 =?us-ascii?Q?qil/IVapgblZnhPbg7eY3sj6+ymc9x4KRTkMiMxrRTS9ErSVXY8DiHDPu+uA?=
 =?us-ascii?Q?NPD+y4g++3DT9En1d0UZhaRwZK8k2jJr5rE2oWwJT3Dh13rDiACeAsCWxr7l?=
 =?us-ascii?Q?0juXYcxEqCG7hAtfiugCUVlhsR+FqFF22n81NSDe8vKgMq1nGkKBXeOmKe0W?=
 =?us-ascii?Q?SrJQVfX/Ipx7qzi9XB373CDXm2kMtcEBtygsms9Utv7t9U8Yxzm9XvN1haKk?=
 =?us-ascii?Q?P8JN+rXEvKBC00+uPxTN/Pmfm+PH5VBSiPvicOOiCc4TXrwhYw2jfcYqmOuh?=
 =?us-ascii?Q?zkAA4XUPToh/mmbo+G/T2UW/dAsbQ7dGXBSxZyse2KeS6CJbWw1qw/tBi4yZ?=
 =?us-ascii?Q?1tpa0sy1d1pDDyCNhgiuu6w+bp2tvhhTYatTaB/BES2+urC+Cre6XzqcNFgR?=
 =?us-ascii?Q?F5QIUpq+w8H/2jMLnU4LAE9ATgje1yc9Pf1zwdBJQ55vZiChL3aRS6z2/Tzy?=
 =?us-ascii?Q?TJVJeTrZTN5TIv+L6mTHYyWtoQxAZ1DHpTuzxkCXoI6tfo+BtZZIQxn4EUSn?=
 =?us-ascii?Q?Duw9ZExYStb+pT3pq7zaijPNIlZB9KReCR2/Hn4wQeOYCXXVrjAMkCFplMnc?=
 =?us-ascii?Q?ca6wTkRYIiCxjBX6N51OKHKKanGKTfOQeOoX0GwpGs3gH0eStGaLvmISGSvy?=
 =?us-ascii?Q?uYGE0mIbOrmdn3xnqPkUeFEet2eE3gZ0BZD+3qqVvLJ2BWlnPyA45C59CKVH?=
 =?us-ascii?Q?b+d2UKzdeNUTy7hjRrsXhLt2l+8TFrOGOaDIjJD83kaGFuwZYchIDfg+uZ+b?=
 =?us-ascii?Q?Z6syZvcMAZ3eESJ/8kIzU9EWOA80zemMYxK+syRXFtZY9oVjiechO3OMrkeD?=
 =?us-ascii?Q?reo1nJbB5TMqeiBpMEPOQWO5qoOh2wc1e20dzHqmV/dLuYt1lLrv+t93FUni?=
 =?us-ascii?Q?mwBgAMYa+nWl/x8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 11:26:00.2472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b2efa4-51b4-43bc-c831-08dd36e9b852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:41 +0100
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


  Current usage information is not read friendly specially when all the
  options are selected. This series fix some of the issues in the info,
  aligment and overlapping issues, excess of verbosity on the loads...

  Additionally Xilinx exclusive command dependencies are included to
  remove text stating Xilinx Only

  The output looks like this now:

  fpga - loadable FPGA image support

  Usage:
  fpga info   [dev]                  List known device information
  fpga dump   <dev> <address> <size> Load device to memory buffer
  fpga load   <dev> <address> <size> Load device from memory buffer
  fpga loadb  <dev> <address> <size> Load device from bitstream buffer
  fpga loadp  <dev> <address> <size> Load device from memory buffer
              with partial bitstream
  fpga loadbp <dev> <address> <size> Load device from bitstream buffer
               with partial bitstream
  fpga loadfs <dev> <address> <size> <blocksize> <interface> [<dev[:part]>] <filename>
              Load device from filesystem (FAT by default)
  fpga loadmk <dev> <address>        Load device generated with mkimage
              NOTE: loadmk operating on FIT must include subimage unit
              name in the form of addr:<subimg_uname>
  fpga loads  <dev> <address> <size> <authflag> <encflag> [Userkey address]
              Load device from memory buffer with secure bistream
              (authenticated/encrypted/both)
              -authflag: 0 for OCM, 1 for DDR, 2 for no authentication
              (specifies where to perform authentication)
              -encflag: 0 for device key, 1 for user key, 2 for no encryption
              -Userkey address: address where user key is stored
              NOTE: secure bitstream has to be created using Xilinx bootgen tool

Changes in v3:
- Split 3rd patch into two, resorting commands and Kconfig changes

Changes in v2:
- Tabs replaced by spaces
- fpga command added on each option similar to other commands like sf
- Dependencies to Xilinx only commands added in Kconfig

Ibai Erkiaga (4):
  fpga: fix alignment on fpga cmd usage info
  fpga: improve loads usage information
  fpga: resort fpga commands
  fpga: xilinx exclusive commands

 cmd/Kconfig | 30 +++++++++++++++++-----------
 cmd/fpga.c  | 57 ++++++++++++++++++++++-------------------------------
 2 files changed, 42 insertions(+), 45 deletions(-)

-- 
2.42.0.325.g3a06386e31

