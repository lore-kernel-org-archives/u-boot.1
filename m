Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A04C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 19:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F6B8777F;
	Mon, 22 Jan 2024 20:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PmyRfgff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00DBD87872; Mon, 22 Jan 2024 20:13:01 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B53787753
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 20:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcOwkh3H1rB3PDqM2tpw9qfTt151UXaRAY+fFvi2PHtx2EwZqnNubuO/Kd+s1EDw5tll8ZE3Z3/+Gj7qqFANxNW40fB2cZmup8aRfKRKkSlnVyFBu6M3nWoUIRuIppvP31QkE5vOT/4hoR0hxz/xEyi2RjXBIFusmZAlJJXkfd3u2MVnzD4euKJfZjL1aJXlMiqRb2a2UMdEK7bIsfCx7nVXb4iSS9fVg9m954kJlqSdayi5vvWgYZj9hp4uz3Xa29ZgQiSDHxk2yo5MQzE6Aixv15QNcJ6up6a6VLU4T1Gah4hF035egUwePW9JVUajBArPPcfmtdkuC/UmyADr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyNmCGBb9j2U5VmcZQqY9u6zsQuZYlcpM1TLa80Tarw=;
 b=OD+pCSn5tXBtvMVmHT/9tGZnNuHXLU0TWHoIhLQoBKOvIJ6hbfQAjahpDqR/a9Oc7K8ziRsrufbItwA9wdqituBGMDMK36dhUQEnToVbEqrna2XztUdpDx9YGtWT8YVfFBoECrgTG1jBGqvLD7v4hjayPplMmU8JzMyQW4pj+EAYKtSpQQu/J2pXxUovHH+OXMeZcZ7aptjXjvstL7Gq3YPq7z41IgRP3keT/zfltQ9L7PmMXL/LkAHPkvJSmlZasnHqbPKdrctiXrIZhJD/ajHGffDbL3tmNFtPxd7mzPwI9odS0boIjPKec7Cn//7ZJlSYIWMckisPFaS21DsP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyNmCGBb9j2U5VmcZQqY9u6zsQuZYlcpM1TLa80Tarw=;
 b=PmyRfgffOq7EIrPhkq404ZzhH0XxTb7aToj9nofUzA+KFw+pIzk+pl8ZAHjOgr/TS3A6abdtSL0zV1HdCJQRRvPe+QV6wTg+opOWLnjdl0UXnK2EZ9l2OCochCni4J4PjUACeKnRrBC9qzaf9RuPqBbTFl35a7IBeGP9QU+Tqjg=
Received: from MW4PR04CA0040.namprd04.prod.outlook.com (2603:10b6:303:6a::15)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 19:12:55 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::58) by MW4PR04CA0040.outlook.office365.com
 (2603:10b6:303:6a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 19:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 19:12:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 13:12:51 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 22 Jan 2024 13:12:49 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>, <trini@konsulko.com>, 
 <sjg@chromium.org>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, 
 <git@xilinx.com>
Subject: [PATCH] efi_loader : Suppress error print message
Date: Tue, 23 Jan 2024 00:42:42 +0530
Message-ID: <20240122191242.2989327-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: d90704c7-cf9a-40fb-bdcf-08dc1b7e233b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8s5yKVdHpKrh2+vioaVfiLpFCB9mfqFfFFXJsHMzk6Y/RcHRPYEW1xZcPjvTBSoYz5SfhSRrr3YE4lkK6menv4c9m7UyGWS13DQvh74XXF5A04v5DIka7O/Eddoz50wgs+jvHwP6o4jyURxizqyN8z9lGOuy4Vu3942Wu+IPkdMe4Rt65F0C14KDcc9/zAQtjHoGNW+N1bk+2fdf4pWsl4G4HOZkxCuXXwGk0tzSVJgdnBWYqU40CR4nWdsekEUzPwvw9yjnftp+8mRSZWPt4UYdLR1pxd6KAsNrR4Uff15RCb5vVSIlc/Vr50imWlTnty7cTGzhvHWnEAfpiQokVqo4mPwBO7rUy8mk5z6+mBYfg0IsuvxBQcLVVrQgOHfpsnYEwACbQYuIry2dVmz5QcFKE2pcvFkXgVRJf4kDEStJwosDa35VnQ7FuDDt5qNEoHQK7xErcd+RLUMBiq7LJjniWwSa0bxjvsdzIByXB0VSrW1gr9b+8dA71aJ2lTpaxUMdIf0kuuXf9GJnWEtnmaoGN5S0gMErFnRJ8AsyfNC9XBguYUkvmo26Ep6sk0ItTos4qOdhx03cB5qbp7MeYXsVnkymvUeANweaemq/nV8/kvYN0rjcA6eFAd+RPZT1qyAle4j4lsXEQd4stIUmNSYQnqZ5CRgpCGRjF60na7WNpF7RrH6L/d8XeTuxhkJT8zjjdUC0erE8TauUmmCFRWPebRdXoMDGaD7BmQ9KLjQVZac6u7ILf523eVA1RxwGvtbTpZxVl3Oyf/5AniCC7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(478600001)(426003)(82740400003)(1076003)(83380400001)(336012)(2906002)(5660300002)(4326008)(47076005)(8676002)(8936002)(107886003)(36860700001)(26005)(15650500001)(6666004)(86362001)(103116003)(36756003)(41300700001)(2616005)(81166007)(54906003)(6916009)(316002)(356005)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 19:12:54.8058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d90704c7-cf9a-40fb-bdcf-08dc1b7e233b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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

Currently, on certain Xilinx platforms, an issue has been
identified, manifesting as follows:

Starting kernel ...

efi_free_pool: illegal free 0x0000000077830040
efi_free_pool: illegal free 0x000000007782d040
efi_free_pool: illegal free 0x000000007782c040

The issue arises when the ramdisk image is relocated, placing
it within the previously allocated EFI memory region( as EFI 
is established quite early in U-Boot). Consequently, when 
attempting to release memory in the EFI memory region during 
the handover process to the kernel,we encounter memory violations.

Highlighting that EFI remains active primarily during the 
booting of an EFI application, and the lmb persists while 
configuring images for the boot process. Since we aren't 
utilizing the EFI memory region during the boot process, 
there is no adverse impact even in the event of a violation.

Currently, there is an ongoing discussion regarding the handling
strategies of three memory allocators: malloc, lmb, and EFI. This
discussion is documented in the email chain
titled "Proposal: U-Boot memory management."

Therefore, it is advisable to suppress the print message during
the boot process for now.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com> 
---
 lib/efi_loader/efi_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index edfad2d95a..821fe7616e 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -713,7 +713,7 @@ efi_status_t efi_free_pool(void *buffer)
 	/* Check that this memory was allocated by efi_allocate_pool() */
 	if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
 	    alloc->checksum != checksum(alloc)) {
-		printf("%s: illegal free 0x%p\n", __func__, buffer);
+		debug("%s: illegal free 0x%p\n", __func__, buffer);
 		return EFI_INVALID_PARAMETER;
 	}
 	/* Avoid double free */
-- 
2.27.0

