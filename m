Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4D6D206A4
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8D3D88D9A;
	Wed, 16 Oct 2024 09:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HHa0+t8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F2A88DB3; Wed, 16 Oct 2024 09:19:09 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B691488D75
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7KbFoVxDAFsnk6kVQ9uVMhK2gkqxcD4vodEux6SgW7D7kUM2DB9t9my3nY6+IQ84VjZxP/+odTYUYHAip8Q9l0Hdm0QFaP+u9+GOnHzW4tktmPLNoNjE2ZYn5pJUWhBcZybuvh4mhNx1N+wDti59ju45Wt/5CSQM+tUmUW9ln2pihxeEtPiJZvKWLWgmEnqq3LChpnYAP00omHqvuhlJL3jmab9yxK0hLILOiTZgn+vjVqpMtWbADpaFwB27zGidW3vrHaj5RDZb6iSpwCqNcrSvXMrVjiCnAV+YAjGT1VzlQG2pxNquBXyIXbpnXuXoEYYc9QTgtV9+9mZZ1muyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqbOh3e+DZ9lJ9katl8007z9+w/bilMQFO5QqOWb76g=;
 b=FuuPsZocIbTqN1jJs0JqQdlfCGGSIAWIfbvlOCBbhpDVHVR0SSZv+RNSMg8UPbpQuXV5YGafUf46Dkwyl5Nq+vXnxzTJhrdQO3WfdEe0KJZmuyGoFZCsDleJZK8uQt24j1nW2/F8Vv5Gx9ZayNhBDU+VjGlvfX/Q7mX4evkQRf3NrUyzvaWG7ROESrYkY16zPHbE1k/GaazwxsYHaYFPoyMtSdWxwm2dyqfAR+axVR7DA+Gr4HPB+wj053EsUN3cRdN2lY//UiI9J3DrHWUZdsbINhXlrTPtPgfivHhJVh8cKlBYqtklJ9+oJ/diQ4UYO/ltNkB5F9eqlqPJELjTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqbOh3e+DZ9lJ9katl8007z9+w/bilMQFO5QqOWb76g=;
 b=HHa0+t8PqtNjtnEJqPsXVq3Zmd02Z8sJ7NdLnPWZZadGqQx9l3v21/eB/l1YMx8tEeMGWI1RQSBLDG98lJHs+CsL2lNN5ti7wF9Ec/jI8EdSJHR9bsMhDoUBV/qYw2/ckwpOTo2O1PgZchTvQ5TVCFFmlakfrTz4OmCjX3ANwIAjPV5f3FeZ04hatPbdtSyHm4lQgjMSDhSzU7p66m4ovAgPM4WhLdfRvIUvKrEWbg/bUY4fZPT3WdXBXS9+WhUIjk22xH0VSXV73eeW1Ya/RNDng02i+j07581EQmHnC/axH/IRSywaNSRMFLoqQjUR9/EewwQmu9L2io9igmeFcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 07:19:04 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:04 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:17:55 +0800
