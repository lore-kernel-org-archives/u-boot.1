Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9029FC35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E59C581DED;
	Fri, 21 Mar 2025 08:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TEdGLW4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF5881E0F; Fri, 21 Mar 2025 08:16:54 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C3F81DDF
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzbTgN+JNHJ+UHoxY/hWQZpkAehv/dshjGX5uW6R5Ge3HRGip10fwJWAWuOl/L4kE5NSNElWW7VIVXwYOIId0Pti8C31Z0NFNnc44pmyhI6ldOWEN5jRxHPMRGPHjF+E37wrCuCqUBn8RguVi4VG6qEYvmuleeu2h0A35fL0Om2k3Vm+srReesbg9q45km/ORpDXaUTuFPVh/GstIcNI888rfZGujRQgwMVIZh/Zaz9yMw78C9gJkBaUIYOIVDtuwDwv9YR7lGyRH4Hv4dW0mj/udrO2hoWsxi95lNKxQCHgFMmN3TxBSJfxjHnK1Qv2TBurP7moljSLL4IKBoLdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxbmFGikrC0Seg10d1+RUdjxqL5GkJvR7SGadccW8k4=;
 b=DF87x32lpDv7tmVEEbqbRKboLKv8xfmsbm4psL/c3f4XMM7BsCu10nfkYuk8IUCuDdbxFbB5bl7vg6U2eXJwKIyIM8v9fTp7gmwQ94r+lOrZNZeAo/NhzBuqno3ZcDRkDvTGPdDrYwxUOFCiBvQKvsMIhf6jmWSOaQ3uLe/FLKF8YjjUCaDIMWkZ5CZFcMrDINEV8h987vNxMPOnus27S2yLPLLLF7VPRXyea1deoVJ/oD+rE30LH162uBIZ1E0jE5mqfC2xd3JnW3rlXMVEiPuBL6psCb373fLpgBaOlo/KfhU/H1wrUcJ5GGafGzk0mLD8sBEsvDJbFb+z+EivsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxbmFGikrC0Seg10d1+RUdjxqL5GkJvR7SGadccW8k4=;
 b=TEdGLW4/5PG74sustvcMFUqN0Ot8WMw+zcG4x+pxyU7370UVzhu7Fc5UnzXKZijxC90w7pgYazW7rH+zGpbOKe1hAX3MPG2LScFpPJ5VVo5jUhbskbVY6sxW14RovM9mKS6AKtjMPiVmYXrBuZLvKXEorOIrgyeYHsrKkfYyOw6mDhGzPwUu84mkesVhD64T6JIdBGJvQ5arML37Vw7k60zzoMW36X1w3md0MRewGIZfIAmlbVIgSE5KsTYEBfcL+mZVC4bnoSD/WbZ6xtZ2q9OAkWDIuuanqrJf2Qs740A83Hz8KR/TRgJs10FAYFclFSFrTWm5nxlwNp9scVCukw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:51 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:28 +0800
