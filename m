Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6711DC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 07:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FCDC886B5;
	Thu, 30 May 2024 09:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p0qNfJ6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B053886D5; Thu, 30 May 2024 09:17:43 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 891E7886B3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 09:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx9iowfMM8LgnxE9f20suMPrI/ndQ+KVeVJg3OC3XSMfAJwLwBHU/FtEX/e4Cj+Wu3BEEVSKl3qIINzUYmkFbt+T9Z9774Jo0G9BHkZP4saqoJYdH+Qbt2/0O0s+DnI4Q3ykq6El9U6tgqC1BQHzXeSF4CV2JxqiH3hEBQCm5hIKR1BL66o3xHY8hRtCAQTB7g9aWjPSoG9oTZA+Hi81gmI27OKrpTfJAOye9tEvPU3/JaBq8SbglMjTDhRDX+GERcGlvUzqphK8pPJ90tyyrQmd/XYwoI/BuT1NFYy1Ks7PDHwaDobcb879lVoIDkeMjyEDu+qpAPHZWImosEV9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhM50wTFu6Awe4ah1iiWIRyN9yOhXdMbd8uW7zEqnYY=;
 b=RurB26QIp1TCn+6oxPB2OLRxZbPTOKoUaXFn+NHqmuvzLJambgZx7psOO7f3CL+yzgkpmEhx6eoqehRtNwicO/J2ipP8YNGOXqKxijKrW063rdO/CKunu3xexm+ei/KEzeXWT78oCfn2HipN8XgDjnkyz3pUNVeu0c3Gpj+UCsQK7gjzVPhvLMOSDRtBRCXtIt1oDDF7ZeTiSVZdUqMz5Q8zyvfKPLkAffqpsb7OvGpa5FGZlznRXu+DV66m9qsj0Z36kqNQZGPUWnemP6w/ZFjYD0/qlo8F8PjQ2IAN9N4XXoZffC4HOZYgMds8TlScqlBDA8QplcXDcMvSb9NE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhM50wTFu6Awe4ah1iiWIRyN9yOhXdMbd8uW7zEqnYY=;
 b=p0qNfJ6xChOx62MQObz1DMGiSp3d7CW+Zb5lQbuehPnYqITQDTJcWiCq0YRcQv4EoQ+MWz1w8EGFzHBDm37pZddCZ7tC+00aL/NnIU5eYN8vneRHs+QCcXpjrrlcB+qP3eZEWEHxaDlW/xAJhFSioxy0ErsFFv/JXrBh7wTatb4=
