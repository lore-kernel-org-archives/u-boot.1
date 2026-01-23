Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D03D7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 12:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D658283BC4;
	Fri, 23 Jan 2026 13:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="wr4QoK+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D329783A6A; Fri, 23 Jan 2026 12:24:43 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A9A98397D
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vh8ULWz3zc3ET+BtTF5GiJiPjZdt1kLJeawLmcDkbHnTNFWTpuIBRRt8dAZrdzRQfkuK68ViXrvNydj3L4nDY+xL177xdvFpYX2XFp3msN6xY4jvNyWoC49X0JOjpe7eSQRrOGHGF/ud7jDv8oGDA41dh68TN6ApZmmjQUPVbrKSIc/hoRe6TzVEVtuIrg0xSzObGRMrW2pQjHGIBKdA28fkYV6WbmZwghfhSg1UOyvHcrzyCsQXocFx44f3WGPSuOByNbPol/E+C07ddo8UZoZdYJWr4uzrGg+4ZISYzg3AUd3SUXlMO629LudLOXqQotwEju0eJtgMeafARl82GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfQzQXHjApysTYz5zKoMU3lBHTeVV3PuSkEUrp7gXbY=;
 b=uSDlvb7eH8ULlvU9+/p1clGmve0OUUlEZ+ydNFKWU6a0Hmp+TH/CtEMeaRtRy6o8T4spPUMelPGJlipyTQcFSWNryF2lXgKrHUW2khJ7IDKp558a1LISU2Crw6V0ig26mHwjB3vmZuyQBGRPQUpKvu7nGa7P/q3pTfntrOjm3AQNRroysakcy0Y5EPetHjLXtprnmM2taEdaQHPEMmyTuB193g10R5pcOI3khd7nzO9++ejSRgBnpwiKj2ZZ7xFK2pREcJLUt+PcroYlq+gxaY6nq+9FIqyfLz5/FILjJZtRUP36olHbMdkA9vgRO9pF/1uMCNeYwGu6Xl9R+aNYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfQzQXHjApysTYz5zKoMU3lBHTeVV3PuSkEUrp7gXbY=;
 b=wr4QoK+LAn7LNRx6cFkv1KkVdnyzSPK9AGmAiGGzr3/Wi4CNIoo2znX++L+Mu+6R+6TzX4Lx2sEqFd2ks+k7Ng+cPnCqo3rC/Aw05XAPdWtVi66ygKTX9/gpNHDY2MqwNoSf3ytTlI/ChcOpQoRRv031AF+l6Ji8uGk1R9ThCmNjKJKjpJLbkMagCCjpM6zvcLpIsUbWjAoQqRKN0BYPmE3XGJHO/BLCRrzGUNC2E+M9Pp94sZA8mqB99JexOQR8SjGhgw/+4NDXJGfH5TJrn8im5b1fmeD5phmG5wzznXuh5y15O/FofjbSsBIhmrp1iGCemFMyGBNtgn3ImIGIcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH4PR03MB7748.namprd03.prod.outlook.com (2603:10b6:610:23b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 11:24:36 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%7]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 11:24:36 +0000
