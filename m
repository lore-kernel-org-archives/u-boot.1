Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48782C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 10:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E03388377;
	Wed,  5 Jun 2024 12:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ECMGunJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7A388252; Wed,  5 Jun 2024 12:02:50 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90288837A
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 12:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3valBjuz9JuhkE0cHG5rdQx89rGkfqTp3msqto2oFWv9zmUut24IsUDX+b8XRHE4hMg+yzZi9ajUPeCSmcF36xyLAKNW8lUKLNUrl7Io2MZbBYZ/oUdXIjoxLxs5eFACzoltQoNXZ5ILJLAX+xgvfzIDn4JcyKXozVtiRy2kVJh/dZmH7zyfnb+oXzHkLySllqgg4GntYH57Zt0QEo0H5WCGc53wnv+wZNhIfBNu+ApRMR7f2jcGM8aXb44gpgLdCTM6uPgq8rM7aKgkCyUBq2hua/13ThsZW1QQT0NNjMLMUoC9uuaG1jzwuaPackKGKZ1Jb5gf0jjKCVa1rmJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL7SBVyqoFL+FW5T8+TuCMJGr0uzFw4PQvaikPQb89w=;
 b=mAjotQ1DocSkV7fa9V9ixoqMxkWTT6Rv681QSXii2WYcHN0F3guqVkPUZt1OmG8CxMk641Ti16xRZJnyJ3vkHUUjhetL9XXpKMPdPm1ZAl1yqQW1ryZPlmquGlVyCoPoBZ93cB8UBGoibn0QhxFSrL16S1Mgn7cwfaZOoOU9ZlQqyVRqyjn8MgzIpp3Jq53r8nQKc9aroYMRdaaIOxoVp1yBazsERMGevFk0Nr4117bb0Lt52zZayeELLe8cBgXL+FI/2VvksZ/NTi16kolfuPta+bPVg2QWiUpBWGS4nLbfz3wgA6m1Rj30oZB9N5Cr/fY381T1JEHvVpAnG/cr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL7SBVyqoFL+FW5T8+TuCMJGr0uzFw4PQvaikPQb89w=;
 b=ECMGunJD/n+pn5rLiKWesSgIfczOxkYB2hBnTPInwtT23HwRM7zD+hQSZPG5T7mn+3tb0F/VkKp5W+oIBCKanzZ13dSwc80dztflG4LjehwHwbyGvYOo2RsPUOHybPcyvwAq/dt5qOugCQGj1Lj/drfQe/UIKKlfbpygK1vsr2o=
