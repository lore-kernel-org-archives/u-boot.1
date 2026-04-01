Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515841076370
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 06:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6950584010;
	Wed,  1 Apr 2026 08:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GHT1Cw7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1E484056; Wed,  1 Apr 2026 08:04:22 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AA383F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 08:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnOfoqPt6q5XwymYXb529d07EXjAaYr7iNvWa1bEBClk6IxWxEQbJDBcXqOSR4xp6KcSz2y+S3xx5epyKGpTBH4xHuV4i/iboyUgJZPaY0mwBvN+DU/kaD0wP7tdiqX2IghMdlum1iQFFHGSYBhLBLazrWxhRRrSLpiNp5ssaVymllbrB0gXTyfXRZ/vvPOdki4YLlYdUoo8JHQI74vHXp2eGIwXqLUyLYt9SdE5Oc2eBiuBAYX9JHarVxGNkEMU+z1sQV7nwwnIJUVNQVAGmWEVxgPT9K4yM+bBR2xGIi8/f/VNkgNzmRhJLLgeZClOAA/HQNFtckuMRDmOUJ44mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr/rksnRd0MwthE0rqSca+GiliOp3rAVcUI1mIy2OZ8=;
 b=xzfDg0lbdFePhBIbyi46ZO1BfMpQwxOCvngBA2aD2rXoiVt2Gq+PpkhotWLcVRtmRf9PZTB+hELW6f03E56xYvdSkc0ZeVjNSE5ot/uST7pqL+5LDxckLd6a0P1FJZAv9p6gPD4MNVO3XfYNMs1mE2cwD7z8EHQLDwA19ZuLK+0mLoCV4kvdrSQkOsD28r03LgN974ud+gv0lIH+PdY+7NHoZw7UcqPVpX430HSRr1xIEUrYUgiZeYYB7wI7V4ZI8Pl1ByqHWDTHI14F0VND7X2HdSewM1XNNhfGAhytWyGbAHr2F+D9QU3k0BwoJZhdqIRyJwTtdAjegkFFri+iUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr/rksnRd0MwthE0rqSca+GiliOp3rAVcUI1mIy2OZ8=;
 b=GHT1Cw7HotDLsdSIIZj42Ef41xNfZb/FbPTzDVkl41qKtfhBhaneHuhakHojRQEmhk7Wx2QaVEsyJ0WIlvSHwrlIJ7UJeR3i/liKKwrmulKZq/iBYCL9RbCgelk17OX0cJaSH07xHVlpWN8TQK+bIT0JWL/ufjWO3dRXZ3PTEe0=
Received: from CH0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:33::15)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 06:04:16 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::47) by CH0PR08CA0010.outlook.office365.com
 (2603:10b6:610:33::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 06:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 06:04:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 1 Apr
 2026 01:04:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Apr
 2026 01:04:11 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 01:04:11 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Casey Connolly <casey.connolly@linaro.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 0/3] fwu: Call EFI stack initialization after preboot