Message-ID: <9169a6e7-67e6-47c2-bb45-4b30dcb3dac4@altera.com>
Date: Fri, 23 Jan 2026 19:24:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] dm: core: Support multiple drivers with same
 compatibles
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Simon Glass <simon.glass@canonical.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
 <20260114-topic-musb-probing-v2026-01-v3-3-ebb8d990b9df@baylibre.com>
 <87bjitesqo.fsf@kernel.org> <0d50377b-22dc-41f9-b74f-de1cb97959c0@altera.com>
 <DFUFESMXOFM3.2HOK8WAVWWSLD@baylibre.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <DFUFESMXOFM3.2HOK8WAVWWSLD@baylibre.com>
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH4PR03MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4d877c-51c7-4fba-3a1d-08de5a71fcf0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2MybHp0SXJzOGNub1lHNmgrbUx3cG9vcVlFOE02M0FlaFBwSHZEeUZqNzYy?=
 =?utf-8?B?T1BwSitHYjJKcjh1VkNTcFlmQTlaNjRoOUdLb21ucllBb2IzK044dnVDYXJh?=
 =?utf-8?B?b2RFcnd1UndsS0NkVmxpb05MdnI3L00yZXMrRzVxNmtEbTExTXZjRi9Kekx5?=
 =?utf-8?B?czFGU3A1TVhkMm5GVjUxWktnNWlkcjd4TW5kUnlGTXkvYS9JbERZZTROSTU2?=
 =?utf-8?B?Z05zVnh0aGdlWmJDMUM3R0U2UmtvLzdFb2ZCWkQ0MDV3ZnI2di9Pem12V2FG?=
 =?utf-8?B?VFQzWm5TbWdROXBYWHFuR3RFWWVoTUdBRkZQK05lWE9rNEx6Y2dNekNiL2ti?=
 =?utf-8?B?Qlh4WkdWbUxUR3V3MUh1cEJKakdYSXVCTERLMnBDdUgrY1JycVdTMEYvNzBO?=
 =?utf-8?B?KzFyN0g3OVZ4NCtxYTFvY0tGbGpxYnBKMGd5clR0bFg3VURiODdRWlNpT1E0?=
 =?utf-8?B?LzJSakVTN1JZZW5WaTBQN2hYSHIvVnB5TWxPakZWTzBsbnlXQk5tTWozYmZq?=
 =?utf-8?B?ZXBTZTR1VVpzSkNoQXVqWnNQRDl3VW0ySlVTd0VENFFuTmV0U0kwSzRpdHpY?=
 =?utf-8?B?MzBPY1pKbW1WWCs1WGp6b08wekc4dFI4SjlqdEFKRlFsb3RnVkJRSVZsMDdV?=
 =?utf-8?B?eGoyMHBHSGVZYnVnTFQ4c3NqMS84ZnZwV1gwRVViNW1WWDhucXJoM0JSV0JQ?=
 =?utf-8?B?cE83K0NDWG41OXQ4U3c1TEVYTlVoVEVQRnByQ2JVRFpHMVhxTEM5ZXJxNlJt?=
 =?utf-8?B?NHVBNG45RFFiamE5UEVIYTE1ZGZPazhmUjk3MXpMQ0lsODdlYlJUR1B3MXhW?=
 =?utf-8?B?QmJ6c1JXWUNOdXlKOGw3c1VRemE1a2NjUnl4ZlhBRzdzeUZFOFA2bXNtcko4?=
 =?utf-8?B?c1Btb0tibUQ4MnU2U3N0bHVKb01rakZ0QnJxSk9oRTBldU9qN0IzNXNOQmcv?=
 =?utf-8?B?YzhqeTQwRy8xdW9HZmRaWkdjTzBBR3F2enRCOXV0RGhoUTQyYmpDM2UrUU5N?=
 =?utf-8?B?eDU5ZGd5VDIyQjI3VTNha3RQWVZXTXlva2x4djNFV0FxTkNUTGVCcnpiVmxi?=
 =?utf-8?B?Q0lWTjlSRFg2a1FXUmg2NlJOVnlvaC92MEF5VFFWM21sTjlmN0E1aEN3aW9y?=
 =?utf-8?B?Nk1PRnJuWXRwdlhvVmREdkd4Y3ZjSmhFWFh5Z1QrMkl6d3crNEMwUGhMWE5v?=
 =?utf-8?B?TGVKN083ZkwyYkxlVTdrZjZzNWk4VThxZnNIWnJLZHkrR0Y2cVp3eStYMVBp?=
 =?utf-8?B?aStaTHREQmJ1Q1ZQLzM5cnZxdEFUWXVZYUhpNUpmNGdDNEw2cDdHNHNOa2d5?=
 =?utf-8?B?Rk5TSGxiNlY0ZUtCbk0zNFFOODRiWEs0RXQ4ZU1PVWpOL2dNYkQ4a3BUaDdH?=
 =?utf-8?B?eDNMczdvNXo2S1RFM245bVlZVzBFYmxUVXdZVWZkdnErdXRhaU1TWHNOK1pi?=
 =?utf-8?B?UGxCek5GbkZucGR1dGNDZHpudW51Y0Z2Sk05U0g2QXl1bzExbjNydGlGU3Q1?=
 =?utf-8?B?TFJUc0VEUEpIRVRCWHdDVWE3amV1NnBnU2d5dTF6QXNlTE84dEFpVmdBTmxi?=
 =?utf-8?B?U1pPWG1CbUhCdlFQUzJGVVBEZ2FpWGYrRk03a0lwdTRiam5zQ3I5R01GVzBW?=
 =?utf-8?B?VHpWQ3Bjc25CRFFHNkFCdjVNRmxEdmtuUCtqaDcxalNlaWFxZnBiZDRHa0l5?=
 =?utf-8?B?WU9VSWZzSHlDaXFHVENyZ1JZTzRtR0NnblBTWHRFNVFhYlA0ZWFVMi9NM0tI?=
 =?utf-8?B?N29vQm9VRjVHVU53K3E5UW1ORnpOQ1JiNXhDQUpOYSt0OGZha3RRd3ZxSXdI?=
 =?utf-8?B?Y3M3Qk41YVhBNDhpRmRCczJrZG0vcWM1UmRGblZwMmg5UnArQU9YSVNJY0g2?=
 =?utf-8?B?TzZQcFJqYmlzNnd4RXpnNkdjdXY5dXM5RHpNeUpqK2RHVXQwSFFpTGwvUFdj?=
 =?utf-8?B?UDg0OGs1WVB6dkFmK1MvdGNxYnprRnF4OTNhb1gwOXlYQjFmTmlMU290Rlpz?=
 =?utf-8?B?VjI0RTZsRElWMGlUdTJmWHVCNjd0ZG5XLzFtMDlTMkRqaGJVbjcraXRQWXB3?=
 =?utf-8?Q?bDJSR2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkNCdHhxb25tZ2NNa3pVL0VBQmNhVjI0UnpwOXoxSkU4eU1TVktLdnVicmVQ?=
 =?utf-8?B?alJIUm1GN3JiUGJjTEJDbEc3SVNjRTdEaFJFVXFZcWsrK3QreDhLOUtWeGR0?=
 =?utf-8?B?V09vc1BNL3hwYVRZWE5YblBvNWhLU0p1bElLTDIzakpsUTd5NUFPQk9OQTBs?=
 =?utf-8?B?MERla0xhVlZLdTR2T2RZZzFYQXBvbk1qSXFNMi9peVN2V3FxUkZkbzRzeGRq?=
 =?utf-8?B?clVXcVpzaHI5RncyS2x3dGs2Q1hScnBXRG5VWHlvUU9JTElZYjRGWGtPWkpa?=
 =?utf-8?B?eVBDZXc3ckxxN0N5SkhzV0NDbG5nTmV2bGg1NzE5dVdLRDBQRFdnMzRYMnlO?=
 =?utf-8?B?eURCbVgzUi8vdTZuZlV0QnVNeDZhT1dIRDVUelptb3ZSVG43eVFsSXdSanBB?=
 =?utf-8?B?NXhnL2VhSkcwRG5HdGY2SXNiQk54blN5bUVaWDE1SWlyUkUwTzlDalZuZ2ZE?=
 =?utf-8?B?Q2k0TWdBUFcyS3I0VWVzSGF5dTRwcjIrSG5OQzNSZXhYeGJYbFN3UWJvY0t3?=
 =?utf-8?B?UVd2cm5GL2U2cmtnNmNaeUw3bU1IMXZxVkc4eUN4dlhmREwzYXVWaGYyb2Rv?=
 =?utf-8?B?enVvNlRBVkdZUzE5UDkwczdaenl0UHE3M2RsVWpsdllvYnljcWlvQ1lSNFhr?=
 =?utf-8?B?R0M2MGxERzhWMkN0TDNTR2dLTWJkZEpOSDgzZStZQkJjQ0tFR25KWDZNeEFD?=
 =?utf-8?B?bmI1NHVvNEhXRUFKQ3ExR0NWbHRPVVRqMFV5dTJlanltOHQ1NUpqSUZDbm9o?=
 =?utf-8?B?NFFxaGh4SHBSQnkxUk1wbU5hM1dVYUU2V2dVSnlXOXZiMVh6ZFJCSUIzNFBQ?=
 =?utf-8?B?RzBDSXR4SXpLQ3V2QlE3QndwSzlRRnc0c0dhWmJDTktSSnpvSzVFeXIvZE5y?=
 =?utf-8?B?N1FuQ3A4SFFEWVZLZEQrd0JGcTlJZEYzZncvalpVN051RndiTnR1bDJxSTla?=
 =?utf-8?B?WHZaTWV1bGcwY1pmMDF2NTVLNitML2JBY2dOWnErNWVxSWpZQkpRSXdlQ1lL?=
 =?utf-8?B?cmRqZ2wvM2Q4RmE0bHlTaVVDdFFadkw5SVc3enJ6L3FhTFVCNStjSEpWMmc4?=
 =?utf-8?B?S3J5TkFNZ00zMWw5VXFPY3NEdUxGR0o1TEJleXQ2VzFvSkZRV0Yrc05WOE5s?=
 =?utf-8?B?N3B1SWRUWnZUdXNaL2dOS3RJdmNIeGpMeWs1dWV2cjVhQVZsQmFMRmgvYnlX?=
 =?utf-8?B?eHVmOVdQcWVvYWpUZW1jZms2dmMrQVVEZGdWbWgvKzV2NG1wWWloWXdIMWk2?=
 =?utf-8?B?Z2ZkcmhoWjRKUzhpRE4zcEU1bDZXWmRKeThhZGhPc2tGaHR5TEl0VUwrRWFo?=
 =?utf-8?B?dXp5dFlWTEd2cUtDM0JKY3hvZXV1ejhEN0xieFQ5ZmJuMmFuZ0U2bURvTjhW?=
 =?utf-8?B?Y3BSNUhvY1lKUEtoWFZOaWpwM1VDUHp1YlpTdU9hWmdUdGYzdTFiTFc4RzV3?=
 =?utf-8?B?aUROQ0lZS0xkUFZHWG8zeUxYckdBQWczL05MRVNzc1dtUVVEbWNiYVp0cDM0?=
 =?utf-8?B?OTY4ZHZLU1c0OENOd04xaGpXMnREYllidkNEVnp1eHEyR292VG4yRTRZV1ZR?=
 =?utf-8?B?VFhjM0YvZHVlYjJBd2dyVW9ZRlVhVDgzRW8rRzRET2p6cEMrTWFSTDByK1Nj?=
 =?utf-8?B?ZDZOU1FlcUtmbnE1VjFFeFpQenBqcXZ0RGhYNGpWdHJ5RWhBbVV1RDhBQTVH?=
 =?utf-8?B?UFhPKzUxMmxsazBmWXNFL2JmT240ZUtVaDNpT3gwV0xmb0FxMWY3WHhSZWFm?=
 =?utf-8?B?aFp0QUV1eGdhait2bndwVWMrUHhkcFVUZ3VMdTNqZDJLdStLYklkUUdlSHh3?=
 =?utf-8?B?R1d2UWZJWkRRZG9OWFFnakdlYjFlWEZ0Y0hhK21aNXlpb1RtSzdHQUo4SnZL?=
 =?utf-8?B?WkwvMnZDaVRoWk5yV3dKOGZOMko2MkVWOVNBYm9FaWViYTlqZFpKZWIyZmdt?=
 =?utf-8?B?Vk9qamw1UjVkRis5TUFEdGR0Nmp3NlNEKytqOU1pNFB0SEIxV2hIcmsvQkt6?=
 =?utf-8?B?dFJUbmQ5Zkl2RnR5b2p1dVNPcUFMdlpjMWZoVU5kdU1paHkzOVpQQkxZYTZ1?=
 =?utf-8?B?V3hrSmlQSnhsY0ZOaXV1dGFPRUd1eVV2UUtzbXloVGdTZVZFbUY5MHk4My9N?=
 =?utf-8?B?RGRiU09BTFdPQmRiM05kM1pscGtCZk1uTS9RcFZwQmJDTGVzd2VLampvOGVR?=
 =?utf-8?B?bjdXdEZXalpJYmxJWEVCTk80Nm1rVGczbHh1TVNyd0YvVUxDSmNXMnh6bGNQ?=
 =?utf-8?B?Yy9KeHZsYjhqSTJPeEw3b3JsQ1lXQ0p5ZjNOanJQMEZuVFIycUNnSkVRTzF5?=
 =?utf-8?B?cHpEbDNQREhZamhSeHBacDdYbS9oekhLOWQ1ZWdDSCsvNVVnSWlUUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4d877c-51c7-4fba-3a1d-08de5a71fcf0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:24:36.0773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzqfBn0d57VUc9nr8xJpM5WagvTyEGZxJorPnpyU6bSsrsiaCIOKOh3IwHayeXSBeNjtkro67bgKv3YY7thDkxcHsTgZi/409czmz28C7h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7748
