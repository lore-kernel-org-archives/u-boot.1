Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACD4E810B2
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 10:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1181086AF7;
	Wed, 27 Sep 2023 12:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XvxbiUWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A10805CA; Wed, 27 Sep 2023 12:03:13 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED70F86D4F
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 12:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT8UcoXPsdPIYqkirFD9Dze3zL0IEABY4c/zdnNq3vZghGDjFzplVk62u9sXmP8NlQ7I5KeRmhC4pYf1dtQW9jcWyb+LeFaq1LrU5npnSGKrQYJ6EDR+gJHuOJOuyqOGAdTI/XBbPGx1MvTKUexWCDh71YR1fCBcs54/q7fK/68xGIPjF9lJlpEEVPnCnQHWk6ncoTERECdHFwTJhNB3Vbh+eAiLqpM5dC2O0uDSH+z1tC9cdNkwKxgzGazexT4ZqKPXe2UTvjj/BWsbCTbCbM94tbBMhF44gorAGwIP6Ka890r1t2lGG5L0GbMpsinXkRBfqdXURzx6ufQUsQ5udQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0yGL1TACbChKWgzGmrHLGrC4jjqapk1GDuqcKmr9Q0=;
 b=kBz2nkt8mu50+kRUmjPVb3a74LKKwig8pFyvZoAr4S+/UogJvR4YyXkrSNEAW55aUEChCPrDdKHt8bH7VApb1D2+ieHi46wvmt3/G9ofBurqA60z3cZHEQe1ASHNDYNpAHfU7pQuyKr4fYEFw2ASN3RHrTXmP8dAcbKlsVULHECrqNYQfvIm8t5zcJDJkyFcgQJgP/koKy2xtB6nbWDZzuNg2kAruuzDP35GiVnO6Npum7JNcftdXknyamG7yRMtkCm0LFpcqj7GTAGoj7I96FjZw2iykvOQswWpe9HnbBM4FEnRMNUW3B0UCbvnEk/WWi7FsCaqZNo2EROWM9GlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0yGL1TACbChKWgzGmrHLGrC4jjqapk1GDuqcKmr9Q0=;
 b=XvxbiUWkUcQwwjWfAjtDITVTL9p6JaEtUryZrxPjDhPqlavmm9VvIgiIZM5NMryeYbI35hh2LHYKtxUuV5QQ1YgK9vbJTtpuxhe6k93szMMAbDTqRquntQ+qgvcAOa22GFoQSqS4U0tQ1hv47lPnphv+Jcywkp7lshDccL9ys6U=
Received: from BL0PR02CA0062.namprd02.prod.outlook.com (2603:10b6:207:3d::39)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 10:03:06 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:207:3d:cafe::d3) by BL0PR02CA0062.outlook.office365.com
 (2603:10b6:207:3d::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 10:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 10:03:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 05:03:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] Revert "clk: versal: Enable clock driver for Versal NET"
Date: Wed, 27 Sep 2023 12:02:53 +0200
Message-ID: <c09276022db5f1b150679cc7a9f9583363ace2fb.1695808971.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=S69wBmC17bRtFw8/ElPuEgsHirDDd4OPbBP1jPe3mz4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlThv6fb3xe8Wbc3Oe3HC7EIsYVch1L85XLeSKVMVdS8/
 EwjbVt7RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjI6y8M82sD7q+pXjVtrQBH
 RzGLQbfqidJOQYaZjJ+OPWd47NG49ZTUubgVzRrVfg0rAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad5baed-aa99-4121-3e9d-08dbbf40f233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBmDdmOcFu1fBjr4BqInrXCU3T5C/nWNlcjXITqeWaABSoznq4XWZVxltCHQBW2rrUgvINBAXt5jJ3gs7mAUn6eBBbV/XGVwecg1V+WW10cSfRKQkVtiYfkFTH/vAnJuJPV1jQkbeSEtI/XaY4CTKezdXmq9NC1jqyDxg0MsaFv+4K278odweKosnbNS2OnsA2TwVUpdxuqJKY7rCoS+3uLWYy/C8qaFVP++4HDG3oBNiiYl/LoysE35MVrRY8GYHUzIipO9sSxtoVtWVD8Htpc48ntTdo9/k34h9YYaJBoO3A7Ykr+UfAEYDLpbSWQFt+w0BtNMy1qgsv9jG9OavUkGUuOju/S5iOkhHKugwI+Dx4uX5inQLQ10oh6DNrMZ1mAexNUvP9RwH5lQxNtTlUdreq3b3pyxndF5qtE29/fXZIUbMn8VSY9bn06ccBl2+65Q7VAvQvpvxYuAU4++TIeEdNOd0fEKDhrppZJI9BA6bPAtuHYDFWyfiGMVRuywveIyuKg5PnIpy2xu+nyaTxVxK3bEgxl8lOWaJOZ3yD49go8aa1oHUyK24XqbSySiu8FqkliG9zBJ/NSbPtrCb507cb0/Khmoj0f+SOCC5rLNlzdQ1cscCPsiUeXIuXb/Cv3d5FlG3xIUKqFipiD16vERz1ouOrYOsy9Ut9WzLRoGI50dKXxcwX2tHIddsHR0lTIWrDnwl0SAskzF7ZXhVyfO+GLQQNtApMLSymSdMj71D6OhZfIP6oi6pf6BA1XmVGQacmPMa4P0Z8N47cfqHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(6666004)(478600001)(83380400001)(26005)(336012)(426003)(2616005)(16526019)(2906002)(4744005)(40480700001)(316002)(54906003)(110136005)(70206006)(70586007)(8676002)(8936002)(4326008)(5660300002)(44832011)(41300700001)(47076005)(36756003)(36860700001)(86362001)(82740400003)(356005)(81166007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 10:03:06.5001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad5baed-aa99-4121-3e9d-08dbbf40f233
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
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

This partially reverts commit ff33227819f579ffb963e0dac6bc6a6566b89563.

Versal NET clock node should use "xlnx,versal-net-clk", "xlnx,versal-clk"
compatible string that's why it is not necessary to define Versal NET
specific compatible string if there is no any other change needed. It can
be get back if there is a need to differentiate clock support between
Versal and Versal NET.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/clk/clk_versal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 2e004beca2f9..c473643603a4 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -773,7 +773,6 @@ static struct clk_ops versal_clk_ops = {
 
 static const struct udevice_id versal_clk_ids[] = {
 	{ .compatible = "xlnx,versal-clk" },
-	{ .compatible = "xlnx,versal-net-clk" },
 	{ }
 };
 
-- 
2.36.1

