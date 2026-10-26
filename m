Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04459606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wGsqAxHF;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=b55a4AZr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6AE580974;
	Mon, 26 Oct 2026 08:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v-dBF9vI82sR; Mon, 26 Oct 2026 08:14:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 31ECB80DA2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002474;
	b=Ocb0CGiRwBwLu6rgtMPiu0mC9utLxJLfRgKzR7dn5V3Ge2AC00CzdNovQ9DfXzpg9dpu
	 0TLvdQostu7RIDBeABrOGDtiWs0J2RMSrCnqwshMjQ7Q25JOCo07NU1ETQhoNGs2uSic+
	 VQyBHzEknSoVouUC/6tuGI6sNtKjR1lz2eHQSnIqWXrigYeQK3uVJxtmHeMFaWpqWNgNe
	 w3o8joqK77Q/6Yhns9ap3PDPDdb5IE0L7RRw5Ih/DO9fbsAXwHddG8j/oKDv0pB5KJsgA
	 yANYDaqWXq6S2ars/MZyPKAqwZl3IL3wAdqe5gRTm2BY+T3EI6NmApYOYieYqVGRSRg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8I/yxz7MW598v4TMnpTBXp1u1OA/CpyAowggDVzqT10=;
	b=hgkQf+UsGW+fX6Vclh18jufU6bE2VMFjTEmVoFfauYJQyBDcRM6iXaSpcYTKUBHhXNQH
	 JnKNSps/l8c3e7kpM9APH9IgfD61YgyxU7fcAagnmsnmx580up7wGUlPOzS5u2Fp5fynj
	 fE6phnZ7k58bikkAtDw8Fo/NFdQ9rheZAL6FygJWnsscXn2F158TGq73IzviSyiDcGwJa
	 Rpxr5tvc8a9FN/qXuqHyjNNKs9Qth0iTZPkX/SVubesIn2FkpdLprwEUjIcvC7dxCIa2z
	 RCDd9d42tP/HI1N600tCD6gK0Ag0FFF+iQbohmGD5X98JijjV301YsmAQc8hQa9v56Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002474;
	bh=8I/yxz7MW598v4TMnpTBXp1u1OA/CpyAowggDVzqT10=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wGsqAxHF3ha7BccQp2deIA1JdWSrCKfGaV4JjXE8pdptFYkBt60M/yrebiFU2CB/W
	 ld9KFaJOOq+yYjbj7J3mrs80FdGiKOcb7tpnjWN3UjLhWB5t2SCHFpPwYldY3VVlKJ
	 +28tzEbiN5zlGA3FPNgYjISWo3Gam7jHzknSqn8ylZQwWxV7kazY8x0jZQ+5D3WQ/R
	 DZTupwh7LFQJeEgptNbEhZN3g/o7FdjnWD54YO3Tcy0Q0zVeofML9MlLBxTUd1MkbJ
	 5GQ2JDdjUR+jglzrXES+MmbyNU3EknOzd/P9z1P7uN/1hdxpuBGOruKzcYqiMs8+CP
	 XqeDp1kOPBKtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31ECB80DA2;
	Mon, 26 Oct 2026 08:14:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE820334
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C43676061F
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wfYsq_AdLnxO for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:14:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 354A96060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002471;
 b=c043hBgShm3r5oJGEuwC2VRqoQ9D9n9V/AAgN4Ds8Q2m0TqPl44+6IiiXiG2bE3PVrSp
 WhoRC97yz7Aep1e+Y3nPwbVNR6dsDlMvcqszBDTwdyj11RtnJl8xnPTOt4kwuETtVDpfY
 Y6ZKECmeY/fKaQz3u1s023bRJHBrVh/ADG6bsZSiOyENzvsyL0iz6Kw7KKTFkJ8YXO8/k
 qYO0wpJvGFEZAsIldpC8HmlK/ypE0HDlA/BDjrgYBOhjEUU1toOCv0cQxhPRqCR5Mcqwj
 zY6U4s9u5f6+He1SdFHXUzqLn3+wCzmK+EnXYtK56zzT2cj0TJ9igjxIhlFGVxgu8jA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002471;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-Developer-Signature:
 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
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
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=8I/yxz7MW598v4TMnpTBXp1u1OA/CpyAowggDVzqT10=;
 b=DPOwGKJONqIh7KkXPLjDaZ2vZm4XBJp1sa0+36V24q692447SKbCP01y2ixXd58nArNo
 4euLo4MvB/OFZvTL9bNtqPDqX5SjJGsquTIrzd+gRNaPnycw2VDznkjLDadMU4pvbtWfX
 8XipRQrD1hAHBVh/3q/ppymQIHhRP1yBHRBDYql1pcxVgnfnbs91DyIMs1ZndYzTTiL5h
 dQxROSkmxguuIHkVDoCtolQi0CrudGQdkodr+FgRI5ms50BmAaoWyzVzCZa6Evn/Np4aj
 y2B5FulFOyAb7CL3+CT6NnVt8nOEDayInsfRnYJadNbCKVOVUQ+qbRNWM1dtpW4mApA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=b55a4AZr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=b55a4AZr
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 354A96060C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfLQlmUTQt1qecdj3WZeM0XaLpvvbBH7rowtXa73A/qL4ajNEdlxk+XoVFNFylJJqvxsFT/zJxJHUUcNNOOq6CjhLEKBIY+ysdOV25Wy2dBWpTXtezN2G85e52ioUyGZWMsm+pTcrr/U+dSsjoB0a5MXGYws5/885FgrV/5v4qaz3/PYWPe9K7M6xr7oMS6L1nl6rnN/I106VnfmO1dVE+hsuTiRMpI1qlJihtmnK8fA0cDtYBRI3qBFJRjqZjIhpx3FqWjOXS1nZ4BHIfFEhbwM1Lb11dFWUYAG5e7DW6H1ZDX3Tx32poeL/dfrDByg5mU0FZZqAY8RFGs9GIUwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I/yxz7MW598v4TMnpTBXp1u1OA/CpyAowggDVzqT10=;
 b=pAj0UCDrthjvkJp15E0DdmvNoQw4V5LyoEs6tHjqV82lvxOy2rOi4IZzd1kqdtaJNd8qVhssJjoKJwUf3larFmKsBHWtJWkxls4MtgU50B4cE6qG3Vyked5T+o8IXy1kLmCn2ypHGpZPt/UlEjGpczHudowOJp2AYSW2cEKNKJp+vs/4IYjG+r47NgZ//qo9KtFpyGHFHkj/1iEjsjDxBRQG48UodnBs4NzJKEchz8dHFYwDK/SA25MMKkdMVAyTsIlb3SEA8WyEdGWTfdi7ryoI02bX3GXLQJfpDcafwb5f3cJHw1LqKWu708uOQnwIcJP7TRvKaLHJtwI5L7Lxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I/yxz7MW598v4TMnpTBXp1u1OA/CpyAowggDVzqT10=;
 b=b55a4AZrgq9QwRQDcQY4J6IZF2250K9QMxW3d9Xk759BsPv++pRJDS9jmBEDuzeIMig+R7dKfDjF4Ae8g7TlLh0i+YiNdOcXO1IK+ty91hsv1JHncQXASq9Xx0G453MOrLlYMJ2JBCES6qxulC/SkcqlAD60F5yykWmSIMZwhck=
