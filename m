Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921E4C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A6B980BCA;
	Mon,  7 Sep 2026 08:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RWLyn4DLtqgL; Mon,  7 Sep 2026 08:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A61DE80BCF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788771064;
	b=QKP+VSwao3ETZ69bW94h/dzG8uSYNwb+uqbc0PK9/RAi5tbhKDxU9MIVpXPSv0gsYm2R
	 SNhCsZgn29cG3ZKNecnXs2Win4HHmF3QbPi7XpUT5HQ+CSDYnRD03XBz/KnBzq+k4D9G4
	 POSXqVKUUJNXYDLLsQJoOYFRzHNVmKWnaxMU7WA/rEmJtSgGL/QpMebxtD5NeXrqPdJgF
	 /eyC9vjGhONDOeqiyOnD4iuAOsC2855cs2gFRYLXXEQgg+gA+LZ2BVbwmEJtPQxkbxrDc
	 RID7Ms7FjcyAkYkYfTpYXktR1GKSC8KfKLscVn+U7mBw8388PPCcnEVQMETnIFFAQQQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788771064;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IcuGa2wv9ab2qPltCsq1aQpDkOBEV3y5vSbuEleTRlg=;
	b=C6/k0yLTE41KhSSuIXJ/vHbj0lwgBKnN2LHuoYIzOB2mBLtAwaHWLzeimo1mCpsEVD2i
	 QwTmdENDptchT7fjHm5+L3OTvTI2Y3ZQJrX1lbYsSeWdaZZKV3YMHeHAReW95+2WUxTBo
	 Mmq5eerGUeek04qBprUViQxTCc5UXlNEn/b7flShWuYQXlfy7rnv2gEZCdcKX12tM+Qn6
	 QpEiMzv+J1Y+VTIGcpMYwpUwxQZSOWTILWucdckUxE485At6YGhp7gx7S4VwZBJnqrNl8
	 eqFqea8vH1E7OXC1LH76iZlkKi6qATTR2xHpw/yFKRo6c0D5B74Ko/baPKOrofwr2sw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=mDxy3m+f;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=QYYPWh5H;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788771064;
	bh=IcuGa2wv9ab2qPltCsq1aQpDkOBEV3y5vSbuEleTRlg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AMrf/7HYyMC0qNqQWyM4p421i8LUTCw99wBzbP7RH5Sb3/H4tvhx43eWgVr8PGp7Z
	 DornuYbz2ix4k7kfIAZ0XnFNc5zPTyIJ4cX/L5iFUMHpjYGl1/8d4jGe+V+QmmxQRb
	 NIgFvAl5eWJsGJ4VHIxBFzuT15S/anW1HFhKE1w9SmA7yYG3xGy8VKv+NQ1GYh6vfZ
	 foYvxb695OhW2Esr6XLEpNphWekt1Th+h4Cn0gA5xgLJLpcBlI8aY+3HB6Lr5TGIJu
	 FxmDxJQXFVWFDAwxtnzgxWXiK2VMUC2gJz4Tx4mNzsyTRQkpYpv7eqvuaBqEsMnl2c
	 rgvHcM/aY2VQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A61DE80BCF;
	Mon,  7 Sep 2026 08:51:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6090B72C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4615280BCF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YAy3d4Sm_Bca for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 93A4780BCA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788771062;
 b=j6BwXZ3uNCG9gXOZKvsvN9XhAYeK5lp1XCDf9T/AarxZp7SzIIciDI9SyxbY8q96xypL
 vFcL4WhiYU2F+jXlqQGgF5Fe3R+nrn/p9/c1hQYu3ApIHgw80I951ukJOmKeB+tWWboHn
 TFjcEe8RhHE/IAE7IU2i/96ErhGNc13bGhLw24+FI7raC5nl5ObhngHDFlZEe7nXnn99T
 q8r/CiGTO2Xhb1NZ/OSl2AObeZIxtUBt1iUfA5awLivWrzhP+3nVkBrGSpqnTrc88n3Ya
 FLgzXrk/Uc7+PnLEEV1HNpZ/0kdeetguUz7rPJCb+5eO887UYxSWbEp0NhiCffwL7JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788771062;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=IcuGa2wv9ab2qPltCsq1aQpDkOBEV3y5vSbuEleTRlg=;
 b=iVxRDrCMTTDgiVnWnPM9vWbUdLNmOk39DI9T6wxjTcWYM8q2ZArhGKfdJpgsdw/tfhu8
 HBwexnxQNosR4KMmEPR6jlOXznhTmxtaduEiknK+JOVtjUaL73/5SDL4BWpCZ9R42N7d/
 n8SiGuNixkV2pAfxT0yDClMZGr74Wsuy62d+FR2WLG3eONpdKxxc5blZAsmQQbBhZYp77
 vmjVn5hzen6wofC6WjQtoQM/6W7wAuMtdnJonr2iLDoBjPY2D1LgsVsRToKcNbYgYp20O
 iuOgGfpCO2oxj+FNmtzCRjuhl6VvOkqivyi25Di3Vm6aby3wajsfRQ2r2nFWvilFzUA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=mDxy3m+f; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=QYYPWh5H; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=mDxy3m+f; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=QYYPWh5H
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93A4780BCA
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:51:01 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68775pcR2615411;
 Mon, 7 Sep 2026 03:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=IcuGa2wv9ab2qPltCsq1aQpDkOBEV3y5vSbuEleTR
 lg=; b=mDxy3m+fCAsKLScxaZyUezsSuIn1wRaBVVwLFdg0pLiI5La97EeJAqzX3
 78fduaRXVNBLADg7THv4AioqSYVF+1bcfMH9xOrzLF+iURVv6ggYVfVOJg8fFhLY
 LJlCtSMORCycPYrszCy21khm2Fe+jrRlHLIy4KX3xFKrfTpZEnbKxrfEsi/nOFQm
 7qCHnj4cve0OoWVSnYCEosoGnlx1ZBc6NXPK2L7kFHZhUbBAasB0e6pTdRHXmbPN
 DpYFgH3iJZgzAYqq3Yn4sf91F8ZTi8SdUJ7zjWFi9JI293QRj6KYTFfqlLAX9XUf
 k38/L0s7CFAAU+hXVCgaVUFUxQDMg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gh43n4rum-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:50:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNTyk39UfB/qbAeCvnBxI9dL/Y3993R9iJ4t/a1eg0DASPtGw6rVDMWLh5W5BFmdfDmrU9W94FtDTNNJhshnq2h10wTb6peoEkSz6ffz0zo/ADmru1y7REGpxMCv53oblZPJhw/L5ooB6boYxSr5AG3fwrH8UV8VDcIJ1Q5t8DwRCRMHuE7l3ZcpSJ8CRCv3Ky9E5P8deenW62NrwOYeZgdchaWnXk/eC/D1YbRfRHnv6DNzgsOIRrBdlpHFpd8gEBXllqTOSVFNfqWMBDLj9L8X9zqynB3l0f6sD8xShAqZ6SOnZkNjKr9SbFMB+xI0+WawZjvylh0ffDnv8ZDeqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcuGa2wv9ab2qPltCsq1aQpDkOBEV3y5vSbuEleTRlg=;
 b=F7cb15J25btxaQ8jGr6GgxGB4P6etCrAIU6pkgJElRsfyT3YVPO7y12ld8o2pHE46RIKLVE+HpZanfvUiYXOrD+QT3DaNnbjKM71JEK9+w8kldWmcvevLezp2FLVFzKgSmlZDfw8Yo1OUhHYyZx5gpYRr1R7tSv9940yo9Feocmko08YmIrJqWv8/3k0AbLQiqjv5t3yVe1NZntSLae/Z0HwvlLhVY7UkAYTNTt5xWDEyA0NcANw6TkDabOAOnBstCTuRbSQ9T47hiOyFurFvWHOlbJIlot0Ln4c7SH2ORg5Qr76XK7lxSRgoiUK6p1N9zL0qqoi2pBm/Vrt5f8Hrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcuGa2wv9ab2qPltCsq1aQpDkOBEV3y5vSbuEleTRlg=;
 b=QYYPWh5H0oPlvBu3otVWogedmS7uCZ8bglc9VmoAGDcZ1/2LVJm/BKBGf3uuLqjLrY9XOoe3vXuzclJS6p5FEs4iUetaPzUMLilrda1JbzBQgWQQPicWYWgGszc7KFYNFPUzuAM4+z7O2flxe3J9h1D61/sXqCawtdwBSyidUks=
