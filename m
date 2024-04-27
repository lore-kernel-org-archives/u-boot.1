Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E693DC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F082388429;
	Sat, 27 Apr 2024 16:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B80i6mDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C3688524; Sat, 27 Apr 2024 16:11:29 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D0F8827F
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78f043eaee9so181588685a.3
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227084; x=1714831884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xaaJNvgO9pzLc9879o5wYmMx3xBO14hJwyAU9g3urUE=;
 b=B80i6mDNUxHiCXy+SzWz0orxh3/wmUR9Dmdhg1gKYMQfPkWkZ23olF5hBAM3E81Qtf
 +jDhtNOBZQBXiIZn2lrWNSIedTHXYfeZ7ynPyuMqRp3BYfzH5u0eHYiu6S0tJ+Ut1VQj
 sSk6YZqzA4lVHzfnPwMkSykBICVT/1G0DBkrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227084; x=1714831884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xaaJNvgO9pzLc9879o5wYmMx3xBO14hJwyAU9g3urUE=;
 b=W1jayNSIvlABbzEm6/bo3kkvcPZjMtwgmoKHt8TOv6tw6D7z3R673lfZ1b8xu7fYtw
 JqCfDtRIytAXMTM7PW5hr8F3Zf6IzNt9nqjGrr0jK83OmVpoNiibqgrO+KJPwwC1otLj
 /xZvB3ekPdTbLCzLNIEgXY9rl5dQ0B4dkeTCtyNllGml2R3H/cHabog6z23gZ5Z8PKUY
 xIPZOPJzMNwyqiD+azOdj35VTVIaNR0YmiPdF12DJUwVuTxkyrED0lUy3cqHA4X+NXl6
 zCH69ZJwTYhHjTEJYPSSwcQixyybXRcAxdG29DH7069XZFU/kqepwTs88FjHXifZMO+K
 67Yw==
X-Gm-Message-State: AOJu0YxmBly4wRartLLteBZ4/XU8AJtE7TdOylj2lk+4B5ArBQ42YDh9
 Vdm/etQfFq2pe/XWmBX+LhLfnKvWcSgj7CW2apGKJO7MGiKnwxy+L3fqpv67RLUy8MwGW7p9tfh
 +5Rp8Qw==
X-Google-Smtp-Source: AGHT+IFhZbuCLn8+8gEjLJbxTVtuFTaNA6PQc7tBaQ+7zp4E7xEZXy2EEFRFjs7O2z9UF+UIUGLD9A==
X-Received: by 2002:a05:620a:611b:b0:790:8c77:19b9 with SMTP id
 oq27-20020a05620a611b00b007908c7719b9mr5862478qkn.45.1714227082612; 
 Sat, 27 Apr 2024 07:11:22 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 10/18] test: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:10:58 -0600
Message-Id: <20240427141106.3406000-11-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
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

Remove <common.h> from all "test/" files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/adc.h                 | 2 ++
 include/audio_codec.h         | 2 ++
 include/axi.h                 | 2 ++
 include/bootmeth.h            | 2 ++
 include/bootstd.h             | 2 ++
 include/cedit.h               | 3 +++
 include/dm/test.h             | 2 ++
 test/bloblist.c               | 1 -
 test/boot/bootdev.c           | 1 -
 test/boot/bootflow.c          | 1 -
 test/boot/bootmeth.c          | 1 -
 test/boot/bootstd_common.c    | 1 -
 test/boot/cedit.c             | 1 -
 test/boot/expo.c              | 1 -
 test/boot/image.c             | 1 -
 test/boot/measurement.c       | 1 -
 test/boot/vbe_fixup.c         | 1 -
 test/boot/vbe_simple.c        | 1 -
 test/bootm.c                  | 1 -
 test/cmd/addrmap.c            | 1 -
 test/cmd/armffa.c             | 1 -
 test/cmd/bdinfo.c             | 1 -
 test/cmd/exit.c               | 1 -
 test/cmd/fdt.c                | 1 -
 test/cmd/font.c               | 1 -
 test/cmd/history.c            | 1 -
 test/cmd/loadm.c              | 1 -
 test/cmd/mem.c                | 1 -
 test/cmd/mem_search.c         | 1 -
 test/cmd/pci_mps.c            | 1 -
 test/cmd/pinmux.c             | 1 -
 test/cmd/rw.c                 | 1 -
 test/cmd/seama.c              | 1 -
 test/cmd/setexpr.c            | 1 -
 test/cmd/temperature.c        | 1 -
 test/cmd/test_echo.c          | 1 -
 test/cmd/test_pause.c         | 1 -
 test/cmd/wget.c               | 1 -
 test/cmd_ut.c                 | 2 +-
 test/command_ut.c             | 1 -
 test/common/cmd_ut_common.c   | 1 -
 test/common/cread.c           | 2 +-
 test/common/cyclic.c          | 1 -
 test/common/event.c           | 1 -
 test/common/test_autoboot.c   | 1 -
 test/compression.c            | 1 -
 test/dm/acpi.c                | 1 -
 test/dm/acpi_dp.c             | 1 -
 test/dm/acpigen.c             | 1 -
 test/dm/adc.c                 | 1 -
 test/dm/audio.c               | 1 -
 test/dm/axi.c                 | 1 -
 test/dm/blk.c                 | 1 -
 test/dm/blkmap.c              | 1 -
 test/dm/bootcount.c           | 1 -
 test/dm/bus.c                 | 1 -
 test/dm/button.c              | 1 -
 test/dm/cache.c               | 1 -
 test/dm/clk.c                 | 1 -
 test/dm/clk_ccf.c             | 1 -
 test/dm/core.c                | 1 -
 test/dm/cpu.c                 | 1 -
 test/dm/cros_ec.c             | 1 -
 test/dm/cros_ec_pwm.c         | 1 -
 test/dm/devres.c              | 1 -
 test/dm/dma.c                 | 1 -
 test/dm/dsi_host.c            | 1 -
 test/dm/efi_media.c           | 1 -
 test/dm/eth.c                 | 1 -
 test/dm/fastboot.c            | 1 -
 test/dm/fdtdec.c              | 1 -
 test/dm/ffa.c                 | 1 -
 test/dm/firmware.c            | 1 -
 test/dm/fwu_mdata.c           | 1 -
 test/dm/gpio.c                | 1 -
 test/dm/host.c                | 1 -
 test/dm/hwspinlock.c          | 1 -
 test/dm/i2c.c                 | 1 -
 test/dm/i2s.c                 | 1 -
 test/dm/iommu.c               | 1 -
 test/dm/irq.c                 | 1 -
 test/dm/k210_pll.c            | 1 -
 test/dm/led.c                 | 1 -
 test/dm/mailbox.c             | 1 -
 test/dm/mdio.c                | 1 -
 test/dm/mdio_mux.c            | 1 -
 test/dm/misc.c                | 1 -
 test/dm/mmc.c                 | 1 -
 test/dm/mux-cmd.c             | 2 +-
 test/dm/mux-emul.c            | 1 -
 test/dm/mux-mmio.c            | 1 -
 test/dm/nop.c                 | 1 -
 test/dm/nvmxip.c              | 1 -
 test/dm/of_extra.c            | 1 -
 test/dm/of_platdata.c         | 1 -
 test/dm/ofnode.c              | 1 -
 test/dm/ofread.c              | 1 -
 test/dm/osd.c                 | 1 -
 test/dm/p2sb.c                | 1 -
 test/dm/panel.c               | 1 -
 test/dm/part.c                | 1 -
 test/dm/pch.c                 | 1 -
 test/dm/pci.c                 | 1 -
 test/dm/pci_ep.c              | 1 -
 test/dm/phy.c                 | 1 -
 test/dm/phys2bus.c            | 1 -
 test/dm/pinmux.c              | 1 -
 test/dm/pmc.c                 | 1 -
 test/dm/pmic.c                | 1 -
 test/dm/power-domain.c        | 1 -
 test/dm/pwm.c                 | 1 -
 test/dm/qfw.c                 | 1 -
 test/dm/ram.c                 | 1 -
 test/dm/read.c                | 1 -
 test/dm/reboot-mode.c         | 1 -
 test/dm/regmap.c              | 2 +-
 test/dm/regulator.c           | 1 -
 test/dm/remoteproc.c          | 3 ++-
 test/dm/reset.c               | 1 -
 test/dm/rkmtd.c               | 1 -
 test/dm/rng.c                 | 1 -
 test/dm/rtc.c                 | 1 -
 test/dm/scmi.c                | 1 -
 test/dm/scsi.c                | 1 -
 test/dm/serial.c              | 1 -
 test/dm/sf.c                  | 1 -
 test/dm/simple-bus.c          | 1 -
 test/dm/simple-pm-bus.c       | 1 -
 test/dm/sm.c                  | 1 -
 test/dm/smem.c                | 1 -
 test/dm/soc.c                 | 1 -
 test/dm/sound.c               | 1 -
 test/dm/spi.c                 | 1 -
 test/dm/spmi.c                | 1 -
 test/dm/syscon-reset.c        | 1 -
 test/dm/syscon.c              | 1 -
 test/dm/sysinfo-gpio.c        | 1 -
 test/dm/sysinfo.c             | 1 -
 test/dm/sysreset.c            | 1 -
 test/dm/tag.c                 | 1 -
 test/dm/tee.c                 | 1 -
 test/dm/test-dm.c             | 1 -
 test/dm/test-driver.c         | 1 -
 test/dm/test-fdt.c            | 1 -
 test/dm/test-uclass.c         | 1 -
 test/dm/timer.c               | 1 -
 test/dm/tpm.c                 | 1 -
 test/dm/usb.c                 | 1 -
 test/dm/video.c               | 1 -
 test/dm/virtio.c              | 1 -
 test/dm/virtio_device.c       | 1 -
 test/dm/virtio_rng.c          | 1 -
 test/dm/wdt.c                 | 2 +-
 test/env/attr.c               | 1 -
 test/env/cmd_ut_env.c         | 1 -
 test/env/fdt.c                | 1 -
 test/env/hashtable.c          | 2 +-
 test/fuzz/cmd_fuzz.c          | 1 -
 test/fuzz/virtio.c            | 1 -
 test/image/spl_load.c         | 1 -
 test/image/spl_load_fs.c      | 1 -
 test/image/spl_load_net.c     | 1 -
 test/image/spl_load_nor.c     | 1 -
 test/image/spl_load_os.c      | 1 -
 test/image/spl_load_spi.c     | 1 -
 test/lib/abuf.c               | 1 -
 test/lib/asn1.c               | 1 -
 test/lib/cmd_ut_lib.c         | 1 -
 test/lib/efi_device_path.c    | 1 -
 test/lib/efi_image_region.c   | 1 -
 test/lib/getopt.c             | 1 -
 test/lib/hexdump.c            | 1 -
 test/lib/kconfig.c            | 1 -
 test/lib/kconfig_spl.c        | 1 -
 test/lib/lmb.c                | 1 -
 test/lib/longjmp.c            | 1 -
 test/lib/rsa.c                | 1 -
 test/lib/sscanf.c             | 1 -
 test/lib/string.c             | 1 -
 test/lib/strlcat.c            | 1 -
 test/lib/test_aes.c           | 1 -
 test/lib/test_crypt.c         | 1 -
 test/lib/test_errno_str.c     | 1 -
 test/lib/test_print.c         | 1 -
 test/lib/uuid.c               | 1 -
 test/log/cont_test.c          | 1 -
 test/log/log_filter.c         | 1 -
 test/log/log_test.c           | 1 -
 test/log/log_ut.c             | 1 -
 test/log/nolog_ndebug.c       | 1 -
 test/log/nolog_test.c         | 1 -
 test/log/pr_cont_test.c       | 1 -
 test/log/syslog_test.c        | 1 -
 test/log/syslog_test_ndebug.c | 1 -
 test/optee/cmd_ut_optee.c     | 1 -
 test/overlay/cmd_ut_overlay.c | 1 -
 test/print_ut.c               | 1 -
 test/stdint/int-types.c       | 2 +-
 test/str_ut.c                 | 1 -
 test/test-main.c              | 1 -
 test/time_ut.c                | 1 -
 test/unicode_ut.c             | 1 -
 test/ut.c                     | 1 -
 203 files changed, 24 insertions(+), 196 deletions(-)

