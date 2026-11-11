Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048F606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YLOCwwCZ;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=gY3X0zGA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A71260885;
	Wed, 11 Nov 2026 11:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9xvboa2vwFqo; Wed, 11 Nov 2026 11:38:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6D39B60642
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794397102;
	b=iqPWvjfQT834HhY/GhJ8bD+YfO6DsN5G9ufpdeHjTMZarQI25k0RKRAWD9CNQeODjmPk
	 P+Y6oc1TjF8wNPahWrx8KTG2I8t2hSjdbV3WAexrrZ4nNUB3RBlS3ZWX6AVy4Sk30WzBo
	 N9AAN0iHCLHDMyrQYU6Nw8gM0n/hlCqI9rOj0MO0ZL0YkZQ2ub1cS1SIVfuhqiOMoGd/x
	 1OkU9bWOqrXFCd6jiuawCOOefNNW+Vr/stqzA8HoC+bP07LbEBQRhCl2xZerl6V31p7SY
	 mHqtq2trKTh+ZU+/kQtNdTJJFLZChPq9wZnCDUX9IdOs9b0t0fIRBD7pJUvh/pHleSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794397102;
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
	bh=wRZ+h/6eEmaoyghsKuFn8o5g0M9aW/XZN9p6Ud4lRJ8=;
	b=qjaG/zV2lyxiyrp9tT8QRhSdzWDZAjHMffCaadCLBDi7eUopCylm/fqEdRihzbl8Lwgf
	 qsAHV8OjmKtHMQqaz0Td0ebx5blOcYh0cUDvVl3/LB982ow5DvEf9kAy3PSyqAy7qRpDT
	 4UoAenaYnAIJ4tYirK/9S+jmOUkgC3cc2/AzF8vE2xExVivxBju6BJmFR+5mFwyphx2Vy
	 lfT1i++UoJhP9SxzR1W6hfi9TAE3w2KwUwGtK3f3TkCA8UemutfM2Hw4OYOfkiE0jB7o3
	 ztGihV8oUdNPvfa4XYgMdNjUtJYndHCeSRARPB2lhJVuj50Ib2xXnprHmCbtoc8sumA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794397102;
	bh=wRZ+h/6eEmaoyghsKuFn8o5g0M9aW/XZN9p6Ud4lRJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YLOCwwCZw49E1+l0R+VFK7j9vA9ZJlt3ym5SoPJ916YPsIo5ysEn0OFQW3l763DOY
	 VJNh+LQH9M4TQLuX1RqVBRRgygQ9F+0ukEgtW4lr+64epD1P5LKFh5LJ6X+2Rv4dLw
	 0pzAfJNyf3dsnUhfEv/lklNzpHElMbvzSEiLMAGXH7cVqTMlbI2T1zZoVMy8Mpt1J0
	 SyoCtxG7a2zLLceI+8vnPALavemQS5f2t/FlH2CuNSmRe9R0BJcOb1SkmFZjVU+zi6
	 aE5BskVvg0hpLKhc7DrFri00Gc3mRizyknhsyd12KWjnkiXn3zwpBEoZVy/CdTeJ6k
	 2x/4D4fLxtGNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D39B60642;
	Wed, 11 Nov 2026 11:38:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 830D628C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68A9040217
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:38:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7gL-f7XrOG7I for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 11:38:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DA2AB400D5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=gY3X0zGA
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA2AB400D5
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRZ+h/6eEmaoyghsKuFn8o5g0M9aW/XZN9p6Ud4lRJ8=;
 b=gY3X0zGAWU543Y4C2pvofVYjNMiMR0WsWX5qqf6POxh4MFVGI9E91L6A9N5eiThTaHHX2v4/S0jxigRWIgyj+M5G71x1CYIzoKlj0dgkARrm6IzOYwsVcHpRvAQ6T7eAwS/t1YBMM3tw4FEEbukGhFq8r6bIChfclB1gclnKQvQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAXPR04MB9230.eurprd04.prod.outlook.com (2603:10a6:102:2bc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 11:38:10 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:38:10 +0000
Message-ID: <c8208805-a659-46b4-8107-2783f6d54fd4@cherry.de>
Date: Wed, 11 Nov 2026 12:38:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] binman: fit: Add fit,compress for generated fdt
 images
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@nabladev.com>, Wojciech Dubowik
 <Wojciech.Dubowik@mt.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>,
 Alexey Charkov <alchark@flipper.net>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
 <20261017-b4-binman-fit-fdt-compression-v2-2-d7e290847543@protonmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-2-d7e290847543@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0068.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::12) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAXPR04MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3c8329-7611-42a7-41b7-08df3fe84317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|18002099003|6133799003|10067099003|4143699003|11063799006|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|56012099006|261026121527099003|261022115727099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: gqWgeDNFhIJKidRtN/Gmwky94aHTbWsZDsvkyxqU/58TXoXmwyH2bdr3NTutmCS233o5bcUneeDtf6iBiy9R87QtUYZ5H7Tt8JA0U7MylXY97pnRJCNz40v4Y8gmoiQHpqvVa10u2gPLmOy9Q9znwSVAqQiu/5yQx+z8OPHlLtNST9Nnqoh0TyOeoLg5AxDfR7pMb6R+5Rw+kq37uH6d1NtXNiAhMY9ql72DX6iw+Ua7cQA5u1VlN3jTohmmVKDVe6kSeMA/IUhrOGdi5H6EM5vUZLUK45DS+aiT1FiDF+dQtUDr/Kepr5yGJwWqEn2FZ6Bt1KBZBI92D+Z1EHcm/lT6Wtl/DTGV0olKOg3xoH0tlUZ3+U9w7514MDYqoLjjUQYA6L9yet+4oGiNcG4nGBlj6GHOyAVe6L8jnoiUesKt8aJ+l7dtKelefqUhF0L6N1Ej00XYfqhRDMtXAMgb9K6DxRi1nG2sDpcz2/JAt2NHypMYbpldW/94NsEo4jTMWeE9vBi8ixz1qecjLWWPgu20PyWyIgEWGmkGrV9GfP3IvnMj3diPd/6HrcsVgpxRUJb9ce6V7XlobH6xb6hs0d1eZW83tkh+WuamJu0MY8QET+r/nyeDJoSehqoHLjsbAg5YcsU7KykNuEVrySfnoDUJUsJFiehHh2nJD+NLQOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(11063799006)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(56012099006)(261026121527099003)(261022115727099003)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnZOV05NN0FzU2FvNm80a3E1Z1F1Q3VDUmFVQ21tOVlmNUNhZFFpRUdiT25N?=
 =?utf-8?B?UUxSenpaR1BWRjY3cS9SRURsb1JhRUlxOXJvNStZWkd2Q09ja1hLYjgvb1Bo?=
 =?utf-8?B?NGhNYytWQTVMdFI5Q0xoQzdYQTlxaVpVREIwUlMzaWNKdG9lOXhnUHBTazVJ?=
 =?utf-8?B?UCtmV0Z5YmdRQnJVVjhqR2RCSklCelljRTl1ZWgrY29wQlpNZzVmVjBOUDNZ?=
 =?utf-8?B?bDNXVEVFRXFMZ29vbXRWOHE0NnBORkNjMnY0RDNMRUFDTzZlQ211bGtwNXZ5?=
 =?utf-8?B?YnZkb2tpcFJQUzdVN2VlTmRFWnVxdWo4U21IdGVvZlYyMmgzUWRVQnRxNFFi?=
 =?utf-8?B?RVVQQm91QWZsMUY5OVNDdmVMem9aMFJiWlduSm9iVDN2K2FnVFpkT2ZWZTZv?=
 =?utf-8?B?NitRTkdnWVcyN05wWk1ndmwxK0JyRWZlci9oSm5pSC9RcUtEbDcvNjZSMENL?=
 =?utf-8?B?VGYvQ1RRbkZaWnFrRTk1cGdxQXVOVGlFQjV5WjRxLzY1S2FlN25EVUI4cXhB?=
 =?utf-8?B?SzVjWkxaZTR4UGM4WXh6c0hMUWZPNytlcHB3RWRscmI2QURPR2JRbENQdUpH?=
 =?utf-8?B?YUZKaGZBdDR3V250dEU4dVRWSGFrQitRWHFpV1NlWWxWNnhoSkkvWm1lRjRl?=
 =?utf-8?B?UGxJejZCTHNhbm1HZzFIK0RiZjc1R2tqQkx0TEpIWlBzM2lIa09kbWZtSXhw?=
 =?utf-8?B?cUIzL2RYRHgyblhGZ2d1RmRrcUZuU1Bsell5YVZPNVpyWTNmYmJEd0VmLyt0?=
 =?utf-8?B?VmJKaTQvZDFZZnJqRFEyMzRRSWo2emFEQzlZd1Y4a0k4enN4MU9kOHFiNkti?=
 =?utf-8?B?dGtqVjZDbUNtRFBsVURVRnMyZFAwTVowZ2w1T2doNUFnODlPb282SXJGT1dI?=
 =?utf-8?B?elFtS2lSK2dpRGZGZ1ZySkVGblJSRzliYXBUSmJIcWxuUVAvcVlDTzRzUUlo?=
 =?utf-8?B?THdQSmlURHpzL1owWVA4L0I5MVVlSURnN1ZUNk1mMW5XdEk3T21BOHd5SzI4?=
 =?utf-8?B?R1J5OC9yN0xrcXA2SUllVDBORGZyVnNkS21lUzRsMDR2bWFESjJJUmlTSG9I?=
 =?utf-8?B?aFAyN1Q0V2dqVkp3ektXb2dxbW5LaE4raytRK1R2TEJBYXE2RWpWcTBzNklv?=
 =?utf-8?B?K3h6TExkelNUZ25TT01xL0VRaWVET05yaThOcHNZUTdXMDhGSWJ5aE0rdEtC?=
 =?utf-8?B?TjlKVjBRSmtTT204QWdHWlQyTEVPUUdIMFNXM0RySnYraFc4RXZnd1VDVGNO?=
 =?utf-8?B?WXdKZ2k5NlpIQmNnb2RIZWVMMjJZam5SNTlhVG4xbFFXTmJzU3NoTUl6NkJN?=
 =?utf-8?B?SUxkTm9NZlUxdkErd216N1N3RnUzZmJ5RGJ0aDRUd3B6eFBYVFlySnVnenFC?=
 =?utf-8?B?aUtTRHF4SFlxRGE1MXV3SWlkM3haS0VlcmJBTlA4VS9MWEpldHExSXJ6d2Jj?=
 =?utf-8?B?SXJ6Q01UVkZNbHNmdm1uSkdyaEFMWDhyY2krS3Q5YXRMb1lhejMxUy9PNmxB?=
 =?utf-8?B?eEpGWVAwTHBURDhEUzJkK3U1NnBWN0ZhK3ROL1ozeWF4cnpVSm9nNU50VUEw?=
 =?utf-8?B?WW5kUTlnYzJyMW1NemdiNEpkM0lCZ0F3b1NKZ1NQZ0NPVnpDSjgxWUwwUHJ1?=
 =?utf-8?B?ZGRJSEFvNWsvd3BQbVRxZWpNaHdDUisxQ0ZpVHcwc2IzbnZQUTVZV0lqenVt?=
 =?utf-8?B?Q2lFUERST0hMNzJ0dWxoc0NLUkMxZkhZQXJBWHlTam8rVUt0L2ZUVXF6WEZS?=
 =?utf-8?B?R0lwRG1sREIydUQxSTZucTZUczBIejZzWHEvcnk5dXI0WmxZby9xeE9TQUdn?=
 =?utf-8?B?ZGhlMUVJNnBlOUgvNnY1ZDloTDNBRytZdTVrTkNtcC9qcmhxdGJKVGpvdWZn?=
 =?utf-8?B?bkg5ck96YXR1VmVyQ0lOdnB4T2ZhbW9kN3k5ZUFBaXAyT2psNjlwZFdPSnpL?=
 =?utf-8?B?aDM2OXBkSkRhMm9UOVhwVE8vU3lNbXNNTlpXdm1kOERqaTJWMXBraERWV1hR?=
 =?utf-8?B?U2hSNUlXS0tsVnlUN3BDcXFQaVUwckRCUkU3NHFBaXN5Yzd3UzV5QW9jN01M?=
 =?utf-8?B?YXZzRHQvYlMyak9CT2V0dTJOMVhScWFQU2pVcGNYMHZTYmxiUEt3MDE4KzQ5?=
 =?utf-8?B?NStISGdRZUczMXI3NFFHRk1pQ0NFYmhpSW5JQ0cyMnJFRGpaenEzc2NXaTR6?=
 =?utf-8?B?OHNjSkdGS1lJZHZCSG51Qnk0RzZXcjY0OWRRR2oxLzBSQ2RSc29lZ0RlOUl5?=
 =?utf-8?B?UmF4M1l5MDlqSW1jbHM3MkJVdUxxc0hQWFlSa1NDODVTN1N4dHVqQ3Zsa1Yw?=
 =?utf-8?B?RzlyRktiK01xS0hpMTlxa2Q0L3JKdXB5WVdHOXVsbWpTWFUwN3Z1dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3c8329-7611-42a7-41b7-08df3fe84317
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 11:38:10.1832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0VAZctYgIteAq+myqV+Hjq5eH2dGAsJ2AMvgpJ1tRPi4swA1UyXOMxeOO/QqLxkk1AG5rbbI+dL44VE4Gx1Lp0CzS6s53DPSj2wJFmMwxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9230
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

