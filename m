Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1F6CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9BD8329C;
	Tue, 12 Aug 2025 11:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="U3p6jdAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A4B832AD; Tue, 12 Aug 2025 11:46:06 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 731F383087
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP+Jabo5/KTHYXri2/r6If79m8UnKY84+RIRND6DNlm1P0cwoNTjDqFzxG5uHARIxeZ2/mQt5ujx7IeUhi6en+/Lw7I0h5oghQeTENFeGkj4LyRipiMkOfLaYBKPVtvLQrlxZ8nAMAxPuBN2RbEU7NnaXWCxprtNnCNvv9F9Px0rYUClQYD/5Rb/d2XL9FjZVLkBOdH16LDTB4Rj2fsMzYCGbSTs3bZ4o7A9OcfCGmCUJMopI0aWqPRK8gEc5Y8P162BBq9BwGLrBEIsXVyaH+Vj8MwcJ4LHLdthAhb/bObWf4PImWW/FOSTRT88pBaoW2R0nF5cdlbj4qd5Z5oQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrY1L/q6WFzWhFqkgeJ3KKOJoqUzbHLsHGTGgxR2Ju0=;
 b=hMEgeUdmFGt4+xh6F8faoYq9BnW8IooZLAPDNyio0GwoKJlCFjFCg4fy95zS0V8EALtsfQx6kqiDbrPbxTzE+gUrl1jpgjW/4q07S1u4twFcby9aMtusdNlwRYeu5F6pzdoQrvdEebVN8RxLAus/jE8IzT0fWICBNuNr3G3sKepViyQjT4uIVwtNxK5EYlW9ArCfC73RWnBxf+xUDn6dSHIJ0dUfqFh++7VCAp5Htw1Wc6Sn0z4jwXX27PO2MGh2+u92xBVA9SfMmuP3h+K3+6htdg2wgly/OSVXoA/el+IMUaLCrnpiWiGYcbiQMOGJzELrS/uR26ewN6NBLm2o8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrY1L/q6WFzWhFqkgeJ3KKOJoqUzbHLsHGTGgxR2Ju0=;
 b=U3p6jdAs1P7kDHTQ7HlbKYn1pHEQ7LUAhHuYulptDfEdanAhcOL+kGHrVRflQkcx9ifAIlfN4PAUg7srot+oFjMzQjwSoWd98ZXj71WBMI/2OiSrVfS5MXO9K2/SWoeWtsk4wtfhduh0CC8E69OWXuoyLLQei85LZuiIh5/Zp1GS1hGB3Q5UfgRXe3De41KEHQOh3/pnJRAqYUfGqKo+JfheXhf3WbPkIHbPhvjH7BgZzWglfzywduqCg+b8DEyC0oHjPnRnV/hREIMGb7wlRtCMTJrz/32+HHjn++s9WCnGZpFi9XZRXKgxv7ty6tUmJvb22SJ1CezizlcCJv5ROg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU4PR10MB8974.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 09:46:02 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:46:02 +0000
