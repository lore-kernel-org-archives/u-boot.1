Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1813C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 11:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E06840A47;
	Thu, 10 Sep 2026 11:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id URuOniQCRpJF; Thu, 10 Sep 2026 11:49:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D31D440A48
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789040949;
	b=ZAk2FzDyqM7Kmt2Ibz7ycvArcDVlzs3lZAVT547R3MbrXD+qpGLc+SXFBXMx4seShpJ9
	 HBItuaxHFry6My223fZ/UwGzvfeRhEYU3F2v6MwsCgcQsjFtYh9/X0NvsdOyJYydrQesB
	 lMULWwf/T4T7sQgjqFyNjaLfgyfh2CvukEcQ9XqpDgrtymFVPLPr1m3jDyTEDi9cRHu5M
	 j+ynglAsS+n+3xl9Zr/WdF4O2BC5JQAm5gwF1HKHllIL+cnfVy6EyPKu2aTKrPcOPmRkr
	 ysDcIkUq53Y2gAhShQNGtBaatB24DW7XuyqeEX+gYbUxJqgMclx/9eJzjxMD8RB6h5Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789040949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OOhZ2aBCsxqijZIzd7m/tN/SmT4Ml5ugV2Lo0iUBHBI=;
	b=AY6ZP1q6DzzLy7fpyl9wSOZZStZpab+hKX3erpa0GeQONZp44fT35FVzjU2gPeS/jhIZ
	 irSHA4hKpDUgo0S+y5bC9rmsuhXre3GXlr2xHzjV5qdIrel7txe0y43z/DnoNr4AspkLC
	 ot2sKI2O9zKYh3y3rKiGQ+mTlI1KoryLjY6aN3svYWJpgAl/FnU4w63nsDQra8ntE1JVE
	 Tbv+CC3mQ7xOPq0JQDQcq8KercgwPH+/uPWf8n7c/dTP/C047pEktt0644cG9AYMRsvkE
	 mCXnSqwaHpBSmuGg4vt9ruzDBsDBSGlkW1oO+zxtJJrdXLd5s7PF9u/Hvnc4A30p9WA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=V7c76N1u;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789040949;
	bh=OOhZ2aBCsxqijZIzd7m/tN/SmT4Ml5ugV2Lo0iUBHBI=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VXNI48dcPP4eNYufU/RgwzjMFAJhPIaumTJtd3wwG2qW/wtFC2cixvCsx+jXyCJIr
	 uIQo5uF9vkyr02RQQ4Or9eoIA9EOA9HoYgIk9e2IciMhNYdqmym57yUUO+nM6V++2R
	 dQlWr8H46hmoTEhhE6AVAMHirLJiyPN+2rHdj1a/9vKg6h1/CK8kWh/BotkV6TY9uA
	 Jz5GLqemepDLSzA47W0CzVOBCcWkoOiOJSbYu/jjYg32DRCjTnBgsji8EUT8Q4lxlF
	 DNUnt4mFuVxokv2z+XNtlZnIhfjkHTsZikz+G1nthKD2D0GAG9VL/Mx9lEFMHoxMND
	 +HZuFDB1IUnhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D31D440A48;
	Thu, 10 Sep 2026 11:49:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC8E443F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 11:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C223340A48
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 11:49:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3FLPJa37C6ht for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 11:49:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 22EA140A47
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789040945;
 b=H2FU/VPSM+aBJAs4RneYMkMPcKZ0F+hf8BLuhp4s3qN0696xKkbhLIdVg1skJPOaMkcB
 RBPav6yZl6M9fKR9VgbGYA4I8695cEePWQdCqFZMSKyo71pO6/7i2MLkbE+0Xskotir9Y
 o+xYUA6TP+89VDD7AQNZyx1HZcJc9uwlXyzvFx+TaoO4tmD+OMe17JuiKzwqWckJOIedp
 O+KHh5bT3dhIfvRGdLT9S/qhYx4LlDM01E11T4tcrGamLMYnk4LTzKwMwTPfksDQNiwzJ
 kFfHtIK7EGWuv+ST7fo8JqB7YSz+qPVlnVG3T4KX8guNYg2+QdaYxvSKblQRestpb6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789040945;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-Developer-Signature:X-Developer-Key:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=OOhZ2aBCsxqijZIzd7m/tN/SmT4Ml5ugV2Lo0iUBHBI=;
 b=iV2bV5o/0bH11NkxYTYQEtmsbJ7HvgYHOWRDsIZjtqAArSD06bAl1Nvi0RsHG1JFSB66
 //TCCZCuAorQmMCaqZ+GU25L4yYguLRJEVwOJXZRItJI0S7mMLhD7nywbo04fzH4Efv2i
 SerqlBRoJxd9wG+iucuEbn9cbjrKC/rSI30LmJwjrGP40W9p0KdXkDVq4LKksCyczCHML
 iLEXiaszNXfpEPW2fxuz6gQtEEfF8ns6Em1ssQCozuul8f+xWGAnUGicFv4BuFTJU8j3s
 0guhLrSFZZwOQ8kpw97qNllvM9ODMOWjGAaTbouksDvs4VHsv8rtU+DxXwxOupt34UA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=V7c76N1u; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=V7c76N1u
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22EA140A47
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 11:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRM3s2vhZSO/bQTG0BFJpFXmVdutCFlMx9raENWYW+g/typv4CmaVkvRDuytsXEx+YtUXe60JYlxNt/aNrKhxuvu6b5nE7TSMkq4w0eAIN1G1UrWbEHBY6gHgoSPnhFERYuVvaFhN4ulb53ftcPIHl6GMRYRIUOy71qqgCdNoeBRkH/MZ891s1NpfNIk/N5Fv8XMa2nPUAyncseJv4H3QE5KtcyT2Kv0/WBQWXj3mBJjsepPxQw1Jh/R6dp2R3MGnXkbfHEZe1ymmxP/DBopQxwIZigueMz1zcRGr5adwkrpu9F/EIHAT4bzX5jrhCBR2K9tDJOqVuimMUlN59An2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOhZ2aBCsxqijZIzd7m/tN/SmT4Ml5ugV2Lo0iUBHBI=;
 b=m/r2GQsn/2ZDzraP5aYuF60HC6w5fE2pc06l/32ORR2Jxh6z8YqT6Y6V2yB9r+sJgDkm0jpG5YVy2FCL/RD+mLQqQoua6w8nViHWTaCSB2C+vSIfVT8Vx/f10l3oezgkSQer9x5rJwbBEKpRcLO3FywZ/wmC4QwWU4/XWr4qiSqSmlnvN+OldXHb1bQaDB5eLQ+cXCIQ2b2D1ApuPlawRB6e0Us4u4lFv8Sz7j/Jsd33hnvR4Eul23tiTdlnUVW8KeHHOYUPC6OxzPip8/xmF3zt71mCutha9IGlQx1ioihb/MVeW0qiMUz8TMTZ2Y5XEP1HswkO5nckj5HC4RFoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOhZ2aBCsxqijZIzd7m/tN/SmT4Ml5ugV2Lo0iUBHBI=;
 b=V7c76N1un5uWD66vH/Oq/GQkK3MGjJHE7fhYkPtII9/DlKw9LWq4Yt88NiuOc71KZVmp8nW7KiCJZYyo816YCX2o6MryNCQHihFrke/Wcc1cp2klbmLPAW3BdKQy9I2ZspCD6Mr47BAV+UC/Lpy5lif9B+5b4HSFf7c80y65vA0=
