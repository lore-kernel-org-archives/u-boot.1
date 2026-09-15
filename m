Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AD5C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 06:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAE2C40402;
	Tue, 15 Sep 2026 06:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p6RMxbdy4Xpq; Tue, 15 Sep 2026 06:24:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 20F6340411
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789453494;
	b=lDBDmpmJlbOZQbm83QnKWnV2HZsYaIhFZaNYw4T36XU+mSaH/KXIQXeDGIkoq998Ec2O
	 mbuSKdEiKHjKn79aBlEAVjoPtJr5FL5MptHZ6Acp+YWWpS2aOsKB8+Brak2RHLV08wy81
	 SJNmckCrW5fHMKne2IfIwVnbDyzVm5j8LXrYQeFENOVQf0fHmSBg3jjAuBIemlItYa2nT
	 3OrYMJY7cI1tEbDpnjvR1osyjR2IRQ2mPzxUlVQlXHEizvhZn5A7GOyrYSv5VbI762I8h
	 dci2Kcbt2tFaNuUr5TS1nePKULqxXGEIPiyu2ZNfzz3H0N3FBi5PKMmzI7idqVxR8Zw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789453494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:References:
	 Date:Message-ID:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hU0y6pPaQ4U8Qx39X1BfVz75IhmxBO0t/E3yYbiX8WQ=;
	b=b7yR9ZNEmrIpLWVrYcUDSQsfO2UC1neDlKR0agqFElC/r/Y8yyVct1f/cAgLDo43iaHG
	 3gqJbGH2adWBger57r9mgJR4tnl+b+2v8TU278Bb8ozGruyoWymXl9xsb+vzdpNK4cagK
	 Yhrd0nvmEUCcEu3OfAZjLvy3dRAMuZi/XJqgWzjQADdp6/EdIMBHaEZBAA97PRnYQHj/+
	 srsXw4qIOAL2slm79iaqsFw3t1/cdO9BI4uTLuoWeaOlYFtz3pKUov5AzQExZvgnBr0xi
	 DP2wumtoUyW7tc+88ei6Mk+WkheG6n5bqplCwWlSFOHelPE+dKfk7xuGDpFpjh4XFaw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=HR9uhM2c;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=uTdiGlZc;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789453494;
	bh=hU0y6pPaQ4U8Qx39X1BfVz75IhmxBO0t/E3yYbiX8WQ=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=udAlYkbMb/9IV1OCSxOPjnlKo7UtHIeyaBJadHbYRfdRVM/IWDfMVjWeQ7SiqMcW3
	 C6Xds3jB6zZ4cH6PeEbb932//yjSkGO4R64gJjzf0OZmiU6f8ewKIuMpje8ATk+If0
	 gz5ehvFZo37aDS4EXE0bzMbLTOEFt7ivVWnZjDdhCIyMgBETuo75A8CJ9sXPQyYP+w
	 B7OMBbmCoT11Qy/EscJ1n30QuraH6g1SQO+04lqmkvYb92RR+4KjD3A3XsgSTMP2Tc
	 tnIzNiFR/VghV6uQ+iZOZpFp1F22hskNSpy5hiDny5ph1qTku0Sk7N6O8q9tt6FZIG
	 p9YFKunN0CWwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20F6340411;
	Tue, 15 Sep 2026 06:24:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E14E493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7E5B40402
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:24:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kNZhOcdzUyPT for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 06:24:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 320EB40401
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789453490;
 b=aTmHHMeKaywsYdpNnG5R2YJ+TQTNh4T5SWqu0incQr2Z3A6NGY3K5Ni0w2+zOh5vyfcA
 s4ujq+mwBeiRtdr0RisnZ3pP70tEmOQTxv9zDYFK2vcvHhGDARlLraR+DrVL1RnIG9V0a
 CwUu+6H0fC/3nP1KVUhXFAQAQJLTjrCt10tCeFTIUoagTnkVbYn/nfBWNseyhH5E/yI/P
 Fc0hv8jE7+VZOgwRz9VkpTA95mHLB/82akw5uAdCF8j4kwEnxGaE8iN5plcwpl3S+7bgK
 s1WT9URAk/kWw+gMe5kxr1nUW0F+C6T558w8/eukqsmKVAimG/n/7CoBTGVm4ZLaMpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789453490;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:
 References:Date:Message-ID:X-Mailer:X-Developer-Signature:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=hU0y6pPaQ4U8Qx39X1BfVz75IhmxBO0t/E3yYbiX8WQ=;
 b=AfN68ftaCFE51x3FyN3m4pP+MA2KUoxw8WhnrHVL44stZ0jYyts3L+Z17a7sWxQRofcG
 DRya0pDQAH51HbBPGrnGbYU65pF+3aZIVzVG4DLJVAHQXV2k/VbAtmBxQ47NXlStVI2F1
 rFqMsHDJi2wQRFllM0R43Iy1d3Ucyoc0oXQ/WGYqNN+0TZklu8Ho78CAHPKxKPNVfDJb3
 lSkOMDDFiEbV+kYrv3qk00MrApBpqv8u4wyALPBfYtpUZUA5fuU5WppbwcTReVaCeLTnW
 eqJqFqIm1Oz/6FYD0kYZH8pklyY/9GHgMBTSOajeDTju8zESLbxFRa9u/PvsZL02JTg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=HR9uhM2c; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=uTdiGlZc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=HR9uhM2c; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=uTdiGlZc
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 320EB40401
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:24:49 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68F2llsc3069187;
 Tue, 15 Sep 2026 01:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=hU0y6pPaQ4U8Qx39X1BfVz75IhmxBO0t/E3yYbiX8
 WQ=; b=HR9uhM2cSpc96URMdHdbH3htzbH8473ddHsZabmhGZrk7mZKUrVeFQRlw
 Y2nJmeA+vEqeqvZgGGehyXtC/h17Uer3Ldl4CI9orPAdxuLNrXC/DWE3yB3WMxk+
 P+85J/62x1NCGrgcm+nxlmdhBpBvY4XuzTuS5nyM+Gtdsk6Y1CanZUNzwdd+2ATy
 UO+7qGTunnaxje/0EnkG77tQB3Duc/M4nEAdDKQwy8tBkr5Va5dexQiPLDhIhG2D
 Wn2EapUXg9pGUGuxk5MbScNB7b606z/AKQrNyP0bNiOjp4ixDwqaXHf98LotX/4R
 3BfK67i3wkYt2dpZCrg+CTp7QtMDw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gppxsk4fr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 01:24:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srbiA7jF0YHAwWFWeFOAvDmB959ERhqSTYnqFmp/30BlX1xoD54B/z/ySAa5fVrBIJMX7Fdv2eyS3rMFYRAOzdx6U6py9Va2/2UVwLPdWP2X8ICALPnVKio0TjcVAy052QQn+zJBj2As09Xoc8B0A39ItGdXg0IPKcAPG7RLTo5iEeLrIjoyrllnXDc123fvZORSMY20IytI2N2nRSOIHDVgsnUzvi74MzHgRzLhxX6Y3a2yg0PuqXiYu92hJAoqwXZ4vahLp5BttVfmleBTDF5B2+1EccSJKlM+5oyGCmwmk1ECIh9Nr1ZWOaK8qk4dK7gRuORxlH9UVNol79rNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU0y6pPaQ4U8Qx39X1BfVz75IhmxBO0t/E3yYbiX8WQ=;
 b=qGueUShk0qZFmgnv4lbVLcb/RD8RPvAWhO0RSseL15u4XCpzJC1rwzY7Bx5UtX4Kh5Hr8HaD22u8Om23sCM2cUw/0xWfrTPsXFWMO9iLJrdEyn66NVkLxqu1ClLGb1ZE/FklWa9WzYI/GUu4fkHzV7U4N9LjPPQrawacx+WLD+B5R3gK/dWe0BJUEDBW81Hi+bbhEM038iMNynhl+wxc8HEFQRGetfjf3SHEMzweEtn4+wPoJk8bgZ63tZBKPqCM/aLtvVgGYLorYDlkEW454gCF87fXOifcRBGQpteoESeCPBAIxMXuy3hAitwUxSAX5fBYDg+9QDN2LKkX10rPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU0y6pPaQ4U8Qx39X1BfVz75IhmxBO0t/E3yYbiX8WQ=;
 b=uTdiGlZc65ZCKNJHKbzFX5NRMONhMeOmVrpIF8o2vnj3TuhIj7zlBwo85u0oza0NA+84smN9xh7pGKO+4rwhppfFDxr6BoJQ4CH4aAkEsmwXZoyjt75ze5YP6wDXxtb++P4wjmg7Y1lLD2OFhhDWzN0cfjC6ByT6FL/v5PRdrA0=
