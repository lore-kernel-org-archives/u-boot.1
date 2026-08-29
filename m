Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97775C61DBE
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 411CB607EC;
	Sat, 29 Aug 2026 14:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Y2VyjQ0APVR; Sat, 29 Aug 2026 14:34:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014088;
	bh=JGql5ho/m6ayPC0btEkKHOvsWViHl5oPPxyILEYyaRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m+1hhV8AWRFb++K7MmSCJ8LrYZGFQ9QwRpKSbgyhv573j8R/XGeLuQIyz+shpaEZQ
	 dTS7oUK4l+UMFwsjrbBnnoMBnbkFEHTddKkbE9+j/E7FWiuu8aoLON+eX5s1DzjfAl
	 UkoTafeajaKGTLsw6R8X/lS6FOm6EpHsu3oviK4egISV4gVeD8i8hx3y2ejeaf4Gpa
	 wOKF4c1O9zqkeZwQZCaULT4pNqoDYYJPkDigd4XG0tJi/K5CGQTzfM4QYW3r5o8kKN
	 cRwLhM4jd6NLzgult/JryxqUWWmmmDhK68QdS1l8VS1EHAWDUQwcjbjredXfqmNVCQ
	 H6YQrwXNrcreg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF9FC60823;
	Sat, 29 Aug 2026 14:34:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E33514F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8BC3C80E90
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5yTvsvfUHO4W for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=SLBKiS7i; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=S+rHXV+L
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C39FA80E7B
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:38 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67TDxonM4097392; Sat, 29 Aug 2026 09:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=JGql5ho/m6ayPC0btEkKHOvsWViHl5oPPxyILEYya
 RQ=; b=SLBKiS7iUfxOv/2ktTaSo9KJWFC1wuNM4lON9EVZb2w0a0wQKnhCUc9Yf
 cgmyOxAEdzZga2oHD3vs6yKw1nCbUQag+u0AGnfZ3Du/Ga+kG11l/za5W651XNMo
 aYpOaURtOfYay59evid+BJW4w/fdad2gEQydUMY54nIOmxO+V9ZJUSRVkcgINxqL
 6PcP5TaidmeoLNXp9B+gh8MVkbdO4RVziduJlazWu92tDU7ZtjkJI/3Vs8JVpCNl
 zIPCKx4lAk+VBDVUidk67YigWUE7WmsY1Mx56NqGhZmYzVC5LQ+J/GY8R+qBXUmX
 cI9yuoCKQpl5bG0rN8hTea38RYHwg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gbqr29rwr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q14L1SWsXMvkuEcDzX+J2fefocVEoqJI8n8URnPn/nun9A2oXRJb972YXBN6J/1wk/MHHLiLlj3d5NunVya1ajfn/mKDDMY6uX/KWhL+H9rrOuZ5cIIOI7YsueCcd7/YZLK3ri0dnm3mOeHLNp+R0KrWKAyiE2WG28s3KEwtIwchj0Ny4jf8Q4H9bv1zENbFLpuCTfk2a0YITiNbqa99Ma8kMZnF6uKTfgC/6sQok0rhYeplj3KDxvQ2TU0VoT2l12bFa52wU68B8PFzmejKnR0Fvglav0yIWZBVwKwtj1jIxuW1wovD+lSOT+zsT2c+45rJ033hTEyn+frvIsITmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGql5ho/m6ayPC0btEkKHOvsWViHl5oPPxyILEYyaRQ=;
 b=obL0XIEpLdzuBI4rRWmME4sS7HcfjbjGiS1NPG5bAfl1yjS8K/LT0i7BtK8G+m8tPHcCXyIkxhGQHTgUWhL9/bM3qlLR8ugjOe7HJaHUhKTdT5uRXpPerw8GUjpMIsE7p6KFCiZOimMFQESEOIBpEPvvsNLwGM6E0UWiG2OcKTaq1q3p4k27DqXhzEwHTlvtaH9TcEjGHwgu0SZ0g9V2ZYLdrylA539fwD8hdl8heDV9NNhH5kX5iVUV50qHKcZtMp2ld7DgUoo1guKn6RR1FXyEIabqNHhO5Nw/sfIVbmukTBjOVE6M+Q2Q77g6b32uGkwgiF1TkvuFis5kcF3ARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGql5ho/m6ayPC0btEkKHOvsWViHl5oPPxyILEYyaRQ=;
 b=S+rHXV+L6T66v1hZ74VSw3PbA11GBI8Yic/VlAGGXNIWw6w8nwo9Kd4C5JS/sXNMDmbnVXrrI4LfKUZ0vOXTktD0jGUf6ORjBlOxOPcnebsh0D1G8+5H9uPDHUCIliwYPUtIueNgRiJqpeiNyJl8YRo/yrcUGB3Ndcq4KyxSHyE=
