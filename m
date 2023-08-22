Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47EAEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24CA6864E9;
	Tue, 22 Aug 2023 14:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GZXPidEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD00586497; Tue, 22 Aug 2023 14:10:53 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B68864F3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso1863424f8f.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692706250; x=1693311050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28//zdq3a/rD0P+QP8DGa5xmSp6ePfq8ZZN/sJ7f7VM=;
 b=GZXPidEYtBZdjfua2AZROOulsqTNlNGmQdgyWXLjFJ69OhlNrlVAjt4fGCYmGYtQwh
 q9Y2f0Ytfmog7SZhe0rFehaptSITdrvjEcv84AB56g3NzFKfF1bdMgzyBoux9qRdyA3G
 3M+aL7SGCAjeX8ENydXo/IrSkGE003SExAvErXgtBQjQNBcWH+3c0FetLEFnpbX/iDcP
 WIQHNMNyzdECjRa9J6jf6/XVgak009oWtjuCVH2+D5gWRLsW0/KyUVxEhHkx+02Plos0
 /IjWXYqJ/zrMdvpp3ODqZIkjBqfQJ8I9mcaQsLflNVI6qKGxEEhW/91bIMlWaXKdBo5A
 6S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692706250; x=1693311050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=28//zdq3a/rD0P+QP8DGa5xmSp6ePfq8ZZN/sJ7f7VM=;
 b=JurenZgF0aIUokbUJJVcSrDS7JON7uBIJUN342NWNY5A/2djI6IL3P14TRqM0rR2h3
 5GgvNemi2eluwJ/p9GHxd1/Xn3hKZMhm58lyRgzOxyJDUNkeQyBuFHYMWoJdMjtBPlvf
 dxzdz87+8LoeRS5pLmUFM5DObB9tnLgOAF9HvEVpStY6HiKs+XCm18Tkq1DeE7IbGa6K
 9FY5vNwku7oMNEnP82aGsML1Z/kFU7+t8nWEaC5B1dgFWNgoNzGSXah9MSBrcnDCJP8u
 JxVEvjclIm+/JnAUD6SWy8brsHqH+Xhe5LC7RQldwmEC/n0SL7Lgmxk+kHy+ACJd+Vep
 spuw==
X-Gm-Message-State: AOJu0Yy0QdJqGcaSRRez1TtfmMnjVG895vgyUOsjs6a25uBZbJilc4ls
 wCuWcpZd1Cs/xun1RgI7wCkLvGMI/vY=
X-Google-Smtp-Source: AGHT+IFzFXSxrRpPzvBi9ct/CTCbtFdZlGaaKTt4izCksu8kBFpsfSAUG0bisbs/ykJmZfuzagqp6w==
X-Received: by 2002:adf:fed0:0:b0:319:7537:b454 with SMTP id
 q16-20020adffed0000000b003197537b454mr6337941wrs.28.1692706249882; 
 Tue, 22 Aug 2023 05:10:49 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 a2-20020adffac2000000b0031753073abcsm15704611wrs.36.2023.08.22.05.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 05:10:49 -0700 (PDT)
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
Subject: [PATCH v2 5/7] arm: qemu: Enable ramfb by default
Date: Tue, 22 Aug 2023 15:10:23 +0300
Message-Id: <20230822121026.1007105-6-alpernebiyasak@gmail.com>
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
by default in the ARM QEMU targets. That way, you can easily use a
graphical console by just passing -device ramfb to the QEMU command line.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
[Alper: Rebase on bochs changes, add pre-reloc init, error handling]
Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v2:
- Rebase on "qemu: arm: Enable Bochs, console buffering, USB keyboard"
- Drop env changes from ARM (necessary but in prerequisite series)
- Drop imply VIDEO, SYS_CONSOLE_IN_ENV changes from ARM (in prereq.)
- Probe QFW in ARM QEMU board_early_init_f to bind ramfb pre-reloc
- Add IS_ENABLED(CONFIG_QFW) check and error handling to ARM QEMU

 arch/arm/Kconfig                    |  3 +++
 board/emulation/qemu-arm/qemu-arm.c | 41 +++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1fd3ccd1607f..7afe26ac804f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1046,6 +1046,9 @@ config ARCH_QEMU
 	imply USB_XHCI_PCI
 	imply USB_KEYBOARD
 	imply CMD_USB
+	imply VIDEO_RAMFB
+	imply BOARD_EARLY_INIT_F
+	imply BOARD_EARLY_INIT_R
 
 config ARCH_RMOBILE
 	bool "Renesas ARM SoCs"
diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 942f1fff5717..23ef31cb7feb 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -11,6 +11,7 @@
 #include <fdtdec.h>
 #include <init.h>
 #include <log.h>
+#include <qfw.h>
 #include <usb.h>
 #include <virtio_types.h>
 #include <virtio.h>
@@ -102,6 +103,46 @@ static struct mm_region qemu_arm64_mem_map[] = {
 struct mm_region *mem_map = qemu_arm64_mem_map;
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
 	return 0;
-- 
2.40.1