Received: from CH2PR04CA0027.namprd04.prod.outlook.com (2603:10b6:610:52::37)
 by MN6PR10MB8190.namprd10.prod.outlook.com (2603:10b6:208:501::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Tue, 15 Sep
 2026 06:24:45 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::40) by CH2PR04CA0027.outlook.office365.com
 (2603:10b6:610:52::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 06:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 06:24:43 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:24:11 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:24:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 01:24:11 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F6O9lh2686300;
 Tue, 15 Sep 2026 01:24:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 3/3] doc: ti: document A Core no-SPL boot mode for
 J784S4 EVM
From: Anshul Dalal <anshuld@ti.com>
To: Gokul Praveen <g-praveen@ti.com>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <u-boot@lists.u-boot-project.org>
In-Reply-To: <20260903072805.31010-4-g-praveen@ti.com>
References: <20260903072805.31010-1-g-praveen@ti.com>
 <20260903072805.31010-4-g-praveen@ti.com>
Date: Tue, 15 Sep 2026 11:54:03 +0530
Message-ID: <178945344346.1987229.4640508419624624767.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789453445; l=841;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=lMF1oRTWnPUdRESrVLAwr0TS9olA7n3KyoyX38s9G1Q=;
 b=Nu8329to550wRqR+mjdFYhaote0nAWyMNU+Gqx3m4t1vUUUEY9lSC8xhJxTinrw93Crc8adCk
 X+67AXpis5NDOniRlIZsmVF05JZ0e3tLBVFk1G9hPslNKpgF2JQdsU/
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|MN6PR10MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: a51000b6-9922-40f3-0072-08df12f207c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rI+t7MzdTNq7SfG3hyqZWhBGoVOWH+IvS3p6cy7rz6z/kkR1Fkq13+QYOh76xLLt69S17PoYvjRNPT3ce0dFUDxJuPLg8jiNf++r+ZK4TocJR/siDQbcwY8MPToTVABawerGiVPyCOpS/7+ASOwYNz6s2hI29JzedPpk9kYXn2guZ6c4YhR8ZePILxE9A5bmkiaWZ+x6U2Qs0omP7YHkHcu5GsHoG1Vz14kCxLIvjaIka4euJZNq9WPnPP1ljdFHJWT01kbZ9wjV8u6jYQmUwTDChkT98kD9sbOSxRE4elnGpcUPSH5BGlxStxSzSjn3MPndut3GH7afE/cFw6kLueCfzbwrJ4arrZkU6tu3sh3c6RgavqF0ArH/LBL3ofH18aEEP+7ltdSLGINLvjnDCGbbYospBcwVGG8C0ssz7z0PKoA6dTSC/FiZgZLw2ESG7y9q2sHBiSWHMF6YAE4FdbkVnuYpjYavFHyaEhiw0gdEc00FKGgJ10OSWcv3G7KYYGYNZuHqIQS/deeSmJe/B/jbq4uY1uBoeMrr8UqRgy//x3Nbp8xusgBAgsEuxkt6pAmc0hgrU8pTOrhhPP4GN1e91q0hKl2r1Z1XFZhk7P3zecIYNKi/VUV42k/wunkHkWntS2R5FhtfdRbpS0biEV43nU4NqJYv/BKfAmLojtnRa8tJx2IXm0MC8zJbYFbQKurhJuqENDEdkmH9xmqjpA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RXymiWidPjlU42OXoD7zUwzt4AufA5OOYtOUrOfmf0tpeK6Gg/PDC/4Nz/Uuojs+WgTgePeyJj22e5o54hlyUX1r09083G8y2Er2OkCXfNNV6gJaetL44wWlbK6rLfpOgGzXBE3Nb7qDeJZewoICuihLo2rhmkkpdGJ5rzHpH9fy7bp6uTS6SGmvHyJbKymklkCD6v4KC3Mrx/U6HkiR4L2crkex3X90n+xE3AzbowD/wflXoTmSydaFC3wOEwub1jFcOh4reBpfC8eCZ1tJpdoJQADRMnkFQUmXXr9zDRjRVFacgNwT7X9DCvJKtYCUb4G2GQjz46LVKbDlj7V+hKvYpJwFZO47EHKe+vKFremtb7jzENgU6uWRWqz8CeaxjsCUbBzE1DHRGWHMAdJTeWhwPLr2on7/sScGsjnooRdz5brw1I9yvIEpJuqe5Yam
X-Exchange-RoutingPolicyChecked: fuxd2wHAOrfcUvttH63TDia6RVsQhe7lsnHoG+8bONxpw/mAdbXACEHB0HDZy6HL/uT8Lk39ftt6Jgkx09P6v+hdZJQCBF6HDOVXA1/dL1CyqTFCfx5liLtCYonAKosdVLJVNnQ2HlyXZWACmwRXEj+B9lKMVMahv/CLsfXdbVWzYnT/M4oNWIlTuHArkiCw0/1vIQNwYti/1jcuo7oaFkH6aEhIUlw6nJKfFOpBX67ntungu7iUWfi5XYksLqJDUUj8bT4A4IPMnBPhahICRY6RAZgC9ygmLdW4pbUqxUmAyWGftk+k1RwmOIA+TMOXq8XpKlfLwt0zXxjppbx3Ew==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:24:43.0746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a51000b6-9922-40f3-0072-08df12f207c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8190
X-Proofpoint-GUID: Bh86vRm8q6kRMG-x6SRTLHNw1AqsLJsU
X-Proofpoint-ORIG-GUID: Bh86vRm8q6kRMG-x6SRTLHNw1AqsLJsU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA4OSBTYWx0ZWRfX3/cJhLZ/3VGF
 ZCBIv49Gj7Or+hpJhw0ORj+RG5pX5bpzK7yoEUK5DHCFMr3cnp9koyldds3X/G5TiQc/DE8dRLs
 ja38bHCicltWdpHr2dBtcGivw0oWFxO4XwSPzSw0iGuApjorvnGiyF86b9ycLj3DF62yjkrNRW5
 kg+3OMz6GSwJyROiFefbOxlSuPZSjPfVoFgV8iPWmo3rxhfLryfiG5QqpqLXbENGtvJ3P3A8x6j
 dx+QTPEVsi/5zN1x5lvOUnnpYGIyDgvQMCUjUajPaFa4I9Hxcty9534X0Z+8zUOwEuAHCQjP/l7
 qSHW9ZOfNr1pQpDqCDCcaEPX20/vEd8IGbdCMF6IH3juzK5QVbSPqHHJwxgi1Ygxz1/3vsD+WXp
 PwLvj748XgjS4qMEVzjEqRfj2f3vvJMtitn+nT4smNioVT97NnBVAyH79gScoXhQs1hS4lp4MrG
 mInkrsWx+kPY4UyKSgg==
