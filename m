Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814D606A327
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g8HZbwjE;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ykAUIBN3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25272406DA;
	Tue,  3 Nov 2026 12:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OIxS14Kw_5m4; Tue,  3 Nov 2026 12:57:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 52027406BC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793710630;
	b=dBFJBoBd+3XrPh2nBd/UwZNlDu+4LaO2qTG1izODifSja3U0zlXXEjfvMjTDBeh4MFBr
	 WBLfWeVkaf8vI/oD+9XPrY6Crkfu9B+ouoaAn99qQt2ohrGMIxhlTmhdLN4aQSYNitQwI
	 Cnw6Li7bjHqLGYqQOybwaQ2ZWPH0PB5vjyTw4Gbvldk3Pa8y9k+WE8dH2KkC5JJF1z9/h
	 VAtMJPeihOBYEsu+Z89pgpDPGZzGI/8TezpdSsn613IIqx3ZYgsUA2VhIqUBLQhX39vwj
	 jMXiz7aGor6KpLRXtRLXKsuMm5PT7Z7rCAVfgRWfhoxvSUjLywr6FfDmul4LdzrNJDA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793710630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BsCfcug4BEV1qciJov/YLgEc097xD3htpTVJmMgPuBI=;
	b=koHok5WjupvlJHygHUu0amejyEx85KglJ9aZaMWYd2wjU6UPtD5Tt8KhZY3v9cLDS5aL
	 Axgoaq4TuWd44h9lrG4Y1n60F1//sGPQSoHDBtu/GW50tekw82RtgLdeUEDjV8uGG18Aa
	 VQujJeQtteuCxaywro+JJwJi5FD9VaiO95SEa8XnZrnoVGUqMMrZLvpGOSgVIMgxHo2To
	 spSuTvKyR/4GaYDMIKRMbd3LfEhu+8Ici+3x4ai3MXmIl0KqgRxKj+lSuFif1xf3VbNif
	 tmt9D2fkAMoIDvHvYDsPXDkyLxYLH5A7w1fOh6r/yQ8qW+6gMAb+1FrV8N9ByRnFG7A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ykAUIBN3;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793710630;
	bh=BsCfcug4BEV1qciJov/YLgEc097xD3htpTVJmMgPuBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g8HZbwjEIl6IJjslX951kmw67NSMzWe8BGeSU8ZkPQcR/vgE9GngcG1/EtNRfTM2f
	 U3U3H1pvCfncMcKNVlksbq5LmqwhB5e2tHC65UdtOZyhIdMXpVaaus7izphHvigraD
	 ybaCHFogpZRqAAgbfrRE77BZSjraQ7TOFJqoewAKBBzHljVzjh867R0PdnliABlo8q
	 lkQhEBaz54n79ST6u9yNgmAcN0Oknbzw83+lhwCqKNs6IoMZOj89Y5n9M8Q1jo/Y/F
	 Ywv426ZAzlEoLJVtd5h88EFCfc0xznYavjTiIPkAsCOgcxh1OAx98Z+HP2vmxB9+TK
	 B0EXj9ThS2yxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52027406BC;
	Tue,  3 Nov 2026 12:57:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D1DB92AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEEA5406CB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:57:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KZZ8MW9SaQD9 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 12:57:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 651C0406B0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793710627;
 b=EJLtQ/df0qIMykPT2xMehjsZxN96MdmJvRaz64QUMHAMirVROzVb8VFvaZvrxJluaOQt
 uaRAbulm6kGfoOaiMBJkXL3FgGFfN0P37Z8dHidGGSES6iqXGAuU9MXmk1dHumiiUbSO9
 goRC6eAjr0HfieRQsp0/atGf2FmvraWWTGwVPnAWP1nyk/pA9fOxzQAUu/Ko+hikXIvMm
 jg7FINQU9+EAfk9gZ706bCgbBg1QZbsxdsTdvPwL3ANFpvjwr6nfGZ4HDPTZCw8YlR5IE
 9AO6wma78wnn0AL+mzOmvgkpSAVHkdVXO+e9QlhG+Z1i+CVvbchj2EinC9qClBjQ1xQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793710627;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=BsCfcug4BEV1qciJov/YLgEc097xD3htpTVJmMgPuBI=;
 b=ZVkjfUgb0HWDownuG2nUrXysxRp7ESfxGbLfktv9mrll0r78uDRx8Au11sPxAG6f6oeW
 6UTVFDChy1dyEbscqTT1+SgcYpQXEUqdLjJjOHb/kl7PnDiAXLwdXZYhpDgZIcpmmE9b/
 JXlsTNZZfBbRu/BhQPfMZRkH8x4zQrjzoOVtbpyriOCFMZTHRyhKZudWpevdeJWGBvP+u
 I2r3YiNVz/7/V3wIlheWKLbWgHc07nLm9ai0cvZjyq7JIVbRvS9xr0BwhLULVslu/Cyxy
 S9AQwNVlK8feiWXX5wGFTfyVeny30oL2hZ9ZtTZaOhlWSWoyFUgDyZ96zHuvRwEt/ZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 spf=fail smtp.mailfrom=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ykAUIBN3; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ykAUIBN3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 651C0406B0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:57:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC778480C; Tue,  3 Nov 2026 13:57:02 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2CA8404D
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 13:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCg5hYkF88GRqiB9rhXgu7Y5aCq8QF2Oqx4KkLn4MMyvFnJc3YiXQewY0oEGzKHnNSlpmQDpRYLoa8QmmrmIeTdIN1UREX2jYW41ld7N+TSyPosS0jtIJC/fLcdtQNFOSf2iqQNhkOhRNidrI8zkitraLFnRpEQsbU1OCfCl11S0Mc7ZIPbHFVE1XTfP/1c/L1ueRtPEBybF6cR1aKjjgBirsJTpsGWEtX1rsYu/PZJyvnrah2orbW8kUSflGQhwQJhBXu2pXpzRDPkZ0Zcdodcqjlpawie+4fPhy54H6nmd3/++YrzHQZNQ7+LrOqKgNNxMAMUiK8n4BvQiOuNT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsCfcug4BEV1qciJov/YLgEc097xD3htpTVJmMgPuBI=;
 b=pQJ8LLLu0QtKh5whnBeHTE8KefcvM/cyqmz4EPkNj6NiwzKtj9KvJw4yUtaJjv6Yh9pOt7Myfz03Sv5JpKexLiF4QdxetBfqZ87xPwE4klUxJGfhIdXjY1rn58SneqhHyXGsge73RItEtF5MLgH4BdLnupzpFKtH3pR/fcDffyvF52D9MRQLVz/A0iAIaZA2S/41iMD/XVMCE20qxFVlis5cUjwjhSc2Gb1viOsUkN+jfcPyuVN4aTDQhblOTMj7kCXhdNDdnB/QDUBgSwnlc/UsfhmCHZ4Ql0cNL9z7fFPXdaYKLcIlP8vN+V3YnS/6Hzbjrv4bU5l4KXgjksubiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsCfcug4BEV1qciJov/YLgEc097xD3htpTVJmMgPuBI=;
 b=ykAUIBN3FM3p3cxGsQf3AAYbU/U9Mx8Fznjfpocv3gw9hjNZmo0mqvsB87k+O95dUfO0wJLv4INbqIfzGvFenzDYQFHi0xzhllCeHa4/7qMgomICg2Kwd6d2ucKvVpJhqR5hFOP0qqF8YvQCpDOG9+oHkB/0fVdNHSjrEGIU0m0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CHXPR12MB999245.namprd12.prod.outlook.com (2603:10b6:610:2fc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 12:56:52 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 12:56:52 +0000
Message-ID: <3348cb48-2b74-4608-a745-4353aae49a3a@amd.com>
Date: Tue, 3 Nov 2026 13:56:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: zynq_gem: plug resource leaks in .probe error
 and .remove paths
To: Graeme Smecher <gsmecher@t0.technology>, u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260820235850.341023-1-gsmecher@t0.technology>
 <20260909171839.3079338-1-gsmecher@t0.technology>
 <20260909171839.3079338-2-gsmecher@t0.technology>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260909171839.3079338-2-gsmecher@t0.technology>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0105.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::19) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CHXPR12MB999245:EE_
