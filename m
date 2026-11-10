Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E78606AA56
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Nq2RvRjx;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=e11/zImr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACB1B40312;
	Tue, 10 Nov 2026 15:06:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5Rlhw5B_7Zg; Tue, 10 Nov 2026 15:06:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EEDA640317
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794323172;
	b=DBPXF5Sd/U8J+JYNdu+VwrGbpmrmGCoMEhaLqYnKm5mgxQG6+kK83XAf5j1es9LkThxu
	 m5uEA1BA9TFcIHxcW2LUdFqVVVHv4JGKMhyjtI1bw4UEFemqnMZsedQmcD7tMWhhAZVvR
	 4e8TXpJw8SttZcy4/dvhcPa1n123oMW+tgSSO3+7hyeTl4kAsH5OILjAWGD7oHSmtctq/
	 lP2u5/0XmcR6GSalMPweh9I5h/T4X2Pz/D9+p3rw4sj/ECBqryeCh7zARN6x2XMOo+qJA
	 n8g9UidLkvmoFeuKFRmznKLYQhyb+1ts7JsybYLDkUR6VGYNW8GTQNIqacSjBFkyAvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794323172;
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
	bh=iFXAqmCl8S1u91vT46fwHQqgq/+5e0E2x0wFo1fV4NI=;
	b=i0pNgE7Qm0rPHd0AdvBjGaC1HSy0EaYNewbcZDnSYsVjXris19+0obznkiRXsa15SKkK
	 Kk0T/2Yu1Lf9s42A3x1S0orqGg8NkJI7tVMq9NHkTn8Oc5FT4nyKIwiCUlBD1qaoG9lt0
	 ykxt5e2AolivVEPoKKUQF6XY/Hb5AaS2SPtDz0v04bAObv7vfb3p9jv6XxpzHIkNES7l7
	 pvmSMKPNeykDoYCL9ccFwSYOL1lJOXPYF1SMmh2S7VlKvXuC0eh/ss18JDpv39DA2o9DX
	 HE4LSFFCyDdmDJmzTmjyHSJJhxu6vRzCGqX/0epYASVeUcY8cVqTAiXb/pyhUOzNtEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794323172;
	bh=iFXAqmCl8S1u91vT46fwHQqgq/+5e0E2x0wFo1fV4NI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nq2RvRjxOCjIdt6eVSuHsGZyMXWZrgyVrlMmwSrQbGcqztlNYXVlTXanr5WOpWGtl
	 K7u1UyEQM7Y15OK5rOb8gQ4lq4F0VH6mwTZb0DlmmkK98kGEOfHizC4IXlnUYiDhwX
	 4hlfUUQynD+HK7NavY31d0uyr+rpkVPCgeTUZvEz9dHMWCuV/nB2/4fLibtflccKoN
	 udHABif2Bs1R8o7uo9mdpo0Q48za2KvbBeOeui2noEn0pJaPGlPSyfZ8WPPzqyJ1Y0
	 Pb/RTsVRYDTJxtbF1AAEQqXkjtQq70sApC9BnlqHVz+P/HkO56ujeTGb1Yya78wey3
	 expD5+AZhvP5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEDA640317;
	Tue, 10 Nov 2026 15:06:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2756F1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C4C2400B4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1i6elxLzV9t2 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 15:06:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 11EF14008E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=e11/zImr
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11EF14008E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFXAqmCl8S1u91vT46fwHQqgq/+5e0E2x0wFo1fV4NI=;
 b=e11/zImrBciv86EQmB2dycXCvGs+zx/a6OxzmVkyO+0dAkfwqd/rqIdQMTKXUmIhpWysVwZF9xwMeNmJMEIHnYLmBkSZu6yIWFqumFTXZMqHoFFEKJRd53bYU3He9t1d42QXnzDYD5tl/VEmz9CqCCfn8vI9fK2tT3UUs+ZEmzo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by CPHPR04MB562998.eurprd04.prod.outlook.com (2603:10a6:380:107::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:06:04 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 15:06:04 +0000
Message-ID: <4d2d71bf-0c53-45b0-bf75-60473d6274be@cherry.de>
Date: Tue, 10 Nov 2026 16:06:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] test: Pass location of built tools to binman
 code coverage test
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-9-1c76e0b68f29@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110-qcheck_fix-v2-9-1c76e0b68f29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0138.eurprd07.prod.outlook.com
 (2603:10a6:802:16::25) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|CPHPR04MB562998:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb5f1a8-cc2b-4f17-ef05-08df3f3c239b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|10067099003|11063799006|4143699003|5023799004|56012099006|261021123027099003|261021121427099003|261102130727099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: GF58ysH/SdpbmAgSXQnqKj33+Sqlwaj/Pg/BGYFGU8UFkFWgp/tRf4279nbaypTzyblX03D+HVRgXXK9DiT9mrcwAY9qjb2s10sPcS+/2dpHbhUmlo3vuhhZeNr7B7ycABpLYaD8LjbTn0clCNFrfZ1HaovafFM2pj6yf0md92ueNic10bQ/B1XfyuI7z2qtEJCGB/PQMGRNLvqp3HGwcYUyklidZcA1F5g7BPD2YFfpR4ZuArxnlTOUlBIQTi01VwjBoNaFvsv64v/jpYFHHo66dAAsTyTCs3r9Cy9anBrt04Bq+VGWuSPGxtv74RcmXo2jIwXcqSgN/32EPh5redD2yp4OLhAYuvUS+DCuaTQ1iCX4hoyfEPpAP/UZ0uotkruqYIVC28SvlwHiofMH0/nCYfjk/B8uMr7N/x2UyNHltpw5342w/CPpD2R9hbOe0PWI6FKtecbuLN4qnHx7HYr2ab8t0dnMLQRvabnt2Q0jetm7Z+7mKRAldhA4u3VwuWtH16qzBKdrinn8zkmxcqmSUbcC8T0bSb+8+6hel+bFmXTS3maUa0r98b/LezgjESoFKcAKUOMkMI5UrAPPWOpWCiY2KEMG8DNMsiElGvPVTdebIAepRG1tYAKb2TwFFAS/azW/X+bhv+1OOOQdNhHHAc9SFuR9j4piywnQSAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(5023799004)(56012099006)(261021123027099003)(261021121427099003)(261102130727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWZRL09RZGllUzJRbExtakpHeHJCYXlncm53ODV0Qjd6NFMwRnVWK09EZmpw?=
 =?utf-8?B?cHZzSHNVRUlCekFsTmUxdjgva2pILzdvUXdvYzRIOUdRcVpSVVhYOXdCWGJx?=
 =?utf-8?B?RDBzQldWRUtGYXE3bXdpQTRkc2Evdi9HQ3AvOEFXeEgzLys2RnA1UXIzdWVB?=
 =?utf-8?B?S3c5MjN6VkxnMGdtdDhWaXVWekNUbllyeFRxMEhQWUF4YnNWRERFajBOeC9s?=
 =?utf-8?B?MzAwTHA5dnh4LzViYW1DVEhMK2RSZk9QQkp2c1VTNHZwVTNOUFNaa0pxRTFZ?=
 =?utf-8?B?bTVRY3h3SDZJVWRGTU0wcDNMNDhOQXRtSXFKMTBnUkwxdXdXYkZpemRRbkhI?=
 =?utf-8?B?L0hIZDZpd2tKekVEMDlRc0ZBNUJNMHN2cGFsQXZJSkp2TGx0Slh6RWpFRVhq?=
 =?utf-8?B?RHdhSmJPeWhkbVpzZnFLT1o4STYrai8zMXBpS1ppekhid2NyOXNhanV4bXo3?=
 =?utf-8?B?N01jM3h6SW1ZNnkwL3dxTkhYaUEvOHZEbG4wV1A1TTdsWmNYM01oekJDQUFh?=
 =?utf-8?B?cVBiWlhkbTRZTDFpVVNENWNTTEpabTM4S1EvZy9pRG1TKzZ0V2lpYlZnMWo4?=
 =?utf-8?B?UFJKQjNvQ2FXbnNnTnVBRkhrb04zbjJOTUFpWmYwV0t3L1YzOTRLeHUwZllI?=
 =?utf-8?B?SGRSQ0I5UVFsdnpZWnA2NFZPVVJaa1hSdS8yeXQrSzlNTklLcXJyRktnT0ow?=
 =?utf-8?B?dldZU09odTYxU2MrWU5Ca2tvRmRwREUzclNqM2NXTzZ2WmdjS1lPOGpzSEdZ?=
 =?utf-8?B?WE5pdnVvamtweW00NDlxRjFUSzRCVXhIOW4xQ2hZT204SmRoNGoycHdxcWlp?=
 =?utf-8?B?akNPZWd1eTZDK0ZNdkNWck5JZWI2akRGWWFRQVB5MUlySzZKM1NmY0kvYjBF?=
 =?utf-8?B?T2dDcmxtbmtYZVk4TFc1MGMzY1BnMDlwbGE0MTd3NHh0SWJiWVFlVWRGWlox?=
 =?utf-8?B?eEQrYTdwMUJ3OC8vVklOSXpPWmE1ZlMzaU11aC9aeWl4WW9pQnZqQTcxSDlk?=
 =?utf-8?B?L0FWTTJ2OXQvWVBqdnVUMysxUnNsRDFhYzkvUFR5UTZLdFc4TVFibVFXaFM3?=
 =?utf-8?B?U2VPc1p3eXdRTzVGSDFMMVduMEZhQ0hFY09lT3g4U3FzanNNaWFkTGo5eW05?=
 =?utf-8?B?TzhOWlJTbkRudmg1eXNjek5ER1gxenNuUWdXalczQTY2RGZlQmtzZ01yRUxO?=
 =?utf-8?B?ZFBTTmZuOW1wc2E0eVFjckFJSzFBRXlSUUVsU2FDdUVYTFhTOS9ZNTkwTGE1?=
 =?utf-8?B?c2svWFI2QWRKY1ZoYUxwWGEvK0tSNDZrWEdZYlMwVk8xTzF3SGpmL1lhdnlT?=
 =?utf-8?B?TkVKeVN4MlVQNmdsYlpSTVR6Y0RTbWpYY1lrUU4xNVBIb0VMb1N3VDZ3OSs5?=
 =?utf-8?B?UkpyUG4yRkw3eFJSUkV1eGsyRGJvenQyQnArb3Y5c2wxY3VKSnZZemRzWnZO?=
 =?utf-8?B?b2h2RWNVVkhxekg5dWhZb3BtN2RhbXNjZmkwMElnSE1CUzBabEVZSDk4MWVE?=
 =?utf-8?B?SW81Y0JKNFlwbjBuN25HZmYraEM2VmtsWkxvTEZOUzVlcExHYUM5N1JVUXRJ?=
 =?utf-8?B?bXVQZVg5ZlQ0MHEveStnSlVCL21jODR1Z0lXZnBmYUQ1aEZVbTlPYWxDZE5J?=
 =?utf-8?B?VzNtTFhHbXBWN0NZM2lHSldSY3QvWk44YlloRG0vUnJOeDZ3dzN3ejVmcnQ1?=
 =?utf-8?B?ZVR6RVFyR2NYckRuQlliZE8rQmZxOEUxb2xzU1oxa05XZUR5eWs0ZTVmemtH?=
 =?utf-8?B?RkdEbzY3UStWM3pGaVcxQ3hVNnNLVFFKU2N3U3FVWXlrK3I5UDZKaXFqU3BQ?=
 =?utf-8?B?enV6WGhBemIyc3BQRGRKb0ZxSU9zQ09reXoxRGpzQW1TY2cvQXdOUC9SM0ds?=
 =?utf-8?B?NEhwSHkwNldqT2FnNGFJU0RRUzlXRzVSZzBNbUZMMlQwQWp5RzNwRFQ4SjJL?=
 =?utf-8?B?eFgxTU9qazIxcWk0eUdXeFFBZFB3RXd2RTgwVDdqWGgvbHp4cWhGUlFIYkNE?=
 =?utf-8?B?YzIySVF6Q0dZVGlib3lFQkdSaDd2cG9KS0hmUjV3ZEZ6Mlp0YmRoY253MThS?=
 =?utf-8?B?Z0Rpa3dpV3FaamFZSzBVZnB4SjM3RmhPMWFlVCs1SDBOcU9FTFFLcG9Id3ZQ?=
 =?utf-8?B?Y3liYzdFOEtGakF2OGw4d0ZiRmlCRnpIY0xUTW05M245K3RSbk9HR1g3Y21i?=
 =?utf-8?B?d2c1Zk54OXFFSVdzL2hvSkNNTStaVG9jUTM0MC9vZ1Faa1dnNjJMU2dDallp?=
 =?utf-8?B?aDZJQjhnY21sWHQ2aHAwVThzRDR5bHdxcHo2ZEp1WGg3QjVZZk9oR0dZWHVP?=
 =?utf-8?B?N2VVekJOMkV4dk13ZmIxTERaMWNBUy9OV1kwcFFwek9vd0JsWVM0UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb5f1a8-cc2b-4f17-ef05-08df3f3c239b
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:06:03.9240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gLhBZi0rPjUmXDSbuDYgVIn+Sns0Qhg5LAc2JCp0pX2lCFuAjOkCZVA0q4cm49L0TxnF33yyQVdgyWkBVFo86nnKoZq13LurbAQNDSw69o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR04MB562998
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 11/10/26 1:24 PM, Andrew Goodbody wrote:
> When running binman for code coverage tests and invoked by 'make tcheck'
> some tests can fail if they use system installed versions of tools
> instead of ones built from the tree under test. Ensure that only built
> versions of tools are used by passing the location of these tools to the
> binman test being run.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   test/run | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/test/run b/test/run
> index d1654dffb5f..0857fc14c9d 100755
> --- a/test/run
> +++ b/test/run
> @@ -93,7 +93,7 @@ run_test "dtoc" ./tools/dtoc/dtoc -t
>   # Code-coverage tests cannot run in parallel, so skip them in that case
>   if [ -z "${para}" ]; then
>   	export PATH=$PATH:${TOOLS_DIR}
> -	run_test "binman code coverage" ./tools/binman/binman test -T
> +	run_test "binman code coverage" ./tools/binman/binman --toolpath ${TOOLS_DIR} test -T

question: Quickly reading the code, I'm not sure this "ensure"s that 
only built versions of tools are used? binman's code is very convoluted 
so it's not easy to figure out what --toolpath actually does without 
digging deep into it. But if you say so, then fine with me.

question: Don't we want to (also?) start PATH with TOOLS_DIR instead of 
end with it?

Cheers,
Quentin
