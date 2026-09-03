Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52640C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BD57810EC;
	Thu,  3 Sep 2026 08:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGiQz_d3FRiH; Thu,  3 Sep 2026 08:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4D1B9810D4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423460;
	b=LiZU3fyTsI9thj7c8eV+WIOfi5XkqnA4C5R7S4sq8ZoFgxtGdZk/l8qnjKSVxCGq0vs6
	 kHMKz9COdcn6KqUrSYVTpVirRBZ/dz1pk0jv0aLhQGVVqfe7wT8BPBKz9iINiIFKzvO76
	 SMUKpK09FApLY0fh05ov/ge4kmkRbA40Jx2kYusfxBwCbKPndTT5w551/u629kf4zWhO1
	 P9R87lfoaFPxDVk55hAZw2uJrdS4BU7//YblRZw0DIpmc5dJ98EVVfggeRoO+/AL4JC+W
	 H5/smasNgrDC2A67UaydnbYnCwv8lmLCuFYi3mdiaRVzHpIU/iiF+jFaJsjdo87iMeg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
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
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MPvnH8uyVFgbLHxyDjKaVzWxzFSWR2oGoH3Lp7X5zoQ=;
	b=QiGrkBmfbfLgcC9ZFPRFyBdu85Qx6ZnuMOmCDx1qgtD6PVwl7AwGZLhxIxDLvMktLO+I
	 MIxHzn/G6Z9kodIf0KxysX3B7FLqA252vSf5BkKDu1j2k8RsrIKCqVIbUMIZdr3VqwH5W
	 /HXTrDFcahmhAxge1Hd5mnmEb86vyeaMHbYKIJeLOwxe+YB65GzYgQKdwXyIHM++Um1cB
	 86ztPYuoWR/zLXwhEGtl4bE/Rwz8borgk6gycDwuOzNGCJR7R7fZHwDaxR9HPaArjeCWW
	 9t2EmP+onaqjgjLTGt3z2/M3tD7QxMM/+sKVIC+P68HRDcwQX7jOmn/t/t+XPMWd1cQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423460;
	bh=MPvnH8uyVFgbLHxyDjKaVzWxzFSWR2oGoH3Lp7X5zoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DDbHhJkXwoP1BCA1PPKsYV1jzt+CTqj2n87gtCkjBwUETNcLrRTaMTCEKSsBFAu0S
	 lLdlkO2wmAG0A4cTDw3uLgBX/j1R+4qSsgU6DulZnl7SNUEVB6Adl0mGrtsPVR9z8M
	 fSdTAixQfvW3/CwWSKQfQ89Rar/cew2y4+gKCv2K618NajgARx/eakORCg4W01Yjc+
	 gutM/8nXPBFiAK9BNvrow7MNP6t4Vv0n1npKW8o2Eb4DzprljC7FtmFJTeG1uPeH4E
	 YuVgWjGnxprwFPyj5CVZZq7/NHV1o503oyPfVqu2qzgWoNnoCS0iw7QKcHx0kIECQs
	 BJntSQI2H6n+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D1B9810D4;
	Thu,  3 Sep 2026 08:17:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5542120F5
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52F9840084
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bp-px52FMMhr for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 13B9C403BB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423442;
 b=ExxdKiBp6SsZnA40awph+hS5bMlMuRL/2DPdq0BrDy8wx5bAV5die5mVX6Whd2AYApPB
 9xxWdgYWwZy7sWNW7+IL8UjQgaTq4GaIwDw3ipCR9cc1q6MDszYhKhUn7UaVsARK0pGr8
 M7kI5BwuNKe58jjNOnrsI4QlOBeSrB5uB08VYnuzhzgQrUR8o2FLIyzzpYHAEXlZ07bjx
 3MQAPywX0FlhS30MH0pR82TmSgxZbNZHOC/BxbW1aeESwH7hi8bbXjKt83Ee6EyZH/Ys4
 W2If9ckyu6PyiBfIfAdAXWR/dBST0ZzBigGQC4icrF4pfv1i2KRAQOsa/amBiHyU4aQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423442;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
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
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=MPvnH8uyVFgbLHxyDjKaVzWxzFSWR2oGoH3Lp7X5zoQ=;
 b=hW5Whiqqrdmogsu7nXXteHOQmKS7C1XN5iH7dvHtTXl/rcE0Yq8+7wln/zFnb2pqnbhR
 2doWplkswROEizJvoBEWc20BmMKV37eckr+iTsgcz07byV7k25JK1Lc6OzrbcqppYU9wY
 NZVa323WWpQ4+tlTuR1kOzwxHYWkoq+7AoeI4svBpeTQRyENKv/vJMTQTIDfQbmE/+MYR
 CE5eG6R2chiVXcIQI8xjA9c+EUxlK2sJHGi1LFNXNR27GBt2dRANo/wyD0X5WNDJZHqz3
 18Kf4z9jGRf910dJxlCHfPSx+waAE6B0CVXoiBg/vxJi9MLoNu97hCp71LlInHryNSw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=B1v5xF5m; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=B1v5xF5m
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13B9C403BB
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXDrQak9U2tWnUgqSXQW1lRIMWfdkbyIQKqBX5T0kzoIxbfX8npTAXpNkvdV79R5y5l23m3/1IEnLP2tbeEm4ulHmc073bAHdY2tw7y2aP4dMFKtNLfXmQVqzi12lPFfIoLU+8oFZTQejhj8THMYF3oJiryqt7DDwyhlC7wyyFsCd/7WZ+l3GIatsFgonGyEJhHN5OUQH+Euhmmq6+jbJG5Q7FqbxBFAsoq76p0BsZ0o0BH0R6ldbxtELl7VLt40JZZZvhUhJj029U0YkQ97TKigywN9BuB+mZXYsgDdPavX0uPrmypCdGfzq/GOXhDxW+407jGbLXcoDSLVGKGQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPvnH8uyVFgbLHxyDjKaVzWxzFSWR2oGoH3Lp7X5zoQ=;
 b=PfjEEcgw3SoJSNvklP0hKoXkTjT8NsAfOQJlg81XH1uqyxFQQ6d4I1CSwtBik8r49G5o/uyoKPf7fUZdJu+NdP9Wq9jEVGmeE93U4GgjbW3euOjZuec7DSdGMRdOStrr9zIxIGPAQ3tC6GAiy0nF/kC+7D5yDYvCtulwG+kZLoxgXYgt6HOKzHQCJxTMI9K/IwWs+3Wfazrf3MekETi5o8lbclEaHXuW1IDqlFWXiZinP+Ytx1vtW229yX5/U8ycxl/6fjnycHg1FQgVpIJr6jAlfFxRVUl+JrsQFX+iDQgUDnzNp6dQ3/bMAWX7uVAtcuFV7gSSgJOnnq65Gb4UIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPvnH8uyVFgbLHxyDjKaVzWxzFSWR2oGoH3Lp7X5zoQ=;
 b=B1v5xF5mEpV8d9KX+1/UEy3A4JdD1KoJ07Iprn4GMqCDUjxsRvtAk/53EDUP9Ssig91e15zFIS/yndyEvoQfjU5hN/FhtO7WvWMcTR3Idrk/9b6vAYiuX7YZyJvdEdA8pLw4pS8tZy4TPZVPijxD7lWtBGjg4f2I8zV5/dbhXse0ZfWJ/SADCHRq41ZYKGME/E6Qo6W0iOQzIpPtRruKpRsLDX9ZxQ4lZ8RLKrUFfBRrLKGykexIbEb3msLYSUqU+2L0a+vTrA4DuZFwSm1R841KM3j9QW5SMieN3wEhBGyhsaM0rufS3Y+59KazwoHvGkZBRBFm4DpruImF8/6dow==
