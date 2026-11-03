Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F5606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kUtqliBM;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=SdoHdZq8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 076E460732;
	Tue,  3 Nov 2026 02:18:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cLm3NzizNH7l; Tue,  3 Nov 2026 02:18:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C95F606E9
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793672299;
	b=MbhsucRPzVYgd0OOOgNPS9TH81WnX47Cj/i5/Z/iTzV/luwKObM4lRTVFDxaaQe+F3Lh
	 +pHd5cnCKX5ANtaU3jmIya2FBMeTwetc8gTwA+Xj6Ea2ztbegNYF0/mgi2+PW/TMXqzbD
	 rniU1cT2aHqi+zVvUZ7Ni2xnZBAQF+t84jko4kTOguZ+9b7bI/A+jVZFw1F1BZuaZuvON
	 wWPaqTv3GEt/dRFG6E5jBR9SX68atePluUIJGZLmztWnJwPJNV1WQTUHmzwp70hAGq6qb
	 1sEkbk/frEIWxbzHwraxm8t4m5jKc/lZ9Kd8QGQVVXWoWRqMs2oEBlSHFWMzYHooEoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793672299;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=s6xr67G52joFDXc9V8wuw98hnOMPycU8rbwktb/uYKg=;
	b=TPWnYIa5FuJP0r5ZOMxgER7jvSKM4z4XdEFdLrxXccxcX1ZbHfG7Eshu8DZQZ3q4ZwEH
	 bsNlCkISWEcJQik1Eyi2zKN+OATZjxeh7VpPUJlzL3KQMxequsJbvI2KIZANk05kg4jIx
	 /TWKuevoPuW+v6Ln2G3Mffub6T8k1DgF7NOpPd/g75s76DcOEv3n4d22mfKET0Cs42oOt
	 JMFQMYBykjtR6d0WseK35EOxbit5sKFbpz6hb8O1SO4LFsEGoavJmxa4RiV5VEInnvfhl
	 0QyzPm9Do1lvlnvFXwWj5Brxe2FHT8uMOi6PBUAPBgycPnqmra7VwAAWSzwDHIdjpAw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793672299;
	bh=s6xr67G52joFDXc9V8wuw98hnOMPycU8rbwktb/uYKg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kUtqliBMVEcJL7gwpA7Z6oMLvQHOvIgm9h4zu5Rur3DS0cH5R7ulSfK6+uOLsMQ+b
	 QCsZh1PUkrVXRpjgJzg0c3K7UJeBe/Sycfa3tkOfbLsZ+PT8uLT61UOo291unUAdrc
	 JI2uKgKVjvnPkh1kP/5QwFyQ2KMyJ0Xr9l5TISbS6XTI99wz5KxRffu+R7QGW6sByr
	 aVRof7BKBfsoMWprbkGApXygf89hIYbimPthHsndPvRDfOwSmQbeRRoaM5Wlot7Kfn
	 YJehBL12/wCIAP5oA+bm3Jk3VoVxTDLt2t8MXR8Tu/Y4EAxSSWEJVQE0L5O7LWJmiB
	 q6WU8U/RRz0Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C95F606E9;
	Tue,  3 Nov 2026 02:18:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 12EB5356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 02:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC83F401DF
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 02:18:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 73_JVxXggyCi for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 02:18:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 679E1401DB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793672297;
 b=Xf2fsL7OA3YS1Ws5tzpR5XIog4R+mUiRENb8punxQ6LPJak5kZYmVBqE41TqA+cQ0Cok
 23KUFDoualHMSd7Wn6W64WrByR4wYbYz/Wwim/QwieZHtXjj0kMiE7BViS/6a7lAuPcCO
 qBdC52HXU3xk412Y13MuphMWlgDaA2AExZjhIigRaLTNAPZqr0xPwKoarnbz6HNKcQZUU
 UJLkAghR/bYa5yzaibkNwZ1olnq6AYc87Bds/x7rC/x9fKwi+86F3rVdEd2VhOq3bWBVm
 3XKlKOD9Yl0zC6IVjBJuLhy3ASQQ8sV5ZSodj0n53RSghGgvRKBC5s4WSHOpCq3Lw6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793672297;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=s6xr67G52joFDXc9V8wuw98hnOMPycU8rbwktb/uYKg=;
 b=OrKZVizaiOpgElEPgTZESHsN+xc8szSsngMy3nyV0OJZDgNCgLZopMFkJdfGW5tDqwqO
 Lz58XkJebR3TSCRmqIVIoPxdC3hfzRklTaXYZMDuPmvZHZasy7zpxXMvQXXADftINkn1C
 p6oUqPcleEzy3SQ+KXhgeSOXLPMzCYdQrz1HnxMmShK78JFJPIgzmXAScBhp77i1G/P0E
 r2z5AXb+9wODaCj8r+umDfbocNaI/mB4DjmMAdBQo5uV/2kab1ILN725CJAKruYHQrai+
 5FVmNqDheMZFa7XUUMYKlK2h48vN/yivMovwZ45cm3xYNyhcsO9xCSZBoyHWSVHDPEw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=SdoHdZq8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=SdoHdZq8
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 679E1401DB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 02:18:14 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D3183108; Tue,  3 Nov 2026 03:18:10 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD7383108
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 03:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrjuyALRmPE9EzOgAQ5pV8f3C6L5UvILIZgVcUDYj9/UYaXF2XkHNcUZ/q4D5vAebJ5/vf6U5sNIGhWG2oT1RTsbZtqqF3upIzF0Clcnq42i4/ZX0j/VIVXZrkK+ZKit+7OdKQKpWAL/oUOpGaXml/4mgSlQfSM41jJQcQ+u6JmPBn9mhFFwQ0NyXkRAuGFsUD1Zqj5WcYrHKzNQKCJ03BbsdSKet0srfS7acJyNrBbPfxjxW/T5UlK0zkLdQHOYKzGbskBqfj1jxfvfA0O7jD6HeChITmUNoIJy01KvFdxhPJFQIyUIG2ywY1VcOIkEQZvCLlrjUaukXvBxOnzxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6xr67G52joFDXc9V8wuw98hnOMPycU8rbwktb/uYKg=;
 b=ss838ZTn75mija/qMNoRFLx8DaBiU0UfQC9nhwWxmbGs58DyfPOLND2dKeA/vZnvzYgZNXs5UjNJRZhRxMg0siIt5xhL4AVyC0cqhX/623Oj/KwUXHm8i+6B+1MzprtokpkhuNrK75wO7l0Ugug/Fnof71mfhmizMmocuSOf2jtKP3/Gws/35iuQhFE6Y6N4NIJeAfoHWZplyNUHTqgWsevQuNTvheViHPr4hJxp2xrR0ZqfedSY5q7CnAV9Qkxqzd2FdqxlQtXrNMAumLwWJlpi8rTtRRb04UPwdqOoKVigVsmjeXcBCOaxZFNNpUpFnRPDpiLhCKGU//qb+n2AKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6xr67G52joFDXc9V8wuw98hnOMPycU8rbwktb/uYKg=;
 b=SdoHdZq8G3cJE05n+c/+RenR4LkkFeTX7zYv/Nnxh1Yyg8Jr2TVtqbYrBAxruOAxQ6WvVrOWHo/4YgGGRDXiPsIqCEG30BGNEapqcnGmkm34gDVmFZmlEfqD2uyUlbBhajC0PEFS0E8ryO1zBoUN5fceAEiW2B7VsGqE+zohUQj5j0IDUJad15Guo5k0G0EAerQ9+qXThKKGkyP8LfACO5RmaS7fVcLJflZlBmGAojUnqF74NZjivYbmlvDZABVZ6ZHT/sue0OrPZ46ogsYPbjzH3OeBzj5gkQnr0d/flVnVGdACB4J+IWyn4NST3hWUuGhX4gqyC1PhbLzNfny9UA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989637.namprd03.prod.outlook.com (2603:10b6:8:41f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:17:59 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:17:59 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Tom Rini <trini@konsulko.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 0/2] i3c: harden device index and detach handling
