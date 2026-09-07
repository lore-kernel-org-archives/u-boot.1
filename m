Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C8CC79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 05:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDC3A80BF5;
	Mon,  7 Sep 2026 05:54:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FYmVRdf-bdep; Mon,  7 Sep 2026 05:54:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 083D680BDF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788760467;
	b=R+Tvse1PDoTYtRdY0SLB/m39OclUnbT7gQlp2u7LDkqcpDzXplmBk5Iohq1wrtXrbd+T
	 RQVFFJSAGuAB/pE7YwgRsPJ/S6G8EjhDfpAymdWlUVRgpssSn9PUuWxe7jddXTY9TFBLG
	 ski/SNqtoX0/EixsBb/7AXxYEvTWFbcJTFIhRj1MY4uw6XLokG82y5Vnia5ioCEBU4vBL
	 ERco0fk8ufMFr/h7SyomWgyPU0ZRGppFUeztnBLQvfBNWlpRgg2LJlyp6i5Xwpxoua1k0
	 bLvZOfwbtCSS9iBFGcJhrjt1V1TYd1+TPgeKnXIUEGIhHR98Uo7ufFgSBlpiJ1nfhHw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788760467;
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
	bh=fxIrOW/rifk8IV7fKfxfcXEfd0cXb2m/BitXaUthod8=;
	b=ZJxjukTTuw9C4elvB3x5FEzsbHrOgiuNGY0+i3WngKc34pMHRD5O4k7D4HlxVZWJabUy
	 bx5g4/Vw4ZoQ3spMDqZ/oDfi162JBtwnYVVyRG8Wtff/CNzpsqmXt8XH9R+2SPK9qMLnz
	 DTcVWfJXe91538JjsgFdIjeI2+nkOLKZz430fUJgJImld/lTboq/oyCymowY5XqaF2RXX
	 NsLGdxmEJ0Qqc0ijWzM5fTScQmvqJb5eeAFYwDuomYQVWhoS6aAUq8sGTeWxZBUQzW7JX
	 O+DZkFSEM1RqjkWx8o7eIvBhnxXnaqMJcAc3DphaPNq65EgmAiX1Ln94Lz/0mfjvHYQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788760467;
	bh=fxIrOW/rifk8IV7fKfxfcXEfd0cXb2m/BitXaUthod8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DTz2mLhqdmBb+/46V0nYMNhW4RU9mnz6kqrK7zI6uv29tXx6shxR433HlvFA5/Ijz
	 oPyfbOaZXOy0uyNibah8z4edvJxDpls8zFo/V2K6Bpo5d1ZzwOdt7M+cQRebuZPjM9
	 X7zvjst5g7z7ula2iGuC/iNRfCPTuSpl+AlcRB1XkflEY3z07btfV4/CebklTbBVpd
	 jXDmmu2E3/WnT/u7sCL0EqeEbsPhw9CbFPSrgSr8bShFN+IajE+REL9V7kjcpv6h47
	 f0tHkDleiOnfIs1iwefYyVrxWt4VcYz0IXUGfzAIsIj+CJSCRoVvoBX/jqgy4G2NmQ
	 1QaUyLInTbKLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 083D680BDF;
	Mon,  7 Sep 2026 05:54:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 27E0B2C7
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD7156061C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:54:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6-VyHzn6Y1h for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 05:54:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A03816060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788760459;
 b=ODFadkfCFBfM0IvY5Tv+0pnsFYlx8fxHY5Y2h15w/CGMBRYT/XBbo5CgoLLxL+OOpPrG
 2QCWktU3t1q+SWInPtHwkXZbBVgOV9GNx8mnl6OP9AI8LtXxaVNfC3hSHxpLbYVlZh/Rb
 1kdQcTKqBtJzdtgdy19vjxMFwI+F0jshMLwgikAahiIesNBjxt5vKlqyaX85ET8uvMXoN
 uaQa0uc2fx6HHUXyFbbPXMg4j4g8jNq1KX+HAmtdVU2AKiOk1gCKb38pAWMaPLBJv/7MH
 T+Yav2MIuyJBYD7gyBFnhMqLroiuIic/FMuc0aWYmgVNKCWFKB4lg0njbEx3PDfZnUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788760459;
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
 bh=fxIrOW/rifk8IV7fKfxfcXEfd0cXb2m/BitXaUthod8=;
 b=db6vPplZ1GQU0dNHC0Ng34cstbofrHV5RXWvXwoKf4vTlnOB5/DY4bkACRqscarrOScO
 LL3QSnW/0aj7CtrVehPWMjsEkUWBy2U3AcdXKa4rWgYl+fvqZSh+bY+WrsGq/9LCNm9Ih
 yIfwO5cBhJY/PjYi2gPDSOnLAnSYHsESayzVWHON14Rk0bf8quPA+gKRM8YXDJNX04n2l
 AW6Omg7Kzh4U118YSbaaTBJ/cPalobCTuy+473CwiRA2ekSb0+U+kWBcEO63ObYMVNgwb
 qh8dPxC6BfPBHhfNsOdkwRj4tSNe3hW9jGriPypioheEtNrwzDhiM+dBpiO6r7LjtUQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ckLe3Y8x; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=fAp580FT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ckLe3Y8x; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=fAp580FT
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A03816060D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:54:18 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6873jFnv477418;
 Mon, 7 Sep 2026 00:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=fxIrOW/rifk8IV7fKfxfcXEfd0cXb2m/BitXaUtho
 d8=; b=ckLe3Y8xB/o/YOuPWCWf96BqERLlKsOs45fl8FRdfhSsl6+vrXydRnNHW
 ZcDf5BqdkU+yphq7hkDIvIEm9xvxzEpWB5uFwFzIMoIkYWSUi2gNJK03ktXhYbJ4
 Ko1nL5oek61z63CNMm1mFwnYn69r4ErLNMB9FUnH6Z8w/LJhTpbiFDLl+17TN1/6
 3lFHxEgu4D6uV0hJ9ZPqoT7MUfXD/ofkz/qPURaaxNUIiWqafCWsaX/hyZA/8UG4
 uZbvmBNQwusUeazLQ1UQqX9Q/hcYKfzf3ZqW9RbAg1Xesuibb97W9no2H2LxT7Nj
 VrjoqTGM5vEiJEj5pr2zsS+jv0h/g==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gh51nkkg7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 00:54:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHRkPmIeWoxY5hbnqoAo3pTsH4jO3earIygEScIegye93+SWbx7rM3qA/+JNYrwYTjwHCiGUw72xS8yPMqIsHMJ+UOr8dolNIXBlcP4OE+YDRXUk9p7o1GTSOxYyNjLyWkeKEDp7O17vSjyQa05TSxJ6qd8ofEcnSlZd+aBr0ks1INAlitWavpOdvoMNcFi28pj11c1fMqCGBaXJ3KNg6tAWEoC+vXsfKW5u+PDMCe3goPDJzTPkPRu7tQpC8f8/0hYTW5mJbdqPnYmFo+OJRSWh19eWCS/1PSh73vQ9SurfM5AFsmJwNSvMt46X5LAggUSqAn6t16TnkTGkoNnHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxIrOW/rifk8IV7fKfxfcXEfd0cXb2m/BitXaUthod8=;
 b=Z5VnNrOrwgYOGYPYa3H7KwJwOUwAZqB+vHWiZlL1WOvMVBC1utmC5btMS9JWJHXYGHUdrfOrxkNU4AYdETzA7ywo7tX9v1YuGQbqOx+Yr1uZj+1pUW33MxL25U56qb0sU7JoOkCdgdR1oE9buHD9unc/CXbNkz+3KS/TjATm7igdHyJsrJOd12ij+hkFKVwV0VOPzREXMD1gYiqzcj9zY79eKGbnhYAPbyUfML2kMfe0PLLyTpq66Jh4+pgg7O/RyxOmAkYC86NityNRykWC2e9EcVJ3lOYqj7JpLW5Mo5++9PLkG5BeMEMa4pMi3Kje4GjnSj8VuhTzD/WmQ0/+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxIrOW/rifk8IV7fKfxfcXEfd0cXb2m/BitXaUthod8=;
 b=fAp580FTyM3efEub/Q/108t8yy5a5nj57MJh3fsPPDOSIRwqt48aM7ABv4G+RzUgE27tjf56UmexUOImo4Udog/5tl0asGMGOK/o1a+B8TD3dEz0obU6LymTlj1cGa2yJCsNME2mHnq2FCBw1pjNKVCOkIBTc2Pw8NZ0ssG/n/w=