Message-ID: <8d7ebbdf-9d8c-49b2-b2d5-cd830cd58c3a@kontron.de>
Date: Tue, 12 Aug 2025 11:46:00 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 10/24] mtd: spinand: sync code with linux-6.10
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-11-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-11-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0446.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU4PR10MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9ef0d4-5710-4d87-a9dc-08ddd9850c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGlMcnVqNWt6aWIxZmsrS2s3OVBMY0Y5M3oyakY4dmh6Rjdzd1BMVmJNcjln?=
 =?utf-8?B?Umd2QUIvVTgrM3ZsRG5PU0RpS1NOUi9UTDZyV29KMGdzcGpkUDF1Y3pwWHVU?=
 =?utf-8?B?M01idlI4Q044QzZrM3hGOWVkTER5OU4xdXZRTFM3MmZjWXNJRTQ2TkpCV2wz?=
 =?utf-8?B?RDIwZFl2TmlyWldqNTZmZGVBS3h3VGJLeWw3WCtZaERhMHJSQkk2eitzMStQ?=
 =?utf-8?B?RURuRTUwYXZQSVdSNG9LRGVMRDRpbFdtWnVQbFVPdWJ3LytaVG85VExHODE2?=
 =?utf-8?B?SU9IK0pQdWpsaWxIeWt3RW5WTXh0VHJDY3ZrbnV3T2lKN3ZjTi9sMmxyRXRT?=
 =?utf-8?B?b0JRRjhwMXBabFpUcVhHMFd4Y2JVSjNyZzEyaUxjZzZ6SFdZOEFNMEZ0L1Jq?=
 =?utf-8?B?UEtvdVh4cEp0ekR6dVZzdUpvS0pXVDV4eXZBOXgzODlKdVpBY2xVOEhGUkEw?=
 =?utf-8?B?OVRHRmk4V3p3TU1MYU56LzlRRkljOXVnU3NhclVUdzQxcmowWVhmbDcrb2t0?=
 =?utf-8?B?aTFoa09FQ0xYdVZvUGxDWE02SUltQ0l2dmdjS1gvUUdvK3FrcDVwazFZcFE5?=
 =?utf-8?B?SXN1b2NrTStPK2hLcVJJU0w5UEpNL0FSQThGTUlJc0lvNEhmQ2ROU0hTUWtN?=
 =?utf-8?B?R2o2c09ybXVjM0ZDd3B2c2pmajVLZCtZMzRjTnpmM0dDa3BSeGVBMDJiL1Ba?=
 =?utf-8?B?MEtYR3FZcm80VmhCRWNLai9BWmx5ZEU0MHVQSGNaeWdEMFo2bU1teU02cjla?=
 =?utf-8?B?TkJUSDdYL0xVcFhoMk1QQlAxVHFnQndxekN5Q2psMElDb0k3MFh1OTE0OHpI?=
 =?utf-8?B?VVNDU01qazJwVThpckVCMDZhZ2dkQWV1TEpCZStXZVJUbmZ2azBGcE4vK2VL?=
 =?utf-8?B?UDZRY1FEVlNYMzBWNjBsWHE2TTd5UFFwNHVVU08wOGYwY0EzbXlKRGpUZTl4?=
 =?utf-8?B?blRNZWpXYkVwUlg2NHplOFY2MWl6MGZEby9PRDZXLzBYWlVMbEFCMXhOUUg5?=
 =?utf-8?B?RTRxMnNUNjBPZ1FNUHVJVEEzRlNNNGxjcUFCcjBtalFMYXJ6ZGkxbmRDcUR4?=
 =?utf-8?B?VURNZzZrUXdLK0xsZWIxTFdud0pxeFcyYnhXc2V0My9JNWZQZ2Y1d2EvTm8x?=
 =?utf-8?B?UzQ2dkN5TllNZTlINzdBWnVwcUN6SWxIQU1WTjN2bk1sQ2pYbC8wbERzdTBJ?=
 =?utf-8?B?VVl1Mkl5L1ZhMisycnJSSjNDc2VrMVVYaVRhM1A5SWpDUm5VV09wekFsaUQ4?=
 =?utf-8?B?SW5vSWt2RHI2UlJ5bTRmM0pjb29FbHJDYXdvWWk3bmdMTVlGN0ZJTDdrMDVZ?=
 =?utf-8?B?NEZ6aDBhTzFoUGNlK004NG9ja0VMV0xXaXFqODlrS1owcTlKZXArSlMrM1ov?=
 =?utf-8?B?SW0xdFpjV0VPRGRlSWppZEJlRHVsb3J5MHJJM0RMZjhwL1dadlN1SG1NZzU5?=
 =?utf-8?B?Z2lWYytaMFAycDBKWEpoYkpHdkNYbDJiWURhTXNGaU16RmZoTlVZd1VIVW1l?=
 =?utf-8?B?c2poZThvTzVZVnQ4bU1GdllGbCtoTmoxVEloU2Fkam5BRlN1VzkyczM0YXpj?=
 =?utf-8?B?cWY2RTZGMC8zV1EyK21ZT1I1Q0dzeVl6NmlLYUF5WW9ZN0cwOEp6bXNhazRC?=
 =?utf-8?B?djZlOGFmZU9Xdk9GOCtzTklWS002RWpZRmlQaHlEOGY1aVRzSzZiLzNVU096?=
 =?utf-8?B?eEwrQ2JZUkF0RVZiWTV1b0dsRmJ5Nit3QWd5bHg4T3BYUVN1TFZYT3RCVXZm?=
 =?utf-8?B?dTJmeWdWSUZkQjBIM1F0TjZEMzNBVG8wZW00dllPNUdDMHN3SDlhOVdueWhF?=
 =?utf-8?B?ZWVMaW1LcS9jT2dDdUg0c20rU0hJUit4cnB1Sk0yRi9naXErMmxVY3Q4TDJn?=
 =?utf-8?B?dEowU2t3Q3FBQTA3c1BETDlvdnFoSWVwS1JacHMxMTc1V0dsYkEyU3pveXRm?=
 =?utf-8?B?TDA4MlVtVlhwMEkxUUhKVjZLREpKUHROQkZONGphalo3RWRrOUViaGR5VTdy?=
 =?utf-8?B?V0RyYXE0OGVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2FmNjJlekdMUFhlVXpVcS9RWiswbFhvTjFKVnJMMm92QWY3bXJWcjB2S1pq?=
 =?utf-8?B?YWpNK3Z0TkJzcGt5c0U5bkkrRUF3VGxBOExmRHNrMzlJUzdvNVZvWTU5TzJJ?=
 =?utf-8?B?OXRHVTErOHZ2ZHZiRmJtRit1MmVUd0w3dzV1Wk8vZ3JhV0JneEx5ZHFrSGl6?=
 =?utf-8?B?UFJTOXR3TFV0Q2xnWEFheHBzYzJLQVcwRkJwejROMXF5ay84R3IraTB4aTly?=
 =?utf-8?B?dFpOa2RENDFFQUtUaXAwSE1JK0p4dG9LYVpmR244Y1FPSml5bHRRZTA1L2pI?=
 =?utf-8?B?bTV2Z0ZEbCswSWRDMzE5NHhoTkt5Q0thbUI5R0o5VE1BUjNLTy9CNUY2RGcw?=
 =?utf-8?B?THVRQ2lMQVZLaWduQUljQ2Ztb2ZZM21pVW5rMGU0cEtPQXkxd25ONjVsdThN?=
 =?utf-8?B?ODhsTnViTlZjc2ZQZlNEeHIzTnhSRzNXSUlIZC9ibVJCdEVLNVBFT011bklS?=
 =?utf-8?B?Um5sSFU2c1RWVTE0R2dOYkk4UEZsNURCMk1QR3p4MkZjWGFBK0pyb3gzOW9N?=
 =?utf-8?B?L2lpTndJWHk1dzVqWStDUEFCUUR6VEVzbFJyU09BZFgxdk9RSlVvSEptVnJj?=
 =?utf-8?B?N2M5am1paDUvR0RINTYrOGxVcnQzNDU2Qk5zWFh1c0tHeEhDMW1lRE5kVWVn?=
 =?utf-8?B?VW4zOTFrQmFjVkUvRGRwRWUxRWh0eEpaUnpHeWhWRm16U1VjbldGbVViMXZs?=
 =?utf-8?B?K3Q4VzBWM0tpNVRqRVV6VFRFYXRtOG9CT3VjVEs2REQ1VmtaLzR4SVZjWVZk?=
 =?utf-8?B?UWVwZ1dqNUN0Q1lOaUV6dWZDeHVzUncwSS9EbE12Z2pJRzYydG5DUytRb2Jn?=
 =?utf-8?B?c00xYmRITnc1VlQ1alloV05uQm8wRGFhOW53UFBqS2NvY1h1RWxPYjAxM0Nq?=
 =?utf-8?B?L09CdWVreHBHdnhSdDlWaXBXOXQvNm5ObUlhbGVjWjFiZnNwS3RjcEhSRktk?=
 =?utf-8?B?Vm1ZS1RmSkwreEJlT2d6ZkZERVR4aE52dDRvSWU2RTNDUWNGMmxqcTJ4ZSth?=
 =?utf-8?B?U2p6c0dYTThkaDM1UUNWeFplSEdJUnJYdE9jUDZzUEJqSmluNGZsclZ1R3Fo?=
 =?utf-8?B?N3h1ckJzMHBSdi8ybUhKaTdKWVUyZjk3Y09NUEtPdU9aaXpTQW9Ec2pOTnk2?=
 =?utf-8?B?cFhKN04wM1FHbWRQNmZHS0MrK0Z3LzlSeFJTWWllVGh2WG5UQlB4Qkc4QUVi?=
 =?utf-8?B?YXlwalZZME8zVlBwVlc3aVZYeHlxYTIrWGpzK3ZKTWVGTk1iM1lUTWdlU1RP?=
 =?utf-8?B?cVZBREVsL0JuR2ZvWDEzclZORjhXc1REdlVEakgvZ2xtcHRaU29FVDYwYmd4?=
 =?utf-8?B?bEl5dnNGRnczZ0RxUDRhZXUvQlVQTHIvOW9XUVlqTGZqSi9wRndEb1YySElI?=
 =?utf-8?B?eWNneVJqZzh6R3VMeE44cHlLaVloa2g1c2FkVldiczVFQkd2Z0tNOU5Da1o2?=
 =?utf-8?B?ZjhTRGhJZmZtM25iUFcwZkNsRG8xbWswWDNZUjNTVE5mYTNQdjhydUx5eTFX?=
 =?utf-8?B?cUFlZU0vc2FmLzZsd0RWY1ZrV2FqcXVLMEp4MkM3M1ZLRWpxMEFKU1hGTzZR?=
 =?utf-8?B?MVQ0a2lHZG1VZ3dGb0JmZDVWRWtSanV1eldLWFM2MFlEWkl6dEVkb2tQWC9o?=
 =?utf-8?B?b1pmM1lOVGFOK091YmZWVEd1OC9Kc0o1ODJZZ0tseVVpN25jWVFwa2JZU0Zl?=
 =?utf-8?B?TS9vY1doZHRKanNQWXFxd2VnVnJ5Yk5vZ1pWMmhuTFhseHZVNVR2a2hSYUN6?=
 =?utf-8?B?NUpkTGRaV1ZKL1E5TWhoM0sxYWpWdS8zWitkWitOMHU3bnh5cjlLMEM2aGZ5?=
 =?utf-8?B?c05UdmdDV0EzTmkycCtUZ1F0ZUFKOWUreGUxMWhGY2pRd3VuOUVteUh4VTlI?=
 =?utf-8?B?bWwyRVMyK0F6QndPMVJMcGhkcGVCRTFST3lQcVJTeGJjOWVTNE9VMDNucE9u?=
 =?utf-8?B?MDRiQzYwU2tRdmNWT1NDdXhIL1FZaFpvQnZDWEZuM2l4cW8wV2NFc3ZFUzBP?=
 =?utf-8?B?UDNCWUtsTTNFVzFWQXFhN2o3Z3N6TXFrdmMvV2xUbytBTXlJeG41ZENZZThD?=
 =?utf-8?B?V3ljNHlpSmI0QTFwZzdWYmRrNmh4OXpVdlJmbGpIZkE0NkZzTjZIZFNWVDZV?=
 =?utf-8?B?Rk1na2wvTUVVNC9BMXpXcHowZ25lcWV3NUlHMlkrTVpZeFVDWCtrOFF5akNv?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9ef0d4-5710-4d87-a9dc-08ddd9850c6b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:46:02.0942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8IT21nLlGjWAsrnv6kQbyCncT36nTAl1mWxpGDbevvOPfNmdP0TRp9iWYHMcYpYvc+J+AL5+njmGBTRAILv+GXgQBJUZUDlSN8gZWiYHuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8974
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

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> This makes u-boot spinand driver almost the same as spinand driver
> from linux-6.10. The only major difference is support of ECC engines.
> The linux driver supports different ECC engines while u-boot driver
> uses on-die ecc only.

