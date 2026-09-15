Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971C9C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 04:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F11D260714;
	Tue, 15 Sep 2026 04:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MlgPzX31Kuv6; Tue, 15 Sep 2026 04:20:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0A4AD605EC
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789446008;
	b=U3RRE110KnW0KMUuRlGzjMxDqxCW3KevBiEloQ4iU/sMvywJwNfuvJbZB687c985CMfS
	 y+Y+ILI1VLlD9DfKIQDsFS/GUrgAvv5tvrNMGrB7pjB2D2xo/gfyT3A8YN/z1OfJ4QGsm
	 zNf0rLemo+egQ1hDE/eVL4F41v4AwYBjV161bRiWlct39VJDliqjda2g5OAoS+LD/Mgvd
	 U75Ciz0AGJHyzFvM4zfDa6FpyFKRPRPUKvk6U/zk13OednXb7o5q42LM8xjop6Wurotvp
	 rPzB0xFMh2HNnJs0ymSxgsSAe0scv825FerC+/sLlvLg1d9g0GmzJ46E1JBfZ/dL8Fg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789446008;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OfPVNOzHO71rnXlnF/2XdpRZJPZG0AV3JA4Lnu2PZFQ=;
	b=Vpez6EsdQkbzk/84Dh3XmUjcvOI5LjDl2a+7x0b/Yb/BKkLtCDsTxVYBYJiou/60SE4N
	 WdGYKz2kHmo7DUkynzAoWtwbCksjzAsLEc7HlLykjE2gVVDZ3j1oMEiQr2xBAtwYzUpSH
	 sfxZM4etHdqeXI52iFIzz0eXjN/4UJxmHItc0C/M6epwOUqFQM5xCOMVwT0a5Q28ZvGYp
	 4B12P2MYaykNz4cdJ9q9yvoTptwu/owCHtnsUPY9s6TJk/iOhzCmWDZkNUEEaSbDMWJP5
	 hCuB3HcKE2nYOcPyxVmtcEvm1H1pZ5YlEu2JTxBsjkUCn6GXb0QKlPh+pEqlVT5QzWg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789446008;
	bh=OfPVNOzHO71rnXlnF/2XdpRZJPZG0AV3JA4Lnu2PZFQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1EwKopQGLCxSRQ1UEnioiic+3cUh2cAM/cr9KXvABpNTBRVhZN65WgvIaqJXh7az/
	 U5jjz/fsryZtATgjEVWWBUprvE14X85HKsmR4/D/2dJHFsMMom5Y/++UJ+4CRU7Xpc
	 145xTb/OdS4e2rUEGjvdxF6nO1R3BX1IfPtUYJ+VAIMXoVhzxZwslK12090SrZkPaa
	 lwKPGFPhYrhhwuKjNn1uG0eLEPEnApkmkVRrJgQKGx6ypkkfiFhpy0dKuEdMWhumGf
	 55oLjM61VTGgV+fsCkFvKHrCc30di/nXq6yu8t097BJOhlc9YOGZpJCKlf6BuRSiNb
	 I1ps8NlYaIhiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A4AD605EC;
	Tue, 15 Sep 2026 04:20:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EE6A5224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 04:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4A0640544
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 04:20:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tcDVya_qSwNZ for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 04:20:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 06B514052D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789446005;
 b=LgtltvENuM6+v5GfqtdkSdNpThI34dImvwCRkqqYZhTCIw2IB9I0Xr5rcbCXnxSfIDku
 yOsXx+VTCGMq3SZcwDp+Vmz1ZnML7qsCRUHlNR1TYXcsynEMbrDcp/T0osR82BkMTiNEl
 LCPOwvaO29RC66gtX3LcC7Z/irLa8PqM9ssOEPW4OJqCDWLcy7cagzff0I0Z9NbHOAWHy
 fwTGhAaH5i7R25S8d9Fur5JRIFPF9zJ7wqDAn9dInWZMQ2ARkrHJim1WsiD9klEr1TyrI
 ffHck7pNXFmjatMNbAqyQHBV7Y8VnBK0oYYFrNBZuuGvzhJc5pxoTXYhIkR0/YJgfJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789446005;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=OfPVNOzHO71rnXlnF/2XdpRZJPZG0AV3JA4Lnu2PZFQ=;
 b=AVwdyk49PhhnFFG2d1+Zcyq5oA18yuTx5IQIufZXxpO8g7xMSnCO6dQts0cKKqMhWimD
 OaVaKlViMujf5L9VXwVdsfcrTH6bdbjeRM8ZdFLcFwOASevGZnqcjVZq8rpwpiPdlR8bP
 1y57ujLUT9ruO+RuFeln2QXzHMhO1Wi/M0XPvEOq49mXWVpkpcCM9I/9ztzejsXTNp6sE
 QViMZTutCySdRNWofDmtyRCpG6JnSjScfwLWTqvyBWb6epDR0USBnYYyoMmR+sVDOJAcZ
 0UvEvme6QQrFMFyaQkfZl3lQaFK1RcMb/aC2ovJZFUXD4jkD7NO28MOz+W2cEM4jcug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ca4aXdrc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ca4aXdrc
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 06B514052D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 04:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UY4wWSHmFDPA4qxd1wuLMjkecvOghXQeX7J32yefcI9v8voTACSVZPQgJ9Ks1OgNllnE7NvAmIHru3j4sCWpJTeLtZaI+GpuNFpzaKZp+S+sSwc1GQUbvNosonmztlhHZytFGtDLL6yujebW1ZSXORELQj6UHTF6kPNVz6w8kYKdF7CBgl6YUSj1gEoHHzmh5VnK5kO/bhXu7YC53fXNvP9ddHXQZI9ZMloxzoiKhZYMPv3ETnJuoPiN4ZcxjPSr1fWKXW5Qslted/yuHfegfTg6AiKDz2y2qsoCHeFK9be8lOrOP9vLOOWIZ4BqcU5RsvY1cRLHJ17IeOb+LJSXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfPVNOzHO71rnXlnF/2XdpRZJPZG0AV3JA4Lnu2PZFQ=;
 b=ecuinKoyAVM/uDLieD18IwqxOQOFZy/2O70zjiX31rcvLTn2xSEDTzOa765zPmmLdgjXfVfwhkkwDyUiB8imtZow+uQVCnYXLQedzOHnHXluHwRpYmIB2SoGbVaufnTL6vXd5aRQZbUARPqXz0+rUxRl6W/XGJPjktlPnkd92uaJC+9iuvQCfqhsNMH19yImgVfk6yNRWJFoeZeEwUYPVXpWfWw/ECIPbI0u/74e8ovv7rBJeQrynP1lOPWkDbWg0Yq0UbfnX44/5WzeBuo4oZRu54W4jcbnkeoBq0CFFFY3TqEafki9OydSzGPSRnu9OZXhZU1XLRPnSYuUaetqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfPVNOzHO71rnXlnF/2XdpRZJPZG0AV3JA4Lnu2PZFQ=;
 b=ca4aXdrcAXrjZZ720q/3SMjheJIJx/RnBJzbl1xt0BbksCPwOWv2rIzaB1qIjU2Mfi0xNBF0TrsJ64LXKqpUmx1TUyoc8FLbmntC04VXB2Ge3pshzQ2lkEfmmCGjmW9EXGfA6kqroM3kosCqoxOUE0BCEU6aeFRO4c5YshGpKDs=