Received: from PAZP264CA0137.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f8::15)
 by PAZP264MB2832.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:17:16 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8:cafe::9) by PAZP264CA0137.outlook.office365.com
 (2603:10a6:102:1f8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 08:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 4AA662017B;
 Thu,  3 Sep 2026 10:17:16 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v9 02/15] mbedtls: enable support of ecc
Date: Thu,  3 Sep 2026 10:16:52 +0200
Message-ID: <20260903081705.12894-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PAZP264MB2832:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 45bb29fb-8564-4dce-4701-08df0993c419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: E4Rnxm1oD8WgNQyvDTlVYz/zAunf8tL/w4rhutppYdmeuOoetZvdIogTyNiSV6C/x1i/6723Fj4+O/fpbjfbPFr/AWwJCY6SQn2HDqX9bfhFclk3DJ7KB3zNFIozlVEqu5XAYQJLkGnLaQ9goKVKQgMF15dKCyKVTxYt71LL/xdTUSLq1vOF+Vh9KMpoA2P/m6Pt08o8NGwMFzlOUP83ET/bmmRoeGbHmQDwtuvJTZ31SbkdoUCacLAOB4CClQ69Fq3CPjJC/PJO369BBE69MnUiBoUDlztXjx0S8no7raHbzurYoUX5piTASoY4+RpOsBo03RMIJGxZTycXvkjspfIvTFWemATdpbH6D5cRm+wwbVWd5xmbp+jbeC5pE8HLnTqmga3HgDBGBk7/yfNp3IfNsLmq1AsGrrs7vsZPhPtmYid8Tlh0rrpwmLpUXYbQrwE5rbAhJCmNehtmOPmerpBghIJezjnpGitRcrIR3XQ8Z612BgT70BEmPclYXSDKcvTLIPBsF5WpRQrdjbrIyMy/AP7qArNXDHRt4tkW0LXp935SlGVqoGcUNwCzhIiz4WGSQRo4Jgh2rDCMPlFULT6yxqYm6G3YNlY6XZ97o+lQq9OBilLYg4gZ6siQlZ/mlGe3HVlfd1KJMjCZ13Z18FxCG39IFiJ9xhEl8CZm3W3NtZVthO2aomtGw4HquViPjGsBHHTqO1V0w07AwKWYVA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +CXCpbokLoQ9JpCuXtvbQWzyMa89Za22+JzZ1s6hPEQl7BouFdN0vFbBzi03j5C785/rGJqff4+XYs9S0PDREC0pXCIaf3d7700obtg9Gwn5NLQLaAZyBoReApzT1Kwl0kMHOYvSFA00fIqh2rKzk9vqA/2uiuJXwCycpchqmwcXPRIt/wpZZRHJrNhf6QNUnz1/bqGfPpaKVrlyPp2f4RvK+tafaphAsVGhoe+vdcX5JplR5Pmy2HBlGxNhwUco2HE+LpRy966Qb5lLaiLyX9gCr8SbGjWvWib37L2cswJ8XliSUjYKcf4C7QOo4aPJBflau8Mb7Hn5+NwadhI8rjQfvVqDkaae6c5s8/dWLKw+pt5uOCvvUmZ21+NPtnfBPpHOFK96p2o5VF+3AAJh3/B70vnavn/bk1ApDFGRQwC3va55RQbVbvvAoj6UsL/R
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:16.4276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bb29fb-8564-4dce-4701-08df0993c419
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2832
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

