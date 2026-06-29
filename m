Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5F8C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 10:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B24849A3;
	Mon, 29 Jun 2026 12:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NpGxv1Cz";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gvO1rCGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35085849EE; Mon, 29 Jun 2026 12:49:54 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB6084994
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 12:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65TASna31833863;
 Mon, 29 Jun 2026 05:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=seQ4EOnJkxAtB
 ZFtSafodm4NByTMRcvpM9OPDEyH5Og=; b=NpGxv1Cza8kx5G/N0i1UvAIOe/nte
 Cx3Yh7airaA6rrEgtuLjILv8JjEcSczQKTjA1qzeT2c4Vr+wU/l/znSC1gQH4/Ne
 QTdgu/tL5TYOubO/Y1RRJi30k3MzPh5pZRwzJ/1YgQhM+PVPunL+42eZ0FZlbo3H
 m2lYtpQnmtyZ7+jfZ7O62cpgxr7zK5erQhhRgUP4gk2uiuisMc52jQMb8ppxpKiv
 2xUiWNUMjgf7ihXxGhM5gYhtosxKqHAeQZkeEhtHBgng/ZpNW9yl/4mrGiSnPtGa
 BgdxZR/iOKsPlBZgXn5OckNfhe8vLr6hXjU8nEUnMk59GZGxFIuzYYDnA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010054.outbound.protection.outlook.com
 [52.101.193.54])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f3p9urc3e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 05:49:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYAGDRPUKklNnAuwOydg8TBGT8plWk1R8+eicvx2YoTJrqzF5gcsbFYLkN1LgnFwP14KIe5ghzK/Fn1Tirxp54NgEIcZLz/YHx/vL2P9/R2hauNKOXsjqtoMbBOirRRjMseQnJlGlxC2MLFK1if3eRqRb/WwygXH+beodE2Es36pjq4fenlG5RjFKSiQf8gmBMCQpr6IbIEGUkVkbVOerQU7eA/Pz5IzmPCr7W5I8SMYJn8GmVS9TOHQVZ/7tKfVUTmGCqkfMASAc4mOCiaTSGclI4uarlVfeal9SuY+aGN8cthBxG1iLW1snv122tmUW/ZQRhMtFrotxtRnCqm2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seQ4EOnJkxAtBZFtSafodm4NByTMRcvpM9OPDEyH5Og=;
 b=cTkKCwE/7WHIUh4u7LSz0hUbRsWVi39g7Rsrwvy50qeDpHGkrzBvD9KjyBoVtIYmy0LAAulWAamNdse90r3ZnmDVTVDjjWJVXXdy8XbZRhthUX6IQ4SPoxtksZ+xylxNBkgOpfdvsrh1Xg4wLswc+6WogWJtKPLeQfH3XH4TISt3dvwXJFyE1zFiQzB5Z5Yjd1H/wu9cDAEagyRT2aq9vCs7lOe4/ALvfAFGedt6aO/RpvpkzgKZIh1K9fTcvtD090L0/kR1T4vTvpyaX4smUU9KG/+Jj5IyjVDRzBFUJeVnGOhRIB7/zS5vLj6EKh65Fcek0TdaZXYYFd7hIpPu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seQ4EOnJkxAtBZFtSafodm4NByTMRcvpM9OPDEyH5Og=;
 b=gvO1rCGtZ4xFmor9hymznB2zhQLZ5oN72+qpzz2bjzg41QFU0VTZSZYDQTy0+j0QAJV79FnNUf811uHgNvMo1jPdR+Ixfc1r9Dx4shTb/19QBm/EycgsbrNkfBZlFlTqvzovUFOBxh93nSwilWxduJf6A/4+vYZOtFvbutR56bY=
