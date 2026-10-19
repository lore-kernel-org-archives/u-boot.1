Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DBECCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0C6960740;
	Mon, 19 Oct 2026 10:40:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id utpmfntXyt2u; Mon, 19 Oct 2026 10:40:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4CCD606F4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792406423;
	b=eiTz6OPHq77kUq6uTJSqUjNGf81Zd4zpkLx2b79/OmDFNHeSc7oE/q3C/ExgnuvKqdIw
	 NCFpJotFVYvMZKQKO1g0WQCr3HGMK1RH4HCeJK60aY3jbrm6LPNc5SA4vdRvvXe8LW6XX
	 8Ea7IQnVP7wZON9FUjzVxY3K1nx8amfWaxLbMzpy7p8HHFLdUo57c+PqLrF8vxX80TJ+g
	 pjgb4vSWXXAHAbt/VxLXlq+EHYaPihK6yvZ7RnROHz37Ksf3LqO8MnssZgxPdcDxpcXNR
	 /W1k6MnWJ+7t4yyHCPL6Kz/nxFIvwEq//f1zBoWrUNwJrAQDto+5TGX5FyUHTSS0zuA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792406423;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fj0o4xPh8iKTmdjfx3uTook1r73bTrvN3aXtRStuZjE=;
	b=mpJ64aym2BxJJZ9yQ6JLzRLYVAYg9ghvx80NodbyPcxpb1en4FH8pywAibtW/e1UspmT
	 TehiuuvNJU3diYRSGeMUYExHSHbHUxMcQFo2T3uDpa6Tx4qbYccNsF4OqCJC1SgUZ/E+Y
	 J3RmX5hApCG+6EnfqSSfFqI4jCm+Er11s7AVo8u6rexW+Vv959ITrHThKNfWMLt/K6IZq
	 nkslYmLU53mUGMlJ/lU2lTBKvaGgEtk2E32pJPE5QWBCj4SDrUE2vYFRQqQPyB2DGZD32
	 0pLeJgc5Emt+TeIZ6/JjSrv1dCMP53M7mdOeGqZSpO5snGvc1nsTqw+jk5hoRhgJ6Mg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792406423;
	bh=fj0o4xPh8iKTmdjfx3uTook1r73bTrvN3aXtRStuZjE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mpQZCzikkUNGhhwtVinZktJBhWEqneQJf+Y8KAXrtNLh/qZOsjqAP9VgK2kWElyic
	 ZKjMb8BcseEhE7qT22wfhiH0MV28XKPUZvI2+COwXHiWMRG3ytEOuFOKzNbpQRzIg5
	 uPsLrts2Kt724txWsDjtfBcC1HVchU2jYErn+DWg+L/nsojOPkoissB5nk1c8UIg2Y
	 bqiiuDykBGxf0sUVDzsSoXLFBAc6tTM1sOGj0rjYkoKm9va0EUtu4fHN7alAaZZNB4
	 OPntedlo2EnMrMNnaNfXwsfkbuAxCTbBwcKRDMjvIEp497VwKBxqFhEtglHSJneJS9
	 EibtldmJ2zfUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4CCD606F4;
	Mon, 19 Oct 2026 10:40:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08FC4279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E336C40080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6pP6bQCjp6I for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:40:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A5B4B40079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792406420;
 b=Fhm1vD2PfSqMWs93c3pHo/J4t1j1Kwa7qqj+hXjnBQvNuo7Kmkei+IrksvgXyhYfG2xo
 nHKeSazvQI0pCasXXXXYw+XYbhO0mZwNvLsZQOuS/N8X7Fk+GprofkSllLerIh1iscZw8
 afK4EE/lnZW2MIchiaWswhNN1KzwJjkeWdn5rGk7ElrBQxOKjfxLveb2X6fFS9doUoosc
 cNYX0hRuNzRVJs3y56qfYFFPRjlsCFcuNBwxzrYsJd7NtmXD0VrFupD7qFyJJSGY2JX15
 iZfTZTSmDmR8QEOnjSJIg96ggCpoZNJy2c91/NuePNX+Tlm+LKQqlrH9l/30ma2EOgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406420;
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
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=fj0o4xPh8iKTmdjfx3uTook1r73bTrvN3aXtRStuZjE=;
 b=Q+PgweY3dLocuR7od5OB7rh5nb3sNdAdHUJ3ksGjpr1X4hu8pp6Y6hQdsT8/ixs9CH6U
 Q9U0iI2b5cc6np/40PsP2juZuIE4BukaU6sWBfaLfNS8MdUJIq8lvny4Q7FkFgaL380qq
 sfX/aIgxVSTY7mQlX1K1SpVctreowIdSqu8Gd4SfVGyLudGUILFB85DJf3DeNKdsFo5ZE
 DqYuyVNncIIeL0k9keAtdAM6gfMENs9I2Auu0K8XItpyduGNEcdA5kwvco0+nwDqj9McK
 aywZ2roJxOP5tGehtTvHG2Iv01zhQe9uWPuY4gMBjf8qtshNmvJn+YGGRGmmoN229DA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=qQvFf0cg; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=mBZFO5CN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=qQvFf0cg; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=mBZFO5CN
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5B4B40079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:19 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69J8NKRA2742489;
 Mon, 19 Oct 2026 05:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=fj0o4xPh8iKTmdjfx3uTook1r73bTrvN3aXtRStuZ
 jE=; b=qQvFf0cg0MhThhly2pOm2ZKzv3BNyy8S2CxbIHkQJ4tYsUqgufDOsxzCU
 bnjt2lFLNVi1i3HNzX0X3Xqgyrb92o3SKlL2Fr1+hok46TB3t3J4bPHE+Dzo9ec8
 gDmoFx+coOqud/6Eblzq4Pf1dXGPECUb9kwOlMAC5WEpZ+jkJPVUpyChKayFONXt
 xGjzXB8IW7fM+8FEJtlG+ER/RtIksGP2yECEUP+Bwi4Z2BtzPyEi7JtTvuSZwQUu
 Mfw2ijWg2xmv8j6ZyO7a00Z2Ljxvv58PZSJElt9CGIoH1qndyMQEKBnK2ynVT4p3
 A5++u8u+xlbNFGJdftDoQ+11/HyqQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hctyncxc0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:40:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNHwqYzfrIaFsqFAGdgL905EnrGtwjXaLmb8aqUSBXkgyE4rpDtH+470q13gM213Q1+RWJZF20273i5wY4PO3t3gtFcmTXA4LQ3+yynrco5pwTYLNAqeE1/1zFxFVsb3pqf1tCxqaMBHq+bXHtXW2OfNhfvq1rZZ6P9jax/4QLYWTYFHm4O4TxTMxNgM2hhc6Q+N5BnfPXKekA8AZgfkR8Wuz48UCiZ2GoOEP1wvSzSyWvxrCI7cIQGM4BoO+DNvW5c9h2m8Ub5EGrMTkXws7SR2EZNONXSAQzd/EIkbWziqGU3vGuil5hf6gbOQ4t8fs2x4TglSmBgtCwu8CEhE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fj0o4xPh8iKTmdjfx3uTook1r73bTrvN3aXtRStuZjE=;
 b=pHQudzxZ5KL7SkzlGrONVFNChV3NYmOsipKjuNj4OtL6JhBtXZlb4pdz+q89gl7rrCdZ3GaFQsrpVs+08/AFAYQKEV7wKE2rHOeg/rrSMGJ9FZJQHm8+XtyygX40AfCGN2xMFG61iFUpk1fa8lSblYzUdx/ZvtfJ90CXuioqj1CrV5IsAU6tM3ovkXqAixrjRHFzZi9gxZ8iuwJNtT42Mbr6iVmFfk+aner8IzHJ9sUeF1BwtCAKUo9ScV8AY1exiLMcgDJd58vFaUe5qSmX04fKgNWtftHdDc921NT77/Ja3s5SBRkacRtXy85x6sUUOpejmK1qdJhfpbE45kZ85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fj0o4xPh8iKTmdjfx3uTook1r73bTrvN3aXtRStuZjE=;
 b=mBZFO5CNa/Rt9ONl8E9irTpRwwz3y1HBoAWwK3EDy7CUDvjL62UcAkNddOV1K7W3KDft/MDtb93F2SiIHBGfwevtqZiUg4o+d817qnI95CtzAmeDVs28XhVD8LLngPkdXrrPyFgvPmPOsdqd6+GkncSROBpom5vwrBpxoeevPvY=
