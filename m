Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED7D606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hy0oQycH;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=SZRq6Koy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D63A40820;
	Wed, 25 Nov 2026 16:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GmzmLCrd8NdD; Wed, 25 Nov 2026 16:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD9F7407FE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795625472;
	b=GmOH3ThmP1yVyY9abyfJGt7iB/j4W90fV80e/VI2v8ry6rlpw8pu2j+qt1Vw7cN/QuQ4
	 b1WxNVXBdpB9zhtZ0iigC+t3ne8IXgyBTLy0C6AXp3ncpXT1kjzDmqM4to/9f3UeNZgXK
	 IglKLRG4ahQBkm9kB8NHlB5rxCl0ZVtBioKoOWfVlaP0z8EL3SfG5xtSpP+KAxW1UVRx8
	 rSLFv0V50ZVF29YPr3tw3VXnCoU1497ssTwajZl1xde9pPkguHxD6ll3Gw/MOH1mMNo6n
	 dg60voyUOsCZaWnn1w6qxplexHE2GfKvWqYni+VCT4tTc3G6CxCGHM2LhpTnMuHWOYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795625472;
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
	bh=fefHpGxGjDEJSEH94Ba0nL5rWQ7T9CdRu6f7oCMzQK8=;
	b=qOU9KKH0AtsOsUX/ImGGvZ4/tXjVZCAiNA30Hsdm9tBXAdxpWRZTQnOXz+ZMDC3XSYra
	 ZWbvSe307OxzQjO2VzOdSDzcOlz3HDI4GckWWE9Q55M4D5SeIoGFuUKwnw8CK3nRc58Gt
	 c4acG3Q7yl5zT9OUBZ/iSUubGPssbzjlB+5ktZe3UMpGEyJUB0BS2TAVN2VXViHo0GxFN
	 NW19G9ageardYQP6/6u5QExnfnfQN27n5Hh10ZfW5xCGVTd8GXtD/MxpaemdW+rSj8TNH
	 XlKd76NXueJjEp2emlofSxr3phoa0sLxzjcp29aZbUpia7mqRhvWcBlzvgdliPUKt9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795625472;
	bh=fefHpGxGjDEJSEH94Ba0nL5rWQ7T9CdRu6f7oCMzQK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hy0oQycHS+yZ0ywAJtDUcAEE5l8IIAIwyVrj18wlt3fDRLQ4ZgrccBlfN63jYTk4K
	 ah1Wh1yl0U5rvS1TMdit2wO8ugNxY6aVqOiDdyzbXradIdFsgcbu+dC6x5k3AkEjFw
	 17Fk00r9weEDZMTyjKsdlaQ35mghzCZ0a3Us1qzlxGCi1X+edu+fPydHCQdfNveh6P
	 bwbVhAY5Md+ZqCMBdw14OfOIwsMHRW0ofuMSUANUlsv8gI2/I8PsbiGmdUIa5QoiHj
	 9FPX6S8W8OEotY4htcnahx9LYbmGHe424IdXTZEw8pezJAL8/CCXE7gxYw0Wb6cuPv
	 4+y9wsnhAxlGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD9F7407FE;
	Wed, 25 Nov 2026 16:51:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D56F26D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 040B640111
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xxZmenKtNi_s for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 16:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3FCC7400CB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=b.hahn@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=SZRq6Koy
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FCC7400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fefHpGxGjDEJSEH94Ba0nL5rWQ7T9CdRu6f7oCMzQK8=;
 b=SZRq6KoyeCXp8evm4oIVTKgscSFGJAUq+9qgyBCxFFun78QqTUOY+UWkakb3DIPxOdz6jQuNBVlsw/+iUmitptqcnCIL3nV0VrAZJfdvOcZ6/uAH0C5KXtmq/D3+kzyy5dvnU53KSRqmK0p1K6DghFz3tVaZ16IrKgrhkRZ9xwQyp1ZkOH95ygQcQAHC7K6V6IYAg0HzTf7Tfghlpg470NTciUOkJgmkMiNNPaenooZOpRyecFHjn7Y8QjvVKjjR2fLVN5pkDloeDx/1FfLpyglx287Tt23qiG9KBBkGkOlBMCXX0KvzEm0jziBueg5+0CGEuUn14z0GtjN87lITUA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:159::10)
 by AS8P195MB2096.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:56d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:51:05 +0000
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894]) by VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894%7]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:51:05 +0000
Message-ID: <a924dfdf-bf87-4f7f-94bc-4ab6b95cb4c6@phytec.de>
Date: Wed, 25 Nov 2026 17:51:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 4/4] board: phycore_imx8mm: env: Add fastboot
 raw partitions for UUU
