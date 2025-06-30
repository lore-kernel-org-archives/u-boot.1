Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548BFC8302F
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 12:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D3D82EB8;
	Mon, 30 Jun 2025 14:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NjDxT/Ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 458CB82E6A; Mon, 30 Jun 2025 12:08:35 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 195FE82C2F
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso19149205e9.2
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751278104; x=1751882904;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4VWHDocLtEK1+cexKejnv3SKZwm5Jk30yEvMTco57JM=;
 b=NjDxT/EyqjiDNVazYpxjWVLvBB84GJAj2nvX4Ui6pjZyLV00ogFcm+mlegUgutb/eC
 EMWKdbNiUfsTrtJ2KioUwhc8UipwVuMSsgGzKtxWdO4DFgse4vNyjG8yNcd7r7KhTSs8
 Jtd60bUuDugbFqPSUXOyuNLOWZLs4R39CEFENuaFJsu7itSxHBkOLE9tmbk6QDX5CY7B
 c3mh84l6UgKlXZAi8JXTMueXi82mKhPdbgiBrMCzg7bcuV4LdQ5GpqBkLCzBCHIFjwp9
 TmRAC0BBjarRiaXlnpmPYhf8PZ2gYYpP0IZWy/+dEX+3oUweeURggaRE2LdRXFinFo1C
 +zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751278104; x=1751882904;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VWHDocLtEK1+cexKejnv3SKZwm5Jk30yEvMTco57JM=;
 b=qqhcdpAMASqhiQ7T/+Yb0jUm3g/C5jG3FyPCuAtTd0yI4roO894E3l7DLcdGfm/+qz
 p+cXHsQ/YA1O7CZC5n6+iBztaCZyHHK63O9qDU8UCBYa1mO/0ikXk17bk9WxUGh0mFmw
 8bAa0s8XcKdnveN4fVZrWMl8u0i+bliqx3rwrQ2g2iJBLIo+4h++22NftTWWsjb/QGzf
 zcrVWErfPpvQVlMyPWgCxrIMYBOEBn6bnpVXRX4nLAD/kJ1WL6bQufcQ2nsIrcQIxi7N
 UK9yMfDVxhplXcQej8s8KqN4rNh25dbhKTyLQwbZyhcv3h/y/gKkiqLf/B4bj3oKSl+c
 20Fg==
X-Gm-Message-State: AOJu0Yz+PneYBTaHznqTsOcFP/qubJ4Nzi/1nbfKcCRytaNq7DatqXwm
 f6GukMIiiC2trMD/thFTRuIRI8mXZiaC3hT2GG3SBrjJxAfB1+DZiEKr8zB4NAodx+6ZNFlshzx
 NQOFTsgY=
X-Gm-Gg: ASbGncvmU3E+F9nOThwMcm8uNtS2VgDLvlsnhxW0PvNPjoUJ6UR87fH+SiZdzIOfbVu
 IDQI+Pbszi5KTwWXcj3DAM3d/3tDOYf121KJlX+bYqyD87F0C52LLVCFdqlUwhcNBSyS/w8qxpE
 zsHY80GE/cg8QR5K3XszMrzgHHNaOFvlo4hgg7PU358j+cNET9gQAwFY5Ym0e+xC/qk38ikRgU8
 yNJ8MXKuk+A8X6Y0ckXtP1F/4B68WRSQOkpHL8u5rcaMp4xDWNzulKom+IZ89/8dcNGoWNt/f/A
 nV2b1zTCm5WGmW6GAueW/bVq1hkJGypyT8mD3IADuR40zEFqYnAvagEvwq4n1R45nsAanjNNhWi
 PqxJdCBsXdogyZIsXlTSd8IvRVaM1NG4nJxX/PnXC4viHPdf79c7J
X-Google-Smtp-Source: AGHT+IGlcy5QUKyEPZkvcjl+dmXTx7zCYzxKF2cp8gjpT2KxIuf9CxVdklHU8RI8NwI0HUDcq0ZpEQ==
X-Received: by 2002:a05:600c:3584:b0:453:81a:2f3f with SMTP id
 5b1f17b1804b1-453900db214mr134456185e9.30.1751278104473; 
 Mon, 30 Jun 2025 03:08:24 -0700 (PDT)
Received: from [172.18.0.1]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f923sm9737883f8f.89.2025.06.30.03.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 03:08:22 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 30 Jun 2025 12:08:16 +0200
Subject: [PATCH 2/2] cmd: add new command to read edid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-read_edid_cleanup-v1-2-ec7d425472c7@baylibre.com>
References: <20250630-read_edid_cleanup-v1-0-ec7d425472c7@baylibre.com>
In-Reply-To: <20250630-read_edid_cleanup-v1-0-ec7d425472c7@baylibre.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 30 Jun 2025 14:18:06 +0200
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

