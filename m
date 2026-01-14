Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46561D31A3A
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C4F80081;
	Wed, 14 Jan 2026 10:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="R2AOujwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37DBF8063E; Wed, 14 Jan 2026 10:59:24 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A5DC8003E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 10:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id ACF684E420CA;
 Wed, 14 Jan 2026 09:59:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 834526074A;
 Wed, 14 Jan 2026 09:59:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6AFEB103C89BA; Wed, 14 Jan 2026 10:59:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768384760; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=l/ALnBZMRADlWwReOxb4xgdx2pgvj3TyREoNBHsvVoo=;
 b=R2AOujwebgF+ZUczfAYyxr7gekHTKDFHAVa5GiEqZmt21LVLCr+MqMBLj2OUGwW5Nz5Um0
 PYl7ycdrwL/pP9/ZTHTLsVZLB3nVgobMOZ/8zTV10RRYm/C8U3nQqyYlqsjWUA0rAzP9Vs
 R/VpIdueXatoK+3NVq04YS4kLKWDvipJLO11b3zrqfNui1Fn+ilqp/Zv1LtXW/YTxAGFYh
 Q6mONGWvsEgP7IXtgiEMJrAqXzT34rXf4LH8snfGCR18gIPzbu8mtlObK1Iv9vtEfMRD+y
 9dqzB1PT1zScz64H90E5fVOfR7BXM6Ohy6+3R/82W1i2PAWlH0xFScFof8dNrg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>
Subject: [PATCH] fwu: Mark failed bank as invalid during rollback
Date: Wed, 14 Jan 2026 10:59:15 +0100
Message-ID: <20260114095917.737634-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

When boot_idx differs from active_idx at boot time, it indicates a
rollback scenario where the firmware update failed and the system
reverted to the previous working bank. In this case, mark the failed
bank (active_idx) as invalid to prevent future boot attempts from that
bank.

This change adds a new fwu_invalid_bank() function that sets the bank
state to FWU_BANK_INVALID and syncs the metadata. This is only
supported in FWU metadata version 2; version 1 provides a no-op stub.

Without this change, a failed bank would remain in a valid state and
could potentially be selected for boot again, leading to repeated
boot failures.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/fwu.h            |  8 ++++++++
 lib/fwu_updates/fwu.c    |  1 +
 lib/fwu_updates/fwu_v1.c | 10 ++++++++++
 lib/fwu_updates/fwu_v2.c | 19 +++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/include/fwu.h b/include/fwu.h
index e7bd1d492af..e4f3a062e36 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -415,6 +415,14 @@ int fwu_get_mdata_size(uint32_t *mdata_size);
  */
 int fwu_state_machine_updates(bool trial_state, uint32_t update_index);
 
+/**
+ * fwu_invalid_bank() - Invalid bank state of a specific bank
+ * @index: Index of the bank
+ *
+ * Only supported in version 2 of FWU metadata.
+ */
+void fwu_invalid_bank(uint32_t index);
+
 /**
  * fwu_init() - FWU specific initialisations
  *
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 0f5ef2ba515..e54c19b0c64 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -766,6 +766,7 @@ static int fwu_boottime_checks(void)
 	if (boot_idx != active_idx) {
 		log_info("Boot idx %u is not matching active idx %u, changing active_idx\n",
 			 boot_idx, active_idx);
+		fwu_invalid_bank(active_idx);
 		ret = fwu_set_active_index(boot_idx);
 		if (!ret)
 			boottime_check = 1;
diff --git a/lib/fwu_updates/fwu_v1.c b/lib/fwu_updates/fwu_v1.c
index 974abf216f6..c9ac1ec244d 100644
--- a/lib/fwu_updates/fwu_v1.c
+++ b/lib/fwu_updates/fwu_v1.c
@@ -136,6 +136,16 @@ int fwu_get_mdata_size(uint32_t *mdata_size)
 	return 0;
 }
 
+/**
+ * fwu_invalid_bank() - Invalid bank state of a specific bank
+ * @index: Index of the bank
+ *
+ * Not supported.
+ */
+void fwu_invalid_bank(uint32_t index)
+{
+}
+
 /**
  * fwu_init() - FWU specific initialisations
  *
diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
index 159315b45b9..3c07adfd4e0 100644
--- a/lib/fwu_updates/fwu_v2.c
+++ b/lib/fwu_updates/fwu_v2.c
@@ -194,6 +194,25 @@ int fwu_state_machine_updates(bool trial_state, uint32_t update_index)
 		fwu_bank_state_update(0, update_index);
 }
 
+/**
+ * fwu_invalid_bank() - Invalid bank state of a specific bank
+ * @index: Index of the bank
+ */
+void fwu_invalid_bank(uint32_t index)
+{
+	struct fwu_data *data = fwu_get_data();
+	struct fwu_mdata *mdata;
+	int ret;
+
+	mdata = data->fwu_mdata;
+	data->bank_state[index] = FWU_BANK_INVALID;
+	mdata->bank_state[index] = FWU_BANK_INVALID;
+
+	ret = fwu_sync_mdata(mdata, BOTH_PARTS);
+	if (ret)
+		log_err("Unable to invalid bank %u\n", index);
+}
+
 /**
  * fwu_get_mdata_size() - Get the FWU metadata size
  * @mdata_size: Size of the metadata structure
-- 
2.43.0

