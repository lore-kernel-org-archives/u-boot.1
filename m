Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAD606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NsR/9TRt;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=QYnHcePv;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Iy008Zyv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6566860A80;
	Thu, 29 Oct 2026 17:42:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CTa2EBY6zIPi; Thu, 29 Oct 2026 17:42:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5DD8360A6F
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793295741;
	b=ZpE5fTsxCZkV9X1Y8V36VtQbjZ4epJ6N1siEj2dXtQha4790ocnmN+9RtRCpgcdrstEj
	 h9ikMDFKQFc50m3EFpTCgGv/HkLb1/d/yCRidFQqBfMMba+BBftaFAbK9uVTWAaO9Obvq
	 RNEEnVc1QonWwrvGMa/qF0R70By5pk7kgZ4kx6trdRoB8n7culBOgCAWYJBQGVuDA9DYf
	 yT+e41VFHMcaP3rzTaFUBJ7ksoZNSVfiCH/3Ouxn3N6PtrMr9b0gmcpJptWT2+tOA7Xi2
	 UgNfFJs5jYVtqvDbjYQk8uXAi/hhzrJORhS2NoZjCNz10V6quZSAgCGkr7Jbuprv2Eg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295741;
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
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l8iIdKElR2jYbEK2E3HK6/adXl7YBtMc8p9hfYKou2c=;
	b=em0NXPeAtk+6mxHsEEViQruFPacvABfaVfDBPXsW9eKDxoxhNIyzCxkBiSSGRx+zFHxW
	 NzYmULXn80tx79trBDRYuzVIM5bpVshp+7e/WDIiYiJLnaiTiyYypYJ/QyMkIRNPxTG0Y
	 XoSFtETgWT6FrMizmGlWPIoWwGBeYiAiFcpSpabbvxesUUvEYnXdpwDOOqhkLxA4BDmZs
	 /xo9/JlzjqDcLzR389PJUcd6XWX0PPyTiQ/eOL5LNJEml0HVhLIV5Rnt/m86u2O2CBojW
	 kA5zb24XF0sA1Vq25fpMz28LdwM/XfiAtQVf3F0/V/C/BNXvafj5mRmoDchsqc5ShUg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295741;
	bh=l8iIdKElR2jYbEK2E3HK6/adXl7YBtMc8p9hfYKou2c=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NsR/9TRtqqQrLlYzSj1OuB9V4ee8RE815OT4VgewtpKEG4uAk6zwjrc1hsVmX1m9l
	 F0JgRnCwsrzQcHesFXPTzahvvJtGpv1vTHDRsAmI6BoQ4Es1HjxWtbJPjUizOoPDDk
	 6QxTrPZaPz4j62dXebiKLJrFhY5ETM8JBLyNrZqggWBKK/LpUHlFaKE9zBLiHpLonJ
	 YLoyJoHbarpykdDeOfgVJ3YeA5Nfm2LxryigByrEAyg0t4E4kvYqK16w6OiFiWegRv
	 jknGACoD3XgjzBjcCw3a71JgtRUNWy/8hhgja2aze4jCAVlBSVQSsXoIob8zNZByRr
	 Y8/3eSMGens0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DD8360A6F;
	Thu, 29 Oct 2026 17:42:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F0F951DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D77CC409A4
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:42:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQzU2yRtjZQQ for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:42:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2172A407A2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295738;
 b=VKINmm3Mo2DkvmfhY79MQI6fOD6iUjvCeIvi8rFnxq2tU7ruI1f3JM1fCoLBJCypJQzl
 EY6JLseiL+VxGeoUY4XMKYJrz8gApTCIwPkG68w1eWRIKMVQ1DEUAoCipGkBXJ/9Jc8mS
 ujjG+EF4OQffHkHuXXAWmht9tVbpMIAVgccvRmisIp5BYNbLVmYd6iY7+A65CyRM/Btaq
 es+F0gxaraBLLhwPMj6o65770NGDktFA0yU+gbpJke1CzUeH6al0mlPfLjIkb9qiCo0W5
 KrJl3/8AXORC0zntTjjh1BWIKS+75Ce0dAhCusdNDU6kUNSIuorMPqnhckGY/WP/N5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295738;
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
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=l8iIdKElR2jYbEK2E3HK6/adXl7YBtMc8p9hfYKou2c=;
 b=jDuSDXA82qZ1monzbL4J9MctJLRTp3iEwi7Jvb5IUZRHYClRj3SS604cMxe0iTGi3GvR
 h//r48LPxMQEp87H/yYQ1iQSf5KLz75Gy7JXL/2DD7LIbklw874234oXhjzrHALNIcBTF
 4Tb3rBPrA5brePhhfEaIwmjvPoYj0/fsxFLCv6LC2dp+SeDL+BifI4Bd4Ood3gROquHAk
 lZazfRkDCBXpR+T+lvnLOojWuYKuMIZYXFo+bwGNa3njRoD0iILlHkXajdvOX7snawCW0
 zbuWav8OxeziD9nroJxkIBZsXkS5jxPL5Q2uh/Ypx7H/D9OF+S5xUFDtCTqOB+PmkDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=QYnHcePv; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=Iy008Zyv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=QYnHcePv; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=Iy008Zyv
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2172A407A2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:42:17 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDU5Y3224659; Thu, 29 Oct 2026 12:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=l8iIdKElR2jYb
 EK2E3HK6/adXl7YBtMc8p9hfYKou2c=; b=QYnHcePvsqNUJJK2USx0Nwkpmxgns
 JEKtcVSh/ms120ewdmspo4AR+2OHi2KkKz5/0XDI3iDv7l7EnNVyFOq6sFna6dZw
 K/D38W6VWrRFB8Yy+ZS/EMdOBiQqtOdfUEHq7udVsw3x08geMHfpHrcM9DL2Pnrj
 Y6PiIflwRlcdVV/dbAYtjrh0Po6AqorLznCVTK+OLXVVy/8/lhOmMpmP0Q0SIZyd
 ooPG7wgkP6xc5sEpZNNG0SlvU1gw8phr8gCHwCcn5T/C049dhydTuvlUQxOWY5Qa
 ctBDaMFik6z7gmswt7RIToTbAIPWcIc0vUr+P1a8vlM5lc+a/LiBSbmnA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hm3h7k9gw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 12:42:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vig7oQrPNfED+aYzRx+0S5wJLo51qIVsA9LMWHnP8paipxDWqc2d3HEjotn6ITilpQlUmuykY1pKWvL7tA3H5uhCG8fu1eMKBPwu90RtuHyBVi8uRsim88dN1tO4KLWmZwHUgQit7OIbtqgPJL60TObNfHCu7ye1Mf9RRNgqTGsuGlVftjTltl8ac2Fnr6lqjVT0IbgHpZOPONi82uJE5EXcekIkLMtysVd0ShEJdespu/1QUnf9njeOOZs5d/t0BliDJ/koCyMDiipmKdNoJ7Eywzd1+q6iQ8T6x84V6txR5ZsuXEOrji6U/x4k/IW9Td2qWkYLk1Y0NcKTXniVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8iIdKElR2jYbEK2E3HK6/adXl7YBtMc8p9hfYKou2c=;
 b=W5OD8nvlgGqm5nuA4C2JCfmZo7dI/ijUaDJxv4iqrizVXJtXzuPjrO5R726x0S7appsaXJpI4/zvrGBN5+07pHw/vfccD8JwUyp7Wn753XF6SV+m32b8i/bMCcsBaZB9XDS56byxsEDWvgLHc7I1e/kcU7nkF/pCmrgTU754mO6cCNlfn3wviNZFPvYrQKFp9ynPDIzZoljwPE08Pi5FZTg6pC4TppdNgNf4vLj9B4KLUgLm0BYbWKg+uj3/15Z4DdKa+BnxDGabmn7bDkEyXnPY6J7WdJbf+3Pu6/2rIq6zVmW2N5nPYgOtk4nGgzOqoOMA2lpXblyknNyB66/FGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8iIdKElR2jYbEK2E3HK6/adXl7YBtMc8p9hfYKou2c=;
 b=Iy008Zyv3k8zGL8MAzfwc2rghKPVe09swLOoTOGTCqKc0hj978ZcMf0dwhDuU6vSoNUfdx2GiDZEmhj62WACBDhizycAGml/W3J3UgVbV4uCfy35PJkGEP5QSh0i+cxt/G7clVJLIFm5g+3zIayMKV1F3J/5WwNAoAGdkQWdrL8=
