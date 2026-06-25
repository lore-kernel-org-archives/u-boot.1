Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C823CDE009
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 18:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04DCA84A0B;
	Thu, 25 Jun 2026 20:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="p6m4FzD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47476847C8; Thu, 25 Jun 2026 20:09:13 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B441F849C5
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJrDhrOVqLBJUB878hsX91KsOMXvMb6u5pgiJWyRf6kD5bW0LckkhCSPs9p6bGCL+N3dE6Sj+5C+GD79tLbrv/JFnl8aD1o7x8hrBbJvyYoUC95rgy4wA5FHdRf++No3PudhWWujrv/k/8t19PABjqeT1PyTbVIrzgRzI9V8eX89vpiKFKn2M1miZ6ebKRVN51q4wXBbhi2jRw4N1uX6+N3WxcVzGq4yk07n99NcHHC2atStqCdCQftqAvheDOOYXvi8rbJTMoFpbvFtmWMTRfp1GS4pSJKOU/Fcykq1ikuVUky9QUPVKpugt9yRLA5XjVpmkIM05qIYsSg20S7y8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XNihHwDun+nzc8YmKAtVP+/p/cWCYRS5nJbl00pOo4=;
 b=CRhCQ1KLPN7WqjcDFnw96LFwBx0UVCOYJvQe2tmMX5kX9AiGIy4lr5xbbvYYHm8JDFU66WWOE2ZF/yt2sCDLoypRP74T6BYQb7psKYe5mYF4QGX4Dqia9J0vDB0rZoRui3H773Lnj+QKmH/piN7GXxqOkKiaUZxmU8sYbZEVxEwCaJi9HaVNjP7I/f5sFGZJu+byY33GCKC/WivGTPrUBzYH/z88Kzma5hpa4AkpoevFe9YumfFAD44ERtuOIzmXh5sx7VFo3lorciuhB8Owd4VH42fQppAN3O4dPP2LTpCyAMozhYRy4SVAtk022XODOz9i8QLkOx0KYKE8YMxdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XNihHwDun+nzc8YmKAtVP+/p/cWCYRS5nJbl00pOo4=;
 b=p6m4FzD1C1kVvwNmhGzKOGd8XMcuCqppJk9nbg/iT4aKZBH0iL2BNttebFINwLmgHljDUBXOeJIYzBlQ/x20/deEYU98l47zMY6gZPjQYBBoZAKi992Cn6dloNLYhHl48etRG9ePK1MkAgYoCeKw0QdbPPGg3n1BaLDSj3nmz/0rm3GYwoqKEOyqEknvfroI+5qiljUWjXrCNnTLBjWyr/yVw4ATElh9Vbyfv3I8jk+2jIiKPCDnfvUfu4ltSV3qCtHvKw9S0fb0m+KXKs93sOZfuBVuYFw1yWYU8y0ktPIphh6jRz9qktiMmGKR3mHY5uJMeACDkglfBK4V6Q5a2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV3PR03MB7357.namprd03.prod.outlook.com (2603:10b6:408:195::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 18:09:05 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 18:09:05 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: [PATCH 3/4] arm: socfpga: Add Arria 10 SoCDK QSPI and NAND boards
Date: Fri, 26 Jun 2026 02:08:25 +0800
Message-Id: <d0ca09b1fa3a608427e90c416bfe8811c73dc903.1782410782.git.dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1782410782.git.dinesh.maniyam@altera.com>
References: <cover.1782410782.git.dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV3PR03MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fcc9d7-0437-402d-12a5-08ded2e4d7e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|6133799003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: tJGmJUQfvbWLTq5lSisrB6II2CbRVjCiu8JThxqjs9BPfBgegAVZwaDnOaYM09WpH1z/BsARisROPLy+DR3yKmhFJlpIlBXQj+mddIcnZ1dqbF2MrYYkO0MwSf0xvfecfB3n68Xg0OdypS+9KliwP1fQsvMyJ98KRjFwyrlRCAsKnGJE88+BNL1fLxJy2WG+0Q0m0qkdeG1JMVyOqr2BCDxOq2am+hUA6LTh3rSOFJjJNVVzPVE8/IcDOeMGGk7vqRtla3DLe8Oygzi6IYhl3hi3jhZ77j8ISKYYyF23AYrUxQ9ZXObsn/CU4ajCWJ0cYn2nznOPP/caOLLiaDtZxyUTSm8eVUqdiiSemBy/2oc0rDs/cqNYa30/szkBlhY2wAPXkxBObdaRKaiYWLFZpH6w7lO2VUclYzUOaTmuY78E5VO0zw8pHWALZVL07G5whnGDZnoBdmwodbPO49Omx3ZKId9yagLGo5qunUT6JMzl4PGP9MuIlMcqjZvVOkY9gDXXacB8HyKm0boQws8fg0j+EGinUWNzLPv3YTiXIjWr4UQVl+Yp3L3kAuoAh3doPffHHOGgfmvtrbeiQx9gUWqBMCIP3jV5LnZ9UQPPFXzRCUFxZ2XvETfqU2M+n4pSHu5rK+c7TvUPtYlqLrhNzNZwj4DIX46/b9quKo4tJ/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h6J5i8c0if9+Axlp4cO9RoFDy6nhb7OCXFzKxAYODYyF9aGTSUy6rTxWg+uK?=
 =?us-ascii?Q?VWF8wCblywOCm2MNKj5oofx43G+85xhQWgWf2fdz6RiKUxwaB8DC8CxKH+3L?=
 =?us-ascii?Q?AJ8fegZVzbxnjo0PTp2hFW2T0fLishTywLnqSPIKdJ3N9v/TuctwD1W6x4Be?=
 =?us-ascii?Q?U774/YvODNBMG3z3jwZqgmfcP2+GuNGC5llnbeyk+MyNpcil+phlhpYtcAwX?=
 =?us-ascii?Q?XuyZWbyrgE2312IhYu9JEl6Gel/I2j6ZCGRSSemHLKu4aiyK5nYzF3icJJQD?=
 =?us-ascii?Q?KyTPBgg7q57KW9BT+MJs0gn9A43HYEngj+b6n3F35O/s82holtCrT82mpMWe?=
 =?us-ascii?Q?6zvmXV5sDhR6+a7RjNcKJKrNugYVoxGlLMyv0B+c9lOM9OAe7uRDr5gCFKNN?=
 =?us-ascii?Q?q4oN7XRs5qyxgRWqFhJoqRPc2994yFPSsmyKBFmM8sCfaUqCcN/Ip4w9J///?=
 =?us-ascii?Q?7id8Iv+5x61qfHaOB+wZ8+S0DjpC6S7pczPbkZaRnhiaQWbQ+HDVqQr3Fapi?=
 =?us-ascii?Q?OSux2nwxn+AYPM1EofIrJtCethbgIESsdN9+tg/6/M2kKKYBXzRDSDWjCn7F?=
 =?us-ascii?Q?smzf6l2IusBNAvyqnwUnbIkfDHYZWfx5hD6U8EX6mDSTNTglNQ0bHN3JIEG8?=
 =?us-ascii?Q?KJ0ovfKGFRTO6wNfcouZio4TdDJOS/GqrT3oS01y563dqul2Yi9Uh4GelGHI?=
 =?us-ascii?Q?h8UGjDxydIm5Rf3U/JqDQt4VzYx0lVNoDzLjyICXFThj6kthBdipegeSeXXO?=
 =?us-ascii?Q?6dlmpKCSu+E6OAlgynCSQeaNH74f7VbBzPbNPgVIKdNJcxDUTj6kmQcy0DJX?=
 =?us-ascii?Q?wcFC2qT7gUf43R3XAPejuSILxzd15iL732LsHKbkiPZQTgLuW5jjafRUn2sU?=
 =?us-ascii?Q?TnWYTS8KuxktMN0qfxabFwHokFboKS+KN/S0+cOdK5bMX6WhcfNi1c8z6xSO?=
 =?us-ascii?Q?dsqd/ujuf3+3Y/ii7IpESfCsIFM+leTvCDrsf01zMsSNfH6Hv6cnxPiWIC1y?=
 =?us-ascii?Q?Fbm6U7nVPsCKe+ZlX/CuT8gQx8B2cz5F6HtN60PRbbZRM8SW6V4wF5c/QAHP?=
 =?us-ascii?Q?zaRulftMOmkdi+T5y6jfqVvDlIl8gLVY6m6qdbsA7ay4QXKIPTsM14iQ3goW?=
 =?us-ascii?Q?gc1gqIntA+xhPkSkyuNKLMLsdmc0zrWzvixTSQNdx8uX3cPd08Zl9fHzpOSx?=
 =?us-ascii?Q?Mkfz7xK/jVOnX8YyuON5uWoyspUfovLSkaYSstrUy7GKpvBhHgKxzq1PIlYe?=
 =?us-ascii?Q?/tIqiuNeQlZwRD01H6++AqBmucJxVK7/8xUhniDCX6ERmK3SmcutG0zxCptg?=
 =?us-ascii?Q?VRespJ6tgaIDv53LiWNGaCKnkqXn++jLaKv3411T1ICEsi5ly1bARMuDgVMS?=
 =?us-ascii?Q?kT3h9juJbcf5fjqti06DniJzQwmk7Gk+BmrzInARyN+uNcl16dFbOM/M+XCd?=
 =?us-ascii?Q?jXYTX09IZtAfLXUrRnTEn1nxilPpLJWkifVBri6JwTw+3KdDfQAUcjIGh6Tp?=
 =?us-ascii?Q?8shSmZplLm85iw9XsNQjutlZfqueqVHvLJoNtXnjpMBXoVT6CdaL1kwSXnvI?=
 =?us-ascii?Q?Toh964BdSXumKSlLKTHLP/IpkuhmLKAnwkT7ohb6vS8IcesZFe0p4/VEyhm2?=
 =?us-ascii?Q?2qgWWIj6u138DKZ3AIZ4weylAL7hBBjGKh9PK4IuPjOqt5VPv/hD+b1EIYv3?=
 =?us-ascii?Q?+oIFkdD5kllDciwWLPHuh/eoTXZwwiRjevtYkmoHRlHzNq7vY2+xdnGW804g?=
 =?us-ascii?Q?UhRTIiTFtuuqwcUs4ImcH2d66T0X8J8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fcc9d7-0437-402d-12a5-08ded2e4d7e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 18:09:05.2669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gD3V/IS0tIY9SzvCHVACTk/ruPxIC2ae6a1uB9zOP3yZKGAurg+PCVUNcG+V9Kho3F0fZISb1oCs4yh3F2pG9qoSKG/hUJnVU5+9ccExlJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7357
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add the Arria 10 SoCDK QSPI and NAND board variants.

Each board ships with a minimal top-level device tree under
arch/arm/dts that includes the existing socfpga_arria10_socdk.dtsi
and enables the relevant storage peripheral:

- arch/arm/dts/socfpga_arria10_socdk_nand.dts enables the Denali NAND
  controller and declares two MTD partitions (boot/FPGA data and the
  JFFS2 rootfs).
- arch/arm/dts/socfpga_arria10_socdk_qspi.dts enables the Cadence
  QSPI controller.

The matching defconfigs select the new device trees, the
storage-specific drivers (NAND_DENALI_DT + SPL_NAND_CADENCE for NAND;
Cadence QSPI for QSPI), and the SPL memory layout shared with the
existing SDMMC variant. Board-specific run-time settings live in
include/configs/socfpga_arria10_socdk.h.

The boards do not use CONFIG_OF_UPSTREAM because the upstream Linux
Arria 10 device tree does not provide the clkmgr (and related) labels
that arch/arm/dts/socfpga_arria10-u-boot.dtsi references; the in-tree
arch/arm/dts copy continues to provide those labels for U-Boot.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/socfpga_arria10_socdk_nand.dts | 26 ++++++
 arch/arm/dts/socfpga_arria10_socdk_qspi.dts | 11 +++
 configs/socfpga_arria10_nand_defconfig      | 95 +++++++++++++++++++++
 configs/socfpga_arria10_qspi_defconfig      | 86 +++++++++++++++++++
 include/configs/socfpga_arria10_socdk.h     | 27 ++++++
 5 files changed, 245 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_nand.dts
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_qspi.dts
 create mode 100644 configs/socfpga_arria10_nand_defconfig
 create mode 100644 configs/socfpga_arria10_qspi_defconfig

diff --git a/arch/arm/dts/socfpga_arria10_socdk_nand.dts b/arch/arm/dts/socfpga_arria10_socdk_nand.dts
new file mode 100644
index 00000000000..07e6c6a788b
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_socdk_nand.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2022 Altera Corporation. All rights reserved.
+ */
+
+/dts-v1/;
+#include "socfpga_arria10_socdk.dtsi"
+
+&nand {
+	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "Boot and fpga data";
+			reg = <0x0 0x02500000>;
+		};
+		partition@1c00000 {
+			label = "Root Filesystem - JFFS2";
+			reg = <0x02500000 0x05500000>;
+		};
+	};
+};
diff --git a/arch/arm/dts/socfpga_arria10_socdk_qspi.dts b/arch/arm/dts/socfpga_arria10_socdk_qspi.dts
new file mode 100644
index 00000000000..3128a11ba1d
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_socdk_qspi.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Intel Corporation. All rights reserved.
+ */
+
+/dts-v1/;
+#include "socfpga_arria10_socdk.dtsi"
+
+&qspi {
+	status = "okay";
+};
diff --git a/configs/socfpga_arria10_nand_defconfig b/configs/socfpga_arria10_nand_defconfig
new file mode 100644
index 00000000000..2b9b776baff
--- /dev/null
+++ b/configs/socfpga_arria10_nand_defconfig
@@ -0,0 +1,95 @@
+CONFIG_ARM=y
+CONFIG_SYS_L2_PL310=y
+CONFIG_ARCH_SOCFPGA=y
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xffe2b000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x200000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_arria10_socdk_nand"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0xffe2b000
+CONFIG_SPL_TEXT_BASE=0xFFE00000
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_TARGET_SOCFPGA_ARRIA10_SOCDK=y
+CONFIG_ENV_OFFSET_REDUND=0x210000
+CONFIG_IDENT_STRING="socfpga_arria10"
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x0
+CONFIG_NAND_BOOT=y
+CONFIG_BOOTDELAY=5
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 "
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="bridge enable; run nandload; run nandboot"
+CONFIG_DEFAULT_FDT_FILE="socfpga_arria10_socdk_nand.dtb"
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
+CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_PAD_TO=0x40000
+CONFIG_SPL_NO_BSS_LIMIT=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xffe2b000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x15000
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_FPGA=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_NAND_SUPPORT=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_GREPENV=y
+CONFIG_CMD_UNZIP=y
+CONFIG_CMD_FPGA_LOADMK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_NAND_TRIMFFS=y
+CONFIG_CMD_NAND_LOCK_UNLOCK=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_CACHE=y
+CONFIG_MTDIDS_DEFAULT="nand0=ffb80000.nand.0"
+CONFIG_OF_LIST=""
+CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
+CONFIG_ENV_IS_IN_NAND=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_SPL_ENV_IS_NOWHERE=y
+CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_BOUNCE_BUFFER=y
+CONFIG_DWAPB_GPIO=y
+CONFIG_MISC=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_FS_LOADER=y
+# CONFIG_MMC is not set
+CONFIG_DM_MTD=y
+CONFIG_NAND_DENALI_DT=y
+CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SYS_NAND_PAGE_SIZE=0x800
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0x100000
+CONFIG_SPL_NAND_CADENCE=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MII=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
+CONFIG_DESIGNWARE_APB_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_DWC2=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/configs/socfpga_arria10_qspi_defconfig b/configs/socfpga_arria10_qspi_defconfig
new file mode 100644
index 00000000000..2ede110eb25
--- /dev/null
+++ b/configs/socfpga_arria10_qspi_defconfig
@@ -0,0 +1,86 @@
+CONFIG_ARM=y
+CONFIG_SYS_L2_PL310=y
+CONFIG_ARCH_SOCFPGA=y
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xffe2b000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x200000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_arria10_socdk_qspi"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0xffe2b000
+CONFIG_SPL_TEXT_BASE=0xFFE00000
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_TARGET_SOCFPGA_ARRIA10_SOCDK=y
+CONFIG_ENV_OFFSET_REDUND=0x210000
+CONFIG_IDENT_STRING="socfpga_arria10"
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x0
+CONFIG_QSPI_BOOT=y
+CONFIG_BOOTDELAY=5
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 "
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="bridge enable; run qspiload; run qspiboot"
+CONFIG_DEFAULT_FDT_FILE="socfpga_arria10_socdk_qspi.dtb"
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
+CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_PAD_TO=0x40000
+CONFIG_SPL_NO_BSS_LIMIT=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xffe2b000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x15000
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_FPGA=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_GREPENV=y
+CONFIG_CMD_UNZIP=y
+CONFIG_CMD_FPGA_LOADMK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_CACHE=y
+CONFIG_OF_LIST=""
+CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_BOUNCE_BUFFER=y
+CONFIG_DWAPB_GPIO=y
+CONFIG_MISC=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_FS_LOADER=y
+# CONFIG_MMC is not set
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MII=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
+CONFIG_DESIGNWARE_APB_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_DWC2=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/include/configs/socfpga_arria10_socdk.h b/include/configs/socfpga_arria10_socdk.h
index 35c777b774e..8ca8ba7be51 100644
--- a/include/configs/socfpga_arria10_socdk.h
+++ b/include/configs/socfpga_arria10_socdk.h
@@ -32,6 +32,33 @@
 
 /* SPL memory allocation configuration, this is for FAT implementation */
 
