Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF614C3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEBD788CEA;
	Tue, 17 Sep 2024 04:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZoV6uKoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 293F188D2C; Tue, 17 Sep 2024 04:30:43 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B23B88C8F
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPvvrPxulc7Chv5gxzWCWkytLuCErpbRkXI9xX5p57QFYPe32JHTo3xzwTAvLtnJxhEIBrpHT/Yw5sSKK8DpR8NzsvJfh/Ltj7jSzw+K5a3i/5hJg630lcorDPSmPWowkt29a5HSW7ONmaOFWjeBpk6vkFfH1PZJ6c8NWFgVeOglYblY8nzbPxcGZyNqZBDPiP7/wD+VXbKa0c25suUof1D7LpY6dqdvk69YMD83irCfd1JoXQlHDvtVxOjOPSO+S31O54r3cuALih+/75IKR6hrz/Tvw7/lm6prGM9fl15k11o9Pn+deBxCEl0BNjjKSKjIvqgHaHFMENb8Eu27YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7FWtX54fZCC6tTc51wiX8ExN/lZaOA202QS0eNNKOY=;
 b=mkNVXJqjv5U3Ykm/lzXvF/JQPg2JGyN8oRmRbETKQmGri+lLZAlMs8zWwO+Og7rqJzVVJ1phNzBrLtnWLmCSZ8w7Ie28DyGcfTOiKgtVXvHU6iTL6JnjgPeMroiNE8tP6VMEgs0HE4HSenKMJTCcX3ZNU6hnKp+cAEyPBkfcdg2315InVwlL3lT07Ex272oRj4j4weGswM2pnkFkM6fg8n5Bp0SRZ7STi8BL82CmKDrrzo0cVfT0JmgiWiXuN6Nnd349Jfp62Czzpp2kor0mTakLqslRawy/r13OMPKrTjANy5Q9tAAB8QdMDspIMazxrK5LwbVw846rSteApp4ljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7FWtX54fZCC6tTc51wiX8ExN/lZaOA202QS0eNNKOY=;
 b=ZoV6uKoWIo03uJIqpHHheRSXFFeQkkc5FYvf7+/AtOfG73LMVOZBCd1VDYWfHyKOjjIwEEYK6wp8i5lPnhwzpL1y0VrlvFcjDfSszIvPX0f7b3mUVHQ8RO0XizoVFNnKwFwirJEGnA0KgVYFa2gFVOziq+PUjtYZWYgii+XQQD5NnMbW9mEdk6TEbhMYsFABNMf4Sw2JqJqdO9D7SlS7yn2N/iyWxkifSqsCnce5gOVukqNflA93c4Gz8EPcRMrnIMkpq31iFzO4PaJ93xk6vlP96UWu2Z0iRmqqF6GU9Sq6Tgjk7//n1sAV6tF3D6MMsZFRFFmUovwjhLxNOWBl2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 17 Sep
 2024 02:30:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:30:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:33:54 +0800
