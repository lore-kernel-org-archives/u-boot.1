Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0EDC982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 14:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFE3D6065C;
	Mon, 21 Sep 2026 14:03:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9u5LU_OEcg0k; Mon, 21 Sep 2026 14:03:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 15F4F6060C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789999380;
	b=gpngUtuo/7j89uikAeR3cOYMpyy6ZxSaolgWWeye5flvpEQo2dlXbHtM2ZIW8p/C/EPF
	 C+bT5qHOFkZ6ExRn01NDuLJFrqYpo4QVyzq9nqYYm1cvSOpVvM7PmOpYsJMirmrY1qxWo
	 zsEzbpYAsl/za1fyD/lRaqZkoklZZcnteXIqy9q4uu5fOuQnlvKWeclWpZCHj4NQ4HbKS
	 ELIQQxSBrWTEHCsLNcBgnXi0UZ3/gcIaMwlfT7i4LPdO6/x6+FeXVYt1bpZRud/nQX9G5
	 q/yzmyAgT23R2NKvpNj/y22L2LYNZ6E4LzWqMD+ZVuVjIPwui+tVWwcIlGfR2chpDFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789999380;
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
	bh=CH83ZC+aY0/fO4qYBStK3wz04OJQ4+5ersaphwYpFSs=;
	b=oncYeto2YZWlTgsij+A9Hq4ZKSLues0+jVF/PTm+aKUuGVBre0103tFpLaaJyqCBqoGl
	 7sJTSNIX4OsM851CC843e5Y1ubFSyE88qDGiNFfpNHApJL22Gd6NjHhSOTEHA04SoY4TY
	 85lJhumaqtLZ2seyI8AQK4xh28KqdJDSWpFTBiHCa5H0dAFgmj+aetx+xhgqZUGx+eaGZ
	 k2NxmfVZJusfVb4dMRN+UHQaPg3kzINQrss2nyda2C8AFtV76u45gQ7zxoPwaLKLO7Ray
	 H/TZC9JEHUjLI5jXCy1rUPkkx7pSHdW03/zENLS8gdzUClGZSqfTJ6ixZuzf9C964aQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789999380;
	bh=CH83ZC+aY0/fO4qYBStK3wz04OJQ4+5ersaphwYpFSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EutIpNWc+K4XfoVlJI+3rFIQMxtia/UGgH9F/a0u+y6O5PiYjdJQ4D99GcGlWZQa0
	 CaXz4BYIoBaaIgIpCyfMEOn7kEydbhd9qxx+cyudLBsFbzjXEMZ5/+hFE6BpSsjeJ1
	 8X8YXOMZUuYlQ7z+Q5HEMU9EAFSclMWI4RY3NqAT2EElEa/p8HyOisDslkClXUgHTf
	 tEs8qFsuQdzp+AAbIWPeGS5/+a1lRPqbw/dD+IaU9L3KQZNT2rBNt66Nko/2FgH/54
	 h34mRewsBaeC7Ieo251Mj3w1/xMRSbM+9UAzf786dLr+B2fA+FOmcQ3TZCTt2ZNOIo
	 vIs/C2AyLq6Nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15F4F6060C;
	Mon, 21 Sep 2026 14:03:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FE9F13D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1ED0A80C6F
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:02:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zxw3rMmlF9Iz for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 14:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F098F80C6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789999377;
 b=G3KYeeph9HJiVXRphKMTtjbWm7Mfc0t4WE2M93BBzOwlqEbAH0HO5im/PxsvOg1RJBms
 wbDlDB/LLFNEZFz9/2mEUIz4nJissz30WdayZ7POnN9IGLXIboqX/KN0cO3UGNjM4qb7D
 iPWd8j2IxF2eN+K0p39aQ2Ppmz9o9i5hG2+kW4vriKxLdLoeJgJ4yhRJSIR4TzE/JEKHy
 Hu97/iccTsE1LLWvAkWaJ3StpSjoMQjELFIjw7p48caQ7a+waJsr+jTjxD1GSMELeVUsj
 prKvl3YnLHp86hW0kLxA8us8rEiLt2Pr+Bb8wWCe2JZuuzga9PuvVvxVKUAtSOaFKEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789999377;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=CH83ZC+aY0/fO4qYBStK3wz04OJQ4+5ersaphwYpFSs=;
 b=AUHQSn3SZDAPTj1hBPJWeqXuDaErvfqgF1Salxu4sITNkQB38BH5018fIujIdUR28o4P
 jU1o85d15lFlaHnv5djNUZXU2Pe1dLCa4rgcNQLTJaonRPD1DWbJ2FIWjLwGormLo6l2K
 PDku7kRGFmUsxyt9TBKRhkEJLlrz5ARDCOBCb8lFFHi4Jbr05zK9/dh91DEYDWYHYbqtp
 pegM5LSJBG4FpLsi9oTvLr+s36AEGbMggx9dEQcZWmmDfxudjIyqhgFF7rD6bUEMB2jGL
 GlNKDxlO4AcScOV9RCm96eQSWz8w33MYfwqquXY58vAE4mRPz2Nf+rEf6p3lIQapmuQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=kontron.de; 
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b="g/3aVjHj"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=g/3aVjHj
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F098F80C6A
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UC7/lqlfxZ+fMvYE2RyQKn3sOinxDa6cNscXYDe70WiR5zbCgWSeBDu+4QO0/jp9L9tP+N/pAa2eXAob21ry2unEJAECDQt7cnlwy3L82jbw7ndbWv5Mtk00eavaQvG0WtRhLQR9VNY37KTqABHK2mSOYpuBKRN0rnd6oYhR+ZMr81iaK55U94PkqjWI6g20flWVQ2YIG2+bEWbf+spJvln2kbC8MUBcMzvpfdkaIV0neV4+y0ZVB+Bhisb71jMGYqeKkq/Ot81oD1FBMG2bBUEnSvd365fBTmsLh+vCFbk2E4lmx7TvxYdmnB6wDWlnzCRP/6aXx/K0FmfbEdiYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH83ZC+aY0/fO4qYBStK3wz04OJQ4+5ersaphwYpFSs=;
 b=om8fA/E2n91kew3OWJC8/szdwunMHlx2BnN818nMqi3qrviV19v9cKARByeoGhWXqJL+xvTJsKxF/VcofeKofXMpn/thu4veE3VDjOza6Z4WBX8MlX8tKqGdmKT5aniA5/Nf5w6Rr84Qqm2QnA6W4Z5+sNeFTuL8KawpGYAclHN2baQysacrfZrdiYWYUhvHcNSaShUDWNxhbYVXwDzEzFtUIgMBsgHxd3OK9AuxvKEwF+ghbsm8VMNt5bsYMNGL9j5Rfck9E9Msozv/oNXaVBbtqiqAa5EYgORz66cNUvmlNj8L2rPfJ8YKHSbo4Rn4/4TZUI7TwprR2CuWsj1Iww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH83ZC+aY0/fO4qYBStK3wz04OJQ4+5ersaphwYpFSs=;
 b=g/3aVjHjpJBu6KgJFY0u0ByJDJhCvmoaYVouwWMceZqbMpgXB04P9uRRGI1rMPEt87WjYIwutNYAaweLu4XYwZ04lDyDGBGRlS2ri9fJ5I778/0VPvEwMATD77qUrSarWbIKxyNNeDvvYb4FBcsVjHTKz4dP2jlK6jzLaQ2Cl9w4kWKc9q0capAr6Zux4GTLKvzMr8uXj5Oz6uEuExgZ3KHxnfdliyahzxhlwvphlSTvz2svExvIoqh1MiiPzbNoE/c63j0Rv6ny1imFhSxrcCwZ4QsPx38tVKoakcBxvYF0YbVSb8D2Z7PYN2cnGUK6isaIFLmLMTHkZCrBde1qCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by AS2PR10MB6428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:547::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:02:50 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 14:02:49 +0000
