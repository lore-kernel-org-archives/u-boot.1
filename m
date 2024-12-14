Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB07E77180
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 06:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66D6800D7;
	Sat, 14 Dec 2024 07:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gpz1x29v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1321C801F9; Sat, 14 Dec 2024 07:45:35 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43265800B1
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 07:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-728e729562fso2037138b3a.0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 22:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734158731; x=1734763531; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IeYUzc+Iy8LtogU8ey/WJWWYfOWyVh1HQrPkMOdYRyA=;
 b=Gpz1x29vsjWElPgC1Ucj7gr/PlOSWUxUbljxmJpiiPnF7zPjXLl8y4+onGlV+jjv25
 9PyzUMH24LriBGUP/x8YXzJBwv7bJc0iC7LPyncAutYdYv9/hl7oN+kyszxcLQVWUjTg
 KuRoZ+8R7Q3UCHjj+4lcQKJfCZcr0UtbB6cajDrmMWTOTs0SX1XM43hHGuplCUGYf4gd
 Zl6s6ezBdrEXbYMDQrt75YniQwzHdKm+ORQdRm/bJboyWcAjrGcndW5xUAm+RrRCWiSH
 81PsIhGsiG07Fw/vV146/j6m8fHyknCqdH0DrBrfb3fbJyp32WZa29GoBlgEd6b+Dc8J
 54+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734158731; x=1734763531;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeYUzc+Iy8LtogU8ey/WJWWYfOWyVh1HQrPkMOdYRyA=;
 b=ijc2MbZA+A/XeMwAfPcs4tsiAUSHmvFMReZlce+dxv8/fhrL6+2PDD3fTvnmtFdnDY
 4I1iCZ8DAww0i31aRG+pc1yWRX34pl2U6ME/dGAH4Vbeeb5GTBxNfS+FU4S+ztlR9get
 kn2I1L2E9OJuXA4OSfd7HMFVD/ma4l4gca9yiAJH64pLwRPIpn9y/pdCIXVxD1UI6EKb
 bbmQhLRF2O//eer8kDPzaUY281YRfaqNRvBGeExNxdcrT+AKmCaP+kkFx6X2AXe2RUPK
 8jlT7BaUl7b8LJEuvnCIXDRwxeUTPyTkRhYuHpH1T+xaX8cL24jdm+QLWA2UCwpPTVZW
 wGYg==
X-Gm-Message-State: AOJu0YxYP6D9wjJjcF48N/DZcJDRiAAAWx2afx9IOgqoYw+99uZaJOLO
 2baz3k8AS8M0gXpHyvBZicPWqca7L5OfKxId3AggNUfRwSXwqftm
X-Gm-Gg: ASbGncsJEdmcvRDCI79iiBsEimeOm4SYZ7bhDds316g3Bk4222Sqp1E8i2n7lLyJLjA
 S0gOrfVDGrQYSz+TXY3fr8kCec0JivFJFw0/TErf2Foplr067Lv83g0FY9kkB/2hkBIT/ZY+esK
 a8yn3vyk3jlRhCdhlkVJMNhyvp2UogvVXjk8jsUzTMZjq/2mAmSQ8hkma20CNgh1r5bHjrr9j4U
 VfmrLJxRTHKHUPZGuSNovH+Lk3OW998AWccpQy1nKG8gtFoz8jfrWL/EY//52/FI0/Z+vr92ATw
 E30/qUP1SLw83tQ3BlSj3LSz9A==
X-Google-Smtp-Source: AGHT+IFod3blGUf0ffFMy/0tc7uI46q2QC9EPBhtZr1RR4vReRLIC3aIgdFXRWZXv3meU4qOfb2jIg==
X-Received: by 2002:a05:6a00:228b:b0:725:ef4b:de30 with SMTP id
 d2e1a72fcca58-7290c1a8691mr8039364b3a.14.1734158730575; 
 Fri, 13 Dec 2024 22:45:30 -0800 (PST)
Received: from per1cycle.per1cycle (n220246100016.netvigator.com.
 [220.246.100.16]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bcde27sm831431b3a.181.2024.12.13.22.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 22:45:29 -0800 (PST)
From: Huan Zhou <pericycle.cc@gmail.com>
Date: Sat, 14 Dec 2024 14:45:01 +0800
Subject: [PATCH v6 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3 board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-pickup-bpif3-v6-2-306355826455@gmail.com>
References: <20241214-pickup-bpif3-v6-0-306355826455@gmail.com>
In-Reply-To: <20241214-pickup-bpif3-v6-0-306355826455@gmail.com>
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, 
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Yixun Lan <dlan@gentoo.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, 
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Padmarao Begari <padmarao.begari@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734158705; l=4836;
 i=pericycle.cc@gmail.com; s=20241109; h=from:subject:message-id;
 bh=j1IVC2FCsDEEngdbkGqhy1M1BPHaQE05WluCeKeM7Pg=;
 b=CO5/b4PL6q6dvyNY9sooZDZ0BGcVMRT5PRjDl2VExBPr4OCwPtl6XGNJsOo54P8o+U60bCErq
 09y+VfUupWdDYagasnnuudIPOagL9iKHfVKmavkJES9qshFgSoAl75v
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
 doc/board/index.rst                |   1 +
 doc/board/spacemit/bananapi-f3.rst | 106 +++++++++++++++++++++++++++++++++++++
 doc/board/spacemit/index.rst       |   9 ++++
 3 files changed, 116 insertions(+)

diff --git a/doc/board/index.rst b/doc/board/index.rst
index b54c1748d57ece029f0f3ab829956dc893e7f5d7..b1c470eb2cbb1c07f907eb2282039520c219c72a 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -55,6 +55,7 @@ Board-specific doc
    sipeed/index
    socionext/index
    sophgo/index
+   spacemit/index
    st/index
    starfive/index
    ste/index
diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/bananapi-f3.rst
new file mode 100644
index 0000000000000000000000000000000000000000..54b412775e458ee7a8cd436d7a1f1c6ac70744f6
--- /dev/null
+++ b/doc/board/spacemit/bananapi-f3.rst
@@ -0,0 +1,106 @@
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
+Burning
+~~~~~~~~
+Actually, we can replace the uboot part from bianbu linux which is the bsp_ to validate this patch,
+use `balena etcher` to burn the bianbu-minimal.img to the sd card,
+and replace the /dev/sdx4 where places the uboot_ with the `u-boot.itb` generated from this patch.
+Or use fastboot:
+Collect FSBL.bin, u-boot.itb, partition_2M.json, bootinfo_spinor.bin
+u-boot-env-default.bin, fw_dynamic.itb from vendor sdk
+
+.. code-block:: console
+
+   fastboot stage FSBL.bin
+   fastboot continue
+   fastboot stage u-boot.itb-vendor # the itb from vendor uboot
+   fastboot continue
+
+   fastboot flash mtd partition_2M.json
+   fastboot flash bootinfo bootinfo_spinor.bin
+   fastboot flash fsbl FSBL.bin
+   fastboot flash env u-boot-env-default.bin
+   fastboot flash opensbi fw_dynamic.itb
+
+   fastboot flash uboot u-boot.itb-mainline # the itb from mainline uboot
+
+.. _bsp: https://archive.spacemit.com/image/k1/version/bianbu/v2.0/
+.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout
+
+Booting
+~~~~~~~
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