diff --git a/include/adc.h b/include/adc.h
index 0d1a666908f2..15e4cdb7dce7 100644
--- a/include/adc.h
+++ b/include/adc.h
@@ -7,6 +7,8 @@
 #ifndef _ADC_H_
 #define _ADC_H_
 
+#include <stdbool.h>
+
 /* ADC_CHANNEL() - ADC channel bit mask, to select only required channels */
 #define ADC_CHANNEL(x)		(1 << x)
 
diff --git a/include/audio_codec.h b/include/audio_codec.h
index a81a31515765..a87b76c6f9ed 100644
--- a/include/audio_codec.h
+++ b/include/audio_codec.h
@@ -7,6 +7,8 @@
 #ifndef __AUDIO_CODEC_H__
 #define __AUDIO_CODEC_H__
 
+#include <linux/types.h>
+
 struct udevice;
 
 /*
diff --git a/include/axi.h b/include/axi.h
index 59fb0b2e4584..133a06ee2719 100644
--- a/include/axi.h
+++ b/include/axi.h
@@ -7,6 +7,8 @@
 #ifndef _AXI_H_
 #define _AXI_H_
 
+#include <linux/types.h>
+
 struct udevice;
 
 /**
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 0fc36104ece0..cd9517321c0a 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -7,6 +7,8 @@
 #ifndef __bootmeth_h
 #define __bootmeth_h
 
+#include <linux/bitops.h>
+
 struct blk_desc;
 struct bootflow;
 struct bootflow_iter;
diff --git a/include/bootstd.h b/include/bootstd.h
index 99ce7b64e7c5..ac756e98d84a 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -10,6 +10,8 @@
 #define __bootstd_h
 
 #include <dm/ofnode_decl.h>
+#include <linux/list.h>
+#include <linux/types.h>
 
 struct udevice;
 
diff --git a/include/cedit.h b/include/cedit.h
index f43cafa5aa24..a31b42452477 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -7,12 +7,15 @@
 #ifndef __CEDIT_H
 #define __CEDIT_H
 
+#include <stdbool.h>
 #include <dm/ofnode_decl.h>
+#include <linux/types.h>
 
 struct abuf;
 struct expo;
 struct scene;
 struct video_priv;
+struct udevice;
 
 enum {
 	/* size increment for writing FDT */
diff --git a/include/dm/test.h b/include/dm/test.h
index b5937509212b..02737411a164 100644
--- a/include/dm/test.h
+++ b/include/dm/test.h
@@ -6,6 +6,8 @@
 #ifndef __DM_TEST_H
 #define __DM_TEST_H
 
+#include <linux/types.h>
+
 struct udevice;
 
 /**
diff --git a/test/bloblist.c b/test/bloblist.c
index 1c60bbac36c3..7c63682908a5 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018, Google Inc. All rights reserved.
  */
 
-#include <common.h>
 #include <bloblist.h>
 #include <log.h>
 #include <mapmem.h>
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 0702fccdae60..6e940002f848 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootstd.h>
 #include <dm.h>
 #include <bootdev.h>
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 674d4c05f83f..4511cfa7f9bf 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
index e498eee036eb..113b789ea793 100644
--- a/test/boot/bootmeth.c
+++ b/test/boot/bootmeth.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootmeth.h>
 #include <bootstd.h>
 #include <dm.h>
diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
index cc97e255e5cb..e50539500a02 100644
--- a/test/boot/bootstd_common.c
+++ b/test/boot/bootstd_common.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootstd.h>
 #include <dm.h>
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index aa4171904864..fd19da0a0c0f 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <cedit.h>
 #include <env.h>
 #include <expo.h>
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 714fdfa415d1..6ea0184373d5 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <expo.h>
diff --git a/test/boot/image.c b/test/boot/image.c
index 2844b057859e..0894e30587f1 100644
--- a/test/boot/image.c
+++ b/test/boot/image.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <image.h>
 #include <test/suites.h>
 #include <test/ut.h>
diff --git a/test/boot/measurement.c b/test/boot/measurement.c
index 9db2ed324c2a..29be495412d3 100644
--- a/test/boot/measurement.c
+++ b/test/boot/measurement.c
@@ -6,7 +6,6 @@
  * Written by Eddie James <eajames@linux.ibm.com>
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <malloc.h>
 #include <test/suites.h>
diff --git a/test/boot/vbe_fixup.c b/test/boot/vbe_fixup.c
index eba5c4ebe6c0..540816e42b00 100644
--- a/test/boot/vbe_fixup.c
+++ b/test/boot/vbe_fixup.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm/ofnode.h>
 #include <linux/libfdt.h>
 #include <test/test.h>
diff --git a/test/boot/vbe_simple.c b/test/boot/vbe_simple.c
index 5e61840652cf..3672b744e5fb 100644
--- a/test/boot/vbe_simple.c
+++ b/test/boot/vbe_simple.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootmeth.h>
 #include <dm.h>
 #include <image.h>
diff --git a/test/bootm.c b/test/bootm.c
index 4bb3ca0655cf..26c15552bf63 100644
--- a/test/bootm.c
+++ b/test/bootm.c
@@ -5,7 +5,6 @@
  * Copyright 2020 Google LLC
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <asm/global_data.h>
 #include <test/suites.h>
diff --git a/test/cmd/addrmap.c b/test/cmd/addrmap.c
index 1eb5955db172..7b8f49fd3751 100644
--- a/test/cmd/addrmap.c
+++ b/test/cmd/addrmap.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <console.h>
 #include <test/suites.h>
 #include <test/ut.h>
