Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF7ECFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 07:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F90784307;
	Thu, 27 Nov 2025 08:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="kLxTEiso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E430A8430A; Thu, 27 Nov 2025 08:42:56 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6EF83923
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vH/bhjTXwvJGPavSqQga+MTa2SUx1seV8aJV2QQ3/u3CXz50XbXY+Hxj8tVx9ihtGypAC6t0hUZ2lq/3QrWOCojtEEFBihmT14aKoEwyid0DIpUtB2lEey3SsXZxg0QFqBHOeCaDL6UoJll6O/sT8kMiClkBXzwV9V1Wp90vV4bwshJk4QZAoX33IE8FZxbRabsBGIJpexN/EhyPrggqIgaLnq0RvBnLRJb5EqUIHl/JRoY746vPkPn1bABkFkzQiLPHke3FXZdetlgcWlxnKkS8J72Z0/ekJBkuS4TvHI2nuu/HWL/wseehVf1zysrHYJJrjxDIjWYDh2lRczqLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXLREVvRP4ycwQYr83jsoHigpQbNgoUsmRmHEnUCG6I=;
 b=r0w5k6hVBFakJO65NRrCDLVwvJnBpL9f4/crXAh7typZO/JPT9JlFJlt53RTxox31HclUS2PZL/t94EbbjaRrbo+NtG+MnfmkWqjkcU5lGf0fCR2694MSwKJNQ4gbd3Bl9x/FRzfLS48LuSi6I8yQFVE9AYtrHhSB/FQWLJ2KfiNeqKPVvV1fKzD6YL7/cDvbWmV/dxiToftwGm6vavSRTkuH7our8fD7fz1RsfrDBBebzEsvjq2aZdibtRthCXPJjShWrn+f1ydZ+0p8h7lENZ6iuixTL/SfVkfOJceR7ZDlh+lpqVB+xCt2+eFvn4QiTonx/JdH1m4rpfDy/zaCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXLREVvRP4ycwQYr83jsoHigpQbNgoUsmRmHEnUCG6I=;
 b=kLxTEisoBz+8tQUStwKrQ+3PNlNIarqYFr3HH0O4V3kb7zd6lJAPO20U6lhJIJtBgYej9ZqDkxWEwMHvWVg4giywcQ/V7QuupU0d+uGuL3UwKzAhzOBTLphKYLSqT4hSnp/gWNun7HgJFu4GZW/g0hMAA68y9P/Z7p07AcsByvDsvKEheD9oJADCCCyIK5He4UcWIauUqbbPq2ek7C2eNc94H+EfioRv3pVkKSSx4YEQ3Ru6E29Qy0VxAjFIOfyE8tqM740YhrrzvyHH8cBiakzGlUhvLUI8Z8Ivsm2TgPZlCWeArFoMKJnvYePgRsJaiKFskELqswAwnjgv6wfaRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 07:42:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 07:42:53 +0000
