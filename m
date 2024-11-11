Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31613D12D5C
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B55168936E;
	Mon, 11 Nov 2024 03:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0541F891AC; Mon, 11 Nov 2024 03:09:48 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20730.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3C33892E1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnh6j5Tdhyck5cX4Hz65I2zz2at5uttEw0hbFYHOONk/rVynLy4lqakrR7jvgph1wO3w78mhFcaJnPMwRBfye3i+0C8FCvjJ5U+3IIYD4XoCf6TlwuC1JJb3UufCNGf1emC0WakxekWiRYjm9PmgL5JUKsBgRh/1qnPWO1i8P5VbOocqJpN3RjBFk796E+ZN4YhdlCyVsqOD50pHaDu++JmcwjUGxn9mm1CGQYmB0ZY1c/sAAFn8JiXdojXYGae5C75HWfhfnANDvsv8nlwS/JorpoFCDYw+U62yNwINawTbutAE4r/PQJd95PwqSLrTPE4qelfBV/pAUPP66gLr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkaRGwwdj6U2/M05ZME83smIPgtF4+WsZdCk5RaQf0s=;
 b=B1sMsVXQf6TL8+V4XUjvXqSfYHOD111ix2XtYz2Yl3K2iD0jlTOKPZbkBZjueaofoR5zHwklsVgVUpDRKKq7tGQtpWnEnFejFjqehPlKuMJmlBQAPOkN2j5284bD5xmeq77LiJq1tfXSiavAQa7oQ2ODIMYQwESvIf3xnXcrJW7ATa7bBqAt/o+AeroV6JvUnPtJREibY3a34VgxO8nWdbLNBT/hLKCe1/Bsxu2ut082qiw8ox5qdgISmqOmdDs9wiO0TUBbIFSAd35EKm1mwaBObrjqqT6NSwchAPESZe/MBS/zX3QFfBnUzwtd3t1yo4c3Yno6QW69TfhofYe5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:51 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:51 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 10/13] configs: visionfive2: Enable MULTI_DTB_FIT for
 JH7110 based board DT
