Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191BBEA3F0F
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 07:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6793E8341A;
	Tue, 10 Feb 2026 08:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="GnL1TtDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E058388D; Tue, 10 Feb 2026 08:17:13 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE7A8309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4hgxDfiOnpHhQUa8S54EWgUWUXkR5XIwEDPI80iREgAHKTP8hskfOw07yCu7nlfBEDAjkFE4uKaUlLsEIa8YDH9Iesqq+vfki05TFn5qpQIbJhO1u3fPKVi8+u8jeUH/6pFOczZEEijo9vl5x2g6rK6qiSBqpkA0OvU4kbBqHADXXhfsH+fIhgPt6Lf1CGufrbXByAis3t6dI18JdLiwE95ydPHxCGQsiC+vh1pCsYzg9SG2SqBFIMrWQ9Fe27/MesF88soBa8YFmolm+0Bjwk8MSO3hmd8F/khB47iAvGGHBqzC72c0PSXMHl5lGCRf4bw69ugfHOEWYLtZVTwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nqF+9nojnCy8sE8ksvdchUPcZ/XzsW8lB4d7wfINuc=;
 b=Z0BAkkp7LKnzOMyPZdxtBqqH7jc4ezh/6i+IpvkNJgju9/ucqdMpPSVLhvYeXMiVh4eS2uPLzgOwfB9DJ6f4mwB8bKVdKLD4o3TVDnsa6rf0zNk5udQiaZXVEXqvU+UUsVnFp2HGJLRyIYHTS7NbsW5GYf9NA8mW62r0yq60/+UmlL3uyM/fW6LiSzw5FBO8EI0jJN90Qy0vvw8FKu8koYUcP7JbzgtR2C+Ks31tVlRQY8D0s4hrH958DG0Cmevko/axreVpyhenRxnUoy7xUO9jwMKsxvuxJXx06opQy1XdA7TqFvYgr2lEG+Fbad9IojWIDtaaYjqxdonQH0a8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nqF+9nojnCy8sE8ksvdchUPcZ/XzsW8lB4d7wfINuc=;
 b=GnL1TtDd5up0CaymM9+QBIGPFaRe6MlZtl9uObH43plJTrqgmp/AulXdVAwpEK3Xlj11AGSwQnmzOIYd/6/Mz/qQuGlbaat0rEH/vfmJr+EAUqwZSppO4CbCeeyYc5gqHEphirXJQhqtiX8g2CoT8PCv8arv6QuWbnSgHtMLZ0n3ztjupMjfgwG0BNtftQbo0/NYM3Bf8wSBsTTKbHiMA1M/VPUtVYU8grNXmwIDpoN1t28vlt1hVP6Q8pxErKRh+9gVId0hvoxE8vJxz8RoqxG10ec7B7ArqpxTnwo4a2CAVTaomtuZNBU9u1xbduhFFD1mYv3eM/4LWfLjhsEGxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA1PR03MB6516.namprd03.prod.outlook.com (2603:10b6:806:1c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 07:16:55 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 07:16:55 +0000
Message-ID: <682467b3-316c-4818-bcd7-9b2c34b32581@altera.com>
Date: Tue, 10 Feb 2026 15:16:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] clk: altera: agilex: Exclude AGILEX_L4_SYS_FREE_CLK
 from enable/disable operations
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
References: <20260203075924.2492-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260203075924.2492-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA1PR03MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f0ffe3-a126-4f69-d9e4-08de68745eb3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0dGLzdmdnQwdTNCcytQMWg0OE94a0dqUlBrR1NBTG8wc2J3djQzL0pJWEpo?=
 =?utf-8?B?UHUxU3JVK2I2N0JIMEs0M0hrZFNndGpFcmM0MzZXWWtxUVdNc0JjQmhsbTJu?=
 =?utf-8?B?ckRkZHpUZHYyRkFMaDRVRnJKSkFDV1lpWnVwYVR6bFBGQW1tOFV3R2tleEZK?=
 =?utf-8?B?TXNqK3NaQmRPeG50bGNCckFtVC9kb213UWNIUVFud0pSd0J1cFE3bUg2OENZ?=
 =?utf-8?B?MUhaaUlSTGowbW4vMWh4SE95M3drcnM4OEhiZzE4bWMxbVFseFZkUGVWSEFs?=
 =?utf-8?B?bXdYNEtxQ1dUM3ltNzYrd1I5RkNIRktMa0F6dVFtUC9QbGo3UjJYZHM5UFdL?=
 =?utf-8?B?NWdtN2V6MEdwcXZ0bFh2U3NIVm1WUkNRd01UZVFzRFYvNEIvWlE1VzhUa0VP?=
 =?utf-8?B?aWZkNXRlRkdMU29zWnpaYVAwMXRxNFF4ZVl2UTdPWCtDQWRKUk5CSlpXdmRO?=
 =?utf-8?B?SFhraG5PUXVRQmtib1JnV1ZrczVDMnphSUhqVnpMemw4SzFZa1BOTWV5ZWFm?=
 =?utf-8?B?Qmo5OWloZU94WG9oWU9tRGx5SUdYdUNlQ1U2czNQeWE0SGs4clc4OXNmbHVZ?=
 =?utf-8?B?K1hBNVdQSDI2ekNBdmlMaXlVd3Z2c1VLeUdUckFHV05RQWt3c2NCSXJITHIw?=
 =?utf-8?B?eWRBMFBEcnR0NVd1bzZIekZoek9pVW5vRmE1WVFGdS80YUJQK2hlbkJZS3NL?=
 =?utf-8?B?UHlxNmNDTmx3dUFBREIvemFrM3F1bU9YVHRDdmJpb0VCbkdLWXE5aGJKTDlF?=
 =?utf-8?B?aHR6YlJzd3hBL2p4MHRJcmMwMEhLQm9EZ0I3NkdSZWNqOU93T0NWYUd5L2sz?=
 =?utf-8?B?T1lDNUZWcjRQME84TXpNcGVRNGd1RGs5RUx1ZjBEUzZRQWtMWEs0K0kwSWY4?=
 =?utf-8?B?cXQwRmFzTXZHQVBkTEZMSENuS1EzNitFcEpSVTZSR3gwcHF3ZGFZWURwOEVR?=
 =?utf-8?B?K3M3c0N1S2FwR25KalhseWVrOEltYVMyMjYyMjNhRUZHcittaU1wMmJFdG5s?=
 =?utf-8?B?N2M3eUhiVVFWQmxhalBOaHlIakdyWEp5WHpjNW9tUWVFOEZaK211V00ydk5Z?=
 =?utf-8?B?eTBYMEs5M1dSZ1ZzZ08yK3dGY0pFcnNUelY1UEE2aGJQVENld1plVzBaWnFX?=
 =?utf-8?B?b0pTMkpOQlZqRmxjaGM5blk3U2hvd1JUR2xmNjZ2Rm01SC9FSTgxdjJVSVE5?=
 =?utf-8?B?cExTaktwREZ0ZUYvMXRJRlN4RWJCczlXQ3diWHdlN2I5R0hXSUZBaFk4cExm?=
 =?utf-8?B?SE44cnArcElqMSs0NkovQS9TbHdsUVVQWjB5TkdPSjE1ck04cWZmYm9MR2x2?=
 =?utf-8?B?M2MyTGh6WWJXcGZENjBtS0lWQkt4RGo1Mm1rR09xalFTQTNRb3lnenBkbUFm?=
 =?utf-8?B?bEhWWGQ2aUs3ZVNCSTh0ZmNpaXBrWmU0U2F3UkJuUFlEekw4MVY4VWFYVS9H?=
 =?utf-8?B?MzgyWVVEUjJ1S3hEai9kWnJ0ZGl6WUdwWThDM3pnRUZaWjFtVGw5QSt1RG1i?=
 =?utf-8?B?NjUzeTFJM0tsYitaVGJrcE9nZEIxMDVpUzBIdzVERkhMY3lWdlBXTFdMQzk5?=
 =?utf-8?B?UVV6cXIvNS9FTCtxczdsbkhqRkRDNHFUMzhpYlk3a3FTeG44ai9SU0MzVlVy?=
 =?utf-8?B?MDBxQ1lPaHBFQjNVMVAwUkpPWVdGNEVEMEZOUTRmN3pFWUkxOWtZOUZTZ1A4?=
 =?utf-8?B?SUhzZnVnUUNvQ3hZRDI5TlNNT2hWa3ZEblFMZnpvR1lCaWRLL2JqUmcrQ2g2?=
 =?utf-8?B?U3lkdXFwcUNwSmZ0OFhKZnNmajdqNVJDYU5Va2x2bXhRajYvNmJWeittUUMv?=
 =?utf-8?B?WEFuTngyc3VHNUt1ZDg3YmtESW1TNzJ5ZXRUT080eVh0QzdFZkZJWlJFcEV5?=
 =?utf-8?B?NjlrTzZMSlpmc29PSFcvWlZMQkk1YnZ2dUJGZThVejczbmp5bG1yU0pldzVp?=
 =?utf-8?B?emdNd3FqYU1vNC9hMHc1dUxRNkJrTzNRN2FsOCtFR1JlL1p6N1BCcmpHWC9H?=
 =?utf-8?B?SURGVUNFODNkbUZsODdVeStNV3IyNUh3eGxoVCtEQXlLZ3lrL2xsMmIvWWEw?=
 =?utf-8?B?b0hxamRWUXY4NjBlclJoVVpZYzJuZFk1OG1LUTRmUnJMaElIdzBrbzhXVmIz?=
 =?utf-8?Q?RkOs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUJrN2gwZkVCQUtDMURKRUh2UlVwL2hlczN2bjBMZzdYNjQ1dUwxUUdWYVdX?=
 =?utf-8?B?bTZoeERVZGp2bHVXQlc4bW03K1VWeStteTFTUFpCb0ZDckdQSjVUTThGNkY0?=
 =?utf-8?B?cHpZUlBrbE1OR2Iva01rcVlDcTJYVkd6N1Aza3VMYS8vQVJQWWJTQ01HditS?=
 =?utf-8?B?MjR3SXRiV3FxRnNUOW8zWDBnNUl4Q3lhQjZKVlU0YzdxRitLZ2dENEVDSDRD?=
 =?utf-8?B?aVIzSWV6cW9tWm1vTERwL0tYSldpN3FSUHg2eEYrUGxFaVV4bGpHblZUVXcr?=
 =?utf-8?B?MFJETHR5bVN1STZTN0RMNzVoUVBMZVpKUExTdFVNZmx5Z0VYZU1ZdHdBaUFk?=
 =?utf-8?B?ajlIaVY3YnNOckZNb2RwS1ZURGRzcENIclVTcE9udnR6cjJJbldEQU0yc1dk?=
 =?utf-8?B?ZTB5NndiNUJIZ2lMczhHbzVWSHdCZkg5MkVsRUFpQy9lS0hOcFdtVSsvTUlO?=
 =?utf-8?B?dk9MUVY1Y2NDYjNRcGwxeWt0M3pFN3RWb05sL21kSU9sQXppQUNoWWs2TkpQ?=
 =?utf-8?B?blZOUFhLcVY4SVpOalQvdVluaUJtc2g4SjZ6bXQxUWZXZmRSK0VVMmkwaTNF?=
 =?utf-8?B?bzNjaHV4b2JYa3hlS0Mxa1FGZVZaNkpRaEdScW1ZRUkxTDZPbEVuQWRsTEVN?=
 =?utf-8?B?OEFGSEtNNFJOOVNYSjloUkc0ckpJVjVEZE5DazcrOWc2RUxucXplVEhsVTBy?=
 =?utf-8?B?SW4rQmxBemRLNHhFbGx3dHRJVTduSjlQLzZJZTFlZS9oV1BmK2wyMVhhWkZl?=
 =?utf-8?B?MWV5UWpUME5vMkN4cDQ2MlFwSEZOaUdZMnB4U1pweldDckpOaXdnNXFFUFUy?=
 =?utf-8?B?QlVIdUFqYjVJcGV0eWd6SjZnSnZmc1lDWFdQTW5HNDkwMDdoTUpjNTErTWNs?=
 =?utf-8?B?Mll6SnlaT3NKNHFHVXNoU0RZNGhZSE40Y25raUpRTVFUeHpKNFowaUdVM0Qw?=
 =?utf-8?B?RWE5cDRYTXd1QzBabTVia2d0cG9kR1hjb0hGMHVoQzRlS3g3cVl0TzB0ZmlJ?=
 =?utf-8?B?Z0R5MU5hcjRBeEg5dWxhUUpscGNYZ0JSYnhZL2hjMnhnTE1nZ2N2c2tjTDBF?=
 =?utf-8?B?TmZZTUdZdUl5QngwRERYK1BwaGQ2Zm91VFYwZFdSbmE2ekFZS0YwU2g2SUQx?=
 =?utf-8?B?U0JWZDAxYkM3YVUxR3JlVkZPekpmZ0dsUWh4WGpzRHFEelJ6QkRLUjFlRHRt?=
 =?utf-8?B?aW9QRmRRQlJpTHBVMnpGd0I1aFcxUC9GWkU0cDE3ZVdvRTRLOFNULzZTZXBC?=
 =?utf-8?B?bGtNTFVCdXBnaWgrSExLL1R3K0lad2tLNVNvZGI2Nmw2bUhXSU1LZW1qdFM1?=
 =?utf-8?B?eXNMY3Z5WFI2Rzd1bDVaOC83WVdKVEZ0Q0ZmQXoxbmhPMFFVSWdlNEJlVDZW?=
 =?utf-8?B?cXV1aEdzbFVPd1IwL0dheWRwMytpZlB2a3JXb0o3Sk5ORjdWNVByK2FzZjRX?=
 =?utf-8?B?QXc2VGU1aWtJMTFPOENhdkFFZmRKa0NxWGRYeVorUmhOUTJYRkNKQlArSm5K?=
 =?utf-8?B?UW5LUThGOWYyMWxKZnpuNW42TUIzbHJob0Q3VXFZYzV5WlZwWkxKdmg5d0ZL?=
 =?utf-8?B?TmNwTGQ0WUlpbjV4UVJVVmpyL21laGZqUVpGVlkwbC9ZOXp6RmRTa0V0YjZn?=
 =?utf-8?B?cmd0REQ3anhLYTZtUVMyRmo1VDRBcTN0OWFuUnBhejduaGM1SDlNejBoQko1?=
 =?utf-8?B?ZCtuM3pzaXVjb1QxNVV4WGhhcHJRZzZ6RHlZVTc0a2lZVkxpN2paUjY3RnNy?=
 =?utf-8?B?UVdyK21KUEZUKzFYVW9pZU5aZityYVNHcEFmYmVMeDNnaHlZemJJa254d3I0?=
 =?utf-8?B?Q1Zrckd5RjVXRGpaM2tRckVPSTM2R3ZaSldvbjFHeXkzT1k1Z0J4VzBESEs5?=
 =?utf-8?B?SE5RaXFMWU1td3JhZnFtTG5leGRwdjVSOGhwWUxIMi9LcTgyN3lrWmJUMmxC?=
 =?utf-8?B?aEpBUTc0MmFkVjg3T0hNNVhGOEtpSGYwYWdndHUvUEVRQklzWlRWblNxbVBl?=
 =?utf-8?B?TXk0bURkN0lNVEMwL0VyTE1kVjhJMWJybFBFNlBiaWdSV1hZcVgwZThCbUdZ?=
 =?utf-8?B?SndOQVNlOTJ6eU1yVEpITXljcDQ1Rzh3MVorN0UrL0VrYm5DdE5LbDhxc0Iv?=
 =?utf-8?B?cHN4bjlCdTE4eFhZc0F4dlhTaWM2bDFtWnVpQ0JZOUdyVlZBTHVhOUZOVDVS?=
 =?utf-8?B?VlpHdW5oRmExQkFDWEg5ZVpESzhsT2VuV3ZUV0lpT2hhSUErcmVlV3J5WDN5?=
 =?utf-8?B?QTdYRXl5R1ZCNUs1SDJBb2xEa29mem85eTZuTVVqUVduaW1MMmtpdzUvVTE0?=
 =?utf-8?B?YzdlVzFHaVcxeGpqcTFHVkMvRHZXeUpITkNmRHR1QmxzVEUxU1Z4bjdIRklC?=
 =?utf-8?Q?z24kJUt1a2HTscww=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f0ffe3-a126-4f69-d9e4-08de68745eb3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 07:16:55.1813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EBCAXputZuizN2ZVMz5aN/NQbtgvzq/1mbfBTvUCZY1sWYAPYwt0ASTPUKVQ5bKThURJG4yPFsnD+3cPQ+ERdwyKotILUcPHgDbYmP9S7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6516
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


