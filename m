Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E04606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1IhtjwjC;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3DH8rpPD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F915407CC;
	Wed,  4 Nov 2026 10:01:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id namQRyuG0TKf; Wed,  4 Nov 2026 10:01:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D72CD40792
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793786461;
	b=VKQW86m4TkGEAdsEenkyC5eW96SaPFCkOdNfucoRZUxhXm5ygUkPeC4KiYt0sQHCOo1k
	 uCF+MyXPHDK2cuU2/ydz4THHmeNJRlywsrNYr2XInavbOnUvinSKbIXOO1Sny/DKtzSOB
	 XbS8xk+ohbyMniLF9CKmaqwzHdKIeT2tbQT/5TXSdUTiU9Ka6umurB4d9FXx32D5sntXj
	 AeUG7cGWCQrA6y17MzXU0phRXCkui0snX6ut+duhH3bZNrByK4+9K9ubJ8P32j/a9q7PO
	 +zfVJAigJNCxUZISx90xKaveiYiPYQcH2vDgfNJNCPdyD30YSOkeQ1sroGq7P8+3uoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793786461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=X3NXpXBa+hhO2AmFkM11+OWBfqAy7p/Sn29XOtz3zgc=;
	b=plXRF2gQ4aBjLN2fLHBWeUfhy+/SGpRW5KI8q+JjgT7TqwqqeN6afsUOqbL/qRqoRtj3
	 wcfJ1g5gdHHuuJnzn4mF9n25USc/KjoNS0x65cBtLGc8PbDQtypcff83UKcj5DVWKgj8s
	 jk6hN/N0n9TcttUFNyDz1nGJ2dtWgBszTaAXnX4Whp/SDALKAdUqTvjmeeyYzg0U2IE58
	 BalrZ9JEh+YvaWTJfMbXJJ9mA4K1aoKa8lgn2NO1Am2ZgFgxnOWpb3VTx7HWKs5CU8cEP
	 Ja9S24Bxd3LL6th4psYrm9fsBY30apkCFnpKn36nEyiaC7vU4dYn9dsfQGJ9g5EL8Og==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793786461;
	bh=X3NXpXBa+hhO2AmFkM11+OWBfqAy7p/Sn29XOtz3zgc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1IhtjwjCe8sGO54iFlK7AFEPvlJG7fBESurYONX8qUfic0kt5bJrFinnOjeHWJt3J
	 wF2lNzuo7zfnyUvADSVTSj9Hhu2EB8s7ogaMh9Tt2g1nA28PSMpMZTqT7NSTkPvCn7
	 FuzRatROGVyQ1THD0MzlBPT23/e/mzZ9aHUCSWgI6tGyx0QFlPaX3i9JceopG5xw5f
	 DGGifYQdsaOmjrS3RDkoAFFWHkJMjU8a3CDdAWrPu91wwLk55K3qy6ZY0PheVlisck
	 gy5HSU6h0/4aP3RC3hfGaO2Vlu6qkdWmh2KW2YdxIaxd/xhr6Txnr9x+aO3JuuuO9z
	 er8rI8PFxUPKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D72CD40792;
	Wed,  4 Nov 2026 10:01:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 33597932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19545400FF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sj4_jgXeC8ZU for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:00:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0DCD54004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793786458;
 b=rJre9tKV7aCyFAJdqaaycadoRwhrI5L7Taf57zg8Qa4EoweoA99GPWPD0YU5joxOht5U
 CnsEFEwtZ+8I4SsrJ0IRfCXWyDdPHBo/NscB9TT1rKPuXQwWesMeweiWlOBjDAgo1+S44
 hJ+o94wzsMpr5qdg54oEazz23qDuTlCyYjF+zqhqbY9LFgu/lms12vhADfdi81C+hYcJQ
 1S/4KHqSXabwhjMwolCEAbpfAhogScn+ynd2PP5JTSdrcFGSwO3+SlmozSZtyntQ4y2qn
 E4B/bKRikadGilxbLeCWvhL+fbNpgGV1UcRvBpWgC75v+M5bUPIOCT0BM+b1IAdropw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793786458;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=X3NXpXBa+hhO2AmFkM11+OWBfqAy7p/Sn29XOtz3zgc=;
 b=J4JL+XEnfgItaILZ8bM3mHIoe3nRc36TsAQHdQnyEWHRGIrfo75bcqGFLbHAd+iTWuKc
 cfMvT4h15BfsuxBMaM8C5kg2UXwEE+m7b+yjiHN0vdvNcYzFgdRWW7HCK4D4Ae673DIQ9
 rIE+ekVHuTRj5CB7bq377LdQ2YYEiA9yB23LPxJw2C8A1GzW2xHa9z8zp7SLk5tpYOuJ+
 01I6aix7PEDA3Yg/55Xboj16pVraSQlTbaM9S/B+E41IXFvgyyiKwxKxi46KpKSFkncKW
 Ab0bjnjv4WfUMVPQbXY4rI61JrQXVtVW1E+LlImB4nV12j+Mj6EW7ECQzzWG3i90CTg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3DH8rpPD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3DH8rpPD
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DCD54004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVtvVD5olsqSix22nmC03kgkO/OnLcEGGxbqAZm1G/jY3Q77z8zyUJMTie7KoJuYo6dJrMlTbeVOz9Gf4/HWNf66cbaYtVkdutvIwwi6gik4NqnaoikducqKXIT7bot0QntgQptolQ/xkcOguuLJZKpLFlMGEPFODf4wy445HWku5omjXt6MYw1fEFvy8TFw2GmMVaPzrV5Taau9xKFBLxj8k4AYkoUOY7qyPSXMFTBGWWXMpysb8uexwCx4r09RuMa3iocpG/m/zmx5qEhfgUPeBVZ0GD6T3V4ObqLYM2UVeqSSc1g1Lln11Cy+mraCTlcD1yCRMRHo5WDRnLmrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3NXpXBa+hhO2AmFkM11+OWBfqAy7p/Sn29XOtz3zgc=;
 b=RMIGRsicK5a+/eDL4PNtWv3tWQnAMEbWsNaV3JxCTN59/aEW+j6W1XnukcSHbF/KTGT4Jurcsf+YPkbY21QdxtkABiMWe76eFtuZmjx8aSTTUOymTcgb5Bi6AvdpvYDfMzfKjkkfJH0QXbiq8En+ZimunW51gT0GBudEbfi0QLXhMhp4mbRrANgrzjS8OYjksNMyXENhjoqWt6+SGSStsz2Oo1Jq9lNG4J1xsOdaU+06bU9G8SqON/7y2d0oIzJihJBTF7UBIXeCz25AmAbuDk0QfXmDg2vkERB4JyQ9dEadJx9K/EnBV4ZSSc25zU+19xcJ4WCKNNVkYy3/EuRiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3NXpXBa+hhO2AmFkM11+OWBfqAy7p/Sn29XOtz3zgc=;
 b=3DH8rpPD5pCpOViRYehhmznF4P3ffgIBdfHPdviZwV45nz76jei7Ly9x+9OPPZJbP2mC5w5VsmLeRAnOlMJAcXmOFB05+YbmS/D/A8ZcdxoTHPosGdkNJVhktHzJmyV5oZqHJ1GU38EHTH6cn+Qcjo7aUaDuPSDwIazPGy4mwdc=
