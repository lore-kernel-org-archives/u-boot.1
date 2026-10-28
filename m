Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B77606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LnX1DOuy;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=jICV7ybr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3C798100F;
	Wed, 28 Oct 2026 12:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Jyz-0sZYACm; Wed, 28 Oct 2026 12:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00A4580FFD
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793189759;
	b=Tl7AfarT26teAzM+c65Sd/nDyOgQVGSzJBnnYOTyDX+18xQq71e4eLTkT+QACT27vyvp
	 M4wA47FCJcz5NjHix1Rzl9GrONsLPtWok19bv5s192Lp9ZKBVKKpXsW7Vgk+qW1wpVCYG
	 TVoM4u2r/ynE08w5f8iQLviBwwhIRgqHf+E8pNVujts9avATCp+n09cdMryrHax1HQBtD
	 1HDOYkecwZ8TcoCGb6aQpENzWtsRhobztNmYT5AQGdU6xaScsvucXV7Vy7SVjeuPh/8o9
	 qx0Bcjlhkk9ha/ut+BfnZjgKWMn3PqdChKPXnUlxhFPote+qLHp6bxFBGSaVnvCyysg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189759;
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
	bh=Z4Xci9h864OS7fsj80g/eHEy+E30pDrmXgZkfpWakRI=;
	b=QlRqVNKUptjmhIivBmSxHeEk5ItNMYgOVE9cyaz8+D1zU/pgOSFmtE/Xd43m6QBLmqnn
	 ePH+R9Xnp+O1TzcYKcXBoIxNl5ArAQRT8OBuj1qLXJGsWC7bcos+P5y9+KpkqJ0j7IbX5
	 3Pss0zlCIm8+iDJnnA86gLDYhu6WU2lRiZChc0nBWx2mNY8N8h7saUllTl4dkrEYZ7dgI
	 sJoo/A7CzNkIAAKChQ+Q14Em3cRVBU205CpWbwW/tNvuzVW60bigrWWQi/xDPSctSCS/8
	 GlFCSaJlJxcIbSNz6wPPmS2m9ovDgADvtY4CsRKZ7a78/oJvHZXHZSodKWzgCiaQWWw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=jICV7ybr;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189759;
	bh=Z4Xci9h864OS7fsj80g/eHEy+E30pDrmXgZkfpWakRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LnX1DOuywCi3O8GOt2ej3NaKoH0FJUsyXysqQQ3qZCGTrhC7j9R6r3bdyQpf+o6yY
	 rnw4JYMjsLQa3hsMrDxAFt+gQDIXIm60ti8CehkuXbrOqX/4f6cMTpjYjYMyULpkEa
	 HKSGtgln9DsuKMwzzde7zsfaRGoZoK447pTvKaF5mvrg2D51eZ6uesrUBKWFalfBKw
	 H/1elx9qqzVi9QOgShFdnerJIORPFQVpN0oBkSKwhneEcVysihGprMf5wHAq26RcVP
	 LRKe/7frEAkG5kXjLD5nNcyRS9cNLGqjCz+Oe6cdeTqlIXVJ/NmHy4W+gTakKxY0of
	 loXHVofar32tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00A4580FFD;
	Wed, 28 Oct 2026 12:15:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AA8B8972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 908B780FFD
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:15:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cS5c4Oxtn-Js for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:15:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 74D2D80FF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189757;
 b=lvy6VytBALVJSQSIb8yt1+8v7NTgubb27/3EmeMEeysrzmmaY4i6A9o/4GW7VFz+B7sx
 FIiwtHrtaxcdzgAeNRLrkGwa1bLoyJQu2VIO6ucZpRgncZM7SWughViDOpQzvJ2nzG1a4
 5xVKyhrkrnNByyQ1326CULllJujSyoQSuv8r968LTZFE5xQo7P8XR9FtXFGpBbOnOIY5a
 PgMYEnafPRkSebcMEzvsF9A1bc6OL68f5VIwVzWi0/TpHSzeGzi1vT9x+zzbVq0cljZsv
 kqf5Y++2N6Fz038kDwCVeRSxHpJzVt8LD/fkuX6eGFfhh2hqQgDQQIYGQJJJW8mwhZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189757;
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
 bh=Z4Xci9h864OS7fsj80g/eHEy+E30pDrmXgZkfpWakRI=;
 b=K97yh4HuwTtznqaz2AK4vV+2+C6hilQ0FWfKHFlyBYqwsVIrPwHGtOXuhFLcnqekXiJq
 BjyS6TGeE/UdbjEUFtzDrZJsaMQv8os7d5Dc/AyI5hTk2iFL5kxroPJf+DNE2gcdv/mZ6
 a4GGXM/UcXtoAb2zBDmE0bkzwd81oi28W4DzL21zujwWDdHZLLShqj2wsJQtlDoHlUkTW
 miJc/wKRZ5FXocTdo7GWGlSZkgkPX+Oclq4TkV8MpHC9SBNc0hTNQvcGdwyEw4Ea6tp3+
 2h5Zmej7dPVhB1uje7+vQpVCP7U7T+WtixUMOGknG3wdXyKpdpaBdfmc+ImXZmdyviQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=jICV7ybr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=jICV7ybr
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74D2D80FF5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:15:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nq9tZPsRBPTjNe81sb0H7/uyzWLQs9xIvXr3hjSHAHpG3p6gWQQ+fSHhIXfkir4oLbQJwNm+NqH7GIOaVM9d9fqi8mKCSyYwQ6zLadtsBY1FF8n17iBKIBfLIPm7a8K/0sc0ATGGmAv8d3haf/MrE7al2arKhGhdAM/1BsZ4N8KU83E9F+UzbGJfZQbSddwhnXirr2N47cCO2fC1D7jzmGEwnRxJIfeNBsDEfllBMNPJh1EF1Ne0iM0pOOjDhwYF+TxdwzUcudj+zej3g6cEG/a7wuhMlv5RE/y5XMi2ttkCLcSLbRUFTJVmw0Utx1oIYBsPAR2ZXTClOzP3ggIFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4Xci9h864OS7fsj80g/eHEy+E30pDrmXgZkfpWakRI=;
 b=FRO2VIM5LDIa/vwiI+DY7gO2RcfWZ+YvAV6mZvobhkPCmOn7ZB6XBrrYaO854ptWk8fzdV7C2Dlp9sdfkWKPT2v0iMPevC1WXKIy3ZLr/hHq3TZbynAphao90HMNwr15r6H4f5dWgCP/fgn7GuwIEvROV4ovGv9TDiHNkODSHQv95FYfxKMISCJ1kpbNH2eu/2xUF0/O/0BmuEdL8oJYPccQWQISi1nB4yo/5AEHdzt3pDy/sCS+XIqmMOQrm3ogh+XcymBt58RDrhhuFgocOJTl4AiTNV2ySM9WPxE299tmdfY4elPNLg5FN0pIYEF7eyf+g0HSIeKXVEnbGyn9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4Xci9h864OS7fsj80g/eHEy+E30pDrmXgZkfpWakRI=;
 b=jICV7ybrCkAzx2b/hqf5PFap8aErH6S3yAEVtnIPNKZ6dGKoW0AcyYHKVfN5gXMabI15uTBSo4vz+IEl3fZglwsNYxyWlAUb6KUpRamurPnjycBIzWPaUZO0wJF/8fFG+W67IUIoe4iZ5k/keu4YDqF9iv5y2Z524Wf34rUiFFI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by CPHPR04MB612808.eurprd04.prod.outlook.com (2603:10a6:380:10b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 12:15:50 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 12:15:49 +0000
Message-ID: <045fea92-18fd-4b60-9d5c-810fd14c1ce2@cherry.de>
Date: Wed, 28 Oct 2026 13:15:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] clk: rockchip: rk3568: Always initialize clocks in
 SPL
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261015224222.1582607-1-jonas@kwiboo.se>
 <20261015224222.1582607-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261015224222.1582607-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF000001F6.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::90e) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|CPHPR04MB612808:EE_
