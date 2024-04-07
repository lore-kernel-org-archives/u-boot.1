Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52232CD11C2
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 13:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE86B87FB5;
	Sun,  7 Apr 2024 15:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="adReMS/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5C1D87E3D; Sun,  7 Apr 2024 10:57:29 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D3587FF2
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 10:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfGyTSjyoCkdbqom6o2Jr18Pw2f6R7YwVw4ky7R/GnZNslnvUS/hdex+jpt4iINMB0K94OD1TdQ5EuRSme1Hk7JcvOfw3tYNo4T8aM7xdSYKUcNA5pt9QUmk6/Sgxcr7FbIGs/XpWl4YpnQFjCI1LJZ/vPXU4csWPeU8Oqhe0oVTPLdIshoauxDm4D/dAPYegiVbwV8LrQ/yEmkf0WmZDFVMUYpSexuDVbh393qGikFIpRjuvcLenzMg+ByaeeGP0bu+YI8ej6DVSypf1tHwuRsFYjl3MQxtEZOSECX6Yv7DMj4ui8gChDzrjVRY1kuBq67XwsM5X9piMb8qsfHm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNos00hQFGcFKXYbptqBXFCAoxBJCXQIopPrngM8zns=;
 b=epL0Yf3DWJj26cd1YnoPDtFjuyDt/d4Dp0QwCn3Q1/CT+O8C5Mhqk67j66cguoyMbVgraC+OpI0EuxbWX4K4BOYXRxf2myyxnmAn+QlP7ztNkB1sZ3tgsOrUiIBVqO9si2M8Z4m3MgHPDLisiyKWEEkXMX7EWSVvUl/9S5af9I8zh4uajb+BeeYbTehot8TMarfryflpf/xMzJ0a++1iL+tsiOozNi5Xa+/GAkuwQx5YsuosYME8sHzrvgO2xbB3iYdbgGgXKt8+WGcmjYO60UvOsS8WkBPr4ApphvLluvHheGMWpSqC/vyPjdYzvqWH/6Ah64/3JXEquqmOtFAJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNos00hQFGcFKXYbptqBXFCAoxBJCXQIopPrngM8zns=;
 b=adReMS/t+Bb20ooEJXIh3if0C0H/bFIOs2Z3Vvh/QxDCKjlbaPN0ZPc+no5lyFWX84DoFBHNFnpGCSiRBRx3zxPB9aBZoczDJPcZnxpEFET0mSg/M09KfK48QIx5y+e5/faERVhqRV/7OhHP+oJNf0oDHfKFWrnJT4KrF5V23PQ=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB8279.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 08:57:26 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 08:57:26 +0000
