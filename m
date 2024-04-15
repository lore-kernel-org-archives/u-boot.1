Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E67C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 08:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2A7687C77;
	Mon, 15 Apr 2024 10:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDDD2wdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8EE88155; Mon, 15 Apr 2024 10:20:18 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81403878ED
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 10:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxtGdTl10/bVc+9I2/HxrMKhxyV99SI//FT9ahRMeyZMgm/FvT7LNHtoFzrbQq/X6VI4daNwVKNxNWOACSOONTJ/3Mfb21AmFrxtogkALTjDOo6gMXhXeSt/DdP/6QwRXmVmd6tYT1M4Ku26VbxfZnuqht0IRpNjwlNF3pdyfTz1rzCNVVMYpKgOpQncPQHfu2KRYl2nBXHNX01pokwmKa0AytZWWaF7Dd7cokRtyQ3AfiBPfw+MC6ojb7S9ca1HWe4579klaGId/+GU6iG9zvs94f4ScERtV91Xl9uVMVCityPWM5csubcXLdwFm7l7NVtI657qe7fSk1J88Psk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMGJLGMwgWhD5ErZyP3xJSXZRTDJvfILyjBG729144w=;
 b=W4vrvTdagZwuly+yBjgutLYbGv4EWCCw4tPt47oaDPRqn83dyB/b3H1t0lgyrvoFF4Ycpcqz6OQQU7W9l6dqnRVjhVp2h/lWuYwP7Yo+x0HZADxZZc8VnZblDl5BsR0c7L2w7kq72uXywTSorCZzvQmW6qTblkgC+yiHkCo4iAyBa1e52czXDw3sq6RpE9DbqtnYUKCSsKYpzTy2/0BJr4/W5m9HRil+8JttQdwWsA68roYhwjvS74i/o8O/6xhCSKjCNP1USsJVtESshjvP/iI/HH7nN/gbXftbcsN8GGYS+CrWFq0flSaUjm62Hxkh2zGQsU88cvrdqKyAY2yKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMGJLGMwgWhD5ErZyP3xJSXZRTDJvfILyjBG729144w=;
 b=kDDD2wdru0pEv08kNVdWqCCK3e9JrpPkBk9eNxtSWehcbsr0S+9or1V1elNVRRJpFMnYIIZvvRNPLF2WI8kYNQnJ7HOiOlfolZHpR5C3Vi1FqA0qlu7DO3KqiBViy3EF8k5UMPt3d9W7uuoYhIve0F/IheEdKF9ph6x+WxMNlRU=
Received: from CH0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:610:cc::9)
 by CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 08:20:10 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::95) by CH0PR03CA0064.outlook.office365.com
 (2603:10b6:610:cc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Mon, 15 Apr 2024 08:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 08:20:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 03:20:09 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Bin Meng <bmeng.cn@gmail.com>, Eddie James
 <eajames@linux.ibm.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Peter Robinson <pbrobinson@gmail.com>, Sean
 Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] Kconfig: Remove all default n options
Date: Mon, 15 Apr 2024 10:20:05 +0200
Message-ID: <4ac3dca43448d6b6660c947cd7d50b1112cd235d.1713169203.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=rssZdhJaYs5Y+Tv7ju+A4ttqBEkH91+t7H/EcNixJCw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjSZx2Zclt82a/ZbnPU4vCyM55l0bpVFZGNs5jE17YiZf
 yQDLtt3xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIlEuDHM974qzLDW6Pmryb0e
 K5SKd4TovheqZ5grbuB0zDdlxY6CU7ELtz2663toFbstAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: db9f51fe-79bd-4f28-de18-08dc5d24de3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFVFUekOfXsLG4TCCkGzPCIZE/JMA7YNqLYOxC1DRgcCf8cYJSpBzGObDxh3sIFDshxGXcUJDiX+PRMJ5DtDpzxGmD1s3WInyZ905Zi0lkzVbK9UzbVgaocsrfamDQB7fvsRrwQFctEk9Cii4f1vuaWurOg8XrpFY3e6AVQzQksPDbGOQi9Jq+RqmfA+mCl6h2un+tSwR562EFB/w7vKO+ygU6QWFK4UxJ8+h6W/xrxVdad8Zmko3uKkrToWjyKETW9BbfVbxz+z42y5JFuoXoPdD5pjGCAIX0p29gTUiDKZgY94v7aLqoZN0CvhBfRJZZ+V+rFUShUVceUhYl1rMTeMXOY53S9kUvPZXFQ/9TBy5ti5IuLR15H7PWxgAtKIVEsae4TsBU7dDW03x17g49ANFjT++5pA7KBomzYOmYiFvDAEeSM+pKqxkAfmD4Rau/HY4SS7KmaP2wjH6kXNl+plRnNUdEH/u4tNaTDfTTF/0zxUN0rC5yGjd0ZYePrEIklHZ6KKi52m5TOvpfkuQHDE9BLcI3nU1wQW21B+Y9Tr+P7Wrej2xF/w5O5St5QpuyXgz0+mlc+IzxQQYyTDlzPujWVvqvA44JcbpQZeDjFbczkz7vY5jcC6XVyg2/e+kF26370mkJEIc+6vJEZxXw6O8YDVJFqt8Z2B2tWidKzBffSI1j/Q2aWqirz1u0TeidSfmDMj4BQF+VF1x5kVyoXk7xjFBgbuLyGivdwVuO7b/ZeIgD0wkekLc5cVnntc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(7416005)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:20:10.7748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db9f51fe-79bd-4f28-de18-08dc5d24de3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430
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

default n doesn't need to be specified. It is default option anyway.
Similar changes have been done by commit 18370f14975c ("Kconfig: Remove all
default n/no options").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 boot/Kconfig | 1 -
 cmd/Kconfig  | 2 --
 2 files changed, 3 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 777e408e2438..bb61e8b24f1c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -816,7 +816,6 @@ if MEASURED_BOOT
 
 	config MEASURE_IGNORE_LOG
 	bool "Ignore the existing event log"
-	default n
 	help
 	  On platforms that use an event log memory region that persists
 	  through system resets and are the first stage bootloader, then
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8eeb99eea5ed..6c8ad1b87e87 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -444,7 +444,6 @@ config CMD_ELF
 
 config CMD_ELF_FDT_SETUP
 	bool "Flattened Device Tree setup in bootelf cmd"
-	default n
 	depends on CMD_ELF
 	select LIB_LIBFDT
 	select LMB
@@ -2573,7 +2572,6 @@ config CMD_CROS_EC
 config CMD_SCMI
 	bool "Enable scmi command"
 	depends on SCMI_FIRMWARE
-	default n
 	help
 	  This command provides user interfaces to several SCMI (System
 	  Control and Management Interface) protocols available on Arm
-- 
2.44.0