X-Authority-Analysis: v=2.4 cv=bYP+w+PB c=1 sm=1 tr=0 ts=6aa8e4af cx=c_pps
 a=wszTalFPv2ofqEyTcV7qHQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=nmrM-ys5oG4wTc4DfQ0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA4OSBTYWx0ZWRfX3doyHevxHBeq
 Mj3w0gAcqDz1nVHSIR/zu6AkocRd5NqUsXGEzOQ5va91+ZIqmUpyHExyOML9b4EPQaXQCVyOtwJ
 lVm+o2MR+vQ6Pq06Y/hAlJtk0DGQxoY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150089
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

On Thu, 03 Sep 2026 12:58:05 +0530, Gokul Praveen <g-praveen@ti.com> wrote:
> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> index ec82228ab908..c3574cbdb1e5 100644
> --- a/doc/board/ti/j784s4_evm.rst
> +++ b/doc/board/ti/j784s4_evm.rst
> @@ -637,6 +637,149 @@ to the J784S4 endpoint:
> [ ... skip 93 lines ... ]
> +
> +* **ATF (ARM Trusted Firmware)** - loaded at CONFIG_K3_ATF_LOAD_ADDR
> +* **OP-TEE** - loaded at CONFIG_K3_OPTEE_LOAD_ADDR
> +* **DM (Device Manager)** - loaded at 0x89000000
> +* **U-Boot** - loaded at CONFIG_TEXT_BASE (0x80080000)
> +* **DTB (Device Tree Blob)** - U-Boot device tree

If you want to represent the FIT structure, I would suggest we go with the SVG
representation like we have at doc/board/ti/img/tifsstub_dm_tispl.bin.svg.

-- 
Anshul Dalal <anshuld@ti.com>
