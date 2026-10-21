Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94693606A323
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=plgY7n+r;
	dkim=temperror header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=we8nrlXh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C3FE607A2;
	Wed, 21 Oct 2026 02:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BU4bRnVRuPMj; Wed, 21 Oct 2026 02:31:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EAFAB60763
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792549898;
	b=VnoKl4HXq191ZWOK7ZMidO2qCh4Ti+OVjDWbvCrwFjBS2+5DuqC+K1KLz3eQSQv4zK/K
	 z2ZnYqpFpF4CVL7YND1FSLeBDMFFSlE4d+ymI5KCPkhA5p+bNc35ICZXQ/0hErD4QTpbO
	 SFRBoUu7Vi9787rrI1G0TuJkUGg5NwnFinvZ1QPMHDTiit0ctFwgZ1RzKmP+9AgPeiPT0
	 Sp06/biz+KNimkZAKilQ0hVW7eD1FcfRLVhP7TGiwHUaspO6J6WpSbhnvkEUPf4xsqcWZ
	 +SQyd1+xEazNQ0/zfvJJTZSwsxPbRvcLY0I4ACDq+99qMjrQQWq7VmaRSKfeQNHPrjw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549898;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=brHGn1tcBoqvduviyx0ArZ2pQmJqS0D63Aai0LkyRL4=;
	b=piURnS0DHY8027rN6c0JfI9UKf3JBWumN0IhyDasthhFGbwvNQWxGllrrAUC4GeCANEA
	 ssgz6IQrvtSfLLixe1LKuGFR/ScSqfbtQwnwqAwiwxigTWmrG3OeAIen+gG/GQBeOSKHg
	 d1YA/sXaGErfF8QIgAvx7yBCo/rtahGRC1X/0wAVsdzut5z8tVF92RsEilX4M7bkXyOBM
	 EvKgrQ7lqNgI50kKdXwcrKaT3hHH9CocJ9wC1bylVn6DSPCSbrGk261u6yk9jU+4F8eOG
	 60vmrdB/B0M6UYcl0c82O2lQJAHWslk2ClCwCYq7QCIP27fJb396jZuoFxKVvD6KHoQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549898;
	bh=brHGn1tcBoqvduviyx0ArZ2pQmJqS0D63Aai0LkyRL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=plgY7n+rCSxwn0VTRW8xWAqX4Xh3FYfeTmm7jNuYLP/HZ+TnPtoqKKZpPTtPo/HZK
	 6jxUtlrOnVwbqrpcSDz2+1PZC6qCogJEKBsGazygLc7bdc3RW29xXOg0Cf4sX41cgZ
	 isuRGGc9HJKunnQ1GOfVbzyeYx33Fho4D6NJTn7Bl5coUGX2BkWal5AILGtR/T/sYq
	 va0akTErgzurNn7lbaOPnLE8QhCD8ICtW0kB2IIGZGDZwxyG9w7/VK0PU9l6UGPq5M
	 uaWreVManAc4kQZCD+yxj4MdQ0fYaYlYOxdi1/WOjA7x0KMWIfUZZZPkyUgc4rYHz7
	 9TD5XBol9Rm/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAFAB60763;
	Wed, 21 Oct 2026 02:31:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 27D383A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0DCE2405B6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uEj22WcaNxMB for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DDAF24059B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549894;
 b=RZc8eIf/CYdMokow+npxCMhVKLSdFTEDPO1zSoH90ApjpyMGo0PH3I4zFP3uALTIW+oB
 loDGteDg/oUgcrKCsA3K2gSsRSBCzGT64wSXy+4DjW7VvI39e698CPR8QegPBRZ2B6zRA
 08FG0NtSfCgbW59obvD5onf5hVJcb1FihXdRA+02JHVRBMfOokVapaALXRsDrifzGN0It
 bylFU5x5fBgo8lq4J8EjKNFWxDvvn3skOlI3sDOGPwG4zi3WK2+ZJFy/UwEBP4IPOwr00
 xCR7GpJPdCgvbIpp4FWafknLlcGuj4tj8cvvlwxQVAeMq5mENtlO7Ii1381t34H2Bbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549894;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=brHGn1tcBoqvduviyx0ArZ2pQmJqS0D63Aai0LkyRL4=;
 b=A0H2tP9Jm+LENldTgOdvLW7mjPO1wQTLDw9dbezBPH/fAoD2G5qgCh16zIp1LPn2mJLO
 4geuOaNdAQlkhlt/cy4yRyLx0uIxgT+mMvJ3j4GxFRqH9OVp2cbtbaLrkyJVLbHPZ+8jH
 iHTbLif6GY88oqusIcAKbA/GTnSdGXSvUwWDqV/+K5p6dXc57yM9R94tK+qik2j5qRLB+
 /uWt8JAI78dxor/Bcmy8p2YGmgIkCmsb/FoQDQHmZTDAoB/tfDWuIchXRvBNu9YDlzYkK
 Fd/CHmXg8+IInk3sG4tlSPymx9ZsohyuWZVhl3iTe4almZIBjL6LjiWdVRKjb0dRMjg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=we8nrlXh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=we8nrlXh
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDAF24059B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:31:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69F86844F6; Wed, 21 Oct 2026 04:31:30 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 446D48056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCr8/s6x/j956wrUGl+81u5O6ARAe6d9Q7t1dBj8KpAvoeho0mXad8W2sUmpHeI+ZIGImCwVOFmXIfXhsodHRLvceHWSbTFxZiZyRwCyv8vwyE5nSpMvp/CCMnCLHnQEB/Fsgy3VwUmyr94OcEe9aLVe3DrLZlpX+yHL+bPwzSCWRLKibXlz2YZ3gaIdpLD/k24qAWtykJnw6A+mxOG+etfUz0Oze8ab9M5Ypxr9YXX2LJOM6ddJrx6Chvm08RlTBnE/qLHo+WVfkFBfe0u4peX8npQ1DBSsP6rU5YTbJMpx6e2fwIMnycmkcXQBpAPkHfIq9KsLn17Lq0BMrHhkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brHGn1tcBoqvduviyx0ArZ2pQmJqS0D63Aai0LkyRL4=;
 b=Bgc10el1bdmubykFHmxW+a8PaTcwbsdnnuLG9supFZCdmGl7yFHzzdx7mCJOzz9laoNbWMy3a6+8sw0BqYI4qTm0eXz+Zc+wvh9GTikRNBPPjwzWVGvQ3nwf26dbDqKrT37kBWT5SC5slT+ahm3bfZzqaj6xtCdg9e6gGScwrcY1z9U8r+kSTIuQex/ZU32fPbvioNfRmIIo95jSUtgdEu8TFnk1fj9Wyolj3gvLPQlAq6TYSM5gyK7h3yVMZuWCrid1tbAXrOiKuu/fsRNPekXOlF+Jbg3d6QMj+n0ETuj6jVJPys+MP354Z2Nv4UWERfyjcCBXWJNGqLZVSRfuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brHGn1tcBoqvduviyx0ArZ2pQmJqS0D63Aai0LkyRL4=;
 b=we8nrlXhN3d1blJvtJXBmThJqpccFyhoXML3woXU3vuddpBs9bRx9dDCrwrYrr1fl+jmO1V1TTBIYJg8Ax0KxR5oAa4DcMa0qeDEQxdpY85tdaQlvK8txso5++7mX/lSwg/YA5hDB+wlLkNqT3IUu+XSEFr3kEldMW/j+tAjs6c4OxQHusLR0a2YhBGB2pH50jhnIrFK1l6CoQblEmBbGeVHPkxx8KAbpfcIwZUTtgtZgZBiWf/63zSSR8KCgW/S9do4QtI413uiavoUXNwhilnz+GpiUV7HiLXEbwWThWScaDOY4za2lkRvGZ2eKwKYDeifwUTFWMhEy+jOr0AC3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by IA5PR03MB989654.namprd03.prod.outlook.com
 (2603:10b6:208:608::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:31:21 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:31:21 +0000
Message-ID: <639a8f75-7d8d-4d56-b804-e3524f169695@altera.com>
Date: Wed, 21 Oct 2026 10:31:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] ddr: altera: n5x: Replay PIE handoff on DDR
 retention restore
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-16-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-16-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::13) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|IA5PR03MB989654:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7b7755-143a-42df-76c1-08df2f1b64a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info: OdNY7gzLnqbGUx6s+8FadkJaOTHOqZeLLdd73eYo2eFpDBPbwImy3BE/SEg+g8VSFAg8JjDjljXIZjFv+ko39wrROXhzEGLv5rWeu/XXZIlK8HVTvaq9P10udDjp6IMCxA2sFHSM5NFyqPDl8rOdomyY0pZrB7DWMMCnugZtpmhFUOxLUeLNGPmnyou2RTGGSVeXRVgSasXI0+TSxvA7p0AE7WMCbvuXmEJAYpo6mcu8PC/mgcjnocSy+osCHEyG6Dy7D2KQoaN1zO7bWF5tqaVUu8mkWEy5Ksf5EGzcPnDYlt++wPSGe6stU2hPNdKxo9E7Qm66IJoELreLi1Q2//v97C5r/APl7NabsujIiLPlRB3KPHFsEWev8p4Tr5tzdZE5yC1w0qI6B+WRLtDJxjJNtvaootBLNpA4h/u2wWvxs3Cz25Ba+TVfP8J7iMuCZKOvtF++LijlSW3xIJmGj9JMHi7SapUFsRMUXr94a2bzSPosfJLebvv2QR8tlb7wOeVqiArhv2f6tbIRmJLGk3rJSKQi4bBe9xJFoURpxyjhUUjOPNIBc5Y7Ic3No795SPDQAA4sjb9eOTvb2btrXfyOhlRXSR8Xy+Izz5NDAnzFH5hdpDHOFiMR706OWYK9EPdlt8xNYqa8PfuRS9h+izRwGfyWFG7lcC7RTTdaAVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3doRGZxSFB0WmYvOS9ENENBZityVmdyM29iSjVnczRqc2s0bUJzYlJZMmR3?=
 =?utf-8?B?eTl5UHk0eUpWQUZXaGFaZGdiN2I3eFl4Ly9IbFRTM1RDdExCUG9vbEtWL1FH?=
 =?utf-8?B?VXhldy8vaU90R25aWmFoOXFId1VuQWI4aklNUUVlWWJUZlBEM3RkUEJUeUk5?=
 =?utf-8?B?OHlxUEtrOG12R1ZPUlp2UTdjWlc3dldtU0ZKVTE0Wi9SdlNCMWl4NnFpSXpq?=
 =?utf-8?B?d1ZJaDA0OXBtZFVma25aYXJDdWRRQmV2cE5TMVVhSytzL00zb1haVGYwRElu?=
 =?utf-8?B?cDR4WHdmRkRVa0dRKy9xcTd1RDdqc0tXK0tvU1dFU3VzVHpzNEZvbHo1SzlC?=
 =?utf-8?B?SFROa2dwallBWFl0YkpreFA4VVRPUXExVURCcXBWblptdkw5RjMwMS9sRktr?=
 =?utf-8?B?TjNZQ0JUcTNhdHU5Y05QaWZHTkd5RUJLZzY2OUtJY0VlZnFkM2RKR05Kem9Q?=
 =?utf-8?B?ZGsxczBKNVFJVVJYTEhtKy9Dc2NsOUpsaU53NVk5c3BmYmNIR0dvcmdDOXNI?=
 =?utf-8?B?SHhObndrYkQ0NGFjN0Ywc0pjVWplUHJvTnZhcTcrMDJFelc1R2ZocTRtN3Ex?=
 =?utf-8?B?V2VRSFV5U2NSVEFrMXVNWVdrMU85WTVnY1RiVDU4aWdJYmVXNFBoU3E3ZUVO?=
 =?utf-8?B?MWZBNGQ3OG5Ic0ZLQThQVFJYREVBTE4vUWZvcGRSOGYrUGlFdEdqTUswd2Jl?=
 =?utf-8?B?RkR4bU5xYWFqd1h2S3B0NSs0NkRxNDZIeWltcjNDYjdwRHZpOWc3UnBnNEVP?=
 =?utf-8?B?VG9wYi85cS84OEJpMVZEcFVoTGliL0xLSzhpZXZVaTJ4dmNhMDRZbzJNOWcy?=
 =?utf-8?B?MGMvUEdMcUF5bEFLWS9rcWt6alE4UW1IUXpITkRYRHYyVHMzN2s4UzlrcHg3?=
 =?utf-8?B?Y2srL3FOa2ZnTklaZ0d2L2FtS0x4Ym9VcEVmTVVsZzF6MkJ4U2FVVXRXdzI3?=
 =?utf-8?B?dE5ENnpweTZSQmJJTnVPd1FQandaQTFwS01MMGl0TG1GbzdtcXpscU5xUW1V?=
 =?utf-8?B?NklMbFNxSk9XaHNydmthS3p1SGlUbzVVWElMWDlOZGMzaUw5bklQWWlXcXlx?=
 =?utf-8?B?RktxQ0hnY0UwNDY5TUF5ZjlQMXA0Q3h1MFVLRmlQY0s5OUhhbHhqb0EvSVo1?=
 =?utf-8?B?TDBkVEdRSm1JV1JYaXlTSm5rTHptb0dsS3N5V0hJdVNLQkpVLy9uUEZqRC9E?=
 =?utf-8?B?VWd2WGVVdWppZnJHaHAvd3g5enF5U3A4UVpGbmhUUHArWkM0UEJqcUZ1d3VE?=
 =?utf-8?B?RFc3SXZ3QXI0Q3B5ajl6NnJQdjU5MGlxT0lja1l2M3hUS2pBMWRvYXNmbTBq?=
 =?utf-8?B?WnkvbWNacWs3TjB3L3pKQXljQ3V4R1pOMC9RNDFnQ0Uxb2lHQUowUENoSW1h?=
 =?utf-8?B?WDR3VTdKNm5LaUladlVOU1BnYmNWcjBWTG1WRHljZ09ONktGL2pqb3V3REc5?=
 =?utf-8?B?VUlIZVg4VGRhSUJGNDk5QUJ2cWZySWVaZ2NzZUR6WnZickpEMjlxSi9vQkZh?=
 =?utf-8?B?cjVIRGV1UldZRWVNT09oWE5NM29IZSswajNvR0R2ZStHMDFMeDZnN00rOHlp?=
 =?utf-8?B?TjdWNVB5d2JmUzFqcythZFRUeXVnZ3FHOTEwM2hCN080R1JaV1R6YnIvTXpx?=
 =?utf-8?B?dy80RE5EV1hCUmNEM1FRbElmUU16d0lyQ29JYkdQUkZPSEFQTDAzV0laN1Zi?=
 =?utf-8?B?bE5EUkdFN1NxcGVoTnorU3V1UG54ZUFMOStTd0htYjVqSGhvSG5TZHdEejNQ?=
 =?utf-8?B?Q0RLQlFVSlUrT0crMHFGbnVkODNWaHcwdlh4NFF6RkRKUVNVWkRxTmZXc3Br?=
 =?utf-8?B?RVdOamhnN0Z0SndpUWMyZC9JNkFvY0ZQMUl1elVNeFhZcFE5Qk93TW10WGN0?=
 =?utf-8?B?bjBvWkRuOUNvL3F6OTI1Umw0MFhpSytlZ0dkLzdsY2RzbUw2dHZQUXJSM0pS?=
 =?utf-8?B?R2hWSEJ5dHBVcWVlOUdIa2QrOWxPMFRJVzJFL3RmNTVUaDVIOHYxZ2JRZkZQ?=
 =?utf-8?B?ZDBseFFQRHpzaVlYbklTRWZQSkpGUGc0Mm94QVp3WHRpc2JZT0c1b0poSEpr?=
 =?utf-8?B?QUhNRFgxaGtjSHFCMHhVMTlabVpPbzg4d3hCQ2duMDdYUHBjMUxoMGM2ZzNK?=
 =?utf-8?B?TlNkNG96cnluTkgwbjNLeEdYaWh2S2x5cHFhdjZweEhjV0I3ZkVzdkhGMWd4?=
 =?utf-8?B?UWM0ajlGWVlxWjZTL3NzYzQwWEhNaFNBTjJSY0c0aDZhc0liTXdyR3JxSW54?=
 =?utf-8?B?ZThCNUJWNzkrc0kwWnZ3eUhPODdTbEgxTmtwSHZHdFFUZjZRMENEeXNBZ3h4?=
 =?utf-8?B?aUNqTXBJOU5kWG9mazJSQlZpSldIWXB3cnpzRTNScVJaSlVtckphZVF2QmVM?=
 =?utf-8?Q?txEeMqqDMqV1Wf3Q=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7b7755-143a-42df-76c1-08df2f1b64a6
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:31:21.1750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqTZWOVmVA7VnQ61f1YSZsgH/AVyZzxDCXF73PoMtHzEzTz42YrmqOY8yflHtQkK4QytK3kpFC0EulH75IF18Y/RO8wIJE/urrX7pvt/5ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR03MB989654
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 12:40 pm, Chen Huei Lok wrote:
> On the DDR retention restore path the trained PHY results are reloaded
> from the calibration backup by cal_data_ocram() in init_phy(), which
> leaves the PHY microcontroller stalled. Running update_training_result()
> there reads back results from a PHY that was never freshly trained and
> fails the DFI handshake, so DRAM init returns -ENODEV.
>
> Instead, bring the PHY microcontroller out of reset/stall and replay the
> PHY Init Engine handoff to return the PHY to normal operating mode.
>
> The PIE handoff table shares memory with the memclk hash scratch area
> (DDR_HANDOFF_IMG_ADDR + DDR_HANDOFF_IMG_LEN - SZ_512) used by
> is_ddrconfig_hash_match(). Snapshot and restore those bytes around the
> hash computation so the replayed PIE table is not corrupted.
>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   drivers/ddr/altera/sdram_n5x.c | 48 +++++++++++++++++++++++++++++-----
>   1 file changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index 11aa020d380..fd90a895a80 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -1495,6 +1495,9 @@ static bool is_ddrconfig_hash_match(const void *buffer)
>   	u8 hash[SHA384_SUM_LEN];
>   	u32 memclk_table[4];
>   	u32 size = ARRAY_SIZE(memclk_table);
> +	u8 *memclk_hash_dst = (u8 *)(DDR_HANDOFF_IMG_ADDR +
> +				     DDR_HANDOFF_IMG_LEN - SZ_512);
> +	u8 saved_handoff[SHA384_SUM_LEN];
>   
>   	/* Magic symbol in first 4 bytes of header */
>   	struct cal_header_t *header = (struct cal_header_t *)buffer;
> @@ -1511,14 +1514,26 @@ static bool is_ddrconfig_hash_match(const void *buffer)
>   		return false;
>   	}
>   
> +	/*
> +	 * The memclk hash is written into the tail of the hashed handoff image
> +	 * (DDR_HANDOFF_IMG_ADDR + DDR_HANDOFF_IMG_LEN - SZ_512) so that the
> +	 * whole-image hash covers it. That location overlaps the PHY init
> +	 * engine handoff table that phy_init_engine() replays on the retention
> +	 * restore path, so snapshot the original handoff bytes and restore them
> +	 * once the hash has been computed.
> +	 */
> +	memcpy(saved_handoff, memclk_hash_dst, SHA384_SUM_LEN);
> +
>   	sha384_csum_wd((u8 *)memclk_table, (4 * sizeof(u32)),
> -		       (u8 *)DDR_HANDOFF_IMG_ADDR + DDR_HANDOFF_IMG_LEN - SZ_512,
> -		       CHUNKSZ_PER_WD_RESET);
> +		       memclk_hash_dst, CHUNKSZ_PER_WD_RESET);
>   
>   	/* Generate HASH384 from the image */
>   	sha384_csum_wd((u8 *)DDR_HANDOFF_IMG_ADDR, DDR_HANDOFF_IMG_LEN,
>   		       hash, CHUNKSZ_PER_WD_RESET);
>   
> +	/* Restore the handoff bytes clobbered by the memclk hash above */
> +	memcpy(memclk_hash_dst, saved_handoff, SHA384_SUM_LEN);
> +
>   	ret = memcmp((void *)hash, (const void *)header->ddrconfig_hash,
>   		     SHA384_SUM_LEN);
>   	if (ret) {
> @@ -2961,10 +2976,31 @@ int sdram_mmr_init_full(struct udevice *dev)
>   			}
>   
>   		} else {
> -			/* Updating training result to DDR controller */
> -			ret = update_training_result(&ddr_handoff_info);
> -			if (ret)
> -				return ret;
> +			/*
> +			 * Retention restore path: the trained results were
> +			 * already reloaded into the PHY by cal_data_ocram()
> +			 * (LOADING) in init_phy(), so update_training_result()
> +			 * must not run here (it would read back results from a
> +			 * PHY that was never freshly trained and fail the DFI
> +			 * handshake). Bring the PHY microcontroller out of
> +			 * reset/stall, then replay the PIE handoff to return the
> +			 * PHY to normal operating mode.
> +			 */
> +			clrbits_le16(ddr_handoff_info.phy_base +
> +				     DDR_PHY_APBONLY0_OFFSET,
> +				     DDR_PHY_MICROCONTMUXSEL);
> +			setbits_le16(ddr_handoff_info.phy_base +
> +				     DDR_PHY_MICRORESET_OFFSET,
> +				     DDR_PHY_MICRORESET_RESET |
> +				     DDR_PHY_MICRORESET_STALL);
> +			clrbits_le16(ddr_handoff_info.phy_base +
> +				     DDR_PHY_MICRORESET_OFFSET,
> +				     DDR_PHY_MICRORESET_RESET);
> +			setbits_le16(ddr_handoff_info.phy_base +
> +				     DDR_PHY_APBONLY0_OFFSET,
> +				     DDR_PHY_MICROCONTMUXSEL);
> +
> +			phy_init_engine(&ddr_handoff_info);
>   		}
>   
>   		/*


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

