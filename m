Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC99606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dDFU7Tsk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=kcHACtJH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2612380FA9;
	Thu, 29 Oct 2026 05:11:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C9sBB-KEZ2uQ; Thu, 29 Oct 2026 05:11:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D959E80F81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250695;
	b=CnOzXK4+kFVP2v/TG54H08XEv8j1P2OIN722CYvaMaDGXr82ytfq1Cp3bVC5lLhRrTl1
	 k0sq6gE0QZBVpbOy1EAef5UcvKondT6ulQc+M+2Lz3LjsM7OJTKWSvsC/gQnwvXRXg3sl
	 0j44K2VUCLAKdcy4+RmaMa4G/uFomVxTSyrFK12i3mnDCOl7PnTPteSLgS8UEsWxKq39w
	 DNu7L6gIdaJIEO57RnyV8L8OTuTXyrsJg9+6OefzT7SyCl2n6ISMz8LylfiM1E2Y4maSJ
	 lZLnM1tOX4Pb0E3KW1eGVfjg/lqva1qsFCZ8O7ULfF6sBK+XudkhyIReg8cy7FdPrhA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250695;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sSfucrxNDwMIZd+PINRhQfnqGnrErH1idqhHuAs7aC0=;
	b=Sv1sRWMZW4iuFElIgaJlUxMQjqwztr8d0jLKm0yzfza/kQmR1DirKPaOLZsxrlylWyav
	 rXcOKL4tCyGx94qVRxgqHZNuAyDjB4gm6TK8c9+WbGwt2NKqW3j5cPcuolBAO7HKrDY9L
	 NWZIrA2+gyRHdDDvFFR34CYc3oaV0v+tXfbmf47jfu/myWtZs3mQc/fTAwn7Ha9mYm44S
	 wxSadL28ehfZAuMO+diKgFiN+LGR8+mst/BmJMEL7PisrrcpNQwTSol1L93p9rWEbNQST
	 BNYdlUwk1L4/yyATAvctZ9kaMWd2yj/8n/uezusVjWP+vf4cGBRjwV4NvjN3XbhqdCA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=kcHACtJH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250695;
	bh=sSfucrxNDwMIZd+PINRhQfnqGnrErH1idqhHuAs7aC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dDFU7TskZRpVCnAiaQ+5T+HHbbL7+7l30jtMpb2iN0t4fesi8VydckZ01+XAFsEp3
	 XOWq0kGW7t9TwqTPxHCq5DrlaaLa+AG4t9BtTCW2ci5n1ovR4fZs5JB2pK6Au31o4Q
	 07bJQSTAVBhBjsoW2ILilTQijS0Nj4+STUYztWU/kRdZQ2IGnx0A6jIGS+rFimTVy4
	 wt/72rZK7z5MdSt19THgTcS8GUjtv5TcTkWMzCbCpV3q6E4KH0fq8kV8sgCvI3bQ30
	 fSpIfSpRJphzzgB+mu4UhvBO98+D7DZylb/r2/66AxPSLNjx7N7I+nbmDTvEEIxern
	 X95lde3Q05Smg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D959E80F81;
	Thu, 29 Oct 2026 05:11:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D73C82FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8B1B80F7A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gQ3M683CsQbR for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:11:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E268380F71
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250693;
 b=I8QVwcaE4vBZlABpkELYL+iHcHKehH1/lyJKr7fX8te1JGNp9sWzn29Ko1ykzUDcM5fQ
 UL8G7sk9y0xW3MP8rUQlv1E7ox/uxLVktOR7rU8foBGAEjRUbzgpDh3t4WWiYQsadYGIm
 675GqyWW2ja3ybC16rmyd0ab41O3uyiYhudXi5fDdgrGSh1POO13BzIbgpYCHR/ubSeoS
 MC3dAhYCkyNcks0j8gOoqkg36iK+ls/yOkJJ30OzIGLnZ+NAXYUGat99zEMmMy43NMqhv
 hhK5cIAwTvXaxtj1wWOHOxzQb7neH3GffrYBmSUZocS4BYeq/JRiyWc//MmrTD+ZwRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250693;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=sSfucrxNDwMIZd+PINRhQfnqGnrErH1idqhHuAs7aC0=;
 b=Lj8NYr+NC/Bnad8bkzGGs/nT0qPVDbC9MHfyP4gm0tDqaiHHWDauciHKH8wceoziqaCT
 rYxXNB0bXuaTvnjiBkBhgm7dbVeqk94+zGanu8tP7unLwoocO0kB1VojOPy4G7XwvXmHy
 QuFlw2SA/yBaMK+nQzFRLveifW4lQR8woJsZWMBpmN8eCXRn8gSiqs5wQ1jXL0UDfB/fY
 GvQMNwtnIwC6XMtjcqZi0Uj/9akXWdw/JB6GnajwSf/ks75obJbbl2Hq3Wkt1dDDVrE9J
 NcHZuoThHSdj8CCWfyynUaZEAk5PaXx268ibigiPxf+P+W6AJAc+vDXST76bVwzp0Ag==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=kcHACtJH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=kcHACtJH
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E268380F71
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250685; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PvIiQ8OmFrM/phZotf+SR95pdw+/4vC8+dwqH2i1bVie5irmLFrhfCe1CqwH8bukC2G4UJ/NT3NdQPC4Ko/W4HIN9AdMgj7V6UvxGo9WCAjhSiLozXAJHQywLESRtmEqMw4FixO7WFE2jF+C+ym0PJX7XVVVQq9EalFq7RB3mLg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250685;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=sSfucrxNDwMIZd+PINRhQfnqGnrErH1idqhHuAs7aC0=; 
 b=JLIBFmgg4mxd4vJhFtDg8crt9pvYgWAq5Hz5RPLEaVskLhhQVzxl8S26EvCGITh+KodfT3Dj/iaC/scLIPFYrBdwfCHQ7+67xr4WDb24CmgrlYjwZ7MQzmiJgVpMkyW6qqC8aU/U6C6kCt7evAFahzfp0Ve2itgFloygcdUVVsA=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=kcHACtJHxX9Ekw7sYHARQ3iBu+q2Pd5tu+w7HF1DCvQbZCX9CmEMUH7JO/+3ThFgdW7WnLDEC1uqyvXmRrUsd0LwtSpctVy9by69jW04veQqPV3WDdbEyga+OdBc3SRqNr5yFEBxSOX+1gumXeF4X/Ntziv8lIVgfLhhwXZUMFc=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=sSfucrxNDwMIZd+PINRhQfnqGnrErH1idqhHuAs7aC0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250683803968.2574943260937;
 Wed, 28 Oct 2026 22:11:23 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 15/20] board: emulation: Add qemu-loongarch
