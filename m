Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C16C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2261C80AF9;
	Mon,  7 Sep 2026 08:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PR-1_vHeXAgg; Mon,  7 Sep 2026 08:15:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4FBDE80AE8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788768916;
	b=mnwVCOKM2Fj5G2yR/ULVtOADPy1ZqS5mSHlv7AxJ53y9v6Bg00eyxPYH3OYx5AUIPqr7
	 Iz3oZeFTdvbghyb4Jj90juKiqjwN5fohSV6VwOU+loVXx82aDSOxGrGcKz1A6wJ2iGO4V
	 gVxvu97HZYAjhSzCtpscRGD2HbZYqIv1v8CvqIcvh+Wtzn+WARItoh3JGf91oazT8p/m5
	 FRRMbVRvppulyhHH38EabPTs1G8f93EK/FebEvNRoVl+wOB9iLfF1vl9Q98O+0aBPo+Pq
	 +PA89et9EKAEpXdw69yBjzplnUBsOccjXoXtpxcTimz4hEFoZTTKaT81RQeXOUKb8uQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788768916;
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
	bh=7EbpP0dCNi3DBWYhgy53QMn3GyZsd1kCGdLxWzVBg5g=;
	b=HzM//4mpYk+q4EBJ16n1IcJ/0JytpQZ3JYknlf0vF3cUJZogsnmb3vtQ080ttK77Di7r
	 nPjGmiRPxj+Cs1lY/N/L+v2NYhKhflUqD+e/viyBwWb43xxVgCA4WSZ1WUm3keB+C2IQv
	 oFOz53g6y6Maaak4mvGMN3j95QksFp9WtXL5Jr2aEIEEeHgFOINwW9nh3IhJ85RIr76Pe
	 +Wv9OOTgPyHt+RlzfIcJuvob17Hg8tIIOE0DWF71W+B/xw892YOy4XAOF32hLqEeD/nB/
	 evCIsfTrEROVb0f8aFR+QX+Biu6v4sABlHujwZc3LSA3+0Y7U7sFkEuRZ8ujblGFpZA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=nnrvg0rB;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=FtVlU9o6;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788768916;
	bh=7EbpP0dCNi3DBWYhgy53QMn3GyZsd1kCGdLxWzVBg5g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g7JM7y7XlGEvjyJfw/AmChhkBne+atuesRegPMyJWtuUe14AlhB+lwjMkrJr+RqEr
	 lxmZNtZFe/TpoLewnkwep/bDTxV/IEETMZu6h9sNk/z3C5C/kh4eQ62lJe/Az0ntsr
	 Zxyp6v6E+zyItfPkrpVHAZNzNkFFuSTdnhwStvUrd9rUV1GZL13keAHlOhDVSDJ18M
	 dE+cuqIoUAhILHhHfBvaLLrVhP8dHNS2HsAm2C34s9oiHDyq/dxT+CyErGPIeNPsA8
	 cxPu2zMYGTY5RRtaHLgYwzHcb80ds09Qkm4A1D226wh9B5JH9j9NfjQC4QWO6jf03s
	 fknVx/G/dRUvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FBDE80AE8;
	Mon,  7 Sep 2026 08:15:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B689C72C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C65F80AE8
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFLV0GbW9Q-A for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:15:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C71B380AA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788768914;
 b=RHaac2+pHRYpPQHkqRj8BICbyAkR50vHKweI2fuLssvGbQWfqnRYAKULlhotF/Kc+/YL
 9HVdqgkeiewwAFTaNCwWGxsk05MFp1ndlJFixe59YzfpupSbq/29bdeNSJYH9VWgWu/ow
 Ssc+ANyq473y+u/gujVhsg5YGV4nCdPKUMWFYA2QfYvdj45ovIxButa2wUHe1u3q/bTy9
 MiRJoNcHRdE76j6X9j6mtfgJf9A6FmBCI/UlWKZAQQfailh0lDfYji+6tP5MBSLscGt0c
 gP3BZUOH3vP0JwuiDeYI7GIWQGcMtd3Ml557VedM3Wowyhl1iEkvHHZwuJiezv+PopA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788768914;
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
 bh=7EbpP0dCNi3DBWYhgy53QMn3GyZsd1kCGdLxWzVBg5g=;
 b=kU+t4aAlGO15esQgvcyXIuVFV1HYUE4BREh7uLv9MTHdie7O8tYwEQnnv7M8zn5ihdzO
 mtHsMdtnAwrzxMnOxm9Igk8exXhQ2Ch39w7gExt0y79Gy0dVnWSDGV4YbkgEd2HLPeVEF
 zq1lsvswoODE405Aa5g6znrppJkLmHehqClW4jH0G4V3uKTPqLuw0YtFlmV4KaGP5X48x
 l8G9We9fsfPoZitmVfF7u4YYyWZLD55iNsDVMzu52X6PRDK3ZV8fE566ui52kkB76Ln3a
 BZod0jiToDubLXunW3RykMkocz34z/RxioOlMUWGKPHELmmbknRJOeacn/shuPDdwvw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=nnrvg0rB; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=FtVlU9o6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=nnrvg0rB; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=FtVlU9o6
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C71B380AA3
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:15:13 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 687763sg863138;
 Mon, 7 Sep 2026 03:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=7EbpP0dCNi3DBWYhgy53QMn3GyZsd1kCGdLxWzVBg
 5g=; b=nnrvg0rB5FwJpLTL0yM/QEul+C+G+z4ms1EPFL/xQ4DcbYtClVN4BfuCc
 j5ZeOZ+3tGoWvlq5CdgVh4nMwug7L9EWLKnIxZS8+NwaSqRc6cznSH7uZGgvFd4c
 16zC/HOLSWtW5Jup40YZJxhtLk9Mmc00plY7wcs2OKwgSy1vVefIXEr8/36l9jAu
 DVMQ5L4EksWVSPSl3moQz2yj0YwmOIdSCa8xvEz3oiVBkdVFMY06lXkmqutQAZlR
 JIIFfb+cnYzWyACZ0GEnNZgR1Ys2IEhGbdCeLmSYpykUKFe+M5bKa6u2MPTVnG8s
 khOIiXmuZ8I97FPBgVjisidS5nhkg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gh51nmcm5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:15:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lbq0RAInI35HSlgrRTzdIQRmauA6aml3p29iKYIfsZD1xU1BG8gjiVnNpCzoW+cxUtkQDcqgY3JTmKCjvQeA6nc4xRDrhYdMQGzxSrhLuPntecfYwdup//4apO8rAMYrbrT1OFO60IJmhgnqFiG7baaJRlfybcTF3ceXYdIHV14/WvO2Q+CNLWdGpY227GOMi3TsPP7JXq8RnRjzt0B/8heXQsHLScjyD2irHioNfa+dIiFQKS/O3SmAqVOoLn3v6tAtCwdz3K+C6IgyLReMTi2arn3p3SaECDKpWVVbZjrqVVs5HqrOKdrFcmBi5Z/wKs08hHEFD6uHZ42RB7lFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EbpP0dCNi3DBWYhgy53QMn3GyZsd1kCGdLxWzVBg5g=;
 b=xgAOFctzAEcyhvdpnRsEXca1VR63f82TsKQYepYW/7vUmR3DJx+J8EoOA5BwdIwdk1D+gKQ8AyoVWBHbE01zA7FuKvSvTWjB94mqAzCU819qKnLZshkilanO5JO1C5SGXyt6khlxjd/8ue8NP4GjG9SetZNSnIpmtcCYRqpQNX3SGPK51bADZWN+F330Q/pt+48YXaqtLE3lYdOuSehAPohKPlqXrmafex1GgirxSjAF1xY0JdY2/j6YINsZx2rYu4t4SwvbpWnHCk+wc74WX1Cd0/55zUJXF66h/Yg+TENMahOSfyFGFNekL29uZRqFo7b51Ce1pXyjcaO3z/8mCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EbpP0dCNi3DBWYhgy53QMn3GyZsd1kCGdLxWzVBg5g=;
 b=FtVlU9o6kkFqEeHITFHBCClHvRXVL4S5UqgivX8hQT5Gigbgdt+YWF4FoysF1aGRtuxY0pkYUk4Wc6x/PL6LWgEhEf4e6XBjPP5UiUDwNLDkHKhCy+kxC2W61q12RfJnIDGNrLyzJTXdCqgq8LI329GWojR86CrSezAwxnKaBUA=
