Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CC0D29DE2
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285458394E;
	Tue, 13 Jan 2026 09:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RJ2RT/QM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4997E830CA; Tue, 13 Jan 2026 09:10:24 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66096808AF
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 09:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c53uhfHBkKxmBf/oxy6mE9GOoojGo0vOK2xqHk3Sf0mwk9fokOOTdG465UzpBvQik0STbyuUVMgRZebkevGQSKIMiz22XrCCVeGjSDGC3leuR7zZcq4FehQbglZlKwm5c8ebQvnpgXh1GWW3dE2JlrZkYc4Y/VIxklbpawASfEZBo0d+crYPWv99VGd/+VqtZrY5g4zHt+DK+Qxntxj1YpmC/QCcO7ZLbeogly6td/nb0aTmleX6Eeod276ma1UCYOf1eNRhvMo5LWN4C9NgVCvKDhlw35FE1Dt2ATpYOKwfItqbTSuQ+9cudIp3Jjy1vTyFAChrBlcDmm6+h3RVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4kodUGR01rJHB7dKS6ryoA5+hnGPwSXgE+HMF5WFro=;
 b=JmmSfQVFwZnRlgue6+eeG7XvzV7cXkIP5CkukM3klfFyNzj59TMsL31oWWVHYK0Ar9VM1E406n0uWXjo91WtXx0s0OsxU2eY5vtlZQpOJHSzf8C0Jm7pqCBExevi76XmFhPEbcGpOERSKuCxtm47pkMKsrgKh3+LXBxk1BU0jseTL5cJQ+MWb7BR9G0Ji3jRhXiifRNM9KOmpIvjcu7r4RPF+nt24l5Jp2GhGfDBRay9kmuejS9Ev0bPXzhWin8svpLZEU+HOfSI6Rbv+g98NKUDBnpQTqas+BUkHPEeD11N218mhC7WeSJevUtlxi2bWfeKTDtlFCpfu67q+m0cVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4kodUGR01rJHB7dKS6ryoA5+hnGPwSXgE+HMF5WFro=;
 b=RJ2RT/QMnB4TUj0aCsZ1OUmaBvF+u1U8epVcAjV+U9sSr3tAqomkMIBokQPD7fGzct3zjgT3HeKA5eIGO00w1vPX2uc+aARZGrSnFKdZyFyOX/+v+l4xkwUMLvKen5YpAWNaJh/qkOOpN417voXR80KUb2FGxM2Sq43RdSGyrqz5LxXH5gI9AwJOCwRElNG5tyu8q/A/OVT8N1sbKVwU+L6gPa7WD7q39Jd0u8D4FkawfBEnFcofUUpmcTYxJFoPnLxIFDbgB8fQIJhob7IFopZwwUuFucAicXnaOgzARsVAHAhfcf6p8exZguzYpRiT1Ar4pBlczRlnxDjV1h+wqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 08:10:18 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 08:10:18 +0000
