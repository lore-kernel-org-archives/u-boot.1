Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DFAC48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 17:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF49588097;
	Thu, 22 Feb 2024 18:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="mKqXvVDw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="j9q+SYM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A042A880A9; Thu, 22 Feb 2024 18:29:33 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970EA88087
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 18:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=NV6kKyfGLbNgt9Oa7TZGD6KrCfkQrr6L4IcLRsrY5D0x9rG8zTsRERSg9/QsyLvBxaZfPTpB/KKOfCDEsvVeSdhyR9vvawRO/hw2mljzwK+hRyxHG6IJjNxsaSUuvWfYNbjWC187MJGfo6LO+H8bR6TPIPtqSWtHHO8/5MoohEYBiXh9XfX+LAEGGi2b2hqZbhwzGRhds/25Ha2XxnMM6zxY/ROfM+r18XbAeyBCsaEZv2pxCHw/wECinHMqiqBqm/RKjIP2peWypzkE3Z9a606J3bCiD4U+OJruOf+WLnr6+7XdNx5R2bZpZlzlBp866vzPj/v/j9g0CpGPCU0ReA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg1nGX/snBFz/iE7M8NZ+38HIfscb9VqttS5IYYDdvk=;
 b=Os15rnXhT+c+EfVNwDoGuRqTGkgOzaKtUTs2rvWXpebRZ73NgBt4de6iXebHOMOZO4XvwHY645hbOT2Xe1/aNN2CkbvSYvqDROawCouSCSyPpdyiBBIzt5fyAOMU6ikiLRGMLhan/8AG8cf4DslNi2EJnFGbgeIULUl5NZFzX4o4QRkmyYBhW7Smx6DuWjcC0Wu9cPKk7Q2g3cH9rToEhJNcaHPxs4Q6bttX7G15+V37UGujOdsczwWVRUywyPS6k6JqXBmfROcwVpNc6cPiv9lYOnQX+m7eT1mM1yiJvhVH2cjFqMwLIZk1wDot+vnAmk32O9EOYAJ0FIoV3PDXpw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg1nGX/snBFz/iE7M8NZ+38HIfscb9VqttS5IYYDdvk=;
 b=mKqXvVDwCRJpRRCYMNt1XY31FfvuBAWgQ8qznYGlqVXf88lRZwQXUCHqRUAvPfbLrqfqlWeRfeP6Hi2Rju0ngum7xMB5kJUbA2r/fwjb/Me9UvOH/VHSNfLSoY4eEXNe8f49eVlgv7JactLakh8neDtGNpDN1stk7IPasq3GNGCh1XlZ2IhzFNKH4BO+M0Lgss5yDvBJjB7NCSQtAWNMQChibT0XIP0BrsjEm134EI+mFDPE/GhEFKgeZkqPh+L/1ur7ky2H8UMXCvIt9mRjI1CE3PNO2Cbwa1zzgeFinJ773dcpwcjRuO+6GkfRlgnNkXU8Vc/hjf/qZDu0rg5avg==
