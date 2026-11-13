Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F4D606D485
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gl7j9Fgw;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=R0btb96A
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E050340E12;
	Fri, 13 Nov 2026 17:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PGYxFKASHnml; Fri, 13 Nov 2026 17:58:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37ED340E09
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794592731;
	b=pSEvO9vvk1LLdxnARoUQjupiw86mUpATq2/jAi3b8Kr8FH+v3/sHr/fsQ22F9Ps9mpIi
	 ttsgXb2JTcyxCHPqccNA0DmBtMGZNVzAITZ2V7hoWMuWLdi7bAtmD8tIW0PTVq/FH0jIU
	 x6+iZamNv68jLWLcW/3qsB+ZOxV1J2n8avv7pZRTTcTV3eML9d6cqkQ8ItTpCzctavvKi
	 MH/8ZZ2RNlFDSIPUzKW5Y1Kv0tXwNJY/QXq/XC3mj7Vw/bAZywAFCYgkYO+VZg3KkS8hm
	 y/tAtw/jZO/KREGVWrmlPOut+UN03fyZpZuuI5bxC55J8uLFUMOHdqZL6oQJMlLkOfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794592731;
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
	bh=HEqX3e+BgXGF8UIZZC2+PXVt5taGCUP4B5CcFSd2fb8=;
	b=IqTbtmeQI6EJrZl5Dly/SnaCEoeUnbsRaWmFkYAModw8/UezEwWwLnz1re8L/SKU9C8F
	 kL0+MKy6j/hVResxxZ/uWD0KXKCYLfmD/q2ZPQYsXsXG5Dj5gW2yFsfgyr/aiUZYaaeYZ
	 8f+hVxA12XQRLdPEGIwzF0Lc655xFb3DtOwuQh86zuJDXuC5B33X7KRTQKR9DNNzh4ET3
	 A4Lf/Fx48kEbq9p1p//uVXNTqg4ncp7nLQLfBjMQ0uERy/uoLxwL1a+e/F2sFGIuIYrWj
	 aLSTmXx6oIATcEZ8xmBxhA0yS1SHfZLxMf0fONdWOksacQUT9wex3NecGi3RbTgLVDA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794592731;
	bh=HEqX3e+BgXGF8UIZZC2+PXVt5taGCUP4B5CcFSd2fb8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gl7j9Fgw3DpOUWTkZ3U7ivn56Qgp+kvAqT+hKzbBul4dwlUmz0SM678CexsCsQ4ey
	 5CZ/JErS2iBV7ZoCtrH0aADbZgw8qCp5E/TEcnFcjAr0lrBYYmXDdh4AbRc8ml70XN
	 H4hYzJohqmvFWV0erc3HJkYqVHe76KszZsO6672zLgmG2exjD3rMdU2qtMr2R9uk0i
	 rHNw9r4fuVt9zHpzQjzjtH1Z6/l9Gn7TgWptDIPgRp9qoSNnVxMj99YsA1JkjlthuB
	 YC7stv2JLrtSXZwi53z/MS6dTYuGvXTRWanlP47vs83Y4pe7Im5VjlwfVp/cdw4RK+
	 LqoFF0RGPJziA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37ED340E09;
	Fri, 13 Nov 2026 17:58:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C5632E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DC9E60DAD
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:58:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vu0Gn9Iq3APU for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:58:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 008E160D6E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=R0btb96A
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 008E160D6E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEqX3e+BgXGF8UIZZC2+PXVt5taGCUP4B5CcFSd2fb8=;
 b=R0btb96AGBlgvlpsx2H5wXrOFpcyABgOMPRYSMfYhbTqJC7a0ajhRKSgmTN8MlJ+V3g/gzsVrjyDLkf2H9DjaNCENgQr550LD1aBwk9hji8HO+xJZvLJe2fnoBd/lV20sfO1Vngg2l9tFXHwpY/a43UwXUqOaOHvI7R5v7iHtik=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 17:58:43 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:58:43 +0000
