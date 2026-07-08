Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8640C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 06:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB9684118;
	Wed,  8 Jul 2026 08:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="pScJUAbK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rPcj1Sqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1558497A; Wed,  8 Jul 2026 08:30:18 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3FE7838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 08:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregor.herburger@linutronix.de
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1783492216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bYEbUkMuSPMw1ivav/ezjCZ73ZChD1oxcsPKmpUfugk=;
 b=pScJUAbK9FFo3UxQuv/79xmWOqVgyjDx/OxsbmzmWkvuiEi9O71mMWTS0vfEJKCnf8rv8z
 vx2EjE4ecPysdCEdZc22Sa77fogHauQk+eItwlRUf7fwZvhbFjTAvGpVGL4Jr5R6amx9QC
 kG5CVkR5QtJGPb2a8W/FxmIaVJIaOoaTANh7BVbZklg9O9TxQg75XG5Pr9SWq99PAlSSrX
 hiTd4/cj62PGkbahBrUrvkS0gnqWr4UTL1BPwFxocXe2Rs7qYTJd3Fut7/qgxtU1vtru/8
 TtOUbl09GiCc/TlmvIo+KjOqMqF5DG05gxmr5U/6tZ+UpQIf/DJ93+wxRPkhZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1783492216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bYEbUkMuSPMw1ivav/ezjCZ73ZChD1oxcsPKmpUfugk=;
 b=rPcj1SqvMPSeVRMCAfPhbQE7eq3/N9N0CafEmuCNRFD4a/j08QlEU4LOjuoaGDYY5V9SXU
 1zyAkrYYwUi6JlCQ==
Date: Wed, 08 Jul 2026 08:30:11 +0200
Subject: [PATCH] rpi: copy /chosen/bootloader partition and set boot_partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-tryboot-v1-1-13a14aeacf71@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAHPuTWoC/yXMQQ5AMBCF4avIrDVppUFcRSzaMRgLlbaEiLsrl
 l/yv3dBIM8UoMku8LRzYLckqDwDnMwykuA+GQpZlLKStYj+tM5FgUoZo7UdFCKkevU08PE9td3
 vsNmZML5zuO8HNyUpLmsAAAA=
X-Change-ID: 20260708-tryboot-c11aa44bf1cc
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783492216; l=1860;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=cZmE6y01PcJ289qFW80z5Vp3p3QlVn5K9HoV0qr0fgc=;
 b=KpcIeU5vKjC29U7wG7ZvTmF43+93sWEQsjHH4L5wOo3OCqA4us1OtCycfUmGg9VnsuCk39Wmo
 L2wxMOxGbQDCSWf2zh5s5HuOvGUQV7QPGyEXtnRbRh1vde5wzEss9jr
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
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

The Raspberry Pi has the "tryboot" feature where it can boot from a
different partition enabling failsafe A/B updates. After boot the
firmware sets 'partition' property in /chosen/bootloader. Copy this
property to the device tree and set the env variable boot_partition.
This allows boards to create a bootcmd based on the boot partition.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 board/raspberrypi/rpi/rpi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 1da5df92351..7a2ff646ac8 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -480,6 +480,20 @@ static void set_serial_number(void)
 	env_set("serial#", serial_string);
 }
 
+static void set_boot_partition_fdt(void)
+{
+	void *fdtp = (void *)gd->fdt_blob;
+	u32 partition;
+
+	partition = fdt_getprop_u32_default(fdtp, "/chosen/bootloader", "partition", 1);
+	if (!partition) {
+		printf("Failed to the get partition property.\n");
+		return;
+	}
+
+	env_set_ulong("boot_partition", partition);
+}
+
 int misc_init_r(void)
 {
 	set_fdt_addr();
@@ -489,6 +503,7 @@ int misc_init_r(void)
 	set_board_info();
 #endif
 	set_serial_number();
+	set_boot_partition_fdt();
 
 	return 0;
 }
@@ -641,6 +656,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
 
 	/* copy uart clk as provided by the firmware */
 	copy_property(fdt, fw_fdt, "/clocks/clk-uart", "clock-frequency");
+
+	/* Copy the boot partition */
+	copy_property(fdt, fw_fdt, "/chosen/bootloader", "partition");
 }
 
 int ft_board_setup(void *blob, struct bd_info *bd)

---
base-commit: ee5d46b45ec0c63f8f9dd1e816e0dac3452ccc3d
change-id: 20260708-tryboot-c11aa44bf1cc

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

