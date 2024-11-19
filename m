Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A204D60D0B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 02:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2AC1891CD;
	Tue, 19 Nov 2024 03:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0964F89484; Tue, 19 Nov 2024 03:05:59 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20711.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4259B8924B
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/AU07xCkjVYC4RwLUBExjj+TXJezFc72DJmMIfCfHBUOmRDCIVAX0Z9n5uEZSE5V3RUKCXu3DtCANamLuEIGo5cJo5LytlqjrzoHlfHQ3fdlv+MH6C/WMgVNmXSizQwa3H+geERb76r9Io53MUfYuiBE5eSf+IFJ8qEXIdA4KFzNH9EdMVXs8kKHzraxQFBA/dZqFKkJgJYlH9N4ui7DB0MObki14zsF1QqOr39th9+P0omfdUzVX/JbOaaCGHf8ucScuZlTAL1E2kel/ksvAYG4HvGTcPEa+3F/n9LWBElDSLgHKwzMe8a2LqpNc867yYn+SLiOkp3CBfQJbSxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PE0s6y9EXVp0ASeC3jCAls3wNUR9El3OFNOE+x6PEg8=;
 b=mLykTNogJWA/O5BzS1Cu+HiBDExKBRbc4bSeotTGbae8DQSMYXgaGFx6dUSJ45XMwozYiivfqFjQKRmTsRhPN1H1PbEiu41TFcqT6h8Qjj64GpGRbgmNvqsAz+8cSgzf0hC4hnaVNxyqy4oMYQNYl8ApawtzzXoDfKnHeV4vGh/8hfhCh1khpoNUdNIlibp4gPJDymO8u1hUn2BbGrFkx9jteqziX2VRZ7WXvZ90ynkevOzgryPvbGJWA6mQGBEQ4mts/Ck605/XvIHSsqNW/nAVV9YSKcSuD5Yp7utvYROMNaQruyS6JdkUCUl8wUyYgHlIUzsj2tFLwM3EDjdwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1292.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 02:06:03 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:06:03 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v5 02/11] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Date: Tue, 19 Nov 2024 10:04:16 +0800
