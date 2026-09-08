Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C71C79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 04:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92814404EB;
	Tue,  8 Sep 2026 04:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 17fIXHgBGaqy; Tue,  8 Sep 2026 04:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4978D404DC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788842189;
	b=NxKW2uDW9y6xdQIvOyloRq3gb06FcrRB0co/4rOW+OD7thsECpy2boAntqZtyh5LPZJN
	 2SiZ/9EVM9wYrpcqkHCNKeZow7es09MDwxbRUySAP7dE5l+sEwrch2QciM+hXKzkHISQg
	 qeUxUrHjKkOgjtRnr8lrS5qGj6mfMfziMhoCllIvtSLnnQiStu7LLK0OVZpdMBtDhJYVf
	 RyTGb98+9q/iks4cEITj/U4AJYnFcLIJI3V/LmLuxrLiHHro3/G0/Sd6NN6yRFwB23TOj
	 W/elRGVw5VwA9UXnR5oB+XljazePPAH9O51efQj4IN5Aqfj1mXNTa5M6AkuhfzQZoVQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788842189;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:CC:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aloBxRbOxfjFBTkYEI9AambnrgMRiOYU3DQuba6Lw5Q=;
	b=MXk4TFG+BVUqzR9mXdTlTPoS8MV55VKo93yFb1BvJvx9h6YNtTCecqrVHEmk2OfMh1ov
	 44gAEcy+zh0IZJxid/6VHYQpB39k7osaaM1RI3vqBMFvu6jyTv+EGiCidflJ7o5RQmhzs
	 wFr8zqSDCwJTk1PMKdOdAIG2NULvHjEo5+k8SvEiVhuDG+B2tlWDy2q4mge896P2tuy0Z
	 oIdbd3TqR4SdEDJptQq1SahrCxeBAgKyD2+zowE8ou/L7R+sGEn+1A5wQq2MY6Ug4J5yM
	 qEKCt8+xa3b8QVkcKowg+sgos+6wN6V4uScJd54fbGW5jPSvzisAWkZtXu8tx8Eoptg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788842189;
	bh=aloBxRbOxfjFBTkYEI9AambnrgMRiOYU3DQuba6Lw5Q=;
	h=Date:CC:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i26y9ck7hvNHIiiufhZtaYREkrgqrDP+v3h2sy/BjDVtHLhHz4YqCqb7tWygD2DiC
	 5h1Z2AcTlSkogYYE9R4+eoluSsZMgVtOT1I5khznwMIE1vQDFYfhxFN/RqAkhwE05z
	 Mz5FfBFbFq5x4w5xJQxzj55VsMme50fKqMTIHh5l9oMANjkmxhPoB52zurQQjYBcTn
	 kXz8CAq6uqkcA7U8f0n6y1r3lNDHlRwSrGxyhKw9cfRa1WKuZyxO2Ycton63RsLD3a
	 eREWX0jDKp2A8rtVskdJsjpck5Mp2Ey02xnK4ysFfkbSX3r0gvGPLHx3NJvFb06j7y
	 JcNmRYV41FTkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4978D404DC;
	Tue,  8 Sep 2026 04:36:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5D3929B
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 04:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E918808A0
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 04:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1mP36yIWB0X for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 04:36:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C6A7380887
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788842187;
 b=opILx1AFyA7rgH0m8mAXcjXhurZFf/rdyM7ELdn89yJHc9DaoqOd0SDNxJnC0BFv6FRQ
 937A+mYEYuyYuBKhemmNHfLYjh/1Neso/WzH7WqZlQqL87h5DXhGQr+y9Bkr3I1WMVQyN
 vRs0y2f/B/iLxUcgdB+UHClFNFCYQjK9OQM7HT+Rt8LhFi1iJT49H1Ppbc8iWdYSkuFkZ
 23X9+ik0dEQg5rTwPbEP05mcrLG+hmvdOZoqT4ayu6gmZVq/iduZkXUPQX7UYG2EUcPl/
 6tyCEy+Z/zhzRDysLJR8WR8jeoOcetdqch1YAN2NvWDtebecPMJi+ViFm3JwR6jT4iw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788842187;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:CC:Subject:To:References:Content-Language:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=aloBxRbOxfjFBTkYEI9AambnrgMRiOYU3DQuba6Lw5Q=;
 b=Hlw0iXkQ0G2CG0tnW12ju7ntK37A9X8FCpgEjmJ+nolqZIkjpRC+RCSCg8lxTWUmTAFP
 HBjXodxnZvlyXk1WU0b9/RcM9a9zk6s/dRW7iQGV6yIaw0CH0ZxLAvV7+ugRmD8Zr0crs
 mirHosLwvynXXfbO8YH3nOlf0bYqJx261AGArABvdakkOBUJFrJmpyirYrkPMxkqVuX7u
 knbpWWASFOod+T878lig0j0gAy8viMp2tERfYb1N84WVsIbH/NUXVQFp8NnYJOF6ugrlS
 FLah26USdhh68veYZNkmjajx6BCAcYzS0SpHQEjq15OIb5koVAYD1jy/24YlEKguq3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=fdFjk82q; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=DGYhrgUl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fdFjk82q; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=DGYhrgUl
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6A7380887
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 04:36:25 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6881sS3X329910; Mon, 7 Sep 2026 23:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=aloBxRbOxfjFBTkYEI9AambnrgMRiOYU3DQuba6Lw
 5Q=; b=fdFjk82q2j6ziRvBILMLC+h8PuENjKZKsH1g2zuQ+d3YAC8PN9EG/snli
 EdOFoREo1uDiwTltrmsZJ7mXgTggnmeH6WB2NnCTz4nclFFxLefET24nSS2Bxmi3
 gvMUMwCNn0HI9RrquPKg41spicUivLhKsJcp8gfIEWIw29YtZuAVnxjYn4/FVzy5
 aEDoePWdvmAfXg8WuyHhoV/mtlgWllSWWIkBoE3yZUK37yiymB2maKXqsKr8JoI3
 sk/ENvvXHM4NS6J89Ok3Tt7QPa0RBiwwCBAEZ89W6yZTbtXY+/gOJ5jHoDf1B5N1
 52Z0YCrQbSK+SPU7LF4qXHQRRUT0A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012057.outbound.protection.outlook.com
 [40.93.195.57])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj940gn92-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 23:36:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDfzsYrbldxyav0Y6orfEi/LLQ5mHdIvQPCXwpHPcNIOBkX5xh3HmhR/pVMTAMh5IXcQ/XzWWQ8UIfQfQoxd4uDL5IG+tb//LKrzQaZmjCyNo28IdnEAH0gG5Til7z17YbrN/ThgGbfTRCjJ6x34i0Xl4FSStIi4ukNcpx1HiPeUBJA1viXtW9RYJbcktHZfvK+S4oYmZufejVwUSyBPnoq9dqNLEQyLoyAol0NQbrOpWvHofp6krsa5yzEs4Rv3ey5MvKQEn8SsZOBzfScxM5OfEFOwhrpNWc134zGNPkcaz12MUgJLrpWK+FmCDkwx56rCx9B6QdxqWnuAMoMx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aloBxRbOxfjFBTkYEI9AambnrgMRiOYU3DQuba6Lw5Q=;
 b=w5p3QMMy4UL8GbqpIG1P0WWuTOUaVXiRnutYw8MjZKphgujk8msl1G7s6PbDuOfz4g9NI7SnnuJe+0JKITixHxGUl2lVuAPnF0ZhDU+if9OaDP15klNzVggG2d2Ex2+7udJ9f9U/n9iyN02M6dyLi+GyTSz8737BLdW51eFrQ2x4Mgnw6MI/1rh5DYSL1GDnyYo4glaqHUGmJFx4f9HjAtLB+N5Qj2Z2YuHMHAIfln3nPE6ngonEQ4THba/MHNA1ZVB8kk3nNS7LhU3VjOH8PJV0angPScU5GPdEBFPjkEyh5O1Hk0b7bjdMHKl7Scpa5kjCn5zR8NlugrXWQ4jgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aloBxRbOxfjFBTkYEI9AambnrgMRiOYU3DQuba6Lw5Q=;
 b=DGYhrgUlWfLp8g7J23pIikHa+ijH1unqylzHRFD4fUtt1T02f6WbIaoplXBuILp5h0c/eTu7hCrbznTN9L9AMFLCuwjBOSGBF6cgR5fBucvD3w+DIgyZPPCjZ0B6YSw7/T7FHv51BHKkOIWGUOhwy+gxDDltUOWsXKrV0Xf9QEY=
