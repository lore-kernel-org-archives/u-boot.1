Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D27D1037B
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 11:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552E684191;
	Wed, 26 Nov 2025 12:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="C1XRz96B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFFF841B6; Wed, 26 Nov 2025 12:13:07 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215AC84011
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDf18o9/AIKpYNW5taxRSgxMoUJToFLbZZYHRVmq5E1vl1eepY+Gq59ybij5iEqjisYAGrCzpxYrhqAcSbQIOhF0IPUlapvGdStSGvhX4Q4/XlXraCBVhseWkXKNVqInh0EatJi2DthMQa+sOR5aqbOiAw7BmWcN/Mcd+AXb6Q5Thys+Gy+dXL5nc5Z/SGogq6VIFQaioSPJ4QJyHE6G7njDCINTzRUM4P7sDS1EITaPet/iaaGhLWPrjbd0p9qJbrAKZefDiRBxmYEIHvn+7yoRt41E4OY9SvBJ1ZYFYq4WETTD2Tm3gv6d4Ud+ugZf7n6ygNrzePxt9U9nEp78Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ6P/ZUikC2ov+WY3ObOaoFbf0zjPtDQ6HwWlXFsYuk=;
 b=GTDFEJX2kUOz5DnKzNm6Rw1pf8mLN0Kj7fccSx64sMk+T6Dwluh4bgUXOTWw5N0D2KkLxouzvHzdz4D+f2w8SVPx1Or38A60dYRIYZFBDYiw8Qk801mPXDPOXqUuzR/3AhEyMMt2ySes9Z9FUdGC4++8ocJYKJ09wwn4SKQgDQgnQv9CjARO4hc4K5WH5QREb/jFMMCFIsVPmCJnoO4f7fwztm+cKcO7LAvCguGzEUWOqO/hm5pOtSgqTEVvc5wONd9K+NEYFekSJ8rTaxN7F2eejf55p2Pj5fOlH0XT/aKORjQwmp1VUbtwGuZM2Nr7G5PvMh9huA7KlBdDFi18FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ6P/ZUikC2ov+WY3ObOaoFbf0zjPtDQ6HwWlXFsYuk=;
 b=C1XRz96BX9t+FGhU/OTTJPd12oTYO8YpodD5UUDesIbTl4Cad1MRM20bZhJgr9vFo/qY8bmnmzkI7N9+UgJBR8x0msskS58d+6QcyZwOrx1a5+ZymrD7ULen/vpsk5yInd/eQLlth98/yOpPYy0KIkXkmIMMG4DnsGGc3v5obtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB12160.eurprd04.prod.outlook.com (2603:10a6:150:316::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 11:13:01 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 11:13:01 +0000
Message-ID: <0b36ba97-13b1-40fc-87de-f6511bff59b8@cherry.de>
Date: Wed, 26 Nov 2025 12:12:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251125123847.307-1-briansune@gmail.com>
 <05987960-b2fa-4798-9504-78aab483e146@cherry.de>
 <CAN7C2SAh5cfXKWxVq1omhtTkgbbFCZ2-kcG8A-+tggWuPUWqpA@mail.gmail.com>
 <54428bab-5189-48d1-9b96-977487648327@cherry.de>
 <CAN7C2SANa72etXcE+C9q4UkprmfbHXOgTBP1fhWxGcVPH3Ongw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAN7C2SANa72etXcE+C9q4UkprmfbHXOgTBP1fhWxGcVPH3Ongw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0033.eurprd09.prod.outlook.com
 (2603:10a6:802:1::22) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB12160:EE_
X-MS-Office365-Filtering-Correlation-Id: 75170943-f837-4bf5-5f5f-08de2cdcc360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEkyU3N1MDZ4dzR4Tld3STUvMnR1WHdOVnlUMVE2Q0lPdGl0RnpramVBaHdm?=
 =?utf-8?B?US8xbkdMTU82SS90d1dMcVJ4aCsvV3VGd2dKNFFJblRyTE96TGxOd0pWbWZ1?=
 =?utf-8?B?QktIOFF4RVhpazBtMFlSQzY0ckc3NXJiZ3hYVE5TWFhmYll1TTRVaml6RWNS?=
 =?utf-8?B?c292MFY4dnBXSkJiMkNxUE1mdktKUUZSYzljYkxKZC9SM0hZN09jdWZDbE5w?=
 =?utf-8?B?eXB1V0J4bDFMSUtvb0xaK28yUU5nbTRkUEg5NjV1aFA5dFVpV1lqOTVob1U1?=
 =?utf-8?B?MW83cU5FRGdQSFQyd2xJUEdGYkptWEt2VjE5UjV4RjRoenRSVXBFenpmbmxS?=
 =?utf-8?B?Nm13RWpwYlV0am9ORUVPek9oWG1mblBNWFhrM2RIR2N6cXByWlMwZUMveDhk?=
 =?utf-8?B?eWlsTkowRUFkNGtSRmFKdTlSY2VZRkNvbkhXSkowOWErRG1Kbmx2ZUZORW9n?=
 =?utf-8?B?OVNtWGRraTZJUUtRMWFPNVBnUGpUR3N1dDEzYlZ2STlFM08xNlQ3ZkRvVFVz?=
 =?utf-8?B?dXpJclFoaWx1UHQ4WU5ic25EVGh5eml6ZFQ2Y1lkYzl5azdEcFhkWmpMQnJj?=
 =?utf-8?B?MlFtR0FLakVoQU1RaXErZlA5M254M2MyUmRpK2dqUHpXa0RYMmRvRTJ2VXBX?=
 =?utf-8?B?bHF3R29oWDhqaFFka0xlOHdraU9zdXdXVmRkcklSemJkcm5BNEdsS25NNndT?=
 =?utf-8?B?ZEM2ZTBNTk1OZXJvRTk4a2dYYlowV0JZa0ZIVTd0YVE0a20vTVhBQllJVzF6?=
 =?utf-8?B?UXhZUW5FSVpZMmtpSWpValZ4NEFVU2N6clNCdEhEVmNuemFIZlJxUmJsdzBH?=
 =?utf-8?B?cUx1N1cwU3hYUmhDeHNLT1NYMEZSaUk5UDdKbys1eUtlcW9sTzk3L1N2b3RS?=
 =?utf-8?B?aGhaR2Vaa2YrUHFSMVh5Q3dRT051eTZWaUNFU1pSYUVaYUlhS2xDVmNPeCsx?=
 =?utf-8?B?b2UydzhoZE4wazJCSFk0ZWtNSlkzWW9uQi9Wc2UxNGxYdjhma2grUUtuSzZY?=
 =?utf-8?B?QWFaWTV4bEFyb2xqU0pDaW9CZGlVOXdlR2RIcW1jNHdTajlzRERjb2JXLzJu?=
 =?utf-8?B?a1NTMVFuaC8vc01RYUNud1lBNEVnYWJtdWc4U0JGaGFvRUhMb2FuQ0FDN3JK?=
 =?utf-8?B?cWVzUzN3NUQ3am9qeHJzS1luejB5NWFzK2R1NTVSVUFmMGtIMEN1Y0FuWFA3?=
 =?utf-8?B?UDVXUm9CNndoc1RmME5QYlZ3UXNQNDU5eWlzbDhKTWo3L1dDcm5uRjRGOTZP?=
 =?utf-8?B?MlE0bjVLR1d3OHlSQnllWVJpLytPUWYxS2lrNUw2eFZzZmduZWpEUnNZejVZ?=
 =?utf-8?B?MFg1SDd1YWVNVHF4VHZrdG0rbDFlTDgxOW52cUZHY083N3Q5Z2FPNFUrZVRO?=
 =?utf-8?B?TE1XU2FHMUJhRUpQTUE2MGtBSDZaZzVXS21yR002dy9PeWd4aEdZWTkycTBa?=
 =?utf-8?B?N0hFakJ6VXBBVW1nYWdNczVZRHY4SWVlTHVpNDkwWmc1V01JVG0zMGtVV3Ix?=
 =?utf-8?B?NHVYSGloV0xMZ0xWeW8vQ3J5UzBJTUVBbVQvaFpRUjJZVlMxeGJhb29ZY1JN?=
 =?utf-8?B?eUpaVXdHZXJjK04yK2VvQWM1YngyUE9SL0hCOHh6Y1pxRUN2dFg0MzlDZW1x?=
 =?utf-8?B?SEhVb0pXN2hyWUlVY1dERnIxK0hHMWF3ZVBwOGxHWU5vNWhmc2JORXQ3bU56?=
 =?utf-8?B?a2ljU3AxejVlSHJ2N28ydzNzaCtFWW0waU9pUEZmVHZ5aDRlKzNlUW80Nmpk?=
 =?utf-8?B?QXhrdUtMQ1FYelhWZjdCNXNPeVBnRzFWUG1VNXg3TUg1Zy9CRSttSk5Pak16?=
 =?utf-8?B?dmlIVnpPcm5mR0krZUlhdlpGVGdDRGRQcFZtYXI0bEcxb3ROMXhNWTJ1SCtx?=
 =?utf-8?B?d1c3bmkxQTA2K1orSDIrRzF6OWhwcGJiOHJZN1ZLWFYwZFVXelI0ZzJjN0g3?=
 =?utf-8?Q?P3Yd0XRAyZKtiOJhs4smpf+CzPkUyaxV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHZuM2pEOFdzODV2ZjFWc09CWXhJR2hqeHJTc29zOGxnWVlyNHJMaWF2MURx?=
 =?utf-8?B?dGZTQTlGQ2pkeFpXVXJwUU42SThVaXF2SFBGZ1lqd3Z4eEw3QzlTQmhZdlFG?=
 =?utf-8?B?ZWExNWwvSTZMMmVOYUk3ZDY3NVVQUGlaM05ISEFDL2RJZWYwaXhSOTBjYVlT?=
 =?utf-8?B?WjVCbXdtUnFNNDRQSk1XUUxzTmcxUk1HS3g3aDltMDViWncraXpRQ1BuU2Mx?=
 =?utf-8?B?T1F0QW1tNVJSYXhPUnZWdG1rNVBuQmJUTDluUmhEYVZHV2taVTR6Q0RMSU9p?=
 =?utf-8?B?RFR1Qms5TUgzbjdWWnNPUlpMUjdRQ1pQNzJoOEpJYWVSZDR6eXRkbXlzUEk3?=
 =?utf-8?B?YkRiRmoxalltdjVmT1Q0UXh0ZFpUZ1lQNy9SbzNtQUcwekM3dlFjMURTTmdi?=
 =?utf-8?B?RnZhcHp6NWZVNytQV05WcktnNEllTkJpNnRza3JsUGY4bEU0ZU9uOGtlcDZw?=
 =?utf-8?B?TlU4bFM1aUlDdGVDTktRRnp1UUZ5aHVhenNzOW9zZHMxYjBhUGdReis3Tmoz?=
 =?utf-8?B?SURmYXVROEhMOGVGMEtyVVVrQTNib0lYZi90WExMMGRBQ0lWTWp4emtGbG9S?=
 =?utf-8?B?RnJ4RFZPSDRMRFBSdis1NVorOTZSM2l4VEljbkdKeng0by85d0tSTUMxakNV?=
 =?utf-8?B?bTBDRkVHTHpLdmhFUzJWc0Y5Z0JFYUJYOU1mT0QvOWFNYnNKVWt1M2JhbVVj?=
 =?utf-8?B?b3BtSzZpSnc2NU51UnA2bUVlQkdRcngxeVcwRFU4cC9aS2JTN2kzSTh4Z3Zo?=
 =?utf-8?B?WXNuRVpOdkRyUGlLeG91WGJIS0xwUlFjUGYrODVkM254ZU50THhDbXJVS2VS?=
 =?utf-8?B?WWRNblJZVFJwcWNHTG90SUlqWDBUMEp4WjBHT0R3ZXRicTBvSUcvMUdjeHo2?=
 =?utf-8?B?dDUybkpWZFk2QmV5L3ViTU9XQW1hVmh2cU5LMGpvTUZQcXFZSUZNK1UvYmRu?=
 =?utf-8?B?YlpHSEJSdVhSVHd1bXFWN2psTWJvdXdJZ2plaStYZzFPczdNelhxZk9ZQzAx?=
 =?utf-8?B?blpHRjZhT3h6a3Vxa3BVK2hMU09tTDJ0dW53Vlcxd0c1bHhzc2JTOHR6bTRK?=
 =?utf-8?B?YTljWEYvMEFUVEgxdG1sdHRORisvdFVsR2JhN01iOTJXQmlUNTI5dFVMQnZa?=
 =?utf-8?B?U0tiaVFIdVFtbGpIdllkRzk1am1VSWdqQWRmNUt5bGY0NjdDQ2hHU04ya1JU?=
 =?utf-8?B?RGN4Qm5XdnhqVVlQd3hqbzl5Skg0ZWlPSE04bm04MjJBczdnV0NhUmZDWmhE?=
 =?utf-8?B?REdweTBYQk9zbmFvR09Zbm1iZU56dnRxeTZmQTVHSk13bzdXVVRXNUF1OUhT?=
 =?utf-8?B?SWc1eHExdTB2WkF4Wjg2dXVNY0pXVkhITUFnaGwwVnIvK05LRWpuOXp3d2RN?=
 =?utf-8?B?VDZtODFFRXNpUU5GWWtaWXhyOWxUK1VLZU53NTRYRkNXL3Ewdy9qUFVJTmxi?=
 =?utf-8?B?cm1xcEltUWRGeXNvazV0V1RWRjJJMFhwYW9LcmpjMTk0MkN1TXB2eGZ1NEwv?=
 =?utf-8?B?ZFNsaktzL09GS0FPVmVXajl6VUFoL1pxd2xWY1NkRDRkS0pqQmhVbWpOenJI?=
 =?utf-8?B?L09wcWlKNW5Ea09wUkM0UDhaaSsxN2pKY0ozMit2aTRuSXAyd2p1WnR0Z0Fk?=
 =?utf-8?B?enZwU2RVSWdBVWN3Q2hvcitsaFpiVkFlS0FSK3l4Y0FZejBDall2OVkvSFpK?=
 =?utf-8?B?aTZMc2lXaitucDlCTjZja2t5dFRoa1gvVmJXWVJXSDlZem5udnN2MzJzZ0lB?=
 =?utf-8?B?d09JSU1GdnF6Mm5TazNQWDZIRmgvSFkrMGFSU0FFb01WYUtuT0xXaTdyelZx?=
 =?utf-8?B?UGQ3ampFWEV1S3ZkbjVCcm83NHdoYWsyVnQ3dmN3RUtERE42T0VobUUrdlB4?=
 =?utf-8?B?cjdiVUc5NjQ2WXBNS1hRMVJJRERxZmFsWmhLUENFTnhqRFZCcWlXVzVUU2Zq?=
 =?utf-8?B?ekFGNUIwQjlwN25IQTJpalA2UG5NdkJmVlVsSno1NnhPbHJhaGNwVkp3anp4?=
 =?utf-8?B?NHJDZFpTZnVEYjVqYlNkNGhaUkR3QjdLdmJXb2hpRk5odFJvTFZKQXBudW1h?=
 =?utf-8?B?alhITm1KRTkwdWpEVmdPc2R0Y2o4cDRwczlvODZVdTlUTkJ4dy9CdXB4RWtW?=
 =?utf-8?B?ckEzUzRXZW13SHVDU0tuYmNGNWk5MCtlNDZ1UTRBYzhOQ1JrUnB3QVFSU29C?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 75170943-f837-4bf5-5f5f-08de2cdcc360
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 11:13:01.6501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0q7LS/W4mpQXYDgO9GdJwFQlo3yFJVO7oXWEi2PSbbAdHV1FmHpXjPXszMcVaQTimnyBPVEEbq9lC27dtOHQKaDmEjHY82DdMLOs2Vn9WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12160
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

Hi Brian,

On 11/26/25 11:55 AM, Sune Brian wrote:
>> Yes, but I only want at least one board this happens on so we can try
>> figure out exactly what happens with this watchdog.
> 
> I am a bit confused. Sounds like this is affecting the entire U-Boot?

I believe so.

> Isn't this just a Cyclone V GEN5 socfpga issue?
> 

I don't think so.

I think the issue is that CONFIG_WATCHDOG selects CYCLIC but only 
implies SPL_CYCLIC and CONFIG_SPL_WATCHDOG does nothing wrt SPL_CYLIC. 
ARCH_SOCFPGA selects SPL_WATCHDOG so it is always enabled, but 
SPL_CYCLIC may not always be enabled.

> It is a very generic setup.
> clone from fresh
> 
> make clean
> make mrproper
> make socfpga_cyclone5_defconfig
> make prepare
> 
> Now please cp .config to .config_default
> 
> Ok now
> make menuconfig
> /WDT turn on and save

Only WDT or also SPL_WDT?

> make menuconfig
> turn all those you have enabled

Which ones?

> save again.
> 
> then gvimdiff .config .config_default
> 
> You will see what I meant.
> 

Can you run "make savedefconfig" after your "save again" step and copy 
the content of the file called "defconfig" that was just generated in a 
mail? That would really help me, thanks!

Cheers,
Quentin
