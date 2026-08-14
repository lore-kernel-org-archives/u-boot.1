Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7783EC5CFDB
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 12:46:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28FF540947;
	Fri, 14 Aug 2026 12:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GhA6-zv6PSd4; Fri, 14 Aug 2026 12:46:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7106A4096F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786711594;
	bh=FNtNTgmrUt8GcQX0iqm+HBe+YLS2xC/v82r/TPxzjsw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UV/qx/3C43WsNyAxNe6T1ZEZiFAo4dEKukFQSXOkG8DfMgoE76cWfDtKlPYyfOuEW
	 saQSz91D6HvddTo7hc/6KVbjYq7WvZGE5klGvyxwV84sNGxMcBhxFItOTgJgJRQZrW
	 ITzFfQ+hyPWUr8ugnZFxD3cS/KzolRiwrscAXNhQlLYIXxoakqrgK9GMMKbOBCTWhJ
	 CICxQa/wAVhNLNvNYe9es+KfTI4OZgJLJa6ckP/o6xtERrK/WhRPtnwEw5/xmZKY2J
	 7FLCiLzjwGbwXRbVngsNzYJBFZSH+iNkv4ceu7m0wFz5E3RjReBjqbj0HYafhbfcc0
	 FvT/er3IchMFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7106A4096F;
	Fri, 14 Aug 2026 12:46:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13E7A1B8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05AEB80EC3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mGM3cnWCevzm for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 10:22:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 13C4280EBA
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13C4280EBA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=pCQ/yeWB; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=fvPIErHa
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13C4280EBA
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:12 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E7eKpB753570; Fri, 14 Aug 2026 05:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=FNtNTgmrUt8GcQX0iqm+HBe+YLS2xC/v82r/TPxzj
 sw=; b=pCQ/yeWBrwKKmGBrA/nJwvElCigkF03IW7OV/myxITp1fGUixyS0bkQ1k
 S4+xT7ryakYBiQQ1Smi9ewYJd5AiBTWgslGYis04BVkc3dyS3hGQ7eSFj8fapHXu
 rKmRMioPzTItmyms2Fw4CQXfngve+nQttV/JQ3dqEGP5kgoAPE5aE6ZxApVMP2Sl
 2m/7uKfhui0mqtx5G3ttZfTx7jo5kh+ouPIDa89Kq7/Uq9xvy9eNO/eZn93oqkIi
 oDfk1h3TUtD4/W/uCAxXqnfnKkD+yztisRBp8tUTfPdRteM0DkfNfqEhY0m90IhV
 n/5AIXmjSQ9z+jyTWq6YBPUjnduWg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g1x2egyck-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 05:22:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXPOPGKXSsH7HMD+aPeGnSdfEGiRBPcOtiYUdFZleAhjfLT34lCegewPqMV61/IywlnTX/LRdoVTFRFBEgmpn3yRfli2+YkLefGZkhEe3u8Hx+bOkrSEDIFpiwHJ3pSdjchSNbvCo9F3ajrXJi+wMX/fIZgvG08DXufJhouI2TP3ad4poM7NnM1qNtPxeaXIJybIDzfc5BLmTVdtRgEcgqE+oPql5KYRPGkUSBGHmeUclJaTXvlFjisnNZr3/9az2EIvZoGWS+eFZja0TwDZ9Q5Cr6jLmyCgRxqFwYAzFnynmSGtbZq2X6ra+MITa7DV+YHUXFbiuc0MnCcmIbhS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNtNTgmrUt8GcQX0iqm+HBe+YLS2xC/v82r/TPxzjsw=;
 b=BiYNXHlkd2NTaYnWgN/k2Ewc932aKm2k4UKtY89nwb88QYkkqC8HL0R0Qy4LYbrxALeNVD3flb3xLpgjwZ63CAmxUUFPxycNVU05NcPB/9pdwKDmPcbaJBQEg1EASU0mmyDONv323oEBE4Y+uc5MCF0Sm8yqAIut0nmh75zE9hZvPuzRv+j98bSYeOz+P66y5tZBG7ebYYfW24PjW7Jzyo3XNnyPSSfKYX3sjJpaAcEOjpwNDfxlDtP5MxE6aKVhMyxQVK2CLiVoey/eWpgTH0ej9iOGjDWl5cdOUInFFGdz8yYTDLlRtN1AFYDwqIvBAhZJJtfEzQxUSbfRv7zzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNtNTgmrUt8GcQX0iqm+HBe+YLS2xC/v82r/TPxzjsw=;
 b=fvPIErHalEEg0HjhVtr2eWE3b3FOPesyU90Lm3cYRMkTT5OJ6eti+o5H1hRHy79T2GvhaIt5KUUoGyzodYO7f/Yu1r2VNjY+KcYqGmojgOnvhuwWUW23Q5gKGS48OGUFptaWm8zttijW/E7DHlTnBfiOtmJD7fppTIOunBhny60=