Suggestion for subject and commit message:

###
mtd: spinand: Sync device support with Linux 6.10

This makes the U-Boot SPI NAND driver almost the same as in Linux 6.10.
The only major difference is support of ECC engines. The Linux driver
supports different ECC engines while U-Boot uses on-die ECC only.
###

> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/Makefile         |   4 +-
>  drivers/mtd/nand/spi/alliancememory.c | 155 ++++++++++++++++++++++++++
>  drivers/mtd/nand/spi/ato.c            |  84 ++++++++++++++
>  drivers/mtd/nand/spi/core.c           | 151 +++++++++++++++++++------
>  drivers/mtd/nand/spi/esmt.c           |  16 ++-
>  drivers/mtd/nand/spi/foresee.c        |  97 ++++++++++++++++
>  drivers/mtd/nand/spi/gigadevice.c     |   6 +-
>  drivers/mtd/nand/spi/macronix.c       |  32 +++++-
>  drivers/mtd/nand/spi/micron.c         |   2 +-
>  drivers/mtd/nand/spi/toshiba.c        |  43 ++++++-
>  drivers/mtd/nand/spi/winbond.c        |  55 ++++++++-
>  include/linux/mtd/nand.h              |  23 ++++
>  include/linux/mtd/spinand.h           |  10 +-
>  13 files changed, 619 insertions(+), 59 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/alliancememory.c
>  create mode 100644 drivers/mtd/nand/spi/ato.c
>  create mode 100644 drivers/mtd/nand/spi/foresee.c
> 
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 65b836b34ca..d438747cf37 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -spinand-objs := core.o esmt.o gigadevice.o macronix.o micron.o paragon.o
> -spinand-objs += toshiba.o winbond.o xtx.o
> +spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
> +spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
> new file mode 100644
> index 00000000000..e29e4cc77ec
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/alliancememory.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author: Mario Kicherer <dev@kicherer.org>
> + */
> +
> +#ifndef __UBOOT__
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#endif
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_ALLIANCEMEMORY	0x52
> +
> +#define AM_STATUS_ECC_BITMASK		(3 << 4)
> +
> +#define AM_STATUS_ECC_NONE_DETECTED	(0 << 4)
> +#define AM_STATUS_ECC_CORRECTED		(1 << 4)
> +#define AM_STATUS_ECC_ERRORED		(2 << 4)
> +#define AM_STATUS_ECC_MAX_CORRECTED	(3 << 4)
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> +			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> +			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static int am_get_eccsize(struct mtd_info *mtd)
> +{
> +	if (mtd->oobsize == 64)
> +		return 0x20;
> +	else if (mtd->oobsize == 128)
> +		return 0x38;
> +	else if (mtd->oobsize == 256)
> +		return 0x70;
> +	else
> +		return -EINVAL;
> +}
> +
> +static int am_ooblayout_ecc(struct mtd_info *mtd, int section,
> +			    struct mtd_oob_region *region)
> +{
> +	int ecc_bytes;
> +
> +	ecc_bytes = am_get_eccsize(mtd);
> +	if (ecc_bytes < 0)
> +		return ecc_bytes;
> +
> +	region->offset = mtd->oobsize - ecc_bytes;
> +	region->length = ecc_bytes;
> +
> +	return 0;
> +}
> +
> +static int am_ooblayout_free(struct mtd_info *mtd, int section,
> +			     struct mtd_oob_region *region)
> +{
> +	int ecc_bytes;
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	ecc_bytes = am_get_eccsize(mtd);
> +	if (ecc_bytes < 0)
> +		return ecc_bytes;
> +
> +	/*
> +	 * It is unclear how many bytes are used for the bad block marker. We
> +	 * reserve the common two bytes here.
> +	 *
> +	 * The free area in this kind of flash is divided into chunks where the
> +	 * first 4 bytes of each chunk are unprotected. The number of chunks
> +	 * depends on the specific model. The models with 4096+256 bytes pages
> +	 * have 8 chunks, the others 4 chunks.
> +	 */
> +
> +	region->offset = 2;
> +	region->length = mtd->oobsize - 2 - ecc_bytes;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops am_ooblayout = {
> +	.ecc = am_ooblayout_ecc,
> +	.rfree = am_ooblayout_free,
> +};
> +
> +static int am_ecc_get_status(struct spinand_device *spinand, u8 status)
> +{
> +	switch (status & AM_STATUS_ECC_BITMASK) {
> +	case AM_STATUS_ECC_NONE_DETECTED:
> +		return 0;
> +
> +	case AM_STATUS_ECC_CORRECTED:
> +		/*
> +		 * use oobsize to determine the flash model and the maximum of
> +		 * correctable errors and return maximum - 1 by convention
> +		 */
> +		if (spinand->base.mtd->oobsize == 64)
> +			return 3;
> +		else
> +			return 7;
> +
> +	case AM_STATUS_ECC_ERRORED:
> +		return -EBADMSG;
> +
> +	case AM_STATUS_ECC_MAX_CORRECTED:
> +		/*
> +		 * use oobsize to determine the flash model and the maximum of
> +		 * correctable errors
> +		 */
> +		if (spinand->base.mtd->oobsize == 64)
> +			return 4;
> +		else
> +			return 8;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct spinand_info alliancememory_spinand_table[] = {
> +	SPINAND_INFO("AS5F34G04SND",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2f),
> +		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&am_ooblayout,
> +				     am_ecc_get_status)),
> +};
> +
> +static const struct spinand_manufacturer_ops alliancememory_spinand_manuf_ops = {
> +};
> +
> +const struct spinand_manufacturer alliancememory_spinand_manufacturer = {
> +	.id = SPINAND_MFR_ALLIANCEMEMORY,
> +	.name = "AllianceMemory",
> +	.chips = alliancememory_spinand_table,
> +	.nchips = ARRAY_SIZE(alliancememory_spinand_table),
> +	.ops = &alliancememory_spinand_manuf_ops,
> +};
> diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
> new file mode 100644
> index 00000000000..f0d4436cf45
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/ato.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Aidan MacDonald
> + *
> + * Author: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> + */
> +
> +#ifndef __UBOOT__
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#endif
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_ATO		0x9b
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static int ato25d1ga_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	region->offset = (16 * section) + 8;
> +	region->length = 8;
> +	return 0;
> +}
> +
> +static int ato25d1ga_ooblayout_free(struct mtd_info *mtd, int section,
> +				    struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	if (section) {
> +		region->offset = (16 * section);
> +		region->length = 8;
> +	} else {
> +		/* first byte of section 0 is reserved for the BBM */
> +		region->offset = 1;
> +		region->length = 7;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops ato25d1ga_ooblayout = {
> +	.ecc = ato25d1ga_ooblayout_ecc,
> +	.rfree = ato25d1ga_ooblayout_free,
> +};
> +
> +static const struct spinand_info ato_spinand_table[] = {
> +	SPINAND_INFO("ATO25D1GA",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x12),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&ato25d1ga_ooblayout, NULL)),
> +};
> +
> +static const struct spinand_manufacturer_ops ato_spinand_manuf_ops = {
> +};
> +
> +const struct spinand_manufacturer ato_spinand_manufacturer = {
> +	.id = SPINAND_MFR_ATO,
> +	.name = "ATO",
> +	.chips = ato_spinand_table,
> +	.nchips = ARRAY_SIZE(ato_spinand_table),
> +	.ops = &ato_spinand_manuf_ops,
> +};
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index a6353b37e7f..b4795927277 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -239,7 +239,7 @@ static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
>  		 * fixed, so let's return the maximum possible value so that
>  		 * wear-leveling layers move the data immediately.
>  		 */
> -		return nand->eccreq.strength;
> +		return nanddev_get_ecc_conf(nand)->strength;
>  
>  	case STATUS_ECC_UNCOR_ERROR:
>  		return -EBADMSG;
> @@ -275,6 +275,66 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
>  	.rfree = spinand_noecc_ooblayout_free,
>  };
>  
> +static int spinand_ondie_ecc_init_ctx(struct nand_device *nand)
> +{
> +	struct spinand_device *spinand = nand_to_spinand(nand);
> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
> +
> +	if (spinand->eccinfo.ooblayout)
> +		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
> +	else
> +		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
> +
> +	return 0;
> +}
> +
> +static void spinand_ondie_ecc_cleanup_ctx(struct nand_device *nand)
> +{
> +}
> +
> +static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
> +					    struct nand_page_io_req *req)
> +{
> +	struct spinand_device *spinand = nand_to_spinand(nand);
> +	bool enable = (req->mode != MTD_OPS_RAW);
> +
> +	memset(spinand->oobbuf, 0xff, nanddev_per_page_oobsize(nand));
> +
> +	/* Only enable or disable the engine */
> +	return spinand_ecc_enable(spinand, enable);
> +}
> +
> +static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
> +					   struct nand_page_io_req *req)
> +{
> +	struct spinand_device *spinand = nand_to_spinand(nand);
> +	struct mtd_info *mtd = spinand_to_mtd(spinand);
> +	int ret;
> +
> +	if (req->mode == MTD_OPS_RAW)
> +		return 0;
> +
> +	/* Nothing to do when finishing a page write */
> +	if (req->type == NAND_PAGE_WRITE)
> +		return 0;
> +
> +	/* Finish a page read: check the status, report errors/bitflips */
> +	ret = spinand_check_ecc_status(spinand, spinand->last_wait_status);
> +	if (ret == -EBADMSG)
> +		mtd->ecc_stats.failed++;
> +	else if (ret > 0)
> +		mtd->ecc_stats.corrected += ret;
> +
> +	return ret;
> +}
> +
> +static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
> +{
> +	struct spinand_device *spinand = nand_to_spinand(nand);
> +
> +	spinand->last_wait_status = status;
> +}
> +
>  static int spinand_write_enable_op(struct spinand_device *spinand)
>  {
>  	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
> @@ -317,7 +377,10 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
>  		}
>  	}
>  
> -	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
> +	if (req->mode == MTD_OPS_RAW)
> +		rdesc = spinand->dirmaps[req->pos.plane].rdesc;
> +	else
> +		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
>  
>  	while (nbytes) {
>  		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
> @@ -366,9 +429,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
>  	 * must fill the page cache entirely even if we only want to program
>  	 * the data portion of the page, otherwise we might corrupt the BBM or
>  	 * user data previously programmed in OOB area.
> +	 *
> +	 * Only reset the data buffer manually, the OOB buffer is prepared by
> +	 * ECC engines ->prepare_io_req() callback.
>  	 */
>  	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
> -	memset(spinand->databuf, 0xff, nbytes);
> +	memset(spinand->databuf, 0xff, nanddev_page_size(nand));
>  
>  	if (req->datalen)
>  		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
> @@ -385,7 +451,10 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
>  			       req->ooblen);
>  	}
>  
> -	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
> +	if (req->mode == MTD_OPS_RAW)
> +		wdesc = spinand->dirmaps[req->pos.plane].wdesc;
> +	else
> +		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
>  
>  	while (nbytes) {
>  		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
> @@ -498,12 +567,16 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
>  }
>  
>  static int spinand_read_page(struct spinand_device *spinand,
> -			     const struct nand_page_io_req *req,
> -			     bool ecc_enabled)
> +			     const struct nand_page_io_req *req)
>  {
> +	struct nand_device *nand = spinand_to_nand(spinand);
>  	u8 status;
>  	int ret;
>  
> +	ret = spinand_ondie_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req);
> +	if (ret)
> +		return ret;
> +
>  	ret = spinand_load_page_op(spinand, req);
>  	if (ret)
>  		return ret;
> @@ -515,22 +588,26 @@ static int spinand_read_page(struct spinand_device *spinand,
>  	if (ret < 0)
>  		return ret;
>  
> +	spinand_ondie_ecc_save_status(nand, status);
> +
>  	ret = spinand_read_from_cache_op(spinand, req);
>  	if (ret)
>  		return ret;
>  
> -	if (!ecc_enabled)
> -		return 0;
> -
> -	return spinand_check_ecc_status(spinand, status);
> +	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
>  }
>  
>  static int spinand_write_page(struct spinand_device *spinand,
>  			      const struct nand_page_io_req *req)
>  {
> +	struct nand_device *nand = spinand_to_nand(spinand);
>  	u8 status;
>  	int ret;
>  
> +	ret = spinand_ondie_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req);
> +	if (ret)
> +		return ret;
> +
>  	ret = spinand_write_enable_op(spinand);
>  	if (ret)
>  		return ret;
> @@ -550,7 +627,7 @@ static int spinand_write_page(struct spinand_device *spinand,
>  	if (!ret && (status & STATUS_PROG_FAILED))
>  		return -EIO;
>  
> -	return ret;
> +	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
>  }
>  
>  static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
> @@ -580,21 +657,14 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
>  		if (ret)
>  			break;
>  
> -		ret = spinand_ecc_enable(spinand, !disable_ecc);
> -		if (ret)
> -			break;
> -
> -		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
> +		ret = spinand_read_page(spinand, &iter.req);
>  		if (ret < 0 && ret != -EBADMSG)
>  			break;
>  
> -		if (ret == -EBADMSG) {
> +		if (ret == -EBADMSG)
>  			ecc_failed = true;
> -			mtd->ecc_stats.failed++;
> -		} else {
> -			mtd->ecc_stats.corrected += ret;
> +		else
>  			max_bitflips = max_t(unsigned int, max_bitflips, ret);
> -		}
>  
>  		ret = 0;
>  		ops->retlen += iter.req.datalen;
> @@ -635,10 +705,6 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
>  		if (ret)
>  			break;
>  
> -		ret = spinand_ecc_enable(spinand, !disable_ecc);
> -		if (ret)
> -			break;
> -
>  		ret = spinand_write_page(spinand, &iter.req);
>  		if (ret)
>  			break;
> @@ -667,7 +733,7 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
>  	};
>  
>  	spinand_select_target(spinand, pos->target);
> -	spinand_read_page(spinand, &req, false);
> +	spinand_read_page(spinand, &req);
>  	if (marker[0] != 0xff || marker[1] != 0xff)
>  		return true;
>  
> @@ -835,6 +901,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
>  
>  	spinand->dirmaps[plane].rdesc = desc;
>  
> +	spinand->dirmaps[plane].wdesc_ecc = spinand->dirmaps[plane].wdesc;
> +	spinand->dirmaps[plane].rdesc_ecc = spinand->dirmaps[plane].rdesc;
> +
>  	return 0;
>  }
>  
> @@ -866,13 +935,16 @@ static const struct nand_ops spinand_ops = {
>  };
>  
>  static const struct spinand_manufacturer *spinand_manufacturers[] = {
> +	&alliancememory_spinand_manufacturer,
> +	&ato_spinand_manufacturer,
> +	&esmt_c8_spinand_manufacturer,
> +	&foresee_spinand_manufacturer,
>  	&gigadevice_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
>  	&paragon_spinand_manufacturer,
>  	&toshiba_spinand_manufacturer,
>  	&winbond_spinand_manufacturer,
> -	&esmt_c8_spinand_manufacturer,
>  	&xtx_spinand_manufacturer,
>  };
>  
> @@ -900,7 +972,7 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
>  		spinand->manufacturer = manufacturer;
>  		return 0;
>  	}
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  
>  static int spinand_id_detect(struct spinand_device *spinand)
> @@ -1034,7 +1106,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
>  			return ret;
>  
>  		nand->memorg = table[i].memorg;
> -		nand->eccreq = table[i].eccreq;
> +		nanddev_set_ecc_requirements(nand, &table[i].eccreq);
>  		spinand->eccinfo = table[i].eccinfo;
>  		spinand->flags = table[i].flags;
>  		spinand->id.len = 1 + table[i].devid.len;
> @@ -1186,6 +1258,11 @@ static int spinand_init(struct spinand_device *spinand)
>  	if (ret)
>  		goto err_manuf_cleanup;
>  
> +	spinand_ecc_enable(spinand, false);
> +	ret = spinand_ondie_ecc_init_ctx(nand);
> +	if (ret)
> +		goto err_cleanup_nanddev;
> +
>  	mtd->_read_oob = spinand_mtd_read;
>  	mtd->_write_oob = spinand_mtd_write;
>  	mtd->_block_isbad = spinand_mtd_block_isbad;
> @@ -1193,27 +1270,29 @@ static int spinand_init(struct spinand_device *spinand)
>  	mtd->_block_isreserved = spinand_mtd_block_isreserved;
>  	mtd->_erase = spinand_mtd_erase;
>  
> -	if (spinand->eccinfo.ooblayout)
> -		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
> -	else
> -		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
> -
>  	ret = mtd_ooblayout_count_freebytes(mtd);
>  	if (ret < 0)
> -		goto err_cleanup_nanddev;
> +		goto err_cleanup_ecc_engine;
>  
>  	mtd->oobavail = ret;
>  
> +	/* Propagate ECC information to mtd_info */
> +	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
> +	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
> +
>  	ret = spinand_create_dirmaps(spinand);
>  	if (ret) {
>  		dev_err(dev,
>  			"Failed to create direct mappings for read/write operations (err = %d)\n",
>  			ret);
> -		goto err_cleanup_nanddev;
> +		goto err_cleanup_ecc_engine;
>  	}
>  
>  	return 0;
>  
> +err_cleanup_ecc_engine:
> +	spinand_ondie_ecc_cleanup_ctx(nand);
> +
>  err_cleanup_nanddev:
>  	nanddev_cleanup(nand);
>  
> diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
> index 7e07b26827a..23be098b885 100644
> --- a/drivers/mtd/nand/spi/esmt.c
> +++ b/drivers/mtd/nand/spi/esmt.c
> @@ -106,7 +106,8 @@ static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
>  
>  static const struct spinand_info esmt_c8_spinand_table[] = {
>  	SPINAND_INFO("F50L1G41LB",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
> +				0x7f, 0x7f),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(1, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -115,7 +116,8 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
>  		     0,
>  		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
>  	SPINAND_INFO("F50D1G41LB",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11, 0x7f,
> +				0x7f, 0x7f),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(1, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -123,6 +125,16 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
>  					      &update_cache_variants),
>  		     0,
>  		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
> +	SPINAND_INFO("F50D2G41KA",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51, 0x7f,
> +				0x7f, 0x7f),
> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
>  };
>  
>  static const struct spinand_manufacturer_ops esmt_spinand_manuf_ops = {
> diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
> new file mode 100644
> index 00000000000..6229c959b2c
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/foresee.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> + *
> + * Author: Martin Kurbanov <mmkurbanov@salutedevices.com>
> + */
> +
> +#ifndef __UBOOT__
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#endif
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_FORESEE		0xCD
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static int f35sqa002g_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				    struct mtd_oob_region *region)
> +{
> +	return -ERANGE;
> +}
> +
> +static int f35sqa002g_ooblayout_free(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *region)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	/* Reserve 2 bytes for the BBM. */
> +	region->offset = 2;
> +	region->length = 62;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops f35sqa002g_ooblayout = {
> +	.ecc = f35sqa002g_ooblayout_ecc,
> +	.rfree = f35sqa002g_ooblayout_free,
> +};
> +
> +static int f35sqa002g_ecc_get_status(struct spinand_device *spinand, u8 status)
> +{
> +	struct nand_device *nand = spinand_to_nand(spinand);
> +
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case STATUS_ECC_HAS_BITFLIPS:
> +		return nanddev_get_ecc_conf(nand)->strength;
> +
> +	default:
> +		break;
> +	}
> +
> +	/* More than 1-bit error was detected in one or more sectors and
> +	 * cannot be corrected.
> +	 */
> +	return -EBADMSG;
> +}
> +
> +static const struct spinand_info foresee_spinand_table[] = {
> +	SPINAND_INFO("F35SQA002G",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x72, 0x72),
> +		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
> +				     f35sqa002g_ecc_get_status)),
> +};
> +
> +static const struct spinand_manufacturer_ops foresee_spinand_manuf_ops = {
> +};
> +
> +const struct spinand_manufacturer foresee_spinand_manufacturer = {
> +	.id = SPINAND_MFR_FORESEE,
> +	.name = "FORESEE",
> +	.chips = foresee_spinand_table,
> +	.nchips = ARRAY_SIZE(foresee_spinand_table),
> +	.ops = &foresee_spinand_manuf_ops,
> +};
> diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
> index fe8c76acac6..f3608a13d8e 100644
> --- a/drivers/mtd/nand/spi/gigadevice.c
> +++ b/drivers/mtd/nand/spi/gigadevice.c
> @@ -190,7 +190,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
>  {
>  	u8 status2;
>  	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
> -						      &status2);
> +						      spinand->scratchbuf);
>  	int ret;
>  
>  	switch (status & STATUS_ECC_MASK) {
> @@ -211,6 +211,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
>  		 * report the maximum of 4 in this case
>  		 */
>  		/* bits sorted this way (3...0): ECCS1,ECCS0,ECCSE1,ECCSE0 */
> +		status2 = *(spinand->scratchbuf);
>  		return ((status & STATUS_ECC_MASK) >> 2) |
>  			((status2 & STATUS_ECC_MASK) >> 4);
>  
> @@ -232,7 +233,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
>  {
>  	u8 status2;
>  	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
> -						      &status2);
> +						      spinand->scratchbuf);
>  	int ret;
>  
>  	switch (status & STATUS_ECC_MASK) {
> @@ -252,6 +253,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
>  		 * 1 ... 4 bits are flipped (and corrected)
>  		 */
>  		/* bits sorted this way (1...0): ECCSE1, ECCSE0 */
> +		status2 = *(spinand->scratchbuf);
>  		return ((status2 & STATUS_ECC_MASK) >> 4) + 1;
>  
>  	case STATUS_ECC_UNCOR_ERROR:
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
> index 86bffc2800b..c2a7aa2da96 100644
> --- a/drivers/mtd/nand/spi/macronix.c
> +++ b/drivers/mtd/nand/spi/macronix.c
> @@ -23,7 +23,7 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
>  
>  static SPINAND_OP_VARIANTS(write_cache_variants,
>  		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_variants,
>  		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> @@ -86,11 +86,13 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
>  		 * in order to avoid forcing the wear-leveling layer to move
>  		 * data around if it's not necessary.
>  		 */
> -		if (mx35lf1ge4ab_get_eccsr(spinand, &eccsr))
> -			return nand->eccreq.strength;
> +		if (mx35lf1ge4ab_get_eccsr(spinand, spinand->scratchbuf))
> +			return nanddev_get_ecc_conf(nand)->strength;
>  
> -		if (WARN_ON(eccsr > nand->eccreq.strength || !eccsr))
> -			return nand->eccreq.strength;
> +		eccsr = *spinand->scratchbuf;
> +		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength ||
> +			    !eccsr))
> +			return nanddev_get_ecc_conf(nand)->strength;
>  
>  		return eccsr;
>  
> @@ -300,6 +302,26 @@ static const struct spinand_info macronix_spinand_table[] = {
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
>  				     mx35lf1ge4ab_ecc_get_status)),
>  
> +	SPINAND_INFO("MX31LF2GE4BC",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2e),
> +		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> +				     mx35lf1ge4ab_ecc_get_status)),
> +	SPINAND_INFO("MX3UF2GE4BC",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae),
> +		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> +				     mx35lf1ge4ab_ecc_get_status)),
>  };
>  
>  static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index b538213ed8e..01c177facfb 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -14,7 +14,7 @@
>  
>  #define SPINAND_MFR_MICRON		0x2c
>  
> -#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
> +#define MICRON_STATUS_ECC_MASK		GENMASK(6, 4)
>  #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
>  #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
>  #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
> index b9908e79271..bf7da57de13 100644
> --- a/drivers/mtd/nand/spi/toshiba.c
> +++ b/drivers/mtd/nand/spi/toshiba.c
> @@ -76,7 +76,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	u8 mbf = 0;
> -	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
> +	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
>  
>  	switch (status & STATUS_ECC_MASK) {
>  	case STATUS_ECC_NO_BITFLIPS:
> @@ -93,12 +93,12 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
>  		 * data around if it's not necessary.
>  		 */
>  		if (spi_mem_exec_op(spinand->slave, &op))
> -			return nand->eccreq.strength;
> +			return nanddev_get_ecc_conf(nand)->strength;
>  
> -		mbf >>= 4;
> +		mbf = *(spinand->scratchbuf) >> 4;
>  
> -		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
> -			return nand->eccreq.strength;
> +		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
> +			return nanddev_get_ecc_conf(nand)->strength;
>  
>  		return mbf;
>  
> @@ -269,6 +269,39 @@ static const struct spinand_info toshiba_spinand_table[] = {
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
>  				     tx58cxgxsxraix_ecc_get_status)),
> +	/* 1.8V 1Gb (1st generation) */
> +	SPINAND_INFO("TC58NYG0S3HBAI4",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA1),
> +		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
> +				     tx58cxgxsxraix_ecc_get_status)),
> +	/* 1.8V 4Gb (1st generation) */
> +	SPINAND_INFO("TH58NYG2S3HBAI4",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xAC),
> +		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 2, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_x4_variants,
> +					      &update_cache_x4_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
> +				     tx58cxgxsxraix_ecc_get_status)),
> +	/* 1.8V 8Gb (1st generation) */
> +	SPINAND_INFO("TH58NYG3S0HBAI6",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA3),
> +		     NAND_MEMORG(1, 4096, 256, 64, 4096, 80, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_x4_variants,
> +					      &update_cache_x4_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
> +				     tx58cxgxsxraix_ecc_get_status)),
>  };
>  
>  static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
> index 16abf89dbbf..fc3e3855d41 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -114,7 +114,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	u8 mbf = 0;
> -	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
> +	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
>  
>  	switch (status & STATUS_ECC_MASK) {
>  	case STATUS_ECC_NO_BITFLIPS:
> @@ -131,12 +131,12 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
>  		 * data around if it's not necessary.
>  		 */
>  		if (spi_mem_exec_op(spinand->slave, &op))
> -			return nand->eccreq.strength;
> +			return nanddev_get_ecc_conf(nand)->strength;
>  
> -		mbf >>= 4;
> +		mbf = *(spinand->scratchbuf) >> 4;
>  
> -		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
> -			return nand->eccreq.strength;
> +		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
> +			return nanddev_get_ecc_conf(nand)->strength;
>  
>  		return mbf;
>  
> @@ -176,6 +176,51 @@ static const struct spinand_info winbond_spinand_table[] = {
>  					      &update_cache_variants),
>  		     0,
>  		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
> +	SPINAND_INFO("W25N01JW",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbc, 0x21),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
> +	SPINAND_INFO("W25N02JWZEIF",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 2, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
> +	SPINAND_INFO("W25N512GW",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x20),
> +		     NAND_MEMORG(1, 2048, 64, 64, 512, 10, 1, 1, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
> +	SPINAND_INFO("W25N02KWZEIR",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x22),
> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
> +	SPINAND_INFO("W25N01GWZEIG",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x21),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
>  	SPINAND_INFO("W25N04KV",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
>  		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 0afdaed5715..910ef56ed0c 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -370,6 +370,29 @@ nanddev_get_memorg(struct nand_device *nand)
>  	return &nand->memorg;
>  }
>  
> +/**
> + * nanddev_get_ecc_conf() - Extract the ECC configuration from a NAND device
> + * @nand: NAND device
> + */
> +static inline const struct nand_ecc_req *
> +nanddev_get_ecc_conf(struct nand_device *nand)
> +{
> +	return &nand->eccreq;
> +}
> +
> +/**
> + * nanddev_set_ecc_requirements() - Assign the ECC requirements of a NAND
> + *                                  device
> + * @nand: NAND device
> + * @reqs: Requirements
> + */
> +static inline void
> +nanddev_set_ecc_requirements(struct nand_device *nand,
> +			     const struct nand_ecc_req *reqs)
> +{
> +	nand->eccreq = *reqs;
> +}
> +
>  int nanddev_init(struct nand_device *nand, const struct nand_ops *ops,
>  		 struct module *owner);
>  void nanddev_cleanup(struct nand_device *nand);
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index ba6c2ba149d..011861dd059 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -266,13 +266,16 @@ struct spinand_manufacturer {
>  };
>  
>  /* SPI NAND manufacturers */
> +extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
> +extern const struct spinand_manufacturer ato_spinand_manufacturer;
> +extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
> +extern const struct spinand_manufacturer foresee_spinand_manufacturer;
>  extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;
>  extern const struct spinand_manufacturer paragon_spinand_manufacturer;
>  extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
>  extern const struct spinand_manufacturer winbond_spinand_manufacturer;
> -extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
>  extern const struct spinand_manufacturer xtx_spinand_manufacturer;
>  
>  /**
> @@ -388,6 +391,8 @@ struct spinand_info {
>  struct spinand_dirmap {
>  	struct spi_mem_dirmap_desc *wdesc;
>  	struct spi_mem_dirmap_desc *rdesc;
> +	struct spi_mem_dirmap_desc *wdesc_ecc;
> +	struct spi_mem_dirmap_desc *rdesc_ecc;
>  };
>  
>  /**
> @@ -415,6 +420,8 @@ struct spinand_dirmap {
>   *		the stack
>   * @manufacturer: SPI NAND manufacturer information
>   * @priv: manufacturer private data
> + * @last_wait_status: status of the last wait operation that will be used in case
> + *		      ->get_status() is not populated by the spinand device.
>   */
>  struct spinand_device {
>  	struct nand_device base;
> @@ -447,6 +454,7 @@ struct spinand_device {
>  	u8 *scratchbuf;
>  	const struct spinand_manufacturer *manufacturer;
>  	void *priv;
> +	u8 last_wait_status;
>  };
>  
>  /**

