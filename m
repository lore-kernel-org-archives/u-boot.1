Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8983FC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 10:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 077B540B82;
	Wed, 29 Jul 2026 10:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lwj2kwjYQGso; Wed, 29 Jul 2026 10:55:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E077B40B77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785322526;
	bh=34OGEEkkf5MpqDTDWUKaMqGkHA/oxDTX1nhgJVhhmu8=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=03nGqsotgvbSGWlYuSaf/ehSGwierLm304dZinWJERQax682CmENcvUg5e6sqmM7k
	 6fT/PcnWYhbOgNZksK/z1xzQUJiH5h5V0eKrF0Zno1qaOEBTCvp6/xgDqt13LEdUOV
	 XcI6QzqgNCRKe/MJdI6hE8f5oIk9AwCwM7rHBov0YUa9NChCRfJi8Bkgc8rjgvfQOW
	 sG3RNC592U/YdNfNSlNvwOGk2xiIKYsIUMHGLPbSj55Cthz48cdo8UG8VEqqWRhbAF
	 PNhww9/rpRZvdvYyhOOF4c6SwIS2bB531xw7pbnSmY5oA8yh5CC4f9b6ohUB6lvZ7d
	 3uBmFJP+boBBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E077B40B77;
	Wed, 29 Jul 2026 10:55:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E03C4350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC01440B77
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g199KdUz9oAS for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 10:55:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C5DA94084F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5DA94084F
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5DA94084F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:55:23 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66T9SoTv2126906;
 Wed, 29 Jul 2026 05:55:14 -0500
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fqewyrb23-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 05:55:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioSlnusbpWzgXa5JR++lhi4l2v/2tmy1nbGi2uX1XatTtyMBr11XR07ZthELv+dZg8PSkqGc2e0UNCfOOL7qZA7Lt9rDOuD1uI7UcY1Edv22WZ+amxwoUtDPNsRb5xMFSxY4v3cRr1VmFbKM52WLWSPQXdMSWwaiKrW9Ro1kH42LSMBdMSoARQZx0shX3wPF0+xgVJo5VK/3hUC6XJX0m0+6k63RczMVYNb3EoK+k9Y43lIJI0G9UIPbmFxnox4Gn+d1A7d79OnDvV80IsIVIeE474Fn6JuUxTC6gqyvoZtuHxmk8U69UwmmTUBs7RXJHvkHqfBCdMezxMhyNO1yFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34OGEEkkf5MpqDTDWUKaMqGkHA/oxDTX1nhgJVhhmu8=;
 b=OBGjNjI046mhqr/Bsg/DEFG7yOkQvqaFvft5kyYjvIMXuXurArl5Y09U97GzRIsQopUwYaAQvpyyhwQJfl6l4CoW3hDPmD+bebkxwY1+y7kKwUNL9XsdlD0UpvAvqksDH4M7Kqohx/rq6LDhRqzk4utz5KDGnz8bG8QWmaoRJJgJUFWX4t6i5Hmbh2cY/c35j/ftF11t3oUQNItkmqkRjKU7eazNjJ/Alyy+nFClIfrRYWV7rK0dsT71qQoEu6VrnA39+PP2/fVtVOwFRI0B3lCWnkUmFzLfArEqavzUN9viNIzKrVW27uNtUSV3/41gzkMGHLsOGQ0tHqJj0qkZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from MW4P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::34)
 by CH0PR10MB4985.namprd10.prod.outlook.com (2603:10b6:610:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 10:55:11 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::ab) by MW4P221CA0029.outlook.office365.com
 (2603:10b6:303:8b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 10:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 10:55:09 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:55:06 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:55:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 05:55:06 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TAt5qE495842;
 Wed, 29 Jul 2026 05:55:05 -0500
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH v2 0/2] Refactor binman nodes for boot binaries for TI
 AM625 into templates
Date: Wed, 29 Jul 2026 16:24:58 +0530
Message-ID: <20260729-k3_binman_refactor-v2-0-9a66fd170040@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBREr0L+2pq2VkBX3sMQ0paPfA2taSvRE
 O5uwb3Ll5k3M0PEQBjhXMwQcKJI3mWQuwLsoN0NGXWZQXJZ8kpU7HFoDblRuzZgr23ygfFalOL
 Ya2NQQxafOaH3Nnptfhxf5o42rUtrY6CYxc/2Oom19/dgEowzxeuTlNyovlOXRHvrR2iWZfkCF
 VP49MMAAAA=
