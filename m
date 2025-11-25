Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62D6CFD368
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 11:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FFA983FF4;
	Tue, 25 Nov 2025 12:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Xps4uAjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDC9283FFF; Tue, 25 Nov 2025 12:42:51 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AED083FDF
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 12:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPM/gvs+YTmba6A2cyDLLsb55A0mUlJpEvW1N7dhgHvRqU4NwIjIFnDCAvGtZDEfnjD8Grv3zfU9ck2MRBFC+EkF3sXyzfc9LkboVFBuzPoi+oraFdKEbgsg62wAsZYSpTMrdWYAgP0bKNHj85iPiYvI4xB0sDRAJi5BoYD+afYS1hjgnCsiOuKHRtuCW0Dz7uPGFc2d32pEgoGlIAtDFbo4W1tjctd5BM32clTSpPMIj75QUJEIjR592bCTc81ElT11owi2srL0nNdGlqOl+S6Q4jtGmNNVg/twsqUEVL0MPpKRfPhWVpniEfSzMyvh6BZ4vA2pxbwe8i1yC05Lmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nXyrm0N0YYVenYdbOdr8+U5k/yBZyh2xLVeFvUFrcg=;
 b=Kuo0C293WIrfOkuSqCvOUfcHAzs8Pc2VNUYdZbY9lXwra1SxjOdbq5mKAhPloyATwskm1U0VE6NFLFGjgpVhJwfqbQo5iOYuYapJstKW9Gxi5gFBsBGr19zXF+s1kqC/CaWfZGYWnwW6vqRn0c/xjYjmGXGXQZ3m59x47G8+9NzeU1KLjCuwIKUFRbjOVTFXRYZeWMEarw7qSVvD1hFfyJ7twQyJyoldvIH8hq6bIUXl5TOEP0aJzRKhFRKQrPcQ+tkJafcSjSif2C029EgW54v+6qLTS/362UVj8mQ2iuwsUWGaS0o9qQxSsFacICq4KO/gFGgRnl34LQxWXXStoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nXyrm0N0YYVenYdbOdr8+U5k/yBZyh2xLVeFvUFrcg=;
 b=Xps4uAjfVsGRbWWLaNAVROnQZbrHqFFVt5bXPMHpUZnZWokxoOX3QWeNe2uXcPqW+9asZDjlLVwxtwGUfOqAea+VSqaq0WXOuvJhRjawlGdlmOr0B8aETopt01XVBWB1FlFr6JHh8MEVTTMwf2U20LIEcRccMmWKIQTPcHypgFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB11772.eurprd04.prod.outlook.com (2603:10a6:10:615::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 11:42:41 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 11:42:40 +0000
Message-ID: <8d0350b0-5a59-4bb6-adee-9fba2d2e2a5e@cherry.de>
Date: Tue, 25 Nov 2025 12:42:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] doc: cmd: document the led shell command
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Quentin Schulz <foss+uboot@0leil.net>,
 Ziping Chen <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Klaus Goger <klaus.goger@cherry.de>, Eugen Hristev
 <eugen.hristev@linaro.org>,
 Durai Manickam KR <durai.manickamkr@microchip.com>, Stefan Roese
 <sr@denx.de>, Zixun LI <admin@hifiphile.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
 <20251112-led-old-dt-v1-3-2892d49517db@cherry.de>
 <c10c2b6b-5daa-4128-aeae-977bb0f72be9@cherry.de>
