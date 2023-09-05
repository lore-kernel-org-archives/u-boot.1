Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE67C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 03:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C4B780181;
	Tue,  5 Sep 2023 05:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/O+66Uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D20380181; Tue,  5 Sep 2023 05:44:13 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 486D3866D9
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 05:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPhC1b2IzZbX0l3wWHbX/wINiwzf6uPLBhrgGJXQaGRKb3z5IXNf8S2g3nv9EaRaZerjRbr/4gJHrpd6FhquAT73ZqkAim1dP60WBg1lt4NaScWo7mAFL6WQOFGmqzwXxK16RjevLCtCE/Du0tcmOoEJ+jL6C3e2brEu9vMxG/JE8UL54XW2lxOp/RHS+V0440cWBXWvMPTyTazcd7fB5svhKn7RPcU8sql28yJx/AmYznS4PMNVDNMlW25sB7LSYtPbkrmm3129YTMrXX6nQHIWTE5xPsilxQpZ2XzIU284Uldo2xxMfjfAbLo6xmiv2CQI/4NMB9V8ATpR1/zK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyHtN1htSN0E2lzJqfN0twsqxoTH3FmNAK/FknHsGVM=;
 b=DnWPd37Y8grnJuRa2ezdB+e25VTc/Nhcn1ZRbdsjAAZK9u7oy+YXpvwejp8x3yVolF7IlkM8iw6teHcmhntF5W98KvJG62ZFxYcC1xi5t6hqaekT/IRWuYmpHvs832njrDWGz+hePE9jwCaG+v+i0n7+UHfr9p4S0eN2DNR4u6twQDPRrJHczzuIyh9MYP65I+kB2Y98FgeZWOrSczRd9yThq9B9lVNmF3mxuwt0sOxZ7wpoYdUNttY4l1BEpAaI0iMMpQTTgQISskadXqBE4Wh3nvFKY4SNb5FGi+rGpUcAy2im42Q4TnskKa6PdDiQEm2U1qdTR1T5OKf3Lkz4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyHtN1htSN0E2lzJqfN0twsqxoTH3FmNAK/FknHsGVM=;
 b=h/O+66UvyrB/dMl9MtwS87OpoxvRe7+skp8DjuyJpePn7dPmXVGeHvYUop9ntj6jo/QWdn2Pz6btwauXgokqfmFJV4GOlX0E8t9av+8uYHtz8Yr4Wcm6GSHRiE5aZV1GajYrjgMyWTRlcQuRGYfA4DDXBtcE5lqbyIvIcnPjtNc=
Received: from DM5PR07CA0051.namprd07.prod.outlook.com (2603:10b6:4:ad::16) by
 PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Tue, 5 Sep 2023 03:44:05 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::63) by DM5PR07CA0051.outlook.office365.com
 (2603:10b6:4:ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 03:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 03:44:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 22:43:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 22:43:22 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 4 Sep 2023 22:43:21 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH] cmd: sf: Fix the flash_is_unlocked api size parameter
Date: Tue, 5 Sep 2023 09:13:09 +0530
Message-ID: <20230905034309.29099-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 86db9ecc-a70f-4225-01fd-08dbadc259e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtEaR6skmzbxlppyOOTZHpI29qNgd+GSg/CzOKI+ksvqoWhEt0/Utc4rhJDlLHz/OQPU3/mfoMgAgujYWaEu1jtkl1tPebCESAHcpnCCNUAo+cTXayeQ2CX783jiymQO9pfwHm5rZygo0eYBYjSA3QAM1h02TyapUOjzVw0WkF/ghP2jZIJRHopd2vm9+FHhucAr/AgvOgL7HjYs8cAnV0e9i8q3XB45d7pFIv+ofuEkO7d7V+WEZDuFeVusC5arutTwAjKyC5bHxgBr/N0xx/ILMKy7wY5nJOI8n23bARiO8d9WlUCiyTTRzb4ox591KF58iMyKaDQlVYQeKJYx7D5ML9MBFicZyEz7ADAKQn4/50jUZ1SjXmbFKkIyWfuNmdHBWjFVpHRLyF3hGnPLW/tp/J7kR1Xf5e2A1vsnqlUwEZsmfwO4kqgl4zKLis/d9hfK4B3uUoB7iIwE5Lys611hw+q9aeFB5WsDK8BTnuFLweqLt2SJv9RWdbjgGlEs8ZoJxKal9iLiXt4hAyz7Gv32zPXDrs1/y7gVtT88ez9bUslUZ9lFgmRPTaP2JjE3qjhnN7jSTEDaoLUqTpfVsXR33DtAYSGubJ0p2xPXGICIGq486ao4yr/9yVle0k8JUbuyd6avgpAQUbZAt5fpAGwEsmRWor3VnpXSDs7r2x2Bm71FH4h5goxfKoQABuAN3VfgWtcESBZDSsAn1Izs/vsVbtio+SvFY4FUeaZRMuAv1B8ZUfSbW1M+ANY0lnP12ZkWvbJHAmefaS86mz7sRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(8676002)(70586007)(70206006)(4326008)(8936002)(6666004)(36756003)(6916009)(41300700001)(4744005)(5660300002)(54906003)(478600001)(316002)(2906002)(2616005)(26005)(1076003)(107886003)(336012)(86362001)(426003)(83380400001)(47076005)(40460700003)(36860700001)(356005)(81166007)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 03:44:04.5913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86db9ecc-a70f-4225-01fd-08dbadc259e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
X-Mailman-Approved-At: Tue, 05 Sep 2023 05:47:36 +0200
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

When we pass the size parameter to the command "sf erase",
flash_is_unlocked() api is getting updated with length which is
incorrect. Fix this flash_is_unlocked() api by passing the size
parameter.

ZynqMP> sf erase 0 100000
len=0x8000000 which is flash size
size=0x100000

We need to update the size in the flash_is_unlocked() api and not
the length.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 cmd/sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/sf.c b/cmd/sf.c
index 55bef2f769..977ffcb63c 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -366,7 +366,7 @@ static int do_spi_flash_erase(int argc, char *const argv[])
 	}
 
 	if (flash->flash_is_unlocked &&
-	    !flash->flash_is_unlocked(flash, offset, len)) {
+	    !flash->flash_is_unlocked(flash, offset, size)) {
 		printf("ERROR: flash area is locked\n");
 		return CMD_RET_FAILURE;
 	}
-- 
2.17.1

