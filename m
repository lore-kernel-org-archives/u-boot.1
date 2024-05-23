Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046DDC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 06:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2572B882DB;
	Thu, 23 May 2024 08:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NON7H0oJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24118830C; Thu, 23 May 2024 08:40:44 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B7788208
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-244bdd730dcso2719880fac.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716446440; x=1717051240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xe9SKWuJu7mNsggkfz7SvnD5i3UrY4tEQYKmE+YMwfw=;
 b=NON7H0oJHmPP3ipV62xs1VBM0uRxtksxQ3VrfoUGKfxM00XHDIOAp4Un/4hQPaQKTM
 EA+7vgQiOFt2gNXAc1xJxHlp8lh3GPN0r1s4LZ36XNBH7EOUrYSNBdwybuJK/dxmf3zI
 Nd0woXSc+hUxnW5t8v0fmN1Imrzk1Katho1xyNAzz+rzxFkY4pdZ9W8Ob7Xra/IXuSap
 0o3RHJFx5jAYJm5MKx8gEoeP0UtAHHXS4SsqbAoct3hrmDCGxc/OpaXOCqZnWEs4wzkD
 ky8RMSVG4FEN0Y1no/jjWZcIhwMP2RYVtA/q59904H9jce3L9k7IBELfI2c2ph4pJzlO
 +W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716446440; x=1717051240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xe9SKWuJu7mNsggkfz7SvnD5i3UrY4tEQYKmE+YMwfw=;
 b=eLLWMZQ4Tw3+4kDZCux6NsZ6TheRObWofS7h0abnXdEXB1Yq61XwlAEcroZgL9xEVR
 +N8fIOfcNVYgEQMYAI5BnP9g94KjCl+MYKbb4QvMIjJV/GmN5zflD389LarGmpjfCs4b
 pGYljbSXTFOzo/mqkjBCl/5MCfBnC9fa2s5NBgw3mG35XwqAkUQGcArW+ALuTzn8YVBZ
 ZF7z028zFRba71bj3+I3smgDz53eB4J+wE+tr12ZexxHwwe5wVFF8+LzzvuAJ3OlZBPd
 PqgcK/gOBh7q8vhznic/LZ5dy6sgFN3XFQBxBg6DSk4APVKvYHviZGUNnJ5IUEWGQt8f
 N2dQ==
X-Gm-Message-State: AOJu0YzAUZEtI2bPuMmIs2eA8tFiySgjTErVaAXa+mCuuMm8WGkMcLsp
 4rPeeZy9a2HDhghg4TO9dZWwtjFO2qxRXPT++oG3M+NzUoLBRiEvL9JxjYwntz0=
X-Google-Smtp-Source: AGHT+IFs//YNjO3DBjclDKgn2sEELmlbnMDGLYzbtR0WsgOJBEsi4jwyiq9cfDQ2RwzhOYH22/lS8g==
X-Received: by 2002:a05:6870:c194:b0:23c:8254:2e41 with SMTP id
 586e51a60fabf-24c6882224emr4291833fac.0.1716446439904; 
 Wed, 22 May 2024 23:40:39 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2aa01dasm24048524b3a.92.2024.05.22.23.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 23:40:39 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: board: sophgo: milkv_duo: Update Milk-V Duo documentation
Date: Thu, 23 May 2024 14:40:19 +0800
Message-ID: <20240523064025.17602-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Add detailed steps for compiling U-Boot and OpenSBI, generating the
firmware package with fiptool, and booting the board.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 doc/board/sophgo/milkv_duo.rst | 41 +++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo.rst
index cb2ed1ad98..a88db5b903 100644
--- a/doc/board/sophgo/milkv_duo.rst
+++ b/doc/board/sophgo/milkv_duo.rst
@@ -20,31 +20,50 @@ Building
 .. code-block:: console
 
    export CROSS_COMPILE=<riscv64 toolchain prefix>
+
+3. Compile U-Boot
+
+.. code-block:: console
+
    cd <U-Boot-dir>
    make milkv_duo_defconfig
    make
 
-This will generate u-boot-dtb.bin
+This will generate u-boot.bin and u-boot.dtb
 
-Booting
-~~~~~~~
-Currently, we rely on vendor FSBL(First Stage Boot Loader) to initialize the
-clock and load the u-boot image, then bootup from it.
+4. Compile OpenSBI
+
+.. code-block:: console
 
-Alternatively, to run u-boot-dtb.bin on top of FSBL, follow these steps:
+   cd <OpenSBI-dir>
+   make PLATFORM=generic FW_FDT_PATH=<Your U-Boot Path>/u-boot.dtb
 
-1. Use the vendor-provided tool to create a unified fip.bin file containing
-   FSBL, OpenSBI, and U-Boot.
+This will generate fw_dynamic.bin
 
-2. Place the generated fip.bin file into the FAT partition of the SD card.
+4. Generate firmware image package
 
-3. Insert the SD card into the board and power it on.
+Fiptool(https://github.com/sophgo/fiptool) is used to generate fip file.
+
+.. code-block:: console
+
+   git clone https://github.com/sophgo/fiptool
+   cd fiptool
+   ./fiptool \
+      --fsbl data/fsbl/cv180x.bin \
+      --opensbi <OpenSBI-dir>/fw_dynamic.bin \
+      --uboot <U-Boot-dir>/u-boot.bin \
+
+This will generate fip.bin
+
+Booting
+~~~~~~~
+1. Place the generated fip.bin file into the FAT partition of the SD card.
+2. Insert the SD card into the board and power it on.
 
 The board will automatically execute the FSBL from the fip.bin file.
 Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
 U-Boot.
 
-
 Sample boot log from Milk-V Duo board
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 .. code-block:: none
-- 
2.41.0

