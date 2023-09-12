Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09A4CA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5873086E69;
	Tue, 12 Sep 2023 11:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LrqXCjZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B6E786B33; Tue, 12 Sep 2023 11:47:39 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 7576986E33
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 63A12212BC14;
 Tue, 12 Sep 2023 02:47:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63A12212BC14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694512052;
 bh=aipxIKPAeFLu3OmSm+tRAi7yoJWd0O+ivgV6v47+poE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LrqXCjZHwuDdOL9pc2+NHr+6Z3dh57SSBYaA6oxbSOgMeJrk0zJS1OdSDeMteQm27
 HjNCGiAWFTcBiLmNnuhWtnCaOO5HNRY0UbLlxPtHtNFwJTFVjIXyC6fMWsXkYQo07D
 bVRyF/OxsOF4Apns/bTn1osyoMdsFSJk66Tbfnn4=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, stcarlso@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH 2/8] drivers: rollback: Add TPM2 implementation of rollback
 devices
Date: Tue, 12 Sep 2023 02:47:25 -0700
Message-Id: <20230912094731.51413-3-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
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

From: Stephen Carlson <stcarlso@linux.microsoft.com>

This implementation of the rollback uclass driver allows existing TPM2
devices declared in the device tree to be referenced for storing the OS
anti-rollback counter, using the TPM2 non-volatile storage API.  The
rollback device must be a child of the TPM device.  For example:

	tpm2 {
		compatible = "sandbox,tpm2";

		rollback@1 {
			compatible = "tpm,rollback";
			rollback-nv-index = <0x1001007>;
		};
	};

Signed-off-by: Stephen Carlson <stcarlso@linux.microsoft.com>
Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 MAINTAINERS                     |   1 +
 drivers/rollback/Makefile       |   1 +
 drivers/rollback/rollback-tpm.c | 117 ++++++++++++++++++++++++++++++++
 include/tpm-v2.h                |  17 +++++
 lib/tpm-v2.c                    |  48 +++++++++++++
 5 files changed, 184 insertions(+)
 create mode 100644 drivers/rollback/rollback-tpm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index de14724c27..e5ac889db4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1446,6 +1446,7 @@ F:	drivers/rollback/Kconfig
 F:	drivers/rollback/Makefile
 F:	drivers/rollback/rollback-sandbox.c
 F:	drivers/rollback/rollback-uclass.c
+F:	drivers/security/rollback-tpm.c
 
 SEMIHOSTING
 R:	Sean Anderson <sean.anderson@seco.com>
diff --git a/drivers/rollback/Makefile b/drivers/rollback/Makefile
index 4e7fa46041..63c08863ca 100644
--- a/drivers/rollback/Makefile
+++ b/drivers/rollback/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_DM_ROLLBACK) += rollback-uclass.o
 obj-$(CONFIG_ROLLBACK_SANDBOX) += rollback-sandbox.o
