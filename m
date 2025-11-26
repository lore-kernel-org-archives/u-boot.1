Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F467D10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 15:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F0984284;
	Wed, 26 Nov 2025 16:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B2wsmw0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CA7C83BF1; Wed, 26 Nov 2025 16:24:28 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 911EE8425A
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 16:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5NZUYHzlksY5rjpOItc0iVNpvdELXhrt3ViZfQ6Vt3S9EdxBlBQRAz9Myj9rXK0Bb8oaETdooB/Q65VV08f27sNGzcZDdh1WuaoksKdna/reZX48bd8vsBwhZAR1mLsXqZ5CJuyaUHFW9QS8zBev/pv3qooq+x4zXzMppej3cY/QvfycCiXYqTkM8gbevQ0dHT/36lxkeCcYtatxZhRcaOjseSIpIK0fpd3Y78/L8KxB0jkneVQ9vB4EjkF61jkI5rFHxBCsoX7MmtJYGLPNQlP3PK0xzZWI/1qH/zgUtOv9LkNqhhItCyMi//wUzSjATgqJgkO+XLG48cGD306Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1kqgN9bsTz05GG0PfU8qfnEYSP9RWO8ZANmSHUOLOY=;
 b=QU7znE/VeKRVTZvdvkvB0gu7sJdgr1h0p/Qh5rCDt/UcJ4AyL14eGqCGgjSqiVhcJ9ZvRT+dTCGHJt74DFvvJS9QvmHY6P1EQZdXyToHtX+o3gDkYpe6ED8/UOV+JAttq16Zp7yQF9PrcqdEzG9i0YMc4C3354ddwCFrGNi4GcP07U0jEo9WNChfRo2bUYkKDG03OW7O/uI5HnhSyOJoYJckmCAkLad+vXFUYOxKVfOV8+HFknxVA8mzj4EAPTv7OZuRq2+G4DH85yeBJqLsHt259hwBgY17WpwJmDKwQ1+o676FqlXzzvOzdac8QUsqMXBlRXgrYiKV0XdRZe8hZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1kqgN9bsTz05GG0PfU8qfnEYSP9RWO8ZANmSHUOLOY=;
 b=B2wsmw0zFtV1AGxjDGLwJSZxJU7KGUUY/YBeIPbG2+KHgKdPPfcuTbrjOvbXlU+6nR7lu2psgA21hCGegq0Otdtky6MefUYQ5yGL2Weel9Cfri3UbZDaxqiZnv0IM8I4pC7E32ClQ36FPRCVuPX1UKxL+iVPcfYZWwzT6vC6YAo=
Received: from PH7PR10CA0002.namprd10.prod.outlook.com (2603:10b6:510:23d::28)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 15:24:17 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::5b) by PH7PR10CA0002.outlook.office365.com
 (2603:10b6:510:23d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Wed,
 26 Nov 2025 15:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 15:24:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 09:24:10 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 07:24:09 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Padmarao Begari <padmarao.begari@amd.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] arm64: versal2: Enable reset and poweroff via sysreset
 framework
