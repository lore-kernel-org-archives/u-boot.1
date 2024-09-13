Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802A9FA3723
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 07:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEB72888EB;
	Fri, 13 Sep 2024 09:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eTFoyDs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5F9B88936; Fri, 13 Sep 2024 09:37:57 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F941888CC
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XN9Y6zPsfCaPlowcYzX54t/P8BsXC6jqF4RDpE/7O7OgzDE/2k+EvagVcnw84ApvzL308CMCyhnsv3UyTZpIo3nxP5Q2pos5y44UKByVmjVKKayql6sHDDTKkzun1jS/Ex7th5N9QFUNDkfLMIEDpfSOlMOXJhHKBRkWVA4hbW3yb5tacQGHby8+OVeXwUxFFYasDanVLlJ+W5Va8QFrDnNznsJDB3ak4qc2sNL2mHPFavVD8zHGgFkcCD08ZQJI05RLxjWY3VGteiAxrCah18efprjzsOBS4d/9MW6LRzQyfyzoZBp48F5DJTHb9Pm4FojZy7iFCz5ad3vpHnVajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkR9nR5gUlx2MXkz/prNrJAKUyP3dxlz0FfIylf6ZyQ=;
 b=uAR2mPQWfu6hMhTem3WfVvZRcazaL7keVaN6H4y7VXuPA4xRwAstQ0FJHX9t1NrzE3WZm4LPOv+z1g0jKQw/AH9u3hx86ZP4bbHbLKrQBvb2ERL248kQTXUyG1FQK8xCsTpPBf2HH40EYScBNFXp1+kIxPHlhgbrkoNT8dxCjJdpKSBGQ1QrygUdFk2dl8k1qVbnAsgtmrNa702Fx/TE+WBpKkjh36m0pqDHAPaq6QvLgjvVR58cKC2g8WXufDmJoCrqRgmccubu8x+1dTpXA7yNE6myA+AHlREEACgXzBfG0pBuCvCziWtyXiVUj6DYCchP4LVeIUE1rWkCawdJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkR9nR5gUlx2MXkz/prNrJAKUyP3dxlz0FfIylf6ZyQ=;
 b=eTFoyDs1HmAvVxKfpcwCNbdmjhx9dxIylNnTCySj/FgfIpyieMLf7AIUqVup5Qj2PcONsFKJUOgvyhzNv0959cgYGvB1k47Ii0Top324MnAeWcGn1aaY5/Cm3G6+5/KJHX2ZnNpckERq+LurYjbWQxYsnEQbhFFkKp+KvE23Xzs=
