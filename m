Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B141606A335
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I8vSimp3;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=CJ1RxqYl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF90F40921;
	Fri, 13 Nov 2026 13:42:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r4I-xpmOGi7l; Fri, 13 Nov 2026 13:42:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 342D9408ED
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794577340;
	b=AUjzXtKKEGH2yKaZMpGawtTVe4qkN3UQI/ml51lVaMg+us/u9Q/3yAB2K517lE3SLr2a
	 9/9m8NkipUPljauqh0/Fd9HU3NqL7w6R1Or6+PAcdXM4pA1Fam/WCqRYJCUAZDLcpMBGX
	 oPly/HSLpPtFcqZwhnZB9XfKagLbLqOmG9BuOyvLdcTx+hw1zJdc8+zLE2HXsfTBDIFju
	 0SsHWBZg6+dTEUkCJXmlh43rrbqbYXm+Su+pWIq9pqzqQ1RsEgfIR0H2QrOXJlpyc/idA
	 9kujJWhXiVEvyvypc7fojf6jzVyHSrAiEyMcj4TNU7NXh4dY3GQCvGcyNPJlgsuYVQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794577340;
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
	bh=9TJ9kYTOZeobtf1JrV6iMCbUhyTe4OYqWZES6DR9xp4=;
	b=kjqQxLrddrXlkE/uauJnIpMOccldDKGHXLZUnLiKVw2yA/8w3LCwTqs3gop5RqjMbxCp
	 WRlYwJNAC37g1haKSZo5xp2HAog1TjSVfDRZOr3ZX5KKa03kMUG752HRN7W2glXX/BsI3
	 7U8eS+3ntReOzgVVA0V1omaTzCM1JLfKQB9PNVjQWI1acU7Pwnpyn73pfYeDxz+tZt+gR
	 E/bsAU5boShtvjiBBeUUglc3kXzmxG7kytSzxdKhFC+rtvvFvE3y8snzhMGf2rERHNgTY
	 IaJJR8i+hR9h0vYpGWG48DszrRGaXpU/8UZ8k+DgoLchv3SjlC+FyILM4vyuDVMwtfQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794577340;
	bh=9TJ9kYTOZeobtf1JrV6iMCbUhyTe4OYqWZES6DR9xp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I8vSimp3kh1JQzl2BSmJ+HmHJ+Y/5J4Z9pL2eAjBV6yANcbQojX6mLGoC/5R1hJXY
	 IKvoTeUDCIp/fNAjkV56viAEMbDjZ/c2jLjGm6uSmNQaz2Sy12oPuw38KnyXf/AnkO
	 TsKQxZTQWRi2mX7NVXteAd2Sdfc6Ybc/FCDnW5+54oGqTjSfMvbc3eFW5sWceA87xy
	 Lb8mEqJynDtlxIpOlVe2JzKx86N/TSmPCWbxQdSH0gjvK+5F9qcjA40KLiEti1MQoX
	 iNgsTS0jsDL273LLN20L6PVLTPo2e+x7w3T41MJXukjnVhsqH6n2nXb5itay6mn8Zc
	 PwT4qYfZn4mFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 342D9408ED;
	Fri, 13 Nov 2026 13:42:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EBAC4178F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD97E60711
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:42:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0m3ErXaUkvz0 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 13:42:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E13C606D3
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
 header.s=selector1 header.b=CJ1RxqYl
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E13C606D3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TJ9kYTOZeobtf1JrV6iMCbUhyTe4OYqWZES6DR9xp4=;
 b=CJ1RxqYlr8aiCbIfe4oOBZ77tT5CJ1swsne9H86JbT/1TjG3HGiwY+EamNbv/saa+Pyhw7qtYl4bJcvzdCXutZoBmWsu8C6f4KqrXBGRzuPc357I+6MDujPs0BxWcTE8AYHG+qic+iF+QAtCp6eAURhONchchDOLo9FkPVbJwPo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS4PR04MB9242.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:42:09 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:42:09 +0000
