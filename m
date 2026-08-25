Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4618BC61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 15:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE42A4058B;
	Tue, 25 Aug 2026 15:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f8vvXZCjiM36; Tue, 25 Aug 2026 15:46:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787672779;
	bh=DEQ5qqxmaX2d5zkirCT/+n0W7h6ntacgbSlpoQR4zeM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RNAXR8f2OFjF6Lq0Q3DlTap0rWPXhgaGbIyGZH6tCBsazYIW5FT6JZi/0Hg01vufF
	 aHmrOpekg1GKFuiHYKI2dRja2fYpbdOb4qGKDezPPXw2yV7N9UOxF6lEccnzcaDfQf
	 RpFDlmtZCjjxzsQz7EC/Xya2o+tuhhC5/kC0c9tIcF5gXyf+Q3I7UYS2q7Nl4w+/Ah
	 GMbKr0bMbaK9pA+VGLolKDVZy5k+BatctPlhrKI1QZOucnGUtnh8r2ve4QFDXec/Ng
	 4RpmQ1DDNtNHfIMimhRSockU5c8zp6iBO8Gf4uKZ6Kp8HbpMF4Cmc5G5AvplLk9eGl
	 IIWwUDiMaqQ7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DED6D40592;
	Tue, 25 Aug 2026 15:46:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D5DB1465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33C8D606AE
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_O9DJpY1MnE for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 15:46:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=NUKSgGLg; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=PI/u1ViX
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A38F560683
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:46:14 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEVAaq1690165; Tue, 25 Aug 2026 10:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=DEQ5qqxmaX2d5zk
 irCT/+n0W7h6ntacgbSlpoQR4zeM=; b=NUKSgGLgg6pc2qDa7TMlzG4kysOPGIt
 kDyQW4kew0i/MTKaABwT+XvYaynwmEFjvIV56CROD0rn+ZnceVfrF1+1xXiFHEvI
 vrRBtTaVpy4XDk0mg9fXeNjqZcS2V8t9GoXNv2EhA+4njBxQIcZIk9sBHnO1GJM+
 1RIuyQFtJJpE5CeCz28ylUg53IlaG/k8xsaPAUVff7Tu+ACcDQpv15Y3Hcnsd5SN
 xARWMamckz/3WbdVe5C8ryEI8rdcgiip4MVqcoE9FsnS0KJ2REy6noodzqiy6olX
 6UFRbWCOI3VLVMj8IeEOe80LzucluOkCEJtZmL7LnjtebbYBXUVzc7Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012014.outbound.protection.outlook.com
 [40.93.195.14])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g8xf0cw2v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 10:46:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3/eEMm+NBTLb3xR23sRBFmRXE3FO7UAfzB4HhR+dI9mcWMgyk6qyv5ORrtDjkNkjWFtHPqULZhlVygT4iAmNq+Cm8gmj2HGxCkgBHOlxztZwWDSatS2vBBmtsPcjSrTnP9b10q635DuxrZqNTKqwmiTONSKikAEsR1qHe0i6JM88pJveYwKrNqz7ThuhDYp/yFkqFR/JMP+ByGfMkaNcY68ro8sSnPTgQTZlHQFbHdOq1Ong5aVca3IRihttFAwLDwc21v7Xp/Npt2dfqjFgoFIQSx3TiM0mInp5lEsvUutbBf/4peAEM2ea3E+yEr3MCYeyfJ+YOoUTi1ZRSL7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEQ5qqxmaX2d5zkirCT/+n0W7h6ntacgbSlpoQR4zeM=;
 b=gRr0V+To+Q0HdjrwBKZWeGLyhK15L1kY0e3xZa9qK2GGhf8jaALaasKstPiQzy4OQRaJSRHiqekgGTW57sXO2x6Q2t0ZTgEgYrSxrOpzvzaHrvkJGGq5b1FqC5DKrBG8RptnAucygkq2czuQgCay624aUneva1K8ZNHz6GroAre/YQHXTN9xcCxQK2bOpB/3a2prI5yLHDip8bRYT0GiZMQOYK5D88hg67+C8KPpLzSN6GXUzFnQFQ8s9TYPZwVsDwcps857+PGzZyS/2JOqLvsn3Sh5eHSynpZtlAG1QKPaEafTkc7SAPJARaggKtboaTh2IElLj6Ij9xPwamkrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEQ5qqxmaX2d5zkirCT/+n0W7h6ntacgbSlpoQR4zeM=;
 b=PI/u1ViXYu/N2QkwWg53zSA40wP0/as8KTNS2oCPI5ul8SyfRC2AHe1v0qLr23dqBpLdIYt/JfqWaQHGArmkkkUOZ9Ojn5aXIDQ78FIRBf6rY2waVCy2UC7/mstvL2bvFBTFhK02XTSyWCthFBA4aDEnbdwdoV4JfwB2z6Padj0=
