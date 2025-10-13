Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ED6CCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 03:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6CA283857;
	Mon, 13 Oct 2025 05:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lO4/cwAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED39837E2; Mon, 13 Oct 2025 05:42:02 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBCC8384E
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 05:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUJDiHXQqdelZXcW18H4oU38UQ/kNvjH2aQxpf4aZMQt2NHXIKgemg2s/hqhGnB3eCMPLrLUXIFKryJ6sXCxM9NSWoooAJh87ZmpGLRpt7cj56Jwl7AUVUsQ/SKAknB0kLfV7nQOjfNSTJHghcxMbI4bjbpCSLzoBAq22v0ID9VHvPzvP0CSovNMI617rG0lmLwkK6bokjxhnbecw554LzUds0ifNm9niuBK7Okmiqqq/dwDgfNb1Gz0UXPNRgUFHcgqF/v40KHLOLpqx8aSl12J5qjK+QKW2pgBmqK/rqQg7KAMy4dQlshj3JkdHGbmthqpitN9wJi+DvhUZdQIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXfQFycQipbYyMx+cG73mh7O4XZBJ2OR7lUS5LYCs8g=;
 b=m/lFy0VoEI1Cpcl5TVm2vNNSgd1f/UMbGzvc70eIXV7aTkTQvyRBpOsMgs+qQCLIhNVVTCwlKvYzZuDnfvDD6cKvl+NPP6JoyxHClm4LGuqf17p/c2kyrhRET+G+ETvy948cEdFeFxZI02B0OOPBViL4iW7T/h6sTXXaNGEe61e0C/Stnf38dhqp/wbH2FoIrW5WqYYGjy/U7+hK6HcyuN4c5LGmfx/pJ6GuWc68oY//xjXbKLygBlKeWNG7VQHcVKGIBftBJRxsVrBZ3ksR27ufSYW6MQ1HesHGRyvX1Jvh5IxFJrgj5RO5klFm43Ck4pcUmO7HcTn8YafGuGOAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXfQFycQipbYyMx+cG73mh7O4XZBJ2OR7lUS5LYCs8g=;
 b=lO4/cwAupMVj/8x/YEAzYtujND22528x/yvJi0RBz/ENIXx+2QzdDQr6B543OOJJLD4DxbMY+kNKHkapkmLcmgBt1++eHLr82beNG67NvE8LHbPtOIloYSdO9o+AY4AyhIzRGq6TbOmFcRNWWFu3kXpk0KTTcomPUlzVy3E81CJxOlve+kPDldGrznAqVJUv+Sr5mzaMdYTZebPTLRhd/YSNKePq4eMGBcS6Z/tHEV1K8aQtRI5hhu8N++e1X8nAwDNLOp0aOENV3he05sK2dUgOllOQ161UuP915O0BteF6AQihA4stG/EKS/87kB5cW1LNPCm98E8xHAH3TFruRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 03:41:58 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 03:41:58 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH 3/3] imx95_evk: Add basic support for iMX95 15x15 EVK
