Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAE9C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 03:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C22382F14;
	Tue,  1 Jul 2025 05:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rg+39752";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CCEF8006D; Tue,  1 Jul 2025 05:49:51 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA4482EC6
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 05:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so1545505f8f.3
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751341781; x=1751946581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+UPL2hOcDBhjm+/r1az9Tp3x/yjMi4R1hn/zjSJRk8=;
 b=Rg+39752EoP4OAWFddF1rY/Doz60LY1/j1K83uiqBlfiXxhCq4RQkSxy7xXgRl8yVU
 ZwvAZvdJno8sGdzb8iOYhfFX15EGS13VdU3zcvh73lthD9Ie6TnnUnmPsoZ7cooBrO3t
 RjEUkbuOVfWmo/36vDmejKFGVCB51MRijwEOW4GS//rVIZ/C4Xr17FMT8/buXGaaa5Jx
 1+TMIoUtPsK55kDQ+eYa+4POYlnffT+qBXbXCjmTXB7NLA4UUwCo3ussHR2MW2GSjcWX
 r4eG2Yq1MAEJIaDd2g9PCO9FULbHPHq7zi+dK9XmpyWi49VHyw+R/EFzmfh3MthGpZr8
 OVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751341781; x=1751946581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7+UPL2hOcDBhjm+/r1az9Tp3x/yjMi4R1hn/zjSJRk8=;
 b=FxUddwInp3Ig0QElmJKYBKLLFIr3g8Xm8pQIuvJVo4NLccUACK80NRhutOEeVLEwEQ
 0xU+k6ZbaRlQfw/8wZhPLU9WuqIBIRO2XDlj0a4b0yyjMV95HvNy5Q9xyh/dk/Vnjlvl
 95uVps7A2fnMsNmNgEMmPlOkdMg7mJfDNWMTOF+NPhbldvrU7HZgZ13AUguuppuvQMs7
 USQobOxjl/GL02SajueQ58Whu4uPYHCn5/rChbi4WbCu4Q+XF386fDNdICaO4ZfrmYVI
 BAZOwRm9cmCKtV1gX+kyxZYLsuCMD6+Kykj/0h2ZIMGrigGxdZjBIwPmGVaLFrBKLBcH
 Hzeg==
X-Gm-Message-State: AOJu0YzbmbK7Nb09O/l0cwYSXUXWskNHo00tM8vEwIXubC9CUMMYvkA1
 TczQ05t6v0YSsXhII9FMWUPGHAJXYbBwCLpi3TF85LPXq07imLKPy7R+CxtbkB4r
X-Gm-Gg: ASbGncuaxb6bA/+W2932znluRX8bb6uzMcSP31OJoI0cGKjTIHjtnVGJkRs4ZQgKCwA
 lM8ZudZDIZdbQSjxkggpjimA3AUNuVfx4x1CsdOKlgkFAxi+au0FaufoVY2sLolaEnH9ZQNGraw
 Zp35TRFwCsrBt7XIDbvEMinXSkcjmeIx5Ors7n+2TWBN0hCfbFWlr6DSoGpxbF5r8zbR2Mp8XaK
 pL8kETnHf8aYn6IxA4L6xmFJrhDgpZKTmewYsOsS1Xh8NmUE7hMVthtiDwhsho4YUQr2aUYIJZe
 5jWAZUvlt1z0wrG5Ha6AwkOjBge5SGooj8vNmeAwPOlShg8B3HxXvz11kdjXgg==
X-Google-Smtp-Source: AGHT+IF7DmqfhyPwjKX25qSXQ39M5WwsxijWv9tz5NPHrBNRr1UbOfEIf9B5TadlIPdWI7WN4Rj7dQ==
X-Received: by 2002:a05:6000:4404:b0:3a4:f66a:9d31 with SMTP id
 ffacd0b85a97d-3a8fdb2a034mr9348637f8f.16.1751341780797; 
 Mon, 30 Jun 2025 20:49:40 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453b35349f0sm5990575e9.1.2025.06.30.20.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 20:49:40 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v7 5/6] efi: selftest: add selftest for EFI_DEBUG_SUPPORT
Date: Tue,  1 Jul 2025 04:49:25 +0100
Message-Id: <20250701034926.83536-6-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701034926.83536-1-paulliu@debian.org>
References: <20250701034926.83536-1-paulliu@debian.org>
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

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

Add selftest to check the installed configuration table that has
the correct GUID.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
V7: add selftest for EFI_DEBUG_SUPPORT
---
 lib/efi_selftest/Makefile                     |  2 +
 lib/efi_selftest/efi_selftest_debug_support.c | 58 +++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 lib/efi_selftest/efi_selftest_debug_support.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index d78bf7d6191..842433f68aa 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -78,6 +78,8 @@ endif
 
 obj-$(CONFIG_EFI_ESRT) += efi_selftest_esrt.o
 
+obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_selftest_debug_support.o
+
 targets += \
 efi_miniapp_file_image_exception.h \
 efi_miniapp_file_image_exit.h \
diff --git a/lib/efi_selftest/efi_selftest_debug_support.c b/lib/efi_selftest/efi_selftest_debug_support.c
new file mode 100644
index 00000000000..9cfa44c05a2
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_debug_support.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * efi_selftest_debug_support
+ *
+ * Copyright (c) 2025 Ying-Chun Liu, Linaro Ltd. <paul.liu@linaro.org>
+ *
+ * Test the EFI_DEBUG_SUPPORT
+ */
+
+#include <efi_loader.h>
+#include <efi_selftest.h>
+
+static const struct efi_system_table *local_systable;
+
+/**
+ * efi_st_debug_support_setup() - setup test
+ *
+ * @handle:	handle of the loaded image
+ * @systable:	system table
+ * Return:	status code
+ */
+static int efi_st_debug_support_setup(const efi_handle_t img_handle,
+				      const struct efi_system_table *systable)
+{
+	local_systable = systable;
+
+	return EFI_ST_SUCCESS;
+}
+
+/**
+ * efi_st_debug_support_execute() - execute test
+ *
+ * Test EFI_DEBUG_SUPPORT tables.
+ *
+ * Return:	status code
+ */
+static int efi_st_debug_support_execute(void)
+{
+	struct efi_debug_image_info_table_header *efi_st_debug_info_table_header = NULL;
+	efi_guid_t efi_debug_image_info_table_guid = EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
+
+	/* find EFI_DEBUG_IMAGE_INFO_TABLE */
+	for (int idx = 0; idx < local_systable->nr_tables; idx++)
+		if (!guidcmp(&efi_debug_image_info_table_guid, &local_systable->tables[idx].guid))
+			efi_st_debug_info_table_header = local_systable->tables[idx].table;
+
+	if (!efi_st_debug_info_table_header)
+		return EFI_ST_FAILURE;
+
+	return EFI_ST_SUCCESS;
+}
+
+EFI_UNIT_TEST(debug_support) = {
+	.name = "debug_support",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.execute = efi_st_debug_support_execute,
+	.setup = efi_st_debug_support_setup,
+};
-- 
2.39.5

