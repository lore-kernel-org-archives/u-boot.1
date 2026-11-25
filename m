Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713B2606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qwRrv5bU;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kFLATDKL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AD5D60892;
	Wed, 25 Nov 2026 12:21:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AroISEP27q5y; Wed, 25 Nov 2026 12:21:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0BFA46088B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795609264;
	b=WmtBIsWJD3mhp6fDy5Jivu+DHzZLXtpMd0YBYT4gc0eVPAtlljXVNTeqnss6N+VMpn69
	 ggS3nYxLThhtS2U22QUeEnvrsFKNxLYxlufWLK7Hgau4n8TKsGqyJqvT7VaMhbBGuziLt
	 I/F9B9q2eCnHrKH/iGHUdE4j6ugeoZwA4kjXiFA30QP3BEqsOFiwxDKtuV/FWFrDGYrdv
	 H1luxS8RninlmH2ARIIme3ZljvHabPrsOXtc300cz8X43u225R/z4tn18X8lmQ+UEtlIt
	 TkAIH/wxsJATA9tgk49LzW1eqHfWPc5wylgijrlTHrlB/rn45IMQz/igGgbE6t7PjLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795609264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IDuz8bGGJssLfTaJrl8A8/Ro8WRB4txe5FqYmXZF7KI=;
	b=DXBk9yWLxb/HwlXYeFJCC2GCTIZhxhOG2BWgqilzmT5OtyJuzQoaZacz5NDsKf8IqyMt
	 5Ec96v8hauoeisvo+CxaGnfBOxXpAhanYVeUTxxIlxzCCha88l2M1xqKmqDUr4ZZ7KzRZ
	 aZNU3Z+XqOzWMGpm48GdfwOnjOAfcycpanf1O0/xlYshLrwCn28zJplfGxYoE2MoSOXJR
	 y2PJJXbY2itJVSN4orEpDYeYs6fm2oCUJ3HcaupY84l5HJ3iq1nmouzdU6WeLZakWrjCX
	 ald22XSf8X4eR16aEfF9xEg/+PeueePdpNeLDPod/pmDhS9zct7wTziBzyYlOT6zMRA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795609264;
	bh=IDuz8bGGJssLfTaJrl8A8/Ro8WRB4txe5FqYmXZF7KI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qwRrv5bURKL/jkYWKmgMFWgOH9tpstOsn6u2Q7NeI3C0fu+LDkqUyOdM05Oy/Y96G
	 KPMa2ddIPCo8Efd8TbWRizbRcPLdvRKQNWDcF5eyFj2nKogWvAY1HtvzGC4KverQJe
	 nJPsvr4ArCfihWYNb/xZ/ThJCtc5oB1yqiWYbEW1H0N/pADUUA4xxc45GPpQcRjIUX
	 ksaLv+as9xUiwTGQ2wCbdaRJzU4szznqv20cPNsyGelkaOQp6jwAJ9rZUdro/PkUU8
	 5sLiuNUBa1hIMQJapdjkgdPcGJZumJ9xg+tYTgj3kghsD1/Gf3jgfWX0ZSeRh1OB4L
	 RmUWbVMFMzIBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BFA46088B;
	Wed, 25 Nov 2026 12:21:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8074C325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71A8E406A4
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:21:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPVpx3OPu_7I for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 12:21:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 487434056F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e35; helo=mail-vs1-xe35.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=kFLATDKL
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 487434056F
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:21:01 +0000 (UTC)
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-7d6a6776719so3470066137.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795609260; x=1796214060;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IDuz8bGGJssLfTaJrl8A8/Ro8WRB4txe5FqYmXZF7KI=;
 b=kFLATDKL+PBvRildj/AvG8B6qBRJJCCLi0oMn5ntnO52iEV9RGvx4ar6itCuv75+/3
 /o3NsUzEMxPP7z72xEGZAkm/gg/eFXt91abAC1W/uUoj1rPathvPAAQiU4ziYshOugGZ
 qwsx2BER8n7uCkqemKM8gtrJ0cqECOW5hpQFZimjBBfolAaQBUunXFP7X1sbASTxK0Up
 h+M+TzjRuW1EFY2zI0KsRae4Ik42Yykoeev19StDD0Wqjy760uLo6mlSJr9M/nXmvVt2
 vZEErYcBuTzUlua316WRj/A9ctrrKkg280MduODqtc+Na8mypR2WcIv8/ozZNQqpjFND
 Vy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795609260; x=1796214060;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IDuz8bGGJssLfTaJrl8A8/Ro8WRB4txe5FqYmXZF7KI=;
 b=1aZt1fhkbTGhPoPtSdmIhOBdHB+55NxALXS9ZCfOj//Jkit4eEbeITzzG24FsKoJDC
 TziviZzaQAzK5eiMIPR2LZWLFic5M3CyYP/IlyAejoE3yBNECxKWohSRLwquMjgjWapE
 /Bq4XxGAygzA7s6krtNBjj2KE9K2zDmCKjxTr2S6ajg1jXxvS5ZklFVdf+6v+2e0le48
 4Kz9Oo+OpVLCa6+GrQvosMWnTuRk6lYPPOTuwsf+B9tCNYaI/2HoHeybJV4dU3xFPuI+
 WOU1gQ6+fYJ6RIenmUu7i+czIb5gWoyLiJvv3OUOPHps90dKeoy0yF9awJhJck9t17U5
 XPow==
