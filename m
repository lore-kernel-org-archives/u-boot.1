Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A74FEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 753BA86D0A;
	Mon, 11 Sep 2023 16:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WYPK7nyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A160586DE4; Mon, 11 Sep 2023 16:11:02 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89A986D05
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVRh4KzV3lhujjOw8NXkjvCPpE9mmF/kQw6UcReLKVPf/raUqxv94PasD3wi7HN72CpJh5jJhFX607z5dNM4MS1XIPw4nO7vFs7h40CcLEkfOCwAKPVjWPFA9yG7CmAp5jhTMpIjQVGa+mxcl0h0KKEEKqfl5zu56XZe0pHjsW6R/yN7dov3UyC1x1EYi9oH5OHMONfNnUcH34IgIEug5QwIjLWECkVYj0AyabwW7XFub314t5rt/kOXeUDjqQX5nq1oCuneC3QJa3pfsJOtEakt1BCqzkxtnkLnX1jLSAwbhBF6JLGKbBIn5ql3GXLlb2q0R+o2VRCbBlDKa7niFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sO1Xwd9QvojS/KGzEGV8GysCuWl3DtPYTGl/ABENoc=;
 b=VH6K1lPJ7ogvuGmvyhCxJ2Ve/TQ1q1YRUQD2juQPsSUnyCXDLe/pZjd/zlQwD0GKvlVKWOhzBI8IueIKjneXr4/7IDYmF1srABYdZPvVZexC/HSnJfO3dDEX2e7mA84AYdcFMGb1f4K4+gipKjuGFb9BrhwtyJM0OkpV6ORgWP2kQB2t/fd4hLZFYMRMQAde8wmOMpRpGFBAnojWCywzwx0jrIltqMtlI1AuhTeWOyK3XAiiMgGlYzu+U25Roqh0I6SrNTgVpGdN5HWsk8WpaGr/1mgEHA+kc9KkkRIp9avEPOmWmL1Xeh4BM0D7LxJagtoq+cAHUY5IBzsM5F/80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sO1Xwd9QvojS/KGzEGV8GysCuWl3DtPYTGl/ABENoc=;
 b=WYPK7nyuG63q65GauHU0pET+m8PR0Xbo/o0NQY6MkETSz2SqzEQ3yZ94vTnWpdVS4xEuMoXEZinicaVoFWaN4/Hyzz2wpRgRTpa8jClpCZxybcHsEAbFR87yPzc7ZUPbhYMjuywkZkZH1opE7osqk/z/CidWQMXpNVLB+6ME/dY=
Received: from SA9PR13CA0139.namprd13.prod.outlook.com (2603:10b6:806:27::24)
 by PH7PR12MB6612.namprd12.prod.outlook.com (2603:10b6:510:210::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 14:10:55 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::21) by SA9PR13CA0139.outlook.office365.com
 (2603:10b6:806:27::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.11 via Frontend
 Transport; Mon, 11 Sep 2023 14:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 14:10:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 09:10:52 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Harini Katakam <harini.katakam@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Piyush Mehta <piyush.mehta@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Robert Hancock
 <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/5] xilinx: Sync DTs with Xilinx tree
Date: Mon, 11 Sep 2023 16:10:45 +0200
Message-ID: <cover.1694441445.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ZXIZKWrcFPjxOZ3GITkn/W4ZZEOVuI+ME3HDxXbEWFg=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT/8s9D5ieLuMR2HNSc57jnJVPDhRunMwsEkp6zTNkm9
 uZp0pGzHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiT9cyzK+5/Zx12wFm9jTx
 qOXP7iUb8i9Q5GCYHyu6M0e81LykeZ2zMt8qF4OLDabhAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH7PR12MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 806291a8-ea36-42cc-5d2a-08dbb2d0e933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qD+DXZT/9j32epmHYs7p3/u5MpKNJC1Sv/KqB5N4BOxM0kV6XI0OzxJjkDIq5L6pCL+oidETyKpdwhpBVbYDfAB+sP3lrfGdWmdoau3D19l8MFfUP10Kx+PRyBeR6QM0KUYLaKDo8iLfOo/tHgGYGdBbv/HLbPAAQKVObmdrGpLw3MrzroBZj3Lf3zlqR1AlYidDzMoj0Rupu59bJYHLBgCrDv0KG6852zNbMUhe1W7QyqJlYBr1DiNx90D7h4dcLUS7OhUZuYRvEq9XiRmYt+bYtadByRA6KhKBsDUSqLH/0LVUJtmw+vKvPLODCtRnKwwfDoZWoou49rZwIUXFYwET5J3iSieaTcQ6XcVU65Fl2xwfj9REW3YhuWyuZlUn5COSPI+Gd/fSXhfpg7p5hupdudxGm6a+zOANP2pvaMXLSCkhPs2MsdSOdungyGnve8rbX/336/k1puPv4a3gAIpEhq5KSTIehfGbeBDk9oNML04+p+a7323/H9pzJU/LU1VU/PRpO1WG7jDTZS5ZFOXWmPYfTJ6L9CRrV6JYoJOGV7X9nUXL2adTlfY+DkHbWJWiltKWMxKJS+h9cNxbzyBiYHMCo7u88D1BRLh9iCpPxPrHs1sYO1a4sHHXfN5ebme/tzvb2UfJKtG/F8W0WRV41t7mS/JETumOtBgJUnGNGSZIAwOcdr6QdTIOt83QBEktlSLh2yy6cKcVSygVN25xk+qGGKAKDQuCK2QZCMoOiFo3UZjhKKiQLrTHpbgVNgxE4KoLll6Aiea2zcEaaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(6666004)(478600001)(83380400001)(2616005)(426003)(16526019)(336012)(4744005)(2906002)(26005)(44832011)(54906003)(316002)(70206006)(70586007)(110136005)(5660300002)(4326008)(8936002)(8676002)(40460700003)(36756003)(86362001)(47076005)(36860700001)(356005)(82740400003)(40480700001)(81166007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 14:10:53.7831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 806291a8-ea36-42cc-5d2a-08dbb2d0e933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6612
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

I am sending patches which I found are not sent out yet.
These 5 patches are fixing typos or incorrect device description or adding
already defined properties.

Thanks,
Michal


Amit Kumar Mahapatra (1):
  arm64: versal: Add no-wp DT property in OSPI flash node

Michal Simek (1):
  arm64: zynqmp: Rename xlnx,mio_bank to xlnx,mio-bank for DLC21

Saeed Nowshadi (1):
  arm64: zynqmp: Fix i2c address for si570_user1 clock

Srinivas Neeli (1):
  arm64: zynqmp: Add resets property for CAN nodes

Thippeswamy Havalige (1):
  arm64: zynqmp: Update ECAM size to discover up to 256 buses

 arch/arm/dts/versal-mini-ospi.dtsi      | 1 +
 arch/arm/dts/versal-net-mini-ospi.dtsi  | 1 +
 arch/arm/dts/zynqmp-dlc21-revA.dts      | 4 ++--
 arch/arm/dts/zynqmp-e-a2197-00-revA.dts | 7 ++++---
 arch/arm/dts/zynqmp.dtsi                | 4 +++-
 5 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.36.1

