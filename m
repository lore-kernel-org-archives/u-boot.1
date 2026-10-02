Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6DACA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF465810EE;
	Fri,  2 Oct 2026 14:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lwm823MzVwrS; Fri,  2 Oct 2026 14:17:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2053280E31
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790950662;
	b=F86kJZmcC7o54xVgoo++jHnObA7FlRK1HgMPLiQ4iK2zjIpis2eh+8NWGZgJhxUHlMcP
	 R/I9xYIhMtNwr2vvQzdr22Ra9tPjEGmdwteZGP+83x2ksLBTzMTCcvo89rieAkCEDscck
	 EbNDBNK1DnBukEx5hYRatb7CttPfgRl7ZyF3YXElA8NygZkLZ7hLGaCP6JejOEgG9Vycg
	 Ifg4QmhxeF/PpsWWm8e0yTwBO9MTAxQ34Dsjw8MOy2Ot6H2nz9BpOohf2JL/R0v2+KBP3
	 AEV4R/HTotZTSOCGvWyP0C7OzQ3YZa9Bcv/5ouH00xnZ9Jo03QR1Q2t9OXe9rmBFlEw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790950662;
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
	bh=dRQhmEfIfDaeCAwmqqmIbwPrzTNxhC8jIhHRjIsW9sI=;
	b=FaT3oMW8qvaomm9eEKdyjnaqTyXe89WmUleorMxVNnkUJKyzzGTuaFnJcQBJUwqHuoiX
	 kIhkfWcb0XU/Obb6xAwUd2By/dO1c+PzxSPwvyE24gBUVPMl6GvvD/1kivec1e3DeuZbV
	 aS49qhJGsBIoLiGHgvJaqd4RmTRwFTKCMlgYSPOxZUpvDhaXFAXG8ZQRnLoEGSgIazIkD
	 5gGsZIhJkkNJd/tQNkXD1mlCAO6Wut77Bq3wzsjWfhu8eZYu8qY0PT/9/PHM/QbXyGCF6
	 JV/hqh+fR+ipO2oV03iKng59n1zt9TTCNvxvLc92LoX/5HzZrAaQlIpBtXO3VyAFnmg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=P1TGhqFC;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790950662;
	bh=dRQhmEfIfDaeCAwmqqmIbwPrzTNxhC8jIhHRjIsW9sI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mMhLjTyatKMomMVPnwL5lU6+zgnk5vQh3RCuJIXzTS2J/OXiwP5eeHe7eyL52iOeX
	 xKXCZ60adpgoWvfNpZiZvsx7A+Ylhtgp+wBWCns4TkTt1dKIoG9XfEi46upYQJpA5A
	 gt7mCoLQYM7qNb+/uqhZsLrbgDtStaQFmZN2Ly8f7WoXFY1a47lPsmsujYc0pWcX9D
	 1UrgNIHqAmzeZI5gaJ4ehRs4A9W7QSOxt4puTJ5op1jB0muaGC52nASP4Jiy2PmEvZ
	 K66l1mu6HGz5PGZW4kFI9HPu+Q8GYjcQURTcZOcfcYC2Xgpp8LpltzoA6BFly2UmAz
	 4X6yExB2rCUQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2053280E31;
	Fri,  2 Oct 2026 14:17:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 14CBC34D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0597F80E31
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:17:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k7fRjNPuvq5w for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9E63480C74
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790950659;
 b=BIb+iNWjsAU5Y159a6GKwOTijIvaOdP56+sPSccF1mUAor43DNTu4ffwWjWW53fLJSlb
 +QQMqetb1Z9okMqV7d7uEb1hYaPvbjHM3pEnd7SrL/whiarS5FxUL8eSM2fBLScfusazN
 ZDyVoUu2Fx3YSck8nU3OSeJzgaiO8o9lPg7wmYMW7iTnnfW6LEZM74QeDj/gI3w6zy5Re
 XPznqE2XZuj95gj7wdFk5uj8IpfHU3pIypr/5/N/1Q2EWQ1YN/gBhhw2j6c5UHmAmu/Yk
 pThzZ1nkupgQScZ9tXt8ruWyZHk1wO8+JE3dFcvO/s6PfCMJyK7Nc97osAZUkrL2aYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790950659;
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
 bh=dRQhmEfIfDaeCAwmqqmIbwPrzTNxhC8jIhHRjIsW9sI=;
 b=saul5KzNbnGFMA6ZCzZ/1uaXmxLz5PP6Z6LPZF2AWb8DDKPKg09ObPjO1SUgdeUjZGDT
 XP+5d9FblUWLxAsIexbpuWaItx9T/Ho4hVDEqRlx3nY5n6Mx5iQkwJBZ0GhlDBS3CGUhH
 F/Yn4TF20RC0v9s4PMEygNAHPyJeSMNQQ3cNonWAq7hsMd8grHJWNj/AbxlEbJviefRjd
 RQ/4z4TPycxQFvTzf/XN3b1cCpWEbQenZjwqRXqq+Q/yvc1Wy+lR9+gFn//ZkKNPudRQr
 aquG9y0iHLqjxQNTXYbaA9Uaa8CExunqATZYiWR1KTNeWaxLsnMhscxCNQFkZ/bFfIA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=P1TGhqFC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=P1TGhqFC
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E63480C74
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYj1IpeBSh1RKs6STAPfdPFJHg647j3Zyoa/8V8+849+v9mjQsd+jJgZDPnmJUXD5RHO4Y/8cwNR0x9BR5vqUmWQHDb79zA5TivafmVEb5+tV72MjpO6uHIWRHL3Jw/SA7MhRvpsDdACaUldLMTmtSJ7w8nnYSR8tRq1qNJOZHEDVwFNds+eVsfEcHtz2bjIUd1nEIsCFbUZmZR4Ny8gJ3/5KlKZGvHo6pfWLLuXD73G6z4emJ7RjMRzWQqU3N2HrPwHNb6QHGtBKBysd3AoG6yz6x7p7kogosdRXxcJpmCiDZVpqk2mIB6j152UQb2+TbSNn96YDSFWEW+akI8Jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRQhmEfIfDaeCAwmqqmIbwPrzTNxhC8jIhHRjIsW9sI=;
 b=w1ByuqE4l6Hu5IKK8lA4tUAZBa0DIuxALOcaVWYf76l8fu9UfrGt83TXTxaGOS1rZ53nOx5EvZUrwydiFgA8pQJ+vsJi5EnU0DS++JRmqrZ5ffXIC5mpnYT//3OsuGS6kc60xg964geJwF9TBDB0JQpa0H7TnFulgAaOk5/1eXxg5JXT8EMkh0fPmnTjYggNMyrVtqWdSXY+3GaOcvuXAltE5YAz6hrbsD7ecdy0srgZKbBrErgb+zfrPyTFJ+Eb57VB9C0SUm0A0Khw72y0SzzJXSsswQzALGUu0rXuj9HSKLaiSEB5gETDMHxnLiH9mJ6LWvBksLupmYf+1WJ84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRQhmEfIfDaeCAwmqqmIbwPrzTNxhC8jIhHRjIsW9sI=;
 b=P1TGhqFCIKC72l03bewDSKMVtzKLYBx0WCAc/CRneICRoKdt+QdFwL/fLld0pVk6X7dHhmRI6PaPgpmRSs46xzq3AE2Npc1ZQXVAY6KuzfyRfe2GaP0jeRCU9II4AttwpL6XVGOTD+YrVcKcJv6br5H6XN6v4w/VoqQ7UMbnjkQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by BR2PR04MB705229.eurprd04.prod.outlook.com (2603:10a6:2c8:1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 14:17:32 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 14:17:31 +0000
Message-ID: <80e9e892-24de-4cba-b84a-35bdcb6a903c@cherry.de>
Date: Fri, 2 Oct 2026 16:17:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com
References: <20260916123826.517181-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0030.eurprd08.prod.outlook.com
 (2603:10a6:803:104::43) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|BR2PR04MB705229:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f1bfd2-b75a-41a4-3629-08df208fe5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|6133799003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: SswQrpduFrLlxjTve/fzDGLUeh/qBrUWNjOaZvzQ7jQC9UxG8p5wSAscheFF09DieYe/MnnZcG/uY9aa2p2gNd3DSmfnQs87npp2zwhNxF1rw7NbIVdJAh6kY0SIKKfN7cVUwMA0KPMGFHIPh7SdeeZMLGO0Cy0XOqZbYIeFOV/aTUIQGvGIHtxJre1Jg4zl3hv6GsjsS/JOeWuXI4bGD5/Tx0sxF5U4ubGGbL0YFA9cfhVMrX79AQSIl/ksPqcM+jCUj4Jw7pocXQPNdXTtch+xVNBkuxE3MpojK92nvAY62BzRGod4HWtkKh8WxO9NjpEoS1GgUyV1IwHiWFVJmqSSVas0hNKge92mdCXOKq9jMX5hd02oMu3jLcDag0EgtS4lzwxI+BIjOOMfbifGNaZ1F7UFpCgDGNEENZK7O6/ValVGxWZ2pjDiDF3wEDQ1LwpCfruNFNpjnoIhvCJnj/gm721KUe+eHVF8hGIhzW4tmDxQk1vZirZLwhjRV54qPiklzxxqg4VScM1tNFUii4ldUc1gEJTXEK1HEXpFcY0OPGwOLHxqpvliQFWeMvexlYAMWzA9fi8itXB41c+EsjljD7VtlTrD9GJfqh7o40HXQWgcfzmDPeSOqj89fi46/8kbZTVMMIkJMvqBnlBXDPiMv+xgmCb+EoOBPwr9jvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2lxdXVwYXpXVmw1RmlDN1pIVzk1dWU1UmxFK2pQWGZlMktDYTlPNkhDZDJi?=
 =?utf-8?B?SVBJUmg3ekEvNzVUSExIS01UYVRoMTZrNHhPSGdiSjVhRkZKNnVqVGN3QlY1?=
 =?utf-8?B?d2NIL09PdTNIQU5RWTkxaXJXNUZLNEtneURZMnFRcnB4UzhoL0RmbldjN1c2?=
 =?utf-8?B?VEJGL1pZZjlEeHYyK3RDRlV2Yk9MelNFMWdwRnhWMFBSUlNoVXc3TlU5MG9Q?=
 =?utf-8?B?cC9mWFB3Q3N2QXIrckliRllnbWhHbExzeWV3ZFRnTS9CZjU2NnNXd2tDaW8x?=
 =?utf-8?B?enZ5d3BMQmVuZW5hRVdxaUpRWGE2NGx4Z3BSYlpLZGdvaWVWeFRIdk05K1gw?=
 =?utf-8?B?UEJwZzZRb0J2bTFwRlBTWEk3KzU1WFNvbFNXaXF6c0ZNK0toeTRrZEhhbXZV?=
 =?utf-8?B?Wm5XV0UzNWE5QUlhWmoyRklDUDdVREFHeFpXZmtQZHZ6dGVaTXd5L0MxNWV3?=
 =?utf-8?B?TWg2cUxEL2lLRWltRHJoWHpobFJhOXlkTS9ubm1NSWtqUElld1UvTStydzdj?=
 =?utf-8?B?Q0dxYm1DNVR6NW1pWW9GVGozdWhmVVR3SDhxckVNbHdrMEtldXlLT2ZWdXJy?=
 =?utf-8?B?SkYzUSs1YkE0VnRNa0t2NFVEb1pMNElObDVIak9ieFUwcGhGQWNZTVVxQWtZ?=
 =?utf-8?B?UGZmY0c4dFN5bTVJZDcwT2dONjI2cnBlYktGemtHM3g0MXJGczB6cERkV1BW?=
 =?utf-8?B?eWdWaS9UV1lKYWIxeDdHTVVqN3J0T1ZzM0dYQ3J0UzhmTXVpUkIwM1Q5d2pa?=
 =?utf-8?B?bGtiUmJHd3MrcUo2UmRvTVFBRXo5Y2I3cDJ4S25FOHprTUVuc2wxdE9aRVFh?=
 =?utf-8?B?bmQ0WWtBd2U1cm93UFY2ZjFRaU9MSkZnY3liU2FMdDBZN2VjNTMvVXNoRkgx?=
 =?utf-8?B?dllvVVlNbzEwTUhIcVdXaU1MNkRVOWNuU3Y3bXZadmdtaXp4NVUxTkIxb3l6?=
 =?utf-8?B?aU5LSXgyODArT0lIYmp2R1haeVozZ3hhY3FhYXRxcTZkeVMvd0RyU1RJb0Uw?=
 =?utf-8?B?Yml1dGNhajQ4dC9DaHdFcDJKOXEzMVRuMktZSFJJR2JrSWw1cXAyQVBPWmZK?=
 =?utf-8?B?ZFV5U0N1THN2aEVzeUluTkFWMjFTQ0ZwaUx3eDhRbUFOaTVGVysxbmZMNnll?=
 =?utf-8?B?T1NXdkRxMTRiSXBFRGphS0o4SkljVTlTRXEwQ1Y2Qk14U1U4VUhZT3ljU1JX?=
 =?utf-8?B?dFpCSW5tYnJFZFo2UDZOYnI5eG1SYVUyWDl4N200TFh2ZlN2bFRQeFBqb3RP?=
 =?utf-8?B?cmNyNjFSZkJyMVhTY0p3ZzBDSUppRThLNGJPVnVpQmlMMjc5Qk4rOXR5RW0z?=
 =?utf-8?B?U1J0Ym9Pa0FIbEErSFYrMHkwSTZBK2p1MnpVMGh0M0dmRVNTVCszeEFmNmZE?=
 =?utf-8?B?c3pTeVRRYms1dDZtYnI1WjVKTXoxc0EzcVlFdTNhQ1dPaDBZdzc3dWJLOGMv?=
 =?utf-8?B?M0Jub0R1ZlFWZ3FjQVZkcll6eTJPMVdKNEpsUGhTRGlPdHE4TjRTRnhIdXhR?=
 =?utf-8?B?Ylkxb3QxTTNVV3NCTU01MThsQkZjNGcxeE9WYjBFTUZyMVRlSnZxRnBuSGdk?=
 =?utf-8?B?RUkxS1p3WDRGNnk3UjIwZGJhL0xCRDc2NE9ZWHNIQ0I3WEtaWkxNT0M3Qm1l?=
 =?utf-8?B?cEcxVSs4dTZmRmpWUTc1TFRjWitnMUw2bzQ4OEtyRnVweGV0LzI2UWRaK2pV?=
 =?utf-8?B?VEVqUmhwQlhFMmlvWUFBeC9nTDhiMjBLSndEL3Q5ZHRVUnl4UE5LRlNIcS9Q?=
 =?utf-8?B?elVHVDZyUitNaWNEbWNwMXZhNUlCSUZkNlVVdGRtZGZYSW5zc3ZJS1c0R0Jx?=
 =?utf-8?B?c0I3eVB2Q0IvM2ZaRmpLSWVXSlFSNDdaUGNnSDh5ZFBraExKM0FTczZhZm5v?=
 =?utf-8?B?b25qUmQzbUtmQm9uaEE0N2lkL0R4b29yUWJCRFJIR2N1bUIreEJ6NVZXcURP?=
 =?utf-8?B?VHpNY09FYU4yRHA3L3JvZkxpcUczTWQ1MEtTL0R4WkJqdXloVEt4TlM5MzVy?=
 =?utf-8?B?dE9Uc3lqS0FteHJjWjhmN0E0Z2Y2OGVOcWl1N3lNL1czZFZlSGIvRmYrc0o3?=
 =?utf-8?B?b2J0OWt1WE0xY1h5a3hSZHY3VGlibnBVVFl3Y2hJTUt2SnVzWXNpdEhSY3pS?=
 =?utf-8?B?OTE4SGYySzhReWV1aHJ5eHUyRnd5VzhDblBDVjhhSFM1SDhKTU5KWHkxWSta?=
 =?utf-8?B?WUdHRE5tOGZvcVkvZDAvNWhBWHhpdWh0dzZTM3RvUkNoS2ppeDlFOElCL1pU?=
 =?utf-8?B?dEo1ajdyOGpOWEFpZnZoaEZBc21lYnoxSkRzb0NvWkFRNU9rRFR6eDFmenJ3?=
 =?utf-8?B?MGZONCs1OVZXYThQMklkaktWU2d6cG0veWNLcU9WNEtvWFFRQlpXZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f1bfd2-b75a-41a4-3629-08df208fe5ac
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:17:31.6946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/lb9xJj1Ma77C9RWe9XUESx87wP8DTq9GtdP0NWE2VBDY+H/hhNnYdYlddQe4v2fAmGIuraFLz90jUBQAjvxYI8PL5socHcR1ACI4dppWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB705229
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

Hi Anders,

On 9/16/26 2:38 PM, Anders Roxell wrote:
> Hi,
> 
> This is part two of two. It applies on top of part one [5], which resets
> the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
> the build for every board that enables DWC3. This part adds back the
> U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
> builds and the gadget works again. It builds on Jerome's work [2].
> 
> The two parts have to go in together.
> 
> Part one is unchanged since v7, so I did not resend it. All 63 patches
> there have a Reviewed-by from Mattijs.
> 
> The resynced epautoconf matches endpoints on their caps field instead of
> on their name. Five UDC drivers never filled that in, so each one gets a
> patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
> and mtu3. With those and dwc2, every UDC driver in the tree sets caps.
> 
> Build tested one board per driver: every DWC3 glue layer in the tree,
> dwc2 with and without DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc,
> musb-new and mtu3. 17 boards in total.
> 
> DFU and ums are tested on hardware on BeagleBoard-X15. Anshul tested DFU
> and ums on AM62p and BeaglePlay. ci_udc is tested on an i.MX93 board with
> ums. Love tested v7 on AMD/Xilinx boards. The rest is build tested only.
> 
> One thing is still open. Anshul sees a single "unknown endpoint event 0"
> line on AM62p during enumeration. It is there with and without the cache
> patch, and the transfers work anyway. I do not see it on X15, and we do
> not know yet if it is older than this series.
> 
> x86 builds again, but CI still fails on am335x_evm. The SPL does not fit
> in SRAM anymore, it is 184 bytes too big. The resynced udc-core is bigger
> and am335x_evm had almost no room left before this series. I would like
> some input on how to handle it.
> 
> The branch has both parts [4].
> 
> [1] v5: https://lore.kernel.org/u-boot/20260716134305.614278-1-anders.roxell@linaro.org/
> [2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> [3] dwc2 prep: https://lore.kernel.org/all/20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org/
> [4] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v9
> [5] part one: https://lore.kernel.org/u-boot/20260824152734.159794-1-anders.roxell@linaro.org/
>      subject: [PATCH v7 00/63] usb: dwc3: part 1, reset and import from
>      Linux v6.16
> [6] v7 part two: https://lore.kernel.org/u-boot/20260824154133.217744-1-anders.roxell@linaro.org/
> [7] v8 part two: https://lore.kernel.org/u-boot/20260909085015.2480097-1-anders.roxell@linaro.org/
> 
> v8 -> v9:
> - New patch first in the series, "x86: asm: io.h: add rmb() and wmb()".
>    v8 kept the two wmb() in dwc3 gadget.c, but x86 only had dmb() and
>    mb(). So the x86 boards did not build and Marek's CI failed [7].
> - "dm: add helpers needed by the resynced DWC3 code": picked up
>    Reviewed-by from Mattijs.
> - "usb: phy: add the usb_phy helpers needed by the resynced DWC3 code":
>    picked up Reviewed-by from Mattijs. Added the blank line before the
>    last return that he asked for.
> - u-boot -> U-Boot in all commit messages. Mattijs pointed it out on two
>    patches, and the same spelling was used in 8 more. Four subjects change
>    because of this.
> - Part one is untouched.
> 
> v7 -> v8:
> - New patch, "usb: dwc3: gadget: flush and invalidate cache around
>    transfers". The resync dropped the cache maintenance for the normal
>    endpoints, so ums did not work. Anshul found it on AM62p and
>    BeaglePlay, and we both tested the fix.
> - "make gadget and ep0 build in u-boot" no longer comments out the two
>    wmb() in dwc3 gadget.c. They come from the kernel import and the port
>    had no reason to remove them.
> 
> Older changes are listed in v7 [6] and v5 [1].
> 

I applied both series on top of current main (c92d8c3c431e "board: 
beacon: Remove i.MX8MP Beacon EmbeddedWorks Devkit support") and tested 
on RK3588 Tiger (three DWC3 controllers exposed) and RK3399 Puma (two 
DWC3 controllers exposed). For each board, one of the DWC3 is routed to 
a micro-USB OTG port which doesn't seem to work (before or after your 
patch). Considering it's historically finicky in Linux, I wouldn't read 
too much into this. For RK3588 Tiger, the third controller doesn't even 
appear in the usb tree output. On RK3399 Puma, it does but no USB stick 
detected (either via a micro USB-OTG USB2 or USB3 adapter).

Tests are performed like this: I insert one stick in a port and power 
reset the board and run the commands. Tests for different ports for the 
same boards are run with a reset in-between tries. If you want some 
other tests or a different test procedure, I can do that too, but only 
in a month as I will not have physical access to my devices for that 
amount of time.

Some information about the HW routing for those boards. RK3588 Tiger 
directly routes individual USB ports to separate controllers. RK3399 
Puma has a dedicated DWC3 controller for its micro-USB USB3 OTG port, 
the second DWC3 controller is routed to an onboard USB hub that provides 
two USB3 ports and two USB2 ports (one exposed on the carrierboard, the 
other one used for our onboard USB/CAN adapter).

I also have an RK3588 Jaguar but the DWC3 controllers are routed to two 
USB-C connectors and I couldn't quickly make them work (the defconfig 
currently doesn't even have the necessary drivers enabled). This is a 
problem for future Quentin (we have a USB2 port that should work so that 
is enough at the moment).

# RK3588 Tiger: Q7 USB P0 lower
=> usb reset && usb tree && random $loadaddr 0x8000 && mw.q 
$kernel_addr_r 0xffffffffffffffff 0x1000 && usb dev 0 && usb write 
$loadaddr 0 0x40 && usb read $kernel_addr_r 0 0x40 && cmp.q $loadaddr 
$kernel_addr_r 0x1000
resetting USB...
USB EHCI 1.00
USB OHCI 1.0
USB EHCI 1.00
USB OHCI 1.0
USB XHCI 1.10
USB XHCI 1.10
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Bus usb@fc800000: 1 USB Device(s) found
Bus usb@fc840000: 1 USB Device(s) found
Bus usb@fc880000: 1 USB Device(s) found
Bus usb@fc8c0000: 1 USB Device(s) found
Bus usb@fcd00000: 1 USB Device(s) found
Bus usb@fc400000: 2 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
USB device tree:
   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (5 Gb/s, 0mA)
      U-Boot XHCI Host Controller

   1  Hub (5 Gb/s, 0mA)
   |  U-Boot XHCI Host Controller
   |
   +-2  Mass Storage (5 Gb/s, 126mA)

32768 bytes filled with random data

Device 0: Vendor: Kingston Rev: PMAP Prod: DataTraveler 3.0
             Type: Removable Hard Disk
             Capacity: 14784.0 MB = 14.4 GB (30277632 x 512)
... is now current device

usb write: device 0 block # 0, count 64 ... WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
0 blocks written: ERROR

# RK3588 Tiger: Q7 USB P0 lower retry with another USB stick
=>  usb reset && usb tree && random $loadaddr 0x8000 && mw.q 
$kernel_addr_r 0xffffffffffffffff 0x1000 && usb dev 0 && usb write 
$loadaddr 0 0x40 && usb read $kernel_addr_r 0 0x40 && cmp.q $loadaddr 
$kernel_addr_r 0x1000
resetting USB...
USB EHCI 1.00
USB OHCI 1.0
USB EHCI 1.00
USB OHCI 1.0
USB XHCI 1.10
USB XHCI 1.10
cannot reset port 1!?
** Read outside partition 0
Bus usb@fc800000: 1 USB Device(s) found
Bus usb@fc840000: 1 USB Device(s) found
Bus usb@fc880000: 1 USB Device(s) found
Bus usb@fc8c0000: 1 USB Device(s) found
Bus usb@fcd00000: 1 USB Device(s) found
Bus usb@fc400000: 2 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
USB device tree:
   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (5 Gb/s, 0mA)
      U-Boot XHCI Host Controller

   1  Hub (5 Gb/s, 0mA)
   |  U-Boot XHCI Host Controller
   |
   +-2  Mass Storage (5 Gb/s, 224mA)
        SanDisk SanDisk 3.2 Gen 1 5B4C0BC01FBB

32768 bytes filled with random data

Device 0: Vendor: SanDisk  Rev: 0    Prod: 3.2 Gen 1
             Type: Hard Disk
             Capacity: 117864.0 MB = 115.1 GB (241385472 x 512)
... is now current device

usb write: device 0 block # 0, count 64 ... 64 blocks written: OK

usb read: device 0 block # 0, count 64 ... 64 blocks read: OK
Total of 4096 double word(s) were the same

# RK3588 Tiger: Q7 USB P2 upper
=> usb reset && usb tree && random $loadaddr 0x8000 && mw.q 
$kernel_addr_r 0xffffffffffffffff 0x1000 && usb dev 0 && usb write 
$loadaddr 0 0x40 && usb read $kernel_addr_r 0 0x40 && cmp.q $loadaddr 
$kernel_addr_r 0x1000
resetting USB...
USB EHCI 1.00
USB OHCI 1.0
USB EHCI 1.00
USB OHCI 1.0
USB XHCI 1.10
USB XHCI 1.10
cannot reset port 1!?
Bus usb@fc800000: 1 USB Device(s) found
Bus usb@fc840000: 1 USB Device(s) found
Bus usb@fc880000: 1 USB Device(s) found
Bus usb@fc8c0000: 1 USB Device(s) found
Bus usb@fcd00000: 2 USB Device(s) found
Bus usb@fc400000: 1 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
USB device tree:
   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (5 Gb/s, 0mA)
   |  U-Boot XHCI Host Controller
   |
   +-2  Mass Storage (5 Gb/s, 126mA)
        Kingston DataTraveler 3.0 1C6F654E48EBB161D95D8F07

   1  Hub (5 Gb/s, 0mA)
      U-Boot XHCI Host Controller

32768 bytes filled with random data

Device 0: Vendor: Kingston Rev: PMAP Prod: DataTraveler 3.0
             Type: Removable Hard Disk
             Capacity: 14784.0 MB = 14.4 GB (30277632 x 512)
... is now current device

usb write: device 0 block # 0, count 64 ... 64 blocks written: OK

usb read: device 0 block # 0, count 64 ... 64 blocks read: OK
Total of 4096 double word(s) were the same

# RK3399 Puma: Q7 USB P2 upper
=> usb reset && usb tree && random $loadaddr 0x8000 && mw.q 
$kernel_addr_r 0xffffffffffffffff 0x1000 && usb dev 0 && usb write 
$loadaddr 0 0x40 && usb read $kernel_addr_r 0 0x40 && cmp.q $loadaddr 
$kernel_addr_r 0x1000
resetting USB...
USB XHCI 1.10
WARN endpoint is halted
WARN endpoint is halted
unable to get device descriptor (error=-22)
Bus usb@fe900000: 5 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
USB device tree:
   1  Hub (5 Gb/s, 0mA)
   |  U-Boot XHCI Host Controller
   |
   +-2  Hub (480 Mb/s, 0mA)
   | |
   | +-4  Vendor specific (12 Mb/s, 100mA)
   |      Theobroma Systems Mule USB/CAN Adapter 002A00244356530720323439
   |
   +-3  Hub (5 Gb/s, 0mA)
     |
     +-5  Mass Storage (5 Gb/s, 126mA)
          Kingston DataTraveler 3.0 1C6F654E48EBB161D95D8F07

32768 bytes filled with random data

Device 0: Vendor: Kingston Rev: PMAP Prod: DataTraveler 3.0
             Type: Removable Hard Disk
             Capacity: 14784.0 MB = 14.4 GB (30277632 x 512)
... is now current device

usb write: device 0 block # 0, count 64 ... 64 blocks written: OK

usb read: device 0 block # 0, count 64 ... 64 blocks read: OK
Total of 4096 double word(s) were the same

# RK3399 Puma: Q7 USB P0 upper
=> usb reset && usb tree && random $loadaddr 0x8000 && mw.q 
$kernel_addr_r 0xffffffffffffffff 0x1000 && usb dev 0 && usb write 
$loadaddr 0 0x40 && usb read $kernel_addr_r 0 0x40 && cmp.q $loadaddr 
$kernel_addr_r 0x1000
resetting USB...
USB XHCI 1.10
WARN endpoint is halted
WARN endpoint is halted
unable to get device descriptor (error=-22)
WARN endpoint is halted [QSC note: repeated 355 times]
[...]
Bus usb@fe900000: 5 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
USB device tree:
   1  Hub (5 Gb/s, 0mA)
   |  U-Boot XHCI Host Controller
   |
   +-2  Hub (480 Mb/s, 0mA)
   | |
   | +-4  Vendor specific (12 Mb/s, 100mA)
   |      Theobroma Systems Mule USB/CAN Adapter 002A00244356530720323439
   |
   +-3  Hub (5 Gb/s, 0mA)
     |
     +-5  Mass Storage (5 Gb/s, 126mA)
          Kingston DataTraveler 3.0 1C6F654E48EBB161D95D8F07

32768 bytes filled with random data

Device 0: Vendor: Kingston Rev: PMAP Prod: DataTraveler 3.0
             Type: Removable Hard Disk
             Capacity: 14784.0 MB = 14.4 GB (30277632 x 512)
... is now current device

usb write: device 0 block # 0, count 64 ... 64 blocks written: OK

usb read: device 0 block # 0, count 64 ... 64 blocks read: OK
Total of 4096 double word(s) were the same

I also have two SanDisk Corp. Ultra Flair that are USB3 but they are 
consistently detected as USB2 in U-Boot for some reason.

Cheers,
Quentin

> Cheers,
> Anders
> 
> Anders Roxell (26):
>    x86: asm: io.h: add rmb() and wmb()
>    dm: add helpers needed by the resynced DWC3 code
>    usb: phy: add the usb_phy helpers needed by the resynced DWC3 code
>    usb: gadget: adapt the gadget API after the resync
>    usb: gadget: udc: make udc-core build in U-Boot
>    usb: dwc3: make the core driver build in U-Boot
>    usb: dwc3: bring back the samsung usb phy driver
>    usb: dwc3: make gadget and ep0 build in U-Boot
>    usb: gadget: udc: enable async callbacks on bind
>    usb: dwc3: ep0: flush and invalidate cache around ep0 transfers
>    usb: dwc3: gadget: flush and invalidate cache around transfers
>    usb: dwc3: make the am62 glue build in U-Boot
>    usb: gadget: ci_udc: move to the udc-core registration
>    usb: gadget: ci_udc: set endpoint capabilities
>    usb: gadget: dwc2_udc_otg: fix up after the resync
>    usb: gadget: fix up the function drivers after the resync
>    usb: gadget: fix up the last UDC drivers after the resync
>    usb: gadget: atmel_usba_udc: set endpoint capabilities
>    usb: gadget: at91_udc: register with udc-core
>    usb: gadget: at91_udc: set endpoint capabilities
>    usb: musb-new: fix up after the resync
>    usb: musb-new: set endpoint capabilities
>    usb: mtu3: fix up after the resync
>    usb: mtu3: set endpoint capabilities
>    usb: host: xhci: fix up after the resync
>    usb: cdns3: fix up after the resync
> 
>   arch/x86/include/asm/io.h              |    2 +
>   drivers/usb/cdns3/ep0.c                |    8 +-
>   drivers/usb/dwc3/Makefile              |   16 +-
>   drivers/usb/dwc3/core.c                | 1761 ++++++------------------
>   drivers/usb/dwc3/core.h                |   39 +-
>   drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
>   drivers/usb/dwc3/dwc3-omap.c           |    2 -
>   drivers/usb/dwc3/ep0.c                 |  117 +-
>   drivers/usb/dwc3/gadget.c              |  724 ++--------
>   drivers/usb/dwc3/gadget.h              |    4 +-
>   drivers/usb/dwc3/io.h                  |   36 +-
>   drivers/usb/dwc3/samsung_usb_phy.c     |   77 ++
>   drivers/usb/dwc3/ti_usb_phy.c          |    2 -
>   drivers/usb/gadget/at91_udc.c          |   83 +-
>   drivers/usb/gadget/atmel_usba_udc.c    |  114 +-
>   drivers/usb/gadget/ci_udc.c            |   86 +-
>   drivers/usb/gadget/composite.c         |    2 +-
>   drivers/usb/gadget/dwc2_udc_otg.c      |   86 +-
>   drivers/usb/gadget/epautoconf.c        |    2 -
>   drivers/usb/gadget/ether.c             |   21 +-
>   drivers/usb/gadget/f_acm.c             |   20 +-
>   drivers/usb/gadget/f_fastboot.c        |   10 +-
>   drivers/usb/gadget/f_mass_storage.c    |    5 +-
>   drivers/usb/gadget/f_rockusb.c         |   11 +-
>   drivers/usb/gadget/f_sdp.c             |   12 +-
>   drivers/usb/gadget/f_thor.c            |   19 +-
>   drivers/usb/gadget/udc/Makefile        |    1 +
>   drivers/usb/gadget/udc/udc-core.c      |  933 ++-----------
>   drivers/usb/host/xhci-dwc3.c           |    4 +-
>   drivers/usb/mtu3/mtu3_gadget.c         |   10 +
>   drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
>   drivers/usb/musb-new/musb_gadget.c     |   21 +-
>   drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
>   drivers/usb/musb-new/musb_uboot.c      |   39 -
>   include/dm/device_compat.h             |   13 +
>   include/dm/read.h                      |   51 +
>   include/linux/compat.h                 |   15 +
>   include/linux/usb/ch9.h                |   25 +-
>   include/linux/usb/gadget.h             |  529 ++-----
>   include/linux/usb/phy.h                |   57 +
>   40 files changed, 1416 insertions(+), 4005 deletions(-)
>   create mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
> 

