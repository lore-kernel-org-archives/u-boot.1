Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B242C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 11:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55341875A4;
	Sat,  9 Dec 2023 12:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cuh1DHfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CFD7875B5; Sat,  9 Dec 2023 12:07:03 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE2448757F
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 12:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEPYwr/9hkYyxph4dgMXLgHwdmXCjfP1/toGlRPdm5sYnlsZXF4es5q14r6FrdhX4bLa9irp/ZMNcnuoAv7o3ELwKCZN7c6pf0gl7G0Q5e8y5oEjdVB7ROO5C73xc1R3RlYt32fhkiZMKbIjgfsiUdKJVNKyWhFJJMlVR3yyzu4L0lN6JUCyYsoK3SCAdllRbZNt5g0HwX6Yv439cad+ZBRjnycoeYaqpcQCyyLuE8qOWfasfXgNERK6zkct5/Ev1sZcId5juDbqvw/XJwpQa+ztWCT+i9vmOdtuqzj+YAjXSXgi0l2FMOnMN5t7/1wFfPL1DCZgX0jcwUcMjmC31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BujxuWAPsVcDjhk8jrjvaNAh0lJlIekZkQXeBjJTcY=;
 b=Q7lya8C8gVdmCZzMaj93rx5f6GklEXDYg4va9ZyXAs9Ufo0l3M8zlMnsCaziIg5k/awRuEqtbNt+FGCLkxf6E61+TTUp464r27G9vNc9Ja6uEosg5KScOYibj9y5bj6NCFo6om0UuDwNGgyyXCKhc8hOSW/Q3NXnxqYgs/WzNEuZSB62pzBnIXGr8fQJgrYRtVg77Egz+VxzB4CN00WN7341YANHgk0aOa+xoErtt4pVwAyWGdoflcRpZhGoYYotMb401ooHa5KP3txawmd8oAiNx0PJrqQYaoJO4wqUi6/BhNryhmUY/uilfpTxPIDjG7ZBOMY3QpZ6na2RZCbTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BujxuWAPsVcDjhk8jrjvaNAh0lJlIekZkQXeBjJTcY=;
 b=cuh1DHfVs82fKEqCtBGSutxEJ9qNKvNPw6zlfWNoTw5TpiqkVl8ParyJmm5NZ1zYnvo7xVe10Qe649e8/QuFLcZlaPF2BCTM8+1VqVftgLk2pXhzNjaEmYoCNwK2uoX+/6wpqrK5EHteOtgrJ065FpWgkJl4wGR1t6CqFRyyU1Y=
Received: from BL1PR13CA0125.namprd13.prod.outlook.com (2603:10b6:208:2bb::10)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 11:06:52 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::cc) by BL1PR13CA0125.outlook.office365.com
 (2603:10b6:208:2bb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.18 via Frontend
 Transport; Sat, 9 Dec 2023 11:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Sat, 9 Dec 2023 11:06:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 9 Dec
 2023 05:06:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 9 Dec
 2023 05:06:50 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Sat, 9 Dec 2023 05:06:50 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <luca.ceresoli@bootlin.com>, Neal Frager
 <neal.frager@amd.com>
Subject: [PATCH v1 1/1] arm64: zynqmp: Add output-enable pins to SOMs
Date: Sat, 9 Dec 2023 11:06:47 +0000
Message-ID: <20231209110647.890409-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|BL1PR12MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efa875f-fb9c-4fae-c1bb-08dbf8a6f23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6ca1uTKsvpn704rDTArZI5SYZ6rypHb/wuLo118nSXOCAaxhYVOn9xT6NhM3oecou20ahUqvcqfd84ELLGqoEPKenhzO5XZdZ7qLwoEUU3dD5pF5nhajyEuyML8m5N7XcQZgTNi3H+TK7ZEKqsRLdSa5c6lbkkk1s0RE6eYObAsmsrFmDqh8blVhnGT21W/hTZTPuVgAcAZN8fJWM0Bg6Q4ZOkUs10+WnGVXH5Xxahj0NUXJh/NN7omBqHKANvQm78qkW4yeYsjgcafwN9ZCb70Mu+3j3EPpn5RpLmtTunZYVu/ZHLpG5fShT1Zf8JXMPz2ZPNBqUGf5RvFekltp9HxoUmA0EVhDkgwRfY6mfN+SR/Mpar4WdlRyo9FJbXDSbG1eMcqbkcrTN3OH0iUktZVebKWebYoSv+eAhVv6xXs7BGL2hxhJlcds9zl7TxIvi7GS1Rhe+c4eMXd/4lKIjqsBD6F0h2joEgh1k7s/EZtjCZiwNe7pTCy/rgSPGFgzl/gNPZwI9ObOrNZkszi9oVfK8k2iwV2Uh4cL5dv6uXPiMxLodeocoBb2+Xg4tm2ITmS2yuIqH8XNi3MUYsvxI+6gD5VkdVwIS79lM/BJk8EqrtMYq7Y7iJFcupH4sFeuToixaHmmHiEpBrFhOwr35IrSrcSMN/KXfXT16ocTHUNkiRVq9Bw/eW8gHgZrvsZBsV9aF32hl3DAYxAMANBk4SXyktgGyEXP7E3DzvyGePwBOJVkmi2sBO4KKFnWRKFd82jiKRMtgvrj71gc/Poug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(46966006)(36840700001)(40470700004)(336012)(40460700003)(426003)(1076003)(2616005)(26005)(36860700001)(5660300002)(44832011)(2906002)(4326008)(41300700001)(6666004)(478600001)(47076005)(8676002)(8936002)(70206006)(70586007)(316002)(6916009)(54906003)(82740400003)(81166007)(356005)(86362001)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 11:06:51.5112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efa875f-fb9c-4fae-c1bb-08dbf8a6f23f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
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

Now that the zynqmp pinctrl driver supports the tri-state registers, make
sure that the pins requiring output-enable are configured appropriately for
SOMs.

Without it, all tristate setting for MIOs, which are not related to SOM
itself, are using default configuration which is not correct setting.
It means SDs, USBs, ethernet, etc. are not working properly.

In past it was fixed through calling tristate configuration via bootcmd:
usb_init=mw 0xFF180208 2020
kv260_gem3=mw 0xFF18020C 0xFC0 && gpio toggle gpio@ff0a000038 && \
  gpio toggle gpio@ff0a000038

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
 arch/arm/dts/zynqmp-sck-kd-g-revA.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dts b/arch/arm/dts/zynqmp-sck-kd-g-revA.dts
index 56f3128528..ffdb60fa51 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dts
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dts
@@ -175,6 +175,7 @@
 		conf-tx {
 			pins = "MIO36";
 			bias-disable;
+			output-enable;
 		};
 
 		mux {
@@ -220,12 +221,14 @@
 		conf-rx {
 			pins = "MIO45", "MIO46", "MIO47", "MIO48";
 			bias-disable;
+			output-enable;
 			low-power-disable;
 		};
 
 		conf-bootstrap {
 			pins = "MIO44", "MIO49";
 			bias-disable;
+			output-enable;
 			low-power-disable;
 		};
 
@@ -233,6 +236,7 @@
 			pins = "MIO38", "MIO39", "MIO40",
 				"MIO41", "MIO42", "MIO43";
 			bias-disable;
+			output-enable;
 			low-power-enable;
 		};
 
@@ -241,6 +245,7 @@
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		mux-mdio {
@@ -271,6 +276,7 @@
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			"MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
@@ -298,6 +304,7 @@
 			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
 			"MIO72", "MIO73", "MIO74", "MIO75";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
-- 
2.25.1

