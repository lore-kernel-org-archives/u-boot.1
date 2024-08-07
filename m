Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74B3C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 12:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D812988B99;
	Wed,  7 Aug 2024 14:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KtdXbhOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E62888D9; Wed,  7 Aug 2024 14:14:53 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8057E88BA5
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 14:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7a94478a4eso134339666b.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723032890; x=1723637690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOhQXfx/69sO/HDgYu6Jml+NKlnBVulJ1XFUoMsj7Ko=;
 b=KtdXbhOmG/ZSX9LPASWz4ZfK22vpZAXfqq1IRRwe9kDEmEwhVdpaTakosz2VXpmUYU
 n5F1FKvHhe1qCMm1TiS1cVakFNPhD3Aipzwy+pY1dA0157GMNasPsBXOFlBOz2qwwajo
 stn4kL3ccW8llRFOmE8e4hmRvQK5vjbRD6Nqro7fI6wlwJ9UVvZIFWrNC0Murt38tTXD
 X7/z/b8vyFRxlFx2DC0353R0+S4x16U74IQcmtNUTr1I8kpaL/GZaDhditupKGWtIsTh
 slYbNqGYfUttO5fx71tbwPMbEdeh6UuRNEqWGbvpo9Z0lmjP38CH5LxwekckFiPoabKn
 6P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723032890; x=1723637690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOhQXfx/69sO/HDgYu6Jml+NKlnBVulJ1XFUoMsj7Ko=;
 b=NuBPgoi684vHOjli9T1d2P7Ve3O1KCMqUpQBHMq1toNsulKoPd8mBRQ94cgAjVk/Q1
 jT29eDJ1IW2XLyW4BSBrnjlZGuz//0tGukKWJagrs1kgauQ5GxffgtjBfG2y8cjbPEIf
 xDVWzJY3MYQEDCD5NBiAKUfq3PXU6i/DRFeBGcVR0rg6sP19Mr5DRDHgZpG5oig5DZWq
 19pZY0P4P1J6omwTHwQayTFmmcUBqN7c+vTgdGtPEt8bs/XuBkInwzlxNq8sdpQKthQG
 KcJF6ljJblXwYIm//106VpuOECzpbggtxZqU5B/OCnF8Bwd70GxeLveL/x/bDvBFpWKG
 7/pg==
X-Gm-Message-State: AOJu0YwBv8N2jcYOImpMFZpGmk4QLSz+EvlI6mv3cnsl0BhNBeLP0mrq
 QCiqWbqKBNRdvRygh6oWFiu2Alyih6Uun33aZWjUayKwFnDi7dXh
X-Google-Smtp-Source: AGHT+IER9UweFh+QRMGKa+gfSHTSdfYV27quasZ7yddMTZhEYvkvoOEF/pAh5rCIMHRSQUlzZlRJuA==
X-Received: by 2002:a17:906:db09:b0:a7d:c352:c502 with SMTP id
 a640c23a62f3a-a807912beaamr127318066b.30.1723032889256; 
 Wed, 07 Aug 2024 05:14:49 -0700 (PDT)
Received: from xeon.. ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d427b4sm636207966b.130.2024.08.07.05.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 05:14:49 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Thierry Reding <treding@nvidia.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/1] board: tegra: convert boards to text env
Date: Wed,  7 Aug 2024 15:14:34 +0300
Message-ID: <20240807121434.11761-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807121434.11761-1-clamor95@gmail.com>
References: <20240807121434.11761-1-clamor95@gmail.com>
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

Convert boards to use text based env. This is the first stage of
conversion, common inclusions should be converted next.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/asus/grouper/grouper.env                | 15 +++
 .../asus/transformer-t20/transformer-t20.env  | 17 ++++
 .../transformer-t30/configs/tf600t.config     |  1 +
 board/asus/transformer-t30/tf600t.env         | 16 ++++
 .../asus/transformer-t30/transformer-t30.env  | 17 ++++
 board/htc/endeavoru/endeavoru.env             | 13 +++
 .../ideapad-yoga-11/ideapad-yoga-11.env       | 16 ++++
 board/lg/x3-t30/configs/p880.config           |  1 +
 board/lg/x3-t30/configs/p895.config           |  1 +
 board/lg/x3-t30/p880.env                      | 15 +++
 board/lg/x3-t30/p895.env                      | 13 +++
 board/microsoft/surface-rt/surface-rt.env     | 14 +++
 board/nvidia/cardhu/cardhu.env                |  2 +
 board/nvidia/p2771-0000/p2771-0000.env        | 22 +++++
 board/nvidia/p3450-0000/p3450-0000.env        |  7 ++
 board/toradex/apalis-tk1/apalis_tk1.env       | 45 +++++++++
 board/toradex/apalis_t30/apalis_t30.env       |  9 ++
 board/toradex/colibri_t20/colibri_t20.env     |  3 +
 board/toradex/colibri_t30/colibri_t30.env     |  9 ++
 board/wexler/qc750/qc750.env                  | 15 +++
 configs/apalis-tk1_defconfig                  |  3 +-
 configs/apalis_t30_defconfig                  |  1 +
 configs/cardhu_defconfig                      |  1 +
 configs/colibri_t20_defconfig                 |  1 +
 configs/colibri_t30_defconfig                 |  1 +
 configs/endeavoru_defconfig                   |  1 +
 configs/grouper_common_defconfig              |  1 +
 configs/ideapad-yoga-11_defconfig             |  1 +
 configs/p2771-0000-000_defconfig              |  1 +
 configs/p3450-0000_defconfig                  |  1 +
 configs/qc750_defconfig                       |  1 +
 configs/surface-rt_defconfig                  |  1 +
 configs/transformer_t20_defconfig             |  1 +
 configs/transformer_t30_defconfig             |  1 +
 include/configs/apalis-tk1.h                  | 58 ------------
 include/configs/apalis_t30.h                  | 12 ---
 include/configs/cardhu.h                      |  4 -
 include/configs/colibri_t20.h                 | 11 ---
 include/configs/colibri_t30.h                 | 12 ---
 include/configs/endeavoru.h                   | 43 ---------
 include/configs/grouper.h                     | 45 ---------
 include/configs/ideapad-yoga-11.h             | 58 ------------
 include/configs/p2771-0000.h                  | 20 ----
 include/configs/p3450-0000.h                  | 13 ---
 include/configs/qc750.h                       | 42 ---------
 include/configs/surface-rt.h                  | 18 ----
 include/configs/transformer-common.h          | 91 -------------------
 include/configs/transformer-t20.h             |  4 +-
 include/configs/transformer-t30.h             |  6 +-
 include/configs/x3-t30.h                      | 44 ---------
 include/env/nvidia/prod_upd.env               | 60 ++++++++++++
 51 files changed, 332 insertions(+), 476 deletions(-)
 create mode 100644 board/asus/grouper/grouper.env
 create mode 100644 board/asus/transformer-t20/transformer-t20.env
 create mode 100644 board/asus/transformer-t30/tf600t.env
 create mode 100644 board/asus/transformer-t30/transformer-t30.env
 create mode 100644 board/htc/endeavoru/endeavoru.env
 create mode 100644 board/lenovo/ideapad-yoga-11/ideapad-yoga-11.env
 create mode 100644 board/lg/x3-t30/p880.env
 create mode 100644 board/lg/x3-t30/p895.env
 create mode 100644 board/microsoft/surface-rt/surface-rt.env
 create mode 100644 board/nvidia/cardhu/cardhu.env
 create mode 100644 board/nvidia/p2771-0000/p2771-0000.env
 create mode 100644 board/nvidia/p3450-0000/p3450-0000.env
 create mode 100644 board/toradex/apalis-tk1/apalis_tk1.env
 create mode 100644 board/toradex/apalis_t30/apalis_t30.env
 create mode 100644 board/toradex/colibri_t20/colibri_t20.env
 create mode 100644 board/toradex/colibri_t30/colibri_t30.env
 create mode 100644 board/wexler/qc750/qc750.env
 delete mode 100644 include/configs/transformer-common.h
 create mode 100644 include/env/nvidia/prod_upd.env