Received: from PH0PR07CA0041.namprd07.prod.outlook.com (2603:10b6:510:e::16)
 by MW5PR10MB5874.namprd10.prod.outlook.com (2603:10b6:303:19c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 10:40:09 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::6c) by PH0PR07CA0041.outlook.office365.com
 (2603:10b6:510:e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 10:40:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 10:40:08 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:40:02 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:40:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 05:40:01 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 69JAdgTk2629975; Mon, 19 Oct 2026 05:39:58 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v8 4/7] arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable HSM
 core
Date: Mon, 19 Oct 2026 16:09:39 +0530
Message-ID: <20261019103942.2497201-5-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019103942.2497201-1-b-padhi@ti.com>
References: <20261019103942.2497201-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|MW5PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb16e88-ba6c-495b-a572-08df2dcd58c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: qvalMAMDk5NZl2ZzlI5iRVgfx5bnt7QcPpBN5J5Qs5hKjhAqwrwYx04PE4dy1To2mEcGibbmYOVaOV5Q4Yar/ddiPJ/jZcXLAdA7Jq0v7I7qMMkO4BW5KFCYvVvVILvtuUp1QphYVFAGpAdgj/BMfqU80bxcc5+IuJzZtIkYbqf9sk86lqko9YZsHfx7xN95rDkNC4t+SZdK1OT411sLag9GZ730qvC/OQwcTr6iUkc+30TkPkcPOa2Te+3AoabsZfHBgQITtXCLd38GhxbPPCGmi0eZldX2BxzQRfMm9S09AWYokqY4uYgF+NUEBRuobRnVmrDIeNkAdqoFssqERHcbKcoNdTPfVBlYEtrFpVICDY088WZka7D3lUPHtHJeOvug68rPxggFOmKOz0LP7Uiw8uO60+3AxY/xZ2Ec9ORj9+bOSEKY0qis+20oLF8mP0Oj0+DTQAOAnAnf5Wm0cgx2kkqskbCB82KcU0PXckP2AnqwQWGIX2YJI2DQtZcgirc+7sgnwyLn/uDpYHiRQJJYv7j0M1J2Qx/gCxPl4oaJk5lXrqcSJMPXM+FYeg8Xk69AVIhJROeSa5g9/lVKrh3EaomH+vh0EAT/vrtbZM+zEzSqOVp5buUmHE6RGGR1eEh4aloHR22V7umz+icaTw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YdlnlF4SEIFTbPDsAr2QpCcW8CvDqPt5W8oyL6X1NUBVxnP/gBd7VhsQilsLOjKCdy/ZRzCEg9lYE6/ey556wiAp66tvOkc8UEI5ors8jWbiDUaUGCAK3BLvgVwNEOrWeE2lGz5J5IIpOfBWmz1L3JcQxt6Wtw57Stdf801wkotFvCk99JERCRe2+AoZPgC0UiiJeD2Nly9nWO1Q9Bcq/J0wfu4497JmSxZYRtZ2c7n9bAmHg8tvguOznNyxQR/Ytd8n470aBLq0HfQjFKU/WXea0QlHySZ1M4jTv3qmm3n6oDov9OTUVF9yTpw6xY3jkinViTw+TYDGIZUP1pKiCoC1LgX/G1lUlEVZN/D0KBgm6UKKMlxhWvAWqanKNwU8bcJ8oHY9wKyB3LoMtmZIC7bskeQU+HJQzggJW+hsVDEAhwl8W1A6GMBByRl3fHjM
X-Exchange-RoutingPolicyChecked: wNofkQBrTGsPe4oeeKCcNllZ8ZPBmgHLKsTzv2ZQvOo9Qe4axhS5s32TK0KBlbfK3NW5CTn0eYBHonhT8u7XnL5qTW0Md5HL3qpe9hfo99LGpTPvEIKEBKrRl6gZozLheogHmt6oGdQlZcS/6Twhp5pXAAseCW0T8SOoPxJvaIBcnKw0Fqr2NddzdYeupZJ3kSvvGGbMevknQd2ONbL3oEilUw1qis1UDggT7Q0bo2alGTQ5pUu9mleM2tMEDgA06eC5dKmRKsstBrS1HcAnD6oYnoLxVzx7Kr83LIUKkBkeR5qOi4QApefaLJV3vtB2le8au4nS5ZIAZ3RPWtWLcw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:40:08.9482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb16e88-ba6c-495b-a572-08df2dcd58c2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5874
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfXw3/JKyWmUs1M
 UuPYc4ImVmgaqWs9eOJrNTVjo8evYgWv8viqe2awBaTmzIrH6rX+tm5+u3hhKeso0S6yqCMReon
 i/F/cJBZtF6agWz+VnyNRRNrw52xLCgG+WyTSPrzdG3xqBkHAJEtPe4P+35lT6l4nrjYWGfqFs8
 jdlCc5ipTYM6DiI3zYbGw5h6vTJibl6Seqcs6QDGRdaanK0YhZ2zazp3ZMjWVdFpsMuk7OV8mU5
 3uJigWKnoea8v7497TrmCSCS6kvmaNmcKjhKRpnow2Ry2+3+EcJRSJ/gSK4HGYjAZekWAFua4zZ
 GYFIVhVol1Z5J5hCZ/g/rQB4HGchyP3d2fLTb6NXgkQ9rcLQTj0mtQ3ESiDxYxjplJk7iTLy/I9
 h4A+QXp59eTFNXlwWS8TagHlSP9AykjQm/naVnTUg8/2eoci+sGc2Eae2Xq3mXQtJ4FU8zA86C3
 gCEHEDcW7fx+yqLJ1dQ==