X-Mailman-Approved-At: Fri, 23 Jan 2026 13:47:31 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Markus,

On 22/1/2026 1:00 am, Markus Schneider-Pargmann wrote:
> Hi Dinesh,
>
> On Wed Jan 21, 2026 at 5:45 PM CET, Dinesh Maniyam wrote:
> [...]
>>> Previously, we were using glue/wrapper driver to support multiple drivers
>>> with same compatibility.
>>>
>>> For example:
>>>
>>> In this file,
>>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/usb/dwc3/dwc3-generic.c
>>>
>>> look for|dwc3_glue_bind_common, why not use the similar implementation? |Why does/core DM /need to know about USB role selection?
>>>
>>> |lists_bind_fdt()| must remain simple and predictable
> I can see dwc3 seems to use the parent devicetree node to bind the glue
> driver, right?
>
> Upstream am33xx.dtsi does not have a devicetree parent node that we
> could bind to. The parent is of type ti,sysc which is not USB specific.
> The uboot am33xx.dtsi did have a devicetree parent that was USB specific
> and it was used before to bind the USB glue. But with OF_UPSTREAM I
> can't use that anymore.
>
> This is why I developed this patch, to be able let bind() return
> -ENODEV. lists_bind_fdt() will remain predictable. Most drivers do not
> return -ENODEV and will not be influenced by this change.
>
> Best
> Markus
>
> I see your point now: with |CONFIG_OF_UPSTREAM|, the Linux |am33xx.dtsi|
> no longer provides a USB-specific parent node for the dwc3 glue to 
> bind against,
> since the parent is a generic |ti,sysc|.
> Given that, relying on the old U-Boot-specific hierarchy is no longer 
> viable, and
> allowing |bind()| to return |-ENODEV| makes sense to keep the binding 
> behavior predictable.
>
> I also agree with your observation that most drivers do not return 
> |-ENODEV|,
> so the impact of this change should remain limited and well-contained.
>
> Happy to understand the intention behind this new approach — thanks 
> for clarifying.
>
> Acked-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
>
>
