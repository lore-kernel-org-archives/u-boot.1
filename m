Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8952AC54F51
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 05:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3329860805;
	Tue, 28 Jul 2026 05:25:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RCJOtrc8RtHE; Tue, 28 Jul 2026 05:25:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A3E7607FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785216352;
	bh=tyfEs8Qff8cJZ27RUACj3K1PaZs9CSK2nAxPq+1Aj5U=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PQTxu0ianYSHkt/3/h8CyonnSijeVK5E24kOSJiZtGbIakGjFjsW2lT//bRsXEXPG
	 Nq8hx6CEdaHdqnmo2uvH6D7GGS05/2Tb71M/1tt7sFzdHMMS6MVA6wiR0CualC17Hg
	 fnGESI3dR5MC39QKnlb3Wp/dDO6naQuDXmdQchFk/owK8LK6G10g3922D0LkXZzXL2
	 Dh5qaHNt33+4K86JRxUZ4Zqp587v0cjLzCTN5dXkM8oAuBy+aWMc6nd6vNVFwj3LAV
	 0o76DQohVtoK9vOeSd1hb0EEDIfG4CkDHx3MdR4wrH0dlYbvFJukvsMwtcyBuZiXI0
	 uJGc53kOOBY1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A3E7607FE;
	Tue, 28 Jul 2026 05:25:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E265123F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C015A40859
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:25:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HdTTgxty4R5H for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 05:25:50 +0000 (UTC)
X-Greylist: delayed 500 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 28 Jul 2026 05:25:49 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C434B40855
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C434B40855
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C434B40855
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:25:49 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66S4Dr7H2742051;
 Tue, 28 Jul 2026 00:17:27 -0500
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011045.outbound.protection.outlook.com
 [40.93.194.45])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fpn6sr8ty-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 00:17:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNbnd8pZwOgonyPBKSWoIUTBuWuNSNh7VFHF1PEXXnWwnhnWLwmyOQMuSuIt7EZmuyyo+oY2KWTIs40YEWbieveGKD2g3NUMmrougHz/f17B39Dp9o4yZQOq73bZDR2tKMX1SGtLQRPjYvDezxxhEo/TbsAMAZHy6FTk4igFeRtvAftIGct+tNsFweZvuCVBT5V5+UP8UJOkPfpdgMVnIVTVg6pA2nFt8HZrxwj0OPiK9ZbAa47puC3/6ths59MmULPhegz3gEVUiJtoH4NveJzDMCVpxV+53NBbzh1DIw+m2gzQ+6/spRP1jDUfPVtgO4fZvurJcgF28w4O6NtBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyfEs8Qff8cJZ27RUACj3K1PaZs9CSK2nAxPq+1Aj5U=;
 b=le+dvB3YS2+9+cyQFuNfNO8lb2+YXH3VHpeLP7nesmCsRBdPaSMmgdIIcWbbnW1KV/0fEc3BoEqTWV5L1k/RU2t++SFL7TXZEggiIwm9ZgHqzutIIe+Qy9HObtexoZWXR8wyAu3/sOyzYPSvtDQ2RTA22WPhQCVtriDavkVgd9Eij6yTcWAB9RNTJH9Ik+qauNjb1fgmxENDwcV68sD9QGmDc+gUGLBKvGebuM36wLs3SAQ1ngnXE2rMmRHLwp++6vWqK7YE+3qHsuOBDi2yK0WiIy5k88wAarS0m+j0Y0tv4Y31AHikvCD04cqtMRLCtUAB+VpkJw9zcdEEapFNCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=prevas.dk smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 05:17:25 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::54) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 05:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:17:25 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 00:17:24 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 00:17:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 00:17:24 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66S5HNG81969580;
 Tue, 28 Jul 2026 00:17:24 -0500
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH 0/2] Fix negation on modern hush shell
Date: Tue, 28 Jul 2026 10:47:17 +0530
Message-ID: <20260728-negation_fix-v1-0-c8021b2b74c0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw5AMBBFf0VmrUnVM35FRNApY1HSIhLpvxssz
 8095waPjtBDHd3g8CRPq2VI4gjGubcTCtLMoKQqZJlkwuLU73zqDF1CGZOnVVkorVNgZXPI85d
 r2p/9MSw47m8DQngALhZA2XAAAAA=
