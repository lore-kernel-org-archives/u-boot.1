Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7595AC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A9AE80DFB;
	Mon, 24 Aug 2026 07:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d89CUGSqHbfU; Mon, 24 Aug 2026 07:07:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787555242;
	bh=nA6ZgtKw1T5uP4lPhIq+Fsg4jmf+YAR8KmRHOcasKG8=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vd0mCeDLnHQwcTH/1v2ySvvnVmsAcH3yF6NB1KDFwu2uBJx9Kw/SLqKLlnwTLss8D
	 JyEjTFGTcp1laHgIbDzyWY6d5HOuK/AG+xcwPGv8SaU8vfhjW3EwT/EKGBGy3J48WR
	 PEa1K2VeQvP+aC6Sx1eEgqfYZqdHuLrMF9/UlhI+9Qj+V1FiVRlftIKiPbspwDn9dY
	 TtcQufUDGooW0iYzqJ2OGdfKWsVpDFSYMQbj5Vht6r0lK0VY8UAAbT9klVqc+t3GiV
	 YQ03zgJsr5uqwwiRfTRrmB0d8laTKFcUmDB5oS+ZUvSgvj7g8mRuVFiBwHH9yKhQ7U
	 6a8A7qjQodQ3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D9A380DF4;
	Mon, 24 Aug 2026 07:07:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E808B336
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD6E060625
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:07:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JmDD04TIBYlG for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:07:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=grCL8a6+; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=mZASqyop
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B64960622
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:07:18 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5UBA92431069; Mon, 24 Aug 2026 02:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=nA6ZgtKw1T5uP4lPhIq+Fsg4jmf+YAR8KmRHOcasK
 G8=; b=grCL8a6+r5yoYQvH+D7FpX6wlHgrPPcOwVrNfQpMWA6WFHsGZEjwrVs1X
 xjEV968tRrOvQ1UCH+5S+ViNbnshynW2/9ioT571rwJpBw1/YlFVs7jNSVgaiCde
 STaDC8nV42ODV+JfSnWiapiKsb32kjcOmf2zhehAL+t4wCT55p7sGg/NPwYXxzrl
 smFRRkBSr8/wWly8z/qGBHuq5D0nhxp35iyIYcxEMFi9y39U5vJNuVhbJ61sW+9i
 M9Q4YMta+vfpcdfa9L/R4CafflN32iIGCsw6vX1TE8KfYL4gyFYA9SA721w+AsIe
 LsT7MhhYoB0v+r//sYZwE+CxZ0ucw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g8d1f96jn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 02:07:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amxBndHmAUKipfQrnDQ5rDtHsKBNO2tuCwXAN3qUNtIPAxRlh1VopxdMtDqwA8PC0AN6Qdt0Njapgyr7UsmIeC12usZDiDTXHO+H4Wty+e5TuvBMjXf3VzAF5xEUSNbgOCy37AVZDDAINtLZbghu8zFjzRgqPN/1lH5bb0u2vq35KPkJxDoHijeP6hLG9BxpzqmLCeAqbgEZl4Id2w/5RufG2sRPGoVSU2VWs2U2B0mYywNQSUc6lnsG62ZwTYCWljmvwBhJoRq+80HembeC6UJvKSVee8qncPNaMUOk5qgS/kJ7rWwRfHpiCWT8aObpS+YhLMYJnHTuaZ1P2WS08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nA6ZgtKw1T5uP4lPhIq+Fsg4jmf+YAR8KmRHOcasKG8=;
 b=ZFN99FoaGieGvKwlo6N7qXxOYgIKxSDg5YH4j69MuxROflcG6Bh+PtIezRIbikTSq1OMjX8aSClj/KweTU1kW/UUPRtyhcor36kdIa1yvZU2ms6rWwCVDzQn2UlGJ1AGeWsK0diPSdJpfeHN90lGoBSsFvoefiOmF6oQ3Zi/fNU7BVVAhl3PaQ75JB3Tc3Fxov8YEkeG+NLh2kfm/UB/Nn2ahweaG3DQlZz2kfyj5n0QGp+eHcJiqMxjEtkCTBmhuJvdZudKR4Ipni7cJR9/+K+JAMJRvRMhiWgjJPyqNkHJE1t8gY2FjzPsZuXJDee112UYINQMDuDgWvwfp+394A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA6ZgtKw1T5uP4lPhIq+Fsg4jmf+YAR8KmRHOcasKG8=;
 b=mZASqyopU4nijs0Howb+m/Y60STqKRNqqOXLVkzYmh1Lv2+ev5x+y2mmM1UuMMHzufP6ORAK02DV84RWgBiVuaLcNrI1r2KfefpXgENO2ZZIEI/lCQcb7vtzIXhUuWF9kA0yNMgnTcMlnNFanlmAdnEZAu9t4V2GGJth8RBr3Lg=