diff --git a/board/asus/grouper/grouper.env b/board/asus/grouper/grouper.env
new file mode 100644
index 0000000000..b1f4aeb555
--- /dev/null
+++ b/board/asus/grouper/grouper.env
@@ -0,0 +1,15 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+button_cmd_1_name=Lid
+button_cmd_1=poweroff
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_2=update bootloader=run flash_uboot
+bootmenu_3=reboot RCM=enterrcm
+bootmenu_4=reboot=reset
+bootmenu_5=power off=poweroff
+bootmenu_delay=-1
diff --git a/board/asus/transformer-t20/transformer-t20.env b/board/asus/transformer-t20/transformer-t20.env
new file mode 100644
index 0000000000..2f7e8206c2
--- /dev/null
+++ b/board/asus/transformer-t20/transformer-t20.env
@@ -0,0 +1,17 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+button_cmd_1_name=Lid sensor
+button_cmd_1=poweroff
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+boot_dev=1
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_3=update bootloader=run flash_uboot
+bootmenu_4=reboot RCM=enterrcm
+bootmenu_5=reboot=reset
+bootmenu_6=power off=poweroff
+bootmenu_delay=-1
diff --git a/board/asus/transformer-t30/configs/tf600t.config b/board/asus/transformer-t30/configs/tf600t.config
index b3734869f5..a452a19fe4 100644
--- a/board/asus/transformer-t30/configs/tf600t.config
+++ b/board/asus/transformer-t30/configs/tf600t.config
@@ -1,3 +1,4 @@
+CONFIG_ENV_SOURCE_FILE="tf600t"
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf600t"
 CONFIG_BOOTCOMMAND="setenv gpio_button 222; if run check_button; then poweroff; fi; setenv gpio_button 132; if run check_button; then echo Starting SPI flash update ...; run update_spi; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
 # CONFIG_I2C_MUX is not set
diff --git a/board/asus/transformer-t30/tf600t.env b/board/asus/transformer-t30/tf600t.env
new file mode 100644
index 0000000000..7bc2b80c48
--- /dev/null
+++ b/board/asus/transformer-t30/tf600t.env
@@ -0,0 +1,16 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+button_cmd_1_name=Lid sensor
+button_cmd_1=poweroff
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_3=update bootloader=run update_spi
+bootmenu_4=reboot RCM=enterrcm
+bootmenu_5=reboot=reset
+bootmenu_6=power off=poweroff
+bootmenu_delay=-1
diff --git a/board/asus/transformer-t30/transformer-t30.env b/board/asus/transformer-t30/transformer-t30.env
new file mode 100644
index 0000000000..2f7e8206c2
--- /dev/null
+++ b/board/asus/transformer-t30/transformer-t30.env
@@ -0,0 +1,17 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+button_cmd_1_name=Lid sensor
+button_cmd_1=poweroff
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+boot_dev=1
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_3=update bootloader=run flash_uboot
+bootmenu_4=reboot RCM=enterrcm
+bootmenu_5=reboot=reset
+bootmenu_6=power off=poweroff
+bootmenu_delay=-1
diff --git a/board/htc/endeavoru/endeavoru.env b/board/htc/endeavoru/endeavoru.env
new file mode 100644
index 0000000000..53e9b56845
--- /dev/null
+++ b/board/htc/endeavoru/endeavoru.env
@@ -0,0 +1,13 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_2=update bootloader=run flash_uboot
+bootmenu_3=reboot RCM=enterrcm
+bootmenu_4=reboot=reset
+bootmenu_5=power off=poweroff
+bootmenu_delay=-1
diff --git a/board/lenovo/ideapad-yoga-11/ideapad-yoga-11.env b/board/lenovo/ideapad-yoga-11/ideapad-yoga-11.env
new file mode 100644
index 0000000000..7bc2b80c48
--- /dev/null
+++ b/board/lenovo/ideapad-yoga-11/ideapad-yoga-11.env
@@ -0,0 +1,16 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+button_cmd_1_name=Lid sensor
+button_cmd_1=poweroff
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_3=update bootloader=run update_spi
+bootmenu_4=reboot RCM=enterrcm
+bootmenu_5=reboot=reset
+bootmenu_6=power off=poweroff
+bootmenu_delay=-1
diff --git a/board/lg/x3-t30/configs/p880.config b/board/lg/x3-t30/configs/p880.config
index 57c2885779..44e0fa7ef7 100644
--- a/board/lg/x3-t30/configs/p880.config
+++ b/board/lg/x3-t30/configs/p880.config
@@ -1,3 +1,4 @@
+CONFIG_ENV_SOURCE_FILE="p880"
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-lg-p880"
 CONFIG_SYS_PROMPT="Tegra30 (P880) # "
 CONFIG_VIDEO_LCD_RENESAS_R69328=y
diff --git a/board/lg/x3-t30/configs/p895.config b/board/lg/x3-t30/configs/p895.config
index 2eba92594b..267ae3a80d 100644
--- a/board/lg/x3-t30/configs/p895.config
+++ b/board/lg/x3-t30/configs/p895.config
@@ -1,3 +1,4 @@
+CONFIG_ENV_SOURCE_FILE="p895"
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-lg-p895"
 CONFIG_SYS_PROMPT="Tegra30 (P895) # "
 CONFIG_VIDEO_LCD_RENESAS_R61307=y
