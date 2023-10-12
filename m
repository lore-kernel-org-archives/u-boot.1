Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081F7CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 13:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D08BF86DCE;
	Thu, 12 Oct 2023 15:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UZna2hfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC16886E3D; Thu, 12 Oct 2023 15:00:21 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C108286D0C
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 15:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVsql36ersnPbm4iv8+1p0SDemDTniz1qxhzeXm6u6Lvfz8SlyFZPb2jGt7PhlESPo2nTST9PHdmZHN1mUGa2Asx/CC1Sr91iBqcTItLc4b104ADibnT70uRTkj5J90lbUNOEprP+WMETzbb4RjoV2HxSFA5t/Zu7NZ21fIBo0QsfK1KDUNtUr1Hm3jQtIOC/2YI0X88f3cSAmRsc5aBIvKLX+blndut4JYMYxQb3cfS5crziF+VUv5DTsdnLQRF2u3gQr9gpK7O/8XumDBmxfTXa8MRhQ6tTX6bLXHy/97L0ckp6NpnwHv39zm2uQ2Zr31zMYIviDCm0V+Fh6MkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAZ6TsEwA4LdtOnyuGmE8ewb/7C7roK5zZhTi/LtnWM=;
 b=H3bh0cfnDYU06NSc8E2d7Zi54k7LkaooRfIMqHvIHSB61AfxX82UtIaXn7LM2MaCyjR/KDKpiRc5Efc9eAwsr2lC3PdFhAeyyI4DFHCtkCeZ7VO5ObzKRK+MXXzJGr7xQUa9X+TzOc5yVst1iEsAlDNsbkXn7u3ijvy5ImJpxfqEtYdHzFFUFp8aPxIE9HwoGdeqpUljgDx+Oj23RQXuPW4jsIdqXw3V/Jo8Ax/kim9NqjsOGHyrQApb9VJyUENM2fIcr7PxP/v9QP89h24YuSvrOCZtFO+D/YmPPSmzoVt1dqowyMsdgfJgbeW7Ax6j4i8CwWuyrEJwTapTAw81jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAZ6TsEwA4LdtOnyuGmE8ewb/7C7roK5zZhTi/LtnWM=;
 b=UZna2hfIs8ZgxqxgQGW8tcRtdMPvhV8AK/sn3MTOegA+vr7wzZu7xKypeAn3B+NwFOt1tB60h1Bq5AEAoF1DcdZ2JO/oTh/ZugRkUfFIHH6vGDOmplOsznVf1ziAKU1ryI3ip6ndrtyfrgNRXRvGAGRt6Zxw/xIvrqeb7fQB+nQ=
Received: from BL0PR02CA0095.namprd02.prod.outlook.com (2603:10b6:208:51::36)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 13:00:08 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::53) by BL0PR02CA0095.outlook.office365.com
 (2603:10b6:208:51::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Thu, 12 Oct 2023 13:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:00:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 07:59:26 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 0/5] arm64: xilinx: DT sync
Date: Thu, 12 Oct 2023 14:58:46 +0200
Message-ID: <cover.1697115523.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=752; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=K9bTH9I1miO41I8xV8/AYVgVKd3CL7/hbwBr/tpN2yk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlT1ty13VokoMsbXrhRuMNu+LuFauGxvsp3FHu8vDWWx5
 dJVy550xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIn0BjEs6KqefbkqO4NdPk8t
 weoVj3M+m3Auw2z2SsY32v+OZz3O/3X16Ex7tkiLh3oA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d80f13-3081-429f-661d-08dbcb2328d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3yHm9b4D3L0SqrkTll+09L9XGuGmmQ/7oNJenZtEXLgu2cHrJscanwu7fvXW+wPKxxCnI8NET1PzMSgLxVkI8BqwEPEt9MdOR4fVi/2A6vpSitAv0eHGmZcBzyjuoEg2mAbV39aD/Sy5j6KjgNlJtiKq7tFFU2jSJqfBCFPa5KFHh1sjrMx6gm8YakDKP0S63OWTnm55MMXInPpBtEJo1QE8vP6BU0BTfprOwQGMdBAeIcXumwZjVbiraE+wCvPwehweSzQmD2N8Ldvq+n25DGbIsXo73oK/ya2l0A4cbboLCvGMwFu57UGDYw8VQwbf11rGamXXlJohQCwHRRbjL03RuSNjco9f8LeE2G+Kcb73VobyCFs4PDT6Z2/2X8eDqT0SlV4AdA9atFJqhtBT4ft0YlIPwlhpTkHm2godoZ5gPUXOe7v6uUz9+GNcw03UZ2BVMm3ddLQwP1+h7UcF6Bsry4zmXcRE3fCAbfoYJ6E4ULLTV99bakKDpQ+erwGsOeNUlN/c8a8m5zTXO3kgF318QN/ozd5xLaf8m7uAns9B1KZ/MRlbl48auWSjk3EgUnb9xdF4/WWv1rDleDPzzi/JfQcd728mPkl5RV9oIMDCNcdZk9hwDvFEXsZvYJ/kB1v0DfNcTUvLWXsCYWzgi+B3j9MK0yNL+pHVPvGpSctu9iSKe4xl2LJtVrigKbypIDbCUtso+h/SPnay5tHcJr/yMWElsOJRoMW83Ik7YdVc+hwCb/GKnhJzlBVN3TOBa/sgGcneNGADTRCyUs/sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(36756003)(40460700003)(41300700001)(40480700001)(2906002)(478600001)(44832011)(4744005)(2616005)(70586007)(54906003)(5660300002)(70206006)(110136005)(316002)(336012)(47076005)(426003)(6666004)(16526019)(26005)(36860700001)(8676002)(8936002)(4326008)(83380400001)(356005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:00:07.1537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d80f13-3081-429f-661d-08dbcb2328d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
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

Hi,

I have found 5 more patches internally which should be also upstreamed to
get DT in sync and descrease amount of differences.

Thanks,
Michal


Michal Simek (4):
  arm64: zynqmp: Use mdio node by vp-x-a2785-00-revA and vpk120-revA
  arm64: zynqmp: Remove xlnx,zynqmp-aes node
  Revert "arm64: zynqmp: Add power domain description for PL"
  arm64: zynqmp: Remove address/size-cells from ams node

Piyush Mehta (1):
  arm64: zynqmp: remove snps,xhci-stream-quirk property for usb

 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts | 10 +++++++---
 arch/arm/dts/zynqmp-vpk120-revA.dts        | 10 +++++++---
 arch/arm/dts/zynqmp.dtsi                   |  9 ---------
 3 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.36.1

