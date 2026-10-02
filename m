Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31768CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 07:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 737F240BE8;
	Fri,  2 Oct 2026 07:07:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEARV9opHv99; Fri,  2 Oct 2026 07:07:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AFF7440BF0
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790924838;
	b=nY5H6rgQyR+drwy2M7NwQUsmh8sU654y4gPg/yuQTIOPS4dJqUIK9arlhyTuj8M+CjGv
	 kpvPeXctaMoCArHYkx1hrTDUboHU40nwp7BQZNl0nMCEQNWa+S1Q2MyqZygTJPJG4p/gr
	 tTmF4H7DGzPCX+ws0K/f6Y+bepd+r7kfSCw5qbpDjx1PnAZ0g+iIB8Vc0hCoyWdEoO1M7
	 n1pvcZMFZ3f4p3facvc9Ev7DQ8NnU29sw8iNzs3HxQweApPIIhHa4afBIxeMmovKNm/dL
	 JYETL9qRtXwR+aQf4WRxh0OvOqB3DNL3LKXICu1UEjLTK9yyJyXr9Ju/vswoDpclaTw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790924838;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:x-checkrecipientrouted:NoDisclaimer:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=52v6qu2Jyr5066ALsdI16qZfnX2Azuh0GmY7XjlrLgo=;
	b=FU0QMVyfgiPTwn5uf30CX4GD+TpR249LEvb6oHDKZN8dZMsujdskyoodbrWvZYT4O0O6
	 GEgIVbzyMuwLFPgBY5REkLXo5ZQAhHZ9LXedP0sRQov2wrRMNzAhJG0dsa+M2uSoEKcHw
	 a2T5y9NBWE2WajWLpm/fWp6ZrteRxwuGKyxLCQd627dGs0j63HiLnU4+bHRKSaxpWMhNI
	 jTXPcxdO0RwHA0yMxFBALJOWrOip0dtuCdmgBfLs2z51CZqIrgeLOCDV2lIAi8MCGIFJk
	 1haVjyN3tSVsEPVQipB91CC7kKzSqHX7Q6HItmKPYVLoOM5Ub1JvVvqZxatvfJGKlZA==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790924838;
	bh=52v6qu2Jyr5066ALsdI16qZfnX2Azuh0GmY7XjlrLgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZB1ztvpxyRRph18xWT36iKIn9roGhPBYIc3dCzGkvfUYbp5dMQP9gWIdppgy/Cxnk
	 zv6dgIGlb/1SbmJdldZKX3Y3zP8agP3IIbPEI+aFg7UUfp4EED2eunGkw32K0G0hTZ
	 tcqRdcRiHUCJWz0eSs+pXvR0ZPKCHoxqpOk3nIHjQRiyFeUICX25vXvjKiQueSLh68
	 3Untek6VFeq57lMrhXV6kaUTPaE7qiwnBgIKjJApYy1P+mU07HsPh5KdChcLF+cnFm
	 QI8jH/x0Vn9ILv0SQM4KBh7QHt/HvrUtUKwTHjWBTNQ1JkSmxCGgaATzKCWIPN9T29
	 /9+OupJUP6NEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFF7440BF0;
	Fri,  2 Oct 2026 07:07:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7305932A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 649C6607F8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:07:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLjpZ2_W5shC for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:07:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B6267607F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790924835;
 b=XIfWhOKTfaLQ+DmtmpYfBPqdmFIA5Xz9LhkwmfyXpdGHGsY2pFtHtLzpNS90rvy7oOq4
 lV5X/ChMJt5LYh/btt1P848Wizd8uKobASv54NK6YnkwQcIxqWWqRAdsYXEHSPjyUAQdO
 oNu/hdjFO7OiW3m+7qQ3D/dJZRFGJkdbWgR97vlPmpb036PH8X0Niid9S96LOz2NDH0/v
 TuwUWEdyY0nitpszzRJUK5ccsYP6nKcW9FDfBCk6km24frsf48NMwtTQmniiDAL8S2Ws2
 7SE1i0eIF7jVWf4Kavc9PNAwLz/+i9bSZS+K+w3MtV/1w4LNZ1w9UGBHCDKdF1iZYug==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790924835;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=52v6qu2Jyr5066ALsdI16qZfnX2Azuh0GmY7XjlrLgo=;
 b=LS6TLrGnzpviesMF2D3m25J22Pacon7/xuqZQxjJWSm9yu/z1j7PNqZQkACAj8MDGbAI
 yX7VGL70xFbgFvh8Tj2VNtC0b0YqlfWoU8EGYLTRAJkg0X16zK/PTwVOLq7aGcrwiwbal
 k2PqW3cqi8m6L/WRG5050v7bhLKuoKTdjg+1HjdWuUsZqFZYlX6fb9FrGGdhk2d5OZIrZ
 nkksl8Am+nIybJ0/GXRaDsSANKmuFjKyF2fTx5pwmLOhSaFVK9qknG2Md6T2KoR6AEV73
 C2wTrPwmfTTSqf9zOT6i7keuJo6P6ramUXInZXmrWGmwgbHDlf8RBVoB5tHsoJlHoJw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="cgl4/yZp"; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="cgl4/yZp"; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=cgl4/yZp; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=cgl4/yZp
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6267607F2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:07:13 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eOnDUH/XxP3BfGMhmy4gVy4HyZBH6yT/spogq+nXIDVYbBWcl+Wk2mljd6wiQfAtrXVkxO/w8nSkcnDBA2eHJUk4PwBZFDBaHp2ZJzI+0g3bRc+Uf6YT/SVfOVy1/sWD/x4L3jT0GOW0ZKgkGBwut8zm57ELpA3/kRwfBBQjrgK+jrIAmDO+Hws6V8zlsBau+TWi/pyUKbVr/lz98kf8gU+Tf/kS/9XVplC9NC4n33I6DIGU99GtH6PAUmzItptR2DDzTuhnWCwtYX9WzGKgV/83VDkwoSDhoxZm7n9MNcrxOnyBW3k5nv32GavP6KjGQNWjvNmhr/iO6E+59Qoqcw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52v6qu2Jyr5066ALsdI16qZfnX2Azuh0GmY7XjlrLgo=;
 b=Y6Cm7VT8YLBF3MvGc/7DOO6UoSCCCPqx7/MDi1s3fjoL/nvs/l1cEiPwXtcJ/kZifjHVw7XRHhv76lR9gBstEx25sgCm26rTlURSaLjU08AO4ezrcEmahahRqAnggmljrQ/jsZBIeiAKoBsdm+4YOLAYVxmdNnXap3KspW8OE6pUqUSYr9Agl8UqcZS0wM70Vvtd8M5l8W7e4CrsFkjB5yz5Jo1BEffPpt8LKDQcMtujbWVC7ZiAZ9+B5VGuLN55qgmZwEpdKvniBQ+qzQH29ai0o0bvidV6Na29bbdlsCRvQuhrWcwnIUYGVx8D9yogVIlwIkpO0joj2kYtVp26tA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=amd.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52v6qu2Jyr5066ALsdI16qZfnX2Azuh0GmY7XjlrLgo=;
 b=cgl4/yZpcwfn6lf48Z01kH3h7G8GEDqh4J96C0IihSlCB4VUX5dfIN+zy3riXmuOLLZL8bwLsGB26Ey1Z7w+r4MtK4h+gWZ7iB8Qxf9thN/5awD5ZUhEOB0aIIr14A9UD40t5PW668zvejeksVqvMgcZRzWfsqYMsA+Qfs03mG0=
