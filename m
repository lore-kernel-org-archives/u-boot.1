Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E632C88E73
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 07:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9764460740;
	Tue, 15 Sep 2026 07:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXZMHiDP4hDU; Tue, 15 Sep 2026 07:43:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 651EB6072D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789458228;
	b=ktlaB3YtK1e4O91grNgFhOnHvzHnhGhOd1iUb0vDdCClIufpKGfexeJ7JGvPtFIjvdbo
	 DPSOWOnM+hwk5Yfh9MpzYm+6GsALWsn4P4dDF1QPumlinm9NS3HuHlkUFWHqfYujJMK3j
	 Tzy/9XpJpWvz8XTzu+5HAj1cMGXXZmJYpkz3V9Kwlf0wKLoQM3ibmryylxtvi3IDCsknz
	 hucn0T/xDQTn/wMLZM9YGJ202iTl+wkfxvlHtCIIP55NWBJ8A998MHQr3OYKV80kDy5XE
	 q5ZX6Eq9hDiGfwQwi87e42znnZnh4oEA16ulDRl9z2SwczGh2qsHInTkrB/SLmStfKw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789458228;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8WIeB9U6sMHiY/1JPk9G+d9WngrCYp/l/QykGHYtfb8=;
	b=E56FKW0AMLz/PC/gtWU+jz9jPurz6wFVyOIBId7XdEjYRj5A12VcWgPhd5ldF2UBcGzf
	 V+Lu85iAsAIFfJEkTvJSxdHcKPIW//ssCZkDNtygO5gdivHtVfd81Tr2LPbQkMo5/SGjQ
	 plSyUCnG5Prr8nLbWrcpZdur2JR92jn41Nc9hHTN6FNeDYx0Y311GZhzXMaJQpZ8oVCvU
	 VNjWgXvWv3qcUksj7SiEIL/EVKucCJlYvK4/2HzbLQDIoI9TlZTps2DXHViV1nDLWdHDz
	 YoEkRjf32gNANJLCFYjH/aLAciKHrUpvv8tqa5br1pB+0qh7spbtatCh625r5TUoXjQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bfmVRKy+;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=APelsIKR;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789458228;
	bh=8WIeB9U6sMHiY/1JPk9G+d9WngrCYp/l/QykGHYtfb8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zaGQ/2L0BaNd0RUOzqL5rptPwkl/4PwY5jsEFLbC68XNgN9w8P0TxLSFLqKE7GF+w
	 pMKHWZY9mvARmpvk11ZH4rXLz/vnk2t/zwqixbuIUlUhDY29r5eflaMZ5WLQzfQVhs
	 Azo9vzn4fowu0C5Da9PNTz3cwCPifGKRh28jhiNOdzfAF1a6FzFfv7wI4vwlnhEucW
	 F5Fg4orlVJbby9ewUtWyMppkueA5jQb0YpRbslNYmKErOB2FIuANgIg5/B5ZkohmP8
	 OXyXtrN/kNcubNsJaJ3QApa/leLx9seEVyle5QGeMFMIRSYc+wwC7USvwNiu1a1Ppz
	 LdPwM49kroVjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 651EB6072D;
	Tue, 15 Sep 2026 07:43:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F799EB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 05:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64F55605D9
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 05:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LAWzj7rfL7FK for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 05:56:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2A94160708
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789451794;
 b=TD6trxaWW/rfiNbXYvN3Hz7GPUZp0LCYWLpuSJbRU/Bof6LN1YRGS3JdH81Z7d9kRnwE
 10ZfHSH4DBpn9JS9FVHOOzoPTUhaArThEjf8N3vfXZa7AweoFvEnUgl6ta2E7YMOoT8J3
 xiTtKx/Dp2tnGY61PFBNoXqCaeDokM4JrZ4Sm/niBpzYFMWGcocyRchV3fubsUM2scqXB
 3fab6H9kELkfv2jEyfrQBYht26gKsF7vW6P+JM4aAWRlu2pHO8lPWvvWXN8iXFdfM7hpP
 e5H5s/s3Q/RgeGIaC+M350bvX5NOLW0rNez5aFd4ULyHQaR/oJm223we3VKkcZimFjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789451794;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8WIeB9U6sMHiY/1JPk9G+d9WngrCYp/l/QykGHYtfb8=;
 b=cX9/iJHTwmWjzafoLQeG/ruDNvV+Fx6HIMJj+jHDbpHsV98ESnNg9b4qrPikaI2iyPeB
 RIpArBE/IaWSFkZFbE8q+ToFedDCeZh8X0SONFZcT41KRcus0YIpG2/nMO5IqSbpzzFFL
 JHOXA31kDsVgs+N7Te8R96XY1sSD2tuNG76QJEZFzOH7eao6f4S/qjo6fTMGqoSuFRBrD
 2AomiAZSA7FdZ7HuLnxaWhQq/ktsh2BKOPHtVPYu1B0dJKHIzjju3CzzVVDhkr3L7x1e6
 hka5hcZpFIBkx8FawGDeW3wgad9oeiYBLHX2UwYX7ngi+uezYt/je6ZRvUaIRm5JXrQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=bfmVRKy+; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=APelsIKR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bfmVRKy+; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=APelsIKR
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A94160708
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 05:56:33 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F2loBT3281004; Tue, 15 Sep 2026 00:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=8WIeB9U6sMHiY/1JPk9G+d9WngrCYp/l/QykGHYtf
 b8=; b=bfmVRKy+H9tNyLxvseY7X02/lgMi12rooA5GYJ6v1up7yxZ+tmPXqqMaU
 bMhsczxwTgKzl7ZCH1pklM7ZzPyVqPyKSemYPIN4EOJUf/JsYT3r8kOX5cK4sL6X
 J7QkrimgxF3QO89mTUlrKGgOGJZMHPETBaPpXRnO0V7oQWjgI9Epn/vZVbeXkeMq
 rl8Yi0tLXbXhg2Rs5CEzKf6C+aJUq74nNC9JOd0sS77yjFTCHRBq8Ig9HZ0w7O8d
 lwGnC7I/M7RudTpSif3W0Bm3As9R5iJdAbCxCYnFpfoCWM/ULMZraw5NCKlD2G9K
 dQiFumMADg9dRoc8mnL1THWHlh68g==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gpvpj9a8g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 00:56:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+6/cWVlCCxHK5Hxc6ylv02Jybv7XNylN29YmKn9Qhy3tjZrPtTn/7Do4HyG5ALG6AXcO5cL0Jdefe5LON9R8Qyv2PS+qus+jI/OLhKRBiG5Ba+kYVTvYARIS+kLQMw/Egd7bMUX5/7mQG7DP07zEbzvCmny6c2LJKqP0USCurF36ekvs5PyXe+c528GiAdxZj09Dkl3oOWm5iFnnoVdkjk4lx9bq7p+LO9gdWSpW57RRQlt6/VFKv7Mxvkewpu7EalYL9ZTH0hGKwRItOh7S96rxow9hzs73lSvUHONEWf6XLbQv3nhMc7zWNsZbuDcOX+/PGrotNHUGyDeh8MgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WIeB9U6sMHiY/1JPk9G+d9WngrCYp/l/QykGHYtfb8=;
 b=mm0UiSDEe6GyQqzi2Knxagz1r7rfCDhEBsViglY4Ajf5mtnY6zXnq5FCkfDXsR3+sirnYIT+WnP4HXpmIcRosvzXLeWYBLp4IjUxm/ZVIyN2pwAmCSgbjgn76OlnNXoRzW4lTMygJuHxJPguhqi5MAeN4+5uRB1JCArWlR6fKhO1jwhHguBWVm1tw9PZhsWkiQhxg/SDHugVOzpNR8ruobB52j3QIhRVC7FhNqV3a5Wd6gTPnCfncmkUJiFppKc1duS4GX/RbVZ265la766vRmHiR6dUSCVFnN4JVN6kmYUUmT6YVSwGoU7LYQXfEO0OTXoPfAj7nZil3rYA3ZwiCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WIeB9U6sMHiY/1JPk9G+d9WngrCYp/l/QykGHYtfb8=;
 b=APelsIKR4/02NgBMhj1oJgF4pPA36jyQ30y8X80myeysUajm5PHlcDFY2utZLNrbkQImf7XwRTuAizlbTwX1/T70KQaSfjHXHUcwXGdiC+kXQjI8sR/K9OrjgsYmLTMzWCuvXRKQVhRD9J7W8tT9lq+UfcQ3Y8avCfVOSLjr25c=
