Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CBBD637AC
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 19:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BCAE890DA;
	Wed, 13 Nov 2024 20:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pBF6uhtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0760F8916C; Wed, 13 Nov 2024 20:55:27 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E40CC890D9
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 20:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 145CA3FB5F; 
 Wed, 13 Nov 2024 19:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731527724;
 bh=iWTjvd8Og7yRc30e9TaRiwVIh3I2/jEZ7ky/JNXXKEU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=pBF6uhtnq2MybZHJ/Tx4vit6hE/UXa8HdwPsJehMoqCmvTF5QeOyX1A7B7xvmJPvq
 rZXLiZNDI3sGjRAq+71XUBm9d5b64YtX9syRUIDxOEN7bli8nVB1TPVrWa8ig+WHfr
 3T6Zk7bieY43P9Rs5DykyMS9pTS1+o5lDJkjHI9mYGcHTalr2nU4cRWv9Tdg2ykbft
 JDHzGRnvA7SuOYvqrXmbeTBTYQKtzJQ6Q/JAvpwC7rHLPhaR0UQZa4+nApSkxFAwIv
 6ItXzAzOKcKofIEDBl8u5aZ8AF4ZLRdQnRDwl1ZqmB2m20R2r22LEmvnt9TEAt5eag
 Q1HMarM2MR/0g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: run bootdev_hunt() to find ESP
Date: Wed, 13 Nov 2024 20:55:19 +0100
Message-ID: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
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

