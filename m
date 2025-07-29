Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A8AC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 06:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2714E82ADA;
	Tue, 29 Jul 2025 08:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Kv1B1pKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A8382BCD; Tue, 29 Jul 2025 08:25:13 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B32829E7
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piTny7a7x6hja+DCxfcNXKy3SSsT8lzMTl2ImkeZFLp1qcuf+dfxxilp29OXOXRfiCi4E4xqbWZRoDm7vFBESbw+hw18RhWTc2SwX0Eak2yHHygBGfsVzStOeueAr+mLWSAYww+Y3djPv+sVL7tLD8WdVgWSDATp2e4KGkdL4GZcyWs8544fgOOhHty298JLUKeI3b+R/SfUhJucncaj/QHiCo2/VfH7yrf0KgR/YWQpoVpI+OpgAB8ixFx//1CueRk1RDcLLhI+3pZllHo3k5aFL0Faakh17kZrdv6TzTKCerwIq8Mt4IErvMZdXX5eJTek9PHFYtNEE73jWTKMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MW5UsAzVHTfbxdJAlSHE+Ju/PG0WigH1vwE3+WmABg=;
 b=QhqHuyH7uJBSeCfaB7RZnmr4dgVZI090PRH9b7jSRn1E6KD6ZmutVcpmx5D69kEius4tu5YPGxl8g9bm0M9Sz4LT/4ZWfExIOR8480XGXfZLMTp0K0TkpGDCfDOyk5lNsfj8uic2l76pIEATNvrxAsD0jlZSexOWNFfvf5lnHTZufto5D4noftNF9xxSO4VAUeOXB/imHzmiG5QB2bySCI5MoP+G1NqCjVdmwH8crYZnLh1lEJ4PGqZEOw65NzSxMFTCuqL2pF95AvIE0omq45Nek7aW8iPSZby1/MtWOfsC0kNBzNfgAixYqPqgVq65e6aJYXiqh4kwaZgkhGPKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MW5UsAzVHTfbxdJAlSHE+Ju/PG0WigH1vwE3+WmABg=;
 b=Kv1B1pKqWkfYDAoSCLHoLpg+pMPyYlMGliiRj0y6ponrAXNz5w6UAU5sagRsvl8LacsL06Ws+0dC6mJ964+TDAcOLiVs0NJ8EaEKB6V6Q24cIoeLMgb5wMLDGehbRUaCjiV/XkD8t4vdXPsAw7ZmF+8GuWnGYWMvNBTaQGLd5pkmjG6maqoui8azLLp4H8xwebwT4hao7t0H4cIAFP1w6TMoyopsUAHp+aDdTE8IwZQgqqAk5WmENrH/v9p6lgjLdtKqQCf/GyT90gEkcEJD7byz8gXkR/w+akgbz9cRqaNvXGO8SOH/SBk3x7iyuDlGCQbHVONhThfuH0N8m2iSlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by VI1P195MB2339.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:1c3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Tue, 29 Jul
 2025 06:25:05 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%5]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 06:25:05 +0000
Message-ID: <dcd0452c-1d9a-4968-9e47-f63f8d77242c@phytec.de>
Date: Tue, 29 Jul 2025 09:25:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Add imx8mp-libra-fpsc board
To: Benjamin Hahn <B.Hahn@phytec.de>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de
References: <20250725-imx8mp-libra-initial-support-v1-0-d9982df21a4b@phytec.de>
 <20250725-imx8mp-libra-initial-support-v1-3-d9982df21a4b@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250725-imx8mp-libra-initial-support-v1-3-d9982df21a4b@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::13) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|VI1P195MB2339:EE_
