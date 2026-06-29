Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC40AC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 06:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112CE84105;
	Mon, 29 Jun 2026 08:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GX+dez4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B507841F2; Mon, 29 Jun 2026 08:24:59 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC8F8056B
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0c/9MPSxqh3mfJXthCyPUb+Ndma38O01p38+Yzfy3SSUQrFwuT7TjOCsstO2K1cOb5+XuHOxhfmvmHTLEHGSG0LRyzNLcwldtvHjSWIuMeOzatAqGwVgEEEaC96Fi1V4QDHSO5aREZaCyqDRFwkEi0377S1yo7lxQGdfBEFkkybxfkAUXBxhFwG/vvI84fqp4fLyXc1UR6qKX1p7GE/97wnWDUJX26dqcFGkMW6ZcpZENIiJF73I9z18UcM3HPQoLHWT75VZCV0XER8C/cnz49TveMdZF6g4FXq7QBhuNLFm+NUbb5HkZr13GMTjWc/kNLxZ9dx/Sk/0dAlKtULpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNeX0aSDvUuwoKYbv6Wo8Jo0XmWn2etpPSTkGDifsdA=;
 b=ofC/Hiir0QEm0XcafMKsRPgWJ09uh7yzRvpUo3Pr727wgywggt89j+PQt/bMZN0wj3KS/eHcLTvuGByOkx8J+g7gpXVGS6OBTrd+FNHOgC83bsRSgNFC6ucKH5i3oeXC/JtsjndIQmRmiEcj47JGbn0O2nEFUhNSdPgOXe6s1vnmkqeqxxEs8zyQpFvIkUJyNjuTogKkc7KCYvsOnIPKoBFlFGzB1QAJzFBt6NQyfAsunmBpSPygRhAzJd7Qt3TA/h3yHIn7/BYYb7Ia0fK/iZeYrb9zr/iGtKTBkBIz0deh5G++4ZkOSJypmErAiDGrIG+nhPZlR3lHXVoYFPECmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNeX0aSDvUuwoKYbv6Wo8Jo0XmWn2etpPSTkGDifsdA=;
 b=GX+dez4j2GoIP00S7jsk5EoE9ytwyOmRfNzCjTgak/AiBZoT2UUv13d/uGl1SjvayBiN+Vi0j4QxUj0AeeLR+dvzoXN0w2SYUxeivlBHiaqzau+J21gnW/zsJdI7qydby0uxGePjCzDttXUDYpsqqTfAw+OHlBmKRpAOFuPaI9h3SWZ/qVPMUelz7d/MpXlr6kVWNZS0RbizgdlR5E4bckvfezNEAZTFp9fJTuEuknAuhRJv0g6XiHOxOVCzsWXqB2Gz/61T7F+HTLS7Dt3rYLBIUfMJ0fpprZFFojSs1FZttPQC3colyU0ZIQK4TMsrcdF3AoXY9SaPbtIvQjveQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM0PR04MB12076.eurprd04.prod.outlook.com (2603:10a6:20b:743::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Mon, 29 Jun
 2026 06:24:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Mon, 29 Jun 2026
 06:24:54 +0000
Date: Mon, 29 Jun 2026 14:28:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.denx.de, Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH 5/7] drivers: power: add support for RPMI power domains
Message-ID: <akIQggjnR/8JfkWQ@shlinux89>
References: <20260626201613.1035208-1-charles.perry@microchip.com>
 <20260626201613.1035208-6-charles.perry@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626201613.1035208-6-charles.perry@microchip.com>
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM0PR04MB12076:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1af68d-04ee-4c37-3469-08ded5a72223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|19092799006|376014|7416014|18002099003|11063799006|56012099006|3023799007|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: RMs0fwkwREXT+z6ggvNXI8LYjbmpAMrlC7eidsK7sH0DGrqcUCNfFBAtlZ0fQW7fCqbxHmCmR+e9QeVJsol+4OxvmIRJ90AYpLiOMSf8SrDPxjU1zCqdbK3yJxpSS3Nr0GiuQM6tJ9iUhh2tVpj6B22gtSU9oWAlB9dhac/4jP2wGsJq3uRZ9OeiFsxWjQldOqY6pDtcUcaxOkqVtQ7KF40eYC1A5EIEEmLOZhopmUrMx+NOqN24ojfajfRAa6db2hSbuaj8+Bgqc/alYG7tAKnYoW6dMU3euQ0S/uQW4EshFqnhaJxaog2T/SbbElTPnOxwzw4im+AhEdBxCxZJtg+qeMu6bydZcb2cd7Wf9y3jOCkTSmNj/l+U9aKa+fkqj+cBHdSPz7gH3CjTnfX9HbE/sN2O2iXX3jtA7m5TFk/dtPRHcUSm3MMOGEXQqiNmj9H7lMVsmJqhXBiRjPBFzBJKEwoeleF9h37lfphuHjD3Ih+j1bFt07d0j5TAPmwd5TpzAFnpvl1ksOqmdWPNLETVSbJUcmpvORTra5WvxoWsSa6/B0DjPEBRYSQfjRp+jfxPZnmEScuLCuk8By1UV1nAa5diAIcRFxJ2xXC57/JuXzTEmrhq+39NB0HPh8YHUrB723Khu+Vst4STO3Z2+Dy5jv3q1AKzMLnBEnru2eU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(7416014)(18002099003)(11063799006)(56012099006)(3023799007)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iE4iA1g+9Vq6wpWb0tnD5QGHupMUjfNJZFFCiPB8QGeYLdsHkpFORLox+CeD?=
 =?us-ascii?Q?A+Q36htHAQlQwxwymn6B3yVlB9EtLq8uh4JZGrLhRQwUL1V4C/wL1RLAVazC?=
 =?us-ascii?Q?mAHlk3S3ptEyA/46oa0V29GX8zoetS3fUkIU2uYAkHGL21w2Datwpi/K0cQL?=
 =?us-ascii?Q?y3nyFgAz4GQkji6hjrh+EBf52PHO4Gb2kQbSuj/eQaDZw9OJ1sThdhWklN06?=
 =?us-ascii?Q?eCqk4ukvbQnhAz4rZbcv8nMkeq/w730DLU2nF7zTyD/uMXLFW7iQvXkhufNf?=
 =?us-ascii?Q?8n1y4Mp1zvzcfQRs/XzXE2k0zjDQWkOWhZ2JplLrweDLrDhHLkLGXiGVsvuq?=
 =?us-ascii?Q?4+6NXUAnZlKbH40IdTOwuCNCHnffdRqUR81FlFmUVpUChwtPHiRis19SX/jD?=
 =?us-ascii?Q?TR9UBVP0FkDGcAHveaMsgC1a4KLMmDBecnTY/coeatFRIdmU4vJ4DNiOrTMd?=
 =?us-ascii?Q?EczIPVhOdQ7GiWLdKo0JLFoM8fehtJNtUXIh0vvdanZwehubJ1dhgt9ckOXT?=
 =?us-ascii?Q?gEylCGjHM8c6rBmHzUfssaM+MS8Lkl+RPE95sTD4h0D/1mMseh33mYBWBbR8?=
 =?us-ascii?Q?aJZkgCJE5itbkSb9EEJ0Kj6H0F0vXdZ/koLre9EVaHqWLln9vk2LKsAFa+uo?=
 =?us-ascii?Q?l4/6aPndG1deze/1dAtNy41e8S4C+aeHjQ5UvxzQ8aamuE9B0Z028IE6H81L?=
 =?us-ascii?Q?dcxQjcOCUADQ6BpCtmcIaak2+NwL3ciwIiPfrHD8GaFt8y0BAa8vHK8lWTsS?=
 =?us-ascii?Q?MTnu6ma5YvaCusA5txDNQXeq+ekzyo0olcUrucY4nFHO9E8Dcb2S9Fo5D3CZ?=
 =?us-ascii?Q?fTF5OByPv3RiDBQT1lLLTSBfpnuUjl/lORbqzuxRwZOuvIPCyQ7324mR7EmZ?=
 =?us-ascii?Q?XxdfkSIjs7Wssu/J0n1o9H/foowVxJeDxPYsUvdcCAOeUb3/BJhCFMuJocKB?=
 =?us-ascii?Q?Jeerlz/m6mESTUZUkAcEhL7XI6yyjcMGAf6lpYtPrjihupL/eTJap9xxWj3n?=
 =?us-ascii?Q?cuy+5CUqInuf1twHlUj7rFHrXGXRALUMtl1JigKhZ/7S6ersnsQdC5Oa3LKP?=
 =?us-ascii?Q?iXolJBgQDct9oDAVHWzyJkOOGrjVRkWAqV0BFYX1zNIZUAWIJUzX0lO6X4ku?=
 =?us-ascii?Q?3YmhxKXLNcmrzzIAOOC2Z9QpirDt2RklFohgyTwT8Fgdf+suJeauB0ooHtS1?=
 =?us-ascii?Q?suHPevbmxDPdjil0Y0MBvXdC5O7AWPIU9TOwPmbFXt9cyh09/94Ze3eJKKcU?=
 =?us-ascii?Q?Y9CRenLt2AIAQp8LXiifhHyd6yMF1kuwYDY9dxPy22X0SMvIzv9FkpRRBpKS?=
 =?us-ascii?Q?jC15poOqptYMo79VkQpU+wLZnHprkMjquUDXb1unSQlXOG8QD0iLbQt/gCYV?=
 =?us-ascii?Q?Z8OYPb+T59qzlkNF8eT9NAv3DuaNw51OXzBB6v/kkUBLlSQ2cIL8WbloQ8Js?=
 =?us-ascii?Q?KFXaaB2O6E3OhSIYS3i/PwbHvCg6FuWzgoCoD9nAgfpOzmyOyXgBW/k9r0FS?=
 =?us-ascii?Q?9UUirvxaY3KcUDIbQFDJsbuMdTbgaxziGSUC8CAvLoshNSiyYs7AoCOJZgwX?=
 =?us-ascii?Q?WenXWpzXAV63/BgI8nzKc+tap/wdjAxKl/cJbS47vLSgl7qGYovOZP0DLYVg?=
 =?us-ascii?Q?tUnxrHpIpCYTXiCXrn7e4Ir2uNmzxK2632rdanzoSF6sZBo/4kJNGbHqYkY7?=
 =?us-ascii?Q?LsS5oSLBEXGwqi8zO84njVeMiL0U9QXJSnoRltsfqdd5Bpv+pRQqecrb+9PG?=
 =?us-ascii?Q?oe18cUQq1NzFOua1IpxKezeQmXBJ8VOHljOsLyR+YHvqE3yCgesU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1af68d-04ee-4c37-3469-08ded5a72223
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 06:24:54.5320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItvRLd/jW3Z4WAtoZl9KLOlCDMcV36C1AoFbEKhzbZYaQpeQJE3M72dWIDIOkCCt1DhwEQV0Tl5klJoDBb9zGfPbrc9Xjo5WndBayAaYgL0U9+QOq+1XYWqoeaAzkZTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12076
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

On Fri, Jun 26, 2026 at 01:15:46PM -0700, Charles Perry wrote:
>The RISC-V Platform Management Interface (RPMI) defines the device power
>service group [1] that is used to control power domains. This is used to
>implement a UCLASS_POWER_DOMAIN driver.
>
>[1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 4.9)
>
>Signed-off-by: Charles Perry <charles.perry@microchip.com>
>---
...
>+};
>+
>+static const struct udevice_id rpmi_pd_ids[] = {
>+	{ .compatible = "riscv,rpmi-device-power" },

Not find this binding in Linux kernel or dt-schema.

Regards
Peng.
