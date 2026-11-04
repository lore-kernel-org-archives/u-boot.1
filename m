Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231C4606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c4VHqe7R;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ops9QZ6M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4DA560822;
	Wed,  4 Nov 2026 10:00:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQshCNPqm2Gm; Wed,  4 Nov 2026 10:00:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 019AA6074A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793786435;
	b=AIJwwyyqiGEc04JaAMkf2Lvz+gnHDZUlN4qUY634BOpkvxjLZ0c14iIpD/DEHBjJKJNq
	 BFbhI3ifN9Q5IR/gj5PCQSy4eP/TotIwGgN0qVfVmAhHzpW2NKLUur9OG20npbxPkQMcJ
	 9lZrUbFH0nptqXLhfz3J8grUw9Qkz2oLkB2E7mGQI22Sg/lhpZuA52pi8Zg7YTevDFCcy
	 3Bc/a+PAjYK8ZLfaFGk6H7fcPfqb+q8ZCn5R+zfZok7vnC4nDAEd2sw4JJd2Q5UgpuOg8
	 71dVJcRFsF9di79BvEWZt3gPIpGWXc4BpEqieRsPvaUW8Pk9AiMk0xF6jyxjcNImx6g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793786435;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7puhJqQIr6krTUbkMfu/glwke/EE08WvZ7NPeRZOrmA=;
	b=CUD43o9VJXn6XDXZRp2BZRMPvB1O1ybbGanfgeodTOjAqFheBtclX3Vi7GgiVzm5Wr8G
	 v8WbxtNso2nav8PNYGMRCoZQf65FZpkM5WXd33hrKKQR8cD09IM4FpkHbkiX0BIhkCr17
	 zJ23jvVV9TLUNSxdZhQ1s3giTb5vxLbzTkKMJq8tLuw2i6IE2azQY8D8iTPnuouZ9t8j1
	 F3UwpXiUb69QoK7Umy89Ith8wjEL1nWXqEINCLwpzR0Rh/oos1m3V6giT5lwnArdjDgCr
	 xhw28BUjeFSepWTttedSOGEy5/JBQBSY0w8kHtQflCbXPV36Wqpf5FweQZbNKwMlN8g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793786435;
	bh=7puhJqQIr6krTUbkMfu/glwke/EE08WvZ7NPeRZOrmA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c4VHqe7RrGTIjRHzQIc9nuZBRB95sVnXaFxAcXe83LEOnuiXlfM4JNCNy1BYCeQ8b
	 EiYfMVmfqR/9yQMo6nKyRWKW3P4UMuUzNjRFsERqf0dRVvEtAsCMz/hg04U1mA5y+3
	 BdmWuPvmtblqS4HzXV90Wm1nlP8TAIPo01pw8zr/qcasDGEeHor5ZS86UedNsOLcuR
	 Eko1z3AfNLareavlk0xPRaIoyfFDj31/U7hyV39sqrNl16PfOXzgBcAQkLlbTY9UV2
	 zc5DAmBaYHjPYzE+vbhr5YrDzT9GPf1SMWHouf95yCVqBFr7ekg9ZkTKYQlpjPCNHj
	 xXpk5b66/RTNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 019AA6074A;
	Wed,  4 Nov 2026 10:00:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C46D37B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F193C40775
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OYSWuTUMfvT2 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:00:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE81A4076B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793786432;
 b=gXDP3+0HivxLH+DR21+PR03teDetEPLXMM6NSx8bl+a4KULq44FL2SoC/pzaPBrc0MNA
 CdpplGuwyztFVmAsmbi3hoZf8LY1lhbhVhOSVa6V8msvLuso0HOdtQQezAA+nEwH/wZ1v
 BwV0EsPtkTfv02Ih+YOzsBHAt5Uk8caWIPl/Qha2b81dRM9+9vdKKOtMuIvaZGZHpWQpS
 qben+QKLeMIflv9aNZp6MX7cdAqdAGUmFE6h+1zujOc1WxkKD61OYkNiv46/bfvaM/w0n
 fo0xu+yoxhfpEKZxAngmq2JKBiWCqAWPfFymRouaXeVRYGegHSpapxWpP1No6Kqj7lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793786432;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
 bh=7puhJqQIr6krTUbkMfu/glwke/EE08WvZ7NPeRZOrmA=;
 b=THsuAQEmLEONJDJHNNyAGl/OebRShVNab7/Z33cA5FbFJcojrIn5FiLsyxHdneCAwZOw
 z+B5WXIFq3NnU82MV/vqslkq/r5whcXrsfzL9zbaZWVKLgd5fs/K8tsOf6yeQ86v37lHL
 K9bpKsqw7PXMb7PIaNTR5ANXEef7sKzCQNgDTx49dOw+vg+qcibgL4t/Eg45u44f0OBqJ
 R63DdNNOaK4TfB7eyHsvDNQbasJ6DbKvvtBoiAkrjWeqsmKFlkBPKaFTJfINAGekYCebA
 9d5+f9OrJxizjoa6vmCT0dH4wUG3AIXOU5zwg39IzngX5iNrIXaxM+I4Mq9vcisPtBw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Ops9QZ6M; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Ops9QZ6M
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE81A4076B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ll4LewhLcz/2RY6rQNfdGk4TgpsiQPOvvl8omDZJQV/+75noiFibGznlHVxYUPuHWLuLma6naUXX1e/xbGDo+7s2CA/D55iY+CMW0bBZ2gAE18g2LZrNSXAug/gTKh0LFJt28yxx6JWeoW0BVJSlHuFksj5tUP5QspJMAhbg3dqBI55imbwaoUgrVEZUhugBaB0o6TuF44UerdGrrw+1NwycaWVt5SUn7PWKMO4s0JzSUqSJiWL6qReYAAmq2FGb69n//jAvA8pUtBS5EQQkTdd8ViOGWB+GkwZJoL2KOXJZR/++n7+HL2BWUIjg2OOb4aPeE9VgGXKRA+gBn5bihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7puhJqQIr6krTUbkMfu/glwke/EE08WvZ7NPeRZOrmA=;
 b=xsCgCppHC2FFIzwxEQYVEEtXVt/Vgzf2CVf3ZDMfn4ekSyS5ZQtD0mfqdRmjXDZ8YBFWp0LiLFZwd435i9HkNiKLXupZXOF45xPa/wxbASlarDwgPGV+O11HtpQ3qUjQ7ETxlkpDubU8C41XeVew1YVcr0pKI5a8vVxbsXGtEiqoBGewbDCPvu88fPVGMQWmZxbywtMPf/xIQMofvMvMa3KMn7NL+2eZnWvkezMZssq33eQVc5pud7TWraofpbZbI/BRcp+4G9wOxYV5x8eb71hL7EsygGik4DJzN8OiNU5dyjxlPXT6/x/JLWNtOK5zWVRwtb1bX54jzAGEd+yqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7puhJqQIr6krTUbkMfu/glwke/EE08WvZ7NPeRZOrmA=;
 b=Ops9QZ6Mh3Q+9rNiOOdGeMV+YT1pHFSGOBQmBl23b6wmy8rUjdLvTHYw032MVDe5n8Xw0kUj2N3GuPYTR7p0zgfHUaKUFeScyFqFnYHmETQKENzGtYWfJIrbM4e2MLxOMweT9OWsN+OFnwrpqC0cFxXgV2Fu0UmhYisrjDLzIcY=
