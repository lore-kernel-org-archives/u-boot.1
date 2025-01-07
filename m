Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA217E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5CD180691;
	Tue,  7 Jan 2025 07:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W+eApCwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3462880612; Tue,  7 Jan 2025 07:59:21 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D99C80634
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEHE4u2ypv4R/CfFULpJPa6d4bPg1XqjVx0O545W6PrroOWciJw5igmRDTNifICBHsPrFiOs4LF8iWbOefacRX2XJy3DtmXbC5+T3rFfg3I1ycUfh7x2VsYdqaMRKk/88Vhq0397gvMI4D1P0kIlyVYaySOXM7z3mxC0djZYGTueiCC3CQAl6294bUH0IhazrQ7y3GhNup3wXp21d7GjpGwJpm5Vki0XTumMw6U+/u/Qktect/Z+zjA1pVjVQRThKqMt84z2T0jBrEXUio62wHFRrNencgpxhGYY7sSu1yyL1fyHuLBFB1TqoyVKdAJsQkfhb8s0GuOOvfQiY9esfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHjmvUq1Wqk253HLW2WCkLSN0wJGhOsfQBss6A2MwaM=;
 b=Y1fBUU39gThyPHsrxVw53SiG3vBPdA7YxkPQgummDJRSeKWfRCwdHKix26S1KYkh0WojqEYou3IxtTpYrsROhzcfYg/eJv0wbihEryYOQWciBebMwYZVYWQHNSdKWlSxIYpg0cBPSpq+bYBCjF3IwcHtU3S4AFNbLixWhvV7j3K8qmcTcrB9uDQQH0jDkDAASXvpq+3wwwHsMp/NrxFrcDF9YvP2hm4FhBNgXWiu/o7VRfBK9CZuPZJvEIuLU21UCzKx+aacHZp7c9kKzBZaez0mmKttb/r7p+DwaPmNbx+YFI2qnamcIRQMNBeyJ/1wreACA8m6sjJfxktKa0FtWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHjmvUq1Wqk253HLW2WCkLSN0wJGhOsfQBss6A2MwaM=;
 b=W+eApCwAEa/RcnZdNnYSV11XpUmu2gibOWUuJoN6SxHT70xaZQuo64K/+/2u+36gJvXIJvq4tRSCA7vYjCoN/47L2jvATzq/nojtpRq7zRGpDTUm40eJFRlCdIdUKC9glsjq8iEcY0FpXFPziaAQv5RTi8xUjSaPMfSHb9jZktxjBj/panQ9IE6z914sJLDlJb6XIxeLg1aI9OY0Ea2xG4mwFZ+omkYFyFjeL5xiZaudburJfL8B1toWZ+dtWIBSUvLcHz86sQsDwzTiYuK+kk+SSFp6lA2qEUdK/Gw638N+BxGZP7w4eneqROWzqXA62/Taaj9PcTtKkDGmFVrx4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:05 +0800
