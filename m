Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779DA60A2617
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B8WqOVwl;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=fTj9Aug8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52ED282B94;
	Wed, 28 Oct 2026 18:23:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-vIY6clTJxv; Wed, 28 Oct 2026 18:23:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7386382BBC
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793211838;
	b=EnFWL+oJYNes9OtiqDhaPU+RT6aWZFZAFyIo/y1cuCHRzGja5ANmj125ENBzspkSivKW
	 Bnn86M9nnwXXV+AtjrMObn3iAiwNBnZvgz7cY/MkqMrmXA9pyuyaVp80Ei5SVo0LW4LaA
	 8aZ6lJzqG3uICiebmPjo/EtEVIvzdaTMQllWO4BKU7N8JTHEE5yd6tluDtQOfAQS+D2Xo
	 8ALHX8oyODEmReR7hZ12Le3Cxf0yyEyVQWGNqhCBbw2oPp8M/wX50JnpecLOu6h1V+WC7
	 j8ajTzJQcgr3u0p7JyeTcEKP99iq2P6DJU/FA8Zk4fFknVrtt6o6jKK4/TLR1CoOr8g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793211838;
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
	bh=0hZiLDmfAPMpkMQXHt3WDpnW5WAmqZuwarzN9eneVWE=;
	b=OFYgm8bJ/6ZfTq+xmUZTvnEb35WB28jjJ8qbsjUg5lVOk6CeHER9zC+z2JYSwc9sVR37
	 Ev0DDbi/IRqYzemQ4fogEk6jx+hSSyVtbbEQJtGoZ40xAGRubv6N7vsuY+Kg9gILM7Wag
	 TP15rqPcgHfd/hsFYuoTs/54u7yVyDmKlaxxyGdAvb92hkfnk8GPDgIWUE9FSiGbfpenA
	 FkFaqR+HcIyTBX4BuQ9xVyg0THzf8DwOwR+1Mf2Fky+TCVEy6CEDTVsEXuTUEgROcwAE4
	 St0G5bsVwcX12IkMrVIZoen01o/93/5sZO1QZeDS4mDlpowI5msSvSelBSG8ZKTnPmA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=fTj9Aug8;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793211838;
	bh=0hZiLDmfAPMpkMQXHt3WDpnW5WAmqZuwarzN9eneVWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B8WqOVwlelwLry8jw8BNdMRaC9+YNzO3u/jkaoJhy49VMVzyZp2Nj8XLfacA+d86O
	 hINCdiOA+0zBux8bduCbW1pypD879vKJx1qPwNKp5KKAedWHAKN6kRVAlKU7e7nj3u
	 /l/oPw0P2VJHAoxTTo1DNW3087jOJ6CO1c//esfhbGnvN0zJgFDsv1cdyv95wHqsjq
	 TG4PaeCdWg56uXCyPLDZcJUt1T06KBHjJaVXB2TrXLNvetFMjOIhVgzcPYrHxxwk/1
	 +9pxe6HBs10XVEg2uzNdwkV6ir0eVFLuDufzJGYHq3aEvIGstiLbYreo9I2D0Z0wYA
	 qDR0Dc1bbnAEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7386382BBC;
	Wed, 28 Oct 2026 18:23:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A4822A8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFE7D82B21
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FnXfphvfAxix for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:23:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 78D4482925
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.83.32
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793211836;
 b=mfIgSrEbqaTCHhYiHdiiQNC4RVF45DZ3NNgX8hXOjeeyawFh3U5X77f3kTtSF5wMs2VO
 v+OyF9J+zOI6CxwEbmeIg4HHP+2uFUcvUZG+0WDj/ye9dltbL0s1Cngega3ZOlbKCOnZe
 Dh18EDBsqx1mJX/7YAcXx4vXO6EGTJ8qcoxJyXxzIxuMod7MS6NhmjWeFzWUGQZCdZna0
 emsj2/xlNaamtFXGq3kxuIM/CreiApXhrsI5Rrlw4sVyh8AOQTbIAGVXEG4DUUmyVVC/A
 yeSg5YPTwO0xe3Jse8Zf/ATEpwo4OULN8a/53qaab/ViJXOznPGcv4pURKGD0l9jn7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793211836;
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
 bh=0hZiLDmfAPMpkMQXHt3WDpnW5WAmqZuwarzN9eneVWE=;
 b=JhjMIylVmG/35SdTnEEOciJy9794K9qlCW1MWkKMCWL/tevdU8s3MwdS1JKy4pI8IKxX
 GzA5al6SNIZtMtSkzalhzdk7f+735y/HmxpRgXGRS6Avn+KN40mSmza4rG9Zw6tV8SyxF
 UytqpQPh4w/7sN9jhs5f1njWc163Ph8G85DKDG2pTh5UzIfIjlCr98pr5wpwuQCC5w6u0
 Gc9nJY5SaeE1UYOmKLShoreyCMnBKD9fccvgXYd5sZr6LzngEGhVivwd8bX77UStlAfQs
 r2qgIdVMeD0mgNs+LB/C/kkYX4GXj0+DT54ltVBAldL/YDS1kuAINYWPcjWPPsvc11g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=fTj9Aug8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.32
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.83.32;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=fTj9Aug8
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013032.outbound.protection.outlook.com
 [52.101.83.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78D4482925
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUWvVDKNC1o5GmPyUH76HPMf4HQCC+MDSIYg5P8ufyoaH8CXcU/etxuMXkTsqFHPGnEVV1uuJQzin7GvdC/tjYw7m+hJ0LqptCMR+e6RNhyH5qWrmgStrhcnPYPeJZky5MT25t2s4GdmO6fRVDwoonMyKTK4y8GiHTOVF/lh+SPPi/gYfWZiVFPmMV4uZ/Hf8MSMm5hmT9ruMUAvk2pjO75QtiIXfRRS8Lb4uca5eXoqsi2e+rT7t3JhJPieO+rGvUErOH3bHCLHt3Ijybw0G/RbtPRRlce6rri3YgZbGorR7m6YD9QkyiNZZ+zfoczQhLBdrwr1xCExpOIXV/g7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hZiLDmfAPMpkMQXHt3WDpnW5WAmqZuwarzN9eneVWE=;
 b=TkOllvxFSuY43660qxFmUp754d3fOKLc6tu5K9JmWPciUKsZhEuPZp7Vbeh/A7+4lhM86pTbSO44lppQyFwO9BB1uqfYzJ2u/kzS6K3jvxlg+tvz8iO+xAs3DA9W6kxMSE/1dmJwdCaRXxL2YswdRR312oRAWKA8XvGJULje/K9vzN7Oz2sukDmub9qerBFbsZiaudxOWmAYqCeOAwm/tDlqz3vQBrfXEqmZLY3cGZ0sj5xRYMcbGVurJthX/p8V+ROq0VFJjOFhLKN9u3ncykWgunVNcWpz4jLNZnUG3sYqvJ9+A1V6TPYFpbvG4pmVAmNl0XJApvF/l7lBAlkXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hZiLDmfAPMpkMQXHt3WDpnW5WAmqZuwarzN9eneVWE=;
 b=fTj9Aug8vmFYcskQjRXaJkwIYrPAhMUqmMFhmXNQys3RCM3XS/Wo1Yir8E7eDoLddY7OUOwpcEuXe8o8rcc688lXvM8hJsY+2uYjP7xvZXCSOSsO2QX9mChA5n6xl0ifBz6emE54sFt7QRxWQtK+r2DLMQVR8qJDzOivu4JDwCs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 18:23:52 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 18:23:51 +0000
Message-ID: <179e0a6f-0dd9-48f1-a79a-3611ddb30cd8@cherry.de>
Date: Wed, 28 Oct 2026 19:23:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] clk: rockchip: rk3568: Ungate PCIE30PHY_REF clocks
 when PCI is enabled
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261015224222.1582607-1-jonas@kwiboo.se>
 <20261015224222.1582607-2-jonas@kwiboo.se>
 <16574e5d-6d1f-4419-8519-b1cc356797a3@0leil.net>
 <6a5e35fb-2bfb-4551-a9a4-2f51a1cbdaad@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <6a5e35fb-2bfb-4551-a9a4-2f51a1cbdaad@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR1PEPF000077C3.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::467) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 6edec58f-134d-4121-6e68-08df35209de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261028144727099003|261026140227099003|4143699003|11063799006|5023799004|56012099006|261022105027099003|261009223027099003|261021121427099003|261021123027099003|18002099003|261026121527099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: Qbnr97oWdyp2Q0XzE2e67FZdR+0IJo0oq79j50Qq5i2Plj7m2+TJ35LP2g0fZdche6H6m0BK94B7Y9OoRGCe703i7GnVYwVmylRiX9FenzAbbVzH44qvRwWkR3S1UHBcFHbpPlh+2VO0y0vBrxp3COLHgeBCUyWFaDWsGvq8Q4/ROltYkH73mCifzFUDmrXuY4+BkfmzAfzNWJ5DbJCEu8NgrFtctjpD6/V63b/Lpn4ejd1TUJJL1xMYQixwQA5s5StYEvxuE2Gkj8TsJRRWHhivDUOUFQxTm27nlGem+0a0GN7cX5OHtGru5Z3kVSPXeCMrNmkDDGQ05Eyk4DiMo0HS2yP9JnPhlrCpmMGC9OHD2LJtnrB14qJKDfBSiimEmsZw/L04J3YdAE9Aow/zf2mLZZW0JrLNYr3aG0JVSvMZHv5yVhQ3DyOQb1L9brUse7yO92/W/kTxiOIVymF3OKbuifnW4XSqDfZZUtkuBQW58wTRFOXTL6cE0atksERRMDNpaOiMz4NmToSA7R7rQ/mcX6ZZ4b4wGkMdxOCFvvE6stQm9Cw36v1n0PeXV9MMrYDY7RWmbgOa4wNRfDKXxh3iti3FizooMIPDBNOjAIKztXUCGFVAEaRu70dZ0GoAvR90EZxeNNNGZyjvE0pGoTUjyym/MEuiI1JV6ysD9bU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261028144727099003)(261026140227099003)(4143699003)(11063799006)(5023799004)(56012099006)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(18002099003)(261026121527099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdhNndicXU4UkpmTi82TzBONjRPampIVVppWVZHSzV2STVOM0V6UUt0bzNj?=
 =?utf-8?B?NVd5N2R0RFdKYnhSbkRUa0RrSHBvQnhOT3ZQVWZUbGVsN3I2VjBwTUlwK3A2?=
 =?utf-8?B?cVRHWXJvZmVnNGE5SS9mTWRSTkdIMWhZT1Aydk5WQ3hVeEJhSVFLcU1lamV5?=
 =?utf-8?B?dUlVRERmc3VQZXpoUUxFdFoxRXo4NlhCVlNXaEdHUkxNOXY1MTFUNWErc1FR?=
 =?utf-8?B?djhtSFZtNDFOaklSVGJjRzFjMHc0UVoyNklzUEtLTFF3MHlDS2xBR3MyRHh2?=
 =?utf-8?B?NzIxVkptSkg4Mi9RY2Nuam1FZGJFeGVZVG5KMU10QjI3d2J6S3FQY3hjYTNE?=
 =?utf-8?B?VDQyOWZhSHV2ZzNERExzQVB4MHMyVWk3SGVtTzNpeERCdUJFdnNZTFlhTFh1?=
 =?utf-8?B?VkEwcmpNcC9acENJTElibEcwc0VHRHJHR2FZSStkZkptQjBTQVhJcklNeHdz?=
 =?utf-8?B?djBiNWZ0QmQ3T1AxeW03OFFxdjc0MjZBV0RUanZjcWFaZW80a2M2MnhBZFV0?=
 =?utf-8?B?bUFqL04zTTdFRTRaN0RuWXRGTmxLdkpqeUZLclQ5SVByK29PdURYSElqdnRx?=
 =?utf-8?B?d3J5aENvc1BGdEhwZFVVcWxqZWhLMENvZWdiUGlxUkR2cXJHZjduNXc1UzhC?=
 =?utf-8?B?TWozMEZwL0FZVlJnZGlsYUZaVExOcmZ5VDRVQ3p4aWRwUlZvd3RLY1IwWjBn?=
 =?utf-8?B?ZG5jS2oxSEk0OGFRUDNsbkJWMTZKZWRPV2I0NUV6SnJ2N2IvU2Y5NmN2bEFt?=
 =?utf-8?B?R2hqL09zY1ZJdUVKL3UvZURxb05xVG1mTEdtamRCakdkUlRKWUwvRW1Pbktz?=
 =?utf-8?B?NWJ4Mk56TDJMR2E0anViQVlXbzZLQVpvZFA2eW9GaWkxRkFUdXJNUEdZNXNy?=
 =?utf-8?B?Z2N6blozN3hlTGRuL090ZzlPb25lUWZodXVoWWxzVDV5UEg1T25uZitRbFlM?=
 =?utf-8?B?VjVLMys1OEttd1R6c3VHZUQ0SHpWR1FiOWxiRWt6ak9EZDZvNE54Q1hTWkNu?=
 =?utf-8?B?RzBRWm1pUEk0M2VQZ0V4QVRYNjBncnYrN2JtVnNCNjhjTC9VdVEvUzdiSGRO?=
 =?utf-8?B?OHNxVDZVdDJqM1dyZ0kxL2YvUUtVQU9uZ2MyazVDS21KbDBGR0RTTnJYOXpT?=
 =?utf-8?B?T0ovMkVtdWZuRDU5eHRTZjhUVzl4WmVDb2txNENvSWx4amJQUE81YWRnVEFJ?=
 =?utf-8?B?eUVBZ2pQR05teEg2K1lQSWFSWlBycUdxTzdHYWxnU1FmQkhWenBSWDZzNXZy?=
 =?utf-8?B?V0dKZzhlUlpGMmNwQVdSSmtXUy9KN0N4OVZoSVd1aVphVzlETUQvWlZoQWVT?=
 =?utf-8?B?UmZmdUkrOHBGQTlmZFNvY0p4b3FZZlBUbkJreFpFK0ZMbGpGUGdMUlVCd1lL?=
 =?utf-8?B?ZG03L3JrRmE3c2VTQ2xlanpIbmRBS2VlY05NNUhpeVIrUXlyclVkR28vQzdQ?=
 =?utf-8?B?dlhoaEI2SU9PejdmNFRvamozN2ZEVUNJWjFjazh3MVNvVGpTbEUxVXAwU1Vt?=
 =?utf-8?B?QW1LL3lqZVBmN3dSOGFoSWorY3dhM1U4bEQyR01JNnRZbVBCTzZNN0NkWDVq?=
 =?utf-8?B?eGt3RFFoeTZKMzNlQlFVR2NzOElCQWY5ZFE2TElqVzZ3STkwNWtTMkp3RTNl?=
 =?utf-8?B?QmlOc3JQZGhLSUxLTytMVytqbUFXRERBL3IyRXNHRnk0MGdZcEdHVWRqYmhu?=
 =?utf-8?B?WlhDMm9aU1F2NzE0NGttWHhMWExCcCthV2JWNFJ4VmZML2lkVGMzZjRWUlZK?=
 =?utf-8?B?TVFqa1ZDTVROMkVaUnM1V0w5SFRzc2ZqK0crYnRxZG4xQlNJaGQyUG5mTDJ6?=
 =?utf-8?B?aWVRdG5tcVpZNGlGVjc4c013c1Y3UTZSckRNbEs2WEp0amlINkVVTktiL1Zm?=
 =?utf-8?B?QjBGN0ZBL3k3Sjhxc2FRdDB3YUMvM05OcmFmcWlZaGN4dnFWOWo3Ti9OTlRU?=
 =?utf-8?B?SENQQmhsYjJ3U0xCam1ieGJVdjA3Rlg0Skh2MytpdjhueHpQdCtjMjhxNjVL?=
 =?utf-8?B?OXJCMVlmZzdhSmRDdlpZZlJsVFFLaloxYmNQbUNNRzY3M1liQVI2ZnlCMUdi?=
 =?utf-8?B?eWJhR0tWV3R6WW92NldPcEM3eTZuaFM0S2FDYnFEZlRabFlZRGZMRTJ5ckZi?=
 =?utf-8?B?anphdjBxNko3eGp0REgvQzNhUGZ1T3dpNUw4QTBHVUx4T1dmVnJQbnBKZXVP?=
 =?utf-8?B?TE1naGlOcyt2Tm1TcDQ0VVJxaVExaXJQV2dsTG11L0EyemM5dERBaXhGa3Zn?=
 =?utf-8?B?TEF1TzAzRnpkcStOVW9ESTFDVndpRGpyU2VqTzZDVDNlRzZoTUh3Sm0vSWF6?=
 =?utf-8?B?bkNPL0xYVytZbVRxWUVpbGxCbktyVmp4ejNhWXA4dlQ5K1JwNHhzQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edec58f-134d-4121-6e68-08df35209de9
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 18:23:51.6277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwY5GYRREYl3rHlfIvxzHgesFh3nGmwfqO2dxEdetjuQrnXGZ9UZXKH4lvBo7hEhlbL8lrN7081RbW3avk4RQsZ+B2UIUvAJ0V1CCgDA1Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/28/26 5:57 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 10/28/2026 1:41 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 10/16/26 12:42 AM, Jonas Karlman wrote:
>>> The CLK_PCIE30PHY_REF_M and CLK_PCIE30PHY_REF_N clocks are by default
>>> gated coming out from system reset. The probe() ops of the PMUCRU driver
>>
>> Are they? I don't have an RK3568 board so cannot test this, but the TRM
>> says the bitfields are 0 at reset with "When high, disable clock", so I
>> am not sure what exactly this is for (except after a reboot where the
>> Linux kernel has disabled the PCIe clocks maybe?).
> 
> I guess the TRM is incorrect, because as I mention in my commit message
> these clocks comes gated out from system reset, or I would never have
> phrased the commit message as such.
> 

Well, it could also be inferred from the fact Rockchip enabled it in the 
CRU driver unconditionally. So I wanted to make sure it was indeed 
checked rather than simply inferred. Thank you for the confirmation.

> See below runtime log on a Radxa ROCK 3B (from power off state):
> 
>    DDR 5c7dbc4d49 kwin.chen 26/05/21-10:58:25,fwver: v1.26
>    [...]
>    out
>    PRE: pmu_clkgate_con[2]=6000
>    POST: pmu_clkgate_con[2]=6000
>    
>    U-Boot SPL 2027.01-rc1-00097-gec7e6bacaadc-dirty (Oct 28 2026 - 16:35:51 +0000)
>    Trying to boot from RAM
>    [...]
>    U-Boot 2027.01-rc1-00097-gec7e6bacaadc-dirty (Oct 28 2026 - 16:35:51 +0000)
>    
>    Model: Radxa ROCK 3B
>    SoC:   RK3568
>    DRAM:  8 GiB (total 7.7 GiB)
>    PRE: pmu_clkgate_con[2]=6000
>    POST: pmu_clkgate_con[2]=0
> 
> Using following code in probe() ops:
> 
> 	printf("PRE: pmu_clkgate_con[2]=%x\n", readl(&priv->pmucru->pmu_clkgate_con[2]));
> 
> 	/* Ungate PCIe30phy refclk_m and refclk_n */
> 	if (CONFIG_IS_ENABLED(PCI))
> 		rk_clrreg(&priv->pmucru->pmu_clkgate_con[2], 0x3 << 13);
> 
> 	printf("POST: pmu_clkgate_con[2]=%x\n", readl(&priv->pmucru->pmu_clkgate_con[2]));
> 
> I guess theoretically it could be the DDR init blob that gates the
> refclks, however running bare minimal TPL on same board show same:
> 
>    U-Boot TPL 2026.10-01297-g83bfcb8d6e91-dirty (Oct 28 2026 - 16:45:25)
>    x0: 00000000 fdcc0098
>    x1: 00000000 00000008
>    x2: 00000000 fdcc1000
>    x3: 00000000 00000006
>    x4: 00000000 00000050
>    x5: 00000000 00000000
>    x6: 00000000 00020002
>    sp: 00000000 fdcc0f30
>    BOOTSOURCE_ID fdcc0010: 0000000a
>    PMU_CRU fdd00000: 00004064
>    PMU_CRU fdd00004: 000014c1
>    PMU_CRU fdd0000c: 00000007
>    PMU_CRU fdd00010: 00007f00
>    PMU_CRU fdd00040: 00002063
>    PMU_CRU fdd00044: 00001481
>    PMU_CRU fdd0004c: 00000007
>    PMU_CRU fdd00050: 00007f00
>    PMU_CRU fdd00100: 00000080
>    PMU_CRU fdd00108: 00000001
>    PMU_CRU fdd0010c: 00000001
>    PMU_CRU fdd00110: 00000800
>    PMU_CRU fdd00118: 00000001
>    PMU_CRU fdd0011c: 00000009
>    PMU_CRU fdd00120: 0000050f
>    PMU_CRU fdd00124: 00008bbb
>    PMU_CRU fdd00188: 00006000  (pmu_clkgate_con[2])
>    PMU_CRU fdd00240: 00040020
>    DRAM init failed
> 
> Above should hopefully make it clear that the reset value in TRM is
> likely incorrect ;-)
> 