Message-ID: <7b563e58-a4d4-42ef-bbec-87af97b1ac95@siemens.com>
Date: Thu, 27 Nov 2025 08:42:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: Marek Vasut <marek.vasut@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e5af0e26-6b84-4321-bb26-c6848d233f4a@mailbox.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e5af0e26-6b84-4321-bb26-c6848d233f4a@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: ef21bb51-cabd-4a11-821f-08de2d88928e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHVIY25RdkNZcDlhQWFuQmdLekpxdjdSN0tPeHJZOGRqUzdxYzBCb3B6cGZC?=
 =?utf-8?B?anpMMXZUOXBxZFFGSzBsdTZEaExBZlZ2MWh6WGZmdmVhUjVjRENLRUErN0h1?=
 =?utf-8?B?OWgzMWcrdTRqcWphYndIWmdkamVKNHpveEY3WmdncEd4WGtBZjBmY0VSV2lK?=
 =?utf-8?B?Q1RNT3I5cElMT0hJaThSQXh2cWdscHY3YlFRMytSclJJWStUMGgzTHRLQUNB?=
 =?utf-8?B?R2s5YmhBek9jOXd0VWd2UlNYc2RycW1XdEFTbkg5cHF4QmVUak9rTWR0a2kv?=
 =?utf-8?B?bXQwSk5vS2MzWTJJckkwQzkyOGg3eFplNHFEQnVBNHlWN2FyWHdDa2drbGlF?=
 =?utf-8?B?ZDhoN3dxV2g1cDMydkhvMFlUbzNjeUNpWnh1eHFVd3BBcTFsbS9mclk5Z0w5?=
 =?utf-8?B?NTZwMDNxMTNuTEVJQTd3Z1lFZ2RFV3RvMkdUalBpRktNUjBQTThxc1lrT2c0?=
 =?utf-8?B?aWp4eTlqcEJVdG9CV2JEOS9rVGJuaVk3ck5wVmtiMnMyQTZWQU83Sm43dU1R?=
 =?utf-8?B?YkhFQ3FOeEhvRXY3RWVuL0JhQWpJZkVKODdXbkJVZjFhZkgzL3RtVWs3M1lM?=
 =?utf-8?B?N2NYQ0laZEt0TllXUnY4cFJXbFVveDNnQ2tEcHI1bVNpS08yZisvdktmY0hQ?=
 =?utf-8?B?NDZ0YUJvRkJNVzBoWXE5MWY1QitBeEV0a0VQcWZITWFaaW1JcUl4K3dINk1I?=
 =?utf-8?B?WTZ4RFE3dG5zdXNBRG1KTHV5WjRxWVNpaW52SCszREJRd0Q3SzhJM015REM2?=
 =?utf-8?B?dnE1YjJpTmFWUzJOSXAvR2NvNUZnUVJGMDg3bENhYVBLUU93YWxBaVY0bzBh?=
 =?utf-8?B?T3l4eEhWZURIbUZnWkRJOUhaL1hlRkMvVTk3UWxTRkZXRnVlNTB5YzBlU095?=
 =?utf-8?B?RE9Hejh5aHNRN1BNYlljaTRDVFJ0cjB3WDVDSUdEUEw2WldiR2NnVW1adGJ0?=
 =?utf-8?B?Tm1HRDEwN0NOMGV3ZXlrOFQxRURGdDlRQlBQbFRCRVJqdEtYaGVsTGl6MHZ0?=
 =?utf-8?B?RVpXLytOR0x4bWRpeDIvVnhuUkt1dmp5T3duUTVSMEtaSHZwVGM4eWVrdS9P?=
 =?utf-8?B?N2FLQTBkYXBFSkdzaW5iQSs0R1M5aXJEakcvc1grK0RnWFpZTU5wQUppNTlU?=
 =?utf-8?B?M2p4bTNSK2wyUndFeE5GdzBEVndqVDR4SVUwZWZOSEpwSTY3Q2hqaTlCM29U?=
 =?utf-8?B?cDhsRFVoaFJqdzkwU090NG9FTXd5cExjdnNlb0poWk1qa2NrZE4wK1BwNEdM?=
 =?utf-8?B?eSs3V0ttVy9nSmxoT2NNVHBVVUluZ3RjY2laN29xN29RV1JZYkdVaERZS0o5?=
 =?utf-8?B?NWI0YWdaeXFWMWVwK0dZM0c2WUFKeVVUVkVldjN6QWY1emc3L1lsVk1UbkVh?=
 =?utf-8?B?Z1ZwK3o1ZjlTSXVmL3Y3MVZKWHpMRkp1YmZlV0pIUzV5Yi9BL3VmT24wWHJ2?=
 =?utf-8?B?QnVTVDFyTXg4ZzYrMThvcEduVWJxWFlwQm9BdjNsSG9DSC9IWW1VQUZrRzBm?=
 =?utf-8?B?OW5vUWxueGJqaExOMEVLbUc0U2R3M21BUG1MTjhZb2hzNit4NW41YytNZkda?=
 =?utf-8?B?RG4ybUNSdHJvVlZJV1Qvb3VxOEhFSjNBZDQ5NFRmT0NEaGQvQVBYd2hLZWVm?=
 =?utf-8?B?SUdwaC9zYkpHb2V5ZW15YkhEQmFyYmhpRkUwL0ZtdzVwL3pmU1BGaDVmSjZl?=
 =?utf-8?B?dzIwMWxvWXhhWXlUL2JsM1pQa1ljSHpLb2pZd2NhMU81NFZTTElaekZwOFQ1?=
 =?utf-8?B?TEVMV0pOWW4vc2FPdThzYTl0YmtKQTNlNkdNakoyK1N6M21adm5WcWpqcTFT?=
 =?utf-8?B?TEFLbk5PZHl4UTlkTUdCYncyYkY1OG5qelRVVy9KaUhVdkczNzJ0ZndzeXdM?=
 =?utf-8?B?eG9RZ25GMCtFeEtxd2JYbldXdVdPb3I3Y1ZYTnQ3ZmpDdUVnc0lFQkgraGww?=
 =?utf-8?Q?JjRMm2RVYVsbkN/h/bF4826hB9xDkTGQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk1hYUJlTXhUU1BFMEFUT0xsUTlHblovWkxWMXRnQzB2bVhNL0RWQ0NaQ25H?=
 =?utf-8?B?aktDWXJrRFhpdzlyZ0ErdUJaekQ4OEJlZFpTVnFQVFB6cU9nSHpGZDR0Qnll?=
 =?utf-8?B?QVg5RDZ4eW1ueGpxUnpMS01Oazk0VUZxTVR5Y3Q2aCtOaFFEc2Q2S2kxeEZm?=
 =?utf-8?B?WG5SMzRwcVVnb1gzdm1ycU5aN3o5N0xmUWQralNJV3JYSXFVR3IyZ25QRm9h?=
 =?utf-8?B?S3UrVUxwQ01Zdk5LQ2RWS0YzL2cxNFRhdllaVkxTZG1qcjZhd0ZxLzcva3NM?=
 =?utf-8?B?SVFMb1BUQ2NpM25uQnlZbmNJVUtGTVJBQlpJb3FweWxuenovUEp0K2tZeFZt?=
 =?utf-8?B?dzNVZEZkcnEvSFhQYjFBWUQ2eWs5N3JxRC94VFk1YnFXcnR3VUVuVzFkcFZl?=
 =?utf-8?B?MFBhc1ZZR2dINzZ2VVBuN2FnVWZrZlBaUnBlVzN4cUhLM0dKeU9NelhEdC9T?=
 =?utf-8?B?RzNmcEZwb3ZEcTRGbkM3ekk2OEhvY2ZPK3pJSEIvZDlKaDhBNDZFcGsvRTlk?=
 =?utf-8?B?RWY1UmNEOGdIQlFCV0JESzduNzZCL2JFOHArVnpRVjVWZWpVVVZhcjNtQmtQ?=
 =?utf-8?B?SGhnYnFQZXYrUEdNT3pucnlJdDhQWVBFdDRhR1dUL3krRGNpUzRZaGVPZEI5?=
 =?utf-8?B?US9aWVlHR1pSRlh5VUEyV1V0TVhId25qVVA5K0UrRWhtV09oMXl3bWtROVJx?=
 =?utf-8?B?WkE2d3VwckRkY21scWJHOEQ5clMvSW9WamE1Z3hpVHFNUFlmL3VqamJPbnVx?=
 =?utf-8?B?Ly9xOXByRnBZTmU0ZDhRVzlGUlV4T2FQdGZFNmlaZWkxTFlaeW51RnhsWksr?=
 =?utf-8?B?ZWpyTnFhbmF5K1F2aG5NYUtnQ2U5VnViM3oxbmpHS1hTMlZhd2hPdmpWM091?=
 =?utf-8?B?aHBucmc5RVIwM2UxQTljOUQrME9RbncvU0V5dzBTdy9kcFNpQTMwMlBZTSta?=
 =?utf-8?B?RTRaRnd2MFdrczU1RDVrTE41bFM0ZTFseWVTUnRqZ2dxUWZZUzJ1MzhyVkVi?=
 =?utf-8?B?dytYNlpZV3RVNVRBWnhJNHlQUFlsSGhmUlBwMEZ2SGlIRnBwYWg1eHFGaElm?=
 =?utf-8?B?L21URVVHaHJTMXRLeXg3aEdzMGdhVWMzRkRhNmdkRDBKdG1Da2RrcnZyWS80?=
 =?utf-8?B?ZHV0bFY0dW9mTktVODNGOEJWc3AxSVk4b2k3S3RVRXhhcW1xbW1CbCtVYUlh?=
 =?utf-8?B?eHpMTE0yd2RvVWJvM1lrYjg4Uk01ZFJZTmhGd25wSTlQbHUwV0U3UFIyTit4?=
 =?utf-8?B?MlJ2V1hZOXF5U21DNDhaaEVLc0lQM0lKMEl2QTJ3NEZxWDdmSDVFUU1vR1Uy?=
 =?utf-8?B?ZjFYSTdrZ0crVGZUS0ppeU13RE9nWU9GaUVtUVNKWXpqbEJ1aURaR1Fhb0gr?=
 =?utf-8?B?bkYxV1BDODJnNkdicFhkS2xqY1lJMjByeUF1RkFZcUFQc1FaSDVoMlRoVlhm?=
 =?utf-8?B?YXpkTktuUVMra2sxem9xc0tNbnlkT1lTMnZ1dnNZeVIrY3lQVCtpYm5RQVhK?=
 =?utf-8?B?ZFpSRXYyaUNWZlY2YlZRSlM2U2JlbDlJUmZsZUFHNTRiVG01cmpjR3FlN1hD?=
 =?utf-8?B?YjdmU0FNeXFHaUFYMjdLNmkzYXErMVpVaVRPcHJNc2xPTTIrUWFGVUIxZzRa?=
 =?utf-8?B?WVhKaVowSlpXWWYrTlBIcHh3Y0N2S3VJQUE4ZksxQk5LSUk4eDRHMS8yYVVU?=
 =?utf-8?B?d3psSEd0cHRGb0tqbzJBbXNlZ2hVZWVyUHNLMDcwY3FIMVhNSXA4MndsTitB?=
 =?utf-8?B?U0l6QlZtWXZKTy9zazhnS1V2UkVmN25QZmd6Tmx1VnV1YWJhV1p6K1g1aEpF?=
 =?utf-8?B?QktCS2wycUlsc2tTMFVjVEFVN005MkpUR3JmM0dGVStrUWhkYkg3TEZxTnd3?=
 =?utf-8?B?dlUrSGd3dW5BYTR3djR1ZVVhY0NRUkVHR0xUSFN1bzhteFR4WllsalhEUkdn?=
 =?utf-8?B?K2tVRUEzUGw2aCtmalJmWit4VEg0QW1aVjlZOVlSd1JaRm9nNEd0eEdMWkw3?=
 =?utf-8?B?cDZqRklWRnBOVlZkY2NUTHFjUitMaEE3T1pJYWtlZEVtaE5WdVNRNllNWWk1?=
 =?utf-8?B?SDNjajlOT1dsYS92dFVJcUxVQnZkM3IrZ29QVlhuVFo5QldQRExUaGw4Qloz?=
 =?utf-8?B?SXltVzZ1aDNGeDU3R0RuRjBjdVkwWmM3cmxtanFCZUVGaERKT3RYem1yRmRy?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef21bb51-cabd-4a11-821f-08de2d88928e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 07:42:53.1914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoF9uMj6mf0xZknuBRIHz6Y9bNz9KQO6L4zXMokqS5+hOo25P0JOTKKphJ7jRFnz/goAyzhm68vIiLSp9b+M7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4068
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

