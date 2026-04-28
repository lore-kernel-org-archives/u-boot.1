Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEABFFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B82846B4;
	Tue, 28 Apr 2026 09:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ArdHZ9TJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9271783A91; Tue, 28 Apr 2026 09:01:04 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EA1983BC4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blggeh2f1KyrFN4pJxrNrMZP1K+1i+X4kcfGjCnp3pxZ8mcD1j7Ed9YL9saDYbhGTIdBMhHKRKrODZxQElbpRRsTiI4x/QA+BNnNM3IKSauUydVevUWVjM1gz/aYxu8xaDEEkQ3lvsyr+5zTDjEzQmxkhavhWusGOWE7bTzjUOjmMajZAh7Ve4N3eHXFe64+UfXiDIAKkP1nRStvSuCTgtE7FI9EWQGg7xGJ97StaNjI2ud4ae+fN7mP5oxzYHEH/+J9d9YtkxGh6O30RIffIu9dKziBEPif2CcvF51sFG7XGhGuqd2p4eyptInndTGZoZL6MhnBb0lSCo8zp0D2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPD2BbfsQsfmwnwRckj1t1XyKVSrKw+nBq7KF3Z+q2k=;
 b=sNqsoDf1Wx+iCc+DUmTYoZpqyaSH5P2Axf6u2AHgLXly7c3EMLTEfagN29rsvmCVNIUD+GVhXVIYHTk0Sn1FOBJ0r1FN4SOJt0mPBFIaTP40GlTF9wLw8E/+EWRYrQglQhzfnm94YkROxrQQH+eQU3HB2QCLGygtYsUd4taVujsnCSmCQu6e6vb5SfcwVdgytXpI6T9/71iSqk4Z4snBNHCxGpdGPhPbyp0wk8RXlRxhtxckVoyJoNlQKCqr4gH7oiH7vP351FCszwJKVA5mFsVv9B8O8yMVmwcSxIUPYvtoJ9UYpo05y2R9EeDPIls3957ZYDZWVDk7+plzlB/v5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPD2BbfsQsfmwnwRckj1t1XyKVSrKw+nBq7KF3Z+q2k=;
 b=ArdHZ9TJ0C9aH/RePFmVSc1SiGou/cL8OiP6MLy8yg33WQ0ZRwWrZCqI+DvmAMo/r55CAPoYopm6ojjeuW4OcucMerVgYrxUo59GgC7TgXUSsuwaW6p6umIR8H53yYIX0XmXdY/nzbV6eSuqgzg47ULd37sFif/VyI6iVgMPd7PJakiUXlOOzZ16XPMOEjTdegmBZQG1dIYl2fZ9xLZDkMIyMQmJ1pq+qGpCMK6ffKGiKil8NSCOOAdSOpOnvei25GE3A9sKDyOKjOb495GZaDmFfVrz+3W+dzMHpahA9ilCfnkU6NzlMgR5pI9UpVAeYTr6+oiHQpHEyvC4Tby2qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:00:59 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:00:59 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 7/8] arch: arm: dts: n5x: switch to using upstream Linux DT
 config
