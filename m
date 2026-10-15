Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C9BCC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 05:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 920AD8101A;
	Thu, 15 Oct 2026 05:25:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ilc-dbaTIa4m; Thu, 15 Oct 2026 05:25:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C1E068100B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792041934;
	b=LPIlDaojxALVvCGZjBiu26lmfFCHzWJqEw3u7XWtewKg6ZZHdwQ7npTWrGobScL38p/s
	 betXxDbtYHIPczhua8hzOlmM8Xw0iWZZ8rn+btXVco7T/SjaqgYn9K18unnuZgBWqyxmz
	 KaXr3T2AALUosHF8uGkIKBdvy78tX7YYvoESrfWh6nW6JTbn21VkqjtJZlTAVfuNIH/9F
	 K3Hg4w4x3ker2ETCxlJ7e5ZdZ9MqtXieaRM7jVRZRFqisUBSa8KA7dteCTUfe3r7nd8qJ
	 PGb7Ja9QMCg8Q4Ei6CXBoNi1a6lt4yl/tLiJqqQGOdS59HKdL6Wstl6QAWF956V8dIA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792041934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DVJgBt+0qfjLEGswpjlG0MJ0n9MeIsDVbQSM6ljBGKY=;
	b=TfbsGsGGGjlZAz7vPkJOfMIKfqFFeXjEgVxec2ov1Nim+WWvDtjoVHJGH9zCFUTUsmyB
	 Mx1u4bRvVq8DYMraUcfaAg3uaOPQHBeXUa8Cp50UTSQyVCmifFcHqiucL3HdY3P7qxvHx
	 Qp7i7PWu99GNeWhoKR7UbmNQ0qiqKFtHBrOIaG5ResEx1AmM2dwGT7jk3TnFEN6lkeFjb
	 jUEttq3ZHzY0BaKp24FsshOcDt2yWvs6gtOrCjJfErUUcSlP4bARy1ERbEwLTdvZ+blyN
	 JezVpSnAEyk0+WfsdkO7SMZuEUelyH2ZShCR5IsI6q+eRyKsXG18r1zgoLZG8QAU5mg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792041934;
	bh=DVJgBt+0qfjLEGswpjlG0MJ0n9MeIsDVbQSM6ljBGKY=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SxN+gwAJmI9D+HGpGo7Q7Z2hEYJVpltIilC6n++D5Ys8ZIcRfqBQrHvCX68C4dVZU
	 +YJUaaCtjw8XQ9akNzoO/5kj2qtK6I7AMcHTAD+F1zxSAyj9IDvdDRhfa4XKJDYcEj
	 1PqhGg+UKiUsT2do7H9dAUHo9zVy54Ivxkqf3wH8SeTeWe1t5lA0yPDT5CLwhq/lQJ
	 u3VTVLQk9lxW36cis26S9OUCw9Vvfiww9+PV34iENFnVZ714VZyZkcw3SwFFTs6hsF
	 V7SZfZcbqlnaF7aV57fuTt1YcKnMEy6XARqyAtPUCnUSrr6t7ejPL0StOfv44d8fnZ
	 jNVU18ahyi+KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1E068100B;
	Thu, 15 Oct 2026 05:25:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DD44A255
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D22A0608FC
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:25:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9WegIt0aorBH for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 05:25:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D504608CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792041933;
 b=elNjHQdnXx1ybTXiCvRieSDJoZkmIUDT/VemPGgNY5WLgWieMbb8WVs4gQIHQCosfiMb
 7EHHymQiQMub+ATPErM0LLLHH+4KuSczP7yU9wuVRQ56b7qvqUZrf/Vpc4e4IlERYRRPU
 AJYNW/t1EOixjmbrp3EIOHbTDduvg6AAEEiWHtEFHfiQegQelEQvmfX4Cim10jkUAJ6d4
 WBVWgu4sEBHgf7Lz8LOTmC+lAzjzn4LRQmLeDk0JOfhPwXxxQ778OfMg3BdNDVSHNhfOD
 TXAIviOsQ+A3yuUbXSs51GI5ECLWeyJN1mYKqHdmZivOa3SWAD7Uy5Q346wZ4aVsKag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792041933;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=DVJgBt+0qfjLEGswpjlG0MJ0n9MeIsDVbQSM6ljBGKY=;
 b=FjQfdQ2mcfK2y5Yntl5A0JHTWcXccTIA9BVWe6A8z1scygBZxYFvHoUPOwyWqUdme3UE
 rrkdZ6Tu4oTmHSsnc7nGa41CSkQSnJ87RVR4e56WQaaY3ApnVjTUdAhRDhu85PDcKKs6Z
 bWX+g/Qbmre48CglNDOTNCpeU9oZgeJeC8qcykxHJ4C4OzKJwHYPlTay8F5C7cMV9LdQz
 p+tWkvmYwKx/zcr2wF0ayeeBRtmo5blN9nG4Ax+2xgiKgwSnM54Bt1EfS3UYj/eN0H68g
 45phHk0Kp6SYc2BwDJHPfQVOPxDFTVDel+i9v8IHi9iyMCPLogYVvXdmh2NeBAQJRMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b="F4/dDuRQ"; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b="mhsww/3t"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=F4/dDuRQ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=mhsww/3t
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D504608CE
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:25:29 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F2SBdW272291; Thu, 15 Oct 2026 00:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=DVJgBt+0qfjLE
 GswpjlG0MJ0n9MeIsDVbQSM6ljBGKY=; b=F4/dDuRQJw4i6l+FuRQbD1HHnme2E
 xSyHMir/xF1OcjW0cLnta5q0W5GiUKp3gYeTYIQE1Ae0J5Ws39kC0umX+ZCrqwja
 rlgObPqjRIjNpE4gcjJoQJ1c9tpwhGwARKc7QkaxYZdMpqJZEC1ccsqJG2C5yDpV
 1AOOo1K6Ft8C8/hfCPHjSLjb9qVfb513VU25nY78qrgsFRNcnCExOfF7YXMUB9bb
 bIMYJWctqar3bYPbSRUG3PfMCadxBS2oU/nT8PIywmHZkIvk6fZ2osRugWvUey85
 u/lmTI2o/JbSyctsOtO1bAQwLR4/pwPvXlnteC7nHJpjrAB0n5xsbRw+Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013002.outbound.protection.outlook.com
 [40.93.196.2])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hag1jat1b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 00:25:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWw2VH2EkSoG9zv6JtZ5EQswp3g/MQn3+EZqy3wedXzESMKU3cNOU+USzbyorbMgb5ISKmAfadB0lBnOt6TL47/qsLZSkmalIH/KtQDi5HUmDmBo3RJomOQN73Ss00tlhEg/JpjaQCqtzy51LTdNdRlwUcv3cppQ+3jsthNQzryklJpqVSVYBjEWfocPWv+q0L0LKt1AJcaFwmVVQ82CZVoV5OEKG1dd5zME21BHE9grf5mf74KNwd/ZdhPmYibPyyCuMwrOIpbZpzyCZeoPYNqK+sH3KpbERwZrHRZaz1j1UKtUdq4XeISsPDGEeQ+OlMev5Xlc2HjT5+BV0r4zTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVJgBt+0qfjLEGswpjlG0MJ0n9MeIsDVbQSM6ljBGKY=;
 b=lvAecBTliio5/u06ISVp7S28EPLe33MiocgEcjLf3HnpaGtMFcwuEv+Qq8RBl3U/LszWLVwbN+cKat81ALtSZCWQ3UDPKDD75IoFPUJJlgycc90NwhoodAulgA0Aye+lYHdNpTWV57W7uvk2VhgNSoujdL/9G2Eseua6yWdxLExL7ELOVPs8ClWOqCRDREk8ys9lfNDQhZAkV8sHU8+XXQu1tTVV5iBnf1L9P3FrWyDGLev/mps194TgchMqVQvplwyyNnXlIybXURZVEcY161KIJVxVX4AyPWb+8/29lbPGZ9mwd4UYo3WSLbozxcSYMxAs+zPEnD+6Q/5Th1T0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVJgBt+0qfjLEGswpjlG0MJ0n9MeIsDVbQSM6ljBGKY=;
 b=mhsww/3txShELtFy3zFcC6HQO+n3aDtvVzGVgmYCBhkMg2jMMURCWeHUbgqP1kYBtaHnoTKPw/faSL1wSyUId2tcriBwxGiquL72FuCsBQVjiChsNL+VzA6G+s5G0Ah1M/8SsVyx9R/3cnbPwDfihZJ8j1KHGZZ58hrrYSWXLwY=