X-Gm-Message-State: APuU4Z+xp5WoZm7asZeDjO5P8opooVwFxDwzS/d+mu5xSSBqxLZOy0lz
 uYyiakVokf+J+BeIHqcswHvD0pvp07/XvcvKDJjbefYLTbNFHuk+5ULq
X-Gm-Gg: AZFdTZeUjeuRssd+2GKm+5uoXOo7ueVXUjzimpkMqA6xciJVs0kX4w8rXHrbPARo9NL
 Qe31pAaSaV8PfgZeqvW9XKL38C536pFEyNFmw1aWIFc2CyzXby5O9ZAIfGe8bK8RUNST+TK7fA+
 zpkBoUmRTNZA3bTLuYgfZ0Ww9QdgkV1/CHDEmV1slWKmDLYVA3XVaDyjgWXNEvCtYtlIpSd2i9A
 iXKkp0pnj8HlctOz9Xs0iRYDWrN9uiat+a2Y1QSV0UwE2WSfShUyZFkV/PYroah0Ardwvinv2Gc
 xcdVs571QGKvhv1xgm2E4fRsUYImCy5w7kTPk7Sak4ukUXgc3ppiZXULfOmlQ1hAgyOvEXl8Lm2
 u6ICAE4TloHyFbhvj731rZ4fbFhKJj7mTgFf3mNXQIGcm/fML08LBCsbxW2PB9VrhksqeM2jseV
 Za6+kctSxDOMwCck1qEEsk7rIjZLCysQCpAb7Amq0pqDjsJLPijbhjFPX9GyjJE4Bh5yJpNNBEr
 u7V79fx2C+RTIap7+sKs2clzGpBiS1loaMczenE0OSuYa5rXhixJxLtvRYB8IQeexswSnQgkZjm
 mWh4n9TJThfTXKRuDjgT+PuBb2tHHJkxq51vjPuhvH3KOw==
X-Received: by 2002:a05:6102:a4d:b0:7cb:fd69:4155 with SMTP id
 ada2fe7eead31-7d72b3582d9mr10144531137.5.1795609259835; 
 Wed, 25 Nov 2026 04:20:59 -0800 (PST)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e6dec7cb5sm18636534241.2.2026.11.25.04.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 04:20:59 -0800 (PST)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Wed, 25 Nov 2026 09:20:30 -0300
Subject: [PATCH v3 3/3] board: sophgo: Add Milk-V Duo S documentation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-upstream-v1-milk-duo-s-v3-3-9ed94b63cbbe@gmail.com>
References: <20261125-upstream-v1-milk-duo-s-v3-0-9ed94b63cbbe@gmail.com>
In-Reply-To: <20261125-upstream-v1-milk-duo-s-v3-0-9ed94b63cbbe@gmail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 E Shattow <e@freeshell.de>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add documentation for the Milk-V Duo S board, describing how to build
U-Boot, the boot flow (FSBL, OpenSBI and U-Boot) and how to generate
the fip.bin image.

