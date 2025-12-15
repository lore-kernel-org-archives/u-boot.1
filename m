Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EE6D41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 11:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BCE2800D0;
	Mon, 15 Dec 2025 12:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EQsgBoF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1BD6805D7; Mon, 15 Dec 2025 12:03:20 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F344F80050
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 12:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFVUhBGWTL3VbxctLD/fbF8hi5WlAkToJWHitCnqohE/SixYRjJ+PhSbsC0hz5rvoFoZF29D3eClAiXvX3vnFvhEbIveCQHT30NWYcOKk3d4XFSQPQTm58Fsen6PdLq59aX4f7zAV8zvZJNM9haVjBacfyY8xYvu4MYa9Sem2ae3n415jM11we1kolV2r+ICmSu1QrFps2PRaGgeKjxK31thY9Emw/csmpsW7BtKjuKBk9dlbYfRAXojQVsddOxnDim+tlDH8sQpZ70L/NUXbtMdrRoN8fAKS9OQsWoxhU4LP4zk0z9dFSWTaf773G8LL3Y0LeqdvfpZBI4sk6Gu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3t7NuvLTUL9SiZLniALKFHf07W6jYXgGDhoHEm8zeQ=;
 b=vOf5+ZHgSXiD2KCZCrrqKCL0FGj0QrdYOwFn9BdRnA2z0T6vrLZuWUuxXiYpjeE/t03PlL0vmvdVmuqOGS3Tx0ZyANO7k7sLaZ829XbF7Y7vTialtxJbdk+Z+0rL1Uq9co7NiWEjQvNcS2Kg/q3DY1tnQFLBTThAsf3rpfAyC2H0pcRe9puIOxmwbqJ6/1ukG4EqB7Z3OejSQH1zXK4kE5KVmHhNt1EYx0tUR0dKpgmi0vqZRLZFDDmVjCxLE1aO61yDxjgr/kAMyCbOmQ7w9k0nFoGNr9NjrJN64i1dCbr99HKkv6YoTuFJ8NvdV3yO2mwhJnw45Q4rxXOUi0Bd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3t7NuvLTUL9SiZLniALKFHf07W6jYXgGDhoHEm8zeQ=;
 b=EQsgBoF+tXIZLbsHQm9TBLRvxK24Jw6L7B+k5d0H962pQxD0LOO4XP+ymp2xXKQHi10I6r7ly0SNpgpQr+cb2Sm/tXqJSjkof+NnTOP+fvJcfUH1ijA/i9JLG6ln5fExpHr+IUVXoaCYyJjs7bYKvKe6qlNqPm1VZGOWvb6WQA6wsbvmUV28TJEJQxokcy69uqqytuACsaOhd3BHArmqZsEjOF+JuOswSt2aPDsDn9RhFdvNVlbX6G1zQ88W6s3RcTD3ILLC4omzWLA0ZMto0pybvgCGdoRakgPCXICAoRN/2rldInqZ+webOTaUVQQvOQPq0mF8pzKw3rIKm+bcNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV3PR03MB7658.namprd03.prod.outlook.com (2603:10b6:408:28d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Mon, 15 Dec
 2025 11:03:15 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 11:03:15 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v1 4/4] arm: dts: socfpga: agilex5: Add dedicated eMMC device
 tree support