On 3/2/2026 3:59 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> AGILEX_L4_SYS_FREE_CLK is a free-running clock with no gate control in
> hardware, therefore attempting to enable or disable it is not applicable.
>
> Update the clock driver to explicitly exclude this clock ID from
> enable/disable operations by returning -EOPNOTSUPP in bitmask_from_clk_id()
> and treating this as a no-op in the socfpga_clk_enable() and
> socfpga_clk_disable() functions.
>
> This prevents unnecessary register access for clocks that cannot be gated
> and ensures clean handling when the clock is present in the device tree.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   drivers/clk/altera/clk-agilex.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
> index fdbf834bb2f..88423292c0b 100644
> --- a/drivers/clk/altera/clk-agilex.c
> +++ b/drivers/clk/altera/clk-agilex.c
> @@ -728,6 +728,8 @@ static int bitmask_from_clk_id(struct clk *clk)
>   		plat->pllgrp = CLKMGR_PERPLL_EN;
>   		plat->bitmask = CLKMGR_PERPLLGRP_EN_NANDCLK_MASK;
>   		break;
> +	case AGILEX_L4_SYS_FREE_CLK:
> +		return -EOPNOTSUPP;
>   	default:
>   		return -ENXIO;
>   	}
> @@ -742,6 +744,9 @@ static int socfpga_clk_enable(struct clk *clk)
>   	int ret;
>   
>   	ret = bitmask_from_clk_id(clk);
> +	if (ret == -EOPNOTSUPP)
> +		return 0;
> +
>   	if (ret)
>   		return ret;
>   
> @@ -757,6 +762,9 @@ static int socfpga_clk_disable(struct clk *clk)
>   	int ret;
>   
>   	ret = bitmask_from_clk_id(clk);
> +	if (ret == -EOPNOTSUPP)
> +		return 0;
> +
>   	if (ret)
>   		return ret;
>   


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