X-Change-ID: 20260714-negation_fix-2ff538762dd3
To: <u-boot@lists.u-boot-project.org>
CC: Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>, "Anshul
 Dalal" <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785215843; l=600;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=wkaUgZi87McFEIL9/VXUP0uxQF4K0/0Jw5IsninpM/M=;
 b=fKTC4BqF3TSGFhWJt7/SgsBdfQLQSkPFA77ksdzQOV6DvTQmTBOY4m/qlbktCHGZ1QcW/jWWU
 p5M0gks4kQvBTnCs+VeYj/APHz6algGxeRvTTA36FqvJ8R6Af9Ysess
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|CH2PR10MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b85845e-92b5-4600-1994-08deec6782db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: pxuP5gSsjUDZnPebuMa7DHtND5RWRw6YSt+qsPABW88BZKdDWSS2ltFPLCp5ZGmysxg0jHMzcV+b4SqVjogV8+/WS65KzhvOOCpdUDE+lTt4+963UJLQfyhkjoLfYn0n1YoUnoi2ZyH1WlXDyceb9Yx0uNkDqSVpeer6BX/kgu1Ry4NSH5jej9grLqgPXDpW6ZK9kUAazZ+cBXUw7Yu2N4LNBwH2P28ksLPFeLOzB2Zg3oSgEZ0XMfgW0Thy0X8dhBvsO3TFgPz2eWShOgnVeO8zkXjMOY2Dz7/+zGxu/GzHStMq2bl+AYToeq/2GsG5z508YKrelM0rzdTndOhMuzEb/ChxcAeqjPUMcS+d7QyzO58i/95U4XYUiFG29gB01Tm1+Ju7eFvjESq30icAHHxqjw9cu8vsolq3peEFw4ozrYGdbmpWXtrXMB9wY/Yb+3NDcHIp221bIP4kHNINiWSeriX32TSLR7suWp5fYftRL47QBoYPk7FPuwiReTwgu6sJhfzwDhh11y8e0VrnE5X32OTq4pplhHiGGQJ3j+AzJ2bH2OcQRh4fq/yNiGkUul/TqUqGENvO32Q8gvbwcvtFQXxxU9CXq2N1WT8aRvsHkSc1hF4v1+3hNORXe5KuVzeayQB702JBNMqB+J5TBZVi2dioam4wcQRFAygVe7IajmYFyhsy2EulQsgMLojuGGT9hnIWR1AHvcBgMRrzhQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LYQ7nXysxPs4Zdq1mXYwvP65llYWnTRCVJEuVJZtnce1BIKLif/0L3V26Uwjn6DJshmU24BieXLNyru32Sk2Cl6r6SqGjXh3OP/MqJ0JjQjL1/ZdtM94swdmNDPPnJ01ga6xxXkDn639aDZxPhw/RH5vTzg08mDzRNYK6qIRplq+OpboIA6zQPqRkrfLdyL0F93eBq3uK+crxBWFwBtoOGsJZvH5HtEOHiMhrVNl9WpGLXKrrGiGQyYz0kNwPPbBXAqtVfIN6BYq4QDb+IX/aifrnrhxebm13Ag57goH204ZE0RVrhF/VmWsvtbkQZzONoaQywFtANPQIiT+YK/c2fWK7prblkvtYzghiRz2zTW2Bdjl2aRREygxuFd5TncwnLSeUTrJ0ff7428dAss7qLvQ+nJJOUlWFpS4/3tuBxHuzU9UGx8SEOfEr5Ts2C8D
X-Exchange-RoutingPolicyChecked: pAmGo9qdM4v9f4H5I5d+n0QdPQ+ysgaQCZQIYacyFhnjZmQtZy/jbIsBiXL4ok1YpWgkSCTkqkPp3nyb+b8UR6fglBcgIW0ehCdpRn6KE8S/ZZs+PwvxZQFYeJKzlvJ62vH5XTDZXQBKBi/bEl2acPxA1Y0IR0Y+nNKgqvWTi6HuZcfkYdJg2uyW0uwAazj9EC1vlQg70A77q0hKhjE4bfgRhhqjDJ2PsrkcZt9yVj74+LaW5brS/URznjle3c7GYFpcYHoR1EO3e/BDK9hPN1rx4mfLFTE9IGqFW6Znfa8jIvTbnKkcTU9y20I80QwSWf27p0z8VYi/WC+RzH5LEg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:17:25.3062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b85845e-92b5-4600-1994-08deec6782db
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0NSBTYWx0ZWRfX8kT3fVPeZU68
 9p7OA0N4ykqqNseKwLl6aJvgHyrZTxE2iGQdAg9zcUP3TdOc96F1r8lNVoCjGE9xQ7DWOom1+0b
 vHsow7RLjx2voAUZ1VT5c6bDluAxqtZ5j1IfgJxebIR0Qe6De0N8LILJTtL55Z8h3ttEF8yQB8x
 3HYSZx672tPuPpJe5WbDD/gZEM8QCUogFQIskq2Q5cCOWvfykFbKvSRymZj0qfCnovC+qSVW64N
 vlA+F+lUW0R+D3UDKdwTa036wDN8b/3M4rXEwd4eElg1GNDTFOTOqNqDvbnjMzEQLcaDLH3vsez
 rMjDvmg/L5giF4rrTEv77st4XnmABBxSwHnCE/XX52oWmafX4NUevoUn4/sCwzOqbKdRpUImppq
 S5NkF+/cZSZtvxbaUaH4wijIGyE/UwMpphQ/7uXtTik4pHoj4mfZ/MJ1r8zQyPlCE/UiimOyenO
 8oC7fSKzZq7xRD7WfaA==