Prepares the support of ecdsa signature check
using MbedTLS. It introduces the option ECDSA_MBEDTLS
to enable (or not) the support of ecdsa in MbedTLS.

So now, ecdsa is no longer supported by default in the lib TLS.
To get it, the option ECDSA_MBEDTLS must be enabled.

The option ECDSA_MBEDTLS only enables the ecdsa support
in MbedTLS, it doesn't provide any API to use it for
signature check. It will be done in another commit
by adding the option ECDSA_VERIFY_MBEDTLS.

Two internal options are also added BIGNUM_MBEDTLS
and ECC_MBEDTLS. Those options are used to share code
between different option and avoid duplication.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- move ecdsa to MBEDTLS_LIB_X509
- enhance depencendies
v3:
- do not use _MBEDTLS in mbedtls_def_config.h
v4:
- do not select ECDSA on some configs
- remove duplicated MBEDTLS_ECP_DP_SECP256K1_ENABLED
- change dependencies for ECDSA configs
v5:
- MBEDTLS_LIB_TLS depends en ECDSA_MBEDTLS
- update some configs according to previous change
- build of ecdsa is conditionned by ECDSA_MBEDTLS
v6:
- fix dependencies for ecdsa and ecc on mbedtls
- ecdsa is no longer mandatory for tls
v7:
- no change
v8:
- enhance the commit message
- use /* */ instead of //
v9:
- no change

 configs/sandbox_defconfig        |  1 +
 lib/ecdsa/Kconfig                |  1 +
 lib/mbedtls/Kconfig              | 17 +++++++++++++
 lib/mbedtls/Makefile             | 17 +++++++------
 lib/mbedtls/mbedtls_def_config.h | 41 +++++++++++++++++++++-----------
 5 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 5c97418783f..b9991d269d9 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -389,6 +389,7 @@ CONFIG_PMBUS=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_HKDF_MBEDTLS=y
