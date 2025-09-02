Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824CACA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8405583A84;
	Tue,  2 Sep 2025 10:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kwfylE+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA83C83A8C; Tue,  2 Sep 2025 10:54:05 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A57EB83A92
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4EmO5AdDdU7c4wlIA8LhO0PxyzHv98f+mcjVNvh5xEvONfHWRwgofK6aLhHPDgt+sCWZdRPazBQxfauRwDWdJEl0LSuo9QQv84nALQtLQV0aMl8BfUIRJODhinSBx+wE3z/ZIsfoVrz1tzjXqI23mDJV8sxFJKA0Edu/NkDtHMGqAHu8iNbuXWTq5xw3jL3C3iqIXaV40V3H1FrfvEPrTa1Fz3oHqdRTPWMezA1B28re/IPUZsmYAGlQtWga7Ovy3FHa8L28R1KIqC4WJFwpuP7vWF4ed1AN6T5o0FIvKN83QN+5FW4mDKWu+4AJ/B38lUGwfO/YABIM/uP8Gpx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0/cX22yMmhqDvmqo3L3I6cpxfjbsLD2E287PhvC5qc=;
 b=N8JFjK0UQIn5dBifiU4k6BsXFKBlL4bi9tbkXS4MuFR97KVJiAkz0HsEjmEXK2zf1OBLs9Wciu85kHVT/io4loy16GLER7cJ4xfZKb469OWPYjtjfPu/3D9CFs8yB9Qse9LhKk2VVgMT3TLofatuWVphucktuer+g5/I9ygSU3d1RFXClWU20ng0H4UMHxtA9a7d3lowx5U9OH/x3ms1msJbfAmPsPpsGqq8XYo3tdy6M/HCQLgGid5JdFdROPY4HrU7+vCdlVFa9/95EwAw9/N+UUtG0B0dyaODVwwizf6rT96vHTXvkGatotGta2nQNvBe9FtFjNZfP7AsXc75tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0/cX22yMmhqDvmqo3L3I6cpxfjbsLD2E287PhvC5qc=;
 b=kwfylE+2D+JAnAeuEMrMurNk15+X2mrs19D2LMx9jvKZvp1Tot7Ei7UC22o5D7IC6+VJBkYhIRk1HxU7TM+pvKn/CympVX/PZklWM36MUqjKwpU7BCBVDIyuZR/tt7w+RpiIablTkv4gCyC3QBTSsUC+lxucB6lUxd9xbQNDjEU=
