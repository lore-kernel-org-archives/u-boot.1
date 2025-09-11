Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031C0CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 15:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E3483390;
	Thu, 11 Sep 2025 17:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="oRnAhSYo";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="oRnAhSYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 353AB83390; Thu, 11 Sep 2025 17:59:17 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79AC8334F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 17:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ww8L88twE5yv9TraovqLk34hYBgB1gj3JPQoO1XvqSVOXdKbuTgqOw8BvQYKW2ijiabU4YTAdEnpuR/qDpm8csEsWaM0O9Saepx7lj9m657S3unkAy2L84YUk0J9S950CRW1ROZdgWdODTyrtaMizMUEWIt4h184VU5nlgjq77sAdg9snXwg91swUNTeggzKA+FilAqSu9csaQQO8BXYO8A9t+wyEd+vUYf6itRlTHrQ0kVqhSDl2cMCfhVJDa9xxJc/WQhnRHqxhPS/BtKjXmHen9xba+bCgDiIEXmerg4QX9nUhuXa4kFzrm/Tlp/wijjR8r94el6qFKo3LMEHxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXGFAEg95pFqCxW+pHLPO5A3a4fVJfYMZk1mTUaU8ec=;
 b=j4K9URaymzwCnQa0yBIwBoRhqAAzQH0775R/dK310bXQmlPmoA+DIjmKhIquShkr2q66XfwmGZ041LM7os1RzcdEU3/a2ECo4elY44gKKhFMqUrXKnbqOOeKw3grOy7fhJHI/WkkEIOydgqPAB2uCMmay0xsWhajWokesswNc0KdwjuK2Cdtvbg1xkuDKkxaQgYW0ZWxnOyIwPA0wPw42lu3+b8Zsea0k4Jn5Fahl+qnHZcO5A4JNtkUYgQpPmhTX/D43B1EqlKUxOIx1D3py4lV40hz8QOvqYJy56H2+SjuzvavERxOVpQx6Rp2S6S6J/fXtVoyZEL24TkOvp8f/A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.82) smtp.rcpttodomain=9elements.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXGFAEg95pFqCxW+pHLPO5A3a4fVJfYMZk1mTUaU8ec=;
 b=oRnAhSYocQI4fSEX/wGG1Qn4/51Sj3C5EIKqZ4jjrnxoD1Lnq7uePOV2cXi+BF7AOeaLjXS0kuXhRXIQT+O2+fbXAQywc1+YAjfPXBFhMUw+eWac6KcSvCdWNzjQQeByI7YWkQqXrN7gc7FQADGAmkrtPdhSS7btlLrcoWrXzcF94Yr3ecDeGNAiNCEcDlZbhm9uqehYO0hUdzIU8aXWXHp/AewLSPtrpR8fVFyZdyQ+lS5xWjJeMxvoNTQqpzibUb7O2W/3AA8OOnaU97GyFVBvfssRGB12SUSc+EOPh55gYdacEU1woqq0lnMH2P9AxaFo0/JG2vYYGKX0fTCBKg==
Received: from AM0PR03CA0016.eurprd03.prod.outlook.com (2603:10a6:208:14::29)
 by AS8PR03MB8499.eurprd03.prod.outlook.com (2603:10a6:20b:53b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:59:07 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:208:14:cafe::b2) by AM0PR03CA0016.outlook.office365.com
 (2603:10a6:208:14::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 15:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.82) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 15:59:06 +0000
