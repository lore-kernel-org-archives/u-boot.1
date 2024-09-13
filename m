Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB75FA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B262688861;
	Fri, 13 Sep 2024 11:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fTMLaAd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3913F88B63; Fri, 13 Sep 2024 11:29:40 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C1A3887FA
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfnve9fSsvdQI/deO9rtDJdJ65yCIUMoYpPIKrSla8bUv/z8dYywUVfNNaeW20n6I0KTsg/RMcGvYcgzEYcS+fJWcU48hl9BkAwBhHiVQFyKpAgMgTPshywDk0QYbsyySgb5LLwle204RU7pPmcYBpeD02vg2IiHifZ8uEkb0ir2Nd/rHYvhrGSNf56nQShN6toHPVNivITf1sScit62t6TkmikaxWjYnIl9PxcFHzaBKXP/EGthLvTqAqwCHDqB+QtzMt2m23QGGxD8o4F0yD16ZTd5SMqTmv62h7/cfYbv2AIvL6rxe41HWI2qulJ+FGQcAxARqj/HHhrDa7lOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOU5CeNN2Mo94+A1eTD1LdY+AOPWGiIyKSTfEvPA2KQ=;
 b=Mi/D2nqoz+mswH6iAPUs2iPI86TdiX4+wgTFKqPY8pV9eF5bR01163V+PI+E+vcjai8a0iQuHZjFjXxgyAGBwHSbs2xII2ixb/VuJ1Y9+8IgTlJ4rLgso3n4wTVkVtCltu8eGdGV/bYtwu6mrJ71avp9hQZeqDUL8InNd+Pthtqi57yT0uheqnjGJSy21YOmtMWd7DshZ2tnIXGv2XQHjSDxUeMUQ8a1XTtuqpUkJ+BwhCxoxbPgcpnjjh/kDDY9GnvsUxu6kMsDW72p56n7yRvfBzy+xzMQ93At0kQay+3YWk3pm2O2fK/JnhqYEFZ77bGDHDkL4GlAhZGs7HpXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOU5CeNN2Mo94+A1eTD1LdY+AOPWGiIyKSTfEvPA2KQ=;
 b=fTMLaAd0GM/Vtgfw4C0NO3+XXGZxTpvPCHCicxbyoInJgS044W22ERvSW4CS35VBGjHSFJO2OCJFbd+UHELD9IRkNHQtm5sMJYX8zVVly3qomdI5+GpJIIGZVobH23uOdSelcRSuqUE6eh3dtrbYkD9rznh2gw9ekFKdnRWHEpo=
Received: from SN7PR18CA0030.namprd18.prod.outlook.com (2603:10b6:806:f3::7)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 09:29:34 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::79) by SN7PR18CA0030.outlook.office365.com
 (2603:10b6:806:f3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 09:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:29:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:29:31 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/10] arm64: zynqmp: Define phy-mode in zcu1275-revB
