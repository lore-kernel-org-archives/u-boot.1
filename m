Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB576C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 06:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2F3640AD3;
	Fri,  4 Sep 2026 06:21:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t-aqsZb84uOK; Fri,  4 Sep 2026 06:21:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1AA6040A6B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788502865;
	b=gU5HnvDqtjVW8HRMxUbJ28402TViZaSjMK3MBjNvSrckwzASUY7P6c8KUFadEDDAw6mK
	 OyWSd5jODVQHfPLMJyNXzd0GAfy88ex1W3/R2pTsemRgqvMv04zgDgeWgONRj7TRSX+Cm
	 x7nzSCSig373dNErrkbUXs5reQiZcdl9LutiB3ItDglF9vgdzKRgY6UMd2tyYab9+QMAY
	 UCiOCjaChooPs+2mGetYkPhiDtRjDI7OWaqMQBIbyx3TrUK4BayT0fmDivM/RElR1cdyV
	 4OFE3n9O3O86hqEzt7u2CY2hGrN5zG/WiW3IBc8Vka66T+VTvOZ4035hwmyoaacOhBw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788502865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QZhZEZud6r1xgCSoJ+SU7CQoLxzna0vHUUVTj3bLygY=;
	b=KCJ/nDvLhOONTgf58JkNZlOu3nV92kU35a71OxMRH221gzvHJkpmZiUcKtArCUyxQLEN
	 kk6725LxRNMItqBbbgtdrZ8VEcZYox1QF53LtwWIuoUyyX4T6s4oxVkJrXmRGQNfXmGBg
	 kay2gYaoosudIcON0NRQm0GIFWcJ+4KzqaTkzivs4OP/FfXwVbmXMrEg5XV/leoKIIdKl
	 8m3Dk7tJ/heqgpll2tSaBoQLqpjd4ZS8DsBvlJ9dREvINrsxX+DYGe3fXGjvEhk6BhjN+
	 kz02Qyq7YlX9OUlVGtE+3aTnBqZzl6B9wJDbfdBJqYRHS5ttRBZjq8kSn5AxzR8Mfzw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788502865;
	bh=QZhZEZud6r1xgCSoJ+SU7CQoLxzna0vHUUVTj3bLygY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uWga089fcEdBkn8oBjREskQIwKfWaJaGf1Ox8s9gMu0ZDpKm1WVkj/GmE6pNAoRRH
	 5LUBiIB1YONqUvXWDjk/idUmvbETduLMiLQGDGITJScZSNh1S2bODQD8oac/E+K3Vf
	 bwHpIUSIhwM/8hkGeSQQCkSwCtAchi3DOGiWOS3XBMQ5z2diEPLKxRm/GE5FVCHLnO
	 ccbXjgk2ty3lSn/asnVwNfO15MG+rRccsCTf4V6ls/n1pFvlbfazlGcDNZQHrrtgQl
	 ij7YjdzzUd5Ywn4Hj3AIe1LBbfWZuoVwdVxi5risxeKN7xkpjnX9Blu1rk1Z3Yr1fw
	 fY96zs+OtNebQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AA6040A6B;
	Fri,  4 Sep 2026 06:21:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C600B2C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8915460816
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:21:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5GFXd9rqqGFc for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 06:21:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B7C626060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c000::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788502862;
 b=hm33c3f7QOTe8PAxxbCgraF38VIylulBRzklSRTGe7RZqKx2bZY1RRyToWUAYN2Ge0Ot
 +yX9zAsP1tk6qXV4dix32hbzS4h02vAbbRLj57wPierqj7DvolUXDwbit33r3Vj4MsBQ9
 jgpV7Z1rTQjOoLUEMGAXg4FxTyCMIJ9USMaYKs51aTm/XHNBLL+oJ/627R7RqaOT7FR2B
 BMbIBKVhMB2C7xS0SMmK0WSH9pesRL/Jekmz84QHeAub+y1KzoIgQNhzW4bmmESVWfjq9
 1OMISlpceAFS8bIMrfmuirK/nuKOYnk9TnqGXR8JMYrprppg0FM5Gp5Z6HzTX6fqDBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788502862;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=QZhZEZud6r1xgCSoJ+SU7CQoLxzna0vHUUVTj3bLygY=;
 b=WR1OgPWEWVTHNY+LoeO0DsZrVXkG3JHmGvDA+HtIbngGldUQP38xfgcWlBYks2UX8XYc
 FiGIsJCVbLS3JcUQBb3pUz1McEICcqzlpbvIyC4k58T3FLIGnJPAC7bP4IfPO9Xw33Bbj
 OCn6YGgeLEu+Gua2AH7sPGphdcNK5v3UnipymjIXeSp/iM0WIqsfdwADSjyFrXlFo5gkg
 I3i3TdBbKoBS00YCowpKf6LRgiEqob8wxt96RuvdIvLYFccQg1lwZXehVUQmKYBnQE8JY
 gu4GGiqknISpZPMVLTdO10UXdsAFm5pg6Mg1acZQIA6g46kBcvbEJUx4Q+ptOhtBEyw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ovb9kbOi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c000::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c000::1;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ovb9kbOi
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B7C626060C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:20:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMBZv3gmo/XYzzMZkpHFgWUA70AxOBP2aesWW25AoEinvmXSQ7jkbccZQe+SVAPGNLrHC7jMX95F2TzsIYd6lbDojM8twUGZ/fIu+ClKxqwFqIhg0Y/LqG/jXoEtvX9h7yKmywNNWwGzJwV/O8feeu8+YmBOIlr6wmvfN/XvDb2gTn7471UkrHrNPoxK0kdzwZNqaayEVu2bjaDY06W5Sb5Hw3xPCVzpJ1ydVHgw/b040NTuQY8n+Sy9oWwH3wS6DKolSqFUODOKi+adKDGebjY4zjx2OVZKq9qjh1jMwkJye/g8zSG685gUn+hTvdXHW7YTO05D0kFbzWuU5ChaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZhZEZud6r1xgCSoJ+SU7CQoLxzna0vHUUVTj3bLygY=;
 b=B2iRsl7JmjmkVcXfReifpJG6JKAiJQo9XoZYX6TFKLG8q4+owIAiUE0S3GtjmZl+R3LJ1DkrWaCP0BJhqyzH8+nNbNSLauPwqU8TnOWylly98wc4v80ZvsOu4I/BWkR3oBKCbouVyafLnz9ESu7r2/G2YAEtnL6qXBhxdHX7cexmXR0QRF5cgCL5nIlJBevXdFmKkkYWge7F4cRrRMkNjZ6t46yJ5hvLM6GxKRtbVqutrIbPZkhOszO0pZ32FAbEhp/013Q1/O3fga5QCOqASAeWOOwawfe9i5eEVrHJsV6tPC0VtwPozFtisoBPHnfsp61B5xAIt7TjuT+AAdH2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZhZEZud6r1xgCSoJ+SU7CQoLxzna0vHUUVTj3bLygY=;
 b=ovb9kbOiB5eot9vIf3ns+QdGryrL5PEY1cy36F8TXjKgX8o/8qv4Vl6LQ0FzkfrdFcF07ALhrSVMhWVDIxWmkMq6IPLG/GPL+sffHl4kOisDTRXVCEPJ+XS9vUVOd+N1aE5Rhs7w34bIW51eI8EaPGtPy7+ksB4PUdgNKpSSj0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 06:20:54 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 06:20:54 +0000