Subject: [PATCH 02/17] firmware: scmi: smt: Interrupt communication enable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-2-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Viorel Suman <viorel.suman@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS4PR04MB9362:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bfbba26-5cf4-43c5-c1c4-08dcedb2d0ce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dG9LOGhYL2packhKeGRZTlJYWDBVUFY3MnFvckpYMWZYUEdWS3NNRzZJcjhU?=
 =?utf-8?B?YnRpMEFBRjRZNjdjOCtHVEJ3ckhFdGNWbmhzRFRPYzZEVTY0NkJLcERVNjB3?=
 =?utf-8?B?UkoxTzZBR3NXb1NZR05uc09aNWpnSHJyS2RLTVl2Yks0dXp4KzY2RjBpOFFK?=
 =?utf-8?B?UlNpcm1lUG1CK2szZEZwanBQMWxKVklIanI2Zm5pYXZ2b1lXWW5JeE9tTEhq?=
 =?utf-8?B?SVorOHZZQXJZbWl3d3Jwc0hVS2U0MDZqWnVCN2R2SXJtK0JoWkQ2WWJOTlox?=
 =?utf-8?B?cXVoUXRjS3BWSXpJOFdLbTRMWWoyS1orQ0hTSHdUTUFnam95RkpNdGYyNVBG?=
 =?utf-8?B?Vm9xVDB5d0ptSEVBZ2poODVQV3Vva3czWkYrNzZnbk1hUmhyM04yUHNYcU8x?=
 =?utf-8?B?UmhNeWtQZFh5N1U2bUFrSnBqRlFic2FUaHNrYzhjKzU3Y21jOXk3bXVTQjM5?=
 =?utf-8?B?VUFwbTJONVY0N1Jsb1cxZDMrSEZoRjl4NzdlOU5VVWxNYWg4d25SS3ZNaklv?=
 =?utf-8?B?bWdMTHRabk5uMW0xVzg4MFRsYVJEUi83OWRkN2RQMTUxNW1tKzJGRmowWnVJ?=
 =?utf-8?B?MHZJTXl3ZFM5eFF0QXd2ZGNPazU1L2JCYnBMclprUWJib0FoNUc0UkxuM1JN?=
 =?utf-8?B?Q2VpbTgrZGJ0MTc3enBoa0pqVU1zbHNhcFhmT2d2YVhCcVR3N0haUVFjazMr?=
 =?utf-8?B?S2MwdE1ubDRzQjVmT0ZYeUwrWkJQK3pmZ0FUdUZrbFVoQnlpNWdIQkYwY1J3?=
 =?utf-8?B?R2czOS9zOXVjN1NkZGloVjBSWktzdlBTOTJ6Q21heHB0V2hHSVI4ZEJWcWJT?=
 =?utf-8?B?TmpNWXNGeE1sREFQRWdJVU0yYnFldVVOVnlKaVJ0R0JjQ3YwM1VKd3UvbVo1?=
 =?utf-8?B?RnA5dTdJd1ArMTRrWjlKdUpZL0ZzWlZ3SHQxYmViUWtPMEJDb2YraHo4MEdm?=
 =?utf-8?B?dnJtc3hRZE5pV0dHU284QTJlbnN1RTRLSm5rdUdZajl1b3lpZVYwQ1F5R1U4?=
 =?utf-8?B?MTZvVGYzNk55RUJMMUhsbGNHTlJ6bXNyNXBMTVlSU2hrSVJGNjhWenZEbWZt?=
 =?utf-8?B?SnNkcTBibkpHb3lRcHB0MkxpdklsMVlDOWkzZnhZWVl4MkdtOTQ4TkFaYVJ6?=
 =?utf-8?B?ZXpjZjhXU1lVaXpGdy85NU5mUGg0OXlPbnR0RlRGbXZMWDI5V3N5WndReG5I?=
 =?utf-8?B?alpvUy9LUHkzUmpGUWphL05Kbm9qT3hlWGMwNW8rWlpydDlhN3BoZU9pQWN2?=
 =?utf-8?B?QnVHN0RYSXM4K2VVMFNCaGF5bzFrUEFMaFNFeTBrUjQ3UG55c3M3MUFZbTdw?=
 =?utf-8?B?QnZXYThrNkxQWmViUHFJOWJybFBndGpXUjJaSHJHaFJNaE1oeVJYMEEvTVBT?=
 =?utf-8?B?VWlrNVphNkJrbFRHNkEzbHB1ekFvdWZRRnRkdW14U3ZiYzZIREthbjlxNDE2?=
 =?utf-8?B?VThMdjJwNERwMktpL3BPWG0rVVQrVk9ic3dwRVZCa1VVVE9jWG9LNkttK245?=
 =?utf-8?B?V0h1N2hZQ05SVDZ0cEp5S1c0OS9SZXNkS0xqamE5eVJzMUxKMDlLK0dlaXJQ?=
 =?utf-8?B?clJnMU1pVzY4NHhCNEp2bXN0OTJBaCtSYjU5SlEvRGRQODJlYzZWN1o4M2Yy?=
 =?utf-8?B?ZmpSMkJlV1VrVTRzcHFuVU9wb1lpSk11bVptWVY1S0ZJWWk1NEVsVUhRbzl1?=
 =?utf-8?B?ZVdJQnk4YWdOcG50M2RDeWJXaVJxelFRbTZzQ25PQWhMN3lMc0M4c2JHOWZQ?=
 =?utf-8?B?UVZsVVdseGVzbTFOZ3Vvck5HaW9OSGE3ZGtpM0RJOWRrWGJOc053bFFQcVhu?=
 =?utf-8?B?aTk3T1Y0eTEyeHFiYkwxdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm5qclhjQzRpRWhmeGIxcFc3bVpNckk4M3lTM25KcVh3WWlUMDJWdHhuNTk3?=
 =?utf-8?B?ZVg5YTd5SnJJSEpCQVRiSC9GN1VsVmpxTHZrTmVRT0lDaUN4VGFwUjNyUmg2?=
 =?utf-8?B?dTdCV0loM0I1em55VkNNRTcyRnZqaVo0Z3QzdEVyOGZVSUhPdTE0SHRQaldI?=
 =?utf-8?B?eks3dlhNZW9QTXQvdW9qdDJpd01pb21jYjdPcGt1M2F5WDB2Yjg1d2ZidmlJ?=
 =?utf-8?B?M1ZxSmJxRlViUjdDellmVGY3U0VWcS9ydDBXZC9MTnIxdGk3eXJtb2g3V2tL?=
 =?utf-8?B?L1JkcGxIc2NqaGRYSlAyVkdkZGw0bE93ZU1MWFljWHVlYW5GUmtZd2Iva2Nz?=
 =?utf-8?B?RnlOdUVNd2ZHYWgxdmppNkMvNjJuaHVGNllnTUoxWG96WnpxOTZDQ0txYTBP?=
 =?utf-8?B?dUVsaDJDZWcySXRUWndvVkZvN3l4QWJDN3hKK05raGYzb1NZS3FCU0wzSXV3?=
 =?utf-8?B?NDdzdUYzbzE5VWhTL2h6czNMbzAvUnpURk9hUy9QZFkzcitEUGpWMVpqdUtj?=
 =?utf-8?B?bWpuSWZkVkhkeTZPd2F3My8zY1E3cmY0cFovMUtVbEdjdmpkSmEvOTVSOTZ5?=
 =?utf-8?B?T1poaDd0RUg2YlZaUGNPR25KUFNzU1N1UVdtaURaTnA2ajA4alo3SWhlVFZ1?=
 =?utf-8?B?MGFKQkVCeWVzamhXZ0VHbkR0VEl6ZU9HUi9iak9HQ3YvNU96NHRmQWgrZnZH?=
 =?utf-8?B?N3FmN3A4b3FjRGtpMitsb3pFZXFCVENwRmYyZnk0eDRRQ21VRldJczVKb3R0?=
 =?utf-8?B?SHdXYlVIZHNaYzJDZWthL2ZYemptcEw0UmRnRVNTZlp5cXF0Q251Qkp1T3RC?=
 =?utf-8?B?NXRpcUhpbWppWHlGTmo1ZTVPNHE1UUtMdUZwOHh2enV0VnA5eUY4emtjdi9H?=
 =?utf-8?B?MTJnbmhTK3Q4U2p2MDNkZ0ZCam5ob25WSGdTK2dDYnJBQ3VzNXprUThsajFi?=
 =?utf-8?B?ZkhEN0loSXlRRGNSY0JWYU10SlJHM2tqanAyMVpZOUJvSGczcTVLa0pSTTFy?=
 =?utf-8?B?ZWhINlNReTlNQ29SOUhlbG5CUnJCWk9BUWFYeVNVd3lwMW41RWVMWFBHRWpu?=
 =?utf-8?B?MFFJajgyNkQ2ZldPN2x2QWwxNEt2dUpPMmY4UUNUZnVQY2ptN1E2ekF4MWxL?=
 =?utf-8?B?UW5JR3FCbXpqYVp5T3lJTStGWWhaZDJOVzNKTFRRczRxREp0YS9OQ2w0UVJS?=
 =?utf-8?B?UUlzVmZMYW5aMGM4R1J2Q0ZKZFpydmFLK2tiWTBsVWlDOWVVeExZZkhZcmlK?=
 =?utf-8?B?Snd0WlR6ZEdxcTJFR2RxRVkyajB3UjJmQ08ybUNFQzVwa2lYc3FZU0kwdTdG?=
 =?utf-8?B?WXZ2RGVUcUpQYkMvc2ppSDJ3WDJZbC9HL0VhRHhnYW16bTVCNHc2dmtTeG9v?=
 =?utf-8?B?M2JJc0s5MXp4SzNlY1cxaFBBNm9BdHR2K1NlOSsyL0h1WlJlV3VBdWpzM2Fa?=
 =?utf-8?B?VHkzK1laZHBYNEpGS0lhK2F1SjlObU1JN0x2NUpsTHBhV3k3R2dJZm1BZmJm?=
 =?utf-8?B?ZUpZY1VjenNIaUxWWllzbDgvWmY5b05vMmdTSU83N0E1b09LbWd4TG9qV1Nn?=
 =?utf-8?B?SXAvQWpQUWYwak5VVVI1cmRudGVJZUNaeTlncDNVaytuc0J5aStaWGJZZk5Z?=
 =?utf-8?B?T3N1QTQzbDJ0OVplbmRkczc3S2tYNlNRWElrSXlWY3drbzk1bzN3aXUrVVhK?=
 =?utf-8?B?Zjh4QlRpc0NCcTVGTThoZm5nODVwNmcwNmt5SzBQcmZxcFVCZFVuR1JJQk5a?=
 =?utf-8?B?SnZpeEtXVnptRnh2SVFFTURpOG1OeXRaVW5CNE1uMGRDZjZEWGtaenlKNGhs?=
 =?utf-8?B?eHZhT1NMcTdOeTFjUkxrSnJPb3BIaC92VnZnTytMT1oyWEcyRThMeklxdlMw?=
 =?utf-8?B?RzdTUVVtaFlyb0lGRDJlVE5LRTZjaWpKSXM3QmhYVXltc3pmR0cyWEszZ09H?=
 =?utf-8?B?OGNSSjNNNEhGcGkzK0NRUmhiWWF6TVVxZEtrQ2g4dW5PVnlwdzMyNDRKU2pQ?=
 =?utf-8?B?cHdEaW1mbU1LQno4aDM1bUlJWGJ2Q1BHOVJkVlVSVnVxWVUrVHFUdzJCd2Uz?=
 =?utf-8?B?bFF1RnJvNE52VUpRMEt5T3dKK0JweWF4U2Jrd2swOUEwaEhneW44OWh1dnds?=
 =?utf-8?Q?CizPGABhZ0ckjdxOx/gMMcBre?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfbba26-5cf4-43c5-c1c4-08dcedb2d0ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:04.4435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4i8L0aUgEwWF79ujhtqmfRMVQpkneQbctBmpACUUVj5EVUiAcDAM/YnDzn6ZbqLdLrt0Jxt7kRTx50ziaG8Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9362
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

