Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DF9D65C6D
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 10:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A4968960E;
	Thu, 14 Nov 2024 11:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VgZqZX3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BEA6895CB; Thu, 14 Nov 2024 08:22:01 +0100 (CET)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9DFA88E0A
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 08:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so180316a12.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 23:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731568917; x=1732173717; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=solLgZiPlVniuqSGmBSUUoJ/Cfk/4V5e+ktdgluMdVM=;
 b=VgZqZX3daWy+GsvF6jwjvFcY1VAdq1s0D1P8iS5wrgcB4BMsNps5eVJmmLLXDSMwrQ
 cUafZi5oJe0p/bFnFJUXYEuMg9vOdrjiNrGSsBm0xBORzOSlQtxH7JRra+teuCpaybzY
 1foTbcq1jw9kv/PL0zpzTlI2bS93JLiMy/8XkNVQXLqgQLCV9BL70xvIr65JkcwRQRWA
 CYCJ/3KqS5RosR4wyZ/h35fw7ubMWcv5DvhEtJFISaBbAD3jNHKSns3rs0yQHrdFr8nQ
 LIWP5ch850ZiFLhaDHMQO0B0U7S/FqYD4xlFmCwB5OdjGBPvpNUZbo7PRzdfkG2Nw7FR
 PUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731568917; x=1732173717;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=solLgZiPlVniuqSGmBSUUoJ/Cfk/4V5e+ktdgluMdVM=;
 b=P1MRTMuQHUIyRlaZIiJ2BngATui/ltc7KZk3gwMS7Qt0lHaX1vksBWXXX80zdq45U/
 D1kKPnLA3g/PsawzEm3RuE6npobhjwkM+l6f7LDiTT/aY+6Io8ed76XQheQ3gQqrES1A
 +b46bju4kohm6A2+rS3t6Cf14Yfh32VDedPc/awJXW8y2u6LQhGsZ/LMNd6G1JqzeQXq
 nIIhD1UGFUModO4gVj5VXbE9O4rabkysZXcGmgxOObq8RALWZI7dY9RrVYVuumcI5hSQ
 yLA8rt/QZn6zEmGfU/7cZAZmz37qFhN8uJXW77SfbzHErWe4FQ4uBc623iSjEACrfpy4
 maMw==
X-Gm-Message-State: AOJu0Yw8cLdgu7d0G015Eyr9HqkRUXr7Mi9qSiHQt9EH5Q8JgxnKVy7e
 QyL0Nb2Zs5vRd9P9ZJRro24aC0StCEY9jcz8eRhoOXxSMJQj2t91
X-Google-Smtp-Source: AGHT+IFlaR7GvfFBajENk51XkWuy/rcI2uTQjdrljOmw9KI/oY1ZMHNXdBsZ09XfRGCMycgfmt4g4Q==
X-Received: by 2002:a05:6300:6f82:b0:1db:eb46:350a with SMTP id
 adf61e73a8af0-1dc704c2154mr6268329637.46.1731568917170; 
 Wed, 13 Nov 2024 23:21:57 -0800 (PST)
Received: from per1cycle.per1cycle (n058153182158.netvigator.com.
 [58.153.182.158]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06f4ce8bsm533733a91.28.2024.11.13.23.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 23:21:56 -0800 (PST)
From: Huan Zhou <pericycle.cc@gmail.com>
Date: Thu, 14 Nov 2024 01:21:33 -0600
Subject: [PATCH v3 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3 board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-pickup-bpif3-v3-2-98a45802ab79@gmail.com>
References: <20241114-pickup-bpif3-v3-0-98a45802ab79@gmail.com>
In-Reply-To: <20241114-pickup-bpif3-v3-0-98a45802ab79@gmail.com>
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, 
 Padmarao Begari <padmarao.begari@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, 
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731568899; l=3820;
 i=pericycle.cc@gmail.com; s=20241109; h=from:subject:message-id;
 bh=D/s9HnqQ6G9yPegK/HPF2YWA8/k+0sR7fXwPcx7cnno=;
 b=SLZg9VX9ry1xJDl9HliEg99MSLk32dZI5Rqyodswk8RKRDGUz3CArPM8IQptzowTssnDZRzaj
 4+juy4pBaTTBZ1H4l+Wl7pwQbbxwTyRmR7sBfC9JTIB3q+SMQyrA5FQ
X-Developer-Key: i=pericycle.cc@gmail.com; a=ed25519;
 pk=Wd3eEYWh1pNETTTXjX4aeanCWrr201iLaYYW5G1BdbU=
X-Mailman-Approved-At: Thu, 14 Nov 2024 11:38:48 +0100
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

From: Kongyang Liu <seashell11234455@gmail.com>

Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
---
 doc/board/index.rst                |  1 +
 doc/board/spacemit/bananapi-f3.rst | 78 ++++++++++++++++++++++++++++++++++++++
 doc/board/spacemit/index.rst       |  8 ++++
 3 files changed, 87 insertions(+)

diff --git a/doc/board/index.rst b/doc/board/index.rst
index 417c128c7af6ad2267ef1bc743c7f10ae70b6de7..367da2d62316d4cab25ecc53f852ef742eba13dd 100644
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
diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/bananapi-f3.rst
new file mode 100644
index 0000000000000000000000000000000000000000..ae98a784a7f19a28658b2d6acad0679cf0a4faa3
--- /dev/null
+++ b/doc/board/spacemit/bananapi-f3.rst
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
+computing power. 4G DDR and 16G eMMC onboard. 2x GbE Ethernet port, 4x USB
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
+   make bananapi-f3_defconfig
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
index 0000000000000000000000000000000000000000..3fb7d804ac8fc8dd4c7ee67ffc877f9ad323162d
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
+   bananapi-f3

-- 
2.39.5

