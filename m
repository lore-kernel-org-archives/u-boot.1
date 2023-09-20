Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16D9CE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B74C86CAC;
	Wed, 20 Sep 2023 05:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GCW55piW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC9AA86CAD; Wed, 20 Sep 2023 05:00:49 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0BEE86C24
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34fcc860911so12982345ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178846; x=1695783646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8w2SzIP6TT/fykTK7JCO3ta7b4g0QjiK6EXENsJFT8=;
 b=GCW55piWe7bQzcluqo5c8hjL8qDDmigC0PUFv1wSf450D/iIgZJL3t9q07k613rmbR
 UlWDYKfkvCJVMemi1Lgau99cqGAPyA9RLRHkVV95ylV884kZja44+O32OZc6xxcSxT8F
 Xz1JG1jJMqf0ECk7IoY9kaWZSgOFmdTuDWipM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178846; x=1695783646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8w2SzIP6TT/fykTK7JCO3ta7b4g0QjiK6EXENsJFT8=;
 b=nNAc8+ag3vH0wXgi1HhCq8CVzjxBUpRlkvaf/b2J9g5YJmx7RguaE+zcX8AKX1LRBF
 Zybcn5U+7KDbgyZC2/R5ErHoHJblsyVZpZMzp4Qf/VDsuVfV/PDpL0uYEGPgDEgf/ZFW
 uJQE83Sm6391/G0tT5krXIk5lTtC5nV39xs65OM4Mqwvst/+NfAjPUgUFOblb1behDIP
 tX6CcjLYLgNJkb/WbUiy0M67Ac1eqPfmM/3wNzCCz3yT4JPnhZ9FTDxhRRvrJ0RT4jEg
 qWABkO1uXKB1x9ejLNinkqoSc0WJaS4/xrahQFymFQD7WZOQycd4Ax/s0479G6SmXa1h
 zHMQ==
X-Gm-Message-State: AOJu0YwlLqipwchhvO2uBp4+VgKSFU2fLc7CPzk+Zi83tHN4N1oDdM+y
 EOJOzfxeU2zcnpKNICrbtoyOFdm2uUnaxymAtMs=
X-Google-Smtp-Source: AGHT+IGzzCjs2ErKAEKTKlDL/vhEzedKZzYUI+Zq1rjkJjcCJlH6PL1MINz8PIoA8J9lhipLe6ZkDA==
X-Received: by 2002:a92:c26f:0:b0:350:f510:3990 with SMTP id
 h15-20020a92c26f000000b00350f5103990mr1910796ild.2.1695178846224; 
 Tue, 19 Sep 2023 20:00:46 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 17/20] x86: doc: Move into its own directory
Date: Tue, 19 Sep 2023 21:00:18 -0600
Message-ID: <20230920030027.1385833-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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

There is enough material that it makes sense to split this up into
several files. Create an x86/ directory for this purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v2)

Changes in v2:
- Add new patch

 doc/arch/index.rst         |  2 +-
 doc/arch/x86/index.rst     | 11 +++++++++++
 doc/arch/{ => x86}/x86.rst |  6 +++---
 3 files changed, 15 insertions(+), 4 deletions(-)
 create mode 100644 doc/arch/x86/index.rst
 rename doc/arch/{ => x86}/x86.rst (99%)

diff --git a/doc/arch/index.rst b/doc/arch/index.rst
index 2f916f4026c5..60c93b3b6640 100644
--- a/doc/arch/index.rst
+++ b/doc/arch/index.rst
@@ -15,5 +15,5 @@ Architecture-specific doc
    riscv
    sandbox/index
    sh
-   x86
+   x86/index
    xtensa
diff --git a/doc/arch/x86/index.rst b/doc/arch/x86/index.rst
new file mode 100644
index 000000000000..3dc19d603d4c
--- /dev/null
+++ b/doc/arch/x86/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0+ */
+.. Copyright 2023 Google LLC
+.. sectionauthor:: Simon Glass <sjg@chromium.org>
+
+x86
+===
+
+.. toctree::
+   :maxdepth: 2
+
+   x86
diff --git a/doc/arch/x86.rst b/doc/arch/x86/x86.rst
similarity index 99%
rename from doc/arch/x86.rst
rename to doc/arch/x86/x86.rst
index 725a1ae58639..ef6970b88a59 100644
--- a/doc/arch/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -695,8 +695,8 @@ to load a 'u-boot-payload.efi', see below test logs on QEMU.
   No controllers found
   Hit any key to stop autoboot:  0
 
-See :doc:`../develop/uefi/u-boot_on_efi` and :doc:`../develop/uefi/uefi` for
-details of EFI support in U-Boot.
+See :doc:`../../develop/uefi/u-boot_on_efi` and :doc:`../../develop/uefi/uefi`
+for details of EFI support in U-Boot.
 
 Chain-loading
 -------------
@@ -732,7 +732,7 @@ SMBIOS tables
 To generate SMBIOS tables in U-Boot, for use by the OS, enable the
 CONFIG_GENERATE_SMBIOS_TABLE option. The easiest way to provide the values to
 use is via the device tree. For details see
-:download:`smbios.txt <../device-tree-bindings/sysinfo/smbios.txt>`.
+:download:`smbios.txt <../../device-tree-bindings/sysinfo/smbios.txt>`.
 
 TODO List
 ---------
-- 
2.42.0.459.ge4e396fd5e-goog

