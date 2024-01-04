Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC080C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 10:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C17EC8793F;
	Thu,  4 Jan 2024 11:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KkI9KRtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A1D87938; Thu,  4 Jan 2024 11:28:55 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 316E0877C8
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 11:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8wG/1wo9Ch2KIQ3jKAMUiM48DwyrwB3ODNeMJ1nYW7jqfC3H3v4qPBCaLC65qgmLhfcI7XFPGXRsU+SCBwvgbFujwetEIiv7Tjs9WiJ/bNM0oM/5Ton+Horoa99GHTMNbcP0We5wkVWvluX+UGroFCwqQi00qIKFvo+lyquPEvxPw2eEYZAYmgHr/qAGbTu8XdcC8ebNxDbuZ8v/L4mWs0JF1omx2KcALMOLTaiNwuU2YGTrp4RaQIOcgnDxp8mQRJ4QOnw0wmHnldpnX0uzXvUCA15hny7p+/eNQuEXoYZs5JkkTZVVc0qtPQw9+qHFZanrVkJ+EMS2UAEGlp6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdvRGN8MfijUtlPSjqbE/nJMLck7ea9Ju7eU2yVqdF4=;
 b=BRxj2xByF6DrJD0sAHuhBU/cSQLG1S5jo5CkIiLaueBm8TsgarUM/5ws6FDNRRgpAsbFZTSd3/At9b91n3GNcZdNP9EeDJlppWC1E47QQcb9jiw0ao+CcWJPP0gdN9KtKT+59nwlPtCuUJ/KHlZC1CMvq+QVRWC73FI1SfbXdAyQBjA2HOrGpvacGghId/NfN3vgVbuX+dNStNgTcFvl+XG3MJk63q5u47ixOKp29/XVeGCh2euj9TvocnpmdUH7ldeevYaz4emhO9aIBZlFOGauxJr2ThM9Jw+xJxE76fAtcgo3qiXgLFqMso5ydxIPMaFqpptwYMbgyFWX8pAcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdvRGN8MfijUtlPSjqbE/nJMLck7ea9Ju7eU2yVqdF4=;
 b=KkI9KRtRmkwzA/e71ONf8W26tNOXXafusp0qYJ6cy8+dV9fUOTBCBwvTiTjbZgMfKcM9ppevdRIJd1Fwbnfw6lTYBVCqnpVR9+G1jefG3HDRwjGNu5is+Bfnbqf6gNfcBkCt5K6yJX9feplKiSXzZ3CR+3i0IflhJ9jdH1TfuTI=
Received: from BL1PR13CA0228.namprd13.prod.outlook.com (2603:10b6:208:2bf::23)
 by CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 10:28:45 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::46) by BL1PR13CA0228.outlook.office365.com
 (2603:10b6:208:2bf::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 10:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 10:28:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 04:28:42 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH] arm64: zynqmp: Match dwc3 interrupts description with values
Date: Thu, 4 Jan 2024 11:28:35 +0100
Message-ID: <578d758ce2af7e307e38ac8b7fa28ba9efba16d4.1704364111.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=o80ZaNvFJTjfNnGoWt1r3A7joJrvPTsPdQBADG8kEv4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRpHQElOU0ij5dsOXTVYeIDnhzVnn8XObfx2f+YdoVHz
 yIybmtuRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjITWOG+UVnjywPbzug/rvj
 lsaUTcsY4ou/L2JY0BzjLJRdpGIwnedDlNjqyNv3/7r9AQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH0PR12MB5372:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e44661e-a7b3-4718-fe62-08dc0d0fee23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YOiEmEmuvXeN0OgDPeZKm7OxdaKMDBgHGz+nUwdPd21rFgXuiC/BHTYFj1ucJA/mpi8l1+YcqnmjvGK/KkuX40V72yV4OEyI16nKBIhuB1oMm1VSF6d1HRDo8qZwzGIEgOzHurgWuw0B+1ccWhUggAEMaZ2Y5aMmc9yIjWKjfMhmD1wdMthdW+TK1TiaDiVqIg651acjVkS5qCJ1PhJ34rCJT10QgeEh/PXjIXutijuF9uy8GHL3KUgvcqTwIbUosrAMCs8zVgxVst6p4TnKzmMrbdrSCQ7NL8lIUXezNXwcUI+QngFkj0Gpt2g1Gi75quyMBYpueBmg4Chi3dm2idTXJQHoewnfMuOoofu5cGyqtl6DUqLmPhOfYxSLOZwNhjLoxRvBTIfk/ZlTO3Gc9ooXGzTMi2v1hgQcumyQpI7TsLyYgHdizD9z7x3fK2LIsEyoF95Qth5b8yDf0wXFxSoialTnGnAfE68aCMT/zYCmr5xuAGJxDIFb/Y/nkLHzrHZPeD7gUuf45esBz7f9Jn7i/X1ctWiQwTMxs6PoTEx3PGdiqq8tDj0br/fXEuPIzrPahh+y10Zt94BzmZd9+DHZf4JKO42J2BWwIhQb46BDDLl0ivZxH5GUkD2Dnls9rPxmibdVDe0HEEdKNl/wMbNS/xzAxcxKdPNAIzdFO+mZfLp83RvNGbWH3FLSnZGalo8S4cG8765NiHjo1IUUzPXMF4pJRiJP5DpDO3iaqlkwH7RG300R2z4dw8a1IPKWPoXEGkwj7ar7/VzU72P2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36840700001)(40470700004)(46966006)(86362001)(36756003)(356005)(81166007)(478600001)(6666004)(70206006)(70586007)(54906003)(16526019)(110136005)(26005)(336012)(2616005)(44832011)(426003)(5660300002)(2906002)(8936002)(8676002)(316002)(4326008)(36860700001)(82740400003)(40480700001)(40460700003)(83380400001)(47076005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:28:44.9837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e44661e-a7b3-4718-fe62-08dc0d0fee23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5372
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

Correct IRQ values don't match IRQ line description.
There is one more IRQ (hiber) but it is not described in DT binding spec
that's why value is not described. Just for completeness dwc3_0 has hiber
IRQ at 75 and dwc3_1 at 76.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 2066d5b616d2..30211ca957cd 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -996,7 +996,7 @@
 				status = "disabled";
 				reg = <0x0 0xfe200000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
-				interrupt-names = "dwc_usb3", "otg", "hiber";
+				interrupt-names = "host", "peripheral", "otg";
 				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
@@ -1028,7 +1028,7 @@
 				status = "disabled";
 				reg = <0x0 0xfe300000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
-				interrupt-names = "dwc_usb3", "otg", "hiber";
+				interrupt-names = "host", "peripheral", "otg";
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.36.1

