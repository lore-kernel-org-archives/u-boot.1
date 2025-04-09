Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAC8C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 11:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896C282824;
	Wed,  9 Apr 2025 13:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Lo/RITpY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C3A8365E; Wed,  9 Apr 2025 13:21:30 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5DCF8214D
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 13:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY9hP6YBK26Fh+fWAUxd9SYzraXkR2zc2F5K6OSiQXsJM0lq2w/QzPBfDLXzc7546HvgIH4HVlFsGgHkpDNNS9KJxerTmYSQ0BM1UeJw9gw5bkfvNtnRIvjR/+hVBxOH9w/xHlwDkK67FJTJuI6k5xthHhaAAm1lZFwQoG2ihc0BqGZ6EGlGwZV3+0L/aw0/XWLW/x9BECo+J57Sb9J/hzC/7KonmIoGxuI4WKkrxp4/J2RRoJNLKzly3ZeLBosqVD3Wkk3kHPe1iv8p5VONK0Jfx8MTCGzo57a/w+x0gNJOV/FYbH89Oo8e2kcQCDsQ2hHg71r1pM+r92GDpICHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8m7V8Pi6IrFM0Pqy9cpEz40tK1D23CvvNDEWOLplmM=;
 b=yPh8qMUXANXWg8aQKoDFnD8zINGvMKPdnrNfquxvW/4ukiBoh7ghZyvC6dnLK5EfKBtKAHYeboUD+Xq1eMYm1OPN1XlBYqRvGu54dBQUbAYm0qMXWPkY80O8bzl/wnmXqmOFFYumO1k79kXIALIhDUL+IdgHHqKEgF1Z7vHr2PxbToYfufc/T+WXP767TlTdZneraYuAF9APdG+limtdQMpm2iCIu1vqw9pRz3plI+5KvEoSmxbTuAhnFPub3MCWbZXa1Vj4k1J0q8A7zph+bwzGL2QT3rA8/ymOV9CCo5OH1uk5Tpx0WCfzik4Jl1qS+l1Y5HsOq5P0viuWef2AHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8m7V8Pi6IrFM0Pqy9cpEz40tK1D23CvvNDEWOLplmM=;
 b=Lo/RITpYSusfWR9cEj3Iejh6yta82y7M+y4S/jA4tzUCZ19s0SHW7s3pR2EGkoXYsJdTgAZCrr/0QzeNTuKSidrTp2rmwrgMoRqmWURrlpEKU2Fv6vGbTJnws5grpXtg87paNpfrzRxJqMFwJQxnat8rIAzuGmJWONX7IPM6sgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10342.eurprd04.prod.outlook.com (2603:10a6:800:219::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 11:21:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 11:21:25 +0000
Message-ID: <660c6578-4b6d-492d-af89-d4781e0d12de@cherry.de>
Date: Wed, 9 Apr 2025 13:21:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rockchip: avoid rebuilding most binaries for
 u-boot-rockchip-spi.bin
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
 <20250211-has_rom-u-boot-rockchip-spi-bin-v1-3-0d77f95b6239@cherry.de>
 <d46f46fc-4300-4bf1-b547-c1e87e066e67@kwiboo.se>
 <67492a22-0e36-4466-9b34-6b27d30271a3@cherry.de>
 <7dfb0e62-5116-4c40-b98a-c252659c1d78@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7dfb0e62-5116-4c40-b98a-c252659c1d78@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10342:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ee96b5-c28a-4ff4-f038-08dd7758a9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGNpMCtsTWNZRlFZbTJFd1VVWUpaOHlyVUM2WElPWm1BWHdSTld6MjRjd21C?=
 =?utf-8?B?TFF4RlkvdUtVUzkvcVpyY0c3MG5GSVZpL0VLSUIyYld4aEJzOTNOMktDdlhH?=
 =?utf-8?B?SVNsQk9iUmtKUnRiMU1yeGVDVE1HMk5ac21CVmRFRVFEUFBQc1lDYTBSNCsv?=
 =?utf-8?B?Z1BMTHJ0Y0JLMmIzOVFUTFVNaE9pUTNHRW9NalVWWjRZbGhwVUlGQ0VKMnhx?=
 =?utf-8?B?QWNaR2RuM2d2SXhZOE42KzdTa2w5Q1ZzQjFxbC9GaFBBL2JZOVl3aEZtVHVM?=
 =?utf-8?B?bjR4bkRyZjlLeGxkRXJSWTBBZVMzRHV6WUlKZGx6WnRpZnZlRi8rSGlyc01t?=
 =?utf-8?B?alBtcTRGaC9obStsQXdWV0grcEJqcVZXWWwyOFJHdDAzc0wvT3pQR2dOSkl0?=
 =?utf-8?B?eTdpc0NZRUZxdVBVTVlRbjd0VGlIYlM2NkxJeVRKQ2UzbWhwNW8zbUYzWVVh?=
 =?utf-8?B?QzRZV3Q3YnlHejhxbHMxNzNrZTlENVZGd1RrU212Z1Z2R0xtbklmTXk0VTh3?=
 =?utf-8?B?MlZ4aEQ1d2hvNW81VUcxczV0SUxURWpBd2tjTVA2ZzB4VU1tS1NsbVB6QlZT?=
 =?utf-8?B?WjRWUEFRTUVnNkNoR3dNY0lWTTBHaHcrcFgxaCs4SXhIMEVaa2M1TnZJMHF5?=
 =?utf-8?B?MWcwekF3QVR1YXVrS0pEMVEwNVgyVENCSGhHNGZwejRVNXA3V1Q2RHVGWGhk?=
 =?utf-8?B?S0dIazVnaHdpbnRtSDV4Q0NpanZuczJGeG92dEtjNzRwZkV3VzA2VjF0ejh6?=
 =?utf-8?B?cjdLU3BTQmRoYlhNYXkyTlBqcU10K1pFcWUwM1hobTYyR0htRURJS3VlSmRY?=
 =?utf-8?B?YWtLL2wxUU9YcXRnaGdTeUFhMm9ocS9idngyS3Ria2RoSUppUUhvV1lOajZh?=
 =?utf-8?B?VXF1R0xLYlJTQWR3WklxZ1RBREgxSXFTSlEremVwWVpOeVJhNmRyd0kxT0R2?=
 =?utf-8?B?ejdHZWE0STNDSFVxSU5jc1RseWtSeGF4VDA4N0JmQjZ5dnQvb3d5M2gveEFq?=
 =?utf-8?B?Ty9XMUJZb3B1b2kwMUlYZ2w5bHVxYUg0OGg3N2V5TkIrQVRYZnhsZHZ2MUV0?=
 =?utf-8?B?VmZxQ1FjdldrS0pKbXIraUw0RUZKZUswZkROd1RweGV2a0tKTmtobnVaY08x?=
 =?utf-8?B?TlJBOHBOcTl6bGdRNTE0aEI5M1NkbFY3aTlpUWREb0dicm1wSi85dFFja3Z2?=
 =?utf-8?B?YkhaVnBoanlMTE41ZmNMYXl1VXBkb0pKaVdtZ0UrTXpBbG9DeDk0OE5WVUoz?=
 =?utf-8?B?SFArbi9YMkhpSU9LRzliYmpIQzFGaEkzVGJiNzRuakxObVc4TjRPeEdndEtp?=
 =?utf-8?B?VkFZU1k4TjlJWHV6RkRueFkvVGxZK0hGc2R1eGVjOTd3MmFvelAvMmpUVDl6?=
 =?utf-8?B?M0R1QUdkS0VYbFhjczRrZmN0cjMwNHUxYWdWeVlGOGhBTlFYUlNRdmNEN3V6?=
 =?utf-8?B?OVl1bHNhOGVPWk95TFlES2ROdDdPTjBiY1RHTU1CNk9tcm9TdVlYbEdUSVJF?=
 =?utf-8?B?dFVEL3dFVEszUWZVa1BlS0UzY0hkWEptOExQWHBaejRLeEhDTHZUUUozQktG?=
 =?utf-8?B?b09ZRFQ1MTFibFhZYndCRGJmK0l6Ti9KcHpXS2JobUZ2NUZaODlYZ3FxaXRI?=
 =?utf-8?B?MTFSbDlUN0l0N1JYbXdBWWJMZ0lLWFA3TGdRUmM2a3NYNGxxTXE0dWRKMzJL?=
 =?utf-8?B?WlFHNStKTmxFd3RwajFsSisxYWdTbTlRbS9wREtNSUtsUUxBRTlJVGVGMXRB?=
 =?utf-8?B?OFdlTHpWV1ZrUGl2SlBSTitSczYzaXFSei93bWNlbVIrcjVvTzZRREQ1WHIv?=
 =?utf-8?B?Q1ZwUittVmlOYmJqTXZEd01YbWhtaVY3aE5TbnBhR2xmQU01eHhnSUUrM0t2?=
 =?utf-8?Q?oYXeUWQ5hPP9f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJnM1YyVkFGVzU2eVJjWmRkNjhjVVV2MWZKcEpmeVAzcS9DYjRvTXNFZFpi?=
 =?utf-8?B?ei9Wc3h6WFJBcFhYd2puRUU1c2xqSlo0RE0yV1VFaHNzMlk3OWMrejlqVU5z?=
 =?utf-8?B?WmY1VHU0L1d6MTU3VzRGaTA0ZWhadWVJVHdKcC9GVjVHTDU2UCtZWXlqSERO?=
 =?utf-8?B?RlZtZjFhTVlVMCtUbGg0dkp1WVdGeDdqbXB5Q1FDMnArQU8ramhkS0RoTE0x?=
 =?utf-8?B?Q1Y0Z3dPQ2tIUEFBR1VPc1p6MzJlVU5sR0ZDemRVcWkvMjA2cVVoNjByc0pr?=
 =?utf-8?B?bTlvd2E5OWl5R0JhTy92UHdoNkcyZ00zZUhSdkQ3dnhGbngyOVpZNEU4QzlN?=
 =?utf-8?B?Qmp4NXkybjB0MkhkT1pCL2tjUk9UL1Bielg2cFJvK2NTT01UREJObm9ZRnpa?=
 =?utf-8?B?cUdDbTJIVmIzdjhMdEREcHBtbGFCRlNQek0vRTRrOTlIcFMyb0pSMHN2KzVZ?=
 =?utf-8?B?ZWJUZXNUNHB0VS9VOXllc0JMd3l5MnN3SVg4SUd2eklMYWhzUUg4cW9yQ0Zu?=
 =?utf-8?B?aityTW9jMC9yT3I0dTJJSlhGaXZHZDh6YmRFcDJIV0Y4M08xTnlRU0pkRnR6?=
 =?utf-8?B?aDliTWd4QXdJdUc2aUNQMW13RmpGdjIxQlNUVXpNWWFaOUNtS1gvY3BhTkFX?=
 =?utf-8?B?VUxqcnRnRjh6bVJ1dGNJOGtRT3FkaVp6ei9JVnJOT25neVpHaXYybTVlZjNy?=
 =?utf-8?B?Y0g1TDdyRFJZOTVPcXJ1UTRJNVl6UEMwdmVyc0FNV0VGL0tUMmpRcXgrZVJX?=
 =?utf-8?B?NmJiMGZpVDBtOWwyQkNMNVNKYkFYSzNWTjJObG9Ob2FLeVNYanhiUEFuK0Jn?=
 =?utf-8?B?V3pYY2h6bmtaOE9wQVJRdWFFbnpVTW84NGtzVHpLejBBMlZpTUVxRXVXUERZ?=
 =?utf-8?B?bTFXamhHb0sxLzFYSGlLbVVpaWNZS0o0VFk4N0Z6SnFnWUFwMmF0aVlIUnkw?=
 =?utf-8?B?SWhyZ1RKMDlBRGRFVDRmVkNqclM5aXVyUDd4OVU4YzZRcVJXNHdrMFdYdHh2?=
 =?utf-8?B?b2czaHNRc0N1ZDBMbzZMTm4raHNqVVBob1I2K01QUGdMR0dBNlBvY2lHTnp0?=
 =?utf-8?B?T2IyblFhZWI2WVY5TitXMTdmRWRzYXN4OU0wVzIzQ0JKR0lEVjlEZmRtdWRh?=
 =?utf-8?B?dU1NelE2VUJ4U2lseGlCVUZzbnZQNjhJcFUyZjJoZlRSSGVXNXBQSmI3c0NP?=
 =?utf-8?B?T3JsRTdYVmptMVVkaDVlYmRib1RRUEtrclQxd0o0dk5HbEIyTWVyNnhzN3Vr?=
 =?utf-8?B?SVRqN3gyaFZDS1phNzdlaVpDK21NS2MrNG9pNXAzc1RHWEdycTBMSWpzaWJ1?=
 =?utf-8?B?RVdNaEdPY0RiZU9iYmZaeFRxaUVVV29RUzQ1azdlTE1sQUsyMWNXZzR0WWdW?=
 =?utf-8?B?RUYrZzF2YUxXWkdpbG1WTXNMa2k0WHVwd3F0U0VQWTN2ZlRNWWFsaTdlMWtB?=
 =?utf-8?B?UFFCM2JvMG1mZG5CbUVhSzFVMnNHY0VrZXh3ckZEMmZmdUk0N0hEVlNWdWR5?=
 =?utf-8?B?cWkrdm5QRzVaWE4xdG1aUHZsa25SQjN5N3FHd0NKTHNtNUJmZ3hMYWVKMmVo?=
 =?utf-8?B?WDR6V2NWM0VpcjF1YW9nbTRzSTA2cWd5bFFMNlppNFZnd3lLV28xSGV0UnpH?=
 =?utf-8?B?YjVnRmNmY0Z6VDlkT0ltRVBJbmNnSk1GQnJ0amFwZjc3dU0zMG5KZnZkNnc4?=
 =?utf-8?B?cHg0cmZORDZpck5lYjJyRCtGSkdVZUkvL3ZtMmpCcTJ4ZDV5cFRyK2J0anZk?=
 =?utf-8?B?eGI1V2I2MW9ZUGorVDRXcVdEcloxb0VEVmtUd0JGRUQyZFNLdzRNclFKbTho?=
 =?utf-8?B?Z3ZiMTlPcDBVM1d1K0Fsc1BaczFYbXY0SE1wWFNDZEFSSGdXZy9VRVluS1lv?=
 =?utf-8?B?cmRXeGpzMC9abnRSZGhHaWpyTG81dTVBSmpvNHVkMTgxdHRNN2NSWWxsNWxF?=
 =?utf-8?B?VmY3dGRER1ZXMWRaSFlGWW1UUjZXWVVnanZya09SOW9MY3VVVnczTG43NUxq?=
 =?utf-8?B?OW1CQkxuT2JyeDdUUkFVMXpQQXlsM3dUQXU5eEVHc09EMFFFb2Y3eGMxU1BO?=
 =?utf-8?B?RzVWWEVBbTZvalFKcWVGNWphRlo3clM4R2hPY1ZsUmRQUVJLMGlOV1pCbStV?=
 =?utf-8?B?cnJ6NVdiWXdVOUdJcHY0elp0UWZTSGFERTRZa1djNVNpblNyamtWOWNjTlVr?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ee96b5-c28a-4ff4-f038-08dd7758a9fa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 11:21:25.0236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z65d/tjxLvKoBSOO3rdu0V5DnswcRe7k+JUmF+rH3fYOugHSGD+CRpLZxoCNGFk8QIGY/UqeaPBjf8bd9Pxc2OGDzHfajVCwfuul/8s2c94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10342
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

Hi Jonas,

On 4/8/25 7:48 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2025-02-11 12:43, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 2/11/25 12:35 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 2025-02-11 11:29, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> Essentially the only differences between u-boot-rockchip.bin and
>>>> u-boot-rockchip-spi.bin are the formatting of idbloader.img which is
>>>> handled by mkimage (via -T rkspi/rksd) and the offset at which U-Boot
>>>> proper is flashed, the content of the binaries are identical otherwise.
>>>>
>>>> This fixes some issues[1] where binman tries to find the symbols defined
>>>> in the proper binary to install them in an xPL binary. However, because
>>>> we use the binary for proper (on Aarch64) generated in simple-bin image
>>>> node and not simple-bin-spi image node, binman doesn't have access to
>>>> that symbol anymore. Therefore, let's depend entirely on binaries built
>>>> by simple-bin in simple-bin-spi so those issues do not arise anymore as
>>>> nothing is compiled essentially, just assembled.
>>>>
>>>> [1] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>>    arch/arm/dts/rockchip-u-boot.dtsi | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>>>> index c8c928c7e5089db3a2239f2564e6dee1d82aad95..2e8a3bd09e49ed73a8cea3fadfb6d2b592082365 100644
>>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>>>> @@ -187,18 +187,28 @@
>>>>    			};
>>>>    #elif defined(CONFIG_TPL)
>>>>    			u-boot-tpl {
>>>> +				type = "blob";
>>>> +				/* sync with /binman/simple-bin/mkimage/u-boot-tpl */
>>>> +				filename = "tpl/u-boot-tpl.bin";
>>>>    			};
>>>>    #endif
>>>>    			u-boot-spl {
>>>> +				type = "blob";
>>>> +				/* sync with /binman/simple-bin/mkimage/u-boot-spl */
>>>> +				filename = "spl/u-boot-spl.bin";
>>>>    			};
>>>>    		};
>>>>    
>>>>    #if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
>>>>    		fit {
>>>>    			type = "blob";
>>>> +			/* sync with /binman/simple-bin/fit */
>>>>    			filename = "u-boot.itb";
>>>>    #else
>>>>    		u-boot-img {
>>>> +			type = "blob";
>>>> +			/* sync with /binman/simple-bin/u-boot-img */
>>>> +			filename = "u-boot.img";
>>>>    #endif
>>>>    			/* Sync with u-boot,spl-payload-offset if present */
>>>>    			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
>>>>
>>>
>>> I think changing to using a template may suit binman better, however it
>>> will be at the expense of having to re-generate the FIT, not sure what
>>> option is best.
>>>
>>
>> Unnecessarily rebuilding images is not great for build times :) If I'm
>> not mistaken, binman still compiles sequentially so doubly not great.
>>
>> At the same time, this is relying on undefined behavior (according to
>> binman spec; i.e. using a binary from another image node) but we've been
>> doing this for a few years now and it seems to be doing ok so far?
>>
>>> It would be great if Simon can split out the rockchip-u-boot.dtsi
>>> improvement commits in a separate series as I suggested in [2].
>>>
>>
>> That's fine but we need something soon, this is already preventing
>> people from contributing stuff for their boards. I don't mind either
>> (haven't checked the template stuff so far though), just no need to wait
>> too long for the perfect implementation. Also this can be merged as an
>> intermediary fix and templating done afterwards.
> 
> The fit-template patch (and others) was extracted and are included in
> the "rockchip: binman: Use a template for FIT and other improvements" v4
> series, see [3].
> 
> I suggest we skip this last patch in this series, and instead apply the
> change to use a template from that series. If not, a v5 of that series
> would just end up revering the changes made in this patch any way.
> 
> The added time for building two (or three with ram boot) times seem to
> be negligible on my build machine.
> 

Yes but then there's no guarantee it's the same binary that is part of 
the eMMC or the SPI image since they are built separately.

It wouldn't be a revert but a rebase for the migration to the fit 
template which absorbs the changes made in that patch. I personally 
don't care.

Note that patches 1 and 2 should be merged anyway, they aren't impacted 
by that decision.

Cheers,
Quentin
