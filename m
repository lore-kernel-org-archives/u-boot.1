Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357E5CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 16:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C4382E34;
	Mon, 20 Oct 2025 18:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XPciTISh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02EAC831D5; Mon, 20 Oct 2025 18:01:37 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF6182C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0ZaNHM658xzeBA984bGvM/dOV8ni8sGsglp44ybGKRo/dNUBmdLhpGKlNweTWTrsev5WjQB1Z2+jjiEjtemmih3HUkV0d4lKySqE4PZNBWEdiMTU5BfkCZEfIrxyo2PwKn4+c+R+PrS3OBBTuzKfBLCdXE92Ju92eW4sFKpnaALZB2ylnrnAXKP4GgJsrxTttJaYlEL0OggthkqCHEWY+wCehDjXq2k0LeAz/jIb4KTicDvofRO7iAQiVNZ+xt3hmNgkg4jVkHJqgxu+SOBfTETMP6R4QMZhlW2hF+FsxGQ1AoJeNbU+sGBVX94DeOev2C/yOJiwNj4cdWOeUd5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=douSr0Fa84wPdVy1cxz7CgyhcgXpCa08cpLuusUQSi8=;
 b=uSJjXpWv3LUje7t5msPvR5wDLlnuah/qYCgijl+rFkF4Etny8s8pFxO2Xkfnen0pybsNGU9by6Uexf25eduS9G94k90/6PDGbwcRH60RJARY5gnDzN4QV03dZwmcSub+jrd+fVNSiyOgzU7jTAbC4ZCIQ15L+r/p0R2IRrawngkI/TBerS6LI5eiZEfz9TlKV6SzugWRQscoOFGA9nXX9JHFBC0GneUljqNTW7pMCr6Vv63RqVK/kUCHJbmGbKJSXOkFQgavaGI2wnRQzFUllWu2ixzxxt3UIcIR17H/br/mZ6MESEqe6DgRjcw94w1g06XhooUavMH4j1RA7U+nkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=douSr0Fa84wPdVy1cxz7CgyhcgXpCa08cpLuusUQSi8=;
 b=XPciTIShX3s92OLri9+MdLvuu/wWkvV5gh0mUnX8JzmBV5TnTVJ1BzI1evz1OOIrcNO376nft206bN2vIc7fkFSgz5TCu7iXmBPZBc22Jm+xf+NkUIisyP03OhD5Fi3W/9BBviQuNnzD1hnZKKQCfJPNJo/dZbXvrnPPjxXKIbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA3PR04MB11156.eurprd04.prod.outlook.com (2603:10a6:102:4b0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 16:01:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 16:01:32 +0000
Message-ID: <14b0f59c-adec-4ccd-9854-09bbf335bdc8@cherry.de>
Date: Mon, 20 Oct 2025 18:01:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] tools: update-subtree.sh improve user experience
To: E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251015083842.46057-1-e@freeshell.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251015083842.46057-1-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA3PR04MB11156:EE_
X-MS-Office365-Filtering-Correlation-Id: 38466f94-54c6-4209-d782-08de0ff1f050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWJ3MlRNNmtxdjNZSW5KZTlJVVZ3MzRIcnJPYno3b0pvenZWeFpvNzhOT2VN?=
 =?utf-8?B?Y05FekRvbktOdW95cmZwNlliUlBFclR5Si9FRWtyV05CMkRkdVJxY1J4WE0z?=
 =?utf-8?B?aWlYK0FyV0VWNWRLcDEvZ3N4VlFsaWFySklqckJZQWg4NTk5Wm8yNTcwZUsx?=
 =?utf-8?B?Nnc0MjdBN2NFTmlLaDZsUkVwM1Q4clV6ZjF2TzBWbmUrdEdzeG1Kay9MbFNp?=
 =?utf-8?B?ZXlwVHRxRDVhTkg5Njl6emRCQXZJSXJLQkI2VG93YVFuUFkrMWR5RUJwWWZm?=
 =?utf-8?B?dHRBL2JKZWpRMDlwckJvNWZZV0lENWFsTkFmbFRwVlRENkNtOUxNbmlsR05t?=
 =?utf-8?B?MUp4ZVp0aEpLNFVXZzFCMGFoTWhHUDVGWC80WHZkQ3dGdFlRSU1YVGNKNWM0?=
 =?utf-8?B?WGFvNEJUbEFKeXMzSTdpQ2RjR3RFQ295bXpTMDEzcHcwa0hsbms5cVV6eFpI?=
 =?utf-8?B?MmhKeE9YTU9yd3ZrTHVRaWNLNVZSU25zNTZkWkRSbmh0YXlnaDVzNEMzZkpK?=
 =?utf-8?B?UHVwQVNTczV0RnpYRnczdk1ZcGFHZWRxaTNIUTRQaCs1dG1GWnBGamd4elEw?=
 =?utf-8?B?TGFYckZKR0FWUTN3dEFRcW0vKzFOdm5tRE9ydFRqYmVlZ2xWcXZVb1kwUk9J?=
 =?utf-8?B?cnVzdDR4K1pLVUlEM2tUUVJCa0RBeXBiTzU3MmFVcUhFa2lRMXV2OUN0YWk3?=
 =?utf-8?B?TS9yN0M2c1ZlNm13c0lNZFgxRGtnV3ViRHo3U1hDclM3YktKSithMmVla2hY?=
 =?utf-8?B?OHNxM1M2VGxuTUZVdDUrSkluOE5vSTg3aGhrdEJmWmpRN2RDTWtRa2RLVTR2?=
 =?utf-8?B?SU0xbEJzWjJzcnhReWVsdWNrUWhVQjNqSml2bTJVcTVSb2FNVGh3QUN1NkRr?=
 =?utf-8?B?WEZQT1JxUHVMY1FFRHBGUlpEb1E3djN6MXgyMnUrR0RDbytzV1J6Z29GN1Nj?=
 =?utf-8?B?LzFWVTU2Qi9lVTZueTVjc0JBN3F2UWYvT1dwK3BmN0hCZGRpUGM1TkdyN3Ar?=
 =?utf-8?B?eThTWHcrd0NxWmc5QW9JMVJBZTJKVWdNZXZTczN3SzdoeS9WTS9ibXV0MnRO?=
 =?utf-8?B?bzMyQ2xjVklSckZlUEF0c2dzQTgzcStMT1RtU0ZtMUtIK20wd1lPNk42NmdL?=
 =?utf-8?B?QnVDVTg1clNoYU1QaE5Wekwwam1aZlZwYUtYTG5nb0lXWVIzQWo4UVpBWTFB?=
 =?utf-8?B?VVpCemdFYndBNG9oTk52bmhseGIwVGtyaXdkWkNCV05Rd09XUEROZ1JLdDdO?=
 =?utf-8?B?Q3dFR1V1bHVpSlVkUnJwak5GaDNSazIvMWtlakVWTzVUbzQ1ZW9OZDZRSnVo?=
 =?utf-8?B?RlpCa3oydXR3R2Q0ZmlqTWJwWEJialhHMjB0dXlIdXRiYm44N0VWbmt4dFNB?=
 =?utf-8?B?YmxwOXliSndBK3FjTzBHS2RHVnFvTjdveVpCMVRUVEd6RmYzQTYvVm5JRGNS?=
 =?utf-8?B?dHV0Qm5sLzB4NW55Tnk4L3FkVC9IRWZKNkU2U0ZQZCtWQXVSTm1hZGtpT1RQ?=
 =?utf-8?B?TldlSjk0dWx6Rkx2ZkY1bXIyditOdjhYRkVibkFiN1NqVFBSUWk0K0cxQkZp?=
 =?utf-8?B?WTZrNUJnZDh3UmVITHV0Q0krbktreGI1Vjk1WDhrb0RORmRqeXZZR2ZKSTUv?=
 =?utf-8?B?eURxMi8rYmd3NVdWMUpRS3MzUElnYlFiakg1TWhSdDVDRHZsbklRQnIrZjJI?=
 =?utf-8?B?anVUeHRDWHhvWCtoWFlmTEphaWJ3NXl5UWdTcWpHZmVFOU5JNTBOeG9zaFBX?=
 =?utf-8?B?NzVHYWZ4Rm5kdkdmSFdhVjd0Zkx5Zm9QcHZPSW9ZbHZubk5SM09kbXlja2ti?=
 =?utf-8?B?VlVUeGNtOG4vaWZtN1NUdHhLTXA0Rm5VVDlURHBSU1N0WW9uU2t5VyszMFQv?=
 =?utf-8?B?NEd6U3Y0UXJ3SXRLTmN5a09IdmVrWnNseUtockJNUnQ3ckE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzJ3WFMxQjRraFhrclo0akpWb3R4TFdnbkpsOFhZR3R6Wlc0NjdxQ3FESUpn?=
 =?utf-8?B?QS9hWHN5Y3RRN2xqRVBHZm5ON0QvdlozK2c5V1ZaT1hBeTZZdUtPQmMzSFp0?=
 =?utf-8?B?ZjE5aUdobmN0UVZrS2kzYkEwMkdRQmpLL3BodjJFYW4yalNQZEpnUG5HSFFI?=
 =?utf-8?B?Ty9GdTkwVUV0dStaSU1QSXlLcEJaV1pNU1VxNW5KeWdEWUlqYXh1eU9NMzFz?=
 =?utf-8?B?SkE1YTZrdzNZdWoxRkFPUDFzY0xtdCtjSkEwMjRXTFJUd0ZYd0hlSFZ2NVBB?=
 =?utf-8?B?NjZSaG4xNnhmSFdhVVdLZVBOcSsya2lGQmF3OHYxSTdlaGQ1Y1dyNW15VC96?=
 =?utf-8?B?eWV0Wms4QU5waG4rMkpvUVNDcmJDUS9EMVdJNWIxYkhLSWVEQTFIUEhMWU8y?=
 =?utf-8?B?czE2U0JPTUJkYldCRVUrdmprTjE4cDRpN3FpUDV5SXlkN2w0TTE5YU10VThT?=
 =?utf-8?B?UFNFQzlmSWlqemtzYlNRUG0yQ1JtQ3pNZWdKQXRsT3NYZDZBUExqZEhlTWxT?=
 =?utf-8?B?WVhMcWlCVm5mNmlYWGRNbnJnRGZPY2R0K3hHUWswWFl0dDRsRys3blRYaU5s?=
 =?utf-8?B?eGNYREtlUlVLWUxvUTdqYzF4K213dkRXVHVSeklENTVZYkNjRWlkZzJwWTkx?=
 =?utf-8?B?VVJKc1JGa0RHVUZ4RWIyNTUvYzBhSDJxeWFmdlNjQU1vbml4clEyRE9jeVRW?=
 =?utf-8?B?Yk1zYVpIcm83SE5mUDFZeE02bW9jdnFRQVV2WFdsbjVXYjVPaWo1K0tMQnF2?=
 =?utf-8?B?M28zckhUUGVDOFFGWEtwMEhCeDMxWW5oeTc5clM3ZFRmY1RaQ3d3bGtTcWhj?=
 =?utf-8?B?MjduU1RDakl6REw4Qzk0RDhjcnR2VjdnbG0rZnczZHVaeTZCRmg2Y2JNaWM4?=
 =?utf-8?B?Q3VwWGduNmJxZnA1L3VodnVtZy9nazkySU9GcU1xSDRXcE5Nais1VCtGTERX?=
 =?utf-8?B?dm1aNVlEQ2tYWHB6c2pXeWpQSnN3Wk85MlhkeEkrV1U2N2RhQVh5ckVGT0Jw?=
 =?utf-8?B?YWZNOE1FbTdudEtoWEVSZURwYkZ5YTRjSXZSZkk4M3grcEpCT0czL0pGRkhH?=
 =?utf-8?B?bHNYUmFDQnoyUHRabjlFdk5aZ21lOU5NQ3puaWZlU2FHZlJxdWtkTEN6WGVD?=
 =?utf-8?B?bmVRbU5yNlIyRExPa24wWFBEdVlLL05SY3VKUlAwYWVPS3FwOGZ6cjJRU2sy?=
 =?utf-8?B?OXdsRVhZbW9xUzdTcjNxT3RGcmhwUnpZazgrdGFQeWthNUhra3hOalgwd0ho?=
 =?utf-8?B?ekJYdFZSNEdacmN0a3F1eFNZSkxuWGZYeitGMEQyWkZYQlF2Q0hpOXFiQlgx?=
 =?utf-8?B?MjdBWGhuZjIvZFlaZzlHVXUyeVc2RXRMTjR6MDh3MC9ZaFVaS2FlQ3FyZmNE?=
 =?utf-8?B?a3VNaUh5RWhaZ3Q4dFpxUHJrZmU5VDl3a3Z3cUpiRE9XVDh6K05wS2xTY1Vp?=
 =?utf-8?B?ZXh5b0N1NUw1WWVvQjBSc0NsSCtFRFoxaGw0d1ZUdndmOGlmTmY1bG5maGdj?=
 =?utf-8?B?bHR0dHB4WFdhaXpQUEJvNDhFZkRwR1lVZFk4Q25NUVlzNGRUY0M5eDhScUEy?=
 =?utf-8?B?c3hLSDVyWlFzVkdESllRbjVhQm9MLzFXTVJZTnY2cFhKNUliTEo3QXJ2Nnlk?=
 =?utf-8?B?UXJ2VVR4UkJwZ3JtYnRxWFRueHlhdWtnenJ4Uk16QnhhckFTUVFLWUo2aTVH?=
 =?utf-8?B?Q1ozdENVMWZZZkMvL1pJV202OUtPMGdNSUhiV3dKeFRTY3Q5QjR6MTRtNGJy?=
 =?utf-8?B?UW0vcnRiR2pXUDNWREcxd3ZLNFFFWDRYRERLQW55MitrUlFZb3JWKzV3Qmpw?=
 =?utf-8?B?NGgydkdmY3pjS0pNOSthYUJQeFZLNUNFUTJaSjZqdmYxeDgwM0ZDZWs2dUpk?=
 =?utf-8?B?SjhpN0hKRHFnSHllK1RpQm41UkU4UVpGRDNsWjR6RXcxbmh3bW5DQjhmdVNn?=
 =?utf-8?B?YXRGOWFrazVWdWZ0OVdlQTdOdUpsbExScXJjU2N2RVd4ZVVlbVgzY2ZncmVa?=
 =?utf-8?B?Q3hyOXVQeHhRTUxySUR6bUdDdGI0RmNwTmJtUTRnVUl4VlRoVnN1cXNwL2ZQ?=
 =?utf-8?B?YXBkTFhLSDAyNVB0SXpjYy9IZVpEM3lxZjBqSmJHZ1J4c3ZVMUxCSTZibnRE?=
 =?utf-8?B?QUFVMW1KSjROV1FGQ0w2aVo5MVJLM1h6bXdPaHYvSDRmYU8wVzJIWUxEeGxI?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 38466f94-54c6-4209-d782-08de0ff1f050
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:01:32.7904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTOswvrcN0uo7pZytBlW6eqA7wFWr2UhiEGMjmhIVWEYwqrV7XgLUS4gYtbHKShDulANMyt2Wrvm/juxrJ0ScKcnlYsI58JvuOHDsHYMtiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11156
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

