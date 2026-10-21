Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B42606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ti7QuFoo;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=WnCTb6nm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10AD24087C;
	Wed, 21 Oct 2026 08:08:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XJnupFULzzWL; Wed, 21 Oct 2026 08:08:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C25D840828
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792570114;
	b=ooNoUUDS92PGx7VU4aZ5bskiPfUtP9e4KNBQLuLUYeulLwct0IbyrtehVN9+5icr2CZf
	 xHi0tZ6OUEajkv5+qmcGdJ/BbLjVLiGuDgOb60Hxl3mtZO7efJ8gsmP7fYTYfisc88eok
	 QcXrj5ZTX19xMNxCeh4dvXwl5ubBcZqrLghZV16vMIGkKksr55V/mBD/l8TRpnoMK/O1J
	 EggsGbsEgXQFnYC6A9wCVrAiWesXTyb4n0dcScio4BmAiVDabEBvZJKuPF1goLaCprWsM
	 1uIteqFK6ZoEGQ4EFrq+HBYecWYnJ8N9baDxBnlgBf5lDbxin7NB1frJk8uE/KDpehg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792570114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=sg5fD5Mk+a2mTNgwOP/CbsjHZ32JJYWvgvNychR0JVs=;
	b=FoLiJE2a/IZhu17FTRaPjFBL4bncj/kqM1kY60Rnidz2yCARuz7SkyPrS3iHGKohPRQQ
	 HRsOSMww/8h+4VT/a5PANKP6ahMzsyxwHUv2zpiqYG5lbuVZP0EQNQqVjukmNkJsu4JnV
	 7XiawcBcGmRBmET2l4gxJHw60IKvtw+yiG5Q+w60oNppS8EoZbq9UfmA1vYFOnb41JW8E
	 T8WYLwAd2D6RDV0llwO1yGgXPeQxdPwSkmE7N9CTR7cfwjr6ab4MZNzeYfxaHZaxCMoGh
	 yahbnilLEeU75odnLP39k/bqwNo3hSV8E8Y3BaH0StuVsWy4hJ8m7DS5ege2bwBZ/VA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792570114;
	bh=sg5fD5Mk+a2mTNgwOP/CbsjHZ32JJYWvgvNychR0JVs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ti7QuFoo36NwABfAfW5dVuXGrw6rUI05ISjWGy7UIE4lw9qRCNbHGTtzlQHbQzVER
	 zJfddpEHnnd83jx4n4uhTpvIRvVAGcVVs6and1USFz3CsEvpmS3kqOjuUI/0CdkqHK
	 +2J0qYBuRvZvMqmE39g78ItE+ISHrJi3etqYlrt0NIhXs0/QZtMzy/TmdoJTcLvMOK
	 u3KX+HK4D9XQX57y6LSorK92TAHTLsMxaWgmIiJnkt7Wk77XTy3FX2ilhILgB2g2RX
	 N1CfEGynp+j1ey95gDmLb/JXtcJbqtxLGtnIf/Jz2Jdqg/mn5w+ZP2bISKkNhvbB3c
	 lnIdNU0Jy8Tsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C25D840828;
	Wed, 21 Oct 2026 08:08:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E10AB995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3CAC810A2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K6PVpma44WiB for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 08:08:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3061B8104D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792570099;
 b=Lm1OwEzonk5JEprJJYL/21RUUA/sabqGNgwE1a9IlXkFMTjkHAYn6VKvi8nGFgXTYdSA
 6TwRsXcl4DtG1N4uALhh+mkJhyGwFAsYa5GBUL7PWQ51o2jzPzu7mQjL9VjNrLERH2EV0
 N3evvC4lb6NBVduqhKWGp7moo0FKkkzbPPUin5KGEGeKACt7W4SPjpkosjnczGrD7siDv
 mRNmV6+xqw0Ez/m48aPsNsCr+hRMXinTTWHzFr51P5A4NX8GwIaSNrxNxbyhNym+v80yK
 pbHA3rkAgBruJM7AOsMV44yh8pbmMU53DvSxdiggaQzlp2KYx7Vr85v8yTJMmGRIRoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792570099;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=sg5fD5Mk+a2mTNgwOP/CbsjHZ32JJYWvgvNychR0JVs=;
 b=GhAhvYI4iJxLUubiUxQ2A+sK6WO1v0T/rDKSG6aQXqf01JFTrDyQ/kp+WkrqXltb7I3n
 UJUuRUvwjqHcvVEpJjMh8Po33HGLBQOHqhNLBF4oHH0cmUx4Eo6gAuTA92awO0CbkJ0UB
 KAtbGhWb1SFIuU/w/ZTjzZjbkXqliLkE3pjZldZKY391o2Og8Al7o8gTOn6JlYMO2j+XM
 2JAut3+Z38Ah8YJwvP23coqdEQPQq0YHI9BNJQr+rV8P/QNwMUHGj7VfLhIoZD0a6QwMS
 sy/WgpkGnFTagIo3LZeU2eCpmZ5U5E53j7jz30imSGzJ1s9Ho8rWxmdfdr2F3TrpK5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=WnCTb6nm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=WnCTb6nm
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3061B8104D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBihcIPXp/i/dQmE9sQa1Kh88/WJZBobfIDW30KIPbwBbiqtZ43MHQrXNd67ZBvfkF5p/NpyYhQ26XCeRbL8+In/DIoe7cm8/D+Fvv3yl7C0QdaXnCrt0Ek8XtTstDD9cskJsCJZF2drqQhiHBoarrhO/VRxlKKoX/gswUfOpr5TQwaq2Kzlt+pzTM7Ml0KzlXAHpXGHo7XVwR0j+tU/bY0RAPwUdzvkl36+lCGq3o4THxaaPLyIgTvj/QPThR6R5wI06SOwloYgxO7AJS6rVJWPwza4MmioKYJt60nLHseEbPee8l9WwzWFCx4U86+t+lB/gp0m0Duvgk+NKF8b3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg5fD5Mk+a2mTNgwOP/CbsjHZ32JJYWvgvNychR0JVs=;
 b=dWm0fnOUt3NE+j4yS5zT+oNK61G8/kJOFPMVbGcZ+OqOpptZpmJ+pNlkLNf733Ey3+Kaw4e+JrewIsnAhAw5V/BwLupi7q8vfg/ZjicV9aCp1VnTOSWUjcgpnw75Nw8RbsoeOOduMWJ94jk+twtQgd+5IXJ2JCwVu/aELrIvzAL0YPFErF66Tp+5270gh1Lcot0G2sqOVE+EJfRjH14fIJz4aUFFOFKTxJdOEDbn9h7EbGhsiBMCd9R/1vk9Eq0+4S5guMKGpNmQlBlPcH2w/34U3HXAUSdqnLB8l8pbGFvd6ApLJL1tt4jpF9nFwck/aFQ2CowTnCcqYIoTBbffOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg5fD5Mk+a2mTNgwOP/CbsjHZ32JJYWvgvNychR0JVs=;
 b=WnCTb6nmR73hxkIAPD3RUW2XApoLn/j5JGhuhwLi4CpYgs6xEx7P/LFJbg2TUNI0oLEJ9dKLty6Lu8bw8GSuihX66mwQ4J+jXAHhiIxtT9H6TaCjDh16ZyJpEg2ncnzvf0SKuHiqeya1YAtyOULiZJzAmPtrIba+wjEt0zuHDS9dTF3wVhzDLK9xLukyKVRs6/U01Yg3Mnm8qx3PVkBY6n/YAp9G71wkKZJbSjI8NPfomqdakXyA2YOqMqoncZBg+uAy5roTeumcfEfQbEQbhsd/n14aVOr5IZyXhZWbU03msnh7LDkflvVhGMuSYJtDYADnZFaEy+q74eVcIVmlVg==