diff --git a/board/lg/x3-t30/p880.env b/board/lg/x3-t30/p880.env
new file mode 100644
index 0000000000..f2bf298a99
--- /dev/null
+++ b/board/lg/x3-t30/p880.env
@@ -0,0 +1,15 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+boot_dev=1
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_3=update bootloader=run flash_uboot
+bootmenu_4=reboot RCM=enterrcm
+bootmenu_5=reboot=reset
+bootmenu_6=power off=poweroff
+bootmenu_delay=-1
diff --git a/board/lg/x3-t30/p895.env b/board/lg/x3-t30/p895.env
new file mode 100644
index 0000000000..53e9b56845
--- /dev/null
+++ b/board/lg/x3-t30/p895.env
@@ -0,0 +1,13 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_2=update bootloader=run flash_uboot
+bootmenu_3=reboot RCM=enterrcm
+bootmenu_4=reboot=reset
+bootmenu_5=power off=poweroff
+bootmenu_delay=-1
diff --git a/board/microsoft/surface-rt/surface-rt.env b/board/microsoft/surface-rt/surface-rt.env
new file mode 100644
index 0000000000..682929096a
--- /dev/null
+++ b/board/microsoft/surface-rt/surface-rt.env
@@ -0,0 +1,14 @@
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+button_cmd_1_name=Hall Sensor
+button_cmd_1=poweroff
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_3=boot from USB=usb reset; usb start; bootflow scan
+bootmenu_4=reboot RCM=enterrcm
+bootmenu_5=reboot=reset
+bootmenu_6=power off=poweroff
+bootmenu_delay=-1
diff --git a/board/nvidia/cardhu/cardhu.env b/board/nvidia/cardhu/cardhu.env
new file mode 100644
index 0000000000..9d1e3e1da2
--- /dev/null
+++ b/board/nvidia/cardhu/cardhu.env
@@ -0,0 +1,2 @@
+board_name=cardhu-a04
+fdtfile=tegra30-cardhu-a04.dtb
diff --git a/board/nvidia/p2771-0000/p2771-0000.env b/board/nvidia/p2771-0000/p2771-0000.env
new file mode 100644
index 0000000000..6789cc1cc6
--- /dev/null
+++ b/board/nvidia/p2771-0000/p2771-0000.env
@@ -0,0 +1,22 @@
+calculated_vars=kernel_addr_r fdt_addr_r scriptaddr pxefile_addr_r ramdisk_addr_r
+
+kernel_addr_r_align=00200000
+kernel_addr_r_offset=00080000
+kernel_addr_r_size=02000000
+kernel_addr_r_aliases=loadaddr
+
+fdt_addr_r_align=00200000
+fdt_addr_r_offset=00000000
+fdt_addr_r_size=00200000
+
+scriptaddr_align=00200000
+scriptaddr_offset=00000000
+scriptaddr_size=00200000
+
+pxefile_addr_r_align=00200000
+pxefile_addr_r_offset=00000000
+pxefile_addr_r_size=00200000
+
+ramdisk_addr_r_align=00200000
+ramdisk_addr_r_offset=00000000
+ramdisk_addr_r_size=02000000
diff --git a/board/nvidia/p3450-0000/p3450-0000.env b/board/nvidia/p3450-0000/p3450-0000.env
new file mode 100644
index 0000000000..a7d7ab3c43
--- /dev/null
+++ b/board/nvidia/p3450-0000/p3450-0000.env
@@ -0,0 +1,7 @@
+/* Only MMC/PXE/DHCP for now, add USB back in later when supported */
+boot_targets=mmc1 mmc0 pxe dhcp
+
+preboot=if test -e mmc 1:1 /u-boot-preboot.scr; then 
+	load mmc 1:1 ${scriptaddr} /u-boot-preboot.scr;
+		source ${scriptaddr};
+	fi
diff --git a/board/toradex/apalis-tk1/apalis_tk1.env b/board/toradex/apalis-tk1/apalis_tk1.env
new file mode 100644
index 0000000000..ff883d6042
--- /dev/null
+++ b/board/toradex/apalis-tk1/apalis_tk1.env
@@ -0,0 +1,45 @@
+/*
+ * Custom Boot configuration:
+ * 1. 8bit SD port (MMC1)
+ * 2. 4bit SD port (MMC2)
+ * 3. eMMC (MMC0)
+ */
+boot_targets=mmc1 mmc2 mmc0 usb pxe dhcp
+
+boot_file=zImage
+boot_script_dhcp=boot.scr
+console=ttyS0
+defargs=lp0_vec=2064@0xf46ff000 core_edp_mv=1150 core_edp_ma=4000 
+	usb_port_owner_info=2 lane_owner_info=6 emc_max_dvfs=0 
+	user_debug=30 pcie_aspm=off
+dfu_alt_info=apalis-tk1.img raw 0x0 0x500 mmcpart 1; 
+	boot part 0 1 mmcpart 0; 
+	rootfs part 0 2 mmcpart 0; 
+	zImage fat 0 1 mmcpart 0; 
+	tegra124-apalis-eval.dtb fat 0 1 mmcpart 0
+fdt_board=eval
+fdt_fixup=;
+fdt_module=apalis-v1.2
+uboot_hwpart=1
+uboot_blk=0
+set_blkcnt=setexpr blkcnt ${filesize} + 0x1ff && 
+	setexpr blkcnt ${blkcnt} / 0x200
+update_uboot=run set_blkcnt && mmc dev 0 ${uboot_hwpart} && 
+	mmc write ${loadaddr} ${uboot_blk} ${blkcnt}
+setethupdate=if env exists ethaddr; then; else setenv ethaddr 
+	00:14:2d:00:00:00; fi; pci enum && tftpboot ${loadaddr} 
+	flash_eth.img && source ${loadaddr}
+setsdupdate=setenv interface mmc; setenv drive 1; mmc rescan; 
+	load ${interface} ${drive}:1 ${loadaddr} flash_blk.img 
+	|| setenv drive 2; mmc rescan; load ${interface} ${drive}:1 
+	${loadaddr} flash_blk.img && 
+	source ${loadaddr}
+setup=setenv setupargs igb_mac=${ethaddr} 
+	consoleblank=0 no_console_suspend=1 console=tty1 
+	console=${console},${baudrate}n8 debug_uartport=lsport,0 
+	${memargs}
+setupdate=run setsdupdate || run setusbupdate || run setethupdate
+setusbupdate=usb start && setenv interface usb; setenv drive 0; 
+	load ${interface} ${drive}:1 ${loadaddr} flash_blk.img && 
+	source ${loadaddr}
+vidargs=fbcon=map:1
diff --git a/board/toradex/apalis_t30/apalis_t30.env b/board/toradex/apalis_t30/apalis_t30.env
new file mode 100644
index 0000000000..2e5161e3b8
--- /dev/null
+++ b/board/toradex/apalis_t30/apalis_t30.env
@@ -0,0 +1,9 @@
+uboot_hwpart=1
+uboot_blk=0
+
+set_blkcnt=setexpr blkcnt ${filesize} + 0x1ff && 
+	setexpr blkcnt ${blkcnt} / 0x200
+update_uboot=run set_blkcnt && mmc dev 0 ${uboot_hwpart} && 
+	mmc write ${loadaddr} ${uboot_blk} ${blkcnt}
+
+boot_script_dhcp=boot.scr
diff --git a/board/toradex/colibri_t20/colibri_t20.env b/board/toradex/colibri_t20/colibri_t20.env
new file mode 100644
index 0000000000..5e9f0630b2
--- /dev/null
+++ b/board/toradex/colibri_t20/colibri_t20.env
@@ -0,0 +1,3 @@
+/* Environment in NAND, 64K is a bit excessive but erase block is 512K anyway */
+boot_script_dhcp=boot.scr
+update_uboot=nand erase.part u-boot && nand write ${loadaddr} u-boot ${filesize}
diff --git a/board/toradex/colibri_t30/colibri_t30.env b/board/toradex/colibri_t30/colibri_t30.env
new file mode 100644
index 0000000000..2e5161e3b8
--- /dev/null
+++ b/board/toradex/colibri_t30/colibri_t30.env
@@ -0,0 +1,9 @@
+uboot_hwpart=1
+uboot_blk=0
+
+set_blkcnt=setexpr blkcnt ${filesize} + 0x1ff && 
+	setexpr blkcnt ${blkcnt} / 0x200
+update_uboot=run set_blkcnt && mmc dev 0 ${uboot_hwpart} && 
+	mmc write ${loadaddr} ${uboot_blk} ${blkcnt}
+
+boot_script_dhcp=boot.scr
diff --git a/board/wexler/qc750/qc750.env b/board/wexler/qc750/qc750.env
new file mode 100644
index 0000000000..f2bf298a99
--- /dev/null
+++ b/board/wexler/qc750/qc750.env
@@ -0,0 +1,15 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+boot_dev=1
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_3=update bootloader=run flash_uboot
+bootmenu_4=reboot RCM=enterrcm
+bootmenu_5=reboot=reset
+bootmenu_6=power off=poweroff
+bootmenu_delay=-1
diff --git a/configs/apalis-tk1_defconfig b/configs/apalis-tk1_defconfig
index 20c9c06cde..bc5a75e85b 100644
--- a/configs/apalis-tk1_defconfig
+++ b/configs/apalis-tk1_defconfig
@@ -4,6 +4,7 @@ CONFIG_ARCH_TEGRA=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="apalis-tk1"
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DEFAULT_DEVICE_TREE="tegra124-apalis"
@@ -19,7 +20,7 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="setenv fdtfile ${soc}-${fdt_module}-${fdt_board}.dtb && run distro_bootcmd"
+CONFIG_BOOTCOMMAND="setenv fdtfile ${soc}-${fdt_module}-${fdt_board}.dtb && bootflow scan"
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1054
 CONFIG_CONSOLE_MUX=y