Date: Mon, 11 Nov 2024 10:08:05 +0800
Message-ID: <20241111020808.38974-11-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: c8593d01-7ec0-4e94-239f-08dd01f5ed41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: FOQmKEsQ1b2otBfOaB5l6ifWjLVfoC+BjRVE4N58VZ8k0mPtgyV/UGZYzI7lpkX7WpuVH/jbt1Ku0KJ+9rPndUPta5+euzg6kkojLOc4af6vW1uEXH113tBMSAehxrIwzF5k2LhiepEWgPkj5P5jtfxcssLAcpiEGq2hMGMLq87efXw17/Wobek3zmI1h/p0ZEpz3fxnJEoL6sfBJow6K9vZFMZqBwMGZU+EpFXOK7X1ofyqssL/p8e7IGsoaIr6Fw+X6SV8U5v5B+iXps7zMfaG/uedWV92VDxtJ7QskzHkSVL3EX8GoDppk3xxBq8Qje0CRlRsKDeX2Uzt4LezyiM6wxe+70l96gZTYay2jOi+D80rupxM8TKRTMngb/0fU6iYo6JUx5L+M5wVZ1OgqbXujGx0prVvhizVIg8cBpvUlPqaqoVR6UX/cGYZC9M4GGZaWyf5WATi/t4+gNJy0MB29Q5+YXRdpgYS5dHaj0sbAXidU7kfR9OSA/rzZZJfJBrQOxWTupGXAucr2mUBLmi85gEmuqTPXFYqWQuqlWIt2IiJbqqZOnhPdTfY0P08z2tlGBXqjgo95PawAS9pxum7qmlUJ9ba6DT+vTJj1jVAnD7DSAPFrXrFxrQwH5z7VcGau+AftF53iPJNtVHgyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?erpzZQKU3JNdEbreUbUIdYvTZhkB5rlu7jKNSIv8PHLpugBF0iV2PKWAdYME?=
 =?us-ascii?Q?92zLOPlQiVWluAURX4J0BoJVOx/ztG/TEYtvWYKMBWWEQNnjvyZGyx7APsCe?=
 =?us-ascii?Q?A03RIAzqLX+k3B87cLJQPHq+qPwDpFJ6NMnPCfeb9ZKBh9K1syki1fJFx67u?=
 =?us-ascii?Q?9mf4Z1m749tKQv5NedQveybv/4d4EXYEo807IVZuiPWpjrInVAbWkYwa000h?=
 =?us-ascii?Q?lW5Yl2HdErz/CUduMz56fyiw9gIzN6wfsu6xcdS+jKE2XeW7GGhbvcCYvc01?=
 =?us-ascii?Q?aXKqaMyomZ3lUMDrUtbDAAq75kGdzTemEsukQ2l/gWUcKozu3u4TMMBhnDnM?=
 =?us-ascii?Q?A/rXz/TWYZhUYMrT9UUUg0C2v10ejznC7iE6la0vTIfG3BDdD3FPnUS+8syY?=
 =?us-ascii?Q?9pcHe2OajTYk3PpHUMoQL3VIjqK00zofHVVtHFUlchwRSIbFsm7OLUpO1LaL?=
 =?us-ascii?Q?UbrP2UzVPkZzh34aPHOKsZjA9nyekDZBZI6r+x3GCNydRYOAOrv3LxM08EBx?=
 =?us-ascii?Q?/cl60mXY+YpOzeB8EPwWoBDZoL2kwdhjh0mTqP8W820EPc1NeT1p8Mfs375+?=
 =?us-ascii?Q?0bF4tpp89l77LeigwNGUQilJoVbkNnAYyYEe++zMJMD1RJaYJ7+3zlCr4/bz?=
 =?us-ascii?Q?qxgtZRRPzOD+2BrMneWyX8dU9Gm2w/pocaFYUWn+L4ZwKigXlAQMcjLHAFrW?=
 =?us-ascii?Q?BwmmKOwwX0kUWx649xBSqvg55bmTwVVNZ14tIB0ZY0Q5IBBPxUvhHKXT+o2E?=
 =?us-ascii?Q?n64Jf2rj/JG0+fqqB/PuLuefkkGCH2KR9eUH8WXWjEVUD4vfTC/sI0/yObpO?=
 =?us-ascii?Q?gEVW1vdmOxEAH3rTE9knC7cmE/5AaA4o71ZKFV+yZjxnxrAqPV5d+C1/7IrX?=
 =?us-ascii?Q?ZQ9v9/OUDKjvTlZ5HAQ0gnwPIh4KRc1EcDZSWiwwzOEn0jKN4AxQQEsy04LD?=
 =?us-ascii?Q?nGq09aJxMxrKJAmAA1uLlTXj7osF6wAevvFWTtZKTVF8bWCay3fuAKu3CFJb?=
 =?us-ascii?Q?UFMKwZ1kfVrhlP6FP/8JbLAMxbZOPmceay7LS98OHPIB0lpvWW2DPcSzf21g?=
 =?us-ascii?Q?qbsAjqYahUj2a2wnVbdnS5bw5hle1F2k94VJdIqaPDNcerRL0x1fDC43q358?=
 =?us-ascii?Q?ZDqYH0xQIyikKb73KCJYgtaW2d5/qB+RCcyz0KjsCkWVNq78PXQHiEr2rvtt?=
 =?us-ascii?Q?ZzDV6jvBM8cN6LLBjDhVWdchL+LmyYOGEUBji8OAHcxIppqMCYikQx3EUToR?=
 =?us-ascii?Q?2PGf0q9dVcEEp+7CHo0yKRSP2XjR3ydKrd/fy/BRsvljCEbzAKeQgkQximvz?=
 =?us-ascii?Q?BuvFTF2U3UrEUTtGGirHiRFPZ8FFhaOE60uvmTKQq0c4cOsZsFbJRk4KlXTl?=
 =?us-ascii?Q?8efv0HsSpF/WsxOlhELuS6qrV9bP45OKoSzqLca5hCb92hmDJBihQvdkEoFc?=
 =?us-ascii?Q?D7Dik0ugshk0Nc5Eoa4jCSiifzNMqu8VSi/AliK+3mGK2WuCf8DJxLQM72tY?=
 =?us-ascii?Q?XloH2y0keCojy7V7cCcpyKx+RIDRwfXSCBfhHPoibLiHV592hgZeYtkPFwgG?=
 =?us-ascii?Q?iun3mNPGGSAR4r/yju4JSZLjTVYleqrwTYqtIayLfAdRA/v6dN27h/M38jIK?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8593d01-7ec0-4e94-239f-08dd01f5ed41
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:51.6759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0w1hxArAJTp229trJgWTp/i+7WMoLS3k4QlwPySXQW/et+l1qKlAqnfWeKP4tQV5yKaLYUx6hbga0OviYwD5YupENwk47WAWaGDFqVky+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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

So JH7110 based boards can select their own DT at runtime.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 40f553816e..5c631e09b1 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -78,6 +78,8 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
+CONFIG_OF_LIST="starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-- 
2.43.2

