Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48964E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 830988036D;
	Fri,  3 Jan 2025 07:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J4jKX0i7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88AA8802EF; Fri,  3 Jan 2025 07:46:39 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09D0980488
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljSufb2fdvgwkoD0m7K6mUREbZGpQKeN6XiHl06E2/LJUd4pJ9FLMT+qIUMQ7w4ORUBSpuGzTL9RsabVxbWx3Qih6wwHCp5kXmCew5h8b/7TpMJ6FEcrW/Pmf4X2JIef8zd2zNwhFJhhFNn1fwaTuaF31pPGz4VMKcYCetdl6jS5T76raE7aRrf/Yn2fsKqE9Nr3/C2Ti6Tl7XH/ZXH25g/rEOAvYwxLMqFoVK0G69Iy3/0vwLENKvd3Kf2jukYtbwVT2QFphrv5Nn3zvgFZTegErlYiYyeScQ3iuRCoKfEd/VLBv52TeeGV9zxtI17eJayfeKI4gRTqZyKwccaNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PlpvLAxTAULUrPSb3ZWMZIvd7WBcU1v0bnMAS/KeaI=;
 b=K926Ke/M1a9qoXjyXsMAxapYHthiEVRDtfDjq9SmViTu/3TOoXYlh69Fm19pd6UnTxhHHoskyod7H4Owf5epJCtbpWpb8CR4+p5ooqFwc5wABFO61EJ0Sp9e/wUaH6vVG1baDR2HeBjJAsQ5DY2bWHpLKDWx53ofIOVMv+Bu54Jqd7Ln5YGF50H5AyykIPKi1VRHiq5HfW2thGJt5bjDL6QOStPLNoBVhVLIsZD4F6lkVTGt2QjhsCoV8p+vemIQNFmb/jrVVB+TDWfCessD6++OjqchWKBvZlau4bKn6iAd6QOaBT9aTTC7CN0qTXq3xhdVwojILJ11JfcwGiSDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PlpvLAxTAULUrPSb3ZWMZIvd7WBcU1v0bnMAS/KeaI=;
 b=J4jKX0i77wCRIBbCyAJu+So0dVXRjxvspiHIA+EmOh5PtFkrFxZlEJANKNYVopR75clv51HZz5qnAnvEcFtVJxcMgr3YANA3O9g/kcnmxih/9eJWhJTtBHPDCLStKuQYshVySiu54nA9A2Fc2YXxqgMTBgjzrG4Bu/4JSsjlWdreCHTmRFddULE29jjgUHqGpTldGPD1QTuKmmzpWQO4bDUf3sEwOldqgi+G0EDkUjYahmELq5Q4XbCv56I7IDJ968xwcD5EljL2EPpvwYX//iH58krKOYWDJ0KbSvmOmylrWPkeyMxb/NyADswIR3evKCVOFofgFxbJxlhpczZiRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:30 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:30 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:45 +0800
