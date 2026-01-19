Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702F1D2ECF6
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 23:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C34B0839D5;
	Tue, 20 Jan 2026 00:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ZF2mn0fk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 393C1839DF; Tue, 20 Jan 2026 00:30:46 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB83E82A9E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 00:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWCgmf5KLhEGF5E7WLhS4lq8d8tMnien5eNn9t5ZROBBirTpYk88Zqxu+frNz3ZRIlDI6EX0C/W26qV9xOIu8Sj5rOHBRHnOBUGr4O0XhU1K1TiXSQ0cG/xvbvpkwUaBLApHJL5gsUoU+LPN5eJ1I/T4/vUuNUG6i0zGFl6M8MEmIGpcZiVC8uyOQe1XnXQ1nIsOBO0OiQR33YYZ+dly2oJiGl5c/SWgDJob/yalzbl+aoreG6WXGyrsb/unNBe/7ZAxxltAmWGxSaETWbvu5dc9P5ouDDWz+HIPErjlxnCFYMSlY4qx4Wme3+ya4xnZx1zqX6IJMApfojgFayYJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7OfdamM1hZZKd1H9/8SYaxudUb+jvXUWXQrGxAX2w4=;
 b=Gvl99itGeCVStRbjt06BIhDdHug6EWXhYdaMkVDeamnBVWbXRjtOJ4KNH4l1gz0TPqZ+xJEjoFpHUA3psb3SA4sTKJ9f9OqWcU5sIFaeYBnupS8NRQLnJGmAZ2TJWfoaskGpp3j1UY3OHnjZNmvnwvr4KgctcLC26EKT84/mvvlFiY/K6+ycYW6swaWakAd7tI/9Y/AYxK3RJBicSE0Nyd/QayYVDziVC8FgticVI2xnVa7KBLkrJFTllgDh0sjKZpUn5ESNji/Ogpr9GBXbpKMF9OGzfQyA1aAk4uXoy6zqyAKFb3QnWFNS9MLbgeTqk6OwdxEsVnouGZI+FoerKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7OfdamM1hZZKd1H9/8SYaxudUb+jvXUWXQrGxAX2w4=;
 b=ZF2mn0fkAFYkpPmDRVMH11pEIuDv8kquiB2LNF/YCTU0lp4c+M1KK0QA+YBDIZzZGNwdsQpfYa0V8+Vb9De01vVOe1fJkqJYqQPyhBGkGzNg37aQHDmIUQ+x7AJ9jT42rDIxFp+Wo9D9LW+H6zD7y5rOAakwK42KoP2OH98m1ljI8bC01evmB/WILyQ4KQavkk8Eo1xvFf21x+b1MrCZjZwOCfyTAYwAkLS+CjU03tatV0OkvnzFjwndRKXdAW1phQGOeD0JW/hQHRPlPoquDqMq89VnVC1Tqb1FMBAkVj8Q5SjAVYcrJiFtWTgiGdux7MDwMghiu3wxQGp8LzPh/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PA1PR08MB11624.eurprd08.prod.outlook.com (2603:10a6:102:558::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 23:30:38 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 23:30:38 +0000
Message-ID: <5bd2f04e-c528-4c96-aafa-3e04082909f7@iopsys.eu>
Date: Tue, 20 Jan 2026 02:30:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] disk: part: fix partition search boundaries
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Mike Looijmans
 <mike.looijmans@topic.nl>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
References: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
 <20260119223305.3022690-2-mikhail.kshevetskiy@iopsys.eu>
 <CAOf5uwkb+bsXsdt9Wn7a2fJRHXX5mOkMGZxifSTY568rwnq8KA@mail.gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <CAOf5uwkb+bsXsdt9Wn7a2fJRHXX5mOkMGZxifSTY568rwnq8KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0017.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::12) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PA1PR08MB11624:EE_
