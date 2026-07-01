Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80499C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE9884AE9;
	Wed,  1 Jul 2026 12:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RKeuV3dH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0531C84B74; Wed,  1 Jul 2026 12:28:39 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84EF084A7C
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcxvzm3nSRNmXcwfoPahG4nrdAcGbzWlLbMqrDV91n91gylB45X7OdzkscOxe6TP3N0RYuaCF6NUDDU3JvsWKE1gGyR82cW84be2EclSrzc/Tnr4/tBBNVvfOdKmYgpCpxU7YjRn9TpT6L3kO3mOfgCp0OEAcQUT3x8G7sv+ru8NKcejCBo006v7QlCEkX8whLV2IZBOWbxGVZHphwsnFBSLIUUDgS8R73UOLuVw9y42F4IMvRVqo2dWyMLvgIfSOtE4HizLTtiQgPnq9//izPXjxA0+J+8WYNoY/X2aujUS0uuyB5RoVbOn7bAttscZWh1MUtOrVgnI5VCxoZP9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9eQvdiKoL/Ly+ZgcfzEx6e5v0mPRn+XhCGHfRYXLIQ=;
 b=QDgXt2WgUB0IC9LtoEzm1ySVUV2g9piiHfb3v8Jx2pvpsyyTxf/h+Gv9f+T7RQfyOwQWTHM6IsarQVBCkDm573RWfyzOma6aHtVpdC8xXnci/yHjPePmPbc2XdtsdbwzlYAYK7mKX2J56t+FYiOB0nrG1DKYp2ZUzwniWlxejgE9p+1yAvj29vJxW20KlVnSr+egY2VIT5KNwRBHtDAPKEIxfd+0P3Y4xLKUI5VXhAVqH4XPoAykuFYOxEXJhW7cLyCGjpVjoPGSUt1LCg81C0zyXa4rYoLPMJlrup6TFn5pR+lKFK9YM3XMbIuUtONP51QncV9Dod7sVblhi/tMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9eQvdiKoL/Ly+ZgcfzEx6e5v0mPRn+XhCGHfRYXLIQ=;
 b=RKeuV3dHg90xMS4MRfqdjG0MAXCT4oLfWH7SFj/CBsFShI1lUDkGpjEOc2efCXRCI03s48bi38sydLP5/QqgB9rDGf+dcrO1fCb70L42MB/Rm7DtS7zSKIrAi/Y8/nMPyAnWCLDgJjQqFbzpoZG0INeTLMhHgDZvzKhYQaBjKpE=
Received: from SN7P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::26)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:28:29 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::23) by SN7P220CA0021.outlook.office365.com
 (2603:10b6:806:123::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 10:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:28:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:28:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:28:26 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:28:25 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>
Subject: [PATCH 0/4] i3c: dw: fix slave device setup and probe issues
Date: Wed, 1 Jul 2026 15:57:16 +0530
Message-ID: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 968c09c8-c54b-4765-14c8-08ded75b7d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 0GD+piWtDsA3FbaNCQywqmnFzbiGtumRdHBtQ70Z6JuST9OrUI5YAqCtq+lguMHfMLWQORJiLO9g0OEg6Nfg2B1hg2I3K/N97olpcDhOvdZIam43tFb2Ztlhhg/zenX7tObEWlvo2Mr4wfiD+nRBQbB21AuwmPqkjI5UIzBSrVHkBSpu1EIVipYzpzgVyYcmaAzNH3b2wDWlhB34U1uqhrnBtgMLn7s4D5+IEnvLmOL6TMCT/xY3gnR2XAoa3yHxS7/pOYpqFrm7Wx5KWJ5jjo/q83RWDflGV85Nv4wcBh0Gfrgwem9MgYRdjd3ZvUNV8xoFuMKPBjVSUhnPJTEo5DoMYtR2MPmxVE/x1de+J6QOfBqe/HjmAeqRyGt/D/68PQvGE6kp6boLvFPTogLHX53/1TN2/hdhRdeyZDzoGh+a638FQxaFOPl4kUzeB9mYvMUfT1I86iThssbrdPHawNUYD7B8AnDwgBMpn/q/n3htcL1F2ADwmfvB2fooA+AVsbwGsbvcK08pdllLGSHbIvBisK1JA8bqGJQD7r11vItzHmcWqM737ftdvQdaCaOq/VwH/ot6lTpduC81QC4lABNLUaCVhTZsTj9tFF3WAf5KuF6Yhwt7k/U4fJ3tfI7S4DvslkETPAnesrL2xHfpF8ibAYFIhAsO3IoqpR8IvfKmUFjqFwV+wCHEWd6lZ8//0jviMFwZeLD30DXOzRdomw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EnTuiptwAWvh1r95HhOx8kRR0YwS7cUjn9Dhs28jHMvjjQkq6EK4WIMzEZB0YKkqWk6kDpZ8Ojloe5+tXvlXRyxVjMGbTVDhg2S2ohW9xpwImovvkK+N3HPconm4IKcw5gSDlVkYlWdiMLn28LPAP7ztDPYuTW1PPlb4LRSQyhf1TrA6/6nXH37RUlof5Ib6FqEbdZbW/iLzrpTrWFF5D5XW25F12aQ0ytPZAcMRrpKRK2b1GojUY4hacWJsrlejQEHb/JmbT+9s/e7rMIkyhdClgM1eW5vxkq7DYOpOrxpON4Knt3BlN/5SHpfKutpuH32mQ9gIijCStxtp4BoNp3B4dFRn+X9bpxPEHQTU+fILEqDOnUuQkl3hOwDe/NG6f5Bz/hM6v5+tisLZh5J1pC4kHyL7mpDQsp0d54cSMHVvoEh9NzGx/VXKt1VaxD3k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:28:28.1493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 968c09c8-c54b-4765-14c8-08ded75b7d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739
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

This series fixes several issues in the DW I3C master driver and
related infrastructure that prevented I3C read/write operations,
and enables I3C support for Versal Gen 2.

Pranav Tilak (4):
  i3c: dw: make resets optional in probe
  cmd: i3c: fix list and current needing pre-selected controller
  configs: versal2: enable I3C support
  i3c: dw: fix slave device setup after DAA

 cmd/i3c.c                          | 11 ++++++-----
 configs/amd_versal2_virt_defconfig |  3 +++
 drivers/i3c/master.c               |  1 -
 drivers/i3c/master/dw-i3c-master.c |  7 ++++---
 4 files changed, 13 insertions(+), 9 deletions(-)

--
2.43.0