Content-Language: en-US
In-Reply-To: <c10c2b6b-5daa-4128-aeae-977bb0f72be9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB11772:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f298fa-7dc6-499f-f10c-08de2c17bd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXFuMy9XY0d6b2EyNVBCVEo4M29NaG9BTFltOFBYN2JXdGtRbHFaSEFjekZE?=
 =?utf-8?B?SUJOcGhqeUhiYTl2Z2J6dE8rU25MN1FXR3BURzllWmVockFYcFdnekZ0M0tJ?=
 =?utf-8?B?dURxV2Rsa0U0SE51dW9haUdhSkhPakNYQ3RtU254b3dxT0g0b1N4S29yck9p?=
 =?utf-8?B?NFRiMG01MGY3UEU0SGhlanZ0RTNWbVp4bUw1YjM0M3dKM0Q1MGppU3VMMm15?=
 =?utf-8?B?d1JVdWQzNFRYMzFrTmJrVHJydFdRSUlRcjl0c2NkNHZSblpBZFBsck9wSWE2?=
 =?utf-8?B?T3E5VW4yVkpraVA3bWhOQnlaTm1OMVpQYTd3aEFRU3lrL2JFTWpuS05xUldM?=
 =?utf-8?B?cmVtcENidEpLbEVVVmdHRXIvZUwrVkRDSkVIUXlseHZFQUhwdDNOeW1FdGth?=
 =?utf-8?B?VVNhYVR4ZXdWOG1HUUVwM0F2bWZPY1h6MG1lZis5c29UZG40MCtVZFpMZkZT?=
 =?utf-8?B?TTdwOFhRd1gwaU9pODdJZHc3WnRBVWZLZUpleHZBSGM3SnJSTlVDUEFYblFw?=
 =?utf-8?B?aERsQXp2UTZlRWsrZXpKUzljZG84TFFqSE5PK0FOYUgxekZTOE1vVGpRT0Nh?=
 =?utf-8?B?N1poVExiU21vcTFRQVFzSnJ1bHoxMWhDak9SdmlwZGt6aExkOW83NldwNXlI?=
 =?utf-8?B?dnIxeDdpUVFDNGpVOHJLNFkxZXNvbmU0R25vSFUvTnpzSmdyaG56NXpRWjc5?=
 =?utf-8?B?M21KVkwvSVpUdi9OK0dsTW5HTnNqK3NNWFZUZ2VyUWxuZ3F4Z1RSeFJoTDJW?=
 =?utf-8?B?Y0Y5bG9VeVg4L0J0NncrMisyS2REb1phWFZORE02QzN4MWhDemxKMkJnb0VR?=
 =?utf-8?B?L1Q3VGNBWWx5TEFrRjBYak52S3BCWG9OOGVoR1hCei9wbkMrd2ZvUk5vcGN3?=
 =?utf-8?B?WTlXd2tkTWh2VDQzaTVtd1ozaGMzSVVjRjdETTJoQkZ5ZTJ0TUwzdG5QVWI5?=
 =?utf-8?B?MGpSd0ZsdWpPV2R4RnVBdHBsaWdZU2pVdi9PdXM1cDQ4eTB0djhKMVFsUm5I?=
 =?utf-8?B?N2RJY056djhjZ0xOM3ZQMWFGS0p1K1VXN29XdkcrVW5XOCtGd3Q0cHNtOXZ0?=
 =?utf-8?B?aGFCQ1ZnRGwzSDdGN3lUcGFwR1J2VXNzTUNYd0hWVUdHeXh0cEtzV0ZmZTND?=
 =?utf-8?B?Sk91RG9zU1FDSksvK2VCWTFpVFpVK3hjeVhTUzM5OWRSR0NiZ3RWZWFEVXhh?=
 =?utf-8?B?ejEwT2ltTHEyQXZhcTlHMjhGcEo3SUMyRjNJWGw3WTV0N2M5MDJ1WEFoSkFU?=
 =?utf-8?B?L21rbVZuV2M5a3dYM3VhNjdjVExRMWYxMExpS0hnb1NTOEk2SFNVR2thQVJs?=
 =?utf-8?B?SDBUa0FUM1hoNXA4ZEE2Yjh5OForOG5aNFpFb3JWZlBicEoyUHRwRzBMWUU5?=
 =?utf-8?B?dmJyVXI2eU1IV1pJbWFZSnRwTFFGUDhZb3BLTFNpK3BJZTNBNDFSRThyb1BN?=
 =?utf-8?B?S0h3WnBxdE1GdEhhS1BvZnErekMxSDBYdGh6cEc2OElOMHM1cnhobUwrdCtZ?=
 =?utf-8?B?WmFHVkVNNytVQUp0bWQrVjNRc2ZFdzRKN2x1Nm10VDNaM0dEVWI1d0RjVTh1?=
 =?utf-8?B?YjJpSlJPei9nZ25XZUFqYkh3Z1BrNHlzNWttMm12bk5hMkk4czg3dDQ0SjZC?=
 =?utf-8?B?N3VSaTg2d1cyMTlvR2wzUnJmSGdsRmRCWGwyMUlqWUI2eURXME9jRUFHZWZW?=
 =?utf-8?B?RWhZUk5CeHBLekZEeTRnNlV3bFRVZklDSGdBTkkxSXRaK2lOYXFvSFBzSjV0?=
 =?utf-8?B?ZURZNGpBZ0dLVG5oQjRCZURXYk1mNUhqa00xK1lNZ3JNOHRXRGxkQjRqUE43?=
 =?utf-8?B?TVNsVlBzUnVRUUlxcEZqTjMyRHdrdk53NUM0dXpmVFczU2JNODlwWlFNZ0Js?=
 =?utf-8?B?YWg2ZzhJOEZOS2l3WXJySUtETGtjQ3p1Q0M3ZHA5M254V2RuZTQ1Z1hEMFh0?=
 =?utf-8?B?Y0NBekdteFJXaU1NNXVNSDM4U1JTeTZUL1ZYNnZsai9YV1ZLS1RHWExQL0VH?=
 =?utf-8?B?bklKS040K0h3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWtud2dPTy9OQWZIaXZubCtBYmVIaDZTdG9tVmZFck8xNDRhZmQ3bXBvNFp6?=
 =?utf-8?B?Mk93bG1WQU5wZ3ZITFQ4Y2oyTUdWK3NrL0d2YWhQN0NlNFVqRWhYSk1NZi9x?=
 =?utf-8?B?bUxvTkkyRzQyV1RRV2xiYXV3eGRyWHVpWjZCc3dGYXVHb29CTGtpaW56Qm91?=
 =?utf-8?B?R2NsSC8vWmZoVk4xMUF2cmNwTHBrZGlIWXdlWFZadW1uL2IwTzJkM3hIQjQ5?=
 =?utf-8?B?bDFPQlUvSkVBNEUvSjlsczM4SmNkOTZndkdVR3VXQmZiQjJUaGc4VUc3RE9Y?=
 =?utf-8?B?ZzhSa0ZudnZQbFdEbXQvT3RyUWYyUTVrd0F5NVNBOVJLTXBXUEpsTkhjYTBM?=
 =?utf-8?B?YzVZZG1HdkVURzlnWTBsVFRTaGdGb2JqNEVUNithZG45WGFEQk82Y2JiVWFS?=
 =?utf-8?B?bUx2REFqZzFHK25MditjOWpMVEh4YUQyaWZGdmtlMUFvaXpaWGIyRURzeWRE?=
 =?utf-8?B?Y3Urc3MzZWJtTjhBMHdnVGxxQkh4YWpxbTV6OEZQT1N6aVQ4eGdTSENWRDE4?=
 =?utf-8?B?cXV1dVpwN0hNb09vNzhTTTU0QjZHTUNvblZHNU11VS9yUEF6bTRJanVHb2VY?=
 =?utf-8?B?MWdqcHpKa2RxS3JRZkFyakFCVCtxYkUya1BVQjVkRUlqK2tEejBzL0FjSjZi?=
 =?utf-8?B?ak4rbkdGUVExczdiZTVvQWVXUS96c3gyeDNrOU5OQmhQOFV0dndSdkwvc3dn?=
 =?utf-8?B?M2crSTQ1dCtzMFdyNHZldE1nN2QyUVV4UzZ4SmZYS2VEY01EZDdBSTVBYng5?=
 =?utf-8?B?c3Myb2Q4SVZqWk1pOXZOVGFvdzhyNlhIZFM4d0FXSlNJckgxRmtETVVDeEYy?=
 =?utf-8?B?cWVlbmJtdFpVMXJMamVDY3lqZ09RbUs4akxUVkF2b2Z2bUhlRGd0UEFLdGRO?=
 =?utf-8?B?OGg0Nm1aTG81cDUzSGo4YXhSVVJGblpaWmRzc2twOStpdi9nemxBRmhZYXFT?=
 =?utf-8?B?RFZXNkYxeHdGS0hQaEpXZk85VVZWdnpGTTE4bDhrT1RIbEFwdzRwMm9paWlH?=
 =?utf-8?B?TmNiYnEzNUtQb1pLamw2aWpWeFpwNW5TOUNYcXJGaFhXZEVRbXIzMG53d0dL?=
 =?utf-8?B?dlFIZU5zSW1nZEJlb2QyWDNPdWJwMGw4bTFQL294TVJ0cGhvWi91MEZlSHYy?=
 =?utf-8?B?VHJ0azlPTVVLT1lYeVNXNUx4VE9kUU5KRjFVeSt1UHVqM3hCcGN1dzZKaXVu?=
 =?utf-8?B?Wjc1OXJvL2d6YWw2MGliRjhWUGIxRmZiZStMcTErNm9mV0ZaYU9UeENhYXNI?=
 =?utf-8?B?YmhNcmhLWmVaWmczVEJDazRpd1BZS0FXeFJZZFR5ZXJnWUIwRXJQN05USjVy?=
 =?utf-8?B?T012Q3ZEMmZ1MGUwU0tsMzBwaDhwYTNkRk42TDd4azdydHpqYjlYdDVUbm5I?=
 =?utf-8?B?YndRTDVjcThWd3B2eUN4UmcrVCtVSTZzSjdqdGdSMzdNMi9BNVYzekNoL2lv?=
 =?utf-8?B?OTJ6L1Z6NXhyYVRwM1NQbzY2R3dGNTMwNTBobVdVNkZ5MWFUeVkyOXNTRGtK?=
 =?utf-8?B?TkxjT3hzTE56eEhuTnNkMUlORVZyQ2JVOVNCcU5VUUJQVXBMMFBIeWhvRVZQ?=
 =?utf-8?B?RXpDMTVvek8xMWtqSE5LNjhabEpzQUhmQXBCYTFyMDFVQU9JZ2dNT2FCbXdt?=
 =?utf-8?B?YzY5V2RNSFFHQnJMeUZtb1BFYzFiMHF2RytvVFRUaUFJcVNRNUtVNVRnWExp?=
 =?utf-8?B?RVlBZnlzaUlEdzcySFZDck9SUVc0T1Q0SjlMWUwzYW85cnVwdHR2bEQxRkp5?=
 =?utf-8?B?K0tLWW1JYy9BOUw3dmx0Q0dSSWZRQ1RnYktVWFlxMloxc1NTZ2VzVkRta09Y?=
 =?utf-8?B?RVdFWUxaeU9CbFlMQ2VYSW9BZnRPS0hBeXVaZlNzS0VKNTZSSHZjOHFXU1Zv?=
 =?utf-8?B?aHBUTUlxZXd2VTlxMWw3R1lWbjhGZUxwM1NLd21oMVliaUFKTmxyVkpzMldO?=
 =?utf-8?B?OHNXOW9CNnlaKytGaEYwKy9LajUwZU9oNVVHa05BOGY3TEdSRUxEVGR1N3li?=
 =?utf-8?B?N0xyVFRFR3hwMm5ZVENtU2JOSXBmVm94NXN3Ujh4c2NJZlErMW1SVnh2TEZN?=
 =?utf-8?B?djRwME05UTlvMUtJRTJIRG9tRlBkazFlNU1aODBTTDdpUHA4QnRqQkNwSlIv?=
 =?utf-8?B?WWxEZXNjbGJadGFvZ1lJUndvRTd3dmhESkF3cXg5eU1FVjIzaVJrdkFFd0k4?=
 =?utf-8?Q?esktNtMRs8cjMRQbglTr9Ws=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f298fa-7dc6-499f-f10c-08de2c17bd71
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 11:42:40.8492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ar6MbOE8nOJZVsEQYrByAdSSFwsJztLWvPbUGAlDvSMVLIVnBiDm/4+KGM1xw+cknq8ehpJ5625oCw71kAaxIQlMr1lMNuGYbsVBtQ8N8+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11772
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

