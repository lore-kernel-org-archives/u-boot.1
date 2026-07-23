Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7512DC531CA
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 12:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2890E608F7;
	Thu, 23 Jul 2026 12:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5tb4OyfGem9R; Thu, 23 Jul 2026 12:33:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B77CD60792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784810015;
	bh=QQw34GGaE/ejUn+ohJcr56ofUGICC1cqEeMojkz8tJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sBfcduNe8/12GNMlSQmgde3F7tocIZAv62Kusm1bGIDBEbYDxzQdcQ6rzicbBaRoM
	 8xWzaLIVIQhvR3hKBzaHc/7UMxEWQiqzf7T2YYH7128hYqacnqbBK2x88UGyin6qiP
	 WV9PlhRRwiMUF2+i45cRoSsBnL+AJqpbG43jkS+CjDT3dWV4LpEg+Eapv7LT46HXyW
	 TZlEf8I1YQa9inweDguOoxNwtGUCK4WKzykX/R3L3+doW842Tf+05Cje4K+EZd4t7c
	 2x+4EAhKx74K73oGefr4R8TG00P7MG0Ja6w2up7Pdn3M9vPoGjibfOCwHOmROybiwe
	 4YeEq240VrLnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B77CD60792;
	Thu, 23 Jul 2026 12:33:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B37D2E5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CD0040702
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9zh1S8aDZq0c for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 12:33:33 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2D669406F0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D669406F0
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D669406F0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:33:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CDC5803F6; Thu, 23 Jul 2026 14:33:30 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F0780117
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:33:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7pIsKpQXH3RAJ6o+5zqpKzLUhNpQWqssBsw6vrkpVNk468qvxYmJJO6X5gKbiTqelrtjT3nygatKPPqMyCf8aXJuJ6Q7xO+9ShjeDmkYrt5zKqAI/kBiYJPmujFcQrEdAqPFo9iS2Ke5Uwkpx1SK5xgF3neeh9oB/cjig/0kb53wKMa7n7M6frK+lC1a1B9pU+kjZY593AZQcdQLB7XbhgW+eetu419cY9OLpM5leEvMTjKIf6g+Ob2mqq4vy/DXPJwSM5vUpq4xlMTi6FFZTdR7KsRRVUQ2f/3Qinou7L+W06O9vWd3snGc2CAYGWyWTQ4wv6x1N2i2aRcVXQhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQw34GGaE/ejUn+ohJcr56ofUGICC1cqEeMojkz8tJ8=;
 b=Xs8uwlFmRpHgq9/fbdkHEfaXgWC5SOnvMzUU8WtIFhS0wodV5Wgt3a71Lry6WN942eWXiv2MYDFA5ZKvBRgWPubQNXLs+nLiFC0sUB8kb1dC6JBvl7lYeU4hpSUWUoHrXvL6WRYiTuwFeesl7M9L+Hz5raqCW5aYO5RBUoxsnTwiw6EM7Ot8SmOsCxIrWCU+gJouInn8XOOtniVBY9s5QAkCbB7nQo3/IFyLzfvFoqT49KIHUElGGDtQ87jv3yDe/jlxEbZyNqtEUJTPJOg3hDXBvObsBFycyfr/UiWRH3C02rfD+/3o0ghGTx26t4U/toka9jc0ROS2weK5N894tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8931.eurprd04.prod.outlook.com (2603:10a6:20b:42e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 12:33:25 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 12:33:25 +0000
Message-ID: <a296f47b-99ab-4d8d-8ab8-d185ed47a701@cherry.de>
Date: Thu, 23 Jul 2026 14:33:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] clk: rockchip: pll: fix overflow and drop manual
 two's complement in rk3588_pll_get_rate
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>,
 Jagan Teki <jagan@edgeble.ai>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-6-cdf47f2ca0b8@flipper.net>
 <88436f3c-079d-40b9-99f4-791ee3adb192@cherry.de>
 <CAKTNdwG-yKiDeh8qH0pQgfyWHwkDT8+1jTR_8soOU0Ffc23OWw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKTNdwG-yKiDeh8qH0pQgfyWHwkDT8+1jTR_8soOU0Ffc23OWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0135.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::32) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a173f1-047c-4d6b-33ac-08dee8b69782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|22082099003|4133799003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: HItc4vljlVMCFdFBN2r5Bh82u/Wk0MdM3pNnOGMzGrkZXHhP5/wMi8DT4IHlvOFzTSdSsz1WH7FDCmCqd8q/jKwXzMyEFIIrbIvIs4Yt0IulIGUTuwnU6nUtQ7mqa11s2WqVk+Gk/auAL7Anx63xoaBb/YGCNAXT1kMrDgcQC8Lexp7EtPEuoq1D/NNe/kHtAcWpnTbwO0ZElyLfzhZtboEv8l0ihFpplnMDV6hH738DN0uf27LzuV0wU55LK0++WtR5nqIvdVNP70nRP4RGpUBHUThl2OALbdY5dXird4evVYQCjnA9b6d+n7foPa6g+C8cxQ1VQNSQSZytc6goqFdYVg8muIO+AwoB4lqCS/gCwP6ou/ZQhm2LgcCcW1+Kp0L3rZs3U3UjEe+92mA8WnC/wNFTOzbYSIPWpvcF2NcGySn9EfvRw/CWhu0i8qzY8r2lohOjCxfR2ItnA0Po+7kzXaIbTI84/E2zMNTW3wbtvGu8N67qVY93T69dZtC2SsvVmA+0iNxAmDfPFvsXldg3105X9LWZTtNCmbHAx9MBT4GuE2wC57lRMwKj5EJCJgw6q/Ip1EapDuH5TkA1wePKTyd4FhPHQexz+LxIYFBvP+MSw/c9UhLnvgYf0TVX73vaOOch6AN/gGujyr0aR4HsvgBhKiJRtCBsTCQprBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(4133799003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmp6RVRPbDJTNHdXL0NrQUoxN1c0VHJWWkwwOGJNWFdKNmVQTFlNU2JncURC?=
 =?utf-8?B?dGxWdHNuZGwxdGgyRGhmTDZGZi9PdDdmeVNJcm52R015MitJNTFjTU9ORjV6?=
 =?utf-8?B?TVhaQUIydWlsTFlyQlpyS2VNTGNDek9CUUw0MmduZjhCQWNEVDdzOXFSRFRK?=
 =?utf-8?B?U0xNUkJDUUlvcVRZamZldllUVFF2Ri9COTZZd0piWmt3SWk4NVoxR2lONy9t?=
 =?utf-8?B?VXpXcmphS2N1Ylpjd2VHbWZNYUZGbE9SbFJHQVRoQVBEVWJmUDRPTjdqRDI3?=
 =?utf-8?B?OUUrdGVpR2hXMlRBWkxsemx5ZVBsa2pWMkNibWpZeUJoUnhoWkpucnVOdmVV?=
 =?utf-8?B?UGNWNnFCU2NLOGJFRXRtVkxkeHBqOXIwUmhqaUFBbEJscHBBSkhIZWZjS1FY?=
 =?utf-8?B?WFZPaXFIaXV4TDg0c2pLaHNPSW9qRDNoWWpvTVk1K3ErQXJWUGMwa3cybnJJ?=
 =?utf-8?B?dExiNkhYSU5CL0xrVVVuQ2lCSnplSmdKWlc4eWRLUEU0cmk0UVZ2UjNKQmhW?=
 =?utf-8?B?eGtxc2gvTlI3bzFLVWxlWklKTmVWaHk2VVQ3eDFyRi9hZk5Fc2Nyb0ZBQzB6?=
 =?utf-8?B?bW1OeDNiNUV6Z0ZobTM5Z3Nka0ptQkVTeVNRUmVSaEVoQjBxS1VwWUZWZVBw?=
 =?utf-8?B?U2pCSDM5ZVRmdWpIZGRVdzhzTjYrdXZnRzB6TCtaM1FzQXlZMXNZWkxEd0pN?=
 =?utf-8?B?UnFJdjdVNlMvRmt6ODRPZTRhUTcxRjZMYVBUMTZ1L1R5ZGVUTjRKc0xnTlps?=
 =?utf-8?B?R0FhRVFUVGlla0IxK3lQSjdCNXhza1Q4NkNtR09GcTFPWXRLMFkzZG1JdGNV?=
 =?utf-8?B?bGRZMkw5V0c3bW9hZUM4cGFkdnFKOG9OUjVGS0JtMFIxa2NzS2p4RkN3L3Zn?=
 =?utf-8?B?QVJ5ZGcwRFJqNkVZQzh5NkFZWklUNTAyR1lkbHRNWHM0ZTdSUW1nRjJFSXRW?=
 =?utf-8?B?YjlrdVZZTlRKMGJuNi85d2lOeFlKWTRhdGVCRjN5WkJ1cU5ma1NLQzMvYUNm?=
 =?utf-8?B?eG1MWEM5bVRxMzNUc0dEcW1sa041OGloQTdBTXQwTFgxNzdGYjhPSEdIOExI?=
 =?utf-8?B?VEMzSUNwM2lZUnFQYlgzTDl6cnV1UUd0TXEwcWU3aTloZEFEWFZxUUMyMldI?=
 =?utf-8?B?N1JlTm5kVCtkVXZsWVhFU3FrQlpVbEFHbDBUYWNlSGpHcktSR1E2QnlSbXNL?=
 =?utf-8?B?dlRFRHBjc1lEOUdTQlM3b0tBRFB2YjlRNmtKRVN1S2dyazVqS0RsdThSUWNy?=
 =?utf-8?B?NjdWKzR3aXdDTExheFM2QWtkNDVUWFh0WGpwT0pxdDhmTGdCYzA3R1FMZ1hv?=
 =?utf-8?B?TktFdklteEpNd1RtUzd4Mm9Sa3RqaWYrWVVod2NFYWxpSmhzWnJZRDZ1NFRQ?=
 =?utf-8?B?Mi9YblBBMTU3SmV0OU1lVVVlTWx4Szk0b0JYcXcvTFZYUVg1UU5makZzazRX?=
 =?utf-8?B?R0w4Zk5lVVRkWXA1dWhMZHdTbVQ2WlJFWmZZZXdqUlVFbHdiUkJveHZQRXZi?=
 =?utf-8?B?TEVZNlVVK2dsREF5bFlHbTlnLzB5dm05Snd3UENsUW80ZjBsUDRjZEhBaHpv?=
 =?utf-8?B?S205VXFqTkRNUUtmU0RwdzJZTzQxaUN5bnNmNXdtSGEwT0swQWhzNnQvVk1H?=
 =?utf-8?B?L3BNakkrcGdvUVhsVExyekh2amlqeWtJNVdPN29HM0VvMDIwN1Qzekpldjg2?=
 =?utf-8?B?RGJZQ000alhLY1RLNEpQMzlDbjhZL1VuT2lHREhxQmJyV1NHR2lFT2RpbzVm?=
 =?utf-8?B?K2ZtTUhwc2syZDU2aExiY25hZldLdW44ejZPajVMbUI5NXpyK3pDOUFUbkFM?=
 =?utf-8?B?OTRUemkwMlhlMGZYL3lIcm01akg4WElhV1BWdThHbUN4dSthWWxldzlZcklD?=
 =?utf-8?B?TW4rQTFMc1BHT05YamlKTFZiRk1VQit4SWN6bmMreFBkWVpKbHpmY25hdzha?=
 =?utf-8?B?dENqNVZDUTZBK2cxUjFSRXQ4REh1MW0waUN0ck92amVPL0Q1a25Fejl4eWdY?=
 =?utf-8?B?SWFmN1p5UnV1Ti9kNFJDOWUvWTl0ajA0aGI5VVI2L1JWYVdwRTFsMFhOVXlI?=
 =?utf-8?B?d3VXcWlsazZOMDlrTlJPUXV1NGk4VXJrbDN6RWJWVlVLY2tYblBLL3dYUjdm?=
 =?utf-8?B?VllqMkdERm9mQ2ZncVJlVmRZa3ZNNTFIc251SWFCQW1IVWRDd0gvWWJYNjhm?=
 =?utf-8?B?NlNDZ284eWdsaEgrcjlGQlBKRHAxc1JlZUJEVFU5WGhycEtLeWpnRjhRZVU4?=
 =?utf-8?B?ZmVjUG5ubW9IVGRyeFpLem5NNjJWSzhBOUdKL0Y3UmZ5QUZEM3ZET3NSZ3Js?=
 =?utf-8?B?TXVaQVBvNlBjNkU1SHJlR01ucU5xS1BUU2xSK2lGbUtTaTN4YU9YUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a173f1-047c-4d6b-33ac-08dee8b69782
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 12:33:25.8098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaHgXlI6JPg/Yg2YWEcXrHC3q8jwSO+jNfzFqHmdW5np3fi7mzt064PFgRuyCaAxw1eCRJdiJckkOCiyqGbnpxuxxIhNBd2Jy1aWS9KESsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8931
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQw34GGaE/ejUn+ohJcr56ofUGICC1cqEeMojkz8tJ8=;
 b=gGliMxlvKecF1Sl0rGJyQdCAumOYo5quZv7xaw8OtFVGy5fgk7UcuTgbSQ2dUwlYrGh5JuRjkAKupZW1O+YWxaaymwCEQaEQ13AmIpvox7as6TwB6XwAw7wWha53iFyds0xfuiLmju2zuHQhG3WG2mAuAaj6yDqLQWV/t4IgVpU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=gGliMxlv
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="gGliMxlv"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 7/23/26 2:25 PM, Alexey Charkov wrote:
> On Thu, Jul 23, 2026 at 1:23 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 7/13/26 8:35 PM, Alexey Charkov wrote:
>>> Current code calculates the fractional component in 32 bits before
>>> assigning it to a 64-bit holding variable, causing overflow for real-world
>>> values of k, given that OSC_HZ is 24000000U. It also does bitwise manual
>>> massaging of an unsigned representation of what is actually a two's
>>> complement signed value, which is confusing and makes the code harder to
>>> read.
>>>
>>> Read k into a properly signed type and promote operands to avoid overflow,
>>> which also enables the use of div_s64() to express the math more clearly.
>>>
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> I've quickly looked at the rest of the threads in this series and I
>> think there's no open questions left for me? You sent patches to the
>> kernel for making k an s16 so I'm assuming we'll go for that in U-Boot
>> as well. The PLLCON(2) thing for integer PLLs will need to be fixed one
>> way or another, but I'm assuming this is also something we need to fix
>> in the kernel so a similar approach would be nice. I don't think we need
>> to make this a big series fixing everything in one go, so feel free to
>> send smallish series whenever you're ready. Anything I'm missing?
> 
> Thanks Quentin!
> 
> I'll rework the helper to take a pointer to the table entry instead,
> as we've discussed in the other sub-thread, and update the whole thing
> to match the types etc. of what I submitted to Linux. Hopefully the
> unsigned->signed conversion will then get localized in a single
> commit.
> 

We're on the same page then :)

> Looks like https://lore.kernel.org/u-boot/ doesn't pick up new emails
> from the list since July 20, so `b4 trailers -u` doesn't work either.
> I've picked up your review tags manually, hope I haven't missed
> anything in process.
> 

Yes that's unfortunate. We know, the LF (handling lore.kernel.org) 
knows. The main IT was on holidays and just came back a few days ago, 
and he's overloaded at the moment. I'm guessing there are more urgent 
fires for him to put out at the moment :)

Cheers,
Quentin
