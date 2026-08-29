Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045A9C61DE2
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA66780E8D;
	Sat, 29 Aug 2026 14:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ty3d0C0grMuC; Sat, 29 Aug 2026 14:34:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014091;
	bh=Wm7SzUDdQFEsQ9ZGAwnNdCFX0BvZSRcDxDT4ssi4Sc0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WnX04O8Z7dru76cPXANwtlbfNC6H2yhKxLstgUSi+chTjrC6MQUoBCIM29OO1f/8U
	 f87fIDo6DLJtXhVF7sEJKffpFx55b+ocjzwzARJ7RNrXR5eH2Zz5uxB3a+8qVueXyY
	 L487B0xbYnIp/1kmOUyY/rKInI5czeERUVzShV5pJgho3RN7YGhbRWRiCuS/Cu3H/0
	 3YHY+jaf2o53ZQs5kfrYUd0xEW6yRxuL5txlA8pdo8w/bY4ymFxGF2S4aI74SwvB/D
	 +XUTilEBHGQBZ/vq4sjwtuDrIzJhL9sI2lsTUdoiFqVGnk50rku4XKzFHRf+tqTDWV
	 UsTD4Ke+6XuGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E235F80ED1;
	Sat, 29 Aug 2026 14:34:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 96C1214F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 772216066A
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IebBkk2-HK5v for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=FskjTNGJ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Cy+/jUJT
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4809260626
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:37 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67TDxlXY269951; Sat, 29 Aug 2026 09:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Wm7SzUDdQFEsQ9ZGAwnNdCFX0BvZSRcDxDT4ssi4S
 c0=; b=FskjTNGJxVCyFx47msN1QJFYzx48Xjsf0A12g8fEKq0J3yP/QsmVUN7Ej
 MXuxhDEhj/Vox/4XPj3EcnrGjD5EeCjNexVaBYtJ4XClJ4MctwmGTqGPy6hk0qgi
 QnSAoJkFV84QshxZs68iwi0mmLq6zayZY5jcW/yYsgoSezCsX4D7ixMNyR6mvXGF
 X79bKrCMawKW1uKLhlo3GMjQPtNJEK/QjEMnevp62ZMPT/QqtTcaJcPlY/MPbzhn
 +F79nXLy2PKD+QvQWT1n6QbtM15llEThyXxpecoJpTj4ZTencsr0jwRmZvVK8C+J
 iTEsvLfjWvuUH/ORAAKXwefDlmrEQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gbqn1hrtv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKPJjISFDv0kkIeMamKrAASdSJ7M5l3hvwTu6a3X3RW/IgysIuMZTK9RHNdEmaR4FSB1yy0gR/346z9cUEch92fb+9WQ52FhpfQrqXJUtA+9NRBwufv4i95pOAYO3Nvsno/jjSBA0EZb9HFhVjNMYf+tHqgEYdMkRJa66hkdaW8nm+H7XaYFIigd3LusHfnVEkNI9MoxB7jjL7r5MfP6g6jWjvlrLH7bwByrc8zE7H1ItG4wr6h2dD1YYhhyNDnpvk4ffQBA1gApguMXnssogXJDJgZ6ce8BU6UNeTP0WfD6P/tRhe7eaYkXajN4EACqn/9oAbRrYmHKlc70oP4uow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm7SzUDdQFEsQ9ZGAwnNdCFX0BvZSRcDxDT4ssi4Sc0=;
 b=RTjoZdEeNFQ52yqswaDVhtWJ/4zaayGMwuzcgg4j9TAX8DvH7kW6fkTBmexElPlsedeaGvD/79Xl/T1kzfxD8/z6FG+nYsrR1qIOotgbDdguRvZSZUKgXi+9XJ9uiK2ST4IauuLueq5LQj9NwaFid5dsm6ORIDlxkdT3E9yvMuOIVlXSgrWRr/BWYNG1dCjpbRxtRG8ro1v48DDoI9FxxkgDEzCwvJJ4qYyYKQtOuWLJZSwTDfOqYElMElvYoOVKjpDth2pluTOoti4q4Wr07xtK5m7RpQSRDizaxKaxYQ4CDpakSMneWobF4u9fuD/2f2BQ0mwQae9aN/R5jDIpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm7SzUDdQFEsQ9ZGAwnNdCFX0BvZSRcDxDT4ssi4Sc0=;
 b=Cy+/jUJTgj9p2bHzLAyCUl592uR0QC1piryfrs3jL3zWG5NY0FE1y+1NHSmEna8Xq4pCtuOb5k9SNloPbi0xzl6KMpg8kJAm7GpJ3qsxC/YIlaRspm2aHToX54TMW+WgPZYipZsKCpX7uO9ARE+Tv31jmv+NA8TkEoHaDcmvJqM=