Received: from CH3P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::9)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 10:49:43 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::53) by CH3P221CA0007.outlook.office365.com
 (2603:10b6:610:1e7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 10:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 10:49:42 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 05:49:41 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 05:49:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 29 Jun 2026 05:49:41 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65TAneSK3903579;
 Mon, 29 Jun 2026 05:49:41 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Mon, 29 Jun 2026 16:19:31 +0530
Subject: [PATCH] fdt: fix phandles not copying when using templates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-binman_template_phandle_copy_fix-v1-1-196f95a13388@ti.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNUQrCMBAFr1L220CNGqxXkRKSzaorbRqSWCqld
 3fVzxke81YolJkKXJoVMs1ceIoC+10D+HDxToqDMOhWm9boTnmOo4u20pgGV8kmWYWBLE7pbW+
 8qO5kPB6QjudgQDIpk+jfxbX/c3n5J2H9dmHbPqWzH6mEAAAA
X-Change-ID: 20260629-binman_template_phandle_copy_fix-956bc3ce48d6
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Anshul
 Dalal" <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782730180; l=1470;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=1uzHBgtrwAg+qtPe4IH1SLA0siOhog4nhELB5ipQUbI=;
 b=KxRRITYokAKZoYWCKpAwbSAu9U5LfXk9Pmyr7gH5ibOWyU+JWgq10hZFpqlVEywOusJLeIk2Z
 v64REsTJP/fDPqY5lPmaop0qQpGGlsE7ehzN7nQFUHHfM8096PynyFp
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SJ0PR10MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e84c19b-2060-4d0b-89af-08ded5cc2044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: dv95/BKdMFwdbYcTlXRr2NZXiSXSwOn61374CFLKCI36WLk5cVghRgzKm82/Or6u2fiQ1QTR9cCJ9XwM7spBdUNZ6yxyPr6GgXp39k/y8XOFDpi25QUNghf9KqA/IzaLCYFKM8z/P8wXuorsflh6BY717q+WkchmlhaqeCT6fGb+E1n3IW5SZdywX44MCWdZwVKsd0YO8smyQWP8OQH/QqofTy1MiNwgQi3114xVRU29U0AL9kcaxDwGVR2GCHkFHcvvAChmQ/BIetEuld56MXrXlz2kzWPggAzSsTOhnkidiGnKYfEnfZx2/WDCasxU6GbrXlz1aHIhItM8yj+CGeOMFYHGO1j9F9WUtJXHBAyaehKHq6e9xo6AjZEPhxuhY1yFxXIm2ab74Ay70/v/bIuWIF3ljKoyW9nplqwnTzlAaqiGrwyoVDxQIo5dSwZBWVAxRxOWt4NlVSBNf5cJ2iGYlT7Vs8yBh2MhiblLUpN/R3NC1jufZ+FU6bDNNVOfAom5UhfY+dwbYC5GGqNtfTRI4pgbeoaLt2m3DRl2xx51MdhLA9x1R9Gq/iNWm1k0PTXh98IGSNW6no3SCc+cOPj5bta/BrIuZdIU7kXvLaAGiqHxWNiBkPv4DDS1jBCgdtU5tnAN82lEvD23pXIRX3EjQur1uh6sLaxvz8zsTFB+27hqvausTTyYcGO2OK1EzjQiJ8xLeXHsLBdy/kzngw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xenjHYRCC+iAce2H0ll4nX1Giv89gLRY0Co9C2OWnuMXeUNzcFDqZ0QEB6oH8/Uy3gSlP7cKz/DLN35QoQJ8Ot8BGQi0+aZCaqH4uiQHawmsBYUO79Lu7cnRpCN7PXTKNIHU9EnTrmIKLOcd1HecVvr+VkWz2fBqedyxML6RRbXSptIZeSbbRoEQ7Z+SLzYAO0LrIu4isgMUje3hRkAM0LL8jfbk4VMjU50gqTErAonLsAMk9hMzBKWh57uvFE4H/Nht1E9f1Tc3CuAPa6sQahii4vfu5X1U4bY4UuUjINpZWG23EsC5UBXrqmnT0yRyC8NnAdmkt0mYcdJurCE55J7ZL+If+ZAvamZf4NXii8XcNF9G4Z8ty44GDxBqksrCtDh67hB0K8RIHAMeUPP5pg1AnTnQm1F/zCmpoITiPJ1lgjmfqdsZTKQ+/RA04AmN
X-Exchange-RoutingPolicyChecked: L7/xPCPGdlW/FmIgqYDuoY4O66yorGXzd6IL8FrT4QZdVnmqEuDDd7VXChSV3QC2h7im/cak6ZVHxw3qSMxMz05PGadx75OaW/jFyfFLr20CIxHr6CIYjdBzgP4OPiW6+U+N0FLoUMQ5OkTfviQu08pG0TZeXmldPG+/VhCxqawTQ/JLwI1Fgsx7FHyGjOTzZDwf4S6Y+EZOgPBPPrL1caZq6lXNOIKZDGCODDk/wKCCmf+OKJVgTg8oHv9DyRSUJJO0WiGcrLNENcQeY0b/RbTq41My82y4GGZzrASU73P2r2pXUIDYT3gGbiIZ3b+LfJAWu3Uj0f+L6srVjv8hcw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 10:49:42.3636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e84c19b-2060-4d0b-89af-08ded5cc2044
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
X-Authority-Analysis: v=2.4 cv=L7ktheT8 c=1 sm=1 tr=0 ts=6a424dca cx=c_pps
 a=Wb2dZV0zRm8mlnqfvkE3cw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=x6Mza3SfBSiTSbXInFwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -W2pn359of0YPd3WQHJyY_xHxDcDPhaD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4NyBTYWx0ZWRfX4oPAYE1iC4go
 Ar7rvl/RGol3YqK2Opx353fSYAaMV8WhDaJeMhaRO5HUpFYbgDvokHMw/yXt5gcviiWt+2jMdtz
 M8mKqhbQQucDJc39Wonk2lkGgZ56qYToSEZB3ZKaNMyC759mFKmPlmZyK9LvTnkDvn+OhlNQnQs
 LiXh7LCSntRnZBQ1SD4qg/fD7las6/TxDUHMyf3CsgOxa7lQbyYcc4imXoBp2O0omMbydYfPHTv
 /UuBzUP4VPF1ZpYJMR3jSUii4ymRQvaTiVUNqRoqvukmLNE5jxcvok2fYX66wEGbYyAfa86KcbR
 2/X42iwjBYJMaJZsoWiUe1VzAWGJ8kUMvesE1IZK+jujbZkkoQ/hZ07whXiFYLfj7NF6UX8b8MB
 eXlBhnGkc94jlSzHeXeKzMRnrjJgXPLi77cWHoT62c6HANMF4Y6drcROWBRxA4IpKWveoGOMj1s
 tRYJnMleRyUrfJioGTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4NyBTYWx0ZWRfX5sjoKgzOkYAb
 GMRHyXiggEdx3Pus9txvTp/PLlbLibF+8s3Vme8WG13FWL7j98tM8FWPTXVosB7oe2mKFakNpqL
 SmMLzwdPBQiDhyyZgKMlvRPQF/NpT0U=
X-Proofpoint-ORIG-GUID: -W2pn359of0YPd3WQHJyY_xHxDcDPhaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290087
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The phandles used inside a template were not being copied to the node
inserting the template, leading to a missing phandle error.

The following example can be used to reproduce the issue:

&binman {
  some_template: template-0 {
    ti-secure-rom {
      content = <&some_data>;
      keyfile = "some_key";
    };
    some_data: blob-ext {
      optional;
    };
  };
  output-bin {
    insert-template = <&some_template>;
  };
};

With the error 'binman: Node '/binman/output-bin/ti-secure-rom': Cannot
find node for phandle 103' observed.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 tools/dtoc/fdt.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/dtoc/fdt.py b/tools/dtoc/fdt.py
index 991a36b98796..6c3449095194 100644
--- a/tools/dtoc/fdt.py
+++ b/tools/dtoc/fdt.py
@@ -780,7 +780,7 @@ class Node:
             parent = self.GetFdt().LookupPhandle(phandle)
             tout.debug(f'adding template {parent.path} to node {self.path}')
             for node in parent.subnodes.__reversed__():
-                dst = self.copy_node(node)
+                dst = self.copy_node(node, True)
 
             tout.debug(f'merge props from {parent.path} to {self.path}')
             self.merge_props(parent, False)

---
base-commit: 63f6cc8ba618396cb9c0161bb5c6d217604ae1d0
change-id: 20260629-binman_template_phandle_copy_fix-956bc3ce48d6

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

