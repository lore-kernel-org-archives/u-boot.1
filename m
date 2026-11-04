Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A9E606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0sgqbwTP;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BV+EI07s
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2825810F9;
	Wed,  4 Nov 2026 10:02:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bkWM0W3gaujD; Wed,  4 Nov 2026 10:02:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18B7980FE8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793786529;
	b=rOEMPTPJ4omZGWxO1TZCGBPDRsRF8nWmyPiYSzigq+WplpSmT1lSfHl7SsJ8WLY0V475
	 /N9EPPkbnqxfvYir+I1jubL9ZzGDTjufn9VnIvQOJmjdC9bQi/JMCqXuQvEk0sAD7FuoZ
	 dTLk/FQjjuuEOeH+7/c16EtuZW5ZDQ+7KMNv1ZbKMC5xl4unELUbnr+TTnI8jy3Q1AYRS
	 rhsYpYNAYuOD1m0sLEwZs/uGThz+gCboFAcH8tclX+r0DKv/aePlwLCQ/tPWE5ncBpGFm
	 qAfjKFwjaaEWPavize8m6a+zm9Cm+/5lyRSv9G6hOjEoUy55oPJSUt6smQ0KdoHcjCw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793786529;
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
	bh=o8Y8+uYAvhQxEPshevjF2D9Y83SJNIb/mhAhvW/Exks=;
	b=MECPSaLM9GZg8EcSg/8osd1JUwzBAkf1FnlDD6FJC/M+RcnohYSnbwNbLZACtv6525BM
	 qVSIPf6zZDxT1l0NDc4dKKjrSTwCPQvfu2pF7D68k7aqcGwnjmTgfQnejoeC76aI6qrDL
	 CdNRuvtU5WFeRsvVmUpl7LUogBVnDX1xbfhFANRqIg1NjpQL4XDRPCsvywR5voo3KUIv0
	 BMx/uZ723cCifEKiIEaTkh9P20/ExvqnGfyMH7L/q73vNhsQlFZHvqboNMVD0lMc+F4Rv
	 zdga5qQOd8ZMe+9qC4qM6+aiVsC/BlqTeE3oWY/jvKFXvm8h44gPqqHM+7lQf9FiFMw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793786529;
	bh=o8Y8+uYAvhQxEPshevjF2D9Y83SJNIb/mhAhvW/Exks=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0sgqbwTPT6MAGuO9to19bIipNI7JRNHA+qZ7QRoSWzQdn1O/7JAr1fG46huHAWJu/
	 WbEwwSsr0q2KxJu3q1YekH0ZFYtSwWBdhz1SWljcws4+Bc4pUlMivyKKagSnKk4/Z0
	 fYm1CfKEk6FgTli29LXC7k5FKEYzn+rNqp7FE6K88bjcb8HscOMLXx0Ch7G/nTwPhF
	 gh/R27Za3vMNG6ag4Ij520bsQY2vpyIJMKvQgoWzXaIDddr6UdNuwxKChVWDgfaTvw
	 YNI17HIXZS3+j1CxRLJVXlQTIFvXM6FgIIpg38+S2xJSHfvZJTCZtvwjU/bev5jysn
	 IZlBWDu7NA+Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18B7980FE8;
	Wed,  4 Nov 2026 10:02:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EC1A932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 155DA400FF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:02:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6DqZXNgQDCLD for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:02:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 57F634004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793786527;
 b=kKj9Pfek1iqsqekGqdqUZaeco2qQ5ZxHiHcj8Bj+v+uZ8FPO7+T2gNu2DeytByouuCcp
 afdlEp849KFz19bnHiwwSVy5hgYZJgQIPvKxTXlSGyEddOX5WbBPBGMAq6gRu2he5MNmQ
 X+5hByVy8KzwOb1bW9jOoO5XVErKrzlXH1scZUANykJJwLe+yM6e6d3Ur18gh2BYmfPy+
 vMXFXQRtTV4M+4yt1Not3j4TB95YqHJ2oXvWCcwMA4LT0giTA+OcBatbYZr/f7y+oPCrh
 xWyI2gy/MfTRLooHRJdxS1+VMhwyPACjQ1BnYm1kGaH3QcZ9+HXcmr9gQ8/kAZ9ZIvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793786527;
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
 bh=o8Y8+uYAvhQxEPshevjF2D9Y83SJNIb/mhAhvW/Exks=;
 b=SAnEuxheLD9D9fyF5kqp7HCnNt8NQ0QJSa/YENaGQqC0k4VThbFZbGavilJgmw6HQuWS
 Ur+Ya1IxdeAENOIp2CPdLIUJPOBflMYFFzccnfarDmoupA2slrErhs68cJsHsNlAAYFGN
 3So6OYknQ6fDNubK67z5aeSIR6xTLW9q0UfVJKkDs8pEXpiTiEh6dRdqDYmirghTl7sGv
 D3DkZIUJRmX8BhtrN6oTEiNBE6vO19OyXITVSA1oeouUDmA8/ozPCGwNF8YsiU48xtiNy
 Yo9s9+bGyjQ60EU/5NlgwbxhCJr6imZQcunV+Cy5NUCoiDtoq7FEMITSqlfDgnDweOQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=BV+EI07s; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=BV+EI07s
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57F634004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:02:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlF+RCuuS5W5TZIUtkf52wjvDvapVsT1+WTdjiG5Qt370SyQnZ7g3apHS7ywOi8djgE453PmfSE4KU64BUIVS4tCm4maxacz3a3pnrtFmtQRw2BMmjymJl3OONdrAB07Uaot3kTkM0BiD8jHwE3hMgMlcGJ46LkDow4517x896qcdqjMuhJo83f26RClxuZyQwctKpiZ5WRnmLr3q1YWe2GWj4eRDE71/NGDfiOBqcBNkHfFoDRuWtVvWAot60W7AwjeSCy93wUJuD0e9ZZDG51HAGyrmlzplWRdJYWKM44YJ5PUiDp/ksmgDwT7YXdyiSjioenFsoNnxv6rEBrACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8Y8+uYAvhQxEPshevjF2D9Y83SJNIb/mhAhvW/Exks=;
 b=Ay5wLQwNLYX/so2yFDSkRiPBTY31e+NKfvkuSzfrH2m7QpWcDgB71adhSVp/IuuVrUZWHGBlry5Ck9NTeMdj8i54BYEhzaaYnyDTKH3JZjUFPXzVLVDhXVzuFtmyaiNoeOANIHBbuaKp45hIOPq9QzY66rOP58wvQwcFT/dhNoWhEcTEQ6gkFWO8b2E7qOwT/8wMCwO8GYbop4Dsba1f/au7dzxIQFf0/wqzi9fJM0x43SCizqrWXbRX9k2kmRjhUVidaxbpCeVs4g03SoiN/nsZv5GzL8wbq1cCm940RDGVffY+eACwvqphhcCWdMH7tmq9jLOQQ5jsAdVPuRVd7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8Y8+uYAvhQxEPshevjF2D9Y83SJNIb/mhAhvW/Exks=;
 b=BV+EI07sL8vvP/Gi7mJqDI63qVkXY+ClT0WwDMujuKEt67nlnR2gKt5HU1Thg6zygerbpZ/xXBxc8RN7EW8Hvv8X1MHc0dkvE9YOvBjfeObrKIGo0TFZfFI/gg+1Dhk8/Bx3HztnPM+MnKRU6I6U4N3imwIsebbauHCJ9P8KynA=
