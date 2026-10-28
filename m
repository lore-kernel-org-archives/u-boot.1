Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C460606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K7Yb3X2N;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kbHqeNOj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D9DA80BF7;
	Wed, 28 Oct 2026 13:36:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z4h-l5JfGv6V; Wed, 28 Oct 2026 13:36:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 06F0C80C81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793194583;
	b=lLhdo79msuHzSM6BLeiTBRHllQ13n3vAgfc0Sah81AXGO8o+o2DphcvxLtMTv5MIqzIR
	 b+GibVGRIoyw/jFl6E8Uy+CQD0UlMF50kOp9sjreNZKj7jL/+nhnuuqXFR4b920tITxRI
	 Wx5IZQGgtXL6Ijdpcba6cFV3umybgQqEtPk3QU/tk1l9eML6g8XY6kuA/MiFOjIkYQ/ud
	 ecZuhGrwfojYUOIBdj1ReYnGHTyQCsUWpoIMLztvj/MkjxwzawOo6GeqxksNwiGuueNha
	 oJWFAjjZl9+JA74vgJWBUdMj+wEabbXeLDjxs2IESTsa0pPgdLWA3EiIzcp9ohWfG5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793194583;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QzUw852Uxk6wqtS8ynj6fqKSb9Yr8PLQ8nGdM632FOI=;
	b=c44eJoUXvSrseGcXcV8B876O+dgc3I4rWvnG53Ord0bAXZrNKYImdaFhwZl6gzcib4wK
	 l+e2Zu9pauHrnkFhGNEbSx/jph70+DSX2B6bvicF2/fCnat5CiS53pnwZ1wR+Deg6oYk+
	 pQliwNQ5mt36eIbEX+AEneiGILTg+vvqFCLW9GY4ZD3gms7KhnU1njSRf8xpS5H2PdhVN
	 H3pqJ6u0FrcCR1+EzRmvQvbvMm+We5A9eCphpYfQhETmtK5QYAN4iDFUMj7UQQtXWD4kH
	 2UeUzDUuOaGPQ/KmW0lRkdRBRkUKp7eBTJMHJBdHIiD3/Vze/f1pNHktuO9c9dbfsdA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793194583;
	bh=QzUw852Uxk6wqtS8ynj6fqKSb9Yr8PLQ8nGdM632FOI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K7Yb3X2N8BxFqOTnReGcePQ+R1eEp0XSJTai03ri4koi2caVqoZaOmGuOTfnIzyQB
	 HdSh3xWeV2vOhUVSA3l6yMl/Ljxi9Eb4j+qhiDytcA2xYVS1S9CMbcLA+Y1f1DUMY/
	 1/YK61geuCCMzPESL6jZKEbHF0yDeqKTm60iiYXdMyJZH+9MYke88NTnqadwe7Ie6j
	 qqnBzsmiHi8rbkvB9swhl6DpzdS+kMdAYWXOFEgUSkufoRxzDDp0u/e0UPNF1qGSw0
	 p2ZLNL6/e5za7sAAbXMtQ3L4XB7//egPGNYatI0nYfXpp77h2I6ilQQqWjgaAAZFbv
	 I5mvPaTDKu9lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06F0C80C81;
	Wed, 28 Oct 2026 13:36:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E3DF972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24468401C8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:05:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9HZcvYoUFEj for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:05:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 20F75400F5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793163911;
 b=HX80fUhp50mX3VExfqkfY9zPc4IRf8cdYTtVsF8vxAsn6/QXPisQfvSa3J7ThuTdyuux
 xW/df1WiH3Y7vT00GH02P7qmNZGkjeWE3USdZCDwwUlACs27YzX4wi/SbjevUsROaMhlX
 GdNqX8FjmNtNsA90IrOfIHCHOvMtwSNLzbfLiiZAvxv/PPgnU8l4rR4XmH1ZD33LpbLdJ
 UXQi0N8qNsZX7s1KpYXiU+mk3dQ4IWwkf0M0lbcXhOrXHHAHm+LIDa+Mlzqv1j+SgT5Wl
 8mUlLIkcfqJdVasVO4E/EXIlKrC5foMrp6uRXNoK0Dyh2vIH5sK/Hw+4O+f0Ibl4Kgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793163911;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=QzUw852Uxk6wqtS8ynj6fqKSb9Yr8PLQ8nGdM632FOI=;
 b=XaV+GA0RHk2ziy6FU9Wa2rZ9O4+RJupQvrcUJiYOkA0gyvmg7O7dVSfCnCa5H5dXQ17X
 UMF5OtD7LzjzwrZGlD7SjDZcCX7Tj9HCNpurT8zf+HJ/L8Jat+lK+qKgn1/hTrGb/zEG7
 8C9HTZlsJqXE0aCRQMaHsyiAE+98MN2FCpPevZWxuHc8LbZk9vyixC/++ASgiTIRKqJJz
 z1SLSv6vuqN+MAGS1bqSAv9jcjjW5DsQ+eWhfQilGZggd1LhBhZ7HUVyxxQ96nKekl8U2
 hXePskeggo6VAtKDaCKEatG09klX8PuiqIlVppfkqlrjf82FCZ6LNiKZ6iht9IMk5HQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=kbHqeNOj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com;
 envelope-from=nguyenanhgiau1008@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=kbHqeNOj
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20F75400F5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:05:10 +0000 (UTC)
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-170135e43c7so796493c88.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793163910; x=1793768710;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QzUw852Uxk6wqtS8ynj6fqKSb9Yr8PLQ8nGdM632FOI=;
 b=kbHqeNOjr/zrGFmZjq6aClwgyTp/SR6K2kGrk2izx1+9/t6bkbIGkg77UGICQ6zTSl
 3KeGs/od7T3oEN1oDVcQEQVcNLLqWxnmIc9RPnJPQpcex8TgPb+DLAbh3h6sXTNKo46F
 XENa8rH8obYB1w9blbfXctuq61eYDYAacq5s452tJZUoAlDa3uVZg/i15pZUxVbFsX+i
 1MTeA58j/TP4nTM4NqTINmoz5n58z4r3gr3smdqMRkk3VvKoJiAaLxQdZhd0lha609kn
 i3MPimCEPdzin+MwnpWbUXuTGJDN53xEPkSPesrXw2OQCdliotOOnaqGZN7laxAKdScs
 50aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793163910; x=1793768710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QzUw852Uxk6wqtS8ynj6fqKSb9Yr8PLQ8nGdM632FOI=;
 b=QGJeR7qvTpdH3QlXZ9Q8J/JfEAQLs9t8/ZKfM58wLd6ls14Hh16sZpJ9gAOv7z0wLT
 hY5rBrEdM84CjwzQDWyCJ5J3ymYA1eZPsy3VLaFoX9BjE6SA5B4WZVMb6KeEL2drzHM2
 Dt5AfwWGPJvcggt1NuVTbniHD1RSmmQjeGjrdjNxIyVVAhzQjyov4ra66tK5qqZSV5+K
 BV5kmaG95r68KYvGWHx1NnIs2fR1ZC9oW2vLCDYSRUBsiFyjF3sVmHkb/SJNig7Ilk24
 NKXZv7sWgtdZiX8vX3UW6Cc8V+Xb8lOEWHNjCh26E7iNAn1EXoP/zuf1B26geaHpuRAe
 FtKQ==
