Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8A2E77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 02:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D39895E3;
	Mon,  9 Dec 2024 03:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QWUgBYPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B6F28954F; Mon,  9 Dec 2024 03:00:48 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476F7895B1
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 03:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7251331e756so4096420b3a.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 18:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733709644; x=1734314444; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=THnLhthZI81prBNmyCcoBbimwpH77fpTrnnYq1gJbaY=;
 b=QWUgBYPyg9s+r5JIdelIvzLhKbBU5T08VtbInupKgu8Gr4PvNvHD6XjEUVQf0HRgTf
 tOOyX7H633LRAm5FozNv5pUzj7nbXym/+/E9q+wMSFAhqNqsrGx76cnWicDjupO2IOWc
 tGeL0XLr9/KRga8ZBGiWEuc5CmrTgq1RBqxhJG0eooRz8GTVe41Y0Pm1j/U5MK5TXydS
 n5KhJlwZDDGtQlZNdObxB58SR+DeZwh9l3aMrhpraOuL024tHuR7OhqsCNR3Pz8AQwSr
 Bjj90WhH3zxKsaR5IiJMjm7RtZbWsXu9XYI6G+9salhz8DnFPUE8SkjvhtSCwuVH8xPJ
 1vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733709644; x=1734314444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THnLhthZI81prBNmyCcoBbimwpH77fpTrnnYq1gJbaY=;
 b=ePaSXK12q5sqqqwW06xYczFD/AKdL8FMryCy0KWte3gz03GQz4fAgj5u5LWpOsMPO1
 48OfKmQbVVn9esL38WFB4RO5mW6eB7Wrom2V/7dF771Vb6e3VewRmDUpHKrOZJqdQ1St
 aN9FK9F7aOfNeJzkyRvy6w0HUL0WS12Zem+Gr7WScuwdSoPUnHnPwKKvHhcmdVbqPt5q
 CPQWB9C+XYDXnVvdA7lhUPWt5BEqfnDKPwSAv/EFJK/ndSQ/A9IwLgCoVXiJQvtbxGlQ
 jNbCErm3+t263177zXrxtZDWe3aQkf+iZmzCy6ZDDd6wZogXSj9nNmps/pRusOL40gSV
 n8rg==
X-Gm-Message-State: AOJu0YymllBIAFj9SsQasHxX50jjxTfX58pw45ZnuQV29E/frfOyIAyZ
 aoUuwbWg37yS8xKQh+O+JY+ZKz27jUI5uWUtw0pyel3eqmtTHKJr
X-Gm-Gg: ASbGncvedMhHMqunf9Ah0XepeiDBXdu4qRqoom8Fe84bLkJTfWwz+Xq94ByCSO8BusZ
 pvJlP10CIZmo/YTJd5lFflrfJ5CuavbCf97Tg3Lr39ZDjWW6QUHdoIoi46CMwgQzE11CVTVcUSj
 cwjNmFypqkcbexOJYfZzxv51aW01dndayeTv3L19BD91ePGV5PyGr7duL6FZ4aPF8AU2GrMOt2W
 /CswD/JGqYbZ9Ug8NizSCbvnLy5uxMJ6GSp3ThMheAjNiea4O8ARmexTFPgZHa5nvvMtVftPLo+
 rN1ICtVHXO5JaotuyP22VMq6FVJQ
X-Google-Smtp-Source: AGHT+IEas+D3mAX7QDzV5Q5izSYUvD7/Qtd7p6u80HZ4QgbqXbrWcz+gZiTjXgySp+TEu8vzM5YN3Q==
X-Received: by 2002:a05:6a00:1991:b0:725:e015:908d with SMTP id
 d2e1a72fcca58-725e01593e4mr6296311b3a.1.1733709643592; 
 Sun, 08 Dec 2024 18:00:43 -0800 (PST)
