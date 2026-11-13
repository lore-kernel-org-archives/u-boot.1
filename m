Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE5607B589
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xWpDLE2n;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=c/WNPa0m
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F283040DA1;
	Fri, 13 Nov 2026 17:25:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id frgdPuFKUhRq; Fri, 13 Nov 2026 17:25:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0FFE340D8D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794590739;
	b=LhS9EdIybfFFrMw0Ot3upXdg9ADsBuqSwFDnOHg+DeQI1zBYXdATW6MAzuIETqiccKCK
	 4ab3Z4J0N+uKuBvg6RQAu9xV1aT/w1BVPNECUmqe8U9PU5XWKBsHHWNlluhZzOsXMT342
	 KnYXX9JCMp+2YVLkIwgooDJ8eWOtJFvJPyiE9u2k1uMqM510EW4nsmdyFqDQ4Botqm8QU
	 S5kHkgAFodKnZcDayl5b77pnp9jPALa9dkIyXIHdNKfm5klcvpe2R+SHSF8Jq1+J8JEQO
	 RRKHvVPH58xmizBQ8I0dWqSih+hVWKwNdXQz3Xe/wKeESGzn3g1gvqWkdKQgAjBRsfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794590739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1hSffBNaoOc6GyzH2vH/Yh+Wv1PcfQvD+7+87zt1GLM=;
	b=YYBX1Ib/JNlInJueK6OIylQZu+sY/5Z/1y0LYJf7IbOXgwduJCkaSoyfLFz9v/TRU5Qd
	 OhxOSubpwiV1dNGmEPgymzLNyBOwzooOhd1lJrM9UOaHLAFSRNymqDQhjLKK1t0f18ep3
	 2GubmNp4p6JYdGayXKtVGjB5Ad3mDggNtCwkUtWiTpkfAdFJpOVjysAVug13P8haKwMiT
	 kdJYxafghVvcbgvdlvOj+dBHEFGr4hMnPj2oTB7+mj0iKaqsL5tIcjvvtO55tHNS92L0A
	 CLOftXYqj24HSBbtZrL9IBI6Yv58Fv3QraVClwwhhN2wXmf38OQ/K8NKLXsAn7uw4+w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794590739;
	bh=1hSffBNaoOc6GyzH2vH/Yh+Wv1PcfQvD+7+87zt1GLM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xWpDLE2nM4xVvW+9t4/a1UzEf5VqaUs43BKBxohAUNEF5SdMsrEZYzf3hdMXUyGwd
	 PtLiKK/jrF9saI47EeBS7Ut2E1qUw3sOXHDz/6B4qXZ/9Gy/PRu8FRaeV39PuO18VU
	 MJI29Dl0YiC44+BBqzwNHMptDsjd0cMlPkmtryIIrX87vM8BVXOLH0Hs40UHklRUy6
	 TPEL57RTsHgeXPOd16/HXVHyf7o1ERozP2WAJefkJhs2CtbiB2VTxKkNGQsXGHcCSI
	 nClZyBrGPvR1Y/7WsN13PmV0VCdVjwRWh7INp+DzN2I50t6WytTCRCARRridwdBM81
	 Oy7yip+B0koiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FFE340D8D;
	Fri, 13 Nov 2026 17:25:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA548F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C02C981063
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:25:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eYCYHnPwqoaQ for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:25:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD9558145C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=c/WNPa0m
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD9558145C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hSffBNaoOc6GyzH2vH/Yh+Wv1PcfQvD+7+87zt1GLM=;
 b=c/WNPa0muSAVP5Mi9l5uFQ8YTqpCRUWMKDJw4kA7l9iPQhNMV7AvOVo7+5sCRNV05jYEG4ORE6qroLNNoYpRbhpNkXWhbdZ8GpAqAB128zfjjyiuZBx3qsxgHH9h/Mdi4nuo7gDG4/SqHTxahjxjZwjMGSgkAF5FVxHlz9bUaYQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MMZPR04MB461369.eurprd04.prod.outlook.com (2603:10a6:190:53::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 17:25:29 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:25:29 +0000
Message-ID: <57bd6b96-159c-461e-8d41-34005d538369@cherry.de>
Date: Fri, 13 Nov 2026 18:25:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] clk: rockchip: rk3588: Rename PPLL register macro
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@nabladev.com>, Kever Yang
 <kever.yang@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jagan Teki <jagan@edgeble.ai>