To: Thorsten Schmelzer <t.schmelzer@phytec.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Benedikt Spranger <b.spranger@linutronix.de>,
 INgo Rah <ingo.rah@linutronix.de>
References: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
 <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-4-dd6db9e5edfd@phytec.de>
Content-Language: en-US
From: Benjamin Hahn <B.Hahn@phytec.de>
In-Reply-To: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-4-dd6db9e5edfd@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::6) To VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:159::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P195MB0623:EE_|AS8P195MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: 5724e51c-ff89-4fc6-d3cb-08df4b144c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004|261009223027099003|261102123227099003|261021121427099003|261021133027099003|261021135927099003|261021123027099003|261021130227099003|261022113327099003|261026130827099003|10067099003|261026140227099003|261022115727099003|261022105027099003|261026135527099003|261022075727099003|261026121527099003|261028144727099003|6133799003;
X-Microsoft-Antispam-Message-Info: bjY74qQEdyhsUS7CKnQzaPGQRSMQQ3vMng2xq9E9AbPmRHvP6JhM8qK1bXf4ZqC8E9VZKhNbVOQBQJdaG7eAKgzUQNJ4XvGdkUaJ/m0qUKRX9q+/VyGJMEs4sVx+BV6QWGHKEDwn6p19E36iyD8wUQWA9TD9OwbH/vdcab6vXbozFFdoNe7k2bOdJLYUCphCl/RcvffXp8jbY/tgqHmus0P/t7zITQHArKDKoTFE2qNcb2ni7RuV7415HogS7n5kbq8AomHPQTA1wLRnsr/JwQZqbSquEhiLarbNVPTgqmB2Wwdm0/Z4yANae8/42xj6O1WgzJ062vyoAi/JCaFID1EJOFylKI580Guj+Lpza/MfDAdLLIO+3E6UE/8oY04W7voyQpJdWUkneQax4HBTdefq1LP1SFZu5BkU9b3NKBHKsEIYUrwfstb++rrCClYWAoxEGaPuHD32tFa0HFTYpvgVsDVA7o+MpL0acBRjeAQVE9WZnnz1YT4dY/J2T4SBYI5dzSYzdTyCmDrghUSGEpljOSym8hxu3ai/PjrrOxqVgSARlJW4Uu4LV/fDWaJejOtXJfF7wbRNJxpg6VULhsQCjyXaWUfnW5mjsuUDZvEYl3UZs8/g+DRRkXBsRe+cSMmbNzH8CQoA6THk2N2/BVfEJ4++DiiMDV+Fa8OIrOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1P195MB0623.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004)(261009223027099003)(261102123227099003)(261021121427099003)(261021133027099003)(261021135927099003)(261021123027099003)(261021130227099003)(261022113327099003)(261026130827099003)(10067099003)(261026140227099003)(261022115727099003)(261022105027099003)(261026135527099003)(261022075727099003)(261026121527099003)(261028144727099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3JDRVIzQ21UTnJ2S1FRalNJOFMzVTFyWUsrQ0Fza3dtdlNxRmh0UDVYNW5J?=
 =?utf-8?B?MVRyekltNFd0aFZsZlM5ZStadk9raXErM3cvUzNOUGVkQVNWbUxOYmh5NGVG?=
 =?utf-8?B?dUVzSDE1b2ZudW5uNFU4RWdmd1ZoaDhsYVBrd2FTL3EvRmtybzZxTVZXUGtn?=
 =?utf-8?B?a1ljbnhFVjZ0blNIc0lSeE9hd2VoUm80Q0lIUVBIT24xaDJoNnMxUWZRUEdE?=
 =?utf-8?B?aFh4cWlrUFV6YjdsTHNQRFAwSzZrUUZONlJrc2J5V2QycE9ST0Fsd20xZTN1?=
 =?utf-8?B?U0s2VGRPUDVBUW9NU2NNUzZEQXNCWmkwK3JBbnMwK29ybDlJSzlRRHRrVFFp?=
 =?utf-8?B?ZHBoMGM0Rjc3d1FJTEF1NXRUN3R1dHA1MmlhRk9MVUlwR2M2anRSWnNvYzY0?=
 =?utf-8?B?dmpxQmExSEJqam5GTXhLVEZTUHRoM1RDRml5RFQzbGg3TjYxRXNwdWtTK1NE?=
 =?utf-8?B?WkZDMlJoYWZuZG1ZUWZrOFJDWFp0SXNyck04bHJiNFAxeUF4ZGxyTkZSdlRh?=
 =?utf-8?B?QlFHN3RMaEhUS3huTnBlSFloRWJlS2ZrenpPSFpndlFwQ3Z0cXgzWWNqUjJW?=
 =?utf-8?B?bjFPQkt2Umd4a1lYWkdETWtpUm9nOSszY1pUZmgrS1VzY09wR2paU09RQkZn?=
 =?utf-8?B?eU9WdUcwcWJzVndvT2lhY2xUQmpBWTAwTXpNWmtiNTFIMElGUUJWd01RUEdz?=
 =?utf-8?B?NEpZaFR3dkVGR0NuTWd5YXAwMStVcEtsOXdwMjlIT3FteVBBMDBidDh6b2pW?=
 =?utf-8?B?d0FjRDNibGxUQ2YvVHNZUWRGK2oreHJFK1ZlYkIwMm9iNmlFYmI2YWN6bWFL?=
 =?utf-8?B?S09HdFgyZkgzdXM0THpkSWo2TXpvQWgvOWxZY3hwTnNKMm96Nk9tVlJxeUlW?=
 =?utf-8?B?ZmE4QnY5dzhtbWEvbFVtRjdBd000d3l3bzNJcFF0SUZweHl6ei9IeU4xU3kz?=
 =?utf-8?B?WENrTCtmeDJDbSt4eFloMzZ3UDMrN1dhSzJLSGt2SVA4WE9CYmEyc25taisv?=
 =?utf-8?B?ckorSnVqVkdoVzAvRXV0KytScHoveURublpDc25hSnF4cFIyTUZGUTUrV25L?=
 =?utf-8?B?NVN4Z0dsREg1Z3dzWkNrSEthVnVnSllvQlQ3QTg2UmFYRnArUmV3Y3o3cHdl?=
 =?utf-8?B?K0ZEQWtmTDBILzh1dU90dlJEdXkyb2xMMjBwQTBodllWTlljR2Jra0RDVEcw?=
 =?utf-8?B?NHJWWVAvWDcxTU5HQTdKYlpJakFWNnBqYlVOZDNiTm9uQmdnUmtuWlNYandn?=
 =?utf-8?B?c3drbzA5Z1RNUHhuZ2ljZTM0VGtuTVBIR3VLK09FYlV6ZzRFOUtQMmUvdkp4?=
 =?utf-8?B?WGRNSzU2Z0FubnVSQkdjUlRTQkl2WFhkcmRvRG9EQkJqVlVsZVN5dHNYMWlI?=
 =?utf-8?B?WFN5RDlDTzlhSFRWSEFTWEhEMDk0UmVlbU1HaG1MY1l0Wk5oN2k3c1U3YWI0?=
 =?utf-8?B?SHdFbFh0djQ4cnhNWnJQMXBoUm1rRmhEUWZJU2RrSlJUdVgyS09mbVpCTldz?=
 =?utf-8?B?VkFkNE5PL2hpd2sza2VLRys1RlJLNTIxK3VvMHpwNFh0Z0xTd1Z6WmZ2aWRR?=
 =?utf-8?B?d0hjUGZKK3VtWGpoSlkyNmpZTkkvUXJRdERuRmVneHlyV0dZUVdPeW9SSEp3?=
 =?utf-8?B?YVNlVlFGQjF0Vk4zVDk0R3pGQ1k1WW95dDNvWkwxNFp1KzdrbEplTGM2eDJF?=
 =?utf-8?B?R29rKy9XRVdJclJ0OG8zK1padVFIZU1la1FuQXdVUVdMSXd5NU9hY3FwU2xX?=
 =?utf-8?B?QTV3RXJnSGhvVWdZcWJYc1pEZjJpdzNaUWgvaml1OUhiWG9jOVdHTnBsbWVX?=
 =?utf-8?B?Y25tRCtoYkxVclBmWExCOEh6UWtTTWhENDZqY0hkdEpyS1JYdXVQS04wSVpl?=
 =?utf-8?B?WW84SmRRTlpkU3poRUNtWjJCVGN3NHZzbjJaOERnWWRkT2JOOGVyeXlucWVD?=
 =?utf-8?B?UVJTYndOcUJJMDU1c1p6emlOVXFNTmxCSVZjSFdyd2xIUkszR1IyYWpiZnNT?=
 =?utf-8?B?UFlTNlptUFdGYVJzN3VvQ0dEMmVqS1dxK0Rma0pLNVpOWExuMDhuOVZYbGMr?=
 =?utf-8?B?anlUcWplOXE5Rjd3MGNoU00ydzk3QjRVWU00U3RrRTg5c05OSXc1Q20rWTZa?=
 =?utf-8?B?aFVkZ3F2SnlRWUJuU2RSWVhuRTAvbkdkRG1xWW5hREZCbmNlNlJjbTRJRlJw?=
 =?utf-8?B?NTIrS3BjOXJoR2lhQktEMzZPZE9aZmpISDRXMm9WTk51UjAvUTdNbUpqNVdK?=
 =?utf-8?B?a09EV1B1aGJDazlUazUzTGM4dnB1WXZob0p1bDBwdHMvcXdyYTI5UGE4U013?=
 =?utf-8?Q?kQd8UqWe/GE83KEYMs?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5724e51c-ff89-4fc6-d3cb-08df4b144c03
X-MS-Exchange-CrossTenant-AuthSource: VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:51:05.7667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoLB6m+DkeaGHZSv0jsRo3OJjF0tMo4YNQQaz/wOHcu1dluYvamWImMLNx7rFruZ98vkmCBJfAT+QI5XtvI68A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2096
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 19.11.26 um 15:12 schrieb Thorsten Schmelzer:
> Add fastboot raw partition configuration for 'bootloader' and 'all'
> partitions. The 'bootloader' partitions allows writing the bootloader to
> emmc boot0 partition at the correct offset. The 'all' partition allows
> writing the complete emmc user area.
>
> These changes allow to use UUU with the inbuilt default scripts:
>          uuu -b emmc_all _flash.bin _image.wic
>
> Signed-off-by: Thorsten Schmelzer <t.schmelzer@phytec.de>
Reviewed-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
>   board/phytec/phycore_imx8mm/phycore_imx8mm.env | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/board/phytec/phycore_imx8mm/phycore_imx8mm.env b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
> index 7cd601f8cd58..bd018f9d0061 100644
> --- a/board/phytec/phycore_imx8mm/phycore_imx8mm.env
> +++ b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
> @@ -1,6 +1,8 @@
>   boot_script_dhcp=net_boot_fit.scr.uimg
>   console=ttymxc2,CONFIG_BAUDRATE
>   emmc_dev=2  /* This is needed by built-in uuu flash scripts */
> +fastboot_raw_partition_all=0 4194304
> +fastboot_raw_partition_bootloader=66 8126 mmcpart 1
>   fdt_addr_r=0x40480000
>   fdtfile=DEFAULT_FDT_FILE
>   fdtoverlay_addr_r=0x404a0000
>