Received: from PH8PR02CA0016.namprd02.prod.outlook.com (2603:10b6:510:2d0::25)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 07:17:37 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::9e) by PH8PR02CA0016.outlook.office365.com
 (2603:10b6:510:2d0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 07:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 07:17:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 02:17:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Tom
 Rini <trini@konsulko.com>
Subject: [PATCH] efi_loader: Fix capsule_esl.dtsi.in comment style
Date: Thu, 30 May 2024 09:17:29 +0200
Message-ID: <44cb3cd74693814e28201956b2ef739ef280ca16.1717053444.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tqdMo3Z1IVgwgF+6b6V5cPlMXhMdnF7uh4LX4I6ZB1k=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQIDda1Sm5LCiOlO4SmN5j1Xrmr7rpt50S3e9OFvUsYn
 v7XEC7tiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABPp/8kwzyr5kYy64ZG7GYmn
 3OZ9Xv7+mKThNoYFfaKdf+fkNukopB1sMPgR7sVclSUMAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|PH7PR12MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 79616e9a-2eb5-455b-5ac3-08dc8078955f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?geuc3Pu8MpaV5LcVdQPjE97WlcVm4HIRElzSH7b+rbu2KM0Bv13YZkbpGFcZ?=
 =?us-ascii?Q?yz5g+ukqmcf3ra0aBwXdoAzAp+YiDZu1eOdecSR7Asz1g0XI5qjuPUukS53i?=
 =?us-ascii?Q?uR2IFTuLy0WEIPD/DYcRQzKul6sUouVx6XUpoRDgxW9haGtbIvXDMwmNRE5z?=
 =?us-ascii?Q?EJAv0pouSaTC4CLE0B8XVdBGHJqAv+ZRJkQak3psGY7alKfvg/04ONTLT2Q4?=
 =?us-ascii?Q?VzoH4ThF8sI25DB89356LW4wNo7o/HUJOiZCa0pWMZZkl8ZSuek2OcgSeOC1?=
 =?us-ascii?Q?/uBj3bmKOGYmavvtnYNlptU5EqSTIszHbnqp8EBv9XjWCRokCdcZBxy4hFMr?=
 =?us-ascii?Q?+1m1ahXgxEmRzXAPxLNyBzobi0/Y2YVx+q51UWGiTJJo4LuqzrQUY0nMSjWa?=
 =?us-ascii?Q?mFQjkH35TTW7Q3wScofcUgKFl0zB3BwMa81ve1QAveXYLMteEHBi2LZAPmFU?=
 =?us-ascii?Q?E4TnEFazKj1KZZNMHcxtywkmh40Bai+ylZDOZu9JemJqj6EtC8VDvE/77bu8?=
 =?us-ascii?Q?ja8klaDv4rV9OuoGvJBkZ9f4OMjYNWyYY9gDiwD95VlIWVlmDYQnBURuGa2n?=
 =?us-ascii?Q?klgbVjgDuDBt+obzFEPLIJJLljbL3gx62xaTMi0BHZLDdLRsBnjYdKeaFlxW?=
 =?us-ascii?Q?6Vhi6lF2U2d05tLocqFAj54BfFzgNc0mON52dwzn4XqAvX+tXvCWPIJBDI3j?=
 =?us-ascii?Q?0gMrzz7jGgqToC6ey9N/QNZ1ZIQTUT0SKa1oyUpckNjXDecr6Wm3bECN9kMG?=
 =?us-ascii?Q?5lIUKFl3OTFKQEhJSGER1YLnIhGAHS0II2iGUNUQ4swhQ9aJDreUuxwkDCXq?=
 =?us-ascii?Q?6IBLP/ASOYgd4FSBbuQ1uQg9XCpNCvSrncxyd3ZXc+A6OdhgYz1wcaBv2+Qo?=
 =?us-ascii?Q?obsQLSh1IQt7tkrH+p5sZmxVb84XWz+0RG6iYE+FsZ8CMguioWvWcBtV4sqj?=
 =?us-ascii?Q?gXsx3WxvSBpxjO9XwZu0x5ts6g2Lv+h+DrKjXB2Yz7Pn6vPaXv2FC4tNxXCK?=
 =?us-ascii?Q?rIqJK3fVgGmMIHukh/hYYHjte9k8RTw59MnrgwZhLlFvp7/f2I7lF7147lG1?=
 =?us-ascii?Q?7bYHVoWCKQrpH1LQ2RAThktsSN0S8CI9hwm1OyfwwWLWx41Ynld0QBI7U5hR?=
 =?us-ascii?Q?b4IMrK2Ek78wEfsxfYBdCsDmoShyXhxOR6kUMrzjWidW2Lfqhi0oeBgv6UOw?=
 =?us-ascii?Q?vtMuq6dFs/8bX6OD36jU6UYDL9yaxX7+wi05UzlP5sNPiqWl3v5ovgulezN7?=
 =?us-ascii?Q?y6wc2Djn2njnrsSA1WnFAjcW5GnL4Ld1iNtM5XBQKpYkyU91jo3Nr2digaK9?=
 =?us-ascii?Q?OrwP0gy2ZG+qfp0f57Fg12SuMOMbovvt27pb6iCdPUpmXR4skBpQSPNVC93m?=
 =?us-ascii?Q?/6U505I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 07:17:36.9627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79616e9a-2eb5-455b-5ac3-08dc8078955f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178
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

Comment is not kernel-doc format that's why don't label it like that and
also fix indentation to have proper multiline comment.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/efi_loader/capsule_esl.dtsi.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/capsule_esl.dtsi.in b/lib/efi_loader/capsule_esl.dtsi.in
index 61a9f2b25e9f..bc7db836faa8 100644
--- a/lib/efi_loader/capsule_esl.dtsi.in
+++ b/lib/efi_loader/capsule_esl.dtsi.in
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
-/**
+/*
  * Devicetree file with the public key EFI Signature List(ESL)
  * node. This file is used to generate the dtsi file to be
  * included into the DTB.
-*/
+ */
 / {
 	signature {
 		capsule-key = /incbin/("ESL_BIN_FILE");
-- 
2.40.1

