Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEC3D10F5F
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 15:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D898584262;
	Wed, 26 Nov 2025 16:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C3DBFvpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C41783BF1; Wed, 26 Nov 2025 16:24:07 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B77E83FDF
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 16:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAIqkDWgl7fMWjcdNB1nMLjOMvgGk4pMAqm6LU3kSzlM3pdkNN/e01+2RTdI+6nPemfPaiLBJGqD5ulmRaRnwE4u6MP+1Ba8iKEn7fpj4CDpl/eD5Md2WxxpAQ5/XvYisPveaS/HGqNDQ+FBGom3RCjadDDMVTZoHdhsnbFbLC1MhFTGb3njntDRr8F+CB6aGmdml4KP2mcdZV63y5p/GhdPIvKMHb6DTTETZMSC55wmPcrGnHQnYQVrQiUvkIDU5Jsc9xO9oLhiMWOFojJHct2TsHV3noroFoxGDR8jCULBz4AUD8cxGzju2umUMxYq7aTz/nImXQrJ70TQQDAVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxYTlquTjE6+T3ZELAOtgsf+ejNv01sGJq6I//OdLyI=;
 b=lsgb3mCsnj6SztAa8FMWdrvVQX5qqjqb2pd/ejk4psSzSY6TCg90QYJ7P/DWG/tds7usbdsNJuICdzfCTukkdJCbYDj2Q0OsxC99AhEDlAiWUYCgXDadEO+B6+P6z6Kn6xODxaahJ+OP8OZIq39BrCC9GaKKZFKbOJPlJ9kraThrIgjxAHrz3R1Ec/kyP6Xs3tQALTefQ5nZuLSlNbuq6xz6bWWkY7RCR8iWNCA8MJ4nLDFV60Ata6FGSaDQfi0YCVE/J228zaV803eFoOAr/g9P9NssIxsZHGdKcehXeTcpzxm8JeCSQ3TpG5SSrTemH90h31vYAoHTDon8EG129w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxYTlquTjE6+T3ZELAOtgsf+ejNv01sGJq6I//OdLyI=;
 b=C3DBFvpwwNZrx4mSG2P5YpWvWS9cRWktEVbVCCJKnk7fZqOYMILlJS27l44ncChU80RTFOj76v3Kn6+gr1C8BHkWOC+AbkSI35C1WbqytuQSdtuvYkWmdnBk/aO/ddaEjb+o76NDjzWglT+A/9stuwXRKmivyY0od45jJNeMIIk=
Received: from MN2PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:23a::15)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 15:24:00 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::81) by MN2PR03CA0010.outlook.office365.com
 (2603:10b6:208:23a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 15:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 15:23:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 09:23:58 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 07:23:58 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Padmarao Begari
 <padmarao.begari@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/4] arm64: versal2: Enable USB5744 usb hub
