Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CABCD6E67
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 13:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E0F86DD6;
	Wed, 11 Oct 2023 15:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D38D86DC4; Wed, 11 Oct 2023 15:16:45 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F08C86DB5
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 15:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp83t1697030180tucp95w4
Received: from ubuntu.. ( [111.196.129.4]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 21:16:20 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: 5q30pvLz2ift5I+l0OlX7NtlO4omO+DpfLSPdhjwvAd1kYTds6+1zPBQMlkcf
 OtLlxdZoN+00U3i2pwk7u0/oS/kPRDRz6HKfLeVvP4i+FEE5XulhDODCtk9tno+RxNRcis0
 LGfBIONPp0x0Ei3JJp0SqXZelbKJjJa+3hg+lISaXbKm9ImxYl5rdKm53x0EKU1AaAeF7Z0
 x/L2WrYDf3GUnm1pfGZLeXXZtqmndIh1hiV/3+OxXbaq/KBnOXHAUGn/wR697HRP176DluJ
 /6M5Nc/3ni9bsJqP12EeK+l623DSumwJ6Do0E82ePX0prhkwJmronO60dwIwsiaYkT9twLD
 yyxRnaW+ocISAdcTig89iYcZuwsrGBmSZ+Gf9bW9xsO6NkCH6Q=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14740807335609082950
From: Bin Meng <bmeng@tinylab.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2 9/9] qemu: riscv: Enable UFS support
Date: Wed, 11 Oct 2023 21:15:52 +0800
Message-Id: <20231011131552.14665-10-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011131552.14665-1-bmeng@tinylab.org>
References: <20231011131552.14665-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

This enables UFS support for QEMU RISC-V 'virt' machine.

Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

(no changes since v1)

 board/emulation/qemu-riscv/Kconfig | 2 ++
 doc/board/emulation/qemu-riscv.rst | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
index d56b4b5bc1..f3ee1f6e90 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -82,5 +82,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply USB_XHCI_PCI
 	imply USB_KEYBOARD
 	imply CMD_USB
+	imply UFS
+	imply UFS_PCI
 
 endif
diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
index 61137bcbf1..8a5eb1eda5 100644
--- a/doc/board/emulation/qemu-riscv.rst
+++ b/doc/board/emulation/qemu-riscv.rst
@@ -131,7 +131,13 @@ An attached disk can be emulated in RISC-V virt machine by adding::
     -drive if=none,file=riscv64.img,format=raw,id=mydisk \
     -device ide-hd,drive=mydisk,bus=ahci.0
 
-You will have to run 'scsi scan' to use it.
+or alternatively attach an emulated UFS::
+
+    -device ufs,id=ufs0 \
+    -drive if=none,file=test.img,format=raw,id=lun0 \
+    -device ufs-lu,drive=lun0,bus=ufs0
+
+You will have to run 'scsi scan' to use them.
 
 A video console can be emulated in RISC-V virt machine by removing "-nographic"
 and adding::
-- 
2.34.1