Received: from SA1P222CA0160.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::6)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 11:49:00 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::4a) by SA1P222CA0160.outlook.office365.com
 (2603:10b6:806:3c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Thu,
 10 Sep 2026 11:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 11:48:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 06:48:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 06:48:58 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 06:48:57 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] video: console: Handle ESC[0K erase-to-end-of-line
Date: Thu, 10 Sep 2026 13:48:47 +0200
Message-ID: <7bef6b59da20d997f3ce70b6a8054bc25f15fd29.1789040925.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2859; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=WptrEIM+t0p4CCof7+KsYieVIuaxmo+hNp0i8YhDemA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQtmqnOOOfhgkkX7YSbVoTUPfHZxzxh6cvmeWfvdC1Xm
 y670WLS9o5SFgYxDgZZMUWW6Uw6Dmu+XVsqtjwyH2YOKxPIEAYuTgGYiK87I8Pfa4UP+9hP117U
 97g0iav4UlShlFm4d0Ted2/x88ftA98w/OG6X1C77CdXweqlDZd0/wiwcV34X+d0/kaIYLXfmkz
 n7wwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: 1defade4-8e5d-4828-dac4-08df0f318075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: Ls1ELUzCHyvTloyp5l/wxWRmnyvQi2kne1Y0Ly12lzIaFAoZv/woWTGWrN7ldvi1VOj+q4QpLkG+7I/VnPxBpXjv+3IdX2w/qEPAWLW1Y9n1PNl6Yw5gE5BwDZtpzWGcw/7VzPaumojBhCprqyDvg5Fg4EqSL3zAK4ueg1vemdGAv51FQKwqwySszbB7ym4BSXp8PkWlmZoz47JwxI4xSZdj2n0NTvkuVOkhjR7L5Wc+5BECQUSJIXVoYpQ4x1k9l1Dq3bEymCkdld0c7rHVNz0+ax30GPQNMk7+uJoSiAO7I3W32Plq23GYx7dAavx2IH1B1jeP8+jGq3XV3I/7y4fqNnkf1wDq1iJka2jf2Zqv2EIb0/rIUtn6PbSmCEz3KQa85UkVN8YF445062tjEiQvI8eCBWk//PEm9C1rk95jVqNsYLhxJq0g0CIMogtuyIutKANNFgLR/3SdlZGLUl1cMoOIjEQsmw59+XNXJ0REEbM7VGc/F0jAo3kVy2lUFOq0exkCVldZR9MTZU2HS0LUwCPXwGu3ixCXWY7i2y4TPIy+1rLdaJVmCufbvSfrQsF6HhjCw9Gx3HFfaP121Y1rOr9e+w5JwyEg2eC3H9h2y7+D7r8hqw01sMeueCk3hiCePqDLx1q/xfrffdvFKMrxrOjSAn37YVvSo0sEGjXl1HE3MbiUJA+pbmsF9YuAJ7BuiObydPtAFRo6eXNCwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E3i/aOnUGR09VU5wLDLl/1vnfsYnTfaV6UN6nuxSb6V2KUR57LozCQICUj6Z/ZIue4exwsUNTEWiJ/DTYRPajE7VteP3NiVOYqkIfrd//cL3zZoJYvJK78FfecCIK6syMAmi+LoGC7YIDY0g5EvOiTzRiFUVgELQm81eVvGN1CXvTLaOlHCigaE/iTOFCiSETk/FBKsXu/jaB92pEuoCP4wmNG6ayccaitMHtFqW482JHDBjVEa1/Ft6ovSxrvRHctsJatlNud5TFpPNAT6betwuhnYJT0uUQSlFhvOda5bPvuWV7F/BP/rdx3pYoEOtzmmq3BCJ9hbAU7QE9HbKN+n/2yAQYjiEm39e9W8rt3Cw0ZdO9Dg9gthgO+kauhUgtiIJ2xXLjWlMkt0iwUOJjg0FqBMEoXN3eBrcH0hKUkYSV2GMXKUYfuiOuLVgPa/H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 11:48:59.2273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1defade4-8e5d-4828-dac4-08df0f318075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
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

The vidconsole ANSI 'K' (Erase in Line) handler only implemented the
[2K variant (clear entire line). A bare ESC[K, i.e. mode 0, means
"clear from the cursor to the end of the line" and was silently
ignored.

Code that relies on it therefore left stale characters on screen. For
example the autoboot countdown redraws its line with a carriage return
and trailing ESC[K:

  printf("\rHit any key to stop autoboot: %1d\033[K", bootdelay);

This redraw form was introduced by commit 5f70be08b015 ("Fix autoboot
countdown printing wrong"), which replaced the older
"printf(\"\b\b\b%2d \", bootdelay)" backspace scheme (that broke for a
bootdelay > 99) with a robust "\r" + full reprint + ESC[K approach. The
ESC[K is what erases any trailing characters left over from the
previous, possibly longer, count.

On a serial terminal ESC[K is honoured, so the countdown looks correct.
On vidconsole it was a no-op, so leftovers stayed behind: because the
initial prompt is still printed with "%2d " while the updates use "%1d"
(an inconsistency left behind by that same commit, which only updated
the in-loop print), the digit shifts one column and the old trailing
digit is never erased. The countdown then showed up as
"45 35 25 15 05" on the display.

Implement mode 0 by clearing from the current cursor position to the end
of the line with video_fill_part(), mirroring the span the truetype
console already erases on backspace.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Tested on vek385 revB with DP over mmi
---
 drivers/video/vidconsole-uclass.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index f1b2d61bd8ff..02c234b463dc 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -327,7 +327,7 @@ static void vidconsole_escape_char(struct udevice *dev, char ch)
 
 		/*
 		 * Clear (parts of) current line
-		 *   [0K       - clear line to end
+		 *   [0K / [K  - clear from cursor to end of line
 		 *   [2K       - clear entire line
 		 */
 		parsenum(priv->escape_buf + 1, &mode);
@@ -337,6 +337,19 @@ static void vidconsole_escape_char(struct udevice *dev, char ch)
 
 			get_cursor_position(priv, &row, &col);
 			vidconsole_set_row(dev, row, vid_priv->colour_bg);
+		} else if (mode == 0) {
+			/*
+			 * Clear from the cursor to the end of the line,
+			 * leaving the cursor where it is. Same span the
+			 * truetype console erases on backspace.
+			 */
+			video_fill_part(dev->parent,
+					VID_TO_PIXEL(priv->xcur_frac),
+					priv->ycur, vid_priv->xsize,
+					priv->ycur + priv->y_charsize,
+					vid_priv->colour_bg);
+		} else {
+			debug("unsupported clear mode: %d\n", mode);
 		}
 		break;
 	}
---

-- 
2.43.0