Received: from BY5PR20CA0010.namprd20.prod.outlook.com (2603:10b6:a03:1f4::23)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:53:59 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::7d) by BY5PR20CA0010.outlook.office365.com
 (2603:10b6:a03:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.29 via Frontend Transport; Tue,
 2 Sep 2025 08:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:53:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:53:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 01:53:57 -0700
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:53:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Paul Alvin <alvin.paulp@amd.com>, Srinivas Goud <srinivas.goud@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/12] arm64: zynqmp: Remove RTC calibration from sm-k26
Date: Tue, 2 Sep 2025 10:53:25 +0200
Message-ID: <6331bf84d7afaf8031d9cbb64354fcd8ca343d45.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=569; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=J54lTlwuTWL8KcAU6M4c9zgKw4YTfBH099lCJVbIFQA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29Bx4d657hmH/QtFoyKD1Y08RF7snTJPznSu1pXeP
 N+rIpJcHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRdHaG3ywHf9b/2XLe8KCA
 BNPGEy//+encnnMvsNVzod22xNMJTSEM/yOqGOKFNxz4fCt5ieTWkI/7/u764vQi4Vy896U1yf+
 d4jkB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 639448fc-2955-4485-0a4e-08dde9fe41c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kogpSvvcI+SG4TUEo0X2osh/EfNodNrcW8kgoaPcJbw6f5EvFfptgHLpmrjS?=
 =?us-ascii?Q?mNgJPFmeTCkrLHq6mFZJPWXScRFOv3tbpHKJMj8inE3b1B8TRfZLH2bekB9U?=
 =?us-ascii?Q?8i0USJNrYHmJ7r6xEkTZn2JvsyXWHS3e93lvhdZm59kZpiFAu9zsCFlBvSRf?=
 =?us-ascii?Q?7ozryslam7kKTqn6yseRUHpmnajDMRgJ235mBCyZ4KFs3KbQpgnfzMNhtzMN?=
 =?us-ascii?Q?ee7WyPmobGvhUp6xYzxfiHrGW03fYWXnCYzNI/9ujYDp3uCstCl8MmsnRsxv?=
 =?us-ascii?Q?o5H3PH0nbm804UbfJiyY8GWeBsZ5VarqriZFwREasfdZmqULnlODLDkjZE52?=
 =?us-ascii?Q?j0Rw/LPFe7ySJKNP/KC/+uPbJ/hqR65LEXzGYzHfE6ZhM1IdLEI1d0q4c0Ez?=
 =?us-ascii?Q?egMhXTjBwByk14qwWSlIowp6myA6OJJcBOfppcv6DoLV6edxVRDKFB00cn7y?=
 =?us-ascii?Q?fPDRtddgJRyZqc8DAZoUu+3fVlhDgPkqy1htpIxKdEUqMKwBGD4UmmTdYEan?=
 =?us-ascii?Q?HVmT6NypuPr8IbaAqWYLYZ0IZ8h5Sa19IfL6ygvaDWTqsd0LmH0nWt5c94Jy?=
 =?us-ascii?Q?le0MCpqWjkUtHPnfEUih/ddYGreV94xoRqu/um9/2y8Di+0KhYIHqLOlsMlS?=
 =?us-ascii?Q?CCNiVew6Qa8OrKfhgPpsK5bagDEFP2fH6EkYvvB7+xwGVB8WPf1mpxEREDf8?=
 =?us-ascii?Q?GRZms9WSNttKNIUBZzD1cIOZY2nQHCz3ciP3AbCcUgFLockog9bqXsZbfIpZ?=
 =?us-ascii?Q?/KmGhX20kPNbf7QWInR6Zbz/SZ9UKFOPWZtDu/6qs4qA0LhOBOlAHVwzjKMl?=
 =?us-ascii?Q?1DWOBEdlN955baeNTXcoXRP7pQQwKgKqDP5ANU39HSMVol+NBHEB05uwq3gs?=
 =?us-ascii?Q?0yK4J9JBy7dTPpBwuxsNH3fU8tQiv3ngVPAVYKfcun9fOqUgmBYB2P91Gz5r?=
 =?us-ascii?Q?GJcggoKxAbM0CMfg3y8R/81ZdQOMQXV0E9lHsDYws3Uwen5Gxs+CfqCDcPzQ?=
 =?us-ascii?Q?yiZTq2IVQ2de2LOmHjhvsFiQMcB8egZWvFIFqcwAEdYACOhDv2ev68ZlbgX4?=
 =?us-ascii?Q?QKTuxFl7mJN4eydFoEaLddCHZxCzQH8JF/7AeXBsfRAGPpei1S/8mkHD9fGO?=
 =?us-ascii?Q?aY1Fn0Pl+GaXSkjN16ebSB11bhZhlYfT8bqBGyCJzMelWMMNJgXuZe+2CZK4?=
 =?us-ascii?Q?GexLccWcA24/fN47nIywo3TzyVooRWIpmFdWpPbD68KeMGePri5YMj3oQc7H?=
 =?us-ascii?Q?N0BWcNSbGPMogdJW7gMfFMnwMaUNE7ZQ3f0RjwL/5v1T02KPfBYeuSXhGu2t?=
 =?us-ascii?Q?taujVwMzezVGlqq0hiNsU30YNYHvwHsHxZj3IXYqtDo/T95a8da6FKOl6qNB?=
 =?us-ascii?Q?oJLP55oKmbdNU9lN/Ykit0BmMwIAvx7+Xut4oo3dpD+rn2OfTKyIahvO7Tz2?=
 =?us-ascii?Q?cvTlWpqNMI3XjpDhgbh95utLueV/+Q5jdrczTe0aNY4IRsOlXfFepCpoidUo?=
 =?us-ascii?Q?bL+O6pyYZxTdeFLY+w+9iy8yH50DEA4dBXJ1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:53:58.9333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639448fc-2955-4485-0a4e-08dde9fe41c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
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

Default calibration is already in zynqmp.dtsi that's why make no sense to
describe it again.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sm-k26-revA.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index 70acd3eb88b8..a614d835b518 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -373,7 +373,6 @@
 
 &rtc {
 	status = "okay";
-	calibration = <0x7fff>;
 };
 
 &lpd_dma_chan1 {
-- 
2.43.0

