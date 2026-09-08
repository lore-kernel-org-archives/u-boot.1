Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068FBC79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 05:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C03534052B;
	Tue,  8 Sep 2026 05:15:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a424K-PY74ne; Tue,  8 Sep 2026 05:15:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C9AF7404EF
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788844513;
	b=FRykrVbmM7fDhnFf15sXq0IIqS/4FNA0c7yaSEXUXrOixjncjeOER5UXBaHQZFqOjnib
	 fyIRD/p+oZ38irzqtgnOQgGKUZ3lxPK5E7wIPKe+xEzLjCy8xKg6jvtGoj/yvSb7Trbvb
	 Vo29/jMaXS7NktRx23dnz9l4pITSoynvlmLQylZFSvIuGPZvwpf6FLbCuR+x9F4fLDDNr
	 yUa3FHzCR55QE/hHD2OSRSgrDenjrwdIEw09pg4RZl7gWzfQZzJNutml4gZSOm5pWUkbH
	 9U0SPqQw2OFuXIx+y+SFGnMTVU/ZoNvBmHnCetTiRPdurYKUCe+Btq+6mX2QR2xyutw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788844513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/YbIr4gAsvQjZNcN1yx/jA/7qP5lxjNY+8lJy+J38YQ=;
	b=ad4dFtsRTQzHPWmcod4FSPGXqceNmNxJQis3nSTqKZZJcqjg3AmHswl6PcHYdLgVZpMK
	 heoruvu4fBGaFmJoxV7PM2sXesQ+6707eU7G55HLyVUCkCWo5P7X7GbQuwx09Y09aLFwS
	 LoZLGqAxuELhZLaQKY7dVdrggJfFgDFDv2KNeB6ekx36vbvOr0JxtcxW2+/f7vXgQaWwg
	 INP0jhi0GMNOSwI/Iy6OyB0GO38BE2mXHtxuTuNeqbtLe5DidnfEPJTOfX+ryhpyZ5pbp
	 jQ4hVlI9ZTlH4MgagbBpGHCGptNwLoiweenwUXYMV/0iqmxRDyzui0HwTAGizpXweYw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=K1fh72pk;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=mIaJBAJA;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788844512;
	bh=/YbIr4gAsvQjZNcN1yx/jA/7qP5lxjNY+8lJy+J38YQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qNFUeL6Mz8Q77GOmSf6NFP0LiT18VFM8ZEc47LsdREsM5cakaTfcHV1o4J4mejo7S
	 FTuGSHv6TmhBvqGMdT06cxwBoPkVMJ6LexvKZE55kjnSEVUZeMEk9oDjoWDIArpNCS
	 hOBdNl8A8aAQG97njWS6RixmmAWH+UOqF3hFU5SiANVoV5cXJ4XtifcFJS/c8pudLS
	 vxt3+lbV3eK9xcOJYdwbwxdewUUWUmAv1pWBH/w4LJkxu4Vs5fRLiYy5F5l9HYNgtJ
	 DwjCBIoYa/3p+mGb693fbaLIvm7Edxxl6huFmWruk3o3hDGkps7uhl5ZF4/xVW+S4B
	 T9DNn4hVBEZTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9AF7404EF;
	Tue,  8 Sep 2026 05:15:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E37B0970
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5D2D4053A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m-PXswCKWYN0 for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 05:15:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D6C8A40538
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788844509;
 b=H22ojO8sPln5/CfGaV1SzVY8xzXkUSEGzzA1ojcOcz5csj4SevznqUX+CEiBpnva76sY
 1dc8+4GLJUSSYyRgH4jpcvxqEdpnRdqjK2kQZUbDrDEC3wd9Av+14R/xq0ztyaKhWP+Kd
 0vPZdFLhZPSW48cG5SVpp0iybjHU4Jnp36cY/oJSuxQgwtdHdBXxB2Cjw/DtJXPpKv45f
 pC4ry1jaiAktXVhM1c+oMS489Zv7pmrhfY4DzhcvDSbbtw3pjSFjl3JdTNfJJiisE2Xg2
 5IyhQ7x7PpcG4VBbe/AQ6RO5CpEMdK5OYdKsRW83JoqoQxO8U1eNhMCfGg7UdShV5ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788844509;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=/YbIr4gAsvQjZNcN1yx/jA/7qP5lxjNY+8lJy+J38YQ=;
 b=j9judKcLUbbdzNXfRQxpt4PdEAWBFJsshY3ePsjz8pkj8KuLEZYgzxWI3CVSrJ2ZE/7k
 sCEnKa/oj14pq+kkq+9IIc4koDAC3tT7wF+TIS2XWFCrLXRQuh2RRF404epVImVgZ6MZG
 nuPMOT7POIR1M3lxv9V/6hDs7yUOTdcrb1ctJCPVgU8K5fN44kfUY2lF4xqr2Y5jSgwYl
 kg2MFz6RZN8C37LGBgCXuGEa7uXIn1BaloGsqbMQCC8NHOj+J3BFxaPiPybv3UxgDi8ee
 e9cs37kOCeAkh8Rcl45vnmWiQC2BdL9ArtT3aNdS1MKs6KTjrsK0u4zLU+qQx8rqBBw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=K1fh72pk; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=mIaJBAJA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=K1fh72pk; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=mIaJBAJA
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6C8A40538
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:07 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 687Nnlxa2679351;
 Tue, 8 Sep 2026 00:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=/YbIr4gAsvQjZNcN1yx/jA/7qP5lxjNY+8lJy+J38
 YQ=; b=K1fh72pkKqkJwQtt+K9R5azQW3GqGqqKq+fRDvJP2/NhkBEyOsGBYMrPk
 rhXVp9FjN6Ecjcj47FO6ZDtIbcI7P3W11GytWeKgmO4j99mO3eK4UJnYZWSk5lPg
 zpTuwkowZLhWv+5CdB2HPlCgT92L7hSH8qytZaJe7bm395Nm8bA6WTe3TzHOoEVS
 BgwxLEqW5YErkoB0OXkHby5JXsht7ll/0QRtqxl/I9HefpNLuwZ8aqFfeVHGzGI0
 jhY1TSisy/tZNDv0j1L/CJMbY5gCJ6Ka1y27kn0eArq+k7NkhUdHFJ9+VZCGnDzI
 b1rJPPwTvAdY99yE3YfLiLpR36d9g==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ght65nd2v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 00:15:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaz6pXQQroZ/ezE9hu7Xi41HZVM/5FPcJtvQybrgbKBQZGReFwWEAHjxiunrIdkAwSfRdL1d5hOin6PkM+i+NTj8obiVkhCINN74d7DaXDkkJx+q6c6soXSyY4m26UZ3MDzpeGPL+QRjDWNHF+Ax1GVWa4sZ/byi2C9Vaaz97iYk48+1SESGNSsPj3+ELtlcQwWPmZfltxexgh5yv/MB69nsuIU0zTJD5ROqWANixDwpVt2i/Ymc/5ljjjNudGHfymNAK8nX7u1Fymt3aYpLh1jJ5P3MroXG6GYPUdAIRgUwA4/rMqa3rg0bgZQzqnCyEzGvP9PWDi49dgHMmJccwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YbIr4gAsvQjZNcN1yx/jA/7qP5lxjNY+8lJy+J38YQ=;
 b=EUSCgLRmGChcYShY2JNAyzYkf/rKELPVhTR+oCFkDkKfewZ8LPQtdBtO8VN7bCQ5FMU6kbGJ+gtiZQu15Z+SORsY7C8xuNkd9WAffLOJqKpWEcuZWaq8jOoI2UlK0kEIu2q3gRhifV7xDJQEE2/m5Nmpd7EQzXntmDlgMMkPFp7sW4zFBFI/yMPJFkKbn0XWwMpPdx//JJ/XiKID2xFFV7N1b1dkm82qaJLP6cchiv/S9Je4NcL1G7hTl8H1et4+Yce1MPu2fL4Qigz7Q3TJAu6g4Ty0iZfgxaeUPpfmlr494oAI+Ul61BQQqaZxrWhequO52O0GMkizLdadS7Fswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YbIr4gAsvQjZNcN1yx/jA/7qP5lxjNY+8lJy+J38YQ=;
 b=mIaJBAJA86C0VMvST8QF6jT6u5uiI1RpnROOzfK819ft4WDUqGIoOelpB+G0disHUTiJmXSgrhByeuOV746lKZ15nHcgSdZY1XvSsWfcqRall0oSdKpOFn+vZ5wkunVfqvj4eU56MZxyGvu41F6g++W9eRrS7e5L3WJHZB1xNzM=
