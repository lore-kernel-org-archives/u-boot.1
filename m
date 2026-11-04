Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA603606A32D
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VukUaSLG;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qoCT4z8S
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B05C440775;
	Wed,  4 Nov 2026 09:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TbmcHABx0fX2; Wed,  4 Nov 2026 09:31:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED8FF401EF
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793784682;
	b=T4tFjAVqfgeN9z9HiKye/qIDCRJogZUTylHIyyswPpaKW0eqhAt/aIwxHUiD2vDE+cYK
	 fQs+oaMLBSen9mpBRyPoeAt8RSYiVbjPe1mP2g4LjhekI8wbFciwZsOSp1ad75YvbVUtS
	 Eo+MTxDi4LvByHGgR2gmG5ZOcuut/jcpZfky4f2/H8H1KxUE2DGkmS1p1nFUqWjSi9WWN
	 eCemjSrIt6q80GZkivYJyxlLffHv43yecVNj8Wq6kSI4zknhkPY5xIoF7A0D2mWJiR+Mi
	 EwXA+AtawXamm5KAp19z4EpThELNirURNZ1rR7jypNF3B+C9MFemXHkTX0/AIcWlokA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793784682;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
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
	bh=y+XooMoYpSvbbAP26Rr0z3bybUeFVvz5+VRV56UBRLg=;
	b=fv7uucBnlH3LvRyL0/asqEUptdnpibHU6U+DAxr0f+RH7i94368LddRpw7rHt9ExZf4z
	 k3fM86CoCj9RjrKWNZWl4AXkK2AXxAvsrL3byksOZFTcdcrRBYMYsE0TW1wxxW00RCS2c
	 +JpmW2FW56UMe1jllA8GfjberNwgEu91fIk2SjwBhzcRRwPpTNKMXwDn1/hGPvrIAcwyw
	 RNnHzaWPFTsPnoqp0tNlXwlm33KhtsCm3fl3MVPPBcJnwFJ1Qh76KWMmLwKenx5zu4a/7
	 L8ZpKwWoabPSb5p2aHpJPlfQgI98M87+lzBcPN3/gnozfmKSAtxcQoifGxlGgLnAFyg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qoCT4z8S;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793784682;
	bh=y+XooMoYpSvbbAP26Rr0z3bybUeFVvz5+VRV56UBRLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VukUaSLGLiOYDj5arNBuzGAZMlneMwSKaLoVXoLyEhyn5w3ToCvtA15drezR6UcL/
	 ylGJ732YQLi984CiTUg442zj2pNH3OwPzqiWCx6DuIY1Ti+WlPfUbLqO1/OtCZs7N7
	 wSUc+KWkTamp7eHE/kCD6xepUnTh9FGxZ6Fu4u8eBYFThOS+1m3Aq31BPoSEuhJSUj
	 fEfhNtuq/1dS/k/SZxymFGzgElmlGnBPx3t+fJUAwC8YntwiWZEyXPDgvzOSI4qXD8
	 ZEUOF/LK/2Fs8E6oW6vnM7Tza6OqrN4HQPufMqo0EEEpMCqyu0ksPG3ABxl30BGQLT
	 5lUCbrMszL9aA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED8FF401EF;
	Wed,  4 Nov 2026 09:31:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 39E9237B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 372FD401EF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zvyhRHPqMquu for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:31:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 83B0240198
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793784679;
 b=UqCK92JWt+OvsbQ9jA/uTm1wApU1R58aiN3ukmS3srKOzrRhYdeKcDG4evS6GyqNtmNH
 ygY2Q9VMSNMDgy7SHMeyrymw34rLW8ETcYZ96f4c9tgHTmqrTypw7943/iOjl4NwqLxkp
 GHzblJ2+3CwO4jI8kVuLgdA3Dy1P6BtshKjW8qf5CyM687Wczf6tBE+i0RYNTN8mk+27j
 ukPfFunBZgKUeBQKRQ358YpFO/1Iv7UEHkKq73M6VAPx4mlN3qpcUkMPa11Oj7KJKa/Fa
 /ye6a9LD8LEvg1z8nNxSAKbAesf+Nw0zEZa6IPvwU84H6ZOpO/6yOiSlGdQlspTLXGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793784679;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
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
 bh=y+XooMoYpSvbbAP26Rr0z3bybUeFVvz5+VRV56UBRLg=;
 b=GoWdcUSB9u8jLV88lpxu7U/o++Jbwx7Gkt1jfIV/UJU5cFgkRo8BFgkZvrQKdPDP/2cw
 /NWauFtFSKKFWCj+tj/W2QsA/Gw7TMmH0pziMBcEuzbUFil025XGjUsgyQC7XahM2QZMO
 WvFvXdXTPxa3a0HFZCQeBOpkIfu6KuXQjQEG/Mqygd42gpFaszJX7L6YgcQx00XKZRmBm
 RYSE0MtWc/hnlK2rv3JhSYQacEF5rVNjH7UeWv4+c2bLNtr/3oW6j6Obw1OoQkEycaboh
 50qxCOTbjHdXxI5ZCnTZCHH7ROOy2JQsAiKvaj2uMDcaJw7sCUR8kA7WWgI2hoDqdug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qoCT4z8S; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qoCT4z8S
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83B0240198
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWAnRwHEVy35Fq0MqkO0cNlZbp95QaRrpwESqH39JQycUdzUJYTL6UClFLgHMz8+RkMeR2aXBCsNpYWt51PpjB8aTie/lRRdsSx+QjcUwoBV24MTST/pJ8GqglUBJoW3d1AJM93yWyGK/i7j/NwluaLbHh750JOESggz468LsocOVdf+3gPG3Dw3Ojj1aCg1xdYp7IdsmaQxjsHRLjTDOxTKwzfwDNeNTNt0sa+atuoP9fNNtXZJF4rU5iveAR5ipvw9kNy23s63dazkLivdgkWaiKdYziJW2jnX1TiXW3OInzCSSLTgwVwx6Jtj1imFTQJzXJ8KpEU8MMdxGrzifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+XooMoYpSvbbAP26Rr0z3bybUeFVvz5+VRV56UBRLg=;
 b=MfP1sgxY+dcFMMnuYQIrwmWMAjRqR/4lVb0FpV6YRIguUVKLlr2DByBg5g7FmR7/b7mdxVp/AYTMtK9yBhz3s/4rvQ4F5ycMvaLLQJLwSwG1HT0+H8qXx3ZiZJpNz5ODTLuIeIW+OiVNVcCZecLlpxt5s+GNhWB5oCMUxtW6QBSsIA+R3Z7ubi7T2qxfLJJaYP22oZmaKeniawVLWdm3Z3kNsR9x9yPvy5GkRLsT0Q+zSviBurhqCnNDW9ccpSPXqIkLxncKHcSn/yjhUDjMkMfH2Cu5xa7Qj42XfQkhhZoBJwvPBAFWthIR1gi7B58FnrSZC3IL5WA23LuvQL9+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+XooMoYpSvbbAP26Rr0z3bybUeFVvz5+VRV56UBRLg=;
 b=qoCT4z8ShIkmIfbwtC/glH0wd95BBuXCDF5i/guv73qZmNil5z3GShhxudw5g/74mfIL9UtN3kkSsZiF2bc0NdgeErgu/qyGnOP8xDPvHH0+2ojO+jIbVyHmfAX+yqi6cKB8du70styP4PCUxV/FHLakTjfkEZx5Nbr4lU/yWWI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA4PR12MB390589.namprd12.prod.outlook.com (2603:10b6:207:13e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:31:15 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:31:14 +0000
Message-ID: <e4f4472c-312d-4a3f-8d85-d1d1026df4e7@amd.com>
Date: Wed, 4 Nov 2026 10:31:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] net: eth-phy: release reset GPIO and reset control
 on device removal
