Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70DFC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 16:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 512F7875FC;
	Mon, 12 Feb 2024 17:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MFLb8LCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1824876A9; Mon, 12 Feb 2024 17:18:48 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEAB6875FA
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 17:18:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 411C93F125
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707754726;
 bh=YjyyRHwi5hOB7c0g1QCEBB2fOM+JqXX75cH1KX10yaA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=MFLb8LCzdYGX7YQ+gGqinFy0wy6AMVwXVp/kqJCVXGes+nnvBdU9KaZqrlyNP+89a
 fFd4JPtqr9w15btkVVMb/zJpGZM6gADYvF+q0mfFg3ifAV2cSV+cCVdEtWzmRArK5F
 A2NPSujbSc+v90p9u3i4Iyl6MOTmAg9awYD9dSvw8EdsP4meNNlJp8bkxODx0j9uRf
 1A1XKDx5MkSxfs+bDaOUWRZsSfWaGV70INh6tyEJbDYgUT8kBJLC2D+N9FxpipGgmZ
 sPGadpC/wrrKbj/tqrQRvbezdw2h95btPAFaZLZ+sTo3wqtkD4tpK6fVey1AqWfF30
 vl09Ik/1+g3lw==
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50e9e5c8f49so3627066e87.3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707754725; x=1708359525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YjyyRHwi5hOB7c0g1QCEBB2fOM+JqXX75cH1KX10yaA=;
 b=eA8p8e12yR23VzRRNa+Fhrx/YrKEqYDVYseehF/UG3HA8VihZGiRNDYJjbaBkQ5yYf
 ejZOFlqMTCXY85xp+Bhv0YaETMVdQeUX0oOQ8SOp1DUjTbCKfTP1Bc5z+aIcldJOynCT
 J2C+6NKejCXRQ95MsAQXwoMjMJkOSeJUZTookDkkSISg04LLOi1iJOtkFkk5k9oRVcvG
 mDIKMYN9tD22pBZ1tvaPpIhB6BSAyG6icXTSYlHUh+KS5Gxnil5eKTS0jb+zKcLX+WAr
 GFwluJhxJpEbJcj/Fd4B6959v10KFLjpZPYH6I27ygp33XwSdwuwzmFRF/HmGHEAxizd
 P1ZA==
X-Gm-Message-State: AOJu0YyDz+lwNyPcHKo9B8fpVyK6Z1T9R8bl2XUQu2gmuDhuzKXy+69q
 8HSyESX5318kLczgQypzQUMPVpMXh864tXy/OLUbXiBPjLcqnxjSn2SZ5C3hAxTMYPjJ2SBt3J+
 t4EgLGRDEU7peUot9He3igTdKD5uyYULI9zsxCDX6g/sVg23z2lUh/FXkSFCdXnyMDtI=
X-Received: by 2002:ac2:43d5:0:b0:511:4eda:2563 with SMTP id
 u21-20020ac243d5000000b005114eda2563mr4366098lfl.69.1707754725654; 
 Mon, 12 Feb 2024 08:18:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+MNSXRFqz7oBwCgHlF/lSPZc0w7hvB3k6p73OJtxul1CDNicyXiyNhyIq5oD+EAlaVIKDBQ==
X-Received: by 2002:ac2:43d5:0:b0:511:4eda:2563 with SMTP id
 u21-20020ac243d5000000b005114eda2563mr4366083lfl.69.1707754725287; 
 Mon, 12 Feb 2024 08:18:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVY9OrHunPF6df8cymBrzE0gGyqsr+bolADlMkI382CsxLA8IQ4yBgkqaxBIu2rFtr+OnHG+9DgnLfOgTj97WiQA3iQNAyO8W9bWEkL+/TQOYo=
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 r17-20020adfe691000000b0033aeb0afa8fsm7207003wrm.39.2024.02.12.08.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 08:18:44 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_driver: provide SBI based runtime system reset
Date: Mon, 12 Feb 2024 17:18:37 +0100
Message-ID: <20240212161837.1290585-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

On RISC-V systems system the Supervisory Binary Interface provides system
reset and poweroff. Use it at EFI runtime.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_driver/Makefile          |  1 +
 lib/efi_driver/efi_reset_riscv.c | 29 +++++++++++++++++++++++++++++
 lib/efi_loader/Kconfig           |  2 +-
 3 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 lib/efi_driver/efi_reset_riscv.c

diff --git a/lib/efi_driver/Makefile b/lib/efi_driver/Makefile
index f2b6c05cc24..0da20fe91d3 100644
--- a/lib/efi_driver/Makefile
+++ b/lib/efi_driver/Makefile
@@ -9,3 +9,4 @@ obj-y += efi_uclass.o
 ifeq ($(CONFIG_PARTITIONS),y)
 obj-y += efi_block_device.o
 endif
+obj-$(CONFIG_SYSRESET_SBI) += efi_reset_riscv.o
diff --git a/lib/efi_driver/efi_reset_riscv.c b/lib/efi_driver/efi_reset_riscv.c
new file mode 100644
index 00000000000..89b23522e95
--- /dev/null
+++ b/lib/efi_driver/efi_reset_riscv.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <efi_loader.h>
+#include <asm/sbi.h>
+
+void __efi_runtime EFIAPI efi_reset_system(enum efi_reset_type reset_type,
+					   efi_status_t reset_status,
+					   unsigned long data_size,
+					   void *reset_data)
+{
+	register unsigned long eid asm("a7") = SBI_EXT_SRST;
+	register unsigned long fid asm("a6") = SBI_EXT_SRST_RESET;
+	register unsigned long type asm("a0");
+	register unsigned long reason asm("a1") = SBI_SRST_RESET_REASON_NONE;
+
+	switch (reset_type) {
+	case EFI_RESET_WARM:
+		type = SBI_SRST_RESET_TYPE_WARM_REBOOT;
+		break;
+	case EFI_RESET_SHUTDOWN:
+		type = SBI_SRST_RESET_TYPE_SHUTDOWN;
+		break;
+	default:
+		type = SBI_SRST_RESET_TYPE_COLD_REBOOT;
+		break;
+	}
+	asm volatile ("ecall\n"
+		      : : "r" (eid), "r" (fid), "r" (type), "r" (reason));
+}
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index db5571de1d9..a7c3e05c13a 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -366,7 +366,7 @@ config EFI_HAVE_RUNTIME_RESET
 	bool
 	default y
 	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
-		   SANDBOX || SYSRESET_X86
+		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
 
 config EFI_GRUB_ARM32_WORKAROUND
 	bool "Workaround for GRUB on 32bit ARM"
-- 
2.43.0

