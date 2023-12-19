Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0819C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642A9876C8;
	Tue, 19 Dec 2023 17:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HitMQUOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DFE187561; Tue, 19 Dec 2023 17:18:04 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC225876CF
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH6zJYxw5//HfTVfwi7pDfewaKVdqliqEaiNVTkH5N6KfTDx2/P3rrw0wolmEKm79p0ZDMT3idaS0KU5I2I9E6vD5cEDydNZvVKeaM5xfp+Pztc/mdm5eoZTlwxJ2fFgnoz7u1jSj5JMMB3SqYZI0pJzFGQanXOPy1xOQFgsHZCpJxuxqHo5vyFp5mXLHZWKQdvK7h3Br8Xbyoy8482bEoTru/VhK9qwueHsJcK752z6FHcLAd8vIC5cH0iZhO6F6QF1jnC5qc4BqNm+zO9ePJQvZA91kPrHekKSGHU6X0vyGDY9Yvdxh7BqBc29a52rQ895ENuUuWn+o0kyYMcpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=key5/x7ABj+dNIZU6esa/pAMPNJsdzfSOvVrkFX5lko=;
 b=OnY/lsOn3GrHFvC5BHNwsoZ6AAynky5EuIb0PzWSTEtaeXwhtkHEaXPH+1eEG/cAFzWUHuI5cN2F4a+UfE3muqKddytFhJEs+FmdSceAxD2YZL2ObI5LNR57o27qMFsRhkh0nK+Xk0sIvuDWFt8eBH/LqEc5IDs6F+JymO9t0TWgPi5Aj7KMYL0712Menr548Vw0RyfScHBe+jh7HhGXHRemH7qWko4WQJul9iL7zV/Ys6lFIgvdRnaXv6GffNGkZyGdGmOxTvRFaH4HXgTn+4iz3t8o3LxL++ZN+SSPyIGoZemQTgIBSEOwUQB8DmfeuLlAD+7gKsGaT8kHfddfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=key5/x7ABj+dNIZU6esa/pAMPNJsdzfSOvVrkFX5lko=;
 b=HitMQUOetUPqUi6+CtKeKu0Mj5X+CrAqR7rB941cd+GTPHqCzGLuLvcazs835DMgZgmsBpQmzQep+4+5xlqZvjpZJMl1MLWj4lSbyl+N8EIIr1/HSKiESSqSuXAlcuKvrp0ievYM6wGRqFjf2VTS/JQu78n2KthSug5pG4bCZGw=
Received: from CH0P221CA0041.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::25)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 16:16:55 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:610:11d:cafe::e1) by CH0P221CA0041.outlook.office365.com
 (2603:10b6:610:11d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.39 via Frontend
 Transport; Tue, 19 Dec 2023 16:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 16:16:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 10:16:52 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 0/4] arm64: zymqmp: DT alignments
