Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36575C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 12:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D890C60B8F;
	Thu,  3 Sep 2026 12:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SYNLPmU4MYMa; Thu,  3 Sep 2026 12:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AE92E60B68
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788439872;
	b=UCCstgK0x7nRhNxvWO2AuY7tKaiCK6d7a6ODz9z1ZWOGsrCmFDS+wnBvFyAOkFzINLDn
	 Zng/ICKSnY1GzqbM+C2wucfE38jJaAajeMVzLIbdCRLYQ4jsvRL4YQQ3hhBWkLxRnlh7v
	 EJWP5blPa2Q7+BJ2hhTZI71use87mhjKBFumX+lg3xa6sSW8YUhFnXasq+clsGOt38iO7
	 Tz975+95E+dqpgMmk4KLj8yGZDorjclBi3BqE8DlJsbfyKLHwvaKgLhIPxjDTsXqU6SIF
	 VDRTG2djs8t/ZWmDpCKtYAyDK9dnw4W5jstkYkQ/9gihxUNyFhTUvew8MEUQjrgd3Og==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788439872;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VUQkC7yHhTYPeRP+RQo4EoaqqM/1p4XN7Kq165mNlK8=;
	b=b+fyJU+la8CRRgmnq4Qk4+nFAdj/7KcXaIan3MVMqNUaw01RmFpyXtXUs7AwFfMrmlCK
	 SwSp0WMYJxGa+SdIxdtm4bgtHXDdZ2rDxeCrZOJMz0o6949dtp9obHJaAr9DSrbOLRJpT
	 UXXbPCvKgyolzVP5ShF4Y88T76KjFjYej5m27R/GI+biQhEXnA1o1k+a7E4IyyOBF8AjQ
	 +V0/EDLoXoUymkEu9KRfpN+8dy9XT2Oizzw6b5GbQUrjXpP+1kljNXTNNVSHM8RQ5EVz/
	 rFClmB4jMrq89cq3oW/PDKn5YLsKRINxmeK14O4A3RXRkfaJhsL+r+zkjAC721E48gg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b="Lm54/oFP";
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=SVo+U4IN;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788439872;
	bh=VUQkC7yHhTYPeRP+RQo4EoaqqM/1p4XN7Kq165mNlK8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y6FJYmW8EqWcID8cszYgcO8ZQ7qoKiiKCcerOwYFJA9viRqPafJvuimaWDuWGvAWL
	 IcFqiS10yX0alDoDC08zyIEZt25FGEEjiOgVjFll4UmT8wGylW/zrxhk9k/YLVVYEv
	 s4AT19977WhLOI1RLHAWD2p1XEloH7u+hcEbZr575NdDo1ZhIYQzGgsiIzTyC3QXQW
	 Haq3O4IHvCk0TA6oMEOYqMWnsXRiqdYGqc2ZOsEyjVZVWuAb7SC+S+9GWwWIKsBgWo
	 AapDV3cRZsBFkm5gyHhc3FAWjxkGqsu2ZTB/AdyUbp1hBgSsP0KDekmCib6TYCuA6O
	 iEy1fgU9zvF9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE92E60B68;
	Thu,  3 Sep 2026 12:51:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 882A0498
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78CB46089A
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:28:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G38la6mFBRu5 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 07:28:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7B56560886
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788420513;
 b=QaIyQOs10O6BFWRJRuBHrkAIXhcVUshYo7+YERSxLKf+Soki+9lUU+cSpdaNjznLRElU
 mnMp62qBJnUs49qdEartTfe7972VaYweCKDLnCUiB+jrWpm92W4jhazTNibMepzXxVSVX
 q4xg3QnBlXl97z0GrGqruLHzJ8sxRXd0e/o8+z9qfKKHln3qjj6tyszYM+icF7ilP0giO
 00ScyW3+vLgno+lSKTG/Y2dkbgIqnwlbu119UNhlrHN1OxWMZL1cfCowPlWAS1n340/V2
 pwpyO0BmyQnKk2v+//cZPXNajXxU/kyadZBa+C252KG1hEB4S4NjsnslSX97O5h6AmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788420513;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:Subject:Date:
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
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VUQkC7yHhTYPeRP+RQo4EoaqqM/1p4XN7Kq165mNlK8=;
 b=RcRJOqyBxYKxBsAsFyMzB+GKPXloQurb6sLYapthXubamhvdeymZW7/xlauYScrIboEX
 aaWiWRBuNxVS4f5Fk4TMT4nfMCoeCt3a1plJLQ4VoWRNPwzFMprzTNyO0GoTgKjvsZKzJ
 ks2369TFlC3nLJ5PLgZ5pg4InvowlSyDOZorMoxt2A9JY0tB/nF5SPApJnIXR4BkIFiFE
 TBnyfDHJbCNnySSqtTHTKsKYTSm1/27tTGuQ6qxTGMbRnmyJMqICSy6feCAEbuGSPzfo4
 RLpOVvNhd3lueLtTcBY6kS0/rwdQKjgvJPSJ/7xYX+oEkfBxrm2BOSwwVRhBdyAL3GQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b="Lm54/oFP"; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=SVo+U4IN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Lm54/oFP; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=SVo+U4IN
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B56560886
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:28:32 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6835j5OF2921639;
 Thu, 3 Sep 2026 02:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=VUQkC7yHhTYPeRP+RQo4EoaqqM/1p4XN7Kq165mNl
 K8=; b=Lm54/oFPJWV6n3W8VZPlDzj6iM1umEb9X8nS1HYhgTGT3kneNpQyMczv3
 Z/cD3/EujYR7gkCMr/CK5DTZBjNXeJhe3ekpJlr6UjDZEwONls9g+QKEaAuZ7Ij6
 5X9RxwSekMPDylaaw4/zu7/lWAbHIBSXynShvHa+wssogGE/t0k2ibvnKjqFA68j
 5iARRNATL1Nzwp4SXeKcW+ELRuGfUGLIyWzrAqMlvI463T1vCNsewAo5Vcsm98ru
 1kceYCOfLkPkFt7VT3tJ09HwNet5nUbPS4r8qEoYewhOOmU8DFU9JaJSrAK9X3sL
 UnaYyYel9ykw24k5oSkR+8wRvGDaA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010071.outbound.protection.outlook.com
 [52.101.193.71])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gf0jv1ayq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 02:28:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3+vSQcsVA6TNWxS+GjR8PA4rKtcAPvAsMxlBs/I9DIkMHPEDmzhDqChZgWqNPgzCjyRJU3HD6FN9vAeCOus8ZTcFqwiz53XNyYDb4veEHfBCDTyWwZYfHNjmuao7rTh8IOWSwew60bneVRKjS7MOv3oHXSbe4TcSV45AFdtX1wWNyE4jjCPzfThTPWTi6T6Bz8Jhje/T2hyhzZO5SNt5/ZLfO8eNXbQ9B9VXqJCmK5O5sGxYOrubshJLe+FcxyJ8nmDhyla7pcbz/vi5n4EH0jwQPDZMXkC4vfG5evEjkNHHd5CPtWm8zbL13OpruKg9KRUWTHVpjNPWyuXetXuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUQkC7yHhTYPeRP+RQo4EoaqqM/1p4XN7Kq165mNlK8=;
 b=J25J9Nn/JlDrIExDhVxFl9Ve4XtaJ5fx1Jl5pkRvTo8pwUnO5Mn9LfM1msLglE7NWWM5FBAj0okRcO2JmpYvNA29dcA0rexwPsu19mlibhhM6G8V1BDzCSB8J88ZwIKD8a2nVbRtvf7ChN9hTSzyWCLVcVZ6ts1MjY2e7AY6nU8GnOKoOROl8RPFNRa6EW8KOBgpUUQVqubLSAfMAg14uwPaPkddGneqWngym5hxFyDGFRWWz3EF+Z4ISwYEEnnlFZrU3b6O5XnpUnQk/OBZZG/P4GVt4JB8qoEdOFAP3ndBMykMxHuEvbL3vU2YIRsZOksAB60/b7khqqpeOfqAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUQkC7yHhTYPeRP+RQo4EoaqqM/1p4XN7Kq165mNlK8=;
 b=SVo+U4INRqRCNKHNDnqb0W1FCeX4tWj09Rv861lyewUs1OXAJcgrDhcgVLgqOTr3VfwtE1texOrYdfbAmVr0kuaR+58a8VK/nN/i9WuDDShEuYxFHFo5GZCEw+i123g9fGZNCmJlL6qbbMNXzRV2mKKfXwFoyzxJEmCY1n5O6to=
