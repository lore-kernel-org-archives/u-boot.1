Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DAFC7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B10882D32;
	Wed, 18 Jun 2025 09:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vGRkjj9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2304782D59; Wed, 18 Jun 2025 09:30:37 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D17482BF6
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZMKd+wqiOOFwJUFjtTWs0XkuUBUfU9FAJkBom2gLoSDZUX2b8+QE3K/9bPQeITE/rQexrlSOzB/Jgh5g0UAfP5gALKRo70pSr+x0vxXlf3L031MROtN+OsGfpVwe5aqwtV+bi8r7/aI681ZBOjxR2nUxGpa6b1WGpGP368lyka+p/a+FOnEQH3bm6YXxQ0wVIm6xMz7XpHPj+aEIDfkMV/2H+EzXGaldlkowp1qYPjWn5P8zlEd/ZAUbEWLmJJPg2KgEa5RtjvOrjaV75ymQjfeGyJJlmIdQyzVRLkf70ejRXiEzZIZZBhC0m7vRDYPWostjYGQNqE7LoleLYnm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2X5yA6+0EUrzXgg/blZ0XY9tMMlIUPJ+rWJ3TEvuZU=;
 b=ejIZG+JBCYGMwxf61SWHoXDZlqPTxOJldKUnYx9g6PDd6rhG/yqZCF+o56c/RUrNhM1BpAdr8D7oGvR4nXgqSO7hmRBELggnXNi9n01893U2FjS5dgSr9iIvEMAofaZq42zvCZtPth9X4Hi5DBqTv1h5UEn6Cbi0qb5VAnB4yKUatGVWNmkHP3HJqNF2B/BEuettTX58tmAZBh7soJL2Uv5J2HrLB1Un/VAnelkYwevFyYMmL878m4nZV220lJKaV2YU61M4ffLgLfUWcAYFEMShPZdODdowemciYxH1RUZj4/27MdzjaSOMD2w/CTH6lhg5UCsrhoF7gyHlVSzK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2X5yA6+0EUrzXgg/blZ0XY9tMMlIUPJ+rWJ3TEvuZU=;
 b=vGRkjj9gfqD5pDDiomP4x8L8UgOJvvizz8Lokq97Vgp3ltykLsAYs/4dIXnjKes6xSrlIKQL84KSwUkyUnymyFrZfwbnFEwcxVrxSVhooZoBSKsIcF6KOgmIjNwx354Jq2fuJRGhI4az0tpPI3g009t02IQ9Leya9d5RU/QPnUYgXxydjH6WlG7/bo4fhje3pblvl67A39VH8a2COr7zMzQ+OFh20U1PoVZVDARwUTCUc8/JCzRGXqVgTPgvRyoU/vB7/+0sWDjiHuqcji7xZQh4ukQeu0rUa/++jgEHw/wuADtEACcbo/LAD+MCTG04JLp8fEA2xOgIBUm8IR+Y5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 18 Jun
 2025 07:30:32 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:30:32 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 18 Jun 2025 15:30:17 +0800
