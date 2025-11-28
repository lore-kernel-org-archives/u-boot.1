Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260A2CFD2F6
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 02:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D07483B9D;
	Fri, 28 Nov 2025 03:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gPREyqOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D5983BBE; Fri, 28 Nov 2025 03:12:05 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F87083B81
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 03:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sX9u0zvbOULUXO3e0hHPPAi6IM9wjkzLmMmiy0lczb2inysZ/DeTf7UCyj30vioqTIKsl19J8jMSaFEBajks+Ar9yKqZh4SuaG9rCrtDRZ4ViGmj+apL/r8Gp0Dsi6CCm1y1+lfbnOb15KyqeuAeaJLghk7rkhcCWNhGBal3LgdifjlVpcGnGwblI/WYDa2K2wc8VUa0HjRkK9XmziXasBThTZhDeYTmOnXwGAoaZc2ERYJe1OPSqM4gTQj/rSuzV415YMoi8q971YpzH030/DQOQel5lB4f2FJFsrDATn9zsCbRQSci3biE70E4onLnwloj7qLMY57HDyed/sgVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFWK6jyNxeoKVkRIM5SJox0cOjWTqLeizMqlxB/tqag=;
 b=fvfAXRUED9gD6Y33mn2agLd2VdHlkWb/OUa51M9sFkjv+JLpYrWsXvPhdF1Ff3OEEEv8H+YEsrabtjxz4UrVQ3ToBWlSrklgjr9GHlz+I12yh6QqFpqZMeo4mxJ1QHE69oWbhuw+gdrj4WZYLsssAFLS3AgfGEPklphwTNVwadYRufBb88IAKoyAUOtyOtvwPrrdUpuksB/0pIQtA2jtRaEEFJCrOcWC7xa4vgOTNi2GjPGfVpSfopPeNCFmKQm+IUcCyDYMTEHNAt/DxIG7X6qfW6ab8J5MoO/1a28aDX6LjOi9Vo6rGI4d8/YeNGMciUm5GHHC7Rjrbo6j7cDO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFWK6jyNxeoKVkRIM5SJox0cOjWTqLeizMqlxB/tqag=;
 b=gPREyqOULPwqD6CubpL8HijZrp5O/uDkLfYh880Gu2m3iSJqpfX5uij65C3Y2LbmAlPd+abpAuDEKdarcT2jwLjF7w/9WIabLknAgPme8YXkXqf2QaS3V1/7ZrpToCU2E1KI54TYjzeUTK06l4k1gu2R8j9p5PlpaiHXVC9A3kaMWFrsW/TnoVIVuEE6uUMQW9lThUz5zGX3eSocDGeqXA6liOsw5hN/AiB3Sx+HoVK0223JAn4NUiNG4VsTuY+s8OphzD1uzlP+DJEJdCpF7uB+oLip+pM0HyQwm5jr4y6G4+cX4exH6OjCqhdE/wLZCTzRtQQhULR+lNQkJuxM0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by BY1PR03MB7924.namprd03.prod.outlook.com (2603:10b6:a03:5b7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 02:12:00 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:12:00 +0000
Message-ID: <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
Date: Fri, 28 Nov 2025 10:11:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>, Tien Fong Chee <tien.fong.chee@intel.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|BY1PR03MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 893a18ff-2bb1-4e77-0a18-08de2e23836c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHo5c09OcnFQTnpjS1M5aHI5RGFWZXhUN1BLYjJpQlpIQVB3SGNiU3ZGeWIv?=
 =?utf-8?B?MUs2aUlIaXM4S3JNZGpRQ0Zxcnk0UEpOWkdNZHVjNnFEUlZ3RUlhd0hrUFBN?=
 =?utf-8?B?S1dCR3JtOWs3QVJzTjIxdkFPeWI5NkhwVk9qOXVSbVorT0U0VmwxT3Z4Wllk?=
 =?utf-8?B?cEJhUlRQcHBHd2Y5T1JwOEZoL2NMbTFjek5ERXI0Rk50UnRvMjkyamY4WU9M?=
 =?utf-8?B?TFdQSFljcHhLU2syUjQzanVzcmFaVFVxMTU0OXkvN3RJRWs5VjVtcWNIcHVp?=
 =?utf-8?B?ZFprQWxFeFdmeWVHQkttWkJBbndiTlRiY05xUTJkRFloU3RVWmRhMzllUjVI?=
 =?utf-8?B?WGFXeHBCYkIzSHBqQUZxMS9QNkpDdlVPQ0N0cThzOVB1THJUejVDWm0vV20y?=
 =?utf-8?B?Qmw4SzR5elNjaUsxQkdHS1NmK2lkbjhZUTdueGlYWHRwbmlqV3hFeU1CRi9l?=
 =?utf-8?B?TVh3eGRycUY0OGdVVmE2SWdDc2hxS0F3TDdRTXhqNitJRytYaklpbFkzbTlV?=
 =?utf-8?B?WHpoVDR2MUJEMVdGaU4vR1JrYXZhN2pGNHEvRDNTV1VuSC9wNUxXb2VwYXZI?=
 =?utf-8?B?OU15N0Q2c3JTbStmYXQ1OHZlN1Q2L3JhakI4OE1YSUw5TUdkZWFmeTVZUmkr?=
 =?utf-8?B?YWx3WHBpV1o5M21zZDh3bi9lNVJBZGNvaGtQazBGMHBWdkxCM2hDN0I2SEsv?=
 =?utf-8?B?Z2pQdGlLSnExS0UvMmlndGZic3FyR1kwQUFyQkc3UmxBNUZranVtTnpPSEhD?=
 =?utf-8?B?c2R2alpGRWVvZVdnRm5sWmNWYXBkTnNqT2JWa2w5c0w3Tm9wQmVVckt1Ynlp?=
 =?utf-8?B?ZVN2K1M1Tk81L0JTWjJ0VFlDV2pnVWx1c1FCczVsRnZMdnZ3Yy9qaFYzSmZG?=
 =?utf-8?B?UmZWdVFjSnRJYVlmWDdZTGdGb0luR2MzbHFNSGIwUzlSOGZPODFLaEo4T1dD?=
 =?utf-8?B?SG9SRjhwYTdRbDEwSDhaYU9Wbis1MWpaaUREY0dnaFc0MERXRjhzWWpOdzZE?=
 =?utf-8?B?Y2I1aVlxZU16VWRvOTJUMlFaWnVIS3Z2Zkk5dWlkSXZuSHcxMDF1REI0c3lS?=
 =?utf-8?B?N1FnVk5JRG9hbXIxbUlRSXI1U1hBVWVFSzJubWl0TDFoa1llWlk0ZHZKU1NS?=
 =?utf-8?B?MUI4SGZXNzBCNGpyMG0rcC9nTS9IUG9BKzBNaWg0RmtqQkhrS1V2UGRWV3BC?=
 =?utf-8?B?SFdDaG9aZWQ1ZmdZR1JFVXdoVVNxVzl5bG43OFZ5MjlOa3Z5T1pqbldtMUw1?=
 =?utf-8?B?Nmd2SmV2bWtUWnh3Y3VRM2hkQ29XODR2TXhtU0FqbkRHYWsyd2QyRW44eDA2?=
 =?utf-8?B?RHB5VGZXaVhuWHZBVStnSTFZUzRmUkUxV3pLczNWSUt1T002Ym0zTGNCVGdL?=
 =?utf-8?B?aVRxTW0yWmYrd0VybFp1bVl4TU5WRXRWNnQvQ1UyUDJlemVQdlVNUzIxZ3lo?=
 =?utf-8?B?dkVQTEFMZmJQOVdrT3krNEdKK0VRNjg1bTRXMEtkUVJDcEN0aXJRZVVXVDNP?=
 =?utf-8?B?Z243UVM3cHRsd2hSaG9kK00rM3Vna0M0OWVmWmJ4WFU0SjFLdlJJTW9PbVFT?=
 =?utf-8?B?T2ZGSWRvVnQ0RW4zSTNtSjRFd3hQMTBmWVJHbzZVV2JnTWxhMFVxUGNmMTdi?=
 =?utf-8?B?bzE0SHhJam1FZkdZZ0phRWZIcCtpTFQySm1YZnl6WmJ6eHNoSzZ0OElPS09z?=
 =?utf-8?B?S210aGgyYzZ1QkpSUUtNN2VBNGlPL2doZUlTb0RydlRyWVdmRVF5bS9YMnRU?=
 =?utf-8?B?MllWR2RMZncwRW1NNWVPcVJJS3p1VFlkelpTbkhwMithZWttRldzdkZqY1ls?=
 =?utf-8?B?bHF6cnV1SGx3eDZoRWp5M0hGeThTS1JlYjR2TUlVK2MyTHJ2aUxubnM3SEt3?=
 =?utf-8?B?V2YrUmZOQkIyUlU5VnhVbmNwd2c4K1dXT2NjVFZiRzd0cXcwZVU3eFp2Y00x?=
 =?utf-8?Q?49w15dX9TEL0rR7nYsDqlKXgqU/yaf/z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXkvb0M4YjF4UEhRTG91RzBuVEdSeFZyM0NvTHJJQkhDWXJsRENDaWhnTFdv?=
 =?utf-8?B?dHRaSWE1S0VpQjR4eFNCNTZCM1YyeGdVVWNMZUZPaWtDcWJVdzBwT0ppTDdV?=
 =?utf-8?B?OG1hOEZNeDNLelJiNGxVRjNMbHA2TFpoaUJiUnRJcEpRWXJ0c0VUTkpxNDBE?=
 =?utf-8?B?SmVMQTRYWHVITWtUZHpyQ1lEZDRBSVVVbkF1WE5NdGUwU2NRVnh1OXE4c1ZJ?=
 =?utf-8?B?QVRka3FUV3hIUlN5V3poSTlEMFBQK2ZIQmd1OUVobWxlYnA4YmNLMEk1cXE0?=
 =?utf-8?B?UUVNMlVZZEtLNGpPa2QzTjhUQnE5UUZWd2MyY2tPaVI4MXNXQ3psZlBpL21H?=
 =?utf-8?B?UUxuSHdUYk5TeEs1citua0dSNjFWenFaWHlPRWp3bytFV3BzQW42V3FYOTZp?=
 =?utf-8?B?NHlKQUZCTENuYk82cTRTcXJNZ2djb1ZuTFNnS0dRN05HMElJcEV2RHNUL3J2?=
 =?utf-8?B?MTVNY3RRaXdrMDExRW5mc01LaFdtQXVIQ1NBWFVOZTBxdzFYbVNwVDVPZ1dx?=
 =?utf-8?B?S2pQOVdaSkpPT0JrellhY1hET1FzaG44b3VCZWhtWkVYS21GUFk1ODk0bEZl?=
 =?utf-8?B?VTd6NWNWSkNPZDg1T1NzdCtSN0pwTWorK1hTaFRNTzlpZzlueVBPMDd2bUdC?=
 =?utf-8?B?VDE0bmg4ZytvS2hyVWt5ZC9aRjQwWGdYQml1ZXEwTG5tL2l5ZFB4WUN2SEJI?=
 =?utf-8?B?NWlCYTZQeHlIWk5pMTczV003M1JsUlJQOUV6cEJMYVg4Q3BNd1k3Mzk4VnhW?=
 =?utf-8?B?VUV1Rk1uRm1sckZCV2p5bVlnMXo0SHI1NkdCM1dndENTK01vSnNkbjc3TnRi?=
 =?utf-8?B?Q0NhYy83c1JLL2xuMFFZK2xjS3h5VkQ0WCtoVFVwc29KMGJKSjg4QXVTU0Rh?=
 =?utf-8?B?b1RxeVJtQ3pNUTBnWVY1SnlKK2Y2aERJN211Ti9oUVN2bzVsdTFPNFYybDNM?=
 =?utf-8?B?Qnl1M3ZrQWUvOXhPTVMrRGJsdEpYQnBWMTdiT3FJVjRmVHdSL1N0bFAxRzNx?=
 =?utf-8?B?OCtBTDdjS1JsYk1waExMSUdISFZKdnk2NzlGUnlXclZBRzJyWHRYdmJoTjVK?=
 =?utf-8?B?K0xpS3ZTTGI2NW9ZL1NuREhqaDl4VkdRbW1lV3pXYVpabkREeE9aeUkxNFY0?=
 =?utf-8?B?bnpwNVQzOXJGc05kZTFsSTRIWVRRUUxaaEV2cmpKTjhhQytyekhsZklwZjVP?=
 =?utf-8?B?cXc4MVV0ZWxack1yYVNnU1BDTVNDWk5MeVErYWFIaHArT21neEtoaVlTQlhZ?=
 =?utf-8?B?STRwSmMrRzg1dDVWOUFYN1VycnNhY3QvRmllREZDOXNaeFFlK3FZVFc2U2dq?=
 =?utf-8?B?U2hBc2RoN2M1NzVMSHIwOXdwQXZENWYva3lTSDcwYnZaM0lSYVYxVGNPakd0?=
 =?utf-8?B?UnJ6cjlHRys3YWZVWHFNQ1dUY2JoNUFjUm5CcE1mOTZHc29ZUTF2RFNQMnhR?=
 =?utf-8?B?cHlVaXVXMWlDYVlLMk11ZWh5Z2ZkWmlScllrdXV2VnNpaXlMWVg3TG5IeXlR?=
 =?utf-8?B?Q3JnczdhQnpFY09WTmRsT3VaUndlQUZwaWUrQTZJdm9aS1M5eFcwcW9OZ0Fy?=
 =?utf-8?B?TUcrNEdYdWlGMXA4VmY1SDhaNFdxbXhUNVF2aXdQaE1EMTRPYUI1cmh0YkVx?=
 =?utf-8?B?NHRYYUhXeGx5cVptSmNuNTZwQ0tRN0hScXd2bFY2VjJWeEJRUi90TDFYUW1s?=
 =?utf-8?B?U0NhYUNlZ25wM2E5Ymoyd1FBQ1hTNVZNNEsvd2U2bFBvMnJJTVkra3J4RUZ3?=
 =?utf-8?B?RUVDNVNpSUdSMFhJY1NXRjFuOGlOb3oySi9JRktpYWhSdjdnb0hpTDdwU3Rv?=
 =?utf-8?B?NGdXdFZzME96MTl4Ni84eEk0RWhaVDhuaEtsWlg4dW5tMzhWZXROZ2IzSUkx?=
 =?utf-8?B?U3ZVTzVEaHlVK1o1QmZMMDlpZElLcGNDTUNmS3NTR0c2REx3SmtnT1FDVFVW?=
 =?utf-8?B?eEplT3ZRNzJsS2UzOXpTVkVwUi95K0MyUDgvNEVhZ2pXVHFZYmZGSVJxZjhK?=
 =?utf-8?B?VlBXN1hRQTZrT09qN1ZmOVVCTXFwdE85NFZKUjBlNmJ1N0s2NnJHZFllVnNo?=
 =?utf-8?B?R1hMUmJTRWFDajdJVVZ2cUh4OS9zeS9MT0RXTHpuUnFjZElGZldyRXlTYzZ2?=
 =?utf-8?B?S1JVSFVtZHZ5S3pDT2xlSkZRMjhkek94SU5WNXFpbnhSL01xWU1mM1FKV3lS?=
 =?utf-8?Q?D0eoHNuSUdkNw9JJYuLZ/wA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893a18ff-2bb1-4e77-0a18-08de2e23836c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:12:00.2564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtP9ttExQf1yQayi+B/5E1SQMMGMo0YabyLzxq/n9ZdbtaTCUNBFfg0nhOwjQo8Bd/jdF24gkNtPurhl/ISNPnAb1GUDiHNhdEeDf1Srok4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7924
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



On 27/11/2025 11:09 pm, Marek Vasut wrote:
> [CAUTION: This email is from outside your organization. Unless you trust 
> the sender, do not click on links or open attachments as it may be a 
> fraudulent email attempting to steal your information and/or compromise 
> your computer.]
> 
> On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> 
> Hello everyone,
> 
>> I already have the referenced commit in my test branch, and I can
>> confirm that the same compilation error still appears on CycloneV when
>> certain directories produce no SPL objects.
>>
>> The existing fix ensures that built-in.o is always present, but it does
>> not prevent ar from generating empty built-in.a archives, which older
>> ARM 32-bit linkers (such as CycloneV toolchains) reject as “file
>> truncated”.
> 
> Which toolchain is this ?
> 

I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compile our SoC32 
devices - CycloneV and Arria10

>> This patch complements the earlier fix by ensuring that each SPL
>> directory contributes at least one real object, so the resulting built-
>> in.a archives are non-empty and accepted by all toolchains. It does not
>> change runtime behavior—only ensures the archives remain valid.
>>
>> Thanks,
>> Alif
>>
> 
> 
> -- 
> Best regards,
> Marek Vasut