diff --git a/test/cmd/armffa.c b/test/cmd/armffa.c
index 9a44a397e8a0..38f40b72f5e4 100644
--- a/test/cmd/armffa.c
+++ b/test/cmd/armffa.c
@@ -8,7 +8,6 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <common.h>
 #include <string.h>
 #include <asm/sandbox_arm_ffa.h>
 #include <dm/test.h>
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 4977d01f62d6..027848c3e24c 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -5,7 +5,6 @@
  * Copyright 2023 Marek Vasut <marek.vasut+renesas@mailbox.org>
  */
 
-#include <common.h>
 #include <console.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index 7e160f7e4bb7..d310ec8531be 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -5,7 +5,6 @@
  * Copyright 2022 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <console.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 547085521758..a0faf5aca904 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -5,7 +5,6 @@
  * Copyright 2022 Google LLC
  */
 
-#include <common.h>
 #include <console.h>
 #include <fdt_support.h>
 #include <mapmem.h>
diff --git a/test/cmd/font.c b/test/cmd/font.c
index 1fe05c1ead51..a8905ce617e8 100644
--- a/test/cmd/font.c
+++ b/test/cmd/font.c
@@ -5,7 +5,6 @@
  * Copyright 2022 Google LLC
  */
 
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <video_console.h>
diff --git a/test/cmd/history.c b/test/cmd/history.c
index 06517fcdbb51..6964bfa9e1ec 100644
--- a/test/cmd/history.c
+++ b/test/cmd/history.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <cli.h>
 #include <command.h>
 #include <test/lib.h>
diff --git a/test/cmd/loadm.c b/test/cmd/loadm.c
index 41e005ac5923..dff8a97d1396 100644
--- a/test/cmd/loadm.c
+++ b/test/cmd/loadm.c
@@ -9,7 +9,6 @@
  *   Rui Miguel Silva <rui.silva@linaro.org>
  */
 
-#include <common.h>
 #include <console.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
diff --git a/test/cmd/mem.c b/test/cmd/mem.c
index d76f47cf3115..f1bbab6055be 100644
--- a/test/cmd/mem.c
+++ b/test/cmd/mem.c
@@ -5,7 +5,6 @@
  * Copyright 2020 Google LLC
  */
 
-#include <common.h>
 #include <command.h>
 #include <test/suites.h>
 #include <test/test.h>
diff --git a/test/cmd/mem_search.c b/test/cmd/mem_search.c
index f80c9c406873..55ad2fac1e34 100644
--- a/test/cmd/mem_search.c
+++ b/test/cmd/mem_search.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <console.h>
 #include <mapmem.h>
 #include <dm/test.h>
diff --git a/test/cmd/pci_mps.c b/test/cmd/pci_mps.c
index fd96f4fba6c4..2a64143eecd3 100644
--- a/test/cmd/pci_mps.c
+++ b/test/cmd/pci_mps.c
@@ -7,7 +7,6 @@
  * Written by Stephen Carlson <stcarlso@linux.microsoft.com>
  */
 
-#include <common.h>
 #include <console.h>
 #include <test/suites.h>
 #include <test/ut.h>
diff --git a/test/cmd/pinmux.c b/test/cmd/pinmux.c
index df40bb774355..4253baa56466 100644
--- a/test/cmd/pinmux.c
+++ b/test/cmd/pinmux.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <dm/test.h>
diff --git a/test/cmd/rw.c b/test/cmd/rw.c
index 98302bf047b1..edd762e4d58f 100644
--- a/test/cmd/rw.c
+++ b/test/cmd/rw.c
@@ -3,7 +3,6 @@
  * Tests for read and write commands
  */
 
-#include <common.h>
 #include <dm/test.h>
 #include <mapmem.h>
 #include <part.h>
diff --git a/test/cmd/seama.c b/test/cmd/seama.c
index b1b56930c646..b60f6550b13c 100644
--- a/test/cmd/seama.c
+++ b/test/cmd/seama.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021 Linus Walleij <linus.walleij@linaro.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <test/suites.h>
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index ee329e94b85b..d50ce5803c39 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <console.h>
 #include <mapmem.h>
 #include <dm/test.h>
diff --git a/test/cmd/temperature.c b/test/cmd/temperature.c
index 2a1ea0611dc4..364972626b1f 100644
--- a/test/cmd/temperature.c
+++ b/test/cmd/temperature.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022 Sartura Ltd.
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <dm/test.h>
diff --git a/test/cmd/test_echo.c b/test/cmd/test_echo.c
index 091e4f823c90..cde74ebeb616 100644
--- a/test/cmd/test_echo.c
+++ b/test/cmd/test_echo.c
@@ -5,7 +5,6 @@
  * Copyright 2020, Heinrich Schuchadt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <asm/global_data.h>
 #include <display_options.h>
diff --git a/test/cmd/test_pause.c b/test/cmd/test_pause.c
index 2b85cce32710..3703290350b3 100644
--- a/test/cmd/test_pause.c
+++ b/test/cmd/test_pause.c
@@ -5,7 +5,6 @@
  * Copyright 2022, Samuel Dionne-Riel <samuel@dionne-riel.com>
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <test/lib.h>
 #include <test/ut.h>
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index ed83fc94a5e2..356a4dcd8fad 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -6,7 +6,6 @@
  * Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 0677ce0cd174..4e4aa8f1cb27 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -4,9 +4,9 @@
  * Joe Hershberger, National Instruments, joe.hershberger@ni.com
  */
 
-#include <common.h>
 #include <command.h>
 #include <console.h>
+#include <vsprintf.h>
 #include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/command_ut.c b/test/command_ut.c
index a74bd109e153..2b8d28d7ae32 100644
--- a/test/command_ut.c
+++ b/test/command_ut.c
@@ -5,7 +5,6 @@
 
 #define DEBUG
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <log.h>
diff --git a/test/common/cmd_ut_common.c b/test/common/cmd_ut_common.c
index 2c0267801b23..2f03a58af47c 100644
--- a/test/common/cmd_ut_common.c
+++ b/test/common/cmd_ut_common.c
@@ -6,7 +6,6 @@
  * Unit tests for common functions
  */
 
-#include <common.h>
 #include <command.h>
 #include <test/common.h>
 #include <test/suites.h>
diff --git a/test/common/cread.c b/test/common/cread.c
index 4edc77396043..e159caed0419 100644
--- a/test/common/cread.c
+++ b/test/common/cread.c
@@ -3,8 +3,8 @@
  * Copyright 2023 Google LLC
  */
 
-#include <common.h>
 #include <cli.h>
+#include <time.h>
 #include <test/common.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/common/cyclic.c b/test/common/cyclic.c
index 6e758e89dbdb..461f8cf91f45 100644
--- a/test/common/cyclic.c
+++ b/test/common/cyclic.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2022 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <cyclic.h>
 #include <dm.h>
 #include <test/common.h>
diff --git a/test/common/event.c b/test/common/event.c
index b462694fc3b6..de433d34f22b 100644
--- a/test/common/event.c
+++ b/test/common/event.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <event.h>
 #include <test/common.h>
diff --git a/test/common/test_autoboot.c b/test/common/test_autoboot.c
index 42a1e4ab1fa0..4ba1dcc8091c 100644
--- a/test/common/test_autoboot.c
+++ b/test/common/test_autoboot.c
@@ -6,7 +6,6 @@
  */
 
 #include <autoboot.h>
-#include <common.h>
 #include <test/common.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/compression.c b/test/compression.c
index 3df90819a1fb..aa1d38bb7bc5 100644
--- a/test/compression.c
+++ b/test/compression.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013, The Chromium Authors
  */
 
-#include <common.h>
 #include <abuf.h>
 #include <bootm.h>
 #include <command.h>
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index f14b3962f845..4db2171a4b17 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <malloc.h>
diff --git a/test/dm/acpi_dp.c b/test/dm/acpi_dp.c
index 44bcabda6bc1..87bd8ae6749b 100644
--- a/test/dm/acpi_dp.c
+++ b/test/dm/acpi_dp.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <uuid.h>
 #include <acpi/acpigen.h>
diff --git a/test/dm/acpigen.c b/test/dm/acpigen.c
index 15b2b6f64a03..7113219792e6 100644
--- a/test/dm/acpigen.c
+++ b/test/dm/acpigen.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <irq.h>
 #include <malloc.h>
diff --git a/test/dm/adc.c b/test/dm/adc.c
index 740167e16b8e..a26a677074a4 100644
--- a/test/dm/adc.c
+++ b/test/dm/adc.c
@@ -6,7 +6,6 @@
  * Przemyslaw Marczak <p.marczak@samsung.com>
  */
 
-#include <common.h>
 #include <adc.h>
 #include <dm.h>
 #include <dm/root.h>
diff --git a/test/dm/audio.c b/test/dm/audio.c
index add15ae20e00..3d1d821f3234 100644
--- a/test/dm/audio.c
+++ b/test/dm/audio.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <audio_codec.h>
 #include <dm.h>
 #include <dm/test.h>