Received: from SJ2P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::9)
 by IA4PR10MB138921.namprd10.prod.outlook.com (2603:10b6:207:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 17:40:05 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:5da:cafe::9) by SJ2P220CA0012.outlook.office365.com
 (2603:10b6:a03:5da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Thu, 29
 Oct 2026 17:40:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 17:40:03 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 29 Oct
 2026 12:39:18 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 29 Oct
 2026 12:39:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 29 Oct 2026 12:39:17 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 69THdFqq2392253; Thu, 29 Oct 2026 12:39:15 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v2] arm: omap: Hardcode control_status register for OMAP54xx
Date: Thu, 29 Oct 2026 23:09:14 +0530
Message-ID: <20261029173914.3771786-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|IA4PR10MB138921:EE_
X-MS-Office365-Filtering-Correlation-Id: b7cbb49e-3fd2-48f6-5403-08df35e3a9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|56012099006|261022105027099003|261022075727099003|261028144727099003|261022115727099003|261021121427099003|10067099003|261009223027099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: P5ba4SGqQy6WK4M2/dXHrf2Ja91PjJs0WIPk7+hrnM7Lnd+duN0A7VXs+nNSDmJJLzWmP7hPiHqSW1hq2GAi+nz60moKBoFhhCp+13hncdU5OgMt75NVI7Fqti0bXNsWhvxHsvv9fsiALtViasswjChZ17AXmbUdw8ur1A63HQzWdchUcPBKDYTLiSYaRIiNqEDqqVma15+ieBp/wi87Ua2lHNOOyyivpy0i1rFhE+kzVjGUgBC+QEgP5fo80Hce2TkLs9QpCONNAkLi11PKeGVcOc2fyLxgFIqrd+1ZjpUE525icBEK12Lrmj8uNuMKXGBc+/KYQcBYpoUTcmOdDjAbbPrlgS4ySs/S8ZHylhSZhXJVho34c4u52uJEdc3iumPyRr+u7Qx0t6TD6hwLQtBPuEla698ZXuRG8iLEgcr4ZOdEMFTHFofQ6es7W5t4fD3WoTZWGAOTmJyCvb+jCcEXaz5RaOAfN4wg3b7yv58/2H4MyYjW7nBVR04AWoGSJgG1fsAmL7cGLZEWVSVGIHIEqhhXM49o0aKKIR0ICUb42lsC9NTNM/l2Dfr+Bsxl0FjhVV8FyEAk/zaxgnn5cmmmUs1s0czQV93zD+QFS//eZYvn8E4EsE61g5sZlocdCVIxgjs3YT53TQTGFIqRE77RvjAB9Au4176AbS4P0H8=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261022115727099003)(261021121427099003)(10067099003)(261009223027099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gnzi8NecXQumt6+TlzGRC/hDgDC/30Ll11AvfYi6sDYkRjEX2L085pCeuBYpn1dTNODWaNJGrdXZ9D4sorlM7SkyInZyqbO+1fg/XZiekNpYeTMIBVV3zwMNvvLR3XnJVbQQE9q2roY1OgcgsVsr1xRaaR5AKC/qj+Oe315dnpAZAstdQCqUYQyEFAVq5LjcfTWed2wqLSEc6IopTLYQXCbPFi4KZSj2eY5bnLKZBIyZLm4s+hwM98j835CzbdB/v7/JQNr/gAgg7NcZWM4u31uPQVieVFe17lL+gDF2w0piSznmbqQHvJOu7dxcnwBYMgTXZaEyCTM7gU7+v+4WOhLQafHzaFij3F1l89vvsppc0DDcy7k2CSf8GhrpsetJUGQRH7cFhooUhMRaY/Iq5mB3d4IGunBHzlxPF4mwtb9G1Y2C25U2j16Dov2HGUAF
X-Exchange-RoutingPolicyChecked: GEsbriPQCHpb3na61RWcnvJUyLkm6ZsNuIkjAUA4qXqZQ1iLSEj+sNgM9mT5m7cgJs1e0urVTznM7+26RTwFC6AbhYW+HRHGL+k9xlVJecsBP5OGc/A0q6TS9KvyH4mTa4TEGC9kkuQoExliPSQv+dpGj2xCM4zWmRaXWFADmgmuJcxlSJH++PuEjz46FFS1xA9JCnsW+Wo23oBK42xqpj0oQf3O8xIibBZWbO3odtCJEttr9q1ccpVUMT6u09RzDfFYRbWxvms8bEZ7YyuDzZ4/exhk9eb5sxxl8V3zOUPoV1VlvjCS07gT3rYU+l6B9dzfFFgS+NgMHb00XfofGQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 17:40:03.0591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cbb49e-3fd2-48f6-5403-08df35e3a9c4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB138921
X-Authority-Analysis: v=2.4 cv=fv1J914f c=1 sm=1 tr=0 ts=6ae38578 cx=c_pps
 a=X74xAhwpQ9G8Yf2i8TuT2g==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=uhuBIUcnttSHE2h6wawA:9
