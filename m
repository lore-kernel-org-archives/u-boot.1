Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53084C8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C75E5831E4;
	Wed, 27 Aug 2025 09:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GXitqky4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E247183214; Wed, 27 Aug 2025 09:07:05 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA7DA83192
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPWI0aiPd0N41b+i+zMARd9iGFq9MXPAEz238xlTOZNwM5VcESr1C2R448l7tn2nqdVEtDehJq85a/vMuVYcTjJ7zX3PMgegzeP0i6T/ShQ0AeopxAJqHzUmyW8x0uddlfCYiIDWgTspTeBbkYeiKyCBvRaB5AE8nwLdBytSGyjUpx/Al/B2wXURum4Z20z3ptGXZZvQSuKjF4kWmjZG9usffGCBl9DZDGetjM/aF3/9zd2RKM0TlB9N7rIk7caM9mWMnuXHnqUQnPJNEkCMqJzuO+x4aHv9UjsORYKEC15ABrkXltbtjwNxdXdznylSRi0L5zDTu9M9ai6Xc4+2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZlYBXVIBiSAonNUE+SU1Qj1Z2WgO8BGsitSD/hGv0o=;
 b=oTqbdfBqsZFJciFUShpyUWMQi1ewoBgR3s67t/j6QDHnZtlWyb7cca0SPhdyx/hFmmZ2XkcmAN1Awac/ErXjc5rpet/4xpRNZkh+/KvgA00H8yKEjoJviQ3IQSQFzZ6qb/4f8qSkkzelZuXjiTkugnzB5dyFAd4e2VY1M1GI/ZNMk2noR9fwZx2RtFLDW7QBSAjU9UPw3dNKyK1oh1YUOg/f1cMH4BmM3uObUJlTBsUP8BiA85eKw+fnkXVh9dMxq5irt9BWPHVOP2PwuJUO1wYU8UcvEqBdruMwZbRndQ/mRGrddwyZkXDi/K/Hl7FVPiEZm5IzwxUGfR8PQRSxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZlYBXVIBiSAonNUE+SU1Qj1Z2WgO8BGsitSD/hGv0o=;
 b=GXitqky4OH9lF6M3rNE/ASQiFGQNC10KbEMQXQr7pnZRh7Gv+XX7oG7K0w3K9qgWsyLHNLdk/hCcenVYXmcPNB131LlLhqNqjKE7hdN/Pev32k/A2HCttdOGjha4WkFCYQs1x0r8LRnKUjNvT1LIEzdMdgqB0wwaMIiU1eTjkofrv77d4hTqIfK9SGwfBioFM6GSeuWf8yoxa+pP3g37LICoU1RkljQhAO6toiJDAKf4/Q9Ex08w8rmmy0WMRFld5IGx2UI63fmPcX3cuQ8AzLZgizHkaX+ehOhMgo1yIkdog8zWqlxMnMEdSA46L+qc9l9G/03Y4m5BAprQSnjCdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10101.eurprd04.prod.outlook.com (2603:10a6:800:24a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 07:06:58 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:06:58 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 18 Aug 2025 02:01:07 +0800
Subject: [PATCH v4 2/2] imx95_evk: Restore support for i.MX95 A0 silicon
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx95-v1-2-f68a19fe30b6@oss.nxp.com>
References: <20250818-imx95-v1-0-f68a19fe30b6@oss.nxp.com>
In-Reply-To: <20250818-imx95-v1-0-f68a19fe30b6@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10101:EE_
X-MS-Office365-Filtering-Correlation-Id: 942458e9-e55c-4921-441d-08dde5384fa6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGNnRjZkZVRyaFdUdFZhck13WEFMQlEvMVJBUHNleVo3WUUvd2pqZW5NUGd5?=
 =?utf-8?B?K2xaNnZpbTRxc0F6MHR3cExnclBCR3lITVRuajJuNXMrd29BVDdXN3pPaEdE?=
 =?utf-8?B?YitmTHl0OFl4aVBnNG5NcXpqeFJxem5FKzNPRmU5TTBCakxwMGxmUjc1VHlw?=
 =?utf-8?B?T1ZLSm5mRURlaGxTOWdSbko3QUNQVjdvOSt4aXJyaVRoeTBqMFhoemFSSWlD?=
 =?utf-8?B?Q2JGcUhOSFBzYzJlcEozYkR1U05aVFZGQUJkYy9yWC9ZZVprVi9Ya1ZGNFFS?=
 =?utf-8?B?L0xsdjFzVThBZjJ2cTl1emFudzA5RGNhdVh1eitMVlZIbnRqZzcwNnZHSW93?=
 =?utf-8?B?Y0NuSzZJSmhYZEJDRHZvYkxSQjIxWXhNc1hpVGtlNGRWMFNSdENZcDZVblQ4?=
 =?utf-8?B?R1JyK3VvM0VvQVJpOXMvSml2ZWtnTkl1ZUwvbk9iWEpyNnEwSEJ6Y2hXRThG?=
 =?utf-8?B?dDRNZ3l3UmZYQUYxTHJxVXNuUHdWVUs0T2dlNFBLazkrcHhwRC9GTjYwN3N6?=
 =?utf-8?B?U3BHc25VNmlVdGN5Z1FRUVFRR29wd2VFbkZOUWdscGxsdVo4cm0vVmVUd2Nr?=
 =?utf-8?B?dzk5Y1ZSZ0lVZ2t6OGFRRllndWdibUpycTZDOXpWM3hPS3dGYVVTWGpJYzdw?=
 =?utf-8?B?blNJL25xdjkzeWxlQUxOLzJycEswbTdacDhoTWxmNHIvTEtYNjY5cDVZbGNo?=
 =?utf-8?B?ZjQ1by9qZzEyY1Z3VHNlRnZLNkFjNG56L1pyNTUwYmpqVFRta3FpbWR4L3JQ?=
 =?utf-8?B?dFJMelNwQWYzcjk5MmUwR3FBa1c0d2dTbUx0OVJuWFRTeFBDb205WEFWWXFh?=
 =?utf-8?B?alVTa2FweExaelc4dVRiSjRrOGUyMWp3VTNuL3dUakprYjB6SG1adWNUTXNh?=
 =?utf-8?B?YitnekZ6dlV2ZDN2Y3UxdmpVUkJscXZkbE52Z3lsZlpxdnA5MGwrMENpclBr?=
 =?utf-8?B?TWJqaGNkYnQ2RFRiS2RFZXAzL1E4d2pkalNXV2ZWVi9BcFNFelRVNThvYXJD?=
 =?utf-8?B?SXZIRkRsYW1zSzB5RkZsVWx3TzdXem5YTGVTRStocnVkNjNoUVJoT0RoaC9G?=
 =?utf-8?B?L0FnTnhMWi9WY2tUQUNLNmFSSE9rK0duQytkakVxVU1va2pYTlIrNUc5ZFk0?=
 =?utf-8?B?QjhkVncrd0VWVDl1T0lieUtBWE9WVVlBQzZaUnpaT1Z2UmFMTUtHV3JPQnFX?=
 =?utf-8?B?VjNDTGd5a2N3NkI1WXVyWUhTR2F5RUJ6cVN6MnZQaEZWbmcya2dnL3B0TUYw?=
 =?utf-8?B?M0R1NFNiaVBKejJkTUFCK3I2cU9GUGlNdHkvOWtNN2JiZVVnTm5wNmJ2eWxU?=
 =?utf-8?B?clp4R2loSTl0V0MxSC9HUWpDdmk1Y25lbzdnWDFlNXZySFBMNjQ0eGk5WXFX?=
 =?utf-8?B?eXZIU0tIY0tld1hEUXBoaFFHd0FxWXpZYlUyS3hoREdqK21Xc1JQSENZeElL?=
 =?utf-8?B?MU1SenF2OWVkVkc2dncwcHlNbUhmNGdmb1JRejFhVXMya2NTZHlkSnJJNmJD?=
 =?utf-8?B?MVV4Rmg0c1QyS0ZGZEZKUzJEZ2FZcHVhSnowZ1UyVVZNYllsSVcvK1ZYQkxa?=
 =?utf-8?B?TE1EQlFBUklxZmxYbzdnVkl6SXZVUW1peVprVGk0c2hkakxTV2RnVEliRVlU?=
 =?utf-8?B?RE5YNHJLbG8vSWZhaDRVN1lYY3RWMUtZZ0NLZ0RBeitEUS9sQm9UZnovK0Vk?=
 =?utf-8?B?bHVDQk51TlpBejJjekcwREdHSmoxTGV5NW9iUEF6eGluWDZxaHNPY0pUa2p4?=
 =?utf-8?B?UGNESHVwZEJSVUdNcjZuRW83Y1hWQi96dHpwRXVQWm5pMlcrQTZyUDJSV2pN?=
 =?utf-8?B?RitnVSt0c055Vyt2MUk3R0dzK3dwdXZTUjFXZDFJZ3FVRGNHU3dFeFMvQlBs?=
 =?utf-8?B?SHpmbnk2UjkyczFibloxZDBEVEQyZWhpb2QrNjhjcURvdDl1Mi9lcVlPK0lR?=
 =?utf-8?B?Vnd0V3BMOWtjQmkyMDJiUHZOaXRpS1VGNlhmS1hSdUJnaVdiYTZTVEthZElL?=
 =?utf-8?Q?tXdp3fIIz4hjTZ5el1DRVY/pZUdJfA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWlKOElHQ1dJZEd6ekUzRVZuaDBzK21wNkdlL04wYzdZSkJla01yTjV3dktv?=
 =?utf-8?B?VlF5Q0p2eUhiVGlaVUtPOU53Z3puV21ZTmdkRHJ5TGtQRFVRM0JGYlNrbGUx?=
 =?utf-8?B?V1JHWis3UEFyRGZabVRWMnljamhhZGYvU0wvYlM3NmRSL0p2NFhvZHpNWGRD?=
 =?utf-8?B?SlVQbGZEREs4N0p4VG9VVHdycTV0SzZ2YzFyRk00UzlZL25FaTU2c1hGaXlu?=
 =?utf-8?B?a0F4ZXh5enRrdVpqQjJJK0hkNGhSek0rc1dXaHBZK0RDK2dFdys5cXU0RnFv?=
 =?utf-8?B?TmtmQXJTdm9SOWVnMzBDRnUwV2FmYnNmamJaWTZaejd5b0w5SzlOcTZrSll0?=
 =?utf-8?B?S0g3WDhBSXE3T0NBWmhoUWgva0tKVFJHcFNzd0N2SzVlTVdYNEtPbWQ4UW01?=
 =?utf-8?B?NTF6L0QvNy9KUmFFdVhoVm8vY2doQURWRVBWV2llRjlwQWE0TmlMWnhvYjAv?=
 =?utf-8?B?VCt1V1p0Z08rQ2R2QTFOM2hRMjVKNFlDY2hTQTI4cStDYTl3VFVOMlk0NFMz?=
 =?utf-8?B?TVM2SjFRTTJRM2xBaTFXY3o1YUF3QUhsZjdGTHdqTXp5Sm5nMVBOSFBiaTdM?=
 =?utf-8?B?bU94ejNhWnpkUTljcXFvZ3lqZGZKQjMwamdDL0tjbmdhQllVT0VZMXhNUjg1?=
 =?utf-8?B?ZVhLMmo5TkZ4MFBTbk9IMm4waWtYK0VPaWpHaGRLbWJ1dzVWWWx2ZTJzQktJ?=
 =?utf-8?B?ZWg2bVNITzhYY2RMa3FRYjZ2NENzSldwNW4yYnRyWVhyc3RnRitscTl1Qk90?=
 =?utf-8?B?SFFNMGVsNkd2bmZTTXYyczZQbWYxaHFtT1dLRXdOSm53NXFjcXA1SDVJRVFU?=
 =?utf-8?B?TEhCUGJJbFZxMFdvUEZ6dTU0NmJjS25PUzlIVkdsQm02K2lqa1crK21BVXhj?=
 =?utf-8?B?Z0haakR1Vm53RUFkZFUyRjl2NnRSVE14RjNqOEh5RnBUcDFqM3VUVWl2ZWJo?=
 =?utf-8?B?NytSalVJSVFIc0UrN1RDaVh4WDZtYzJiS0pVQVJ1ZDJjd1dvY2dKODJJeGNa?=
 =?utf-8?B?V01QSFpSSHl0T2RneVI0T0hPbGJCMEhMZ3grcGdnRHVTMmgyOFIxS2h6ekhk?=
 =?utf-8?B?OFYybHlDZ3RFMy9pVzQzOG5IWXF3NnpQMEVFdFppRVB6SWR6dHU5TW44YUZu?=
 =?utf-8?B?STFDbEZOUUptdDltTDdHZ2ZXM2IzbGRsdHF2TmdqMlV4bENMQUNtZkVFNjZP?=
 =?utf-8?B?QlZLVWxFRllaaHd6THZ0Wnc3VlJxR1k1SDJRVS9xaDZmUDh0d1lWaGlWT1B6?=
 =?utf-8?B?Tjg4bmVCVHJIMWlodUh5UVRqb2llLzJIOUtaQVFvUHlZK3ZZeVRaVWxNbkM1?=
 =?utf-8?B?RmFKRUFlY09XOXpML1hXVHlGQS81YmRUL2xrRXpZaU5xNkJvVHJKR0w4Ympu?=
 =?utf-8?B?NzRMNzkxeC9mWFlUTWQ4UUp1eHNuSkdkaE9hR0tkcnZndGxTWjBPRFI3blIz?=
 =?utf-8?B?Uzh3bEVua2MwNzQ3eDByV1hCeFk3VUVtNldFZnQ0eHlSaWRlRVNWbjJ3OXZ5?=
 =?utf-8?B?ZHczbVNOWjJIcUJkYStrRHFNSGZmMkxPY1g4RGV6QTdQSmx4SmZ5TCtDZmd4?=
 =?utf-8?B?VkRiWTAxWmJ3SkhMNjN3eUwxS3hBRExtNVFrN2xtTFQycjkwUHJQb0JqTzB1?=
 =?utf-8?B?ekp6c3g3blh4aUM3MzlGNmhwN1d4enFkQmpwMy9hQUNySU02bk9xWUkvaWs4?=
 =?utf-8?B?SGZ2aDdWcE1BeGpOL3RYUWhWcU83bGRBb00xZHp0bnZLdWhWMit0V1FlcG5E?=
 =?utf-8?B?UWtheXlNS0NNczBVNTFZOXk2a0VadXlUbkZQNmZyTllYOTBkQXowWnhGUkd3?=
 =?utf-8?B?Y0tQaG0zNWU1ZFRVU0pBMlA2U3BaKzFGT2RMMVBoYVZaMGNnUUNoWVVuQnRy?=
 =?utf-8?B?N2xRN0pQZ2JFVDN0OHdXWkJkUnJ3akJPWFFxSkdENkVsckIwOXdYamVRQ3Y4?=
 =?utf-8?B?WGNwaFBDMHAwSjNEYi9aUTdTUXJBWHFFNjZvTmZ3RXErc21FRXdJTFU4dE1D?=
 =?utf-8?B?TVMzWjRUZlhVN0lQYXFxQndNeXpvL0VkODNjamE2MVE1OVVpS2NFYXRZb2tr?=
 =?utf-8?B?SFptcyt1MitheC9VQlVZSHBhank3MGg3eHY2Wm9ldXpINlQ0Q3g5Z2txZnVG?=
 =?utf-8?Q?jfM1XvaZF3LOvBis6dw3SuBsd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942458e9-e55c-4921-441d-08dde5384fa6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:06:57.9929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gqh+FKwHUr8HOu6YqZsxC+NdfVXZEt/krlF+TIlxjDJZYfZAA+IC2853Nq7U8Pr309TpoYdQiBg6hy6oyGPpsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10101
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

This patch is used to restore support for i.MX95 A0 silicon. To avoid
duplicating defconfig, imx95.config is added and can be shared between
imx95_a0_19x19_evk_defconfig and imx95_19x19_evk_defconfig.

container.cfg and imximage.cfg are used to created .cfgout files that
are be passed to mkimage with -n to build flash.bin. Now they have been
deleted and replaced by adding their content to properties of node which
type is nxp-imx9image under binman node.

Fixes: 9936724aa9b ("imx95_evk: Add i.MX95 B0 support")

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Tested-By: Tim Harvey <tharvey@gateworks.com> # imx95-19x19-evk (rA0)
---
 Makefile                                  |   3 +-
 arch/arm/dts/imx95-u-boot.dtsi            |  44 +++++++--
 arch/arm/mach-imx/Makefile                |   5 +
 arch/arm/mach-imx/imx9/Kconfig            |   5 +-
 arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
 board/freescale/imx95_evk/MAINTAINERS     |   1 +
 configs/imx95_19x19_evk_defconfig         | 153 +-----------------------------
 configs/imx95_a0_19x19_evk_defconfig      |   2 +
 configs/imx95_evk.config                  | 150 +++++++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst               |  42 +++++++-
 11 files changed, 241 insertions(+), 191 deletions(-)

diff --git a/Makefile b/Makefile
index b4f10c08d75..569a2c0070b 100644
--- a/Makefile
+++ b/Makefile
@@ -2469,7 +2469,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
 	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
-	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot
+	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot \
+	       imx9image* m33-oei-ddrfw*
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 9bf8f9834c9..de74398fdfe 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -52,15 +52,47 @@
 			pad-byte = <0x00>;
 
 			spl {
-				align = <0x400>;
-				align-size = <0x400>;
-				type = "mkimage";
-				args = "-n spl/u-boot-spl.cfgout -T imx8image";
+				type = "nxp-imx9image";
+				cfg-path = "spl/u-boot-spl.cfgout";
+				args;
+
+#ifndef CONFIG_IMX95_A0
+				cntr-version = <2>;
+#endif
+				boot-from = "sd";
+				soc-type = "IMX9";
+#ifdef CONFIG_IMX95_A0
+				append = "mx95a0-ahab-container.img";
+#else
+				append = "mx95b0-ahab-container.img";
+#endif
+				container;
+#ifndef CONFIG_IMX95_A0
+				dummy-ddr;
+#endif
+				image0 = "oei", "m33-oei-ddrfw.bin", "0x1ffc0000";
+				hold = <0x10000>;
+#ifdef CONFIG_IMX95_A0
+				image1 = "oei", "oei-m33-tcm.bin", "0x1ffc0000";
+#endif
+				image2 = "m33", "m33_image.bin", "0x1ffc0000";
+				image3 = "a55", "spl/u-boot-spl.bin", "0x20480000";
+				dummy-v2x = <0x8b000000>;
 			};
 
 			u-boot {
-				type = "mkimage";
-				args = "-n u-boot-container.cfgout -T imx8image";
+				type = "nxp-imx9image";
+				cfg-path = "u-boot-container.cfgout";
+				args;
+
+#ifndef CONFIG_IMX95_A0
+				cntr-version = <2>;
+#endif
+				boot-from = "sd";
+				soc-type = "IMX9";
+				container;
+				image0 = "a55", "bl31.bin", "0x8a200000";
+				image1 = "a55", "u-boot.bin", "0x90200000";
 			};
 		};
 	};
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8bd85e889ab..fa2cdaba144 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -223,6 +223,10 @@ endif
 
 ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 