Received: from DS1PR04CA0023.namprd04.prod.outlook.com (2603:10b6:8:243::17)
 by SJ5PPF7113AF9D1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 10:22:03 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:243:cafe::3f) by DS1PR04CA0023.outlook.office365.com
 (2603:10b6:8:243::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 10:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 10:22:02 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 05:22:02 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 05:22:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 05:22:02 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67EALueR2569179;
 Fri, 14 Aug 2026 05:22:00 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <a-nandan@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH 1/3] configs: add semi-falcon mode fragment for k3 devices
Date: Fri, 14 Aug 2026 15:51:51 +0530
Message-ID: <20260814102153.44487-2-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814102153.44487-1-g-praveen@ti.com>
References: <20260814102153.44487-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SJ5PPF7113AF9D1:EE_
X-MS-Office365-Filtering-Correlation-Id: b11bcbe3-461c-476b-bf09-08def9ede22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q/zMB7RkQuXYf4OolrYRwoZhCTTSOT4WrgB5mDmy7Xd9oaZW7QRet884F5X+n7ntfAFiylRHlVzulMWKEcEN/0D5PDPDYnsKoDHFkUWp/rJpfHI4Z7CdqphQhBIW95eemlHUTyU1hWsZ0nu5Wil725IEtcK4ItiGIL4kznEwFFqcSeEbMBPpmEPQlnbOf9HRCGunM2MfjqExXNYP6zMlAeXc3l87bEGTVKzobLkpNwVN5LXGjfItJ1Q34O0wUTu7aWgmMuigaCI1en0B1jCDkDfUQGsKXLGi1TO9WQ+ksB9pDEP9egX8Faw8sOLh7uWVquJWpjYdR3vuvm/DuxXZRQpuLcftE2sr+n43a8Srb1PLYa+OsKlfLjRzM1r+mSlK0uwWfKhend7uyNxDFfDHLkAEQI5OseGsF21+VmlC4t48s/QEYPyok0nRs8AkYsWCTM1biRE8//PjFONbjyciaBDgAIrbc4P9RbAHX3twqEpwvLrkOHz6+Gwy1LHRxjiZrqy7bcaQYR5j2uF09BANh9EmbuqfKy1AvF7kFrpeLLO4l0wiFgBbMTYut9BVmAxYJIDhxSD/VUIoQMTP+tnY8+m4TZPduI4gcTsIoRqtobmBCozlFWYVwMtNxgSd9gHpyk1hiWdAI8vklaQDYkA5epKS3cNbk2f+IHcNAZP40eI9o0HptfvYyEayxzNrB+YIGDXISa49u1sH9adw0Qnsww==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +AqYoU5cOrujW07b5jWFCB/u30N7pDoSr3Yw1SM8bMfMcIsCkkAiI5wnCrtEZ5HWBoUvUqRSE+UDqr/ASBwzI9eiszAyLuFzIhTjI8WUr/A8O77grdayMpCwrUrX60BV1bIFSZrgvOnEo8vo+1KlNWfG5Dz/scRZmWkxuYrKjgg6Jn+E+CuiL60dQ6wtsuh05NNZODAh/hSTgwWYov8Kz0bDZIS55cMfG5tIMYoUquRCtsUEPHWGQN2MMXWfdC8nDeauqlUhuDoDsy3X9y/iq34CxoQJNMz6RWHvByKjXLwnjqErC34JBuYLQR4Epv/4OXQjoP4XB2iQa7uWsY+I67SndPXq8TMppCS5LkSlh1tH3FUGWx6I9aJoP9X3K8Aom2QVD80g3vA/BDkRMwhabolA7UWhS69k+bVj1T4D4HCzNA1G83i0ODKZ+KKXebdc
X-Exchange-RoutingPolicyChecked: sTSRTyVu9jEW7JLOoH1/JkzxvNMPqV6YrZu764+vQubWtPhTeQ3M+GGRcZ4gbvS9PU2ptUrvJJiYj458RIhQgc5YWSte0iMB4FMTPiOn3MtigbFXy4dZ5nDYUbq1JZMfevD8036kTOOmlgO8sQnUxsAEO7aJ6RLh6u1ZxkWu0wffvjcDDBL/Tgm1lDlZDmND2uy+3oLHr/Z8yJvSGY6pQCz3WqKXJOHFTff0s18w2v4TvkPxdFl7hJopZD5DJMtZAMvlDZxekNmG/eByk0Ji2jws96CDS4gvESAlw5qSKqO5KdiTFRnNA6Bm53YjY8/31lU3DCbtSNlts3a4I4EbSg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 10:22:02.9338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b11bcbe3-461c-476b-bf09-08def9ede22c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7113AF9D1
X-Proofpoint-GUID: WVRid3i5b2DRwRpXpkxsQllWAYeHJ1Hc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfX2rd5QisAOpRs
 SWatTYnylTuLeEdV7CxMUPyCn+aaEC1ibGj6BRGqCd08kCoEHrTaNabMCmJdZu02xu84B/ovwhQ
 ZXze81zdfSorfyXN3OtXzsfHxXu/OYUUD3PrRwJrQyUPG5gsnSqIfODF/T4UFMb1GKvnvwIU9PY
 kRBdYtGZHgf3vpD/mHs/Ir5ymOiyY8HpX11W9xsURTReEXIRnonosSwbkjCagcibdXy19IhiBV9
 dYfBviDPEppWo9CDxgdkTfcYJqBylnysBhYgVYnaKR25zWbcJw3MAkd2/Z77HHFe+i/5JGsZnAY
 +DlEfM1B3dAa1TxXInloVOaqC3liDRJcINSJkEueK86073QPjYYSsPPSzuEFjPX8VArTPW2OkKD
 wV+JHBv5QUDDbG1vnjzjs5n2wsFS8gIiI0cOvB4MQsgU2/YG9qjUsg0XtXhc37uMwlG2k3lAEAg
 SlxGGxDw2FCtzukhJtA==
