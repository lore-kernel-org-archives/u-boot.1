Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED640C5AC82
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 08:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B105C40302;
	Mon, 10 Aug 2026 08:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WMxy4mylk3VX; Mon, 10 Aug 2026 08:16:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0AB534046C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786349784;
	bh=0gFpBg37yVLAAVu3Jor62aDxqQGXPDinN/pavwsVRnM=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=arNjnSSQUXOpMxSuEVlJvZOm+6P8ikAgt/6f/UBrizajckZs61Yuex58XKdhB7PP6
	 YOfxnQWq+6rSxqUrpCIU4Q9vTkrM6hUJiCVdhxzP6onDQvCg/nEfNvRy3K9MSHmVoE
	 mZXOyAr9tuuOQH+GSmAV5mWUAcC9PMM4PeQ6e/VpeL2tL5xztbmn5X9086OQFzXOVK
	 LLbkRPXqNqtcMJasVY4sjhgY/uwkGDMdoC9kamK3SIN8bdQzFozkr0dIpdXPCdTbST
	 yxui4sY9+Wi9HrogLtAYQbypBx31hDFAEQMWDdAdsKxXN5OcZs8RO85vFq8PfxeHDY
	 RTr9BLQUJRkLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AB534046C;
	Mon, 10 Aug 2026 08:16:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4958723F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B14940435
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jw154LqWi-Bn for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 08:16:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4120340302
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4120340302
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4120340302
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:16:21 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67A5JW1t2501321;
 Mon, 10 Aug 2026 03:16:19 -0500
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fxpdnd0mg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 03:16:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6qRm3GaH+gKPNrHS8qGJ6DAk+jcH9ij0BM0Qba9r/Atrklm3zeJIjfLr37UjyEnHDkvV/2H5XwmopJaGbULfPMH+Ej5Vmoz8kZipQBwihOpF/L6HetFbTocleE/GZIDuqcvNGrlQr2MrBIwhtobkb9JKrDcZvj+JMf43kqI6tzG7eTvx3SUYw4BMM98ldfopXYFxNE330fbzhy5OWzceX6ESsQVJPsxiEJX0vxxwl4N1I04JK5IaWG/fAn0bdU3aqB8QIL1A0POw6d0VPX1fDhyDT1DAPPrZLyCPOTtPlM0Z87K+k16ZFsI7XAgPEAqn9X9zacpjeHLr9J/QFD9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gFpBg37yVLAAVu3Jor62aDxqQGXPDinN/pavwsVRnM=;
 b=box3Or8zEzrRXVgPM1scAWpY4+9lR++NPm1P/k6uLddtO9+esawZ2DC/8j97k4C7kwuDVkQNhNBhk839V4f17/CE3Eh2jP0eCNLA3dpzcxQioISrdyA6K+X0j5Sl6lTvQKw/LuYlr0XTicDj6p7y1MSNZvnNTItIPchgCLJTq/coBvosGjosvC9plxhxR4epzY+2ZMjz8s4JgMuLTSqIceqKbbpr+y3aeZB3hKEo7zsWEEzSEEcjwHXsShXSTPxxn8LaZxFLc/WI0cQTelobzDzEw6emv2rfSk+D/bY9RuzPeXuaraswhOryLcwm/f2nyk5J6UsTh0WrGrD95eOpHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=renesas.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from PH8PR21CA0008.namprd21.prod.outlook.com (2603:10b6:510:2ce::29)
 by DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:16:16 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::9f) by PH8PR21CA0008.outlook.office365.com
 (2603:10b6:510:2ce::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.1 via Frontend Transport; Mon, 10
 Aug 2026 08:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 08:16:14 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 10 Aug
 2026 03:15:38 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 10 Aug
 2026 03:15:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 10 Aug 2026 03:15:37 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67A8FYUb2047610;
 Mon, 10 Aug 2026 03:15:34 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <dan.carpenter@linaro.org>, <trini@konsulko.com>,
 <u-boot@lists.u-boot-project.org>
CC: <peng.fan@nxp.com>, <alice.guo@nxp.com>, <marek.vasut+renesas@mailbox.org>,
 <ye.li@nxp.com>, <vinh.nguyen.xz@renesas.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] scmi: pinctrl: Rename SCMI_PIN_DEFUALT to SCMI_PIN_DEFAULT
