Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43388C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 12:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46CBD86936;
	Fri, 25 Aug 2023 14:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ej40cvnT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40F4086A1C; Fri, 25 Aug 2023 06:57:00 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 924C786A09
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 06:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAon41r2x8BxeuOsmon7h6kIoLwcvmy3/a3+/e6hfA5dt/RUnVmeyz01/CPC707zx7Md8tNeFFF8hyuLL2bQpdMqB5MfG/yhgiouTP8xeHgLzB6y3rFCVEd3j76uIrhXl+1rgb4OlIDdW+v4/mkjNqWJPSsl1h4AiDovLa2rW7XS7Y9rA2zM3dJdxld+L/6uVNBCTNIiTix+K2Yq2+tNnte9VLzy7Ubk2NKAQTtKrUS9Zf9/0FK+rNdq0ekCoHZIE7R459dpPh0v6OlIowiBqZ1dsK9MWRtjoY5uTSAm67s71PPkEVvWsrI6RRWwL0CfyTF6QFZyIymsTEv0OMcS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG7wiYn3Jg9jxs5S/lVPXXUscz9JSvAfAO/XICO7a2I=;
 b=LIY0/Xp4A9lmwFAcIx/Boim5q7qn9INi/mvX4KjuUaNyFPM1TQcKQ/dqtHy/CzBk3Vx5yb1A27GVANfgRWQFgx4RqiEO5TwSQpSbLJrmUOIzB0MBw2FHA3+/icMe4fmjJG2SjxkG0SLEFzLjMl/Xayz0V4hvWPgktZpLumWal53A6yutqROCZ1xJ7xp2GUdyxtHYmHXYfGc92mcf/Ja3czR8+6Y3XBAvX7g7lm98N5EVm1C7yxRzdlywMjTw1fAbNUYtJQyJw+crtqhdwV2so6sE8/2krXtpHbadczw7lc68Kp8OdaoTkILbhCrNFuhJ9nBinTCOFHFJFwQ2+XG5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG7wiYn3Jg9jxs5S/lVPXXUscz9JSvAfAO/XICO7a2I=;
 b=ej40cvnTiGvEuPIOwkd6xvI3kTTH2dTTkMaEyGzjx+4xFMSXW79G4faDUmTnuDWoQy1UZszbJNheaMasb3+NhVHM12/IXjJhFxpBEkyLTIr4Q3SVyi1bxRk06/VzrzdAJjFFNH5H/tLUriY16NSFzdzAXlMrfXD1Y+7rlKNFa48=
Received: from SA0PR11CA0067.namprd11.prod.outlook.com (2603:10b6:806:d2::12)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 04:56:52 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::12) by SA0PR11CA0067.outlook.office365.com
 (2603:10b6:806:d2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 25 Aug 2023 04:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 04:56:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 23:56:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 23:56:50 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 23:56:49 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 1/3] arm64: versal: Enable TPM for xilinx platforms
Date: Fri, 25 Aug 2023 10:26:39 +0530
Message-ID: <20230825045641.32728-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825045641.32728-1-venkatesh.abbarapu@amd.com>
References: <20230825045641.32728-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8729cd-8601-4d72-dc9b-08dba527b2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHv6wEYhwI75EGfbbyP0MHmqsCkcuaDi2nmCJDcsMzC7prOQ9JkugSQtBMr3IuDxOemLU1vsQOyAknX00FhioEirgLAQMvg8IM9pn1q5CrbMyMe+aqvBG3PyrWFcFUEmkpl+pmqoeh6UeuR44wRYMr+9rD+ILkfRV2XMJD0n2XYZJZBfvpHGVdC6LPEZyLN+1pEWiPK+A8qn61zjCJyu5ui462som+UbeQZQHLFqvBy30lshLD4W3N8OfDtXN4tWaG2Nx5E9xRBU6fUs8QKA1MEw+3j3UN9gSTUdwn25FVFMYE/ldvxVq6Ffc9ZZLauM5jJINLd4hP1lG4KVeENcinSpOC58L3PSCj6bDfT919GewFoxK8bLDtVGpEvijXKtksGXRRbIIOCvSrabYeMdTHYihqDKOO7g2ifVKjmTh6Y6JjPqI3L0NuRfJcBUT4Qmk4NbxSjP3GmUY/okgF5lwI9U41JCVWxYI4GZUCAJcm5glp5/kipK1t0HEPltmxkZkBr6+jOOWBDrP9vTCBKz1uSSrTc5Vs8e4QEJsqcfEzn1iv27QpTsDM8xmEs+N15wVc5cSaSpwdtZEiuiohf9z2u29gdX3miAsAzcxB+T0RKjhvYP4yXV7FSYOsaXEs+jS5/HGdnBvm5lNwDTSfwsBV6HGHMeiKh3b9gohrCwxrkx+zSobhHSIYVqHVpZTHPAhJA29OtH4xg8p1pTrokkR+zicV9g25ZywMOpDRqS6GEuDulFdR+dUbdjLz4gGpgOERhASl1LVRxkBuZ97RrUdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(82740400003)(81166007)(356005)(40460700003)(8676002)(4326008)(8936002)(54906003)(41300700001)(316002)(6666004)(36756003)(6916009)(70586007)(70206006)(86362001)(40480700001)(47076005)(26005)(478600001)(336012)(1076003)(36860700001)(83380400001)(2906002)(2616005)(107886003)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 04:56:52.4499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8729cd-8601-4d72-dc9b-08dba527b2d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
X-Mailman-Approved-At: Fri, 25 Aug 2023 14:39:25 +0200
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

TPMs are becoming popular that's why enable drivers
and command for it.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index a1feafc49b..3bca89d27e 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -51,6 +51,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_SMC=y
+CONFIG_CMD_TPM=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
@@ -114,7 +115,6 @@ CONFIG_ZYNQ_GEM=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_ZYNQMP=y
-CONFIG_DM_RNG=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_XILINX_UARTLITE=y
@@ -127,6 +127,7 @@ CONFIG_CQSPI_REF_CLK=200000000
 CONFIG_CADENCE_OSPI_VERSAL=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
@@ -144,3 +145,4 @@ CONFIG_USB_FUNCTION_THOR=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
+CONFIG_TPM=y
-- 
2.17.1

