Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBD7C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7232871C7;
	Tue, 19 Dec 2023 17:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sWy2HgfR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5559387032; Tue, 19 Dec 2023 17:17:17 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62F89877B0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSXLQrKFJ74A3XpbcA4aOGAILb8VtV+MI/iQIBaQ8e5K1L/F9/5TfNEAVY8uPwIXiugW6NeXfE2GtzzrD729dWiYgmn9CblJ04JeUvRnS95PgH2+q2TQwTJXSIA/lkJ9vX7B46sArml7GZev5tXczoLABKtt9Nw4AesOVOoECj4wPqM4fVmqCnzexfCh2005SqwEYKJlIRUiETJTvpTjs5t9B/fByaLQS9v5yldUt0niHGP1ovmg1vwrojSUxrq34hVR4NZFzdYCBxBzN/KbxPmZ3EdeQSFV9BTwJY9RmaNLqHcYuchDmOCy/DoPdfy4muOE+bNu5t7TCgF6ltssKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg/tuzuOqVG3Ezz3v0uXX/U5WQKIanDBBqlE8urygyo=;
 b=GrNRitWq1EB174nqp1LheomvlgysZuqosr1biPuaCKiq55vHyPaVXOLwkepXCSHeTVwxn1fwDFEBT4tYSXuPOoNoQaWgSNkMPCC/KZaeexRrg02i0WIRdm5P1vcCkY5y4MkEJdkME8yuRYbZLAo8mgnJd/fAL4ahooiPVxxTY3zxsjIQvuVumKB5ehdSZt+vTlxc0KoJ8BR1LgduBFQbb+xGOr2x8qMUsNORgmx8Z3QGGMb1Oz6aSta68KmY8Q/XUApebAuKC1HVXOIsB0d5aOcS0o2b/dD1f7RWvNl7VXzJlaqcZtDvSgDSOdx2go/oX+tLXkNV/BPiLl/R4fmfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg/tuzuOqVG3Ezz3v0uXX/U5WQKIanDBBqlE8urygyo=;
 b=sWy2HgfRoqQl+/RZYCN6KtNiaRhbaY1SgzwZb4pTjDeubttrYggEPD0FWJvMdvtZ6YFdNzKvIVkAlK0UUO/SysgVqQkwfhw/Ki7LcNPoFm2i3+dbatUcUg8N/KSXsd+uEPhv+T8QQNRf0yVDwebI6aFaCnIW0eXHH3vtmdGHVGY=
Received: from DM6PR07CA0110.namprd07.prod.outlook.com (2603:10b6:5:330::26)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 16:17:10 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::d8) by DM6PR07CA0110.outlook.office365.com
 (2603:10b6:5:330::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 16:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 16:17:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 10:17:08 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 4/4] arm64: zynqmp: Rename i2c?-gpio to i2c?-gpio-grp
