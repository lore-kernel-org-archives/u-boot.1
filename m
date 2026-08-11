Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1B7C5CFCF
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 10:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4D8F81007;
	Tue, 11 Aug 2026 10:53:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hLyt7ZUxbD1q; Tue, 11 Aug 2026 10:53:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 67EED80FFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786445619;
	bh=BuFTq3SWry/Zh/VlW5OvILljH4mAalaqdLkERdD/igI=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w9FxfFt3bRMsGVo5dRVwQGZlCqSYobfoFkjMUhTAOHkh68oeKk0JzW+VgLbB8gPJO
	 vZ+DN1ZiXE8VGX8pcSEsyD9jzNHPJi8efPs7zJJNlrlwFnqvfQePC5MvlPmj1Dcwff
	 toxnL71sdCAQIBnz3corysqCOxUzfaFha03NfQJVBGtnfhvU2hMDrQ09HJrWa9F4Y4
	 IKU34oKtgjbq3cXgzAn6D9hM76BC28TlmlfV+UNeHXddLuY1xXyo6MpQ5PdrZj5A8h
	 v3lL8U7Vn9y45WO/P+L9QwwqPf8WyV+Nw7R4y55W9Elf5JFOh24BORwSCAfWUGXZo2
	 KtI4x/mjXus+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67EED80FFA;
	Tue, 11 Aug 2026 10:53:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 99BB7259
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8BC4880FFA
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iiu8ZQ5o-hTA for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 10:53:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6294980C34
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6294980C34
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6294980C34
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLybypQb27peR8iInfPnkoFDJrmuWGGcpGUrTlhjznoXu+9ZmJTwHB7nHGiqEIt63+8pqGQeRGmwywyFPaUcUjVd0cQ2VnlZhmi0y37VV1nviQkrliah0DhnoqJeBdOu58nSQuQoGkpSykoGEvI1U5fgXjwZ15ysQQt1aOt93IbD46z6R9DTE0VetoZ6yKmo2i58t3bjWOmsDisF5jlXrfcRF54x/j/LZRSQy0/zUJ+V5YDPbrYtol9tknx2aZYRYQKJjQifFmMDi07uMkusTpLRoQPja3YtgOGqb3tYCmcVdU9B9NYLe9bxyk1rYZxprnVIBtfrHhsrR511vXNW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuFTq3SWry/Zh/VlW5OvILljH4mAalaqdLkERdD/igI=;
 b=aLElqA+Y+/h02aE/HyoKZShtBFQ4+pIc+jvE7BZUvoJmg07mKcyTHctookQ2454CaAQ2LDHxsu8iTgYHdMBeqRcISKbyzpNRdN6A2jIn12khoG7OvWBH3HVoWXVgV4nJ5XjB7DG3og3r1t4oOuW3aj8QR90NjEoXgK09NjaWqTYVvchSUu7bi2mAdO6vJnfeNHJ3RNmVFHq3Xuqixlm00HM/HQ7HIh/8eZlL15pNKWhX8uXPrR7iV5+NvpX7g8Wcne5PA0nLAcJvlE4uhEv4zFg/LI9jKffywXhjRvGlPtyyBPoXk9uRdzYaaV4SCc6OxJuVk1SJoMoFWlSqufhhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from MN2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:208:23b::35)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 10:53:30 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::5b) by MN2PR11CA0030.outlook.office365.com
 (2603:10b6:208:23b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 10:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 10:53:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 05:53:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 05:53:27 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 11 Aug 2026 05:53:26 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v3 0/6] gpio: improve claim diagnostics and fix gpio-delay
 offset handling
