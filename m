Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C00FA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931C188A7D;
	Fri, 13 Sep 2024 11:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XbfKvli7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0426588936; Fri, 13 Sep 2024 11:29:49 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B51A988A7D
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvFboVPmZHHfJBWRdOXQ25ZmnhLya/kj2Ge6Ea9IZ4Wuy1GyrKQGIj1u6qFi4OBOS3Up+r5PpfjtLAeZtudbB0ZlcipIWlbSzTxOHFfS024zvkqV/cA8u/UklcsKVX/3de2Mp778Wyeyg6+vGCxK5RP/ryKz0FhkcpI0O6uq3IVgbGAzNHWOlqCDD+ta55RWumWjOCOzNZRveTLOYB5wpHSM8bhiolq30lk/7R1ID0lYI5vG4qELJewihGmyIjb4KVwZnGzjkamzWGJXOLB7YmRDTnvMV02leLbgf93+dvlbi9GEGSj1o0wIVHZ0Ucw8R3IxwIhvD7t4+6+pFpmN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VVb0lZr0ZPwbg/ZQxTtzNrYzNNwX7rcQ2gGg71QZ+g=;
 b=g+q8SrTrFKOReY/Fw+Rlc7r5/bC1t1cVJRP+NDJMSBj1bBL62KczU8G46KefUSBXWwpMoDAKN3my6e/zmu8DR1AhDO7hM/CwgEs0LkhCEmIHjZoYzXtlu+Ynewq/b1YCfG8O9qfaW5y/JfxKACa3Qndn7qkZf2NsHZALm4PAorIyVPb3ulREC0A0NifSK0Vv22S8acwcX6gNFHAzJ4cu1hbmR5eTV9d4Km4/XdG7+WzNJd9Y4JA7489Baxn9wZdN1F/piNVCyIBqhqaBne6CiaIHhsCHK6mx9swqFAuAHAUk0svORWgj+WUJO6H8aiwVrtGHp/4TUHu5eLLtW8bS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VVb0lZr0ZPwbg/ZQxTtzNrYzNNwX7rcQ2gGg71QZ+g=;
 b=XbfKvli7SWBAyHgJIGH9InRTxDUTJmXMqda5IKywD9FnU7vS/o1ewhPRIn6tFhl4QPgJ4mHTzF8jb9nBk9ieLaafzKTbLJ32Q+Q80RY8L34pOhy9zlVJUB5D7kDZqxk61Q/T27bgevxsL9CDuU3XBZo10DRzBhjqteMH/2RAm1c=
Received: from SN6PR05CA0017.namprd05.prod.outlook.com (2603:10b6:805:de::30)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 09:29:42 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::11) by SN6PR05CA0017.outlook.office365.com
 (2603:10b6:805:de::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 09:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:29:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:29:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/10] arm64: zynqmp: Rename ina226-vccint-io-bram-ps nodes
