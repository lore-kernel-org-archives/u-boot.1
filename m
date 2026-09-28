Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3A5CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04435606B0;
	Mon, 28 Sep 2026 17:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id boMNoLQBnied; Mon, 28 Sep 2026 17:04:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 46067606CC
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790615097;
	b=OVcMIhxcG6+J8rYjh0mqz3IbiZNbgOP/PlcWMFxSM0NT+tnZUrqj2Xh2Pv11oxWAvZGj
	 ZxpIbKZUc+Mc7Mk/00IcwlohaLTGZNKJ5Y+OWs2BnfPTyX5ws39Ru91E6wEHTde5DFh9E
	 Iml11/lEOvuDQP5Ocfh3NSBRlhJ6SFwv+2hW5XWwP1LKRaCBwvXQjLK9K9Kh9oGT85T+s
	 G2vZEGBJOaScKJjEXQhnkszL9UGSEM3dBk6WzCbavKQFzmUaFT5cJdqzCpLGLZl5ej4+a
	 qPXfmc7nIFCwfY0W1LJq1s7wH0YkAnRDf7whIYI94t9MsiE3oiPOtSTpTutjr4Wfrdw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Type:X-Change-ID:X-Mailer:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
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
	bh=0lVjr9UmLeEne8vMqB1wjXTIeqoteF1vTe9mxwVhrD0=;
	b=rUgy77R3F9Xoewkuvf1w/GkkcdnuqPhxGvdkEygrHzfcdlbjksM+Ck28tPWLkQIn5K7w
	 1+yvvhai2had7UxDZ72iDmqu9XEmIT+eUTAidGuIQTNLRpfbsbjsg1XdxjJYvHuqbyoxT
	 +p1GLU/1jF3swUhnuCJugYkLsl8Pb8B0fsqJpDx5WlLprrbI+WbqIruOSmM6dpmSkvgyj
	 3e5NYVxJZaI4/HGejMMrhd+VLvUgv/aldEv+Hn2CgSaNaYUc2ZODtIUzdEfZTjIE0NaD/
	 mtJj2pBOwjq2tmZ1SjAVjyPDh7kWBdmBP8I2eIh7Ke+7+u3D6ULBNJ4tRXN4wb2P0Rw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615097;
	bh=0lVjr9UmLeEne8vMqB1wjXTIeqoteF1vTe9mxwVhrD0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Lq+JVpCtSKHCFSvuGFfFZ+R2NzRdMtUIl3urX2MLeF0yG5Ex0ZWkmKhs9XMWAvyne
	 sxviVKSdrvKDY1J3qWjUhmFVdiR2DglMkcgM+P/LJsT+AIDhi3WRLNFGgWfEd4aZhL
	 FC1Uu5O1oAkz0r7nJaZz9Fia9A69LdTO7VXngMRBHCddPO8cJRI1fnrMvDCXbkchk3
	 lZS8bz+U81mVD446Zc7GSqOWIM13jI7okAMvtKP0uyoVycmGtDtsNGApFarGQClhi3
	 2T7Em2zxsGoYxTguWblXUU5Vu2QX0FGS/aLUB2WsuKIgu4zTSYP7Wy0VC/XI1tjAKH
	 kQfggBClmR3zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46067606CC;
	Mon, 28 Sep 2026 17:04:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 05AA072
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0181D80F29
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:14:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z1LnAngbrVmW for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:14:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EED0180ECB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c405::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608485;
 b=FBhCisuTNOx8vRQ1zfUn+2PSiK/hAnHmeXb9ggC/D4eVaIP/H53c25sgyQwdA5mpR8QI
 nVfykxcNtSy5+B4Pogn9dx2tW8Ka3YmgJ7ETbL6oRrXc9P0iaDznmv1n7dwwtKods+LyA
 xRNeCONvQscTmyoKDsI0ABJzMApE14aSCspldepPVVigkb9evbwxEXjhnJqIcFGJnZB3z
 PyT+S2nUH3By595fdH2TapVjRbAEWeuHkffX88tvT+1Flnwin91hAuw9kcCj+lP/ipbLB
 bEtoCAMjAPP+OfaZR9HF3c9JXGniQnN2RAIMBO3rJ3NqjovPIDtt0tJuwoMvWv9d6hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608485;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Type:X-Change-ID:X-Mailer:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=0lVjr9UmLeEne8vMqB1wjXTIeqoteF1vTe9mxwVhrD0=;
 b=s/uavZKarfxcHaSrMd48h0qwBc1H9RVOuJf6KM3B7D1qSpGQSHpvT2xAmNuq6tt1A02o
 CDnTcmfrZiUzfJrza2Go6uPGsa9AAJkJQKI1RoNPr3PTpTAgV3EBFpvzlnyQDttA4YyOw
 4vV0kEc9IyJlt7XivtClVRtZJWnB/tvQf+Yh2EyNM7JwFHNRA5XuzYGfg523+Viry0ygC
 ZjL8ONcgJ3q2t+7hVH7zFCjHqCEqIS8c8w1Ww1iM63Ww9973KWNANv5u6vFoVsRb7v/7D
 d9K/6P4lTZz1QWJOCOSmc5BJB4X+mmYfbXXsldwkfCOs4hQ17IJNsH9krvqSsjdpEMQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=espressif.com; 
 dkim=pass header.d=espressifsystems.onmicrosoft.com
 header.i=@espressifsystems.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-espressifsystems-onmicrosoft-com header.b=wV5QOU2H; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c405::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c405::5;
 helo=typpr03cu001.outbound.protection.outlook.com;
 envelope-from=gustavo.nihei@espressif.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=espressif.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=espressifsystems.onmicrosoft.com
 header.i=@espressifsystems.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-espressifsystems-onmicrosoft-com header.b=wV5QOU2H
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EED0180ECB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOZmr7T3lGls4opG3CHbmh6psWo6gyVLo2rka84XnjXudBsK40xBjoNps0eFkAhjMRMiYL10e++kY1KlIexlMBhZG6i9WuLM/z5XjsbJA5uFajQzlpsA7YHCmGELRv4b1Dr4Ds1KrvsuH6jLP/NgZfBJ1kNDrVZSMCBrSUNOx3pJJaOb4C2BH/GAES3a7VWuaC9F5xTdRzF4fIUHC2Bs/djgE8YT65c4bsLxaeUzw2Plx3hswu07aCFiqCkY9KG9MW7jzU5LHN5EBdPWNo1X8fxFdKC+KH2hUqBpqXVow/3t3jG8fG8HIVYPuk9yz6NW1ZpO4/1/th1RMZVhnc1pkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lVjr9UmLeEne8vMqB1wjXTIeqoteF1vTe9mxwVhrD0=;
 b=LyCeSJcBxYpuHmej40Q6d0pFySykcIlCbJ79XB/EF/Fh9Y1EbdiBBoF2VFJgi9qNLKdwK+9LjkJ8YXmoobzqY+eJq863P/8F9paeswsVY7xhecAV2AE7yoOunw/AG3Nvj11X6aj/hhr1/otxl+lcWCoEWMMqDURk7C4LcjHHfl74OoxV05SWCS6NFvE0ssWcs1LFW2NkXgrdlEJ0olEJMpkzH3ytmnWE54dsRZZmQQIoGs0LFkJHG3RbqFJzQkMGJIDuOJsKRhFVrlWe2U+/y+mRHvs7mNdqCKgvlR565KaHWnikCiDhLBjWqN5UPI4mNM85gSIi3KuOjrjeu1CpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=espressif.com; dmarc=pass action=none
 header.from=espressif.com; dkim=pass header.d=espressif.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=espressifsystems.onmicrosoft.com;
 s=selector1-espressifsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lVjr9UmLeEne8vMqB1wjXTIeqoteF1vTe9mxwVhrD0=;
 b=wV5QOU2HBTZN2JgZhvDQN1FBpEFhrgm3WkLU+BpkWJsJin//faYc0r0+yreW+iUpP5m7K4wonkSHzj/TrwMrOLnRa61081UTARxBUvm+wSBouWeXNjidEtUjx0TJuIlR3jUM4d+Che3f4ZnfscaW7AsG3aSeCKsRtdOzUELbv9g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=espressif.com;