Received: from YQBP288CA0037.CANP288.PROD.OUTLOOK.COM (2603:10b6:c01:9d::14)
 by PH7PR10MB6968.namprd10.prod.outlook.com (2603:10b6:510:279::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 05:56:24 +0000
Received: from BN7PEPF000000A4.namprd05.prod.outlook.com
 (2603:10b6:c01:9d:cafe::23) by YQBP288CA0037.outlook.office365.com
 (2603:10b6:c01:9d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 05:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN7PEPF000000A4.mail.protection.outlook.com (10.167.245.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 05:56:22 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 00:55:42 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 00:55:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 00:55:42 -0500
Received: from [10.24.50.206]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.206])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F5teex2640206;
 Tue, 15 Sep 2026 00:55:41 -0500
Message-ID: <d473b384-dda8-478f-acb6-686d4e50113a@ti.com>
Date: Tue, 15 Sep 2026 11:25:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] A-core no-SPL Boot Support
To: <trini@konsulko.com>, <n-francis@ti.com>, <u-boot@lists.u-boot-project.org>
References: <20260903072805.31010-1-g-praveen@ti.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20260903072805.31010-1-g-praveen@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A4:EE_|PH7PR10MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: b25a6321-8d9f-4330-b5d5-08df12ee11ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|6133799003|22082099003|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: W3KMgAg9qGF0BWVkg0v+NmEJ2FCCjaIgiCfy5H8rpxCLvBoGqTU1QUJbVx4v2f5Ib+WrYi3BLxNYhga4rPANHdvdaBBHBDsrLD5v+S7UGgCCDkx3CIrYerXL/P6aguHbYngVnZO7of5kJfkyTqxtULUzy4jaSirq/7qhShKIrNrHsMSbAtaZU2rjNly8acCwMGDqvt0Ai4pSAPv0zaA/6M/QwWbV/IBk5YOSOkkvTSNrAl/ad4s6J9sIqQDha58BSJkr1rQE9x1IzlW1vfdWo7Mj2Be4oVllsIBTWhOBFG5dc+VfjLT28Y9zQma9+boQjEGMgVAheHihuEudX4X1sgF6qpxOj1tp5cP7rsDDAjMduexye+Xw3K4GMHsKO+MNXIhRzUAWRdFZjI2Qp7vGhbhD9NoF14RQumM7dZyo3Lsf2w5JUmBY1y0FSlBLG6UHedeZbvN+M+PgNZXdFWbpE6LgtdxejkNe0FBX3yT6Yx92I9tMmwlARN2Q2vUKufFjibwilVOLYDBsngUpQ/OJ/7wkA96PN7WElbHYBz6l4tD/9QhcdHZTuoW5gljNQrjfLjXL4WBMfHOmDMjgWBIXiEHBGRGBp4ALUIug9apabRKdY8zmffzq0AdxLfsr2ZiKDUKuBWR4SAb5TNssqZeopZyJCbKNjvtELDfqTbjaz4gjjtg7S7S6sWVA2iFfShtTQJNeAjOqacuOZl0rHjAumg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9m8QhPUVcZaiDeuar5q0u2wO6ypTpf+mYdiLYcXIRuDfdTcdXz+0HQtCTudZg+A17QhB2pQVptbJU9qBAYHxQDhJFrS5BGu/NZd1V9CnJfZCunzPInZSR0+u21OWHNbaO7+f2tnwANw+hmLH9lKqs/b/LIgP8+Lef0ZN6a+hHqIol3D7/2vivLqvtjmDgEbvKhS+I5ET29B5RY4Dkm3W59EBS2Ykx9CuPM7h756WcuXcM4btNzwEXk5WBgTjqhYtAIXqiHd/rVoQKbiC0Hh96v6DEQ7/wvaJWlLM7JlhKp9PVVqN/Y9PXeeq08QXJu0bsQ4TM6+vA8+HsYJRrm0m7nhUBWfGqaHD4M9e3A+N6R116eVgeHNRU6qvVi01Vb+c9t7Q+f7LrHIAJQqSFQ2eycMZZCyA1kBePqcHh69Bo6rYH+EKDtqfhaVaE1mDi8gx
X-Exchange-RoutingPolicyChecked: P9MbgOdmjpYfNSNNS8YV9wvfsNbv4Rl8mLshI9Hf1PxROXtAD53xWrAJJqLGqhaJSg/ulnnbAe6KwiOPBSRgJYsFixQ+/AXO5uO3fdSQHQTxIH1waXcU0NhQUHERvO+vfn2Da9QoWs4dg8oF+rMZ0P1rEwI0O/lWWOt6c0VDuU+BOJlhDbhICGlNwPgIglu/mWR6IL8hfg3f6vlnmCs3nQrh47qBieO0axQ4nOYeeCzFi9zUjdpnmLakr7OmLqXG/EmmLG2+ia4TX07DGncLLOIPVOqJga83TajE+/BWJERoBWiRj33Wbe8Pfij9x0uKUNj9AzFCPWKkwKJVFx0MgQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 05:56:22.1103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25a6321-8d9f-4330-b5d5-08df12ee11ee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6968
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA4MyBTYWx0ZWRfX9TXX05+fB9oD
 GQFg58nLmwKjb5mdN69ibg4RCWQU/gkSUKfRbESoFRbzCCOnCKSLeCGHvfjm8GTm08+D8SJ125z
 I0yVLIKGdhHZcGXjuMl9ntpq7CrKxSA=
