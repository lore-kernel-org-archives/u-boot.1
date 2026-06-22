Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DAECDB46B
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 09:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C76B784832;
	Mon, 22 Jun 2026 11:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lokp3qlP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EEB6848DC; Mon, 22 Jun 2026 11:40:23 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C87846A4
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 11:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grTSrhuwV06Me93k3aKsUccLERoMfF3ozXOSL8yZNBUpEAkN5LfpljcOwoJfauQKgCz1fmAZTCq+69r97iHYU6cO86qyU1rrfcCLrunilrNxsRAQYj1tTcviXw5XSG50Y9UClR31l6OInpibxPEEmfQWzXSVeXipCbqa/9H10aLUj9vZPMsXcWBNQdKsFm557xvkMzXSWnfaS5AyAPaLzyQNnrYkj4byvlO2hQNSeqb2mRhoaPpM0m1h69I7ZrTKzssxGf56ejextVYMOsfQRlD64pFZxPTSj3lPDtRqemhXGhIoLTXXiR/ZZZMDyYj06UVozaCRRzTkssuVilCQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXes8UFyEb3BY4Du2opf9XOpn7rzxTHA1H/lazeHyqE=;
 b=PTMmqWbv44O7uT8W7EN7uauyrYi7zUwwHQ7mvuchnnRPJPE78d1SYy69dMqdCi+XVWLX4Q5rQwi0m66ass7kkU9oiVzucpeB/b8KaAtvutaOvEddiAYKp8IFftjymZVXsgxyMjPMlj/ZYaYKy+N5urt4b8SIcOr6uMKVQ8sOfgftzBC+kkFRhY/2ZjvCplUHVWBBzMaMPYlkUtZUuYpAmnEivGgOVuE/rn3qE7W4AUEnm1MnHFUboigHOrNIZxMxYFeGu/0C7wyzcyWBOWUc4q9d6DgUFBPqzVvhRd5T1mLMEMMNlqG3iiE2z0bjRVD5C/Aab22OF+pdnEYqyFH8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXes8UFyEb3BY4Du2opf9XOpn7rzxTHA1H/lazeHyqE=;
 b=lokp3qlP1QUd9WoanZWdQhqOD+4/s+oqxveT+cQnhOCXmDa1VckUaite13kZZ7yNIcgFCdt2eEQ+eWvIHYGjCE8nJ8SGAiU1MZqaKfWN+Qs+aQ5h3MsMlFQce1iL9OVt2qeSGoE5x9WVjEyJCzzVL//D49p0teA9LUEyo3vDrEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Mon, 22 Jun
 2026 09:40:16 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 09:40:16 +0000
