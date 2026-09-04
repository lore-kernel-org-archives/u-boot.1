Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C27C624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 12:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D63460BBE;
	Fri,  4 Sep 2026 12:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ONwD58sL1AVf; Fri,  4 Sep 2026 12:03:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 26FF860738
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788523381;
	b=fEquGOWsx9upq5i6r5wgQ+qXd6+zvDcdFPPrGF/01q3D6pB34jxsGNXCjuIS3d624nhB
	 E2nRyC82Csjqf9Vw/H5or7Wy5ogUpdcWIlnIJnD4utqA8KEjEQml64g8ejXrA209soAX3
	 a1pwDQVBrAUSJlESRUlTdDmyGvfnojr+Pj24V+4P2i/1Cklq1b5n3WflxMOoq65bamJMI
	 6FLQSPTwOVVNtc/kZmUs0HeDqcS9Z7q58LklTfcQkUXjxXSwiK/qIdFt4vvhQD3pkboK7
	 jO2TFgX9HLagVt4bmzvFnJVvURQazRS+I7MuCxXUT6SPyyWlyXP1SELbqYtj+TM+A5w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788523381;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CAY4YT/kpa6nf1GnLEGDs6S1zarPTMucfVeh7QiHju4=;
	b=PJrtI649XcrUasoC7QSFmZrbgIzj5xiiJ6iQcGpvHHzatEGWoIZErLU5cdR+EWbfpPe5
	 BRrZFtK0Inm8VvWpLq90bev0WmONJasd7B9Lut5eZT84qnpgkoF3AuNlGM60jN6Zjcdxk
	 LV7L+CLrV2Or0ez5mxnn0edMW5Z8uVaMTC6ECFJiSKsl3iaT9Iq9qaWmq06hDLFgbbxYU
	 jLaU/hRWr3a23oLMO7Qaod+9m7K8V2ighVTLHgPmxArVYhKC5ovv/VT6GMTsWhvcxqikp
	 61YHjlZQKoN4Sa5xJmUJPrFWzTXoq4xO0j7W/TqnST7h6jLdjmEMZbslFEIFiRyiPDg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788523381;
	bh=CAY4YT/kpa6nf1GnLEGDs6S1zarPTMucfVeh7QiHju4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yKXEh/ZUU0wuYbkSgRTUwBOLSo2GPYl4hCq+RNXzYtGB2VEruymqndR0vh99EvBCa
	 nII3ODWbknETMQSldqfJihRL28JKqYJrqKA0PkCEHOkMlj1m2RdE/pO8AtQjNOIgC/
	 yl8yMPaimfU+pVkfBQuhjkA64NmbxJzbe7ckNR++Qwu0CP/N/RSowQGjwGIJCC27Yx
	 /g+xRM4l8Pf/KK1z85gpUrC7vafbsEXoioff9YbgLIodL5gErAf/vWYM0uoCWTQ0bn
	 c3rYSua9OWwBh/e443ORDhB4JKTTAi4BiXba9lijczM4AjDIxY2xOPb8lQkLgxXlp5
	 KBgal8viqx6sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26FF860738;
	Fri,  4 Sep 2026 12:03:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B5EE363
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D42C40B7F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i-RnLl0ASEeF for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 12:02:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C581340B28
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788523379;
 b=ZcH3qxr3uG3xx1vLZTUD/jZfNpooR/CHTxH9gYiO0iRoJ08xxhuYFuHQ0+q9J9BCvT4v
 tSW2WjG0pslZW4vjGRhIn0IW21ZwObhZDQL9Rv3wGZboFtDReIADlqJfNiYV5VBfIwEmW
 aIsjvuEvU1xn4dh3LkDSv1UY33hFfO5J6upsSGK1bM0dJx+3m62z4dPIZ+fKuXhvFaXbb
 tWOSWzjJXJ21JPQa7+sxj2gotvUKznntIFp25cCmaUJsY7TQZw+/hG09m996lfAYSgdlR
 pDFeReKGfI09BUUEnhV+pH8w3Z0n/z73awFsYW1UjVdpMfwTKI1ehgNM/pS+zafXCnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788523379;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=CAY4YT/kpa6nf1GnLEGDs6S1zarPTMucfVeh7QiHju4=;
 b=MhoE/5HWhuAK46wpPiCEpLN8i3nrljWI5xQRWzxYrXRWIjHgetqBcO293kqEzmAfmue8
 IfM5XDi+djQAoVy1RiweVXJKHEabEhDFhhLV8byJiHvkXU6z+R40vtffPV5eYBSJTTHT5
 pCk7/dS9RL/dfQonls7Dh+3NYFT/LW3rEM41/JsCdY+tjMM7DzvYDBZMaScQbTl3YkBso
 ivz9if/u922eeXhPd1ZziQtFa7BQrd/CEOl0rkTkjUzYn/GSW/nvYpySB1SDmlhf8ojxT
 SD8sp5bI10fY6gJ4VDppAZpoa0sPKc3LpWDctgtLuKe6LNnScp24B4mdOqEGN1x1hWQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=nJEQefNz; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=xTBTbhQR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=nJEQefNz; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=xTBTbhQR
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C581340B28
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:02:57 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AHoCe3238091; Fri, 4 Sep 2026 07:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=CAY4YT/kpa6nf1GnLEGDs6S1zarPTMucfVeh7QiHj
 u4=; b=nJEQefNzCldQkaW3C9WXvUamwMbo9Rt2DD9MZhFm7hSh7PcShPYdR/P+2
 ML5zttSegHY1hIh0lt7UxaxKqcWRnjnqyKEP6wI20bolnb2p8T8ZOJRZrvP+kEvX
 t8aHQHKlNHlTWD3jk7gAuzEVmXY39Lg+5I3vA8bV+QL+N7qpPQGrL05m3a6YxGDR
 hUqpqDyQjnUpUsB76XwGn/1hw4C/mLLT1VhwvYMwC6nBVf4iVcEo4+D/B6fCAVYU
 ygiAvlDg6kDhvnOgnImpkA89c1MF/PdHpVBK1x4Ja0oieXjKjpLj8p6HdP3fdSoH
 zj6qCYEzpkllVmNRK6CNsrcfzIoIg==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012059.outbound.protection.outlook.com
 [40.107.200.59])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfu6w8swd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 04 Sep 2026 07:02:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6gcA9Rh5XQpiLCfXJn0bam9Q7gmqdK3/lexWn1cLw0NJwFA6Ei7oyZnSogSvdtp8pRL+LStt4ng1kXtwjHoz9C8Q6awxIRuzfPIZquUAl+11IRgdVF/7tQcN65tW+81UVWFHF9fWtH9SBkZRthVCXe1QBOjC8W+Z84JYp5xMu2MMgc3l3gO36MgwjRhLoPQDlagcelP/GABLyfmeDXQTEQSNTBGAr+4sMZaFKQvz1nKjT9ejZUoZdJPEizxi2ly+EcwnTu+Gcxh7jts+1O7cwVSVY4JbZeFQhWo9MOeKsTe6RTpmno6C/YUyzCPo67UUDbFj+c2lnDwDmLS7b7LvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAY4YT/kpa6nf1GnLEGDs6S1zarPTMucfVeh7QiHju4=;
 b=vg16SzlZy+RO4xZE3rNWDcgpRZLY3t59gdIt8YrK0JJ+dXTrXXWVrH2mpKVsnc/X9cSgZHFsMcFPs0sxeTivtkkSc6JroXTVT+OB2uNAp7r8eSit0sPozIwTFR+GRoSF5EhAHoPW6CTIVm6tWbgO4hW/3UVepICxocH6hZcrrkI+vdI9a3EV2WdxiS7FUSWOWw675WapvdtXBjx4Sjb9GlIE5MLZnv2PwsBPdU+oIHD/k7YBAoEBURh6xwhbznpsnzNovaLc3M2Qqjmc5Bbr0nhbeiF6RQCWhfAdFN1v0jlt6Dt3xxFCSMJUQV5IdqWptTu4kralog04WQwj+Ouqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAY4YT/kpa6nf1GnLEGDs6S1zarPTMucfVeh7QiHju4=;
 b=xTBTbhQRGtn7byipHSepATOzS2mREBfTfHHsf+isIe/35HqPSOQJuXkC/MjegslHDX7kjiS5gzXmrbyh8Rk3Xh/DwjBYrX3B92bxfinLhxxtuXU38h/JfoWTi+YRQdHjlLnltiCRlu4MoBQJ4NGj7+ylW00UoH5CuGWc77sBfKg=
