Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5577CA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 08:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E5E160862;
	Wed, 30 Sep 2026 08:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Ky32pWurZmF; Wed, 30 Sep 2026 08:53:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C9AEA6085C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790758398;
	b=kFqxZWl5aOHtu2fWYuh0F/uhAfmvIJriz6WqzI1+nxUoCbDdz1RPyajXhqg66xzFvN2r
	 UPFv4pNWObyxPWfsg7EpAJ2ckyZ2I55GQM5ot1cIGbZjpTkOsjOvyGFPYUmDgsw1CQ1UH
	 u5EhHOyw/HSb9GPkir7KWVIjTUB7y24Dvlkq0Oiu6UXlBp41uDJz25+Od9RLmXWi3jsKa
	 UKiQEVZg+DShGimbyRXnJoxeo5wrDUP9FLXFDbtN4rQ+Us5jYwpU+1Ep54fy/6U7WPcoR
	 JWVIdyfvtTPmwsctCVgL3IgALWISC2HR2oSQJbRIuqchgt9nG9McUISF33Frm1TKU7A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790758398;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
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
	bh=9R26hq3nQ2yx7JlBNXUCe6lsDEqcznVIHj8P4pRrmAU=;
	b=DbbfXluW6R6bnAmWfm8gv1P9/yAmspC7hVEv/Igg7GNOBpXcSc35329I2KpBdIloV5fx
	 ONFyStsrYQgRNlZ3WRfrQNlY7vV7avJ2QSIqnyr47Pih2QsoFIFUKMMF9uezGoHzuPEww
	 mD9Rkvr7qDGFCRJ93XJpkVftwolAXbPrSPxW06NPJH0+/rleWuKKQUWsrDGaMan1SF/x3
	 Rs+yqOqt9IswZDo1fjMtqYlNG2XJMrVyQPC6JnXwIeqbJfMocvROGvMHGPWt4B1uwlzPx
	 yBS32dRzhE40N7WO/caG9ukyYBPHsFBQW1R89+393Pm0lxgiC80pNjvGlVY3DP2IYvw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=msPIOVKx;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790758397;
	bh=9R26hq3nQ2yx7JlBNXUCe6lsDEqcznVIHj8P4pRrmAU=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QascIIrNCw9YvB7t7q7gvg3TGXgxeasPZFLqqVzOdxHfhSKL5h0grxBNMgsB6ndad
	 lTOaHB6qt1vDfykbNVdWnW1xq26H9ifdAbwsxtF04kfolY93nJv9HtZW0p2vDZwry6
	 fNCfiZFR68T2i5Fcm7g3EdMlYSGrAIOstD2LLPK612zprl5gYmtTElRNjzGhjumot9
	 qWYgI7FwAu6BdOaWIKVbBn1UrbZwRd8txdF27/kuZ7yLXZWtaSMh6kOMrj7QDUa2le
	 6kh1XaQkF8+r5pdoCKNPy7ZhaMsZ0lh5tAqvPnxrgqbmLS5I7jTwF2CwGc9D2IhoHb
	 HtKxOE+eYQF4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9AEA6085C;
	Wed, 30 Sep 2026 08:53:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E717E282
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC7B56085C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:53:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sbrmtFNSPyKA for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 08:53:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DB45D60855
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790758396;
 b=B9oxX1uBHuKbLrC9k7TfdDNA74RnlUy/t/Olfnlpl5IMyT5wOsACFGCl9Ox0REfJwLCt
 01wWX77gFk1MR8ak7YeRaTB/bKSwyHrH17rq7lKJBIYSlqjMNs9ufYLmQnsjpJfixxPFu
 oWHjsonpgRmW36wdq+H9ALWiqTK5pkMvp/MN2wdZ4Dc59o5svs6dHU/RFIQhpWWeK/TQ1
 vjH00DBFJSu84H0fC/5icw17PiZIla2tt40Y7ydChy5MAr5NxavJjEMHgZS6nGYRBviG6
 rDF3VrE7sFIWWiecLXEwp1WxdAlEZp2Qnf7jkpTvBLjPGlTtAbUg1Ov0N3hNJRvtl1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790758396;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=9R26hq3nQ2yx7JlBNXUCe6lsDEqcznVIHj8P4pRrmAU=;
 b=YggtyblYu/kcIynOnVmxYW3S9tLb0PH3Jv9dfQ5aMnk7uqEwiSS8LXW8/HG7EAIiv/Dr
 ZSpAIC97znrRV94fTfBPpVaVzDXIURuR6a01ABaNRIcOiucewph5fWJChhIorQkyzNHPR
 X06KAjlIkkeb2wp1uIGE7kkBYoh+lF8E8QPiD5X17QfE7ugeV5w/74ptgnZEjK4ppGK4I
 XlT0oPyp0xN3mEJj6dIN9BbUvCx0JC9I26U/3+LBvuWJ9G04KeTrxcDi0U/rknu7yspUs
 KvuLpBvWCXncVGER6sSO6sXNIYx2yrGRjbJhZ7rWJmAe1dB+OeKNpkRF55fXsCytvJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=msPIOVKx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=msPIOVKx
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB45D60855
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSiq6SfBm6efZ1hRKQsXmY1YA8uB6pi9Hius10ASTN41T5hrWofvMcfjbJcWJlQOGw6XJpyJ/sBzw4bV0SmaZ/YWqYYubpUMRw9zT4KdBH7XVWUI2tSCcZVTTD+3PRqi1a9XdBoGFIdVW0ecAuWqsW2sj/sb5uXn7E91ENDL4aLKtOKRnA/9D/E/X5Qhbz/EWzEh8UcrGlHhc8QXritJTL2MVz9VnOv81tfl2K0hcT895JteeCtVu5cvSBnxTBEmFyQlW0Xn5Za5rV1MNKP0JpmmJBCT+lS097X/ryNT6KfjRJ9E1jrAVi5eloM4dfxQ6qJU7aR6Za81Wystw2AFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9R26hq3nQ2yx7JlBNXUCe6lsDEqcznVIHj8P4pRrmAU=;
 b=DsRKSW/M7coyfEIzzjQAjNFmUzyZ/zVFoFwd9i9PrGhW2eutkGZ/o/Ouk+7qJXESwV5Ad926B6mqTQwT0V/2R43Du5frjRXzXh/f2t9If51399J2T9LxjPNZTdtA8BGUvkKi2JeQh2mYManSgvmxFQlNPDlBcb5mj/o3EC8RAG3Qp/uOY5qPECL0wRLNwBwvRUMFWi/bz7Vk6hXmgnSBi+yf5Vm9nPo7KUIju+tTttMJ+SlDVdS3eSy5bbHKTcFgcgS3VVTetn9kG0p7VFCGiRTcfJpwVy5iAIlg4ocShfAZmcF1rRoU6d3XqRSL5Si+n95ZEA/8SOjiEiwv4OO58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9R26hq3nQ2yx7JlBNXUCe6lsDEqcznVIHj8P4pRrmAU=;
 b=msPIOVKxQmmvEAkfVT4yem8TBT5Jyvg83LMds6/8+Z5vFJdYe5PsyP8hU9Br/UMCKwDWCHyXvpyEvrNAd5muPnwwhdtsYt4KYEOdn83RklyWTya6mRrz3Euw4EYJrX1jZInMSuNXBrbcMK098V4AEpXuwEkRK8bQKzZecyJijWs=