Received: from per1cycle.per1cycle (36-226-243-111.dynamic-ip.hinet.net.
 [36.226.243.111]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725ec7394b0sm921252b3a.43.2024.12.08.18.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 18:00:43 -0800 (PST)
From: Huan Zhou <pericycle.cc@gmail.com>
Date: Mon, 09 Dec 2024 10:00:20 +0800
Subject: [PATCH v5 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3 board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-pickup-bpif3-v5-2-92f801b7c6c1@gmail.com>
References: <20241209-pickup-bpif3-v5-0-92f801b7c6c1@gmail.com>
In-Reply-To: <20241209-pickup-bpif3-v5-0-92f801b7c6c1@gmail.com>
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, 
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733709622; l=4194;
 i=pericycle.cc@gmail.com; s=20241109; h=from:subject:message-id;
 bh=CCao/sdc77IZK7JcazSa4gfW1HGZMc5Q60ndf+yN+hc=;
 b=QcIwtboNHihUHKnKbPa+GJWpz94TbJtmFSOOwkC9rZM63q3uUGZ59dd6y2sAeQUrsVFapGjcn
 duPeGsa8gg9DMT+zPga18KjMKJpm2IZ8i8Dah5EmHbVssZa1VGQiLdd
X-Developer-Key: i=pericycle.cc@gmail.com; a=ed25519;
 pk=Wd3eEYWh1pNETTTXjX4aeanCWrr201iLaYYW5G1BdbU=
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
 doc/board/spacemit/bananapi-f3.rst | 86 ++++++++++++++++++++++++++++++++++++++
 doc/board/spacemit/index.rst       |  9 ++++
 3 files changed, 96 insertions(+)

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
index 0000000000000000000000000000000000000000..98a1b1d91daa897508762267e8363e7d98a0c5d0
--- /dev/null
+++ b/doc/board/spacemit/bananapi-f3.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Banana Pi BPI-F3
+============
+
+Building
+~~~~~~~~
+1. Install the spacemit riscv cross compile toolchain_, or skip it if riscv toolchain is installed.
+
+.. _toolchain: https://archive.spacemit.com/toolchain/
+
+2. Setup cross compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix, e.g /opt/spacemit/bin/riscv64-unknown-linux-gnu->
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
+Actually, we can replace the uboot part from bianbu linux which is the bsp_ to validate this patch,
+use `balena etcher` to burn the bianbu-minimal.img to the sd card,
+and replace the /dev/sdx4 where places the uboot_ with the `u-boot.itb` generated from this patch.
+
+.. _bsp: https://archive.spacemit.com/image/k1/version/bianbu/v2.0/
+.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout
+
+Sample boot log from Banana Pi BPI-F3 board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: none
+
+   try sd...
+   bm:3
+   j...
+
+   U-Boot SPL 2022.10spacemit-dirty (Oct 21 2024 - 09:01:13 +0000)
+   [   0.279] DDR type LPDDR4X
+   [   0.292] lpddr4_silicon_init consume 13ms
+   [   0.293] Change DDR data rate to 2400MT/s
+   [   0.430] ## Checking hash(es) for config conf-1 ... OK
+   [   0.432] ## Checking hash(es) for Image opensbi ... OK
+   [   0.437] ## Checking hash(es) for Image uboot ... OK
+   [   0.443] ## Checking hash(es) for Image fdt-1 ... OK
+   [   0.488] ## Checking hash(es) for config config_1 ... OK
+   [   0.490] ## Checking hash(es) for Image opensbi ... crc32+ OK
+
+
+   U-Boot 2024.10-rc4-00462-g5b138cfcc587-dirty (Nov 28 2024 - 14:56:49 +0800)
+
+   DRAM:  4 GiB
+   Core:  19 devices, 8 uclasses, devicetree: separate
+   Loading Environment from nowhere... OK
+   In:    serial@d4017000
+   Out:   serial@d4017000
+   Err:   serial@d4017000
+   Net:   No ethernet found.
+   => cpu list
+   0: cpu@0      spacemit,x60
+   1: cpu@1      spacemit,x60
+   2: cpu@2      spacemit,x60
+   3: cpu@3      spacemit,x60
+   4: cpu@4      spacemit,x60
+   5: cpu@5      spacemit,x60
+   6: cpu@6      spacemit,x60
+   7: cpu@7      spacemit,x60
+   => test
+   =>
+
diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
new file mode 100644
index 0000000000000000000000000000000000000000..e7d3d94e4599fbeb8da16c8a837e777a0be06227
--- /dev/null
+++ b/doc/board/spacemit/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT
+========
+.. toctree::
+   :maxdepth: 1
+
+   bananapi-f3
+

-- 
2.39.5