Received: from CH0PR03CA0417.namprd03.prod.outlook.com (2603:10b6:610:11b::6)
 by FT1PR12MB227580.namprd12.prod.outlook.com (2603:10b6:170:e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 10:00:27 +0000
Received: from DM3PEPF000265BC.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::47) by CH0PR03CA0417.outlook.office365.com
 (2603:10b6:610:11b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 10:00:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BC.mail.protection.outlook.com (10.167.23.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 10:00:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:00:18 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 04:00:16 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/7] dm: core: Add ofnode_find_node_with_property()
Date: Wed, 4 Nov 2026 15:29:35 +0530
Message-ID: <20261104100005.4104985-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104100005.4104985-1-padmarao.begari@amd.com>
References: <20261104100005.4104985-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BC:EE_|FT1PR12MB227580:EE_
X-MS-Office365-Filtering-Correlation-Id: 9910b2d9-8c33-4a9b-bde5-08df3a5a739e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|261021121427099003|11063799006|261102123227099003|261102130727099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: aRBwrWHHFLMryL3cTabSLVSblw3nofwRfApaUfB4rjzPD6amTpEVBA88/W6x5nwkgsusRuXrYbvILoDbg8ThGKhG7RDyIbdkrEzRZBsHrKftv6QcwFiqck7MAKPvgpcZf9ABhwcidXVoryemIWF2p4F6Ok5Ew1hz+6x7Jtild3vagPuVPDDLnjLrdgoy/QIIX3p+bxlhgDlv8WnhKoUnl8NycObP06+a151NqMZXJprlQ0ZzmOHySqRc+ZDYb9ci4JNv+iooWPCGj59dEfGo6v82P++IR74tyJL8Zk11vt8fapCQj93IiIJbOGYDETii0MNAxX/B/hln5wpBpxdSgbnOpZFgsLR9vjDUs1IMulfGEqQal98InuCW0g0dx/Imp+3J9/wjkCz2naHQYNrk4BafeuR4UZ9Xbt9NQouHe7WTMuoom5DQyzQJkElnIuTZmD3vCLi1CTcI41Zi8uaa+6T3vjkLZHr5CA7QjL+risoEZOH5hL0ykpn/FqMqHojVCFKqbtWc0tT7Kn953qvWN57a6es9ENdaqVYOzo6Eo3rsJ1Oj2Zv/SkDqb7rg/I4THR5PBYhfv/r2NAQ5jGYEavO1tBf3lhBDF/UnaGWWgdNg3VjV+Dw5ZEj42cwDfYSomLhDkhJ+zglBSpLSBDZtTORxqMjiwB/pzE7lcrPLZTF/PPgg1wUHKnSrNTQonEoU+ofuzgUBDta6yR26K/zs6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261021121427099003)(11063799006)(261102123227099003)(261102130727099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mRs+h9Ft/p6HXfxi9QCmwNpjkBlwEYsze+BXt01o60FdaqYGLHArs9BrtS0ix7rw3r0lVnWNIEzSBjTziU6OuCnjrYvQW9k1qFoXpih/JevbjOyOXqGVkffztXqTxwBMPv6AJHVf57OXJ4cxzUNCuG0GgoNKvxHMb1D5WtFmVbEXR9hk1cu8AmfmcVmH9NI3Z2WAQ9slprXPgKSgVOf0u72SDHEMrk2lRDOfQ244+brXNKn55zqb/UXh3VHBd2FKN2Kgfqt9YLqE84/2DQjEwdyMSMrKp9YEafbP0B3hDztTIFWXyb4aCLh72GGvIqEvY4vWbVyN8hOCjErPmTCohTK2lfUPIU66Oy8zT9GKtSYSUCI4gMgM9wgsvx1Uua2G7czADnDAk1tmajk+OsOiXuUiEvk8bYtOvruXZ/+MKqRk62UXJwwA11npVkQrGvbM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:00:27.0364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9910b2d9-8c33-4a9b-bde5-08df3a5a739e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB227580
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a function to find the next node that has a given property,
whatever its value, walking the tree in depth-first order. This is
needed by the MTD virtual concat support to find all partitions with a
"part-concat-next" property.

Also export ofnode_dfs_next(), which it uses to step through the tree,
and add tests for both.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
- New patch: move the DFS helpers from the MTD driver to ofnode and add
  tests

checkpatch reports 'Please use a blank line after
function/struct/union/enum declarations' for each DM_TEST() line.
DM_TEST() is placed directly after its test function, as in the other
tests.

 drivers/core/ofnode.c | 31 ++++++++++++++++++++++++
 include/dm/ofnode.h   | 23 ++++++++++++++++++
 test/dm/ofnode.c      | 55 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index b5d13c43db1..29d2041086a 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1791,6 +1791,37 @@ ofnode ofnode_by_prop_value(ofnode from, const char *propname,
 	}
 }
 
