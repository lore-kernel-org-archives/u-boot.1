Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37661C982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0321181124;
	Thu, 17 Sep 2026 17:19:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IyCSJiGJZTuQ; Thu, 17 Sep 2026 17:19:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0DFF88109C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665588;
	b=NH1MKxNmtJACowhkE2l0gpitxCIKPHz2MQCPTZBBax7O4uaF+R61cloKczX/X7Eiekmt
	 8ZW4YqcPVSnPmiZvT/b0Hzy/OXHavm7o2c5tPhw9+qpPcWEazUl+cDxoSxKyYtXmLlMKx
	 fOyBvbYQdPHVTgDsaYaONz9hF9cgBn7+h8Mq78l6Cyt15duQlNp7hxyAK8Vcx275BnFZZ
	 XZvMdXj1hhsI085GfiUSAqy5UDVzGsPMnR5aKBbGKrofMnlBtKNbcgwsCMVPItZLe48OB
	 epy02xwQA/CWtjuv+fIhiWmH8hN/HJSD5UvLqb+pB0agBt6sIjLb/4+AfW22sZm0snA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YOXwiUret76l6/Au5k986pGtguaoJWlh5sDSGJBdYac=;
	b=fdt/nk9LEQT7oLR5lw5HhhuRID0B7o3lcOqsnRobUE2lEavHYOVbFCaeySp4HSadtF//
	 nInTK4PAaURLUoN1L7gIMfzQ/wG1nuM1uSgi5X6A+vtIczVl5b4C74dG1IMpve5CxVEJ/
	 J3blg8LzGF0chmC7KPU0RYgFCV6bYvuiNNDCtT0fwwx9aqN4oRHkmdBX/3P9eJTNKLFKO
	 mLK9E6LsZMLVd/zEjSzQZ+mJxhP5uSjFo2yylLs681BHHyD2ntIxTlxergeTYAkO91Z9I
	 whPvTsoixgIYVD+0FF+PeOPMfiIGTttZTqReWnpaGfIbmu5HWTqXGQGlKRsWs4bdbMQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o+MYeo8j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665588;
	bh=YOXwiUret76l6/Au5k986pGtguaoJWlh5sDSGJBdYac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HUszxCFFwEmq9B39r/NifZnlh8DPLZn7g8vBhKNnvxEDACGI8VLB43ILGETTtADPc
	 R4E5ceSkTObShmfa8LD2XBIBvjUdaXJBwyLkXFRp56+KVcDfdYAvtCXmYtZpNryz9T
	 W13ftisjAXlVGDfIGthFCjNVeJ5Cb+F6ePUw+OLi+Cx99IskzJpCJlWVZmC0UijYME
	 Z1nmgs/ak+U7zIP7WtqSisV39scKzqg5dk1RU9xkSPVWHq4fPTEKPxMbV1BRVJgH7Y
	 efJ8UIt1Z3JYpO03WaXJnK3+M43XNnVoOg4sGWqiBXMa/PrrJd4yPL4wRtZVwwLkkn
	 A+09tb4FQ6XDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DFF88109C;
	Thu, 17 Sep 2026 17:19:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DC4E422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D68C8109C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QiMJkjI6skob for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DE51E8108D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665532;
 b=b0W8I859plGwsxCpFCyV94VY/vls5YgqVtdjFM6RmuPEjJGOhTNzZPPHY6T1h+BqbU4L
 p15qhkT4Oms4AtHJJpmagdUqA3nYjc4HWUymIL8klL+xVkbEgy5EZ4V8q0jfnEPdmFTbG
 X+K76ePI2cU9ixKzWAGM6TCAsVDI1WxsvQ1E8ZAzRtFfHTY/l8IJgejhVIICwHcF78ExX
 Xl60/cW9nm49F0AoFzyp1GQ51FSjf5sd7VGlgpGZFBhivUXcNPDIusivic65I2NMFZej0
 stf6VaxoEbI2V818YK0axAMYLCkwCi30vaAavMC5a358+q1Nt48FZI/dFUDZndWCLlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665532;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=YOXwiUret76l6/Au5k986pGtguaoJWlh5sDSGJBdYac=;
 b=Ao9PXkFRgE6li42fhpTKblVr0WEh6rHN3O3NyZxkGD1B/MShuxyUufbQs4kTQQ8oH6x1
 TOX1EBeXf9GrKQXIs4+lKCWv1TqTSaWoyySjDNiYs8LjfEKCttNGpz0W9rHjOjhgUK6Um
 24Q19MeeF6i0Ls4/pwumuYX/eCeB/hMxz1dRVb/Fme1gQ4vGpaYKKM3SVrZ9s66GTzcAk
 GIRsIjqSwfMTbsT6Mcu58WkjzJT2r3TdGLeuuB3A/+yG0daWEFfYdnD60TDvJEKae1ZRi
 5BBc4twnbQxzqfuX/rEDpqT98Ly7pLtmDuhMJfDPsoZ/3hsLythZA3O44sAt6OZgbiA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=o+MYeo8j; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=o+MYeo8j
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE51E8108D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78E04143D;
 Thu, 17 Sep 2026 10:18:47 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23F6D3F7B4;
 Thu, 17 Sep 2026 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665531; bh=5n7eQOBAapz+5i2nNs6dDfiddu8cdEaSormvrUSRqWI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o+MYeo8jJkBYR1hc3+9vrnq8Ply+jHN0dVjAVPNwzYTX5g/JlRig9CY7pnKuonOcZ
 mqfNdr4JdOktjvx95VQROH96nFiTEH+mQgiw10v/QYnLPZ+r7g7zhheZRSBzDs3EKZ
 jwSrGFhMdTH5ziAlHH8h53nNujcqlIIO9k02GoQY=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Alex Chapman <alex.chapman@arm.com>, David Hu <david.hu2@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v6 09/24] fwu_arm_psa: Initialize the update agent