To: Graeme Smecher <gsmecher@t0.technology>, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
 <20261103-zynq-gem-remove-leak-v3-4-2f02ec0023f9@t0.technology>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261103-zynq-gem-remove-leak-v3-4-2f02ec0023f9@t0.technology>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA4PR12MB390589:EE_
X-MS-Office365-Filtering-Correlation-Id: c15d957a-46be-4839-ea23-08df3a565f0c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|4143699003|5023799004|11063799006|56012099006|261022105027099003|261009223027099003|261102123227099003|261021121427099003|261026121527099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1TJJKJdqb399KwyglK06lL7JmTCHTr8bX9m71Sh/AlfznKMjCfsZ8UsDdd9E/Qi4usda9ZBmOl9J6D17YwUuK+32w/BeZE/e1J44ItTkTNlmd0XW2OYza6GSVQJfyWDE3L4MzWgMpUnh0qK4/WjWiEjBp3AZ5fAlH/T9Vy1psi5fo91+CafF/ESlE5xawxsxMFKibB53Y0YY/ZzcTWcs6CUqAK03ljWip427INiIOteFosBVNw1RgIsim/ubcrLDOgV+F8eu38en3zVj2Jh/ZQtmyUzjRKD+0WHXT6TTcYt6dYesEGufjyuYqMH9Bg+zUfKGTKHidPHCR6JKlaF1v0WLj/oIrVzAxe6EGAFL2TVVxP4hyWCkiJG1ZJb1z+9Jwr0uhSJ+hqS5ggUUgvAO/z7McIIGku6IBTvWhOqB4Jly3sWaXVa4UGv0FDv3IDIFXfXiu2MSOS0sBUInlfe6O6Slf4kOf0nWfjOu5G7Kkbx1tbUuAbIrvGjfelKrJce8UzR/Ol19k6F+09oHGWX54VaBUybuo5x3gRKYjnOWNr6+rhcTHsnxHjAfnAJkiwsDhtnzBwjllPgihjFQ2FcJ5qRWsM6pjcfgVQymvEgEhOues2MO8x0a0b4gIM4Xnx4XLqTpix4wMTMqFIrcaVQ1p0YSLoFXU+sp/nrnlGcsr5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261102123227099003)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzMzVjFUalhGNmhBdVJVd252ZmhvbVRFa3QwVkhRMjBNVGdCNW9TN1lSQ3JL?=
 =?utf-8?B?a0htZE5XMWFidWtWdkdrbW9mV3dCM0VZMVFjUVB4L0dvdkYzZlFBQzZsWjk3?=
 =?utf-8?B?aEExYndxUmd5ZXU5ODRHQW1KOFNkM3NTcnpLMTFkZ2lJSVpuN2pGd2xVSHBT?=
 =?utf-8?B?WWFQOFVET2ZmWWNCMmhQWTZWbUFTVnhTdHZ2WFpuV0l0NUpTdHcxOHhSeUhM?=
 =?utf-8?B?bjVRYm1jclcwOURmcEtYTHNabnlpeEdKNncvSGhJYTB0dmlubFFrSDhVcXdm?=
 =?utf-8?B?SU01WGR5VGVjblkyMUx4SHBYZEpmb1hJcXJUcDNucm5SV25UYll0RjJuVkEz?=
 =?utf-8?B?UWpHYzhweFNJS1lYSy9ldktxaHRFOWszQUtiMEovdFF3SGJYVHVtV0F1YTRQ?=
 =?utf-8?B?WllNd3cyT1hRL2NXNnV2Mi9FejAwRU1pY21tU05pNUFTYkxtTUM3QmVGL2hB?=
 =?utf-8?B?dzZYQkVzamFJQWZTUmZyZ2lDTnJKbG4rNkJBMVdNcWJpcm92aXd6dncrMm9m?=
 =?utf-8?B?T3l5TThVRVRmYnJyVDFWRmhWNkM1Y3pYNW5Fc2sxOG84QlppWWtGRGVCMyta?=
 =?utf-8?B?YVVWREtkTFErOWxndnVLNEFGWWIvNGZtbjZwbi9XcG41RjBBZUxYVWtCc0ZP?=
 =?utf-8?B?VTE2a1FwOFEzVnNpQzA0OUJhcGRaRXRKWHg1UFd6ZHJvSklBdXlOeHQ4aksw?=
 =?utf-8?B?eUpzYWR4bW1XcmhnU2hlcEJwNHMvaGp6dXA0cWVUZ0ZWaFBVbkE1blBJbTdj?=
 =?utf-8?B?YytXSGpVVDVjRWxHaDd2U09kL1k0eHduOFpaNDdHOHFiSVYwQkRKN0lLRFBG?=
 =?utf-8?B?czZPLzcrQVdIbTREWGlOZHZ6M0I3Q0FlRld1WVNvVWFEb2RKdEJCZFJGSVNK?=
 =?utf-8?B?U0dvUkVYTG9JZFNjbUtSRHRaYlJrb3NSdjNjcldJUitVMHcxYTEzcURLYTNH?=
 =?utf-8?B?bkJCeFhmb1VvNFE2eWhkQzlrZGV1Qnh2MWUvc2hLTVVTUDRHVUw0TFBySmVM?=
 =?utf-8?B?b0VHd3J1RXNsbzhBaHR3SUFLZlhYZTZtd1JJOVdPNGNVbUdZRXlkTzFIUnhK?=
 =?utf-8?B?VWRHbkdZVm5UQXJQZ016anRWUzYwQUdFZEI1WFNrYjF5UnBtV0hsSW5VejhM?=
 =?utf-8?B?ZTZtc2Z3Q3BpQUl6WGFWU2FTTVd5L0pHQzFoajl1R2dZSHlwQmpxYjBNTjFV?=
 =?utf-8?B?STl6ZVVRNWsxK3l3cll5WHZKME9aTjhhajhsM2RUUENrVnVlLzM0VVAwbEhG?=
 =?utf-8?B?TkMwUDV3akRURmFkcGxkWlpBSDI1czZYVldJMGswZmhmUm16UXRRM3hqTGY5?=
 =?utf-8?B?bE5kNXNVYXhSYUdRcEIwdGdkalE5aFpqZTdDWm9Lc2w5MllvTnQzZndCa1JY?=
 =?utf-8?B?OGt1S2twUTI1MHViSGRmS0E2enlaaEwrbEtiblNmaE91Y2RyRnRtRmZvSmQw?=
 =?utf-8?B?ZzlYQ043TFVXOVlDMUZVZUJZR2E3YzgrQlNFdjhwU0Vyakl5bVFqSjRVMXZo?=
 =?utf-8?B?MzRHc2hjUzd5dS8zY3BKYzdaTlUzczVBTW9GcDJkeExpaXI3TkNFb1dBaElH?=
 =?utf-8?B?VklwQ3FBMDVSUVAwd1JLczYzUHpEL0JpR1VtTTRoY2MrQzM3MDZ3TTgvRHJE?=
 =?utf-8?B?YTB0NDVuaDloeWZlU3MrNHJRYTdVcklBK3Y0MGJubjVRWnN1RUxPU0MzdGVm?=
 =?utf-8?B?cGNObkN4MnFjazYwZ2V3cFRmWmlGQmsvczZVaGViQVVDYWJ2b0hOWkxJNUFu?=
 =?utf-8?B?WnB1Rks0b2dDUDZzTHpwTmNiYlM5Z3E2MEtBYlBjdHVpdDVXazRnd2xOcml2?=
 =?utf-8?B?enlQYmt5bmd0L0ZIZXZvYU9CZ3NCaS9lSkFWSmdybWJZTlVleGtxclpxY3BY?=
 =?utf-8?B?UUQ5cE5ubktlVTNYZlB6UFJBZnFZb1hiNGpYbEZoUzFqUWNBcS8rcndHWXI2?=
 =?utf-8?B?Y3hkdmpQTWZOU0Q4a3ozbmVjb2FjNGRObGI2V1J3T1hTREpUdkl6OTNBT1F3?=
 =?utf-8?B?azFWZWdSSU9YTXJTcXRBQTR5aGkvSy9Wd2pPQnR1Z1F3Mzk3cjRrUmVQUUJk?=
 =?utf-8?B?NTlLd3lzallvYmxmeE5GWGtHUldpU2NIUDJDWTBWZmxvV1B6UlFKMWxJZzlC?=
 =?utf-8?B?U2RNTXEzZE1meUljY2dBclAxT3N4Q2NOTE1YOVcrSHZZWnRnd0pXbGpPVlI2?=
 =?utf-8?B?eHM1M3FqSDExd1E2Q29ESURqbjg3a280MWZDeGo0WUU2QXZtZkFnYmIxNjFE?=
 =?utf-8?B?OG82Y2pTTVJhNEpHVHlwdS9zZURJWTl1enBwOUI4c3Y2eDVjalkyTU54L1Zr?=
 =?utf-8?B?Y0xSdkg1R00zcXIzMTVEb0NBS1p1RmswS3A3YzA2RzRNMGdTZFF5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15d957a-46be-4839-ea23-08df3a565f0c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:31:14.7487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3PkqeYsodBBcSobdcqKEgA59Eznedvv9EisZVQSuUlMtM9Q3+Lij1QHwRnJ37Sc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB390589
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/26 19:43, Graeme Smecher wrote:
> eth_phy_of_to_plat() claims the PHY reset GPIO with
> gpio_request_by_name() and the PHY reset control with
> reset_get_by_index(), but nothing releases either when the device is
> removed. When retrying a wedged PHY, any follow-up probes fail because
> the reset GPIO is already claimed.
> 
> Add a pre_remove hook that frees both.
> 
> Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
> ---
>   drivers/net/eth-phy-uclass.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/eth-phy-uclass.c b/drivers/net/eth-phy-uclass.c
> index a13e2fc7c50a239bdea4aaeb6d77496cc86b3575..7ac1876f846abbddd23117db235a535eb96d234b 100644
> --- a/drivers/net/eth-phy-uclass.c
> +++ b/drivers/net/eth-phy-uclass.c
> @@ -191,11 +191,25 @@ static int eth_phy_pre_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int eth_phy_pre_remove(struct udevice *dev)
> +{
> +	struct eth_phy_device_priv *uc_priv = dev_get_uclass_priv(dev);
> +
> +	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&uc_priv->reset_gpio))
> +		dm_gpio_free(dev, &uc_priv->reset_gpio);
> +
> +	if (CONFIG_IS_ENABLED(DM_RESET) && reset_valid(&uc_priv->reset_ctrl))
> +		reset_free(&uc_priv->reset_ctrl);
> +
> +	return 0;
> +}
> +
>   UCLASS_DRIVER(eth_phy_generic) = {
>   	.id		= UCLASS_ETH_PHY,
>   	.name		= "eth_phy_generic",
>   	.per_device_auto	= sizeof(struct eth_phy_device_priv),
>   	.pre_probe	= eth_phy_pre_probe,
> +	.pre_remove	= eth_phy_pre_remove,
>   };
>   
>   U_BOOT_DRIVER(eth_phy_generic_drv) = {
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Jerome: This should go via your tree but if you are fine I can take it through 
my tree. If I don't get answer from Jerome, Graeme please remove it from this 
series. I will take 1-3 via my tree and 4 should go via Jerome's.

Thanks,
Michal

