Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C96CA1002
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 11:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D32839DE;
	Mon,  1 Sep 2025 13:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="eJmmna1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ABA1839E4; Mon,  1 Sep 2025 13:29:26 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2481A839A1
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 13:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF4dLWFYnc1nMM3nEJz/4TS+1uHMJC5JtduSBJvXnpqf0ZKKbR+13RyNb5hsfROo9UpcoU+cq0OGZNvaaDcxAXWtPWVvw7VsZYDN/ub9bT8NKdPliXaHShpfX13dKeQU+dpAs6TXZJW5SRrHSGaXrPS7zIfQlSTt7LCQPETEv59mJQIU8kk2aV2hVf2sn551FmNsAvhClJjeW62LwQdJvc9P43lizzyF1j7xoWnbuoWyK2VFTu5lJLfmQww5qZT2BC9M+62504OXDfVCPr+FWd2whnjTZwcunM/XlIkB+JLqEoGqaAqrbDRdu0Gu19OGSZ6c/ZhbSS3u39AFBdoB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQ6LGifhzFbI8MIZ/g1lP/g+7dP3iYeF//xJaAJI5cU=;
 b=ppwusg95fGqTemxz3LOiQnn2DyUAHfGPosiKnypvUP+VHPEPHRu1emBM4H8pmityAwO243o/5y0z8dVb1XG4ZLe2tsmEzWBbgZGT4lARJ/6UiwkvtRYf8xU/6NlI6JWEKzhkvHi0aGo2CsuDIdDyAxmW+r1+lhHOucnqCJv+Tn+vp2Jmg1WDDIhm/SRrKSQ1H6jbhqyyWYZPODXfDrNXO01nwTqgoqItRrrv+w5YZoyAJnilcdVruoa0NmlVbyYFQZDbUydysG6Oc1OyUnw2pb/t52nBNffKiguoFq0qqksrWn6X9zap9PYOdsT8t17W7fGqNZQtdehfceEX5GX3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQ6LGifhzFbI8MIZ/g1lP/g+7dP3iYeF//xJaAJI5cU=;
 b=eJmmna1FSHveUKLnQIY9cvtHbkxq6bvylFba2WF81NQ76PCb8tKYnzliAUccBLg1E+yg3hAwP8mhRiw1tky30MPlvpYV8v6PlA/UBaXKFqx3XvzPIc1WZZzZvCCBFgLsxkCqf+0SbKy10A+1icCRJvPfoIxIjNR+rFGkjnhyynQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Mon, 1 Sep
 2025 11:29:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%5]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 11:29:21 +0000
