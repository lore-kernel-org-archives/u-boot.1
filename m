Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC0EC982E1
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 17:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B29C60D95;
	Fri, 18 Sep 2026 17:20:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Y3NstBwvmNU; Fri, 18 Sep 2026 17:20:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 56F4260D97
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789752043;
	b=CMgp6Ze0RacbjvNUwmxdg+qaYtUT0wquhYGBgQYW1QfpJR7oA2BafuNjuM8EBGV4Zb4d
	 G+klxSoLnYL/XJPI6Uxb9RxKjGXGdvmPk3JFJta1DzwQxZhJ+vunC4ss/HXMXiWcEli9w
	 9NtCnI8+4ksPacEs3ghcDznJLiZohQyds2bf8zurKFviZEBFC58B+0jxXUAQRCR3glOYU
	 YoDgu9eXNl2rZwsH3sqhJxhZ3Ib4CRlB0URmSPS9gX9/eevhk9CWV7tb6LaBZueHfGU9x
	 Uu//c4jiFQrUgiyv6iTZorKz0t2kLKIa7WKYZnyircbOe3TcAga44uw2/XArbMi/bDA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789752043;
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
	bh=QLPjuJWh3rF+HsrcBfBzMOahRxRxf+rfZ+0wi1Tb/EM=;
	b=frCPCCpVdhca8KVlVkbPukW7BYL0hirNFoFmE1OR4ELlgo+q/ut1mbZvz/9/3DLl1X3z
	 HZ3hYkxnUy/XYlilFNyNJzTuzsaYibfE+zVXBTPr+BZhj6f4RpdqCMXE+NeJciro1JMIb
	 ZmOYjZ9vOSh98gQ0SR0+YvXjytrObdB6mkbPY2RdZBXwATFQ2gMrkgA+LXjNm9D7j2Hgb
	 dfPEItjQM4wLQV4cKSamXeM/A+CR4ZHshjSlXtE1jGtu6AHC8vH+2aPluYeP5rKbOt33N
	 m0EMMrR9eRVlRchQIyhPW/ajhKgAjBdU6MtS5TC1ScFPF0r5BoafKLkntXmtRfRFFXw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789752043;
	bh=QLPjuJWh3rF+HsrcBfBzMOahRxRxf+rfZ+0wi1Tb/EM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o4FXXlPWd+XT27GoI+fGNdUyDq/2cODFglkw65Gt9MTJd9Qqb8QgZfq+10rKlHOeM
	 ehkQ42pgDK8G0kFZoMjpWDFjgxWqcGivdRAE1G5twzPO9O4IsiSvyuEwQlo/Lcqw3j
	 GOkNVdTzN2snR5bwgq0Q5zTbB76M2vEItlLzfOEdHBLjskRRT5yUWlTNORe1XLhgIZ
	 P2YjUddJDMUIgd1hAIbKQ3lJqLcYLrx++8BN6SSBxAbLfJyzp3KetPnYGlE62o95Sn
	 JQ1lLC6/nlLEgvK8r/D3VY+SCUFpbC1XFUHCUIW4ZQxdiCzkLj+zjx8PjpIiBYaUm/
	 AKWm0S9BB4vEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56F4260D97;
	Fri, 18 Sep 2026 17:20:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F21625B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14ED140B59
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:20:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ar7tkyK_z3SQ for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 17:20:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2A4E540B83
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789752040;
 b=Ex884/kuRPp7cPBWMVMTVuLbxYFROMulqe6phlXocyhUsrliGq9h5EVTVS6PvAY+P0Pb
 WpAj506rVeNcB5chDC1Nu8xxXmNz9ILPe0nXyZQRxkFctuwOLnPFxiF3EbbGJlznjpQ87
 WTaA+sid52E8fbPpgqs1Vp+uv/BtuB8s124x96Arbik6dSV5ekOsJMZTpqvnKFDmC1JCp
 k4BA8Su5qvYsMuAsBVqRPQgYUkeSK12k9XvoKKpXnq3AlTrIgPoPRXuvGVpVUrB1LrJVV
 yNkkAQs4ibctpLftibR5DKMf/Mfa0X0YSa/83VTrEWdWcD2D9P/0oIWc2cnki3ci0vA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789752040;
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
 bh=QLPjuJWh3rF+HsrcBfBzMOahRxRxf+rfZ+0wi1Tb/EM=;
 b=oH0/3C23iuYydSEH3KspPDaqXcQRMpZuuukAk1Kwc2bKFg4Gs4LfjQvHjJR3ULIUUsL9
 w3w9zAGls5QYZZndmw7fLDb434JiJNGlafqI05WAVem1rEapFhYvtMr41KZUZhXY7WdCt
 UxP8LnRn9g0WS6kqRjCtKVYu8O2OavPA65xeGUjoRnxsIXC2L0m8uthdLOEzyC3nm2g4j
 w/l7cuEzcatC6AaFfYTYQrnOB/Fxi6tMLE9p/4YAJlA7BW4ntKoqZIp7Y0CzLlJTbal6b
 gmydUBHz7q0ZSQB3b0GC4y5VnqvdNdgY9M/L6Usu5v1FVtaSJ3nzA9Bb+iLPmSgoL2g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="D7/kX/By"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=D7/kX/By
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A4E540B83
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVHrsCrG60ws6Zf4efvhHH04yite3issfYha/+HWJ3zy6s8lCSCThnhSncGQaP2tFyCp9p+jfzOLVQg7SREAErv6OnqTz9cjFTGVBiEhDzrF7l7LxaYFZqJPdMA8eg3Q0KrQKU8Y1G57MT+gMwWonTukrjdoIc21bi0kvaSxaJ9cdwKbZAkdKwImyaCeNKpqHcoKHneKjNkA308cv6EaWjfcxP2WeDzyULNphnvgDGOGfVUyJw2P59fTnQPeznw/a/ToIYjU+Bre7uoCe9TxlVhBXIzR2HwmC3Iq+P1u3x8ysskKhoHks0rDqebLODm0OYYj2HYbIkA+kTAV2kBsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLPjuJWh3rF+HsrcBfBzMOahRxRxf+rfZ+0wi1Tb/EM=;
 b=JxPHdOtEwVHEhago7zkuMhYTqIakRfQMSpZ+aaFG3kzS0nj5LUZzyM/070vU2U/2oHPRht31d3ZKduzRutsNrC6z/eS7TBrJdU/d6oAiJCjs0KSH8l3eRzXEMtZ+JJVLzfffzsc6mzsj4g46uuHc9poZRmuYPy3QFm+rb2WTrc51rZ2Obo/AZuwA5zTqJBfkWFmzAs+NpB7y83wBvfHaD1pfU58eJT7UZfia2yfqgkVYKuTMCZ31t1cs4vRoJyGlve/MJhSoN0G4IjwdwU+JwpFn5UACC/EseY0mCbNMwHzUcTkg+7ZFB8cW/WO/FeROEoU5essIm5NGbHSRbCEsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLPjuJWh3rF+HsrcBfBzMOahRxRxf+rfZ+0wi1Tb/EM=;
 b=D7/kX/ByEyXAjenqFId2H4Y+gc4NkVNDctLCO4zRpwP1xqwN2pKB35R33eRXn9MDHKTjWrMXqvI5GXZzUZFM9LZl9pqWp7M0AWSFLsVM1MgQ5JuFW6nTFOQblA8l/JESFdDwvg6YEWUJC6UNtNMQA++XyCnhEytZtQfCk2HcN58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MI9PR04MB338771.eurprd04.prod.outlook.com (2603:10a6:290:87::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 17:20:34 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 17:20:34 +0000
Message-ID: <a7eb0233-918d-4ec4-bc54-746475cf171a@cherry.de>
Date: Fri, 18 Sep 2026 19:20:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] board: rockchip: add HINLINK H28K
To: Chukun Pan <amadeus@jmu.edu.cn>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260918120001.2256317-1-amadeus@jmu.edu.cn>
 <20260918120001.2256317-2-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260918120001.2256317-2-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0059.eurprd02.prod.outlook.com
 (2603:10a6:802:14::30) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MI9PR04MB338771:EE_
