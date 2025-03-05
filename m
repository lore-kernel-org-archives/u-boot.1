Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90609C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF21480FE2;
	Wed,  5 Mar 2025 14:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xEav94Pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32E0F80F56; Wed,  5 Mar 2025 14:29:07 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12981807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTF6mZQcVi/YcNEGlP5gVxikGOHwL3gIFppueHhNnoXlI847tRRZ+mdAgLZrFGtKgIkiRYa2vvI5NHvq2j02mZVCSN+XIpihAF2knzxW/l7jcxNrEIVT6nJbpMJCF6237/z3mMsqb9UMAKv2apyBy4Mbn2RCTIMGVpFewwqA6E+PVCab61skd5FS5qEF0UY8sgdQ8xEGKM5mfWmny1w4H5UItGql7X18x6EOWR+n+tJUoWLGduDB18lqqsSDtk+6FM3uMh/NqihnNcUd/fWhxJi+DsOEHSi3LDm9oOTSBQrnxHFmYlsgaDLdgiX8mwewmwCvGRaAvveEGR7aspmDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fF7NBdMGuIof78uz3MMz8YBu+cgu4Me4a3eAqO4NNJc=;
 b=mfdrIKW7LJcCPgnCZMETiKkgr3CsQRRRQYj2CJqlcaOLyxF5ahuem9pAnyVjw98SJVG55JJQogO/+dwUutBpHajxXxKeBXFKLKphbMkZkmbQpC9SAGNErypGbUBaycZlbHJkWMEE4eIDt5NvZpM3Iap7Km16PADxZIf9MbapjJv0hzhZX+omzros0s8jOKwxNQYfCgDXCyRNCu03ikYOZVpGAXihiWjUgIX3bKdZ0fvJwk100/xG0EHAjyrltCS9tZd6w/JmoxW5+Gkh4zntv3VSx/2CS5nOD5OA3LG0RHl62q++N9iQsdUeamoUgbFnHB4rwNo+O1iDf/HXGSsBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fF7NBdMGuIof78uz3MMz8YBu+cgu4Me4a3eAqO4NNJc=;
 b=xEav94Pi+99ZF07ZpTzn7hXCaJ8Y2DIxyT5sQXL0TBo9bFeDjI4BXtufNnA5kpbGySU855mNmSzW4Id4VB6+3UuMC/FJPl/4fusp3OQn/uf7DEiUOFsT71eSiDbUury0qGxPydLWQ2KUFBz43Hc7G7j2HJuT0Fnst+9OFcFtyh3Q6d34sQ8BmbkW2dRqvG6kOiJKryGfHZufwjVWayx3+I5DSQ29R8A4naYPHcYO+eTr7VfMjkW0nae3cpPrubJGwvAYrQB+4WLtqgp8EE26n/rKEMjq5mDpL+QJj29nRd3zCku+5eUB1Wk+/R6d0gl1NCcxvvUg3V6TD0fRUr8jxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:29:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:00 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:15 +0800