X-Gm-Message-State: AFq9FYJPi/Ee+KfEFO9BsTetE4R/8a4ZHcQjk+4gTuKW/QyRxsuih8di
 xQHmdo/z4yZiag5FHrgcctmH/KWlICtqgtbm1Ex1aqwqopl9XZLkDuG2aUxoP+mLqQg=
X-Gm-Gg: AYBFou1E8s6dQUNu3zPKgEX3+/Wf8a6bCko0hsEqJY2inl8PaF1g7FEyuvCoKyG3iRR
 Nmd3oPExRmvOrs91qs2pR0OQ56YkzJ8RyPAGlkXNzOcOZJP4jIeQLShdJnCVdq2fFYUIk5+m9V+
 Nk24laV3ZD7nUiQMAgo1V//A7x/C0hk1MZi1uO87FR3ev5Yf3DyYg6OTrI3tUzy20leimtjyLIy
 HwoqLzcxsuy7HjudLmc8Cs/iksPdisNBP0EHhSa3I8ikakkztLP7r+dOxmUEseEoQbmbHfUsQAb
 y272S/OBo+/tfYwNI55ltPHEtf3dhwuIaLZHH5b2bgzpk6TreEc35nSmBUVHaB44b0msJjorWvj
 JzxFi2rEASX6pWwWNhucNucAt6BKwhVi6qaw1uOYhNbxYVQN4eqkSO+viz9l5o00W1q96Rt/iAD
 X0uMdsxM3SQLaYE5PWGc/F3/Mdzeg9n87uRRwibxOPLlxBLnHbw6ZwJpyZB2nxG1wJc/yy4Altg
 miVQBD8yDCGBa0eLI1qTfAR6pz+NL+Lst63rJjVDIsfTnwuEwOoXCCoJIh87FqCwwKyN+grU4ey
 xRP7kDg7zChDFh05g9L7+G07YQZwE23xL1lBvAtHxI+Eo67wMAMyh9oHsKIW
