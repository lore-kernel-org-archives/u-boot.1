Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36091C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 14:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52A7987A65;
	Mon,  8 Jan 2024 15:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ukG7l54d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E59887A75; Mon,  8 Jan 2024 15:47:23 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B098D8794A
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 15:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUnvQmBdmVEoatoQMczmUbtuquxXyauALWBIrUGuGJKVf2ArSrM8MjNEHO2y+M/H52DtdYRpsrU0J/4vyIpL2VNApyZchMwMbezxlgW+hzfK7FmH+MeuWhlYKvoLCICax1VlwONRfwRnqZkFFteV30CbS0ddY9g/Gv8jLJkHHiTCsCCiQ5oVGRVi2D9xblKHQ+2eieB0ljesrWKxAHkFK2ujH90A+cdV8gq9mpkxTH/GNuD/O4dUNBtKdPZ3p2K9nMDMlHAtZ/p6lG9o3Trxk5ytnXEy+4E5uOYMM5WbIA2VlGqiBFVEGENQ0UrrG5HwAphEmkM6imofTAJ6DS5N6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGFXoEUb3o/0OC5iXq5QZO5MHBUNQLEyTkkGGIOxXYo=;
 b=mE4VYXQX+KczkL/vtURtIrQLklceEx9zDCwN9YN8s6hTzwQL2L1l0y9Vo9aHLS1qQ8mCKeueXXzcyhhDqTwcQiPXs+RFthmiTq+uDAWdZXoUSRQpUX1t097SNdMUxrhWd6ciWjz0rpLx8uWSveXUWLtGPOPaT5A4VHW4NBZRaVhPy+bCc5Ck0xzBeEKOpMYZrEvGRk3ZuBnPBEZk2tWnFvXMLma5u+QPdF1AyfEENrqU/paxsx6g5jWJ9+je+zhC8rP2WJF0kPfCilkffcHqTtCwBRBd5C9Btc6a2dJ8c5lHO0ZYQT8XdiLQIzuVhxHo4ibKcigwJe39uqDsIOXTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGFXoEUb3o/0OC5iXq5QZO5MHBUNQLEyTkkGGIOxXYo=;
 b=ukG7l54dIk2bMVylS/rxHPORK+SMKcd43iayn8FNDcnFbH0PVPBLY/XvRZtKe00Kaq6SwRMGqqMje6kY0fTCO0TWU8YMt9NlkwWiOnztImYe1HrUTTEiZtIYizIhV3inzoyo2DDzJjdhQEvUbfxc5y5pNv/6RccQIvIZ2rEQ1aU=
Received: from DS7PR03CA0055.namprd03.prod.outlook.com (2603:10b6:5:3b5::30)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 14:47:12 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::dc) by DS7PR03CA0055.outlook.office365.com
 (2603:10b6:5:3b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Mon, 8 Jan 2024 14:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 14:47:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 08:47:10 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH] arm64: zynqmp: Update the i2c0 node for zcu1285
Date: Mon, 8 Jan 2024 15:47:07 +0100
Message-ID: <3dfe8b41142de2e8c25c56702450ae1a6b1becc0.1704725223.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4660; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=TUKe4DiP9/dIcecovm7tCqrQaecJ7X2UiBjkREqs9Rc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ5XC9u7n6rqJvgaMnxeacT49Mb9y/7pSvM2VctJ/F6u
 WbqFfYtHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAii8QZ5rs/eZtWsWAWx7lz
 MTxPX9l33nNwf8KwYIpU9ElL31d8Guzi62bt2H+pVDVsCgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 398ba901-12e6-42d0-8864-08dc1058b275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCJmx/7IOwiAc1iltPX7qRtV1Lh1aOxkqiTuvBeMz+NPmosnlvuAkRoT0hW/f2DJyqha2CKBTrXeRR9MlT5DpVW0L0VXwGDD5NFzoNZjpvrQUqhse41HHC5IFZEDLip4nhS/0M/8wBlGECF/Oz5xjzb65nT7chV+MsC0Sy08/Z8jn7FIf97qU1SxuGyXsXfeGtCJsQ5LDCXBD+ns0Wyu7pjVpwSJZJU8mu34Azofi68yggge+DUE55b/v93Pct8NTI3JF6v4ay03EMenqsrhAbN21rUqEtqncDDYWb2+xtNf8DxnoHbdTDIzTcanLwFqcYPf7U30qUDtBDPrXflzIwD7vV/6TfmxKCk/a8PTcET9wiOkaWtoJZtMNHfSAJPErGKMFHcg0SiTB2oeyAtlHfP7Aky2LXJOQU6OTXBKIUzUlrnsRCPfS2Zqz8+i2ClD38E6A8/D6T+Iy5ap6CihkZn9fqzqkgCFhV1RW9gm4q2FK4V5rwpLNUWPbWCTm+il7xx5G3ksOCLgo0P9R3WrCu2B7GaCgv0rYqB1+x0A7iq5C+GWI5KMEFxoYl74kCETo8Bg4CnudlutlZwh0OgD00qOp6CYZFPTG0hivPA7c4gdhm5AeRnOpOswGMy1AWu9ttzCSy5sPJUeGw4sEBy3uckeH6rEwlDcdNN4Nzy2GL36f/3fE0mT9OIgbP/PNr8XS395Xqh0q6VVUJ6NnJAcv5REVsuX+J4ArhFJvDOmYrKEraGVDVQoR5CEdzlb1wNITxFC4uExITF1id14r5jOhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(40470700004)(36840700001)(46966006)(336012)(426003)(36860700001)(82740400003)(2906002)(47076005)(86362001)(41300700001)(36756003)(81166007)(356005)(316002)(110136005)(6666004)(70586007)(8676002)(70206006)(8936002)(478600001)(16526019)(83380400001)(5660300002)(4326008)(44832011)(26005)(2616005)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 14:47:11.6356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 398ba901-12e6-42d0-8864-08dc1058b275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428
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

