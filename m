Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CBFCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C505A40519;
	Mon, 12 Oct 2026 16:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4iYMdDk278Y; Mon, 12 Oct 2026 16:04:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2134740665
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791821068;
	b=a15BLIye+1o6tMp+w6L5p+n3RsWVottWGbP09YUbwR5ICXQHfV1jcbWfAQgaCzC55lfu
	 ImLcbA12ypSRvSs3mi9i5EeB2JkvtPml4mdPOkZ83+kVRH/h4Hpac2MClbUt3hsmMq7qC
	 Oz9/ltsfs3W8Bl4Bec7fgGJWYMn665Z/whmb4zHFzCpXGMoRQqO7aoLwShobSJu8Ibxqr
	 LtNcHbbTZ3pnsaCzZIfVNxqElnTiTWvUwIkOFom35OadzIQXkjallKP/xRtRA7Xpi9FMr
	 pWXE3Gfjsd4YuYi/0icIisRvzCQxAxeUQmD6LzCo+amGZlUQLoSingURZhtDy9W6G2g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791821068;
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
	bh=vvH4b3z3xyF819TmyV1n2ta7jU63DHit0mY8RYXbLE4=;
	b=gYS67b00Cea3z17O79BEAHzPvrdzWKAxuJNLG+6U+r0m7WucIZyg5MxvvNix6lu1mOiB
	 ZPsbtep7bqId+3yW54WMnLXx1FydeXb13uLbOQdHKleFx1A53dJ7nHTAgpM6EqC8rU7o+
	 2h3sCp0HvAANI2wkG/V0jlu/bH9/vaC9gbeO86wYCqKPcWOJOQiV8P7fAiarKRGaCZCI8
	 Q8En4cSul3SFqDktwBhzYNPs7z33flB1EHAoaTCKdrT2yyXPuwxMp4wj8NNaYppnKkIjN
	 FG+JHtKHupXkYUc8a1cptqn+qp50cofqxIYwuYMFrgRAd63Bjy30kXy4jiNfdvSNx1Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=TqvrAzXM;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791821068;
	bh=vvH4b3z3xyF819TmyV1n2ta7jU63DHit0mY8RYXbLE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d/z+96NOKHkmO3NjHNRT/OJq065AOJOtVBAFvjNVLO5yxIt3ynChC2AHCp17QiuAl
	 Exzqd3I4R2jBP4/DF9KHjBoCmR3wt/qt2221bZ+p1wDJP/RvB1gfasBw8q95BPROr6
	 kRpheYx9l9jJMeQgDPCDzDdXlB3Bd4Au96xHXHwV8ZWKDHhjiMCLHYq749FR+2bZPB
	 CcVHw+HzDthZt9AhVoN6Nl1qYwDPtc/ODzqh6A7KmFgLEf4mbSzcXivYar0/V4mcCo
	 gdycxORZGUILV5u3oHN1rzq4bgSQ+N7XPA6J0TTdIqSc4HgRI7fBrimLNZviQTl55o
	 2bD/IJg6aMbYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2134740665;
	Mon, 12 Oct 2026 16:04:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 51529105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3795D40665
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tx9iNjsaRlRe for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:04:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7059040519
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791821066;
 b=CUE1uD3GUMOWaEAXTCBjtSuC3nU5hViwSakU0Rq7OOR7eIGgj1VtqUAZFOTEOhor1r7b
 yWe6XxTrq9gFJeFX5oacZ0rlz1W+uABdmpg/bTtA2IjZF1tKXNIzmlEy4ukY1wU9qD7CD
 PZdc/MRQqVQ7IXutwkXFQsJU+kTCWh+KFh24NM8oKimR80SkELwmW3eSIDObZXf/mCeNt
 nHr4tGFMeBo2nmi0B80C85pHQjaHyUwV1GvRXQ4CmUayXPTKoWEnMTiD5mQDkMh08OfKh
 H4WnZuogtbZz4PencqR1xPu8LZofZ1LNwHTUpFgCoz/Ino00CBXFExlV2yuSRnmm+Uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791821066;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=vvH4b3z3xyF819TmyV1n2ta7jU63DHit0mY8RYXbLE4=;
 b=h2X3GeF1Fl5e1I5vclmTAIayj2z6tJzwtDrQSzQGTywz/CR4V0K5yclXGMBoZk5zDWcs
 c6bC8QgI0Rh5e7hOrmB//wzsb1Lq02QFXYxf0kPyUDfpTph/PEn9y77jFjSMG1iTO5eap
 1oUqTUc7r2zBFQuqXHWIPY3vnZw+w8rgP8/IcOAx9aPSDWxu27Q2CyAqmYfcqwxSURdGv
 L9hCQ3vTkIqqz6c/8yUVnXzZpOeq+6XLFWDU+1PwCeJ0HkxcPa9WtHcn7wtcLgKDP41Fl
 3ZAGz5HdbfLV6yRMLenbAbLUkWUV/vmeD52hzT9ccf/0pKKtnpVpg3o019587YjW7fg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=TqvrAzXM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=TqvrAzXM
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7059040519
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHCCESKk+FeOSi+aBKrVjcjzW760bxu4plbCddH15COEYKYGgZTQXzin7upSLbeVnK1xokOKPptVV98xmFzuBKdr8pht4HIPwWk+bl1dxuHCt4fbgMzn4uccFnfHo7o36257Jv/T8H1EG3XCRW/KSfy3hqyv7F7FPVqTfpxI1c6+f8r4wHmE8XIcjPQ1geTN5MepAP5FjNMBFPIu5VF3bfbU2t1uGmcQNnuuu3Eqbit29z2PE/nR8JPvRGto1ouFFtKTYGg0bYqrh5edQpW6FtlS5tqPAFUH/uFO5Dq9sKp+mwSEcfbgq+3vM82WgCGn+QFj/OuTXNXVPXhYShIjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvH4b3z3xyF819TmyV1n2ta7jU63DHit0mY8RYXbLE4=;
 b=wHVATLJ31AxQvcnnx65ngd9eCKqLQ0YpESWChR7X3M8f9kPnDiwr6dnL3MQmm+o6amYbSxOIwaCGe61uPEqwaNppE6w59LvETIiSqtnMcoVmrXv/HhhC+NP2nbzUEzKD0m9X40DecU3wVEJhaxSxdIvd/ZyCSfQJ1TRu1s7CZM+8SJ1eromMVn7huLQi5zDnLDuC0YCHSVR1oMvlByaF1g9ZGIhqKaLa9CkdJWnOuork03hGisrkro/ynYGkee2UvPBs5Na+JxmiIZq9LMV6Y4wQPfNuMpSxECeXCthp8XKRYTHETmbxY285eIvelXxbP/JRIrZuRVGjme9piiPXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvH4b3z3xyF819TmyV1n2ta7jU63DHit0mY8RYXbLE4=;
 b=TqvrAzXMgj5ayAJobjfWnM8GqJZwFs8XkAtdrVXMbVdmcHadfrjeKaML2ohHaELJop0S1w9S43K3ANrHXV/G9fITsLtg82yManEnoTx4Iya5iWDdcKVmiRU1kQaax8nhgxlmQ2onG8n24mlwsfB2kN0i6B6DHDj8iLeMtk00Ao8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA4PR04MB7581.eurprd04.prod.outlook.com (2603:10a6:102:f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 16:04:20 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 16:04:19 +0000
Message-ID: <bb0fd02b-5031-46a9-80ca-5d3ca823da3e@cherry.de>
Date: Mon, 12 Oct 2026 18:04:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] clk: rockchip: rk3576: Always initialize clocks in
 SPL
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
References: <20261012111552.1173161-1-jonas@kwiboo.se>
 <20261012111552.1173161-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261012111552.1173161-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0093.eurprd09.prod.outlook.com
 (2603:10a6:803:78::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA4PR04MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a2f77d-9f2c-4981-ef89-08df287a7964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|376014|366016|10067099003|11063799006|4143699003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: vgpwmizPmEpjsGcW5kPg8kTR7ntk50qtnWRkf/p3MmiDKDlNEucf7wK3ZkDdXhwU8D3O4ifBkBxFozATWvATlz6c+NuWghtpGlo77tViuDR83f7oOMF/qR1WZSQi+wa4KAgJ5Bb5JL+kGp1ZNIgkJcuN/PpOd9iMV9MaAKizxsbK2vyvhDRdW9yNbUb5ANywQYKJPfGwP78BpIk2c3FNzdyuXd+XRraVPdbJBt1YGG5iNNF4pE2CYreWqkPZoWLUoHzechRx3502opS2u67jz89SRhbGAsAsQoSUu8CmT4Dg9zzOUcL+CpGbgn+TNZCwGOdHFE9GFBrXtSdcGotdsvmq6K+1SQdbNBhoc7KIH0IcRg0vP5GSX65tGT2n+CexWjmgdrop6YLpLHk/6pTPtcQXe35STet1RTo3dWnESwtcXWkLLOYfoi2fkXU0ca+I5+z6PrMdt9ryaqTzvZuqyV6PeUGl1cXErI+wx/DvPH1u85+t/U28UajOie0R4kMlpRuoBYGXKNJBQP2gJN9882vYoSQLYz5Xi9ZdHbwpbuHd6OFJbUFMGxejFf5wwoHCFoxs6BJl15m7PKEN4zh5QFwBi9t+Z+wsT8hkac2YRMq0Nnp5mnNbvf/XrS3xW/rmxQWwVbda2Ts8+CTtgqlZNXvcZZptdxqkTFAw3+pA0Vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alNzMUphVFhxWHJpWG0rVXNaM3RwWVFMMGp5ZDcrVlkxcHJsWUxmS1hUVlQ3?=
 =?utf-8?B?MHFsMHd4NG5paXFSM0V4RmhuZDIyM0dSSmI3bEJ0NW1VbGJaS05uMmFJcXlV?=
 =?utf-8?B?Skx1VGcxeFVaOVNjb2d4dzJGZXh4Rm9vQjZuVWZXcDZkZ0U4UVRUOWdGamhn?=
 =?utf-8?B?TDlNaXhJOU5UbXFMTlFlSnpVd0kzKzRVbEwrWDFNMTUzVWhxMXVoZzJIL0w0?=
 =?utf-8?B?RldqaEFaK0VRdmthQSs5MTIwYkU0dGZzSlVUTzdMd2xwYzlhQ0JianJ4YUZa?=
 =?utf-8?B?SGJ3eVNsMWdFNWJoKyt2NWVId1NXcEw0cklCSnhRWkhJNFBidWdWeUIwT1o4?=
 =?utf-8?B?eWlNUXIxRmVhMFVWQTJYaVVkb0t0SURvb05lNzZPdXdkM3FsaDY3U2NnWkJ0?=
 =?utf-8?B?aGhvMklTRzMzZ1JNNHVBWHZ6NFFFQ2VBa3pzVzFrazQycmNwK1JlZm5yZGpN?=
 =?utf-8?B?OExGRDFxOUhtVzdzeDk5R3NKRFZzOVlHY0hxTEtJVklqN0ZLeHlBaWNFck0r?=
 =?utf-8?B?Y3FOcnA0eWRHcExXOC9BcjVVZFplRmhOT05DTU1Fd210WGFLaFRVRjB3N0hL?=
 =?utf-8?B?WUFabWE1c21NeGFoTWh0SFZTSVdKSnR6b1pDcVU5MklNeFpQSVBvNG5GbzZ3?=
 =?utf-8?B?eUdtUmVWeFNZZU1SbldUbHYzTnNTYjYzUkV2OGdwQVdkSXNualIvY1BvdDBT?=
 =?utf-8?B?SkQ4ajY2RWpJeXZKdVhWSjVYRHduME1kY2VORFkvTEZNL01taTh4RWhPMTdQ?=
 =?utf-8?B?Q29tSU00MG5wT0VMNWQ1cGMzL3JXemhPREpMV2YzQVhqemtNTFNraDF6OWdC?=
 =?utf-8?B?UDJya2VkRlpBaTVCVURLbis1eFpLMndtQStaMmVuNEc2N2VHNUlpS1VpRjUv?=
 =?utf-8?B?MUcyRGxaKzJHSnVtOXZMdFhyZ1hmM0ljUG1GRXBTZGM4YUJtYURzZTQyU0NS?=
 =?utf-8?B?cmtOSXUzQXhQTEhHeG9zRndpQ2VaTkVzVC9GTXorS295Wmx2Tk82azQ1SXBq?=
 =?utf-8?B?Q3JtdHJ6U203Um9kNnZlRnlMK2k3SWcxdmEycG5Zdi81S3gveWJ4ZHYrY3Zv?=
 =?utf-8?B?S0doektVT2ovQ3pVQXRYbHE2QS9DMVUwL05nMUFFMUt1VHdZN29XZi9uVG5P?=
 =?utf-8?B?MEJ6OWFhU1NvWlUvT2FRQXBBeERneXZHb3A1QlVDMWY3TCtsT3U5ZFpkVWUz?=
 =?utf-8?B?bGxRdGN1R1RrSElBeG42VjB6cFR3MHRETEJWcjV5TEErZjMvTDhVczhUa0Vs?=
 =?utf-8?B?Q3YxZUZYbEZCK0xDdk9WRUhtMncydnRBdjljQnZxWkliWHp5NHl4a3psYmdr?=
 =?utf-8?B?WDZWejI1K3RHQ2VuSGZnR0c2ZHlERjc5c1ZyUDkvV0tlRzk4aEFzK1E3TlZV?=
 =?utf-8?B?ek9XWW5WRHRFOFFsN201RXdhL0pyOEtjSm93dWJhUVpNcHpNUFBQZXlQUU1V?=
 =?utf-8?B?bXdmYWxOaGlhNFdHMUFjZ251VTFMNkthWjNacWgzNVloaWZoTDEvN2JydWhj?=
 =?utf-8?B?RVlqNTV2NzRRUHRxdkcrY0Q4OXJVTHA5Tm5EUUthWTZJYVlUY3lEVUM0ZHBQ?=
 =?utf-8?B?QThDMWY0UEZvNXpmakxjWnUwRlk4eE5sM09HNmFGQkR3aVlBUE1zSjlyZks5?=
 =?utf-8?B?Skw3UERTU1h0dUtVcGJ2Njg1WDA0Y1BFT2l1STdhV3JRL3Y0L09WNlN5aG1p?=
 =?utf-8?B?YVdZUkVGaFJhNzNwaFBzYnpxUWhwbThGNm05RGx4cWNsMjV0RW5hSEFUbSto?=
 =?utf-8?B?RHpXTHpINGQ5MTQ1VFFvTGFGSkVCbTFEOXFNTmZBajgvMW5JTWNEaVg1VlJ0?=
 =?utf-8?B?SDYxaXBYdnQya0pHT3N3MmZSWGFXWTVuQW9od2dROFBva3NGRG5YMkN1MFBY?=
 =?utf-8?B?MVFicXpSTFI3azNjekd3aFpIdFV1Rkx1VVpNcGdlaVM0ZFBZZm8zM1VVbm85?=
 =?utf-8?B?RFIvM2ZXcG1jbHd5RDh5cURYQ2Z1SDFFekpsZVhDeVB6N0hCcDEwV1N0Q25t?=
 =?utf-8?B?MG1DSUp4T2lDV3huN2hONFQ0a0lybXNQc2ZYaE1zb2dlOFJCZ1ZjTFlCVExl?=
 =?utf-8?B?M2tqTWJKTmlDSmc1RTdqWE5uNFczOGRRMGJ2Tldub1R1YTZzNFlpSU5MVW5p?=
 =?utf-8?B?bnN4YUpiUXFpZlZRRVc3V2lJRUt0UFFMR1dBQWNtRlVpSmFvNHlSQ2tVYThZ?=
 =?utf-8?B?Ulc0WkNUM29HWUQwVHFCelg4OFNjaFRsbStZKzRTZlpyeUkzWWRqWHY4cmdZ?=
 =?utf-8?B?VUk0aUtGWmwxS0c5RXZZYkx6NldzRlF5RWp2R1V5bU9BRUluczNaZGVMNUFr?=
 =?utf-8?B?NGpxSmZ6eUU3T09JSWNjTHdNNER6anBFMy9Gb254cjVoMU1mRVpJNGRHM3Uw?=
 =?utf-8?Q?9gKRUAAL+HlwZ11lNB7j7DgNFNQzkMxf5pEF/JROJIAqO?=
X-MS-Exchange-AntiSpam-MessageData-1: nkx5oHCSuVhX5A==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a2f77d-9f2c-4981-ef89-08df287a7964
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 16:04:19.9505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hH5PjLN/SNDuwBzj34m7arwWUvro9RFhzIp0HeIW5G5sIFiSPdowd+mKYMILIpaPRr7AUY/mxUWaF+oB1vFnCJi4g1Uhx3QGiqYr12tzt24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7581
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

Hi Jonas,

On 10/12/26 1:15 PM, Jonas Karlman wrote:
> The RK3576 clock driver configures the CPU PLLs and CPU clocks when
> probed in SPL. However, the driver is only probed on demand, so this
> configuration is skipped when no SPL consumer requests a clock, e.g.
> when booting from RAM/USB.
> 
> Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
> of boot device") all boot devices where typically probed, with a side
> effect that clock driver likely also where probed, prior to the
> boot_from_devices() call.
> 
> Flag the clock driver to be probed after bind in SPL to help ensure a
> deterministic probe and clock configuration behavior prior to booting
> from devices.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Alexey Charkov <alchark@flipper.net>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