Subject: [PATCH v8 14/19] binman: add a new entry type for packing DDR PHY
 firmware images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-14-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c30a7cd-8c82-4e51-4faa-08dd684859dd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzZlRVdSWEpZZFo3ZTZsV0x1cFFnelZaVkYxTktVbCsrSC9uaXV6K2lOdDVB?=
 =?utf-8?B?RVN3ZldVcXgvTnQ2a2RuTEx6cGRwMHp4WlAyaURGb3NZNk9FNlZUcHBQMTBW?=
 =?utf-8?B?ZGdvLzNqRVppOVM0SFl5TFArVk13UWcrN0ZwYk5jSEpBQ2hRWlpXUnRTV0RO?=
 =?utf-8?B?eGhDNGxkejltamtQK1lpaWJ2SkpoYTZQL1BYL2tVMERXRGRiRlMzdm1nRCtx?=
 =?utf-8?B?cHEwZFdHekRkcTZjYzB2Yk4xOWgyYXc4d3gvTkRia2lzRUpadjlmaUFIU1JI?=
 =?utf-8?B?ZUYvazdZNlgzZUtwaDQwQlF2MXpXVkQ2dEM1L3pVRXR4NWdBYUxNR0hsTk5z?=
 =?utf-8?B?T3FrYVRrL3Zyalo1WmgwVXFuYU9YdmRKY2JJbld0aFk0dFYzaFREajBMUzcw?=
 =?utf-8?B?SWpGM2NGbEI5Skl2WGErMlRmNVh2NlhGQVNhOFV3amQ5ajhWallYbmVOcXhS?=
 =?utf-8?B?RE9HcFlGSEo2RWI5aDlnT2RMblN2eEVNMzQzaE1CZ1FUMnB2TzRpUVZVVzBN?=
 =?utf-8?B?dXMzRmNKZFdnUnIyWjJQZk0vUkdzQWZGVUNxMUJpN0lmMjNwWXBCcER0cFVT?=
 =?utf-8?B?TStBNjE1WXFYdlhoV3FKaWVPRFpabGhFUE1QbElOY1gxMXFmRk1RYXVZdVFM?=
 =?utf-8?B?STR1OUIxZ1dxTWJXeTNnVklxRE15dTFTMFEyUDVoczdDcjNzVktMVlJ5bzVn?=
 =?utf-8?B?YUdBeWw3TlRxVG8zNmJIUUhVemFHVTloam1CS29aamc2ejV5dUdOSDVGZjIw?=
 =?utf-8?B?ZjNBZVpUZlgwM3d5YXlFSGlYbjlHeVQxdjhqYTh3S3RtbDZxa2laYVR0ZzRL?=
 =?utf-8?B?VFlHMXFFcjR4ajhyTlZySTZTMmNVZ25MWkpLQUVOeUw5QVVFaW53YVo0MW83?=
 =?utf-8?B?MTdwOVB4MXlleGt0Mlo3b3R1eWFCRGpWRmZXRndVYjRURW1HMnVhdlh1cFNt?=
 =?utf-8?B?R2tFSVk2NGFvVDhUd2xNdWI4RXVCTzRtZmZURjM5c1ozV1I5aXNuWlpXQkdL?=
 =?utf-8?B?T1k0U1h1OE10ZUpNWkhqblhkY0tKcTV3WjZWMUhDaGptSGp5Ym5wUURwS2JI?=
 =?utf-8?B?L3hKYWZwWk8xb2d6eTd5a1FlSTFEL2JOTWI5VzVYNEk3Ukw0QVltNWZQM0lI?=
 =?utf-8?B?bWJSaWd2Z2RBME9sTEp1b0F5Ly9sSjc1bUYyOXBEekIzS3B2bnFSR3NkanI4?=
 =?utf-8?B?c3ZGaE9uT0V0bU5CUW5Oa0VJNm11VFUydDVkZXEyZG5yWkdzNzNYbFd6dzhE?=
 =?utf-8?B?RU5vTnJiamlNRXd1SU93R0dHcEdhbDRRckVRSkVjM0dDVWNIQUJrODBtRjBT?=
 =?utf-8?B?aGV0VktpWTRMMWJXOEdsU25PRDdYUDRuMWt0ZS9SRjNLRkxLZzl0VTZMVFVv?=
 =?utf-8?B?T1ExM2hFMUVybUtyOGVRODZYdCt2YSt5VW5TTml0Q3pUTVRtZzB6OTRRMG5T?=
 =?utf-8?B?aldIU2JuaHl0UC80ckxEY1FldWxZZUxjR0Q4d1puUVJBZFNhZmNYTVVralk0?=
 =?utf-8?B?MnlZZG1xS3JzWm9mMkVxbFZjeFNyNWFXSFRjUDFSK05yTWdaelFCUUluRkow?=
 =?utf-8?B?aEdPSG5Wb0tZYWtMQmx6L1hkRTF6QXdCNGtYQndieWtXNUVEN2VFcXkveFBN?=
 =?utf-8?B?MW90bFloTEM1bVYzWGhwT0lzakdMTlpXdTBEUlJQZFhQdExBTjBrd1JndTZV?=
 =?utf-8?B?WmZFQ1o3alEvS29Ob0MrSzJYRTF0dGl2UlEydE42UVVUYXlLN0NYZURXR0NF?=
 =?utf-8?B?a0xpdm5FU0F6WWZuRnc5WkhMTWJ3dzhrRGVtQzNoVzlaaUFRU09DTjZ0RjV3?=
 =?utf-8?B?bGFieTljdG1nWWtGR2lac0x1VXphUXlvaUlMcVlsQmpSUnZuNXE5TzB5NjRH?=
 =?utf-8?B?Z01GVjNVaGR6VW9aOEdvazZ1TXBLSGl3elVTRlNIODhONWFZTDBibEh3ak40?=
 =?utf-8?B?bVFPOGtGUGV0b2lYV0dDREFxMUdETEJQanNBeVRzUnM2eG04WHNVbGh3MG9N?=
 =?utf-8?B?aksyNDBiNG5BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3lKNWNlOUFJa2VEalpDbWdyMDM5K0R2YUtyV2pIZTVDNEtQVjcwb1YzT3Bs?=
 =?utf-8?B?b2tIbnRWMldyaWoxSUtVNFlYTzRDWDB2SGVjQnoyTUs4R0w0dWk2dWt5TTJB?=
 =?utf-8?B?b1pGamtlL1Rwd1hRWFlPYWFuN25kQVV4bXpuN090eXAvd0JTK1Mxd0VWdzd5?=
 =?utf-8?B?QzY1YzZySXhoWDhGNis5ZnFaNStlU3dhRVpvb1lYZEEwTGNENGVMT3d4Z3pO?=
 =?utf-8?B?b3Z2UlBVZERaOVVSRFFKODJON1RMZk5hL2VJdXEvVlpTVFY1VEFzWVRJQXJR?=
 =?utf-8?B?RzNXUERGQ3N1SVowaGpXYk1YTFh6RTJOMGZpRExDZGI0dXpvZTBFa1lQTFVM?=
 =?utf-8?B?SHFxdGtRZ1hCS1Byc2duQlp1MXdiNkJBejZSdTliQXpwbHEwYlRqNWZrQXVq?=
 =?utf-8?B?TkhIejFmUmdxS1FBdUhCUlhiVTFndGpIVGVJMzFKV2ZiR2xacCtuY1hTbTFD?=
 =?utf-8?B?WVhaYnM2UHJKV1FHTHhNWk9zWWl1bTN2akpyNEhGSnNXY3ZERlIrV2MrUG5Y?=
 =?utf-8?B?dGhIT0dNWVVydDhuYnE3N1ZnTm9OS1g1RnBSYzFET1NxcXorcEhJNEdvc3RR?=
 =?utf-8?B?UXVTMUk5UGxPM0VlcFFEZDV2TWpkMlBWSENJbUdpbWVqeGNxZWlURmxXMXR1?=
 =?utf-8?B?NmFEang5RVpoTjk5cUkrWkJlQzc0VGsvcWpIdXpGcStYZmZybk1rb2tVQ3FD?=
 =?utf-8?B?QWdIZWYzZUZDb1V4amIyTmxvVXBwMnVTZnJOUjQxYkNWQ1ZGcStiYm95Q2Iy?=
 =?utf-8?B?MDlnaWpDaHdxOUx1RldtVnJDQUFkUzJkNTJzTldQZElpRlJJSDNuNnJ6NHRa?=
 =?utf-8?B?cDFBMHRzYmRQV1pURmcwcUJpY3k1bXh2L3BrMEFqYm1HcUZTNXFtMkJrRmcr?=
 =?utf-8?B?VG1TaXAwWWJTbDQ0L3VtbkpKd2d4RExibmFNTVpLMzNvUkVFSW1YSkNtTVdh?=
 =?utf-8?B?VmZSS2IrMm1MTWtLYXVReU9tQ2pUVlNudUJhWkp1UVZFbVE2ZTZLUEZTMTQz?=
 =?utf-8?B?ckZCaCtUdE5maWh4eG9hamswM2d2aVZ3Mk5TcXYzVmNHeUdhT1pXR3Fsd1Nj?=
 =?utf-8?B?YVZvUEp0U1ZtT29UUUpBczB0KzFJSHRkZlJaM3AxNjlMcmkwMnJUSWMyZ3Jq?=
 =?utf-8?B?WWZuZHBLa2NWWjkxYTB4NFIxbjYyVW0zNUN1WDJMUVJoQ1ErZ2FwcnM4QW0v?=
 =?utf-8?B?OGxYQWVMWWVVa3R5RlcyN0R6RktwQVgvVXd2VzAyV25CUVFEUGlmVWdjaXg0?=
 =?utf-8?B?TzBNbVEzejFHb05JSnhyVFdXM01oRnBvZ1dDa1E4T0Jrd3ZSWk9pRnVkQlRG?=
 =?utf-8?B?VUUzclZoMHQ3Q29Ccno3NTNRVXU1M0JFMkMxbVJsTkp4YURKejVla3JQcTNn?=
 =?utf-8?B?cFZlR3BhOGU3SEdJdFlHQnFSVXpxTXpBcFNBQnVZQzhZeHg0ZFp5M3BEYkpQ?=
 =?utf-8?B?WHdJTklOL3B0UmxkTmV6WElaNU1KcmpIc09FTFlqWEJ4R0MzTVV4cmdtb1RQ?=
 =?utf-8?B?aTFvaEdLYnJyQWVGZnRpdDFCbVp0bEtxT3FVWnBGVExack8xbjhYaFdEYXQy?=
 =?utf-8?B?U2hNdzR2WXdIUCtTSVIxaUdMUmNBV3N2OTR4TW5ia0RPU1JrYlFDcWR1Qm82?=
 =?utf-8?B?SzZoWlhyRDFtZDhjRUNUdXNOYUFncHBOSnMwYmk2MVpTc0dwYWZPT0NVcThD?=
 =?utf-8?B?ajZGU08ydHp5alZkZjA4cUNSTDdkNlRsM2FXelFMZ3BMMGxkNnlJZTI2b1Jr?=
 =?utf-8?B?dm5KT3VQTk5zbWx5TU41QlZWTVZoeXhIOHpKSmVzcFpsOTVLZjQ5ek9EVjJl?=
 =?utf-8?B?M2xqU3NBc3pJYU94M1FOUnpGZnRBRDA2dEthYk5aSG12dit2bjNVQkUxUkM1?=
 =?utf-8?B?VVJMWGErR2piTlhIWVJkSDMxblJzaTd0dUJYWjlpNGxXWE84Y25UaGpheVVW?=
 =?utf-8?B?aWRxNS9kUG5ENExLSGVQdzVWNXg4UjlwWHBsSnlpVmd1bkYyYTlBMUl0MmNB?=
 =?utf-8?B?SWpvUUdVRXNIcFcyejlNNDBUK21FK1QzcnhneUtGbkZVMm43ZWF5UUFTbXVL?=
 =?utf-8?B?TExqQVRZWmNnS3UwRkpQQnZCZTRhSDJRQzMybWhEMjlmTy9uZVE1ODNESUti?=
 =?utf-8?Q?UIASbU/4zb+Mued8t7P2Ya6qk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c30a7cd-8c82-4e51-4faa-08dd684859dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:51.2381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suVP02tszT0hz7V9w5uBg+2NgqnalnjYHB/x6OUiiGX/el/ezRQBdnFaSP9eUpqRWq5Uoi5QLx/ymKrBOGO26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421
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