X-Proofpoint-ORIG-GUID: pcDOP4t6L9cQjYOa8e3bqKPsEFzEOETF
X-Authority-Analysis: v=2.4 cv=afT0Dhot c=1 sm=1 tr=0 ts=6ad5f38f cx=c_pps
 a=cLI4zmX3yytpP84iY95SKA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=voM4FWlXAAAA:8
 a=cm27Pg_UAAAA:8 a=rkogX2Xzrmj8k-iabVcA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: pcDOP4t6L9cQjYOa8e3bqKPsEFzEOETF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfXz0sBgwz3/80I
 SadPP98ezFYID6aJbIzh2XR9DogYaRNlAHD+lF96yrycfDIY2e7Taar7kWb0VAd4WdW1XcDuIIb
 Vcnw2m7UTf+UdCbVBIrNxVZVEF86PeM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
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

The HSM M4F node is disabled by default in the device tree. Enable the
node here as we have to load and boot the core in R5 SPL stage. Assign
the alias of 'remoteproc2' to the hsm node. This assigns the sequence
number '2' to HSM core which can be used during rproc_load() and
rproc_start() calls.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v8: Changelog:
1. None to this patch.

Link to v7:
https://lore.kernel.org/all/20260922084536.2477291-5-b-padhi@ti.com/

