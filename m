Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9230ECCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58FBC80FA0;
	Mon, 19 Oct 2026 10:40:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zjLLAd11kC5k; Mon, 19 Oct 2026 10:40:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4583B80EF1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792406413;
	b=iaunwD2gjq0JcZoniONUpcAnHz1dqK/s/qAMOjWk9pF44dAznWu3rzX4sigN+iuB7RKk
	 9WbE/rBAnc+IzhheB+K2k2RALp6kiZth0FiueJvXaX4bZhzxA9tyMcKq2m+jAvjqnbibN
	 /qAKdfHc3DgTnKq+YXaLfnPoSkJdo3hdrJkv0xIXCU1tEi10CJtsOc/QSW9jpm4B3WbJo
	 j9GMP7e3cOnJClmeRCRClhhJOnCFe9yGoYJHcX28Ut5TUlIpXXsWLH5XU5YJYiVroK1EA
	 F4FwjTmOg4+f+3czcLmjnvwn9MURJyMQ2DHD77l9Pjut6nE8ZrQ5oiOcO+jo5FO482w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792406413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SnGzfvLGwp1ScwrVGkWaKtMNn1GjcZNd6pP9Tl5N0YI=;
	b=EIbAi9R3FhY59UA3j/jW0EBakProwQrtmTh/7uWK3NxcncmFdAE20k5nwATJf2qafFRP
	 3B3SGlsi4tF5gU2hBD57ppjJBAlw/0y8xqTMfm/1+yfDw58NJIZCsE3rhoDlFVRKd6Ay9
	 0vWNRI2ixihzJVsUKAUwQeJWeJ0Fw2MSV/jz1k0O3nIOZGmvFizySFYEXzL8YJ5VUDXXG
	 odRnLRVCPId9KWIceCSOjETZui8dZ6jp5uxO54nJLy2TnRBciML2pnhO9+x9Joa2on/oK
	 0SVQi0H9326wfsZSP9Q2ehEGm8awO+WsSQLlmJNc7escw2KC0i98CCT3bABaGXdkkQw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=lg+BRONY;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=GGWaibbu;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792406413;
	bh=SnGzfvLGwp1ScwrVGkWaKtMNn1GjcZNd6pP9Tl5N0YI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=niG6C+pNmATi5BXSghyxKvSIARU/YOvcXXCDSdFz0uTVGq2Ww0w/rD5s/Z+o/hlgr
	 y0mj0tTj7yQxLslRDEHIeaexcoGHWWsDs/FLmAZD50mVf2YvtjxvIjMmct8EjduX5I
	 Y+qj2573uzLMpARCKtsQv+iJwDfAoiOOj/fcWp7pXdC/ICO4gkdOrkkc5kn3TJo8sQ
	 VYkcJw5oGgicdXpCbzLtDRXyiDlH3LT+8ivS2202kAubsV1HU39n3t/MDDLjHx1AqM
	 A9fNIyRSNWpwTtBaK7psCbUpm3qxuwvKmKd21qapxSPRysvoEBG1LDFl2dOLu/OLTt
	 Z3/n69WZxOnBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4583B80EF1;
	Mon, 19 Oct 2026 10:40:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 453B21DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B41380F80
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DFnrWI7xRnR4 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 16E3780F84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792406409;
 b=iKJZNOAjuo1P8p8xHDfDV3cWgf8sDv/TFeGW+f4l9bCqwu0jOXVJXcdn6kSjOMVaQVEI
 U8Z9VBtYs95ElDWE5ozGU9LaGrd07co/O6QjP7NNeMoXfUw7uZ8sVRujCEFiGZvj8IB0V
 iGO9TPXGsuP3DrzH1AzO7nz8DoQ9di2r/OxI3zN6eVgs953sFzFfJQRjlIR5fgCY0PFzV
 6HIY07p1yyeGki/NSXZku+qztGM2V0s/5GWm+ilJAJGnmP0lylisMykgx20F+yQbeUVgf
 9Vw9KiBYtAKs6rc9tX9005XxaIkAB1z88PwuLbD6lbisXkKF/Uh9qJMVhnalUMmDvFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406409;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=SnGzfvLGwp1ScwrVGkWaKtMNn1GjcZNd6pP9Tl5N0YI=;
 b=QmTExnON6WrROLyvD6yri7jv7HRmp57yUvUNRSuUgK+sEm61O52KkTn9kL+kyDOA6Ut0
 i1qyjcecr0XoHeIWqipx6Scho3yrPeV2a9BAN+9wq1H9EflrK3zMI9SfL2Uh0VMGpKJeg
 SvrDQ+OVKBaWEI13XhgkAknsQzKfVwLeJmjaovl6fdKGy8J6zn1pTy26U33ycHzlaMLqZ
 ftxeDXYdhfu0eTS5IL11EZbjL6VcejaX3+lEdW40RMMBrMqacfFPJ5VfgYLTRvUoMtcX8
 5LJgGmSOkN/w4ashVqNahEE7bLwhmNfqWRZL/5FOQpmxLr8gzbx2MxU84XazNdGGkzQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lg+BRONY; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=GGWaibbu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lg+BRONY; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=GGWaibbu
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16E3780F84
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:08 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Ns6g3456515; Mon, 19 Oct 2026 05:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=SnGzfvLGwp1ScwrVGkWaKtMNn1GjcZNd6pP9Tl5N0
 YI=; b=lg+BRONYVbj/qyKTAMSfn/oHtKyifDwlKDEUDA/TgSMqNZ2hy9kaOEg28
 YJRhoFBRjGqRxnZPhJi4RksPj1MA6j1JZs9Jlw37KTC4GSwO4dAr6UZJpjBSk7tD
 Xuw7+pyQnygyHSpQV4VKI5PojQUd2DDz4zJq6+g3bSnycrkQv5X8bYGADPByIZ3V
 4SCEkHqHqLab0t9zE20zO6hfR2IBsArcM2va7qrnIQY13foTi+TEPDYqNRTSm0h8
 b15PKu/Tm5mUO1hwK63kD0AvB3bSK/apI1/HHakoOKJhsl7P6UxwmNpZ6bfnDHdO
 g0emFm3nPeqOa1WmOUaiQL3z+OFOQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcr5p5a1b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:40:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TS1mQBzytXcNOD3F3lFBueQgnjjG5G19Ii3pG9VnS+CQmg6W71mCticRHV7ol/l9+g30xzVRkuS1On/KnBFL8RhJYExLukUXxBbZuyR+Jog9fYFNqYv1pOkGeSFufpExEdbTQ3M2FLHb8SSZLnDMcKmRUfRQRpDj19+FDwUOoHd94F4MWaMzblgK1pJ0XaPBwc/3BOy0KoGmTz9bcIPyN34zG4oOtpQz0DtrOn6Z2msSJ4Ttkhg6rYkuw+9o4+8L5qILytulDoCjZtuoFu8KNgyPLuazmoIA9XwWV8esHs86gQBRrANpRY1oDt4raYdZlVovLNkOUIzQ98fkr6TTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnGzfvLGwp1ScwrVGkWaKtMNn1GjcZNd6pP9Tl5N0YI=;
 b=rO/IM+W+U5Mu/wu8SABi9F1fJcQyaf0Mo3tav7pOwDdkKslf8TGgg77ZXnzaOyE1a1Pn1u276z88WFs0W4P/3yDdjIwvIqkXWpPb+M4stnWgEwbS3okE1lz6yva8paNzJbX5kp64FLfdLa37F6HP8i+D3n205ZHJbfWjCamtrb5CHP/Mpz91TQmWQJ10I//3i3xv5glSIklWovYSTYomxYeVto8eQg4gY5kTXTES6UdI0QJ41QtSezdOqK9C6ppx9r0TxJsn3Ck7+ldWyY7jr2+31SRtXV8uZH5xxK81/rxzxN7/7Q90arOkP5caEz8torynhqaghoHr8b4dbjVZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnGzfvLGwp1ScwrVGkWaKtMNn1GjcZNd6pP9Tl5N0YI=;
 b=GGWaibbuQZ+SR+i0gVH6zinNJHJLmth0Fp3QB4cbAQRDvUGGVNY0l+pjb3i9wp54xOXFBkSWFho+czvwYmp+cj0InyizIIe4Sb1fzBA3lP/20A+DYyCrir8MgsywSYI1ZiZeGcLr3Ivs5wQ430pPAukkpkJmgKC7QvuyAWuBC0o=