i.MX95 needs to combine DDR PHY firmware images and their byte counts
together, so add a new entry type nxp-header-ddrfw for this requirement.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst                  | 10 ++++++++++
 tools/binman/etype/nxp_header_ddrfw.py    | 29 +++++++++++++++++++++++++++++
 tools/binman/ftest.py                     | 11 +++++++++++
 tools/binman/test/346_nxp_ddrfw_imx95.dts | 24 ++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 780e9817fb6..4f05aa0a323 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1663,6 +1663,16 @@ Properties / Entry arguments:
 
 
 
+.. _etype_nxp_header_ddrfw:
+
+Entry: nxp-header-ddrfw: add a header to DDR PHY firmware images
+----------------------------------------------------------------
+
+This entry is used to combine DDR PHY firmware images and their byte counts
+together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_header_ddrfw.py b/tools/binman/etype/nxp_header_ddrfw.py
new file mode 100644
index 00000000000..655699e6ffa
--- /dev/null
+++ b/tools/binman/etype/nxp_header_ddrfw.py
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+from binman.etype.section import Entry_section
+
+class Entry_nxp_header_ddrfw(Entry_section):
+    """Add a header to DDR PHY firmware images
+
+    This entry is used for i.MX95 to combine DDR PHY firmware images and their
+    byte counts together.
+
+    See imx95_evk.rst for how to get DDR PHY Firmware Images.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def BuildSectionData(self, required):
+        section_data = bytearray()
+        header_data = bytearray()
+
+        for entry in self._entries.values():
+            entry_data = entry.GetData(required)
+
+            section_data += entry_data
+            header_data += entry.contents_size.to_bytes(4, 'little')
+
+        return header_data + section_data
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 1a92a99b511..301e4927886 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -104,6 +104,8 @@ PRE_LOAD_VERSION      = 0x11223344.to_bytes(4, 'big')
 PRE_LOAD_HDR_SIZE     = 0x00001000.to_bytes(4, 'big')
 TI_BOARD_CONFIG_DATA  = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
 TI_UNSECURE_DATA      = b'unsecuredata'
+IMX_LPDDR_IMEM_DATA   = b'qwertyuiop1234567890'
+IMX_LPDDR_DMEM_DATA   = b'asdfghjklzxcvbnm'
 
 # Subdirectory of the input dir to use to put test FDTs
 TEST_FDT_SUBDIR       = 'fdts'
@@ -202,6 +204,8 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('fsp_m.bin', FSP_M_DATA)
         TestFunctional._MakeInputFile('fsp_s.bin', FSP_S_DATA)
         TestFunctional._MakeInputFile('fsp_t.bin', FSP_T_DATA)
+        TestFunctional._MakeInputFile('lpddr5_imem.bin', IMX_LPDDR_IMEM_DATA)
+        TestFunctional._MakeInputFile('lpddr5_dmem.bin', IMX_LPDDR_DMEM_DATA)
 
         cls._elf_testdir = os.path.join(cls._indir, 'elftest')
         elf_test.BuildElfTestFiles(cls._elf_testdir)
@@ -7845,6 +7849,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that binman can produce an iMX8 image"""
         self._DoTestFile('339_nxp_imx8.dts')
 
+    def testNxpHeaderDdrfw(self):
+        """Test that binman can add a header to DDR PHY firmware images"""
+        data = self._DoReadFile('346_nxp_ddrfw_imx95.dts')
+        self.assertEqual(len(IMX_LPDDR_IMEM_DATA).to_bytes(4, 'little') +
+                         len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
+                         IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/346_nxp_ddrfw_imx95.dts b/tools/binman/test/346_nxp_ddrfw_imx95.dts
new file mode 100644
index 00000000000..889f6f29860
--- /dev/null
+++ b/tools/binman/test/346_nxp_ddrfw_imx95.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		imx-lpddr {
+			type = "nxp-header-ddrfw";
+
+			imx-lpddr-imem {
+				filename = "lpddr5_imem.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr-dmem {
+				filename = "lpddr5_dmem.bin";
+				type = "blob-ext";
+			};
+		};
+	};
+};

-- 
2.43.0