Received: from MN2PR15CA0047.namprd15.prod.outlook.com (2603:10b6:208:237::16)
 by BY5PR10MB4385.namprd10.prod.outlook.com (2603:10b6:a03:20a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 8 Sep
 2026 05:14:59 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::5) by MN2PR15CA0047.outlook.office365.com
 (2603:10b6:208:237::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 05:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 05:14:56 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:10 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 00:14:10 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6885Dwd82811953;
 Tue, 8 Sep 2026 00:14:08 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 4/7] board: ti: am65x: evm: add support for SPL to update
 U-Boot device-tree
Date: Tue, 8 Sep 2026 10:47:29 +0530
Message-ID: <20260908051741.868824-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260908051741.868824-1-s-vadapalli@ti.com>
References: <20260908051741.868824-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|BY5PR10MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f782d11-161a-4e1c-3fa3-08df0d681fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Z55w0lbh4sK540xbUgcaIyAksvfnt8/7/xPvjCr6cTC/F8Q17LYVc92sfGnMTyfY0AtChTtj/KWw/hhjnBI3aQVhNGsXGy79ch7SQtr1I73Z2VdxOU41XHzIvM0TgQ3k2m8CFRF5D9JTraobrvbhR36+ZQatsbPEWynhVgJtLzqpyytW6llG8wQn++4EC7E/mvN3IQw1CQwu+ZqAMi1rvFLqZpzhC1T2ahsm+Awh4pFRG5cMxVCv4Oc1GRwXgP5a4oqLz4DdG4IxUkMLhjMoF2yCutDaIN6vaCVg2MhqfAO1yxBTxD2usAimlMCEfKtC06WtceDgHYSRTgVPTre12Nj0X7mwMkq0yvNzptMPR3vBK0aRi5PviTcIMHxjbritw4oabcidJYpxatmEgC1ukJszI9LsOXjQl7VEjZ5xBqwcyInL3qkMtq8+eowC0xqLeQuMwQuginqCzyxlArhr+WUMvccwgw61b3zWi2UzDSdmorPtAR0KCcxlblH6Wzau6oJNQmKJNE83QA9bvbl5PankcTtqwbCAHENgubiVvM4YYb1mUytj2PnZmre0H497/HerH9Zt+g+uhDMNBij9hmGfC1hsZJUHtGQCi5MMyg3L5JIFT+vC2Fx4eHr8P7u38IKcCElhHRRlmJSxdC5n8fvCtnvN5Ok3LeSDPIO4b+MfXJiUdfTXhGkY+hGqsovhDgCkXc5T5H/rgG3+vri7sA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UtHq0e7K3HGGNi6Dc1SzETBdLwT8V7m/agZ/DO2eIr0TBpYUu0naS8U4usBgqHh92J9WkxvZVNZWCx4oVA6FneL9SkYS0S+w4drmW37c/QH11WfZddPKjJWFoy3uAUcc5WZ6nIrRIXOIRJAWGAn/hIMqoeAQNN/r/L75mYmtI1Mj1QCSlXGuTfS+s8+6YaDARWV+QN0tr1SV0Z75AaFvhcaIdEEENYcYWb7qRZAgCTWzELZOsPJJyat8iGA6b2XhGKyQEhMX4WcdhP6JE03n342K3hjrPyq0bk+RfgCN2Ye3ETGOxGG/gWZCZoX0FMiYSRpu0C3DhqBWo+GMHbVsI73QCYF9w+6rWfKTJga7F1q8A/qBvyOhLL6r78KatEc/HrotN2D/BcuAatexmDja3qwiFyhQGeMPPD1ZiUnchiS25yqfVQrhCe3G8cXAamfq
X-Exchange-RoutingPolicyChecked: NK3B8nUl71rWBE1bsmDFVEwBP1b5lKeqSf0XvizuEw36UtiHIqTfLGn0lpIgbRUK9m4lY2oenNhxzaImTZtGtASYPeN5+XexOw33X45R4siKWe6PZisSha6v8kXbfh6/4wJD5ct/0FJ2qPnC1A+ko4UMHaXVWpNuWsqPDbnNvxeLYX+98+zVULOzOlBS/2B6Da6XqiSWDx3HsZjo0jhD8/A4/WkNltt/zwT0LqyIbJz0WpeaQVlYtSzHqyU5E1xh4+azCL89/GXvdphvtgqx6naRk8al4Zl0oSDFhR0DCSfIKVfQ105xST63WPckbUSDVbelkAdl/UCAjVCS04Zpsg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:14:56.9441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f782d11-161a-4e1c-3fa3-08df0d681fc3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4385
X-Proofpoint-GUID: c5bCkuvvzKe-a57LxjQoC9BchWOFcM5o
X-Authority-Analysis: v=2.4 cv=I95Vgtgg c=1 sm=1 tr=0 ts=6a9f99d9 cx=c_pps
 a=pvbKGUK/Si0pumwNLfsG/w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=CJpyKn4wwkOrDLVWNK8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX0vAJM3IOaz3o
 X0lMU9jLLKqM5JcCdkrnmKwrAoC1wgy0lz7Yfqvlft9WIpx0+HgXu/d9bAvo4drDU25qzZGsfxJ
 N38x7hHIikAmy3dej+yhCyW0Jti1Yn6NqCdKLeBHp2321YptQHwzd84lcA37izYd7qSuWmFGqQw
 rquJz4ynI4OGUhyKCMhXgx01Bi7SPYW0fVtIQGLEe9UVoIx1bniFfmA44YI3sh0tou0rohmkgdr
 io5xS56VrRGkGK1ylEKR+lF1va0u3FigGTiw+u4oRtu+x0wfqAX+PkZYZP8Ef/PETnol1C0qCUc
 FkGKSAb3rtYtNb6rwBXWz+o3DIVZ5l//Y4oStdnO22CGivjeZ2y4zubIuGSBpaEL+51oV5gA5I9
 //us1xwSEl1H7GgX2SOKZs978FQK6KHh6X3fzvOhqgaru1hqcMm4Mf0J8Rdp87Chw1kzsjH7uIj
 hDaJHnP+eamFtBMB/Cw==
