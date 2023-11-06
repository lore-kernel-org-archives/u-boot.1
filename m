Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34FEC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 15:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 262DE86B18;
	Mon,  6 Nov 2023 16:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NMoWmNz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F9F869CA; Mon,  6 Nov 2023 16:56:03 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F6E86E40
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 16:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqkKIbKHMY4PG6Vu6BUZDTZBaU2at025eV3OtDMTBB4KJQ0FiKF+BgHDIhmJcgJBuaW3Mx1EUW0J3Q9uPVdFmrwMUbLyVWdosfE2uZ0l+6mKWAIvx4w0bHe54Ou6iaWhmSh0cP4U6QtzL389O88uUQAWU8EFmcgZbrFo2h8A4zjC3wh1oMc3Om9aCIY+iMMPI4QMZtSgdXIg9AKPKe1WfmK4GaWqQkTsmRz49scVKioVyavzTYhj5/fagqqqsaUHXsctpeIAlZ7Nrd8QFKoV3Palkaui2rYNk+v72na+945ZF1RaN8vjAh2w5oAwUZ9FVTDmHYH4SBtmeVo6C+dCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qaYplr122p1ALdTTYO/aT8a8XPZkupuUZOG2bXwADQ=;
 b=BgAqWxSBGaDxZt9V1Q+MM5loUKIYWFp2Dtqup8fWWlcu3mavKObANoUVNBzj4P0qvZQjQwP6FFCt8VsCupooWNc+1jtroUBpXYy+7F+7fPXywZNF00Lb/sdnGpzE+2qC0T6yFPg01H38AEgFp9zyxtqeOW0T8DjjsCJOVHJmgaENDeqf8jk4/1Z0oLMndeMrF5Y9eguxuZQRNlp9+wzHPGby2kwat0CVvNAzHuOR00qb86pAnVSWpoaVNrSRBtVHV+V58JAqOR480ZrcmE30q0z613sgDZ6bJ34gCOLzI7tW37G83Eu0L2jk1ZlvRpaa6kaiAg5MFpVxHIhS80jRfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qaYplr122p1ALdTTYO/aT8a8XPZkupuUZOG2bXwADQ=;
 b=NMoWmNz80DFgGzxEXgXP2C6iiCrHMss35DoB+3bxBAGasPb0FpiFdz0wRTC8k2+lWIhXDV6qfX+HqVlByuLrZFXrGEWWTq+zhe7MWAmUB/1YIQ9etQcvGwmolKYvqh5+yDH4T7ExYOBFckf86wiAb6spWJJb3cB7RtskXfQHqIU=