Received: from SJ0PR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:332::17)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:31 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::4a) by SJ0PR05CA0072.outlook.office365.com
 (2603:10b6:a03:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Sat, 29
 Aug 2026 14:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 29 Aug 2026 14:34:31 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYOh81551069;
 Sat, 29 Aug 2026 09:34:24 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:24 -0500
Subject: [PATCH 06/14] board: ti: j721s2: split boards into separate
 maintainer entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-6-e4e03971e14c@ti.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 9000574e-34c6-470f-62f7-08df05daa3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: rYnuVuEgjJSY3+0wIJcZj67GNkT+fmz3aDx0W7ap8h7JfBwYsEOYeOl8YD3iiwTxbxCYZvW4VC0DhIpWiHbWZKbu7Gk0ghkYfTaLj/0yUTLgzhv2xK/g+KWTjHuwGrp+aHlQmS/yt29NgvsIdmHYdklG691inDqo8RUrEuRAohe09rxJVxbkMJuvNKerkBTBFaSinarEzXTXsqAhxdajpR9wDU1S71Wxya/SPjTl5pJCoo7ISO3kRjTX+VKKIihNEbdwgyeyu6Xa2qm4+JRfCtDuUl87qrmColydSZeLpP+Bvak2FdDvt26gldumZOiQUQie7Z4ls3sW8cUDmo9tbJ6KPlSVMfFAiFlJFQrcY8LDlBOWDHPfw3huNtjDFsBuXEP0qI8/htJOaicjzQwEH9RyCLwWLBjP4J39dApIwESDOrCh/3U7uqprCWoAJGQUPGWZ4PsWvy4HRmzKmt1QgiyDpM/bVAODlawXNnDttecSA3GhwWeeHvodKLN11YhUu5autDBsyanTrCxLT/o7QT1aixCbu66QZyBoE8OaabMuZXR5B6zOyOGIv8nqWTD34mpb7yVi5ybAxRu7G1sVY9ZwGTJB2Rd3A+HPT79CgcPx5u8d2Mvvs/QarpMnVX40qub5jRzOPFlQk5YWqUvf8vQcC+vxPRH8Y/5SogPnniHof/g9qsDOoru0JBjD/LM9qsEHtLm0sSrXi4mXYT+9zA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /I7/Ku5w1RyE+eg4JwUo7cXIFkntrFAiGoriWSxaApmHIWZF3YbUPUowI5jM8FyfPk4J46++IUyf/0kEde0WXgPWn/EHD8zKeObf9zFxq1H0M5WaeJxnEx2Y3lPvLCsmrjl8a1X/fM8AfOv9weTHy1NVxdHxDRL+jBwbbj7az9gT2oPLvziwG8N+9SK8DywZED+wapt5MWzpJp2d2HosWsAr58/nQnz/m+d81nDE29Kg1vsfmXAWELZ8ecHJ8LY1W9oD+xXMHEXltRmwy1oXpDeYmVNuwjYNjVuP3JtefFAvT7PIr4YelshdHFIPFznOPBYCFxJGKkpb2lXIyCIUcCzcc0rWnXqncrQajTzghqSUWLGvdNxQeH1TxmUTl82KBRsR43zK+ydJR93OI75gV8Ezo95eC7jFE5G7R2MVrrCOIc3rQYiUawxLOrLaqMMD
X-Exchange-RoutingPolicyChecked: z++tWu82DnEgcFcaC0z2GelcN6cMcg/+R8mOZ0NkDdw0wIVgeEJfmKHmIp/YgkCmkCN1sxODHjpcDvtRE18R2s/3+6eoVwyYdvvVKn9z+iCpqiIIlbiS+5//ow9kZjGjBxZFh0wT3zfkKpK5UD8dIn1SLtdakS+g8viPj8dRpUKjKOgmiPUbJR4KoFTunn3wd7Jk6EcJdqNB468Y8JqdlMpvFF0rPtUFT4OpWhkZ/rGCNRCIDc52PfLpgg5zB8rbObOV5/OrePqYRuEmN8EzOOEjzOu0cW8Qr+4vyT82R8vWZoqwe7fyzat7RPjK+GZRj3VlgcHtr9VDI5J5nL8HEw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:31.6597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9000574e-34c6-470f-62f7-08df05daa3bd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Authority-Analysis: v=2.4 cv=E9j9Y6dl c=1 sm=1 tr=0 ts=6a92edfc cx=c_pps
 a=i9oGDAf80PfF53tpRsLhyQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=tQFKoVUjMCfkTHFdc0QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0U9PDZQvQYIygn5V6ALbAd_NX8q7aTRm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX+w9mQ2o4S9cS
 w8RXjDXjmWw9UI2gfX3Vs0jI2agiZpNoDjN638+w+VaLmOSdUg1zRGrzGSmj2lx4q9loN7dvtsB
 PtI1O75utXTIBxybDvvb4HkVy9oxxc6o0VYX8zlNf1DH+yvp/dgJL4CvUYBdjSRu3ZjW2oXVMOC
 WCvagmzIY/OQIGNfNIU9NFauT5vkWn04ZD4jVtx3BW7NZAUmNKG7ptSLP9ddeA5LZL81X0EQn7C
 8Qph2XI7cYwKIm/twj+YLGqN6JtI5Zc1HvPUgWlcw18Q6+TAi5yC62l33wRvjMXfEocruUxLxrP
 PQDxP7wnR/8ZsSIfD/lH4JLrQM6/6Uonc881+I6r6Q6+oLnoArmV8fPRTlgMasRr8lZpDQ2qXqI
 INBwTbCFbPN3MFcw3UqeSOZe08+wY7obG2C2x4aeqnoj6xaaHD88rXQVJ80+XnBjNuIJ3AoWOzv
 edjPrKcR+Y7/fLWPvQA==
X-Proofpoint-ORIG-GUID: 0U9PDZQvQYIygn5V6ALbAd_NX8q7aTRm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX9SJOZcb4nvHZ
 Xdi2AzidVyo2hOlv40FFqf/rVZQsYNqmiwtAYnGSnx+y3qwtSwuDS1UGsxAX2QBnaYNxzgljx1F
 NXO5z2XzaYrdE0hNK972LsaltdAag28=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290125
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

There are two board variants based upon the J721S2 SoC, The
J721S2XSOMXEVM and SK-AM68. Split their MAINTAINERS entries so we can
better track which files are needed for each board.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/j721s2/MAINTAINERS | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/board/ti/j721s2/MAINTAINERS b/board/ti/j721s2/MAINTAINERS
index 81276116cc45..5bf5b59839c3 100644
--- a/board/ti/j721s2/MAINTAINERS
+++ b/board/ti/j721s2/MAINTAINERS
@@ -1,20 +1,31 @@
 J721S2XSOMXEVM BOARD
 M:	Manorit Chawdhry <m-chawdhry@ti.com>
 S:	Maintained
-F:	arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
-F:	arch/arm/dts/k3-am68-sk-r5-base-board.dts
 F:	arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
 F:	arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
 F:	arch/arm/dts/k3-j721s2-ddr.dtsi
 F:	arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
 F:	arch/arm/dts/k3-j721s2-r5.dtsi
-F:	arch/arm/mach-k3/j721s2
-F:	board/ti/j721s2
-F:	configs/am68_sk_a72_defconfig
-F:	configs/am68_sk_a72_ethboot_defconfig
-F:	configs/am68_sk_r5_defconfig
-F:	configs/am68_sk_r5_ethboot_defconfig
+F:	arch/arm/mach-k3/j721s2/
+F:	board/ti/j721s2/
 F:	configs/j721s2_evm_a72_defconfig
 F:	configs/j721s2_evm_r5_defconfig
 F:	doc/board/ti/j721s2_evm.rst
 F:	include/configs/j721s2_evm.h
+
+SK-AM68 BOARD
+M:	Manorit Chawdhry <m-chawdhry@ti.com>
+S:	Maintained
+F:	board/ti/j721s2
+F:	arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
+F:	arch/arm/dts/k3-am68-sk-r5-base-board.dts
+F:	arch/arm/dts/k3-j721s2-ddr.dtsi
+F:	arch/arm/dts/k3-j721s2-r5.dtsi
+F:	arch/arm/mach-k3/j721s2/
+F:	board/ti/j721s2/
+F:	configs/am68_sk_a72_defconfig
+F:	configs/am68_sk_a72_ethboot_defconfig
+F:	configs/am68_sk_r5_defconfig
+F:	configs/am68_sk_r5_ethboot_defconfig
+F:	doc/board/ti/j721s2_evm.rst
+F:	include/configs/j721s2_evm.h

-- 
2.54.0

