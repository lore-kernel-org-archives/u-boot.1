Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598ADC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 11:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE218773F;
	Tue,  9 Jan 2024 12:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5b4Dfne/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E49287871; Tue,  9 Jan 2024 12:26:58 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C56807E2
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 12:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b648ijWtaKzW3qjMz1AyvBJ1OGLmQjJMDxfltfgKYxzdZvAOidsl2ChxUJpQ5stJ1Z0A/NIxFWUq/ID53TrnBI4yYUzhenjv7Tt/lvPCMkwi6sL1+fyPbDQxBqocyUKpA2slmG/zNqVNXZ0cS+XmosbBmQWdENF1QvNiOfDuf29qDaIzmEUldAidQWUOMiGYdIdXE1uRkcRG5cAjZaULldkl8eppAClXDFaqgzFStNhr3tBEf6ZDPC7lYVBB/gi/dJ87tOrBYMx48eUlm1k+DSAHDrXikzWjdaT28H8VRDcCEcGXWx5VlGvJkH/Dzx6dIi80shWTFwtSjy2WG7SLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwQWPpba12G160cOGlN+NFOoyGfXrZ67RogGaYrLaHE=;
 b=nlkYIkTxffXeCPYGPPzUiHzVnCGQJwdc+HEpZquGGyYl2+4DIR+Dfpe0881EYtEJUjIN7XipPWpAjMFXw/XKuCRduZZxtPZRw7EoxlMM9hioGctLpQj38pfK1BAC3F1sSp3wA4dqlijMDzxwt4MtzcZrOv4wnXw4TC8pDxYpe8QY4KNBWfsQwZCUY5bDcs+QkrhcZYerAPRlWiuSzHwUCXJ1PYndu43qPvTwFbf3wTzmmDy9XMxQfnNES8aVdvyC76x8mmImQp0ec9ZyfhSV9zfaRApOmeYRGh5LhSdzEfwVGQtAabC4gIKNuhKo55hYjY22CSjpFXtCesLdVCy6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwQWPpba12G160cOGlN+NFOoyGfXrZ67RogGaYrLaHE=;
 b=5b4Dfne/ix20e0ZUA0rPG5HBpvyR9ySPsdOQL4Fg/UeoOSIqV5D6QfWAeRe0owiAIbQHUghL5Cx0msoEEjEjqndAONoGcAET7S8nlrVxolJqZxxcomceRsIqYETjHv9LXtVkrvaBCceUOLm4GimE1vYxYyH5tNemkEm17gNAxW8=
Received: from CYXPR03CA0043.namprd03.prod.outlook.com (2603:10b6:930:d2::27)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 11:26:51 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:d2:cafe::83) by CYXPR03CA0043.outlook.office365.com
 (2603:10b6:930:d2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 11:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 11:26:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 05:26:46 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH] arm64: zynqmp: Add missing description for efuse
 aeskey/pufuser
Date: Tue, 9 Jan 2024 12:26:10 +0100
Message-ID: <9975c501c92d8e9d6e307dfd3f4146e08a2fc68e.1704799551.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=811; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ubHGgUZIEptVvwwfz/KAjw1i9uBm0WBqEJ32MSAr9zI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtS5ug4bxZlTI1ebcXa8P/m7ftOqavUrGotO2eskXfDfH
 3rwd8S1jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCR1dcZ5nu6lIVPe2UStNzz
 e+N6/9/XNqtd/cUwz87mfM4muaaAplZL5xleq471iFdMBgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d77ae85-ef64-4329-6e56-08dc1105e039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxPZpc8K2RenLQHnZM9AwxF7jsbTi4LjoEchoAIYa2SBCkF3VTGftv84MyoiV7yfREcEJGVPUoW6hwOo4g5tb27SGAlYtHbORV1AvMYyeJ4azNIFhPkgum6tuQcFR7yvfB5uLA1UVTiXaUB4Q8/DA58uQ1o5j1eUdhkufKLhF2Tv/soCaM4OFSqTqUID/PGDTWx5MjpMOeCiL7vkvIs90WBYrdL7sA9lf1vwaRXh4FLWdI53hfmNQYjsh4qmw65Ytj2IB5gyU/reQQcfVYS9TTPs51cPd3+a9yzrdvsgkLSPRrNwPXLl7+omsHKcqUgodFCg5jQYguUqAakB76QXkbQbz1XUYXohdu4LAy4QLtPfcJo0nmAZE8Tdvpe7S+p34ZkrIz52V8V+uTJtR8PjbmSbPoKwKEZM793ficlHJBwEFM48U1Ew1kuokvon24xW8g/IikrPe0lBHzLPrzKCDQOODu82JD4F/c93mAgF+QYVQKiUcMcS6nkAgT7R50UMVYTQBNRBUZoM24IOPjSwBnuWCdW5uMuC5BrmFBCdzFPAHRa/a4DWLgr5uozy38zIbKcjudC056sIXgbK49CEke6jtNkS4gsF1eUu81wFhcNm8PX3WDoEjeVmfUgKtFhJPLxoZ8DlcWtUQDbnbTxOQWMErQWZZCaSlFEXjGcP1SWFkjQQ0ap25vK7l22GMk561gmiPHVbPUcNix+1SQS5iMEMNcXntWU5zY2X13Si/qY5kVNXxm6e7fxhy0Jr5b+5yEjRyFQvPZKjPKpvSlphsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(356005)(110136005)(41300700001)(36756003)(81166007)(86362001)(82740400003)(36860700001)(47076005)(26005)(16526019)(426003)(336012)(2616005)(6666004)(4744005)(478600001)(2906002)(70206006)(70586007)(316002)(54906003)(4326008)(8936002)(8676002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 11:26:51.3199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d77ae85-ef64-4329-6e56-08dc1105e039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
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

Add missing description for efuse aeskey/pufuser offsets.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 21be909b1abe..f31f244ba77c 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -258,12 +258,18 @@
 				efuse_spkid: efuse-spkid@5c {
 					reg = <0x5c 0x4>;
 				};
+				efuse_aeskey: efuse-aeskey@60 {
+					reg = <0x60 0x20>;
+				};
 				efuse_ppk0hash: efuse-ppk0hash@a0 {
 					reg = <0xa0 0x30>;
 				};
 				efuse_ppk1hash: efuse-ppk1hash@d0 {
 					reg = <0xd0 0x30>;
 				};
+				efuse_pufuser: efuse-pufuser@100 {
+					reg = <0x100 0x7F>;
+				};
 			};
 
 			zynqmp_pcap: pcap {
-- 
2.36.1