Date: Tue, 11 Aug 2026 16:23:08 +0530
Message-ID: <20260811105314.3837228-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8e5cb6-5231-437a-228f-08def796c70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|11063799006|56012099006|10067099003|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 7eOy9Fmi59reFPlI2jg8Hsxv6vuaJ4OEiCd42rfGz8fQzokaL2r7Ja1es48jyA/pEHfGD40yjLQmr4LXzxwdbRvd1yNMsHBCF71gETy/3xSS6m1CQoQrLkPYDzcQ6BAkDdBtC7GQeXFu9X97sleAwO2IQlW8D3mgbHNnM/B9qac68CUzG0XyUdl0Ylz3eAGZ/XS2GZqqJPXs9uCVtv6Zzb5LXB41QTuLDpc4Q7morfAuXChLTnyqYFBvDmr1vKEJqFwKvmLA+lFtey3fPfAE18q03f1Nygj4lCaczI2ATmtgosMByXYG3I4r4QDibWLnJstm0JJHujBLct+6Cpwzk3P5LHTFVABPGoq6YisaDsY794D5htdkT1GHeQK26CUpZYdFb8TpNxJdKvVmCu4nF06bm6P2a8S0MIwzbYa0Gsl0z4eFEh22l5jGtslW9YoFXaQAU6Moth7mVNnT89kpYbFuRXuoxITurGXo+xoEIkJRyAY+NCeLllGa+eAssVZiLaXl1tJDNVf4OBrAOtqNkeYnu6aaDq69MAgo2eJlv3pS1y/isPccYoalO2bSFKu5EMFxddD+AN6SR/A+pFVG4E3m8RQ7btHOLbEmkzo693tkLOqqczaWEwA39gGscARh4nGhjGJwpxPu078EuwsOKag+XslyqQiHBahCzo5PgFb1Je3HpJPtMtvXx3am9dvMDSqkJdp6MOVIOUhyRG0bwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DMuKrjdIonnYjdrWCBP9JPpy6tuvWWGQgWtYIJ04Nsex058bBDOefKYhdrAwW/0wLjKbTs592gv/QT9k3D7BC94PaYzkRccNbz/mE1tPRvNDpB2cm/Rc8ZSLrlmF16JEGsxpxc57PhrhvX7KlxzXPpErql6aVUNY2hDiCM5CchjQ9Qs2fKATgMCVnP6vf9JYCUciSfSrEbHBOAcXQg3nsIVTn9nfxzD8N2i2eog86+zCDZpHGWeU2JFwvjhF0Zz4qdbMvayneSI5ARYk1wNgncYvL4fYhb9aPNDh0jXGEsZsZvyIjCSG35QEcHznE3Lo5cZBudeGr5MtiEBUVnzm4ZNJxaPO4Iy3lICIDrbmA6yKgZCtQt8Dhq14ZmMgWJ2XDSZRsLEMfVB1ng6RElwXKxJL0fRVOxbRQoNWEFroVuYWjjWzXf90xY8k+nKVb0FS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:53:28.9408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8e5cb6-5231-437a-228f-08def796c70d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuFTq3SWry/Zh/VlW5OvILljH4mAalaqdLkERdD/igI=;
 b=ii0zjHaZ0PxPTa/6rXxcnAK6GSSIBdO9hr/4fIt1v0JdWcI9IAZlAMFrYqElh9c+rxYZ0iypJ+8wGLWF4BITlJCMzIXI7KxvgpJE+1T2pR3VgqMm60YX9XRFCaqVMbTEMUU9uTabEIMgPgfYdotp2lMEd0p9jOrzyIT0Bc1vziw=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ii0zjHaZ
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
four related bugs in the gpio-delay driver that were uncovered while
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

Patch 6 fixes a related pre-existing leak: gpio_delay_probe() bailed
out on the first failed GPIO request without freeing the ones it had
already requested, and patch 5's new .remove hook doesn't cover this
either since .remove is only called for devices that finished probing.

Patches 3-6 are tagged Fixes: c866f2f197e2 ("gpio: Add GPIO delay
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

Changes in v3:
- Patch 5: added an in-code comment explaining why the device_active()
  guard is needed, so a future reader doesn't need the commit message
  to understand it (Simon)
- New patch 6: fixes gpio_delay_probe()'s partial-request leak on
  failure, reusing the free helper factored out of patch 5's .remove
  hook (Suggested-by: Simon)

Sandbox coverage for the gpio-delay fixes in patches 3-5 (exercising
the offset-propagation, gpio_count/bounds, and remove-path fixes) is
posted as a separate, dependent series:
https://patchwork.ozlabs.org/project/uboot/list/?series=516335

Pranav Sanwal (6):
  gpio: uclass: log when a gpio offset is already claimed
  gpio: cmd: warn when a gpio offset is already claimed
  gpio: delay: set gpio_count and validate index against it
  gpio: delay: fix offset propagation in gpio_delay_xlate()
  gpio: delay: free wrapped real GPIOs on remove
  gpio: delay: free already-requested GPIOs on probe failure

 cmd/gpio.c                 | 11 +++++++++--
 drivers/gpio/gpio-delay.c  | 40 ++++++++++++++++++++++++++++++++++++--
 drivers/gpio/gpio-uclass.c |  5 ++++-
 3 files changed, 51 insertions(+), 5 deletions(-)

-- 
2.43.7

