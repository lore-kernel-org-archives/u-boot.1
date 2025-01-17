Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49446C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D53807C4;
	Fri, 17 Jan 2025 15:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mmYgRbvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B716806FB; Fri, 17 Jan 2025 10:28:27 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8394C8069D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccNRZ7zWy58fV7SmkADXC93etskwi2tmqqBv8vmaODKbb0zcTG8fi7cDbx3BZ1q6W3yD7L/FDu1hbyEJX1RrBdDHa6t4UgB11QmYwwhkV9LyKU4DC3JukT33dc+y6bqhEx5pItYguJdxZ2f5G+sRVimgpVpUOA5966cbIx+DHZY4Nr4DsI6acsP/rfi/2st/6lBUAuCdynS9o3QqmBU21VDA12pwZE7y5GP8XteV5PEXm9oLYjuqAnPQtPX7HrosLL/S0s28OiDn17jEOdKpVpnXh448MFXjY03p2K+h/KRIHzV3cVDoZjI+X6eLg4bK84ZoJxYlX84ntkaKYqN5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlPU55dq30tRmF+VsdyV48mo8LrQrl8T05nUN1/oOG4=;
 b=K11G1fcY2wu3Bw3ipsJXrcjRzlgfQQUBjjcpYAxe5wZUf6b4QCvhEbkF4jyK2v/ZWaR//s8f6xhVEtN2IRDxyVn7El/+pWsjaYk41YiEyMtdw0ECPhmR9xZlJMIsUr4uvKU4aqz4qWski7ljDqnhwGBIfvPyarFaV78R2xES8l8hCUae3l54wGoGzIfu7/5Y9dWWv9FccLS1cSQ5UOjKjS+xkR+OZrS7nGtb4Cs+nTUoC+SLfZig0MBkLS/JeQnvP/qq2lZqMDmcM0MUTPwatfoa9NgjQbre6NgXRGd4L6xNLpNDICl3QepDM5fzia8FT8QdJxAqClIEe+2XCD9VDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlPU55dq30tRmF+VsdyV48mo8LrQrl8T05nUN1/oOG4=;
 b=mmYgRbvCZVxc0CIUqIStwAZQlwBBhcHGmFd9Gp5v4G+gF78ritHa25MFu5Ek87+DeQEAOoLtuML0GoK3Se3rOvvNoXBMKnuMYhW46qphFLq//yThrkHDA+N5wsBnEWEGGVa/sttsbn4mZ6T4rfDTcRARWbdIxTaGQQecgQ2rJ3M=
Received: from SN4PR0501CA0111.namprd05.prod.outlook.com
 (2603:10b6:803:42::28) by DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 09:28:20 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::d4) by SN4PR0501CA0111.outlook.office365.com
 (2603:10b6:803:42::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Fri,
 17 Jan 2025 09:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 09:28:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 03:28:19 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 17 Jan 2025 03:28:18 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v2 0/3]   Improve fpga cmd usage information