Received: from outmta (unknown [192.168.82.144])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 2A394200831F1; Thu, 11 Sep 2025 15:59:06 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (unknown
 [52.101.65.76])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 74E7F200C4FE4; 
 Thu, 11 Sep 2025 15:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsGW1siI1nnjNtXAalMXJVf+QTqARoorXp8gYCfAXaTR2/XJthRuUQm9F2TJxZt8Qd9b0MJ4gIWrpN3K3i7/6G84URGImK2m4h34Xi+ztOSvIqbsYYadUkfAvbYf/LJX9x3qJI/DCpbZ3kVkVOn+GasdF5/kkfX/LcSi3VzhkFmey2kvG4fCwXM5wKRwdaB4xjSuZvU061+pYVbuhcHfAHCwarRdtTM/YR2kwgoHcBouqqLP3H+hjKcz2qg5m6xlPRbeTsvW75Qf85mghJDUgJO0wcVSlxh34VvN9KfXszVB4oY5STpyVfrKYWWk2IrdtjvKUnk2GWkbUbmd1N7New==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXGFAEg95pFqCxW+pHLPO5A3a4fVJfYMZk1mTUaU8ec=;
 b=riT+lSzPCiFSOAwtuvMQbS423RJPNrx7O1TxinmFWmzvwS0r09xV4Zs7lCw46hSvPMXVGNnludzVN6850U9hW5m/ptfIVgQncgRwDXgy4yLD0AeKtdwczq4Yq18IaNLHRkxOD3tU2D30XMDU7N6vinud82ITvV1TkmAncPN9paDBKVEbZn3K3ukE112HXSzZBBij4KaAYgaPVdxCs7YvZUoDaNJROvwLzxx+92ZAjRGMuRZrc+NoPq48RUj5RxINqN/RHuoxs0z7jg9yMPSvbTBJwAD4IkXLPjYQZH4jMY0X+nZu7OJe4P1Hpf3H5WnGonnZAbwwYrz+ZhEd1api7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXGFAEg95pFqCxW+pHLPO5A3a4fVJfYMZk1mTUaU8ec=;
 b=oRnAhSYocQI4fSEX/wGG1Qn4/51Sj3C5EIKqZ4jjrnxoD1Lnq7uePOV2cXi+BF7AOeaLjXS0kuXhRXIQT+O2+fbXAQywc1+YAjfPXBFhMUw+eWac6KcSvCdWNzjQQeByI7YWkQqXrN7gc7FQADGAmkrtPdhSS7btlLrcoWrXzcF94Yr3ecDeGNAiNCEcDlZbhm9uqehYO0hUdzIU8aXWXHp/AewLSPtrpR8fVFyZdyQ+lS5xWjJeMxvoNTQqpzibUb7O2W/3AA8OOnaU97GyFVBvfssRGB12SUSc+EOPh55gYdacEU1woqq0lnMH2P9AxaFo0/JG2vYYGKX0fTCBKg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DB8PR03MB6267.eurprd03.prod.outlook.com (2603:10a6:10:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:58:59 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:58:59 +0000
Message-ID: <633bc9b7-adc1-4e9a-af4e-d6f846988d35@seco.com>
Date: Thu, 11 Sep 2025 11:58:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] bootmeth: implement semihosting (smh) boot method
To: Andre Przywara <andre.przywara@arm.com>,
 Said Nasibov <said.nasibov@arm.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 peter.hoyes@arm.com, david.hu2@arm.com, michael.zhao2@arm.com,
 marek.vasut+renesas@mailbox.org, mkorpershoek@kernel.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, m.schwan@phytec.de,
 quentin.schulz@cherry.de, rayagonda.kokatanur@broadcom.com,
 tien.fong.chee@altera.com, casey.connolly@linaro.org,
 patrick.rudolph@9elements.com, alif.zakuan.yuslaimi@intel.com,
 boyan.karatotev@arm.com, Oliver.Gaskell@analog.com, duje@dujemihanovic.xyz,
 1425075683@qq.com