Received: from PUZPR04MB5419.apcprd04.prod.outlook.com (2603:1096:301:bb::12)
 by TYSPR04MB7983.apcprd04.prod.outlook.com (2603:1096:405:89::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 15:14:40 +0000
Received: from PUZPR04MB5419.apcprd04.prod.outlook.com
 ([fe80::af90:4b51:a7c:3d9e]) by PUZPR04MB5419.apcprd04.prod.outlook.com
 ([fe80::af90:4b51:a7c:3d9e%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:14:40 +0000
From: Gustavo Henrique Nihei <gustavo.nihei@espressif.com>
To: Yao Zi <me@ziyao.cc>, Lukas Auer <lukas.auer@aisec.fraunhofer.de>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Gustavo Henrique Nihei <gustavo.nihei@espressif.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Anton Maklakov <anton@espressif.com>
Subject: [PATCH] riscv: restore ILP32 size types on RV32
Date: Mon, 28 Sep 2026 12:14:26 -0300
Message-ID: <20260928-for-upstream-riscv-rv32-posix-types-v1-1-6f8a37501ccc@espressif.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260925-for-upstream-riscv-rv32-posix-types-65f46e21fd8d
X-Mailer: b4 0.16.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CP5P284CA0085.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:93::18) To PUZPR04MB5419.apcprd04.prod.outlook.com
 (2603:1096:301:bb::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR04MB5419:EE_|TYSPR04MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: aa70951d-d3dc-4b41-d3ed-08df1d7337b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|10067099003|5023799004|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: fmRyjl5+xRzN7H0Jp6uNSZQocYACX/xHldkrj5vvwyUJokh266XtIuolBo8Vh9hXrBfrZRlA0R4BnT5OS0BpojCg498ST7BDdyiDf1c28tKxpFlwyI2+6eUb5zTe3hZFBTOKIO+9E4TVwShCkgui7Bp1Ej127Km9nj6J4LD2VRcZd9IoAcb8GU9/Ns+vyWTSDcHWVz0J+MUCv5OtWUrqLyh2JftSqCe0y57uAhvFpbV+VcLRgSrNL6S2SXyuZdKUeda1EYHqOJGpy0tFVvGHJz6ba1/VLpjhFSpBNVXegVIqmUwiuc0v0NR9h1M/SwUOEJCAtoomvbJ6cryyKEo4HoDgVvQRJGrjqa9eMr0eXotZj1kBnB7zDH3K27dVqC8GMiajVMNznNx0+J+y8oKuqbPE7dyAf6FJ8Ap639PyO9341WaFnskDixOUt9yO8n7piQp89IkcIQ7V2zfD1vpaD10LkU6dhhlkVwBKpz8geklJmebpf7wOzPQDNeeRma9vRN5mBxbAYE+ExyOYYIhA86+fILtiQVv7E1RpdfJZ37J8/sOzN++g5jv8sw8azPO0xd8Bi9RsRM2APdrPCQvXBWGfikVbCjBUHiJDIMTk9kqbmF2hLcItWZZdXTDJJiupfkX3nTf7B4XS+wi9XQyAsGdHpgQn4zo92t++0PiaT+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR04MB5419.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(10067099003)(5023799004)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDMxUzdPVXdrM1gvazAxVWwrSHk0bmR6djVmWUlPQnROY25pckpRKzdvZTE0?=
 =?utf-8?B?YWZ1a25lM2ExL3Boc3lhSXNoVWgrODlsaTR5d0g0blpiekM3SDVqaHlydUJW?=
 =?utf-8?B?c1ArdUluTFA3VzZucllYQjR5Ti8rS3FHMENreFg0Mk1BOWFuTDhqK21ybFRC?=
 =?utf-8?B?K2FIZXBiRWpvRDRWcXQrVUFPYzg3NG9LdXBQQ1NvSFhVMDVXVWVJVUtaMzlx?=
 =?utf-8?B?L3hWUklNMWdETDAyUVErbHp6ZUd6TXlmQ0tKNnlZNkVTcEloYjhhTGZ6Qzg4?=
 =?utf-8?B?YUcySkc2OHJ0UnFqUm96ZGNhYmFlYVExRG1vTE15V3R1OXE0RG11eVpQM2Yw?=
 =?utf-8?B?Yks1Y0prM3NvL3F4aDQ2WXBiYVdtbDBqbitTUlZJS1Q5UFhvbitkc0xBa0Ra?=
 =?utf-8?B?SFhNVlRxU3N5L05lSDVnbnNjUEtNMmFtdHAxeE1vcXBPTnJXOHNzajdscmNB?=
 =?utf-8?B?ZG9qdktjejJBVWxzelRvK3ZTZVZDWXR3SEFiTTZvTVIvcmhUK3pNMlp2R1VZ?=
 =?utf-8?B?cUNRSnp4OEN5NjRHZVVDYVpOT0xmWWFydU5USVVQZkQrZklRYjd2WnJXTHV0?=
 =?utf-8?B?TWUwM2tpYTlNdDZkNFBoWlNGMXJvNTlGM2JoY25vNmxGZmVlK0VNOEhQVU1t?=
 =?utf-8?B?SStUcWRXUCs2cFNQbkt1Q2ZRSklQVi9sVXdJS093MkwwWDFua09NSjRpYWJj?=
 =?utf-8?B?bnhld0JBTnZ3ZHp2VUZ5MVc3a3ZnOEh6ekl1dTBHMCtTQTYvYzg2N2ZkL2xa?=
 =?utf-8?B?L1JKL21xMm1RUGw0SW91TU9RV09UOFplTVcvenFRZ0FsdWxqUEZzU0Q3OUlS?=
 =?utf-8?B?YmdCMlR3Q000NDJuSHhOOTdzRGo4V2RwY2ZtVm01eUtwR0VFQkRaM2ZUZkJy?=
 =?utf-8?B?UDJFUVdRWlBKc1FkdERMNTFpd1QyMXVnWFhWR0ZPQjkzTDN6QkhrNkhLYktj?=
 =?utf-8?B?UUxzRGFHVjFDZGF1Sm1ueDQ5QW1yTnkrR0JtenhUQ1V5U0NaVTRleUhESVdv?=
 =?utf-8?B?OENOTDN5Rk1Ec05MTElLU2w2Q1dYYi9XRE9NcmpMcFNzQlNDbmo4aEE5dzZu?=
 =?utf-8?B?R2g0dzJrcmRlekJDd2lIVDJIOHBMS3dLNDQrMjArRmloMGd5QmlEODhkbytL?=
 =?utf-8?B?dmwyWnZGUytjQ2M5WEMwVit0ZThNMk1TTEZkV3M0REpvOUtqaGpNMEpKaGR6?=
 =?utf-8?B?am1iZkJYZmw2UEZHZXRETlg4WGlUWVZBcjVxZ0pYcU85TmpCWWExWWdSeklm?=
 =?utf-8?B?ak1JN0JMcVFJUFdsWTBZaXpMcHJDd04wdlJ2eHUxZ3JHTW5nZXd3Z3RlN0dr?=
 =?utf-8?B?TGtOT1dudk9SWEl5NFBTZ2RRZm9vQlhlbk9UMk9kcVNVSFREK0ptd282Z3pl?=
 =?utf-8?B?c29IZkw0UGNJc2ltVHVOUE4zRWQxZmozV1VPc3lldmgrdy9CKzQwaUJZNFZL?=
 =?utf-8?B?TDVHamd4ZzlnaVkyR3lHcURsY29SZVI3ZU9ab1M5NElVQXhmdkhiYkJSWDYw?=
 =?utf-8?B?SVF5RmhmUk1DWE83cnBvQlZHMjVMS3ZJaWJlRWJra25yOEptZnpsUFBiZHFj?=
 =?utf-8?B?ekxOSE9OSExKaWJFUWRWVGNNbVIxbnhreWEvM1ZqWFlsaTRKcjd6NGRmYkZL?=
 =?utf-8?B?KytOK21Od2ZZc0IxMHhSR3ROSzg2SUxUQjllMzhEYlNORWs4WEl0N2FFbnJm?=
 =?utf-8?B?UlJtTlFLeVlEaDBrOHBncmR4QmpoQis1STFSVEd4NEh4Q2E5K0d6Q3lTQnV1?=
 =?utf-8?B?aWZROEE0eWdGMUlWZ1JSWWMvVG1rVnlUdVNpam9EV0dZZDBuOGtmWUlSNlYv?=
 =?utf-8?B?LzNyeTgrTHVuNU5qU0dBcFJ6MUE0enVIRWVzQ2llbHZxUFV4VllQK0NHcVpS?=
 =?utf-8?B?MDJ4NStUc0liSzhMTXMwQUJrMHE0V3BvamJxdHNLTlZsTzR6LzlKVm1RK0xD?=
 =?utf-8?B?SFhqaUlHTTBKL3lBYjV5S3JLTEVJVWxabWFacUUzMmVtOVNSU0EzZG9wYlN6?=
 =?utf-8?B?REtXNjhLM2lobU5GNFdPRHU3TitTdlhlSzhIZ2ZhZkxLQ2ExeEdselBuV2lL?=
 =?utf-8?B?S0pPYmxUc2NDMUMxV1AyOGtOSEJaN0F6REFvVGEwUW55STZWTDZaT3VrbkpT?=
 =?utf-8?B?VHByaG56OEVLMjl3QVJUQytSNmZWaWhIbFNYK25DRi9oNERIKy83d1R0d1Q1?=
 =?utf-8?B?MVh0aXpvajRsV25GbzRkYzhJamxxT3BkRDMyQ1QreGZ3UTE5WGw3MUtjSmtY?=
 =?utf-8?B?U3JJTjk2bEF1dS9KdG5CMjJ2SHZoMXY3WTd6WUppdWgwNUJ5cUhEVkhQMHZX?=
 =?utf-8?B?ZVVMT1JWKzF1MTNUWU1wMm05bWFpYStYUjNmT3NHVTdKNjMzM000ZHBodWRx?=
 =?utf-8?Q?g7Z0GVNmRN9q/hNgR+hbfCv6ULVXmj+cfV/5xIkslfnmX?=
X-MS-Exchange-AntiSpam-MessageData-1: 3OaIm2cuy7JjwQJVjCXFeCdbnc7yJUYBDMw=
X-OriginatorOrg: espressif.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa70951d-d3dc-4b41-d3ed-08df1d7337b1
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB5419.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:14:40.4365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5faf27fd-3557-4294-9545-8ea74a409f39
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yvg7w2TMTOd4mEIFyg9PRHwy1W279/wyqM+S/8z6LBnePnB7gpGNvAaoNN4B6MXdW0MBvDsJhFDPNl5JY7lG8ScWcieJz0ChBh+cwslfO8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7983
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

From: Anton Maklakov <anton@espressif.com>

commit b2c860c6dc50 ("riscv: fix use of incorrectly sized variables")
widened __kernel_size_t, __kernel_ssize_t and __kernel_ptrdiff_t to
long for every RISC-V build. On RV64 that matches the LP64 ABI. On
RV32 it does not: the ILP32 psABI and GCC's __SIZE_TYPE__ and
__PTRDIFF_TYPE__ use unsigned int and int, as does the kernel uapi
header.

The types are the same width, so the mismatch stays hidden until a
header typedefs ptrdiff_t as int without defining _PTRDIFF_T. U-Boot
then redefines it as long and the build fails.

On RV32, this fails before the change and passes after it:

	_Static_assert(__builtin_types_compatible_p(ptrdiff_t,
			__PTRDIFF_TYPE__), "ptrdiff_t");

Key the typedefs on CONFIG_ARCH_RV64I, as asm/types.h already does for
BITS_PER_LONG. GCC and Clang define __GNUC__ and take the
__SIZE_TYPE__ branch, so the size_t fallback changes nothing for them.

Fixes: b2c860c6dc50 ("riscv: fix use of incorrectly sized variables")
Signed-off-by: Anton Maklakov <anton@espressif.com>
Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Cc: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Gustavo Henrique Nihei <gustavo.nihei@espressif.com>
---
 arch/riscv/include/asm/posix_types.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/posix_types.h b/arch/riscv/include/asm/posix_types.h
index 0fc052082ac..85b6ec83dfa 100644
--- a/arch/riscv/include/asm/posix_types.h
+++ b/arch/riscv/include/asm/posix_types.h
@@ -36,11 +36,18 @@ typedef unsigned short		__kernel_uid_t;
 typedef unsigned short		__kernel_gid_t;
 #ifdef __GNUC__
 typedef __SIZE_TYPE__		__kernel_size_t;
-#else
+#elif defined(CONFIG_ARCH_RV64I)
 typedef unsigned long		__kernel_size_t;
+#else
+typedef unsigned int		__kernel_size_t;
 #endif
+#ifdef CONFIG_ARCH_RV64I
 typedef long			__kernel_ssize_t;
 typedef long			__kernel_ptrdiff_t;
+#else
+typedef int			__kernel_ssize_t;
+typedef int			__kernel_ptrdiff_t;
+#endif
 typedef long			__kernel_time_t;
 typedef long			__kernel_suseconds_t;
 typedef long			__kernel_clock_t;

---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
change-id: 20260925-for-upstream-riscv-rv32-posix-types-65f46e21fd8d

Best regards,
--  
Gustavo Henrique Nihei <gustavo.nihei@espressif.com>

