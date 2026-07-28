Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF056C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 10:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E84254093B;
	Tue, 28 Jul 2026 10:06:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tYB84u13Slql; Tue, 28 Jul 2026 10:06:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC22F4086E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785233200;
	bh=v6pj8TlJsSiCVPZFWkoxlJ0g0HyFXmmKu020eftttuw=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q4897Mk0WT5Od5v/xntllX8gHrJ0NrcHhfkZ3rrwnTHgB+WmGXNPGLQr4MpEM9Z3K
	 H/QHFHksZ+/sj7qWcb28s0qQ85lQZrghDi6xAPUeXt1FqfZ0lcrzmzQbJv6yVlOAdp
	 9OjwwJt/6J3xgTXA0pb58mSYbOPaIxtWD/opluYkNxx3mVjGRwSvWYt3NkCHbYARtV
	 mHEoYnlTX8JJ7tCi4wHwzXsxCfS0FsVTufv9U5DRofe18tvZqv+3ejxVAU73qxNCts
	 7VrUMcNJhxdohM/K10MlVPd2amgMsr3SLx0NoIs0KFeerFEJ5aOYf63kZ4pcYc6o/Z
	 TWc6CROrb+ttg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC22F4086E;
	Tue, 28 Jul 2026 10:06:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A0A142A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56AB8400DB
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:06:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NPHFRRJ7TkzH for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 10:06:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=m-shah@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0E946400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E946400D3
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E946400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:06:37 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S92BNG3262624; Tue, 28 Jul 2026 05:06:36 -0500
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fpseg89tf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 05:06:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfsgZJ3LdUCN1CxqoeIO2+kNQigJPDOX0fMEzY6tzc4BtpWsFt+DsvmEVzojWziewFGkhuYqc3fUFNcI1uI89kjX/d1xUH3/6Ix0C1oQGHKfInNQWnZ3D0l/OeXQzLzkDrV5mNp9/pX0371hb/yHyDzUe4YkYr1QHDw/H4OGJL1GOd/9QxJE4ITOtJUmSNP2hfKyoOwpQc8yqFnBWRChJkipgZqLTPvHX+1l3T8NNFm2pJIyeS3kmfuwRPb9iNgBWXBAUKL6yUH2LqY5NO/lDdpW26yY8mSv0+iePBeqNdNxnYt7ehbHdd/+ionogUc71VQdPG2w+VHdcVv7GPziAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6pj8TlJsSiCVPZFWkoxlJ0g0HyFXmmKu020eftttuw=;
 b=fQtfVuzl+Y6JcJdEpLRvEHA+mieBbuv2BP4RVBowGtyjjbyXbitSU8ngDNRpgyXeakfpYjGdFWM0PdVbqf4fl9kfPH+Slb8xfEgtfm0/9fhW/fa1Kn8r/VYXD70EinuAK5oj2lG3BnHxd8s8taGzehT+Rtw4jFoRzMGfrbC+xnSP2zk8XFYS5u9RajyXj0BPRA0aCMVceZLRx5LAp9VKx0ftr5zg0GviLHmUPkktVgRD2JfAgvBSRWk1LV9gzqZaJcx2WQpJMOCkqXANtzCrulwbD5vuwzmAroFwPhuuCNt++A5BGVglV2f/EB3giS3014vPiu9T0OGVkhup/n6smg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from BN1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:408:e2::20)
 by DM6PR10MB4330.namprd10.prod.outlook.com (2603:10b6:5:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:06:34 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::3) by BN1PR13CA0015.outlook.office365.com
 (2603:10b6:408:e2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 10:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 10:06:32 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 05:06:29 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 05:06:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 05:06:29 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [10.24.50.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66SA6QqR3083594;
 Tue, 28 Jul 2026 05:06:27 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <anshuld@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>,
 <gehariprasath@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2] board: ti: j721e: Fix up eMMC OTAP delay for HS200 on SR2.0
Date: Tue, 28 Jul 2026 15:36:26 +0530
Message-ID: <20260728100626.4065232-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DM6PR10MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 050cdce7-194d-4e51-f05c-08deec8fe6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|18002099003|56012099006|10067099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: xn6emP94GrkinbFaokBBk2lSOd9YIuqbNad1fojgikOq5E6tQI6wSZWde6Tud37T0RUf+okPcjjkSzTIfK6K9IPpk2kQic800BonkoQ6Y0BAsGpoe0kdhYEugJV0jY03HTVpzbplHV1NWm0fcCBkonqeooSjMbqSg1LirsocQcJs3AK22DTkarqgHf6+4gpTfNqnKLScVdeLrW7Nj3WCW1BkSppU+Sq588iGKF+wGmVpSVYsz73t7P3dJv1+/qr1JZ6hJBRwySEk3rvPJXs6z+6gcI4yJlSdEbGhAKE0wQC85yaXfh09R5lwUoqe4SaMdC4T2u5blGwMFZiGXIML7lniCVkolgdTD4Mw5E21J7lIDgH09bBWzn6wJoBTPBtnrry3DmD/x8OpgoXflhTG8q8lspLleQ1PD1Ruaw8K5nUTxHXKeCcNmiqQOztZQ3WXxh+g1rWx9xNom+OHdmy3bQ05ElPrwVMqlT6avbBMuOWwbcLaRtZVFq6E41B6dEbnvsf7DBvLFjUczoVtc2c6noXk5rLp5Mc8oMKRCl863Df2RKeUzqUHB3lhyo16E8QdvtKOdoEiFxaedc20fRHgpASeS2s75ub/a5Ap0n1XoQ7sWjxfBMI+shKZqrhoqJ5snL5cBMLI4/2EMdm2hU+N8DtKQdjcCxOmPsv5PkkieVs=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099006)(10067099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CNdiR0Shwyuzhszs7pCiVYAKUzfF/BI+rmUIdpjKVISIySKyq0F43ZrVZ6lk+xMK7Ny5g4YYRwDMjCn+7y5VNRORRYqsP39mv4hWAE4J5iWJh6ZK4BRzwqWjs44wzzXVyyvt7tM1/UzzAwrxeAg2niec/EfY67IFqOjdK7enlrqBYM+l/zp5P0rspPOpxQWf14zzWODMXQxPSvryAlvib67VLlGt3pIsrEfi/qtLafTIV0+YXyaF/d+XY6uyBFd6+Nk2R2fnse1uQBIAe0hsDEsC2ttBmciQB8lMvwpm8J088yz4x94mTppNn4YhVVtzIre/qvU2soZ8QFijg57TUV2PoRhwa7pAskmTMc7DcBrCkspGiOn9teBUaZa0VuoQ/bxUFdDBTGivLPT61RuUIwZfVqTIzlZu6b/1solfLF1Jq2aU0wtYz+zsdKyP/duP
X-Exchange-RoutingPolicyChecked: kxmYOHCU1IJbfv28IgfmINCoMJ0+RPpNxKaGMQgVTHtiJ9LmL8xccOj7K944KH78JquUgya7QolG/DtQC18Ox4g1gy9PW7+aYxF6TE5nC8pHo8jTXWLlp2uABcYjkhTeS6G68m075XHqkeeqWUk1j2KDLJSq11ZzDRFXBajKWuj8nIisZwjd/OQ97jj0/wGMpXDz0HCYcKyDETn1inWTJHIjVu8wBXS5wid99O48tnMVrAyQOLQGZjgVOvi3ulo/AkFYTR1dnhKO/AFRMR0sFixdCsRcx/UMK86tm+aB6RfAHYwUxJxo2WMl2yT+croV8UIvCILEDnDwn8azKvzTXg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:06:32.7920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 050cdce7-194d-4e51-f05c-08deec8fe6c1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4330
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4OCBTYWx0ZWRfX9F5Q41qNOb9h
 Pr4h/5wOnQGrBMLVB6mDbOpQRdRADhy5sUNnluvqjJIHxbaGdm5+i5+fokVjRN1+HE6HG3itKzx
 VTAPoaPQONTkBD/eUsxAdFkvzAcKTJM=
X-Proofpoint-GUID: tKUek7zSP8GtbhEvbo9O0X8Xp2bdKBcu
X-Authority-Analysis: v=2.4 cv=Iu4utr/g c=1 sm=1 tr=0 ts=6a687f2c cx=c_pps
 a=CrKnoqqb99nOpAJSR4mnrQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=Z7R9Haq8394pxuHmFM0A:9
X-Proofpoint-ORIG-GUID: tKUek7zSP8GtbhEvbo9O0X8Xp2bdKBcu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4OCBTYWx0ZWRfX/xePZsDQAGPn
 Ak2vKjKpeojw8veJVdyv+0yZ/M43ofqphu5gChLe3y+lfQ+EE0r5KlU9fuWBbzN/t0WCCxqIqZo
 ZYckkLJJ8AA/MJRGVLVMTC+3jdbLSiSdDccbSovoNvEYNAkkXvYWjqPen4rdUDLRLp6V6L7HYFW
 NzkLD6WG++/crond2hw0lDfbqNt9VCZxo/C2CSkmLcDiO6g7Fuyd7X3BRfLrRi9pUKpGwE/xHLf
 iYAHh233ixOZH7UMr1vdefcpmk+zlyQ++L1v5rRx5lODQmI0r2ftZtrNCKpp+KJc+usvrttp5dh
 UKDSRujNzMpoRaRMW5bqfNVvq0n4BwKioxSNOeKNDFigSiFpEgEKCuBlG0vzIVC3TGjytsk/wys
 RaW43uphayQ1zb1IZUtgHVRmLY6qyogrFBQHPhvUto3dKzNLIlnvMBEK5JHrS7RiQkSuWmAxEVp
 U+VyHJkwkxRHElGO0fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280088
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=v6pj8TlJsSiCV
 PZFWkoxlJ0g0HyFXmmKu020eftttuw=; b=ABULFuxkk4NOu+pf+9zP4pxGqHBfA
 +w7iljLxE3m35EGzAuSJgtMp1nVTS5GKsxAzC/DKVc8/Kkjf0nESrc91IYa2O4bx
 ZmaUj5oTFPTyAEaDRyf8iGj3uK4MQVcD0NnH5L2LeBNq2DaEzqoNjxhVaQ8BTytL
 uxeNx3GU1TAKNpUGXya+vVqQFgW2nZJRDlvJFtM/C9JgHuEoLeADaKP8GqnAMFNY
 adkLtan4jRGL78S2a/8gMvUfo6GcQNY9tXrDJTHFfAgCPE1H2FGV8odsPToQPUqu
 h7GRz2SlR7eFa9AmjRt/0SdTy5YWK2OU1qDFzuLhzMFcb+pQ2YZVIUBig==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6pj8TlJsSiCVPZFWkoxlJ0g0HyFXmmKu020eftttuw=;
 b=Dfau8OedWTmhTDRJH/AP5N4O/pDSalSDVgkPRKqk++APr3aIpYQ1jakkIdF4vi6+1oiyfKUBy39FO3l20yEd5RW3V+IGbEJ2OmhWbR/DLKNR99ol/eaAFXhI4vN4hx18l/iOrLFTc2LhWx6ip760BV25te9fKhPRubMopXNmBvw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ABULFuxk; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Dfau8Oed
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

The J721E SR2.0 silicon revision requires an OTAP delay of 0x8[0] for
eMMC HS200 mode instead of the 0x6 default used by earlier revisions.
Hence, detect the SoC revision at runtime and patch the devicetree
accordingly.

[0] https://www.ti.com/lit/ds/symlink/tda4vm.pdf

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
Changes: 
- Fix error msgs and add error check for getting offset

 board/ti/j721e/evm.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 881392bd963..da4eec2a44a 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -16,6 +16,7 @@
 #include <asm/gpio.h>
 #include <spl.h>
 #include <dm.h>
+#include <soc.h>
 #include <asm/arch/k3-ddr.h>
 
 #include "../common/board_detect.h"
@@ -33,6 +34,9 @@
 /* Max number of MAC addresses that are parsed/processed per daughter card */
 #define DAUGHTER_CARD_NO_OF_MAC_ADDR	8
 
+/* eMMC HS200 mode OTAP delay used by the J721E SR2.0 silicon revision */
+#define EMMC_HS200_OTAP_DEL_SR2		0x8
+
 DECLARE_GLOBAL_DATA_PTR;
 
 struct efi_fw_image fw_images[] = {
@@ -125,11 +129,50 @@ static void __maybe_unused detect_enable_hyperflash(void *blob)
 }
 #endif
 
+static void fixup_emmc_hs200_otap_delay(void *blob)
+{
+	struct udevice *soc;
+	char revision[64];
+	u32 otap_delay = cpu_to_fdt32(EMMC_HS200_OTAP_DEL_SR2);
+	int offset;
+	int ret;
+
+	ret = soc_get(&soc);
+	if (ret) {
+		pr_err("%s: can't capture SoC details for OTAP reconfiguration\n",
+		       __func__);
+		return;
+	}
+
+	ret = soc_get_revision(soc, revision, sizeof(revision));
+	if (ret) {
+		pr_err("%s: can't capture SoC revision for OTAP reconfiguration\n",
+		       __func__);
+		return;
+	}
+
+	if (strcmp(revision, "SR2.0"))
+		return;
+
+	offset = fdt_node_offset_by_compatible(blob, -1, "ti,j721e-sdhci-8bit");
+	if (offset < 0) {
+		pr_err("%s: can't find eMMC node for OTAP reconfiguration\n",
+		       __func__);
+		return;
+	}
+
+	ret = fdt_setprop(blob, offset, "ti,otap-del-sel-hs200", &otap_delay,
+			  sizeof(otap_delay));
+	if (ret < 0)
+		pr_err("%s: can't reconfigure OTAP delay\n", __func__);
+}
+
 #if defined(CONFIG_XPL_BUILD) && (defined(CONFIG_TARGET_J7200_A72_EVM) || defined(CONFIG_TARGET_J7200_R5_EVM) || \
 					defined(CONFIG_TARGET_J721E_A72_EVM) || defined(CONFIG_TARGET_J721E_R5_EVM))
 void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	detect_enable_hyperflash(spl_image->fdt_addr);
+	fixup_emmc_hs200_otap_delay(spl_image->fdt_addr);
 }
 #endif
 
@@ -137,6 +180,7 @@ void spl_perform_board_fixups(struct spl_image_info *spl_image)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	detect_enable_hyperflash(blob);
+	fixup_emmc_hs200_otap_delay(blob);
 
 	return 0;
 }
-- 
2.34.1