X-Proofpoint-ORIG-GUID: c5bCkuvvzKe-a57LxjQoC9BchWOFcM5o
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfXx60xxYsEmmLu
 wuUjIMVAaMVnr8Nhh7w2sRZA1XFcLMSv2zjZ6viE/AfSILzlFwXlgSFq4oMZ+4eB8OUDRQEdXDs
 BWglMhMwiltlVyHsdQMme0Iwpyx0Cn4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080055
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

Since the device-tree description of the peripherals contained on
daughtercards that can be mounted on the base-board is present in the
device-tree overlays for the respective daughtercards, in order to utilize
the functionality offered by the daughtercards, it is necessary to have the
device-tree overlay applied for the current stage bootloader by the previous
stage bootloader.

Two such use-cases are that of the PCI x2 Lane + USB 2.0 daughtercard
and the PCI x1 Lane + USB 3.0 daughtercard which provide PCI and USB
functionality. For U-Boot proper to detect and use them, SPL has to update
U-Boot proper's device-tree by applying the corresponding device-tree
overlay at runtime.

Hence, add support for this.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

No changes since v1.

 board/ti/am65x/evm.c | 76 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index b35a9229033..1ee7ce5e30f 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -126,6 +126,14 @@ static int init_daughtercard_det_gpio(char *gpio_name, struct gpio_desc *desc)
 	return dm_gpio_set_dir_flags(desc, GPIOD_IS_IN);
 }
 
