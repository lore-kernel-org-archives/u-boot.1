Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A107606A330
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ufp9e9Fm;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Slytf3JP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5145180E33;
	Wed,  4 Nov 2026 10:00:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRi9BT7-HWvQ; Wed,  4 Nov 2026 10:00:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7381480D32
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793786441;
	b=dTAdclOthNkgL3pK2ZwP+5aaAh2kgmD59Y19t1xCJMMl5U8AKQTOLTO8QlnQzxsm/2kM
	 Ce0Nxs4gq0bMY8pKBrGoM5uTasY/6slLEqMWH7lZXwbYY1XPJFVw/pwWfGw6jKcXl2SRW
	 bGThjMrtiM7L4CJJ0uuxJCnyzftv2qrKyPCZv6Er6tKQb3AuSCov+rwPsoink7F95TLRs
	 yqSnjB9savBONsgUqv9YdVfvoW6bXkz7a5ozyXJ3l/Xd7AwDcmpbqBRm0nJS46lIJs8yP
	 b6AbKSQykdj6y1KZjQ2we8je8jHZ57R3d2WkJENkiG2N5Gpy/yNzAfscjsgiiVgxjAA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793786441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=adIkzF0kS5PW/zTgit3237+qUev3IXgV9NOFneK22bY=;
	b=cMn47zbTB8ozOqK7Z8OG94+gYLNIl9oVEPJljzAEKABao29hKqmDk5gXJ2ITiWLA4SCT
	 YcYbaCfQa/vfmyp/4zsyOji21pKOxcBUUCDeBKa7RiNP/dadog3zHaQZftYIViVtsJ8jn
	 9nzfnmw6cV8RwSmGcrNVGIiNnkptidSNIf/E64CbcPAkHOR8f6vHJZ07FGFJe7CZhwabU
	 EmH7HN+f87uLT3PUGYI1y3e4oxBzfD7YBoCMVXyzrU4COBqihs+fx1WcnolOnvVoAhS0z
	 42gbAZ2Nxml1Mwsg3Ez+m3qXQvbDaMAfcjPiXkG0xaBGfgoeGYUV8KZjle2feGVm78g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793786441;
	bh=adIkzF0kS5PW/zTgit3237+qUev3IXgV9NOFneK22bY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ufp9e9Fm7PCoTo2sowS/Y6PrB75Blec9P63UnQZYmBm/NmCbp047ntHg/W6+fkbB9
	 sNQ0U8g+gLtPvhYuqIEeLYnfC5I+pvJPhBPaWllYwVjuflSFVxu3VAA18S2LtLqAz/
	 cvv2j6LK07NqZhlwIZi5lJD0nQrMqaz6SOqle042NrItogwC3ssqmNChQOtBsFgqkq
	 cbKbCV3ppVM8D4WhNz3WVQBIRHaZs6TfZU7sCztWV/ATI5Sf2Z9ttjXAbkfuWuEIm8
	 H3EHiqB9SrmbyDdTBxecMrHezP95MZWYnUyV4Q2rJiZi0QnKg70kjcXlHZdb88PG9c
	 oN5AEhT0fMrbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7381480D32;
	Wed,  4 Nov 2026 10:00:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D8962B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33491400FF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cp8cwDCo81Dl for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:00:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 56E7C4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793786439;
 b=EU6joIJpr03cj6ajebflLxTp2Xk3x9jbR/gHYki0GYTVqS4OpfSHc+3zYqyMJk9MsqSs
 yr8E/UPRULDc/0LgCxZBio1LcM8KsyN2SySlc6UzoLWL2x7YF+AdFriCdWkKTtpkhkyJ0
 BgidCGKFVf3je4PHeQWCoWqVnVYwAhTEi6F9kVinX9F8j+bejUFJ39piKS8ELyqsfpuqP
 mozqPviU6/mW1l577Dg0UTg/pcHBGv4u7iOqrjRvAiLGKP7oS50c/hUpJoSkY31FWD88i
 MzNiBAt57344BleadlwFQpsUyxV+YGB/esK8CcHKMvrgfj3SjeREIw6jv7ot6azFg5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793786439;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=adIkzF0kS5PW/zTgit3237+qUev3IXgV9NOFneK22bY=;
 b=S+Pxjxf6fXpd0qzyRrj5Zdn85VIdq3CZ1ABvxG+tyzF99yiDwevbHb9wVs42nAbav8yW
 PNfL4EoO7jnO1wTdyNZQ6VWAjZ4fhb1Lgnnep+fXoPj7/+K97lRsJJCIxFm8lK8bPs6NR
 8uB7q9HGRQhn/lyJG3BwYAFLkAUM/bkyzloz+w9y+powXSb45qctfku08OIl3fd52/xuK
 RB/sdyTDOh9isSFWMd2RaipuvJzTTqCMWxk4FM3QQzOE4zaUU/cFEupdLWeRu2NudSFPp
 g3bUVFigRZCl8le5NcoCUELv5paOetjksiH36HPLKH7fFu3CfWhF3NSG9lnhOLtQ7qQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Slytf3JP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Slytf3JP
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56E7C4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bo46ckW9Q5gr/ENlPhCliLILa7eYmjNjU77ID+4h6nxNS3aNnc6hAqI4fO6Xt+9yZWiY7t1IwzYiPQXicFrZih0cVeNPKCqUgqHYGB0BhZBR3DzCfcgQ4pFqpe/dzI3agm4FJiu1thPUu+MOXgjWqejV9t4jvG/q59T2SZbM6PdklQ2hhBibOF6n3q78vSUszbySUzeZT3kgvbNFU82kpQkMWdJ2EYHjDSn8htbfM9hvkuHO7LQBFTTrVC/GaT+XyNptqcLLVq/eldL6Wvn3Dzr4m7hDt5yralXYJ3rYJbDwTiHFnj892NZtp042GBA0ii2FVRbQszeCDM5il1uAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adIkzF0kS5PW/zTgit3237+qUev3IXgV9NOFneK22bY=;
 b=S6PmY602Ie9HSBnOHkE/LBA4MEY49hTJGWmvk6g4hSonztN35JdHkXOPlRfP3zXdfWnvKtJyjd/Ls+IKj95wWoH7GA2cJnAMdGSY9AmUHl+Qi2k45bpX5G7npk9YEu8OenUuHkfD6w2kQVerS0HgXaBPFiwRWEVO3JAnueL84vLQp4ebkPuOrei+rmxRpr7kD3vfyzBr5ZKINzBOPfMJcSwNZ9wUuWKzevU8ORbN+9SQ2WXi8aRlbcmVlyNqfJf9/wRBJ2Eo7wii2T6d5sFrDWhusY4fMmUxIIbo1JRFXRrBBjZJ4aa32aGCYSNMyHS5hR7oZtQRAz56U/O1kZECqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adIkzF0kS5PW/zTgit3237+qUev3IXgV9NOFneK22bY=;
 b=Slytf3JP+5knuasxboua5TtrmJjK5wNM5lS59Th6zS9+0RC8x2LLkW8vg24L4OJRVXxbCNwzlUWq9zDuEi4zWPPruS+0//POCwUUabBpmPTuSCE2FQ5gsFP+eyEWxBvM83rOOvorvKVKy2qGrHkXJR3iAcypa6cPDAuntFQrYyU=