Received: from SJ2P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::11)
 by MN6PR10MB8000.namprd10.prod.outlook.com (2603:10b6:208:4f5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Mon, 7 Sep 2026
 08:50:54 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:5db:cafe::6e) by SJ2P221CA0008.outlook.office365.com
 (2603:10b6:a03:5db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:50:52 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:50:39 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:50:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:50:38 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6878oYQC1192638;
 Mon, 7 Sep 2026 03:50:34 -0500
Message-ID: <fc42d7fe-b2f1-4fff-8461-89889843b122@ti.com>
Date: Mon, 7 Sep 2026 14:20:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/21] arm: dts: k3-j7200: Extend firewall for ATF
 region to TIFS
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
 <20260828135730.1565643-22-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-22-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|MN6PR10MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fa0c33-24de-4414-20eb-08df0cbd1f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2vEsXuSwy4mg3rNjFogzI76vx1urFDoRPgkAY1s8YemmTaIc/CxHZgGf+fznDwIh95VhEUPbQkj942hU4wXrsov/bi5oMRXkItAICsNoL+xCpmFMVTLJ3YzC5fDUglpCZMG2WtCZM1qejduT6Ae7bQL+/82bFlxikbtP6KNulyo6bYikQSPzYZVC+KBHC7wVHxBq7v5nKUMWsFjwsiLhhUmSQMmmJzBZaGC0jy0XiZf3Xp3AAhOKrgei0W76T99OKUWrCLrvXb+02hxYmqA2J9h6SRmkZwfOUx8IlGFSpx/f/7HqPDuKPgfjdJQ601bPEiB1mcbyN0ydne1q+vVYLkiSqJJmHP5cuLsFkldm1AfwmpwmzS3yQXFENhF4eVD8bP1eC3aZatEC1xHaYl97/XIODr8kJRdXxDKoJatOA8FSvYk+BwdM6Va/HJe3z/UPF8NGpypit8gI5nkn7x0d2KoOujeXf6IAM7BWV0dAGyRjkKpgh8QqnbrShvzvNm/4CTrKCMtKdUUsUIR9nD9YHY2X7lMVhndc94EMHYV52luE2pSHm5zztKKCmz9cpJq9l3WK5x5rILYC34ENFvoeTZdQpLG+sXgYGyzxUnAz56z8nFwzTQhOFhoICfI6fOf2681pt/GjGXyCkhGv3uOCiQZMMCmAT+5AJUu7fJ+1+oeSKWux/FxJhmh3/RIjUQVVlbePHr0umFmCt3jLVOH4yw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lYMZ95AndoE5sTmt8AhvNIbTf/D4UzmUf6hEJahmqZTS+i90MDiWHyr6CS8f9hAidUH4f9NbOGAJPrmu7mw54SzYL0TvnAK2z0SdY5m49rGvpu5bGFEpsCRHpkgWUUMpxMeQ5NEHJmqaV58v5PqVgRUmk7ozMSw9Gwv/+9Xsx3lPiNcyQHLxhP7OLHdzrTsdl9szzGzgZGP8ahxnATIW9DOPIZ/ECxjF0E8/95APUewZhHT9ZofSaxO+pjqkzxK0giRrphwf/F2WfdIJm+/hnocONKqB9VpHwYFIj/qCbA4OIkocVDptTAmpUOznDkHeCxKipa9FV4eRgkFgjemmuGfCSdYeW6z7kNj13dQW2wyQixZNu2XwhM3t0qjQJFt7D+arNqxWKZlHMfe7b/3aiupkylZcNKy0C2GUoa+2TM9zFqnWlPnXX+Mc0i76RgS2