Message-ID: <2e7fd9ef-40eb-4a20-b6d5-aff9fbf1bd85@cherry.de>
Date: Fri, 13 Nov 2026 14:42:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] doc: CONTRIBUTE: minor spelling and link
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
References: <20261112-doc-sending-patches-v4-0-d6f4b7e3eeba@linaro.org>
 <20261112-doc-sending-patches-v4-2-d6f4b7e3eeba@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261112-doc-sending-patches-v4-2-d6f4b7e3eeba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0301.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::13) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS4PR04MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a75ba1-aaae-480a-0fdf-08df418be9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 0dPNa056HmBk6I1cdvN7WHQ1d7tUqIIC3ugwIHDQW0VLzzEj8s7q0CZomT8tqOzrGMN7uxbz05q3S6jyPZpijHQSWC8mo0OhEFV0C1BhJ0U+T+rCHNYP6xXxyGU0UqTFCDNR56O8AVWAnxDPm0iX52MuzCfnk7TfZNZtJFHy3rGETlRI2DY435kWS0LFO3Pf1AKjnNl4tOz8RvxMYac64dQ7g0y5Xa0zYZu8SZraMmmRnEt9KpAhRPbYC1UdLqIoGNtxS6Qij1Oa7FftMvY6mjm6DiBc9a3SbxBucKkhWFDee0lNgOBq1YB/uzPvWb5GEVY8UJ2UbbbQTg7wcJMZz2F7tj0JYDrCJ5V0tm0W2gbPYqoFgJv/6colgIsHBY3bzE7Qm2TUWQtxd1BshTB4hFmQt4/UBrGKuPJ/BIEVgl80gMw6H/CxpWO4LYhJJ50TeLs8M3EtMww2hHINDaqnWzfKinZCLBHewUpDkE83aNchCKGHp++5div39Ng4sKyg507U0NpHlAZSWJb0zp2CXRabsraGV1L3AKreBJ+bNPOZqq1H3ydXGXYz2EcFGypgSCiTESoAbl1xDX9oHYMH4vpClgpKcwzU18Habr6JUC1gN5vt+EOwpuQiTCCJ8cKZMpcWpl+IbENPTALcv4h5OB99snZtK16/aVGlREmwTug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmpjZFF1U1o4VW5nclpRaUNZVzBsN0xKVjdja1cxSHBlTmRaNGh1QjNDWmVx?=
 =?utf-8?B?SmJ2ZE0wOHRUQXRtZmQ3R2pSQklqOHlxY0FEZ09ma1cxbHZvTjNCZnpxQjQ0?=
 =?utf-8?B?MmpPSHcvOXZVaSswelh5MVhkSmd2MVc0cFViUTV6KzBCemR1NmNwa2RGc3Yw?=
 =?utf-8?B?UkpsYVN1cExtdFY0dVh5cWpyM2VBbWc5cUNmRXhQc0gzUnE2MkF5ZnpWYVd5?=
 =?utf-8?B?ZXlJMGtIZ3dMeXh2N0Y1dlFVSXRqcFo1OStNb3IwaUZ4WGVydTRFdkZ5TC9E?=
 =?utf-8?B?TUNGWlVWYlRMaWMrMytGcWY5cHNvNDBRT0ZKbWE1Sk41S0hTZjZaYWxaTzAz?=
 =?utf-8?B?eVJUdDJsaS8zSFlKcHlaY09qYlJFR0p6V3NkZ0FGQlpncmxIZ01aOW0xQXpF?=
 =?utf-8?B?Qi9wZmM0UkV1dnBjOWFqVCtvb21ZcEJYb0h0NkY4RzFkTVZFd2VXS0xBSXlL?=
 =?utf-8?B?cmVaZXNZTG9KZW5oenk3ZlVDQ0M2UElsQUZUMXo1bWdtYnlEV2kwZHlNM2dT?=
 =?utf-8?B?OElnazRUcStCU0tTQm5NMzBzVk83YUZEVFh0d3JHNVNWelVRRTJpTUJMNXo4?=
 =?utf-8?B?SFdGMmIySEF5WS9hc0orVVZlNHY5Q3kyZWJETG1nT1BOWldVYW5NNHJ2TmZj?=
 =?utf-8?B?S3JEeXk0VkQ1a2lIUnZteWhOT1JxS2F2WjJKWjZ3N2VLQi9RRjloSjFudldp?=
 =?utf-8?B?cjBXT3MzL3RXNVNrU3E4a1ZwWTNYN2NORGNPclpoL1krWVoweXlaZjZTRFRn?=
 =?utf-8?B?L2FtMjNPc3prUEUzS2NCWlhhMW9XZCt3bUNIaXJpYWNOVUl1enVRUWV3VGxL?=
 =?utf-8?B?Wlh6amVjdHRiWUU4UUZ4bXZXbEN5ZGJjMGpzMU9GZFQ2Y1BGeERSczhWRnV6?=
 =?utf-8?B?S29tdDdmSlY2eFZ4MWdFb0ZOM3dkOGtxWmNwMGpoUzJ3TlJUUU8wcmE3UFBr?=
 =?utf-8?B?UjI5QytTdU5hYTRmUWVoLy9iZWZQYS80R1F1VEx2UTJ5R0t1dWZKL0xCeDE4?=
 =?utf-8?B?OUxidGdjWGVvOU9OWWcvMldmUlVqbDVBelpPbVNxM0I0NTdjRzZmUnJqOWc3?=
 =?utf-8?B?YW9pT2dYeFdoeVJmQkNzQWNTOGZ3NUVweHE0VGhlbmo3OVN3VXVxSmRldSsv?=
 =?utf-8?B?dG5qMno2QnhyV0R1eksxNmUrQXhWTXZncnRnV3pIV09yTzN0TEJjTEZ6NFJQ?=
 =?utf-8?B?Snp3dnEzNzZuS2xLWmdVM3diVHRrTUNSQWM4YmZtNmhLMjJNMTdkQjhtMHM0?=
 =?utf-8?B?SU1FTGg3cElBU2dqcU5ueUw3NG5lRDl5MzFVaFVSUVo4MnoweXNmQ1ZWZ0JD?=
 =?utf-8?B?Si83clV4N3VUT0RuMGIrS3BFZWJzOVlUa2h3WlVXZjMzSXg4WWNtVkNkKzhH?=
 =?utf-8?B?cEFERXVVd1dzSDF6S2ZVSTVwRmJUMkVqSGlMejU1ZnFoVW9zL01PWXBVU1p3?=
 =?utf-8?B?dXZyd2pEcDd6dVRZVzlVRmYyREJ5TlBRL3pMZ1ltYVIrL3dZQ0gxM2VQUkJy?=
 =?utf-8?B?VDU0QVRsSkhGMmtNZU9teGExZ0FuVzJMUndDK20xaFhac21RNTFLYWY3MW01?=
 =?utf-8?B?V3RERTNpZC9kOTNaOFdmdFlFcnppYldMMTZrS0htK285K21HVUNMUk90QTFz?=
 =?utf-8?B?RHJicEgzeDJ0SUNTQ3lHV1k1RWhWcG0rVnBYZEM4bmZYNnhHczlRQzQwK2pa?=
 =?utf-8?B?dzA1YUYxQzRJWWI2OG9MSUU4WEx6Ukk1Z3Zhb1BrN0pFejlPSkNRdTBiSWQv?=
 =?utf-8?B?SHBaNkkwKzR3MFJGbHkzVGt2QWFKQmNTTXpKNklhS0lvbTBybnlOd2h1L2hC?=
 =?utf-8?B?UEkvYzc4dlcwa2VwTTlEUUM4Q3VXc0pBVUc3Mk5KOVJqY0Jub1c4SFdFa3A2?=
 =?utf-8?B?QWdWRTNEQXpRWHVkUjhkdmN3ZVVSTW1MMUdwWGFVNWRrTGlTS0N0UmZ4Z2lz?=
 =?utf-8?B?ZUpZUC9obVpLSTZXV3pEZUYvYStET05BUEhsMEM3NHNlU1dENysxbTFoSEVP?=
 =?utf-8?B?REtTQ3p6VGJyZWpIU2VId1JlMWtGL3p3dy9abUl2SWFvblJRZm1UbUh6ODNT?=
 =?utf-8?B?UUN2QjVlZTZOcVg4dklTU0hqY0F3eUZIQnJFWjFCL0s1b1JjdlhmMmRDekVu?=
 =?utf-8?B?QUhXUG5rSCtqOU9XZ2lwMmoxUTdaMWFJc01mVGVGQlA2MzhFVHIybkc5WjJY?=
 =?utf-8?B?amx1SjJJcXhJUzRXTWJDZ1hpWmNKMU5jQkVyYnVNdDBlNUlOekZRbTFXeUxV?=
 =?utf-8?B?Zmt6VlVlcXdTNkZ2Wk9URjNxUEJzY2JUcUVYYTVaWXREWTRpeHI5ZnpINTdy?=
 =?utf-8?B?eFFEVGJ5bWZZME83MTdDRUxzWWFVdG93Y0xidUdHR1JWSGY3VG4xZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a75ba1-aaae-480a-0fdf-08df418be9e6
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:42:09.2431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3Xb2k2pSKvxHmHHZdzehhX2XuGfvJLalaM/uUOviJwc7nqnbhiP36XCiN6W1+J6XOjcE5FjuXKK+14mMgLzNDZ8FUdAaC0XrntSdcgVJJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9242
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

Hi Ralph,

On 11/12/26 10:55 PM, Ralph Siemsen wrote:
> Two minor fixes:
> - standardize the spelling of "self-contained" to include the dash.
> - add a link to develop/sending_patches.rst
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
