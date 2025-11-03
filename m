Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698AFCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 10:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA31983642;
	Mon,  3 Nov 2025 11:47:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TnlVjrtg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54BBA836D1; Mon,  3 Nov 2025 11:47:39 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571A08331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 11:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rsd+1TnqXG6c2ghx0usCf9shqTZjNSwES8dWiEXKO3glfGnoDznyIDxGUlt7hh+ae92h2NCoqjMLzEvndJXpD6H11jH4VwxWPa2ivbd1cGgyIUywUaX74zxxL+bSsaPeN0Z8zRffHuOnZs0/iSlFUMW69JgKMm1yUFULj/rDpZ1/qQ3yInkIF3sMadDUGwu63Ptm3m1OQNEG5PCns6iEgPNuhRICJPuKEEHA97f91aUGHqU7HkhQ8TujJHhA090Dc7nI9ZHTrz+h1yfur64NUuYHiN3FtzpMQc2ZSdHNE53qoYDobyFG4GIejlAREQgBZRYCCB/lTH6D9C5e2sthVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzrLjWdiOBPzfmCWRy/JOiSPfC3FqfjE1UT34hWKq1Y=;
 b=Rfgt4o7kGUGoDyLwNAstX5TwIXAKzz9HvVzed6X3Gx8TxIJvGzF1k2R2GJIIPG1kg6unz3UgXEZ5uyLeqzPXHEdcpbOF/YL8PX7pAoyqFF3zaXHg5ufXicVghElHRbqFGjqMdxqMm0IPIhqIHgZlTUX7VNhDT0ODGRqzzOR0SKZU1BExvE7ow4MTkpQt6gnhOtDEbCTxetRMlBaFgLdH5wotXMVmsvUQLLfDNeG7UX9rJcy+o2aWHCGoFC+EIybxwFmGmDvunkWiohnI65Hlh/owKZrw8e/ojrY90IA2pb5/vvGSEpmqH8nzNVX6VPQpkbnMCd074mai9xyJ+if7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzrLjWdiOBPzfmCWRy/JOiSPfC3FqfjE1UT34hWKq1Y=;
 b=TnlVjrtgei0JVbsuf+3UyIlEC8NFAQFl3MaKzwvmQa9rtw12DeaojMDdvr39RCj3JTkfPThTk6+yXKO7G6kHv8ez/KKBIXjsk+3Rnwvw6vxAY0OwmdIlUrhqYjkuRifnlSQAS3La0ohP8qwk7n+l2Uq4peZ4Hz56M2Ag9Z8Vn4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by FRWPR04MB11284.eurprd04.prod.outlook.com (2603:10a6:d10:19e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:47:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 10:47:35 +0000
Message-ID: <8987cd66-3ba4-4a40-84a2-9f978d688566@cherry.de>
Date: Mon, 3 Nov 2025 11:47:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <0f8fa8d4-3cab-4555-af1e-03feaef81ca5@cherry.de>
 <CAN7C2SBiONLZLy3jwUW8OE2QkvJ+N2Av8zcu5PEPa0zZmPNOpA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAN7C2SBiONLZLy3jwUW8OE2QkvJ+N2Av8zcu5PEPa0zZmPNOpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|FRWPR04MB11284:EE_
X-MS-Office365-Filtering-Correlation-Id: 982bb4cf-4562-4d58-a92b-08de1ac66578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVlUSWtVY3ZUbkIvcWtjTjRoZ2lMRXRvS3prM3RDTUYyMlprUVV3MEVUQlpU?=
 =?utf-8?B?TWtITzJQdEYrQWlUcEcwd0hIRnB3K2dodlkyZ3lKREwzNGxScTdQVzMxYk4r?=
 =?utf-8?B?N3hJVzFuVnlPQVU1R0VmdnFxUFFtOW01RjMrQVowaHRDYUVGaHgydlk5RG82?=
 =?utf-8?B?Z1Zza1RIRUdKQ3o3NXUxU2pJMFdKN05CZE1ONXlKL3UzbjFlVzMyQmxNSDBm?=
 =?utf-8?B?QWRpTzJaUGFhVW1FV2ZuMHMyVkJvSFpJcjNxL3psNGx3Q0g5UjBUeFp4b3Bo?=
 =?utf-8?B?a0JvVnRWcnBNTnpLdEhSbG9NSC9Ed0U2UHFyK2dTNWh2Z3RFSkw2YmZaVEhZ?=
 =?utf-8?B?NU15YXhHL1QwTHNkZzZmK3JsdVNnalhWRkY0TGVQeG9qZTFrYnp5UElpZGs4?=
 =?utf-8?B?NHVNNDMzUkl3K25BOU0vUHo1Zk82S2xWeno5NHVESGR5cnpXY0FZSU1OV0x6?=
 =?utf-8?B?aHNDRjVkV2J0SlZveWtHbDZLQ3NaRlJoVDZFMW0rM20raGxiYTRmdklqQnF0?=
 =?utf-8?B?WlB6UjhqMkNmSndpWCtZRzljMWIyYWNBM3I0OWZpb3ltclBZQWI5TWp0dDhu?=
 =?utf-8?B?WnNOajdPall2N2htcXBiblhWR3VXRHBHNmZGMjJPdFR6Wk42b1BUWXF0TVBz?=
 =?utf-8?B?eExUTVREa25hOVV3NVUvd0w5eXRsOGJ5Sk4wZ21icEVEcGFXQ2lOYU1aZzNV?=
 =?utf-8?B?aDNQajRadUtiNHBLWm9LR3V5RGk2MGpUYTFHK0tpV1NCVDE1a0c0VGRwck9C?=
 =?utf-8?B?VGtJaWJ2MitZcEdVV1BVUjBoVlJWNVJhY0pIOG5WdlFQaElBai9XNVh6aXVJ?=
 =?utf-8?B?cllGMlRjcTFTbEZsdFMrZHFzd0NSNjlYMTNXRHhWOFcxVjVRaHY5eVhTT2cx?=
 =?utf-8?B?akN0RkV0VnVHUnAwTTd2OUdGQktLaE1hVEhORngyVDdzK01PcWtJZFlOb3Rj?=
 =?utf-8?B?MDk1TFJpOTROWm16YW9mL3o1d1BhNmJwK244TGJTKzFwSlpVUjFENGU2Sk1G?=
 =?utf-8?B?bEI0WXd1RFFYVnhkZi9GM0dPeXN5aktIU3VJbmZBYjRlYjBVWEc4M2k2MGdp?=
 =?utf-8?B?UEI2citMMDNscWI3Si83ZjhaMG9YUDNnQkpla3NMVDJibFVJZ0pDOGRMMG9B?=
 =?utf-8?B?QmpNSWMwU3BSbEZ5NGNmR3NzNm9xZEtLenZQQjQ0UW56TXR1NjJaOEJvQWVm?=
 =?utf-8?B?dWs0U0ZmczNoY1ZaVVVyZ200b1B6L3MrbnpORFNRaWI1dmo3ZDVYNys0Ykdh?=
 =?utf-8?B?SWcyYmpLblAxQUJTU3l2aXE2b2ZLK3lsWVdaa2E0VnlXdWVTbDVjMWFJVWpG?=
 =?utf-8?B?Zm5pUGoybTZKRVhnYkorNVlndllyb3hoOHg5NVNQVGhaOEJoRlIvQ25acWFC?=
 =?utf-8?B?cUcyL0VvdWRiU2kxSVlPamF0KzUwb1RBTVhtWFMydnE2a1Y3bFdYVUpvN21v?=
 =?utf-8?B?UG9sOXI1MGxlTFdhbGcxQjFTRHdVemJVNTlpVm9GcXhJYXgvdGlCN1VMS09y?=
 =?utf-8?B?cmxlelhyVmRsdTh5YUx5eVZnY1F3MTdCdVlHcERWaUJhcXRFYXBGQUo1ekxK?=
 =?utf-8?B?dlQ0SWhtOEx2bW9NNUFpNHJHZHpkaVNQRUFFOHJPL2Y1YXZRdENIVk1iOHND?=
 =?utf-8?B?WmVsYWlTSlRKYUlWSFIvbFlrMzgrRWJGb0dmSWp0L3lFdGw5QkprRTBWWUhG?=
 =?utf-8?B?MmdMbWpqWkhZLzFQdDFhN2V2K2I3Zk9tSFBoMWlwQWpoZkI5USs4dGRrVCtP?=
 =?utf-8?B?VGFGYXRON0ErdS9GV1NVaGdoWWRCL0JWdmtPdmhjSE1rNE5DUnpaNkRtUWJU?=
 =?utf-8?B?QTdqSVJ5Vm90KzFuVG10TjB2VDJUR2w5M0crd1dib1FrQmZFbU9teitjNFBp?=
 =?utf-8?B?b0UxZXZtUS9XYTBtNHI2b1crWlFodzkwOFZ2U1o3V1JsdVJvRVZZMjVJQ2o0?=
 =?utf-8?Q?wvSmcB+s/ykNxg+OFbypG6tHIQYhxK1r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1B1Q0RITkozdEVjQjZnTkQxNExXczg3d2JDbDdIT2JpdDhxQmVFMDFYQ0NU?=
 =?utf-8?B?NFVBRmNsT1RhTlc5cWlmUFMxN1cvTzJyK3VONyswYVRUL2NQRm1FZnF3TDg5?=
 =?utf-8?B?Rlc1aVJqQVVBcDA4L1J2dk5BbC9QVG1HVU5Lak1WaHB4dkI5dEVRdHYrc1FV?=
 =?utf-8?B?NnNacWdjdlJYK2lkbmFzS2RGd08vZHFMdGlyTG9ZU3ZWVHhUOEVOTTlpRldj?=
 =?utf-8?B?K3Nocmp4ekNuY2RDaWg4ZVR5cEJyN0ZaZGV5eTlFS2xYbVh0d1NLWHlEbTZ4?=
 =?utf-8?B?QWpiWWNPeEdST0NhT0hBOUw1Z3YrQmFuRGJLaVBmRzY0cFMrNDRhTnRJd04r?=
 =?utf-8?B?aUw1Zi9Pa0VQcXN1aGlKbktoc1NBaHFVcFhkYkxpODY4RkJJU2lVKzE5WXND?=
 =?utf-8?B?QmpKaVdiZlpSMzBjNHNJR3kwY0NyNVhMWDBXNmhNdS9oYkh1Vk0xV2Q3VE1a?=
 =?utf-8?B?eVoxRjJIMXRtMWpjRk4yYmRXMkluS3IxZ0ZrVDhWQ3QwVy8rMWhTbUp6K2ZF?=
 =?utf-8?B?WlN6Qmtqenc4dlp3RG1DQ3NBSkJBUEU1VmdySWt2NkFYVjJ1a1Q2R3BTOHJ3?=
 =?utf-8?B?MUFManlyQ3l5Q2prY0xWVndtbWdUSDkzWWcwRkpNRTR2Z3Q1YVpwR0xYQURr?=
 =?utf-8?B?M05zQllBcmRzd3dSa2xsQnZITUZpYXZZZ1NHNnBXT3JLbGMyMUFnT3pSTSt5?=
 =?utf-8?B?MWxaUEx4S3FCZTVjQzNLMmljeXFJN0hjZG5ncUtGY0UySExoMVJ3d2pNaWxY?=
 =?utf-8?B?QXpkeFFGOXhjZlI2RWJwbzArMjFEdHgwTG9ZczdtbnBSd3krc3hpc05jVHRn?=
 =?utf-8?B?RU9YVHlKRHVTQTlzVnBBUFBRUGJpc0lJOU1Hck1FZ0Fjb2IrLzQzL2hZYmxC?=
 =?utf-8?B?cGlFd1NrSXl0RmsyTXZQNFBsVWlreWdGVlArWnlwR2ltSDd3MURNMkZPbFNy?=
 =?utf-8?B?RVdZNFpwUGtZU2lMYjVDQk9vci9JbjdjelF4K0xsbHdnYlU3TW9Ta1kwRGFS?=
 =?utf-8?B?UjJiU2tMczhieXNab0pHakFmdkd0UlM1dFNqNUYyQUZrUWJQWExWS0ZDbDNK?=
 =?utf-8?B?OXpWY2RxTzN4NDZwMXdJMFNmMlJ2dmd2UXlKU2pwWXNxSnZSbktkSDBLWklY?=
 =?utf-8?B?SEJ6UHhQVmZPUk9lZ21JV0Y2eG1oUEN5eThLaWs3WkQzMVJYaXJnc0tXQUNu?=
 =?utf-8?B?UGFyNTlvdGw0MGJUa2tkSkJsU3dXT2lZVmRZRGJzZ2V4cUFZY3JNWFgrZzJt?=
 =?utf-8?B?OXA2SjV5WngxczJoZ05PU2p5VWpjRW43VXZ1WmhuZEJZYlJCQTBiS200YjZv?=
 =?utf-8?B?anlZOHo1OFk0TmttREVpbC9yU1pOVFEydnIvMVM2cHVqcGNOTTRCUFhQUTRY?=
 =?utf-8?B?bTdJcWlhV0ZLcDMrbEdJdDV2UStQTHJCZEtPbXpFSUdzclN1YjRYaDJhUTRa?=
 =?utf-8?B?SHV6MlVHdUhXUmpEbzNkVkpiRmFCaVF6R1Z3bm56c2RveWx5Rkd3eVJKdVFJ?=
 =?utf-8?B?aHZDb1NoRUpsZWp2WjJ2ajlKTTIvZFJOQzZ3N2l5VzIwQWhIaDUyZTdPc1Ey?=
 =?utf-8?B?ZktPZEJOM2FubTlIV2dZWDdQdEF4VW0xdTlzT1BjK2QrS2ZlbzhOYUJFRCtx?=
 =?utf-8?B?M1E4M2kzenE4a2cxN2tzMWF6QlBkQURZYjhQNFhuSWt6OVJQcmtvM2dQdVBn?=
 =?utf-8?B?UjVObVo1RWZES0tSN3kzazhERm1vYk1FaFA3YkxFQkZlZEZpczdUcERNd2c1?=
 =?utf-8?B?dld4K0VUT1VxUUxIRnpZTkN0VjRsVVBCNUhDa0hSc0ozcVVySlU3YnlxVk9u?=
 =?utf-8?B?NEt1MEt1TFpxVHgrQTZlYnN5bStkb1gxaUZ4a0svejlNVGFOMmpFVEQ1UUF2?=
 =?utf-8?B?TGlTUlYzZXdqRU0yY3pYM09yaHBEUlZxbnJ0aW9KZ3F2V1ZwVUVuSm5aQlRC?=
 =?utf-8?B?QVcvZU54Qk1FNThhTWFSZ3VoSFBEMTljNk5UUGV5L1pidk5nV3p4NSt0YXVE?=
 =?utf-8?B?Zkl4WHpoUTg2YnFoOVNZd096b1VXSkRFc0JmUk8xRTRlQ3lTQlgzeFFzMHJo?=
 =?utf-8?B?MDhjUTcxVUJ1ZnlkdmVJZ1NmeUs0Mmozbm5JNi9Ia01Ga3dGdXFGUmFwU1VB?=
 =?utf-8?B?bTFwSlF4RENLVUlOZ0p3blVWRytXdXpMRTRpLzhMRXB2b0YycW9qV2dUVi93?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 982bb4cf-4562-4d58-a92b-08de1ac66578
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:47:35.1012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2TLYiGbW5fPT/OWOeI0IrH2x96H2kyKMo6jy/SigwpROfdsD5EnutGK0IA58fGNeeNtnR1fdPDkmdnWK3vbtqJZOMd/yGzMbzcTV817lSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11284
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

Hi Sune,

On 11/3/25 11:29 AM, Sune Brian wrote:
>> the vmmc-supply always on (not configurable by software) so I cannot be
>> impacted by any change.
> 
> Comment on this.
> The nanopi neo4 has an sd card slot and mmc slot.
> The initial debug mail is only targeted on sd card.
> Where the MMC do not have any issue and this is

MMC != eMMC

SD Cards are MMCs, eMMCs are MMCs.

Cheers,
Quentin