Date: Wed, 26 Nov 2025 16:23:46 +0100
Message-ID: <a0b13b17fbf99fd16341b68b649ec08ef2b3536a.1764170621.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <edfb7e7a6e800484d3ac3bf45a4f83adfcdd1754.1764170621.git.michal.simek@amd.com>
References: <edfb7e7a6e800484d3ac3bf45a4f83adfcdd1754.1764170621.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=AMM77eWHOl3MNr6mu1Fqq+S6KyI3VIHnFfbgr9rQWgI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSqS3dcNJr7WfpmJeMehaVf9/tUL+de4cY/w23B7Nz1D
 zk+zxPg7yhlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJ/Mhg+MUk1nwjlLOjdSN3
 UHLyd5FknnPnVv2edPGEjHbYabmz/qUM/52Zb118tC8s8tih9Ey9m6cuVJZkOi67q3S0QD/wmrk
 rGysA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6828d7-54af-4ca5-5d79-08de2cffdc15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r70DamXzlRc70fZxWpLZJDh5Bl5vQE75tvhe6CeHxX/EgODakmSk7SE5CiXC?=
 =?us-ascii?Q?cSWMNT6gY2vyNdbrL9w6+x2ctcaztN/rdNyeqslq3uPnR8sIRnmzygiH80va?=
 =?us-ascii?Q?bP2bbR7/G6nVRtfPvZM1MTjn2YcslyN7Xul02AlkMEBnzXknT2VMPCrBOoC1?=
 =?us-ascii?Q?kPC3oas9/7H6lFEHdkbacUEpaYONp4NVzBH6qTHKULU9hKtYFuTXMm7uJKHx?=
 =?us-ascii?Q?kdL30cfe1jfyXADKA+6BSpS1ijRtCgRtuo7niC6C2i+I762oLz5k2BY9H8lJ?=
 =?us-ascii?Q?I2O/kupvjV5AWFOTA67BLhfVM8jDCEOWC8vV6mkjElrlObLZxaUJMzNTl1Lv?=
 =?us-ascii?Q?gpkLk7L1NC33zJnUT/KYFkirPi/suhJNqzLEU8my47qFxAnx7lGUh2lyxR8U?=
 =?us-ascii?Q?SkWcLj1Ejt+IDflbDyo/UCGLHWP/6fMcrqm0Bb0YvnYKveqKsU9jYxYzDHDP?=
 =?us-ascii?Q?iUB8SnRDYLlL+JTg9bH6ER2xx3e8Cx2SWrdZJBff5kqN1Dr7Em77g/+7cS6g?=
 =?us-ascii?Q?b7xnbVp+S9j8Waw60W5GLYCXiokOile0M8U/ZXB4sYRBnrbSIW4oxpRO47Fg?=
 =?us-ascii?Q?NmEFV2245YrghHRzjdUyuHtVE6ErHjdIr2zw5zRBXu6kN4FqKDbI4SFdsRBp?=
 =?us-ascii?Q?vfKne1JDTnVQ6a3E5kSN1h9VEPQ2NVsPdPg7vSmu4EeD6+x/QIPVOALjkENi?=
 =?us-ascii?Q?7XPqxGKiXbiDrUIHA1hgzcbPbNBCLXZ6IICoQAhmazRfURo+YCx60Tf7M73+?=
 =?us-ascii?Q?fqkHrDqPmWn495Q9VoU8EYthxQmNzRgvt4waJv+Sii8c7CgVzuV2eebnbay1?=
 =?us-ascii?Q?jZVN4COVXrMx5/AaHJBUapAxSpYMOIg0FUXcr7dcS2JzzSyHo3lDp81S0XxD?=
 =?us-ascii?Q?TdoW2K+Vj7Ln2x9b9t1pOOSNRNj5Pn+J9xNCN0FmirIZHPT7EL8ge9hm2BsR?=
 =?us-ascii?Q?LUSI040DmDlYWYp7WFNSFalgkoe5N6lp2yM8jB4SS9iNE54PVNuQnRmN35ZQ?=
 =?us-ascii?Q?QTYeOsgir98eJxULKAeUGzKp5HSNicB9TwI65Mcc9DV+3Uh/DxeT/kyfc0QB?=
 =?us-ascii?Q?A+avZ5LuBC+ZnrV0OpPYTQZ0+k/O8GYM23Ka390/5lMT9muc8zgeFPNKg5ta?=
 =?us-ascii?Q?FxfPC4C9xRj3exokHu40FaEEDWnAddqKa3suTnIbUILrVNthghR7agKv3/J/?=
 =?us-ascii?Q?k5TU8rORHfXp/2NM358qldBH0rhHG3F08LWd9nMx47AAPxLezdb0YZ3QtffE?=
 =?us-ascii?Q?WFn+iv1D2iezMDXAnJqhT6DmnHthrEvgHtmRy3nRqEqw52rA0qPh/3GqZEJz?=
 =?us-ascii?Q?+OMsJrRINURt7q4+8ZxtUzl1KXsQuAPgMmY0yLO/rgBy+OWGaWwPYleh0l23?=
 =?us-ascii?Q?tGsqtwbnvoYkzfDmnS+WsJRp3Et9Gm0uTYYpbYxFD/1i3oVJlUfdAAhT1TK8?=
 =?us-ascii?Q?wuHeVf4yfsLIU457yzb36Kgy2ti5ZLw8X9fDMVP2IqIcXkSBNx3mnw0n10dQ?=
 =?us-ascii?Q?6vEH726BmAzObS9r0dGDT/rQfNusIbaURp2tmipcSoYiLBwURR2AbKcyucQO?=
 =?us-ascii?Q?CRF8S/N2Yb2LKlByjkU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:24:15.2990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6828d7-54af-4ca5-5d79-08de2cffdc15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

reset and poweroff are called via hooks in psci driver which is going
around sysreset framework that's why enable sysreset drivers and do
reset and poweroff via this framework.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index ce633dfc61ac..0344089030c3 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -139,6 +139,7 @@ CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
 CONFIG_SPI_STACKED_PARALLEL=y
 CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-- 
2.43.0

base-commit: ba53d57c179f3390b32bc6094f3ffb5f4cde931e
branch: debian-sent3
