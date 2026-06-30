Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1868CC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82A784AC3;
	Tue, 30 Jun 2026 14:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="v5TBdsY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E757C84A48; Tue, 30 Jun 2026 08:56:19 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63C8D84979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhB7CDGHR9uWm6PoZTonJVzWSJeDZ7UCuS58nYa0jjNnhuUbZ7lyTdq3RnPbXj6QdCXlGxBSCv3VTVHQ/jTF1Kg5u+w/zQkwfETicBcOOrE3EKnzvRtzt/wUjGPYAi22tjadEd/chGL9kWZXG+NeQ5xnhSuVaE82Vs6sF0ZFDI59Pngu11uIjB69cJGigL4ZnqdEvQILxQJbSvCMlP2X+C82aWysHWRx6/8bMQIA7LTsZGk1bzAB72DQyJjHUSsFkLnCrNYP7wjyjL9b42CBOJoOJIyb3MXoWRw6iESb0OZhw3DAExVEBHJa5n9eKPDDiixRwyLPHn6r6lI2GV+Xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxwBNX86lxd7L8loNYyByzfsi6epOuBfDa8HbEjEBJs=;
 b=G5ZRjJgxeu+IiiFdlBWJvhsatZ6FuZYCHSWmZ59Nm5qFNZVG77dQWfcSEb6o+jZt1y20K3pO08Vt3nnG6OK0WDgBkxgVR0qW4m2Wkft0PcXv8XgxT+9xHTTRW/Ep/A32bddgA2xpVKBvepEuMJKvxpxz9mjEsi1dTTiUIInL4RHwr1bj7Qo3g/UANshiTHhOQmLKpdghYFCpl9/pOXGs7118+Bw0k6WewJheTTqWAyXr6lDpr02dauNnb9GSfIDympHoteQIgQYdiJNVhCt/lK2gBkwv2+Wg33hah5/FakL93vE5jpbvDSCVkSWtU+p3HtBSrfyxdrV30I31li8eJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxwBNX86lxd7L8loNYyByzfsi6epOuBfDa8HbEjEBJs=;
 b=v5TBdsY0l0L2l2dgWEYsyZJD8XHBYettB2wA/hXUgUqHqjtVULpYJ1/+t62Kd7dd4ZOBjS+3+yBEj9T79+k5Dy+bwu3rea/YmkaJs+h39FgkDnt0zUgvAZGTC8h20su6OKmqH80Dw5HnNU4zlC/pLLPY8h0U+7Qod3FQnf1PLiIE4NsVxDif98fI/vHqXNwQOSCHFSzVXFkeeF8SeNxz2n/DTaJENgo3eYiAtzB6Uc3hiF4ZHowIOiVZdLFv5VL9HCqWhlWpMb1uhD99vkyfSf/X5VtrTSUQKshfbbXCiRbLM3rxQVIbOsuBToZ8M8e/ST6l6QQBTI5wdeO6nenBKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MN2PR03MB5085.namprd03.prod.outlook.com (2603:10b6:208:1ab::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:56:09 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:56:09 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Fabio Estevam <festevam@gmail.com>, E Shattow <e@freeshell.de>,
 briansune <briansune@gmail.com>
Subject: [PATCH 2/8] arm: socfpga: Add Remote System Update (RSU) core library
Date: Tue, 30 Jun 2026 14:55:18 +0800
Message-Id: <20260630065524.27680-3-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260630065524.27680-1-dinesh.maniyam@altera.com>
References: <20260630065524.27680-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|MN2PR03MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e6a68e-42e0-4747-8544-08ded674a949
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|13003099007|18002099003|11063799006|5023799004|3023799007|6133799003|22082099003|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info: Ki62MiZ5xR86GXX3Iz3OHVXSyBoumQMkU/yMTSK362Qe0uRvqj9y9EtV56dw64HxRLKGHxOhpqAyzHb4HyXWWiN8qg2O8CeMXJohTHkHvxqzJmWp1SsPXfffUBUHdGNEqY0dqOA3NFK5yI3KvCM/6BjkkeDhQaRmLg8juWEf18yjmoeyiv1EXHbAJT9PE+xnsrt+MrLCwktyqW16ka20FvNKbOjMMD3eGQ5QosGWT5oFOvVfyYWdm4pzq3nvlBde+aJ1lcvU+3p90wkQ6vpTJ0z62aBhmPePs/rXCMzmPaCrLZH3EhlEOJt59pHknr1yUef+fjyC3TvmwNC+/iGfwurTcj0nu/7g4DnrKPtE6BnwUf0OZQfZK49UwGHOwssymCTCt3lynNUSUTiRAvEuEltfSkupRFHqhS2rqYZ4OG68G/f8f22gV2zKkrIN89j+wzliqXtPO7sANbPUzK88lYrCe/hZ6kwuwTm9IOvXiCIS0WpH92gj+xMT18oqA09rJX5QytKCa5WcTnHFiaCmDDqWMfQQ5awRacdWC6Al623y7K89+2jCbR8VB1zz4hojVJidY52FrgfiKWvQVVWXbfEuJaZ0Ik+W6GGdDcRXouxzz8rulUs0iRQ9uJcufEIW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(13003099007)(18002099003)(11063799006)(5023799004)(3023799007)(6133799003)(22082099003)(56012099006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bnMlE0NtJVm/OwfVvRcLLzF3vsLNzYNpACaRypxMH5XwfcQpdFTF2sSjFc9a?=
 =?us-ascii?Q?xYENRY8+9h7L/7LhuY+FIlgpE+QMXARrnKzCGpxPlHn/x0q9WNqdaREAY9gm?=
 =?us-ascii?Q?Ps8cuPuOFOwcOJqjmivoKZk+1Cd8DO8S87AVlEJ3uhPAZUy4+P3obHdCPtSf?=
 =?us-ascii?Q?uEz9W+8+vKu1QdE/u9lmkqMyZdPp+sDu2bPdbh+aBeRS3SPdz4owMv+wKwDw?=
 =?us-ascii?Q?y47C9TI7yKcmAPHj84iekdCvd0d7my4vJtGglEuZCCYfl846x2KRJ45uu14D?=
 =?us-ascii?Q?1UVUKkdYxxO0FN7kBvzRAVpf8vq1ZEEdzoXUbA+9RX2bEMYQqOlOexxw8O1C?=
 =?us-ascii?Q?WMoZxb88/4vZrTZx7rvxFrB2NHruF1HdyuGqbP4WCJuqe0hlKHU1yrjMXr8l?=
 =?us-ascii?Q?kf7EXTmnG8pn37rbKtfqwB0DI2aFUU8UAlageuS4cJnVWFn66N6W2FZi6V8c?=
 =?us-ascii?Q?T0N6A+KD/a6moz8CA5KaE/Ed9i2f/U5YGBvzfYK2e3qj/JFyNP1QPHwIkgwh?=
 =?us-ascii?Q?WaGqtU4FkCk4/NPRzQ6x6wyE6ApkTBfQ3a+BmFA/idSV8+2V9bJS1CL4Xlm8?=
 =?us-ascii?Q?hSbSKk5TQmFwwwHWlWrwAc8JEWHsI9i9AcXtwwyvn+AEa/qMCksN44xgjdLC?=
 =?us-ascii?Q?9By9lH1DrjOT/3/R9jfRHVPJ4CbJiBu8dbvzu8YTzUKbsMmwWz6mxPqKdy/d?=
 =?us-ascii?Q?OxM6yObFVyE/KmIEso3MFbsaj17KIu60IhtMU/9cKUPfb9UrtONK6VDFNXKj?=
 =?us-ascii?Q?9LKRCaM8MPvLKR2r/XlyK/q63yt9cJmvMfA9hkSaU3z3RKOOVkMms8lDgv7w?=
 =?us-ascii?Q?geD898wKbeGL40pBNN9xIrfWoWZS+Bzdv1dTThiURab0NBcXZ95PABwH2AkX?=
 =?us-ascii?Q?hkDAY/j8OCCNFD2zBBs9qyDNi1x38S2lFPJlh8X00b6EK5t8NLFmTojGid2x?=
 =?us-ascii?Q?qALU94LKwpNBH1VwCiWdgGkojK6NiYgGIVGLzBu0C+L0/UcBM6FhRooL1aGC?=
 =?us-ascii?Q?BDlS0xFiqUM/LgrdVvEZWqeX35ZS8Ss4acXM3RCr8buaVephMyDQHvNwLx0A?=
 =?us-ascii?Q?RlVJtYos9qzsoOv2cizvaAgdPFkkz29S/ESiVBMT4CGaT/qh0Rj+2MlKss/c?=
 =?us-ascii?Q?HXG52SnETd3OktP3nzsMSp+CBHDEAO4d0MuF0cCgBbAGqzO9BEluxk4JHDSi?=
 =?us-ascii?Q?PTErt1Mlzzq955wXTu/ZLdZMG/jTRyguRqBnACwbgux6/Ka7pYRCe0PrN6zc?=
 =?us-ascii?Q?t2U2peikrYTJJjWjcSJHofssC3/y8HkYJI1t3JHgSGrwl+YC1MsEgui+jYHx?=
 =?us-ascii?Q?LTE9zsI0wTc5uJNwLT2yER0T1pZVHcWHDhfV4t5oa0yMiRU90AUifKaL04Gn?=
 =?us-ascii?Q?2elKyy3Nb7b6CBU/axCvtUs5iRF2p//SDgbHpn12DMVcxCiorGPrgIobNwed?=
 =?us-ascii?Q?guDpPfgXDajEj9AxqL6OLMvZ2EBzGFO/xbGUJy/vCv7mDmjrf452VxZvlMra?=
 =?us-ascii?Q?YDic97H07O/TxBMbWkMn+nsVw5/bB3GOrExXfnVMi9T9WVmAkH+AgIhFhuBY?=
 =?us-ascii?Q?W4ueGUFPQgWqDHpAIK4I82sw1II3EoWoRCxa1A9hP2dZe8cVfYTeGWTZt0zk?=
 =?us-ascii?Q?OJ0D1oqjSZqZAXagrepsZCVya/yIq06hqbFFqtOsNnrxEUSB7hlKtgiPeRvb?=
 =?us-ascii?Q?uyi9LhYI6n8GDyWJKP8DYw43ctnvlIFGiNZcLQMlG1ZU5FuBSJNs/PPZ7I0I?=
 =?us-ascii?Q?DUqvc0q+Nw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e6a68e-42e0-4747-8544-08ded674a949
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:56:08.5632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVccLf/XSJ5RBP471nXbs9hke5nDpKPI8hwR8UGPh2Og3ZBViBo/YHVLfvdkHCRIzMviB3FCVr0hsrfD6uR/spBn7UL2wnIkTs8ot6Ebgqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5085
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:28 +0200
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

Add the RSU core library for the Stratix 10 / Agilex family of SoCs.
RSU lets the SoC boot from one of several configuration images held in
SPI NOR flash and recover to a known-good factory image when an update
fails. The feature is implemented in the SDM firmware and the on-board
Cadence QSPI flash; this library drives it through the SDM mailbox (or
an SMC call when running on top of Arm Trusted Firmware) and the
SPI-NOR framework.

The library is split into the generic session/command layer (rsu.c),
the helper and SPT/CPB logic (rsu_misc.c), the QSPI low-level backend
(rsu_ll_qspi.c, rsu_s10.c) and the optional secure-monitor SMC handler
(smc_rsu_s10.c, built only with ARMV8_PSCI). The decision-firmware
version/status copy paths select the SMC client form under SPL_ATF, the
secure-RAM form when U-Boot is itself the monitor (ARMV8_PSCI), and are
a no-op otherwise.

Add the CMD_SOCFPGA_RSU and SOCFPGA_RSU_SF_CS Kconfig symbols that gate
the library and select the RSU SPT/CPB chip-select. The objects are
built for U-Boot proper only.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/Kconfig       |   12 +
 arch/arm/mach-socfpga/Makefile      |    7 +
 arch/arm/mach-socfpga/rsu.c         | 1210 ++++++++++++++
 arch/arm/mach-socfpga/rsu_ll_qspi.c | 2402 +++++++++++++++++++++++++++
 arch/arm/mach-socfpga/rsu_misc.c    |  854 ++++++++++
 arch/arm/mach-socfpga/rsu_s10.c     |  459 +++++
 arch/arm/mach-socfpga/smc_rsu_s10.c |  188 +++
 cmd/Kconfig                         |   11 +
 8 files changed, 5143 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/rsu.c
 create mode 100644 arch/arm/mach-socfpga/rsu_ll_qspi.c
 create mode 100644 arch/arm/mach-socfpga/rsu_misc.c
 create mode 100644 arch/arm/mach-socfpga/rsu_s10.c
 create mode 100644 arch/arm/mach-socfpga/smc_rsu_s10.c

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index fb98b647442..ff961e7f13c 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -6,6 +6,18 @@ config ERR_PTR_OFFSET
 config NR_DRAM_BANKS
 	default 1
 
+config SOCFPGA_RSU_SF_CS
+	int "SPI flash chip-select used by the RSU flow (SPT/CPB)"
+	depends on CMD_SOCFPGA_RSU
+	depends on SPI_FLASH || DM_SPI_FLASH
+	default SF_DEFAULT_CS
+	help
+	  Chip select of the SPI flash that holds the RSU sub-partition
+	  table (SPT) and configuration pointer block (CPB) metadata.
+	  Independent from SF_DEFAULT_CS (which selects the flash SPL
+	  loads u-boot.itb from). Override only when RSU metadata lives
+	  on a different chip select than the u-boot.itb boot image.
+
 config SOCFPGA_SECURE_VAB_AUTH
 	bool "Enable boot image authentication with Secure Device Manager"
 	depends on ARCH_SOCFPGA_AGILEX || ARCH_SOCFPGA_N5X || \
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index b6f35ddacc4..109af31ceb8 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -138,6 +138,13 @@ endif
 else
 obj-$(CONFIG_SPL_ATF) += secure_reg_helper.o
 obj-$(CONFIG_SPL_ATF) += smc_api.o
+ifdef CONFIG_CMD_SOCFPGA_RSU
+obj-y	+= rsu.o
+obj-y	+= rsu_misc.o
+obj-y	+= rsu_ll_qspi.o
+obj-y	+= rsu_s10.o
+obj-$(CONFIG_ARMV8_PSCI)	+= smc_rsu_s10.o
+endif
 endif
 
 ifdef CONFIG_ARCH_SOCFPGA_GEN5
diff --git a/arch/arm/mach-socfpga/rsu.c b/arch/arm/mach-socfpga/rsu.c
new file mode 100644
index 00000000000..a8c822bf753
--- /dev/null
+++ b/arch/arm/mach-socfpga/rsu.c
@@ -0,0 +1,1210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include <dm/device.h>
+#include <dm/ofnode.h>
+#include <asm/arch/rsu.h>
+#include <asm/arch/rsu_misc.h>
+#include <asm/arch/smc_api.h>
+#include <asm/arch/socfpga_rsu_dm.h>
+#include <asm/secure.h>
+#include <asm/system.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/intel-smc.h>
+
+/* RSU Notify Bitmasks */
+#define RSU_NOTIFY_IGNORE_STAGE         BIT(18)
+#define RSU_NOTIFY_CLEAR_ERROR_STATUS   BIT(17)
+#define RSU_NOTIFY_RESET_RETRY_COUNTER  BIT(16)
+
+/* Cached anchor; valid as long as the misc device stays bound. */
+static struct udevice *rsu_dm_dev;
+
+static struct rsu_ll_intf **rsu_ll_ptrp(void)
+{
+	struct socfpga_rsu_priv *priv;
+	int ret;
+	ofnode node;
+
+	if (rsu_dm_dev)
+		goto have_dev;
+
+	/* Locate by compatible to avoid hard-coding a DT path. */
+	node = ofnode_by_compatible(ofnode_null(), "altr,socfpga-rsu");
+	if (!ofnode_valid(node))
+		return NULL;
+	ret = device_get_global_by_ofnode(node, &rsu_dm_dev);
+	if (ret)
+		return NULL;
+have_dev:
+	priv = dev_get_priv(rsu_dm_dev);
+
+	return &priv->ll;
+}
+
+static struct rsu_ll_intf *rsu_ll(void)
+{
+	struct rsu_ll_intf **p = rsu_ll_ptrp();
+
+	return p ? *p : NULL;
+}
+
+/**
+ * rsu_init() - initialize flash driver, SPT and CPB data
+ * @filename: ignored; kept for ABI compatibility with librsu.
+ *
+ * If a previous session is still active, it is closed and re-opened so
+ * a stale state cannot wedge subsequent commands.
+ *
+ * Returns: 0 on success, or the errno from the low-level backend init.
+ */
+int rsu_init(char *filename)
+{
+	int ret;
+	struct rsu_ll_intf **llp = rsu_ll_ptrp();
+
+	(void)filename;
+
+	if (!llp)
+		return -ENODEV;
+
+	if (*llp) {
+		rsu_log(RSU_ERR,
+			"ll_intf already initialized; resetting\n");
+		/* Tear down the stale session and re-initialize below. */
+		rsu_exit();
+	}
+
+	ret = rsu_ll_qspi_init(llp);
+	if (ret) {
+		rsu_exit();
+		/* Preserve the backend errno for callers and tests. */
+		return ret;
+	}
+
+	/* Backend success but no session pointer: report as -ENODEV. */
+	if (!*llp) {
+		rsu_exit();
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/**
+ * rsu_exit() - free flash driver, clean SPT and CPB data
+ */
+void rsu_exit(void)
+{
+	struct rsu_ll_intf **llp = rsu_ll_ptrp();
+
+	if (!llp || !*llp)
+		return;
+	if ((*llp)->exit)
+		(*llp)->exit();
+	*llp = NULL;
+}
+
+/**
+ * rsu_spt_corrupted_info() - output warning info to user
+ */
+void rsu_spt_corrupted_info(void)
+{
+	rsu_log(RSU_ERR, "corrupted SPT --");
+	rsu_log(RSU_ERR, "run rsu restore_spt <address> first\n");
+}
+
+/**
+ * rsu_cpb_corrupted_info() - output warning info to user
+ */
+void rsu_cpb_corrupted_info(void)
+{
+	rsu_log(RSU_ERR, "corrupted CPB --");
+	rsu_log(RSU_ERR, "run rsu create_empty_cpb");
+	rsu_log(RSU_ERR, "or rsu restore_cpb <address> first\n");
+};
+
+/**
+ * rsu_slot_count() - get the number of slots defined
+ *
+ * Returns: the number of defined slots
+ */
+int rsu_slot_count(void)
+{
+	int partitions;
+	int cnt = 0;
+	int x;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	partitions = rsu_ll()->partition.count();
+
+	for (x = 0; x < partitions; x++) {
+		if (rsu_misc_is_slot(rsu_ll(), x))
+			cnt++;
+	}
+
+	return cnt;
+}
+
+/**
+ * rsu_slot_by_name() - get slot number based on name
+ * @name: name of slot
+ *
+ * Return: slot number on success, or error code
+ */
+int rsu_slot_by_name(char *name)
+{
+	int partitions;
+	int cnt = 0;
+	int x;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (!name)
+		return -EARGS;
+
+	partitions = rsu_ll()->partition.count();
+
+	for (x = 0; x < partitions; x++) {
+		if (rsu_misc_is_slot(rsu_ll(), x)) {
+			if (!strcmp(name, rsu_ll()->partition.name(x)))
+				return cnt;
+			cnt++;
+		}
+	}
+
+	return -ENAME;
+}
+
+/**
+ * rsu_slot_get_info() - get the attributes of a slot
+ * @slot: slot number
+ * @info: pointer to info structure to be filled in
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_get_info(int slot, struct rsu_slot_info *info)
+{
+	int part_num;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (!info)
+		return -EARGS;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (rsu_ll()->cpb_ops.corrupted()) {
+		rsu_cpb_corrupted_info();
+		return -ECORRUPTED_CPB;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	part_num = rsu_misc_slot2part(rsu_ll(), slot);
+	if (part_num < 0)
+		return -EINVAL;
+
+	rsu_misc_safe_strcpy(info->name, sizeof(info->name),
+			     rsu_ll()->partition.name(part_num),
+			     sizeof(info->name));
+
+	info->offset = rsu_ll()->partition.offset(part_num);
+	info->size = rsu_ll()->partition.size(part_num);
+	info->priority = rsu_ll()->priority.get(part_num);
+
+	return 0;
+}
+
+/**
+ * rsu_slot_size() - get the size of a slot
+ * @slot: slot number
+ *
+ * Returns: the size of the slot in bytes, or error code
+ */
+int rsu_slot_size(int slot)
+{
+	int part_num;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	part_num = rsu_misc_slot2part(rsu_ll(), slot);
+	if (part_num < 0)
+		return -ESLOTNUM;
+
+	return rsu_ll()->partition.size(part_num);
+}
+
+/**
+ * rsu_slot_priority() - get the Decision CMF load priority of a slot
+ * @slot: slot number
+ *
+ * Priority of zero means the slot has no priority and is disabled.
+ * The slot with priority of one has the highest priority.
+ *
+ * Returns: the priority of the slot, or error code
+ */
+int rsu_slot_priority(int slot)
+{
+	int part_num;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (rsu_ll()->cpb_ops.corrupted()) {
+		rsu_cpb_corrupted_info();
+		return -ECORRUPTED_CPB;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	part_num = rsu_misc_slot2part(rsu_ll(), slot);
+	if (part_num < 0)
+		return -ESLOTNUM;
+
+	return rsu_ll()->priority.get(part_num);
+}
+
+/**
+ * rsu_slot_erase() - erase all data in a slot
+ * @slot: slot number
+ *
+ * Erase all data in a slot to prepare for programming. Remove the slot
+ * if it is in the CMF pointer block.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_erase(int slot)
+{
+	int part_num;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (rsu_ll()->cpb_ops.corrupted()) {
+		rsu_cpb_corrupted_info();
+		return -ECORRUPTED_CPB;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	if (rsu_misc_writeprotected(slot)) {
+		rsu_log(RSU_ERR, "Trying to erase a write protected slot\n");
+		return -EWRPROT;
+	}
+
+	part_num = rsu_misc_slot2part(rsu_ll(), slot);
+	if (part_num < 0)
+		return -ESLOTNUM;
+
+	if (rsu_ll()->priority.remove(part_num))
+		return -ELOWLEVEL;
+
+	if (rsu_ll()->data.erase(part_num))
+		return -ELOWLEVEL;
+
+	return 0;
+}
+
+/**
+ * rsu_slot_program_buf() - program a slot from FPGA buffer data
+ * @slot: slot number
+ * @buf: pointer to data buffer
+ * @size: bytes to read from buffer, in hex value
+ *
+ * This function is used to program a slot using FPGA config data from
+ * a buffer and then enter the slot into CPB.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_program_buf(int slot, void *buf, int size)
+{
+	int ret;
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (rsu_ll()->cpb_ops.corrupted()) {
+		rsu_cpb_corrupted_info();
+		return -ECORRUPTED_CPB;
+	}
+
+	if (rsu_cb_buf_init(buf, size)) {
+		rsu_log(RSU_ERR, "Bad buf/size arguments\n");
+		return -EARGS;
+	}
+
+	ret = rsu_cb_program_common(rsu_ll(), slot, rsu_cb_buf, 0);
+	if (ret) {
+		rsu_log(RSU_ERR, "fail to program buf data\n");
+		return ret;
+	}
+
+	rsu_cb_buf_exit();
+	return ret;
+}
+
+/**
+ * rsu_slot_program_factory_update_buf() - program a slot using factory update
+ *                                         data from a buffer
+ * @slot: slot number
+ * @buf: pointer to data buffer
+ * @size: bytes to read from buffer
+ *
+ * This function is used to program a slot using factory update data from a
+ * buffer and then enter the slot into CPB.
+ *
+ * Returns 0 on success, or error code
+ */
+int rsu_slot_program_factory_update_buf(int slot, void *buf, int size)
+{
+	return rsu_slot_program_buf(slot, buf, size);
+}
+
+/**
+ * rsu_slot_program_buf_raw() - program a slot from raw buffer data
+ * @slot: slot number
+ * @buf: pointer to data buffer
+ * @size: bytes to read from buffer, in hex value
+ *
+ * This function is used to program a slot using raw data from a buffer,
+ * the slot is not entered into CPB.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_program_buf_raw(int slot, void *buf, int size)
+{
+	int ret;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	if (rsu_cb_buf_init(buf, size)) {
+		rsu_log(RSU_ERR, "Bad buf/size arguments\n");
+		return -EARGS;
+	}
+
+	ret = rsu_cb_program_common(rsu_ll(), slot, rsu_cb_buf, 1);
+	if (ret) {
+		rsu_log(RSU_ERR, "fail to program raw data\n");
+		return ret;
+	}
+
+	rsu_cb_buf_exit();
+	return ret;
+}
+
+/**
+ * rsu_slot_verify_buf() - verify FPGA config data in a slot
+ * @slot: slot number
+ * @buf: pointer to data buffer
+ * @size: bytes to read from buffer, in hex value
+ *
+ * This function is used to verify FPGA configuration data in a selected
+ * slot against the provided buffer.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_verify_buf(int slot, void *buf, int size)
+{
+	int ret;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (rsu_ll()->cpb_ops.corrupted()) {
+		rsu_cpb_corrupted_info();
+		return -ECORRUPTED_CPB;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	if (rsu_cb_buf_init(buf, size)) {
+		rsu_log(RSU_ERR, "Bad buf/size arguments\n");
+		return -EARGS;
+	}
+
+	ret = rsu_cb_verify_common(rsu_ll(), slot, rsu_cb_buf, 0);
+	if (ret) {
+		rsu_log(RSU_ERR, "fail to verify buffer data\n");
+		return ret;
+	}
+
+	rsu_cb_buf_exit();
+
+	return ret;
+}
+
+/**
+ * rsu_slot_verify_buf_raw() - verify raw data in a slot
+ * @slot: slot number
+ * @buf: pointer to data buffer
+ * @size: bytes to read from buffer, in hex value
+ *
+ * This function is used to verify raw data in a selected slot against
+ * the provided buffer.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_verify_buf_raw(int slot, void *buf, int size)
+{
+	int ret;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	if (rsu_cb_buf_init(buf, size)) {
+		rsu_log(RSU_ERR, "Bad buf/size arguments\n");
+		return -EARGS;
+	}
+
+	ret = rsu_cb_verify_common(rsu_ll(), slot, rsu_cb_buf, 1);
+	if (ret) {
+		rsu_log(RSU_ERR, "fail to verify raw data\n");
+		return ret;
+	}
+
+	rsu_cb_buf_exit();
+	return ret;
+}
+
+/**
+ * rsu_slot_enable() - enable the selected slot
+ * @slot: slot number
+ *
+ * Set the selected slot as the highest priority. It will be the first
+ * slot to be tried after a power-on reset.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_enable(int slot)
+{
+	int part_num;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (rsu_ll()->cpb_ops.corrupted()) {
+		rsu_cpb_corrupted_info();
+		return -ECORRUPTED_CPB;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	part_num = rsu_misc_slot2part(rsu_ll(), slot);
+	if (part_num < 0)
+		return -ESLOTNUM;
+
+	if (rsu_ll()->priority.remove(part_num))
+		return -ELOWLEVEL;
+
+	if (rsu_ll()->priority.add(part_num))
+		return -ELOWLEVEL;
+
+	return 0;
+}
+
+/**
+ * rsu_slot_disable() - disable the selected slot
+ * @slot: slot number
+ *
+ * Remove the selected slot from the priority scheme, but don't erase the
+ * slot data so that it can be re-enabled.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_disable(int slot)
+{
+	int part_num;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (rsu_ll()->cpb_ops.corrupted()) {
+		rsu_cpb_corrupted_info();
+		return -ECORRUPTED_CPB;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	part_num = rsu_misc_slot2part(rsu_ll(), slot);
+	if (part_num < 0)
+		return -ESLOTNUM;
+
+	if (rsu_ll()->priority.remove(part_num))
+		return -ELOWLEVEL;
+
+	return 0;
+}
+
+/**
+ * rsu_slot_load() - load the selected slot
+ * @slot: slot number
+ *
+ * This function is used to request the selected slot to be loaded
+ * immediately. On success the system is rebooted after a short delay.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_load(int slot)
+{
+	int part_num;
+	u64 offset;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (rsu_ll()->cpb_ops.corrupted()) {
+		rsu_cpb_corrupted_info();
+		return -ECORRUPTED_CPB;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	part_num = rsu_misc_slot2part(rsu_ll(), slot);
+	if (part_num < 0)
+		return -ESLOTNUM;
+
+	offset = rsu_ll()->partition.offset(part_num);
+
+	return rsu_ll()->fw_ops.load(offset);
+}
+
+/**
+ * rsu_slot_load_factory() - load the factory image
+ *
+ * This function is used to request the factory image to be loaded
+ * immediately. On success, the system is rebooted after a short delay.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_load_factory(void)
+{
+	int part_num;
+	int partitions;
+	u64 offset;
+	char name[] = "FACTORY_IMAGE";
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	partitions = rsu_ll()->partition.count();
+	for (part_num = 0; part_num < partitions; part_num++) {
+		if (!strcmp(name, rsu_ll()->partition.name(part_num)))
+			break;
+	}
+
+	if (part_num >= partitions) {
+		rsu_log(RSU_ERR, "No FACTORY_IMAGE partition defined\n");
+		return -EFORMAT;
+	}
+
+	offset = rsu_ll()->partition.offset(part_num);
+	return rsu_ll()->fw_ops.load(offset);
+}
+
+/**
+ * rsu_slot_rename() - Rename the selected slot.
+ * @slot: slot number
+ * @name: new name for slot
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_rename(int slot, char *name)
+{
+	int part_num;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	if (!name)
+		return -EARGS;
+
+	part_num = rsu_misc_slot2part(rsu_ll(), slot);
+	if (part_num < 0)
+		return -ESLOTNUM;
+
+	if (rsu_misc_is_rsvd_name(name)) {
+		rsu_log(RSU_ERR, "Partition rename uses a reserved name\n");
+		return -ENAME;
+	}
+
+	if (rsu_ll()->partition.rename(part_num, name))
+		return -ENAME;
+
+	return 0;
+}
+
+/**
+ * rsu_slot_delete() - Delete the selected slot.
+ * @slot: slot number
+ *
+ * Returns 0 on success, or Error Code
+ */
+int rsu_slot_delete(int slot)
+{
+	int part_num;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (rsu_ll()->cpb_ops.corrupted()) {
+		rsu_cpb_corrupted_info();
+		return -ECORRUPTED_CPB;
+	}
+
+	if (slot < 0 || slot >= rsu_slot_count()) {
+		rsu_log(RSU_ERR, "Invalid slot number\n");
+		return -ESLOTNUM;
+	}
+
+	if (rsu_misc_writeprotected(slot)) {
+		rsu_log(RSU_ERR, "Trying to delete a write protected slot\n");
+		return -EWRPROT;
+	}
+
+	part_num = rsu_misc_slot2part(rsu_ll(), slot);
+	if (part_num < 0)
+		return -ESLOTNUM;
+
+	if (rsu_ll()->priority.remove(part_num))
+		return -ELOWLEVEL;
+
+	if (rsu_ll()->data.erase(part_num))
+		return -ELOWLEVEL;
+
+	if (rsu_ll()->partition.delete(part_num))
+		return -ELOWLEVEL;
+
+	return 0;
+}
+
+/**
+ * rsu_slot_create() - Create a new slot.
+ * @name: slot name
+ * @address: slot start address
+ * @size: slot size
+ *
+ * Returns 0 on success, or Error Code
+ */
+int rsu_slot_create(char *name, u64 address, unsigned int size)
+{
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	if (rsu_misc_is_rsvd_name(name)) {
+		rsu_log(RSU_ERR, "Partition create uses a reserved name\n");
+		return -ENAME;
+	}
+
+	if (rsu_ll()->partition.create(name, address, size))
+		return -ELOWLEVEL;
+
+	return 0;
+}
+
+/**
+ * rsu_status_log() - Copy firmware status log to info struct
+ * @info: pointer to info struct to fill in
+ *
+ * Return 0 on success, or error code
+ */
+int rsu_status_log(struct rsu_status_info *info)
+{
+	if (!rsu_ll())
+		return -EINTF;
+
+	return rsu_ll()->fw_ops.status(info);
+}
+
+/**
+ * rsu_notify() - report HPS software execution stage as a 16bit number
+ * @stage: software execution stage
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_notify(int stage)
+{
+	u32 arg;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	arg = stage & GENMASK(15, 0);
+	return rsu_ll()->fw_ops.notify(arg);
+}
+
+/**
+ * rsu_clear_error_status() - clear errors from the current RSU status log
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_clear_error_status(void)
+{
+	struct rsu_status_info info;
+	u32 arg;
+	int ret;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	ret = rsu_status_log(&info);
+	if (ret < 0)
+		return ret;
+
+	if (!RSU_VERSION_ACMF_VERSION(info.version))
+		return -ELOWLEVEL;
+
+	arg = RSU_NOTIFY_IGNORE_STAGE | RSU_NOTIFY_CLEAR_ERROR_STATUS;
+	return rsu_ll()->fw_ops.notify(arg);
+}
+
+/**
+ * rsu_reset_retry_counter() - reset the retry counter
+ *
+ * This function is used to request the retry counter to be reset, so that the
+ * currently running image may be tried again after the next watchdog timeout.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_reset_retry_counter(void)
+{
+	struct rsu_status_info info;
+	u32 arg;
+	int ret;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	ret = rsu_status_log(&info);
+	if (ret < 0)
+		return ret;
+
+	if (!RSU_VERSION_ACMF_VERSION(info.version) ||
+	    !RSU_VERSION_DCMF_VERSION(info.version))
+		return -ELOWLEVEL;
+
+	arg = RSU_NOTIFY_IGNORE_STAGE | RSU_NOTIFY_RESET_RETRY_COUNTER;
+	return rsu_ll()->fw_ops.notify(arg);
+}
+
+#ifdef CONFIG_ARMV8_PSCI
+extern u32 smc_rsu_dcmf_version[4];
+#endif
+
+static int copy_dcmf_version_to_smc(u32 *versions)
+{
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
+	u64 args[2];
+#elif defined(CONFIG_ARMV8_PSCI)
+	void *dcmf_versions;
+#endif
+
+	if (!versions)
+		return -EINVAL;
+
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
+	args[0] = ((u64)versions[1] << 32) | versions[0];
+	args[1] = ((u64)versions[3] << 32) | versions[2];
+
+	if (invoke_smc(INTEL_SIP_SMC_RSU_COPY_DCMF_VERSION, args,
+		       ARRAY_SIZE(args), NULL, 0))
+		return -EINVAL;
+#elif defined(CONFIG_ARMV8_PSCI)
+	/*
+	 * U-Boot is the secure monitor: stash the versions in secure RAM
+	 * so the in-U-Boot RSU SMC handler can serve them later. Convert
+	 * the address of smc_rsu_dcmf_version to its pre-relocation form.
+	 */
+	dcmf_versions = (char *)__secure_start - CONFIG_ARMV8_SECURE_BASE +
+			(u64)secure_ram_addr(smc_rsu_dcmf_version);
+
+	memcpy(dcmf_versions, versions, sizeof(*versions) * 4);
+#endif
+	return 0;
+}
+
+/**
+ * rsu_dcmf_version() - retrieve the decision firmware version
+ * @versions: pointer to where the four DCMF versions will be stored
+ *
+ * This function is used to retrieve the version of each of the four DCMF copies
+ * in flash and also report the values to the SMC handler.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_dcmf_version(u32 *versions)
+{
+	int ret;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (!versions)
+		return -EARGS;
+
+	ret = rsu_ll()->fw_ops.dcmf_version(versions);
+	if (ret)
+		return ret;
+
+	return copy_dcmf_version_to_smc(versions);
+}
+
+/**
+ * rsu_max_retry() - retrieve the max_retry parameter
+ * @value: pointer to where the max_retry will be stored
+ *
+ * This function is used to retrieve the max_retry parameter from the decision
+ * firmware section in flash
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_max_retry(u8 *value)
+{
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
+	u64 arg;
+#endif
+	int ret;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (!value)
+		return -EARGS;
+
+	ret = rsu_ll()->fw_ops.max_retry(value);
+	if (ret)
+		return ret;
+
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
+	arg = *value;
+	if (invoke_smc(INTEL_SIP_SMC_RSU_COPY_MAX_RETRY, &arg, 1, NULL, 0))
+		return -EINVAL;
+	return 0;
+#elif defined(CONFIG_ARMV8_PSCI)
+	return smc_store_max_retry(*value);
+#else
+	return 0;
+#endif
+}
+
+#ifdef CONFIG_ARMV8_PSCI
+extern u16 smc_rsu_dcmf_status[4];
+#endif
+
+static int copy_dcmf_status_to_smc(u16 *status)
+{
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
+	u64 arg;
+#elif defined(CONFIG_ARMV8_PSCI)
+	void *dcmf_status;
+#endif
+
+	if (!status)
+		return -EINVAL;
+
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
+	arg = ((u64)status[3] << 48) | ((u64)status[2] << 32) |
+	      ((u64)status[1] << 16) | status[0];
+	if (invoke_smc(INTEL_SIP_SMC_RSU_COPY_DCMF_STATUS, &arg, 1, NULL, 0))
+		return -EINVAL;
+#elif defined(CONFIG_ARMV8_PSCI)
+	/*
+	 * U-Boot is the secure monitor: stash the status in secure RAM so
+	 * the in-U-Boot RSU SMC handler can serve it later. Convert the
+	 * address of smc_rsu_dcmf_status to its pre-relocation form.
+	 */
+	dcmf_status = (char *)__secure_start - CONFIG_ARMV8_SECURE_BASE +
+			(u64)secure_ram_addr(smc_rsu_dcmf_status);
+
+	memcpy(dcmf_status, status, sizeof(*status) * 4);
+#endif
+	return 0;
+}
+
+/**
+ * rsu_dcmf_status() - retrieve the decision firmware status
+ * @status: pointer to where the statuses will be stored
+ *
+ * This function is used to determine whether decision firmware copies are
+ * corrupted in flash, with the currently used decision firmware being used as
+ * reference. The status is an array of 4 values, one for each decision
+ * firmware copy. A 0 means the copy is fine, anything else means the copy is
+ * corrupted. The status is also reported to the SMC handler.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_dcmf_status(u16 *status)
+{
+	int ret;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (!status)
+		return -EARGS;
+
+	ret = rsu_ll()->fw_ops.dcmf_status(status);
+	if (ret)
+		return ret;
+
+	return copy_dcmf_status_to_smc(status);
+}
+
+/**
+ * rsu_create_empty_cpb() - create a CPB with header field only
+ *
+ * This function is used to create a empty configuration pointer block
+ * (CPB) with the header field only.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_create_empty_cpb(void)
+{
+	if (!rsu_ll())
+		return -EINTF;
+
+	return rsu_ll()->cpb_ops.empty();
+}
+
+/**
+ * rsu_restore_cpb() - restore the cpb from an address
+ * @address: the address which cpb will be restored from.
+ *
+ * This function is used to restore a saved CPB from an address.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_restore_cpb(u64 address)
+{
+	if (!rsu_ll())
+		return -EINTF;
+
+	return rsu_ll()->cpb_ops.restore(address);
+}
+
+/**
+ * rsu_save_cpb() - save cpb to the address
+ * @address: the address which cpb will be saved to.
+ *
+ * This function is used to save CPB to an address.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_save_cpb(u64 address)
+{
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->cpb_ops.corrupted()) {
+		rsu_cpb_corrupted_info();
+		return -ECORRUPTED_CPB;
+	}
+
+	return rsu_ll()->cpb_ops.save(address);
+}
+
+/**
+ * rsu_restore_spt() - restore the spt from an address
+ * @address: the address which spt will be restored from.
+ *
+ * This function is used to restore a saved SPT from an address.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_restore_spt(u64 address)
+{
+	if (!rsu_ll())
+		return -EINTF;
+
+	return rsu_ll()->spt_ops.restore(address);
+}
+
+/**
+ * rsu_save_spt() - save spt to the address
+ * @address: the address which spt will be saved to.
+ *
+ * This function is used to save SPT to an address.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_save_spt(u64 address)
+{
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	return rsu_ll()->spt_ops.save(address);
+}
+
+/**
+ * rsu_running_factory() - determine if current running image is factory image
+ * @factory: set to non-zero value when running factory image, zero otherwise
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_running_factory(int *factory)
+{
+	s64 factory_offset;
+	struct rsu_status_info status;
+
+	if (!rsu_ll())
+		return -EINTF;
+
+	if (rsu_ll()->spt_ops.corrupted()) {
+		rsu_spt_corrupted_info();
+		return -ECORRUPTED_SPT;
+	}
+
+	factory_offset = rsu_ll()->partition.factory_offset();
+	if (factory_offset < 0)
+		return -ELOWLEVEL;
+
+	if (rsu_ll()->fw_ops.status(&status))
+		return -ELOWLEVEL;
+
+	*factory = (factory_offset == status.current_image);
+	return 0;
+}
diff --git a/arch/arm/mach-socfpga/rsu_ll_qspi.c b/arch/arm/mach-socfpga/rsu_ll_qspi.c
new file mode 100644
index 00000000000..423df4dd676
--- /dev/null
+++ b/arch/arm/mach-socfpga/rsu_ll_qspi.c
@@ -0,0 +1,2402 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include <env.h>
+#include <limits.h>
+#include <malloc.h>
+#include <spi.h>
+#include <spi_flash.h>
+#include <stdio.h>
+#include <asm/arch/mailbox_s10.h>
+#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
+#include <dm/device.h>
+#endif
+#include <asm/arch/rsu_flash_if.h>
+#include <asm/arch/rsu.h>
+#include <asm/arch/rsu_misc.h>
+#include <asm/arch/smc_api.h>
+#include <linux/errno.h>
+#include <linux/intel-smc.h>
+#include <linux/kconfig.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+#include <u-boot/zlib.h>
+
+#define SPT_MAGIC_NUMBER	0x57713427
+#define SPT_FLAG_RESERVED	1
+#define SPT_FLAG_READONLY	2
+#define SPT_OFFSET_MBOX		4
+
+#define CPB_MAGIC_NUMBER	0x57789609
+#define CPB_HEADER_SIZE		24
+
+#define ERASED_ENTRY		((u64)-1)
+#define SPENT_ENTRY		((u64)0)
+
+#define SPT_VERSION		0
+#define LIBRSU_VER		0
+
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
+#define DCMF_SIZE		0x040000
+#define DCMF0_VERSION_OFFSET	0x000420
+#define DCMF1_VERSION_OFFSET	0x040420
+#define DCMF2_VERSION_OFFSET	0x080420
+#define DCMF3_VERSION_OFFSET	0x0C0420
+#define DCIO_MAX_RETRY_OFFSET   0x10018C
+#else
+#define DCMF_SIZE		0x080000
+#define DCMF0_VERSION_OFFSET	0x000420
+#define DCMF1_VERSION_OFFSET	0x080420
+#define DCMF2_VERSION_OFFSET	0x100420
+#define DCMF3_VERSION_OFFSET	0x180420
+#define DCIO_MAX_RETRY_OFFSET   0x20018C
+#endif
+
+/* maximum supported QSPI from programmer */
+#define QSPI_MAX_DEVICE		4
+#define SPT_MAX_PARTITIONS	127
+#define MIN_QSPI_ERASE_SIZE	4096
+
+#define CPB_SIZE		SZ_4K
+#define SPT_SIZE		SZ_4K
+#define CPB_IMAGE_PTR_OFFSET	32
+#define CPB_IMAGE_PTR_NSLOTS	508
+
+#define SPT_CHECKSUM_OFFSET	0x0C
+
+#define FACTORY_IMAGE_NAME	"FACTORY_IMAGE"
+
+/**
+ * struct sub_partition_table_partition - SPT partition structure
+ * @name: sub-partition name
+ * @offset: sub-partition start offset
+ * @length: sub-partition length
+ * @flags: sub-partition flags
+ */
+struct sub_partition_table_partition {
+	char name[16];
+	u64 offset;
+	u32 length;
+	u32 flags;
+};
+
+/**
+ * struct sub_partition_table - sub partition table structure
+ * @magic_number: the magic number
+ * @version: version number
+ * @partitions: number of entries
+ * @revd: reserved
+ * @sub_partition_table_partition.partition: SPT partition array
+ */
+struct sub_partition_table {
+	u32 magic_number;
+	u32 version;
+	u32 partitions;
+	u32 checksum;
+	u32 rsvd[4];
+	struct sub_partition_table_partition partition[SPT_MAX_PARTITIONS];
+};
+
+/**
+ * union cmf_pointer_block - CMF pointer block
+ * @header.magic_number: CMF pointer block magic number
+ * @header.header_size: size of CMF pointer block header
+ * @header.cpb_size: size of CMF pointer block
+ * @header.cpb_reserved: reserved
+ * @header.image_ptr_offset: offset of image pointers
+ * @header.image_ptr_slots: number of image pointer slots
+ * @data: image pointer slot array
+ */
+union cmf_pointer_block {
+	struct {
+		u32 magic_number;
+		u32 header_size;
+		u32 cpb_size;
+		u32 cpb_reserved;
+		u32 image_ptr_offset;
+		u32 image_ptr_slots;
+	} header;
+	char data[4 * 1024];
+};
+
+/* retrieve multiple qspi info from mailbox */
+struct flash_info {
+	u32 size;
+	u32 erasesize;
+};
+
+/**
+ * struct rsu_qspi_priv - per-session QSPI RSU backend state
+ *
+ * Allocated in rsu_ll_qspi_init(), released in ll_exit(); SPT/CPB cached
+ * copies are memset before free to shorten sensitive data lifetime in RAM.
+ */
+struct rsu_qspi_priv {
+	union cmf_pointer_block cpb;
+	struct sub_partition_table spt;
+	u64 *cpb_slots;
+#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
+	struct udevice **flashlist;
+	struct udevice *flash;
+#else
+	struct spi_flash **flashlist;
+	struct spi_flash *flash;
+#endif
+	u32 spt0_offset;
+	u32 spt1_offset;
+	int cpb0_part;
+	int cpb1_part;
+	int num_flash;
+	bool cpb_corrupted;
+	bool cpb_fixed;
+	bool spt_corrupted;
+};
+
+static struct rsu_qspi_priv *qspi_ctx;
+
+#define P (qspi_ctx)
+
+static int load_cpb(void);
+static int check_spt(void);
+
+/**
+ * get_part_offset() - get a selected partition offset
+ * @part_num: the selected partition number
+ * @offset: the partition offset
+ *
+ * Return: 0 on success, or -ve on error
+ */
+static int get_part_offset(int part_num, u64 *offset)
+{
+	if (part_num < 0 || part_num >= P->spt.partitions)
+		return -EINVAL;
+
+	*offset = P->spt.partition[part_num].offset;
+
+	return 0;
+}
+
+/*
+ * @brief Calculates the current flash offset based on the given offset.
+ *
+ * This function calculates the current flash offset and the current flash index
+ * based on the given offset. It iterates through the flashlist array and checks
+ * if the current offset is greater than the size of each flash. If it is, it
+ * subtracts the size of the flash from the current offset and continues to the
+ * next flash. If the current offset is not greater than the size of the flash,
+ * it sets the current flash index and breaks out of the loop.
+ *
+ * @param offset The offset to calculate the current flash offset from.
+ * @param current_offset Pointer to store the calculated current offset.
+ * @param current_flash Pointer to store the index of the current flash.
+ */
+
+static int get_current_flash_offset(u64 offset, u32 *current_offset,
+				    int *current_flash)
+{
+	u64 relative_offset = offset;
+
+	if (!current_offset || !current_flash)
+		return -EINVAL;
+
+	for (int j = 0; j < P->num_flash && j < QSPI_MAX_DEVICE; j++) {
+		u32 sz = rsu_mtd_size(P->flashlist[j]);
+
+		if (!sz)
+			return -EINVAL;
+		if (relative_offset >= sz) {
+			relative_offset -= sz;
+			continue;
+		} else {
+			/* relative_offset < sz here; u32 keeps the assignment loss-free. */
+			*current_flash = j;
+			*current_offset = (u32)relative_offset;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * read_dev() - read data from flash
+ * @offset: the offset which read from flash
+ * @buf: buffer for read data
+ * @len: the size of data which read from flash
+ *
+ * Return: 0 on success, or -ve for error
+ */
+static int read_dev(u64 offset, void *buf, int len)
+{
+	int ret, current_flash;
+	u32 count, current_len, current_offset;
+
+	if (len < 0)
+		return -EINVAL;
+	/*
+	 * Preserve the long-standing no-op convention: callers (notably
+	 * read_part) may pass len == 0 at offset == flash/partition end,
+	 * which the per-flash boundary check would otherwise reject.
+	 */
+	if (len == 0)
+		return 0;
+
+	count = 0;
+
+	ret = get_current_flash_offset(offset, &current_offset, &current_flash);
+	if (ret)
+		return ret;
+
+	for (int i = current_flash; i < P->num_flash && i < QSPI_MAX_DEVICE;
+	     i++) {
+		u32 sz = rsu_mtd_size(P->flashlist[i]);
+
+		/* break if total data length is done */
+		if (count == (u32)len)
+			break;
+
+		/*
+		 * Re-validate per iteration: only the first flash was checked
+		 * by get_current_flash_offset(), and a later device may report
+		 * sz == 0.
+		 */
+		if (!sz || current_offset > sz) {
+			rsu_log(RSU_ERR,
+				"%s: flash %d invalid size %u or offset %u\n",
+				__func__, i, sz, current_offset);
+			return -EINVAL;
+		}
+
+		/* Compute in u64 so (len + current_offset) cannot wrap past 4 GiB. */
+		if ((u64)(u32)len + current_offset - count > sz)
+			current_len = sz - current_offset;
+		else
+			current_len = (u32)len - count;
+
+		ret = rsu_mtd_read(P->flashlist[i], current_offset,
+				   (int)current_len, buf);
+		if (ret) {
+			rsu_log(RSU_ERR, "read flash error=%i\n", ret);
+			return ret;
+		}
+
+		buf = (char *)buf + current_len;
+
+		/* reset the offset to new flash */
+		current_offset = 0;
+		count += current_len;
+	}
+
+	return 0;
+}
+
+/**
+ * write_dev() - write data to flash
+ * @offset: the offset which data will written to
+ * @buf: the written data
+ * @len: the size of data which write to flash
+ *
+ * Return: 0 on success, or -ve for error
+ */
+static int write_dev(u64 offset, void *buf, int len)
+{
+	int ret, current_flash;
+	u32 count, current_len, current_offset;
+
+	if (len < 0)
+		return -EINVAL;
+	/* See read_dev() for why len == 0 is treated as a no-op. */
+	if (len == 0)
+		return 0;
+
+	count = 0;
+
+	ret = get_current_flash_offset(offset, &current_offset, &current_flash);
+	if (ret)
+		return ret;
+
+	for (int i = current_flash; i < P->num_flash && i < QSPI_MAX_DEVICE;
+	     i++) {
+		u32 sz = rsu_mtd_size(P->flashlist[i]);
+
+		/* break if total data length is done */
+		if (count == (u32)len)
+			break;
+
+		/* See read_dev() for why these guards are required. */
+		if (!sz || current_offset > sz) {
+			rsu_log(RSU_ERR,
+				"%s: flash %d invalid size %u or offset %u\n",
+				__func__, i, sz, current_offset);
+			return -EINVAL;
+		}
+
+		if ((u64)(u32)len + current_offset - count > sz)
+			current_len = sz - current_offset;
+		else
+			current_len = (u32)len - count;
+
+		ret = rsu_mtd_write(P->flashlist[i], current_offset,
+				    (int)current_len, buf);
+		if (ret) {
+			rsu_log(RSU_ERR, "write flash error=%i\n", ret);
+			return ret;
+		}
+
+		buf = (char *)buf + current_len;
+
+		/* reset the offset to new flash */
+		current_offset = 0;
+		count += current_len;
+	}
+
+	return 0;
+}
+
+/**
+ * erase_dev() - erase data at flash
+ * @offset: the offset from which data will be erased
+ * @len: the size of data to be erased
+ *
+ * Return: 0 on success, or -ve for error
+ */
+static int erase_dev(u64 offset, int len)
+{
+	int ret, current_flash;
+	u32 count, current_len, current_offset;
+
+	if (len < 0)
+		return -EINVAL;
+	/* See read_dev() for why len == 0 is treated as a no-op. */
+	if (len == 0)
+		return 0;
+
+	count = 0;
+
+	ret = get_current_flash_offset(offset, &current_offset, &current_flash);
+	if (ret)
+		return ret;
+
+	for (int i = current_flash; i < P->num_flash && i < QSPI_MAX_DEVICE;
+	     i++) {
+		u32 sz = rsu_mtd_size(P->flashlist[i]);
+
+		if (count >= (u32)len)
+			break;
+
+		/* See read_dev() for why these guards are required. */
+		if (!sz || current_offset > sz) {
+			rsu_log(RSU_ERR,
+				"%s: flash %d invalid size %u or offset %u\n",
+				__func__, i, sz, current_offset);
+			return -EINVAL;
+		}
+
+		if ((u64)(u32)len + current_offset - count > sz)
+			current_len = sz - current_offset;
+		else
+			current_len = (u32)len - count;
+
+		ret = rsu_mtd_erase(P->flashlist[i], current_offset,
+				    (int)current_len);
+		if (ret) {
+			rsu_log(RSU_ERR, "erase flash error=%i\n", ret);
+			return ret;
+		}
+
+		current_offset = 0;
+		count += current_len;
+	}
+
+	return 0;
+}
+
+/**
+ * read_part() - read a selected partition data
+ * @part_num: the selected partition number
+ * @offset: the offset from which data will be read
+ * @buf: buffer contains the read data
+ * @len: the size of data to be read
+ *
+ * Return: 0 on success, or -ve for error
+ */
+static int read_part(int part_num, u64 offset, void *buf, int len)
+{
+	u64 part_offset;
+	int ret;
+
+	ret = get_part_offset(part_num, &part_offset);
+	if (ret)
+		return ret;
+
+	if (len < 0)
+		return -EINVAL;
+
+	if (offset > P->spt.partition[part_num].length ||
+	    (u64)len > P->spt.partition[part_num].length - offset)
+		return -EINVAL;
+
+	return read_dev(part_offset + offset, buf, len);
+}
+
+/**
+ * write_part() - write a selected partition data
+ * @part_num: the selected partition number
+ * @offset: the offset to which data will be written
+ * @buf: data to be written to
+ * @len: the size of data to be written
+ *
+ * Return: 0 on success, or -ve for error
+ */
+static int write_part(int part_num, u64 offset, void *buf, int len)
+{
+	u64 part_offset;
+	int ret;
+
+	ret = get_part_offset(part_num, &part_offset);
+	if (ret)
+		return ret;
+
+	if (len < 0)
+		return -EINVAL;
+
+	if (offset > P->spt.partition[part_num].length ||
+	    (u64)len > P->spt.partition[part_num].length - offset)
+		return -EINVAL;
+
+	return write_dev(part_offset + offset, buf, len);
+}
+
+/**
+ * erase_part() - erase a selected partition data
+ * @part_num: the selected partition number
+ *
+ * Return: 0 on success, or -ve for error
+ */
+static int erase_part(int part_num)
+{
+	u64 part_offset;
+	int ret;
+
+	ret = get_part_offset(part_num, &part_offset);
+	if (ret)
+		return ret;
+
+	return erase_dev(part_offset, P->spt.partition[part_num].length);
+}
+
+/**
+ * save_spt_to_address() - save spt to the address
+ * @address: the address which spt is saved to
+ *
+ * Return: 0 for successful operation, or -ve on error
+ */
+static int save_spt_to_address(u64 address)
+{
+	int ret;
+	char *spt_data_dst = (char *)address;
+	char *spt_data_src;
+	u32 calc_crc;
+
+	if (!spt_data_dst) {
+		rsu_log(RSU_ERR, "failed due to invalid address\n");
+		return -EINVAL;
+	}
+
+	spt_data_src = (char *)malloc(SPT_SIZE);
+	if (!spt_data_src) {
+		rsu_log(RSU_ERR, "failed to allocate spt_data_src\n");
+		return -ENOMEM;
+	}
+
+	ret = read_dev(P->spt0_offset, spt_data_src, SPT_SIZE);
+	if (ret) {
+		rsu_log(RSU_ERR, "failed to read SPT data\n");
+		free(spt_data_src);
+		return ret;
+	}
+
+	calc_crc = crc32(0, (void *)spt_data_src, SPT_SIZE);
+	rsu_log(RSU_DEBUG, "%s - calc_crc is 0x%x\n", __func__, calc_crc);
+	memcpy(spt_data_dst, spt_data_src, SPT_SIZE);
+	memcpy(spt_data_dst + SPT_SIZE, &calc_crc, sizeof(calc_crc));
+	rsu_log(RSU_INFO, "%ld bytes SPT data saved\n",
+		SPT_SIZE + sizeof(calc_crc));
+	env_set_hex("filesize", SPT_SIZE + sizeof(calc_crc));
+
+	free(spt_data_src);
+	return ret;
+}
+
+/**
+ * corrupted_spt() - check if spt is corrupted
+ *
+ * Return: 1 for the corrupted spt , or 0 for not
+ */
+static int corrupted_spt(void)
+{
+	return P->spt_corrupted;
+}
+
+/**
+ * writeback_spt() - write back SPT
+ *
+ * Return: 0 on success, or -ve on error
+ */
+static int writeback_spt(void)
+{
+	int x;
+	int updates = 0;
+	char *spt_data;
+	u32 calc_crc;
+
+	for (x = 0; x < P->spt.partitions; x++) {
+		if (strcmp(P->spt.partition[x].name, "SPT0") &&
+		    strcmp(P->spt.partition[x].name, "SPT1"))
+			continue;
+
+		if (erase_part(x)) {
+			rsu_log(RSU_ERR, "failed to erase SPTx");
+			return -EIO;
+		}
+
+		if (P->spt.version > SPT_VERSION &&
+		    rsu_misc_spt_checksum_enabled()) {
+			rsu_log(RSU_DEBUG, "update SPT checksum...\n");
+			spt_data = (char *)malloc(SPT_SIZE);
+			if (!spt_data) {
+				rsu_log(RSU_ERR,
+					"failed to allocate spt_data\n");
+				return -ENOMEM;
+			}
+
+			P->spt.checksum = (u32)0xFFFFFFFF;
+			if (write_part(x, SPT_CHECKSUM_OFFSET,
+				       &P->spt.checksum,
+				       sizeof(P->spt.checksum))) {
+				rsu_log(RSU_ERR,
+					"failed to write SPTx table");
+				free(spt_data);
+				return -EINVAL;
+			}
+
+			memcpy(spt_data, &P->spt, SPT_SIZE);
+			memset(spt_data + SPT_CHECKSUM_OFFSET, 0,
+			       sizeof(P->spt.checksum));
+
+			swap_bits(spt_data, SPT_SIZE);
+			calc_crc = crc32(0, (void *)spt_data, SPT_SIZE);
+			P->spt.checksum = be32_to_cpu(calc_crc);
+			swap_bits(spt_data, SPT_SIZE);
+			free(spt_data);
+
+			if (write_part(x, SPT_CHECKSUM_OFFSET,
+				       &P->spt.checksum,
+				       sizeof(P->spt.checksum))) {
+				rsu_log(RSU_ERR,
+					"failed to write SPTx table");
+				return -EINVAL;
+			}
+		}
+
+		P->spt.magic_number = (u32)0xFFFFFFFF;
+		if (write_part(x, 0, &P->spt, sizeof(P->spt))) {
+			rsu_log(RSU_ERR, "failed to write SPTx table");
+			return -EIO;
+		}
+
+		P->spt.magic_number = (u32)SPT_MAGIC_NUMBER;
+		if (write_part(x, 0, &P->spt.magic_number,
+			       sizeof(P->spt.magic_number))) {
+			rsu_log(RSU_ERR, "failed to write SPTx magic #");
+			return -EIO;
+		}
+
+		updates++;
+	}
+
+	if (updates != 2) {
+		rsu_log(RSU_ERR, "didn't find two SPTs");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+/**
+ * restore_spt_from_address() - restore the spt from an address
+ * @address: the address which spt is restored from
+ *
+ * Return: 0 for successful operation, or -ve on error
+ */
+static int restore_spt_from_address(u64 address)
+{
+	int ret;
+	u32 calc_crc;
+	u32 crc_from_saved;
+	u32 magic_number;
+	char *spt_data = (char *)address;
+
+	if (!spt_data) {
+		rsu_log(RSU_ERR, "failed due to invalid address\n");
+		return -EINVAL;
+	}
+
+	calc_crc = crc32(0, (void *)spt_data, SPT_SIZE);
+	rsu_log(RSU_DEBUG, "%s - calc_crc is 0x%x\n", __func__, calc_crc);
+	memcpy(&crc_from_saved, spt_data + SPT_SIZE, sizeof(crc_from_saved));
+	rsu_log(RSU_DEBUG, "%s - crc_from_saved is 0x%x\n", __func__,
+		crc_from_saved);
+
+	if (calc_crc != crc_from_saved) {
+		rsu_log(RSU_ERR, "saved data is corrupted\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * check the magic number to prevent user from accidentally
+	 * restoring CPB
+	 */
+	memcpy(&magic_number, spt_data, sizeof(magic_number));
+	if (magic_number != SPT_MAGIC_NUMBER) {
+		rsu_log(RSU_ERR, "failure due to mismatch magic number\n");
+		return -EINVAL;
+	}
+
+	memcpy(&P->spt, spt_data, SPT_SIZE);
+
+	/*
+	 * CRC+magic only prove self-consistency of the supplied image; a
+	 * crafted SPT could still carry an out-of-range partition count or
+	 * overlapping regions. Re-run the full validator before committing.
+	 */
+	ret = check_spt();
+	if (ret) {
+		rsu_log(RSU_ERR, "restored SPT failed validation\n");
+		P->spt_corrupted = true;
+		return ret;
+	}
+
+	ret = writeback_spt();
+	if (ret) {
+		rsu_log(RSU_ERR, "failed to write back spt\n");
+		return ret;
+	}
+
+	P->spt_corrupted = false;
+
+	/* try to reload CPB, as we have a new SPT */
+	P->cpb_corrupted = false;
+	if (load_cpb() && !P->cpb_corrupted)
+		rsu_log(RSU_ERR, "Bad CPB\n");
+
+	return 0;
+}
+
+/**
+ * check_spt() - check if SPT is valid
+ *
+ * Return: 0 for valid SPT, or -ve on error
+ */
+static int check_spt(void)
+{
+	int x;
+	int y;
+	int max_len = sizeof(P->spt.partition[0].name);
+	int spt0_found = 0;
+	int spt1_found = 0;
+	int cpb0_found = 0;
+	int cpb1_found = 0;
+
+	u32 calc_crc;
+	char *spt_data;
+
+	/*
+	 * Make sure the SPT names are '\0' terminated. Truncate last byte
+	 * if the name uses all available bytes.  Perform validity check on
+	 * entries.
+	 */
+
+	rsu_log(RSU_DEBUG,
+		"MAX length of a name = %i bytes\n", max_len - 1);
+
+	if (P->spt.version > SPT_VERSION &&
+	    rsu_misc_spt_checksum_enabled()) {
+		rsu_log(RSU_DEBUG, "check SPT checksum...\n");
+
+		spt_data = (char *)malloc(SPT_SIZE);
+		if (!spt_data) {
+			rsu_log(RSU_ERR, "failed to allocate spt_data\n");
+			return -ENOMEM;
+		}
+
+		memcpy(spt_data, &P->spt, SPT_SIZE);
+		memset(spt_data + SPT_CHECKSUM_OFFSET, 0,
+		       sizeof(P->spt.checksum));
+
+		swap_bits(spt_data, SPT_SIZE);
+		calc_crc = crc32(0, (void *)spt_data, SPT_SIZE);
+		if (be32_to_cpu(P->spt.checksum) != calc_crc) {
+			rsu_log(RSU_ERR, "Error, bad SPT checksum\n");
+			free(spt_data);
+			return -EINVAL;
+		}
+		swap_bits(spt_data, SPT_SIZE);
+		free(spt_data);
+	}
+
+	if (P->spt.partitions > SPT_MAX_PARTITIONS) {
+		rsu_log(RSU_ERR, "bigger than max partition\n");
+		return -EINVAL;
+	}
+
+	for (x = 0; x < P->spt.partitions; x++) {
+		u64 s_start;
+		u64 s_len;
+		u64 s_end;
+
+		if (strnlen(P->spt.partition[x].name, max_len) >= max_len)
+			P->spt.partition[x].name[max_len - 1] = '\0';
+
+		s_start = P->spt.partition[x].offset;
+		s_len = P->spt.partition[x].length;
+
+		/* Zero length would underflow the inclusive end below. */
+		if (s_len == 0) {
+			rsu_log(RSU_ERR,
+				"SPT entry %d (%s): zero-length partition\n",
+				x, P->spt.partition[x].name);
+			return -EINVAL;
+		}
+
+		/* Reject offset+length wraparound; otherwise overlap test passes spuriously. */
+		if (s_len > U64_MAX - s_start) {
+			rsu_log(RSU_ERR,
+				"SPT entry %d: offset+length overflows u64\n",
+				x);
+			return -EINVAL;
+		}
+		s_end = s_start + s_len;
+
+		rsu_log(RSU_DEBUG, "RSU %-16s %016llX - %016llX (%X)\n",
+			P->spt.partition[x].name, s_start, s_end - 1,
+			P->spt.partition[x].flags);
+
+		for (y = 0; y < P->spt.partitions; y++) {
+			if (x == y)
+				continue;
+
+			/*
+			 * don't allow the same partition name to appear
+			 * more than once
+			 */
+			if (!(strcmp(P->spt.partition[x].name,
+				     P->spt.partition[y].name))) {
+				rsu_log(RSU_ERR, "partition name ");
+				rsu_log(RSU_ERR, "appears more than once\n");
+				return -EINVAL;
+			}
+
+			u64 d_start = P->spt.partition[y].offset;
+			u64 d_len = P->spt.partition[y].length;
+			u64 d_end;
+
+			if (d_len > U64_MAX - d_start) {
+				rsu_log(RSU_ERR,
+					"SPT entry %d: offset+length overflows u64\n",
+					y);
+				return -EINVAL;
+			}
+			d_end = d_start + d_len;
+
+			if (s_start < d_end && s_end > d_start) {
+				rsu_log(RSU_ERR, "partition overlap\n");
+				return -EINVAL;
+			}
+		}
+
+		if (strcmp(P->spt.partition[x].name, "SPT0") == 0)
+			spt0_found = 1;
+		else if (strcmp(P->spt.partition[x].name, "SPT1") == 0)
+			spt1_found = 1;
+		else if (strcmp(P->spt.partition[x].name, "CPB0") == 0)
+			cpb0_found = 1;
+		else if (strcmp(P->spt.partition[x].name, "CPB1") == 0)
+			cpb1_found = 1;
+	}
+
+	if (!spt0_found || !spt1_found || !cpb0_found || !cpb1_found) {
+		rsu_log(RSU_ERR, "Missing a critical entry in the SPT\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+/**
+ * check_both_spt() - check if both SPTs are same
+ *
+ * Return: 0 for the identical SPTs, or -ve on error
+ */
+static int check_both_spt(void)
+{
+	int ret;
+	char *spt0_data;
+	char *spt1_data;
+
+	spt0_data = (char *)malloc(SPT_SIZE);
+	if (!spt0_data) {
+		rsu_log(RSU_ERR, "failed to allocate spt0_data\n");
+		return -ENOMEM;
+	}
+
+	spt1_data = (char *)malloc(SPT_SIZE);
+	if (!spt1_data) {
+		rsu_log(RSU_ERR, "failed to allocate spt1_data\n");
+		free(spt0_data);
+		return -ENOMEM;
+	}
+
+	ret = read_dev(P->spt0_offset, spt0_data, SPT_SIZE);
+	if (ret) {
+		rsu_log(RSU_ERR, "failed to read spt0_data\n");
+		goto ops_error;
+	}
+
+	ret = read_dev(P->spt1_offset, spt1_data, SPT_SIZE);
+	if (ret) {
+		rsu_log(RSU_ERR, "failed to read spt1_data\n");
+		goto ops_error;
+	}
+
+	ret = memcmp(spt0_data, spt1_data, SPT_SIZE);
+
+ops_error:
+	free(spt1_data);
+	free(spt0_data);
+	return ret;
+}
+
+/**
+ * load_spt() - retrieve SPT from flash
+ *
+ * Return: 0 on success, or -ve on error
+ */
+static int load_spt(void)
+{
+	int spt0_good = 0;
+	int spt1_good = 0;
+	int spt_size = P->spt1_offset - P->spt0_offset;
+
+	rsu_log(RSU_DEBUG, "reading SPT1\n");
+	if (read_dev(P->spt1_offset, &P->spt, sizeof(P->spt)) == 0 &&
+	    P->spt.magic_number == SPT_MAGIC_NUMBER) {
+		if (check_spt() == 0)
+			spt1_good = 1;
+		else
+			rsu_log(RSU_ERR, "SPT1 validity check failed\n");
+	} else {
+		rsu_log(RSU_ERR, "Bad SPT1 magic number 0x%08X\n",
+			P->spt.magic_number);
+	}
+
+	rsu_log(RSU_DEBUG, "reading SPT0\n");
+	if (read_dev(P->spt0_offset, &P->spt, sizeof(P->spt)) == 0 &&
+	    P->spt.magic_number == SPT_MAGIC_NUMBER) {
+		if (check_spt() == 0)
+			spt0_good = 1;
+		else
+			rsu_log(RSU_ERR, "SPT0 validity check failed\n");
+	} else {
+		rsu_log(RSU_ERR, "Bad SPT0 magic number 0x%08X\n",
+			P->spt.magic_number);
+	}
+
+	if (spt0_good && spt1_good) {
+		if (check_both_spt()) {
+			rsu_log(RSU_ERR, "unmatched SPT0/1 data");
+			P->spt_corrupted = true;
+			return -EINVAL;
+		}
+		rsu_log(RSU_INFO, "SPTs are GOOD!!!\n");
+		return 0;
+	}
+
+	if (spt0_good) {
+		rsu_log(RSU_WARNING, "warning: Restoring SPT1\n");
+		if (erase_dev(P->spt1_offset, spt_size)) {
+			rsu_log(RSU_ERR, "Erase SPT1 region failed\n");
+			return -EIO;
+		}
+
+		P->spt.magic_number = (u32)0xFFFFFFFF;
+		if (write_dev(P->spt1_offset, &P->spt, sizeof(P->spt))) {
+			rsu_log(RSU_ERR, "Unable to write SPT1 table\n");
+			return -EIO;
+		}
+
+		P->spt.magic_number = (u32)SPT_MAGIC_NUMBER;
+		if (write_dev(P->spt1_offset, &P->spt.magic_number,
+			      sizeof(P->spt.magic_number))) {
+			rsu_log(RSU_ERR, "Unable to wr SPT1 magic #\n");
+			return -EIO;
+		}
+
+		return 0;
+	}
+
+	if (spt1_good) {
+		if (read_dev(P->spt1_offset, &P->spt, sizeof(P->spt)) ||
+		    P->spt.magic_number != SPT_MAGIC_NUMBER || check_spt()) {
+			rsu_log(RSU_ERR, "Failed to load SPT1\n");
+			return -EUCLEAN;
+		}
+
+		rsu_log(RSU_WARNING, "Restoring SPT0");
+
+		if (erase_dev(P->spt0_offset, spt_size)) {
+			rsu_log(RSU_ERR, "Erase SPT0 region failed\n");
+			return -EIO;
+		}
+
+		P->spt.magic_number = (u32)0xFFFFFFFF;
+		if (write_dev(P->spt0_offset, &P->spt, sizeof(P->spt))) {
+			rsu_log(RSU_ERR, "Unable to write SPT0 table\n");
+			return -EIO;
+		}
+
+		P->spt.magic_number = (u32)SPT_MAGIC_NUMBER;
+		if (write_dev(P->spt0_offset, &P->spt.magic_number,
+			      sizeof(P->spt.magic_number))) {
+			rsu_log(RSU_ERR, "Unable to wr SPT0 magic #\n");
+			return -EIO;
+		}
+
+		return 0;
+	}
+
+	P->spt_corrupted = true;
+	rsu_log(RSU_ERR, "no valid SPT0 and SPT1 found\n");
+	return -EUCLEAN;
+}
+
+/**
+ * cpb_header_access_ok() - validate CPB header fields used to index
+ * cpb_slots[].
+ *
+ * Return: 0 if the header is safe to use, -EINVAL otherwise.
+ */
+static int cpb_header_access_ok(void)
+{
+	u32 ip_off = P->cpb.header.image_ptr_offset;
+	u32 ip_slots = P->cpb.header.image_ptr_slots;
+	u32 max_by_buf;
+
+	if (P->cpb.header.header_size > CPB_HEADER_SIZE) {
+		rsu_log(RSU_WARNING,
+			"CPB header is larger than expected\n");
+		return -EINVAL;
+	}
+	if (ip_off >= CPB_SIZE) {
+		rsu_log(RSU_ERR, "CPB image_ptr_offset out of range\n");
+		return -EINVAL;
+	}
+	/* cpb_slots[] is dereferenced as u64; reject misaligned image_ptr_offset. */
+	if (ip_off % sizeof(u64)) {
+		rsu_log(RSU_ERR, "CPB image_ptr_offset not 8-byte aligned\n");
+		return -EINVAL;
+	}
+	max_by_buf = (CPB_SIZE - ip_off) / sizeof(u64);
+	/* Reject ip_slots == 0 too: zero-iteration loops would silently succeed. */
+	if (!ip_slots || !max_by_buf || ip_slots > max_by_buf ||
+	    ip_slots > CPB_IMAGE_PTR_NSLOTS) {
+		rsu_log(RSU_ERR, "CPB image_ptr_slots out of range\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * check_cpb() - check if CPB is valid
+ *
+ * Return: 0 for the valid CPB, or -ve on error
+ */
+static int check_cpb(void)
+{
+	int x, y;
+	int ret;
+
+	ret = cpb_header_access_ok();
+	if (ret)
+		return ret;
+
+	for (x = 0; x < P->cpb.header.image_ptr_slots; x++) {
+		if (P->cpb_slots[x] == ERASED_ENTRY ||
+		    P->cpb_slots[x] == SPENT_ENTRY)
+			continue;
+
+		for (y = 0; y < P->spt.partitions; y++) {
+			if (P->cpb_slots[x] == P->spt.partition[y].offset) {
+				rsu_log(RSU_DEBUG, "cpb_slots[%i] = %s\n",
+					x, P->spt.partition[y].name);
+				break;
+			}
+		}
+
+		if (y >= P->spt.partitions) {
+			rsu_log(RSU_ERR, "CPB is not included in SPT\n");
+			rsu_log(RSU_DEBUG, "cpb_slots[%i] = %016llX ???",
+				x, P->cpb_slots[x]);
+			return -EINVAL;
+		}
+
+		if (P->spt.partition[y].flags & SPT_FLAG_RESERVED) {
+			rsu_log(RSU_ERR, "CPB is included in SPT ");
+			rsu_log(RSU_ERR, "but it is reserved\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * check_both_cpb() - check if both CPBs are same
+ *
+ * Return: 0 for the identical CPBs, or -ve on error
+ */
+static int check_both_cpb(void)
+{
+	int ret;
+	char *cpb0_data;
+	char *cpb1_data;
+
+	cpb0_data = (char *)malloc(CPB_SIZE);
+	if (!cpb0_data) {
+		rsu_log(RSU_ERR, "failed to allocate cpb0_data\n");
+		return -ENOMEM;
+	}
+
+	cpb1_data = (char *)malloc(CPB_SIZE);
+	if (!cpb1_data) {
+		rsu_log(RSU_ERR, "failed to allocate cpb1_data\n");
+		free(cpb0_data);
+		return -ENOMEM;
+	}
+
+	ret = read_part(P->cpb0_part, 0, cpb0_data, CPB_SIZE);
+	if (ret) {
+		rsu_log(RSU_ERR, "failed to read cpb0_data\n");
+		goto ops_error;
+	}
+
+	ret = read_part(P->cpb1_part, 0, cpb1_data, CPB_SIZE);
+	if (ret) {
+		rsu_log(RSU_ERR, "failed to read cpb1_data\n");
+		goto ops_error;
+	}
+
+	ret = memcmp(cpb0_data, cpb1_data, CPB_SIZE);
+
+ops_error:
+	free(cpb1_data);
+	free(cpb0_data);
+	return ret;
+}
+
+/**
+ * save_cpb_to_address() - save cpb to the address
+ * @address: the address which cpb is saved to
+ *
+ * Return: 0 for successful operation, or -ve on error
+ */
+static int save_cpb_to_address(u64 address)
+{
+	int ret;
+	char *cpb_data_dst = (char *)address;
+	char *cpb_data_src;
+	u32 calc_crc;
+
+	if (!cpb_data_dst) {
+		rsu_log(RSU_ERR, "failed due to invalid address");
+		return -EINVAL;
+	}
+
+	cpb_data_src = (char *)malloc(CPB_SIZE);
+	if (!cpb_data_src) {
+		rsu_log(RSU_ERR, "failed to allocate cpb_data_src\n");
+		return -ENOMEM;
+	}
+
+	ret = read_part(P->cpb0_part, 0, cpb_data_src, CPB_SIZE);
+	if (ret) {
+		rsu_log(RSU_ERR, "failed to read CPB data\n");
+		free(cpb_data_src);
+		return ret;
+	}
+
+	calc_crc = crc32(0, (void *)cpb_data_src, CPB_SIZE);
+	rsu_log(RSU_DEBUG, "%s - calc_crc is 0x%x\n", __func__, calc_crc);
+	memcpy(cpb_data_dst, cpb_data_src, CPB_SIZE);
+	memcpy(cpb_data_dst + CPB_SIZE, &calc_crc, sizeof(calc_crc));
+	rsu_log(RSU_INFO, "%ld bytes CPB data saved\n",
+		CPB_SIZE + sizeof(calc_crc));
+	env_set_hex("filesize", CPB_SIZE + sizeof(calc_crc));
+
+	free(cpb_data_src);
+	return ret;
+}
+
+/**
+ * corrupted_cpb() - check if cpb is corrupted
+ *
+ * Return: 1 for the corrupted cpb , or 0 for not
+ */
+static int corrupted_cpb(void)
+{
+	return P->cpb_corrupted;
+}
+
+/**
+ * load_cpb() - retrieve CPB from flash
+ *
+ * Return: 0 on success, or -ve on error
+ */
+static int load_cpb(void)
+{
+	int x;
+	int cpb0_good = 0;
+	int cpb1_good = 0;
+	struct rsu_status_info status_info;
+	int cpb0_corrupted = 0;
+
+	if (mbox_rsu_status((u32 *)&status_info,
+			    sizeof(status_info) / 4)) {
+		rsu_log(RSU_ERR, "FW doesn't support RSU\n");
+		return -EINVAL;
+	}
+
+	if (!P->cpb_fixed && status_info.state == STATE_CPB0_CPB1_CORRUPTED) {
+		rsu_log(RSU_ERR, "FW detects both CPBs corrupted\n");
+		P->cpb_corrupted = true;
+		return -EINVAL;
+	}
+
+	if (!P->cpb_fixed && status_info.state == STATE_CPB0_CORRUPTED) {
+		rsu_log(RSU_ERR,
+			"FW detects corrupted CPB0 but CPB1 is fine\n");
+		cpb0_corrupted = 1;
+	}
+
+	for (x = 0; x < P->spt.partitions; x++) {
+		if (strcmp(P->spt.partition[x].name, "CPB0") == 0)
+			P->cpb0_part = x;
+		else if (strcmp(P->spt.partition[x].name, "CPB1") == 0)
+			P->cpb1_part = x;
+
+		if (P->cpb0_part >= 0 && P->cpb1_part >= 0)
+			break;
+	}
+
+	if (P->cpb0_part < 0 || P->cpb1_part < 0) {
+		rsu_log(RSU_ERR, "Missing CPB0/1 partition\n");
+		return -ENOENT;
+	}
+
+	rsu_log(RSU_DEBUG, "Reading CPB1\n");
+	if (read_part(P->cpb1_part, 0, &P->cpb, sizeof(P->cpb)) == 0 &&
+	    P->cpb.header.magic_number == CPB_MAGIC_NUMBER &&
+	    cpb_header_access_ok() == 0) {
+		P->cpb_slots = (u64 *)
+			     &P->cpb.data[P->cpb.header.image_ptr_offset];
+		if (check_cpb() == 0)
+			cpb1_good = 1;
+	} else {
+		rsu_log(RSU_ERR, "Bad CPB1 is bad\n");
+	}
+
+	if (!cpb0_corrupted) {
+		rsu_log(RSU_DEBUG, "Reading CPB0\n");
+		if (read_part(P->cpb0_part, 0, &P->cpb, sizeof(P->cpb)) == 0 &&
+		    P->cpb.header.magic_number == CPB_MAGIC_NUMBER &&
+		    cpb_header_access_ok() == 0) {
+			P->cpb_slots = (u64 *)
+				     &P->cpb.data[P->cpb.header.image_ptr_offset];
+			if (check_cpb() == 0)
+				cpb0_good = 1;
+		} else {
+			rsu_log(RSU_ERR, "Bad CPB0 is bad\n");
+		}
+	}
+
+	if (cpb0_good && cpb1_good) {
+		if (check_both_cpb()) {
+			rsu_log(RSU_ERR, "unmatched CPB0/1 data");
+			P->cpb_corrupted = true;
+			return -EINVAL;
+		}
+		rsu_log(RSU_INFO, "CPBs are GOOD!!!\n");
+		P->cpb_slots = (u64 *)
+			     &P->cpb.data[P->cpb.header.image_ptr_offset];
+		return 0;
+	}
+
+	if (cpb0_good) {
+		rsu_log(RSU_WARNING, "Restoring CPB1\n");
+		if (erase_part(P->cpb1_part)) {
+			rsu_log(RSU_ERR, "Failed erase CPB1\n");
+			return -EIO;
+		}
+
+		P->cpb.header.magic_number = (u32)0xFFFFFFFF;
+		if (write_part(P->cpb1_part, 0, &P->cpb, sizeof(P->cpb))) {
+			rsu_log(RSU_ERR, "Unable to write CPB1 table\n");
+			return -EIO;
+		}
+
+		P->cpb.header.magic_number = (u32)CPB_MAGIC_NUMBER;
+		if (write_part(P->cpb1_part, 0, &P->cpb.header.magic_number,
+			       sizeof(P->cpb.header.magic_number))) {
+			rsu_log(RSU_ERR, "Unable to write CPB1 magic number\n");
+			return -EIO;
+		}
+
+		P->cpb_slots = (u64 *)&P->cpb.data[P->cpb.header.image_ptr_offset];
+		return 0;
+	}
+
+	if (cpb1_good) {
+		if (read_part(P->cpb1_part, 0, &P->cpb, sizeof(P->cpb)) ||
+		    P->cpb.header.magic_number != CPB_MAGIC_NUMBER) {
+			rsu_log(RSU_ERR, "Unable to load CPB1\n");
+			return -EUCLEAN;
+		}
+
+		rsu_log(RSU_WARNING, "Restoring CPB0\n");
+		if (erase_part(P->cpb0_part)) {
+			rsu_log(RSU_ERR, "Failed erase CPB0\n");
+			return -EIO;
+		}
+
+		P->cpb.header.magic_number = (u32)0xFFFFFFFF;
+		if (write_part(P->cpb0_part, 0, &P->cpb, sizeof(P->cpb))) {
+			rsu_log(RSU_ERR, "Unable to write CPB0 table\n");
+			return -EIO;
+		}
+
+		P->cpb.header.magic_number = (u32)CPB_MAGIC_NUMBER;
+		if (write_part(P->cpb0_part, 0, &P->cpb.header.magic_number,
+			       sizeof(P->cpb.header.magic_number))) {
+			rsu_log(RSU_ERR, "Unable to write CPB0 magic number\n");
+			return -EIO;
+		}
+
+		P->cpb_slots = (u64 *)&P->cpb.data[P->cpb.header.image_ptr_offset];
+		return 0;
+	}
+
+	P->cpb_corrupted = true;
+	rsu_log(RSU_ERR, "No valid CPB0 or CPB1 found\n");
+	return -EUCLEAN;
+}
+
+/**
+ * update_cpb() - update a CPB slot in flash (best-effort).
+ * @slot: index into P->cpb_slots
+ * @ptr:  new pointer value (NAND-style 1->0 transitions only)
+ *
+ * Writes CPB0 then CPB1; on a mid-write failure (one updated, the other
+ * stale) returns -ve with no rollback. Callers MUST then call load_cpb(),
+ * which reconciles the two flash copies; do not roll back P->cpb locally.
+ *
+ * Return: 0 on success, or -ve on error (caller MUST load_cpb()).
+ */
+static int update_cpb(int slot, u64 ptr)
+{
+	int x;
+	int updates = 0;
+
+	if (slot < 0 || slot >= P->cpb.header.image_ptr_slots)
+		return -EINVAL;
+
+	if ((P->cpb_slots[slot] & ptr) != ptr)
+		return -EINVAL;
+
+	P->cpb_slots[slot] = ptr;
+
+	for (x = 0; x < P->spt.partitions; x++) {
+		if (strcmp(P->spt.partition[x].name, "CPB0") &&
+		    strcmp(P->spt.partition[x].name, "CPB1"))
+			continue;
+
+		if (write_part(x, 0, &P->cpb, sizeof(P->cpb)))
+			return -EIO;
+
+		updates++;
+	}
+
+	if (updates != 2) {
+		rsu_log(RSU_ERR, "Did not find two CPBs\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+/**
+ * writeback_cpb() - write CPB back to flash
+ *
+ * Return: 0 on success, or -ve on error
+ */
+static int writeback_cpb(void)
+{
+	int x;
+	int updates = 0;
+
+	for (x = 0; x < P->spt.partitions; x++) {
+		if (strcmp(P->spt.partition[x].name, "CPB0") &&
+		    strcmp(P->spt.partition[x].name, "CPB1"))
+			continue;
+
+		if (erase_part(x)) {
+			rsu_log(RSU_ERR, "Unable to ease CPBx\n");
+			return -EIO;
+		}
+
+		P->cpb.header.magic_number = (u32)0xFFFFFFFF;
+		if (write_part(x, 0, &P->cpb, sizeof(P->cpb))) {
+			rsu_log(RSU_ERR, "Unable to write CPBx table\n");
+			return -EIO;
+		}
+
+		P->cpb.header.magic_number = (u32)CPB_MAGIC_NUMBER;
+		if (write_part(x, 0, &P->cpb.header.magic_number,
+			       sizeof(P->cpb.header.magic_number))) {
+			rsu_log(RSU_ERR,
+				"Unable to write CPBx magic number\n");
+			return -EIO;
+		}
+
+		updates++;
+	}
+
+	if (updates != 2) {
+		rsu_log(RSU_ERR, "Did not find two CPBs\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+/**
+ * empty_cpb() - create a cpb with header field only
+ *
+ * Return: 0 for successful operation, or -ve on error
+ */
+static int empty_cpb(void)
+{
+	int ret;
+	struct cpb_header {
+		u32 magic_number;
+		u32 header_size;
+		u32 cpb_size;
+		u32 cpb_reserved;
+		u32 image_ptr_offset;
+		u32 image_ptr_slots;
+	} *c_header;
+
+	if (P->spt_corrupted) {
+		rsu_log(RSU_ERR, "corrupted SPT ---");
+		rsu_log(RSU_ERR, "run rsu restore_spt <address> first\n");
+		return -EINVAL;
+	}
+
+	c_header = (struct cpb_header *)malloc(sizeof(struct cpb_header));
+	if (!c_header) {
+		rsu_log(RSU_ERR, "failed to allocate cpb_header\n");
+		return -ENOMEM;
+	}
+
+	c_header->magic_number = CPB_MAGIC_NUMBER;
+	c_header->header_size = CPB_HEADER_SIZE;
+	c_header->cpb_size = CPB_SIZE;
+	c_header->cpb_reserved = 0;
+	c_header->image_ptr_offset = CPB_IMAGE_PTR_OFFSET;
+	c_header->image_ptr_slots = CPB_IMAGE_PTR_NSLOTS;
+
+	memset(&P->cpb, -1, CPB_SIZE);
+	memcpy(&P->cpb, c_header, sizeof(*c_header));
+
+	ret = writeback_cpb();
+	if (ret) {
+		rsu_log(RSU_ERR, "failed to write back cpb\n");
+		goto ops_error;
+	}
+
+	P->cpb_slots = (u64 *)&P->cpb.data[P->cpb.header.image_ptr_offset];
+	P->cpb_corrupted = false;
+	P->cpb_fixed = true;
+
+ops_error:
+	free(c_header);
+	return ret;
+}
+
+/**
+ * restore_cpb_from_address() - restore the cpb from an address
+ * @address: the address which cpb is restored from
+ *
+ * Return: 0 for successful operation, or -ve on error
+ */
+static int restore_cpb_from_address(u64 address)
+{
+	int ret;
+	u32 calc_crc;
+	u32 crc_from_saved;
+	u32 magic_number;
+	char *cpb_data = (char *)address;
+
+	if (P->spt_corrupted) {
+		rsu_log(RSU_ERR, "corrupted SPT --");
+		rsu_log(RSU_ERR, "run rsu restore_spt <address> first\n");
+		return -EINVAL;
+	}
+
+	if (!cpb_data) {
+		rsu_log(RSU_ERR, "failed due to invalid address\n");
+		return -EINVAL;
+	}
+
+	calc_crc = crc32(0, (void *)cpb_data, CPB_SIZE);
+	rsu_log(RSU_DEBUG, "%s - calc_crc is 0x%x\n", __func__, calc_crc);
+	memcpy(&crc_from_saved, cpb_data + CPB_SIZE, sizeof(crc_from_saved));
+	rsu_log(RSU_DEBUG, "%s - crc_from_saved is 0x%x\n", __func__,
+		crc_from_saved);
+
+	if (calc_crc != crc_from_saved) {
+		rsu_log(RSU_ERR, "saved data is corrupted\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * check the magic number to prevent user from accidentally
+	 * restoring SPB
+	 */
+	memcpy(&magic_number, cpb_data, sizeof(magic_number));
+	if (magic_number != CPB_MAGIC_NUMBER) {
+		rsu_log(RSU_ERR, "failure due to mismatch magic number\n");
+		return -EINVAL;
+	}
+
+	memcpy(&P->cpb, cpb_data, CPB_SIZE);
+
+	/*
+	 * CRC+magic only prove self-consistency; a crafted header with an
+	 * out-of-range or misaligned image_ptr_offset would otherwise flow
+	 * into cpb_slots[] accesses. Validate before writing back to flash.
+	 */
+	ret = cpb_header_access_ok();
+	if (ret) {
+		rsu_log(RSU_ERR, "restored CPB has invalid header\n");
+		P->cpb_slots = NULL;
+		P->cpb_corrupted = true;
+		return ret;
+	}
+
+	P->cpb_slots = (u64 *)&P->cpb.data[P->cpb.header.image_ptr_offset];
+	ret = check_cpb();
+	if (ret) {
+		rsu_log(RSU_ERR, "restored CPB failed validation\n");
+		P->cpb_slots = NULL;
+		P->cpb_corrupted = true;
+		return ret;
+	}
+
+	ret = writeback_cpb();
+	if (ret) {
+		rsu_log(RSU_ERR, "failed to write back cpb\n");
+		return ret;
+	}
+
+	P->cpb_corrupted = false;
+	P->cpb_fixed = true;
+	return 0;
+}
+
+/**
+ * partition_count() - get the partition count
+ *
+ * Return: the number of partition at flash
+ */
+static int partition_count(void)
+{
+	return P->spt.partitions;
+}
+
+/**
+ * partition_name() - get a selected partition name
+ * @part_num: the selected partition number
+ *
+ * Return: partition name on success, or "BAD" on error
+ */
+static char *partition_name(int part_num)
+{
+	if (part_num < 0 || part_num >= P->spt.partitions)
+		return "BAD";
+
+	return P->spt.partition[part_num].name;
+}
+
+/**
+ * partition_offset() - get a selected partition offset
+ * @part_num: the selected partition number
+ *
+ * Return: offset on success, or -1 on error
+ */
+static u64 partition_offset(int part_num)
+{
+	if (part_num < 0 || part_num >= P->spt.partitions)
+		return -1;
+
+	return P->spt.partition[part_num].offset;
+}
+
+/**
+ * factory_offset() - get the offset of the factory image
+ *
+ * Return: offset on success, or -ENOENT if factory image not found
+ */
+static s64 factory_offset(void)
+{
+	int x;
+
+	for (x = 0; x < P->spt.partitions; x++)
+		if (strncmp(P->spt.partition[x].name, FACTORY_IMAGE_NAME,
+			    sizeof(P->spt.partition[0].name) - 1) == 0)
+			return P->spt.partition[x].offset;
+
+	return -ENOENT;
+}
+
+/**
+ * partition_size() - get a selected partition size
+ * @part_num: the selected partition number
+ *
+ * Return: the partition size for success, or -1 for error
+ */
+static u32 partition_size(int part_num)
+{
+	if (part_num < 0 || part_num >= P->spt.partitions)
+		return -1;
+
+	return P->spt.partition[part_num].length;
+}
+
+/**
+ * partition_reserved() - check if a selected partition is reserved
+ * @part_num: the selected partition number
+ *
+ * Return: 1 for reserved partition, or 0 for not
+ */
+static int partition_reserved(int part_num)
+{
+	if (part_num < 0 || part_num >= P->spt.partitions)
+		return 0;
+
+	return (P->spt.partition[part_num].flags & SPT_FLAG_RESERVED) ? 1 : 0;
+}
+
+/**
+ * partition_readonly() - check if a selected partition is read only
+ * @part_num: the selected partition number
+ *
+ * Return: 1 for read only partition, or 0 for not
+ */
+static int partition_readonly(int part_num)
+{
+	if (part_num < 0 || part_num >= P->spt.partitions)
+		return 0;
+
+	return (P->spt.partition[part_num].flags & SPT_FLAG_READONLY) ? 1 : 0;
+}
+
+/**
+ * partition_rename() - rename the selected partition name
+ * @part_num: the selected partition
+ * @name: the new name
+ *
+ * Return: 0 for success, or -ve on error
+ */
+static int partition_rename(int part_num, char *name)
+{
+	int x;
+	int ret;
+
+	if (part_num < 0 || part_num >= P->spt.partitions)
+		return -EINVAL;
+
+	if (strnlen(name, sizeof(P->spt.partition[0].name)) >=
+	    sizeof(P->spt.partition[0].name)) {
+		rsu_log(RSU_ERR,
+			"Partition name is too long - limited to %li",
+			sizeof(P->spt.partition[0].name) - 1);
+		return -EINVAL;
+	}
+
+	for (x = 0; x < P->spt.partitions; x++) {
+		if (strncmp(P->spt.partition[x].name, name,
+			    sizeof(P->spt.partition[0].name) - 1) == 0) {
+			rsu_log(RSU_ERR,
+				"Partition rename already in use\n");
+			return -EEXIST;
+		}
+	}
+
+	rsu_misc_safe_strcpy(P->spt.partition[part_num].name,
+			     sizeof(P->spt.partition[0].name),
+			     name, sizeof(P->spt.partition[0].name));
+
+	ret = writeback_spt();
+	if (ret)
+		return ret;
+
+	return load_spt();
+}
+
+/**
+ * partition_delete() - delete a partition
+ * @part_num: the selected partition
+ *
+ * Return: 0 for success, or -ve on error
+ */
+static int partition_delete(int part_num)
+{
+	int x;
+	int ret;
+
+	if (part_num < 0 || part_num >= P->spt.partitions) {
+		rsu_log(RSU_ERR, "Invalid partition number\n");
+		return -EINVAL;
+	}
+
+	for (x = part_num; x < P->spt.partitions - 1; x++)
+		P->spt.partition[x] = P->spt.partition[x + 1];
+
+	P->spt.partitions--;
+
+	ret = writeback_spt();
+	if (ret)
+		return ret;
+
+	return load_spt();
+}
+
+/**
+ * partition_create() - create a partition
+ * @name: partition name
+ * @start: partition start address
+ * @size: partition size
+ *
+ * Return: 0 for success, or -ve on error
+ */
+static int partition_create(char *name, u64 start, unsigned int size)
+{
+	int x;
+	int ret;
+	u64 end;
+
+	/* Reject overflow before computing end; a wrapped end defeats overlap checks. */
+	if ((u64)size > U64_MAX - start) {
+		rsu_log(RSU_ERR, "Partition end overflows u64\n");
+		return -EINVAL;
+	}
+	end = start + size;
+
+	if (size % MIN_QSPI_ERASE_SIZE) {
+		rsu_log(RSU_ERR, "Invalid partition size\n");
+		return -EINVAL;
+	}
+
+	if (start % MIN_QSPI_ERASE_SIZE) {
+		rsu_log(RSU_ERR, "Invalid partition address\n");
+		return -EINVAL;
+	}
+
+	if (strnlen(name, sizeof(P->spt.partition[0].name)) >=
+	    sizeof(P->spt.partition[0].name)) {
+		rsu_log(RSU_ERR, "Partition name is too long - limited to %i\n",
+			sizeof(P->spt.partition[0].name) - 1);
+		return -EINVAL;
+	}
+
+	for (x = 0; x < P->spt.partitions; x++) {
+		if (strncmp(P->spt.partition[x].name, name,
+			    sizeof(P->spt.partition[0].name) - 1) == 0) {
+			rsu_log(RSU_ERR, "Partition name already in use\n");
+			return -EEXIST;
+		}
+	}
+
+	if (P->spt.partitions == SPT_MAX_PARTITIONS) {
+		rsu_log(RSU_ERR, "Partition table is full\n");
+		return -ENOSPC;
+	}
+
+	for (x = 0; x < P->spt.partitions; x++) {
+		u64 pstart = P->spt.partition[x].offset;
+		u64 plen = P->spt.partition[x].length;
+		u64 pend;
+
+		/* Skip a corrupt entry rather than wrap; check_spt() validates on load. */
+		if (plen > U64_MAX - pstart)
+			continue;
+		pend = pstart + plen;
+
+		if (start < pend && end > pstart) {
+			rsu_log(RSU_ERR, "Partition overlap\n");
+			return -EEXIST;
+		}
+	}
+
+	rsu_misc_safe_strcpy(P->spt.partition[P->spt.partitions].name,
+			     sizeof(P->spt.partition[0].name), name,
+			     sizeof(P->spt.partition[0].name));
+	P->spt.partition[P->spt.partitions].offset = start;
+	P->spt.partition[P->spt.partitions].length = size;
+	P->spt.partition[P->spt.partitions].flags = 0;
+
+	P->spt.partitions++;
+
+	ret = writeback_spt();
+	if (ret)
+		return ret;
+
+	return load_spt();
+}
+
+/* Reject corrupt CPB header before indexing cpb_slots[]. */
+static int cpb_ptr_slots_access_ok(void)
+{
+	if (!P->cpb_slots)
+		return -EUCLEAN;
+	return cpb_header_access_ok();
+}
+
+/**
+ * priority_get() - get the selected partition's priority
+ * @part_num: the selected partition number
+ *
+ * Return: 0 for success, or -ve on error
+ */
+static int priority_get(int part_num)
+{
+	int x;
+	int priority = 0;
+	int ret;
+
+	if (part_num < 0 || part_num >= P->spt.partitions)
+		return -EINVAL;
+	ret = cpb_ptr_slots_access_ok();
+	if (ret)
+		return ret;
+
+	for (x = P->cpb.header.image_ptr_slots; x > 0; x--) {
+		if (P->cpb_slots[x - 1] != ERASED_ENTRY &&
+		    P->cpb_slots[x - 1] != SPENT_ENTRY) {
+			priority++;
+			if (P->cpb_slots[x - 1] ==
+			    P->spt.partition[part_num].offset)
+				return priority;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * priority_add() - enable the selected partition's priority
+ * @part_num: the selected partition number
+ *
+ * Return: 0 for success, or -ve on error
+ */
+static int priority_add(int part_num)
+{
+	int x;
+	int y;
+	int ret;
+
+	if (part_num < 0 || part_num >= P->spt.partitions)
+		return -EINVAL;
+	ret = cpb_ptr_slots_access_ok();
+	if (ret)
+		return ret;
+
+	for (x = 0; x < P->cpb.header.image_ptr_slots; x++) {
+		if (P->cpb_slots[x] == ERASED_ENTRY) {
+			if (update_cpb(x,
+				       P->spt.partition[part_num].offset)) {
+				/*
+				 * update_cpb() may have written one CPB but
+				 * not the other; force a reload so load_cpb()
+				 * resyncs the two flash copies before we
+				 * return failure.
+				 */
+				load_cpb();
+				return -EIO;
+			}
+			return load_cpb();
+		}
+	}
+
+	rsu_log(RSU_DEBUG, "Compressing CPB\n");
+
+	for (x = 0, y = 0; x < P->cpb.header.image_ptr_slots; x++) {
+		if (P->cpb_slots[x] != ERASED_ENTRY &&
+		    P->cpb_slots[x] != SPENT_ENTRY) {
+			P->cpb_slots[y++] = P->cpb_slots[x];
+		}
+	}
+
+	if (y < P->cpb.header.image_ptr_slots)
+		P->cpb_slots[y++] = P->spt.partition[part_num].offset;
+	else
+		return -ENOSPC;
+
+	while (y < P->cpb.header.image_ptr_slots)
+		P->cpb_slots[y++] = ERASED_ENTRY;
+
+	ret = writeback_cpb();
+	if (ret)
+		return ret;
+
+	return load_cpb();
+}
+
+/**
+ * priority_remove() - remove the selected partition's priority
+ * @part_num: the selected partition number
+ *
+ * Return: 0 for success, or -ve on error
+ */
+static int priority_remove(int part_num)
+{
+	int x;
+	int ret;
+
+	if (part_num < 0 || part_num >= P->spt.partitions)
+		return -EINVAL;
+	ret = cpb_ptr_slots_access_ok();
+	if (ret)
+		return ret;
+
+	for (x = 0; x < P->cpb.header.image_ptr_slots; x++) {
+		if (P->cpb_slots[x] == P->spt.partition[part_num].offset)
+			if (update_cpb(x, SPENT_ENTRY)) {
+				/* See priority_add(): same recovery contract. */
+				load_cpb();
+				return -EIO;
+			}
+	}
+
+	return load_cpb();
+}
+
+/**
+ * data_read() - read data from flash
+ * @part_num: partition number
+ * @offset: offset which data will be read from
+ * @bytes: data size in byte which will be read
+ * @buf: pointer to buffer contains to be read data
+ *
+ * Return: 0 for success, or error code
+ */
+static int data_read(int part_num, int offset, int bytes, void *buf)
+{
+	return read_part(part_num, offset, buf, bytes);
+}
+
+/**
+ * data_write() - write data to flash
+ * @part_num: partition number
+ * @part_num: offset which data will be written to
+ * @bytes: data size in bytes which will be written
+ * @buf: pointer to buffer contains to be written data
+ *
+ * Return: 0 for success, or error code
+ */
+static int data_write(int part_num, int offset, int bytes, void *buf)
+{
+	return write_part(part_num, offset, buf, bytes);
+}
+
+/**
+ * data_erase() - erase flash data
+ * @part_num: partition number
+ *
+ * Return: 0 for success, or error code
+ */
+static int data_erase(int part_num)
+{
+	return erase_part(part_num);
+}
+
+/**
+ * image_load() - load production or factory image
+ * @offset: the image offset
+ *
+ * Return: 0 for success, or error code
+ */
+static int image_load(u64 offset)
+{
+	u32 flash_offset[2];
+
+	flash_offset[0] = lower_32_bits(offset);
+	flash_offset[1] = upper_32_bits(offset);
+
+	rsu_log(RSU_DEBUG, "RSU_DEBUG: RSU updated to 0x%08x%08x\n",
+		flash_offset[1], flash_offset[0]);
+
+	if (mbox_rsu_update(flash_offset))
+		return -ELOWLEVEL;
+
+	return 0;
+}
+
+/**
+ * status_log() - get firmware status info
+ * @info: pointer to rsu_status_info
+ *
+ * Return: 0 for success, or error code
+ */
+static int status_log(struct rsu_status_info *info)
+{
+	if (mbox_rsu_status((u32 *)info,
+			    sizeof(struct rsu_status_info) / 4)) {
+		rsu_log(RSU_ERR,
+			"RSU: Firmware or flash content not supporting RSU\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/**
+ * notify_fw() - call the firmware notify command
+ * @value: the notification value
+ *
+ * Return: 0 for success, or error code
+ */
+static int notify_fw(u32 value)
+{
+	rsu_log(RSU_DEBUG, "RSU_DEBUG: notified with 0x%08x.\n", value);
+
+	if (mbox_hps_stage_notify(value))
+		return -ELOWLEVEL;
+
+	return 0;
+}
+
+/**
+ * dcmf_version() - retrieve the decision firmware version
+ * @versions: pointer to where the four DCMF versions will be stored
+ *
+ * This function is used to retrieve the version of each of the four DCMF copies
+ * in flash.
+ *
+ * Returns: 0 on success, or error code
+ */
+static int dcmf_version(__u32 *versions)
+{
+	int ret;
+
+	if (!versions)
+		return -EINVAL;
+
+	/* get the first flash since DCMF always located at first flash */
+	P->flash = P->flashlist[0];
+
+	ret = rsu_mtd_read(P->flash, DCMF0_VERSION_OFFSET, 4, &versions[0]);
+	if (ret) {
+		rsu_log(RSU_ERR, "read flash error=%i\n", ret);
+		return ret;
+	}
+
+	ret = rsu_mtd_read(P->flash, DCMF1_VERSION_OFFSET, 4, &versions[1]);
+	if (ret) {
+		rsu_log(RSU_ERR, "read flash error=%i\n", ret);
+		return ret;
+	}
+
+	ret = rsu_mtd_read(P->flash, DCMF2_VERSION_OFFSET, 4, &versions[2]);
+	if (ret) {
+		rsu_log(RSU_ERR, "read flash error=%i\n", ret);
+		return ret;
+	}
+
+	ret = rsu_mtd_read(P->flash, DCMF3_VERSION_OFFSET, 4, &versions[3]);
+	if (ret) {
+		rsu_log(RSU_ERR, "read flash error=%i\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * dcmf_status() - determine if decision dcmfs are corrupted
+ * @status: pointer to where the status will be stored
+ *
+ * This function is used to determine whether decision firmware copies are
+ * corrupted in flash, with the currently used decision firmware being used as
+ * reference. The status is an array of 4 values, one for each decision
+ * firmware copy. A 0 means the copy is fine, anything else means the copy is
+ * corrupted.
+ *
+ * Returns: 0 on success, or error code
+ */
+static int dcmf_status(u16 *status)
+{
+	int ret;
+	struct rsu_status_info rsu_status;
+	char *buffa = NULL;
+	char *buffb = NULL;
+	int crt_dcmf;
+	int idx;
+
+	/* get the first flash since DCMF always located at first flash */
+	P->flash = P->flashlist[0];
+
+	ret = status_log(&rsu_status);
+	if (ret) {
+		rsu_log(RSU_ERR, "status_log error");
+		return ret;
+	}
+	crt_dcmf = RSU_VERSION_CRT_DCMF_IDX(rsu_status.version);
+
+	buffa = (char *)malloc(DCMF_SIZE);
+	if (!buffa) {
+		rsu_log(RSU_ERR, "malloc error");
+		return -ENOMEM;
+	}
+
+	buffb = (char *)malloc(DCMF_SIZE);
+	if (!buffb) {
+		rsu_log(RSU_ERR, "malloc error");
+		ret = -ENOMEM;
+		goto ret_val;
+	}
+
+	ret = rsu_mtd_read(P->flash, crt_dcmf * DCMF_SIZE, DCMF_SIZE, buffa);
+	if (ret) {
+		rsu_log(RSU_ERR, "read flash error=%i\n", ret);
+		goto ret_val;
+	}
+
+	for (idx = 0; idx < 4; idx++) {
+		int i;
+
+		status[idx] = 0;
+
+		if (idx == crt_dcmf)
+			continue;
+
+		ret = rsu_mtd_read(P->flash, idx * DCMF_SIZE, DCMF_SIZE, buffb);
+		if (ret) {
+			rsu_log(RSU_ERR, "read flash error=%i\n", ret);
+			goto ret_val;
+		}
+
+		for (i = 0; i < DCMF_SIZE; i++)
+			if (buffa[i] != buffb[i]) {
+				status[idx] = 1;
+				break;
+			}
+	}
+
+ret_val:
+	if (buffa)
+		free(buffa);
+	if (buffb)
+		free(buffb);
+	return ret;
+}
+
+/**
+ * max_retry() - retrieve the max_retry parameter
+ * @value: pointer to where the max_retry will be stored
+ *
+ * This function is used to retrieve the max_retry parameter from the decision
+ * firmware data section.
+ *
+ * Returns: 0 on success, or error code
+ */
+static int max_retry(__u8 *value)
+{
+	int ret;
+	__u8 tmp;
+
+	if (!value)
+		return -EINVAL;
+
+	/* get the first flash since DCMF always located at first flash */
+	P->flash = P->flashlist[0];
+
+	ret = rsu_mtd_read(P->flash, DCIO_MAX_RETRY_OFFSET, 1, &tmp);
+	if (ret) {
+		rsu_log(RSU_ERR, "read flash error=%i\n", ret);
+		return ret;
+	}
+
+	/* Add one, to make value consistent with Quartus view */
+	*value = tmp + 1;
+
+	return ret;
+}
+
+/* Forward decl so qspi_ll_intf can reference .exit before the body. */
+static void ll_exit(void);
+
+static struct rsu_ll_intf qspi_ll_intf = {
+	.exit = ll_exit,
+	.priv = NULL,
+
+	.partition.count = partition_count,
+	.partition.name = partition_name,
+	.partition.offset = partition_offset,
+	.partition.factory_offset = factory_offset,
+	.partition.size = partition_size,
+	.partition.reserved = partition_reserved,
+	.partition.readonly = partition_readonly,
+	.partition.rename = partition_rename,
+	.partition.delete = partition_delete,
+	.partition.create = partition_create,
+
+	.priority.get = priority_get,
+	.priority.add = priority_add,
+	.priority.remove = priority_remove,
+
+	.data.read = data_read,
+	.data.write = data_write,
+	.data.erase = data_erase,
+
+	.fw_ops.load = image_load,
+	.fw_ops.status = status_log,
+	.fw_ops.notify = notify_fw,
+	.fw_ops.dcmf_version = dcmf_version,
+	.fw_ops.dcmf_status = dcmf_status,
+	.fw_ops.max_retry = max_retry,
+
+	.spt_ops.restore = restore_spt_from_address,
+	.spt_ops.save = save_spt_to_address,
+	.spt_ops.corrupted = corrupted_spt,
+
+	.cpb_ops.empty = empty_cpb,
+	.cpb_ops.restore = restore_cpb_from_address,
+	.cpb_ops.save = save_cpb_to_address,
+	.cpb_ops.corrupted = corrupted_cpb
+};
+
+static void ll_exit(void)
+{
+	struct rsu_qspi_priv *ctx = qspi_ctx;
+
+	if (!ctx)
+		return;
+
+	ctx->cpb0_part = -1;
+	ctx->cpb1_part = -1;
+	ctx->cpb_corrupted = false;
+	ctx->cpb_fixed = false;
+	ctx->spt_corrupted = false;
+
+	for (int i = 0; i < QSPI_MAX_DEVICE; i++) {
+		if (ctx->flashlist && ctx->flashlist[i]) {
+			rsu_mtd_unclaim(ctx->flashlist[i]);
+			ctx->flashlist[i] = NULL;
+		}
+	}
+
+	free(ctx->flashlist);
+	ctx->flashlist = NULL;
+	ctx->flash = NULL;
+	ctx->cpb_slots = NULL;
+
+	memset(ctx, 0, sizeof(*ctx));
+	free(ctx);
+	qspi_ctx = NULL;
+
+	/* Clear so a stale .priv cannot dereference freed memory. */
+	qspi_ll_intf.priv = NULL;
+}
+
+#if CONFIG_IS_ENABLED(SOCFPGA_RSU_MULTIFLASH)
+int get_num_flash(u32 *flash_enabled)
+{
+	int flash_count = 0;
+	struct flash_info mbox_flash_info[QSPI_MAX_DEVICE];
+
+	/* retrieve qspi info from mailbox */
+	if (mbox_qspi_get_device_info((u32 *)mbox_flash_info, 8)) {
+		rsu_log(RSU_ERR,
+			"%s: RSU:Firmware or flash content not supporting RSU\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	for (int i = 0; i < QSPI_MAX_DEVICE; i++) {
+		debug("QSPI Device INFO\nflash_info[%d]: 0x%08x\nlen: 0x%08x\n",
+		      i, mbox_flash_info[i].size, QSPI_GET_DEVICE_INFO_RESP_LEN);
+	}
+
+	for (int i = 0; i < QSPI_MAX_DEVICE; i++) {
+		flash_enabled[i] = 0;
+
+		/* Calculate the size return by mailbox; */
+		if (mbox_flash_info[i].size > SZ_2G) {
+			/* >2Gb, power the bit 0-30 */
+			debug("RSU: QSPI %d larger than 2Gbits capacity.", i);
+			flash_enabled[i] = pow(2, mbox_flash_info[i].size & GENMASK(30, 0));
+			flash_enabled[i] = flash_enabled[i] / SZ_8;
+		} else {
+			/* <= 2Gb, total the bit 0-30 */
+			debug("RSU: QSPI %d lower than 2Gbits capacity.", i);
+			flash_enabled[i] = mbox_flash_info[i].size & GENMASK(30, 0);
+			flash_enabled[i] = flash_enabled[i] / SZ_8;
+		}
+
+		debug("Calculated flash size[%d]: %d\n", i, flash_enabled[i]);
+		if (flash_enabled[i] > 0)
+			flash_count++;
+	}
+
+	debug("RSU: Total flash #: %d\n", flash_count);
+
+	return flash_count;
+}
+#endif
+
+int rsu_ll_qspi_init(struct rsu_ll_intf **intf)
+{
+	u32 spt_offset[SPT_OFFSET_MBOX];
+
+	qspi_ctx = malloc(sizeof(*qspi_ctx));
+	if (!qspi_ctx)
+		return -ENOMEM;
+	memset(qspi_ctx, 0, sizeof(*qspi_ctx));
+	qspi_ctx->cpb0_part = -1;
+	qspi_ctx->cpb1_part = -1;
+	qspi_ctx->num_flash = -1;
+	/* Set for future per-session use; current backend reads qspi_ctx directly. */
+	qspi_ll_intf.priv = qspi_ctx;
+
+	/* get the offset from firmware */
+	if (mbox_rsu_get_spt_offset(spt_offset, 4)) {
+		rsu_log(RSU_ERR,
+			"RSU: Firmware or flash content not supporting RSU\n");
+		ll_exit();
+		return -ECOMM;
+	}
+
+#if CONFIG_IS_ENABLED(SOCFPGA_RSU_MULTIFLASH)
+	/* Zero-init so a partial fill cannot leak into the probe loop. */
+	u32 flash_enabled[QSPI_MAX_DEVICE] = {0};
+
+	/* retrieve qspi info from mailbox */
+	P->num_flash = get_num_flash(flash_enabled);
+	printf("%s: MULTIFLASH_ENABLED: num_flash #%d\n", __func__, P->num_flash);
+	if (P->num_flash < 0) {
+		rsu_log(RSU_ERR, "get_num_flash failed, err=%d\n",
+			P->num_flash);
+		ll_exit();
+		return P->num_flash;
+	}
+#else
+	P->num_flash = 1;
+	printf("%s: MULTIFLASH_DISABLED: num_flash #%d\n", __func__, P->num_flash);
+#endif
+
+	P->flashlist = calloc(QSPI_MAX_DEVICE, sizeof(*P->flashlist));
+	if (!P->flashlist) {
+		rsu_log(RSU_ERR,
+			"RSU: Failed to allocate memory for flash list. Exiting.\n");
+		ll_exit();
+		return -ENOMEM;
+	}
+
+#if CONFIG_IS_ENABLED(SOCFPGA_RSU_MULTIFLASH)
+	{
+		int found = 0;
+
+		/*
+		 * Firmware may enable CSes sparsely; compact the probed
+		 * handles into a contiguous prefix because consumers iterate
+		 * 0..num_flash-1 unconditionally.
+		 */
+		for (int i = 0; i < QSPI_MAX_DEVICE; i++) {
+			debug("%s: probe flash #%d\n", __func__, i);
+			if (flash_enabled[i] > 0) {
+				int err;
+
+				err = rsu_mtd_probe(CONFIG_SF_DEFAULT_BUS, i,
+						    &P->flash);
+				if (err) {
+					rsu_log(RSU_ERR, "SPI probe failed.\n");
+					ll_exit();
+					return err;
+				}
+
+				P->flashlist[found++] = P->flash;
+			}
+		}
+
+		if (!found) {
+			rsu_log(RSU_ERR,
+				"RSU: no QSPI flash enabled by firmware\n");
+			ll_exit();
+			return -ENODEV;
+		}
+
+		/* Resync num_flash with the compacted flashlist[]. */
+		P->num_flash = found;
+	}
+#else
+	{
+		int err;
+
+		err = rsu_mtd_probe(CONFIG_SF_DEFAULT_BUS, CONFIG_SOCFPGA_RSU_SF_CS,
+				    &P->flash);
+		if (err) {
+			ll_exit();
+			rsu_log(RSU_ERR, "SPI probe failed.\n");
+			return err;
+		}
+
+		P->flashlist[0] = P->flash;
+	}
+#endif
+	P->spt0_offset = spt_offset[1];
+	P->spt1_offset = spt_offset[3];
+	rsu_log(RSU_DEBUG, "SPT0 offset 0x%08x\n", P->spt0_offset);
+	rsu_log(RSU_DEBUG, "SPT1 offset 0x%08x\n", P->spt1_offset);
+
+	if (load_spt() && !P->spt_corrupted) {
+		ll_exit();
+		rsu_log(RSU_ERR, "Bad SPT\n");
+		return -EUCLEAN;
+	}
+
+	if (P->spt_corrupted) {
+		P->cpb_corrupted = true;
+	} else if (load_cpb() && !P->cpb_corrupted) {
+		ll_exit();
+		rsu_log(RSU_ERR, "Bad CPB\n");
+		return -EUCLEAN;
+	}
+
+	*intf = &qspi_ll_intf;
+
+	return 0;
+}
diff --git a/arch/arm/mach-socfpga/rsu_misc.c b/arch/arm/mach-socfpga/rsu_misc.c
new file mode 100644
index 00000000000..50a744d162e
--- /dev/null
+++ b/arch/arm/mach-socfpga/rsu_misc.c
@@ -0,0 +1,854 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include <linux/compat.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <asm/arch/rsu.h>
+#include <asm/arch/rsu_ll.h>
+#include <asm/arch/rsu_misc.h>
+#include <asm/types.h>
+#include <u-boot/zlib.h>
+#include <errno.h>
+#include <exports.h>
+
+#define LOG_BUF_SIZE	1024
+
+static char *cb_buffer;
+static int cb_buffer_togo;
+
+static char *reserved_names[] = {
+	"BOOT_INFO",
+	"FACTORY_IMAGE",
+	"SPT",
+	"SPT0",
+	"SPT1",
+	"CPB",
+	"CPB0",
+	"CPB1",
+	""
+};
+
+struct pointer_block {
+	u32 num_ptrs;
+	u32 RSVD0;
+	u64 ptrs[4];
+	u8 RSVD1[0xd4];
+	u32 crc;
+};
+
+/**
+ * enum rsu_block_type - enumeration for image block types
+ * @SECTION_BLOCK: section block
+ * @SIGNATURE_BLOCK: signature block
+ * @REGULAR_BLOCK: all other block types
+ */
+enum rsu_block_type {
+	SECTION_BLOCK = 0,
+	SIGNATURE_BLOCK,
+	REGULAR_BLOCK
+};
+
+/* maximum number of sections supported for an image */
+#define MAX_SECTIONS 64
+
+/**
+ * struct rsu_image_state - structure for stated of image processing
+ * @offset: current block offset in bytes
+ * @block_type: current block type
+ * @sections: identified section offsets
+ * @no_sections: number of identified sections
+ * @absolute: current image is an absolute image
+ *
+ * This structure is used to maintain the state of image parsing, both for
+ * relocating images to final destination in flash, and also for verifying
+ * images already stored in flash.
+ */
+struct rsu_image_state {
+	int offset;
+	enum rsu_block_type block_type;
+	u64 sections[MAX_SECTIONS];
+	int no_sections;
+	int absolute;
+};
+
+/**
+ * find_section() - search section in the current list of identified sections
+ * @state: current state machine state
+ * @section: section to be searched
+ *
+ * Return: 1 if section is found, 0 if section is not found
+ */
+static int find_section(struct rsu_image_state *state, u64 section)
+{
+	int x;
+
+	for (x = 0; x < state->no_sections; x++)
+		if (section == state->sections[x])
+			return 1;
+
+	return 0;
+}
+
+/**
+ * add_section() - add section to the current list of identified sections
+ * @state: current state machine state
+ * @section: section to be added
+ *
+ * Return: 0 on success, or -ve on error
+ */
+static int add_section(struct rsu_image_state *state, u64 section)
+{
+	if (find_section(state, section))
+		return 0;
+
+	if (state->no_sections >= MAX_SECTIONS)
+		return -ENOSPC;
+
+	state->sections[state->no_sections++] = section;
+
+	return 0;
+}
+
+/**
+ * swap_bits() - swap bits
+ * @data: pointer point to data
+ * @len: data length
+ */
+void swap_bits(char *data, int len)
+{
+	int x, y;
+	char tmp;
+
+	for (x = 0; x < len; x++) {
+		tmp = 0;
+		for (y = 0; y < 8; y++) {
+			tmp <<= 1;
+			if (data[x] & 1)
+				tmp |= 1;
+			data[x] >>= 1;
+		}
+		data[x] = tmp;
+	}
+}
+
+int pow(u32 x, u32 y)
+{
+	if (y == 0)
+		return 1;
+	else if ((y % 2) == 0)
+		return pow(x, y / 2) * pow(x, y / 2);
+	else
+		return x * pow(x, y / 2) * pow(x, y / 2);
+}
+
+/**
+ * rsu_misc_is_rsvd_name() - check if a reserved name
+ *
+ * @name: name to check
+ *
+ * Returns 1 if a reserved name, or 0 for not
+ */
+int rsu_misc_is_rsvd_name(char *name)
+{
+	int x;
+
+	for (x = 0; reserved_names[x][0] != '\0'; x++)
+		if (strcmp(name, reserved_names[x]) == 0)
+			return 1;
+
+	return 0;
+}
+
+/**
+ * rsu_misc_is_slot() - check if a read only or reserved partition
+ * @ll_intf: pointer to ll_intf
+ * @part_num: partition number
+ *
+ * Return 1 if not read only or reserved, or 0 for is
+ */
+int rsu_misc_is_slot(struct rsu_ll_intf *ll_intf, int part_num)
+{
+	if (ll_intf->partition.readonly(part_num) ||
+	    ll_intf->partition.reserved(part_num))
+		return 0;
+
+	if (rsu_misc_is_rsvd_name(ll_intf->partition.name(part_num)))
+		return 0;
+
+	return 1;
+}
+
+/**
+ * rsu_misc_slot2part() - get partition number from the slot
+ * @ll_intf: pointer to ll_intf
+ * @slot: slot number
+ *
+ * Return: partition number on success, or -ve on error
+ */
+int rsu_misc_slot2part(struct rsu_ll_intf *ll_intf, int slot)
+{
+	int partitions;
+	int cnt = 0;
+
+	partitions = ll_intf->partition.count();
+
+	for (int x = 0; x < partitions; x++) {
+		if (rsu_misc_is_slot(ll_intf, x)) {
+			if (slot == cnt)
+				return x;
+			cnt++;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * rsu_misc_writeprotected() - check if a slot is protected
+ * @slot: the number of slot to be checked
+ *
+ * Return 1 if a slot is protected, 0 for not
+ */
+int rsu_misc_writeprotected(int slot)
+{
+	char *protected;
+	int protected_slot_numb;
+
+	/* protect works only for slot 0-31 */
+	if (slot > 31)
+		return 0;
+
+	protected = env_get("rsu_protected_slot");
+	if (!protected)
+		return 0;
+
+	protected_slot_numb = (int)simple_strtol(protected, NULL, 0);
+	if (protected_slot_numb < 0 || protected_slot_numb > 31) {
+		rsu_log(RSU_WARNING,
+			"protected slot works only on the first 32 slots\n");
+		return 0;
+	}
+
+	if (protected_slot_numb == slot)
+		return 1;
+	else
+		return 0;
+}
+
+/**
+ * rsu_misc_spt_checksum_enabled() - check if the SPT checksum is enabled
+ *
+ * Return 1 if SPT checksum mechanism is enabled, 0 for disabled
+ */
+int rsu_misc_spt_checksum_enabled(void)
+{
+	char *c_enabled;
+	int checksum_enabled;
+
+	c_enabled = env_get("rsu_spt_checksum");
+	if (!c_enabled)
+		return 0;
+
+	checksum_enabled = (int)simple_strtol(c_enabled, NULL, 0);
+	if (checksum_enabled)
+		return 1;
+
+	return 0;
+}
+
+/**
+ * rsu_misc_safe_strcpy() - buffer copy
+ * @dst: pointer to dst
+ * @dsz: dst buffer size
+ * @src: pointer to src
+ * @ssz: src buffer size
+ */
+void rsu_misc_safe_strcpy(char *dst, int dsz, char *src, int ssz)
+{
+	int len;
+
+	if (!dst || dsz <= 0)
+		return;
+
+	if (!src || ssz <= 0) {
+		dst[0] = '\0';
+		return;
+	}
+
+	len = strnlen(src, ssz);
+	if (len >= dsz)
+		len = dsz - 1;
+
+	memcpy(dst, src, len);
+	dst[len] = '\0';
+}
+
+/**
+ * rsu_cb_buf_init() - initialize buffer parameters
+ * @buf: pointer to buf
+ * @size: size of buffer
+ *
+ * Return: 0 on success, or -ve on error
+ */
+int rsu_cb_buf_init(void *buf, int size)
+{
+	if (!buf || size <= 0)
+		return -EINVAL;
+
+	cb_buffer = (char *)buf;
+	cb_buffer_togo = size;
+
+	return 0;
+}
+
+/**
+ * rsu_cb_buf_exit() - reset buffer parameters
+ */
+void rsu_cb_buf_exit(void)
+{
+	cb_buffer = NULL;
+	cb_buffer_togo = -1;
+}
+
+/**
+ * rsu_cb_buf() - copy data to buffer
+ * @buf: pointer to data buffer
+ * @len: size of data buffer
+ *
+ * Return the buffer data size
+ */
+int rsu_cb_buf(void *buf, int len)
+{
+	int read_len;
+
+	if (!cb_buffer_togo)
+		return 0;
+
+	if (!cb_buffer || cb_buffer_togo < 0 || !buf || len < 0)
+		return -EINVAL;
+
+	if (cb_buffer_togo < len)
+		read_len = cb_buffer_togo;
+	else
+		read_len = len;
+
+	memcpy(buf, cb_buffer, read_len);
+
+	cb_buffer += read_len;
+	cb_buffer_togo -= read_len;
+
+	if (!cb_buffer_togo)
+		cb_buffer = NULL;
+
+	return read_len;
+}
+
+/**
+ * sig_block_process() - process signature block
+ * @state: current state machine state
+ * @block: signature block
+ * @info: slot where the data will be written
+ *
+ * Determine if the signature block is part of an absolute image, and add its
+ * section pointers to the list of identified sections.
+ *
+ * Return: zero value for success, or negative value on error
+ */
+static int sig_block_process(struct rsu_image_state *state,	void *block,
+			     struct rsu_slot_info *info)
+{
+	char *data = (char *)block;
+	struct pointer_block *ptr_blk = (struct pointer_block *)(data
+					+ SIG_BLOCK_PTR_OFFS);
+	int x;
+
+	/* Determine if absolute image - only done for 2nd block in an image
+	 * which is always a signature block
+	 */
+	if (state->offset == IMAGE_BLOCK_SZ)
+		for (x = 0; x < 4; x++)
+			if (ptr_blk->ptrs[x] > (__u64)info->size) {
+				state->absolute = 1;
+				rsu_log(RSU_DEBUG, "Found absolute image\n");
+				break;
+			}
+
+	/* Add pointers to list of identified sections */
+	for (x = 0; x < 4; x++)
+		if (ptr_blk->ptrs[x]) {
+			if (state->absolute)
+				add_section(state, ptr_blk->ptrs[x] -
+					    info->offset);
+			else
+				add_section(state, ptr_blk->ptrs[x]);
+		}
+
+	return 0;
+}
+
+/**
+ * sig_block_adjust() - adjust signature block pointers before writing to flash
+ * @state: current state machine state
+ * @block: signature block
+ * @info: slot where the data will be written
+ *
+ * This function checks that the section pointers are consistent, and for non-
+ * absolute images it updates them to match the destination slot, also re-
+ * computing the CRC.
+ *
+ * Return: zero value for success, -1 on error
+ */
+static int sig_block_adjust(struct rsu_image_state *state, void *block,
+			    struct rsu_slot_info *info)
+{
+	u32 calc_crc;
+	int x;
+	char *data = (char *)block;
+	struct pointer_block *ptr_blk = (struct pointer_block *)(data
+					+ SIG_BLOCK_PTR_OFFS);
+
+	/*
+	 * Check CRC on 4kB block before proceeding.  All bytes must be
+	 * bit-swapped before they can used in zlib CRC32 library function.
+	 * The CRC value is stored in big endian in the bitstream.
+	 */
+	swap_bits(block, IMAGE_BLOCK_SZ);
+	calc_crc = crc32(0, (uchar *)block, SIG_BLOCK_CRC_OFFS);
+	if (be32_to_cpu(ptr_blk->crc) != calc_crc) {
+		rsu_log(RSU_ERR,
+			"Error: Bad CRC32. Calc = %08X / From Block = %08x\n",
+			calc_crc, be32_to_cpu(ptr_blk->crc));
+		return -EBADMSG;
+	}
+	swap_bits(block, IMAGE_BLOCK_SZ);
+
+	/* Check pointers */
+	for (x = 0; x < 4; x++) {
+		u64 ptr = ptr_blk->ptrs[x];
+
+		if (!ptr)
+			continue;
+
+		if (state->absolute)
+			ptr -= info->offset;
+
+		if (ptr > info->size) {
+			rsu_log(RSU_ERR,
+				"Error: A pointer not within the slot\n");
+			return -EINVAL;
+		}
+	}
+
+	/* Absolute images do not require pointer updates */
+	if (state->absolute)
+		return 0;
+
+	/* Update pointers */
+	for (x = 0; x < 4; x++) {
+		if (ptr_blk->ptrs[x]) {
+			u64 old =  ptr_blk->ptrs[x];
+
+			ptr_blk->ptrs[x] += info->offset;
+			rsu_log(RSU_DEBUG,
+				"Adjusting pointer 0x%llx -> 0x%llx\n",
+				old, ptr_blk->ptrs[x]);
+		}
+	}
+
+	/* Update CRC in block */
+	swap_bits(block, IMAGE_BLOCK_SZ);
+	calc_crc = crc32(0, (uchar *)block, SIG_BLOCK_CRC_OFFS);
+	ptr_blk->crc = be32_to_cpu(calc_crc);
+	swap_bits(block, IMAGE_BLOCK_SZ);
+
+	return 0;
+}
+
+/**
+ * block_compare() - compare two image blocks
+ * @state: current state machine state
+ * @block: input data provided by user
+ * @vblock: verification data read from flash
+ *
+ * Return: non-negative value for successful comparisor, or negative value on
+ * failure or comparison difference found.
+ */
+static int block_compare(struct rsu_image_state *state, void *block,
+			 void *vblock)
+{
+	char *buf = (char *)block;
+	char *vbuf = (char *)vblock;
+	int x;
+
+	for (x = 0; x < IMAGE_BLOCK_SZ; x++)
+		if (vbuf[x] != buf[x]) {
+			rsu_log(RSU_ERR, "Expect %02X, got %02X @0x%08X\n",
+				buf[x], vbuf[x], state->offset + x);
+			return -ECMP;
+		}
+
+	return 0;
+}
+
+/**
+ * sig_block_compare() - compare two signature blocks
+ * @state: current state machine state
+ * @ublock: input data provided by user
+ * @vblock: verification data read from flash
+ * @info: slot where the verification data was read from
+ *
+ * Absolute images are compared directly, while for non-absolute images the
+ * pointers and associated CRC are re-computed to see if they match.
+ *
+ * Return: zero for success, or negative value on erorr or finding differences.
+ */
+static int sig_block_compare(struct rsu_image_state *state, void *ublock,
+			     void *vblock, struct rsu_slot_info *info)
+{
+	u32 calc_crc;
+	int x;
+	char block[IMAGE_BLOCK_SZ];
+	struct pointer_block *ptr_blk = (struct pointer_block *)(block +
+		SIG_BLOCK_PTR_OFFS);
+
+	rsu_log(RSU_DEBUG, "Compare signature block @0x%08x\n", state->offset);
+
+	/* Make a copy of the data provided by the user */
+	memcpy(block, ublock, IMAGE_BLOCK_SZ);
+
+	/* Update signature block to match what we expect in flash */
+	if (!state->absolute) {
+		/* Update pointers */
+		for (x = 0; x < 4; x++)
+			if (ptr_blk->ptrs[x])
+				ptr_blk->ptrs[x] += info->offset;
+
+		/* Update CRC in block */
+		swap_bits(block, IMAGE_BLOCK_SZ);
+		calc_crc = crc32(0, (uchar *)block, SIG_BLOCK_CRC_OFFS);
+		ptr_blk->crc = be32_to_cpu(calc_crc);
+		swap_bits(block, IMAGE_BLOCK_SZ);
+	}
+
+	return block_compare(state, block, vblock);
+}
+
+/**
+ * rsu_misc_image_block_init() - initialize state machine for processing blocks
+ * @state: current state machine state
+ *
+ * Function is called before processing images either for writing to flash or
+ * for comparison with verification data.
+ *
+ * Returns 0 on success, or -1 on error
+ */
+static int rsu_misc_image_block_init(struct rsu_image_state *state)
+{
+	rsu_log(RSU_DEBUG, "Resetting image block state machine\n");
+
+	state->no_sections = 1;
+	add_section(state, 0);
+	state->block_type = REGULAR_BLOCK;
+	state->absolute = 0;
+	state->offset = -IMAGE_BLOCK_SZ;
+
+	return 0;
+}
+
+/**
+ * rsu_misc_image_block_process() - process image blocks
+ *
+ * @state: current state machine state
+ * @block: pointer to current 4KB image block
+ * @vblock: pointer to current 4KB image verification block
+ * @info: rsu_slot_info structure for target slot
+ *
+ * Image blocks are processed either for updating before writing to flash
+ * (when vblock==NULL) or for comparison with verification data
+ * (when vblock!=NULL)
+ *
+ * Returns: 0 on success, or -ve on error
+ */
+static int rsu_misc_image_block_process(struct rsu_image_state *state,
+					void *block, void *vblock,
+					struct rsu_slot_info *info)
+{
+	u32 magic;
+	int ret;
+
+	state->offset += IMAGE_BLOCK_SZ;
+
+	if (find_section(state, state->offset))
+		state->block_type = SECTION_BLOCK;
+
+	switch (state->block_type) {
+	case SECTION_BLOCK:
+		magic = *(__u32 *)block;
+		if (magic == CMF_MAGIC) {
+			rsu_log(RSU_DEBUG, "Found CMF sect @0x%08x\n",
+				state->offset);
+			state->block_type = SIGNATURE_BLOCK;
+		} else {
+			state->block_type = REGULAR_BLOCK;
+		}
+
+		if (vblock)
+			return block_compare(state, block, vblock);
+		break;
+
+	case SIGNATURE_BLOCK:
+		rsu_log(RSU_DEBUG, "Found signature block @0x%08x\n",
+			state->offset);
+
+		ret = sig_block_process(state, block, info);
+		if (ret)
+			return ret;
+
+		state->block_type = REGULAR_BLOCK;
+
+		if (vblock)
+			return sig_block_compare(state, block, vblock, info);
+
+		ret = sig_block_adjust(state, block, info);
+		if (ret)
+			return ret;
+
+		break;
+
+	case REGULAR_BLOCK:
+		break;
+	}
+
+	if (vblock)
+		return block_compare(state, block, vblock);
+
+	return 0;
+}
+
+/**
+ * rsu_cb_program_common - callback to program flash
+ * @ll_intf: pointer to ll_intf
+ * @slot: slot number
+ * @callback: callback function pointer
+ * @rawdata: flag (raw data or not)
+ *
+ * Return 0 if success, or error code
+ */
+int rsu_cb_program_common(struct rsu_ll_intf *ll_intf, int slot,
+			  rsu_data_callback callback, int rawdata)
+{
+	int part_num;
+	int offset;
+	unsigned char buf[IMAGE_BLOCK_SZ];
+	unsigned char vbuf[IMAGE_BLOCK_SZ];
+	int cnt, c, done;
+	int x;
+	struct rsu_slot_info info;
+	struct rsu_image_state state;
+
+	if (!ll_intf)
+		return -EINTF;
+
+	if (slot < 0)
+		return -ESLOTNUM;
+
+	if (rsu_misc_writeprotected(slot)) {
+		rsu_log(RSU_ERR,
+			"Trying to program a write protected slot\n");
+		return -EWRPROT;
+	}
+
+	if (rsu_slot_get_info(slot, &info)) {
+		rsu_log(RSU_ERR, "Unable to read slot info\n");
+		return -ESLOTNUM;
+	}
+
+	part_num = rsu_misc_slot2part(ll_intf, slot);
+	if (part_num < 0)
+		return -ESLOTNUM;
+
+	if (ll_intf->priority.get(part_num) > 0) {
+		rsu_log(RSU_ERR,
+			"Trying to program a slot already in use\n");
+		return -EPROGRAM;
+	}
+
+	if (!callback)
+		return -EARGS;
+
+	offset = 0;
+	done = 0;
+
+	if (rsu_misc_image_block_init(&state))
+		return -EPROGRAM;
+
+	while (!done) {
+		cnt = 0;
+		while (cnt < IMAGE_BLOCK_SZ) {
+			c = callback(buf + cnt, IMAGE_BLOCK_SZ - cnt);
+			if (c == 0) {
+				done = 1;
+				break;
+			} else if (c < 0) {
+				return -ECALLBACK;
+			}
+			cnt += c;
+		}
+
+		if (cnt == 0)
+			break;
+
+		if (!rawdata)
+			if (rsu_misc_image_block_process(&state, buf, NULL,
+							 &info))
+				return -EPROGRAM;
+
+		if ((offset + cnt) > ll_intf->partition.size(part_num)) {
+			rsu_log(RSU_ERR,
+				"Trying to program too much data into slot\n");
+			return -ESIZE;
+		}
+
+		if (ll_intf->data.write(part_num, offset, cnt, buf))
+			return -ELOWLEVEL;
+
+		if (ll_intf->data.read(part_num, offset, cnt, vbuf))
+			return -ELOWLEVEL;
+
+		for (x = 0; x < cnt; x++)
+			if (vbuf[x] != buf[x]) {
+				rsu_log(RSU_DEBUG,
+					"Expect %02X, got %02X @ 0x%08X\n",
+					buf[x], vbuf[x], offset + x);
+				return -ECMP;
+			}
+
+		offset += cnt;
+	}
+
+	if (!rawdata && ll_intf->priority.add(part_num))
+		return -ELOWLEVEL;
+
+	return 0;
+}
+
+/**
+ * rsu_cb_verify_common() - callback for data verification
+ * @ll_intf: pointer to ll_intf
+ * @slot: slot number
+ * @callback: callback function pointer
+ * @rawdata: flag (raw data or not)
+ *
+ * Return 0 if success, or error code
+ */
+int rsu_cb_verify_common(struct rsu_ll_intf *ll_intf, int slot,
+			 rsu_data_callback callback, int rawdata)
+{
+	int part_num;
+	int offset;
+	unsigned char buf[IMAGE_BLOCK_SZ];
+	unsigned char vbuf[IMAGE_BLOCK_SZ];
+	int cnt, c, done;
+	int x;
+	struct rsu_slot_info info;
+	struct rsu_image_state state;
+
+	if (!ll_intf)
+		return -EINTF;
+
+	if (rsu_slot_get_info(slot, &info)) {
+		rsu_log(RSU_ERR, "Unable to read slot info\n");
+		return -ESLOTNUM;
+	}
+
+	part_num = rsu_misc_slot2part(ll_intf, slot);
+	if (part_num < 0)
+		return -ESLOTNUM;
+
+	if (!rawdata && ll_intf->priority.get(part_num) <= 0) {
+		rsu_log(RSU_ERR, "Trying to verify a slot not in use\n");
+		return -EERASE;
+	}
+
+	if (!callback)
+		return -EARGS;
+
+	offset = 0;
+	done = 0;
+
+	if (rsu_misc_image_block_init(&state))
+		return -ECMP;
+
+	while (!done) {
+		cnt = 0;
+		while (cnt < IMAGE_BLOCK_SZ) {
+			c = callback(buf + cnt, IMAGE_BLOCK_SZ - cnt);
+			if (c == 0) {
+				done = 1;
+				break;
+			} else if (c < 0) {
+				return -ECALLBACK;
+			}
+
+			cnt += c;
+		}
+
+		if (cnt == 0)
+			break;
+
+		if (ll_intf->data.read(part_num, offset, cnt, vbuf))
+			return -ELOWLEVEL;
+
+		if (!rawdata) {
+			if (rsu_misc_image_block_process(&state, buf, vbuf,
+							 &info))
+				return -ECMP;
+
+			offset += cnt;
+			continue;
+		}
+
+		for (x = 0; x < cnt; x++)
+			if (vbuf[x] != buf[x]) {
+				rsu_log(RSU_ERR,
+					"Expect %02X, got %02X @ 0x%08X\n",
+					buf[x], vbuf[x], offset + x);
+				return -ECMP;
+			}
+
+		offset += cnt;
+	}
+
+	return 0;
+}
+
+/*
+ * rsu_log() - display rsu log message
+ * @level: log level
+ * @format: log message format
+ */
+void rsu_log(const enum rsu_log_level level, const char *format, ...)
+{
+	va_list args;
+	char *log_level_env;
+	int log_level;
+	char printbuffer[LOG_BUF_SIZE];
+
+	log_level_env = env_get("rsu_log_level");
+
+	if (log_level_env) {
+		log_level = (int)simple_strtol(log_level_env, NULL, 0);
+
+		if (level >= log_level)
+			return;
+
+		va_start(args, format);
+		vscnprintf(printbuffer, sizeof(printbuffer), format, args);
+		va_end(args);
+		puts(printbuffer);
+	}
+}
diff --git a/arch/arm/mach-socfpga/rsu_s10.c b/arch/arm/mach-socfpga/rsu_s10.c
new file mode 100644
index 00000000000..fa3f2448031
--- /dev/null
+++ b/arch/arm/mach-socfpga/rsu_s10.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2018-2023 Intel Corporation
+ *
+ */
+
+#include <limits.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#ifdef CONFIG_DM_SPI_FLASH
+#include <dm/device.h>
+#endif
+#include <asm/arch/mailbox_s10.h>
+#include <asm/arch/rsu.h>
+#include <asm/arch/rsu_s10.h>
+#include <command.h>
+#include <rsu_console.h>
+#include <vsprintf.h>
+#include <spi.h>
+#include <spi_flash.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <asm/arch/rsu_flash_if.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define RSU_S10_SPT_SLOT_MAX 127
+
+/* Linux DTB label identifying the RSU-managed boot partition. */
+#define RSU_BOOT_PARTITION_LABEL "Boot and fpga data"
+
+static unsigned int rsu_s10_spt_entry_count(const struct socfpga_rsu_s10_spt *spt)
+{
+	if (spt->magic_number != RSU_S10_SPT_MAGIC_NUMBER)
+		return 0;
+	if (spt->entries > RSU_S10_SPT_SLOT_MAX)
+		return RSU_S10_SPT_SLOT_MAX;
+	return spt->entries;
+}
+
+static int rsu_print_status(void)
+{
+	struct rsu_status_info status_info;
+
+	if (mbox_rsu_status((u32 *)&status_info, sizeof(status_info) / 4)) {
+		puts("RSU: Firmware or flash content not supporting RSU\n");
+		return -EOPNOTSUPP;
+	}
+	puts("RSU: Remote System Update Status\n");
+	printf("Current Image\t: 0x%08llx\n", status_info.current_image);
+	printf("Last Fail Image\t: 0x%08llx\n", status_info.fail_image);
+	printf("State\t\t: 0x%08x\n", status_info.state);
+	printf("Version\t\t: 0x%08x\n", status_info.version);
+	printf("Error location\t: 0x%08x\n", status_info.error_location);
+	printf("Error details\t: 0x%08x\n", status_info.error_details);
+	if (RSU_VERSION_ACMF_VERSION(status_info.version) &&
+	    RSU_VERSION_DCMF_VERSION(status_info.version))
+		printf("Retry counter\t: 0x%08x\n", status_info.retry_counter);
+
+	return 0;
+}
+
+static void rsu_print_spt_slot(const struct socfpga_rsu_s10_spt *spt,
+			       unsigned int nentries)
+{
+	unsigned int i;
+
+	puts("RSU: Sub-partition table content\n");
+	for (i = 0; i < nentries; i++) {
+		printf("%16.16s\tOffset: 0x%08x%08x\tLength: 0x%08x\tFlag : 0x%08x\n",
+		       spt->spt_slot[i].name,
+		       spt->spt_slot[i].offset[1],
+		       spt->spt_slot[i].offset[0],
+		       spt->spt_slot[i].length,
+		       spt->spt_slot[i].flag);
+	}
+}
+
+static void rsu_print_cpb_slot(const struct socfpga_rsu_s10_cpb *cpb)
+{
+	int i, j = 1;
+	unsigned int nslots = cpb->nslots;
+
+	if (nslots > ARRAY_SIZE(cpb->pointer_slot))
+		nslots = ARRAY_SIZE(cpb->pointer_slot);
+
+	puts("RSU: CMF pointer block's image pointer list\n");
+	if (!nslots)
+		return;
+	for (i = (int)nslots - 1; i >= 0; i--) {
+		if (cpb->pointer_slot[i] != ~0ULL &&
+		    cpb->pointer_slot[i] != 0) {
+			printf("Priority %d Offset: 0x%016llx nslot: %d\n",
+			       j, cpb->pointer_slot[i], i);
+			j++;
+		}
+	}
+}
+
+static u32 rsu_spt_slot_find_cpb(const struct socfpga_rsu_s10_spt *spt,
+				 unsigned int nentries)
+{
+	unsigned int i;
+
+	for (i = 0; i < nentries; i++) {
+		if (strstr(spt->spt_slot[i].name, "CPB0"))
+			return spt->spt_slot[i].offset[0];
+	}
+	puts("RSU: Cannot find CPB0 entry in sub-partition table\n");
+	return 0;
+}
+
+static void rsu_s10_sanitize_spt_names(struct socfpga_rsu_s10_spt *spt,
+				       unsigned int nentries)
+{
+	unsigned int i;
+
+	for (i = 0; i < nentries; i++)
+		spt->spt_slot[i].name[MAX_PART_NAME_LENGTH - 1] = '\0';
+}
+
+/**
+ * rsu_spt_cpb_list_inner() - read mailbox SPT offsets, flash SPT/CPB, print
+ * @spt0_out: if non-NULL, set after successful mailbox read (for rsu dtb)
+ * @spt1_out: if non-NULL, set after successful mailbox read
+ */
+static int rsu_spt_cpb_list_inner(int argc, char * const argv[],
+				  u32 *spt0_out, u32 *spt1_out)
+{
+	u32 spt_offset[4];
+	u32 cpb_offset;
+	u32 spt0_off, spt1_off;
+	int err;
+#ifdef CONFIG_DM_SPI_FLASH
+	struct udevice *flash;
+#else
+	struct spi_flash *flash;
+#endif
+	struct socfpga_rsu_s10_spt spt = { 0 };
+	struct socfpga_rsu_s10_cpb cpb = { 0 };
+	unsigned int nentries;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	err = rsu_print_status();
+	if (err)
+		return err;
+
+	if (mbox_rsu_get_spt_offset(spt_offset, 4)) {
+		puts("RSU: Error from mbox_rsu_get_spt_offset\n");
+		return -ECOMM;
+	}
+	spt0_off = spt_offset[SPT0_INDEX];
+	spt1_off = spt_offset[SPT1_INDEX];
+
+	if (spt0_out)
+		*spt0_out = spt0_off;
+	if (spt1_out)
+		*spt1_out = spt1_off;
+
+	env_set_hex("rsu_sbt0", spt0_off);
+	env_set_hex("rsu_sbt1", spt1_off);
+	printf("RSU: Sub-partition table 0 offset 0x%08x\n", spt0_off);
+	printf("RSU: Sub-partition table 1 offset 0x%08x\n", spt1_off);
+
+	err = rsu_mtd_probe(CONFIG_SF_DEFAULT_BUS, CONFIG_SOCFPGA_RSU_SF_CS, &flash);
+	if (err) {
+		puts("RSU: SPI probe failed.\n");
+		return -ENODEV;
+	}
+
+	if (rsu_mtd_read(flash, spt0_off, sizeof(spt), &spt)) {
+		puts("RSU: rsu_mtd_read failed\n");
+		err = -EIO;
+		goto out;
+	}
+
+	if (spt.magic_number != RSU_S10_SPT_MAGIC_NUMBER) {
+		printf("RSU: Sub-partition table magic number not match 0x%08x\n",
+		       spt.magic_number);
+		err = -EFAULT;
+		goto out;
+	}
+
+	nentries = rsu_s10_spt_entry_count(&spt);
+	rsu_s10_sanitize_spt_names(&spt, nentries);
+	rsu_print_spt_slot(&spt, nentries);
+
+	cpb_offset = rsu_spt_slot_find_cpb(&spt, nentries);
+	if (!cpb_offset) {
+		err = -ENXIO;
+		goto out;
+	}
+	printf("RSU: CMF pointer block offset 0x%08x\n", cpb_offset);
+
+	if (rsu_mtd_read(flash, cpb_offset, sizeof(cpb), &cpb)) {
+		puts("RSU: rsu_mtd_read failed\n");
+		err = -EIO;
+		goto out;
+	}
+
+	if (cpb.magic_number != RSU_S10_CPB_MAGIC_NUMBER) {
+		printf("RSU: CMF pointer block magic number not match 0x%08x\n",
+		       cpb.magic_number);
+		err = -EFAULT;
+		goto out;
+	}
+
+	rsu_print_cpb_slot(&cpb);
+	err = 0;
+out:
+	/* Release the probed SPI flash; no-op under DM_SPI_FLASH. */
+	rsu_mtd_unclaim(flash);
+	return err;
+}
+
+int rsu_spt_cpb_list(int argc, char * const argv[])
+{
+	return rsu_spt_cpb_list_inner(argc, argv, NULL, NULL);
+}
+
+/*
+ * Strictly parse a hex u64 from argv[].
+ *
+ * U-Boot's simple_strtoull() silently accepts partial input ("12xyz")
+ * and wraps on overflow; both would let an unintended flash offset
+ * reach the SDM. Parse digit-by-digit so we can reject either case.
+ *
+ * Allows a single trailing '\n' for pasted-command compatibility.
+ */
+static int rsu_parse_hex_u64(const char *s, u64 *out)
+{
+	const char *start;
+	u64 result = 0;
+
+	if (!s || !*s || !out)
+		return -EINVAL;
+
+	if (s[0] == '0' && (s[1] == 'x' || s[1] == 'X'))
+		s += 2;
+
+	start = s;
+	while (*s) {
+		unsigned int digit;
+		char c = *s;
+
+		if (c >= '0' && c <= '9')
+			digit = c - '0';
+		else if (c >= 'a' && c <= 'f')
+			digit = c - 'a' + 10;
+		else if (c >= 'A' && c <= 'F')
+			digit = c - 'A' + 10;
+		else
+			break;
+
+		if (result > (ULLONG_MAX - digit) / 16)
+			return -ERANGE;
+
+		result = result * 16 + digit;
+		s++;
+	}
+
+	if (s == start)
+		return -EINVAL;
+	if (*s != '\0' && !(*s == '\n' && s[1] == '\0'))
+		return -EINVAL;
+
+	*out = result;
+	return 0;
+}
+
+int rsu_update(int argc, char * const argv[])
+{
+	u32 flash_offset[2];
+	u64 addr;
+	int ret;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_hex_u64(argv[1], &addr))
+		return CMD_RET_USAGE;
+
+	flash_offset[0] = lower_32_bits(addr);
+	flash_offset[1] = upper_32_bits(addr);
+
+	printf("RSU: RSU update to 0x%08x%08x\n",
+	       flash_offset[1], flash_offset[0]);
+	ret = mbox_rsu_update(flash_offset);
+	if (ret) {
+		printf("RSU: mbox_rsu_update failed (%d)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+	return CMD_RET_SUCCESS;
+}
+
+int rsu_dtb(int argc, char * const argv[])
+{
+	char flash0_string[100];
+	int nodeoffset, parentoffset, fdt_flash0_offset, len;
+	int child, fp_off;
+	u32 end;
+	const fdt32_t *val;
+	u32 reg[2];
+	u32 spt0_off = 0;
+	u32 spt1_off __always_unused = 0;
+	int err;
+	bool found = false;
+
+	/* Extracting RSU info from bitstream */
+	err = rsu_spt_cpb_list_inner(argc, argv, &spt0_off, &spt1_off);
+	/*
+	 * The shared inner helper returns CMD_RET_USAGE (positive) when
+	 * argv has extra tokens. Surface that to the command framework
+	 * directly instead of treating it as SPT/CPB corruption and
+	 * stomping on the live DTB.
+	 */
+	if (err == CMD_RET_USAGE)
+		return CMD_RET_USAGE;
+	if (err == -EOPNOTSUPP) {
+		return 0;
+	} else if ((err == -ECOMM) || (err == -ENODEV) || (err == -EIO)) {
+		return err;
+	} else if (err) {
+		/*
+		 * There was corruption occurred in SPT or CPB, doesn't
+		 * return error & let load process continue. So that Linux
+		 * can recovery the corrupted SPT or CPB.
+		 */
+		puts("Corrupted SPT or CPB, Linux will recovery them\n");
+	}
+
+	/* Retrieve the soc partition node from Linux DTB as start offset */
+	parentoffset = fdt_path_offset(working_fdt, "/soc");
+	if (parentoffset < 0) {
+		printf("DTB: /soc node not found. Check the dtb and fdt addr.\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * A board may carry more than one fixed-partitions node (e.g.
+	 * one for QSPI and one for NAND). Scan every fixed-partitions
+	 * node to find the RSU-managed boot partition. Primary pass
+	 * matches by label; fallback pass honours the legacy rsu-handle
+	 * phandle on the fixed-partitions parent (older Linux DTBs).
+	 */
+	fp_off = parentoffset;
+	while ((fp_off = fdt_node_offset_by_compatible(working_fdt, fp_off,
+						       "fixed-partitions")) >= 0) {
+		fdt_for_each_subnode(child, working_fdt, fp_off) {
+			const char *lbl;
+
+			lbl = fdt_getprop(working_fdt, child, "label", NULL);
+			if (lbl && !strcmp(lbl, RSU_BOOT_PARTITION_LABEL)) {
+				nodeoffset = child;
+				found = true;
+				break;
+			}
+		}
+		if (found)
+			break;
+	}
+
+	if (!found) {
+		fp_off = parentoffset;
+		while ((fp_off = fdt_node_offset_by_compatible(working_fdt,
+							       fp_off,
+							       "fixed-partitions")) >= 0) {
+			const __be32 *rsu_handle;
+			u32 alt_phandle = 0;
+
+			rsu_handle = fdt_getprop(working_fdt, fp_off,
+						 "rsu-handle", NULL);
+			if (rsu_handle)
+				alt_phandle = be32_to_cpup(rsu_handle);
+			if (!alt_phandle)
+				continue;
+
+			nodeoffset = fdt_node_offset_by_phandle(working_fdt,
+								alt_phandle);
+			if (nodeoffset < 0)
+				continue;
+
+			printf("DTB: boot partition found via rsu-handle (legacy DTB).\n");
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		printf("DTB: boot partition not found by label \"%s\" or rsu-handle.\n",
+		       RSU_BOOT_PARTITION_LABEL);
+		return -ENODEV;
+	}
+
+	/* Extract the flash0's reg from Linux DTB */
+	fdt_flash0_offset = fdt_get_path(working_fdt, nodeoffset, flash0_string,
+					 sizeof(flash0_string));
+	if (fdt_flash0_offset < 0) {
+		puts("DTB: qspi_boot alias node not found. Check your dts\n");
+		return -ENODEV;
+	}
+	printf("DTB: qspi_boot node at %s\n", flash0_string);
+
+	/* locate the boot partition */
+	nodeoffset = fdt_path_offset(working_fdt, flash0_string);
+	if (nodeoffset < 0) {
+		printf("DTB: %s node not found\n", flash0_string);
+		return -ENODEV;
+	}
+
+	/* determine initial end address of boot partition */
+	val = fdt_getprop(working_fdt, nodeoffset, "reg", &len);
+	if (!val) {
+		printf("DTB: %s.reg was not found\n", flash0_string);
+		return -ENODEV;
+	}
+	if (len != 2 * sizeof(fdt32_t)) {
+		printf("DTB: %s.reg has incorrect length\n", flash0_string);
+		return -ENODEV;
+	}
+	reg[0] = fdt32_to_cpu(val[0]);
+	reg[1] = fdt32_to_cpu(val[1]);
+	/*
+	 * Reject a DTB-supplied reg window whose start+size wraps u32.
+	 * Without this check, `end` underflows into a tiny value that
+	 * silently passes the spt0_off > end guard below, and the
+	 * subsequent (end - spt0_off) length poisons the boot partition.
+	 */
+	if (reg[0] > U32_MAX - reg[1]) {
+		printf("DTB: %s.reg start+size overflows u32 (0x%x + 0x%x)\n",
+		       flash0_string, reg[0], reg[1]);
+		return -ERANGE;
+	}
+	end = reg[0] + reg[1];
+
+	/* align to 64Kb flash sector size */
+	end = roundup(end, 64 * 1024);
+
+	/*
+	 * Guard reg[1]: spt0_off must lie within the boot partition, else
+	 * the u32 subtract below underflows into a multi-GiB length and
+	 * corrupts the DTB.
+	 */
+	if (spt0_off > end) {
+		printf("DTB: SPT0 offset 0x%x exceeds boot partition end 0x%x\n",
+		       spt0_off, end);
+		return -EINVAL;
+	}
+
+	/* assemble new reg value for boot partition */
+	reg[0] = cpu_to_fdt32(spt0_off);
+	reg[1] = cpu_to_fdt32(end  - spt0_off);
+
+	/* update back to Linux DTB */
+	return fdt_setprop(working_fdt, nodeoffset, "reg", reg, sizeof(reg));
+}
diff --git a/arch/arm/mach-socfpga/smc_rsu_s10.c b/arch/arm/mach-socfpga/smc_rsu_s10.c
new file mode 100644
index 00000000000..01bd18da560
--- /dev/null
+++ b/arch/arm/mach-socfpga/smc_rsu_s10.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Intel Corporation. All rights reserved
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include <errno.h>
+#include <asm/io.h>
+#include <asm/arch/mailbox_s10.h>
+#include <asm/arch/smc_s10.h>
+#include <asm/system.h>
+#include <linux/intel-smc.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define DCMF_STATUS_INVALID 0xFFFF
+
+u32 smc_rsu_update_address __secure_data;
+u32 smc_rsu_dcmf_version[4] __secure_data = {0, 0, 0, 0};
+u16 smc_rsu_dcmf_status[4] __secure_data = {DCMF_STATUS_INVALID,
+					    DCMF_STATUS_INVALID,
+					    DCMF_STATUS_INVALID,
+					    DCMF_STATUS_INVALID};
+static u32 smc_rsu_max_retry __secure_data;
+
+int smc_store_max_retry(u32 value)
+{
+	void *max_retry;
+
+	/*
+	 * Convert the address of smc_rsu_max_retry
+	 * to pre-relocation address.
+	 */
+	max_retry = (char *)__secure_start - CONFIG_ARMV8_SECURE_BASE +
+			(u64)secure_ram_addr(&smc_rsu_max_retry);
+
+	memcpy(max_retry, &value, sizeof(u32));
+
+	return 0;
+}
+
+static void __secure smc_socfpga_rsu_status_psci(unsigned long function_id)
+{
+	SMC_ALLOC_REG_MEM(r);
+	u64 rsu_status[5];
+
+	SMC_INIT_REG_MEM(r);
+
+	if (mbox_rsu_status_psci((u32 *)rsu_status, 9)) {
+		SMC_ASSIGN_REG_MEM(r, SMC_ARG0, INTEL_SIP_SMC_RSU_ERROR);
+		SMC_RET_REG_MEM(r);
+		return;
+	}
+
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG0, rsu_status[0]);
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG1, rsu_status[1]);
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG2, rsu_status[2]);
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG3, rsu_status[3]);
+
+	SMC_RET_REG_MEM(r);
+}
+
+static void __secure smc_socfpga_rsu_update_psci(unsigned long function_id,
+						 unsigned long update_address)
+{
+	SMC_ALLOC_REG_MEM(r);
+
+	SMC_INIT_REG_MEM(r);
+
+	smc_rsu_update_address = update_address;
+
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG0, INTEL_SIP_SMC_STATUS_OK);
+
+	SMC_RET_REG_MEM(r);
+}
+
+static void __secure smc_socfpga_rsu_notify_psci(unsigned long function_id,
+						 unsigned long execution_stage)
+{
+	SMC_ALLOC_REG_MEM(r);
+	SMC_INIT_REG_MEM(r);
+
+	if (mbox_hps_stage_notify_psci(execution_stage))
+		SMC_ASSIGN_REG_MEM(r, SMC_ARG0, INTEL_SIP_SMC_RSU_ERROR);
+	else
+		SMC_ASSIGN_REG_MEM(r, SMC_ARG0, INTEL_SIP_SMC_STATUS_OK);
+
+	SMC_RET_REG_MEM(r);
+}
+
+static void __secure smc_socfpga_rsu_retry_counter_psci(unsigned long function_id)
+{
+	SMC_ALLOC_REG_MEM(r);
+	u32 rsu_status[9];
+
+	SMC_INIT_REG_MEM(r);
+
+	if (mbox_rsu_status_psci((u32 *)rsu_status, sizeof(rsu_status) / 4)) {
+		SMC_ASSIGN_REG_MEM(r, SMC_ARG0, INTEL_SIP_SMC_RSU_ERROR);
+		SMC_RET_REG_MEM(r);
+		return;
+	}
+
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG0, INTEL_SIP_SMC_STATUS_OK);
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG1, rsu_status[8]);
+
+	SMC_RET_REG_MEM(r);
+}
+
+static void __secure smc_socfpga_rsu_dcmf_version_psci(unsigned long
+						       function_id)
+{
+	SMC_ALLOC_REG_MEM(r);
+	u64 resp0;
+	u64 resp1;
+
+	SMC_INIT_REG_MEM(r);
+
+	resp0 = smc_rsu_dcmf_version[1];
+	resp0 = (resp0 << 32) | (u64)smc_rsu_dcmf_version[0];
+
+	resp1 = smc_rsu_dcmf_version[3];
+	resp1 = (resp1 << 32) | (u64)smc_rsu_dcmf_version[2];
+
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG0, INTEL_SIP_SMC_STATUS_OK);
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG1, resp0);
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG2, resp1);
+
+	SMC_RET_REG_MEM(r);
+}
+
+static void __secure smc_socfpga_rsu_max_retry_psci(unsigned long
+						       function_id)
+{
+	SMC_ALLOC_REG_MEM(r);
+	u64 resp0;
+
+	SMC_INIT_REG_MEM(r);
+
+	resp0 = smc_rsu_max_retry;
+
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG0, INTEL_SIP_SMC_STATUS_OK);
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG1, resp0);
+
+	SMC_RET_REG_MEM(r);
+}
+
+static void __secure smc_socfpga_rsu_dcmf_status_psci(unsigned long function_id)
+{
+	SMC_ALLOC_REG_MEM(r);
+	u64 resp0;
+
+	SMC_INIT_REG_MEM(r);
+
+	if (smc_rsu_dcmf_status[0] == DCMF_STATUS_INVALID ||
+	    smc_rsu_dcmf_status[1] == DCMF_STATUS_INVALID ||
+	    smc_rsu_dcmf_status[2] == DCMF_STATUS_INVALID ||
+	    smc_rsu_dcmf_status[3] == DCMF_STATUS_INVALID) {
+		SMC_ASSIGN_REG_MEM(r, SMC_ARG0, INTEL_SIP_SMC_RSU_ERROR);
+		SMC_RET_REG_MEM(r);
+		return;
+	}
+
+	resp0 = smc_rsu_dcmf_status[3];
+	resp0 = (resp0 << 16) | (u64)smc_rsu_dcmf_status[2];
+	resp0 = (resp0 << 16) | (u64)smc_rsu_dcmf_status[1];
+	resp0 = (resp0 << 16) | (u64)smc_rsu_dcmf_status[0];
+
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG0, INTEL_SIP_SMC_STATUS_OK);
+	SMC_ASSIGN_REG_MEM(r, SMC_ARG1, resp0);
+
+	SMC_RET_REG_MEM(r);
+}
+
+DECLARE_SECURE_SVC(rsu_status_psci, INTEL_SIP_SMC_RSU_STATUS,
+		   smc_socfpga_rsu_status_psci);
+DECLARE_SECURE_SVC(rsu_update_psci, INTEL_SIP_SMC_RSU_UPDATE,
+		   smc_socfpga_rsu_update_psci);
+DECLARE_SECURE_SVC(rsu_notify_psci, INTEL_SIP_SMC_RSU_NOTIFY,
+		   smc_socfpga_rsu_notify_psci);
+DECLARE_SECURE_SVC(rsu_retry_counter_psci, INTEL_SIP_SMC_RSU_RETRY_COUNTER,
+		   smc_socfpga_rsu_retry_counter_psci);
+DECLARE_SECURE_SVC(rsu_dcmf_version_psci, INTEL_SIP_SMC_RSU_DCMF_VERSION,
+		   smc_socfpga_rsu_dcmf_version_psci);
+DECLARE_SECURE_SVC(rsu_max_retry_psci, INTEL_SIP_SMC_RSU_MAX_RETRY,
+		   smc_socfpga_rsu_max_retry_psci);
+DECLARE_SECURE_SVC(rsu_dcmf_status_psci, INTEL_SIP_SMC_RSU_DCMF_STATUS,
+		   smc_socfpga_rsu_dcmf_status_psci);
diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a19..67b035729f2 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1275,6 +1275,17 @@ config CMD_FPGAD
 	  fpga_get_reg() function. This functions similarly to the 'md'
 	  command.
 
+config CMD_SOCFPGA_RSU
+	bool "rsu - Altera SoC FPGA Remote System Update"
+	depends on ARCH_SOCFPGA_SOC64
+	depends on CADENCE_QSPI
+	select MISC
+	help
+	  Remote System Update (RSU) for Altera Stratix 10 / Agilex family
+	  SoCs: inspect flash images and the sub-partition table (SPT) /
+	  configuration pointer block (CPB), manage configuration slots,
+	  trigger firmware updates, and adjust the Linux DTB QSPI layout.
+
 config CMD_FUSE
 	bool "fuse - support for the fuse subssystem"
 	depends on !COMPILE_TEST
-- 
2.43.7