Milk-V builds the Sophgo FSBL as part of its SDK, with the T-Head
toolchain and the Sophgo U-Boot fork, which does not support a standard
GCC toolchain or a mainline u-boot.bin. The FSBL build steps are therefore
based on the community-maintained meta-riscv layer, which provides the
board memory map and the FSBL patches needed for both.

Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
---
 board/sophgo/milkv_duo_s/MAINTAINERS |   1 +
 doc/board/sophgo/index.rst           |   1 +
 doc/board/sophgo/milkv_duo_s.rst     | 142 +++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)

diff --git a/board/sophgo/milkv_duo_s/MAINTAINERS b/board/sophgo/milkv_duo_s/MAINTAINERS
index 435d4827fdea..86533c03fd9a 100644
--- a/board/sophgo/milkv_duo_s/MAINTAINERS
+++ b/board/sophgo/milkv_duo_s/MAINTAINERS
@@ -4,4 +4,5 @@ M:	Hiago De Franco <hfranco@baylibre.com>
 S:	Maintained
 F:	board/sophgo/milkv_duo_s/
 F:	configs/milkv_duo_s_defconfig
+F:	doc/board/sophgo/milkv_duo_s.rst
 F:	include/configs/milkv_duo_s.h
diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
index 19c9a19b1d4b..61aceafceea3 100644
--- a/doc/board/sophgo/index.rst
+++ b/doc/board/sophgo/index.rst
@@ -7,4 +7,5 @@ Sophgo
 
    milkv_duo
    milkv_duo_256m
+   milkv_duo_s
    licheerv_nano
