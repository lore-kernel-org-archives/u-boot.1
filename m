Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8258606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W8pSNcwq;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=iYamDwCy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1D49813C9;
	Thu, 19 Nov 2026 16:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NpRDwO7m-is2; Thu, 19 Nov 2026 16:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD225813CE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795106127;
	b=LQS0jXpgckM/5u6lTjgZOATJ0MQIVK9mlKIkYBlIL7ejTvcRfFT3ZF7T0MBVaqTFJzrs
	 kC/Qp78l1HCTlPT0Xu4bOfYYQ/6CHz9mtB0vAp5zs47KXdS+0xROPhaoR4EeiyayDoOQD
	 6S5X3nF+pNIDEm9AzHmKPKwSMj4f5IWU/HiTmGRmJLjXKYepT2lltnyhXg+CARW4gNsqC
	 GwFYk+zmSjiRf/XV4pFFBXQUdjEfctIHnenEKZh0CFyaPJsHMphcFggEd67FVs35DcDxO
	 +rJ89+63chRnKAhcnXRG7sv6ZfPYARXunOCZFL+kIgaxBb+3usuuSK0ELHI4eCAodDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795106127;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4womeqvOvW739AH3iOBVh1UcgRlj0wVfAXMOr5bvTlM=;
	b=oMkQHu2o+G5pKJCZAX7rgx0oLoznHocxrYFQDlScKvKQVC0nFyOcT0pIOeIMBS1si1x3
	 sIfeioKEYb4td20BFP+uo8OsFvdcxDnTs+IILoRTYTxCdL7tuqPK+OcGFvwpol/HbfHia
	 /6Yq8yRd2MLOL+a1gvRZYTPWiocE651xCbuiy9pOftS0AUKL0TLJbxGpmYu9m0rimWrB3
	 NhUV4C8ARF87OEZSmnAP/qQXNlToPXrGLpvlLEDhw+0LZaRUvFzJSxkWWPruNQYyl1YLP
	 CN6b0l1uSUNYwu+mg+t2dlKrgNthn4EvkDBdDCNr2EbQiKHcaMw7RHhmGiFysAfk7ww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795106127;
	bh=4womeqvOvW739AH3iOBVh1UcgRlj0wVfAXMOr5bvTlM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W8pSNcwqliwfUrP8+uEBIZwHTUYyQf/GKUqecwW06YbOoTOeewQ61C58SQQp5oxJS
	 i/rePn5itXZcB9bhRd0WYs/sAq7WCr9qVYXVaRaDNqv6KFWHG7QEg+D2dXDc8QuEoA
	 HnRl6Q1eIoi9nfzzJuv5YRsDs3l0+N39Rc96Ls7tqcOeFlW/AggPYa0dEedjAXUxo3
	 O9fVB2JdPTRJanFq5ZboyXjzO/eRMz/CMQ8vAZM3O1aBTF3/BKlWllo1VTEMFHXOS6
	 d7FG1x7tzTjUbKsfZCULHKIXjq6u1IbenAMX3qtc0WejrDOFBAnYrWaj/9Ci2eYHVf
	 EaE/79ZG0UMkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD225813CE;
	Thu, 19 Nov 2026 16:35:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C22C01E7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B39C7401F6
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7dOfPbERE6cI for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 16:35:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9E1B6400E6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=iYamDwCy
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E1B6400E6
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4womeqvOvW739AH3iOBVh1UcgRlj0wVfAXMOr5bvTlM=;
 b=iYamDwCy5ApPq+p2LghmD7kG7GMKQfjtVY27x/Rbu2Ez9q9/LArvs3PCSjMwmybvlhNavb5PnGBlS9GDobcLQ6R1W/rFXKFjNR9PQ5EF1pD8soYhcPK0hwVTJ8qFeP3k9Mpjq5eveH9IA4Cg8sXbB1YLpQUy/GRYkBky5CJjA1w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB8278.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 16:35:20 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:35:19 +0000
