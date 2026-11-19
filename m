Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62C606B415
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QFMODtPX;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=UvciSSO6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C64160896;
	Thu, 19 Nov 2026 17:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHtMRFCS8j5O; Thu, 19 Nov 2026 17:13:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E256160749
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795108402;
	b=qclvbHdL8sBTBY2vafdRu6LdpAqnfPV75jRUmk8/lLEGxgitgaNVyh/D4Q0bncPGy1xd
	 ME+jxvqJBURBA5nABA15686f9FhfxQV8np8/5K6PeKaHzjTbE6h/mebUl2yZBB0eTmD3S
	 /GvmuOEJcdMsNK1g/1N5eOX9EtJg91bEUxDxOxtAOB8lnflLK5EG5Pssq3NMelsTtdRZh
	 Eg1KB/2iTo+tOKEOQrxjMGw7ougFEkc0uiz185McuM5p9TPwRYwB3DCodd8NGybhlNR3W
	 JkJR0tTCtFjk02Q0rUV4O00HYYahv1fqOxcH9A6zzWDnUzgb3xNP9hQo93KbHb7qhLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795108402;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MVEOISpdYhsI6kBChGFwFFdhSHKhKOuTYZvIPRSfSyQ=;
	b=RYuKEqi3ie2WFEC68xM5ccMDVZOLzUnQK8QejHmoAFKqGANtY93ms5unraX0Q7XyFEaQ
	 S2xZXF+vxUrAQ5r71XJTPpg32F462TVqAHeBMJDO6QeGMdr5gmUa3hRja8+WESNaeQY8O
	 yCQ5hy0O2WNI6hk/fT4xyOTSnRnRSR7b2CC8mRVJqrWlinatsQ/RTVu/HcTdMplTQ6E5q
	 BEjoG2CJvQ3GWHwpTmMdjeWzwqzfdXPcaCBbvj/DbvT4EBxjJ4tfnkZP4K1j/kZdz3ABo
	 kcgpYWWCtgE4td1VJ5Yi8nY9onzejvQ/0EMie7sQ58MdmrzLXrZwmdlnoXPfALNBcMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795108402;
	bh=MVEOISpdYhsI6kBChGFwFFdhSHKhKOuTYZvIPRSfSyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QFMODtPXH2cKxLbr4CtwHfBjdGImTET8+ex6jS3MFSrPN57V2ulCw0WT77JiMUILh
	 LWJ4Uw5m78KdElVbrYrmhl1fJCoK8GRVGOikB+Quq6QjMavfMWxBgBlxTVkwczKDdd
	 nuibUs/zAci2jNOb/m1SGpQzbW97pq1tYGqc0q+79eNahc/1thSvCh+L9CS/P2l7c4
	 dkM1Tx26PshZSpLGRYbeBk4SRCc7EmwoWCJV0sTKFyclPzmudBFFUjpRiwXgw7/jJ0
	 ETs5hoIzrzrt9GpqugO0p6i5q9bpqsjfQYnrBNzljFWQNikH4qc/sQWnpwvmuVObw4
	 hN8mMuCPofwuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E256160749;
	Thu, 19 Nov 2026 17:13:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D6212FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FA3B401C8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bfaRUHzQPxvL for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:13:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2E8F940180
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=UvciSSO6
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E8F940180
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVEOISpdYhsI6kBChGFwFFdhSHKhKOuTYZvIPRSfSyQ=;
 b=UvciSSO6+G9bpu6V/koHaLRx2259EBcOv0drRyQ+aoFqrmhnB4mxniNw8KplWkW9DxoC03/1jmUu/Dj05BlOiLvDsqvFn1QYMc6+0S1ZCI6UE2CYDOzk0JM1mb7bJVuN2jNgc41cqsqSUo22Ga7SHdf20vzaX7U/zLhdETt8aUE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB12134.eurprd04.prod.outlook.com (2603:10a6:800:316::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 17:13:12 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 17:13:09 +0000
Message-ID: <0ff5c700-9ad7-4aed-8309-aa40e6e3cab9@cherry.de>
Date: Thu, 19 Nov 2026 18:13:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] binman: Use mock environment to ignore DTC
 variable
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@nabladev.com>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
 <20261116-qcheck_fix-v3-6-b6cf7e96944b@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116-qcheck_fix-v3-6-b6cf7e96944b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0017.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB12134:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8ab342-4a1b-49b9-e7ac-08df466062ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|10070799003|261102123227099003|10067099003|261026121527099003|56012099006|11063799006|261021121427099003|5023799004|261021123027099003|261026140227099003|261022105027099003|261022115727099003|261028144727099003|4143699003|261022075727099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: ljz9B37nFZCUwhXE/N1v4+LIl5CgQlhOjwMNrYo7YLVknCaRztLgOLgDJpdFFuJ1IjJt9Lbj0o/jRUVgRHtVWG9XSEC838q0olojnRLPCErf6MODYl8mNNFjbgSMGz4pmQ6JPhIwAtLVWwxHrwrz9Byf0mFeEBY4tNMe0bQgNrR31peqE+5Av8OSYhKuH3zVeQfYTYz3FTBhQFqbemZSCxPhCZXlwhLs3xiOjaZnF5BMSf1XbeHKUNRTnmyDREt4x9jbH2Fr1XK9YMA2NzT/mZZQ2ep3TjIjvzDCHMr1E9XYVMDU23MpPwfbgnEsXcQt4uW3UfhzctwhLmcyeCM7sKSc6Wc8+XFTN3FlW2BcgmgzU5QSa96rHcV6AIGOFPMAXgvI0jYVtjDYlprCFvzV6ENsO52xo3bttizdDnVsL8bXFnfDDnPd5T79WLy54+Y0XDvs/Rmsd5M7X3Aoax6LmVtwy4bFrjnJMasanyAv5FMuj1yln9+AUA/WFaJToxs91gYhXcGV9zEdrXRwHKUtRDU3cFMcRCRpEBoUVSOpuL152bBX6S6gOAurB+JfjUHyO6TnVp91amNRcHSMbfagj8jKFQQFrbaanVgDbxAeO7wcNrAXpi5JmSgWJc78DZ4Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10070799003)(261102123227099003)(10067099003)(261026121527099003)(56012099006)(11063799006)(261021121427099003)(5023799004)(261021123027099003)(261026140227099003)(261022105027099003)(261022115727099003)(261028144727099003)(4143699003)(261022075727099003)(261009223027099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckxaWFpHT2dnQ2N3QXBTWVNGa01OM3NNWEZIMUN4L3ozOHBaNFlod1hPNnpU?=
 =?utf-8?B?ajliaGwyWnJ6dlpKM2FnVytDN3lpSHZ0N1A5azQxMzBQMVZYeVlCTmt6MFpH?=
 =?utf-8?B?cmp4VW1xbVVhV09pR2hqbFI0emdjajh2cGo1N2JDa0xlM3ZYaGxPZzQ0SzMz?=
 =?utf-8?B?L08rbWdnVDl3NlNsUXRHdDgwSjkwbkJoc0RyMEhsZ0xFb2JWRTl1Qkh1MUg1?=
 =?utf-8?B?aDgvZlIwcXFvS2lXRkh5ZXJjYi8xSEVjSDl3QURjQjZ4TUxmMjJUbjBiV29C?=
 =?utf-8?B?d3RqNHU5T0hZcVpOT2N1OUlSZVZ2UjVpbkswWUxvRkp1d1hpODdzNDNvTU9x?=
 =?utf-8?B?MGFaYkpMRjl3ekFPTDJaLzFEMmdBbWpRTzQrQVNQYmZWWUtZbDVVSXFQMGtL?=
 =?utf-8?B?WjlObnhPZHhRanRKdEcwNGJ5dW9kdk8zd1o5VWdEUnZyUXZNVXVLKzloQXJz?=
 =?utf-8?B?THh4RG5lcXZnWlRhWHR3SVB6VWtkdFQ4T3J1NXBZWnNVTWlTaVpTVDJsRVBO?=
 =?utf-8?B?NkhvWXdTZjdnNjRuK2FGdEdSWDQxd3NEeFViUzdXRkhCa0Q4MGtZUkRvTGli?=
 =?utf-8?B?U04rUDRvRzFaQUNmUkpLbmUxYStJMmt3MVpLd3FsaDh3Y0pUUmJHNXduV3Nv?=
 =?utf-8?B?NkduUzNIcTZxSDZ6clZNLzhOWUxOTjVrUlJjT1VkT1VpSzJZUGM5R085WHpa?=
 =?utf-8?B?a2FTMTVYM1F4M0xrQmk1ZG9IbEk2cUNCZmh2VWtyN0VRR01kcFZ2eU1TM2dr?=
 =?utf-8?B?TlFzNnNaam1BZ1p3K0twa1ZSbUJJbEN1eGJua01Bbk5JVjlZdks5b1BiNnU2?=
 =?utf-8?B?RUlzNjFFQWNJaFVVampWYTc3RXVKRXU2blIvN3ptSlFEaXRLcTljL2E3bVZm?=
 =?utf-8?B?aTZvdVFpM1JGaU1BTnh5cXBaTytiWXUxR2VoQnR1RnhFMFJhZjBFYVdCUUgr?=
 =?utf-8?B?a1BOTmNKa2F1VlpzK0FKUFZoZ3IremdYekRhaWdhQmNyY0I0YWwxb0kxbDNN?=
 =?utf-8?B?UG5wbS84QXV1QmV2VDN1SnViWFRnSUxxazdLeDRndGw4KytacFB2ZkpkY2I4?=
 =?utf-8?B?TlBkZkhqRXJHNU05MGl2dWFoTjJNMThUTUU5SGNvUlMxNFlvT3BsQUtUb0c2?=
 =?utf-8?B?UUs5SEJNSXVvZ0VObTR2SytRMi9WTDJreHNYMmdKMnF3R0VSVmMwTjcwWnZ1?=
 =?utf-8?B?MHd3OWE5cG9lRExTOWlwQXlmU1g3RVNQRjRkR29hRk90b091Zlk5QlNRMjlZ?=
 =?utf-8?B?Q0xKejdSbXRGYUhlSUxEWmdQeUl2cklCMlZINDdyZEZaRVlkWklPRUJ1cnl0?=
 =?utf-8?B?UU0wQjR3ZlpEMk13eHNXc2NpRmpMTTExRmkrNEUyZDlHZkJ0MWoxYkxHTmUy?=
 =?utf-8?B?c01NNUhGa3FXOXlYWThkbTJITXorc2lnNWREQi9yOHVuM3hmVUw4bjVDMGNE?=
 =?utf-8?B?L2JmVE9lQTVvc0xnZGRDd1F5am56NDhKRHlUWVdXcXdnSTRUaUpZejBsVURM?=
 =?utf-8?B?eVpxSmM0L2ZOb0M4ZWpTaVp0eVNjVU5FS0VWVWNxVjBsRzFubHFqK2crRXc2?=
 =?utf-8?B?bTQxTWdhbzdiWjViTmkvd2dGQnk2N2ZwRnpBYUtMV25jM2EvRDFIMjk0MEcw?=
 =?utf-8?B?SVNHeG1oTWRtS2trWWFxS0FlY3JUU1B5cTMrVng3V3pwMWpGOGdNRkN2bm5W?=
 =?utf-8?B?aFl5MkYwN0lUZ29sd0hqZWNtZFZIS2pyd2luRmR6bjFyTVZaQVAzMnhRU1Rk?=
 =?utf-8?B?OFMxUEtQZWhsMmVac04xNjc4SUYzYmluQ0FDNTZBU1JPZ253Mnd5c3lydlEw?=
 =?utf-8?B?WEpFNUpXUitLdDZzSmhKeU50UDFhcjArK0VsdnFRdk43RklPbVpSUkZGOUJs?=
 =?utf-8?B?SEVGZFVPUE1Id2I3d1AzVEQxWEdQWVNwdlVMRUlVRVF4SWJKUlJsU2hzQmkv?=
 =?utf-8?B?QlZ4a1A3N1BETEk5ZHFkSVJtNlVjODB0TWltVXNQaTMyMEhFKzIwOXpldXQ4?=
 =?utf-8?B?bEl0eXhJMFNLSkorWTRQTXFSaFRwWU9MaDVSZWFzdGJ6T3llRGs2STJYc1Qy?=
 =?utf-8?B?L0I4cUhaUVI2aWNCcVlGMGVDRDNCSExtaDY1Rm4vczE3R1N0cjhUT2kxNGZu?=
 =?utf-8?B?aU1oMUF1Y2cxUGlDSUM5SjJDTTJtOUhncW5uWVlRQTJZQTVlSGNVMjhmNE16?=
 =?utf-8?B?N214NXRWNElkdzBzU3pKQTBXa1VTQm8wVEVySnZrYXBPSTFMSTVHbzczRzZs?=
 =?utf-8?B?YjNCMjRpYm9mQUthTmxzVXBQUTRYQ3VwajVsZ0kwSkNocnRFWkI1RU13VWJo?=
 =?utf-8?B?aGZqbTRXZGtpNVdLYjFQUStsanhRbnYwU2Q5dXRqaWUyZDRWVjhURkxMeHN2?=
 =?utf-8?Q?K9TJGZxGtGpSw/791Cii8mubdCahN+KK3+ILfQzJ0EeTi?=
X-MS-Exchange-AntiSpam-MessageData-1: DY4HqOjis77rjx3z3EFMTkOCuXCWLsPPRT0=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8ab342-4a1b-49b9-e7ac-08df466062ac
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:13:09.7529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOoaPU02tnBtM8iTIhU8y1n46tDBcVY1x7ONUxDNNHkFNoLs6Zr1cUb3bmNzBUWAo0gVeJOgcSH0URvWt1x5nGr4NGhdtMthoVuL8QH7OSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12134
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

Hi Andrew,

On 11/16/26 11:59 AM, Andrew Goodbody wrote:
> If the environment contains the DTC variable and it is set to a relative
> path this can cause the tests testFitFdtListDir and
> testFitFdtListDirDefault to fail as they change the current working
> directory so that the value of DTC no longer points to a valid dtc
> binary and so the tests fail. Instead create a mock environment that has
> the DTC variable removed from it just for the duration of the test.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   tools/binman/ftest.py | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 567ffa96b2b..50fb25325a2 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7984,18 +7984,26 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>       def testFitFdtListDir(self):
>           """Test an image with an FIT with FDT images using fit,fdt-list-dir"""
>           old_dir = os.getcwd()
> +        local_env = os.environ.copy()
> +        if 'DTC' in local_env:
> +            local_env.pop('DTC')
>           try:
> -            os.chdir(self._indir)
> -            self.CheckFitFdt('fit/fdt_dir.dts', False)
> +            with unittest.mock.patch.dict('os.environ', local_env, clear=True):
> +                os.chdir(self._indir)
> +                self.CheckFitFdt('fit/fdt_dir.dts', False)
>           finally:
>               os.chdir(old_dir)
>   
>       def testFitFdtListDirDefault(self):
>           """Test an FIT fit,fdt-list-dir where the default DT in is a subdir"""
>           old_dir = os.getcwd()
> +        local_env = os.environ.copy()
> +        if 'DTC' in local_env:
> +            local_env.pop('DTC')
>           try:
> -            os.chdir(self._indir)
> -            self.CheckFitFdt('fit/fdt_dir.dts', False,
> +            with unittest.mock.patch.dict('os.environ', local_env, clear=True):
> +                os.chdir(self._indir)
> +                self.CheckFitFdt('fit/fdt_dir.dts', False,
>                                default_dt='rockchip/test-fdt2')
>           finally:
>               os.chdir(old_dir)
> 

os.chdir() is not thread-safe as it changes the cwd for the whole 
process, c.f. https://www.man7.org/linux/man-pages/man2/chdir.2.html

Nothing your fault though, and I don't know how to properly fix that.

For this patch, here:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I'm wondering though, do we actually need patch 4 which removes DTC from 
the env if we properly patch the env such that it doesn't matter whether 
it's present? If we really need it, maybe moving it after this patch 
here with justification that it's not actually used anymore (and was not 
working before anyway), would make more sense to me. Just nitpicking though.

Thanks!
Quentin


