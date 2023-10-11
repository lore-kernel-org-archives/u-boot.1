Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5327CD6E64
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 13:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E62B86E86;
	Wed, 11 Oct 2023 15:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134A086E08; Wed, 11 Oct 2023 15:07:12 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD1C86E1A
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 15:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp78t1697029562tycr655r
Received: from ubuntu.. ( [111.196.129.4]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 21:06:02 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: 90EFqYDyPxDBW2LafaqRugPVicZiqydm3qELRZJ18SuihL0n/qJbblUNVrjJ5
 xBY1NUJIOI4vFxscxEAcauOA8mrYBakBiG9Eo9+0kVEZ7yKHzO1+SfS4BMr1moZywsM34wc
 U6lm65RRy2h9jjPzft3jHFM40/XUzIscEdC4qkWP6hNJnSwfYxySOOIXbUYCX7FbQSh4S2p
 T8P3MDuAG91kQgIUSU36Y1jIVr00ABUfhBg8NIyrSZxpL96r7Ur0sWXGYgdVNmXF8lK/N18
 FrKKnJQM9AgRfvcM7pLhxxnL2YF9RLTcYYQaqoBnWacdpnQrQJd0eDSWMVRFyt5pN9lpKRx
 aWzId712z7rmvkD1JjpHGJUhdh8nbmInqyOYArz
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18444544956873560644
From: Bin Meng <bmeng@tinylab.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH 9/9] qemu: riscv: Enable UFS support
Date: Wed, 11 Oct 2023 21:05:35 +0800
Message-Id: <20231011130535.3964-10-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011130535.3964-1-bmeng@tinylab.org>
References: <20231011130535.3964-1-bmeng@tinylab.org>
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

