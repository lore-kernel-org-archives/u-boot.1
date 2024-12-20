Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AD2E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 06:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 340C78007D;
	Fri, 20 Dec 2024 07:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FK4S9hCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74EA280326; Fri, 20 Dec 2024 07:51:00 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C76C8006D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 07:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+wbQDRGMSJy8VwEHdCPTZiw/EVUEgIMGrQImXWLAK0+hVFPPSUnCoBSfmROO1e3wt84kPIhDUeC8JVUNLPF9IYe+ajAJ+WF98GIw+gmN5ZGHCjGW8Ic+C1Fybh1VI475dwvMFLh6ixbv3vGcai6dGcaVBfU4vp8PehKSDgHGRP9BkYkxBYtQEwkt4qk3/UvWnyB1nvE/OTAVlTcYtqdntsfftCtuTQg2ntYOLPKrWL/7mWRmNcAVU+COLihkFTj6oobXJaY1X4EekYphhk0GNH54q1Ypko2PafxImgHUPK8uHN+v4ZFzVUvhUUZqmm3mmu+x6tQE4q0sst+6Mkiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7Q58+tyJIwlEPXMZYrpDzfzGEdtpaYoS7hsp9wxL4Q=;
 b=x90yOpTUP0xf0L5sxwTZgzOCHJOlPOMQwqSVkizuAPAsEMKRtT1SQlIgQxLRmQXftvJAoco92Tu0Kxo4SFqU54dRsl2uDQ6EQRo7MtGf4sAQBkJYhMY1OkNdQIPHQxN3N/IR6LUJVQX5wkwvsT20lp4VFs9MWe61Wd50WDaQEhahdqsoS2CVZTCOTH+lpmcrSYf+cLsoLsd2XkUYHNTJIS6HxyG+LVLsa9cc7S4cr6p/iZBIVnUubQRrUjSSGXBA+PCi2l1wzQ2OUqGM+gROhyBVj5f26xzdiWYQUqu2fwIn32XFCMLzRG2ObvsTdHqHNfdymyAddA3P2yH4oGObQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7Q58+tyJIwlEPXMZYrpDzfzGEdtpaYoS7hsp9wxL4Q=;
 b=FK4S9hCZYx6CSoUmyRFKCxz2iXxZPQsaSejM3aA5WCklB6j2Cxrq/GyjTMXAbSiRrIrc0EFyANDMgsk0HW6tUvJN0/cSoMdqM2crTx1U5IjyX64V6eKtmA86rqSw3yAEm7Bz92am+LrNeUwPblXhiiQ4utCUPz93HEVWrU1mp0FVn4X+TNKXeKxB3ICvjrTRHGQWPqwGVf3frzbyiDzI7DpM5AxOITlFd9f+2LuBrvj57qp8n15+gmZh5Ga4q6FCP3QtEZ8X1HcoX7CrPrSCF7uKXr6DGwLTQG2WPH6OhxpfbJATxtEhpS/XCM27Lj66eE2BSirYmVaLpJlnN7YomQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB1926.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 06:50:57 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 06:50:56 +0000
Message-ID: <a44b9cfd-811f-41f7-acec-9cad96529abe@phytec.de>
Date: Fri, 20 Dec 2024 13:50:50 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
To: Santhosh Kumar K <s-k6@ti.com>, trini@konsulko.com, nm@ti.com,
 vigneshr@ti.com, u-kumar1@ti.com, bb@ti.com, m-chawdhry@ti.com,
 vaishnav.a@ti.com, j-choudhary@ti.com
Cc: u-boot@lists.denx.de, n-francis@ti.com
References: <20241213103129.332246-1-s-k6@ti.com>
 <20241213103129.332246-7-s-k6@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241213103129.332246-7-s-k6@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB1926:EE_