Date: Mon, 10 Aug 2026 13:45:31 +0530
Message-ID: <20260810081531.3673097-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM6PR10MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: ba629cfb-b0be-4665-af4f-08def6b7a513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|56012099006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: wI7rwpBu6FTHx0oQg3gMAUpm2mdHcfe8/f6rPX47NmMsSrSVae3CYgpDNEep7jHlV8kMObyq2YkC38sSVJITP+ECRrrdT+P6+bR6O3LSv/3NOvtjbIrEeGRY+K/8Dprxn8M0wtMiD9zRxLU9lVrJVAkiV4zk0tuoG4iirU5pjdE+zc4WURk8V36JHhnXn5CxDxUbpLWF3y0DwVYyrAgE+WvwwBNYPewL3cOyjIeePgsz8IqtzIfoqHFNUtDns2lJE1QX1uJeldFffgBE4qyaTmsE+WJ+xPsBLPEncNCwEmL3rWABjXUsobb2asHdj5fkqOx6m9S0/d11q6y0wP2qRgaGDM54uXrfbYeKAz8VNb3Pe8n9A9Bs8QhQxqFdGVR3cXeFXq/yY/Lwjc4aYPqp5U+viQeT6ou3isY+IoMAYEJ2y05Fb+k586wC4dr9bocAc7nhGoPC2qqMUEeD+bZzNV1hg2RC5FZ3xXGRCfMB4Q/xRM+b9koQOdn/ae14QkR5ySK+vYjbtMp9gxckISamYGs+6kn+vlIbyDAYzkXS+2uLiKZlRF5XlCNzgFXyqWcc60UFWSIY+Ntw03ZEIceyoCanoXPiMxDz98y5Iqk6J/vWfx2JqLEJJKUkReP0+5S5UxyFh73LRk2HVoJ9tmslyRQ9dxPhvWJdpmx6lnaA3vwBnLRIoly3zMXemV1yd5b6COVJIaSaHFnBf/nWJ0Ptdg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VQgykGr84O+WM4BioCaY+e1xmMtYcqEw8pr2MG/mzZCvhTBRYLCPrbMmTpJhpxYfLtuQTheRt1sWG/F9Ztrt9VO6lZbTHCvt4ufXf28LkTAqNElq9uq1D91elJnxMdoK/ThrVk12pI46JGbxDLueTS2aIF9nBIS1mugOME/sDm2SYCKUyG1tVEU+pyGzzxPyfsRtsfj6wuGI0JUG/+ckFk/Tue3iZZ0IJwqE9dn4MT7dO9tRS2Cyh9zoIjqTlNy0uhi5Y6irv/yyDW/Y6VIR+rJ/TkLTqTLGZExhAPqyak4xSZXxeu1bWQQEnpOQ14L1k2K4E3HcuTvrfQolkJrgzu7OwCQx0zGBah4lidMU+wRBJOf6waY6cUQgAhw6T8U16xDRyex635NPcXx2H2p1t6a466+3cSu0MhOPmvLJ7DpdrKx3Rrsu5tC5KgUkdMNv
X-Exchange-RoutingPolicyChecked: O/mD0LXJOiBg4LIvFhEi+F5YNpTBPsjAUEMQ0tM8Z8NiIAWX0j/SOO7rzPbt9xqihuTeyqocSG2Ctuv/8lPKKt5l4WWi1JvGsa7HYrqq10PbeuWzyQOSLakDWrNBDxQbXi1FR9IfdPaoGwatHGgSI/67jDPtxn4Ozx1nP/+Yz8jaOp9X0xudqPcc9XTUFvVkoKsko4SmDBtG+U8j8r6ou9oIIBW5opzYHiYECNN4msdXCQsXISHIsrAXAi2Xf9SjJ+xLi+zVTRjWUsByhmAg3o4gVIVGR9kWl81QdCPumu9LmGr6CA/EAybD7+39jeeNVCeyYswFzHZrR3VO6ZuzvQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:16:14.1313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba629cfb-b0be-4665-af4f-08def6b7a513
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4363
X-Proofpoint-ORIG-GUID: I1o-Vd6PgymqhVCdHhBlX7rVFmSQeiy_
X-Authority-Analysis: v=2.4 cv=Y/7IdBeN c=1 sm=1 tr=0 ts=6a7988d2 cx=c_pps
 a=g4Zu/129bcKSj1q/f/8ScQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=HUidwhiwrgva0QYy0yAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA3MCBTYWx0ZWRfX7nZcbzViPv8c
 b5y65r+Me7dAg6kSjJoRltKOiDP+0JpFn8LJXosWLGZwpfjBpg3uPx0uX1XcQO7/A/fxN6NXUp9
 /feXuzNDFhJK51VIa/5fsNL+XgBG+CPJVgi9OZ26L/+k43sccZEftkUAOSGnFOjrD06Ip8llbqE
 hVbNDsE3S9qSkEqCgbtvywtxbhPo9DiPCOttNKn32fbhXUfGstv5zf30KMxYrFHV7YK+ThzBnU9
 q6venaXslJQ0XrVlPKJ9X2pgyOKY6IV7jza/kwmicva+qeJHW2KWQA/gd9UQ+AJx+Fz5NEhwykc
 kIXVllqL3I4yn1BIh9nvNOdvtHCPW/T8wW/LaZEfGMtQeDKD6xl+pEUCJKhcBgX4kVjlPc3TsgM
 75zkS1KYDapzXjmnamEp1wcYEdvWtALu6raBPcGOutsAkdNDlg8MwbVTA0QA8q4NF2vmxewEA18
 xyHtcx9F38u2AhqF9IA==
