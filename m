Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2627DC98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 11:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB704606C4;
	Fri, 25 Sep 2026 11:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pqqTCM0qu0Qc; Fri, 25 Sep 2026 11:08:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1B092607E4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790334513;
	b=QRT8ha1+Eeag3Khz4H7jn+tPjfLiJDIcaq8SYUU9DKPBQdOWHL2ecfxpoF4oh+kOMnWV
	 SRLrgmR0oPE0unIzy7K4jjstQBcTV/lgTBwfTY92gPcHLR0C3/gIGS+t4a6N9OjDKmwQ9
	 ExeN+Rscn43YU3c86IqqfhyTDxvOIxlvse4KQQlfHWb4GU6VYxbF7cgJEOxOupqy9HGyR
	 u2T4dTJsb3AsOkyGuZ0UfL2hCx2DxZ2y+WLda6sM4CN3laITYvNDQGnZShpN00fB3cjeX
	 d0UHoXl93rzulKomyrpBE1dZsTwDjghr8Un+sWUcx9lv+stFE52COYsFMuFlU4pujDg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790334513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VptjT1kxhAYs/cuQKK9Kb82Ifq3TMOwzeEfmVY3xf9A=;
	b=nna5J7NCx+FX0+o/ENdoJ2FCkfeOlJZboGoipKpDv9LePPhakrtcUOA7aR3hP5y0Xgou
	 OQTSfnqq2Q7qRBziFC7jTypoeqYi0QrZzpsd6CEAjujRNqweZsQiYoReXsHZT89qzRX+C
	 KKauNP06lCi/6uCDxsdE/w8TbFQFSgvtUDoyzqPtRGMVXIb9V9jZhakO8YsTW/5C4BVif
	 LQGBg8ng9ykvIb0+S1RYOEX1DuNTG2Mmx8EF7nl4zn4NOTLULqzW7QFzv9XfQvfff2GQT
	 mCZAoIb6/xcIW9PMXS3NnFHAH5KeQHgRqGSU8X7OroiIubGtYI5SdCwjegG57qwb04w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790334513;
	bh=VptjT1kxhAYs/cuQKK9Kb82Ifq3TMOwzeEfmVY3xf9A=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TKGXCk5nXv+vRx88a7ckH1C+/oiv4YWhjk47k0RYW5483nSnmrCd59x6HUTjmHn+8
	 ye9Rn/vet0/Ex5Ukqtz8IZEa2KN9sE6qXhtdcYkDICiT3rGeGmuCPeL2l0OugjXZPr
	 0RnmUskKCd+Mws02od9Tb4FAltt+JqC0UXkbcOp1x8xBgPU12j49azgFuJ7CovO2xY
	 PCbVLGu/uScJlUiZgTb6Inl9jkSdLX580ZAi06sbOAQgWAlDFpbp3E6tm8akpTedye
	 1/8Ug/svfyjOkYN8PisH/+h1wRGrV0wpvf4aDcDWMscVD809t9U9f+bbKvXQr1BBPR
	 3us6IBy3FDC+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B092607E4;
	Fri, 25 Sep 2026 11:08:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F2E5334
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34912810C2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:08:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fn77KeeD_kIJ for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 11:08:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3E2FB810B6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790334510;
 b=iZi2s/nY3rEIuHiLXb1uxBpeTwHYR67U6Dm+cPVEowXMksAo1NDlLXEXph0ye0xMaJns
 N8yv8iZ6AsTB7WqHzQaXcEOhdQzICiPJu4PZjVy52+elBZMBfnN5zg46Uy4foEPMxJf3d
 02+Iro4nnH6LXD9m130czpD/40L9+0fB5iTrWbQ4rPSygy2tHEJTHFiR7Xtg6zJHpwLcE
 W1HCbzHxOfsCT/jEsZROFzejvaTjZWoZqZHSJuWdx6Ke4OAujXV+qMVKp0xreeRzey1Ex
 U3yxe3ktaUmAtn475+0H5UzUONQTgvsw/hijrEIOnY/quxCYlzaP2Bn+8yr1i17UKSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790334510;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VptjT1kxhAYs/cuQKK9Kb82Ifq3TMOwzeEfmVY3xf9A=;
 b=jQ6u0u4n229j8KE3DZj4vx7yyNHN4pBsZk0cmNI0h1Gb5NijjOz3ltEPrYFz3UMXtYmO
 iQHFGGQBZsDcm6liCoJ72eoI2H2wWrW81f2lAU0thdiHZX/zXAxhfK1njBbrECFsjh0yz
 MCkb3dkfxFkTRpsq9UFnljhPESDcX12aufvduzJhvcNxymICtYuMpEkKuI5wpilGssrvg
 FGYxJ6/ShfamXFOTWR9D2YZJ9LY0clxHFK6V7/Y4JRVSEgyu90jmrO6wpMPPQHSE61kIT
 RpcOc6+bP8WItDy2Oqmj3KZKrN8syS6ntznfOp1H5JzygPAeGtO8QLUP6zEmS1/tv+Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=HHffGRuO; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=J6KO2dBR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=c-vankar@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=HHffGRuO; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=J6KO2dBR
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E2FB810B6
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:08:29 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P6G3P11848365; Fri, 25 Sep 2026 06:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=VptjT1kxhAYs/
 cuQKK9Kb82Ifq3TMOwzeEfmVY3xf9A=; b=HHffGRuOk6a7pCoX6wGBBi9MS7rCE
 dtGWS6Q9NXshYW7Rnky+wsY2OLEXDNV6WqbXHWEsqFHFufZWr1Bgptx0IvnnmMAd
 +XkfmT+ktu4J4jXNrNPO6/iDCsWrM2glAnBHQhMZUL7xCFpumYuq6S/QEMo6XVNt
 6Uw149W90WYgo9JTp7XWTj3rOaBdLqEcVu1cc4LezI/VHOqOMCeURuvf1iW4iL23
 kmNYYwl7ORJ6rSlZFfAAnIGIqL1AezjgzFiz2UdPv5oRVEfJjqCZGazLOhsg1gdx
 Kkc3Ajo4qx0Ryn9gEDH5jPXQrw5x5gfrcd+4pfAbstUDN9BrIakc2J3qg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gwkhr991u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:08:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZR4RG4z55koTr4fAciqX+Y6XcMV0rXGVZMN38afMTBBI7E5Hc/I5dtV1+62hwR3AXiwpyZLDnHkEhyy1j/r3ZfwVjiERN3uBjhBOcDk1arkb3R3RowGuTacO1eOd3O2TGB9ItvK3UZwaZCDnCJDCygDOctxTZxbRaF+dHf1zC+xksd7a1+TibC+yMkRbabu8pPqfMJgiu5j78WZ9cH2rgfQQBmvIlmeq1xMTEt/iTTqJLZ0KQoKLpb6DH1PKPke5rk51zmxSWluuGy8rw0equzDK8O+YBn6xKhVBHz4wRDZpyoW7mWJuUSCswNeKZacpcNYUEpPO0u5LUOoo4UALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VptjT1kxhAYs/cuQKK9Kb82Ifq3TMOwzeEfmVY3xf9A=;
 b=vfi0KBzEtbfrBL4Cs7NssOj8gbhD8O/xj1FlOqyB35M/VMzskJcIlQOIRNJCnYsPU2b1CxKF/zfwVvXRHmIN5lhsuglRTM2JU3yDEtUSOTGLzVqh5l/wqPD7/rBErlFSUGMVE7VEZkcl+zXuP7oVm15t2IUrH29JtILswiC8gOF1OwDGTX6z/vAURqiZElSB6vIEnRVCxrzZiCcKsD0VCOBtUqqDru9sWwV3w8l/MBhJ9PM78F9RMFY285OBeKJiMqqzBA1YEqsxrKy6zdrGsycKZ879/LuQRWjmlvEWIIAn2aJz/rJqX/WTJ2giemFKg0hBc0/wzaEgzbVA7iBOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VptjT1kxhAYs/cuQKK9Kb82Ifq3TMOwzeEfmVY3xf9A=;
 b=J6KO2dBRYE107n1UGZCXpaT1oBkcEIQa2WRvLxujnt4d72D/2xXPCePc6MBSG1NeIEKb3WEeIVXv2r4PHEt8IoUUdGirnSOgAIbN1xvOEvrr+M1NTARcw/9BPJxicLdeOpwlmBW2Iph/BcmUzjfWT+ZY8+lG2teH1S/7qGS/HBY=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by BN0PR10MB5112.namprd10.prod.outlook.com (2603:10b6:408:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Fri, 25 Sep
 2026 11:08:23 +0000
Received: from BY1PEPF0002695A.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::84) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Fri,
 25 Sep 2026 11:08:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0002695A.mail.protection.outlook.com (10.167.244.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:08:22 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 06:08:02 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 06:08:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 06:08:02 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68PB81DX2648402;
 Fri, 25 Sep 2026 06:08:01 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>, Tom Rini <trini@konsulko.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>
CC: <danishanwar@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH 0/2] Enable NET_RANDOM_ETHADDR config options for
Date: Fri, 25 Sep 2026 16:37:56 +0530
Message-ID: <20260925110758.843871-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695A:EE_|BN0PR10MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 039fb986-1123-45c2-4227-08df1af55057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: rwrfeeBbS8wD4uaS904kvigxWXinlROn+6y1KTLI6XK+8fE4UquijcGucfk+RNP0Sj7QQH16sSeWwfhb2n72qhirENN8Muj97ZGAbaz+Ci9rNDUAY90PKfLhdQash91AieL4hQrsY/7bCUIfg8eVSzWkgWR/kb+uo7lbNQ+JSBNw2gyYMP1vWRvBPKwWXrx9u3x5xqemoJm04t9WtQVoTO6415wNmC6hdRWXe52zP4MqkvBT4xgbks6RvKdS4Zovs10w4MSTNxq8IHma6LUWTYkeiVrtrqf90sqsckr2qEuyHSGZxZ+bbDSoBvWQz1sQO5dqQ8RUx6kxmmw4SW4WtVthfUCqwZ2van5k64hcUbSypT9qMzrd07uC2eiiSCtNMaNoizhTUg74ykafwO6OrzrQpLBTBTWkz6+bEOFoAhhWY18VFcX+j6TnZxA72uQ3S9Wd6+NhVWiQqMESuEo2AFlISpkoofERSR6YehHlo6zTIco9j00jV2AYADHD9t7au3BfHRcE9xJ1oCIKn6e2DvbEmjftmx7PhfYuXZqD4MrAZtpgTqc3k7zIDNqhJ21Mgm7YTlD7pq6ZcMxP3Pn6U0QanT7pvrlqKH5MN3ZGMpGilos4VvBW7IqsZ+K2SqNwiGzBxy79MP7xHCdlVAstia6rM3fEPjgl/tITg0YSxPMnDEgp69j0QgI/jl8XFisBtsVq2ENc/Ai4LhSDxq6r8g==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4kwT9VLxrZ6yaecZxdIHnHItXJnryFaG3WbzSffFDfCjTkoSfeJuYAEQ9J7RG79PMMQUHyd/uaN5H4pQPqOkL/EPax0AFPCXToZNisVM9ZQGjjfEV/wxZ++Zm3equ8UmKi8Jp9EhiPOtkjZrSBCjefKzY2zph1RQDU+1JuQH3VrwIXTSOtLpg234hzIku/DKYEZYhOfn6ym/XBpz0hvMxaWwWWc2IO6usNsYBmul5sK/Hm47GVTK7ehhSn6Vv3UvQuz9Zu1Cn8op4xaqwvbFsM4KdyhJnCpcpgDeWpBhLYY5M1thlCqtx128/CoDCmIzbWU/PWNB+705nJmmp5WTimPE4swM+/pXXk0ZAl9RECox/ygFzEwXRYwTns8GuE43bA0vC2gRpaRz9CKlaaULWDtgnLfG3sE6UwMH9zBG/d7WlnQpkj8St9d1vmMXV4t1
X-Exchange-RoutingPolicyChecked: uPx8Wm8lEnP3YKMhThMk3D8dfoDxEqZCuvBzapHXJ1OMags6RKz0TkqBxOfPO7Y25dByz1vlRBx/sd8bkN14K6udKnnCFAImv8fRosOqJTzMs4UdbKt2yBlqPMRGVAkhZRbXZwQBhyK/o/Tr5drQ7NirFjCY9byLG3A0GHVdwwMayzhEqWR4dZnFIpH/Tu+inD6vkVL04aMXuCvVsVOqXv4oKriIa5oA/RRYpTJofTwni94N8ZUO6BAKSDseWUcjb9/pS85F2ajXsiQV3D8FPmEomCFWLv/LLHp6kjXrM27BllDk30VUX55MxCd8hEVJzac92diolTqJWhBy00Hj7Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:08:22.5725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039fb986-1123-45c2-4227-08df1af55057
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5112
X-Authority-Analysis: v=2.4 cv=Fv+QbGrq c=1 sm=1 tr=0 ts=6ab6562b cx=c_pps
 a=3isWwmYGSdluMw1j68YAZQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=HJJQh-ng3SVff65beToA:9
