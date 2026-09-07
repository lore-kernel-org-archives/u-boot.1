Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2C3C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DFAD80A75;
	Mon,  7 Sep 2026 08:46:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x7JzW1ZPdNK1; Mon,  7 Sep 2026 08:46:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D0A780BBD
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788770785;
	b=FTuyri63BakaUqDlO2/nr2iGI/bSN9113PUCTRbXMwIRpBKW1dFtdJWKNrynDiYUCno4
	 rVetGS1TwWMBSMxLL63UEP9NqZjwp3Ntw5kb5PN9XJ7/49ohKORJdq4zMbbWiSoPOC1gx
	 r775LOoiQtrWX05/gCfKx+PNHZI8c2l3do3V3awjT/ESoCgKC/9SjW4yhQiUMWmR3G5DV
	 ++b1jbLHE1iPuSSb5LDj3YWwiS2imzPUUVNbfsmfgbfaALYy5St+zA8CqCNIkGETNCI2J
	 Rg2zoNZWrEidZE3/vkc+06k9+jzMXR4QM2cG2kHi69LYSnBxZjZ0AjPNKrCeY2a4CpA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788770785;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lIG4InGoiQ8NSjOIUbgAiMNcVKTqj0yR1U+0M52QOaE=;
	b=F34lnImC5AkFgDMj1h5bFbVFRK2u42VE+afvGA7eFYgPaTuHaxX8CmYyJzUHifcvzczw
	 D4hz5KYe2uBacZ0ruxBg/E/g7CEhfrsam8vNs6A4T28PGNsXUy1e2hriAK9aEGcBBUJ0n
	 fIaRb27J+9LndOOA23VZEOfAbHWneVlEbn6stSRL5/aBfYWXzYnht6+6Mca3hwIB/okqG
	 EG9AGoPOH3UVolQM7iPohPncSYoDNllQ/4f7hhs7JludSzzM+DFgMl6ov0R2frocy0U+D
	 63yF2gv+5SeqL0OjWjRlS6qGkg52pLnUrNPVscaTZd4f5whyMVBF3yXmbSxVhS8CKSg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=owksW5mD;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=ZpsnkD7+;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788770785;
	bh=lIG4InGoiQ8NSjOIUbgAiMNcVKTqj0yR1U+0M52QOaE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VXWKReBQ/+Z6PyrjMy7+98yF60UlM8sOE2wsjhw4yJi9Ba0Z+EknSx5jfFjkr3Trt
	 GTkUJyx1AkPdHMqfF27mSBHAL5QbQtc4bKd0JG9dUEDj4jrY7/T2QgXIBrP8wq0zAk
	 bj2gcvsJ0LWMfWJ1jKYWQksG2Tth580hKSqPkglbOIjjMjQGyj7HICyEPAzfPcOIUw
	 SVYANT5pAXSJVEtYOyWbzGYxd8Jj+MQ3aQl03q3xRklDEE75GlySHNeIiR2HKCYLII
	 dPOg6+SOpakpARZKe2NhD7LmRL0BAJOhGgrtNWkQtY1JWc7ZtA9HIBZzbtIl0CrpDi
	 DD4rc7pHgIKWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D0A780BBD;
	Mon,  7 Sep 2026 08:46:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 28AE32FC
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19E8E80BBD
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:46:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z_-wZV8eY1o1 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:46:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2BD7C80A75
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788770783;
 b=N0xAcNF7tYMc6l3GzczT48vsCK/xvW15rSQMUuUB4SHx6TsOaHBUPtF6DqdAJlHwas23
 sYeT6bnKswW+a6wWK9FOycW8LKHJma3D0beJeM41VwqMiessh43bGEWEIye1rQJRxAX8C
 +61EJHXSXPQpLhQ81FgeGxf5KxLpKKKkkWlKX/9U0owfEbBIaOSxuSc3LX2H+yD0WW1iD
 KTRieklGyedH7zo9gDgXbB5Mp3WPSP0klQsM3nXeGxf3qfrb6vMzCxeezWcWXl8v3C8UL
 LABExljUDoAjraOBW+HW+TlMhsEcjr0Oy48LCsC6x23Pfv+PFsIbxi+fpEwzoNisjLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788770783;
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
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=lIG4InGoiQ8NSjOIUbgAiMNcVKTqj0yR1U+0M52QOaE=;
 b=MUvddM45iLFTp3J2GbIoLLCugBtyOaCebvQuQHGPnRN5qUm1AAeDhmsWHDhWWp8eV/aG
 KDzCmM07rdDOwsiPcstcbCPv7gCzUd/isNS4q9kBxGMVkeoYe10PzOo9cooG4wYk1MXCn
 egp/k4LBYAuHmrFDzLMtTPgep5yTdWDjgzWAHIRHjYZUKmf+Swd1okzzWgWE+pOtSyCU5
 ddBNpuFR2E5ely+nmTpfd5dAPsV6Ocg9ve8bhIDWZcIj3qo7/xXFBY9TqXyl90n2e6YQc
 mcd9ditrPeRYYukLbdn501fcyjGaeIQC37eZ4Mz79Ugp5l9gKtC/HUWWlxjleoYEouA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=owksW5mD; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=ZpsnkD7+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=owksW5mD; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=ZpsnkD7+
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BD7C80A75
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:46:22 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68776Atl2415498; Mon, 7 Sep 2026 03:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=lIG4InGoiQ8NSjOIUbgAiMNcVKTqj0yR1U+0M52QO
 aE=; b=owksW5mDQ8AFbYn15/b77oIeEqIZn4HCCndouuJzoVQYWdyZEvTGczeHM
 vGZyYo6Pt4ySUlDZjYVmnUtDDBIXj+bqhWnBTaVj2fZaFuBODBmDnuUUDhWc36bF
 Z/oU6C3YQuAqbQ3TvxXemzWHNeqROlILNP/m1tEJLce6sc18dSGIOLWaPumvi2j8
 BYxZ2+tWj2Uhe+2Vbp6/36x+TdaYtal0pi72g+joA8sJ5tqzTa2FuYBGxA+niR8f
 ptzGUXhoY2wBdCMaoPnygdK3HFmS4ycfOFiRxGaD5lKRSN5dbuuhGO4K2k5uY8aN
 pWD2+8ZaTQJcrbSDkSXJVqVa0W4yA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gh27q4x1k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:46:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QP8/PeaVRZZikTquhAoTFt16eOgYwXYkrUpRqAhYX/DZnRt2El0oMmC7dpO6HU0aYhQVDeDL29b4lsvPYC5dZ1cdFtRw5jDJj1aTVI3B6qZTa7VoO1mDqSkWlKon/r3bzYVxxABBQRAJv+4fiTKZRAEEqAZX1/3pt1/yhFI3TwE6Zfbl04mqsAfkqdVia9rL+4AXXgKmlcFQtBbQP7MvtH5rUQEImJBAB+9y5jsj7BOg9dKF1djlChTM5aywkIxxCX5MZtwI7Dpzd8dvz3c9TToLe/8G+ZhR3qKpM5KZ8ZEeaT9e8f2I3CpRHZiUm309IehHx+Ks6CGLnkZ41Jnl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIG4InGoiQ8NSjOIUbgAiMNcVKTqj0yR1U+0M52QOaE=;
 b=n3m/+cMkurNEigpHbWv8mR7IYf3AU68XwXs6IxusBsAXIA0qN4CU3hj5cUU558Z7gwINpzLrH5n25qnx2VyGZQkrSwhFZo3juF45+WskmO/XtBz8UU8gWFYKuvrhUgYVtt90HKx//zToJhu+6Jw1IGn39fuvdsQJ7w4WEZgxT+qBd35VZ378tuC2hKtdMgLhw+8vkQRODVQvHp+YXGaLZQGHbpxsKUCSc2bt64LJ5VlMPQD9IgBUeNOi5Y2gshbjJYwhpOAMCumFREEI9NPmVobfu4zI6VO07u9HIOfM8bFkGmxgg8w/E1JABGV2tjm8sSBSEI1ixkw5mLsw6nF0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIG4InGoiQ8NSjOIUbgAiMNcVKTqj0yR1U+0M52QOaE=;
 b=ZpsnkD7+ykIv5aYsyCqwPdkDH2SM8ypGihWyDl1MMpnDTghIjY6WMhYC1ih7jsmKJzzcmfkdE42rUhCC0mBs/R/ZK0fQnYNSFLGipfDHE0A7RAIqbiJFRC4jxy8AWWaxfHgEDcQXyIF0glloU74NiNEExYHuafy9XrIvxwBT8Wg=
