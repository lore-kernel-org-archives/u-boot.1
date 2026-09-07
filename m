Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BCEC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 05:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C093C80BE9;
	Mon,  7 Sep 2026 05:47:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eypk7CbVijmY; Mon,  7 Sep 2026 05:47:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5007180BD1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788760042;
	b=Qsbfetrx65QgojxkXN0mhck5cXZzjYRDDdgk0xnlpzB6B2Egmoqy5Mc8nn1wjW4+NuW7
	 vrHBqRMbLUcTDm0iA0v/cr6o9PkmLHy0jACi4GCsdhBzq3GFS6Mxfl1qcryWZNN/vEsE+
	 YWMb8XVOqbTY7tcuIUfyPOMRC5tNeKeudJLMLFssewwAj+xmiy1L0na7gxCWyVGPhBRi+
	 SfvvWNv6kOXqzyJ6Be27tIvwgYfZ3+YTf8JzaUfthRtoUAolVvsHbzpKIbIgMG3Nwegq8
	 LGab3FO6O7c1A0oo8pb/OXhQ9gi+9NNTT3aqrK3DySl1RHf+4MsNnB1sScDSGpIFN1g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788760042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GCAt+HO95f/lAzEq1X1FcKPlL6k9Hbdvbql+JvwoLHw=;
	b=cU8TlV1yc5UprX0A56qtfyFApSsld+FRamC3fNCK+uQfY/5QjECxyHUQSA9EZw8bhc8O
	 MOdmOP3lDIKugEDUC98lBfZtIi0AVYagf96Z5GFds3jnjOTMZGTTUqEb+yOuM0PorCVfN
	 njYYFvpgDDX3ann4AFGF9QvotbFnyO8wjMAsvlFu5zxEP3pZ3rcZVszAAIHcXgm9AhS7a
	 mTXOwboM5hcUfrN9TLgNWcsicl2rxMGsQbIhRpPtJBe8K66VUaweHTGfOdcaGOmGDURwL
	 9jhU5y4HaSjR0/uN4ozRwv6zzvK/E1WHYb14bvPEl1/2L5Oy4E+fF84/d7jTqIow7rw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ssehnju6;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=GSWK2+i7;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788760042;
	bh=GCAt+HO95f/lAzEq1X1FcKPlL6k9Hbdvbql+JvwoLHw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uJ4akdx8d+y3RQvfzrQzJgLL4m51eUZ2DLBnYLuUAh5cxiXKnBAPR4wiiUVZ5KoFO
	 OTUOYhw8gTu9NlDLCILmjuSLuPUXQkUg9I+ipvuMKqqkFkiSgaSZ4gk4ShRp7mnGW9
	 /iTa595GPinCdNr0hiwFbDHalZ9gxE+GmbRSG5CxrpyyGgtZ7juUePS0JeT5uRyn83
	 AkB7hCPwYEkg47PjLSLFqKdMZuEYSHzi/p8q08f/QhK0hhMqx4bt7lUGHalcCeOaML
	 POPxUadtI7NcNIhEdGPCta81N326WUzaE0vP5zasr15LH2peOrJikax8JqS8sYTT3Q
	 pAZL1HqqcaAPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5007180BD1;
	Mon,  7 Sep 2026 05:47:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 839AA990
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68EC080BD1
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sbGagCVy7TtI for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 05:47:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AC59180ADE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788760039;
 b=lGJMXsDWjsxHmg95/4f8eHZ90R01OcM+xolIG7A8vPlSeyZAVE6LxuWXwpmJqdmVF0VB
 j0MQp23D0IvaJ2/5h8VYdEYjpnfpfOWyLUp1Y1m04F26ejaPGn7NTHN4MQZxdHFrkC82X
 vnvDf4Z2qZvvlEcKDdhFmmGx3+uPeacQ3sZwQneqmgwXmeIyLReTT0NEWsmxg0dtfNqol
 wGOxv3QXaHZiLaNfKk5Bw7aUITJlV2jJ4JSE0wG7pb8tfU8uAcaZZjFEGTN4F35h7CeVA
 Vv4U25G1aaW3CXX55NDCzwz5kCLEuL9xNVTBxdIwmIU6vBI064jvycivBiyRhnp2lwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788760039;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=GCAt+HO95f/lAzEq1X1FcKPlL6k9Hbdvbql+JvwoLHw=;
 b=jnF2hubJsqIJjQkzxcbFdSgtaicGc6TEJ6O4PbUOYVl3Im7UfcGl+JeJseb4BHDiMokt
 wxpLcnArc/We9UUqKC+Zv/ftbo2d2o/FPC62VPUgMNZzdz75T1kvIB5ANBVpQwdPATSKx
 Cozw7KUIOdfOS3uESd8e1uKB1jNY/mcUpbCb9cvqhWjCQI1KcbFZ8C7Qg/YTwa22zMikK
 osCJ4e5Sy0+DFs3ddgHRpFtvQfi+aWnEA5q1oU+kSg+rrQdMnu96SKgJzpEF0F9WuJol0
 nxjckwznPWsFJJkPEQsw++EnrdhW31+aHwJsPTKRVeyAeJfwWa7BxkyImabeGvyJB1A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Ssehnju6; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=GSWK2+i7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Ssehnju6; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=GSWK2+i7
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC59180ADE
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:47:18 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6873jFmS477418;
 Mon, 7 Sep 2026 00:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=GCAt+HO95f/lAzEq1X1FcKPlL6k9Hbdvbql+JvwoL
 Hw=; b=Ssehnju6hO2tzbZ54VjHQnRSAw8g5f/L2A+YlubgFHr7Lem2wv+LtiY+q
 4cjxKh9ywKJt7ahy8TeuPDJR5mHgtmv1b/kZQeJOLnVpkzBuY/J0XHROXB93ixvf
 +NYc8G6uf5SDdglTckZeIWBAk7QVooSig1vH4blLZMuzAuDtpkQWD4x6cdhIS/Ck
 zf2k0JgD0Pfsf80hWmtXnpKgH/R7V7ZpDyOhOezI9IbKDENVojQA8BiafpGjECwQ
 Z7JOiteAEEEqAtTxhsnT+Rug3kfRvaW1DwF1VkH1FITpZNFtFSsoBrIc7m/bVWk2
 cXDvUVUvNVa9BRSnw29U0FHJGaH9g==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gh51nkja6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 00:47:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lB7gruj/YYACOVch8ViraxBkpPyFn5+NtNQ9bSZHnjRKCQOX3V695fnJttlQGyPcEyvvEW6mE616VX8+73Acn3i0pC8IX1MJMGLxEb062LC+BiXMUgyxSMpIYBVWVhEXEw/LPRdC3FGPKTdMerxIsCr7BD4WRQlf2eu7Pbp4THrmc24WodT0oxpZBG+vOZQJI+woUl6NJBGjo1HGUhxhap4YCDnL+oOxHIAyZwQiqOnR8txhQE4NyA2OJS/NyHLHYwbdQ++e5XvVutobz1sNVQJg0CBvdu9JoKQUXUaefB+0xhxgamfvub7MnUTZhv+UbkxkkRfo2PhwIJwHdvoShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCAt+HO95f/lAzEq1X1FcKPlL6k9Hbdvbql+JvwoLHw=;
 b=bfRAmBAKrCZSAyAUNfJT82qCFxRv2nUeQKz6uop0lB1ex0n+eVJJtjctMyPwpcFpG4OIcqUtJjBrJp1ZZEkJhUOhCnJYgwxl0Iak1vo3mkOJHHLWUYpaL1G9wFNdoSbgpjBws0NTOkluRS28Ts8RwiDPoB9wmS5QeORag9XQ+35+undhbI3uKg/6KpFWOwEAQFRxgOX5fBZFCR8R4gZ7DMjFtQEaqgHQJeGbdJfRx78o81s75CZIYOKh/r+XA9UQcDFEMlA1rZgrzWHc8UJ4z7GSN51x8PQREPwbeNg9dnVKw25JMcVaZK+yiHahKWmMqg/h+I0xABb6O3LGHrIrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCAt+HO95f/lAzEq1X1FcKPlL6k9Hbdvbql+JvwoLHw=;
 b=GSWK2+i7LCpt3SfpAH1qHw/nEgFeUsP/aUmR/fNr/65EYyi38X36bQ5KwF+fvUCMdrCQxdZomO9himlGfq/3z/qCRXqnkFlpeu8InOhKcWHsRdXoBSL4WKidlAcVaTYF5r5GiKAznzMHx5FbxAuscGrBlECDmvtTHItc/lEHXf0=
