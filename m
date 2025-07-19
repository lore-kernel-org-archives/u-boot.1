Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCFAC83F27
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 23:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D27D83700;
	Sun, 20 Jul 2025 01:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aAczQo7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D16C83734; Sun, 20 Jul 2025 01:57:50 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C51833AD
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 01:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvHqf0RcdOx29ToIBHtI13HCV/eVzvRWlPcJtj+7duvyssujsuxI907nCazJxsi4WTz6sl2IAQ4Z8LCcmLb50e0aXE8WwX6cYVxYfw+7cgeV25TAhwNhJYRM8WGtHQLA9JNVBCgAL9sXxtaXvpW6xQB46Y+2XHSUbLuPvwtBWvsYLEpeksAn7zuBDoOX4dBEs5wcqi6h7S+VEPGTByGBUbG5ATM4JVuvzy1moCe7K6IYTkTk0HhG82KyHLgxuMsftLax2z9InQ6tqdMj9WJw3A1FqJqgg6ECbXxY+HU4utToVqsu8aStlkDSVsCl2Fk32f4pqmvcxjtizFBuxsSInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qZNtlb5qLGcD6mp9W736FT1Gw3vPETZSeFnOII8kiI=;
 b=teCDzXFx7gbMYYMz7n96nFKgaWOyoSB5JFRQPahXLAZpPCf/uGlgWJYZU/0veBMwYCuAwAT8T+vH/vi8CKc04iA7QhVNqdFMCk1Oghe1WfqRkIPSZppOXT7/CkyuvDJokKvueZUG/aEoYy+U/4powCQIKc0wfYLaYP8LXxQ6JWEQIpaIRUr7fcvBVfWIi+l9wM7uGDXIBioRbMYhFsN06bx99JrNRZrILnUSt6I7FqYIoeegUEzAgMOSjlF7sjllXbWdAmoCDvtVX4Km0jj5EJbn2ULtZueKjm8B9XIcU7/KFZzX5iOhguGEImfNgP+zzCPG/9xIK6TdnCifIgRQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qZNtlb5qLGcD6mp9W736FT1Gw3vPETZSeFnOII8kiI=;
 b=aAczQo7OadzYEgJBO62a+ge23pBLYRcWK5fyJNQRFkThvik/CIfKQbLhPAqKqoO8turj3yFMjIjsPBOYrq7gkEIdx5egC0SiJxMW5FM/AZGMqH2iG9oAm5nClLIMJleUz5p6DHpq3lpH4u/i1jrFGMaKXhx1jelpZnVdJKmcOK+6+DlA0kWbBV3fyG38biRcwEPTw3qD35QxrSNcWKE13pLS58pa1XfGilGHcM6mg/DQwFV4n6ddSJjVROibPG6kAHxDFuu0/Pz9Upy8yNl3piGp/g2vH3U/xnzBVUpXVUpM6T7C3Q5uuTwZc7pC5fzQumlfGcptkvd52sqopyd64g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7779.eurprd08.prod.outlook.com (2603:10a6:150:57::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Sat, 19 Jul
 2025 23:57:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 23:57:43 +0000
Message-ID: <0cb84343-d12c-40f2-aa24-710e1d254928@iopsys.eu>
Date: Sun, 20 Jul 2025 02:57:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drivers/reset/reset-airoha: add support for airoha
 en7523 SoC family
To: Tom Rini <trini@konsulko.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
 <20250719005717.113842-4-mikhail.kshevetskiy@iopsys.eu>
 <20250719145757.GY193579@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250719145757.GY193579@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: a98b94d2-6afd-413e-6ea6-08ddc7200d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzVSUUptd0U0eHVrN0JzRDRHZGJ0M245bVF0Rmg1OG9vYTZ5RUJaRDMycjE2?=
 =?utf-8?B?dmM4UU1mb3RINEhxWEZvWnRXR0JtMWtmbWRUcjMxeUh0SUFoS0NKakI3RzRU?=
 =?utf-8?B?QkpXUHROM2VueE5uNUdLRjVpK051eDBURnd5QWh5bjBRa3EwaE9vUjFvTUdZ?=
 =?utf-8?B?WisxK3lUSEsrUUV2UE1DSzZ6czJFWHQ1TWZ6Ny9WSWExcXN6TXVHSDR4eitI?=
 =?utf-8?B?S2NDZmVPNEN6OWhMbEdqUW1BdjJkblNCbXJpZnZCbGdCRXB5cnI3b3l4WkIv?=
 =?utf-8?B?QTZTWUZpakxsNjdSUHFjVWIvTFI3dC9KbFdmUG1jZk95a2VsV2Y4MVFHSlBt?=
 =?utf-8?B?UUNGcGZuWXJNOFY0RFI1aHN0VytNdzZqbHZqRmVoS1RVU0EyVy9TVGRlT2xn?=
 =?utf-8?B?ZGtDSEdPWGg4VTlqc3BUMWFkRXRGeXNaOVNtYjByWTBUSXNWeURVNjRZdmNa?=
 =?utf-8?B?c3NBMHNxUE8vTnRxOGRDNnkzQ1YwSkJMRFpmcmxTK0RacEl1dnlMT2lLRGIy?=
 =?utf-8?B?a3YvRlBSem5ZL2JxQTE0d0xyTHROeCtTdlhJVWp6Wk9xdkFvNm44WXVWSDlB?=
 =?utf-8?B?QmFVL2lzd2NxbzBoa1JJTmwzZFROSko5ZldTL2QyTkpZb3VNMldIVVNSbXZw?=
 =?utf-8?B?MURTWVRldXJxR0JkNjFQa3dIVmhqUlh1Zk1ldEdFTWlNSitEeS9ySUlnU1hl?=
 =?utf-8?B?dHdFamt0NXA1bXVHTlpncjZmN3pIUUtwMU81QVhQVVZ6eWNwYmpkMHNqSTlM?=
 =?utf-8?B?czlFUHkrMHQrdlI5QW14a1FrVWUvb1c0ZEdkUmoyZkNCSWFYSE02L2NBNVV4?=
 =?utf-8?B?N2lMZXRsS1Z0b2g5aFczRTdjU3MxWTdwYTVCQ2xMRTdOTzRjeXYzWUdNU2M0?=
 =?utf-8?B?TUxuYU5sekVScVg2alRoc1kzbVVmc1Vva1ZuMEk2WnRrS0VGVnZLb2h4cXR5?=
 =?utf-8?B?QmlzcEw1amNKQzAybUI1RnBGQjltUXFJWEU3VDdsb0pMTGJzTno1aGwyTUpL?=
 =?utf-8?B?dEpZV0dGVzFMVHJXWlFxVGYvRDcvL01tOEhDaytDV3BEZ3liMklIZTVYbkxY?=
 =?utf-8?B?VmpqODRYVVJibE9zYkNkejZWdGVPS2NJT2xvellpK3d1WTVzLzRQcy8vcTV0?=
 =?utf-8?B?dzM5bUNDZTg1TENub0NsdkZSV3lwWW10WjQ4cVdIaVlHZ0lUMnRmQ2paUUll?=
 =?utf-8?B?VzRQNmZPZHhOeWRtSmVPaGp0bWQ3ZkY4MU9WVjZ3cXd4bWN6UjJQQ2U4QTB3?=
 =?utf-8?B?ekhlVmxkaTRDakY3LzkvR3hqTnlQcE5SdkoyV1FVcnpiSm9qeEFSTDVjbk1K?=
 =?utf-8?B?aUppdWllUVBkV0pxd0YwOWxxNXF3WTRubU1FaVlWVDY0OE9pZS92YkpwQ1Br?=
 =?utf-8?B?d290QlFlM2VXWlE5b2JQNmp0ZE45a29XRHcrL2JteGF4MzVLRm1uOVhtZTBL?=
 =?utf-8?B?VitTbmlvbmJMd0lETlVVTVVVSmxzeXBudVlNOUtldDkxbGs2d2ZBc3FwTUJx?=
 =?utf-8?B?WHp4dzFKN21RcWJCVC9WZzZZeW1NZmtSM3BNNEQ3bGhJUXhqTnRBN0hNUDdv?=
 =?utf-8?B?L0VyQ3NIUnkyYS9lSEs2SVYrU2Z6QVZpaFFjQy80VkNqQWY2YU9yVnlmSmR3?=
 =?utf-8?B?OUJqUnJPc2UwOXVkcFIrZDBiTnNXa1FyK3NSNTRoMWRnSjJwQVowMFB0cWEx?=
 =?utf-8?B?a3E4MmFnL2lENVdkQngzRkhwK2p4eExpd01WUXY1Y3J5L2hJQTdHdThZd0d6?=
 =?utf-8?B?U3lwMWJxRmlsUW9mb3o0SXdiQ25Ja3hscU9JVytMMmZyK1JHRWlDODIxU2l1?=
 =?utf-8?B?SFNwSVJueHVaN1hPb01OQkJ4T3ZDYTNKb2hnRDlyR2lNZTliaFZ6QUEzSUl6?=
 =?utf-8?B?bzZGaWc1cHlsOHY5eFpIb01WT1NGU0NnZGFsZVM4REZRcWdrbUJGQllUdG5D?=
 =?utf-8?Q?DbfP2uq62+c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhSSFR1M0FCQWZKcXdzQTE3VkY3blNmR0NOZFVPMnIrZUhrNVRydXVmRUlY?=
 =?utf-8?B?SzBPRXpIZDRCUHp4L2V6MUFjQzhSZTlxcmhJNGlhZkVsUEppeTVLa3ExNE9W?=
 =?utf-8?B?c0RQNDZKMEdYWnF4d0VXS1lseFpDTVVMcUZZSWR2S1phMVh2RXptak40YkJr?=
 =?utf-8?B?T29tVzNqWkFGcGFsaGp0R3BYZUxJSExuUE5LZkIyZDRUZ1dFVFVsS1Q3WXNB?=
 =?utf-8?B?Y1dOem8zN1FONU50TUN5cU5NOThyNkJ0a2UrWDhYYjRVY3NTMmcxUThobzVi?=
 =?utf-8?B?USsrakl5dmtwemhCUjZIOVp4RFVoV1NtMCttbVV5K2NWdHB0eDZhM0w5aFFO?=
 =?utf-8?B?ZWE1RUlYL3R3ak1sWlQrY041KzhaejlwY1RhWVlLK01KRGRKVEh1ZHdEQjcv?=
 =?utf-8?B?TEN6RjI5NGxSQ2tpS292TDBOOStzVmZMclFWUUdDb0tHSmk3QThDUTFwWlNo?=
 =?utf-8?B?Rkl2bFFXa3N1T0d0cVRiVElKL2dUTS9tbC8zSXNzRUNjUmlrYkNXTWNyVW5Z?=
 =?utf-8?B?M2VVNXNiUlprZWI3eU1oK1g5WWFHQm56ZTZkelB3My94c0RNNjlEMFFtaWpJ?=
 =?utf-8?B?d2lENE5hNWlaUGQ0MnlCTG95bHVOSklyOWhJdzErTTc5N2JpeTk5ZDdyS085?=
 =?utf-8?B?cG5aTFB2Q2ZuTit5UWsxcE44a1Z4akpzeW8yaElvTXlpVzAzVk1Wbzk3dWtY?=
 =?utf-8?B?S3psOFNNRWdkVEdoSXFUWUEzSnZJVVZRYVNlL0k0SzAxeGd0QWZHbWZVcGFj?=
 =?utf-8?B?VENXZENCRmVlVWFLekIzYUFLdGw4WkY4cnBXaVBTVWNHcUhGOENJQmJrajNa?=
 =?utf-8?B?N3lXcW1qamF4OEFMeUVFRlRrbXdwUDByRVZVeGpNZGs0MW1KYy9zWnpOMlNW?=
 =?utf-8?B?LzRDSktQRTdGUmc0aEFjTlVBR2p5cmhuSW9rbC9Pa0NlNm1KZjNkVlVOQlJK?=
 =?utf-8?B?Tjk1MkFIQmpLSXU4OWttK1pSYStEVzNuMEtjcGZOMHdxRFFCSWRZSDZNRGxI?=
 =?utf-8?B?enZEUmFlL2hlejRvb3NoTTd2OWVRbDlqQlI0Q21VYnkvU2ZJUmlkTGxCTFNl?=
 =?utf-8?B?UHl2ZVVUaGhrWG9RWTFhNlRlU0Z1Tjc5RGQwdE05UHViWlJ2M1ZyRDdpU0Ft?=
 =?utf-8?B?SnY5Rm1MaUpqc1hCRDI0bmlKS2tOSEkxRlltODlHOWdYMkxKRlVhRU5YNlN0?=
 =?utf-8?B?RHdxU3lIN2JVOXV6aXpxMFMwZVlQbU1WdVI0SldDaklRYkhsT2I1TStpNmhF?=
 =?utf-8?B?UUxRN0NPYUJQWmp2RU1rbDFUNGNGaVZFV2tpUnZlTTNWakZ1blllL3FoaGtY?=
 =?utf-8?B?eHh5d01DclpSV2loODRNVE9CL1hwQWs3K2NLRkJaZTdEWDN2djIxajdqbU45?=
 =?utf-8?B?cUtBcHdHUXhzR09Gbnd3eHE0emRIOVhhUXZCN1NGUDhZNGdMVmFHcDJUZkZ4?=
 =?utf-8?B?YW1oQ0NaTXhxcnZZc3IyWVd2b2Z3UjZmNFI5TW9xSjBkVnRreDJjd2xTWWx1?=
 =?utf-8?B?NnByUkwwM09DQUNwUWJaRnFMS0FsN1crMXBsM2JMV0VLZTlIWTFXKzBwZTRI?=
 =?utf-8?B?ajVJN1NPU1QrYks2T2ZUZVU3YTlpTWxCbzArOG1hUkJpc2Y2S0VHdHRZa09y?=
 =?utf-8?B?bEZoVlJUL05kaW1FUFNTbklqUlJJcDNpOTg0Y295WHJxOFVJWmc3ZHFvR2cw?=
 =?utf-8?B?UndNa3c1SnpOanV3a0pZRjV4ZFg3RWxqTFQwaXY4WEFwWE5yTWdHQzlTakNw?=
 =?utf-8?B?aWNvcUNjSFg5TytqSE51SEVEaWdpNlJPaDM3UXpEbjBrV1NqaGNqOUcyaXdv?=
 =?utf-8?B?ZTVnVXJKWHZhNjY3ckpaMUVtcU8wdVVuSmlpeWRBUDFXalppVHUvUzBWRWFW?=
 =?utf-8?B?S2NJY2hEUFdxcjQ4a2FYYnNYR2pnUlR0U01HUWN1cjB2a0JPRVdhWlhYMDFB?=
 =?utf-8?B?RVkxVy9keXhQWWllMFprU0ZIVEhnZ05pYjZqaERGc3RrY2FaSTNGR0U1SU1U?=
 =?utf-8?B?V0J1T1ZxVG5YbVBkNFJuMkU2WlZ6NUNWVU1ZMGpUVk8yamxhSDJTYnBvb1ox?=
 =?utf-8?B?YWJLZDNoSzkwSDZpYTh2amtTbWhzWThnNk9ySGJvME04QjZYS0xGM2pDeXdR?=
 =?utf-8?B?MlBJUGpDMmdNSFpZT2F0c1JzcFZMekM0emNWRlVKblp0bUF4YzQxcmRVdnkr?=
 =?utf-8?Q?0uldr5js86pI4/+bjZJz2q0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a98b94d2-6afd-413e-6ea6-08ddc7200d82
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 23:57:43.7424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tym3h6nKtVfxBK0lXfbuXYGgBMLSA03Xqk47OyBTbPJEcls6TXATVTuTWBNh+ysld1udz/09vAjzWMizJrx2xlxxCtrXDQdWnikr/crHIbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7779
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


On 19.07.2025 17:57, Tom Rini wrote:
> On Sat, Jul 19, 2025 at 03:57:13AM +0300, Mikhail Kshevetskiy wrote:
>
>> This adds reset controller support for airoha en7523/en7529/en7562 SoCs.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/reset/reset-airoha.c                  | 63 +++++++++++++++++--
>>  .../dt-bindings/reset/airoha,en7523-reset.h   | 61 ++++++++++++++++++
>>  2 files changed, 119 insertions(+), 5 deletions(-)
>>  create mode 100644 dts/upstream/include/dt-bindings/reset/airoha,en7523-reset.h
> This is not the correct form of cherry-picking an upstream binding.
> What version of the kernel includes the required binding, to start with?
> Thanks.
This comes not from linux. I write it from the scratch.