Received: from BN0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:e5::7)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Tue, 15 Sep
 2026 04:19:59 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::ad) by BN0PR02CA0032.outlook.office365.com
 (2603:10b6:408:e5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 04:19:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Tue, 15 Sep 2026 04:19:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 23:19:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 23:19:57 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 14 Sep 2026 23:19:56 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH] board: xilinx: cpu-info: Fix inverted soc_get_* return value
 check
Date: Tue, 15 Sep 2026 09:49:49 +0530
Message-ID: <20260915041949.1957388-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 0903b433-4be7-4dbc-ae14-08df12e09aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|3023799007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: k3lxqN2XHpiabs9t8SBuASb57cNNuHVFJrzrhl5g6juvu5micf1OAue9/6s76YjBX7o+5bI2loZkWt31GPKKgUBOLscjtlUE4sSsFs4QHRiOwfRhvhCw0T5OV4Jwr+QV6TKy86QCWZlZWvemi/K1oo0uIEcpMpxIHPiX03bHiwGjWxX1ZIXX+obgZp3MkC9yyAOetKykFh7Fx6Wwq0p4vYvODtdEFpDeFW/g88dxha1eg3a2Qm4W2l5hB9rXYIZxKJTKSGMB+af3ErIXOZfwg4JS5IsObBPxRMCfKdk99o/8tjo0bj4Qgaub2utPzkKThrBlVNqhKqu+PW18tbrMI9bSW3H7+my20qytH5owteuoRBPa93gqHDmU/lGpBhpbkoifhmmh4XP5agD139oFw84oVEyvFw92ko5dncbdUyqrKfefrZA2/Z3BJB8OWyl4oe6YiMNY5m99gERIPFVMVODXT+U0Y062RCXVWLCdvbbQhuODTnlLgTte+CzjSMK/3crWWcTtzRo8bUkvDqAhU1kngMJApDHiXaBjl3VisLaMI9R7VD0znhKGV8VZSPcVgNtX9vt2Rxo/bSkYFcVbATWQrjDyU2l8lCGYahEDgP0kOta5DDfmWpvr5NlL5HhwPiaCRAGXr1sM433zUCVdE4VaJ1O+eVPnXtNh8phYIefydoTEITbmIi9dP1Jz7Ya/8q2cd8adTGwdeZWczipwKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qwhD0Bphx5S38rSZBDsMxy9JO6tBSlxFOeJmdq8Y+ZMEU1ofADX7EsPTaONmrmJnn06/Z4pzMjU5S8+FXkcAAdFYL6QdIe2ZTD26tbh9xfXye7ecAkNRHR69qzymbueW4fi7X6RFysOO+IoHc9mr8VmMn1hA98xwFMzuBu02eROEwPC8AzfDAY4UvXDVvNpIe9kzAwKIFSooM82gjo5yKc7ntQK7Ki0q17EfgyOuj6XAU3gFI4r0Do06ll7PuqoAwQCrfE9TLLMCIPi8ixFRuZAfTM64Lqj9JiblAxkiFrItD/Nd3rlUPlAw30nO87P5no36ciSu8zupZzNFwwf0pzt8DztFMslo52pf39j+nkVpyH8suzzuEKvuQJCcaxjH7phhYvFLx8BUXM++33qH9QG5gZ0IgNi7XxQKEN8KRNP3D52IkWN8XInp+NS0mmFp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 04:19:58.5988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0903b433-4be7-4dbc-ae14-08df12e09aa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178
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