Received: from CH0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:610:32::7)
 by SJ0PR10MB5801.namprd10.prod.outlook.com (2603:10b6:a03:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 08:46:16 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::48) by CH0PR07CA0002.outlook.office365.com
 (2603:10b6:610:32::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:46:14 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:45:33 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:45:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:45:33 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6878jSAh187826;
 Mon, 7 Sep 2026 03:45:29 -0500
Message-ID: <7e14ccad-eaeb-4946-817e-aecb133e1cb4@ti.com>
Date: Mon, 7 Sep 2026 14:15:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/21] arm: mach-k3: j721s2: Enable LPM resume flow
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
 <20260828135730.1565643-19-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-19-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ0PR10MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e9d66e-1e2c-436b-49b3-08df0cbc7990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vO0drMiDoVLcFtJN4sdW4ARGn0QHH3AD8kV49zO3bziAi2U1fMQHOG0U1dZW2W7ofm9bA/tFpGBP+71O0Kx47hfTN7Btffq7/pysr8wvYUKc052wXAK7tnbfgX2VHPbdyDMNZdcSDOv0d9QX5pTZyEQPsbZlKx90AsCiTy9B2S3FSXL2+rNxYTG/fu1zyHPeqsauq2ShVoV31Wz7UR+CdlOIIrL+p+/iKM7qcStxl3pp1XVAIAmp3cfBsnTsnDuSZC1MhmOF2jSax4KkIAo8y/aZ9xlsVjL4/bTDUxpOX1WkMFVsNHqdV5qV1QrYAk/NtYBZQ/cM8aAcLAj/s648myDpBPy9iLcoFU3MFKIRSS5UBnnBkhccBYNeWEKgucCdmfzWIcsF9kGFb0iJ/hG6cMJdUpTk2c1A7jBZL1Z//EDUfhXzUjjsyfcgrlGQ88kANHEX6jl1IlXlRKsOfoEZFiJg6Vj1U7aPvM9TDivt4+LO1XO7BZ9p2QkXvvEL1g6XB0TA4GmymGgMsfCfGbtiEvPmFgrvpnUnNszK3HS3BZ4ZI7511lYnGccu5ejBTiS90lj22iqQeCDHvlvW5zGoIWE1NJylr7WBvMNN3mDO5gldCvMPzSELzO6x2ztrXU8tHJLVV6uKkHvgh2xrswpkIJY3BACtLEPbhID3nwjQVR+7cYFwmvX8dqomE2usMpTYOaMHtFGdTosQbYe0TRUTpA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GPtRAgD7PvCkmbLjrAYFuDi+qc+6M0XuaI5Jq7HEKxHnickvOazcuHbYQwrC2VwHJTIMdoevsu2wI+WEBnN7301WeTjgkYF3ZhnEIGRO80D9LLss8r1nG64E3/JO/gP8c7AVkuqictj+DxGtVpCk/BxZelvV27J1sJCTjCFtX8yKBNJNZHJUoFxcGi7nuPxDlMQSmX4uxRkqkGFtuFjGTd5PZavUBAW75ftHurlrn8eOXcMyh6ngOiYHHNPfSQlIIA+ONjA+E1w/XZ0M7l6fNnunAchsv/DrXXqAAhc25+kYOhPH6K5ARoq7yX3e6v4skc/CNUaTIhyQm8vQibozkI3R0dNz0Vu4g33XyZAnC6TOHgd/dCfdBUaysmzd7cWgM9HKa+cXim2LiPC3GzJqbzYWAHA3HFtvfuvxTLbCt2CO468rL9rNSde9tO6cgl1l