Subject: [PATCH v1 4/8] imx: imx8qm: update packing i.MX8QM MEK flash.bin
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-binman-v1-4-373e66c7a51f@oss.nxp.com>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
In-Reply-To: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a82898b-fcdf-44d8-3687-08ddae3a0204
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjZIL0VXM3VFUDdETnhKUmNXMjhzbGN2M1B6aFI1dkk2M3VhaW10YzRhM1FE?=
 =?utf-8?B?dFhTUFFOL0RlazlzeDR1QzNvSndqQzd4SUJURnA2MW1kTm8vdTcwMmxWM094?=
 =?utf-8?B?RnpzN3VrME8rbDBhdEpiU1ZuaHFlamdIWkxWZGk0cWJYV21TQjdXS1hVaWcx?=
 =?utf-8?B?eDdRcHhLRXNnRkgwSDFsTkJvUTd5VmJiV3Z2R1ZtYUxUZi9CaUVTTXJ5SE1h?=
 =?utf-8?B?eitwTzA3MGxOcVRxdVVqVW5qTXlrekZJMlpCeC9heHFuNzFaNXp1WlFQb2gz?=
 =?utf-8?B?K3ZHYXlYekRrVll5V2lycXRBWlQzcVZLMXJzWHY0Y2RyeE15OFdMOGZlMVlE?=
 =?utf-8?B?VnppbFNkL1dabEwxT3J2R3UyaytUdWZUc1NNNURVMHlkWjdUSFA1dld6RHlT?=
 =?utf-8?B?N1gxb3FVaFBRNGRlbTNwa240WlRpdDJPYlM1NGpabUZaQmd1OFV6VVA0MVIr?=
 =?utf-8?B?Qlo1eWlJc3dQU3lnZXhvMjhVeXhxZk51SEloc3M5R0J2L3NYRVJHbFNNZndy?=
 =?utf-8?B?NFhGNjU2cEFTWnUzNXd1ZjA2MzB0YlV2SlowZkZUK09kSFoxcG5qN015VkQ3?=
 =?utf-8?B?dFViTG1iNHA3Rys0YlRucVBNTnU3aDNoaUtyRHozZUM3SytYRzhsclo3aFVi?=
 =?utf-8?B?RjBpUWJCUkhia1BCajdnc3o2N1VnbDYweG93eTBFVnBqVFVIWEVJKzliMG9S?=
 =?utf-8?B?M054VWgyRm0wMVFNaHJuL2o4ZVRqdnBQOEhYdkR4bnVTSldqa2ZUVUNoVUw5?=
 =?utf-8?B?R0trcTlhNFpkQkhNNmJCSk0wRXZ6TFNHOWszT1NFYnp4cUhVNHlPdHNnZmZm?=
 =?utf-8?B?NnhORFN3MTlBeU5rMmF1QXl0M0krOXEwdWRhNDNyenF3N0lDYTZlK0NrQllG?=
 =?utf-8?B?c0paOU5acWwzSDcrNWxJem9DUTdjdlAxL3dEU1ArTzYvekFJbmhrOEhhUHky?=
 =?utf-8?B?azZESHVRSy8zV21HamRsa3ZhdUtIYlVvLzl2OW01Wkt2Z2lRdnNCbG1QdGJ2?=
 =?utf-8?B?R0l3VEMzdGc4ZGdNWDNOQ3V4QVh2Z0I0TVFSbVNVTzJFSnRlTlFkZ2gyN2Nl?=
 =?utf-8?B?S2VsR28wZHFxVEVFL2Q2OW5uenRCNGxzYXZ3VXZ4TXloRjdkZVVWUHlxbzN2?=
 =?utf-8?B?M1NWTkxDdTdFWDF3a3lDb1cwYSt5NElGUURzSDZnWElDajBkTlJBTVVPR1Ur?=
 =?utf-8?B?MmFmTnhpZnBlRkpMeXcwQWZycUdyUVdJNmlSMVpIU1VoK1M0SHdsR05UZG9K?=
 =?utf-8?B?Szk2My9WZHZFRHhCUEJDVTFQUGNuTHg3UkZaSHdPRnNGbXAxS3ZNSjFyM2F5?=
 =?utf-8?B?aGpIbWhubHl1b3lNMVNjVGtLQ0J1ZHZtempiSDZuT01yTDBqRWRhOXhCV05K?=
 =?utf-8?B?aDNjY0pFS3JKTndFcmhYS3dUK2RXcTlFSFJkWlAvUFFFemUvZENrd1hNWHZU?=
 =?utf-8?B?Zm1VRFlRQW1PUklQVWNTQUtWaGJtUitObnBiYWJ4L2pGcUc5QlFiUmNnTE12?=
 =?utf-8?B?TDc0MmdYVzNFWVp0YlI2NFFsU1dXQU5qZWdzRWVDTzE5Y0h5VllmbXZ3RjVj?=
 =?utf-8?B?Y0xYZ3lEMkFCSTVwTUxpWVZpQjJUcy96bWNVbG1TMkVEdm5RVStMZ2lMTmNq?=
 =?utf-8?B?L2g2UWJXbFRVaEp6MFFqaDVjNmNLVktrcWJSR1d5YWJVZzBBK2c2Y2FNNWJZ?=
 =?utf-8?B?cUltNldQaTdGeGE1Z3lUZU5Gdy90NEtwNnVsdkpSd0pEWk96VGZ1YnVxblQ3?=
 =?utf-8?B?UnF0Vit2eUtRd2FjbGlaZFFkL0RlYjdESmpTRm9qVmVDcjV4d2dyQ21pZTF1?=
 =?utf-8?B?a3oyMkcrOGlyd01RS1BIQlc4VCt1TXZaR3JGcnpGNGtheFh4SnEzbzNEWTFj?=
 =?utf-8?B?bm02Z0djbFVkanJWckxDR2hJaS9WK0JVcWNzLzdlYnVFdElSWUV6dXM3VXZy?=
 =?utf-8?B?ZHByL09SUHBWNkxDTmloMStTd09uVW9FS3FCT2tNTzRoUGtHZlBMRlNRZ3lN?=
 =?utf-8?B?WGhveGtrTFpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzUyZ2JrMVhQODk4aEsyS0FMRlNZeVpCZW53bkF1VkNKd0lkdHNYZDZ5QWlF?=
 =?utf-8?B?S0N0bDB1ZG5QRmNycTZkQ09UWVZEQjIzeUxsemtaQkgrbi83dFUrTlRJUDcz?=
 =?utf-8?B?NVR5ZkIxM2VNL3huSEV1MzYrT3VVL2laellmRlJqZ3V5ZG5sUzVEZSsyL1lG?=
 =?utf-8?B?alAyM2I2dWVBSzgvZTNmaXJxVnFSUGIvRlIzVHFNbGlVYWNaRFdEb1ZmeENT?=
 =?utf-8?B?NzNGUnQxTGxwUW8vNFJGbzA1STNMVHVkbXFKRlpBSkRIdWxady9GNzY5MmQ2?=
 =?utf-8?B?QkRsczZNVXZlNVBiR25iSnMzMFZFUGZvd04wc1VJNVg2WksyQ2h3TEFPQUF3?=
 =?utf-8?B?MUZvT1dZdWV2NDhNZXd6YjFpM2VSa0hUbUs5bnFYSHVhdGcvdDByZ0lUczJ5?=
 =?utf-8?B?Skc1cXA4Tmc1bThQK3gxYjM3VkNMZzdJRVh0L0RURlpZQjhhNzQ0ZlovNnVT?=
 =?utf-8?B?cUhJcHcxR2pSRzM5SCs1Y3RUTjEva3dTdytQVWhnaGVMZzBqVnEwTGxMcmds?=
 =?utf-8?B?STBHY2hKa1lxN1FabnkvQzFNYVRqbUFvYjIzWE8rVWJTQjkyelVLcU9ma3NS?=
 =?utf-8?B?V3lDbldra0RqOUlHRGM1ci9INUE4ZWxWZXpSZmlYbVl6c0RuWER5MThoSDVx?=
 =?utf-8?B?czZTQW8vNXNwa2xZQVpUNXppditZd1FjaTkxbndYRVh0TVVTRFV2QjQ5Vmxl?=
 =?utf-8?B?SHc2WXM0dlBKdzZlK1F1MmV4Y3VrRjBtaDdualFnbUVCRHJITS9UeGRZMFRo?=
 =?utf-8?B?RDlyeWUrT1BsQnhtZExURVgzVEF6eEJYOFFMYU5hYzdPMUR0RFBSQTUvQ3Ix?=
 =?utf-8?B?MGRhNFZISXFqYlNOc2owQnZJbEg1TEV2eFZJVGpuS0NKMUFvOStqbEtwSGZS?=
 =?utf-8?B?dHh6R0VoSU04WUtVNzIwL0dvejlVbWpsaFJJd3dvazBsQ1VBanBmVjN1UjV3?=
 =?utf-8?B?ai9uMkJGRnhuNDVqTGJ2RktMazRIR09xdVQ1VjVJNG5UcWZjb291ZVZIWW5j?=
 =?utf-8?B?TUREd0Jla3pPTzVCd2ltZWFLSEF4a0NvQTJneUUvYUpHUGUxbTVieXlrcTU1?=
 =?utf-8?B?aEV2MHIvOExydEdjNnRBS3FBcWdoR2MwTml2UHpPUmhTOTZrMzI5WUI3WW9V?=
 =?utf-8?B?Si9vZERQNWplQnNmNEVjWFB5a2FMUmFZdDBMSDkrMWR5c0JYc0VMaFZkeElt?=
 =?utf-8?B?UmNXTmhTREJIUitCemNOd2FHYTdpbDByNEFQbEphK1hsdDlITkxvUFNROTlI?=
 =?utf-8?B?Q0hnUnRRYmJLWjluTGpEb3lwQWthVGhFWXJaanE2eHU3ZFhLWDZqaEZLYlFN?=
 =?utf-8?B?b3VwZS8wb2tua3NVZGNFWVRQOGxNelVXU2ZmVDYxOHA4d0lNNFlTK0pHY0lT?=
 =?utf-8?B?akZVUGhoZ0ZpQUx0MVdIQXNLeXl0Z0VwRXRnUlVla0k1WjY4dCtWVytXSlYv?=
 =?utf-8?B?S1FtLzRMSEJSSVlyU0tydk9BM2lzN1hOSmtyVm5vTnh5ODI5TWpsWG5pWTBO?=
 =?utf-8?B?RENyZzZ5UlRWazNkbWkwQ3J4UTlZV3FrNGxWSnlzbkJjc0FsRHByVFJwN0JV?=
 =?utf-8?B?WEhMdlM3bEtnTEFEa0xxWXFYalZXeDZlenluMEtKZUZMSlV4WXhtaXUvb0ZH?=
 =?utf-8?B?TXlETldtdHU3dzlYNTdFZEdqeWdRRUNDbXNBS0QwdGlWNDNJVklOWWVMS0lS?=
 =?utf-8?B?M1laN1RRUy9GSStiQkV4dlFqZTdSYWhQQnJLR29BOWtKZUVNV3RTOGR6d3h0?=
 =?utf-8?B?R0h1K08ySGV3ZTJWSnVydWxwWXBsSHRpSmNGcHMvU0RDclJWRnFKZEZHOEF0?=
 =?utf-8?B?ZFZHZlJFcWpKd0NlSzQ0aVhyb2tiTFBJQjVONVNWMXRzVmszV0hOUE16VXNI?=
 =?utf-8?B?OVhYNC9HdWNKZjd4eUZ0Tm91ZkxDVlJJWWFhQjFkanBhWEd5YnJzTDZ4eU4v?=
 =?utf-8?B?VTRlRVNTeWxhblJzK2dKcy9LYjBVWFBscWxDRVAwejliTDNhVUk3ckV1anFV?=
 =?utf-8?B?OEM4anJkSFhMY0psbWExWTZkSVcraXBvMUlOUkM3MVdrODJYZ3dkdmV3eTc3?=
 =?utf-8?B?OFg5L0VqRHFBWmdETXdCVjJSVWtwYnZtTCtaNEs3VEpjU3V5aytGcjJmaFIr?=
 =?utf-8?Q?JNO3EVgyk0UxekjCUsaH2pbww?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a82898b-fcdf-44d8-3687-08ddae3a0204
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:30:32.3072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FCB1e9j/VT/N3jrDwGwc3/R/a6VwQQWuc51AWsScohP+qjyfSiiIi95anOWOMrAe2u8nTncu6h3dwylnBsFzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408
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