Received: from DS7PR03CA0277.namprd03.prod.outlook.com (2603:10b6:5:3ad::12)
 by SN7PR10MB6288.namprd10.prod.outlook.com (2603:10b6:806:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 04:36:19 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::a8) by DS7PR03CA0277.outlook.office365.com
 (2603:10b6:5:3ad::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:36:18 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 23:35:32 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 23:35:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 23:35:32 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6884ZUuT2751947;
 Mon, 7 Sep 2026 23:35:31 -0500
Message-ID: <5a321e55-ef8d-4c23-9d90-b3db815fe971@ti.com>
Date: Tue, 8 Sep 2026 10:09:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 3/7] pci: pcie_dw_ti: fetch reset-gpios from the
 device-tree and use it
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
References: <20260904120604.3612484-1-s-vadapalli@ti.com>
 <20260904120604.3612484-4-s-vadapalli@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260904120604.3612484-4-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SN7PR10MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de60ecb-1739-4e30-ba8a-08df0d62b98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1+yG2rblFEMlvCFFktTwtO1yQ4U5UYx4YnyCnp0TZN0K45FiRDU2kj86EZS4cw7MjxusK3g1P1oTObfKCtnJuunp+rad+LjiS0U1S8PCfCNxM5a4ynPlXlfsWys8fXZhyyjXpTfvG+7Vvmdet9fnYNjT6LQSreetCrgpgsE+ltJRrog/kHTDUIjb9yQdRAKbE+bG/03cRbkeRfhzasW2msBP2kXITjbauLqPUpIdt1z+93sCdSNqTuzjVFBPtcU2pvaptO2uvNylRinHEOssdyLbwDHkn9SBCRBynfjKyoDHxSEeeS0Ns+fgz/y6pE30DgwaVV1PGg9fGqy1lkGg3SMtokmBDHl/LO+F2gROJSl6PvaSS9/y3fHgY/+vqv7Qkxf3GqbRBfN7o7OcxqveTxvs/aOrt10vlCOTQ2IhkzaZg+QXrhz32gCwFN3CZvqxSHS472Q3oTNa8BhuKOyi0AtR9GVpZ6+PpM5fCmvttPa1ykWgLDGOF3/XAcjmcInx2xWz5wkTZ+ThWLsANSoz3MU66wXAJAcH4BVeOqR2GcAVLonqBbbIQGtkLJqGX6YzGwvFYpfDkmTi921C6E4l3LrFioAZIuAkGpNM5fKID2SZ/qIH+kr5NFVx+WgALDH49ePtFKf1Rn049aD6uaDqAP4j5zj2Txn2H/E1DALUBGwvinQ6btDl+mxKirKXSnZXDn50U+nIZ3XGMufrflxxFA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ll2aVJ+EiPvcT8z7LHY8ONg2DoMQM1rTUEI1mkw6OUcaaMuwtz6K83ZiFLrdJZlvy8LSgFFyjNSn7irM1+3eeEN1jAZMakxj78bfLr1fl0mZDixWJGWNJ3cI1y7wYwmoiv5XLPBtOInjY1aLCDCDS6JsFZiqZHaDNycJgJXm5IdFFgZNSBonV+OVIx4MuyGroZEriBI3RbOUCESyozzfHcuLok2DHDu9Z4AHmOtJgLZYMTF8BiebFZNBnh7OaeSCW2XqIOLUsPYGq7auXbZg/6Fc7/rUTMnGUW8PIixsaFOmf91fbx9Uza7Cv4qZtMDfh3hpYoOGyFo6QrqiTZuCeoxrBCcj4xFPQP5g0PjMtufcvACBbA+JqKWImSOI4Kk73T3e0p/sAjN2q4GtrAkksmybXGadKylynVDZHA1ZF2WU026X2VlZjcGmp0a63daj