Received: from DS7PR03CA0208.namprd03.prod.outlook.com (2603:10b6:5:3b6::33)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 10:02:43 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::8e) by DS7PR03CA0208.outlook.office365.com
 (2603:10b6:5:3b6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Wed, 5 Jun 2024 10:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:02:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:42 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:02:40 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Wed, 5 Jun 2024 15:32:20 +0530
Message-ID: <20240605100221.3571-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: b226779c-bd89-4f10-32b5-08dc8546a479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3tKbmyYcqP6AXledSMrtX5XnV+jmeleiOP4PH+9oPg+5KRxcbwYC06njnTWd?=
 =?us-ascii?Q?FF2uPVgMUVq1KQ5JVcLai0H03PV3jkCGwLslVH0Vd8saz8qKtWkJINLmB7b9?=
 =?us-ascii?Q?n3yTD871L7b+sPhLOPTV3LqLmLpxlhrbgnFEAj9dkxjYG9UkGLdb0pLGRqgx?=
 =?us-ascii?Q?lKsRsvOSa2jPaU/aWb08YN2vgOC0/D2sfeLXhgNKDU00Ovbaum5wwttEe5k9?=
 =?us-ascii?Q?P6OkmLG3hyzfaW8moYfBiRrmqZ/fa66/eegda46l0fnpK/cGn/eFdJOZ2/51?=
 =?us-ascii?Q?0X7jipVd5Csq9xhFnAGlFcnsTPfp4cVa97FXUApWACCRRczB6HqvFR4E4PvK?=
 =?us-ascii?Q?TsdPUEckhBvSm2WrvwXd6QnSzsOfrAwg+r+nRwpvyF9E8PPVpj45xgiMJetI?=
 =?us-ascii?Q?6NnXJp9xFyXqEBqpzzqYbFoyDQ3twJ6VZTR3chuYmNl13gTGpVjhZmg3FPb5?=
 =?us-ascii?Q?Bv3Bs2fU1QGn+l65FPsraNcDXTh7yriI1CnY03MwAFFmUpbHimqPOgf+ie8G?=
 =?us-ascii?Q?AQ/yErP5mZbIqeR1Yqv0IFkrC3ahu1vROYJZdeHkNdpNI1hg9mg6NeI0LWYu?=
 =?us-ascii?Q?ch5l2hCElpy997C+QWIJ1vdh5eMsRG2ILsCo+9iTawR9OSj/QCa3sAEEisw3?=
 =?us-ascii?Q?VuttCu1Yu3g+fwH2c87Y6NNvYtEsg8oSf4AJXTueOS0sD0Fp3CVmBokv/9YA?=
 =?us-ascii?Q?URtW5M3bUDEeJr/ycG3CpNzZDMKiCVA3uG5mpIr3GSu4TboPUZp7vwgtdCFD?=
 =?us-ascii?Q?qUu381aOWpTKpOtP4aboJqCV2RxZwvH8LLdnU1B5OSLPW6Dg3uNEoP7UaHGT?=
 =?us-ascii?Q?A5lzhMmQ+ea8UIvOlMvVUXXZjSd5N9SPKqZPfKqplgQcUfnLVlBjswX8FiMV?=
 =?us-ascii?Q?ZhcQh4ny4igOEjL75949sByHiK+ccnlhUnPrw8kzmE1InzXPIMqz9B0/OaEq?=
 =?us-ascii?Q?hO0nzxLdBWLLcqk/RLZ/dPgaV5YOnA+SFHlNWFj1A3U8QgYj95rjcF1rWoc3?=
 =?us-ascii?Q?QNievwPdT2wCw6BWGBY8L4eyOosUVih51xbcDGBsBuOuQAZPG7uBORJMhQUt?=
 =?us-ascii?Q?YqD7vMFDgbNsDEO/Ap9k5KA2WMlMO4EfmkowRT8jRYNG48LRF0rr/3XyKWA9?=
 =?us-ascii?Q?y3Z0rlqZjj6tIm+XP1bdIqQiVhdk3qbMGLbMecf3imvJaw3BOIOjHAbITPym?=
 =?us-ascii?Q?Yxc6Ego6FlVW4z4S64aDHJ5bSdM4s8GWKVWg3F9Ty4Xmva7HjQmBPXPiETvv?=
 =?us-ascii?Q?fOyGQsGL8Rzryj/NHdscSyT2tl79KCfwDa2QPeQsz4fWIBGIDMkT7t3mWY6z?=
 =?us-ascii?Q?T5Q8acJLgOG/LvB/9Ql9ux371rVLNVqK31bwcjznac1D14KtGtOhdjZlyph7?=
 =?us-ascii?Q?PY1/DujwytOcum9d6tjeG/BZnee8jaMEgBYpY9RvHsaSdi3q+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:02:43.2285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b226779c-bd89-4f10-32b5-08dc8546a479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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

USB host support on ZYNQMP KRIA SOM needs onboard USB
hub driver for handling reset GPIO and for i2c initialization
sequence.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_zynqmp_kria_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index ba42f0c7848..8ca80b67ee0 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -199,6 +199,7 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_ULPI_VIEWPORT=y
 CONFIG_USB_ULPI=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_GADGET=y
-- 
2.17.1

