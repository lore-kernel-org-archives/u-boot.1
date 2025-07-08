Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A210EC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 15:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC48832F0;
	Tue,  8 Jul 2025 17:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=wdc.com header.i=@wdc.com header.b="kJK+hOJ9";
	dkim=pass (1024-bit key; unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mcOsIk8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 228F18331D; Tue,  8 Jul 2025 16:16:37 +0200 (CEST)
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD84383297
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 16:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=27714dd71=Johannes.Thumshirn@wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1751984195; x=1783520195;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KmrjSqiV+cQ1rYsBdb1iXIMldcJ/wsBuOH5vMwIQiBw=;
 b=kJK+hOJ9xiuE/B2BUeWIELQE6HOqYxLyzSAhY/FTGoDAKBX6yl30Ems2
 fGS8W3yw4HUlPdwCSMASLRtnRFpPVHPnIuyDWyY3tIk/7BmfyixfNOvJd
 5qQgLPIyvVNGsG+nJGwKpFIgn5CpaCCKMxwFMsfTcvyrmhBcgFSA9Rz92
 uNwsGzu5k78GMSmd9YVO8NagJHTOlJ+S7PB0F7sUEFBblOSGYt3ZKQhO5
 +mpVWhFrrCdAzyjZZ2wJicvt9FWpTGJoPcwVq/NRkGdquoBZN/R4zVq/t
 Y1M5FRBnyyY+cKnh9PoHZY1CPFpI4RAyZkIEXZhFcRZ5X5vR14M2cfgKy Q==;
X-CSE-ConnectionGUID: vl30QsNuQv+uGmI8hfAf+w==
X-CSE-MsgGUID: 45vI/5dvTcKYMSh0G22BTw==
X-IronPort-AV: E=Sophos;i="6.16,297,1744041600"; d="scan'208";a="86765857"
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.88])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2025 22:16:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCKvrL/xlf6lRw9C1qiHu8D4aBmFZUWpB/SYVT3A4hKnHwb9azSOeI8S9fufTiy0x3np5+TCjaB11QvEA0w9HwLARHYjuHnyhfJAtZMQevo1oUZx3rUT6KXQe/cduRuNQKoxBHidWSw8InxwNF0YZhcaViBgnGMx/+GbnTrn3O09OR3EUS0J6c0ljg0P/NJ4g4Y2mfjwH9f1M12WG8/DQ/R8BfMUz4464H2eC/WwMKxAWhrx41QRw8KJGJEVYHJ74i0MtV5bgaJaAmb6D5N2FTFaMgp1z7D/YJQR68qj3Oao3gA2fgSgY3ivKncxtl5Kja+CabPpp/SthOsCdTgvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmrjSqiV+cQ1rYsBdb1iXIMldcJ/wsBuOH5vMwIQiBw=;
 b=mdRAKfS6cl2xwTR7E+3FxQh1W9J0NJF/WxYQ7bo4WIBovNTevEi9llG41tbYt6zSvz5rMaL+glo7ew6ZKru/TY4INhZVql0CKA8YMZFt1Xjpe5w6Vhu4vkPN5o9C5+xZkN6f1FFt15Qv+8AE3s8rYP6gX+WR3hx58MpWGW6aRNSrbaDlJc0x6qDWSWd20Y2PqLoSzNRaN0HTU5hkM74cMOfeG1SyNodFxU1AOI+9vCCJarXlPvV4uwrJbXTpdX/fCDhNOtICEiw+j0ZyQYy8MPo6vFvrA0Yp5rOpY5m/W21D2f4rziWzJkxAIsaRB2405WaUCoHLrDHPEqaUeU03vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmrjSqiV+cQ1rYsBdb1iXIMldcJ/wsBuOH5vMwIQiBw=;
 b=mcOsIk8fpEHTSi5zMtxKNYq1Ug0F+FgfdTEGYVaQLhp610+3ki7jBYNh94PvYP7QFqQOsvldGsieaoLoXqjoVk8SZTCm1jwlP00i/pumE+v9AaIRQUVwxPRah/mU358RMyxgmXLdG1EGChlfvLcNGBo68VcVxk/dE6q4DedSOuM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7865.namprd04.prod.outlook.com (2603:10b6:510:d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 14:16:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 14:16:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, =?utf-8?B?TWFyZWsgQmVow7pu?=
 <kabel@kernel.org>, WenRuo Qu <wqu@suse.com>, Tom Rini <trini@konsulko.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] fs: btrfs: Do not free multi when guaranteed to be NULL
