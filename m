Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88A5C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 05:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D54560837;
	Wed, 29 Jul 2026 05:14:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6o0SgSB8UaEu; Wed, 29 Jul 2026 05:14:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8496F607E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785302042;
	bh=/szHTwuIvFrHDQPgatqSXSQvTopPs28IqQZOiZmRa4U=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BMSeSlz6OcanUHTHxCoRCkz7kLgB/RuyT5+Pv0eXmBEoxRQEQGASWzomj0bV58ixX
	 jW87Nj1HptyKeYFPaBuzB7VH2l4m/FaPFyNkIHOzXMpH0vrCeWeNTQzkJm2+5X2z78
	 DAUPfyuFjWasFu0y6+388noB7VQAc+VTD9Z+jlPXASJr5FQqE3feuL5s4BRVXEd9NU
	 BvIGoCxzqEJRFHMmt9cyFfwJHT7+t8ixT+CK9VubSc0sMygmA4PvL6kQ6M+0StuFO6
	 J27ZlJYmwoIZHtrdoKO3ky03t6la1kGv2RfaeQmAI1X/G5By64IHBr5M3wn2V2T0Ud
	 /Qj0HRpBBBHjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8496F607E3;
	Wed, 29 Jul 2026 05:14:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED1F3788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D35FB607E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pdLOhdlbroz for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 05:13:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A3114607E3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3114607E3
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3114607E3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:13:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9402F849A1; Wed, 29 Jul 2026 07:13:55 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73CC28404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 07:13:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvS7WX7+9P7cG4v48RUFU483CVVBHW+ICbzzuLUfiURTv3w7xbl/ze3Zs83iW8DQ/gW3B+Zrweoo74egEDOWTvsPIDxumUd1rZ8VrLZbxY6eP5A35DXBGL6lTrIs4ApNe6OjW0zgUbopw9oQnhwqcyClzgiOjLO0m6ZBjuzjdZq5lNwPsFZWHkggdpHRXuarHr1Loz7zqiZumi6E9HzW9yl8reUEnaEyYFpbiu97UXkjtufk8XTRpYOXox1/ivWJ+B4bK8scTIkadV38KlBT6BzRlMDhmLlq80jIENTNuem1hstI57HTgtRAQa16bYmXP28GwsJj+p8YKKWiKvzlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/szHTwuIvFrHDQPgatqSXSQvTopPs28IqQZOiZmRa4U=;
 b=QjqwMJxuwS3JxvuR+qSDXzCULvDQxD4GaQ8OGED7jfvr4UPM2ohMzUfFvQowrrzya44NZQul9LDACEsthgPL75GjTFA2ure6HDCC1eFgBLEBiV2qe54+6v/q7moP2StPF/sUCld7AxqFRWBsOxlmvP7GaOE6iexrnC5WKv6w2Npt5pbo/PnrvR2ChM1NcFUX+Jk+MWfYfUPxQI67aOzYKC0EUlxBGdrcF+N2smhd+o0taLWMsesnpwDx1FtXh2ZlkxHge+VcDhdgIh7v7T4RsXOg26rBCE59SgkiGVW+q1IOBfR0lHAE+r3SJiwNKPtbDvnXms3pUP3eutHOFaxzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from PH1PEPF00013312.namprd07.prod.outlook.com (2603:10b6:518:1::d)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:13:49 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF00013312.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 05:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 05:13:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 00:13:47 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 00:13:46 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 0/5] gpio: improve claim diagnostics and fix gpio-delay
 offset handling