Received: from DS7PR06CA0052.namprd06.prod.outlook.com (2603:10b6:8:54::30) by
 BLAPR10MB4929.namprd10.prod.outlook.com (2603:10b6:208:324::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 07:28:26 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::19) by DS7PR06CA0052.outlook.office365.com
 (2603:10b6:8:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 07:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 07:28:25 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 02:28:24 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 02:28:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 02:28:24 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.51.66])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6837SBAT1110504;
 Thu, 3 Sep 2026 02:28:22 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v4 3/3] doc: ti: document A Core no-SPL boot mode for J784S4
 EVM
Date: Thu, 3 Sep 2026 12:58:05 +0530
Message-ID: <20260903072805.31010-4-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903072805.31010-1-g-praveen@ti.com>
References: <20260903072805.31010-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|BLAPR10MB4929:EE_
X-MS-Office365-Filtering-Correlation-Id: 5475a039-8835-43ee-1e24-08df098cf0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|6133799003|22082099003|18002099003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: ldL6pyUkgh/gYX+jIffnMmOBOh3rzb0Ls0ArRzN94e1bdyZ7dbfvFA8JWYO/iIp2DAFfj2DcnYpHRTB7qqMVLhpEeEyWoMJMsCmd9bGfCUt9knA0yMQ7OLzMdG0gnDgqtn5cNYAJ3u6LDapBxnMIAv1vgu5Aq9FcGr8G2YWT7dYx3EYDbVuaQeML3fKbdUX0awLXJnkFY3lqSg5mC1e6kdIrHOP2IEMBAfR/I3L7bN25X3w7RTgJmUM1cV3B3TkX6TxL7XnpzwFmBJRnmiObzYuIGwR/gIFCdy5hQPv8neL6Vo/0ZKvZfiOOP5IDtugUbgmjLu13CP235JPE4svhYlD7q8RsIAZIaYBFnRXbb/hwaPaBt5m14AerKA37SbOOjG+sNsfuMQNedHdkF3OvbM/mp8e+R2HnkuzaoDZ0wIW+MWcpeOCDUWa95kA1r6KEB67CTV56bz04i9d1CTd7mTRtaRY4yPiZn/IzT59mokMfRWqOH/Abfh8WKiYNTJMPZNFFSl/kwq1R91rj88Ip6R4xfMj3mh2xrUcxN94x/IYZrcsbzgA51ekpd/IHBvhxow+oKqeljhdZreOPt18CbbfA1Ba4DdYZJF0H4YlUQ2XoIW7BKe1Lm0gKXWmr02/LF+a5HEn7wL4PQTAz+h76JS2cYxjHFbHlDNLxFlSx3Xp38x3vYR9vfKCXo82o6UdU9QUKCEOxZRUHVW7XO8XZWQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: loS04oql/KS0jToFhttWIjsYQIJk7WKPh95UBHxaH8p1evtaqe44pjfRY3V5Vjs9/XCTEIMBAFIwHLTYoldn8d7T/zLqlLS3HPgaBA2K6ruQEiO12N3MUnp5C6u+APumYLC2yBO8io9TOlCP1raH2k5bAJktHOgVdV0a6/5qIyT72/n++gEcT7dIavlhPsZ4bMUPfSimvOiTq9Xqj1fPD2loVC++kdz9Kv8LsZl8dnyGVDSBrVrlsKgwjwF0Ra8UFoLpp8p2JZ9z/nloDUs6KBFsKYWxGz9rzPLrFCOHHJfCWAEOI44TPblov8wtyGsiOJupQXA7XVnv/LyCWGEtiW5NoEN617Yr5najUYo3Wzb6o3Sqa+2MQRvZpqXHNPGzP+5E1usHG+SCoxyvypM/jWqNLH0yPKfgS4HhOPZc1RmiaiqjONUkv0ZcEFeCEY5S
X-Exchange-RoutingPolicyChecked: I2PY5ML6Xk5wZaULrUHj6MD/PYbBPLkGOzdi2s/YJDr8Ip52sTVpLNuYxFWqNhYj7Iuyp4nailrO/dNDixwKVWn8xBTcfB071I4xrC6dB8YmWK0oOM1WofvvIaKi1Obn4lR04VUfmUOLAXyKQRTMp9+3zuM5iPi22ds/XzVn3BKL3BRJpIXYXeWsGzBM0T/32dGloIyNjOn2FxYyJ9XOE5PAzG4iSM65D4JMSgGNTSxovhuJiGtguQ30jYiAOW+bL8H8+j4Zafxg/uucY0vQnSwFnPOVoZWF6QlxM5bBA8kQvPiDc+I7zM7uVvM8kUtTLZ7m6u/84aI7qhXOIBcf+w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 07:28:25.0659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5475a039-8835-43ee-1e24-08df098cf0e7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2NSBTYWx0ZWRfX4BB1Z5v7Ce4H
 LFYBl+r6dZu+AeeXYjNTQt+Ct+CxZLu3TFdFbH2++imURM48VpzsbNUjJy78YQFMxeiu5KE27oN
 MqLNo+J0UUQtlb9Ksvb2lHrqtmXYEnU=