References: <20250828130657.249153-1-said.nasibov@arm.com>
 <20250828130657.249153-2-said.nasibov@arm.com>
 <20250910174809.64ad1ae2@donnerap>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20250910174809.64ad1ae2@donnerap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::18) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|DB8PR03MB6267:EE_|AMS0EPF000001A6:EE_|AS8PR03MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdb3c34-891b-4145-e101-08ddf14c22fd
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?b09OVmhEYUtXM1FyaXB3QlpNeWZ4Y3lnSDhsZU9ONHUvTi85TFJSa0tYSmNw?=
 =?utf-8?B?akNvaWR5cVNyYU5rSkVyZVBDcEZqcmN2MTArSWIraG11UGJ6S1g3c3ZucktV?=
 =?utf-8?B?V1I0RTNiajhSRnpBOUIzbVhuL2FCYUROUjlwbFR6aXl1MEMzSytROGtIb21i?=
 =?utf-8?B?TGV3ek9nVFdPd0xvK3k1b3ZhTm1FR2MzbzhFNE10MUxsc0s0aFJKUFVvR042?=
 =?utf-8?B?bDROSjZNOGdjRHgrTTVOclVlbFhtZ0tPdUJaNEZ3d2xJdzJ6WE5xai9GZnlD?=
 =?utf-8?B?aCttalJZeU5oVjk1TTJiUUMvUHVrUjc0Y1pCT1dmNzNudWwxRVlFSFBrVkI5?=
 =?utf-8?B?eE1tWFNZR0oxTCtJWmVpL2ZhT2lNQzY1NFFhOWpDb2pXZEUzWE5YUWJ5ak5Y?=
 =?utf-8?B?cWV6ZWVoODhSUEdIRFVoc0hVb1Foek4rZlRBWWxOeElTeVBEL3JqSExWV29a?=
 =?utf-8?B?UmdidVRYSTRWUm9BVk9qRnRFNFZpaVZuM2d3OTdoUlJsQzNvWXpVY1dtcWlI?=
 =?utf-8?B?enppWTVuR25pbWttcStCWjRuOHZ5cU1zcVhKYnlYMHlyN2xZODZKYWxUTkc2?=
 =?utf-8?B?c2NUaGNYWEtldFgxSzZNREkxa2ZPUnNuYzJvTERvNkJFQUFidFFhOGFHUEhS?=
 =?utf-8?B?cVMvOGtaNjRsZE42R1V2RFRGdzV2L3B6UzJIMklEMmJnVEs4SmtSL05iT1lz?=
 =?utf-8?B?MTVuUU03dWw1NUhYQlprZW5VZEdua2dIMUx5V3Zaa2hLK0xJQUVRa2xSd3Fq?=
 =?utf-8?B?cGZER2IxZFVTS0dnZEozcDFseWR6Q2NNVHRyN2VlSjdhZy9rU1VsOVVwOW91?=
 =?utf-8?B?SmV2RmRtcEQwQm8wa2kwdVZqVVNqM0RvMXFBbXk1dlc1S0xGb0h0TGwwNUxy?=
 =?utf-8?B?UG1nWnAwditsT0R2K1d6V3VXM0FDMXRrY2hSOHM4anowejh3dW93WkZKclBi?=
 =?utf-8?B?MnhtZHBEREk1UTVLNjdLM1Y1YTEralk2bVVqSEFtRDZaaGxjcEVBa1dhTUxM?=
 =?utf-8?B?eWJuUC9DU2VWRXBmaEJEdUZIQ21EeEhNNGxDU1ZNM0lsWEg1enk3enp2dklF?=
 =?utf-8?B?R0dJTWJzVW9vdVpnMENpbnlJaEM2TTU1eTJDcmVwbExXcW5BWXhhMkdnQ1NG?=
 =?utf-8?B?SWptTUdSWmZnT0N3bTkreGtTV2txWmkyRHg4SFNHZzJDa1lmc21BNVFpRGsx?=
 =?utf-8?B?Y2tBYm1nQmxwUG51M3lzTThrSHFwTDhaSmpvVXRnQWRUL1lFaUJwWjdYVnlk?=
 =?utf-8?B?RSs2VERCY01mNHVuNUgrbzQrZDAzU211eWhjOUVxbzZzQ1NaQTdrV0pnS25y?=
 =?utf-8?B?VVlGTzhVSnNJV1NkNFhUbGEwbDlVMmdScTlMWThTaDJwUFY1RUxmQ1o5R0RO?=
 =?utf-8?B?Q2xvVm5aR0JubHROV3g4dE10ZnU0emx2MmZ2RDh5azRtMTJQdWk1eXlNWWE1?=
 =?utf-8?B?QzJyNWRhM08rQkFteVZKenNrczRobjJKWHFZSjdtdW5SL2QyUExTK0V1a29Y?=
 =?utf-8?B?ZHl0Q1F2Z1hCVkthVGF3OXphb0tOQlJhZkdNdXJKNUUzb1YzTVk3QjZERTF1?=
 =?utf-8?B?RTREM0crRWVCaHJ1NXZVV2xXYm9ockVsQWFOMUo4aVNxSWU5amZDa3VNLzZu?=
 =?utf-8?B?NVNHSUU4WUQvMVhZV1l0aC9VVTN4QUxwclY1MTRxcWxkUGtwbDNQSDM0dURV?=
 =?utf-8?B?dSswRjhsVzQrOGZmaHMvN2cwcGJheVowaVlOZWN2Q1ByMjNvNG5Ya3Mzd3FD?=
 =?utf-8?B?TnpUM3dZNXducW0yVW5xUlNCbjRkOUttVVVhTHJ6K2NwSlVCUm5iaVBueUEx?=
 =?utf-8?B?NjVWUFpvbjhSYktTWHEvRzFIM2JmNldVMHJFYVUvUk9HQ1E2RFA2emxxMnE4?=
 =?utf-8?B?YncwM2twWFBFN2srekNVVjBUMnlOMU5YWmtKT1FUR3NvQUEvMmxBY3lrdWFJ?=
 =?utf-8?Q?S4LhNUeKvH8=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6267
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: df51feaf-c7cc-4ba5-537f-08ddf14c1ecc
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|14060799003|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q01zZVhKZU1GREVLVjhrRktKamxHQXpOMkUxZ0FqdmxnWWVOdTFKRjNnN1NU?=
 =?utf-8?B?M1NqODg5NTVrU01sS2toZE9YVkJrUEtTWGRwUUpERFZIVUNERVc0Q1FyMEZT?=
 =?utf-8?B?clRmUnE4MlkvTElhZENnME4wT1l3bnZMNFNCR2NmK28yZEFhZVZJekJIT0h5?=
 =?utf-8?B?YTU3cTJyOEhiZDNoMzZuM09KLzFUeStodUpsK0hXZHluMllnUFNMUUY1UCtm?=
 =?utf-8?B?cXVtejBwOExDYk9MQzVRZEtNa21xa01Ya1BtbjlFV05hYnNhdlQxTnlFOVJY?=
 =?utf-8?B?UEgxbXE3dVYzS2VQQjhqdjloYUJJSmlvWmcrV3FQK3Q0Z0Z3b0hrZ3hXeHNm?=
 =?utf-8?B?MTFrbVdTZ29vRTRGZ3lnaFVqVitsbTNIQVRzSkJSM3g2SlJiRjNaa1RqL0l1?=
 =?utf-8?B?WGFmYys0UndvREFDZS9mSTFjNzdnZWR5NG4yZDBVanI0Q2prdWdNdnBtQTY3?=
 =?utf-8?B?cUNSNjVvSWhzUGwzT2VtQmdjdDQ1V2JMOVZuMkJ4QkVBdnVBZ2pNU28zdXl2?=
 =?utf-8?B?S1N1TUFuRHRadlpieWtxQmZjOWxtcUxqaGVWdDd6c0x1cGhVcUp0WnhqSHp2?=
 =?utf-8?B?c3BPVk50YzU5RHVKTU44dVp5N280VFI2M09uaGczWk1wdEkvMElOWFlQaWVi?=
 =?utf-8?B?MGxKazZpc1F6OWhZYkxxTkR3bWxjTzlkcUkvV2NCcGwzSmNpd1dUSEVLVUJa?=
 =?utf-8?B?QmdveWtLQ2RvTmczMEI4SzlGSVNZYk9HT0F2OXA0UVdEZXBadGhyRThFUHhZ?=
 =?utf-8?B?TjJSV2VHbXFLc2kyQjgvOHlQTEJrL0QzRTJwOUd3QVlrQVFNTjRiUmNJMFYw?=
 =?utf-8?B?VitINXorYmFaTFgrUDZidHRBNG1YOEZZTGRmT25haGRNTmRMdmtwMjllWm5Y?=
 =?utf-8?B?c2k0Q2VtODh5NWJUVy8rY1VObFhJdzQ3MFJnR1ppVVVYMW5lNjBkMHRnOWJS?=
 =?utf-8?B?MVU5S2JUOUZZUnJLTVdnUjNoL05BaGpieGJ4NVRIT2xYTU8vWk5ieStPazR6?=
 =?utf-8?B?OEd4N0Y3Wmdyd2ErQnVRSU9TZmZiOTFxbkFoWjhwSE1rdEpVY1d5dXBWMWNm?=
 =?utf-8?B?UDl4TXI1a1EzYStNRVAvZ2tqMGwwTzFTaTFYVURnQmNQakZPVEN6aXhoUDRT?=
 =?utf-8?B?NnpMY0EzYWJ5UkZsK2o3UHQ1RkFBQUVIcTBQSzZNMUxzVzd5OXVQVWxvMzhM?=
 =?utf-8?B?MGh2U0lVSmFDVXM4SXMrMzl6S3A4b2JCQ3Y3aTh4b1k2dDZFUktTT0taa1ZU?=
 =?utf-8?B?dHIyOFVHMFI0TUdTM0ZJeWhLdG9waHY3dE1XeGFhTlVwYTM0MHcrNXBacmkr?=
 =?utf-8?B?NE1PS2VNVjduYlNRSm9HQy9Id0RzaXBZRGdvQjMyaUNkbFFmakVxRFB6aHl4?=
 =?utf-8?B?TndUa080UDBYS2FKcEU4ZUNsYVdyeFEyQXN4NVZiTU5NNVZucjRKMzhZNGFw?=
 =?utf-8?B?RU5yUHBja0VFMkc4VkxqZG81eFZ0NGpDQWpnYUgxZWREU1VVL2xNWmIyMXZP?=
 =?utf-8?B?b1JsaHZldkw3eWlZczlyYlR3YzliUTNTR2R1dWoreXpLZjlvTXRrbkJWeTFp?=
 =?utf-8?B?NmlMTEgvQWtwMVRoZzhYaGFiK3RYaHhiL1VPSkhzRi9hRzJVNzE3VUFsNFN1?=
 =?utf-8?B?QStRZUE0TjlPNUpjMzRwSC9DZ1dUcWhnZCttUHpMWFdYUTZKVktUZHB6ajhC?=
 =?utf-8?B?SFBPVjM1Z1FvR0VkN3ZsVjR3U3AwUWs3anNwaHBYSW1oVURWdUdUVU5KUS8x?=
 =?utf-8?B?N3hNQTNqeW1oVHFqTXdyb29QcGVUSWo0VEdiS3lFRzloaDF3cjJ4RCsrcWpY?=
 =?utf-8?B?YVUybm01U0RqVHV0R2VPZ25tOW1YRFBKb1haRGxabi9GRnJIT3ROb2g5UTNM?=
 =?utf-8?B?MTZ2eDM5SmdDTmNHQ1M2VzNkQUQxUzBkMm8zVS92RUwwR096MGhPN1hyNEEr?=
 =?utf-8?B?alByZUFSd05KVGRNZlFpRnh3c3RIc0twQ1hBK2ZTMTJMdGZiTWxaV2RLa1R2?=
 =?utf-8?B?Nm9pV3lBR1VsemJPMWNZK2plSytaQUdFSXRucy8vSkJNMExmWHFHQlJIMWdn?=
 =?utf-8?Q?6KdGzw?=
