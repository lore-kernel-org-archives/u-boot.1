Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDBACCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E71EF80F67;
	Mon, 19 Oct 2026 10:39:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V2sbsTgHmyun; Mon, 19 Oct 2026 10:39:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A200480EF1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792406398;
	b=S7W+WWAgPHI+2w1rGbtQf42i1SXDH4CC4XcB6da+0hFRbkiKxJOksn6q2CN9XA63lRDC
	 KGhAZdM2U+4z4w5ROMlYtnfbA0Pkfx/jmA9+RgrFeqtV0CqWO8jSilrswxUnFCD/Q6kpB
	 JEmznpBx8YkrBvXXXKHzYDKNq7tOcDXnRRfS6BWhfrshxszru6hdLNvzGS3i5Md8YEcOr
	 /EgkCdlLufPRqaQK7xcMy7RrtPAzUuPibpodPwXrWMtFuiAZscOifS5hE1a+tdfKhCbH0
	 GOeLOjBSn97E0J0pYKqNuerOC991ZqOP7dK1ZAytOV1p4qa7bAmeBnZv9bJcfFEUBhw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792406398;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DKq9WM4ysvjBkUCDCenfzDeeBoXrvltCUCpATYTvEjA=;
	b=k1xwK+H4UAm1dx23bvu87x2a5OCDBrF0xIDxoFbRj1mw4ke3VUUZZyArj/V6jnoUYfME
	 SA/ZfD78X8FJE14lZwqHtw38hzYZn/XPw4MW9x7ThplL8gZmdyQj67VP/R2iWITTC9SXA
	 T6QZP1QcCen7lMbXwT+W68dw2kXCYJ3oYe9ibR+N/CbxMs4X0qx5CkxfsQm9ZT5GtugXx
	 194BEgebB7MndmPPXjDfT9VDRGJ0Inm3e5568YZjqLqT8VaWjLzxbKtdS+oFA9hzHDJ4c
	 51Q4G29r1kQ7dRmp+BfpR+zi5ScOCw+wAJBq/PnLwWReOesmxRQdiMCX+2aDK2NgQEw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792406398;
	bh=DKq9WM4ysvjBkUCDCenfzDeeBoXrvltCUCpATYTvEjA=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ccLQwZRd2ZZVg5xrJqQ2hL2Q9a5RIomCrLeikwSOJSK8nr347bYAmfqy1Msz+ZJPO
	 925fKX8avuRBlWbz5j+k7xJeQoeN/6M+OsjO0nWQSevhrvxFaxfoQMHrIxoVMZgsJd
	 OlDaaEEqlfHuclin7nxQAtgtN53HkBMfKroMTlnVvDt4YV+BeOfojP0P7Ces6Z5eBR
	 sHKrNsAsdLTAhwK+gLy/0tUAsg7CQoDmxLOYTNIMmSs6VaoL5WI+Te44C1jOcse6V1
	 XTE4RT7mcLyrsUaPjO7AEet1IRzY7CcI2i59lAuV6JM2ohvYFnujacUPDkjcFenHmv
	 +6ZNfSAEu0AxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A200480EF1;
	Mon, 19 Oct 2026 10:39:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D8B401AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA098606CF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:39:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6ozRBg668Ld for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:39:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D888960606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792406395;
 b=MDOF+w978UXqPQ5/x6JCFsW+XGFRj4DzDP465YcdIcMAag5x9DkNekk+I5Iu/12iISa9
 GS4R+u6tFYAimwhdgclQGGAK3TFJKdss2rykh/ak2zwmpjaMclQcLdgInQEFMTMqgEVJX
 m/5LfKR6P7wOxDuSLesHzpjedmkFzzhvGugOs0h7VYS0jVloEkZZuVZHHPSVoEOVw1Qf/
 UVx8PltaGyjaI5Tni9VGU5c6TlSy/Mz90eBbrSUe4qpCDjggFH/npaQc1CtO0MqBl5oCT
 ROuNz9Xp/Q0qeI/StBEHNZA4DT3zVkehTjzXMg+mqzJsVRYcVokFvf3CcL5aLORuiGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406395;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=DKq9WM4ysvjBkUCDCenfzDeeBoXrvltCUCpATYTvEjA=;
 b=CwuyNJbNXzHu7Ixi1xbOEU8/qv1v3PW78GFu5SiZ/I/MoK1b2JLF2ynJX1AiFAYzxN1q
 j0sdpV1nC8gj5F1B1qcNQw/n37VLszE6ocYniu1zol+AlMTllkvyFp7NItBEgXEguCcea
 hKNKfqZWgJU5WHogGkpJ4N3WLxTZKOMfHvYES87wfxpK4njBmnyrn9JFPIuT2Acw+pHt0
 utyShOBDQ3N10fRTn1pIO3OCO6R/f+k109a9NtaCWBn9qaFyhkz4SKjR6BSFJhF51wJvp
 WG7PjzPbGLFJm1g3IO7T0C0QlQpqFQdX+JFEzhy9PEvm9jIMevsAGppi4tTXS1gUU2w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=SIbfgfh0; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=AbRKgRzh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=SIbfgfh0; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=AbRKgRzh
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D888960606
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:39:54 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8NU4d4031187; Mon, 19 Oct 2026 05:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=DKq9WM4ysvjBk
 UCDCenfzDeeBoXrvltCUCpATYTvEjA=; b=SIbfgfh065ytr5UmiyAr4fDyTKUF5
 H2AZSGNuZbtqR+jl3i8O7fsidTt+mQ/sGUKSe3dwcXt3ThEGIjjHwCIq2jrl4+8U
 V38KMLKOJZkTm7s3JAAXUQ/PERx+H6hidrm5Ldu6rBBrZlj2sg8FC/PTBkWXQ2il
 1Xnhn2V3KWvTTEt2gsBcZyLt9DMy7BNuQH6IfpJwmNjX2aXrGf8ZS/WWJx0Ny+rB
 snI8C2Kc1KRFDB251NsGHBjuGVCbCejMou8yeuURlzLnki8beUsrvm3uG5ng/zzA
 tAGofwrxH71EBfq6g1QQYhg/6F69SRxzQ0zJQxcEGZ3wuqkaD21jsR3LA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013007.outbound.protection.outlook.com
 [40.107.201.7])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcrd5w88y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:39:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kknfrja/kLwRevzA3GznOZOzNgI0MlA/bufyZnPFOM/s6CCV6+/YMWSKhbius6OkYvkaypjZ/PNQL8NGWmiAY2qxfrS6zIoNyOxJHcgSmHjev0H0vlWyz0VNuu9vBNWFq2lUGi9mXk0m5xmH2hFIUhPgwqWRYLfWGpaTLeHwUzu/kv54S+oNayZsAt//mgpjmRBf9doy2uShn7wGEoEG6UzUVmPlFBlna7r6Tux+CbJEBQ0rVC/o+myo7cg4KkqfSPmDR2k97p8lzZyibB0ymj2zTgkovTlXI6wR4yHbzzAd8q/XVpLV6+RA8X7P6PTzWJtmkeJ0t3bJCqiD3q9zHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKq9WM4ysvjBkUCDCenfzDeeBoXrvltCUCpATYTvEjA=;
 b=gw9P89KmH7ghR6HeCbXxQNqu2V9kYAulTCcB01k8PT11t3s7U9tCaLGIdJo9StWpC7z8q6HmJkOPx53qLXfyp0XxWQAeSHeOXNSWQJHwsp2cB0qhcC6+68PI+V4FeO0m55UiX2w77OqUl5yhnWYCmjx7J5gz9Ft++pmgmX47SxuBBEC0M6ftzMiyek5eBSFAAL7rC0Vmjpv3Y4Zg+/u/3z6/qmGW6arAaIS44qo7Cq7w7i/VImuOlYT3l8fnjO2HgJ74/xNlMFL7F/LOjovPQYpRC66JkVBYe9nXPOtFPBFvCavMTrt9zBsHXBWd4NENTYdRj/nCGngDpl2F8kqQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKq9WM4ysvjBkUCDCenfzDeeBoXrvltCUCpATYTvEjA=;
 b=AbRKgRzhhEWvA5HV2ggcvLYcuGB1epjUbMr1UGT1JwbR/MZzDXZ4WMAJlq6sjDZXO6+BiHbUAW+4c7LNRwtKc7PrxIEjdMopHjtOxXtrKm0+AUni2U63x/QfCePe8hKxNkgFzwgBNEmsoCyLzdP1eBg1kMA2XYiykthRNBR5AXg=