X-MS-Office365-Filtering-Correlation-Id: caafdc62-29d4-48b7-95e7-08ddce68a863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWVoWHdUb3g4RWhvam5ZNitHN2l1elRDaURlWWE0SnNoMzZvLzhIZ2cwWEpz?=
 =?utf-8?B?Z2VjZjdWV0k5OGFDL0t0N09jeUdoVjVacVFOaDFWM3lvQm4vVVdOYnhwMksw?=
 =?utf-8?B?VklpOGRxV1kxZ3NFaWFQdVJUcDBPMVloK3c4UmJRL1N5eWU1eWgxVG9XYW1I?=
 =?utf-8?B?eDY4TUVPQmQvZS8rNHFnTnI4ZlBvWWowZnduTlJzREJFTC9YcEtIMk1OcjNS?=
 =?utf-8?B?dWw1cUlpNkpDYWJGR1ZLZjZVbHhZWkhCVWJMVkViK0JNcmtwRmU0TmRFeGg1?=
 =?utf-8?B?dmIrcEw2U3YxQ3Z5TWRTLy8yVXpFaXZ5eWFGN3ZpQXhENEhWWkR4cFBQWWxF?=
 =?utf-8?B?NHloR2EzVC9yY2JnVUxSclhrUVlHamhGaHZrNCtNSXBaUW5ibERhbCt0eTI3?=
 =?utf-8?B?R3ZoWnhZOEJMRlZUeVFDdE52alJHRUorS21OSFNyN1BYRzM3YVV4cmlRWHJj?=
 =?utf-8?B?RUhhckdQdmVYVzd1QlAzR1Z1anNZT2hwc25vcENvU2prQ3JmdVdXR3NPN3Nw?=
 =?utf-8?B?MGw2N1NMVFRBbWtPQnFLQTFkMk04ZXNxdDA1aHpyclpVQVc0ajE0OE04VDY1?=
 =?utf-8?B?SkJvWGFBMXd3NnFYbFd4VTJPT0s5RUJOUVhlTnRSVHpiWGQ0MDV4WFJIY0tt?=
 =?utf-8?B?V1l1OGJMcU1YVlYrdENMWjFSRm9nQ1NKWHZDYmVTK25xOWtRemY2QTRsSXMz?=
 =?utf-8?B?ZkhRdm9qNXVMR0hKd3dXSFdHS2liZ2lVdEt6clN5WjBjU1Z0c1gxWmJsNEdN?=
 =?utf-8?B?dWo5cmZSTE9hdkRneGNpd0Rkb3hiU1QvTzVLaENTcythNWVLWkwzQ0hoOEZH?=
 =?utf-8?B?TmZ4ZDhaUDhrOHk4eUp3R0NKcTNWOUhadnZlZ3hFRmJmSm15V2cxN1UyNmdS?=
 =?utf-8?B?RG83RU9ON1hNYnI1L1NUQ2V2QlI4YzRPUjd1OFNsZWlMV0dPQUR1WEZiOUFF?=
 =?utf-8?B?OXFGbEVjOHlWQ3ZmMkMyQ29PaGV4a0dldXdGWW9CaGlCM0dkeCtJeTJReDlT?=
 =?utf-8?B?eUpWQzdPSmZ2U2VqT1BBTTlIakgyb0gwQUxwMkxnb01FNzFsT2x3cks4ZWYz?=
 =?utf-8?B?T28zVFJaL2tXNWFoVXE2aFkwSXlzQm1xblZ6L3N4dkcwYm1pbTY2clpidjU5?=
 =?utf-8?B?T2l5OWNzMWtNYlNINUZKUjdkV2VoWllKK3lLc2J1MHVUQlZGL2Y2V3RFWmxQ?=
 =?utf-8?B?OGtDL2FINWlQMEk5ZHV2ZkpJM3J4UHBKN2NDSzBVM2dGT1RtYWRGQXFDOXNG?=
 =?utf-8?B?ajJtMjNTejVjMjBNNTBEUXBYWStOOHRoVXE2aXh5WmI4U2tNMXVRdVdhbEt3?=
 =?utf-8?B?alhCMnZUTk1nMXk0dElFc0MybUtKeTF2VE14Qlp1cXJOa09GWk9nclkwbDFn?=
 =?utf-8?B?cWdCREFiSUpRcmRjUzdKMktwRmhzZjFCcGMrR3pvU0FvbEV1WU82VUdRQURD?=
 =?utf-8?B?ZTVCNFlyODJyRkJDMUExdHgzKzFoOWRJaFpKYmNkRldYSU1MQzFNRk9XVmFl?=
 =?utf-8?B?UGxXbDQyaTkzYjgxa0kxTCswdXpPZEN5eFBrT0NNWTJZelowdFozNC9pRExZ?=
 =?utf-8?B?cDl1Si9mS3IyVlFCTkNmS0g1RWZmUW9VMDIyVFQ5TXRQWXQ3YVV5bGpLQnJU?=
 =?utf-8?B?cmUvZkdOWG9ZNTNybW5PLzJUN1N3TlJYcnBKWmdEZDF3MGFkeVQ3NEIyR3Jy?=
 =?utf-8?B?NTJ2TkN0TVh5RExjcHBEbFJNaE9JOVF0b2JUSlJhNEhPaE9HeVRqaHVjMlZy?=
 =?utf-8?B?aGVJcU1WNHZveFdlRVhVTnpOZEJPNGhSNUx5SDNxVm9mem5OcHpEelU5RllJ?=
 =?utf-8?Q?2Y1xOtMeo5NnxF9MBw7BII+Q7kLvbhd1fYNt0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZEQTRSOTgvNmpoWk1hS2FpdkJTQzlOZEhwR2ZEQ0NHaTZFMWF5ZU5MMDZH?=
 =?utf-8?B?NU1nWTdiWXBxWjJGQ2VTcmlTUWJ1aXplUUlJUTM2TDhkQ3FLZ2lZeTgyNVJy?=
 =?utf-8?B?Vjcwc2ZoVzNaKys1RTJGaGRzVXlXZ3E3QmtpVzhTR3hhOWhrSWV0VWdBOERs?=
 =?utf-8?B?MmVJWjY2VzRMejgvUnZ2L3BSeGlBUVZQUXZoVmNJTVlmejhuczlxSk1CYWtV?=
 =?utf-8?B?a0crampBK2ZsV1FsQ2w2RjM1a0c5RS9oZUlLMXdpTk9JQkRnMGFTNjFSZnhS?=
 =?utf-8?B?bGhOQWhxU1lobmZTdkFQYlF0N2pYanhrWmNjN2JGWk9TSlJxdFBLZWI2TjNm?=
 =?utf-8?B?K1FoK2gxQ093OWNzYkZVeDhCZjFHdmpxYTB4QkhZZWs5MlpaQklJODdOaDcv?=
 =?utf-8?B?bXY0ZEF2czVLQ3Y3ZDU1bmVQalp1ME93bkI3MENTcUQ5NU5XV3pSaWNRZGVz?=
 =?utf-8?B?R0QrZGh5S0JmMkUyTVV0OWNTU09sSGRPb3hheGtpZ2xvcy8zYXcrQlBURlU5?=
 =?utf-8?B?NVorNU9JVkNDdW5LKzR2VEZmSFVaUFZ0dmxvN3hYeEpNOWRNRW5ralBYYVR3?=
 =?utf-8?B?UEl5T1NqV20yTDRwV0MzQ2ZDN3Z4TWtoU3d6aFhSOXJSSzBreHlvNTlQWEJX?=
 =?utf-8?B?S2dtSmNRNlZWNDY0bXlPSUxrMGNxYkdmc0VURis2VGdzOXEyRHRZeGV6QWNk?=
 =?utf-8?B?N1hYWmxZY3pkUERpN2lkWkNVRWFNdUtDQmttYUtkSkNja1h0QTAzSHU0ajNi?=
 =?utf-8?B?S1BkYWlXeFRrZWRMWEhKM3VnMU5aYlNmek5OWDFReGkzeXF1Y3h4cU55c1hO?=
 =?utf-8?B?UVlVL29MSC9MUCswdXJPRGpDb1dTcnJFOGgyUnBnaHoxa3hldzBEOW5ueDF4?=
 =?utf-8?B?RHJLVTVmYWJQdUQrZk1tYytPbS82RkliMmxUQWEwM01qNm9reGZUTXF1bU1N?=
 =?utf-8?B?OTJwYnVaa1pxRytiMHRnaGY0L1kzQ1Bld29qYkpRRDhoOGtGenBvSU4wNitV?=
 =?utf-8?B?ZDF3NEREem1EYTYyLzVyY2tpYzdzakZBU05TbkJ0cTYrNk5BMWRkMjcrazJR?=
 =?utf-8?B?ditxd1hQWGpNTUZuVTdTMHY1Tnp6SzVudXFyNjJvQng1N1hFT2tYS0tTQSto?=
 =?utf-8?B?QU5JZ216NmY4b21POUJrRFY5bVNrQVpJUURYUU5XMnBQUGFTcXNpNTRNdStz?=
 =?utf-8?B?RXZHV1dYSjlycExNUS9tTkE2dSt4YTVZVSs2eG5WTU8xRzNwclB3TlZJVlFl?=
 =?utf-8?B?VXVtZ2JQMUIweEVucEFNbUgzakpFR3VRM1NOcGZvV1ZjTXNjazJnRTF1YjBq?=
 =?utf-8?B?YTV1OU9qWE5ReWl3Z1orQ0IvNG03cVgrcjdLb2ZxNGFTUTVscys5ZHBXR1o2?=
 =?utf-8?B?M2N6cmpkWVcwSXlUYUJNaCttUEJtOFhacmd2L1cvK0NJNWE1RGFtd2xTMW15?=
 =?utf-8?B?Q29PK0FFU3dSd1VNSlhHN0QvQUVzNmlNaWR3SnhyZmovMEhVZEp5SStyS09l?=
 =?utf-8?B?VFBFU2puRkgrVWljY3c0cmgrQkdtQ2orcHAvKzR6STRBR2g3UEcyTFZyaDlw?=
 =?utf-8?B?ai9FRlBWK3ZCV080L1NFc0FqUGtFWDNRRVc5QS9XQStITk56QTNQMGhtZ1Fi?=
 =?utf-8?B?cytneXFJOU1OdE9rOE5pVkUwMHpKVzZKajRxdU9BaUIxVHQxNzZHRm1BOHN1?=
 =?utf-8?B?NU5zRlUzRnFFSWE5ZDFpZCttQWl2b0x3cXR2eko3U3JEYmozUFk1dHZFUzMx?=
 =?utf-8?B?LzB4MTdPbkllcGxQcGtrcEN0VE9DODVRckQ5RlgzNm9xRklkWUJ3MjJvU245?=
 =?utf-8?B?TnJySkFUSy9rUHF5QkpYL0tWMzROSktqczc3dklxbktLdTJVTFg3Wlh6eXFT?=
 =?utf-8?B?c2hvNXBwK3ExdDFabTdKT29mN2plbisxNndIOW8zSENLNE8rL1BZd3VlNGd5?=
 =?utf-8?B?cnRYZmpoMmk0SWRCOHh1UTVQUzB5bnpjYWVPMWlwR0p0VVc2MUVUaDgrZTdY?=
 =?utf-8?B?dHEyWVhGOEkwK1pRd2IrTUpWQkRJRzRpMHRKdDRUbFFVQXErbW5vZGdsR21z?=
 =?utf-8?B?ODdaMWlkS21zVXAxcnBzd0F0WmxnV0JzSCtrQzVEVml3MXdrZjlHTkc5TjRu?=
 =?utf-8?Q?MxPs0ED6+XYmipD4+APNoHVHy?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: caafdc62-29d4-48b7-95e7-08ddce68a863
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 06:25:05.5208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5P492tG8WbP+KWhHoHdsBqFpjrACGbpI9RefftkzPUWEuXXnm1wYCZaJzHNY6E3vHUAqmbWZ1peReRnN89bTEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB2339
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