Message-ID: <50aafdea-388c-497c-ac51-b6eceffd442f@cherry.de>
Date: Fri, 13 Nov 2026 18:58:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/37] clk: rockchip: rk3576: Use correct TSADC clock
 register
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-25-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-25-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0152.eurprd07.prod.outlook.com
 (2603:10a6:802:16::39) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2788b9-0930-4e83-078e-08df41afc15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: emVng6lnXKNnLEY1YT1V9xpT8xTDubeVlxnbfQge7XsZHjb2zhfVCE83YoeAjFNtW1ufViQbz3t43vgpfQBrXLjNLU5XlcMbcHpQLReHzktZUrwv0dBmPkoGOV2BqTXimaPGgcI37UlxnekkKCcqr+YQebmnQ6hd86iX/Zf4FgH+RIPH/lDNJsCWi6xoR7Pioy12ngde9rEkUeD21PaBTDQj6pbpGc2RzPGgyBCQsU9t66iR1Qt53PUDkHrpDdRTTmkzKK3rbA5UYlr287yVj3b7PpAIzM4y534xikP5si5Zn1cvRusjZ4PNN8Vyeps9Qv6R/wexPeCeEUKyXmUW7d/CyOVjRJOY8gx+daZ45LvlVw7VR0wx0+2CVz5OXwaJWHdkMa4NVqZAb45WInTpWdQwwXKt7OsrUBxiDjkuRKbCdh6t3/eB/j7bDgVdEtUiEzzxlvEqwAGlzhnjkOhwvpIMsDfCPd5hVbFEgRTVkZSQt53co3MgBo55WcAkD228hRSpkUqelI4WQEYVwGxCvuqh43RKwh04CSHGh5HmXrv1861Y1d/hCGWi8FPat3CEi7UdkAT90bf+wNCsV6g/FO5X4ZZ9kfz1fhhTSATs2iE/E1Umi8wTnIJvnPx8pM/294KCL05ZCOeNSlQeeMFP+hV1c2/vZ5ll6dx/87YD2YU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3VSREp6ajI4dVJXRHU3NVZ3aTFqVFVwc2FBWXpxZ2hnMFZYN05tT05Xcmty?=
 =?utf-8?B?QjdNS0krUk50eUw5LzNUQ016cGl4WXBQTWJCemlyMXRqaXZIZlFwcDZIbzZO?=
 =?utf-8?B?RTg4ZUZ4YytrZk9oSWhhNmJxV3p3NFc0ZWYxaEEwNlR2VFNzWDIxNGNOTXBo?=
 =?utf-8?B?eExYRUkxaC83cVBZRFFVNVZrdXNWU3M3WFUvdW9vZkR5OU5DYmJQdWtWVkRK?=
 =?utf-8?B?VWNOYjlITGlPSlJhcDFHTTRuNUgzQnFyR3ZtVXo2ZEdVOEplamxLT1NrWjJx?=
 =?utf-8?B?MmhCNzF2NXN3S1E1a1FmZFpuV0VDZkJidzlMOHhncEw2VjJjbXlvUEEzbGxi?=
 =?utf-8?B?cjdIaDdDSW9IdGQvOGJFbmtrK2cyY2k0UzFyRm9DZHRHZGdrWlQ4NEU3blhR?=
 =?utf-8?B?d3M0QnZDVFhsbDVRM1M1OUZRNXk5NFhMcllhMjQ2cENjWjZJcjNUbk9VQ1Fi?=
 =?utf-8?B?UWNXa2d4UmJWWVRkdS9ETld4YjJGbnJydGhXbTQwbDhaRWh2bXpCdG1ZNkJU?=
 =?utf-8?B?R3h2eklOeXF5U0RhY2g0cElzT25od2ZNQlVla1NXc2RXTEVKY3gyZDErV3Vh?=
 =?utf-8?B?aW9qZTZhNzF6dGp5Rm1zc3pXdkVFdE1ra3Q2YURuRjRUZU9jaXpRdWNsZWRs?=
 =?utf-8?B?ZVFidG56YmVzYnVSZUpUNkNRU1Q5WXJaKzdmTzl2K0NwbTZaMnJvcklnNmVo?=
 =?utf-8?B?K2djWDhTREx0dFpvcnl0aTRTVWlVVXIwSkRsbmdkZlBDWjZhWk9IS3BDalFD?=
 =?utf-8?B?MkdVNnlKTmNwYlJza1JLeTlSNHRhdGRWQVpjT0tPc28zR003Y1NvL05UcC9F?=
 =?utf-8?B?SDhYcmd4R1pEMThJWkx1dkJncFlySjhqaE52bmhlWkZ6cTBpdmhFK3AzLy9s?=
 =?utf-8?B?V3U5M3pzVG9BU2sraDA5Z1NQalFzUy9MZnFwUC9QaS8vdkg4OWxKcjdzVC9Q?=
 =?utf-8?B?WWdYaUloYXJsaFFxZHc3V0ZDKzMvL2QyVXFjUkVJaEFPYjNvbFdTa3JvZFkz?=
 =?utf-8?B?bmV2TGdKR1JpZnBmM1lHVTNLNERwZ1dtc0dzSGphRGtxdThJaTBUcHU2em5W?=
 =?utf-8?B?cmdsZDU4bjB4dGdURVYrd1puVmtFNDBCVm4yOTU1VElnQnZ5RkRhcU15Wjg0?=
 =?utf-8?B?M2Z3Z1N0RUh4UWJmWkFONHFzOFhIMEYrbnJWd09pUW1WN0wyWVkxNExqM1pZ?=
 =?utf-8?B?MnhhMUpCRUV5NGxsMFJpdDYrYXBDVTVUMWVRKzVkQ05WdEN2b3ZmTStsT1My?=
 =?utf-8?B?YURtZnd3dWI5a1FnbXUvanVVYXZzTVpOU2tYOFhpRENsOVpQTGpMVllqdXk2?=
 =?utf-8?B?Z0FKcjRHUElxN2E5dG1LcWcyYllIUmduQ05rMUt6KzJlR0FMak9MZmtYYjJI?=
 =?utf-8?B?cjRLWCt2WTBjRGkzclJOclVKNnpuZHI2aWZLRW5oZHlOWEk4RzY2UHRJUGxC?=
 =?utf-8?B?cGtPZy94T2xqdkwzODY3SzJaSHUwTXBlNGwxb1hOM1JGWGxNVGVsNllKOEZk?=
 =?utf-8?B?VkZFVmRubjZRVGtPMXk2LzNqYUlGdVA0U01zNTRNa0hxVGxvczgyb1NPSmY5?=
 =?utf-8?B?NzhWQ3dHUHE3UXFkVzZoSFZ4YmlRN3FsSGRjV2ZoM1RkWmJ5QzdFNFNieXk0?=
 =?utf-8?B?dW02bGt5RjlINlRoNWlKb2FPeGtUZ2tqUzdHdDVJY2ppOVd5dk1WS2V5akZ2?=
 =?utf-8?B?cjJta3ZncDVxMlhEOFF4MGZScmwyaC9ITUw4QzhCQ2xQb2JkTlkwYzdtbWhu?=
 =?utf-8?B?SGtKUXlkc0swT1Z3a3A4VVBBWWNycytNRG43UDQyNE1ZdHVOWk15ekE4aXpa?=
 =?utf-8?B?ZWd1Z25MN0Z2d0RrR0JDREowd0xCTGp0OFRRS3duc0ZlOU9jdFVYdWxSbHZP?=
 =?utf-8?B?VzllVlkyWTJUa1BxVFVOZDVRcXY5eHgvWjZ4VTFJUnpUck9YSDhLTEZTeWNq?=
 =?utf-8?B?ZGpWcGpUa09SNEl2ZkQ1WlJrTHpCVTV1VDFYd1JhMURZNFFjaXFsYzVTUXAr?=
 =?utf-8?B?cEJoZXhDT00xQTBBdDJzRjUxNHFINTVLZzdBWkU0a2VlTk5LcEM5b21mdVRn?=
 =?utf-8?B?UWVSSHNscU43NmlsMzNQKzNOUS9NNXJCMEJZY0xHZUdTUFdtYWtFWTF6UGdH?=
 =?utf-8?B?RE5HUVVhc2IwTWowMjVwQXpsUHh6c0oyaUFOUE9WTmpIbGJZanZoejlsVXZv?=
 =?utf-8?B?ZENxWDNacjJhV045MVV0M0JkbEtuTlBYN2hzeDBqTTVVUTduZ3V2aDVNL2tj?=
 =?utf-8?B?STgzNGJxTFV4U2R3S2dTYllOb0VWMmlyYUlJYndwRE9pZjRjSXJVUHBCOGxz?=
 =?utf-8?B?MmlMaGpxYWx1bm1mUFg2cHpSU3BiRzZKU2RJOEdPRkRGUHA1TWZ4dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2788b9-0930-4e83-078e-08df41afc15d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:58:43.3462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGqRCx0jE2KW0fOyEQqwS++ooLRNo9+tAbJdLZAtCjYLIvEsRDQQ4Rpv2RrKowKEJRL/ASq7L408p/Y907wxCWAcW8+O5a8RdMU6wjY7Z/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11780
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

On 10/12/26 12:28 AM, Jonas Karlman wrote:
> Parent and divider fields for CLK_TSADC are located in CLKSEL_CON59 not
> in CLKSEL_CON58. Change to use correct CLKSEL_CON for the CLK_TSADC
> clock.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