+CONFIG_ECDSA_MBEDTLS=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_RSASSA_PSS=y
diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
index ca13b6bfa1f..dac8bcf23dd 100644
--- a/lib/ecdsa/Kconfig
+++ b/lib/ecdsa/Kconfig
@@ -1,6 +1,7 @@
 config ECDSA
 	bool "Enable ECDSA support"
 	depends on DM
+	select ASN1_DECODER
 	help
 	  This enables the ECDSA (elliptic curve signature) algorithm for FIT
 	  image verification in U-Boot. The ECDSA algorithm is implemented
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 789721ee6cd..e019f17d6bd 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -247,6 +247,12 @@ config MBEDTLS_LIB_X509
 
 if MBEDTLS_LIB_X509
 
+config BIGNUM_MBEDTLS
+	bool
+
+config ECC_MBEDTLS
+	bool
+
 config ASN1_DECODER_MBEDTLS
 	bool "ASN1 decoder with MbedTLS certificate library"
 	depends on MBEDTLS_LIB_X509 && ASN1_DECODER
@@ -264,6 +270,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
 	bool "RSA public key parser with MbedTLS certificate library"
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	select ASN1_DECODER_MBEDTLS
+	select BIGNUM_MBEDTLS
 	help
 	  This option chooses MbedTLS certificate library for RSA public key
 	  parser.
@@ -292,6 +299,15 @@ config MSCODE_PARSER_MBEDTLS
 	  This option chooses MbedTLS certificate library for MS authenticode
 	  parser.
 
+config ECDSA_MBEDTLS
+	bool "Enable ECDSA support with MbedTLS certificate library"
+	depends on MBEDTLS_LIB_X509 && ASN1_DECODER_MBEDTLS
+	select BIGNUM_MBEDTLS
+	select ECC_MBEDTLS
+	help
+	  This option enables support of ECDSA with the MbedTLS certificate
+	  library.
+
 endif # MBEDTLS_LIB_X509
 
 config MBEDTLS_LIB_TLS
@@ -301,6 +317,7 @@ config MBEDTLS_LIB_TLS
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	depends on ASN1_DECODER_MBEDTLS
 	depends on MBEDTLS_LIB
+	select ECC_MBEDTLS
 	help
 	  Enable MbedTLS TLS library. Required for HTTPs support
 	  in wget
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index c5b445bd85c..0c86c90d15a 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -39,13 +39,21 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) += \
 # MbedTLS X509 library
 obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
 mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECC_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/ecp.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
