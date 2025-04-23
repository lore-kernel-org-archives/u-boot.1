Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E8DC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D12080FA8;
	Wed, 23 Apr 2025 14:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TMxCin1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 187E580FDA; Wed, 23 Apr 2025 14:45:03 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 530F080F9C
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RInUYg0Q8Nnu86GFLD5o1MbHhidZGc/4ILDXGRYEPxO/U6W95kjhEat50VPT2BjzvaTVfVKR2GXc+gLBnnp2/+3AycgOTE127XDJrCFbisioho4DVf5ZeBT1egASHvKiWfzNvu42gOkDZ0jvU0bwLQEehPYOfOF3uTuSiAkvSX6mHgymbPnfbEhdVA9ypaL7xHaWoOPnQrFi9Dlhk0A3yjyvXLJ5jvCaev/t+q80Mh7DlLbJUAnOX4woAGa4JaUqdy8+K0rMwLo7wOxXYTA2xqhzfrIkOCiRd6eVqChPiq4rIcGB82YwPH78rK+24jc9jNgBVBiT3z2LDr87RxtsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/a/UVOB8dSE/f7iwzP0aGe5QTITvp5IQtlbDVlqd/A=;
 b=DpdNdbRDMr6kSeTBCYCv8Td4IqxvvCPwgswH8KjV08OJVjLEHGWQ0VOA0Ip5wYJLREk1aOd24q/9KMzu7JXhe5nWavNlvl547SppTxk4wBouyW9uaQBN9679WMeDzU/9F9NswhsSY9eOpUPfdF3bKL5r7BkuAbxyCWHyCa+ahm+MZZi6EBBciQUAAndEEvFtgS3h++u5jQ/oNKYYp/4eFEjQBkK4ADReMtcijOrsB7e4rw0bS1nkytlQ078iCySnRy1h/YoqhyL58VGv95LE3ogZw26Em0bqY4Zo0AKwpzTidAL4mrvmxOYKJs1KYOl6v71/aCGPrkRZ6Xus5tOCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/a/UVOB8dSE/f7iwzP0aGe5QTITvp5IQtlbDVlqd/A=;
 b=TMxCin1P1EhOid3vocmcyoG9bmhMuL1hEl8Lbhkjdk2h4sBdI09sGOUkyLYEffFNpJiyv7yl3KNtHT5FW8CdTJnU+1HyaK9lJKBbvHmyp8l+IlqZDtCZ+WR2UyyD7PsyU1b6he+0mz4uBFjV+LSIj5oCEwmwhV+zm1/bXi++eYc=
Received: from DS7PR03CA0182.namprd03.prod.outlook.com (2603:10b6:5:3b6::7) by
 BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 12:44:55 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::6) by DS7PR03CA0182.outlook.office365.com
 (2603:10b6:5:3b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 12:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 12:44:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 07:44:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 07:44:52 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 07:44:52 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] Dockerfile: Simplify applying cadence_gem commit to QEMU