Message-ID: <488789bb-06a2-41b5-816e-9737a0a19a83@cherry.de>
Date: Thu, 19 Nov 2026 17:35:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] doc: spl: describe loading U-Boot from UFS
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Aristo Chen <aristo.chen@canonical.com>, Denis Mukhin <dmukhin@ford.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Carlo Caione <ccaione@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
References: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
 <20261021-ufs-spl-boot-wlu-v3-4-064e73cd2209@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261021-ufs-spl-boot-wlu-v3-4-064e73cd2209@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: ddacc671-e623-4161-5e2a-08df465b19a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|10070799003|1800799024|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006|261026121527099003|261022115727099003|261022105027099003|10067099003|261022075727099003|261026140227099003|261028144727099003|261102123227099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: XKLAIUzBaTXZgWqjks9Oj8xHkHzzG1pADiLFx1bxGRVXVg5vzF0cXTNKWsu9mxhzXcNOXVWlHQ7eGMNU2u0zJjvrG5D4T5Y/tGjjvtcGyYYhWCKCLyiuAJPAigKqGABIsQPRSaotpfnyaLqv2vBxP4UuEk8urxdABwYLwnGhs4D9OL6DEh1PRTu4BtuKlEkY44caTu+iljc0xC8LrZfO8fieX3QuCGW9ToEPfqhRJSHk2mIxkd1kgXt/OOAlE6Ljpu9eznP7u93kv3IKjBQB4k2eadTLqovde4mfFR/gOBHHo5ct7dqjFOMcirqmRz70o3bBhld1eizqYp+oaOlfXG81CXpJ8tTwcarAJAXfNHrda4I1bExIYb1rI5kgiNJ2RpfQHZE8P10PpZth1+T/hig2FOqZrjHL0tOmFgw1T4o1xanMEdsD7mG3GYekGFSn6JsKM+OKhoux9RB1bjl36MeKIuhBgG/Ga12hN0GSl56i7V8JV2rp7rNIkMb5cptz489RqaIR3QM/LOoRmRMmMaBGImKtDcotDbHhQvxtzxXuxaDlsu2EMvp5FS2HXdgEtw+1jqtXiwwnvkPaymFQKAkTYDrMq7CNAFonFwCw0GVJgN1KJwGEFU5VL+yDhRNv5kJ4oHoaGatYQp8l65CCxkbGtngwiq58DuQLX9FdK8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(10070799003)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261022115727099003)(261022105027099003)(10067099003)(261022075727099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHVNR1pkWTZETWZEMHkvN041YUJldXdZWDlYbUVRS3lIdEdoUjU4bFRMTk5K?=
 =?utf-8?B?OHVEajdQNWl3UXZUb0pvS1JHNElhMVdHWW5Kam1CSVhIQndZSktoSXlLRllx?=
 =?utf-8?B?Z21iZXJMTVpuQUkxQThMSHZCeHBrc3pZYkEvcVFJOGlLN1hXWTUrVU9PTVZJ?=
 =?utf-8?B?ZG9ieHZleUJPRkJKeWh5eHVxTnVWQkRHVHdhWHZNak5EbERjTG95SVhEU2Y1?=
 =?utf-8?B?NUZ2UkwzS3FJWmhidzE1RkhPUm56ZGNsM1JkUTZZSk5lVS9tSlBqREVscWFr?=
 =?utf-8?B?M0ZnY203SEU2NWhzazVxVGlDS0VBa05udHc4bHBDVEhKZWtvTEg3MzlnYitJ?=
 =?utf-8?B?d3VuY0UzTGV2Kzl6V2JGZFY3NC9SL0M5MnVpWE5vQzNReSs2dS9jYVlaOGk1?=
 =?utf-8?B?ZFFmMWNEVEo0UE12MlhTQUYxT1ppQ2xtaWxsMmErd1JaSXMwWVpSN1djY040?=
 =?utf-8?B?enhHMlFrdWNReGsyTDJPQ015QzNIL1h4bVVmNmF2MXJSUmI3eHdjSkxSaGJp?=
 =?utf-8?B?QVdBdFNibzQ0YkY0cFJJSjRiMEV2NWRxNm1VYWgxQmhiTUJUbmkvZmZDV1Z0?=
 =?utf-8?B?dGlscnptMU1CWElpMFlqaVQ0QWx2b25Lb3pyZFlqdTJZU2dnaHRsVSs5RmlF?=
 =?utf-8?B?a2JNYVI2YTlxdFRNQXRxbDdiMG95dWVrbDVzc05raUFZUnF4VHlETDA5aGs0?=
 =?utf-8?B?UWE5TjE0UkZuZG1HSkFZbjJnaHZBR212VjFSckdBL1RXY0JjdFpSTUdiRGFZ?=
 =?utf-8?B?T0d1OFczSlRhcWhGZ2lzT1UwSkZ6aThvcmh1WkxVVzhlL2F3NlJycWx5cGt1?=
 =?utf-8?B?M0U0bEp1YjB4NENkaDB6UGgvRnVGWkNqQkoxRmd4bkNaeThjRFp0WVQ5aE1s?=
 =?utf-8?B?ZUJDNGJGd1lCTlZFU2RUamVCbVExd1NMR09LRFhkeXQ0bjJWVFNZaFpZOUlU?=
 =?utf-8?B?QUhNK1ZQajh1WnJwbnMrQnNIM3VPNjZBSHhDcWs3NUIyUTJlMXBySFQ4TkQr?=
 =?utf-8?B?YkcxMnoyQUZzaTFPbkt1TTF5Z0dOSVJOSWNtZnZ0Z2o3eGs5WkdJMnA1WW12?=
 =?utf-8?B?Rmw3YjFSRitTZU1SeU51Wm8zK05lOVRKUkUwK3ZwcVBoc3ZXTTVyY2tXcHFr?=
 =?utf-8?B?Y2xLVk50eWE4MmdSSkdSMmFoOUp0eWhaOERxK1ZtK0E0TGNQUW45SmZmcHgz?=
 =?utf-8?B?K05KQjh3cCtGRmFZWWd5TzRWUG5hNkFjYmJiT0xjQXZCM2VOcjh5SjZkVlNQ?=
 =?utf-8?B?ZTluVXBOYWVPRGdvSzAzV0hjcFF0Q09qZXdudVRYRzdqNnlTRTEvQUZ6Yms3?=
 =?utf-8?B?RG5LTmYzMUQ5WTNzSFl0Q2Z5RG1IQmtGb3RrbnVObFNsYzJOQThTc2gvYmFw?=
 =?utf-8?B?Q284dFFoWmRtV0hyWWl0MldiZWVMSkUzV3l0K0pxd3FMbjdyTFhBVnFyTFU1?=
 =?utf-8?B?WlRVVVllYTltSk5sNDJIMURGWGtpWks1dXlBU2ZIejJlVXpLT0VMRzN2cDlZ?=
 =?utf-8?B?cU9tN3NONERGVjd4WjNpSll6ZmVCcDhqallpUWplOEdqSDBETGRiQ2gxc0tK?=
 =?utf-8?B?Y1dJVEhUaEd4QUlJVDlCR0F6U1FOeEdTaGN5TTkyUXZZSk1aaUNXY1poeW5k?=
 =?utf-8?B?c29MY0hrUldvMXB5NzNUQnZjckk5RHBlNk1RZjVBSXRFVWtOQU5kWllBTlBZ?=
 =?utf-8?B?K2ZuUGdBOVVCTDNNQUY0N1M2eTZCU0VaQkpVRDZUV3V2VWhDU3RkOGlJR0ps?=
 =?utf-8?B?UEdSeEhVVzlSK1Q5MVhVMVRVdkZxMktOSWhWM0xLS29oRVV3WWkzaXFYdHkx?=
 =?utf-8?B?U2xWcHBCVTMzR1JYTmRsWHhHcFIzMmpQSmpVVEJOT2dibjBOZXZGKzhWQVdI?=
 =?utf-8?B?UGhuM0c0cE83Sm9jTk9zaUVTd2VGVHFadTF6YzFQa3pIZTdwSmZ0RUMzWWJ5?=
 =?utf-8?B?ZDI3ODQ4b2laWm1Uc1RtVjg3cnpndVR4ODJDamR6VTBnekpFVXlySWw1aEk0?=
 =?utf-8?B?SldrTGtKSXI3eXNQZXlsOUR6NWQ3M1hQSU00MkRNeUNYOGpsUEdwR3UwQ2dL?=
 =?utf-8?B?cWN0R3RQeG9iMzhLYU9Id0Y2RGpqZWprZWpnVU1Qb2ZUUm0ybk14YW14RU9q?=
 =?utf-8?B?Yjc5WUQ4WWN5M2hHaDdjVUorMXV1NUlmb21RUmVnYi9Zb1BJRzF4N1ZGNnhN?=
 =?utf-8?B?RVcwTWkvbERSeXJRV3pMcUp2Y1liODZMQlVpK0RoL1hJaWlTRXJwTWFIN21U?=
 =?utf-8?B?RHNoeDE3WkljWFZVVTFYUkh1L1hOZnNYYnl1MXZ6dlV0OGZTZFlYMkFlZ21J?=
 =?utf-8?B?cWlUYWh5ZzU0OEdrMGtaNEUvZWprUnNOTFFWSWVHQXFUSEtRa080ZUE4MHhP?=
 =?utf-8?Q?JGpi0VtwcHqmi5EAmYlAAv/OW6BxIXZTMk3vMBLixVuTx?=
X-MS-Exchange-AntiSpam-MessageData-1: a8nNMPfChhaQmehgTx8JAA0Ftp2HphQF8K0=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ddacc671-e623-4161-5e2a-08df465b19a0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:35:19.7735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gnu9eAopewOT5r3pg0IMt+KTjfaHQdThJNjA3TsqN36kPnyV7jBX5hA4RETX9VajWprTuoDhKXxrHiJWvRa2rctvrVVgu26kpn5ABuImYvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8278
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 10/21/26 6:04 PM, Alexey Charkov wrote:
> Loading U-Boot from the active boot LU only works on a device whose boot
> LUs have been provisioned for it, and the Kconfig help is a poor place
> to explain how. Document the UFS load method, including the A/B boot
> attributes it relies on.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   doc/usage/spl_boot.rst | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/doc/usage/spl_boot.rst b/doc/usage/spl_boot.rst
> index 64b8083e0073..d5d9eeac203f 100644
> --- a/doc/usage/spl_boot.rst
> +++ b/doc/usage/spl_boot.rst
> @@ -145,6 +145,48 @@ SATA
>   
>       * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="<filepath>"
>   
> +UFS
> +    This method reads a raw image from a logical unit (LU) of a UFS device.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_UFS_SUPPORT=y
> +
> +    * CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR (where U-Boot starts on the LU, in
> +      logical blocks of the LU, usually 4096 bytes each)
> +
> +    The LU is chosen in one of two ways:
> +
> +    * CONFIG_SPL_UFS_RAW_U_BOOT_USE_DEVNUM=y with
> +      CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM (SCSI device number of the LU, in the
> +      order the SPL scans them)
> +
> +    * CONFIG_SPL_UFS_RAW_U_BOOT_USE_BOOT_LUN=y to follow the boot LU that the
> +      device is set to boot from
> +

 From here...

> +    UFS has built-in A/B boot support: up to two LUs can be designated as boot
> +    LU A and boot LU B by setting bBootLunID to 1 or 2 in their unit
> +    configuration descriptors, and the device attribute bBootLunEn selects
> +    which of them is active (0 disables booting). With
> +    CONFIG_SPL_UFS_RAW_U_BOOT_USE_BOOT_LUN=y the SPL reads bBootLunEn on the
> +    first UFS controller and loads U-Boot from the enabled LU carrying the
> +    matching bBootLunID, so switching bBootLunEn, e.g. from Linux with
> +    ufs-utils, moves U-Boot along with it.
> +
> +    For this to work, provision both boot LUs with U-Boot at the same
> +    CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR, and make them large enough to hold it
> +    there along with anything placed before it, such as an SPL that the Boot
> +    ROM loads from the same LU. Note that the configuration descriptors can be
> +    locked permanently through bConfigDescrLock, so plan the LU layout before
> +    writing them.
> +
> +    .. note::
> +
> +       On Rockchip SoCs the default provisioning that the maskrom loader
> +       writes makes both boot LUs 4 MiB large. That fits the SPL, but not
> +       U-Boot at the default CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR of 0x800
> +       (8 MiB), so reprovision the device with larger boot LUs, e.g. 16 MiB
> +       each, before enabling CONFIG_SPL_UFS_RAW_U_BOOT_USE_BOOT_LUN.
> +

... to here should be reindented as it only applies to the second way of 
how the LUN is picked no?

Cheers,
Quentin
