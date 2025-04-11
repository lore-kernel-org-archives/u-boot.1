Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779E0C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE2383F2F;
	Fri, 11 Apr 2025 10:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VifhLkAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D5C83F32; Fri, 11 Apr 2025 10:09:35 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F9FB83EDC
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSKFQpiFZvOydTWvYcSVTNSm4i0WjuAQubj1Uu7M+/rXTdjSPsJaN1estPa3Wmm/mvLBy3SsxTiMgcY7l0omZC6ddjsAalldimgdOUVjgcW8RbxLxtvPFZsPSM42KMf6b1SFUve6RRCud6myGKPDjN128S9QMbXvifEQe3rKO26SaSHoD9iBgRuy6oH5wP0z2Atz86GrU/RHfWgVA7accG9SbaA/u29uCkVu6zpPtEa8oPZO+giW5TuiYompNu2eTssHHpbrITDCGZaHANLHfwEMdghBsiGXCv/fRt9F9Ill1gjVOJqlhFCl1aXhnGdnPQwr7YMqt2XNJsxdrIWF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHb/86+9VZV3n+TcaEELEwzO6xwp5978HGOiL32gKaY=;
 b=u3VDJ5VI12/uZjQxGLdP1XzLnq88loTwkL2B4S46Z69Jbf6cbrrnqNz70aSEQM3cHw4kUA81PY+fUIOJOFo+FaBbyELQplJjt5c85WV2AXo4CChLoQbSHywND/6hkrcdxV4N3q8AeKporCAiwhGCYhgPFwEWz5sDQg4r3wYDzbWiJCYhSUD9BY1/gJAi7cWdt7cqBfHSg/foHuasveoZALcBNGrmmdEjuFFK2OpJ5C9OrKqiL/9jDvTMm5oHbuwlFeZ8IwlZpUkYfmwDMNjKmIMXeylAAVmha5bJ9mHtRsd7pMobplqA6grhXkLCEZ2Pq5Y8DKHvVRwhRQjUkoxEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHb/86+9VZV3n+TcaEELEwzO6xwp5978HGOiL32gKaY=;
 b=VifhLkAE+SkqffGM+Ut61yTU0JVY8iDQKhzwK6kKBpLZLSrIEF8dlPH7yGAhmR4LwzZ7mLHQOiM36zCU6pbBdI0vRZQtBxYHA1wHkAptoqpN0g1dvMGArvW1Iq7VyL15+yhUjWoBHPE7Kl12vThB4k6xGBPbLBCze0pZLNvnZshcISiVpBHc0LZ72lhHliGvLBuI5kQChxnUs2ot1mIMJjU+gRlkp0qQhdcwciPO3Bpo5dg+GEWEfDJzw5d0SKhsNmG1wWSj61Q0DdtPUd4j1PBQmCq4foNnLW6BVkgL0Vbg4LOimXh1oENreYzuY+R9hKAspdKgA5LDW6Q3l3TbDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:09:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:09:31 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 02/20] pinctrl: nxp: add a pin controller driver based on
 SCMI pin control protocol