diff --git a/configs/apalis_t30_defconfig b/configs/apalis_t30_defconfig
index 03a1f2c239..203c5dae90 100644
--- a/configs/apalis_t30_defconfig
+++ b/configs/apalis_t30_defconfig
@@ -4,6 +4,7 @@ CONFIG_ARCH_TEGRA=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="apalis_t30"
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-apalis"
diff --git a/configs/cardhu_defconfig b/configs/cardhu_defconfig
index 52183a3e30..39129afb52 100644
--- a/configs/cardhu_defconfig
+++ b/configs/cardhu_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYS_L2CACHE_OFF=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="cardhu"
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
diff --git a/configs/colibri_t20_defconfig b/configs/colibri_t20_defconfig
index 8d8423ac79..50b9a91377 100644
--- a/configs/colibri_t20_defconfig
+++ b/configs/colibri_t20_defconfig
@@ -4,6 +4,7 @@ CONFIG_ARCH_TEGRA=y
 CONFIG_TEXT_BASE=0x00110000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="colibri_t20"
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x200000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-colibri"
diff --git a/configs/colibri_t30_defconfig b/configs/colibri_t30_defconfig
index 394d656a12..b5e69a5805 100644
--- a/configs/colibri_t30_defconfig
+++ b/configs/colibri_t30_defconfig
@@ -4,6 +4,7 @@ CONFIG_ARCH_TEGRA=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="colibri_t30"
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-colibri"
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index 3230d360ed..326ece89ad 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -5,6 +5,7 @@ CONFIG_CMDLINE_TAG=y
 CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="endeavoru"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-htc-endeavoru"
diff --git a/configs/grouper_common_defconfig b/configs/grouper_common_defconfig
index 001f5b8804..94fb989c23 100644
--- a/configs/grouper_common_defconfig
+++ b/configs/grouper_common_defconfig
@@ -5,6 +5,7 @@ CONFIG_CMDLINE_TAG=y
 CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="grouper"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-nexus7-grouper-E1565"
diff --git a/configs/ideapad-yoga-11_defconfig b/configs/ideapad-yoga-11_defconfig
index 25624c6886..2e4c9a5ae8 100644
--- a/configs/ideapad-yoga-11_defconfig
+++ b/configs/ideapad-yoga-11_defconfig
@@ -5,6 +5,7 @@ CONFIG_CMDLINE_TAG=y
 CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="ideapad-yoga-11"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-lenovo-ideapad-yoga-11"
diff --git a/configs/p2771-0000-000_defconfig b/configs/p2771-0000-000_defconfig
index 83e904b4de..635c8e9361 100644
--- a/configs/p2771-0000-000_defconfig
+++ b/configs/p2771-0000-000_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_L2CACHE_OFF=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_TEXT_BASE=0x80080000
 CONFIG_NR_DRAM_BANKS=1026
+CONFIG_ENV_SOURCE_FILE="p2771-0000"
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra186-p2771-0000-000"
diff --git a/configs/p3450-0000_defconfig b/configs/p3450-0000_defconfig
index 67bc3f4bb0..9fdc23f54c 100644
--- a/configs/p3450-0000_defconfig
+++ b/configs/p3450-0000_defconfig
@@ -6,6 +6,7 @@ CONFIG_ARCH_TEGRA=y
 CONFIG_TEXT_BASE=0x80080000
 CONFIG_SYS_MALLOC_LEN=0x2500000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="p3450-0000"
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
diff --git a/configs/qc750_defconfig b/configs/qc750_defconfig
index 17b5ec8824..9fc737b3d3 100644
--- a/configs/qc750_defconfig
+++ b/configs/qc750_defconfig
@@ -5,6 +5,7 @@ CONFIG_CMDLINE_TAG=y
 CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="qc750"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-wexler-qc750"
diff --git a/configs/surface-rt_defconfig b/configs/surface-rt_defconfig
index 2326d24f28..521e622f97 100644
--- a/configs/surface-rt_defconfig
+++ b/configs/surface-rt_defconfig
@@ -5,6 +5,7 @@ CONFIG_CMDLINE_TAG=y
 CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="surface-rt"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-microsoft-surface-rt"
diff --git a/configs/transformer_t20_defconfig b/configs/transformer_t20_defconfig
index 13bb269500..d6f5c7085a 100644
--- a/configs/transformer_t20_defconfig
+++ b/configs/transformer_t20_defconfig
@@ -5,6 +5,7 @@ CONFIG_CMDLINE_TAG=y
 CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x00110000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="transformer-t20"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-asus-tf101"
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 1ebdb31acf..e3a70cc8c3 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -5,6 +5,7 @@ CONFIG_CMDLINE_TAG=y
 CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="transformer-t30"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf201"
diff --git a/include/configs/apalis-tk1.h b/include/configs/apalis-tk1.h
index 71d4727ca9..4c690a1785 100644
--- a/include/configs/apalis-tk1.h
+++ b/include/configs/apalis-tk1.h
@@ -18,64 +18,6 @@
 #define FDT_MODULE			"apalis-v1.2"
 #define FDT_MODULE_V1_0			"apalis"
 