Hi,

On 7/25/25 1:35 PM, Benjamin Hahn wrote:
> Add new imx8mp-libra-fpsc board.
> USB is not working yet, as the entry in the upstream devicetree is
> missing.
> 
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
>   arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi     |   78 +
>   arch/arm/mach-imx/imx8m/Kconfig                    |    9 +
>   board/phytec/imx8mp-libra-fpsc/Kconfig             |   16 +
>   board/phytec/imx8mp-libra-fpsc/MAINTAINERS         |    8 +
>   board/phytec/imx8mp-libra-fpsc/Makefile            |   10 +
>   board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c |  114 ++
>   .../phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env |   30 +
>   board/phytec/imx8mp-libra-fpsc/lpddr4_timing.c     | 1846 ++++++++++++++++++++
>   board/phytec/imx8mp-libra-fpsc/spl.c               |  131 ++
>   configs/imx8mp-libra-fpsc_defconfig                |  170 ++
>   include/configs/imx8mp-libra-fpsc.h                |   27 +
>   11 files changed, 2439 insertions(+)
> 
> diff --git a/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi b/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
> new file mode 100644
> index 000000000000..8f0f86d9f09e
> --- /dev/null
> +++ b/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + */
> +
> +#include "imx8mp-u-boot.dtsi"
> +
> +/ {
> +	wdt-reboot {
> +		compatible = "wdt-reboot";
> +		wdt = <&wdog1>;
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&reg_usdhc2_vmmc {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_uart4 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc2 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc3 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_wdog {
> +	bootph-pre-ram;
> +};
> +
> +&gpio1 {
> +	bootph-pre-ram;
> +};
> +
> +&gpio2 {
> +	bootph-pre-ram;
> +};
> +
> +&gpio3 {
> +	bootph-pre-ram;
> +};
> +
> +&gpio4 {
> +	bootph-pre-ram;
> +};
> +
> +&gpio5 {
> +	bootph-pre-ram;
> +};
> +
> +&uart4 {
> +	bootph-pre-ram;
> +};
> +
> +&i2c1 {
> +	bootph-pre-ram;
> +};
> +
> +&pmic {
> +	bootph-pre-ram;
> +};
> +
> +&usdhc2 {
> +	bootph-pre-ram;
> +};
> +
> +&usdhc3 {
> +	bootph-pre-ram;
> +};
> +
> +&wdog1 {
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
> index 74416a788473..2e4b86473c63 100644
> --- a/arch/arm/mach-imx/imx8m/Kconfig
> +++ b/arch/arm/mach-imx/imx8m/Kconfig
> @@ -345,6 +345,14 @@ config TARGET_PHYCORE_IMX8MP
>   	select IMX8M_LPDDR4
>   	imply OF_UPSTREAM
>   
> +config TARGET_IMX8MP_LIBRA_FPSC
> +	bool "PHYTEC Libra FPSC i.MX 8M Plus"
> +	select IMX8MP
> +	select SUPPORT_SPL
> +	select IMX8M_LPDDR4
> +	help
> +	  i.MX8M Plus Libra is an FPSC SOM based on NXP i.MX8MP.
> +
>   config TARGET_IMX8MM_CL_IOT_GATE
>   	bool "CompuLab iot-gate-imx8"
>   	select IMX8MM
> @@ -411,6 +419,7 @@ source "board/msc/sm2s_imx8mp/Kconfig"
>   source "board/mntre/imx8mq_reform2/Kconfig"
>   source "board/phytec/phycore_imx8mm/Kconfig"
>   source "board/phytec/phycore_imx8mp/Kconfig"
> +source "board/phytec/imx8mp-libra-fpsc/Kconfig"
>   source "board/polyhex/imx8mp_debix_model_a/Kconfig"
>   source "board/purism/librem5/Kconfig"
>   source "board/ronetix/imx8mq-cm/Kconfig"
> diff --git a/board/phytec/imx8mp-libra-fpsc/Kconfig b/board/phytec/imx8mp-libra-fpsc/Kconfig
> new file mode 100644
> index 000000000000..449bfda79632
> --- /dev/null
> +++ b/board/phytec/imx8mp-libra-fpsc/Kconfig
> @@ -0,0 +1,16 @@
> +if TARGET_IMX8MP_LIBRA_FPSC
> +
> +config SYS_BOARD
> +	default "imx8mp-libra-fpsc"
> +
> +config SYS_VENDOR
> +	default "phytec"
> +
> +config IMX_CONFIG
> +	default "board/phytec/phycore_imx8mp/imximage-8mp-sd.cfg"

This does not seem to be right. I guess you want to have a copy of that 
file for this board.

> +
> +config SYS_CONFIG_NAME
> +	default "imx8mp-libra-fpsc"
> +
> +source "board/phytec/common/Kconfig"
> +endif
> diff --git a/board/phytec/imx8mp-libra-fpsc/MAINTAINERS b/board/phytec/imx8mp-libra-fpsc/MAINTAINERS
> new file mode 100644
> index 000000000000..16b18b605e0d
> --- /dev/null
> +++ b/board/phytec/imx8mp-libra-fpsc/MAINTAINERS
> @@ -0,0 +1,8 @@
> +Libra-i.MX 8M Plus
> +M:      Teresa Remmet <t.remmet@phytec.de>
> +W: 	https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-8m-plus-fpsc/
> +S:      Maintained
> +F:      arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
> +F:      board/phytec/imx8mp-libra-fpsc/
> +F:      configs/imx8mp-libra-fpsc_defconfig
> +F:      include/configs/imx8mp-libra-fpsc.h
> diff --git a/board/phytec/imx8mp-libra-fpsc/Makefile b/board/phytec/imx8mp-libra-fpsc/Makefile
> new file mode 100644
> index 000000000000..8f956eb2ffbb
> --- /dev/null
> +++ b/board/phytec/imx8mp-libra-fpsc/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2025 PHYTEC Messtechnik GmbH
> +
> +obj-y += imx8mp-libra-fpsc.o
> +
> +ifdef CONFIG_SPL_BUILD
> +obj-y += spl.o
> +obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
> +endif
> diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c
> new file mode 100644
> index 000000000000..89b3b6f90ecb
> --- /dev/null
> +++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + */
> +
> +#include <asm/arch/clock.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/global_data.h>
> +#include <linux/io.h>
> +#include <asm/mach-imx/boot_mode.h>
> +#include <dwc3-uboot.h>
> +#include <env.h>
> +#include <init.h>
> +#include <fdt_support.h>
> +#include <jffs2/load_kernel.h>
> +#include <miiphy.h>
> +#include <mtd_node.h>
> +#include <usb.h>
> +#include <i2c.h>
> +
> +#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION)

There is not need for this guard. Please drop it.

> +#include "../common/imx8m_som_detection.h"
> +#endif
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define EEPROM_ADDR		0x51
> +
> +#define TUSB_PORT_POL_CRTL_REG	0xB
> +#define TUSB_CUSTOM_POL		BIT(7)
> +#define TUSB_P0_POL		BIT(0)
> +
> +/*
> + * WORKAROUND for PCM-937-L 1618.0, 1618.1.
> + * USB HUB TUSB8042A has swapped upstream pin polarity.
> + * Set i2c registers to inform the hub that the lines
> + * are swapped.
> + */
> +void tusb8042a_swap_lines(void)
> +{
> +	const u8 pol_swap_val = (TUSB_CUSTOM_POL | TUSB_P0_POL);
> +	const int addr = 0x44;
> +	struct udevice *dev = 0;
> +	int ret = i2c_get_chip_for_busnum(2, addr, 1, &dev);
> +
> +	if (!ret)
> +		dm_i2c_write(dev, TUSB_PORT_POL_CRTL_REG, &pol_swap_val, 1);
> +	else
> +		printf("TUSB8042A: Failed to fixup USB HUB.\n");
> +}
> +
> +static int setup_fec(void)
> +{
> +	struct iomuxc_gpr_base_regs *gpr =
> +		(struct iomuxc_gpr_base_regs *)IOMUXC_GPR_BASE_ADDR;
> +
> +	/* Use 125M anatop REF_CLK1 for ENET1, not from external */
> +	clrsetbits_le32(&gpr->gpr[1], 0x2000, 0);
> +
> +	return 0;
> +}
> +
> +int board_init(void)
> +{
> +#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION)
> +	int ret = phytec_eeprom_data_setup(NULL, 0, EEPROM_ADDR);

What is the point of reading out the EEPROM at this stage if you are not 
using the information? Drop it and add it later when you actually need it.

> +
> +	if (ret)
> +		printf("%s: EEPROM data init failed\n", __func__);
> +#endif
> +	tusb8042a_swap_lines();
> +
> +	setup_fec();
> +
> +	return 0;
> +}
> +
> +int board_mmc_get_env_dev(int devno)
> +{
> +	return devno;
> +}
> +
> +int board_late_init(void)
> +{
> +	switch (get_boot_device()) {
> +	case SD2_BOOT:
> +		env_set_ulong("mmcdev", 1);
> +		if (!strcmp(env_get("boot_targets"), env_get_default("boot_targets")))
> +			env_set("boot_targets", "mmc1 mmc2 ethernet");
> +		break;
> +	case MMC3_BOOT:
> +		env_set_ulong("mmcdev", 2);
> +		break;
> +	case USB_BOOT:
> +		printf("Detect USB boot. Will enter fastboot mode!\n");
> +		if (!strcmp(env_get("bootcmd"), env_get_default("bootcmd")))
> +			env_set("bootcmd", "fastboot 0; bootflow scan -lb;");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +int board_phys_sdram_size(phys_size_t *size)
> +{
> +	if (!size)
> +		return -EINVAL;
> +
> +	*size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE);
> +
> +	return 0;
> +}
> diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
> new file mode 100644
> index 000000000000..edcd05aedd2e
> --- /dev/null
> +++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
> @@ -0,0 +1,30 @@
> +bootmeths=script
> +boot_targets=mmc2 mmc1 ethernet
> +boot_script_dhcp=boot.scr.uimg
> +bootenv_addr_r=0x49100000
> +console=ttymxc3,115200
> +emmc_dev=2  /* This is needed by built-in uuu flash scripts */
> +fdt_addr_r=0x48000000
> +fdtfile=CONFIG_DEFAULT_FDT_FILE
> +fdtoverlay_addr_r=0x49000000
> +fit_fdtconf=conf-imx8mp-libra-rdk-fpsc.dtb
> +ip_dyn=no
> +ipaddr=192.168.3.11
> +kernel_addr_r=0x5A080000
> +kernel_comp_addr_r=0x60000000
> +kernel_comp_size=0x2000000
> +mmcautodetect=yes
> +mmcdev=CONFIG_SYS_MMC_ENV_DEV
> +mmcpart=1
> +mmcroot=2
> +netmask=255.225.255.0
> +nfsroot=/srv/nfs
> +no_bootenv=0
> +no_extensions=0
> +pxefile_addr_r=0x58600000
> +ramdisk_addr_r=0x5e000000
> +sd_dev=1    /* This is needed by built-in uuu flash scripts */

Can you bring both variables next to each other and use only a single 
comment line?

> +script_offset_f=0x400000
> +script_size_f=0x2000
> +scriptaddr=0x58500000
> +serverip=192.168.3.10
> diff --git a/board/phytec/imx8mp-libra-fpsc/lpddr4_timing.c b/board/phytec/imx8mp-libra-fpsc/lpddr4_timing.c
> new file mode 100644
> index 000000000000..dd5b4ad8347a
> --- /dev/null

<snip>

> +++ b/board/phytec/imx8mp-libra-fpsc/spl.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + */
> +
> +#include <config.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/ddr.h>
> +#include <asm/arch/imx8mp_pins.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/global_data.h>
> +#include <asm/mach-imx/boot_mode.h>
> +#include <asm/mach-imx/gpio.h>
> +#include <asm/mach-imx/mxc_i2c.h>
> +#include <asm/mach-imx/iomux-v3.h>
> +#include <hang.h>
> +#include <init.h>
> +#include <log.h>
> +#include <power/pmic.h>
> +#include <power/pca9450.h>
> +#include <spl.h>
> +
> +#include "../common/imx8m_som_detection.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define EEPROM_ADDR		0x51

Why can't we have this defined in imx8m_som_detection.h?

Regards,
Wadim