+ifneq ($(and $(CONFIG_IMX95),$(CONFIG_BINMAN)),)
+SPL: spl/u-boot-spl.bin FORCE
+	$(call if_changed,mkimage)
+else
 quiet_cmd_cpp_cfg_imx9_check = CHECK    $@
 cmd_cpp_cfg_imx9_check = $(CPP) $(cpp_flags) -D__ASSEMBLY__ -x c -o $@ $< && $(srctree)/tools/imx9_image.sh $@
 
@@ -244,6 +248,7 @@ u-boot-container.cfgout: $(IMX_CONTAINER_CFG) FORCE
 flash.bin: spl/u-boot-spl-ddr.bin container.cfgout FORCE
 	$(call if_changed,mkimage)
 endif
+endif
 
 else
 MKIMAGEFLAGS_SPL = -n $(filter-out $(PLUGIN).bin $< $(PHONY),$^) \
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 4e0e194690b..b6acbb20ff0 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -25,6 +25,9 @@ config IMX91
 	select ARCH_MISC_INIT
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95_A0
+	bool "Support for i.MX95 A0 silicon version"
+
 config IMX95
 	bool
 	select ARCH_MISC_INIT
@@ -33,7 +36,7 @@ config IMX95
 	select DM_MAILBOX
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
-	select IMX_PQC_SUPPORT
+	select IMX_PQC_SUPPORT if !IMX95_A0
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
deleted file mode 100644
index b25f3b726c5..00000000000
--- a/arch/arm/mach-imx/imx9/scmi/container.cfg
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2025 NXP
- */
-
-CNTR_VERSION 2
-BOOT_FROM SD
-SOC_TYPE IMX9
-CONTAINER
-IMAGE A55 bl31.bin 0x8a200000
-IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
deleted file mode 100644
index c2c92174c1c..00000000000
--- a/arch/arm/mach-imx/imx9/scmi/imximage.cfg
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2025 NXP
- */
-
-CNTR_VERSION 2
-BOOT_FROM SD
-SOC_TYPE IMX9
-APPEND mx95b0-ahab-container.img
-CONTAINER
-DUMMY_DDR
-IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
-HOLD 0x10000
-IMAGE M33 m33_image.bin 0x1ffc0000
-IMAGE A55 spl/u-boot-spl.bin 0x20480000
-DUMMY_V2X 0x8b000000
diff --git a/board/freescale/imx95_evk/MAINTAINERS b/board/freescale/imx95_evk/MAINTAINERS
index 5caf763e0cc..9d5c4e41b65 100644
--- a/board/freescale/imx95_evk/MAINTAINERS
+++ b/board/freescale/imx95_evk/MAINTAINERS
@@ -3,4 +3,5 @@ M:	Alice Guo <alice.guo@nxp.com>
 S:	Maintained
 F:	board/freescale/imx95_evk/
 F:	include/configs/imx95_evk.h