X-Change-ID: 20260717-k3_binman_refactor-081615fabbea
To: <upstream@lists.phytec.de>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Aristo Chen
 <aristo.chen@canonical.com>, Suhaas Joshi <s-joshi@ti.com>, Bryan Brattlof
 <bb@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Sparsh Kumar <sparsh-kumar@ti.com>, "Anshul
 Dalal" <anshuld@ti.com>, Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785322504; l=2015;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=Ou8DHocUokjQIHBwwF69B8QpahShO23MdZn12NvsM8k=;
 b=k7vIUGQSRYjRuo3P26Kk80RIok8KX3Y+3vQ2Iz4YfvxuM/Wof3Q/Ewjzm8NISCsZEHsAR2sOP
 42OFkXojy23C+nIK95YKC1LRF+YLN3EugrKqUnDobzQp2Er1skBmT2o
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CH0PR10MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: 410dbf5e-c174-4708-31e9-08deed5fdbc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|7416014|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: rpjyVayc/Eb4OvidS7UOfSVDTnpT+eJOmwFC2YiZOFxIMdvlyuAR9C4d6lOFSVDLJaye3zAU0m+jkieCzQ4aHUHULNFRLWMRIaMvrbZHR3HXxbx0HH9bz3W7OlWaR0bF2gkvXl44mjSKww0cWBV9DhiWm1ZLukcDzLA+3sXikGwHKG0aIzj3gpQph/e8f00gJOpBB6ulP70y/9ECrjtITXEgYGKN2XeqhUQKUkKNUcTdB/EyoXiy8cu/HXZ7ZCB4Qt+yJma6LHsm79X5pIEeA9f5+WCq5L3X2/doQ+hUba4LyMgy5AEKcpEFjL20yRa/6HkGIMOF/8G9dg6hZHVy6LcHqWNlEjYiagx8lWLqq83Fv3g8yQWgSRAyDd06P4YXPT0mPEgtljc3ojyuhVxNe2DRBJBuhP+neGAGdpktX0m7mElEUmuTg78peimBGxmpRlheNviQ7O2LSw4AT5pa++4D/ckJ/BNjtM0jL6QF640QiT9ysJR16tmdAXgOAtYH6Zo5KfKXzr8u39J3k4Iy8qM27f35ZAuksGwUOH2f3mjRmBZqYBQE3uPJ7czdN2t62A/LxekLgmQBeNQePsiQkVbLW3yTtP+tN5UEgbwfW/+joemXBHNweagoCwFuDDVjD445mHxk8NG+1A9fnvJfa5GI0FeL1jmm6Z/1G1ISiHA=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(7416014)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zleNA33zbg5xjsVY4Erx44Kaz0KkYp9sbNF6WD0uh6mEyvXV80Txr2oi0hkbs2bvkbdFYOBendRvk9oQVE74GO1VhfNJ8x+i7lNWgD9hP8B+UUi85eVSQVvbCL48rYuzsozE1sMjffF1gOfElM7rnfF1jjFxpx459H3TdOLQJvs/kK/P5vw+uyAuW8o8PXaDzXvntFGL/w3i8D4RpDrTfa/OV8PM/r5ewR35P1OMCYJBFIQSTwopGt/Rc9lwEt/kb7ba1oCVty6JZB657wxNQdc33mDLzpN/4taPdrYb39/9hB1e02gN/w4r7uoZh/tWg28vyviBNNN8938L+midzcXI93L+/HNKCz/hfR8FEGRywnuUpCBIMyCeyOSKSnUTZ+9oVOXhbmR9H8gfsHvpc4Kx8C7m9Q0OBal2kgvypPU0QGR44n+r70wjQswG1sPW
X-Exchange-RoutingPolicyChecked: JBq5X1uQm1Vsp9vNKyXRZrGTEMHTO4GQ8sCDy9b6ZHqr1bN4usaMMNfmBT7YeqTZukaLISQ3DA3BX1dVwNEvHRLh/thS4bR18yKJcA8WnFyNl1Apx+KqI/rZSiSU66kG88tXjgB6ZqpacDRn2SojtdqYPQI53um/T24yNxog+w4lkWTATm5aupKK6FpWumt1Vt/TIO3QIWNoXiHPvSPfEZWa60erDykiRYe7+2nUeQenW+W0T/9KN5Zp7ki5y0+6dRexF0RHm5MexGApMHJF/bbdHWzJYR6Ymb1A9oL33PPXbQmAPFa9aGG6NuE+NSkwL/OxQuBvBLv/jrOMVBHfDA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 10:55:09.6454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 410dbf5e-c174-4708-31e9-08deed5fdbc0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4985
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MCBTYWx0ZWRfX4PQdvfnavtej
 dUfQBw6/lYySnKX40JBQcbLQRJaRh7KmTLci63nvRl/o1ef0u/QT61haSklpD3WdPzM5VX+iZwr
 QUEfCENFTHg1zpUjHwchZy5aUgwuXg5Gg2IRuzt4SEJmdJQtl6DM3gliRsKGHbTUq16UdfDjyPW
 rKqZIsgbbO5f4//hvgTE+gkXAgKiQlEuVrzcn2wumXQf6U47GzCNiS05BG5qZ4M01DRfiZcuVMY
 8ADFWVcrSulZS6A3lLcdj8NhDEpZUCutuX2BF8xFG/MP43YO54TL8BlxQ2kMcLE8BGtYdCq6l8A
 awfQqWvLoGZ7XGd37Tl48NUz/OGwioTyBhKosSp8RTC7jPTmfBmv42F0/RwvbYP7nOwxvpDvhy3
 ouu1YJAYzQLdlXRQUW8UwHmemIhDHnOx3D2uGBMHLtINXBFoKxbko6BxOc0HcLaQsQAh/St4Sle
 fvKVNsA9TmWT3YoqJnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MCBTYWx0ZWRfX3z+0QpkWlO2m
 pWnQI13pyyhgnx+n9OOzcQqPAsq/fdtk+gn6DWdn9pPiz3YaCNBLPTo5p8bvG3NTijPDSgEMuvg
 0aR8pUkefh6IgrKp5S2nsyKEs2ZbHIY=