Date: Tue, 19 Dec 2023 17:16:50 +0100
Message-ID: <407b0b67ba019be5a2073d09d578b381c639cbc6.1703002605.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703002605.git.michal.simek@amd.com>
References: <cover.1703002605.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12820; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=LAbamWErmvUoCeoazcMswGke6BfsOiBJ928XXekrlsY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTGgx8epb75zBBVZvjsffuEQnmrG/vUZvP2LOURK5vf9
 13KsnJVRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIcSvDPKNtu9sn6UpPXCCz
 IUj8VWCq89ZXMQzzbGNZp7QmK/62f+1tbFtbaLbg3bZ5AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 747786a0-0939-4b08-a7f9-08dc00adf3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWHUvUzgdyrU8PblAqxdJcdfUVZpaOoS+NDXrLkAbXXeUq7vPp3lflo/GNxdQVhq910Lq9lxzCR29hNhRa50FH0pi1laGoqvrp5PqqJ+3xpGV39YzwJykSh8ucKktepwLGacTXeOco42yeQd94hLGHpDS+kLy4XCKRkOB30bgPw875TLpe60Dgl+ESp6/rURMuOc3f8hNduYYKB9V7zR/6PG1zFctRXRqpT9NwezWxZ6cmQpFWt67E030gPsnOmS24hJGa7v7T1jJNQVjHKPH2AROfw7G/0HwwzMBDTCXltu9hm68PLAnyzqf5UyXxyTFsLkJYS3TC1zpA8de+KwPe5SGPpa+IORg6pl7v1bbs5hmubtn4EeMXzFq1OnRCxO3N+nEOybjc064vR4ojI+fu7sx7jjZFSBxWXBu9ebQl0SxHYgaVS1h5G3jxw+XrRWNDBFTRpu9RGCTJ5AuBjMKF9NYID7/wBBel18AbVnrg7s+bx9dyfJpppwnA0mjOBa/1A/p0qylqfTJs1zdHt7llygkYWfG7LGpMbvJ66BdQZ3XnRIaX0c+DxmjS8QBHpH5+SY/EMVROi1uNMO4inXYCb9sjzbmk6byRYU7jEgqXpu3qMiiQ7yggcP0EXM4RHyoOZ14GzKQPE1/68JiYKocYnN98FcjWFQtn3pOIoOfvdx2YMIMd6f0WXTE2u8glC3dfGJJrQe9ypGFG9DvsSWgkMfZ/oGOc8SZHDoUTNtk2aDFfFuvYx6qLMz0+Ub0TFLgsSFV39K3sULU1q25THIjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(8676002)(5660300002)(316002)(8936002)(44832011)(2906002)(30864003)(82740400003)(478600001)(81166007)(83380400001)(86362001)(356005)(966005)(36756003)(2616005)(426003)(41300700001)(16526019)(26005)(336012)(47076005)(36860700001)(6666004)(70206006)(110136005)(70586007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:17:10.1029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747786a0-0939-4b08-a7f9-08dc00adf3f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
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

Anything ending with gpio/gpios is taken as gpio phande/description which
is reported as the issue coming from gpio-consumer.yaml schema.
That's why rename the gpio suffix to gpio-grp to avoid name collision.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Dt binding change has been sent here.
https://lore.kernel.org/r/2e3a1f1f57cf929bd05115bc081e6d01d5a53443.1702996859.git.michal.simek@amd.com

---
 arch/arm/dts/zynq-zc702.dts                | 2 +-
 arch/arm/dts/zynqmp-sc-revB.dts            | 4 ++--
 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso     | 2 +-
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso     | 2 +-
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso     | 2 +-
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso     | 2 +-
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso     | 2 +-
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts | 4 ++--
 arch/arm/dts/zynqmp-vpk120-revA.dts        | 4 ++--
 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts   | 2 +-
 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts   | 2 +-
 arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts   | 4 ++--
 arch/arm/dts/zynqmp-zcu100-revC.dts        | 2 +-
 arch/arm/dts/zynqmp-zcu102-revA.dts        | 4 ++--
 arch/arm/dts/zynqmp-zcu104-revA.dts        | 2 +-
 arch/arm/dts/zynqmp-zcu104-revC.dts        | 2 +-
 arch/arm/dts/zynqmp-zcu106-revA.dts        | 4 ++--
 arch/arm/dts/zynqmp-zcu111-revA.dts        | 4 ++--
 arch/arm/dts/zynqmp-zcu208-revA.dts        | 4 ++--
 arch/arm/dts/zynqmp-zcu216-revA.dts        | 4 ++--
 arch/arm/dts/zynqmp-zcu670-revA.dts        | 4 ++--
 arch/arm/dts/zynqmp-zcu670-revB.dts        | 4 ++--
 22 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm/dts/zynq-zc702.dts b/arch/arm/dts/zynq-zc702.dts
index 6083f99dc8d4..7864b4b8bbbd 100644
--- a/arch/arm/dts/zynq-zc702.dts
+++ b/arch/arm/dts/zynq-zc702.dts
@@ -294,7 +294,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_50_grp", "gpio0_51_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index e0b554c9c545..f7349fdc3b4c 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -344,7 +344,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_34_grp", "gpio0_35_grp";
 			function = "gpio0";
@@ -371,7 +371,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		conf {
 			groups = "gpio0_24_grp", "gpio0_25_grp";
 			slew-rate = <SLEW_RATE_SLOW>;
diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 298e80265e2a..766f78303eee 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -225,7 +225,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		conf {
 			groups = "gpio0_24_grp", "gpio0_25_grp";
 			slew-rate = <SLEW_RATE_SLOW>;
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 95b1dc5aa571..57cd9ba13e78 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -274,7 +274,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		conf {
 			groups = "gpio0_24_grp", "gpio0_25_grp";
 			slew-rate = <SLEW_RATE_SLOW>;
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index e2387a2abb8f..21187396326b 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -274,7 +274,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		conf {
 			groups = "gpio0_24_grp", "gpio0_25_grp";
 			slew-rate = <SLEW_RATE_SLOW>;
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 04ae59290a0b..6d0d5c487d2e 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -248,7 +248,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		conf {
 			groups = "gpio0_24_grp", "gpio0_25_grp";
 			slew-rate = <SLEW_RATE_SLOW>;
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index adf3511ad313..a4b4465d2038 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -235,7 +235,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		conf {
 			groups = "gpio0_24_grp", "gpio0_25_grp";
 			slew-rate = <SLEW_RATE_SLOW>;
diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
index 9ab8f5bfffe4..088545c87cee 100644
--- a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
+++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
@@ -400,7 +400,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_34_grp", "gpio0_35_grp";
 			function = "gpio0";
@@ -427,7 +427,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_36_grp", "gpio0_37_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
index ce76e0b3db36..fa6046eb95c4 100644
--- a/arch/arm/dts/zynqmp-vpk120-revA.dts
+++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
@@ -536,7 +536,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_34_grp", "gpio0_35_grp";
 			function = "gpio0";
@@ -563,7 +563,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_36_grp", "gpio0_37_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
index e72ed50b1cb2..27b38e981a05 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
@@ -148,7 +148,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_36_grp", "gpio0_37_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
index 160c6c58b36d..ff7069bc1249 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
@@ -273,7 +273,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_6_grp", "gpio0_7_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
index b1857e17ab7e..53aa3dca1dca 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
@@ -125,7 +125,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_74_grp", "gpio0_75_grp";
 			function = "gpio0";
@@ -152,7 +152,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_76_grp", "gpio0_77_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
index 44d1b24677d1..49d5cdbba585 100644
--- a/arch/arm/dts/zynqmp-zcu100-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
@@ -284,7 +284,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_4_grp", "gpio0_5_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index e166c9555069..3132fa533b8e 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -708,7 +708,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_14_grp", "gpio0_15_grp";
 			function = "gpio0";
@@ -735,7 +735,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
index cdfeea2fdd84..31effbf27a8e 100644
--- a/arch/arm/dts/zynqmp-zcu104-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
@@ -272,7 +272,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
index 4b942acd4132..999b2431bdf2 100644
--- a/arch/arm/dts/zynqmp-zcu104-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
@@ -284,7 +284,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index b90ff61d2416..ba3989cad3e4 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -719,7 +719,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_14_grp", "gpio0_15_grp";
 			function = "gpio0";
@@ -746,7 +746,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index ba9e4891fccc..787cf0d87f9f 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -589,7 +589,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_14_grp", "gpio0_15_grp";
 			function = "gpio0";
@@ -616,7 +616,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index 22ad8d33a116..b4e24745a9a6 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -600,7 +600,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_14_grp", "gpio0_15_grp";
 			function = "gpio0";
@@ -627,7 +627,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index 575ff5b1b77b..6f593e80841f 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -610,7 +610,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_14_grp", "gpio0_15_grp";
 			function = "gpio0";
@@ -637,7 +637,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
index edbbf0b30e7b..76410de1edca 100644
--- a/arch/arm/dts/zynqmp-zcu670-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
@@ -573,7 +573,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_14_grp", "gpio0_15_grp";
 			function = "gpio0";
@@ -600,7 +600,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm/dts/zynqmp-zcu670-revB.dts b/arch/arm/dts/zynqmp-zcu670-revB.dts
index 97599c5658fb..c2dd9f696bf0 100644
--- a/arch/arm/dts/zynqmp-zcu670-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revB.dts
@@ -573,7 +573,7 @@
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_14_grp", "gpio0_15_grp";
 			function = "gpio0";
@@ -600,7 +600,7 @@
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
-- 
2.36.1