soc_get_family/revision/machine() return 0 on success, negative on
error. print_cpuinfo() checked "if (ret)", so a failed call (e.g.
-ENOSYS) was treated as success and printed name[] unpopulated or
stale. Fix the checks to "if (!ret)".

This alone would drop CPU:/Silicon:/Chip: output on Xilinx/AMD
boards: soc_xilinx_versal.c, soc_xilinx_versal_net.c,
soc_xilinx_zynqmp.c and soc_amd_versal2.c return snprintf()'s byte
count instead of 0, which the old inverted check happened to mask.
Fix all four to return 0 on success / -ENOSPC on truncation, per the
documented soc_ops contract.

The wrong return values also affected soc_device_match(), which expects
0 from these ops. With a nonzero byte count returned its strcmp()
comparisons were skipped, so any Versal revision matched the
{ .family = "Versal", .revision = "v2" } entry in cadence_ospi_versal.c
and took the CQSPI_DLL_MODE_MASTER path. After this fix family and
revision are actually compared; production "v2" silicon is unaffected,
while ES1/v1 parts now correctly fall through to -ENOTSUPP.

Fixes: 86ceedd84e2 ("xilinx: common: Separate display cpu info function")
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
Message-ID: <20260912111037.767370-1-pranav.sanwal@amd.com>
---
 board/xilinx/common/cpu-info.c      |  6 +++---
 drivers/soc/soc_amd_versal2.c       | 18 ++++++++++++++----
 drivers/soc/soc_xilinx_versal.c     | 14 ++++++++++++--
 drivers/soc/soc_xilinx_versal_net.c | 14 ++++++++++++--
 drivers/soc/soc_xilinx_zynqmp.c     | 21 ++++++++++++++++++---
 5 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/board/xilinx/common/cpu-info.c b/board/xilinx/common/cpu-info.c
index 765bb24d937..6fc3d612b46 100644
--- a/board/xilinx/common/cpu-info.c
+++ b/board/xilinx/common/cpu-info.c
@@ -20,15 +20,15 @@ int print_cpuinfo(void)
 	}
 
 	ret = soc_get_family(soc, name, SOC_MAX_STR_SIZE);
-	if (ret)
+	if (!ret)
 		printf("CPU:   %s\n", name);
 
 	ret = soc_get_revision(soc, name, SOC_MAX_STR_SIZE);
-	if (ret)
+	if (!ret)
 		printf("Silicon: %s\n", name);
 
 	ret = soc_get_machine(soc, name, SOC_MAX_STR_SIZE);
-	if (ret)
+	if (!ret)
 		printf("Chip:  %s\n", name);
 
 	return 0;
