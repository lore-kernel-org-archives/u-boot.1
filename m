Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66891C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 11:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68799865A5;
	Mon, 18 Sep 2023 13:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QP31fFwE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA8686898; Mon, 18 Sep 2023 13:22:14 +0200 (CEST)
Received: from outbound.mail.protection.outlook.com
 (mail-dm6nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C28864E5
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 13:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv82C0pf0z0lcYgDJ/kJQXVCRyXaYQB3t39c159LDq8voLFuoS6O63p3bfni79/1TFpjE0K6T2v5XDqzAsTJrvi0H+KhH/H3SrNJJsuzuF+XPtoZwysONvfiHwM4qIftbOr2QGHLL6T3RjIjmXeDjx/9VPv3DYGAA4IKsoRfewvxyxGSg4sqRgqnEdWqx/otfmwiE6oJHvLefYp0ZaEei8w1AouydDTobqM2nbCp5HxPxTcvqxAsYNZWHWvn5JCSONZ6WUMmlZlxtHmgJl60YJeUf/z1i2ER7pLbvdtVnpvqdewEPkiUq3SlJXJc3Caijb0YrbtcJJER2gnyJrnGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WW6dOAnXsGATyIWQEYjnvUIgZMgy4xW2Lz0Ujquvyc=;
 b=CHzdweAWNxPRXmuSNR8IJqpFXpTyjEC9BOFH2ebrtvltgr1+UV+2Z5gVX+ZLAAB+1Lx4/rU7oVyviIqlkooZGt1HO6LdyP6z3wpDAbQYHh+I2XaprVF2Lr9t0TVuWwqKZsxbonPTjKG2LIoZwDiVVlsmUdv+5Z8f/3Oym6O16Gi3wzuicQ9RxZ/3j9wSoNSr0Yw6LfqlMQTnqHGhdh/M927IEa26Ouxc5DPz9uONhxb4C0vCBzBoMehsDPC+B6qjH3fsDwf0PmbmjJwCfA7eULLeMHVIcDz73Lwr+ldPAZLA29dCLA5QmaeuhUii/eMIGKJGYQ+7D1gnTtXQUicwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WW6dOAnXsGATyIWQEYjnvUIgZMgy4xW2Lz0Ujquvyc=;
 b=QP31fFwEdfH+4OBL0DTsjwCBT6I2pf3MnLuMzbI7O2NZDBaBeZTySzcHbmyjNBAtPTG7zXQwcR6818OjIb1AzP2t3whxaLbBV24Dhm8apX31P7EwPc+xzfJ1iPNs5kZxUDmKCVbEkCCI4b0MdgWAFxPmARAzV0zV10OsvGY0aeA=
Received: from BL0PR01CA0025.prod.exchangelabs.com (2603:10b6:208:71::38) by
 BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 11:22:07 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::b9) by BL0PR01CA0025.outlook.office365.com
 (2603:10b6:208:71::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 11:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 11:22:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 06:22:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Describe assigned-clocks for uarts
Date: Mon, 18 Sep 2023 13:22:04 +0200
Message-ID: <bddbb81209a4567b0939c5d2d0ecb42fdfcd71ea.1695036114.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=720; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=lM7q5+OVsg3od5n6h6tZYTxEuHhfHeZmb9IGG/hsgyw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQOo0tKFR/eyLqoh/FZHdvqr7f1w/opu4o8+7bfSl2Ru
 23rKZ7rHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAix7YxLJgx73VLhsCNsqKt
 XlNdJ8+VXJPnWcMwzzIm3y6Lc8+12BUCJ+Pl1384GeOfDAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 32abcba9-957c-44e6-80b5-08dbb8397dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikfX6EKKGbthtZgC8aCp6Ygto5eH9y/aq7jk8W/7BVRHMHvQP5R3Sp6zvjQcykh4AoZj+OfURWwOLRiCJx9MqWIOIIzp7y6qh70xx+K1Sl95IXzEOygj2MGECZYJXrPGsSBUDHwaF1ypPbyQDsME13pCwbkrlPkJEhwmTu/FkLLMgQ4qPKc8tCzv1fiUl76GHI8lnyUb+kPkwT1s8VS5XveLHgdxTM58/eMHjt8jrXIxxAY/tWhIfQ9zoaSqe2FuAxf+qraIwYq7JeDRWNCmtvWzI+sE8jds8kelcYzhFnFfiMzj9eIRpPi4kA1O5LTVTo3TVWgh+HZmD+5VAYzMCtp+HczyZ+jepH36QlH1+XsO5YP4osDBMN4uef5l1Q9Wmcd7lqKLI/NMWiP0mvbH8v2GV1BPhgsHXmYEr+TUR+PELmr01bGeq8x1JfxSyuCzuz/ua5kG0IR+4iTIZ9B1RP3XY0YLXoiRrGObD3sSxgk+eP4HHWAp4BezSSqhyL5dV1ZTMCcNZgr5P101caPRl2l+1gRN8W/5Nk0FNOXbULIKLHiKI6uG6FRAf0VP+qxaZ1aVlYkaCekUwOLJejhNZuH5F/bgaxJKVKaq1Oe8CfHuUSryIF0/I1YozsialWSmppD+Ucz1iEFhP7+2teli62CYyK0h1l/JfnuB309QbxSxu9azX3H3spIt+yddP+xRh3KfCiZBytm8/q4RCdEokRAFIJM6FVS6ifiT+6x+Z1PYdZyAxCBneYCsOPUn0znuJsnRejZRwb4r8y+gf54orw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(16526019)(26005)(40480700001)(426003)(336012)(2616005)(40460700003)(8676002)(8936002)(83380400001)(82740400003)(356005)(2906002)(81166007)(36860700001)(36756003)(41300700001)(44832011)(86362001)(70586007)(70206006)(316002)(110136005)(4744005)(5660300002)(47076005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:22:06.5355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32abcba9-957c-44e6-80b5-08dbb8397dc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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

Describe assigned-clocks for both uarts. SOM is using this functionality.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-clk-ccf.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
index 1ae8ea2e43f7..9c0aa073dd94 100644
--- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
+++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
@@ -253,10 +253,12 @@
 
 &uart0 {
 	clocks = <&zynqmp_clk UART0_REF>, <&zynqmp_clk LPD_LSBUS>;
+	assigned-clocks = <&zynqmp_clk UART0_REF>;
 };
 
 &uart1 {
 	clocks = <&zynqmp_clk UART1_REF>, <&zynqmp_clk LPD_LSBUS>;
+	assigned-clocks = <&zynqmp_clk UART1_REF>;
 };
 
 &usb0 {
-- 
2.36.1

