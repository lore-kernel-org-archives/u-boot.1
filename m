Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074A8E668A5
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 00:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E3A80325;
	Sat, 20 Dec 2025 01:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OslrASiZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F57803F5; Sat, 20 Dec 2025 01:05:38 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B90280050
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 01:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-003-045.46.114.pool.telefonica.de
 [46.114.3.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8977F3F35B; 
 Sat, 20 Dec 2025 00:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766189135;
 bh=fUGCs3tHXGAyvNNGV2haro/hdpLZ5z1+b0V5IqcIovQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=OslrASiZUOC+ztcl/zYcKNhBgIh+VXLMCZuImz6fqQVcmI6/qW0E0vhXRkY/5rbd3
 ERE1Li9jcXwl37QAJ73TDnGoqmOj0++NXChY9gyUJgLYEf8nRawDeJscT7NrjJwxvR
 V+PTGrMZzRxWF7mAa5bpoJz7HZ/qEOhZIJ3JkNoJRMVBflPi5EG9TAFnHJlQcY0YIF
 HKGbvq3AV/H+tNdLDDkSlTZooj/R59qfWKogdY9nekY+YewhHcsigL0dT6yCFw+z4X
 9DPi1zbm0XEvt++cF89H9kIWRQefGZVm2A0V6Ik/M3mui0QKwGD27Kn+8m6qG3wpQa
 3EuO6ouwt0Y/igRAhQUsWAF7GSxs1rgAjyO8zzJJFK6ijj62x7K0ZnG/O2UYzcxyJ4
 hoVaS8WbUGGSA/UVp7ETf15SL7lwatIiH3uhYAwSfqdzNALQaAmGDpTPM5CKaDMXiG
 8pNWBX+s99u9iRUw7DPnhdF08thN/k+wl8x7TPIA9qmA+7j9FThXpTZps6c1ssNLoL
 ThAwwP/bEKzsZUWwzFFr7Bgjv6J9jCCNNCIMGXH5aQRyMBblvvslFE1SpKCE+cADMU
 H45kkklPrnHfSGANVmJl0urPOV5IVTh0Acx+EH5N0xotRkgpPLNX0rwG58PVlP3PwU
 p0vPCda8tk+oX3lgPFn52fYs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd/bdinfo: LMB and device-tree are not related
Date: Sat, 20 Dec 2025 01:05:31 +0100
Message-ID: <20251220000531.278098-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The usage of the LMB library and the device-tree source are not related.

Remove the dependency in the bdinfo output and adjuste the unit test.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/bdinfo.c      | 9 +++++----
 test/cmd/bdinfo.c | 8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 20c8c97f0cd..8e2bbfa9c20 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -160,11 +160,12 @@ static int bdinfo_print_all(struct bd_info *bd)
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT)
 	bdinfo_print_num_l("multi_dtb_fit", (ulong)gd->multi_dtb_fit);
 #endif
-	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
+	if (IS_ENABLED(CONFIG_LMB))
 		lmb_dump_all_force();
-		if (IS_ENABLED(CONFIG_OF_REAL))
-			printf("devicetree  = %s\n", fdtdec_get_srcname());
-	}
+
+	if (IS_ENABLED(CONFIG_OF_REAL) && gd->fdt_blob)
+		printf("devicetree  = %s\n", fdtdec_get_srcname());
+
 	print_serial(gd->cur_serial_dev);
 
 	if (IS_ENABLED(CONFIG_CMD_BDINFO_EXTRA)) {
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 2b4866a172e..3005c85d4a0 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -191,11 +191,11 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	ut_assertok(test_num_l(uts, "multi_dtb_fit", (ulong)gd->multi_dtb_fit));
 #endif
 
-	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
+	if (IS_ENABLED(CONFIG_LMB))
 		ut_assertok(lmb_test_dump_all(uts));
-		if (IS_ENABLED(CONFIG_OF_REAL))
-			ut_assert_nextline("devicetree  = %s", fdtdec_get_srcname());
-	}
+
+	if (IS_ENABLED(CONFIG_OF_REAL) && gd->fdt_blob)
+		ut_assert_nextline("devicetree  = %s", fdtdec_get_srcname());
 
 	if (IS_ENABLED(CONFIG_DM_SERIAL)) {
 		struct serial_device_info info;
-- 
2.51.0