X-Exchange-RoutingPolicyChecked: wpqkXYQoDU7RE7a5wk+z9r0HH8hPKN4Pz/g36x2MZWUecBQHcz6RmphXI6UEhvJubM9fAsqWtEajohT2XE5YK1OTt023SdUjTo8wCkzv1pkkrOeOplJFT0glv5pQaktMWghe8Tlz+KSgVCoezLkwUrBPGT9hr3+Th7j2j5lbMBAJOiUlQtFGv5gpPeLD8QxJpOOp2fgW4cF2DCUssuSwc0twHjpK+dq1rTl+mqfT//N06lKpInFuQB5VVfVEBX9WfI366Wq+62Y7rXe3ZgimMw4jkUjnE8l9AJ5VAiK0hVDV2RvtJ1kjyBHJ/iewBmM/7FI/25fFVCeFS5Vz3KVqTQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:46:14.1560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e9d66e-1e2c-436b-49b3-08df0cbc7990
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5801
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NSBTYWx0ZWRfX8jYoQwlgjgMx
 BkeRBgngdnnNYuvdetMSKRPRWqb5Sd9N5LGSPUZpDz5mHfro5trsdGkktKgnFhizRrGbzACeHqK
 63b/4wzg9vhFhnjK3Uy0ZXJ03NJ+mDOHpwh0G28WoIzSNKl4dd09HlJ6oEntb0tEDabX2XdIVzm
 eVZRTMN4ToB6BnQ4bHGrzqp+Q+L79MX/xMqpam2MwSEZszp4oLgjfBG+st234MRBV0YqvtV75/x
 x/KK/+9dW4uu3yWTGLtQ5p4hVCGiskNS1zLlxRIIyEsvq/n12702nvsmQyh13PSIRFbImwRrEuE
 GgpkwZMd5TG/Q6miyV3VbFzvyPsgxMDoTSkTAaWOC6RgWluJr0RMgkYmT8ejziXsF2Mk0zBOPpV
 YbilMV2D58EL5lK8dfwoDsroMdzlI7JGMGabKD/3qKXp+zR+F0H/ZnZt6xYKwuDoF1TC/+7pc2b
 p1Lt+s5w8lDiGMw0jAg==
