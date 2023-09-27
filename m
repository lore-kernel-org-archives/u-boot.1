Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE91DE810B1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C98886DA7;
	Wed, 27 Sep 2023 11:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="POrtaEor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5560086DD2; Wed, 27 Sep 2023 11:53:51 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 566BB86DA7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2++mhaF8odP/c2o2QMJyIyylSd0Go+dYMBwCqPzZJpJq2C86zzleQVgAxgwGcUkgHt1TGdCB4LLNoNDKbwcWMVz1CpAQWdvekQ3PqyDqTbbW9recc9WsfrvofplZFmjNVbJOBVQuZwfgxgMfCmBz6DYn12tm/jF8eLJsBIvEQyGyr7qEh18WPgZDcF0MRh714HLcR9A6S7JnHnLrF1FlLi4aCdAR2vlCjXSD6b5WhqKSv4LlnLardnWJYU2NEyRREuZ8ffVy9cRBBWPS2Shhl8PhKKsXPh6VUxoHJbWzJ0jErc/LmVvDV/kMoXPe+a/pk6599jaT5YHL2PGFwDywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oq4B4KVydOcl9jScOqyyXywe7GQCkg0yQGrdr8o3UNM=;
 b=mdP7VC29cbUd6hiDjd1XwEUk4TLaTtvFe1UsyFOgexDM7oXVC/ssgRGELU+ldY9vxQoVw1FGPKsawkQWnn/Aqjk5+tOKkRXMT+bM6daWCm5M+dXSDHWUcij82r5Mfa9F7xzFusPItA2JVVlTntgg1KYAAZ/XHO538/CwoXMA465SwzIMe8SEo6eCtm6qkYy0AGi2TAcOXYCKqpzzxkVmEyPke88ndrPMoHVRQNumjZ4mHr9W0kYpcCd0+b48HMhCAc/ZR44ufexAFG9AoDSfJVTqHQDk6FiMOHmaszuLpzFxGO82VYIN41wEMWU7ToepgrOPHv8AC8UHIdnPWb0S+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq4B4KVydOcl9jScOqyyXywe7GQCkg0yQGrdr8o3UNM=;
 b=POrtaEoro1PtobgbPUBtK2iTQLQpvZ7d2cdVR3vdc6qLBywAW/M7H6ozXsfT08nBvepLQvHhZ3zKGkqcoleLnl47Z/2oaVfuyxmQe2tNnV38zPKJCGhtJ4LE/mYN7bIcpx1Jxnc8x1nTkNZQbSn47CjjR4OdaPs6JkllWu0hJKc=
Received: from BLAPR03CA0157.namprd03.prod.outlook.com (2603:10b6:208:32f::27)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 09:53:46 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::6e) by BLAPR03CA0157.outlook.office365.com
 (2603:10b6:208:32f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 09:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:53:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:53:44 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 02/11] arm64: zynqmp: Remove xlnx,fclk nodes
Date: Wed, 27 Sep 2023 11:53:28 +0200
Message-ID: <b25dedd066f587321751d7d20c1f65bb96c53b89.1695808407.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695808407.git.michal.simek@amd.com>
References: <cover.1695808407.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=qCWuCQXbEaqfDYbBmWjjG7xTYQPq0BKRtyXIn/RFsms=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTh33NWl8iFLuOfeziWw0Frf0q3+aIz3LERPAY6ZyQ1l
 vH+dErviGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABN5u4dhwex7Jf/EDhY7F09l
 2vS1JHil+/2DwQwLpl5hKVt7Zf8S7s1Tlfpv3pS7vChtOwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d30a43b-096e-44f5-af1e-08dbbf3fa3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yS4KR1CS+eFFFqp3Cp+6N9aBx7ObqChSHG7KBLnanfaEjlSuU18aEIE07sL+Iw0ARZ+cyR4PL+L8PrDOa1lF46/nIySlBukp46rY5/KvzaWlkYP21vWWLwCqbIEV45CzFNRkUr7M59AmMOS9qO0RY99zWu/bBGTbWQ8L30Yxdbp887H88ta1r6lbA2nsDiplTJwH0u1/jzWKv0O8hwUuXakshfmHSNeg0wij3GMrEItYl0OJJJJ0Bb5Ayd4TPrciZvHXGSS550fne9fwct+h5+BNQ5moY+L7cYCEmBtB5dlLx3UH9lHVD+NVGbaB8dewj+gQGW40PgFIJrQq9BDVHrMtsGI8AG7kqQpmvUNAknlnyKAxxMuGXdTNtE6u202UrNSvfTpoUDSgkPW+H7FQXRZkExyBm0qqN0mIgG3oljckFlh4SNpPhz+jlMM1GtTMs0N7yjTAMiyou5miXa/oQKlhw6vDgYA14NWVQot6ROpMONPZZDTL8aZHlWDa8jy2MaFnzxUDzEt3N5EfQcoCM9b+qYXCdeCby5BQb1H5QdnvzTTIFgmfnY8iNbDYQ/69vY11rlwfqiQCFYNzuy8RAXns8XNI0ej8D5zl+RN81WFKXk3FgzZ/0WNPJzBM7xnzJ7O6xUatcnIpvvz+MptsKlOGWFhSpv7+DDH7XVYBjGhPZe/fsxAUj80GOn2rFuRvXOuN2OXtpRermNnaHZS3ZRttOqh/U0Y5p7z7RsB6yo9tsdAuVmxcUrlOMvkDcz+Ev0AGa0coeYo0H79acXx0rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(6666004)(83380400001)(426003)(16526019)(81166007)(36860700001)(82740400003)(36756003)(40480700001)(26005)(478600001)(44832011)(47076005)(336012)(4744005)(8936002)(70206006)(110136005)(2616005)(40460700003)(2906002)(8676002)(5660300002)(41300700001)(86362001)(356005)(70586007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:53:45.5057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d30a43b-096e-44f5-af1e-08dbbf3fa3d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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

xlnx,fclk nodes are not described in dtschema that's why remove them.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-clk-ccf.dtsi | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
index 4044b62d27a2..5f1b0b23c124 100644
--- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
+++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
@@ -16,24 +16,6 @@
 		clocks = <&zynqmp_clk PL0_REF>;
 	};
 
-	fclk1: fclk1 {
-		status = "okay";
-		compatible = "xlnx,fclk";
-		clocks = <&zynqmp_clk PL1_REF>;
-	};
-
-	fclk2: fclk2 {
-		status = "okay";
-		compatible = "xlnx,fclk";
-		clocks = <&zynqmp_clk PL2_REF>;
-	};
-
-	fclk3: fclk3 {
-		status = "okay";
-		compatible = "xlnx,fclk";
-		clocks = <&zynqmp_clk PL3_REF>;
-	};
-
 	pss_ref_clk: pss_ref_clk {
 		bootph-all;
 		compatible = "fixed-clock";
-- 
2.36.1