Received: from CH2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:610:58::39)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:14:27 +0000
Received: from DS4PEPF000001BE.namprd21.prod.outlook.com
 (2603:10b6:610:58:cafe::2d) by CH2PR20CA0029.outlook.office365.com
 (2603:10b6:610:58::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 08:14:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001BE.mail.protection.outlook.com (10.167.23.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 26 Oct 2026 08:14:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:25 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:14:24 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/11] xilinx: mbv: Enable CMD_EXCEPTION
Date: Mon, 26 Oct 2026 09:13:46 +0100
Message-ID: <0c0ce458bdee1b947f14493ece5121545faaff38.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
References: <cover.1793002418.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=701; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=zuprTvNSKeM/L82JaCH7YJiFgKjHycW1N+Mqo09WXrk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd5z7wyPPFshkyZqeeL1nonbvuv8iu7fzNmTd4/WLzV
 RefmGWd1FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATcXViZFgdnHdwwxyb3B1M
 gvc4zi/RuNL+6rpQUcuf2Wtbn/PZSp9l+B9iuzuHdeIN/UnNHoyMTyZ1dO60sslpfN7/UCV3u/L
 PWFYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001BE:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2fb7fd-a4a9-4df3-7334-08df333926c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|56012099006|11063799006|261009223027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: T2pbvYv2YaOVXX72AvWe/ZKl4DWsP94x6JjQF0CgHytNh5w3NfiruNeFqU7yyVK/35tMH5flkQs8kr2cfHarKiDLm756XSlsvp5wJwnTfeZ1/isVFzlderCeVZo4y8+JFYMlI1hRHnwl23KFxNRzmE5T4udixe2kucL7hTxV0Sm0axagWZEsrNG3vM1AsS1p7hdO33tb87ia28UEcIxbmm9c9kxMKkei7jWUJ9Ov8wEZR0/GokFc3VSBH7XeJEV0/mjtXeOmdp+vWAIFGKiDK0jeoXFtuhCFpMKa7qIkEdEp6Lt2Hj2ZN2q1kEGqGsUlpgu/mUs+OcwCgn9Y0Zd4LVXjiangZVp+BuoEpahrMjsw0q2+RVnZL603uR3ZNRKaQhMDS1P0bUAdgPXcrZLavxyT0w5OMTFHs0++Ml7EsC4sRRcVZ2MEr+O4krEjAbWefVOZx9gyDORGhDWmz4nPDXcHl6mCxOxvkp1Wp72vfvH17CUnEcriwS1lyfkvtmC/5/lQYGdNwSQG/EY7sDOeUytwFZr36KpucTEtt5w0WIcOiUkQ65orDbavWgGCBETkE7t2UgqAaDos4gr/Mx5cPHhoPLSjPkRBUwa1vMdOks0ju/2a5eBQ0hw4bi/YpAEgscCuTezOkh5QtXngahBJUFDQB8QcYYT8pYk61VzZH++DcPUbrdx2fvq1SaPHU8ynVDlObD5ZJpfBWKpH2ef0Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AJsTZOFSNDsuNGv97TahIsUEBrA0loPWpsRb3p8kh94asUYD3owKukwv4tmSRhDDBwR/rNVME/rAL5NbakUD7Vt/Ra97CWemffZGFqKFTpDfm9/2bOxgNrZIET0W2StXfY6GPLtNAMqYrG4V+2oSfoE7GfqdTmUbYCE/ve/PXbroMB/2RyYamgODz6Z84xS2QwmTx/XQzLASOETGxBIdOkDA7fASseQgCxUuC1z7ODkMnEA7/EUjH4tj0NwxyRUxFYHbU2YsK+Vp3YofajbDnemQu+EtaFlAszQgJ81RtrmPL4539NYxAOzqvTKm/ihAMtFVCKPN7lszx6u+nRVDMNCso8eSw4OQu8gE3rT4SnS+VejtnKeKpFY5d78xWWCVRzfNx4Iw9ZHzH9TGJybQyNOeQ5WP++jfh1g+/uoJAxiNkvmX77YqFgra294p97CV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:26.5947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2fb7fd-a4a9-4df3-7334-08df333926c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001BE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Command is useful for testing the system and checking that exceptions are
working property that's why enable it by default.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index a1a2e3b0feed..dfb0865a5c27 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -47,6 +47,7 @@ CONFIG_SPL_REMAKE_ELF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_SNTP=y
+CONFIG_CMD_EXCEPTION=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
-- 
2.43.0