+#if defined(CONFIG_QSPI_BOOT) || defined(CONFIG_NAND_BOOT)
+#define CFG_EXTRA_ENV_SETTINGS \
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
+	"bootm_size=0xa000000\0" \
+	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
+	"fdt_addr_r=0x02000000\0" \
+	"scriptaddr=0x02100000\0" \
+	"pxefile_addr_r=0x02200000\0" \
+	"ramdisk_addr_r=0x02300000\0" \
+	"socfpga_legacy_reset_compat=1\0" \
+	"kernelfit_addr=0x1200000\0" \
+	"fitimagesize=0x5F0000\0" \
+	"qspiroot=/dev/mtdblock1\0" \
+	"qspirootfstype=jffs2\0" \
+	"qspiload=sf probe; sf read ${scriptaddr} ${kernelfit_addr}\0" \
+	"qspiboot=setenv bootargs " CONFIG_BOOTARGS \
+			"root=${qspiroot} rw rootfstype=${qspirootfstype}; " \
+			"bootm ${scriptaddr}\0" \
+	"nandroot=/dev/mtdblock1\0" \
+	"nandrootfstype=jffs2\0" \
+	"nandload=nand read ${scriptaddr} ${kernelfit_addr}\0" \
+	"nandboot=setenv bootargs " CONFIG_BOOTARGS \
+			"root=${nandroot} rw rootfstype=${nandrootfstype}; " \
+			"bootm ${scriptaddr}\0" \
+
+#endif
+
 /* The rest of the configuration is shared */
 #include <configs/socfpga_common.h>
 
-- 
2.43.7

