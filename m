Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDDFC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4129581A04;
	Tue, 11 Mar 2025 17:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gILfyjYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54825807D7; Tue, 11 Mar 2025 17:48:24 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0570381B42
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2235189adaeso411315ad.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711700; x=1742316500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnYiv5ooMPKDg+0VINrmCQUX5jypwdmLmYwe0ws2uzw=;
 b=gILfyjYidbvvmK/VcwMrQbb8AdVu7PtrCyJHT4h1jajeuf1b2pk0nolT5aYzLHF4j5
 G1JiHX+7ibjLyj9wMHo1xERjgXYJq4MXlsKFVFTm/mBqxMRd5L57+lhYRGdsj0dIw0u8
 mvaiMsu/+6RsmvmTB/8wtcZiNGjzkw13GlrdzP0nUfyumOq22kEniciGbf2wz4Ycm0cf
 fnOSHMnvAzZ7fnniu+j0I/nA5xt3cgfdKt8qC6HVLN8UMySIqF1AcoQrm7DAjsp6SwfL
 DM6dK0iTtLrOAAiShmBz9FxNGmW2Fi6V8uYo8zuaoJJAcDJ54XEXnYq5Nxb90aof4QR2
 KhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711700; x=1742316500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnYiv5ooMPKDg+0VINrmCQUX5jypwdmLmYwe0ws2uzw=;
 b=GgpE3+SKsrZd/KQ5h8VAjvXHnYqy2U0xkGE0bA699Sx31UmwKuv9GIu3gBdcplmxTo
 MKz/HCVYSyorQMyuiDnZ75UuwCwysWny8C/GrsJ6fxlC/tP/l9HqUhUB/BZK1eVauM1y
 KdpS3XyJogLCnt2uYXWfiH4yB5tB+XaGYFwAkkSxeg7PAaKAW2MeMDvCvcdoSpxUTayn
 ay0gbYjVX3jZ7sbhDkye68kEnP8fPU/Kbe4LWLglXVV6XrDNiJMvXKO+tV3UQJ+dkCL2
 RkoZpX9WeMcC++kdNebXxX3uReQq/qygZAF1/1so73MgvxiMxPfBalTs6IGLmbwggfK6
 E8Yg==
X-Gm-Message-State: AOJu0YwKQ0PD6FxjhBCVaoDO54rjYGlevYPqmO0YjmXNBSgEdzN2PaId
 QwH7d3/oStJBj01CQUUBNqWDHrrnGyZ5zhlkbnz6EcjUGJs/Vh7ha4JvGRsKzFY=
X-Gm-Gg: ASbGnctkvaRqnoKpxt+oDUsr3jGE2As8IgZzT7Ntw+X9Xe9kGk01csYfv51zVGMLvLn
 UuT45KMfSvvwwhMPi+m3PNP+WH3owcOrhzjGmZBu6ALjfrXOgbgzR5rljeFkBdcFsbshjGfw04e
 B0iI9vxQLiXRKNUes4RI2oFRz3Ifg47IHX45Cu7FpmOHXiFPXcG70Zpet+FJl9H3YhXq0SNCckA
 7PILJjHzhbzNwhllIxAi/8tf4l7THlDC011c3gVSo/dRI0bmWpA6tuCaazcVeFDPTKhh+9cS7MF
 e6q3cVhjns/0jAkXEdT5z2Nnqqha+3OgEjrkWBbY+ciaZ6KFHy21MMZDNs+Zdkkikg==
X-Google-Smtp-Source: AGHT+IEL1K5R0IcINHBr0zb2BRbQHVM2USFUh6d/IgJXLBOhnl9RINyxoOfmha3TON6/AsmxZrODgg==
X-Received: by 2002:a17:902:dacd:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-22593df9927mr59205995ad.26.1741711700481; 
 Tue, 11 Mar 2025 09:48:20 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:20 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 13/16] efi_selftest: Add selftest for counting EFI netdevices
Date: Tue, 11 Mar 2025 13:47:55 -0300
Message-ID: <20250311164758.421900-14-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311164758.421900-1-adriano.cordova@canonical.com>
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_selftest/Makefile                  |  2 +-
 lib/efi_selftest/efi_selftest_net_device.c | 65 ++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 lib/efi_selftest/efi_selftest_net_device.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 17fbfad116f..f7e8f02cb20 100644
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
index 00000000000..51963eb328c
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
2.48.1