Date: Wed, 23 Apr 2025 14:44:40 +0200
Message-ID: <5061af5aef7e964431679bee94b7ccfd2579e521.1745412278.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=cnAVDliYpxTS1a2YuLJzzHztL38AGHZKEB9iawDtThY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhgyOBzvX9C0Ibl//YbnEsc8lOguWOUQaLnG4YGJ8lr2Pi
 yFd/rVaRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjI4gyGuZKbuT7dOcZs/FCQ
 5xLz8sBnk9rXXWGYn1N6avv3G4GWnxvOvzvXPPXhvKQ2XQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6143d6-ae69-4491-f41b-08dd8264a5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c6D0v8qM3gIcGh6v9timLUkGAwsGJY0oCdFUf0zJ8Eo0PdJCfrlCU8YhhO3L?=
 =?us-ascii?Q?E3wi4p37CttZ2FDGpezgPBN7zaNTtAsKJlqPDk1oK3Is0MVlTu5TeY8ynJmb?=
 =?us-ascii?Q?Gd9JP6+Vn33gJS/MuaIfzML5jxCnQdQqw5u9Smr5hM93keVJIzPmAaNZc0Uo?=
 =?us-ascii?Q?/srKY+laRi+8jBokHb7NLwo9W6uUlRcjoXb/TScWQAImlSZUwi8JyO+3Fwgr?=
 =?us-ascii?Q?FiSnorewKQPd9Y3uvpz3qnIiT3diC/5SHJ8g1HmNbyO9UDDRk2BNsykvsGSQ?=
 =?us-ascii?Q?UubIAtCUjtOifz1OgwVIyU3vGS4PCa6WGxTIAiCvlYGd/zCNB3AvbdDOKWn2?=
 =?us-ascii?Q?BbV926Zd82Qz6cNaNyvsg9t3nrIwudZwTgyEWpz98z0op8a58bqlDw8AGAc7?=
 =?us-ascii?Q?WRUc/0KLWmt2YsVRsADmW4Pm071fQMUDtiEWsO+TPVq+zwsR7E/M0wTwkT80?=
 =?us-ascii?Q?qxShPQOtdiaCWubh1h+GTlYS3ACxpZPRO5JKzct7/7j/3DesZNk2kOIir9uN?=
 =?us-ascii?Q?YaNAQm5M9Z3k+TZsUD3Mz3haQplyyp5eMfGmr22ysWFWNSrk8eaX4KYiCq6e?=
 =?us-ascii?Q?AMt0dFxCNpH+CmMQWcIrEhkjMOlyN+VYPd/XCuUb+RosaweATphLgaC1YYM5?=
 =?us-ascii?Q?8ptAQZ+LYg2w03KqXfOWKZYIy/EP/TMulIQns0MeeeGJy5TD9sKnsU2hUz4V?=
 =?us-ascii?Q?3nUXWWW4sJ7gEoxda1pUqiUsFdLN67HpncxkXiPKRWfw6aiSQ36XMPBSL1hJ?=
 =?us-ascii?Q?REdTb+kOBVN384ExWictstodt/pyhAa/RL+hCmLS4IyuCswGxKfKDPfHsd+O?=
 =?us-ascii?Q?q67bAlA9drspkp2m7o2GFavhjiv8cSBQ2dHp+usII7s41RYUC77MUBxD+U+S?=
 =?us-ascii?Q?QiEfqL6B3svnUY4h9owKZxqzL8VPHJtUe5QncPCXXkU9ocVCfooJ9Cq2K7Mr?=
 =?us-ascii?Q?4b8leVG6GnO9otnthn7yVW3V6xCV9plXCAi0EkLt3HjGmVwXvO/3Xr0IW6w2?=
 =?us-ascii?Q?tNy3CKw3aLav3hkPjDCViq8gjeetzZaoiRuPaH52S1oDZlI33dbqlhpBdYc9?=
 =?us-ascii?Q?5kFHREnzxJtiwrMn+/VesHNgLlCSz9lbzbezGMyUvVeniquiw9/mKu+2vIwv?=
 =?us-ascii?Q?8WhkY7aggYUy/6lj0h7qDoC2a5K2WbctZsBJAG71IcfcCdYVhDrygBjg2OwA?=
 =?us-ascii?Q?N3H9F5eRTxcJc3r8XS8PLaQLzMExf7S/IAsq6ydyakR/EJwXMECEMTQy0c09?=
 =?us-ascii?Q?fGdj2QrUIiP+OVk25DW7IbkNoPbuYjg5qRR8z82OdH1y46KJtAjboQtVXI7c?=
 =?us-ascii?Q?SOTn4XPx91cI7ZjiSCTpNHX72xenG1flQKgzLPN7D79WnslBM0TRBabI+kv2?=
 =?us-ascii?Q?PmzcFqtSdDIwgyXSUQmUusKE0QVN96+TId7IfNUNdc7rzZMfv/TRfXkj+ZFT?=
 =?us-ascii?Q?/vKRCnMGpM1vF3svSy8YAmmOxUZr/CF6X40XP4pDbAt5UjbPpQdzvTKRb74L?=
 =?us-ascii?Q?1ZEvoWIttKayGZHv7qDDZGX+mxiVczccUjvo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 12:44:54.8271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6143d6-ae69-4491-f41b-08dd8264a5ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
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

No reason to call format-patch and then apply it with git am. It is enough
to cherry-pick it directly like it is done by commit 074bfab54d83 ("CI:
Cherry-pick reset support for m68k for QEMU").

Fixes: 50a907edbb2c ("docker: build QEMU v8.2.0")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 tools/docker/Dockerfile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index a0fd174ff602..0aa9d3ab3a84 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -222,8 +222,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	# config user.name and user.email to make 'git am' happy
 	git config user.name u-boot && \
 	git config user.email u-boot@denx.de && \
-	git format-patch 0c7ffc977195~..0c7ffc977195 && \
-	git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
+	git cherry-pick 0c7ffc977195 && \
 	git cherry-pick d3c79c3974 && \
 	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
-- 
2.43.0

base-commit: 82ee3cc8d1854628688fe6ab89afaabf3112dd04
branch: debian-sent3
