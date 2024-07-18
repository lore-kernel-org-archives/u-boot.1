Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B1AC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 04:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC8BB88B12;
	Thu, 18 Jul 2024 06:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZcQpFO3e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1527088AF6; Thu, 18 Jul 2024 06:34:11 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D5DB88AFC
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-395e9f2ebc0so1679185ab.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 21:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721277247; x=1721882047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+NvhxUGRj2Arz3ndUe/7eeOwqX8AgeQ96/szmCJ2PM=;
 b=ZcQpFO3e9QvvDHcWcew/iTrS3u7RwI5ACmkNFhBcpOWZOqABJY4rr3RhlLlVWWS2Z4
 uJPHhCuXEms4c1r5FgrDHNHHU8JyKpo5GJNobEXzxCiL2F8eTmB7zYth1H0yN5DC9mkf
 rlAhFIf1ZMxWzikiUS76Rjn/bKlOsloSzV9jCbcgHM7ori/u3Nwq9RLTjEZ63SEDlBYn
 N1iWT+lgGkzD56WpguWujwpGAo/spbmrKsJdxFq3jxG2qaQi2A9RB1jtS2X4BlG2qzob
 ho20es2Q3gwn/j2kTrIJQdXdYoJ9y6K43xg1vrI7QW+idlLmGMuj3NXpTLDT+Mu5pPHG
 0xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721277247; x=1721882047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1+NvhxUGRj2Arz3ndUe/7eeOwqX8AgeQ96/szmCJ2PM=;
 b=Q9jX2XMzWRX1louJ9VXKehEDdvzTUYstSYq8Cv/GIMsD3AJ6l6gX9U4evfes9nN5x9
 GUe9gAENe1IGwBDbx3HNp/v3ZybDpYPmhar/os9lMygrHf1h4sI8/nr4Dg8iy2Tpf2dd
 7BBTKQL94X6q5JI9VnKAhhdX6YEekbln3Z9MnuyRnExtu6f4VP/AJvYT3JQligN1JKa+
 cdi8OVJZWMm9TWAjWuOQKBNxjCsT8qvrofpv5SFY8jvgQDYkIM2XKKXGXw6aRZE6e0L5
 vEupPd1wUO5mtMhpyoBebYmqyt4l9Lia8pQvoBF6IPp6KuuFU5vxYhijWrGRI8ruWutY
 S9eQ==
X-Gm-Message-State: AOJu0YyhGp7Z6vNzsorF0zCP+ini7+ZR1NwzmLG9bShsuQta50Ve8yFB
 5QruDkXSkf29nkllptw1MdDjO8HPH7+K5ZNbVL/c1Phbo49poty+lqqyxT1utX0=
X-Google-Smtp-Source: AGHT+IHEv9F0cFJVY+cJKceIRP9Xw5Jv1mwpOTCkArEsrxZJnIlrl2lXdsIgu9y3J7dDlm9erlGjuA==
X-Received: by 2002:a92:c26e:0:b0:375:932e:7e9c with SMTP id
 e9e14a558f8ab-39557043bf2mr46105755ab.19.1721277246802; 
 Wed, 17 Jul 2024 21:34:06 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd309csm8965354b3a.216.2024.07.17.21.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 21:34:06 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3 board
Date: Thu, 18 Jul 2024 12:33:23 +0800
Message-ID: <20240718043329.1500-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718043329.1500-1-seashell11234455@gmail.com>
References: <20240718043329.1500-1-seashell11234455@gmail.com>
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

Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

(no changes since v1)

 doc/board/index.rst                |  1 +
 doc/board/spacemit/bananapi_f3.rst | 78 ++++++++++++++++++++++++++++++
 doc/board/spacemit/index.rst       |  8 +++
 3 files changed, 87 insertions(+)
 create mode 100644 doc/board/spacemit/bananapi_f3.rst
 create mode 100644 doc/board/spacemit/index.rst

diff --git a/doc/board/index.rst b/doc/board/index.rst
index 417c128c7a..367da2d623 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -51,6 +51,7 @@ Board-specific doc
    sipeed/index
    socionext/index
    sophgo/index
+   spacemit/index
    st/index
    starfive/index
    ste/index
diff --git a/doc/board/spacemit/bananapi_f3.rst b/doc/board/spacemit/bananapi_f3.rst
new file mode 100644
index 0000000000..cf3041085f
--- /dev/null
+++ b/doc/board/spacemit/bananapi_f3.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Banana Pi F3
+============
+
+About This
+----------
+Banana Pi F3 board is a industrial grade RISC-V development board, it
+design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
+computing power. 4G DDR and 16G eMMC onboard.2x GbE Ethernet prot, 4x USB
+3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
+
+Building
+~~~~~~~~
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+
+3. Before building U-Boot, OpenSBI should be built first. OpenSBI can be
+built for SpacemiT K1 SoC as below:
+
+.. code-block:: console
+
+   git clone https://github.com/cyyself/opensbi -b k1-opensbi
+   cd opensbi
+   make PLATFORM=generic
+
+4. Then build U-Boot as following:
+
+.. code-block:: console
+
+   cd <U-Boot-dir>
+   make bananapi_f3_defconfig
+   make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
+
+This will generate u-boot.itb
+
+Booting
+~~~~~~~
+Currently, we use a modified vendor's U-Boot SPL to load a FIT image that
+includes OpenSBI and U-Boot. Fully describing how to boot into U-Boot is a
+challenging task. And the booting method will be added after the SPL
+support is available.
+
+Sample boot log from Banana Pi F3 board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: none
+
+   U-Boot 2024.07-00686-g608f2d51760c (Jul 08 2024 - 14:53:51 +0800)
+
+   DRAM:  4 GiB
+   Core:  18 devices, 7 uclasses, devicetree: separate
+   Loading Environment from nowhere... OK
+   In:    serial@d4017000
+   Out:   serial@d4017000
+   Err:   serial@d4017000
+   Net:   No ethernet found.
+   bananapi_f3# cpu detail
+     0: cpu@0      spacemit,x60
+      ID = 0, freq = 0 Hz: MMU
+     1: cpu@1      spacemit,x60
+      ID = 1, freq = 0 Hz: MMU
+     2: cpu@2      spacemit,x60
+      ID = 2, freq = 0 Hz: MMU
+     3: cpu@3      spacemit,x60
+      ID = 3, freq = 0 Hz: MMU
+     4: cpu@4      spacemit,x60
+      ID = 4, freq = 0 Hz: MMU
+     5: cpu@5      spacemit,x60
+      ID = 5, freq = 0 Hz: MMU
+     6: cpu@6      spacemit,x60
+      ID = 6, freq = 0 Hz: MMU
+     7: cpu@7      spacemit,x60
+      ID = 7, freq = 0 Hz: MMU
+   bananapi_f3#
diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
new file mode 100644
index 0000000000..78081a47ff
--- /dev/null
+++ b/doc/board/spacemit/index.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT
+========
+.. toctree::
+   :maxdepth: 1
+
+   bananapi_f3
-- 
2.41.0