X-MS-Office365-Filtering-Correlation-Id: a042099b-442e-4a95-d7b7-08de57b2c0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjhXNzhYdW5wL1N5RmJrbnRPL2FuR2lwYU5JOFgvdEZ2R1BCbS9PL1RuMC85?=
 =?utf-8?B?QzcwQjBVTHREdk5scytTcWtzTzF2VXRNQmc1aHNQRGJzb1NMcUJYVjZ0MTVs?=
 =?utf-8?B?d3oydWFOYit0S0lJTFpEWEx0TTVBUVczNGN0VXNaeUNJRS82dVFUSkE3aHpJ?=
 =?utf-8?B?cHYzQlNYYy9pWnc2UmF4UHB3ZCtYaUNyaThpN0d4NTJDNFBVYUlVRnRXb2k1?=
 =?utf-8?B?bFJUWGR1bHdCVGpyc2hSeWNTVE84MnJnQzgyK0ZseDVrbHVqZ21UdElHMGRm?=
 =?utf-8?B?SHh3MUZMbWZFeUs1aHFKS0N0cjZLRlQ4WHhvbGVlNDlydTl4bnYyYzZtTXh2?=
 =?utf-8?B?NGNJcmZ5RUtOMnlzNUx0OE04YldDL1ZNUUU5eXV1K1FxSWlxWXZzTHhXRytS?=
 =?utf-8?B?aUJ6b29JQjBFM0tsRlZQSlgyaUtnRmhDb1MvU3NRWnlRTFVDaTMwT0JYSzZG?=
 =?utf-8?B?d2JDOUtwVDlJaVlUbzB6dWVjZFpxRDZVbnVXODNSWUdYa2ZxMEErRTJ6b3F1?=
 =?utf-8?B?Z3NIRitHcHZYNzFlblRwVlFrNS93S212d2VRUzVybnlOYW0rNUIxbkpRZHJO?=
 =?utf-8?B?T1JRd0F0cUhQSFBzTzgvWFZSMmhsTC9kTXB4U2dFQy9CcWVoWmN3THU4aHRr?=
 =?utf-8?B?Ry96aXhhZ2FxMEdpaEliYUpBS3ZSVmhjWGRMaFI0RjlpZGtocWpxT2N2RVNp?=
 =?utf-8?B?MmZxelIzUDhXc0xoTGhyZEljOUlQdXJTTmFta2MzZ0FyMElIaVBWMzZZeURw?=
 =?utf-8?B?UkFKMExTT0N0UEFGOWErZjJXanpiNkVlZTlQL25xSncyZ29FQ0ZEbUZSZ09J?=
 =?utf-8?B?STlNRWZxOUluWVl3cUd4V1lGSGEvd08wd283ajVBYkpQWWFsQUJsby9pd1ZV?=
 =?utf-8?B?VERGZXhmK24yTVdQcDA5c2dCcDdoZk5yb1dLVTJab3BDSGpnckpsa1huS2Q1?=
 =?utf-8?B?czd6RDhFSDZUY01NUUptcWE1clZTNkdFb2pwVlFyUE1KVnZneFpYT1AwOFFU?=
 =?utf-8?B?SDhtSDZYVStYUXdESWlLQTRUeEoyeEhYaUtxWXZKUWxkZG5LaHp4QlRmRlRJ?=
 =?utf-8?B?NjVlRXk4VkROaEJhSElhYkU0NGc2cCtvZTdOYS9NTUZKbkRhT0ZvZFNrZmJR?=
 =?utf-8?B?N1hMb1MxT3YyZWRFT0ljRkpHcFQxZk02cWt0alVjbHMwK3JwUEorcW5xdmlw?=
 =?utf-8?B?QW5BMkFObjZSTnhXclVwM2lOTkt1SWdUNHJBQWoxS3d0UEVGOCsvaE5jbUhS?=
 =?utf-8?B?NzNTSTdmUGwvNllFUXFVeTJVNFNDclZqbTdVQWVlNFVvUUFwS1AzeW1DbGh4?=
 =?utf-8?B?YklJcVF5QzFOSWd6WmE1TXZ6UzE4UEdzR25WUU9UdWttbVNncUVHM2lkNi90?=
 =?utf-8?B?dUF6TUtkeXY0U3VHZi9jWXR0VURacE5hRVlwREFaRkZtckJKUWVYdDRPUlpp?=
 =?utf-8?B?WXZuZEEyRm1iZHpBa2pnZG1DVDR4YTJhdzJWV3l2eC9aeXlkSUlwMUFaZFVX?=
 =?utf-8?B?QmFVRkc4OWx4UzU1YWtTZ2pmYzdTQUhXN3hNMldWSnVNZWhvWm1SQ2J1NUdU?=
 =?utf-8?B?bEJMNCtMcHlNbEtXZXg0TnNxeUpQeXAxVC9BR2tKcHhZUno1Y3pDVVdCUG5R?=
 =?utf-8?B?UlRpSmFoUVZKeHBzOG9QVXZBOUZBYlFjYU9rRTB4TTJ6MG40TnFlTVNla1lE?=
 =?utf-8?B?VmQvNkxtTjRSblR1enBDS0RsVkk4RTQrR29rZkh5U3lVMTNTOVA0M0ladU5s?=
 =?utf-8?B?N25UTWxZenA0RDVVUnFEWWQybm9aNjNjQUVTVnQrZXdBVUZ0K1RrYzZwc2Y3?=
 =?utf-8?B?bXVGMDM3Snl6dWh3djhKVWREK1FmeW8wMTlnTzdtL25McXdYK1Q4Ri9iVzVv?=
 =?utf-8?B?VHBGTWx4WjV4cVBNT3Q4Kyt1VDBmUnM0NHBoVWtCY0x5TC9YU051aXluNjc5?=
 =?utf-8?B?Q3V6Y2lEaFAzVE5ubGZsaGlOWHFxa2dxZVlDZ1FuMXdKbnEvQXBCSmMrMWs5?=
 =?utf-8?B?N28rSGduUjY2aGpORmJlQWJwNFQ2NlpWTHJzNWJPN2k4MlV3NHF5ZGpNVkUv?=
 =?utf-8?B?akJaMi9lM1FTTGsveU5WdWZIUkNJSEtOVEdvZnJWQ2hTT3JWM1J4dnJEZytS?=
 =?utf-8?Q?aa9g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WExqVi8zRk5jTDBGaERFNE12Kys5K296Ym9GSytHOXhLNFNJT1drMFd2U1hr?=
 =?utf-8?B?eHBYdGpCVDRidmZWM3Q0OGlGNlc2NWZGZkxBTDBqMXdTajJ0amZmTHJzR2tQ?=
 =?utf-8?B?aVNpNmg5K0NWeWlUMk10U1ZCc1RXdGJxZThCSExmR0Z0aFk5dEYxYTQ3dnBH?=
 =?utf-8?B?dzE5V2FycmpQY2FDYm0vRTc3ZXdvMnpnTE9oWFpYd2FTQmNqTnZ2OHZFV1RH?=
 =?utf-8?B?V0VpaEJUTkxveEVNSnIvellpeDZrWmFjTTRzTFNmMXUxU01kRFFydWpQUHN1?=
 =?utf-8?B?NmpINE5uVlBWZFpjR3UzV3FWMHEwamhhd09RcXRTdDVLeEk1MDdlYnd6UmZR?=
 =?utf-8?B?SjJGTXlaek0yUmhiODFqYmZBYWNkSDBXZHdXbmxGRFF5QkhabEJqQ0hJZG90?=
 =?utf-8?B?MW1HWk1qRmlFUTNtV3c3SHhVaGZ0Q2phUGtZeXFVTCt1a3hPNjd5cFFTNjA0?=
 =?utf-8?B?akpXekpTdXRKaVBGWHMxdDR0UXM2bm54MmVCWGJOdjYzL3gxWHQ3bit0MHBl?=
 =?utf-8?B?RndEeVYrRk1rMHo0cDdJb3R4TUswZDFHdVFkVFBzU29WVkpEeVVQbFNITm1M?=
 =?utf-8?B?N1YwbnpURmszcEVXRERha1BEYjl6UDJQU0dkTlNxc3BLODFhUE5XMDRKekdi?=
 =?utf-8?B?WWdnYTNLZmhyOEVxUkx5Umx6b1hHbSsyczBXWmVDaUZDV1hDQ1NVYVdxVzJ0?=
 =?utf-8?B?NVhOdWo1aEVndEIyWEdwSndwMVdldkt5dTIvdkhQem90M1VNUEpRTTdmK3dJ?=
 =?utf-8?B?MGNHNUR1RzBEMHVBZ2o1NE14aTZBVjc4amZwY1NLZnZVeXU1V2UvdEVHcjdx?=
 =?utf-8?B?ampHNGVlQ1JhVkcwcG5BT01pKzZvcHBFendrdnI5T0cwL2E1WWpWMXR6c0lt?=
 =?utf-8?B?ZGZONXdvdk1Ia0p2R29HeTFhcFBGT0hXVXh0TXUwVkNkSTZ0aTdhZjlqUTFW?=
 =?utf-8?B?dm9id0RiQlU3UVFucVJjWXlBMkZzY2NlVENmVmFadlZULzhTTjMwVWF1ZGQx?=
 =?utf-8?B?djc5ZkVvWmFHcjlwaExkQk1wbGdQb1VZNTVlaHRDbko1UFRVaXRmekpRdkVP?=
 =?utf-8?B?WmNoQ01SenhXMW5mNjJVUUo1K2lXTmVFNHhJSzFETlNpbW5YWS9yUEEwZWdo?=
 =?utf-8?B?SDRvaU1KS1E2OTVtTFJOOEh1aFlUOC9FS3RZUG9EcTVEQ251bStLYk1OS0ht?=
 =?utf-8?B?QkdZNjZmeHZ6a216elJGOHRNZisvUDBrdFRULzhFTDh4MnpsSkhrZVdoUjZz?=
 =?utf-8?B?K3d6NWtYa25WV3RFKy9ndHRNc0tqNUFEYUJBRTBBeHorN3hvRzI0YWFuMy85?=
 =?utf-8?B?bkVLU3FpTVk4eTJFWWY4UU8zRmpFeG1MdlBnRHBjcjN0Z3Q3Q0xCRlczeWdC?=
 =?utf-8?B?azF0VXQxbmZYTjhnRU1VcUpFUUdkRDNTeWpOYmtyeXRZK1Y4aDgzcVNYNTlu?=
 =?utf-8?B?NVlvMWUxT1gwZHp6UU11MlJ1WjBFMGFJMjJOSDhTWmNKR0xKaGxhcy9maUho?=
 =?utf-8?B?SUVXZG9wbTkvK0Eyck0rWGtRZFNqREtxK0VXSWhNQVAzWU8zcHVPU1puYWxE?=
 =?utf-8?B?WmV6b1lacVQ3endwWFcvZzBGZDVnSTkwQnlKQWE3cFhGNUhqNmZkL0lzN0M3?=
 =?utf-8?B?NTZEcjdMRWJ2T1VTMFRkVnNLUFVCOFNJakdWM2pvRVpFQi80c3Z5Y3hldnRy?=
 =?utf-8?B?THBPK0lXR0JoY1QvUVpxYWlMaDZIbXdTcVJWUmwzc0ZFVTFEMUtwL2xUdlZ2?=
 =?utf-8?B?UXo0TlNmTXBLUTZEUWxxQ0hWK1JOY0djMzU0Mm95VnFzelR3Y2RSdUQ1aVRi?=
 =?utf-8?B?RktRc0xOT3VTRjBVaVZmNWd1VHhQZkFORk56TTBhUlNZaWlUemc3YUVYcEZK?=
 =?utf-8?B?MnFWendFaWQzbUgreERDL3JoTHRIZ3hmZHhKRTBscm12aXZUTUNFV3pjQ3g1?=
 =?utf-8?B?bUtTdmtpTC9GcWp1NjI2U3M5RnUxUTBXL0ZyNmlhMTl3a0dteERGWkxpUFdy?=
 =?utf-8?B?YUNyZG5mWWtxUDdtSXpCbmlaeWt2alBrYlh0ZHZrV1Q3UGhGOE5FS0JTc0t3?=
 =?utf-8?B?M0xtQjFnQnE1WERxRDhoN0xNbkxyaU9QZE1BejNQckhSaE9LTEpnemNzTVVP?=
 =?utf-8?B?MnRPVDcxeDc1ajNsd1p4QXhISE5sZHoxMEVmbmQ5UGpmbHlnVWkzblkwMlhM?=
 =?utf-8?B?cHFaMnNtSXg1NmtOR0t4SU5RVGMxSnVwYzJxSlNXNHRHd2tMN3ppQUZ5cHoz?=
 =?utf-8?B?empQZG9oYnlIUTE5Mk9zQ1AxMmZFVlJNMU5nVWdxV0pHYkdGYzdEZnBBR2hB?=
 =?utf-8?B?ZnZ5OVBRSjFVZnFOQmF6T3NHU251Mk9qWjdTNEIxTUNKSUZzZ0hEcUo4cDZz?=
 =?utf-8?Q?2HnCm6UEQE+RKsKo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a042099b-442e-4a95-d7b7-08de57b2c0d8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 23:30:38.5756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkJuhIAd6bK898GWnEbmFqWfHVz/dvz5AJ00NijmHgqoWhk3R+x7jmgID8+K3ET0RdlqShheZN2RV8trI/aIf6kFVRZdomy7TZcFLUb3vVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR08MB11624
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