X-Authority-Analysis: v=2.4 cv=J6eaKgnS c=1 sm=1 tr=0 ts=6a99219d cx=c_pps
 a=/fsfGrOPy16csppsbskbtg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=tlSJXLxGV86A4UsorCoA:9
X-Proofpoint-GUID: g0nl0V7m8CHzmdno_4c1iecIt8eYzOEB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2NSBTYWx0ZWRfXyjWb74NSILGP
 hrrdzlxy5uLg1ElInPpy+EfQ3jcF/MMGiQ+ev+/mdTZBYUTH7RrxbYSibTmp9Tm59rJIuyErlVq
 TaCeeg/7nBkqal6OMuvIACKm/GrZa/h3/s4IRp8nRSZENJm7uvQgf+NTfRfpkRzrjnmgjKEIPMR
 bciR8AD3ZbNKKwHV+iRMH0U2DYf40UKFoaXTOci6it1XD+EdJw7POtr8xLjXpQzQps3u8Rh93Li
 AcmFGbCygjPNbgNdsZBxlnHHOuS8L1yFKEbTGhEAh+3T7BAjHxVU22Pl7K7QXl4lXJ5NLj17SiL
 w0cSRgu5SDTBiyrTlv45T4ijAIrTgXwFGr3pn6m75l0CWeWqKdEYWcoko7y7nx5SFPx+isR7nLj
 u2OPhjEDUIPJzo3ZCW7Tu1In2tOknvPQT1BryK0l7zIw3kOwBSWGnNrF/a6zh58BBRa73KmJIYD
 oQOgyip7p58EjHWSnkg==
