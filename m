Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4648E606A329
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j08rkiIJ;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1hc0Rued
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C92C60705;
	Tue,  3 Nov 2026 06:59:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A1mf3U_Sxy0B; Tue,  3 Nov 2026 06:59:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 639CE606D0
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689155;
	b=j3vazDOxrdW8FzLlRqxGQQy7xCsLDkqvWjkeNPxWy8rQy1e2haCwACag7KgNUwT8vg1m
	 afDdatMZv6rgQY/rvI2ila6eHR/7cnPKCAD8E6wJbU3mrghHnJI740xZ7WM412ZiZzKFO
	 Xux90jxCzoObrWYSB0P+FdZFsZS3dGGt1BcjsMayCHZfHu/EBdtgtBSxhrOc++uTRosxw
	 pk7gShrUdQjHPcCHdFK4i4fIhAXqAmFYqMXlx2NHAsjpaoK6gTEUGntH2MDADLEPoqm/U
	 GnFhiAiT3ThyNlA29UuGQ7/niSv3T9/qZtQqgxU0uE8m7mouzHR+otlPhdOLoz9sm0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689155;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fluQYLMXOdUVtiPbctzUybSpwIr8o8GCNlzMrKWL6RQ=;
	b=IojAeEQ5yO6siMpNOAaJyP2JBZbRZZWajwFKc3kl6HWT2vRQjJwV42VF219Ydej7G643
	 sCnl7W4DBrpt9g9gwgToeiVbwScrVGogPd6jeTzEgnH/Jpcyd8H1U9OwTvK8kM54jJ4NT
	 cpvibifRFWkPtS2cAkr43VgbAxdCan+ZISebhjRc/YRYkkVvZPqda10xmFiJfo3u6Wjfz
	 Rh5E/IVEjqeqImXEdtQ49ONTdtJoJKfKtReS71G8FJr+zsszsP4GoIle5fe5V29yFlMxT
	 3M/5lo3ScpVoiSIRBkTQoHn1jVgcnQUy62MfhVaOsD8V0BnH3qLienlE+AiQ+J+EmEg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689155;
	bh=fluQYLMXOdUVtiPbctzUybSpwIr8o8GCNlzMrKWL6RQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j08rkiIJ1DSH0qgkHqEEZq+giOpHELnpMnjeFhPx7Bb5K4lYw+vxFZwKfw62K0pDg
	 aRaFmW2TzzKvsJTg5CSBXGt8t2NsU63by1Q9xItlFwJyj6f3V8ug9aPB6rHI5w9Zgq
	 O0bcJp4t7iqsf6a1M7K7Rmu4uBuboUvTMrKFmBUPv1905IX440I19+Z1h13WikfZM0
	 krjAH7O7qCy9WMzpwXQFMw5lMcPcSfUtbYsNh6hO1ucKz2MaLQDqLlA2LSGTLqE4Fv
	 wJDu36icq+eN2kT6/7FOmiexY9GZi32PCGFWaHdt8HBL9Y8+y5y0AHKFL3M9Hx9BVk
	 A4vVnAVWmS3FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 639CE606D0;
	Tue,  3 Nov 2026 06:59:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 58C3A2AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 489BF4054A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zvpmr_cghTwH for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 06:59:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60F7140509
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689153;
 b=ToSVYVGte0zbvhj+5iJjLcMwRTwlokT2F5OyEfl99nRVPvdrbduO/CFEXYtSTvT7Pho9
 LapCpTJj/6VHC3/SwKHPa0IE2kgJwPeCt21qupOpOBkSGGBNywE/Q/6HLbk08vBU/TJBL
 0JWrytdOK+QiK92AIalLF7AaXR9N2wIJrSPL0gibOxi8ZkNdbG608TjhectByOtlvLuSm
 mR1ooOVcehDpMKO0NBRglusdd/9pSmoTYXdg5CPFDTbbAagNHZ/iHzaFHHq3QfWf1wcQ2
 QGYu2wB9TbQlO+hBDR3lSe0n7TGjv+uu1uGfcuq4AhzpAjymVwYzCYipy4TWB3xYR3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689153;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=fluQYLMXOdUVtiPbctzUybSpwIr8o8GCNlzMrKWL6RQ=;
 b=aLXoxpcwCtNchQIUVNDV8thsSp4JAZDPLOzL5/iuiC5lk3Wv2P0wZwF2cUBaKzKW86tS
 /uGqblIPzKUiTgybgDKVCTEyiTgqRiEhJZl8rb9BVsqEmVgHnLeX/I/8mImpYzGxx5N9I
 CoS1UhlKfb/pMv1wmTWh9H+BJ9BSPC3AGy1chbBptKgD9Ziaeks9SYMTgWXBJwdCZu43r
 WhDLztdh3VqXMFZjf094k7/hfccekmwadjOpwF90tS07hVb+1VK92sBL6FJadU6DyRXsZ
 1F47aKgGsD6d/kHb1V/FkDdotwLIkCb+RUVFYEbKpp0fG1/b5LvXTGvrLK41U3BOtfA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1hc0Rued; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1hc0Rued
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60F7140509
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWcq/LloSY2neHm9x9oZq+1JOKBiPn2JPTTW1lCvsiSds84q5jRsPQ1pqSLUtsL0NvQ2MDjKwcbojFV38r2jqsHzNmRggI5neZC5tYNoRfXgJxpTpxCl53cJ2W30WzIdXPIWJEcX6LR1G7yb4vgXXStoqvKqFJfV5cn0KitLueo+VOAk46jLcdq4AuoFItPHLkJjUBLK21UM1ktDlbDhoaJIwu+y45jUSUl56ucUHV282kmvah5AliS4STfYp7e2MHxzhDSce84zb5UAmMi8m7gBFx+y8iMiepsK064ktBMc4kNieDS38J9LLjSyiqw3yoLhvPfh+8aApuVLw+Owqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fluQYLMXOdUVtiPbctzUybSpwIr8o8GCNlzMrKWL6RQ=;
 b=hgLleUWJfQQso/9CWtAjluIpbx2K2PDGJLQJymXA2iSlvAwRBZ+N2Y/2G1CALMQXbLJ090dJprNOHBvQuxKliwmA/eDzQGm+KatYYpWXbFTHV0AU+khMr5jzSTt5s76Xsj7qGsS86h0b/mW+bl8BK0WlU4+wGMrGS5rM7soehKmyRW0iZ0Uc91gWRq9NfMg3c5QflVWucWREBCQ1KG930iiVG3nxhlaw7z5lY7qtoqHd/+R7lw8sXLi8NYER7K2yH8wxvRmr26RwjlQEjaD3Y/K+CnZa1zWS71Lea/b/9N3iBdYwEJ7eEHyFjWLberSzwq+eUcUBrAbOiMjd0cfB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fluQYLMXOdUVtiPbctzUybSpwIr8o8GCNlzMrKWL6RQ=;
 b=1hc0Ruedf0G+oYZvbYiBsNVj6TAz6tvc6pA+qn8UpEzphv88LpZsYdnatxk8kJgJOi2kmzos1Wqo9RGo5V68S0vMSMhPChSYkUY0LGRu2KLB9qHp6nM74eK2cjhAXjRefJtcePdPvVcoos5zNAdBfjfQzh1i/RCFxghrfL2iNKY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:59:08 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:59:08 +0000