Subject: [PATCH v7 03/19] firmware: scmi_agent: add SCMI pin control
 protocol support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-3-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dedd114-6450-4767-cb15-08dd5be9b065
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFp3dHZadHY3M3ZtRzdaSnBLK0YvRHpqcS91RDJyQm5zYW93ektROTBtMEZL?=
 =?utf-8?B?WmJuSDB5b1V2VVVQY2dPLzRicm9ZWkRPc3ZzZm9oK3RzaXl5a1FIV3RjMWpY?=
 =?utf-8?B?SEliUzFNYmZtRFhlQXNWbjl3SjdzZyszRlFaM3owcllROGxHZlJ5UXBzTUdq?=
 =?utf-8?B?WnMxQ0JGU3F2U2tyTWcwN2ZRUjd0L1JwQ29BTUI4Q0ZmWmd5WWRqaEdVZ3FI?=
 =?utf-8?B?dW1GS3ZjRHJVMXpSMkJVSmFJN2pFUThaWTVXZmxsL3JJSHBrK04vSk16U3d2?=
 =?utf-8?B?eTdaY3JxT25VZk1oSTMrZE90ZFIrWk9oQzZWSXVzTVpKQ013dVpuaTU5aVB6?=
 =?utf-8?B?VEhMMHcyS2hqTWNTRncrNm5lL0R3QmdRbzVJVm5KNFV4WDNGaU9VU2Z6NDlj?=
 =?utf-8?B?SWxLRGpLSkdNUEFQZHo3VTBRK3M3VGJjZE1zRGVFamRaczQxM1ZkeWo3T2FZ?=
 =?utf-8?B?L2JKV2JqQlgvT3NSZVFIK2s4Z0dnRCtSQjV0SE84bzIyUGc2Y1lHODdjaUxh?=
 =?utf-8?B?M0Qydkk1cnBkWnc4NmdiY0VGK1djczdRZTFWRWNnakgrQUkrRE0rSXNFbC8v?=
 =?utf-8?B?Mi9oUWxHSi9YLzRZVHZ4a3Job2lCWWpiejZ3ZlNkbml0SXdFMTJ2TndZY1Az?=
 =?utf-8?B?QU94Rjh0dFl4MEU0OENMdHdjZWNxNkwrTzRlM2VVRnZySExmQmJlM1RYSXhw?=
 =?utf-8?B?TDQ1cmptTmlZZnAzVzlWMlhlNko4L215SzdaY3h1N3ZBeUxKUkRRVHIrTDZD?=
 =?utf-8?B?U1lFKzB3UGRac2dVRENzbjEvak1zbGMzSFl0blgrYnBpbjdwV2pNV2xmU1No?=
 =?utf-8?B?VHRPVXUya1Z0YkpsbVA0T2QyLy9ianZISVRNRUpsSC95WCtXYTBXOHBRblVp?=
 =?utf-8?B?Nkt3c25OQXBUM1B3WldmQjRjYTlJS0FPV3RDMkdmY056eGhYcEIrcTdoL21q?=
 =?utf-8?B?OW9mRmloQ3BDUWlKamNLc3FZbmlxbWdVanpDUFViQWhYaWNCSmk4d3FDM041?=
 =?utf-8?B?bXZHelJSa2tya1FMZ3dleTI3ODJQUCsvdlZuY01VaTZ5QlFNRGF0bmJIY3hz?=
 =?utf-8?B?UkcyckRwMEhESG1rdm9Xa3h0N0MzL2FTM3o5WWxHQzNGcVoyVWdwT0JlWGEr?=
 =?utf-8?B?blUvVlFVWDBPZ2tlWjNnUUJoUDRodTJsK3lmSnRoNGNIazM5ZWdJVEpFVklY?=
 =?utf-8?B?bzYvV01wR2w2ODRSdTRxSGo0Wjl3bklNa21kbEJ4N2o5QVdxYTlaNG5yUFRB?=
 =?utf-8?B?L3BEdlNpQXBMQ1dTZXpBR1l0a05Fa1hyaFlmKzBqLzFYNXRIRm5aVzJrYStQ?=
 =?utf-8?B?RDIweWxDQWRDTjRsdGdVU2JQUk4zWVVNYkFvT3hEQjhtYVVLbmlWb1VsbDhF?=
 =?utf-8?B?aGl4eFNDaERkWkRVQjhJcU1lZ2Vxb1pFMkdEc3k5RmNmc2tacHJzREFqU3dU?=
 =?utf-8?B?Y1BZZ1Y4eExjVktINGVQWjF4cUFxTGNUaXgxMlBreWFHazVMTHkrV2pGWU5s?=
 =?utf-8?B?Sk9JeUNJT3htN0p0dk5rUTBiakhDWGVGcmkwWm5tQzhFbmJBN2dOTklUTjNP?=
 =?utf-8?B?alVPSTNHOE9zMklNTlA5YlE2bWtPSHRlbDF3bUhRYk12NVhFRzFDOXFkeG13?=
 =?utf-8?B?aHdXb2hhNXdEeUQvWFZxaDIrOFlTcWZPa3ZXczV0bm1ja2JiOG9lNHkwVHpZ?=
 =?utf-8?B?c3oySDFOTUJacURva3dTSDV2d1RJUm44Q2hXSWhCS3R2VnBBdktRTm9Kem5U?=
 =?utf-8?B?NUFYM0pRZGZraVZKOVhocmY5bldycllvWFg2Q1I3cXYxM2k5R2xIZ01RRFhC?=
 =?utf-8?B?T0FwNnA2WkZpNlFTd2htWG81QUdOVk9EaklwQmFxZE9TUDVxT2grRFFpYUdH?=
 =?utf-8?B?cHVJaEpqMHkweUtXZm1hWjBoY0FZTzd6amtoT3AzUm13SllWY3d0ZXE1UTJM?=
 =?utf-8?B?ZkJKMmF2WDkycDJCWUVudGFicXNGUTFZVlFRSlR6cXh2Q3QvTHpvemNaV2Vm?=
 =?utf-8?B?bFVRZGRZcFRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anRZVTdWQmh3TW00c1BLSXNPc08xN3AvWjlwR3ZlM093Um11NldINGlJbjA3?=
 =?utf-8?B?cy9BSGNrcDZrZUFocHdxZ2F4UGthWnpQV2tVRzVaejQyRHhSSDFEbHFuWmIx?=
 =?utf-8?B?NGRVenRoNzJHUm82ZEZRQU1PN0I1Ykg0cm9uODRMSW1HVk11d1FqaGM1RGFO?=
 =?utf-8?B?bks5cHU2SHJLeXQ3dHE5NVhkNGs5R0g5T3BibUNpb0ZHb2s3OVRxWG8zWXJq?=
 =?utf-8?B?b2twbFpSbkJKeUNyYy95bjc0dE1rZHg3SDZHOGpaRzBHZDY2VjlrTDdiK3RE?=
 =?utf-8?B?UUJVbXNUZzdabUpwL1EwS3lmZC9oRW80NEoweWFLU3k2aFdSa0x3dW96eWp4?=
 =?utf-8?B?ak12MEVpcWM0Kzl1cWhnSGMwZVdjeHN3RTlhUlhEYWwyT3IyRHk1dFlsYzJh?=
 =?utf-8?B?Q2NkQ0pKSjhUcDBjSEI2UHN0U0s1d2dFdmVVTkw3R1F4dlNxcEVkY0pObVRw?=
 =?utf-8?B?VWZEbWNIamU1d29WWXpiNXVJQzZoTjJDREw1NUw4SE9laVgySk83SWkzSlZp?=
 =?utf-8?B?eHIrUGhiMnVtRWxmVGlGNWlXQkxhbEZ0SDBRSGd0bW9oSGRuU2hPVUI2VHU0?=
 =?utf-8?B?Yy9mUU11MlNTMWx3aWdhYlpudGZ5eTZWY2hYNGlnR0hHOVJXMlp6cHkwaTFV?=
 =?utf-8?B?VWU3SmNpNlV6QkpUOXNUbU5raEZicGc5d1VjcGs2cDVYZGJiVDlMdVZtQnRM?=
 =?utf-8?B?U3RRK0RCWk42ZWxhR1ZiRWhnWlhuODRGUG5iV25HV0lsemVoLzI0aTd4Vk5i?=
 =?utf-8?B?S0NCcC81RjNuRzlhUG01MjZsQ1NjK3NFeWVPd1Q3NHlRY0tqcmtLVXJldmZz?=
 =?utf-8?B?OXNpZzRsYmxUcmFrVXRPNjRjblo3blRnVTAvQzNEOWdjWXdHMDdRWWM2SFhC?=
 =?utf-8?B?NEtzTS9VMGJWUkZkZGpzN1Y1YjIzWFhVa0x4TmdEaSt3R1pNdklQaE00eXpw?=
 =?utf-8?B?eVQrbVJ6N1pkeWExUzZRbTJUNGFVa09GdjlEMFhWQUJJenA5MEZlZmxWMDRZ?=
 =?utf-8?B?TGZtNHR3NHRNdEZZUkF3blY4MFBOWWRxbS9XeHpVUnJPWmN2QmVMc2JYOGll?=
 =?utf-8?B?Z1Z4RXI0UXQ0YWFja2FURi9LUFJ2a1ljUlV0VE92c2JEZ05wVlVJbG1jZ0x5?=
 =?utf-8?B?SGFqUFhWa09ZSjc5V1FZdTY0YVE5RkswMkFaTjJSTFlrMVFpR0Q2VkVRYm9y?=
 =?utf-8?B?a0ZVZUl5cmN4c01HZ3pzOXZyckEzTno3bnlnRTFLZ2lsWTBrVDJNRFNYVjMw?=
 =?utf-8?B?dnpLVGxsZHFlQU5xVVJhbWR1c05PQkhhWXZ0Y3JLblhZQUV2UTl0SHk5UTZi?=
 =?utf-8?B?UmxjcFFlaWZZNURKMGpGd1ZaYVErNzJITzhPT1VzV0ZxMERUOHlVWEd6SnRv?=
 =?utf-8?B?Wm1ZSHNnREROdDNpZDMwR05FK09KVyt4SGxhUE9UUHI2ZGpHODk2VDU0cXVj?=
 =?utf-8?B?eWVOMGg0bzJwZ1h3eHhFMnVJMFgzR01BQ0pZVlJuLzJlMm1EV0l3ZURSbW90?=
 =?utf-8?B?OGxybmVZZERhMzczci9nYmM4STJkVGY2NENZY2ZmZnNDZUp1RGd2T3MwVWI1?=
 =?utf-8?B?Y0dvRStpOXpiZ3hqeFhiUk5vUGY0UzAzSFlvQnBpVDM5dXl0RGYrZElza0J2?=
 =?utf-8?B?bGJkc3VtVllWVXFjWjdVSS95QkttZHNaZnA1Q05qYTErS2kzdHhEeTQydXRR?=
 =?utf-8?B?R3paQ1RtcnlyMElsckJkaWQxTmpmNEZiSkttV01VSHpIS0d2TmIrRnVDUEd4?=
 =?utf-8?B?MnZSRnFmQnVNQUFEVHdiWHM4M1IxTlRhRlF5cysydjJGdmJad3BCL1JyRjY0?=
 =?utf-8?B?N053U0ZiaXVYNlE1dHhqbkpON3RpckRKUTJhb1B4NzhCYUVPUkc2TlRVdU1W?=
 =?utf-8?B?TjBhYVJVbnZmQTZ6d3dtem5sZ1ZFT1Q5a212T200NER0Vk10VEphRXIzY2hk?=
 =?utf-8?B?R0E0VDNUdm9EUjZYN2lWWUNKRGsyKzJhRDBWQTNPSWFMaE9aNXFTckkzTytq?=
 =?utf-8?B?U09jYkxoQjJqbk82enJOSWRUaTJHZTJsTzJJTFlvNFZDNDF4eU5OdFVERlFw?=
 =?utf-8?B?WVE3T0RONWVNYXB5KzBxWDlaamtZdHB4cWZIVkVKQ3NEUEpWdWh2Ly93dE83?=
 =?utf-8?Q?WHsa6ZDzffhkAEnnvRVS2m32l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dedd114-6450-4767-cb15-08dd5be9b065
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:00.2672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSkNadpni4k6GTwFxFubsK4RbICq25GaNewVGnDRWErmdr7YEkcd7/rFCQLpPYP/4zeDNSgY6zNvuFUiU6/8qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
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