Date: Thu, 29 Oct 2026 05:07:32 +0000
Message-ID: <20261029050738.1107663-16-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Yet another generic QEMU VIRT machine.

LoongArch QEMU splits the main RAM into two parts: the first 512M is
placed at 0x0, and the rest is placed at 0x8000000. FDT locates at
0x100000. BIOS is mapped to the first flash mapped to 0x1c000000, where
U-Boot starts execution.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v4

Changed from v3
- Remove the dummy empty devicetree
- Fix the typo when limiting top usable RAM address top (0x1000_0000 ->
  0x1_0000_0000)

Changed from v2
- Add board-level documentation for qemu-loongarch
- Mention the memory layout and booting process in commit message
- Move TARGET_QEMU_LOONGARCH_VIRT to
  board/emulation/qemu-loongarch/Kconfig
- Drop duplicated selection of BOARD_LATE_INIT in
  TARGET_QEMU_LOONGARCH_VIRT
- Explain why RAM is limited to the lowest 4GiB
- Drop unused board_init()
- Rework comment in board_fdt_blob_setup()
- Define FDT address, 0x100000, as a meaningful constant
- Clarify how CFG_SYS_INIT_RAM_[ADDR,SIZE] are chosen
- Add myself to MAINTAINERS

Changed from v1
- Remove dynamic setup for environment variables
---
 arch/loongarch/Kconfig                        |  4 ++
 board/emulation/qemu-loongarch/Kconfig        | 68 +++++++++++++++++++
 board/emulation/qemu-loongarch/MAINTAINERS    |  9 +++
 board/emulation/qemu-loongarch/Makefile       |  6 ++
 .../emulation/qemu-loongarch/qemu-loongarch.c | 67 ++++++++++++++++++
 .../qemu-loongarch/qemu-loongarch.env         |  5 ++
 configs/qemu-loongarch64_defconfig            | 35 ++++++++++
 doc/board/emulation/index.rst                 |  1 +
 doc/board/emulation/qemu-loongarch.rst        | 39 +++++++++++
 include/configs/qemu-loongarch.h              | 17 +++++
 10 files changed, 251 insertions(+)
 create mode 100644 board/emulation/qemu-loongarch/Kconfig
 create mode 100644 board/emulation/qemu-loongarch/MAINTAINERS
 create mode 100644 board/emulation/qemu-loongarch/Makefile
 create mode 100644 board/emulation/qemu-loongarch/qemu-loongarch.c
 create mode 100644 board/emulation/qemu-loongarch/qemu-loongarch.env
 create mode 100644 configs/qemu-loongarch64_defconfig
 create mode 100644 doc/board/emulation/qemu-loongarch.rst
 create mode 100644 include/configs/qemu-loongarch.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1f376ca291c1..a53d26a59497 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -7,9 +7,13 @@ config SYS_ARCH
 choice
 	prompt "Target select"
 
