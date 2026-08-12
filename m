Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED91C5B56A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 13:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B73E380DDC;
	Wed, 12 Aug 2026 13:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sk15VBiDFv9O; Wed, 12 Aug 2026 13:09:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1C0180EA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786540199;
	bh=n8yOkKMIgEWPiYdEcnpJ3CuCJnA/My57L7wW3QaeJGU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kXeCnBqVpylxYqMTMn02jvpcth3AcO++4xGXamPE/y25XqQJ9TOKVrlFr3lE0joD3
	 bH92bEHTdmIIOUZl7ZwlY6olhuf+JsgdOA0HOTwXOJw/e6HeM725k0EJx2n9XYpgo4
	 6yHM1FOa8xak/NrOSXLtnZm5wanY3syR5jSX95wWzyDrgWNRdeNkg9fmjjn3G7OL6l
	 n9E+3RP22zsH5imKGn6kmQahOFq9QjD9qL5tZP0CqeqiXtedh0QLskbAOjU9wNg5G2
	 ZHCwJ0XbfZtdxpG66JyLl2RB6szSwsIVifpkOy/En7+0P0lgRLjfljH21fhb3cD1Ot
	 +wtpN0OT3F6EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1C0180EA3;
	Wed, 12 Aug 2026 13:09:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05C493A4
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBEA3403E0
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkvzNXETDZbh for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 13:09:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7CD47400FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7CD47400FF
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CD47400FF
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:09:56 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Jlub4yxKzeBQ8ENoerRNamZGqE9i1SRpanBu7HFdsOEAPNrYMkvglFmYaSpgfjuVncaNJ1PGjAbFxBQgBbRrel026oNvTaAWygvuT5D/x6QNsnXfRBiqqBx+tj0bv6EsB7Xh8Mem8n2z+hfikLSd64f8A5tNLxgEhFt/nWQILSwth/GP70piPLntZL9THBNPB7lY9BZx2OnmGATwNUP4Rh5Lr3AHCONAtHil0s5iIdCwyQaEps17f5pooMYLZkdb9tX8YDNtBbP7PoJpLROEcEP8Njs+r5rdDJfPYA8+5QT1+TNoTVdHbVdLia01GXDieYUC+48x33DDydhS2NiB3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8yOkKMIgEWPiYdEcnpJ3CuCJnA/My57L7wW3QaeJGU=;
 b=HNdWSmgfNpzELc+IdeQtH96kOwf625XsHt1Kvrf/mghMM4cf/sepMIPVzpjSl41AoumxETbwvEynzDMPmc1jAm+mDujV7ObaOMa26Ma/ilw3/XpAv0JE0Zon9FeO1mvhNexG+xt1omR3R27mWdfNip4KGj1BSNfg1mUkOjvYp1IDU7Zvi/TJeRv7AOQ0BFewsZszRC4T3ECiJluVJp/gf72L5iQt0TjZnjqMNE+N9YVEW6p7PAv6c+/0I/PvcJGMK+IAaXuxfvcsGc+tLFGC5d/mHpPZERFn/w198S3uy5rTLZaDqEcMyLRDdJ55nta3Y9Fx4Y//mbaBuZn+tDDhJw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=byteray.co.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from AM7PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:20b:100::28)
 by DB9PR08MB6489.eurprd08.prod.outlook.com (2603:10a6:10:256::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 13:09:51 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:20b:100:cafe::82) by AM7PR02CA0018.outlook.office365.com
 (2603:10a6:20b:100::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 13:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Wed, 12 Aug 2026 13:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFQ89beO0N/pb3w9aDXmbyMCB6YQvJx0sT68hRIQwjRzA1UV81MTBUwtkT6JlxFo+Tli8xT5yyNR1uLa7jDfX3nsqEhqn7tR52Z3vmI/ifUpoqQKwMypjgQ/KbDPUFDLp0TaZdyGS6MkrP1/GHmy8GPYRHpLMxi56eiseiPBylKijrWbDPTZEQuKxlocBWqvsmzve218zFoGJqHdDTp1x6TTRp714a/XU/XA/hwbWql+HE0COg3JmoZEEEAYC5WC79Wiw8kmucwHPuGVQfARQ8Gfa+oEerADAVs87g6nhgG4Yt8EJ3NYAkEXgu1H5mhMjBPGw4v6VToSDRwvwUd7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8yOkKMIgEWPiYdEcnpJ3CuCJnA/My57L7wW3QaeJGU=;
 b=kpUnUBlEij6d5b5jxtaEPYhVhLYg8edPyNqt+YDE4ddv1OmLJFXbccfkN2eLbYaRbZ32L1HVLIW9pTCWvZIA5w4mBwr3BruFn/7ggGKfkLx8BA4Cu6gTHCg2ADYPWzz4BhEUoRkafaVp4SoUwL95jONIJzmxhpuaQZMxpcx8AA28LpUIFEZjczU3ZgpRgZzZGhSSuz3kFRbOYRLf2u+GcCTkFR7kSBa0GLKiei37T1ZXp4Vt3/c8KXzn7MQXgaDZhLaUuPeiEYKM/f6Y05KR6uGNwqDvMDUGORgMQoqoo6w7cqxBjoMfnNosCIcbYF1ei9NoGxn7GnjntuY4wy3Kaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAVPR08MB9652.eurprd08.prod.outlook.com
 (2603:10a6:102:31c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 13:09:15 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 13:09:13 +0000
Message-ID: <562641c4-f600-46eb-9b84-ece7bda0fce3@arm.com>
Date: Wed, 12 Aug 2026 15:09:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: dhcp6: prevent an infinite loop parsing IA
 options
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sean Edmond <seanedmond@microsoft.com>, Ramon Fried <rfried.dev@gmail.com>,
 Francois Berder <fberder@outlook.fr>, Argus <argus@byteray.co.uk>,
 nd <nd@arm.com>
References: <20260807-poc-dhcp6-ia-loop-v1-0-9d3fd3171c59@byteray.co.uk>
 <20260807-poc-dhcp6-ia-loop-v1-1-9d3fd3171c59@byteray.co.uk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260807-poc-dhcp6-ia-loop-v1-1-9d3fd3171c59@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAVPR08MB9652:EE_|AMS1EPF0000004A:EE_|DB9PR08MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 726e1d33-fd0e-4bd0-6b43-08def872fe8a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|4143699003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info-Original: lHpv3NIwm5NdqMmVIf7dVFV9/UuLzOEfdfEDJ6w8wrJ/wwWy5Guh6blTi/UqA8eC7D4UIXWmsZFwheQD7sF2sdtDlhxN/o/pA7ZGmYWpheENfT809xU/3AzsmX2hw+BGK6TkjqNBNdkjzFe+PeV1MHPZuTMkwKGI5/MJHBGwEHqPnxryAObFhlGnsaR+9A98yiWiTqNcIM3tmsIfQCat70Slu+GqpzL360TBOmlTpc63L2N60SXKbO1KVy2SZYJBzAoc6K2wr5yAPh4THv6+zjQA1r1C9j9UmcuafMgvmvMcVGP6FGGnHuSm2JLRD7Rj9h2985nP002f23WBWoswRgPRQK02+kHIXA28+b1xrMDhYZWWkPgvc78eavt7nKuF+FSJMO+bwUBhQ1lvZEFguOmjp2UzPJMpOmruaN9gayMHv6+bxM1IP261bS1pk9OsGeax7BVfsq0UP18uRQcSJtiPF6uUzOhL6U5+mi8+wuXz1utMisJH0Y98oEW8PpeHCndDWzeFo251XT2Ki75bFG1Act8tMgbA+TpT2XpE5CEuDHqhWDvyKzNmwoOXi3LNTDbxyfgyUrcvebjPfz1xU7zlksf26lUfLj+a7nC+VmfZLKXpmv75hOTBAW1dDKLkghQwtrcB7kOItazXqqBIkw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: BuKHIYNc1bxlzjdKJrzPBUytWBm7CfwIowPpHOCCElrhqw6zJ7k19/DOhCK/HYnyiLPree4/i27TKaPntA7iXm7gS/TLrEPHPRWaeFt1dVr2b7eDNhP3nSdUywzffs9DzqtbY0AaJlnsSZ1QMc5Z5r2dY10Zvuh12OmXQIOpF5FaD+vdTR6wOmWoJ2bNGITRY7EbhdxJhOqCRHVZuY4q8UDBixlmQs4ImE+mQUIGiqcpY86EiJhPPy1N4vDVr44a7F9WpaQ18Lrw+dXW3PmJrA5Vd6knNV8xC5c/Isq/OlycqJVDvMEwyII7pKQfW+hi8CcO/L2SgOcWvZcnX4/P9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9652
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1d23eb45-c3cb-4c92-818f-08def872e7fa
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|23010399003|82310400026|36860700016|32650700020|1800799024|14060799003|22082099003|18002099003|56012099006|11063799006|4143699003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: bGZifkmRH1bUyogLaglu/6gD+n3yqgCitqLzvPGS6NIBcVur+SFne1fKUjvJASHcAehhCS9nljeDXvLcyBxsWNJ0v6Ul5aQ7cfoWTaRG2AzKiJymstzy+u+WLpyRnQT5AdrDBwdyfOiKdCyUOmUR7rxoIdYw5ZGpOMlRGxrxdsJ0l/6LOuZMbDc5q2Hwax52FUWX5d5hE1nfEDMyJEKxqbCeJi8Z/m7sJiADmeVHnWRhG1RVWr/8L1bnFSIrJLDueD3TBA2/WsW6GFVLPwfw8IMcYOEbsie2DL6pWPeckuMvRy00UdAvfYzEo/AGnaIxgS1Fq9OsYbU0SJ4WpXwhFI+dvxP1iotlYbGLE/KHAsRFNcwcFohj0/VLk/yup3skpz17FyxOaFERePUYIzJDqk4AG1B2WCwXI13TCMiT6EwOi8bbOHG3W0lVmC4nVv7412X1HHhTqQc03hGlYHC3puXP4ucRLaVk5gWlRpZMirSg1bVQ2sx0SYWg48gVxGJOZd95NaaAixlF8gedtm7oMlAXmoGqJ+ZqlwzYagTW6AQxnn5vF7f1irro+qZ1/FU+z9p49pWHmfBNs3ZIfb7iiEVmd5e1Ay5kTdOhquw/uav+nb/9RnBOnl8tyZoJ8TmNHZrB1yl6ZXw2WTq5uM9j8h9kmhIIo01Ehxmrl6jud1h8PC4sTy6tkOvNSZiy5XJO
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(23010399003)(82310400026)(36860700016)(32650700020)(1800799024)(14060799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x01m9wxO5GFm7oOelnVxA2zjeLInkolDykhiO5dOKGPPKFUO/3DUA1pOdwvXC/LUz2qrwA0dSOAZk+/WWbpX1PjV46VDxUMxxwm0StNH38H1q7tAioGsuoD/xqdlqm/xMVw0VxsReVAHac0d2r3iYDQmRf+wNsptWvew6AFBVdO++j0/Xh68zBWpZbf95P6Ugn2KkHmt+eHada5+F8uGRJE6zf9sNG5pEyMyng0MxZH+4CDewhlhHecPEVRvluH+PSBIRZG83NqmDVnxSVsN2JFKMVPDNWXe0GeFQRS6HWieLSDZoTbrXYU35Qk2YE+X8GtntEf7QPzDnDEre1Rh0lgybN8PberZY5p5bwdxJ/pA/Mgcf3mp4M1RljL15Cda4TWWi5n8Mt/F/+jP5BL5wk2rQrWYb9uLvUahpoAOFP+md+KeL+LrTZh0IBxpfVg+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 13:09:51.2713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726e1d33-fd0e-4bd0-6b43-08def872fe8a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6489
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8yOkKMIgEWPiYdEcnpJ3CuCJnA/My57L7wW3QaeJGU=;
 b=SqTL6MYnkmBd3eSVtevVNiA8l5zLZGFCIwq7Eq6fA+PJDvU7nZoNptbEVQhbpKbCXv9KYhjsrLH33JTDvngS77p+nxdHNZY6HF4R+TprDgUKqfp97KyFL85kexpJeA+wG4/zDN7SGUebtQ8yxxrWy+4Sa5FufLmJrJrXrPm9RaM=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8yOkKMIgEWPiYdEcnpJ3CuCJnA/My57L7wW3QaeJGU=;
 b=SqTL6MYnkmBd3eSVtevVNiA8l5zLZGFCIwq7Eq6fA+PJDvU7nZoNptbEVQhbpKbCXv9KYhjsrLH33JTDvngS77p+nxdHNZY6HF4R+TprDgUKqfp97KyFL85kexpJeA+wG4/zDN7SGUebtQ8yxxrWy+4Sa5FufLmJrJrXrPm9RaM=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=SqTL6MYn; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=SqTL6MYn
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 07/08/2026 16:52, Shahriyar Jalayeri wrote:
> dhcp6_parse_ia_options() walks the sub-options encapsulated in a received
> IA_NA / IA_TA option and advances its cursor by the sub-option's declared
> length alone. A sub-option with a length of zero never advances the
> cursor, so the while loop spins forever and the DHCPv6 client hangs. The
> advance also omits the sub-option header, so it is short even for
> well-formed options.
> 
> An attacker on the local link able to answer the client's SOLICIT during
> a netboot can send an ADVERTISE whose IA_NA carries a zero-length
> encapsulated sub-option and hang the client; the IA_ID it has to match is
> observable in the client's SOLICIT.
> 
> Advance the cursor by the sub-option header size plus its length so every
> iteration makes forward progress and the walk matches the option layout.
> 
> Fixes: a0245818f7f8 ("net: dhcp6: Add DHCPv6 (DHCP for IPv6)")
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> ---
>  net/dhcpv6.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/dhcpv6.c b/net/dhcpv6.c
> index 640f089a2e1..1e92d744615 100644
> --- a/net/dhcpv6.c
> +++ b/net/dhcpv6.c
> @@ -285,7 +285,8 @@ static void dhcp6_parse_ia_options(struct dhcp6_option_hdr *ia_ptr, uchar *ia_op
>  			break;
>  		}
>  
> -		ia_option_ptr += ntohs(((struct dhcp6_option_hdr *)ia_option_ptr)->option_len);
> +		ia_option_ptr += sizeof(struct dhcp6_option_hdr) +
> +				 ntohs(((struct dhcp6_option_hdr *)ia_option_ptr)->option_len);
>  	}
>  }

This fixes the lack of forward progress, but the nested-option walk still has
two issues:

First, ia_option_hdr is initialized before the loop and never updated after
ia_option_ptr advances, so every subsequent sub-option is interpreted using
the first sub-option’s ID.

Also, the code does not verify that each sub-option header and its declared
payload fit within the enclosing IA option, which may permit out-of-bounds
reads.

Could you address these issues in v2?

Thanks,
-- 
Jerome

