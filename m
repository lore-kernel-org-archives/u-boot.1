Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC75C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 15:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C4ED879F6;
	Mon, 26 Feb 2024 16:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hMHy09Aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64BCB879F6; Mon, 26 Feb 2024 16:54:24 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1A483334
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 16:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e39gLQpLEjICVcdLY1640iRU3b8t09yNSMUGHN6fRywKVu2vJvFa5i8y9EBZe8AduGhmVNdZ4JTumYWnCQoBzjwkEFqoYGNKNazRuJVc3pHox+cSfj0J2I8X+ANWKawxY4rGs6ovzGrnYVdZWJ8Yvf29iMIB12OTBK9sNGhHxF516xBymFKN28CvvNFI7KjCuCb/uq/2DNIydbhahgmLUb3k7dp2+w4v7zNSkOcHI2ZjUZzLgWx+wfBT1CwFpfe9nqEa4VYEl8JzDj2rim+F0GWUmbUi2luQC/acIAve2S0FziesQn4+MBfkzMCAaQhYGNt1TvzdblYjGstcjmFL9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D3Pu/5GyO+CXVhuaPnlDnbLIw5SxqAkCWu8n3DiBUs=;
 b=ai+EIFuyJMy1TsXrdJOD2YU5XZqxJdee6Dd1jFWygtZKvuexKAAmLxBl1b7jwK1LTRDgpm1tKgEGCwwTifcfKpNh25NRMawfDvTAo6ustqymckkGPrp8sy5N7H5WzXUmwNTcxFkjDAiZjU40e8m5CgqNHm6xKMpSecv7fdZ4NL7a4Ab263+z4vezAJNXLNczaF520pg+XV4lP45+g25J48UQw7rReE3VUXYtzVUMScUDvhT4wu+cM7YPEpqGIMOdVGMdpehFnC1FJMm2yXpUT7w5/toqXSejad5u1gul/VV6n169XvtuTBctSuaBqMz1tPDpts5t2VOLvXzzpFih3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D3Pu/5GyO+CXVhuaPnlDnbLIw5SxqAkCWu8n3DiBUs=;
 b=hMHy09Aj58YDWd6nm5KipWyofd77sKGjI798ezHHNB3wegi4yBDsyR0ghPadY9/eYYycE5ul2SZapSqcKOwraj4TXsBrZj9/YAR181D8fWD/OJKkF96uMnBcHp1it5B0R7L8wgS1lA91cZPaS+eLuIrSolrWSSUdzWug2Wo8i1Q=
Received: from MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32)
 by CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 15:54:18 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::d7) by MN2PR15CA0063.outlook.office365.com
 (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 15:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 15:54:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 09:54:16 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Remove snps,enable_guctl1_ipd_quirk property
Date: Mon, 26 Feb 2024 16:54:13 +0100
Message-ID: <2067eefbad161dee64b1dc7d97c498f09a8307a2.1708962844.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=RV1ndhEmvgcMX/CgSziF52tQe1W/qb4lOUO1Vfs3uF0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ7W2SFDzufnBAgGKnLnV8703/316eG2Qymsy+o3lkiF
 uLvODWtI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExkoQbD/LjCfUcD+XXteKLz
 7HYxHFqgMYU7lWF+fpbqmylqydb1PRXRG5ImRmy84TsBAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CH0PR12MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8ed4b5-f3b2-4534-0dc0-08dc36e33085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGmrVjQ2Gaug3hR8IDIAQNTkwNUfC4sJWO5XXXnk9yF766YtLh1RQtRRD8PFzcnG0BEMW4ZD24mvOCj/18jWkoOVrs8GmiHTa2TbCEW+JgOhtfEGUv0ljrTKMB+eXDmGDzP66fibhoOJnxcFmAjszs3/oyU0wK9DZAp8r6Eg7stoabHuD53Ca1ZpyHEFJFLxcwqRttjx8KIYW8PRQGAfkIHEVYuwIfp8IJyMdzDWPF1hEf802lVfNVDoWdNEck6zLvb2CdTAgWmgvbfJ/t5rj4mIQiR0t4RbSyWjbgAeKOVEyL7YbUbTogLELLiEEmv/ODsxOohzvCOIcphSHWPKL9q4yic2PYk6V9DGRIEPCXu8nwop2F63ZjoUYwlO3hOxw+w4bMOf+bFzNebwK0bc7qXGn+efRvfhYhl1vfdyaxwepGBbwOod0B58z9qvw4MnunarnikS2gFjyJjWuwwEDvibxjNGLua4gaPrgZe8FUFnGpgUi35QAqeOxft3KI6R+KYqhl2UzSUbG9WMjeypLCIdtcQAcRUQ/fVWo4NYBS7k4GWOTWUwB5E0XmaJkkjvjUpvcOQy0MZ3PZnO/pNbiLJb+OZgUupQk+gzt1nNJrymAK0D43KZeOnxSzumqvsAfGT0TbTeUoUH6R44HwbiA4izdhzInVKLr8rySul/oYIfbO3HCzMtTpzPoy/gx6QGfMSBL0GzfSduxlDQQTfk0E+lhSAU6SilcfyJvUM0T5BrT06LIholdmROKhLGkBN7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:54:17.8801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8ed4b5-f3b2-4534-0dc0-08dc36e33085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
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

Remove undocumented DT property. Suggested solution was to apply quirk
via glue logic driver that's why make no sense to have it listed in DT.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

For more information please take a look at:
https://lore.kernel.org/r/1708023665-1441674-1-git-send-email-radhey.shyam.pandey@amd.com
https://lore.kernel.org/r/1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com
---
 arch/arm/dts/zynqmp.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index b50b83b7723f..daae23c12b79 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -1008,7 +1008,6 @@
 				/* iommus = <&smmu 0x860>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
 				clock-names = "ref";
-				snps,enable_guctl1_ipd_quirk;
 				snps,resume-hs-terminations;
 				/* dma-coherent; */
 			};
@@ -1040,7 +1039,6 @@
 				/* iommus = <&smmu 0x861>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
 				clock-names = "ref";
-				snps,enable_guctl1_ipd_quirk;
 				snps,resume-hs-terminations;
 				/* dma-coherent; */
 			};
-- 
2.36.1