Wouldn't be the first nor the last time this happens :)

>>
>>> unconditionally ungate these clocks to help ensure PCIe works in U-Boot
>>> proper.
>>>
>>> Change to only ungate these clocks when the PCI Kconfig option is
>>> enabled for current boot phase to delay the ungate as late as possible.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> Changes in v3:
>>> - New optional patch to help delay the ungate of PCIe ref clocks until
>>>     U-Boot proper
>>>
>>> This patch is strictly not needed, however it seems very unnecessary to
>>> ungate PCIe ref clocks in SPL when PCIe typically only is used in proper.
>>>
>>
>> Considering the kernel seems (I had a cursory look) to be able to
>> control those clocks and have them handled via the pcie node, it seems
>> fine to me to possibly not have the clock enabled by U-Boot (e.g. with
>> U-Boot proper or xPL not enabling PCI).
>>
>> So, I'm fine with the content of the patch, not the commit log. Can you
>> please confirm that they are indeed not at 0 when reset (and/or that we
>> do this to be safe when doing reboots) and rework the commit log?
> 
> As mentioned above, the commit message has been correct from start, so
> please be explicit about what you think is unclear and needs to change.
> 

You could have just said that it doesn't match the TRM, that would have 
told me that it was checked IRL.

I can reword the first sentence to

The CLK_PCIE30PHY_REF_M and CLK_PCIE30PHY_REF_N clocks are by default
gated coming out from system reset unlike stated in the TRM.

when applying, does that work for you?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
