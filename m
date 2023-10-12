Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFFECDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 13:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC4D186E5E;
	Thu, 12 Oct 2023 15:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EZgvOfzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65C786E2C; Thu, 12 Oct 2023 15:03:08 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A21886E6C
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 15:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6h12apTai8Msp4txrgdAZbQGkjT7Nx8z9AKsV+jRGhNciok3zS0iZw9fdHCnV8Cx0UN3etXtOfoo1cVzJhwK6+MMz/EepQ26r5mNdvhsqDWKVbU5klcVW3wyW/rVeZasOJK5fet+yrqKKV8MOQdIam18owlDVDZj8/uzwZEY9pxgE7T+N+ptBv0ya3X7CbP/bCjPdi+nG+ZwqQBHyaIHpudxQVRwM6oNPt98AoJ7lXNEptpeSGkTEHRaft1uGUeUTLV8Bb0kIS/C+5wEbi8v6b0164WCZWHAD/0UFByORs92U+cSq30nYT+mQuYD2dFbGWNCtFgo2ndnIsL2CSnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tua878h8pWPZKf55rOxtq9e4Js0IC2FM4XN4tcVKp+w=;
 b=L+jcl2A06RtYiSx0dr+abyioRC2WyRK1ODt3Zs4W/o3GztwcK2hdaQF4jtfwIdo7alqmedw7H72RLAhoxIXEMYTDrzahNwH1E25ZRMu3CPG5h3VkbJLoOuQWGVGFoX40TBpoGnaZa1gIN46+K9gYRmvjPieNe1Q7AzVe/ZhmtDmBjYrLp59HYfgnPbxTDOMBAfUrIpCoHt1e4eFaOFLlnkQqWBbFOf9WublRXwBaXFB0tiXXjiJPkm1qtNE0eLRh8kMIevEb/qoqSe/1MdEYk04j5aoDjshyPrgjwv3UBQae/du3fH2t/zt4DrLrFFBTRsVmlZTJJmh6bvzLrkXK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tua878h8pWPZKf55rOxtq9e4Js0IC2FM4XN4tcVKp+w=;
 b=EZgvOfzLly5fi4cL2pZQXOxxIwtb1HRI+aCgWQyFxZjFRIOv3WJGkXS/e0SDGyr8I3iWciixrobmwlX4QTKMyDCAu0UrRikm5ZbvvJvBixNpAnsBaKLX0hGtbZgbEi+XDip/tK8GQ+c8BrinixgFwLkcMkkSYEqmvBUh4Ou06A0=
Received: from SA0PR12CA0022.namprd12.prod.outlook.com (2603:10b6:806:6f::27)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 13:00:48 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::d4) by SA0PR12CA0022.outlook.office365.com
 (2603:10b6:806:6f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Thu, 12 Oct 2023 13:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:00:46 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:00:44 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Piyush Mehta <piyush.mehta@amd.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Robert Hancock <robert.hancock@calian.com>,
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 5/5] arm64: zynqmp: remove snps,
 xhci-stream-quirk property for usb
Date: Thu, 12 Oct 2023 14:58:51 +0200
Message-ID: <1f4ecfe3ea6a4d0d8d8de324f5dffd3efc86656a.1697115523.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1697115523.git.michal.simek@amd.com>
References: <cover.1697115523.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=F/c6EXVMTFS0dqDtnonSbUIjqFgKfeWVhfW4FvIPwok=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlT1t52pNpnt7dedl+hUXreITNm/7f/BQ15vbu08aXrKa
 rre0TdfOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBESuIZZrP5ZNoaXuo/X3w7
 YSKL9MG2SaZnMxjme/efTDBJ1TV5z1GTPMU2/NWDE//nAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c03f127-9999-4ad0-f360-08dbcb23402d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aaDgFUp4eqldSh5SKwFqyX7GGNX9HB/G7Wo+C3I018H/BZJlzK2nrwyvp4fONDWC1vrJ1vXywrATGjcpW4wszlE3NmjIr6U3nmKqh8PSYvJtjvDNNMVlcGkxtolqbCQiDI/LC5qhaOjpkxjydGPKyBFQI3qciFAZqXO73V/Bsd7lyd8YiYPKi13ceGT3B2GdwX7sEYAjkirDKZ3NLImBCwtRj8ukQW7yxwNb3QmrwJY4J9PS/0EKU5mZD2TqwJdd+Zc993fE77Gbv8kSgQK6kNWVqUho1bMRd7vRAD1evVp7EPIm4yZETgkXzGw1i3Ffjek+SAS78Tdy+LQ95ub0qeniDBSK/ZkhEB42udH6P00w2Zzr52csjuAfn9QZVbjcQp5nim0NMg9J1qi2G0ocd0sKLkxaUHUhWtvkPi+9O2L3KiuLub26Wpwv8RjljQdwfoX1HTjTAbq9PRDFhpjqvqFcylbzVjKefsfFkC7+t2SzQVBAtQF+o+hV3s8oNFYjAFxqNS45qtaeQGwfxe+vlZBVOMO0a2BgpZd8dukK8DHCVWAfUWfy8L6ECDpQGfBVXGQz97AG5v19MLe121pTPyf83Ft/cvbFmq9zWwkGKOIe+LPvyPWdUQfAZdu4ykUW0/T8GLLORk7euVbUF+/GNgikgwmNWmGHAF58PELvyrJndqC+Li8W8Jv9PdxIJrzpeHH3xedFH5BoGsQvibLsrjXab2E06LuoqlML6PQbjgYuInPfEzhgF5rKtPQKrRHBO8w2J+z579joPz/CRTrTdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(40480700001)(8936002)(478600001)(70206006)(6666004)(40460700003)(426003)(26005)(2616005)(336012)(47076005)(54906003)(36860700001)(4326008)(83380400001)(110136005)(316002)(70586007)(41300700001)(5660300002)(44832011)(4744005)(8676002)(82740400003)(2906002)(81166007)(86362001)(356005)(16526019)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:00:46.3479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c03f127-9999-4ad0-f360-08dbcb23402d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
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

From: Piyush Mehta <piyush.mehta@amd.com>

To sync up with the upstream bulk-stream feature, removed
'snps,xhci-stream-quirk' DT property for usb.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index de60233fd061..2253e773d386 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -955,7 +955,6 @@
 				snps,quirk-frame-length-adjustment = <0x20>;
 				clock-names = "ref";
 				snps,enable_guctl1_ipd_quirk;
-				snps,xhci-stream-quirk;
 				snps,resume-hs-terminations;
 				/* dma-coherent; */
 			};
@@ -988,7 +987,6 @@
 				snps,quirk-frame-length-adjustment = <0x20>;
 				clock-names = "ref";
 				snps,enable_guctl1_ipd_quirk;
-				snps,xhci-stream-quirk;
 				snps,resume-hs-terminations;
 				/* dma-coherent; */
 			};
-- 
2.36.1

