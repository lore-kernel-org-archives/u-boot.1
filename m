Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CA6C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 11:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4634380285;
	Tue, 14 Jan 2025 12:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lzepDrAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A758060C; Tue, 14 Jan 2025 12:16:43 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54AE28007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 12:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffTSU319D0Vy7Z+yayHNJ1MKIeJw+eyEG7kVw9r6ldRSFeIUf4Y9Itb9cMSyrA4u5oo/c+uTVxHjCZBrenELmmBt40i6mKmfEBAi9+8auSmDfQKRfyr3kUI+oscnT4CbaS+w++WvR6qHnTk9TbuUPxx7o4Hk2Z6THMmBOcnmj4+bTKBvI9ZYoiOGpIWMPfOx6TLOGRQahSy0G7JqmDhXsBAAHJGqf7BVVA6L8xF0J4a+TsDTxmtOnY82H4PANHhOSXEJ7pa7rkNiC9Muhibb3ufjUcgnqEDVpSHlRfnRPxwTCm3/knWjRYlNPtR50711Jt4dDTasj2Uy1idFEhIv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeFv8Xl0noRjsWUKD2o7uIO/Rem1KOViPmv/pxOlAM4=;
 b=jlRnrwhATDSxpdgRFRwPgIV8sRzyDzvRrzzoBqrFo8dNzsbUtFfRsclMC6+2XFrzZshhm1vaL/IILTd5ebtt2/49RUQA/E2SGLe6FGcMuJjg0yN5qeqze6tN3DKXmwSgWZhluJPhuzC74nMN2splb1cg1vAwQ49X+cNGOdtzBO+OacJX4oaYvfjj6zPe6xBkWxMQlqvwInVFfWj8M+wrCpDQmNEbb3ETEaO1CzMbKFSQ8MFKXRY5jhopXZNBjeFFUWiLJvM9hUFcVPLrwchL5Qb4sGXBx7MqgJDqc1Tix98N0IFsZ93iZKE9x6T3KhqNY+QssfMQLbQonTOc7WxCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeFv8Xl0noRjsWUKD2o7uIO/Rem1KOViPmv/pxOlAM4=;
 b=lzepDrAW2+ydtBik2DoN/rIT0/bycsVqZ828ClcL4PIXDYImSjccH4PlvcoB8WjgIcgB+0DU1tYwhLywfdM2X+qWa+n381xQHbY4c5FBU0LsT0wtfreFAO8fI3arG+VcfXIa6puU7E31A1EonEAgBqMn70gHYgQqKNDZOQ5dZiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8005.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 11:16:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 11:16:36 +0000
Message-ID: <2d821f40-b52a-44f0-8dc1-5d9ec2992993@cherry.de>
Date: Tue, 14 Jan 2025 12:16:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] common: fdt: hand over original fdt bootargs into
 board chosen handler