X-Proofpoint-ORIG-GUID: VTF8mFPMqJuMs8bP42wKJgd0IYFK8Xqr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXz0X7TGxIHeBD
 PpAB/jZ82INjAe7BImo4ebHI4ZEbl5UQggMYIqvdKmEUuqVXNZ0Hbp7IFBxqg5OE5x/R2gXbIZv
 GuxFqVkEbAbKLoNUGMqqAsAIVedEqCi4e9BXgwc22XCz7jirFYL0/oU4TkZRTCDb9iIQLQcPn+i
 /KV2Lww9/G0OLHgqsejG6+HVSZ7cIhv+v7oD61wWFnHeWpbkajnhVxwPjF4j6obRAa1dB2nk5XB
 TZbarrDX8X7P5tjmclheSVXRMNq1fEg1RqPwTX5q6ZqzdzpjEX8WIMQC2PjkLNCPsi8UhvDZ1Q0
 1QVbkIyQJn3SGJRWbBSQ1SEnnu0H+rtQnnhP+rK9T4s/cXO+fKEAP9G80qrRjRv7fQLVgvQclDX
 9R41Hw9o4B4+uGE40hxlXHfuBQ/4rQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX1ya28bFl6wso
 B+ntN+XP/MoPwS7t+0njT9B9l9SYLX/s3XUdmQc6v1QTNBSLuXNzwWl9Oifz44aYCkBoayznPgV
 2f0Nlw4GJ+oWSKCO8j8V7rebCvQhGhA=