Date: Fri, 13 Sep 2024 11:28:49 +0200
Message-ID: <fdd98ebd217e005fedde6aa2175449f7ad5555eb.1726219714.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726219714.git.michal.simek@amd.com>
References: <cover.1726219714.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=551; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=W0x7XghHaFx93xTgjou0mepSEVVT2T5NZzyf1mH61tw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnrOcarr51Y9h7W/nB7L0/b2bIMH41UelReZb1ZembF
 xFdr24kdsSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJrG5kWDDlytnkp+KxG1OL
 St7YrUyZ8mzhD2WGOXyhC1Y8ufJV4Huj3pRTvuscJG08mAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: b93a229e-8925-41a9-203a-08dcd3d69415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G60GSkD5q8YQjpsPWlzZwm6kUbPy9QTJVmZY31xW3/wBW7C50TNJ9TZspgS3?=
 =?us-ascii?Q?3XsyIoQZV+vuMSEq/Hc77rvKL16LYTp/4fwMXyyFbm+S1wdm9ncp7Zhdl+I0?=
 =?us-ascii?Q?H7ckdJ4Om1Nx60rQhwdD9XODZ0u7p8Y4mX9AXMn6EyLTHzEQowYAyVTj+VoL?=
 =?us-ascii?Q?15t7egukKt+BsW3PSCwLzSvSBpyJT9T7vefn2ve2qZ4mdB4vkBvEq3UvgsLD?=
 =?us-ascii?Q?Whl1G7qhh0prMB9xKG5Y5d+WTkNVOgxfr8Mu1gxFutYaehsRR8ZufIIwJJkc?=
 =?us-ascii?Q?4bMkmsGp1cANtaVm7U41V7E5g9Dmaq8eKMDENFB5Bu2h1N3wwgWL/6i2N3/c?=
 =?us-ascii?Q?J87ksKijAzfUKANMm6xsd3F+PhPbUUJ1LiR7kPBi0i3LveyJCHa9OBRwutzQ?=
 =?us-ascii?Q?flE9v6ceu7tvr/TP/vb6Pd8ES93qJ26VC24KL8vikzkQAv0kyHOK8ysQycFa?=
 =?us-ascii?Q?frVY/lQwx3ox0aOvuvdyaQa2xW5FFLW7ATOsYeAJQotA8k78hpD134DUtIwt?=
 =?us-ascii?Q?tkL+0MoTZ4YFSB3H/8PSdkUmfPtuq94TqtPr0RqSoHkpOkXO8w8n+OM2Pmz/?=
 =?us-ascii?Q?s03PwJgZd+xPUGb5oWKKQsonrekAFCXy12ZP0dj9U+Xlirck9RsfjCt61+ZR?=
 =?us-ascii?Q?RvdWnozxa4KI9NQHkwpOHPRqMWgJXTabj4F/6Thtjn3/6XAMPPuysJtAN5Wk?=
 =?us-ascii?Q?X9LmiRliDu5lxTtV9aN8ICupMGZgWqTn9zkd0evBPfoSiY+/9Kfunxh8BJux?=
 =?us-ascii?Q?Si+7mrBBL/izmf9BBwWdTPcEdaRWyroGWWeBqJOc1tRqKNio0JO/kYy5hfDi?=
 =?us-ascii?Q?MlEc/3WyjdQkPMlRbL4d131DotzQ/2cqm0WB1/G9c0yFNe1UIAU71dSQlMRB?=
 =?us-ascii?Q?TGCxrmjtM5WYz5BkgIAUIYk6haTsNHQeCeO3KL4y1Xt6UCyzGs1JgLJ0D6y9?=
 =?us-ascii?Q?v22opGnHlV/DWst0xZQpBbQvwrtB2PuD3Y+3TS0mtNl0R+A7XfUIriphZ9pW?=
 =?us-ascii?Q?Nwlj8XmpEm2pJtmWfE6hIQfOMDPWrFn1KsZ003dJOwFdBlfq0+9KW2Cyrbv8?=
 =?us-ascii?Q?B9bQXezSWIXKHiJci/lbw9vF4JSIPX/CeuBnKUDkoSwwHNIZnpIRwOfAR53t?=
 =?us-ascii?Q?TE7IlGUIx9+Kdggu414RKzyJ51z24eVDTHeDAyMU4sT8Sdp1AcB6Y7LKZqV0?=
 =?us-ascii?Q?XVqUYED6Nn93HuOL2gwgY6ZVykBgktPw6hgtKKa7m6rgcKiim0ja9T5ICKBD?=
 =?us-ascii?Q?bax/OKc0G2kuoISo75LTJvK329xDfI76Bc/n0QrdsfBVDg5Bh1TQ+6szepAl?=
 =?us-ascii?Q?q2Ciy22YwB3BcFfUEQKMpF3FoxUwlgiRcYygY42MeMt5BEEnZa2Uc4g603LT?=
 =?us-ascii?Q?oOz4yoSPFZ7HJOCUb4dEagBIAFOgUynvS+RwU1nuoy3AfkAnJwuTJFjAcoVt?=
 =?us-ascii?Q?O+QA5d0OnIPP7nstmSSdEYe2zOd4msGW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:29:33.9861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93a229e-8925-41a9-203a-08dcd3d69415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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

Add missing required phy-mode property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-zcu1275-revB.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/zynqmp-zcu1275-revB.dts b/arch/arm/dts/zynqmp-zcu1275-revB.dts
index 4060dc3613a2..ed83ba327916 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revB.dts
@@ -43,6 +43,7 @@
 
 &gem1 {
 	status = "okay";
+	phy-mode = "rgmii-id";
 	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.43.0

