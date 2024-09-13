Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B09FA3736
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B8788901;
	Fri, 13 Sep 2024 11:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p1f/N+Bs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6326388969; Fri, 13 Sep 2024 11:29:03 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66251887FA
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgTeIHeRG9rMBQa24aPOTPbMc2x+M5EHHZ06gS936CT0Jq8+P4+Zr4HbiuxMa1AawyQ4FxJ1sfyBUDYrgGhdCKraKpZFAyb+Z3+8ugcwdEmxU+sjxZdLLloEvVy3xWyNLdYztqjjTOI9WwS6bNiTLmoLnfkdmCOQiktY/AP3HTqT79FsD24EImuxN1tbM9fPEuvuc5JQ+Cdgyr0rv8V6s3IwHoknhySeHdMC+xAFHW9cAFW9vMop3N6isoxCLZZGfHkZFXYI7Q1gcAXyS7mud0mkBRbR4Mu+WGCsOH6ZU2/VhU/GxAHAewMxULAW9Bb6Ps73lVPSTXE6JWmtah02aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWuePbzOpMZuKx1bFrfotUt6bhgDc/X02ugNB33yIHM=;
 b=k2/HEfCIpygn/i8W2hVqBzaD5FF7t+BNf2hv5CfUCdrzC1413VqESWfyLsNZo3oO67L+FNfSpUgGTQxOb1bXBwceIuMoUCAv+ZVDv7YwpeKg/SfRoPQv7rJshxipTgTBvzneVpXfafOO9SbhyS240Q66flwP1y5XTLsK38XXwU9czS5inMX/JEBuleF0o1xyiWn+igZqvj0LUjWNLff7vtgIzuV2QIdH5rLeVGwRY7zqAvB9Q5LXiHQ8KPLfUft3Y4H5Q4ZjXm6JJUKBuAl8w+rhJg8XE2EmmuWeYMSMLpzmG+o2xdQE9UeIeSTLnuRwPHE5cfMhubWJ1uiB6jgVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWuePbzOpMZuKx1bFrfotUt6bhgDc/X02ugNB33yIHM=;
 b=p1f/N+BskeeqHsFuZeCMjBvkqU1rPxT3TrEdZnKJZpIFZqc06KFOs4KnEAV6Znkn4/DlWfwVRc0ZnVgGHap6QFp/pKbzw8QwCCGt4QJab/huSV3O+jJpgBDmn84WiNjiZjThX6o0DWDYUTY9xMWwFE2qWBjdW+0cZLllpV85vHM=
Received: from SA1P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::13)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 13 Sep
 2024 09:28:54 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::92) by SA1P222CA0011.outlook.office365.com
 (2603:10b6:806:22c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 09:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:28:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:28:50 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 00/10] arm64: zynqmp: DT schema alignments
Date: Fri, 13 Sep 2024 11:28:41 +0200
Message-ID: <cover.1726219714.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2641; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=1VDmTMAMA+ybtIbNcERcyNRuu39YdOetnh6iJITLuJk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnrKdFM/7MLVvaZ+w2qzg8WlVwZ1Fud2/mvg+SgV0Zs
 W97RCZ2xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIms+M0wv6Y/4vePi0+sNkRP
 EH+yszsn8XrON4YFbdtZN4rsu+o4ia02d95vkYKvf36LAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: ef93cf15-094f-4c51-6209-08dcd3d67c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fn7xEL8EoIrMFLLdCco7FOdUx1joCUXAT7UlX633qWeTJh1A3b1DJKD/wgis?=
 =?us-ascii?Q?3oTATGcWu8Ft9/7n6+vY8NWc+SaNmd4tpbau8/hF+4x/vBMgQxnpfMdDjqLk?=
 =?us-ascii?Q?W5iH4LlbZ4qWF8lXRU5B93Pbeaeuy7okNZ+cINCIDtPHXK2ps9r0hyz+Mi+5?=
 =?us-ascii?Q?WxA4XUItmaygYTYYfSgkNrW8JxuihFCA+5GEpwNVRJUOMUq6/SyzmA7598hv?=
 =?us-ascii?Q?ir9KTJzBkc+fePwlGvOY0RJRRFXffht4OymWA08RDr2tJTXlgH0EoTMm5UPZ?=
 =?us-ascii?Q?nzOhBzBbzjaq+hxOmn8dGOswWLqG9ZkGer5xMTQLJqBCxRIl9Uewnn/FmgIu?=
 =?us-ascii?Q?qMr7P/oGWJBwFwcBVEWPTtE858yHSfSzhhvIpqxVKMR7YeMcQ3vCVxHWAssx?=
 =?us-ascii?Q?duo5qjJ+hWMZttqxKrBIH9siwP1C+OEjYBLehzIeMv9aE0BiGI6Fj/ddrB7m?=
 =?us-ascii?Q?2V1hV4/oq8pfIhfk5Xsxa1MXrN3imQgFr7k9zftT2hkk0AO9n9jP4Cg1V2r4?=
 =?us-ascii?Q?AIi/4+k+GLKYxZmBjxOB8O5EYWoQwEfmD3pr+LNX5A003+ztEewtupcHkUfc?=
 =?us-ascii?Q?/RXj5QOL8y5XbZomdhD/IXowjxFpLv/Am5kjl2HN29k/ThHbYL+rKTCKjA8n?=
 =?us-ascii?Q?L0i9fGPzIJ4KmQJUdKO60Huc7588YrTLXngFH5/45RI27NzE4UGr4T0qpaW1?=
 =?us-ascii?Q?YRtmldG9pZaUHMxYpfpM1PfdQdSBFFy8VVwy+Ou/p5dioCZqZBItOnpGt3bg?=
 =?us-ascii?Q?4ZNkXA35SnlFZ/7BLNItLKrgqjAm2lF1h4+8BSnqAUrFc0sahuAEMRYRKDwT?=
 =?us-ascii?Q?SbGZXKsLqMIilRqQgmFSwGH2kS1+6TFVRMBPq4J0hl5IHG2CWMq44ZLWTY2z?=
 =?us-ascii?Q?mpE/RkOTpJ8wLsxkPuVbFHf5Jfe0fvoNaHihLqxcQOAvXB04Vbu34DxVNRjP?=
 =?us-ascii?Q?PgGRFI+ZszBj/VnxrFHtw7FUNxq0Or50b+37nBiwmZqsfxkiiyQt9GHnUf8B?=
 =?us-ascii?Q?km/Ii5Irdp+n4n0MKEEkYJcRoz4DdbG+S8R0OVwo+w8yOwcRCdN87I3XGjUQ?=
 =?us-ascii?Q?nRHldmCARC8OQgUj//s/nmGei/Xe3iY1ok47mD6/CZZcapvr5qYArKDG9fZl?=
 =?us-ascii?Q?juXZvjBFk8u4pMcwvFyL1/gvGpRl7TIU3w1NYjdiNdwvx2wmA7bVNC6GWQY2?=
 =?us-ascii?Q?QsRP6k1HBhpOofIG5xpZ5OYp6YiWh6RQPEcaDFigrHOgYr1UUzblc8NS9qX0?=
 =?us-ascii?Q?3iYUTBSBx6vKq7i8c3E52wUmq3GyLnTWGrQpa1ymSRxq5uYpe7nVezn/yshv?=
 =?us-ascii?Q?U/zNmOHj9FLKP02QxSc6dY4DnhV/xtSAGbPSbw8CaF/qrB31eymJCpqQhFoJ?=
 =?us-ascii?Q?H4fB1839Yx0td9EBxhitwRFe4vqsmqfT9Y5eP4hF2SRwntEq9EbfQPPFHvgL?=
 =?us-ascii?Q?6PN07iUUrem4JNJZnIcA86HLnL/ND07c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:28:54.0632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef93cf15-094f-4c51-6209-08dcd3d67c49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
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