Received: from MN2PR10CA0026.namprd10.prod.outlook.com (2603:10b6:208:120::39)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 07:37:50 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::d9) by MN2PR10CA0026.outlook.office365.com
 (2603:10b6:208:120::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Fri, 13 Sep 2024 07:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 07:37:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 02:37:46 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Neal Frager
 <neal.frager@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Ramon Fried <rfried.dev@gmail.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Saeed Nowshadi <saeed.nowshadi@amd.com>, "Tom
 Rini" <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Vishal Sagar <vishal.sagar@amd.com>
Subject: [PATCH] net: gem: Remove undocumented is-internal-pcspma dt flag
Date: Fri, 13 Sep 2024 09:37:38 +0200
Message-ID: <2ecdbcc4ce692e2f8b3e7054a2abab35f6c03a69.1726213052.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6166; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ARNdakABPcVOYXV5Y+JAFs6HDwb9FcUYj1OF6QnvsJA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTHrw/7BHwy4NtZt1qp88DbV2GbIo9baR68u3SxTpn0p
 KfcE2ef6YhlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATUX/PME+VsVE9bMkn9Xmv
 61/+FD1v51e9eQrD/KKMTx9PvQ1MtO+SCXbk2BQ01+eMHAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: d660ba54-51ff-4eb6-4ee9-08dcd3c6f818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KvRZ9M2Jp3au7qJPZfGNk9BtPUm/iUmVN9h9JB66MDoVLXJ43jd6WbqIa9AX?=
 =?us-ascii?Q?/VQLxZltHSNAeh3CxJCeWTvxkGAtugwrL8TbInet/tYlXBgf+SW5yJS6PwLn?=
 =?us-ascii?Q?6gOasXjMQKn3PvsTsCoKv2XWBXJi5fT7vkZsnkSL/GPMYnFtE3f5PhpraJmq?=
 =?us-ascii?Q?HbtJPcXxm7cM2h21D7k0diqP38+V0LCBYHX7OUrvC3JgPGBZuXca/QNCuHp1?=
 =?us-ascii?Q?erYojSXJq7zjbXfGXVqIOdI9XcONz2R3dI/YDEDxrULD2S8bpkLgyx6GwoiY?=
 =?us-ascii?Q?SRaHcwjVYdC01O21ICcnFmmy+2fGfuDKn7zRuPCnil5UbYfV/weDH+NQI5D5?=
 =?us-ascii?Q?lv8fy20IuIPEsTRs5+uXTG2jm1WXAlOhiNbqec+HiMWlaY30o5tPdWaEA8FE?=
 =?us-ascii?Q?JMLKUWppPqen6BTj5dKmNq1WNE7MsBLhF/rMosAKKl1kvnP8bW4fR5ODAc9b?=
 =?us-ascii?Q?VQj3EvVbi1HltOYveGkh3x4jVlP7FdZthJ6lFrZUdaadxlgk5Z0uUsSDl9wB?=
 =?us-ascii?Q?qhzNv+mHhgzAKW0JCJw4VfvBz3h98t3VcqxpjmcNpffy8t2qKcqtJNROUX09?=
 =?us-ascii?Q?eeC2V3tqRsW7sEkcwVqYTsEJ184rljeyf5/Zj+sqh4ZxxhOHHkyeQmBNmOqF?=
 =?us-ascii?Q?wCEv6qX38/UdDlrPCQsdUkFNTXxyc1gDLAbFB8L/eCVaqnnuIO1IZbZnn9rE?=
 =?us-ascii?Q?k28hM/I6lz9Ll5ZcnsDknviwL0hyWqCiAhM8V0+uyW9G0Hur/mqPfEaMnlQw?=
 =?us-ascii?Q?kC1XqBAPaDgSnfTTHOXR5rQkRv58oVZEwmQpxChHHGCDozfW40lM6VV2SY6j?=
 =?us-ascii?Q?njsLJfrtyTcbGzOgDFE4y0AUbBdbLugCfzohS8l6vH0dAUtJFH51CdG9jOET?=
 =?us-ascii?Q?9m25BDFQUp7QAMhA1EwD1vruZEjupyarlnB9fn/TDEMzNbj5xnBm98sMUPn9?=
 =?us-ascii?Q?OQ+Z7qrXtWvSKuBqx3vVqkj+VjGYHOpeme2CqjwW4+H+sVnGzywoF8zHCq/a?=
 =?us-ascii?Q?uraUp36Y3tFrIVy/h6YLfVnCNQ6uh3q7slIAlYyWG3QZjZMzqMNzzksNKeTV?=
 =?us-ascii?Q?YL2s/OGuo58sWxFqZSAcoNfXeoPvfyUusQuTu5Ya2J/v+SE7EX8gXJtJMxGS?=
 =?us-ascii?Q?fuPAAqmJgYCwocQKN0x+N3OUjE1Khgr0tIDMxQQwIX1TaFX7ZdLBxK359DOL?=
 =?us-ascii?Q?t7zAc1TgzG1ZErRRnyY2oV/lSFUV0ei5nxzUJ/r7DZVKpXl73jllYwRk6D8s?=
 =?us-ascii?Q?Ys7TWmxf2rv4lgnLmacsdc6ypKJe2Aa6S8Q7NviW+4HxnHXfh2qLIKyxk4kD?=
 =?us-ascii?Q?H3rgLw5H9uJKoUBKzF66zKemGg1pKiPWgekEPg/jU+lUdHS+WAyus/hpQ/eE?=
 =?us-ascii?Q?y97CvyUxjGUqkf0BbgETnOtXG6viF5jFoKCwy7gtL9uICh66RK2abi1u0mBq?=
 =?us-ascii?Q?D1RqM2612xQHN0nI9FL7DR+lygg0hTEd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 07:37:49.8158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d660ba54-51ff-4eb6-4ee9-08dcd3c6f818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
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

Generic understanding/consideration is that phy-mode as sgmi means that the
internal PCS(Physical Coding Sublayer) should be enabled by default.
Xilinx GEM implementation allows configuration GEM (gmii mode) + PL PCS PMA
(sgmii mode, Physical Medum Attachment) but in this case phy-mode should be
setup as gmii.
The reason for this assumption is that phy-mode should be described based
on GEM configuration not based on mode coming out of PHY.

Also Linux kernel automatically setting up PCSSEL bit when phy mode is
sgmii without a need to specified additional DT propety.
All our DTSes with sgmii phy mode have this flag enabled that's why there
is no need/reason to just duplicate information.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-dlc21-revA.dts         | 1 -
 arch/arm/dts/zynqmp-e-a2197-00-revA.dts    | 1 -
 arch/arm/dts/zynqmp-g-a2197-00-revA.dts    | 1 -
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts    | 1 -
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso     | 1 -
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso     | 1 -
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts | 1 -
 arch/arm/dts/zynqmp-vpk120-revA.dts        | 1 -
 drivers/net/zynq_gem.c                     | 9 ++-------
 9 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
index 59cf22d0eb98..293d8e97b63a 100644
--- a/arch/arm/dts/zynqmp-dlc21-revA.dts
+++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
@@ -87,7 +87,6 @@
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii"; /* DTG generates this properly  1512 */
-	is-internal-pcspma;
 	mdio: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
index 0b97fa3f28ac..4e0587fd441a 100644
--- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
@@ -155,7 +155,6 @@
 	phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>;
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
-	is-internal-pcspma;
 	mdio: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
index e3228fc98f0c..c439f778ca46 100644
--- a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
@@ -80,7 +80,6 @@
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
-	is-internal-pcspma;
 	mdio: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index d3070b0062e9..ae52e8e996a5 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -90,7 +90,6 @@
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii"; /* DTG generates this properly  1512 */
-	is-internal-pcspma;
 	mdio: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index ce7c5eb6d346..6349a0e10877 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -195,7 +195,6 @@
 	phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>;
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
-	is-internal-pcspma;
 	assigned-clock-rates = <250000000>;
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index 0a0cbd2b69ae..b0d737d3caf0 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -216,7 +216,6 @@
 	phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>;
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
-	is-internal-pcspma;
 	assigned-clock-rates = <250000000>;
 };
 
diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
index b626d1aacf58..7849f8c540bf 100644
--- a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
+++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
@@ -117,7 +117,6 @@
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii"; /* DTG generates this properly 1512 */
-	is-internal-pcspma;
 	/* phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>; */
 	mdio: mdio {
 		#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
index e0632883e4ec..4768fac71d02 100644
--- a/arch/arm/dts/zynqmp-vpk120-revA.dts
+++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
@@ -118,7 +118,6 @@
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii"; /* DTG generates this properly 1512 */
-	is-internal-pcspma;
 	/* phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>; */
 	mdio: mdio {
 		#address-cells = <1>;
diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index fe7d10844507..461805ae53ff 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -228,7 +228,6 @@ struct zynq_gem_priv {
 	struct clk tx_clk;
 	struct clk pclk;
 	u32 max_speed;
-	bool int_pcs;
 	bool dma_64bit;
 	u32 clk_en_info;
 	struct reset_ctl_bulk resets;
@@ -504,8 +503,7 @@ static int zynq_gem_init(struct udevice *dev)
 	 * Set SGMII enable PCS selection only if internal PCS/PMA
 	 * core is used and interface is SGMII.
 	 */
-	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&
-	    priv->int_pcs) {
+	if (priv->interface == PHY_INTERFACE_MODE_SGMII) {
 		nwconfig |= ZYNQ_GEM_NWCFG_SGMII_ENBL |
 			    ZYNQ_GEM_NWCFG_PCS_SEL;
 	}
@@ -529,8 +527,7 @@ static int zynq_gem_init(struct udevice *dev)
 		writel(nwcfg, &regs->nwcfg);
 
 #ifdef CONFIG_ARM64
-	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&
-	    priv->int_pcs) {
+	if (priv->interface == PHY_INTERFACE_MODE_SGMII) {
 		/*
 		 * Disable AN for fixed link configuration, enable otherwise.
 		 * Must be written after PCS_SEL is set in nwconfig,
@@ -992,8 +989,6 @@ static int zynq_gem_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	priv->interface = pdata->phy_interface;
 
-	priv->int_pcs = dev_read_bool(dev, "is-internal-pcspma");
-
 	priv->clk_en_info = dev_get_driver_data(dev);
 
 	return 0;
-- 
2.43.0