Received: from BN1PR14CA0013.namprd14.prod.outlook.com (2603:10b6:408:e3::18)
 by IA3PR10MB8346.namprd10.prod.outlook.com (2603:10b6:208:578::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 19 Oct
 2026 10:39:52 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::89) by BN1PR14CA0013.outlook.office365.com
 (2603:10b6:408:e3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 10:39:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Mon, 19 Oct 2026 10:39:52 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:39:50 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:39:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 05:39:50 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 69JAdgTh2629975; Mon, 19 Oct 2026 05:39:47 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v8 1/7] arm: mach-k3: Add config options for packaging HSM
 firmware
Date: Mon, 19 Oct 2026 16:09:36 +0530
Message-ID: <20261019103942.2497201-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019103942.2497201-1-b-padhi@ti.com>
References: <20261019103942.2497201-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|IA3PR10MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1cffa1-c58f-44d3-8ef2-08df2dcd4eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|18002099003|56012099006|10067099003|22082099003|13003099007|261009223027099003;
X-Microsoft-Antispam-Message-Info: Tn/JiUSKftqUSCisLw3iuWy3D9bZqMjb3TMgKAC+RWgCpGfq7K+8b91nKQ/6qGidcJyJegp6cF7H8d/7b7u+hy8ddlFsDU4my2XenSsr3tNKZYVLHaLsNbCw4GGubb0dYHOB3q6LY2VxXo+O9zP1veoeLipcASp9pFfjHYfPUG2mnhskO90n0a/022MGAdJnOIVWY1o29npI1xxZ1AG8SGWXo6QF6nkpatznvurAsvPUm7WKiIQO9UbZu9ac4EEojM8j0jaU4hw4LbkDglhN2aoou8akah88jHPPHXV7fv3Yvxckifu3okVYJTWTVpr4PF3qvJQV+ui2wXa83Rhq7CzBNdxic06hQsOoeVUXCbF0dR27nZed+pXsyH/C13iRSGfvn+2U4yRqrsKEyRa/3r1Q//wLF+Pq/lOi5WXLI9LTxJDBE/3EqyldgmdCbTG78huFtzkIK+t3eYWX73U4bGYVEfBdxWve0SxE7eYLoU/1Jx2wBrpJLYCXE+lUp5+GBrEI2xPOYmOuQaIyYIZGljndUA9nL1iWbxwkEVahUKfZVUX94a0efG+YIxEHM51mBwT/j93eMRntNtB+ItZZmTkk91Psu+vRkm3+S8fRDcAMxwmSHmoFJWZCJP8RcrSO8FZtTOuKHjqG7mucIj7gIdNPGsOKWmY8e19UE+ToKak=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(18002099003)(56012099006)(10067099003)(22082099003)(13003099007)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qQKQRbaf1ACuVuR+RExp0YuM9aUD+3u5D1bwD2UVwh48zndJf8C0UtqV5413CPgoC/uBW6kuGngeg3nIfDzA8949ZbdJs9Mql/kPNGfFrGB8CrYqu8nm6SAf5oPAD7t0NuI/qQ37ZU5PK75tZlyrCnIa5Gycd/2PNGRBfJy1iAOYzgiHuxnZhA8rQUo5lWnWj1xOWvE3cjFX3e+3NnWqPNxc9eefTpBB9nOLLhaszgyuHa6d3vykyvSbTGrjZGgwijAr+NcyyhNrEtBjczu1hJxql2imqgcIJu+3VJNXGBI2WQocs0WgPmpb/oeuJrDj8Jrx9t7m/K9bVD/C/wlZBDnoTvVFyAnW+CwF7DZmeID4pTLHJGLVdw5EnBBVAqo3YGms8MGUpG7qfm2TreYYxz4sCkd/7o7RQUM4MdPdc5owz9HhDVavHgc5Z1bZg/l8
X-Exchange-RoutingPolicyChecked: haPZnKusC7SakIhH2BvlXq+vDmm/U7lXgTBp8X1OoL272GC/Sq+1k/U/HyrSi/iaaToS+4oQ3rtEwQMfue9ObD4KSXsgrbvqgsBKSibHw6KY3LQiKQFjp+qt5SNEoP431ZqFLWAX52U/s8tT7gUi9J2J9XYl/nzLbc7Rus862RaSaA9jO5rkMW9MfxmtldUBzRdEjnRxLRcKHnSV9sFkzYtWbBpZ2yOP8DS7nkuQehhRvj+HPXfhbgd+Bfb/B8A4Adp8Jx/XTGwRhh4tJFKw06Xnwe5mHR78sNiKvoqRHqRaBM4XV51zQ3G/1Ww0r3Hwa86TKkIU2G5sHHlpbiVOyQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:39:52.0593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1cffa1-c58f-44d3-8ef2-08df2dcd4eb1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8346
X-Proofpoint-ORIG-GUID: 7s7EC4UMrEEQp6Mj0bN62tAVJ7aSLGUP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX5we2+odrQ7Rn
 C+ptxE5Df9pAb+5Wd6KK+iEm+eXkNeOQb9w571MrtsIwFUHRukVjE4QuWr8M9+upTtOsrheRygM
 LpaCGyUPJQZ2KekAK848Z8pftTv+Stc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX0E2AxojHTrKO
 Pwzfw6M++PiaPitU3IYe1MJPEH/gKJMR57JnjlDzSlCl5yLh/sxOB0/ZgSnuyPr/bo/Q6MJCaA0
 dJUfL+1BL8sySq3r7yre+L1JuCDeRYbLNn1QqJmUKX/9VD6gq0U9pOqpxN6y1E09p9hEeShZvzQ
 yYnstH35UA9+kEm2IMg6+nqxI0Qs2x/56RY1EFDAokjNxmkNWROCZDaYNJo3L5uH9mlEAZ3PJTh
 7n7eMszHI0+VNJK6IUMhExNtVd6h28iquonNjhOx1sZcTh9AY2AMOfq7JL4QHRNZogI2eHdssu7
 Mm1+d3LslrIjpqSt9iekNYv8+Q4GtJpj0NUiFClbB/B40taHdsZST+SEG5LmM3U2tW1HLuVN5G1
 O7QE+FpXsHalOo2xPj0ZAHtKuJ77ZzZH5LfasS2mZb3JsUFYYZ8/q+sh9P+L3Yx8O5FXGgdmEnK
 e3PvEzzpcCcR04K3QEw==