Received: from BN0PR04CA0141.namprd04.prod.outlook.com (2603:10b6:408:ed::26)
 by DS3PR10MB997750.namprd10.prod.outlook.com (2603:10b6:8:347::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:07:09 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::ad) by BN0PR04CA0141.outlook.office365.com
 (2603:10b6:408:ed::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 07:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:07:09 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:06:58 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:06:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:06:58 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67O76vw72576749;
 Mon, 24 Aug 2026 02:06:58 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 24 Aug 2026 12:36:55 +0530
Message-ID: <DKWZFTIBMBBL.2XN2NB4O63S6@ti.com>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Moteen Shah
 <m-shah@ti.com>
Subject: Re: [PATCH v3] fdt: Fix phandles not copying when using templates
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260729-binman_template_phandle_copy_fix-v3-1-9bf6cbbe1a61@ti.com>
 <37b6996f-f0bf-438a-b96a-1d2d74ec8d9f@cherry.de>
 <DKL91OUU5LDQ.V2B9UQREH116@ti.com>
In-Reply-To: <DKL91OUU5LDQ.V2B9UQREH116@ti.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DS3PR10MB997750:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e1a3b8-0ebe-426a-95ef-08df01ae503a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|56012099006|10067099003|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PjtsZ3ghfSZqXZWvVbRki002Q6jlzFGesDutH0/ZdK1E01WoocKNpKOlD3N10Z7rJI1bNbow/R9/j4aMtcegciPfpAYuugSNUu/hhmzvnw8biXNz0zNNIYyASICWuK94IpMb0febT6Essec12+qa6O2L48bpmmmIn3OOw+IXCvnGR7MxaGwXVh/CpovAvG1KW49vRCHrIm9d8szpn+uiL6rYPfgCeSUbbp0QAamB6Eo/ja6nlYczVhAtjuc9nCncROIoAdksznAr0ffnqeGyAVwImron3vZP1KMz+F8rhNBnv9RB68gNcWlgqIlZm8sfkP349CdkGPNAVW0Buxc90ys3STCSVLE6mAjPptL8jQkfMuEjdilccSPi/GTSwx8C0w3We9pPPYbtWU7NcMhhHdYh814qxZ1z68NxtavLHYRMKigup+GoWYzzUwoYNKetPJB/fYtxY3w8VceSU4nT/bcGgeR87l2K0b+yvdnTtGJml/66vUt/omrt+IW1kH0sepG4o+3F8nNhyPCCk5jbBG/uFG/onDD4Jr+nhoAdCPIzMPT8vpJ19eOsDbUQszSpcrL3pm8foeTN51vja2XcBAuIbxUOG+huUx0BGDye37fovJxCS9LwLxOVrB33Kwlcb1YpnQEyXR2YA/AZ1Ivw8g==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cjd6gZdLm20pRJzQaqJJQQ0qx9rSKKWculn3I6ypasV4C2J3OHozTDB/E9vheBObm9ltgNQjwZRXIwbwDM8asJEXwiFUWZZi5R1aV0237w1GosR3FRxxqjZH7IL9PNSXHUWmWSmhqx2zvoE2Vnq+FZP6L+GchbFmll7oAUTjLRwn8pNBbHMc0dqVUb2bjRKwURJioF0lSq9Rv2B5tF0EgsYtGZjChpCz0bJ3uqAM3/WjjuSH2JaLFvKe7OKJVY0nzGhkiCgD/w7GE1dRRlUTl+/sMN1tLkQwIUjClbAdc5+8fk8k9vjjFr7pZEYQnsWnLIlIPUtHJ9EyOvOzRNetgz6GOPf9GcVRXd21V/jpBBPW2GdTZLCm/Oi/isu+vr7nUADwLD5h0J4E7+u9Acxb6eMv7+jJTCQFfFJ1oVNyLqb5lAt0AG6bpTjlz3olI6mE
X-Exchange-RoutingPolicyChecked: K03dsh5fQGEOhB2SMMuSQxavnmyLW4mb/RbbDQnIpGRxngamrh5j5fJwzkie3gjUMaIXJI8UDmTAgFUOKycRVg99JxfLXaG7F7CSzYyb/cFaPj7UX3dRx/y1TdoanFjjQRTRGLpqhlpvSIuyz8CWx4hUQveY9ULlyScj+9BGVhTPZi/aQZUj3+ZjG15wZ7fk0t0usT3SUcx0h+L/pxMWDcrnWaKbMYzlgFKShMPiSkzIXrAxSwlD2KOMqTn3pCELPwom4eRDS5peH/Rw9ZaW2TuyNx9JAI8WdML9VPY3LvQart5f85+wTEM11Jd+SXz4KtUkKgcpUZ8Lja/QUyLA1w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:07:09.0566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e1a3b8-0ebe-426a-95ef-08df01ae503a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR10MB997750
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2MSBTYWx0ZWRfX2LZxEUWs/Ape
 zf2Myx0EmBKIgbU0EN3CHRguK8zDZuJSZ8GlwTAp0Nk9pTvlpex/S+DAS1kEsY99X4LO/0Wabqh
 1FQqY+TQvtkXHLYp5/OS8Otu/ijO94/ZyFhJIpcKPlDdKzQpoHf64eDM1ixkGYuoeK/ZYQbpfmV
 2C5+wXJgd3jk/SBZsHtQA8IovKhvlTQVlU9j5R34rZCg1hbJzRIzdscIEVmTmA9HErkT8VEIhvz
 wfJLtdtmH/ix6Bv+w8TvHOyK5KtQ7vTxLWhGQFNdoW/Rgi6ZLk1rLQ/ZnjKvAzF/NosR3VbUmiV
 eztLCp9NdgA63unouHkMObbM5Lpb9r7KtbO4C4oeuxQbR+5Bn+Qouecfb/VoLABWPePSVJKHTlK
 mQo8kvMR4yPvsxQS2Sk7UXNXdsLLgx1Q1eiLAyln628EnrVUaMlQXrTjJIzYh4aeho4pNk6DTHL
 yd2PzZLhDYU8Dqnccnw==
X-Proofpoint-ORIG-GUID: mJNStIHwUsoytMhMMp4P_NoT5VG9VnRF
X-Proofpoint-GUID: mJNStIHwUsoytMhMMp4P_NoT5VG9VnRF
X-Authority-Analysis: v=2.4 cv=NZ3WEWD4 c=1 sm=1 tr=0 ts=6a8bed9f cx=c_pps
 a=qHyJGWWDR7+eWeZXJqH6eg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=XpE1AkgCAAAA:8
 a=cvIuWm6pIepFOt1jChcA:9 a=QEXdDO2ut3YA:10 a=dpZMgbseYPk84XhQl7oQ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2MSBTYWx0ZWRfX5jSgbr3e116w
 OV+0pdBGEqDUsxefpQLUUka+ApJ7px/CT4qF2GdQO0UnV0S6cD0AdpV+h9jupDR4svaIFezDI1u
 d/jKo7WmCO/2eB2le1veC4j4LGomFUs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240061
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

I guess this reply got dropped due to the list migration, just a gentle
ping to ask if everyone's okay with this change.

Thanks!

On Mon Aug 10, 2026 at 5:36 PM IST, Anshul Dalal wrote:
> On Wed Jul 29, 2026 at 4:12 PM IST, Quentin Schulz wrote:
>> Hi Anshul,
>>
>> On 7/29/26 12:24 PM, Anshul Dalal wrote:
>>> The phandles used inside a template are not copied to the node insertin=
g
>>> the template, leading to a missing phandle error.
>>>=20
>>> The following example can be used to reproduce the issue:
>>>=20
>>> &binman {
>>>    some_template: template-0 {
>>>      ti-secure-rom {
>>>        content =3D <&some_data>;
>>>        keyfile =3D "some_key";
>>>      };
>>>      some_data: blob-ext {
>>>        optional;
>>>      };
>>>    };
>>>    output-bin {
>>>      insert-template =3D <&some_template>;
>>>    };
>>> };
>>>=20
>>
>> What happens if you insert the template *twice*.
>>
>> e.g. have:
>>
>>   &binman {
>>      some_template: template-0 {
>>        ti-secure-rom {
>>          content =3D <&some_data>;
>>          keyfile =3D "some_key";
>>        };
>>        some_data: blob-ext {
>>          optional;
>>        };
>>      };
>>      output-bin {
>>        insert-template =3D <&some_template>;
>>      };
>>      output-bin2 {
>>        insert-template =3D <&some_template>;
>>      };
>>   };
>>
>> ? Gut feeling is that this will fail to build because we now have the=20
>> same label for two different nodes.
>
> Yes, it will cause a failure due to duplicated phandles. And as per the
> docs[1], it seems to be an expected qwirk of how templates work.
>
> [1]: https://docs.u-boot.org/en/v2026.04/develop/package/binman.html#deal=
ing-with-phandles
>
> Regards,
> Anshul