Date: Tue, 13 Jan 2026 17:24:31 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mateus Lima Alves <mateuslima.ti@gmail.com>
Cc: alison.wang@nxp.com, u-boot@lists.denx.de
Subject: Re: [PATCH] armv7: Add CPLD support via IFC to the ls1021a-iot board.
Message-ID: <aWYPT7OH8oY0O0Mp@nxa18884-linux.ap.freescale.net>
References: <20260103030728.334736-1-mateuslima.ti@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103030728.334736-1-mateuslima.ti@gmail.com>
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GV1PR04MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f294f1-53a7-4b39-2529-08de527b3056
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oezzuOEkj4Q95bA4X1e/FjbrW40mPMeF8jDeJIX5s9IJd8Y2sAqZ8ToLtOtm?=
 =?us-ascii?Q?3ih9tfdQ0UVBAqqHjj/kyNSSv3FV8eLGBt7bEtCEDZHvdvYMq30Nthe+iEDC?=
 =?us-ascii?Q?t5SBuyedbfVL/NaBQnkHDa3M+KYSDc+Qc3+KChQWu6JxVHYLol2wbsaxgzru?=
 =?us-ascii?Q?82B+j80THJlZ381LMBO7orTdfVTbH7EemDbVl7/aOYWi9pCcZ6+HkUjngR4W?=
 =?us-ascii?Q?6vwfe9feaSqNE5edr3YOdZ3XtJlLP5f7SzLl32NqZHddBR0M0w29M/gwxU/y?=
 =?us-ascii?Q?Ui3pFMCfBkZwZ5vAguvlnrYm+o5aKX0d27WEZMZowjg36UyEFPopF7W5p6ng?=
 =?us-ascii?Q?j2qpKPwfYaoYKZEyRzUfXKzyq+gUyc8XX3LEu/brDa9nXDGhsk9juR3omkcy?=
 =?us-ascii?Q?wHNrbBdxg7nYLWb0u6C/Po37cNLMC9uACZC8+3kZ1BX1M3rQcNTYDJfffTLQ?=
 =?us-ascii?Q?tr0cOQWAAiY6bFTV3YNZp/hFeWD5SMJseaF6j+71U/oP600qHkLekUagkvjb?=
 =?us-ascii?Q?tCf7hRLeNEqP9Qqq/1VzUmqTopMaNcYBICL1zDTaBy0OG4Tg9E+04JeMgcdm?=
 =?us-ascii?Q?lfX4ejuTRVrZRhgh2rsINnoNGovjSbVXlVG9T5rEVHTVh8SqTicCgGVQ/hHH?=
 =?us-ascii?Q?pZiiMr0NfjDFQEAxo5J1YXcO1CJcybNs0a1/yQkIJPd1BVOv2iqZA5prEOkJ?=
 =?us-ascii?Q?7UKLuE9p7CtZuhDCnDSF4zs7o7UypARAWKhLTOqqQEyHrCaqg1wlFiEFhcls?=
 =?us-ascii?Q?Mk3VofG19Cy+McOOnjKMxbm1KOP+md9vO97KWAMLto5AGdO8UFZgbJTu2y15?=
 =?us-ascii?Q?WEAhb4JwwdLh1pUEDPTuR3K7uDsgyZyG0gwTRA6BAGGttHlCin3KgW3w0KTI?=
 =?us-ascii?Q?wLazsT0ZVuahVXAPnnetQL2Bt9T1xUA777Ms1oAUjVr91XbM4vXZ1YmJxXsY?=
 =?us-ascii?Q?xsRtY54nsrO0fJrsG71708bxGojJcVrh9RWY1TcwMQSJwFwff4AWegRlFCPC?=
 =?us-ascii?Q?/zg4pWy1/xAzQVqJv+7Bwze4Y1JycPhuiB+qZaGMp8kdgzllb27ijq7sbSun?=
 =?us-ascii?Q?P5tfpsGk8XOiI0ra8eKf1I9ngKxszLShLpf3+3L+pAnYAZwokZs0Nn3aTpV/?=
 =?us-ascii?Q?4arrYvp+WO6tNt27gssSRNaiFv6BtxS2zoRSIggLTZdt11kYwAyKeNaIuwls?=
 =?us-ascii?Q?yBXZF1JJxi6xzOcf+oIV9WJKHqjhQP/k425XNNEkYal9wURI2jT/8XXma8bV?=
 =?us-ascii?Q?tAG9RlNoTmA7Ps7czldLI4HwHtAuZ52XeKuuq+k2zxvUoomJdgHfIW++jzfE?=
 =?us-ascii?Q?gvt13hQHEHCt+pJ4TtipPV4zW/Ktyo34qyPNRwivQ09aeFBi6EHy01rnNDbv?=
 =?us-ascii?Q?zaeOE/tCPsWsKbVhDSgSiM4lDpg6775Ma3x06U6VS7+RKs7ncBANTw27pdhx?=
 =?us-ascii?Q?5heT6wDSD5WgyKq6LsYWNGjHD+v/4DwmOB4GjgS8efhAXcEgqIJRfL4MKkML?=
 =?us-ascii?Q?6KLIa2awvcJI3cMfLtXALvK4Vcw5WL1WLlEr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3mheH5agJhtSrVy9pu+qqcQarG0/ORxn06NYaekAOGmLDT1LXwKQJayajVK4?=
 =?us-ascii?Q?aPx5dflvjtwGcoO94IIEPUGohentVl9chGVIBrQFsUHicN6KlzGlc4AkAaPB?=
 =?us-ascii?Q?tIZapIHQz4Ng+MOMc/y0hC5yfbNjwJKqUJEYYvOInWjavtYGrAwOkVtlv0XO?=
 =?us-ascii?Q?rOCFFokvymdS+zYpwOYk+4ekX7agK8aVn+gPFIjcCc2ZlvaPIYBLHQr/LXyp?=
 =?us-ascii?Q?PNsNoS9Z5k7BF06JNm2K3qQKqfx7rplc7adi0AbRIaibSCZPvHtUYewf4a5x?=
 =?us-ascii?Q?EFsNtzORxI01H8F1BLtCX6vzkZaDZ5bSm74q2kvpLfmY3KVFI25+RaBX81Uu?=
 =?us-ascii?Q?kFSKqfgVQ4+KuUyA/xGrpRLpl5wS8mWqTeiZ8Rmb+ZOSVGYJM60ANzKvp2E6?=
 =?us-ascii?Q?uNPiK8t/OOdSstraU6vIrgGxNQOkMlrC47lKnw3J1V7o3Kb8LVwfB+9nq96R?=
 =?us-ascii?Q?BRymXYCdLWi3B7ILwXU654wZaGO5RFMAJQwr/3fC+PVbYJvNrkLJSAbz/1hv?=
 =?us-ascii?Q?3k2Lj0LK+59Gj615SJclicphjZfA+9FjiHJBKwMdO20WFah6rK2TkAxFAKNt?=
 =?us-ascii?Q?eaT+305zEfgqIF7KW9ZvjVjVryf8iRZoQZMe4yXauHXN5DzvnDO9hiVqNeGP?=
 =?us-ascii?Q?4MrJLtDnCzLeXz0o0stgKcS0Y5XLSjRSs4B0u6ksSHniXhtdd22qogB99IhE?=
 =?us-ascii?Q?pfwHkh6+6fuVEt3uwyiTdK0yZdL4xBtSCW6W14z4lrdVoyu6uktTBN7RWUij?=
 =?us-ascii?Q?Vyyyb5JpmuldIginYpPrPQdr6th5A7PJxECVAFcUuji9r93igg5wZgya9/4w?=
 =?us-ascii?Q?KozpL4g33cXg6hhZvc3su2q7zKVS8+adEVV/sKP4W5qXUou0xqMYIQF+ErNt?=
 =?us-ascii?Q?Fr9fWf+Bci3HwVP9+Mt8qIBeJJyKsU6zJHAox1/wiGSHSmN+iML0lvoRebsM?=
 =?us-ascii?Q?ofIsJSyl6/oodryemobBqes4SIybWqTXeeivdTw7v/Dm0h0k/Ktx/RoD85lI?=
 =?us-ascii?Q?IvVVsBzCKGq9TRM/qkKo78RD72V/LCBAFwDlTQY/80LgJG2oWjJ+ofEjiG2L?=
 =?us-ascii?Q?w/7CcN6VTaUbFz92DTIdBbzBNPL1i/2lL3BVgw8ebZAIwXNe2b9/LmbPI/cY?=
 =?us-ascii?Q?PSOR+9VVPODPPIfiAjiZjhTaayll4dD38LGOoLEVp+MAPumopoAJMYuptlf0?=
 =?us-ascii?Q?ew8sbBAECuvfFlqbdGoQiJF1EP1nBpQgK7cs9MVhcT8wXQYVoxwxOFbexMKT?=
 =?us-ascii?Q?Gq4fTpy8DUVOt3HCjTmJCBdpNsrp26zyuO6hBiwxuJbO+T+m81GcYdwlHlMy?=
 =?us-ascii?Q?V+IIlAqpiFslLJX+jxbW7OS/KEa3TQlr50JqvjXLoVDxu8fZt1TQUt0sLTh/?=
 =?us-ascii?Q?QkY2/YPo9LR3bTBhHAsSbHQe4npeY5bvkyo0B7UR5ad+HzgqHFxE4texyhqh?=
 =?us-ascii?Q?Oj2w7MSmMLP4PHrobEUrtWmdcVc5DR5Uci5/yo/W/TpwXbknZ3OpK1vhJlhx?=
 =?us-ascii?Q?vbOxfAvl43fS7cnVVMCcIib68CELCj/cDsNQSgvmfDjY2T05kj/WiOfknsgn?=
 =?us-ascii?Q?1dHXST4YHLEYpCJxaiLPFTwsXjBIKrsERBfBs8ta4Eyrk7by84H04x3SVOcy?=
 =?us-ascii?Q?wpGqOVW6miF4JqGNF1tSMfzqv579RTUzYIOCEVwCcTFbpOIU/KzVqAbRkBs6?=
 =?us-ascii?Q?7jETx62zQRjOv6lXC+vv0x3/nQKAySKYN1W+oBapTEpe0TlLIERXnPryDLK+?=
 =?us-ascii?Q?RejD46fCog=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f294f1-53a7-4b39-2529-08de527b3056
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 08:10:18.7223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67dz+7rJzTffaoeooZV8ULB3IMo3pwXMAc7xYxcHNyXIGbYqddpcPv3dPsSeZAIEkEZqnzAeztlCWqKxjvDOSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120
X-Mailman-Approved-At: Tue, 13 Jan 2026 09:42:06 +0100
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

On Sat, Jan 03, 2026 at 12:07:21AM -0300, Mateus Lima Alves wrote:
>This patch adds CPLD support via IFC to the ls1021a-iot board.
>
>Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
>---
...
>diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
>index 6b32150e408..450b46a6f1d 100644
>--- a/configs/ls1021aiot_sdcard_defconfig
>+++ b/configs/ls1021aiot_sdcard_defconfig
>@@ -63,7 +63,6 @@ CONFIG_CMD_GPT=y
> CONFIG_CMD_I2C=y
> CONFIG_CMD_MMC=y
> CONFIG_CMD_DHCP=y
>-CONFIG_CMD_MII=y

Why deselect CONFIG_CMD_MII?

Thanks,
Peng