Subject: [PATCH 02/21] imx9: soc: Configure TRDC for M33 TCM access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-2-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: a49426f5-e0d6-40b3-4af6-08dcd6c0b83a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SElsaWtoc04rWTdYbnFYekErWkthSXFYeEpINGMvTEFsNWREd2grMkROWURi?=
 =?utf-8?B?ZmU0bWh1empkaTArL3J6UjlhaG9rQ2lkN2pmbTRTSW41RjdVTWlyWUdQRVN6?=
 =?utf-8?B?d3NvMXZPZnVRRVA0aU92STJjNHh1MG51dkFjK2oxeTU1U0t3dnRCWG1QL3ZR?=
 =?utf-8?B?RzE5c3AzVVRxL2NMVnA5K2VhNm5FWWpWV0lxLysxb3lVZUhPQ0d4Y2ZWM2NB?=
 =?utf-8?B?WjNZbUhhZ2d2aXJoeXFzRHVOc1Mzb0hhUDV4RytUeFE5QlNrbGhkWTF0NE5G?=
 =?utf-8?B?Zit3MTREZkZWcGx4ODR0ckJLb3RZT2F5dkZNVEpuRXN3VWY0Vm8zZGd1YTZL?=
 =?utf-8?B?R3p0TXZabzZ1dFZweXUzNUl3N1kvNUFjdTh6cTFYUlMyVEVIQVkyVms0c0hZ?=
 =?utf-8?B?d1hOaW9LSGxackttL2w2ejB4ajZ2blNCNkNSVFp6bFJQL0poRUh4NHhzbUhi?=
 =?utf-8?B?VEZ6cVBsSXN0djNLclduVkcvU2pQczNFemZuUFJhT0pHWFpjWXJCd3duUm5I?=
 =?utf-8?B?RkJuZEN0TGJ5OThDWlE0QndqY21Vb0dCTFBaVkEwSkZmd0l2K2sxQy91aDB5?=
 =?utf-8?B?SjBzSHZxSmxTSUFGaFREZUp1Tjd1MWxvRk00N3dGWG4rRE1iTk93L3FmRkY4?=
 =?utf-8?B?WlV0Q2pNV1hIR3F6YlozenhhRG53TEcrTWJjNXN0NUhoYkU5MlEzVnF3aldp?=
 =?utf-8?B?emI1M0d2L24rZk9DNktZMDRvNXB3UjBYcG9IRklraS9kVklmTkp2VExxM2RB?=
 =?utf-8?B?VzJ3V0JSQjNOWm12TTJKdXU2L1BXaUtJaUJybTZLMUxyTWd6YktQTVdjbkFJ?=
 =?utf-8?B?UlJXQ0l2WHRpei9IeHhSTzc0cHFPaGtyMkZOdXpBTFdHQUEzT05MYVVGMFpU?=
 =?utf-8?B?alVaTm0wM3pGN04yaG9STDY5QlhVTTROOEtSVmgvZ3BLWm9uMWtjMXdUUDJL?=
 =?utf-8?B?WERZVm5KTGRXWEhlamJha3kzUWgyS3NEUzBSeVlxalFaTlE2NEJ6VEQ4NmZw?=
 =?utf-8?B?dTJMOUZUbkI1TnV5ckFDc2pUU25iRzFVdU5aWGFsUExhRWJqbkxUc3ZGYkE2?=
 =?utf-8?B?M0NpWDNyRmdRM2gvcXp0QWpIN2VSWXEzNElkNlM0c0lUZXNXM29nY0pRcGlz?=
 =?utf-8?B?bUNnU3crZTZ5eDB1bUJNOEh5UHRhbnBZOEw0dlFSRGQvd0tFcXJlVjBaUEtM?=
 =?utf-8?B?eXEraEFsSlhqQUZkVHBvUnFvSFNocHZNL0FaQnpxTk55NFNhckdkZzl4R0dr?=
 =?utf-8?B?d0VRazRNbkU1RWZmOTFPNnlwcFRqdU1oSmt4dmEwUFljRVRTcXpFc0RPb3Zn?=
 =?utf-8?B?endtTnNNejZFVEJpWXNkbTNrVmIxKzBlT0gwTi9qOFNEOG9hTTlxY0IxWGZ5?=
 =?utf-8?B?NzFHMjVLVXRnRWo4Z3FVdEFicUl1M2t0dUZwbGJsZlhjNkJ0c0o1TW1wYlgv?=
 =?utf-8?B?azZwemxZZWoyZE1XRVhzamZJa2FVYkpWUC9RUjVBZytnU3M5clJJQ0lwek1G?=
 =?utf-8?B?ZEUrMjE4cmxyQ052WVQ1cmVMLy8vbVNkaHlvb1JGMDNPNWNGZkZReFllSnJ0?=
 =?utf-8?B?T3AyaHFnY05zZkRKNjMyQ3YxV1F1QUpjalFGaVI3SFhua3lxNGRmcUN1SzU3?=
 =?utf-8?B?UU1ad25GQndLNDZlSy9PZm5YdXpDWTlTOTdNUXFTWG5odC9uaGZ3NHZRYXRq?=
 =?utf-8?B?b0ZmMDZMa2cwd0lTL1JMUUR0eVNld3luTjNLSGNCcGRYaWxxamF1czhCWmVT?=
 =?utf-8?B?TEhFcHhGVHdZNXFPYTV3cmw1U0ltZVRQQ3I1Q004VHRCMFQ3QVVQazMveXFk?=
 =?utf-8?B?QVNZQnhqcDZxSHJZQnIyczVQZzRIV1FyZmVsN2JKU1JXV2hWL1Q0UVMwckF2?=
 =?utf-8?B?a0RmV0dSRE1RRUVBRkY4TnUzL3d3UXd6REhpbUtzTGpGeVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWY5bEE3Z1VLRnlSQkpnOG9sZm81cVVVN1NJbEtrYjhzVWU5bUxOamp3RDlC?=
 =?utf-8?B?WTZaK2RjdkZzMzRrN2RyN1k4ZFBCM2ZHc1JlQzRwVlFVdmM4Ujc5Sm5oYVZy?=
 =?utf-8?B?UDBYU3lwUVJ3Q1F2SFc4c0JRWSthNkVYNVc2MytmZ251MXJEdHVGR3U2TEFx?=
 =?utf-8?B?c2NhOGJKd1h5RFBJSGFZaEV1UmJ1cUR6UFJoL1ZXK2d5NXpHNExWT2doR1Rl?=
 =?utf-8?B?SktSOUtHMUtVVFB6OXJZQUI1dXlkTEZlU2l3ZlJSclFSQWErbDQrVGdaaFVu?=
 =?utf-8?B?YWlmd2JpV2RYdHVCR09aVitsTjVNOVZ6WUhOZFZVd1JXMG1SV29EbXpMaFBm?=
 =?utf-8?B?bUFNUEdrQmlTZW91NVZxM0E0dXVhaVRHS3dFKzZFbGFJdmlPcytoL0VFRHU4?=
 =?utf-8?B?ajBRamJjeVd3Um5ZNGh5SXBzbnNkdTNweHhwMFhUM1kzVWZFUmNoU2JZdnlr?=
 =?utf-8?B?S2hqa2dOcDEwNHRWek9Ram83SHpiTExrUC9oSmpTbTVCQVZqaDlwT1ZSV29M?=
 =?utf-8?B?TlZZSkxRR2RoeWNlUkQ1QllzeGp6TS9JcThORVNWckltV3ZIQWFlWG84TFgx?=
 =?utf-8?B?cVFlWG9YMWRDTHhHaHpOaTlrOHJiMXdvRmZwV2R4L0xDWmZsZmNFa2lGT1Bm?=
 =?utf-8?B?cXppTGtsYVk3T3FMbHlSbEI1aGlNV1VGZ1VUZWdyZ25ENUFEcTFVL2Q5WjJ6?=
 =?utf-8?B?aDNGVnBCOVJsSlJlYy9ZQTNNN3ZsQmxVcFlmUXpyYmF2bVF1aWpFdFFLUWpj?=
 =?utf-8?B?aWdta01JVEhOTTdFQkJ6S0xtZUxlZFlPNlJ3aTFQV0xmdFdvZTkwdnN2Zm5R?=
 =?utf-8?B?Tk5CdTA2MGdBSitKODhESkt4dVZRcnBuQmsvckNSS1Rnd2VzWHRTRkhqU2Zw?=
 =?utf-8?B?UkpBR0N5WDFTYUM5M0FiT085UEQ2ZEJKaXN5M1A1TWo1TjBDYlZIUHRPM1dq?=
 =?utf-8?B?UzBBS2NIeVdlM01BVkh2aFZYOXZybzljSlFEMkxCNjQ4TEI5aHhVU0I5L2Fl?=
 =?utf-8?B?NmJ6eEtvclJDc3BHVTByYnBET1E5a3VGdkhGMHdqNTZnWWNwNXhYYWpGUEdl?=
 =?utf-8?B?RXBndjhGWWMyZTRsUG1kNnBJMzltSXpYelNtWGl4RVhObWRJekVwd1J4SEFS?=
 =?utf-8?B?aGl1L1liOEVqdUhreHBtLzFXTlVhOTJJTGRQdkZIM2FQNVlSOTREWW9iRnhu?=
 =?utf-8?B?SnlDdWdpVG9SZ25sNWJ3R2xLcHBnYUM0Z3FQUkNBczZvZTU1K1ZUb1VuL3ZI?=
 =?utf-8?B?WnJyZzUrcDZYVnRjS2VzbXlQdUF0RUlPZStQaGNiRW15SU42QWFHVzFvUkxp?=
 =?utf-8?B?WkZEaU5XWTd3NjQrRkRaWnM3am11TXJDamxvMzdQU1VyUUNFQ0F3UWt4QUFx?=
 =?utf-8?B?TTJUZjgxWFg0cnJjcHhYRU4wRGNNVWppeGtid0tyV01qTERMK1lBZVU3bU9v?=
 =?utf-8?B?V3hxOW9pT1czQzdXdXJzOU1iSXZqa0J6RWVTOTk0bTc5TVF4M3g0WVdQS2t3?=
 =?utf-8?B?eE9kMS9lUkNJUmhjb0t1aDROK0VuZWJMdUVJRmVtUTVicHFaSVBabFRqelNS?=
 =?utf-8?B?dGJmMXNsU05EaTZsRloyQ3prUjdMcVVJYmtXNzAxVVBmK3J2dkx3QnZsKzFR?=
 =?utf-8?B?dmluelRDWk9RWERsRCtZb1E2YVBBbGpodkZULzh2dzB6YXBteEFBT0p4QXN5?=
 =?utf-8?B?anQ4SStPMkd0YTRTUHNuTEpWWjVSUUwxak0xUVlpSXlWTm9HU3hnR2ZUcXNV?=
 =?utf-8?B?Z2RLL2JLR0ZSMVk1bXhaa0VhL1ZvaWwvQTYwWmFUaUI5enhzT1ZwWGFHQWFH?=
 =?utf-8?B?aUFidEUxNUZtSzJlSkQ2ckJSV1QzdWhYMTV2alZISmNhemMwejlldmdFS1NE?=
 =?utf-8?B?bHljU2tka09zRTZTeEQ1cDF2UXMrWjdRcTNWNmNoYzBCRFVDcEpMandIbDg2?=
 =?utf-8?B?TkYxL0hFSjNPMERWWWNsbzFMY0FQVzlvbWs5UnhJdUVSU2lld0Z6bG5qZTlh?=
 =?utf-8?B?NCtLODVnYnEra1lFNnBkTERDelR4ZzZueTVEeTkzQVIxWndrbmhhZnBhMjNx?=
 =?utf-8?B?bHhtZVZ6bVUwNXdxSzgvOGh4RnRQdXR5N1RPc1hpdG9oYnJna2RRSkxJeDd5?=
 =?utf-8?Q?9EkOYylqGRuMGMSv2kljZ8HTd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49426f5-e0d6-40b3-4af6-08dcd6c0b83a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:30:39.7777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58o4jl3UnPIO3G8Vg01U+enHCH29CEph7iszD3eHoOyhtaVouNTDeojUEAUDxP3ghU9H71HlMl/a6902aAuMIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493
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

