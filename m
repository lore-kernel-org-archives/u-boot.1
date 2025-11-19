Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91135CF3186
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3798583EA9;
	Wed, 19 Nov 2025 10:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="S0yHmV57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98FE283EA9; Wed, 19 Nov 2025 10:53:04 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F55483EAB
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 10:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooclINzTTHM7qOADwYxyELRHHmPLi0J14MXVZWniQZMRG8GzlcyPBD8LU+zsuCwe0UCMgQGoCtHjF4zrg2Pk/zYJadmvFObMuASr5Zkc7/JW6EC1hkVX2vwMvqRphHUJx5THxMVcBGtd4gEgS1RgfJTvYZ8+G4kPpk9M2QNCu2zIH2Dq9iylW+qCSOc4iglDN7+6hueUWYcCOPjGxVcfMeuhh5pVQfqoin/s+xwDm6s2/PMVqsvdYtJPkFKVNaSN4KJr5fFHOdl3okWcqdapcY33Y9Hm/tkqAglorJCaGdH9AFsOMgKuq9FvRTsfHOWfDCGxrSI53hVHzOGdOTjn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOImXqgXjHVPDRvC2NNt0elrapVqq9SD+P/hk0HbzFA=;
 b=XwoTUuBPV6KY2ZGOPoKff8zY/c8lk7FsCeZ5GVtR7E2zfuOjABBd12tyfzeNp/TRUJ6k/6YbVFm7WT6B+z0rZZ/uX4TRW8LQRCg/NWT9AdyEADP3/9uax/cH64PMPDqN30sNvVpmLCGfM7KwkmO+pEJQTow+xeeKgFowPSzrIaJ7MVn6BkSMZP76L67tIXIVYEjHchgAMUxRGH55blRCLodxPWAimnyU1+WIbh3NUhd2DyTsA4cPLWTMazVfV+gJBW+iKHs6GS6KadpDYys2SzbQazxS4JeZabASEwKqpFO7+dcWj7hDKZcKlBYsQASCZyNX9f9KfhcDbAHmBM/pdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOImXqgXjHVPDRvC2NNt0elrapVqq9SD+P/hk0HbzFA=;
 b=S0yHmV575h7WyjSKNhSZiWbDplmC6o8U1CWmK+xXq1JcJWysczgh0hYEhIFFZkh1Z0C44AwxKaXX2zBe+4TkR5KR++DMjO0SOUVzcjiRzymbdT14vytn0KI5cACUfWsOB48VlFL36z08N/M8PeHvNp9312Qq3Ry3iSQp/OUkYpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV4PR04MB11290.eurprd04.prod.outlook.com (2603:10a6:150:28f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 09:52:52 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:52:51 +0000
Message-ID: <bae11d52-65cf-4d8f-a51e-115a90a7444c@cherry.de>
Date: Wed, 19 Nov 2025 10:52:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: Enable RK806 PMIC on rk3588-evb
To: Chaoyi Chen <kernel@airkyi.com>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Chaoyi Chen <chaoyi.chen@rock-chips.com>
References: <20251119015554.153-1-kernel@airkyi.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251119015554.153-1-kernel@airkyi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV4PR04MB11290:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b855e0-9cfc-41e0-2bab-08de27516737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejlNRk1lSklTSy9FUmk3T3hVemkyRjBMMTViWGxhRjRkMFo2RXAzSGl0eVZM?=
 =?utf-8?B?SFo5d0lpWU01KzBoUmJiOWVuTDZNWHFUQW9jbnY4TFpmQXFZRFRBZ0Q2b0dJ?=
 =?utf-8?B?Vm5VUTZqanBkMWMrSm85NnhGdXVvQXdSbWswcU9wQ3pFZU56VTJYZHNlNFlO?=
 =?utf-8?B?bldsWDFoUVJ3REVWelZFaW15YXJDT0tIVkQyNEJLNGZtTUpUT3dSR0JQVVJK?=
 =?utf-8?B?WkdOOEtac3JuZGprdWJrR3BhSTR6Vi8wNFErdFZGOXN6MDJMOGxIVnRZTVl5?=
 =?utf-8?B?ZlBnSzVibDhxbHd5TkhBU09seThsaWxqa1JlQ1dXQjMvVndUZURzZEI0UE8r?=
 =?utf-8?B?dXV4Q1l4aDJveTJabWhFaVQvdXN4bFNIckVpOTJhdDIxaTErRFFhR0VJcmFK?=
 =?utf-8?B?MENlRkw0UGRZZjhZYnk3YmM5Q090c0NZdUpVbWx4Nlpsb0FFdTNFbmxwUjV1?=
 =?utf-8?B?Qm1DMFRzMGJESmxXcHZkRWFMbm14R29NNU5MTnhRVUZ2dkIwdWd0VWVleEg2?=
 =?utf-8?B?K2NLYkU0NGYySjZ6dFA4QW5NTDJZREZ1c3BadnAzVTdEWVROdXZsNWgvVkJF?=
 =?utf-8?B?WHNyc1didTcyRXIzUS94ZEpvempwZkh1Wm5WaGNVRGw0V1ZYVWFlN3VVM1FD?=
 =?utf-8?B?VjlTdGt1RUU0UFNQSjRYdWs5dUJJSTRlSnB0M0VETGdQZHVud2VZS0JCOTBo?=
 =?utf-8?B?VHBac2R2UkdheWdrVnNucERWVVFBTWtKdEJLT1VtQUcrMnRpM0RML0dVZDEw?=
 =?utf-8?B?dmxRcmcvMFE1Rm4vUmVVdytQRyttNlhZeDQzU1ZITkdJWVVRek5adm9mbkdO?=
 =?utf-8?B?UUYrQ2JqRUVtMXUxTXVxOHRYTGsxc3c1bEN5bGpyeXFnNXhHUldTK0tnUVp5?=
 =?utf-8?B?dlo4RUpjNHZlbVRLYzVNamY3akxkZ3pmRm81MjF5SC9BVmNsa2NNSUxWVmFV?=
 =?utf-8?B?andtdXk2cVZOTURNNVU1UGNRYzArOTB1Z2ZaNURPcEh4YUt1VkxoRlN5eXJZ?=
 =?utf-8?B?bHRGUXY0bHdCNUxsQnRFcUk5SHZub3poYlVOa29hMGdjUnFBNWduV3V6Q0dq?=
 =?utf-8?B?VEtWVWRSeC9IK3dyOXp6L2RZOXNCZ013RkRoTjkyaHMxLzI1SDFMMjEzalMy?=
 =?utf-8?B?MlRqSzVEYzROeG1qUk5PY3ZHVkpkdmlRWnVjZVphWTRXa3FZVDg3MTB6aTZu?=
 =?utf-8?B?aXFncDdFK2I5WnV0Z2RJalBIZkVCd1FSUTFEZ1NPVHhkcDJwRy9uSWo2UzFE?=
 =?utf-8?B?QUQ4bUpaWWtLTi9XNytyNDFZYWErdVhZVWYxSlRRZ0cwY1p1eC9CVG1QcnB6?=
 =?utf-8?B?WHhlekx3NWRmVEV4eXZkakZ3WmZPeGdTQXBVRTJKbUlXS3pBUk5HRXdHWVhs?=
 =?utf-8?B?bzNvbHpQZkxnMHowMjZ6eDJKNkswb2NwcnMxSlBxdzZGd0YvRVQ2czdZaVJo?=
 =?utf-8?B?UTlzOVBYVFBjUkZiald5azhBT0xCUE45TXhNcVBxZDhHR2c2MEpZUUtiZDE2?=
 =?utf-8?B?aW45ZnQrS3BmTlZGd3ZMOEQwcE01ZVVKczJ0Nm9JRmtteWlLaVJWNU9tNWhW?=
 =?utf-8?B?RnRQZDlQVVBNVnUxdEN3TlBJa2VEVDBTWCtTNnI4VEVUd3EwMEdIOW9wS3RC?=
 =?utf-8?B?RWE4emNhZ21JSWRXbWtySjZhbnplMUlBRnNlNlVTNUtkSmRaeFVVaWJwc3N6?=
 =?utf-8?B?YzRVblZlZ2N0ZWkvcFA2QWpTOWkramR6Q1Q0LzlmMmM2L2xGK2Y4M0lKYUdR?=
 =?utf-8?B?Zk9yalZDaUhlNEg4OVZ4U1liM0tveGJmbG0wVGhOSmE2cmZwMysza0hOVjls?=
 =?utf-8?B?U2JqcHc1MVVJanZPalRwR1VPL29sUlBPR3BLYlpGS09udURZMzhpL0pOL3hu?=
 =?utf-8?B?Qm1nWU1oNGR1Q0NjVkxUQUlHdGRXR254TlRmbUZXVzVSRU9hM094TENGSXVs?=
 =?utf-8?Q?qT6G+LTZSXZ4kQ7ocp98QAl3TWR5RK7j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmtDNHRHV0gwaFduWVJSRlp0d2pqdUJ2ZW9uSCtNNmMzMTNwRGQ3endta3dI?=
 =?utf-8?B?cVh1RStHRFl1SkNTTEVjTnQzc3RRWjlJbzYzOE5GeW5rQmI3QUFDd3pHZTBv?=
 =?utf-8?B?Q1NGa2kyYndLdTlDazhCQUxnbi9HQXdPZWFLRFpLYmcwTWd5ZDBmSWRieGJ0?=
 =?utf-8?B?eGNCZGM4TnQ5NG1qa216K1BGak5yVXNTTEo5ZEU5cmNvK014WWJrdlNqZlVk?=
 =?utf-8?B?bHBmeUpmTDNGb2NNUGo4cGN6S04zU3k5OUg4L1d2dXdDblZ3cHJ0bDFMeVdU?=
 =?utf-8?B?YWpnT3JEbFRhUXRnaVNWbWhFdXB5b3ljUjcwQ0txRDZuRnNiRGtURHNmOGxC?=
 =?utf-8?B?NDV2R2FLanJQbm5lSU5vb001ZzJ3WkxObHNCNzJibkFSaUZ5bEdCVkZBRGNj?=
 =?utf-8?B?OFNqeURjbTRWSVh6TC9XVkthaGlRaXA5dWl2VEhIeUI3SUFJZ2c4SnVvRGpv?=
 =?utf-8?B?dk55ejA3eitoOHAvMThNbXZVTFRWU2ZTN0pBcjJZanZFbkh1OTAwS2lHTmJl?=
 =?utf-8?B?TFhtcmNHSVVvU282SjRybUJtQUZuRE01UEN0V1dXZ2xjY1RxWGFKbHVHbmQ2?=
 =?utf-8?B?MTJXc0I4ekpQajVYRklBNEVCOVh4ZUJOQitDYmpqa1JMaXRGSlNaNkc2bXBR?=
 =?utf-8?B?QWIraVkvNFhKWUUvUkZaU2txek9aWXNPSlpoeCs0OEExckRkUHdTVVdxT3NW?=
 =?utf-8?B?YTRlZmZQcGpxd0VTRXhsOXZhb2NuMWNUVU5JWFpIeG1vOUt0VjlKWUY0UU9x?=
 =?utf-8?B?ZmxWYXlkQmRxV1ZKL2VmMUEwVFRMOThpNHFXRU1ZQS9WWUNCMHNCMjlXLzJB?=
 =?utf-8?B?L05iSkJwajA3ODNLdjRsRGpCREdxMGozbTVRMk0rOEN3emV3SmR1ZnJ1TGpu?=
 =?utf-8?B?Wk9Bb3ZBUE45S2ZvUHZBRnRaTE1aZk51bzNmMzBEOEhyMWlQK3lQTnFsaEZ2?=
 =?utf-8?B?UkkvSkwvUDZzeFJnTm9XWHpieEJBdTdRdlZRK2pjdHZQZE9ObWZzY3JneVZa?=
 =?utf-8?B?N2cwYUx3MGR4U1MwT1d2ckMzNjhQNVRtc3EveXUxYjFESERad1dpNnplaER4?=
 =?utf-8?B?bXpEK1ZtS1VrS1pacGFiMUhrQUhoelE4TEhndGNZQkpXcVprbXhaSVRCWnJl?=
 =?utf-8?B?bVRmN3FtcDVTOGFsYmVPQjZTdXFzTFg4WDRJN2xDYmpxcDNHV0xrSkxPNXFI?=
 =?utf-8?B?YnE1TUUzaDYxM0p4MC81MzJSQjFHM3d6UEZ6enVBQ2xmL3I2bWxlVG1jVXhq?=
 =?utf-8?B?TDZkVGxDazErdWhRZldiVVJwcXhFZFFCdGs5TnRjZEZDSzB4cHN0ZDMwTlJm?=
 =?utf-8?B?Ukx5enZEVTBWNjh3OG9rMU9hVDh1aVV4MGQxVUNrUk9kd3J3Z3ZvTXZSVXZ0?=
 =?utf-8?B?WWczcVBzMmQvNytRL1hvZWZEd2FtUTh3eEZxbjlQTzNDZVE4VmVrNkU5SjRi?=
 =?utf-8?B?OUlYYXZVcnlTdzJBUURXclAydXR5d2dsZndtems1ektnK0Zlc0kvOHBQT0xr?=
 =?utf-8?B?Wk1rZmdvRUNuMXZSS05sOHc0VFF4S0cwUTJCTFIxZWdBT0w5RjNGMzlESzE4?=
 =?utf-8?B?M0dPRTBQcERuRGU2eFljSnk5bW1uOWdDZi8rOENud0I5Y3BtMy9mZHZNbll4?=
 =?utf-8?B?Nnh5VHdTMDJTV1ErVjFCQjJTeWhxempoUUU5SzNqemhmdDBDa3NqOWhRZm51?=
 =?utf-8?B?L0FlV2JWYmlrTFNwS0NmS2I1NTQwVENGSkRlaXpUWjdZY2RRYUpma1hINUFq?=
 =?utf-8?B?LzdzL2hKQkRtT2FXRDJvSHZhZVJwaVFqN1ZzbVNGM1ZBUTNvYXZlN1RRL0FG?=
 =?utf-8?B?dlFLNVk3S0R5YVR4M2lYRnl5SHd2dDhNb2s4YnM1RkFLMVI4aEJ4QXZrVUZ1?=
 =?utf-8?B?dDlUNEh2dlZUR3ZZRC9IcjdmZStocG5PRU1DSGd2ZHNhaWphcU15YXB3MXl3?=
 =?utf-8?B?U3p6K2N3VTBpSi9ndm1aMlhXR2kyU1dHN1ZIOTVUaE55RUVhUVg3Wmc0OHBU?=
 =?utf-8?B?SG5lT3pNbWdzT2hxdFZqZWhrQzlhY2FXbFEyRzM1dEV2eHIyd1hUdFFrKzJK?=
 =?utf-8?B?Wm9LMlRNWjI0Q1d5Q2hCN1VtTXR3UmRydFQ4Z2ZINmxLYkJSdlhQZTF2NHhB?=
 =?utf-8?B?N1NCRk1wYnl0ZmprUnFQWjd4TlVDdmpBUGlEaGR6ZFBHSUd5bXpOQklxYi9w?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b855e0-9cfc-41e0-2bab-08de27516737
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:52:51.2463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eFPbTBUZIqNscqGDd9g8uVDXkgaPG0DM5A97ryLWuFYnK6hO/Mzd//9ik+skUT2QNkw7pGY9Q9jGCfOlrolbpi5SCnLOXe/uL4HH+mx+Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11290
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

Hi Chaoyi Chen,

On 11/19/25 2:55 AM, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Some pmdomains rely on RK806 PMIC for power supply. If we don't
> enable them in U-Boot, random panic may occur during the Kernel
> boot process.
> 

The kernel shouldn't rely on U-Boot doing something to work, so please 
fix this with upstream Linux kernel.

Can you tell us what's the issue?

The issue with this patch here is that we probably would need **all** 
RK3588 boards to have the PMIC enabled, and all the appropriate 
regulators brought up before booting into the kernel. It'd be *much* 
better this is fixed in Linux (and depending on what we're talking 
about, it may need another fix in U-Boot so that whatever depends on the 
PM domain works as well).

Also, why the PMIC in SPL but not the regulators?

Cheers,
Quentin