diff --git a/test/dm/axi.c b/test/dm/axi.c
index dc029df5e443..0900a9b5485e 100644
--- a/test/dm/axi.c
+++ b/test/dm/axi.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <axi.h>
 #include <dm.h>
 #include <log.h>
diff --git a/test/dm/blk.c b/test/dm/blk.c
index 799f1e4dc75b..d03aec32f6c7 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <part.h>
diff --git a/test/dm/blkmap.c b/test/dm/blkmap.c
index 7a163d6eaef2..7581e62df3bb 100644
--- a/test/dm/blkmap.c
+++ b/test/dm/blkmap.c
@@ -4,7 +4,6 @@
  * Author: Tobias Waldekranz <tobias@waldekranz.com>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <blkmap.h>
 #include <dm.h>
diff --git a/test/dm/bootcount.c b/test/dm/bootcount.c
index b77b472d1f26..9cfc7d48aac0 100644
--- a/test/dm/bootcount.c
+++ b/test/dm/bootcount.c
@@ -3,7 +3,6 @@
  * (C) 2018 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
 #include <dm.h>
 #include <bootcount.h>
 #include <log.h>
diff --git a/test/dm/bus.c b/test/dm/bus.c
index 89a6aa6554cb..a338c7f567c1 100644
--- a/test/dm/bus.c
+++ b/test/dm/bus.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2014 Google, Inc
  */
 
-#include <common.h>
 #ifdef CONFIG_SANDBOX
 #include <log.h>
 #include <os.h>
diff --git a/test/dm/button.c b/test/dm/button.c
index 830d96fbef34..9157ec928783 100644
--- a/test/dm/button.c
+++ b/test/dm/button.c
@@ -5,7 +5,6 @@
  * Based on led.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <adc.h>
 #include <button.h>
diff --git a/test/dm/cache.c b/test/dm/cache.c
index bbd8f98d007b..d2f3bfe2caf3 100644
--- a/test/dm/cache.c
+++ b/test/dm/cache.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/test.h>
 
diff --git a/test/dm/clk.c b/test/dm/clk.c
index 57fabbdce08b..a966471dbd96 100644
--- a/test/dm/clk.c
+++ b/test/dm/clk.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
index 61dad8d85273..15fba31b962f 100644
--- a/test/dm/clk_ccf.c
+++ b/test/dm/clk_ccf.c
@@ -4,7 +4,6 @@
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <asm/clk.h>
diff --git a/test/dm/core.c b/test/dm/core.c
index 7f3f8d183bca..4741c81bcc1d 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2013 Google, Inc
  */
 
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/test/dm/cpu.c b/test/dm/cpu.c
index 5734cd0a92d3..acba81059966 100644
--- a/test/dm/cpu.c
+++ b/test/dm/cpu.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/test.h>
diff --git a/test/dm/cros_ec.c b/test/dm/cros_ec.c
index 30cb70e08826..ac0055f0acd6 100644
--- a/test/dm/cros_ec.c
+++ b/test/dm/cros_ec.c
@@ -3,7 +3,6 @@
  * Copyright 2021 Google LLC
  */
 
-#include <common.h>
 #include <cros_ec.h>
 #include <dm.h>
 #include <asm/test.h>
diff --git a/test/dm/cros_ec_pwm.c b/test/dm/cros_ec_pwm.c
index f8d6e1e6c40f..f68ee6f33b8c 100644
--- a/test/dm/cros_ec_pwm.c
+++ b/test/dm/cros_ec_pwm.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <cros_ec.h>
 #include <dm.h>
 #include <pwm.h>
diff --git a/test/dm/devres.c b/test/dm/devres.c
index 3df0f64362dc..95a470b9f1c1 100644
--- a/test/dm/devres.c
+++ b/test/dm/devres.c
@@ -5,7 +5,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <log.h>
diff --git a/test/dm/dma.c b/test/dm/dma.c
index cce47cb21803..949710fdb4e3 100644
--- a/test/dm/dma.c
+++ b/test/dm/dma.c
@@ -6,7 +6,6 @@
  * Grygorii Strashko <grygorii.strashko@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <dm/test.h>
diff --git a/test/dm/dsi_host.c b/test/dm/dsi_host.c
index 6e0a5df704f5..68686a40d9f9 100644
--- a/test/dm/dsi_host.c
+++ b/test/dm/dsi_host.c
@@ -4,7 +4,6 @@
  * Author(s): Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dsi_host.h>
 #include <asm/state.h>
diff --git a/test/dm/efi_media.c b/test/dm/efi_media.c
index e343a0e9c85d..9d0ed0f07551 100644
--- a/test/dm/efi_media.c
+++ b/test/dm/efi_media.c
@@ -5,7 +5,6 @@
  * Copyright 2021 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/test.h>
 #include <dm/test.h>
diff --git a/test/dm/eth.c b/test/dm/eth.c
index bb3dcc6b9540..820b8cbfc29d 100644
--- a/test/dm/eth.c
+++ b/test/dm/eth.c
@@ -6,7 +6,6 @@
  * Joe Hershberger <joe.hershberger@ni.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <fdtdec.h>
diff --git a/test/dm/fastboot.c b/test/dm/fastboot.c
index 758538d0e85e..5d938eb7f121 100644
--- a/test/dm/fastboot.c
+++ b/test/dm/fastboot.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fastboot.h>
 #include <fb_mmc.h>
diff --git a/test/dm/fdtdec.c b/test/dm/fdtdec.c
index 087d4846da89..b484414f5f07 100644
--- a/test/dm/fdtdec.c
+++ b/test/dm/fdtdec.c
@@ -3,7 +3,6 @@
  * Copyright 2020 NXP
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <dm/of_extra.h>
diff --git a/test/dm/ffa.c b/test/dm/ffa.c
index 6912666bb465..fa6d54d00d61 100644
--- a/test/dm/ffa.c
+++ b/test/dm/ffa.c
@@ -8,7 +8,6 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <asm/sandbox_arm_ffa.h>
diff --git a/test/dm/firmware.c b/test/dm/firmware.c
index f37bccfe4a83..ec68e816999d 100644
--- a/test/dm/firmware.c
+++ b/test/dm/firmware.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Xilinx, Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/test.h>
diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
index 52018f610fe4..43ce3d0a9d87 100644
--- a/test/dm/fwu_mdata.c
+++ b/test/dm/fwu_mdata.c
@@ -5,7 +5,6 @@
  */
 
 #include <blk.h>
-#include <common.h>
 #include <dm.h>
 #include <fwu.h>
 #include <fwu_mdata.h>
diff --git a/test/dm/gpio.c b/test/dm/gpio.c
index 0d88ec24bda2..957ab25c8d34 100644
--- a/test/dm/gpio.c
+++ b/test/dm/gpio.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2013 Google, Inc
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <dm.h>
 #include <log.h>
diff --git a/test/dm/host.c b/test/dm/host.c
index ca05a36b3136..e514f8409cf6 100644
--- a/test/dm/host.c
+++ b/test/dm/host.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <fs.h>
diff --git a/test/dm/hwspinlock.c b/test/dm/hwspinlock.c
index 995759d4d7e2..a05b183b8bc1 100644
--- a/test/dm/hwspinlock.c
+++ b/test/dm/hwspinlock.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <dm.h>
 #include <hwspinlock.h>
 #include <asm/state.h>
diff --git a/test/dm/i2c.c b/test/dm/i2c.c
index b46a22e79b14..e9cf9f7819a7 100644
--- a/test/dm/i2c.c
+++ b/test/dm/i2c.c
@@ -5,7 +5,6 @@
  * Note: Test coverage does not include 10-bit addressing
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <i2c.h>
diff --git a/test/dm/i2s.c b/test/dm/i2s.c
index c2bf4d5604b9..a3d3a31b6fbc 100644
--- a/test/dm/i2s.c
+++ b/test/dm/i2s.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2s.h>
 #include <asm/test.h>
diff --git a/test/dm/iommu.c b/test/dm/iommu.c
index 62d38f1214ac..acea5f289715 100644
--- a/test/dm/iommu.c
+++ b/test/dm/iommu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
diff --git a/test/dm/irq.c b/test/dm/irq.c
index 51dd5e4abb41..d22772ab7693 100644
--- a/test/dm/irq.c
+++ b/test/dm/irq.c
@@ -5,7 +5,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <irq.h>
 #include <acpi/acpi_device.h>
diff --git a/test/dm/k210_pll.c b/test/dm/k210_pll.c
index 354720f61e2f..2a581499634d 100644
--- a/test/dm/k210_pll.c
+++ b/test/dm/k210_pll.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 /* For DIV_ROUND_DOWN_ULL, defined in linux/kernel.h */
 #include <div64.h>
 #include <dm/test.h>