Received: from BN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:e6::15)
 by DS7PR10MB5168.namprd10.prod.outlook.com (2603:10b6:5:3a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 7 Sep
 2026 05:54:07 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::a2) by BN0PR03CA0010.outlook.office365.com
 (2603:10b6:408:e6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 05:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 05:54:06 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 00:53:46 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 00:53:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 00:53:46 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6875rfZm918478;
 Mon, 7 Sep 2026 00:53:42 -0500
Message-ID: <58aaf4b4-f792-4775-b047-f7ca240a5a51@ti.com>
Date: Mon, 7 Sep 2026 11:23:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/21] mach-k3: r5: common: introduce
 j7xx_board_is_resuming()
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
 <20260828135730.1565643-7-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-7-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DS7PR10MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a74fc8a-71b5-4764-8daa-08df0ca46da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|13003099007|10067099003|22082099003|4143699003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: CvFCnHo30jP16/B4V1VDUtf7mWijD7hZjcmfyu/TGu7rnkkH1NxxgXEGG0vJOhrLMgtjNEKN4/t4biF5/1nWn72GdnRroGW5CsbAlU8L1sMGtJceVhsS4Ix7TFLFBlmnstnwK0RUqGzf3c7uEfLfGrJu0So+V2rQ7z2theK1d00y5Rr6RDNE9fta5/xF5wETXl5Gt7lmHAHFut0E4aOhNzUDKIEPZoEgJVj7NlnpSciuXmJWZ6pVxq6/Mq0KhbqVbuwkXNn7x9EfcR+ClxGs2pRPAW8JmaQpDr5NZhPqKxbdOSfar+YrAYfXA3W7gpzmj9W1cVy5v6v/w1tE3lZCQT5QMwGqkufbl749AtICJ5hEm048JCPmUgEV0fBtjuK5+om7YGGeEM8pUJJi4HRhy/a/H+uapnFwY/hIL5w80Fhu5ZnBxWU1GS3zb3hFy/ISu3nbzNtfspHHq2PnMUdZLJrejHVrWHtEBv+a6TkCFQbMWchdrEalVCyluGl0iE9tlfO2AfIhaq6wyivBce9TfR/9H3JqRmYWOqt9AvzLiNZ6/8dD3lZy84hvfaSTR7gVZJ5K2EksJhHlETkHsOAjK+NrB/jc01a5fgkeS6MK/113VjG0napa7eHaBSs3LfumtmP3REHohDdw9/sYxSRhzOPcyocWqxMyAU4ZZXvVbUZOZyJoDwq276KMccO89vxkJH9ZbXUA3qUWHX4UVLDGLw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(13003099007)(10067099003)(22082099003)(4143699003)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hog9cIWhaWm4h+g8WSPbIVCqaMYLp07IcnYPk4msIJVA+4Xpu7Gx0iZSHVka1bAe7PGGV1OcVfp+MZvug32hSh7pLIASeCEJKOzR+jJn4K5+oMQLiWwK5bfNUqp62T/+mp7rI3x//httTpRfaYwEHNTURby91tPYmr8Smki29yEwSa63c/jzUgTryXXaXTfYS7peXUcgzV+HpU4Bt2eUKubJS5xusfgfSmsd+j8acbJlwVnQmCgkZMEklp9j5+zseDYa7RanJ62u0vkVVySvoHrvESifMqnTHKMoubcTk6YJMiTgMezd0+T6wY4kBWZp0p2PD7n4xixrDzq84LRJgfVEECs3JnClmPKr/BJzz2pmvAIL9jo3wBacz0RZ1c589a9EjBwlt25AT+5BLvLJxsQFPamA/jBQ9PaC38zmbVKGwfrJIC1ieM/lW3COcgeB