X-Received: by 2002:a05:7022:ff41:b0:19c:dd9b:d09e with SMTP id
 a92af1059eb24-1a6cced508dmr2516617c88.23.1793163909797; 
 Tue, 27 Oct 2026 22:05:09 -0700 (PDT)
Received: from R3700x.lan ([2405:4803:217b:bca0:5d93:2973:6540:69d1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75f7fb28csm2437149c88.18.2026.10.27.22.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 22:05:09 -0700 (PDT)
From: Giau Nguyen <nguyenanhgiau1008@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: hs@nabladev.com, mbrugger@suse.com, pbrobinson@gmail.com,
 trini@konsulko.com, Giau Nguyen <nguyenanhgiau1008@gmail.com>
Subject: [PATCH] i2c: bcm283x: Refactor driver to support BCM2711 (Raspberry
 Pi 4)
Date: Wed, 28 Oct 2026 12:04:41 +0700
Message-Id: <20261028050441.380764-1-nguyenanhgiau1008@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 13:36:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The existing bcm283x I2C driver relies on a hardcoded clock rate
which breaks I2C communication on the BCM2711 (Raspberry Pi 4),
where the VPU core clock is dynamically scaled by the firmware.

This patch completely refactors the driver (based on Linux kernel's
i2c-bcm2835.c) to bring it up to standard:
- Queries the actual core clock via BCM2835 Mailbox property tags.
- Calculates the CDIV divider dynamically based on the firmware clock.
- Adds the "brcm,bcm2711-i2c" compatible string.
- Improves FIFO drain/fill and hardware timeout polling.

Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
---
 MAINTAINERS               |   1 +
 drivers/i2c/Kconfig       |  10 +
 drivers/i2c/Makefile      |   1 +
 drivers/i2c/i2c-bcm2835.c | 411 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 423 insertions(+)
 create mode 100644 drivers/i2c/i2c-bcm2835.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c6c0c2a4bc..3260024a736 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -215,6 +215,7 @@ F:	arch/arm/dts/bcm283*
 F:	arch/arm/mach-bcm283x/
 F:	board/raspberrypi/
 F:	drivers/gpio/bcm2835_gpio.c
+F:	drivers/i2c/i2c-bcm2835.c
 F:	drivers/mmc/bcm2835_sdhci.c
 F:	drivers/mmc/bcm2835_sdhost.c
 F:	drivers/serial/serial_bcm283x_mu.c
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 52067fa7c1f..19bd60ecdac 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -782,6 +782,16 @@ config SYS_I2C_XILINX_XIIC
 	help
 	  Support for Xilinx AXI I2C controller.
 
+config SYS_I2C_BCM2835
+	bool "BCM2835 I2C controller"
+	depends on DM_I2C
+	help
+	  Enable support for the Broadcom BCM2835/BCM2711 I2C controller.
+	  This driver provides standard I2C support for Raspberry Pi
+	  devices, including the newer Raspberry Pi 4. It dynamically
+	  calculates the clock divider based on the VPU core clock
+	  queried via the firmware mailbox.
+
 config SYS_I2C_IHS
         bool "gdsys IHS I2C driver"
         depends on DM_I2C
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index bebd728e7da..e2c252cf16c 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_SYS_I2C_UNIPHIER) += i2c-uniphier.o
 obj-$(CONFIG_SYS_I2C_UNIPHIER_F) += i2c-uniphier-f.o
 obj-$(CONFIG_SYS_I2C_VERSATILE) += i2c-versatile.o
 obj-$(CONFIG_SYS_I2C_XILINX_XIIC) += xilinx_xiic.o
+obj-$(CONFIG_SYS_I2C_BCM2835) += i2c-bcm2835.o
 obj-$(CONFIG_TEGRA186_BPMP_I2C) += tegra186_bpmp_i2c.o
 
 obj-$(CONFIG_$(XPL_)I2C_MUX) += muxes/
diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
new file mode 100644
index 00000000000..93d19cb8e5a
--- /dev/null
+++ b/drivers/i2c/i2c-bcm2835.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BCM2835 I2C controller driver
+ * (C) Copyright 2026
+ *
+ * Author: Giau Nguyen <nguyenanhgiau1008@gmail.com>
+ * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c
+ * Assisted by AI
+ */
+
+#include <log.h>
+#include <asm/io.h>
+#include <asm/arch/mbox.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <i2c.h>
+#include <memalign.h>
+#include <time.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/types.h>
+
+#define BCM2835_I2C_C		0x0
+#define BCM2835_I2C_S		0x4
+#define BCM2835_I2C_DLEN	0x8
+#define BCM2835_I2C_A		0xc
+#define BCM2835_I2C_FIFO	0x10
+#define BCM2835_I2C_DIV		0x14
+#define BCM2835_I2C_DEL		0x18
+/*
+ * 16-bit field for the number of SCL cycles to wait after rising SCL
+ * before deciding the slave is not responding. 0 disables the
+ * timeout detection.
+ */
+#define BCM2835_I2C_CLKT	0x1c
+
+#define BCM2835_I2C_C_READ	BIT(0)
+#define BCM2835_I2C_C_CLEAR	BIT(4) /* bits 4 and 5 both clear */
+#define BCM2835_I2C_C_ST	BIT(7)
+#define BCM2835_I2C_C_INTD	BIT(8)
+#define BCM2835_I2C_C_INTT	BIT(9)
+#define BCM2835_I2C_C_INTR	BIT(10)
+#define BCM2835_I2C_C_I2CEN	BIT(15)
+
+#define BCM2835_I2C_S_TA	BIT(0)
+#define BCM2835_I2C_S_DONE	BIT(1)
+#define BCM2835_I2C_S_TXW	BIT(2)
+#define BCM2835_I2C_S_RXR	BIT(3)
+#define BCM2835_I2C_S_TXD	BIT(4)
+#define BCM2835_I2C_S_RXD	BIT(5)
+#define BCM2835_I2C_S_TXE	BIT(6)
+#define BCM2835_I2C_S_RXF	BIT(7)
+#define BCM2835_I2C_S_ERR	BIT(8)
+#define BCM2835_I2C_S_CLKT	BIT(9)
+#define BCM2835_I2C_S_LEN	BIT(10) /* Fake bit for SW error reporting */
+
+#define BCM2835_I2C_FEDL_SHIFT	16
+#define BCM2835_I2C_REDL_SHIFT	0
+
+#define BCM2835_I2C_CDIV_MIN	0x0002
+#define BCM2835_I2C_CDIV_MAX	0xFFFE
+
+#define BCM2835_I2C_CLKT_TOUT_MS 35
+#define BCM2835_I2C_XFER_TIMEOUT_MS 1000
+
+struct bcm2835_i2c_priv {
+	void __iomem *regs;
+	ulong input_rate;
+	size_t msg_buf_remaining;
+	u8 *msg_buf;
+	struct i2c_msg *curr_msg;
+	int msg_err;
+	int num_msgs;
+};
+
+struct bcm2835_i2c_clock_msg {
+	struct bcm2835_mbox_hdr hdr;
+	struct bcm2835_mbox_tag_get_clock_rate get_clock_rate;
+	u32 end_tag;
+};
+
+static int bcm2835_i2c_get_input_rate(ulong *rate)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(struct bcm2835_i2c_clock_msg, msg, 1);
+	int ret;
+
+	BCM2835_MBOX_INIT_HDR(msg);
+	BCM2835_MBOX_INIT_TAG(&msg->get_clock_rate, GET_CLOCK_RATE);
+	msg->get_clock_rate.body.req.clock_id = BCM2835_MBOX_CLOCK_ID_CORE;
+
+	ret = bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN, &msg->hdr);
+	if (ret)
+		return ret;
+
+	*rate = msg->get_clock_rate.body.resp.rate_hz;
+	return *rate ? 0 : -EINVAL;
+}
+
+static inline void bcm2835_i2c_writel(struct bcm2835_i2c_priv *i2c_dev,
+				      u32 reg, u32 val)
+{
+	writel(val, i2c_dev->regs + reg);
+}
+
+static inline u32 bcm2835_i2c_readl(struct bcm2835_i2c_priv *i2c_dev, u32 reg)
+{
+	return readl(i2c_dev->regs + reg);
+}
+
+static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)
+{
+	u32 val;
+
+	while (i2c_dev->msg_buf_remaining) {
+		val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
+		if (!(val & BCM2835_I2C_S_TXD))
+			break;
+		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_FIFO,
+				   *i2c_dev->msg_buf);
+		i2c_dev->msg_buf++;
+		i2c_dev->msg_buf_remaining--;
+	}
+}
+
+static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)
+{
+	u32 val;
+
+	while (i2c_dev->msg_buf_remaining) {
+		val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
+		if (!(val & BCM2835_I2C_S_RXD))
+			break;
+		*i2c_dev->msg_buf = bcm2835_i2c_readl(i2c_dev,
+						      BCM2835_I2C_FIFO);
+		i2c_dev->msg_buf++;
+		i2c_dev->msg_buf_remaining--;
+	}
+}
+
+static int bcm2835_i2c_calc_divider(unsigned long rate,
+				unsigned long parent_rate)
+{
+	int divider = DIV_ROUND_UP(parent_rate, rate);
+
+	/*
+	 * Per the datasheet, the register is always interpreted as an even
+	 * number, by rounding down. In other words, the LSB is ignored. So,
+	 * if the LSB is set, increment the divider to avoid any issue.
+	 */
+	if (divider & 1)
+		divider++;
+	if ((divider < BCM2835_I2C_CDIV_MIN) ||
+	    (divider > BCM2835_I2C_CDIV_MAX))
+		return -EINVAL;
+
+	return divider;
+}
+
+static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rate)
+{
+	struct bcm2835_i2c_priv *i2c_dev = dev_get_priv(bus);
+	ulong parent_rate = i2c_dev->input_rate;
+	u32 redl, fedl;
+	u32 clk_tout;
+	int divider;
+
+	if (!rate || !parent_rate)
+		return -EINVAL;
+
+	divider = bcm2835_i2c_calc_divider(rate, parent_rate);
+	if (divider < 0)
+		return divider;
+
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
+
+	/*
+	 * Number of core clocks to wait after falling edge before
+	 * outputting the next data bit.  Note that both FEDL and REDL
+	 * can't be greater than CDIV/2.
+	 */
+	fedl = max_t(u32, divider / 16, 1);
+
+	/*
+	 * Number of core clocks to wait after rising edge before
+	 * sampling the next incoming data bit.
+	 */
+	redl = max_t(u32, divider / 4, 1);
+
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DEL,
+			   (fedl << BCM2835_I2C_FEDL_SHIFT) |
+			   (redl << BCM2835_I2C_REDL_SHIFT));
+
+	/*
+	 * Set the clock stretch timeout.
+	 */
+	if (rate > 0xffff * 1000 / BCM2835_I2C_CLKT_TOUT_MS)
+		clk_tout = 0xffff;
+	else
+		clk_tout = BCM2835_I2C_CLKT_TOUT_MS * rate / 1000;
+
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_CLKT, clk_tout);
+
+	return 0;
+}
+
+static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_dev)
+{
+	u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
+	struct i2c_msg *msg = i2c_dev->curr_msg;
+	bool last_msg = (i2c_dev->num_msgs == 1);
+
+	if (!i2c_dev->num_msgs)
+		return;
+
+	i2c_dev->num_msgs--;
+	i2c_dev->msg_buf = msg->buf;
+	i2c_dev->msg_buf_remaining = msg->len;
+
+	if (msg->flags & I2C_M_RD)
+		c |= BCM2835_I2C_C_READ;
+	else
+		c |= BCM2835_I2C_C_INTT;
+
+	if (last_msg)
+		c |= BCM2835_I2C_C_INTD;
+
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_A, msg->addr);
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DLEN, msg->len);
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
+}
+
+static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv *i2c_dev)
+{
+	i2c_dev->curr_msg = NULL;
+	i2c_dev->num_msgs = 0;
+
+	i2c_dev->msg_buf = NULL;
+	i2c_dev->msg_buf_remaining = 0;
+}
+
+static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs, int count)
+{
+	struct bcm2835_i2c_priv *i2c_dev = dev_get_priv(dev);
+	bool ignore_nak = false;
+	bool done = false;
+	ulong start;
+	int i;
+	u32 val, err;
+	int ret = 0;
+
+	if (!msgs || count <= 0)
+		return -EINVAL;
+
+	for (i = 0; i < count; i++) {
+		if (msgs[i].flags & I2C_M_TEN)
+			return -EOPNOTSUPP;
+		if (msgs[i].flags & I2C_M_RD) {
+			if (i < count - 1) {
+				dev_err(dev, "read message must be last\n");
+				return -EOPNOTSUPP;
+			}
+		}
+		if (msgs[i].len > 0xffff)
+			return -EINVAL;
+		if (msgs[i].flags & I2C_M_IGNORE_NAK)
+			ignore_nak = true;
+	}
+
+	/* Clear stale status and FIFO state before starting a new transaction. */
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S,
+			   BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR |
+			   BCM2835_I2C_S_DONE);
+
+	i2c_dev->curr_msg = msgs;
+	i2c_dev->num_msgs = count;
+	i2c_dev->msg_err = 0;
+
+	bcm2835_i2c_start_transfer(i2c_dev);
+	start = get_timer(0);
+	while (get_timer(start) < BCM2835_I2C_XFER_TIMEOUT_MS) {
+		val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
+
+		err = val & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);
+		if (err && !(val & BCM2835_I2C_S_TA))
+			i2c_dev->msg_err = err;
+
+		if (val & BCM2835_I2C_S_DONE) {
+			if (!i2c_dev->curr_msg) {
+				dev_err(dev, "unexpected completion status\n");
+			} else if (i2c_dev->curr_msg->flags & I2C_M_RD) {
+				bcm2835_drain_rxfifo(i2c_dev);
+				val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
+			}
+
+			if ((val & BCM2835_I2C_S_RXD) ||
+			    i2c_dev->msg_buf_remaining)
+				i2c_dev->msg_err = BCM2835_I2C_S_LEN;
+			done = true;
+			break;
+		}
+
+		if (val & BCM2835_I2C_S_TXW) {
+			if (!i2c_dev->msg_buf_remaining) {
+				i2c_dev->msg_err = val | BCM2835_I2C_S_LEN;
+				break;
+			}
+
+			bcm2835_fill_txfifo(i2c_dev);
+
+			if (i2c_dev->num_msgs > 0 && !i2c_dev->msg_buf_remaining) {
+				i2c_dev->curr_msg++;
+				bcm2835_i2c_start_transfer(i2c_dev);
+			}
+		}
+
+		if (val & BCM2835_I2C_S_RXR) {
+			if (!i2c_dev->msg_buf_remaining) {
+				i2c_dev->msg_err = val | BCM2835_I2C_S_LEN;
+				break;
+			}
+
+			bcm2835_drain_rxfifo(i2c_dev);
+		}
+		udelay(1);
+	}
+
+	if (!done) {
+		val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
+		dev_err(dev, "transfer timeout: status=%08x remaining=%zu\n",
+			val, i2c_dev->msg_buf_remaining);
+		ret = -ETIMEDOUT;
+	}
+
+	/* Always abort/reset the controller and clear W1C status bits. */
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S, BCM2835_I2C_S_CLKT |
+			   BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE);
+
+	bcm2835_i2c_finish_transfer(i2c_dev);
+	if (ret)
+		return ret;
+
+	if (ignore_nak)
+		i2c_dev->msg_err &= ~BCM2835_I2C_S_ERR;
+
+	if (!i2c_dev->msg_err)
+		return 0;
+
+	if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
+		return -EREMOTEIO;
+
+	return -EIO;
+}
+
+static const struct dm_i2c_ops bcm2835_i2c_ops = {
+	.xfer          = bcm2835_i2c_xfer,
+	.set_bus_speed = bcm2835_i2c_set_rate,
+};
+
+static const struct udevice_id bcm2835_i2c_ids[] = {
+	{.compatible = "brcm,bcm2711-i2c"},
+	{.compatible = "brcm,bcm2835-i2c"},
+	{}
+};
+
+static int bcm2835_i2c_probe(struct udevice *bus)
+{
+	struct bcm2835_i2c_priv *priv = dev_get_priv(bus);
+	unsigned int bus_clk_rate;
+	int ret;
+
+	priv->regs = dev_read_addr_ptr(bus);
+	if (!priv->regs) {
+		printf("bcm2835_i2c: cannot get base address\n");
+		return -EINVAL;
+	}
+
+	ret = bcm2835_i2c_get_input_rate(&priv->input_rate);
+	if (ret)
+		return ret;
+
+	bus_clk_rate = dev_read_u32_default(bus, "clock-frequency",
+					   I2C_SPEED_STANDARD_RATE);
+	ret = bcm2835_i2c_set_rate(bus, bus_clk_rate);
+	if (ret)
+		return ret;
+
+	/* clear FIFO + status */
+	bcm2835_i2c_writel(priv,
+			   BCM2835_I2C_C,
+			   BCM2835_I2C_C_CLEAR);
+
+	bcm2835_i2c_writel(priv,
+			   BCM2835_I2C_S,
+			   BCM2835_I2C_S_CLKT |
+			   BCM2835_I2C_S_ERR |
+			   BCM2835_I2C_S_DONE);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(bcm2835_i2c) = {
+	.name       = "bcm2835_i2c",
+	.id         = UCLASS_I2C,
+	.of_match   = bcm2835_i2c_ids,
+	.probe      = bcm2835_i2c_probe,
+	.priv_auto  = sizeof(struct bcm2835_i2c_priv),
+	.ops        = &bcm2835_i2c_ops,
+};
-- 
2.34.1