To: Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com
References: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
 <20241220-board_fdt_chosen_bootargs_improvements-v1-3-f6a7181787c5@salutedevices.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241220-board_fdt_chosen_bootargs_improvements-v1-3-f6a7181787c5@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 57672a21-3984-4caa-40dc-08dd348ce8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWo5dythUWhhR1I5VmtxbjlsNHF0RzB1Q3dSTndMaUxZdmZ0NjBNa3lEWER0?=
 =?utf-8?B?dHNBMnVxSDdqcTYvQnlFQmFZVWxua2UyNk82WlB0SHloQWltMzVHVHNnVHV1?=
 =?utf-8?B?QUN5WXRNNjVRRFdMY0s5Vzg3U01aTnFUR1g5ZkRXRXNLUkJzZHBCS25ETGh1?=
 =?utf-8?B?ZnZVb1FKTERTL2wrVUxVRU4zd3F6RTdFWUZVUjY0eHdhZ1kyVDJnNnpiYml0?=
 =?utf-8?B?REpnMThEV1kweUNTZWN3dnNnZXRDbG1aOFRDOTY0YUwwMVlUSUZKUE4wZW9i?=
 =?utf-8?B?K0hxMStyOGk5MkR0cXZhei93QWx4czlFS29hZUQrRjRDMDBIb0xxcWM0Z3lC?=
 =?utf-8?B?SXNWcjVEQ3NlTVZmZGd0TUY0ald1aGtmaXZtTmp1TVF4SmNqbWtwTThqcTRH?=
 =?utf-8?B?UjRCcEZPeSt6OG40cGd2ZkZiR1NxZnhyNGZyN3hONnhoRVJNS3pEdDR6V2Qw?=
 =?utf-8?B?V2ZXcHJHbEpUZnM5QUdURkh3QnRyK0d3SFVwazZsaHpPUlRxOFU4K3RSdEZT?=
 =?utf-8?B?TlNlMFlXV01RMHdiMVVsMW5jMk5SUlFHaFNFMWU1U0xweVVxM29HMHA5b0V4?=
 =?utf-8?B?M25Zd0lBNGc1MkhQSHNVZ0E2czlsa28wc3hDazVzNnRqODNlRHlwTXpiWG5R?=
 =?utf-8?B?QXVsZ1EwaGI2NzVIRWh6NWNnVXlWZ1djS0xYZy9VNEJNRDJzelpQNkxJTzlR?=
 =?utf-8?B?c3pGWFR0SnF5SjZwSktjMzRpVVI1M2pHa0xZcHExZXRYcWdNUVhpMC9PcDhT?=
 =?utf-8?B?bnJKTURmWnA2UlgrQ1N6emdyWTlPR3ZaTG1qZFZmUTdCRWExMmNiK3dGTHFT?=
 =?utf-8?B?WDlkVWovS25oNVJ4a2FYUzRGdXY5WFZZM3Y0WDJlOHRUdEVmUVN0emZqdXF0?=
 =?utf-8?B?Q1dRUi9Jd2N5YkdLVFg2Nm4rUlhTbnVyeXZXV3cydzJKRSsvTzZhRG1rSk5n?=
 =?utf-8?B?bWF2SnRPNHpPemdhU3pNUHFNVEswMkhPd3RGV1hzTC9tcGl2clRuYkVaR3lE?=
 =?utf-8?B?Qm1Vb1g3NFIvVkgxYUtVMCtRMVlmNU9HckRTQ3dYY29DeDEydzE3MnVza1l3?=
 =?utf-8?B?N0ZaRWlOMGhyZERJamQyRXNrdTYxMnV2YmtoaDRoQ2QvWlJXb282SFJFcmkx?=
 =?utf-8?B?WElSTDFReHhTVkx2NHV0VW4xdGRSUFpQdFpBSWxXOTZkWENzOHlGS1ZFcHp5?=
 =?utf-8?B?MkYxVk04TWlOV213UHQ5N0J5cnFmdWVqUExnOVlZdGFhaHNvT2xGZnIrZjlB?=
 =?utf-8?B?enAvbXhjVEZnd1R3dVQzanNnZGZwYkExOTlpOHhaVWdmb0o3bkJDM0w4N3Vx?=
 =?utf-8?B?NUdvNnFuM05OVGs4emI2SDRWTzJUWGJSaXhrbEZHYnFjcDYvejlUencrRVJr?=
 =?utf-8?B?MDVwOGVUSjFacm96TmUyNGM1L3NTM3JqUUtiMnpvWnFUQjArdjZjemVaekVW?=
 =?utf-8?B?UmdRb1YwRzh1M3NLcGZmOEc1M2ZWZ24vbzJ2OThqZ2FkMHFrVG1YcWtnamRt?=
 =?utf-8?B?cy9ZanRVUHhoSVV3OWhwYytRMkMzNWc0TDloazdDWFlwaFZReGJmYTR1NVJ4?=
 =?utf-8?B?SURIZ2Z6MTVEalBrN3Y0bi92Y0ZwV00zdlRTcGlCbG1wUEZWRis4N1hrZUdh?=
 =?utf-8?B?NlFqVGhBQVB4RXhpTW5ldmp0TTc0UW5QZkZWNzZGeG5GTXUwWVJQWHlYUjBT?=
 =?utf-8?B?RDlPQ092bWFtZFpJaHo5dWxsRVNVWS93OWRpeGpzcnVENjFrRFlKaDlnQitz?=
 =?utf-8?B?aDhWdjkyaUxPWHd4a0xpcXBNa1ZLWjVZTDhISFMvdk1MclR0NkgwSXdmajBV?=
 =?utf-8?B?ZEZXb2JnTFdKZ0VnUmZMVlVQTU42VU5jSFQ2QVpCazVXUXEreDR6MjRNNUR3?=
 =?utf-8?Q?P0u5nviHyjA7H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRVOEZldE9JZmlBTE1EalpjQU9OUkd3VnVENW5XbFFBMkl5UmJkTVJ0OW94?=
 =?utf-8?B?T043Z0pEVituV1FycWtnTHVpM0VBTU9pSGNXRWRBbDlpeFZjQ3NSM052R1pX?=
 =?utf-8?B?SFBGSFdzM0dXUE1XOWptaCtkcnIybnQ2QkhjdHJUWmZ1Znd6R3J5MjBVZ2tz?=
 =?utf-8?B?ckNmd0lPT0JMUCtaaFJvS1l0aTY0OUl4MldoaGhyWWlOamtqM0ZvdE5pZkxm?=
 =?utf-8?B?NVdoVTRNQkJaeDNrRDBOMDU0dGpDa1FKMzE4K2FrUllUUFR6NjFpTmFPbGRV?=
 =?utf-8?B?K2s2UGdHbFZQY1dxTWtKZ1J3KzZPUld0Q2MwY1FWdnNOMFhGSEdJc3hISnlq?=
 =?utf-8?B?YjFVTFEra015bnBJWmdIOGVPZHFIWkdVT2hxcmRDcXA1ZjhTWEF2WU5Ba3JZ?=
 =?utf-8?B?ck1tNmFkMlV5WmRMVDFyOWRVNzVtK1hjbEVKUVBwY3hvc2FlWHpXczBsR1dv?=
 =?utf-8?B?bW5GTGIxQnZLNHRzd1RjREZnNS9CNkVZMWZvQ2E0RFJPUGpoV042Mm0vRWJ6?=
 =?utf-8?B?Z0RLbFJtbnU5OHoybm1mbGNCOHpRY01uNzltYkRtYXB0ZXhZelV4dkkvTzRj?=
 =?utf-8?B?Sk9nRjl1MWFCV21hWWs2WUU0SzJnWUk0bGp6ZDllcUNlMnBmRk1FZWlSRDJj?=
 =?utf-8?B?SVJKUCtYdXI4N09GMTNILzVLUktiMU9PTm1UTFlLTURBaW9yNC95S3RZTjVV?=
 =?utf-8?B?bUtOYVpnVnQ2YTBpdTcxS2Q2NVl4eXFUN3ZDM2hOWW1GaFhOSUtTaEdIZUZU?=
 =?utf-8?B?SUI4SlRtOG9UdWNtbTcrMm9WL2JvSzZJaTZSazk3UWRwNHFmT0E4K01EazlV?=
 =?utf-8?B?Y2l6aHp6R2JoRTdlT3lidnBCUEhiQ0FSUXpxMUJPeVRiSVAyRGV6d1l1dkFP?=
 =?utf-8?B?ZDhwV2duN3ZQVnlua2ZjQmRRdHZSVHpYcmZpL0hmVms0R0NuSXhWV1c4bnlI?=
 =?utf-8?B?QXFvNWdwOEJiaFRqYnUrVDdlZ1QzK1AzSzBNQ080OUNObkc4Z2lVamx6YitZ?=
 =?utf-8?B?UTd2Nm9FWEdUQ281eXBwMml4M1IyZjVhQ0E2R3lKU2NEa1o3V2QvLzF3Yzk4?=
 =?utf-8?B?dW5vMzZIaW9MS2NEdG1FN0NRY0phai9aRXYvQnJBczZtM0RaT3g4NVQ0aWla?=
 =?utf-8?B?aENaUFdUV0luc1pBd2tTV1ZiMzBYNklWQXZSUW5JSEJyUnVGM1pQSnJmRkp3?=
 =?utf-8?B?cmFNbFJ2VTg5WHM5TFdPY3cxaUY3cUFXa2Z4eDRidExDanI3OHpYVzAzK3pT?=
 =?utf-8?B?dXd0TC9nc1B4d3JzWGJ5K0E3a0Q3cG4yQkhmWTdES3hCdXRkbUliMlVJdlJR?=
 =?utf-8?B?MUxFMEJpa1ZjTUIwNXFyTkp5ckpMMGF2cDUzNy93aVhWcG96M29JSmFub2FZ?=
 =?utf-8?B?NDd4KzJWOUhSZG1tazc0dWE0UGhKNkVmQ3dMdEtQT3FRUjJLQXJBcXFRcWp0?=
 =?utf-8?B?UVFuZS83N1RMcnArMGl5bWovNThmQ2NSRGVHU3J0MmxQQlltWi9xL25FVVRU?=
 =?utf-8?B?SHYxV3VoTXpUMG1ES0VGY1FRZVlKa2RkK0JiVisxQ1o2K1FUa3c0cXpjOVRU?=
 =?utf-8?B?bldOci9YOEhOUkMxY3pldzhwQUVXVklVSS9kUHk3bTliTFY2WWNnSkhCZ3R3?=
 =?utf-8?B?cVN0SVdXK0tEcUxxcmhhbVhYbjA2YnpCb0QycU9aTHNYVkpLck9rcVg4alBv?=
 =?utf-8?B?TWJ2c05LU2wrR1VsQVM5ZWUvd0ZVRGlXY0FqLzRYM2tmdTFxS3ByNjF6QWxZ?=
 =?utf-8?B?eGllc1pOdEFGWFVCeC9VKzh3RXpiTFc4SjhCcGdTdWpmNXVwL3FxMzJWZmxz?=
 =?utf-8?B?SUd0ZmdzQ0laMmNQSU5sMWwvVkZSZFNJT1VONFd0V0wwWmF5K1dXS3BTMTZJ?=
 =?utf-8?B?NFFBaVdEWnZFK1pxRkhYVUkybTVZTFp2ZS8xL2EybERIdjdKTEtWbFRtTGh0?=
 =?utf-8?B?d0FaWlZ2TmlXcWwxUkoxdXFraFZqNk5FbUZtNTN1YmtROEhWQ0Vub1M1RFFO?=
 =?utf-8?B?YUJsQkMydjRvaUpCQ0lGQTVERldqVVRXMHFuWE9qZDVwaExOd0tURmFqYnk2?=
 =?utf-8?B?MURhWkJVSGpoNFZXb1FmNXh2VzZRcGZFQWxQaFcvaDRPelVBOWVNS3FLSnRR?=
 =?utf-8?B?c0hBR2RneWRrL2tHV0tBWnc2RmVQQklhZThzRW9ycmg0cHgrRVRORUNrNVRS?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 57672a21-3984-4caa-40dc-08dd348ce8ef
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 11:16:36.6332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyTlpDqnhQX9qJbtom8WTUsxE+pKqTB0FwyAcJHnmPRCu04NecYDAY5QCYwctnp2HdUZBgChWVQ0MEZflhRtRhIAgRebxqGv6B8Q7znKPOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8005
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