diff --git a/drivers/soc/soc_amd_versal2.c b/drivers/soc/soc_amd_versal2.c
index 530b3249431..ac505d0f961 100644
--- a/drivers/soc/soc_amd_versal2.c
+++ b/drivers/soc/soc_amd_versal2.c
@@ -26,17 +26,27 @@ struct soc_amd_versal2_priv {
 static int soc_amd_versal2_get_family(struct udevice *dev, char *buf, int size)
 {
 	struct soc_amd_versal2_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = snprintf(buf, size, "%s", priv->family);
+	if (ret >= size)
+		return -ENOSPC;
 
-	return snprintf(buf, size, "%s", priv->family);
+	return 0;
 }
 
 static int soc_amd_versal2_get_revision(struct udevice *dev, char *buf, int size)
 {
 	struct soc_amd_versal2_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = snprintf(buf, size, "v%d.%d",
+		       (u32)FIELD_GET(PS_VERSION_MAJOR, priv->revision),
+		       (u32)FIELD_GET(PS_VERSION_MINOR, priv->revision));
+	if (ret >= size)
+		return -ENOSPC;
 
-	return snprintf(buf, size, "v%d.%d",
-			(u32)FIELD_GET(PS_VERSION_MAJOR, priv->revision),
-			(u32)FIELD_GET(PS_VERSION_MINOR, priv->revision));
+	return 0;
 }
 
 static const struct soc_ops soc_amd_versal2_ops = {
diff --git a/drivers/soc/soc_xilinx_versal.c b/drivers/soc/soc_xilinx_versal.c
index ff6eb873d8a..8dc93a66acc 100644
--- a/drivers/soc/soc_xilinx_versal.c
+++ b/drivers/soc/soc_xilinx_versal.c
@@ -24,15 +24,25 @@ struct soc_xilinx_versal_priv {
 static int soc_xilinx_versal_get_family(struct udevice *dev, char *buf, int size)
 {
 	struct soc_xilinx_versal_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = snprintf(buf, size, "%s", priv->family);
+	if (ret >= size)
+		return -ENOSPC;
 
-	return snprintf(buf, size, "%s", priv->family);
+	return 0;
 }
 
 static int soc_xilinx_versal_get_revision(struct udevice *dev, char *buf, int size)
 {
 	struct soc_xilinx_versal_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = snprintf(buf, size, "v%d", priv->revision);
+	if (ret >= size)
+		return -ENOSPC;
 
-	return snprintf(buf, size, "v%d", priv->revision);
+	return 0;
 }
 
 static const struct soc_ops soc_xilinx_versal_ops = {
diff --git a/drivers/soc/soc_xilinx_versal_net.c b/drivers/soc/soc_xilinx_versal_net.c
index 7afb110d8ce..9b3d1b8a131 100644
--- a/drivers/soc/soc_xilinx_versal_net.c
+++ b/drivers/soc/soc_xilinx_versal_net.c
@@ -26,15 +26,25 @@ struct soc_xilinx_versal_net_priv {
 static int soc_xilinx_versal_net_get_family(struct udevice *dev, char *buf, int size)
 {
 	struct soc_xilinx_versal_net_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = snprintf(buf, size, "%s", priv->family);
+	if (ret >= size)
+		return -ENOSPC;
 
-	return snprintf(buf, size, "%s", priv->family);
+	return 0;
 }
 
 static int soc_xilinx_versal_net_get_revision(struct udevice *dev, char *buf, int size)
 {
 	struct soc_xilinx_versal_net_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = snprintf(buf, size, "v%d", priv->revision);
+	if (ret >= size)
+		return -ENOSPC;
 
-	return snprintf(buf, size, "v%d", priv->revision);
+	return 0;
 }
 
 static const struct soc_ops soc_xilinx_versal_net_ops = {
diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
index 1dc0b05a1a3..cf6896aef4a 100644
--- a/drivers/soc/soc_xilinx_zynqmp.c
+++ b/drivers/soc/soc_xilinx_zynqmp.c
@@ -368,26 +368,41 @@ static int soc_xilinx_zynqmp_detect_machine(struct udevice *dev, u32 idcode,
 static int soc_xilinx_zynqmp_get_family(struct udevice *dev, char *buf, int size)
 {
 	struct soc_xilinx_zynqmp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = snprintf(buf, size, "%s", priv->family);
+	if (ret >= size)
+		return -ENOSPC;
 
-	return snprintf(buf, size, "%s", priv->family);
+	return 0;
 }
 
 static int soc_xilinx_zynqmp_get_machine(struct udevice *dev, char *buf, int size)
 {
 	struct soc_xilinx_zynqmp_priv *priv = dev_get_priv(dev);
 	const char *machine = priv->machine;
+	int ret;
 
 	if (!machine[0])
 		machine = "unknown";
 
-	return snprintf(buf, size, "%s", machine);
+	ret = snprintf(buf, size, "%s", machine);
+	if (ret >= size)
+		return -ENOSPC;
+
+	return 0;
 }
 
 static int soc_xilinx_zynqmp_get_revision(struct udevice *dev, char *buf, int size)
 {
 	struct soc_xilinx_zynqmp_priv *priv = dev_get_priv(dev);
+	int ret;
 
-	return snprintf(buf, size, "v%d", priv->revision);
+	ret = snprintf(buf, size, "v%d", priv->revision);
+	if (ret >= size)
+		return -ENOSPC;
+
+	return 0;
 }
 
 static const struct soc_ops soc_xilinx_zynqmp_ops = {
-- 
2.43.7

