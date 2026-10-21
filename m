Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D61606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ymcg04lJ;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=FUAKE7UU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C21B1607E4;
	Wed, 21 Oct 2026 02:20:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xYbrt2y_EWyp; Wed, 21 Oct 2026 02:20:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 132AA6074D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792549242;
	b=N38c7UItIJF3hFOYVRyx+NPHM4nubGqOIkJre1UDF5l8YZCbtUC5Dgggwn75tu6pQ+0S
	 r2d3Ls65MYXC1j63+lkxg6QXnt3BNxZxPLQV67OOcxLB8mgwGfaxwLCMRI1LuDLZlzOBq
	 IKlbV4TqFmgzKtniubLlq+MeUcLtyZgHPeMDlboBjMif2KygEsSjGCm7I7fcc4scUrVrf
	 JVsd1mAGz1Wxn0C3ngU9sfxXCMeCoqHSd5FxgifFgEBRe+CWNCrVfZNS9TBIgptmRwhTM
	 JnMe1ShsIy7z2QJwQlTcdeGreZ2DDg0jfELU7UyHPT5d0p57HFoW0tme9pmyYapaalw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549242;
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
	bh=R2rIExMA3xqiw7rQW96+hUni0PloAVQKgRSmX5uMPn8=;
	b=mzzFthkiJKUQYcuNGRRAoZrDCn6vlOYbjqeqa+cde1u0FNWmNCBr5nU82UD0NGVzpxAs
	 NhZ4vhz+3fv79ZzV9urUFedWJAjsEgmiF9ImrtD5KXN8KlN94/PmTFfUvfCN2LzySm0KY
	 hrF9fWTqeWbLWOqRKPpMAIkHw0HYgia+JXiVKxuQNr08xY5IAK2E51HMoMs8xYnQWg4xt
	 oy614cGYRTZvV2FzyMX+aNVG49bK1S9X01r8HKrZNmsFG+EXLus+8K0MlJBU/vPywgjIG
	 Si098DHEr+LR+4EtTUwuuFSRcM+Cnj/C+IGegXFowl5fVQ2ledOW27Pet5hDlBNlazA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549242;
	bh=R2rIExMA3xqiw7rQW96+hUni0PloAVQKgRSmX5uMPn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ymcg04lJ9DhH23tafas+9/V/E/ZBVh++o3dpgAQCLSx++CSPiNGmdiL5eEA3R5Ljd
	 /P1eiItnMxTfQzUBe2/+YcvqsawMCgZ48StSUY4zoCZMmRFDcFv9snCckCxzfaC66L
	 inRlzvTWdSj48ZV4qIGsgQDl9pAXj3hrvbEkOFATH/6W7ObwVFACQbW4wlgOh3kzjo
	 RoL/8G3h8WaNWIfUzJLBGrpkj2u2/VQ3EXc7xcbBc2dzsJIkfd3XJe7ATbI2mreguw
	 62PTbw/3tR6oGpnts97mwo0eir0eLJcnD8YOorsTTK6aCsRM18uiEz3jVwzHR/mkBP
	 x0NFKRaN1xkWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 132AA6074D;
	Wed, 21 Oct 2026 02:20:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A9B7995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C5A481086
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:20:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gAG9t4dinU36 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:20:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B3AD680F90
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549239;
 b=CQpO8Kg2KkvP2ts8UIPUgbwiM7+7qEdEou68Wh5ZhDBB4WInKzrElMwasArqnIOvJ1cC
 XKcV2WHxl3vpAhljYCKs4qGHcm32NQLabGzFwK9w3JksRqmuYaDxbJ7oCQaTSy7W70/dG
 AwVY7X0YnNBBOoomKjVazuvqzV4RWJSRn6XCfJuTFItqpT33Iw5GYKCozJ+Vn2B+p4gTe
 4/iQ9+B5DosDMLC4lidDu7s8KUYn2DneesyKp0hQ13C7xsqBf6J0hUVA2qqIEFR9Q+c5G
 Gl1Yz1J6s7Sj7b8yM1S8Vk8v/SXg5liJ+NeQ4BXhai5CqQ7GE7KDm0Qtc5Y5mNJPXtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549239;
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
 bh=R2rIExMA3xqiw7rQW96+hUni0PloAVQKgRSmX5uMPn8=;
 b=jEDFmzfgw7SgM0rjh8Xh79rXch8+js/6ZQK8DqrxNcJ3Az7WcbQIVUkiuiltJzVxnm7Q
 lUaUSD5FVzyTjF/1okzT5tUpmTJ+WOpNYLEJ7Kr95l89L4QXqhxkBVgfRqhy3kNCli/H1
 FRoHOom1FJ91JquBtxeU5HBDtOL+OJiKBGTzkKV/ngLvx9lLIoHbZWWCyc/aeylVLmT3V
 tQoW4pESHaTa6h3yu93rOUgavZQK3W7BaBTXzS35SZEDBr1fH5x2qKDCYOaTKQuGjhRG8
 u8bPNkr1WHMbIgW6MRl4c/ILDiBg0FWGex/NpBbUHZAjDmhwwyIkq32OHEJNSiB8u4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=FUAKE7UU; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=FUAKE7UU
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3AD680F90
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:20:38 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4FBF844F6; Wed, 21 Oct 2026 04:20:36 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A4908056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwAfcMHneXNsFRDO+cqQ+6dpFOPApvc2eXV/jPJ/MER/BsG5bFoaYvUSpxa5YMK6TqIj83GGNjgZrCgreVwrUE0b1VuNhb6p8rsYCF11CTfAdYOGOcDKXGZlfLOb9C4A5ETBc15TtmTSKebnMZNVN6ml08DLiMosqTYGTI0u9pA+4jClTrg1FdEItzabh2EF2xSXXnePa2eDhpxqpbWFVUwjyYR0CEnHXGPly8CbVZHqYhXPI4ZD/Irc0GHqytxN2WwHYzK2xHLhpTwk1fbnDsYEWyKziQ7R5ej6S2SdDd3t3MlaC3ApWlcVdLQAxTJRGQoyTm527xBt6UfSJqsnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2rIExMA3xqiw7rQW96+hUni0PloAVQKgRSmX5uMPn8=;
 b=IKdY5mbPT8G8UzMKVHfSYj1ncpTDkR85/InO37bj+we1NMyDHRUNjJ0suQ6vVI9gVkcGlfgA71KdSe+CLIxcCqmZJU1E+Afn/8BBywReNp3SbK70rnzdz3ZaJ+xLliwmBmI1ZihlbUa8vRsm7XMoA7c/kP6YC8FWnZ7ZNItymSj7VoMZrKe/z3AFjvb9ErQ1d0A+lAMpaiad2brf0TyiafC+kzwmqxZSDLHfMb/zrqBdfm3fi82zl0sMyvKtYny/Lt7lBLOMe/H6ldDnYDx9EPbvsAtbpxQ65fFhV54NOaWawWJa0PhgzC3M0V6Xd8/816GVkRuhbsWlLfsjKMURVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2rIExMA3xqiw7rQW96+hUni0PloAVQKgRSmX5uMPn8=;
 b=FUAKE7UUH4/A1Jm/HkUbz+dFoY6+4G9uXUP8ttgKrYU+czRWzz9k78ce5Oem2qQqA8aBc/bvKH8CsjkTWxdyD93VvH9Q0xfEoKBTgRVb8YTcTThaSRnOTUK84oXI2yUcv77ME9OwrlXzMaXbJ/aN3fNDe7xETZaVuhvWG0FZr1yK98RKQZXLK4rWzf11nLf469rNSUOO4CbinpLBF5DQ51aTi94MmPtQ+yYmUoTbmxMc5fQ4AnXyl6nlE/eF6TyJalxST7EnYAVRW37z+dldAX6OulCIPsUOTsVG2Rmdd4cUTraY/6HcQQT2W4HSP+gLE6F6T+juZRDMTbMLQ7IQSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by CH7PR03MB7833.namprd03.prod.outlook.com
 (2603:10b6:610:249::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:20:22 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:20:22 +0000
Message-ID: <1aeab7fb-9a5d-4bc4-8037-eda4c6d8d858@altera.com>
Date: Wed, 21 Oct 2026 10:20:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] ddr: altera: n5x: re-init DDR when double-bit
 ECC error is detected
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-8-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-8-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:990:5::15) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|CH7PR03MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb48c03-effe-44d8-b15b-08df2f19dbb8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: tshdowEg6RQflOg5yIxtl2aePcxgirFbx8sou1KMiqxaeUXD7ZDI2maIBaKZXTGECgDetaDlMCY0SojOa2s+yeNDpvDHzmZT6jooLvdRMot0vZYbJnOeSHNz8ZjGKlam/CYOKCipOVwVP/XHgsbEcmukAB/OC+4RqdK6R0SqsdNgLRvQdanJh101B9suPDmJW3V5uCX3/NoUdATYMk6SzfTym1h0vx/Ge5brrkHPEmKshZK7R9qP6KqKCVe7uiNJo489eCcyN7d/gAskU3EgNyVE9uZvli07PK0NNVvwHHBGn00tnf7O0Z1GVQcw8k9MDvsatvfJTgsZjZHK9nnK+YVZrccugsuaJaxfKHDPTKOK6fN1iNf5kRQ/GIP7N4qmNumjJVyZrhL2j65ULnFhXmcZFUq5ciPP8dhiCg6ZYgyWrfYHSWtWdSFH6qC0bClYUHKKdVpetlMy9mRGA0PQ3fLysAX671MCaFyN9PU5p58a4oGt7nrHzgT/5ubdWQYJNydXQUQ75sIEZMalBv/PqV8GW9lRJpOxQJqKH3ZV4BOan7TdbAgzoTaQwHb/IxuYVg5EfgUOx6zKsXSbMeAzerZ9iUpCc9yeZvfcjB/vKQbgjKs0I5iIE0A87PlpVzYJ4LFTGzBYW5zG0SBWcHaH6wgoF0WoGX5ZFjz1dM8U91E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(55112099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHl4N004bitqbjExYXdQWS9UOUJBOXNwa2crNTc4QzdWL3QydUdGTTlOUGt1?=
 =?utf-8?B?QWxOeXBucWJtVEhSQ3U0Z2F2SmthbVF2bnZzUEVVYW5MSkNYMThSU2hWYVc4?=
 =?utf-8?B?Tm5lbUtzS2ljUWpWT2pSbW41dGg4NTFxTGhES1hFS0V5cVBZS1VoTFg5U1pX?=
 =?utf-8?B?K1pDbjA2SDA1eGNlcjQ4SmhTa0hYQmxUaW9oaWNmbS9mRzRScEI4NkJXVVhT?=
 =?utf-8?B?Z2ZBSEdUUmNWY0xUT0NuMmkrMnZ1K2dPOElEOEFST0x4djJQQVRYSkhSUGN0?=
 =?utf-8?B?aW8rK2xCVThEL01nTGVJd0xtTjNYTHpqTWxITWlqbERjeGIwckdmZXBraGNk?=
 =?utf-8?B?REMvelZ2dDA4RVV5NlI5aURsZkpoeE9zZm1IYUhJTHROb2RXczdCT3RVVW00?=
 =?utf-8?B?dXk2NzZvZ2dPVGJsQ202aGt3VmNYcG1iWktiZEMydWV5cEsreWlFRUx6NDNC?=
 =?utf-8?B?UU55WFYwUldveWlNVmpUS3hIc0NWZFdaN2NGdWN6aU1jN3hDUDJWM0p0L3R4?=
 =?utf-8?B?akxLV1ZoZEhyZGF1Z0ppNWkyK1ZhMXdFUmsrRlhLZU0zRGlOUjd1bERscDVZ?=
 =?utf-8?B?VVcyWTBUcWw3aXBpTEVMT0plVXgxWXdma2cya1pXNkVkcTBnZ04zM0duUmJa?=
 =?utf-8?B?ZGFGSEJGaTJnOGZWK3lpTHpjdm41ZDFBUGJhNC95R3ExbzJCM2JDaDFwQU1Q?=
 =?utf-8?B?RVJoU1k4M2dMdXR2UUtuZGRjUnY2WlRvSEJoVzM3S3hqTVlXZUxZKy92Z1RQ?=
 =?utf-8?B?UllSZ3dRRU5tNDJUcXNXeGtrZVNpVmozc1JqMnN2NUZaa2ZNK2J0SDFVSFFO?=
 =?utf-8?B?QzZCTjJiM1NjODhzdWVoVkh1blBPaWRteG43b0J6dll0R2w4Mi9adkRQbmRn?=
 =?utf-8?B?V3BOV0FzczRrZ2lEbnZVdjgxSGIyMFNhanludDFQY3JCaTB3Mmh0MmJqa2w2?=
 =?utf-8?B?Z1RkVGNTRHh2aFIxbmxuZHFXa1VCbHZ3WTQ5WWNqOTFwT2luTlR0azNhSXZv?=
 =?utf-8?B?cmRWTXhTcEhleTRJdUczS1o5TnNiZlk2dk9STG5Dckd0cmwrTS85bFdxNXEx?=
 =?utf-8?B?NCtuRGpWanNMSzdmbnNEYnJOd3hhYzYyQWwzZVVSWTZOa0NKbEVRdy9XOHdl?=
 =?utf-8?B?RDErZW52QmJIQXFXcFVuYm0rbXRFellKQ201eUc4Zi9zZGVJbFd4UlE2MXl2?=
 =?utf-8?B?cG0xZXppUWhzM0ovRmhYSHZwbjVNVmtNSFIyQ2JSNlBLeWo4ajg2REpyaFl0?=
 =?utf-8?B?S0RCK1Z0eXJDOXNFWkl0ZlJUL3o3eWwxLzZ2OUMzZG5XTTVCREF0YUpsWTI4?=
 =?utf-8?B?QXdMa2hZamp1SFNibEFBTXArbXdhbi94TkJaVVlDc21UY3QweEhyN3g4akl2?=
 =?utf-8?B?UUJMNmtsam55YUw1dmVmZ1JnLzZWVVJVTEV1YmtHTzhiSzdyTEFhdFMrWng2?=
 =?utf-8?B?ZkNMZ2dONTVacHdqOGZ2SWU2YXdhbThGSXYvdjlhYVplN3F5K2VBejJQK200?=
 =?utf-8?B?aE5JeWxPdWdYRGtqS0U5N0EyWjcrVWR5cjB5L2hiSTA0SktaMTBFWVZUL1Zi?=
 =?utf-8?B?d2dVaXkzVlQzcVFuMHdiNkd0Ym96aG5Va01jOTlnSDhLekdxUTRiUzdmaE5i?=
 =?utf-8?B?MWIwM3I4SkV5OCt0aUdzbUdvZk1ORWVCN3E2RVlBYzd3OHBkdEhsTmkwQ2o2?=
 =?utf-8?B?TWpqN0tTcjh6OFBjdFFxY3ByMmp3ZG90RVliQy9SbDkvZklBMXVnNVRldE5T?=
 =?utf-8?B?MWZuMDRjditzK1JzQmE2amZoc2doOWttMHZQc2FVYnY1eE9MaGlLQjVEbnM2?=
 =?utf-8?B?blNZYkxUZWd4THVXU1N1cVl1TXl0ZzViRlIydmYyR1BKd01nOW42MmpjRHkw?=
 =?utf-8?B?YWFzZFZ0VlhPanRCelh5ajZjRjZxaDBTTUFFYmpYd1l6RG1oTDl4a1pUUlND?=
 =?utf-8?B?ZG5OSkhaLzZ6cU5hNHpiQlJzSERiZzlIU2VoRVRVOUpmMENhVDMyMXc3RWR3?=
 =?utf-8?B?YzBNdmxoL1BCZ05yMFJUQTNIWmw5Wjg3SXJzU0hBTG9HcHl6bE9nL1JDT2RH?=
 =?utf-8?B?ODBhU3loSGFOdjFheUIzQ25kaUFicnY4amZScnN6SGgvQzZTbk9GVThJSnh3?=
 =?utf-8?B?dmExamdTdzZlOXhqaGxObG1RempheXpRaUpPeGs2Ulk0ZWowbHVBUExvb1ZP?=
 =?utf-8?B?RFlIR0kxakNTT0xYWVp1VEF3OE1uQmMxYmNidDhLWWY1SHhGWjZhQXBFWUM3?=
 =?utf-8?B?K2pCQzd0ZXk3VDVpVzdGWXRueEd5a3BPVXNmNlB5b1Q0TTJvRU9YQlpDRkNU?=
 =?utf-8?B?Q2VCQjZ4UjlqbTNadWgrU1psY2NGWnYwZkNNNU04VjRpeXorSGhTZz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb48c03-effe-44d8-b15b-08df2f19dbb8
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:20:21.9745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrpDsQsz11hyLtXKqXf/2OmaREbiELsjBkTO06/K9qa6B7HvoiTsDcHjmBwGQj0I+/NAtOgIJeF5JEaO8di6rhsO7a6Sq0FU9wpvxjcLisM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7833
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 12:40 pm, Chen Huei Lok wrote:
> From: Tien Fong Chee <tien.fong.chee@altera.com>
>
> A double-bit ECC error (DBE) means the retained DDR contents can no longer
> be trusted. Detect the DBE status and force a full DDR init and
> calibration in that case instead of taking the retention / warm-reset skip
> path.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   drivers/ddr/altera/sdram_n5x.c | 33 ++++++++++++++++++++++++---------
>   1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index 4da0617e37c..1bbd5bb0082 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -420,6 +420,17 @@ enum data_process {
>   	LOADING
>   };
>   
> +bool is_ddr_dbe_triggered(void)
> +{
> +	u32 reg = readl(socfpga_get_sysmgr_addr() +
> +			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
> +
> +	if (reg & ALT_SYSMGR_SCRATCH_REG_8_DDR_DBE_MASK)
> +		return true;
> +
> +	return false;
> +}
> +
>   void ddr_init_inprogress(bool start)
>   {
>   	if (start)
> @@ -478,17 +489,20 @@ bool is_ddr_init_skipped(u32 reg)
>   
>   	reset_type_print(reset_t);
>   
> -	if (reset_t == WARM_RESET) {
> -		debug("%s: DDR init is skipped\n", __func__);
> -		return true;
> -	}
> -
> -	if (reset_t == COLD_RESET) {
> -		if (is_ddr_retention_enabled(reg)) {
> -			debug("%s: DDR retention bit is set\n", __func__);
> +	if (!is_ddr_dbe_triggered()) {
> +		if (reset_t == WARM_RESET) {
>   			debug("%s: DDR init is skipped\n", __func__);
>   			return true;
>   		}
> +
> +		if (reset_t == COLD_RESET) {
> +			if (is_ddr_retention_enabled(reg)) {
> +				debug("%s: DDR retention bit is set\n",
> +				      __func__);
> +				debug("%s: DDR init is skipped\n", __func__);
> +				return true;
> +			}
> +		}
>   	}
>   
>   	debug("%s: DDR init is required\n", __func__);
> @@ -500,7 +514,8 @@ bool is_ddr_calibration_skipped(u32 reg)
>   	enum reset_type reset_t = get_reset_type(reg);
>   
>   	if ((reset_t == NCONFIG || reset_t == JTAG_CONFIG ||
> -	     reset_t == RSU_RECONFIG) && is_ddr_retention_enabled(reg)) {
> +	     reset_t == RSU_RECONFIG) && is_ddr_retention_enabled(reg) &&
> +	     !is_ddr_dbe_triggered()) {
>   		debug("%s: DDR retention bit is set\n", __func__);
>   		return true;
>   	}


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