Message-ID: <20241119020425.51989-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241119020425.51989-1-hal.feng@starfivetech.com>
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1292:EE_
X-MS-Office365-Filtering-Correlation-Id: b64e5265-d041-4985-9925-08dd083eb868
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: klncmZ90YHk2kZIuMJ0KRQLbNUZFoX6Vk0Zab4AYXAE3KwvdxdJB0/K43Th1tJqkoXp/76+IAo/jPboNVS6Xq0sqSZ+2sUieTAxiP2eZlJrutyryX9EhI5paxVDyarTgJN0Hn0WwyAJNpqAllkvVnEq0eB2U6lsh1UWSu8lyNEfRJwer4mF7GRilotFugNREyCyDdtP8ejcwU+RXvj59YZABc/B47A7yDtF27Alk20XbfZ+WC+U5sbJ7mS/1jIeyXcA4jXtrLBOPjf9HkZMZRsNBQ9yCSlfFX4N/BQ/PGpT6w3cGvhLQlMKYc5JYt4HMCu4UL4Z5kevLZt5t1CthjRolKudb4qTyDlxwYe6pgnSJOd6GRvn0VhJrrk1miOIvLc8HWd6gQdr/p0JXPxyR96CZ4yPtjhBN5dLw0ah6vcK8SBBu4H/r6ZyUHtL+GyRhr4ywTHKfbimLfcyYfb2MPRXE8E+nUAa6LuO0ojMJCX7xzi4kOS9/N8ci51hCzbqKvkBPZyhtwi/60fbJ66qYxCh+1D8Xv608LEQz9gHMh8CaYU1XG/WWObmDMUn8s/BVVfHmyl8W0T7CstinahRrwSF0Bb7F3u99X+C39QpZFTAXKMCa6c674HhWg2KbAQOrGv9XTmNcBENSoF3T//FfXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(52116014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aOdk7F0bZ8owbqFM0Jjxl/9H/2JZ2IBuAHnVyjUAE44Dk60JjAO8XkNpQX4k?=
 =?us-ascii?Q?OdK2ptv/3MYae435slWNlvkmbUQtf3TujFzE3MyHNT2nDQGR3mIjUB5k5/vN?=
 =?us-ascii?Q?i1DhHiTzzTkshsBbVj11biLv2JEJ46QFD3kVTOIy1fNv1DaCHhXUjzM2qdug?=
 =?us-ascii?Q?3tlndgPx3F3mHMUB668dD/IfcabcWFV+LV58ypnHrqXBE+yipkTvI5iZNrpQ?=
 =?us-ascii?Q?RtZx9KzwGePjNtD6WNGUwLN5L7v1QPrdmpD11zg/Y11JvhnC3zdK0+GKilpk?=
 =?us-ascii?Q?H4i45+EwJjveyX5sXEzQbXmy4zkso6QJkNbQs4EQ/CE5WRII/7cMr5XFaOix?=
 =?us-ascii?Q?R5DoLXjBEpZmzh85o/CQie4ne4KXNVaAqYLx5wd/PDtzbRqrHmJ4pqQozoJi?=
 =?us-ascii?Q?jiVz9D8kejDGFISD5oWXpdG8Q+V2nPfuJmN45lFL01WvzEbJKvkUjc1DSD5J?=
 =?us-ascii?Q?uYW16WRZU/T0z8EUThj60WfOlLacMXi/AEtK1755nvB9vXXjYsOnAaVRduWt?=
 =?us-ascii?Q?pTKRz3MZ1gg0ynY3cfcpMHQDYTd3FQ72qliIc7UlaQd73ejyh1+JZaMd9jyd?=
 =?us-ascii?Q?4C5VWIocpBwLrEtcb7Em+GGLd2scbcXw4TRA4l6i3Q4r/scMUY4QWcn5/QZ+?=
 =?us-ascii?Q?XfIZD7LZn0REgCk5m+UF83EIXq/vQlnV9Ehrm5OTRCV270iAUEKeTwnivnWm?=
 =?us-ascii?Q?AF6HzBFvhBBbVNkSmZb+l+8FMORzBX5oYeAlvjfjTgh25CfDAv7+na5QVA5d?=
 =?us-ascii?Q?HFfd92ihJbdSPeQ5SMi5nZ/nTE9DnGjjau/ocgXsSVdWRBP50Aw/jCFQU+CB?=
 =?us-ascii?Q?0JG0+Ovgej/xcWW33Z5PlrM+pb+PBrb/Yk/5olZrShwimPANGT1J7GjCnDIP?=
 =?us-ascii?Q?Iwfd5D9My2z+cYOkLC/dumMl0GYd/X/i5rOLwiVw+bDRkeO5SHJMVDhVCHsH?=
 =?us-ascii?Q?Gbl59lLsSRj8GHFdG6doZ4plIyNn4BfgfersXltGWoDz13ljcUmJLVxUykCf?=
 =?us-ascii?Q?hx9RhsFSmpV0ruKi+0Y02XIqUvS7o8qMlzqRsJCi4WzhLQrgxDMRZmKHknIg?=
 =?us-ascii?Q?65vqKPr2rM69KHEHND2LOGnmySmOwfPD+yLqMvmyoETGR6DzMnuDVEpDfyOP?=
 =?us-ascii?Q?JLwJ7NxIZXCMk1e47zgbhvOfGxcT81koAQ+jy8eGvxPkfiRgG86ruJhEQVSm?=
 =?us-ascii?Q?mdUMgBfVcBPEkNS60nNLBsyn1s7aaI4wIdsR35/57rU+VoQKkin3JEwumOVg?=
 =?us-ascii?Q?iatsFQs+0HBphl3k+eslxj27eYSw3guT/T0h+xaPOksJyfuv0qxsQSX6bjp8?=
 =?us-ascii?Q?9vcinoFUchk89IyUHIhnoBw9fPzV3pSxM5SVtFgQROGh3ZkYYrvWWJgsEEvZ?=
 =?us-ascii?Q?chAyQv+uNu66ekghknJZ5C7Lrd7aqifhvB42iHqQ+874ErbN7FoDss1zIwzI?=
 =?us-ascii?Q?FP3SOd5wnk1DSmUOH4fKvXGiHwFaXXeO0M28vrKYzn+bSLmikMlZCLch3e7d?=
 =?us-ascii?Q?KSIi81fMBYg8IVzg0OLncSvYDh89ku+5P7+oLTS6m3qVCl5tOOPFPWHhRZfk?=
 =?us-ascii?Q?zbU/KFWJSZUSp8COIp8pnuV9elVU4ahzjEEEp3sl8nq8+NS4sbJhO+NYN9pV?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64e5265-d041-4985-9925-08dd083eb868
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:06:03.2838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+jRwBFJt1fEEzpTQjTvjw6fNUXYxUNCVA1CHG0EmvUkaTXqpkBli9sDn+cj4AYULxlhnDMgIDBXmJ4GmzSYblx32Nuw3dEL31NJ5+D3DOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1292
X-Mailman-Approved-At: Tue, 19 Nov 2024 03:08:50 +0100
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

