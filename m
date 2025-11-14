Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8B8CE7AED
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 11:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C031684081;
	Fri, 14 Nov 2025 12:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PzQxoCrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E3A84088; Fri, 14 Nov 2025 12:36:19 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33EEB83EF5
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 12:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYZTp3W4rOM9JzeeQAc//5Phc8hmFQqn9UYD3eLnDVRMld6dDPjntfGTh4ND0bzACMNF5NUcMGyb5YrGRhAddcD//0aNSIAcTplpeXjZyZqxoB+Id0wqwSmkmC6k2zHb4BfbTRTB2HMckW5gm3Qm4F5WONPKDSIoBvteZ/QwG+L972ng8YTQDm+53ZRk+qVA/yBf+iIv9IRJrj3LbCrBuQI/pxrTB1zEjyIqRynoCQbxljxfmTFSr2kONZTZ7w5pXyvsiORRJ11TiqV//KN/BsZ5aZhyqlzeJqCaXCsE2qd6D3V8tH2BheLcYkTM7uAw3RCO3qD0cGGIelxxQckhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alEH5CJ9gfqhgc7gEVLiiuQ3EdngkMPiNMPiRp2hsL4=;
 b=raSea1A3QHXBKzwa25NGZgLy79rYbBNyrapCSyc/tn0YtaJ92nAAJSyTScWmAiSB6ICIfk+RLzAt/Pbcg8AYg+nEsrLXFJy8OwLBB4txhB+Axb4EaqBIPyc8DdXBewypC/rWsMz5qzuQ3PO/YtqMC/A9MHUSPEUuHuhMMxT5xy6dEckNQE5ykHjRMU9+LUqffUEoWAtTMshfoiBpj9G8OGC+A6v9+lCdo5Y234Nrz2luUJpVyaOTVPnoR4YWBoZUx7+H6l1YTIg7f4Urj+aj9UJjYHeWasp4aO/yTNxyfJ2RHZR2H3m89tV/p9MJ559ZY3brutcTze1f5yTjbiEi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alEH5CJ9gfqhgc7gEVLiiuQ3EdngkMPiNMPiRp2hsL4=;
 b=PzQxoCrjqgEU/gPH0N0RAFo47DwL8oRpgDla6oPHPK/MvO1ildCIPKxqxfeAoQ/5gjQ8KJNC3zQX6wdty4YivYr+zvHpAIYcts01dEk23cRRHoW7Lb0MxarKAUWmKhZcGPxeZN/K6QXy65zYdu0OPr+l8d8zkE+ZC/zM0rJJuCpUQ4zowDQtoRao+Q30D7/XUI9J14MXPLgIVjmqseYc0caFJnD0BD8PphYfK5NRfovQyYa/Pw3M/EveMRevrd0IRB2zvDGclzEELu6TnWFzdDgACqvqs1f7yPQBQvQlcII4VTpvssgz7eWe1v7Z22LcYOBJqzXBFON1SYHlm5mTzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ0PR03MB6390.namprd03.prod.outlook.com (2603:10b6:a03:396::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 11:36:13 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 11:36:13 +0000
Message-ID: <009323c1-98b3-490a-912a-35249efbfd9d@altera.com>
Date: Fri, 14 Nov 2025 19:36:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
To: Sune Brian <briansune@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251020133455.1870-1-briansune@gmail.com>
 <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
 <CAN7C2SDVD+bpF=CGDPXDqLE3U9cMm2YqxnwXScvxiFh3OypP=A@mail.gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <CAN7C2SDVD+bpF=CGDPXDqLE3U9cMm2YqxnwXScvxiFh3OypP=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0040.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::7) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SJ0PR03MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 966d81da-078d-4d17-fb11-08de237203c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3NaNHNHbWZ5Snk5UmdDQVFaK3hCSzBHUmE4QzhEVUd5Z1FDSjlHbml3YlhD?=
 =?utf-8?B?ckhndDBJcE9PRWFJWWU4dGl6dmxzUFllWHpGQmxzMy9MNGJya1ZQSzQrTG5C?=
 =?utf-8?B?eHVWb3hwakNhWlJOYmMrWTFYZjFLcGViYlJGSlA4SWxMUGUydWVDYm54bUZQ?=
 =?utf-8?B?TTdhOHViREdESUNUdGpjMFlVT2haWHRveTlTTnB0MHlPVU4wNUMvWnV3Yjdu?=
 =?utf-8?B?d3IzSGMrVDRRNGtobzBnTDBibFhNcjgvQTlZcS9peVlNSDR0cUdCTHhLb0xt?=
 =?utf-8?B?Q2hEK2c1aDZxR1UwK1EyQjRTWFhSM1VTQUN5TUVxWDFuL25BTkRMVFJ5QmFJ?=
 =?utf-8?B?WXdnU1ZlclZHcnMwSEhGT0kyVGtBSXdmdzZZM1BML2YwdG5Ib0FrbHlJZ05F?=
 =?utf-8?B?ZnRNVEVnNXh2RWZtSDdRK1JFeXYrWG9SNjFtZU56ZmRxVXp3VjF5YmwxN1Nm?=
 =?utf-8?B?SFNydnN6SksybUpiY2FwY3U4TWlRdzAzR1V3SkZCeTRjeVIxVEFVaEJIZ1NT?=
 =?utf-8?B?Z0pJV0ppckxYMGpEYzFJeCtTT3dxR1lmdkU2L2kyZUFkSWg0dStlNUhvWjll?=
 =?utf-8?B?WkpZbUV4MDBNVHllenJHZWVYQ3l2N2RrSDJmUWNhbmJTTmZhQVZncDhuQXdJ?=
 =?utf-8?B?ai9YSTNlY0haUloweWZSbk8vcUtpZ2syakZINUluVnhYVjFhODE0RlNxRFNo?=
 =?utf-8?B?UGNRVy9sbmNFWVdGL0c1bzBXVHNUSUw2MFhzU0UxZy9OTk5Hd1FyUEFjMWxO?=
 =?utf-8?B?Rm1YeFJ5Q1ZFRDlSYUh3ZTRuczdRSmYrUEhSVGFQSlFBZWt2VlljN0pVdk9u?=
 =?utf-8?B?c1h5MFhLTEdSSVVuZFJja3pkblErOFhzUU1nOXc2cGIxZVNxbENpcnRIZ2hW?=
 =?utf-8?B?V2NGU0FXbFAyNzRmcXVDanVpVEgyK0EvT0I2ai9HMHhyTExwQUF0YWhXOU9I?=
 =?utf-8?B?RTFTSkY4LzJ4bittVzJHTDBaV1NjdWxCSm94bGFSM2FkbW5laVgwUUdYRzBL?=
 =?utf-8?B?RENiNWpZYnd5bzNTMytjM2Zkd0dMTnJPQkg1OUpsOEpCaHVuTUpnS1NlSkNo?=
 =?utf-8?B?eDUwRHAvVFAvamZLM1V4VjFNMFhaTXNKejZBQmdQaXZTZkJtbFlickNJbE5I?=
 =?utf-8?B?Q0U1T3V6QnpRQlgxbkVISFE3M1dpTGd0dEVGemRLWDdvTi9jKzZVTDNQMHF2?=
 =?utf-8?B?STE1RThRTE9KRlJDNFhzR2JkclF2Tkd0OGZHdG9qbW1md0k2aTUxSkJzbXFI?=
 =?utf-8?B?cW1RdW5pcDh6dHZNdVBJbmlwcSs1Wll6RVJIU0Y0d2RsbEM5VWZRQzlsSU4x?=
 =?utf-8?B?NGF1cTRiWE03RTBuN0dZaTlrVnl3S1JhKzlLZ2pWZ1ZINHpxZGkrQmFmejcz?=
 =?utf-8?B?THhpT1RGeU8zOHZsV09rU2ZBVFNsYmlNaGJoZGZSNTVvdG14NXJxS1I1eGha?=
 =?utf-8?B?eldjdk82WGw2UjZHMXBsMGE3QlRuZjNSZWtpUE1ZcU9rcVlyT0Y5LzUvZko4?=
 =?utf-8?B?YXBieStlQmFaQzRNYU8vc2tpSG5QVlp1M2pmdEMzUzNiUHJFZHRWWWgrZ0dJ?=
 =?utf-8?B?RndyU3dxbi9sOHQvVkVGUStBSVREWXFCMzRHSnNFUXRLQW5uQ3gzcXJzRDVT?=
 =?utf-8?B?YmJSeXNUaHp2NEdiaUhqNXFEdG80RGpaeS9zWEJ0MEJMcTBuTHpKNXF5N2ov?=
 =?utf-8?B?d0JyaDBiY21KdEhYNmVGZWIzWnJpamhlYVJqNFdOMWhiZXc3ZElFYmphK3VP?=
 =?utf-8?B?UEpySTRzT0loSWUyYkdJS0V2Q1ZRN1FyZDg1amlCbEc1bFBoNG5ncnZLd2VN?=
 =?utf-8?B?bVdBKzdTM0htSU5OSVQ2SWFhMDc4T1lORGVYeE0wZnZ0VXNTSTBtNUZuZEtH?=
 =?utf-8?B?bVd5TUMvS1cxRzV4M0V0bENRUVdLZ21Pbkt4czBLbEVpODIyWStnakQ5UnpV?=
 =?utf-8?Q?1OKB8QPkxmr0GHRWufISGR37tG5iUFKa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2dQdUJ2c3FWcy84aU5ZUGIyY0lUMkFhZDZNc2JPa05PMXhTYWtlSVdvSmQw?=
 =?utf-8?B?UmdLeWxTTVBZcjRHTDRRQmhBSGhyWDNmd3RMWURLR0RxMFNwSFdXWXFvOXgy?=
 =?utf-8?B?QkVZcHZ2QlVGd1hSTnpUWVYzekcwVG95YzRZQkc2UFdISm5SdXpwSFNXSFJT?=
 =?utf-8?B?YkhhVnVVYnRZM09ZTzVQTG9CUEM1MFJxaFNMaWxIM01oT1JXVWdNMkdjcTVx?=
 =?utf-8?B?cXRDVDFPQ1pQckx0amZLUXZwc3pyTWI3L05SYnQ5QThKUFozV0ZYaGtpWklW?=
 =?utf-8?B?blk1M3U4REZ2SEdiVTUrcmxjK1QwSVRuVzBzTVZLK2RSL2tBY2VDSnA2VEMx?=
 =?utf-8?B?dTBXeVZUM05lVG14SFkwWWFHdnFtNDVjOXBFRlVHdzcyK3crT01CcU1tSFgr?=
 =?utf-8?B?M3FzeEx4MHkzSEY1V3J5ZlladE40TmZPYTZzMmF6ZlpNVEg0R1pPSC9Cbll1?=
 =?utf-8?B?S1JoYlJFOWZOaFRMYm0vZEt3a1pFbVo4WTJ0dkJPRWdoMGZ0QTBIcHczYm14?=
 =?utf-8?B?ajc4eGRhZnBZazNCTVFjaGZqeUdYS3c2TVJtOWV4clZmVlcxZU9jNlp2dFc0?=
 =?utf-8?B?Q3QvVkVnSTlOeGJHbFhuRVZQM0xONmFmdldMN1RUVWc5TWpOcEMwVW9xWFBr?=
 =?utf-8?B?NWFOVjRWZXdDdEJQZ3J4VkVpUWxMbXl6L0dDVUJRSFBISGFxNXdrTk84a1pM?=
 =?utf-8?B?eFNidE5wQjBsWEEvT3BpR3V6WjB5SXNFZWI1VnhUbmt4UUhsKy8rTE0rb3Fn?=
 =?utf-8?B?U2hYM3FhZGYyMENNalplSEdHcDhMS2ZlQkZqQU03R01GR1RPZ3hzZ3IwWTFl?=
 =?utf-8?B?a3lFM0RQYjE5TTZCSHhpQ1dzMWY3ZE9zVnJxcDJCYStSWW81Y3pCblFoSVF3?=
 =?utf-8?B?ZW5xSENoOVVXd3gxa2pZY0hZYkxjL2J3NTlDMnVtVllzeWJJb3NScUpNTi9x?=
 =?utf-8?B?SzlyUWpmQWlxd3ZPTHB2RDVrSlYwdHVVRDVGMnZQaEpTMnZvSDYwRmRQdUdS?=
 =?utf-8?B?TmtlcTBSbFBiVW80b09OZUplSnVLb3ByZEkvUDhQb3RFeUV5N0o2QU5DSXg4?=
 =?utf-8?B?RXgyYmVUOEV4ODUzVlNNOTBjWW56N05HUUVZSzdES2NZUUswWm5MenJ4c3lT?=
 =?utf-8?B?VXB5clJBUmFWcGVGOGVsZ1hkY0tGVkVFUW1Qc1Z4eWttNUhWU0lOSVdURDNm?=
 =?utf-8?B?T2dGMTRaT1hPWHRMdmwwSFoyTVNCMzlZUEdrNXRMMUlIZU1YR0dSdmZVSFFP?=
 =?utf-8?B?TmlkRFk2cEd6cUhmUXZoYkxZWnRjOEtWZ0g2bk9pWmM3NU53ZUxnL2VTUUp3?=
 =?utf-8?B?QWMrTmlOSGtaMWNyZnB1RHVYRkNJTk5lbnJteWprclpUdFZWVXlDVnY3dnov?=
 =?utf-8?B?NDR5NUZic2ZFVDRoMFNQaFRtZVcxUFFjcVBYVU1Xem9UZTdROGx0b1hMbFVB?=
 =?utf-8?B?Mm9ucEJYT2JuYjBxN05wYURjbnJVTjJ4L1I3bHppTUpya0NMdWRVUm10RFla?=
 =?utf-8?B?bnhCNm1zM3Zsc2ZFRE9QaFV5TEZ2bTcxSGZBR2lHN2RxWTdQNUl4Qk93anpm?=
 =?utf-8?B?SVJnYlp4UGpyUUg0d3dZelRTak9vS1FveldsWlM1Z0NEY3lCQ0FTMGpsWmhZ?=
 =?utf-8?B?M05lcFl6czQ2MzVycmRlbDBMM05hSUlGWmRFQUxiVUtnTklxYnVlL09HbnpS?=
 =?utf-8?B?UGxCSDVYS20wUnIrL0RMd3U0dnBvYjlQVmRvWjNRajJmcnMrS0lBbi96WVFy?=
 =?utf-8?B?TFFXbHVWcVlYbmZabDI1cEQ1YWVyWU53SmxEaVJIeG0yUmFCUTFET0cxMWRn?=
 =?utf-8?B?OG9icVdwcklCeDQySXJGNGFRMlhzTFZFZU1jaTdreW9GSDNFNXlXdW9Va3VN?=
 =?utf-8?B?bE4yUzIyUExGeWo5dTZOZUE1MjFnd3FJYkNIbTNhSXA0eHRHSnk3ZEplQTFw?=
 =?utf-8?B?R0JZeFpUKzJGWW9zaTM4S0hDMW1SZWJjcXFCWkxMRDlvOGpZZ0hINW9Zbk9F?=
 =?utf-8?B?ak1HTUFqNlZmSlJ4ZVdmSy93R0k3Tm42RVp4a3VzQm94b0dFL2xWMlNoZGE3?=
 =?utf-8?B?dUFYc042UE9DTTdSVCt6Ynh0VTBUQmE4Rzd2bC9KUGZUaURxRkNjbzFQWXg5?=
 =?utf-8?B?OXJWL1BoOStvalBXbDN1QnUxL2hPYkxGRXFDelVQV1VnNGNYRE1BWXZESzE0?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966d81da-078d-4d17-fb11-08de237203c1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 11:36:13.2923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZYJVnO29QGN6fMhywKIAg8tP7IqODi+0NF+dYz38n6YcwyizGOhlDBGAh4HdAySJgkTrkEOatUk96iIvaKtS3g9LLoIUeykzHBpmraUmgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6390
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