Received: from DB9PR06CA0025.eurprd06.prod.outlook.com (2603:10a6:10:1db::30)
 by DB9PR03MB7625.eurprd03.prod.outlook.com (2603:10a6:10:2bc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 17:29:28 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::6b) by DB9PR06CA0025.outlook.office365.com
 (2603:10a6:10:1db::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 17:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.81) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 17:29:28 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 1E45720080F8A; Thu, 22 Feb 2024 17:29:28 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (unknown
 [104.47.11.232])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id EB2922008006F; 
 Thu, 22 Feb 2024 17:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lyu4iXNeu61C8Urcd1FMaVWIzI9inBhtrjDWGsl9VM1MoclH+yDgKohRGQj0Jtw1MS7qaRwkEoousS2FXa6Y9CI5jEY/usm6qxu7HIgt+x/Au+/bPsusF1wKo/ZnGCjVNLz9RkmVsXaKVbWb1aRQnimnKimGJt2Hjn5yAgtdxvooSPNPXeQwvPsjbegFbeCoPPHOqXyIf3Rm6igHB+kGKzn6AHAuJ4/IPVoLo7v4mVNFYVRinpchyZIHCmwFPVSzuPNaIF0XGXWUqFJ2qGPe4an4AkvDmlFxxEuC5btBDsFVSw6hv9CAe666VgeQ258ukhkM/wLha602TP4CImBESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiyV2Uv4+015zgjB8YNbtTXzbA+kSGX6gJ0fwdRRpKQ=;
 b=EcpEXDGR22hJqInDA7GeuOAYzoMjwn8lIP+4oE1a8DRdgiGV9uds99vCfCbQ467f3hT4zNCzStu9YAT66qyF3Ilv9dWgUEiYJD2C7uwI/zMejzp0/4tynRYUYB+XU6fY5t/FqRDzEdMLRsjTOBHl+/ejziqZBRHY+6nV90AJ1k0ze/ueoqStQvRcwzMfI3KtYatdPxboTbv9E1DP6fBnlofnzx/gXr5RAEZz8E36oUEvtExTHyGh+JwmdEiRYGMOCrW4yNrtKAl5sGvK/Nc9Nl6cmcgkf+AZGEaeR9WYnXHHH5AgJJyKywDvMw4ov73DQJIhsbVLBXZtdcj7d8eWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiyV2Uv4+015zgjB8YNbtTXzbA+kSGX6gJ0fwdRRpKQ=;
 b=j9q+SYM27UoCx0+HV8c75fH7xB5AZJPP2vPwC+D2wEiO7G0f1I62z4k8x6yypYwZSzub0HUlrQBTWXqTjSFtcIeERtp+4QRxbCW3E+OIfAM6qOmX1UAl/4vjUS02Kh8zI8bBx3F7qD/8IcCuK3jmEwEeyeapGVEdeCAQggRWscxxNUk2OXNloH+PQmQKVrfL2fMd9bGbfxe78XI8Vk75MOBqSa9NtND5a2wrOQ6NaAgl6133QZpu8jCQnMnJS10WEmDPPgszaZLdLavjb6yisKNk48eP5uqZyd8vw2AV5niaG4rNSdwMnSdyXVswfDj+Kpr0cU4uD2j0dEw6sCXUpA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by GV2PR03MB9450.eurprd03.prod.outlook.com (2603:10a6:150:d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 17:29:22 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c%7]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 17:29:22 +0000