diff --git a/test/dm/led.c b/test/dm/led.c
index eed3f4654c56..c28fa044f459 100644
--- a/test/dm/led.c
+++ b/test/dm/led.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <led.h>
 #include <asm/gpio.h>
diff --git a/test/dm/mailbox.c b/test/dm/mailbox.c
index 7ad8a1cbba28..14f72d58d1cf 100644
--- a/test/dm/mailbox.c
+++ b/test/dm/mailbox.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <dm/test.h>
diff --git a/test/dm/mdio.c b/test/dm/mdio.c
index f863c52645b2..7ececf37ccc0 100644
--- a/test/dm/mdio.c
+++ b/test/dm/mdio.c
@@ -4,7 +4,6 @@
  * Alex Marginean, NXP
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <miiphy.h>
diff --git a/test/dm/mdio_mux.c b/test/dm/mdio_mux.c
index bfe3518221f4..33a7e9726094 100644
--- a/test/dm/mdio_mux.c
+++ b/test/dm/mdio_mux.c
@@ -4,7 +4,6 @@
  * Alex Marginean, NXP
  */
 
-#include <common.h>
 #include <dm.h>
 #include <miiphy.h>
 #include <misc.h>
diff --git a/test/dm/misc.c b/test/dm/misc.c
index 8bdd8c64bca2..ad856fd01b6d 100644
--- a/test/dm/misc.c
+++ b/test/dm/misc.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/test.h>
 #include <misc.h>
diff --git a/test/dm/mmc.c b/test/dm/mmc.c
index b1eb8bee2f9d..c0abea797d9d 100644
--- a/test/dm/mmc.c
+++ b/test/dm/mmc.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <mmc.h>
 #include <part.h>
diff --git a/test/dm/mux-cmd.c b/test/dm/mux-cmd.c
index 11c237b5da90..d4bb8befa384 100644
--- a/test/dm/mux-cmd.c
+++ b/test/dm/mux-cmd.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Texas Instruments Inc.
  * Pratyush Yadav <p.yadav@ti.com>
  */
-#include <common.h>
 #include <dm.h>
 #include <mux.h>
 #include <mux-internal.h>
@@ -13,6 +12,7 @@
 #include <test/ut.h>
 #include <console.h>
 #include <rand.h>
+#include <time.h>
 
 #define BUF_SIZE		256
 
diff --git a/test/dm/mux-emul.c b/test/dm/mux-emul.c
index c6aeeb7e1f1b..febd521104af 100644
--- a/test/dm/mux-emul.c
+++ b/test/dm/mux-emul.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
  * Pratyush Yadav <p.yadav@ti.com>
  */
-#include <common.h>
 #include <dm.h>
 #include <mux.h>
 #include <mux-internal.h>
diff --git a/test/dm/mux-mmio.c b/test/dm/mux-mmio.c
index 27c881dabde2..3a871a19c7e2 100644
--- a/test/dm/mux-mmio.c
+++ b/test/dm/mux-mmio.c
@@ -4,7 +4,6 @@
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <mux.h>
 #include <regmap.h>
diff --git a/test/dm/nop.c b/test/dm/nop.c
index f7d9a0f3df35..0c79431d9d80 100644
--- a/test/dm/nop.c
+++ b/test/dm/nop.c
@@ -6,7 +6,6 @@
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/ofnode.h>
 #include <dm/lists.h>
diff --git a/test/dm/nvmxip.c b/test/dm/nvmxip.c
index f0ad47d4efe9..537959a0930c 100644
--- a/test/dm/nvmxip.c
+++ b/test/dm/nvmxip.c
@@ -8,7 +8,6 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <console.h>
 #include <dm.h>
diff --git a/test/dm/of_extra.c b/test/dm/of_extra.c
index ac2d886892d9..3c31bfcd31f9 100644
--- a/test/dm/of_extra.c
+++ b/test/dm/of_extra.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/of_extra.h>
 #include <dm/test.h>
diff --git a/test/dm/of_platdata.c b/test/dm/of_platdata.c
index a241c4279367..d4939e885162 100644
--- a/test/dm/of_platdata.c
+++ b/test/dm/of_platdata.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dt-structs.h>
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index a5bc43aea4e7..39191d7f52b5 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -16,7 +16,6 @@
  * behaviour of each ofnode function, since that is done by the normal ones.
  */
 
-#include <common.h>
 #include <abuf.h>
 #include <dm.h>
 #include <log.h>
diff --git a/test/dm/ofread.c b/test/dm/ofread.c
index 3523860d2b31..69d03c491073 100644
--- a/test/dm/ofread.c
+++ b/test/dm/ofread.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <dm.h>
 #include <dm/test.h>
 #include <test/ut.h>
diff --git a/test/dm/osd.c b/test/dm/osd.c
index 6279b391ca5e..cf4a3a545ed0 100644
--- a/test/dm/osd.c
+++ b/test/dm/osd.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <display_options.h>
 #include <dm.h>
 #include <video_osd.h>
diff --git a/test/dm/p2sb.c b/test/dm/p2sb.c
index df24709141ad..3ada1fcb3629 100644
--- a/test/dm/p2sb.c
+++ b/test/dm/p2sb.c
@@ -5,7 +5,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <p2sb.h>
 #include <asm/test.h>
diff --git a/test/dm/panel.c b/test/dm/panel.c
index 4d435a0d255c..8be7c397a462 100644
--- a/test/dm/panel.c
+++ b/test/dm/panel.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <backlight.h>
 #include <dm.h>
 #include <panel.h>
diff --git a/test/dm/part.c b/test/dm/part.c
index d6e434581274..cabb31d18ca0 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Sean Anderson <sean.anderson@seco.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <mmc.h>
 #include <part.h>
diff --git a/test/dm/pch.c b/test/dm/pch.c
index 53f7bbf180c9..b37b856d5dac 100644
--- a/test/dm/pch.c
+++ b/test/dm/pch.c
@@ -3,7 +3,6 @@
  * Copyright 2018 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pch.h>
 #include <asm/test.h>
diff --git a/test/dm/pci.c b/test/dm/pci.c
index 8c5e7da9e629..9b97f2e0544f 100644
--- a/test/dm/pci.c
+++ b/test/dm/pci.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/io.h>
 #include <asm/test.h>
diff --git a/test/dm/pci_ep.c b/test/dm/pci_ep.c
index 9941abd4cebc..e82fc53f84b1 100644
--- a/test/dm/pci_ep.c
+++ b/test/dm/pci_ep.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Ramon Fried
  */
 
-#include <common.h>
 #include <dm.h>
 #include <hexdump.h>
 #include <pci_ep.h>
diff --git a/test/dm/phy.c b/test/dm/phy.c
index 0cf3689fdecb..d14117f6f7a9 100644
--- a/test/dm/phy.c
+++ b/test/dm/phy.c
@@ -4,7 +4,6 @@
  * Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <log.h>
diff --git a/test/dm/phys2bus.c b/test/dm/phys2bus.c
index 342f2fa8ebaa..1ee2150482c6 100644
--- a/test/dm/phys2bus.c
+++ b/test/dm/phys2bus.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <mapmem.h>
 #include <phys2bus.h>
diff --git a/test/dm/pinmux.c b/test/dm/pinmux.c
index 6880b2d2cd9c..cfbe3ef5d1eb 100644
--- a/test/dm/pinmux.c
+++ b/test/dm/pinmux.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <dm/test.h>
diff --git a/test/dm/pmc.c b/test/dm/pmc.c
index e70227e7800b..bbad1ee27419 100644
--- a/test/dm/pmc.c
+++ b/test/dm/pmc.c
@@ -5,7 +5,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <power/acpi_pmc.h>
 #include <dm/test.h>
diff --git a/test/dm/pmic.c b/test/dm/pmic.c
index ce671202fbc6..53a6f0369e87 100644
--- a/test/dm/pmic.c
+++ b/test/dm/pmic.c
@@ -6,7 +6,6 @@
  * Przemyslaw Marczak <p.marczak@samsung.com>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/test/dm/power-domain.c b/test/dm/power-domain.c
index 8604b5d72dc0..120a9059c8e6 100644
--- a/test/dm/power-domain.c
+++ b/test/dm/power-domain.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <dm/test.h>
diff --git a/test/dm/pwm.c b/test/dm/pwm.c
index dff626c771ac..80133347ec73 100644
--- a/test/dm/pwm.c
+++ b/test/dm/pwm.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pwm.h>
 #include <asm/test.h>
diff --git a/test/dm/qfw.c b/test/dm/qfw.c
index f3f356898308..3c354163ef3b 100644
--- a/test/dm/qfw.c
+++ b/test/dm/qfw.c
@@ -3,7 +3,6 @@
  * Copyright 2021 Asherah Connor <ashe@kivikakk.ee>
  */
 
-#include <common.h>
 #include <qfw.h>
 #include <dm.h>
 #include <asm/test.h>
diff --git a/test/dm/ram.c b/test/dm/ram.c
index f624343138d6..188c7c327584 100644
--- a/test/dm/ram.c
+++ b/test/dm/ram.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <ram.h>
 #include <asm/global_data.h>
