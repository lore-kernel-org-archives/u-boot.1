Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4053ACA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0C2B80DFA;
	Mon, 28 Sep 2026 17:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P2tFgsLy6Vk8; Mon, 28 Sep 2026 17:04:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ED3B680AEA
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790615086;
	b=LQpF6hnOdVmgV18UZc1evkl7EvE9z2LnEuc1skvlnePtJ2FbzcDAHXmuFzX9GCrSB2tG
	 J3r0M6JWhEN9IfA+igh2Y1oB5mcRjt6zcYYRSI+uUV7Fxz2zktt63fJ/xyVwJF2f77Vmf
	 x9ZhhzFy3yEVFaA5auVFvh3cOir6PGbJR8HsXGQi7rm4tdxAa2L0V8pICFjYvQ01dGVOn
	 B4SRASMkGXZBYH5MIo9o3YezbeO4UlhzafLAoH1Bb7fpyb0xd5a/SNsIvb1A/mSVPl/+x
	 yPfGxx9BkS9MtWEGuxC2Xu+mF+6jb/Qky37p1F/sRGpfkA/AaCiwDb80SeJHLcnAayA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615086;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7bDwHOp4GxB1RG/FAIA/ARTnY92pIjMYy2SgQqs5MKA=;
	b=d93gJEDq0NFuLlcGdRL32u9XRx70Mfu8tvqdOI+JckqUE3MPCbxsK6svRqfgaUm39dBd
	 BY4kTiCGS4jyGNQ932bOyHESQxaQjn3j1Kf1rn/1YUaqp156ZPOLjlNZwuEvHKp5iZx2I
	 l3wQLn552DxUeRWF7canC2kXMykOB1wVKWBpT2mxLJv9ffaLfmWYMNQ5k60TXcCjsE5FV
	 gwG4KEtXFter7a0fGmFyHOb16jh8VSpfxTW8iNCV5RHZzusEGZAy/VbmfxQbP1bQMsxHx
	 //rNTSW0UdVRz36+3n8xkymxEbvT0ZjQIKFANOUrcHf21ia1AbwRAelgbn6aOUss1jg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615086;
	bh=7bDwHOp4GxB1RG/FAIA/ARTnY92pIjMYy2SgQqs5MKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W+DVd9vdS5N01z2ZVdjYyfYT0m/+dV/muwgBj66WLG5ckPn2sdSBn7SS8f2yuAv/S
	 x5qTb+lYLqUcY/9MOaPgDOfWk2Z0WuxI7GBpzTp+PxQcDR6Zt5enSfuZB5VDAOjpeE
	 PRi9FGyyFJwP0elK+liGvv/oSvJjt90FNEKYYrA39xEH6N0uUyqUwijevFdwP8NV+i
	 04RvHXqTa4wkldHVxD95bu8nZ2G6cnWnZkmJQzU8yvZGGGNKHxKrpm2l5f4Wfa4HZy
	 a7/JyzZgBvhseqyT0LV/zdbrDkZk6ttgqz5AfGVeEtApXZUONTA7QyOZTWeEpY01Ms
	 Si0PugSF0ZYPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED3B680AEA;
	Mon, 28 Sep 2026 17:04:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B96D361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 13:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 213D0606B3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 13:43:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xRMS-D1dUlPU for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 13:43:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 83764606B1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602980;
 b=OYfBwqQ0gPlkQO+LzfngJzwOJoWsrgaF90YhHeCJNf6tQGJf1R061vAtcV1HRc359Q9c
 bHqphrfLlxWlYOUB8ykKYiVIHdXgJ3ptIhtZIyUglrz6EifnZZEmUJjdsmuHAM/0ynRO1
 FggeZ68z+2ScAYngCH68VRA1GAFsicnMTN1JjvwDN217qREfdmcoTtPlZuDzYG4q61NpD
 F16FZzAshZxLmui55rW1uuUD+ci/uMkhXs3L/LadlOIr9VRGV2iiwxjVobhewuEGZxlpl
 rBZDDKI3mLaOmr0tWDjQw3+aHyGKP1pj0l6FhAgWXtkcjWpAUjAEHV2N+Q5ZPTZA3ZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790602980;
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
 bh=7bDwHOp4GxB1RG/FAIA/ARTnY92pIjMYy2SgQqs5MKA=;
 b=J3XUZ6w/JI6PimgTJ8sp4i23YZk9YET/Z2+SLbccXeTxTuBnm63aNhG+NAs/RYjLtVhG
 7w6xBDW+lGf2f1C0KZ/8wUvk4LhXkI053xWZFlxjJRwbY4ZOWtZgOWIuIIcytjbUhP+9E
 sgE0xTn18f3+XpNmxzngoX60EIYCgJXwTAu5a+lbAyfKVzaGLpdGo7hlMXJmH0bMNFtGS
 LQD/a09dI/3B57iPDrIoftUPKnUiQjUngZokDaQSzDFEOfR98Ww0qpn+4Vj0PD9p0ZBY6
 wPY2Cli7cKiVQtis9Mh51N96IFbIzXeTcXeNpOAZXLADc68NkPURms802J/t4nRszcQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=MTJQzc3n; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=MTJQzc3n
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83764606B1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 13:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Geju4lYkQQbsns53CVX4E8iKhmhgg96KrXemBtOJQ389ALCJ3OOyBIWNj/52cGF2inE5RezwMtzE6EXvix674xwGCeLJMa08M7QmqCZcLVie6/r3swNnhqTUZZrvfoucKW4/E7J3mwmF8/6Qwf36Kl58vPffA2JOBKIwof6qWAmddK0qqz6oVBAI611nri82f//2pW1I63YuQJot594M5Svb/Nwq1eYCkKVlFRW4FYaHR3QPMeIDqw5jT8lW/E5dlft40RgOVAaXgWkz2+kXpYFJM39Nb+7Df5VzfWAWumUTml3bJCSc8JwYzWSZt6WiyFgztlcKAgNLv1pI4xNC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bDwHOp4GxB1RG/FAIA/ARTnY92pIjMYy2SgQqs5MKA=;
 b=Ilt7vydrANhO6F3nsXDyrK1ID1uo/1PU1yrRQUec3W+kv5Lr/33FKKbPtZfSsKVAvyooc12wefqEw2VJZgz72aoIAjqYiVfcAgKcCbJYqa748cF9HAlT3E//y3Dzb9Gjd5OeWYj1ZdZ05if7JvJvijboGHvY48E2s4ClKmObvQrWK7/T8X9bb5Ydn8SKhkFhfAczyZ3hlBX7b5SECjD3JJHS09OF1GYtTdI9xgzCHlteydlWXxBCTPeXSQcWAro7HaF8WXUVSE6yQKK5eqs9D0lrW2gG7S36WL9cfnuvW6mMIn5QFlwZZesUu4nBknUrrwrd2DPU5ccTdDCJPwynqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bDwHOp4GxB1RG/FAIA/ARTnY92pIjMYy2SgQqs5MKA=;
 b=MTJQzc3n8l5bezNkqWjdyjDeEybboTXRHWwZ1hmWwdgOpQQFw7A6zO+AfvZjpbqVPYHcvjeq9zPcVbovYKguhpm5jrJgS5sDMUSzKFJPTuB0v1oz8V2HV6cqZKVESHT/EC/OET9OW/vhJgEBEjQrt4y0SiaYH7oe9Z9dPgq7/XI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB10924.eurprd04.prod.outlook.com (2603:10a6:150:224::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 13:42:44 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 13:42:44 +0000
Message-ID: <7967ed70-13ec-4ed7-947f-8808710e8c44@cherry.de>
Date: Mon, 28 Sep 2026 15:42:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] rockchip: spl: default to Falcon mode boot in
 SPL if enabled
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?=
 <joaomarcos.costa@bootlin.com>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-8-acb97c172993@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260731-atf-falcon-v2-8-acb97c172993@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0248.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::21) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB10924:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d9ac16-ab9f-4b57-0e0d-08df1d665fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|4143699003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: Vc4Nc4So4xHezTTnqLuZk/PMApHzznUNFTdsZ//TIET7eNEI9INm344ibmPsWoUBfbv1EGQvkaS626BmvwECcQxgmNM1ikNr9DS60DBZNvWzSsK7XDbL16L0Sn6e4b9egtB3jtHRuvwFvIsz0A0KT2ouqDXSY7m6T+CmHXkBnjjFMYJbmQNSBJp6J+fwVqnXVCcK1AuvFa+ibvJOF7B941ZSbJ6dwKqOMPyvvhKvCcRfo6IG1l0DJeOquDXQiY78RC4EDaarS+pzXMPWt8FbhtiyaFxQ0Af2LNBSS9LANXLEh7wkQNUWlJvFxAGJEbhke69d9CKwRWU5N+xlkqq6VuwQoYPi2p+ckRAc61uv72J5JhOse0D9tSY5dMjsVK/uDmGs8x+C1RxEQ4iu1hNIyJpUI+py5AOrE8ISXT89ugO0p2PXyxgtivpmCqdK1JLa5ZUTVJYSjM/uAauqeY5VhVvNQEOhsJ38Mruz0eolRnnE2/EvxliPNo4BV5wYduMgWBf2iDyS7J4WFh/HOk9zblqURXyiBOuaC3JmPjA+WglH2fZHPLNAmL+eCW3rIo9/M9AvoOT2AmNpuZhfB7rCLZ0WevGyqWIdcqF4snUWjhwZVSqdc6RHE0FIfDcDGpOoizj4PWUkGYK5YbCyFRF71qMWOdOADSy4c2DwK3Z69Us=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnlxNUZYWmU5Tjg3OTgvdmM4M1U0TFB1bHhwWGtKSHoydG1KUjFwUWR5bEpL?=
 =?utf-8?B?Q3ZHbjFXVjl6VXA3VE9Fd0VPcUhqblZXNFVVK1RmdzJoTi85bmF6ZE03VWpj?=
 =?utf-8?B?eTBlOWV5M3R3V3VZWXVQckkvRE5XQkpOTEdHdEtNNlU1cnZBYlFqRng5SXor?=
 =?utf-8?B?VXJCVGVWOVczWnFXZmpvVWwyOFFSRDM0Q2NvTzYzWXRIYUthMWdDYXBWYVJR?=
 =?utf-8?B?QUo0d1cybkhFQW5jUjNWcWtXNFJsa2t1UUFmV1ZPcUpiN2RSQlkxYWdaVUpY?=
 =?utf-8?B?bi85VFdlMGJ1UHNrcUNJSU8wSWhCbWtBaTV3VWt5S0pBWjRmOU1nTE9mOXhR?=
 =?utf-8?B?ZHJ0RWtwT0pIYzM1L3FMcFNZR3BsU0dYbDNmakJHeFdwVWhsRk5zZzB3c1hs?=
 =?utf-8?B?ZnVjTkVsYi9PSnZFL2hJcDJJeTNabTNZbG16YnM2YU01aCtZbTMrbEV6ZU5s?=
 =?utf-8?B?RkxmaXJmaEs5YWhBL1ZZdUREVCtKcm0rVSs4SllSTGNtSVpTelRWclNwc2E3?=
 =?utf-8?B?RWNIZXhCTi9VUFllZDlXOG15QlNrWGRETWZTUTlLNUtOU0RSRFJQVlVuN2NQ?=
 =?utf-8?B?WlJrV1M3OGJrbmZhbnRQeTV1WnBDR1RJSXI3TTRwZW9mTlk0TTZLUHI2dmxi?=
 =?utf-8?B?MWZTUmdxKzJ5ZThQQUxjYTJPYjkxOGFkdk5IN05EZWo4amxoS2NJK3FnYXkr?=
 =?utf-8?B?Nk1OZGpHZGhRRHlNSmUzTEoycHVpVGJtU1RTU3hUN1lPa0sxZHhRUFNwU1JF?=
 =?utf-8?B?Z3ZCc2xlSWNHc3Q0TUEzTnV4SVdyVVQyWHpGbzhCbXhxcldKbm96cG1RSk5R?=
 =?utf-8?B?UWtnOFVEZlJpWXhCbE84QWwvRUhTdURSS2lZT2J6UmhTbjhHbTY0TFJYVmJO?=
 =?utf-8?B?bk5MOHJ0SUpWbmxSWGJzSFRJZmNSRjB5ZGp4Q01nOWNqSmZLeVg4OHEyRUpw?=
 =?utf-8?B?c0orRVVlZUVsT2h5ME9tM0NaT09nWGtoTUJ1aXN1d3Q4ZEtQckJib2lZOExn?=
 =?utf-8?B?dDZHaHpZM2FFOTltVFVNUXVvYVUzUUc1dlJ4b0g4QWJYd3ZzWmZ0c0FLRmhq?=
 =?utf-8?B?MHdMMFFFOTNUcnlKVUwrVmxhamdiS1JHQllIYkZ3cW5Ja0JrZDZTd1BVOEl6?=
 =?utf-8?B?UFd0UGNoV1JEWjNIU0RyTmhzdmlnR05EanhiczhzbENRQXlqRzdiQ2RHZm9V?=
 =?utf-8?B?NS8rVkZLeUNIVzhJNUlWYWVHMVZUcnZBMG56Wlk0OXZHYjllT3FTd3Q4QVZa?=
 =?utf-8?B?V1I0MHBYSFN1eTlQeUdLQWREUUEybnc1S2ZKcnFaK1JpaHpUUkQ3TURhcFRB?=
 =?utf-8?B?TGlZZitCSW10SzBGU1hhb2EvUmRMSjVXanNIVHpzaS9iR2h6TlltbjVvblZ2?=
 =?utf-8?B?cFdGcjRXTXRXd2YzdmlQNnQ5RDJiVERxaUtaY0JEbzh5dWIyd0I3dGV3dXc4?=
 =?utf-8?B?WVZHdHZQSmU0a1BwL0QyeHVMRXlaa3ZZRmk1UFB6Q2tNZldUNkpaZHB5OVBW?=
 =?utf-8?B?L0xFY2ZKbHJwZWNyZjBXa0F0VDNuSnEyR2hFeVE2bWtUUzhmazIrMnNvK01u?=
 =?utf-8?B?QzRLRzU1dmtjbWREcGFtaEYxSEJHMFBzb1dnT1Q1dWxWL2dEeVU5b1BWcktB?=
 =?utf-8?B?VlFmeFNJZFhka3YrUzRFV3IwRHRzVERwbk83eWcvUEt0L2h5TkJtaEdPaTlF?=
 =?utf-8?B?b0JyM2xvOXMvcnlpNWJDRmVnbXg1TlpUbDJ1THJsME9LR25JSko3SWMxbEIx?=
 =?utf-8?B?Z0Y2UVkyRUFzak5tQkZMQkIvbFhZZkYvRERlMjY0eGcrQUFxeE0ya0pEaTRQ?=
 =?utf-8?B?d08zZTVMVHhudjY2OFNKMWFnRFVWU0xnOVFsT284QmRTYWE4YkNYVlJWN24z?=
 =?utf-8?B?aXRUbys5Y1FpNmRyZFdJcS9CWHozcUJ0NGQrSmxKS2xyMjljVzVneGdaNzVV?=
 =?utf-8?B?WWdlbjNqa09NQjgwMVhMcGxVMWNxSDRuWjczZTVoN0wyUHZTV1Z2dWEzRzJU?=
 =?utf-8?B?dHdBQWNIbElZWW9LRXZFNW9UU1VTaE02TU5SSUppc0xHU09LbWxPMkR6N3or?=
 =?utf-8?B?cGp2N0NNYm51eFlMVmJrTjlicE9sekFnbzM4KzR0aWdFeGZpZTVBNEJndits?=
 =?utf-8?B?UmRsSHgrRXM0UjZLV015Y2QwTUNhaXAybTdLZndrelBVcG1VdmRuMU5ybksx?=
 =?utf-8?B?Zk5aTjJod1VuWHFmWTk0MGI4VnRKcEowdXpKQVZWQ3U5QlhuV2w0YW1OQzhR?=
 =?utf-8?B?Ti8wL1RETlNPUWpHdDJqRU03TlZwRWpmM2lnK1RNQnlaNUFXQks5MS9CS1BU?=
 =?utf-8?B?ODIwUEFNSFlPcmdXYnZtZ2lpMnd5UG03YkhyaWxqQkZZa2w5VDdKQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d9ac16-ab9f-4b57-0e0d-08df1d665fa5
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 13:42:43.9542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQS8GW/LXTLvO8glG1fuou1ah+ywe79pzT9wWZz8nxQVoMQ/RUhBiW3pst4Zbt2jpUM1JIIsuamsoMaUds5tHyDfCvvV8KdPKQ7DQNbgKck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10924
X-Mailman-Approved-At: Mon, 28 Sep 2026 17:04:44 +0000
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

