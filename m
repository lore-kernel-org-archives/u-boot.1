Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5B5D1D482
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 16:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D2B84228;
	Thu,  8 Jan 2026 17:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="S5dowQvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED868422D; Thu,  8 Jan 2026 17:33:42 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50ABA8421C
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 17:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvePDtUOFqDU4bRNBxxqQ5zKxKEWcE4UEaJ07RC14bYvRZEiDF8bmmQpMfBtvOKJEWxNH9RmHunAwYeIca1+Js08YU0EzsYGW3QdEyxZU+DlZGyJtiWuAc0FIi4Wmh1PxmzIlvlxOr4+0hMgxXb8QzZuw9LE8MPeZ2Lq7jpe3z28RYLZYAa61586Ts+IVaR2e8qjGntbCG2+UI7Drst/qgQRYqChL2710jt5eT4hPoG2nUNsXoN825KkgdpphQ6+D9gA6AWi7Fzn1cECEn70mMlrpIU2QLMIaqOc5ttMNJ52va+8IsgRBkb8Pepw865YljBDTpNOILvhKVO35ECK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUrxnMp0JDhOfnFLrhTGnMtEmWg4wBTCJfQNvmSTVBo=;
 b=hKA2IRL3qSOMeXuJXYZ8OumuQ/MYxidS6+tD2uxSggkaJMYzbupDBsCA4+Ux1qTGjBcwhWAwJJRA9SikFOP+O5cP5Uy70ulIDx83Q/DQgp7YawPPv2TYRk7VM08q6NHBPHHqX07iopGNrOMOHIL1WM7YumGCZtyzoFOez0bNUlMKNfGS+kTnW19tKqI5pGko4PcvpTk+9bzEEfLO5ZPkqhujlYQzWoD17aO3tu4vynRcjjXnjlw1rHP2MlWVRrie/IhH5x5cJbAgHzeCQXTQB5nCBHa6611XLsk3sAEsGQ+72POSpDyOmLtGyZcplUPW6R8ML2eBUjGY2yLiX2Gf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUrxnMp0JDhOfnFLrhTGnMtEmWg4wBTCJfQNvmSTVBo=;
 b=S5dowQvYjCrEXxxa8UzlcSiZm98524apct0DzjOlYay2UIKjKv+cunGZqVijZHq3ALT0xvQqkiPrNBZyspQs7bodK+kxWM/PuzUSO1onAYJ6xpkIuRXJx0y5BpE4nbjLUs3VsoDpSaH7CWFn/YqcpmkdZu1Ir54gzMuMUwaeMkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB11045.eurprd04.prod.outlook.com (2603:10a6:800:25f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 16:33:36 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 16:33:35 +0000
Message-ID: <bf3a7773-8b66-478d-b45b-f032cf93347e@cherry.de>
Date: Thu, 8 Jan 2026 17:33:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: RV1103B: Attempt to upstream
To: Fabio Estevam <festevam@gmail.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, U-Boot-Denx <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, xuhui.lin@rock-chips.com
References: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::23) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB11045:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a2fa0a-cebd-4681-41c4-08de4ed3ab7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHJmSUp5TlBtczJqeDFxZWp4V0I5RENTcG8yVk1mRWFyWTI1eU1pbG9UQ1Nm?=
 =?utf-8?B?N1Q1Q3ZDRXNVdFJCNFhGNFZYbGxnR3oxNFBVTnVWM3lnRGR3SEZaWno0UzVq?=
 =?utf-8?B?RHlMVFBENTlZeE11WmkvR2FvWlpKeE5lLzJwK25iRWk0TWF6WUJLNTlBeHRZ?=
 =?utf-8?B?eXc1dXB1c1d5SXZYOU9QL1pSQlYwazRybnJwaWZLdmxNNFVFVitaVldvaThq?=
 =?utf-8?B?ei9aSWlCOWpFUDRGV0NPNXZSbjNVUXQ3RXVPZ1EwOUtNM2hudzBwc0JsaUN0?=
 =?utf-8?B?SUI3em9RQkFIK1Q2U3pKbXh5OFVBVUVTUVBxQjJJR3VvZlptMFJnTFZSdnZD?=
 =?utf-8?B?V0xhL1BtdnZTa0Q0aXBubUp3NzJWT1VTMHdqMVdSSmhZd1ZGZDE5eW9Zb2xj?=
 =?utf-8?B?ejlUaEtaelB1VXE1V3pBRUViM21rcmQzOFVWdEk1T1VqTUhDS09WYnZnREZE?=
 =?utf-8?B?a0loVU05RnUvZ2xPQXljMUYzRUdHcWNMOWVzMmNlUzYyQlJJcHJXZUNtWE81?=
 =?utf-8?B?bmd5QkYyUGRlQTFyMmQ4MitldXorS3FCUFNKcHZuNGlIRUxRWmR1YXgyK1Fa?=
 =?utf-8?B?TzhWQWVYTDk1RlFSNEVPVFBzTWlHbTU5Zy9HUU8zRjJtZjR6M3pGeHJ4bndF?=
 =?utf-8?B?bk5sMzZ1MkZpdFczdG5NOUNGV3lzdVcxSHIra2dXRU5GVUMyeTZydkVwbFAy?=
 =?utf-8?B?N3hsaXdjUkt6ZER5d2ZtWko5bVhTR0JhbDBvdzFYR0JoOVRpN3loTFlaK2Ex?=
 =?utf-8?B?SWZzUHUrdG8yNnE2Rk90Yjk4NVQrSUNoN0VTT3FVZ1ZnWlRpaEN4eEhmTzNC?=
 =?utf-8?B?TDJaNlp6TGpnTFlPNVNPa2luZEpiQWZEVGMvdnBqTDlxS0hGVzBPODYwMW1O?=
 =?utf-8?B?SWZ0UkpsTWFUT08vMFJidGNSbU4vSDdlUWlQRE8wa1hXTjRQYXR0bjYrR2ky?=
 =?utf-8?B?c1lCeFprelY2TEE4cXliODZ4UjJyVnowdWtpUEY1MTNxL095Y01zUG1nV203?=
 =?utf-8?B?ekFoTjFTQ0l6akJzUW0yYlU0cW1SckV4cGlyaW1mM0ZXNTRvM05wOWVYWGJY?=
 =?utf-8?B?dXJYT1V1L25USVYraDFhNUJVeEtZYnNNbHhueXpQSDUzZE5Oa01sNmIwNzc0?=
 =?utf-8?B?M0FHdmdrNDREYUwzL2Q1R01pYlJySEFmSFh3MkZmK0RCdTJ5c2RDSExJWkZS?=
 =?utf-8?B?SWtzWkUxajFyQUxvNC8yRDl2WVhqSEtDTFJBdlptY1g2aGdGaWVpYzZnWkJJ?=
 =?utf-8?B?L2dORWM1OEhSNUM1VEtVSG9BZGtvNjVDdHdzcmhJVm9XYVYrZU92NlU5aUdm?=
 =?utf-8?B?UkZkZ0RMWFpFclJQalpaOFZGNnlwRWV3L2UyRFdZY0NaVHJ3N1pPRlNmdXJm?=
 =?utf-8?B?NTBrYmoyM04vWHpPZVVzVTNWRTBHYnp3M212THArSjF6bThQSWs3Rk9uMEVt?=
 =?utf-8?B?T0FnblZtU3VMODhIM2NIKzlUbUdUb3ViSW12VDRqcEhEdmdoNHpBRURpdW43?=
 =?utf-8?B?OC9jZHZwVE5IWTg3ZUUwM2QzcmtZZ1gxWlhnd2gzMHhMUDc2T3R6RDdrTEYr?=
 =?utf-8?B?aTQwNHVTSU9tV3ZOUTBxOHRJNkFNcTVjYVJERHJzeWVlU3FwdTRxTUlJWlpP?=
 =?utf-8?B?Sk80YVhkMGdlV1RpODIxYlNEdXV6UmJEVlpmR1YrSGlSVG41T3VSc0FCNmQ0?=
 =?utf-8?B?WmpUMmdrN29wejl5eHJ2N0piZFZoMGtBdG1ZRkhhcVNkL2wvTkN1VGFQV3FI?=
 =?utf-8?B?ZWRDVlUwTGdHWEZqTFlmMGxIekZSNDV3YTQvcWF1UjFaRzdVZ0JTTll4SVhz?=
 =?utf-8?B?bVkyOUlwSTkrWkJFTHJORmFNeWJnWXZ3NzJmQUpMSW9lUWVyWjJLVXUrTFFZ?=
 =?utf-8?B?M1k5YzBWek1RZGZVY1VwTEJUS0YxTTlDR000L0FnWEhqQUpueWcvdWI0dUZh?=
 =?utf-8?Q?2Hr3e7p4nBKAMOMkD87bqp1g3wyXdExR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBTNWRZRUhTdlpuUEQ4RHUySUhaOVh5UHloK3lHNVA3OERlRS9STUlYTUFV?=
 =?utf-8?B?M0kxc2U4eDBKQTN5M2lnbjRRL09FQVFveTNyMUtLK2ZCQ21vVHFsOHp4UnAv?=
 =?utf-8?B?N29Wd2crMHc4L1ZLcVNTYm9LakNlUFZzRjRLekQrWXpMdkk5NnQvazQyYnZj?=
 =?utf-8?B?SmtYbzJJNkhUbW5XMkZMZGtWbnVPYnk1NWhqSVd2TVpVdFhLb1JGRXpQeFBr?=
 =?utf-8?B?MDBkdTdJZEtzV1U5M3ZBcG5HbGYwZUdvQmZDOUFuUzk0Y0haRzgxSHFUcDdu?=
 =?utf-8?B?NHdTVjlSUHlKbzBTbXVTSnBZTEhDVERNY1hCa0l4QlF5OFRPUEF3cEZabWRu?=
 =?utf-8?B?QXZncUFBK1dhTnRoZjgwbkNXMVhEWk5vRjBGdDhDdDF4NGZMZkJzNGhnMGZM?=
 =?utf-8?B?OTdTdnRHR3ZRL202cVdIUXFtNjJVLzJzeFpsS2ErQjhadzhoam1pZ3dobktB?=
 =?utf-8?B?NEQ0VXFTZ2wxNFVnZkF5amFDeTlRcjMxdHVxbFdQdmhFTTFEZ2RrcmZudDNy?=
 =?utf-8?B?cmFldS9UbkYyaTE1dm9udms0bjZzUTVYRFhLQjkrS1NuSUhyRW5uakMyVVUv?=
 =?utf-8?B?VEtxYk95TjVaaGlJU3dRZlJlWUZXYUk5Sm8yaUhuU2tacnVGM3huSjM3NEt2?=
 =?utf-8?B?TjVVWWpaU3lFS0J0QS9XaVN0dXpwT1paSVUwZWRoM1hOMVdqL3FVUXVnSzdj?=
 =?utf-8?B?RHNFemF5RXZFOVhvNXhUSVFibGRxNXV1TEIwU1RQTnNyai9vTXZ0T2dSOGtD?=
 =?utf-8?B?eFlEWEtQM01tYUMwakd3UWFhWU1vb3lRUVVSOTRzRC9CWDBYcGJlSDJyb3ox?=
 =?utf-8?B?V04rK2VUSTlQVy9WR0ZYOE5LZnNxSVZGTjhOYXZyckdzV2N3eFE0c3hEZjN3?=
 =?utf-8?B?bU10bmtCTWpxbHdoK1JnNXU0L2QwNkg5d3Z2ekNtZWIxQzBuWk5UaThVTzJL?=
 =?utf-8?B?bmNIY01jdVZRSDNmL1o1dFR5RFFUY3Jrd3lBeTh4c21QZmJhb3lwU2FFVWJS?=
 =?utf-8?B?VFRORWZ5dEN1UERCRUNNTk5KaEZnZWRMRUVLZWIycHpqUlhXRGJQVnVhanR3?=
 =?utf-8?B?M1Uxd2UwUDBHc1dwUXZsMVI5dHVWdXJvaXBTZDRqS3BzU28yTCtuMkN4d2c2?=
 =?utf-8?B?aW5mWEJZT0h0WWljTU1SS0VtazgrRHUvZjZScTQxNzlVNGdYYnFTT2JKTnUw?=
 =?utf-8?B?YkRtMlFYUmZ3T1JyaXlWSkFMRmxSSjRvMFhZaU5vaFZSQitSS1NmOGxSWDI0?=
 =?utf-8?B?bDNGcnJaUDMyK1pPb2oreXE5N3FEV3BJekVUZFp5UFRQc3E2Uy9UT2dsalFB?=
 =?utf-8?B?WEtwWTd1eHpkRjBUSUNnNHB4QlE5NFh5ZHFuY1JEU2JJTHA1aEQzZXJ6aUhX?=
 =?utf-8?B?SFpMZnlHZmlxN3JKRzNQNk1UWkYyTUZYUnlSOXBrSWJFRlZxVjRDSFdYTXVs?=
 =?utf-8?B?OVNhSG1BMEswZHBINGlSMUdUekxIdzRva2Z4SkZ4V3BqUEN1OHFVV0JiZTkx?=
 =?utf-8?B?NXFVN3NDRVd0MEpoVUVVNVFPOWhEeWt6YS9XYlAvWnJQcE8ydUdRZm1LbTlv?=
 =?utf-8?B?WnViaG1TT1UvSHZNeFRJSmlaR3hiN1FNUTg2MnRIc2xNZVZNeVRZQlRVdndB?=
 =?utf-8?B?OS9QZmRObkl4NVJFTzFRQ0VOWWJBRTV4aHU3eEFCTzFJa0ZyZjM1Qnkvank3?=
 =?utf-8?B?WjlnemRESU55d04xNlBLL3F5SElDTG00RWhORFNNd2FBTXRuSFI2WldtVkdK?=
 =?utf-8?B?Q0lnQTVwR1FPekNNd1F5MGxKMEh2QXpncm1wbW54aDczVjdCZG9Fam12VXFt?=
 =?utf-8?B?Q2R1UU5RZGdGcUxhWTExaG9aeXBMUFdhZUVPSzZFL2xMV2JLSzhDWVZsbHN2?=
 =?utf-8?B?OUROKzRnc242M0xLR3NLY2tWV1JDY0Y0a3Y1VWhPZGh6WXY4NXExb3VabTFJ?=
 =?utf-8?B?SERkNURLZWFaZUY5a2tpZUJncTh6WUlXYzc1YkZxdzhISWMrWnJFRVhCWHlz?=
 =?utf-8?B?NWRkUDYrVGo0ZGR3dm1aSk1tb3dyNE5yUDI0ck5hazBHU0VLbG9ZWEU3M0Rv?=
 =?utf-8?B?NFpIRDRpdXlqeStSSTdpSmhkY2c0Wjh4dHNZZUd6U3FRR01ZeFNOU0pMSzVD?=
 =?utf-8?B?UDA0S0J3SGxzN1l2N1BITnI1RXlZaHhOSmY1RnZ6WVQybFVaS1NkdDMwMTg0?=
 =?utf-8?B?WHNtYmJkQTY4TWpWZVVYeUdLQmF6SmxGRTJGOFJnaTBsRkEzNkNGZ1BFcDRs?=
 =?utf-8?B?Qi93WGRzd1RlYlFLUW9SaEpwZ3V0dVZScTZQMGdhMnZQbDBiSU5xTk1tVk1S?=
 =?utf-8?B?K1JMSForL05rVThZeS9xMlR5TzMvQi8yZlB3VzYzSjFRTE95SmNSZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a2fa0a-cebd-4681-41c4-08de4ed3ab7b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:33:35.6683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yA0DYyRh4LId1hUDlXR2ijT4YFhnQy9nnvm764NwUmJxeC0+ulHryYElu4iEgLYSvJ9rcHVR4NTKO45qYg4rd2KLZO3FlogqBFDzaEUYevs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11045
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