X-Proofpoint-ORIG-GUID: g0nl0V7m8CHzmdno_4c1iecIt8eYzOEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030065
X-Mailman-Approved-At: Thu, 03 Sep 2026 12:50:58 +0000
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

This patch adds user documentation for the A Core no-SPL boot mode
on J784S4 EVM, where R5 SPL directly loads U-Boot proper, bypassing
the A Core SPL stage.

The documentation covers the boot flow, build steps, and usage
instructions for this boot mode using tinospl.bin.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
 doc/board/ti/j784s4_evm.rst | 143 ++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index ec82228ab90..c3574cbdb1e 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -637,6 +637,149 @@ to the J784S4 endpoint:
 This program copies the boot image to the PCIe endpoint's memory region and
 writes the necessary control words to signal image transfer completion.
 
+A-Core No-SPL Boot Mode
+----------------
+
+A-Core No-SPL Boot Mode on J784S4 platforms is a boot approach that bypasses
+the A72 SPL while retaining U-Boot in the boot flow. This mode provides faster
+boot times compared to normal boot while maintaining U-Boot's flexibility for
+kernel loading and system configuration.
+
+**Key differences from Normal Boot:**
+
+* Skips A72 SPL execution
+* U-Boot binary included in tinospl.bin alongside TFA, OP-TEE, and DM
+* U-Boot loads at CONFIG_TEXT_BASE=0x80080000 (A72 SPL's earlier load location)
+
+Boot Flow
+^^^^^^^^^
+
+**Normal boot flow:**
+
+.. code-block::
+
+             | tiboot3.bin |         tispl.bin          | u-boot.img |  Image  |
+             |-------------+----------------------------+------------+---------|
+    R5 Core  |    SPL      |                            |            |         |
+    ---------|       \     |                            |            |         |
+    A72 Core |        ------> TFA -> OP-TEE -> A72 SPL -->  U-Boot  --> Kernel |
+
+**With  A-Core no-SPL boot mode:**
+
+.. code-block::
+
+             | tiboot3.bin |        tinospl.bin          |  Image  |
+             |-------------+-----------------------------+---------|
+    R5 Core  |    SPL      |                             |         |
+    ---------|       \     |                             |         |
+    A72 Core |        ------>  TFA -> OP-TEE -> U-Boot  --> Kernel |
+
+Build Process
+^^^^^^^^^^^^^
+
+Enabling A-Core no-SPL boot mode requires re-building U-Boot as follows:
+
+0. Setup environment variables:
+"""""""""""""""""""""""""""""""
+
+Refer to the build procedure above for setting up the environment variables.
+
+1. U-Boot:
+""""""""""
+
+* **1.1 R5:**
+
+.. prompt:: bash $
+
+ # use the no-SPL config fragment for K3 platforms
+ export UBOOT_NOSPL_CFG_FRAGMENTR="k3_r5_nospl.config"
+ export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} ${UBOOT_NOSPL_CFG_FRAGMENTR}"
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* **1.2 A72:**
+
+.. prompt:: bash $
+
+ # use the no-SPL config fragment for A72
+ export UBOOT_NOSPL_CFG_FRAGMENTA="k3_a72_nospl.config"
+ export UBOOT_CFG_CORTEXA="${UBOOT_CFG_CORTEXA} ${UBOOT_NOSPL_CFG_FRAGMENTA}"
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+
+.. note::
+
+    The ``tinospl.bin`` file is automatically generated by binman during
+    the A72 U-Boot build process. This binary contains TFA, OP-TEE, DM, and
+    the U-Boot binary with its device tree.
+
+Usage
+^^^^^
+
+A-Core No-SPL Boot Mode uses a specialized binary called ``tinospl.bin`` which
+contains all necessary components to boot directly to U-Boot without loading
+the A72 SPL.
+
+**tinospl.bin structure:**
+
+The tinospl.bin is a FIT image containing:
+
+* **ATF (ARM Trusted Firmware)** - loaded at CONFIG_K3_ATF_LOAD_ADDR
+* **OP-TEE** - loaded at CONFIG_K3_OPTEE_LOAD_ADDR
+* **DM (Device Manager)** - loaded at 0x89000000
+* **U-Boot** - loaded at CONFIG_TEXT_BASE (0x80080000)
+* **DTB (Device Tree Blob)** - U-Boot device tree
+
+The R5 SPL requires both ``tiboot3.bin`` and ``tinospl.bin`` to be present
+in the boot partition (first partition) of the MMC device. By default, the SD
+card boot partition is used (``mmcdev=1``). The ``bootpart`` environment variable
+defaults to 1:2, specifying the second partition of the SD card.
+
+To use eMMC instead of SD as the boot media, rebuild the R5 SPL with the
+following diff:
+
+.. code-block:: diff
+
+    diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
+    index 82b9f0741bb..73d59ac425c 100644
+    --- a/board/ti/j784s4/j784s4.env
+    +++ b/board/ti/j784s4/j784s4.env
+    @@ -17,8 +17,8 @@ run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+     boot_targets=mmc1 mmc0 usb pxe dhcp
+     boot=mmc
+    -mmcdev=1
+    -bootpart=1:2
+    +mmcdev=0
+    +bootpart=0:2
+     bootdir=/boot
+     rd_spec=-
+
+**List of files required on SD/eMMC for A-Core No-SPL Boot Mode:**
+
+.. list-table::
+   :widths: 10 15 10 25
+   :header-rows: 1
+
+   * - File
+     - Copy path on SD/eMMC
+     - Partition
+     - Description
+
+   * - ``tiboot3.bin``
+     - Boot partition (raw)
+     - 1st partition (FAT32)
+     - R5 SPL binary
+
+   * - ``tinospl.bin``
+     - Boot partition (raw)
+     - 1st partition (FAT32)
+     - Combined binary with TFA, OP-TEE, DM, and U-Boot
+
 Debugging U-Boot
 ----------------
 
-- 
2.34.1

