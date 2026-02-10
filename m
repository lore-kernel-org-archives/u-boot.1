Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7873EA3F16
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 07:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091168341A;
	Tue, 10 Feb 2026 08:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="O2pQyJfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6EF8388D; Tue, 10 Feb 2026 08:36:53 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707338309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLXKTvXyTrgNT5hKT5SFdmfRzeN770iJSBneSCzb04IQV+vh1j/Mnllb5FSnt5nv23pva6j9uu0UMYKl1G6AGuEdCAWuAoFS460S0LsM+GKcm+RQcwJocph7OERUawiCCnQHeauSw6GyWH4GdmNMO1wb7eJB0obdYRYBWk1JOIrzEOMIMHw2PTpmdKV8aP/+b0gljZe60jSefwbkYMCAHEtyCH8XgRry1SItcOYoBh3ICHwfQw2ywqio6FFCCwhS6RNR8XxmqisXtLngPlzF7vKQK0ST0J1pN6F+hNbMKPXgZhJY1RgkShxoLoxPShJnmw6FKJXS5aBor1lH4vRoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmwleqVVXvY+Pu1vlJvIw4en4r7PbFsx3wzT6tTrd20=;
 b=dBZlI1B20HEKIekr6YbWy8+eVBT/KirLIWQmnWjymIGGvBSDezndaUJZkDyphPYkhDzS+p+6LkBW0qHSbPUeSbBqU7ssFyIBvEK6zDdbwyz7uRCzbkJ+Wd2hiGMu+fP5vxKE5Pkn8jSYxkUXHOCXs0InS7z/tTKdciPrDZwuSLNj7UzXnzNkDFR+gRDMzsjRcywGOtdjvLhip5X4+MGqp/bbfqwCHFNKPPh0y2HrkKUPEthYnTQCCqFFaEECNytvzIIF3ZJRKm5tm9rrZ3+CNBD98RuGORp72NeXcB1ydvXrVOQlu0w1M9qF+iLod6R3WRmPYURqbgRuQcVXwyCKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmwleqVVXvY+Pu1vlJvIw4en4r7PbFsx3wzT6tTrd20=;
 b=O2pQyJfMxt2weCIYERaDMsSLC+dQPgRD9bG9dmiqsPevlyvLizxSh/X5srMxQgAo3X1EQi/TTmD7wXFuwYOStXczmgvPKBK4GAJd3K5o3xhbL7uQQHHjhAZeaRLNa3xTbgvtU26sPe+VePNLtiz5Oz3WNqRslX4c/1d1CwFD9PFED9yoKAh5TEpIS8UalAryNheGp+NTWnYbsVts07xgqYyg4I+3lsf5x1E8Y5mlMI0NNiXOOon+9a5W7HTbo4IEmS0OxZbThSIU2J6F7oiVqwmzl/ma7Vb1L6WV2UjGLkGZ4522rEvW5f7riXr3gXfuRpLHead2PxHc66X7c9+sWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY1PR03MB7921.namprd03.prod.outlook.com (2603:10b6:a03:5af::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 07:36:47 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 07:36:47 +0000
Message-ID: <a59f894e-f953-4210-b360-59aaf1a6dac1@altera.com>
Date: Tue, 10 Feb 2026 15:36:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drivers: ddr: altera: iossm_mailbox: widen
 MEM_TOTAL_CAPACITY mask
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 drosdi <danish.ahmad.rosdi@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
References: <20260209020709.19712-1-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260209020709.19712-1-chen.huei.lok@altera.com>
X-ClientProxiedBy: SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BY1PR03MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a77382-b275-4d3e-f33f-08de68772561
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUhUK1lFMlg2dXhwY3V2aHp2ZEUvbldCZjZYVTNnNWcvQTNYOUxOQldENXVp?=
 =?utf-8?B?dFVvSmZTNnJIWktCZGd6Ym5JUnVEaVhkRGwvL0ZleTRUZFBKUmdRdUl2RnhT?=
 =?utf-8?B?MEpXR2xONmNzR3pmK3F6b0lGR3AxenlxcmRJa0V0MTFzQWdqL1hpVkliQ09I?=
 =?utf-8?B?eHpPVUNWL205ckdVb05uRjlyNkdjSnpWOXRKaUhGYThFWjhZUjdPVFBzcUhp?=
 =?utf-8?B?VC9PM2tBUGZTVmFHcXplSm80eFJjY1N1bWdpWHJWQnlvNWlOQ2dSenlxa0dl?=
 =?utf-8?B?dWF2WDlVemxuNnFSMVNMdGZadFZzNjI3RGR5dldrT1lqRE5IOWRsakdMcFQw?=
 =?utf-8?B?bVpDTjRKU1FaNVVENVFrZlFWSktXWVpUUGcybnk5Sm9xdS9wZ2ZXWEV6cm9u?=
 =?utf-8?B?aFJqZ1dqU2NLWDh0VlVvMUVORGQ4aE4raFNKNWZuMys5QVJESnRaZmozUUpn?=
 =?utf-8?B?OXZJMFN1VWRzSlJKL1NQQ2U0YXUrQ0RQRmFFOVlpU1lZVkdiMHBLZlQrZmpV?=
 =?utf-8?B?R1BMR1FjVkxnZm9yOGNzQVBYMkRMdFU2c3NtTnlUSGRsS2FROFRYZEMrZURO?=
 =?utf-8?B?dW05d25rZ0hUUTRCRGdEWnUwcmVFeGlKTmU1LzJTWlBjcENRQnFhU0ZGVmhv?=
 =?utf-8?B?UW00MzVBOUhtZG9jeXJHVWhkM0sxT0N0OWdGdTN1cjg1aTQyV3doN0xyb1Yy?=
 =?utf-8?B?bXB3RVFRR2NLQ0Uwc3M2QlFlY0dZTUhqdVNXTEhCQlZpdDgyV2l6WHJEaTl3?=
 =?utf-8?B?OFpORFQxbWdWSndDcnNOWDlHNlNRVVJ2eUh4TDRvcmJzNGhwNWd2TVo3aktG?=
 =?utf-8?B?Q0xmTjZuQjFmeis3UnRrb1h5VkJEM210WlYxaWQ2dmxwWTdwRFFoRzEzaEZW?=
 =?utf-8?B?SEJsZmRLNS9MRHFOUjkvUXBYOGIvMFFiS2tTeUM4YXJ1aW8yNjhUVVFGTWh0?=
 =?utf-8?B?VEc5VGo2ekdEa3ZKYlp0VHFkd1NiblJsRHJCa1VCQlJyNWZuR2RQdGxxK2x0?=
 =?utf-8?B?TEpENm1OOE50ck0zNWJMTjJ0T2VmaGFUYUo3NW5rSTFFbENkajNFWElCOUE0?=
 =?utf-8?B?RkZNVWgwb2JzbC9lYVVnS3VUc3Qzdk0wM3l4RnJXNFZseGJocUhSYkM2Tnc3?=
 =?utf-8?B?ZkxialNaRm1QWTVHaldYdlNsM0ZMak4zUkxpSzRuL05YSDAxSSsxYTdzenBQ?=
 =?utf-8?B?aEk4UVl5TjRLS2Z5VHp5TTFsSDdXdytYWFVsZW13bGllOXh3UGRPR1lEc0VS?=
 =?utf-8?B?c3hxbkRGRE44YWxEcUU1RlBqU0ZVd1RydFgxVjRrZUVnRFRtay8vak01L2Vh?=
 =?utf-8?B?NHNkaFI5WjZScDVCdHFDaW8rcHB3eXIycU5iUmQ1K0RRa2NzSFZWMENweU1u?=
 =?utf-8?B?Z0JkSDJCWmxSM2tqQzBHWStiSnB6ZjRxVktCRDN6T0dkcmdhMzBhRlJwSGU3?=
 =?utf-8?B?KzZkWC9reDM0WjhlcGFnYTFORzIxV3BRSFFuMnpFY3N0bHFhaUJRcGdzQVE4?=
 =?utf-8?B?NWkrWDVYVHFEaEdGQjlxb3lzV3lGendHc3VIWk84TEgvbUFBWm1uaWNyRFVK?=
 =?utf-8?B?R2dkZG41WHFHYzN4L1hSKzk1RUg1eFZEL2t4L3RhUDcwdnpJVjZwNEpod3Vr?=
 =?utf-8?B?VDZHdko5TzQ0ZUwxYVIvSFQ2SzluYWFxYlplOHVEWFdWY0l2d2pZcjNFWmR5?=
 =?utf-8?B?ZHc1K3cyNWxlaG9PcU94cDRFMzZMSXh1aDlLMWp4RTVJZElWaVpyUCs2VXBm?=
 =?utf-8?B?SjNDUHZTeVZoYmd2anFCbkVIVXgwMmVPc2FwQngyOFNweVdhQ0xPSjMrQVZj?=
 =?utf-8?B?enhxZ3U2TVVtdGw3R2Y4QWhma0g1WDNHNnJEWjQxOUsxdkNHVElkb3ZocU4x?=
 =?utf-8?B?WW5UZHNpVExzT01pTmJ6THF3T1hnVk5CQy9DamVjNTBiWWZxaDczV21yM2F2?=
 =?utf-8?B?YVo4Um9XcDBLc2xHRTBIWXJWY0hSV0JFelU2M0RScDBvVXZEWnhJcTJVbmEx?=
 =?utf-8?B?UlRncjJKTzhtY0VxcWhVS3R2MjdCQWpmcWFFeDhsOHNNM2hzUnVXMGlTOGRk?=
 =?utf-8?B?UzJlc2tvVklCbXJpb2ZFYUs0d2RFc3hHQ1JIVjFpdCt5SzA4R0N1NWRnNkNJ?=
 =?utf-8?Q?/8gk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnhOTzE2YWpPSjBISmUzUXhZbXdNeEJOS2I2b091SFpHUGpaZkZRMHJsMXVn?=
 =?utf-8?B?RFJnNVFWTG05WkZyWU01c28zWDgyNWl0SFFyT2JuclRSM1FoYmhiTEFnOTFE?=
 =?utf-8?B?YkEwcTkxZW9xNDBFWTQxTU5RSVVCUXNaM1RDZmwwZVJJYXFobmZhMitjaDI5?=
 =?utf-8?B?czgxU1J4Q3V1aVZvVDJEaXJWejVNMXMvaDh1TlAyM2VGc1dWQmg4RDRFTXpw?=
 =?utf-8?B?Y0kyOUVSQXFkWGtxTm5RbVJHd253RDRrWlNXRkZKYTdzRFFwWkRJK1REckdF?=
 =?utf-8?B?VVVGQTVxSVdjblpOSVNKeVpRS2ovUWE0bmRyOXA5SDhwd2pvYWUxQTRQbmtm?=
 =?utf-8?B?b3NmS215bGJ0Z3JqY1ptT2dtRy9TUFZaZ3lkdk0vSUxjTE42UmhJdlpMMWhK?=
 =?utf-8?B?K2s1cWhBbjV0VStRbWNlQjUzSlgwU0dDZHRpdU9BUFdubHd3Zk05NGJtL2VS?=
 =?utf-8?B?aGRiMVBaVnJ1L0FzQ0xFRFE0cFk3eGZIbmNYRUZjOFFRQ0EzOUdEMDhqOHdj?=
 =?utf-8?B?em5JTmt5Z2ROK2ExY1VjYTIvM2NRdVk3VHVOZ2pYOW5pUnk2WWVLNlV1ZmVU?=
 =?utf-8?B?ay9UTWMvMjRwaGwwTW9NUU9QTGcremZzSmpSRWRsNmp1S3NTd0dyZU5sZmZJ?=
 =?utf-8?B?YStFQjZ0eEVrZEFXRW5YRnArZ0NxeWZtSXFOV01EL3VLRU13SWJsTDVMUTJF?=
 =?utf-8?B?b0ZUNFJvR0NhcXhXbVlSc2dVVUdrb2JQQ0ZoQU5yK2RlUE03N0JLRGJOQkpV?=
 =?utf-8?B?WmtacG9SVHdqNVF5SVdtbFdwbmU3R0Vkc1g3d1J6bVppUitlaFBJaU5vbFFS?=
 =?utf-8?B?ZUdwcWxMdmhuak9tT0RLRi9ocjVPUWQvSkFBakt1ODZEMytLWEFnRmV3eHJX?=
 =?utf-8?B?d2xhS2tVZE1SYVNKT3JZMEhHdjBPK0VJYmRyUXFxd2F3bkhiNEdIcUoxNVZh?=
 =?utf-8?B?RzdZMVFTYTlLNjhOaU1kZlN1NDdMMThHZUJrcVZHZTNwenFrS2hYU3g0RHNz?=
 =?utf-8?B?VkgvMmdENnltUjhRMTRKTE5tKy9PWG9JK3A5dVl6dHB4dDU4QmJyYWpxeUFq?=
 =?utf-8?B?d0J2Ukhyd0oyd0F4ZFZaeVBmVXRIY2RRTjhrUzRjYXlYOTJmVXdLRDJGcTVI?=
 =?utf-8?B?ZHBuZnhhTWZyU0dHRkhFK2pnMW5PZVMwRTlVNURscG00Qk94bmdJc1M3VTNo?=
 =?utf-8?B?SCtJMlZMc3FHUHJmd1NtdFV5TEY5Uzd6MjludUM1MUduRzkycWxEQkRnbmpL?=
 =?utf-8?B?cmVjdXFpUHlhS0xZTEhMY1U2WlE1dXJNL21qclRJcmNUMjBNQ2JRNzhUM0pZ?=
 =?utf-8?B?OVFWcGF3T0NFVTlQVlRRWVJoOWtiR3lRUVdsbnRJVXZ2ek1uMWlFMHl2S040?=
 =?utf-8?B?WEJ3QmF2WnlJamNHM3hMYUdQSTY4dm1obWRBVDNhWDVwc2tRVy9CZ2UzWkhm?=
 =?utf-8?B?dmFSS1dIbTN2Vlh0U0NrK0ZIcGJqMjRQclZiZVlpVllxd1dkbE80ekFGa1ZC?=
 =?utf-8?B?NE9Ca0xqLzZ4d1B2NFFCa3N2dUFIOVFaL09oajg5bDlEdG50YnpUL0FiK0pQ?=
 =?utf-8?B?ayt6aVR3YnBuVWJVckhNM2Rsd2RHaFBvQk1ObGV1OVlUbWJZWDFvK0tYNHdP?=
 =?utf-8?B?VmdscHVlb3Uzanl2cWt2RGZEZjNOVzhNTFd6dG5oVHg5eFJaYThTc0lEYktv?=
 =?utf-8?B?YjhNOFBpYnE1Y2FkYjAzSVlNWkFQYTZzWHJodEh4b00xNTRncVZSRjJsR3Z1?=
 =?utf-8?B?aFRqY1ljRkpWUnpEd0ZtNVpjeWo3ejBucXVxaElBSTNBKzNXelZvU1NxbEFs?=
 =?utf-8?B?aUNDOWxBVHNZRS90eCtHS0crcllCRlZXZmdkcXg1dHp6TVN1MUpVYnJNK0ZN?=
 =?utf-8?B?MDJGVElUWFVBU29HL1B5NEFEYTZVZWVJTDhXcWJrSmc3U1UxSlVOMmVEdUZM?=
 =?utf-8?B?T01oTTJIL1Fxc2dxUmp4TWNrd0s4aUhnZ29Bd1IvRi9hUTBTWFg0M2ZLVXZn?=
 =?utf-8?B?M0FjdGJjbnJycUZSbFh2eE1razRqNW5xWlI4UUoxM2ZHQ1BaV0x6SkVybFdW?=
 =?utf-8?B?WlMxbmhpVmpLS21PSStXdFplRXRQUHVwU1kxNDdWR0RGam9samt1WnpTTUdj?=
 =?utf-8?B?ejJ4SlVUL2UxYWsvSHg0KzJ1a3ZpMDBxKytJUnYvZ0Nja0R3NXZmNmZTUk9h?=
 =?utf-8?B?MnpYWDlsc3VjanVGVDN1VFpUcm1UZWIwV0FNL1ZDQ1J6bWwvaHc2QytEcFlC?=
 =?utf-8?B?cFBNUmFkUGtzRXR3M0d0TTZ3OEhRSWFOdmxhS2xGc2l4RlZtd2JnZlVGdmlR?=
 =?utf-8?B?Sk5Cd2Z1clQrMFBZOTJRV2VGdzNaQlI1a3JnQUNyS0RIZGZZaFcyUVBYbVRU?=
 =?utf-8?Q?7pWBHv3EhoJ6PNRo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a77382-b275-4d3e-f33f-08de68772561
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 07:36:47.4023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lNCLwSLIZlDg8oLGM3B2yly7Dp9JZtON2fsY+oFTqLRoAnJoFGXcYV4rQQUUHeyE1E3t9IOi/tMEoaBn71j04nlaQFDGGpg1vqlawPW+1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7921
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 9/2/2026 10:07 am, Chen Huei Lok wrote:
> From: Naresh Kumar Ravulapalli<nareshkumar.ravulapalli@altera.com>
>
> The previous mask for MEM_TOTAL_CAPACITY_INTF was limited to 8 bits,
> which could truncate DDR size values on larger-memory systems.
>
> Update INTF_CAPACITY_GBITS_MASK to 32 bits to correctly represent
> the full capacity field according to the hardware specification.
>
> Signed-off-by: Naresh Kumar Ravulapalli<nareshkumar.ravulapalli@altera.com>
> Signed-off-by: Chen Huei Lok<chen.huei.lok@altera.com>
> ---
>   drivers/ddr/altera/iossm_mailbox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ddr/altera/iossm_mailbox.c b/drivers/ddr/altera/iossm_mailbox.c
> index 2a2f86a650e..3156cb9d4b6 100644
> --- a/drivers/ddr/altera/iossm_mailbox.c
> +++ b/drivers/ddr/altera/iossm_mailbox.c
> @@ -86,7 +86,7 @@
>   #define INTF_DDR_TYPE_MASK		GENMASK(2, 0)
>   
>   /* offset info of MEM_TOTAL_CAPACITY_INTF */
> -#define INTF_CAPACITY_GBITS_MASK	GENMASK(7, 0)
> +#define INTF_CAPACITY_GBITS_MASK	GENMASK(31, 0)
>   
>   /* offset info of ECC_ENABLE_INTF */
>   #define INTF_ECC_ENABLE_TYPE_MASK	GENMASK(1, 0)

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com> Best regards, 
Tien Fong