Date: Thu, 17 Sep 2026 18:17:55 +0100
Message-ID: <20260917171810.4122899-10-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Add the initializations required for the update agent

The aim is adding support for the Trusted Services (aka TS)
Firmware Update API. This API allows the interaction with
the FWU services provided by Secure world.
At U-Boot level, we provide the PSA FWU ABI built on top of the
FF-A bus to invoke the FWU services in Secure world.

The design is based on the Platform Security Firmware Update
for the A-profile Arm Architecture specification [1].

In our design, the Secure world is the update agent. U-Boot
is the update client.

The update agent is initialized as follows:

- Trusted Services FWU SP discovery
- Setting up the shared buffer between the Normal world (U-Boot) and
  Secure world (Trusted Services)
- Notifying FWU SP about the shared buffer

[1]: DEN0118, 1.0 A:
    https://developer.arm.com/documentation/den0118/latest/

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
Signed-off-by: Alex Chapman <alex.chapman@arm.com>
Signed-off-by: David Hu <david.hu2@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 MAINTAINERS                  |   8 ++
 include/fwu_arm_psa.h        |  54 ++++++++
 lib/efi_loader/Kconfig       |  20 +++
 lib/efi_loader/Makefile      |   1 +
 lib/efi_loader/fwu_arm_psa.c | 243 +++++++++++++++++++++++++++++++++++
 5 files changed, 326 insertions(+)
 create mode 100644 include/fwu_arm_psa.h
 create mode 100644 lib/efi_loader/fwu_arm_psa.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e5b2a2e373c..bde8158fa73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1192,6 +1192,14 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git
 F:	drivers/watchdog/sp805_wdt.c
 F:	drivers/watchdog/sbsa_gwdt.c
 
+FWU ARM PSA
+M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+M:	Davidson kumaresan <davidson.kumaresan@arm.com>
+M:	Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
+S:	Maintained
+F:	include/fwu_arm_psa.h
+F:	lib/fwu_updates/fwu_arm_psa.c
+
 FWU Multi Bank Update
 M:	Sughosh Ganu <sughosh.ganu@arm.com>
 M:	Kory Maincent <kory.maincent@bootlin.com>
diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
new file mode 100644
index 00000000000..a5881a0d400
--- /dev/null
+++ b/include/fwu_arm_psa.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Authors:
+ *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+ *   Davidson kumaresan <davidson.kumaresan@arm.com>
+ *   Alex Chapman <alex.chapman@arm.com>
+ */
+
+#ifndef __FWU_ARM_PSA_H
+#define __FWU_ARM_PSA_H
+
+#include <linux/bitfield.h>
+#include <u-boot/uuid.h>
+
+/* 4 MB buffer shared with secure world */
+#define FWU_BUFFER_SIZE			(CONFIG_FWU_BUFFER_PAGES * EFI_PAGE_SIZE)
+
+/* TS UUID string for detecting all SPs  (in big-endian format) */
+#define ALL_TS_SP_UUID			"d776cdbd-5e82-5147-3b96-ac4349f8d486"
+/* In little-endian equivalent to: bdcd76d7-825e-4751-963b-86d4f84943ac */
+
+/* TS FWU service UUID string (in big-endian format) */
+#define TS_FWU_SERVICE_UUID		"38a82368-061b-0e47-7497-fd53fb8bce0c"
+/* In little-endian equivalent to:  6823a838-1b06-470e-9774-0cce8bfb53fd */
+
+#define TS_RPC_MEM_RETRIEVE		(0xff0001)
+#define TS_RPC_SERVICE_INFO_GET		(0xff0003)
+#define RPC_SUCCESS			(0)
+
+#define SVC_IFACE_ID_GET_MASK		GENMASK(7, 0)
+#define GET_SVC_IFACE_ID(x)		\
+			 ((u8)(FIELD_GET(SVC_IFACE_ID_GET_MASK, (x))))
+
+#define HANDLE_MSW_MASK			GENMASK(63, 32)
+#define HANDLE_LSW_MASK			GENMASK(31, 0)
+#define GET_FWU_BUF_MSW(x)		\
+				((u32)(FIELD_GET(HANDLE_MSW_MASK, (x))))
+#define GET_FWU_BUF_LSW(x)		\
+				((u32)(FIELD_GET(HANDLE_LSW_MASK, (x))))
+
+/**
+ * fwu_agent_init() - Setup the FWU agent
+ * Perform the initializations required to communicate
+ * and use the FWU agent in secure world.
+ * The frontend of the FWU agent is the Trusted Services (aka TS)
+ * FWU SP (aka Secure Partition).
+ *
+ * Return: 0 on success. Otherwise, failure
+ */
+int fwu_agent_init(void);
+
+#endif
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 4cb13ae7c8a..998f2fb547e 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -367,6 +367,26 @@ config EFI_CAPSULE_FIRMWARE_RAW
 	  Select this option if you want to enable firmware management protocol
 	  driver for raw image
 
+config FWU_ARM_PSA
+	bool "FMP driver for Arm PSA FWU specification"
+	depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT && \
+		EFI_CAPSULE_FIRMWARE_RAW && \
+		ARM_FFA_TRANSPORT && \
+		(ARM64 || SANDBOX) && \
+		!FWU_MULTI_BANK_UPDATE
+	select EFI_CAPSULE_FIRMWARE
+	help
+	  Select this option if you want to enable firmware management protocol
+	  driver that supports the Arm PSA firmware update specification as
+	  mentioned in https://developer.arm.com/documentation/den0118/a/
+
+config FWU_BUFFER_PAGES
+	int "Number of 4KB pages in the FWU shared buffer"
+	depends on FWU_ARM_PSA
+	default 1024
+	help
+	  This defines the size of the FWU shared buffer used for communication.
+
 config EFI_CAPSULE_AUTHENTICATE
 	bool "Update Capsule authentication"
 	depends on EFI_CAPSULE_FIRMWARE
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index d73ad43951b..34af842db7a 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) += efi_load_initrd.o
 obj-$(CONFIG_EFI_SIGNATURE_SUPPORT) += efi_signature.o
 obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
 obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_debug_support.o
+obj-$(CONFIG_FWU_ARM_PSA) += fwu_arm_psa.o
 
 EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
 $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