Using this patch, a bootable flash.bin can be generated. It contains
seco container image, scfw image, u-boot-spl.bin, atf and u-boot.bin.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx8qm-u-boot.dtsi                | 38 ++++++--------------------
 board/freescale/imx8qm_mek/imximage.cfg        |  1 +
 board/freescale/imx8qm_mek/uboot-container.cfg |  2 +-
 configs/imx8qm_mek_defconfig                   |  1 +
 4 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/arch/arm/dts/imx8qm-u-boot.dtsi b/arch/arm/dts/imx8qm-u-boot.dtsi
index af229501a4d..85ddcc38993 100644
--- a/arch/arm/dts/imx8qm-u-boot.dtsi
+++ b/arch/arm/dts/imx8qm-u-boot.dtsi
@@ -10,32 +10,6 @@
 };
 
 &binman {
-#ifdef CONFIG_XPL_BUILD
-	u-boot-spl-ddr {
-		align = <4>;
-		align-size = <4>;
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
-
-		u-boot-spl {
-			align-end = <4>;
-			filename = "u-boot-spl.bin";
-		};
-	};
-
-	spl {
-		filename = "spl.bin";
-
-		mkimage {
-			args = "-n spl/u-boot-spl.cfgout -T imx8image -e 0x100000";
-
-			blob {
-				filename = "u-boot-spl-ddr.bin";
-			};
-		};
-	};
-#endif
-
 	itb {
 		filename = "u-boot.itb";
 
@@ -127,9 +101,15 @@
 		pad-byte = <0x00>;
 
 		spl {
-			filename = "spl.bin";
-			offset = <0x0>;
-			type = "blob-ext";
+			align = <0x400>;
+			align-size = <0x400>;
+			type = "mkimage";
+			args = "-n spl/u-boot-spl.cfgout -T imx8image";
+		};
+
+		u-boot {
+			type = "mkimage";
+			args = "-n u-boot-dtb.cfgout -T imx8image";
 		};
 	};
 };