X-Authority-Analysis: v=2.4 cv=KvnYSmWN c=1 sm=1 tr=0 ts=6aa8de0f cx=c_pps
 a=/jEiNo7mPoItVXs2NspnyQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=ZT2bg7pKn1LwNrHCK5IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cSIa6iC0yJqWaLSFNNC0U-NllEsOk2n5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA4MyBTYWx0ZWRfX+ttYY1eocuO3
 cOE/j4alq925mlRBNsOct7hwT0UoyTYDowpAIDyqfiXo9b18jqj7yojEiCizJXxI1A7urPlxlyQ
 zKLww8wVStJOJrIDs7VKMZgPoYpN4ixi5ABl5WnH58Ape9XKUPaSkpQ71WZqLnCQak2X3b3TS5d
 2eZ441Zd79u+YQOnMTV/ZwtEB9JtN8xFdi8vKGS2/50T6CVZRBgWWiMjWR+ufiFwFkbiGbsfaaL
 PxqBl98mnNxRm/J3ESJYd2c3gW1vttIQV7JQ8ZvAqRmQfseg6VxnP/Nwo86W7nPB5dRffq1rJis
 665jIf0u4jlQ+jSpP0xs4rApIjJNVVFUW62z7MdB3mPYtmebpEpE9h2lkO77ypOa6nAGEL/EPLJ
 Dsjln06rdRdbsI92irp4UfuHd6zp3IEIs0qFNvqt9Mt/SdJXaxAklWnykWtGSEa+7j4ljJIytXr
 oC4BG4qlzFqAxT6d/qQ==