Message-ID: <3f759656-ace4-4c0c-a969-a8894d631ab5@kontron.de>
Date: Mon, 21 Sep 2026 16:02:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: phy-imx8mq-usb: add USB PHY tuning support
To: Marek Vasut <marek.vasut@mailbox.org>,
 Francesco Dolcini <francesco@dolcini.it>, Tom Hsieh <hungen3108@gmail.com>
Cc: sbabic@nabladev.com, festevam@gmail.com, festevam@nabladev.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, trini@konsulko.com,
 tharvey@gateworks.com, stefan.eichenberger@toradex.com,
 u-boot@lists.u-boot-project.org, Tom Hsieh <Tom.Hsieh@advantech.com>
References: <20260921054505.2978948-1-hungen3108@gmail.com>
 <20260921133040.GA265796@francesco-nb>
 <bcb231e1-3ec2-49a9-b1fb-b9a499d13fcb@mailbox.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <bcb231e1-3ec2-49a9-b1fb-b9a499d13fcb@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|AS2PR10MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: be20f961-63c3-4ed5-0d4f-08df17e9056b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: CI0kRKGQz+sRk9+78Ruzi6r0/jvVgyfei9DHg8EH28aNiX6VqYdHKYsFnNBwqvY/XdTuSP8pNVM/4jUtxykyPF7/zSMKnsy50g+ZI82/WtBJ3b3p+zS5qmtTOhs1xyAwaoz2gWptbOtBNqrrpJxWJvEJ/7fvIpp8WrtcmSRcDZvkB+XhyrX8PwYyCq0v2SlnFf4Fz1XKSTZkurblc/sRxPHgQb0SNqdQo+KMUO4LBkeUxbKjS5HYBUHlGjs2SPa4YF26pv0A0SathdoFHMOxse0lvVFrUqNtWrigPMvLB9eJuwXZcL/NFBKyNAZJPvvtxy6+z/3mlo1LfqywVzpEF8fxRIOUe51cDS8z77/Afu2pliZFNCakBE3pMEf9Bl76aR3KU5/DGmL3kJCXE23YOImez8FGLjFh85CGuP8J/jRnmJ3xUwurAEtGplSznBwXrOtKIbNt88A0duvIv1zVY9n9k+zLqiiwCiiV4I5PWfv4898qH1/O5rdYRrhLv+A1yVAPe3cVZzMUXOd+heCEyEEty7pfCgRs6TTzDN3aK5lqLb0jFR9gwrSOCN2QcmHHMnMJvdP42rnXRCZnQgFGdrGsm5LZcauaOillWJ3+UQOGmahc7Rr3wGO3P1aqv5wfUFtQhmQJas9k6oN+4bzl/D7f+2MGl719ENASGuPX+Qk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDNWQXdLT0JXY1R6aG82VmFybDh1SjlnaEcwYk9FOVhOT2YveHl0TDBhc01u?=
 =?utf-8?B?aGtLQnRzTURoS0l3TEhjckQ4TFA2dkdnNEwxNC9qMjZ2VnVKdkVqSlI3K3E3?=
 =?utf-8?B?Zk9HTGp0UTRGOTA5bkhUdGFaRk1iWWlsTzE5UTJFNFBTUHJjMmZxY3pQS0M3?=
 =?utf-8?B?STQ5WEZzaWFneWhFR0c5MGN4RERzQU1GOWtxeS9TZWU2UG9IQ2FmeHR1YkVS?=
 =?utf-8?B?TmZOZW9pU0lKT1RGMjhBWEZrbGFwaHhVeHJvZ010UnhzSDRtN2dvMUYzc0NQ?=
 =?utf-8?B?TTl6ZFMxMVdyMCs0UWJiVkdSVGRhOHdTUWVQNTBtMlVkUnorZG05NDNvLyt2?=
 =?utf-8?B?OERieVd3cDZXTnZ0Qmx0dU0va1hOTGY3cVYxUVdjdU1TYmMrdXA1a2NJZlcv?=
 =?utf-8?B?QzNVUVVmQ1BYQ0FmaTRjdTA1UXkraFlWb25XNHIvNzdjRm1LaHl1aS9rQmFq?=
 =?utf-8?B?YWVRdWdiNlYrcElRNDVLamlXN2t4S2syWTVXLzZWbDM5Z0RSam5JclpKUHpm?=
 =?utf-8?B?MW0yMERKdWc0NmNiY0Evd1BuZE9qVUlZYUhsc0lYRlZYRnI3YW5GMFROWVN6?=
 =?utf-8?B?R1ZabDRhVngwL1hZSHB1Q2NyVTBUeTdyQ2tTWjFqSlVPUXBzQkl1Q0ZCUnFu?=
 =?utf-8?B?SjVvaXpidnUxcXFRSElVa2VzektMRjJYRDUrNVZPU0tUaGZRcnZpclk3ZW1I?=
 =?utf-8?B?Z09lTjErUUF2MExPMEt2NFR6czlBVWVLeUNJUkdNNXBhUEY1V2FGeGhJMWxN?=
 =?utf-8?B?cnRvODFuUTRrQ3YvT2V2cWlYSHJvdTRTUzlhYnVtVjB3bjFzdlZEOGdhSlM3?=
 =?utf-8?B?bHpPKzR6YS9Wckp5bnJYcFkwZXU4UXR5SjJZL1JSRFVjdUgzUEpZL2JpL29w?=
 =?utf-8?B?Mi9EY0NhNENpN2ZIU0lIbUhhYUpkWGM3emorNk9ZNUhONGtHaEh4UHRPZENE?=
 =?utf-8?B?Vm4wQ1NOTjBNa1NmcS9QMzkrbFY2YmhVQUJtNXpUUWN1K1hKZ1dkMFRreDFQ?=
 =?utf-8?B?NHNLdldjZ2FRQy83M1dUcGV2QnFXMWd4L05QaFNPSUIwQm81WTRGOGFGUURC?=
 =?utf-8?B?V0pydTZQS0pmMkNjL0FNN0M0NDBNVG9pYWdxYnI4bEkzQ1lzcUgzUE5YZHo2?=
 =?utf-8?B?bGJHK2VwdDFYM2M4S2EvUWNqQ0NFU0ZiTnlpV2sxRVhnTVRxd0Y4WktSNWRF?=
 =?utf-8?B?NmdnTkNjSGZxQVVCa3I1NHYrU1ZkdDgyR0tzRElkRUU0eElDOURYMU5McmNL?=
 =?utf-8?B?VEFWeTNnZ2lLaXZ1c1Q1MjEwV1pvbDd1OCs3YXYzRW8zZ3AzaUlFZzZob3pw?=
 =?utf-8?B?d1NFSFE0WkZPN0dlYUhQL21nUzk4ZXZsdWFpYWRERFozTFo3UGtsMjhWenZv?=
 =?utf-8?B?RTJ5eTh4cmowTy90K21XYVI2dHMrMHNkSEk0b3lLVVFRejNSRVlHbUM3ajRF?=
 =?utf-8?B?c2NEZmNmL0NNVjhDSE1rVFQxcUJtbThva2pJeVBnemFkWmpabjRQSTdZOVli?=
 =?utf-8?B?dEY4eTBxUThueS81cFFFZmFvK2VFUVp3VXNIZFRxMEZtZjJTbmhMTVllMUp6?=
 =?utf-8?B?ZW5SaVpyN2RUaWxwNVBiamNqS2h3bS9kVDVmZVVhM3NlWFl6Ykk0ell4eGFw?=
 =?utf-8?B?RVRsbjZBTU04SzFISDBubnV4SzdvbEFRNFMrM1dTcHZiQjNZRi9PQkRrbUNs?=
 =?utf-8?B?bkJhS09ySHI2RjVBM2w3RXhEVXcyVXhrS1IxdFJUdU1xM044VysyMVJIQmhZ?=
 =?utf-8?B?aEZEVjYyVWgyTHBqeldQNERBYmNHRktlQkJsM2Zub1lNRmdPdFRReEV6elVJ?=
 =?utf-8?B?aFNHeHJFOVAwMDA4MmhKeDVjRndLWVArMndSa3U1ajNwYXBuRiszUEJ4Y09I?=
 =?utf-8?B?cE0vUE1makViK3JHQlYxSlc3bXp4Vk9UQkt4Skh3SlE2SUJETklsajJEYU40?=
 =?utf-8?B?SWh3Ry9ISFFHVDVpYW13U1pWNEQ0eGsvTjNGNWQ1V2hUditsSTZwdDFxWXVy?=
 =?utf-8?B?UXQ1cEdoTGcxUEF1UFhtanpFYU54RnN6bi9OZXJsT2RaZGExdHJuZTliOGxX?=
 =?utf-8?B?enV6cEJCY2VrdjMwdEdQc1A0M1gwUklLa3dUdWE3aXJjMW8zSjZrK3V1dC9J?=
 =?utf-8?B?MjkybncrbHJiMGVaT2lOR0NOUXZKZXluWitJRDQvanU2bmJiTjB3d2tlVVo1?=
 =?utf-8?B?a3lRdGlMVnM5bDBGZDFvQzlRK3Eyamp1MXpVYy9tZjRnd1RLekszeEpybHFi?=
 =?utf-8?B?ZnYyUTBBbG9Ib3NjRmcwdlhvY29ZUWI1RjI4QzJhSXFlZjN4K2hxaERzRi9k?=
 =?utf-8?B?VlNoNGxOdjFycHl5Ym8yeFhwNTlvZ3Rtczd3RVgxSVlTK1hJTlZjUnRVK1Vn?=
 =?utf-8?Q?wPgm3tANeVTkAULg=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: be20f961-63c3-4ed5-0d4f-08df17e9056b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:02:49.7371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXFEmJFT7nToS5ifcb5l2PcWkLNGArJhNTb29ZwC1ZlYLK4g4O8TjHbmx3RCh7M2d5uvSOIcHox1u5NZeQO22ib7vorziolec5DQnVCWZTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6428
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

