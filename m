Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80618606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 04:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gKmXOlQX;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=OBO9D0ZK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 798CC405A5;
	Wed, 28 Oct 2026 04:39:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qPHCssCKMuqw; Wed, 28 Oct 2026 04:39:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 26BF4405A6
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793162369;
	b=GAmrfn7zlDeUw6Ogl1AUFVWOLeIOE2gY5ExAZgKicMQwZJXMS83lVP6iKbDB/NbywpX5
	 u+viphYZI1Vurf1Glm5kGnLfa0+arZhavcpGsGTrrqfIezUNdJam9/6AYG3UEcFH/cNXn
	 PQ+JgDCENjd0vJMqMv5fTBTRo/aJq4Xrux6YI2LV1q0Pm88efuy+zX3Axw7QN6ZI96u3M
	 IdbO1eiiv/0+9sv9H00zh6iC/8tpFCOlLIafv+ljfl5R6uklwOTpP4DTHdvIaUbYu8qvF
	 +UORrg/XtJb8UeW35xI8fiGBT12XVPBc9kg+TcCcV4U/fslkh9GI348b0vrPuDVYy6g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793162369;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v0jQaaTnBt61X7RB094JkhfFfUfW3li8Dat5V4IRGHQ=;
	b=WdM2tNoTKtrOrURTv/I2DBIT/8Q80RowlHwYQWpUIhU3giV3EhwbNKBjPR8yGobetOiA
	 AhzU56Vm/VpgTUrwFezS8W8iQrjZVoUKG+IJ/FdFA3ydwp6GDC9OEeh5hmubQuMzHbAwk
	 wO27N6t3dqJhiZK0gRJkArYVBrdIXehiXGM6xtPd/Omt1jP2tKy0PFQkuReu3MSDqaSyJ
	 kPoiPC1qruTU8iIZYxh0WwHEAKRPKvzIIXKCvyL6sJuOpRfocZorPip8jeUS6mx22fGBs
	 n+DJa+6fG453g2+jwNnlU9zRhyXGbtccAq99fUrYl5O0F/U9cB9lJ8sKMbY0XUP3NQQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=processmission.com;
	dkim=pass header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=OBO9D0ZK;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793162369;
	bh=v0jQaaTnBt61X7RB094JkhfFfUfW3li8Dat5V4IRGHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gKmXOlQXkw1dBRAj+toZLXcjbmF7TX3hFftMMTIqeMKXwIwlHrh8hBCw05Wx5Aknc
	 bwsV9LUFCNQqcXumFIxnsFkH4HKryjSAs+ZaJQDPdWwXVt5omGCpb9SWhDFXclCXhk
	 UAXS+gtPoKCVx+rrSCJE9SG86TO43pR+CXAc/UCxJPsPG58tnR1IQhQRpUYC6ukqDg
	 nCp7By6VuhbuW6H6ebzR/t3yn5WJRJ1WilTbgpNe0kpORFJcwFhGBS2Xsklnya9AjJ
	 yJiyxOzr3OJrEBC7HbGDhavf5wgEm+vpHi4SCEkeadO8267xWAGgriebwb1EitC2nv
	 ZASZoe+jcaRSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26BF4405A6;
	Wed, 28 Oct 2026 04:39:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 13F6CD1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DAE8940574
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mLSK3foMO1Xw for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 03:51:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62D0840575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c405::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793159496;
 b=MRjb7+V+EUYs9otXDeRZgqseuNtBaJqTH+1xylc/ElP0aOoiLaCiCPRK1kmJEcUF1vkN
 NHQvw9tRlqiVc1ZBaAqhyo2j96VoBcjrPAKdpaengTxpqtMFQLvXEMJUSc009cY/UPbZ5
 rP/ilvdMZngdOoji918rKYc02m/C6a/gJfN5q5thILOhZcz3pC2ALxBupkWg/gzCmgeOY
 3jGVlnCCOO15OoEt/kFNXLv0WTSL+ty6hKU/+p5fsj09dWXxJZB3MZTDnmNLCixicKqSU
 YAZs87MhuuEcGiUMxWm5HEWg0Vp0TpxzHtsRQ4I51+vJb4ZKdC/CpScFLRr2NjNPt3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793159496;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=v0jQaaTnBt61X7RB094JkhfFfUfW3li8Dat5V4IRGHQ=;
 b=nrmXxDPzQBWxN6kmspp9MeVBREnfEQu0umJPYyvFGC1bju3oj00LOcjCkK0817C5/vIw
 O55CmE0/M+9rUFPEO6mSU2qq1E++29eGoaUYNefn726DhDDHtFPOmY7/bh4UA4PqyDdiZ
 FRRIAXZMbgIXGwLMMYqdSU1vhO0iAiCO0jQcGWIwn45EFjliNUIYP2XiWMilDY7guLsv2
 530+hq2Cb3a9w/H/26w2JTArkaIkAhvZPOpGTJ1Z1pEa4esr1bDMPspYuv0sRg18HS5zF
 XxVIv8w3SS0Bh+uQC6KHh6Y6tM93kwCPOHZOyQCKqNL/37ge6PozqDRFw6pGVl5JtIQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=OBO9D0ZK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c405::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c405::7;
 helo=tydpr03cu002.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=OBO9D0ZK
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62D0840575
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMezrluz8vwgZe6pslX+4Lj2uKNGn/mPgrzuEOq75qi1EyqXtpfFQWOBKEMKtVAAPuDAbPFlqvywVm5zX56lWNSzQWKbnsAbAmzYsBZBJM1Ptk3rpSfEG+yM0U64/28LCuGQCVtZzbet4rz1rdpqw07I7lDkKcsXsxMEo9k+8qQNqwBmP6Pad98i7c3NPvX7Ls3Dbbv/u+kLEtZ5u1SPLbzj3y5EFFt/52chgt3pYFU71NUGAeO0YHjoqthrD+pIh96C83yMKA8rThg0yAn7t6H6nlFV7Mu5nGrqn8rGAnUXA0+PVQMn8PLwWr4t8T4+1L1IDlsfLSNf43TWZZXsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0jQaaTnBt61X7RB094JkhfFfUfW3li8Dat5V4IRGHQ=;
 b=hWURNHrqush5UTRQ2hcO5S+0trBf/EY9exl9qg/A8zhgx4lcJShhk90lABOpFfWQEmqYvCeBVsL5g6FG3H3KvBogUS7TbQGFcUxXbexTpC3QVCbm6WNHZPi7a+H6LjJHczX0jbkoh+EHnwJbMRSwy32GryMHHg7X+bxgKGbXm8CXle3Roax5CtZ8vljMe2DQybu7JksupWFekO1k6nZZlqdaVTbgRvYDYOFZ7vnpc2pDL/8m2NxSiKhV01m9fzz2xSPn0g/fJmtHAqqAH4wh/ztCciXRIGMNu3zTyMt2PB2ctEJYPgyHYdDKzAB5XLRhxa42XcoQ9/EHFEcko99Zlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0jQaaTnBt61X7RB094JkhfFfUfW3li8Dat5V4IRGHQ=;
 b=OBO9D0ZKhXvth69BTA/B4AYQFw1ZaZZbOfrHNVffSNmelhIMPGG47AQrzUkkdTpNnN/kSBMDcSh1LilpL5K/tB28l/AIeIsW3zoL2iEAmx1auvpK9tAj34ma6Ixe4hYnLQduJ0JTWcCMV/79fnYIDK6qDTgigt5xy8DP32ESv10eOqIFL9BCh51aUBPR6FRqHYLXDZtfabwaKpzY2XST+jiMg/4MtKjiPORHb4yPyRuASfBN4WXT+aSV/2gir4okjVDkQ7yeji8xWS7qhoEDyO4Y1hAuAT8VxaVuWoyKrIuOnKlcLXkkwrtGBLXOwVx4K2/Frxl+JzgEsiKiVUPG1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SEZPR02MB7470.apcprd02.prod.outlook.com (2603:1096:101:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 03:51:28 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 03:51:28 +0000
From: Bin Meng <bin.meng@processmission.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [u-boot-test-hooks PATCH v2 2/2] bin: Rename QEMU arm* conf files
Date: Wed, 28 Oct 2026 11:51:07 +0800
Message-ID: <20261028035108.2910329-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028035108.2910329-1-bin.meng@processmission.com>
References: <20261028035108.2910329-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::10) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SEZPR02MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 5464dd78-7492-4b13-c685-08df34a6bf2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261026140227099003|261009223027099003|261022105027099003|261021121427099003|10067099003|261021123027099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: acbf28FyKbwbp5j1VwQ2C+DvODcVlFnml/jOy4izIVc224J/q+QcgCoRKu0dx3m3eh3wZUUUzl/z8reOcbgzMqp0CZhLrjORLMj695QY3cz/Kannx53ajLqHm3KHloWrKgIl1LKHJcswQrnDZgmgKNSu9kO80ddkX6Z42v3M6Gxfh31ank8QQgEyyhAJlv/OyfOFk6IVSKgzvVeg6/OoU5WxYOUlCiWZZc/FVmQdMgzPBOQwxMhVdBLpJkgSZT/VJEUBk6m6Lx0d1NR3kV/31JN+KjMe5T2mPuf/qEPtFiSwKmGKQ56UFuaGzgu0YQkUKrCF5pBe8REkZL52IiQpbP+Ag8M/13aRavCSfLO6fXu+3WiBiNCIQo5S1q1pQw6TMdHbziuW3hM739QgClpMVCj3n3ffKE9ugyPdTcY3BBb3dfdjtF8t2mUFUk4nCwEewEYeTM+jqMDztNsXrgWRqpnqVD087+s1VvoQg4WQQiqj/aWnYKYqksF9TRPCuBj8/UHRAzsOCmnw8qlhyIlglgAOMfcip8vDr+8MY6wvJCxye2MMfdkSojtMxqHQ6v5+U6IQ6EudinfPrTF/2UdiMSSmy32cfgm5nlxh782OqKuTrezNF9KbApKnoSPUMXBzWnTrkOLhYREFK3Vkc7/Pw8M5KIX4cwe2nfrOoH7IgD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261026140227099003)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(261021123027099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hgEZmWVPGGQyknJ+80OWpF4NBfjQTzUtYCzPZPdBgrincURlBxTvPp1JNZ3Z?=
 =?us-ascii?Q?ufLSVajzSe+lAzIR+UtF6/Ub4rSFV/UyDsC7BREtWsXmPN/t12LXu2mK9D1+?=
 =?us-ascii?Q?RaeCzylM0tD/OL9aPTHVlJueGX0YUDq+4ayU0em5C6v2pOzL4AV2mPcOvJO5?=
 =?us-ascii?Q?ZV5U8NfIJnqGn3WAu2rr20Q5Fax9U5QlzjjwS5dWVmrnUG+wKYh/eWuksGPk?=
 =?us-ascii?Q?4e/hO2Wg6BZswc3VdpbD0rlPScd1fekIPaXGqjqFD0OiKHwUf+hMnSU4nNLf?=
 =?us-ascii?Q?PregI5gZgEo2lCNSdoOurpK7H5IdWj0wRKJLdOwCV6xyY3cj2VEP8R+KbzQn?=
 =?us-ascii?Q?scY0en8Ei5usZxb7/4VntcXl9hk9P/lUL8NWhspb9NDHwea/USVOtu6hZAgJ?=
 =?us-ascii?Q?WUOIyHNQMOB+yk3QH6bF87AugsO2ZcHN/WHtN0l9VfloFstmdOJQ3o1vTJdl?=
 =?us-ascii?Q?pL8LIA3ZpnZWl6Xp+SbZSWdEI+FX+CNN1jnSPwHCu853LP9I3WqNLie50Ea4?=
 =?us-ascii?Q?a8JhzYlQ34F9H4+2jQcQPN/j7lHsK/wb9Z4zEUVsxYHWbexBLUbGOWhdfs70?=
 =?us-ascii?Q?VoygWXVte4ykChDy8c8RRkDhuOSedOTZF5S21ztFjQw32vjSNbdbO21aGTjC?=
 =?us-ascii?Q?opjSgTRyBvEAgRDcylBQoalAGhxzVVWZWVYPZ2JJ2KlTEjf9qheUam5Nbaci?=
 =?us-ascii?Q?9z/YoJsss1OKj3XAOuE3KvKX2NHq1hG5lza4Nook74W/UO8DxfwRN8kjFjAh?=
 =?us-ascii?Q?W/f2t3URKBrwRAWjfVqrrcBsOnTObW0KlA1yY7fyP9j7v/i6svf3JXZzPugM?=
 =?us-ascii?Q?wLjK7JhI3eZR6yS09ZimKkEs2gNvyjMDaJGWv3kk/XqHV0CVE91frQeScmPF?=
 =?us-ascii?Q?6xda1JVlmqDoz8kjlSx7v1+CrF9xzYPrLoaBySOHlTDXaIHTaLqhoMOpwt1H?=
 =?us-ascii?Q?pPuxB98WH3NpLjjGB3ia0ejm8+g+PKv6mRPnAZP4peETHgGMpUW/EFbHWQ3z?=
 =?us-ascii?Q?rPObryPyHqCZtMl3Rk+ND1YR/LTgP6LksrbNDU1+Y+8c+0a9NOVt5Pladn61?=
 =?us-ascii?Q?f6ePTs1DmGXvrpo6adfUSZsiq1x0tCpTGwnhal1eUPqOopgd0LF1tTJM12oB?=
 =?us-ascii?Q?Ni0G/HBo5xQJLOJKvgPGu5RRo8+bBA0Snd4MHM0KMUUNhIbaGCRi7MVIDu2k?=
 =?us-ascii?Q?e2j5TW/xC8Ysj4MGEZIzKvI6Hh7IMg/dukmSKb+eMXmW0QbBOj4MGlJFnHPn?=
 =?us-ascii?Q?e1u6OIZN8p0AC4LmLzoEjiTbnQpktO98nrrc14wz0hNy0rTs9wZNTd4Rs26W?=
 =?us-ascii?Q?KZj0r9jyj8i3yEj/CDhEjBXb0HfGxkR9MXgASm6h1W60HXMFkHlMxXfgv6gW?=
 =?us-ascii?Q?oGy5MGIJtbaZ8wvijhD2eGBJT0RUIf2b37vK55lLov9zNJdCZWncRJKq/rhs?=
 =?us-ascii?Q?DqQejD6vp/IMBwqYbxs+Ns5akhRiwTTQ0uXYmsMnVMm+VWqVuNENmgC6nyXs?=
 =?us-ascii?Q?utlridOSi3WG/lhnx/ldfwnlnVOvMCTY5Gl+kbNHiUAh0X2ZAl99ep885JNJ?=
 =?us-ascii?Q?ah0V+ubo8NJr7oRFT7OORA1ha9SiJD5QJTBs6VICFYkPnmSQkYoKYIE1iwVS?=
 =?us-ascii?Q?mVFhlYk1NEQYchg6wblE+VD3PLu4A9GBvmZUwdu8nSzaJKBaNKdk93JKwIVC?=
 =?us-ascii?Q?sqUyiP+/hzm7P8Atnc6omRWWOIFtFtgnPv0TZ8X8v8TwKK0i9UZfTdl7Q9RY?=
 =?us-ascii?Q?Dj93omforFaeCIb62A9cx5lNjcMD9dw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5464dd78-7492-4b13-c685-08df34a6bf2e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 03:51:28.8051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fd+62vJuPrFMvyQcb5BKuD9DdBz9QuIhi5T8CFPGZ1lOqCD+gV/AXvKtoXjB7Aq0R0X0Yg/jERmi0Cvlc4yBXwoA+0/960bUHzTAFA8ksEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7470
X-Mailman-Approved-At: Wed, 28 Oct 2026 04:39:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bin Meng <bmeng.cn@gmail.com>

Use a hyphen between "qemu" and the architecture name for the
"board_type" field in the conf file name, and indicate "arm64"
for the ARM SBSA virtual platform.

Update the Labgrid U-Boot provider to use the renamed ARM defconfig.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

Changes in v2:
- Rebase on the latest mainline
- Update the Labgrid U-Boot provider to use qemu-arm

 bin/ellesmere/conf.qemu-arm64                                   | 1 +
 bin/ellesmere/conf.qemu-arm64_spl_na                            | 1 +
 bin/ellesmere/conf.qemu-arm_na                                  | 1 +
 bin/ellesmere/conf.qemu-arm_spl_na                              | 1 +
 bin/ellesmere/conf.qemu_arm64                                   | 1 -
 bin/ellesmere/conf.qemu_arm64_spl_na                            | 1 -
 bin/ellesmere/conf.qemu_arm_na                                  | 1 -
 bin/ellesmere/conf.qemu_arm_spl_na                              | 1 -
 bin/travis-ci/{conf.qemu_arm64 => conf.qemu-arm64}              | 0
 .../{conf.qemu-arm-sbsa_na => conf.qemu-arm64-sbsa_na}          | 0
 .../{conf.qemu_arm64_spl_na => conf.qemu-arm64_spl_na}          | 0
 .../{conf.qemu_arm64_tpl_na => conf.qemu-arm64_tpl_na}          | 0
 bin/travis-ci/{conf.qemu_arm64be_na => conf.qemu-arm64be_na}    | 0
 bin/travis-ci/{conf.qemu_arm_na => conf.qemu-arm_na}            | 0
 bin/travis-ci/{conf.qemu_arm_spl_na => conf.qemu-arm_spl_na}    | 0
 labgrid-sjg/kea_env.cfg                                         | 2 +-
 16 files changed, 5 insertions(+), 5 deletions(-)
 create mode 120000 bin/ellesmere/conf.qemu-arm64
 create mode 120000 bin/ellesmere/conf.qemu-arm64_spl_na
 create mode 120000 bin/ellesmere/conf.qemu-arm_na
 create mode 120000 bin/ellesmere/conf.qemu-arm_spl_na
 delete mode 120000 bin/ellesmere/conf.qemu_arm64
 delete mode 120000 bin/ellesmere/conf.qemu_arm64_spl_na
 delete mode 120000 bin/ellesmere/conf.qemu_arm_na
 delete mode 120000 bin/ellesmere/conf.qemu_arm_spl_na
 rename bin/travis-ci/{conf.qemu_arm64 => conf.qemu-arm64} (100%)
 rename bin/travis-ci/{conf.qemu-arm-sbsa_na => conf.qemu-arm64-sbsa_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm64_spl_na => conf.qemu-arm64_spl_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm64_tpl_na => conf.qemu-arm64_tpl_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm64be_na => conf.qemu-arm64be_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm_na => conf.qemu-arm_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm_spl_na => conf.qemu-arm_spl_na} (100%)

diff --git a/bin/ellesmere/conf.qemu-arm64 b/bin/ellesmere/conf.qemu-arm64
new file mode 120000
index 0000000..312f519
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm64
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm64
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm64_spl_na b/bin/ellesmere/conf.qemu-arm64_spl_na
new file mode 120000
index 0000000..112a3d5
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm64_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm64_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm_na b/bin/ellesmere/conf.qemu-arm_na
new file mode 120000
index 0000000..d103ff9
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm_spl_na b/bin/ellesmere/conf.qemu-arm_spl_na
new file mode 120000
index 0000000..aee911e
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm64 b/bin/ellesmere/conf.qemu_arm64
deleted file mode 120000
index dee6855..0000000
--- a/bin/ellesmere/conf.qemu_arm64
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm64
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm64_spl_na b/bin/ellesmere/conf.qemu_arm64_spl_na
deleted file mode 120000
index abbbc02..0000000
--- a/bin/ellesmere/conf.qemu_arm64_spl_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm64_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm_na b/bin/ellesmere/conf.qemu_arm_na
deleted file mode 120000
index aa91a9f..0000000
--- a/bin/ellesmere/conf.qemu_arm_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm_spl_na b/bin/ellesmere/conf.qemu_arm_spl_na
deleted file mode 120000
index e171c5a..0000000
--- a/bin/ellesmere/conf.qemu_arm_spl_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm_spl_na
\ No newline at end of file
diff --git a/bin/travis-ci/conf.qemu_arm64 b/bin/travis-ci/conf.qemu-arm64
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64
rename to bin/travis-ci/conf.qemu-arm64
diff --git a/bin/travis-ci/conf.qemu-arm-sbsa_na b/bin/travis-ci/conf.qemu-arm64-sbsa_na
similarity index 100%
rename from bin/travis-ci/conf.qemu-arm-sbsa_na
rename to bin/travis-ci/conf.qemu-arm64-sbsa_na
diff --git a/bin/travis-ci/conf.qemu_arm64_spl_na b/bin/travis-ci/conf.qemu-arm64_spl_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64_spl_na
rename to bin/travis-ci/conf.qemu-arm64_spl_na
diff --git a/bin/travis-ci/conf.qemu_arm64_tpl_na b/bin/travis-ci/conf.qemu-arm64_tpl_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64_tpl_na
rename to bin/travis-ci/conf.qemu-arm64_tpl_na
diff --git a/bin/travis-ci/conf.qemu_arm64be_na b/bin/travis-ci/conf.qemu-arm64be_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64be_na
rename to bin/travis-ci/conf.qemu-arm64be_na
diff --git a/bin/travis-ci/conf.qemu_arm_na b/bin/travis-ci/conf.qemu-arm_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm_na
rename to bin/travis-ci/conf.qemu-arm_na
diff --git a/bin/travis-ci/conf.qemu_arm_spl_na b/bin/travis-ci/conf.qemu-arm_spl_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm_spl_na
rename to bin/travis-ci/conf.qemu-arm_spl_na
diff --git a/labgrid-sjg/kea_env.cfg b/labgrid-sjg/kea_env.cfg
index a12bbd5..0072732 100644
--- a/labgrid-sjg/kea_env.cfg
+++ b/labgrid-sjg/kea_env.cfg
@@ -1161,7 +1161,7 @@ targets:
         login_prompt: ' login: '
         username: 'root'
       UBootProviderDriver:
-        board: qemu_arm
+        board: qemu-arm
       UBootWriterDriver:
         method: qemu
       UBootStrategy: {}
---
base-commit: 59437fd1c7a6a84da05efe5cefde47264f78dcbe
branch: qemu-arm

-- 
2.53.0

