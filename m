Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ADEC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23D41881D7;
	Fri, 22 Mar 2024 11:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83FA8820F; Fri, 22 Mar 2024 11:59:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AD86F881C6
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EADB1063;
 Fri, 22 Mar 2024 03:59:41 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33F0F3F64C;
 Fri, 22 Mar 2024 03:59:03 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 17/20] test: fwu: make changes to the FWU metadata access
 test
Date: Fri, 22 Mar 2024 16:27:30 +0530
Message-Id: <20240322105733.203888-18-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322105733.203888-1-sughosh.ganu@linaro.org>
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
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

Make changes to the FWU metadata access tests corresponding to the
changes in the FWU metadata access code.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* Make changes to have the test work with v1 metadata.
* Make changes to have the test work with updated logic in fwu code.

 test/dm/fwu_mdata.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
index 52018f610f..621ba647d9 100644
--- a/test/dm/fwu_mdata.c
+++ b/test/dm/fwu_mdata.c
@@ -93,6 +93,10 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
 	struct udevice *dev;
 	struct fwu_mdata mdata = { 0 };
 
+	ut_assertok(setup_blk_device(uts));
+	ut_assertok(populate_mmc_disk_image(uts));
+	ut_assertok(write_mmc_blk_device(uts));
+
 	/*
 	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
 	 * to populate g_dev global pointer in that library.
@@ -100,9 +104,7 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
 	event_notify_null(EVT_MAIN_LOOP);
 
 	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
-	ut_assertok(setup_blk_device(uts));
-	ut_assertok(populate_mmc_disk_image(uts));
-	ut_assertok(write_mmc_blk_device(uts));
+	ut_assertok(fwu_init());
 
 	ut_assertok(fwu_get_mdata(&mdata));
 
@@ -118,18 +120,20 @@ static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
 	struct udevice *dev;
 	struct fwu_mdata mdata = { 0 };
 
+	ut_assertok(setup_blk_device(uts));
+	ut_assertok(populate_mmc_disk_image(uts));
+	ut_assertok(write_mmc_blk_device(uts));
+
 	/*
 	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
 	 * to populate g_dev global pointer in that library.
 	 */
 	event_notify_null(EVT_MAIN_LOOP);
 
-	ut_assertok(setup_blk_device(uts));
-	ut_assertok(populate_mmc_disk_image(uts));
-	ut_assertok(write_mmc_blk_device(uts));
 
 	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
 
+	ut_assertok(fwu_init());
 	ut_assertok(fwu_get_mdata(&mdata));
 
 	active_idx = (mdata.active_index + 1) % CONFIG_FWU_NUM_BANKS;
-- 
2.34.1