Hi all,

On 11/13/25 11:58 AM, Quentin Schulz wrote:
> Hi all,
> 
> On 11/12/25 6:48 PM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
[...]

> 
> It seems like there's another led shell command that you can build with 
> CONFIG_LED_STATUS_CMD=y that uses the legacy LED API... Should it be 
> mentioned/have its own documentation page?
> 
> Maybe we should spend time porting the 5 defconfigs that make use of 
> this legacy API to the new one and entirely retire the legacy LED API. 
> However, there seems to be some discrepancies between the LED_BOOT 
> behavior and that of CONFIG_LED_STATUS_BOOT. The former blinks for a 
> brief period of time and then is solid on once reaching U-Boot's main 
> loop. The latter is blinking sometime after relocation and then turned 
> off on first BOOTP packet.
> 
> Out of the 5 defconfigs, 3 are using GPIO LEDs with 
> CONFIG_LED_STATUS_GPIO=y so it shouldn't be too difficult to migrate to 
> the new API just to get the LEDs working (I am not talking about keeping 
> the same behavior). The other two are configs/eb_cpu5282_defconfig and 
> configs/eb_cpu5282_internal_defconfig which I assume are for the same 
> product, but it has not seen actual updates (aside from tree-wide 
> migrations) in the last 13 years. From what I could tell, this is also 
> GPIO leds, but controlled by writing directly to the GPIO registers 
> instead of using a driver. Maybe we can issue a deprecation notice and 
> tell the maintainers/users of that board they have X releases to migrate 
> else it gets support for the LEDs removed.
> For the other boards, we probably need to check how to use the DT for 
> the LEDs that are currently configured via the legacy API.
> 
> This is at the end of my todo list though.
> 

Multiple series sent for tackling that:
- 
https://lore.kernel.org/u-boot/20251112-led-old-dt-v1-0-2892d49517db@cherry.de/
- 
https://lore.kernel.org/u-boot/20251114162417.4054006-1-patrice.chotard@foss.st.com/
- 
https://lore.kernel.org/u-boot/20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de/
- 
https://lore.kernel.org/all/20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de/
- 
https://lore.kernel.org/all/20251119-led-legacy-vining-v1-1-6107439085a0@cherry.de/
- 
https://lore.kernel.org/all/20251119-bus-led-removal-v1-1-340218264e59@cherry.de/
- 
https://lore.kernel.org/u-boot/20251120-legacy-led-sunxi-v1-1-c4c1422fd242@cherry.de/
- 
https://lore.kernel.org/u-boot/20251120-legacy-led-removal-v1-0-369d44338358@cherry.de/

I think this series here is not blocked by those. (I'm commenting here 
because it is not uncommon for series with open questions to stay on the 
list without review and never merged: so this open question is now 
answered I believe).

Cheers,
Quentin
