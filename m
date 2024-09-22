Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB97CF9C69
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 20:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7630488BF9;
	Sun, 22 Sep 2024 22:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=at.encryp.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=at.encryp.ch header.i=@at.encryp.ch header.b="RtipnWT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A9F889B3; Sun, 22 Sep 2024 12:11:12 +0200 (CEST)
Received: from cheems.de.box.skhron.com.ua (cheems.de.box.skhron.com.ua
 [IPv6:2a01:4f8:231:76a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D5188279
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 12:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=at.encryp.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lekkit@at.encryp.ch
From: lekkit@at.encryp.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=at.encryp.ch;
 s=20240721-cheems-de-box-skhron-com-ua; t=1726999870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zhc5AYN4Zv4vIhutze8A0EUJ4ZXIsBnJmLm3i6aHAkw=;
 b=RtipnWT4OkIG2LXDuyF2oKhPXTVzbxe6v9zJpI260hyNIGL7L5b3ufljIx+2rd4HCkwX2g
 fGtZFJYatA3Pety3osL5pSuTV8rjFvSLNlR2iV8EQB0einzQjUi56fXfx5B6rL7SRC7yOL
 iPHxFNCDx3179CmF++Smtz50tpg/tIaQQxf+gTv5mY7AaG1TFmvpkYHTz/m7I8TobUI34Q
 OkYc7+fzOS5CTT5zI/mm+02XwCYp3HY3icreBVCDXBnnbFWNARBtfGfyZ8gBbQ2OtwTpVw
 +gRSrk7+z/KqASWwiQYCkNrXsswPcc35qBk/gisXq7X5Xof1TikDthR7T/8FGA==
To: u-boot@lists.denx.de
Cc: nyandarknessgirl@gmail.com
Subject: [PATCH 1/3] riscv: qemu: Enable booting from NVMe
Date: Sun, 22 Sep 2024 13:11:00 +0300
Message-ID: <20240922101102.7010-1-lekkit@cheems.de.box.skhron.com.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Sep 2024 22:14:37 +0200
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

From: LekKit <50500857+LekKit@users.noreply.github.com>

QEMU supports NVMe devices, but U-Boot only tries to boot from Virtio.
This is problematic when explicitly using NVMe, so fix that.

Additionally, RVVM virtual machine is almost fully compatible with QEMU,
except it only implements NVMe drives instead of VirtIO.
---
 include/configs/qemu-riscv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/qemu-riscv.h b/include/configs/qemu-riscv.h
index 2f594bfc..cf4fcb90 100644
--- a/include/configs/qemu-riscv.h
+++ b/include/configs/qemu-riscv.h
@@ -22,6 +22,7 @@
 					"stderr=serial,vidconsole\0"
 
 #define BOOT_TARGET_DEVICES(func) \
+	func(NVME, nvme, 0) \
 	func(VIRTIO, virtio, 0) \
 	func(VIRTIO, virtio, 1) \
 	func(SCSI, scsi, 0) \
-- 
2.46.0