Message-ID: <972c116f-a430-4ed8-8b94-e4c1982e5f22@amd.com>
Date: Fri, 4 Sep 2026 08:20:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix IPI not initialized in riscv_cpu_setup()
To: Nikita Shubin <nikita.shubin@maquefel.me>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>
References: <20260904-fix_skipped_ipi_init-v1-1-3f4e7a10efe8@maquefel.me>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260904-fix_skipped_ipi_init-v1-1-3f4e7a10efe8@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::13) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: f774fe0a-241d-4649-a255-08df0a4cacfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|11063799006|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0uTE5Y+oLSVkTXTxO/9B8hIdXxAoF7oCjMnqEuS2Gys6fboykondWXrAJ+w0+P58iawbw+zaTgDNQ2KP0OSUsMI8ZG2H6cdyvl2aXKc06RyWfDUQttlieRBrU8GqM0JEvqwPxQpg5ZGIN33fj1QMqLQaMs6K8tosRxKTfF5yCK3n1evf18uZPPBpn+7CoLA+QBTgzIHHkKaFu0SH6btSBuWvXr2gEPCahBu6VCmcr8Frg/WPUymlsWiQy907YjLsbChOirHkWMVHa8wVGUQi+nEGlRJWq1cKseUesdbcrec0GgcOyHXHGjICoIjBae57IkecISe4XGx9Epd9JPVUT5JMTxM/lJYgaj7CaPfJ/JB7HheGHPtSsh8FiXj2ZvcxFo5J5wMbwU/ufr/y/kiuAdDLpF3+U/aYhsBlLXLfAqNhP1/3nN9rbiFjK74iaZ6b6rc9Qu/7pbmzdzIWa9VQdN9E5ankc2H26NgEx71ErCpND6PYkF+CWU7TcMS74v/XpWwZF+kr71IBzYfFVA6214szS1/jY/L1WUCJ8Kkffn3s7HiRbsLD08WUQoUP3MDkKZhiY7LqdztOEMxdjZkJfnkh0LmXbJr87n9dUC+DwmMBqrK9qimIovANSL/OMVNBUGEZ0aJeYm3eJYMR/iW7JVv5HymTad+j+zSam13YtQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVFpZm9sVDQ0R0tzWlNRUDNmYVl1K1ZrNTBFdHJZNHVlUElmSDNjRGI1SEJS?=
 =?utf-8?B?VW15L1VCR2FRRjIwWGc1OCszbVhjWjE5T0hQMDRIcmFrandrcUM1ekhURzQy?=
 =?utf-8?B?YUxpbWlraXNqdGJaM2ZFNXIwSjdFMnoyekc0bjhWbmJaV2wwNWxET25HZSt1?=
 =?utf-8?B?dmVmSGI3M0hEdG1mWjY3THl1VEpNVkhSek1UbjBlS29aeXZXYnJ3bUI4RWxZ?=
 =?utf-8?B?aVFRdVJ1VGRUZ2cwS2tXLzJ0cGxIQlE5dFAzM1g0VC9JUEZGcUswUEo4VEhT?=
 =?utf-8?B?blZ5R0RRbmFFc1hxYk15SkQrSWllTGh4SXQwT2hIZzR1bFlNeFdsczdYY0Y1?=
 =?utf-8?B?WklOdkhFQ3pIN1FwRTJWNFBWV1gvWUpmcmtyYlJzeVFtMnFvMGZrcDBpSnVw?=
 =?utf-8?B?NmNhNVkrWFpEZGI1WHBVQXZHMU1UeFNoaEVGVVpvcnorVlYwUHlrSVBqZVRF?=
 =?utf-8?B?dG1FQ0tKRkpmV3laMUhIZ01sclFTME9Oa200MFJyUEtzTmpUZ3lHbldodWJz?=
 =?utf-8?B?ZHhFTUJzb09pY1huTENPRnNRSlAvTmp5WVd6NE5CYlF1S1RFOFpGbCtiQjBP?=
 =?utf-8?B?ZnlsOHpJenlvSnhWNndsc2Z4NUlrbWVlcUJ0SkFVR2VGWGtpbEplUVJiOTZt?=
 =?utf-8?B?eXNJc29NMVJTSXJSTUVodnpBSzRXV0h0MGxwZC9qalVBakswV2EwYm8wOTIv?=
 =?utf-8?B?WWZidGFkS0lJUmxWbVdyK3VpSE1MYURKYnJkaTR4WDNIWHRSdGh1ekNzQzk4?=
 =?utf-8?B?RUthbnQweHJVYk9hTkRad1haZXZlSGNzSG9ZQnF2MHdzTTk4dUo4eWxaVkpp?=
 =?utf-8?B?NjBpcDU3VHdJb3lrNHJGQmZYZjhBWUoyMnZFOFlhc1J4LzZpaDcvV1NHTmhY?=
 =?utf-8?B?N2ZwRmNyelBnS1g0V2RHSktZWWVLZTR5NTRtSkdpZmhjYk9tcldIMlVGdVN2?=
 =?utf-8?B?d1hpbGthTnBpUVYyN29oN09QYllCYlcxb3p0NFREbUxCdXdYM0dURFRJdWNR?=
 =?utf-8?B?UGFFNFhWakFXcDZ4MjI5cDZXd0Rja2E2MGVlYXpXVnBzSWQ4c2FIR0dYa3F1?=
 =?utf-8?B?OXRNSmNCMWtzbVFQNnhsZm5ucVJGZFRZOXBVMFNFVm0vWXBmRTR5ZjdtRjZ5?=
 =?utf-8?B?eUh3R0RKR0d2am1nbXZxOUlmcmJMU2p2cDkzYWdDb0xIcDloUE54RU93cnpC?=
 =?utf-8?B?OXFJUWc0WVhET0N4SmYvN05aVWRJRmNOMkQ1VU9GSC9iZThwZC8yZlRJei9C?=
 =?utf-8?B?engzRkpTMis2WlFXWXNuRG9iOXZzNlRGZEVFMXhHdEMwK0lqeHB0eGU2a3hI?=
 =?utf-8?B?SXp0a0Zxc1I2MC9qTS9CSWtPdzR0cVN5dXJNak5vcnJXN1dIa1o0Mmt1anNZ?=
 =?utf-8?B?QjRsRlJOc040MXFZT2pqYjhzRzBrNm4vQTl1Uk9UWW1mUlBQWlRyaXRCZ0c0?=
 =?utf-8?B?SHRVSkdscGZWdCtGQzdFeGN3RXhxcXdySXYyZVF0dVZtaDZkb3FLY01WbEhj?=
 =?utf-8?B?eThaRThXZG5hK0srTlVNY1BaUXM5eGNMbmZPSk15UHZ3OTI2RGtQbWlZMGlQ?=
 =?utf-8?B?TnBsMGttSjNCRjgrR2owYUVUNEhtYWhxVnEzd0tIa0FkczhoTVFaLzROVjBM?=
 =?utf-8?B?YjUycGd2NFJRcHE4NjJNcTNVWDFUTnJZMHZycFV6SWJWaXVaYjlOOHRodDNN?=
 =?utf-8?B?MXlkWWhZeCtnTm53aUpvZnNoS0c1anE2YVAzSWNNVEtCcUJPSUJobGxrdUV2?=
 =?utf-8?B?b1BhQ2pReERzV1d4eTZna29RcXhpaWdkTmJIbnlYRk11Z2NCbHJ0b3ovM1Ja?=
 =?utf-8?B?eVhiTTkySmNzZTJxS1FUc0ozNy9XN1NubkVxNkR1S0h2dGQyUWlrUlJaN1RO?=
 =?utf-8?B?cWFSN1FPT2IzSng1VlYramtKS3hSVDBzWXBJK0ErQzZpSjJ3bEowVkdiN05G?=
 =?utf-8?B?TVUvcEdEYVRyM1RzclRMMTJRZ3REV0pPZlo1YTk4MjRwQnFkaUN6ZnVldVJU?=
 =?utf-8?B?MXZhS1NoOFFJbjJWSitsYVRzQ2JVZWFPSlhsbXB3dU9Kb1ZzVnBxSzFaQllm?=
 =?utf-8?B?S3I2bHhnMnAyd1kxU0JvT3owT3JWV3E4WUtaYlA3SGk3U3FBc0VlYkRwenIw?=
 =?utf-8?B?MUlrNEs0bEx5ajQyOE5HTk5xUTc0cW82aXlwcnB3OHJueEFvUW5UTFltaHRG?=
 =?utf-8?B?b1NQUk5jcURIV2FKWkZMd0FpMjg2dVdyN3ArRGlYYlZXdDNCRWxnbW9EVE11?=
 =?utf-8?B?d3NiNXdVY3BBN0JScFBRN2llVTNsYkJrd0s4WGVCcWx4WmZCV0g3TXlvazBB?=
 =?utf-8?B?RFBuc09EOEQ3NHliVmpZa0RJb2JGemJuRE5ZSXNpY2l6bFR3WXFlQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f774fe0a-241d-4649-a255-08df0a4cacfe
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 06:20:54.7381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sLzbvVq6c1JUiJAwIy/p/20b0XEOt0SOb9CRX7C2SZLgcP8KWbChLQqf7UGIFmJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
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



