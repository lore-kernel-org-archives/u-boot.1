Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67394FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365848468A;
	Tue, 28 Apr 2026 09:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="T0prTSXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6C584150; Tue, 28 Apr 2026 08:50:40 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70AD983A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFpjIBOZDjF83iIzOxz/eAsP952C3A4lsgXDycDz4enkBskmIMpnJBx2YhNxzGsYq5GHvuTpu1KxsyZ4AdXUCwOFwsmNyt/1S63DuSR4rtiJrI5nqsnPFT8GkFzatJo/tEL75cTPgGed46ybiJPPuMXqFCMspDV/ruUPj4QetKxNwfT6yMST0ns7ZAPxyMHjXX5Ig1J/N3cMNkdXPmCOm8126wDDjEwC6YIXzbMDGoiTN+7Mm34d4QgnbygVP+HN4c/werRywgL4ytv/VetDIvvDXAeaJfVQhobsaNCdLx7T9gCoTmzzP55z7/MH4NKaYfsMW4bKkDR2oE20yc8dOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPD2BbfsQsfmwnwRckj1t1XyKVSrKw+nBq7KF3Z+q2k=;
 b=RgoVilRe/CfnIJZ3Wbefs6VGzu/lq8P3d3vu4EmeRavsjuls+yQ0lWNO0ORQm1mJ9cURewjW5YcC2pH/+Ag2STLw7E8mhHZw34Z0tOfkWK40GF3eggxo7+vI+zr1Cr4347EARAY8qOF44yk53wgGYgdvVGEQ4OVBu7aT8j3nV3uNpZYKPO6MR9Pga6vYiw2ZZhFuQCy3EnCQxHfCRbPXXdpmFXjQyDCIkHM1V2t3qElkaRDbwIZrCCfkPf1m6dv06wgf1zXIsz+QWdS3367YThjRWtGwKdJDL7ChXmUFNWo4riqGQtM29L+9k3Of7HFc0kN9EhwUDGwUQBSDACAO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPD2BbfsQsfmwnwRckj1t1XyKVSrKw+nBq7KF3Z+q2k=;
 b=T0prTSXfifA5QwFwPn48rIiw0dcbpHxpzeO2c/hu1nY7L026kDgfgYCKV3CpSyh0DVIRTSFLiact2/JKZtDJEpoc4xT9xDdd6+3UYoU8QMqxvd0qKrys42zWx+XvAD9BU1zet9lh9KJR1zXOFqQmnTp+OvxIF2qUvH6KP8sVb4DXytYujSF6L4l7cLaU6/El+h+FjhbSWOYZyr2CzZNtNJATVM4sybEtan5oU9k5/bsw5rc7XlQSTFBQ5VSYShr3NSarEJFxoj2PdqWpJ9oqXuuWh/XRaw80YMlydVAMucWkoJIFbenPYl35jKTM53jGv9VV0TcTN04xc5KFLX3NdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BL4PR03MB8038.namprd03.prod.outlook.com (2603:10b6:208:58d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 06:50:34 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 06:50:34 +0000
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
Date: Tue, 28 Apr 2026 14:49:51 +0800
Message-ID: <20260428064952.3965-8-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428064952.3965-1-chen.huei.lok@altera.com>
References: <20260428064952.3965-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BL4PR03MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: cacd9bea-3f1a-4f06-4a92-08dea4f27274
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: tQ9978KePzsioaPCe5HFiLYkrdi1ENO2EA3D48M15m4uIhXCXQe/sNMlwpOsDhZo8oN/vZerAlBt8Dezc5h50PyE+/qSeCryYNl2PNnxhg8yqK6jesGNjnb2MbCXNCqsngPfZUKMhKBtzgw3rZ5QWN96zCydQx6z4F+WcYGG2xg7dwft6GkIoSzMu+nXMjfR8+cD4J3egt0KdUmFK+OYSGoUF3J4tm39yDyeqISBS0Ko2Gdq0SDsVhbRwx2k+eUiI2BKkNlvkmKGm2eMmopyktlo7bejlwfJU100ZyRyiodwotaqKAn9v8uQI4oKAqlSJ+f/IeMOf9EJOh6Tsv4Xsloy+Uz7BCKFkZ38fBzAG7qoLP0gJrH+dWF77D+4ibpaet8dWmXP/LteXLF5dHh/mFGUtJeppMI2npxAF9f1MpGD1XVNUF4yh/b6YKpbNkLQsLORzV6kuDjmQsBpmOiDqda5PcaJlapQ0dvz1A0vYWtCUVEYjqTix2X+p2d2/lLq9ucriNF+vFUwfEzOKf8CExy6xs/g8IPLaBcswgc8RCQssPKhtClKiHX8WXWQnnLO3kcPzujjT93obspXMdJeXiGZb1gsMJkJK7O0IB43OTPFg8WUDmrh3M2AeNRhcrrrY8G+mKV8L6k4J5w8HtLNcy4+TyMmY41NxZlVXIWfWzDnab66Nl+Hm7Sv4zIZBsauuK7De430K4+lUJ2IiTFPPH4NU/4yJNEZ0Vpp5Yx/sPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IkXPMiZhfggk+oMnj2tGnR6gFnwf1bOT+TNUZ2ezPAn0t4KRC2ebpoeMc5Jj?=
 =?us-ascii?Q?thg5oBs+MFZ2Osywujw4ETMc/vlBIcAd8h1V6Ktvp6tmfswuTfK99iA+mRTl?=
 =?us-ascii?Q?+1+zs1EOKXhOdn3rOhzebNqvD7rmTJM2jxeoF2cGyvEuylzAtnCby/02KmFz?=
 =?us-ascii?Q?ZtwXIqfaMiiZWj1Ju5N3l5zTfdL+Ce7aXCZdtnrRijIY9Ao+qQI6qLPGpzkV?=
 =?us-ascii?Q?w86e5jCg0dFMiQG/VFUJRVOSDbuKoj6dDJF46moaDD+hT2huDTqDK4jZ7FC2?=
 =?us-ascii?Q?38ntROAbFrxuxJ0Q/pOSVck4XYUlmhu33KDAdMW+HpEbUnPQfy9oiKqcYUxK?=
 =?us-ascii?Q?w0If4mFz30NyJvMJx0WygzYlxLRF30N9nc3lfVt0UBNRGjYo9xn/m3BnhvAh?=
 =?us-ascii?Q?eEApsUbxtPGK1X2NpmciZTDQNbLHN2tFG8AFNCf1mLi/u0mioyp4FbsjZAIG?=
 =?us-ascii?Q?/XNvEX9tKYniIjezvGsHr9RedBWzy0ZGpJ++zj1NH2E9fNL0pVuWo4gTLmt3?=
 =?us-ascii?Q?yLfKlWQ1y9wiyzqkPPuqJeevLdLpuEISaWLjoR9UR+NYCbWCuIGZPutmYkwV?=
 =?us-ascii?Q?s0ftA+W5L7Rz96dsv/h9ollfcwug2HBdLJpErF9gLTkH73N3AJ49bmR7Eof0?=
 =?us-ascii?Q?2uPPfmgZIkaKUAc8I+YBR4kmGlQCYl+VGD0rMPOlQNPI2UB4uMJ91M/80HbA?=
 =?us-ascii?Q?UBQABzqvYAX4L6OAvNforrF4tezFu9eC8qrRwxiFfxf8BZt65fMZboOX2wxi?=
 =?us-ascii?Q?W41wqJS+4Yyr6bhqPcGwSGOOjCFKmZAbgUsY80qw6oWn/Fwb2OLn/JVNLdVj?=
 =?us-ascii?Q?5efRDYrzmjvyPOgW4xuigW2CSgvf3lsq4j7rI/fMxGGR6Utu/ubA2oIE1F/D?=
 =?us-ascii?Q?2Lu4tHtg+9sKU76lT7Z02d/inQl2l0Io5TJTv3q6UVyXkeFbCL47tDcweq9V?=
 =?us-ascii?Q?H2dYjb3tFBbLdwzwmd7/JCd+PStW5TgG4u0Gm5J/N+d1xmm56OD6ILhnrhOO?=
 =?us-ascii?Q?i4pqNhKI19fFUjEzVH5vcwRajr84DUSagOdEevtHo8WSDDOuSy5fr/m0IRDO?=
 =?us-ascii?Q?FlN2C3+zx3HbM5t+7Gp5S6AgPetRzWbBvsupNQfUlt3EVkzGF9TSfi8AuJ16?=
 =?us-ascii?Q?uIXFdVlnBgIq/Z5g7JZwlSsN40v52pe7lrvxpQL9jgsEmswUbMi45uaJMpdK?=
 =?us-ascii?Q?g6/qIRY3m/jG8LBdJ1oxdJsxmAsvoCjukIqY51kCWLS80fCr6UyxOSd5pDia?=
 =?us-ascii?Q?d/uFNXkrXcqoOyVhjFSrscawmVIoISnWehEB82UOX+t9i8BkrGIp9ez3e3NO?=
 =?us-ascii?Q?sDtBSZeYcTs5ee8R6OwZdcR/3LX91DjmE8QvqPbPguhCVh9jBq7fRvu5Xaco?=
 =?us-ascii?Q?I8sDXrZDg63ktcn6RffdjSzOkWuEw4lbGZ5+QOtLukInlw8UtRJH7CcOa6et?=
 =?us-ascii?Q?1/G2MVHc4lPQapcGt36+biaUUFJTZ5ezvshNxAOs/4CEsmCUbMwa+cz0NAI0?=
 =?us-ascii?Q?/2ic/+NxaBgRGO9sntPqTRuEK6iBo5fvf58R00JaIFG1e3j1fAD4qxPtyJ/y?=
 =?us-ascii?Q?irGFuTJb345JByYEv6f/F4yyWqiNiPvjznJSwt5Stg9BlTR1i88sPoDnzx+v?=
 =?us-ascii?Q?tLtQWKsiDM5rw7QnokdjwG7H/cPwYfTUEmyLFTSXlkoPySk9Y5+PYRjdJ5T5?=
 =?us-ascii?Q?/YWaX7fqvL1F2FEL6lQEyQFBAMhE2ZEqjWwR7cT+ZqmlqHFTMjEFB2HZnI5G?=
 =?us-ascii?Q?57byhxIF0ScEyNg9lEFfeaT7R3ZrelU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacd9bea-3f1a-4f06-4a92-08dea4f27274
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:50:34.5955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: So2IbmQ7pnsa8NfxZMI3wfY3G3zQtL1hslAroF1LdgCyDJdRZnjFhMF1WgNfcqcYwd3RyRPG2jTXVtLoAlIJ8NBydKnSYTJa/k7ybEcqH84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8038
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