diff --git a/test/dm/read.c b/test/dm/read.c
index 7768aa296885..4ecf18110d0f 100644
--- a/test/dm/read.c
+++ b/test/dm/read.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device.h>
 #include <dm/ofnode.h>
diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
index fbb9c3a5426a..160b4da07f20 100644
--- a/test/dm/reboot-mode.c
+++ b/test/dm/reboot-mode.c
@@ -3,7 +3,6 @@
  * (C) 2018 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
 #include <dm.h>
 #include <reboot-mode/reboot-mode.h>
 #include <env.h>
diff --git a/test/dm/regmap.c b/test/dm/regmap.c
index 8560f2afc2d1..1398f8f6573e 100644
--- a/test/dm/regmap.c
+++ b/test/dm/regmap.c
@@ -3,13 +3,13 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <mapmem.h>
 #include <regmap.h>
 #include <syscon.h>
 #include <rand.h>
+#include <time.h>
 #include <asm/test.h>
 #include <dm/test.h>
 #include <dm/devres.h>
diff --git a/test/dm/regulator.c b/test/dm/regulator.c
index 86f4862d9dd0..9e45fd177b94 100644
--- a/test/dm/regulator.c
+++ b/test/dm/regulator.c
@@ -6,7 +6,6 @@
  * Przemyslaw Marczak <p.marczak@samsung.com>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/test/dm/remoteproc.c b/test/dm/remoteproc.c
index f6f9e509e27a..ef9e8e5a0df6 100644
--- a/test/dm/remoteproc.c
+++ b/test/dm/remoteproc.c
@@ -3,7 +3,8 @@
  * (C) Copyright 2015
  * Texas Instruments Incorporated - https://www.ti.com/
  */
-#include <common.h>
+
+#include <config.h>
 #include <dm.h>
 #include <elf.h>
 #include <errno.h>
diff --git a/test/dm/reset.c b/test/dm/reset.c
index e2d6f456230c..d3158bf4a72e 100644
--- a/test/dm/reset.c
+++ b/test/dm/reset.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <log.h>
diff --git a/test/dm/rkmtd.c b/test/dm/rkmtd.c
index 3c3e8efa92f2..3dc9ca1add11 100644
--- a/test/dm/rkmtd.c
+++ b/test/dm/rkmtd.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2023 Johan Jonker <jbx6244@gmail.com>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <fs.h>
diff --git a/test/dm/rng.c b/test/dm/rng.c
index 6d1f68848d52..c8ed6cadf586 100644
--- a/test/dm/rng.c
+++ b/test/dm/rng.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <rng.h>
diff --git a/test/dm/rtc.c b/test/dm/rtc.c
index bf97dbbd2f9e..a8aa41955c22 100644
--- a/test/dm/rtc.c
+++ b/test/dm/rtc.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index adf36ffaab1d..69fc900e3429 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -12,7 +12,6 @@
  * unknown SCMI protocol ID.
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <reset.h>
diff --git a/test/dm/scsi.c b/test/dm/scsi.c
index 380cfc88baba..5180159fb27d 100644
--- a/test/dm/scsi.c
+++ b/test/dm/scsi.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <part.h>
 #include <scsi.h>
diff --git a/test/dm/serial.c b/test/dm/serial.c
index 34b783e062e1..34c0d4db879a 100644
--- a/test/dm/serial.c
+++ b/test/dm/serial.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018, STMicroelectronics
  */
 
-#include <common.h>
 #include <log.h>
 #include <serial.h>
 #include <dm.h>
diff --git a/test/dm/sf.c b/test/dm/sf.c
index 17d43fef3bc3..0e3a0f13f9ec 100644
--- a/test/dm/sf.c
+++ b/test/dm/sf.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2013 Google, Inc
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/test/dm/simple-bus.c b/test/dm/simple-bus.c
index 3530b47fac2f..8a730ba2fce4 100644
--- a/test/dm/simple-bus.c
+++ b/test/dm/simple-bus.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/test.h>
 #include <dm/simple_bus.h>
diff --git a/test/dm/simple-pm-bus.c b/test/dm/simple-pm-bus.c
index 792c74505806..9949cb34d596 100644
--- a/test/dm/simple-pm-bus.c
+++ b/test/dm/simple-pm-bus.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/test.h>
 #include <dm/device-internal.h>
diff --git a/test/dm/sm.c b/test/dm/sm.c
index 7ebb0c9c85ed..4d95c2ad75bd 100644
--- a/test/dm/sm.c
+++ b/test/dm/sm.c
@@ -5,7 +5,6 @@
  * Author: Alexey Romanov <avromanov@salutedevices.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <sm.h>
 #include <sandbox-sm.h>
diff --git a/test/dm/smem.c b/test/dm/smem.c
index 289fb59ba136..adcbfe574ab9 100644
--- a/test/dm/smem.c
+++ b/test/dm/smem.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Ramon Fried <ramon.fried@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <smem.h>
 #include <dm/test.h>
diff --git a/test/dm/soc.c b/test/dm/soc.c
index 8f6c97fa7908..cb0ac1545f7f 100644
--- a/test/dm/soc.c
+++ b/test/dm/soc.c
@@ -6,7 +6,6 @@
  *	Dave Gerlach <d-gerlach@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
diff --git a/test/dm/sound.c b/test/dm/sound.c
index 15d545ab5a34..f4e6215e6830 100644
--- a/test/dm/sound.c
+++ b/test/dm/sound.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <sound.h>
 #include <dm/test.h>
diff --git a/test/dm/spi.c b/test/dm/spi.c
index 325799bbf104..1ab2dd783249 100644
--- a/test/dm/spi.c
+++ b/test/dm/spi.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2013 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <spi.h>
diff --git a/test/dm/spmi.c b/test/dm/spmi.c
index 97bb0eb30fc9..e10ae8db4d30 100644
--- a/test/dm/spmi.c
+++ b/test/dm/spmi.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <dm.h>
 #include <malloc.h>
diff --git a/test/dm/syscon-reset.c b/test/dm/syscon-reset.c
index eeaddf88392c..ba19504573f4 100644
--- a/test/dm/syscon-reset.c
+++ b/test/dm/syscon-reset.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/test.h>
 #include <regmap.h>
diff --git a/test/dm/syscon.c b/test/dm/syscon.c
index be2329723362..04d324e87d44 100644
--- a/test/dm/syscon.c
+++ b/test/dm/syscon.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <syscon.h>
diff --git a/test/dm/sysinfo-gpio.c b/test/dm/sysinfo-gpio.c
index 2e494b3f3412..24a99dafb152 100644
--- a/test/dm/sysinfo-gpio.c
+++ b/test/dm/sysinfo-gpio.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <sysinfo.h>
diff --git a/test/dm/sysinfo.c b/test/dm/sysinfo.c
index 96b3a8ebabac..7444a580df6e 100644
--- a/test/dm/sysinfo.c
+++ b/test/dm/sysinfo.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/test.h>
diff --git a/test/dm/sysreset.c b/test/dm/sysreset.c
index 5aa69e046186..f3a859be7878 100644
--- a/test/dm/sysreset.c
+++ b/test/dm/sysreset.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <sysreset.h>
 #include <asm/state.h>
diff --git a/test/dm/tag.c b/test/dm/tag.c
index 8ae8a1fcd65b..bce8a35acfb5 100644
--- a/test/dm/tag.c
+++ b/test/dm/tag.c
@@ -6,7 +6,6 @@
  *  Author: AKASHI Takahiro
  */
 
-#include <common.h>
 #include <dm/tag.h>
 #include <dm/test.h> /* DM_TEST() */
 #include <test/test.h> /* struct unit_test_state */
diff --git a/test/dm/tee.c b/test/dm/tee.c
index 7a11bf891389..bb02a9b3c98b 100644
--- a/test/dm/tee.c
+++ b/test/dm/tee.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Linaro Limited
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/test/dm/test-dm.c b/test/dm/test-dm.c
index e73a1dd8f814..4bc2c45db61c 100644
--- a/test/dm/test-dm.c
+++ b/test/dm/test-dm.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013 Google, Inc
  */
 
-#include <common.h>
 #include <test/suites.h>
 #include <test/test.h>
 
diff --git a/test/dm/test-driver.c b/test/dm/test-driver.c
index 02cb974b0f74..851177c3018a 100644
--- a/test/dm/test-driver.c
+++ b/test/dm/test-driver.c
@@ -6,7 +6,6 @@
  * Pavel Herrmann <morpheus.ibis@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/test/dm/test-fdt.c b/test/dm/test-fdt.c
index 72d0eb57e212..18c89eef43fc 100644
--- a/test/dm/test-fdt.c
+++ b/test/dm/test-fdt.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/test/dm/test-uclass.c b/test/dm/test-uclass.c
index 067701734a08..9a80cc63667b 100644
--- a/test/dm/test-uclass.c
+++ b/test/dm/test-uclass.c
@@ -6,7 +6,6 @@
  * Pavel Herrmann <morpheus.ibis@gmail.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <dm.h>
