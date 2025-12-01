Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853F2D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 10:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2C03839D7;
	Mon,  1 Dec 2025 11:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dk6JWybb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EECEF83AA4; Mon,  1 Dec 2025 11:58:04 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB193830A0
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 11:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4f7jG+aiqApSDk3RB8EhPM9AihAWZzgVe1MQmOvtb/Ad7XRQpHJSM2ba3VPejprm3LsfJ3Dz8cCHveW3Lq0mSKN6TgfBOVR0AR/9IjzDBK7OpGGZXN3JU6yELzrvsWhf25+wAETzlai4/Up7ypYmi6tWrnrFC9osqIPDtzvcN1PA+1ULkf8Unk9u46qhZcnG+XfaQ3ygOdNfJPcsmRgVAlvvcyQf6ZHOzmYFcutwLk5CNodx88ePV7/c5dPuzuqo8GQsT93K9NdNNwFfC0LPCuy+IPJ7el9eyI6113w6yTaE1/ApkVNYlWedY0X0yw9zgNwzprS1NZ4/ql77DVS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv9nlrh9EpUy9bZXq+sJBU4Uqn4BjBHtxQjpHBDpAkU=;
 b=h2XDEXSGuaRuu9QYyhaU8M5zU+N0xppxpqGwt+jB7nz6s2YL/qMhT6U3Cy4SW3nVvw37C1JRcMm1f9svSbsFuaiLaPnCeP2CaoWPv4D0woFM+Lr/JgVJUbRmRMKXPm7X9m3TZb14TIcQpFpTGGIfSoZKpDH0ERpq1A/vF/5F7N1+DKd6C5n90UDOFCb+vu7hFMcwLs7q4EQHgXQcz4KMjzOmnuMvbBRjmfCAQ5sk68J7DmEbYXArthV57PyLwGeRVfoHa4ss8XYLrywxwypbPxysIW5PygwCxx4NRTkbh7Ts0rfGyr6VYvhmhUQUdZsXeEW6nneVHLkT3d2L/ymHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv9nlrh9EpUy9bZXq+sJBU4Uqn4BjBHtxQjpHBDpAkU=;
 b=Dk6JWybbMzIjik8uNtd4Dinrf0HWnC/aeOfHlkNat6g/qitRYN8vcFBrZtgRw0MqDqjC1h59YZ8vdMLwnZYnHOQahuuanGtISWBccvFy1RPAB2Vsl74WV3m1xqP3jTmhxXsJQ5TGQ0GCJftuvWRo9jqK/usipXFJwRCdWC228X/gsoJpi/qE2P0REyOBeI31bxemD0GKvSHToXh61zgUr4xyLmoys+AxMtnr+tt3a242Nhy1LoKb6FNlBjh0Dt/Kbdr0OddwTzESCPhJ2bU4AWRtn7EBSbaQ99a/qGS+QwbxEHWMqiP/6fq0cy4CFczG0QJXppla5lCESPfj5kpzIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB12112.eurprd04.prod.outlook.com (2603:10a6:10:641::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:58:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 10:58:00 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de,
	uboot-imx@nxp.com
Cc: sbabic@nabladev.com, festevam@gmail.com, trini@konsulko.com,
 peng.fan@nxp.com, alice.guo@nxp.com, sjg@chromium.org,
 davidzangcs@gmail.com
Subject: [PATCH v1 1/2] imx8ulp_evk: Move environment variables to .env file
Date: Mon,  1 Dec 2025 18:56:56 +0800
Message-ID: <20251201105657.1968244-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0250.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB12112:EE_
X-MS-Office365-Filtering-Correlation-Id: c779460c-71f9-458d-c9e1-08de30c87dec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ogHegKC9/kpTbxsmcPJZxtvNU79qbHGL1wPR5F0M3gByAQNQXJKhSWfyd7a?=
 =?us-ascii?Q?rmESw6AN79mZD3AG3g2p6tXAYjOjfD7MVrYTEFMXwdsPw1EQugwwlzp/zeJ6?=
 =?us-ascii?Q?LIEQ06TiwuO5LTi7nEEUPcFI+AWe2XfPyb4VqUCGmR607D+HN1ZqJm8FawWc?=
 =?us-ascii?Q?iGcoBNJF5jRy7nnLaKACKuggC+NH7spf6KxFfrMsUoOn44amS77DJFrywboD?=
 =?us-ascii?Q?muxHqppU/jQTXtA6Q7i8bb6Zfrm7ZG2sNdH7RT1bHe6Nha0M4h3y0dgqihUB?=
 =?us-ascii?Q?ahu5tLrzDi0xl5L02synkKLCvEjk+xtKqFNv2KKQY74KPGqnlARZUYhkaEVh?=
 =?us-ascii?Q?JklrbwiZGXSXepqtkO3jMP39QHhdn1tZu7Km/ajZDRL6tBEJf+R/33h7MlDC?=
 =?us-ascii?Q?LI+r8QuevpBYN2IAQzYBFBoOEjAOOa6+R+qlnOVc7n7Lb6+x8bWihZu0hnSp?=
 =?us-ascii?Q?6jZuiKDIgeqPJC6VvyHHKi0UrUl6QN2HaxUin8vcZvKvxbfnzDsgzgql/jpH?=
 =?us-ascii?Q?xpXsqR/jIqPkRcLVoN1oQLU4m1zX3HZKi5Pz5n39/uLthVXJ2I7YUlHHdokb?=
 =?us-ascii?Q?H4jteghQzdyRcXNJW5/iTrbW9kTEXeRvLMMzSopqX2BFw+W5Cj79AkQcZy40?=
 =?us-ascii?Q?NAM1n7md7eweMUu4k0QUCl0ASiZpVRs0+HSGq9/PuzAdgt6Tcs9quHRgUPLa?=
 =?us-ascii?Q?WcMBGnlgabX1LMl/1INlHvEJUnJVWZ3zCJadnpROEEIuZ56+u3NB0j/N5gL1?=
 =?us-ascii?Q?2qBEVDbY15V75EpQTS9vIldsU19dpreIP0RuXj0XsuDZ+k3usuj2OqFt+YYB?=
 =?us-ascii?Q?MAxW6+rsPN3TK77vL+tgCzVXSLuU8H3/yCE2sHdO47pFsBV12fb2pB48rZAK?=
 =?us-ascii?Q?xj5Tq7uavWh4y/+LeP7Fk7AwDDh94gUGS5t3Eu+A8tDJkDfp7tmxpwEzyg6x?=
 =?us-ascii?Q?ZGwUHecpKOCgZhhN940MJim9d8xOu3H0/0qyFB2ueq37yNo0EZNAeEPpoKqr?=
 =?us-ascii?Q?Mxlfm2Brjf60b88q9AWzVdTPXi32kLYIMj1ic5bcLfsVbwwmQZ4KdSq+mc77?=
 =?us-ascii?Q?iGOyXUw0LvE5LK7yo8ZbiHye2BmrAMd7fpALTNlDBI56vtoBsWtnbzGqbzFL?=
 =?us-ascii?Q?PK1Z8xS1+5WNN9TS+mxnojvEx0vzHJefE5SJvmdXneNqnFFHcDGDZN+mCm+H?=
 =?us-ascii?Q?+gjzhuJuiaiOcoz/gR4X5DEzw0Vc/W8FOnK2s2ccaktVGuvaLAwexCFi6QRw?=
 =?us-ascii?Q?XHB88IEvJBNefUiehCmjW6mL4pwy/tvkdKaR2djf8GJZUn4lgX8HLNvFc+Nn?=
 =?us-ascii?Q?/xwU9UCACGzTZyI1720dQ02xjsATlxJyge6c1odl36XGhf0zh8AF4K6Q8HyX?=
 =?us-ascii?Q?03hXJeYd7u2U7fzyLDOzrMWlEji2MFJq4+Yk4/lljn5alMrnjtDmrj/25wMj?=
 =?us-ascii?Q?ptcFlvZEhZWJffSvswt/JMCBW9Pow5fWSIxnE6yJWqOTN7wlIRszXan/LYJg?=
 =?us-ascii?Q?NxvCXdBlJa16fQ9fgu7I5fuzZxpKbOOc9kwO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BVDxinoaoB6jFJtp6lOja6b4yx4oJvBT6rwlQasywzHR7pI/xLSOaMuI5JZ1?=
 =?us-ascii?Q?l/gO6Jq8WE7S/A60ZWn3cNbtt2sUMFdCzdjtigYckQ61qV0dOJInbotgvb7+?=
 =?us-ascii?Q?r8HdRxi7Y8MjWCWlCCFiRs28/iqsvjglLT+rVV1oEdD3JoGn40p3vEmbcVsV?=
 =?us-ascii?Q?uPcX3PAhaWtyYg/66GfKY6FV8eTuJq61BIFXFfIKtvbhBOC51oRg6L4THCxu?=
 =?us-ascii?Q?2DielaPNg1wtHPqtCwdrGUTddF5v9g6CGYWJpVQEWyCZdIXLOHv6n7Z1DDxn?=
 =?us-ascii?Q?pLpI7bXsKNZ2s8dvT2ALfEE4BZVIBdb1YJKWUegSFj7cLeO5mCEexKyyd3K/?=
 =?us-ascii?Q?7PzWWZbsp6vZZ8OkxFfwKNXkRVzSroDiQQSkhVgmoxs4LZRMtG1r0WGPsKaA?=
 =?us-ascii?Q?fNne86bOe2DmPNZNNCuA2E//wlBzK6h1TyVnTvVfCFGZFbuVTJGMsoXlqj3M?=
 =?us-ascii?Q?wJuOv6tFA4URFpVguUgKq/R+CRhHzAsXAB5RD4K41/6JkS/9cC+G+jNOQiex?=
 =?us-ascii?Q?7mpOt2aQTZN3ClkHiP15lyBnc8iKVpoVgH43QGhgJhG3Q+zn35IbAm1G9HJU?=
 =?us-ascii?Q?eXuu/L1822U5tQFzMQEpPo7K45r2Q2LIgPmg3fwGOziKQxb0KxdxLX6x/laU?=
 =?us-ascii?Q?iiWLVEA5CgCcz2sbbLSj/t6Awo/CEGiywpkx5RMDo9Z9iQK9AosrtSQDWho+?=
 =?us-ascii?Q?TKQJaeP2je7w3npiOqGYgGgFrul13PMci64I7IPwxWYACKR7rPwxeu5/d60H?=
 =?us-ascii?Q?CrhmtfT2D8rboTLe7k2RXAN72BM3uadxR3obT34k3a5m1OtG3qvBCzbmQsti?=
 =?us-ascii?Q?F9QxSbgY/UJDYidFGpZiOzm/iDRel5JjKQnx0Q1r5K8GeKpGoH8I/m1yd7ZI?=
 =?us-ascii?Q?/jfkjyQF6da2oLqQUyhABC/t4/bAGrgYfP3UaDpVymKUwAN0lksXs6P5YLRi?=
 =?us-ascii?Q?jxYs0ks/vyuLt39SASeIQ6bJQZAxJ/eDF5gRqTIVRZNKDitHhiNUfevGKmfC?=
 =?us-ascii?Q?VroAiIcW3ql4Dn1ag+tmZU/X11+k4m8BfvOzj+WhyrBKIvjl3ba4Bv9Lp/dZ?=
 =?us-ascii?Q?vjbTo9+XdkPbkJ5kbkGtszwrggrSnis3YHlYGlvFFRWZ/oT2x3nAK4QLKmsj?=
 =?us-ascii?Q?z2Tx8vxFu0CUfg+DYXe9onqJoJQTauIQhIFQhZdeEMnshJ+3p62pRMk71a9Q?=
 =?us-ascii?Q?9ZBx+UcT7aWZgVaePMh9M3I83SyDz2EOCZd2oy0y7+LELVvxVyTQZkr4xWd2?=
 =?us-ascii?Q?XBPOwwBzUsiL77+32hMloKtOUubt0WeS6C+vb2R5IuvDI9uHc5j/BZJ0j7j6?=
 =?us-ascii?Q?6EvfPCr1e94qnAx1FjN071ZVjpQTe8Ybp7ERyVE/dEtyqx4NB+qUGfj/FC7N?=
 =?us-ascii?Q?z1YluOy3Cc+mqRQ7KjcLdcLQNE9Q8MmNDC0ly2xg/MjGpNhi0laJonuDiXnc?=
 =?us-ascii?Q?zdmQxA0LcdjIuvLGo1XMr7+F1TMchVUY+O1T8neN0SU0s9OFs1LNNhGUIzPD?=
 =?us-ascii?Q?HZmw7vQ1PM5fUn9b3Hoz38hN5+BS0773rCACeA/szFX+aqaeZiq4o2V2VWjW?=
 =?us-ascii?Q?L7i305wllxtl+w3KToMMGs590KTg8sdDor4Ox2Au?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c779460c-71f9-458d-c9e1-08de30c87dec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:58:00.0721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHme8UKhlavNUx1bdYwWkxJAoaFbkh6d+thNiwPms3L+SsdlDwOA53VPfPGBE1Sb47TE5YXEy2nEbvizygUINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12112
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

Add board-specific environment variables to imx8ulp_evk.env for better
maintainability.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx8ulp/Kconfig           |  1 +
 board/freescale/imx8ulp_evk/imx8ulp_evk.env | 99 +++++++++++++++++++++
 configs/imx8ulp_evk_defconfig               |  5 +-
 include/configs/imx8ulp_evk.h               | 24 -----
 4 files changed, 102 insertions(+), 27 deletions(-)
 create mode 100644 board/freescale/imx8ulp_evk/imx8ulp_evk.env

diff --git a/arch/arm/mach-imx/imx8ulp/Kconfig b/arch/arm/mach-imx/imx8ulp/Kconfig
index fbca241e106..e96e34651ce 100644
--- a/arch/arm/mach-imx/imx8ulp/Kconfig
+++ b/arch/arm/mach-imx/imx8ulp/Kconfig
@@ -27,6 +27,7 @@ config TARGET_IMX8ULP_EVK
 	select IMX8ULP
 	select SUPPORT_SPL
 	select IMX8ULP_DRAM
+	imply BOOTSTD_FULL
 
 endchoice
 
diff --git a/board/freescale/imx8ulp_evk/imx8ulp_evk.env b/board/freescale/imx8ulp_evk/imx8ulp_evk.env
new file mode 100644
index 00000000000..bfa43eedf84
--- /dev/null
+++ b/board/freescale/imx8ulp_evk/imx8ulp_evk.env
@@ -0,0 +1,99 @@
+#ifdef CONFIG_AHAB_BOOT
+sec_boot=yes
+#else
+sec_boot=no
+#endif
+
+jh_clk=
+jh_mmcboot=setenv jh_clk kvm.enable_virt_at_load=false clk_ignore_unused mem=896MB; run loadimage; run mmcboot
+jh_netboot=setenv jh_clk kvm.enable_virt_at_load=false clk_ignore_unused mem=896MB; run netboot
+
+
+initrd_addr=0x83800000
+initrd_high=0xffffffffffffffff
+scriptaddr=0x83500000
+splashimage=0x90000000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+fdtoverlay_addr_r=0x83040000
+fdt_addr_r=0x83000000
+fdt_addr=0x83000000
+fdt_high=0xffffffffffffffff
+cntr_addr=0x98000000
+emmc_dev=0
+sd_dev=2
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+image=Image
+cntr_file=os_cntr_signed.bin
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+console=ttyLP1,115200 earlycon
+bootm_size=0x10000000
+boot_fit=no
+mmcroot=/dev/mmcblk0p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} console=${console} root=${mmcroot}
+netargs=setenv bootargs ${jh_clk} console=${console}
+        root=/dev/nfs
+        ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+bootscript=echo Running bootscript from mmc ...; source
+auth_os=booti ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r}
+mmcboot=echo Booting from mmc ...;
+        run mmcargs;
+        if test ${sec_boot} = yes; then
+                run auth_os;
+        else
+            if test ${boot_fit} = yes || test ${boot_fit} = try; then
+                bootm ${loadaddr};
+            else
+                if run loadfdt loadimage; then
+                    run boot_os;
+                else
+                    echo WARN: Cannot load the fdt and image;
+                fi;
+            fi;
+        fi;
+netboot=echo Booting from net ...;
+        run netargs;
+        if test ${ip_dyn} = yes; then
+            setenv get_cmd dhcp;
+        else
+            setenv get_cmd tftp;
+        fi;
+        if test ${sec_boot} = yes; then
+            ${get_cmd} ${cntr_addr} ${cntr_file};
+            run auth_os;
+        else
+            ${get_cmd} ${loadaddr} ${image};
+            if test ${boot_fit} = yes || test ${boot_fit} = try; then
+                bootm ${loadaddr};
+            else
+                if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+                    run boot_os;
+                else
+                    echo WARN: Cannot load the DT;
+                fi;
+            fi;
+        fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+            mmc dev ${mmcdev}; if mmc rescan; then
+            if run loadbootscript; then
+                run bootscript;
+            else
+                if test ${sec_boot} = yes; then
+                    if run loadcntr; then
+                        run mmcboot;
+                    else run netboot;
+                    fi;
+                else
+                    if run loadimage; then
+                        run mmcboot;
+                    else run netboot;
+                    fi;
+                fi;
+            fi;
+        fi;
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index e750b3d9ae0..f8a87dde5cf 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -27,9 +27,8 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=0
-CONFIG_BOOTCOMMAND="run distro_bootcmd;run bsp_bootcmd"
-CONFIG_DEFAULT_FDT_FILE="imx8ulp-evk"
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx8ulp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2068
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index 9308f5234f4..edfd6f70815 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -21,30 +21,6 @@
 #define CFG_FEC_MXC_PHYADDR		1
 #endif
 
-#ifdef CONFIG_DISTRO_DEFAULTS
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 0)
-
-#include <config_distro_bootcmd.h>
-#else
-#define BOOTENV
-#endif
-
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"console=ttyLP1,115200 earlycon\0" \
-	"fdt_addr_r=0x83000000\0"			\
-	"boot_fit=no\0" \
-	"fdtfile=imx8ulp-evk.dtb\0" \
-	"initrd_addr=0x83800000\0"		\
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk2p2 rootwait rw\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR	0x80000000
-- 
2.43.0