Message-ID: <1fcd5dc7-7b44-44b8-a3a8-0e8f562911b2@seco.com>
Date: Thu, 22 Feb 2024 12:29:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
 <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
 <326f67f9-a6de-42e3-a2fb-9d649520557a@amd.com>
 <0ab35778-ae8a-4eb2-a021-ee8e3a9815be@amd.com>
 <4a2e8e89-36e3-4e58-9f14-2151fc907081@seco.com>
 <8561797f-3b77-44af-849b-faa555e244bf@seco.com>
 <5816ffd1-4105-49b9-8026-026a4195fa00@amd.com>
 <84443f0d-817c-42d8-a70f-f656e6ce79b9@seco.com>
 <769ad987-fdef-4edf-adf8-96f8acee63e3@amd.com>
 <05c38e6d-e9bd-4bf2-a1a1-93ddc5c818c4@seco.com>
 <e4913460-077d-41c9-aa9a-c4b2b6f5bfbb@amd.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <e4913460-077d-41c9-aa9a-c4b2b6f5bfbb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0102.namprd02.prod.outlook.com
 (2603:10b6:208:51::43) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|GV2PR03MB9450:EE_|DB5PEPF00014B9C:EE_|DB9PR03MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 379772b8-af99-421e-bd5c-08dc33cbd2a1
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yVnDPc6y91ALce7J8ZplTPwEIF1mxkljh5x6sF7Ov9O2eD+5pvBGNr9A0t2cHg/oRnAT6+qAMnJg+AW+xzRDPw1dOjrTms0cAuUdvZC3iRNn/yBLU8nQJWVY1ocOfAUKw/z5aVvvghOTxofxsPL81SKIEF7Jv92swJwP3F27Kpz8Xjj60W+9Lka8fZpmoVrwWRwYcbX2P6nKyUsDA/evw0lqxMqZgeSronUZch7v/X8dI9BUsRXOZ8vT3irh/AbYHXCDvvhTlQpikEv+/O9AXA4PtxUF3GHRdP4gIoQgg3MOtPL8kSUKEPoyIdONN9DVEEFxMtQxWrOjEo7f55BSiJyTsox5Uz0heZg8ZqBCyTuCicgaZiVJZomyZ9XWUudsy41veVbJrN4bs4SpPJcURlpDZ967S2HrJBMvrrulfbgHWNnfxdUp9N6hykF6qkAM5cZYjKWm06H+HgWiGTxj2Zag6LE9l+wuEhDVFVyfWCPukyh8bJYmEfAKPzJxHCxE9epSUYDbdT2uAaHNjs4QHfZmbgQkvz3Y7hAALhew0ponysApVskTd6fOEZsLaZqs1DmXrtqxyHNyeWWZVVgWRi+15O+z5oNjEJQayRysvp4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230031)(230273577357003)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9450
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c8bba996-c297-41eb-88c9-08dc33cbceb1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZyDEeE2KipEhIWesbkjl1sg1kgGYu2tKgxrlwxmU2sL3HkHQOesutPsFn/AlZjVCNjxrv9Ael7fPQG0wH3ecvEVOnI9DoYBhqv9SItsqz8aT8/VYycmYNMaHSd1S+py9i+D5jtGCUeak04qudIVx7HXQR6R7NeOagyuFFKf6D+RCkCsi4g+tt9kwiZNKSpAgq2IWHbKkGUqQlXkuXjf5bNI2mx43r41QcBt6BuxZnCOG2GR5A/bvdgyOShurlQk+TyiMUvR2sdtnMXa9+izNmNYXTycb8JMlZyjFBXlo+lQ9grAPBj5S6zsSmdmiEpCS7NQ12mJIkD+Y8Z4KmTPop2+ZAOiwNdLtoeozhq6u6htDq4JgqWLDRbO4xqoTi/MmN8s8a95vCIKwcP2DwobyZqrYjl/iynBVzhSE0Vc+z8+U9PWBoObH6CriXPQij9BHBLMaaou5eMA4GuuZUmIH0pr+8ICQk0PaRaONxek4Untvm+a0vgU+tby8g1C9u2VTkfsLsC0KBD4babEMHY98PL+nzHPXdVVFV9xsvd6bYLuJv167Nl+7ozmo6jtGAcAQ/nY7O21Auc9JV1xV3Rw7j3Gr8jbhLqNv2X7DfBoSj/AxI4Zk60e6sSfZJQEbvlSgRKzUvflatmwIaNmddDLZg==
X-Forefront-Antispam-Report: CIP:20.160.56.81; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(40470700004)(46966006); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 17:29:28.4179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379772b8-af99-421e-bd5c-08dc33cbd2a1
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.81];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7625
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/22/24 05:34, Michal Simek wrote:
>
>
> On 2/20/24 20:30, Sean Anderson wrote:
>> On 2/20/24 14:18, Michal Simek wrote:
>>>
>>>
>>> On 2/20/24 19:43, Sean Anderson wrote:
>>>> On 2/20/24 13:24, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 2/16/24 17:09, Sean Anderson wrote:
>>>>>> On 2/16/24 11:03, Sean Anderson wrote:
>>>>>>> On 2/16/24 10:06, Michal Simek wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/16/24 14:48, Michal Simek wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2/15/24 20:31, Sean Anderson wrote:
>>>>>>>>>> On 2/15/24 14:08, Michal Simek wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 2/15/24 18:19, Sean Anderson wrote:
>>>>>>>>>>>> Currently, when we boot from JTAG we try to boot U-Boot from R=
AM.
>>>>>>>>>>>> However, this is a bit tricky to time, since the debugger has =
to wait
>>>>>>>>>>>> for SPL to initialize RAM before it can load U-Boot. This can =
result in
>>>>>>>>>>>> long waits, since occasionally initializing RAM (and other thi=
ngs in
>>>>>>>>>>>> psu_init) takes a long time to complete and the debugger must =
wait for
>>>>>>>>>>>> this worst case.
>>>>>>>>>>>>
>>>>>>>>>>>> Support semihosting if it is enabled, as it lets U-Boot tell t=
he
>>>>>>>>>>>> debugger when we are ready for the image. This means we don't =
have to
>>>>>>>>>>>> wait any more than necessary. We don't change the default conf=
ig to
>>>>>>>>>>>> ensure we don't break compatibility with existing debuggers th=
at don't
>>>>>>>>>>>> expect us to hit semihosting breakpoints.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>
>>>>>>>>>>>>       arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>>>>>>>>>>>       1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp=
/spl.c
>>>>>>>>>>>> index a0f35f36faa..5af735aa5ce 100644
>>>>>>>>>>>> --- a/arch/arm/mach-zynqmp/spl.c
>>>>>>>>>>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>>>>>>>>>>> @@ -9,6 +9,7 @@
>>>>>>>>>>>>       #include <image.h>
>>>>>>>>>>>>       #include <init.h>
>>>>>>>>>>>>       #include <log.h>
>>>>>>>>>>>> +#include <semihosting.h>
>>>>>>>>>>>>       #include <spl.h>
>>>>>>>>>>>>       #include <linux/delay.h>
>>>>>>>>>>>>
>>>>>>>>>>>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>>>>>>>>>>>       }
>>>>>>>>>>>>       #endif
>>>>>>>>>>>>
>>>>>>>>>>>> +static u32 jtag_boot_device(void)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_=
DEVICE_RAM;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>>       void board_boot_order(u32 *spl_boot_list)
>>>>>>>>>>>>       {
>>>>>>>>>>>>              spl_boot_list[0] =3D spl_boot_device();
>>>>>>>>>>>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>>>>>>>>>>>              if (spl_boot_list[0] =3D=3D BOOT_DEVICE_MMC2)
>>>>>>>>>>>>                      spl_boot_list[1] =3D BOOT_DEVICE_MMC1;
>>>>>>>>>>>>
>>>>>>>>>>>> -       spl_boot_list[2] =3D BOOT_DEVICE_RAM;
>>>>>>>>>>>> +       spl_boot_list[2] =3D jtag_boot_device();
>>>>>>>>>>>>       }
>>>>>>>>>>>>
>>>>>>>>>>>>       u32 spl_boot_device(void)
>>>>>>>>>>>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>>>>>>>>>>>
>>>>>>>>>>>>              switch (bootmode) {
>>>>>>>>>>>>              case JTAG_MODE:
>>>>>>>>>>>> -               return BOOT_DEVICE_RAM;
>>>>>>>>>>>> +               return jtag_boot_device();
>>>>>>>>>>>>       #ifdef CONFIG_SPL_MMC
>>>>>>>>>>>>              case SD_MODE1:
>>>>>>>>>>>>              case SD1_LSHFT_MODE: /* not working on silicon v1=
 */
>>>>>>>>>>>
>>>>>>>>>>> Good timing. Can you please tell me how to test this? What's th=
e setup?
>>>>>>>>>>> Which debugger are you using?
>>>>>>>>>>
>>>>>>>>>> I am using OpenOCD with the patches at https://cas5-0-urlprotect=
.trendmicro.com:443/wis/clicktime/v1/query?url=3Dhttps%3a%2f%2freview.openo=
cd.org%2fc%2fopenocd%2f%2b%2f8133&umid=3D6e1be473-0b3f-4bc4-a4f0-403592e74b=
af&auth=3Dd807158c60b7d2502abde8a2fc01f40662980862-afc15b07b0f91c910f832185=
958363d84f990a08
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I am trying it on the top of the latest git but getting issue wit=
h event block and no idea how to fix it.
>>>>>>>>>
>>>>>>>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi=
/digilent_jtag_hs3.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zy=
nqmp.cfg
>>>>>>>>> Open On-Chip Debugger 0.12.0+dev-01509-g6d288937cb2d (2024-02-16-=
12:22)
>>>>>>>>> Licensed under GNU GPL v2
>>>>>>>>> For bug reports, read
>>>>>>>>>         https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktim=
e/v1/query?url=3Dhttp%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=
=3D6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=3Dd807158c60b7d2502abde8a2fc01=
f40662980862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>>>>>>>> Info : auto-selecting first available session transport "jtag". T=
o override use 'transport select <transport>'.
>>>>>>>>> wrong # args: should be "-event <event-name> <event-body>"
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Do you know how to fix it?
>>>>>>>>
>>>>>>>>
>>>>>>>> I actually bisect it and found that it is caused by
>>>>>>>> jtag: rewrite jim_jtag_configure() as COMMAND_HANDLER
>>>>>>>> ea2e26f7d521f5755b4bfda7bf12d99650277421
>>>>>>>
>>>>>>> Interesting. I have been testing with 0.12.
>>>>>>>
>>>>>>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/=
digilent_jtag_smt2_nc.cfg -f /usr/local/share/openocd/scripts/target/xilinx=
_zynqmp.cfg
>>>>>>>
>>>>>>> FWIW after installing the udev rules I do not need sudo
>>>>>>>
>>>>>>>> Open On-Chip Debugger 0.12.0+dev-01512-g214206ebb972 (2024-02-16-1=
5:38)
>>>>>>>> Licensed under GNU GPL v2
>>>>>>>> For bug reports, read
>>>>>>>>        https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/=
v1/query?url=3Dhttp%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=3D=
6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=3Dd807158c60b7d2502abde8a2fc01f40=
662980862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>>>>>>> none separate
>>>>>>>> Info : auto-selecting first available session transport "jtag". To=
 override use 'transport select <transport>'.
>>>>>>>> Info : Hardware thread awareness created
>>>>>>>> boot_apu
>>>>>>>> Info : Listening on port 6666 for tcl connections
>>>>>>>> Info : Listening on port 4444 for telnet connections
>>>>>>>> Warn : An adapter speed is not selected in the init scripts. OpenO=
CD will try to run the adapter at very low speed (100 kHz).
>>>>>>>> Warn : To remove this warnings and achieve reasonable communicatio=
n speed with the target, set "adapter speed" or "jtag_rclk" in the init scr=
ipts.
>>>>>>>> Info : clock speed 100 kHz
>>>>>>>> Info : TAP uscale.tap does not have valid IDCODE (idcode=3D0x48e70=
126)
>>>>>>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x04=
9 (Xilinx), part: 0x4738, ver: 0x2)
>>>>>>>> Info : JTAG tap: uscale.tap tap/device found: 0x5ba00477 (mfg: 0x2=
3b (ARM Ltd), part: 0xba00, ver: 0x5)
>>>>>>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x04=
9 (Xilinx), part: 0x4738, ver: 0x2)
>>>>>>>> Error: JTAG-DP STICKY ERROR
>>>>>>>> Error: [uscale.a53.0] Examination failed
>>>>>>>> Warn : target uscale.a53.0 examination failed
>>>>>>>> Info : [uscale.axi] Examination succeed
>>>>>>>> Info : starting gdb server for uscale.a53.0 on 3333
>>>>>>>> Info : Listening on port 3333 for gdb connections
>>>>>>>> Info : gdb port disabled
>>>>>>>>
>>>>>>>> but with zcu102 I am still not able to connect because error above=
.
>>>>>>>> The same behavior with recording SOM IDs I see on kv260 (via hs3 c=
able).
>>>>>>>> It looks like that not everything is working for zynqmp.
>>>>>>>
>>>>>>> Is this with the boot mode set to JTAG? If so, you will not be able=
 to