Received: from PH7PR13CA0023.namprd13.prod.outlook.com (2603:10b6:510:174::23)
 by PH3PPF553978BD2.namprd10.prod.outlook.com (2603:10b6:518:1::7a1)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Thu, 15 Oct
 2026 05:25:23 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:510:174:cafe::a0) by PH7PR13CA0023.outlook.office365.com
 (2603:10b6:510:174::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 05:25:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 05:25:21 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 15 Oct
 2026 00:24:54 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 15 Oct
 2026 00:24:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 15 Oct 2026 00:24:54 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69F5OrRb2793445;
 Thu, 15 Oct 2026 00:24:53 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 15 Oct 2026 10:54:51 +0530
Subject: [PATCH] configs: am62x_evm_r5: Increase malloc pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261015-am62x_increase_malloc_pool-v1-1-8b6e97ffbd12@ti.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBAF0KuUWRtIInbhVURCHH90JE1KRqVQe
 nejLt/mraRoAqXjsFLDW1Rq6XC7gfgeyw1Grt3krR+ddQcTp9EvQQo3REWYYs6Vw1xrNp4tYFP
 aJ3bUg7khyfLLT+e/9XV5gJ/fkbbtA0gZemx+AAAA
X-Change-ID: 20261015-am62x_increase_malloc_pool-2c0ee0ff3fc1
To: Bryan Brattlof <bb@ti.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792041892; l=1184;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=2zH89Rg/4yDTA7TwbhdXHmr7CliHOWoGCKMPtMQ+elc=;
 b=FctVuzNg+mfidFxlITXZNanXnPGeHijA4Qk9iU7WOoq90xYoxpM+zLKcQFPiOlUalErwvWwK3
 JRfeCJzuCXNDoEq2y9lRQK+p6/2wbHuZFSC9avp/8HIDQIj157TAqMF
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|PH3PPF553978BD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bddba9-7a52-4eed-f8bb-08df2a7cb56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|18002099003|10067099003|260925022911599003|260925021911599003|260925021311599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ab0BQ1TH3hBUdc1va8hCyuRZipMdLT+xKPUedX6qC8JT1NGw/9WoJuyGskOiix8VankZk2TCMCGnoGFLQZjUcl5J6GIn1t5/q/8EOQS8e4K80IwW9qeG0ZP+reIOK/J/o92DyIPPtNG4mSjBHgwgKM0QQTyjXsr0aRDsmIT7ydUa9eKpf93PPoB1TcBjaHHI1o0dJ6wlk8kSLxwM1YW1OWp7DMBnZVXHAibwkxkxbZNwQjGLpUGNqXXjZgV/KuxclBOnNunIYsUiS3iQOMHZwbKfEKTtG9lKbZohWARmGbya4SAwEyv1w/5b9nvxfT6iGDzX74DnZuYz7Tg69eon9y0sdCftvR2i6PQDuZrIR0ppq9WqucLAuoMC9F33vt/liSdCpdaMPINKXE27KV2sfsRsydEiO+bKNMO8TDLKG0J3vMZu+e/y+N7bPGnEvf2+LITpu42nsYuzdZBmTCqrOWMR/WlejDbqu3irj2pQbXbQm29uFeeSLT2t6r5qsYZxNWZxkliGY95PrmiEjVhEL+OuI2FxpVKABa10Wcz/izcMC9VS2A++oxpEY3TSxNQHqrhW69Muc11HEClOr7hllgcq9Cg2NORO5QFdxh1PdO2hd6Xi/0Y4P+No/CAv46lnIEObhb4BGVn5Ab4THMjn5flH8Nsu9kpkvfYNFN3tHh6sL7FBN0cVx7A91Zsj+LLiRDWove0UUx7JaCCig6ruNw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(18002099003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JCLH/fuY9l1WkQZF4bsqWrUn/TlEGJQtzvWp9HQDjJtupHeSh2hhxiyGnTSHSaHzVEx5WcVX+Wdf0GlrUHMWzSV7dCl+h4kSggGzfL73doPBS4P0SCyNPwnba3vgT7tyg4P+5eB0rpPl4KHfIcbs/JZra3MA5IjaXHzjYHaLo/mpBPv1ZfPKdZ57JczQKNOgXGhByAFdMrrTqJfvOrZZkvtrNMKQ4eF1O0aIeJafcE8fNZQe3gHq/LQhtvAQ+u8OXrn/6M41uMAtmY2BfKKb2ljl4zY/yyuTCJnWvVt8MdWRKzX9USy+vjAiVR5CdpO0NPBaHo7Vpfu21R+gdc11SqYMZSQ8A7X3On44IJs8tPVBAR+FlvHx+4VfvOonzLCCb/cy8/ku/U2znrxzEI6IegJj7ZtvxnK1H9MdUE4lOyg+h2L0ArLVPX1PqX8WTA/9
X-Exchange-RoutingPolicyChecked: iRqQu/PmQms07VWR4TbgrDMLAEKaFEzma0izalOuxHVv+RmhvoGvT72hJYeioIxrNxTNsdhf1uKG6MvDaGMiQwd92I23xzu9koHHIdQPKJlQQlQVIkb20E5ZGCokJ1hQlBKp6n5L/JGd4CvWy53ZnNp+JjrlMDGUIVKog5AxNCXvWzhMXPh59rEtog89FmNxu8iz1k9K49x8/gbz7JsZvRuXkW0RU5jtERxkZrkkUQbLALIYsmCVeGKMZ9ZE8sfajo/NdXnVeviAenP9o5tnmCEVJzmkhy7lwu7CIBufUL6/B7dJbDKpNIDPykdkRkFVB2A4likbN4Pi1YNHM26FmQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 05:25:21.6547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bddba9-7a52-4eed-f8bb-08df2a7cb56a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF553978BD2
X-Proofpoint-GUID: E4761WRBPAHW3K9zeKUlow3Dwprr13Ck
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyMSBTYWx0ZWRfX9j4GemEq6kMS
 U74VgjBNwzOjt83/V1pCuxrQ9ofsZSTgzym8p2c0zacGeDgdPYPmjHpKTec8Iv0bLNhPb4PFKW5
 PJjNV3iT/Sao1+xNWTjZ4f47BEmia4KzsSuX0qBfDH7RckCGnrC3tDMO1+3cDgIVjAz/FDxIkry
 T0a+sQv4BLfbkStXYB90cFH+HGX/IJfGkvapjpgZXfTDXZp4LvRm+5nsTPEP0q2pC/j5uoKm0UD
 BHtsKbmWXCcc9xi7F5Ks1m/XY3ddAssJyVWrFGrVwrfMtIdiJFk8t8ycU+odKa45AoelW5cb2J1
 93wcUoUdCp7CQL/YpoJ8COfl4E58ThpSlpDpIuQhXNwmDjzllRhQAw+/M+0NSC7hRPt1l9CAYCo
 sL7s5GfJflA+kGu98dA9N/V5uoxDk0COHdV2yqVyO9M6SnEOchsGdyVktRaPkXLGpWw93JRrExM
 gHnyIghPcEza9mBGkGA==
X-Authority-Analysis: v=2.4 cv=ZsZ4uN7G c=1 sm=1 tr=0 ts=6ad063c7 cx=c_pps
 a=qSv8Sft3UEt4GReRCOm4JQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=2oCcaHZjVaI-3ILMWSoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: E4761WRBPAHW3K9zeKUlow3Dwprr13Ck
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyMSBTYWx0ZWRfXy5hyw+Omev5w
 5x2Gc17QDkvOBsy/GXF3JBe6PznjjnbWrmVteZbW5uTdjY2rPWMHvEV23C67sfUweA+SNTN1YtH
 hsEwjMh9vol6i8RNySFHzak6tta/47U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150021
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

Since the commit 6b4b1c8dc464 ("arm: mach-k3: am62: add &main_uart6 to
clock and pwr tree"), the malloc usage of R5 SPL for AM62x EVM has been
increased by ~400 bytes before relocation which leads to a boot failure
with an "alloc space exhausted" error.

This patch fixes the issue by increasing the malloc pool.

Fixes: 6b4b1c8dc464 ("arm: mach-k3: am62: add &main_uart6 to clock and pwr tree")
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 configs/am62x_evm_r5_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 49656680252b..083fa780ca0d 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -16,7 +16,7 @@ CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am625-r5-sk"
 CONFIG_DM_RESET=y
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y

---
base-commit: 65a7532545336e4b73e049a69436e255da7df961
change-id: 20261015-am62x_increase_malloc_pool-2c0ee0ff3fc1

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