X-MS-Office365-Filtering-Correlation-Id: 15214934-dfd8-498c-b881-08df15a9262d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: CpxGBI7W7iBkVvbKPCfKiGIoEtYV2hk2cZ4BygfmxmP2tGfFQSmzs+mDapdrQF6mwehLFLBoK6UWea/dJekWi1kIy9vTQ1LCBNat47U4vyXwVypWMEDBfnDoSQsog1rMouSGLYUrkD34edUlcHe7ACJfFYMukIcauCHG7Lp6Q+s/zBORVFWrBKLkP75DXAEgdpLacFwwU8JYEi/eU6okjNFrNGPiq87dTKYoOYa0ixBJcqS/nv5YLEDjgGDrwNezVfgy49fu6wWSnAYFI9rdrYaTOrnag16Q8qMVUurEEfnL0287TU+dUZJiJvyNbAa1Z726DD+Zo7ccLHcFGuMrsN4eIc/W8JZI1dCktMF1QBHl09iInLaf/lX8r3suBIJRPKiTS3VVFhNuk6gzQauWtZdPmojsIex55hgJt4ZTk11/sQuz1OIRwOhditp2v0KIIDSs17BPri69Qe0+fbo1rdYes2cqijyD/9KI/qdevfPirh8PQa75B91xvSJzcwB7pM8XoFwBKMPZ2+FZnS9NrxYrRLz1WUgGUZ7i6ZGaF4LFd+VqObDI7Rd+HlmERrBjqP5PEd3FYYRnqYfvHlpYdh5yAyLUw5c5Q0iPwBSC37Qs8dbeXiNgBhySZYUtoQown6/2kGV0cXBfZGSZ6eZ0VPGFYrZtm4foq6Co7MFh6Y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M092eCttRTI5NytaWkhwMVIzdWhIbDg4VTJwb0p1VzE2d0IwSGhCdUZpbmJt?=
 =?utf-8?B?OW9rTExPT1hoVld4SDMzd2JQMURpdmh2anpyQ01zVVRUMTc1dDd2OTBmdStG?=
 =?utf-8?B?RnBrU1g4aGdPeGpWQ0x2NWl2R2JETFpFcS95MEhuOUp2azZMOFZxWVhQcytr?=
 =?utf-8?B?anozYldIY213eldKdm5mMFBzbGpDNWl4NHA3NnR5N0Q1anZDTklCcGdDUFo4?=
 =?utf-8?B?a0o1RnhjR1l4b0ZURitucjB4R0gvQjI3bTdaTFVuSHo5cjdkcng2VjAwb3M3?=
 =?utf-8?B?KzJwcTM4eUNCVHVQSzM0WncwNmJzclpIU1dVK0VjMFpkblA4cCtpOXE4VXZJ?=
 =?utf-8?B?OGFpT2NaYzIxM01UVk1hbGxnTzJtVURWc3pES3RnTTIyZVl4V1dnUEY1UGZP?=
 =?utf-8?B?aDd3b2lTbHdNMUhObjJBUkMzMnhYVzRESjlkVkVvbXIrSE5kNzVEOFF1RG1t?=
 =?utf-8?B?OEQyTXkyb1h4azgyMjFDNkI3cHBycWcvc3FPOWhoL3RsSFdidlNaeERvVTFl?=
 =?utf-8?B?ZlRzcmlVRXRsT2pxTXY3ak5oVWpGM0VQZU5kaUlKM20wcW9sQnRVTGRvTm9V?=
 =?utf-8?B?VlNHVm81d2c4anZ6VU84NHNhY3VOWEk2NmtoSzdGbEVMRUdJVnhLYlJmZ2Z5?=
 =?utf-8?B?SlVRQmJEVENmaWkralNPcWpxVmJLbWd2WVhuWGZ6LzdldXQ3dEdVSWJOZHg3?=
 =?utf-8?B?YnNXOWExajV6RkZoYmtDRkVabUdoYXdnZTZYVW5oNlJEaVBIUmVUR01DTldr?=
 =?utf-8?B?K3JrcXczNEo0UjRFbDlSallFcjBzeDRuWlhEaGlPb0pnek0zcFN4NXFRZ0E4?=
 =?utf-8?B?VHpYK2hwbDhFU0R5S2hFTk9iTVp1aE1oOGs2SjFEOVo1Uy84ZCtMK0orek1J?=
 =?utf-8?B?UTVCYS9nS0ttSUVXRzN5NVNUZGpicjlWd3REVHI2V2lUVkJoVGUxRmFSOGNT?=
 =?utf-8?B?UVpKK1ZmOVJVNkg1d0lHR1FGeEtSRlNRYmhGR0lDdkZzTG42VG5jaDl4enJ2?=
 =?utf-8?B?TktCc1V1a05HYlM1UEUzb3RiajhnV2QrcFNGWjdFWnkzbENhNnFneklWUm41?=
 =?utf-8?B?VXBzY0F2MWM0RWI0b0pWOFUxZWdFWlZaZG05Z3lEaEJRRkN4L0cvSm0yMlNh?=
 =?utf-8?B?K2E4TDN1WHozTit1WnU2VFM3T1AzVmlSVTVVOURuR2JoRzhic25keUQ2bmZR?=
 =?utf-8?B?Nm90V0NqejFBRE05am5ZczNvNFBrMEl2RWlTZ2dsK2sxeTVIUm5BUzhlNzkr?=
 =?utf-8?B?azNkektqVWF6azIzck5sYy9ESkpkWFhJamdDaEViOWtybnFkc1pHU1pvMitx?=
 =?utf-8?B?dTBZbmhzZXBXcEczR2lUSjBzZzYyaWdkYUxocWNQQ3daU2JMNXFObExNOWR3?=
 =?utf-8?B?aW1ScUI2NXExWFR5Qm1SS0JhTGx0aGFiL0Z6SThNL0ZPSGNyelJ0MG85NjBX?=
 =?utf-8?B?Ylo2dXhyQy9OVkdaZmtzVmNoSHZJTjNOMmJycEo3VUJVaG9nY29KSmpRaVFh?=
 =?utf-8?B?OHRmRzMxY2hWTXAxUlp3VW5PNWw0RlVSbVpJNmpJMXd2Sy9LQVd5MmdxMGor?=
 =?utf-8?B?SlNSRHRQcTFrZGNYaW4yOVUzUGIxL1NvY1U4a2pIalhNRFpDQW1Ud2grc0lr?=
 =?utf-8?B?N1ZwcDJjQVB1T01PZ0k4ZVV1dVd3WVFvMXZPdXkvRURsanI0OXh2dXg0TEZk?=
 =?utf-8?B?c0FhU3Frbm0zdVhlS3U4RlhYN1pZd3ZmN1lybkZndlBpVXc2SHBkTHJtem1I?=
 =?utf-8?B?U090UlczLzN0QWw0QmN2V2tpZmlkKzltUXhVTkNMQmJpcE1teVZuMkdwZ0wx?=
 =?utf-8?B?K0JLL2lMS3lDTk9ablVyNGlwSGxlbk9LNlNCWGJBRTNVV3Zub0NHS1hEbDhi?=
 =?utf-8?B?UmN6cGF6TUthSk5NeWg3M1pGNS9nNVpxbkoxcnRYb3NWNlJaWEhxZWhKQUVW?=
 =?utf-8?B?Mm4rcVZVbTdrZnVKQVFlVDZiN0VuUm91QWlsZkZSV0VvdFE5cWhsb0JyYVA0?=
 =?utf-8?B?bkFmRDZuVXJ5U0wrMkdJU2Vkd2hBaGhxemhxTklGR01BcExrZ1ptd2pPdmhr?=
 =?utf-8?B?SXZGNFVIdmp1NklwdHY3T252ME5Ub2tVOXFsUVJtNFRMWVRnbkVGVXNZQ0tJ?=
 =?utf-8?B?ZG1uUDBEYTVCU1hPd3JCUG55WXVKOVE2cTlwNXFGRm03ZUVMZE5mditoZEVx?=
 =?utf-8?B?ZEZsYlRCemZXOTNvaDRBdTJxRGU1ODduNXQ1My9Ba0ZMankrbUMzZis5VVZF?=
 =?utf-8?B?RDhjcTJlTnl2bzdjVlpFTDBEY0YyQldCRWtVQ0pJWUR3cVZYQ1dPejVJUGZx?=
 =?utf-8?B?bXQvUmpxOS9oTVhsWUczTmc4SUVnN21Vb0dIVmNYWEZ3VUNCaS93Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 15214934-dfd8-498c-b881-08df15a9262d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 17:20:34.5582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkY2azROB5ze7KpoeElwE8A6ISH9l1c0QEmjDnDj1HcFXv3gVqjGR9tf0sqK1GNzF/c2sbR4yXSCn66Sedobz4cRsCI1iyGgrib6HNxylzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB338771
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

Hi Chukun Pan,

On 9/18/26 2:00 PM, Chukun Pan wrote:
> The HINLINK H28K is a single board computer based on the
> RK3528 SoC. Add support for the HINLINK H28K board.
> 
> Features tested on HINLINK H28K:
> - SD-card boot
> - eMMC boot
> - Ethernet
> 

Only on one of the port since the other one is an RTL8111HS on PCIe and 
I don't think PCIe is enabled (for sure the driver for the network card 
isn't). I see a few boards also use the RTL8111HS, for example 
QuartzPro64 and CoolPi 4B, but only the former enables the RTL8169 
driver. I know you said you tried to enable it but it said it didn't 
work in v1, but it would have been nice to state that in the commit log. 
No need to respin for this.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