On 1/20/26 01:40, Michael Nazzareno Trimarchi wrote:
> Hi Mikhail
>
> On Mon, Jan 19, 2026 at 11:33 PM Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> GPT disk partition with max available number (ex: /dev/mmcblk128) can't
>> be read/write from U-Boot using read/write command. Here is an example:
>>
>>   => mmc part
>>
>>   Partition Map for mmc device 0  --   Partition Type: EFI
>>
>>   Part  Start LBA       End LBA         Name
>>         Attributes
>>         Type GUID
>>         Partition GUID
>>   1     0x00001000      0x000013ff      "env1"
>>         attrs:  0x0000000000000000
>>         type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>>         guid:   5452574f-2211-4433-5566-778899aabb02
>>   2     0x00001400      0x000017ff      "env2"
>>         attrs:  0x0000000000000000
>>         type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>>         guid:   5452574f-2211-4433-5566-778899aabb03
>>   .................
>>   8     0x00158000      0x0034bfff      "apps"
>>         attrs:  0x0000000000000000
>>         type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>>         guid:   5452574f-2211-4433-5566-778899aabb09
>>   128   0x00000420      0x00000fff      "fip"
>>         attrs:  0x0000000000000000
>>         type:   c12a7328-f81f-11d2-ba4b-00a0c93ec93b
>>         guid:   5452574f-2211-4433-5566-778899aabb01
>>
>>   => read mmc 0#fip ${loadaddr} 0 4
>>   Could not find "fip" partition
>>   ** Bad device specification mmc 0#fip **
>>   ** Bad device specification mmc 0#fip **
>>   Couldn't find partition mmc 0#fip
>>
>> The error is caused by invalid boundary checks. This patch fixes an
>> issue.
>>
>> Fixes: 43fd4bcefd4e ("disk: part: implement generic function part_get_info_by_uuid()")
>> Fixes: 56670d6fb83f ("disk: part: use common api to lookup part driver")
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>  disk/part.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/disk/part.c b/disk/part.c
>> index 49a0fca6b89..4923dc44593 100644
>> --- a/disk/part.c
>> +++ b/disk/part.c
>> @@ -674,7 +674,7 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
>>         if (!part_drv)
>>                 return -1;
>>
>> -       for (i = 1; i < part_drv->max_entries; i++) {
>> +       for (i = 1; i <= part_drv->max_entries; i++) {
>>                 ret = part_driver_get_info(part_drv, desc, i, info);
>>                 if (ret != 0) {
>>                         /* -ENOSYS means no ->get_info method. */
>> @@ -709,7 +709,7 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
>>         if (!part_drv)
>>                 return -1;
>>
>> -       for (i = 1; i < part_drv->max_entries; i++) {
>> +       for (i = 1; i <= part_drv->max_entries; i++) {
>>                 ret = part_driver_get_info(part_drv, desc, i, info);
>>                 if (ret != 0) {
>>                         /* -ENOSYS means no ->get_info method. */
>> --
> Perfectly agree on the fix but still I prefer to think that things
> start from 0 and not from 1 and move up to < part_drv->max_entries.
> Do you consider the amount of change needed to make a more common pattern?

I think this is inspired by linux device naming (/dev/sda1, /dev/sda2
and so on). Starting from 1 maybe extremely useful for passing proper
device name to the linux kernel. 

>
> Otherwise:
>
> Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>
>
>> 2.51.0
>>
>