Received: from SJ0PR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:332::17)
 by PH3PPFE0A9C68D2.namprd10.prod.outlook.com (2603:10b6:518:1::7d2)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:30 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::3c) by SJ0PR05CA0072.outlook.office365.com
 (2603:10b6:a03:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Sat, 29
 Aug 2026 14:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 29 Aug 2026 14:34:29 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYOO7530331;
 Sat, 29 Aug 2026 09:34:24 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:28 -0500
Subject: [PATCH 10/14] board: ti: am62px: update MAINTAINERS entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-10-e4e03971e14c@ti.com>
References: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
In-Reply-To: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|PH3PPFE0A9C68D2:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a22a50b-4cbe-46cf-e635-08df05daa2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X1t71ACEUhFhFt8bZ+22tTokYDQS2CnSTmZ8yJk9ddQKMrtwCcrqEs3es8kCOH6mVqrhy0maf0CUYbppfy6SJcLFNqOcm+J/FO8yPucGo8NuQBG7/3e3mpHY9t7UWQt+6hYckuPVKGNsLYrYZt2m5z8PC7J1qU5X5O6e7iM5FOdbK3g+Tq1PhMQJw2aDpiUk/H9zLcozdrls43q177ndi4MNPzYYsiqQaFKpQ4hJ9QJMJXPoX5P6r65NK2iTulsn+CyiT9yX3LVuTJaULwNhKgq3ypcj3fKfnWmLNaL1STfmq+oXCG0ASS7dS8fPOklkfOiv5jnEz9ZqXC1ImmavuaVTxlGCsuqwU8B9bHg9QAjaGvFh26s+woE9bwZzNX6lqVEtaVU323L19gm4QzFpLNob1HDs4EadvgD6p+tJMN+UBzggknUW8kNg7ZEIaZFUq1EOcNN8AHbVUdyI26X3WD9iqYp2k+C2/etqJ41MFE001hZGQPlD9UJx5QXPROcUxST5yk7v8KeOBBjnBVa1U4wl71hrGcKtzX+bhqNaVVxkAOrio2UJY8s+NcCNDv0lgryGb5iiGDqT8YeQ6zB5cOGCvLWgXeCbnOgrq9c4VHuuq3umFbwZU7Tadi8jflswh1yMbeKTkocSBJ58FbHErVemYCD+0+xH0Sxf38pRwaMQH8ofBr40G/AilvRHgl1HU+te2fLgDq/P4FRVCAB/PA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CV0NV3zGXgFumc8m3xNo++JaEa7ZU+4sBZdGrMIs+5O5SaxBhOOLWomA57AvU3yuL8Pj/frX26+nL3FkTUKPeoDSXOHDFuoAtC7pxy4IHvtYjIvaz2BAhmv0QVmNhKJHrbvd3amdAswXJSNrm3WQIzVxdcXZ186/FcHgkXyBDqU36UWu/0Cuq3YVY3azwSyqb/o5KR8PyiyuTXprfvDOuYLPunaHCLAVjX3YGhQgsQGgC86hIEtFxchcBHMTpCBQZxgXp4jSEtOuF33OMgDHLiau2WxcRhNla0hvv0kPP9dqjQptMYJFBFQXtsN4agvXFcvNRz5/qTemVxWBYzzoeqLz7ykTmj6OYNiPiQvb9nFrvH0cFeCp6EDWN0KRyuh9+usN9gY+fuzGAZzOICkDGOrmw4SpA4Apyb7O44+QbGmZS+tDvs7TkaSYbljS5oXd
X-Exchange-RoutingPolicyChecked: vE3NrTc5WjacOipZ8J8LjBaKjvy5EnxSTZ8ZIJIyp+0pKfA3aDzwLmsG5bNDCQrrc4JPnuNQbOC281aPNPdW1/7/acNyhWV0co/XWwWjhM6L4zHlOLRiv+Clgo16LJ1Dpcmjw4EASsrmD6xmF05SvRmV4Ea4RGoXnrbyZseQtRkSszUz34yuJZ+zWpeN2F6Kd7IMDrPydb8+ThyZ2NbGmTk1yGhgoF+bDyGnQRbQ3bWuN2WKU74xdM2qlbWglslLMQvLxOluho9PQr/x+tpidSnOwZSjXcle6lPmOrIAfq0OwdGwTd6ZpeFKZfBPUlXPYBonf3uZ2DI6CojO2xw6wA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:29.9614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a22a50b-4cbe-46cf-e635-08df05daa2b8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE0A9C68D2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfXy/7Hguxm9DvD
 M4Sy8a1HEpB6NN8AXB+q4aTPgeVY9/DwjHANT1ALAbm4ChAV23rLwS9Gh1SXlq24IWTYEf3CPGZ
 1kYwH+cZoDCK+qBT4bGe4sd96lPicl4=
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a92edfc cx=c_pps
 a=ubW7OWQb4uJshPNbXurJQw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=k-42gJp3AAAA:8 a=Ysg7fMynT4q17rUXyroA:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: WQ267zdUoZByyPCN4K78-rc1zjHOnPEw
X-Proofpoint-ORIG-GUID: WQ267zdUoZByyPCN4K78-rc1zjHOnPEw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfX7cPn0TS+LSsT
 EQ/Uau4DzI1NkrHi/QlBEULXCcc3XKjhhet6NQBlCCuye2alucxIKm9lj1lNC7ewv7quuot1hSL
 H1gwPfPUXA0KecdyayUxmMfZjLa7g1vPXV36UUs6dkAaiXEuffOtYgHtjiKSGMKgivl1O37cWOR
 8809g+VeCL1B5L7LYM/JL1Y1rYBP62zpCJw87wFvECwhcVD6VEMqxB7Py0hzb1JEchFrnJ0Qlq9
 AE8okfm/durrbnQIBUYCQ8DC6iXvwDyulGjrZMy9AP1L1N/oiNoAyhThtAUMzupoko7akVPnGnO
 bXrHzMxQQ38KpZbK8xf1wdGi8Je8ZFHew3j08sTUMi1lBGzsZ56KRINx6oTdtsA68HmcEcX/P6O
 A84ZRR/hk2kbcHNYOpixXBI3uAECzcChBG1K0Qk+1urCBLsp+BNrCLddJukf5b+BV2E+MMtRToi
 gxeBPJp79oaBBLUzMww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290126
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

There are some files the AM62P-SK board depends on not claimed in the
MAINTAINERS file. Add them.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62px/MAINTAINERS | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/board/ti/am62px/MAINTAINERS b/board/ti/am62px/MAINTAINERS
index 320b0021b552..0dbc48d724b5 100644
--- a/board/ti/am62px/MAINTAINERS
+++ b/board/ti/am62px/MAINTAINERS
@@ -3,9 +3,21 @@ M:	Vignesh Raghavendra <vigneshr@ti.com>
 M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
+F:	arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
+F:	arch/arm/dts/k3-am62p-sk-binman.dtsi
+F:	arch/arm/dts/k3-am62p5-r5-sk.dts
+F:	arch/arm/dts/k3-am62p5-r5.dtsi
+F:	arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
+F:	arch/arm/mach-k3/am62px/am62p5_init.c
 F:	board/ti/am62px/
 F:	configs/am62px_evm_a53_defconfig
 F:	configs/am62px_evm_a53_ethboot_defconfig
 F:	configs/am62px_evm_r5_defconfig
 F:	configs/am62px_evm_r5_ethboot_defconfig
-F:	include/configs/am62p5_evm.h
+F:	configs/am62x_a53_android.config
+F:	configs/am62x_a53_usbdfu.config
+F:	configs/am62x_a53_usbmsc.config
+F:	configs/am62x_r5_usbdfu.config
+F:	configs/am62x_r5_usbmsc.config
+F:	doc/board/ti/am62px_sk.rst
+F:	include/configs/am62px_evm.h

-- 
2.54.0

