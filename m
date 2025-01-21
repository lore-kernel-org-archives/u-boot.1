Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19537C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4483280792;
	Tue, 21 Jan 2025 14:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wbv2nN6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E5F80780; Tue, 21 Jan 2025 14:01:52 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72643801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKktvX1oP9VeQQKnbqRlTQ2U/yfGhHOxHwGUW2NsB5hJku6KWyTnsCD59Tep4IBZwtCtXHE+L3T7PJ4oy0hqZrtUqS6GQ25TiimD8o1IzqPvKMII3qoHQP8exKGUaDxfSSv7aNMUzUj3liMiR8mxHMNmVCB8iRQRM5MdrmTg2zj1HZhbTNrc6fisH49h5FUeD+hQPaA5QfByHIHwHCJeDqIvq3Gh/3AAaVIv9vxyuU/iyBUkns6mp3iI/Hd8aDzJyhabP2dj0paqRzE1XPC3Usp2HoPbQvYciWgM+MYcXbxx+Zws/DoWIhgpy37Kuh1S206/yTYzlr2QQ0ilvOcpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EenKT2Y/p87sUlnsSCI7QViEBl9WSxKo4DFpazQDy4=;
 b=W82nd5OnDnwUaQvOzxnmEoJ8v3QwF+45ZzgfhIvxlnO34A1MXidhOpfnwtdHRhz50delC7amGhCzc5jgkpJBrY34A9Nf7nxR+RfwOzT8QMfgFSJHDvIrDfwfMXMVhzBtkMy5Awy+PGU4l3Nryp3Nfd+MD+z6x/XwhepjsQSjxi5hcaASThbRkG2emGFcEd/p7eeFLW0QAUI/GMVF8RFkAmcFeZqX7HYUeiz34nUTx6pB2iJf8MSxHyzMUJZ3UfGt588uHgb+Rt0iYhqKugr4BUAwMh4KM05FpBavSspxzfUBYnRdjv0R+Gw4p4Qu+JYcJSBMRgYh2kCnZqepp6pP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EenKT2Y/p87sUlnsSCI7QViEBl9WSxKo4DFpazQDy4=;
 b=Wbv2nN6y3bDxDmqluAG6yzYmgnge98Myt7RZAkKiXgNn3qtd34rWjH6VsPE9kr+2OqLhS+lngVDEuQL5ADNuh0Q9TMj/Px3a91Ou6Dpb5e/tJ14rG/ykxevd9wX8Sm9ODU+0vpeynNEfwIK87tHCSTfpL0Ckbd3tpSg7pILuiz0=
Received: from PH8PR02CA0043.namprd02.prod.outlook.com (2603:10b6:510:2da::12)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 13:01:45 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::50) by PH8PR02CA0043.outlook.office365.com
 (2603:10b6:510:2da::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Tue,
 21 Jan 2025 13:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 13:01:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 07:01:41 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 21 Jan 2025 07:01:40 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, <ada@thorsis.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v5 0/5]   Improve fpga cmd usage information