Received: from BN9PR03CA0206.namprd03.prod.outlook.com (2603:10b6:408:f9::31)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.6; Mon, 7 Sep 2026 08:15:04 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::6e) by BN9PR03CA0206.outlook.office365.com
 (2603:10b6:408:f9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:15:03 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:14:52 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:14:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:14:52 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6878Elbk1134717;
 Mon, 7 Sep 2026 03:14:48 -0500
Message-ID: <c3711f46-a1a6-4ea0-b54b-73759165a479@ti.com>
Date: Mon, 7 Sep 2026 13:44:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/21] board: mach-k3: r5: common: Set PMIC NSLEEP
 triggers bits at resume
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
 <20260828135730.1565643-12-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-12-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3e9e0b-5177-412c-7785-08df0cb81e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|6133799003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: zgDFi9OO4N52XWxwiLS6Cx2ZMa0WYWi3l4OgC/3/TwpkLIfSsjD9gpS3zzo+6cWHZd4IgvbLlUe6UftmjkQD4+R/lGBGRD7ocYvTjXk/d4UGiOWzey+5ZovP+1TM7+AbKSr99aO2Df3RidGrxqoZD3Gy4dSv/ZnGDO4LzRruHcAZHC0tpsaEEqiSv5IQpC+2V+jOJE+OTziF6Pb3YDxk8rvEUZD6kSyuQL4DSO2PLXukuEX/JsSVXax1CVVCri5OqXNFJMGpe7yEQjyMCGQwHXG2l4y4+4aGatj6KNBy/7EoqZdzsHBlondstffRNxG2MQmDzuDcHqO9BVCmNTMCOKKsjm47dvFvkZbO5HOjLDZUAA8YJbBbQxu20HDoi3+6zCp7i25vcUI4A98pyGwrnqe68NxjNzdrau78jzWSBb1HhL4yUq6CYNlF2lxtE/s7L9UTuNZecsI3dAw0YgnrIiQChFo5zNQs+CUe81Z9w00ANStAklgEmPRh05rE6uFM3aRO5jNdaqtkRguRo4HeHoX7CRfLa68YhYngR/Uv2gOYUeXwKEX58TbXQuL+EV/WI9xQOLyqP7fC1nkQt0Psk0Velbtxxn4WyY4Pe2TSq0gRjds4JKCDxAuQl+4OstveTooIpXjEdIK318GJb71cptE4b5WP8m0B0QGwYTr9VASKWUgL8760SHEqQiKHURe3hcqAuBNPtMTYGs7in9hZBA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NOPC4RwTmRKTT7otzIHOY8iS3b7C5NL6Wrd08E1QJrJ0Vsbi9HhB+o5VYlswEsu6Xx/FtUkwfFkNsXpDO/pexwtbk0TokPD9pJA6GkOdf+GyGMhb3k3BesqViX+PdCKehpGEVq1Gmo5NXFyd/9wnBCFMnWG+wnEGzHgpJY2Q6sufdXiBxipfWUmyiWtkA9CfIBhXbVa9x4ftCAKlFCI/TO2RiYHiriFQler0m6/bL7kVhH8BV149ceC6siCPIzk1beAsoR1WEsNdAvr9gqcE2pRavd5YYg2QUeYmVYmZnogIuDu2p5H7T6f/CzhCeDorCfPa1upEwPvC05B9DUYnPyYMNsUcmo6xTZhr5N3trcaGYPXYtL9xuMwR3QA9Gtvx3pyKJ/ZllBXmfPLA0i5MAJtxOCBhYLKtUVlyL2VPesRAfQMYIAWbCEmrDR4fB+Zh