X-Forefront-Antispam-Report: CIP:20.160.56.82; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(14060799003)(7416014)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:59:06.2876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdb3c34-891b-4145-e101-08ddf14c22fd
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.82];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8499
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

On 9/10/25 12:48, Andre Przywara wrote:
>> +static int smh_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>> +{
>> +	int ret;
>> +
>> +	ret = load_file_from_host("kernel_name", "kernel_addr_r");
>> +	if (ret)
>> +		return log_msg_ret("kernel", ret);
>> +
>> +	env_set("fdt_high", "0xffffffffffffffff");
>> +	env_set("initrd_high", "0xffffffffffffffff");
> 
> As Tom already mentioned, this seems a bit of cargo cult, carried on from
> generation to generation, we should drop this.
> 
>> +
>> +	ret = load_file_from_host("fdtfile", "fdt_addr_r");
>> +	if (ret) {
>> +		ret = run_command("fdt move $fdtcontroladdr $fdt_addr_r;", 0);
>> +		if (ret)
>> +			return log_msg_ret("fdt move", ret);
>> +	}
>> +
>> +	load_file_from_host("ramdisk_name", "ramdisk_addr_r");
> 
> Should we support running without an initramfs? So when this call fails,
> we just use "-" for the second booti parameter.

Personally, I don't use separate FDTs or initramfses at all. It seems like this
flow will break FITs that include their own devicetrees (if they differ from U-Boot's).

--Sean

