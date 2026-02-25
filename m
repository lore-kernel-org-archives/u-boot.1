Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F2AFD3768
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 890668408D;
	Wed, 25 Feb 2026 16:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DENWg4xj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0492383FDB; Wed, 25 Feb 2026 16:23:00 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA1A8408D
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raV3CMwEco7JmTjDPeCrg+nDRUMRdV/0El8ATNXWkS+lfN6xFoS9/X6LH/oRDTHs7gGL4oEvIeWz7uCxcVwgnS0jnAXgIM+xoHuuRZ6ARGQWxTNtGCaDriV8xvZ+pFf4eCUAYYSo4S3hUfl3vfsd2kYmhWABenG6UvKMKH+IabPKKWhJGf2xEMGTwi2Ac+FG8Xs6/3QIuZ4Xg58acvm2jg0hfPKiRWD3Uw58SeA70btwt7ioLLUVwqMnb1wSzLuz1WksIFlqcWUHwwMX+nz9ChbWszGIAmQGb/srzWOUjxGZFEgiRC166SpKlGXUMTvlBX5O6tHNIG9MrKOmeWPHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jWHuH/cxs/NRFNKyCu5gahMgttceemQVQxeztiMQPs=;
 b=oxbJE0bXP1rdwr7OPOrRnDrggOGFt1UmAhON0HmmsrCPBrmst3wM7RO1G4+7SoQW3B4cNBoUEIi4aFYKhgYwZfmqP8nIhERMbPTaqneFi/xw2LLZdcpH+EW0F+drQcKdI3QiD2DCx+lQVMCs+ceE2+tPa87R+A/p15DO8IhuuTDXm/uW4wB9CWT4Zen6h2g16tC7iHohAXw9HTTVAgnV1HWLfUHnAmk2sOsgiw1U5JtTs32S/yDHGXDAnr1lewdObgQrhVtEr+lb6PGuycJNir4dtmahfpK0OK4ZPCPw0b7zrMSVZ4CaaWd4gdILceiF0Q4ZMHfeXbBtNKQtncaP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jWHuH/cxs/NRFNKyCu5gahMgttceemQVQxeztiMQPs=;
 b=DENWg4xja7S8eM3zra3QkrdGE9X3ng+YjQFWqLC40W7y83E3RCskPs2saM89xEXJ3w0Bp/M1bKFxoa8LL1Yox1RX1gO0vYQWlC7ugEum4ToVGhZAmWzy1+88f0F1xmOOvU8B+3g3Oqu8d3WXlxPjCU1eTj0uAIBB2/yXXFSlRoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA4PR04MB7728.eurprd04.prod.outlook.com (2603:10a6:102:e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 15:21:28 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:21:28 +0000
Message-ID: <8d802396-601a-433f-baac-5573a74a7faa@cherry.de>
Date: Wed, 25 Feb 2026 16:21:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] doc: pstore: fix typo
To: Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, Aristo Chen <aristo.chen@canonical.com>
References: <20260220031841.15708-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260220031841.15708-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0145.eurprd07.prod.outlook.com
 (2603:10a6:802:16::32) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA4PR04MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: af5ad335-4c19-4a20-8e03-08de74818c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: WZysaC11eeWGoJJcrp/CTJKg7hzdUhZ0mwAfAp0ntx5cNauSdCmdseup68FuyO3kkOWhKk3tqk6GHGqteYBqs5cVIQRNQroBTOjVwM1t+KwQIeki7jR9lQHby41owj7je2A9lML0g7jpOEAtEs2JspbgE1H+/doYyIBqhwoDS3/g0kbrMp8RipouXOZdQU/r3lVMkEh9mIQBQdsrJeg0qGFjk+Qv5WpcRcjFORNGpfs0dWDrwvYCykQ1OjSV8JzPSyv/a4JDocTlQu2SKrxZT63Kpf0QeNCULfY0iRKFlhCNG4Mentmh2H16ru4CLNetKjq1O4Yn4W0N+jxJMXb2ltXb+HnObZ0VhVACaogF5nR26sw1ThSWABnrcu8xLGoir2V2h5H5Cits/MQ97FpeO7IWws08oMBF6ipvpNPvj0vp/qhxGHp6JAiAEukvgMNZiWjDuS7Wj+UYuvWneb0V3PrHirt/mrb+ACS3DE6lXZsVsJ+o/8ehk/2jMRy4Ni742dGtNcEFlIKfXflXcohsWulvInOEe2DRhzTvmChXTRNIeAsq7gn31gavCOpcCuhGlxdfsmwC5CRXhUE2TtSoJqS8rcAzDF9NDpqPe7mPj7aEk0nDX0jX0V6EZHMn/MLmdE3xgK13wZlrKhI/E4ZNoOXYWoZEDabEy8t/AfuQnBazLn0PuhcK3vRKuLafMwYcxNa6N0Bu/ncZAVy536c5+joGPrMdMA6jw/WzRk7V8hk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUIrVDhRd0w4aUtMcEhaYUVGU3ByaFZ5V2x3UHBLcjVRSHZKV0pLWHVVbnE5?=
 =?utf-8?B?Szc1RjJTb3ZTT0prMDRUZ0VvVFNGam56ZXg2VitENTF3L1NzTm0xR2JBY1Mx?=
 =?utf-8?B?aFV4ZnNmZUhwWkxoSVNtT0JLaks1NlhtYkdFS1BpZkxOMWZXa2lNYjJUeEdh?=
 =?utf-8?B?NzJxbEZNaWZhVktMSGdwd3FOb3lDdUZKRDZlSUJlZ05FOE9GQ01ZRjl1REV2?=
 =?utf-8?B?N1JhK3FvdVJTZ09XbTJLOVNRU3JkeWhNR09jUnRpNlhNdmhRYitCODUrb0Na?=
 =?utf-8?B?dDRLckZtNWZoZUxUVWNnRTh3a0V0dGgxNnhwY2RKb3Z3ckhTZnBQb3pyT0Vq?=
 =?utf-8?B?Wk0zUVhPWCt4UzdSTmhOREkwRzRMdDQ3UHRSQURmbkZYK1JwMlpYU2ppVENn?=
 =?utf-8?B?K2pBWVVKZmVKc1RFTVJRdE9WMlpGZzVoNVpiRTJ3RlNiZWlsbWFXY1NxMTNs?=
 =?utf-8?B?ZkdaZ3BGQUwvcnQ1WTJWZWxsUDhQc3FNb1VmVjdaeGt5c2lpNE90NlRYNDVK?=
 =?utf-8?B?SElpR3AxN0lMNzlNZ0JJV2Q1dGZJeExDSWN4UERKTUpKQVlPajI2dFZWNmFs?=
 =?utf-8?B?WmdwQ0oyVlFSMXlFYTFYaTYvWEhvQUlxZHRKTFNMbEZBYUpKRk9HY2JmMEtV?=
 =?utf-8?B?UkE4d2dDTDhJblhzV2F0Mmc4S0JIU3NlaFh5NVpkNlNxN0FWbDZON0dWZjMz?=
 =?utf-8?B?R01pZzBlbkJUaVhTUk1KeXNqLzJJMjNmSWVxUnlLT1lGbjFabTNiQjl3RjUv?=
 =?utf-8?B?YzBDUGd3MjRNNFhyMVJCb2F1ZzlJdmRpa3QyWDI1T2dGaW5nQmhqYmFtNVk3?=
 =?utf-8?B?QS9GWC9OWWl5cFB0YUYxWDl5WWMxUU9ZTk45cEdSbGx2MHo2akxCNVJFQlI4?=
 =?utf-8?B?OEk0cHVDYS9CN0N6RG5kaXJRazM1VENYK2h3elYxNW5HTksvWnkwNTVCaTlF?=
 =?utf-8?B?bjlWVHdQZnBzNVN0Q2tEenVHNDFPSHRyMzMzQzZsdFJRazgrZmU4cGlOQTN2?=
 =?utf-8?B?Sm13cmxKUnY4RnFSdjFVaHhGOXNsbnpWVERLSzRFZGNZVmNZRjVWZ3RMRHp5?=
 =?utf-8?B?Ty9oUUI5c0VYRXRpN3k4RmN1MXNTcU9YdkNGR3RjM0ZYRHdKN3pQdE9mSzlq?=
 =?utf-8?B?eEpJeGNadTZJTzFDNVRhaWdvKzZMcVM5MkREUUtzQytrZzByMU9CeGJhQStl?=
 =?utf-8?B?NEhLMko1eUJybXN0WWVVdXJqcEVhb0NkM29oREZYVzltSS9IZ011M1JINGVn?=
 =?utf-8?B?ZXAxZTBOazFFek01eEpZdUpqSFdyNlE1ZXlOUTQ2L0tDSk9Tck5QYXJTazdH?=
 =?utf-8?B?QVluNFM3WW5WSnU4THdvVEFCM2tzZXYxRWxGOFRHbXFqYmhZV0FEdjR1WjZ4?=
 =?utf-8?B?MUtMRVRic3lXZHVkeXJUSEcyMDhvMTNDeFpIRWhlTE51L2dqN0UxSVdUTnZN?=
 =?utf-8?B?Sk1uVzFRME1aVHBqZFZGWWtRRWNrK2xWdHpPZGMvcW1oRGVUOTlNTXdRQmFl?=
 =?utf-8?B?MEY4K3JjUGRrZXFjUGkwSlV2TmN3MkZBdDZHUW5vMC92Wi80b0JKbHZQdEls?=
 =?utf-8?B?cXQzTzZEVm1scXpjMGcxRDd2NHgvZUpBTXBNRE5OdDl4dFNQSE96WlVwcHlm?=
 =?utf-8?B?MENoeW5lUXkxa1hSR3JNdmorcmJtK3puUExlNTVrMjhPZXhPZ1FDOWJrWjN5?=
 =?utf-8?B?dUJaMGdVWDFFbjlZbU1HNjhZWkc0MUxDQjFvME5xbk5iSms0U1dEVXMrTUx3?=
 =?utf-8?B?NE9RUlNjMldlV05PR2VDSUJCM2xIYmpHNGVmbENaZHZhbVBMbWZkZzVqRW9R?=
 =?utf-8?B?T1l6RVV0UGoycFBxeVR1VWY4RWhCNHdCZDBkb1J1NEZTbFRQZ3hQV0JUQkx4?=
 =?utf-8?B?V2gyenVaVzE5RHdwVXlIVU1mV1JNU2tkQysvQVZUU1I2TkFEU0doZmc2SFkr?=
 =?utf-8?B?UWpMeG9xNTVnNVROU0lsNkhzZUJjM1lXajc5c1NNYkhrVXhjU2dDUVlXZEFi?=
 =?utf-8?B?cGd6R0VMRTdoRUVwMTVFbDY5M2dJQ3MwK3pTWXBVcmV0UHRqcG1UUjRQbmx2?=
 =?utf-8?B?bFM5TTlpV28xeGtDbElmUnNxM3JnR25uNDdaUFJ3cVhsWWUydHpVLzBXQ1NM?=
 =?utf-8?B?M0tWNGE5NmlUYnR2WHBHdDBlbU5MaUxJT2syYkIvTlpPaUk3My8xV01CMlhu?=
 =?utf-8?B?ckdqUS9oOTFpVjlQa21maEVYMjU0Z2gwV3FSUzByRG1uamhMQmhGUzBvN25H?=
 =?utf-8?B?VXFLb05jeU9zSHBTaGRMVW1UbVFQZzdnYnZvWU9pSjRHdUU1Y3IxdTNjTis0?=
 =?utf-8?B?WUdRMHVURE9Cc0xqRlA4bjFLVE5ScmtEWnMzSlN2L00yWGNRbmxOUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: af5ad335-4c19-4a20-8e03-08de74818c07
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:21:28.3688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ne6ucccGHwVJuJGTWEHiF1a4In7c7TUj3jP0IzpNanzDkAEuU88DHEKwB5XUiKjgm7GGpZZRU3089uu9LLtpBtUANAdL89JnuqqJnXeZbYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7728
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

Hi Aristo Chen,

There seems to be an issue with your git-send-email setup I believe. 
Your email address differs from the Signed-off-by and specifically, the 
body is missing the From: field you get when this is the case. See 
https://lore.kernel.org/u-boot/20260224-device-tree-debug-no-phandle-v1-1-10bd3f3a3498@cherry.de/ 
for an example on this looks like.

On 2/20/26 4:18 AM, Aristo Chen wrote:
> Use "parameters have been set" for correct grammar in the pstore
> documentation.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
