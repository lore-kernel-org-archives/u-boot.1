Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1327FC982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB39D60BB7;
	Fri, 18 Sep 2026 06:54:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I7ye-fv61x_0; Fri, 18 Sep 2026 06:54:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EBD1860BC4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789714488;
	b=k18EFhgptfN3Ax1R3B0hIL/UuweA4yTDQoc7yBk8EjHhPWMKOL0Oq23MKXH9E8gUqmfP
	 oaXf/A6cqVzWwIpSwU3+hFwS4y/KeL4etdjWyGJJiiQ+M5RIcFp13ENcHvQS+N9pRu5fC
	 0Ll5ykBcsr6bmxwDclqZGoOSwEijQC6BPECLn/P/refcya+w51xDSjZkGUnDPndTAi6eL
	 dUQbnDJIcTRQCNAP5BPEcgDV+bkX+Nh8fUC4IrDlBwQWme+/YLrYuovWDMwDHvBQaHEf3
	 xQN9C8g4an6vWphFsaKt00MQLLKEqjr5/QBcdnXywzRl8iZ9WOghgpyUkYR/TFxM8cg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789714488;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
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
	bh=rc0fXBGT9NjPYTVY0I77tDifck7aQu2Xe6reant53OE=;
	b=gUWU5VlfXA+Wbz4WRmbUxaPNdDywMADzrLnPhzIe7Er19cYRN5r5V4o14WLubKjDta3L
	 POr07jHSe+1lOB3sUiwu8ndRTUYbY0rhkVcaT6OFNOsokrXGv1k5pTokzv9uWZK0Qy06k
	 Dtrm5SJwPgMYmEwGtYqoJoObA0Ut6mya44VNEhGJzli1ZL3/Qt4Eok5kK+60gO2PUItRr
	 WZ2j6WCNuKUKN3xk8bK52WMFOMw+eifdXiY48pJ4BHPg+fjqsoWKZslYEap5eNnu7DG4U
	 LFc8jIdO0HV9PIXHvnZtn1tD7pPbnGst7oV062jemYUStR6S5xFaLz4icQCrGW13uDQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789714488;
	bh=rc0fXBGT9NjPYTVY0I77tDifck7aQu2Xe6reant53OE=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hStnedAFK8oOwsAu+rWkesQJQPWSqXH+pMZgA3kQKnCuVQwrYvAN64m9wsJm1YSHp
	 StvSb7O25tZB8f9u1cB79WxE6WLD1ZEptVPYkG58vruj7DMTsCbTfj0HW0zEaezBZs
	 HzFMZySrFCxZWyjuy+0z9jnoYO0iT3LGQOb6wS76hzTgAKv52UbHPtzTe3YCn4GXRF
	 1fKZDOTAoyPczf9wDSh77qHS/uNL0SnY1HnnOliHY4BMJDvUWy6JZDo4sgdV8nVXDx
	 KKbPK5SJOnPHctZO5CVddBJ+BZwwdjWH3ss8p2ymE5DWZ8TO3xznkI4+1jmlrG3de/
	 onzC1cLgLPNqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBD1860BC4;
	Fri, 18 Sep 2026 06:54:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B3EF29B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1123D40AED
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:54:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fqutpCJcdpZC for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:54:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9F30A40ACC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789714485;
 b=JbR7Y4bQGrS0LgqyFdGPqQlFH8wj3UamMZdTMoWSZSMeoX23jeedin3KZedSj1Z4kDWc
 S+G2r+XImX2x50FZU5dDh9Lf47JuVLChyqKaJqrVhrFOI6eCUTBX4M4bsx8YSSgdLiWWZ
 M5qfLfPKONx7CTmNaNOyiPeq6Dn/XjDqX9gIsbkDJl3vZqGM81eSAP6B6DyR56JaQ0baz
 4SDmJsTv+5USzmK7lswgfLIsnHajOsdtxEM/cQ/znSBjloPOEhkjLZ6PxTRmUnmi4jofh
 1DZXacex070QFwJH687neytiHusVkjwKAkcLz1wN4dVFnBnZyEhX6m/wsTf+p0TYkPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789714485;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:Content-Type:
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
 bh=rc0fXBGT9NjPYTVY0I77tDifck7aQu2Xe6reant53OE=;
 b=CCV6MQ/gifMLyRsOa4374IPzf8oGS7Bt4CwMw4ol/YGFVeTcEDM5PduHNrd0P/celb0v
 9aCtKtFTMXkGs1wHyeeVafFGYi/fbSDVcYlEISETzQyE1IbV3faLB+tNZ0cjuQa+EqNUr
 ozMyVkcNQTnJ3JIc9fofxOx3QRZYcTyLXWp8/oR9ajTuGAQgGVOx6yP5DcrNM14k/tLcO
 TejDKM5nsENud9bUtdYsHmlKowpS/c5r2iOm1xtxlkWic4EB+e3P3E3K5rbTIKODTggg5
 Ypvjnx9qPHnMV6l2YXDF+9RxB8UbwlElKV6i5LM5p6NqdsJNNOPorg+30KmaxQD9nXA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="lK8YIVS/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=lK8YIVS/
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F30A40ACC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGvTSoQtkPEvZXZ0i17WvPecdFoTRlzWfl/PUhei6Rud/KNiNE250/0PwqziDTapIcfBdYHRt4E2+aRrxNeXaYLrFfx1lbQUX3++EI3CiUGb/EnGXtFFZUnzXlrvPMAaMw08RB2vflg1ARc/XPR7p/H6nPb2JSFQPiksdjp9Aou42nNEI9whUa3H4qcjdA/E4Wv6GneakH/VT2lBgOcxOuKQJ3VEVJPJlG81uN0KYOHGBvbluzmQMCF964Oj/1T56DKuhKislSSiRii+FXqkZwNh+ZQazVpc7A0rrYwWMOWvaFU/tp978N6eCoEjkrEE6KPVoKNU1WHUyWdBb9tOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc0fXBGT9NjPYTVY0I77tDifck7aQu2Xe6reant53OE=;
 b=GWnCq3FSOjS7IvaJE6B5eSj90ALTu4zqUYhTuS9/TR3h97nVg8X10iGzLdwuaFfnKNublL1ZaxzMW6Zmr+0me8etKNc2JajWPYjSwzkBk4VOozYM1Tv3kRzLDYrfs+Mt5X+gdCavXAaFzRu8Ez1q3utYSx6/f+N1+EoRvoyxJkQsKgseHRVicz5r5JO/5lfbCjkJyIIMhbm11Y01a2svOC8dds18d9TZ+CgTCzLXW3RpN2ynmQ0Dh2aMtcvRi0GXe/dDLC+bAgENtDiQzqCQxvtTdHOMd3k9GmDVXlCTrCyzTuvjSyc8oXlGFLYm8yeO0vPeTFvksrc7Ep54rTAdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc0fXBGT9NjPYTVY0I77tDifck7aQu2Xe6reant53OE=;
 b=lK8YIVS/PJ3nILDfNAyzi4N5aDhaOcyq6ajt3VL24blhPLiQx2SXsDNOlJ4EAmPinLOWoXNUqhbpV3Ck92Kp9p4MNVMrCugOqrzEfsmKtbZOn4iAfl6mb+UorpI8xwunKC4XyQH2qINJyEFsZOfIgnpocS4PyoW7KWJxyBq/Tvs=
