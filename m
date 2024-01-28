Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4D8C47DA9
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 14:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72B0687E92;
	Sun, 28 Jan 2024 15:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WQ4J7RTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A1488071; Sun, 28 Jan 2024 08:06:49 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B7F880B6
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 08:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso417454a12.0
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 23:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706425604; x=1707030404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMIhpB3VL6+rI0fe61GNqB83jzxeVd+2V3irn6Pbr18=;
 b=WQ4J7RTN3NncLscdIYgVQm97mzVeOqxhkP8tfJoWHPGVIsct0WKiEVA0kkSgC9a7Ld
 NQ2ZmtXclMM2X7KYPCo9WR3+yELfUWBz4unDF1umnA6bWF6f+rnQsQsAwsMZX2zpDc2O
 sfdB/pLX0ZlGkstqUjnJMFZ9reBx1XfhUfkjj9RMGiYV5gMK0tQQd4zf3avokadkfO/I
 ytQB1cVGwImp6yzeSE0Bl32LJ+Yjgfl2jBHg1bHMsySjxSO0upiQ00+9/HAa5BmjeR4O
 JetL7e/lSqUiNG32z9vCifXxWpE2I4BeOZOmfb/wRWiV8dYFDFiecoZAJboEC+60QER1
 uoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706425604; x=1707030404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMIhpB3VL6+rI0fe61GNqB83jzxeVd+2V3irn6Pbr18=;
 b=WohDLPUe4MYdrO6vCW+KG7mko3cJRQKd3Wys1z4HgT2aikHstVysVqrb26ikPEhtXt
 UsyYCLzDB17aIM8D0t5ekufTRieYnqKFy9v7auFptTalDpVSXGwkILUDLzvxFrBspNen
 VQcqlQe7ZLkRZAZv0dEF06/79/zLJg/Wa1Eku8C205UvDygqTadplkVjAOSGMeDAjOqN
 SOlbrZYuuzrOJM/B6AIyPzva/wJhwwx2iKxD1WQ2kIm3wqqwDWY3cRO+0fFhV+ijutjk
 NUTSxkCGTWZ24TZUmln3Uys4f6As58AZyak5y8H0iArR1rPGue1FmUOHj9+VbAI4VLqp
 fjVA==
X-Gm-Message-State: AOJu0YwbM1X+0hZGRTEf+Z+j61g5q5JS3/TOHbp7z2ih6Yytt9qRv3Tv
 xuREQPAa3Qp+n2bWPnt3snBxs7kW5MxeoOVxmZkOH59up/MaEIXesJmX37S+EK50/IJ7
X-Google-Smtp-Source: AGHT+IHl1GtIJEzlq20THaTQLKyyO2v/sDNJY9gRbpMbEWzFRAxQiwI6uUKDa2Wj8tT0F7cOE+pL5Q==
X-Received: by 2002:a05:6a20:b803:b0:19c:8263:ed9c with SMTP id
 fi3-20020a056a20b80300b0019c8263ed9cmr913362pzb.25.1706425603629; 
 Sat, 27 Jan 2024 23:06:43 -0800 (PST)
Received: from localhost.localdomain ([115.216.236.184])
 by smtp.gmail.com with ESMTPSA id
 lc8-20020a170902fa8800b001d88b4b87f9sm3287297plb.192.2024.01.27.23.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 23:06:43 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 Fabio Estevam <festevam@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nishanth Menon <nm@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>, Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v4 3/3] doc: sophgo: milkv_duo: document Milk-V Duo board
Date: Sun, 28 Jan 2024 15:05:26 +0800
Message-ID: <20240128070614.7702-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240128070614.7702-1-seashell11234455@gmail.com>
References: <20240128070614.7702-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Jan 2024 15:10:42 +0100
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

(no changes since v3)

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

