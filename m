Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AC5C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 10:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C651840B5D;
	Wed, 29 Jul 2026 10:38:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhVUklJMVEoB; Wed, 29 Jul 2026 10:38:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73A404094E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785321532;
	bh=auv4j3jkAaUXdCSM6+X4neI+/q+K8f5G4wZqaRxQoNQ=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1L0danKdEmM5B9glaafw9xZLYv/JgSi2n2S7P/XXTZhar2gYidvhaTZCgRhozBDFb
	 kBGTY9KrslnkAIlOdNA0O6Jl0VCZ2umaIp9IZbGHXf1sWAYNU+4DwCE/QEHK+n9g3U
	 8qkewoGZglSgK3aFwwOIF1GeajIqt+GBqBLJmUZN6NGzFQwVvAGDYeSiQC1NFadviV
	 8KfcxGiBp7Zk/n6oNOyGkUFud+EctZ7MZV5o//R5FMwnhr4WKrAUj9qTSDXB3gjArQ
	 XwhXM5hlxDOAx7l2Q0y2O7Xd70M64Um7qiA4jEZA/Xt6y+7juAaE6mvuYhFFJpqRdv
	 zCfwu4s4lIZNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73A404094E;
	Wed, 29 Jul 2026 10:38:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E8BB26C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FADB4025D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NK30qPVGv6AP for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 10:38:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=anshuld@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2294A401A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2294A401A3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2294A401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:38:50 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8F08493F; Wed, 29 Jul 2026 12:38:47 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6618F803F6
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 12:38:45 +0200 (CEST)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66T7eCbN3522208;
 Wed, 29 Jul 2026 05:38:42 -0500
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fq41vusqe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 05:38:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFPKfWGK8MntjicRj33TzzTGoAUR3LgJU3dkYjgG8k18dfhKmEQYKJVD6wfj+2WapMpPsY6mdPpjHAHm5ZSEUUg4L1Hqu6qG0yI8VftRnNH6dpKxz65ihXRSSfEtfG8U3ccox+nOywcyylYhkDKoCE39IqBu+GzWzKRrDcNffi22fzOmpEmVYnAL+5dMLS5/P9A9hsIGvBEGVAtN6MAbhIpjWTotmM3iJm2Kx5/COPFeyBCvdPt64qlxNir8HZ2f+jdejKOQLkX7gKRCq2/E701W+pqhvXXTS/sCbLLPUdD3VYpItQisGBJuhHL95DAsznTLEiQx+k8gTPYqe31ABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auv4j3jkAaUXdCSM6+X4neI+/q+K8f5G4wZqaRxQoNQ=;
 b=Ys7sAZbjgwKD6S3MQxoaavouCBleiuPFsVABemmOOqn1x8H7gGM3qpltaVKs+cGibdY8RSyEyeRgGuLCAlSca7hF2UeWChKMb+MuRix0/yM26zpmd9G0cu1TP7x7TH5hcCc1j+EsT6RpXOFH0boXk2X2Mn1EK3KJFyNUA2YBoUnA2DL7B2hHnG/ut5dceWMVD73/l91P6wRNzpA/siDgVa4NnvS7F6y020NadZ95K/NwtCFEo0qIRLCxPaAJn/vNQY7hJr49TFiW13X/vkGKrmAYpKzqriqVPUBJRTveM6ZUN7thJLqe8lcenEnKGbb9UTpe1d6vgdkmlAlPnIJy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.phytec.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from BN9PR03CA0881.namprd03.prod.outlook.com (2603:10b6:408:13c::16)
 by DS7PR10MB7347.namprd10.prod.outlook.com (2603:10b6:8:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 10:38:38 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::22) by BN9PR03CA0881.outlook.office365.com
 (2603:10b6:408:13c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 10:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 10:38:37 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:38:37 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:38:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 05:38:36 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TAca69472874;
 Wed, 29 Jul 2026 05:38:36 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jul 2026 16:08:35 +0530
Message-ID: <DKAZNPTM5DG5.29DKG4LUZSWZB@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] arm: dts: k3-am625: add template for tiboot3.bin
From: Anshul Dalal <anshuld@ti.com>
To: Simon Glass <sjg@chromium.org>, <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com>
 <20260717-k3_binman_refactor-v1-1-4089220b4fd4@ti.com>
 <CAFLszTh2mAP1COO0V9own5rX8vz1Ly+RvBB=dDAiNNfRKf8wXg@mail.gmail.com>