X-Exchange-RoutingPolicyChecked: uHVrySUAPZAI3NUfMcmVkQVX1cTzYGsr/Gpkd/sP7JGYMdBY9qz76O8ObPlRleU/tfIZaE1wD/1Y+GRgAtWgPwmMaKRC2btPxUt+s1WzVncl9vMQu35BhAAe3A8Wg9ssxC+t1mMDEuGVNAjtxSvQdCFgSSejQGiOfjtRAuUqhtHKTYuBg6Tnv/+9Xty9ilgagAIu8YOCmZ1LMQ0m5s0L/xupFp4d/5nrU4Ek0dN7Ty6iknt6uwomxQEyOjlZHsF1CnLDDYQtNlt/cpugMaAoZ4qTVmSNWrCkn34LJA9qVyF90UfZ5N6qjV2Wi7HgOU30GbB73e1715HR1o7TgihrsA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:36:18.0074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de60ecb-1739-4e30-ba8a-08df0d62b98f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6288
X-Proofpoint-ORIG-GUID: sKlqcP3Liz5Ox7tC8uwQLnucAryijQIT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA0NyBTYWx0ZWRfX44y4xSEVdVCJ
 upZYYTv/ZzFEwphs+8C9dDN8oEkvuw6EC18VEobXJHE7CdFgMWLTSud6GpeD17OkAjQitJXoqvN
 wnNa1/1OYrraeWA+tGDdAxnwHJDGzwi8Bg13XIrmmwzm8d/OilS2dEQvzZk84U7mG97tJM3cCMW
 TkamJai1eKJPjJD+BTsMwoEqJGZwU1ibhS9ncsAzraJZ2/XOcCj/dKAAK/JflBXRYVQ3fn0W/wa
 wyQ+9dCHq5jTTnZG1M7W/1KSp4vi0c5hMcNeqjp+rTGKqP1KA5I3XyKNP4fHhhVuTWYhqwNo9+y
 xmQmmwM9s7ZkwPXb93rF6MAJrNV9GWC7R49qoXli3Ak9Q5/GXwo3wsCM9o/UyggG/cXIhaOPcYo
 cnciEgEsBuOCPIAHDdAxG4qYI1Hu3z1dCiQMqztG4omXZ6APyaOoa0sYnfh0v1ZrjXUaysxPY6r
 FtRLdGeHTN6MttAdtXA==