+config TARGET_QEMU_LOONGARCH_VIRT
+	bool "Support QEMU Virt Board"
+
 endchoice
 
 # board-specific options below
+source "board/emulation/qemu-loongarch/Kconfig"
 
 # platform-specific options below
 source "arch/loongarch/cpu/generic/Kconfig"
diff --git a/board/emulation/qemu-loongarch/Kconfig b/board/emulation/qemu-loongarch/Kconfig
new file mode 100644
index 000000000000..94f42091e0be
--- /dev/null
+++ b/board/emulation/qemu-loongarch/Kconfig
@@ -0,0 +1,68 @@
+if TARGET_QEMU_LOONGARCH_VIRT
+
+config SYS_BOARD
+	default "qemu-loongarch"
+
+config SYS_VENDOR
+	default "emulation"
+
+config SYS_CPU
+	default "generic"
+
+config SYS_CONFIG_NAME
+	default "qemu-loongarch"
+
+config TEXT_BASE
+	default 0x1c000000
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select GENERIC_LOONGARCH
+	imply AHCI
+	imply PCI_INIT_R
+	imply CMD_PCI
+	imply CMD_POWEROFF
+	imply CMD_SCSI
+	imply CMD_PING
+	imply CMD_EXT2
+	imply CMD_EXT4
+	imply CMD_FAT
+	imply CMD_FS_GENERIC
+	imply DOS_PARTITION
+	imply ISO_PARTITION
+	imply EFI_PARTITION
+	imply SCSI_AHCI
+	imply AHCI_PCI
+	imply E1000
+	imply PCI
+	imply NVME_PCI
+	imply PCIE_ECAM_GENERIC
+	imply DM_RNG
+	imply DM_RTC
+	imply QFW
+	imply QFW_MMIO
+	imply SCSI
+	imply SYS_NS16550
+	imply SYSRESET
+	imply SYSRESET_CMD_POWEROFF
+	imply SYSRESET_SYSCON
+	imply VIRTIO_MMIO
+	imply VIRTIO_PCI
+	imply VIRTIO_NET
+	imply VIRTIO_BLK
+	imply MTD_NOR_FLASH
+	imply CFI_FLASH
+	imply OF_HAS_PRIOR_STAGE
+	imply VIDEO
+	imply VIDEO_BOCHS
+	imply SYS_WHITE_ON_BLACK
+	imply USB
+	imply USB_XHCI_HCD
+	imply USB_XHCI_PCI
+	imply USB_KEYBOARD
+	imply CMD_USB
+	imply UFS
+	imply UFS_PCI
+	imply BOARD_LATE_INIT
+
+endif
diff --git a/board/emulation/qemu-loongarch/MAINTAINERS b/board/emulation/qemu-loongarch/MAINTAINERS
new file mode 100644
index 000000000000..cd9636d6dc9b
--- /dev/null
+++ b/board/emulation/qemu-loongarch/MAINTAINERS
@@ -0,0 +1,9 @@
+QEMU LOONGARCH 'VIRT' BOARD
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+M:	Yao Zi <me@ziyao.cc>
+S:	Maintained
+F:	board/emulation/qemu-loongarch/
+F:	board/emulation/common/
+F:	include/configs/qemu-loongarch.h
+F:	configs/qemu-loongarch64_defconfig
+F:	doc/board/emulation/qemu-loongarch.rst
diff --git a/board/emulation/qemu-loongarch/Makefile b/board/emulation/qemu-loongarch/Makefile
new file mode 100644
index 000000000000..a928b90780e9
--- /dev/null
+++ b/board/emulation/qemu-loongarch/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
+#
+
+obj-y	+= qemu-loongarch.o
diff --git a/board/emulation/qemu-loongarch/qemu-loongarch.c b/board/emulation/qemu-loongarch/qemu-loongarch.c
new file mode 100644
index 000000000000..9370e81bc276
--- /dev/null
+++ b/board/emulation/qemu-loongarch/qemu-loongarch.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <env.h>
+#include <fdtdec.h>
+#include <image.h>
+#include <linux/sizes.h>
+#include <lmb.h>
+#include <log.h>
+#include <spl.h>
+#include <init.h>
+#include <usb.h>
+#include <virtio_types.h>
+#include <virtio.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define VIRT_FDT_BASE 0x100000
+
+#if IS_ENABLED(CONFIG_MTD_NOR_FLASH)
+int is_flash_available(void)
+{
+	if (!ofnode_equal(ofnode_by_compatible(ofnode_null(), "cfi-flash"),
+			  ofnode_null()))
+		return 1;
+
+	return 0;
+}
+#endif
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	/*
+	 * Limit RAM used by U-Boot to 4GiB to keep compatible with 32-bit-only
+	 * DMA peripherals, for example, emulated PCI cards.
+	 */
+	if (gd->ram_top > 0x100000000ULL)
+		return 0x100000000ULL;
+
+	return gd->ram_top;
+}
+
+int board_late_init(void)
+{
+	/* start usb so that usb keyboard can be used as input device */
+	if (CONFIG_IS_ENABLED(USB_KEYBOARD))
+		usb_init();
+
+	/*
+	 * Make sure virtio bus is enumerated so that peripherals
+	 * on the virtio bus can be discovered by their drivers
+	 */
+	virtio_init();
+
+	return 0;
+}
+
+int board_fdt_blob_setup(void **fdtp)
+{
+	/* QEMU stores the DTB to 0x100000 */
+	*fdtp = (void *)VIRT_FDT_BASE;
+	return 0;
+}
diff --git a/board/emulation/qemu-loongarch/qemu-loongarch.env b/board/emulation/qemu-loongarch/qemu-loongarch.env
new file mode 100644
index 000000000000..7655f26d8d6b
--- /dev/null
+++ b/board/emulation/qemu-loongarch/qemu-loongarch.env
@@ -0,0 +1,5 @@
+stdin=serial,usbkbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+
+boot_targets=qfw usb scsi virtio nvme dhcp
diff --git a/configs/qemu-loongarch64_defconfig b/configs/qemu-loongarch64_defconfig
new file mode 100644
index 000000000000..5d5ae44f8e56
--- /dev/null
+++ b/configs/qemu-loongarch64_defconfig
@@ -0,0 +1,35 @@
+CONFIG_LOONGARCH=y
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=8
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DM_RESET=y
+CONFIG_SYS_LOAD_ADDR=0x02000000
+CONFIG_SHOW_REGS=y
+# CONFIG_OF_BOARD_FIXUP is not set
+CONFIG_SYS_PCI_64BIT=y
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS_SUBST=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_2048=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_SYSBOOT=y
+CONFIG_CMD_QFW=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_BLKMAP=y
+CONFIG_EFI_MEDIA=y
+CONFIG_DM_MMC=y
+CONFIG_DM_MTD=y
+CONFIG_FLASH_SHOW_PROGRESS=0
+CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_PCI_REGION_MULTI_ENTRY=y
+CONFIG_DM_REBOOT_MODE=y
+CONFIG_RESET_SYSCON=y
+CONFIG_HEXDUMP=y
diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index 5d0dd83d8aca..a142cd3360ac 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -11,6 +11,7 @@ Emulation
    network
    video
    qemu-arm