On 14/11/2025 7:23 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>

Hi Brian,


> All the below comment are all just talking about new SoCFPGA.
> You break the SD boot by for Cyclone V and Arria V and possible
> Arria 10 as well.
> You can do a build and board test on SD boot.
> Just consider newer SoCFPGA is not a proper way to remove things.
>
> If I am mistaken point out why and what is the reason.
> There are nothing to do with new family, this patch is pointing
> out the old SoCFPGA is break by such.
>

Thanks for your detailed review and feedback.

You are correct, the patch as-is focuses on newer SoCFPGA platforms such 
as Agilex, and Agilex7M, and it does affect SD boot on older platforms 
like Cyclone V, and Arria 10. Our initial assumption was that users 
would primarily use the Altera official release repo, where we have been 
gradually migrating platform devices to the driver model stage by stage, 
including clk driver used in MMC driver.

To clarify, as of today, the driver model has already been implemented 
for Agilex, Agilex7M, and Agilex5. For older SoCFPGA platforms, we will 
ensure that SD boot and existing functionality continue to work while 
maintaining compatibility during this staged migration.

We appreciate your testing and observations. We will take care to 
preserve backward compatibility and address the issues you raised before 
finalizing these changes in mainline.

Thanks,
Tien Fong


>
>> Hi,
>>
>> On 20/10/2025 9:34 pm, Brian Sune wrote:
>>
>> Since U-Boot 2025.07 pure SD Card
>> boot no longer works. Now Altera released 2025.07
>> shows the different on the u-boot files.
>> After testing, the major root case is
>> get_managers_addr. And this patch fix the
>> SD boot stall via pulling from offical.
>>
>> Signed-off-by: Brian Sune <briansune@gmail.com>
>> ---
>>   arch/arm/mach-socfpga/misc.c | 26 ++++++++++++++++++++++++--
>>   1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
>> index 76747c2196a..c54f5e32454 100644
>> --- a/arch/arm/mach-socfpga/misc.c
>> +++ b/arch/arm/mach-socfpga/misc.c
>> @@ -178,7 +178,10 @@ int arch_cpu_init(void)
>>    * timeout value is still active which might too short for Linux
>>    * booting.
>>    */
>> +#if !(IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_SIMICS) || \
>> + IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_EMU))
>>    hw_watchdog_init();
>> +#endif
>>
>>
>> This is intended for internal use and should be removed.
>>
>>
>>   #else
>>    /*
>>    * If the HW watchdog is NOT enabled, make sure it is not running,
>> @@ -223,8 +226,16 @@ static int do_bridge(struct cmd_tbl *cmdtp, int flag, int argc,
>>
>>   U_BOOT_CMD(bridge, 3, 1, do_bridge,
>>      "SoCFPGA HPS FPGA bridge control",
>> -   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
>> -   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
>> +   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges\n"
>> +   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges\n"
>> +   "Bit 3, Bit 4 and Bit 5 bridges only available in Stratix 10\n"
>> +   "For example:\n"
>> +   "1) To enable and disable all bridges (command without mask):\n"
>> +   " a) bridge enable\n"
>> +   " b) bridge disable\n"
>> +   "2) To enable and disable HPS-to-FPGA and LWHPS-to-FPGA bridges (command with mask):\n"
>> +   " a) bridge enable 0x3\n"
>> +   " b) bridge disable 0x3\n"
>>      ""
>>   );
>>
>> @@ -261,6 +272,17 @@ void socfpga_get_managers_addr(void)
>>    if (ret)
>>    hang();
>>
>> + if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
>>
>>
>> if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
>>          !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M) &&
>>          !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
>>
>>
>> The condition for non-Agilex5 platforms should be rewritten because sys-mgr has already moved to the driver model for these platforms.
>>
>>
>> + ret = socfpga_get_base_addr("altr,sys-mgr",
>> +    &socfpga_sysmgr_base);
>> + if (ret)
>> + hang();
>> + }
>> +
>> + if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) ||
>> +    IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M))
>> + ret = socfpga_get_base_addr("intel,agilex-clkmgr",
>> +    &socfpga_clkmgr_base);
>>
>>
>> Similarly, the section for Agilex and Agilex7M using clkmgr can be removed, as both now use the driver model.
>>
>>
>>    else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
>>
>>
>> The N5X section should be updated as:  "if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))"
>>
>> The remaining part of the function can remain intact.
>>
>>
>>    ret = socfpga_get_base_addr("intel,n5x-clkmgr",
>>       &socfpga_clkmgr_base);
>>
>>
>> We’ve already tested the above changes and they work as expected.
>>
>>
>> Thanks.
>>
>> Tien Fong
