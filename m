Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24643C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 08:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6BE88675;
	Mon,  8 Jul 2024 10:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ER0qjR8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A52886A8; Mon,  8 Jul 2024 10:01:31 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87EF888675
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 10:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6M6f/4Stf1vFfQWXjmMH8t3ms/ePGjTRLEH8eegmeyP9MqTUJWVFKaGDds0tADrUWuKe1vnYoKjpIjCV2U0j+sSg7lqPiZI9ZmV8DmIqCAbV8r0hkqocTts8ud5EBjvBPjDUkgeHo8ZXGnKPYoRRSzQy1hsDYWQR9OjC036PaBEzJIPxpILZjmPFm5vtOIeZNXbGPNy6xo3NMcnTCnfkS2URRnklO03W7kaF1C1dA+vynL8KFaDSZKz/XXg6gxdKflEOlLk3xwnuvOo8DI63ZRLNjSopIJ/h3Dx/kCmFcAUPH8s0rVW+UOzV6orx81QFert+HmNg6ONtQ0VZP7huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMGWU2H6KWDtah+rZVwnJmHVwfVhcpGCXWKjFVhkU/4=;
 b=KvdG90g4YKR0uL3bL4WBAgxrSMy7UDNyfIboP5zcMg01wyKulItul211XwHNpSP0d/3M5RJFVqQBq5+ugDUGkR/4GjuUregRGQY7kq4WtzN0gsH9MGejbYEiQ7PRthDMdVrEBkhc5vGbBOkGd9G8leCZAYM9zBar5T/4JR6eN8G9M7iWqIDJxA9Q4hpW7rZsAmBGs83OLtR0Ewtc4p7FsP1X85zeqahb8v8EDKm0tye08mP+Yj2/njeh/DkohkG5Du1x/LF9Qdq8Ps4uJ6QNixM4mTIGmj0ASLhM0gKYXSwSQYNIz/NytkTzcXofxjBlht4L2cnX1CecgEweRWqDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMGWU2H6KWDtah+rZVwnJmHVwfVhcpGCXWKjFVhkU/4=;
 b=ER0qjR8km3j9c1Up33Bd3gs+3ExQqF5aJKHV2QYVQICw6JlQQ/TLmWKyjzxsubnpgoShzlwQTeYvkwVLMjjdLlAYOtuwcaWiDBE2JYGUycQcUJ98YuwDHCKqavJ459fT65JbCQMjYV6DpTyUQSavVjj/rmDUzFiV6pUnvE35rjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8121.eurprd04.prod.outlook.com (2603:10a6:10:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 08:01:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 08:01:26 +0000
Message-ID: <bce44f33-c882-4652-9233-9aee5fad9728@cherry.de>
Date: Mon, 8 Jul 2024 10:01:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20240626235857.272264-1-marex@denx.de>
 <d31b4e88-a59c-4ec7-aa05-1293ab8139d9@cherry.de>
 <7c53dff2-9703-4a59-9a90-ec2d64cdb3fa@denx.de>
 <274c876c-4d42-4af4-a68c-5b51c20bfdb8@cherry.de>
 <f873b919-a4de-4d06-9f6c-b964cf0699b7@denx.de>
 <d8d6995c-a66b-45dc-8d1c-3debbb9e757e@cherry.de>
 <211b7562-c0ca-4d57-9fb0-0305b14b0b66@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <211b7562-c0ca-4d57-9fb0-0305b14b0b66@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0037.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5f903e-7d37-4e1f-08d9-08dc9f242ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amU4dTJuL1BiS3JTYnI5RUd2TGlFb2V1OElaYkduS1RYZkpEZm9nV3IvTlZi?=
 =?utf-8?B?U3BFNEtXUU40WFc3SWJUNnZDL2ROVS9ENDV4UmdWTHZramlQK1NjazdrZFBL?=
 =?utf-8?B?MVZOaVdpOGZxZFpwdUtOYlJrZm4xa0xGSzc5a09VTXFjRS9SK0VvanVhU3lr?=
 =?utf-8?B?c1dMbEY2czVRSzJSc0NpaVQwaFZEckpwdDU1NXduV0g0UklCNWg5ZitBb3Nh?=
 =?utf-8?B?MWlGOXlkVktZRmo0Nk5TUEM1M1F2dUt4NHFXcFBmV24zMlF2aFMwa1lkbkZr?=
 =?utf-8?B?Zjk3bkVrcjZUaDVRT0VSZzF4dHBTSVJFcmJuTC8wdGtaS1Q0OXc5WFptRmti?=
 =?utf-8?B?RmhlaUNUSEFrQ2xlcmtvWGZmSklGODdobjE3UlUzK2xjd1NRc0J0Vlo2MUxF?=
 =?utf-8?B?NVZCMHZjZ1doL3dGSjJqbjRDeGRhc2xWSHAybFhnNnpBT1g4S3lKUlhTN2FT?=
 =?utf-8?B?MVQwdEQ1dldnTGkyYytjdzdSNkRwL0xRY2pJOXZxbnpVTFdaZUdtMkhEeWt2?=
 =?utf-8?B?WmF5NjU1d2cxbER3ak12MVhHKzcrUVVycmZOT0RKM0pOOUJPc0JVRWdITmhz?=
 =?utf-8?B?WEF6dUh3NGRFNVNISVFjYTlkL1VpMStMRURDakZTMlQrR0VWT2RCUm0vS3B1?=
 =?utf-8?B?TzBxNTRQK2t2V25UdXJkc2FRMmZPWnpiS0R6aEZTaDVzWXkvRnBEQ2YzdHMx?=
 =?utf-8?B?V3R6dm5pVS80S1Y0Z1pyYktwS2pqVDBNTmFadnVMbDB5WFZXeE8xWHJjSytj?=
 =?utf-8?B?Qy8vcVVwTGZZVnJrYWNwMjl0UjZLdXhIa2FmNHB4M0hPdUZtSENMdWlMYTlB?=
 =?utf-8?B?V0FuUFdaVysyQTR3WFJZOVhhTFErdGk0cnRGUEh1cURieTJVSzZTUTI2V1JE?=
 =?utf-8?B?NVRUOW8wR1hmMDBPQklCTWc5R2pmM3ZNeDNITFFiSjYzWmhJQUVndjFDa3Vm?=
 =?utf-8?B?TU5HbXJPVVFGWU0wcmV4QTRXdm45NFA2Q1c3UEFkaFlGK0RKN0RiZndlQ24x?=
 =?utf-8?B?UG9EZjJwbTVLN3VuQ21CODVocGpIKytWUEliTWlEM3FmVmRic29aRzh1Y2JT?=
 =?utf-8?B?K3BjaURXODNKNXpmcmgzM0pub0tDSE1MWE9pSFlxTHBmWGUzTHAvL0pyREhB?=
 =?utf-8?B?Rk0rZGZrU2c2SDdWdEVNVlhWZE8wWElrUGR1WktZUTQzQ29CTXE3Y2dxc2ls?=
 =?utf-8?B?Q2daY0RXbTVUVE1BQlFOeU1aMU5SaUlqWlJ4amI0djViZU5PMHEzeW13NWRq?=
 =?utf-8?B?Y0x6dGNVRnVwRTZqSTFRQXdoOTFZYUpYeGpmOEgyRkx6c0dOOVllUzNLUEh6?=
 =?utf-8?B?dlZOcysveTdEVnQ0c0w5UWtualpiRmM3QUtJamtqY0RZeUYwL3NZUDdJVmZ6?=
 =?utf-8?B?aDRoYitXYWhibUFxUGpsUDBDUXZvUFg2WDJSQlcvekU1SndTSlRSWEpTZEpP?=
 =?utf-8?B?VFhyelMrbi9GZmVpSFZJa0RtOGRKQ0Z1QSs1ZW4xNzQycktIdk02MHhYTFE1?=
 =?utf-8?B?LzlUTDBhQ3NjeVA4eGlPeTViZGU0eFVrM3F1VFg4a1dzbnhVdVJrNVVub1M3?=
 =?utf-8?B?TFNPU3lzbGtNaXVTQ2Z2MnVBQ0RvSjlKek8yYjdVcXVsb0tocWxUQXZYMEM2?=
 =?utf-8?B?MUdUcXNHdlUxYjhrNHhxSHMxNmlCdjdyeFJYT0JWNmZtQ0N5M2FaMnpMNk5R?=
 =?utf-8?B?QjFUQWtGd3BqNVE3dnRlalc0L3d6UzRTTk04NkdCUXFZVlpNS1BqY1h2eHI4?=
 =?utf-8?Q?dpCAxQ0r/dnARRxZEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUNEUGd6Q3ZRRzBQSVFCVmlKSmpRR0FHQVdLbE9YVVk2cGltNnM0OUpaS21R?=
 =?utf-8?B?N3pMWVptcnJjU2dOYnowYVZteEJBLzZlbStuRUp6UHFTcW9uTTVnYnNlcERm?=
 =?utf-8?B?Z0ZLYVdLZXNTM1puSHlsTk5SRXJpMkFIdWhZaUZvRWExMkpHKzFnemNOcFJ2?=
 =?utf-8?B?bGpTdWJvbjJDNDllZ0pYVnJJaTZrKzFIKzBrbXltd3hpdXR0MEtzbzRjZG9r?=
 =?utf-8?B?cXlsZEswbUhaOUxlS2VRYzl2SExMOTI2bWw3MzVqdThESG9ZOVV0NE5VeER2?=
 =?utf-8?B?bUtPcStoNVVQbERFeU5PTGQyL1I5UDFaUVZLVkEyWjNQZWQrUUcvalVWV3Ja?=
 =?utf-8?B?eGpscDVxVlNraXBOdStBc2Nuc2FXVWdLZjR3N295VHoxUmZBVGYvNFpxR0RZ?=
 =?utf-8?B?bmVzUHFmcERRdU1JYjJiWDJCMFBWUG5zcUxMWWNBSTZzVEZUSDN6VDErck9D?=
 =?utf-8?B?Nk5BTmlWZkh6Q2N5cDdhOUhxSXIwRWpsQXFPbjFJbXJHbkQvWjlNTnpBYnly?=
 =?utf-8?B?WlljV0pDZVBpQmJabUJIdXpuUStXaXNSZzZwMnBzcWgrekRwSHV1THVIVVU1?=
 =?utf-8?B?WjZVcC9ubnRycHRPM0t3Q1kzZ0JIQVl2OHlRTE41TGNmbzlaMVdMVXlrRVdm?=
 =?utf-8?B?MjJmVzR0dVdETTdWeTN3QUZwdjYyNUJwaEFUNWdqODJ1U0Uxd0RuNXpsVjBE?=
 =?utf-8?B?ZmxZeHdiNTRWaGVIY0lSK2xpcGR1WDVrc3ZzdnJmSmx6VWpYV2paNktLeFQ4?=
 =?utf-8?B?NnhrbzZCUGJSb3Q3ZmdkSnRwNm0vQWRmRmVFT0loOVgrdnYyb2R2YStER2lK?=
 =?utf-8?B?K3hSVFNnM3ZUQ3JLYW9hMFkxV1RONElqVDJELzFpWGxyWGN1ZitTWE9xZzdM?=
 =?utf-8?B?TGt1Z1E5aGs3QXV4OXd2LzlJZGt6a1g3K05NVzNhWXY1NHNUMm5RU2lpb1hB?=
 =?utf-8?B?bnVsemV1MGg4Z2xMeXQzU0xuRW1wUDVweGhiMHBBTFhxNGtlVGo2WGhqR0NB?=
 =?utf-8?B?WjhQaTFhSXRDN21adThkd0JpZ05CaCtqSGRFM2Z3Y09tTE12WWI1d2JqU1Bw?=
 =?utf-8?B?Uk9oTDYvOCtrNlMwV0ZFVGpaQzNBbXM0ckZwblVMK0NtNTZJWFFjNnUwSlJQ?=
 =?utf-8?B?K3JhWVJ6NGczekcrc29CeHA4Y2NYb0lIZjF4VkJWQVByK09MSGo5OUQ4VXUy?=
 =?utf-8?B?R3YrRHpiWkZOVDdzTTVlLzBQUGc4QkZHc3ZhNzFrREQzaW5NK1Y4YmhaWEJY?=
 =?utf-8?B?VnVDUUlMSTEzcml6NFpJZjRsK1p0dGkvRVdncGpwdENpY1pKR2tIbU9Nd3M0?=
 =?utf-8?B?REZHYjdMeWlmYUQ3dDFlRUhvUHI4ZlB5ZlpJaXB2RmIxRUsxL29jZ09KN3Mv?=
 =?utf-8?B?dXQ4dEdIYmdTSEJkWGRnZVFIOFJLSkFuUW02bWluU1hudm8vWS9MNklOdWNr?=
 =?utf-8?B?UEVjV3hWRXBRSm1FbnNaZ0xGZTR2VGN0a3JGa05ubDZmOGtiN3cxcGUyMmNW?=
 =?utf-8?B?T09CenJQK1J5eE16cUNuVUpNWDNKVCsveFRkWTllWGxlYWw0QUg5RzdOd2JD?=
 =?utf-8?B?WHdaWWYyYUFiYnFrZHhmenFsYm40QTFLeVZURThBVjVaWlhVK3pUQ0xkb3dB?=
 =?utf-8?B?NGtpYUszdFZkcmw5Vk5vMHBoSk5JcTZsMTlDbkd2MUJWNExxRVVtZWx1S0Nk?=
 =?utf-8?B?RUFraEkvTkRrTVpRejF0TEdvaUxwS0hLYVgxQlE2enhZSEtGSUdiOHY0VEUw?=
 =?utf-8?B?aFMwVE5yR085WGYyMDZ5UC9aMjZETGRDSmJmek9UcDNOZ3dKSlB1N1RsQ3Z5?=
 =?utf-8?B?WlAwd1NFZGM2TlhZV3JYcFJjUDR5TEtWU3BHejRGYVZTeW8rRGcxMGNBeHAz?=
 =?utf-8?B?VjdSQ2dEUkxQYWVGbzZya2xyRlhXUG1HeC8yK3VUWXFzUzNucloyVjJwQWhs?=
 =?utf-8?B?cUtGcm9Nczhlc1NMOXc4cy9VUExIUkdRTjhOUFJVV2hXbzUyZXM4YUd6RElJ?=
 =?utf-8?B?M0hPWWNFWjlGYzExMnNhSmJ4WWsyQjYyOGNzWVUxc0svZW8rUklrSHJKMCtl?=
 =?utf-8?B?VzZ4ZWVhUVJvUjFydVdOQTRvdWhFYlZDVU4wbE9rb3dTT3ZhdC8xTnpWdm11?=
 =?utf-8?B?VHl5bDhockYrSEJnaHp0RzFOcmRCZ21OV2xXV2QxUWNRRUUrSC9TdVV1UzFx?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5f903e-7d37-4e1f-08d9-08dc9f242ac9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:01:26.6405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOJIc2f3rAiI30t7pJx0puwc2COrwyqXcdfvEMjX6IsJkH05YCSM7RRrOnQ1cguj7J2W3r70QVH+NhX4jNmNkNI5uLz9NnDMEG2i62FIlG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8121
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

Hi Marek,

On 7/7/24 2:29 AM, Marek Vasut wrote:
> On 7/1/24 10:42 AM, Quentin Schulz wrote:
>> Hi Marek,
> 
> Hi,
> 
>>>>>> Shouldn't this rather be in /config node?
>>>>>
>>>>> This is what I had there originally, but then I realized that some 
>>>>> DTs might not have the /config node in them (or am I mistaken?), so 
>>>>> I moved the new properties into the root node, which surely exists.
>>>>>
>>>>> It also keeps the code simpler, as it doesn't have to fiddle with 
>>>>> creation of the /config node if it doesn't exist.
>>>>>
>>>>
>>>> I don't think we should pollute the root node with this. If we want 
>>>> to be able to expose this in a proper binding to the upstream DT 
>>>> binding repo, I'm not sure this is going to fly :/
>>>
>>> The other option is to add more code into SPL, that's not great.
>>>
>>> I can check if /config node exists, and if so, add it there, 
>>> otherwise do nothing. That should be some sort of compromise between 
>>> bloat and config node. What do you think ?
>>>
>>> [...]
>>>
>>
>> Considering that we're trying to have the same DT for U-Boot and Linux 
>> kernel in the long run and that `git grep "\s+config {"` returns 
>> nothing in dts/upstream/src, I'm not sure this amounts to anything but 
>> dead-code? We could also always insert this node as pre/post process 
>> of the DT compilation? But I think some people want to reuse the exact 
>> same DTB (like, the binary itself) between U-Boot and the Linux kernel.
> 
> In my case, the /config node is inserted via *-u-boot.dtsi , I don't 
> think those DT extras are going away anytime soon, esp. because of the 
> 'bootph-*' properties.
> 

The bootph properties are standardized (?) now. The kernel accepts them 
(see the ti and xilinx DTSes for Aarch64 for example) and it's part of 
the dt-schema now: 
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/bootph.yaml 
though I cannot find it in the DT specification (not sure they need to 
be there though).

>> I guess we can start with checking if the /config node exists and we 
>> can figure something smarter once we need it?
>>
>> [...]
>>
>>>> 2- Add info about which DTBOs were applied to the kernel DTB?
>>>
>>> SPL DTOs or DTOs applied from kernel fitImage ? Or a merging of those ?
>>
>> DTOs that U-Boot proper applies to the kernel DTB either via fitimage 
>> configs, maybe also via syslinux (via 
>> `fdtoverlays`/`devicetree-overlay`) and the like?
> 
> Isn't that something that would be better (=more flexible and fixable if 
> broken without bootloader update) done in a boot script which could be 
> embedded in a fitImage ?

That's one way to do it though you risk desynchronization between the 
boot script and which overlays are applied and in which order. 
Additionally, can we actually already run a boot script from a 
configuration node? Because one can simply boot with a fit configuration 
and all of its DTBOs will be applied (if I'm not mistaken), if the boot 
script needs to be executed standalone before booting the configuration 
node, that's quite a surprising workflow (but that would work; we could 
probably also have the boot script directly call the bootm command with 
the proper configuration node, but then one would have to find a way on 
how to select which boot script to use between each representing their 
own configuration node?).

Cheers,
Quentin