+   qemu-loongarch
    qemu-mips
    qemu-ppce500
    qemu-riscv
diff --git a/doc/board/emulation/qemu-loongarch.rst b/doc/board/emulation/qemu-loongarch.rst
new file mode 100644
index 000000000000..0d97dc7df797
--- /dev/null
+++ b/doc/board/emulation/qemu-loongarch.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (C) 2026 Yao Zi <me@ziyao.cc>
+
+QEMU LoongArch
+==============
+
+QEMU for LoongArch supports a special 'virt' machine designed for emulation
+and virtualization purpose. This document describes how to run U-Boot under it.
+Only 64-bit LoongArch is supported at this time.
+
+The 'virt' platform provides the following as the basic functionality:
+
+    - A freely configurable amount of CPU cores
+    - U-Boot loaded and executing in the emulated flash, mapped to 0x1c000000.
+    - A generated device tree blob placed at 0x100000.
+    - A freely configurable amount of RAM, described by the DTB, starting at
+      0x0. RAM above 512MiB is placed at 0x80000000.
+    - A NS16550A serial port, discoverable via the DTB.
+    - An in-core constant frequency timer.
+    - syscon-reboot and syscon-poweroff for powering off and rebooting the
+      system.
+    - A generic ECAM-based PCI host controller, discoverable via the DTB.
+
+Additionally, a number of optional peripherals can be added to the PCI bus.
+
+See :doc:`../../develop/devicetree/dt_qemu` for information on how to see the
+devicetree actually generated by QEMU.
+
+Building and Running
+--------------------
+
+Set the CROSS_COMPILE environment variable as usual, and run::
+
+    make qemu-loongarch64_defconfig
+    make
+
+The minimal QEMU command line to get U-Boot up and running is::
+
+    qemu-system-loongarch64 -M virt -nographic -bios u-boot.bin
diff --git a/include/configs/qemu-loongarch.h b/include/configs/qemu-loongarch.h
new file mode 100644
index 000000000000..7103dc1b02ef
--- /dev/null
+++ b/include/configs/qemu-loongarch.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+/*
+ * LoongArch QEMU always places a part of the RAM at 0x0. These options are only
+ * intended to specify the initial stack pointer address, and can be replaced
+ * with CUSTOM_SYS_INIT_SP_ADDR when it's supported in the future.
+ */
+#define CFG_SYS_INIT_RAM_ADDR	0x0
+#define CFG_SYS_INIT_RAM_SIZE	0x80000
+
+#endif
-- 
2.56.0

