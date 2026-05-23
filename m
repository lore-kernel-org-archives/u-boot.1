Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03944CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0447E84910;
	Sat, 23 May 2026 14:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IfARZmya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C667784881; Sat, 23 May 2026 14:23:31 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E411D848DF
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNERXALF02ucKfW68BnJ2VY/jpbRUAAXG5cKCHvH3vQWkrfpYfsbDMc1WD7t/rSlD7Ml9Yyf28n7vvwoa9IG71O6/vs4SBTpNQC/EgOy5xEzGGLRXr6VY5BH5hM99kPCpRlF3LeIz0HwvdKGDHVwuJYT0K9hhtFesPZTxuZban7BE8s6tT3TVoLW3sRqjLS5kycuiIlkCDRVvidos8P9gW6EFoT3xYGDjleULDRFF4zOk6r9aFttVpp2majOWDDTUFFOB8hC1d81hPXs5gaZ8MvvmOwLOfvDQiSETOOCNSVvtpJ4f17ZJjJCe5sCsx9NhXlNUnemo3pWE8A2EWL2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG7KGUn6CkCjxkzxemTz+LblLk56l6B2WSEd8fkxJ9s=;
 b=k97H1TYbAdLxwes2IuU8FoWFAGPHa3Y4eBSM7NJnqQcZD4oj9oNeIHk+TO3whKFVupV/v0w40JO6KthlefyKvta4pNraf3kCuCzIn4x5XruY0ZcvjUMb+EiwO1VBCSsZekMcITJYepxuw1HO/ywRWinzEejbNkLwfvvvORUQ9lE0tl+L3btmYVn2KEKJ64C4EmVrPyMpi8RxLlgwsM5P7IP3GKny0hmQyG4mYkJ/SpKDQFpVuN0ibh66cvSSSRYm2mDv0rJSrSayOs/bh2ybaKyH1Uv/ijDkHHw7dSO9ZxLL5Zj69loSjB5yCkmjit2FcxlM6N1E/xHepxToTcWY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG7KGUn6CkCjxkzxemTz+LblLk56l6B2WSEd8fkxJ9s=;
 b=IfARZmyaMZoOin3FWv0ACGazDItxUJlaGnZpj/1IeNB7sD2WpmXrR+2mNrPyRQGxCqMSvK7vD2Mdz1ifJq38D6uXQizKAP6caX1DGyUiKL/0HaSdzRA+piAEBrGQ0YaKlgabtLLdxdlslHG22jHs2xTXow25/1brmOfGs+KxuZOxsq/L4qJ/MQB37zDg89s17dlde8/2c9Lyd3JKSXJbnf8J3me834wq1pS07l+bh8rOJdtpwCV0RFX/IgCIQrQ0HZcLO65AKfsQH+2b2ERA4hifzornbZ+O7wXyfsOrQnfEPmoPaoafX+s/c6s7bTyH7aQ8Gpcd++/NPDmT78yXBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAWPR04MB11708.eurprd04.prod.outlook.com (2603:10a6:102:50c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:27 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:55 +0800
Subject: [PATCH 12/13] imx8m_evk: Select OF_LIVE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-12-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAWPR04MB11708:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6b027a-a1a1-4223-af0e-08deb8c617d3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: kFJV9oN3gfw2YZRVpufAYbMMEkjDyirAvox5XwsDemlVebCRSPWgmoZ4mDI143qr069W38DiMo8A8xg0bS1rG+aKKYX5XRfgB7KJ6KCro+9kn3kfIrXhpwy5INgqmxHE1K7BO9Li3MuXTwCt0VcAXbyu+SoD18DN3WDA18MJQ7lHk+wCGy2IpqNwAKuFT4vLuz7j2KfEjbJiMrsDMKz0C+7g6G3VcQv9SWF/ApF+WdcGwBspjt+2IZiN3wpQKMcHjLf1MNB9+iRbHAguRorfb50ZUSwa3E+FCfk4fPO7IyJjBZzPpWIEV45jT6zSrS/1mj1MhnuQx/QHCHPz9Y4M6x9SHfuG7hFuojeyy/YVx+EKgXWXfwkf9IKMYmklGJfVhSY7JG4m9ttN0Ht8zpBVNP7tbmxQTrAHb30SzXa9rGRpDQ9XrcORW2R4gpcU7tIUkabBiW5nVKkcrWzzFFzzeT7b7oLCZNnWk7ZCrHtSRslC6KWn8kE4y0Sv9xH+tNUofK3ls7wKI1EHbZ9C9EatIibAo7zojcOVoyOjZXT2zQQDnziQykrI+mJfD+Jbsdx/zB6oYQ3qzA7QvL+7CWn2O46CewcrQzPEfxx7MtJjjVHOxRlyPVWxFBWinLXmcN7MQxEWaHW8rPanszCsjhoEahpRYcSWVWXdqEhgwJe78vSoDTn6XPuEBeTd9eU+L6cThUmEenKp5s0z77D/ny3vyZzLlhYKJ9Xgh2NnKIsj8/IC1qVV4xdDdskb3xCRhkvt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0lub3JKV0dmSkltRTdZRmF0c0s1MjRDbzZpUUJPRHNndjVSakdZOU03TG40?=
 =?utf-8?B?WUkySllnamVZakN6QjFOWThGTmlHUk0xVFoxMDRHUFIxZzZKWGpCN01HelJI?=
 =?utf-8?B?TVhaaFRvWmVPS3VRRXBOTGhXTnU3RlM5SzZqZWRJMEhxZU9RVHNKWWVQbldN?=
 =?utf-8?B?cmhyWFRxUWZZbWIwRFp1ODJNeDJDNXJYYkxOZ1dUS1VCZzAxU2V2K1FsejB3?=
 =?utf-8?B?VkhFZjVUODhsOFRXWEZEREJFaGp1TitTeUZCSEhINTR5UmplOGsxZ1NXR1NN?=
 =?utf-8?B?cUxGT1drK2NBYWtEaDJlYWtiZStCZHd3QWo4TXMrdWs1aXZvOTVSOGxoVFA1?=
 =?utf-8?B?aUJzbG1ESXJyK0gyZ3YrUktudFB4bDEvelN0dUZMRTI1U2swMUsrSFo1ODdi?=
 =?utf-8?B?SE9zUlk3d2RTU1NjREVjeEpnSVkxMXJ2NDhXaC90ams5REdiZy9UVmorbmFM?=
 =?utf-8?B?azNaT01OQzEvUzU3bkVJU0FoMFJqOFMraTBPQytpNzJSRkEzVFF0YjlPQWtG?=
 =?utf-8?B?WkQ4bjM4blFpT3FTdFZiRC9HbE9wT2tmeWRGbzdwV3hzLythL2hva2VKenJ0?=
 =?utf-8?B?Szlqejl2dHF0aEpabXJRK25WZ05Bc1RRa2FRWFU1ck9wRGhSb3BKQU5TWHhX?=
 =?utf-8?B?MnpGNXBMWEtUZVpKTFgxQTVsUmNkT09ZUUpwd0JpQnlyaUthaFJPeEo4NEVX?=
 =?utf-8?B?Q3RCejZFbTBKTm1WcDJ0YzB6NXhObklVQVZxaDdUNmJmL2pSRXE3Qm1TNnJv?=
 =?utf-8?B?WEMxSFB3ZmtUek00Z0RKVThaQ0d0UUZlWDFsVFllTlp2UnBlRng0Sndaajg4?=
 =?utf-8?B?RXBIOG1IMEFDNitUU0QreWxvWE9ZMUJHVWcxTEM5Z0NJOW91TUdtVWg0LzBU?=
 =?utf-8?B?eXhUbHN4TVhTOExteFFvNzJ1UXlDR2o0NDZVYzNrdmxsbk82TTVCUmV2bHV1?=
 =?utf-8?B?ZmMyVEZJQkkzajNreHF4ajIyaDJIaWZ0UU5MU1Vlbit0M080OTB4TXJoSTRr?=
 =?utf-8?B?WWZhQ20rZlZqZmRsTTBUY0ZkN3A0a1VxYzBHeDNRVTh0VDMza0lHUDgrak9w?=
 =?utf-8?B?YkJBbE00RGs2S2RNZWFIeXhyek5UL0FWbCtNa1oxVTFPTEswdVFKdFRQVGNq?=
 =?utf-8?B?QzVpdVBCK25JMmtGVkpjU1lpS25LVjB3VWFKSUU4b0t4MEJLVzBuaVVFU243?=
 =?utf-8?B?YXNDTEZzcmZJU3pZZDJab1Z5Y3NDS1JuQ2c3bFo5MXlDcFVpS3J2NC94cWsz?=
 =?utf-8?B?RDB0U0pTd29FUGxkK21BUDF1KysyUkUvcldRV29YWE95cjI5NEU5TWd6Y1VS?=
 =?utf-8?B?V21oREtjVlpXS1VnN25CSkcvSkJLbHJBZDJEMm1LTzFibGdwRlJLdWdKcDVu?=
 =?utf-8?B?K1E2MFBnanFyMnVUNVJvOGxHMFVVcU5GOWVlZFRSczJIWVVZUHhGNHNlMmw5?=
 =?utf-8?B?Qys0ZU1nR3ByYWU0dGRnSWdjOUwxbWhidGF1UDY3SVN0Q1dBNzkxeS9PUEN6?=
 =?utf-8?B?RmR0aFBlZitBZjZTaTVIckNVSkRDbXpyZ3RhL2VrYk1sWEpKQU16ZnZ1aDYy?=
 =?utf-8?B?d3JKRU9lS2w5eUd2aXVJVkNHNG9tR0prTzRJUzFlb2NvSFpVakNIYnVkWXRG?=
 =?utf-8?B?QUp3L3BKUDVOVC85TlZYYUNaT2s2TVBuV0dhVGdBSUpqb3R0YWZmN0swTmty?=
 =?utf-8?B?Y1ZuOHNQN0tSTUx5dWNRMjVZSHlPMmNjek4vYzJEOFNTbnJFUk5iTWRISTZO?=
 =?utf-8?B?cmE0bTJkR1h1SEZ3MTRtS2FCY3JRY3JEUmlSbE52c1lpSE9BZ1pUcU9uWXJM?=
 =?utf-8?B?MU55RW1pc3ByZWJEazhPN2ZML1g3V0JmRU5ySk82dERiZVlwTVo4eWprOXRr?=
 =?utf-8?B?NHBZSDJrclhJdXB5MVNXbEFOSTVIejNXamhIT2ZCWE1oemtUUVdsdGhlR3A5?=
 =?utf-8?B?OVhuNEVuckR2U3VMam01WWtGMXNFKzRrZEtGNnorM0VvTzVNOGo1a29VUHNC?=
 =?utf-8?B?YlBETkduSkJzbWZ6YlEvMXNYZzVMeGlHcWxWbDlDTm1tUmRaU3BUaWgzWTBo?=
 =?utf-8?B?Vk1VSnY1Y3dnYTNpOGlIYXk0YnJXSSswYjY4V0gzaEh4d2FlWmk2T2Fmb0Zk?=
 =?utf-8?B?NHdnYzJxNldmMmZnbkJjTVVpZkJkdGVZS2dIZU04MGhhTHl0bDBnVS9BTDI2?=
 =?utf-8?B?aEdTbldJVkJIOGl4VEk5N0Y2dUVGMkF4UGo3dkJocEhydThhOE1lbUJGZE53?=
 =?utf-8?B?aFE5S2t2WGpNU2trVlRRSUZyeDc0M283dHFtdFJ2N3JtcGZQUEUzU2pNQ3pB?=
 =?utf-8?B?U2RjWm9VRzVZQkVnREowQVlZT1JEYmtUUzVaSE53MjFuc2lDbXBJQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6b027a-a1a1-4223-af0e-08deb8c617d3
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:27.6630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZTGcbiDz5hJFoqn9CSnVLQaxuS66lI+c5qDIqtVl+C2rGYaA09k9gAcADCc8OoBy4GRvlmGwEfLTGIlAUBkRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11708
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

From: Peng Fan <peng.fan@nxp.com>

Enable the live DT to reduce the DT parsing time.

Test data on i.MX8MP shows that boot time is decreased by ~%6

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 configs/imx8mm_evk_defconfig      | 1 +
 configs/imx8mm_evk_fspi_defconfig | 1 +
 configs/imx8mn_ddr4_evk_defconfig | 1 +
 configs/imx8mn_evk_defconfig      | 1 +
 configs/imx8mp_evk_defconfig      | 1 +
 configs/imx8mq_evk_defconfig      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 953968c9092..33c1ae625a4 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -71,6 +71,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 79abe3bfeeb..94174916786 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -59,6 +59,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index 63e75aaf7a6..033d1670d47 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -62,6 +62,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 152f04953f8..b7bee8cf276 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -80,6 +80,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 7af538ee367..d176b42e83d 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -75,6 +75,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index dd0c615032a..d041fbd8268 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -70,6 +70,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y

-- 
2.51.0