diff --git a/test/dm/timer.c b/test/dm/timer.c
index 9f94d4769200..7fcefc42e595 100644
--- a/test/dm/timer.c
+++ b/test/dm/timer.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Thomas Chou <thomas@wytron.com.tw>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <timer.h>
 #include <dm/test.h>
diff --git a/test/dm/tpm.c b/test/dm/tpm.c
index cde933ab2848..0e413c0eedd0 100644
--- a/test/dm/tpm.c
+++ b/test/dm/tpm.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <tpm_api.h>
 #include <dm/test.h>
diff --git a/test/dm/usb.c b/test/dm/usb.c
index 7671ef156d84..9a571938b816 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <part.h>
diff --git a/test/dm/video.c b/test/dm/video.c
index d907f681600b..7dfbeb9555d1 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bzlib.h>
 #include <dm.h>
 #include <gzip.h>
diff --git a/test/dm/virtio.c b/test/dm/virtio.c
index 3e108cdc35d0..3efd7c74f427 100644
--- a/test/dm/virtio.c
+++ b/test/dm/virtio.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <virtio_types.h>
 #include <virtio.h>
diff --git a/test/dm/virtio_device.c b/test/dm/virtio_device.c
index fdda4da41781..63dc53415b73 100644
--- a/test/dm/virtio_device.c
+++ b/test/dm/virtio_device.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <virtio_types.h>
 #include <virtio.h>
diff --git a/test/dm/virtio_rng.c b/test/dm/virtio_rng.c
index 8b9a04b1fdef..ab7d862d79ef 100644
--- a/test/dm/virtio_rng.c
+++ b/test/dm/virtio_rng.c
@@ -4,7 +4,6 @@
  * Written by Andrew Scull <ascull@google.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <virtio_types.h>
 #include <virtio.h>
diff --git a/test/dm/wdt.c b/test/dm/wdt.c
index 2bbebcdbf286..1df2da23c6c7 100644
--- a/test/dm/wdt.c
+++ b/test/dm/wdt.c
@@ -3,9 +3,9 @@
  * Copyright 2017 Google, Inc
  */
 
-#include <common.h>
 #include <cyclic.h>
 #include <dm.h>
+#include <time.h>
 #include <wdt.h>
 #include <asm/gpio.h>
 #include <asm/state.h>
diff --git a/test/env/attr.c b/test/env/attr.c
index 8d5c0f1c3df4..de5d5d4ee27c 100644
--- a/test/env/attr.c
+++ b/test/env/attr.c
@@ -4,7 +4,6 @@
  * Joe Hershberger, National Instruments, joe.hershberger@ni.com
  */
 
-#include <common.h>
 #include <command.h>
 #include <env_attr.h>
 #include <test/env.h>
diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
index d65a32179ce1..13e0998341e7 100644
--- a/test/env/cmd_ut_env.c
+++ b/test/env/cmd_ut_env.c
@@ -4,7 +4,6 @@
  * Joe Hershberger, National Instruments, joe.hershberger@ni.com
  */
 
-#include <common.h>
 #include <command.h>
 #include <test/env.h>
 #include <test/suites.h>
diff --git a/test/env/fdt.c b/test/env/fdt.c
index 30bfa88c3550..c495ac7b307c 100644
--- a/test/env/fdt.c
+++ b/test/env/fdt.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <command.h>
 #include <env_attr.h>
 #include <test/env.h>
diff --git a/test/env/hashtable.c b/test/env/hashtable.c
index 70102f9121c2..ccdf0138c4b8 100644
--- a/test/env/hashtable.c
+++ b/test/env/hashtable.c
@@ -4,11 +4,11 @@
  * Roman Kapl, SYSGO, rka@sysgo.com
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <search.h>
 #include <stdio.h>
+#include <vsprintf.h>
 #include <test/env.h>
 #include <test/ut.h>
 
diff --git a/test/fuzz/cmd_fuzz.c b/test/fuzz/cmd_fuzz.c
index d0bc7b8d7b76..faa140433ff5 100644
--- a/test/fuzz/cmd_fuzz.c
+++ b/test/fuzz/cmd_fuzz.c
@@ -5,7 +5,6 @@
  */
 
 #include <command.h>
-#include <common.h>
 #include <dm.h>
 #include <fuzzing_engine.h>
 #include <test/fuzz.h>
diff --git a/test/fuzz/virtio.c b/test/fuzz/virtio.c
index 8a47667e7785..836eb9a2f660 100644
--- a/test/fuzz/virtio.c
+++ b/test/fuzz/virtio.c
@@ -4,7 +4,6 @@
  * Written by Andrew Scull <ascull@google.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <virtio.h>
 #include <virtio_ring.h>
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index e1036eff28ca..7cbad40ea0cd 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 #include <image.h>
 #include <imx_container.h>
 #include <mapmem.h>
diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index a89189e1124c..935078bf67b4 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <ext_common.h>
 #include <ext4fs.h>
diff --git a/test/image/spl_load_net.c b/test/image/spl_load_net.c
index 9d067a7a592f..4af6e21b8b98 100644
--- a/test/image/spl_load_net.c
+++ b/test/image/spl_load_net.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <spl.h>
 #include <test/spl.h>
diff --git a/test/image/spl_load_nor.c b/test/image/spl_load_nor.c
index de5686343b99..f53a6724e27f 100644
--- a/test/image/spl_load_nor.c
+++ b/test/image/spl_load_nor.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <spl.h>
 #include <asm/io.h>
diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index 26228a8a4a9c..7d5fb9b07e05 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <image.h>
 #include <os.h>
 #include <spl.h>
diff --git a/test/image/spl_load_spi.c b/test/image/spl_load_spi.c
index 54a95465e239..80836dc0dffa 100644
--- a/test/image/spl_load_spi.c
+++ b/test/image/spl_load_spi.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <spi_flash.h>
 #include <spl.h>
diff --git a/test/lib/abuf.c b/test/lib/abuf.c
index 42803b20e2a1..7c0481ab610b 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <abuf.h>
 #include <mapmem.h>
 #include <test/lib.h>
diff --git a/test/lib/asn1.c b/test/lib/asn1.c
index a66cdd77df0a..4842b7058ac5 100644
--- a/test/lib/asn1.c
+++ b/test/lib/asn1.c
@@ -6,7 +6,6 @@
  * Unit test for asn1 compiler and asn1 decoder function via various parsers
  */
 
-#include <common.h>
 #include <command.h>
 #include <test/lib.h>
 #include <test/test.h>
diff --git a/test/lib/cmd_ut_lib.c b/test/lib/cmd_ut_lib.c
index f1ac015b2c89..f98cb9b3c572 100644
--- a/test/lib/cmd_ut_lib.c
+++ b/test/lib/cmd_ut_lib.c
@@ -5,7 +5,6 @@
  * Unit tests for library functions
  */
 
-#include <common.h>
 #include <command.h>
 #include <test/lib.h>
 #include <test/suites.h>
diff --git a/test/lib/efi_device_path.c b/test/lib/efi_device_path.c
index 24e2f23c5af5..290c8768fa4c 100644
--- a/test/lib/efi_device_path.c
+++ b/test/lib/efi_device_path.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2020 Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <test/lib.h>
 #include <test/test.h>
diff --git a/test/lib/efi_image_region.c b/test/lib/efi_image_region.c
index 0b888f843378..3ca49dc4a2eb 100644
--- a/test/lib/efi_image_region.c
+++ b/test/lib/efi_image_region.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <test/lib.h>
 #include <test/test.h>
diff --git a/test/lib/getopt.c b/test/lib/getopt.c
index 3c68b93c8a59..388a076200b3 100644
--- a/test/lib/getopt.c
+++ b/test/lib/getopt.c
@@ -6,7 +6,6 @@
  * posix/tst-getopt-cancel.c
  */
 
-#include <common.h>
 #include <getopt.h>
 #include <test/lib.h>
 #include <test/test.h>
diff --git a/test/lib/hexdump.c b/test/lib/hexdump.c
index 5dccf4388663..d531a830398d 100644
--- a/test/lib/hexdump.c
+++ b/test/lib/hexdump.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <hexdump.h>
 #include <test/lib.h>
 #include <test/test.h>
diff --git a/test/lib/kconfig.c b/test/lib/kconfig.c
index 3914f699659f..0c463bb794a5 100644
--- a/test/lib/kconfig.c
+++ b/test/lib/kconfig.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/lib/kconfig_spl.c b/test/lib/kconfig_spl.c
index 8f8a3411b14f..3bd8abdf4b8e 100644
--- a/test/lib/kconfig_spl.c
+++ b/test/lib/kconfig_spl.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 7e4368de22e2..4b5b6e5e2098 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2018 Simon Goldschmidt
  */
 