Add a new command to read EDID info from connected display.

When applicable EDID can also be retrieved by commands such as:

  i2c dev x
  i2c edid 0x50

but the new read_edid function relies on the implementation of the
read_edid callback from DISPLAY driver.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 cmd/Kconfig                    |  6 ++++++
 cmd/Makefile                   |  1 +
 cmd/read_edid.c                | 37 +++++++++++++++++++++++++++++++++++++
 drivers/video/display-uclass.c |  2 +-
 include/display.h              | 10 ++++++++++
 5 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f21d27cb27f28267963e0d264e4cb9e7e791b0e8..3018e33ca7d5730c1353e1b30a689261c2b01907 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1608,6 +1608,12 @@ config CMD_READ
 	help
 	  Provides low-level access to the data in a partition.
 
+config CMD_READ_EDID
+	bool "read_edid - Read display EDID"
+	depends on DISPLAY
+	help
+	  Read and parse edid from connected display device.
+
 config CMD_REMOTEPROC
 	bool "remoteproc"
 	depends on REMOTEPROC
diff --git a/cmd/Makefile b/cmd/Makefile
index 80cf70b7fe8c1747db37d7cb1428863a671560b5..7cb379c05a01237133eab24c085a47c3f5386626 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -154,6 +154,7 @@ obj-$(CONFIG_CMD_WOL) += wol.o
 obj-$(CONFIG_CMD_QFW) += qfw.o
 obj-$(CONFIG_CMD_READ) += read.o
 obj-$(CONFIG_CMD_WRITE) += read.o
+obj-$(CONFIG_CMD_READ_EDID) += read_edid.o
 obj-$(CONFIG_CMD_REGINFO) += reginfo.o
 obj-$(CONFIG_CMD_REMOTEPROC) += remoteproc.o
 obj-$(CONFIG_CMD_RNG) += rng.o
diff --git a/cmd/read_edid.c b/cmd/read_edid.c
new file mode 100644
index 0000000000000000000000000000000000000000..30b03d616ab81a8378c9655775f703d8e8fd2a31
--- /dev/null
+++ b/cmd/read_edid.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 BayLibre, SAS
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <edid.h>
+
+static int do_read_edid(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	struct udevice *dev;
+	int ret;
+	u8 edid[EDID_EXT_SIZE];
+
+	/* Get the first display device (UCLASS_DISPLAY) */
+	ret = uclass_first_device_err(UCLASS_DISPLAY, &dev);
+	if (ret) {
+		printf("Cannot get display device: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = display_read_edid(dev, edid, EDID_EXT_SIZE);
+	if (ret) {
+		printf("Cannot read edid: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	edid_print_info((struct edid1_info *)edid);
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(read_edid, 1, 0, do_read_edid,
+	"Read and print EDID from display",
+	""
+);
diff --git a/drivers/video/display-uclass.c b/drivers/video/display-uclass.c
index 57e730538dfd70513c4746653719440d973aed6a..85dac12a197e8e527ffa8217768c1e2a967585cd 100644
--- a/drivers/video/display-uclass.c
+++ b/drivers/video/display-uclass.c
@@ -10,7 +10,7 @@
 #include <edid.h>
 #include <errno.h>
 
-static int display_read_edid(struct udevice *dev, u8 *buf, int buf_size)
+int display_read_edid(struct udevice *dev, u8 *buf, int buf_size)
 {
 	struct dm_display_ops *ops = display_get_ops(dev);
 
diff --git a/include/display.h b/include/display.h
index e8d8aaa15fbcbf0b2bcaeec0d612ad66346d28c3..26b965daba9384e8e351a4a5fc6f4703b8d8511d 100644
--- a/include/display.h
+++ b/include/display.h
@@ -25,6 +25,16 @@ struct display_plat {
 	bool in_use;
 };
 
+/**
+ * display_read_edid() - Read edid from display
+ *
+ * @dev:	Device to read from
+ * @buf:	Buffer to read into (should be EDID_SIZE bytes)
+ * @buf_size:	Buffer size (should be EDID_SIZE)
+ * Return number of bytes read, <= 0 for error
+ */
+int display_read_edid(struct udevice *dev, u8 *buf, int buf_size);
+
 /**
  * display_read_timing() - Read timing information
  *

-- 
2.49.0