-/*
- * Custom Distro Boot configuration:
- * 1. 8bit SD port (MMC1)
- * 2. 4bit SD port (MMC2)
- * 3. eMMC (MMC0)
- */
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 1) \
-	func(MMC, mmc, 2) \
-	func(MMC, mmc, 0) \
-	func(USB, usb, 0) \
-	func(PXE, pxe, na) \
-	func(DHCP, dhcp, na)
-
-#define DFU_ALT_EMMC_INFO	"apalis-tk1.img raw 0x0 0x500 mmcpart 1; " \
-				"boot part 0 1 mmcpart 0; " \
-				"rootfs part 0 2 mmcpart 0; " \
-				"zImage fat 0 1 mmcpart 0; " \
-				"tegra124-apalis-eval.dtb fat 0 1 mmcpart 0"
-
-#define UBOOT_UPDATE \
-	"uboot_hwpart=1\0" \
-	"uboot_blk=0\0" \
-	"set_blkcnt=setexpr blkcnt ${filesize} + 0x1ff && " \
-		"setexpr blkcnt ${blkcnt} / 0x200\0" \
-	"update_uboot=run set_blkcnt && mmc dev 0 ${uboot_hwpart} && " \
-		"mmc write ${loadaddr} ${uboot_blk} ${blkcnt}\0" \
-
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"boot_file=zImage\0" \
-	"boot_script_dhcp=boot.scr\0" \
-	"console=ttyS0\0" \
-	"defargs=lp0_vec=2064@0xf46ff000 core_edp_mv=1150 core_edp_ma=4000 " \
-		"usb_port_owner_info=2 lane_owner_info=6 emc_max_dvfs=0 " \
-		"user_debug=30 pcie_aspm=off\0" \
-	"dfu_alt_info=" DFU_ALT_EMMC_INFO "\0" \
-	"fdt_board=eval\0" \
-	"fdt_fixup=;\0" \
-	"fdt_module=" FDT_MODULE "\0" \
-	UBOOT_UPDATE \
-	"setethupdate=if env exists ethaddr; then; else setenv ethaddr " \
-		"00:14:2d:00:00:00; fi; pci enum && tftpboot ${loadaddr} " \
-		"flash_eth.img && source ${loadaddr}\0" \
-	"setsdupdate=setenv interface mmc; setenv drive 1; mmc rescan; " \
-		"load ${interface} ${drive}:1 ${loadaddr} flash_blk.img " \
-		"|| setenv drive 2; mmc rescan; load ${interface} ${drive}:1 " \
-		"${loadaddr} flash_blk.img && " \
-		"source ${loadaddr}\0" \
-	"setup=setenv setupargs igb_mac=${ethaddr} " \
-		"consoleblank=0 no_console_suspend=1 console=tty1 " \
-		"console=${console},${baudrate}n8 debug_uartport=lsport,0 " \
-		"${memargs}\0" \
-	"setupdate=run setsdupdate || run setusbupdate || run setethupdate\0" \
-	"setusbupdate=usb start && setenv interface usb; setenv drive 0; " \
-		"load ${interface} ${drive}:1 ${loadaddr} flash_blk.img && " \
-		"source ${loadaddr}\0" \
-	"vidargs=fbcon=map:1\0"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/apalis_t30.h b/include/configs/apalis_t30.h
index 80204d706d..87a679efde 100644
--- a/include/configs/apalis_t30.h
+++ b/include/configs/apalis_t30.h
@@ -22,18 +22,6 @@
  */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
 
-#define UBOOT_UPDATE \
-	"uboot_hwpart=1\0" \
-	"uboot_blk=0\0" \
-	"set_blkcnt=setexpr blkcnt ${filesize} + 0x1ff && " \
-		"setexpr blkcnt ${blkcnt} / 0x200\0" \
-	"update_uboot=run set_blkcnt && mmc dev 0 ${uboot_hwpart} && " \
-		"mmc write ${loadaddr} ${uboot_blk} ${blkcnt}\0" \
-
-#define BOARD_EXTRA_ENV_SETTINGS \
-	UBOOT_UPDATE \
-	"boot_script_dhcp=boot.scr\0"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/cardhu.h b/include/configs/cardhu.h
index 82729eb95c..3412b883cb 100644
--- a/include/configs/cardhu.h
+++ b/include/configs/cardhu.h
@@ -13,10 +13,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"NVIDIA Cardhu"
 
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"board_name=cardhu-a04\0" \
-	"fdtfile=tegra30-cardhu-a04.dtb\0"
-
 /* Board-specific serial config */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
 
diff --git a/include/configs/colibri_t20.h b/include/configs/colibri_t20.h
index ea7d648eb6..bc616d1436 100644
--- a/include/configs/colibri_t20.h
+++ b/include/configs/colibri_t20.h
@@ -13,17 +13,6 @@
 /* Board-specific serial config */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
 
-/* NAND support */
-
-#define UBOOT_UPDATE \
-	"update_uboot=nand erase.part u-boot && " \
-		"nand write ${loadaddr} u-boot ${filesize}\0" \
-
-/* Environment in NAND, 64K is a bit excessive but erase block is 512K anyway */
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"boot_script_dhcp=boot.scr\0" \
-	UBOOT_UPDATE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/colibri_t30.h b/include/configs/colibri_t30.h
index 7edb2c0b26..1f474669a7 100644
--- a/include/configs/colibri_t30.h
+++ b/include/configs/colibri_t30.h
@@ -23,18 +23,6 @@
  */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
 
-#define UBOOT_UPDATE \
-	"uboot_hwpart=1\0" \
-	"uboot_blk=0\0" \
-	"set_blkcnt=setexpr blkcnt ${filesize} + 0x1ff && " \
-		"setexpr blkcnt ${blkcnt} / 0x200\0" \
-	"update_uboot=run set_blkcnt && mmc dev 0 ${uboot_hwpart} && " \
-		"mmc write ${loadaddr} ${uboot_blk} ${blkcnt}\0" \
-
-#define BOARD_EXTRA_ENV_SETTINGS \
-	UBOOT_UPDATE \
-	"boot_script_dhcp=boot.scr\0"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/endeavoru.h b/include/configs/endeavoru.h
index 348078f977..33d0021ec1 100644
--- a/include/configs/endeavoru.h
+++ b/include/configs/endeavoru.h
@@ -10,54 +10,11 @@
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
-#include <linux/sizes.h>
-
 #include "tegra30-common.h"
 
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"HTC One X"
 
-#define ENDEAVORU_FLASH_UBOOT \
-	"flash_uboot=echo Preparing RAM;" \
-		"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
-		"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
-		"echo Reading BCT;" \
-		"mmc dev 0 1;" \
-		"mmc read ${kernel_addr_r} 0 ${boot_block_size};" \
-		"echo Reading bootloader;" \
-		"if load mmc 0:1 ${ramdisk_addr_r} ${bootloader_file};" \
-		"then echo Calculating bootloader size;" \
-			"size mmc 0:1 ${bootloader_file};" \
-			"ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};" \
-			"echo Writing bootloader to eMMC;" \
-			"mmc dev 0 1;" \
-			"mmc write ${kernel_addr_r} 0 ${boot_block_size};" \
-			"mmc dev 0 2;" \
-			"mmc write ${ramdisk_addr_r} 0 ${boot_block_size};" \
-			"echo Bootloader written successfully;" \
-			"pause 'Press ANY key to reboot device...'; reset;" \
-		"else echo Reading bootloader failed;" \
-			"pause 'Press ANY key to return to bootmenu...'; bootmenu; fi\0"
-
-#define ENDEAVORU_BOOTMENU \
-	ENDEAVORU_FLASH_UBOOT \
-	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
-	"bootmenu_1=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
-	"bootmenu_2=update bootloader=run flash_uboot\0" \
-	"bootmenu_3=reboot RCM=enterrcm\0" \
-	"bootmenu_4=reboot=reset\0" \
-	"bootmenu_5=power off=poweroff\0" \
-	"bootmenu_delay=-1\0"
-
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"boot_block_size_r=0x200000\0" \
-	"boot_block_size=0x1000\0" \
-	"bootloader_file=u-boot-dtb-tegra.bin\0" \
-	"button_cmd_0_name=Volume Down\0" \
-	"button_cmd_0=bootmenu\0" \
-	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
-	ENDEAVORU_BOOTMENU
-
 /* Board-specific serial config */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
 
diff --git a/include/configs/grouper.h b/include/configs/grouper.h
index 8064b88902..b6ef6ff2ec 100644
--- a/include/configs/grouper.h
+++ b/include/configs/grouper.h
@@ -6,56 +6,11 @@
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
-#include <linux/sizes.h>
-
 #include "tegra30-common.h"
 
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"ASUS Google Nexus 7 (2012)"
 
