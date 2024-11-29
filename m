Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBE7D70E1A
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 05:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06E26893E1;
	Fri, 29 Nov 2024 06:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MLhsP6z/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359D3893C9; Fri, 29 Nov 2024 06:38:09 +0100 (CET)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5B689397
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 06:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-7ee51d9ae30so945331a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 21:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732858685; x=1733463485; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s9tWdz5r/MITqNGdkcRM9SGUuwaAVL+KJ8WBJVMshkY=;
 b=MLhsP6z/58ISe0jEWiRcI7cT3+LKlV6VIF7Zisi/nNx9+VtE+4tEAh902/68TNzjyd
 nwrmmQRGB/pPd1F1zmnKQ5dA087SkpGSzJVHs/9BovChhvMFyvKECKRmOT36ltS7yR49
 MzmGX2OotD7jXnT8z9oSCsHM7QASVQVHf07DO65Rdr1vmlT/B4Tvbw6W7ZzGQEYQ+iqz
 e0S4XLvQKgp3+GbUHZzXovpVtX7jUsFaGpRL/4qudACn5FfBXCCZ6AbUad5hLJvVbTmx
 ZxlTs6kXPd+BFI9UKujb4IVBQFPp9E7tDF+RkZT8XQKGjn9C4AZWKeVezUg9N/C1NN4j
 tBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732858685; x=1733463485;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9tWdz5r/MITqNGdkcRM9SGUuwaAVL+KJ8WBJVMshkY=;
 b=nLXo61sRlmQor9keo3/Ah7h51/ISQKwhCUl6WIAJ2SYdwBpYW0XvCPiGt2jP3/9l51
 01R1Wd7A7tWm3fWsTGL9CPOe5BqKNpnliByV6myHUUOm7WcNMOPtXLx7zMzZG6IvaD3m
 93gjJXB2dOJ5+1uRZlBUUnj12mepbmN0meoQ8QAuhiv6ydZ35YJd+LpX9gCC6ZyUu/dQ
 0St7VqdwvkbWYN4p+ZqfRVVBuGIFP85wDnq70lkFIKY41dsCngmjU1jXorK2Sqox5jab
 S64VnmOfChrule8na9utssDVpz/o1H6IxMoCkFVd3NNvZR5Uwd6hb6UJjX6B5HcZEKTF
 fuYA==
X-Gm-Message-State: AOJu0YzbtE8Her+bHACC+n2Ggn4ZRciiXMuCxB5Wrt5A/8rwWLTyPlc9
 ngjvWkgeCdw2U/1kmbHrRPnhRtYN0+pO3QZji/7etK9TFoVAFqhW
X-Gm-Gg: ASbGncsuxcSDepTtr14lLAGk5r0KYzMEHbc7jYOstk84UA+0EbUvQu66sgidhJxwtk/
 UnyYfO72l4einmmv2dViaN9BtbgwZC5d0UoF3kYIID/s8SlU6Zei7zXV4ZKZWnPAfXeFLlldjFk
 /C7LKTo+0uAtwGSwbjKKgTkhfNogsnr/sIeN+ZM/Co/e9i7x39l65heJM6XTxthrtjaSUUDxbFl
 7DLM7lyIxUZWsmWs8yIcZZood4yYClPPstGKpV7a1r107gCAd5MplzNOV3WN74xl5rHYi4ZqMRI
 qbK/4MRg2bVedhKT75Q=
X-Google-Smtp-Source: AGHT+IE0pgWMhWvIgqrNVUl/pFj8bPr3kN/SMgMD3oFXML64mZQKfb8eF+d1MiWa+Xjgy8N0kfeHXw==
X-Received: by 2002:a05:6a20:3944:b0:1e0:d8c1:cfe2 with SMTP id
 adf61e73a8af0-1e0e0b5d87cmr15283371637.34.1732858684928; 
 Thu, 28 Nov 2024 21:38:04 -0800 (PST)
Received: from per1cycle.per1cycle (n220246100016.netvigator.com.
 [220.246.100.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215218f2345sm22901415ad.17.2024.11.28.21.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 21:38:04 -0800 (PST)
From: Huan Zhou <pericycle.cc@gmail.com>
Date: Fri, 29 Nov 2024 13:37:40 +0800
Subject: [PATCH v4 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3 board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-pickup-bpif3-v4-2-e99fabf66e33@gmail.com>
References: <20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com>
In-Reply-To: <20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732858662; l=4185;
 i=pericycle.cc@gmail.com; s=20241109; h=from:subject:message-id;
 bh=pRHUgMDJyOToy6Hk9m5NCMIx/mqzn1/b9pJSk31LboM=;
 b=z4LDkU5TH3cRxRqIdL8P1uEzaahhD8DQtW03hST5HL945G9osyVgCaW211+WOhgWPzEddFywW
 yw8MhBu+5CEAZdW70wRSzzzDsswKZCwe7rXqlBaLURBeHGZ2Hcb32Zd
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
 doc/board/spacemit/index.rst       |  8 ++++
 3 files changed, 95 insertions(+)

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
index 0000000000000000000000000000000000000000..1e6d6ef19be7e25684966bd4a727bd21b147330a
--- /dev/null
+++ b/doc/board/spacemit/bananapi-f3.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Banana Pi F3
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
+Sample boot log from Banana Pi F3 board
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

