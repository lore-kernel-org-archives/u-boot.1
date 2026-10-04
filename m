Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DF9CA5FCE
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 09:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7361360615;
	Sun,  4 Oct 2026 09:28:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1uEZNKE_LE7r; Sun,  4 Oct 2026 09:28:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B36E56060D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791106098;
	b=KsZYdYPLkoM0T2C5VOgPek1UnJdzCQj45yzDmL1nxUnVofyFzPnOwcTD4INRby1K1CQV
	 RPI/PFJrndpzGebXt/rn86tawlJDASnrkZB77Ybo0/Oew76WjdGFcw5jrtuZDvFXYqaig
	 J2Mo2NH0iECEVDHAGwIwBMJEruCXD8G0fs7QnwFDZDqIcA4/xLmlO6Sehzz3Aa97b98uJ
	 OKI0Hxmmvu6HpP3MWsUt2FF7ezcAP9SYYe8fuErq3oC0YYWl5nQN8uskaVb95VgX50rgm
	 oyFjdsMMGk+x9JVXmltBkQ3HZdVWXrckSXjIAAfbwkjrJmikskQly+ThsZtmvnLzRQQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791106098;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qt7dto2Y4dSuO6XvGAMLc7TlrNwso99VuB0RQXAATDE=;
	b=s5Dt//w2xbZu/J1AOdu3MJ7P1PBVlC4sfvAw7k8XWmQU6YSfheKggUtdXoHpS5z8IREX
	 gmR6v4NwvvFc0Bu3kfMa9FE179MNrju1/mlMa7CxUue41icTArKwoJI7XsqEX9th7bNCl
	 jYJ4kYTztshyaEPyQ1JAb1z/Crq5epsSZnN8Cbdz4RaMSSlsPTgGGkCyLcBPmFzRDJHwj
	 WmIHhCl9usl4cgoqndyN0begSTj+I2DCmNbRJzSA7a7ZJ0YI0GGY3/kLArSNQuYXaxXMi
	 m0mA1LOmoycf1ggyUxfIVRpO7SU1h3hHuNB6Y7f+XwluYA5IMX34hPGJzmqgrTCOoiw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b="AVeade/w";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791106098;
	bh=qt7dto2Y4dSuO6XvGAMLc7TlrNwso99VuB0RQXAATDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dOHSTiiorfY3ROQrqGwQmc9RTxBgt7IYQUuPtnX23KLm6UeOSSYci8xJKVXTkJYu1
	 sdFrUk8NpzvABYZk2F+4K6z21yXlVImn5HpC8lUYZtbnm4LqNCcLQjU0+cA7QjcPhr
	 hQR3B20y/2rSxknK+UgG7ZL2VFkoxZ4XwYx9NYfuKujPcNZdMZdnVjUEhDk6PfK8lM
	 orVR0SZh3ZLNwt/dpEpKcMw7Bm+eyfJkVId1fGShBxS12GtvxACgCCzVtliL1H0XBD
	 snsMJNTo8eBJ6AK0kDxiBvwR0nE4eB9e8OdRCoqpZYxhxUG9OEF4m06/T7zN+KdVfD
	 mKHiV49GozvcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B36E56060D;
	Sun,  4 Oct 2026 09:28:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B9395263
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AAF2660613
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:28:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sc9Ts6KpAA38 for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 09:28:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BF6B2605C7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791106095;
 b=AL/EbH6AHlWLOWsPYEXbr41K8lG4oYnmlq8GVtajpbfc9rQZqE7Hhpr58l/qY1wV8aw0
 woKkCo+NsXVwpHRaF0aG1BWhfhvpdZrAemVfuGcEMjcPyMfgEvtRhc6qAvom7q0CxTKFD
 rZ0vHXfY/b3eBf8oQt2w+AyD12Sib6mnKc8PmFXyo+NQGZfVb2uOv+RpV7tUbIuoFuD7r
 9QCpXrfkb9WRYXO+pQfUPkz6gnhe7gKhZ0qlE5KURyczAY/jFAPweIeKExxUf3morqKtF
 JBnMcJqiPar3x2yP3Olq+DcWz5uxYiXZecMJFiyHHUUAazYbKu7CXJZCDOz3XMm8H/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791106095;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=qt7dto2Y4dSuO6XvGAMLc7TlrNwso99VuB0RQXAATDE=;
 b=pfDuMqcOGs9I3PxCcFj9D6SCD9xAfPQ7Ytp5cnYAUtEcqct28Ka4TtQ8J5fyhZ8RMJjZ
 HmSzdc4eeZ4BR0Zx/Ea54nVoVQG5uBwxaJY2/8D3hvnhx08UxyVMFYy9P76nA0hMeCtb/
 6Wllm+6lC4Dxf+64pa5yG6om9y7g0qKOdSxnu98/HKmQtZg6BDzgicZSMyHOm/elJv65A
 58kgPzQ8iXg/biCJ5Z+eA7VXBFNEPSId5GPpba8JgyAYCR8ZDRXBfnkIawO9/VWGhTk+I
 FmlqVdaJzoGd6x56OagMs559A79PjlbZGBfryXjlXwVSc+SioATeNm7NFcnRk4Hx0sw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b="AVeade/w"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=AVeade/w
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF6B2605C7
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gci/N+f5X1tcv+WH29KzdKh499P/W8zcH2vQA6WLmcDRvzZrcPb8jKsnbgWOEVP5hUUy7ezgJmun0tJpybluz9j0PPPnQWfXCSkqb3tAw/NRRKmr6vjCKNBi2Nv0DH4aJ93U3e9BmsrsHv0J/fulSBXg/E4WTrH13G6IRAHdzIQswItqcwiIHxgVvjHH+EbKjpvnKzw6cyAXhO1CLNRlnqspV4oBI40s5czhT+KPwx+WC9lnoJ4MWj0d807UKDI3kkD6Iac9sIhaU0JKROxSHVzn4L/ZfXorKkNlArOVO2WgT0TtMYsYXnuqPzQn4D0ZtOpWvgBYEGgEg8uqq8+ELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qt7dto2Y4dSuO6XvGAMLc7TlrNwso99VuB0RQXAATDE=;
 b=HBvaTr1vQFTUVvYw17H4h3C5kRsHNjOM6Q5Hrfy+v2gQpJHkWpN7Ql67Ok0ZWTpiWMgbB3S2AkdJQ4ojzjE/uFNfjsIWG6BrfM+q4pdA/AJljBIvg+qpLElBBXIGJEdHwi9nWPDOqLvyI3jtCGppJIIx+hb/0kGE1oHjOhaBF7EOOnVUBGjD1auON5UXv2m7i98ZO858v/cuuhJtEDgrepf2Hf8jN1qzWgCFdYT7E+DSRHOy4Q/ypzMYSgrXzKmcjGJoNKhVnNeCSV1+sWrarbIFowT2eqDovs0QcqTKurEroVcqrSQC0eoDgepJWf33AQY8V+8QzA8LMzWbMtOOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qt7dto2Y4dSuO6XvGAMLc7TlrNwso99VuB0RQXAATDE=;
 b=AVeade/wSuua6zei/9zLdnutffEEq/ssfK2miAPr8YJZAdK+RgKflCQihNyrcJOXDZ3zq+yDCDfaG5Qo3zqZIJysYLlOUTiQcZWSFIVCpGPLNTbAiZPjuNShzypdnF+0xXRso1GaL9nnhHac6et5YA8WbKBZKjieN41Y0tHHHNS4RUom8pZTolIeC6k+FfDAgckAUfNMxSucxt4QLm4f0bnRXUQ+uu7g4eWJ6POXbo9JL/58z3JyX6jOAy1Hsqlnx7lJiOkvoMIYEEobhInjPd9HKC5rIoWKSjoRFMr0PMQnXZNnu5t935dvFeAdUu3rp4JWQVZ4Skr3lkpRa7sthQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21)
 by SA1PR03MB6513.namprd03.prod.outlook.com (2603:10b6:806:1c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:28:10 +0000
Received: from BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4]) by BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4%4]) with mapi id 15.21.0472.015; Sun, 4 Oct 2026
 09:28:09 +0000
