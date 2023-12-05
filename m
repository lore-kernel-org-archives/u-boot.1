Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850E1C46CA3
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 11:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC30586DD1;
	Tue,  5 Dec 2023 12:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="EWbUgyJf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BD0876FB; Tue,  5 Dec 2023 12:10:09 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B18F86CF7
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 12:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yongxuan.wang@sifive.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cfc9c4acb6so24342005ad.0
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 03:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1701774606; x=1702379406; darn=lists.denx.de;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ls9Brl2M49UsAVdtykWJCHQaVqvL0tjwqaIFJzjxaCY=;
 b=EWbUgyJfVF/Snf//j4c9ULu2IY/NWvZvYhSC4uCBD5/HNXFjun4+tBglfnda1czRf1
 wlmMYj1QfvNpPLWAbF+z8mE81CAHJuQP3CgKqJmxfYDgGzUk//hYKWdjo+fWTaBoLc0O
 0ye1oL/R8L0ltpEAfI7m22mGwRg0uvkWKhgRnh4DlL+r0l6Z2DECBrku4tzvrTaQ/oHS
 3+Tkbp7PtMshka9aMqSSE/JBchi9KpWjv4+8Mra/V/scXGAShrXg5b2eEveqj3QN5x+b
 +p4rZZmyfbySI6iow7RHHjMqp7gviTiQawPh+MDo1Dfjom4Vixmecyn14GMAawVUUyx/
 u9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701774606; x=1702379406;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ls9Brl2M49UsAVdtykWJCHQaVqvL0tjwqaIFJzjxaCY=;
 b=JUJ41voZ+Lupi/nUmkTyHsa+jxGcje0movy8xBM/7n95OorIYGeNjz/YjX981FXPxX
 mxX/QCAQM4x//5CtUwojXyf+43cdbxZYEDebItEY6x5UdN05UrRxyR4L2CMIPb4W3WSo
 WxGrZRb4H1WLiRzxRO7Qk8XN0QZ6LlPHIrKKrLrODSdka/9S5X4pP7lvbm5tc/NMD+zO
 BO2MykaMFYR0cspG4kq+SLJX8rdhWxyylJZrz5Qaa3ZOquEHNJB+0p+gkWByEJEt9lt+
 vPpNCe1Bsb0LPBtp6ZnuG0FQ6lbtswucEjD/sDZOo0pTCkxI9lNn9NVSjAh3J/Nk4hSW
 VksQ==
X-Gm-Message-State: AOJu0Yyy9d7eJNbmhzxTKk9oTQFyj5L3xKiiekm/5PAc44SZ7zBj1S96
 zDkIKiMYR7IoeMA9USnahBuqkyQDUe+3zsR5EMAjBDvjmdnituuNZeWQgEINIOQ1QgsHd+oIOCU
 SL9Fg397Qd3hQDVM2MO3AMUQj05pwwbfwjkKV7EaJWdtPNLQodbbqMRL1RjNPo3zbuXvW5srDvo
 nxCckV45ye
X-Google-Smtp-Source: AGHT+IEstykp242EZwViby10J40WUVLGI5J+6frAF4J4WPkjb8Dx22CTWgneMXx0TSHaUB7+HH1mxw==
X-Received: by 2002:a17:902:e809:b0:1d0:6ffd:6e6e with SMTP id
 u9-20020a170902e80900b001d06ffd6e6emr3917755plg.102.1701774605573; 
 Tue, 05 Dec 2023 03:10:05 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a170902ec8400b001d08bbcf78bsm4498601plg.74.2023.12.05.03.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 03:10:04 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: u-boot@lists.denx.de
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, trini@konsulko.com,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>
Subject: [PATCH] riscv: sifive: unmatched: migrate to text environment
Date: Tue,  5 Dec 2023 11:09:55 +0000
Message-Id: <20231205110958.30180-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
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

