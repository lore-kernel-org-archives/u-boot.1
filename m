Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB63C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 11:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E6FA60731;
	Tue, 15 Sep 2026 11:23:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pb6tpiR_DSbz; Tue, 15 Sep 2026 11:23:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1876660751
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789471387;
	b=evEs2+Wysyi7j3xZP6Wl5lhXf6rdpNqNeImknZavvKPPZg694tTGxbShfX5EbnM2TG2g
	 kO3FJ2O8t7WbBsN86QbVQCVDaXPDCOEm3tLuH0yTFKBwFkKCSGVPqPKUQj6C5f0Q0mkUh
	 3lIIDDjDQvLhY44niZ8mon4ElpsL7QyVEdSZJnmBjRLvY+61jJWUQrvhD8bO7hAJiPZ28
	 cA4KvzlUWFxdiE5Z0HiLBZAVYd1gGT2MswdwdtfPWAHABE2lhusYPwcXpbd7KR6s/cwj7
	 w2f67/pWsK9v+kI1ZIXtr1bln9Hf8h+JKNChypsTs+aMvQV4QvrP35tkgvueCjlAmVQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789471387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=oV4CBAiVnM5Fp/6lw1HFVm+W9tHjYq7yunqw8L5SrsU=;
	b=s12Rr6vuJx2DOiUyI0VzxVZsNkBbZzSOgI9dY+GvSBwBLyTvOLv/5qsuDXsm+1mrKUUs
	 TxsPRoAz5bJDaTuqdeZnP1+G2cjNa88mJh9ZahOEJnfyn0ecPe1TBc/95OsPZkM+QVqXi
	 TCxdHytSCsttO/jyp12r3QwNrvF8XBKDeYLBrSo6fbNHPnmGcv95nU8sgRwvwM8PCIvxb
	 Vxv6/zeS/JZ4QgtRqESoL6Cq9Dr/NbxWipThUDj/Sc0+cYnY53eCOyzxL7/dXqPai9HKE
	 EJbAreZDqkq9sL6irob4ek1Odl+zmaMGKa+drGpCM4d2Y2BZpPe1wpvjVlwmOnnsA/A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789471387;
	bh=oV4CBAiVnM5Fp/6lw1HFVm+W9tHjYq7yunqw8L5SrsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c/1fhAilT6sVh6Ua5hcxPrBK1efQBctIAOOHIZBOJ09xiJSfkb58YKqq55la1ddgt
	 yBEm6RzHQJoLfwvfTPVQJrn2lYvZ4KBjHPSR/6D8iYeg5jOwKhsuR0YbrzWSLx3jy0
	 /Ch/ubsdDkQJTPGUFpT3ZQnZBOghHlxAqxGCNybbQS252kA6Wc9YcC18C5NRzE3FMK
	 pN7BuIJntm15fD6iWeOEWlBWWqvuWXQ6AcRvcGSirCl+p2htE4v81LyB/+UOJ0Fu2d
	 pnSTjt3cIgHEhrfG7VCQ6upjdIobWItYPHDngvQjh9l8C+Y50sxu5eJZAoDw1fZuBe
	 vgKGNdsHb+r/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1876660751;
	Tue, 15 Sep 2026 11:23:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D871F2E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 11:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE0974005E
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 11:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r8ccdr_y0c-v for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 11:23:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B40F64002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789471383;
 b=NmxDzkaINCADIe2d16orS0Bu7uw6glU4U84GNMOiY+4cV4kjiscANXq+y//HTsUWnZE6
 lF5eMKCdRElP0JNk/lo1rbh5oyBC5RXkH9HlZUpOUcZh/5OW3uMIKZZsR8yDWBbNXPXq3
 6hxY0cPog9lW8P98dmYGcJfsYLMPJf4cAJC+889NPOMjuVMC4NwtMniQIOyLALlfnUjyM
 VvWussAzC4orZXKeBxBEWmIsPL/r1omyhIYjMB7J9ndb9N8osVC7HtShZhXe04Y2aiiqQ
 MqJjwDhP8nbPyRzfjEvC5GDPZRK4sHeGasG8YZwln3qYlFLCh3v5aPRWvu6cyuwh2Kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789471383;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
 bh=oV4CBAiVnM5Fp/6lw1HFVm+W9tHjYq7yunqw8L5SrsU=;
 b=sjG3NS/bcm9HHxpH/dMjLZ0c2/+/ZsGUw6CGPwilyUOKbf4Ymd8rpP6JXhKrSseW89aK
 gy4CfYlKIOtIyD+gS8Ij/xFUVSRtLTypAUp7lhCIZD4mmujfyW2cRMSe606n+0827COaD
 ZxR7F+nqhZr+5vZiGttRdXzyXoLMgEC0nYUTpjMD4CEmtGfqbKptQjmuXZJsOOUHx6cj7
 8zrrItIORUx6SlbrwP0WTfRBKxlrhFmeF2yBrlMRUdcWtYdvqV4NNPxAAYuY2tfzkTNxq
 A+yoFiNczsyLuqWh2ZLYmYgHwwc+Za7yNeOYYyRnDahL+LD2W0eIoxpJiAKXIN7bX4Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=dYFVuU6q; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=dYFVuU6q
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B40F64002B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 11:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FC9wZ9TbMjdLzIwN8IfTy1XS5bJmSkRzgUZCSetEF+aUlaH3wuVF2E4mHn+zGWJCKarlpmOqlop5nQMBioKMhtvx4OPeT2tCA62CMw5YiD1DyZLIwYTUK8I+z6b6U6Jof84oIZAus5wEh/7e/FgN3uTxiM9A0rL9SgjtcfF6DqxY7iMxJIn69PjZsoG9YCUyY7kPF0Z0p3lp1blGzxijzP5IMurh9f4TXyOukQwOjJS7Ls0fqbk33qixHAO/GjpHRTo59MF9D5zQswOEwurBZ21oB4B7xFdtUTCmxXzZhixnAEGYIP+Prj9CEy6c1Hs+0lQ96GZdlMmFFOQiH1tT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV4CBAiVnM5Fp/6lw1HFVm+W9tHjYq7yunqw8L5SrsU=;
 b=uxYAoH9bTUjD6T4a0vFxWzW+UfV3pVneE9UcNMzAX92luEo7YlJoNii8kf5ZlLLzESs9pVlZZf36DNQDr89cUBB5CIPVWkprojo1d/21/wOyKkY88JgbyzgVstPAXfEze6zO7Fc3qEv2cgVoKhZp7UBzsrYAryQ7CL9wvK1iWcIybOEm7yXSs496hkbqXyhcRMOy8r2WWSidIpwcDcDdzFlavKAHdplP9jYZKUxO5QiokM3b5zjyKc5r70ltczignrIjggdvNDJcUrlWlrzWfUBk+eg5OxlJer9ZgyQUpxHu0go1poQmU1zGJdixpTGb3HdWTcr8YOmktX4zcriKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV4CBAiVnM5Fp/6lw1HFVm+W9tHjYq7yunqw8L5SrsU=;
 b=dYFVuU6quntUIjkU/YMMK91k9G7J+FbOB7yuN6PBTUJHILYJMroWaUp8YIL+uXy7Nq+GPbgTEYkfK88UEWLk/CbI313eiQHjB0n1TLSmctztnwzEybLDygsIkNkaLyP1sOsgn7t3JU+i/u3zNLY8vOxH2tXgZRtb8RSz5Z7oAY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM9PR04MB7636.eurprd04.prod.outlook.com (2603:10a6:20b:281::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 11:22:55 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 11:22:54 +0000
Message-ID: <49bfa1b3-c159-4816-8a09-ac0eb81add0e@cherry.de>
Date: Tue, 15 Sep 2026 13:22:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] clk: rockchip: rk3506: Use FIELD_PREP_WM16 macro
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-6-jonas@kwiboo.se>
 <fd9af4e6-17f3-4b3e-99c0-b6bb5a1ca79e@cherry.de>
 <7cb02287-c541-40d2-8a2e-6ab018f44a91@kwiboo.se>
 <2be8dfb1-517a-4326-949c-6a62bc11060d@cherry.de>
 <1a6a8ea6-4999-464f-b515-b97ad61b8cdc@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1a6a8ea6-4999-464f-b515-b97ad61b8cdc@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VIVP296CA0011.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::19) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM9PR04MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c69c93-d6d5-40a7-0757-08df131bafca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|4133799003|4143699003|10067099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: KUoN1WW2zuqGK3ftaV68pEvj9MR2XjfkkU5G54QznR8sNzZiwBVNPhgm4gYHw38TpQ+jdSXi85W4DrQi4sFuNsL/60oy1hZelBs5PZjVGWGlBzWYka0m6TdQWYCBxRBKgtT1m1SZ77NhcIoHFykXapOpSzfg5ctX3EP8HoVk6DvpYbKlnHhVscIwNWMhJIHETC6If4wcJoOwBU37liAccIxrAbaoyahrpasrKSOOxolJ9834JYq24of4OiZMlBmRxVBZnj1diGA1ooj4QbG9WysFQUUL5hOht96J8XQCZdpdtMKNVvgJRF5ov4v72PZ3sJVS9+stWt70SemGep76f/gJBroDjM10OFyadyFO2Zl/YG3IBItMiMW/vlaOPJYYwwow1gAMlj6w2exz7ceVcq20ZR6e+Hnz+guQB+rkTzUsa93dotIhYmA+lR0xJX6H1NYP/g/QtYvy1VnNj8IjHFFWW7rbHmZJkHZuo8dpwfSSzUB41dgJkr4ic9600ooZytTXZI0eIyH/zGN3lGE935UraOX5OLl38Z6+dnI/7KVLEqkfF1YLdB+Q/0fSwGYduliPUd73S8okCaYJN78TiFb9nrHtA72ySAQw3iroIEDwwuMFHyD6iz1yEBuxN8Qj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(4133799003)(4143699003)(10067099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjZHNFlSYkIrNlB5bjVIK1k3bHcrWEt2bWxPZWM5U0sraStRbmxGa21Mb3ZL?=
 =?utf-8?B?VWxOQWptUlUyYlpXOVM5Q2FZREM2Zk1DTnB6cHZieDBXYUh2TC9mVjg0NWwz?=
 =?utf-8?B?NkppRjdlampGeFVsMjBabmd5eVBua01aZXdqVUZCUDVQN3ZsQXNYVWxwbmda?=
 =?utf-8?B?cG1tckhTTTdQcmlaY3JpYmdzeGFubDBWc0lqcnJ6TTYvWjQ2UXczU2UyUlpS?=
 =?utf-8?B?V0syTHMybFE0YlFTVkRRZjBUVUFhdGRtSEtKRDZCVzAvVS82VU5sY3JXRUQx?=
 =?utf-8?B?c3RhTUxjTC9kc0k5V0RQWmhVNlQ3VExldVU1Q1V0VmQ1RWxZdldUOTJtK1F3?=
 =?utf-8?B?bVhSMC9nUlhzN2ZmbDJ0VUhPUDYzRW1YL2UzREVGRnFVUEw5bXQ4TlpmK3dh?=
 =?utf-8?B?NVBId0M1K3hmVWRhUlljdCtPQldBb3AzaUJMbS9MU09HWDJiNVhIZDhORHl6?=
 =?utf-8?B?V2NoZmQ0OUdJZHJTS3lQRWYydSs1QkJ1aWZVeTI3QzFIem1LR0N6N0Erd1NI?=
 =?utf-8?B?TXRiUTlJUHljQzZkQmk3SEsrS3RSeEN1MDk2TkdtZzR5TmFETVMxTkcxaTNQ?=
 =?utf-8?B?d0dObzFLSGxIcXhkYU16QWNwTGhJTm9TOHVSanNyQTE2Sk16UFQ4V2FZalpi?=
 =?utf-8?B?ZXVtUWF1elAyelVwZ0RVTUs5bzdQbVZPOHFaeTN3Umx0N0xrZ25wZjROZkZq?=
 =?utf-8?B?N21lWHNucEgrYVNYbXFYVFhlUHhCMUlvQXNiRyt1TmJEVllrSjJlT0c3anQz?=
 =?utf-8?B?V2dMQytHVWRhbW1EbnZwczhoZzBaeFJrMjlvbjQ4REVOc0duVXlqTWxOelNw?=
 =?utf-8?B?T3JOc2w0T1hockZua3JubHovSmc4Mm5oQ1dPcURSWjJjNkwxZHlZa04wZFFr?=
 =?utf-8?B?WHMwOTlzWnpmc2NzN2pxVVlHZXV2L29odjlnRFdRWHF5NFBraVZKeGxqaG1l?=
 =?utf-8?B?K0pVTDN2NUJlSUFHbUdSYVJ4OHB0dk96NmdxN2pDeFdyYzB0Q0RGRTdybzZD?=
 =?utf-8?B?aTVIM2NGSU0wVGg3SlB2SkpMSVlWdEZiWlgxd0h4RE1kd0ZPOUVrNXpRUEZO?=
 =?utf-8?B?aHE2UDlFTzIvYUhNL3NmN1VuamlwbnlNYU1YREpiWEF3bWNJZStWU2UyMSs4?=
 =?utf-8?B?S3dpS056R1NlNFlvL09FemdpUE1zNGtJK0kycVhSQUNtdGorTlc2eGxXUFZR?=
 =?utf-8?B?K2ROQS8wUnJVWmxrbDE2S1VDNkV4dTEvdm9CZ2dpb0JKYndjbWw1a1BySU5m?=
 =?utf-8?B?ZWZJRXZyRFFPeUJmQzdlUXRRNUNCRTJDVGt1eFZZUk9mdXpJdFZBOFlrUnNY?=
 =?utf-8?B?Y0Z5K0VEV052N01CdHNBbzVUNFRVV1c4bkMrVFowUEVPU0gzS3pKMjF2TW9n?=
 =?utf-8?B?NVVpNmRPSjVOSWswRlA0UFY4Z3YrNGhCZGEyWnBFalFqTng3TU9uc0pMT2d2?=
 =?utf-8?B?YTNmcTh1SWl2d2xMU2R4N3VnbldxdHBYMTh6aUtZYm1DdmpuZEtjRklrckp3?=
 =?utf-8?B?ZUdkQmRHeTgwS2NlRGk4TDdNZXd6bFN0NGw4RGw4MmczYkZ6VFZMdFpISWpE?=
 =?utf-8?B?bW9PSGpVVk9yZmFWdTFEanJDbnBZMW5KWmw2RzdYNHFpNFlCOC9NT2tTU0Fo?=
 =?utf-8?B?ZGZ1N1M1OFgwSFlvRWRyQ25mc0tvVVAwMVdIdjNZbXJBV0MrSWlEZ2Z3Y3Y5?=
 =?utf-8?B?SzB4aFNsKzcvdFkrNzRjM2I2SjlCczZ2bVZSaXl1T2hvaHJMMEJYLytrN013?=
 =?utf-8?B?USt3enpIZHd1a2R3bUZ4U3laVVJqZC95b3F0NWNxTms3MDZVZ0xDUUtHUlN5?=
 =?utf-8?B?NGN0dGQ3NmdsbVJDeWxtREpyd1RPZzdMY2ZpNWE0YnNEeW1JQVZoZEJsKzdM?=
 =?utf-8?B?VS9GY1daUVdLYUVMSFF0c21wME5ha3FwdkgwSzJCbXo3Rm1GQkRFcytIS3F2?=
 =?utf-8?B?K0t3R2pXcVdmVzZYTENRb3F2RkYyMkk5TVJPWkpxc3Fxd3BjZWlOS0hlaHVM?=
 =?utf-8?B?OWR1WG1KRU1FUEFCck5qY2RSdjg5b2hJQUJ2SzE5QlhZYnF4WEZYTzZIOHpM?=
 =?utf-8?B?NjJ2YnJJWGhiL04rYUoxRERCNENnRlNtamdpbFhBSFIvelJNWmdTOHNqR2ps?=
 =?utf-8?B?OElQVVFUSk9EbWdKc2hFa1cyRENYMEhFMkJSNjcyMU82Q1dyejVOYm90RnVY?=
 =?utf-8?B?eHkyMDR4SnJQTEtMcXhBMnVvcDJ6SUcvQWMza3NMOTdab2RDbVIxdGd0Nk84?=
 =?utf-8?B?eVdUcXcrbjZEQXQxSlVCcnFDMFo1S1BXRTFYeFVYNSs3WDM5c0NneXN4djJq?=
 =?utf-8?B?R1cxRzNxK1ZUR05SbjBGdUltNlZETDRTdXpIWENVRzNPcGZKdDlmQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c69c93-d6d5-40a7-0757-08df131bafca
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:22:54.6892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLwAhB9yx0dMjEAp/t7sMbuKZVAOs7MpsHd9VkjdUPkFPhNCbjV9S89y7LCGlfLYb/ljzDL7oTqArrRQWlJyIMyQ7HrJ6qPG6hsClxeHJyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7636
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

On 8/24/26 6:56 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/24/2026 4:54 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/14/26 10:16 AM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 8/12/2026 2:42 PM, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 8/3/26 9:09 PM, Jonas Karlman wrote:
>>>>> Change to use writel() together with the FIELD_PREP_WM16() macro
>>>>> instead of using the rk_clrsetreg() macro to avoid having to define the
>>>>> mask as a parameter to both rk_clrsetreg() and FIELD_PREP(). Also change
>>>>> to use u32 variables consistently.
>>>>>
>>>>> No change in behavior is expected due to this code style change.
>>>>>
>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>> ---
>>>>>     drivers/clk/rockchip/clk_rk3506.c | 195 ++++++++++++++----------------
>>>>>     1 file changed, 90 insertions(+), 105 deletions(-)
>>>>>
>>>>> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
>>>>> index e156bf19a6b4..7ccab313e6ec 100644
>>>>> --- a/drivers/clk/rockchip/clk_rk3506.c
>>>>> +++ b/drivers/clk/rockchip/clk_rk3506.c
>>>
>>> [snip]
>>>
>>>>> @@ -770,7 +759,7 @@ static ulong rk3506_fspi_get_rate(struct rk3506_clk_priv *priv)
>>>>>     
>>>>>     static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
>>>>>     {
>>>>> -	int div, sel;
>>>>> +	u32 div, sel;
>>>>>     
>>>>>     	if (OSC_HZ % rate == 0) {
>>>>>     		sel = SCLK_FSPI_SEL_24M;
>>>>> @@ -787,10 +776,9 @@ static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
>>>>>     	}
>>>>>     	assert(div - 1 <= 31);
>>>>>     
>>>>
>>>> If somehow div = 0, then this will result in an underflow. Because it's
>>>> an unsigned type, it'll wrap around and start at U32_MAX so assert()
>>>> should catch it. However, assert() is a noop when DEBUG constant isn't
>>>> defined, so this actually does nothing.
>>>>
>>>> We should switch those assert to something that actually does something
>>>> otherwise we could still very well attempt to write a divider that's too
>>>> big and have weird behaviors instead of outright fail when we know we
>>>> cannot do something that's requested.
>>>
>>> I was looking into trying to use assert(FIELD_FIT(...)) to validate, but
>>> as you mention this does not help for non-DEBUG builds.
>>>
>>> However, I have been playing around with something like following,
>>> still not sure I fully like it, please advise.
>>>
>>> static inline u32 get_divider(ulong prate, ulong rate, u32 mask, bool divisible)
>>> {
>>> 	u32 div;
>>>
>>> 	if (divisible && prate % rate)
>>> 		return 0;
>>>
>>
>> What is "divisible" supposed to represent? I don't understand from
>> reading the code.
> 
> "A number is divisible by another number if it can be divided into equal
> parts with no remainder."
> 

Yes, which is what prate % rate == 0 would do.

> Basic idea is to keep existing pattern, we first check if rate can be
> divided exact without any reminder, and fallback to do best effort to
> get closest rate. Divisible was a word that seemed to match this meaning.
> 

You set divisible only for 32K and 400K but not 24M. And after reading 
the code 5 times I now understand that the only thing you care about is 
that the *last* call to get_divider() sets divisible to false.

If I remember correctly, we're supposed to take the clock configuration 
that allows for a frequency that is below the requested one, but as 
close as possible. So the logic here is kinda broken, you'd only select 
32k or 400k if we can cleanly derive the frequency, and default to 24M 
otherwise.

Take me requesting 31KHz. It cannot be cleanly derived from neither 
32KHz, nor 400Kz, nor 24MHz. We'll end up trying to get it from 24MHz, 
while the max divider is 16 and we clearly won't be able to derive 31KHz 
from it with that divider, so we return 0 and we error out. Instead, we 
can at least derive something from 400KHz by using divider 13, which 
amounts to ~30.77KHz. So I think we should instead just always return 
div if it fits inside the register and do maths to figure out which of 
the possible parents provide a rate that is lower but closest to the 
requested rate.

>>
>>> 	div = DIV_ROUND_UP(prate, rate);
>>> 	if (!div || ((div - 1) << __ffs(mask)) & ~mask)
>>
>> I scratch my head looking at this so not sure it would stand the test of
>> time. Would:
>>
>> ((div - 1) & mask) == (div - 1)
>>
>> work better instead? If your value masked (I'm assuming you want to use
>> the bitfield mask here, so all bits are set in the bitfield) doesn't
>> equal your value, then the mask cannot contain the value.
> 
> Correct, we want to ensure that div-1 fit inside the field, i.e. same as:
> 
>    if (!div || !FIELD_FIT(mask, div - 1))
> 
> However, FIELD_FIT only works with constants, so above was a quick and
> dirty unpack of FIELD_FIT to test the idea. Hopefully there is a way to
> instead make use of FIELD_FIT and not a custom re-implementation.
> 
>>
>>> 		return 0;
>>>
>>> 	return div;
>>> }
>>>
>>> static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>>> 				    ulong rate)
>>> {
>>> 	u32 div, sel;
>>>
>>> 	if ((div = get_divider(32000, rate, CLK_SARADC_DIV_MASK, 1)))
>>> 		sel = CLK_SARADC_SEL_32K;
>>> 	else if ((div = get_divider(400000, rate, CLK_SARADC_DIV_MASK, 1)))
>>> 		sel = CLK_SARADC_SEL_400K;
>>> 	else if ((div = get_divider(OSC_HZ, rate, CLK_SARADC_DIV_MASK, 0)))
>>> 		sel = CLK_SARADC_SEL_24M;
>>
>> Can you really not divide from x24m as a parent?
> 
> As mentioned above, final param was just to signal if we need exact
> match / no reminder.
> 
>>
>> Also, please do not assign a variable within an if condition, I find it
>> very difficult to remember that checking an if condition can have side
>> effects. I can suggest:
>>
>> div = get_divider(32000, rate, CLK_SARADC_DIV_MASK, 1);
>> if (div) {
>>       sel = CLK_SARADC_SEL_32K;
>>       goto div_found;
>> }
>>
>> div = get_divider(400000, rate, CLK_SARADC_DIV_MASK, 1);
>> if (div) {
>>       sel = CLK_SARADC_SEL_400K;
>>       goto div_found;
>> }
>> [...]
>>
>> return -EINVAL;
>>
>> div_found:
>> writel(FIELD_PREP_WM16(CLK_SARADC_SEL_MASK, sel) |
>> [...]
>> return rk3506_saradc_get_rate(priv, clk_id);
>>
>> Or use another function for
>>
>> the writel+return currently at the end of your function and call that
>> instead of a goto.
> 
> Yeah, I was considering goto and extra functions, but wanted to keep
> the logic as small and simple as possible.
> 

But I think the logic is broken unfortunately. And I really dislike that 
we need to remember the last call to get_divider must have divisible unset.

> I have evolved my idea to take advantage of macros to help make the code
> more readable:
> 
> 	if (RATE_TO_DIV(div, 32000, rate, CLK_SARADC_DIV_MASK, 1))
> 		sel = CLK_SARADC_SEL_32K;
> 	else if (RATE_TO_DIV(div, 400000, rate, CLK_SARADC_DIV_MASK, 1))
> 		sel = CLK_SARADC_SEL_400K;
> 	else if (RATE_TO_DIV_OSC(div, rate, CLK_SARADC_DIV_MASK, 0))
> 		sel = CLK_SARADC_SEL_24M;
> 	else
> 		return -EINVAL;
> 
> or
> 
> 	if (RATE_TO_DIV_PLL(div, PLL_V0PLL, rate, CLK_I2C0_DIV_MASK, 1))
> 		sel = CLK_I2C_SEL_V0PLL;
> 	else if (RATE_TO_DIV_PLL(div, PLL_V1PLL, rate, CLK_I2C0_DIV_MASK, 1))
> 		sel = CLK_I2C_SEL_V1PLL;
> 	else if (RATE_TO_DIV_PLL(div, PLL_GPLL, rate, CLK_I2C0_DIV_MASK, 0))
> 		sel = CLK_I2C_SEL_GPLL;
> 	else
> 		return -EINVAL;
> 
> It still assigns div (first parameter) inside the if, but with the
> benefit that it keeps the code and code flow as simple as possible.
> 
> See rk3506 [1] or rk3538 [2] clock driver in my rk3562 branch for a full
> working example of an entire clock driver using above pattern.
> 
> [1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/blob/rk3562/drivers/clk/rockchip/clk_rk3506.c#L500-519
> [2] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/blob/rk3562/drivers/clk/rockchip/clk_rk3538.c
> 
>>
>>> 	else
>>> 		return -EINVAL;
>>>
>>> 	writel(FIELD_PREP_WM16(CLK_SARADC_SEL_MASK, sel) |
>>> 	       FIELD_PREP_WM16(CLK_SARADC_DIV_MASK, div - 1),
>>> 	       RK3506_CLKSEL_CON(54));
>>>
>>> 	return rk3506_saradc_get_rate(priv, clk_id);
>>> }
>>>
>>> Here we use a helper function, could possible also be re-made into a
>>> macro so we actually can use FIELD_FIT() instead of bitwise ops.
>>>
>>> Basic idea is that we assign div and test if the rate is divisible and
>>> fit inside mask at the same time, and if not we move on to next possible
>>> parent/divider.
>>>
>>> With above and using the 1 MHz rate I would get something like following,
>>> provided I also added some log_debug() calls.
>>>
>>>     => adc list
>>>     invalid divider 24 for prate 24000000, rate 1000000, mask f
>>>     unsupported clk: id=193 rate=1000000 ret=-22
>>>     - adc@ff4e8000 status: -22
>>>
>>> In the future I would also like to drop some priv->pll_hz uses and
>>
>> We should report what's the configured frequency for a PLL from the
>> registers. I don't know if we can reliably cache it though (hopefully
>> TF-A/OP-TEE doesn't change the ones we're interested in :) ). I don't
>> know how much we would spare in boot time by avoiding reading the
>> registers often and used a cache version instead.
> 
> In the clock drivers at [1] and [2] I have changed to fetch all PLL
> rates via <soc>_pll_get_rate(), the calls is mostly hidden behind new
> macros to keep code cleaner and easier to follow, e.g.:
> 
> 	con = readl(RK3506_CLKSEL_CON(49));
> 	sel = FIELD_GET(CCLK_SDMMC_SEL_MASK, con);
> 	div = FIELD_GET(CCLK_SDMMC_DIV_MASK, con);
> 
> 	if (sel == CCLK_SDMMC_SEL_24M)
> 		return DIV_TO_RATE_OSC(div);
> 	else if (sel == CCLK_SDMMC_SEL_GPLL)
> 		return DIV_TO_RATE_PLL(PLL_GPLL, div);
> 	else if (sel == CCLK_SDMMC_SEL_V0PLL)
> 		return DIV_TO_RATE_PLL(PLL_V0PLL, div);
> 	else if (sel == CCLK_SDMMC_SEL_V1PLL)
> 		return DIV_TO_RATE_PLL(PLL_V1PLL, div);
> 	else
> 		return -EINVAL;
> 
> With something like this we no longer need to pre-cache PLL rates at
> probe time, instead PLL rates will be fetched when needed.
> 

I think the kernel caches the clock rates by default (unless 
CLK_GET_RATE_NOCACHE is set). They are probably doing this for a reason, 
hopefully only performance? Gut feeling is this will increase boot time, 
but considering you've been hunting this recently, I'm guessing you had 
a look at the impact and decided the time increase (if any) wasn't 
meaningful?

Cheers,
Quentin