X-Exchange-RoutingPolicyChecked: 4DfoXEMA6pUn5VvraZwVMNMDljJ56YLraHl/f9fSh/GlHiBHi78t6QvIM+bEItXh7CmPglYc4ed/m2QhGKreQmU8q7QdeYtJZetXLopCDxmcFO5JUT5JWZX88cK26+Zn5V0ddwH/VIrJPXhO+fRz6kLzarbAuhig2ECyYzmbVKVPMP4hCkgBosFYFxccvsWVZZ/TRqCuA1aZDqoBSlF74lr34Dol6X/nDFhIIOsz7aeXKh3K5bGhGj6dhUiCUJ/jZHN/nLfVbj01KAKG7pS6hTiZfQVx1VDBLcWReOk4smlMR/Zum6OcLwqzW7aX92CkW4iNz9BEL8SYitpxQMO8Ag==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 05:54:06.2378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a74fc8a-71b5-4764-8daa-08df0ca46da3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5168
X-Authority-Analysis: v=2.4 cv=J8GaKgnS c=1 sm=1 tr=0 ts=6a9e5184 cx=c_pps
 a=hwAR686YzpmZ7aH69gEPcA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8 a=DuelbYMqBzff-jnWeGgA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: fUJwd2RckiQK5jkmlHrT8eYm-wHFepv1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA2MSBTYWx0ZWRfX1MHzNBl6HtaL
 nsCm6ULg1VhPZQ30t9q8dbh4O+JlmDckAQbMFNNdjtfqZI5LBcTWr+v6ko8+/+zP/jeGf08mM+E
 K0vhLz4+vqK2i5K8F0Viu+fOAP0K4i0eAVtFGgTICSZEWRphpu0MfMn6rfSJNUwdtBE1Znrk+jf
 ZeaOLT5fByjAGDPEyjGY1K3/icMLFMAVJ/AJRSEri3ErIFe44xH5UqJHSs63KVB+/5q/BPolNGi
 5hSJ3d4PABTNIpcEt9wUyP7sXDDXFKCdJUjZv7ZCKLOLqNn2DpPCjgK/rSI2lnJF9l9UMbhbT5y
 78fT+IvIBDplwZ8z2UyU262MO2J+TuXnRZY4KzoypQeMXI8P8kZX1ufkMjEcC2JoZGXvNwqCOPj
 9LXGQRC93HvXbjWY90Z0YjyhSFAXxmyAE6SOGJ9QvqqAb0ZgzNY0o4xPOweP+Q7tzvXh5r2SqxM
 ebyOszPx18b+k/cljHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA2MSBTYWx0ZWRfX6xjS7DIP1BzM
 LDpX6W2c2Req5GjLmjDLJGfeg4By9oNCS/R+3OXuigzhbhzqon8dMppPi8lPp1fNRAwzXrFuQr4
 RhHHNTtCngox3DxEf6KDRmHDC48RvwE=
