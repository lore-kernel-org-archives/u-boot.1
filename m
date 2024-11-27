Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A483D609A8
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 07:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55A889CCE;
	Wed, 27 Nov 2024 08:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sGCm0pfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E2B389CA5; Wed, 27 Nov 2024 08:07:01 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431B589CA5
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 08:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4943C41028; 
 Wed, 27 Nov 2024 07:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732691209;
 bh=XA/hrsUL6qa2FihaC619dps5SnfGaoc/I36j+6MBqjA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=sGCm0pfW5g/+Xn8FdFhJpdx4V7rBU4mdsGUgwtQvdrLml89HA1/6+P2dARl/I40MF
 Xf/eEXL0mWDSo+Ew+Vt3HXTcAtyl7z0jzT5W85CRh7xAusvQ3PbNwpdxvIDRDaYqmS
 2qT+vRu4AkW/Z3efkpJz6qodXfwG/oWmucD/RHVWmW/G/wFctuQlgUdwazJKMDJ0+K
 l5loRTlfr9JmCJefIfNyDGwq3eTa/ql9SqExBlNvTWombcxvwp+RjCenOtrcmt+Ku3
 f45zJLRmeZs0Z5sJfo1uyzLposV7+bd4riuCazTrXAp7nFB39CbOAenS9ot1xP51xu
 1EYaUBwlFsiTQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 6/6] efi_loader: run bootdev_hunt() to find ESP
Date: Wed, 27 Nov 2024 08:06:31 +0100
Message-ID: <20241127070631.16412-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
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

Some hard devices need specific routines to scan for block devices,
e.g. NVMe (nvme scan), SCSI (scsi start).

Invoke bootdev_hunt() to find all block devices.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 cmd/bootmenu.c             | 39 +++++++++++++++++++++++++++++---------
 doc/usage/cmd/bootmenu.rst | 13 ++++++++++---
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index ffa63a4628d..90f4f3d583c 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -330,7 +330,13 @@ static int prepare_uefi_bootorder_entry(struct bootmenu_data *menu,
 }
 #endif
 
-static struct bootmenu_data *bootmenu_create(int delay)
+/**
+ * bootmenu_create() - create boot menu entries
+ *
+ * @uefi:	consider UEFI boot options
+ * @delay:	autostart delay in seconds
+ */
+static struct bootmenu_data *bootmenu_create(int uefi, int delay)
 {
 	int ret;
 	unsigned short int i = 0;
@@ -357,7 +363,7 @@ static struct bootmenu_data *bootmenu_create(int delay)
 		goto cleanup;
 
 #if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) && (IS_ENABLED(CONFIG_CMD_EFICONFIG))
-	if (i < MAX_COUNT - 1) {
+	if (uefi && i < MAX_COUNT - 1) {
 		efi_status_t efi_ret;
 lib/efi_loader/efi_setup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779d..8e0ff16f3eb 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -7,6 +7,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <bootdev.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <log.h>
@@ -228,6 +229,13 @@ efi_status_t efi_init_obj_list(void)
 	 * Probe block devices to find the ESP.
 	 * efi_disks_register() must be called before efi_init_variables().
 	 */
+	if (CONFIG_IS_ENABLED(BOOTSTD)) {
+		int r;
+
+		r = bootdev_hunt(NULL, 0);
+		if (r)
+			log_debug("No boot device available\n");
+	}
 	ret = efi_disks_register();
 	if (ret != EFI_SUCCESS)
 		goto out;
-- 
2.45.2