Message-ID: <f34edadb-aa8f-41d2-9dbf-bb848fc17148@amd.com>
Date: Tue, 3 Nov 2026 07:59:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: zynqmp: fix PM_REGNODE_PMC_TAP node ID collision
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Akshay Belsare <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>
References: <984538550e0da30844d82201b3eead312a3af78a.1792504307.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <984538550e0da30844d82201b3eead312a3af78a.1792504307.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: b58e13c2-cece-48de-ba5b-08df3977f4dd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|11063799006|261009223027099003|261021123027099003|56012099006|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5CBX+z3xbDyqL2bhNA5qN+1xoFGh/rbrgJbhpjYVdJxfunM34FZsC+Zm6LTqcSjbV6CzH6h7RvSpinkwVUY/bi8WHIoCxrNd/yPPLppJcIBlkJLN33lhdVPJaO/ITsOobYZxW0YP+NOvZGLbE6SFG+czT560YY/ub7cV8kUlh5H4UxZ3UKOn3aCmO9XLTV/cJvPaDXemYqj0ppS6TTeTqkiwvRBBJqJN1G9Y3RtiMXI1OGydu/ToD/+SQkVVjjVK/9xXEqrbYeTZUxjtgFn94Hzs+A8NxnVkP2z69BbmA4YCsRNBOHcDehsZTIACZ9IFWBe7514/KPOSdTGzrw47OnuNXGbr/5cMExc2KneDVsEeSv2POL+6Yi3+6DkutWrPZgUo8fju74xSr3kI/Kx7J2gcISFDEunrx/+yGBUI2kJQ+mipB6at5XPUx/Q5iW+WNgMVnlHsAK0zxGe9hu1maAfSEdamtgIe4e60anj79TfmT8Nnu5r7R21vGSLhcO3hV3ynl7p4pzcFJd+ZEneEQuRKWAxpLWPY9IQiobBy/j+Ac+VZtlHuQftCxzTL9SQ3OvRDyWGLzMa4zc8P0shUsOgqNzF3jhH9cHV+PboZhfTCNUblcsmkzDq/F17+fTHS8C1hFdSKbqM6LseHEzCb9SCzmhJG0nOPZ6i0bSmSNf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(11063799006)(261009223027099003)(261021123027099003)(56012099006)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUJMNXJIWFl5U3A0YkF0YzViRzEwSUdEaXByaUliR2g4NjhQeWZJaytvZU1P?=
 =?utf-8?B?NTZxeEJQRXhmc1ZXQlBlT1lUQ1BxOTR5RkZnZVdNeXJDOGtmVkgwVU9KcWI3?=
 =?utf-8?B?TDZNNllpNElUU1FwQ3VCZTU0UlgxRjJoSmljWitDQ1dyaWpSamNpTGFvSjhP?=
 =?utf-8?B?MVNDQUhnUm94ejFrZ1B0bzhEY3l4N0x2NW95c0RDQ1ZBTnZlNWhtTEJ6TDQv?=
 =?utf-8?B?dUVnYnlSMFlVbFQwZ0JQSExpejNzUU5jcVFPa0lNL2JRVGtLTVRwTE41N01s?=
 =?utf-8?B?WDF1K1pLTFYxSEZ4WkRNbGliVTBmbEcxS0F6WGtQTmRFWXRodjlNYTFXZFc1?=
 =?utf-8?B?UE5waGxIK3U5cGVVOGhIc3I5a0JOalZyY1BoNGNrdjN4ajNBTlNLSHdGbU1K?=
 =?utf-8?B?aEk5cm5iSVpnYTNJSVNOUm94ZFVjL1VPTkxCTkFGUThJV2JnQ21aVDJNcGh3?=
 =?utf-8?B?dmlYckpsMzdYL0Y0Sk0yQVo0UHYzKyt6c1U4RTBnOENkRmVzOWdaSTVKOGND?=
 =?utf-8?B?QlBQaVc2MlphREdtcS8rT2gvWXlySlU3aE9tcEVMcFVMbTVidGRKV0JpR1VC?=
 =?utf-8?B?YlVmY01NR2JJM0RpVU95Y0ZHcmZUK0laMlNuWXc1M0lhRmh3SEFCeHF2UHF5?=
 =?utf-8?B?WFpDN20yNFdWUXVZQjVMUEtySmJzZmJqZVA2TVBtd3AwQWkvVTFhQmhNaEFz?=
 =?utf-8?B?Z2htdGMxTi84Q3lKb0hSaVpXNHNYQlRneHJ6VStLcXZuR2hsR2hrZVlrTWF2?=
 =?utf-8?B?eWI3dDUzeDh3S09vWW0xSnEwUVJOQ3RMWjVySTB3WEJtTXpXdTVSK1JrOUpu?=
 =?utf-8?B?NElwQmpJajF4NVNwVHFkZVVrajJjMkVlVE9KT3lnbkRIaHd2SnFCZklzaTVF?=
 =?utf-8?B?MythaE41ZjRPeG01bWw5SjhWWXp6aFpSbE1zZkhoUW1PV25FcjFud0JJNnZ6?=
 =?utf-8?B?Qm14dTBVcnQrcU8xTFhVcys2YkFDdmJrWmNxTEZKYWsvN3ZlWXVhSzg0bnBL?=
 =?utf-8?B?dFRqMEZTeUtjU3lqbkFZM1V1YTJ2Njk5ZXhjdVZFT0NobW5KVkJ4WldmalU0?=
 =?utf-8?B?NGFyRVI2NlYxWlpCbldBZU5FNmFaRjBieSt6bjJOZ3hkU2x0VGtDckpCK2Rz?=
 =?utf-8?B?TlRPS1d2Zlloa3BiMzVxME1JTXBIaFpsOXRPRHBoamdrSXA5bXhLL3RzY241?=
 =?utf-8?B?UFFQOW5EczQvaGxydlpoRThtNm9jOG1rWEYxS3N0YlI5NitFNkFleU9jajJX?=
 =?utf-8?B?SnVrMGtWV1FpZVBWelNEM2c0TTJYTG1ZYlNlTFlFeFRtQzA0Z3h4aHFZYnkz?=
 =?utf-8?B?M3dGRW9LRWVNMkVNZWd2bjhLaWNUOUdHUSsyeVczekhyM1dzanowN2pzcTRI?=
 =?utf-8?B?MUs3bEFNeGFPOGxOZUk0Ukg0dlpVbGhKWVdLMEZNRXNWQURnK2JhY0w3REdN?=
 =?utf-8?B?aXMwTjMwUzY1WFFxaVcvZUhoZkUzTVJ2QXVPaXBmT0FsSGY0K21mQXQ3QVVP?=
 =?utf-8?B?bUZnMGN2eWFuei93K3FTeHkvV0c1Q1doUWFkdlYvQ2VnUzV2eU90QXZiU0ZE?=
 =?utf-8?B?SmsyL01yVjh5bGxOa0szN0tNZDZuSWV4ZVpoMUJDaFhjLzRLSzdjb1h2MkJX?=
 =?utf-8?B?WVJGV0ROZXdDVGxVS3ZTVDdwN0xWeWFndzZCR1ZhUlFwTEljT0dZbytHeTVw?=
 =?utf-8?B?bzBhcStkMUViczJsTmFIRmloNlpXdVBPa1BlK2dCWFlYVkNoUng1djV5Nk1I?=
 =?utf-8?B?aytINytlWGNoWUQ3OUtlQ01sUGg1WmJjdFN2anlCaDZMeW8xaVd0VXVRME03?=
 =?utf-8?B?TlZxUlVKb2tTaWd3UjErVkhCbkV6a081ck8rT1IzSjlHTVJYR1krQmpEbTFK?=
 =?utf-8?B?eFlhRDJFTDJ4ejZHTkZZT2RRUWFVbm5Udi92aGdNckFRMzM4UTUrOGl5M05C?=
 =?utf-8?B?U2srVEdUemp0M1RMUEZjZ2txd1F2Z0ZkamVMMW9VUVhWMDh6VitFZ0pOZktw?=
 =?utf-8?B?eWdNNmN4SDNCWUhQU1VlekxsSDNHWndQRlArdlRweDR6NlEyeU84dUxoL1lt?=
 =?utf-8?B?WHd1Z1dCTEhtQlFqa2g4Vm12TEhiVnVmRUNndU90UTZqdFdFc0trMGZ6UXZn?=
 =?utf-8?B?bks5WDJPL05IQ0RweEtGZUxoTlBKRklPZ1NlekZaRGxpVk5iSDhKUGZNNXJE?=
 =?utf-8?B?aUc5MW42alpSWFgza3NaZXZ2cWlXVmZNMTVPdW1Jc2ttSU9BUmxiSHduemox?=
 =?utf-8?B?TS83dHZSY0I4bzFWL2duQW1UNmxxS2tFampBejVpU1ZFakVLNEhEVTFBK1NV?=
 =?utf-8?B?dDZ5NUpnTDUzczNHNmZHNFhoMW55bmFlQ081VWE1ajdjSFdpT0FEdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58e13c2-cece-48de-ba5b-08df3977f4dd
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:59:08.3363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wd6wXlG3BlAPKdGi0hsLK/3LPnMipDmQ4K6jJdD3zmjOeVx6H5I3vVNAw/s/Mb6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB347562
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/26 15:51, Michal Simek wrote:
> From: Akshay Belsare <akshay.belsare@amd.com>
> 
> Update PM_REGNODE_PMC_TAP from 0x30000005 to 0x3000000C, matching the
> dedicated PMC_TAP RegNode used on Versal, Versal Net and Versal Gen 2.
> 
> Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   include/zynqmp_firmware.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index a0a2ed79643b..87d7051f814d 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -540,7 +540,7 @@ extern smc_call_handler_t __data smc_call_handler;
>   
>   #define PM_REGNODE_PMC_IOU_SLCR		0x30000002
>   #define PM_REGNODE_EFUSE_CACHE		0x30000003
> -#define PM_REGNODE_PMC_TAP		0x30000005
> +#define PM_REGNODE_PMC_TAP		0x3000000C
>   #define PM_REG_PGGS3			0x30004003
>   
>   #define SRAM_CSR_OFFSET			0x104C
> ---
> 

Applied.
M