X-Authority-Analysis: v=2.4 cv=GYcnWwXL c=1 sm=1 tr=0 ts=6a7eec52 cx=c_pps
 a=LPqnct3xGwQwGN9n+XDEZg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=zewSo026zT8JIqLPc2kA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfXx0fSXoMnAl6W
 uhAAuYFc8hjNQRqWJWLB2EjoN6h6xtHfvnGRJ7e5NAr3DQI9b4DrUvxmOSIrnv8aisz8qgtkYQZ
 zDZh51v/9O/7rBZpshsAtrdrTROifVY=
X-Proofpoint-ORIG-GUID: WVRid3i5b2DRwRpXpkxsQllWAYeHJ1Hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140078
X-Mailman-Approved-At: Fri, 14 Aug 2026 12:46:31 +0000
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

This fragment enables semi-falcon mode for K3 platforms by
modifying the file to be loaded by R5 SPL and updating the
UBOOT proper load address to A Core SPL load address so that
R5 SPL can load UBOOT from that address as A Core SPL is not
present in semi-falcon mode.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
 configs/k3_a72_semifalcon.config | 1 +
 configs/k3_r5_semifalcon.config  | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 configs/k3_a72_semifalcon.config
 create mode 100644 configs/k3_r5_semifalcon.config

diff --git a/configs/k3_a72_semifalcon.config b/configs/k3_a72_semifalcon.config
new file mode 100644
index 00000000000..7522acab950
--- /dev/null
+++ b/configs/k3_a72_semifalcon.config
@@ -0,0 +1 @@
+CONFIG_TEXT_BASE=0x80080000
diff --git a/configs/k3_r5_semifalcon.config b/configs/k3_r5_semifalcon.config
new file mode 100644
index 00000000000..0217ebc81a8
--- /dev/null
+++ b/configs/k3_r5_semifalcon.config
@@ -0,0 +1 @@
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="tisemifalcon.bin"
-- 
2.34.1