X-Proofpoint-GUID: I1o-Vd6PgymqhVCdHhBlX7rVFmSQeiy_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA3MCBTYWx0ZWRfX+CD+h3cVqSXW
 3BkxtkpKez+B3lfhWvt2D3JFUAaDaFYdXNmUTLkMRMLAOQuO+pQrjyVic477Pj3pb2XsXAtUSCx
 zUlXR7LuAY7b/HWx7xagTk8MoTcq+e4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=0gFpBg37yVLAA
 Vu3Jor62aDxqQGXPDinN/pavwsVRnM=; b=ijIYzYx8gBe9+QCpMdSicjc4J7saG
 9p3MJ3NmCzZfToDPYQ1Hvz/MmpiEXvpB43fpWfE0Exk6KLdi8EDYef6K2dZNIOTp
 Xa5BdkWXHZU0qEH6Y/egfqNdbd4Fh7q3FHl8VgeUdIpxfEbOCIx2dOG1U8QkEfQe
 Sq/00pdmNzo7c7CsAtBkpHcLUWGz8m8rqVFcnwKg0RhBMWhD+csU12a35C0vc9sY
 LNybkEeVZgYAyZXYiA0BFhyA4I3Vw3UTX7GmoWVT/h3bLrzTHfmQj10j0aVEPYRV
 TmGqEiaNSVbZyc3YEuKNxgl6IgB7ZWgTfsC33TQVVLL8u9tHENr8UdfdA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gFpBg37yVLAAVu3Jor62aDxqQGXPDinN/pavwsVRnM=;
 b=CGj7Y4RVaYdGhFW20GfM9F9shRTqLuq7yPnx+itD0fAg/Nrf1A7b1Frjy6NjhZcFn0xcYmK8eDcuqufwvKXlVYGg5Y1xKQX1rQEp92MpHHHJESFsBMNxDsJupHhK1A/D5kXz27VZ8NvwT52GM72sOSwKNLXwu/4QRjkCQb++fec=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ijIYzYx8; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=CGj7Y4RV
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

Fix typo in enum scmi_config_type in include/scmi_protocols.h.

The enum value SCMI_PIN_DEFUALT was misspelled and should be
SCMI_PIN_DEFAULT to match the correct English spelling. This fixes
potential compilation issues and improves code clarity for any code
that references this enum value

Fixes: 0cb160f1b629 ("scmi: pinctrl: add pinctrl driver for SCMI")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 include/scmi_protocols.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index a8fd0a5a729..d6b1df4e206 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1340,7 +1340,7 @@ struct scmi_pinctrl_release_out {
 
 /* SCMI Pinctrl Config Types */
 enum scmi_config_type {
-	SCMI_PIN_DEFUALT = 0,
+	SCMI_PIN_DEFAULT = 0,
 	SCMI_PIN_BIAS_BUS_HOLD = 1,
 	SCMI_PIN_BIAS_DISABLE = 2,
 	SCMI_PIN_BIAS_HIGH_IMPEDANCE = 3,
-- 
2.34.1

