Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0E0C5AC67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 08:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B1D981102;
	Thu, 13 Aug 2026 08:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uleS3MiTERP2; Thu, 13 Aug 2026 08:47:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76EA281164
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786610831;
	bh=RVo5dCD0YuZuUpSy4PMehVE6EtOeX49KpZxdRajbAMc=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MNn2T4LBhShWaDR/gJNxbm62aKWlQ0FNp70Ogdjrw2GHa0X/EFEap/NrFmMF7gSBt
	 skxuAAxNa0fV6Lhp5NEODX3PyRtmAfKHevf1by3MAj/LSfoil1MyHK222fdoknDFyG
	 gqXFMheLZxe0/2kqwAIY5EWzkkoo9nbsMc1DinOiMApeo7c0UhcfJBGzAAtToCNfZf
	 aJRm2qgSZUi+CWJXAOW7aTlNSLzgIubnueXTkzUNpRyYE8GZZ4yvBCVHUbgtMfFuTp
	 uAEhcxEo9gIuUwzaNXWVohzNf/FrjYDY0Gol7Xm6xle5OUVUHUgsQpgnSgSu0FXWpL
	 4eRYs8lqUAnzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76EA281164;
	Thu, 13 Aug 2026 08:47:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BA7A3744
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FDEE81164
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 13U9avCGs57x for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 08:47:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 31ADE81102
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31ADE81102
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31ADE81102
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:47:07 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67D8A9wu2749017;
 Thu, 13 Aug 2026 03:47:04 -0500
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010036.outbound.protection.outlook.com
 [52.101.193.36])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g1a67g5mp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 03:47:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g19E+ZIrN7miLupP5WigCybfk+XodyIF21ACIHFeat4PEGpZtA7d3474WL1rau4lOV4bPmm1ZyWoVJMNo+Gx3jS1b6oOfpIwbOoBL0udPgcpIlWF169TmbiYyBWdwIxqyEoDzWUif+tWeezs1WlhDxOf4P5WbfNyszig1kDgHt3AWuGpe9LyTwzAJtZ7IajPEOFq/h7rGKjDdVEJjYjRWj5PBlhmdy/r8PQt1hczhu+4PhZS2oFLVdJopC6EOft4B0dKkP+7Id+/aidBe/RvcOKehIDiEEiNwhAtZbaYzQ7voKIy1zSM073DzVfx+6/xEk8QSKgsgX2snVYftkKw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVo5dCD0YuZuUpSy4PMehVE6EtOeX49KpZxdRajbAMc=;
 b=mpGBMROz26waMXj2Rxq9aHLYfsKndGM7XUaprrxHvdLJyeXsDkbIy/a8pVsKhBf6OGswvmijERgemIGR3UdJkL+IndaP+7qEon0Tyrfmfw4D9mkrfCK72aYaQB3SAbZpfrL//UZIdfVJxE/aCjXprs4ZTG3tD13/5w6Ha2vcY5LBthE5IYD3ZdIdM++CEWXRdPE46vXXrHtxlrhrud1Bl9/BqrEeNn6G/Sn79cs+7NdpG4po6xuKwcHiwfVx7gK5qbarfYqeSpUBOX+qag2y5N/1BMUg893uV9IYZT2O0Em/Ai83B3GTGCzUkr6uNCsMD3K3Ys+X4S4HU+WHQe5zAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from DS1PR03CA0016.namprd03.prod.outlook.com (2603:10b6:8:233::6) by
 PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 08:47:00 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:8:233:cafe::9b) by DS1PR03CA0016.outlook.office365.com
 (2603:10b6:8:233::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 08:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 08:46:58 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 03:46:58 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 03:46:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 03:46:57 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67D8kuL63721128;
 Thu, 13 Aug 2026 03:46:57 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 13 Aug 2026 14:16:48 +0530
Subject: [PATCH main] arm: dts: k3-am625-beagleplay: add bootph tags to
 pmic regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-beagleplay_boot_failure_fix-v1-1-01d73d735cbb@ti.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auUWRtIYyviVUTCTJzUkZiUpJWW0
 rsbdfn/4m1QOAsXuDQbZH5LkRRrtIcG3APjwErutcFoc9Ln9qiIcQg8BlwtpTRZjxLmzNbLonr
 SRL4zve8cVGHMXPdPv8ILJcLtf8tMT3bTF4Z9/wCGH+A/hQAAAA==
X-Change-ID: 20260813-beagleplay_boot_failure_fix-5b0bbf425f4c
To: <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Kumara Bhimeswararao Matsa
 <bhimesh.matsa@gmail.com>, Peng Fan <peng.fan@nxp.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786610816; l=1930;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=COYOOPHcGneD7FXTLNjhPuFKa3+ypHbdXLo5EaZ1Sx8=;
 b=xj/IKgVmqTRS03dccsEw3IGToqhJpUIs+A7oeL1aeAVwqXH55tV6n8dOQ5uF2DnucCO0vX4LA
 DJ6AU9qM1zODiAVI98O1wtJzbnFWaYuj2SkJgOQUkhA4zkxX44R9iz2
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe2c148-6685-4f02-edd6-08def9176fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: +8l5eDLreEePTN2kJLQMlUf5s//2ZqfttxNrsrDiLh147MMB1HsZqLvfrRvHhj0d97twP9PhgR1gBDQkLCyiRgoYogrLeYFF8G99/ViEoIpFWnHvBcJhOQAH/TXd5mMF3iohSTgt63kcxpmNljLWhtPljUUKBIBhOi+R8Jjt/5BKWdiOM4h/SCxNhPxdsZAQsTUX2eTYSGfTnCmFb03yLJcXSqwJjHIRC8E53EQ+r38Q/So/rrnps+qYK7bpRJhWEBgwELsD1rM3nVxrXoZmN4XlVnISXIZ5QQrP7c/ufqAvd3mxntubyS5X2nJpiU/VRZJ4vJjsLIxnw5coKoLaa9Ei1ro6Evv90xCNWdEM+YB4Q9LkGJs7kETbJVkrra/fok8irkI7l8m/yQz50FkVddjOLbMoCSnRn1GKb0xznJQOSqpaY+lN7f42p76qXESLTWcuwebWuUYU49nQwKNXNkw5EKmNNOfIamj+fhywFSZcWP7ydQEyR1NLvqylHJ9T897nk0OFhh4srP6M2GODc5i4nMZjnoz670AdChQsUTnbYtHroVg+/X2eXoRszugIJj2kT/sQv2EnwkpiiMQ1yxGFa0PfCn/n9fAe3dZY2y2ooh8oE6NgcwZ+C+XqA6OKbfGKfMF0Vd9rV/KblW5beoCRFNVWbzyX2ypZwh/zsoinjMeEKRWJPmrrlXo59u1Ukt+p5whkRXEwd1/I5h+LXQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vB9lkpAOgHupCwIGGkshJz+ZqKrd9MXeVlyRfkFiDbOodF76xCeagBdJC60+LVWT8NJHWg/5Ad3tSCHpB4k2NoUyWOx9NoAFmk49il/1xp+EmQqGMX/YTLR3USqfWQHFVnSgXtkSk4pdGDJUhZlE/+gzhKPIugqBzoXLLUtRgE5myINNnT3QkN0k3Hf2oXa4pAicbc7tk2VD15TMsUtwRoZp67ybinK+F1Skv8yvf7HVgyAHMqfR/+4KyukR2Txd+cm992LK/+AX5rlPMlWt1rfBfIhSqGyQl5sOMNVMgQehgt93FP7ZPvyqcM+1XpvVnLWbUh2dfZAqDq/i/GPWwa04BzmT8/jR4ueNCjQdKdVT0fJTJsGGi7i0DY9tuaY5wCCOfYnJivyUmr0BlbKnbxkRbTSOg6+7l+CZngksnjQK2tP5MKJTZlCabCve8LeZ
X-Exchange-RoutingPolicyChecked: TKMtqXmadmkd+6IoLuGKRFrTLSuVn2af8+f6oWc/G5mIfLELsFksdYrms6TORggv6ZxKZ4CvBQ7YIoD0jmTFbZO2ibWLh0AaWGhJf29DHTImLM44k8W8Y1ekKqhf8TjQajJRQWdzfrT10dfOXuNU1dDVCuCJPablRx08DNf3Gnr1iTrhuE1beAc1rF0WrkBKrEjv+u4VmMqUejMzqm+o4BtNAyq7MMJdeDhFxydo8GvOHiVbv4Cya1qcEVzyf/dDNY0bs5m0kIVmG9hzclwg71GXLKBPRq5bIWXITuBnltuTgovMB/HK6oviwbC++1DskSEXEFeu9qNeejklEMxHGw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 08:46:58.4866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe2c148-6685-4f02-edd6-08def9176fa5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA2MCBTYWx0ZWRfX0yCr97JIca4i
 wfXVE3apHTJliULO+G2BjD19LdHKzV0IMX1at6/dOasmFofjtR7eRtpbQTSzsZKntZ/wtConqGS
 a+gCOIit9Oo9XQe/xGHCoVlhv7torOMknQzhunyLzwkcFEaO+LtUOxhQMEogv/J79QxzyTJwXkg
 p3KG3fME5v3YP7dlRffF8tbjkUDaeZ7GTnWqoGzJp1dWHDPO/LWhps2DmLX24pERzo4Chn99eI+
 pjIKBpREAg63XupoM19oJtTWAUhECA/KNG/azvP08eZl8dkJR2MyEBA5Jgdfm0WjUWEBvlZQOiq
 QC0wrzwStdGAfoPanTyUIJHlLaet42FoRRWLoH5hKtMLbThSHMZscthOg9F5uh6WxWtcoa0vyuS
 LIvo50Wc/ODQmi12zuR5pdX5hwdRxEBNVnpsR6Mu7UHJCNTGROWCyWIlPYu3OJRE60i0TFHZcMf
 1ijLzAjjfK/DGd1TI+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA2MCBTYWx0ZWRfX1tp0YnMgBf7f
 0E77qtXjsLLvoW/5Vb/C1Q7yoqV6Y4VcS/79sMTkQnr+fGV/8ZvTGx/3/aoc2dAprfv4CXKHFKv
 m099700UXfFRTlWzmzGnRDthec68FEg=
X-Proofpoint-ORIG-GUID: 3MruuihHJC0_cqFLhLNo6z7sZeS3LUz_
X-Authority-Analysis: v=2.4 cv=D/J37PRj c=1 sm=1 tr=0 ts=6a7d8488 cx=c_pps
 a=VaBts2rfnB/nCs5PY8NajA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=W8P6LO6VI-cQjg85CY4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3MruuihHJC0_cqFLhLNo6z7sZeS3LUz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130060
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=RVo5dCD0YuZuU
 pSy4PMehVE6EtOeX49KpZxdRajbAMc=; b=JLC8AHTYUqF9OxBLN+v+SXtop4j1G
 S+vmj80DaZCVFc2WrJLr46W67wLsFINxQhszfSC1Zb9wGodsH14Jt85t1dUmN/9W
 HzuO7olqvt3cEDHu/WTsjGZCjA1LJguwpH6ZbvvoqeXc/kHkcu1E7k6HfTmq+6cN
 fivArQSseHSX6E1MJ6SvGhnHLUcWYO4R1d59KYXxH0IK2UESXBTJcIf9uqYo70VQ
 3zqxRTCrzGrB9lj712ow+wg959+7IuF9zHbz134eNdYkvwKBOtpfealTTMHjpxy4
 MBfuCNJzk61vGKy8qp26C744wHO6vlJ+iXbUbnJd5d5Qbd1iAXl+fha4Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVo5dCD0YuZuUpSy4PMehVE6EtOeX49KpZxdRajbAMc=;
 b=Z4MdL17oiPpdcQL84aUBRbU4yUpNiZ9JuLP1LGCaRbZf1Z2xX3OXqNpIGeHmWWDX9CFmsqYYU0qGY5b9e6hyOQGeX2OSIedMP0pXLUmhRSPDJGlv4iUx4yyFt5z8R2etT8e7do+pzWDyKhdOhpiIZcFHJcwWhuVMLpcn5G0pETQ=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=JLC8AHTY; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Z4MdL17o
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

With commit 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators
node is missing"), the driver requires the PMIC node to have regulator
nodes.

Since we don't have bootph tags in the regulator child nodes, the
resulting DTB doesn't have any regulator child nodes for the SPL phase
leading to boot failures. Therefore this patch explicitly adds the
bootph-all tag to all regulator nodes for the beagleplay.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
This patch resolves the issue where the A-Core SPL fails as follows:

  U-Boot SPL 2026.10-rc2-00025-g0b581a9612e4 (Aug 13 2026 - 01:30:38 -0500)
  SYSFW ABI: 4.0 (firmware rev 0x000c '12.1.2--v12.01.02 (Clever Cat)')
  SPL initial stack usage: 2048 bytes
  ### ERROR ### Please RESET the board ###

I have also sent a parallel patch to linux-devicetree to get the fix in
the upstream DT here[1]. And this patch can be dropped at next DT-sync.

[1]: https://lore.kernel.org/all/20260813-beagleplay_pmic_boot_phase_fix-v1-1-4518e7cba940@ti.com/
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index 2a4f0e453652..cd13b5c3cd1d 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -319,6 +319,34 @@
 	bootph-all;
 };
 
+&buck1_reg {
+	bootph-all;
+};
+
+&buck2_reg {
+	bootph-all;
+};
+
+&buck3_reg {
+	bootph-all;
+};
+
+&ldo1_reg {
+	bootph-all;
+};
+
+&ldo2_reg {
+	bootph-all;
+};
+
+&ldo3_reg {
+	bootph-all;
+};
+
+&ldo4_reg {
+	bootph-all;
+};
+
 &cpsw_port2 {
 	status = "disabled";
 };

---
base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b
change-id: 20260813-beagleplay_boot_failure_fix-5b0bbf425f4c

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