Received: from CH0P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::25)
 by CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 15:46:07 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::48) by CH0P221CA0015.outlook.office365.com
 (2603:10b6:610:11c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 15:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 15:46:07 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 10:46:02 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 10:46:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 10:46:02 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PFk2I91297031;
 Tue, 25 Aug 2026 10:46:02 -0500
Date: Tue, 25 Aug 2026 10:46:02 -0500
From: Bryan Brattlof <bb@ti.com>
To: Michal Simek <michal.simek@amd.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
Message-ID: <20260825154602.33rs5mq553ojtgxj@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
 <20260825134812.nlq25ymj5gsnmdvb@bryanbrattlof.com>
 <20260825142736.GV523975@bill-the-cat>
 <57548c50-e2de-44eb-944e-554438c2cfd0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <57548c50-e2de-44eb-944e-554438c2cfd0@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|CH3PR10MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: efc78a9e-1dac-4e70-dc7b-08df02bffa64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: q1fQs+0FIwyFeoiFLpqjqv/Nkj9pMrUxu0HcW7X50kPvXnyxHr1R7A5RNFc11HsPI/Hf/pj1JSRNS3MfO/l3uFh1lRVB7vdCIB1wkwCFTlhIEJyK/+PhDIRbEkluGDY4A13lvKJ5qYeFacPWR2ndBEUWUZYm8qMbsHC8WDPKOlb4Qzgehbd45ZDCrMAIOIEVjC2IVWlaMw8dhhNGpDkJs6KRw20jNK9PQhNyv+1QZaqMM2n2qpunpahzsQ9AFtroNCtYejsoQ4u/c3eIBETG69dMQG3gmBbjBzNaqRbd99EP+Z2lQ1ezUGoyF1ynLP724MQfSwfROnqYKGBKEf48jC3I4fRv0b4ZEoDFUVHDuYBvsRK7Af0wUrOaP2Ql6Vlt4s6roc/rA9zzINK9xk2V0g+KGGqMqQd8VlWyMBk/eM6uWVWrdiKAhrlCaBtJRMbgZrSqaj96JX1VSIccBj70oyH6Qwmvh8Mv36PJusmakak8HJtI7kJtVmpUydCBYZdkGUT8YQLYRAyMGoxC7N075TNiB/SP+wjW3aQzy+AIHtrRLWSC8/lUi+X2Xqnz/hqNLaATn/UamhjRMNN806AH2R/nFO3Wy/Nlw2i4W9x0RhupQVtgP0IA/Al/AH7NGoi9K/fNFp7/hfP4kWUibb6/ZV6/MZg0uZSmlzEUiSl0n4OzHxHjc8ec4vSVETMN4344EMOYLtQKO3vov7TWNhqcKw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: USDs3N8Y/iOtjK6pGW86FdLjpF/Yt0eyf1ZNEnZOrstWyBXZn2bMZ1yj9fpSFn7OUv1icnN3qPyRPW901Vq6QcOyE7c4nlNWuxFcxbrU9IVWBEwhvnD5KQmX8PKi/LfsD+ECYPLTVmaHWmYA7DPYLeMOPw2FNpV1T9A4GwE7R8v0NuBKt1hAm1AfTV/mCoGgYYLP7+DBpo9U7HmXyq9+UsgSaqrLFtNpDAs8VpO7jmYfYDirDwMS7Bk8gqGdXdUqpAmFACSwDZl6jb5y7dpqvUGhtBb3FZd+mvm5BdvohgeVw8zrhbqOiaQezGXnDGLzyW5I/lmT0KUpVQu9zQGvebdLN/L0CEFWyLLtipj9r2PO86wacu19EWwMumPAG59lT/CJTTphkMWwtYjaSAnaBHu6v826qnX/2RYttahS5ZKrWyH0P4GR8DgfOxicLv4d
X-Exchange-RoutingPolicyChecked: 5VbnZUl/+N+6KaATps8+LcIbaLBl9Cn8Nh4p+K0VrSAgP/1CCds8uDrV1DBURcEVqhTp7qbBw0c6hlGBbnw1JxVBWWRWHdDD76D8u13rHVbEurdYz9v/LABUd1Q6T+fh0x6hopZnUFx4/RXJsu5CcdnrWUrYrRsXCcSiYhYYyv/xlriETupBCSK2dhaVzob41jPeDacvRaC7FUipWFAs1MmdsjxrFXpRqZAGFXSuA+Ry4yxJVOyEfgjEDrFuHJwyroAQNgJdgeXrt4xmzjrSCC+jjZdv9fKqwnK0zPg9RFQnmZcNknA78CYc+9d68e4RZhSeNnqGT+Sfv9yHSWw51g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:46:07.2397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc78a9e-1dac-4e70-dc7b-08df02bffa64
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7436
X-Proofpoint-ORIG-GUID: F9WuLnUC3jeUkngc5gpn7kzVg4bjcR8E
X-Authority-Analysis: v=2.4 cv=Fow1OWrq c=1 sm=1 tr=0 ts=6a8db8c2 cx=c_pps
 a=C5q/T6pJLpFJxMBEEzTjbA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=zd2uoN0lAAAA:8
 a=sozttTNsAAAA:8 a=9TN1vv5Y828kqbLodnEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzNCBTYWx0ZWRfX5YWIsGyV1/4v
 YQA95DICIUgXkRa/M3akjBH0eQ2xk9Fw0SNgh5tRVwFv1k2344dxbPnU2IHSnO61JV3jHzPxCuD
 K29BxLNzefAeQihzljIZ3g6edEkcMOc=
X-Proofpoint-GUID: F9WuLnUC3jeUkngc5gpn7kzVg4bjcR8E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzNCBTYWx0ZWRfX4vkII+EfQLei
 OjmvB1RlieEbIs1hUXCI+41FGSNE2hAwbUEwRJhYEhX1hEmWYuY2oqJ6mHPqs+Ep3hhWvFu75PK
 QwAzi0AsMlhrVM4oTVilXKWD7Bq7u6wOiGHxpCuyqjofUpWQ/PVQkckPnay0PVS/PZoaC5FExFy
 7VPZAZYGkhCqs8a5J1HeFle9hmfhsX/ahe+iRqNmFtc+nmse/Lop3YrVoEnA4bOJAOlI/DLfAAP
 IhhEqiG5evSOVboAw4MdzCohKMEgAEqUntUt1RGnZXn0NVwEvSBNmXaMuVcmi+FETfi05nJAiv/
 UuPAiDl8l9PHHlVntKeq5hJA6hFssGZjYSCNSQw4BDR75Hkl8Uyd4v5bec+R+hooVNFKYz3MM3b
 KEhKJe3je95oPMkRuha8YmcYGaU5MTuQuANYsREj1Pmdj1ZZ8dHUDx42C7T7N4V4krlnRdYzmdD
 i416dAbtH1P/CmUNfUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250134
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

On August 25, 2026 thus sayeth Michal Simek:
> 
> 
> On 8/25/26 16:28, Tom Rini wrote:
> > On Tue, Aug 25, 2026 at 08:48:12AM -0500, Bryan Brattlof wrote:
> > > On August 24, 2026 thus sayeth Michal Simek:
> > > > A number of file (F:) entries across the MAINTAINERS files pointed to
> > > > files or directories which had been renamed or removed over time. Drop
> > > > these stale references so that every F: entry resolves to an existing
> > > > path.
> > > > 
> > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > ---
> > > > 
> > > >   arch/arm/mach-rockchip/rk3576/MAINTAINERS         |  1 -
> > > >   board/CZ.NIC/turris_omnia/MAINTAINERS             |  1 -
> > > >   board/LaCie/net2big_v2/MAINTAINERS                |  4 ----
> > > >   board/LaCie/netspace_v2/MAINTAINERS               |  6 ------
> > > >   board/Marvell/octeontx/MAINTAINERS                |  2 --
> > > >   board/Marvell/octeontx2/MAINTAINERS               |  2 --
> > > >   board/Synology/ds116/MAINTAINERS                  |  1 -
> > > >   board/acer/picasso/MAINTAINERS                    |  1 -
> > > >   board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  1 -
> > > >   board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  1 -
> > > >   board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  1 -
> > > >   board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  1 -
> > > >   board/altera/stratix10-socdk/MAINTAINERS          |  1 -
> > > >   board/amlogic/p212/MAINTAINERS                    |  1 -
> > > >   board/amlogic/q200/MAINTAINERS                    |  1 -
> > > >   board/amlogic/s400/MAINTAINERS                    |  1 -
> > > >   board/andestech/voyager/MAINTAINERS               |  1 -
> > > >   board/asus/grouper/MAINTAINERS                    |  1 -
> > > >   board/asus/transformer-t114/MAINTAINERS           |  1 -
> > > >   board/asus/transformer-t20/MAINTAINERS            |  1 -
> > > >   board/asus/transformer-t30/MAINTAINERS            |  1 -
> > > >   board/atmel/at91sam9260ek/MAINTAINERS             |  1 -
> > > >   board/atmel/sama5d29_curiosity/MAINTAINERS        |  1 -
> > > >   board/atmel/sama7d65_curiosity/MAINTAINERS        |  1 -
> > > >   board/atmel/sama7g54_curiosity/MAINTAINERS        |  1 -
> > > >   board/atmel/sama7g5ek/MAINTAINERS                 |  1 -
> > > >   board/avionic-design/medcom-wide/MAINTAINERS      |  1 -
> > > >   board/avionic-design/plutux/MAINTAINERS           |  1 -
> > > >   board/avionic-design/tec-ng/MAINTAINERS           |  1 -
> > > >   board/avionic-design/tec/MAINTAINERS              |  1 -
> > > >   board/beacon/beacon-rzg2m/MAINTAINERS             |  3 ---
> > > >   board/bosch/acc/MAINTAINERS                       |  1 -
> > > >   board/cei/cei-tk1-som/MAINTAINERS                 |  1 -
> > > >   board/compal/paz00/MAINTAINERS                    |  1 -
> > > >   board/compulab/trimslice/MAINTAINERS              |  1 -
> > > >   board/comtrend/vr3032u/MAINTAINERS                |  1 -
> > > >   board/comtrend/wap5813n/MAINTAINERS               |  1 -
> > > >   board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  1 -
> > > >   board/davinci/da8xxevm/MAINTAINERS                |  1 -
> > > >   board/embest/mx6boards/MAINTAINERS                |  1 -
> > > >   board/engicam/imx6ul/MAINTAINERS                  |  3 ---
> > > >   board/friendlyarm/nanopi2/MAINTAINERS             |  1 -
> > > >   board/gardena/smart-gateway-at91sam/MAINTAINERS   |  1 -
> > > >   board/gardena/smart-gateway-mt7688/MAINTAINERS    |  1 -
> > > >   board/gateworks/gw_ventana/MAINTAINERS            |  6 ------
> > > >   board/ge/bx50v3/MAINTAINERS                       |  3 ---
> > > >   board/htc/endeavoru/MAINTAINERS                   |  1 -
> > > >   board/imgtec/xilfpga/MAINTAINERS                  |  1 -
> > > >   board/intel/agilex-socdk/MAINTAINERS              |  1 -
> > > >   board/intel/agilex7m-socdk/MAINTAINERS            |  2 --
> > > >   board/intel/n5x-socdk/MAINTAINERS                 |  1 -
> > > >   board/keymile/km83xx/MAINTAINERS                  |  2 --
> > > >   board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |  1 -
> > > >   board/kontron/sl-mx6ul/MAINTAINERS                |  2 --
> > > >   board/lenovo/ideapad-yoga-11/MAINTAINERS          |  1 -
> > > >   board/lg/x3-t30/MAINTAINERS                       |  1 -
> > > >   board/libre-computer/aml-a311d-cc/MAINTAINERS     |  1 -
> > > >   board/libre-computer/aml-s805x-ac/MAINTAINERS     |  1 -
> > > >   board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  1 -
> > > >   board/mediatek/mt7981/MAINTAINERS                 |  2 --
> > > >   board/mediatek/mt7986/MAINTAINERS                 |  4 ----
> > > >   board/microsoft/surface-rt/MAINTAINERS            |  1 -
> > > >   board/myir/mys_6ulx/MAINTAINERS                   |  1 -
> > > >   board/nvidia/beaver/MAINTAINERS                   |  1 -
> > > >   board/nvidia/cardhu/MAINTAINERS                   |  1 -
> > > >   board/nvidia/dalmore/MAINTAINERS                  |  1 -
> > > >   board/nvidia/harmony/MAINTAINERS                  |  1 -
> > > >   board/nvidia/jetson-tk1/MAINTAINERS               |  1 -
> > > >   board/nvidia/nyan-big/MAINTAINERS                 |  1 -
> > > >   board/nvidia/p2371-0000/MAINTAINERS               |  1 -
> > > >   board/nvidia/p2371-2180/MAINTAINERS               |  1 -
> > > >   board/nvidia/p2571/MAINTAINERS                    |  1 -
> > > >   board/nvidia/p2771-0000/MAINTAINERS               |  1 -
> > > >   board/nvidia/p3450-0000/MAINTAINERS               |  1 -
> > > >   board/nvidia/seaboard/MAINTAINERS                 |  1 -
> > > >   board/nvidia/tegratab/MAINTAINERS                 |  1 -
> > > >   board/nvidia/venice2/MAINTAINERS                  |  1 -
> > > >   board/nvidia/ventana/MAINTAINERS                  |  1 -
> > > >   board/nxp/imx93_evk/MAINTAINERS                   |  1 -
> > > >   board/nxp/ls1012afrdm/MAINTAINERS                 |  4 ----
> > > >   board/nxp/ls1012aqds/MAINTAINERS                  |  1 -
> > > >   board/nxp/ls1012ardb/MAINTAINERS                  |  3 ---
> > > >   board/nxp/ls1043aqds/MAINTAINERS                  |  7 -------
> > > >   board/nxp/ls1043ardb/MAINTAINERS                  |  6 ------
> > > >   board/nxp/ls1046aqds/MAINTAINERS                  |  7 -------
> > > >   board/nxp/ls1046ardb/MAINTAINERS                  |  7 -------
> > > >   board/nxp/ls1088a/MAINTAINERS                     |  9 ---------
> > > >   board/nxp/ls2080aqds/MAINTAINERS                  |  4 ----
> > > >   board/nxp/ls2080ardb/MAINTAINERS                  |  6 ------
> > > >   board/nxp/lx2160a/MAINTAINERS                     |  2 --
> > > >   board/nxp/mpc837xerdb/MAINTAINERS                 |  1 -
> > > >   board/nxp/mx6slevk/MAINTAINERS                    |  2 --
> > > >   board/nxp/p2041rdb/MAINTAINERS                    |  3 ---
> > > >   board/nxp/t104xrdb/MAINTAINERS                    | 13 -------------
> > > >   board/nxp/t208xqds/MAINTAINERS                    |  5 -----
> > > >   board/nxp/t208xrdb/MAINTAINERS                    |  1 -
> > > >   board/ouya/ouya/MAINTAINERS                       |  1 -
> > > >   board/phytec/phycore_am62ax/MAINTAINERS           |  1 -
> > > >   board/phytec/phycore_am68x/MAINTAINERS            |  1 -
> > > >   board/phytec/phycore_imx8mm/MAINTAINERS           |  1 -
> > > >   board/polyhex/imx8mp_debix_model_a/MAINTAINERS    |  1 -
> > > >   board/qualcomm/dragonboard410c/MAINTAINERS        |  1 -
> > > >   board/qualcomm/dragonboard820c/MAINTAINERS        |  1 -
> > > >   board/qualcomm/dragonboard845c/MAINTAINERS        |  2 --
> > > >   board/qualcomm/qcs404-evb/MAINTAINERS             |  2 --
> > > >   board/renesas/blanche/MAINTAINERS                 |  1 -
> > > >   board/renesas/eagle/MAINTAINERS                   |  1 -
> > > >   board/renesas/grpeach/MAINTAINERS                 |  1 -
> > > >   board/renesas/v3msk/MAINTAINERS                   |  1 -
> > > >   board/samsung/starqltechn/MAINTAINERS             |  2 --
> > > >   board/seeed/linkit-smart-7688/MAINTAINERS         |  1 -
> > > >   board/siemens/iot2050/MAINTAINERS                 |  1 -
> > > >   board/sifive/unmatched/MAINTAINERS                |  1 -
> > > >   board/sunxi/MAINTAINERS                           |  2 --
> > > >   board/ti/am62ax/MAINTAINERS                       |  1 -
> > > >   board/ti/am62dx/MAINTAINERS                       |  1 -
> > > >   board/ti/am62px/MAINTAINERS                       |  1 -
> > > >   board/ti/j7200/MAINTAINERS                        |  1 -
> > > >   board/toradex/apalis-tk1/MAINTAINERS              |  1 -
> > > >   board/toradex/apalis_t30/MAINTAINERS              |  2 --
> > > >   board/toradex/colibri-imx6ull/MAINTAINERS         |  1 -
> > > >   board/toradex/colibri-imx8x/MAINTAINERS           |  2 --
> > > >   board/toradex/colibri_imx7/MAINTAINERS            |  6 ------
> > > >   board/toradex/colibri_t20/MAINTAINERS             |  2 --
> > > >   board/toradex/colibri_t30/MAINTAINERS             |  2 --
> > > >   board/toradex/colibri_vf/MAINTAINERS              |  1 -
> > > >   board/toradex/smarc-imx8mp/MAINTAINERS            |  1 -
> > > >   board/traverse/ten64/MAINTAINERS                  |  1 -
> > > >   board/wandboard/MAINTAINERS                       |  1 -
> > > >   board/wexler/qc750/MAINTAINERS                    |  1 -
> > > >   board/xiaomi/mocha/MAINTAINERS                    |  1 -
> > > >   board/xilinx/zynqmp/MAINTAINERS                   |  1 -
> > > >   board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  1 -
> > > >   board/zyxel/nsa325/MAINTAINERS                    |  3 ---
> > > >   134 files changed, 241 deletions(-)
> > > > 
> > > 
> > > Thanks for the cleanup!
> > > 
> > > For the TI boards
> > > 
> > > Reviewed-by: Bryan Brattlof <bb@ti.com>
> > 
> > I want to call out the TI borads here, because I'd like to see the
> > entries fixed as the first thing I noticed was "it was called
> > am62a7_evm.h downstream, not am62a_evm.h upstream" and we should have
> > an entry for the include/config/ file :)
> > 
> 

Yeah I've let this get out of hand for a little while :)

>
> Maybe make sense to find out which of these configs are not covered by any
> fragment.
>

Yeah that's probably a good idea as well. :)

Should I wait for this to go through before I send the fixes? I want to 
avoid causing you from having to rebase this constantly.

~Bryan
