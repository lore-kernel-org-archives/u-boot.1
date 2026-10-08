Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA0ACA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 845F04092B;
	Thu,  8 Oct 2026 22:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tm7TcN_UMTmi; Thu,  8 Oct 2026 22:08:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE3214090C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791497310;
	b=V0XEkOyBfEOOeSCthPWyJP9ggjnwhJ6lfmMT9MVK1pVs4v+nxhDVPWDP8yq91ETBSJIU
	 B+xGAdQc0vQcv7iiDDTCNmHM+3RFY8F1oVQzvZqUkyV9dgPCdvGRoBm2hHhZNmu1jU7vp
	 KeyG/7BlyAfOLh8+1iCAhSBYgoaEBcZ3EydfD3hlUhCAPBNlBfTZxXid7rtb2QjhH0pY+
	 W4cnq6Gl+Fh4+2uNGvVxae4zqN4vfeGrwjj8kkdrcnQ/Hv97TEQ7iyoe0/HDFzh6fl/UA
	 qK09pIByy1tZKRetyMsiFv+w9XAqkL4LTqoLUgP/3ifOxEXWgPap5oBuHCNlEa1eX5w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791497310;
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
	bh=NSSJRfqEW8/nCPgOfa/fuMR/Dx5SKveqJ5M8tiLCNiM=;
	b=Sh5Icx8iu6tUDkZuD+B5F4V4TaBe9N6PXM+L7MCpwfWwn+RE40QB9lNMXxR6LzJ4rkkj
	 Od+zTCcMDUT39renfIPnii97AdAES3+VGgSCI3OgyMVh2ImwM8WUCBaCMFuSo6Zepkav6
	 uHXhFi+qZr7JGCJPywcLZvIQpRdqHEd9UA7TQ85eVOlKN8/tUX6IdpG3egFpJAw1lIm2o
	 54wR9tVofhz6vRBG1JyZDtHWtAyupSc/FiunKCI701uaTSwLjNsA/jo03wPl2NMrEbB4c
	 7W43t8ymgnF5U8tLAjgAPZWRb4+5FCF2AHOXG7rMaJQIOuqGWIvZkQN7yZTDLPw9NLQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=QxI9xVfS;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791497310;
	bh=NSSJRfqEW8/nCPgOfa/fuMR/Dx5SKveqJ5M8tiLCNiM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OlxnxlEXQErtvpFvD8onFajGBcXVQ5Br7cz/prxP63O92tt54RGMH6RQ/U1Ip2xAj
	 z/qTK3kZrEqN3ZfT3pAxS9l3Yc6DdpFf6fAWez1lXsWml8HzFUvqPxONJ+6nhnbIwK
	 fi0nEULx9QCjq4MUQnURQBlIhnr7xPcSsR76not72hszPy60n+6NnsRvXvhJxnLkVf
	 iWDGT/3/fJWXI96hhRTwLdAriDAVWTrMHshWZ5u+HJ+OrZSo9PUL74z6TvJMOS9Fj+
	 0pGgVeVicM7inaVMo6vf2Wa1c3XKUBZWAi77IYneTxNqvDeFcSWxbvR6Om43vgDc2d
	 kfZG9IfkfFOrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE3214090C;
	Thu,  8 Oct 2026 22:08:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF38E156
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94E8F4090C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dUU-lUlb15GK for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C19740871
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791497308;
 b=CwVR2W2PwsoFhtZU4jNf+6Cdw8Vfpnt4P8VjHuesUKkHUwpWZV8ksLpw7+seh4/gvlyH
 AhIRE19cZ+zdvA5uuX1KG3Ql9yHg6QMvlkJMZN4P4AIcp0GKbCIvkXS8agjlCjUt+Ce0D
 DyRMTu0/pn829tVQFkR2GpCaQ53rcG1GpyHvYJo/UVmBSReSpAg7gKNo6RwWDGUfgwdZ3
 33HHiXCTr3cDqWvNQODKbVWqJlkeft+/Z75LQSF6oB8EyCziyZlKNSJrZep1uc5hoAH3/
 6ZTzBbYAvP7mQkP/jZ+bthv/U+SNZRV+piFPAl0SoV59IzcVAhCQ3aS/A54KuYgdgcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791497308;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=NSSJRfqEW8/nCPgOfa/fuMR/Dx5SKveqJ5M8tiLCNiM=;
 b=R+KU4SxUludwHFhYf1e7n+r8EH7bRDIHYQuaQMorE75rBTjG9e9a5ugrOjHRABJbL+67
 9a+RDQ6EK2P0GjSqbXa5kVTyksDRgx2UQvCeW4CKfIp1LwNwu0rKeybFR1DAwgwcN8xeq
 gjHTMofkr9pOpxySoHlRlB6jUv5M7uvRxldgGihVYDWyatc4JnbmpIiyPKSYcKZzaeXJ2
 HppNUUn4Em2Z9SewceYVHAEMNh9Iw7epuz8m8pVBaIYuWCNRaVu5atRQqAvMrVHkjQeqp
 nvnRJ4x3K+5WToznnHfMoi8Qy9rFvK+aO6MgrbvqMkSFdLO/5naxj98TKLQD89htC2w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=QxI9xVfS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=QxI9xVfS
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C19740871
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7+525ogcbFEAARLtwN7C5ZatTtB7G5eq5XzQoE3j/UDB9zEOzFE9coGWWmI2jCzVjEu0BvleAVtqyThA+7iG7GocaeItuUhW3b/Z04Eu61UUG2Dn/kAd67F+AJbK1TYQswiJA9yk2WwOKRrPjJ8UvvpWJn1mduSVcqAu5bn830jA5Eh+g4tZwEMxgAmTKRiSYcGLPyA9Vip2yq5Ansv3jQG9kYSPAEvnXvwtPeBG0EFaguT3CrA2YVLHHmFtW4HLdJr1JcmS62+xnoQDjvwfGQLyLwJ2WwdZ+kv7mkLDUPqFmhukWYuVlXPxvRYbni+YBqtZcJE962Bzde5crZvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSSJRfqEW8/nCPgOfa/fuMR/Dx5SKveqJ5M8tiLCNiM=;
 b=Ek6jNM8RxqW8jM464EWn0mSCo9KXhE0bhm/w/fZQXDFmMaW7PVEhu1aJ4BH0M7XSY/l0EazdurgLAkZaMdiW9Ut5uucVLK0Zk7ThhUsz3qTet5eBQG6Q7g+eHQKBCGYk06s0tDkTQxDBra5EMveMfNe7oBJNKN4A6mb/PLOzGTYKusGC2/Mp3EpujNgFRtk5Xhrk2ldPWeZzy5cVZSTvsCexeRDAGBd30BxR1cUXfiP/WCgMSpuMkJVYZq/JUkI6+3RyvroIjVfinHcHwD4CnWU2sjrD+cTk5AB8/oCeBRCvGMfCvr4ofIrj32hr4n2Hu0s4zpnhzfULVSqEUpNRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSSJRfqEW8/nCPgOfa/fuMR/Dx5SKveqJ5M8tiLCNiM=;
 b=QxI9xVfSTwVSQ1dVYXZxAcv6he5GymiIwKLYu2R9XP+6OYzOUsjG8uqTZszoyL+EDoo8Wxtr8KecpoAoB90/aifKHhJPTmZ8u10zfO/QYZspCp0VShwIMiWxrUgl2gAEGboCzxcyHCL9igSej058YbPpblaYIjdfTn3yBUA3LbU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAXPR04MB9218.eurprd04.prod.outlook.com (2603:10a6:102:221::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 22:08:23 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 22:08:23 +0000
Message-ID: <b0e408bb-4a3a-43ab-badd-93718a963584@cherry.de>
Date: Fri, 9 Oct 2026 00:08:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] rockchip: rk3506: Remove unneeded syscon driver
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-9-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260804105721.2402406-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF00000212.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8d3) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAXPR04MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: bac9eef1-e107-4509-f896-08df2588ab45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|56012099006|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: eLjU1PKTdY9gJms9PdVyuit2h8t7JEhCVcEBH+8sM0TXQeVbsViSQLfI7KZUh2wU/dxlU3d8T/vxc0XhqezcsZAvC8JrhENExbOCHANyi4e2upciQgM7bnDjTZd/LzELMScFkhD94yFAlLjuhfjU5/ls30bz3o81hht8jVYxT9UUdi3Ia78G+Jrdd/JIELifiypXhbg5TqRdobooqj/jtl7grCdCljDdvkGwmlIpT8yypfaf4En9TCr+iLRG2MZGsziC+GVBzT1ovFWmpuhjljRhRsldOMLFPw50bVdHyM00JNzdKuNQX3bfAjSP4SjUP+WaMZBSqI8ZIW02oFaPdRbWTibVVvNfb+1KQRURGH90wtFw5vz8/trO83dR0U0Q37HzxIjQCxa840ejC1knKalNtd9WvB8j6TMA4HESdv6cAX+HTVWOv/D5KUs5pOUVNEmLlge1o6vr49JNqX4qOoTZ8eij/4JEaDJ6SktEhicNQwtueRPIpdmxa/Fbf3n3CA4D6PWpnZFPyhSBd61pbBSBR82hK0/5/OTH3kKGr8r8c5T+MOJK8J8/k+A65DvxvdKT4/fIGvkCYBFmRWmwSRR19gPNFucr+G9abB/u+HDjDx46Dju5w3SrDwrKAukJZlh3xS6GZYDVoL1HU/89vMaXPmCQivxG182Tez8BP7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(56012099006)(11063799006)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0V2czB0LzRZRXBYbWxoTFF3aGxuVFBmMzFqMEQ4Nk5RcmQ2em12N0JUSnY4?=
 =?utf-8?B?WE1YSnIvZGVkbmJZK0tEakk2OXNTTER1VzRTT1ExS1hFSW1RUHNlMlBXS2Ez?=
 =?utf-8?B?UmJnL0lGTUxoNlExOCt3NWhFOE9SWHRORS9scG91emlkTnJaWWVmNEQ3OFEw?=
 =?utf-8?B?MDJJbGpOVjBzUG41YUpIRmNiazc3ekNzRnRBR01sWkRZV2M0bEZvSlQ1YTh1?=
 =?utf-8?B?U0JSVGVTSGpMazIxV0xnYk1iS3hYS0k2eTQxKytyNGFFMEVjWjB4eWd4VGUr?=
 =?utf-8?B?TVJvdGlEVUZOOUNOeXA1aXFwTy9jc2RkY2RRM2tFWXBIL2twaWdhK2UwMFly?=
 =?utf-8?B?MkQ4d3lzcmc5Nm9WcHkvbVZmM2RmTGU3azZJM0RwdDh0d0hoa3lGRFA5NnZD?=
 =?utf-8?B?bjBXakp6Y1dld0h2RmdsSlFra09WUkRxVUlhZUVxY1lhbExGeGlwR0kxcFN4?=
 =?utf-8?B?RE5YV1M5aW04bU1MRkwxZ0xPVENWOXpHRzV2c2t3djlTeUV6ek0xaUdlQmRT?=
 =?utf-8?B?d2ptbCtjRy9qTkhoRUJQeUlENG8yQU9DWlB2T0F6WCtoNFlQNVFyekZ3UEsw?=
 =?utf-8?B?QzUvVEh2NnR6Y0FpeVdsYXVhcGxoWm10S2F3NDVWbkI4OExzSWhBb0NDUGdn?=
 =?utf-8?B?R2VFNE10Rkw2ellRajJQVklMQ3RsdTE0YVRWeS9CZGRBRkJHM2tsZ2FYRW4w?=
 =?utf-8?B?SzFsNEhTOVMzLzlKV2dTQXAwMEpNVG5sVXozay94QXM0ajRFbXdKMmJSQnUy?=
 =?utf-8?B?SlJ1QVhkRjBRaGtIMmRhaWdMU1VURXpJMW9nME9lZ3MzNS9mcytVVzVGMklN?=
 =?utf-8?B?cDkxN0NLVUNOVGIrVDdLNmUzaXhnUFZVUGljbURKNDY5eTZDVUo5b3kwUFF1?=
 =?utf-8?B?bGNZbnZLZ1h2bWxiWnRyK2ptR1NNKzArSEtMak9lb1ZFbWJmL0kxckVqNlFM?=
 =?utf-8?B?ZGxTcVBoRStEKzAvZnpHd2NxNVlRV2RHaTJ6NUJqL3cvdGFCdmxiNjJTZHNT?=
 =?utf-8?B?anAzS0I3YjR4SGFNYTAvZW5Ld1EyRkNRVUlRTXo1T3RwZWhnVWxKUFUxblp2?=
 =?utf-8?B?MDUwTXAvSmJJVEx4UjA1UkpXWmxBK21sRmZXNlBRd0hUTEFGZFFkdFlxd3JD?=
 =?utf-8?B?ZGhRYTNFUkF3b2txRXhDcWh2TkFzUHQwcDRUWVJjYk5QSG90Z05kdU1ubFVR?=
 =?utf-8?B?SjlYc29oOE9jOWdIdU9mMGtLcUljMHZqalRqK2VQVjV5SG5oekwxRVZIU2Vp?=
 =?utf-8?B?T25ZY1MwdmRLaUhucm40Q1pZcHlRcHl4SC9hcVFqK1ZZZ1pBUGJVSjRUQnJ5?=
 =?utf-8?B?QitzSmJ2eTBPZjdaQ1laTGIycHpxc3NxR0x5a3lMMmROeTNzSzd0ZStEcTln?=
 =?utf-8?B?Uktvdys0MndTR0xiOXRUZG1oZFdUejZQdERmb3NjNjJPVjNzVFVwVHpXSDVP?=
 =?utf-8?B?Q0VMb1VoNmlQQ1R5U0RDYmJwUW9YYzl1cVk3LytjRjkxam9aamFkTHZlKyt3?=
 =?utf-8?B?V2dRZEJtTlQrT1E3RE56NlVvTlpnTStRdjFEa1Y4OFlZREh6TjF3TjZmS25T?=
 =?utf-8?B?V2VFaDgwc05EbjFtS0wrbkZBc25rQmZVQVVrdDI4dEVEaytKNU1BSkhHdDVN?=
 =?utf-8?B?TmticFloY2F2Q3hWM0dubHNaTVdFOWxDeE5NSWJabW5oRjU0MDRGWi9FL0pr?=
 =?utf-8?B?SVhJbUVUNFc1N29TRWZRcEJTZ20yVUx6eUVYMGFwalR4VGYvQTFVQUUyZWRm?=
 =?utf-8?B?dDFjQVB0RGNQUGhCZXIxREY3czZYNWVVTERseVk0NHd4SmlORURwR2tJaVp2?=
 =?utf-8?B?UmgxT3FNUjZOa3VzT2dSWS94Qi9pL0xxM0N1bzIweWk5SXBxSzFoejFxbmtF?=
 =?utf-8?B?cUE3YlJVM2RQNjR0czVOLzJqRUlmeXNucDE4MEJPaDdFQlRxdUI1NTFBTVFC?=
 =?utf-8?B?YzR0OHFpVHlBVzJWQktkL3lWU1B4YTZNeHo0SjNqT1dtd3Mra3JMMTljdjBL?=
 =?utf-8?B?V3MxdkJwaGliTnFUeEQxQlZpQUY5S2EwM0JzS2dPS0c4UlEzZlE4SVRhUjM3?=
 =?utf-8?B?QmxWSFd0VzN0R3RVS2szNzBLcmo0UlluQktEWTZBTXJQSndVZVZldDBlaVMx?=
 =?utf-8?B?N0wweXp2SzVSa1dva3dORU80aTQ4NUYzL1NTbS80K2xzYjAxK3o1bHYrTlBP?=
 =?utf-8?B?YnhwU2lvTG1XWGRNdi92T04wdmlLL1dJMEZ5RHFXbm5pMVY1ZCtxbFpFQWc2?=
 =?utf-8?B?TEVkNFBHSG1sU3U5eTNUL3B5bEhyTmJnM3F4TVVFb3RmT3lLUzIwNUFFNVNk?=
 =?utf-8?B?RlJobnFXejBFLzhWaU5OZ3BGdzZ0bGxtRER1R1hucUdsam1OSzNGQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bac9eef1-e107-4509-f896-08df2588ab45
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 22:08:23.1470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxDM/bUYZhVWJUy6u383pfg5FAzY/2yYUtuy/MQMv3WqUejd6U1xJtGRn+VPTPE4jmoIwHLFBxTV6g27xprtUSq8a/FHCEfnpl6IAH5FteY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9218
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

On 8/4/26 12:57 PM, Jonas Karlman wrote:
> Modern Rockchip device drivers use syscon_regmap_lookup_by_phandle()
> to get a regmap or use a constant to get the fixed base address.
> 
> Remove the unneeded RK3506 syscon driver to discourage new uses of
> syscon_get_regmap_by_driver_data() or syscon_get_first_range().
> 
> The generic_syscon driver will instead be used for the compatible
> previously matched by the now removed driver.
> 

Same remark as for the patch for RK3528 except that here it's worse, 
there isn't even an upstream DTS(I) for RK3506. Just slightly reword to 
avoid the misleading claim.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