In-Reply-To: <CAFLszTh2mAP1COO0V9own5rX8vz1Ly+RvBB=dDAiNNfRKf8wXg@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DS7PR10MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 20467988-5041-4e1b-e3fc-08deed5d8c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KNYLunHFgw1AeooGh88nV0KI+p3Uap0znxZA6P4vulaMOfJFcmIEvVczESDVyA/T8bEOSNCIJEwvzIPA5SEi/DVaILeQ7kXmExtpG4LcEhTImVWWaYDje3Ns8xuOY4gAQAC83+jMkYRc+oYDBnaHweanaJQse/s5Q8L4t+M1ncvPjd0cXsqkxSPoHG/zQsmhyqRMgFb5QAQFAHX5qnGo3AIfcJ74VDqg+gVykL7NsSB6iCkyXJVr2hcAAuWeLWNAc8PCXMSa6jsSXWjWGpJEMre/FzRl0kussaypXDfXxPeKxhC7S1ARtVujLG/jOR80DKrh9lXLko3HROT+aT6Ox4td9SpZ0iTfbabLUtPxoaduiAhJFcG5BSLnPnxbZQwTzDoK4nm2SCNMqihDwR+tvdmVB/7vfBREVZ2gapgU1UHQM85HFYXl5dXlT0p9mBnbLhQpeBX2n56n6jRljKD0iBS4f3rh9ZiqqwPHmCxmlBu/ePqh79IreKmQ2g7vqYthgnUKDU1G+QmjPUdL0pwiEPUmSIsm6hBoLj7k82O1jWR+MuA4YKNgs9eIt1NWWsM6tcz8Jvtq4EV35torJZ59+WUDaDR7ZrspneWSE4QdlcuCEo4Fd8tQ3oHHbuwjWdCaD6yEQMF6Jetz68ZvjnfuyM4Fw8OZLFWDejvi4vUBy20anpFjAodTU4tzXIWbKE97oqLHIUvi+Gz6aPTqjA2OWg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(4143699003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0HtLD76+nyZiH140HRDiJ7Le0djIcoyFsogncZpWHwmv8kuWvcH91hDciZS8dPooyg/jErujOLaji59qpqxQlqGLRD5Bg9gRBAbSs94/cKz8+DzOW0orh+J3G/HfBY7ULB0CqYvQyt5suZA2qsRu3QHl/d2mXnRhXu5vfLDXW1ph6ye0Auc57ZgS993JreXO+vSel+wm/td4EjObXouxp1tKawHygUQnVVsgDRQnWmx9r7+4aWsIVg3MCAHyxRdRu/wHlb47bdO8FqXqOoI2nP2mYnxskxMWoN5qAG9QrZQ01Z0EjKSBiuPjIaq8QXOuBi4SBC24E4WYH0CspytJXkF2wlSLvO+bE1caItLUqfC24m+bQLrezRiHYAxBQ1oATjaUh8Q/A3ucoNSPd4nCmfa94Hc2fnkUTAbjCpGxNCvqR1NNEbdP3mE0mL9H2WgR
X-Exchange-RoutingPolicyChecked: bcmEd8E3p3RDyhDqUyT7rKHmUBmM8qo3d7Y6Ue7KuSFbFu6HkZAuRym67B/h8WaRZUhYzHZtdg6kbFtBaOIWyXTl6SsLfPBqoNyhgV454nLssYPNlBwcKiT3p9aYEkuTTk0pmiiy8BpQYQShOJ8v912KlrabRSvH+huFHn88Tf2vi14fOG5nw6aAXGdq7CNXNCGg9ZdqcuBSg5rH5lbTd3aaPbRPtrTyWlaSUjCfdZvMYLcC66UKsXqcBiOr5OlYWh/clv2P1tE50cWKI3LhDiMUBtcQNx5GI7r2I0oEaKafeFrKNaQeKY8tReqP7aISpRbGYrbXSgiZDm+uiXNxjg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 10:38:37.5730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20467988-5041-4e1b-e3fc-08deed5d8c6c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7347
X-Authority-Analysis: v=2.4 cv=D/h37PRj c=1 sm=1 tr=0 ts=6a69d832 cx=c_pps
 a=EOla4jo+ZS3aUDydQNalYw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=AXp0ecf-gjKzY7z9nowA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: U3G9LAudOR3vQkDkeckCMip_-hb-nnaS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4NyBTYWx0ZWRfX1P68+I44DVVM
 g6hyzuxI2Xxp/eWyWhH8NSRL/U95kZK/1tIU19a6rwpM/TA7kK9/EevLJpVbr21k7UVAhwKGXI+
 0TopaY1/0WfaXD1zmlk03nvEtdUIFEA=
X-Proofpoint-ORIG-GUID: U3G9LAudOR3vQkDkeckCMip_-hb-nnaS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4NyBTYWx0ZWRfX86EmDLx9TT3L
 PSTgP40ZgAUmLeLvwF/lugN+HXYRRGOyk6XtY/4usqfEXYr7te/DArFXScTdVAinq+kZFyWdAZC
 zUPNVG7myyrPTLEgNJZn8imGIkM/xar1b1UxD8nfJgfr+Q2/5A9WbmpRWvfFkk+sEt+NoW3GKV0
 SJwuvbZlGJiNuXHZSENCm4tC9YFcCB5RnKYnxgu0Vx+rJLkUZrob6mNizuUdK/ob897CLWLj9b5
 /A8Y1YYMrTuwbO4RUEWJ9P9iS8ngTQrKd+96ENenlTgk+mERDxNjwD9yzU9u5hjXacaxD1a5XFm
 ATpuHqALSQImczXpFiJBinOoF4To+phxkwSpgT9RIVITb7xQUywrsaj3XVlj/LXp6Aedn1q5OiF
 KnKewcTWDUuriTGdb38vleDLZWMUTtmY4VqdeN00YjXk4tINWv21yj55Y3kaG8BpWh1AgCOLpsD
 qcPAnUdMEw0Iei6NYlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290087
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=auv4j3jkAaUXdCSM6+X4neI+/q+K8f5G4wZqaRxQo
 NQ=; b=Zs7DJKETXwtZXcHIYUn37zcdN2rqnSOpcxZXylsF71d3uqSBvgeorc1Sr
 CxJ7H/gD+tyYOPP1DtJ+5IFHblFbz02tDzhkcvCO5P0BeJoFYpdLe7Hegf/ki08F
 mDYF4wdfmAbP9/ZCmqG9AQMp4tKElcHbx10Je9HH6HVQS/v6qvmFTAl+AoyI8Y79
 rMdJaVV6W+1dEOZQIlYrAzMc+Pxt4ju8JKOAbYgEXbUjRLWeyeOxc/wfPNzz7flg
 915Dp56/GOIodHIDZP/11NO+JqTxRjIUaMipcylcAtHS4SaC93iRJJPbJy7glKc8
 +brU3FIXW2gJa5OnoAU01XLN+2GxQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auv4j3jkAaUXdCSM6+X4neI+/q+K8f5G4wZqaRxQoNQ=;
 b=u1Wf4BxHN1iGgx7GBw3Q/gZ+aYTeH39gac7DnefFKlfdjfWJUlL2+Ti2mGKz/igF7kIqp1+6K+kQyjGvR92kZoZHyxvMqNdn8tW4SVCDUvPCWLmgRck3OIv7QX1FSPwSJ8rb0bVbfu/alto76zmyhbpfJIu6zxKBOE79lNTpNeY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Zs7DJKET; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=u1Wf4BxH
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=anshuld@ti.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=ti.com header.i=@ti.com header.b="Zs7DJKET"; 
 dkim=pass (1024-bit key;
 unprotected) header.d=ti.com header.i=@ti.com header.b="u1Wf4BxH"; 
 dkim-atps=neutral
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

On Tue Jul 28, 2026 at 4:46 PM IST, Simon Glass wrote:
> Hi Anshul,
>
> On 2026-07-17T10:42:51, Anshul Dalal <anshuld@ti.com> wrote:
>> arm: dts: k3-am625: add template for tiboot3.bin

[snip]

>> diff --git a/arch/arm/dts/k3-am625-binman.dtsi b/arch/arm/dts/k3-am625-b=
inman.dtsi
>> @@ -0,0 +1,123 @@
>> +     tiboot3_am625_hs_fs_template: template-tiboot3-hs-fs {
>> +             symlink =3D "tiboot3.bin";
>> +             ti-secure-rom {
>
> This bakes a policy into the template - that hs-fs is the default
> tiboot3 - but the hs and gp templates deliberately don't. All three
> callers (sk, verdin, phycore) already set symlink =3D "tiboot3.bin" on
> the hs-fs node themselves, and on the r5 beagleplay the symlink lives
> on the gp node. Would it be OK to drop this line so all three
> templates are symmetric?

Yeah, putting symlink in the template is not the right approach. I'll
fix it in the v2.

>
>> diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-a=
m625-r5-beagleplay.dts
>> @@ -33,38 +33,7 @@
>>       tiboot3-am62x-gp-evm.bin {
>>               filename =3D "tiboot3-am62x-gp-evm.bin";
>>               symlink =3D "tiboot3.bin";
>> -             ti-secure-rom {
>> -                     content =3D <&u_boot_spl_unsigned>, <&ti_fs_gp>,
>> -                             <&combined_tifs_cfg_gp>, <&combined_dm_cfg=
_gp>;
>
> ...
>> -                     load =3D <0x43c00000>;
>
> The original hardcodes load =3D <0x43c00000> whereas the template uses
> load =3D <CONFIG_SPL_TEXT_BASE>. These resolve to the same value today
> (the ARCH_K3 && !ARM64 default is 0x43c00000, and no R5 defconfig here
> overrides it), so it is a no-op - but please mention it in the commit
> message under 'No functional change is intended' so the next reader
> doesn't have to chase Kconfig defaults.
>

This value is specific to the SoC and will not change for AM62x but I
will add a note in the commit message for the change anyways.

>> diff --git a/arch/arm/dts/k3-am625-binman.dtsi b/arch/arm/dts/k3-am625-b=
inman.dtsi
>> @@ -0,0 +1,123 @@
>> +     tiboot3_am625_gp_template: template-tiboot3-gp {
>> +             ti-secure-rom {
>> +                     content =3D <&u_boot_spl_unsigned>, <&ti_fs_gp>,
>> +                             <&combined_tifs_cfg_gp>, <&combined_dm_cfg=
_gp>;
>
> Just to check - the property ordering inside ti-secure-rom here
> (content-sbl / load / content-sysfw / load-sysfw / =E2=80=A6 then sw-rev =
/
> keyfile) differs from the hs and hs-fs templates, which group all
> content-* first and load-* last. Both work, but since you are
> consolidating anyway it would read better if the three followed the
> same layout. What do you think?
>

Yeah, that's fair. I'll re-order the gp template to match the other two.

Thanks for the review,
Anshul