X-MS-Office365-Filtering-Correlation-Id: 1594da85-78f6-4142-00da-08dd20c2a77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0MrN2tUM1hUcHlacGlEL0EwVG55UGZ3Q3A3SDg2bEFNU0RNQmVZM2hBK3Vx?=
 =?utf-8?B?TzdaS0Mycld6QWlyS0FOK21uT1ZMa01JVm5Ydm9QbklMRVZaaUtCZVBraDNx?=
 =?utf-8?B?NUNIMUNEZTdYb2hxU20zaCtlc1hLbEQ0U0ZZUGVTWmJvOFV4SFJEemtiOWNq?=
 =?utf-8?B?TEs0OXJRUUpkVi9wcm1TWnM1ZTVJeEVYcDF5ekFhR2MzSDYvbkZPeUtsOE9D?=
 =?utf-8?B?WjRRTHVYd0V0ekV5VUVCT0ZXanFWdEw0bUU2VHlocWQ3ZDMzYkNHZTRrVUdx?=
 =?utf-8?B?MlV4V1BETHRZWHRaek95RkpZNXU4TEJtalVhMllFZEtkNHJHS1RiUTBaa3ZF?=
 =?utf-8?B?M05nQVprNTlHbTlCRENTTCs1OXdvR0F3VVlqZS8zdWcwS25YYnQvTEdhQWtV?=
 =?utf-8?B?VmpjdTBHekd4NlN1VkNET3kwY3ZjUHp6WC9Wb2hmbTllbkpBWkd6Q1htUTk1?=
 =?utf-8?B?cTM1RXBnK0F6WXlCMzZSUWs2QkRaWXdLL204OElFdFBacjlrQzdrQWhna3JZ?=
 =?utf-8?B?SGg4MlVZckZaVXRZTWlITkdTbjl3SCtBQlB2dnU0NG1uQTZKaUJvYzF6Q1VH?=
 =?utf-8?B?MW5LcFpoRC9qRUVBT0d0Q3BtcHVvcUNCQi80bWZabFRBanE5WWlGR3pER3Qv?=
 =?utf-8?B?TVhKa3pBQW83cTRwelJqVGdwWVhOdTF5ejlsMmlmMlZSNFE2bUNPL1BSN0ps?=
 =?utf-8?B?ekpnZUc4UjFCcEVxRElSOW16ekV2SEs3cEs2UmxEZEc1dmZFUE1jYm9NNWxG?=
 =?utf-8?B?WmdOUytmbXlMZVV5Vk9vZnNOTFlSK05GUC9lVWd1QTBaOUJ1dWZDY0g0QjZK?=
 =?utf-8?B?L21FMFQzN24vbDQ5eFpaZ25XRUp3UHpBNmx4WWR5M0NHRzRMQ2g5R09HeUV0?=
 =?utf-8?B?ekFIaERoNXlhWnpRZ2tVbWhoV1hWcloxRWlsbmRDKzlYdWhMNU51Q2RMRmVl?=
 =?utf-8?B?L0UzdXd6SksrTS90aGRxR3hjZmUrbEVmNjByNGo3cnducmdHZXRzMmRiQ1Vr?=
 =?utf-8?B?TC9GTitSZ2lENlhrTlQ0UzNsMU5Xb20vVytCRGoraVNQRGF2SFpMU2RFWGVi?=
 =?utf-8?B?UHF1dWtSVFNLamdYMnVrVW8rUkFjMUdlcG5UMXFGTEMxRHpPbEdJOW52Q0Yx?=
 =?utf-8?B?VGNxR2M3RjJVZ2VnRkFwZTVCQktMSmZKbTRia0wyQW9tVml5bktXd3BmUWtZ?=
 =?utf-8?B?ZHpDM2M3NXAzbnpkWnh3OGhUb04wR21zOUFzUzNxRy9WRm1FUjhTaFl1dFl4?=
 =?utf-8?B?SWFSZ3d2WUI0cFdFUkZsYjROSGcrMUtydW1YR04vc3hQaDJMb0F0d3UzakNB?=
 =?utf-8?B?UkZpdmtwSTdCcVZQOE5EcENDNnlJQ09kWFU3OEZOZDZaNER2VE9uUjBsYVpB?=
 =?utf-8?B?NDNVR3NBTitNUERjcDdKRnZ5eGFEVGRTT296NzAxdXJRTjY5S0tqRHpXaVpG?=
 =?utf-8?B?cWJIUkFGa1ZmVk5Ndjc4MDBZa29uRWwrQTZRVFg1czFkai91eXc1QUFGdmZx?=
 =?utf-8?B?eHVOU3BudFM2TDljSFBUMVpWQlZrMUNBTnlaOVZQOVFweTBEYytNMWRxU2xj?=
 =?utf-8?B?TzA2TGtWK3ZINm5GNmgzVlFzMHlPWUZGNTdJT3gyVnVpVGFLT3duTS9LY0xR?=
 =?utf-8?B?UnRwL1lTcyt4MmxWWWxsN2s4Z1JZcWdUSklDbk5qYit2M0VhSnE4aXBVdjQv?=
 =?utf-8?B?MnlJOXdCYWFQZDgrV1FqazhRRTkzSk95cHhyWkdnMGhMTXpJVUJEbWtwa1Qv?=
 =?utf-8?B?T0NUcjJJdGFGUkV0YnlzVVNNUTFEZEt0L2FwZWxCa05WYkhrb2Ixbk0wZ3V6?=
 =?utf-8?B?NSsrT1BtbjlBcGdpSjhWZEdvaDYvY3FhWkhaTVc3UUZUVWY0NlNCU2Q5Tmkr?=
 =?utf-8?Q?tGjGDNwtwIS8D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHoxOWlvdFptaHFSeGRXSmd4bGNqbjNvUC81SWwxaW9ZVDFDUGZQUUFlRTl3?=
 =?utf-8?B?Ujg4QTRrajdwblpSOW1keU10QUdQbTAxMWs3Q255MUZWWDRwNms4bmJmWUZ4?=
 =?utf-8?B?OCtHczBNaUExQWxWN0cwajNockszSjIwWTBpcmF5QzZ6clR4WnhYRmtnQ251?=
 =?utf-8?B?RmtXbXpWTVpTUHJZdHdMWnYzem1ib29XaHRXUHAwRkJKc0pKMTd2NFVKMkI0?=
 =?utf-8?B?WnN6dG5CMUlsdzd0Um55T2J0NExjUHQ4S3I0U0hNb2IxUS8wby8rMmNBZmZm?=
 =?utf-8?B?UGdQZGlpVGF4WGwyT0Z1VjBOOWUya1dzNjJsMUh4cTFCa3E5dytYVy9CcGJY?=
 =?utf-8?B?Q0I2ZTZYWmQxSEFhMFJGOTJDVzl6T1hFZmZUVGhibDBIS2lQRWgrcktqVUVH?=
 =?utf-8?B?dzkwTG5icVdMN0twUHdMUFhTSEJKdXNmZHQ5NkhaSjAyOTZ3QkZ0akQ1QlJR?=
 =?utf-8?B?WGlCSHpUcmNwOVN0NSsrcVE1YzhvY2EvZG9XaklUSUFtSjZMbkhpVlhXcTNq?=
 =?utf-8?B?MVBkVU4vZy9rZEkya0xHUVdXd3BLSTBFQzhZbVYzaFFWQ3JzU2hGUXJmRi95?=
 =?utf-8?B?c0ZVK25WRlpTUUg0ZXlFTXBUN3h5aFF2SVl6Rlp5c01CWWlFa1AwMzhoa2k3?=
 =?utf-8?B?bXRLMzFycE4xNE9qamdrRFl4aFVwWFhBYUxnbzhFMmtnUEdXL0ZNTkxRVTRZ?=
 =?utf-8?B?eDZldG85RU9nQ2h6bkpxdFFHbUxOUFByZkMyS3NVSi84bnBoTU1ud2JUTUx4?=
 =?utf-8?B?UjVoK3BMb0VmOFRsTXRHUGluYjEveGx3VnR5M2Z5bkZMOTZ5aUtDZDNYc1Ni?=
 =?utf-8?B?TnhQU1dsYi9tUWZVc3diQ29GSUVvcVdaMGhxRlBOS1NyUEVEV0tlcTgzNDJY?=
 =?utf-8?B?VUhzSWhEaVZhanVka05KMVZRaEVBdWk1RmViWU1kQ3VTS3BNc0RTaGpHSXJw?=
 =?utf-8?B?VmNEdmRQVVRwc01qZWhsb1YzakIzZm0vbG1QWWliU05leTFFWkFwOWZxQ2Ev?=
 =?utf-8?B?MHZITHE3NW5LRXljeEU2ZGJOSXlqWDV2RTJNY0IvWTdFWFBmNmU2RzJRNm11?=
 =?utf-8?B?ZjU2Mk41aDNMRk9LUnhEdm9CYnVVaUZJZDRGRzFMT203TkNWbjBQVUhqTmRt?=
 =?utf-8?B?SnVlTm04eXhSSGF3Zk8wY2g1QUx2bWdVUjJaNEZwZHI3S1hqeUxMUzIzeC9v?=
 =?utf-8?B?UXNEUDVEcFdFUGU2TWNSN2s2QW9TQlF5TmtHazJocW1kUEtUcGI1eVNzaExh?=
 =?utf-8?B?OGIwNGQzcUp1eW15aHdXMzNZUDcyN1dUa3ZlSWFDZzQzZWN4VkJyeUlMaUlG?=
 =?utf-8?B?a1VFVWtmcS9NVGFOQzRlMVBod1grU2U5bjB1ZFBLNlMzS0xRam90VlJmTEZp?=
 =?utf-8?B?Wit6cUZTSjJpRGpIcnNqVXNaNzBvaWtoVUx4MzZnNURTd1drWWxZYmdSdWhP?=
 =?utf-8?B?QmU3Vk1VUjhrM1hRMTI1YVQ5MU1qdzlYbDJnY1UxbE9yRnkvM2E3OFkzS05s?=
 =?utf-8?B?WUFYRTRUSzN2YjZjQmhpd1R5VUdISW1mWHo2RnpFL0NFLyt4T2tCOFVXZlFV?=
 =?utf-8?B?ZTVVVkhIT1JOYjdTbXJHRzB4NGIybGJaS3BWS2JhN3VIUDkvL3NQNmNZY0Jt?=
 =?utf-8?B?OWtxN3RQWFl5ejh3a29rdVUwNmhQZFRjdm9ieHZqOTF5YVNSaDRzcWdhVWVz?=
 =?utf-8?B?ZGMvQmh2SDBUc0U4TXZ2aGNUbFYwT1hVNzViRW1oajcvWGs0YkZMekxRWElr?=
 =?utf-8?B?SDhsK09aK1VKV3lwank5M2pqcGRJa3NsNHU1bmszVnVTMkQxZ1lDOVFaY29H?=
 =?utf-8?B?WEpjcUVnUWZMdWR0ZDNOcWtFSkgrdzBtZjRmVUg5Y3huT2YvTnp2MCtQYzBa?=
 =?utf-8?B?RkEzQllpTGFaRkhtdVZEOEthUEJvYmprb3E5WklrNmxBbmFsODJnRlJCK2VN?=
 =?utf-8?B?OFE4R09hODdKcDA1c0hrcFgvMG0rQ1kyU3dMbTVlZ2Y1djVqK04yalhvZktY?=
 =?utf-8?B?TVQ5bVMxYnk0Y0JUd0hDUThDdGswbitQMVVMcWZobHpmTUxhTHV5Z0Zia1BD?=
 =?utf-8?B?dGZVSlNMY2gxcjVYbVZ1RnJ1TFd2TTJqSDMxTTh4bUgxRWNpQ0F0TG5BenV5?=
 =?utf-8?Q?NPOoOUkPI90NCo6GOyKbdXIZF?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1594da85-78f6-4142-00da-08dd20c2a77d
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 06:50:56.4828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm7cfBMCqHW6+M+mLF8MumS6uSSDNUSgA+tY0BRnyWS8vyn68JgJjfTeyjmfJ75wURJ4Ht0wAgEaeRpmWHfHmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1926
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