Date: Mon, 15 Dec 2025 03:01:17 -0800
Message-Id: <20251215110117.19371-5-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
References: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV3PR03MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: f29c67d3-4402-469b-eacb-08de3bc98bdc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JqHlc8waLUah0RNfzI3x0yI8QfgUDjae3TumAb/9pEJffdhD2MUl8c1Cv/Fs?=
 =?us-ascii?Q?Bu86LzUcRPaHluHldee9UZj3zbm3ZqVl0rKU5s26fOv/R+vGfEhpvyCWuAde?=
 =?us-ascii?Q?CnkFmg7yYALVLFvQ8KxWdtmY45OFwwmfva4fv9r0XGFP9y0BnlOPZ1ma+tge?=
 =?us-ascii?Q?8Q3+oM+T7XAU74vddFtOlpimIMcnQhJKiLzVPWZhDzn8sjFCY4HZgTnNN70m?=
 =?us-ascii?Q?3IX9PcjTrhKGQLxm+Twj8Qz0W7ERVn/yQOaNkZm/NTITGOZhbH+5wVD7sUdE?=
 =?us-ascii?Q?Rb/8F7+Bzu/e9QxcVryo8qBDV2J/nmjUK34JrD5m3kAPLLNROC/tuDOEHZjv?=
 =?us-ascii?Q?W6vV8z1jD49vTjrezPIxzFT0BndSoHf9k8WdRUci93b0Y3AAZBzgmdKXEnrv?=
 =?us-ascii?Q?6fzCF2UZsM4t6KanBS6a31AtoFKHsytv+syYYWIJ4gwOLB1rTCEffkQI/0hO?=
 =?us-ascii?Q?Hm0tqK7lVM3mvbg03wMPyAiJmleAP1qFnlA/TiU3zNpbdlWOOSQMRFVoOu/C?=
 =?us-ascii?Q?ZuoUrdXaNWGOfXwIyJIwrehcpxJEWTVY6lXAXkoyZiX15y8M0G1EnZG/IhaP?=
 =?us-ascii?Q?FnjknNopwaaxeDi2YnYBT7ejSw9xH0FOe44jskRT8OKSjJkFKzOI3ZnxlvVs?=
 =?us-ascii?Q?imH1ChMfIWgxbtAMOPipG7JLvLYYseJAhvMVcP/IKphtaGAKWOoyGyk7XsfW?=
 =?us-ascii?Q?9U0/RaIr19p2UHLzmWoLH6oE2HY/qRWqHLnvw9EmfR3cQITMerkYQs+f3qJx?=
 =?us-ascii?Q?Xqk99hvcubkip9kjFJLavoLrftoHLPqM/7Go94R7ihXgZbeQ/p6VlMUWpSaV?=
 =?us-ascii?Q?kWte1QYbJv5t6fvQNozXakawdxl0ycVh+zPCLhZXuWetLo4/qaICvtkI2ydE?=
 =?us-ascii?Q?Cu2U8+RTwzBwLauuFRbUARhM+cZ+QiIst1aAWj7mjLtqk8RwjD05rDj13EvC?=
 =?us-ascii?Q?e3C4ivdKIvi7YCOBTPoAA+jF4YHwbgw1XuCrgCQeQt4uFz1sOmO9Iq5JLypl?=
 =?us-ascii?Q?/Zx+wbr8NJF1puasSwuAIZKiYC8ZpOQkUFLM4nHL6yWSwd02ubGaMBovRZzv?=
 =?us-ascii?Q?jTPQut4Iz2vmoafMrRiv2JJGzlsvRNZ3PArI3It6OVSdh1hhS57j5eKUALFI?=
 =?us-ascii?Q?vJDqowRxWOR0n9qaEMwRkMpz6cRLz/qxqdvnZiiEQsoBrUQqYju49VEhlp1N?=
 =?us-ascii?Q?baYhJAmG9g8PMJ6M/yZEN6T0sE47aJ7my1KZiMyJ/bTFuacmxh8Fg9nGJFu9?=
 =?us-ascii?Q?TuUCtURJZQVhMpoD5/LdRn34dXMU5Vao6HEZQZBzLvZlGrb410sDfAgbkKmW?=
 =?us-ascii?Q?/HdXc0b8kMdsIjZBdvld8Ypbf8GKX86YoUTR+LyPMGF/DbxK5GNDKDDEje8D?=
 =?us-ascii?Q?0Q8LRaRERYfh5BUUSWBUsvD3sg9nqnrd7o8doUW6LUpfJZt3uFqmI+Losuzk?=
 =?us-ascii?Q?RYVcg6FLkcSfnt3wMPNeHJo/+DxC+iwS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vVSIDVETo62C9JN5KMRfgsX+TeI+8QqRc0WuZDIgHt35Fs9MP9Wyb5wT7JZ2?=
 =?us-ascii?Q?UM4UWIGlA/oo+aCRX5G++ZP1eJ/nffoxTW74McuxnpPGlUd/YUIxEHy8k7fr?=
 =?us-ascii?Q?4unzzS8xTdRMWRmyAQQ2qPU56WiEQqeJxyNwTYhnfOI7sY8GUwS2Qc3OhM6u?=
 =?us-ascii?Q?H72C+DJXrrHt8VkySr4ZxDHOmzD0AWRDrTlbX3XzBMyJ4Yk3s5M9hPAYulOd?=
 =?us-ascii?Q?8fZy6seLkSoo5whI42Yp4GklK0attCGbCOET79cqnmnfkphoU7BKqNoGz3Xk?=
 =?us-ascii?Q?jHP8eoBhsYKkedTTrreyh6Ex8UzDVOHJbm9f0+6rGsROD9mizE7eDSRGcfoH?=
 =?us-ascii?Q?W++mMDMZWygC0MTVIWgbPomILairs6iht50y8EXqroi+rMpnWfs+4aQZoFFr?=
 =?us-ascii?Q?YrGcvuoyYtaV0KiMUuPTJSjEcNtvh2M6OxQv3b7Zhfjow5rIx6bgOgCmtGnb?=
 =?us-ascii?Q?sz2G5MbRJMm94OR6hfGp+rc+KHNtBFtXeNjmJhfRgbic10G6P5bIDZVgNwI4?=
 =?us-ascii?Q?F/B/u59vZSLata6gfx00kbA0GYq8XhrgUNHTIszIg3SmArQH4i2g3Gl+FkB1?=
 =?us-ascii?Q?+pJfuMgW/9r1ZKGoMxd4WxUBp3ZNLmwcp8WFXpFmDVCGT417n3B2zrIbqrdJ?=
 =?us-ascii?Q?34wfGbBlpCyL+1w9Fi3io+dBwauhjnyRdOq3tKvFFyz0h5G6NObfuOf5QeEq?=
 =?us-ascii?Q?yP6YTFDDOfB9ILE5fiBUarLSc/CruXsCvTQJ9vFJsJnIr3VPFN5i9w/F5Pby?=
 =?us-ascii?Q?Crgj1lSn5elDI4V1dk7VnIZqJkavRZjji2vGYaIVXMmsyxSS9JcFLcLMKtps?=
 =?us-ascii?Q?kHPG6JPWpF8/6n11u8mgloTitfM9VcpbDiJhr7W4v7DfkKKOUQ5E0JIIAJts?=
 =?us-ascii?Q?UlmTud9+VwkFPxxjTcVIL6JRSscTn+uMPF/9Jvty5L1xxYyvUTaiTSba468a?=
 =?us-ascii?Q?p8TON8gLeXpBIO9e/WbPoukhE0hTus8+o0tRPFuLeYBGYGrO2+uMe0FWBYk2?=
 =?us-ascii?Q?nBqe7WH4Af8nGJ7D2NrYEBj/+LbtciAdRLKDiUYGbkO2PSzuIDXR3CDhCbez?=
 =?us-ascii?Q?OmMfVmTxB/PKgplVY9JCeFuWjD91GPxKqfkeDDk3DiQuHGhBXDhInSSwPrdt?=
 =?us-ascii?Q?2ZJq+czCj7hE/h2X6MwSGhHKgnZhKDi+WfzU3RWc9rZ/FpaCNV4OqvOVEi6B?=
 =?us-ascii?Q?UXyUFAKVat953kgyUEPHpXHzIgP5ziMdPLS0jw2X7chqfPQtOqWze8dQaZg0?=
 =?us-ascii?Q?4Jvn9u1Zf8nEgLnNav072X3GP2xYJfqDQycYJ33Xd+kr6gYT14J4rvyYcrQM?=
 =?us-ascii?Q?V4sB909vhzFtEbN2O5S8Oi+Ixm8/8gXVuC2gNszMAVWPNy/Lg6guS5EY04tN?=
 =?us-ascii?Q?A/kAZ+bz2f1Zmv3Q0wy8gJRYzzK4AwCFjJN6Esk2KW08WRsBWCw/JFE1S9dM?=
 =?us-ascii?Q?mVwq1aDtMxXY6NNjNdCxhVI2TSW596bsLpqUv7dI05jWF70j7AJ3ex+MKI+6?=
 =?us-ascii?Q?ZLIhzD3ozt7WS8pMKhx7Gz95t9+uazUiAw0Y97w+jh48sBMY23Frdm3U0Y93?=
 =?us-ascii?Q?qpxSDLlS1cd0NZDJmpp05XuW1zPJ8cNw/bsjkiuYA51XvRAXA1c/Nvj6z7vD?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29c67d3-4402-469b-eacb-08de3bc98bdc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 11:03:15.5289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prvv71KZcwShAOENp6Sx1biMe/6B8Nn7RPV868tkNND+qY2PelPaqFrTDAUoiGvP9Y+vBhegDOrHNXHZ0U3Pg3WXZqJ/NFIbxc45tTPORNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7658
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