X-MS-Office365-Filtering-Correlation-Id: 467a8beb-4836-4910-90c9-08df39a9ee38
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261021123027099003|261021121427099003|261102123227099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: MjFj1R5XlAvugNshxl0y6qbSnqjpcBnwUiXcCgInHe+iMiTnqtIEhDHSOu56xhX1nQ9b2rPN3bROTxnqe4OIP1RxAk3QV4Ky8jz7niI+dWLGY1ylPYEMPCqB95wU0jtxKFvhqOXL/UKvId53xTxT56Pcivlrv9V5iorF8f1kLefwi3d3tyiBYsla59Av1lWwQKO33ITuIVQNrFjTbq4XRVJc4tU4NVuX4iivBGHLISdL37RHSaDHB6YCKwHH9krqKQXitJrQ7+hsOEzhunaREg5rcwWuWKAUtFyjqujk8CnjTahoNnEXE9VkDKXxlbzkL4XX08QFTqlsU0L9DkF2N3YdQBXwHKHhtH6UNl9vcVQnZLTX1Q5uO0RRzgOR57w9T0PNaHQDQdOXQLJlJo9Z+Pb/CVt8x4leiYrWvmmA0m5wVkIIzncxL+jAe4bgfdHMWqQSKF1rJ+whmm04UWx3CWmU/AaM9Wtpi/pcLiuJLc6CDTO7roHg52XvkFKMHTF9/UOsKYnSEqGLRMRZM1X5LeawtjG8+Wx8y1m704w763xFAtohYyUXSuG05tO/bmog9hAbZfjA4gFA1ErJ5epSFKCm9aN997EdUOnp0CbflUhTRkA/oX4NH/f4MA3fc47cRJ6COn4jt/aidKP/Z7aMbW5aSnMXiByNRY5Al0OvChk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(261021121427099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWVqUEpTQkRLYmdzS3J5eTRpeWlmUmpiL1BGUVZveXdHOFhvVmFPNE9NMEVl?=
 =?utf-8?B?bSsxMnhJVGFNZnpmZG9MYUtIR0FCOEdWNzhaZWtYTlFvNUNaMThpcmxDenVT?=
 =?utf-8?B?WkloRk9JVTV0NVMvQUpjRW5pNU5Pa2oyRFEvL3I1eTl4R1BaMnFkRkNXTzR1?=
 =?utf-8?B?YXNRWWdpOU1nOG5SYzBNZ3VpZTYzK2ZoZTE1aHdlRXpwZ3krT3ltTUprNXpt?=
 =?utf-8?B?L0V1QWZTK3k1d2h0MDZlQnVsS3NSaFRpNmlsUVhFRFM0d3I1bWNGb2VOOE1T?=
 =?utf-8?B?NGZqbHh5Q080TEZENmNlaTdRVVVWQjlEYVYxL2VYeDdROThLQmkrdmxDbVBH?=
 =?utf-8?B?T1YvV0YxY1BDYXhSczhqNzlOa0FKaGtrc0lTUXdMaUJVNjZOdjFJQTVmTVRl?=
 =?utf-8?B?OCtIeE9GVHd0RWo5R3B6dEVrRlVYbEVwMEVCaVhYaEgzNWpyMlI0MVNGVXo0?=
 =?utf-8?B?YWExbm9mTlAxYklIZEdyS2lEYVJCQmtSc3Z5ZXQxM1ZyRXh3ZTVWSms1dWN0?=
 =?utf-8?B?Vk1lMDFxejR3OXZHdlViSFNvZE95RGl2eXp0NGlTNCtaZk9xSXpmVTlDMWlx?=
 =?utf-8?B?NlZqc1lTQTdtbkJwT2E5eFZLWWdNUmZuVGVyMVczNHRYeVlsQTVQeHB1TDlX?=
 =?utf-8?B?L1BCNzhrTkF6WU5vcmk1dXB2MVhBQlExVjRHbDdiNU1sT21vZklOSUJkTkQw?=
 =?utf-8?B?dVpoYndLUk9hWFJ4T01vc1hDRHJleWc1cXRHRzdtQm9xdjZyWjNYTzRsWWJR?=
 =?utf-8?B?TkZkYk8yUnh5aGhMSWM5bDNSZ0dmQ1l3TEVHb1hNK1BYSDhiMGMwWTYxM2V4?=
 =?utf-8?B?dk1TVFUzVUVJaDJxNS9sdlphTVhieCt0UzFlU2kreDhGT3VvenhtdnE0bGQ5?=
 =?utf-8?B?UFNrMXYxVWF0ajdGNzcwRXNOWDVYdCthRk5BMTVmVWQzNUFPenN6bUZsa2tj?=
 =?utf-8?B?RFdDbDRiOWFhOEkzYms1TDZLUXRGMkRSdnd0cHlMWkM1WWFMUnh2endhd0lS?=
 =?utf-8?B?dmM3VE5SSVFJSmdjODVERHN5bkJPVER3UkY0SVMrVkliNktMUmhpSTNwemR3?=
 =?utf-8?B?TUZxeDlhd3ZkaThJS3hKL0h0eGlzQ1JzL3FGZmlaTlhqdGRyblFDM2lpZWd1?=
 =?utf-8?B?SWlZb3liV0J3TFl6MDBxdzEyWjZZWWRRcjdpblk0RXBNMVVyQ1psREQ3TjR0?=
 =?utf-8?B?S1Z2M3d1S3RLRHVQNm5lOTY1SzJWOWlKaXNWeVBCbFZFUHpvUlpqRHpyVHdj?=
 =?utf-8?B?ZktmVHpDSU95QnNYV0ppZExGMEJFR0lYaEFBK09zQjNyNFVSdHc5UHVkdGph?=
 =?utf-8?B?U2RhcGRobWV2YldpaDZNd09hQjNOUW5lTnNwczFrRkJsOE43d21nT2VZdndo?=
 =?utf-8?B?L2ozWSs1RndReHo2c3lmYnoyeUw3ZTBjbUx3VjJLUGJ4S1VrUkdHOWRVSEMv?=
 =?utf-8?B?RUR1V0p4Wnp4aDVUOGpzWlJGN2hhK0pmQlBZanZzTTFtRVVPaEVYdDBXYXRC?=
 =?utf-8?B?OGR1d05tMGYvNUxuSE1xNnpxdFBvVzJSN3E0VXVHQkU3K2lrbVYrMlFMeHh3?=
 =?utf-8?B?ejhaMWFvT2h1MkVZWTN2aVlVdmp3aHRMOGJwMEwwOVlyRGxUUy8rNEkvaFIx?=
 =?utf-8?B?cENrRVFkdUxqcXFtWjhHeldxcnVZaVdneUgvTzVUUzFkT0RXY3d0SnlUYUFT?=
 =?utf-8?B?bHZUblRpb200eE5xZXhQZWJNTTVuU3g4TTdYQ3lQK3V5Z25tTkh5MXFMK29D?=
 =?utf-8?B?WGxZOVNFTWpxY2I0eUpHSkF0VndHeFJ6L3pER0FzdVM2MlJTc3Q3RHNzY2sx?=
 =?utf-8?B?cjZCMEc3SENIQXlIc3hMVVFqSngxSEUxR2pwNkJ4ZDh2LzZsMlJwT0NwRyto?=
 =?utf-8?B?NUFSSWpyUWIraUNPTERic0g4WUwzUjN4Z3FXNTc3Skd3c1p2aTFtNXlMODNk?=
 =?utf-8?B?WXZkbWJTWDYvc01DMk9jb2FzS3NWMVFCc0p1aWRPQzBMMnBENmFjVFQ4d1cy?=
 =?utf-8?B?SHJDWEhwOGFQdzVURGxiQ1lpWXZFdkJCV3RqQ3lNek1kM3J4NmNhSUN2ekU0?=
 =?utf-8?B?QXRUQW5waE5jb3JTYWpocmVTeVZvYVcwUUErZENHZlpiRkdwMzMrMWJ5VWtv?=
 =?utf-8?B?MzFiamVNQVZxUHlVRU10SDBwVkdTNTJRQVYwYjU1cGdtdjZERDU0QnZIdk1I?=
 =?utf-8?B?S2lzZ3ZWZkFFYlREdTUrNkdiMnRnTnpLU0xDc2MrdmVVaE84SHdodEk2Tjhw?=
 =?utf-8?B?M3krZlBQODdsMHVHajdBVTBQK3VQVkQwb0xhWDNva3hPaFYvRlMwZWRIRlpW?=
 =?utf-8?B?SkRkNVQvTGVFZzhTZ20yWU5JOVh4and2NitWRkNRRmxtRGZMUzRSQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467a8beb-4836-4910-90c9-08df39a9ee38
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 12:56:52.1219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWPhtTwC8xK2ViK8dDcUikoXFV7YXz/XLCnk/4qG+ZzZpPkb10YuXgcyqBMgdNjM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999245
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 9/9/26 19:18, Graeme Smecher wrote:
> zynq_gem_probe() allocates receive buffers, buffer descriptor space and
> (usually) an MDIO bus, but these are leaked on some error paths.
> 
> zynq_gem_remove() never freed priv->tx_bd and priv->rxbuffers at all.

And this is one patch.

> 
> With CONFIG_DM_ETH_PHY, priv->bus may instead come from
> eth_phy_get_mdio_bus(), in which case it belongs to another controller
> and must not be unregistered or freed. Track whether the bus was
> allocated here and only tear it down in that case, in both the probe
> error path and remove.

And this is another one.

> 
> Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
> ---
> Changes in v2:
> - Move mdio_free() out of the mdio_register_seq() failure branch and
>    into the error label ladder (Michal Simek)
> - With CONFIG_DM_ETH_PHY, priv->bus may be a shared bus obtained from
>    eth_phy_get_mdio_bus(). Track whether we allocated it and only
>    unregister/free it in that case, in both probe and remove (Michal
>    Simek)
> 
>   drivers/net/zynq_gem.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
> index f570ae9ee73..986e6918253 100644
> --- a/drivers/net/zynq_gem.c
> +++ b/drivers/net/zynq_gem.c
> @@ -257,6 +257,7 @@ struct zynq_gem_priv {
>   	struct phy_device *phydev;
>   	ofnode phy_of_node;
>   	struct mii_dev *bus;
> +	bool own_bus;
>   	struct clk rx_clk;
>   	struct clk tx_clk;
>   	struct clk pclk;
> @@ -998,13 +999,18 @@ static int zynq_gem_probe(struct udevice *dev)
>   
>   	if (!priv->bus) {
>   		priv->bus = mdio_alloc();
> +		if (!priv->bus) {
> +			ret = -ENOMEM;
> +			goto err2;
> +		}
> +		priv->own_bus = true;
>   		priv->bus->read = zynq_gem_miiphy_read;
>   		priv->bus->write = zynq_gem_miiphy_write;
>   		priv->bus->priv = priv;
>   
>   		ret = mdio_register_seq(priv->bus, dev_seq(dev));
>   		if (ret)
> -			goto err2;
> +			goto err3;
>   	}
>   
>   	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
> @@ -1012,7 +1018,7 @@ static int zynq_gem_probe(struct udevice *dev)
>   
>   	ret = zynq_phy_init(dev);
>   	if (ret)
> -		goto err3;
> +		goto err4;
>   
>   	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&
>   	    generic_phy_valid(&phy)) {
> @@ -1024,13 +1030,13 @@ static int zynq_gem_probe(struct udevice *dev)
>   					dev_err
>   					(dev,
>   					 "Failed to set gem dynamic config\n");
> -					return ret;
> +					goto err4;
>   				}
>   			}
>   		}
>   		ret = generic_phy_power_on(&phy);
>   		if (ret)
> -			return ret;
> +			goto err4;

