Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D91606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T2Ay0Tut;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=q8QrzmBT;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=q8QrzmBT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56FF4607ED;
	Mon,  9 Nov 2026 18:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CKzS0AYCcEst; Mon,  9 Nov 2026 18:11:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5873260703
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794247912;
	b=oAuLa33FVKITHR/ww3LWrFrptp8Z/L00g/4wajTZ2JF1gwhotmSjhI50JjMPaIHDNrg9
	 aZLJAvlbkik+kr4zynUwiKy/JQkDZju2SPFyaYJrH5TSj5hXYpu9EBmjduZ0FEWlkXVUa
	 XkruZshLPNNsFIIruWY7YHLzELe+x0Iw6DkVgQ5xbFWg7488/9Vq3xhsalySiipJh44gf
	 pg4CEG+iHflZmaNIYS8xP9tl/vuk/D1Uz16sAPKNmlhlEIVDTkQNwv/6HEchJ5z21pn4w
	 DHrTW+eUbbzRzLUo/HN/VoQm2TMYnurE0OmPbptqY3YaIJlYLeINWSz6913jzB3lOEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794247912;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Content-Language:To:Cc:
	 From:Subject:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UEAYxVZWem49ZT3jtVFtJUB0HsnomlCdlQGam+q0hUE=;
	b=AV2BCkCaJ3uvwrDxYLNYbPubfWrUeScTL8EoFLendGdhOIA0hkDa/ta00X+y3/SinHqa
	 lzOavqoUCgmZQWboa8/jK7Pe/+qSKL1oLNSVvfuq54LXIwr8Ymt1Csw+Zhd14zhH6KpwS
	 HEw/6rfYNn1HMFkwcHPgg3ovgXVV8YY4emsKwGpOgI7QecNEDvxnO3IEttfQKBtK4Ocvv
	 NIsWAYU1QweTGSfAbJOAl7g68BOg9TCcI0YTCueD+LMcyW7ujB6CKXKOshuzIabrJwepr
	 qLg8pBwBxG1BE6fbtxfXvE3cei0bxM+542TSZmmtdZSjkFufvPWapwwU0kkPXLJ1u8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794247912;
	bh=UEAYxVZWem49ZT3jtVFtJUB0HsnomlCdlQGam+q0hUE=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T2Ay0TutF7CgtcBSbnwqA2R+wnoianjhjVOvgFH4VsbchNjiQ0JWnygykw2+m+dja
	 /4uEoB3wh6t40dDLmqMQTEBmp5vTiVUqLBTz3aFMR23fsh/NRAIvH6+5w+hFS+yxbP
	 HAivlJ5DrusPzVGM0H3hRz1lQbc4xLuCMvLE+fNDWrBS9mjZUbmTdT6QUlR600L+q1
	 npf1Seds3bbSh9SXZpDK8zm4BrJuRUxNXQak2fq2zagayzzv4svk3UA6fD3sefAE6u
	 uoQWPirZyRXn6GB1l702jR1nFEf3i38PJFbRxcT5plJ21Lg5H0lSYFAp0I1av7vIR7
	 Vc9oyts22lRhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5873260703;
	Mon,  9 Nov 2026 18:11:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A14A33AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86BE64077F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:11:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvA_ONDBbypy for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 18:11:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ADB8040768
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=q8QrzmBT; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=q8QrzmBT
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ADB8040768
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEAYxVZWem49ZT3jtVFtJUB0HsnomlCdlQGam+q0hUE=;
 b=q8QrzmBT4ZGYStkDs9M6gqRqHrT2TcEwm1msKWqE4oC75pqJ5JRVqxnPfiueVgVKpv83tvdAugS9PSYvs5GFd+hMAGZA+WctQskCUT09S99OmFxlSAvcgLr5KdP76ErznQbU+eoPgN+/XmqjMxcgzJeBM4QmPuhwEUHQNpcR3YE=