-#define GROUPER_FLASH_UBOOT \
-	"flash_uboot=echo Preparing RAM;" \
-		"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
-		"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
-		"echo Reading BCT;" \
-		"mmc dev 0 1;" \
-		"mmc read ${kernel_addr_r} 0 ${boot_block_size};" \
-		"echo Reading bootloader;" \
-		"if load mmc 0:1 ${ramdisk_addr_r} ${bootloader_file};" \
-		"then echo Calculating bootloader size;" \
-			"size mmc 0:1 ${bootloader_file};" \
-			"ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};" \
-			"echo Writing bootloader to eMMC;" \
-			"mmc dev 0 1;" \
-			"mmc write ${kernel_addr_r} 0 ${boot_block_size};" \
-			"mmc dev 0 2;" \
-			"mmc write ${ramdisk_addr_r} 0 ${boot_block_size};" \
-			"echo Bootloader written successfully;" \
-			"pause 'Press ANY key to reboot device...'; reset;" \
-		"else echo Reading bootloader failed;" \
-			"pause 'Press ANY key to return to bootmenu...'; bootmenu; fi\0"
-
-#define GROUPER_BOOTMENU \
-	GROUPER_FLASH_UBOOT \
-	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
-	"bootmenu_1=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
-	"bootmenu_2=update bootloader=run flash_uboot\0" \
-	"bootmenu_3=reboot RCM=enterrcm\0" \
-	"bootmenu_4=reboot=reset\0" \
-	"bootmenu_5=power off=poweroff\0" \
-	"bootmenu_delay=-1\0"
-
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"boot_block_size_r=0x200000\0" \
-	"boot_block_size=0x1000\0" \
-	"bootloader_file=u-boot-dtb-tegra.bin\0" \
-	"button_cmd_0_name=Volume Down\0" \
-	"button_cmd_0=bootmenu\0" \
-	"button_cmd_1_name=Lid\0" \
-	"button_cmd_1=poweroff\0" \
-	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
-	GROUPER_BOOTMENU
-
 /* Board-specific serial config */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
 
diff --git a/include/configs/ideapad-yoga-11.h b/include/configs/ideapad-yoga-11.h
index 12c7649f78..c4e6b2a647 100644
--- a/include/configs/ideapad-yoga-11.h
+++ b/include/configs/ideapad-yoga-11.h
@@ -11,64 +11,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"Lenovo Ideapad Yoga 11"
 
-#define IDEAPAD_FLASH_UBOOT \
-	"flash_uboot=sf probe 0:1;" \
-		"echo Dumping current SPI flash content ...;" \
-		"sf read ${kernel_addr_r} 0x0 ${spi_size};" \
-		"if fatwrite mmc 1:1 ${kernel_addr_r} spi-flash-backup.bin ${spi_size};" \
-		"then echo SPI flash content was successfully written into spi-flash-backup.bin;" \
-			"echo Reading SPI flash binary;" \
-			"if load mmc 1:1 ${kernel_addr_r} repart-block.bin;" \
-			"then echo Writing bootloader into SPI flash;" \
-				"sf probe 0:1;" \
-				"sf update ${kernel_addr_r} 0x0 ${spi_size};" \
-				"echo Bootloader SUCCESSFULLY written into SPI flash;" \
-				"pause 'Press ANY key to reboot...'; reset;" \
-			"else echo Preparing RAM;" \
-				"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
-				"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
-				"echo Reading BCT;" \
-				"sf read ${kernel_addr_r} 0x0 ${boot_block_size_r};" \
-				"echo Reading bootloader;" \
-				"if load mmc 1:1 ${ramdisk_addr_r} ${bootloader_file};" \
-				"then echo Calculating bootloader size;" \
-					"size mmc 1:1 ${bootloader_file};" \
-					"ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};" \
-					"echo Writing bootloader into SPI flash;" \
-					"sf probe 0:1;" \
-					"sf update ${kernel_addr_r} 0x0 ${boot_block_size_r};" \
-					"sf update ${ramdisk_addr_r} ${boot_block_size_r} ${boot_block_size_r};" \
-					"echo Bootloader written SUCCESSFULLY;" \
-					"pause 'Press ANY key to reboot...'; reset;" \
-				"else echo Reading bootloader failed;" \
-					"pause 'Press ANY key to reboot...'; reset; fi;" \
-			"fi;" \
-		"else echo SPI flash backup FAILED! Aborting ...;" \
-			"pause 'Press ANY key to reboot...'; reset; fi\0"
-
-#define IDEAPAD_BOOTMENU \
-	IDEAPAD_FLASH_UBOOT \
-	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
-	"bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu\0" \
-	"bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
-	"bootmenu_3=update bootloader=run flash_uboot\0" \
-	"bootmenu_4=reboot RCM=enterrcm\0" \
-	"bootmenu_5=reboot=reset\0" \
-	"bootmenu_6=power off=poweroff\0" \
-	"bootmenu_delay=-1\0"
-
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"spi_size=0x400000\0" \
-	"boot_block_size_r=0x200000\0" \
-	"boot_block_size=0x1000\0" \
-	"bootloader_file=u-boot-dtb-tegra.bin\0" \
-	"button_cmd_0_name=Volume Down\0" \
-	"button_cmd_0=bootmenu\0" \
-	"button_cmd_1_name=Lid sensor\0" \
-	"button_cmd_1=poweroff\0" \
-	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
-	IDEAPAD_BOOTMENU
-
 /* Board-specific serial config */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
 
diff --git a/include/configs/p2771-0000.h b/include/configs/p2771-0000.h
index e409cc3896..fc1b7c0302 100644
--- a/include/configs/p2771-0000.h
+++ b/include/configs/p2771-0000.h
@@ -15,26 +15,6 @@
 
 /* Environment in eMMC, at the end of 2nd "boot sector" */
 
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"calculated_vars=kernel_addr_r fdt_addr_r scriptaddr pxefile_addr_r " \
-		"ramdisk_addr_r\0" \
-	"kernel_addr_r_align=00200000\0" \
-	"kernel_addr_r_offset=00080000\0" \
-	"kernel_addr_r_size=02000000\0" \
-	"kernel_addr_r_aliases=loadaddr\0" \
-	"fdt_addr_r_align=00200000\0" \
-	"fdt_addr_r_offset=00000000\0" \
-	"fdt_addr_r_size=00200000\0" \
-	"scriptaddr_align=00200000\0" \
-	"scriptaddr_offset=00000000\0" \
-	"scriptaddr_size=00200000\0" \
-	"pxefile_addr_r_align=00200000\0" \
-	"pxefile_addr_r_offset=00000000\0" \
-	"pxefile_addr_r_size=00200000\0" \
-	"ramdisk_addr_r_align=00200000\0" \
-	"ramdisk_addr_r_offset=00000000\0" \
-	"ramdisk_addr_r_size=02000000\0"
-
 #include "tegra-common-post.h"
 
 #endif
diff --git a/include/configs/p3450-0000.h b/include/configs/p3450-0000.h
index e60f42eaa7..1138c1d306 100644
--- a/include/configs/p3450-0000.h
+++ b/include/configs/p3450-0000.h
@@ -15,19 +15,6 @@
 
 /* Board-specific serial config */
 