Received: from MA3P292CA0061.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:49::14)
 by AMBPR07MB11383.eurprd07.prod.outlook.com (2603:10a6:20b:737::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 08:08:11 +0000
Received: from MAD0EPF000008AA.eurprd04.prod.outlook.com
 (2603:10a6:250:49:cafe::55) by MA3P292CA0061.outlook.office365.com
 (2603:10a6:250:49::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 08:08:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 MAD0EPF000008AA.mail.protection.outlook.com (10.167.241.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 08:08:10 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 31EB5200B5;
 Wed, 21 Oct 2026 11:08:10 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Subject: [PATCH 0/7] watchdog: add get_timeout operation
Date: Wed, 21 Oct 2026 11:08:08 +0300
Message-Id: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOhy2GoC/y2NQQ7CIBBFr9LMWhJEYlqvYlwgHeiYCDoM1aTp3
 UXt8iXvv79AQSYscOoWYJypUE4N9rsO/ORSREVjYzDaHHVvrGJK4tTLiZ/GHFVEEbpjrqLCYcD
 B2GC176HtH4yB3r/2+fLnUq839PINbgbjs7ZT2bR1/QCHFBIvkgAAAA==
X-Change-ID: 20260824-rinta-watchdog-gettimeout-f39e924f40c8
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792570090; l=3355;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=asmEdW3O4W3+7v0ms4xgg6a3zz5AvZaF2Tpa/hQdIoI=;
 b=doeQwga9mL9KOvEbhkVY5okUByLNc9GL723xKpS8LQ5twN+dMSUB6sYKbx7WaSl3AGRAeKaFH
 2MuOuy6nw3ZC8YJim5qzeXnV806XWZxFila4Uy/F05H/1ES4mygI4HU
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AA:EE_|AMBPR07MB11383:EE_
X-MS-Office365-Filtering-Correlation-Id: 864cc221-9eb0-43bb-421c-08df2f4a72c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|13003099007|10067099003|261009223027099003|11063799006|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: tm46Og06r4VvPivR7MUXEFL7mts9kCdkaU/pi9vnRvc1klrtuTPkJB83fR/yK82gIK0caHczwjrWTGziDhVawp364ka0/Gzld+20jICJz4Uaopz7SAXWMIj+29QLxh+Np1joBa4sgtFJ6lwYhI56JiK/Fh6Ux2RUYcF2gryKL92N4WyZCFcCX6hoHZwkTSQwz81qVZX1/FDgjk7AfDodqbJ9Z7MMCaqvZC3gYHl0G3+4koqVrgVLWr0gj6IS/r0LO6ajBG+5SncnL1LKt/nQr0e+hnomAfwYC0LWNgmlEbfHzZFjqUtqooggRzKBWttm7qr4GqtbH6uVg+vjXrokX+kqvaBVEdhrpCWzYVa2nX02XcQKgvL18S9x2w+pdPqs8eIE9eZPi8h756MkjRFpgumEOvZIZkpzBZCPIfHqX3ZftTQkFerXwePzgHco+dN/MGm3/EKaXuJb+EPhkTnMRdE6Jk4dobpnNImSVtAvg4H5eJpaW6T/62bO3D5uDLXvFhKJsy5QRHgGHSsFKwgqbdTFHrzs5hNnOCIryQYYVX4kYu8wwo4kkr+S65l1fdA9WSKWyur8iJMVD2Bvho8+Da2nQgkVlXiq6ICkEcW05ODlLuC7sn8zS+F0uzEai9/BkbE6vnTGJFnSdAxifVhe/2ixhHQOioDwy4BfuvQjgLw=
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(13003099007)(10067099003)(261009223027099003)(11063799006)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mvc2T6Yit7GRLp0IAEcu9/ndjQoh5iREOpYmdt4USLdB0zSJ6TUsBkaJZQ987RUYki7x1WslVTRR6HONocLbZtBTq8oHQx/8PPtxiP3knL/SEKDZPUF0Cz/+lnNI7JsjC4UxJnGd5YBWwHNnjTKEsUzDYKNPJ4xxaQRY5MoCbbBq9M6W4PVG+ogphpyGW4iLWbbMqNtdpXgw7oGegD4MoT1ZQW0JL9HTlQvmkDjDtUqlDAFHmkRVioT0O3BPAdqgtOorCQvJNOATAoIoKf+N/aE/6kfjUle49iHaqv1L7weiS88PyRpkK29GFIKv8EIfF5QNsBPMTuR8NgcyF0L92tZHWi+qNrRbUYfiRsrCakW+H2MuqxAIAsjdPT2HFe4OA4KcL0QwD437WOzKxCsMR0DDbjR1PEuxcKT/O3XWVob+dGtqIVRXO1K3PbF7NMna
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:08:10.8279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 864cc221-9eb0-43bb-421c-08df2f4a72c8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MAD0EPF000008AA.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11383
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an optional get_timeout operation and a wdt_get_timeout() helper to
the watchdog uclass so drivers can report the timeout actually programmed
in hardware. The requested value passed to wdt_start() can differ after
clamping, discrete steps, or rounding (for example power-of-two periods).

After a successful ops->start(), the uclass calls the new operation via
wdt_get_timeout() when the driver implements the operation and uses that
value in the start-path print. The series also adds a warning when the
programmed timeout value is not longer than the servicing interval. For
drivers that do not implement get_timeout, behaviour is unchanged.

If wdt_get_timeout() is called while the watchdog is not running, drivers
should return -ENODATA, so callers can tell that case apart from a real
error. This is consistent with arm_smc_wdt, which maps a disabled watchdog
to -ENODATA.

Add a 'wdt gettimeout' subcommand which exposes the same helper to the
U-Boot shell.

Implement get_timeout in designware_wdt, max6370_wdt, and sandbox_wdt. The
designware and max6370 implementations have not been tested with hardware
as I do not have access to those devices.

Add unit tests for wdt_get_timeout(), the wdt gettimeout command and the
servicing-interval warning.

This series is a follow-up to "v3 watchdog: report effective timeout"
[https://lore.kernel.org/u-boot/20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com/]

Patch summary:
- Patch 1: Add a get_timeout operation and wdt_get_timeout helper
  function for wdt-uclass. Update the wdt_start function to use this helper
- Patch 2: Add a warning print in wdt_start() if the programmed timeout
  reported via the get_timeout op is not longer than servicing interval
- Patch 3: Add a gettimeout subcommand to the wdt command in cmd/wdt.c
- Patch 4: Implement the get_timeout operation for designware_wdt
- Patch 5: Implement the operation for max6370_wdt
- Patch 6: Implement the operation for sandbox_wdt
- Patch 7: Implement tests for wdt_get_timeout(), wdt gettimeout and the
  warning print

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
Juuso Rinta (7):
      watchdog: wdt-uclass: add get_timeout operation and helper
      watchdog: warn if programmed timeout not longer than servicing interval
      cmd: wdt: add gettimeout command
      watchdog: designware_wdt: add get_timeout operation
      watchdog: max6370_wdt: add get_timeout operation
      watchdog: sandbox_wdt: add get_timeout operation
      test: wdt: add tests for wdt_get_timeout(), wdt gettimeout and warning print

 cmd/wdt.c                         | 25 ++++++++++++++++++++++
 doc/usage/cmd/wdt.rst             | 10 ++++++++-
 drivers/watchdog/designware_wdt.c | 21 +++++++++++++++++-
 drivers/watchdog/max6370_wdt.c    | 39 +++++++++++++++++++++++++++++++++
 drivers/watchdog/sandbox_wdt.c    | 13 +++++++++++
 drivers/watchdog/wdt-uclass.c     | 21 ++++++++++++++++++
 include/wdt.h                     | 22 +++++++++++++++++++
 test/dm/wdt.c                     | 45 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 194 insertions(+), 2 deletions(-)
---
base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
change-id: 20260824-rinta-watchdog-gettimeout-f39e924f40c8

Best regards,
--  
Juuso Rinta <juuso.rinta@nokia.com>

