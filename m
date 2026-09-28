Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D516CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5296280EC7;
	Mon, 28 Sep 2026 17:05:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 32G5aLFVwVzZ; Mon, 28 Sep 2026 17:05:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CC9B780EDE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790615101;
	b=H16F/ykLnr3iIOgU/D4h2PIhTA50o+/IS9qSrdUsx9i+RWEYQr7vjoC0oDtJ/6nBGo+b
	 pbWqvwE9blpGfmgXdQfamxFIK7l4IuUdqLg28SVW1GMqNGNgSqT1UfafnvRiwvY0RAPPC
	 7PWekv/JfNt44k+tiz1laWL6zgp7pZJWQoVSmdf08P/OBVUdRxSPk+iURgTKcM+5/XUry
	 bGHxKj0fBy8fzrbSuDQ+jbsiKtM8x+37VkL00QaYsRvU6jYRv84L71Uefl6oU6hHZFG3v
	 sfOrbv3wDtwApDES9hBDQjfCxst8HfLfiWgepIhtJolZBpyHP03ytJibxSLY2ZbZwVQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615101;
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
	bh=wca3ObUKDXUUZay2CGjlJhW4DdmYJ8D3N69NQq4GQKk=;
	b=Kc9wJJ6ukvA1cGuyV+QrD/1yjrw4+wqst6s7zHt37VYZGjXUCZQ7sAdY6tU3wuobILto
	 SfchecRdELS5NrGG2jln9MhlqKdT7FEakZZPocfcYjvQJ7pWcK5OXldNgOBxAnH2w2nrJ
	 DXqHrr6AoetQhKdGtXQ0pT+SgVOIk75M+oKVNZoQVwkg4zkKJPrKEv6Kx+8DWUi2iHrCN
	 f3tgIO1tMXQXZN1/v97WyccwIwYouz6348CftO2p38D2jBjcFWU5vo6LuyCfImCgxXZRl
	 IEuQ55zd2fQCfwzl607YGCmL0L3D/ZslvST7ECUGIzUpcCoYkN1kcANkeT57Tj6rRvQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615101;
	bh=wca3ObUKDXUUZay2CGjlJhW4DdmYJ8D3N69NQq4GQKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BlUIs2cpGzMuBVvsOXVyNz587DBlqDpf5ltpz4FuRkF9ubuVaoNi8+Dz4JWBGetBb
	 z4RNoisdo+q1XcWkJkdQguUfvdKD74KbG8HdVN2GB7lAvtfXbSn2C6/Aa++6Q03TNh
	 8xJKqV/e7Y9K4PYZ1RwQK44pwRE8L31c1uZaIjug3w4dHksCbmntvIjbntPqqRlxg4
	 Q5N1bwvrmOj+OXSgL6GJK9FIlln7j4gJNQ67ILThEzNVQsaUDv7iTrcwgxrQYdUBtN
	 lT9zZCy7QbKaCKoZu3Cm0hyymTvVfGkXp0EVGYhnxX4Gnf6wIlvpMBlMAm0XvzQbe5
	 ymusPW6xDoRCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC9B780EDE;
	Mon, 28 Sep 2026 17:05:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EA5FA422
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB844400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FbVkgAiKCfib for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 84FA4400B4
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790609594;
 b=rIyP/fSNG+ZCXNDIPw8LV//HFknuyb9y+hwjgcpbWps/qCC02rpg47V5Isk7cSbQou+K
 bSWHSyCQ4QYKiNRL85m84EvLVoSNVr2J4RgUrp7PEqX0TmbI0qS5kY9PHe4VBxn/i9Rlh
 IQrK9EMxyiTSlTMKvjmPNZVjUD0ambf+iRh8/Iqpt4Wm5l1j5HCckJ3a+8lLo0BAMyUB+
 /datSQ2w8YK/+q/IPx4nHKNTQbXhjVWCZLQqxntf6+K4WerDKbrqwSq8cofj74QsoQgHD
 VtghFYM/3nQXJSHXMoFyoqKfAy8vXP23+rNTCvTe0j+IKFL9pVuIYvt/AbOzBaN5RWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790609594;
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
 bh=wca3ObUKDXUUZay2CGjlJhW4DdmYJ8D3N69NQq4GQKk=;
 b=irgmFJy3Q6ZXB4rlGBzs+2Wq0mim/iZT8ADgksWmFLxw1Y/RZTjp76vQCglc7by5fzz9
 obhyDetEY97vPRtiZvZv2+mzT+wQBkgQl8Dfkwv5uMRqoh1ei8qtSIK1pTNvoAZm18PxP
 aHq/+jSBO+SBwSjVIaVQN1i4rOgkHtKuRI38GhWQZxZbDM7aP52ZMkgB+OUFyDlF2Cqbr
 8o0U3GAiK8ai3NGlRn54huGOFUPomfa/o/iVN8VcqB5qtrXiTBcWKV2MSrUE70xN0Jgk5
 R2GXkMOge6FxPfWD6LUuaJ3YVCwt/zihobNfo/TY+PpNMfBkHkCxRJTbt9mmRGVTrSA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=EqCMtbws; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=EqCMtbws
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84FA4400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAiZrGgnQxkitnRYexj8mrpVF2WVUdY0LTIPpazBl53Zxj+3NWkTAhv/vZJZk0fDdg5hZNvFBqDQa1OSJPVc5z2o91NvassqmiV7wwsPhmsexUduIos4QBa4xKskT3k4qKEbECQ5OKBLvfIXFnK3fENo/2V74A7kmPW/pnTmDhxaQ40LtzX7s99VMN3njs6nPeeHFCLPN/f2ryEK9CbT56gaJGI1ORJ4IxYx5XwCP8JOlSTkZnKdbchan7bNVS/WPLsjPVa9A+pP06p8aBxMLUFRe0xgJchxuJnyMKSHtoK/uc8VYAjjGgHbGY5pRT2yMv5V2DfW0wMqW2lMlDBsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wca3ObUKDXUUZay2CGjlJhW4DdmYJ8D3N69NQq4GQKk=;
 b=gnv6H0yOs/0uth7nXQ8q7JviQeyzoZYeAHTx1uTT4wz0+VaUVoUNsK/Xn66wQTAPsKtMLMko8M3aJrKJ1yiDi26KZbB6n6r+W+vaboTXc9s7RckggPTVFpK6zwqlZW8FZT2ecf5NX0zxc7AD629k3tz7fcxCCxTgEztmh+ywg2JP+KmsRQ5101ptcYGiFH/aSOaZySxDorZsHvi5Tf1ud8ba9NJcAzcdJ02yLKTv/Xrzn6FtuMx18ZLHMUh3njgevL5ehgmVyGDS/0gkO4jYID4rmrVAq2B9p/X79J322niiUL0INZddYbgnFB6XPbxMk/gCmtarKvEjyAGtE+a8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wca3ObUKDXUUZay2CGjlJhW4DdmYJ8D3N69NQq4GQKk=;
 b=EqCMtbws7/di2XF+IeEgIVRUgBxFO0v1IsJVSc36gGVOIXYCNpyPxrSjFSSYcSFKKEw/LuYQI0Dsa4qN8/ywZVQmxzB2Fb52Z/lIrFfujZVPytJUV9HyNDNlLnZih/SZ7zU5aCUtzVLCAF7NVY/TaMaCT7CecDE2Y7XoCsRN3DY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM9PR04MB8633.eurprd04.prod.outlook.com (2603:10a6:20b:43c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:33:08 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:33:07 +0000
Message-ID: <e9ac17e0-81b9-4d4f-8ab7-01a2837456ea@cherry.de>
Date: Mon, 28 Sep 2026 17:33:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] doc: falcon: Describe booting the OS through TF-A
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
 <20260731-atf-falcon-v2-10-acb97c172993@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260731-atf-falcon-v2-10-acb97c172993@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0078.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM9PR04MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9dcb28-84a1-4e1a-92cc-08df1d75cbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|5023799004|3023799007|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: m7gMQK4Z7PTt90+pqqwVhJc/1btQz1CKM1Clx4MMF5RyyO2PZgs6L05b3UL6pHytIF6Gg0P+8SS1B2aKj0Xiec2gxPaSU3mlSx+/2mFJrv8YGiTSKopmWHKR5kjHjNqlHk7QBdyqTToedBoTAryDdU3sTnQQWrnm7u1lbrNDCEkAwsqLlfXJsYAzEKrwTPgimon6IVIrpCpMsrqcFlUDhuenS4K7W+ePyQ8+xCKq1kdhsz5poS8ya5jCJnprg8E5U2Zqp3RrnYO5urubF9uh4x6j2jQwdc1l5p5tvJ7uTG3xMQAv7iOsjU941e3pCOLsyFcW4mtIjrUUVR1fRN580/EpzMu2eq87vAwibHHKCrj8LsBYXDQr24/0ODlWjiLAi+QLf6SZmMS3LgBtD9qvC04wOREjnZavH1B4peFABamZXW6e6nlM5QmM8aQLFKrL/jT6S3uyIWIvGnjLm6vxVCU4rOd9jzl7UN0wtwr/QQKDDib2i1ASbuOkkMQChOwak8JXIuri3t4mKj9Qvri2EW4qcY8V3535ELwi3X4d2k6y2zUYXNyErQkpeuA/8yA/VNWl/NqQ60ZZR1P/haoZcmp+na6q2lmzNz2jrGfnuj37AYiST4soXDrWmKRxjPeXVxiJM3AlAV0Pr+rSldcB0KCezZklHpZXZzXZCU5Vwwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFJeVI0UmIwSGVqMlNJejhxcjJxVzNlRGtnYm1Senllc3NFbm5kU3Z2Sy9P?=
 =?utf-8?B?NEpYajBzc29Td25pSTZ0ajR2blF0QkxicWJnVWxBcmhoRU9WbGptSTBrbkJR?=
 =?utf-8?B?RDdHdjgzUWdEYUd6c2pXcTl2NkdNbG1kb3JXbS9DMmtOK0lpMXhNcElzeEp4?=
 =?utf-8?B?SkQyUzV3VjZWdmhybjFXRXFLdm1DTVlMMlh4VlBLQmJKMStPOTd6U2RyNVNh?=
 =?utf-8?B?M3JFOWhOTE5zbmFwTzczaUhobGJRUE5xWU85OXlDT1IzL2JLMHhYcitCdVlk?=
 =?utf-8?B?MWg0bmVVaDU5akdWdWowREt3b3ZFWFRnN2lDdW1vTjl0RkRNTW8vcXNET2Vx?=
 =?utf-8?B?eDM1K3Vha2lmUy9zTGxIOWtnZEtFN2lrY2RzbEIzRWhYYkFsTi8yRVFaK2xV?=
 =?utf-8?B?WjF6bVhCdkY4NmI3SytOTXlsMmt2Q3JkRDR6d0FaaTNQV0UwV3R4UEh3YWdQ?=
 =?utf-8?B?Skc1Z0lPckN4RkRaQVZmbUNtb09CRHB3UnBNMkQydW1LcWR2cFZYemxvWEZy?=
 =?utf-8?B?K3FMaFJZbFpFbUhEZnhNeEVnRm1yYkZMaXlhdFNhaWYxalNVaTBPaXBWamY0?=
 =?utf-8?B?WjY5MzV6NVZWVkJxM21FcmhrdkEwOWU1TkNUdTg5RUhYSWNQamk1NVNqL2VU?=
 =?utf-8?B?TWtYZHNHNFA0czlFL0UvcHFZMjBLeW5XQ0VIK1R2c2h4eXkwWDhzOVRNQUJw?=
 =?utf-8?B?akpmelIrc2lUTjFTTEtQb3hEb1Y3eEY4VGFpVytteUx6azR2dEhEMkF1alBn?=
 =?utf-8?B?dHJqK09yY2lrdThmM0EyYWVEY1Z6enBwSlJ1Wk5CNW5QVkpESXExTjdMMXFU?=
 =?utf-8?B?S045Z1duZVM5SG9BWVk2VnJkREZ6NlRwTExranNDWURqL09TamVYbFFXVE51?=
 =?utf-8?B?VTNhd25wdTUycC92OTA2KzdOa1VOZGpzVDBsZ3E5cGs1aGovVks0N2VGc3Zm?=
 =?utf-8?B?cm9ZbERkbFVQaE1kakMwRmR2ei9NMHg5a1NnZU5TTjYvMTM4TmNLei9EV0hv?=
 =?utf-8?B?MDFPN3NXa3VhekZxbnhlR3M3ZzFYR1dCK0w3Nk9sRmlnOVh2RUNZdldObFNw?=
 =?utf-8?B?OXBRSTAzZXFYZTMvR2JqaWtZYjZMakFyTFB0bUh1RURPRHBGaExPa2JvQXU1?=
 =?utf-8?B?cUQ4bVVoNGgzSS9LSW40dy9GQkFwZkIwUTBvcUwrbXFDUHpLU2FTSkJFNjla?=
 =?utf-8?B?K2dpTndDT0ZtY2VIRWdyZGt1cVJsOERpMzBrVGtBNWpNdmxWQlJITEhwSXFw?=
 =?utf-8?B?Q3g0OE42MGdqRjI2MHc4S3lROHNQVGF4WVhYY3NwMzZpOEtMWjhPUjI5QTZB?=
 =?utf-8?B?cUt2dGRoT0VPc2FvdXk5a2k0MGovMzVKd1gzQ2NhYkRuQ1NIbnJQdTI1eSt5?=
 =?utf-8?B?dk1DWENubkMxbklwd1pySWg2RHpnT1FRSVJZVWh3NWZkWmNXWEJmRFZlWEFL?=
 =?utf-8?B?eGM0ZVZNejYwbTZsUm5DMTNyNG9PcUFXK1VZSStiaVIxZkZCL0IvaXl2N2Fw?=
 =?utf-8?B?LzVJOENUeWV2clcxVjhVK3ZqUnJzblY3Y05JMXpUbDlnbmgrYmJDYUhSN1o4?=
 =?utf-8?B?VlF6QTh6WHpsWUVwWTBLL2J5TmFKdlM3TnBrVG1TNm5abXhwMUJtamZYRGxr?=
 =?utf-8?B?QjFyZHR5dnppQTBvRURkcmIveW9yR3M5Vll1RVU2blVmaUQ2T3ptdC8raVBm?=
 =?utf-8?B?aFBtTzdsejJTY0hlMzllNkZpaU52TTBUUVFIQW9TZGUyQ1dzZElkK1B3Y3Zz?=
 =?utf-8?B?NE53WmRiZ2NEV2UrRStvT3dXK01pVTRuUTJpdGNZMTBhR2x3Z2tWQ0t0TFFl?=
 =?utf-8?B?UEUyQ0F6UWFIUkdxQWtZVkcxSXhEYWV5QW1iSkRuMjgwNzFjakFFa2ZPVUxr?=
 =?utf-8?B?dmNYU3cyWnloYXJzVkVqbHJzWXZGdzlPZjJ3MHlwSEFsbnJzYzhTaVVMbnlp?=
 =?utf-8?B?cG5WaEY4V004Y1Mwaldub0o3NmtaeFVaaFlWd01vOEpsNGVyb2o0R1BDeXRY?=
 =?utf-8?B?OE5sNlNNRkQrQ2FpRlFTMmNBTHVhZWZNbGJJdDhkYm4rS3I2TnRJNnVhOW9V?=
 =?utf-8?B?cHB0WkRicXF2dVJKOVdLTGo2bjVpcWlmd1pId2xEZkpVSmlkRm9VK1ZYNU03?=
 =?utf-8?B?M3F4WkFDS29YUGlVU2hoQ0JJazIyWUN4di8rT2VkeTZhb0ZNeS9IQ042Vkxo?=
 =?utf-8?B?MUlLUi9TSmVRUENIemRuYndRVUExa0xqdGpKOHZHa0FIeHRMUThRWk9MeU51?=
 =?utf-8?B?NjdpWUszMDlsRUFwanBadTdOZHlCQVRyYmZGSnJLZWszVGtCdjhtbW9qaDZI?=
 =?utf-8?B?WmlSRDZEN01LTUIydE1HZ2dGZlVzUXdPcG5oVERXM09YNVozYTdGQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9dcb28-84a1-4e1a-92cc-08df1d75cbce
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:33:07.8920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPx374JByj6cYGB32MOjnsnm1pcgfCjVxB4ZB7BvBmApdQ7ZVPMODKzRHnHLz5vPUsgtI87wUMUU7xl6lJCXnmfjlVUZmuJJ+FYx5vGQvVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8633
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
> Falcon Mode documentation only covers SPL entering the kernel itself, which
> is not what happens on ARM64 SoCs needing ARM Trusted Firmware resident to
> provide firmware services: SPL loads a FIT holding BL31 as its firmware
> image and the kernel as a loadable, and BL31 enters the kernel as BL33.
> 
> Describe that flow, what the kernel image may be given that neither
> booti_setup() nor bootz_setup() runs, how it differs from the classic flow,
> and how to configure and build it on Rockchip.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   doc/board/rockchip/rockchip.rst |   9 +++
>   doc/develop/falcon.rst          | 131 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 138 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de2df3046e28..42c47c51036f 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -325,6 +325,15 @@ To build rk3588 boards:
>           make evb-rk3588_defconfig
>           make CROSS_COMPILE=aarch64-linux-gnu-
>   
> +Falcon mode
> +"""""""""""
> +
> +ARM64 Rockchip SoCs can also boot Linux straight from SPL through TF-A,
> +without U-Boot proper running at all. Enabling CONFIG_ROCKCHIP_FALCON_IMAGE
> +makes binman build a ``u-boot-rockchip-falcon.itb`` holding TF-A, the kernel
> +and an optional initramfs, which are passed in with LINUX_KERNEL and
> +LINUX_INITRD. See :doc:`../../develop/falcon` for the details.
> +
>   Flashing
>   --------
>   
> diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> index 3fc23f65c458..f29aaee06a10 100644
> --- a/doc/develop/falcon.rst
> +++ b/doc/develop/falcon.rst
> @@ -95,11 +95,138 @@ Function that a board must implement
>   ------------------------------------
>   
>   void spl_board_prepare_for_linux(void)
> -    optional, called from SPL before starting the kernel
> +    optional, called from SPL before starting the kernel. Not called when the
> +    kernel is entered through TF-A, see `Falcon Mode with TF-A`_; use
> +    spl_board_prepare_for_boot() instead, which is called on every path.
>   
>   spl_start_uboot()
>       required, returns "0" if SPL should start the kernel, "1" if U-Boot
> -    must be started.
> +    must be started. It may be called from more than one place in a single
> +    SPL run, so prefer spl_falcon_boot() when querying the result - that
> +    caches the answer, which matters for implementations that are not
> +    idempotent, such as those sampling a button.
> +
> +Falcon Mode with TF-A
> +---------------------
> +
> +On ARM64 SoCs which need ARM Trusted Firmware resident to provide firmware
> +services to the OS, the kernel cannot usefully be entered directly from SPL.
> +Instead SPL loads a FIT holding BL31 as its ``firmware`` image and the kernel
> +as a ``loadable``, hands control to BL31, and BL31 enters the kernel as BL33.
> +
> +SPL picks BL33 in spl_invoke_atf(), which looks for an image with
> +``os = "linux"`` in the ``/fit-images`` node it appended to the device tree
> +and falls back to ``os = "u-boot"``. The kernel is entered at EL2 with the

Should the fallback be deactivated in case of CONFIG_SPL_OS_BOOT_SECURE 
is set?

EDIT: is it explained in the next paragraph but I would still mention it 
here.

> +device tree address in x0, as the arm64 boot protocol requires.
> +
> +Nothing generates a FIT holding both an OS and a U-Boot payload, so the two
> +are separate images, and it is the loader which decides where to read from.
> +In Falcon mode it tries the OS image first and falls back to the U-Boot one
> +if that cannot be loaded, unless secure Falcon mode is in effect, in which
> +case there is no fallback. For UFS the two are addressed by

Would be best to repeat what "the two" is representing here (and you can 
then use "respectively" instead of "against" which I find more readable, 
but matter of taste).

> +CONFIG_SPL_UFS_RAW_OS_DEVNUM and CONFIG_SPL_UFS_RAW_OS_SECTOR against
> +CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM and CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR, so
> +they can live on different logical units, at different offsets, or both.

Yeah, that's implied by having two separate sets of variables, I don't 
think we need to be that verbose.

As a general feedback, I'm thinking ideally it would be best to have 
this in multiple patches, whenever you add a new feature, update the 
docs to reflect that right after (or if allowed by U-Boot custodians, in 
the same commit). I don't want this to be a blocker but I think it'd be 
good to have.

Cheers,
Quentin

> +spl_invoke_atf() then hands over to whichever of the two actually loaded,
> +which is what makes that fallback work.
> +
> +Pointing both at one location is also possible, and is what the defaults do:
> +only one region then has to be reserved, at the cost of having nothing left
> +to fall back to.
> +
> +What the kernel image may be
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The payload is an ordinary FIT image node with ``type = "kernel"`` and
> +``os = "linux"``. SPL copies it to its ``load`` address, and BL31 enters it
> +at ``entry``, or at ``load`` if no entry point is given.
> +
> +Neither booti_setup() nor bootz_setup() runs in this flow - SPL does not
> +enter the kernel itself, it only places it in memory for BL31 - so there is
> +no inspection of the arm64 Image header and no relocation to the text offset
> +the kernel asks for. The addresses in the FIT have to be directly usable,
> +which for an arm64 ``Image`` means 2 MiB aligned, and clear of the device
> +tree, of the initramfs and of every region BL31 and OP-TEE are linked to run
> +from - each of those is split into several regions when it is supplied as an
> +ELF, rather than occupying one contiguous range.
> +
> +The image is loaded verbatim unless CONFIG_SPL_GZIP or CONFIG_SPL_LZMA is
> +enabled, in which case the FIT ``compression`` property may be set to
> +``gzip`` or ``lzma`` and SPL decompresses while loading. Two limits apply
> +then. The uncompressed image has to fit in CONFIG_SYS_BOOTM_LEN. And the
> +compressed one is first staged at CONFIG_SYS_LOAD_ADDR, so that address has
> +to clear both the region being decompressed to and, when the FIT is itself
> +already in memory, the FIT: booting from RAM reads the image out of DRAM at
> +CONFIG_SPL_LOAD_FIT_ADDRESS, and a staging buffer landing inside it makes
> +the copy overwrite its own source, which shows up as::
> +
> +    ## Checking hash(es) for Image kernel ... sha256 error!
> +
> +The device trees in the FIT
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Each device tree in the FIT can be pre-patched at build time with a
> +``/chosen`` node holding the kernel command line and the initramfs location,
> +so that nothing has to fix them up before boot. See the ``fit,bootargs`` and
> +``fit,initrd`` properties of binman's :ref:`etype_fit`.
> +
> +Differences from the classic flow
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +* The device tree comes from the same FIT as the kernel, so no separate
> +  'args' file is involved and CONFIG_SPL_OS_BOOT_ARGS is not needed.
> +
> +* CONFIG_SPL_BOOTI provides an entry path which is unused here.
> +
> +* Because U-Boot proper is never loaded in this flow, SPL panics rather than
> +  jumping to CONFIG_TEXT_BASE if neither a kernel nor a U-Boot image can be
> +  resolved from the FIT.
> +
> +Neither of the first two defaults to y when CONFIG_SPL_ATF is enabled, so
> +nothing has to be turned off by hand.
> +
> +Example: Rockchip RK3576
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Set the following in the board defconfig::
> +
> +        CONFIG_SPL_OS_BOOT=y
> +        CONFIG_ROCKCHIP_FALCON_IMAGE=y
> +
> +On a board whose SPL can load from SPI flash, CONFIG_SYS_SPI_KERNEL_OFFS
> +becomes visible and has no default, so give it a value suiting the flash
> +layout even if the kernel is loaded from elsewhere. The load addresses of
> +the kernel, device tree and initramfs default to offsets from the start of
> +DRAM which clear BL31 and OP-TEE, and can be adjusted with
> +CONFIG_ROCKCHIP_FALCON_KERNEL_LOAD and friends.
> +
> +Enabling CONFIG_SPL_LZMA or CONFIG_SPL_GZIP additionally compresses the
> +kernel in the image, trading some decompression time for a smaller one - for
> +a 30 MiB arm64 Image, roughly 35% of the original with LZMA and 39% with
> +gzip. Note that this compresses U-Boot itself as well, since both use the
> +same setting.
> +
> +The kernel and, optionally, an initramfs are passed in at build time::
> +
> +        $ make BL31=.../bl31.elf \
> +               ROCKCHIP_TPL=.../rk3576_ddr_lp4_2112MHz_lp5_2736MHz_v1.13.bin \
> +               LINUX_KERNEL=.../Image \
> +               LINUX_INITRD=.../ramdisk.cpio.zst
> +
> +This produces ``u-boot-rockchip-falcon.itb``, to be written at
> +CONFIG_SPL_UFS_RAW_OS_SECTOR (or the equivalent for the boot medium in use).
> +Its default shares the region with U-Boot, which suits Falcon-only boot;
> +point it elsewhere to keep a U-Boot image to fall back to.
> +
> +With CONFIG_ROCKCHIP_MASKROM_IMAGE enabled, an equivalent maskrom payload
> +``u-boot-rockchip-usb472-falcon.bin`` is built as well, which can be loaded
> +straight into RAM::
> +
> +        rockusb download-sram u-boot-rockchip-usb471.bin
> +        rockusb download-ddr u-boot-rockchip-usb472-falcon.bin
> +
> +Rockchip attempts Falcon Mode boot whenever it is enabled. Boards which need
> +a runtime choice override board_spl_start_uboot().
>   
>   Environment variables
>   ---------------------
> 