Received: from BN9PR03CA0227.namprd03.prod.outlook.com (2603:10b6:408:f8::22)
 by DS0PR10MB6774.namprd10.prod.outlook.com (2603:10b6:8:13c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 12:02:51 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::95) by BN9PR03CA0227.outlook.office365.com
 (2603:10b6:408:f8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 12:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 12:02:50 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:36 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 07:02:35 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684C2NcJ3456269;
 Fri, 4 Sep 2026 07:02:34 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 4/7] board: ti: am65x: evm: add support for SPL to update
 U-Boot device-tree
Date: Fri, 4 Sep 2026 17:35:53 +0530
Message-ID: <20260904120604.3612484-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260904120604.3612484-1-s-vadapalli@ti.com>
References: <20260904120604.3612484-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|DS0PR10MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c987886-be94-47a6-f926-08df0a7c7173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tNrPpJWmY0xyAhZoZxpxcsOHtuOG7iVI424akdZlHkVVM9zXeL6lYwBghYPXfWpd4KCU0Xa5+lZeioY4sE43AF23vaYGwDNsXAmxlSVia31x5EmKRWcxX4bpJ5uy1KE0K7ND4euW+8rZIljzBIiSgZbcOXCuD5cbUOwaSc8jUF318y+kp6mgRJgrLV6IKo9dBFsPgZFG6pM9yqR7sEpaHXESQJ38BhF52RwtVCZlUcB4lWCUHfdrM2xzNP+iB7OjlfyFTZYowy0nCjyJtda476ySyrFrBLnta07t9az3/69NRTAyQVROpeLLkUm2zibwX6WrZZTzviOustB6xjAswgUW7yZy0GZzCRJouC3GVzWMhKQkFAqY3lbh7ubBiQNA+IJyD76FyldAngx0g23FYEQ+uZ/3iwsxyNO4k//Ix08kbkI/Rpe8HfCVQ+AwibP6IxK398678cCwfmyWiNIuV5iJMcWGTuZZOM5pqc0kbFItCN2spCx962xBtwb00r4gjDbF5qvVE9PYdY2LzylYUBjNmZEqHkuFGZGbjpNhLGSa+hdtfKUUxAbD3ow2l7H0aHw3DljuyByeZsse9yEFnUASGrNwN0Wcs2upJnz0m+mw52bXm9klrbp9tXlEbyTy90+QWX9r+sWLbxZPcR8ITQBu9Hmd8dVNtD9PSTuK14uKnIohHEwRfN7UWerJ3dqn6OoRKxHljkh5C1KhvfzU3Q==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LzEXWqSz/rNp2sZDmR15Xtv6aX5kAvmsAKz1Bc+wpH2hUOGIFCdzKmPEERZdxi1dy7b/01ZG+FJORSgqKbjpnCKTD0imXnut2YswyqOKnaAsst5Gs2xSmtZ8bobJWLCNxxCdTpj6eYoKEAxuvm0M1+P+Gxefn5ZTaVDQd76vPX70SudhLwBQ1Q7JeNi6KcrZyFF7hyZSOyINlqqGwuipSxykZ+rPaLoe6Ui7o4R3Mn6ppfBI3rRRmBGaq1d7emWkOE2MmEN7N6BP7IupaPYpaMZmw/zAVxkqz6uc4qvOySQOUn0TUF5B40mFi58HZTER2A+vedr7/FIZjNPjViot5qHDHgSZw6x9gpNgYPwSbDg8R5VML2mHXi/luK+nV3XzOIDe2eJwHSc+f17LPRot+zQJUETS+r+g+/agJ7p76GH8ca0wi75+99uq5lgqnkmK
X-Exchange-RoutingPolicyChecked: ilYcnuprPKnmnDRP6PPksJ6J2dnMWI2vhvyCuH6ByrgJKZO9aXuuG4rbc3NrnNmwQ154tmW+COkHN/d3yiQQzG5DXopp01ifTXQonF+kzZQyvVsKwN0GzutDvOg5s6lgnMZwHq53JujKUP+V4mVnA9ZVHint1oujfqDXkcgR/M9ucCZF3uu8FRfMDGH9e/HGCf+olExJd3Yu4/JV6XuAgPq/NOJAgEZ6ze/C2jDOlf2GjlHcHRimr5bu995SVFh3lTBi0/1KCzi65u3kJYs3Wf2HDwFVIpbpD+NWFnsBbkBjFEFPL5sXcepcZC4YsRMm7CYsnqYRFLGwsKQMoK23vQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:02:50.4375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c987886-be94-47a6-f926-08df0a7c7173
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6774
X-Authority-Analysis: v=2.4 cv=XLoAjwhE c=1 sm=1 tr=0 ts=6a9ab36e cx=c_pps
 a=+/t0CT+QaJpOasvqRK9qOg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=CJpyKn4wwkOrDLVWNK8A:9
