Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDC4C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE41580C65;
	Wed, 22 Jan 2025 18:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kqiAOmEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E9CF80A4F; Wed, 22 Jan 2025 18:10:01 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E64480977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2167141dfa1so239855ad.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565798; x=1738170598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxKzRq9Z/TRy5BMHvN0YbQcgI8n/F2SLa/+42V7qEEY=;
 b=kqiAOmEgSO4QHXSm+1UIi/4qVeXZhjl6xJK4vkAySAyC/ig7Rh7XxXc1Oon1LpS7i3
 AfMmuQrUoIfFTeKoN6iI6FhRi71VsIOzGS+lI9z4f4rz84ctxk/IqxJ5XDQ3QyX04GjI
 l+FtGcu1btffamqCDaWMSAKLcPKZh0VIJgdLSIcGNCiP2iteI97pByx3a5ZsUCFptE3p
 gpTnaeZQFy3SU9DXF/3KB8AcCfPXdORvYu5okveRIAtGql6zXVo8FVQyVvGRrpOcf2lJ
 0peVI0Uf/xMoxt8yaznjZanDo8rFNO61bF/gawsYM5KihqELFvxsJMBBAtjMe26UM0bS
 eb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565798; x=1738170598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxKzRq9Z/TRy5BMHvN0YbQcgI8n/F2SLa/+42V7qEEY=;
 b=KldleRbEf+6QE+ATDvZ4vlhGuvr4kpcvL8e/W8xsoqBZHWwYx1Ts4OyFmHrHm5q3o+
 GVQdkuLIRg2rU1T9HMe8mi/VkgqhdhWYmmupIlr+h3WsM2b2cUj0KgqryBHll54y/Uhc
 lcOphJxGoGBgNMfuDAIM3004MUoNUyV9Y7+qxdLSBWRzw2oTaEuKuk13xYrN96qVOHA3
 wlISkGWW1FxrRUrqM9OT92gddqxwmVjBpqpbfg0ixBxrOjjg59dDPqdwzKWdT6CIr2zR
 0vbJoIUipenNRnA+y3OUjrM/SEt3CTXbsYb6188Cxs9Wc6dM3UhY42tCLwWiY3/Mho34
 75Fw==
X-Gm-Message-State: AOJu0YxGzau8agAmPdhaKRO3jd0BLiLiAZSS8AcXTZwmpKlTB4HhuwfC
 2GHH5okLd/S+7BVi/VHVurqn9uUZKo1Qy3RcoXilEUB6wtk3pG4cZp3kgEr2
X-Gm-Gg: ASbGnctYiMcvoW1zQr0wLGg2PuPGlX+t8XertrLrHoI4fRG0c27NAcoSHG8245T6U/5
 nFA43Dw25jH5J9zGa9I1FYZd5w7RiCxERAbn+gJaO1oUKINb52Bg0hfmoAkjfG+7YjpWvrBe4ps
 raSIqJjYLfQ0H1HWCeDykn7U/4db2bWOtVqP8KnC8lWVIeCeE0CNO62sUQ4V6oseK+lqjcCb0te
 AxHLVloTVR1eQdcNHsmV9GRt2DWS15rqouIFjYmiLS8//EHSFPZpU5IOxpAQebr3bjcE5ysi1b3
 Fw==
X-Google-Smtp-Source: AGHT+IHiSg95Aos7TDhenT9RUKJngD7vde9++Z78hkm/JZUZaX9je427GaEiWKWAH569zKu6Gxmj1g==
X-Received: by 2002:a17:902:c951:b0:215:758c:52ea with SMTP id
 d9443c01a7336-21d9933a4bfmr576035ad.9.1737565797729; 
 Wed, 22 Jan 2025 09:09:57 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:57 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 18/21] efi_selftest: Add selftest for counting EFI netdevices
Date: Wed, 22 Jan 2025 14:08:55 -0300
Message-ID: <20250122170858.961359-19-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122170858.961359-1-adriano.cordova@canonical.com>
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
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

Count the number of simple_network_protocol's

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_selftest/Makefile                  |  2 +-
 lib/efi_selftest/efi_selftest_net_device.c | 65 ++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 lib/efi_selftest/efi_selftest_net_device.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 17fbfad116..f7e8f02cb2 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -51,7 +51,7 @@ efi_selftest_variables_runtime.o \
 efi_selftest_watchdog.o
 
 obj-$(CONFIG_EFI_ECPT) += efi_selftest_ecpt.o
-obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o
+obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o efi_selftest_net_device.o
 obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_http.o
 obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_ipconfig.o
 
diff --git a/lib/efi_selftest/efi_selftest_net_device.c b/lib/efi_selftest/efi_selftest_net_device.c
new file mode 100644
index 0000000000..51963eb328
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_net_device.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * efi_selftest_net_device
+ *
+ */
+
+#include <efi_selftest.h>
+#include <net.h>
+
+static struct efi_boot_services *boottime;
+
+/*
+ * Setup unit test.
+ *
+ * @handle:	handle of the loaded image
+ * @systable:	system table
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int setup(const efi_handle_t handle,
+		 const struct efi_system_table *systable)
+{
+	efi_uintn_t num_handles;
+	efi_handle_t *handles;
+
+	boottime = systable->boottime;
+
+	num_handles = 0;
+	boottime->locate_handle_buffer(BY_PROTOCOL, &efi_net_guid,
+				       NULL, &num_handles, &handles);
+	efi_st_printf("Detected %u active EFI net devices\n", (unsigned int)num_handles);
+
+	return EFI_ST_SUCCESS;
+}
+
+/*
+ * Execute unit test.
+ *
+ *
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int execute(void)
+{
+	return EFI_ST_SUCCESS;
+}
+
+/*
+ * Tear down unit test.
+ *
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int teardown(void)
+{
+	int exit_status = EFI_ST_SUCCESS;
+
+	return exit_status;
+}
+
+EFI_UNIT_TEST(netdevices) = {
+	.name = "netdevices",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.setup = setup,
+	.execute = execute,
+	.teardown = teardown,
+	.on_request = true,
+};
-- 
2.43.0

