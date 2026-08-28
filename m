Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42093C61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 19:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97FD180DFD;
	Fri, 28 Aug 2026 19:32:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gINeuOi1HMkC; Fri, 28 Aug 2026 19:32:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787945540;
	bh=hFXsrCcQut3qTS2GskGS1KHjl45lvUXA+rYUbvXbZhs=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RYsYqCuUELLOeSJ9XkuS+47D8QmGL1vWwiRH/wt/BKEftJM0BvyrWIy1p3EON9ArI
	 7EXu3KDenuVo0ZvmaqTzKJ81wTmA9iBJYHAUwWPKcFMl03FX5kvdXrajAtlLhe39kU
	 wVpghSE4i5kbv88i/Gd9eOeN50mZCeefxEHYP+OZGAIIjWkFT7QqP567jCylloPyif
	 fx2Le8enmj4iN8VZt8AuoMRWS6IUXEfN1wV5WpPkxjdKfcjU/YERnyY+MjBEBSAVdt
	 oWwzWcNVIhlai5Nb+zMrN43W7EdsXRRjSKN8Yf5q1lWU8FHOmxyqk+aDflc/GRrKel
	 qB/IKdSCgkFMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6422380E0F;
	Fri, 28 Aug 2026 19:32:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ADE10334
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 19:32:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9397980DFD
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 19:32:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TMiSCnWvmITm for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 19:32:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Gc2pA/9l
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F09B80E0F
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 19:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x73ER9LS4xqGDS70IGxcOndTT4Qo2i+i2llL715bgWDInhSI7Efu+F4TQHaMxbvM+ulIBoaz2RXfdwv5wbBdMeeZ5x4Mi/4wcMiA3CPmkNY7TWfzQISmknVFp+CdzDAFvqFa0YCp2P2+yIp9Zdxf6Jf9iWUJkmSB1PB3tIiD3kJbg9Mjy6wpGnB3G+/bCPSC5dEut2Fxy1eZIp1zR5B0wS0N/gXFQRWVWl0PhJ164k1zAKH1wgvsvws6I7do+sfuBK1kNJPfiBDmlNAlfw6sG7u40FQsLH61kZ8sqtXqIRJKmRclY8PBQzwE1kTrjBsVWDkqlnRHYt9oLygm9Wcm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFXsrCcQut3qTS2GskGS1KHjl45lvUXA+rYUbvXbZhs=;
 b=ttfUGpluHjIu+ZUS9Jqu5PeQuqB0BZ7DxD5BNyCqJ/txhzKAIgLNV9px4eWQIG0qNyhccyq6/aukex+WPEzMzoG67U1PMgUNGyeFf8so0tLS6QQARQxcQXSMOzKbtkgjp8UwqxPxlhmjDQ6Fg/aYOl1F+PuPgnTgVsD5ff+xDl0gR2WBuBlb4m9b5q9JVcy+qmskGO3O3MPW8DpnYKy6PLnQB5RcFv2WvaffrpXr1vwzvziJ+jVp3o209Vi3q9IGHp1LQB+y6Gb+Nia7fArFWXMTF6aG/V8JCCBjH+oriG1kPpCluVK/Jjk6zLSoVpbvkLxTH2/t8IVrOobM6IXswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFXsrCcQut3qTS2GskGS1KHjl45lvUXA+rYUbvXbZhs=;
 b=Gc2pA/9lBucVOjWjwx/M+YTM+wNlpEIDADGBmzmjEkVsSpBO/aKih6kywuzigMcbXO0/DRI2pyJXsRf+UC4kgojVLyP1T8Fm9CPr6dgkhft4hXoRm9XgOrLwLf4r6YKAEJ7OjLOMYKkH0RWmHj/IKbSlH4m/SBemTkuZBNSQoKP2/ncLieWNb7c1je9sQlIPKf4/gVZYWLdOxBhRi5VtOuoMKjc7MBGigTX8EyJLx3WvO2QODzZel5QARVAUEgACKZ/Cp4kTxs7p08zKCZNwWKiq9cFjLEY1D/R6f/FGkinRbuOOWTnNQ7GXlB0s0fuQSb4q15s1HBnt4mUlc9RWqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA3PR03MB7234.namprd03.prod.outlook.com (2603:10b6:806:2f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 19:32:07 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 19:32:04 +0000
Message-ID: <13b02211-1fba-490b-a2ec-c111da429c6c@altera.com>
Date: Sat, 29 Aug 2026 01:01:54 +0530
User-Agent: Mozilla Thunderbird
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH v1 2/3] mmc: msm_sdhci: add HS200/HS400 support
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 nathbappai@gmail.com, quentin.schulz@cherry.de,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com>
 <20260827073325.4113071-3-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260827073325.4113071-3-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA3PR03MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 42129a22-c488-417a-a484-08df053b0a08
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|6133799003|3023799007|22082099003|55112099003|18002099003|5023799004|4143699003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: V+Q2BIe3gPA9PGePrU1kRGbhVWtN6sffvM6DSUCIwH1C2TfNi8BFnyPeSoB9vz4x3MHZ5Dcdjbvne4g9tucfsSsd6qYMT63Ri7p4CD1GMAW6GZcAJFPgVwG6qUaRaSYtystnKi/sSfM5ozq8putTHqTvfLt787RzIgIX1BMDppvBV1zFRSJ4ReCsDv2YBnUeVYUG73DTxvDB/1cqF8m0HXO2CtqhohYAF4YbS8lLMzB6F7JbWbSy+51OLA3TDQeOj6iGi2CuL80Tp6WyYeIs+LCe3uXfnn8qtJyGuZz2tk0sHb8Swxq6TKHw2gjAHU0A1GQwuku1WF+M+nX2PBzAzsMMoVCgZsPOkWqmN90NwOrVhh3TgeFagpc3EUoYfGUq42xzlH8Fd5oP+lzBh97HqmXW0hUPquz+sK6w4g3kCP0bLu42XxYr4y1vnzRLuzf4ihfryqNJ1gozoHDX9zHjj0ZzWGu9WZ88xSPT1LMw+BKFwdPAz8JDO+9rKW6XMaN+d+4HmaEiwJLG8eb33RsHuX23t07m4tAHb1uIbQGjctJTEd/rpYUDXy/WKjQD9Ex5QzJ77lNSIUPZ00frFpt4jpJawLfv3KB/yzIZJ3MlbqN202HCiDXHGcJ+Fsn+FcVfD68/oHx/n7BsIa7wFrGY4h30Ab8mpSRGeTlt6vYRPvsGJIFqRuguvRbwJqeJFxRRQwupJa/a0qxiMUqSVzy0Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(6133799003)(3023799007)(22082099003)(55112099003)(18002099003)(5023799004)(4143699003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkhISEFBZlVhbkpIV0JoYklkQ1ExQ1VaZitSTzlTQjVTdXorNCtQQ2dBUmRP?=
 =?utf-8?B?Ly9EelZrTGFWM2hKb1VUQjk2b292OHdxdHE5MWxYdTdCY2J3cHJGeXZqZnJK?=
 =?utf-8?B?enJDaE9MaTB0dnBQL0RkWGtlRUdYTnQycy9YSXFmRmc5NWMweWdtTVErVUFm?=
 =?utf-8?B?dlF6SDAwdHlCcXQ3WHJEejNubUJXNHlMRGlwaCtITHc0MUJ1SyszSUorL0g0?=
 =?utf-8?B?LzZTbXBLa3NZemxWMXk5YmtBRGZ0RFEvakxqMVBxQ2dwUGNXeWpJbVp1ZXRY?=
 =?utf-8?B?cHFOc2JpNm9TMVJ6TlVuVmdxQWxIMWFadm5LbG5kVTNVanhlRVdqRU9rM3Vn?=
 =?utf-8?B?czc0bzBNbU1FVDE5TlNMNWhjb3RVMyttUjQ4SzQwZUJQblBoSkxnREY0S1dL?=
 =?utf-8?B?dUZXOXNNNjhmVWhZRDZTQVZHZGp2b0twZlJoU1JhSW1jR3BuUktwZnV6YnZ5?=
 =?utf-8?B?SEtGckl4Tkx0a0crMUJaVVp1eWtQdGJudnZpMFVmblloM0xvSnVMSUJMVEF6?=
 =?utf-8?B?cGdQODhDSGtoRGJlN2YranVVdlNxeXgybHRpbDlnOW9qcWlnS2dYSUlqUFRL?=
 =?utf-8?B?MUl4UHBZWU9ZMmFnelVJVkFiUTY3UGRzUVVkQ1ZsRXM0d0FGbE56QUg0elFG?=
 =?utf-8?B?OS9tOEwram9lUlhPNW53UU91WldmWlJ1NkY5VGFsMG15ZDBwMk5SZEVEdS8z?=
 =?utf-8?B?QllYRkFScnRnQ1JSQktJTVR4alpTV3lTd3IzYkRhRUpBUmsyZ3VINVZUaEli?=
 =?utf-8?B?M3N4Y25UL05EbUtDaGpCMWFna1kwMU92aWVsM1VMb0lXcUNpc0pKRzM2MzdW?=
 =?utf-8?B?TkdhY0lkT3psVkJwcjEyejUrdzZlaU5hcEc1VHpNUU1vZHllYjJ6Qm5ORG1j?=
 =?utf-8?B?YktjWno2WWVxdEovc1JnL3U4dk51bEx1SG1yY01jbndPU2Z5NTJMMTZmL2g1?=
 =?utf-8?B?c2l4L0F3VkU3d21tMWdPb1VLaXZER3pKYUR5OEJhNWxqcGtnQ0c5VXNSUTNC?=
 =?utf-8?B?ajU5TUFKRTMxUlc3eThocmxjQjFTSFErdVEvS1dwOCtCcHZHaUlSeUxXTkZq?=
 =?utf-8?B?MGN5UEhKUVJYUW0yNzE5bUhhRlBoNjdpcjdEdDg5ekxWVms2bndZTkpOUUtQ?=
 =?utf-8?B?NW9CYXNabTJwK0NOUzZYcFZBMHc3RDIvazlzRkRpbWZOWEhxcklwSFA0WE9K?=
 =?utf-8?B?eXB4ZVl5TGIzS1hacDAwYjVqMmEyYktwazBhVExLSkdzek9aV0NUWjJlS0g5?=
 =?utf-8?B?K0ZGSUJmZVc0MitQNVcwVXh1L0RpY08rVm5Bb0tiRVBCT3hOVittMzZNZUtT?=
 =?utf-8?B?SjFtYWpudENNcGJPTnU4WEVsdmtKUnRWd1dTOHhLeUczQ2dSTTVoekRTUXg4?=
 =?utf-8?B?Q3Mxd3FQcmVjSjdJWE5CQlNYNGZBaFY0OW56eThESC9ibDMrTnNEY3IxYVlD?=
 =?utf-8?B?N1N3RE5zZ1QrQmpkZFdXQ1V3T2ZkQU1LL2VkS0pYQVZadDBqWGdzTUJYYmhB?=
 =?utf-8?B?bmVnWTRqaFExOUNNdzVnNjN5Y2w3ZjU0V0NNVUNVbUxaQjdDQ080bWVzSVFx?=
 =?utf-8?B?NGRZclNJWEFLVTFhNGNsdThoVHlVZEZIUk51WmhjQy9keGpUV2luMUYxaVl6?=
 =?utf-8?B?NnNwMDFjc1ZZWnA3ZkZLaTBxZUtKc0RCMFNLVUZtTm9NQjQxMmdueUN1SlVX?=
 =?utf-8?B?NzVTRG1BWDBQQ2RiOUFnaHk2R2JBV0xRQWhlLzgzQ3d6TkZVN2xzaHpnRjZR?=
 =?utf-8?B?UzFMM3ZtL2NabEU3eFVDbjFVMnhpRHQvQVM1OE9ERG04eGJlRHlsYjVHY1pt?=
 =?utf-8?B?Skc1aXczT2JVZFJDUmFENGxuSEFXUDluRndWZ3FranhqQ2I3N051UE1iMkM0?=
 =?utf-8?B?aE5CYWRmb1dNQjhWYmNXSEhXbThZeFp3Skd2Mmw2WVR1S1ErcXdncFpIdWhM?=
 =?utf-8?B?RGg1K3d2SWxnMndPTnlodVFnWHpOSUx3WXpwSVIwZXZDQ3JHN0ExUW1mRENU?=
 =?utf-8?B?WmxYY09uVGUraDdxTHFJY1BLdGVlQndUOXZReGJrYWJMaVc2ZGMzRVV4ZHcr?=
 =?utf-8?B?MnR3NzYyenRhaEpzcUluMWVZQURiZjdhaERmZzd0YmFkcVYyZlZ3ZUt2RTdP?=
 =?utf-8?B?TWRWYmo2NldmNFMzdnFvanR2Wks2UnFYL1EzR0F6QmtaUncrU0c3RUVvZlpW?=
 =?utf-8?B?b1V5bENmTWlQRnpMQmRRUDhOblNzWmJLQmY0WFZ5eUJ6Ulo3TkIzYjRnR1F1?=
 =?utf-8?B?L0FPU3JhNkZxRytDcUVmRDZSQzVGbmJ0TTRnU1RVN2ZvK296cmF0RG5HdjJ1?=
 =?utf-8?B?RmkwNDZOR3Azdm1XbkxkTmlZeUNvSXRKallYWDVKT1gvUFRNTHpFTVgvZ0tY?=
 =?utf-8?Q?zuHr2awxWqsVxFvY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42129a22-c488-417a-a484-08df053b0a08
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 19:32:04.8972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1tDEcwbI3erm9kD9OKhFIdVDQl6GL7PbHIRq7lA3yNhBtpdiFAXiShXyFZl1dDEKVehJanY494Z1Zxn3DvMz4/wrKLhDj+yVoeN6rdi1eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7234
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

Hi Aswin,
I was not able to fully review the driver, but I found a few issues.

On 27-08-2026 13:03, Aswin Murugan wrote:
> The Qualcomm SDHCI driver lacked DLL init/calibration and tuning
> support, so it never negotiated above high-speed/DDR52. Add the
> CM_DLL init/phase-tuning sequence for HS200 and the SDC4 DLL
> calibration for HS400, matching the SDCC core generation variants
> already distinguished in this driver (core_minor-gated 14LPP/
> Tassadar DLL reset paths).
>
> Signed-off-by: Aswin Murugan<aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/mmc/msm_sdhci.c | 855 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 854 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index cbf565be426..8525d5d7534 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -16,6 +16,7 @@
>   #include <asm/io.h>
>   #include <linux/bitops.h>
>   #include <power/regulator.h>
> +#include <memalign.h>
>   
>   /* Non-standard registers needed for SDHCI startup */
>   #define SDCC_MCI_POWER   0x0
> @@ -38,6 +39,52 @@
>   #define CORE_DLL_PDN		BIT(29)
>   #define CORE_DLL_RST		BIT(30)
>   
> +/* DLL configuration */
> +#define CORE_DLL_EN		BIT(16)
> +#define CORE_CDR_EN		BIT(17)
> +#define CORE_CK_OUT_EN		BIT(18)
> +#define CORE_CDR_EXT_EN		BIT(19)
> +#define CORE_DLL_LOCK		BIT(7)
> +#define CORE_CMD_DAT_TRACK_SEL	BIT(0)
> +
> +#define CDR_SELEXT_SHIFT	20
> +#define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
> +
> +/* MCLK frequency selection (CMUX_SHIFT_PHASE) - required for the DLL to lock */
> +#define CMUX_SHIFT_PHASE_SHIFT	24
> +#define CMUX_SHIFT_PHASE_MASK	(7 << CMUX_SHIFT_PHASE_SHIFT)
> +
> +/* 14LPP DLL reset / Tassadar DLL extras, for SDCC minor >= 0x42 / 0x71 */
> +#define CORE_DLL_CLOCK_DISABLE	BIT(21)
> +
> +#define DLL_USR_CTL_POR_VAL	0x10800
> +#define ENABLE_DLL_LOCK_STATUS	BIT(26)
> +#define FINE_TUNE_MODE_EN	BIT(27)
> +#define BIAS_OK_SIGNAL		BIT(29)
> +
> +#define DLL_CONFIG_3_LOW_FREQ_VAL	0x08
> +#define DLL_CONFIG_3_HIGH_FREQ_VAL	0x10
> +
> +#define CORE_CLK_PWRSAVE	BIT(1)
> +
> +/* Timing mode selection */
> +#define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
> +#define CORE_HC_MCLK_SEL_HS400	(3 << 8)
> +#define CORE_HC_MCLK_SEL_MASK	(3 << 8)
> +#define CORE_HC_SELECT_IN_EN	BIT(18)
> +#define CORE_HC_SELECT_IN_HS400	(6 << 19)
> +#define CORE_HC_SELECT_IN_MASK	(7 << 19)
> +
> +/* HS400 DDR/SDC4 DLL calibration, needed alongside the SDR CM_DLL above */
> +#define CORE_DDR_CAL_EN		BIT(0)
> +#define CORE_DDR_DLL_LOCK	BIT(11)
> +#define CORE_PWRSAVE_DLL	BIT(3)
> +#define CORE_CMDIN_RCLK_EN	BIT(1)
> +#define DDR_CONFIG_POR_VAL	0x80040873
> +
> +#define CORE_FREQ_100MHZ	(100 * 1000000)
> +#define MAX_PHASES		16
> +
>   #define MHZ(X) ((X) * 1000000UL)
>   
>   struct msm_sdhc_plat {
> @@ -50,14 +97,40 @@ struct msm_sdhc {
>   	void *base;
>   	struct clk_bulk clks;
>   	struct udevice *vqmmc;
> +
> +	/* HS200/HS400 tuning and calibration state */
> +	bool tuning_done;
> +	bool calibration_done;
> +	bool use_cdr;

use_cdr is assigned value but never read.

> +	u8 saved_tuning_phase;
> +
> +	/* DLL init sequence variant selection, from the SDCC core version */
> +	u32 dll_config;		/* qcom,dll-config DT override, 0 if absent */
> +	bool use_14lpp_dll_reset;	/* core_minor >= 0x42 */
> +	bool uses_tassadar_dll;		/* core_minor >= 0x71 */
> +
> +	/* HS400 support */
> +	bool use_cdclp533;		/* core_minor < 0x34, legacy calibration path */
> +	bool updated_ddr_cfg;		/* core_minor >= 0x49 */
> +	u32 ddr_config;			/* qcom,ddr-config DT override, else POR value */
>   };
>   
>   struct msm_sdhc_variant_info {
>   	bool mci_removed;
>   
>   	u32 core_dll_config;
> +	u32 core_dll_status;
> +	u32 core_dll_config_2;
> +	u32 core_dll_config_3;
> +	u32 core_dll_usr_ctl; /* Present on SDCC5.1 onwards */
>   	u32 core_vendor_spec;
>   	u32 core_vendor_spec_capabilities0;
> +
> +	/* HS400 DDR/SDC4 calibration registers */
> +	u32 core_ddr_200_cfg;
> +	u32 core_vendor_spec3;
> +	u32 core_ddr_config_old; /* Applicable to sdcc minor ver < 0x49; 0 if N/A */
> +	u32 core_ddr_config;
>   };
>   
>   static int msm_sdc_clk_init(struct udevice *dev)
> @@ -153,12 +226,714 @@ static int msm_sdc_mci_init(struct msm_sdhc *prv)
>   	return 0;
>   }
>   
> +static int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
> +{
> +	u32 wait_cnt = 50;
> +	u8 ck_out_en;
> +	struct udevice *dev = host->mmc->dev;
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +
> +	ck_out_en = !!(readl(host->ioaddr + var_info->core_dll_config) &
> +		       CORE_CK_OUT_EN);
> +
> +	while (ck_out_en != poll) {
> +		if (--wait_cnt == 0) {
> +			printf("%s: CK_OUT_EN bit is not %d\n",
> +			       host->name, poll);
> +			return -ETIMEDOUT;
> +		}
> +		udelay(1);
> +
> +		ck_out_en = !!(readl(host->ioaddr +
> +				     var_info->core_dll_config) &
> +			       CORE_CK_OUT_EN);
> +	}
> +
> +	return 0;
> +}
> +
> +static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
> +{
> +	int rc;
> +	static const u8 grey_coded_phase_table[] = {
> +		0x0, 0x1, 0x3, 0x2, 0x6, 0x7, 0x5, 0x4,
> +		0xc, 0xd, 0xf, 0xe, 0xa, 0xb, 0x9, 0x8
> +	};
> +	u32 config;
> +	struct udevice *dev = host->mmc->dev;
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +
> +	if (phase > 0xf)
> +		return -EINVAL;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~(CORE_CDR_EN | CORE_CK_OUT_EN);
> +	config |= (CORE_CDR_EXT_EN | CORE_DLL_EN);
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	rc = msm_dll_poll_ck_out_en(host, 0);
> +	if (rc)
> +		return rc;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~CDR_SELEXT_MASK;
> +	config |= grey_coded_phase_table[phase] << CDR_SELEXT_SHIFT;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CK_OUT_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	rc = msm_dll_poll_ck_out_en(host, 1);
> +	if (rc)
> +		return rc;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CDR_EN;
> +	config &= ~CORE_CDR_EXT_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	return 0;
> +}
> +
> +/*
> + * Programs the MCLK_FREQ (CMUX_SHIFT_PHASE) field, required before enabling
> + * CORE_DLL_EN/CORE_CK_OUT_EN or the DLL never locks. Matches the kernel
> + * driver's msm_cm_dll_set_freq().
> + *
> + * host->clock is never updated by this U-Boot's generic sdhci.c, so
> + * mmc->clock is used instead.
> + */
> +static void msm_cm_dll_set_freq(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	struct mmc *mmc = host->mmc;
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 mclk_freq = 0, config;
> +	unsigned int clock = mmc->clock;
> +
> +	if (clock <= 112000000)
> +		mclk_freq = 0;
> +	else if (clock <= 125000000)
> +		mclk_freq = 1;
> +	else if (clock <= 137000000)
> +		mclk_freq = 2;
> +	else if (clock <= 150000000)
> +		mclk_freq = 3;
> +	else if (clock <= 162000000)
> +		mclk_freq = 4;
> +	else if (clock <= 175000000)
> +		mclk_freq = 5;
> +	else if (clock <= 187000000)
> +		mclk_freq = 6;
> +	else if (clock <= 200000000)
> +		mclk_freq = 7;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~CMUX_SHIFT_PHASE_MASK;
> +	config |= mclk_freq << CMUX_SHIFT_PHASE_SHIFT;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +}
> +
> +static int msm_dll_poll_lock_status(struct sdhci_host *host)
> +{
> +	u32 wait_cnt = 50;
> +	struct udevice *dev = host->mmc->dev;
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +
> +	while (!(readl(host->ioaddr + var_info->core_dll_status) &
> +		 CORE_DLL_LOCK)) {
> +		if (--wait_cnt == 0) {
> +			printf("%s: DLL failed to LOCK (DLL_STATUS=0x%08x)\n",
> +			       host->name,
> +			       readl(host->ioaddr + var_info->core_dll_status));
> +			return -ETIMEDOUT;
> +		}
> +		udelay(1);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Matches the kernel sdhci-msm.c msm_init_cm_dll() sequence */
> +static int msm_init_cm_dll(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 config;
> +	int ret;
> +
> +	/*
> +	 * Keep the clock enabled while DLL tuning is in progress; PWRSAVE
> +	 * may otherwise turn it off.
> +	 */
> +	config = readl(host->ioaddr + var_info->core_vendor_spec);
> +	config &= ~CORE_CLK_PWRSAVE;
> +	writel(config, host->ioaddr + var_info->core_vendor_spec);
> +
> +	if (priv->dll_config)
> +		writel(priv->dll_config, host->ioaddr + var_info->core_dll_config);
> +
> +	if (priv->use_14lpp_dll_reset) {
> +		config = readl(host->ioaddr + var_info->core_dll_config);
> +		config &= ~CORE_CK_OUT_EN;
> +		writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +		if (var_info->core_dll_config_2) {
> +			config = readl(host->ioaddr + var_info->core_dll_config_2);
> +			config |= CORE_DLL_CLOCK_DISABLE;
> +			writel(config, host->ioaddr + var_info->core_dll_config_2);
> +		}
> +	}
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_DLL_RST;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_DLL_PDN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	/*
> +	 * MCLK_FREQ must be programmed while the DLL is reset and powered
> +	 * down, unless a DT dll-config override is in effect.
> +	 */
> +	if (!priv->dll_config)
> +		msm_cm_dll_set_freq(host);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~CORE_DLL_RST;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~CORE_DLL_PDN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	if (priv->use_14lpp_dll_reset) {
> +		if (!priv->dll_config)
> +			msm_cm_dll_set_freq(host);
> +
> +		if (var_info->core_dll_config_2) {
> +			config = readl(host->ioaddr + var_info->core_dll_config_2);
> +			config &= ~CORE_DLL_CLOCK_DISABLE;
> +			writel(config, host->ioaddr + var_info->core_dll_config_2);
> +		}
> +	}
> +
> +	/* Applicable to SDCC v5.1 onwards only */
> +	if (priv->uses_tassadar_dll && var_info->core_dll_usr_ctl) {
> +		config = DLL_USR_CTL_POR_VAL | FINE_TUNE_MODE_EN |
> +			 ENABLE_DLL_LOCK_STATUS | BIAS_OK_SIGNAL;
> +		writel(config, host->ioaddr + var_info->core_dll_usr_ctl);
> +
> +		if (var_info->core_dll_config_3) {
> +			config = readl(host->ioaddr + var_info->core_dll_config_3);
> +			config &= ~0xFF;
> +			if (host->mmc->clock < 150000000)
> +				config |= DLL_CONFIG_3_LOW_FREQ_VAL;
> +			else
> +				config |= DLL_CONFIG_3_HIGH_FREQ_VAL;
> +			writel(config, host->ioaddr + var_info->core_dll_config_3);
> +		}
> +	}
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_DLL_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CK_OUT_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	ret = msm_dll_poll_lock_status(host);
> +	if (ret)
> +		return ret;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CDR_EN;
> +	config &= ~CORE_CDR_EXT_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	priv->calibration_done = false;
> +
> +	return 0;
> +}
> +
> +/*
> + * HS400 DDR calibration via SDC4 CM_DLL, used when use_cdclp533 is false
> + * (core_minor >= 0x34). Matches the kernel's
> + * sdhci_msm_cm_dll_sdc4_calibration().
> + */
> +static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 config, ddr_cfg_offset, wait_cnt;
> +	int ret;
> +
> +	/*
> +	 * core_ddr_config defaults to the desired configuration on reset;
> +	 * reprogram the POR value in case an earlier bootloader stage
> +	 * modified it.
> +	 */
> +	if (priv->updated_ddr_cfg)
> +		ddr_cfg_offset = var_info->core_ddr_config;
> +	else
> +		ddr_cfg_offset = var_info->core_ddr_config_old;
> +	writel(priv->ddr_config, host->ioaddr + ddr_cfg_offset);
> +
> +	config = readl(host->ioaddr + var_info->core_ddr_200_cfg);
> +	config &= ~CORE_CMDIN_RCLK_EN;
> +	writel(config, host->ioaddr + var_info->core_ddr_200_cfg);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config_2);
> +	config |= CORE_DDR_CAL_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config_2);
> +
> +	ret = -ETIMEDOUT;
> +	wait_cnt = 100;
> +	while (wait_cnt--) {
> +		if (readl(host->ioaddr + var_info->core_dll_status) &
> +		    CORE_DDR_DLL_LOCK) {
> +			ret = 0;
> +			break;
> +		}
> +		udelay(10);
> +	}
> +
> +	if (ret) {
> +		printf("%s: CM_DLL_SDC4 calibration was not completed\n",
> +		       host->name);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Skip CORE_PWRSAVE_DLL for the 14lpp DLL reset variant: it cannot
> +	 * guarantee the MCLK-gating timing PWRSAVE_DLL depends on.
> +	 */
> +	if (!priv->use_14lpp_dll_reset) {
> +		config = readl(host->ioaddr + var_info->core_vendor_spec3);
> +		config |= CORE_PWRSAVE_DLL;
> +		writel(config, host->ioaddr + var_info->core_vendor_spec3);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * HS400 DLL calibration, performed once when transitioning into HS400 at
> + * clock > 100MHz. Matches the kernel's sdhci_msm_hs400_dll_calibration().
> + */
> +static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 config;
> +	int ret;
> +
> +	ret = msm_init_cm_dll(host);
> +	if (ret)
> +		return ret;
> +
> +	/* Restore the phase found during HS200 tuning */
> +	ret = msm_config_cm_dll_phase(host, priv->saved_tuning_phase);
> +	if (ret)
> +		return ret;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CMD_DAT_TRACK_SEL;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	/*
> +	 * use_cdclp533 only applies to legacy SDCC (core_minor < 0x34); our
> +	 * supported targets always use the SDC4 calibration path.
> +	 */
> +	if (priv->use_cdclp533) {
> +		printf("%s: CDCLP533 HS400 calibration path is not implemented\n",
> +		       host->name);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return sdhci_msm_cm_dll_sdc4_calibration(host);
> +}
> +
> +static int msm_find_most_appropriate_phase(struct sdhci_host *host,
> +					   u8 *phase_table,
> +					   u8 total_phases)
> +{
> +	int ret;
> +	u8 ranges[MAX_PHASES][MAX_PHASES] = { {0}, {0} };
> +	u8 phases_per_row[MAX_PHASES] = { 0 };
> +	int row_index = 0, col_index = 0, selected_row_index = 0;
> +	int i, longest_range_len = 0;
> +	bool found = false;
> +
> +	if (!total_phases || total_phases > MAX_PHASES) {
> +		printf("%s: Invalid argument: total_phases=%d\n",
> +		       host->name, total_phases);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < total_phases; i++) {
> +		ranges[row_index][col_index] = phase_table[i];
> +		phases_per_row[row_index] += 1;
> +		col_index++;
> +
> +		if ((i + 1) == total_phases)
> +			continue;
> +
> +		if (phase_table[i] + 1 != phase_table[i + 1]) {
> +			row_index++;
> +			col_index = 0;
> +		}
> +	}
> +
> +	if (row_index == 0) {
> +		ret = phase_table[total_phases / 2];
> +		goto exit;
> +	}
> +
> +	for (i = 0; i <= row_index; i++) {
> +		if (phases_per_row[i] > longest_range_len) {
> +			longest_range_len = phases_per_row[i];
> +			selected_row_index = i;
> +			found = true;
> +		}
> +	}
> +
> +	if (found) {
> +		ret = ranges[selected_row_index][longest_range_len / 2];
> +	} else {
> +		ret = -EIO;
> +		printf("%s: Failed to find a valid phase\n", host->name);
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +static bool sdhci_msm_is_tuning_needed(struct sdhci_host *host)
> +{
> +	struct mmc *mmc = host->mmc;
> +
> +	return mmc->selected_mode == MMC_HS_200;
> +}
> +
> +static int msm_send_tuning_cmd(struct mmc *mmc, u32 opcode)
> +{
> +	struct mmc_cmd cmd;
> +	struct mmc_data data;
> +	const u8 *tuning_block_pattern;
> +	int size, err;
> +
> +	static const u8 tuning_blk_pattern_4bit[] = {
> +		0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
> +		0xc3, 0x3c, 0xcc, 0xff, 0xfe, 0xff, 0xfe, 0xef,
> +		0xff, 0xdf, 0xff, 0xdd, 0xff, 0xfb, 0xff, 0xfb,
> +		0xbf, 0xff, 0x7f, 0xff, 0x77, 0xf7, 0xbd, 0xef,
> +		0xff, 0xf0, 0xff, 0xf0, 0x0f, 0xfc, 0xcc, 0x3c,
> +		0xcc, 0x33, 0xcc, 0xcf, 0xff, 0xef, 0xff, 0xee,
> +		0xff, 0xfd, 0xff, 0xfd, 0xdf, 0xff, 0xbf, 0xff,
> +		0xbb, 0xff, 0xf7, 0xff, 0xf7, 0x7f, 0x7b, 0xde,
> +	};
> +
> +	static const u8 tuning_blk_pattern_8bit[] = {
> +		0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
> +		0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc, 0xcc,
> +		0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff, 0xff,
> +		0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee, 0xff,
> +		0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd, 0xdd,
> +		0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff, 0xbb,
> +		0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff, 0xff,
> +		0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee, 0xff,
> +		0xff, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00,
> +		0x00, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc,
> +		0xcc, 0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff,
> +		0xff, 0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee,
> +		0xff, 0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd,
> +		0xdd, 0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff,
> +		0xbb, 0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff,
> +		0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
> +	};
> +

Except calculating the size tuning_blk_pattern_* are not used,
they should be used to compare the payload, that comparison
is what marks a phase as good or bad.
These 4/8-bit pattern tables duplicate the ones in
mmc_send_tuning()

> +	if (mmc->bus_width == 8) {
> +		tuning_block_pattern = tuning_blk_pattern_8bit;
> +		size = sizeof(tuning_blk_pattern_8bit);
> +	} else if (mmc->bus_width == 4) {
> +		tuning_block_pattern = tuning_blk_pattern_4bit;
> +		size = sizeof(tuning_blk_pattern_4bit);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	ALLOC_CACHE_ALIGN_BUFFER(u8, data_buf, size);
> +
> +	cmd.cmdidx = opcode;
> +	cmd.cmdarg = 0;
> +	cmd.resp_type = MMC_RSP_R1;
> +
> +	data.dest = (void *)data_buf;
> +	data.blocks = 1;
> +	data.blocksize = size;
> +	data.flags = MMC_DATA_READ;
> +
> +	err = mmc_send_cmd(mmc, &cmd, &data);
> +
> +	return err;
> +}

msm_send_tuning_cmd() is a copy of mmc_send_tuning
function with the memcmp dropped. Any specific reason
for doing so? If not, then please drop msm_send_tuning_cmd()
and call mmc_send_tuning() instead. It is already compiled in
whenever HS200/HS400 is enabled.


> +
> +static int sdhci_msm_execute_tuning(struct mmc *mmc, u8 opcode)
> +{
> +	struct sdhci_host *host = mmc->priv;
> +	int tuning_seq_cnt = 10;
> +	u8 phase, tuned_phases[MAX_PHASES], tuned_phase_cnt = 0;
> +	int rc;
> +	struct udevice *dev = mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +
> +	if (!sdhci_msm_is_tuning_needed(host)) {
> +		priv->use_cdr = false;
> +		return 0;
> +	}
> +
> +	/*
> +	 * The SDHCI core may call execute_tuning before host->clock is
> +	 * updated to match mmc->clock.
> +	 */
> +	if (host->clock != mmc->clock) {
> +		rc = sdhci_set_clock(mmc, mmc->clock);
> +		if (rc) {
> +			printf("%s: Failed to set clock for tuning\n", host->name);
> +			return rc;
> +		}
> +	}
> +
> +	priv->use_cdr = true;
> +	priv->tuning_done = false;
> +
> +retry:
> +	rc = msm_init_cm_dll(host);
> +	if (rc) {
> +		printf("%s: Failed to init DLL\n", host->name);
> +		return rc;
> +	}
> +
> +	phase = 0;
> +	tuned_phase_cnt = 0;
> +
> +	do {
> +		rc = msm_config_cm_dll_phase(host, phase);
> +		if (rc) {
> +			printf("%s: Failed to set DLL phase %d\n",
> +			       host->name, phase);
> +			return rc;
> +		}
> +
> +		rc = msm_send_tuning_cmd(mmc, opcode);
> +		if (!rc)
> +			tuned_phases[tuned_phase_cnt++] = phase;

Better to use:
rc = mmc_send_tuning(mmc, opcode);
if (!rc)
         tuned_phases[tuned_phase_cnt++] = phase;

> +	} while (++phase < MAX_PHASES);
> +
> +	if (tuned_phase_cnt) {
> +		if (tuned_phase_cnt == MAX_PHASES) {
> +			/*
> +			 * All phases valid is close to as bad as none valid:
> +			 * likely no phase is really reliable. Retry a few
> +			 * times rather than guessing.
> +			 */
> +			if (--tuning_seq_cnt) {
> +				tuned_phase_cnt = 0;
> +				goto retry;
> +			}
> +		}
> +
> +		rc = msm_find_most_appropriate_phase(host, tuned_phases,
> +						     tuned_phase_cnt);
> +		if (rc < 0) {
> +			printf("%s: Failed to find appropriate phase\n",
> +			       host->name);
> +			return rc;
> +		}
> +		phase = rc;
> +
> +		rc = msm_config_cm_dll_phase(host, phase);
> +		if (rc) {
> +			printf("%s: Failed to set final phase %d\n",
> +			       host->name, phase);
> +			return rc;
> +		}
> +
> +		priv->saved_tuning_phase = phase;
> +	} else {
> +		if (--tuning_seq_cnt)
> +			goto retry;
> +		printf("%s: No tuning point found\n", host->name);
> +		rc = -EIO;
> +	}
> +
> +	if (!rc)
> +		priv->tuning_done = true;
> +
> +	return rc;
> +}
> +
> +/*
> + * Configure HC mode selection. Runs from set_control_reg(), which the
> + * generic sdhci_set_ios() always calls before sdhci_set_clock() - and it is
> + * sdhci_set_clock() that triggers config_dll(), which performs the SDC4
> + * CM_DLL HS400 calibration. On the first HS400 transition, calibration_done
> + * is still false here (it only becomes true after config_dll() runs later
> + * in the same set_ios() call), so the HS400 mux-select bits are deferred
> + * until calibration has actually completed - selecting HS400 in the mux
> + * beforehand would switch the data path into HS400 timing while the DLL is
> + * still configured for the previous mode/clock. The first write of these
> + * bits happens from msm_sdhci_config_dll() via sdhci_msm_hs400_select_in()
> + * once calibration succeeds.
> + */
> +static void sdhci_msm_hc_select_mode(struct sdhci_host *host)
> +{
> +	struct mmc *mmc = host->mmc;
> +	struct udevice *dev = mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	bool is_hs400 = mmc->selected_mode == MMC_HS_400;
> +	u32 config;
> +
> +	config = readl(host->ioaddr + var_info->core_vendor_spec);
> +	config &= ~CORE_HC_MCLK_SEL_MASK;
> +
> +	if (mmc->selected_mode == MMC_HS_200)
> +		config |= CORE_HC_MCLK_SEL_DFLT;
> +	else if (is_hs400)
> +		config |= CORE_HC_MCLK_SEL_HS400;
> +	else
> +		config |= CORE_HC_MCLK_SEL_DFLT;
> +
> +	writel(config, host->ioaddr + var_info->core_vendor_spec);
> +
> +	if (is_hs400) {
> +		if (priv->calibration_done) {
> +			config = readl(host->ioaddr + var_info->core_vendor_spec);
> +			config |= CORE_HC_SELECT_IN_HS400;
> +			config |= CORE_HC_SELECT_IN_EN;
> +			writel(config, host->ioaddr + var_info->core_vendor_spec);
> +		}
> +	} else {
> +		/*
> +		 * Matches the kernel's msm_hc_select_default(): explicitly
> +		 * clear these bits for every non-HS400 mode so a previous
> +		 * HS400 attempt never leaves them stuck set.
> +		 */
> +		if (!priv->use_cdclp533) {
> +			config = readl(host->ioaddr + var_info->core_vendor_spec3);
> +			config &= ~CORE_PWRSAVE_DLL;
> +			writel(config, host->ioaddr + var_info->core_vendor_spec3);
> +		}
> +
> +		config = readl(host->ioaddr + var_info->core_vendor_spec);
> +		config &= ~CORE_HC_SELECT_IN_EN;
> +		config &= ~CORE_HC_SELECT_IN_MASK;
> +		writel(config, host->ioaddr + var_info->core_vendor_spec);
> +	}
> +}
> +
> +/*
> + * Selects HS400 in the HC_SELECT_IN mux. Must only be called immediately
> + * after sdhci_msm_hs400_dll_calibration() succeeds - see the comment in
> + * sdhci_msm_hc_select_mode() for why this can't be done there.
> + */
> +static void sdhci_msm_hs400_select_in(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 config;
> +
> +	config = readl(host->ioaddr + var_info->core_vendor_spec);
> +	config |= CORE_HC_SELECT_IN_HS400;
> +	config |= CORE_HC_SELECT_IN_EN;
> +	writel(config, host->ioaddr + var_info->core_vendor_spec);
> +}
> +
> +static void sdhci_msm_set_control_reg(struct sdhci_host *host)
> +{
> +	struct mmc *mmc = host->mmc;
> +	struct udevice *dev = mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 config;
> +
> +	/*
> +	 * The Qualcomm SDHCI controller does not implement the generic
> +	 * SDHCI_CTRL_HS400 (0x5) HOST_CONTROL2 encoding that
> +	 * sdhci_set_uhs_timing() would write for HS400. Per the kernel
> +	 * driver's sdhci_msm_set_uhs_signaling(), it instead keeps
> +	 * HOST_CONTROL2's UHS field at SDR104 (identical to HS200) for
> +	 * HS400 too, relying entirely on the vendor-specific
> +	 * CORE_HC_MCLK_SEL/CORE_HC_SELECT_IN bits (sdhci_msm_hc_select_mode()
> +	 * below) to switch the data path into HS400 timing.
> +	 */
> +	sdhci_set_voltage(host);
> +	if (mmc->selected_mode == MMC_HS_400) {
> +		u32 ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +		ctrl2 &= ~SDHCI_CTRL_UHS_MASK;
> +		ctrl2 |= SDHCI_CTRL_UHS_SDR104;
> +		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +	} else {
> +		sdhci_set_uhs_timing(host);
> +	}
> +
> +	sdhci_msm_hc_select_mode(host);
> +
> +	/*
> +	 * Below 100MHz the feedback clock must be provided without the DLL,
> +	 * so tuning can be skipped.
> +	 */
> +	if (mmc->clock && mmc->clock <= CORE_FREQ_100MHZ) {
> +		if (mmc->selected_mode == MMC_HS_200 ||
> +		    mmc->selected_mode == MMC_HS_400) {
> +			config = readl(host->ioaddr + var_info->core_dll_config);
> +			config |= CORE_DLL_RST;
> +			writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +			config = readl(host->ioaddr + var_info->core_dll_config);
> +			config |= CORE_DLL_PDN;
> +			writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +			/*
> +			 * Calibration must be redone once the clock is set
> +			 * back to HS400 speed, matching the kernel's
> +			 * sdhci_msm_set_uhs_signaling().
> +			 */
> +			priv->calibration_done = false;
> +		}
> +	}
> +}
> +
>   static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
>   {
>   	struct udevice *dev = mmc_to_dev(host->mmc);
> +	struct mmc *mmc = host->mmc;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
>   	const struct msm_sdhc_variant_info *var_info = (void *)dev_get_driver_data(dev);
>   	u32 config;
>   
> +	if (clock == 0)
> +		return 0;
> +
>   	if (enable && clock < MHZ(100)) {
>   		/*
>   		 * DLL is not required for clock <= 100MHz
> @@ -173,12 +948,40 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
>   		writel(config, host->ioaddr + var_info->core_dll_config);
>   	}
>   
> +	/*
> +	 * HS400 requires a dedicated DDR/SDC4 DLL calibration step,
> +	 * performed once per calibration cycle after the divider has been
> +	 * programmed and the clock is running above 100MHz - the analogue
> +	 * of the kernel's sdhci_msm_set_uhs_signaling() -> sdhci_msm_hs400()
> +	 * trigger, which runs right after the SDCLK divider is set.
> +	 */
> +	if (enable && clock > MHZ(100) &&
> +	    mmc->selected_mode == MMC_HS_400 && priv->tuning_done &&
> +	    !priv->calibration_done) {
> +		int ret = sdhci_msm_hs400_dll_calibration(host);
> +
> +		if (!ret) {
> +			priv->calibration_done = true;
> +			/*
> +			 * Only now that calibration has actually succeeded
> +			 * is it safe to switch the data-path mux into HS400
> +			 * timing - see the comment in
> +			 * sdhci_msm_hc_select_mode().
> +			 */
> +			sdhci_msm_hs400_select_in(host);
> +		} else {
> +			printf("%s: Failed to calibrate DLL for HS400 mode (%d)\n",
> +			       host->name, ret);
> +		}
> +	}
> +

If sdhci_msm_hs400_dll_calibration() fails, config_dll still returns 0, 
so it
continues in HS400 without a locked DLL. That should fail the mode switch.

>   	return 0;
>   }
>   
>   struct sdhci_ops msm_sdhci_ops = {
>   	.config_dll = &msm_sdhci_config_dll,
> -	.set_control_reg = &sdhci_set_control_reg,
> +	.set_control_reg = &sdhci_msm_set_control_reg,
> +	.platform_execute_tuning = &sdhci_msm_execute_tuning,
>   };
>   
>   static int msm_sdc_probe(struct udevice *dev)
> @@ -239,6 +1042,27 @@ static int msm_sdc_probe(struct udevice *dev)
>   
>   	log_debug("SDCC version %d.%d\n", core_major, core_minor);
>   
> +	/*
> +	 * Match the kernel driver's version-gated feature detection so the
> +	 * DLL init sequence matches what this SDCC IP revision needs.
> +	 */
> +	if (core_major == 1 && core_minor >= 0x42)
> +		prv->use_14lpp_dll_reset = true;
> +
> +	if (core_major == 1 && core_minor >= 0x71)
> +		prv->uses_tassadar_dll = true;
> +
> +	if (core_major == 1 && core_minor < 0x34)
> +		prv->use_cdclp533 = true;
> +
> +	if (core_major == 1 && core_minor >= 0x49)
> +		prv->updated_ddr_cfg = true;
> +
> +	dev_read_u32(dev, "qcom,dll-config", &prv->dll_config);
> +
> +	if (dev_read_u32(dev, "qcom,ddr-config", &prv->ddr_config))
> +		prv->ddr_config = DDR_CONFIG_POR_VAL;
> +
>   	/*
>   	 * Support for some capabilities is not advertised by newer
>   	 * controller versions and must be explicitly enabled.
> @@ -249,6 +1073,16 @@ static int msm_sdc_probe(struct udevice *dev)
>   		writel(caps, host->ioaddr + var_info->core_vendor_spec_capabilities0);
>   	}
>   
> +	/*
> +	 * HS400 uses DDR signaling, and host_caps MMC_CAP(MMC_HS_400) is
> +	 * already set unconditionally by the generic drivers/mmc/sdhci.c

The comment is incorrect: sdhci_setup_cfg() does not set
MMC_CAP(MMC_HS_400) from CONFIG_MMC_HS400_SUPPORT. HS400
comes from DT via mmc_of_parse().

> +	 * whenever CONFIG_MMC_HS400_SUPPORT=y, so advertising DDR50/SDR104
> +	 * support here is all that's needed to enable HS200/HS400.
> +	 */
> +	caps = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
> +	caps |= SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_DDR50;

If this write is visible, it advertises SDR104/DDR50 on every instance,
including eMMC-only nodes. Drop it and rely on the existing DT properties.

> +	writel(caps, host->ioaddr + SDHCI_CAPABILITIES_1);
> +

SDHCI_CAPABILITIES_1 is a spec read-only register, this writel is a
no-op, the block does nothing.

>   	ret = mmc_of_parse(dev, &plat->cfg);
>   	if (ret)
>   		return ret;
> @@ -322,16 +1156,35 @@ static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
>   	.mci_removed = false,
>   
>   	.core_dll_config = 0x100,
> +	.core_dll_status = 0x108,
> +	.core_dll_config_2 = 0x1b4,
>   	.core_vendor_spec = 0x10c,
>   	.core_vendor_spec_capabilities0 = 0x11c,
> +
> +	.core_ddr_200_cfg = 0x184,
> +	.core_vendor_spec3 = 0x1b0,
> +	.core_ddr_config_old = 0x1b8,
> +	.core_ddr_config = 0x1bc,
>   };
>   
>   static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
>   	.mci_removed = true,
>   
>   	.core_dll_config = 0x200,
> +	.core_dll_status = 0x208,
> +	.core_dll_config_2 = 0x254,
> +	.core_dll_config_3 = 0x258,
> +	.core_dll_usr_ctl = 0x388,
>   	.core_vendor_spec = 0x20c,
>   	.core_vendor_spec_capabilities0 = 0x21c,
> +
> +	.core_ddr_200_cfg = 0x224,
> +	.core_vendor_spec3 = 0x250,
> +	.core_ddr_config = 0x25c,
> +	/*
> +	 * core_ddr_config_old not present on V5 - updated_ddr_cfg is
> +	 * effectively always true here since V5 implies core_minor >= 0x49
> +	 */
>   };
>   
>   static const struct udevice_id msm_mmc_ids[] = {

Regards,
Tanmay