Hi Fabio,

On 12/19/25 3:45 AM, Fabio Estevam wrote:
> Hi,
> 
> I have a custom board based on the Rockchip evb-rv1103 (RV1103B silicon),
> booting from SPI-NAND.
> 
> I can successfully boot the vendor Rockchip U-Boot v2017.09 on this board,
> from SPI-NAND
> 
> I am currently working on upstreaming U-Boot support for the RV1103B SoC.
> My first RFC attempt is available here:
> 
>    https://github.com/fabioestevam/u-boot/commits/rv1103/
> 
> Build steps:
> 
>    make evb-rv1103_defconfig
>    make
> 
> However, I am not yet able to boot U-Boot on the board. At the moment,
> the board does not boot and only prints "RKUART".
> 
> My initial plan was to avoid SPL, similar to the evb-rv1108 approach
> (described in board/rockchip/evb_rv1108/README).
> 

There is an SPL, it's just a blob from Rockchip.

> Before going further, I would like to ask:
> 
> Is the evb-rv1108 “no SPL” boot flow a valid reference for RV1103B?
> 

No clue.

> Any guidance or pointers would be greatly appreciated.
> 

Do you actually use the same SPL blob as in the v2017.09 image? Do you 
see something on UART on that image?

I would think the SPL blob from Rockchip would print a bunch of things 
on the UART (e.g. while initializing the DDR like it's used to on 
RK3588). If you are using a different baudrate than the one set in the 
blob (usually 1500000 but maybe it's different for RV?), serial 
controller or serial IO mux (the number after M in the pinmux, e.g. 
UARTXMY means controller X mux Y), you can modify it with 
https://github.com/rockchip-linux/rkbin/blob/master/tools/ddrbin_tool.py.

RV1103 is somewhat old, but I'm assuming it's not impacted by the bug 
that requires us to use rkspi (instead of rksd) format for SPI images? 
You would need to write 2KiB every 4KiB IIRC. You can check after 
flashing the downstream image what is the content of your flash I guess 
to check that.

Usually, the blobs from Rockchip end up returning to BootROM for the 
next stage, so U-Boot proper would need to be stored somewhere in DRAM 
and jumping to it by the BootROM for it to work? Not sure about those 
details, I have been fortunate enough so far that I didn't have to do 
any SoC bring-up but maybe Jonas or Kever can help here?

Good luck!
Quentin
