Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B16C4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6806160901;
	Tue, 21 Jul 2026 18:09:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YbZFDKWHp-Kv; Tue, 21 Jul 2026 18:09:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1D90608CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657362;
	bh=X8/RliubH5aInu3ytR0ECGMek6ri/wDbcJf6DEZVkQc=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=nT/vwbEt20Sh/a+KJhJYqfSr93Ey5prOuYXzvjYmXf1wKRKP7XkHPfvV+bab2w6b4
	 c3aSrc7Ylnpo38qXmec0Mf+i6p+a74ZZRhFFYcq2sS9BrTsJUc5kwvPrteryS/ugnK
	 c+5B+8YNU2/5b3KiG5g8IBYA0fI5e3xVL3QBrsKS9oK+XDcHQ+6joGprfmDj3cltx/
	 Qfl10vm9p/XITdjcIrm6BGyZsBZRiVOWf9yX3bTC1VGX693YYi+v41RvK1yPcJErhh
	 GkIaf48GBJ9fgFnxKGN4zMIvyzmiUsoMJ0b1PR7EGVHT4pcd0kZybQ6cCbyxbZGAF4
	 jFNZXzMqqgPqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1D90608CD;
	Tue, 21 Jul 2026 18:09:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64010313
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49C2140838
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:18:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ibS7TOe6rErD for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:18:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D99E540829
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D99E540829
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D99E540829
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:18:18 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDjpkg998072; Tue, 21 Jul 2026 10:31:08 -0500
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fj7q91knu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:31:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEYttPIAEfwd/hwKA8TXwge2w4m7ggRxoUgJqgs2l7Ho0gDDZ07YaTyH3SkNRec0+ROXLf406+UxaQ8TR4OrmKE/6PF3s1hnH69S2ANmv3uVVEIBZsascm5avnPYlCEb/9QHpGLwb9s0KyMZ15KlaCMdohS3JOi6RPxUFiYwINywpzAY7uDEenSclHTbRyCgURxgvlO3B92Obq2mORukmwVh6hzDY8HXAJBWIJU/02kRgLgr6UtCkGvtmrA62obWnwPnYNBxEnZPUxVGl06b6I+GJ7Xa1Tpng3RyG0x0rl+IBqS1BXeUfUU9G34DEh7ho8LFDSI2bu1uYTVdbSIVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8/RliubH5aInu3ytR0ECGMek6ri/wDbcJf6DEZVkQc=;
 b=csXYmMNB8UpoBp4A66Cd/26NdLKYFG9LEltxQ472H5+FD/DuAReGxPm2pBPtllK1Ti0eQePZPIcYWpNJM9BU3GCBmDHtN30y+ASH/QXFZ+ATZRZZzNntsTI2BapgL2EB3XrP4e2jDwfhNGg1jdWyZBHgDMRJk94UCGD+QepFMdNjGXg5Jno4/Sx6MwGeoEQlS6YtQwAUecM0/QBVYzVtb4wh61u6eMmYITknpeuDU6P+e5eiYtmWcWjU1MqjL+FRcQuINA5m3QVn1Rk3gDj9BTU1Z+AvL2pheonLU7zam3oFp9ul7q1wVv7A6TlhG/LdUgt0UJ1hI50ZzT4Q3BPPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from PH8PR22CA0023.namprd22.prod.outlook.com (2603:10b6:510:2d1::21)
 by CH4PR10MB8124.namprd10.prod.outlook.com (2603:10b6:610:23a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:31:02 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2d1:cafe::10) by PH8PR22CA0023.outlook.office365.com
 (2603:10b6:510:2d1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:30:59 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUMeM1655294;
 Tue, 21 Jul 2026 10:30:22 -0500
Date: Tue, 21 Jul 2026 10:30:18 -0500
Subject: [PATCH v2 03/11] soc: add data to identify the am62lx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-am62lx-v2-3-33ff580c267d@ti.com>
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
In-Reply-To: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
To: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent
 (TI.com)" <kory.maincent@bootlin.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Daniel Golle <daniel@makrotopia.org>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|CH4PR10MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8cbbad-8c67-4e06-db82-08dee73d10af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|23010399003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5Yi04vNZ86Ihpr90K/xoFm25qGcwd24PvtJZip2PByvYMKdWGkos/9urM0mL5WDKZdYBak+ydn2sTLAY4LJ9zEvHoUGE9lX6gWQSN3CKJUPApYICyCUHbg/FXY+c/GCgKjLubyes+RdmxyJzkQOLwyHaVeD+oe9fM/HNHKTzFaQ9Dq1OrYD9icMmA71h8qX+tp2ag23jGPJrveRfBx7hu29XhyhKJEGLZEknRs0JrlXJZ2fDAldh7lQ2gkYwfReCdBAkXfTOfl7n7J70Rnj2LQA4hLnUFyAF9JOeYUuvH/mKM7JY0vJ37dk8HqBt+Jdc/wQi7XOiiNmmVeSAHXerR3lTfmpywoQHU/J2d8oQ/XJKryb+mLtqUb0NrKJuWVZNOU6zomEkbOvJdumFr1WtxuKkKnkeJc/ZZcVtwmmYX4/SJCDFSdyF3N9/ihTiljqb4bwf5/kvi1qxwKFXdC/aMe/nnDx4IdWSNFsjbZK77OnK7d1bBUXO1hceVFc0eKZ7f6n7TJa3a2HBFilHnvEUFHDobrfp5z7It6gaA7l/8kgjLDAb665IY+tbUGEixJurXFi3N03pk+ggWiVW3VaUzqoapqXr8J6d6KLtW4ts7dhLzm5XihtQQzsNbEW7Z/ARsioVVEDIpCamR0I2krBSTJq5q+7LESvVkw9cxQeB/PKDIqecN21yxdVLR8vT3ioWDvtW6kmusTAtp31ByqtcgQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WyXdhgiPO9eIAWKPTLb/yazK77M6rHUcCbgoeoDXuf4REjD+6au8BSwYDtRYc5a3XeIGZxrM3tPTvAkEeAvpgHWuWP6gBIibGVtN1Fo2UDrnWwmma5w0kfk33+J7nwrWdKC1OOAzioSEQaARHIx1UiH/mbJnlgMfCJB259NWQtEJZS/RB6E1p5OzUvp3O5up1bJbNWXAxd6Slb+robmmsKZlBaLttrtvVS15xVFEfVTtqcznhhOhUsvSL5Xfpa0hyKtMmLtcwk3DN8aHDafjyGS2zQAc/cz7GTqPIh4FSHRQ6jrnLLWDnQWbtEv/sjua8SXc+8mnX6ZFLVwBjan5spV6zuJeHjGHHD/kVwc3hPcd0Fi80LkZYVrkIOZg0vTvjtAtxXIRi7JhnlaZyjfd6wb01s3A1lDDX9+rj1CahaRvbiP0alVUdyJazQd23FtC
X-Exchange-RoutingPolicyChecked: UrY750U5a+neC2sJIOwAtu45Ot/Qc34OvtbQo5le84sbwjsAHFuYuFkZirHKpMua6srjG+4Vrl2psXRsdn5S1OmathcPMbouIHLuEqaUnAqVqqtW9c8miN5gAuoEPtjYsBi9rTQ+zpLKihiJik3Fkw0JJpd/ZyfpJTXPqnyBb1p6u64KflvfNapGv0ZnrP5cID8E3ZMHQruNhnMj+UnQAgPtO1WvlTW2AeUJpxrLrvhGm0xPm5LYRHxOhDdLyPtC1/NuZi3XfJRwerIm1s6BEIiQBwDvcza6aRTHJ2zR5pon+IIyybgYr55qcIoBs9R4cYjwR7vPH+4KdBOJvZZ/pw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:30:59.1436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8cbbad-8c67-4e06-db82-08dee73d10af
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8124
X-Proofpoint-GUID: XF_-TKReR0Zi_81U8qGRuzL7xbN_txTE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX3x+1grmh9O2V
 OJkiJHlNcQtsYc1wjKD+AjQPDDMVpmwyHHUvfxrOJkRSk73Juo0UsWZEIgRHxuLZ3IIbpGUddVk
 r/HfYMzUbefoJGiEn6EFoRlGjTPSHgo=
X-Authority-Analysis: v=2.4 cv=CsmPtH4D c=1 sm=1 tr=0 ts=6a5f90bc cx=c_pps
 a=wcVwjJSTJ+Ev3TLsT0vURw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=CgQoTPMYTAfA8Ut1j2AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XF_-TKReR0Zi_81U8qGRuzL7xbN_txTE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfXy3EzmkeS7OTJ
 f2521I7wYE8/aHTQGEuJeduz/WyzFd+7IJKXCdIuCDx3fpep/BdM+pgMcLm09Ai0xhuaLT/KkdH
 Ue2dsBUEQ8OUSBJZoY2RVIgLek91yeuTvrKegd5E7UJl3zZnBEHGKbiJp3nnQhnnKEd1bEc8m6L
 nwCJuq6Id8hWTTcHV73i60c4KyFYkCH+czsin7Y36ksifN1G0ItdsY3UR6weyxjRGqgANZlxJFd
 GHtyZh7RwK8qUi8tU8DjbgaK+rmCorgAPYA1wwN2mg5pt1n9a9/+TaIHH+IFlY6T3OTBb17SfhC
 GQXKOxt7P5dm9KsxczeTu7Ceo6Ldjs9MRYPrbN7xdctwgZOtm+e2wPPumL0h4KwZQCfNgxnsRLc
 +lMQKi896fmeyJs4poccbaPyzDylaBgAauJhrFSRH8s8gWdiiE2GJmIwb+RL3piAjcrD79fjJta
 GNqQYrYxYSWcKuNOVSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210164
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=X8/RliubH5aInu3ytR0ECGMek6ri/wDbcJf6DEZVk
 Qc=; b=OeQMLeNGB8j3rikOlpFti64a7g4/Mjfh/ecfOG8vYOqni83LRMBN998ad
 AtfDkbYYYJ01weAdcd7Uvlnp5WB9xH58Q0BaA8lI6Ab1tOGeRq6NeQ/7oTMBKCjX
 l7wtN1etFx+v3wnw1xm9MKMAUELx2wzyTDHzitzmsbKvdLmuqgfgCg81rDC5oubV
 gGkW6jlR/7bTVo6vb4m3vnc9V+Tox+Z8Gc+ZGtO0/48p2yyZjZFbwtGvGh6PbWyQ
 Ax8X2B84hC7JpeULfY/oaDEkWeRrX5UAwO7eJemlzVXC5bu+bsd9pg/UbaCh9t6P
 iKokkgDyksAMb9TP9Ft3TUyxRYc4A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8/RliubH5aInu3ytR0ECGMek6ri/wDbcJf6DEZVkQc=;
 b=edxd9MEuTlvRez4pcBYxWzD2VSYh7qFllN7XMthIMW39hwPZmlUig3qUJZEMJ3fG5TtOEQn72yPI1NA9Ath4y9vV0MuAMWLMFMtDhPQ2dyDrshjLp43LH/0qPBRsdHwtEamLr46Xcq4vi9ADhCkgNZ3C3X4beSiEJfgSYSd4GcM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=OeQMLeNG; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=edxd9MEu
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
From: Bryan Brattlof via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Bryan Brattlof <bb@ti.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

include the part number for TI's am62lx family of SoCs so we can
properly identify it during boot

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/include/mach/hardware.h |  2 ++
 drivers/soc/soc_ti_k3.c                  | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 2c771a1195f5..6b86f6ed12e6 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -56,6 +56,7 @@
 #define JTAG_ID_PARTNO_SHIFT	12
 #define JTAG_ID_PARTNO_MASK	(0xffff << 12)
 #define JTAG_ID_PARTNO_AM62AX   0xbb8d
+#define JTAG_ID_PARTNO_AM62LX	0xbba7
 #define JTAG_ID_PARTNO_AM62PX	0xbb9d
 #define JTAG_ID_PARTNO_AM62X	0xbb7e
 #define JTAG_ID_PARTNO_AM64X	0xbb38
@@ -81,6 +82,7 @@ static inline bool soc_is_##id(void) \
 }
 K3_SOC_ID(am62x, AM62X)
 K3_SOC_ID(am62ax, AM62AX)