Hi,

I am sending some patches to fix issues reported by dt-schema checking.

Thanks,
Michal


Michal Simek (10):
  arm64: zynqmp: Fix status property for m-a2197 boards
  arm64: zynqmp: Align gpio hogs with dt-schema
  xilinx: Fix axi and mmc node names in mini configuration
  arm64: zynqmp: Fix gpio-line-name size for m-a2197 platforms
  arm64: zynqmp: Fix comment style around gpio line-names
  arm64: zynqmp: fix i2c mux bus description for m-a2197 platforms
  arm64: zynqmp: Align mini-qspi DT with dt-schema
  arm64: zynqmp: Define phy-mode in zcu1275-revB
  arm64: zynqmp: Use generic spi@ name in zcu111-revA
  arm64: zynqmp: Rename ina226-vccint-io-bram-ps nodes

 arch/arm/dts/versal-mini-emmc0.dts               |  2 +-
 arch/arm/dts/versal-mini-emmc1.dts               |  2 +-
 arch/arm/dts/versal-mini-ospi.dtsi               |  2 +-
 arch/arm/dts/versal-mini-qspi.dtsi               |  2 +-
 arch/arm/dts/zynq-cse-nand.dts                   |  2 +-
 arch/arm/dts/zynq-cse-nor.dts                    |  2 +-
 arch/arm/dts/zynq-cse-qspi.dtsi                  |  2 +-
 arch/arm/dts/zynqmp-dlc21-revA.dts               |  2 +-
 arch/arm/dts/zynqmp-g-a2197-00-revA.dts          |  2 +-
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts          | 16 ++++++++--------
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts          | 16 ++++++++--------
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts          | 16 ++++++++--------
 arch/arm/dts/zynqmp-mini-emmc0.dts               |  4 ++--
 arch/arm/dts/zynqmp-mini-emmc1.dts               |  4 ++--
 arch/arm/dts/zynqmp-mini-nand.dts                |  2 +-
 arch/arm/dts/zynqmp-mini-qspi.dts                | 16 ++++++++--------
 .../zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso    |  8 ++++----
 .../zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso    |  8 ++++----
 .../zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso    |  8 ++++----
 .../zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso    |  8 ++++----
 .../zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso    |  8 ++++----
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts          | 10 +++++-----
 arch/arm/dts/zynqmp-sc-revB.dts                  |  2 +-
 arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso   |  8 ++++----
 arch/arm/dts/zynqmp-zcu111-revA.dts              |  2 +-
 arch/arm/dts/zynqmp-zcu1275-revB.dts             |  1 +
 arch/arm/dts/zynqmp-zcu208-revA.dts              |  4 ++--
 arch/arm/dts/zynqmp-zcu216-revA.dts              |  4 ++--
 arch/arm/dts/zynqmp-zcu670-revA.dts              |  2 +-
 arch/arm/dts/zynqmp-zcu670-revB.dts              |  2 +-
 30 files changed, 84 insertions(+), 83 deletions(-)

-- 
2.43.0