X-Authority-Analysis: v=2.4 cv=UrNT8ewB c=1 sm=1 tr=0 ts=6a9f90c6 cx=c_pps
 a=8TTB3MyXo5LrYHl2kKBanA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=-mJ2eqfY3ZwqBMwtFs8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sKlqcP3Liz5Ox7tC8uwQLnucAryijQIT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA0NyBTYWx0ZWRfXybbBQZ1krRqZ
 iRyFm03Eyuc9JNJkBN3p1eGolsH4jA2CzgJFL5qLrFTRzaD13iIyjXpthvr240nrCf43De0DYES
 udzWrf9BliwsXTDdxhBayt6lwFhO86E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080047
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

On 04/09/26 17:35, Siddharth Vadapalli wrote:
> The 'reset-gpios' property specified in the device-tree corresponds to
> the PCI PERST# signal that is used to reset a PCI Endpoint. Since the
> on-board circuitry may not reset the PCI Endpoint, fetch the 'reset-gpios'
> device-tree property and toggle the GPIO line corresponding to the PERST#
> signal to enable the PCI Endpoint. In the absence of the 'reset-gpios'
> property in the device-tree, existing behavior is retained rather than
> returning an error.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>   drivers/pci/pcie_dw_ti.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
> index fb39132f7c1..a34b142bbfb 100644
> --- a/drivers/pci/pcie_dw_ti.c
> +++ b/drivers/pci/pcie_dw_ti.c
> @@ -58,6 +58,7 @@ struct pcie_dw_ti {
>   	/* Must be first member of the struct */
>   	struct pcie_dw dw;
>   	void *app_base;
> +	struct gpio_desc rst_gpio;
>   	u32 num_lanes;
>   };
>   
> @@ -252,6 +253,17 @@ static int pcie_dw_ti_probe(struct udevice *dev)
>   		return ret;
>   	}
>   
> +	ret = gpio_request_by_name(dev, "reset-gpios", 0, &pci->rst_gpio,
> +				   GPIOD_IS_OUT);
> +	if (ret && ret != -ENOENT) {
> +		dev_err(dev, "failed to get reset-gpios\n");
> +		return ret;
> +	}
> +
> +	/* Keep the reset-line asserted until the PCI Controller is ready */
> +	if (dm_gpio_is_valid(&pci->rst_gpio))
> +		dm_gpio_set_value(&pci->rst_gpio, 1);

The polarity is inverted. It should be a '0' here and a '1' below. I 
identified this issue when testing with a PCIe-Ethernet Adapter. This 
series was tested with a PCIe-WiFi Adapter that seemed to work (logs 
included in the cover letter).

With the polarity corrected, both the PCIe-Ethernet Adapter and the 
PCIe-WiFi Adapter work. I will post the v2 series with this fix.

Regards,
Siddharth.

> +
>   	ret = generic_phy_get_by_name(dev,  "pcie-phy0", &phy0);
>   	if (ret) {
>   		dev_err(dev, "Unable to get phy0");
> @@ -281,6 +293,15 @@ static int pcie_dw_ti_probe(struct udevice *dev)
>   
>   	dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
>   
> +	/*
> +	 * The reset-gpio (PERST#) should be held deasserted for at-least 100 ms
> +	 * before the link is brought up.
> +	 */
> +	if (dm_gpio_is_valid(&pci->rst_gpio)) {
> +		dm_gpio_set_value(&pci->rst_gpio, 0);
> +		mdelay(100);
> +	}
> +
>   	if (!pcie_dw_ti_pcie_link_up(pci, LINK_SPEED_GEN_2)) {
>   		printf("PCIE-%d: Link down\n", dev_seq(dev));
>   		return -ENODEV;