-/* Only MMC/PXE/DHCP for now, add USB back in later when supported */
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 1) \
-	func(MMC, mmc, 0) \
-	func(PXE, pxe, na) \
-	func(DHCP, dhcp, na)
-
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"preboot=if test -e mmc 1:1 /u-boot-preboot.scr; then " \
-		"load mmc 1:1 ${scriptaddr} /u-boot-preboot.scr; " \
-		"source ${scriptaddr}; " \
-	"fi\0"
-
 /* General networking support */
 #include "tegra-common-post.h"
 
diff --git a/include/configs/qc750.h b/include/configs/qc750.h
index ce6665d0f3..ad9f9146bb 100644
--- a/include/configs/qc750.h
+++ b/include/configs/qc750.h
@@ -15,48 +15,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"Wexler QC750"
 
-#define QC750_FLASH_UBOOT \
-	"flash_uboot=echo Preparing RAM;" \
-		"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
-		"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
-		"echo Reading BCT;" \
-		"mmc dev 0 1;" \
-		"mmc read ${kernel_addr_r} 0 ${boot_block_size};" \
-		"echo Reading bootloader;" \
-		"if load mmc 1:1 ${ramdisk_addr_r} ${bootloader_file};" \
-		"then echo Calculating bootloader size;" \
-			"size mmc 1:1 ${bootloader_file};" \
-			"ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};" \
-			"echo Writing bootloader to eMMC;" \
-			"mmc dev 0 1;" \
-			"mmc write ${kernel_addr_r} 0 ${boot_block_size};" \
-			"mmc dev 0 2;" \
-			"mmc write ${ramdisk_addr_r} 0 ${boot_block_size};" \
-			"echo Bootloader written successfully;" \
-			"pause 'Press ANY key to reboot device...'; reset;" \
-		"else echo Reading bootloader failed;" \
-			"pause 'Press ANY key to return to bootmenu...'; bootmenu; fi\0"
-
-#define QC750_BOOTMENU \
-	QC750_FLASH_UBOOT \
-	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
-	"bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu\0" \
-	"bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
-	"bootmenu_3=update bootloader=run flash_uboot\0" \
-	"bootmenu_4=reboot RCM=enterrcm\0" \
-	"bootmenu_5=reboot=reset\0" \
-	"bootmenu_6=power off=poweroff\0" \
-	"bootmenu_delay=-1\0"
-
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"boot_block_size_r=0x200000\0" \
-	"boot_block_size=0x1000\0" \
-	"bootloader_file=u-boot-dtb-tegra.bin\0" \
-	"button_cmd_0_name=Volume Down\0" \
-	"button_cmd_0=bootmenu\0" \
-	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
-	QC750_BOOTMENU
-
 /* Board-specific serial config */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
 
diff --git a/include/configs/surface-rt.h b/include/configs/surface-rt.h
index 30f6450cf3..1f0837e179 100644
--- a/include/configs/surface-rt.h
+++ b/include/configs/surface-rt.h
@@ -13,24 +13,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"Microsoft Surface RT"
 
-#define SURFACE_RT_BOOTMENU \
-	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
-	"bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu\0" \
-	"bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
-	"bootmenu_3=boot from USB=usb reset; usb start; bootflow scan\0" \
-	"bootmenu_4=reboot RCM=enterrcm\0" \
-	"bootmenu_5=reboot=reset\0" \
-	"bootmenu_6=power off=poweroff\0" \
-	"bootmenu_delay=-1\0"
-
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"button_cmd_0_name=Volume Down\0" \
-	"button_cmd_0=bootmenu\0" \
-	"button_cmd_1_name=Hall Sensor\0" \
-	"button_cmd_1=poweroff\0" \
-	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
-	SURFACE_RT_BOOTMENU
-
 /* Board-specific serial config */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
 
diff --git a/include/configs/transformer-common.h b/include/configs/transformer-common.h
deleted file mode 100644
index bb6817c8d2..0000000000
--- a/include/configs/transformer-common.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2022, Svyatoslav Ryhel <clamor95@gmail.com>.
- */
-
-#ifndef __TRANSFORMER_COMMON_H
-#define __TRANSFORMER_COMMON_H
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"ASUS Transformer"
-
-#define TRANSFORMER_FLASH_UBOOT \
-	"flash_uboot=echo Preparing RAM;" \
-		"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
-		"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
-		"echo Reading BCT;" \
-		"mmc dev 0 1;" \
-		"mmc read ${kernel_addr_r} 0 ${boot_block_size};" \
-		"echo Reading bootloader;" \
-		"if load mmc 1:1 ${ramdisk_addr_r} ${bootloader_file};" \
-		"then echo Calculating bootloader size;" \
-			"size mmc 1:1 ${bootloader_file};" \
-			"ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};" \
-			"echo Writing bootloader to eMMC;" \
-			"mmc dev 0 1;" \
-			"mmc write ${kernel_addr_r} 0 ${boot_block_size};" \
-			"mmc dev 0 2;" \
-			"mmc write ${ramdisk_addr_r} 0 ${boot_block_size};" \
-			"echo Bootloader written successfully;" \
-			"pause 'Press ANY key to reboot device...'; reset;" \
-		"else echo Reading bootloader failed;" \
-			"pause 'Press ANY key to return to bootmenu...'; bootmenu; fi\0"
-
-#define TRANSFORMER_FLASH_SPI \
-	"update_spi=sf probe 0:1;" \
-		"echo Dumping current SPI flash content ...;" \
-		"sf read ${kernel_addr_r} 0x0 ${spi_size};" \
-		"if fatwrite mmc 1:1 ${kernel_addr_r} spi-flash-backup.bin ${spi_size};" \
-		"then echo SPI flash content was successfully written into spi-flash-backup.bin;" \
-			"echo Reading SPI flash binary;" \
-			"if load mmc 1:1 ${kernel_addr_r} repart-block.bin;" \
-			"then echo Writing bootloader into SPI flash;" \
-				"sf probe 0:1;" \
-				"sf update ${kernel_addr_r} 0x0 ${spi_size};" \
-				"poweroff;" \
-			"else echo Preparing RAM;" \
-				"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
-				"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
-				"echo Reading BCT;" \
-				"sf read ${kernel_addr_r} 0x0 ${boot_block_size_r};" \
-				"echo Reading bootloader;" \
-				"if load mmc 1:1 ${ramdisk_addr_r} ${bootloader_file};" \
-				"then echo Calculating bootloader size;" \
-					"size mmc 1:1 ${bootloader_file};" \
-					"ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};" \
-					"echo Writing bootloader into SPI flash;" \
-					"sf probe 0:1;" \
-					"sf update ${kernel_addr_r} 0x0 ${boot_block_size_r};" \
-					"sf update ${ramdisk_addr_r} ${boot_block_size_r} ${boot_block_size_r};" \
-					"echo Bootloader written successfully; poweroff;" \
-				"else echo Reading bootloader failed;" \
-					"poweroff; fi;" \
-			"fi;" \
-		"else echo SPI flash backup FAILED! Aborting ...;" \
-			"poweroff; fi\0"
-
-#define TRANSFORMER_BOOTMENU \
-	TRANSFORMER_FLASH_UBOOT \
-	TRANSFORMER_FLASH_SPI \
-	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
-	"bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu\0" \
-	"bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
-	"bootmenu_3=update bootloader=run flash_uboot\0" \
-	"bootmenu_4=reboot RCM=enterrcm\0" \
-	"bootmenu_5=reboot=reset\0" \
-	"bootmenu_6=power off=poweroff\0" \
-	"bootmenu_delay=-1\0"
-
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"spi_size=0x400000\0" \
-	"boot_block_size_r=0x200000\0" \
-	"boot_block_size=0x1000\0" \
-	"bootloader_file=u-boot-dtb-tegra.bin\0" \
-	"button_cmd_0_name=Volume Down\0" \
-	"button_cmd_0=bootmenu\0" \
-	"button_cmd_1_name=Lid sensor\0" \
-	"button_cmd_1=poweroff\0" \
-	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
-	TRANSFORMER_BOOTMENU
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/transformer-t20.h b/include/configs/transformer-t20.h
index ca1e70caa7..6a3d9b2403 100644
--- a/include/configs/transformer-t20.h
+++ b/include/configs/transformer-t20.h
@@ -11,7 +11,9 @@
 #define __CONFIG_H
 
 #include "tegra20-common.h"