+#ifdef CONFIG_XPL_BUILD
+/*
+ * Populated by probe_daughtercards() in SPL and used by
+ * board_spl_fit_append_fdt_skip().
+ */
+static char spl_detected_overlays[1024];
+#endif
+
 static int probe_daughtercards(void)
 {
 	struct ti_am6_eeprom ep;
@@ -133,8 +141,7 @@ static int probe_daughtercards(void)
 	char mac_addr[DAUGHTER_CARD_NO_OF_MAC_ADDR][TI_EEPROM_HDR_ETH_ALEN];
 	u8 mac_addr_cnt;
 	char name_overlays[1024] = { 0 };
-	int i, j;
-	int ret;
+	int ret, i;
 
 	/*
 	 * Daughter card presence detection signal name to GPIO (via I2C I/O
@@ -242,9 +249,10 @@ static int probe_daughtercards(void)
 		 * Populate any MAC addresses from daughtercard into the U-Boot
 		 * environment, starting with a card-specific offset so we can
 		 * have multiple cards contribute to the MAC pool in a well-
-		 * defined manner.
+		 * defined manner. Not applicable to SPL.
 		 */
-		for (j = 0; j < mac_addr_cnt; j++) {
+#ifndef CONFIG_XPL_BUILD
+		for (int j = 0; j < mac_addr_cnt; j++) {
 			if (!is_valid_ethaddr((u8 *)mac_addr[j]))
 				continue;
 
@@ -252,6 +260,7 @@ static int probe_daughtercards(void)
 						      cards[i].eth_offset + j,
 						      (uchar *)mac_addr[j]);
 		}
+#endif
 
 		/*
 		 * It has been observed that setting SERDES0 lane mux to USB prevents USB
@@ -283,13 +292,66 @@ static int probe_daughtercards(void)
 		strcat(name_overlays, " ");
 	}
 
+	if (!strlen(name_overlays))
+		return 0;
+
+#ifdef CONFIG_XPL_BUILD
+	/* Store for board_spl_fit_append_fdt_skip() */
+	strlcpy(spl_detected_overlays, name_overlays,
+		sizeof(spl_detected_overlays));
+	return 0;
+#else
 	/* Apply device tree overlay(s) to the U-Boot environment, if any */
-	if (strlen(name_overlays))
-		return env_set("name_overlays", name_overlays);
+	return env_set("name_overlays", name_overlays);
+#endif
+}
+
+#ifdef CONFIG_XPL_BUILD
+void spl_board_init(void)
+{
+	/*
+	 * Detect daughtercards to allow board_spl_fit_append_fdt_skip()
+	 * to apply the overlays to U-Boot FIT image itself, allowing
+	 * U-Boot proper to enable and use the peripherals on the
+	 * daughtercards.
+	 */
+	probe_daughtercards();
+}
+
+/*
+ * Mapping between FDTs in binman.dtsi and their corresponding Device-Tree
+ * overlays. Depending on the daughtercards detected, we conditionally
+ * apply the device-tree overlay's fdt if it is packaged.
+ */
+static const struct {
+	const char *fit_node;
+	const char *dtbo_name;
+} spl_fit_overlay_map[] = {
+	{ "fdt-am654-pcie-usb2", "k3-am654-pcie-usb2.dtbo" },
+	{ "fdt-am654-pcie-usb3", "k3-am654-pcie-usb3.dtbo" },
+};
+
+int board_spl_fit_append_fdt_skip(const char *name)
+{
+	int i;
 
+	/*
+	 * For the overlays to be 'conditionally' applied, return 0 to apply them
+	 * if the daughtercard corresponding to them was detected and return 1
+	 * otherwise to skip applying the overlay.
+	 */
+	for (i = 0; i < ARRAY_SIZE(spl_fit_overlay_map); i++) {
+		if (!strcmp(name, spl_fit_overlay_map[i].fit_node))
+			return strstr(spl_detected_overlays,
+				      spl_fit_overlay_map[i].dtbo_name) ? 0 : 1;
+	}
+
+	/* Any overlay not in the list of 'conditional' overlays is always applied */
 	return 0;
 }
-#endif
+#endif /* CONFIG_XPL_BUILD */
+
+#endif /* CONFIG_TI_I2C_BOARD_DETECT */
 
 int board_late_init(void)
 {
-- 
2.51.1

