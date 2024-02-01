Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DD6C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 12:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D90187CB7;
	Thu,  1 Feb 2024 13:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A9XB+6+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886498786B; Thu,  1 Feb 2024 13:39:07 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD82877D7
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 13:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8o6eLFvsLfeogG3DjwRXBftWORSuIMRpZCWR9SO/JqCAvqIwaT2Nj0fxlxz1iyL90+yDifMxI/MarOV6FSZyMYYwlaxQWul6jCQODUop+H/BpDrDcxqEyL9FHAwNdsyGqeBxBUdknC6pM0pQYxflmAenyOXm+IyjCOHoK6qFEsEWywFeepZ5/80wbxI5fApyLJe400hviwfWC3qnts+Ta8D4mrvXWo22sIcqII6oQNshRJsUQRLSbao/1RK32M/Oa3zRwHFnX01aj/QOxgxu5YJhY10daEYhIVp+XX+EC3tMebwBa8nTRfO3JkOQLDdBakc2aXEGgsey6Z7NetXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRiyvPPWdF50PkMxdSe1lj30mO0vRoaJgv29jPck2eE=;
 b=QXtrJUepDXhKVjKpi4v9PujTM2FXDe94ux0GTTsB0OMCHQ7ES4XkVnVONcOmPojnm6feVJr2lYEvt1/DDDds05Rsktuu2b1riZRJ3JZtg9WbbnnqI/SrRQ6AwBPkE+nMxomGdEBgzReUWh8+yClUDm8Ty9/jdZCcSzS7eWs+wGVqD2Bjv6M558khp1bF6kIfIKBlQB/0iBEbnn78TrLLkGumS/7heqhsRl8L303L6fWdwC2CDFFTZ5t9xgHIXUZosQpD6QoIqoCnlkomF2mwdoNXR8UYtZG3C6yrSW9+CiTiPh9h5jTJu7J8lXCGK8E/6SbiIuiE85wXn5RF9Rdsxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRiyvPPWdF50PkMxdSe1lj30mO0vRoaJgv29jPck2eE=;
 b=A9XB+6+h8zi/1dX69vwnj8wDWMSjAXUlnjAxjd0p5J/T2elNMfQ/yogXiTTZ2kprydSFO+TFW1ZV3W20GzCKz2FNxh6s7qTOC61VErayQSCoHdQZUik4dR3ADdNYyqVxfltGbMrGl7IsSpniGjA4LkKM1KuUgAb0MtFSGP1N0dE=
Received: from SA0PR11CA0021.namprd11.prod.outlook.com (2603:10b6:806:d3::26)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Thu, 1 Feb
 2024 12:38:57 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::86) by SA0PR11CA0021.outlook.office365.com
 (2603:10b6:806:d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Thu, 1 Feb 2024 12:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 12:38:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 06:38:55 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 3/5] arm64: zynqmp: Align nvmem-fw node with dt-schema
Date: Thu, 1 Feb 2024 13:38:42 +0100
Message-ID: <32899b20c1e282aab16c32074b1c9a3f45f6dac8.1706791116.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <78e6e3f287f79917eb92c6c74accbaf955526aad.1706791116.git.michal.simek@amd.com>
References: <78e6e3f287f79917eb92c6c74accbaf955526aad.1706791116.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3597; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=f5Y2Iy2fEGC0U0pBfziKv4RGePQ257QJxplue3hySDA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTdEy6WfC4zehHq5/DKfQNLh2rGY8UH3t2Vfza4cr/2a
 J62Rf1WRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhIZxTDfE+hSZNDX95+uv7o
 u65Jjr3+m2+nlTEsmPqdo0JDtnxt8eUX2tGXbDbf5N38DQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 367af620-e143-4049-9cff-08dc2322c1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwGmm0T+SgmBhzvxZwOW5Bh/Ux5beLI1po+0IjHgWfKWQ7yisz7QCkn79/0qAhxCDD42FezmWJvMrQJIbxLEOOZehbn5qpfTpKi7t5EusXAlT1vhAfl2cwqvJ4pXbyM3SjLgJ6QGD/vPXXj3UA4UXEdAFQpceM7k0xZivN/hWYwHkw2W1E12YbGsEAYV0jkeops/IboJXz/XgflhglO4yuwf+y9HSUlXW3xeS84CmLSXyqWx9nCSlgoDH/0JOJy5Tv8wLvJ27Eo8qq9Thxqqr9WGI3Xbxy+cSTfSs6X2SiKcbHrCbQdrEi9gN4gh6EeeXEU1teEO0FXCCxbxMo5lhI0BV7yQrAKoPfo5bIKx4zzFcDfcWd6nMRrNDzArOekLzlbQMMhlLNuIocF0s3cu9aW9q0zq0bkIZZDlu7ALSJ1DFiNUk01JsRHW8feE+OJ/jFml8J5gIBSkvg1fbh+KquoExWVaE2uUmDSP7wEL/IELNHit78iwrg2mEzJqANlf2NdMHBo81/Cstb2Bgn9sPE51NVKcJFJPj7NoHZ558aw16TKOgx0wPmH3dkQfyJuXvDPCwkTH5y4GzBVPax8VJEB4tlhu1NM7sjly9LZRsHRDiiTbrUq98kvOKq+Y8lKGP7ciYWxTS3fqkSp6bK4ACT01k0CA1D8VjDEkBV2i2w+KLXJ5dpinT2pkT+oBKHRaM+6GiUOz7MSomkbr9LVo8+unkKHp8FrywfqoHzh4/RScuh7Od5UCLZcGtTJV6DQvzyRswJ/0tPN1Q/dnEVIKzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(16526019)(426003)(82740400003)(26005)(2616005)(356005)(336012)(36860700001)(110136005)(44832011)(5660300002)(8676002)(8936002)(4326008)(2906002)(478600001)(54906003)(6666004)(81166007)(70586007)(316002)(70206006)(41300700001)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 12:38:56.8880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367af620-e143-4049-9cff-08dc2322c1f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836
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