-#include <common.h>
 #include <dm.h>
 #include <lmb.h>
 #include <log.h>
diff --git a/test/lib/longjmp.c b/test/lib/longjmp.c
index 201367a5a3a2..79d889bdd5fa 100644
--- a/test/lib/longjmp.c
+++ b/test/lib/longjmp.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2021, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/lib/rsa.c b/test/lib/rsa.c
index 44f8ade226f4..40f70010c788 100644
--- a/test/lib/rsa.c
+++ b/test/lib/rsa.c
@@ -6,7 +6,6 @@
  * Unit test for rsa_verify() function
  */
 
-#include <common.h>
 #include <command.h>
 #include <image.h>
 #include <test/lib.h>
diff --git a/test/lib/sscanf.c b/test/lib/sscanf.c
index 772e4b920425..9fe5521749fd 100644
--- a/test/lib/sscanf.c
+++ b/test/lib/sscanf.c
@@ -9,7 +9,6 @@
  * Unit tests for sscanf() function
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <test/lib.h>
diff --git a/test/lib/string.c b/test/lib/string.c
index 5dcf4d6db003..d08dbca92915 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -9,7 +9,6 @@
  * This has to be considered in testing.
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <test/lib.h>
diff --git a/test/lib/strlcat.c b/test/lib/strlcat.c
index d8453fe78e2c..d1a0293271b0 100644
--- a/test/lib/strlcat.c
+++ b/test/lib/strlcat.c
@@ -6,7 +6,6 @@
  * These tests adapted from glibc's string/test-strncat.c
  */
 
-#include <common.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/lib/test_aes.c b/test/lib/test_aes.c
index cbc712f7eda3..cfd9d8ca5a93 100644
--- a/test/lib/test_aes.c
+++ b/test/lib/test_aes.c
@@ -5,7 +5,6 @@
  * Unit tests for aes functions
  */
 
-#include <common.h>
 #include <command.h>
 #include <hexdump.h>
 #include <rand.h>
diff --git a/test/lib/test_crypt.c b/test/lib/test_crypt.c
index fb21edf97484..dcdadd992c15 100644
--- a/test/lib/test_crypt.c
+++ b/test/lib/test_crypt.c
@@ -5,7 +5,6 @@
  * Unit test for crypt-style password hashing
  */
 
-#include <common.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/lib/test_errno_str.c b/test/lib/test_errno_str.c
index 8a9f1fd9805a..67f76442b271 100644
--- a/test/lib/test_errno_str.c
+++ b/test/lib/test_errno_str.c
@@ -9,7 +9,6 @@
  * This has to be considered in testing.
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <test/lib.h>
diff --git a/test/lib/test_print.c b/test/lib/test_print.c
index 79b67c779321..c7fc50a1de17 100644
--- a/test/lib/test_print.c
+++ b/test/lib/test_print.c
@@ -5,7 +5,6 @@
  * Copyright 2020, Heinrich Schuchadt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <display_options.h>
 #include <asm/global_data.h>
diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index e24331a13668..0914f2c47e77 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -8,7 +8,6 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <common.h>
 #include <uuid.h>
 #include <test/lib.h>
 #include <test/test.h>
diff --git a/test/log/cont_test.c b/test/log/cont_test.c
index de7b7f064cd5..036d44b9d73d 100644
--- a/test/log/cont_test.c
+++ b/test/log/cont_test.c
@@ -5,7 +5,6 @@
  * Test continuation of log messages.
  */
 
-#include <common.h>
 #include <console.h>
 #include <asm/global_data.h>
 #include <test/log.h>
diff --git a/test/log/log_filter.c b/test/log/log_filter.c
index b644b40a850d..9cc891dc48c1 100644
--- a/test/log/log_filter.c
+++ b/test/log/log_filter.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 #include <console.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/test/log/log_test.c b/test/log/log_test.c
index c5abff80d111..855353a9c409 100644
--- a/test/log/log_test.c
+++ b/test/log/log_test.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/test/log/log_ut.c b/test/log/log_ut.c
index 5aa3a1840045..6617ed8b1525 100644
--- a/test/log/log_ut.c
+++ b/test/log/log_ut.c
@@ -5,7 +5,6 @@
  * Logging function tests.
  */
 
-#include <common.h>
 #include <console.h>
 #include <log.h>
 #include <test/log.h>
diff --git a/test/log/nolog_ndebug.c b/test/log/nolog_ndebug.c
index bd9a4f408e7b..b714a16d2e7e 100644
--- a/test/log/nolog_ndebug.c
+++ b/test/log/nolog_ndebug.c
@@ -5,7 +5,6 @@
  * Logging function tests for CONFIG_LOG=n without #define DEBUG
  */
 
-#include <common.h>
 #include <console.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/test/log/nolog_test.c b/test/log/nolog_test.c
index 4e52e5bed822..c4c0fa6cf81a 100644
--- a/test/log/nolog_test.c
+++ b/test/log/nolog_test.c
@@ -8,7 +8,6 @@
 /* Needed for testing log_debug() */
 #define DEBUG 1
 
-#include <common.h>
 #include <console.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/test/log/pr_cont_test.c b/test/log/pr_cont_test.c
index df4520d28075..30f30d98fe14 100644
--- a/test/log/pr_cont_test.c
+++ b/test/log/pr_cont_test.c
@@ -5,7 +5,6 @@
  * Test continuation of log messages using pr_cont().
  */
 
-#include <common.h>
 #include <console.h>
 #include <test/log.h>
 #include <test/test.h>
diff --git a/test/log/syslog_test.c b/test/log/syslog_test.c
index 4db649db8226..c4180f775b95 100644
--- a/test/log/syslog_test.c
+++ b/test/log/syslog_test.c
@@ -10,7 +10,6 @@
 /* Override CONFIG_LOG_MAX_LEVEL */
 #define LOG_DEBUG
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <dm/device.h>
 #include <hexdump.h>
diff --git a/test/log/syslog_test_ndebug.c b/test/log/syslog_test_ndebug.c
index 4438791044d0..b10e636812b5 100644
--- a/test/log/syslog_test_ndebug.c
+++ b/test/log/syslog_test_ndebug.c
@@ -7,7 +7,6 @@
  * Invoke the test with: ./u-boot -d arch/sandbox/dts/test.dtb
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <dm/device.h>
 #include <hexdump.h>
diff --git a/test/optee/cmd_ut_optee.c b/test/optee/cmd_ut_optee.c
index c3887ab11d92..c6f50e0995ac 100644
--- a/test/optee/cmd_ut_optee.c
+++ b/test/optee/cmd_ut_optee.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019, Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <fdt_support.h>
diff --git a/test/overlay/cmd_ut_overlay.c b/test/overlay/cmd_ut_overlay.c
index 56a3df17138b..bcb29a26e216 100644
--- a/test/overlay/cmd_ut_overlay.c
+++ b/test/overlay/cmd_ut_overlay.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2016 Free Electrons
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <fdt_support.h>
diff --git a/test/print_ut.c b/test/print_ut.c
index bb844d2542b7..bded2b6ebe5a 100644
--- a/test/print_ut.c
+++ b/test/print_ut.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2012, The Chromium Authors
  */
 
-#include <common.h>
 #include <command.h>
 #include <efi_api.h>
 #include <display_options.h>
diff --git a/test/stdint/int-types.c b/test/stdint/int-types.c
index f6d09e8643d6..9051e32c7ced 100644
--- a/test/stdint/int-types.c
+++ b/test/stdint/int-types.c
@@ -1,4 +1,4 @@
-#include <common.h>
+#include <linux/types.h>
 
 int test_types(void)
 {
diff --git a/test/str_ut.c b/test/str_ut.c
index fa9328ede501..389779859a3d 100644
--- a/test/str_ut.c
+++ b/test/str_ut.c
@@ -3,7 +3,6 @@
  * Copyright 2020 Google LLC
  */
 
-#include <common.h>
 #include <vsprintf.h>
 #include <test/suites.h>
 #include <test/test.h>
diff --git a/test/test-main.c b/test/test-main.c
index b7015d9f38dd..3fa6f6e32ec8 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <console.h>
 #include <cyclic.h>
diff --git a/test/time_ut.c b/test/time_ut.c
index 80b82dbfd833..149c4b58f4a1 100644
--- a/test/time_ut.c
+++ b/test/time_ut.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <time.h>
diff --git a/test/unicode_ut.c b/test/unicode_ut.c
index 47c3f52774cd..13e29c9b9e32 100644
--- a/test/unicode_ut.c
+++ b/test/unicode_ut.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2018 Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <charset.h>
 #include <command.h>
 #include <efi_loader.h>
diff --git a/test/ut.c b/test/ut.c
index 628e9dc98050..ae99831ac8ff 100644
--- a/test/ut.c
+++ b/test/ut.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2013 Google, Inc
  */
 
-#include <common.h>
 #include <console.h>
 #include <malloc.h>
 #ifdef CONFIG_SANDBOX
-- 
2.34.1