Received: from WA2P291CA0023.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1e::19)
 by AS8PR08MB5927.eurprd08.prod.outlook.com (2603:10a6:20b:292::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.13; Fri, 2 Oct
 2026 07:07:04 +0000
Received: from WA1PEPF000099CC.eurprd04.prod.outlook.com
 (2603:10a6:1d0:1e:cafe::a4) by WA2P291CA0023.outlook.office365.com
 (2603:10a6:1d0:1e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 07:07:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099CC.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Fri, 2 Oct 2026 07:07:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=my9YdOClbEv978QOlI31CBweAum2DI5XtgLc0RS4o9SUR+9tDYIU5q0MSIWKFeVsrX/KN2N0YwLedTuHLs8AFIHQF2Y3up25ZkxgxCb00ZaD3lpMG2PmJiIa594WLdq1feVaJxGaXZtxlJ0bEW5GWAf9DahRjCG1w28UwEXZFgK/V4fqKXJiw3KMEZMahjec0JRtLBMWSRM31p1EqaAFVyJS7SEHIAcann4P2vK2b9+NxzwBZuMKkHCFg+H/Tr0EZ7z3uWOhJgrVGMPSdXE5jyKkkMeNY+bCX0lo0JcOPZ6NAesrQAn6iP4W0+Jaq31G2oirEbVnv+sKnEABBWSyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52v6qu2Jyr5066ALsdI16qZfnX2Azuh0GmY7XjlrLgo=;
 b=pWtmld9i4A91sOtNTAk/v+y2YgFIpgXH5zTe9RApQPV9sZLD4RvGiMxGGbYfq6qr1OTp/ktwKRaPwRztK03eKlm54vWD2RRKXRTbu0njlq/M2vdg8+/iXAlq3famqZ2pGy3PxBwgZimt9hLQbHOMU1GtnIQktb5XaHbUByqIpqaUre35XAMESkI5iYkY4rYj7VF/IPLrm+sGjFSAPS6ZblYUnTmY4Y1qhSH/hJZR0Ft1HLQdjCNcnie7huJT6hqlraogOlvUX8za/bx0GfONm1u+WqH5rMAIPF3QCZxPYXd6RN/7xYGbCXUBFm5mx6rFzpeTljK+Lpu/FCqZAHzrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52v6qu2Jyr5066ALsdI16qZfnX2Azuh0GmY7XjlrLgo=;
 b=cgl4/yZpcwfn6lf48Z01kH3h7G8GEDqh4J96C0IihSlCB4VUX5dfIN+zy3riXmuOLLZL8bwLsGB26Ey1Z7w+r4MtK4h+gWZ7iB8Qxf9thN/5awD5ZUhEOB0aIIr14A9UD40t5PW668zvejeksVqvMgcZRzWfsqYMsA+Qfs03mG0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB7881.eurprd08.prod.outlook.com
 (2603:10a6:10:3b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 07:06:23 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 2 Oct 2026
 07:06:23 +0000
Message-ID: <d4f5d1c5-c3dd-43fb-9f7c-a15e4ab8044b@arm.com>
Date: Fri, 2 Oct 2026 09:06:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: pxe_utils: Fix NULL strchr when parsing append
 initrd=
To: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 u-boot@lists.u-boot-project.org, michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>,
 Francois Berder <fberder@outlook.fr>, Rob Herring <rob.herring@calxeda.com>,
 nd <nd@arm.com>
References: <20261001034142.3487023-1-suraj.hanumantkakade@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20261001034142.3487023-1-suraj.hanumantkakade@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0516.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB7881:EE_|WA1PEPF000099CC:EE_|AS8PR08MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 428655c8-b374-46cb-b3ea-08df2053c28b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: sGBIe0WehJmiG8yApowEYwa0YN0inpDQ6UqKxWrtneAZ46BcbLl8tM6GfB1l8zMsnE0vOwV5u2CKWzZ8OsuCU20njeKfVOXNZFRUzDn+pR9dwIZUXZlappYy642M30ie1diJ0nrskxZ1wxp8bCdQWcP01gKPoZcz/TJ1+o+TZOk0bAkQTLO9AqRrTPGLApajcPu4hNg28fvShDRQe9jKiTHLx9rsfykkXLWkZUD3SqVykGmARu5tKZPw5UCW8uUNb1qTgtZiAkGi27kB08N6W7Oc9LdhSpIdZbiXqReeBrxX+pwE9PEC3bl5Z92CFc9j6/RFCOEEqPOQGyHQi+fQCnNMCVrq/URVp21iviue/5FDUH0GVoR9mVWBkED2R3nWdTwpDgH+Fxg68gPSvedEJbYGVEFbjtRzfhI4a/gjBX8M71bnVlKFxxN531hzyyjUr+h9lm2H0cijXf7jkGGqT18FLoFWMuuTtfNLA6cykMseWGHi5j/vYMegDI/Fzp2iSe2MUT5ZlnwokJ/duefLOVaiQpM2oLjcBn5TSwcDQ79W2ZuE6XqTglAtHWzcrPTYEgZb7akJQJxc5vCwCJXTXg4JJu3iGziIQuudCmVbvnvzWtN3E1tzbOXtkyYh90tt7dlKnbuV0vPkNeI12OhYcq8R8THXk1ith38bnUlGCxA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 15o9zj18912wj07Jx70YbS1U912iGGRY4Hn0LSVF1yb7fHSTrXb6wsnCL7AJrFOknfQdJuWyb8boFec1s0G+LUZKoPZqW4DoiaDprpJeGfKIanlBYkDjpD1PKpYnIMBOREpxclqWNbJZ0yZ7RmJdvoSD4FdZRE1vau+lmDhhioFWXr35ZU7zcnqWrsmVjBZv6mb9P9VvFCv4nTujGJwHSSE6+Cv2YKja1UyDbVl2eclIlgFaKN9lNBG7DNjIyMmNcY6WPfpGNcVPHso4ZMnl49BIxl8s5ErBPbyAHPgRVkg83bLYGlUqc93LX7BEZfCH7Ci0KQ/xeK8L3QYON/qZIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7881
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099CC.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 19ab80a3-9f3b-42ca-7854-08df2053aabd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|32650700020|14060799003|36860700016|82310400026|35042699022|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9VlP2PbW32jCx95WC8tOSZi7yk7a5Cw1FH0WvmwIrrlsTIhCoc+5xjqHJJLrV1ITIIQ39eDcnm7LFZBG963oCZcvJvf2UlXzBC5j9O3jBoo5RLh/6WX2xzngN5ZSohr0/mG0eZnynSsF1SuM4roUtLjiVfDWAFlTioyS1LoHRtIkI2Z8loG7jJ/PtY9HS9kv0jgqG3fygIu9Cn3sjW5yGKVOnE+N8wLC1Ybf3Ar2fbMhewjONphU8ku1waQMp1P0X3ec/zo96UIb7kCHlstCcrsjDR5gsFvcThaKSxrGBE0NLgQv6YLp7bYasZkCyINEsgmYJwE+bmZxSHaNUHRgUs1LSKBJIjG8jnD96YvZq39o3CItg4zgkjlAnDwLdN5mtqmiYK0oz4sq3YEFXH9aMtcsP+Jl+9GZJ6frmN1E1Zcjpfs1dHPrtaX1wmdbxBfC0mkRKZZOmDNVnn4REY0nXQI5XfuCiKBCrXsTBkc8wozlQJwuoNMYtsiXTOz6FWcxoIdvRgOBtZ9tzRNK6vOBS6rmE0mcVYGynsHRJoXjZ4CH8qpN/7jsGowAYwt1K9zjN74FxwtrkO1M8nsjIDU80HKnqS6EORu4W9c0FOllhS5mz3eNKWM4FZQ+EfE5Zcoz/Ien9yssNXs/EtwCd23Cz5dqJ/zsx7SwL5L754rMMeaDkTKDvoeleQXm+WnutjL7N07I7xNXsJvaAunUAq58uw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(32650700020)(14060799003)(36860700016)(82310400026)(35042699022)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qSu25RJBVtmdh9sKcpA1aGelm9qLr0N7BlPbae0Yz/6Cy/XPT0VT+phlURzQjKZC803/2PqRMgbv0vU0CcDKhWpDqTpHtIvA9U7RTYyuptK7ctmMAT/ZrgL6IFc1cv37ezpiLglU2YQnhNvU4QhXgygemyV1PCfurhjRxsi/VYG9s/ECdXsz0JyM4cRwcnxDKiJjJ6A4Et62DreHxZhIW08uYPV/q2Dn1sfvoFhgwRLA01lKUyMCPQW6ZhSV7ZMV/3ZT5QFont+E2g3FYt+LIWVus9h8uOEvlXdBrWOvPQVc53R5PlcCVG5flqMnZJQ/5xa6HmRye9YRl7mwvgB6O9Uy8VywzTp/ApdVT7oDr2/iw+GVF3nVXjPpNKRQ4EN09hTlfJpGOYoK0on6gdEZJ+g+IA4+gForAb1UlPD2JW8IWCUDou0J5K7nF9NfsA2K
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 07:07:02.6172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 428655c8-b374-46cb-b3ea-08df2053c28b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099CC.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5927
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

On 01/10/2026 05:41, Suraj Kakade wrote:
> parse_label() takes an initrd= filename embedded in an append line
> and computes its length as strchr(s, ' ') - s. When initrd= is the
> last token, the append line ends at newline, so there is no blank
> after the filename. strchr() returns NULL, the pointer subtraction
> is not a length, and malloc() and strncpy() use an invalid size.
> 
> If strchr() finds no space, use strlen(s) as the length.
> 
> Fixes: 34bd23e42f3b ("pxe: parse initrd file from append string")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> ---
>  boot/pxe_utils.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 8c1310dabeb..d4c57ff11f9 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -1285,6 +1285,7 @@ static int parse_label_kernel(char **c, struct pxe_label *label)
>  static int parse_label(char **c, struct pxe_menu *cfg)
>  {
>  	struct token t;
> +	char *end;
>  	int len;
>  	char *s = *c;
>  	struct pxe_label *label;
> @@ -1326,7 +1327,8 @@ static int parse_label(char **c, struct pxe_menu *cfg)
>  			if (!s)
>  				break;
>  			s += 7;
> -			len = (int)(strchr(s, ' ') - s);
> +			end = strchr(s, ' ');

How about len = strcspn(s, " \t"); instead? This would naturally
handle both ’ ’ and ‘\t’, like the parser does when tokenizing the input,
and avoid the need for explicit pointer arithmetic.

> +			len = end ? (int)(end - s) : (int)strlen(s);
>  			label->initrd = malloc(len + 1);
>  			strncpy(label->initrd, s, len);
>  			label->initrd[len] = '\0';

Thanks,
-- 
Jerome
