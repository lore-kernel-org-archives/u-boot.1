Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847CFC47DAF
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 15:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC558786B;
	Sun, 21 Jan 2024 16:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e3d8Ylb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C406D87705; Sun, 21 Jan 2024 16:07:04 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA74B87708
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 16:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6dbcdbe13e1so526353b3a.3
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 07:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705849619; x=1706454419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Psrw6t9YChHYoGUJlONXgotKNGhG2YNyD5Kf1SmmoM=;
 b=e3d8Ylb4gCLWqot2YcpYP1Tny1ym5/BGwNUHpMZZUGUTxQK/yqAXKsen5MvHV5mBKZ
 1PBCrBDy11KVaZmGWWer+tDdCAJqpzPjTZIHhxB8s+i7AHr/fhUPcR432k6MTL4yu5o8
 Qx652xp7ManhM/2QNHDL2Zvg/baX1fxNnruy1hcFLiNEi0cBp69UlgzasplRISj04osa
 7qXerpu3WLiILB2W8QKDiarXGPQBF+A+UGwl4aDtmn298uN3uOfGjw8cJ60YH+k5aP/e
 YZMBUSIAGj9C62FgVN5xjL8hwaglN0E8Z1yGuByDvlOe8SYkAGHGxEor1irIVNLQYWVl
 QEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705849619; x=1706454419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Psrw6t9YChHYoGUJlONXgotKNGhG2YNyD5Kf1SmmoM=;
 b=wwFpzawnW/MJwbMP7BwahppObkMApvRp5igyZ11nQYCFlClNAk4trpwSnoTqTG1+sl
 ZcHVf4I+LhVi8qcnsW83MqJSRJcr+Bb0G/viCMXMtaPfLepufPum0ijpOpjxyy8Ov2/g
 n5UYOChQMcVadqMBf1S+kXxvm+aszrXZGhjArFBFfwlsm3NhoHLBAG5XNFi+ee27MtHG
 6c8zZerHaAMpsOLO97NG6BmS1PyEGJDrs53GZl+oVUGGvOnMugMis3CxtqihQ7Ffvvis
 abWT6ujXLrm+7Mrd2LmBb0rF8uxe6fPkrhFNAzsSIx4HGZhYtIKsug3KyKeySmOIl3mK
 c74g==
X-Gm-Message-State: AOJu0YxreUnMcB4Kyyt7MIEwKilJCsXqNkxp3PsMO9hROQhHrbvigCXS
 n+4PdWlV3yn1/7/79O+cpC/GVi70/z/O80laoIdGif9pYbdTraymmQyf1QQl0AZw7g==
X-Google-Smtp-Source: AGHT+IHJVD6vhsY8BCILZEOpYAcUp81nIzyr+2BbOOHWjMYc9hhUwGm1UGte+OXJvY05cWuAIm7+4w==
X-Received: by 2002:a17:902:6b02:b0:1d5:8c0e:2d05 with SMTP id
 o2-20020a1709026b0200b001d58c0e2d05mr1066248plk.135.1705849619147; 
 Sun, 21 Jan 2024 07:06:59 -0800 (PST)
Received: from localhost.localdomain ([218.73.27.11])
 by smtp.gmail.com with ESMTPSA id
 ke5-20020a170903340500b001d33e6521b9sm5942139plb.14.2024.01.21.07.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 07:06:58 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 Fabio Estevam <festevam@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kever Yang <kever.yang@rock-chips.com>, Nishanth Menon <nm@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>, Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v3 3/3] doc: sophgo: milkv_duo: document Milk-V Duo board
Date: Sun, 21 Jan 2024 23:05:15 +0800
Message-ID: <20240121150630.30588-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240121150630.30588-1-seashell11234455@gmail.com>
References: <20240121150630.30588-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 21 Jan 2024 16:11:19 +0100
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

Add document for Milk-V Duo board which based on Sophgo's CV1800B SoC.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

Changes in v3:
- Add brief description of the procedure to run u-boot-dtb.bin

 doc/board/index.rst            |  1 +
 doc/board/sophgo/index.rst     |  8 +++++
 doc/board/sophgo/milkv_duo.rst | 64 ++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 doc/board/sophgo/index.rst
 create mode 100644 doc/board/sophgo/milkv_duo.rst

diff --git a/doc/board/index.rst b/doc/board/index.rst
index c96e5fda28..d0f9f355d2 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -46,6 +46,7 @@ Board-specific doc
    sifive/index
    sipeed/index
    socionext/index
+   sophgo/index
    st/index
    starfive/index
    ste/index
diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
new file mode 100644
index 0000000000..e097afdac6
--- /dev/null
+++ b/doc/board/sophgo/index.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Sophgo
+======
+.. toctree::
+   :maxdepth: 1
+
+   milkv_duo
diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo.rst
new file mode 100644
index 0000000000..cb2ed1ad98
--- /dev/null
+++ b/doc/board/sophgo/milkv_duo.rst
@@ -0,0 +1,64 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Duo
+==========
+
+CV1800B RISC-V SoC
+------------------
+The CV1800B is a high-performance, low-power 1+1 64-bit RISC-V SoC from Sophgo.
+
+Mainline support
+----------------
+The support for following drivers are already enabled:
+1. ns16550 UART Driver.
+
+Building
+~~~~~~~~
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+   cd <U-Boot-dir>
+   make milkv_duo_defconfig
+   make
+
+This will generate u-boot-dtb.bin
+
+Booting
+~~~~~~~
+Currently, we rely on vendor FSBL(First Stage Boot Loader) to initialize the
+clock and load the u-boot image, then bootup from it.
+
+Alternatively, to run u-boot-dtb.bin on top of FSBL, follow these steps:
+
+1. Use the vendor-provided tool to create a unified fip.bin file containing
+   FSBL, OpenSBI, and U-Boot.
+
+2. Place the generated fip.bin file into the FAT partition of the SD card.
+
+3. Insert the SD card into the board and power it on.
+
+The board will automatically execute the FSBL from the fip.bin file.
+Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
+U-Boot.
+
+
+Sample boot log from Milk-V Duo board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: none
+
+   U-Boot 2024.01-rc5-00010-g51965baa36 (Dec 28 2023 - 13:15:53 +0800)milkv_duo
+
+   DRAM:  63.3 MiB
+   Core:  10 devices, 8 uclasses, devicetree: separate
+   Loading Environment from nowhere... OK
+   In:    serial@4140000
+   Out:   serial@4140000
+   Err:   serial@4140000
+   Net:   No ethernet found.
+   milkv_duo# cpu detail
+     0: cpu@0      rv64imafdc
+      ID = 0, freq = 0 Hz: L1 cache, MMU
+   milkv_duo#
-- 
2.41.0