+obj-$(CONFIG_ROLLBACK_TPM) += rollback-tpm.o
\ No newline at end of file
diff --git a/drivers/rollback/rollback-tpm.c b/drivers/rollback/rollback-tpm.c
new file mode 100644
index 0000000000..3bb6214042
--- /dev/null
+++ b/drivers/rollback/rollback-tpm.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021 Microsoft, Inc
+ * Written by Stephen Carlson <stcarlso@microsoft.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <fdtdec.h>
+#include <rollback.h>
+#include <tpm_api.h>
+
+struct rollback_state {
+	u32 nv_index;
+	struct udevice *tpm_dev;
+};
+
+static int tpm_rollback_idx_get(struct udevice *dev, u64 *rollback_idx)
+{
+	struct rollback_state *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!rollback_idx)
+		return -EINVAL;
+
+	ret = tpm2_nv_read_value(priv->tpm_dev, priv->nv_index, rollback_idx, sizeof(u64));
+	if (ret) {
+		log(UCLASS_ROLLBACK, LOGL_ERR,
+		    "Unable to read rollback number from TPM (ret=%d)\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int tpm_rollback_idx_set(struct udevice *dev, u64 rollback_idx)
+{
+	int ret;
+	struct rollback_state *priv = dev_get_priv(dev);
+
+	ret = tpm2_nv_write_value(priv->tpm_dev, priv->nv_index, &rollback_idx, sizeof(u64));
+	if (ret) {
+		log(UCLASS_ROLLBACK, LOGL_ERR,
+		    "Unable to write anti-rollback version to TPM (ret=%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct rollback_ops tpm_rollback_ops = {
+	.rollback_idx_get		= tpm_rollback_idx_get,
+	.rollback_idx_set		= tpm_rollback_idx_set,
+};
+
+static int tpm_rollback_probe(struct udevice *dev)
+{
+	struct rollback_state *priv = dev_get_priv(dev);
+	int ret;
+
+	/* initialize the TPM rollback counter NV index
+	 * and initial to 0.  Note, this driver provides
+	 * a NULL policy.
+	 */
+	ret = tpm_rollback_counter_init(priv->tpm_dev, priv->nv_index,
+					NULL, 0);
+	if (ret) {
+		log(UCLASS_ROLLBACK, LOGL_ERR,
+		    "TPM rollback init failed (ret=%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tpm_rollback_remove(struct udevice *dev)
+{
+	struct rollback_state *priv = dev_get_priv(dev);
+
+	return tpm_close(priv->tpm_dev);
+}
+
+static int tpm_rollback_ofdata_to_platdata(struct udevice *dev)
+{
+	struct udevice *parent_dev;
+	struct rollback_state *priv = dev_get_priv(dev);
+
+	priv->nv_index = (u32)dev_read_u32_default(dev, "rollback-nv-index", 0);
+
+	parent_dev = dev_get_parent(dev);
+
+	if (parent_dev->driver->id == UCLASS_TPM) {
+		priv->tpm_dev = parent_dev;
+	} else {
+		log(UCLASS_ROLLBACK, LOGL_ERR,
+		    "TPM rollback must be a child node of a TPM\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id tpm_rollback_ids[] = {
+	{ .compatible = "tpm,rollback" },
+	{ }
+};
+
+U_BOOT_DRIVER(rollback_tpm) = {
+	.name	= "rollback_tpm",
+	.id	= UCLASS_ROLLBACK,
+	.priv_auto = sizeof(struct rollback_state),
+	.of_match = tpm_rollback_ids,
+	.of_to_plat = tpm_rollback_ofdata_to_platdata,
+	.probe	= tpm_rollback_probe,
+	.remove	= tpm_rollback_remove,
+	.ops	= &tpm_rollback_ops,
+};
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 2b6980e441..8c441066a0 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -321,6 +321,7 @@ enum tpm2_return_codes {
 	TPM2_RC_COMMAND_CODE	= TPM2_RC_VER1 + 0x0043,
 	TPM2_RC_AUTHSIZE	= TPM2_RC_VER1 + 0x0044,
 	TPM2_RC_AUTH_CONTEXT	= TPM2_RC_VER1 + 0x0045,
+	TPM2_RC_NV_UNINITIALIZED	= TPM2_RC_VER1 + 0x04a,
 	TPM2_RC_NV_DEFINED	= TPM2_RC_VER1 + 0x004c,
 	TPM2_RC_NEEDS_TEST	= TPM2_RC_VER1 + 0x0053,
 	TPM2_RC_WARN		= 0x0900,
@@ -706,4 +707,20 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
  */
 u32 tpm2_auto_start(struct udevice *dev);
 
+/**
+ * tpm_rollback_counter_init() - Initialize a TPM rollback counter
+ *                               (used by the TPM-backed rollback device)
+ *
+ * Will define the non-volitile index and initialize to 0 if it hasn't
+ * been created previously.
+ *
+ * @dev:	     TPM device
+ * @nv_index:	     NV index to initialize
+ * @nv_policy:       NV index policy (pass NULL for no policy)
+ * @nv_policy_size:  NV index policy size (pass 0 for no policy)
+ * Return: result of the operation
+ */
+int tpm_rollback_counter_init(struct udevice *dev, u32 nv_index,
+			      const u8 *nv_policy, size_t nv_policy_size);
+
 #endif /* __TPM_V2_H */
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 9ab5b46df1..c3c469eb35 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -742,3 +742,51 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 
 	return 0;
 }
+
+int tpm_rollback_counter_init(struct udevice *dev, u32 nv_index,
+			      const u8 *nv_policy, size_t nv_policy_size)
+{
+	int ret;
+	u64 data;
+	u64 data0 = 0;
+
+	ret = tpm_open(dev);
+	if (ret == -EBUSY) {
+		log(UCLASS_ROLLBACK, LOGL_DEBUG,
+		    "Existing TPM session found, reusing\n");
+	} else {
+		if (ret) {
+			log(UCLASS_ROLLBACK, LOGL_ERR,
+			    "TPM initialization failed (ret=%d)\n", ret);
+			return ret;
+		}
+
+		ret = tpm2_auto_start(dev);
+		if (ret) {
+			log(UCLASS_ROLLBACK, LOGL_ERR,
+			    "TPM startup failed (ret=%d)\n", ret);
+			return ret;
+		}
+	}
+
+	if (ret) {
+		log_err("TPM startup failed\n");
+		return ret;
+	}
+
+	/* test reading NV index from TPM */
+	ret = tpm2_nv_read_value(dev, nv_index, &data, sizeof(u64));
+
+	if (ret) {
+		/*read failed.  Assume the NV index hasn't been defined yet */
+		ret = tpm2_nv_define_space(dev, nv_index, sizeof(u64), TPMA_NV_PPREAD |
+					   TPMA_NV_PPWRITE | TPMA_NV_PLATFORMCREATE,
+					   nv_policy, nv_policy_size);
+
+		/* initialize the rollback counter to 0 */
+		if (ret == TPM2_RC_NV_DEFINED || !ret)
+			ret = tpm2_nv_write_value(dev, nv_index, &data0, sizeof(u64));
+	}
+
+	return ret;
+}
-- 
2.40.0