X-MS-Office365-Filtering-Correlation-Id: 229c9eee-e6ae-4825-24f7-08df34ed33e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261021121427099003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: qj9UsqQ2imv6iqWD/vHs7ReFYkCFfgbEk6tWnp+CgvAL46hMSNYaEW9auhFPaL8QnPyZHHS20uHp1g+wBccRPqF4xtahK/TxJLYyf5FaWHds+NKWEzxpSyg1xrU/6QZoxOqyJgc4GA5lznfO83bA9ZD37EyWO67MyLKO4PMQJiLdsYRz3idzG9OWMB+y2vqZt9xBKsrU9wsF+O1t6S8WCqzqZjbCzFhIYHtW/UB7p4yByIjbjZg883585YHIzCNB1hd/odjedSzkWe7bfDVyscvIpIBXzbaAGbUxFKTavsjzCU16axynQF+C/0GeLKcOpxXDQbP5t+G488CQxGiVCyz9GN9vxdW1bkBzp6jT47Irx684kh0jx2e+uJeYi6I7tTUs/23mJi9uL758wmzIKPrfnlb7Hf4SHEhTzpui3pbCqdlUosmJjcLrM3XXNmkdKwn945G0bLSRnIwrVQkcbz7ys35UvJvws8sOKGlrWpTqcuRZk+jGlilgZ4NKx2ddfHpmoeIej6rrs8WN2ZoFKzDbk9sYpcDdmTNiBzvOVH2mO5NitFLpEZ+JUH2G5+7eEXhZqN6kEUv01Wnv2U43FXF4q78bruduhPtIH/Bd8TK35pqmrRFmkZ6xDYYY1X4wTypzmdLKdoE6UZaDWXmaG25lJkoFGqVhfzBE+T+3vsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261021121427099003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0hYTC9kempPNHh3dEdDTFBkWXZKYzdmOXJBMnY3Skw2ck1wY29aU0tYeTkx?=
 =?utf-8?B?YTYzZENsbVZxZlYzWDUzejVOaEg2U05kM1l4RDJJeEFRTzcveHRpN2tWSGxI?=
 =?utf-8?B?WkRta1BIL1V5RDkySno0aEZvR3lUNThHa3ZXTU5GNWplRU5mSkRraVpoWVZt?=
 =?utf-8?B?VG1VV1Vwd1dPL25iRzZCZVJpSGMrMU9hc3RJbkw1SmEwNGpFNCthdGRlazJF?=
 =?utf-8?B?NGlTZlVBODhNSDJmUURkNTBYd0pDeWJBb0xGSjN4QlJ5WGU2Syt6Mi82Y2NC?=
 =?utf-8?B?eDNXd0R6d08yc0ZodHZUQVlHOUowMi9YVUJXZ2hZMjJUU2UrdzFwbEtGS1Vh?=
 =?utf-8?B?N0o1N1RaaDE0cExxTVVSbmgzbE9LbG02VU9ZOEpKOFljRFprVmc2NkVKU3FC?=
 =?utf-8?B?bWRxd3dpV1lhVmgzbWtNNGw4MXQvMkErcDVVVEY0NnJ3QWRtZFc1ZHdHN2tk?=
 =?utf-8?B?ZTkvc2tPSVovZWVtYnNMeWZLdTNrSlFNWFJ5a3AwQXhzMUduNVJ1NXNaNHJD?=
 =?utf-8?B?RU5Kb1JVRVlLeXBUckpvcTgvQURlUTJOSVFjRHQ2TFJvdDRRcFZ4QlU3bmpr?=
 =?utf-8?B?QkZ4dG1IbDN3UHZtNWo2VE5vRDIyTjdSRmszZzZYYXpoR1ZZUm9vWHBjSjhO?=
 =?utf-8?B?L1dxSDV4WitoU0ZoWUZTd081SVZZY0Y0VU5raGQ2aUpqSmxRTFBmL2xZYzhR?=
 =?utf-8?B?ZXB0MU1sOWFaSks5elVISlQ0cEtwL0YwaVF1cTVQb1R1UG5WbnRxc0NnR3dR?=
 =?utf-8?B?amZ2Um9RbmdkY1ZHREhpZlVINGdzdVdzNkc2UDY1NEhYUjYvZFVvcWgzRWJX?=
 =?utf-8?B?YkswTjJFZXYrbDNaTTNKTFczd25od0JJYmsxQ3BLa0JPM3ZtejNKUnFCdWlh?=
 =?utf-8?B?eG5QRHM0bklGckNRS2dnQnZEVEFmN0dGYW5IQzVkZjRFVURTOHM2aHYvL1c2?=
 =?utf-8?B?WkkrL0lOMXd1ZXg5QWZGNG04VElkenY5NE10VElDSmdEVGZIc1FwaEZmeGtB?=
 =?utf-8?B?WWlZNlhvakZzYWN5Z0Vkam1qcEZXbDNtUGIvS09meXprV0RyTU1Ec0txMTYw?=
 =?utf-8?B?dkdaSkVBRXNjY3ZmV2d3YkRYNU5mZytlOGtlVGxLZDNCdloxTG51b00ycXhO?=
 =?utf-8?B?c2h6VFNJd1N6SW9ISWdUOHNpSG5Sak1hOTNMMGNYY2pUaWw2ZlMzY1krTERh?=
 =?utf-8?B?UHdieTB4OFYwNWNjTC9pSWFCNmJudkRjTXNOQmt0cUphK2oyT2trYzJ5RVVO?=
 =?utf-8?B?dTJMSG9FRlhZUnkvN3R4Zk9jSU5kU0lxNWpqaStuRjdNT0pZR2xTYlo4djl6?=
 =?utf-8?B?L3RUUjhuWlVMVUFyN1JnK2JmYmg0R0FHbFFXaWFzdDZreGp0SHZTN1VGSVdL?=
 =?utf-8?B?V2h3STJTNnU0Mnkxd0tCNXhyYlpBQm1NbU1TVUQ0eDFINWZhbmphRTYvcnJp?=
 =?utf-8?B?VE9JZW1nMXI3bzNPSlZmQUFvQUNEczRMZzNMVTNia216MlVvbWc3Ym1SbmNx?=
 =?utf-8?B?YUJodUd6VWRFOXdqbXRSbDdGdDVLVzNqMTFmakpUKzFreXo1ZElFb1A0dkFO?=
 =?utf-8?B?eXFTNm54ci9TNzdkci9CZ1dQYVVCVlkwZFE4VEZXVGhGaFgzVzl5LzhsU3dN?=
 =?utf-8?B?bEM0NGVwYjhpZmd5akdnMHFNQUVMTnVpVnEvN0gvZWgrSy9ZOEhjbjZhVm54?=
 =?utf-8?B?MFpDSlp2UytOcTl6TkMzNGkvclBVcnNVQW94Qy9OcElzVUlpT1YvTDZTcU5C?=
 =?utf-8?B?K2Y0TUNPY0hVTzNZSWNyTE1qbjQ2R3d1cFppdExLUmYwaGFweDl1SytjekVF?=
 =?utf-8?B?UlFpVUFJWTBxdDNPUUhvWDZtOHQ1UUhEZmEvNjkxSnNoQm01dkg0cjFCdTZO?=
 =?utf-8?B?TUpTWU1acTQ3WmV5M0lobEt0QnZydkNjR0huVWhhSTBOdUd3SUdTS0J4ZVZT?=
 =?utf-8?B?dmRCZGVSQkJyeFZXanhqRGtYMnIrU2RKY2c1M0dIb3h3SGQ2U2NVSytlN09M?=
 =?utf-8?B?WHVOUXRISzgzS0V2OHg2MUsyYUhsY2F3eUpzZFoyMm5WYjg0MWVFTUI1Q0c5?=
 =?utf-8?B?L3dCQlFYL1VoWFlKRGY0aXdDd2NTUzdXQzFwNGNOdDVjVzZFb0dITjFSSnRH?=
 =?utf-8?B?dENLN0NoZVdMdlo2WUUwQWRiSDRNWjgzQUpYSERvVW92VG8zVHpoYUlMVncx?=
 =?utf-8?B?V09HYTBrN2NFblhqWms2aW4vZWV3azlmTFlxVnU0Wk1BanlwWU5IcVA1d2Ux?=
 =?utf-8?B?S2Y4SGtDd3ZQOCtUMGNEWk5sUXo3dng1UW9GcUREM00zOE13UnI4aHlQSHRD?=
 =?utf-8?B?blRTdlBEN3dyNU1uRVRMY2E3SVRCWVlyMDdNUjRYcCtPcHR2VmNnQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 229c9eee-e6ae-4825-24f7-08df34ed33e7
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:15:49.4754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEX+TuKZ5uncT4NNrtFvFhyEZcZzyWHBj1d1+TqC/KZBejag9ppa1c7zb6+n3724/RxRZbynoZ16EmUpEWsykZENYf53HRLHymzLPiH+Xs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR04MB612808
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/16/26 12:42 AM, Jonas Karlman wrote:
> The RK3568 clock driver initializes ACLK_BUS to 150 MHz when probed in
> SPL. However, the driver is only probed on demand, so this
> initialization is skipped when no SPL consumer requests a clock, e.g.
> when booting from RAM/USB.
> 
> Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
> of boot device") all boot devices where typically probed, with a side
> effect that clock driver likely also where probed, prior to the
> boot_from_devices() call.
> 
> Flag the clock drivers to be probed after bind in SPL to help ensure a
> deterministic probe and clock initialization behavior prior to booting
> from devices.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