On 25.11.25 13:20, Marek Vasut wrote:
> On 11/14/25 6:13 PM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> If U-Boot is located on MMC, SPL and U-Boot proper are glued together.
>> More precisely, SPL is stored 4 times. Take this and its padding into
>> account and adjust sector number via board_spl_mmc_get_uboot_raw_sector.
>> This allows loading from a partition, without the need to hard-code the
>> offset via SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   arch/arm/mach-socfpga/board.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/
>> board.c
>> index 28554b7a109..d756f7381fb 100644
>> --- a/arch/arm/mach-socfpga/board.c
>> +++ b/arch/arm/mach-socfpga/board.c
>> @@ -14,6 +14,7 @@
>>   #include <hang.h>
>>   #include <handoff.h>
>>   #include <image.h>
>> +#include <spl.h>
>>   #include <usb.h>
>>   #include <usb/dwc2_udc.h>
>>   #include <asm/global_data.h>
>> @@ -209,3 +210,11 @@ void lmb_arch_add_memory(void)
>>       }
>>   }
>>   #endif
>> +
>> +#ifdef CONFIG_SPL
>> +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>> +                         unsigned long raw_sect)
>> +{
>> +    return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
> Please add a comment whether this is offset within a partition or within
> a raw block device.

Depends on the mode. It is relative to the partition when using any of
those modes, otherwise relative to base sector. Will add that.

> 
> Also, I see the long discussion thread, maybe it would be good to point
> out which commit exactly broken the DE0 board.

2a00d73d081a14e7c2ecf23794b6d029268d8ca3 - though it is not completely
fair to say it broke things because the code paths we took before that
change were not really consistent and papered over issues which the
refactoring than surfaced.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