Subject: [PATCH v2 05/16] imx: imx8mp_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-5-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dddd734-349e-406a-b1ba-08dd2ee8ca14
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2lET0JuM3JtYWhjT05aaG1WSlJZMnBhbGcvWnNDVU14Z0FTSnpwbzAxN1FE?=
 =?utf-8?B?ODBlTXRqWHpwOGh6ZzVwM0NobFNzRE5yU0U4cG1IMkVoME1Ua01ibk50RFRH?=
 =?utf-8?B?cnlUS0F3REllMVhaNkkybXBvc1lIdlBFZnR6c1gwWU1wVlBhVDA4WHhYZWdx?=
 =?utf-8?B?aks0TGtVNTYza1dIN2RPMmo1UEp4V1RRSzlic09PbGxMbjFHNWJ2R0Yydk45?=
 =?utf-8?B?eUM1dTNaa212aTJZSVR0UVNheFhMVnJXbDZkNHE2aytkcXE5L0FyemNkN0Z6?=
 =?utf-8?B?SG9zM29jQkpBK2hOOExDTlRJNjFhbDJKc092UVViS2ErbXAxMkhLUnNXRmd1?=
 =?utf-8?B?NVVKOFZnM3doSGpiOWhIZEQweDkzRWs5MDJQVE11T3hOb2NmMy9LMVBMQVN5?=
 =?utf-8?B?ZDFMR250TzdqVmY3U0RXWm8rVWd0czFrYVZEN3RXamhmMmg3SjB6WjZwcW1N?=
 =?utf-8?B?eDBiVTJZSDhWc1JHNnhKcmp5UHkwSTRtSUhNNWJnNmxiRk1uRlBiWmFwRS9Z?=
 =?utf-8?B?Q0JHWEF3ajdIYkM4ZkJ2MUZXeGI4cnNJRWJiZ1lDeFdsaWg4aW5tT25vcCts?=
 =?utf-8?B?YTgrZ0NzREcyZ1FmOUVyR2JJMFltaytyQzUxMzBxUmY3RnM4bmVBYUNzOUdY?=
 =?utf-8?B?dWJmV0M1Rm5PWVJ4VDNGYnJnTFBpcGFFZVk0QmhDK1RLNzdBSlhtVjlJcXBr?=
 =?utf-8?B?Q1pRMGtZd0ZaSVFIdERoTzAzbmNBb3phTmUzejNkbGRiN2wxNGNQNjhYZGtx?=
 =?utf-8?B?L0RnV2lOSkI3cjJadlFjbVA4aTltN1dTOURxc0lDSVpPZHJka3NTOVpIOXJR?=
 =?utf-8?B?RGY2azduWXRmaWw2c2FCd0dMR2Z2QTlCL0RKOUVqUDZNMWNBLzRLY1YzL25h?=
 =?utf-8?B?K1ZBbGpJTVBMN2VLckNkNk5xNzhMTWlscUUrQldlTmdUVkwybDBwc3RkYmhq?=
 =?utf-8?B?VGRPN24weXBIaFU4dEpoZGhrZlZqemxZeU16dzdtUG5nMkFtd3pZRkNwamN0?=
 =?utf-8?B?YkNhYW9zTi90ZW84bXZkaHJoWEdqeTNLRmxLNlBGaFE4dVdOVVRpcTZDT0xH?=
 =?utf-8?B?QTF0SXJJZFZCZ2QzbEQ3QjcxVlZsUkI2Rm5zQ0c1aXdzd0lJelpwdExlOFZj?=
 =?utf-8?B?OEJzNlZnelhYQlhKTEUvb3o3VVQxTXhSUklSN2dzNlRVVWlZWTdYS0Q1MHVr?=
 =?utf-8?B?b2JDUTV6REZtN1FmUHRMTURFVFBYcVZ4QVAzVDVEWmkwc2ZYdVlpQVJMamEz?=
 =?utf-8?B?bklpWmlJQmRjL25mcktaRzNtOTFQMkM0aXowVEoyTmNEUFd5VkVyVTFHbkFK?=
 =?utf-8?B?blU1UU1aOFJqdU16cGpJeUFGaHFFaThUM0ZmTFBnV3p5ZE54TnZnN3M2YlZL?=
 =?utf-8?B?NWZmSHlXK0dXNWlxcmxUQU95OUpFd09wbldMQTFtazRYQmdzQjNBalA0Uzli?=
 =?utf-8?B?NTI1STNGV0lmUzlBZTlHRHRad2hCTnNjOFZDangydDVlZXNNVmFocXJTeGJn?=
 =?utf-8?B?eStWUjZpMzdGVE5jTmN1Z011L1NuREo4Z1ZKVjBSYzBkM1djOExueSs3UEJU?=
 =?utf-8?B?bDBMNUdma0NKeS9DOWlpSEFFQnZLUGFKSzg2aHJ6dm9jYWllUDZXNGdsZm10?=
 =?utf-8?B?TUlmalYva28yb2JpeFk4Wmo2aG02ZjBwMEUrdHlqWVBCTGFzcDBJQkVpQjNI?=
 =?utf-8?B?RTVkdkJXdXJLbFMxM2U1clpha1dobU5jNmF1djZyeGRONjJ3WUYvSlFBWndP?=
 =?utf-8?B?S3pVWG5TcUxkWWZqSVh4QVNsNUlrT1FydzFFa3FoZy9PdDRYRnIrR2dreUx5?=
 =?utf-8?B?a3dsNjVHQzVDbE54UmJtUGpuam8yN3YreTNKc0tyOHZrd2xIdGNKaTNtVHBT?=
 =?utf-8?B?UnZDaFF2dWZNMFBkcTdvcjlmV3JFbEllZXBHRXpYc0krWGtmR2ttaWlvNXox?=
 =?utf-8?Q?TDMxgCx9N2a+7ulQ2KX5jXUGsLvtEA9L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkJzS3BPME9VbTRXdXVBMzBiUUxuTWJKbG9Xa2NmeWJ1S1BNU1hibVErWnJ6?=
 =?utf-8?B?MTVXN3FEUXBBcFNuYTRGdk1nTVQzbFhMdUZiWjhmNkRhMXo1aVRwSHBTeW14?=
 =?utf-8?B?TnhOQnJhemZTTFBwRkF1U3RHWlJUZ1I5ZWU3RHRUajB4ZTVjUFhEUjNXc3Rp?=
 =?utf-8?B?dDdBZlllbzhXVGFmV2pFRXA2MG0xcHM4amVnWW1BdlNYc1gzUXdmbWhpMlpk?=
 =?utf-8?B?S0lsd0ZiL3Yxb051Y0FSU1Z5TlhveEsrZHNrSlNQOEdTamQ5TzdyVFA1T2Fh?=
 =?utf-8?B?aHV3T0plR05tTDJqcTZHa2xyVVd3UFZnM2txUXNNTGMyWkN4amc4dDljb3ls?=
 =?utf-8?B?T3grL0NjaWs4Z0lpSVQ5K2FlVlZyYTdBbkNBaFNxam9XTkxWTGFGUmxZdkgy?=
 =?utf-8?B?WDVxNnQ2b3hwTU9waGx3WmxpQk9YdjdmSm9hMW9HUitBUmh0dVMza3RXbFpE?=
 =?utf-8?B?Vmc0Z0RhS1JTeHlJM01SSjlDVVN4VHZWckFpNUoxZzBzN3A2MlNwVmJsSzJ0?=
 =?utf-8?B?Y3lJM3VPSFUrRWw3QmRVZ09UcWlrNVJlOWl4TFlwL0wxb1lUbithVEl1R25x?=
 =?utf-8?B?NFgzSnFxa3o5eGdTcnVCajFmVGV6eWlvQ3hZZE00SFBZRzNEV1Z2aVgvS0Qv?=
 =?utf-8?B?U0pzaDZNV0xjbktrQUt1S29sZTVVTGNId1ZKRzBGQmlIRVZDZG9DTVlxdGZD?=
 =?utf-8?B?alAySjlYU1V3L2xvam81RTZHTjI1UWYvbWVOdkN1RS9iTmtjdVAzSXlFSVJC?=
 =?utf-8?B?NDdDb3ZQZ3ZKQkhmR21tTXZZbTR2UWZxVDE2K0JndlFCeGxXcEd4TVY0Z0hE?=
 =?utf-8?B?MTI3ZUJVbms4UFFHK09YdUdtM3RENFA4TmdFeUQxc09SUUxJYVVFdEFScU96?=
 =?utf-8?B?VWN3SCttS1ErREhQdXFLZ1EvbnA1NjZneVhkQ3AvS3l4cXlZaVpxMURHQ0kv?=
 =?utf-8?B?UURvcmo3Z09qY3UyakkzZEl6eEIvcDBFZ1IyQUJ4b1ZwSWl2eGVsMHdPMUlX?=
 =?utf-8?B?NTJCT25TQjkwekFwN0ZKVkE0b05YUzNjZWl2T2ZTWFY3T2Jnc05RV1RoR1lC?=
 =?utf-8?B?L2o1RDUrd0dhNFJCaXEyN25DZGlad2xvL041MnNTZjBqTVlCUFNSelBFYml1?=
 =?utf-8?B?OU1OZlh5cWRZZVAwY1pPaUlZNS9mdy9UclpYTmowN1B6ZTZDdHM2Q3FUY3Q4?=
 =?utf-8?B?cHFGa1RSODVZVTdHNEtGakpIWXR0T2J4QTI0bEg5cmVJWjFWTEwwMDNvUmVL?=
 =?utf-8?B?TUxHb0xyQW01UmlxNG91bS8zUU5BTm9aOVVnV3Z3QTlubXMyczFsSnlnOGE1?=
 =?utf-8?B?QmdTUGNOK0QxbEdFN3kySjBFUFB1RkNyQVlPYk1vNlQvTVBDR1lKVmxBK1R4?=
 =?utf-8?B?QW1VaXo3WDR5d1ZieThIWGhscElVeTFwcGVlL2lJY0didzN5dXBrT0lLZ1NJ?=
 =?utf-8?B?ZTNUbmN2eHVFS1p6aG9ua2JYTVNIWHZxNmRmbGtxQURCVFJoT0R1UHd3UEdw?=
 =?utf-8?B?NDRkbWo2US9hdmRHalQ1eVhGaWhjV1pHQ0toV1RieGtRQTBTVUtkMGFQT0Nx?=
 =?utf-8?B?Um16Uy91bnFYT01PVC9RdUVQeE9sOGFrY1U1L09JSVZKSWc4OEJWS2x4L1pm?=
 =?utf-8?B?cmdxd0tqY21qMlliWHpBdlFFNHVMcktFdjNzT2dhK1pBaUdxVDRsQXB6NWcy?=
 =?utf-8?B?Sk02d1BldlhEYm94RzRPUWd2MGxSeGcwaStYSEVJZ29YcHh1d1VCZ3IzY2VT?=
 =?utf-8?B?QjhyMVdxa1ZITGNhSzJIb0QrUVAzUkRCelY0SERiNlNteXZ5VnY5bnlWdDlo?=
 =?utf-8?B?QXo5K2RoSi9SeVcyYU1WTU5xS2VicXRycXdFd2lZR2ZqYlkzWENaR3QyVnRh?=
 =?utf-8?B?VnllZXI2T25FMXRHclgwaTk5REF3TzR5VlRjOUgramZleGQzbDBCVVRNMTZP?=
 =?utf-8?B?cFVjUWthaDlHcDYvU1Zvd1ljcWlQQTY0R2FXOHg5d1lLMWNPQlVNK3JLemtK?=
 =?utf-8?B?KzNMK2JlTUpqcU8xL3UzSjNmMHZSbHZ2c3JXVUtQbFBrOGdNbEx1c2h0YVJV?=
 =?utf-8?B?eHUyOEQrZXZnL1Z6TTk3azc1MkZjWi9UQ0NBR216dk83ei82OWhFb1hPalNO?=
 =?utf-8?Q?ShIur6ZArbDIXgKc9v+Vk77nu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dddd734-349e-406a-b1ba-08dd2ee8ca14
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:11.5107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfHCz4e8FeOhnAcoP7K0YDY2vhBvrXHRZgmiovnggNL2l8SxBtasZWiRLRkDmV9ichcfFfmXs3yal4qSpIsXig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

