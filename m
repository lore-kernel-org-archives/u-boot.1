Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2366D11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 07:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE3D84312;
	Thu, 27 Nov 2025 08:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="wtyFHu0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E56E8431B; Thu, 27 Nov 2025 08:50:28 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF2084307
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xml145C17MpxJPMzEDVOVf1rJ/e2fP1NA+xctvEApas5tS9cdqejVjLERcUwor0zQH9vf2gBUTkhCqiK0EQ4sHfcMXXDt8PRAVUTgmpirONcsX828hmDs2T5x0+cKPoVNnT4BmrcFjQacQkkpxtmSuGA2WZHawQhpGVBgSafZmtnISTPSLBm40awyJv/oEGYBwjY5Re7qd/ve/bVpWgmeI7Zl2AlROqqsJRP7KLTur7LwNhQBssicjyndK7AO+C1UvPjyE84YDo0t0jElxufRzmEoXr83h75EJgPCumhC2JlNROo0eHz+p49cX4EX8OxymO1hiV7dZsWx26tiJFo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6kWBzSRc46164QpQYykdjiCJqO/kvHRfRdOPIoHKuY=;
 b=pMxVqUCWFGp1uRv4ojEub+u20nYLa0m13ViG31D4ysRrHufiHYbTLazs7Z3tjEX8rMzbk0IWBpEpJb7g/afwCwODP+9sNVM5bZQBPgFWb7SgqAXrT8ZGBzFbkq5bNmjSkL7O+IQAFgsli8QFLCsxpyq3ehzDvPH4VQSvSVdTmSOVdgkIAY23iQSlNSCgR39AKdJ0TZXWybz+sO+dRiWSnL5nAuRxatJyYtHjIW042ua721uKN94cRdwDpx1J61OjtOlOkG7WBJfApq/mzDXIUxiwfNgrP46+yLggld5fAB6NU/rFCIlwhrIkOjZ/2qYXjYQMPU9EFYifdfKwYn6oqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6kWBzSRc46164QpQYykdjiCJqO/kvHRfRdOPIoHKuY=;
 b=wtyFHu0WDaKe9wqEQq8HN/CGXTMm0HYHwM8ms+pVskz3fdOq0z27JAbmBwQ+gML2eycuNM/qUFd12pHF1q1JW+Cm55ZdRaflg5sRtOqQCwuwyJYLar2Pa/OYMxagMW4FuJV5y5Otk5SRa5g+pI0HgPY/cR+vBaKeuCqsVXJZz8LETpJQ4znRMHreTMaRq2PMcavdAz0YleMnvSsMwBtiD+ZXRB+7fJMPklTCMw+TkXTat7QCCCS9c+nVQ788SRf0yXgyFS/ogENi81p8mFi8xlVOB3tH92kp1oP6w27e7eaQZpQBOzsUsWsitLd77E+K0+04EfgsED3p6V7tvKYOlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8740.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 07:50:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 07:50:24 +0000