Received: from MI2PEPF00000B85.ITAP293.PROD.OUTLOOK.COM (2603:10a6:298:1::41c)
 by VI3PR08MB916203.eurprd08.prod.outlook.com (2603:10a6:800:372::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 18:11:41 +0000
Received: from MI3PEPF00008550.eurprd05.prod.outlook.com (2603:10a6:298:1::84)
 by MI2PEPF00000B85.outlook.office365.com (2603:10a6:298:1::41c) with
 Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id
 15.21.592.13 via Frontend Transport; Mon, 9 Nov 2026 18:11:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008550.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 18:11:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEAYxVZWem49ZT3jtVFtJUB0HsnomlCdlQGam+q0hUE=;
 b=q8QrzmBT4ZGYStkDs9M6gqRqHrT2TcEwm1msKWqE4oC75pqJ5JRVqxnPfiueVgVKpv83tvdAugS9PSYvs5GFd+hMAGZA+WctQskCUT09S99OmFxlSAvcgLr5KdP76ErznQbU+eoPgN+/XmqjMxcgzJeBM4QmPuhwEUHQNpcR3YE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11747.eurprd08.prod.outlook.com (2603:10a6:10:646::15)
 by PA4PR08MB5902.eurprd08.prod.outlook.com (2603:10a6:102:e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 18:11:06 +0000
Received: from DU4PR08MB11747.eurprd08.prod.outlook.com
 ([fe80::b0a0:400f:1e10:ab52]) by DU4PR08MB11747.eurprd08.prod.outlook.com
 ([fe80::b0a0:400f:1e10:ab52%7]) with mapi id 15.21.0592.009; Mon, 9 Nov 2026
 18:11:06 +0000
Message-ID: <6f01e99a-8245-4027-8fa5-968e07bf2cab@arm.com>
Date: Mon, 9 Nov 2026 19:11:04 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: lwIP re-sync to v2.2.1?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PA7P264CA0278.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::16) To DU4PR08MB11747.eurprd08.prod.outlook.com
 (2603:10a6:10:646::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11747:EE_|PA4PR08MB5902:EE_|MI3PEPF00008550:EE_|VI3PR08MB916203:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5ef48e-9c2d-4c31-9c4e-08df3e8ce741
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|6133799003|10067099003|11063799006|56012099006|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original: z82VPnHZWrwFFKD9WRfc+5aBXY7gMtAxkKDSxGdsXBwMT53tDdJ/32Yj7YiGa+zEswh9ll99sXjvxJyTR3RjDEhT0sXMWywZtw7dRREwb/TLtMN3M1CdqtQAyD9XEQ01XbjE2OLcMXJHSvzvbAgStQ2E96omL6+sLhb0vXcnlpmWHMtesGvc9hY8vICYJqjSMt3SkFVlSVq9gsapwQv4Nho+w/GgXg5WB0+g1gKDoLgN95cW6Jj3CbgZTgWhaPlVtjpzE0+xL5wl+x8AFLCSEoyHGhHPxG/BhnPKyENb4O1gwxUwVpz131jtc+/out8YVeXMRLxG5Vjb9ipww/rNqbSDrUG4tjdmklXu7+wJHUX5Pu85v7mNLVZ/fLub0KAKyXLu5q+MFsMTIAktb3lYCP9IZavcReyut+HGCX2AKbynuvk/f5mqP+D/p30olUtKe4UxEWYXruqYkRAFJYgFAP5LX4yppnHDYlyb++j4fGg+qu9nEa5Y3GJkQI8vl59YXefNcq+jtjVDKWMKk/CGdRURjQkF+nP4/gvjBsYGu8jWUmTW1R7J8+YSMD13EG6c8gQkrEOgebynaxjTTVMKhe/Ow9lX8oqkQGIqofV0tWsOAYZvv2quGwITAggISHsV
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11747.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(6133799003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ZKHMcmLze7EmTQUpVYP3hdbv2r0Tn3I1yOt7jWw8gXP8Fiz8m+hlKCSSn5LXLUfV9bfbv7ydIsrzMDJCZP8+g4ouzIJIS3Di0HPbN7TtjS9eMcX2/jIRVyPKcPzfDsWm+fKWTSL61D1E0L5SVPsxgLgVl33nq+Xtj5RJSiodXtLbIiLKnMLERgnC407jvCwUaSKYiljd/oIviG2tOiqISr8uGQXyfoBLVzmAZjO2l/lleGIv3C/SY09LwqlUK1ctn8NuJ44b/Q0bGFN+v4LOC+EqeOXD+W8lxa1F/7m3UBe0/yyWPRy/tXUfQ19lyXNOk24JdVrkCFe8zKZpJ5NObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5902
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008550.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 39e65ace-4d74-4904-c2e8-08df3e8cd28e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|35042699022|36860700016|23010399003|14060799003|376014|18002099003|6133799003|10067099003|13003099007|261009223027099003|11063799006|56012099006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: Ur+TlwOHPBoWkQ6q8fMvQypBTDxfNF66hZjyJEGqDWaD39nnF/bNtdH6VQkWnm3ob4HF7XG6O4D331Vhu5MK1nwTLuvTZvCKJQDpgyOXplAs/Ux1g9jksoDn+lqFdgjpyT27EVd7kd11lplPGf2ync0ErwagpYw2pa7hbUgj7ctXMx6LaKuQ0zYMKtME6cfKknbHHgBJqItf5xd023e6e1aZ7Qlum+Qwy+aBBLvgYqP5KtQvOnykL6XR/rbAr7d3CZb3lQgDVE+s3JPWf06j1QjqMDi3+u/IjIHFzdNlyGGZT/HB92ArJYG8anxln87FBdQZkHmLHvQPCKQ/VaScY5cD/4cMGpUG8pqppy+lFJ1gH0p2t2CATAcr5oD0tmIr7kW9o6LBtyivxsqCs2RqVNMPWN1gWKNby2mTSNu7OQ1wNeVmtNPRkqcEsH7c8D7zDRpUa0OGuzBMxc1F4ZwKjzx2LbY0tefU+/T+2H24WPrYVvowXXCA/dgjJEy4HEVU0nE4idC7xPUvI99pi2pWG8lwWu49zYqzzjHwzzz0OzRK3ut930o49TAqiz33+4XtTF5QkzK4bs91FUsJcUJTJnioNNwTxo3NLgNphJnf9456Ztp+xjqsy3+csflyE7Oht2ZYgPyIweEIXP7Sg2cV/w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(35042699022)(36860700016)(23010399003)(14060799003)(376014)(18002099003)(6133799003)(10067099003)(13003099007)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +AApDBLwge5j3juzGbpct8Nsvm4l01gxQrkkF1YJX1YuM2+c9VU6Z+DVAaHshjmhxjHxAvaU+IIg0iOQDXyX4OsxebLKA0Xrj4XmNmAtwM40RJ4QefxBi7QJjF4ukoGHH8BrA9tOWClmor7e6X8MyXj9LSYGxBU6Z0HDoevUvo4Ueq2WbPeoTCnoWv7EYe7NV+vx/La0KLWVYyRi+EWUVrTP2/tBTsyv9Ig5/35FTngZ71U50v+W0jf8R0decQu0yXJvRurAPXwMsqbjvd1z3B0nFu03UDPDVShTSY30GbV6MkXeQZCgK9k46bNsUln9DsfM9cKMq69mNy98n/MbyLI0y2gL23ZldLLlfxus74Hedhcg31ITwmlS/Tn3TyV5iYN4lh6Kv7cMNzLJgdB26PE6qq1tcXTUb+P7NydoDtdM3FcnAp9NcvU2Q28JCSkb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:11:40.4909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5ef48e-9c2d-4c31-9c4e-08df3e8ce741
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008550.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR08MB916203
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

I'm thinking now may be a good time to re-sync the lwIP library with upstre=
am. The
tag imported into u-boot is STABLE-2_2_0_RELEASE (published on 25-Sep-2023)=
 while
the most recent tag upstream is STABLE-2_2_1_RELEASE (published on 05-Feb-2=
025).
That's 94 commits to import. We could also re-sync with master for more new=
 stuff
(162 commits) but I'm not sure about the policy on this matter. It seems sa=
fer to
always use released versions, isn't it?

I have pushed a branch in the net tree [1] for the v2.2.1 re-sync and CI is=
 happy
with it [2]. Would you like me to send a formal pull-request?

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/l=
wip-resync
[2] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines=
/1938

Thanks,
--
Jerome
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