Message-ID: <45368170-7735-49c5-b0f6-5ae3583703c8@altera.com>
Date: Sun, 4 Oct 2026 14:58:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: Dave Klotz <DaveWK225@protonmail.com>, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <a93aa8e53d5ebf81a61be873d935c4e37cf5179c.1790975596.git.DaveWK225@protonmail.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <a93aa8e53d5ebf81a61be873d935c4e37cf5179c.1790975596.git.DaveWK225@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::7) To BL1PR03MB6199.namprd03.prod.outlook.com
 (2603:10b6:208:315::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6204:EE_|SA1PR03MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd9be06-3b6e-4d51-7f89-08df21f9cdd1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|55112099003|4143699003|56012099006|11063799006|10067099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 8r70HJ9aMDHD4yJKA1S5+PCPj8OTQIuFTuG/hPSPht63RtTy0bIxt4KzNVZvy5ErYwk52idJYvA74e4jUA47fS5Io3FwpdrOm0PEvTLj5k0PHRz1f/LTz8jE1uzGp8KHKLc7pApcaTN4NZwApBl2/X8W5OEhJQmBmXoMpwZrfhbmM5cIvJoJgcwFaL7gepubY2jdb0deMMVrqqf2B5KDL25/V3Dw07hwwwWmKuHEv83/dKX9MMhIxcctZQuNQeiOP1pfxGndNFUzwTeMitidoRQIcfbchs2WK3tT/iiqi4yKkI/uDQHa+g/Gq8fq/h6g3w+Q0RVFVV/xJq4Y5IfAAYbjx9OoIcyIpG8s3NCxcBChQB3sNDm9NkA4CEXZ3BQAVXjoGm8al+GFvbsmzdyrhuq9f49tjvN7YdBRDtR5XstjzXL/mbD/2lpgWxsbsqjjcFKOAA/1v74o6UwmVvirIp1toap3TOEMB0slmGGe3uR9PWQ6zsKYGoJTl8KwQ97MEVHbntiBTlE+Txj4yb5FnshmJQ62gMR7+YAp4neJF33KFKb9I0S3MhBiWHoVEyc/Qc4DlDjDkTrCpsQv2JA1wHv2ZIeTtyc7/n6C74yeZS2iJEiFvHK05xrTxQUU8e7Vu0e7NVNYtinBDkDtejw5oUr/mHdndMzqObJLJy/oxdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR03MB6204.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(55112099003)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0Q1dFVERTlORDVIM0s5KzlBMnFsaVRzUnRyMHI4ellxaDRua05vVjZMc1Qr?=
 =?utf-8?B?Wnhpcm9ObEFWQkx4YUtOMTVyVGo1WEZzejJLZW5PZlI1aG9ndEF5djVldDNn?=
 =?utf-8?B?MkM4TjVvZFlPd3hXK0RaTytNSGJUODlGZEt6OXRXbXhtNTRLakFKTE9Ha3BN?=
 =?utf-8?B?bDYvbms1WHlqODZ0Y0ZtaGRRd3RmY29tdnJxUlB0NGFyYVFsVG5NUHVZVkZs?=
 =?utf-8?B?TnRBdUVRK09qLzhsUWgwK01hcU1xWEdjR3YxOTZxWmN5NmY5R3VXc1kwZlRa?=
 =?utf-8?B?VmxFdVI0R1J4TFMyMXRVWVF3aGVrMkhNVmhDQTZDeXJ1YlY0L2pBaUVFZnU1?=
 =?utf-8?B?RVAySW5RaWF4V3JLc3Z6QXFXTEZ6c3hnODQvckg5OXYya25aZUkraVAvN29s?=
 =?utf-8?B?ek5Ec3U3YkJCSk5oblBJQW5ZT0dOR1o5M1dHa0xlY0lFeDh0a1FrUEw0SytS?=
 =?utf-8?B?QUYyQUc4ZmFSWFJ1Qnk5K1lhTkFzTitPSVBsR3lXbEVmL3BEaDNWcjduR21G?=
 =?utf-8?B?SjVMaFFUOUJBbTAyT0RTRDhQREN3b2FHUTJpcVdPUUJBdlRxVVUvUzJUK2pw?=
 =?utf-8?B?R1lUNDRwblIyTU5EZU0zMnVNalY3ajNFc2laQU0wTHhxZ0xaSHRMZ2NEQnU1?=
 =?utf-8?B?OUpmcjhiK0FaYTJZSHFMYk5RU01aUXF4QU1XQ3Z6NUoybWh2dzhmQ1NzQ0NV?=
 =?utf-8?B?ZkM3TFdFeXROSzR0bit0ZG1oVk52WVdXSGczbThldW82SXIyNXpUL0MxSmFa?=
 =?utf-8?B?eDFDdUZmWGlyeTY4Wlo4VHZjb1JBMEd4cmM1aHZibis0TjhQcjhnVDZhOGRG?=
 =?utf-8?B?Si9oa0RvV1ZiNjlKUSsrNnZXOVI1Vjcray8vY2U4UWJTQ2xUa2dxSm1BTURI?=
 =?utf-8?B?dzBjTGJnWEVMYzg0ZENIdExpVFlSU3J3aWdmRXZzQU1MZ05KbGk2Y1lIVDAw?=
 =?utf-8?B?Ry9VblR0M2l3NXpDZDNLSlVlTmJzNDA0NWNNZWtkWVdJNkZBRFQvRnFCVUV4?=
 =?utf-8?B?Y3dERnAxckN5bVU0clRPMnRxdWYwY01tVkRHWkJETnlpNzcxZzA1UlBvcVQx?=
 =?utf-8?B?aFRjSkt1QWt4Q2pjOHVRYmx4SS9KNXpLd3pZdzR4T2RyTDZHbXYxekR3QTNL?=
 =?utf-8?B?RGZ2NjhmYnByaFp4VWlpaUNXOTA1ZDFwbk5IZEdXdmdFczRONDRnUGlrZGdT?=
 =?utf-8?B?eFV4bDFLa1pEMWd5TjRjOEkva0VyR2lPOHE3Rkg0SGJmWnM1MUpDVEJsd2xR?=
 =?utf-8?B?TmRoY2hzM28wMFdHT3h5cGdMNFFDMmlUMnlVbnBWMlhCYWN3dlVNRElkS1NE?=
 =?utf-8?B?LzhCWEhBaTQ1Z3hFRUtwNXYxQVFaZlpTME1zdlRwL25EbUJuMFJWdi9YVlcx?=
 =?utf-8?B?VGF0VG1SUE5QVUdjWU9DYitSUjNlUjh5aWRyZ0FqV3VxMlNYcXZqSkM4WkRj?=
 =?utf-8?B?Wm1ZSmpFdTJxelFmUEhzVHVmd01KQWwzUDFEN2dkY1NYSnBVZk11SlJ6RWEv?=
 =?utf-8?B?MjFzZDZDS2FYOFZRNytNaXV3eUsweGUvVWRiTDV3RkF4NzhwNFA1Sm5EYXpz?=
 =?utf-8?B?QnBlK0JrUmtjZ3EyTjJ5Smc5QmloZFNVcCttdktLRXBnYUZUcXNJZjhvc3ZX?=
 =?utf-8?B?QjRuUUJPUSswQkYrcVhuZUVyeHZ5UDBwNUNUdlFsTEVLbTBvdVlIcG9YS2dv?=
 =?utf-8?B?Y2gwT0JYYlBQUkNnSGZZckVqWmNFaTZSMWg1dnhPOXo5NERZcTlYcjZoMi9w?=
 =?utf-8?B?aHFDa0NFSjJqNWVxS1E4VFdqZkJsZGpyU244cTJ0WFg4UjdJUG1NeVIrY2U0?=
 =?utf-8?B?SnV5L1ZlMm5rSFpTYy9NY2JGUGRrT0ZYT3NIeDZtZlhSSW9yanZnRkNFYVR4?=
 =?utf-8?B?Z2VKeThJZEY1SE01NVQ1cmUvWlZEZEcxVGtMaUQ0UVpsdzhFZDFwb2lzV3pH?=
 =?utf-8?B?MmVtNTFHNmZSTEJjbDRJSEowQWJwWXJ5SEZkUllVMklsYjl3TUpETTIwRy95?=
 =?utf-8?B?RHlIL2ZESU5XOEVETVQyV3hYeVk4aDlmNGZhckhycmZrTk5NRW9BUFNJREg5?=
 =?utf-8?B?emlsOE5UaHQ3TDBId3BTa2JNZnJJb1pPK3lkTFBXOXp0RTExMWtVTHVEZFhH?=
 =?utf-8?B?U0tuYUluZTdhUzQ0R2xycHY0WTZMcXk4ZmJpMVhXbVh4bi9HcmJUcUJIMXB3?=
 =?utf-8?B?SVd5OC9VVUhCdUsxNUFrQ3Z6RGVvWmVwazBvdWZSNGYwVGlrZnpEc1N2VEly?=
 =?utf-8?B?L21mUE4yWDJsTzRXTGtOZ2Nrd2VwL3VMMEtkbzYvcFVPM2liMGw5N2VDSnhZ?=
 =?utf-8?B?VG5ZWnY3RTZZMkZJKzNlOUNqZVR5d21zZ1ZxMm11ZWQyT2VlLzF2em9LbGFi?=
 =?utf-8?Q?1XBN0E5coSfXZA/g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd9be06-3b6e-4d51-7f89-08df21f9cdd1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6199.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:28:09.5621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXj8suz6zpp7rmnO9AunRDHKx9viot+Rmn1lpF+ZseKldz4HB9y1VHNrXJJiPEmKpcja+dPLULysRVJSM2AFu7OaFuIhV8DGWLqULXsyit0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6513
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


On 03-10-2026 02:59, Dave Klotz wrote:
> spacemit_sdhci_get_b_max() limits every SD read in the SPL to a single
> block, so loading a ~1 MiB u-boot.itb from a card takes about 2000
> separate commands. The controller handles multi-block PIO reads in the
> SPL: the OrangePi RV2 has loaded U-Boot from microSD with them through
> the v2026.07 and v2026.10 trees.
>
> Drop the limit and use the host's b_max.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