X-Proofpoint-GUID: cSIa6iC0yJqWaLSFNNC0U-NllEsOk2n5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150083
X-Mailman-Approved-At: Tue, 15 Sep 2026 07:43:46 +0000
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

Hi Tom,

Apologies for the reminder. Hope I have clarified your queries.

Best Regards

Gokul Praveen

On 03/09/26 12:58, Gokul Praveen wrote:
> A-Core no-SPL Mode is a boot approach that bypasses
> the A Core SPL while retaining U-Boot in the boot flow.
> This mode provides faster boot times compared to normal boot
> while maintaining U-Boot's flexibility for kernel loading
> and system configuration.
>
> v4<==> v3
> ==========
> * Updated a small info in the Documentation.
> * Updated the MAINTAINERS entry for the A-core no-SPL Boot mode config
> * fragments.
> * Link to v3: https://lore.kernel.org/all/20260819101910.39192-1-g-praveen@ti.com/
>
> v3<==> v2
> ===========
> * Updated the naming convention used from "no-spl" to "A-core no-spl" to
> * make it more specific and clear.
> * Link to v2: https://lore.kernel.org/all/20260818115322.101705-1-g-praveen@ti.com/
>
> v2<==> v1
> ===========
> * Updated the naming convention used from "semi-falcon" to "no-spl".
> * Link to v1: https://lore.kernel.org/all/20260814102153.44487-1-g-praveen@ti.com/
>
> Boot logs link :
> https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c
>
> Gokul Praveen (3):
>    configs: add A-core no-SPL mode fragment for k3 devices
>    arm: k3-binman: add tinospl.bin for direct U-Boot boot
>    doc: ti: document A Core no-SPL boot mode for J784S4 EVM
>
>   Makefile                               |   2 +-
>   arch/arm/dts/k3-binman.dtsi            |  47 ++++++++
>   arch/arm/dts/k3-j784s4-binman.dtsi     |  65 +++++++++++
>   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  14 +++
>   board/ti/j784s4/MAINTAINERS            |   2 +
>   configs/k3_a72_nospl.config            |   1 +
>   configs/k3_r5_nospl.config             |   1 +
>   doc/board/ti/j784s4_evm.rst            | 143 +++++++++++++++++++++++++
>   8 files changed, 274 insertions(+), 1 deletion(-)
>   create mode 100644 configs/k3_a72_nospl.config
>   create mode 100644 configs/k3_r5_nospl.config
>