Received: from MW4PR04CA0285.namprd04.prod.outlook.com (2603:10b6:303:89::20)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 06:54:36 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::ae) by MW4PR04CA0285.outlook.office365.com
 (2603:10b6:303:89::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 06:54:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 18 Sep 2026 06:54:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 01:54:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 01:54:33 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Fri, 18 Sep 2026 01:54:32 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, open
 list <u-boot@lists.denx.de>
Subject: [PATCH] bootm: bound-check OS id before indexing boot_os[]
Date: Fri, 18 Sep 2026 12:24:18 +0530
Message-ID: <20260918065425.1480266-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 8824b887-29dc-437a-1677-08df1551b342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|18002099003|56012099006|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: oCnVol/4dqUfCWpkGjYmj/sYa1LhsYu0podOf7oLTZnsif6kOHYiDqHj18aLYOQQnhR9qDvvSNtR4v/9sFGGZEAHCS93TPXE4guVGEPkB73zPQO6s/ywF1SFBYUR/V6XG4Al0AsO/8f0WjD8oXJ2wmexSqshNzgYfqCxJdARyeyDkuz0JRfXugRBKO8I/ukPiinJ5t/qSK12FrFuWdzI978S7BDhpN6NjBazw4wxd4wSVeIE07vRsc89x4U2AKy7w8ZRWsdwYgoiOZbBAQuoB+9nG1ArGFE10q84mvhCoJ6CwqxLjzfCiYw9xrhYLbvfXI7GTDpT33Yu2MjBxYV4vaHS94fzAznTm0AQIqEROjJm88/eQRXPNbotesdxXfcspyDPN60TOvRToHVygG4KXmOZH1DdtOqduv0Wij2HNBSSE9ERYSvXEpKQzc04D24siceAXsD4Uwo10rtM2zQpRM9cG4aVnDsYWnepTSVtjw7ofl6kTOQFQ0vDGYk5nO86g9F7J71ue/IMWfj5g1jDnx4I0WBcJK2vGzQozlnXKaVN0JPuUPtbqI7oGwcZU2XADLMYGngF0EBlmzzt2N5lUH1XvFIT/4xxdd62oaCcK5SUcywjbmlphTcJOi41mOJndDLBnr9Ekml1E0jXU/BuEdxQMVl8EXGR6z5YFkG/EZx6YObVxDfFyFQ9gSqJoZY6ZkXOrxrtdqU0Ue+gNEnjug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(18002099003)(56012099006)(10067099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: neMuD3+QNmP2kP4iw6bnBme5CS7a4kS4J6c8fc7raRidFUMYSYu6xoDyF2fAhILmoQD9PRkt5HMf7csTw4kpcSzxLeIKrwAFsSpeoEsMOKZWsNQ+rFr85IrkvZLZdjqjMHAFwdMilPFfdCz2nAvPi2N5jQzdS6fdsX7HIwCrPyv3xHUK0md1xFO8uqQ7tCHhc4/tl1YiPU7jOJ5dluamcdNs/RdJn+wr7ux3LnUaAueS2VD3imROGGYxQkrJBRbDWhCvkcBDu25rO2UnZ+9xCNS72+F5UfxwUDlxFgtsP87Ixlqv/OzoOFixuieec/XHE+YzIt/04e2Z9JSUhK+8MkTQ5htFrYoU/eW/WAteEhuwa6OztmZ7KI5Y5c8F3q60g/nh7TCpe3GsXp+X7mF0nTwvOnFDhsLx1lB3Cw/FT98ysddw3sV8SNuanO1ZKFIt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 06:54:35.2543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8824b887-29dc-437a-1677-08df1551b342
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799
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

bootm_os_get_boot_func() indexed boot_os[] with the caller-supplied os
value without a bounds check. boot_os[] is sized by the highest
enabled CONFIG_BOOTM_* entry, but images->os.os is an untrusted uint8_t
populated from image metadata: a legacy uImage's raw ih_os byte, or a
FIT image's os property truncated to 255 when its name is unrecognized
by genimg_get_os_id(). An out-of-range value reads past the array and,
if non-NULL, is invoked as a boot_os_fn.

Return NULL for out-of-range indices so the existing "not supported"
error path in bootm_run_states() handles it.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 boot/bootm_os.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 88f7c183867..cf67419c04c 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -599,5 +599,8 @@ int boot_selected_os(int state, struct bootm_info *bmi, boot_os_fn *boot_fn)
 
 boot_os_fn *bootm_os_get_boot_func(int os)
 {
+	if (os < 0 || os >= ARRAY_SIZE(boot_os))
+		return NULL;
+
 	return boot_os[os];
 }
-- 
2.43.7