On 9/4/26 08:07, Nikita Shubin wrote:
> If riscv_cpu_setup() is skipped we end up with riscv_init_ipi() not
> being called.
> 
> But we still use riscv_send_ipi() in spl_invoke_opensbi(), so even if
> CONFIG_PHASE_CPU not set we still need init IPI and clear pending IPIs
> on harts.
> 
> Fixes: d8810e1d4f82 ("riscv: Skip riscv_cpu_setup() when CPU driver is disabled")
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>   arch/riscv/cpu/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index 3bec7c7cb6d..a65e6951384 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -639,7 +639,7 @@ int riscv_cpu_setup(void)
>   	struct udevice *dev;
>   
>   	if (!CONFIG_IS_ENABLED(CPU))
> -		return 0;
> +		goto init_riscv_ipi;
>   
>   	uclass_find_first_device(UCLASS_CPU, &dev);
>   	if (!dev) {
> @@ -687,6 +687,7 @@ int riscv_cpu_setup(void)
>   #endif
>   	}
>   
> +init_riscv_ipi:
>   #if CONFIG_IS_ENABLED(SMP)
>   	ret = riscv_init_ipi();
>   	if (ret)
> 
> ---
> base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
> change-id: 20260904-fix_skipped_ipi_init-aa5575f55bc4
> 
> Best regards,

There are 2 other approaches how to do it in the code but it is up to maintainer 
to decide. No issue from my side to solve it via goto. Obviously one big if 
(CONFIG_IS_ENABLED(CPU)) is another one. Or move it to own function.

Anyway
Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