Hi Petr,

On 10/17/26 9:39 AM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> The 'compression' property of a FIT image is only metadata.
> 
> Add a 'fit,compress' property for generator nodes. It names the
> algorithm so binman compresses each .dtb with it and writes
> the algorithm to 'compression' in the generated node.
> 
> Any algorithm known to Entry.AddBintools() is accepted.
> 
> Register the needed bintools in Entry_fit.AddBintools() and
> report a missing one in the usual way instead of failing.
> 
> Document the property.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   tools/binman/etype/fit.py | 67 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index 4657ed1fd76..a81e3a1de0e 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -274,6 +274,29 @@ class Entry_fit(Entry_section):
>       string from the root node of the devicetree, so that things work correctly
>       with FIT's configuration-matching algortihm.
>   
> +    Compressing the FDT images
> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +    The 'compression' property of an image node is copied into the FIT as
> +    metadata only. It tells the loader how the data is stored, but binman does
> +    not touch the data.
> +    For generated FDT nodes, the 'fit,compress' property can be used to ask
> +    binman to compress the .dtb as well. The algorithm is written to
> +    the 'compression' property of each generated node, so it should
> +    not also be given there::

I'm wondering if we shouldn't have a different logic. Keep compression 
as the property, and the user must set it when they want to use 
compression. Then, set fit,compress in the node if you want U-Boot to 
actually act on it, otherwise it's left in the default format. This 
allows us to simply trust what the user puts in the compression 
property, which is ruled by the FIT spec, so if they put something wrong 
there, their fault.

In either case, I'm wondering if there could be a need for having a 
compression = "none" but still have U-Boot compress it. According to the 
spec:

"""
If the data is compressed but it should not be uncompressed by the 
loader (e.g. compressed ramdisk <pair: ramdisk; compressed), this should 
also be set to “none”.
"""

Then we need to decorrelate both and they mean different things.

Cheers,
Quentin