Received: from SJ0PR13CA0174.namprd13.prod.outlook.com (2603:10b6:a03:2c7::29)
 by SN7PR10MB6363.namprd10.prod.outlook.com (2603:10b6:806:26d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Mon, 7 Sep 2026
 05:47:08 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::aa) by SJ0PR13CA0174.outlook.office365.com
 (2603:10b6:a03:2c7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 05:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 05:47:07 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 00:46:51 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 00:46:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 00:46:51 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6875kk1s909966;
 Mon, 7 Sep 2026 00:46:47 -0500
Message-ID: <7c909676-c821-4c51-a339-03aee3871a00@ti.com>
Date: Mon, 7 Sep 2026 11:16:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/21] mach-k3: r5: common: add helper functions needed
 in LPM resume sequence
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-5-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-5-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|SN7PR10MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d938815-a16f-4b9f-496e-08df0ca37428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|13003099007|6133799003|56012099006|10067099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: UIHcfCjMUQFZDBPihMjD/MbY9ldLbxvX1whHXJQaOAAcDGRmbtt1Mz4JY4/y3d1GnRaEYtdo+0ce1GPWXe/jvG8yLiai8SwW5VbrTijOTED9YmqUjD4JpshFwoWIhz0z/6Z1ow9lV25zQb0pkF5FNQ20UGG1VUHe3+vvRn1CUuQuqCtcIX6x1aoBhgjCJr7ejyIczd9kQuiaVU/b+IJ+vhfqJ3j9RfYtYntD4Qy4MciuEgqNHhMW5uDbsT3ShQFIN4xgQ8pkXg9RUd3TfE4oYti0yBEOhn+zE1dj1qyU6KcYfVjKEUZFt8xxGTY0JoxfOmNDpnWe7yo6SEHMS/jB2bhzQXQZr7jh4Rppo1s/MSRwggBGAFRNZF1Y5KpK1ehncYURhFKSq3fFb21HlfsfZ//r6oe1+froFtY8f5iej+pLpotC1XanQF1lZuBRxNSgE31pWkhRtyr+Ps0DwhN7lUNnbrWY6UTdaKK6DR2l0SCkLmQabAN1C/h+CwEoh7s/ZyxHlXjfqlaaY1VBxm8eDYzJXYH/llnXnmYUyqrdP2zfHmFpzGwMQXHEApLS9RIfirZSvDS4jHWr1oL52UaqcOkISbfBViSFF+fkM685Km4dRmSBHAuYbs2I8LUEPIe5/yRtvgGqB2f4NBDoHzTAHw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(13003099007)(6133799003)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lQGrFUg4TvUCRDmVh6BoP2IteTsa38avUHRQjy326V2mpDd3nf6HQUfXsHqnSLwYn+o6wmqrIA8tLot8O1yKORjVAYVRhxNLOgQ1pp9/PNC+AQKAjaGhZOyC3l1V5+RBRK+qlBgO2Vu/Mj4505MblNQ6T8CMUK+n7+E32bVgAJVpmHhxm+wFX6W0h4khKZNXZmkq2nAnwuXlev2xmQtbS4IQPT3YqAZ7oYaOaFySLUEyCn4py+JVrDkPARNgIflC98A0oPKzpazvBOWgZhlnxrgIKj67CqSNTdEZ/lRv8nDh8AljCkhLEGy1uTweeX7rMxM2fR3S2eJC2UOtQJIPrl/4ZcflHlqkeZIkZpMwOZ2dUFlo7kNgbX9KCX+fWc4NTlTGwMAEnJN14w4lU9L7zXKxknaEPJUsF0/1si9sh+tyJOxV6kOJB9ABPRlma0e9
X-Exchange-RoutingPolicyChecked: lyhX8dXbwpKMtLZzsCbYBhIZJaBvdlRmPvmQ0hHrGejdJxrQOxsALHg12HfZf2ox7+MoCmHdOvijhflfAMq08ceuZIY7Bzdh/HvddqO/15dcFQnPC4VO1YViRG3meVdzbYSSYIACGFsydkpqkVWXnhO9Zb9+7L4Q6pDkhER7RQXaNLMDh2ov9XhS7CXuGnxdBB4DP2R2LRbEwOCjCEeEpv++ZvG+hg/DgqNEXM+Uq4sWnyuEOFaKAH505V/rN14s+/KIyJhVmcs2LG/CDXI9YO7nYYrdQEq1hAnxPv3B0nsvSl9HGru+ZFUZmx+gluZz2Cn6sMrC+E4Mg/UjikYneA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 05:47:07.6620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d938815-a16f-4b9f-496e-08df0ca37428
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6363
X-Authority-Analysis: v=2.4 cv=J8GaKgnS c=1 sm=1 tr=0 ts=6a9e4fe1 cx=c_pps
 a=ar5COM9M0msGq9wDbiNjNQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=P-IC7800AAAA:8 a=aNlTAoTlZwaeOKGEOHEA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: e-BpVuCgSXnWPwkHgGj429DXWM95vNaq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA2MCBTYWx0ZWRfX4M09Fbpe8Qnq
 ybulR931ipds+oONllcMCPzxc1xVsiUB/bG5O83tkvHJUhigjbCEZO1W8U/cxh1T+4AqSwRys3F
 KcGI7e82Ho45MigagruDavD9T1SAKZ8u11aBa/e1PBtg8ghm8Y4ucV3N8op9G8g0U5O4jjeqmn0
 L9qMlksOXZC5xh9NmCdb/qUVakEVUkGcej3kS9mfKOKVgeOdbLYX/vFZKkdsSTttFvNvGg5T4Ib
 hFRro8kapvLeqZEMff1JH3FvF+htUB9iFR3AYrZetQEdRjyRhxDJkDiYBFIRani0I+TX6T3AV+h
 pNJDImdBcAo9BaKpKbY2hEacSWevtTj3hxkHq+mqpGhFVfBEc0pHib0PPnJEdPi7xq8X8dbyqD2
 fe5Tyiwt+1Z8fNvJlYn1IKnPbYoWRrg6XleAq0oJYgt65OG2Rn8yU+8MAeo4TOTI0OnXUa0WYxy
 YoTTtADopmF6Uxg6eww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA2MCBTYWx0ZWRfXxRjqCbF+EkV3
 R1hyWL96J0FldaxdBs4m1BSVzp5ine36bdHFxSK+VqcH1A1zAcIB5iJKzXIpz7kEMBLyEyGpSsm
 1v7mwvjglntCglYx7hjW6rUrlHR8zhE=