Date: Tue,  3 Nov 2026 10:17:41 +0800
Message-ID: <20261103021743.27111-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::31) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSVPR03MB989637:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d4e8c1-935f-47d1-e977-08df3950ae00
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|261102123227099003|55112099003|18002099003|56012099006|11063799006|261026140227099003|261022105027099003|261021121427099003|261009221227099003|261021123027099003|261009223327099003|261009220027099003|261009221727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: tGYYuuFdvbOy7mQeVwBlO/nAF+TSgAx0ZVTPwlAqCNX427/p+zuVv/Vsl5JWjDqHV5KGkn6VZ2dHxbP5j389lSRLKsn07LKmRSANLgNj6UYIRDVpPtlDhiR6fzUyN1rMhQifZUUpaOK+YOmrayh/ZRKBNJsENpT5mLn2wijdpNZOoV91kctR/bacq5wRFzrj37jiKGWZkyyaNQYh85iIsc6IQrDWCTCl3efxbaDSl2jouIco7lrcc/olom+E6RYBqGvwWWtCRRPZkxfRnJcO1rYjPI9C9G5JCpbbxP43hmA1HX6JDH4QoXvPlsv+QWlGhMWA/L0wxpVlq6FUA1yTtL8OB5rHh4HuI1vQ8EFWuFKXJ3hw9csiOn7VbwQjJ+kyNPn7zgxetY3N3c/5D1NL5Ztc0gA8524ChcO8s7F6qBcugtcrFZV0GzEtu4tc4Q/5YVtaJb2ITYnkpdNDIwwNGlePKTJT89+F34zbotJzVpjzsFjVx7BcX6v3zTBQevSi2pGJSnXxCvWbgdaZqGy4LhOoUZMm4znkpkTDgBYazAoOITSXpY6syPMG8RIEthhuWVR8V4S2Guu2yWjvP+bdf2PM5pEB+s4KHE2TOhxP2dN62EK1J/YindykyrAnFpD86Y1eO/tfjmcVAxFBZEyP+xVHNpyYX88Ot9rYEGR49TY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(261102123227099003)(55112099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261021121427099003)(261009221227099003)(261021123027099003)(261009223327099003)(261009220027099003)(261009221727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UTCDgRHKV8BplqVXvPjzVxPZaCWm5rnzoR+XxtURdWSdwGlxm5aMo3lHtpsk?=
 =?us-ascii?Q?Nug4Nyt5J6EIX6Fhi/IjeFoDeFs8HeFUVnzhKG6KYZKuCkttFkPwim/f9EDz?=
 =?us-ascii?Q?AOuYLOmzNgJjp5heWSKA3lbvPXd923m+s8RzaJd9QVbRlOqRujxISZc+YZpk?=
 =?us-ascii?Q?2kN8Wm4mM3yXtS31PBizaNbgHGDU77D98xW1ezHH5bFQBwCbTkufSSwf7YJz?=
 =?us-ascii?Q?1vVCixOMQ3Bp+AblfMnNcfgMdLPzmFm5Du9R5kJnLf0OmRMeoY9N1mXYGCHQ?=
 =?us-ascii?Q?VZOZ+/Miy/IQfD1cp1VNClQgdywh7aLEVFcnR1enDBXb4XBNQlMCeRcUqUsD?=
 =?us-ascii?Q?SlY9GSdAopoMD+xcZ24aO4zki8yY2WsMF1ra1prYBQNFVS3oSL1lPNDCnepT?=
 =?us-ascii?Q?OgO/I/jGAeoO6fRDMNfQ5VfvspKOcTrtxJLOHWzi70Q8EoMHGehNMVvV/Oc6?=
 =?us-ascii?Q?BdAo6qzlp+99llom39qozZv1Nb+57jPitkxvCcNvlDoQZo56D9OCBZTnrhPJ?=
 =?us-ascii?Q?R8VhuZFDKoGphJ5P+YdaRA054+kzBDk2FcMBLfJQeiii0orA8t2KD4mgjChB?=
 =?us-ascii?Q?mwY4/MrNIyd+gKfiizvi2ZOCGeeYibmlOCE0mGkVrZzXottnVI2Y00snPUv8?=
 =?us-ascii?Q?YoXyoQAO5b0ejnc5CpoiiNLUFBG6OuaGkXMFbOcQpXTSaMbBuc/5vubtOgh0?=
 =?us-ascii?Q?dNDcZal3fseU6EyQvgMaYFXved3fTnfPGzXaLcfMkBN5RunGaX0t8exyP2eU?=
 =?us-ascii?Q?0kZAKh9wybF5iMXSA4Bb2U9a17d5yknuC+yIhHe5ioopDHWZHbfEW1xr1HcP?=
 =?us-ascii?Q?k5fHrBOYmeMLLYDET7I8sYsapOJ9Yl0DABbCJWdn6KLVlaRj9mOzECtxD0K6?=
 =?us-ascii?Q?O+ohGuzSPug/lN85UEoOtdD/1hCMrq1iMECGxPirW0SRIA+sxsGWLDivf9l8?=
 =?us-ascii?Q?5MhN1EG1bqgMtOkeTGbL3OT7Ee+gR2cd3qW1DrR4qfdZIpjSEyDhSAfjf7X7?=
 =?us-ascii?Q?y1dHxMZxCLKqbfpBrrPd01VaAzSIVcWkEEyd/VZdnixBsnWtrDYwiQutW81P?=
 =?us-ascii?Q?yW3yMzIFMjjAWnfwuPqr8MfH+gwe+0K4zFWCQz+w/314MShwTUsA5OLRpsun?=
 =?us-ascii?Q?3lNXyera063wQDnkW33RXADiljAmHlxA6NUlmzZlO7kcI+vipDRbVWyBFImo?=
 =?us-ascii?Q?qhzfQN8sxmanXTN24s0D5r2447chtv/AL/pguXtJFTI2eAWSYBQ/1sdGt5au?=
 =?us-ascii?Q?ORCgBLkQW6XcF445ZZeW1I03C+0ObR1Aqlzo+Ra55bJUy7hPIYGxJmzxdVba?=
 =?us-ascii?Q?4saxSaDD6UKJo63K22TrkDxgVclel54n6sqMCAKGFdvFDJsrECDOJ5C+KHX8?=
 =?us-ascii?Q?PPSDHpat86Z+0KOxBBIPIQmZmzU0ctb3Qt6bBRG6E7LlwO6O1dvE2CUYVYUo?=
 =?us-ascii?Q?by4H6dQQooZR/tFcE9rtmwO1xdrLVuFhlZbQ8+tm+d54HZKNtOBn8ykhVY2h?=
 =?us-ascii?Q?QSH+QqxhJ7dlvr+/rm738rb4cTwD3X5tiacL2cITB/CH8o7f/Bliyx302JXV?=
 =?us-ascii?Q?TSnVJg2jLyBCBKMR0pPk1PeCcmN0tNR5g21IKLYOV9GI5gpEgICNrsp9Iwm/?=
 =?us-ascii?Q?IbSlewRUAKMenjbHoprt0+j+BPWusJiBKqXHuuLzJLGUGOWJ77tOk7RJj3OO?=
 =?us-ascii?Q?cKOZ4ynHhnRsctQWI9MoTth3wcgyOfqYJHeSusVL0FYqHW7SIRC0AgvHEie/?=
 =?us-ascii?Q?QiJPXQRoKsoh9WKLyiYOQx9Y5HExHSU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d4e8c1-935f-47d1-e977-08df3950ae00
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:17:59.3156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 232C/vGOoGk+xWGFQclsa+A3UAmgUQ+c2ZuzWylZhrxbv58WtFUc8l155RlUnQO5Cek4H223eD5I+BNKDG2AEnv3z0ce5/UuXttwfL5/jhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989637
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The DesignWare I3C master indexes master->i3cdev[] for transfers and
listing without checking for an out-of-range or empty slot. A bad
device number or a detached DAT entry can therefore NULL-dereference.

This series rejects invalid indices on read/write, clears the i3cdev[]
slot on detach (leaving num_i3cdevs unchanged), and skips NULL slots
when the i3c command lists devices. Also drop unused includes from
cmd/i3c.c.

Alif Zakuan Yuslaimi (2):
  i3c: dw: validate device index and clear slot on detach
  cmd: i3c: drop unused includes and skip empty device slots

 cmd/i3c.c                          | 18 +++++++-----------
 drivers/i3c/master/dw-i3c-master.c | 15 +++++++++++++--
 2 files changed, 20 insertions(+), 13 deletions(-)

-- 
2.43.7