From: Joy Zou <joy.zou@nxp.com>
To: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de,
 festevam@gmail.com, sjg@chromium.org, saproj@gmail.com,
 judge.packham@gmail.com
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Subject: [PATCH v4 3/3] imx93_11x11_evk: Add PCF2131 RTC support
Date: Sun,  7 Apr 2024 17:05:03 +0800
Message-Id: <20240407090503.2312483-4-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240407090503.2312483-1-joy.zou@nxp.com>
References: <20240407090503.2312483-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB8279:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyxL9ehzP+OHez5sN2J0JKygUg/T7yw9BUN5fKeoRrE3vBcjcbzHu2lhRbNtcMLcuZpRkilPO3rh9souIMUy1J/J4ENM+kRFi7DadImxVmeDTrFinH0YS2b+lWy/DYAvgPUeBDKi1R/SGMa8OC9lUJcD5sXIrFa2GZMSikw0NUQlEK8FLSk6sYOUh5dCBLYJxZ3/e3Y6MQwn7q+cu1q8C/7Ry13Ji7QfROCiqWP86/WtFPqv0PA7D306JwKsQ70NJ/hF6XdUnLGSNbgA1+u7zYdXLf4rAMSHxUoZfLQma+1oI/YBXeQl0Zd1Y/2hMXysUmKC72Fv0oYUrd+C9RDiX2bUNScJNQ9zXhemoHqXRwQ1VeplAMEGN/no1ZkQvSZpZ1erY9djiKnIXIXZ0tOj6E0ilJactEZV9HMiq6VHi5PbrDpY951hPMff7ILWIWhafPoNOB7AkWl+GmUcfdDFtHxS28IQu3paXS6SyzYSe611AB/HX437ZKWhgTMFvolA8JrN0N65zvSK2DvNNZo2aeU9wg/Bkgd1oEQs81MFejFbsX42TdYvFdcc+2E/waOmwaitRBRPWHBbusitzrAaoqdYLlZcoRyxJZOtbajdweYd+xI8ONwLQ4bCLgJ88dwg/GgKCYFGMysUQJZWswcP90nfZl/QaLUT2OGDYLowQKiIXxVynVX2/Bdke6NtoKSJ8krdhWEhb20pR8jfsc3KJ5xD2LwYcfm0Hphl8t6IzKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9386.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nvvlobt+DB3+eNp6kAcPxLXlhctptMKcbwwUBGBgXJBVkxPikC3jJEnrEqUx?=
 =?us-ascii?Q?pZqSWgfjFLN09OssRxXalu62IrlGYOhZ9IRdp/UdV5II6pHuxtY8oVIv985C?=
 =?us-ascii?Q?3yueeNRLGSawagG/pWzpNeooEFRJeCddreVz4UK9TP/9kHjd39FkD3dfooNI?=
 =?us-ascii?Q?qxWC9+keGY3zsYylqqwF55b0afP5lBp7k52iXo01L+oPZQoPY6jUf6zOpeZs?=
 =?us-ascii?Q?HYnUOi7Wq38R53y6DfeIsjdgR5Yh5czMuRQnr61gER8HCxvyS6MkhBY0ua9O?=
 =?us-ascii?Q?nvRZYXWCAPC5FNybcjeDGVYaVe9bfJdtnvpJ4tZR0jlI+ud64wlN0pvtPIE2?=
 =?us-ascii?Q?6nKbRCpzwmc49EVQ9sLJsXNmaqWAB/WSmQFpoPj9Buwfem8+h2CE1ZPaKjvj?=
 =?us-ascii?Q?O2KXLLxAAWvNqDlvKgFbtDpyCMG3Uci6Dwz0rutkUZ4ckZMuJUeKD7sNxW3i?=
 =?us-ascii?Q?Puw255/NhLvve2/9F1kTvbXD1IzOMldRotn/ZuyfsQEd7l1IxBr8TJj+HVYq?=
 =?us-ascii?Q?PrbuaJf5ma46WPDiCbW1bXmHKKvqla5IW83mlOLA4rj2ZkoEzOrVx4U8/nOO?=
 =?us-ascii?Q?aHHRX6nusuPCv4ZE/HzaQmN5yIEpYcf9+anwyld883UD1DqwoEguOHEdaFyA?=
 =?us-ascii?Q?zc1RgSTZdBtpWjI6qygEpGV4LLrOaPPTPufJ92AojF0ImkVJJ2m8AYMLWAly?=
 =?us-ascii?Q?RpLLKXggl89t5zP1V++1rILcPU+3B25l16TOb5FOAoltLfeiuxMjBM8W1O1t?=
 =?us-ascii?Q?tDTQ+itQrgTbxLlJgLf5w7G7N+9Fv08WazZSkybs1t85nTkIt7+ZiiZK2lZq?=
 =?us-ascii?Q?dfGAHEtaGQ84dExaoSe8l5nQ9oKZJYHHi66xyEfYtvuBguwbxfcDdJmR9Emx?=
 =?us-ascii?Q?F+Pg+cQhAgDYkJd54WKjsjDUjcL4o93zMRaOgGoNr54tmPipHfso6mlS6AwY?=
 =?us-ascii?Q?wOxPKKSYrrN7kLLRzQVw6vEUH617Paf5oiu8bM9qYm60+66L954Ms5W6Cgbt?=
 =?us-ascii?Q?/7iYwJHIYEJcATRtoeMIkdrpkbgTMHBLTbhfx0mZcgdpVOhlOndr0FXK0SYa?=
 =?us-ascii?Q?licDjA5q2iW6zcL+stYAx+aiTwMelnkBbj+j37tnbmWWaa688sQmmcDOCdkA?=
 =?us-ascii?Q?9yyWR17/i1B1sKhM4S/wpa5Ci5EZ5OBatkMO737fomi61Zq+i2YgptPchWO5?=
 =?us-ascii?Q?xEmoq/6R9PXwKdSNGTCQ9hxU8i5vwhy5cOEh1iSRuNauRKXWdUdxVgoh88Ga?=
 =?us-ascii?Q?17VqGBynUjGh3stfMzi5KpJe3FLsPlLYfU+KJ+lOMbjvf4fqXx/A6CoWVoOT?=
 =?us-ascii?Q?aWcYUaSLLcYmF2RzbobMV2C2sux4hIL0EhV5aIDwEI/1iR/osJBD3qJdJd/k?=
 =?us-ascii?Q?iUos6TYceEDtH091a6HRM5BLvZFKylyWYBFdvti0ClbefNSr8sXYonuzzYB+?=
 =?us-ascii?Q?TzxGWeLnXl0yVf8+QvT+DUuSh16b6gvYmEjE5slyAVa3eXlTCmdj2VQAMBNA?=
 =?us-ascii?Q?i/Hera21WimihU2yQYoZ0U7yQi4ZzBAfJdJboJ8b0TSlv+A6cY27B5L62O4S?=
 =?us-ascii?Q?Q81CYWS4dFCnjAdFlF7GZj6b+GFvp3MAPd/bWVtH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ff389d-b60f-48e1-a46f-08dc56e0bf5d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 08:57:26.6282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/hrjk46zcsEYiiI9nl9clEMdJCIQoEwSiH+meGJ41cRu8OKG3yw1g4AirIyukXd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8279
X-Mailman-Approved-At: Sun, 07 Apr 2024 15:03:39 +0200
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

Enable CONFIG_RTC_PCF2127 configs to support pcf2131.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v3:
1. Change CONFIG_RTC_PCF2131 into CONFIG_RTC_PCF2127 because the pcf2131
driver have been merged into the pcf2127.
---
 configs/imx93_11x11_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 63613477c7..55e2673291 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -14,6 +14,7 @@ CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-evk"
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_TARGET_IMX93_11X11_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_RTC_PCF2127=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK=0x20519dd0
-- 
2.37.1