References: <20261111231251.160051-1-jonas@kwiboo.se>
 <20261111231251.160051-7-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261111231251.160051-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0078.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:352::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MMZPR04MB461369:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce66cc7-22e5-4506-2493-08df41ab1cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261028144727099003|10067099003|261009223027099003|11063799006|4143699003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|56012099006|261102123227099003|261026140227099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: IbL7Oci85aF+rULWJWXqd9dPF6xopjfNWiNvkm6ijgoLSPyqTvZzg3HmzT9bz7LaP0rJgveo+BzG2CXksaGVUwVS0Xf1PDRuF4mrUiC17hBj6qDJhnvLBh2pB/m3srljq85fj8+EIDftaAz5H0dL2uaP7rj91GxnA2BJmKtyPlNgw05Lb7gaaZeRkPFRAsNLUeg5MDvmwcJXYig11Axvhfnt3ER+4JnUxLTE0QLcEtIaekiEnUE+yv/Bw5m+QFoEGXRWUrhUqP0LiYK/RhH6Pw2QH5wqqSAP1SP4U/S5XVX4hHAiWqIgR0xgf+an74kW83kfLF/hIsog5Uh1ddjlHmEN/NWtvoB0HnFkGzrmzYIpK1F7yljDmiNzS78C+gbMgTqKh6M+2pffAyIUQRGA0YOyqQL3AgAB2Uvg2s4l0joVuuhJpdEKz++aIXJdxcTqTQlNEf6kC67tViyZ6fKkx8LbN7yvgv4edd63nGfceoS3qSNnJ+FZOtGckpfIoCm3qe48cZoECw/z/4oEuGeWt98/2qPx0rufVRo0+edxaFyPWLymm9e5Nv4/w83Cx07UlYdEu1M7pA/zsH7La6G4hWie+L5il1xyrN5Z5W9bzoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261028144727099003)(10067099003)(261009223027099003)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(56012099006)(261102123227099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWxXSEprTDhKNkdDRUdMTW5laU02Qi93UzB3QXQrd3dxb1A3ZWpCQUlTVVFI?=
 =?utf-8?B?bzdSbm1MUy95UUVBM29sam5xaFFneGdpV1pNTUE3cWpjTDAwQXYydlN4U0ZU?=
 =?utf-8?B?UCttRlZDOHFzWVRwSkx0SXU1c3lWN1RINlY2V3d3dFI0aEJkQzlWeSt3MDh2?=
 =?utf-8?B?eHY2dW4xTzlySTBDVkYvSEZKenNRRG40c3VkeE96L04xZmVLbHMzdGJkaDdP?=
 =?utf-8?B?OVdDUWc1VklBQkZMejNmNDRqNGRJc0J6aUJzLytYd0wzSnRzUWgraWhVYmw2?=
 =?utf-8?B?UlI5SEhzWnZ1NlJxa0VBT0NBOG9BdkdhZGp5eHRVL2hpNEJOWE9uTUxWeXYy?=
 =?utf-8?B?SjQ0YUMvaGNOMnRubXJGalhEU29idHk0bExTbHpYTjRRcjRtMHl2TGMyTUZJ?=
 =?utf-8?B?VHppdDZNckNPQTZvcHlYbllGMHk5dHNUR3IyRmVtUGU4Vm5ybWJIWUthdzdp?=
 =?utf-8?B?UVdobUtvenJCQ2xLQ0FYUCs2bUVNNGdUa3I1RVQvNFBwR2xJa2hWSUJtUmtk?=
 =?utf-8?B?OGJtMnpCbHhYZCtETzRuWlhvTFhMd1hZa2pSOWdGVzlzWlQrYU5qbTE4QWRt?=
 =?utf-8?B?NmlxUGNFOHRsUWtobGt4Q085d0NNT2VQajcreS8vam1hbGdFdDlhK2NleE1H?=
 =?utf-8?B?eUpUSHNlcGhWL1FwalFlUCtxMGNiekhZdSt6OElLY01leElJSzFSZk9Rb2NG?=
 =?utf-8?B?LzhsVUpPN0xFRGRFV0xtUGlRRFVYeVdxTU1hUXhtM0ljc242MkxjM0NYRHZK?=
 =?utf-8?B?UU93YlhLeWF0bXNHRGg4VEltdHJGSk03TVU0c0JOSTVlSGVhSkxaSFVQd1dC?=
 =?utf-8?B?U1hOQXV1aXJlY2pxUFg3b2Rkd0V1TDFwY1ZpVE90bmJQaFYvRjIvYXdGSjBI?=
 =?utf-8?B?MkJ3MlhsYm9IMWlKYWlkOU4wQlFDaXJDVUlCb25tRFMzQzVyNkFlTEUrVks4?=
 =?utf-8?B?a3A0Wm1xYWZxYlExMi9MeXY3bnhDakdNcHdZUjJmVzBGeWlXUW1MSytCZEp4?=
 =?utf-8?B?Q2xkdDczaWNBOHRJbExLYXc0ai8wQXB6ZktTekFkdU1JajUyQ0lld2hIMSt3?=
 =?utf-8?B?MzNyT2FTODE4T09sYUZJK3NtaTZtT2c0T0VQdU5Md2dLSVFmc0lVUDVCdXNP?=
 =?utf-8?B?TTZ5K2JMYzVwbGFuYUhUdFloN0czeXRNYm9rT2tGcGpRSm9zSDlIdEMydVJP?=
 =?utf-8?B?aWk1WGx3RGlPMjRvYVpvTHNid1dKY00xaVYvTk1OaGRiNEhrQUNBNDVFMTM1?=
 =?utf-8?B?eTc5WHVsMmtQVUNobHpXRjlkZ0hLbTRqOG9NcDdva3c5MWhOY0xFcXFyWFBv?=
 =?utf-8?B?aDhGUHlLVjNYR1RXOEhpcGlLMTZ3dFIybXcxQ0VVWW43U0R6VjN2YUF2cEJs?=
 =?utf-8?B?YWtOT2FuWE91NThJTG9oaXRHUWx6d3hocWlUbVk5cTY1dGwzZzk2VExKcWQ2?=
 =?utf-8?B?ZGZiSlhJdHYzN2s2ZlRXZTNscEVhdUY3NXFKblRFTXNETFkxUyt2Z2s5OE4x?=
 =?utf-8?B?Q0dzdmdIMzFzcXd5ZHlJQ1A2MHVUK0xHOVRFaUk0Y2lvU243amI0RUMyeUhu?=
 =?utf-8?B?Z3JkcmFENXNWTGNIeTJlWDB1aVNKOVlnQitOenpwaHIzempuY1p2QkJlS3Ez?=
 =?utf-8?B?a21wMW4zOXhIanpHaWxCTnlNZXdMcmpXU3Yydm4ybzE4VTB1eWFhajdQNmlM?=
 =?utf-8?B?MlBQSnpaZnpzRVR5ZFhWQmMyM3VqR0phcWJOem14SDBWci9tMSthWm16WS9W?=
 =?utf-8?B?Njh1U1NCamY2UDkvU0pTQmZVaGZ0ajBuVTNGUXg3MWRBSnRveUN1cFd2UCtZ?=
 =?utf-8?B?c2ExTHd0SGsydFhXbU9uclZZK0x4QUdsMzhJc3B5T0FmMDFOM25tTThYanlp?=
 =?utf-8?B?bW1scXhFRHBuNlF4eUxZQnhybVczQk1hdlRtSEY4bzdrSENKNk9udHlzNWlK?=
 =?utf-8?B?TUYvNGVBVUJ0RlZYVXdnVnE4MEhLbVRnOXkrMTd4eUhhQ1c0SVVCd1VBSHVG?=
 =?utf-8?B?M3VSdXlUTlpxU3JjT3pmclNhd3Z6UXBJbTR2aUZLaHlnaGorUms2cmhxd3Zk?=
 =?utf-8?B?cDA4T1FFVnJGRXZnYmk3Y0ZydjhRV3ZSTkhtMk81YWZFZjZRbTZWOTlDaFhz?=
 =?utf-8?B?L2hqQys0aEJtUEFqMmpxYTVHZkltUGk0Y1FXcXJEc3pLZ3pkYlpkZDNCcllY?=
 =?utf-8?B?YmdJcm9ZQS9RRFRUVTFMdHFtNEpXM1NOT3VRK2w3VEtoTUFBWTVmVGRmNkJZ?=
 =?utf-8?B?c0hMeEFia1NtQXBKV2oyemM3MDQ3WktBMGIxbVZvYklSQVJ5cFRQMnhoanlx?=
 =?utf-8?B?WFFPdmlWUnZWc0VmV3gzUTk5cW9CalFuVzFKQjE0cnFRSmw5RFlKZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce66cc7-22e5-4506-2493-08df41ab1cbe
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:25:29.1692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hA4z9xmwmLtqP/j7GZss/PUx82KFoOUGLUu9+kN6waT7+9a/9Krmv257lJXt8KoaQEe472gi4Ab7TYJfzCqIrXmIOIiC54I4GV7hdr3XeCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB461369
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/12/26 12:12 AM, Jonas Karlman wrote:
> The PPLL registers belong to the PHP CRU, rather than the PMU CRU.
> Rename the register macro and update the PPLL entry to reflect this.
> 
> Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

I had a few other things I would have liked in this series as said in 
v1[1]. I'll do a follow-up with those.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

[1] 
https://lore.kernel.org/u-boot/9a3af141-7a1b-48de-8156-026a09146455@cherry.de/

> ---
> Changes in v3:
> - No change
> Changes in v2:
> - Split from "rk3588: Fix trivial clock configuration errors"
> - Add fixes tag
> ---
>   arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 +-
>   drivers/clk/rockchip/clk_rk3588.c               | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> index c83010e518ee..39295adeb38a 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> @@ -126,10 +126,10 @@ struct pll_rate_table {
>   #define RK3588_SDMMC_CON0		0xC30
>   #define RK3588_SDMMC_CON1		0xC34
>   
> +#define RK3588_PHP_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
>   #define RK3588_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0x800)
>   #define RK3588_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0xa00)
>   
> -#define RK3588_PMU_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
>   #define RK3588_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x300)
>   #define RK3588_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x800)
>   #define RK3588_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0xa00)
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index de435f7d0ec0..fb218ff995cd 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -61,7 +61,7 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
>   		     RK3588_MODE_CON0, 2, 15, 0, rk3588_pll_rates),
>   	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
>   		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
> -	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
> +	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PHP_PLL_CON(128),
>   		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
>   		     rk3588_pll_rates),
>   #ifdef CONFIG_XPL_BUILD

