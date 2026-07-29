Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067A1C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 19:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 925D480EE1;
	Wed, 29 Jul 2026 19:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UQ3i3l2ZbdNl; Wed, 29 Jul 2026 19:34:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7806380ED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785353684;
	bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnLYI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K9vGzsFlsaY3nSOCI8rrQOczXM87Jf3sQVcMC1DeAP3I0+gAziye4+MLBR66cziMD
	 W6IXDUwKTF/9VTmYDQOGcjWf2jC0ryR/iAu0557ynwJqdoEIOLVq5E197Qx8lx5M0O
	 OPyosvH2C1AjRVAQvJQNZJRMw6ZSAr5efH/SN4+QdtsEH1xGjx5xVnNREgwRBwyiNG
	 icF76QjVaSxM5iUKrAXau8J+9GlDzhW+alzJni7O+9xN5XpxqQKzCJWHzpqks1sUGC
	 dyfF4D+/oz8xWT6GOFlTYLXghnYWEWdUbbYIgCPkl6UtCo0eagA9UrkSX0cCWFbqBo
	 n0P9nj+AkGaOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7806380ED7;
	Wed, 29 Jul 2026 19:34:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF74227F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B56CB60731
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:34:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIhrmLuU6dav for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 19:34:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 247AA6062B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 247AA6062B
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 247AA6062B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:34:40 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TJ5xqr3536769; Wed, 29 Jul 2026 14:34:34 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fqqcmr59k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 14:34:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMJ6cNR15dNjKf66/KKDwkZfYrcr+U/zpsGzzEaEuMRtp4Q2p48tajTs9H5X/vLX6Qu38Xm3vPIOHOKs7TARGKtFfnAyyUF5/OsmaPeDkOwshFOI5mzkzkbIC2Gwrpr6jIZgniE5Wp/F81eFvRJM2A6q8vLi5BgjZ1qA46K4XRYksQw/uiF0wGOTlb3yuz6IgT08resJXu5eCELNdteEqjHJG0nh9ms6seLzDi78QM/kJ+2pwbjqz2ph6LvpJwlg3AttV+CTSBCixHYG4NRxM70SnG90NXrqQ6sN4y9YU7qSgcx4zu8XBcAGZT0A6ADVkY+N2BRDuccIO7f6I3nvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnLYI=;
 b=qCXZGug4+fH11mwzlgHVBCjr6dcBX2baLX7gWceXaBIP8mOuEM/vW18Kta37GC9H5jJwa4ZxsIeJ2pICkQrU9fOuV58H8V01C+9xggM+Y46L5+6rexQIQrkBqoCu/L5wzkvsD8sH3kkg5zqbevfPATyvgRaMEAjA7KrehFE1blyme8uj/oKW7eCl94TIlab36yWrX9U+XPptNSODN3JxU9FKCO60uLO/1QqGQOKCFmnkbopg7fFzRmHEcMgw7cs0U4rsTYbnzGHZyA050/RAvPUTMb2su1zwFF+PfjY3kq1SbRgORKqzy+SimgwOUfGReF4QPg+LDkqFM3zjGQ+6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from BN9PR03CA0599.namprd03.prod.outlook.com (2603:10b6:408:10d::34)
 by DS4PR10MB997770.namprd10.prod.outlook.com (2603:10b6:8:34b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 19:34:31 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::93) by BN9PR03CA0599.outlook.office365.com
 (2603:10b6:408:10d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 19:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 19:34:28 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 14:34:25 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 14:34:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 14:34:25 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TJYPKR1893221;
 Wed, 29 Jul 2026 14:34:25 -0500
From: <rs@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <robertcnelson@gmail.com>,
 <ayush@beagleboard.org>, <Erik.Welsh@octavosystems.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: [PATCHv4 1/3] arm: mach-k3: am62: add &main_uart6 to clock and pwr
 tree
Date: Wed, 29 Jul 2026 14:32:08 -0500
Message-ID: <20260729193209.798946-3-rs@ti.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729193209.798946-2-rs@ti.com>
References: <20260729193209.798946-2-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS4PR10MB997770:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a886fe1-2699-4461-76c8-08deeda867f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|56012099006|3023799007|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: zPDufKY694vI0OYRQ/ZFnfxn+tlozp9GQcST/agTBhnAtH2nrfY7RnxdOq4lNJ2QmiRsANsnhH1sf7fOK0W4EePVBiSDnvg2OncZDYj46xfEkBNY/CRpgQhaH6aklp7rLL/xE+YueKo6DLr2eZ/N6wCUTq5aR42VBt8W042FtVcDPtyrbJ+qnt6p8Rza+W/6w2YnRWiLjxbjj+dXXtovWHmrB3bM1FzE0BtdlQoNv6tq14vux2QgXDjBNY+5l2WutL6tZKJ5oaRfUyS9u58tGbTJOZxPGnoCv08Yhb/WZfSBS2QTFNGysQGhRfh4CrcmgielDkcyZSWHlFlwfIel2NzUMoHCt1rMSMbdDZGLOvIgZjLbO8CoP79enu3J1qiVgW3WsqZdPOGZ4O8QkYeKUm6Y5189sjFlBNp6m31ubVkbpxcCoarY4e96LIsLTCxHUkQ7E49j9puAHvDCSv1FBNN689RTrxqKYtLII8yWdxLTZf1PKoe2I5tKquRPwYKGb9SCbkFyMW9M3vpXGCahwW+KHCa3ufDE4sIEoS6hTEGZ5fdLi8V/DANYdWeFK+hELWk8px5UtnmUIrM9hCQq+vSzYuYfvoZITcf4w/ly5mgcYoJ+S8nepx9nT5HDUghQ+ls7TuawPvph4AdVBp138w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GcBIgKhbCt53y4HHMUA8Y9Lpy09idmtIsC4NXdYLFSQfMBYPxHndw47rbZAGtCA9B4IeKnmKO2v2vyHLSJ+AtH0ltQ89ajuXPSc8RsscRS1dGzL//Q2lkh5VCH90EWvLc/mwJ5A70RQ6nglKPjBqR2ZsDaezUT2U15TnecwlZN4Eex3Kb/SUrmS57PvYByOpwupQfNCXs2EFyYnbKXtflJucOEGQkVtzDqSjcP1s66/E6spjctANC4FjuKQHycekR+oBxMjCXn/gQG+jCNR3aLH/4uePazKW3mv03NDFQCFrtKGCT4KbwDRFtLNG7h2Gmnn1kGvlOh5EpVj3O3qu8rFc3W6u0kiLMNiiCS68Pmb9gaz5r7bf4j+PHykMNkObugirpOPaIi1ZEsp1QvTKNZH5F2nWh/MJTDmVXtud49eL24ZmI34J7+kQ5CRcbMqr
X-Exchange-RoutingPolicyChecked: JJiS3JPE0FjLL20PmcVA/pavQt8zYiKvQbcR1AlZyVbJejpZyp3BMgRBTgzJxMwtfWTeYPDxiLbDkp2L6IAHHcGtWE/Wt2Zm2x70vpoZVUTYTx3lNFpm9kvjqAYxzinoGsEJorOuRCBX05I2rJ8mU02HelppWyTF6jLJTrGx2zPmKQNP6ItyIy5RyNmf13xrzMycLyMQD9aUuF//rJ9k8eiP1pD2RxwMVKE4HkLYDwwwItfdppMUf4rFuxLvX6WdQg6GfEOeVmyZut74LTLLzVTjLitANiUhWi9SpwhPfrIFXtSjsZ4W4jC0s7+8c1jMhJ/NN0WGF0ZnYbEX336rSQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 19:34:28.6504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a886fe1-2699-4461-76c8-08deeda867f7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997770
X-Proofpoint-ORIG-GUID: Qom_0Ts_keYPjsbXBVvMcXtGscNkQL3m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1MCBTYWx0ZWRfXwiYhIdx/lpXl
 Xmcp7ZZPTwBCX/7Y2U/39vocqEbv7tqBeXte0byOqhOUCTfRjBq2aTt2/ou07/1jHY9g9YJtTic
 hRda+jahPqk/rTP00j5LXMfK003elLI=
X-Authority-Analysis: v=2.4 cv=UtZT8ewB c=1 sm=1 tr=0 ts=6a6a55ca cx=c_pps
 a=P7Y/ubs9jOqwJofkHNyo7w==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=WtDTEybOK8mIDu76bVQA:9
X-Proofpoint-GUID: Qom_0Ts_keYPjsbXBVvMcXtGscNkQL3m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1MCBTYWx0ZWRfX/OVfLdUuTMZr
 YjrFcAYsXmcf5OHAXVgbNtPotFppsrTeRbayfrLXVit63qejUVkFKCcxQoM3Yeo0lhSOKnsnd85
 6ZveeWOH2076qiizPYlJnHrHSPVXRLqoQHhnFTdKBGZaQQcPgvoY55oLoKL4rScfiafA1FPWcKy
 ofkoTcpp+fUJtQNRQf05GY4Ay3TLyJdr7W43dth1gcWNytO6uhAT29/hwDcnML7YMn2MsKXqnK1
 WaaacmcwKR1hsswxjwRTo8TDkgO6NmiYw4Y+9Zud5fmDh/AMv4FmuiSW3lGuBIm+oE5ul9EIecQ
 q+RJDjbMxZfbNCLjKxyTp+Qa0N+i6z/S/FTNr3rd8HA9F7dYjlo+oFQbSeFmlJKlrgW2SUH0EVv
 jtA4RRSm3FImapvpBgjs092bsfpQI6xFzOuP3i4VBFqxO2EdH1TeGyrz115XO2pZukkKtNgMbAm
 POfokj7lpnfXZ94J68Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290150
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnL
 YI=; b=lbLka4ZyIai4DT5/1acMnl6XgENjvHRme4gFNQ5qce+K/ewrrx4reeYki
 JyJg2rCpI1gVJ57NXLDNqUUnin70fOf0KaAa8BoZPCMpn0jXPzEjRCzM2AupC6vL
 EY/Nq26JRJlZLCeAyv1PMFDIkYzk9RNqFbNJ67Q+vFawbhHcAonmzJrRkMPqOEzB
 B9vyIt3cXeevAhmrtpG1kY/PrgJ6FtoGczBz5JTOYr/5V2ee1drkkfVEk973dp+M
 DDmCfvtQkkLesh5/1W6tV29bS60gxQGVsmgnY2bEJRGhgqgzZdNBoEd3pRwbWVkm
 Nk+N+rP4zJQMc6L8/+7fXfMPVV5gg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnLYI=;
 b=XqMp+rDiNofx+UMzM2EBWqhEkTtN6PunBSvbwGOmADRdC+dwJ05ZNPbR51kPy1CV7MDgmFlgDmknKMqHKC9idUUBPe0VE7QhA29hgC8SNb3SZdJQNW90eT1Kj8oHoO1+X6Zyjpia/ued3qwQy23ZKg4cQGm/PAY/Mk93ZXm4zEQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lbLka4Zy; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=XqMp+rDi
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

From: Bryan Brattlof <bb@ti.com>

The pocketbeagle2 uses the main_uart6 as the debug console. To get debug
console prints at the R5 SPL stage, add the &main_uart6 to the R5 clk
and dev data so we can configure the uart as early as possible during
the bootup of the pocketbeagle2

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/r5/am62x/clk-data.c | 19 +++++++++++++++----
 arch/arm/mach-k3/r5/am62x/dev-data.c |  5 +++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-k3/r5/am62x/clk-data.c b/arch/arm/mach-k3/r5/am62x/clk-data.c
index d7bfed0e031c..05cced0b313b 100644
--- a/arch/arm/mach-k3/r5/am62x/clk-data.c
+++ b/arch/arm/mach-k3/r5/am62x/clk-data.c
@@ -3,9 +3,9 @@
  * AM62X specific clock platform data
  *
  * This file is auto generated. Please do not hand edit and report any issues
- * to Dave Gerlach <d-gerlach@ti.com>.
+ * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/clk-provider.h>
@@ -125,6 +125,11 @@ static const char * const main_usart0_fclk_sel_out0_parents[] = {
 	"hsdiv4_16fft_main_1_hsdivout1_clk",
 };
 
+static const char * const main_usart6_fclk_sel_out0_parents[] = {
+	"usart_programmable_clock_divider_out6",
+	"hsdiv4_16fft_main_1_hsdivout1_clk",
+};
+
 static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("osc_26_mhz", 26000000, 0),
 	CLK_FIXED_RATE("osc_25_mhz", 25000000, 0),
@@ -210,9 +215,11 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("main_gtcclk_sel_out0", main_gtcclk_sel_out0_parents, 8, 0x43008030, 0, 3, 0),
 	CLK_MUX("main_ospi_ref_clk_sel_out0", main_ospi_ref_clk_sel_out0_parents, 2, 0x108500, 0, 1, 0),
 	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out0", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x108240, 0, 2, 0, 0, 48000000),
+	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out6", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x108258, 0, 2, 0, 0, 48000000),
 	CLK_MUX("wkup_clkout_sel_out0", wkup_clkout_sel_out0_parents, 8, 0x43008020, 0, 3, 0),
 	CLK_MUX("wkup_clksel_out0", wkup_clksel_out0_parents, 2, 0x43008010, 0, 1, 0),
 	CLK_MUX("main_usart0_fclk_sel_out0", main_usart0_fclk_sel_out0_parents, 2, 0x108280, 0, 1, 0),
+	CLK_MUX("main_usart6_fclk_sel_out0", main_usart6_fclk_sel_out0_parents, 2, 0x108298, 0, 1, 0),
 	CLK_DIV("hsdiv4_16fft_mcu_0_hsdivout1_clk", "pllfracf_ssmod_16fft_mcu_0_foutvcop_clk", 0x4040084, 0, 7, 0, 0),
 	CLK_FIXED_RATE("mshsi2c_wkup_0_porscl", 0, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_main_0_chip_div24_clk_clk", "sam62_pll_ctrl_wrap_main_0_sysclkout_clk", 0x41011c, 0, 5, 0, 0),
@@ -336,6 +343,10 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 164, "clk_32k_rc_sel_out0"),
 	DEV_CLK(157, 165, "gluelogic_rcosc_clkout"),
 	DEV_CLK(157, 166, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(158, 0, "main_usart6_fclk_sel_out0"),
+	DEV_CLK(158, 1, "usart_programmable_clock_divider_out6"),
+	DEV_CLK(158, 2, "hsdiv4_16fft_main_1_hsdivout1_clk"),
+	DEV_CLK(158, 5, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 2, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
@@ -361,7 +372,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 
 const struct ti_k3_clk_platdata am62x_clk_platdata = {
 	.clk_list = clk_list,
-	.clk_list_cnt = 90,
+	.clk_list_cnt = 92,
 	.soc_dev_clk_data = soc_dev_clk_data,
-	.soc_dev_clk_data_cnt = 137,
+	.soc_dev_clk_data_cnt = 140,
 };
diff --git a/arch/arm/mach-k3/r5/am62x/dev-data.c b/arch/arm/mach-k3/r5/am62x/dev-data.c
index 59c95df2a887..ea1e76a8a758 100644
--- a/arch/arm/mach-k3/r5/am62x/dev-data.c
+++ b/arch/arm/mach-k3/r5/am62x/dev-data.c
@@ -3,9 +3,9 @@
  * AM62X specific device platform data
  *
  * This file is auto generated. Please do not hand edit and report any issues
- * to Dave Gerlach <d-gerlach@ti.com>.
+ * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-dev.h"
@@ -61,6 +61,7 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(36, &soc_lpsc_list[11]),
 	PSC_DEV(102, &soc_lpsc_list[11]),
 	PSC_DEV(146, &soc_lpsc_list[11]),
+	PSC_DEV(158, &soc_lpsc_list[11]),
 	PSC_DEV(13, &soc_lpsc_list[12]),
 	PSC_DEV(166, &soc_lpsc_list[13]),
 	PSC_DEV(135, &soc_lpsc_list[14]),
-- 
2.55.0