On OSCCA part, M33 TCM is used for ROM PATCH and protected by ELE ROM.
So after release TRDC, we need to configure TRDC for M33 TCM,
otherwise A55 can't access the TCM.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |  1 +
 arch/arm/mach-imx/imx9/soc.c              | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 9953c33b73b..fb6de533d12 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -25,6 +25,7 @@
 #define ANATOP_BASE_ADDR    0x44480000UL
 
 #define BLK_CTRL_WAKEUPMIX_BASE_ADDR 0x42420000
+#define BLK_CTRL_NS_ANOMIX_BASE_ADDR  0x44210000
 #define BLK_CTRL_S_ANOMIX_BASE_ADDR  0x444f0000
 
 #define SRC_IPS_BASE_ADDR	(0x44460000)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 9b6ba5609d2..25b9116f2a6 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -792,7 +792,7 @@ int m33_prepare(void)
 		(struct src_general_regs *)(ulong)SRC_GLOBAL_RBASE;
 	struct blk_ctrl_s_aonmix_regs *s_regs =
 			(struct blk_ctrl_s_aonmix_regs *)BLK_CTRL_S_ANOMIX_BASE_ADDR;
-	u32 val;
+	u32 val, i;
 
 	if (m33_is_rom_kicked())
 		return -EPERM;
@@ -817,6 +817,18 @@ int m33_prepare(void)
 	/* Set ELE LP handshake for M33 reset */
 	setbits_le32(&s_regs->lp_handshake[0], BIT(6));
 
+	/* OSCCA enabled, reconfigure TRDC for TCM access, otherwise ECC init will raise error */
+	val = readl(BLK_CTRL_NS_ANOMIX_BASE_ADDR + 0x28);
+	if (val & BIT(0)) {
+		trdc_mbc_set_control(0x44270000, 1, 0, 0x6600);
+
+		for (i = 0; i < 32; i++)
+			trdc_mbc_blk_config(0x44270000, 1, 3, 0, i, true, 0);
+
+		for (i = 0; i < 32; i++)
+			trdc_mbc_blk_config(0x44270000, 1, 3, 1, i, true, 0);
+	}
+
 	/* Clear M33 TCM for ECC */
 	memset((void *)(ulong)0x201e0000, 0, 0x40000);
 

-- 
2.35.3

