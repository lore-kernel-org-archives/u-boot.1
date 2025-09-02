Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9FDCA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1575883A91;
	Tue,  2 Sep 2025 10:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EIPg81VK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A8E83A81; Tue,  2 Sep 2025 10:54:05 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1AF83A7A
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJs676OYDSY1PCz5StBScvzIUxbrsqq6TiqCDoXi/zRRD5pVbxj2mh0c7P/4IUDLXunHlVDkwNtTzAytQvXfLRmUcp4jyTirHHn2uexcM05y+p9vrHvDIHeBtcf1cV+rt84VHYL8PYCwMGVNc1Bjw8H31VSnXounrhzk2gOjaNjueayIqF2CGPjeG2EC+ZT5PiAa8ExyqzZ2kldDJlzu/MnUqEImI3pUzFu9eNM1fZ5Ee9TpInvc3EaWpJ/EqTFumv4Wzr0rq90CGjp6bQsqGLzsYOKtuzAulh+nHEcTaXMBR1DtEJOR5TIuYh5XmuYF77qyIXroX9U2NvDy7l6CnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7LeRhMV+xTufIoCGChF3bFWbEiM+ynrdbG3rHbjld4=;
 b=cf4JR9H+dDTtGKD9zlGe2tF2QjfGMjwQV0YghLWjsmbTFR6mIpz6cfb/ztJBGus96ZF+mNrA3aWXEN5kIFdq3j0TPfDmZMoHsmfxFfzmvKbfGPJe4CgtWSjRZoMPiElNNm6/ApK9QoEz8lcJeOokdKIROAuqKA8RNcOW2Ql8Xkrb/0CxPePN2H+rDtRAmfUyehu3Q6Dw07Ezk4mBAMbK1WWqJjSZFY/c/NClqELWHRlB/xXHX+DVCTlWZ0QxtZDrpeuZYgp2K9fxwbd60VyZtttBJpOhS7meaIZwBFDnXUDn1IqQ7Hoz0b/nlfgCi75T8XXVsMTqR4G4bppTyOIf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7LeRhMV+xTufIoCGChF3bFWbEiM+ynrdbG3rHbjld4=;
 b=EIPg81VKyGWJpSfbGa28bn8vSigBaRecNTHZKOjDz48qjR3Ii5ydluDCrk/9mjK5X6m0sYSMi9gulahYMRBFOz9ybn0v/dF0PI/eQ4A5jCmu7EKaxvV3S3MdFbsy1BZtDNWPqM69MEM/gw+8WZez61xLExpVYD2uScQuR+YHifo=
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:53:56 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::92) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:53:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:53:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 01:53:54 -0700
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:53:53 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/12] arm64: zynqmp: Remove undocumented arasan,
 has-mdma property
