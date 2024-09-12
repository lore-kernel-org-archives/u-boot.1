Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E33EE57C7
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 943A788E08;
	Thu, 12 Sep 2024 08:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RFnTrRJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BCDA88DAF; Thu, 12 Sep 2024 08:06:59 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC8AD88D9A
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c3df1a3cb6so112905a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121216; x=1726726016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSVF56jI0SAxeTr7ecNh2ccSZTLatNX4L70TQd7wy8U=;
 b=RFnTrRJWtSNkZ0H+vXyUFrX47RCFXl1N1wUhMeWzSXtPeHPCMrJlCI/mw+HHUybHr9
 YVnLgWDU7K9hUqqRaaBQfg1TglVrVeFL/L5Qf8kdCskePKOCmp3XYDjoQniawX6A0e1Y
 8S6cwrhidiBROkvjcDIqK1Y30l++fu2C7w42efOlOId37pTBtFTaXQL6t9SBoR2vQAsV
 unBNym6+Q+tnzxVdlP6qYdG9b8lNhtPLQCqDP3I+ccKSQNttODbVwG0P/X/NFTsvxYVg
 j8FaAqPBBEoQbMmTMC9OG7u9CdLeXTcAHUIJ30z8vNiAAKCWMLbOTNmLqkSuQTycA9Aq
 HqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121216; x=1726726016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSVF56jI0SAxeTr7ecNh2ccSZTLatNX4L70TQd7wy8U=;
 b=bFaCgab0Xn1DUJvUYZDAzXdPz4XL3+CTlIlS7XlN2Z1bGGujP/oR1e7WmLW9AcLEer
 JGVBlPmaW9pFRe2kg/3IwT9SS8d+xL9n/BwQI4kwVgz0xdg1jZVg5MzWtjIwDkGgG3I2
 w/dZi3gBh14BWoMxMybcNSmN2wfUe9HyQmshqvscPo7LgN2GvWjUmJM6o9JPQEvSwUUi
 uoBQEs4n1ek9Z0eOOAuqs2O6YAuy6aroAP3pPJyZwQ9ryVPKyvxaiNf8veOekNM49enK
 n895JoIgIDdQRn6HK1b/H6DgwxtCAq07DDbTp8onKI3hWm72Fc9XCS5kS7CHRs2uMkJa
 Hr1g==
X-Gm-Message-State: AOJu0YxRmo1aAbL4c25MjQhcAPDDb/s5CSD9iAKoTApk2goZ4qeHBnMI
 NIeosMwi3PdsSMBJ3bZm0Hmjlg1OipkJA5OtSQYwNrRol3ZXjt5037lgFw==
X-Google-Smtp-Source: AGHT+IF5qx9vlJHYXcCzGddm0CRhC6xxmiN5WcrJctqu4OV5BVyw4dddqN0omXBJiHDMmYlcVgwGpQ==
X-Received: by 2002:a17:907:724e:b0:a8d:2623:cd4c with SMTP id
 a640c23a62f3a-a9029663244mr52005866b.14.1726121215885; 
 Wed, 11 Sep 2024 23:06:55 -0700 (PDT)
Received: from 77c10117340a.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2598b844sm698112866b.76.2024.09.11.23.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:06:55 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH 5/9] ARM: socfpga: add Enclustra AA1 demo env files
Date: Thu, 12 Sep 2024 06:06:45 +0000
Message-Id: <20240912060649.190-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912060649.190-1-l.rubusch@gmail.com>
References: <20240912060649.190-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 08:13:00 +0200
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

Provide additional uboot.env text environment files meant as a generic
demo. The default environment uses a uboot.env. The default environment
works somehow. This environment provides better support but only shows
one possible approach used in the Enclustra reference design setups.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 board/enclustra/mercury_aa1/mercury_aa1.env | 65 +++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 board/enclustra/mercury_aa1/mercury_aa1.env

diff --git a/board/enclustra/mercury_aa1/mercury_aa1.env b/board/enclustra/mercury_aa1/mercury_aa1.env
new file mode 100644
index 0000000000..07b4a95a75
--- /dev/null
+++ b/board/enclustra/mercury_aa1/mercury_aa1.env
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Enclustra GmbH
+ * <info@enclustra.com>
+ *
+ * This is an example configuration file for uboot.env generation.
+ *
+ * Given ENV_FAT_FILE defaults to "uboot.env" and ENV_SIZE defaults to 0x80000
+ * (see configuration options). Then adjust the configuration to your needs and
+ * build the a binary .env file as follows
+ * $ ./tools/mkenvimage -s 0x80000 -o uboot.env ./board/enclustra/mercury_aa1/mercury_aa1.env
+ *
+ * NB: Without providing this binary uboot.env the board is supposed to come up
+ * with the generic environment based on the architecture. This can be helpful
+ * when upgrading and/or recuding environments.
+ */
+bitstream_size=0xD00000
+bootargs=earlycon console=ttyS0,115200 rw rootwait root=/dev/mmcblk0p3
+bootargs_qspi=earlycon console=ttyS0,115200 rw root=/dev/ram0
+bootm_size=0x0a000000
+devnum=0
+devtype=mmc
+distro_bootpart=1
+env_size=0x80000
+fdt_addr_r=0x10000000
+fdtfile=system.dtb
+fdtload=
+	load ${devtype} ${devnum}:${distro_bootpart} ${fdt_addr_r} ${bootdir}/${fdtfile};
+	load ${devtype} ${devnum}:${distro_bootpart} ${fdto_addr_r} ${bootdir}/${fdtofile};
+	fdt addr $fdt_addr_r;
+	fdt resize 8192;
+	fdt apply $fdto_addr_r
+fdtload_qspi=
+	sf probe;
+	sf read ${fdt_addr_r} ${qspi_offset_addr_devicetree} ${fdt_size};
+	sf read ${fdto_addr_r} ${qspi_offset_addr_dtoverlay} ${fdto_size};
+	fdt addr ${fdt_addr_r};
+	fdt resize 8192;
+	fdt apply ${fdto_addr_r}
+fdto_addr_r=0x100c0000
+fdtofile=socfpga_enclustra_mercury_sdmmc_overlay.dtbo
+fdto_size=0x40000
+fdt_size=0x40000
+kernel_addr_r=0x11000000
+kernel_size=0x1000000
+qspiboot=source ${scriptaddr}
+qspiload=
+	setenv bootargs ${bootargs_qspi};
+	sf probe;
+	sf read ${scriptaddr} ${qspi_offset_addr_boot_script} ${scriptsize}
+qspi_offset_addr_bitstream=0x300000
+qspi_offset_addr_boot_script=0x200000
+qspi_offset_addr_devicetree=0x280000
+qspi_offset_addr_dtoverlay=0x2c0000
+qspi_offset_addr_kernel=0x1000000
+qspi_offset_addr_rootfs=0x2000000
+qspi_offset_addr_spl=0x0
+qspi_offset_addr_uboot=0x100000
+qspi_offset_addr_uboot_env=0x180000
+rootfs_addr_r=0x12000000
+rootfs_size=0x2000000
+scriptaddr=0x10800000
+scriptsize=0x80000
+spl_size=0x100000
+uboot_size=0x80000
-- 
2.25.1