+F:	configs/imx95_a0_19x19_evk_defconfig
 F:	configs/imx95_19x19_evk_defconfig
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
index 73818a82627..542b71f5c07 100644
--- a/configs/imx95_19x19_evk_defconfig
+++ b/configs/imx95_19x19_evk_defconfig
@@ -1,152 +1 @@
-CONFIG_ARM=y
-CONFIG_ARCH_IMX9=y
-CONFIG_TEXT_BASE=0x90200000
-CONFIG_SYS_MALLOC_LEN=0x2000000
-CONFIG_SYS_MALLOC_F_LEN=0x10000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=3
-CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
-CONFIG_SF_DEFAULT_SPEED=40000000
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0x700000
-CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
-CONFIG_TARGET_IMX95_19X19_EVK=y
-CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_TEXT_BASE=0x20480000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x204d6000
-CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_LOAD_ADDR=0x90400000
-CONFIG_SPL=y
-CONFIG_SPL_RECOVER_DATA_SECTION=y
-CONFIG_PCI=y
-CONFIG_SYS_MEMTEST_START=0x90000000
-CONFIG_SYS_MEMTEST_END=0xA0000000
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
-CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=2074
-CONFIG_BOARD_EARLY_INIT_F=y
-# CONFIG_BOARD_INIT is not set
-CONFIG_BOARD_LATE_INIT=y
-CONFIG_PCI_INIT_R=y
-CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_LOAD_IMX_CONTAINER=y
-CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
-CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
-CONFIG_SPL_I2C=y
-CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_POWER=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_SYS_PROMPT="u-boot=> "
-CONFIG_CMD_ERASEENV=y
-CONFIG_CMD_NVEDIT_EFI=y
-CONFIG_CRC32_VERIFY=y
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_CLK=y
-CONFIG_CMD_DFU=y
-CONFIG_CMD_FUSE=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_POWEROFF=y
-CONFIG_CMD_SNTP=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EFIDEBUG=y
-CONFIG_CMD_RTC=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_GETTIME=y
-CONFIG_CMD_TIMER=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_HASH=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_NOWHERE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=1
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eth0"
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SYS_RX_ETH_BUFFER=8
-CONFIG_SPL_DM=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
-CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_CLK=y
-CONFIG_SPL_CLK=y
-CONFIG_SPL_CLK_CCF=y
-CONFIG_CLK_CCF=y
-CONFIG_CLK_SCMI=y
-CONFIG_SPL_CLK_SCMI=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_RAM=y
-CONFIG_SPL_FIRMWARE=y
-# CONFIG_SCMI_AGENT_SMCCC is not set
-CONFIG_IMX_RGPIO2P=y
-CONFIG_DM_PCA953X=y
-CONFIG_ADP5585_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_IMX_LPI2C=y
-CONFIG_IMX_MU_MBOX=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_ES_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_MT35XU=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_AQUANTIA=y
-CONFIG_PHY_REALTEK=y
-CONFIG_DM_MDIO=y
-CONFIG_MII=y
-CONFIG_FSL_ENETC=y
-CONFIG_PCIE_ECAM_GENERIC=y
-CONFIG_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX_SCMI=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_SCMI_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
-CONFIG_SPL_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_SPL_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_RTC=y
-CONFIG_DM_SERIAL=y
-CONFIG_FSL_LPUART=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_NXP_FSPI=y
-CONFIG_ULP_WATCHDOG=y
-CONFIG_LZO=y
-CONFIG_BZIP2=y
+#include <configs/imx95_evk.config>
diff --git a/configs/imx95_a0_19x19_evk_defconfig b/configs/imx95_a0_19x19_evk_defconfig
new file mode 100644
index 00000000000..9376f11b151
--- /dev/null
+++ b/configs/imx95_a0_19x19_evk_defconfig
@@ -0,0 +1,2 @@
+#include <configs/imx95_evk.config>
+CONFIG_IMX95_A0=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
new file mode 100644
index 00000000000..231b42cb377
--- /dev/null
+++ b/configs/imx95_evk.config
@@ -0,0 +1,150 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
+CONFIG_TARGET_IMX95_19X19_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_EARLY_INIT_F=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
index 27cd15eb7c9..709992e016d 100644
--- a/doc/board/nxp/imx95_evk.rst
+++ b/doc/board/nxp/imx95_evk.rst
@@ -25,6 +25,17 @@ Note: srctree is U-Boot source directory
 
    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
    $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