Date: Wed, 26 Nov 2025 16:23:44 +0100
Message-ID: <4cd72e28bc0e2a9720fe5481dcab2e923d708b34.1764170621.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <edfb7e7a6e800484d3ac3bf45a4f83adfcdd1754.1764170621.git.michal.simek@amd.com>
References: <edfb7e7a6e800484d3ac3bf45a4f83adfcdd1754.1764170621.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=750; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ZuWyl97prsNPwn5wad03zSihtGFwZWuFPMCIUsYHgns=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSqS7ff3zQtf4NTRhy/RnZnRuxMf77C6GO2Wwt2vb23Z
 M0a/v/8HaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCR2Q8YGab7OP/fMc/4xBXl
 tHo+xdeMJzeUPupjFK9qFc0t/ad6cA4jw/Nr9Qc5vEuqroc7rru+ia9E8bPwbtvODwcPvFTPL/5
 3jBUA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f91cdf6-ae01-44e1-1c22-08de2cffd2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xw+P3E+jDWQ7a7aWdauqop6RV8iHoEHU3/8w+ZJg0oDte6yCE0RYFNOKaIec?=
 =?us-ascii?Q?vVy4qJGHjOYXOLNlvUVFWquaNZFHbLLyOQa4TUHL/glpJmF7kB+rZCt3ayPy?=
 =?us-ascii?Q?xn93IEICN+ozgqOqlqg+GDiVO2QmVIoEIoD+tKYSCppGyP7OYS7SQa+HO3ZA?=
 =?us-ascii?Q?JtpJIqaRMwp6VeB7P88cxlWDisqcJWHJZXQysFV8Sik+U62/0zI95tRzBve3?=
 =?us-ascii?Q?jdJbQ0nenmXVZhUBwsH7ErWEqrmYD+P5a0UDn0LgdGTT4mF7a5m/mKKK4jKk?=
 =?us-ascii?Q?HGEj6hZSR5Qv8aJ2xQ36Y8XRzX0ywFDY/kFQO2SwA0BS6hw9YoFPWBLl3H6m?=
 =?us-ascii?Q?clsMUXy6RQ+XRiin5sK1i49UKvPFZ3pbsrj34LTdVyR60+1yqbBTDtzkvFAy?=
 =?us-ascii?Q?Qf2yfgwjWqIfQC4CJ6FOWG3y+xicRXL6CI92AQ6enYeAQU6okZ7q9ZTwgm9l?=
 =?us-ascii?Q?FCG55reqAenJye3wxBMlz3LSxj1b0TCpVLUoPHwg2PgzINlo1kwUjnG0ybNA?=
 =?us-ascii?Q?wg1RNR+YOqGQugdZkPdMk79B4opKe9vRRwlcYrOm59iS6ECLeRVgoMu9dTyJ?=
 =?us-ascii?Q?+oUR6w/VZrFFDhXuTIcmzpFtrAY0lJEeVhbpFeTMI3x0SQhHc2YhpYdsmJON?=
 =?us-ascii?Q?VSrEe3NJBDYwi5cb7WhuOn4LzpNzQc7UZJlOkUv2p15ScxyRH4h5PJGwvjZu?=
 =?us-ascii?Q?Nk/ZGmB2WVj4oqldbm/0YO3o3GKolYBe4OvqDqGwHSZcoXhogwb2wFhP4uJD?=
 =?us-ascii?Q?YZiS+hSrjlvHI/M+jp4g3Xl1akkeHqVyqtdvxqAHrIum8esz0De8NQVsjyWo?=
 =?us-ascii?Q?jd8YpN+nATujxWKoij/kFpdkuZdigBEVr6F/BXEpGse9HIye+WJZJBYKvaJ2?=
 =?us-ascii?Q?M7pijMcDkMNYAq87a8GG27IEPM90GYJG+2dtw17TDJB9OBBa6hu+XPgvtBc1?=
 =?us-ascii?Q?cbcT+0dw7FDy7HcHo9eKZ9zaqcmfCVOnb1FId7YtlAYREYcFp7Lj/P9It9tc?=
 =?us-ascii?Q?j4aynZwDjMd7XEslJi3EzjI9MHcgwPdB+LNrWHkEXEMhhqCs8HVeli8rC8to?=
 =?us-ascii?Q?VUW9hcdNIbGZHBjeqG6ytI5dOre/NaN6pI3s3GxwePp/L76oSgmtU70EAPiR?=
 =?us-ascii?Q?g/LqkvgXtM7BGgUZAHmx61fvg5Sv8CP5fH80nZtzcV8JP8kZQunS2NPrc1vw?=
 =?us-ascii?Q?GlCNoQJOgm2qE0sYPhnm3xM9mvNQ8vUOZX+Rf77gnOebmdHrIsvwxDaxSpPL?=
 =?us-ascii?Q?zzdlRZSDbwjM8U4gtn1YWTBeeQkwLABZvXv5nnKvbk/jaGROwphMHaTfv/fb?=
 =?us-ascii?Q?u6+ui3K37q29Gg19DOsAHYWBojRM8UneK8zRA4J7UVOQhruDxrqHfzcJ5std?=
 =?us-ascii?Q?eYv5adWA3ejpDxahBuRdcD0Yl5FCf1cVvCttrTJjToQbRLEXAfcMhd6tEvS7?=
 =?us-ascii?Q?fNgmmp1jCtvQgcFGFpizFlm2V3n96Oh2e+pHZm+GeMLFMSfCpHex9S78+qnx?=
 =?us-ascii?Q?e1LNzb8UNLqCWO5y5TgLfp4iLk919dnIts6rUxDgEdwIiHWCAzbV8Z6OcJVV?=
 =?us-ascii?Q?goB0/lm38+TsnZDHBRw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:23:59.6956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f91cdf6-ae01-44e1-1c22-08de2cffd2c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
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

USB hub is available on the first evaluation board called vek385.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 416128fa937f..c3893fa833ac 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -149,6 +149,7 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_ULPI=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Xilinx"
 CONFIG_USB_GADGET_VENDOR_NUM=0x03FD
-- 
2.43.0

base-commit: ba53d57c179f3390b32bc6094f3ffb5f4cde931e
branch: debian-sent3