Date: Wed, 1 Apr 2026 08:03:43 +0200
Message-ID: <cover.1775023421.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dDpM8fpCtEX+ggnWZWbhgYQ/YFQd/MMqdqbl8Ld9np8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSe2er5ieXyxyo3T0XertPbpff/0pUpidPKj9FJ3COhu
 fm816GtHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRWX4M/xRf3MqZsH3ftDM/
 H616vuS/cumZ3wdi9rPdu2j4bJPdwfRShv/xaetXuLe08nHxLzpxV3iBsPYT1o/5x8zeOsXk9P5
 /VMALAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fef6860-46d8-47e0-d0e1-08de8fb4811d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: B8pDo9QVMkLx6zGWgSgI9u7q62OKq5kx2SKxPIujMGu7MCZ/XPxwUclgrHXTANEJ1tW91mrWZ5R5fGFM92mx7ImVxAHJUd1gGEXU5VoSy5XcXclrGwjXwVajIYMrQYMMCqg4Z0bBfx/MbcpS0KZfNN4MImbc0GhCp6QfSEFqOIJf7QuPeOF8Kh2F6y9xVRvbF0CSkN79qlCz3/jbQKcEVB1yY8KOepeEVBIdrBF6El2BjgI0491B3Gb19gK00TDS7JtZ4BcEQBMyVg/Vh8P6CGfNFkWvylmC1a1iJ7SxGnem5TrmFUzlpCdYG5vr6apG8ucB2crMXMyW5Ngw3uOpKgiap6kD/OO7/Kh4Wlk1ZIA2iTUdpcd8tYTcOioF8qdlSJGk57GyoHtfviog6uT6WOYknihkEbcgs/4y3f4bfMyuxvn/uFFCael+20ZGv9ncOwkksoh2uqOH/TfKo3xEBXdkQZCf7Q/SCXKYMBKwpqfLSlkdwOlJww7/FnBZJJ7V1sPx6yifXkzoreX4Pno+yKwl/2vMFofwT+DLQwHoAuSgw7ombp9d+e8GgxRFXITbf4hm42ZIHx3f/G2hxwaFv1FuwS7IaU5uSRCVyhmo25HHTyHMJLymNolgeJsYsAMKYwCGNG3GpxhIN1KL0Htg4V1v/1rrEWmMS5Sh+x6AWJrqhd1F/vZ5TyAczuvCTxa6a41rV/++dJmu8K/h+ok0Umi+34eDmNipbA+pwZUhIXVhkI4i7TeSzkO9ZG/hJfHRraPBnwwyeBzVaDYuU7Fmuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fo8sP9CX+ww3TSvY9XyZEwbPT1sHEwcbePWFhTAAP6vvbEeiefue6q83pwOYUWzeKrUKv8rMkL/hTGgBwcQ5gP8Fn3ayQw9k/ZnkSJMA8ajBiA/5iOxGhubMDK6b+rlXw+HcZHeIbqPy5VzTDTC408mBeNVUpmTQUAGlQFxwwwtQaJ9cLDHpV8RQUFMHXzy3pScgFHu9u8N1REB6yLNxMQgnB0vRarqBa9X7hBK6PXZfWJMrxVRi59cIOV9Um8IQ5N6qUjFUyOnFQGvjkcVdUFB6brL99VtbqbewZd2Lc3V+O4DrOTA3G2f/8dVGrZ2E23M0NANVa6vl6JUXt/UNWv9qAKepirfk/+n73AqqzNzNlL1ZvDxFLnWKlGmUYQFc0PwkWbt5D6vy+DGLYGF6O+8eKSjuN8CweFIXzvn1RFUV84g48G3h7O+Jg91fIXtz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:04:15.5961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fef6860-46d8-47e0-d0e1-08de8fb4811d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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

Hi,

the whole series is trying to address issues we have on platforms where usb
and ufs init are not done before efi initialization. This is happening on
platforms where A/B update is enabled. FWU code is called early and do EFI
initialization before usb and ufs started that's why they are not visible.

We are workarounding it by starting usb/ufs from board file but this should
be more generic approach.

Thanks,
Michal

Changes in v3:
- add missing type_name extension

Changes in v2:
- new patch in series
- check return value

Michal Simek (3):
  event: Check return value from event_notify_null()
  event: Introduce EVT_POST_PREBOOT event
  fwu: Move boottime checks to EVT_POST_PREBOOT

 common/board_r.c      | 6 +++++-
 common/event.c        | 3 +++
 common/main.c         | 4 ++++
 include/event.h       | 9 +++++++++
 lib/fwu_updates/fwu.c | 2 +-
 test/dm/fwu_mdata.c   | 4 ++--
 6 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.43.0

base-commit: 0da1866a8fdd4d4bc4837ef2af281dbe010ae16b
branch: debian-sent3