Message-ID: <b977adfc-f16e-4436-91eb-8824932379af@siemens.com>
Date: Thu, 27 Nov 2025 08:50:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
 <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
 <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
 <75a890fd-48c0-439e-962d-6fa85fe67953@siemens.com>
 <CAN7C2SCSr3h6dJLEXrUEdvAHQYyEfo3jWtkUkNccSWYTv9M7fg@mail.gmail.com>
 <0c42e18e-60d7-417d-9b83-dea8ffd4a362@siemens.com>
 <CAN7C2SDH6g0PgDUsu8hEnEA4yr6z+YA5afWhK9-D7-7wBbe33A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAN7C2SDH6g0PgDUsu8hEnEA4yr6z+YA5afWhK9-D7-7wBbe33A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0013.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9460ed-ae66-4430-e4a3-08de2d899f91
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V050RktZY1dUeDVYeGpra2Zocy8vZmwweWQ1dFBHeEtxWTFtQlVKVEZLZXhX?=
 =?utf-8?B?QVBLNmJSM1JkRk40bkZQdTVRTDRNbHRPWTdMYWRmN1ZuNURQRkxSZ1VLQWNG?=
 =?utf-8?B?NUcrb2dsL3NZaW84WVFsdG1IRGpPKzBDcUloa3hxaGxFSnZWV3RZSUpuOUNL?=
 =?utf-8?B?Y1pMcGI0SHFwQytuLzgxSWZsZ1YxaWdyVzYyUFYyVE4yV0thMStheGVjdEVh?=
 =?utf-8?B?SXU5cVBzSkNqRWJrMWNiZzZYT09Xbzd0clczSm15RGNNWnYvMTl6cXRwSnBK?=
 =?utf-8?B?ZlJOaWRrcDlmRno5U0xVNDhBUnFHZS9CZlpYSkk3UlpyRzBhV3lESnFjTmJL?=
 =?utf-8?B?UTE2U2pXM1c4ZkpGVWJUblM3OXZzT20yZUtvWFJDY2h6UTlBSWxQTENvUlNG?=
 =?utf-8?B?RytvVjQrNUlqVjFSdi91ZWw1VmdiMTNKQVBob3Y5dU95VTAzSk50OUkrcFZR?=
 =?utf-8?B?TE90eUNIRzM4SVlkYVRNc2R3RVNTMGdIOFFIcVdINUMzVEZXeFJIRDM2Q1gz?=
 =?utf-8?B?MDZUVUlqNkUyQTcvY2RnUVQzQ01xc3hadnBISU5qRllTeTJBNnNpcXhKRHp6?=
 =?utf-8?B?R1NmYUhJK3RCSldJWVBTanJQREZ5RC9DYTNDZVBLUi9XaHBkdzhWNzMxc1J4?=
 =?utf-8?B?WDRyeHQwTE56bXZRVkF6M1pXRC9ZVWlWWXRSMVVmOU51VW8yS0xBK0FMQUlE?=
 =?utf-8?B?SWIwWVBnVnFCNGIyN1VrQ1diMkQybEE3a1NGcHpyZUxvSGxtUXlsMGRrMVVx?=
 =?utf-8?B?T0JMUGlSTzh5TVNlRk1VWGhMZm9ENEZqbmxMWUd4TEQ2ZkpZRGNRMVFORlgv?=
 =?utf-8?B?Wkd2WVdQeFhLSzJTQUw2WVFTMGc1T3NZbEIwblgzNGhqQVNxMkpaSzZYdnBM?=
 =?utf-8?B?RURCdGM5SytvSDVkVm50bWI4WTRLbzE0N09UYSt0ZzdTUzdNeDBnV2tQODJ2?=
 =?utf-8?B?R0J6djNsaXBNZkJITGJ3TURsVkVnUzc3T3JHUXVzcEVDQ2lOemxTRW9kaWhr?=
 =?utf-8?B?OUIvSHhuMlF3elVUR3dhOHBLblQ5aWRpMUhtbW90R09iTndmSHlnSVJHa2w1?=
 =?utf-8?B?dU11aDdFWUdFbXpxSWphd0w1U2prWHlHL2tIZDZsVGprdXJzMXZTVVNTZnAw?=
 =?utf-8?B?dWFGaGVYMlc3UldZTDZaRzhtTVBhcXhWZFhBKy9xSTlMYXQ2OFAvOTlZcFUw?=
 =?utf-8?B?SjdSb2FRU3o5bkw3Rng5Z0QwZHVLU2tUTElDYjQ4eFlxNDB1TVAxb0ZUUTVv?=
 =?utf-8?B?aEl6WjVHQzFuSWh1UFlncWFWZXA0TExhak5DZGFhOG9xazI4VDBMaC9ZY0cy?=
 =?utf-8?B?emUzNkhtQlZCWEJWQXJWUDhkVy8waWErRU9DYldONFZmeG1nQ3AzTHhnRUJr?=
 =?utf-8?B?NVBBbHREdkx1YkppaElvWFMwVy82WWZXZmZoTmY2eTJIQTRNcVFuSkdCbDRn?=
 =?utf-8?B?b2hDQmpWS3NKbis1VXd0Y3dWL3piZU9oSW9LWW5mUlhwMVROVDIvbGZ2bmYw?=
 =?utf-8?B?L2JJcjZXK0NLWWcwRCszQllrSjk1L1ZXMEYzUVdhdWRSOTZIN1ZiQzhpYnFs?=
 =?utf-8?B?ZFltVnlkVWh4L0RMTk1ENHVBcTBiYkhHR2xneEl3R1htSkZNdGZkbTczTzNv?=
 =?utf-8?B?RTNYSWVhRC96UE1YTEZKdEN6WVoxS29NeG8vRXdrVmhDaFJiSGJFV05rMXdY?=
 =?utf-8?B?L0krUmY0VnBua0c5WnJwYXBGUGFlMXZqSmlZK3FrUzNWcDIwLzJWSTRlalM4?=
 =?utf-8?B?RUdFYVJaMFhFdEZmbzFYMlNScWtWSXhKNFFnQ05RaW5yanVQcE92VWx0aGJo?=
 =?utf-8?B?d2xsUjZZWnltZUpFRXlrL0w2cVlVR2o5SXo5ekdWL0xuR3dialJ1Q0lUT1lh?=
 =?utf-8?B?MjVJcUswVTk1ckdpN0tJTVl4emRZNTJUWWlTYk1pZ0N6cUxycGRIYzdZQ01u?=
 =?utf-8?Q?HkP9LMxGpi5c2vxwp0ZK50jP0W42gMTk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDJmbFF3cGp5NFpiUDhWSlZjT0I3cmxMdGN2dXdxdVVMQmdqc2hIOE91UDFi?=
 =?utf-8?B?VmxEQy93enQxOEY3YzRadkp2K1Z2UkdJK05LaEw3RTZKOHpDYkkzUzZ2R1dJ?=
 =?utf-8?B?L3NVOXdYSzFLUk8xOVRSd1hMNEttenZKc2ZXYjNvcERrNFdjamhMbHZ1RzhS?=
 =?utf-8?B?UGRvUDBQUzV6QWU4Vkl5N1E5TnZUb0ZnWW5peDNHMnhuWDdlbXllMDdKMlJ3?=
 =?utf-8?B?WkgrNk9PSmpNSmNlOVVja2EzRmFGU2hodzRBZnB1TGZ0ZXV3eVBQZUxmOEJa?=
 =?utf-8?B?R00xZldGNVlEeUVuaWk2ejNBUFVhS3REeDBva1dzNDA1U3E2cjllNldhbGFF?=
 =?utf-8?B?S2pxMklBeTNjakhzNkU0Vk1SRysvS3l5Qm1UUVRjZXVKTmtQZ3BwYzlFR1ls?=
 =?utf-8?B?ZndUUzhDUVVqL2JHay9JN2FheHZ2U0d1eDNGQy8rZnZxK1RBcXREL1NzYUMy?=
 =?utf-8?B?ZXFzVWFVQXZGTEE4N0cyK2ZOcGNycDlvUmtIUzJWNlZwV3cycUNXZC82WGMy?=
 =?utf-8?B?RExMZTRhWUZ0bjU0UFVVZnJjYThPVWdwdDQyZ2UzR1o3dUtJYlgwMzhJa2ht?=
 =?utf-8?B?TWhwb00ydWhVMk9mTjFJbzlubkhNZTEzR2RLVXBMTHBHSFM3QkllM3ltVDMz?=
 =?utf-8?B?TjlXVC8vSnZPc2Rsc1JXUDV4bkhtQmRIZ1FWZ0pmOHJaYm1PTHIwRW5WYTRC?=
 =?utf-8?B?czdtU1ZxMVQvSzg3bVJSUmFpTWZRRVNaMXdOeW5ORVFCTkRscTZSV2lJbGgr?=
 =?utf-8?B?V0FGQjVDcHRXRUN0ckw3b1pHSlJINmF0V1hIZ09wU0I5K0hNL2gyS2w0OTJu?=
 =?utf-8?B?TUF5ZndqSTJDcmdBaUNuSFFDWlpOVDgvOHNCSTBuYVR5bzB1UXFqQURrMFlJ?=
 =?utf-8?B?c2NKWTFLL2t3NXROdmJFSzdvTk5CUHdOUCtJbG80a0tpYkxCRThkSVRmSmtl?=
 =?utf-8?B?YkJNbTBlUjhmTEZiZUl3YS9IeUYrbkhDb2ZUWUIvL2VQUUc5dmRBZTk0MkZp?=
 =?utf-8?B?RzBOaW0ybkN0alArN0hxV09TdmlURmdDOWE4VnZpb1cxRVpxZXpOdHVWQXhi?=
 =?utf-8?B?bXc4RzlSU09oeVdYSDJsWHVmQmxhaWVVM0NpTm9GeXhqQ3lZdUsvTU0rUmgx?=
 =?utf-8?B?QjhSemgveEwyOFhhN3hJcFlzTE8ra0ZXblVqSVh2ZmxjZEx5M1oydm11VGpV?=
 =?utf-8?B?Q1YxaU1nbVFsMEJoTU9nSmI1dmpOSi9UQ0RMT3phdWVMQk01eERidEF2TVJR?=
 =?utf-8?B?cENOYi8zaGxUTzJqQlNXdGxaZEE4eWQvR1Z1UXljclFjWWRIUlh1QUJjdS8v?=
 =?utf-8?B?TU1jOVBnZ2docjBWYTljdXcxOVF0TkZWWUFNZjVRS1BTbjR1SVd4NHJ5QTZt?=
 =?utf-8?B?Y2UrdzVVbjAvc1pUbS9XeDcrRFMvVDdKNUJJNVZPOS9TR2dycTlZUnJuMmVD?=
 =?utf-8?B?Q3NIaGdUZVJKNGFWM211Z1NtbnZ1TDY3dlpydTRSV0RFbDVJcDdnS2o0WWFM?=
 =?utf-8?B?WmFySVpBVEpQQ2g4bWtQV3daaFJZRFBqREtyYWl1Z3I2YVFFWEhUbzRqekVn?=
 =?utf-8?B?dzRUVUZUK3hIZ3JKMEUreGM4LzhJSm5KQlFSMHphdE5ZcE1qeTZGcVZaYTJI?=
 =?utf-8?B?c1RFUCtMTlQrSEgvY0ZRd0pvMlc4SFZyQ094Y3FqaGpxZG0xb1F5dWc4RllF?=
 =?utf-8?B?b0xGS3pMQXF6a212MnRUSG1iRkxRNVBOT2t2dXk5UWhMK2FJam8rU3ZHM1FN?=
 =?utf-8?B?TVdoTGpmMjFabzlHaVRNRUZzbU5TTjlLMmlRc0o2UHozLzlQTlIwdUM5TXQw?=
 =?utf-8?B?Ky9pWUdWdy9VSXNkMExOSTJyTnc2UklValpBNWFmOXZISTFoamlGamwxTVJR?=
 =?utf-8?B?KzRmMUR6Y0FnNGNnM01OSFA2Ym4yMTlHVkg5YjBYQlR0SitCY2lkTzdnSU1V?=
 =?utf-8?B?b0NVMmFoWmZocUc4RkEzUXZMUk1VRDBmdCs4QUhrMTIvL3ZZT200VU5mdWpF?=
 =?utf-8?B?Zm5nM3VmNTkrcWVCYURid2NER3ZWcUNOUjdxNWFQNWY0T0xHY1Q1VGVwSjJx?=
 =?utf-8?B?S3kzbnlNYldNdjRGcjFXbytVV0l2OGFaL01GYWp1K0xDTVRuVW1XWWNpaFRo?=
 =?utf-8?B?Mkg5YmgvTzRPdHdQQXJMV1ZRZGVQZVdwcTdLL2wzV2VpTjUxeHpPV0FFV0Qy?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9460ed-ae66-4430-e4a3-08de2d899f91
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 07:50:24.5267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JwbKRrMCDGrHabXIVZelBNHGfEA0ACtbMPKXdbIRBgjzLVBwN2CzHCa66jhk2BJyz6UDKlHXpToaDMMkJCFzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8740
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

On 27.11.25 08:39, Sune Brian wrote:
>> It is ok to work around current issues in upstream, but we still need to
>> fix raw mode loading - or drop it from the tree if it has no value
>> anymore (not my decision).
>>
>> Jan
> 
> No this is not a work around it is SPL seeking change from first place.
> From the beginning, u-boot-with-spl.sfp is not supposed to exist
> after 2025.05 or 2025.07 I forgot when the seek change from combine
> to one out of three.
> 
> raw mode loading works, just combining two is no longer an option from
> first place. My understanding as such.
> 
> I don;t think you had encountered SPL not beginning printout aka load.
> 

I would recommend studying my raw-mode loading patches without looking
too closely at your own setup again. You should be able to spot the bugs
I try to fix there.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