Date: Tue, 28 Apr 2026 15:00:16 +0800
Message-ID: <20260428070017.16807-8-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428070017.16807-1-chen.huei.lok@altera.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW5PR03MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c3e92a-4320-4b1f-417b-08dea4f3e6aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: woVJPS+fvPd9OzgyVOWcaM8ECzaycy/KsFvlyXMOXPz1EzZykqxh5M9Llc+h2UkjqtJJpUc1Z/NzY4xtD4W/x3KvMJr2ckykRUy3DpmHqCPu/UvxQT0xbHM+pQPKp7uKpQHMF8ex4vPLHIO+dvT0uLgDGJPdPikQ/NIJ309PPbIlXPdfcqfXf8NIZvS2rI3m3TPFmMx44YVUocm0Gxdk2p8x8tOvveUNGDUB6MQoGLZ5wp4sBwLHKBk7tOe5eAhMubDL9GqkKkXUL1z+/dy2qJJCWjp9/HkBsGwqGTigHpqK26kzEKQx3Jeavm2mKJCcXUoiu+k55BtHbIJ4Plu9CZVi+9ea3ocxi67PDb7NLrz3CDqTSpg9D6J+LTnHLd8TklJ/iD1Q3B00rVk2/0qacXWAvSNTpHyAO25vpLgw2ec/RLWFgosElpOVIG9BX6s0tivv49SXy2Ys3v/R3VytJHnv/rqSNSNyYaDRS5G5vTEi6KFvdfldjEXsVxjV/Gmp4owqqvRVh9ZjyRUkSHpzPbN3g85o+ANz/fA+mTj28SmN0Qzou109W+FqDeMsRreFVDAaKyJ/tn9wT2QXrzBlhfuIhW6f8HkWZTC9C9RA+NbRwJ2RA8GgO5nWc+JbvkH6xhL88oHKfwqPPMEfmixjUw+j/A+hoeL9gQy5+e71PmiV7VXmpuSLUVL37eU8IF/H0ha9kPcwIeka4QDYMlNLZLKc8WB/6z4Gf87BO80typE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVRUr0DAxNhZ0TFpA3iV/qoJ7J/1Ui4FCEyIHr1SlLzwAQkXxBXxXwQGWYmE?=
 =?us-ascii?Q?ZSPgiEbxDVjPCa9xBqypp5hOEtbda7RRwKblxlHn59JlOauYK45regmiiq2k?=
 =?us-ascii?Q?8SHQRN/jSBi99KtNYl2vwkvp4FKtY7MqCY0az/VUyn9LSEmbAyc7Gr5DRXr9?=
 =?us-ascii?Q?u98YQ9gyH9PGiL2bReHxkSlbT1x7AfR6qCy/o+c+snn7CWDcfFjToYUrRYSC?=
 =?us-ascii?Q?5ea207ukreR8dRITsoTuSXkJ46wARS9qT670VFHVjnLGcQfTFd3WEkBswxWl?=
 =?us-ascii?Q?g98VMXLMJj34MP0lp4fDDtZr/2uT0KlSotE9RC1srdT0B81jnM51D6uTc5uG?=
 =?us-ascii?Q?wK7QPsgId6t4eY1rW407CG9NFaJ5Zf52HbZ1rpJdL+eiHtxGcvEw20DHJf66?=
 =?us-ascii?Q?Rw61fVvu1cG0yUZDJpkzyc0WL1xaThX5PzO16xgAwA34Ew9nnwxUHCcgfNsV?=
 =?us-ascii?Q?L10n6+AqfXdfYpOAIglrb6AVXQJ1IpZLxQzsKawinRBewKbLVExg5lHWIlsl?=
 =?us-ascii?Q?YxbfstWRkHC++xSHcUqzb0MKfu9KQ5kZbO4D0vCCIHUAuhs1rusx4No1EkIj?=
 =?us-ascii?Q?7Ut5+nTL+o/4as/osdFLRxsNdVCSRBXhHmdlTzDtPSoJPh+SSquEaR+4V32m?=
 =?us-ascii?Q?pTRC44pqUwo6TxU7Zc9k14jEqKftpzvP4dYU58LQ0efblLIxLilhDoPD+tj1?=
 =?us-ascii?Q?Z/c+NDlubEP+gOSuFT2LNbvdar2/Zp/Tooz7ApMtildwWCKo280ax6JNs8Vm?=
 =?us-ascii?Q?gY07bCldZWRaLlmPRVXK32wDx8Q40NPaEk2FQN8jWPUUykhJjWzqrlZRFZJ9?=
 =?us-ascii?Q?d3Vvfkcv++ESVyeZtc69RjGCxr9GZ01OUpMMtdnMbRFmL0lqJIhmx4cmWdso?=
 =?us-ascii?Q?sUHwTWmkr/Z+LODVTZlg9b7VoEODXiiffuCdkfy3cdGHxYqsT9Suu67OCudC?=
 =?us-ascii?Q?/S9rPabDIxnqASVBfe0dPN7MukRNsbuP/XYiBlFrYbYgaRfOUPIFeTYuhER+?=
 =?us-ascii?Q?CP11vvNkw4URPXM00tA13IodQe0/Q3GLloeauRdsp531KdI8xNvrOGrxaauy?=
 =?us-ascii?Q?glRY0KAtjDRM/BxqkLi81Lh9jQwHgjPl8mE3opk7FxPhdg67b+Oge+mhA80y?=
 =?us-ascii?Q?WNJywZCEdbn40SUaCMgZLMp+LDz7iLAjbjnATmVsAvWtJ61nG/7dsNh0qE0W?=
 =?us-ascii?Q?5rsytPr9dDTnDEeudSH7fldFsImOBXbeQxTkWQx5qPrz/JFhYa4a/JUd3CHN?=
 =?us-ascii?Q?L00ERW1d5OvfETZxCKjIiwlxF4fOWrZaARrQd1U9qKTHVGGNkdoPw9q4Tjmo?=
 =?us-ascii?Q?8D2CQ5AxuAhL7ICy15p62qPpGaBAj+apE6zAfCBWOdcIywB3Fr2rJgQldQxi?=
 =?us-ascii?Q?znrGzaU9FTj662+fh1m4wPgOwoYbglSm5/XIoh/ts0sY7M1HIN9Y+i/k4k0S?=
 =?us-ascii?Q?6ROeDc5DZZ975rsE/P/MbGJHsOff7teDQPy4y6KVPiZYhSaE+ggGnqAbMqok?=
 =?us-ascii?Q?Yx/ix8s/353izCsgrm04BZ9FHKdBQRVMZdLxkG26rxQh+IZxXKPltnp3wdh7?=
 =?us-ascii?Q?/wDdunEFOsC2WLSg12lBTF5cR6K1NuLLRAXuhAFGiV4WjlDne4x8wUj2KbWW?=
 =?us-ascii?Q?peTKHmL0UdiGOzcQ5qbYqSQB8AjMkV2OexiauahU6qDKjILq/iQrxEGcykpH?=
 =?us-ascii?Q?h5dMh7ZiJ3C3YXL4nqzYmcIYhyTD4pKkrxPhtDMPOmS9swqwoMS8P8Pz+BwL?=
 =?us-ascii?Q?g5a6DcyCO/EQmz9exQXV1jgt3BAt6WE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c3e92a-4320-4b1f-417b-08dea4f3e6aa
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:00:59.2011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwYb9d/FMmx2HAzvKLvTBJLhU8gkpkQZWy+Zftbgwnx6Actz295fprOKdpV7Y0BIYA24Eucn/wI2xiUid76+NPRjMaJ5ATCSZyRjy2Zx08g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Migrate the legacy n5x platform to use the upstream Linux device tree
configuration. This helps reduce maintenance overhead and aligns U-Boot
with the Linux kernel's DTS hierarchy and naming conventions.

