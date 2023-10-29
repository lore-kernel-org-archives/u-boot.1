Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47DFC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 08:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73EFC87286;
	Sun, 29 Oct 2023 09:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FQGUgXTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988528767E; Sun, 29 Oct 2023 09:46:02 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E0DD8767E
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 09:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 988B242D45; 
 Sun, 29 Oct 2023 08:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698569158;
 bh=TSlb65B+0g4KsQlbO6Ta8FzpsZkfXh4kvpu8c43Z1Wo=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=FQGUgXTUDDn/mWhf9IiZSZ8w9DXRL1S2BW2+Cwat4P07omuuJb+iz1zA5xfPG7oom
 LEYGw1IKxuFfP8HgR+ojmvQtkbm70khss1pS0Whgl4mVf7M8Y/u668oSuIJV9I9Q46
 W6/eFKbKtFZ5A3lq6YiZ4XvOLvB1iZS449koBPKE0aB5E6JZPYNQWdYqqmM6/11yUb
 coJUa4NuWizRAhk/gwHwc2aoA54K2uvmXina8hlwVWZiVAsG0os4jO5RJU8kYBBhi4
 kq+JwxFZH+CbduuzOiEU4fAYXB2iPerotWRJTp7pr+YbSbGY6kwHAVjx4Q6bljMoid
 LNncugRqoZ2kg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Anup Patel <apatel@ventanamicro.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC v2 1/2] riscv: allow resume after exception
Date: Sun, 29 Oct 2023 09:45:32 +0100
Message-Id: <20231029084533.44607-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231029084533.44607-1-heinrich.schuchardt@canonical.com>
References: <20231029084533.44607-1-heinrich.schuchardt@canonical.com>
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
v2:
	new patch
---
 arch/riscv/lib/interrupts.c | 13 +++++++++++++
 include/interrupt.h         | 22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)
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
diff --git a/include/interrupt.h b/include/interrupt.h
new file mode 100644
index 0000000000..1baa60bcf2
--- /dev/null
+++ b/include/interrupt.h
@@ -0,0 +1,22 @@
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
+ * set_resume() - set longjmp buffer for resuming after interrupt
+ *
+ * When resuming the exception code will be returned in @data->code.
+ *
+ * @data:	pointer to structure with longjmp address
+ */
+void set_resume(struct resume_data *data);
-- 
2.40.1