X-Proofpoint-GUID: e-BpVuCgSXnWPwkHgGj429DXWM95vNaq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070060
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



On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
> From: Prasanth Babu Mantena <p-mantena@ti.com>
> 
> Add helper functions that are used by respective SoCs in LPM resume flow.
> 
> - lpm_process() is called at boot time to:
>   - retrieve the LPM memory region from DTS
>   - save ATF/OPTEE certificates information and DM code in this memory
>     region
>   - Forward the LPM address to TIFS via TISCI_MSG_LPM_SAVE_ADDR
> TIFS will use this address to save TFA context and its own minimal
> context just before suspend.
> 
> - do_resume() is called at resume, just after bringing the DDR out of
>   retention to:
>   - retrieve the LPM memory region from DTS
>   - authenticate certificates from LPM memory region and apply firewalls
>   - ask TIFS to restore TFA and its own minimal context
>   - start TFA on remote proc
>   - load and jump to DM
> 
> - k3_set_lpm_core_bus_node_path() and k3_set_lpm_core_compatible() are
>   used to locate the lpm memory region in the DTB
> 
> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#lpm-msg-lpm-save-addr
> 
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/mach-k3/common.h        |  16 ++
>  arch/arm/mach-k3/lpm-common.h    |  17 ++
>  arch/arm/mach-k3/r5/Kconfig      |   4 +
>  arch/arm/mach-k3/r5/Makefile     |   1 +
>  arch/arm/mach-k3/r5/common.c     |  17 +-
>  arch/arm/mach-k3/r5/lpm-common.c | 268 +++++++++++++++++++++++++++++++
>  6 files changed, 311 insertions(+), 12 deletions(-)
>  create mode 100644 arch/arm/mach-k3/lpm-common.h
>  create mode 100644 arch/arm/mach-k3/r5/lpm-common.c
> 
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 37ff98d89924..c97ccc8e0619 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -8,6 +8,7 @@
>  
>  #include <asm/armv7_mpu.h>
>  #include <asm/hardware.h>
> +#include <image.h>
>  #include <mach/security.h>
>  
>  /* keep ram_top in the 32-bit address space */
> @@ -16,6 +17,21 @@
>  #define K3_FIREWALL_BACKGROUND_BIT	(8)
>  #define K3_SPEED_GRADE_UNKNOWN		'\0'
>  
> +#if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
> +enum {
> +	IMAGE_ID_ATF,
> +	IMAGE_ID_OPTEE,
> +	IMAGE_ID_SPL,
> +	IMAGE_ID_DM_FW,
> +	IMAGE_ID_TIFSSTUB_HS,
> +	IMAGE_ID_TIFSSTUB_FS,
> +	IMAGE_ID_TIFSSTUB_GP,
> +	IMAGE_AMT,
> +};
> +
> +extern struct image_info fit_image_info[IMAGE_AMT];
> +#endif
> +
>  struct fwl_data {
>  	const char *name;
>  	u16 fwl_id;
> diff --git a/arch/arm/mach-k3/lpm-common.h b/arch/arm/mach-k3/lpm-common.h
> new file mode 100644
> index 000000000000..83e0fdcca6ca
> --- /dev/null
> +++ b/arch/arm/mach-k3/lpm-common.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * K3: LPM Architecture common definitions
> + *
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2026 Bootlin
> + */
> +
> +#ifndef _LPM_COMMON_H_
> +#define _LPM_COMMON_H_
> +
> +void __noreturn do_resume(void);
> +void lpm_process(void);
> +void k3_set_lpm_core_bus_node_path(const char *node_path);
> +void k3_set_lpm_core_compatible(const char *compatible);
> +
> +#endif
> diff --git a/arch/arm/mach-k3/r5/Kconfig b/arch/arm/mach-k3/r5/Kconfig
> index 12335880e106..7a9c005a6d7c 100644
> --- a/arch/arm/mach-k3/r5/Kconfig
> +++ b/arch/arm/mach-k3/r5/Kconfig
> @@ -1,6 +1,10 @@
>  config K3_LOAD_SYSFW
>  	bool
>  
> +config K3_LPM
> +	bool
> +	default y if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J784S4 || SOC_K3_J722S || SOC_K3_J721S2

SOC_K3_J721E does not support LPM

> +
>  config K3_OPP_LOW
>  	depends on ARCH_K3 && K3_AVS0
>  	bool "Enable OPP_LOW on supported TI K3 SoCs"
> diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
> index 074e3b61a262..ccededbc0d60 100644
> --- a/arch/arm/mach-k3/r5/Makefile
> +++ b/arch/arm/mach-k3/r5/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_SOC_K3_J722S) += j722s/
>  obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
>  
>  obj-y += common.o
> +obj-$(CONFIG_K3_LPM) += lpm-common.o
>  obj-y += lowlevel_init.o
>  obj-y += r5_mpu.o
>  
> [..]
> +static int extract_lpm_region(struct lpm_addr_info *mem_addr_lpm)
> +{
> +	struct ofnode_phandle_args memregion_phandle;
> +	fdt_addr_t lpm_reg_addr;
> +	fdt_size_t lpm_reg_size;
> +	ofnode memregion;
> +	ofnode bus_node;
> +	int ret, idx;
> +
> +	if (!lpm_core_compatible) {
> +		printf("LPM compatible core string not set\n");
> +		return -EINVAL;
> +	}
> +	if (!lpm_core_bus_node_path) {
> +		printf("LPM core bus path  not set\n");
> +		return -EINVAL;
> +	}
> +
> +	bus_node = ofnode_path(lpm_core_bus_node_path);
> +	if (!ofnode_valid(bus_node)) {
> +		printf("Failed to find wkup bus\n");
> +		return -EINVAL;
> +	}
> +
> +	memregion = ofnode_by_compatible(bus_node, lpm_core_compatible);
> +	if (!ofnode_valid(memregion)) {
> +		printf("Failed to find r5f devicetree node %s\n",
> +		       lpm_core_compatible);
> +		return -EINVAL;
> +	}
> +
> +	idx = ofnode_stringlist_search(memregion, "memory-region-names",
> +				       "lpm-metadata");
> +	if (idx < 0)
> +		return idx;
> +
> +	ret = ofnode_parse_phandle_with_args(memregion, "memory-region", NULL,
> +					     0, idx, &memregion_phandle);
> +
> +	if (ret) {
> +		printf("Failed to parse phandle for lpm memory region\n");
> +		return ret;
> +	}
> +
> +	lpm_reg_addr = ofnode_get_addr(memregion_phandle.node);
> +	if (lpm_reg_addr == FDT_ADDR_T_NONE) {
> +		printf("Can't find a valid reserved node!\n");
> +		return -ENODEV;
> +	}
> +
> +	lpm_reg_size = ofnode_get_size(memregion_phandle.node);
> +	if (lpm_reg_size == FDT_ADDR_T_NONE) {
> +		printf("Can't find a valid reserved node!\n");
> +		return -ENODEV;
> +	}
> +

having check on lpm_reg_size will be helpful, so that you are not
exceeding below allocation of memory.

> +	mem_addr_lpm->context_save_addr = lpm_reg_addr;
> +	mem_addr_lpm->atf_cert_addr = mem_addr_lpm->context_save_addr + FW_IMAGE_SIZE;
> +	mem_addr_lpm->optee_cert_addr = mem_addr_lpm->atf_cert_addr + FW_IMAGE_SIZE;
> +	mem_addr_lpm->dm_save_addr = mem_addr_lpm->optee_cert_addr + (2 * FW_IMAGE_SIZE);
> +	mem_addr_lpm->size = lpm_reg_size;
> +
> +	return 0;
> +}
> +
> +static int save_certificate(struct lpm_addr_info *mem_addr_lpm)