Date: Mon, 13 Oct 2025 11:41:28 +0800
Message-Id: <20251013034128.1752157-4-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251013034128.1752157-1-ye.li@nxp.com>
References: <20251013034128.1752157-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: a9534aef-6ee5-4ea8-5a3e-08de0a0a763f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|42112799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fLO5+fF88gs17dyAz50Bj/LjSLZvkRsNY3YLJWR114BgJOuxeiTSnkkFPrs/?=
 =?us-ascii?Q?MSrH3NIRJ/d3+80c3ZU0hNeqVgJaWowYPJXZdrMNjoSyxkB0n2IInoTjF72k?=
 =?us-ascii?Q?o+Ea8OZC9eEoWfpC0KFjegcdscI8VS7g9yMDwuV9b/zqJZ5eBPb1E3OhVC0Z?=
 =?us-ascii?Q?GpBWvFQcZqcdUbejlqs5IixjUS8OWK3rk3mV88cHRxKunLUtBbekUI9q5GS/?=
 =?us-ascii?Q?56FMqYsDN2S9Hw5nHtEjs1sDsr8/6FUne6MHinXXMbCWGfUwrymE37hofKpO?=
 =?us-ascii?Q?9vjbPyi1BaayWAtQ9cw6bmxAP0lHeYvnbq7F/FC3qPRn4+DgUCsVQyJLiOyp?=
 =?us-ascii?Q?G7gzF8WD0VUsE3uQ/VcVy0PZtIzCvssloXet9jJb/OAzjgqKzBmzpQmny9+K?=
 =?us-ascii?Q?N9C/r6sGY4Ve4YdsuP3vyRiZ+ad0jSPyTfdxxXbHn9CvnoMV6cwAOj1LZ9Y/?=
 =?us-ascii?Q?YJiQDNTv7vv088033OE12oigZwBV9gIclz0zyYh9YcaqQt6Aln1gXyunk6ci?=
 =?us-ascii?Q?MXdV8PJgxyYkTNQcMlQEUU7BeH1hbFE7VjoelgelFIlKgySAkhN7x8+q8hVI?=
 =?us-ascii?Q?2jwDHcAXGQWUUyC4lKRxIaKSZkBiBxWMLILVjB3V2IUglUSm5ZSewI8H+nk2?=
 =?us-ascii?Q?chOjL2qgSCL8Rev06TNK2N9pAWMsJyulmCQdOPTMbsPEOcLuq+NDBPMEFkin?=
 =?us-ascii?Q?t09NhGkm+nW2LxPpFRL2PTBlSScC3VtDjDbWrvTv9Lk3/mbGy9dRbSHObn15?=
 =?us-ascii?Q?nQC8o3wNSASVn+m5KqeS89CUuS8vi3joH3ThE3T1nHfZ+pjTyHCauHdMmQIu?=
 =?us-ascii?Q?HR7tbY6KLqGPaYIzycaxAXggeWbGRfC8wf+N0FZrk3U2kkVvUQgR50/vwjG8?=
 =?us-ascii?Q?7Rgc5kwUvX5Wp30xN6GgROVaRUNG2I+JOvelsEAEI0ih4Vs8qr6tjTfvj6qB?=
 =?us-ascii?Q?OwyWESREpXABXM/YUIcyDXFO3sxBQfFG3tFFVcD5WJVSDV4jiBh1Mk6oCNiv?=
 =?us-ascii?Q?oelrkhzxh4gZGelXsEf3ABEGVIGvaEqEWOG5J6BVfX2h6o1UjvmnnzemDu26?=
 =?us-ascii?Q?i/joYuDBV3LQt09iyZvT5fypTK7M1ZoUUAI4/eJGSBY3HMB638RzEIDEH1RC?=
 =?us-ascii?Q?Q04OGCU1pJnVIxt2lUpMQvT4s0nGY6AsPR0mspLMLtTdDlWNZSG4GC8rCJHV?=
 =?us-ascii?Q?DDkghzLsFKpL2VEd4KMYOVii/EIebY3I5GHXUTyrDeg81GliL36+Qf9rgO1u?=
 =?us-ascii?Q?t3V1hy6guLMNKMO2DkVENw8BcXeJnmK9BXFbFOTqolZnGVgX5BGvr01cvW4e?=
 =?us-ascii?Q?eNoctcGglKkKpqvX+2Mz715BhjMJI+MAkEFrGcbm7QPSFCjd0jZjfikxPfff?=
 =?us-ascii?Q?UH2vBJbGIPYZfyINsz+iu3mBaCWcKQLway1Jxb0OkdR16DLgkVbnm+A0/goe?=
 =?us-ascii?Q?i+ViyB4qSe7+LOBK4JfYJLymrAPjepTShZDPqkpWf4tLS8EYtLfJRprfcPfc?=
 =?us-ascii?Q?QOZdV4JPN1Wn2b4nb0OvrIr4tp1tJm83iTvC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(42112799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mVzMsjP3P8zs45hnpzRbRVj1a0EVERZAGyDAD+slTidHUi0J9A5/iGy4Jt3R?=
 =?us-ascii?Q?hlqHkA1ia3WqQVPTw5iuEeWH/JgysPN0sAiREiGiQ52WiQ/QZzPudr8a2uJy?=
 =?us-ascii?Q?pLYzueab/ERYGvoAq68DxIpurCLxkeCCw5MlGBTcql4NwPpZD6EecczlhjDL?=
 =?us-ascii?Q?UAxA2aIA4tXy81dg69IevwtprEWuE97uJmrF1aMQKqcoenF/kx5mOJAZkCu5?=
 =?us-ascii?Q?M3EA67UsPdGiRaEgis6eaJ4q35R6ceAhGDp3c7C0J5nsm/PqFxHCnrfWkfA7?=
 =?us-ascii?Q?yB992HIUu6ag1cdVCcPFw+QBCYMISp1/s1kE4hrtgT1xjM6KBGhET6HvQzJd?=
 =?us-ascii?Q?HZRDhJz+KZYuFPwyYMX3KGBJKu+WzA4iW1JDwyK+jL3eUx6XtamXdArBa8nF?=
 =?us-ascii?Q?cniyf4qZBR2LWYCtraYKTNU3zssxv9CDRLA2u58FVCWKyFIkCUj1kuy1YxBV?=
 =?us-ascii?Q?lGvU60BoF6RLXOrHedCvx1DREQw0N0kja9m1VwdneF43tQISFcKnxZK2TAKB?=
 =?us-ascii?Q?4Ino/xaK9xMJTesa+UmrEj0+R64TE1n3MidRHs5ewHEg3ZNiR/dMeNazos+F?=
 =?us-ascii?Q?vJB/lj9Xi0+mz42p5QWIqdtD333kPnmDrlpsM0FnEis0L7A1eWqG7xAIU2Ix?=
 =?us-ascii?Q?cBdISJo4nH3s01qOglied2eKW8WKaHrVmKd4MtAOE7y8sWvEZmtmToBcVy/b?=
 =?us-ascii?Q?V+yQTWW2GfNW+ruKPCr9xtuycqgoXk6Z8d25SSTWgbwcMGIDAn6I9zCSLUow?=
 =?us-ascii?Q?vR6uHCgHX8fAnH0gYZcHaB3pm3Ril01/USsclPqsuGViG7cOH/Lr2BF9C5DK?=
 =?us-ascii?Q?WQxDTsbhR1EoCLUcJAa+a02RejluQ8I0IePIl1jxQuZBDAywUNWTTU0/l4/z?=
 =?us-ascii?Q?lItPuVRRGNk6xCIVcm/KGa8eEE6IDb7+2GH//6YiaWMzvQxCN/4Y2DT+sqCG?=
 =?us-ascii?Q?TTPxSkqgsQzLmPAW45bBpRIrxu5rkoMSCU6eso+RoQwwK5zG4L6pxh5kfQgW?=
 =?us-ascii?Q?v1g+QGHvGOWI624vYADphUNW8V5ZAcq/pIZDNyk73uuHqiY25quk5+cSLMDN?=
 =?us-ascii?Q?A/uqkGY5YCBcZHFFrzpwA3syWpJ4/ySQU8Pqd0b+9iDl4OrnsehxTD/zoXiV?=
 =?us-ascii?Q?O/mUZM0jHmsIT1eG+ojXRlhC3S2cMF3HYkKthyLkgvg5VXIWq2QZ9q5b7A3C?=
 =?us-ascii?Q?+o5+r3YXdwBFLqDi2ywV5SQaBKY80ydDol3NGG3YLeYOM4zo4NUDJRmKbjrZ?=
 =?us-ascii?Q?TZGYInnfp0jwvXJygb2p4MvGd34kHjutT3vtzWDzazPl9ca/0kY2KwUS4LB6?=
 =?us-ascii?Q?pkcN0PvpytcJDj38LJaqiPpfmpTpBCoMrlmtXHPnuBPW3A6TVJr1OMcWJFoS?=
 =?us-ascii?Q?mv71c7EFfQ5wzboJTC6NwTqR/Q9iIoOfEmElO1r6WgH36Yoi+wodfbRvqHSO?=
 =?us-ascii?Q?yism9rKT2CL2ulJhGNQP+kupkIl+jY+QFXHsxZehV/pJr3r6ukKUc9x0Cj/0?=
 =?us-ascii?Q?dAWC+YjUJknZ66WyBkRaPymcacsEZSHpLGetwcU7p7uErZoXn1CKnsaa7iuC?=
 =?us-ascii?Q?xaAKngGlgRTgurXdnnc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9534aef-6ee5-4ea8-5a3e-08de0a0a763f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 03:41:58.6325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKSrAzmDk9QuN5t0FHfV2cufLCinQAmzCejz1f+23xkAoMkbPGPribv3iHDFt79d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786
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

Add boot support and peripherals like eMMC/SD, UART, I2C, GPIO, ENETC0/1
and PCIE0/1 for iMX95 15x15 LPDDR4X EVK.
Updated doc for build instructions.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig    |   7 ++
 board/freescale/imx95_evk/Kconfig |   2 +-
 configs/imx95_15x15_evk_defconfig | 148 ++++++++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst       |  24 ++++-
 include/configs/imx95_evk.h       |   8 +-
 5 files changed, 182 insertions(+), 7 deletions(-)
 create mode 100644 configs/imx95_15x15_evk_defconfig

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 48f458fa55c..420a93755fd 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -106,6 +106,13 @@ config TARGET_IMX95_19X19_EVK
 	imply BOOTSTD_FULL
 	imply OF_UPSTREAM
 
+config TARGET_IMX95_15X15_EVK
+	bool "imx95_15x15_evk"
+	select IMX95
+	imply BOOTSTD_BOOTCOMMAND
+	imply BOOTSTD_FULL
+	imply OF_UPSTREAM
+
 config TARGET_IMX943_EVK
 	bool "imx943_evk"
 	select IMX94
diff --git a/board/freescale/imx95_evk/Kconfig b/board/freescale/imx95_evk/Kconfig
index f9a67353e5d..bf746e091de 100644
--- a/board/freescale/imx95_evk/Kconfig
+++ b/board/freescale/imx95_evk/Kconfig
@@ -1,4 +1,4 @@
-if TARGET_IMX95_19X19_EVK
+if TARGET_IMX95_19X19_EVK || TARGET_IMX95_15X15_EVK
 
 config SYS_BOARD
 	default "imx95_evk"
diff --git a/configs/imx95_15x15_evk_defconfig b/configs/imx95_15x15_evk_defconfig
new file mode 100644
index 00000000000..96b1d2a64af
--- /dev/null
+++ b/configs/imx95_15x15_evk_defconfig
@@ -0,0 +1,148 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SOURCE_FILE="imx95_evk"
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-15x15-evk"
+CONFIG_TARGET_IMX95_15X15_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-15x15-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_EARLY_INIT_F=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_CLK_IMX95_BLKCTRL=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PCIE_DW_IMX=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
index 709992e016d..b8c3f4bed50 100644
--- a/doc/board/nxp/imx95_evk.rst
+++ b/doc/board/nxp/imx95_evk.rst
@@ -48,6 +48,7 @@ Note: srctree is U-Boot source directory
    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
    $ sh firmware-imx-8.28-994fa14.bin --auto-accept
    $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4x*v202409.bin $(srctree)
 
 Get and Build OEI Images
 --------------------------------------
@@ -65,7 +66,7 @@ branch: master
    $ git clone -b master https://github.com/nxp-imx/imx-oei.git
    $ cd imx-oei
 
-i.MX95 A0 silicon version
+i.MX95 A0 silicon version on 19x19 LPDDR5 EVK
 
 .. code-block:: bash
 
@@ -75,13 +76,20 @@ i.MX95 A0 silicon version
    $ make board=mx95lp5 oei=tcm DEBUG=1 r=A0 all
    $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
 
-i.MX95 B0 silicon version
+i.MX95 B0 silicon version on 19x19 LPDDR5 EVK
 
 .. code-block:: bash
 
    $ make board=mx95lp5 oei=ddr DEBUG=1 r=B0 all
    $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
 
+i.MX95 B0 silicon version on 15x15 LPDDR4X EVK
+
+.. code-block:: bash
+
+   $ make board=mx95lp4x-15 oei=ddr DEBUG=1 r=B0 all
+   $ cp build/mx95lp4x-15/ddr/oei-m33-ddr.bin $(srctree)
+
 Get and Build System Manager Image
 --------------------------------------
 
@@ -120,7 +128,7 @@ branch: lf_v2.12
 Build the Bootloader Image
 --------------------------
 
-i.MX95 A0 silicon version
+i.MX95 A0 silicon version on 19x19 LPDDR5 EVK
 
 .. code-block:: bash
 
@@ -128,7 +136,7 @@ i.MX95 A0 silicon version
    $ make imx95_a0_19x19_evk_defconfig
    $ make
 
-i.MX95 B0 silicon version
+i.MX95 B0 silicon version on 19x19 LPDDR5 EVK
 
 .. code-block:: bash
 
@@ -136,6 +144,14 @@ i.MX95 B0 silicon version
    $ make imx95_19x19_evk_defconfig
    $ make
 
+i.MX95 B0 silicon version on 15x15 LPDDR4X EVK
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_15x15_evk_defconfig
+   $ make
+
 Copy imx-boot-imx95.bin to the MicroSD card:
 
 .. code-block:: bash
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
index 2eebdadc51d..3d22740b3f4 100644
--- a/include/configs/imx95_evk.h
+++ b/include/configs/imx95_evk.h
@@ -15,9 +15,13 @@
 
 #define CFG_SYS_SDRAM_BASE		0x90000000
 #define PHYS_SDRAM				0x90000000
-/* Totally 16GB */
+
 #define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
-#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
+#ifdef CONFIG_TARGET_IMX95_15X15_EVK
+#define PHYS_SDRAM_2_SIZE		0x180000000 /* 6GB (Totally 8GB) */
+#else
+#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB (Totally 16GB) */
+#endif
 
 #define WDOG_BASE_ADDR			WDG3_BASE_ADDR
 
-- 
2.37.1