Date: Fri, 13 Sep 2024 11:28:51 +0200
Message-ID: <88cc8423db6726fb1f3d1ffc0ad0262611c0fed5.1726219714.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726219714.git.michal.simek@amd.com>
References: <cover.1726219714.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=5X0lhh0cBzaZ8z1xeb1YKQiSRJKjC+Ap1fBiyESWREM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnrOfNS20nftz/z7zjh/ml+U8Xldaum7llosDOVo8n8
 h9DH+cGdcSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJXFzBsGCmx+NTe9aKKBV0
 xfidtdshd8wv5jPDPMWiJR13pG/erZy+d054lFDN1I0nmwE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c0a0a8-9003-429f-23a2-08dcd3d698bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P0QUxg/KY00Iyn6BRJ730rkxtaok0kWgazuFwG0AVWsM4EUbmQOymD7Oaxml?=
 =?us-ascii?Q?W9cyeiCv/dqbzheT5Q1MkOvyZeJIBcUpgv3UkPigBb4IFSPgEnND+Dd9YbZE?=
 =?us-ascii?Q?p2qbUmMr6GISDM1a+lhjZyb5Qgfi5w4u7mKvDwM4CTRqOOcE8iW/uGFkkIsP?=
 =?us-ascii?Q?iSXWD+5sYxZ1H3+8cG9T6pS1TK0No2g12q9E2cg4LzQQcY96kQJXz1iZ5UF+?=
 =?us-ascii?Q?cxFLKQCQqcTF+bpavzjs/VMniDf7tRmwEw6WyX/vvtKxXdVGB7EZUplQNHpf?=
 =?us-ascii?Q?0itxl9uKo1qn7P2XOnSKaGOCtCEqjeeuuIQ9qAnWiK2W9i1/0WLJyJOZ4dZ0?=
 =?us-ascii?Q?7piefjWGXAFRFIPmDuMES0tb3h9pdUcCdCdi7ZZ9NFesHIqyINzHo321pStj?=
 =?us-ascii?Q?d+7dvogvNM5Po6ublN7Ljc2zlmZYef1ICE6LlYhbAPUI9vAm0ns4nxs23LqG?=
 =?us-ascii?Q?lk2xx0e0ACLBx9gZhS6V5nglrUvDrwzr1E3F6Ai67/gV5BMykhvYQ4xJ4nfZ?=
 =?us-ascii?Q?IT9y+CgnNVLZPUOxdX86e0tHFUJd6H1/OXyCRuk1PMUKUnFyvMv4f6/ntDqo?=
 =?us-ascii?Q?vhmIufoJqtMKPnAsC0dpSpPuICCUbkpSFaMRJfsjrvmkMda+jOxxgFjRIBXI?=
 =?us-ascii?Q?Wg6kcUicFEe+luVjEvkkcGAjWCIhxi1TmgcCf+VNsM7p9DzIDwQHQvUk42XS?=
 =?us-ascii?Q?NbhkHHFSO2nuMKgi1Q9wvPjA84yEHLMXleUuy+iPTwQTAMKkvZpRneCnqvBQ?=
 =?us-ascii?Q?dJXROsamAci7HFLBP9o9aXt4tQyWbNQ75xI8CbhBqkK0zKbg8MSG9xD+JH5V?=
 =?us-ascii?Q?M2D1kl3IV7Aq3xCtWcswRNGU60BdAEmHhBzLpsvXCc0o+gP7RJkUq4InNs8z?=
 =?us-ascii?Q?FU1BXBWocnZqyrqJrOt99yQeMXRoFmxIJ9yNlLmJib+QPi3knhids7wZCpSv?=
 =?us-ascii?Q?bpAmgBazcwVZV04oTzTGMCPqKNopo0naN8PCB5OutySDOP5P+zLUf7hcZH/S?=
 =?us-ascii?Q?5y8BLvsU9EYc0xGXGqv+hlza7aLrJZ52SP0yz+M+VZl9BYPj4Lz2nvzHxxa3?=
 =?us-ascii?Q?QXEkFHHmKbJoxjjF/PYWiL3sQ/A1ZxvDiyE8d6JhKbkw8lyRWXXgHxMsHmLz?=
 =?us-ascii?Q?Z0uYYqSKTN686Ebrfyz09OEi6Wkw0wjiR28Lh4gogwLWdIBOlUz+7eSmQVH4?=
 =?us-ascii?Q?pYimKY9vwgNWmSXEviGp7VXA9BTkaXd5ea4X5evi9pwou1VC4UNPPL3J5QrD?=
 =?us-ascii?Q?LvC+nYpkHm4cpQzZUwLTW8Ek32uB6/5qr98sZ9LSKDh+Ce53WyYXt0+MmGpO?=
 =?us-ascii?Q?85TvqqtBlqiSUDLGrKpOwq5/vqHl65ppNiWcHw966zDhp/JWJ3wEi7lDgNdX?=
 =?us-ascii?Q?ThsZRRPhr6S6MCdwNTZmjVowNZZu917qSzW0RSo+QB0BySqI7SsJGFUPyX48?=
 =?us-ascii?Q?6h9RkrJQUlWlytXsHXz3kyD1J19+oxON?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:29:41.7915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c0a0a8-9003-429f-23a2-08dcd3d698bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
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

Remove -ps suffix to avoid issues with dt-schema where -ps is allocated in
property-units.yaml for pico seconds.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

The same behavior is if -ms or -us is used.

---
 arch/arm/dts/zynqmp-zcu208-revA.dts | 2 +-
 arch/arm/dts/zynqmp-zcu216-revA.dts | 2 +-
 arch/arm/dts/zynqmp-zcu670-revA.dts | 2 +-
 arch/arm/dts/zynqmp-zcu670-revB.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index 215908d4a3e5..88536e917d96 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -68,7 +68,7 @@
 		compatible = "iio-hwmon";
 		io-channels = <&vccint 0>, <&vccint 1>, <&vccint 2>, <&vccint 3>;
 	};
-	ina226-vccint-io-bram-ps {
+	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
 		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>, <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index b5e11cc4ff45..29087aa7cb91 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -68,7 +68,7 @@
 		compatible = "iio-hwmon";
 		io-channels = <&vccint 0>, <&vccint 1>, <&vccint 2>, <&vccint 3>;
 	};
-	ina226-vccint-io-bram-ps {
+	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
 		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>, <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
index def3b53cef7f..2928ebe56fc2 100644
--- a/arch/arm/dts/zynqmp-zcu670-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
@@ -71,7 +71,7 @@
 		compatible = "iio-hwmon";
 		io-channels = <&vccint 0>, <&vccint 1>, <&vccint 2>, <&vccint 3>;
 	};
-	ina226-vccint-io-bram-ps {
+	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
 		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>, <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
diff --git a/arch/arm/dts/zynqmp-zcu670-revB.dts b/arch/arm/dts/zynqmp-zcu670-revB.dts
index 41f9a23d06ad..1a99d1e08fb2 100644
--- a/arch/arm/dts/zynqmp-zcu670-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revB.dts
@@ -71,7 +71,7 @@
 		compatible = "iio-hwmon";
 		io-channels = <&vccint 0>, <&vccint 1>, <&vccint 2>, <&vccint 3>;
 	};
-	ina226-vccint-io-bram-ps {
+	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
 		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>, <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
-- 
2.43.0