Received: from SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::35)
 by CO1PR10MB4738.namprd10.prod.outlook.com (2603:10b6:303:93::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 10:39:48 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::80) by SJ0P220CA0019.outlook.office365.com
 (2603:10b6:a03:41b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 10:39:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 10:39:47 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:39:47 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:39:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 05:39:46 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 69JAdgTg2629975; Mon, 19 Oct 2026 05:39:43 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v8 0/7] Add support to boot TI K3 HSM M4 core
Date: Mon, 19 Oct 2026 16:09:35 +0530
Message-ID: <20261019103942.2497201-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|CO1PR10MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: ee353e8f-3be0-45c1-5d64-08df2dcd4c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|6133799003|18002099003|10067099003|13003099007|261009220027099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: uBLUctNKLPOKVs+prEgxqnOG0wIAwmkEPAL87A1e2iaj2oNRsYKS1IUtei4Q5kC0fHQr+f/pLMgl7tBAOGUQGHGRN7AoLrAKn5ojcRWoq21YakYEwO/XV1h9APzEIOhN6yh7NbtynT6tU4B2nOB8V+a2jPu+HzBOhjmBNZw3A37WcD47+H0kxv5+89ioI0ZsK/lLUxKb1LpAyAbgF2DVI/EO81f0yuuk+uI+d7hTatmHPW53otQ4P1GpdF3oaZ+PCx9PPvmnd8a1LHeQfFD2SiFHwSndBqyv59vJTLsD12s7eldGxkdRievmJ9Gf4HigEDF7CI464kT52G3L3XvJvcnrmBM2IpBNewwra4bvTzHspNrtdj8NJKZH5GHWjx8ex0r9uqzKjn94Pq/AfShrv5h85tk5QL+4fjO+miHpaqqD7ios3aE8tZbKVMoLB0/ZDaDnyXHGkoJFUl0Q4IZ0f/zcpFBDFlz8IpwjyDriu/Lb2Mh8L2a8m+FVEM7o3dU4BtLGMKluouXsif81VZVuaMHNQT03yLsXzXDbJPIgDF5oK1LCzTCjDR2JmqqzmJExUaABBy7MMrDAGYPO+MQEjCJTYosdTAM1mjhyGX+CfOY/4df2QNX1fwhjLb+w6uuNhlcs8oFtc6aU92KxCtCVEg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(6133799003)(18002099003)(10067099003)(13003099007)(261009220027099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8yfybBdnAheD0AYaDvFUEBiyFPON6Qfr1t86oy9oFP7sakqlwNvRGZXeMWl+C8nS8AoV5nNb6u+u454w4VA1rItcY7hx5/gdJT+ljwvBX5Sc8lQPaEvbkS/xjZqPpOfkFNE6M3QECtYxOUQNR/RXTBhwBMYIpQCeUpCz0pcDa+Lp+wJ3dg7+ZBuesdFJZdEOJA4/mQUVv1CYoYp9FpL+/h9XX0XKLQ0Cuh3qOCf96+LSMF/GuTMlOQbmqHSGbEP3v6kZf8Xspyp9mAXp/IV4mSpcL1qPH1qFMZwHlhE9tz7hqwOjfsecdT2YbWZuS4Rh23ERdet4277xrBf1vQ5TLUAMtyfN7sNBoV7rWsGAWojUMw5MVIOKsgObOvbUMg0+zDQjm/gYu5AP4qkRTGOLKiTBJvMRwRFcYClx8JdFa2KnN505nXtilpx5dL5+B/hK
X-Exchange-RoutingPolicyChecked: YzwuqFcLR6+4fEMuzeYSn4OXC5scoAtVCVC0eqHiiXxoeqZpGo1pQHBXTT1x0grADbSatRQt88YeS342BzK/MDxNc3UfAVQL7dzRybTZEpme1Cs3pxMxkAl2pJ67q1t8nUYzBCedAuidKvkm5P/Jz+aSTFZ9nPTpb8AU2Ro0Jm7+WbiWCru1XrwTRnH/kPLF4cFZcdejI9LjUuipIodZ5N+3++krIdSSdHITI6WgMM53EjaA0MddKWjkCQVRMA35zEIBEx7lys4ejUFqCPqjlkdKAM7eQKAkE5TB3/+RIqdH8d2A0e4+TeI+TgEq1YgcmsosNejqZ6CWZH9DSYmx+g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:39:47.9983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee353e8f-3be0-45c1-5d64-08df2dcd4c49
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4738
X-Proofpoint-ORIG-GUID: pNi8G8BY1T65ZhqsUhnpaCYhVhhxU8qo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX6XCGE/HyPY59
 4V+HmWE5QnaoBkdsGDmx1Do94u7lZsRdj6oVWfxlsq6+MmyeJYQUxnfh83TqcfHXPplg7Qw8DJY
 LMS/n6ayqFaHH0YeXjgUn70S/axE2qB9w+P9WJYkopUaYN7FBoCkpgn/mE0efiVVfNubUgw5NlJ
 q4m37D3Wtz0ydtuHPnWPi5HqO0thtN15yVnrMtGKNiAbywhoc+Qs8nrpXlXIJ9IURpcwHJc+dw1
 F8pub2e9J5/JADQ47LIxOEZRkD2TSRyb/ojEIFG5qIstHvIz71O1n5ENZe3dqXozOhavQAz1DT3
 lh4XvQTAyztVpvKMY17AX81PFZLcAxl8aD7LtOdNOuboF0M6tXrF9JqCPYvmRIX80qTKMWH2hFJ
 /rbWnIXoy9yeLRvrXSujCNicM/Lmo58jBIlzDjXLxVA/1O2t5GUn1L9hR1TFFpKt7RvB+MyWd4x
 Za63mSGMhdr7d3jGxuw==
X-Authority-Analysis: v=2.4 cv=ReYFmFtv c=1 sm=1 tr=0 ts=6ad5f377 cx=c_pps
 a=/vhbQW8ajZ2wERCzDUYoLQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=voM4FWlXAAAA:8
 a=NEAV23lmAAAA:8 a=x0v_tFf1iXXrK4k0_x4A:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: pNi8G8BY1T65ZhqsUhnpaCYhVhhxU8qo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfXx8AcAyV5owdd
 PCnyZOfG7yAw8N/wqsUeqNg3s6dioRBnRhZna19nVewj597M7Qd3dUJNkalen+de3iPrF9GU2HH
 Wd5He7bw+ZSis1olYgKO0ihwMJQHybg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
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

Some TI K3 SoCs like J721S2, J784S4, and J722S have a HSM (High Security
Module) M4F core in the Wakeup Voltage Domain which could be used to
run secure services like Authentication. Boot flow for HSM M4 core is
different than the general purpose M4F cores, and is as below:

1. Request control of HSM M4F remote processor.
2. Assert Reset on the HSM M4F remote processor.
3. Request Secure Entity to Authenticate and Load HSM firmware into
   core's internal SRAM memory region. For GP device, load the firmware
   manually into core's SRAM region.
4. Deassert Reset on the HSM M4F remote processor.
5. Release control of HSM M4F remote processor.

This series adds support to boot HSM M4 core from R5 SPL stage. The HSM
firmware is packed inside the tispl.bin fit image. The firmware is
unpacked into a temporary DDR address which is then used to load HSM
core. The configs to boot HSM M4 core are disabled by default.

Additional documentation on HSM M4 core usage:
https://software-dl.ti.com/jacinto7/esd/processor-sdk-linux-j784s4/latest/exports/docs/linux/Foundational_Components/U-Boot/UG-HSM.html

v8: Changelog:
[Tom]:
 1. Initialize boot_ext and load_ext to None in Entry_x509_cert to fix
    pylint errors.

Link to v7:
https://lore.kernel.org/all/20260922084536.2477291-1-b-padhi@ti.com/

v7: Changelog:
[Udit]:
 1. Update docs to include HSM loading section in applicable board
    specific files.
[Neha]:
 1. Post to new U-Boot mailing list.
[General]:
 1. Collect R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/cover/20260831083347.1168880-1-b-padhi@ti.com/

v6: Changelog:
[Bryan]:
 1. Rebase on upstream main branch.
 2. Drop [PATCH v5 1/7] as existing fix is already available in main.
 3. Add documentation about enabling and booting HSM core in
    doc/board/ti/k3.rst.

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-1-b-padhi@ti.com/

v5: Changelog:
[Simon]:
 1. Add 'depends on SOC_K3_J721S2 || SOC_K3_J784S4 || SOC_K3_J722S' for
    KConfig options.
 2. Use hyphens in DT property names and underscores in python code.
 3. Add comments to explain DT property values and link to ti-sci
    documentation
 4. Use lower-case hex for DT property values.
 5. Use consistent whitespaces.
 6. Add property documentation in function docstring.
 7. Log missing properties for boot and load extension groups.
 8. Update tests to check the load and boot sections contain the
    expected values from test DTS. Add negative tests to check it raises
    an error when some of the properties are missing.
 9. Driver improvements: Size check before memcpy(), type-casting, and
    checking device type via get_device_type().
 10. Invoke ti_secure_image_post_process() only once for HSM images.
[General]:
 1. Explicitly mention the load address of the HSM image in the FIT.
    Don't rely on U-Boot to assign a fallback load address. Use a
    Kconfig option to specify the HSM load address.
 2. Pick up R/B tags from Neha and Simon.
 3. Squash various patches together as they are atomic.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-1-b-padhi@ti.com/

v4: Changelog:
Re-spinning after Device Tree Syncup happened from Linux to U-Boot.
[Andrew]:
  1. Reworded commit message on [PATCH v4 03/11].
[Simon]:
  1. Add a binman test for the boot & load extensions in certificate in
     [PATCH v4 08/11].
General:
  1. Drop J722S defconfig changes out of this series. Will be
     posted/discussed separately.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-1-b-padhi@ti.com/

v3: Changelog:
[Andrew]:
 1. Added dedicated remoteproc driver for booting HSM core.
 2. Added support for signing HSM firmware images in U-Boot. [Anshul]
General:
 1. Add support for booting HSM on J722S SoC as well.

Link to v2:
http://lore.kernel.org/all/20250506104202.16741-1-b-padhi@ti.com/

v2: Changelog:
[Andrew]:
 1. Added support in SPL to load FIT images with no 'load' property.
 2. Removed 'default = n' in CONFIG option.
 3. Used __maybe_unused to decrease preprocessing.
 4. Better error messages with error code. 
[Udit]:
 1. Added 'HSM' entries in enum at the last.
 2. Added error condition in if-elseif-else ladder.
 3. Hang System boot when HSM failed to boot properly.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-1-b-padhi@ti.com/

Testing done:
1. Tested HSM boot across GP, HS-FS, HS-SE device types for J721S2,
J784S4 and J722S SoCs.

Logs after enabling HSM boot configs:
https://gist.github.com/3V3RYONE/ad33683652c8c49e4fedab49f0493e79

Beleswar Padhi (7):
  arm: mach-k3: Add config options for packaging HSM firmware
  arm: dts: k3-{j721s2/j722s/j784s4}-binman: Add template for packing
    HSM firmware
  binman: openssl: Add boot and load extensions to x509 cert
  arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable HSM core
  remoteproc: k3-hsm: Introduce a remoteproc driver for K3 HSM core
  arm: mach-k3: r5: common: Invoke boot of HSM M4 core
  doc: board: ti: k3: Add section for HSM M4F core loading

 MAINTAINERS                                   |   1 +
 arch/arm/dts/k3-binman.dtsi                   |  26 ++
 arch/arm/dts/k3-j721s2-binman.dtsi            |  12 +
 arch/arm/dts/k3-j721s2-r5.dtsi                |  10 +
 arch/arm/dts/k3-j722s-binman.dtsi             |  12 +
 arch/arm/dts/k3-j722s-r5.dtsi                 |  10 +
 arch/arm/dts/k3-j784s4-binman.dtsi            |  12 +
 arch/arm/dts/k3-j784s4-r5.dtsi                |   9 +
 arch/arm/mach-k3/Kconfig                      |  16 ++
 arch/arm/mach-k3/r5/common.c                  |  29 +-
 doc/board/ti/j721s2_evm.rst                   |   7 +
 doc/board/ti/j784s4_evm.rst                   |   7 +
 doc/board/ti/k3.rst                           | 136 +++++++++
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/ti_k3_hsm_rproc.c          | 268 ++++++++++++++++++
 tools/binman/btool/openssl.py                 |  49 +++-
 tools/binman/etype/ti_secure.py               |  65 +++++
 tools/binman/etype/x509_cert.py               |   6 +-
 tools/binman/ftest.py                         |  45 +++
 .../test/vendor/ti_secure_boot_load_ext.dts   |  23 ++
 .../ti_secure_boot_load_ext_partial.dts       |  20 ++
 22 files changed, 765 insertions(+), 9 deletions(-)
 create mode 100644 drivers/remoteproc/ti_k3_hsm_rproc.c
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext.dts
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts

-- 
2.34.1

