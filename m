Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF807C021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 15:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B5A805C3;
	Mon, 24 Feb 2025 16:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZeXg1e5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C28F180F3F; Mon, 24 Feb 2025 16:09:36 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F91800B3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 16:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G367dB80EfzSFVbyGmDz49ebjAFshr7VNFcWJFgjQtcjeQLEpKKk6wucKghnQF0CJI9V5nS/WNTWkf0BRqvPuXFafowJ+noZF04602RgQm+YvUBBzHESUfk3fviAkDnc4+vQngVJ/Xygn8EpQfCOrqQKSzR3b0F6myqxTOL43KvMefG5ho3s11d6KR545SaYyMAbvKEXn3f88I1WrLOpZp6R5WmzH7fR2EWlG5OGrcweeQy5nHJt/6Rg7sf/AZTrjYluHrD8hvlbh5r/vspuooin0qsfHWwXYRMv1UDHkvB1oAYNEwj5c7BxwEH92F/0u/z9WTwV9+anynaLoyknyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4/siXtyk7csBgwzf7u1ZCax7DQfafls71xx/S0u9kQ=;
 b=cMzNziurr6Xov/8kKEyW6HPlc7h4vhbD11NaSjrsQZAfcPG2ikioQ+I8sJT4gvwknfYiu4+h901KQ7ltkTSo/faLSO4IQSCRdl388Uqq2enuwGRzQ6lf3fyXEM/X+tgpjB5O5CpdjOtA23XIi8f4QVhgITPVImeS9AdoW6bx+ueg+MwXf2vLIQYz75kSw4US4xkOY+AIsm2GFIdhjuR0FwiLNzOlG335nmAe5c4uL0JeKGZ2EADri3dUPC+XgXyoqfC71RV9XVJqY/Ul8Vq5EfhrL7Hi5A5gmhxvzT6kR9XqZLPvujNKF75R+eVeH08G8Fe0zhz5dNenkJCMdC2ylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4/siXtyk7csBgwzf7u1ZCax7DQfafls71xx/S0u9kQ=;
 b=ZeXg1e5DkIfRmMQ7HLyqtcKn07tF7v/yig0gu4jRGa5753Ym4EnpK/sVxkmXtP6DcRjThXHexG2TXGE6b1kWjeeKYfYVJV7DJ14mngFnmbAiUFzIZkmSmBEZUW0UcDt2Gz4+mV78wbCwagwEigEGj2rnwuZejafwvxsimpsOeiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9021.eurprd04.prod.outlook.com (2603:10a6:102:217::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Mon, 24 Feb
 2025 15:09:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 15:09:32 +0000
Message-ID: <7d430025-ba05-4ea4-becd-f746845e2429@cherry.de>
Date: Mon, 24 Feb 2025 16:09:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Need help with booting from SPI Flash
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAJs94EYBX3iNiOcSPXtrxA_brQACwjcTSJ6BjhqJdOdBNGxG+Q@mail.gmail.com>
 <19488fdc-2666-4407-b49b-d25085c98453@cherry.de>
 <CAJs94EbjwrFgh5Rb5addpdj19hfi2SPeDpDgGJYavNA_0GpCrg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAJs94EbjwrFgh5Rb5addpdj19hfi2SPeDpDgGJYavNA_0GpCrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: a221b584-45f1-4514-c78a-08dd54e53e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHhMVE43THVwYjZHNHVFaEZMa0EzdlRVd0licDljTWZqRkM4c1RtTHlhTmpR?=
 =?utf-8?B?L1ZhYnVwR2R6ODFoS3JZeExZajgwMzZmZ3VIQUdLN0Fha2tzcUFTaWtPUWVQ?=
 =?utf-8?B?RnRoR2EyNUJDa0hBQyttKzZ2cU9FUE1pU1ZrY3hZWE1yeFp6OFZ1VGJ6SHhL?=
 =?utf-8?B?RUl3T1dpS0hYMGorbzZyNVRFanBXeWpTNlhiT3BhT29sTEtxeUU3bEtma2ll?=
 =?utf-8?B?Um9VbzlMdDBIeitCRUM3dUhCQy9MWXpINHNxaTRtWUZFQTFwNElFUExRMCsr?=
 =?utf-8?B?T2pGNGhJaU03Y3FpRDZtUnBtYzRWVlhsRFpITGNqaXh1eDNaNTllZGJuNi9W?=
 =?utf-8?B?T1E5UjJIZGxsOU5jWEhIQzI4UDlHbS9Sd3JTckNqS0JlbVplbVpxT1pkaFFa?=
 =?utf-8?B?UStzUklSMVZZY2JoRDhnOEhsK3ZvQXpDd3J4VkFVazdxQWh3Zyt1azV5anps?=
 =?utf-8?B?ZDVyY0kwMDUrbHpjSDFTdEVlcW9jUmVoM01NU00vcWlDcEYyUjVWR2wzdzFC?=
 =?utf-8?B?NWVTR1RzVVV2cWdJQ0RFbllsZmhKR2JBbkRkV2E5YWhYb2xIcnZCOERZRllQ?=
 =?utf-8?B?M0c2QWdVRmtHVU8rVFRYdjlzRERmcFE1NHNFZFFSb1lWU3JVb1FHZzV5NkFL?=
 =?utf-8?B?TGpSQ2VJUDdkVHNFbTFwQys1S0hTclY2YngvZlRaeXM5WlBEY0F3aVBkVEdJ?=
 =?utf-8?B?QWdUWURPNWc2bVBxMnRPWGJzcEtncmd5NjVVVU5nNThyZHhZK2ZnVldBTmpV?=
 =?utf-8?B?eXBGOUFMaS91WjZQZFJZdFJnY2UzNnY4RXZJcFkxTTlOOERmMEVwcXpFV0hk?=
 =?utf-8?B?NWk0clJyVER4ZGVzcjR2Zkh1Qkc1emQya0x0bjBNRkZKVlZQeU5NRjVqd040?=
 =?utf-8?B?WnVxZEZDYW1Jd0FvNTBjK3F3ZW1XRmxYYXZTZzFwQzhGTmY0V1RYR29TQjl0?=
 =?utf-8?B?NFdQdmxOTGI2UnN2dXNqTU5scEJld1ZKUWxiOVM1NnlMRG5VOHIwUnRMRi9q?=
 =?utf-8?B?SDZaZm1ZVjY0T1NBMkloUzFYVG1NTC9Ebko3bE9JekdPQkVkcWhwYTE0Nkdo?=
 =?utf-8?B?UlF1NG0zNWZya1lUYWUwdjZRT2NYd0NTUlM0R0hYeVVMRTRUbVBFcGc0MTFC?=
 =?utf-8?B?Q2VRTTZVQ0t3SEpTSEd6WGVJUWhlQTZMWmt5L3c0RVBwSkhpTUUveGdDckV1?=
 =?utf-8?B?OEwzbHY4ajRxbmVtZ3FsUTZkSkNJTDg3WWdZelErUE1MTUlsQ2wxVG1vSnVQ?=
 =?utf-8?B?N3pxTzh2ejBvNnR2MlF4U2xmYzZ4aDRJREV4ZHp0cHkxWnZBYjRaUG0xMDYw?=
 =?utf-8?B?RmVXUnI0QmFYeTQ2T3Z2M2dYaGR3VEsvRExGa2dFSlViMXZML00xdVVyS0JJ?=
 =?utf-8?B?TDlSbVZ2UnV2ZlhqNVIrNGx3MVJoZ0QreDhNMG1wR1ZyTnNVdXVjWktuQ29J?=
 =?utf-8?B?NUFhQkVoWGRnZVNHcU1oN0p6b290a3VnL0xSMVZoNWtiZUx3RmQ2eWhZcnZW?=
 =?utf-8?B?SnJDRlBkeUxQcTUzRUp4Uk04bFdNMHNJeWxpQ2VlT0xHcjRwUDQyUFgrL3I2?=
 =?utf-8?B?N3RuQUJyd2phYytnaFRvbFU5ZjdYek1zVlNwMjlPVDZaa0hwOUlBdnhUMDMx?=
 =?utf-8?B?MGVNNThFYWR0NXgzY042VnNoMmJFZy8zOHNkT0FaOG9Nb3FndHRXbTNZSGlK?=
 =?utf-8?B?OVpQSG1zcm1YMHEwak5VTG9sbi8yY1kyN2FtOEw5TXM3N1NnMzNDdGpMTlc5?=
 =?utf-8?B?aTB1TEVLaGdOS2J4dGJJbUg1YzJGUFBsYm1pYXpuZlZYSkVobGNYRXJXZHNw?=
 =?utf-8?B?VXZiTjBpbVBmR1ZsK3BNMDVrKzhYK1VlYnh2OWl2M3JXZGFKVkZYcDdQOVNa?=
 =?utf-8?Q?Hhvd88XEVf8XJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWV5V2Nub09rRzNWdTJZWFZDei9VQ1RRSnZEOWluTFJIcU1wRGZrM0xvUXpD?=
 =?utf-8?B?ZDZTVUNBdHBJeHZ1V3BCVmY5OFA0SHdyM2wveHVNOUNVQVhkdUZuL004RDF0?=
 =?utf-8?B?S3Z0Z3NMVVdjTUUwUWhuV2srNUZOMVlNenNXTCtxQVU3NzQxN3JlcmJiY2Ir?=
 =?utf-8?B?cERUWVZQa2tEZWwzOHBHbUI3WXA3OExDUzU2ZU9OQm56SzRNYjN1SnAyK2Zv?=
 =?utf-8?B?a0V0R25MdC8rVldrRDRGcW9VaUcrTUNMcjA1ZWF3TVVObm1FVDVXKzRSdHZi?=
 =?utf-8?B?ZTJCSXRaMkxJdkwwN21GcmdQdFdGWnhKL1pkdTRoYkRWbU0xVTRVN24wT0tp?=
 =?utf-8?B?aFRZb2VyMExzb1lEbjlhZXlYZHM4ZU5BZjVFbWlXNGtIRTlHT3U0WGVnOXoy?=
 =?utf-8?B?T0Rja01vL1FIL2QyOEV2SjNBY21TT2Zwak5hM2hCUXVQWFBJQ0ZiSXJRcHV0?=
 =?utf-8?B?M1hUcUMzV0c1b0ZPZzJGWXpKaVpleXlWUS9zQm5HLzcwWGllaG1QTU9ESUxV?=
 =?utf-8?B?dWUzWkV1VjRNRG5PYm9KQlhwek56QmJIQmlKdHFacStqVGN4bkQ5ejBlcDRr?=
 =?utf-8?B?d0kxZC9QUEJRSWlUbjRKMG5ZcGsxaGoxL3VYT0xyekdqMFMvM3VhVHZYaHQw?=
 =?utf-8?B?L1NPdXJ6b3dCWFk2ZlNZWEw5K0c2UUhWTG1KajlzQ1JIS1hNZmY3SDIxWk9h?=
 =?utf-8?B?YVVnUUNuOGhSK3ZUOFJoQlVkOG5sRUFab3UveS94SjNBRnZTeUEvbHZ2UllE?=
 =?utf-8?B?ZVNwQm5OdTBUd09wanVGeWk4eXluQXY1Ui9CNmpQLyt5alBmcHBtNGkyL2R4?=
 =?utf-8?B?dzVCN3lpZkZZdzFYdlllRDZoVTgrOFpWeFVGVWVMZ3BVcUpNdEpobGlkZHVR?=
 =?utf-8?B?OG9NYnIxUXpvQ29XR3VFUWFNZ3MrSmlmbnJMNzBFVGhtRjhjb01QSEg4RHkz?=
 =?utf-8?B?SlRPWTNyNFZUZ01wdHJCS2VBOFdaMWM2YmI0cGV0SkNPVjBKaHYvZTFIelY5?=
 =?utf-8?B?S1RSNi9Dd2hvSHZHaEhJYnJTeC9VRm9Pb2hzQkdjaUk4TENJRm1DOE1qRXkx?=
 =?utf-8?B?V2NSbjNxMjhXY0MwYzZGSnJGMVpJektLSTV2VGtUd2tHZjgxQ1p5RCtSNjVU?=
 =?utf-8?B?QUM0dk5aNjR0L0pTcTNhcjFIdTlNd0NVM2twUjdvcGpsSHd1UWwxSlNsemt4?=
 =?utf-8?B?MS9wWUZGYzk5Nng5d3U0ZnRoaXhDV2tkUWNuNGU2dUdqV2xoNjNQQ0hnODNx?=
 =?utf-8?B?bEQ1T1huL0FJN0xQZ3ZwQTJtanhnNkNWdFlJbk5tOU1VWGdVdEt5SXhDbTVk?=
 =?utf-8?B?V1FOUFlXWXBMZ3FKR0ZDK3F4amJmOVlhSWNaSlFrVExVZ21xYk12WDMvZi81?=
 =?utf-8?B?RnF1emtwOUlrbmdmaWlRZEQ4UFRlb1dqNVZBWThjSlF1ZFNxL3ZpcU1WUko0?=
 =?utf-8?B?c0M5STVPTEdoai9WUHNUZjBFSVNRZGgrekZOeTlwN2VNdCtzTk1SeUZqdEwr?=
 =?utf-8?B?NVRkVVZHbUJkNFNEempHQW9ER0R3Y2g2bkdYVW1VMmRSWTJ4d2RheDYwZ1Nx?=
 =?utf-8?B?WGY2Q0g3TmI4SXBTcUpuR3dmdzVLV0tZbTNoZlhBYlY1MlBOVDBUaGdlRXNs?=
 =?utf-8?B?UnFaL2Z2T3BPc1BVdEtEa3FmNDhlUWdKUE0walBJaFE2NzFnRkRhNTVFMUph?=
 =?utf-8?B?WklsODFtSUJVRmw0dUZlZ2xCNXNTNDUvRHpHeWxxNjNKbzhiY2hndW9Ud0c0?=
 =?utf-8?B?dTZrcWpCajhCWTNMNzVkNUNUSk9nVllNbHNXK2hvUXp1UkpMeEY4SGgwUEJn?=
 =?utf-8?B?YkV0cmlydkFNR1kxZ2g4Z25BcEJLSWFmOElNK0YzYjArRlVWOUFYTTliNXJZ?=
 =?utf-8?B?NHluUWZSSlhSeTJMQTlqM1h5SDVLNTF2dkhCZG9abi84Y0ZQWlVKejl2YUZE?=
 =?utf-8?B?S2cwaXhINU9vd0xkc1pJallHaHB4WEdneWJTNEhhSERSNWMvbm9YbU5GMm13?=
 =?utf-8?B?cVYzQjl3MCtnaVhwd1pqM1N2MmU5YjNraUJFOTZVbzUrK1Bncnh5Vkwrdkpa?=
 =?utf-8?B?SWMwVVB1WFljSytmY3ZLbEQ0bEJ1SWJ5Q2oxYkJvWVNlcVplSWxiTVFkalNr?=
 =?utf-8?B?Yi9qcWtuUHRtU0x6ZzJOUTNpVDlld1p2d0M2d2tjMXNMNG92eklBRnNyaDBE?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a221b584-45f1-4514-c78a-08dd54e53e13
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:09:32.4350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpieASY1YshBPVTViB7V83pzV3JzTOvvE5H6b44iUSfRc7XDZNnMAQvkHFEPpOY7RNVIchUGJTZ9gUjoeytOLgatFHyrxu2fWyb3o9GQ48g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9021
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

Hi Matwey,

On 2/24/25 3:37 PM, Matwey V. Kornilov wrote:
> пн, 24 февр. 2025 г. в 13:54, Quentin Schulz <quentin.schulz@cherry.de>:
>>
>> Hi Matwey,
>>
>> On 2/24/25 10:57 AM, Matwey V. Kornilov wrote:
>>> Hi,
>>>
>>> I have an Allwinner based board with manually soldered 16MB SPI Flash.
>>> I am trying to place u-boot into the flash and need some help so far.
>>> I have already updated the board DTS file and checked that the Linux
>>> kernel provides me with a /dev/mtd0 device which is writable and
>>> readable.
>>>
>>> I enable the following config options additionally to the board configuration:
>>> CONFIG_SPL_SPI_FLASH_SUPPORT,
>>> CONFIG_SPL_SPI,
>>> CONFIG_SPL_MTD_SUPPORT,
>>> CONFIG_SPL_SPI_FLASH_MTD,
>>> CONFIG_SPL_SPI_LOAD.
>>
>> Make sure the driver for the SPI controller on your SoC also is enabled
>> in SPL.
>>
>>> I am not sure that I chose every relevant option.
>>>
>>> However, I see the following message from the bootloader:
>>>
>>> U-Boot SPL 2024.01-rc1-45362-g94a35b52f78-dirty (Feb 24 2025 - 12:43:35 +0300)
>>> mxstatus=0xc0408000 mhcr=0x0000010b mcor=0x00000003 mhint=0x00004000
>>> Trying to boot from SPI
>>> Invalid bus 0 (err=-19)
>>> SPI probe failed.
>>> SPL: failed to boot from all boot devices
>>> ### ERROR ### Please RESET the board ###
>>>
>>> Are there any obvious things I missed? How could I debug this?
>>>
>>
>> Can you check your SPL DTB has the SPI bus and flash node?
>>
>> dtc -I dtb -O dts spl/u-boot-spl.dtb
>>
>> If not, you're missing a <your-board>-u-boot.dtsi in arch/arm/dts/ where
>> the SPI bus (and most of what it is needed to enable the controller,
>> power, clock, pinmux, ...) and the flash node has the appropriate
>> bootph- property. I believe it should be bootph-pre-ram for SPL,
>> according to scripts/Makefile.lib (fdtgrep_props).
> 
> Thanks. This indeed helped me, while no success yet:
> 
> U-Boot SPL 2024.01-rc1-45362-g94a35b52f78-dirty (Feb 24 2025 - 17:31:47 +0300)
> mxstatus=0xc0408000 mhcr=0x0000010b mcor=0x00000003 mhint=0x00004000
> Trying to boot from SPI
> fdt_fixup_memory_banks: FDT_ERR_BADMAGIC

The code seems to be wanting to load the DTB to fix it up. I do not know 
if it's U-Boot proper's or U-Boot SPL's it's after. A memory address 
might be misconfigured in the config or include file somewhere (not in 
the environment likely as I would assume no environemtn in SPL just 
yet), maybe the "wrong" U-Boot proper was flashed (e.g. one missing the 
device tree) or at an unexpected offset.

Cheers,
Quentin
