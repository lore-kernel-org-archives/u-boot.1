Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89929C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 12:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E11687C9D;
	Tue, 31 Oct 2023 13:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cT2SPv0B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 382C287C76; Tue, 31 Oct 2023 13:56:13 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59AAF87C94
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 13:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [159.148.28.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DEABD42790; 
 Tue, 31 Oct 2023 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698756965;
 bh=T3QZ9S0V89vfZ/vdOrO6JpAXN/7cGcJpIbgZF4HK7Yc=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=cT2SPv0BRVA9aOfHBKOu9MFAlapHbsCs1o00r0RVaUplgzBwz7fh42eN2oSnNyz7b
 /7tuu0ZaXWcCsw38iI7QdZr3CmMb0EC7IGK7Ltwmw295x4f4V+2t2kDIVoHCwDZE1t
 J9t1vVDziG5hDNTFZ75bR2SMOEHrTrrsgE4Thj8+Z13xcIvz0dACOso3UysJilm2Qj
 VWSNc4UD2/l9T9waZEeqJ4EhgJZI2GawILOiJUWd30Qtu+dMnLFB4BWRy+wmgpeKih
 v9EUMxQMSG+9HH5tJtWG7j8qA2p6sTJF8PpE92RNjqDYGSpRG3xGLyabBExOEJcOPV
 xfi8UUZZTaPBA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/2] riscv: allow resume after exception
Date: Tue, 31 Oct 2023 14:55:51 +0200
Message-Id: <20231031125552.26698-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
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

If CSRs like seed are readable by S-mode, may not be determinable by
S-mode. For safe driver probing allow to resume via a longjmp after an
exception.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	Add API documentation
v2:
	New patch
---
 arch/riscv/lib/interrupts.c | 13 +++++++++++
 doc/api/index.rst           |  1 +
 include/interrupt.h         | 45 +++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 include/interrupt.h

diff --git a/arch/riscv/lib/interrupts.c b/arch/riscv/lib/interrupts.c
index 02dbcfd423..a26ccc721f 100644
--- a/arch/riscv/lib/interrupts.c
+++ b/arch/riscv/lib/interrupts.c
@@ -12,6 +12,7 @@
 #include <linux/compat.h>
 #include <efi_loader.h>
 #include <hang.h>
+#include <interrupt.h>
 #include <irq_func.h>
 #include <asm/global_data.h>
 #include <asm/ptrace.h>
@@ -21,6 +22,13 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static struct resume_data *resume;
+
+void set_resume(struct resume_data *data)
+{
+	resume = data;
+}
+
 static void show_efi_loaded_images(uintptr_t epc)
 {
 	efi_print_image_infos((void *)epc);
@@ -105,6 +113,11 @@ static void _exit_trap(ulong code, ulong epc, ulong tval, struct pt_regs *regs)
 		"Store/AMO page fault",
 	};
 
+	if (resume) {
+		resume->code = code;
+		longjmp(resume->jump, 1);
+	}
+
 	if (code < ARRAY_SIZE(exception_code))
 		printf("Unhandled exception: %s\n", exception_code[code]);
 	else
diff --git a/doc/api/index.rst b/doc/api/index.rst
index 2f0218c47a..51b2013af3 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -12,6 +12,7 @@ U-Boot API documentation
    efi
    event
    getopt
+   interrupt
    linker_lists
    lmb
    logging
diff --git a/include/interrupt.h b/include/interrupt.h
new file mode 100644
index 0000000000..46ef2e196d
--- /dev/null
+++ b/include/interrupt.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <asm/setjmp.h>
+
+/**
+ * struct resume_data - data for resume after interrupt
+ */
+struct resume_data {
+	/** @jump: longjmp buffer */
+	jmp_buf jump;
+	/** @code: exception code */
+	ulong code;
+};
+
+/**
+ * set_resume() - set longjmp buffer for resuming after exception
+ *
+ * By calling this function it is possible to use a long jump to catch an
+ * exception. The caller sets the long jump buffer with set_resume() and then
+ * executes setjmp(). If an exception occurs, the code will return to the
+ * setjmp caller(). The exception code will be returned in @data->code.
+ *
+ * After the critical operation call set_resume(NULL) so that an exception in
+ * another part of the code will not accidently invoke the long jump.
+ *
+ * .. code-block:: c
+ *
+ *     // This example shows how to use set_resume().
+ *
+ *     struct resume_data resume;
+ *     int ret;
+ *
+ *     set_resume(&resume);
+ *     ret = setjmp(resume.jump);
+ *     if (ret) {
+ *          printf("An exception %ld occurred\n", resume.code);
+ *     } else {
+ *          // Do what might raise an exception here.
+ *     }
+ *     set_resume(NULL);
+ *
+ * @data:	pointer to structure with longjmp address
+ * Return:	0 before an exception, 1 after an exception occurred
+ */
+void set_resume(struct resume_data *data);
-- 
2.40.1