diff --git a/doc/board/sophgo/milkv_duo_s.rst b/doc/board/sophgo/milkv_duo_s.rst
new file mode 100644
index 000000000000..e4c201de2c4c
--- /dev/null
+++ b/doc/board/sophgo/milkv_duo_s.rst
@@ -0,0 +1,142 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Duo S
+============
+
+SG2000 RISC-V SoC
+-----------------
+The SG2000 is a high-performance, low-power 64-bit RISC-V/ARM SoC from Sophgo.
+
+Mainline support
+----------------
+Support for the following drivers is already enabled:
+
+1. ns16550 UART Driver.
+2. Synopsys DesignWare MSHC Driver.
+3. Synopsys DesignWare Ethernet Controller.
+
+Building U-Boot
+~~~~~~~~~~~~~~~
+1. Add the RISC-V toolchain to your PATH.
+2. Set up the cross-compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+   cd <U-Boot-dir>
+   make milkv_duo_s_defconfig
+   make
+
+This will generate u-boot.bin.
+
+Boot flow
+~~~~~~~~~
+The board boots from a FIP image, fip.bin, which contains the following
+binaries:
+
+- FSBL (First Stage Boot Loader): the Sophgo (SoC vendor) bootloader [1]. It
+  serves the same purpose as U-Boot SPL, but U-Boot does not support SPL for
+  this SoC yet, so the Sophgo FSBL is required.
+- OpenSBI (fw_dynamic.bin), built with the board devicetree.
+- U-Boot (u-boot.bin).
+
+The boot flow is:
+
+1. The boot ROM loads fip.bin from the FAT partition of the SD card and runs
+   the FSBL.
+2. The FSBL initializes the clocks and DRAM, starts the coprocessor firmware
+   on the C906L if present, and loads OpenSBI and U-Boot into DRAM.
+3. The FSBL jumps to OpenSBI, which runs in M-mode.
+4. OpenSBI starts U-Boot in S-mode.
+
+The fip.bin image is generated by the FSBL build, using the fiptool.py script
+from the FSBL source code.
+
+Booting
+~~~~~~~
+To run u-boot.bin on top of the FSBL, follow these steps:
+
+1. Generate a compatible u-boot.bin using U-Boot with the Milk-V Duo S
+   default configuration.
+
+2. Use mainline OpenSBI v1.5+ (v1.5 is the first release supporting the SG2000
+   [2]). Use FW_FDT_PATH to point to the sg2000-milkv-duo-s.dtb device tree
+   file while compiling fw_dynamic. Example:
+
+.. code-block:: console
+
+   cd <OpenSBI-dir>
+   make PLATFORM=generic FW_FDT_PATH=<U-Boot-dir>/dts/upstream/src/riscv/sophgo/sg2000-milkv-duo-s.dtb
+
+This will generate build/platform/generic/firmware/fw_dynamic.bin.
+
+3. Build the FSBL [1] and generate fip.bin. Milk-V (the board vendor) builds
+   the Sophgo FSBL as part of its SDK [4], together with the T-Head toolchain
+   and the Sophgo U-Boot fork. That build does not support a standard GCC
+   toolchain or a mainline u-boot.bin. The steps below are therefore based on
+   the community-maintained meta-riscv layer [3], which provides the board
+   memory map and patches the FSBL to compile with a standard GCC toolchain and
+   pack a mainline u-boot.bin.
+
+   Mainline U-Boot lacks the 32-byte loader header of the Sophgo U-Boot fork,
+   so fiptool.py prepends one, loaded at LOADER_2ND_BASE. LOADER_2ND_BASE must
+   therefore be CONFIG_TEXT_BASE - 0x20 (0x80200000).
+
+   The FSBL also needs the board memory map header, cvi_board_memmap.h,
+   generated from memmap.py with mmap_conv.py. Example:
+
+.. code-block:: console
+
+   git clone https://github.com/riscv/meta-riscv.git
+   git clone -b sg200x-dev https://github.com/sophgo/fsbl.git
+   cd fsbl
+   git am ../meta-riscv/recipes-bsp/milkv-duo-fsbl/milkv-duo-fsbl/*.patch
+   python3 ../meta-riscv/recipes-bsp/milkv-duo-fsbl/milkv-duo-fsbl/mmap_conv.py \
+       --type h \
+       ../meta-riscv/recipes-bsp/milkv-duo-fsbl/milkv-duo-fsbl/milkv-duos/memmap.py \
+       plat/cv181x/include/cvi_board_memmap.h
+   make CROSS_COMPILE=<riscv64 toolchain prefix> \
+       ARCH=riscv BOOT_CPU=riscv CHIP_ARCH=cv181x DDR_CFG=ddr3_1866_x16 \
+       LDFLAGS=--no-warn-rwx-segments \
+       MONITOR_PATH=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin \
+       LOADER_2ND_PATH=<U-Boot-dir>/u-boot.bin \
+       LOADER_2ND_BASE=0x80200000
+
+This will generate build/cv181x/fip.bin.
+
+4. Place the generated fip.bin file into the FAT partition of the SD card.
+
+5. Set the board's boot core selection switch to the RV (RISC-V) position.
+
+6. Insert the SD card into the board and power it on.
+
+The board will automatically execute the FSBL from the fip.bin file.
+Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
+U-Boot.
+
+[1]: https://github.com/sophgo/fsbl
+
+[2]: https://github.com/riscv-software-src/opensbi/releases/tag/v1.5
+
+[3]: https://github.com/riscv/meta-riscv/tree/master/recipes-bsp/milkv-duo-fsbl
+
+[4]: https://github.com/milkv-duo/duo-buildroot-sdk-v2
+
+Sample boot log from Milk-V Duo S board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: none
+
+  U-Boot 2027.01-rc2 (Nov 25 2026 - 09:07:47 -0300) milkv_duo_s
+
+  DRAM:  512 MiB
+  Core:  30 devices, 14 uclasses, devicetree: separate
+  MMC:   mmc@4310000: 0, mmc@4320000: 2, mmc@4300000: 1
+  Loading Environment from nowhere... OK
+  In:    serial@4140000
+  Out:   serial@4140000
+  Err:   serial@4140000
+  Net:
+  Warning: ethernet@4070000 (eth0) using random MAC address - 4e:bb:60:96:fc:e1
+  eth0: ethernet@4070000
+  Hit any key to stop autoboot: 0
+  milkv_duo_s#

-- 
2.53.0