+K3_SOC_ID(am62lx, AM62LX)
 K3_SOC_ID(am62px, AM62PX)
 K3_SOC_ID(am64x, AM64X)
 K3_SOC_ID(am65x, AM65X)
diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index b34cbd08e073..6ffd88f22c09 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -36,6 +36,9 @@ static const char *get_family_string(u32 idreg)
 	case JTAG_ID_PARTNO_AM62PX:
 		family = "AM62PX";
 		break;
+	case JTAG_ID_PARTNO_AM62LX:
+		family = "AM62LX";
+		break;
 	case JTAG_ID_PARTNO_AM64X:
 		family = "AM64X";
 		break;
@@ -72,6 +75,10 @@ static const char *get_family_string(u32 idreg)
 	return family;
 }
 
+static char *am62lx_rev_string_map[] = {
+	"1.0", "1.1",
+};
+
 static char *j721e_rev_string_map[] = {
 	"1.0", "1.1", "2.0",
 };
@@ -89,6 +96,10 @@ static const char *get_rev_string(u32 idreg)
 	soc = (idreg & JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT;
 
 	switch (soc) {
+	case JTAG_ID_PARTNO_AM62LX:
+		if (rev >= ARRAY_SIZE(am62lx_rev_string_map))
+			goto bail;
+		return am62lx_rev_string_map[rev];
 	case JTAG_ID_PARTNO_J721E:
 		if (rev >= ARRAY_SIZE(j721e_rev_string_map))
 			goto bail;

-- 
2.54.0