Add dedicated device tree support for eMMC configuration on the Agilex5
SoCDK board, providing an alternative to the default SD card setup.

Changes to socfpga_agilex5.dtsi:
-
- Configure always-on regulator for stable eMMC operation

New device tree files:
- socfpga_agilex5_socdk_emmc.dts: Main eMMC device tree configuration
  * Configure for eMMC operation (no-sd, no-sdio, non-removable)
  * Set 8-bit bus width and high speed capability
  * Add timing parameters for legacy and SDR modes
  * Configure voltage supplies for eMMC power and I/O
  * Add fixed 1.8V regulator for eMMC I/O voltage supply

- socfpga_agilex5_socdk_emmc-u-boot.dtsi: U-Boot specific additions
  * Include common Agilex5 U-Boot configurations
  * Set SPL boot order with eMMC support
  * Enable necessary peripherals for boot-time operation

Configuration files:
- configs/socfpga_agilex5_emmc_defconfig: eMMC-specific configuration
  * Inherit from base Agilex5 configuration
  * Disable GPIO regulator support (not needed for fixed eMMC setup)
  * Set eMMC-specific device tree

Build system integration:
- Add socfpga_agilex5_socdk_emmc.dtb target to Makefile

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../socfpga_agilex5_socdk_emmc-u-boot.dtsi    | 178 ++++++++++++++++++
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts   |  49 +++++
 configs/socfpga_agilex5_emmc_defconfig        |   6 +
 4 files changed, 234 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
 create mode 100644 configs/socfpga_agilex5_emmc_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index fcad6fb2fc7..4e39c795e1e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -451,6 +451,7 @@ dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_agilex5_socdk.dtb			\