You are changing this but in error patch I can't see error path for phy 
handling. I think it would be good to clean it up when you are on it.

>   	}
>   
>   	printf("\nZYNQ GEM: %lx, mdio bus %lx, phyaddr %d, interface %s\n",
> @@ -1039,8 +1045,12 @@ static int zynq_gem_probe(struct udevice *dev)
>   
>   	return ret;
>   
> +err4:

Don't you miss also clean up from zynq_phy_init()

        if (!IS_ERR_OR_NULL(priv->phydev))
                free(priv->phydev);


> +	if (priv->own_bus)
> +		mdio_unregister(priv->bus);
>   err3:
> -	mdio_unregister(priv->bus);
> +	if (priv->own_bus)
> +		mdio_free(priv->bus);
>   err2:
>   	free(priv->tx_bd);
>   err1:
> @@ -1053,8 +1063,12 @@ static int zynq_gem_remove(struct udevice *dev)
>   	struct zynq_gem_priv *priv = dev_get_priv(dev);
>   
>   	free(priv->phydev);
> -	mdio_unregister(priv->bus);
> -	mdio_free(priv->bus);
> +	if (priv->own_bus) {
> +		mdio_unregister(priv->bus);
> +		mdio_free(priv->bus);
> +	}
> +	free(priv->tx_bd);
> +	free(priv->rxbuffers);
>   
>   	return 0;
>   }

M