Date: Tue, 2 Sep 2025 10:53:24 +0200
Message-ID: <546788df1a64c41e332463411ad99b1f3b40bc96.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BpPns2koF4+8uKbSYy7J7jfPsMX039ssnv+OmFb8DlY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29AucfBw2gvBBv0j7ZMK47NemXyJW6Cy9qPSwWqnG
 p5AJc3ejlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZiIwFtGhv9vtS1DxSfdzGXh
 ZN1mF6X886i1uHfDk3VylkUK+iHqFYwM6ysD3z8KvV6ZHv1r/alt9/SOyKltCJJRvLTq7ZdDknl
 MfAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: acc3fb00-e2ed-438a-2ea4-08dde9fe3fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ua5For5re4vitixpmwXoG/Fbh/6CmepMqD+KCBw85DDzTzyLZDEpAOSnheJ5?=
 =?us-ascii?Q?4vA7MqV36D3oWyVzmqDJdn8tbGUIaifJuXVhvQ9vhP1W+CsmB/ZaouKYwGpD?=
 =?us-ascii?Q?ZGtb9G+Zt2g/TMPhnvPiZippURVzyxTgX8C9DQJQ2WyT1QlgCapD24Ryzkth?=
 =?us-ascii?Q?kvoHG9CLYnlVmr0Sz9/EJ+U2bqYxtkTH8KEAJx86pZlKFOsHjv43xcX/eBgO?=
 =?us-ascii?Q?ATkAuaKfreehipMR7Ljf2/WaFHlieN31NZefWChoc5tme07aczVZGwwP5qW2?=
 =?us-ascii?Q?afj3BoOq/JoTPh98tdfSLB/JigA3LYmkD9pGWsEW63Et254h6GjfFzZxeAE2?=
 =?us-ascii?Q?OV5Sz8u2H6VoYTN5kivCRrgYksfWYr/hy5hwRBkRB9mgUoe87hHIQg9FNvbE?=
 =?us-ascii?Q?sZHgLGxE6bmq5SAIUTB/5ezYMSKWRdC8kjahrK56ljruN2BZsq/+Xg6H/Nq6?=
 =?us-ascii?Q?3XC5LFxDeJD1GD0ItQ1mLU2ZDKVFFrhUu0AQ8Y72JxvdPu2IkZDneDQMR8C/?=
 =?us-ascii?Q?nX6S6gr5bHN4JQz8eCYjIdAPK0+cuS2FzQW2Y0NTUNZ8URvvkCbd/GWZBpn7?=
 =?us-ascii?Q?QKZXoqkui1xiatEgoSbIKHzh+kNdQFB8dlEfffp2hcgkIrExu9fVHhCFrG2v?=
 =?us-ascii?Q?n64lXn/rLNlyBHKBZWtDwBgwczZw1GHkRavvIRJ9Kmkd+dx7CKi5GUpmOgBB?=
 =?us-ascii?Q?+Tewns758++WgHLNasVmgxyMkZIlEUpuBvOA9vjh52rYq+hMqXXcBWRpj0L6?=
 =?us-ascii?Q?ICZgJ/kuNl06rThylJmjqiqOi6U7M4cTY9uubUuJu5tpx1mBTca9yr3RQdmx?=
 =?us-ascii?Q?NoK4pofhU/826ZeGm+aqlwanGL75uM9XH+1IiSneoJV6QmAKH6xT885vrwDi?=
 =?us-ascii?Q?U6TV0ep1s3wjOWmeRVHmJ1elJyz9KzyheagesR1XkTzPzZzN80OXcD1fQoWg?=
 =?us-ascii?Q?qJ5faf750v3OlsoOWWFfTEEvUoSBBzp33FOQFx5d4JutNumDVMrr/C3FK5nx?=
 =?us-ascii?Q?ORwgdZzOekyU3aujazMnnJlN19UvBEOrGANkkI6KF0v881WG9GW+4KubWxDq?=
 =?us-ascii?Q?XfRV+tCvN78CTXFbh342hXBM816Ys/5+J60+jmVqebwjT70LOxfTCfRb4lWe?=
 =?us-ascii?Q?d/XsqkvFHDDcBNgoalYiuGL6PvDbWLIhFJGmNFZKIJdqcspKxEmNAXuYvcHx?=
 =?us-ascii?Q?yhdH5Qu7ivGCV0P2r24JEPecH1j0/Pg6c+QkoNpSv22DpZFEpvMLdIQjGzHE?=
 =?us-ascii?Q?qnu0VvmhlhFYvhk/rmgwPgs/ElXd9xOOFW+E+ycbuycoOtAUl7re1llI3lqL?=
 =?us-ascii?Q?k18N5oPzt/51MKhB+baZXPHbk2l75WMGacIVdRiLxavcVQ1FKeGK8v+048yw?=
 =?us-ascii?Q?zdPrYU+O1PI78/8luO0Ie/FufvVHEGO4/ywUwdF97GXbE7LNOimj1tygeVsY?=
 =?us-ascii?Q?c78TJ7vTGKW/KXuvf2v/lMIubN6EpUANYeRCVVJR5SksLCKlrqnr+s9OJdvG?=
 =?us-ascii?Q?c9LI60Fpx5UeS/jO8Et4JB7dLlc0enff4ZHX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:53:55.8281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc3fb00-e2ed-438a-2ea4-08dde9fe3fe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148
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

Property was used long ago by internal Xilinx Linux driver but it is not
documented in DT binding that's why remove it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-mini-nand.dts        | 1 -
 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts | 1 -
 arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/dts/zynqmp-mini-nand.dts b/arch/arm/dts/zynqmp-mini-nand.dts
index 1ece39997912..af2cd5b9bd8c 100644
--- a/arch/arm/dts/zynqmp-mini-nand.dts
+++ b/arch/arm/dts/zynqmp-mini-nand.dts
@@ -42,7 +42,6 @@
 		clock-names = "clk_sys", "clk_flash";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		arasan,has-mdma;
 		num-cs = <2>;
 		nand@0 {
 			reg = <0>;
diff --git a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
index ff7069bc1249..e3d5cf972e83 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
@@ -135,7 +135,6 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_nand0_default>;
-	arasan,has-mdma;
 
 	nand@0 {
 		reg = <0x0>;
diff --git a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
index 48ab619472e0..e187818f333f 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
@@ -129,7 +129,6 @@
 /* MT29F64G08AECDBJ4-6 */
 &nand0 {
 	status = "okay";
-	arasan,has-mdma;
 	num-cs = <2>;
 
 	nand@0 {
-- 
2.43.0

