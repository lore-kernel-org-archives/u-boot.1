Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C804606A883
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nyS+G0o0;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=UhVbvUYI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D7A560D6E;
	Fri, 13 Nov 2026 17:53:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RQaocvwYdVDc; Fri, 13 Nov 2026 17:53:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A42C60DA3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794592396;
	b=Ujdpz3jVFebZuKmo4N7bS8lP4sT8/Y5pFvGF+bUFHxddjGXM8IwGobWs069LqwonDNpK
	 qLY+MxZwmlxJxPZvCT3WQRpEz0rC9FESP5CPgzFnS8TQ+2FMcTUVd/iqGnBLFcytp1lus
	 fDdi8Elb0UHKTDhLAreJtGELd7EDY0BCXgqvSD6mur3/pyQyEQcvBF/VN/0MDBPomlM7R
	 2cwfs6Akc/+i7BohTbb3UA+FK0wa26xiKwFv5LXzU8ROmA5Zme6Os+5WfL3p5tIhkoOJf
	 q4HswXePBJ3T5Oq/EcSMazuOcrouN6GfNfy02iscNoFQKgGvFnSst0lQ/cZdXyCTugA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794592396;
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
	bh=iZh0KDnJzjioEVB8HNEwyaF/oebdtG7aluj2lU/xHJc=;
	b=p2lZMdqeV9Ir1LCS4RWXmVmNSeSmSY6SpviWXIS5sNmiB2Tugx+g1DrjZ8YubCkdQYDK
	 N3n6XKvan/y/uez/M4UlB/nEhisytOfrCyjxpno3uwBFsxTzh3cI2equntYQJ1PPWhvsC
	 hqRcyHHY3EB2YwgaElhnFNDJZIHbdwio5g7NhvheiZ4xgdXaowlzv9JLUyO2fqzU51+uV
	 MQVd1JZ31QP8ZIFPkH7QNg2YbVSeJqP+xlxqhVE0yCEeRWMBkzEsuF7oCuhMoZZE42FLB
	 mOY/9N/1bn+UZpSxWzIJ5mwxxjv4+GTwk/U1uUYxBM+PO8UTx3TYF/Pmc8huPdoTrzQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794592396;
	bh=iZh0KDnJzjioEVB8HNEwyaF/oebdtG7aluj2lU/xHJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nyS+G0o0UNLFwZAj72t+qHgrS52GAl1A6wAU8peSC/FHXKbMPDo84tefWWlO68FlN
	 PZyFtq7Jgvxh3Xm3GjrQeFCIAOIaK7gdt1LSD/JgW59K9ouMn4GxD9z1uDpkV/qwle
	 0p82QkJo7M7RzCrghZqOkz6sjx+DqeTMcIJcBDMzX60LTsRR1q8wXaTDM/LJie0mNM
	 MnopFMTPPZ1KOy/ckdKvc3MrHacXspFBV0O4DcdGUUAuKTgct2XqLrZNgFm9L9+iEp
	 5SHjE24/rg01Z2mznO52n49zoDANll1N5Y2tGCPGIYaeCerj8vmaTJXYMYljem6pTL
	 3Zop/zzOv8dEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A42C60DA3;
	Fri, 13 Nov 2026 17:53:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C37C2E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C7EF40E0A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:53:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h7IKIgAMyamj for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:53:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6752840DDE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=UhVbvUYI
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6752840DDE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZh0KDnJzjioEVB8HNEwyaF/oebdtG7aluj2lU/xHJc=;
 b=UhVbvUYI2cEmTt63Pk/SEqAyeMJDH63FdlFH+wLrhLOGsTBJgiy9hZZYjscIHlEk7ByE2A5Tf/p6SVJ3AxUlfyoew6JOy4O4lxoExdsWtA9l5OBXCTaHRR6nweY9WwxRz/IyRs+ibBHP4CLqeP+tmiBcis4kbEzoA+gWOtq9Qhw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB9878.eurprd04.prod.outlook.com (2603:10a6:150:116::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:53:10 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:53:10 +0000
Message-ID: <553a504f-e9b2-4697-86c5-d528c8b27d50@cherry.de>
Date: Fri, 13 Nov 2026 18:53:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/37] clk: rockchip: rk3576: Fix ACLK_TOP_MID parent
 selection
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-21-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-21-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::35) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB9878:EE_
X-MS-Office365-Filtering-Correlation-Id: 552d91d9-49e1-4aa0-6475-08df41aefa88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nOFZ6K1yBQa+7Wuff9mtoCYYmwIbd5FE6kapFnb/ENZHpmYO5IvDbJZSRDKsdi+CYb2y2VFRAdOOV1jpVS7I/0ROuTsvFvCM88SjtYectfs+bCdF7Gym6SRIq8fCOlVM26N2eSkzx9QgTGi9WuTfHeHlUPo8q6hBhbt6HkYYL62kmwLY1PTN0ZbN85FVJGF7taZOwuKc05dvH2GdHZv2GFiwAPveVbYaGRNp8jPQH7tPRX/EbGVq9Ta9ZzXyuupHQ+57uSDTvZd6NOG3gTZdfzG4hrwwkgOTtFXkYaSkpja435cVfu5Mf0vBRMJCgJCxtLM9XpHY12Z2BpLhfMOBIKYfXWWWcNAgipXA35o0xwzpNXS+bdmPfStuZKVYZ/aC44TT9vh1mkjD0q1xOZqIkAmiyg/cn3WMe/AcgIxtje9Kx1fT2ieCnDwvy1VqkUbmq0+arHm+HPQvQrCRYmfrxZF8JvCfQv6Kqoy5sJKUm83B4DYxYQh3DWAQsmTc0h+ZOwaHHub08SwjXqIzrOwE8RjH0dOLzBcJFUAPZURSbP8lJixYg6toWPfRpPp7I2F3jiyp9cwAywPgXVUxPujH8IAYxZY9XPjdC2irDEyutZ24/R+SkxiE9SDOS0Qq4SEHwiMWAwDKspJJJYbauzAtkM1XD9C7ScV0jiQ7MzWbZvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxPM2xtUEUybU9DOEs3WFdDYnJjYWhZbGZNbWV5Y0dYZjhkRUNLNmxUMFdC?=
 =?utf-8?B?b0xrcm01UGJKL2ZhYmVVL096dkxIdkNwU0xtaHBSYUoyYTA2UHIwc2ZEMnJF?=
 =?utf-8?B?eDJ0UkYrcVVlZERpdGVqL1VDOXVBRVBHd3JQSHlzakFzUVFHQ0dNUE1XMm4z?=
 =?utf-8?B?Zy9OZ1pyN2t1YUZoMkJMbHdrVVpyamRBU1ZabHIwZHN4b21ZSXNIbVJmSjUy?=
 =?utf-8?B?QXc3M3JoWkRjSVV6MjZWRTU2UEV0blFDcldXdE9XRTZTWHZvZjhFdmFVTmpr?=
 =?utf-8?B?ME44ZjE5QVJ5YVBaSkl0MlJVeGNNdFJnMW91c0U5QTNVcjhGQ1JXSHpyVkcv?=
 =?utf-8?B?SUZURHVRNnpQZ2tGdnhLbDVndDRqbU1KL0Fydjg1bWZkMXZEV0Nld0xVbEFx?=
 =?utf-8?B?YUhnaGduclcwTENsbTRsOXBVUkd1bUswaDZ0bWtCRjdJVFdrNDI4anBZRXIv?=
 =?utf-8?B?dHErRm8zclFBTUxCZldvZHhNM1dJbXNOaVZRYS8vUUFBOE9halJENmg5NU5T?=
 =?utf-8?B?WGVGcE1hZHh6R2JEQmJmVTVOeHFNcElGNTdOMm05WU9BcFUvVHFHbWluQ3Fu?=
 =?utf-8?B?OTc2dFZsdFR6VXJ0bzBlRkczMU9YTWV2bE0xS1ZienRnNjlsbitvWG1qNFgw?=
 =?utf-8?B?b2x4NDlreEFuQm5JNHBNN245SWtRNkg3dDRRUjUwbHJEWG44N0VNTVp1OG54?=
 =?utf-8?B?emR4OGJFK3lnZEI5blFsVnhsWlVsV3FNY1JBb3VPTzZmblpCR2wrbkxIN2t1?=
 =?utf-8?B?ZkdlQ2l6WnE0aW9ZNXh3TjdncHQwNTNvT0dSVFRaUkxIQXFuaXJDb2p0b1NG?=
 =?utf-8?B?NHFPK0tZSDlzVG0vTGZ4MlJNc3FTZTNIMGhEbzRMcGJWNXY2WFM2TEh2NkI3?=
 =?utf-8?B?MVJTYVp2NnRVbkR1MC9rRnJYZHYrU2FJNml6M1dqbGlDc0gyMllBbmk5a2Jh?=
 =?utf-8?B?a2VCL0c1VzZCaEpkcnppM3p2dW02aUJvWHdzdHBYeEhyZ3hySnNUcElqV0Y0?=
 =?utf-8?B?eWVrc3A5dFJFYzlmSE50WDlCazJnZWQ5d2REREJEck5pV1lZOXNVZHBoQktM?=
 =?utf-8?B?S1JxNmFiRXJuTE04VGlNdTh6Ym9XTDVQSXVOSmRTWVNaa1JXY0dPTFBweTVp?=
 =?utf-8?B?Q3dGN3RmUXIvS2tWYkxVWWwycU1TMktLUDlOS3l1V2RRYnpzT0JXVUFUTnpG?=
 =?utf-8?B?Z3lKdHJOVVRFOE1Fb2xSSFRxSWdsZUlnYW9QWGhlNWE4MXpkVzRKTGZWNzh0?=
 =?utf-8?B?c0ZmcVRWc1l4U29IejUwNFRPK0RPdVQzZkVueGxMdGxZTUZqejI4N3p2cjBu?=
 =?utf-8?B?TjM2NXd3ZWU4MGhqbjJLSEw2TzhSWHNsdURNUUl4M1hKYklxQkxrclkvcEhq?=
 =?utf-8?B?L1pYV1IxNi9HTFZXUzRDbFpTTmNoY1l3Rnh6SVNQbVJ1Ni91TFgyR1Arb2xJ?=
 =?utf-8?B?VTQrd2xNOFdsRUZDZVF4TnBqTU5mN0hrSGRvZ3A1enhtaHNnZWhFV1FzcnNG?=
 =?utf-8?B?d0gvaHRWQVZ4RVc5aUprVEs2Nm1ueDIzZjN2SVBkVkFVYmlsVUVHeE4wUSt4?=
 =?utf-8?B?Nlpoc0VCN21HWTdPSGJnanlqanhTS2xiaW15WGMvU1RMSlBwZHVXenZMRE9L?=
 =?utf-8?B?UnN6QW4xWFpkRDhpaXpKbml0c3JWNWQvM3dYSXV1SmhlTnNpMXI4bVh6Mm9E?=
 =?utf-8?B?MUFKVWQ5MjJWcG8rbnJpcHg4TUlhdERKeTZJaStpUHE5eEZldjFxcjVMdjZL?=
 =?utf-8?B?MjVFSWoxMUlZclFpMmhycVBHQnQ0c1hTZE1XMG9OV1dVcFJRNFpEaTBncThw?=
 =?utf-8?B?ZDNEZ00rOVl3MWlxdEV1ZnI3K0ZsaS80K2FXYVREVENwNVFxOFhjV085T29t?=
 =?utf-8?B?bjBiVmY1NkVRZU9xOXhORnVxVWtaV2FNQ25PRFVpYVBpaXJma3B2ellTMmxl?=
 =?utf-8?B?UGp4bEs4aEZBTDI3VnFJYklUd2wyS09mNVhja2FTMUhrbExMQUZjY0xnZ3hC?=
 =?utf-8?B?bHlMejJHdDVOQUFCMmtZNGNwOGZIY2VUR3RjRjlFcHpHTGI4cllwMm9pdXFj?=
 =?utf-8?B?cFlDOXVoUlFONFBVZFY0clUxbG41bnI5K2Nzdkc1bWhmRHE1NXZlTjZDSVQ5?=
 =?utf-8?B?dDNxMitBUURLSjVwR29EY2VMcmt6TDRsemNwdUtOb1RYVTVDYWFNV21DdHpv?=
 =?utf-8?B?UVdNTjlueGNEd3A3SU9wcDhXV0gxcjliYnJCQ3R0RDZUNEY3SDcyeGZreHJo?=
 =?utf-8?B?VU14ZUpVWDdGMTFQMHhkNFE4NFN5V3VDblA0bnArbnpNRVFXT1N0bmZ6R3VR?=
 =?utf-8?B?djQ2NDd5ZURaWjFIZnJrZTFYbyt4anZsWnlRTGlGOGd2bUhsR1ZuUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 552d91d9-49e1-4aa0-6475-08df41aefa88
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:53:09.9043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6MWvDqhAR9bmxN0XWB7HAJmXVq48kxDzGKDVTJ5trlJTSye2ZdXYeoUSlSKR04BjG4r/Ywwd2B//ucJvcZ9xcpr9uCvevNlqGKnKe1bQaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9878
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/12/26 12:28 AM, Jonas Karlman wrote:
> Write the intended parent clock for the calculated divisor instead of
> forcing it to GPLL when ACLK_TOP_MID rate is changed.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