Received: from CH0P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::26)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 10:00:35 +0000
Received: from DM3PEPF000265BB.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::3) by CH0P223CA0011.outlook.office365.com
 (2603:10b6:610:116::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 10:00:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BB.mail.protection.outlook.com (10.167.23.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 10:00:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:00:29 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:00:28 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 04:00:26 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/7] test: dm: nand: Probe the NAND controller in the test
Date: Wed, 4 Nov 2026 15:29:37 +0530
Message-ID: <20261104100005.4104985-4-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104100005.4104985-1-padmarao.begari@amd.com>
References: <20261104100005.4104985-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BB:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 47277c23-96ba-4ab4-8a0d-08df3a5a7814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261022115727099003|261022075727099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: q+5qza9cmKjT22epqQ9EffSJyzT48glpvpnEBpg7beLbIkOmehWc3h0JWnbsf4mc45GHoR+qetiNmU48An41uq/Dc64T5O/lE0oh3oUGFADTvRdWnLlRhLXhWTRZyOifq9TJK/9aEUXUxe7VReRj0IKMn/NlktG6FnRySt03DomLgurclnVxCFYgzrhE11nAIrNM1sP3P3w+ZddnB5eY+Hg05rbFhIHWGyUvIFTQw+HZbyuoWo1tIpsuO/8MXOEpiFEFGDxwMq67eBGsDtu9HsohpenVMiruwalbmLAr4BSthakxjt0oVPbW+XcXwOLDNH4Wwpkx2H4x3HWbv3cLZveU5owMKAJ8xuVM288F5Yl8KmEJ8IHiCrHVRQH/n2lz9URLwc5yUpxINIHQohQK1TNiq6Q8Rxox4OPiQ1wdCOHz0kmi5S3gb+WGydNYNASuO2kHcVcAue7hLQ8iLRvSsrNgkacxo1UU4Gum9Eoc5q2fCpzDZv1UynCYDfB+bodFijsiZM7z/pq2IHnQ8kCSm7H/CfVn+Ksa5s5OC5OmkXhgCCfXqp5k0gfSY0P3KxXgv33VqrUXVM4PS0Rzf5fy/OjUCPyxMvsJdBQ0QOJ9qfoFxn1+N5nxh2pUYbDV9uLmfu86tAsECWOfrvNK63Zyvl/lb+8VtxNf/hCcNC81gf2jBEWyYA0t1iTAsS3fDapnImKe6M20TtUQ/go9fXYLmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261022115727099003)(261022075727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0PhfrYWzBOObpwWpK/uK2a67YON7/jzAYo9xmJysyVmgY6gEgZu772ZEb1p2hRSYZF0rmFl2Z+eql0scTTtepP07BChqUHF5VE9GfJqzBqXwu2lWSkrOAt1wTk4k2olzgUaqpWvhGQLdJ3cSduLwd8s60KcPDw3UQ6WyzbB9GmqMgqmUqdf/Ll6MCLk16Rkt+/qNeMMdNfME/dO61Nq9W2CTapWXpUAWfsVhO97Jfg+ABd0OQ2+m8QbLEATpwJfdO8i700lrcurI+kip0goG7VJezVTR5u+mAVHylLfIjDadITiczvaSw87bIGyDtl9SRjbO0Y4ltP5/7sIuUUVA3wbfsjrKrxdKi67I75/21O85EvUMVH+CQFekcdVvgB3we14Ky7qdBErXCJJoYWbReOL21eBpUuYVgB1iy8HbEPb+xDbIg56qvarz/WS+rsQq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:00:34.5546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47277c23-96ba-4ab4-8a0d-08df3a5a7814
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NAND tests use the devices which were registered when U-Boot
started. If an earlier test probes the sandbox NAND controller, e.g.
by calling mtd_probe_devices(), the controller registers its devices
again, in the driver model of that test. When that test finishes, the
controller is removed and the devices are unregistered, so the NAND
tests which run after it fail, since there are no NAND devices left.

This happens if imagemap_test_mtd_blk runs before the NAND tests, and
also with the MTD virtual concat tests, which are added next to the
dm suite, ahead of the NAND tests.

Probe the controller in each test, so that the devices are registered
in the driver model of the test.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
- New patch: needed so that the new MTD virtual concat tests do not
  break the NAND tests which run after them

 test/dm/nand.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/test/dm/nand.c b/test/dm/nand.c
index c7e09850503..5ab52fc8051 100644
--- a/test/dm/nand.c
+++ b/test/dm/nand.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
  */
 
+#include <dm.h>
 #include <nand.h>
 #include <part.h>
 #include <rand.h>
@@ -15,6 +16,7 @@
 static int run_test_nand(struct unit_test_state *uts, int dev, bool end)
 {
 	nand_erase_options_t opts = { };
+	struct udevice *ctrl;
 	struct mtd_info *mtd;
 	size_t length;
 	loff_t size;
@@ -28,6 +30,14 @@ static int run_test_nand(struct unit_test_state *uts, int dev, bool end)
 	/* Seed RNG for bit errors */
 	srand((off >> 32) ^ off ^ ~dev);
 
+	/*
+	 * Probe the controller, which registers the NAND devices. Another test
+	 * may have probed it before, in a driver model which is now gone, in
+	 * which case its devices are no longer registered.
+	 */
+	ut_assertok(uclass_get_device_by_driver(UCLASS_MTD,
+						DM_DRIVER_GET(sand_nand),
+						&ctrl));
 	mtd = get_nand_dev_by_index(dev);
 	ut_assertnonnull(mtd);
 	size = mtd->erasesize * 4;
-- 
2.34.1