This change improves consistency between U-Boot and Linux by removing
custom/legacy DTS handling and instead relying on the standardized
definitions provided by the upstream Linux DTS.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/dts/Makefile                      |  1 -
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 17 +++++++++++++++--
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi | 13 ++++++-------
 configs/socfpga_n5x_defconfig              |  3 ++-
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index e79cfb4b633..86c6b4f465e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -460,7 +460,6 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_cyclone5_vining_fpga.dtb		\
 	socfpga_cyclone5_ac501soc.dtb			\
 	socfpga_cyclone5_ac550soc.dtb			\
-	socfpga_n5x_socdk.dtb				\
 	socfpga_stratix10_socdk.dtb
 
 dtb-$(CONFIG_TARGET_DRA7XX_EVM) += dra72-evm.dtb dra7-evm.dtb	\
diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
index dbfd2abfd59..16b92ef48f4 100644
--- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
@@ -10,7 +10,13 @@
 #include <dt-bindings/clock/n5x-clock.h>
 
 /{
-	memory {
+	aliases {
+		spi0 = &qspi;
+		i2c0 = &i2c1;
+	};
+
+	memory@0 {
+		device_type = "memory";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		bootph-all;
@@ -121,6 +127,14 @@
 
 &qspi {
 	bootph-all;
+	compatible = "cdns,qspi-nor";
+	flash0: flash@0 {
+	};
+};
+
+&flash0 {
+	#address-cells = <1>;
+	#size-cells = <1>;
 };
 
 &rst {
@@ -200,7 +214,6 @@
 
 &usb0 {
 	clocks = <&clkmgr N5X_USB_CLK>;
-	disable-over-current;
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
index 1f7e31bcae3..1bed87c1231 100644
--- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
@@ -8,12 +8,11 @@
 #include "socfpga_n5x-u-boot.dtsi"
 
 /{
-	aliases {
-		spi0 = &qspi;
-		i2c0 = &i2c1;
+	chosen {
+		u-boot,spl-boot-order = &mmc;
 	};
 
-	memory {
+	memory@0 {
 		/*
 		 * Memory type: DDR4 (non-interleaving mode)
 		 * 16GB
@@ -38,10 +37,10 @@
 };
 
 &flash0 {
-	compatible = "jedec,spi-nor";
-	spi-tx-bus-width = <4>;
-	spi-rx-bus-width = <4>;
 	bootph-all;
+	cdns,page-size = <256>;
+	cdns,block-size = <16>;
+	/delete-property/ cdns,read-delay;
 };
 
 &gmac0 {
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 17dc55aa41a..8ad6316bce4 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -10,7 +10,8 @@ CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x200
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
+CONFIG_DEFAULT_DEVICE_TREE="intel/socfpga_n5x_socdk"
+CONFIG_OF_UPSTREAM=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
-- 
2.43.7