v7: Changelog:
1. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-5-b-padhi@ti.com/

v6: Changelog:
1. None

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-6-b-padhi@ti.com/

v5: Changelog:
1. Add a comment calling out the usage of alias indexes in code.
2. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-10-b-padhi@ti.com/

v4: Changelog:
1. Changed node labels from 'hsm_m4fss' to 'hsm' to match with device
   tree definition.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-9-b-padhi@ti.com/

v3: Changelog:
1. New patch. Enable HSM nodes from DT.

 arch/arm/dts/k3-j721s2-r5.dtsi | 10 ++++++++++
 arch/arm/dts/k3-j722s-r5.dtsi  | 10 ++++++++++
 arch/arm/dts/k3-j784s4-r5.dtsi |  9 +++++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
index 7d4a6dc5301..abe64f2364e 100644
--- a/arch/arm/dts/k3-j721s2-r5.dtsi
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -8,9 +8,15 @@
 		tick-timer = &mcu_timer0;
 	};
 
+	/*
+	 * The remoteproc sequence numbers defined here are used as literal indices
+	 * in arch/arm/mach-k3/r5/common.c (e.g., rproc_load(1, ...), rproc_load(2, ...)).
+	 * Adding, removing, or reordering these aliases will break the code.
+	 */
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
+		remoteproc2 = &hsm;
 	};
 
 	a72_0: a72@0 {
@@ -102,3 +108,7 @@
 	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
 			 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
 };
+
+&hsm {
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-j722s-r5.dtsi b/arch/arm/dts/k3-j722s-r5.dtsi
index 06a63fb83ba..9ddb951e078 100644
--- a/arch/arm/dts/k3-j722s-r5.dtsi
+++ b/arch/arm/dts/k3-j722s-r5.dtsi
@@ -4,9 +4,15 @@
  */
 
 / {
+	/*
+	 * The remoteproc sequence numbers defined here are used as literal indices
+	 * in arch/arm/mach-k3/r5/common.c (e.g., rproc_load(1, ...), rproc_load(2, ...)).
+	 * Adding, removing, or reordering these aliases will break the code.
+	 */
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
+		remoteproc2 = &hsm;
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
 	};
@@ -82,3 +88,7 @@
 	reg = <0x00 0x0fc40000 0x00 0x100>,
 	      <0x00 0x60000000 0x00 0x08000000>;
 };
+
+&hsm {
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-j784s4-r5.dtsi b/arch/arm/dts/k3-j784s4-r5.dtsi
index 78444dc4e14..afbb8faca44 100644
--- a/arch/arm/dts/k3-j784s4-r5.dtsi
+++ b/arch/arm/dts/k3-j784s4-r5.dtsi
@@ -8,9 +8,15 @@
 		tick-timer = &mcu_timer0;
 	};
 
+	/*
+	 * The remoteproc sequence numbers defined here are used as literal indices
+	 * in arch/arm/mach-k3/r5/common.c (e.g., rproc_load(1, ...), rproc_load(2, ...)).
+	 * Adding, removing, or reordering these aliases will break the code.
+	 */
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
+		remoteproc2 = &hsm;
 	};
 
 	a72_0: a72@0 {
@@ -113,3 +119,6 @@
 	vdd-supply-2 = <&tps62873a>;
 };
 
+&hsm {
+	status = "okay";
+};
-- 
2.34.1