+
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ cp firmware-ele-imx-2.0.2-89161a8/mx95a0-ahab-container.img $(srctree)
+
+i.MX95 B0 silicon version
+
+.. code-block:: bash
+
    $ cp firmware-ele-imx-2.0.2-89161a8/mx95b0-ahab-container.img $(srctree)
 
 Get DDR PHY Firmware Images
@@ -53,12 +64,24 @@ branch: master
    $ export TOOLS=$PWD
    $ git clone -b master https://github.com/nxp-imx/imx-oei.git
    $ cd imx-oei
-   $ make board=mx95lp5 oei=ddr DEBUG=1
+
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ make board=mx95lp5 oei=ddr DEBUG=1 r=A0 DDR_CONFIG=XIMX95LPD5EVK19_6400mbps_train_timing_a1 all
    $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
 
-   $ make board=mx95lp5 oei=tcm DEBUG=1
+   $ make board=mx95lp5 oei=tcm DEBUG=1 r=A0 all
    $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
 
+i.MX95 B0 silicon version
+
+.. code-block:: bash
+
+   $ make board=mx95lp5 oei=ddr DEBUG=1 r=B0 all
+   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
 Get and Build System Manager Image
 --------------------------------------
 
@@ -82,13 +105,14 @@ Get and Build the ARM Trusted Firmware
 
 Note: srctree is U-Boot source directory
 Get ATF from: https://github.com/nxp-imx/imx-atf/
-branch: lf_v2.10
+branch: lf_v2.12
 
 .. code-block:: bash
 
    $ export CROSS_COMPILE=aarch64-poky-linux-
    $ unset LDFLAGS
-   $ git clone -b lf_v2.10 https://github.com/nxp-imx/imx-atf.git
+   $ unset AS
+   $ git clone -b lf_v2.12 https://github.com/nxp-imx/imx-atf.git
    $ cd imx-atf
    $ make PLAT=imx95 bl31
    $ cp build/imx95/release/bl31.bin $(srctree)
@@ -96,6 +120,16 @@ branch: lf_v2.10
 Build the Bootloader Image
 --------------------------
 
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_a0_19x19_evk_defconfig
+   $ make
+
+i.MX95 B0 silicon version
+
 .. code-block:: bash
 
    $ export CROSS_COMPILE=aarch64-poky-linux-

-- 
2.43.0