X-Authority-Analysis: v=2.4 cv=bNsm5v+Z c=1 sm=1 tr=0 ts=6a69dc12 cx=c_pps
 a=+JqGDqswvm8kVNJxtWojiw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=voM4FWlXAAAA:8 a=sozttTNsAAAA:8 a=bC-a23v3AAAA:8
 a=dsBQDNjR4xsAJqLJe2YA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: T6VHFJ8_5MnLZpoQZMYTYusXi16qiMuQ
X-Proofpoint-ORIG-GUID: T6VHFJ8_5MnLZpoQZMYTYusXi16qiMuQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290090
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=34OGEEkkf5Mpq
 DTDWUKaMqGkHA/oxDTX1nhgJVhhmu8=; b=XRQhlb6b0BzaeI9ubk4Sxk7aMpBRP
 4Cj9Aab1c7LuKwkfWiWlwSM8BoTm8Vm8TBDqn2eGyo5OY6ljuYihMYhNOagdrqvU
 7WTk0VEGe6ftpygXnxa16RC7LN/NGJGxUyzh1CgAuG77wVV/F2NSwAV/+NHOh4EN
 LYdpOJdFPS9yYFPpo1t1YcXyDO4OW8Z2c3zD559YRZ/uhrqpKU7kUq64PklaThxe
 R+L4xRBT2ln1KOwEedunUvpMZzgHfXSyAXxnWSfgDvdaSiLlgfDPNtDcMYaqIpB6
 QV2yi/xQxeGLGshGs1ePlOOJExmRCB0ZSXyijh6N0TgSxkv8q/ePGg5xw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34OGEEkkf5MpqDTDWUKaMqGkHA/oxDTX1nhgJVhhmu8=;
 b=YBmVQ4WebKxuPwomFwmVG/li7rae/fSiDomoiiKjCj2tSzGloO/mog1IXXqIfzVSJJMB/dkIDux4CpalGS9zWZ2CoHWiDBeIh/Fv+prBiRWs26kSrT8ydYUQ15ep1r+Gxc2YpZz6fGLzLxwaVp/w7EBFjPmvVhUpVzIYDKNN6po=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XRQhlb6b; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=YBmVQ4We
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi all,

This patch series seeks to help in reuse by moving currently duplicated
entries for tiboot3.bin and tispl.bin into a generic SoC wide DTSI
(k3-am625-binman.dtsi).

This dtsi in-turn gets included by all AM625 based boards which can
insert the templates from k3-am625-binman.dtsi.

The newly added templates are as follows:
  tiboot3_am625_hs
  tiboot3_am625_hs_fs
  tiboot3_am625_gp
  ti_falcon_am625
  ti_spl_unsigned_am625
  ti_spl_am625

The series has been boot tested on beagleplay and AM62x EVM but the
following affected boards have only been build tested:
  - phycore_am62x
  - verdin-am62

To verify no regressions, I compared the final 'u-boot.dtb.out' for both
the R5 and A53 build using dtx_diff script from linux source.

Depends on: https://patchwork.ozlabs.org/project/uboot/patch/20260729-binman_template_phandle_copy_fix-v3-1-9bf6cbbe1a61@ti.com/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v2:
- Reword commit message and pick R/bys
- Reorder properties inside tiboot3 template for gp to match hs and fs
- Remove symlink from tiboot3 template for hs
- Link to v1: https://patch.msgid.link/20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com

---
Anshul Dalal (2):
      arm: dts: k3-am625: add template for tiboot3.bin
      arm: dts: k3-am625: add template for tispl.bin

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi      |  94 +----
 arch/arm/dts/k3-am625-binman.dtsi                 | 362 ++++++++++++++++++
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi     | 357 +-----------------
 arch/arm/dts/k3-am625-r5-beagleplay.dts           |  33 +-
 arch/arm/dts/k3-am625-sk-binman.dtsi              | 430 +++-------------------
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 301 +--------------
 6 files changed, 418 insertions(+), 1159 deletions(-)
---
base-commit: 447f6dfb9aa2191553993441f92f9c50f6486ffe
change-id: 20260717-k3_binman_refactor-081615fabbea

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

