Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B71C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 09:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7F684A3E;
	Thu,  9 Jul 2026 11:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vlhtZ48i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D713384A51; Thu,  9 Jul 2026 11:14:45 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0744849BA
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 11:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssGOQjsOhwYQk3W7PGV7Vlos9lNxjZ04UJLll8paeWmSjrg2oWiBI1E6ONaL27HqD5+Eu5cpLZcTdAfXrktxhP2detQqT3c436gjE73JxalGnk35lkzukKM86ewdlYuf4uIYiChIX1kC7sz5Tfl7RtHNAH40sq/oKwOIChf5MzynaWRtE90OPVXiUiMD2UOoQl/tv5weUOvK033o4buYz9SiJqf/usJjBk5/kdgAegY+aozogtwsd90vLmoy9hRbNLhSgo91ITpJclByOcXjHvIE9hPZxpuuuuTIZpDXEn+cRaWdKnLmac9P0spJf9YeCRm/MJ8fLqZqHzDSwPr/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3iTm67swAWGp5WIMaw9C+irw82rRUEq1nGNnYS3er0=;
 b=oTFvjxt+8pUpMziKV7xMQpPdawGnFobpWA/i0H2sfeyo7M+v80fGmz7ps5rTo9W+QyQbNuGTJvjJU2RgDiT5OB9oeI1N1CRW3EkjlOyEPdlfmEzJ48rrqy6negQgYpUBqCy6qxjy0dpz9BPmK0GJJYfg7seowG0wqyBc702o5aXY+QW+a+zWi1meox9JfXPaGZql2cDjyHciD7fWW4a4wIvC+6KQiDk2gkrNK6B2OW+ZlDX3TMDetwZMpA63jGA6eG3Y7qfipWOatiyVJq2IhL+uEHbWqXnmSkehYOBPznuAd+yIQDqyfCSVKKzgae7Bihhiu+Iz9+ch1in7P31e0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3iTm67swAWGp5WIMaw9C+irw82rRUEq1nGNnYS3er0=;
 b=vlhtZ48ii/eHj396E/gtlTx49p7iH3vHXp7LDNFVGe5P3YmSpc9cn0BPRv5JRpmhG2qmNQq6qiVOXxB2OXDUQ0ZPEmkByNOOcJUl1e2g3RO/26B44SuG35H0D3vtqI/sXh1NgsuNt6mtqFfpEGESX//DMo+PsQSP+8hPkFQw6Xo=
Received: from MN2PR22CA0025.namprd22.prod.outlook.com (2603:10b6:208:238::30)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 09:14:39 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::89) by MN2PR22CA0025.outlook.office365.com
 (2603:10b6:208:238::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 09:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 09:14:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 04:14:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 04:14:38 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 04:14:36 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>
Subject: [PATCH v2 0/4] i3c: dw: fix slave device setup and probe issues
Date: Thu, 9 Jul 2026 14:42:51 +0530
Message-ID: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 7613819e-d8d2-41c8-ed6b-08dedd9a80fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: LuisbhT432mCxvN4of/VJGQ+76KGEqoMgG8eg+XbyvWNwyhCnxi/yyWJkSIFWbYH9AeBnA8uWRAYHxX4GP2qnIkBKyAVWaQrtyGgt4/aXYFlx5kEdf8rJrLCKfXWQduRuudOnOOVt137nJ8Re3m9qVAHxh69pq81Bofqi8xuFauA2d2zC2+lEsuBcvR0eQ+cnSFBZcSHMtxFUNhCGJB+UEPOBlzgALjNI9Rn4+/M1U6aw709lkOLN+9S7tZe/uSPcTRmP5OXzcN1qe7ETQLfObjBzQWH1JVuechuyDszToXj0r6XaUfx7Qy1ToE2S0HpkrhN5RUKQ+WqjmMif3to+tUdJsQNbhqzce8zD1nI6dWWp47ttGaJGrCrrmL7C/xH8u8dk8dJs9v4VF4MeXBjskttxmO8IG4Ua9Gnl9XCrGMRsYNqdb02TrCpx0Asn4AOIVbZ9YNPRJHEw2ZKHQ470wlZEPbY+wGqndoek0JyMU5Ztvdx/XN8Iv2eGtOFH1TxchgakavqRtUFJVNHUidif+M7UrAxwDUFDk7DG5v8ucAn+b9DistdNr11wZSLWHRL3Qzb9KHbHRy/29I+4aWFm8oqv4Tv1eOf70gG73tir3AcG345LsyejBe5zhqfn9lXYsdORMN/Nx1KWoj2aaq1zTrKRpNZ0gLgw+ZWrvx799MglY7UXtrxoTQInu8XPyc725hKl88hbdRerAR0eQMnVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Sp5RpIpSyOe4zbNffV5rghV8qj+UNFlUAqV/rjLoryKFBuHSttw/5DExf7odjT83zqkhmCLOUO87fDlTI5TplwGvp9e+H1ZDNFzK7jU+SfhhMjxRWnk6aTDeygZV+rLMhJFquDsb2BVy2rNqm2dWO+pU4eX56v+xBdrRIHWOdBkcNetZ9LB+c6GQq+NtOEeSvrxquFNn5gze9WNJv1jXNVBiZCXtjr53GiiP3J2iF4FFe31E6Q6K8taKnpo+cQxhrtvMQGl5Rf1QS9hZJHZ5gU+5SNsY7iKcP5O8+jpDrSPY5DQCSWPVIUpgVhaUcdYcZK0Do0zLLjt/hG8jInG4Om7kzDaAGplsPaBW1lomRDVKC6hbUjjJluYOxRjUaUEO4Rp3UtkJURUJlTz/0zvmHgtlBgKGBMbdv87BtdaWEzMSZGoqQUXR+paIN0dGTeCe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:14:39.1388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7613819e-d8d2-41c8-ed6b-08dedd9a80fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828
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

Changes in v2:
- Use -ENOTSUPP instead of -EOPNOTSUPP as the reset stub in
  include/reset.h returns -ENOTSUPP when CONFIG_DM_RESET=n

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
2.34.1