From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

The pca mux is not added to the i2c0 bus so remove it from the bus.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-zcu1285-revA.dts | 174 ---------------------------
 1 file changed, 174 deletions(-)

diff --git a/arch/arm/dts/zynqmp-zcu1285-revA.dts b/arch/arm/dts/zynqmp-zcu1285-revA.dts
index 4f85837e64f6..38735b1ce1ac 100644
--- a/arch/arm/dts/zynqmp-zcu1285-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu1285-revA.dts
@@ -37,26 +37,6 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
-	ina226-u60 {
-		compatible = "iio-hwmon";
-		io-channels = <&u60 0>, <&u60 1>, <&u60 2>, <&u60 3>;
-	};
-	ina226-u61 {
-		compatible = "iio-hwmon";
-		io-channels = <&u61 0>, <&u61 1>, <&u61 2>, <&u61 3>;
-	};
-	ina226-u63 {
-		compatible = "iio-hwmon";
-		io-channels = <&u63 0>, <&u63 1>, <&u63 2>, <&u63 3>;
-	};
-	ina226-u65 {
-		compatible = "iio-hwmon";
-		io-channels = <&u65 0>, <&u65 1>, <&u65 2>, <&u65 3>;
-	};
-	ina226-u64 {
-		compatible = "iio-hwmon";
-		io-channels = <&u64 0>, <&u64 1>, <&u64 2>, <&u64 3>;
-	};
 };
 
 &dcc {
@@ -67,160 +47,6 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
-	i2c-mux@75 {
-		compatible = "nxp,pca9548"; /* u22 */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x75>;
-
-		i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-			/* PMBUS */
-			max20751@74 { /* u23 */
-				compatible = "maxim,max20751";
-				reg = <0x74>;
-			};
-			max20751@70 { /* u89 */
-				compatible = "maxim,max20751";
-				reg = <0x70>;
-			};
-			max15301@a { /* u28 */
-				compatible = "maxim,max15301";
-				reg = <0xa>;
-			};
-			max15303@b { /* u48 */
-				compatible = "maxim,max15303";
-				reg = <0xb>;
-			};
-			max15303@d { /* u27 */
-				compatible = "maxim,max15303";
-				reg = <0xd>;
-			};
-			max15303@e { /* u11 */
-				compatible = "maxim,max15303";
-				reg = <0xe>;
-			};
-			max15303@f { /* u96 */
-				compatible = "maxim,max15303";
-				reg = <0xf>;
-			};
-			max15303@11 { /* u47 */
-				compatible = "maxim,max15303";
-				reg = <0x11>;
-			};
-			max15303@12 { /* u24 */
-				compatible = "maxim,max15303";
-				reg = <0x12>;
-			};
-			max15301@13 { /* u29 */
-				compatible = "maxim,max15301";
-				reg = <0x13>;
-			};
-			max15303@14 { /* u51 */
-				compatible = "maxim,max15303";
-				reg = <0x14>;
-			};
-			max15303@15 { /* u30 */
-				compatible = "maxim,max15303";
-				reg = <0x15>;
-			};
-			max15303@16 { /* u102 */
-				compatible = "maxim,max15303";
-				reg = <0x16>;
-			};
-			max15301@17 { /* u50 */
-				compatible = "maxim,max15301";
-				reg = <0x17>;
-			};
-			max15301@18 { /* u31 */
-				compatible = "maxim,max15301";
-				reg = <0x18>;
-			};
-		};
-		i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-			/* CM_I2C */
-		};
-		i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-			/* SYS_EEPROM */
-			eeprom: eeprom@54 { /* u101 */
-				compatible = "atmel,24c32"; /* 24LC32A */
-				reg = <0x54>;
-			};
-		};
-		i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-			/* FMC1 */
-		};
-		i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-			/* FMC2 */
-		};
-		i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-			/* ANALOG_PMBUS */
-			u60: ina226@40 { /* u60 */
-				compatible = "ti,ina226";
-				#io-channel-cells = <1>;
-				label = "ina226-u60";
-				reg = <0x40>;
-				shunt-resistor = <1000>;
-			};
-			u61: ina226@41 { /* u61 */
-				compatible = "ti,ina226";
-				#io-channel-cells = <1>;
-				label = "ina226-u61";
-				reg = <0x41>;
-				shunt-resistor = <1000>;
-			};
-			u63: ina226@42 { /* u63 */
-				compatible = "ti,ina226";
-				#io-channel-cells = <1>;
-				label = "ina226-u63";
-				reg = <0x42>;
-				shunt-resistor = <1000>;
-			};
-			u65: ina226@43 { /* u65 */
-				compatible = "ti,ina226";
-				#io-channel-cells = <1>;
-				label = "ina226-u65";
-				reg = <0x43>;
-				shunt-resistor = <1000>;
-			};
-			u64: ina226@44 { /* u64 */
-				compatible = "ti,ina226";
-				#io-channel-cells = <1>;
-				label = "ina226-u64";
-				reg = <0x44>;
-				shunt-resistor = <1000>;
-			};
-		};
-		i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-			/* ANALOG_CM_I2C */
-		};
-		i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-			/* FMC3 */
-		};
-	};
 };
 
 &gem1 {
-- 
2.36.1