X-Proofpoint-GUID: wovrMlKI50ZuBjrs5Rs7IR8FPoLQxpxe
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NSBTYWx0ZWRfXzxXE/bwsE6HT
 MUefADp5NyN08dKfb48MJpVYA/oHpWWMsTwkV0DOcbj0UPNByeyQVYEW0MlbUZF6RmF9yrIN7RP
 LQ+mI0tf8LRJUGYj7ccp2f+xdRftpjs=
X-Authority-Analysis: v=2.4 cv=e/82j6p/ c=1 sm=1 tr=0 ts=6a9e79da cx=c_pps
 a=uej8S9duoQdrJ4czObxKNw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=P-IC7800AAAA:8 a=qht0g8Gzk2b6KiN6GU0A:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: wovrMlKI50ZuBjrs5Rs7IR8FPoLQxpxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070095
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
> From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
> 
> Add the board specific part of the exit retention sequence for k3-ddrss:
> - exit DDR from retention
> - de-assert the DDR_RET pin
> - restore DDR max frequency
> - exit DDR from low power
> Then generic resume path is run.
> 
> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
> ---
>  arch/arm/mach-k3/j721s2/j721s2_init.c | 49 ++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 4 deletions(-)
> 
>[..]> +
> +			/* exit DDR from low power */
> +			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
> +				k3_ddrss_lpddr4_exit_low_power(devs[ctrl],
> +							       &regs[ctrl]);
> +
> +			do_resume();

Please check for calling spl_enable_cache() before do_resume

> +		}
>  	}
>  	spl_enable_cache();
>  }