+	$(MBEDTLS_LIB_DIR)/pk_ecc.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/ecdsa.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)BIGNUM_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/bignum.o \
+	$(MBEDTLS_LIB_DIR)/bignum_core.o
 mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASN1_DECODER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/asn1parse.o \
 	$(MBEDTLS_LIB_DIR)/asn1write.o \
 	$(MBEDTLS_LIB_DIR)/oid.o
 mbedtls_lib_x509-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
-	$(MBEDTLS_LIB_DIR)/bignum.o \
-	$(MBEDTLS_LIB_DIR)/bignum_core.o \
 	$(MBEDTLS_LIB_DIR)/rsa.o \
 	$(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
 mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
@@ -64,7 +72,6 @@ mbedtls_lib_tls-y := \
 	$(MBEDTLS_LIB_DIR)/mps_reader.o \
 	$(MBEDTLS_LIB_DIR)/mps_trace.o \
 	$(MBEDTLS_LIB_DIR)/net_sockets.o \
-	$(MBEDTLS_LIB_DIR)/pk_ecc.o \
 	$(MBEDTLS_LIB_DIR)/ssl_cache.o \
 	$(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
 	$(MBEDTLS_LIB_DIR)/ssl_client.o \
@@ -82,8 +89,4 @@ mbedtls_lib_tls-y := \
 	$(MBEDTLS_LIB_DIR)/cipher.o \
 	$(MBEDTLS_LIB_DIR)/cipher_wrap.o \
 	$(MBEDTLS_LIB_DIR)/ecdh.o \
-	$(MBEDTLS_LIB_DIR)/ecdsa.o \
-	$(MBEDTLS_LIB_DIR)/ecp.o \
-	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
-	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
 	$(MBEDTLS_LIB_DIR)/gcm.o \
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index dda3f4dd6e4..d55f31acfda 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -62,6 +62,25 @@
 
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
 
+#if CONFIG_IS_ENABLED(BIGNUM_MBEDTLS)
+#define MBEDTLS_BIGNUM_C
+#endif
+
+#if CONFIG_IS_ENABLED(ECC_MBEDTLS)
+#define MBEDTLS_ECP_C
+#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
+#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
+#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
+#define MBEDTLS_ECP_DP_BP256R1_ENABLED
+#define MBEDTLS_ECP_DP_BP384R1_ENABLED
+#define MBEDTLS_ECP_DP_BP512R1_ENABLED
+#endif
+
 #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
 #define MBEDTLS_X509_USE_C
 #define MBEDTLS_X509_CRT_PARSE_C
@@ -74,7 +93,6 @@
 #endif
 
 #if CONFIG_IS_ENABLED(RSA_PUBLIC_KEY_PARSER)
-#define MBEDTLS_BIGNUM_C
 #define MBEDTLS_RSA_C
 #define MBEDTLS_PKCS1_V15
 #endif
@@ -89,6 +107,10 @@
 #define MBEDTLS_ASN1_WRITE_C
 #endif
 
+#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
+#define MBEDTLS_ECDSA_C
+#endif
+
 #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
 
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
@@ -122,7 +144,9 @@
 
 /* ECDSA */
 #if CONFIG_IS_ENABLED(ASN1_DECODER)
+#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
 #define MBEDTLS_ECDSA_C
+#endif /* #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS) */
 #define MBEDTLS_ECP_C
 #define MBEDTLS_ECDH_C
 #endif
@@ -130,24 +154,13 @@
 #define MBEDTLS_HMAC_DRBG_C
 
 #define MBEDTLS_CAN_ECDH
+#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
 #define MBEDTLS_PK_CAN_ECDSA_SIGN
 #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
 #define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
 #define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
 #endif
-
-#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
-#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
-#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
-#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
-#define MBEDTLS_ECP_DP_BP256R1_ENABLED
-#define MBEDTLS_ECP_DP_BP384R1_ENABLED
-#define MBEDTLS_ECP_DP_BP512R1_ENABLED
+#endif /* #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS) */
 
 #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) */
 
-- 
2.43.0

