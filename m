Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A41C35FE7
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 06:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F333688EDD;
	Wed, 18 Sep 2024 08:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aDbwdQT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2423688CDC; Tue, 17 Sep 2024 08:22:08 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C4688DB4
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 08:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a8d302b6b30so82640366b.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 23:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726554124; x=1727158924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSVF56jI0SAxeTr7ecNh2ccSZTLatNX4L70TQd7wy8U=;
 b=aDbwdQT74H6NOyaTZukkNTE4IY0PpSarRtrch554+yUT3vQHqAAcIqE9LiO9tOOeMw
 EXCBZzvTfgKX8VAzCxrlJ5oCFhPEFkUZOPTibvGIKIC6jtwJtSWc9x0yfa/p50kE3gJ4
 +bNVQ2I1bqHARwPq8dUuvjsA0Y/2Pnbu3806LNhETnJ1z2/AXc5KU5hlvI+TI0zwfuiX
 HtwYiPYYx2lEkfWoWETZPgNW1Mtge6cSwruEEjxh4WPEFDXn52Z0mYm7VEEbacOJFEND
 a/OpFesIf3/Y8MwzeGRvWqQZRDD/jlgJt2+6QHnzHSpbCbIBHVbD8+e+bN5BySSzl6OK
 Ai+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726554124; x=1727158924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSVF56jI0SAxeTr7ecNh2ccSZTLatNX4L70TQd7wy8U=;
 b=m1Rojly+FUAwP2NIy4yIl+yvZyGBZediZNUMrCiltX+7TNMfdMQhFsQkFOMYVQOdxf
 cOIMVGBTtxlGeXnqxULxaO8+qkQcJAhmp47ZtWGkSUSwlWxIPCbSt8Lv6JBmBXo61yrk
 DHDUnuvw87fK6+mHmhe2t+u72cKoU8IE+z0Yi17isRV68yXRrdbXx+/QMu4ygF8UhmtY
 yUYtp/3NEcSMYdMOuCvECyU6FXW5vEx1Jzq0BJ4hFGqYQJwoDxEm1MUUfsTLP9zXLtul
 DaIIbVSH7T83c2MvP1RPz6V37CHcc5iPeErcGSunY0cLFI/hAcz1pXQGo1hX0dr01O6d
 7qZQ==
X-Gm-Message-State: AOJu0YywZPAcVG2p1dCqW/xh9TecsUsV+cymbyPaTwFesvSuYzWZBZTj
 GisALKoAqZnu3louG+QZzhrwGyIyOQmb10T2M2ee4vChowt1V0s8UV89lf4i
X-Google-Smtp-Source: AGHT+IFd8wC9fv0XAsM0VqDzJEXQggLUnLZkcSkrf3K1iEiJ6v1LUnay7odlOHQCjXX/26nktrCmKQ==
X-Received: by 2002:a17:907:9724:b0:a7a:b895:6571 with SMTP id
 a640c23a62f3a-a9029612b9dmr755627566b.9.1726554123400; 
 Mon, 16 Sep 2024 23:22:03 -0700 (PDT)
Received: from fc8b2ad344cc.pool3007.local ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9061328e61sm403556366b.196.2024.09.16.23.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 23:22:03 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH v2 5/7] ARM: socfpga: add Enclustra AA1 demo env files
Date: Tue, 17 Sep 2024 06:21:55 +0000
Message-Id: <20240917062157.3181-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240917062157.3181-1-l.rubusch@gmail.com>
References: <20240917062157.3181-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Sep 2024 08:14:47 +0200
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