Received: from CH0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:610:e4::12)
 by PH0PR12MB999090.namprd12.prod.outlook.com (2603:10b6:510:38c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 10:02:01 +0000
Received: from LV8PEPF0000005A.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::7b) by CH0PR03CA0187.outlook.office365.com
 (2603:10b6:610:e4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 10:02:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000005A.mail.protection.outlook.com (10.167.245.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 10:02:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:01:43 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:01:13 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 04:01:11 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 7/7] arm64: xilinx: Enable MTD virtual concat
Date: Wed, 4 Nov 2026 15:29:41 +0530
Message-ID: <20261104100005.4104985-8-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104100005.4104985-1-padmarao.begari@amd.com>
References: <20261104100005.4104985-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005A:EE_|PH0PR12MB999090:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ef6b63-3398-43f3-3d27-08df3a5aab34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AyfX458d+dirKllnCDZmUwCdM7I1n0H6RpmiLWnCTV6du6lCAgtrCKtF1JCBL9uxCA8Ydn3lXnzX0eXYbqhRQg2RopBuUV7yEPYO6J3apXUErqkESijzf9fds9qaQRQDJxQGPzvMIMEzaa4192aTIiISgusZauZkzZt0LnWLh1XTi88cZ5XdFxonniaQAANtKHxNLXD0GNMb1T7gY2zy5Cdm4mT9uBYNCxdGun7EfYu6wtOB351voqbSu0cYViVKKb5C/HeEg/6IPfVhp6qwHNA8WXWA6GUIaN8Y5u2ujuP0554bpiLFdQyLUeCtFxh4Dn0e5cnmQBLeJ5vVB99NV6+RtnBelB2LNym2YlUDCAsHOjMBMO8jO3Ob7bp/lGUAsrqCiVYnwQMo0FKTywCA3XJaQLnsdlA6GyrCmkg4JbYjzLTnm3v5hi7MH7VfOOEpdV3RtqbYsd8bHPxfw/zoPUrrYggqaJVNS5BQIYbKHoosYK1r0vBSsSI75uI/FRxBWBWWO2tNlUOoa6Q9gK1Cc3PkTOV3E8V9b0IeN3D52G7+r1+mqUbQI03Yc1eE1laHbp7RIQz31l/Vi84y3l7UGwrYLa4wdeVUkuhr5BkmCikW2XlRBewIJHKyiTC4dl64//r4aQAA6HmXja5MXeQd/PqjUd0P2hQsGSt+NvUzupebTdp/BtL0bgkSF1ouBz2vbACfOqOxhufUvUKSlzy+nA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PM2yTHHWx+sCOuDXLJqfjiB3GCAj6zSncm2NCdCxSrYMQ/ydcdETuZPCXwhwck0A65N/k6R3BWQS8P1QyNlllzbLaYiJKRp58gykfJPZAsp9ZzXsZszMs/ON1U0Ov/YFpPa8XQunW209wTPQZcrvJv9qPsqzU0z/M0jATKy9H6SXg8QPnOKvKCMwkFDTxQ08idusroEgqD/bVHPrdwmWr5OdqAsezCeWCtnNCfhKLP0hFPDuycROdE4GkzAOvibSbJ3H+/Q4BtfHubtwLjddETpbSe1scBkTZOIFPukEk/kbPNJz1ZMnE95Yhmx7BpUwy7H5SUDxGpmaqTlfd6E8rwmXiPgLHh0fmNHEy4vB255BA25WT9Xv4u685JHZwCaJ+ybm0EMz4rcrFRdSIDWSCIDFzindZWidUisVmHjY/plQCB2BrgOXCxnsZUa6Jq8V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:02:00.3304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ef6b63-3398-43f3-3d27-08df3a5aab34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999090
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

Enable CONFIG_MTD_VIRT_CONCAT in the ZynqMP, Versal, Versal NET and
Versal Gen 2 virt defconfigs, so that partitions on separate QSPI/OSPI
flash devices can be joined into a single MTD device, for example to
let one filesystem span two flashes.

This has no effect on boards whose device tree does not use the
"part-concat-next" property.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Do not enable CONFIG_MTD_CONCAT, which CONFIG_MTD_VIRT_CONCAT no
  longer needs
- Reword the commit message
- Keep the Reviewed-by from v1, as this only drops the CONFIG_MTD_CONCAT
  line

 configs/amd_versal2_virt_defconfig       | 1 +
 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index ea02b0c011b..f280f0e6a60 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -120,6 +120,7 @@ CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_VIRT_CONCAT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index c9e62a85543..b09c46a2685 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -98,6 +98,7 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
+CONFIG_MTD_VIRT_CONCAT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 647e0455f85..23f0cef487f 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -111,6 +111,7 @@ CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_VIRT_CONCAT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 4684edfad03..01291cf22aa 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -158,6 +158,7 @@ CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_VIRT_CONCAT=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_ARASAN=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-- 
2.34.1