Node name has to be renamed to be aligned with dt-schema and also
xlnx,zynqmp-nvmem-fw switched to fixed-layout.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 125 ++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 61 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index e539fa329e19..855a97077d98 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -207,68 +207,71 @@
 				mbox-names = "tx", "rx";
 			};
 
-			nvmem-firmware {
+			soc-nvmem {
 				compatible = "xlnx,zynqmp-nvmem-fw";
-				#address-cells = <1>;
-				#size-cells = <1>;
-
-				soc_revision: soc-revision@0 {
-					reg = <0x0 0x4>;
-				};
-				/* efuse access */
-				efuse_dna: efuse-dna@c {
-					reg = <0xc 0xc>;
-				};
-				efuse_usr0: efuse-usr0@20 {
-					reg = <0x20 0x4>;
-				};
-				efuse_usr1: efuse-usr1@24 {
-					reg = <0x24 0x4>;
-				};
-				efuse_usr2: efuse-usr2@28 {
-					reg = <0x28 0x4>;
-				};
-				efuse_usr3: efuse-usr3@2c {
-					reg = <0x2c 0x4>;
-				};
-				efuse_usr4: efuse-usr4@30 {
-					reg = <0x30 0x4>;
-				};
-				efuse_usr5: efuse-usr5@34 {
-					reg = <0x34 0x4>;
-				};
-				efuse_usr6: efuse-usr6@38 {
-					reg = <0x38 0x4>;
-				};
-				efuse_usr7: efuse-usr7@3c {
-					reg = <0x3c 0x4>;
-				};
-				efuse_miscusr: efuse-miscusr@40 {
-					reg = <0x40 0x4>;
-				};
-				efuse_chash: efuse-chash@50 {
-					reg = <0x50 0x4>;
-				};
-				efuse_pufmisc: efuse-pufmisc@54 {
-					reg = <0x54 0x4>;
-				};
-				efuse_sec: efuse-sec@58 {
-					reg = <0x58 0x4>;
-				};
-				efuse_spkid: efuse-spkid@5c {
-					reg = <0x5c 0x4>;
-				};
-				efuse_aeskey: efuse-aeskey@60 {
-					reg = <0x60 0x20>;
-				};
-				efuse_ppk0hash: efuse-ppk0hash@a0 {
-					reg = <0xa0 0x30>;
-				};
-				efuse_ppk1hash: efuse-ppk1hash@d0 {
-					reg = <0xd0 0x30>;
-				};
-				efuse_pufuser: efuse-pufuser@100 {
-					reg = <0x100 0x7F>;
+				 nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					soc_revision: soc-revision@0 {
+						reg = <0x0 0x4>;
+					};
+					/* efuse access */
+					efuse_dna: efuse-dna@c {
+						reg = <0xc 0xc>;
+					};
+					efuse_usr0: efuse-usr0@20 {
+						reg = <0x20 0x4>;
+					};
+					efuse_usr1: efuse-usr1@24 {
+						reg = <0x24 0x4>;
+					};
+					efuse_usr2: efuse-usr2@28 {
+						reg = <0x28 0x4>;
+					};
+					efuse_usr3: efuse-usr3@2c {
+						reg = <0x2c 0x4>;
+					};
+					efuse_usr4: efuse-usr4@30 {
+						reg = <0x30 0x4>;
+					};
+					efuse_usr5: efuse-usr5@34 {
+						reg = <0x34 0x4>;
+					};
+					efuse_usr6: efuse-usr6@38 {
+						reg = <0x38 0x4>;
+					};
+					efuse_usr7: efuse-usr7@3c {
+						reg = <0x3c 0x4>;
+					};
+					efuse_miscusr: efuse-miscusr@40 {
+						reg = <0x40 0x4>;
+					};
+					efuse_chash: efuse-chash@50 {
+						reg = <0x50 0x4>;
+					};
+					efuse_pufmisc: efuse-pufmisc@54 {
+						reg = <0x54 0x4>;
+					};
+					efuse_sec: efuse-sec@58 {
+						reg = <0x58 0x4>;
+					};
+					efuse_spkid: efuse-spkid@5c {
+						reg = <0x5c 0x4>;
+					};
+					efuse_aeskey: efuse-aeskey@60 {
+						reg = <0x60 0x20>;
+					};
+					efuse_ppk0hash: efuse-ppk0hash@a0 {
+						reg = <0xa0 0x30>;
+					};
+					efuse_ppk1hash: efuse-ppk1hash@d0 {
+						reg = <0xd0 0x30>;
+					};
+					efuse_pufuser: efuse-pufuser@100 {
+						reg = <0x100 0x7F>;
+					};
 				};
 			};
 
-- 
2.36.1

