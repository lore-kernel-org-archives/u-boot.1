Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D281EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 13:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECDA86568;
	Mon, 11 Sep 2023 15:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wPFZcpQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE2386680; Mon, 11 Sep 2023 15:30:13 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B793864AA
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 15:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfU2RKSnKX0RGldhSHADjq6bL1N4Yclg5X4RszgD5xZ7vRjYoKCC1OzIAmGo/Jc34UcoOtMAcdmZICm9j9J6w/OaGk8NqfvGx8MSuaeveT5xYUoUM5OZroSlri1hmFCfJOO3XtcPsQ4g/8RoRng8YwIToMlmuPsLoBkDpuDzgWoHDr+5TPgABmxnLFK6ObnSTA1IEaSJQAoDpY+ePKeNNhx1ZXm5S3Ge6BlwwjClyDG3+gcX5baopNrMSswK16x/szcTCv9udZVUY5Ex6pKoyL9bnGn4ypxCIHASbJ/ixxxI5PpfYauXVPDkzlJzocfBC1xP6N84dfhiKNWatNDcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNsrmZ01aJYJILCbleazMf41DNSZIXmugzwRY/anwos=;
 b=SpObA9SiO28yIsxYrXERI+d88yxHNoGxfi/P08qR9EntsJVlDRdSH2xZEorjAMogfChwvA7gV9Tp6fk0jeNfMFfJL3V4qtw6buDT2Ke/TlGXx7HMKxaFjeNiaPW/3n2sEfh1T7OUURUsuH//I6bzvi93OWniqbBkTd3YwImSDvAWsdhWhQJkKgzRLmaUkaSeDsJ1Sngbe2Xzd3ERrFQpw93T7mXvxzpq9/mjIt740nO1AZx9UsrOUGBEFN4Tx0L7wLn9VZPrjW7z/nJbJQC2fUJ7irII0XVnuUO6HSQTkh9xgPLc6YwMdvNKK53O2kvO0toaXAzpBxa5h2H52+Z/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNsrmZ01aJYJILCbleazMf41DNSZIXmugzwRY/anwos=;
 b=wPFZcpQflmN8tCX9XoJvsqRVDAq2AWyaZjx5hUMVIpma7JoY0wUeXNz8vCamYYOhsLrp3k/uS49Ubk+u4ZEvDWxWyc+8NTvqJd84aYYO6l4sqckcIz1qmjyaJPysJ2x4q9/c8y9iDOajAyXpdaRMXogU2FTlB5WPR9hrU7BHqrQ=
Received: from DM6PR06CA0037.namprd06.prod.outlook.com (2603:10b6:5:54::14) by
 CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Mon, 11 Sep 2023 13:30:06 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::b9) by DM6PR06CA0037.outlook.office365.com
 (2603:10b6:5:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 13:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 13:30:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 08:30:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Simon Glass <sjg@chromium.org>
Subject: [PATCH] dm: core: ofnode: Fix error message in
 ofnode_read_bootscript_address/flash()
Date: Mon, 11 Sep 2023 15:30:01 +0200
Message-ID: <ff62e980237ab271cf05facfbc306e85914a8c6e.1694438999.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Zu5XTPV8kakty3Kx8Zrx4Eg1WLrqxMsa0NrdCLIL1lY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT/YuGhz5Zd7roW7SnvrnXw4Anu+VelZgVPvqsXJca/W
 tSgceqEjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCR/GMM8xTmySzjX5Kgcqsw
 fIb7/jvGTrKcexnmu6V9TEyw253gEXfq4+aCUrHwh9M3AQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: e7337b6e-7c74-4b76-b5d1-08dbb2cb3609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4UCwx9EmM/pOw4pJL5T8SXoP7q2xqP4QRwHFQmPCq4nqeAJul/sdUeA3BezpUXlp0YHdhbV4UpsxbwSk6ojDpSgeB6cYUyx9vsbIv4GswdUiHpyFNCQ+QIv/7xhdQfSFy/Zoh0cM9rAgVSPTBhj2bQgKOdMijoh/UvcGdSzhXd6gLn9K2t0508LZ+Qqz5+d41w51EcCA+8090/aotGYXJ22o02VARgEHONe1UYLyt1V6K2xDBiu7X0Aqx/YpmM9++Z2DBD62dLSutqi3ktpMzn683I1W9JdX77PARq2dwgHLkUU2cVXEApNeFG1MB36hMJlkt8XQ+FYm3jzld7PKssYfkVmWzBZtjsAKg2yr7vCWgMSrcv7bSWpZH2hUSa5RGDThzYgEblIFJHxSOQEqDsG3Mu4haxyFT4smDoi8ttCJboV8dZBfU17kLU4c02vZTUErNpVcLAQv/IFfbfcOHv4lLCvM6jiRoEAbrajLa1DXgHBCxXphY/ErteEokUHOZxS9nBRGP6sm64sgsWtRrtkg6XvHsDnJvRgZaUf6i7izTIJ0O9O+/oIgLVKod+hqK5vSqPeqTWkfKOuKUs2813g6Qv62mERZu7bMgtH6VbjreDALKsFUP0/SBB/8ZuKVI4ENmnAU+qdxi+krEnpDH1R1zND74ubHmfL/vbPvKoGK1nRIjf3DTjgsmC6eMildN1zauKVOC9cTVnryzrPjSVy6jF0T7lQCWjNjxw7WDD3p28CYplAmNQuBVJw317lLeRAQ5j4qtkY2ipBEjCRKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(46966006)(36840700001)(44832011)(8936002)(8676002)(41300700001)(4326008)(110136005)(15650500001)(4744005)(70586007)(316002)(5660300002)(70206006)(2906002)(40460700003)(356005)(82740400003)(47076005)(81166007)(83380400001)(40480700001)(2616005)(426003)(26005)(336012)(86362001)(478600001)(36860700001)(16526019)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 13:30:05.6830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7337b6e-7c74-4b76-b5d1-08dbb2cb3609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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

Missing u-boot node shouldn't be visible in bootlog without debug enabled
that's why change message from printf to debug.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/core/ofnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 2d82f38db36d..df2d7fdd535c 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1603,7 +1603,7 @@ int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
 
 	uboot = ofnode_path("/options/u-boot");
 	if (!ofnode_valid(uboot)) {
-		printf("%s: Missing /u-boot node\n", __func__);
+		debug("%s: Missing /u-boot node\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1629,7 +1629,7 @@ int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
 
 	uboot = ofnode_path("/options/u-boot");
 	if (!ofnode_valid(uboot)) {
-		printf("%s: Missing /u-boot node\n", __func__);
+		debug("%s: Missing /u-boot node\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.36.1