Date: Wed, 29 Jul 2026 10:43:34 +0530
Message-ID: <20260729051339.221699-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 53937f19-7985-41a7-1950-08deed302c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: I3qorinWymyDUK3VVx2YyqkcJFx5aZ1Zqo5KP74pDWIs3OgBAMa4odwVcWZJHIrdlbG7HaJ97xnSntcowXGVOvsrXQ9XF7TGN01MClMv4y4q1KBOYvAarcqz1+QTHCdJgZb6tZHd80aPlUbn49Kif4QoQ6PZnXb98Otgkod1qx6pVHYh7Jk5rhvBE8YiZprqbdAXrxms5kiM35MWa0SqfORSCV4d8uudvyDCkXaCvzYZX69COP/KLxAkXLNXu/TEhpUg9ESzh4NzaUR2i+kKsAQVqhpv7Pw3wjacp/Mbt71Z2XNRnryPUHdoEz9GFKbfbk8j8I1j+gMgR+qKbXpeN4HF7wG0atyBNJFtgCDU11YMMI33kQQ4KdYVA4Y+WT7mkzFO2RrX2pAz88/ebD4lZxaUxVnDsaO+sdsM9C9druq72ZOqEfViHYEkcRkygUxjZpYojCqD6m7jnCUcfmb6oMHLxdXzo215AJwAb4WjZ2HHd+cgIYjR69LKE+Vc8Vqjz8Qw8yLF9Yb9PLwSXv/s9BHqh2c14gNCbZlyzNNMuWrxoFj1lRzqLfPTQ4u+mfobk8NSU/6Q+3cOcIyWakJ38bvIEep3RkJcD8Xa73KRLvmR/Je5T2XMsBII1BtqVFBmvt3lVnfh6i3orlj31f7V8TbC4z/irD9VhdyxzS/T0D8FJie3LQPzvNXKt4dNPDIdrdTiJF9vsKECAakDTEl98Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VfKxpF8mb3itoxa5ThZAF1lp7/sMjz2euL2MvgoRqKnfVik1hK6YiHL8sLPFFod7vtYUT2yIRtqhrP7gzoWKtsZ2c8li8OF9D/j4VluWmFIDELfGr8TdwAjFOOS7kx2xxioYhDWrSCzjYQhkKB1bWeLcFMCC4Wcospa4e8GZwBmRYclpgp9StHEl+euHPAhQ+N2aB/FLFXBabdp70RKP6mlB+cFhrBursn68pW5bMhzuYjwfAXPbZz3RTna2/Q7tOAaknHtbOR/iyQkpabtuz4yCHVIMQsKrnyKVAITQCojQlnELa9oWDFtjtCVGT2GcZQKIlJvs0BBGXJYd7SbTo0nbdSrQPtQinCU5TieByNO70f/DwTreZnOSDvXovgqSOOO6No8czVjB0zh2aycJb0x5jFsqHY0zKQH8UkDJCtJJ+KPie9Vd2nY0RoDYMieg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:13:48.6002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53937f19-7985-41a7-1950-08deed302c14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/szHTwuIvFrHDQPgatqSXSQvTopPs28IqQZOiZmRa4U=;
 b=UKeHXyueYEiEnvf2RJO7yXGHs/iZRc+uA3jvdVxwSXZiIVBZBbuVfzmXgbWd7JdKKBlFhumzLSFfFuWx98DNQwmbM26mpr4GwFLM47cK48D/byv7kSC9ttpJBly/dxbZFZkn7bmf24S+7R157vMuj1av8/dVHB22sx0kfXfG+74=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=UKeHXyue
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=Pranav.sanwal@amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="UKeHXyue"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series improves diagnosability of GPIO offset collisions and fixes
three related bugs in the gpio-delay driver that were uncovered while
debugging such a collision.

Patch 1 logs, at dev_dbg() level, which label already holds a GPIO
offset when a new request collides with it, from within
dm_gpio_request() itself, so a collision can be root-caused from the
uclass layer when actively debugging.

Patch 2 adds the same diagnostic to the "gpio" command, at printf()
level. -EBUSY from gpio_request() is a normal, expected result there (a
pin already owned by a driver or hog), so the command already tolerates
it silently; this patch only prints which label holds the pin on that
already-tolerated path.

Patch 3 fixes gpio_delay_probe()/gpio_delay_xlate() to size and
validate against the driver's actual GPIO count (from its "gpios"
property) instead of a hardcoded 32, correctly sizing the claimed/name
tracking arrays and matching the pattern used by the generic uclass
xlate implementation.

Patch 4 fixes gpio_delay_xlate() to propagate the requested index into
desc->offset. Previously every consumer's descriptor came back with
offset 0 regardless of which index was requested, so on boards where
gpio-delay wraps more than one real GPIO line, every consumer past the
first silently collided with the first consumer's already-claimed
offset 0 and was never toggled. This was the root cause behind the
series; the other patches are diagnostic and robustness fixes found
along the way.

Patch 5 adds a .remove hook to gpio-delay to release the real GPIOs it
wraps. The driver requests them via gpio_request_by_name_nodev(), which
strdup()s a label into the wrapped device's own uc_priv->name[]; with
no .remove, those requests and labels were never released on teardown.

Patches 3-5 are tagged Fixes: c866f2f197e2 ("gpio: Add GPIO delay
driver").

Changes in v2:
- Patch 1: downgraded from dev_warn() to dev_dbg(), since -EBUSY is a
  normal/expected result for some callers (e.g. cmd/gpio.c, and sandbox
  tests that deliberately exercise this path), and warning there fired
  on legitimate operations, not just misconfiguration (Simon)
- New patch 2: moved the user-facing diagnostic into the "gpio" command
  instead, where -EBUSY is already known to be expected (Simon)
- New patch 5: additional related fix found while further exercising
  the driver

Pranav Sanwal (5):
  gpio: uclass: log when a gpio offset is already claimed
  gpio: cmd: warn when a gpio offset is already claimed
  gpio: delay: set gpio_count and validate index against it
  gpio: delay: fix offset propagation in gpio_delay_xlate()
  gpio: delay: free wrapped real GPIOs on remove

 cmd/gpio.c                 | 11 +++++++++--
 drivers/gpio/gpio-delay.c  | 23 ++++++++++++++++++++++-
 drivers/gpio/gpio-uclass.c |  5 ++++-
 3 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.43.7