X-Proofpoint-GUID: aGNBHeuCd6HXJtcQRAXaXQQtCywsFzH0
X-Proofpoint-ORIG-GUID: aGNBHeuCd6HXJtcQRAXaXQQtCywsFzH0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX8CMgg9FN/4WT
 Dn7xnQzCsfN3RD9gRed3bQCLhjrrzryCwUXLILQ9sMhPYHlAN6qV/ACDUtaqHf9gLXHNOj6SX7X
 PKV7xlmbEKEfBfVv0To9azJzv0JB8Np3VPp4a3aMhJMcpzGk5Zk6HcYlhic+cuPQ9IV/4Ew/7Gw
 Ucy67t0ZPZoGd9rTDZbffhU5I2Wq/SQFICWcecPHyBE3+tZX3x34eMTsdXk9dDwlYHThBsbz9hR
 bz706GF3thjJCn8Nh0gNYKjap8GRavhE0mToAEP28oUqiFPCeGMa/+qxDUX6H7usFd6Z58PqTi0
 +GtaBilSCD7l5gsFRgPtPzeLUjPbtNa1aCjyKW3r1K+afWBSoX/R6twekR3pSnZJeC+DLiB0U4w
 dDPNQIHpxTF57qZpX9rZvxiZ5hBgj/Jh1dtgydh/WifKlLT0jjK5I2al/j68PCdD1RAqP2LdI8t
 FzCHPKIbPy9/YMshYzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX/RdpkipjbA+7
 98zpyLRewKepA/OPjRX78QRmYnjn1VAFcahvxbDXP+PGBCm67PLUHHhUYPi1aAO9FQutbrxj2oO
 zoQj0Ln7LqHFOPYKJ5m9dk1Gy1oLU5g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250044
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

SK-AM64 supports Ethernet boot, to get the MAC address during R5 and A53
stage enable NET_RANDOM_ETHADDR config options.

This series is based on commit '9e002445cd0d' of origin/next branch of
u-boot.

Chintan Vankar (2):
  configs: am64x_evm_r5_defconfig: Enable NET_RANDOM_ETHADDR config
    option
  configs: am64x_evm_a53_defconfig: Enable NET_RANDOM_ETHADDR config
    option

 configs/am64x_evm_a53_defconfig | 1 +
 configs/am64x_evm_r5_defconfig  | 1 +
 2 files changed, 2 insertions(+)

-- 
2.34.1