X-Proofpoint-GUID: fUJwd2RckiQK5jkmlHrT8eYm-wHFepv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070061
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
> Add the capability to detect a resume on J7200, J784s4, J721e, j722s,
> j721s2 SoCs.
> 
> To detect the resume, SPL searches a magic value (0xBA) in a register
> of PMIC.
> This value is set by DM-Firmware during the suspend sequence.
> 
> NB: As this is called in board_init_f(), there's no BSS, so we can't
> use global/static variables.
> 
> NB2: For j722s HS-* devices, we need an extra call to ctrl_mmr_unlock(),
> and we have to use I2C API instead of PMIC API for this to work.
> This is because bind is called before anything comes up, in between either
> bootrom or TIFS messing up, clearing pad config and pd config.

There is some work going on to avoid this dual call
see https://lore.kernel.org/all/20260225051559.416445-1-u-kumar1@ti.com/

Please see, if above patch helps to avoid this unlock

> 
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/mach-k3/common.c                |  6 ++
>  arch/arm/mach-k3/include/mach/hardware.h |  1 +
>  arch/arm/mach-k3/r5/lpm-common.c         | 78 +++++++++++++++++++++++-
>  3 files changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 6e382efdb3be..d934f732b330 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -713,3 +713,9 @@ int spl_start_uboot(void)
>  	return 0;
>  }
>  #endif
> +
> +/* if r5/lpm-common.c is compiled, this will be overridden */
> +__weak bool j7xx_board_is_resuming(void)
> +{
> +	return false;
> +}
> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
> index 2c771a1195f5..c45bd3747163 100644
> --- a/arch/arm/mach-k3/include/mach/hardware.h
> +++ b/arch/arm/mach-k3/include/mach/hardware.h
> @@ -137,6 +137,7 @@ u32 get_boot_device(void);
>  const char *get_reset_reason(void);
> [..]+
> +	if (IS_ENABLED(CONFIG_SOC_K3_J722S)) {
> +		/*
> +		 * On J722S devices, i2c access fails unless MMR
> +		 * registers are unlocked.
> +		 * Moreover, it fails also if we use PMIC API instead of I2C API.
> +		 */
> +		ctrl_mmr_unlock();
> +		ret = uclass_get_device_by_name(UCLASS_I2C,
> +						"i2c@2b200000", &i2c);
> +		if (ret) {
> +			printf("Getting I2C failed: %d\n", ret);
> +			goto end;
> +		}
> +		ret = dm_i2c_probe(i2c, 0x48, 0, &pmic);
> +		if (ret) {
> +			printf("Getting PMIC failed: %d\n", ret);

Patch looks ok, but want to avoid special handling for J722S :)

> +			goto end;
> +		}
> +	} else {
> +		ret = uclass_get_device_by_name(UCLASS_PMIC,
>[..]
