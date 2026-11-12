Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A79606A32D
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SiQ9i0OS;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=NO2JABRl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB7CF8146B;
	Thu, 12 Nov 2026 15:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aV9m0GRKtWLd; Thu, 12 Nov 2026 15:49:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E13FB8123F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794498544;
	b=sDRlrv6UYCZBKQ811VBmMVXqR/H7EzSnKguI9dIpbW3qpgCnX6jCE9CuLPv9ftROMJKe
	 RHfrKRuzk4IsimGR8jj7ZIPUl6+EeohsmcvAO3IHngMj9iP3M2600MeZcCywvLBiMPWJb
	 eKM/U98NHWHO8kxwAlVdzKP9+wS+PFEx3s6mRMtIiLcHH/zsg6aDwhqUTpr1w2h4RK1Lw
	 qrDP7WTSct1vDplBxB3Qy5QtyEic47mBAHtJQ/LvJPxMDK26LYg+4dzFa188llspkR1Jg
	 HesTtLoGW/5PzypMDUwKeja5Qy7Ls2HyTyzBNePKDILuON5uF6M7eEWyzpNI7vAXeWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794498544;
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
	bh=s8ymKNjbpgvj9gB1f3oW0PqDwodxufzz1br1Hy/QS5E=;
	b=TsCrbL1gobdvjqn60beCD2Gccy8A6d++09pU6q88KL/Ow+hWdKgN4SJH69w07daSiCMb
	 4TozJAfNK+rCH/CyVIUe4/a3z6DMmXVLEIxy9MybBEAy5d1GP84F6IygXPLJpyHEP3P4k
	 NeWuvGqTFMIXlVAdjoa6uCfhh2I5DK58ZgASLwuyNOIrD3cnhiKNFprB+Abbbmn+oYo0S
	 IG84ZTZNBdNIBMxNUyMsDVaXsTNxvyFK6AujNVNB+KkBnlfoxZswBjjm1ocsxjNSQdrMQ
	 dJyTB3XRqj3eodJkH01rJRm2DBHyn9f1JVAb9HpQ3yk1P2r2FSOEevH3jtJwW3GXkxg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794498544;
	bh=s8ymKNjbpgvj9gB1f3oW0PqDwodxufzz1br1Hy/QS5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SiQ9i0OSuC5Elf9LGeLSKL3Db9PblhyvuuGc0cxSTKnlRflpf8i4Bo3Zni/Fl0j2b
	 WyN6scda15H0ON4kLCIonjjqIXSEz+3GDK9NCLtelJltU+a6ancYPaw4aUFxW6m20P
	 2DdTQOR7U7WH+cLDjWS5liv2n5wmR9kYnxoVEUZ+KMD9kCh7C2ER4RhI4ewpUv4wiL
	 h4c4M3AMQtuZBXDK3I/RVc5wBsGa+SJXH95O/ONfaC/dEHglU+LR5Dl/GzeDFwkyAN
	 aBU0isLgBzvz8zs3D2d3776LyUjVYaVBjgYWEyrcg2yrohU8H6XxQImEO+3EJ0rFeT
	 x8GBjNR3R63dQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E13FB8123F;
	Thu, 12 Nov 2026 15:49:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CC86156
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 15:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DEE040B39
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 15:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hn9v9ee8RX6s for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 15:49:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0ED4F40B22
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=NO2JABRl
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0ED4F40B22
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 15:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8ymKNjbpgvj9gB1f3oW0PqDwodxufzz1br1Hy/QS5E=;
 b=NO2JABRlgthfcNZ7506y4JWrfMNHiHJt2Ggw+uVIfJ6BWcm231P5Xvt8ByWCTfrxClHGOYz6XIBTbSl+kPmtQHoBHPsSHKS9KeNVxAMh5MZu3R2eAgun2LnQcWTjcCWJtyFQW+VccnnD0Ns/aIYTWjVNjNW3x5rbG2blk9vcxSI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM0PR04MB12143.eurprd04.prod.outlook.com (2603:10a6:20b:744::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 15:48:56 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 15:48:56 +0000
Message-ID: <44f4ca43-34c1-422a-838c-9d2b9a042da9@cherry.de>
Date: Thu, 12 Nov 2026 16:48:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: develop/sending_patches: add tips for series
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, E Shattow <e@freeshell.de>
References: <20261104-doc-sending-patches-v2-1-c0a90ff6c049@linaro.org>
 <76240a0d-96ed-4a8b-9336-8cc96c6e6e4f@cherry.de>
 <auyTzNmT63e_mEWO@maple.netwinder.org>
 <fc54cf9e-e56f-427b-b390-fbb2c9ea5c1c@cherry.de>
 <au4fPht4wT72RFUD@maple.netwinder.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <au4fPht4wT72RFUD@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0118.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM0PR04MB12143:EE_
X-MS-Office365-Filtering-Correlation-Id: bd090930-c81a-4589-bded-08df40d475a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|4143699003|5023799004|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261022075727099003|261026140227099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 76lNNQvmZIcYNqoP5piOvHVEKZb/0m67HO0tj4pv6mSFlchdHSXVKsLa/fiF4Bccx1PAaSJLzpeXXWlLHbW7g2WP/pQLw6TqKNkTFYeaR4pbfpH2O34GTlnKJ1CupHXqeji110NYsjuhYKgPOa3sTTPgKUKqWBlax1OKPmIeK8bDwWK8a6JWWe9Gzcx71UERDBDMKRfJAqsfmU1E5HCS/EeFUfIIARn6Zzn7oSDgSRZ7EMszeo9MJKyZrGfgya5AZBseG+IOEgRMP1F/D+Z//rPu7cPRrstyx4dsacmVB4WC1Rp927Ip6T+ydCU6kb6bJwfCAy51QXSz5RHBqkDrVkKf6H7bJ+JXsS9NqRaJWs2pyBrLmBvTbZBlmcOJX00yE9T5GbseqBgDgG3lP0JNYvbfmRg95bxl9cInu/1KPdigkufeP5s+xcmIRSeHiPqapuQ1lhyDA/LA7W8ZaI2UToBd9/WwxDSiawqPb/rIt7Jmgm4VmANHC2T34jrk5HpBlMPQLMdqIR64Slhiw1d4LThGJ90c+gFr/mf8kJZ8Pj2hzaZ8fle49bh5yobPJ7SaEb2x04vUU0sB4GEfJhnJp5Fj3JcX9h9n/i/g3JmMk5WPk/J96Zdojdy0GoLqx3/32SMpn6bx7DP/R+tKeEJMm+XDTTwTBOag4qcdDCSDxJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261026140227099003)(261022105027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUR1V05YcTE4MEV6Y1NNUUxYank1TTlGZkE1ZXlJekhKU21laGc0UGZIU1dk?=
 =?utf-8?B?eUY4K3FSRGhwbzNla1puZ241WkxkOVkrV25tQkZIZW0vYjVLcC8zSUZlUkI2?=
 =?utf-8?B?bnlCQXlVUGdIeGJ6NWtXT0lDM1o1YitrV0RCRys5VWUwOUkySGo4OHpEck4y?=
 =?utf-8?B?ek5mMUZuK1Mva0tkdmJVWjJ4Z2NJSjNtMDlqaDMySFkwSHZoYlZnMVF1Vy9Q?=
 =?utf-8?B?Y3R2aCs3OGsyVU9lYXlDVXpGMklZdHBUOU1YS21TMFdiVy92N0k5TFFxU3Qr?=
 =?utf-8?B?M01oYytZeGk0MDNPbUtOcG1iOWNoTGtsWXVrTHIwQUlwb1J2SEFadUZ3YUZQ?=
 =?utf-8?B?and5SkJxUXFTNEFSajE0anh2RndKTy9YcmFMQWFhejJNZkladmk1WXZaMll3?=
 =?utf-8?B?aTVqSWZKdnBmTnRPMTU3VEgrMktMVVhyb3JXcVFkR2l3L2FvZXZENTNZSEND?=
 =?utf-8?B?Z3QzcFJBUzBuaGwwWEZEWkRVTS95VGlFQlVTYzlIOER5UkJOL00rWlpMSU40?=
 =?utf-8?B?K2xSbTVMNTRuMkJKdTBsQS9kSnRpek93ZlB6b3YwTnUwVjJRclNuVTBRa0FI?=
 =?utf-8?B?dUJkMmdISE44T2R5VFlBMGxhS2NZV0ZQdDJNV0ZNbE13Y0VkRVY1eklIM3VM?=
 =?utf-8?B?SDZ5dHdIc1VpeXErclU0SUY5OUZ6c2loZFRkRmJRcUp2YTJmTHE0TlNQaXdB?=
 =?utf-8?B?N0xvS1U2ZEZpYUJ1dTl3WjJHeG0yeG5EdGNoWVkycUp6UEFrQ3o5VE9CZEg4?=
 =?utf-8?B?MzkwRlVIS0pTdUJQcER2ZkphOXN6RmltdXJyeVVxK2wrRE15Zjd3M1VrbGRZ?=
 =?utf-8?B?WTJ4UlFEY2p6S0FIV0hvQzJwbWNKYjR1Y0E0YkNldllOYW11S1AwZnJYUHdW?=
 =?utf-8?B?Zi9OMTBjSlA0cVllVGZNKzhXT21KbWtvak81emhjWGhSUE1wRVhwM2VvSDZL?=
 =?utf-8?B?a0ZwWkFFTzcvV1dhTmdDRkxJcWpoVVVYUi93STNiWG43WDBEclB1QS94bGlO?=
 =?utf-8?B?RHBJcExqbEcvUGFJMTZHNFpUaWtoZTRDSWJDYzMzSXdLL1RpZm1QKzNlai9r?=
 =?utf-8?B?ejBaSXpMRjFoV2dHUTBNMEdCbnNwME1iZUhoVmtTWFp4WXFYQnhtNi9VS3M1?=
 =?utf-8?B?Q292QWJvUHZhUWFIOHpnTjkvZ0tjL1pZVjBwK0J1anBPdlQ3OG45Sy92NWVM?=
 =?utf-8?B?bThwSFczeWx3QUtvRC9GeTdmQ1haeENHVjZuWkxOS1VMY1NuTmdPVWtraldr?=
 =?utf-8?B?cHVKZ2tYU0pzQ2h6Y2VickdNREtTeEowNUFkM2o0R1pPZE9HcS9YbVYyUTJq?=
 =?utf-8?B?VWdVWHFmOERtWjlRM1BuUGF0VS9sR1VuN0pEbzMrUENYeGtLWmxRdTlZLzZL?=
 =?utf-8?B?ZVJSSE1mV2p1OWQvZE1lcERSd1BrTkRjK0Z2aEpwUlJvSVdMYzl6dE5IYVZ1?=
 =?utf-8?B?UDBjVEdvblRjU2dVQ2l4OURDcmx3S0prSkliR240ajNkMnQwTVphNWtkZUpn?=
 =?utf-8?B?UVBDcWJmbFhSUWUzTEtKK0QzTHN1VzExZzV0dUg3TlJLN1hTUTlCZnFhUWVS?=
 =?utf-8?B?eHlBUHRaNEdxYlBjc0hkTFY1WDd1U3hIRnJ3M2hXc0lPSG1PK0RRWERxMG4r?=
 =?utf-8?B?L3pKaEFNajQxY3RpUUQvWFVzdG1McW1HMjhTZWtvVnZhR3Y1YUJIbDhmUXFs?=
 =?utf-8?B?Y2lhK3QvTmxtUDdhS2RCOXZiT1d4R1dpMDJadDVZNHhrMGlYa3BRUkIvZjBp?=
 =?utf-8?B?L1RsdHYrb2RDbFdwSkhwRWQ3NnllSDBHU25rRWw5ZTNmeDErc0NqMzRsL3hB?=
 =?utf-8?B?NW9jRmF2OWpTYTJBSEpqb3d6YWhCcFdUYkgrNjlXRlEzbUlHcXFSYVJVZ1hP?=
 =?utf-8?B?ZGpWU2RPWEVNSys3NHMyU2ZNbExvTUhMMmtXZC9hNk5BNzNzK2VwTUJ3UkQ0?=
 =?utf-8?B?RmRNNW9ocUx6dUgyVFZJenNyTlpoelpUc2t0bEZCR1RZTnB0eWVFNGo4ZVp4?=
 =?utf-8?B?ZlErYTRYS3RiUVBOVDRqUGdpYTlpdjJOVFdVNHdYOENOc2VrbEVoYXNUcFhU?=
 =?utf-8?B?cllIRTk1TUs0MVQyTlhVWDNwa21ZSWtUUmx0TlJKMEtRMnh3TVAwcGwzMVA5?=
 =?utf-8?B?VmVmNkVpTUNiNVREak1jRTQ3dWg2N1FGYmIrb2NUa08yTmNZckFvMU80QzlP?=
 =?utf-8?B?MU5mYmorZXFmajJMRWM0K3M2VXdabk43M1J5N0ptVkR1ZGxFNUxyOXZmNWFH?=
 =?utf-8?B?Uytsb3JQNkdiQStUcWhKeE00WTd3NnpCQnFWamRZWkZkUkdKMTc1VWFrTFVK?=
 =?utf-8?B?TlNZM3kxa2YzSnJJUjdkbTVOYWY5cWdRVTFSVTdxODJXVi9xOEE2UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bd090930-c81a-4589-bded-08df40d475a4
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:48:56.2944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbds5iOGKtKqQLob0q/Wh3AEz9ViX03Es81KqN4KkLgIFE8EHGLHcHYvLi37NAeDfI7HeozwtTD2de/3Jtrn5OaLsCBaMhA1kWLYImScnmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12143
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ralph,

On 11/6/26 7:41 PM, Ralph Siemsen wrote:
> On Thu, Nov 05, 2026 at 04:46:17PM +0100, Quentin Schulz wrote:
>> Hi Ralph,
>>
>> On 11/5/26 3:33 PM, Ralph Siemsen wrote:
>>> I also agree that it is hard to detect the actual dependencies. And 
>>> in fact they are not static: when a reviewer of one series requests 
>>> changes, it can often impact other series. Which suggests that there 
>>> is a dependency, even if it was not apparent initially.
>>>
>>
>> At some point, there's also "don't send too many series at once". If 
>> your series A requires big changes in series B, it either means it 
>> should be series A+B, or that series B was sent too early and we 
>> should focus on answering design questions in series A before having a 
>> look at series B. Sometimes patience pays off in the long run.
> 
> When adding a new SoC, we end up with series A+B and often many more. 
> All of that code needs to be written in order to get the device to boot, 
> so it is generally not possible to "upstream" any of it until it's all 
> functional. (I don't like to send out untested code!)
> 
> The problem then becomes, which series to send first. Inevitably, in at 
> least one of the series, a reviewer will suggest another approach, 
> perhaps to extend some existing subsystem, or simply to do certain 
> things a different way.
> 
> Unfortunately such suggestions frequently result in changes to the other 
> series. These changes are hard to anticipate or plan for. Sometimes I 
> try to send an early preview "RFC" to help identify such issues. But 
> even then, during the actual merge, further changes are requested, once 
> again with ripple effects on other series.
> 
> Sending out the series in a different order would not avoid this problem 
> in general. Specifically because it is hard to know which parts will 
> generate friction with reviewers. My guesses have been wrong more often 
> than not in this regard.
> 

Send what's the minimum to reach U-Boot proper and interact with the 
console. I would go as far as saying it's fine if you cannot do anything 
with it like loading and booting Linux next until other series are sent 
and merged. Baby steps. On select platforms (like Rockchip recently), 
you don't even need support for a storage medium to load U-Boot proper 
as you could load the whole thing over USB via the BootROM. This also 
gives the opportunity of other people in the community to work on other 
parts of the SoC bring-up in parallel.

> Not sure there is anything we can really do about it, but I can totally 
> understand why someone would send large "add new SoC xyz" patch series.

I understand as well, but the bigger it is with the more susbsytems 
involved, the less likely people are going to spend time on it or look 
at it. For some reason I'm in Cc of many many patches for the last year 
or so, and I don't care about probably 90% of it, if the title of the 
cover letter doesn't ring a bell, it goes straight to my archive, I 
don't even uncollapse the thread to look at individual patches in the 
series.
I don't have an answer on what is the best compromise, and I think we 
both agree on no definitive answer is possible, so on my side I have 
nothing more to add to this topic here.

Cheers,
Quentin