Hi E,

On 10/15/25 10:38 AM, E Shattow wrote:
> Makeover of the script:
> - Usage now explains at each step what is expected from the user.
> - Default branch name is no longer hard-coded and is queried when omitted.
> - Additional operations 'update' and 'log' close the logic gap between
>    expecting the user to provide a commit id and where from this commit id
>    should be obtained.
> - Use 'set -x' context to show git invocation where appropriate
> - Sort options for usage output
> - 'pick' operation detects merge commit id and displays suggested commits
> 
> Additionally the LwIP remote is now using the Savannah mirror system:
> 
> https://lists.gnu.org/archive/html/savannah-users/2025-05/msg00002.html
> 

Please try to split changes into multiple commits. There's a lot of 
unnecessary noise and it makes difficult to review your patch otherwise.

Here I can identify:

- Cleaning up the comments at the top
- Removing set -e (why?)
- Moving print_usage somewhere else
- Changing the output of print_usage
- Reordering cases in the switch..case for the subtree-name
- Changing URL of GNU mirror (which very much looks like a typo as it 
doesn't seem to be what the link pasted above says the new URLs should 
look like, albeit working somehow)
- Adding new features (each its own commit please)

You also do not explain what your pain points were when using this 
script. This would be useful information now for reviewing and for later 
if/when this gets merged so we know what kind of confusion happened in 
the past so that potential future reworks don't reintroduce the same 
problems.

If I remember correctly, the biggest issue was that a pull dts was 
attempted instead of multiple cherry-picks? I believe nobody except Tom 
(for DTS) and whoever are the maintainers of lwip/mbedtls for the 
respective projects should be running the pull option. The diff is too 
big for DTS to be meaningful so for now Tom is essentially pushing to 
the branch and then notifying people on the ML that this was done and 
that the new base is available in master, c.f. 
https://lore.kernel.org/u-boot/20251008220903.GM298503@bill-the-cat/. 
Maybe we should also be conveying this better (including 
https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing).

Cheers,
Quentin