Date: Fri, 17 Jan 2025 09:28:01 +0000
Message-ID: <20250117092815.2986832-1-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e68541-75b6-49b5-88d6-08dd36d947f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UpTDZ4oXSckCUg1OXZNof3JJ2Ev6iQcNCPT3CWECFYdjoox01GsX9XX3TaKT?=
 =?us-ascii?Q?UWdOoDhLWpASjkhOn4KpW1IVH2T7K610ciifDN6+MPuiYFgorc+D74kh+tGW?=
 =?us-ascii?Q?/mWiYXcZcPgGZnvl/EkGmEQQrKNCqWavxQWb2NhNPeF+eX0m/RO+F0UcgBqC?=
 =?us-ascii?Q?fBMary85UfZokxoqpfI+AmC+GJxLxHAmL7UldND8HCbm1PzT4yzOyfaW/QHb?=
 =?us-ascii?Q?96Pl+vP/SIiOynDjKNUOzbBIBz7CjO1T8JkEZ9ASHoAiFu8fdRFVzyuiisk6?=
 =?us-ascii?Q?NpNtx0/sb8og7+ClgFi5H/hcuThjNonGWbt+KFlwXn5vh8D5kZxQQs1TBoA4?=
 =?us-ascii?Q?xOmAR9xZuTcivGXTNQOhuctXG3T4Jtk7AVKnCpwJ4oinT3Ox4JNuOt7oWsC6?=
 =?us-ascii?Q?z2TIB3jDaTqPiHFVFeFTYyxsolh8LLHtJoiE0jy7g9+RLN6Lxiv9gbGTTwa3?=
 =?us-ascii?Q?SHHlapd/fOQ/RBLJa13NHd87ppoFurcwIBHi8uc6SQodDNQDBAKxXWets7kU?=
 =?us-ascii?Q?wWY7oYkyE0kfaHY6VgCF1oDnZBMfFqPwFjzMkvYelCEuj7oGRh5n8sxFhQHy?=
 =?us-ascii?Q?7kaOKXiZGV8Sv3PRgWw9ezZq7Sl45ECPsWlZPq6IWxqh+CQ34wehqqykxN+t?=
 =?us-ascii?Q?2d+aqB6TcZiNYIfzya5PLSgFaRaodstgkhskgdnU1Pm7k0QVosj07QuKlZCm?=
 =?us-ascii?Q?JMEQXNQ82vZ8b2lWmcVhphKXZFxlEuuirNWmmXS7BIgjgx9Cg91RDvu9apuA?=
 =?us-ascii?Q?k1alwnSldtTz+ItfKKObUj9cULrE+dixmyeOfPS5cyxRh/vKqXMwrijk1I9G?=
 =?us-ascii?Q?kjt5nn1fREcsUf4N4M5O+yLGQPyo3hop3ltec1H1haY5cIxyGhqMHdvaG6PA?=
 =?us-ascii?Q?TK9t+gX6SuEiF1DRbANNkeiqJp8JN2PkOhmXlP7fU1aE06jEW7O2K31dDWnu?=
 =?us-ascii?Q?7h+m+cyzUnIDhEMcd2Ra6tooMcgKz6HkjrS68xnv/Tr21/i24gmzK2X9+z/5?=
 =?us-ascii?Q?IcL9iWMONvfcJ+pX7Y1bO4ommuGhmGXOW3GJbxJmIcOkQO3lVsN+M535wHhu?=
 =?us-ascii?Q?qJATc5ztvO9vlJW1Pmp/ky4g7JsPrgSzn9CbaGlhhPw9tw72GtoSpJAABfAi?=
 =?us-ascii?Q?kC/G6keNx7/fJ1bNFVZGgeFgnhGMxxYPmQIeJjhuxilictBR8h2kqZXLZZeR?=
 =?us-ascii?Q?c2TJODIMZIXW3nFzSq639P9YCHKjMjTzCpuK+bCqKlmpIlXokST2EYhhsspI?=
 =?us-ascii?Q?uiqtynnH5vdiXnkk/dTGw9VaRBwYVZtlBZ6ZMbYH9T69Z/3Td4ultul8yNsi?=
 =?us-ascii?Q?SGG0fNkCA31qb4vvF2frWhf5Jj54hSo53sqHX7Cf88+gaykdShMmYkmSVNli?=
 =?us-ascii?Q?1dTq5nK2pH2B1oK2mIqNasipBtVDPcjKn0IFq5EFDXix77IDkQKoxSuwZBsj?=
 =?us-ascii?Q?7AFakWObOTLRUm4DsEg4GxxR5TwJRd5/WUEn+I3coWRf54oga8ZagmDIjM4s?=
 =?us-ascii?Q?zYrJgTy6NgSOv9Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 09:28:19.8905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e68541-75b6-49b5-88d6-08dd36d947f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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

Changes in v2:
- Tabs replaced by spaces
- fpga command added on each option similar to other commands like sf
- Dependencies to Xilinx only commands added in Kconfig

Ibai Erkiaga (3):
  fpga: fix alignment on fpga cmd usage info
  fpga: improve loads usage information
  fpga: xilinx exclusive commands info

 cmd/Kconfig | 32 +++++++++++++++++++------------
 cmd/fpga.c  | 55 +++++++++++++++++++++--------------------------------
 2 files changed, 42 insertions(+), 45 deletions(-)

-- 
2.42.0.325.g3a06386e31