X-Proofpoint-GUID: VTF8mFPMqJuMs8bP42wKJgd0IYFK8Xqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290069
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, the control status register address is obtained from the
ctrl global pointer. ctrl points to a fixed SRAM scratch slot
(OMAP_SRAM_SCRATCH_SYS_CTRL), which holds (*ctrl) pointing to the
omap5_ctrl/dra7xx_ctrl struct at DDR address 0x8086XXXX in the
pre-relocation U-Boot image.

Since the SRAM slot is outside the U-Boot image, (*ctrl) is not updated
during relocation and becomes stale. The kernel section from the
fitImage is loaded to address 0x80008000. So, a larger kernel image
(~8.4 MB) overwrites the value at the address (0x8086XXXX) pointed by
the (*ctrl) pointer. This corrupts the (*ctrl)->control_status value
and CPU goes into a data abort when it tries to access the data at
addr=(*ctrl)->control_status

Before relocation:
  +-------------+     +--------------+     +--------------------+
  | ctrl        | --> | *ctrl        | --> | **ctrl             |
  | .data       |     | SRAM scratch |     | .rodata            |
  | 0x8088XXXX  |     | 0x4037BC20   |     | 0x8086XXXX         |
  +-------------+     +--------------+     +--------------------+

After relocation:
  +-------------+     +--------------+     +--------------------+
  | ctrl        | --> | *ctrl        | --> | **ctrl             |
  | .data       |     | SRAM scratch |     | old .rodata        |
  | relocated   |     | 0x4037BC20   |     | 0x8086XXXX (stale) |
  |             |     | (unchanged)  |     |                    |
  +-------------+     +--------------+     +--------------------+