Since we are saving images as well, so save_certificate is not right
function name.
> +{
> +	int ret;
> +
> +	if (!fit_image_info[IMAGE_ID_ATF].image_start ||
> +	    !fit_image_info[IMAGE_ID_OPTEE].image_start ||
> +	    !fit_image_info[IMAGE_ID_DM_FW].image_start) {
> +		pr_err("Invalid images to save\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = extract_lpm_region(mem_addr_lpm);
> +	if (ret) {
> +		pr_err("Cannot find valid LPM address range..\n");
> +		return -ENOMEM;
> +	}
> +
> +	memcpy((void *)mem_addr_lpm->atf_cert_addr,
> +	       (void *)fit_image_info[IMAGE_ID_ATF].image_start,
> +	       fit_image_info[IMAGE_ID_ATF].image_len);
> +
> +	memcpy((void *)mem_addr_lpm->optee_cert_addr,
> +	       (void *)fit_image_info[IMAGE_ID_OPTEE].image_start,
> +	       fit_image_info[IMAGE_ID_OPTEE].image_len);
> +
> +	memcpy((void *)mem_addr_lpm->dm_save_addr,
> +	       (void *)fit_image_info[IMAGE_ID_DM_FW].image_start,
> +	       fit_image_info[IMAGE_ID_DM_FW].image_len);

Is this DM image with certificates ?

> +
> +	return 0;
> +}
> +
> +void lpm_process(void)
> +{
> +	int ret = 0;
> +	struct lpm_addr_info mem_addr_lpm;
> +	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
> +
> +	ret = save_certificate(&mem_addr_lpm);
> +	if (ret)
> +		return;
> +	/*
> +	 * As there is no function to check TIFS capabilities, we can't really
> +	 * know if the call failed because it's not supported by TIFS or for
> +	 * another reason.
> +	 */
> +	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci,
> +						mem_addr_lpm.context_save_addr,
> +						mem_addr_lpm.size);
> +	if (ret)
> +		pr_err("TIFS lpm save addr fails (message not supported?)\n");
> +}
> +
> +static unsigned long resume_to_dm_f(const struct lpm_addr_info *mem_addr_lpm)
> +{
> +	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
> +	unsigned long loadaddr;
> +	int ret = 0;
> +
> +	loadaddr = mem_addr_lpm->dm_save_addr;
> +	if (!valid_elf_image(loadaddr))
> +		panic("%s: DM-Firmware image is not valid, it cannot be loaded\n",
> +		      __func__);
> +
> +	loadaddr = load_elf_image_phdr(loadaddr);

I suggest to load DM image using proc_auth_boot API, so that firewall
inforamtion in DM image can be applied, or replay certificate of DM
image and load elf.

> +	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci,
> +						mem_addr_lpm->context_save_addr,
> +						mem_addr_lpm->size);
> +	if (ret)
> +		panic("TIFS lpm save addr fail : %x\n", ret);
> +
> +	/*
> +	 * TIFS minimal context restore
> +	 * This restores also the firewall
> +	 */
> +	ret = ti_sci->ops.lpm_ops.min_context_restore(ti_sci, 0);
> +	if (ret)
> +		panic("TIFS restore_context failed (%d)\n", ret);
> +
> +	/*
> +	 * Restore TFA in msmc memory
> +	 */
> +	ret = ti_sci->ops.lpm_ops.decrypt_tfa(ti_sci,
> +					      CONFIG_K3_ATF_LOAD_ADDR);
> +	if (ret)
> +		panic("%s: TIFS failed to decrytp TFA : %x\n", __func__, ret);
> +
> +	/* restore TFA resume vector address in main core */
> +	ret = ti_sci->ops.lpm_ops.core_resume(ti_sci);
> +	if (ret)
> +		panic("ATF failed to resume (%d)\n", ret);
> +
> +	return loadaddr;
> +}
> +
> +static void resume_rproc_f(void)
> +{
> +	struct power_domain rproc_pwrdmn;
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = uclass_get_device_by_seq(UCLASS_REMOTEPROC, 1, &dev);
> +	if (ret)
> +		panic("Unknown remote processor 1 (%d)\n", ret);
> +
> +	ret = power_domain_get_by_index(dev, &rproc_pwrdmn, 1);
> +	if (ret)
> +		panic("power_domain_get_rproc() failed: %d\n", ret);
> +
> +	ret = power_domain_on(&rproc_pwrdmn);
> +	if (ret)
> +		panic("power_domain_on failed: %d\n", ret);
> +}
> +
> +typedef void __noreturn (*image_entry_noargs_t)(void);
> +
> +void __noreturn do_resume(void)
> +{
> +	struct lpm_addr_info mem_addr_lpm;
> +	image_entry_noargs_t image_entry;
> +	size_t sz = FW_IMAGE_SIZE;
> +	unsigned long loadaddr;
> +	void *image_addr;
> +	int ret;
> +
> +	ret = extract_lpm_region(&mem_addr_lpm);
> +	if (ret)
> +		panic("Cannot find valid LPM address range... LPM resume failed\n");
> +
> +	/*
> +	 * Disclamer:

Disclaimer

> +	 * ---------
> +	 * There's a potential attack vector here, because OPTEE could be
> +	 * modified before being reloaded.
> +	 *
> +	 * Also, if the certificate replay is skipped, then TFA can be
> +	 * read from MSMC.
> +	 */
> +	ret = rproc_load(1, mem_addr_lpm.atf_cert_addr, 0x200);
> +	if (ret)
> +		panic("rproc failed to be initialized (%d)\n", ret);
> +
> +	image_addr = (void *)mem_addr_lpm.atf_cert_addr;
> +	ti_secure_image_auth_apply_fwls(&image_addr, sz);
> +
> +	image_addr = (void *)mem_addr_lpm.optee_cert_addr;
> +	ti_secure_image_auth_apply_fwls(&image_addr, sz);
> +
> +	loadaddr = resume_to_dm_f(&mem_addr_lpm);
> +	printf("Starting ATF on ARM64 core...\n\n");
> +	resume_rproc_f();
> +
> +	image_entry = (image_entry_noargs_t)loadaddr;
> +	image_entry();
> +}