Received: from CH0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:610:74::26)
 by SJ5PPF6785369A4.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::997) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 10:00:53 +0000
Received: from DM3PEPF000265B8.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::18) by CH0PR04CA0081.outlook.office365.com
 (2603:10b6:610:74::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 10:00:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B8.mail.protection.outlook.com (10.167.23.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 10:00:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:00:46 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:00:45 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 04:00:43 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Kuan-Wei Chiu
 <visitorckw@gmail.com>
Subject: [PATCH v2 6/7] doc: Add documentation for MTD virtual concat
Date: Wed, 4 Nov 2026 15:29:40 +0530
Message-ID: <20261104100005.4104985-7-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104100005.4104985-1-padmarao.begari@amd.com>
References: <20261104100005.4104985-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B8:EE_|SJ5PPF6785369A4:EE_
X-MS-Office365-Filtering-Correlation-Id: e274b8c2-c168-4737-dd93-08df3a5a82be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261009221227099003|261102123227099003|261028144727099003|261022075727099003|261026140227099003|261026121527099003|261022115727099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: GcQeSR5Zx73NvVeiE9Iq1x0cgg06GtYunbH8rxBY8sBr0EJwckZZ+gbfMn06/smYn8C1EwnR6vv5esDEUt1kf7japU2fuUPEHMrtTJK+3gHOnxzwfUNbh8ZOlxuHY+rzr17Ofb4AMb6kbO40Ua9NNQ7AgnC/g39XnV4teFcT87VkJA+87LWmIyw2siswqGRzLPZX7roe+y6qNZrfAIIiZAJUoYgo+tRiUm2OgwQ1YFSZOQN1dIyq++qU1v21Q/ED53j/Xrk/zUrc8/oHwn+4oF/2rpiuJSmZHYuZAR0g6t9+QynZfVSG6zASFAzJDrNpVfrP0hPb6sfHwGIOrlYz4jRtIsB8RTFv2lFP+RlgNAg6yNlwZtoi2jKB3zWaDhg2H5h7kGbt8Qp7bnA8CxSo0lwUSzp1uHkyDozkj22/HzxFQxy/OKbDIViOeSSVnvyJ3LbgKh7n1e5XPS0PL5RwNt7tALpuOJ2NcMATu+yqj3tIF45nXXlS8KcOD4G1d1dJs+rko7ooRGp4H6rjLKLxAYghcRdmiPFnT9GYRtD020EdIlK6mQmGDqJpf0Nc5Vil++SvR3+PaVtbskOOSLEnUGb86egd/9YF8bMKAdpmU/W5McJYfMnql5eU2l1NLZx5Cw7wEpAzZasSrEC13AlVkz8X2GlEPET/pusLBVWt5UlbKp9i8SUghvaIvGjpzs6mLlGwMr7nIn9kdYNXAFhvPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261026140227099003)(261026121527099003)(261022115727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yfRLImmVnUsTaicBBM8ScQatcAa1HD+Ck45gfBD8RcZm8Ts7bqV7ORCl9HcinHgxMH4L3mi5Hh/XIBwd65mRNSnwLBV6zhJFBE4DrDY9uE/G2FMlEyqdWN3KlxxRDcFYmHRh/0PE7NBtx/lHNJexdUBxi4Dkj/YgNz/Jq+AiEBpWawCK3d14abPmr4kZVuaTkfFryrxduyfgrNQHaMMcy+nL/1O6LNrM2M5kHomPND6MePI1vc0leU9rjAUOiODcbsknfWegXjH/KFNNFyPLiRxg0RtWuqEP8C2k7hBKkowKFxHrtvSy1W+5zaZgWmO/yCpN82znNXYEsnRoon01pep3TWiQvqUX900TVdSOaUqodiugcLYMfHNKkmCnKWPmRgLCQVFjVHLQepLUohIUOqDDBm+IywCjiTUSCdJLVY0/4Nefc9X5ExHsixTkvUg3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:00:52.4141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e274b8c2-c168-4737-dd93-08df3a5a82be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6785369A4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe how to enable MTD virtual concatenation, the device tree
property and its binding, how the concatenated device is named and
used, how it interacts with mtdparts, and how it behaves when the MTD
devices are probed again, when a group is incomplete and when a flash
is removed.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
- New patch: add documentation

 MAINTAINERS              |   1 +
 doc/usage/index.rst      |   1 +
 doc/usage/mtd_concat.rst | 146 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 doc/usage/mtd_concat.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 0553f4034ee..69963828972 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1322,6 +1322,7 @@ MTD VIRTUAL CONCAT
 M:	Padmarao Begari <padmarao.begari@amd.com>
 M:	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
 S:	Maintained
+F:	doc/usage/mtd_concat.rst
 F:	drivers/mtd/mtd_virt_concat.c
 F:	include/linux/mtd/concat.h
 F:	test/dm/mtd_concat.c
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 6d7ca6b9aec..b5df9359a6a 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -10,6 +10,7 @@ Use U-Boot
    environment
    fdt_overlays
    fit/index
+   mtd_concat
    netconsole
    partitions
    pxe
diff --git a/doc/usage/mtd_concat.rst b/doc/usage/mtd_concat.rst
new file mode 100644
index 00000000000..e0368ee46aa
--- /dev/null
+++ b/doc/usage/mtd_concat.rst
@@ -0,0 +1,146 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+MTD virtual concatenation
+=========================
+
+Some boards have two or more flash devices, for example QSPI or OSPI flashes
+on separate chip selects, and need a single filesystem or image to span them.
+MTD virtual concatenation joins partitions on different flash devices into a
+single MTD device, based on the ``part-concat-next`` property in the device
+tree. The same property is used by the Linux driver, so a board can use one
+device tree for both.
+
+Configuration
+-------------
+
+Enable ``CONFIG_MTD_VIRT_CONCAT``. This needs ``CONFIG_MTD_PARTITIONS``, as
+well as driver model and ``CONFIG_OF_CONTROL``. It does not need
+``CONFIG_MTD_CONCAT``, which is for joining NAND and CFI flash chips, and which
+this option does not enable.
+
+Device tree
+-----------
+
+Add a ``part-concat-next`` property to the first partition of a group, listing
+the phandles of the other partitions in order::
+
+    flash@0 {
+        partitions {
+            compatible = "fixed-partitions";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            part0: partition@0 {
+                label = "flash0-part";
+                reg = <0x0 0x800000>;
+                part-concat-next = <&part1>;
+            };
+        };
+    };
+
+    flash@1 {
+        partitions {
+            compatible = "fixed-partitions";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            part1: partition@0 {
+                label = "flash1-part";
+                reg = <0x0 0x800000>;
+            };
+        };
+    };
+
+The property is described in the partition binding, in
+``dts/upstream/Bindings/mtd/partitions/partition.yaml``. It can list up to 16
+partitions, so a group can have more than two partitions, and there can be
+several groups. Each partition can only be in one group. Only partitions
+under a ``fixed-partitions`` node are supported.
+
+The concatenated device is named after its partitions, followed by
+``concat``, e.g. ``flash0-part-flash1-part-concat`` above. Its size is the sum
+of the sizes of its partitions. The partitions in the group are not registered
+as MTD devices on their own, while any other partitions of the flash devices
+are registered as usual.
+
+Usage
+-----
+
+The groups are created when U-Boot scans the MTD partitions, which happens
+when a command such as ``mtd`` or ``ubi`` first needs them. The concatenated
+device can then be used like any other MTD device::
+
+    => mtd list
+    ...
+    * flash0-part-flash1-part-concat
+      - type: NOR flash
+      - block size: 0x10000 bytes
+      - min I/O: 0x1 bytes
+      - 0x000000000000-0x000001000000 : "flash0-part-flash1-part-concat"
+    => mtd erase flash0-part-flash1-part-concat 0x7f0000 0x20000
+    => mtd write flash0-part-flash1-part-concat 0x1000000 0x7ff000 0x2000
+    => mtd read flash0-part-flash1-part-concat 0x2000000 0x7ff000 0x2000
+
+Here the write and read cross from the first flash to the second.
+
+Interaction with mtdparts
+-------------------------
+
+The partitions of a flash device come either from the ``mtdparts`` environment
+variable or from the device tree. If ``mtdparts`` defines partitions for a
+flash device, its device tree partitions are not added, so none of them can be
+part of a group. Partitions defined in ``mtdparts`` cannot be concatenated.
+
+For example, with the device tree above and::
+
+    => setenv mtdids nor0=flash@0
+    => setenv mtdparts mtdparts=flash@0:8m(boot)
+
+flash@0 has the ``boot`` partition from ``mtdparts``, while ``flash0-part`` is
+not added. The group is then incomplete, so a warning is printed and
+``flash1-part`` is registered on its own::
+
+    partition@0: found 1 of 2 partitions, not concatenating
+
+To use a group, leave its flash devices out of ``mtdparts``. Other flash
+devices can still use ``mtdparts``.
+
+A concatenated device which exists already is destroyed when ``mtdparts``
+defines the partitions of one of its flash devices. If it is in use, e.g. by
+UBI, ``mtdparts`` is not applied to that flash device and a message is printed,
+as it is when one of the flash device's partitions is in use. It is applied by
+a later scan, once the concatenated device is free.
+
+Behaviour
+---------
+
+Rescanning
+    The partitions are scanned again when ``mtdids`` or ``mtdparts`` changes,
+    or when an MTD device is added or removed. A scan does not change a
+    concatenated device, so it keeps its place in the list of MTD devices and
+    can be used while the other partitions of its flash devices come and go. It
+    is destroyed when one of its flash devices is removed, or when
+    ``mtdparts`` defines the partitions of one of them, and a later scan
+    creates it again if its group is complete.
+
+Incomplete groups
+    If a partition in a group is not found, e.g. because its flash device is
+    not present or uses ``mtdparts`` (see above), or the partitions cannot be
+    joined, a warning is printed and the partitions of the group which were
+    found are registered individually.
+
+Removing a flash device
+    When a flash device is removed, for example when ``sf probe`` probes it
+    again, every concatenated device which uses it is destroyed. A later scan
+    creates it again. If one is still in use, e.g. by UBI, a warning is printed
+    and it is kept, so stop using it before removing the flash device.
+
+Testing
+-------
+
+The sandbox test device tree concatenates the ``nor-spare`` partition of
+``spi.bin@0`` with the ``nor1-spare`` partition of ``spi.bin@1``, and the
+``nor1-b1`` and ``nor1-b2`` partitions of ``spi.bin@1`` with each other. The
+tests are in ``test/dm/mtd_concat.c``::
+
+    ./u-boot -T -c "ut dm mtd_virt_concat*"
-- 
2.34.1