diff --git a/lib/efi_loader/fwu_arm_psa.c b/lib/efi_loader/fwu_arm_psa.c
new file mode 100644
index 00000000000..9355101a3a8
--- /dev/null
+++ b/lib/efi_loader/fwu_arm_psa.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Authors:
+ *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+ *   Davidson kumaresan <davidson.kumaresan@arm.com>
+ *   Alex Chapman <alex.chapman@arm.com>
+ */
+#include <arm_ffa.h>
+#include <dm.h>
+#include <fwu_arm_psa.h>
+#include <efi_loader.h>
+#include <log.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <linux/errno.h>
+
+static void *g_fwu_buf;
+static u64 g_fwu_buf_handle;
+static u16 g_fwu_sp_id;
+static struct udevice *g_dev;
+static u16 g_svc_interface_id;
+static bool g_fwu_initialized;
+
+/**
+ * fwu_discover_ts_sp_id() - Query the FWU partition ID
+ *
+ * Description: Use the FF-A driver to get the FWU partition ID.
+ * If multiple partitions are found, use the first one.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_discover_ts_sp_id(void)
+{
+	u32 count = 0;
+	int ret;
+	u32 i;
+	struct ffa_partition_desc *descs = NULL;
+	struct ffa_send_direct_data msg;
+	struct ffa_partition_uuid fwu_service_uuid = {0};
+
+	/* Ask the driver to fill the buffer with the SPs info */
+
+	ret = ffa_partition_info_get(g_dev, ALL_TS_SP_UUID, &count, &descs);
+	if (ret) {
+		log_err("FWU: Failure in querying partitions (err: %d)\n", ret);
+		return ret;
+	}
+
+	if (!count) {
+		log_err("FWU: No Trusted Service partition found\n");
+		return -ENODATA;
+	}
+
+	if (!descs) {
+		log_err("FWU: No partitions descriptors filled\n");
+		return -EINVAL;
+	}
+
+	if (uuid_str_to_le_bin(TS_FWU_SERVICE_UUID,
+			       (unsigned char *)&fwu_service_uuid)) {
+		log_err("FWU: invalid FWU SP  UUID\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < count ; i++) {
+		log_debug("FWU: Enquiring service from SP 0x%x\n",
+			  descs[i].info.id);
+
+		msg.data0 = TS_RPC_SERVICE_INFO_GET;
+		msg.data1 = fwu_service_uuid.a1;
+		msg.data2 = fwu_service_uuid.a2;
+		msg.data3 = fwu_service_uuid.a3;
+		msg.data4 = fwu_service_uuid.a4;
+
+		ret = ffa_sync_send_receive(g_dev, descs[i].info.id, &msg, 0);
+		if (ret) {
+			log_err("FWU: FF-A error for SERVICE_INFO_GET (err: %d)\n",
+				ret);
+			return ret;
+		}
+
+		if (msg.data0 != TS_RPC_SERVICE_INFO_GET) {
+			log_err("FWU: Wrong SERVICE_INFO_GET return: (%lx)\n",
+				msg.data0);
+			continue;
+		}
+
+		if (msg.data1 == RPC_SUCCESS) {
+			g_svc_interface_id = GET_SVC_IFACE_ID(msg.data2);
+			g_fwu_sp_id = descs[i].info.id;
+			log_debug("FWU: Service interface ID 0x%x found\n",
+				  g_svc_interface_id);
+			return 0;
+		}
+
+		log_debug("FWU: service not found\n");
+	}
+
+	log_err("FWU: No SP provides the service\n");
+
+	return -ENOENT;
+}
+
+/**
+ * fwu_shared_buf_reclaim() - Reclaim the shared communication buffer
+ *
+ * Description: In case of errors, this function can be called to retrieve
+ * the FWU shared buffer.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_shared_buf_reclaim(void)
+{
+	int reclaim_ret;
+
+	reclaim_ret = ffa_memory_reclaim(g_dev, g_fwu_buf_handle, 0);
+	if (reclaim_ret)
+		log_err("FWU: FF-A memory reclaim failure (err: %d)\n",
+			reclaim_ret);
+	else
+		log_debug("FWU: Shared buffer reclaimed\n");
+
+	free(g_fwu_buf);
+	g_fwu_buf = NULL;
+
+	return reclaim_ret;
+}
+
+/**
+ * fwu_shared_buf_init() - Setup the FWU shared communication buffer
+ *
+ * Description: The communication with the TS FWU SP is based on a buffer shared
+ * between U-Boot and TS FWU SP allocated in normal world and accessed
+ * by both sides. The buffer contains the data exchanged between both sides
+ * such as the payloads data.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_shared_buf_init(void)
+{
+	struct ffa_mem_ops_args args = {0};
+	struct ffa_mem_region_attributes attrs = {0};
+	struct ffa_send_direct_data msg;
+	int ret;
+
+	g_fwu_buf = memalign(EFI_PAGE_SIZE, FWU_BUFFER_SIZE);
+	if (!g_fwu_buf) {
+		log_err("FWU: Failure to allocate the shared buffer\n");
+		return -ENOMEM;
+	}
+
+	/* Setting up user arguments */
+	args.use_txbuf = true;
+	args.address = g_fwu_buf;
+	args.pg_cnt = CONFIG_FWU_BUFFER_PAGES;
+	args.nattrs = 1;
+	attrs.receiver = g_fwu_sp_id;
+	attrs.attrs = FFA_MEM_RW;
+	args.attrs = &attrs;
+
+	/* Registering the shared buffer with secure world (Trusted Services) */
+	ret = ffa_memory_share(g_dev, &args);
+	if (ret) {
+		free(g_fwu_buf);
+		g_fwu_buf = NULL;
+		log_err("FWU: Failure setting up the shared buffer (err: %d)\n",
+			ret);
+		return ret;
+	}
+
+	g_fwu_buf_handle = args.g_handle;
+
+	log_debug("FWU: shared buffer handle 0x%llx\n", g_fwu_buf_handle);
+
+	/* Inform the FWU SP know about the shared buffer */
+
+	msg.data0 = TS_RPC_MEM_RETRIEVE;
+	msg.data1 = GET_FWU_BUF_LSW(g_fwu_buf_handle);
+	msg.data2 = GET_FWU_BUF_MSW(g_fwu_buf_handle);
+
+	ret = ffa_sync_send_receive(g_dev, g_fwu_sp_id, &msg, 0);
+	if (ret) {
+		log_err("FWU: FF-A message error for MEM_RETRIEVE (err: %d)\n",
+			ret);
+		goto failure;
+	}
+
+	if (msg.data0 != TS_RPC_MEM_RETRIEVE) {
+		log_err("FWU: Unexpected MEM_RETRIEVE return: (%lx)\n",
+			msg.data0);
+		ret = -EINVAL;
+		goto failure;
+	}
+
+	if (msg.data1 != RPC_SUCCESS) {
+		log_err("FWU: MEM_RETRIEVE failed\n");
+		ret = -EOPNOTSUPP;
+		goto failure;
+	}
+
+	log_debug("FWU: MEM_RETRIEVE success for SP 0x%x\n", g_fwu_sp_id);
+
+	return 0;
+
+failure:
+	fwu_shared_buf_reclaim();
+	return ret;
+}
+
+/**
+ * fwu_agent_init() - Setup the FWU agent
+ *
+ * Description: Perform the initializations required to communicate
+ * and use the FWU agent in secure world.
+ * The frontend of the FWU agent is the Trusted Services (aka TS)
+ * FWU SP (aka Secure Partition).
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+int fwu_agent_init(void)
+{
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_FFA, &g_dev);
+	if (ret) {
+		log_err("FWU: Cannot find FF-A bus device, err (%d)\n", ret);
+		return ret;
+	}
+
+	ret = fwu_discover_ts_sp_id();
+	if (ret)
+		return ret;
+
+	ret = fwu_shared_buf_init();
+	if (ret)
+		return ret;
+
+	g_fwu_initialized = true;
+
+	return 0;
+}
-- 
2.43.0

