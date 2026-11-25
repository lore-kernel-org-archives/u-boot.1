Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3C9606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0U/9rZvb;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=bYSRcgoh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F7B7607D2;
	Wed, 25 Nov 2026 14:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vsrhmmQ_dii7; Wed, 25 Nov 2026 14:02:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4BECE6076D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795615366;
	b=V2rqiMqsx+u2e035wZ4IrthabgMBf5VLDZZ6SW+tZmeYA3aHcxbcmxVxPVwuckF8+srP
	 I54jjmcMJQm1ghO8hWevXl9aKLA7Ee0Or07e8dsF1+dZ6Kap19lTsVfHM94RtL3S03WHJ
	 k+FcPD4OvjQ6cF4Dy2ZdyeEgDorT6GO7l5IGKlnMWngQh5NoCICHHp4Dmg81Ok/B9JIet
	 s8sh2eJtFoV9DhjcKFkT35oBR7ItKb7Rvev+QLhlHn6xfQoZghaGyMZbDVLICeZmRtusn
	 cht0oeCI5TEeYCwXjr+m3RFLeU25yXHGjHDCpAxf3lpN/E+MElUh3ElhMAj/IjvvpzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795615366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=A80JlFe6Lyw4nY0OhbQ/Smmo5n/+e9iK+uFbrFlAI60=;
	b=QuV1HPCoVScm2HVigRXVX5TTiAF7AEncTLbCEuQgNOwFGcYE3JPio8gr6H2wnq3DDrWV
	 HbVLMqw0uVmu0m72y5J+924NT3Dgy9w9gWcpxJH8YtXi92epEYTMnzXgqRyo7ZK2nbQlk
	 Dm50iQRrcP1kTpaWsa534hCHOzaz2RebSAF8s0DjeeZ2NXWSuxYf5+JfvpUM41zod9qQ5
	 +0alz2RWj/tnI+LgwfyFPYkrxYfW3tbuOLU5I8BWsiuWeVBf7OX+Ibr1srFOh+4uwXVxO
	 SOuYB35cl2F4DxY7e5HBzPlhXW85WgoLZvmO0eGFnWFwYsdyNrXtun94bFr2Qc1ubwA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795615366;
	bh=A80JlFe6Lyw4nY0OhbQ/Smmo5n/+e9iK+uFbrFlAI60=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0U/9rZvbgkVGJh9vlLUDYzvRfOLkMPfvYRH36PB3EJwNHgodXfFNVk0VGex413dIk
	 Qu5wD9PK6H3PlmsWgJeVzE8AfLx9ult5e7hZqfwmca2EoVajxLw1tdBG4tsGxSNfE3
	 +Tn/PqUojEIg4+qR63V5W7gmxUlHoLX0miKkoOqZu7XVlnkw6+VoiPXdpOWGKoDGSZ
	 VZscRMrGqM4I2W85hGItMurWcSXsCU/CNYy8Cu0iPRvwLA6pW9HD6ImE4TrtRip5fn
	 kc8OXM76oyD9JIc+KVdGrSOFhrmOnVELfMS+CgPmxcBT0cSelbyekujH/64Dk6PT/l
	 doa3pc3f0LxBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BECE6076D;
	Wed, 25 Nov 2026 14:02:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 860281C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C3B680D3E
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:02:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGg51fYjx5vm for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 14:02:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 58D2580CBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bYSRcgoh
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58D2580CBA
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A80JlFe6Lyw4nY0OhbQ/Smmo5n/+e9iK+uFbrFlAI60=;
 b=bYSRcgohV+iNP19j0uzYSO/QewSlMZzfSeqg5VxpdaNUU6NNmtuvUVXQdybRmLQCFuA3dYTvRW0VZ77p+UrlRhMTn/9vt+SN7R1snHOxdYHr2ERFRAbrlBE/EoviZxeUNpnIlbF7+CiSyQFfJcNjuUKoZXwF4J959ia7pjNyCPQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB12687.eurprd04.prod.outlook.com (2603:10a6:800:346::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 14:02:35 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 14:02:35 +0000
Message-ID: <9f765c10-3e60-4253-8f68-67ed973bde62@cherry.de>
Date: Wed, 25 Nov 2026 15:02:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Dockerfile: Be more polite in two git clones
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261125134317.2479815-3-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261125134317.2479815-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0003.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::7) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB12687:EE_
X-MS-Office365-Filtering-Correlation-Id: 346b4822-943b-4e81-9515-08df4afcc15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|261028144727099003|10067099003|261026135527099003|261102123227099003|261022105027099003|56012099006|261026130827099003|11063799006|261021121427099003|261021123027099003|261009223027099003|261021133027099003|261022115727099003|261021130227099003|261021135927099003|261022075727099003|261026140227099003|261026121527099003|261022113327099003|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: vLAEaECGIB7o5KWOqq6vFvw7DAtsR0xaP5Kf5oQIadB0dbmZf2TTI+kYnPpDA3tLSkXamdcsUoYUX13oQ4ohfHv3T2bZx/07EL5RZGtaA7w1uda1GMVioK9ZtxoTKwjx6DoAU6u0DlWvXF970T8G/gNqAEQmea69QLhPVCWqS7z6PnkOX8L4UC3jFsM2tt/rtvymP9FExuykeLvE4XpLke7H/YAdUqUEvndlYpedRBwmVydrntgdRmmOWIm0nQtWcHdCZPll0TWfSp4VwW0FbDy8Hs5S7AIzcXm3Y8xt0H4BedY/nswciSuCq3Ur4MpWiDXqryp+uhghv2C9qFWxsieCoCnyDgfjPVr+RWRWhNP25gutBzLnclzX4POD6HYvO4wwSlLPXnsFu4xN0FPhaY211ekMDQW+ShQdHp77WF2oBp2OkvtrRph+BkBcr0gQtzcAhZ5WY9lobCtMzZgcF+ZnKJZieP0dOy9LBJ5Xezgd33BhB23TaE4KDnBqlayXYQFRt0Yp6CKfvRUCQMc1u7jArH+a93f6jzsmOKipNXdHr0GlARzu6h4hiHBtfAxJuz7CSdMCDCEeBB1jMPprqJ5WeFpyVu6JTscpGCiDvCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(261028144727099003)(10067099003)(261026135527099003)(261102123227099003)(261022105027099003)(56012099006)(261026130827099003)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261021133027099003)(261022115727099003)(261021130227099003)(261021135927099003)(261022075727099003)(261026140227099003)(261026121527099003)(261022113327099003)(6133799003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmVTNVpUNS82R3BSeVAzWDNUNTRUd3Vmc0dUVGxIWUdzTnlYT04xQmJSV29O?=
 =?utf-8?B?T01yRktDSjg2ejhGdEpSZURIbE5FcmZxbENMRUY1YzVOcVB6S0FENlBsUHM1?=
 =?utf-8?B?NVhkTWU4VkxpMUk1bkNJYUhDZm02aWt0VTU0WUpUNitXL25KRTdTd29QeUhV?=
 =?utf-8?B?SmtGek5JNEk3bnZNMUUwTFJnSHBPTUhMYUtEeEJncHRBODVMeWNRL3hUNzFn?=
 =?utf-8?B?OHVTVmJyaUh3NmlzQU1WL3VadzBnUm8wNC9zN0s5d3VOcnhsbFAzWWFwbkZn?=
 =?utf-8?B?ajU4MU9vUUJmV1dpdFk1WG1aK0FYVUtVamx0VUFvTzcvazdRZ2krU0Y0T1FB?=
 =?utf-8?B?bkRZVS9Yb1hCcGxvemVTOWNGVk9kTjZKaHdhOTMvV0JGZTFMT0p0UUtUaEsr?=
 =?utf-8?B?OUtOdWN3RjBCMkhjNlN4ZTJZcVhQajZObEFPVDcxQmRCTmZBMTJLNGNaL05a?=
 =?utf-8?B?czJ5MHREQytCbUdqUSt1UXF3TmRsd2VnU0pvMUhWWGZQb2ovbkVUYXhIZ0pL?=
 =?utf-8?B?N1RzU0dEYTlPTUo5eDM1bUpFVkZPaXo5c3pSbU5yWkVlRXJ6VnJDWXUyazFv?=
 =?utf-8?B?QXhsRWdaRk5kZ1I4cUJvTWZZSHBqRHNXOG4zQnR1S1Q3b244L2RKZHdlN0Ex?=
 =?utf-8?B?RVA0TUtZWnlMNm9peXc1WlBWc0pGODl1TnFNck9OL1RVOG9GUE9vdVFMOVMv?=
 =?utf-8?B?ZEZTTGlESlhuOGQxOTd1OFN3OXZhN0x5eXBuV05Td0h4WDZDQXhkK05QbXhp?=
 =?utf-8?B?UnVLaUJrbTRTYzJMYVVQdmJWTVhXVFk4OFlwLzR3bGVKeWFCMFNibFkybVdz?=
 =?utf-8?B?UmpvblMvM2JNbUwvTWFRS0tQOGxBc3dnN3d3WTFGdlgvbWJKQVA1Mk40c0pU?=
 =?utf-8?B?SW0vbmRmSDVyeVdZNzVLalp4SjBWMCtsVm1uendnVkxCOENjeWl2MEphaDQv?=
 =?utf-8?B?ZFlqTDFTRW01blZXVlpGMWpvT1FZNEU2RTNWN2xURTNhZVpEbTBYVW4xd0Y4?=
 =?utf-8?B?OUxoZkZCU2pLVm1pU2dvODFybTYzb3Rka2NNRThvTjRKd2R6ejMxaitUelpM?=
 =?utf-8?B?S1BhTVc2THIvbUZvdDM2NkRRejU0TGxLSEVUckJScHZIQlRYQ21iblFhY1px?=
 =?utf-8?B?L2ZzaFhZaEpZZTFqUWFsdWhCN2dFZENwdmRydDRWc2RkeXFNMEt0Tk1IZ0sv?=
 =?utf-8?B?ZG45aXdUZko3a00xV2VQY2NoQTZXU3lqVjJ6clNYdTV3cUVHeXI4djJZZCtj?=
 =?utf-8?B?SHJRdzNqbHFMRFE0bmc5SXAzT2hzUTRGVWVyckhHR3pzaXBFSVB5SFdYblpC?=
 =?utf-8?B?NDlvZlBBSndXRXpCTHdFQXNBTkp4SkhYUXJUZzN3TlZoQ3hyN2ptcExOWXlQ?=
 =?utf-8?B?cUtRVUQxNWZNeXk1S3luZlJtSXNtQWdSMkovd3R2QVlzRWlaTmdOOTkvazRG?=
 =?utf-8?B?a3NCZkxrWUZhdnMrM3lXS3lWb1ZHTGp1d3d2d3FLc3F2MzRTOE5zMVI2T250?=
 =?utf-8?B?aFlaN2xnREJ4dFRia2JVeVJaRnZTaUVBMUN0QmhNL2EvMk92NjZ1UnFYS1Fr?=
 =?utf-8?B?NENnWlpmdi9RR09QYUNGT2V6YVBZQWpOTVJKeVJOMmdYa3A3MmRRT0V0SWZO?=
 =?utf-8?B?SGRJMjBUMlI1ZU84VjhjbDZCYksxMVUwNklHR01KR1cxSDd0OS82eVBaOHBr?=
 =?utf-8?B?WjZSOVVNRk1vTTcwdmo1TTN3OUI5Um1IK2tCa3BGLzNFMHV5c09sNzFiS1hL?=
 =?utf-8?B?ZklVUVljeWRjOEdzVWdUeGhxNkJ4eEJpRWhRc1k0RmRPcXJyb3NMVTBBMHJU?=
 =?utf-8?B?cFpEeXBFcHdKbGtna2hPYThzODIyVzlCek14SVNSOU9CTnh2Y3NWZE0xSUVL?=
 =?utf-8?B?cUVzbkxwcE5CcUR0MzhoV0x5MkhxckQ3aG1jbFJzeTJJU0szR3g4dWhnRE1q?=
 =?utf-8?B?dU1xOWhIWjYyamt5S1hUS1pKVmFKSzZENk0rR1pMNHMweTlCbzRIYndQSkJI?=
 =?utf-8?B?MllHMUY5ZElNMjA4Ly9URHl0L3QyUzFDakxuWGR4OXlZeG1DNmhjeUVHenZ0?=
 =?utf-8?B?d2hqTExTWVJQK1NNN2Q5UVBobStmcHhMbk12N2VEVmI2dzNuUzlOQlU5cjVR?=
 =?utf-8?B?WVlOWTRCMFFoN0k1b00xK2hXTDYrZ0htUTd6eUMxT1laMXRWV0ErNTh6Vmla?=
 =?utf-8?B?cnRTMGFmWXU1bGk5NFJ1WWVCaXlEYmFMdXhkZjY4QVRQYTdlK0kza0pXRWFM?=
 =?utf-8?B?KzFFWmMzME45OU96SjJmaVcvZmdYTzdmSUxpMjU4c1Q1TnBHejdnbW9ONHMy?=
 =?utf-8?B?MUtkbG9ldVQ0dU5PR0h1TWhvK242MXhmVFpLeU52dUx6cGZLYlhmdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 346b4822-943b-4e81-9515-08df4afcc15d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 14:02:35.0116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y20bTC8kkHx+CHHiHntVqJAxMaY0PawQI9JfmKqNOAEF6OejebhYZkdJfij7FhuCicOg4N1Qk4kaMlBgwDqTDxmg34Ff0CqdI3EjOWhx50k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12687
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 11/25/26 2:39 PM, Tom Rini wrote:
> When cloning grub and qemu, stick to grabbing only the tag that we
> intend to build. This both saves time and their bandwidth, which in turn
> makes our build more robust.
> 

suggestion: use tarballs instead?

https://ftp.gnu.org/gnu/grub/grub-2.14.tar.xz (or 
https://mirrors.kernel.org/gnu/grub/grub-2.14.tar.xz) for GNU grub for 
example.

https://download.qemu.org/qemu-10.1.2.tar.xz for QEMU for example.

> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   tools/docker/Dockerfile | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index ab001a4d34df..d5f1f6d697fc 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -155,9 +155,9 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
>   
>   # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit, and LoongArch
>   # 64-bit
> -RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
> +RUN git clone --depth 1 -b grub-2.14 \
> +	https://gitlab.freedesktop.org/gnu-grub/grub.git /tmp/grub && \
>   	cd /tmp/grub && \
> -	git checkout grub-2.14 && \
>   	git config --global user.name "GitLab CI Runner" && \
>   	git config --global user.email trini@konsulko.com && \
>   	GNULIB_URL=https://https.git.savannah.gnu.org/git/gnulib.git ./bootstrap && \
> @@ -241,9 +241,9 @@ RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
>   	grub-core normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd && \
>   	rm -rf /tmp/grub
>   
> -RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
> +RUN git clone --depth 1 -b v10.1.2 \
> +	https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
>   	cd /tmp/qemu && \
> -	git checkout v10.1.2 && \
>   	# config user.name and user.email to make 'git am' happy
>   	git config user.name u-boot && \
>   	git config user.email u-boot@denx.de && \
> @@ -397,4 +397,4 @@ RUN /bin/echo -e "\n[toolchain-alias]\nsh = sh2" >> ~/.buildman
>   RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
>   
>   # Add mkbootimg tool
> -RUN git clone https://android.googlesource.com/platform/system/tools/mkbootimg /home/uboot/mkbootimg
> +RUN git clone --depth 1 https://android.googlesource.com/platform/system/tools/mkbootimg /home/uboot/mkbootimg

question: is mkbootimg even used?

I don't see any actual code running the command, only documentation.

Cheers,
Quentin