Subject: [PATCH v3 10/17] imx9: add i.MX95 Kconfig and Makefile
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-10-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=1502;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=A8qS/z0irg/nqhLvjupt+urYvtM8hKfTEAor8RbJNW8=;
 b=zLtkgWzo8mIDsKGtNj7yVqRqQBQljPSCvEbJEPfJgRAuafO8IC3pu9yT3etmi5rKPDjUAqq93
 atrtmw9B97UDJ6jCCsg6FmaWz3p6mMa0aGjckD3+cSHNsTettkAgsFY
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c73bdc3-d3f3-4213-49d1-08dd2bc25ac7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTVQbU05S3RUNjFwdElYb2J2Nk1oZ3h2LytaYTYwRDFuWTBJSk9aNzBlOHFO?=
 =?utf-8?B?b0VaV0hTeTFQazg0VmNEOHNvdXpVZGJacWpDYnBOZzRJY3BqSHk2TFQ3cTRk?=
 =?utf-8?B?b01tWHFrRERaNnp5clR0ZGltT1JiV1dpTGE0QXo0alpBaS95Z3E1UjZDb1Mx?=
 =?utf-8?B?NFljQ2pseG5GcXBwd3JkMEx0allxejRsZkZiZWpMS29obUtDNUVMT1pzelNV?=
 =?utf-8?B?d2NRazZmaEozdlR1Rkh0S0pxTTdLak5lSVRQUmpmR2lZeFhDUStReElxNFE4?=
 =?utf-8?B?aXpNdEVTZVJPZU5oWi9HODE2WFl1TVVTUHdEZTJjMDlQQnFEb0E0bDk5NTJh?=
 =?utf-8?B?UlVKbUpla0pCc0d4RnJOcDR1RFBscXRSS05UblhnbjdTT2JpY3lBc2NveVVa?=
 =?utf-8?B?RGxabWlmZ2pDQTVnSGRrN282ZDFYQVByMnA2RHVwQ1FTSVhtRzRRMytTUjcz?=
 =?utf-8?B?QzQ2OTVXM1VtOWloWGFLLzJLbWwyMU16NmZiUm9wRDdvanZhVTJILzBMUWYv?=
 =?utf-8?B?bE8xSzJCUWRlajh3NlFkblY1VUVQNG53c3RNaGc5T1Vtbkg5U1U0akVmOXUr?=
 =?utf-8?B?Z1JmWlBzV2xWeHhYVzAzUmtqZDRPeUJXeUtBTEVHRUJrT0hFSU9qYU5iTk1W?=
 =?utf-8?B?SDRDcm5qZEJUMFYyanNmVjFHeU95Z1lvYkEyQ1BCUHJaYyttV2NlbUcwUm5j?=
 =?utf-8?B?V01idTZ4S1BwT1BqYlZmQnBCMUEzWU1CT0hoa0k0YW5LcmRHVUgvbkNOenJZ?=
 =?utf-8?B?UlpRblcvNzlJeHpyS1M2TnJsa1lOeHFTZGpML1lMZ3RYbFRQNWovanZ1Q3hJ?=
 =?utf-8?B?aWIxbXc4eFVTbVRYQnl3Zk84SDd6dVBLNCttWDdsVGFVTjNDSTVDVFpBOXdU?=
 =?utf-8?B?ZUxCNWlGNHJ4R2FZNm83QXAxYmEyQm9VanNHZk5Hc0VPWmJJSENUU3RRWWQz?=
 =?utf-8?B?d29SUUhaY2I2UW8vNGdEbTdJazdianlmbTUwcCt4QlM0R0NrUHJRQ1lVV2NZ?=
 =?utf-8?B?b2F2QkRYemp2ZytFbU9KcEQvNmYzMGYyL29XSEpFQkRudDlHVjRhbzk5VUNG?=
 =?utf-8?B?bWNHaHlvTWp1eXY4Tm80M2MzaWJnays0WkVMV3RuOUI1bng5ZEV1RnF5YlFa?=
 =?utf-8?B?UC9OS3pDQkwxOHZtUVVod2FzendFRUU1ZWxINFdGQ1VUcmZxVTNKV0c0cWpz?=
 =?utf-8?B?WEtIYlQ4OUNpS1R4eVBsQ3c4MmFvL0YxQjNqSUo4TExVM0I2ZEdNRWxTQ24y?=
 =?utf-8?B?Q3JOUjBxZUhGaWcxTERhOC90dG5hVUNYSHBRSy9uK3pmUDdTaTZ5WWY0VUZT?=
 =?utf-8?B?bW15bkJGOS96WFRzSWtlbXBxdUdHWUMrMXFVYUxRTkFva3FtVlEvRnlRdVFk?=
 =?utf-8?B?K29aUEZzZktVNzAvdEF0Z01Jc0xsY1VDV1h0aFlpb3JPbXhmUFJIcCtpNlpZ?=
 =?utf-8?B?M3U5ZFAxTUFkUEdtQjYwNy8vUmMwU0N2WnpmYzFEUTVIYWxMKzRsNFJWLzZn?=
 =?utf-8?B?TFg0Q21UVjBpanp5eXZhK0tqdGJFZVozN29tZEREVVVKL2tBaVJhbTZ6V0xU?=
 =?utf-8?B?c3JuQm81cWdrOVh4SEdDNng3NVR4VzFsMmVuUktvMTBORWhoMUIvb2l5UFU4?=
 =?utf-8?B?d1NEb3hlV0hFTVN5b2pmNnM0NjEwTXRpRWZDRXU5TUgydVdlOVBQcXR6Y0FC?=
 =?utf-8?B?RzR2d2t3ckhYQzN0R0FKS3FjdEQrY0Y4c0xtUkpneHF2YVVjZVAxTHQwQWZU?=
 =?utf-8?B?RmgrYVJzbG96SlpXSnAwSmRKaVRUalZ0TlZJSXoxT0VybEkvQ2ExRU1kWUhT?=
 =?utf-8?B?akZHSWJHVXowSm5GK09PTzU2ZVJ2YWgwekpRK2Z2NytuN1haV0hnZ3VFaWl5?=
 =?utf-8?B?NXdSVkdmV1JsamJzeEg5QndYWWZnQSsrTmNLeXNWc2hDWFpzb0pCMlp5Zjda?=
 =?utf-8?Q?WdTVXaufAtJOmF/4T7tpTL7JC6ARKAuj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlQ4bi9QRS9pM1EzU0cwelRaUFNBUE5KdVNuMzNoNEcyRlRIQ1g0L1hSM2tM?=
 =?utf-8?B?ckxGMVE0UXp4T1JwZlRZY1E3cEJ6NzMvbmxjUXBaQTN4MjM2RHJsbUw0NGtZ?=
 =?utf-8?B?MkVsR1V1ZzFvQ013cHBhY1BLTmExMXN0NmJudVozMTdUVlJYN0lEcEFUYyt1?=
 =?utf-8?B?WStzMFNGNXJUL0puamhISXF4ZE5OU3YyVmRsUkc4M0hGYXZSdGk1Qjdsc2Z1?=
 =?utf-8?B?eThmS1J3WUNoekFyVFAxS2N1a3VxR3R1TEhGNG5NdGZDMWhWSzBxdytzeE5n?=
 =?utf-8?B?TmR3alQzYU4rdmg3QXRyNTBzbFU4eTltMEpJR2I5ZjVCWVZ6aElGQ09mVGxP?=
 =?utf-8?B?QVN2Z1pUQWh0c2FxbWc2V3QyM3QzWWVraGRTVHROUUx5eFZLQ3BBWnJDVWkv?=
 =?utf-8?B?Uy83SVpMN2VuL2NLZElkYVFyc005NFZHSWJKbGs2cXdybndXdThGN25weVJF?=
 =?utf-8?B?SE9zTkwvWVZUK2JoeEc2dWpzb1QzQUdYZGozWnZhaHU5TE1mMkhyaFNRajB4?=
 =?utf-8?B?SWJ5cDRwMW9XeHRiNmNFZ0lCOFdoSWdCcjBsVW03ZkhEVFVCQW1EcnpSNUhq?=
 =?utf-8?B?Nk5KWlFwWjVNMEZTMWc4V0d3OUQ4TTRLZUJMaTd5eDVRVjlYMDNRYXlWWVh3?=
 =?utf-8?B?emdsbVk0TVg5WXNjR2JKNndWaVhzV0Z0ZExCL29iaGMvV2tFUzFpSm9oVXAr?=
 =?utf-8?B?b095djVQUUdqWXB0Z3IycDB2WTl2SXQ0VC90em5XbVJ2bElBWWVzT3ZYYkQ1?=
 =?utf-8?B?Z1RMbmlBNzlTRGdmWFhKQkxpT1RtMkVaRHZCRExFVXhuNVZZLy9sdlZkRElX?=
 =?utf-8?B?Zk5rZ0ZKaDlhODVTZlBhLzlFcjk3UElLWEJ5elNtT1FLM3Evam81SjNwejRs?=
 =?utf-8?B?MTVraXhvRG5SeVp1b2Jnc3hwN0ZzM01vemJ5NWNEYnl4L3RkaWJqTjY4cXV6?=
 =?utf-8?B?d3dBQWVSbFVHK0xlNzhMb1BJNEJrelp0dDh4VkpZSnB3c2tJc1RzQTkzZjFU?=
 =?utf-8?B?NmduWFdaejRPUWEvMGRWd0JYaHBDUkc5c2tzdkczTXNxMzZqbXlwTzVCTFg3?=
 =?utf-8?B?Q0hyUEdITmNFMERKLzI1cXNDQ05ZQmtlRXQ2M3Y3NWYwbTloNUoxbkxKeXBh?=
 =?utf-8?B?RmgxdVY3OEFRNUlqcUdpRHlFRDUvTmZmRkR3MjhsdzRtMDZTQ1Y3U3FSM0tK?=
 =?utf-8?B?eUpRT0E0aXhuVjMrRDZEWVR5NFIvZjV5Tk42SmdNMzRxY0h0bExORzBQa28y?=
 =?utf-8?B?dVZFT3M2RE1TeDY1c2RNN3BpaENEei9PbWJiSVZIL0MxWGVqWU52SFY2VE5M?=
 =?utf-8?B?eW9GUHNKbFpUNGh3b05BcEpXbjU3ZjIxZHgyOGhsQnpGMmlPMEExYlo3UU5X?=
 =?utf-8?B?OFhNcnVsY3h2eWtaQVVBOTFJdTdmT2NjODFOakw2WDdZSXVZN2dNK2lheHUw?=
 =?utf-8?B?d1VHQ1pjV3AybzJ2c3NDaHNYSldGY21ITWxtbDBwYmswMG1UMlBxbVdBaXNJ?=
 =?utf-8?B?dXlhUEhJcENPQUpGVVQzeTlZWkY5RmE5SWI4ekVmRlF2Lzl1MFVveTBFNG4v?=
 =?utf-8?B?TDFFRUNWTXV1SDEwUDd5eGRRR1pTNzhVS3V6N2ltUTJwdElmUkxreThoeGtR?=
 =?utf-8?B?T1loOHQxelNjUGxPaUR4RGhYSVZ0VFB5M0pUc1A3M2VVaTgyYzVKVjBwWjlY?=
 =?utf-8?B?NTBjdzJuMDVLYUFzQ05BTGZneko2cmk3ZU96aDBqTU5BdlVhTUN1ZncxSi9x?=
 =?utf-8?B?bldoY1JvM0tieG93cjF1a1hDOGJ4eTZMWlpPR3RyaEMvOCtjckVEQjllL1Zn?=
 =?utf-8?B?bHhlaE01Z1MxOW5XWFk4Y2x2a0gzcEVUVUVEa1llTlgyQVlXd1NLcnJNQ2wy?=
 =?utf-8?B?QkxCTjMzblpxUlV2NXBxclhDa3RPRUZ6dlUraDlVbnhHay9FbzkxOVZncGI4?=
 =?utf-8?B?MkpZY3ZDT2tvcUxEbHp2c0J1cjRicXREN2ErZ3lOaTBNSkNSVm04UjhWQjlV?=
 =?utf-8?B?bUU3UVNmZTdJMEtDSk1CT2RsM21YdDhtTWtmK1dwd1dxdFVVUXRIc0UwWUVV?=
 =?utf-8?B?YjlFQVVJbHM0YS8rQmxqRnlhWkwwd0hLT0dLNzhpSHhHbXVCeGN3SXFySU9h?=
 =?utf-8?Q?sMFFEtRHo2UCTtBNXeJG7QTZ4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c73bdc3-d3f3-4213-49d1-08dd2bc25ac7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:30.4088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJg/h7lQUthIz9UMfI+mbLcXGzhDnTzzx1elkDNOKQSystDRB9sjWboB6YSpPr9/MZqhfM5dxxGqpMbTh8Fjyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10903
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

From: Ye Li <ye.li@nxp.com>

This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig  |  6 ++++++
 arch/arm/mach-imx/imx9/Makefile | 11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 54c6b117fcff21be5c3800ebd1dc30f8ea12ac42..596e753f2897c11d7ca3bcc9211af786d005bfd9 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -21,6 +21,12 @@ config IMX91
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95
+	bool
+	select IMX9
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select SCMI_FIRMWARE
+	select DM_MAILBOX
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 45a9105a75a558dada3c328ed0878050da2a41e1..8d43ea2b267e2608df2e8f140c91b626dd969842 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -1,10 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright 2022 NXP
+# Copyright 2024 NXP
 
 obj-y += lowlevel_init.o
+
+ifeq ($(CONFIG_SCMI_FIRMWARE),y)
+obj-y += scmi/
+else
 obj-y += soc.o clock.o clock_root.o trdc.o
+endif
 
-#ifndef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-#endif
+endif
\ No newline at end of file

-- 
2.34.1