Date: Tue, 19 Dec 2023 17:16:46 +0100
Message-ID: <cover.1703002605.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=iLF8GNlioOrfnMoHxpkUFuOXZdHMgjSFUrl6r+rV5NA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTGg+8MytQW3El9WFE2aV/Ybo8TkzpvtAp8LEv+NauRZ
 +nDY1/qO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEKtYxzOGPeu+XEq238eek
 vPmcEcVSZu1i0gwLGp783G9brLvI6K/D/KoFFZmzgq8LAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: b824746c-e37d-451b-03c9-08dc00adeae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PimxBggL68r/rBLZHVPuxG1zFA3tjjhUsbCP09BR5dgRtnb7t+di0oLL5B1QWGIK1s9Hkx1ZkRakJ9xTIU5g0wpEKx+Va8rQtudklouT9uaWT187iI/HlGR1rUGWuNRiL1pPcOXvERjjF6zGgxRKsGxCCP+Kav8z7lArFBI1owEyOCM+D75EJEGPJrqm8YR5YMzdRr2EfXI97594r8lDEBZpzG+qCKamxgtxA2pJ4YakPMLohIwc+RW+CGY7GRwcRY0S7Opnr0o3QZetg2gxelAIwedNRwwFSn27/RhMvJ+NtIxKFiI1VjVHicMc9eK8yXdqGAx9+yrCSDJSmFvRGS5rvCNp0IYlAY1cSe8zPKvu8H7W8ZFyy9JUe1e62BYhGVpHcc5McpcC4q1S7RtklLzheglj2lphp0ANkG0PJ9cdJ4xDUlGrfu+sMSXH5Qi892BiVheS8p5nnFa0AXZX+K8BLMEhQ9xPFX68/UzjIwthi4VmCk6Y3foYFHpKOeM8ArKnVBMxj2Y1Pgh/nvUOn4HBVAgfnUGbTsfjSx591F00z8vA0lSUxrJqfGZ6Wec1gYqYoush+9MpIVCqpDJJMB9HS8srm5GnTdsm7LCjG/TW3dh0EMzrYc99TyYGo6xYHI+DMJ/eMEGrXDDM3DZ2a4DeHzx65GaVThOd7UjyAIen7awEX/z8oltpjZgiVFO00NfUzdrm0J5674sEgwaq/SLTF10ZLSnBEeRx+zkAQt9BjL3w6vFm38G5+CuvcIm1iqUA7TxVfaFAd16btgS7/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(16526019)(26005)(2906002)(336012)(44832011)(426003)(6666004)(36756003)(110136005)(2616005)(70206006)(316002)(5660300002)(70586007)(36860700001)(83380400001)(8676002)(41300700001)(8936002)(82740400003)(478600001)(81166007)(47076005)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:16:54.9271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b824746c-e37d-451b-03c9-08dc00adeae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
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

sending couple of patches to get in sync with Linux kernel and they are
already in linux-next.
The last patch is based on the latest proposed update in dt binding.
When dt binding is reviewed this patch can be merged to U-Boot too but I
want to make it available earlier.

Thanks,
Michal


Michal Simek (4):
  arm64: zynqmp: Move fixed clock to / for kv260
  arm64: zynqmp: Fix clock node name in kv260 cards
  arm64: zynqmp: Remove mt25qu512a compatible string from SOM
  arm64: zynqmp: Rename i2c?-gpio to i2c?-gpio-grp

 arch/arm/dts/zynq-zc702.dts                |  2 +-
 arch/arm/dts/zynqmp-sc-revB.dts            |  4 +-
 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso     |  2 +-
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso     |  2 +-
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso     |  2 +-
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso     | 52 ++++++++++-----------
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso     | 54 +++++++++++-----------
 arch/arm/dts/zynqmp-sm-k26-revA.dts        |  2 +-
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts |  4 +-
 arch/arm/dts/zynqmp-vpk120-revA.dts        |  4 +-
 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts   |  2 +-
 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts   |  2 +-
 arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts   |  4 +-
 arch/arm/dts/zynqmp-zcu100-revC.dts        |  2 +-
 arch/arm/dts/zynqmp-zcu102-revA.dts        |  4 +-
 arch/arm/dts/zynqmp-zcu104-revA.dts        |  2 +-
 arch/arm/dts/zynqmp-zcu104-revC.dts        |  2 +-
 arch/arm/dts/zynqmp-zcu106-revA.dts        |  4 +-
 arch/arm/dts/zynqmp-zcu111-revA.dts        |  4 +-
 arch/arm/dts/zynqmp-zcu208-revA.dts        |  4 +-
 arch/arm/dts/zynqmp-zcu216-revA.dts        |  4 +-
 arch/arm/dts/zynqmp-zcu670-revA.dts        |  4 +-
 arch/arm/dts/zynqmp-zcu670-revB.dts        |  4 +-
 23 files changed, 83 insertions(+), 87 deletions(-)

-- 
2.36.1