From: Viorel Suman <viorel.suman@nxp.com>

When interrupt driven communication is supported, the transport allows
the caller to choose between interrupt and polling driven
communications. To make the choice, the channel flags are used. i.MX95
uses interrupt driven communication so that Channel flags should be set
to 1.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/smt.c |  4 ++++
 drivers/firmware/scmi/smt.h | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 67d2f45002490ab64a6bc997eda93a8f4681d99b..e5b902dcb0e641065f4c0faae6bc6660a7e2c6af 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -48,6 +48,10 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	if (!smt->buf)
 		return -ENOMEM;
 
+	/* Command should complete via an interrupt so that set Channel flags to 1. */
+	if (IS_ENABLED(CONFIG_IMX95))
+		scmi_smt_enable_intr(smt, true);
+
 #ifdef CONFIG_ARM
 	if (dcache_status())
 		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),
diff --git a/drivers/firmware/scmi/smt.h b/drivers/firmware/scmi/smt.h
index 9d669a6c922666c48e7dce4c0affd7b47cb137e4..768b0f4c8a8d1cc7966530e724d278d72c2a167b 100644
--- a/drivers/firmware/scmi/smt.h
+++ b/drivers/firmware/scmi/smt.h
@@ -84,6 +84,16 @@ static inline void scmi_smt_put_channel(struct scmi_smt *smt)
 	hdr->channel_status &= ~SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR;
 }
 
+static inline void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
+{
+	struct scmi_smt_header *hdr = (void *)smt->buf;
+
+	if (enable)
+		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
+	else
+		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
+}
+
 int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt);
 
 /*

-- 
2.34.1