>>>>>>> examine any of the CPUs until you have released them from reset. So=
 you
>>>>>>> should be able to run
>>>>>>>
>>>>>>>            targets uscale.axi
>>>>>>>            boot_pmu /path/to/pmu-firmware.bin
>>>>>>>            boot_apu /path/to/u-boot-spl.bin
>>>>>>>
>>>>>>> to boot a CPU. If you want to silence the above error, you can add
>>>>>>>
>>>>>>>            uscale.a53.0 configure -defer-examine
>>>>>>>
>>>>>>> to your config. So the full command would be
>>>>>>>
>>>>>>> $ openocd -f interface/ftdi/digilent_jtag_smt2_nc.cfg \
>>>>>>>            -f target/xilinx_zynqmp.cfg \
>>>>>>>            -c 'uscale.a53.o configure -defer-examine' \
>>>>>>>            -c init -c 'targets uscale.axi' \
>>>>>>>            -c 'boot_pmu /path/to/pmu-firmware.bin' \
>>>>>>>            -c 'boot_apu /path/to/boot.bin'
>>>>>>>
>>>>>>> Let me know if that works for you.
>>>>>>
>>>>>> Oh, and I forgot to mention, but if you are testing semihosting then=
 you will need to add
>>>>>>
>>>>>> -c 'uscale.a53.0 arm semihosting enable'
>>>>>>
>>>>>> to the end of that. I also find setting the semihosting base directo=
ry with
>>>>>>
>>>>>> -c 'uscale.a53.0 arm semihosting_basedir $IMAGEDIR'
>>>>>>
>>>>>> to be helpful.
>>>>>>
>>>>>> As you can imagine this is a long command line, so I have a config w=
hich looks like
>>>>>>
>>>>>> source [find interface/ftdi/digilent_jtag_smt2_nc.cfg]
>>>>>> adapter speed 25000
>>>>>> source [find target/xilinx_zynqmp.cfg]
>>>>>> uscale.a53.0 configure -defer-examine
>>>>>>
>>>>>> proc boot {imagedir machine} {
>>>>>>            targets uscale.axi
>>>>>>            boot_pmu "${imagedir}/pmu-firmware-${machine}.bin"
>>>>>>            boot_apu "${imagedir}/u-boot-spl.bin"
>>>>>>            uscale.a53.0 arm semihosting enable
>>>>>>            uscale.a53.0 arm semihosting_basedir $imagedir
>>>>>> }
>>>>>>
>>>>>> which I invoke like
>>>>>>
>>>>>> $ openocd -f my_config.cfg -c init -c 'boot /path/to/images my-machi=
ne'
>>>>>
>>>>>
>>>>> ok. 0.12.0 version is working better. I am able to load firmware to A=
PU but I was not able to load pmufw. It was saying timeout like this.
>>>>>
>>>>>> boot_pmu /mnt/disk/som/pmu_obj.bin
>>>>> /usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg:173:=
 Error: Timed out waiting for PMU firmware