Hi Alexey,

On 7/31/26 7:10 PM, Alexey Charkov wrote:
> Common code calls into a platform specific function to determine whether
> to attempt OS boot in Falcon mode.
> 
> There is currently no platform logic to drive that decision on Rockchip,
> so attempt Falcon mode boot whenever it is enabled in the configuration.
> 
> This can be overridden by board code if needed with appropriate logic, such
> as checking for a button state to skip Falcon mode boot when pressed.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   arch/arm/mach-rockchip/spl.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index e989c148079a..54dec06737e1 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -153,6 +153,35 @@ void spl_board_prepare_for_boot(void)
>   	cleanup_before_linux();
>   }
>   
> +#if CONFIG_IS_ENABLED(OS_BOOT)
> +/**
> + * board_spl_start_uboot() - decides whether to boot the OS or U-Boot proper
> + *
> + * If Falcon mode (direct Linux boot via TF-A from SPL) is selected via config,
> + * try booting to Linux first, with automatic fallback to U-Boot if it fails to
> + * load. Boards that want to implement conditional U-Boot/Linux selection logic
> + * override this, for instance to look at a button.
> + *
> + * Returns
> + *   0 to boot the OS directly
> + *   1 to boot U-Boot proper
> + */
> +__weak int board_spl_start_uboot(void)
> +{
> +	return 0;
> +}
> +
> +/*
> + * This overrides the weak default in common/spl/spl.c, so it must not itself
> + * be weak: two weak definitions of the same symbol would leave the choice
> + * between them up to archive link order.
> + */
> +int spl_start_uboot(void)
> +{
> +	return board_spl_start_uboot();
> +}

We have a board already defining spl_start_uboot(): 
board/amarula/vyasa-rk3288/vyasa-rk3288.c. It would be most welcome to 
migrate this into board_spl_start_uboot() instead so that it works as 
intended. According to 5d94ebedcd19 ("rk3288: vyasa: Add falcon mode 
support"), they really wanted to support falcon mode on that board.

Unrelated, but I'm also skeptical of

   #ifndef CONFIG_SPL_OS_BOOT
   int spl_start_uboot(void)
   {
           return 1;
   }
   #endif

in common/spl/spl_mmc.c. It was added in commit 339245b70d40 ("spl: mmc: 
remove #ifdef CONFIG_SPL_OS_BOOT check") but I think it's not the best 
today, we probably should migrate

if (!spl_start_uboot())

to

if (CONFIG_IS_ENABLED(OS_BOOT) && !spl_start_uboot())

and remove the spl_start_uboot from common/spl/spl_mmc.c

I did a quick test with odroid-m2-rk3588s_defconfig and it seems to 
compile fine with the aforementioned changes but maybe I'm missing 
something.

Cheers,
Quentin