+	socfpga_agilex5_socdk_emmc.dtb		\
 	socfpga_arria5_secu1.dtb			\
 	socfpga_arria5_socdk.dtb			\
 	socfpga_arria10_chameleonv3_270_2.dtb		\
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi
new file mode 100644
index 00000000000..6aed59f7c19
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions for Agilex5 SocDK eMMC
+ *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	/*
+	 * Both Memory base address and size default info is retrieved from HW setting.
+	 * Reconfiguration / Overwrite these info can be done with examples below.
+	 *
+	 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
+	 * be reserved for the Inline ECC buffer.
+	 *
+	 * Example for memory size with 2GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 32GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 512GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>,
+	 *	      <0x88 0x00000000 0x78 0x00000000>;
+	 * };
+	 *
+	 * Example for memory size with 2GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x70000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x40000000>;
+	 * };
+	 */
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
+	};
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	bootph-all;
+};
+
+&i3c1 {
+	bootph-all;
+};
+
+&gpio1 {
+	portb: gpio-controller@0 {
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&emmc_io_1v8_reg {
+	bootph-all;
+};
+
+&mmc {
+	bootph-all;
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	status = "disabled";
+	bootph-all;
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&watchdog0 {
+	bootph-all;
+};
+
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&emac0_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac0_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&emac2_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
+&binman {
+	/delete-node/ kernel;
+};
+#endif
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
new file mode 100644
index 00000000000..f6848c373cd
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5_socdk.dts"
+
+/ {
+	soc {
+		emmc_io_1v8_reg: regulator-fixed-1p8v {
+			compatible = "regulator-fixed";
+			regulator-name = "emmc-io-power";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+	};
+};
+
+&mmc {
+	status = "okay";
+
+	no-sd;
+	no-sdio;
+	disable-wp;
+	non-removable;
+	cap-mmc-highspeed;
+
+	bus-width = <8>;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&emmc_io_1v8_reg>;
+	max-frequency = <200000000>;
+
+	/* eMMC legacy mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+
+	/* eMMC SDR mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x00000000>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x10000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0x1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x30000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0xA0001>;
+};
diff --git a/configs/socfpga_agilex5_emmc_defconfig b/configs/socfpga_agilex5_emmc_defconfig
new file mode 100644
index 00000000000..9254ab92e0c
--- /dev/null
+++ b/configs/socfpga_agilex5_emmc_defconfig
@@ -0,0 +1,6 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_emmc"
+# CONFIG_SPL_DM_REGULATOR_GPIO is not set
+# CONFIG_DM_REGULATOR_GPIO is not set
+# CONFIG_SPL_DWAPB_GPIO is not set
-- 
2.43.7