+ofnode ofnode_dfs_next(ofnode node)
+{
+	ofnode child, sibling;
+
+	child = ofnode_first_subnode(node);
+	if (ofnode_valid(child))
+		return child;
+
+	while (ofnode_valid(node)) {
+		sibling = ofnode_next_subnode(node);
+		if (ofnode_valid(sibling))
+			return sibling;
+		node = ofnode_get_parent(node);
+	}
+
+	return ofnode_null();
+}
+
+ofnode ofnode_find_node_with_property(ofnode from, const char *propname)
+{
+	ofnode node;
+
+	node = ofnode_valid(from) ? ofnode_dfs_next(from) : ofnode_root();
+	for (; ofnode_valid(node); node = ofnode_dfs_next(node)) {
+		if (ofnode_has_property(node, propname))
+			return node;
+	}
+
+	return ofnode_null();
+}
+
 int ofnode_write_prop(ofnode node, const char *propname, const void *value,
 		      int len, bool copy)
 {
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index c905e86b283..5cd378e9735 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1488,6 +1488,29 @@ ofnode ofnode_by_compatible(ofnode from, const char *compat);
 ofnode ofnode_by_prop_value(ofnode from, const char *propname,
 			    const void *propval, int proplen);
 
+/**
+ * ofnode_dfs_next() - Get the next node in depth-first order
+ *
+ * Return the first subnode of @node if it has one, otherwise its next sibling,
+ * otherwise the next sibling of the nearest parent that has one.
+ *
+ * @node: valid node to start from
+ * Return: next node, or ofnode_null() at the end of the tree
+ */
+ofnode ofnode_dfs_next(ofnode node);
+
+/**
+ * ofnode_find_node_with_property() - Find the next node with a property
+ *
+ * Walk the tree in depth-first order, starting after @from, and return the
+ * first node that has a property called @propname, whatever its value.
+ *
+ * @from: ofnode to start after (use ofnode_null() to start at the root)
+ * @propname: name of the property to look for
+ * Return: ofnode found, or ofnode_null() if none
+ */
+ofnode ofnode_find_node_with_property(ofnode from, const char *propname);
+
 /**
  * ofnode_for_each_subnode() - iterate over all subnodes of a parent
  *
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 0f60c2a6281..4fb9bf8ce6e 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -212,6 +212,61 @@ static int dm_test_ofnode_by_prop_value_ot(struct unit_test_state *uts)
 DM_TEST(dm_test_ofnode_by_prop_value_ot,
 	UTF_SCAN_FDT | UTF_OTHER_FDT);
 
+/* test ofnode_dfs_next() */
+static int dm_test_ofnode_dfs_next(struct unit_test_state *uts)
+{
+	ofnode node;
+
+	/* down into the first subnode */
+	node = ofnode_dfs_next(ofnode_path("/some-bus"));
+	ut_asserteq_str("c-test@5", ofnode_get_name(node));
+
+	/* across to the next sibling */
+	node = ofnode_dfs_next(node);
+	ut_asserteq_str("c-test@0", ofnode_get_name(node));
+
+	/* back up to the parent's next sibling */
+	node = ofnode_dfs_next(ofnode_path("/buttons/btn2"));
+	ut_asserteq_str("buttons2", ofnode_get_name(node));
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_dfs_next, UTF_SCAN_FDT);
+
+/* test ofnode_find_node_with_property() */
+static int dm_test_ofnode_find_node_with_property(struct unit_test_state *uts)
+{
+	static const char *const expect[] = {
+		"a-test", "b-test", "some-bus", "c-test@5", "c-test@0",
+		"c-test@1",
+	};
+	ofnode node = ofnode_null();
+	int i;
+
+	/*
+	 * Nodes are found in depth-first order, whatever the value. Other
+	 * tests may add nodes to /some-bus in the live tree, so stop there.
+	 */
+	for (i = 0; i < ARRAY_SIZE(expect); i++) {
+		node = ofnode_find_node_with_property(node, "ping-expect");
+		ut_assert(ofnode_valid(node));
+		ut_asserteq_str(expect[i], ofnode_get_name(node));
+	}
+
+	/* the search can start from any node and runs to the end of the tree */
+	node = ofnode_find_node_with_property(ofnode_path("/d-test"),
+					      "ping-expect");
+	ut_asserteq_str("e-test", ofnode_get_name(node));
+	node = ofnode_find_node_with_property(node, "ping-expect");
+	ut_assert(!ofnode_valid(node));
+
+	node = ofnode_find_node_with_property(ofnode_null(), "no-such-prop");
+	ut_assert(!ofnode_valid(node));
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_find_node_with_property, UTF_SCAN_FDT);
+
 /* test ofnode_read_fmap_entry() */
 static int dm_test_ofnode_fmap(struct unit_test_state *uts)
 {
-- 
2.34.1

