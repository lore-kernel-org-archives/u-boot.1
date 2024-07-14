Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3285EC3DA42
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 15:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D64882CE;
	Sun, 14 Jul 2024 17:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nDJCkODK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8AA882CE; Sun, 14 Jul 2024 17:09:01 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B3588498
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 17:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so3111396a34.3
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720969737; x=1721574537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4c2xdutG+LiWnovx+z6RCXfyGXESzNtBlCan23x519c=;
 b=nDJCkODKG7YKhcApKq45AbiIYWimy8qHW1l3Nm7idtqnCW4GEx4E/dQSPmyqybDLtE
 eBQmCaK1V7IYbcNMx+QqvtLwjrtyRzvr9bHJoZORQKcsza/qgyUohYh/KUDI9Z41xAL8
 R5kvX0pcg1O45MWESx2RMyJnNiDKDAaNwzPXJkKibR2Zksy7C/BmbqvHS5nvi7KcA2x5
 XSRU0c8gsurumzMu66mn1GjrFX3nuyMdns7xmoxCxiEV47NboBmCJqjogWi2k7pc8rxo
 p0VADMmL8khyxUmQJeytPbeXWQXSoX/vx2aRXDcEj7KW5Ml8G87++YqB+I8fLNM1Lfb7
 ra9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720969737; x=1721574537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4c2xdutG+LiWnovx+z6RCXfyGXESzNtBlCan23x519c=;
 b=mgdJJsIjgKxax9wOpFSdtpOmZ3OQG1qvOTpbuMYPXOaSmyrCDMnxEu5PnZfPxLtNLN
 iqKAm267ME/PjGFgynlpYU9YN4auozhR0rC2Ed2OFM4iGMCF9jUlIpUgjXLuMRPQ5gu4
 yZHd+gFnaLofsCz2v1cOHeDZ7/97T1+FXqWDmfG7w4oF1qP+e3SuUXWSCpcMUbpWA2j3
 UFk6undk+M80zg+tS+BGpO5P4r91FgrugthjBs5cxs1bXl9486IOEzAkvuAHvi9OI8w/
 xA+jYVAWIctMP3cmJaUiZlA0TQKTKidfGQljOunz5cHoXHgQS0WyFfF0BED9b+Ke7RgS
 t72Q==
X-Gm-Message-State: AOJu0YwkBWl643RHuZcSDkc7ZTtfi62NkLOk735/cUMIRR0nRCAxwy2C
 KTgLW6ZxX937KXb5gG+CItzsrluzX8nh6QY75nr83sQpyM03JICAAdVdawjg
X-Google-Smtp-Source: AGHT+IGu95x5RzQnbgPpoJpnbsgvTvkRDumcu8/1+bQtv4uoyQodyq/hPZKuTWwL1lggtvMlZXkABg==
X-Received: by 2002:a05:6870:1692:b0:25e:c7b:ca8f with SMTP id
 586e51a60fabf-25eaebfa15emr13803470fac.46.1720969736654; 
 Sun, 14 Jul 2024 08:08:56 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ebc4637sm2686529b3a.88.2024.07.14.08.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 08:08:56 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3 board
Date: Sun, 14 Jul 2024 23:08:25 +0800
Message-ID: <20240714150828.736-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240714150828.736-1-seashell11234455@gmail.com>
References: <20240714150828.736-1-seashell11234455@gmail.com>
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
index 0000000000..465040b94f
--- /dev/null
+++ b/doc/board/spacemit/bananapi_f3.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0+
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
index 0000000000..cc2bd6ab0a
--- /dev/null
+++ b/doc/board/spacemit/index.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+SpacemiT
+========
+.. toctree::
+   :maxdepth: 1
+
+   bananapi_f3
-- 
2.41.0