Message-ID: <008cc329-4464-4d9b-8100-ee0adcd488c0@cherry.de>
Date: Mon, 22 Jun 2026 11:40:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] treewide: Fix STMicroelectronics spelling
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20260622000535.226234-1-marex@nabladev.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260622000535.226234-1-marex@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VE1PR04MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 910a0dc4-5718-496c-cace-08ded04243ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: fqnC5GPvmzTQKlH5/b/h3I32DdWuSuwdJ4UNzTTdaL1OJqBfGn5Cqi5X6hGsmFW7tIqIdmKUkL4pSrdGbUO4iDOvLMU++OvpM/z6hEdwFr+v5wyBuYKdq2rrx/iv2rCzMwM61mRYBJEeDuSxox3H/AX0K0uhnrMvrqL6/0aCfkZCMTlZ/mv0E/i+HeUSeOprqppWQZ67N76aCDywctB/AFCbaisC7A/PERDoG5TpK+ai/R+iJq/IvB8grdnP+A9v2Sg+5ZhT5g3zBI1aO1JpMYUQhCOOBQ5oLoBoQ++GgV2Qc4cmhsdgDL59BvOfj+kJ7OvqMtCtZPFSBGzsMe8O2o8Zyg3bsQ+VBs/Oh2lhHpny7+dDjajSuaLaP25r6RpRBipQni7r/f2RdZLBfn8tev2VyKjqrhVfp0CNu6pnSSPLgzB1VtElim5bcp+vUj4GO76Ob9tn8sk3lmSBwu4+GkH1l4rQG6qWMV/6CDGuJg16Y3tgu+fRHTGWeUByeSEnbvQ2v+lK91sa7zJU/SSJGI7gXSOMv/zuKDPPu4jFM7+MvoS9ZdNQZxj2iS6gmzloAiR+JeVJeOy26nmtw9xx1GJLdE2vEpDPmhCSwU2UhaXRSXA6OF15BctqtTb0oJZzKjtcAgdxslupgoyIWdL4c/VL4Cav6S4ocS6cmu/PLRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVpjaktIVjEzbjBwYTJMYTh4ZzRaaklOb05zbnBqN1Y3cVl3Ny93WXNKY21Z?=
 =?utf-8?B?dlI1aU5DQVBsRFpobVo4MlZuYXVwbzJMWTMxNlpzbGRnb3NsWFhNa2dYdWE1?=
 =?utf-8?B?amRoTkVTUGVKbFlJRWIrZjlVSWlRUmo3Snk3b0ZBVDZ5L2xWNC84cEJ2YjZN?=
 =?utf-8?B?ZVgxd1d5NEEvR1FLOTcwdHdwNHgzS2Z2dlJUb2NVYlMvRHBBYkhrdFd5Tk5p?=
 =?utf-8?B?L05vd20xS3pqSHVodjRhaWNXR3FsSDBHOVlFTEd3aUw4eGRvbU91S0tZZUJS?=
 =?utf-8?B?ajVNaUdDaEN0UFZBQlVYQXNYNU9iNVFZWHBOMWg0eFF1dUUyeTF4QlJBY3Rx?=
 =?utf-8?B?T1Uwa0ZFNk9UYlVmcGhpeFJmWHVzdE5mZ3BqTTRDNWk4eEtkVzFGbloydzJs?=
 =?utf-8?B?bWJsdjNXK3B6NW96U2RaWmtGRThRWEFPY1Zwdi9ZY2xVbXFXb0dIMHhZWTIw?=
 =?utf-8?B?QWxxUzc3akx3dHBsMEJTR2dDN0NxWllZSmkyOTU2TUJNd0ZRTW1JK3hFUU04?=
 =?utf-8?B?akJvaCtMSnVua2RzODBNSTZWQlE5cFdUT3NnendYWm5LdDZWVFBFOWVFVXgw?=
 =?utf-8?B?MkhVUFhQWU5rWmVvQ3BLY2N6Z3pJVkVQL2ZaUlVsbDRKMTIvUCt3NnFtczVN?=
 =?utf-8?B?ODRKd2pHTHc1ZkV0UVdDTCtoZGFxZTB5cURpTWk2T3ZPcDFCOVg2L1JoTGIr?=
 =?utf-8?B?Z0g3Tk1aWUtaRnhpeXdJNlJQNStnUHFkdWtDTTVIOCtRRDNrOERxbEV5Q2k1?=
 =?utf-8?B?bExhRStWTGgwWFFhdUNSVEgvZVplSzlDckhlaFV2RE9GK1drUU41dDZ1U1c4?=
 =?utf-8?B?N1dKUi9sZGxoWnhrOFhLNnQyeFBpMmNPOVBJMWduYk13YWtjNFYxMUs4MzlT?=
 =?utf-8?B?TGZudE1FcUJWdlBVRzBxdnpDVDA2OXE4cFdsWFlVNzlNVkFpSWpZR3Jtanpz?=
 =?utf-8?B?c3l0UkNMZmhxa1p3ZE4yWEh2Q0R2SFdXbDJEYWhLbHAvT0Z0WXZ1T2ZXcDE3?=
 =?utf-8?B?Nms0SUZNUjZlMXYxcmhqTEtneTh3TENtZGJKUTdNNys1WHdQY2tpbVhsM0Va?=
 =?utf-8?B?dzdETnNrSzNvanFsNHRyV2tFaCszSmk5UURiOHJCdXZIR3FHd2ZMVG1mZXBK?=
 =?utf-8?B?MkhYc3FTbVgrMDVRUkU4VjhnV3QyV2pXN1h3UHVvb3g0aDh4Zkx6OFY2TjNu?=
 =?utf-8?B?QVhKdjNoSGZzMEJzSG85VHNoTnVPcG9EVHhMUUdYSXlWUHlNWGlIYW5QQVVG?=
 =?utf-8?B?SUNHV2JjTnpQSVMrU2liZEtDV29VeVJQVkZTSm5DdDNrZkJDWHJKZis3Y2dp?=
 =?utf-8?B?SFg0b05EakN0RjBNZ21HMWxReGdLb1lZWXp3cXQ2OEFyNmprLzN6bWZZLyth?=
 =?utf-8?B?OG95K1JsMGN3RjBab2Z4QzUyeUpSSGlsTHQzQm96OGxNczJIdVRCV25adElW?=
 =?utf-8?B?dlVmK0FFQnVGMUI0aHJlUzRJRVEzcTY5ZFJzQXhmMWRyZTQ1SlpIWExxOHMy?=
 =?utf-8?B?SVE0Rm5ORUpsT2tOMTRHaVhsYmFqZ0V4d0xuOWkvUWViQ1J6N1pLMkhyMW5p?=
 =?utf-8?B?ckw5cWF0VmhGNEdjbkhrYUl4ZThzbGdvdVNvcWlkb3J2RGxmNUJla2pZMzBE?=
 =?utf-8?B?V0lTWGdma3BqV1FhRVpFbGo0WStQZDhjemk5TW9CT1N4R2xmdDUvRWZTbExI?=
 =?utf-8?B?ZHQreDRocVFMdUcveW5JNVcxWndWWWJZbnIyQUV1ZWRqUnhmZVFMMS9kZW1K?=
 =?utf-8?B?QUk2UUttY3RnemVERko5MnFoejJrTkFGNDZ2QVRkZk81TEZ2emxXTlhaR3Va?=
 =?utf-8?B?clhHam5oVnJLSFp3WnQzWThXZ1FlbGM4MUk3Y0VzNFlLRTc1S3FPSWU2MlRm?=
 =?utf-8?B?dWZ2S25xQk5KSnJHQVB4czZMMFNvU2w4MVJKZTdKbjlZb080bjZScldxT3VK?=
 =?utf-8?B?aXBBTVBuUC8yRHVBRW1jMXp0MVc0Z2JlODdsZlNhN2NQRkVQMUlmaklpc0Ns?=
 =?utf-8?B?QVpZZmovcEhtMnNTa1h0U3F6cFNHZ0hHSTdRSHVmU1ZJNXpuOFcwWWVZRkxt?=
 =?utf-8?B?MHpJbmFweHBzbHFtS0dpUTVHVVQ1UFBUaHhzRThSNVZraERkU0FMdm53ZXZm?=
 =?utf-8?B?WlZwcmJzYjg5SnhzalBoaFpyZUU2d1RLd0NuTUcvb1h1VzB6WGY1c05HdktV?=
 =?utf-8?B?ZTR6enhpdGhuQWhvUU93aHJpenl6MG50QW5ZSi9qUGtUanN4SFByNEt0dFRT?=
 =?utf-8?B?Yk43S1d2RXg2TFAyMEpOYy9Mc0cxcllrdEVjcjJtRG1XNENKcUdmQTJoRmlt?=
 =?utf-8?B?T3U2VGhTK1lBdld5R3BocExQQkx5NmUrNjRGNVdWdTEyclNSRGJldz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 910a0dc4-5718-496c-cace-08ded04243ff
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:40:16.2298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wO7bL9TAuG/3wkUI9wKiaM8WCVSn5VMhfByF/Ta9HtORM7z/pm6fFWH0zEUHbb+VPB+gcjmC1ososuJNjRbgDsWZFn2tACvxWhPl6bGypzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7213
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

Hi Marek,

On 6/22/26 2:05 AM, Marek Vasut wrote:
> Fix STMicroelectronics spelling in comments.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
