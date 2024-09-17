Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08533CAC589
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 06:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474BC88EA3;
	Wed, 18 Sep 2024 08:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FPoUc7XW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6611888CDC; Tue, 17 Sep 2024 08:22:06 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F80088D3D
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 08:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c4093d074aso793116a12.2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 23:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726554123; x=1727158923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRCd/aYb0v7e7yYMyBvEnSLUhQuQPdo2E3oA4XELAVk=;
 b=FPoUc7XWYT06s0O5TFTISURLRchRFB1B5UH1xxudBZ9T/ynjNvSyZWtKHITYjxggUz
 ZDshxI7+MtIKuCYfYw9MpIPBb5jOjFvNBzVWFdAA/Eyt09qgeQcOKOQhmGYmBEazpjwQ
 Iy8r2JaSqNe45lWLOvHVsvW8nGGPcnDN0Z4dWEmt/8wpL8f/QxskWMpHtDH2MSKeXuOG
 WrbMaXFfIRBPWGeiEzKkHxhkpQETDJ8636NEqmKG08yBtlWOSfJ83zqjObC8H1IQBk/9
 1Yw9Iy8Ssluok7lc7XYHnCGcUIf2uOale2QOSC1ACmpNa/RZ4UNZSzNGx6h9j+oNAS7u
 mMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726554123; x=1727158923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRCd/aYb0v7e7yYMyBvEnSLUhQuQPdo2E3oA4XELAVk=;
 b=Dqv2pSHWzk2SV+ehynW5UENK5uBdZ7n5xhjewIhd2nkHlg33rzfONWDZ0/JnDPzAA9
 sG/rG5qfxWFXriZydt955Un66uuYeagUtKtnF3mk5zADJUB3+yrfXq006WnTZ/EiukRk
 3/bvxx5IxYCEZrcwKteITpK+Y4oqAHbVXifif/6abmbxqBla/Z0iDg6LTXoTl4vZU0z2
 wpRdhP7Op2dMUKQbCAfX+gqyanxtL9Tw4hJkHFEN0hAhld2AlyVXDhoPsZhPAOWhGpM6
 1x8ZD5KyQjMKQqs0BUKqwFChYj5TVwyyJ+8aFJORkMPJhDfmNJXNNkoSKVlkOSGjMxJ4
 OclA==
X-Gm-Message-State: AOJu0Yx5qzoG4MNVVkwM2KruLvD/7S5dbM7xKQUhob+fn30xmdpBN0L+
 FSSyYuLRUjH7zb+VOllxog3ednHpp7mAdSuYogu8npbsAzZFU4aoO0j9+9xO
X-Google-Smtp-Source: AGHT+IFmTwA8VJifm2jLT5Hs9+IWAAkOTeETga4pP18x0ISxSXvWxIx7l7iDOMx9IiWchCDQgry39Q==
X-Received: by 2002:a17:906:fd83:b0:a8d:2624:1a83 with SMTP id
 a640c23a62f3a-a90296d7d09mr681766766b.14.1726554122518; 
 Mon, 16 Sep 2024 23:22:02 -0700 (PDT)
Received: from fc8b2ad344cc.pool3007.local ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9061328e61sm403556366b.196.2024.09.16.23.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 23:22:02 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH v2 4/7] ARM: socfpga: add Enclustra AA1 extra env settings
Date: Tue, 17 Sep 2024 06:21:54 +0000
Message-Id: <20240917062157.3181-5-l.rubusch@gmail.com>
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