Date: Fri, 11 Apr 2025 16:06:45 +0800
Message-ID: <20250411080707.602371-3-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 035386c6-25c6-4df8-a439-08dd78d03007
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5HVw/N3Efz9s6eeFL85qbEFUCTl2rZ0j7ZcW/Ap/c2uwieeP5fmLLjEkNVFc?=
 =?us-ascii?Q?/NzACdrH713fQyZ+zETN4nHGHER2u64MGxQBXzKydFqNo+wueJXqgidV+Ly0?=
 =?us-ascii?Q?mh05f9wilF9RZ2wdlgluoj+kcg1tuxKBqCIroSxi15jJ7iikiKCrdKn0zrGV?=
 =?us-ascii?Q?CCiI2r8r7ptljXd1b13nlgrhZ+f6ytSS2ZTSGyJvxKMl+4T9KgCT6vZc+sZ9?=
 =?us-ascii?Q?mU/3J2sw7Hw3emowGDlExOXneepCIN8FOMn+qg37+3/lfmx89Xsohvn83/QU?=
 =?us-ascii?Q?IVmfSXVYMENy7KdR+r4CDZ3K8VO0IjK8KAeVO50FWP8Tb7o34Rh3e56H+Sh6?=
 =?us-ascii?Q?v8vrw+iwmefDlo3I4eomL48yCR90JT1CB0OYjP8qz9xJInt0a293E7cclc9W?=
 =?us-ascii?Q?aufAVx0WudAu+p/HflWdw64OkJWNCl17/Y2WOZ4WMRhHMgAjC5xH1mVIMji+?=
 =?us-ascii?Q?4YeuXRvhRwGfjP+TWkxvp30V4qIIHJtxJE2W3lkjjo+XxvDfZ1B+MddPrwB9?=
 =?us-ascii?Q?SxtfgMiVbdsnaz9VEkW6Qv+Os8UOgLYYuDgT84iar/2vHN98/tZcdRZyb/M9?=
 =?us-ascii?Q?TqbK6i1jTC+XyHEqop9pRz5wtP2IG0dn7pAQansRC36QAzTlGGPhTx9lPnmT?=
 =?us-ascii?Q?K++EL7YnfjFn1IvcLSYXZxJC/+1cuifGdWu8atYhglQX1+48iW7kXj02Gg1+?=
 =?us-ascii?Q?MK38rJTvAWUQDwQtMg8/zWow+AdOAW9+IT+cj/LxcOetxPcww4Ff9YygsxUX?=
 =?us-ascii?Q?ZNbfdhnGGgb8HincGOVPDEEtc3qkD8JohP6X12G7VQD5Fb9Uanm6nRdHlDA+?=
 =?us-ascii?Q?RSCL5/LV5hh4qFCYEXOeTbaHMr1TVGHMjUz9b9t7k4Imwc9fa1KWSB65XJf0?=
 =?us-ascii?Q?pkkF7HCbXgdsgZEWB9UkBanSjv9lDQOWckZ4SWb68GiHbWNQzgjuJvnRwNip?=
 =?us-ascii?Q?byGHt77zV30KjIJHbxqSnEAyroPUNDCf9tXDa1SQKdBeKTgEzzeP1EwKCZ/K?=
 =?us-ascii?Q?XQIeWY1rtK/gscMmL2og923ZKTLXTOoQRyI28lUQrUYzrS167XQuNvDvNwOm?=
 =?us-ascii?Q?KnHpVANc/OfDxOsOJfmK9UDVKYweHq7ufuBm2iotcEFSVvGhuWXNNyOaC/H7?=
 =?us-ascii?Q?WD1Z+JoxUCgCv07j+eaKj7px7BmvaBZQhwcAgI9htmMzFHtQvP7kWF9IN3cB?=
 =?us-ascii?Q?tUcRAa/F7HMcu4OGMOR6n+pXDAGEh08uhXhrKnufb8BpWvWCxc0JmD4wxu7M?=
 =?us-ascii?Q?m5lsiZ9cQmv738UeenKRP7YKevzxqUyPt/4lv42BCjzE15vlExWcSrn/+wu3?=
 =?us-ascii?Q?lh4yVaLZYgPlcXEQNU50k+KR/X6ka0gQFvS/+UKjpJH94rMXMnFnH6EX7rdt?=
 =?us-ascii?Q?IehS7fWyDQvLtXZ7ok8gbFxpKMNCnysW8foh8jsLEeU8wAC2Y5Xnta7GEIba?=
 =?us-ascii?Q?6gLCc5/tQ3rvfzw8LP2JpYtG/4muoGjh/L+h0rzHWyPfqrknr+mfew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eyhiJY8HyzYkxfC5HLEb6njLDI1EhwNBEylTs6Vtq9pY/JfeREfcReIL0S5B?=
 =?us-ascii?Q?1Mk+iojm2eQSM06pK4vEeJwBKy8CDN3bVbODC+mL1ACAClQ3JnQU3+nM64Uj?=
 =?us-ascii?Q?yjmMr97BZbVzuAsBO6XXf1A+W5ssk0XwQMJKcSDo1H07mAcDCIRN+hb2eWnM?=
 =?us-ascii?Q?5y9mqjDGjI2KFtHLdglrgUGQ5IBXDgG3p4CRCxjWv3u8JZkUOnRLl5H/Cp2e?=
 =?us-ascii?Q?a9wElwCXFSFn65OF8ndnROWiE/k3zVc2AJjvyzRg8Fy7Jqvm/7siZrcvN0js?=
 =?us-ascii?Q?V5/pZl/PgbnDOPlOMveKG+IV9U6CDIFWbB5B45guoKOacPcdEPKbbTtNQ9np?=
 =?us-ascii?Q?mE+Roi/N01syzC5Kv5Gm+1Vkz4VC/YrPe3lmlMGWx+UVh1p6zvvJGIX+keD5?=
 =?us-ascii?Q?r1LzeXCMv40vIOlr2pVZnFruKC+bHb3RxZ1W0tNub803rcxyvLBt99+TDI5z?=
 =?us-ascii?Q?Sa9qt/VIBgaRHBMvVAlvGBZOtVVYMw3GmznEbvI12Z99n7H7FAR+1TbppNxE?=
 =?us-ascii?Q?DHQFvsMU39BIMUSb7+YMpY4aJD6p0ZQokHTWLrrSL65y4AEFu3jOHHliEmQH?=
 =?us-ascii?Q?AKn6pW0T2pjGNfOMDcsgqZmwsR4A6et0PCTFJkbb6aEqRduOuxC9uBsY3aQk?=
 =?us-ascii?Q?RaTtw8b48T4PsWCtUWRVNmqmqTy0oOifnUCWiYJdX4n7CalQaOgk5kb9CVpT?=
 =?us-ascii?Q?7yGC3OYoJbBWOOB3X5cbOvNRNMpHe26eYtrFsZvFPl2xSo3rnI/7gRmWE7FW?=
 =?us-ascii?Q?nOLzaBmyH90fUUkmUdF1fSX1MHWC/H2pDPzkyKI3JykXO1LwXWOgZh483FGL?=
 =?us-ascii?Q?sv4v0BPINW8ho2emjOjjiDyAdu8g2HVzbx9LWO0zOF1qfxAqUULO1AhrNgq1?=
 =?us-ascii?Q?VmZE0ydjYHLARt3gIZJaiUldZAkUX1KF9kLqCLJi7kQ7Mw326hC4L7Zdjm9I?=
 =?us-ascii?Q?9y+Y6NVrkuVJ/O/Sh3qhPtYBL1BsYeSwOOJpkL41jIDLfCf577juOuehiJE+?=
 =?us-ascii?Q?ZWW3nODM8I84GjN4X6NHv4prfyd6n65ZYY8y6q/zo/nCXKmvZuFvB6O674Or?=
 =?us-ascii?Q?0X7eqr4IghdVZ+MuBROndZSfBODhBP0n72KWRzDcsA5xt8dbbpeRGRLIdrsb?=
 =?us-ascii?Q?gtzoJHwL9WZJuwCpzhNzApfk8XIGyLT4DjvSEYNcSyWTkpG740ggqoxTGrmy?=
 =?us-ascii?Q?k6515P9Tr6F5B4n9ltl1hxSY/VOkTVL7T5zmVX43D8M1Eoy8fUMy+79S/4pX?=
 =?us-ascii?Q?CGsBeyEHS1hVAaeReJZh5e5H2jY5m6j7CM4IJb81FjKQRV2MZklntiPtYTYa?=
 =?us-ascii?Q?cyVRYflsexHnZrEG0eQkuhepXBR23ndXqfX2/e/UBYMbYypbmUlSMCDsrx+e?=
 =?us-ascii?Q?zR6b37iI1W5IZf1p4ITqS+LSn1FoSTgrSeGffvZnsre40JMn58Mdb9+BTqoY?=
 =?us-ascii?Q?fNvmzmtRxH3KcEcvnYCAALBIpm+RPqkb9bAgxqAdmHEL3RJu9aFLotbjxltV?=
 =?us-ascii?Q?vw/eBlb7FecGTDSMtfGmwPBKs+KsmTwK7wq82Zp/1M/nUPb+s5NE6O/enBTM?=
 =?us-ascii?Q?m9ZnCebAf83yYlq5/9O7z9I2GhM62UTxYHVbXi+0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035386c6-25c6-4df8-a439-08dd78d03007
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:09:31.6006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbLHQFAU2qAvW7256mp4/JR9hBXxQxIPUxHniQnOLyf1zLOvV7mXjAaimQ1TjkApViqNRrzNisFcrLmtcSCLMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
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

