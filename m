Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D661BC46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 14:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D018694A;
	Mon, 18 Sep 2023 16:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Anj8yMBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E7D86958; Mon, 18 Sep 2023 16:09:28 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17EA786936
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 16:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Llz0+WE/DYk1Y6ELvsi8AAnbUGRdkhaFMNzNPl4fuRZLDGjrk225JlIqRT2Nk5DSyXMDlzTiJjDRg6R4bDQljJKhYwoI/c7rQIQ95s8ZOl1Gm3XAOgjt+l6SbIyLQAyMCXPs1G9x3IRKUJh4NhizSuYZXWp4I4C3M6tD5KJGAwlAtjuz0tIC2l25T6zaPpcqs/fuTyuD64DJbm8Y1XWmuJEZiKqaeeQxT5/pMZpyqY7OpcnyrAD3TNGTZ8DOx7mD/qHSPU6f8NvENcEG0PWMcwJK/aSzleA++CUGeLSCZGCZ27Qlc/PJ0RxWjpl3lFWw/MGUbyQQ4da9avaWvrvsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1Ot/Eh8eX1d3VQ/wID7T+zDs8G+5IF8aVEmw7Ono2o=;
 b=illlKsS5l14bxa0PJE5GHKYa36dhHkhYHLLMCS3jojNlqgGXmKtsy0aic6tBxAMP3MqiAwAiatkDxIsjZLkBD+Ygfuo5LGMyqHcriJwPtLGc9kWFL/KmAVlEhFQBwEGGRS2bMpX2VPtPiuSfGd2SOHqpfzVqi3Gt+X6ccEx2QXvUvQ3DdjDkQrdzmR2TmPu0CCeSB9YTFw8h8nkVgrd5uBXbEgdEx6SjGHNpfB8je6g0Mapgyd8NQO0aD3V9PhdCGzRtDONQUXPdrP7gPP67YQDGsUn3UzN1EoyU2uwFNRZ2adrMJDuulH3FJiamRIdLYOM0JvK8Wvx79jZDej5hxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1Ot/Eh8eX1d3VQ/wID7T+zDs8G+5IF8aVEmw7Ono2o=;
 b=Anj8yMBLuRLZXzRkoDmHhill6e/09YJ/TLu47SlDpn6xfPPW0580gM1mDotFuK2SRZ0H0nYiHm4GY/o/Q4vimyQ0IT++00/mcpLG2aJcpMdUMfPU2L+g8OoESbK8LU4hPE60b7rLy/PVSK3+NaiKZDVtmT5PHbDoYrQ76XcoDOs=
Received: from CY5P221CA0048.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::14) by
 SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 14:09:22 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:4:cafe::cb) by CY5P221CA0048.outlook.office365.com
 (2603:10b6:930:4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 14:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 14:09:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 09:09:20 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Rename dt overlay file names from dts to dtso
Date: Mon, 18 Sep 2023 16:09:18 +0200
Message-ID: <1dce37e72428c14a3ccbb5dc674b90dfe56b75ac.1695046155.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Y2wxD6BRc/wKClc6ujBdWtTzM95P2ceJ/aARvFpHbic=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSOKJ4nEpnlR4Vf/H/2ZVVftJfc5F2MSxqUuYIc9HXeH
 n83x+J8RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhI8luG+WWsdbt132nevlFv
 +jrxltyDPaqtrgxz5c4vkyvY+9r3gLkMy4qb3ktcNjrMAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 468e2f11-4751-43f8-2017-08dbb850db83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvY7EfsrugzyXVMeTH25M/RswzkUVLmjAsAyOhgztvkkXFDjkKJGfSsy+0G8Sz2EAVqadi+WqybndV9li/c3WRCv+Ku87NApOcLyxxUhIXFKBqGlBddPHEsP6ekc8vM7HbTSutuf9UF6AqhFsJheCS/5wff4I6+vNdWF7PDzeLspexpL6g3b1vdsAa3HsIWI2Ec4xTmgFDObsBFyltbCBJkmt7QJ5eBBqnBxI4nez2owCwriQgj2aXZz8p5b+C1EUGNM6XPxxxVq64S1lNDnilLxSGoiYBV/ZJHg/2i99TwZvu+a3LUtMsz6fO0/v1/i8qRIqFnn45xUXGg2C1uoVdjzTyb4Td5T4JeTtbmpmyjjtZHjO6ipdpebqcr/k1GsYCr8J3D8JKWkCOXAHUahN21XHcndYK4v7PcMZX6FXr2sjJ9ggugq3Ugxf7XnF13IkKouNfQlSUwQXysUEVyEdq5ASyZUS6ACLYQmZCUEJpAZlZ+vA50jjVLCT5WTPeKWXJ/Q/MRjWuZCfQjrU03Lq90pO86lAKU46Ue8pwQ6uo4V6agj/3/SojtNh0Th3evyFeXppe+xMxFyrsxPBJ1TlPo1gC0MWxWjhNLGdadHuIda2AKivkqe6DkMIUx4NcYVsZNha1hEtQEDVjHI92n8cEgudVZdUhgwGZC7w55q4rEi9mN7o3y/zBYTCg4hITJzkgds4X7d+xJwu2rONM9qTxLpzcWsXrC6NLtz431oIEE1hsLw84Nxxe7kSd+RNT+E/jzHID6n/H5Pa9vQe8gz4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199024)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(81166007)(36756003)(82740400003)(356005)(86362001)(40460700003)(478600001)(2906002)(44832011)(5660300002)(70206006)(70586007)(8936002)(8676002)(336012)(426003)(40480700001)(83380400001)(36860700001)(47076005)(41300700001)(110136005)(316002)(26005)(2616005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:09:22.1661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 468e2f11-4751-43f8-2017-08dbb850db83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
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

Use dtso suffix instead of dts. Build option was introduced by
commit a0f9a77912b2 ("kbuild: Allow DTB overlays to built from .dtso named
source files").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../dts/{zynqmp-sck-kr-g-revA.dts => zynqmp-sck-kr-g-revA.dtso}   | 0
 .../dts/{zynqmp-sck-kr-g-revB.dts => zynqmp-sck-kr-g-revB.dtso}   | 0
 .../dts/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso}   | 0
 .../dts/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso}   | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/dts/{zynqmp-sck-kr-g-revA.dts => zynqmp-sck-kr-g-revA.dtso} (100%)
 rename arch/arm/dts/{zynqmp-sck-kr-g-revB.dts => zynqmp-sck-kr-g-revB.dtso} (100%)
 rename arch/arm/dts/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} (100%)
 rename arch/arm/dts/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} (100%)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dts b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
similarity index 100%
rename from arch/arm/dts/zynqmp-sck-kr-g-revA.dts
rename to arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dts b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
similarity index 100%
rename from arch/arm/dts/zynqmp-sck-kr-g-revB.dts
rename to arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dts b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
similarity index 100%
rename from arch/arm/dts/zynqmp-sck-kv-g-revA.dts
rename to arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dts b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
similarity index 100%
rename from arch/arm/dts/zynqmp-sck-kv-g-revB.dts
rename to arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
-- 
2.36.1

