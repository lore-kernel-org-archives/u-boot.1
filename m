Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B9E606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M9RGCfp4;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=u1T3HBNm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7455E405E6;
	Wed, 28 Oct 2026 08:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 95BaAlweqEaX; Wed, 28 Oct 2026 08:31:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34448405A5
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793176293;
	b=pucw+IbIJj7Mxa8Tq7ourjVWIEZ4L2zhlvlY375FQiTC6DxIjLycJdg4r4qY+XSmZ7ab
	 wtA7uDtjm3leTVt8q1fxz+hbMWqkly1yQcbw/L0n4OtyA6xHLOq62iW33AW9suH3zeTE+
	 11bdejeuyzK7BjketWxeQ0G1OQkvFiEq6mBVzWheMuGYRFq8o/zTq60ostczu3PDrPDdU
	 h66kpXadhlaJpow+aHZEfNSb2aNVoUK7HjOwfgFUkhDoBuKJ0hOC0LipUnEYgxLRV7ULd
	 UwKBXF6+l5fFiM8N2sYjyIN5x/nhdfy0/4vlV4DAq+2udMNJL5LUKt1LmutJP0cWsrQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793176293;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kPEVonJkcWFJAnIbTYU+dg3xVd/SomzZ/YoAxPmA93o=;
	b=sbUpuZTar2H7jdavWRH8J0qCsI58bifDY3n2cq7z+0YVeiYsDzQhQVhUoU6PfnH88wdi
	 vkDJogB0SFpMKJDpra868u/RLICGWVz/AY6ATr7p02fR1/S9qkGkwRGm/8YM2WVG2Ntsa
	 +EFKk/jRsfTwHkdqyHHsC8JZwsKnyHM3dEqG60oaTj57R+iPlA294n4KbyjnnyJOKLXBh
	 tWRKzf29qRtXRJJ6P8zm97DUQm69O0TAdziWSpBhB5STxEBj+bOjjbs3ayHn5Iim2DgIU
	 RR9Tq4371zpYL/+m4K+D3AcABUc24ZiclOnp0Cfxm5ZXQ32Lho8tVnBb7zwAzo1v4dg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793176293;
	bh=kPEVonJkcWFJAnIbTYU+dg3xVd/SomzZ/YoAxPmA93o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M9RGCfp4JVIkNELoBGC9tKgLZsmTdeXV4urYvN+on2D0lXL0scBxL/S/nNcoF3MQE
	 f2f/UtzE2E4g7lLP5t+gCML1qaFbvujM/PKaL08en7p+yeYGhUL0LyJCw06/Ao1UQn
	 tj8hl0N8KxKFjA1Y8nMFx6JPhTp5vUyVZoCJy5CZ/5PpDKn88K04sGTaHo8pxGlv3U
	 cdiQoIGSj+P/9b6QzQsCyo6jvmQ8dbgZxl82kywLXpYcrYBxRcZllW0VumNTFYT/jh
	 VhRVLK/wd8svjPjqnwttz+pRVHIzId7RA7xAeDB1LPiOsBDEms7ovfjqlVPfFJaPm/
	 XuHIXD4tBtq7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34448405A5;
	Wed, 28 Oct 2026 08:31:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0227B972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:31:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7C4F60658
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iIgzAhR6tfCf for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:31:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A17F260600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793176290;
 b=WYpokkcfHrp1a9YILC63niR+Dn/vcTdzwgvKVGEj6PThwv5/ezndVZ5DJbYkP4JcNRrd
 5CLxG4BGHG3D8IguOCXAxmgHeoYgACnJYlADn7TNtna1dbuAnk40zcgmXngptpBuZuwV3
 RvLkT77ELqoRn4DenwkPqB/5sgOzFx3lfLP/9BUdUDgbREMvUToRz6VnULnmNpe1/INrq
 cMT3htM94CKOepgabEaF6vEZBdUP9oTSY4SqcmBEtrU6RiGqR2ktNCrcMm7Soh6AT/KD5
 wjz068cfrawazHhyhv/S36huTfT3zy4xDu8XNa4jK3oOahdFkh0vrGQLdfFlB9IoYgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793176290;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=kPEVonJkcWFJAnIbTYU+dg3xVd/SomzZ/YoAxPmA93o=;
 b=AKvrPgRiX0P3mJCWjhuTBfDfbTg0x9gbg796i/L6QQIq02fcKhu6X4roco9R23+Se2+m
 JS5O+KYU/AFNcoH39YUmJBImPfabLnLOPFlbIOEAvFDpbNvxcB2B7s+o41b4AmSYsk6Kx
 2W00CVOIsQw1i7it6YJWLFDg5ErZ23Zs0agwHhFYXGxbfgpO3wUwpKCSEz0F7Zna2FFeZ
 zutQQjESSpvjJEHyjkPUr9lwmj+bYlPioCKI1otRrQ6/Noib4zHh72llhfgYU9CVsVR8Z
 AbqMnCxqm/eurrjkosPsNsDAnoS4MGjmlaMz88T9s2A9oIoOC/DYtEYBzwns4cldpsA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=u1T3HBNm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=u1T3HBNm
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A17F260600
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:31:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mu7oCrdXjGhWGe68jm24JD7SFA5QpRy+pcEVLSbat5voVnoi/DXnxoIoj7StBKdTEeLgBsmldiAmSe3O3T4YAKZwHDmqXLivXJbpDOntvsKOBbyY1XVvtejz6RNbGkzZBDvsSv4OBpEk30adlWE6v6awyG4e9GcK9rtsNRaU+TgyWnIakU+ez/OuI5dpMGgn3saly7PAdIcN5cZEfIyXmKF7go9r0lfgYUNRo1VaFkDgdaoXSzBVKdCZhLphqtaZgXxQZp6Og0r+8Z3QZ7jUoP92sVBrLlhMTitYyKRjrlVNLD59l750K01pNYuOg5BkOnxF7UmdpBBYv22pM8yqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPEVonJkcWFJAnIbTYU+dg3xVd/SomzZ/YoAxPmA93o=;
 b=cb8cqh/Wmbp1nH+GvVIbOa+kFj1ke2CUYFtn9T0UPVNc/vAGkk0/1vSIjLX9fqlU88XBLAUFbfUhhyho86Ry8SgHVK8qjtXuSyhlByfIeRM3aj0OR9LkUOBz6kmRk8ESpAjPAVk3YOt1mLR7GW/4In3xusejIRDtRm8PyGIFTq+3aYgkZ2i4zEwb5MHPmWoMxGEZL99xommlBTgPLSzwSW9iwWByFo79iQuBOyn7PwdNHDcgq/gC7A+FRL2iHGtg/MEiYdV5tk6ZQurgi5KNb+/I81T3jjbnfKMWf3NwrlyVjpld/tNT6AitR8vwmvlVJ9SJVeINybxTX1Rnvd2g1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPEVonJkcWFJAnIbTYU+dg3xVd/SomzZ/YoAxPmA93o=;
 b=u1T3HBNmQ2Nus/CqyFiqPTPOsFPxQIMRFSN1XLq3BnddtGr0+RIkN9PDzNa7kTE6UzP5l1PL15xtDrAmW6PkdMMDnxLCOQCdKge/eXH3IO/pyRnok8BPc/Ej7gREgeGkAh0KAlPcTHt46zwsXp0Z7XaKtgycsfIS8cIoXP72IeoUc7HNKGeTlzE+4N4RWg8q2MaO7thHeeZAXUunIcs/tpMYCI5E5ddB5X7YoWKd3Oc8simOFL6JpnGEEuXBFg09+t0WrISoW6SdVjF1m1Zn+xAqTcMYq9YSUZWduYrwdhGdJGzQG1TY1vfZATti8vv+4zCh/BHfpPwhgHELM9Qlpg==