From: Alice Guo <alice.guo@nxp.com>

This patch provides a pinctrl driver based on SCMI pin control protocol.
Currently, only the PINCTRL_CONFIG_SET command is implemented.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/pinctrl/nxp/Kconfig            |  13 +++
 drivers/pinctrl/nxp/Makefile           |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 154 +++++++++++++++++++++++++
 include/scmi_protocols.h               |  36 ++++++
 4 files changed, 204 insertions(+)
 create mode 100644 drivers/pinctrl/nxp/pinctrl-imx-scmi.c

diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index d13c5f2a6d5..84d9a3641ff 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -139,6 +139,19 @@ config PINCTRL_IMXRT
 	  only parses the 'fsl,pins' property and configure related
 	  registers.
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
+	  Say Y here to enable the imx pinctrl SCMI driver
+
 config PINCTRL_VYBRID
 	bool "Vybrid (vf610) pinctrl driver"
 	depends on ARCH_VF610 && PINCTRL_FULL
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index 44e37c631e5..7d861ae52c1 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_PINCTRL_IMX93)		+= pinctrl-imx93.o
 obj-$(CONFIG_PINCTRL_MXS)		+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_VYBRID)		+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_IMXRT)		+= pinctrl-imxrt.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-imx-scmi.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
new file mode 100644
index 00000000000..20ea55d40ae
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+
+#include "pinctrl-imx.h"
+
+#define DAISY_OFFSET_IMX95      0x408
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+struct imx_scmi_pinctrl_priv {
+	u16		daisy_offset;
+};
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret, num_cfgs = 0;
+	struct scmi_msg msg;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+
+	if (mux_ofs) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+
+	if (config_val) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+
+	if (input_ofs) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs -  priv->daisy_offset) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+			  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret || out.status) {
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n",
+			mux_ofs / 4, input_ofs / 4, out.status, ret);
+	}
+
+	return ret;
+}
+
+static int imx_pinctrl_set_state_scmi(struct udevice *dev, struct udevice *config)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	u32 *pin_data;
+	int i, j = 0;
+	int npins;
+	int ret;
+
+	ret = imx_pinctrl_set_state_common(dev, config, FSL_PIN_SIZE,
+					   &pin_data, &npins);
+	if (ret)
+		return ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM) {
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+		}
+	}
+
+	return ret;
+}
+
+static const struct pinctrl_ops imx_scmi_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state_scmi,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+
+	if (IS_ENABLED(CONFIG_IMX95))
+		priv->daisy_offset = DAISY_OFFSET_IMX95;
+	else
+		return -EINVAL;
+
+	return devm_scmi_of_get_channel(dev);
+}
+
+static int imx_scmi_pinctrl_bind(struct udevice *dev)
+{
+	if (IS_ENABLED(CONFIG_IMX95))
+		return 0;
+
+	return -ENODEV;
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.bind = imx_scmi_pinctrl_bind,
+	.probe = imx_scmi_pinctrl_probe,
+	.priv_auto = sizeof(struct imx_scmi_pinctrl_priv),
+	.ops = &imx_scmi_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36b..279ebbad440 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -1005,4 +1006,39 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @identifier:		Identifier for the pin or group.
+ * @function_id:	Identifier for the function selected to be enabled
+ * 			for the selected pin or group. This field is set to
+ * 			0xFFFFFFFF if no function should be enabled by the
+ * 			pin or group.
+ * @attributes:		Bits[31:11] Reserved, must be zero.
+ * 			Bit[10] Function valid.
+ * 			Bits[9:2] Number of configurations to set.
+ * 			Bits[1:0] Selector: Whether the identifier field
+ * 				  refers to a pin or a group.
+ * @configs:	Array of configurations.
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */
-- 
2.43.0