X-Proofpoint-ORIG-GUID: GqHBbSfHo45fz4ya7zyt17qcB1dZGVx1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfX3/Rb0HM1UlxF
 VxyuoXMYzMRiWPiiDSePrepYsogu2FEX468+j2i7ziYhpcCJKJX+o35s3fj1H9KSNtyj+vvjYx3
 uasoW3/FFb7GHSWsUWy1lv4XuB+GwSxrEmEgjQl/+s9SKVIEspqrB2PjiC1gBH2E7Rhywf8D9Lb
 NjOuQG8I+1EAs0nbvSS4w2D7FVrGnq5E4N18VT8v6a1cOgV93ZvPzge7eSeobmgTb+5XLTu1tp6
 4sg9MM8Wn0O2Rpd1AwNliobc/HNCL2JM1fLQ0s0GUJbq7ETI696ks8D4D4bjgmTcr9leh+7rCwP
 Y4TXcXAQaHpLY2OasNvvcOGmRW5czlxtdUcbOCX2NVaqnP4rQN9YCkspJX4wu+pAE5k+pby/5rO
 ZgbDJz6IkfXwiJ59ejURHI525He3g7e0k6wpUfOp3yziwbKReMUmHSAktlbqmf9jqmSm20mTGYI
 YIlRiR5Wxgq1b5c6Rtw==
X-Proofpoint-GUID: GqHBbSfHo45fz4ya7zyt17qcB1dZGVx1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfXxzRRAPXhyZlO
 ZsFmSEEHmAV53zcRvJdsbVoUsXnsaCf98O1MMYdUIIERbf4zU5fQpYsRacI49ro8RJwBpH1GLgO
 IGaa5JtVlLsj/xL1JbECn3kNei5/fcg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040107
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

