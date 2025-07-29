Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B63C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 12:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C7D82BA1;
	Tue, 29 Jul 2025 14:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=ixit.cz header.i=@ixit.cz header.b="SJXk1iwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0492E82C65; Tue, 29 Jul 2025 12:40:48 +0200 (CEST)
Received: from ixit.cz (ip-94-112-25-9.bb.vodafone.cz [94.112.25.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F34E82BA7
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 12:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=david@ixit.cz
Received: from newone (office.icewarp.com [82.113.48.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id 5F6901600C2;
 Tue, 29 Jul 2025 12:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1753785644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wXi9Kdg5XNXmgkTYrm0vEcEnNsAxKOOpOPYO3OAgQC8=;
 b=SJXk1iwaziRJnWn6WXZT3v6uqSfGqx5wXKRK0s4fTppFZD8mmgmwn1hvY6SzF0QPwU802F
 boI1nN3ua6DbAPwTEHVd7+fvUML6ed9oRCH7HQtHZRPZz2UKeofevubTIUXXypMka7f5JM
 ZjZxeAOAu+RU/CcPM2NFlbER97FSRW0=
From: David Heidelberg <david@ixit.cz>
To: Tom Rini <trini@konsulko.com>,
	David Heidelberg <david@ixit.cz>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] configs: Add pixel3_defconfig for Pixel 3 / 3 XL
Date: Tue, 29 Jul 2025 12:39:49 +0200
Message-ID: <20250729103950.1154040-2-david@ixit.cz>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Jul 2025 14:37:26 +0200
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

Introduce a defconfig for the Pixel 3 and Pixel 3 XL.

On these devices, U-Boot must be chainloaded via Fastboot. However, due to
a Fastboot bug, U-Boot won’t start unless a specific condition is met.

To work around this, U-Boot must provide a TEXT_OFFSET of 0x00080000,
which allows Fastboot to successfully launch U-Boot.

Clearing the framebuffer improves the Pixel 3 experience,
as it prevents collisions with the Fastboot logo left on the display.

Instead of:
$ make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig qcom-phone.config
do
$ make CROSS_COMPILE=aarch64-linux-gnu- O=.output pixel3_defconfig qcom-phone.config

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 configs/pixel3_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 configs/pixel3_defconfig

diff --git a/configs/pixel3_defconfig b/configs/pixel3_defconfig
new file mode 100644
index 00000000000..9c0c8ca63c4
--- /dev/null
+++ b/configs/pixel3_defconfig
@@ -0,0 +1,13 @@
+# Pixel 3 has special requirement to have TEXT_BASE set for the fastboot.
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+# some Pixel 3 bootloaders aren't able to start without TEXT_BASE
+CONFIG_TEXT_BASE=0x80080000
+CONFIG_HAVE_SYS_UBOOT_START=y
+
+# fastboot logo distorts u-boot output
+# CONFIG_NO_FB_CLEAR is not set
-- 
2.50.0