Move env to imx8mp_evk.env.
Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig           |  2 ++
 board/freescale/imx8mp_evk/imx8mp_evk.env | 57 +++++++++++++++++++++++++++++++
 configs/imx8mp_evk_defconfig              |  2 +-
 include/configs/imx8mp_evk.h              | 21 ------------
 4 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index b254a50b091a05393d99db6000dcfcb4427dfa5f..0cf3c1baffeecc5d7475e6f7b8d77539aa9646a2 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -227,6 +227,8 @@ config TARGET_IMX8MP_EVK
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX8MP_NAVQP
 	bool "Emcraft Systems i.MX8M Plus NavQ+ board"
diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.env b/board/freescale/imx8mp_evk/imx8mp_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..18f6c6e200ede28201c95eb34c23a596e6771fb3
--- /dev/null
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.env
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_fdt=try
+boot_fit=no
+boot_targets=mmc1 mmc2
+bootm_size=0x10000000
+console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200
+fdt_addr_r=0x43000000
+fdt_addr=0x43000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+image=Image
+ip_dyn=yes
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_clk clk-imx8mp.mcore_booted
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if run loadfdt; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${loadaddr} ${image};
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if run loadimage; then
+		run mmcboot;
+	else
+		run netboot;
+	fi;
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 5369f8b84a4172434dcef142c854d06e3437caf1..2438ab5d26a7d9b335b4dbf3451520bee81b665f 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -26,8 +26,8 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
diff --git a/include/configs/imx8mp_evk.h b/include/configs/imx8mp_evk.h
index 741ee39db1a340136b57d9411d96bca995e0ebd2..dfb5cd22528ec4febee8a2fe069c17cfdd77decc 100644
--- a/include/configs/imx8mp_evk.h
+++ b/include/configs/imx8mp_evk.h
@@ -17,27 +17,6 @@
 
 #endif
 
-#define BOOT_TARGET_DEVICES(func) \
-       func(MMC, mmc, 1) \
-       func(MMC, mmc, 2)
-
-#include <config_distro_bootcmd.h>
-
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200\0" \
-	"fdt_addr_r=0x43000000\0"			\
-	"boot_fdt=try\0" \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"initrd_addr=0x43800000\0"		\
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000

-- 
2.35.3