Add u-boot features to the U-Boot device tree.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 43 +++++++++++++++++--
 arch/riscv/dts/jh7110-u-boot.dtsi             | 34 +++++++++++++++
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
index 3012466b30..fac9e16fb1 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
@@ -6,6 +6,10 @@
 #include "binman.dtsi"
 #include "jh7110-u-boot.dtsi"
 / {
+	aliases {
+		spi0 = &qspi;
+	};
+
 	chosen {
 		bootph-pre-ram;
 	};
@@ -27,42 +31,70 @@
 
 &uart0 {
 	bootph-pre-ram;
+	reg-offset = <0>;
+	current-speed = <115200>;
+	clock-frequency = <24000000>;
 };
 
 &mmc0 {
 	bootph-pre-ram;
+	compatible = "snps,dw-mshc";
 };
 
 &mmc1 {
 	bootph-pre-ram;
+	compatible = "snps,dw-mshc";
+};
+
+&phy0 {
+	rx-internal-delay-ps = <1900>;
+};
+
+&phy1 {
+	rx-internal-delay-ps = <0>;
 };
 
 &qspi {
 	bootph-pre-ram;
+	spi-max-frequency = <250000000>;
 
-	nor-flash@0 {
+	flash@0 {
 		bootph-pre-ram;
+		/delete-property/ cdns,read-delay;
+		spi-max-frequency = <100000000>;
 	};
 };
 
+&syscrg {
+	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
+			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
+			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
+			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
+	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
+				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
+	assigned-clock-rates = <0>, <0>, <0>, <0>;
+};
+
 &sysgpio {
 	bootph-pre-ram;
 };
 
 &mmc0_pins {
 	bootph-pre-ram;
-	mmc0-pins-rest {
+	rst-pins {
 		bootph-pre-ram;
 	};
 };
 
 &mmc1_pins {
 	bootph-pre-ram;
-	mmc1-pins0 {
+	clk-pins {
 		bootph-pre-ram;
 	};
 
-	mmc1-pins1 {
+	mmc-pins {
 		bootph-pre-ram;
 	};
 };
@@ -78,6 +110,9 @@
 	bootph-pre-ram;
 	eeprom@50 {
 		bootph-pre-ram;
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		pagesize = <16>;
 	};
 };
 
diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index 52c1d60859..21a2ab1789 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -46,6 +46,15 @@
 		};
 	};
 
+	timer {
+		compatible = "riscv,timer";
+		interrupts-extended = <&cpu0_intc 5>,
+				      <&cpu1_intc 5>,
+				      <&cpu2_intc 5>,
+				      <&cpu3_intc 5>,
+				      <&cpu4_intc 5>;
+	};
+
 	soc {
 		bootph-pre-ram;
 
@@ -73,10 +82,35 @@
 	bootph-pre-ram;
 };
 
+&gmac0_rgmii_rxin {
+	bootph-pre-ram;
+};
+
 &gmac0_rmii_refin {
 	bootph-pre-ram;
 };
 
+&gmac1_rgmii_rxin {
+	bootph-pre-ram;
+};
+
+&gmac1_rmii_refin {
+	bootph-pre-ram;
+};
+
+&stmmac_axi_setup {
+	snps,wr_osr_lmt = <4>;
+	snps,rd_osr_lmt = <4>;
+};
+
+&gmac0 {
+	snps,perfect-filter-entries = <8>;
+};
+
+&gmac1 {
+	snps,perfect-filter-entries = <8>;
+};
+
 &aoncrg {
 	bootph-pre-ram;
 };
-- 
2.43.2