Thread-Topic: [PATCH] fs: btrfs: Do not free multi when guaranteed to be NULL
Thread-Index: AQHb7/xavzeiQRFefEKP419udcMFbLQoRdKA
Date: Tue, 8 Jul 2025 14:16:29 +0000
Message-ID: <8780edf7-e89e-424c-8770-2d45ab8849d4@wdc.com>
References: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
In-Reply-To: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7865:EE_
x-ms-office365-filtering-correlation-id: 399a313b-2770-464f-eed3-08ddbe2a088c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c0FsMzBMRERyQzdJZVdjV05wMmE0cVdZdjZkbnJXQ21tbk9Md3JWbGh4Z2xm?=
 =?utf-8?B?S3FoRnFTa2k4UHRQY21ZL0NNWE02WXczWlFHYmN3bDcwcEU2cVNnajl3RW8v?=
 =?utf-8?B?dEZkb1ZzRDc1UWE3eHNEMmhWaENMMGRXSG5mRTkxK1pzMk5EdFR5MDQ4R0JV?=
 =?utf-8?B?MDZvQnRZZUo4VWpya09PYWJXRG1yUnp0R1QvWVpvVTRFZEVpSHdtZnI1OVNP?=
 =?utf-8?B?S1YrWkNVMHBQUFRHc01OZGxTV2pSU05lbi9TNGdOSW8yWGk2M3RhTDl3ejRz?=
 =?utf-8?B?YktrczlzN1pIQy9YTXAyNlMxVnVmL2FXSThKMVRGNkdrUjNWUHhpUDlCbUZ4?=
 =?utf-8?B?eHVWRll0M2JXN3dxNTgwSWF0d0N4WmtUV0c0QjNzalhPS25qMWpYN01OZjB0?=
 =?utf-8?B?bmNiWEd4N2xWR2QxOGU1MTg3N0FDVi9yTlFNY2hKRUJ2ejZyUmE2TVRtMG8y?=
 =?utf-8?B?RXk4ckNlWEk5a3NGUjJ1WEdGQ3pMOXVoRGg1NW9saWZGMUZrV2VSV2EzWXU4?=
 =?utf-8?B?OGViZzE0Z3VJYUJRWE9tRW1FTWFhOGgra2wyZzhXN0Y5UytBWkREOVVoT0o0?=
 =?utf-8?B?R1hDMjBKTnJvT3p4WXhhYmlaTml5YnUvVjRCY21KK29vTVZPK1M4YVB2bFY2?=
 =?utf-8?B?aGpMZWdhTFZQejBuT0M1dzdNMjZpdE5SdXM2aHVPUGxtOG1NQ2pzMTFQNHNE?=
 =?utf-8?B?MS92QlVIb0dVamlFTC9KN2h4a0o2MmQ1RDVqYTZMWXh5UUppMW11TXhESFh4?=
 =?utf-8?B?ZHNJY1o5eTJWZEZtZHRWWUZtZnp3c2JEMFVYRmd2T0dZaWNLWGJ3cmF3aUZk?=
 =?utf-8?B?NnBrN0ZrMW5mQmhxZlRhNnQvNTVLU2tLclRmcjlYem5IeWxab2Z3MjRkZ1Nx?=
 =?utf-8?B?UFpuM0NsWVE2ZFAvS2FXdHd5Yk8rWGxLdDQrYW1lakRLRG5sR3J5K09Pb2RD?=
 =?utf-8?B?aVFqVWpEUWt0ODhjcHdnWTZXUWJETmEwazMxNHlEaThTUEtiMFdic1FkSkFN?=
 =?utf-8?B?WTNWb01QRHlIdUM1aWpEVEJBbklVNytOaHpHZVdOM2o1ZjNjcEwwU1NSbUR6?=
 =?utf-8?B?aGRKNFA0WXkwZmFLSnJVQUJYWk1pSlFoWld1NVo4eFNiR1huTytDcTJXZjdE?=
 =?utf-8?B?bW5oY3NTKzM3U3NkVTJHUTBaQVJPYktZaUhBb1ptbitKOXhlbjJYOFZlWUhH?=
 =?utf-8?B?RlR1aC9rc3Y1bEQ2d0RNTU96Z29pZklOeVRMNW51Mkdxc0cramdxQUgvNStM?=
 =?utf-8?B?Zkh2bERaZWozOUlRQUpQOTZZc1pkMnJIM0V0L09pL2RPWHRqS0hxeGVlUGMv?=
 =?utf-8?B?YURmU2hXemJldHp6WnBDelZJbXNsQ2xtd1ZoMmErM0RiOFQxSzJNVzZMNmcy?=
 =?utf-8?B?dU43eXAvQzBuYU1ZbzRXeE9JQUk4VzVNUVN6NWRKSndBbzl4bDBBRU0yQnVK?=
 =?utf-8?B?VjNHUWVZZmllSit5R1VWSzlWWFBMZHpHd0pwOG5XczZFVW9QajBWU0RwNXZs?=
 =?utf-8?B?UEtzdWp2a0NPOWdRbzBJeDNVODlHWEtJcmM0cWNnOUxuUWZuRVIzV2tYU2lV?=
 =?utf-8?B?TUloQ0NMUEhOYVMvblpVVFhVeWt6YkI2ZE14UUFpYTlSSTBwNWJRdml5WHVM?=
 =?utf-8?B?ajU2Q2ozZG9rTzIrSHdWOTJmSzlzZlZ3WHJoWUNKc3hWTzRiK2FrRWp1RndI?=
 =?utf-8?B?WEZ2R0FzWVF6RDg4bGpuWmE0SzBWSEhDZlNMQ0RnZmhtVG5kcDNKbFU4SEpi?=
 =?utf-8?B?MXdHa1oxN1p2YStVUEMyTTJjT0dWWmE5NUU0OHJKanNjZVRlVnl1a24raFFU?=
 =?utf-8?B?UnZQdG5kSUl3emFvNVBUKytvbFNNUDZpYUVub0RiVUtkWGRMTXFxTzR4YlBT?=
 =?utf-8?B?ZWxZUm1FbGZjb3g3VWdGVVZNWCtVbkorYXJ5cjFyYjZQZ1ppWWNVYmliQjYz?=
 =?utf-8?B?NVpZNG1oL1J4MkpTSUNVdEdSbmwydThFWSt6VWltWm5Bbnp0YjZvbk1WdUxM?=
 =?utf-8?B?YSt6eDY4cHNnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7416.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elNpREgxV015ZEVYbkpaSkt6NEtHeFhXQXg5UGExNjlENXh3aEE5dld5dnpQ?=
 =?utf-8?B?c21nZzFuR2c3ZWM2ejA1RzM5dVVWSHFBVlh6Tll4MVB6REFRN21QOFV5ZUZs?=
 =?utf-8?B?VDd4Qk5Ya0NZUkJBWjJaWWI3UGJhZ3JxS2gyYmkvTUNtNm9wMlB1YlhWbFhE?=
 =?utf-8?B?WHR2YURBYWlaUWtDT0hQdG5mZFlaUlFLOHpma1lucTBPenJQRS9kcXBzN1Zo?=
 =?utf-8?B?Nm1mWnJ3YXRJR3pSbVliV0JGSFF5M01HeCs4bWZRZmVJTDZXUWo0UDNBT0JU?=
 =?utf-8?B?RmV0bFdYeVgzNGRzTFJxS1lKQ0I5SnhnTXVzMEsvYTdhSVducU9XYWw4eEtZ?=
 =?utf-8?B?NmhXaC9rbURkWVl4RDNmWUtIS2FESDRwQ0Q2eTZtN2xUdnZnN0hMZHJFaGV1?=
 =?utf-8?B?dU9EUkFIcnNFeG1GbVoydllmR0NKVDRNM0krRjZUZHhtNDRGcy9HN0xBSWgz?=
 =?utf-8?B?OFQvWmc4cTF6R0U1NkV3M1Vqc3R5eWE2Y2lyQ3FaTG9kY0xMV0JDUXVjSGI5?=
 =?utf-8?B?YS9xQ3hBZFBFVEkyZ2xoU0I4TG9pK1MydFBlZnJBOUNSU3k5ZUxmMXdpdGVt?=
 =?utf-8?B?dktqNXRSS2prR3JQU21nMUZDWXFqaW5DVUN3RnF4YU1OOTlVbG5uUnlScElN?=
 =?utf-8?B?QmdUZFlaWi81eThxUGw0amp0d3l0aldrUjFOUHkxUE15SmFhRXNsRUZvZzcv?=
 =?utf-8?B?bUZtdExxSGFmaS9GeEhtQVhtQ0RaNzd1eDY3eXhxZHBDMUh0SHlrWUx5MlQz?=
 =?utf-8?B?eVVmOUU3VzFsNVZyRmsyQlVpREQxb2xwV0p2V0VjS3hUOTZwNlFPOC9Wd01o?=
 =?utf-8?B?MnRaREU1OFF1MDB1MmJGSFJ3YnllRnByajlqeURoM0VjNDErUHZ0cW9rS0hL?=
 =?utf-8?B?L2pUaFRaZnA5Mi8vSEdZNTVlam5vbmp3NU1LbjFWVVBQeFdnblZBWW5YZjI2?=
 =?utf-8?B?N3hoUHZCamhUSHVXQ0R4VC81YWlpTWVCbHp6UXNxU3JMVENjQ3l3VEZMa283?=
 =?utf-8?B?S1hFWUo3TjIxZXRObkZleEVUZFk4bndlVS9RbE1pdWE3NDc5c09mSmtybnJZ?=
 =?utf-8?B?UG13WWV4TmxYcnM3aWloM1ViTkJKeE5lRklZaURtTGRGZmVSaUIvWWE1TFRW?=
 =?utf-8?B?V21sRjFSeEFzRVlCSUJ0K0pIVEgyMjdrRkFQa1B1U0t0RG9OTGJ6UVJOaFBl?=
 =?utf-8?B?cUZHSDFRb0FpUkZjeElqZDlUdVdORW1nODVQWE9QQnBKSnhHYzhYMnhzYkJ4?=
 =?utf-8?B?QjdESWpCeW9tcEV0WHJmY2NlZmxnZWlSYi9NemlZd1lkUXl5TmQ1dlVrMUE2?=
 =?utf-8?B?T1pOVU9BMVJGbFpSazhzbFRuRnRiT1lacHBzckJyTlJDcEVIUStoaTZZN2pM?=
 =?utf-8?B?Uk5yWE95aE9qS1ZiaTJreTdaUFhTeVVzQzBPUTFCMVR2US9PN3lKaW1vdmZZ?=
 =?utf-8?B?TlNGenZHZ3FZVmFtcjNJRnhnMDRtbjdnREVOODVYQlk4UGxTcnJrTWp1SlE3?=
 =?utf-8?B?alU1V1hsM09BUXFDQzBRSHB3TFBnMTczK25QazNDRzdjQlRQT3VBbzZjWkdM?=
 =?utf-8?B?VHFCYUx5TURWYjVHK0xKQk5iWm5WNFFiZVFZQTJUeXE4QTNLQVhqM2x6cG9T?=
 =?utf-8?B?R0JCQWtSa3VxdXVHZkZRd1BiYkRGOUErSUUvam9RMHdZVGhFeUpIZ1NLMld4?=
 =?utf-8?B?YkNqVUpIbXhJdnN5b0tDZC9PSUFRb2Z6bXRJai9Eb0lkVlFyVS9DMllFRHRq?=
 =?utf-8?B?MU1VUDZqczlKWU42YXdpOE1iS2c2Q3JFQ2l3RjlxZ3ZLd3pYV3VWWDBuMWtv?=
 =?utf-8?B?SmluTCtnMlZ6NmYwb1NVQ0ZoZkRXdmdJMFltSHBkbSs3SDc2TXpONzVvZGxw?=
 =?utf-8?B?eUJrRFVBaUVYWi90VUFBaFRDWGs2ckNldXc2cHJwTDRTNTZhSDV2cURneXlr?=
 =?utf-8?B?TE5VOEdSb2RHREhKenRwVW92WEIyRnRYMURUbERiUEkvT2FPR0JEbkVpdURX?=
 =?utf-8?B?ZjBjQWlzVEFnVWVMWE9LQkxaMkkwUUxzOUh1WFdOUXdjc01KYVc3YVVUNjV5?=
 =?utf-8?B?b0tBdnRHbmZoTm1YUGVqMzh4VXBoMXJZL0pGSDRLYjFHWjFmRmpLVmVoWnB6?=
 =?utf-8?B?WDN1YlRUdnFJRTZnUWdSTXA5ekx3Q0VVL0syMWc3MHQ4eDdKQm05Ym1sV29B?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59A905BA2D672E42B47170075880E132@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: huAsfi8T3VRhZxxv+Acky68FBHB/XlxsU3z3j+HJJ+XejVj7oXBVpcN6FjDo/gyi7W9M/a38Rb7hRGyCpWtrCCbBKyAKHe1cbfxRMbZsVSAQ316ZUtfeIS7K+8Bn2rkuP96y/cLXgIXL0gejpxF+Qi2Vk1rOUBAvEcGI8IBYPj/5uO1pu6xiEPWf2HmHnK95FIiRoo4yH4+gnorF+sHEoLQ04VJRxLQScbaz4N0QGggi/q3BdcASR+WuiAKscaCLAS3bn0/6+D1NaFvdWARs9Xw/fH/S2GqhvqvTShpfzmGu5eWMA8UkwsHhVmX2svPzXwGm1QmXDAvbANRwBRvaUfgDhpkXG5e59yE/MNiZP9IZr7u+hDYp+q03PlDiPowcxJFlv1IpbXyop4mMHotD9HUeIUloQtKjrf6E1s3KiTrGaUYND1nOKBhDzEi+oVICCV+mLyWYn1k787mENcn1b/Px5tyn1um0yeEWaQlafIrXfVacwJouTSS+WijpwnMXzQqGT5hxET14w32E/lIhUhe9LwS69eZNQcZgN3ipMIwB5oRDgetanluNV4OMGWO9bAyzzBI6wFJd4u5rC3ltwhIVuWn59N38cICHMKVcALeal+fc8pF5PBj0JybvuLeQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399a313b-2770-464f-eed3-08ddbe2a088c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 14:16:29.7334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbmHUK/3zDasDfJaw0WfgkbSgRZoSBfj5tdWPUzCgLbBEAMiCfjEceDs9rRjFlyEEyNgAc+NYrcYXXKKXlbqbXjkCxRyzzmbgiG19R/7O6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7865