X-Exchange-RoutingPolicyChecked: mWMZ91/ViZkdBAg+B1gUbH121wFgyXyTwarSLDK0GNDBhN264AkvAMeN0q/xMMQL5wlh2hGh6MqCl4lIuPcDvGw3RO7f2o9qnJ1lxSzCuq8SCzp0M0OUIRW4QMO6dtzZIVM3py8zlSoLwiCOPb2nonP92MKoa85/sU2HX3lpiqk1eEsQX282/pczzSfXp2VqRKbstlwa9jTgvEEpCg2mu17HT/G6vinUhKjpGIZhb7Aw2G+ySsKEnHHyvh+nR7wPSt03lWQB/CdqZZvV1nRC4xZs9qV3EqRfj8EuzDMCGNqf/seFhzhfD8px1bLTpi0219wV+Zw475Nzq1D9ME5y+Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:50:52.4199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fa0c33-24de-4414-20eb-08df0cbd1f6e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8000
X-Proofpoint-GUID: wy_LzqKT_e_2x0civExi_nDfeVGgn1Pa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NiBTYWx0ZWRfX4PCqeUDIVgwJ
 JTMHzt8SZ1e9yatUeO+rDnF7nHXLQ/kZu3RXJ1vZZwb5p1oPblqtB7AKvqzqq8QezooeYv6e17e
 v9+87xVYyKFV/wpjf5chq9ToxBVmRDWmCyAL37a5HmWXShBPx7Ql7zsF8G9d24H5Ji/3WHbFsIx
 lkqEIYfspCD5G2PCZs2Y4UuwehGCTS9fpvW3hQTUPZg5m+gv0xdsSGUuNq/AIFGDKqi3YkI1E0E
 iUqagXizCk+wzf9ndHR0zWOT4l2zIjUF5Iv6vQmXf2iIAT+T1lY8+XNZaRa8P6VVMK3KxgrrzBS
 vLZ7V2l+KcglB+d1vcbGC2Hh6Jq4m7KeUR7uqGK5XOA05p3p+wLXvuVeZB+6Oqdjmt5spGWqM5J
 KcqPyILm/myyM/Nmnbt2vKvGhQ69Qu6eNEuvBT4/cZ68TmcMJhF/dEeTGQmytOXPCRtRMVQ3YJ0
 NhnFzEXa2RLpeLWvvPg==
