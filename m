Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A88C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E19B2606EB;
	Tue,  4 Aug 2026 00:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cv2OZgEgJf5B; Tue,  4 Aug 2026 00:10:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A381606E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802209;
	bh=KlTuNbEzLQJvlyPBx6q3P3HVTMB7S0NOzYH498lO9qE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cpn1Q3FGO4xhPLIJzuKdNGyHqqFMg4gUMoq+egcKMrAfiEZrxfS1hD5HJrVQ5NM0N
	 IzeixMWxqsheeRDUoKcn8J05NQqHHEs1orRmA/tY4ug4UEGdVW41d1LACcqphq/T8e
	 vmOZ5yfZfimeVdNS+sebhW701HDtZxQkYyle3LLgRPHXLGEYBvCmb3PyRUW2gxXcO4
	 rk+eH/m94bgyTib6euZo49P8vWNa2Cj5t1hdJDfKnBtA2SYq5+cxJ0Ouk6VErzJ2Bs
	 WgcRCGNPswN7SR/pgmQSc3gXtGIaQ8foJHkWHNB9F+J2J8GFpg93YX1JAkD+3xi9CS
	 0VqxniCV7ZkVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A381606E8;
	Tue,  4 Aug 2026 00:10:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 929D9282
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8430E4065C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PO0aPlCJ3OzL for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:10:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B33DD4065B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B33DD4065B
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B33DD4065B
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:04 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673JjBYx438759; Mon, 3 Aug 2026 19:10:00 -0500
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ftt0rdb7x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:10:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4m4t43MWiGdwG8wEHSNwgXYGEJY3sZljIM8n0aRBzJ/jk93EFVRomochvC+nSiRamoNwLUytyS0KCcQKFYrhJSmgcvE4gbEHL375dZvChNl5jsUk1VEc0P/dpF6Lv1aH2DS6IF+MizNsILP5WEHe4oofaY5ma9YWejN8emAkaoexRSawpbNGwaLN3gvvqr/PjwxagaTKbWjwvZ9DjwRZmDmalKJ5X326Rs6AZxUe+Zul2kevtyq1E66Z5zNBUnuRXIF+SzXjscaAiR5+XFkqO30CCLFPJ9geH1vO1fdSnIYAQCL6kEer2aV0fUdcO1dWQc+zoA3mIkLQywQLk4hTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlTuNbEzLQJvlyPBx6q3P3HVTMB7S0NOzYH498lO9qE=;
 b=yzMhkMWZLYRwqBmKm9IxFQcJd5W8QmWxs3CwoUgT7nI6ExTTcXPnJuejt8Ew/jM4GFFDX1mW9/Jwnjt//EH1wN+NGhu+bfQZPZ4CRejH/1ZCGVmxrMLbo9iXPqe3gqZ2oRstc868BL6+kL4mTyBGca9NSUSKceX977mNZE3jPapZmMeOa5AAkwkaxwx3v4KhZpRa316cmmSWIPuap3Y9MfrYm8vgURerQDZUvGYUbxdm9SdaDNkmbiyAowA6MbNYwWPO8JLp4MRg+gUs8KFdwJfzuJEbAhtILpDvILEAmGCpTgiPRQgdz9fTXZJX2uh9w+v17byhGydm9cl6kTINZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from CY5P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ed::11)
 by SN7PR10MB6473.namprd10.prod.outlook.com (2603:10b6:806:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 00:09:56 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:ed:cafe::55) by CY5P220CA0007.outlook.office365.com
 (2603:10b6:930:ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 00:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:09:55 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:51 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:51 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409p6r3381230;
 Mon, 3 Aug 2026 19:09:51 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 3 Aug 2026 19:09:34 -0500
Subject: [PATCH v3 09/11] doc: ti: k3: fix pygments warning parsing device-tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-am62lx-v3-9-b4f4302b09b4@ti.com>
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=bb@ti.com;
 h=from:subject:message-id; bh=t65kn2uWnMaPQck0qGEPppvLBepbIryGnoL0ATLJATs=;
 b=owNCWmg5MUFZJlNZ3o3BJAAAZf///3/tZ//jmf/Xfq36+t3z4H+r77z/6E/f7P9+v/9P5n2wA
 RsYkPUBoAD1GgAPUGgAHqaAaAAANAA0AAAA0DRoBoNDQDTQ9Q9IG1PRHqNk01DoAaBoA0DI0AAa
 NDQDQGmQ9QyAGgPUYQAaAHqDaI9QA02oD1AA0GRp6jygA6DJkyaZA0DRoMjINNGgxGjJoBoDIMg
 DJo0aDTIMRoANMgBo0AGEMJkaDQAAzQLfDVgYHf84ITOQPrCBJjxGhKXX7mwfIH/cSHAZkONaAH
 D3lZ2obqUklG+D150JyDIyUJpUdL6iAwSuepc4mBZVDf69QBvFypClUlBzw5gE2rPhp4xQj/V4V
 MLRgMeYNbma4wEpdihMSVhkRJ34Yr7gFdYSpWZfwZULjoLcQqCX6XIzvZYsfmFvvmkCTaKTTGvN
 HejbZRBDBpU/doE/zL08eAlo8sRqz0VWw67IqXSHpIfpx2Gbh3kxuj7Yp7xQzpCYRnVJutw/rg6
 KT0mj+S1p8BGbNkRylyRHMsQRcBEwCgP5BQDILspeUsGSBeiQU+6rUZar7+ONhDCCe2pWSP9HCD
 rv6per8BjPOaAGvVk8pHAT7ivo/Vq1QhXvy8B0xUvgTTWJpK8wRiKWBlPZmLXFVh4sucMQGAB1F
 erSqYT2Qjbv+LuSKcKEhvRuCSA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SN7PR10MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 011634de-2523-435f-ccc9-08def1bcb6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|36860700016|1800799024|82310400026|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I2ANRQ8DJRMP18K8KuATxRXesP5aidThH7QjSiBpXlni0kv6u+ZL4nc8opFgltC4dTrlg4QvudtiUmaiZnqg79vCcpBg+YnXreAYQpl//k8oWUbB74enpH7am/vVarY35xq34oLR3TWS1OGPkmY/o766B+GfCiI5xsKxCT7g+IJSLlX7o/SlKmXxoJL340xJqUSMP3tVUYLt6Q6d46Lc7hzRrzA44bI+gt5ORGzMfZvZ85zZeW6pfl8iQrsOLW+1gEicHmQhhTybUcuS0Hh/w4IQ9QgxOvzyY0oITJdhSU7r7XSczKOQHC/483gacgYk+Q9g9esC/s9oUT9cTC4hPvjejfwZXebMYjtitLmY9fOEzm/7Tf6oytSLTTVnPcEUu73OH7zOLcrbPlB4xBDW8MVR5B/rcJdfr0LB7uMrrwBnXB5Aj1TM0Sbs14nai1aS/RGqgGO3QLoYWPb2A2AI+a+9iaFOEEEZS08W7GGRFfcgQEHoFqKAqPniYtFETEHMTH30IqWarErW0CH1rhEXNtVxiOkrCwr5FWIL/2YpwtR/f1ff4atun+SxfOzhAfzcHDgRgDJ+djdURMBXu6Cl+cwJ2eKd7alEX8sgswCqtt/C0+HHcstEf7jpIltghrBClwsifpRE9iQ2gUN+ajQJbm4IYVRz6VIYIiTVNh6DW5jvQllIfgRfUWDd/Ip36s/PohVRjvwCXTJiism8xtUxWA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VN8YZb29SFVVEXB3ve+Dc6Q2HloG8861G/bfMNsBQnFT0nFZzU2JrQY+58b+sHnybd7ePu2tR3OlY1MequzA2VsfbV5AGvCRvAOC5A5p2RVnZFyBtkodKtBXFCqRLFHEjiQVBggTJmohGJxre4FEFA6uMVrxkkoMWv5xW+5cSmn7h2W8GCV7Sxvuc5BNI+NIJpUsps6JA3FoypcGpy9MrkjjtazjlFB3HE+fIs938fvYtFvEHGXIB/3TviSoRrbbUe84G74sXH1jgtdkJOzLStvBWaeqa6/Bk0+err83yQtakeDCR2MOt/RAaimc3BtDKtiWrvSrNWSDrnPQyWdrLV/wTlptihHJbxso8liFdC+nwqiEGVnOXoarsJ04PCiHBGsCVd2vSndOcDtxjil7ehGmZeDVEXPNRfpNKzDpYLcgyFgYHL919hGtzp3H7ir2
X-Exchange-RoutingPolicyChecked: jwqVP5huudaFFBFm4R719nbubAqsezV3Uk67haMoJW/3u2EJVncOod6LT+TRL7xHgq2ysI9rZnWAbwZK+jJOfMUxAOMtuGw68f6VOoS7lY+ZdFxhq6ANeBO4YkEF9IhGWv8E2VBSkEzyZjjOCvUTpvtwAimxwOP/pcKcytJKL3B5VU6M+nANL3NYEwXRzbyYIy1DoKU16YfUeaCvPL/oiAUCpWUfsXCk0HM81LtCeOvSbC8R4EKPEQHMiFXPk8jnoL+JXLvVXJG8OANZWmsWM44qIUu9HZ/gl/VHm9OYnYKNKk57GqYFwUxcI6IBBMHOkkhCxR4DGmLStwreuh0oTQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:09:55.7742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011634de-2523-435f-ccc9-08def1bcb6f1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6473
X-Proofpoint-GUID: uLrm8JGpJNqZkBlD2ePsxL35jHnhbjov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX2rwZq7A7FmzV
 01u5sgFx+VZ6CPKmRkqZNZ0hIhognIBX8xcI7bhYuQUhZNmooTyonhlHZMZbINLpSTq2ioe+sm5
 lS2doan1hF7sZ1vrOm1HYtYQ7jaKuoh0rQuG/YyKQnszQ6JltLjNSRMdIYO3F/b9PZMJcgbAHjd
 GUGD90QzvI054xOP7ToL1f4GsNHjSSVAKiQTq4fars3J0CNWuspM4potBY0D85NjTOTzhMr8glP
 kGVqRrfDpGl24Ld4Ey4rT00+yDtjh0QynvUY/fcy9loqBXmUPJAexpcLrF9VdnOikOolarQQzRS
 cAYB9zPPCrRoy4JdOpdVXcVpUxqBHmk+VqR1SArThGQ85JPiHpPBUO6uor/oLVrjBelsGF/jQsd
 aBM1z5i2Zie6tf2AquQUS7S3hU0ivfnl38HQEa4w5hI68IibB7XmD3YpIPFCyYdM6J8jXqVnK6B
 XfETLLtKOsneJjABgjw==
X-Proofpoint-ORIG-GUID: uLrm8JGpJNqZkBlD2ePsxL35jHnhbjov
X-Authority-Analysis: v=2.4 cv=eOUjSnp1 c=1 sm=1 tr=0 ts=6a712dd8 cx=c_pps
 a=04So32024hOmtaefayDOVw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=BavfKqRvrzg0Ny7GcN4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfXyPSznBRSu+OG
 PgeYetVrCg5o45RhmovDW8IsHfAP+KmMOw7UB3b/xpfziHBiakZ/475hZ2ureOqRlRR6Sz8meRq
 BFJ3NI+jJ3jt8D42vqvCwHB2MQ6yAPA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=KlTuNbEzLQJvlyPBx6q3P3HVTMB7S0NOzYH498lO9
 qE=; b=ZcmIqNOtxDUhvlYcXyadnXuIG1UibmihzVA6YZemFcR1LjLVkctdpzcYz
 4OTp2+1NvMXuuWin0qDGlJArL6TRTL0fDVWvvdn9Ko+r1ibqwjA1heVn0bpWpBGv
 hLEjK6PrFuYg92BfeoU+gJYODiNa6iqCud8Qt02Aok95CNSdttUPjExxkTiQ3rCW
 DBuklbPTw5JSkyhmaLdJs97gJN7E1ZYdPw3+QzRbsbbOdNFBz2ULkR1J8/X8mKz3
 6UGuILWvr50sKnVbUMBfOL4yBrMGh6Rp+lrQwwSqcfRjlu+4JhyMAx6XAxpzr6aA
 QQD6hTeVm40l+Z+SBRsFyBbXhM2MA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlTuNbEzLQJvlyPBx6q3P3HVTMB7S0NOzYH498lO9qE=;
 b=J6Ab+Noh5h8LzY9ESRA53crAk6HciVJnY0ygC8b5NLnOn3ITmLASs5ZA707AGbgVuKiRaYttHw3MJvV4OTkRbX/DxhmJbdoQ89g01mbFdsZjyscNxyIZ3szukd6+Q+pIZh/n2h3PKVzgNndF2msJV2jgNBykAjzaynyM7FVcIwQ=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ZcmIqNOt; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=J6Ab+Noh
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

A warning is emitted when generating the FIT image examples because of
white-space and invalid node names. Fix them

Tested-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 doc/board/ti/k3.rst | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index d3ecaf599094..b7b69949af16 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
 
 .. code-block:: dts
 
-    /dts-v1/;
+   / {
+       description = "FIT Image description";
+       #address-cells = <1>;
 
-    / {
-        description = "FIT Image description";
-        #address-cells = <1>;
+       images {
+           image-1 {};
+           image-2 {};
+           fdt-1 {};
+           fdt-2 {};
+       };
 
-        images {
-            [image-1]
-            [image-2]
-            [fdt-1]
-            [fdt-2]
-        }
-
-        configurations {
-            default = <conf-1>
-            [conf-1: image-1,fdt-1]
-            [conf-2: image-2,fdt-1]
-        }
-    }
+       configurations {
+           default = <conf-1>
+           conf-1 {
+               image = "image-1";
+               fdt = "fdt-1";
+           };
+           conf-2 {
+                image = "image-2";
+                fdt = "fdt-1";
+           };
+       };
+   };
 
 * Sample Images
 

-- 
2.54.0