>>>>> in procedure 'boot_pmu'
>>>>> in procedure 'resume_pmu' called at file "/usr/local/bin/../share/ope=
nocd/scripts/target/xilinx_zynqmp.cfg", line 232
>>>>> at file "/usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp=
.cfg", line 173
>>>>>>
>>>>>
>>>>> Then I looked at pmu and use below snipset which I use on xsdb to mak=
e it visible for debugger and also small waiting time.
>>>>>
>>>>>
>>>>> @@ -141,6 +146,13 @@ add_help_text halt_pmu "Halt the PMU in preparat=
ion for loading new firmware.\
>>>>>           This should be matched with a call to resume_pmu."
>>>>>    proc halt_pmu {} {
>>>>>           set axi $::_CHIPNAME.axi
>>>>> +
>>>>> +       puts "Enable PMU target"
>>>>> +       set val [$axi read_memory 0xFFCA0038 32 1]
>>>>> +       $axi write_memory 0xFFCA0038 32 [expr {$val | 0x1C0}]
>>>>
>>>> These should already be set. See table 39-3 in UG1085. Although I seem
>>>> to have a combination of 39-2 and 39-3:
>>>>
>>>>       > targets uscale.axi
>>>>       > # BOOT_MODE_USER BOOT_MODE_POR
>>>>       > mdw 0xff5e0200 2
>>>>       0xff5e0200: 00000000 00000000
>>>>       > # jtag_chain_cfg jtag_chain_status jtag_sec jtag_dap_cfg
>>>>       > mdw 0xffca0030 4
>>>>       0xffca0030: 00000000 00000003 0000003f 000000ff
>>>>
>>>> Do you see these values in the JTAG boot mode?
>>>
>>> That 0x1c bit are
>>> "Setting these bits disables the security gate for the PMU MDM and allo=
ws the PS TAP to connect to the PMU. All bits must be set to 1 for the secu=
rity gate to be released. (POR reset only)"
>>>
>>> This is enabled to see PMU microblaze MDM. But I expect microblaze is n=
ot supported by OpenOCD but this makes it work for me.
>>
>> Yes, I know why you set these bits. But they should all be set already
>> (see e.g. my output above). So I am curious if they are not set for you.
>> If you have different values for the above registers, then there is
>> likely something different about your setup which could also cause your
>> below error.
>
> I tried on different zcu102 rev1.0 and I need to have it there.

Hm, maybe you can try https://review.openocd.org/c/openocd/+/5578

It has a different approach for this sort of thing.

>>
>>>>
>>>>> +       sleep 5
>>>>
>>>> Part of my goal here is to remove "magic" sleeps like this so the boot
>>>> process goes faster.
>>>
>>> I get it. 5s is likely too much and didn't try to minimalize.
>>>
>>>>
>>>>> +       puts "PMU target should be enabled">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 set val [$axi read_memory $::IPI_PMU_0_IER 32 1]
>>>>>           $axi write_memory $::IPI_PMU_0_IER 32 [expr {$val | $::IPI_=
PMU_0}]
>>>>>
>>>>> With that I am able to test your patch but it is kind of slow.
>>>>> Max freq I am able to use on zcu102 is 2MHz which is far from 15MHz u=
sed by xsdb.
>>>>
>>>> I have been using the maximum 25 MHz speed without issue.
>>>
>>> Can you provide more details about board you use?
>>> I can switch to different cable or different board but based on
>>> your config you are also using digilent smt2 NC module (without USB on =
it)
>>> that's why it is quite scary that I am not able to run it at higher fre=
q.
>>
>> It's a custom design based on [1]. The carrier has a smt2 module on it
>> which is connected to the ZynqMP via the card edge connector.
>>
>> Regarding the clock speed, the datasheet for the smt2 [2] module says
>> the maximum speed is 30 MHz, but I use 25 MHz since DS925 says that is
>> the maximum speed for the ZynqMP (table 40). Maybe you are using a lower
>> VCCINT?
>>
>>> I will try different board or different cables.
>>> Do you know if standard xilinx cables are supported?
>>> This one
>>> https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=
=3Dhttps%3a%2f%2fwww.xilinx.com%2fproducts%2fboards%2dand%2dkits%2fhw%2dusb=
%2dii%2dg.html&umid=3D720e2c50-55de-40c4-ac09-1623b19dfef2&auth=3Dd807158c6=
0b7d2502abde8a2fc01f40662980862-1c4afab79eea13f4f1554e802b0609bcea3cc2f7
>>> or black version?
>>
>> I have not tried those cables (nor do I have them on hand). I have used
>> the smt2 as well as the hs3 dongle. I also have a J-LINK, but I do not
>> have an adapter cable made.
>
> I have seen it working at 25MHz once but it is not stable with the same d=
igilent module.
>
> Anyway please fix typo in subject and rebase it on the top of current mas=
ter branch because it can't be applied and patch is ready to be merged.

https://lore.kernel.org/u-boot/20240222165230.2600974-1-sean.anderson@linux=
.dev/T/#u

--Sean


[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>