X-Mailman-Approved-At: Tue, 08 Jul 2025 17:01:18 +0200
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

T24gMDguMDcuMjUgMTM6MzUsIEFuZHJldyBHb29kYm9keSB3cm90ZToNCj4gbXVsdGkgaXMgZ3Vh
cmFudGVlZCB0byBiZSBOVUxMIGluIHRoZSBmaXJzdCB0d28gZXJyb3IgZXhpdCBwYXRocyBzbyB0
aGUNCj4gYXR0ZW1wdCB0byBmcmVlIGl0IGlzIG5vdCBuZWVkZWQuIFJlbW92ZSB0aG9zZSBjYWxs
cy4NCj4gDQo+IFRoaXMgaXNzdWUgZm91bmQgYnkgU21hdGNoLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQW5kcmV3IEdvb2Rib2R5IDxhbmRyZXcuZ29vZGJvZHlAbGluYXJvLm9yZz4NCj4gLS0tDQo+
ICAgZnMvYnRyZnMvdm9sdW1lcy5jIHwgMiAtLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3ZvbHVtZXMuYyBiL2ZzL2J0cmZz
L3ZvbHVtZXMuYw0KPiBpbmRleCA1NzI2OTgxYjE5Yy4uNzFiMGI1NWI5YzYgMTAwNjQ0DQo+IC0t
LSBhL2ZzL2J0cmZzL3ZvbHVtZXMuYw0KPiArKysgYi9mcy9idHJmcy92b2x1bWVzLmMNCj4gQEAg
LTk3MiwxMiArOTcyLDEwIEBAIGludCBfX2J0cmZzX21hcF9ibG9jayhzdHJ1Y3QgYnRyZnNfZnNf
aW5mbyAqZnNfaW5mbywgaW50IHJ3LA0KPiAgIGFnYWluOg0KPiAgIAljZSA9IHNlYXJjaF9jYWNo
ZV9leHRlbnQoJm1hcF90cmVlLT5jYWNoZV90cmVlLCBsb2dpY2FsKTsNCj4gICAJaWYgKCFjZSkg
ew0KPiAtCQlrZnJlZShtdWx0aSk7DQo+ICAgCQkqbGVuZ3RoID0gKHU2NCktMTsNCj4gICAJCXJl
dHVybiAtRU5PRU5UOw0KPiAgIAl9DQo+ICAgCWlmIChjZS0+c3RhcnQgPiBsb2dpY2FsKSB7DQo+
IC0JCWtmcmVlKG11bHRpKTsNCj4gICAJCSpsZW5ndGggPSBjZS0+c3RhcnQgLSBsb2dpY2FsOw0K
PiAgIAkJcmV0dXJuIC1FTk9FTlQ7DQoNCldoYXQgdHJlZSBhcmUgeW91IHdvcmtpbmcgYWdhaW5z
dD8gX19idHJmc19tYXBfYmxvY2soKSBpcyAiZ29uZSIgc2luY2UNCmNkNGVmZDIxMGVkZiAoImJ0
cmZzOiByZW5hbWUgX19idHJmc19tYXBfYmxvY2sgdG8gYnRyZnNfbWFwX2Jsb2NrIikgDQp3aGlj
aCBpcyBtb3JlIHRoYW4gdHdvIHllYXJzIG9sZC4NCg==