On 21.09.26 15:54, Marek Vasut wrote:
> On 9/21/26 3:30 PM, Francesco Dolcini wrote:
>> Hello,
>>
>> On Mon, Sep 21, 2026 at 01:45:05PM +0800, Tom Hsieh wrote:
>>> From: Tom Hsieh <Tom.Hsieh@advantech.com>
>>>
>>> The driver defines PHY_CTRL3_TXVREF_TUNE_MASK,
>>> PHY_CTRL3_TXRISE_TUNE_MASK, PHY_CTRL3_TXPREEMP_TUNE_MASK,
>>> PHY_CTRL3_COMPDISTUNE_MASK, PHY_CTRL3_TX_VBOOST_LEVEL_MASK,
>>> PHY_CTRL4_PCS_TX_DEEMPH_3P5DB_MASK and
>>
>> [...]
>>
>>> Assisted-by: Claude:claude-opus-5
>>
>> What is the policy on this in U-Boot? If we re-use the Linux kernel one
>> it should be just LLM.
> The author of the patch has to understand the code, and more
> importantly, be legally responsible for the code they added. Therefore
> the author cannot be purely the AI.
> 
> For example if the AI generated the code based on some problematic or
> closed-source content (do we surely know it did not?), the author has to
> be legally responsible for any damages.

I think what Francesco wanted to point out is that the current kernel
scheme for the Assisted-by tag is now just "Assisted-by: LLM" where it
previously was "Assisted-by: <LLM provider>-<LLM-name>-<LLM-version>".

He didn't suggest to have only an Assisted-by tag and no human
Signed-off-by.
