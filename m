Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EF5C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 11:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF12F87BCB;
	Tue,  6 Feb 2024 12:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HxUzPh25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D92EC87C09; Tue,  6 Feb 2024 12:51:49 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95FE487BC9
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 12:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgM8SzLQHbrGRL+Or8e87S4Lwg1kuRuEhrHqqz5oEFSY7jjf1PAmz+VNr5qf94Hpe00Mr2HvXTAfC3sVXp8KwAmJBWeFwd+QhPP6JGX3ZUvQykQqLwjLmaffXan2dz5fqd3zyiYEAQd0DzjOvwfd/jdLJ2NoxBjEJpne5CZkmXdfUWAKioj8YN49w2j7ULw+dlE/9AYWf3rIJjmEN2Y4l7zkeQHa4n8T0IbfgKyIUpMbDVGqbN3nDvSxchAN0V+BvJAhzr4aQp4Byf8nYlAqpR6pO6RE0YWZ/DVaLBGlGeu3v1sGdno4wn8hKAaVs/9XDuTxnDbw8j2bLwS9rLqOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03XM6W4ZoC3xzrOuE+Ppx6oAAsesmGsJiL23RhJQKxo=;
 b=oSrcPTomIXnQ6R5L/c15txopJ/LQAKkD6G8ysEsLCEE1Hs5I4gAqEiK9r39BEMwcurZfofbjXcIAvOSHKLKkcRaPhTT88/opy4BLuto1QJATX54sKSphn4txP+aOoQLu245XTUWsVQjYqzMhGNSSfcqe14F9sKU7TTHoP6n30TzWoauMa+jgRYl07Sr476/Th0ncbApxzhXh7mkI+BKRWr1MTahfsC+6VIauGaJ02jb+lpesVAPylZ7gDurQceXYtDervxJpVZgBj273OKX6cbuurUSh0C7SOF+aM7jxPOjpuAr64VqmqZXlCM3XMfL/9zLw2ozrnaFAAfGs9kUxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03XM6W4ZoC3xzrOuE+Ppx6oAAsesmGsJiL23RhJQKxo=;
 b=HxUzPh25yWTDoyM9s0StCAiZa4HlEepRQ43ZEw6sJxciITmGuw24drSfcpmm+U08dfRNLxiqVya2RHVAvPOKmVGE4Di+Wsr1mUc3b/J6Rmyps3FgFKGFSDfpT2sTYe8WiOJziJ0rQuVN4q+jTSdmL5+USX0B4nWnsq8fxnIAVE8=
Received: from BN8PR16CA0031.namprd16.prod.outlook.com (2603:10b6:408:4c::44)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 11:51:44 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:4c:cafe::b5) by BN8PR16CA0031.outlook.office365.com
 (2603:10b6:408:4c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 11:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.0 via Frontend Transport; Tue, 6 Feb 2024 11:51:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 05:51:42 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: versal-net: Setup correct addresses of GICR/GICD
Date: Tue, 6 Feb 2024 12:51:39 +0100
Message-ID: <5d3d0e1afb1f673ffeb4a1c5d7f040475c806a30.1707220293.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=rg4xATvdk3SPWXnO2gsghukvRyL7mxPMzO4GaAcuHN8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRDsm5V5lGW1y/ckPQ9+3Qf3+djR+d5/3Tcn/ZQWps3s
 uF7p5lxRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIEzPDgsZjsUzaDrMZkvPX
 HH5hf3ZrjV8HJ8M8vbpvHwOK7t34Kt9SJ7pjVxjvu2Y9AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: b208776b-90df-487c-5149-08dc2709fd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kig0lsxsy+0TPmVIw7Cs9ZgIJ9NxxO2yv9NnI7pxL8WgjS71udbJbHqYAY5Ys3kEyN4JoLtW1PWZ5sR6/wawSimLCFRz8wNZTTOD3bk4cTTvfGsA04sehL3iirynhhSkPo6p0p/u2UeWyLbG3x5hdaJiYUpXKUUErXzdAX+8lDolq6zHpbFwHXnqwGW//9SJf1pJgJL+MoY2ZP/RuYn35CynWdCRzpKFemhXvrQgD4X1TM9B0Mmswuis86MUNJCeRpDX1TZ5FQeFyazRYV0YRLavJsDB6kFpJ+/RM6x6ARpGb5lFyVtqarD8I+iRf4Lx6hoVTb/QYgOALS9fO++lEgHEqBkwdpHOjQQrANUS6KyE5EiHhrK7qzat3kYBNsbTu0CDTzq93JdOd3MuZobCMd3MWVTOksq1uKvy68wru5QyYZ50kr384lP/B87IqG95r49IVeglwu6FTKZ65SRqAqfxWae15lJyG9mQxwwrAtcCdOs/FuxCLhyyUUEaZreEPxbiINI/c9aBX1uTPx2ip+Z977Ug1J2TTDIs0cNqhu5dAG4bCpzV9a1Pu9CMwkuYmh8itSzXfc1Tv6wIBEOVAB2NiTud2MPMye9L9rfaxc3rjcjUfJx12xkBiIjoLmjOJ4AHCSJ2Ornu7hFhD460khlo1rlD3b0Ajt76p1o0d+Yh3TEh/a/gDhHe6YJsipH1hpBGAlJKpBFhyQ1GLqsYVT4buHzd1SzaagReakojSAUwmpg+GfIuXvEYPmrzi1GYbFL6bY48xPS8JX0auVE2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(4744005)(44832011)(5660300002)(8936002)(4326008)(8676002)(40460700003)(2906002)(40480700001)(110136005)(54906003)(70586007)(316002)(70206006)(478600001)(47076005)(6666004)(2616005)(36756003)(356005)(81166007)(82740400003)(83380400001)(336012)(16526019)(36860700001)(86362001)(26005)(41300700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:51:43.8370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b208776b-90df-487c-5149-08dc2709fd5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
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

Previous addresses where used in past in emulation environment but never
gets to silicon that's why use correct addresses.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/configs/xilinx_versal_net.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/xilinx_versal_net.h b/include/configs/xilinx_versal_net.h
index 2b441da91a10..9cb6b2bfea3e 100644
--- a/include/configs/xilinx_versal_net.h
+++ b/include/configs/xilinx_versal_net.h
@@ -16,8 +16,8 @@
 /* #define CONFIG_ARMV8_SWITCH_TO_EL1 */
 
 /* Generic Interrupt Controller Definitions */
-#define GICD_BASE	0xF9000000
-#define GICR_BASE	0xF9060000
+#define GICD_BASE	0xe2000000
+#define GICR_BASE	0xe2060000
 
 /* Serial setup */
 #define CFG_SYS_BAUDRATE_TABLE \
-- 
2.36.1