Received: from DB8PR04CA0006.eurprd04.prod.outlook.com (2603:10a6:10:110::16)
 by AM8PR07MB8263.eurprd07.prod.outlook.com (2603:10a6:20b:326::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 08:31:23 +0000
Received: from MA3PEPF00000407.eurprd04.prod.outlook.com
 (2603:10a6:10:110:cafe::b) by DB8PR04CA0006.outlook.office365.com
 (2603:10a6:10:110::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:31:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 MA3PEPF00000407.mail.protection.outlook.com (10.167.241.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Wed, 28 Oct 2026 08:31:23 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id CF0762006D;
 Wed, 28 Oct 2026 10:31:22 +0200 (EET)
From: juuso.rinta@nokia.com
To: sjg@chromium.org
Cc: jonas@kwiboo.se, jonathan@joggee.fr, juuso.rinta@nokia.com,
 stefan.roese@mailbox.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, yuriz@vodafonemail.de
Subject: Re: [PATCH 2/7] watchdog: warn if programmed timeout not longer than
 servicing interval
Date: Wed, 28 Oct 2026 10:31:22 +0200
Message-Id: <20261028083122.2257868-1-juuso.rinta@nokia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAFLszThz5iM4Qn78NOyVedon2jrDUnKn=0hN++YcFd1759tnPQ@mail.gmail.com>
References: <CAFLszThz5iM4Qn78NOyVedon2jrDUnKn=0hN++YcFd1759tnPQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA3PEPF00000407:EE_|AM8PR07MB8263:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 515f3302-3c8e-4114-a2b0-08df34cdd9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261022105027099003|261022075727099003|261022113327099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +pW7H0lDB+6/V4TkKbLtemtjovd+CHyefxwLtJKOvFn3SvGTOpQUzhTcbJE1bnPNbZf4onl4RoIO1GwA9AnQq8gH89q7FdogO2dVujKsFXPSNLlmEWIM9iO0cCYLGp3/U/i5lBOhaABm1N5LTswEl5WRdpogly3NYD+cDb5j+JIPaHIiCfE/VBsE70LmOpHhkGlxD8GmzZlROlOv4Clp3kTWjBtZ6XLVrjsV1muKOIYTw+qPazmNpTEqd5dolyusVX9xk6WFOn2JfwRsuRqiegLxhuIqsLCRE7jkESXctiS+mUa5/uHt2AtGmz8SVK7Ed7+BZAKkBPa5QJRAns1ZzD3rHikeFRGnkPC06XhdoN5zN7rh3uls0aTuE4BNX2WMqzTfEiwWLrRIkGnFrvWHOdqXGXmJyvgMZE+cv2D3Qj/ohZdQig9gNm9WHWDs5W+WxyzRzNj1tDnMq0TPAF5H91pbhpJY6wpzu1Vd/ZRiPX5Cmgg6ZAQeQKrtbq70ObDyF3BfA/iGoZMASQux6PG32+oOAw9k3PHx0s7rNdVERu2Om3FmUDVdUj9BsWXT0jn+eOO20XPwd/WlFN709G5JHDkvP+O1qDR+GPk0JtEYCd3G4wgXW8MARrZLnIOSSDYC5zKPl9aTZkp2L3IoqfGHS/XQZEw4NwY9Wbrr9AT9/1F9Lwv3ljIC9MoimIV/tV0AHLO6QBijAzpEcsWfIkIgPg==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261022113327099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OvlxT/GBOj1owtDfMIzj3aExqbmkK7sl1cG8nT9qUu6toJ6jHzkmBlCrDKHhS/69prk08QxbaFiUsyYtcHIHUN1Il+zMKKkxrFFQLHDncgDXoxOPKbvarI5nO455yWlISvla02+DclIYmb9q/QkctqpzuBb4FEcxqvz/mAZCIn2LTPbrXjt5FEYBDKNhZFQUBRDQ89GgJNncxxGENfKyev+gscEwwW6+FcOsTojsAqVGPw79qXnNKoiyon8YBCAJzLc2SQ4ox+Z7XZeZWH+HWD4xA+QUPoStKSjhUZl5qaKwf/DLKPY3yGT5tfjEQJxTkxDPBT3K9ZQXQsOIJFyCZVt68m81WjCfwakPcuQmKxqrnLGjLFX9QI+Q+KhUeW0zFa+aau9fuYZ7479U+UOSq140ASgdlOQph2wY7aadeVkTPtSNeOcyx8erthaz1P6V
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:31:23.5333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 515f3302-3c8e-4114-a2b0-08df34cdd9c9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MA3PEPF00000407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8263
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

Thanks again for your review. I'm working on a v2 now, following up on
few questions raised in your review.

> Why only warn when the driver implements get_timeout? Otherwise
> timeout_ms still holds the clamped value passed to ops->start(), which
> is the best value we have, and the problem is just as real. Dropping
> the 'get_timeout_ret == 0' condition would cover all drivers and
> remove the new variable. What do you think?

I agree and would drop this condition for v2. But I think this goes a bit beyond
Stefan's original suggestion ("once the uclass knows the real timeout it can
warn"). For drivers that implement neither get_timeout nor max_timeout_ms, the
compared value is only the requested timeout. Would you, Stefan, rather keep the
warning limited to drivers implementing the get_timeout operation or drop the
condition as suggested here?

Best,
Juuso