-#include "transformer-common.h"
+
+/* High-level configuration options */
+#define CFG_TEGRA_BOARD_STRING		"ASUS Transformer"
 
 /* Board-specific serial config */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
diff --git a/include/configs/transformer-t30.h b/include/configs/transformer-t30.h
index d2a16f12c1..792b958a30 100644
--- a/include/configs/transformer-t30.h
+++ b/include/configs/transformer-t30.h
@@ -10,10 +10,10 @@
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
-#include <linux/sizes.h>
-
 #include "tegra30-common.h"
-#include "transformer-common.h"
+
+/* High-level configuration options */
+#define CFG_TEGRA_BOARD_STRING		"ASUS Transformer"
 
 /* Board-specific serial config */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
diff --git a/include/configs/x3-t30.h b/include/configs/x3-t30.h
index 78a2012861..c152af9b7e 100644
--- a/include/configs/x3-t30.h
+++ b/include/configs/x3-t30.h
@@ -10,55 +10,11 @@
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
-#include <linux/sizes.h>
-
 #include "tegra30-common.h"
 
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"LG X3 Board"
 
-#define X3_FLASH_UBOOT \
-	"flash_uboot=echo Preparing RAM;" \
-		"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
-		"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
-		"echo Reading BCT;" \
-		"mmc dev 0 1;" \
-		"mmc read ${kernel_addr_r} 0 ${boot_block_size};" \
-		"echo Reading bootloader;" \
-		"if load mmc 0:1 ${ramdisk_addr_r} ${bootloader_file};" \
-		"then echo Calculating bootloader size;" \
-			"size mmc 0:1 ${bootloader_file};" \
-			"ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};" \
-			"echo Writing bootloader to eMMC;" \
-			"mmc dev 0 1;" \
-			"mmc write ${kernel_addr_r} 0 ${boot_block_size};" \
-			"mmc dev 0 2;" \
-			"mmc write ${ramdisk_addr_r} 0 ${boot_block_size};" \
-			"echo Bootloader written successfully;" \
-			"pause 'Press ANY key to reboot device...'; reset;" \
-		"else echo Reading bootloader failed;" \
-			"pause 'Press ANY key to return to bootmenu...'; bootmenu; fi\0"
-
-#define X3_BOOTMENU \
-	X3_FLASH_UBOOT \
-	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
-	"bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu\0" \
-	"bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
-	"bootmenu_3=update bootloader=run flash_uboot\0" \
-	"bootmenu_4=reboot RCM=enterrcm\0" \
-	"bootmenu_5=reboot=reset\0" \
-	"bootmenu_6=power off=poweroff\0" \
-	"bootmenu_delay=-1\0"
-
-#define BOARD_EXTRA_ENV_SETTINGS \
-	"boot_block_size_r=0x200000\0" \
-	"boot_block_size=0x1000\0" \
-	"bootloader_file=u-boot-dtb-tegra.bin\0" \
-	"button_cmd_0_name=Volume Down\0" \
-	"button_cmd_0=bootmenu\0" \
-	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
-	X3_BOOTMENU
-
 /* Board-specific serial config */
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
 
diff --git a/include/env/nvidia/prod_upd.env b/include/env/nvidia/prod_upd.env
new file mode 100644
index 0000000000..f4e381994b
--- /dev/null
+++ b/include/env/nvidia/prod_upd.env
@@ -0,0 +1,60 @@
+boot_block_size_r=0x200000
+boot_block_size=0x1000
+bootloader_file=u-boot-dtb-tegra.bin
+spi_size=0x400000
+boot_dev=0
+
+flash_uboot=echo Preparing RAM;
+	mw ${kernel_addr_r} 0 ${boot_block_size_r};
+		mw ${ramdisk_addr_r} 0 ${boot_block_size_r};
+		echo Reading BCT;
+		mmc dev 0 1;
+		mmc read ${kernel_addr_r} 0 ${boot_block_size};
+		echo Reading bootloader;
+		if load mmc ${boot_dev}:1 ${ramdisk_addr_r} ${bootloader_file};
+		then echo Calculating bootloader size;
+			size mmc ${boot_dev}:1 ${bootloader_file};
+			ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};
+			echo Writing bootloader to eMMC;
+			mmc dev 0 1;
+			mmc write ${kernel_addr_r} 0 ${boot_block_size};
+			mmc dev 0 2;
+			mmc write ${ramdisk_addr_r} 0 ${boot_block_size};
+			echo Bootloader written successfully;
+			pause 'Press ANY key to reboot device...'; reset;
+		else echo Reading bootloader failed;
+			pause 'Press ANY key to return to bootmenu...'; bootmenu; fi
+
+update_spi=sf probe 0:1;
+	echo Dumping current SPI flash content ...;
+	sf read ${kernel_addr_r} 0x0 ${spi_size};
+	if fatwrite mmc 1:1 ${kernel_addr_r} spi-flash-backup.bin ${spi_size};
+	then echo SPI flash content was successfully written into spi-flash-backup.bin;
+		echo Reading SPI flash binary;
+		if load mmc 1:1 ${kernel_addr_r} repart-block.bin;
+		then echo Writing bootloader into SPI flash;
+			sf probe 0:1;
+			sf update ${kernel_addr_r} 0x0 ${spi_size};
+			echo Bootloader SUCCESSFULLY written into SPI flash;
+			pause 'Press ANY key to reboot...'; reset;
+		else echo Preparing RAM;
+			mw ${kernel_addr_r} 0 ${boot_block_size_r};
+			mw ${ramdisk_addr_r} 0 ${boot_block_size_r};
+			echo Reading BCT;
+			sf read ${kernel_addr_r} 0x0 ${boot_block_size_r};
+			echo Reading bootloader;
+			if load mmc 1:1 ${ramdisk_addr_r} ${bootloader_file};
+			then echo Calculating bootloader size;
+				size mmc 1:1 ${bootloader_file};
+				ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};
+				echo Writing bootloader into SPI flash;
+				sf probe 0:1;
+				sf update ${kernel_addr_r} 0x0 ${boot_block_size_r};
+				sf update ${ramdisk_addr_r} ${boot_block_size_r} ${boot_block_size_r};
+				echo Bootloader written SUCCESSFULLY;
+				pause 'Press ANY key to reboot...'; reset;
+			else echo Reading bootloader failed;
+				pause 'Press ANY key to reboot...'; reset; fi;
+		fi;
+	else echo SPI flash backup FAILED! Aborting ...;
+		pause 'Press ANY key to reboot...'; reset; fi
-- 
2.43.0