Date: Tue, 21 Jan 2025 13:01:29 +0000
Message-ID: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: a4efe168-1e7b-4171-2843-08dd3a1bc21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IRN2Z4GSN1uKjf0QrK9DZclMc2h9QJGmaWEpqMSIu4Vrv0nhC4S0c2pFlYHM?=
 =?us-ascii?Q?onJm8tqzBX7MobwB5c8hyrbZF+bkDXa67MTVjjVb/DGqUKFj6celKUONMBys?=
 =?us-ascii?Q?5SRQFjaXxZ4Pii90GGHmpT76S6fRzcslxtd0saOFFTvR74igY8XdozLSFXmJ?=
 =?us-ascii?Q?M4vbHvuFrqzuw/h1gDul83Z9xPVFmsgFiZ+nurfcea37EZmmERCydRqDK2DA?=
 =?us-ascii?Q?9XLpD442oz4TBLBOJ6fjscM7Zz8LrLls+86N7vR7tsdLCQLktaugQcqBpSW4?=
 =?us-ascii?Q?ajKrISM+oCSVWYX5c6Xyro8GqERQFv6Zz0xwdXagP9z9Dl4sBQDH/SZymPmJ?=
 =?us-ascii?Q?Ycbe+glQ7z1EZnn4Tgo2FVUxudxHhmuIJ3461AMSDdPSQY0fkTA3lN+kwHkx?=
 =?us-ascii?Q?amW14+ZOcLbUgTTLJAnTrKp7YS6DKYPmCJ15X0ztVqzc9lIHUx3XpcIhnDcO?=
 =?us-ascii?Q?qoOxxyHqtxNATb5I7W+Ko4x37dheTvaamHzKiT3jqGfJffvzY2M6U7vuPuKl?=
 =?us-ascii?Q?5mggVCYnQYCBNRdaoCV9V0w/0UBRbtq7ZFNREzcgUk7jRNVmeZ87f62Gzo8F?=
 =?us-ascii?Q?2F8h8KEMhAnVS8PK3bdDHbRiwhodsP56AiGxp5nQqfI1zLTlLbyf7c0u57i2?=
 =?us-ascii?Q?439LS8h52C6Zf7I7Z5zLT6sP0VX+FYo4ZGTj6MpbTFzdrjifvhhMj+TSxXYW?=
 =?us-ascii?Q?DZuyxDYb5Ie4srmkS2SRAbg8rruSKLF1VtT9rp1M2HGsgwsq6+zt398qhIzL?=
 =?us-ascii?Q?XVUvXrRee07r0kSKHzb9cQo3llY8STW24Z/8Lj+9IWmk7IsaIF7IlHxb2YwD?=
 =?us-ascii?Q?y7zwoi8CGWY1Dd0NPwNodZDu9N4c5+Q+F980tFcKrMUIf6zxqkjNkhiPGPqi?=
 =?us-ascii?Q?/teyqVtM4xhhiRu2XoY6+9vwr9ItgZnyev1oCJK0ub/tsE49JeuI4Fe9yBIK?=
 =?us-ascii?Q?AC9+/TAsqUhAC5CYTLf5BjZFD+n/Iyvq2DmEBQI5Ba0c4C+HyGPBiq5lDaUI?=
 =?us-ascii?Q?x5rvBhrxNUXFor9FTenu7Q6yDlmd28SiBDVvO7xYE+NoE/N398LZkEcnMyu1?=
 =?us-ascii?Q?qNzF67ofIBBx1lil4UmB9v5X2MDaUZpB06npjt19OEdTvNj+Sz9f0hoev32X?=
 =?us-ascii?Q?0M60DSjBfMkFeOx6LcAMlWckfHo0f+4VqUaxwFEjDFtA3f92kgupppcSB14k?=
 =?us-ascii?Q?EMUr3UErERuC6VSE6izzpk7KgST3SiRBw0/cwNslW4Y0cX/FvHEaEKsg8Ib7?=
 =?us-ascii?Q?9/fk2oPfujRUe/gqR3WcqsIqeWTahVNpEJ2NqS37bPvtzfQuISKxjfGeU8t+?=
 =?us-ascii?Q?56f/T4uZWhTxRKhwY79G1Dn7umawOuaeQj6NyGfgmgjfKDVyLb3sxB6phgHp?=
 =?us-ascii?Q?LLsGScwuKjOdGL8Ib1MlB+1iiU2WBSq8WwPsJ0C2Jd9hOTrNyVUvrd/BvOaX?=
 =?us-ascii?Q?44ZO4w2cBQjvsSt/vAk9FOvpOtQVfCpNqVgrLFjbAToCkDIobEP6UT1jzsD+?=
 =?us-ascii?Q?5hZUsGU0RtxKt1A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:01:45.1047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4efe168-1e7b-4171-2843-08dd3a1bc21f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

Changes in v5:
- Reorder KConfig to ensure commands are listed in the same order as the
code.
- Clarify the bitstream file type for load/loadb/loadp/loadbp commands

Changes in v4:
- Split 4th patch into two, one for existing symbol dependencies and one
for the new symbol

Changes in v3:
- Split 3rd patch into two, resorting commands and Kconfig changes

Changes in v2:
- Tabs replaced by spaces
- fpga command added on each option similar to other commands like sf
- Dependencies to Xilinx only commands added in Kconfig

Ibai Erkiaga (5):
  fpga: fix alignment on fpga cmd usage info
  fpga: improve loads usage information
  fpga: resort fpga commands
  fpga: xilinx exclusive commands
  fpga: add new symbol for fpga_loadb

 cmd/Kconfig | 35 ++++++++++++++++++------------
 cmd/fpga.c  | 62 ++++++++++++++++++++++++-----------------------------
 2 files changed, 49 insertions(+), 48 deletions(-)

-- 
2.42.0.325.g3a06386e31

