Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ED9EE49A5
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 00:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7450986407;
	Wed, 23 Aug 2023 02:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UOrehcHm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pNtv3H+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE1D86460; Wed, 23 Aug 2023 02:17:13 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D745786403
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 02:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RVmxL5Zdqz9skp;
 Wed, 23 Aug 2023 02:17:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=l0h3/TW1BKq6zklogBuIdpHG+wIXfZv+qUFPWnDF+ZU=;
 b=UOrehcHm+TsqrLuSy7AdCSk+Jf8M1prmjR5vJYxr93V8xQpezYE69xNWFWOeURVoB2XHIn
 F/9YizycAc4/Bl6Em2hgwPI7t4vsE69zIKpSsC5m1k5NiU0mo04z8xapm4LZEVmHhmy1wq
 WVMrWTb3gLtkwfF+PJ2dzdxwrC0z+qU6ZkYXuOIRbg1mQ4lDdKJXrkL0C8jD/VFTDo694t
 3sI0umYV75/fy1DbCBwjerc5Ht4wCKPC8n0OMUHFqzMq7NyIrB9aqKbC3A3XUj/j8n3EIS
 j3J/oaeuouH/1Q1uMrw8tx9lCvZXY29rSpJd9KIgIYfm6ZbUVwxdBQGK0w3LAQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=l0h3/TW1BKq6zklogBuIdpHG+wIXfZv+qUFPWnDF+ZU=;
 b=pNtv3H+OI8nZoVyDYrAltUu4IaKtXz2N8SCzK/O6rKSX4+m99w+3dz+UaZIsE3cVycogxW
 IDXhqJz71+r4ULJpGDyti2B3yxZWkU4wBgTNEpIrMRdIMehPF1Gmccbde0nV7dpQg1dKZN
 XkyUSlUghgMQUq2OLeM6Sszaf9LjgElKDk606fTF1B7F3Q4jYwntXWiwr8hpgGBxhGQYHk
 P3U3mdSjxQEI5yCjpbOkYt9ecSBAMvwY1nRbiWmNjfGABYjvy0xKYTutlfFmcZjP9cX9ke
 5R2GaUYig/dhVopNuRj35putJ548lxX0xD7Zx/ciJVjWP9nWFgoS2zE5my2dCw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] fwu: Initialize global fwu library state during CI test
Date: Wed, 23 Aug 2023 02:16:52 +0200
Message-Id: <20230823001652.266215-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 09c3141cb6c7896c7c6
X-MBO-RS-META: fa1mwg4ftid1kpwytnpfwkxfoesmrhdy
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

The current CI test worked by sheer luck, the g_dev global pointer
in the fwu library was never initialized and the test equally well
failed on sandbox64. Trigger the main loop in sandbox tests too to
initialize that global state, and move the sandbox specific exit
from fwu_boottime_checks after g_dev is initialized.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Etienne Carriere <etienne.carriere@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/fwu_updates/fwu.c | 12 ++++++------
 test/dm/fwu_mdata.c   | 12 ++++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 4d0c8b84b9d..22bdc78df59 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -623,18 +623,18 @@ static int fwu_boottime_checks(void *ctx, struct event *event)
 	int ret;
 	u32 boot_idx, active_idx;
 
-	/* Don't have boot time checks on sandbox */
-	if (IS_ENABLED(CONFIG_SANDBOX)) {
-		boottime_check = 1;
-		return 0;
-	}
-
 	ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
 	if (ret) {
 		log_debug("Cannot find fwu device\n");
 		return ret;
 	}
 
+	/* Don't have boot time checks on sandbox */
+	if (IS_ENABLED(CONFIG_SANDBOX)) {
+		boottime_check = 1;
+		return 0;
+	}
+
 	ret = fwu_get_mdata(NULL);
 	if (ret) {
 		log_debug("Unable to read meta-data\n");
diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
index 8b5c83ef4e2..52018f610fe 100644
--- a/test/dm/fwu_mdata.c
+++ b/test/dm/fwu_mdata.c
@@ -93,6 +93,12 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
 	struct udevice *dev;
 	struct fwu_mdata mdata = { 0 };
 
+	/*
+	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
+	 * to populate g_dev global pointer in that library.
+	 */
+	event_notify_null(EVT_MAIN_LOOP);
+
 	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
 	ut_assertok(setup_blk_device(uts));
 	ut_assertok(populate_mmc_disk_image(uts));
@@ -112,6 +118,12 @@ static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
 	struct udevice *dev;
 	struct fwu_mdata mdata = { 0 };
 
+	/*
+	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
+	 * to populate g_dev global pointer in that library.
+	 */
+	event_notify_null(EVT_MAIN_LOOP);
+
 	ut_assertok(setup_blk_device(uts));
 	ut_assertok(populate_mmc_disk_image(uts));
 	ut_assertok(write_mmc_blk_device(uts));
-- 
2.40.1

