Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E395DC54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03A4E8328D;
	Fri, 23 May 2025 15:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QYZiwvs2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 170DA83281; Fri, 23 May 2025 15:07:53 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E6183108
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a36c2d3104so3542177f8f.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748005670; x=1748610470; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEfL/AlAO4t9USxHsT5fioVplbTDMTE6GWEiHvdDMgQ=;
 b=QYZiwvs2AyTH039wP7o4243VV83qyagrEcXgrOsbhkdrEH9jT8OZUTBr4fSISMW27a
 swq+xJN2jPVOEV/X9uVz+QVjbqybxsx5WvICoUSMe25arTdqeo+NtzxBN35yo7FcMO+i
 q0bQqIWXKbHVFUTxxDUTiR2HRY4GDJQjko6rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005670; x=1748610470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEfL/AlAO4t9USxHsT5fioVplbTDMTE6GWEiHvdDMgQ=;
 b=gQNe+NHo7ntv8UEasmH3Ii2TrP3OO81IrWEB1zG6aIqOKR0Tuo2mrvL0g7v5g27zJX
 DsTa/T5pdpRDyT6noq5m/UPi7TSS1RBe+ybhZQUMxpGIQ3+HTnG5bqlud7vAC/oynCuE
 sztB85DcCW+S1FEzxTDvKhKRSXam7avSQM6PtuzDwWY2E3cXJtNf/FAdxIJMRbln6Mev
 mS6QRhBk3a+EgPyPz7MqcDbzex9SHgbdb7+usFEk6y0K7IPJCf5KNEB9FOk+ebKcV+uC
 YeiqU1MnBXqplIJ6DbOVYy76v3UdwtC6F/2xdctasBDrApxbJxl2Ac3i1SFpUbjwX20k
 w/uA==
X-Gm-Message-State: AOJu0YyR1YZvHzjTA3YUpTzVapGzMF3ETjQ0B7DjvaseXlg5m3aKp0Od
 4F7EsxbsHjVAfvdrfkxT2RQWesC/QqjB1kvRBYaHbN02aO8StIHjPvKnBGSQzWWfE0+FGwdP1u5
 gZNKdCCV2
X-Gm-Gg: ASbGnctriKraValc4Z2DckdnoQTytxSiMGH/kuvH+q7mEn9xME9Atpec5WwWMfpg3v0
 VWACe2W2WBCaZZByBvRVtr2hFRP5PnLK+hwtePPdIRRCQn0JUMSGhg0sr1iJzBUfptQ7J776HOI
 0RMOJV+g6ysavROGF4yHtVkYQj7KBgjLrixUdciEtE1vQvbsDIjZFwD9Q+DfvWPzx0+/YifKJUs
 qYQPVG8QZicJNsy8lQb8LPKVbia/HhoaqvWU8dmkbcBqyOn1WjYCEkd4worKj1ZXrVHO9p8WUkA
 /BVnFYxWwZL7VWJTghQfkfLVJw93VflYkEmxFcPgbf3MEsMVDfUhlhl8lFWpKhvox54nsJA=
X-Google-Smtp-Source: AGHT+IHci54mB4/UE0YPcXgrXkgPhLPIc33CaHlAyx+slZcAFpByvdVLdoofXaGznG/HHDXlU+R0tA==
X-Received: by 2002:a05:6000:4308:b0:3a4:741d:35c1 with SMTP id
 ffacd0b85a97d-3a4742c7bd9mr9947245f8f.36.1748005669943; 
 Fri, 23 May 2025 06:07:49 -0700 (PDT)
Received: from chromium.org (82-132-216-100.dab.02.net. [82.132.216.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm12109241f8f.100.2025.05.23.06.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 06:07:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/10] efi: Create a new CONFIG_EFI
Date: Fri, 23 May 2025 14:06:41 +0100
Message-ID: <20250523130651.1329593-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
References: <20250523130651.1329593-1-sjg@chromium.org>
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

Create a Kconfig which indicates that EFI functionality is in use,
either as a client (EFI app / stub) or provider (EFI loader). This will
make it easier to share code between these two parts of U-Boot

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/uefi/u-boot_on_efi.rst |  6 +++---
 lib/efi/Kconfig                    | 12 ++++++++++++
 lib/efi_client/Kconfig             |  1 +
 lib/efi_loader/Kconfig             |  3 +++
 4 files changed, 19 insertions(+), 3 deletions(-)
 create mode 100644 lib/efi/Kconfig

diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index a687eb3d691..7a1713f7588 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -46,9 +46,9 @@ First choose a board that has EFI support and obtain an EFI implementation
 for that board. It will be either 32-bit or 64-bit. Alternatively, you can
 opt for using QEMU [1] and the OVMF [2], as detailed below.
 
-To build U-Boot as an EFI application, enable CONFIG_EFI_CLIENT and CONFIG_EFI_APP.
-The efi-x86_app32 and efi-x86_app64 configs are set up for this. Just build
-U-Boot as normal, e.g.::
+To build U-Boot as an EFI application, enable CONFIG_EFI_CLIENT and
+CONFIG_EFI_APP. The efi-x86_app32 and efi-x86_app64 configs are set up for
+this. Just build U-Boot as normal, e.g.::
 
    make efi-x86_app32_defconfig
    make
diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
new file mode 100644
index 00000000000..fc6d5b6d6c2
--- /dev/null
+++ b/lib/efi/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright 2025 Simon Glass <sjg@chromium.org>
+#
+
+config EFI
+	bool
+	help
+	  Indicates that EFI functionality is enabled, either via EFI_CLIENT or
+	  EFI_LOADER
+
+	  This is used to provide libraries shared by both.
diff --git a/lib/efi_client/Kconfig b/lib/efi_client/Kconfig
index b6446179b67..fec5b7e004c 100644
--- a/lib/efi_client/Kconfig
+++ b/lib/efi_client/Kconfig
@@ -5,6 +5,7 @@ config EFI_CLIENT
 	bool "Support running U-Boot from EFI"
 	depends on X86 || ARM
 	imply X86_TSC_READ_BASE
+	select EFI
 	help
 	  U-Boot can be started from EFI on certain platforms. This allows
 	  EFI to perform most of the system init and then jump to U-Boot for
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 9c67cf55283..f5abcd51cae 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -16,6 +16,7 @@ config EFI_LOADER
 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
 	depends on !EFI_APP
 	default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
+	select EFI
 	select CHARSET
 	# We need to send DM events, dynamically, in the EFI block driver
 	select DM_EVENT
@@ -610,4 +611,6 @@ endif
 
 source "lib/efi_client/Kconfig"
 
+source "lib/efi/Kconfig"
+
 endmenu
-- 
2.43.0