Received: from PH2PEPF0000385A.namprd17.prod.outlook.com (2603:10b6:518:1::7c)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 08:53:08 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2a01:111:f403:f800::) by PH2PEPF0000385A.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Wed,
 30 Sep 2026 08:53:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 08:53:07 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:52:57 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 03:52:54 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, "Francois
 Berder" <fberder@outlook.fr>, Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH] boot: pxe_utils: Fix leak and double free when using fallback
Date: Wed, 30 Sep 2026 14:22:14 +0530
Message-ID: <20260930085220.3226707-1-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: b115bdb4-2ae7-477e-7dbb-08df1ed03faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|32650700020|1800799024|82310400026|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: BH3fAyy9cC+ZChiuovPo0g/+pM0oEdLB0tv4zBC8H6DbADG3HrYTNIA8iRNdTDuSNqZ4ki9dO0aN98u+ba22ZUqkvEqxd/6uhd6w9UN3jmPlUjKTYM1GzrCMNbFvh6yPntnzmw6ho8cqn68cd1t2K9B+bBgR+xQIxXr6l9f2R/O0aLKY/gSdsnfCWK0SK1d0ajgg2P8rh0fBUm/mH9IvYsl2hIYC4flEWZ3YjdjcBy8VqGXCtPXNLdrSh4PpiI91q7zbT25KZqHfFem4Vk4Fi/KhFUR/q7qk6sfUloXjwvQlT/vRmGO76XCaEL1tCVfMdPjciv7BhbxsgEPEUQKHAm6GdHTiOSIeGywuEUEpV70l+AOzBA5Py0vKdjpD1IUi+Cz8OgfUVIUC89I6cHVDnuJYqBAgZjJoyOXqDC+CmuM7cFEfyDkl6uadYzAoYll+RTmOK4H25I/DNwMm2+UxxUiTUJ/vHF8vSzS35W6DFrGgcqoYzZnqC1qtKO/hE6FN7YTKfA5MZoT5qmyd4/mLFhF5EgG9XSzumr6J3fkV3icJmfXwoQ717hYfg9WeInB1HveGZRzBjDxRk4ndP0XeWVUESNQ9mwOuj0/1jX83loOwJ0YP+OsiAI+6DDqHwR54bfPKDi7VdgY94IAeE06Wji6AUMCr09jNq2hCvn5B3+we5lCMBOhqrwjFSbbUajN0NTILCaVk+D3TN9bisn40aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(32650700020)(1800799024)(82310400026)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MmCnpD37VWnc/SnvHGNRMflOygUjL2fl6+U39ZQspKfoOGfSNoxGUuPJ0FRfgBVFSbozRVWa0nyzxyp9Z2OlowLkT6FnTafQlDASQ+JJtgiWrxzrPNX2JUGm6njvikx/4m60iCvcqsNGP8r+GLOsOcMJnsqoK6gmxIbuCmD7HI13kIMkSohrtFMqDhj1pNJD/OrdJ01M04nMVbvH5cLvtlKOMB2+XGNyb5BZdvtYIvxNxxPdx+uDgC15peYUVrnbk1bO+luK5nOJ5UWdizysukqwKK1SPup273qDfVeT0qRCj03GWWnDLQFCOEZopMeIQCRWzxT8naJlhsvlJWAZ2+8hbQcj0h7a6nAhcvXNIeW1drnEyvoeDMiJrLrATAPym8liuYauy+79VM9WXKS4ng/veVflv6WkCP8ESH3tqj9iibt/j7BAf7FM/QNBs5v+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:53:07.8792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b115bdb4-2ae7-477e-7dbb-08df1ed03faa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744
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

When use_fallback is set and the config defines a fallback label,
parse_pxefile() assigns fallback_label to default_label. The previous
default_label allocation is not freed, so that string is leaked. Both
members then point at the same buffer, and destroy_pxe_menu() frees it
twice.

Free the previous default_label and clear fallback_label so only one
member owns the string.

Fixes: 8ba82a91b3aa ("boot: Add logic to enable booting from fallback option")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
---
 boot/pxe_utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 8c1310dabeb..9841c426267 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1529,7 +1529,9 @@ struct pxe_menu *parse_pxefile(struct pxe_context *ctx, unsigned long menucfg)
 	if (ctx->use_fallback) {
 		if (cfg->fallback_label) {
 			printf("Setting use of fallback\n");
+			free(cfg->default_label);
 			cfg->default_label = cfg->fallback_label;
+			cfg->fallback_label = NULL;
 		} else {
 			printf("Selected fallback option, but not set\n");
 		}
-- 
2.43.7