X-Exchange-RoutingPolicyChecked: oFWaemGfGnB4SwQlL/jTM0EfLhVoJFMjiWm82smuvgzn3I8B8htwghwSDTNLhS1/1d7rcJQ9CcETIfKnbC2SbWb62kAv17+mOysVCwMseIEEWHKV4lWTGPtT2jVnZFXCUOHug0iD35t0txBETEz318h9uPHCtZEy58mCIDRebNgnCvH037guaBosFftplAwZQ6Om1fjFpaXbThUyLibegrz57BkGpUnG740roegQh/PSX6RRqf6amEHhpRZSgNXXbBD7/9ZYQ9rGz8Qa/DB6idm+fZox+EC5q0hlizBAw3dWTX2DLUeIYgwY00MTwN3wGBtQUhwvj/dlMkeKQ0OSLw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:15:03.5671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3e9e0b-5177-412c-7785-08df0cb81e99
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Authority-Analysis: v=2.4 cv=J8GaKgnS c=1 sm=1 tr=0 ts=6a9e728c cx=c_pps
 a=ss0k+GDJiFel2I5peBRHfg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=P-IC7800AAAA:8
 a=Mbcd-q07g5ZnHJK_IHgA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: O38FiAjdciAfoYCzrcuzopkOXFRWYrbi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4OSBTYWx0ZWRfXzQpmqveMgp7M
 zSH42Yn86I8F/koI8c4JXOuAEf3SQZpTaDnigpwijwXrdDlSlUB4NQo70F0IKCEvifrFEZMQ7+e
 u7efMRYaRlK/JZTOZdzcxIYLWhbNQfYDIkWNRwEanxbQt1zHfAz2FyLVLteKGGUv0ZpEu9gdxwZ
 M9Cx5j8bSKhh5Dn4hSIz2KDOeYxqzu+gC3/Lgg7NEXqTH+vHRs1q0f1fRnNpyH1gbxcwwpLj6VE
 Bjrc947evShAjJljCpW+Q33AIzqtAZhS7ZbtTejRfQaDQDYwutXOKuyj2+8TVrxHcUmr/7hJli4
 FY8KunMiYqu17Rhwsytw5zYsCXgFD3ONIBVShI5lhFkUKsw0DIIM/e61+rNfncww1aCmPjFTqnz
 ZUfrbIKXgWyRJKy7XeHIAgsxwrDlfpF6OjgMNO05HxLZxXflDHitcQDuqPvADeIMyc0ImkH0LV4
 ift8mdw4GEFBgQGArSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4OSBTYWx0ZWRfX0LztoSOjsC34
 nj2ehf1vZpY3GRjFxkm7gct+zUpnIeV/hmBRoA17q1ayWZSaBTVqSHOnmVcHWtXpyrntYx3eejQ
 B+3w/DJ3L5ZFwitdM5SYne9lA1JH9cg=
X-Proofpoint-GUID: O38FiAjdciAfoYCzrcuzopkOXFRWYrbi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070089
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
> If we are resuming NSLEEP triggers bits of PMIC-A and PMIC-B shall be set
> to prevent transition to S2R state while clearing interrupts.
> For example PMIC RTC Linux driver accesses to interrupt registers, in this
> case if NSLEEP triggers bits are not set it triggers a S2R transition.
> 

do you mean, if nsleep is not clear, then linux driver will fail to resume ?

> Suggested-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/mach-k3/r5/lpm-common.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
> i[..]
