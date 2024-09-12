Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD2AEE57C7
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5DBF88DEA;
	Thu, 12 Sep 2024 08:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JO1cXy3e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3002988DEA; Thu, 12 Sep 2024 08:06:58 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A7888D78
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8a92e8c840so5192966b.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121215; x=1726726015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRCd/aYb0v7e7yYMyBvEnSLUhQuQPdo2E3oA4XELAVk=;
 b=JO1cXy3elvprXX1K6aKKooiV1qN9wVAUAdxpC54ODkDAIdCMnE1Z3QnAYaM6N9+1XW
 FEDq3ctJhZK95UuD3x7lVMwn6m7RfdwSarcpdBXEU+EIiXGMSHuzc6hhBAg56uZTTPOE
 h8LEhmgwC0HVQpL9Y7nlnAaOzZqCDFNdmknDVL+e89fW4vW6pwCJFfOmutLXvKkhcI85
 s28gIWls1wPUODIJzPo8CsukdeWgCyOWSVZvovn6BBgGBG9epYRhomoIGpXSYPAsQP/W
 w+VigPWP7Mw9RmVXdHc7I9kdw6igZfkrtO19C7ITcQIXSQr/NLdSElSPBH18AxtkgOP1
 8FUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121215; x=1726726015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRCd/aYb0v7e7yYMyBvEnSLUhQuQPdo2E3oA4XELAVk=;
 b=MNqNEFG9meA3g6vm+lACKg0xt0ciCHNrdt4jiQFxXHJ8MjdkkTMS7EsJiIqnulQAql
 kbWbjDIOixdHG21UlMd2iCT7qnpMf0+BsQPXvLTIYkcHwmjFlwyYSmj9QE6RI9UB4ED/
 w9mkCzRo/yHm2ydOnawh55iV4n42+sTNpVW3yrt8cxRV37jJSTAU8S0WktbbJfgDgZm7
 ngtcrtYBplP/OBEXwe0CKrKy+wYTodJFErzXZ6NidxlY85oEGLBWsYQKA7Y4TbnpNWr8
 Gu7KAaiQvgh7HLYlqfBP7gh052f7ZefJfqjQd/wyIZrSK/Fj142UsN1vPy/N1qPWLe88
 +obw==
X-Gm-Message-State: AOJu0Yy9rsklY4xYwetr3FGnXr4PNprq2oz6weGUH7yjN4I8MkKiY+lT
 YSTkTc9eZPq2unF8xGopxWUIXzrGkOiqOYcrCFIaAE0ft2RdYrp1nM4qzQ==
X-Google-Smtp-Source: AGHT+IEskv5r0DCHIpWDv2gSPmYYagGJ4utffzfYwxXtqpjTS6GOQ6b/PsUAcCWXRE+mhpdxaUVJjg==
X-Received: by 2002:a17:907:d22:b0:a8d:2623:dd18 with SMTP id
 a640c23a62f3a-a902963a4d7mr65287566b.13.1726121214940; 
 Wed, 11 Sep 2024 23:06:54 -0700 (PDT)
Received: from 77c10117340a.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2598b844sm698112866b.76.2024.09.11.23.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:06:54 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH 4/9] ARM: socfpga: add Enclustra AA1 extra env settings
Date: Thu, 12 Sep 2024 06:06:44 +0000
Message-Id: <20240912060649.190-5-l.rubusch@gmail.com>
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

Add command files for boot scripts and initial boot environment.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 include/configs/socfpga_mercury_aa1.h | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/configs/socfpga_mercury_aa1.h b/include/configs/socfpga_mercury_aa1.h
index a5b63336e8..4b047e11a7 100644
--- a/include/configs/socfpga_mercury_aa1.h
+++ b/include/configs/socfpga_mercury_aa1.h
@@ -21,6 +21,41 @@
  */
 #define CFG_SYS_BAUDRATE_TABLE {4800, 9600, 19200, 38400, 57600, 115200}
 
+/* U-Boot environment */
+#define CFG_EXTRA_ENV_SETTINGS						\
+	"bitstream_size=0xD00000\0"					\
+	"bootargs=earlycon console=ttyS0,115200 rw rootwait root=/dev/mmcblk0p3\0" \
+	"bootargs_qspi=earlycon console=ttyS0,115200 rw root=/dev/ram0\0" \
+	"bootm_size=0x0a000000\0"					\
+	"env_size=0x80000\0"						\
+	"fdt_addr_r=0x10000000\0"					\
+	"fdtfile=system.dtb\0"						\
+	"fdtload=load ${devtype} ${devnum}:${distro_bootpart} ${fdt_addr_r} ${bootdir}/${fdtfile}; load ${devtype} ${devnum}:${distro_bootpart} ${fdto_addr_r} ${bootdir}/${fdtofile}; fdt addr $fdt_addr_r; fdt resize 8192; fdt apply $fdto_addr_r\0" \
+	"fdtload_qspi=sf probe; sf read ${fdt_addr_r} ${qspi_offset_addr_devicetree} ${fdt_size}; sf read ${fdto_addr_r} ${qspi_offset_addr_dtoverlay} ${fdto_size}; fdt addr ${fdt_addr_r}; fdt resize 8192; fdt apply ${fdto_addr_r}\0" \
+	"fdto_addr_r=0x100c0000\0"					\
+	"fdtofile=socfpga_enclustra_mercury_XXX_overlay.dtbo\0"		\
+	"fdto_size=0x40000\0"						\
+	"fdt_size=0x40000\0"						\
+	"kernel_addr_r=0x11000000\0"					\
+	"kernel_size=0x1000000\0"					\
+	"qspiboot=source ${scriptaddr}\0"				\
+	"qspiload=setenv bootargs ${bootargs_qspi}; sf probe; sf read ${scriptaddr} ${qspi_offset_addr_boot_script} ${scriptsize}\0" \
+	"qspi_offset_addr_bitstream=0x300000\0"				\
+	"qspi_offset_addr_boot_script=0x200000\0"			\
+	"qspi_offset_addr_devicetree=0x280000\0"			\
+	"qspi_offset_addr_dtoverlay=0x2c0000\0"				\
+	"qspi_offset_addr_kernel=0x1000000\0"				\
+	"qspi_offset_addr_rootfs=0x2000000\0"				\
+	"qspi_offset_addr_spl=0x0\0"					\
+	"qspi_offset_addr_uboot=0x100000\0"				\
+	"qspi_offset_addr_uboot_env=0x180000\0"				\
+	"rootfs_addr_r=0x12000000\0"					\
+	"rootfs_size=0x2000000\0"					\
+	"scriptaddr=0x10800000\0"					\
+	"scriptsize=0x80000\0"						\
+	"spl_size=0x100000\0"						\
+	"uboot_size=0x80000\0"
+
 /*
  * L4 OSC1 Timer 0
  */
-- 
2.25.1

