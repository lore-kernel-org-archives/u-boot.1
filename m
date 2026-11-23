Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82F606A31F
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FpD+DtmA;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=cgBjzwYL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C73434064A;
	Mon, 23 Nov 2026 10:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQUj7m44PosK; Mon, 23 Nov 2026 10:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20A704060E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795428606;
	b=BgfYbPaNg0kcGwg55lfF1/pAODyM8+fgIQXdG3h/A9gzwNk4xk/Id0pHRmQIcQWG8pvz
	 OK//lI1ad+fWtktq4jUvAcqVIPvZfeTNp6uW2EoU68FggOnPBtdq8mZj36y7g+MwSZHhN
	 e0lbXRXBLN6EGr7+3q1PFW3BdH2+U/ZoGj3j4iLbUJ6AdIiCjJF21cUYHzYHfnSrAq+n1
	 Lz1DwhQr8A/WDjMp/OXtJXJkpaakeanuDxVG2w7rPw63MJb/Mvu7/tbMKSi5Odlsse1J6
	 tpM+09kEsnEOY7zemmRzzbvXJHy9KHVdrxlYo3YOAZz++PSsUeNxLlq9EdOZyDvZ4gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795428606;
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
	bh=+tdTtXChWu70Et7AJnVOYd4zcWEo/wdt+ftdlIsfasM=;
	b=F+Ykiq63ErqBQfRTpT5wfB1/BRc70teguCCcVj/DrfTMm/S0PkQ4EcPq9D45ck6tl+Kz
	 GWHqwlOYy8bmXabvz92A764G2EYq/R6HLtKGceMaPq8RrpjQN5AaVP62RjnGPXjsrRgwn
	 b793hlXE4+VmsOh0TnFBUQoNlmu4ZP3rDJP+ktSu8v6DOVzYnWrw/OT3A/hxuj3mOxICu
	 cZFOsXwGpCPJwMsQqdtbSEtvZOzSrHgQLinsvI04iBXQ8RS81Kh7ceD9wx0ZnPjHQUI5k
	 xYTDIOM5KlxbvBw6jHHzeYTHHCWplXeZPi3mEBsnf6wL+EVexI4d/2nZMq3miLFitjQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=cgBjzwYL;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795428606;
	bh=+tdTtXChWu70Et7AJnVOYd4zcWEo/wdt+ftdlIsfasM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FpD+DtmAJGqo7Ad8e6S+Jnk/QPeo5fytwUIvhm7Ss7b9WEo5Xhm/sBeZ4Q+onAqmv
	 l8zF4T4+z3wldo5K+UNkxpavZ3YHk9mo+VwVmhS9tnlxV5o19z247QyuMhfr/5rj9q
	 441vMmEWlQ3DM2Yke2IE2sx2TG6DeHeCvkgkDIFKkJ7zjvCwjNm1PzVJ2OkA9+e8sD
	 0DtYJS05QjAwjagDKmNrO+mWwu2CN5DyJunqCM5s18TVEptnohsLtjg49w3TIA7lSX
	 KVovepK2Vml6BMbLPr5KQDA+z5+HI9xLoRT3KPWkGGSqIwwTNpeSu3x0MkuKUd4xR2
	 KAPcTphHPx5Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20A704060E;
	Mon, 23 Nov 2026 10:10:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 06ABD22B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:10:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ECE634060E
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:10:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ae3Z9D_-qPeH for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:10:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 05C83405E5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cgBjzwYL
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05C83405E5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tdTtXChWu70Et7AJnVOYd4zcWEo/wdt+ftdlIsfasM=;
 b=cgBjzwYLXvLFxfkgsZMQxKqDx7p1Xurn4EunvNBFi9XOQMEHQqmImAu4RbWDw8Sr7U6EMZ3kMb46sNy0EL+25JBA0BibhlMi/+MoUyLVK9yLFrLml89ruGezIxueViFJWDb+gNHyVBZLDQKirxJmK1YeFBUn589rfgoKGcB/lq0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DU0PR04MB9297.eurprd04.prod.outlook.com (2603:10a6:10:354::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 10:09:57 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 10:09:57 +0000
Message-ID: <880dbc31-77ad-4335-a6c9-338f09e44895@cherry.de>
Date: Mon, 23 Nov 2026 11:09:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wget: Fix typo
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
References: <20261123085803.25333-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261123085803.25333-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0414.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::9) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DU0PR04MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: 96847e44-fb3f-44cf-f214-08df4949ecdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003|261028144727099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: NNtSbVxNgsbhFRwexWLfXjFblk1lraAIuVc6vD4+1mlVsMkusF5XJoTqjzbQ1W8nJZHPASJQq6qn0GE1Svw05kcFYdCxA932Ml92otE8bLLeVhs3H9VeoiuUWNKfAq4vXX1/Mhl8Zso6JUSUfPMSypKF8SYGLkuSujaIxjxxKY2yAd0stszUduS6sV3NKGTFNYtBB5+Bqn6fOssbt6YIJBrGQJHHiD29t1DHQCW5Jp4Y2fw3MgowgpElaQIKhVlKGtR1J7rPvlplVeiJRO/seqRVQ0ejK3evKc/zM9hQg7eXKHanZiZRq+/1WhMTkpGSiBpVluaiPsYLhRCGSjyaSTgizLjptIQezd/XG6atdjDmhHgSNcXZMyZPlSB+IKFB2efy4O6jmekCVVHO2ZaNU6PgbiWc2xjVnkwuFvJywHDCFzlzc8COdTjj+YiXy/uO6gaScJC/038kF+Nsk5UO9U36C09FG4jNWOZR6EKU/X0lmL3HODkGGIAZA6DGCAuucxqhGLZe8liXXAQzUQQcikXMCLR+yGrkcH+n0FKGMRZ/1KOBM/lYW5iwFT33N/YDlLf5Ii3B+TC7UQGc9Cw4cm8iFMi1TUwBkRZMc2ScDD8AwojCOUB5tHSuOTKrm+1UBJNGz0BaaFVqXwr1QhCsTmpd8UTXPAqspC9O78QmB4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026140227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmx3aGsrd1czajNTb2U2RkN0cjIyRG5VemtBMEJlb2ZJZmh6bzhIelFIZ1N1?=
 =?utf-8?B?d0JpemU3QUMrVWIxYXBmdTNvelRkTHlPbDhVRno0T3lZMk5iVHNhUG82bVQw?=
 =?utf-8?B?elowN0FOZXR1bTYrZXJab3A4SjcwazNKdzRMRjdsdzNDT05tZDJKYzBRdWo0?=
 =?utf-8?B?WHNOQVlwR2crb3NzU1hONDBBb2I0U1lldXVYd1EwYmN3NndLejJTK3lqUm9n?=
 =?utf-8?B?THJtWFJxSUt5RkFqY0pidDJJb2ptbUIxbEd6YUZxTUhMVEJOK2J1VlNKcjNL?=
 =?utf-8?B?MDJUUVZkNmVOZ2FEYk1DemNpRWpHMFA5YldGTGpUR2RzWG5yKzVMU1dWWCtj?=
 =?utf-8?B?OWhFcktSNE9GOWlDaXZMbkhwTFBhbnM3YzJwUmw1cGZpRHJORkFwTHhEMi9J?=
 =?utf-8?B?ay9wdVdPbjgweCt5elJaU3lLWXBXcEgvNXMxTlVGakdLZnU0RXhOQUJGSCt4?=
 =?utf-8?B?QXRvYkErUWNmWnMrd1VTS0hkNVN2aytUQmt1V0JxRElHRCtDVnlOSVBZMG1R?=
 =?utf-8?B?SjVxbDRQVUJCUTBIL1V0S21lY3FNM3loa1Zmdm51MjNLRFd5Wis2cUE5a01E?=
 =?utf-8?B?RnFpK2w4TnlnbWNkZFpUSlJMTExuL3RIcE53TDhGV0VvVC9CUy9sSGQ5empo?=
 =?utf-8?B?MDdpbSthdW1maStac2dSV3pJVWExbytLamc3MTFPclJnRmVyQVU0UEZDMVVM?=
 =?utf-8?B?NmJ1cWZyVzdGRmhmNG1EYUN3and3RGdPZEZPbG4zbi85STkzamIwNEZUbnlS?=
 =?utf-8?B?ejZKdi9wRFpXRlB5OWFGTXM1aitxRlp5aDJpYVR1WnFEZWk1TDFyYUxWUFQz?=
 =?utf-8?B?U3Y3M2tZTXpmSTVPbklEL2VTcTlVWXBkVlZKME0wWlhsTGxZTE1xR00rRmIr?=
 =?utf-8?B?a1JJSDFQTnJIZXBRcE9TTzdOQzQ0YXJTeU5YVE1vZ3Bia1YyM1Q0emFWS2tP?=
 =?utf-8?B?SE1wWEhCRllBOHlGbEV5eWdFSXJqbTlXL0RuQUU4UkZka29manplU3NDbGRC?=
 =?utf-8?B?cUJjdVBjem5aeElvb0VEdUhFNnZjb0JuNHJSY0N5RjJacjduZzl3T042T2Vr?=
 =?utf-8?B?UUQ3UXZ1bUdia2U0eStpU2ZzVEprK0dkREpuOTRJTXEvc1Bqa2doZUxiL2dx?=
 =?utf-8?B?RG5SSWZXSVVtUGk1WUt4d3Z5UmlyaG1wU2xsMFh3TmR0VEFzd29CY2RHYndw?=
 =?utf-8?B?UENLYjNJWEFMZVNRUndRR0kwMTNMNStmdkxkRmtHQWpJbnhnaXJYYVg2N3JM?=
 =?utf-8?B?SjZSRkwxc1BSVDhmbzZJNDNGRm1taS96dzJpQ0xPUUsyTWxDaTV2UkJ6S2lO?=
 =?utf-8?B?WE42ZHl0ZkRsd1F2T0d4ajVtdmJIb3ZJZ0JxdVg2M3l5VE9XbmxTNmsxS3dB?=
 =?utf-8?B?bVJLekNtYkVySlRnZllzYnhTU1k0VDJHdWgwWllVU2VQc0ZUbTlaNjVORGU0?=
 =?utf-8?B?NW1Kb0ZpY3IwbEtSZHpsS3JyTGhnRXgyTWRwOWVDRElrR1NLZ3AyZWE0bm9G?=
 =?utf-8?B?UjVEY0NtOThCbFBFWkpPQlh0MTBoOFRCMTUzTStoL1JGdEZtMytGYUk4R2x1?=
 =?utf-8?B?S2pGcE5rRGlyMmFrSjFDQWFsR25CRTRZakxjbWpGQjMrbWdqZFJaY1NmZzFs?=
 =?utf-8?B?djA5bTM2aEFWUXlDbmxzTDVsbCtzVWtSbDVTdENQdlBWdCtxaEEvUTQ3K3ZK?=
 =?utf-8?B?Sm1JRUQwMmJmbGZOZ245aWtPUXZOMHVQR3pKU0tlUGExU2RTU1ZPSmVBeUo4?=
 =?utf-8?B?OWxPOEtqZVlqQnV2Wms1RkhxQTRJVVhIZk4rY2sySy9HdDRGUUQ4enk3eFFz?=
 =?utf-8?B?TWg1VUlFazFJN2hXRkt6QlpjT2RQVzFTRWIzdUF3aGNrYXhCZHdCK1dSMHg2?=
 =?utf-8?B?WERNS3h6QXV5T3pidWZaVUxsYWVna3ZBSUx6cXdvSFpMbTFFT3hOeXRkUDA4?=
 =?utf-8?B?NjZ1NHFwV1JWZFpyOTFNMDlqYytPNjN6VUoxeDMrOXh2ZGF3aFZOdmpET2FN?=
 =?utf-8?B?T0lGcXlnNThFbU1SOTFObncyUFU1aTlyazhHbUEvMmdTZDVFcjJzOU55WUhW?=
 =?utf-8?B?WHNITVIrMUJtM3dTZ2MxNk11VTRQWUNnNUU3M2VQdUxUYXNWY2JmaXpFZng2?=
 =?utf-8?B?ZmpoYy85dTlrd2lRbEN4OHFZM1JkUDZQeWpVUzVqZ2FSWndGUS9MMFFjMVk5?=
 =?utf-8?B?dDhjOGJ6RFdLSG8zMlQvMXYrWEtCbEhhMmZhOHlScW1Nd3FFRlZ4TFVSS1lS?=
 =?utf-8?B?eHA5K1ROY0R1TE9zWGxkdGo5M0lvbzFIL25ZSWpPa1g3WXJlbDE5SjZRR2xV?=
 =?utf-8?B?SWo0azR5aGd2cXI4WHMvS29ZVlZORmVQNHo5QmV4L3BnaXgvWWFUUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 96847e44-fb3f-44cf-f214-08df4949ecdf
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 10:09:56.9080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXS6IIB6YWYxQtONwYVfbuO+MQOAxW0xe1byIzPpFjY+cgd5PvQr/k8geiT/8WRPhu/d04p3OEPOTo7MJElg3CjigJaOad/Z+bSz32vxA8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9297
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

Hi Marek,

On 11/23/26 9:57 AM, Marek Vasut wrote:
> Fix misssed typo, two s are sufficient. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