Received: from CH0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::20)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 15:55:55 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:610:11c:cafe::22) by CH0P221CA0024.outlook.office365.com
 (2603:10b6:610:11c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 15:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 15:55:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 09:55:50 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Do not expose usbhub nodes
Date: Mon, 6 Nov 2023 16:55:48 +0100
Message-ID: <537c91a7ac0843358c4e33aa10d9e035d8e92faf.1699286139.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3615; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=JbOyQJA96wiK5zFOETeUtbcgq3Bp5xM9/V77ojNHLfQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlRPnppPt5Ly1xYsTW0rKb6pNb2i5uXlr56Hz0zwuaTuk
 rZy7/q8jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRy1oM83PupSfWn3kt0pa4
 8ozzO8Pm2Yf9NRnm8An7esimLzBYcYmtsVvl9cU7Ag9mAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db012ac-b53f-4370-c82a-08dbdee0daa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wknCpit7N68KUquNKYroI/+xN+amF/VTdTaTFSTn9rZK/Cjv9fhiZrb/1ZM9rsPBkpBzJMb1gSw6rXIwhzTvf5It9ukrTmYl+hGuiy1P7Zqgn7FiesCVkhV/q00xvMj8RXGXc9STbJIBdtKWq6L5bOnalJ0IYGDP6+Hcwwng+VunbSp7D6qXDZymjHczkXAPymtEF+Wykfi3htzOKyD64BV+/aBeFCAmQ4C9seSp0K3r5eGn+51yLX2cMHjH0oAqqR7wR06MOthg433TTKvT40PHNzV2BSuFa7lYyqMvlvatnsZdDDcozRilNRM5H3z8KnYVtulNjj9xCce0mZycDV91EVANe1ojLw8oIyXo+U7Ep2IUT3Dr/ViT90ntcnvzcdOeVZdgrDkxlPU9IoYLePzGXqSRX+U7kM8DZ5KzLsjWUrM1P9h+n+HD7ZE1Azt+oJYZbwHY/70Pdm+illH7ySd0RsI/5FbVnzNz4KVkWPBy2LdVzb82rdT8s/mT9FkMKyDXlAp/wFwXTmB3vo3033Sr/KjeC/pkvhVcsJK12I+Qo3eEiVvaE0/3EouXf/YaOrSdb28HcksKIyGj+75lMJTH1+iGh0gctWPGzmox77OUQTRT2Vc6IFGAp8kL69g0I9+CjKqTqdwcar9BlB5NYmLaFYoGQcsawwFxXnQo9MgncQDKNiDBQTVIJDK9kGQs0zyNhWAdnA4NXgtryA+M7cvit8h20MMv60D8ZKn8/QGyPdZ/ZLRKMcB7eW/Hj8v+8cK779gtuo6e/7A3fSV9HA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(26005)(2616005)(16526019)(336012)(426003)(41300700001)(47076005)(36860700001)(83380400001)(8936002)(8676002)(2906002)(44832011)(5660300002)(478600001)(316002)(70206006)(70586007)(110136005)(356005)(81166007)(36756003)(82740400003)(86362001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 15:55:52.2829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db012ac-b53f-4370-c82a-08dbdee0daa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
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

Upstream dwc3 U-Boot driver is not able to handle child nodes properly
that's why comment them in DT for now. This patch should be reverted when
dwc3 driver handles it properly.
DT node itself is aligned with dt schema.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 3 ++-
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 3 ++-
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 3 ++-
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 2 ++
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 3 ++-
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 5a5c1efd6b96..8d0ddecdc14c 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -87,7 +87,7 @@
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
 	assigned-clock-rates = <250000000>, <20000000>;
-
+#if 0
 	usbhub0: usb-hub { /* u36 */
 		i2c-bus = <&i2c1>;
 		compatible = "microchip,usb5744";
@@ -98,6 +98,7 @@
 		compatible = "microchip,usb2244";
 		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
 	};
+#endif
 };
 
 &dwc3_0 {
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 30a0230d4767..95b1dc5aa571 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -139,7 +139,7 @@
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
 	assigned-clock-rates = <250000000>, <20000000>;
-
+#if 0
 	usbhub0: usb-hub { /* u43 */
 		i2c-bus = <&usbhub_i2c0>;
 		compatible = "microchip,usb5744";
@@ -150,6 +150,7 @@
 		compatible = "microchip,usb2244";
 		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
 	};
+#endif
 };
 
 &dwc3_0 {
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index 8f4c52d6d643..e2387a2abb8f 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -139,7 +139,7 @@
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
 	assigned-clock-rates = <250000000>, <20000000>;
-
+#if 0
 	usbhub0: usb-hub { /* u43 */
 		i2c-bus = <&usbhub_i2c0>;
 		compatible = "microchip,usb5744";
@@ -150,6 +150,7 @@
 		compatible = "microchip,usb2244";
 		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
 	};
+#endif
 };
 
 &dwc3_0 {
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index c4f1da92186f..f43c159cdca9 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -131,10 +131,12 @@
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
+#if 0
 	usbhub: usb5744 { /* u43 */
 		compatible = "microchip,usb5744";
 		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
 	};
+#endif
 };
 
 &dwc3_0 {
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 6c5e0e566061..3643569cc7c8 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -113,13 +113,14 @@
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
 	assigned-clock-rates = <250000000>, <20000000>;
-
+#if 0
 	usb5744: usb-hub { /* u43 */
 		status = "okay";
 		compatible = "microchip,usb5744";
 		i2c-bus = <&i2c1>;
 		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
 	};
+#endif
 };
 
 &dwc3_0 {
-- 
2.36.1