This patch adds SCMI pin control protocol support to make the pin
controller driver based on SCMI, such as
drivers/pinctrl/nxp/pinctrl-imx-scmi.c, can be bound to the SCMI agent
device whose protocol id is 0x19.

Add U_BOOT_SCMI_PROTO_DRIVER() so that the SCMI agent device can choose
which SCMI protocol driver to bind by the bind function of struct
driver. This can avoid putting i.MX related code in scmi_agent-uclass.c.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 25 +++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c    |  7 +++++++
 include/scmi_agent-uclass.h               | 17 +++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 8c907c3b03..2ffdd5c881 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		proto = priv->pinctrl_dev;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		priv->pinctrl_dev = proto;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
@@ -352,6 +358,22 @@ static int scmi_fill_base_info(struct udevice *agent, struct udevice *dev)
 	return 0;
 }
 
+static struct driver *scmi_proto_driver_get(unsigned int proto_id)
+{
+	struct scmi_proto_driver *start, *entry;
+	int n_ents;
+
+	start = ll_entry_start(struct scmi_proto_driver, scmi_proto_driver);
+	n_ents = ll_entry_count(struct scmi_proto_driver, scmi_proto_driver);
+
+	for (entry = start; entry != start + n_ents; entry++) {
+		if (entry->match->proto_id == proto_id)
+			return entry->driver;
+	}
+
+	return NULL;
+}
+
 /*
  * SCMI agent devices binds devices of various uclasses depending on
  * the FDT description. scmi_bind_protocol() is a generic bind sequence
@@ -436,6 +458,9 @@ static int scmi_bind_protocols(struct udevice *dev)
 				drv = DM_DRIVER_GET(scmi_voltage_domain);
 			}
 			break;
+		case SCMI_PROTOCOL_ID_PINCTRL:
+			drv = scmi_proto_driver_get(SCMI_PROTOCOL_ID_PINCTRL);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index 0ed971369a..dbd6ff437e 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -9,6 +9,7 @@
 #include <dm/device_compat.h>
 #include <dm/pinctrl.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 
 #include "pinctrl-imx.h"
@@ -150,3 +151,9 @@ U_BOOT_DRIVER(scmi_pinctrl_imx) = {
 	.ops = &imx_scmi_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
+
+static struct scmi_proto_match match = {
+	.proto_id = SCMI_PROTOCOL_ID_PINCTRL,
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_pinctrl_imx, &match);
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30..d6586eb3ff 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -27,6 +27,7 @@ struct scmi_channel;
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
+ * @pinctrl_dev:	SCMI pin control protocol device
  */
 struct scmi_agent_priv {
 	u32 version;
@@ -43,6 +44,7 @@ struct scmi_agent_priv {
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
+	struct udevice *pinctrl_dev;
 };
 
 static inline u32 scmi_version(struct udevice *dev)
@@ -115,4 +117,19 @@ struct scmi_agent_ops {
 			   struct scmi_msg *msg);
 };
 
+struct scmi_proto_match {
+	unsigned int proto_id;
+};
+
+struct scmi_proto_driver {
+	struct driver *driver;
+	const struct scmi_proto_match *match;
+};
+
+#define U_BOOT_SCMI_PROTO_DRIVER(__name, __match) \
+	ll_entry_declare(struct scmi_proto_driver, __name, scmi_proto_driver) = { \
+		.driver = llsym(struct driver, __name, driver), \
+		.match = __match, \
+	}
+
 #endif /* _SCMI_TRANSPORT_UCLASS_H */

-- 
2.43.0