diff --git a/board/freescale/imx8qm_mek/imximage.cfg b/board/freescale/imx8qm_mek/imximage.cfg
index 71612678c99..bead3a90d3c 100644
--- a/board/freescale/imx8qm_mek/imximage.cfg
+++ b/board/freescale/imx8qm_mek/imximage.cfg
@@ -6,6 +6,7 @@
 
 /* Boot from SD, sector size 0x400 */
 BOOT_FROM SD 0x400
+DCD_SKIP true
 /* SoC type IMX8QM */
 SOC_TYPE IMX8QM
 /* Append seco container image */
diff --git a/board/freescale/imx8qm_mek/uboot-container.cfg b/board/freescale/imx8qm_mek/uboot-container.cfg
index e25aa76fe18..2bc6e5ba572 100644
--- a/board/freescale/imx8qm_mek/uboot-container.cfg
+++ b/board/freescale/imx8qm_mek/uboot-container.cfg
@@ -9,4 +9,4 @@ BOOT_FROM SD 0x400
 SOC_TYPE IMX8QM
 CONTAINER
 IMAGE A35 bl31.bin	0x80000000
-IMAGE A35 u-boot.bin	CONFIG_TEXT_BASE
+IMAGE A35 u-boot.bin	0x80020000
diff --git a/configs/imx8qm_mek_defconfig b/configs/imx8qm_mek_defconfig
index afcb0f30594..6cfe840ba6b 100644
--- a/configs/imx8qm_mek_defconfig
+++ b/configs/imx8qm_mek_defconfig
@@ -42,6 +42,7 @@ CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONFIG="board/freescale/imx8qm_mek/imximage.cfg"
 CONFIG_IMX_CONTAINER_CFG="board/freescale/imx8qm_mek/uboot-container.cfg"
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set

-- 
2.43.0

