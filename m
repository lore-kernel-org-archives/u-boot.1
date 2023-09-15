Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B51CEE645A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 12:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 163608692B;
	Fri, 15 Sep 2023 14:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gf0uMSXp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A39A868D7; Fri, 15 Sep 2023 14:12:24 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 686AC866DA
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 14:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8HREyVWA8bAcDP0Weth4OO3HpCXUXmnoSn2pwKIePZDVbcfWO6NOWTRAVFIzQGtc+gEJdg+OexdiG/zmIXimwik8Qew1t73LvCr0rO6p/DI4g0zQ7IDCcfDz8Wo+Af8cwsz9jvdKQLFBbXzGhQqpyLW8rQ1+w15VjQXocgS6NY0Y4AQfg6EXQGU/ncZYKmNTK/erwm7tX7rfjo++OfnMDLcDCpIdp8jszxQcUpXqjHdHLdTbhYmMB+sG/hOmeetA4o6DDmQJwQmymD7PmC29bkpReeGVVh21w2y6qmzW99oBAgte9mfY9F7Hkl6N64087V1C7gouvh6khHJbf69zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2tG0oMDMMsHZTb24FQHVY6+2ZVrb5CPSem8H2qzRCY=;
 b=m7Q5JnCPto6/S01wzQVPJjur0bTHnKruoo1qthB7vp380WYhSO/EmDYUWxt5tf+mWu+Fbg39i/HqSy7sRZRAggcbexuFrhopvQTsyweoVfjEFtk/A4CRh19dJWUQVeydsWp2JvTNoblokIJB86iCVMhpZuuf7tASprcghSd6Ilj+jIesQUQFF9uwuyoztAh1eoZfoXnZWrQoua2snpHVg6mRnLmZ3aIglSxgDT23rTEiiN1WyhrRav/cUy1DgtSKcfkVS3UTuRU3oXfzabDCsJmwEPfk3PwZzz2ITZTw7tblgIccJ02APMSQQogIVGyWVUxIT0Zz3MIpoosPSMlZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2tG0oMDMMsHZTb24FQHVY6+2ZVrb5CPSem8H2qzRCY=;
 b=Gf0uMSXpFPTYOxF60Co2A+NyyJeDrToOJCNsrfR8RT9E8BnMUMaUPNYhgvGi7xUv4abNfwDouhIRibXCY+hfD+Wf+mfwXdeKeHIn20Em/okPehmTbgffjsjTSS2F5XmERwXFBi+DaLvfoaOUH3ch4IvQv3ruJg5Qa24L2UuX5WI=
Received: from SN7PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:f2::21)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 12:12:17 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::e1) by SN7PR04CA0016.outlook.office365.com
 (2603:10b6:806:f2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 12:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 12:12:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 07:12:10 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/3] trace: Use 64bit variable for start and len
Date: Fri, 15 Sep 2023 14:12:03 +0200
Message-ID: <6edb34ef1f10010d2380f964fb6b4fb3dc257799.1694779918.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1694779918.git.michal.simek@amd.com>
References: <cover.1694779918.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=812; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=podKwQe5s9kYfom7nwpIhcT/1IkBac+RJwPSnSXi7b0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQWLyHBYqbHHNHJVScmvuvLCdnxyVhkut/Ga3xusUY/T
 5z6nPuyI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwkVZZhwRTOpc6XPJQOxh9s
 61LZYiTvblxXxzC/1HnFXgn1zbnSAv0P5oid/btqqqImAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 541e9280-8ffd-4cad-eedf-08dbb5e4fdaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CExE0Q1p1OXbItMD8c2uo7iDMV+ycRNbbKU+QA+ukh5GZEEfoXwHwDe8njPArEn5/LdUehh+uuAsZZfrXOGDzxfLNZIKzBuhS1JIKCR7tsjBjrzN8HOIUzFoAS7OOorjzyBQ1k/vTBHIrwG1TvIyE3wp+7KV6tJLkd4QhvrvqyKWdQqDNuHDSYTpBCoGz0m3huHo4nP+O+FGJlLjHiZnuOMI4S0hvx4eKlNBLwhjRktEg2fZ+/g3WcaEx0kdxJIGXTXWokv8Jn17YxPjnkwGJFV0r2GYVEHfqXzerXaRVXmD+eTAPLfbTM67Jnpby2uwqyYkK2CAJZP0tBo0X1L8ns4xNNBQK9dCH7EIFwftX0Bn14TeR6PlFHGbizG6GKVRjrlEUiQ9t7h7w16eSrFcZZgUeNbcwB2rSs9NxUWknTCX7oB1pL/U6AoE78jXuWGwpdTEI1tWM4f+YpfrSsUN83lxPZ5F5FQgh1FieU7Q0CVksdCIZyH1aH6nNB8aXZb028ohzI07fYS/Fs7eEenWV6Xq+lsbBvQX9dmjx9bktyEwCNmD6PGyCBdWDclDbJgF4AC1eM2g+aWkbNi6yENmbZohwPrIK/dZhurFyQxK3M3yeJGZ0dg1lFwnm/t1yQGkKCg9n04jFGx1uea5d/Z/PlX8jDv8nEcKs5TEEWtw2uDPluUhIxtmblpQDRsgOsIwvDLUgbGC6l2FRqzm+cmstG6gXAKYGcrLzpl6fUyyBgeagf67OFxIiC5hsLaC5IcNpG04usstvcnm2G6b3HPNUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(82740400003)(356005)(36756003)(81166007)(86362001)(40480700001)(36860700001)(2616005)(26005)(2906002)(336012)(4744005)(426003)(478600001)(83380400001)(5660300002)(110136005)(47076005)(40460700003)(8936002)(8676002)(41300700001)(70586007)(70206006)(316002)(16526019)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 12:12:11.5924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 541e9280-8ffd-4cad-eedf-08dbb5e4fdaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
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

tputq() requires variables to have 64bit width that's why make them 64bit
to clean alignment requirement.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/proftool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/proftool.c b/tools/proftool.c
index 101bcb63334e..869a2a32c510 100644
--- a/tools/proftool.c
+++ b/tools/proftool.c
@@ -1493,7 +1493,8 @@ static int write_pages(struct twriter *tw, enum out_format_t out_format,
 static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
 			   int *missing_countp, int *skip_countp)
 {
-	int start, ret, len;
+	unsigned long long start, len;
+	int ret;
 	FILE *fout = tw->fout;
 	char str[200];
 
-- 
2.36.1