data abort
pc : [<fff551d0>]          lr : [<fff54a41>]
reloc pc : [<808031d0>]    lr : [<80802a41>]
sp : fdf0cec8  ip : 00000020     fp : 00000000
r10: fff5366d  r9 : fdf31ec0     r8 : 00000000
r7 : fdf31fa0  r6 : fdf40363     r5 : fffe275c  r4 : 8ffc7000
r3 : 726ae0e1  r2 : fffebe40     r1 : fdf31fa0  r0 : 8ffc7000
Flags: nZcv  IRQs off  FIQs off  Mode SVC_32 (T)
Code: 4b04 681b 681b 681b (6818) f3bf
Resetting CPU ...
resetting ...

Fix this by hard-coding the address of the control status register and
avoid using pointers as done for OMAP3x case.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v2: Changelog:
1. Correct commit message to show pointer layouts accurately.

Link to v1:
https://lore.kernel.org/all/20261026134848.1733598-1-b-padhi@ti.com/

 arch/arm/include/asm/arch-omap5/omap.h | 3 +++
 arch/arm/mach-omap2/sysinfo-common.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/arch-omap5/omap.h b/arch/arm/include/asm/arch-omap5/omap.h
index a9c0421b140..5791fd2d635 100644
--- a/arch/arm/include/asm/arch-omap5/omap.h
+++ b/arch/arm/include/asm/arch-omap5/omap.h
@@ -24,6 +24,9 @@
 #define OMAP54XX_L4_WKUP_BASE	0x4Ae00000
 #define OMAP54XX_L4_PER_BASE	0x48000000
 
+/* CONTROL */
+#define OMAP54XX_CTRL_BASE	(OMAP54XX_L4_CORE_BASE + 0x2000)
+
 /* CONTROL ID CODE */
 #define CONTROL_CORE_ID_CODE	0x4A002204
 #define CONTROL_WKUP_ID_CODE	0x4AE0C204
diff --git a/arch/arm/mach-omap2/sysinfo-common.c b/arch/arm/mach-omap2/sysinfo-common.c
index 49bc3a634fb..1b7bca3ee37 100644
--- a/arch/arm/mach-omap2/sysinfo-common.c
+++ b/arch/arm/mach-omap2/sysinfo-common.c
@@ -22,6 +22,9 @@ u32 get_device_type(void)
 	 */
 	return (readl(OMAP34XX_CTRL_BASE + 0x2f0) & DEVICE_TYPE_MASK) >>
 		DEVICE_TYPE_SHIFT;
+#elif defined(CONFIG_OMAP54XX)
+	return (readl(OMAP54XX_CTRL_BASE + 0x134) & DEVICE_TYPE_MASK) >>
+		DEVICE_TYPE_SHIFT;
 #else
 	return (readl((*ctrl)->control_status) & DEVICE_TYPE_MASK) >>
 		DEVICE_TYPE_SHIFT;
-- 
2.34.1