Message-ID: <02454834-467b-42fc-abd6-e6e46934b515@cherry.de>
Date: Mon, 1 Sep 2025 13:29:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] tools: rkcommon: Mark rkcommon_is_header_v2() as
 static
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Daniel Golle <daniel@makrotopia.org>, Maks Mishin <maks.mishinfz@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Yifeng Zhao <yifeng.zhao@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 u-boot@lists.denx.de
References: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
 <20250829081628.2327372-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250829081628.2327372-4-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cc690b-fea5-4d8c-bc56-08dde94acba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWVERlovWE84M0NDcFdoSWpXZmIwWGNpYWVVTUFBK2VLVjA3Tzg1NTBPb0dv?=
 =?utf-8?B?cVY0K0dZbVlsZ0l4SHpBeUxEYnUySTk4TnVxWUJvTzQyUFFHTmZmMS9wNitn?=
 =?utf-8?B?TUxaRGZ0N0FVMHk4bFIrWHF4bWtXRGJHY3ZyS05NWDFXbUZPYXJHRkJkWkUw?=
 =?utf-8?B?eHArQzg4eE9kNGc1SWVpbXBKdXFZS1djWktoYjdKTnc5WHhlUEY4TXEwRlRM?=
 =?utf-8?B?ZlBMMThqQmRHOWZocTNBYkNXb3NlNGJFZldUNXcyR1l2ejFhbzA2YVNGcVJo?=
 =?utf-8?B?anUxSUJUQlh2NmVPSnZHem1ZTThpclV6cGU2c3F5WDdVbzlOakc1Yy83S1lN?=
 =?utf-8?B?Rkt4M0wyK3dVU3pQZHUrL29PMlJ0TjFLdHdoZlRvY01oaGNXTHZ0Nml2Tnpn?=
 =?utf-8?B?RHpveGttN0pHV0I3ZXZaRSt1UWMxYXcvRXZkOEVRRUFuQjl3UkY0N2tLQWJs?=
 =?utf-8?B?TmtvUkdiaExzamxsQnBxd3JBcVdVZkwzOHkxazdBN3JIOHJSUnkvbGc2TVZ5?=
 =?utf-8?B?SjljTUZDSGJaVTVESnhyZWU3bVdZVU40TVZ2bkFpc2NRcko5dlNuWExHVFhD?=
 =?utf-8?B?Z2N1T1FtVFZWWDgzemRWNjd5cVdFRWhHbnlKc09rTFd6SnBsNnBkUitWSmJL?=
 =?utf-8?B?ZFk2WTU3UXdsYmIxNUJqS1RYMUxkbHhYUmlxdWRJbjVTeDdJZjZCS2Z3TG5l?=
 =?utf-8?B?NStybmJMVmtUSFpPc3o2N3NHS3NMSFpuWWtrdjBNaWJRazVkQ2ZlbjhRSnFN?=
 =?utf-8?B?d0UvZGVZcHljbzhsTzhmYjkzbVZiSllTaHhIWE1aMWp2aFRWSzNvM3NKNkVa?=
 =?utf-8?B?N2FQN3dJalYrU2dxQ1AyR0xyTjhUWSszK2k1bGU0dWFFMlhmcDVoMURpU2sz?=
 =?utf-8?B?aTRxclFoNGl1Z2g2ZnJEV1A1QTJQQXZIYllncHlESHgzYkZPUmZ1L3o1SWVK?=
 =?utf-8?B?Z3BIcU1lVjN2bm1wZWNBd1BsMXoranlwWEV2M0YrNXRvQUFGQlBZOUVHZ0l2?=
 =?utf-8?B?S05Ja3ZsWjA2OFdiWG82TTlRLzk5WUozeXlRVmlVaDA5dXRsUUN5bm9yb0Na?=
 =?utf-8?B?Vzh6WWJFcWFDS2x6TDJ3eFlHOXVVRlk5UXB3cWtMTmtwdEFDRkhES1JYTldn?=
 =?utf-8?B?OG9WaHc0Q1pRT2hwclVQZ3ZKZkIzNTBnVWFiVFJCOVNIVDJmT2dlMFQ3NDdX?=
 =?utf-8?B?SitwNnNUZlNObnBnNlZPbnBSSXRrYzh5d1l6SlZKQSt4MjNFWFNrU2JQNThp?=
 =?utf-8?B?SG01cEgwQXJNTWtCcGdod3JvcE51RFdJTG1CNjVWT3JiVjljUStpT0ZSb1Vj?=
 =?utf-8?B?M2o0ajhtMTFmZmtOb3NReldHYmUrSU55Vm5PVlNTSlc0Q1BpOGlldm9UTFhI?=
 =?utf-8?B?bDlMVGI2VUZSSk1xcVJ0V3pNaDRuS1VkY1Njb3dEUWNlT1F5UjcxV1BtcW9u?=
 =?utf-8?B?ZHBTam5rYmNHd2VNakl5ejdQa045enZLcFV3ZHc3dHlKNWJIWElNdnFyYjFh?=
 =?utf-8?B?WUczTGdXNmp3S0h1c2o0UERvUVRTN3BmVUtVMFNzVzU3Um50Uk13bFVvUktY?=
 =?utf-8?B?V3MyRDUzNnhFZERiVW51VTlabFZaUFMvQi81RFh6K3plR1JBb0xxSWZ6czdY?=
 =?utf-8?B?U0s4SnBOK3pyVDlHZHdxSk0ydC8zbzJNbVQ4WHpuMDdQaHpVWHdwOS9RcTFM?=
 =?utf-8?B?N0RhTE1hNE8xYnA4ekVMSVdMWFhFckRBV3lTalc1UWdqL3VmTGwvWjVFYTc4?=
 =?utf-8?B?V25oOGZ5MjB4MVFFL3NqU1ZFVFF2RHNHa0laekhmRE5ZeEY4OHZnekdNWFJU?=
 =?utf-8?B?eEpCTWg4ZmFlSEpSK05JRFp5dk4rTUVRek9zMjZyMXlyZkJ2bjRXcGpIM3k5?=
 =?utf-8?B?UUJhZkVsMDI1aFNvRWR6Sm1NMDE0aTh6cEw3QUFUc28yTnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJ2dTBzaGJjR0loZEhLYlBySExaY0JvUjlnbzZoYUZoTGtDb3Z3NWNqbmRk?=
 =?utf-8?B?Tk1UdDlhTVJrMnVJQ0p4ZkxMc0tKcWRsZ1ZTeW0zMFlxckh2NEkyaUFqUVJL?=
 =?utf-8?B?S25RMDA1M0lPZXJJT20xV2JndjBQaFpOQk9SKzVTYWpObDN6V0E5TXNDaFdE?=
 =?utf-8?B?bG00ajlDQ05qczFJOUJ0WU5CTzZzUDhtcUlyQ3BHaktjam0xRUh4Q2VEbmNS?=
 =?utf-8?B?K0ltU1hvaElrUU1xcE5vQnUwMlM2NG5HVkY5NUFnclFtRHdZejZRR1YwU3JL?=
 =?utf-8?B?bkFiR1JkL3lqdSs4cUVTVWg0ZDlSRW1GbmpNeENWaTBQUzN1ZTVqckczVllO?=
 =?utf-8?B?eWt2cnphLzUwMkRwZ0J6eW5xL3BtQmNpQmFHM2lrTjZTSGEwdFV1Z3RZZXVm?=
 =?utf-8?B?aUI0Z0sxNkFVdk51bHJObFlGSWx4aDBYSWg5WVp0djZVV05JZVFFaFVvM1h0?=
 =?utf-8?B?YTVYUWs5ZkZucUZsQWtoTGkxaXNHNisyUHJ6OUU4ZHNNZm5xQlU3L2UvODdC?=
 =?utf-8?B?UVhPeFk5SkdZRnVTcElCVXZJSVdqWXhEcGdDZ2l1aHVNSlJUMmE5SDlpZ1FR?=
 =?utf-8?B?WU4vRStuamlzNURWNjQ5S1ZlQ1pSL2J3RmlpTXorQjRYRVd5cXlETzhiclFo?=
 =?utf-8?B?QUlwbXY5dDdwbjJTMzByMVdmVnVKNjBWcFhlTVNwOFJidmlkM29jWmRRcDJj?=
 =?utf-8?B?YmY1WjlycElyRGpNQ2w2ZlR0bHM3bXQzclhnbmI4Z2RVTmlIazFuU1JpbTdB?=
 =?utf-8?B?RjZRNXZNUjh6a1dBc1pvNGwyWUxJR0FMN0lHUEMySm9icGh6V00vNlNZSDcv?=
 =?utf-8?B?NmY5T3VxK2xaVW16eVFLaWpHYXNJbFYrMzRxdmxBRnpab1JkUjJDM2JsUUVQ?=
 =?utf-8?B?eEtrTHhkanB1TkYya3VkbVVodnJid3AvRlZ2eGMramFSbXoxWWxMRTh1bTVF?=
 =?utf-8?B?SGFzUHQveUFZaEpCYUs0clpWOWRyQkJYYm82MDVqMUlVQzhGdm5WYUlvaEpz?=
 =?utf-8?B?RDJUa1U4U2c4elg0YU9wbUhwZndPbFNZUGIyNjMvU0lTblVKUTdCbmt5aHJT?=
 =?utf-8?B?dW1VMmlyaCs4Y1Z3K2hidTBGSUYrWnlNbnJucmplaDMyTVQra3hXb0RSUkNv?=
 =?utf-8?B?VDNtUmU1Z2dRTW5YV1h0YVlLMVloRHpJUVg0V281R09BNHhSSFU5c1MwUE9O?=
 =?utf-8?B?bDJTejczWlNxZkVNWFVlZWNvakpXWlkyMFNJTTFPUTdCVU92cG00Ykc2d3ZJ?=
 =?utf-8?B?ZWw0QTErQUV4YVROZnFNRzI3ZWIxMG5kVFFpVlFBblZHODZIcDlpT2tWY3hj?=
 =?utf-8?B?U3FiZ0NSREZ5R0Njb2JhRURRNzhGZS9adVFveGRqanpOQjBHbUpSdXBOY0pD?=
 =?utf-8?B?UzhrSHdIKzFDd2Mra3hqbzdjbmJobWNrSDgxMUYwVGxTdTBidXlkQzRrNWRX?=
 =?utf-8?B?dExISkhzb20vTTM4ZmZiN29DeVRlYzR3TkNVTVNvQTZSSXFPY3Jjd2RmQmhY?=
 =?utf-8?B?cXR5SzNTeExmdG02Wjh5N21pTHowdTlCMDdZZnpSZitYNWdnMmlXUGxNcEM3?=
 =?utf-8?B?ZHFVTSs0TUFZUG5pbjUrV1NzSll1QXZ2ZjZYYy96bHdvUG5NYWlQUTEzUmxC?=
 =?utf-8?B?UUtwbnlucjg1dmhWK3Faa24xVHJleDNzbmFwaER2N1pWR1FPTm1DeVBMMUNB?=
 =?utf-8?B?a29FYXhnZ2V5UTE4dllJZDNLRmtRcDRvSHd3YkF3NEpkQkR3U3Nlbjd0SHB5?=
 =?utf-8?B?SmNpQXg0cHU1VS9MWk51REJaeVpDTm9NTDNuNkRBRGxZRnRVWUpuSVFGR1dV?=
 =?utf-8?B?MVFlTlpxMjlNamhVNkw0ZmF0bDhCQUhhcGlCWWhSajlOK28xck1KajFHSjVR?=
 =?utf-8?B?KzUzQVB3NndXQVI5NTJSZVNldTRYbDFyZmF3KzB4U05VYUd2T2xucHdvWDZX?=
 =?utf-8?B?alBpeEVsNmNXWFFqeFJvbTk4K2UrblU2eVdQaXVlS3V0LzVNaytLdTd2QmV3?=
 =?utf-8?B?R1RqbWE4aHhwVE5IQ1lUMTJGYlRwbHozWWdWdlFQaUEvQ2tRRnNvY1hYUzlP?=
 =?utf-8?B?b2hybEpBOGN2NG5mS0FSamdwYzhKdW5oZEtBN1BZMlJhcUpaUCtPY1FlTFd2?=
 =?utf-8?B?WDdqcjlMNVRrYlNOWXcxa3ZRREZHZXQ0ZnJTUFpycXBsN3FqQUo0MUdWQVJ3?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cc690b-fea5-4d8c-bc56-08dde94acba8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 11:29:21.2443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: me17/ZlEKvklvcAY63oUNgJ5uzsbP5CljASmyC+gKQMqxgaiO0C0+Foh5j62t7x3kas5Y7KemWtwYQOxKmfzQiu0A0aiw7p+0aCxL2Quh4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326
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

Hi Ilias,

On 8/29/25 10:16 AM, Ilias Apalodimas wrote:
> The function is only used locally. Enabling -Wmissing-prototypes
> triggers a warning. Mark it as static.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
