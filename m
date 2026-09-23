Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492D1C98302
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 04:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55FE3406AE;
	Wed, 23 Sep 2026 04:25:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aWgSYqECQdCa; Wed, 23 Sep 2026 04:25:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 84A0D40611
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790137537;
	b=tYtvhvzwi0RF3XK387hHT7k1mZZEHy8Iky5W7R45gkecxeOAQcNzuUJal2cdiz1zHe5W
	 k5WqnG6YWDE7mCAu/tMCQDVK0IiqtoRmIIo37ItpP/pjyNrXDKFmbp6ot90oIKFM7PsKV
	 Y/7lMRdxlh0ls0x7EdypKd+AABYuc7xLQnhOqc5OAZciMeKkLePQleq6ADHuDissL66Vy
	 iBzB7tQWxj61cH6XpShNB2w5jgEdQR8XzsgIoMXDsU0ceaCjmqc7YP6/fhrUTspKuLc9v
	 GZ5mcoNEFb1oMk/DTnQ4MQMLew5fsscI5zg1XPb7uh4RhoBWfT4eOCDEhPDIyLVP0XA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790137537;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=n6J2TeFzlNv+kiZM4oiOFFcvbK0sNzaPkmdhNxYh3dI=;
	b=elfj6DGgWDb3TDmEcZFXm4YIDgDRA85EnVM7yOGCDgGkN3vLVa+p0cM0kdTLg50PX09w
	 fh8Dz96/KToqCanBVkri87CsSjJ3cXJqF90b8xqq2kqU1NFZs0sryJtLSzIQnwsLGGxA8
	 EjFfL8TJkAtnyKztGrCaHwA8bvRMP3YZAyM4u5kEs7PM1MNFKB2izEbP+cFLqocTN1mJQ
	 ql0HTd3a7Ieew3Hz6F204eiTs0W7UGxsQMfhzcFmHasEF6A/ETxJwpo/GeXby1KbWkqiG
	 wMjTrZ9aKmPnJ5n2jVXwBvZLo0WqsoYE5kILcwtRsfauLFxqAkmLl2tuuGJo+p/9BRw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790137537;
	bh=n6J2TeFzlNv+kiZM4oiOFFcvbK0sNzaPkmdhNxYh3dI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PwzyEADP9zzKsIMDJbeAJqGSWdlbBYaeOrzL3bNjKSQAkQDQTMYU+yYl+r85S6UPQ
	 6p8GMwHFG5PqCYfYA0QUM7AHWfv7NKy5eVgd2jP1Acs0en17WMntgyUT/k4Ebnq/Re
	 mzDd05aZdD8HCVd01mZRUXvrWxSSHe+/c3gmBWEhUNeWBDwFjCdZIKnGG1bnUH8p9Y
	 pS+IAjmZk/4BEnF6EwsDo8NvEek+0lgloF3nbhk0/1S00w7rWqwQaNnw579EZQm4Rx
	 Wa92pU7cFUdGU3qz7wTMxxnJ+k/Eh9A4NUHFvuMqODbOBYM5abZZN0YsxO9ROqiAV3
	 r2brVX9w0504A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84A0D40611;
	Wed, 23 Sep 2026 04:25:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D3FF13B
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 04:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EFA880D48
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 04:25:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H0aMdXji-PnJ for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 04:25:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2177A80CA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790137535;
 b=n+DWYlY7eT3v6oKGRBP5kfpGhGX7u70gFuYOpzji53EWJvifojl7c7li9Wq5jAG9YHwh
 L1mUsOP1hD6+mWTHblVEupub/Y7u9cku2XmG5NFqi7PDeF45Ogv1YhIouWFLZ++HabkWU
 NAcUmy7UPc4z5NzcoSI5YojNCqW0oAJ6dekZZCAN37tRay/X4lMFAKnF/B0cemj9tRnjX
 2+W2bxh4dTW+37AAfqbkeuFGUvTw8lVrPaS0JcMdltkUUvlnOBfmZBjlJSOy5glRjPQeH
 vVl0ZMHk1z3xasRxQBR9XuAyamsGMPOK/o3lrf5gHtm5Ov1Yv60nVD6IcnQsxvn8rEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790137535;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=n6J2TeFzlNv+kiZM4oiOFFcvbK0sNzaPkmdhNxYh3dI=;
 b=dOw+NZQMSb4VdSpVx7RkYWlmdxWvvWksKmXHcZN9QvI9LZbSO4rjb55yu1GZBLlq1OCp
 vU6QyJdgJWWpK+EYJAavpetrVCIGlFukWfUBKn2o/ZfLFFOfeRdJ2KhRQ9yqrGCg7ctm/
 sdgI6uEO4e6cLy/gzntzjpqbcZrRSff5EymG4tc4JmxtwbJYBukINm3NG6j9JeqN//xzW
 nmAHWaXo/Eo2stTvgM5eobgsArobFpQS1clRg4Zs8OHp/e5VheWbOUj4rv03dUnwjYDri
 bvBLeYE7jgyEhs32FCPRMIn21T4Aetttp5TlFa5ZPfez28mOvQXuP9f3UiStdKv2Y0g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com
 header.b="cq6KLnt/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cq6KLnt/
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2177A80CA6
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 04:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/V6uQwplky6gogMc7bQRjfqPboqFEe19aGzNAMZ8d+NCotVzVYEujS/zMw9ugxxWxiwUoi54cfYKspD96tEFGJIAc3bXMbbYMSIWPis2W6pdJSjGknEmq6prKZywBERYO0DG9a2dc4j+ZslaUoyVWoG0sDKKl6Drjiy2afWZjX270a70tIHoWQZRjx9oXsBAX9uqNWrKMYvusBU7ND5x6rJGNmsgmIO3ESo1Jx6t/5Vc4nbPktJXLdstpuz1gId8I9M3YOZb6p9bPR2xl/ot+CFsnZUT8Lmjrq1UIf2vecq+GWuJtXIXOCRFLinC8qjxAzpDeF4k6zY3sTbb45rVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6J2TeFzlNv+kiZM4oiOFFcvbK0sNzaPkmdhNxYh3dI=;
 b=kwkBnKY8cl3tOghJdJxQW7XUqPyg8scVPn487d2O0RcH3OrtmmTgHhNmZsmNZfvayPVtT5e9UVpdxsbNsK76LO8zKSvZqskgx1YhFOyUJnc3PhYLwMKMi3dxpztsL1Y6MPdfooXNPgDNYVUPMgievEnhZykEmhqvtJWUdEJIG5H/EjdPsClM+Nq2quM4nowfvBrRxy4eRd0zkrKPH3UsDJLfhgHsMdXlJiV8aAXD+aAUnRcoJ8gITGc1w5EsGBC6M4bwQZL4PshAQF4B/YMnvsYNGmYZZqJJr6w5T1Ja3iOgcqAWSmOhdWefijkVel7AAaJ1mozEJ55PT1iFEioA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6J2TeFzlNv+kiZM4oiOFFcvbK0sNzaPkmdhNxYh3dI=;
 b=cq6KLnt/ll/Kt2hzCUDRN9vO9JSVHHBq+oL/Htu0TOUbYkTmYqsVXZMHI+fobv/Jsw6dtj/WuPZfWX5OrH43JY3XWxb5LFs9F3JGv9cUZNC7yXbYWLcci7K8W2MB+LwZhbMXeQmlSlBtpkBNZaNERTP09Jad28+3o7q6R1+/kxYFrcKxM4uVy7gpPjw4XO7RTcHo1an1xVlvbHz+BsvUOcSMKLIWPzPyA3JOM13w5+FM6TwovM4+9SQitr0cD2Giifg7Y3N01Yb0ptNVWab0HHuNnZeM4lUtzgJfanZWcYXbLSXUKdVD1Mqr4aIE8ySYmFZcuR2OGlruggVMNOD1gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from BR2PR04MB038925.eurprd04.prod.outlook.com (2603:10a6:2c8:4::23)
 by DU4PR04MB11056.eurprd04.prod.outlook.com (2603:10a6:10:58c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 04:25:28 +0000
Received: from BR2PR04MB038925.eurprd04.prod.outlook.com
 ([fe80::cf42:7e5d:19:b8e9]) by BR2PR04MB038925.eurprd04.prod.outlook.com
 ([fe80::cf42:7e5d:19:b8e9%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 04:25:28 +0000
Message-ID: <107bfad5-a283-403f-a241-20d6c4515b35@oss.nxp.com>
Date: Wed, 23 Sep 2026 12:25:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] imx95/94/952: Enable early icache/dcache in SPL and
 U-Boot
To: Francesco Dolcini <francesco@dolcini.it>
Cc: festevam@gmail.com, u-boot@lists.u-boot-project.org, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, qijian.guo@nxp.com,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
References: <20260922022406.1838737-1-ye.li@oss.nxp.com>
 <20260922053742.GA8706@francesco-nb>
 <b914014f-b904-475e-8903-d8c9505aa896@oss.nxp.com>
 <20260922141839.GA242194@francesco-nb>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20260922141839.GA242194@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0007.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::10) To BR2PR04MB038925.eurprd04.prod.outlook.com
 (2603:10a6:2c8:4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BR2PR04MB038925:EE_|DU4PR04MB11056:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f27d769-6510-480c-a055-08df192ab242
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|42112799006|19092799006|366016|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: A3S9gJGqEYPeFKMXkqGINRbXHdmgHkQIou2R9t5haGLu/8kMFejQa0ucbFQe+oNkYGqeAbeoCRCoc0QmS5K9gkTvfqCEtN/r3YBCn9nGwDVtcxplur1NAKJsv9v3qm+JOGJ6jgeQEZvJPfwGci23ekHyTEiSJi4Uf81nYUdZfnfQwvxQ+l6OMMVXLLznWBVgB8HFQmeQDtvnG+naakSa7BYqAr8GRNVfKuW1MDqeELOqFTlM/DW7gou/3fy32h6ClBcmhQmOalskBAMEGmmv/sHCC/3z2QwMBsZonPez13Bm7LX6LQOedLy98jGBka8THQrURx6Qc0Q2PmIaL06EjkeM+8LyD8RubiZf04xw3is402ZlfQpfpwA/UzCc0ri+I27L4gKsM9DYSo3TyEygy1InRmx0epMQhoXONg3VqKu83Ncmtj/N5/4Z8cvOB5e4v9zquuV5NeZufvAYO5g+f/+QEnsg/2XffY9qGu1LcbwbnZ8fBN4yUtvsm6E0lqJZdqLH0/ut2gM1z3iM8CS0YnO4GCZX1riVmJwAWOmt/TCl/ZxW5kpletbujYcncu+LSFamlNJEJe2xm9PlXGfMBdI0HoTsRaHzdZHjrZlZfzWy4nAwt06pxcxEst0MSrGCoGc6p/+3R3pfcVGqyvX4fNrD1SqbrUOIVoqww8tEgB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BR2PR04MB038925.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(42112799006)(19092799006)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjd0QmVYVGVvdGR0MjZFSi93dU1mSm9iN2JrR3cyK0VoczNPVWlXR0hwVEI1?=
 =?utf-8?B?bnBvUHNLZzRuTVE2WVArY2tiSXUrVDJUMCtxa3VxMHZ5U1RrWElUQTFnNlVV?=
 =?utf-8?B?aW1UWURlVXBVRkNqbFNhc1BBdDJwMWY1NmpYSWhIa2Y1djQyTDh1aGYzVHJY?=
 =?utf-8?B?aFFkd3Y2Z3pRNS9KcDA3U3hvU0R5RlFINEZoZWU0OEVnOEF0dUVqYzNqQ3NC?=
 =?utf-8?B?MU91UHpOaDBVVjRXTmV0OWVXSjhLQkxFaWl2d0lZZVhwTUNmek9QdlkzQnF1?=
 =?utf-8?B?bCtoSHZjbmZGSGVDdk9Cbno4T0JaZm5tdFpqUjY2eGVPRDJVQ2tjNUdsQzdv?=
 =?utf-8?B?R2ZoTitiYVc5ckxtZjVxcDg5eDZNK3pabTBPUm9RcVRONDlkaXovaUNCVlU2?=
 =?utf-8?B?ZXlSRWNpeE81NUUwU0s3T1NmckUyTE5mazZiMVUxd3VJWmxTWk83V1FpeGpG?=
 =?utf-8?B?b01tViszNi96b0tEUzhyeHZaUnorMThiQWYyWGlJeFJZZlpuY2tRbDlROUFj?=
 =?utf-8?B?WWhPVUJTcStUTzRRcG03US9iSXBSN2p4T3R6eDFIck9oOHh5cTRLbllUbnF3?=
 =?utf-8?B?UVBJWEt2MHNUNDNmaDVTSFpHR0dKV0pmTW1hMy9Hb2Mxb0o0OVUvbVVwaXJI?=
 =?utf-8?B?TkRqb1FPQUt0aUpob3VlVVp4d1V6dDlxZ0phMmthT2xMbTNQMUFJTElERlRP?=
 =?utf-8?B?U1d2QlNZTjFTRlFOemFuemxOY2szaVJVWTVBZnoyVFM3THZKNlo4V3Q4OTc4?=
 =?utf-8?B?aVdkU1NrVkt5TmxKOGMzZm0rME1LREdoSGpQbnB3c1FoZ3ZLK2RYWlZVSy84?=
 =?utf-8?B?Qk1DamIvR01PS0prTFo5bDZRcFpPQnlmZ2JFOUgrdHgvdlgzcDlSdmo5cWpp?=
 =?utf-8?B?WWJ3M0s0RXk5dlE3VGk2UnA2MDNkdlFBcnhpcWxsQjZyZFJndjNqeGJZUU5y?=
 =?utf-8?B?cFdOSFY4djNoNUpLSlo1SmdVY1ZIcjh4em5RaDVFRjg2VlZKNHpZbWxUd1Vn?=
 =?utf-8?B?a0pUOGtoMFh1Z1hKSTNKRnFTV0RtUjg5QzFVamRaSG11Z2lsZ3JLRXlBMDh1?=
 =?utf-8?B?RmlzS01CaEhJU2FIaERwdExvRjJxdDQ1S3FONjA1c2RnajY1WEhaWHpRRVpB?=
 =?utf-8?B?WDhJV3N6MmtoYUg0ZDNURG44TDFtZHFmVTE3M1BGVlg5U201cTdFcjBUMFBV?=
 =?utf-8?B?MTcvdnlxdEMwY2VsbVBHRHhIREVvTmRkZ1F6ODVWdDdQU0FxYm5hN0ovRnZz?=
 =?utf-8?B?OUtKUk43YklZQlNCdXU5a0JYUWdaMkUvYWxFNjBJZmszV28wbTRvR0VDcG9a?=
 =?utf-8?B?eUpDTXJLY3JmNVlkMVg1VHVPaFpaaWwyM1UzbGFoTEgyY3lnQWtpaXFQVm1O?=
 =?utf-8?B?WFNmUHdoUTJPLzVBYzFINVJHSzQyNkkxZnYrT3NLaU5UcUUzQnFkRXJCTng3?=
 =?utf-8?B?ekZPamsrQWxtQURYR2EySFdkVkp4YXA1QWtXYUJvVi9CTmRHRGs0NFRLbHJM?=
 =?utf-8?B?dGZiUGsvYW1iQXl3QXIxQ0tOWVNrVDBhQVA3ZjR1Q1BoZEtkT3JoYUNVelIz?=
 =?utf-8?B?aVZ5RjNSNkFNeFN4U1JPWnN2Qk81MmVuTWtWclY4dWdlblM0QU9QcGxjbnZO?=
 =?utf-8?B?VVNaVnVpbUYxbEJxdFAvUXMwVTZIR1JKQUNHZ1dydGc1RGlWdXlFNU1URS9K?=
 =?utf-8?B?bUpsUDgyaDhyRWJDdk9OQzVlUTdiYU0raXJ3Ym1VaXU1R0x5aFlZbWt1aVEz?=
 =?utf-8?B?ZlhBai92VmxOSDZNczI0OVEveTMzdWtKakNHQWs1MWFiTk0rWUEweGM4OWFh?=
 =?utf-8?B?WTdmZkZNMmlWWEFlZEpvU09ST0NDTnNGM2R4V2h1SzZ2b0FsaGM1akNjeGFy?=
 =?utf-8?B?bG0wUC9FeEtmMlNha1VTcjBEdG9TNXlnZWRwYTBtWmlUVXRJU3dPdXY0c092?=
 =?utf-8?B?bkJFLzN1aS80c0haZlZ0ZlVOdkY2YTBzaTY5Y0lzeW5qNktCQTdSR2tvVTV0?=
 =?utf-8?B?Yzh2SWJUYkhad2R1bHJzNmo2SjlaRkhINVNKb0ZsR1BSc1VTT0VQcC8reCtQ?=
 =?utf-8?B?QlFhcVNGelVpanV6ZXFkWFljSVlUSDkvcmF0d1YzOUR1cHJWUWdzNFdPbVR0?=
 =?utf-8?B?eWNvQ3hZYW9RNWlGbm4wa2J3MlNpc3YrVmVVdElBcXYxdWlZZ0w5bVg5TnNH?=
 =?utf-8?B?a0RhQnR4THFweS9JMmtSaFFycFZCNGZhTnJPNithNVZGL2pmd2pQQTNJMEw4?=
 =?utf-8?B?UlJHVm9RM3NSUDJtNzdFZHcydGR4bU9OSGlUMUJMTHRWMzh3L1RERXdhRGc2?=
 =?utf-8?Q?xULI6S3aX+4uKg5I9s?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f27d769-6510-480c-a055-08df192ab242
X-MS-Exchange-CrossTenant-AuthSource: BR2PR04MB038925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 04:25:28.2844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZwNqJlqPtcOKZ+Nk4ocNOf/Ca+k/hh1h3jH47w5imqepjYAXq16FqZxG1twMbL0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11056
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

Hi Francesco,

On 9/22/2026 10:18 PM, Francesco Dolcini wrote:
> Hello Ye,
> 
> On Tue, Sep 22, 2026 at 05:32:01PM +0800, Ye Li wrote:
>> On 9/22/2026 1:38 PM, Francesco Dolcini wrote:
>>> On Tue, Sep 22, 2026 at 10:24:02AM +0800, ye.li@oss.nxp.com wrote:
>>>> From: Ye Li <ye.li@nxp.com>
>>>>
>>>> This patch series enables icache and dcache at the earliest possible
>>>> point in the SPL and U-Boot boot flow for iMX95, iMX94, and iMX952
>>>> platforms, significantly reducing boot time.
>>>>
>>>
>>> You did not update the Toradex boards (that are the only iMX95 boards
>>> not from NXP currently present in U-Boot).
>>>
>>> Is something that should be done?
>>
>> Yes, I only update NXP boards. By default, the u-boot early caches are
>> enabled in the patch set, no change needed for Toradex board. To enable
>> caches in SPL, Toradex boards need to update codes like patch #4 to define
>> the CFG_SYS_SECURE_SDRAM_BASE/SIZE and move arch_cpu_init().
> 
> Is something that you can do and make sense to be done as part of this
> series?
I can add a patch for Toradex boards. But I need to confirm if same 
CFG_SYS_SECURE_SDRAM_BASE/SIZE ok for Toradex boards. This should be 
aligned with full DDR layout and related with your SM cfg for DDR 
regions assignment.
And I don't have Toradex boards, need you and Emanuele to help test them.
> 
>>>> On iMX9x platforms using SCMI, the DDR size is not known until the
>>>> System Manager (SM) is queried via SCMI during DM init.
>>>
>>> Emanuele: is this the same also for Toradex boards? I think for us is
>>> different. Any significant implication because of that?
>>>
>> The default board_phy_sdram_size gets the DDR size from SM. If Toradex
>> boards don't override it, you are using same way. This allow single u-boot
>> image working for boards with different DDR size.
> 
> We have the same binary images using the same U-Boot/OEI and SM and
> everything for board with different memory. But to have this we had to
> deviate from what NXP does.

Emanuele sent another email and mentioned a overlap between early MMU 
table address and the alias address used in Verdin board_phy_sdram_size. 
So I plan to add below change in v2. Please check if it is ok for all 95 
Toradex boards.

+__weak unsigned long board_early_mmu_tlb_base(void)
+{
+    return CFG_SYS_SDRAM_BASE + SZ_64M - SZ_2M;
+}

Best regards,
Ye Li
> 
> Francesco
> 