X-Proofpoint-ORIG-GUID: wy_LzqKT_e_2x0civExi_nDfeVGgn1Pa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NiBTYWx0ZWRfX7GRH71ngOSA2
 +Y3flCkufRV7YSH81qEf6fyqriTCqYEBrsFmYegRQrh64DAkS9vu1hE9+183L4ZzTpXrtzWG+vB
 g8oVPZ8Ggqe6Be3Z1BsbRk6KIugzrxI=
X-Authority-Analysis: v=2.4 cv=JdSMa0KV c=1 sm=1 tr=0 ts=6a9e7af0 cx=c_pps
 a=rA8xTxhMCG4Q6PG1LLvkJA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=P-IC7800AAAA:8 a=BmZN3poPZwLbovA9AcgA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070096
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
> Extend the access to SRAM region of ATF to TIFS as well. This is
> needed for TIFS for encryption and decryption of ATF as a part of
> low power mode sequence. TIFS encrypts the ATF while entering into
> low power mode and decrypts it back while resuming back.
> So, giving permissions for TIFS to access this region.
> 
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/dts/k3-binman.dtsi | 7 ++++++-
>  arch/arm/dts/k3-security.h  | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index ad127663d03b..1cf417ed7dcd 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -475,7 +475,12 @@
>  					FWCTRL_CACHE)>;
>  		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
>  						FWPERM_SECURE_PRIV_RWCD |
> -						FWPERM_SECURE_USER_RWCD)>;
> +						FWPERM_SECURE_USER_RWCD)>,
> +					<((FWPRIVID_TIFS << FWPRIVID_SHIFT) |
> +						FWPERM_SECURE_PRIV_RWCD |
> +						FWPERM_SECURE_USER_RWCD |
> +						FWPERM_NON_SECURE_PRIV_RWCD |
> +						FWPERM_NON_SECURE_USER_RWCD)>;

LGTM, to give TIFS access.


>  		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
>  		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + CONFIG_K3_ATF_RESERVED_SIZE - 1)>;
>  	};
> diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
> index 33609caa8fb5..3e066bca6ad7 100644
> --- a/arch/arm/dts/k3-security.h
> +++ b/arch/arm/dts/k3-security.h
> @@ -7,6 +7,7 @@
>  #define DTS_ARM64_TI_K3_FIREWALL_H
>  
>  #define FWPRIVID_ALL    0xc3
> +#define FWPRIVID_TIFS   0xca
>  #define FWPRIVID_ARMV8  1
>  #define FWPRIVID_SHIFT  16
>  