Am 13.12.24 um 17:31 schrieb Santhosh Kumar K:
> From: Neha Malcom Francis <n-francis@ti.com>
> 
> Add CONFIG_K3_INLINE_ECC so that ECC functions can be compiled into R5 SPL
> only when the config has been enabled.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   drivers/ram/Kconfig | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
> index f7e357f24da7..533d0c629a64 100644
> --- a/drivers/ram/Kconfig
> +++ b/drivers/ram/Kconfig
> @@ -116,6 +116,16 @@ config IMXRT_SDRAM
>   	  to support external memories like sdram, psram & nand.
>   	  This driver is for the sdram memory interface with the SEMC.
>   
> +config K3_INLINE_ECC
> +	bool "Enable TI Inline ECC support"
> +	depends on K3_DDRSS
> +	help
> +	  Enable Inline ECC support on K3 platforms. 1/9th of the SDRAM space
> +	  is used for ECC storage and the rest 8/9th is available for system
> +	  use. Enabling ECC increases boot time as the ECC protected regions
> +	  need to be primed with a predefined value prior to enabling ECC
> +	  check.
> +
>   source "drivers/ram/aspeed/Kconfig"
>   source "drivers/ram/cadence/Kconfig"
>   source "drivers/ram/octeon/Kconfig"