X-Authority-Analysis: v=2.4 cv=Fp2QbGrq c=1 sm=1 tr=0 ts=6ad5f386 cx=c_pps
 a=xqIz4pcv3YTcvFGvps39jg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=voM4FWlXAAAA:8
 a=cm27Pg_UAAAA:8 a=Vh17HNacWqn-ezHjO_YA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: 7s7EC4UMrEEQp6Mj0bN62tAVJ7aSLGUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190042
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

Some K3 SoCs like J721S2, and J784S4 have a HSM (High Security Module)
M4F core in the Wakeup Voltage Domain which could be used to run secure
services like Authentication. Add a config option which indicates that
the SoC has a HSM core and the firmware for the core is available.

Add another config option (K3_HSM_LOAD_ADDR) to specify the load address
for the HSM firmware image. This address is used to build the FIT image
header that places the HSM image in memory during boot.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v8: Changelog:
1. None to this patch.

Link to v7:
https://lore.kernel.org/all/20260922084536.2477291-2-b-padhi@ti.com/

v7: Changelog:
1. Carried R/B from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-2-b-padhi@ti.com/

v6: Changelog:
1. None

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-3-b-padhi@ti.com/

v5: Changelog:
1. Add new config option to specify the load address of HSM firmware in
memory.
2. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-5-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-5-b-padhi@ti.com/

v3: Changelog:
1. Updated description of config to match with functionality.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-2-b-padhi@ti.com/

v2: Changelog:
1. Removed 'default = n' line from CONFIG.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-2-b-padhi@ti.com/

 arch/arm/mach-k3/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683..f7b42a4912b 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -198,6 +198,22 @@ config K3_REMOTEPROC_PRU
 	imply REMOTEPROC_TI_PRU
 	default y if (SOC_K3_AM642 || SOC_K3_AM654)
 
+config K3_HSM_FW
+	bool "Package firmware for HSM core"
+	depends on (SOC_K3_J721S2 || SOC_K3_J784S4 || SOC_K3_J722S)
+	help
+	  Enabling this will indicate that the system has a HSM (High Security
+	  Module) M4 Core and the firmware for the core is available. When
+	  enabled, the firmware for HSM core will be packaged inside tispl.bin.
+
+config K3_HSM_LOAD_ADDR
+	hex "Load address of HSM image"
+	depends on K3_HSM_FW
+	default 0x82000000
+	help
+	  The load address for the HSM image. This value is used to build the
+	  FIT image header that places HSM image in memory.
+
 if CPU_V7R
 source "arch/arm/mach-k3/r5/Kconfig"
 endif
-- 
2.34.1