Hi Dmitry,

On 12/19/24 10:42 PM, Dmitry Rokosov wrote:
> Sometimes, it is necessary to provide an additional bootargs string to
> the kernel command line.
> 
> We have a real scenario where one U-Boot blob needs to boot several
> kernel images: the vendor-patched kernel image and the latest upstream
> kernel image. The Amlogic (Meson architecture) tty driver has different
> tty suffixes in these kernels: the vendor uses 'ttySx', while the
> upstream implementation uses 'ttyAMLx'. The initial console setup is
> provided to the kernel using the kernel command line (bootargs). For the
> vendor kernel, we should use 'console=ttyS0,115200', while for the
> upstream kernel, it must be 'console=ttyAML0,115200'. This means we have
> to use different command line strings depending on the kernel version.
> 

Can't you have both in bootargs to handle both versions of the kernel 
with the same bootargs?

> To resolve this issue, we cannot use the CMDLINE_EXTEND kernel
> configuration because it is considered legacy and is not supported for
> the arm64 architecture. CMDLINE_EXTEND is outdated primarily because we
> can provide additional command line strings through the
> 'chosen/bootargs' FDT node. However, U-Boot uses this node to inject the
> U-Boot bootargs environment variable content, which results in U-Boot
> silently overriding all data in the 'chosen/bootargs' node. While we do
> have the board_fdt_chosen_bootargs() board hook to address such issues,
> this function lacks any FDT context, such as the original value of the
> 'chosen/bootargs' node.
> 
> This patch introduces a read-only (RO) fdt_property argument to
> board_fdt_chosen_bootargs() to share the original 'chosen/bootargs' data
> with the board code. Consequently, the board developer can decide how to
> handle this information for their board setup: whether to drop it or
> merge it with the bootargs environment.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>   boot/fdt_support.c    | 5 +++--
>   include/fdt_support.h | 4 +++-
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 2c39b2dd14b7c447bc4c7c8fad64e22cb00e88e0..49efeec3681f7c97341ccdce596bcaa4e1f037eb 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -321,7 +321,7 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
>    * board_fdt_chosen_bootargs - boards may override this function to use
>    *                             alternative kernel command line arguments
>    */
> -__weak const char *board_fdt_chosen_bootargs(void)
> +__weak const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba)
>   {
>   	return env_get("bootargs");
>   }
> @@ -364,7 +364,8 @@ int fdt_chosen(void *fdt)
>   		}
>   	}
>   
> -	str = board_fdt_chosen_bootargs();
> +	str = board_fdt_chosen_bootargs(fdt_get_property(fdt, nodeoffset,
> +							 "bootargs", NULL));
>   
>   	if (str) {
>   		err = fdt_setprop(fdt, nodeoffset, "bootargs", str,
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index f481881ce640797e0f6204d599f008d0e5dc2bf7..7731feba5f068f82c8ee25f18a9f0e57729e2bd8 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -231,12 +231,14 @@ int board_rng_seed(struct abuf *buf);
>   /**
>    * board_fdt_chosen_bootargs() - arbitrarily amend fdt kernel command line
>    *
> + * @fdt_ba: FDT chosen/bootargs from the kernel image if available
> + *

Missing leading /

/chosen/bootargs

+property
to highlight what this path refers to.

Makes sense to me otherwise!

With those changes,
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