Migrate to the new environment format and drop most of the config.h.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 board/sifive/unmatched/unmatched.env | 19 ++++++++++++++
 configs/sifive_unmatched_defconfig   |  2 +-
 include/configs/sifive-unmatched.h   | 37 ----------------------------
 3 files changed, 20 insertions(+), 38 deletions(-)
 create mode 100644 board/sifive/unmatched/unmatched.env

diff --git a/board/sifive/unmatched/unmatched.env b/board/sifive/unmatched/unmatched.env
new file mode 100644
index 0000000000..0f1e5a7174
--- /dev/null
+++ b/board/sifive/unmatched/unmatched.env
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/* environment for HiFive Unmatched boards */
+
+kernel_addr_r=0x80200000
+kernel_comp_addr_r=0x88000000
+kernel_comp_size=0x4000000
+fdt_addr_r=0x8c000000
+scriptaddr=0x8c100000
+pxefile_addr_r=0x8c200000
+ramdisk_addr_r=0x8c300000
+type_guid_gpt_loader1=5B193300-FC78-40CD-8002-E86C45580B47
+type_guid_gpt_loader2=2E54B353-1271-4842-806F-E436D6AF6985
+type_guid_gpt_system=0FC63DAF-8483-4772-8E79-3D69D8477DE4
+partitions=
+    name=loader1,start=17K,size=1M,type=${type_guid_gpt_loader1};
+    name=loader2,size=4MB,type=${type_guid_gpt_loader2};
+    name=system,size=-,bootable,type=${type_guid_gpt_system};
+fdtfile= CONFIG_DEFAULT_FDT_FILE
diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index 6a95ab3977..43fc87d3ce 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -23,7 +23,7 @@ CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x84000000
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr};fdt addr ${fdtcontroladdr};"
 CONFIG_DEFAULT_FDT_FILE="sifive/hifive-unmatched-a00.dtb"
diff --git a/include/configs/sifive-unmatched.h b/include/configs/sifive-unmatched.h
index de8bfc1123..27e0912665 100644
--- a/include/configs/sifive-unmatched.h
+++ b/include/configs/sifive-unmatched.h
@@ -13,41 +13,4 @@
 
 #define CFG_SYS_SDRAM_BASE		0x80000000
 
-/* Environment options */
-
-#define BOOT_TARGET_DEVICES(func) \
-	func(NVME, nvme, 0) \
-	func(NVME, nvme, 1) \
-	func(USB, usb, 0) \
-	func(MMC, mmc, 0) \
-	func(SCSI, scsi, 0) \
-	func(PXE, pxe, na) \
-	func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
-#define TYPE_GUID_LOADER1	"5B193300-FC78-40CD-8002-E86C45580B47"
-#define TYPE_GUID_LOADER2	"2E54B353-1271-4842-806F-E436D6AF6985"
-#define TYPE_GUID_SYSTEM	"0FC63DAF-8483-4772-8E79-3D69D8477DE4"
-
-#define PARTS_DEFAULT \
-	"name=loader1,start=17K,size=1M,type=${type_guid_gpt_loader1};" \
-	"name=loader2,size=4MB,type=${type_guid_gpt_loader2};" \
-	"name=system,size=-,bootable,type=${type_guid_gpt_system};"
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	"kernel_addr_r=0x80200000\0" \
-	"kernel_comp_addr_r=0x88000000\0" \
-	"kernel_comp_size=0x4000000\0" \
-	"fdt_addr_r=0x8c000000\0" \
-	"scriptaddr=0x8c100000\0" \
-	"pxefile_addr_r=0x8c200000\0" \
-	"ramdisk_addr_r=0x8c300000\0" \
-	"type_guid_gpt_loader1=" TYPE_GUID_LOADER1 "\0" \
-	"type_guid_gpt_loader2=" TYPE_GUID_LOADER2 "\0" \
-	"type_guid_gpt_system=" TYPE_GUID_SYSTEM "\0" \
-	"partitions=" PARTS_DEFAULT "\0" \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	BOOTENV
-
 #endif /* __SIFIVE_UNMATCHED_H */
-- 
2.17.1