X-Proofpoint-ORIG-GUID: iLxNOqXNqB6SIUnCP3VFa08UFgxzGUuZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0NSBTYWx0ZWRfXyFUDTfk6p/5K
 /GmwQiqa2KVEXmzCOQY3W6VgFhsrmyRD4+c133nq8Ae2vewmtU8UVJ2cxp8ixybCB9tkEkI37Ty
 TrCsDy0FMalj9MsPilH8GfVcHC7NgtM=
X-Proofpoint-GUID: iLxNOqXNqB6SIUnCP3VFa08UFgxzGUuZ
X-Authority-Analysis: v=2.4 cv=dvnrzVg4 c=1 sm=1 tr=0 ts=6a683b67 cx=c_pps
 a=z/rjtr9/JqYX5j7IdmSYkQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=jablCpf-1CLvJuYehNkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280045
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=tyfEs8Qff8cJZ
 27RUACj3K1PaZs9CSK2nAxPq+1Aj5U=; b=KlSQKgt8EqB3xq4wOvIiq1gzpSCvU
 r6pdu25laaqew56Y6FAkfoIiETLg7UgcPsMGPnPieXT6UqGkkchMNMRk7hAQTQTp
 GqP+J5K5xrhmJxr0spRjcRrRXXrNzOhheBK724yOeG1Bzs5g5SQF3NnPC/1ghP8F
 URzOO/0klLdl1vEl/Zn6KuOUnCNjx/+yxjNs2ayFMJSMQBx1aux5WYRI/TMQ7Qcn
 FxjYf6cER4rCxSWQR0ARz4kFoHqzLM7ZJXxbo71bdKnQgb46swAUjaJCx6kXHZrP
 2XAOJP9WSEbcKRwVYc/bwW/9VGd/uBs8xAmjkRxc9jw2RfRxHun7Fy5Gg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyfEs8Qff8cJZ27RUACj3K1PaZs9CSK2nAxPq+1Aj5U=;
 b=feDGujeh7QsSgo4IE9l1qultJHLzp79OuDh4NwTlPqesHN5zSnLl41FWSivQjPl73e5+w2LGeLBIv0Zk1a9ggqWYmnpmi15ofniDKJ++hXPP75Q3ggf189pXZ5I7RorilSCLfC7+DgYXTQ2UqTexQ1vmUL3gWHV6K5RqbqSAlWw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=KlSQKgt8; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=feDGujeh
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

This patch series fixes the negation on modern hush shell and adds a
sandbox test for the same.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Anshul Dalal (2):
      cli: hush_modern: fix negation during run_pipe
      test: hush: Test hush negation

 common/cli_hush_upstream.c |  1 +
 test/hush/Makefile         |  3 +++
 test/hush/modern.c         | 30 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
---
base-commit: 5c215cb75c3723cbf77c36cbac3e60b001721c79
change-id: 20260714-negation_fix-2ff538762dd3

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

