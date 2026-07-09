Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2078C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 14:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D73E284BB8;
	Thu,  9 Jul 2026 16:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pe2W0RE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF9E584BC8; Thu,  9 Jul 2026 16:29:40 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F1E84B7F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 16:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3JOKTrt5dnE3ZQkhjNdFb/h0Yk+dX7Qke28c0ll9uB51Hegf5eOuEStxzY/uv8nL7tmRbM6o7MrGPiQO8qoT0frxmnYsWpKW01Ar9TEFRQGEHns2SCmyIkaoE7jSQhouT/djuImLUZM4wN8Is/wjCy/Aii3Mhg6pXnAFeX4dVKJ1fPpnDtlKQ7pGygld8x85dVbLZbL1nIqKpP8AgcAFPUEuJPxA05uWx+JF7QqzWON7d1xdk7F6NT3y7j379Tw9Rdr6Wh50qXDzQEipX4sCazQeFa+6VapKQyzO5yMq8+xJNh81mS9jndZ458GrdyI0BCYo9jEifcLMsKMEcOg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIvrdHnFFK1RWV/GGQgvpY1LSI6FQHPhCa+6f042sYg=;
 b=OvikEXksqFeGOe5fGAFpGvaFO8Jtf0dFRdE1eVVKhy2tMHFthRz7cpe3BwB9H0R/6av7fk61jeb4AtuWYDtCwj4N3V7ea5r6yasSi3Dbw6qOSF3n/I6IJaec0N5vDhe3e9LB646PQl2W+sy2QYNGN/5moBUYGV69T09UAl5t/1pADJWWQZZ5GaV4UAQLVz/1gRLEnCP0ZQqxakLdH/AyP9MKvkH3PV6D2xTBfZdqG9VqB6u6np5r07P6mU9CvFZiqAJf+bBTpWoe9ontNROOBI8wPD0HKhGScDXwTOLJ3agoS26u6Z/o+inKlRvscy9DLY3jOn+TBljQvTEtJZ/Q2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIvrdHnFFK1RWV/GGQgvpY1LSI6FQHPhCa+6f042sYg=;
 b=pe2W0RE48oZB2MPb8LEgYuC2SRcD8cvi+805ZEIZ5n5O+i+lRbPsUgUxyRd6pjqLk3VTmp+xfWw6lOYxLf68kg0bm/j8wz57l60d8FgPZQ4i7WVK3sKTfUE8+X2XJo8VBoomp6ZxNWTldPd+/5Dg6YNBKVez5M4Srr4Q8ro9GCE=
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 14:29:33 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::26) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 14:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 14:29:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 09:29:26 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 07:29:25 -0700
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 09:29:23 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 1/3] gpio: uclass: warn when a gpio offset is already claimed
Date: Thu, 9 Jul 2026 19:58:59 +0530
Message-ID: <20260709142901.2054431-2-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709142901.2054431-1-pranav.sanwal@amd.com>
References: <20260709142901.2054431-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SA1PR12MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eae7fe3-08f8-4aea-604b-08deddc67ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: k56WK3GWtgv+YRckpCE3UiWfWzgzcyh+KRRxNb71NpnLfIcvcIX0/C8xjE9H2Es0xP5uKEw14ISNeg+qSofVF/qGNFvB5yRmjfNC0NWq37Va5a7itFHeOlEFkyteKAeemnhCeMrfi20jaAy2H8BUC+cDNN3tRx+lj9r7se0tixXjt1lFLM90jRb/FQUXDkWZQR+8gMCtnThC2bfLXnq0M9d0CEc0DQJrGLT/2JTqZGTUfFF/edKdfUCkiHGsg2qzwxiVmeOmtGvtP0fL/ACxA1S9fFyK+zIdsf4U1TGiF6s+try20TpFGYoo33pYhYndQVJtC2Q1JlPGBPRi6ov8HGJE+Av2mxixQV/14iddGgdJsDLdFZCteliD6FTLN3Lbkx7oszGrmfwvCxzFrgTg9V+XMQac8qxo/7SA27M2gswToXGJexVybUuqwYUYFrcqj0gjijGm9sevndheE5/xdH614xdtFQwxcns3h8aZz1giT7/vhPVzN0KBwGCZhenoD3JvUCLpF6NpyAhip/PCCD/EFFS3B4XrMZIMdJbcnxmGEFQHK+jZhi9mvDmcLlf8/+0+Q3xHxEV8jVTd5Jec3N4US2pCixTG7CYC0ahVFXYLE+Kha6GRilfSPf+/EzzKRN8k7wbI72OGNJ26jqbXEwoElkKkAw5IOnRfb5pVWn+Vj/AliyIzKhikEwF9yaDfFOPffFPkgp4v0l7upKtkwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mzG/LtfYtccSMGLpqi6iq4NaICX2cafKssvnVd/6vPUmCv9W738OKQDyFDPBhrZA3kmgxrvAhjTuvPH3LvzfAmUKEkIIT4CBLwhE045QLGiO6h3tSJW58I/LYLuCvflhfNY5kZ+0ojBkfj0WFhLbtAgQ8afQ0Tj5O2H0YUTkoCesAcJJaMyVgvGTnuFP5aiHEEE6S0iGoTFJTrk6vjAp8ISRZ/zi3XUbQW0mTNQHvEggcVLW2IadqZ/ZpbN8b8Rh/diUJzjmWyIuWLKITaoTh5NzI7dm7k8jUHC+7QAizZfwp2ddijlkyglaCXcW3NKG7Vkf8mPZDOjvkBeBnK/ixXTvpN6Wz9kxbnN5BZx7+G89lqSDUZd+B14jfL+2HFXTR+aSdXsz70zxK1Tid4kYySdEQf5fYvMtm1jvVy/pyd4UcFFHHT9uWlIJxgqgVio4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:29:33.6192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eae7fe3-08f8-4aea-604b-08deddc67ef9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

dm_gpio_request() returns -EBUSY when the requested offset is
already claimed, but gives no indication of which label is holding
it, making an offset collision opaque to debug.

Add a dev_warn() printing the label already holding the offset
alongside the newly requested label.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 drivers/gpio/gpio-uclass.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 7559b8dc7e2..45f7367438a 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -391,8 +391,12 @@ int dm_gpio_request(struct gpio_desc *desc, const char *label)
 	int ret;
 
 	uc_priv = dev_get_uclass_priv(dev);
-	if (gpio_is_claimed(uc_priv, desc->offset))
+	if (gpio_is_claimed(uc_priv, desc->offset)) {
+		dev_warn(dev, "gpio offset %u already claimed by '%s', requested label '%s'\n",
+			 desc->offset, uc_priv->name[desc->offset], label);
 		return -EBUSY;
+	}
+
 	str = strdup(label);
 	if (!str)
 		return -ENOMEM;
-- 
2.34.1

