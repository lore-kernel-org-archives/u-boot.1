Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB19EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6912A864F8;
	Tue, 22 Aug 2023 14:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nclRN+Ct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDDDC864F7; Tue, 22 Aug 2023 14:10:54 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 601A8864E2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fee06efd6bso18862815e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692706252; x=1693311052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGoQ4jNs+N/QlQ+g76Ew8n/gmPoZlQSS+BRhjyXWnbw=;
 b=nclRN+CtMV0Q0oxln7YLW2r24k/7h/6R5wHeSTz8ZAPlSsCUHe0YB5Fm/EH3d2369j
 cht64UVvzvilFRlv4rznOlMNtf/rbiRVwU2OJJHao+oDuYol/n1xMco1GonHXALZRaA4
 vOPzEFeTmPM8rAvnHu582lKDiWonlDMIyUradqB7nwS6t/rwm/CXy1efOa11+BMLNUAM
 tkwJuw8wuQ9luERJ6v9IsR9xOcx77odWMEfN7HUQEKP/NNuW2GrswNCfd6rnJodxQc5i
 Be5MJIhhVhYIyWBVZOcA5Ln46IYm3HyZKrdv2yzkx8hnk4/5rbfo0tmnvKzWzd/h/n5M
 G95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692706252; x=1693311052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGoQ4jNs+N/QlQ+g76Ew8n/gmPoZlQSS+BRhjyXWnbw=;
 b=Myb6YAyY62PNqsDNlqGjgli978JpGgB4CfFNP6FLp7+YWhJoPEs28O1UK36/sQAfca
 /EAKiHh/W8f0XBjLUbeeWEUuOuEmhu68b3mDq22P9ma3lY+qzaoNJxpWMGWurEx+wmhp
 EmeebDCJIS4XgDFmb/8FtvbUSaIlRYMD2unCdtH2sGg1HJ5sCWTr3D4YtF8iik75J522
 QTfxO1BWR7pZehzwKLS8NhCD0pAIGtIDpWDyCV0HPN7zieWZVuc5rMlfmC8VWM/QYn8A
 NUEXfUf6XxeptiVfbNdTGTe0TXfAHEYxBjmEeIft8ffprQcpV7kD3vNdqNBc6tmA8FvX
 XcyQ==
X-Gm-Message-State: AOJu0YxPACK/GIE0lBZxu60NAnzlhy2QOAjn8okLyLt/t/S9pqS0p5a8
 0qd5FroUbnvJs3cXAHpVbIVAB1cS0Rw=
X-Google-Smtp-Source: AGHT+IH54t2CEuFXoKg9hr87mvp71CZ3YyZSiWhwWYlujCI2qR5RV5K/hNJFTyd2kUVpOnd2xM4O9A==
X-Received: by 2002:adf:f74b:0:b0:319:7c17:4c65 with SMTP id
 z11-20020adff74b000000b003197c174c65mr8541000wrp.12.1692706251878; 
 Tue, 22 Aug 2023 05:10:51 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 a2-20020adffac2000000b0031753073abcsm15704611wrs.36.2023.08.22.05.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 05:10:51 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 6/7] riscv: qemu: Enable ramfb by default
Date: Tue, 22 Aug 2023 15:10:24 +0300
Message-Id: <20230822121026.1007105-7-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Alexander Graf <agraf@csgraf.de>

Now that we have everything in place to support ramfb, let's wire it up
by default in the RISC-V QEMU targets. That way, you can easily use a
graphical console by just passing -device ramfb to the QEMU command line.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
[Alper: Rebase on bochs changes, add pre-reloc init and error handling]
Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v2:
- Drop imply VIDEO, env changes from RISC-V patch (in u-boot/next)
- Drop imply SYS_CONSOLE_IS_IN_ENV from RISC-V patch (def. y if VIDEO)
- Probe QFW in RISC-V QEMU board_early_init_f to bind ramfb pre-reloc
- Add IS_ENABLED(CONFIG_QFW) check and error handling to RISC-V QEMU

 board/emulation/qemu-riscv/Kconfig      |  5 +++
 board/emulation/qemu-riscv/qemu-riscv.c | 41 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
index d56b4b5bc1ed..b5c72982e565 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -82,5 +82,10 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply USB_XHCI_PCI
 	imply USB_KEYBOARD
 	imply CMD_USB
+	imply BOARD_EARLY_INIT_F
+	imply BOARD_EARLY_INIT_R
+	imply VIDEO_RAMFB
+	imply CMD_QFW
+	imply QFW_MMIO
 
 endif
diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
index 181abbbf97d8..1041e936e9d1 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -10,6 +10,7 @@
 #include <fdtdec.h>
 #include <image.h>
 #include <log.h>
+#include <qfw.h>
 #include <spl.h>
 #include <init.h>
 #include <usb.h>
@@ -29,6 +30,46 @@ int is_flash_available(void)
 }
 #endif
 
+int board_early_init_f(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	/*
+	 * Make sure we enumerate the QEMU Firmware device to bind ramfb
+	 * so video_reserve() can reserve memory for it.
+	 */
+	if (IS_ENABLED(CONFIG_QFW)) {
+		ret = qfw_get_dev(&dev);
+		if (ret) {
+			log_err("Failed to get QEMU FW device: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int board_early_init_r(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	/*
+	 * Make sure we enumerate the QEMU Firmware device to find ramfb
+	 * before console_init.
+	 */
+	if (IS_ENABLED(CONFIG_QFW)) {
+		ret = qfw_get_dev(&dev);
+		if (ret) {
+			log_err("Failed to get QEMU FW device: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int board_init(void)
 {
 	/*
-- 
2.40.1

