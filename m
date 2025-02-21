Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50045C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 20:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F4B806FE;
	Fri, 21 Feb 2025 21:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TUG6CaB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43CEA80F56; Fri, 21 Feb 2025 21:43:44 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D4418001F
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 21:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d191bfeafbso8047745ab.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 12:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740170618; x=1740775418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H2RvEO8nynMaPpvRICUBvh9fIgaePUGLMJtCoarreVE=;
 b=TUG6CaB7M1t2Ric+y1hfXua5Y26HGcclg/dDyml06KTByoYyr7Tug3ZNk4lReNlrhu
 qA01PN/jEKxHevCRmL3nuusMmrXXEzp5bk9FkjM+yrNmhuAykYUdLrfdoV5JOOSBxDzU
 nuPFV3UsPQpLwndFV8elzWOOI5ksvuWeXmOG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740170618; x=1740775418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H2RvEO8nynMaPpvRICUBvh9fIgaePUGLMJtCoarreVE=;
 b=qraKis4yxaxvY4kHt2lH7zYBitCFjC5dHh9L4lrDyNrO4/mrpIJl2VSN3KseArMegh
 j+lvae6MhevhIGBRBuNGq1VNPDdnT+QCOm17bNHMDkAx1hlsjKKH+rWzvo5QplBHdARq
 JQeStS/wzPg7oCnWymywZkiHfCpVL5U/sUucHDLoM6gxE9B8AwrmQn2i4D19u1ghB2jb
 gNGT3Ts68JH45JXLogxVBvfJDNWz0Dt/GSlPpKgrsconK0A29+6oXmHicRJTiRMxhWG2
 tgZbsH4hs60b1k5Y00qP9ryKy3iV+Y6TRd8xOdZ9YdN+GIT7I0+qFFgswxEApyDUyf7g
 2f4Q==
X-Gm-Message-State: AOJu0YyqGXTphkL7+U7VcZ/rv4vP6JNoPdc1RqdJS0ta7pfdQXDpiL/j
 XRyaD77sRdTToQHJueRqgqco+qP0Mmrau2Oreb9p53nQZexmP7lQITM0vwoA1+JZaJYYLPGt9aA
 =
X-Gm-Gg: ASbGncucWswhUjWilOOuhHMSRc6uaemCTDR46+3uK6tqODR/75khbFxuNYUB7cnG7Y0
 pbjRjBsskQ2gDQ1k38E1rWPHacXSDT0BVjq8XSPrT9CGTRBEVw26irhSAAj0AtR1HAX41O1hrCr
 HXPGkdJFn/aiIHJCS92RTo3BShQx1vHBdtJCKCJo+0UVX3dDrVTL/R58rIZ3Xh+FkL99WGyddXm
 42ZlcoVp9bu8jnaP/MFPL+kDXkKiVBJwCmq2Bg8AgXVzGrYOSXd1oWxj01EnlKp0Jo0w15IThgt
 xt5gDTRU2UuaFuZFDQQh1/ViAPXT0J2kTNblX18k4mKRxf4k9+FYoAyaAVVzZPA=
X-Google-Smtp-Source: AGHT+IEGsTWAIy2B73FcW1R1wVsAAK79JXS5/Xz6w5oNgBj7579cBkiMl0C0qBgF+vk2Xa21vByZBg==
X-Received: by 2002:a05:6e02:2413:b0:3d0:ca2:156d with SMTP id
 e9e14a558f8ab-3d2caf04813mr50116995ab.14.1740170617613; 
 Fri, 21 Feb 2025 12:43:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eeb6780bb4sm1663476173.131.2025.02.21.12.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 12:43:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 1/2] labgrid-sjg: Add kea lab
Date: Fri, 21 Feb 2025 13:43:01 -0700
Message-ID: <20250221204329.677953-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Add the current state of the kea lab as an example to others.

This includes 48 boards, not all of which work.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 labgrid-sjg/kea_env.cfg     | 1546 +++++++++++++++++++++++++++++++++++
 labgrid-sjg/kea_export.yaml | 1117 +++++++++++++++++++++++++
 labgrid-sjg/kea_places.yaml |  188 +++++
 3 files changed, 2851 insertions(+)
 create mode 100644 labgrid-sjg/kea_env.cfg
 create mode 100644 labgrid-sjg/kea_export.yaml
 create mode 100644 labgrid-sjg/kea_places.yaml

diff --git a/labgrid-sjg/kea_env.cfg b/labgrid-sjg/kea_env.cfg
new file mode 100644
index 0000000..a12bbd5
--- /dev/null
+++ b/labgrid-sjg/kea_env.cfg
@@ -0,0 +1,1546 @@
+#
+# kea environment - information about targets
+#
+# This lists the targets (boards) and what drivers are needed for each
+
+targets:
+  rpi3:
+    resources:
+      RemotePlace:
+        name: rpi3
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      YKUSHPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'U-Boot>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rpi_3_32b
+      UBootWriterDriver:
+        method: rpi3
+
+  opi_pc:
+    resources:
+      RemotePlace:
+        name: opi_pc
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      NetworkPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: orangepi_pc
+      UBootWriterDriver:
+        method: sunxi
+
+  rock2:
+    resources:
+      RemotePlace:
+        name: rock2
+
+    features:
+      - flash
+      - build
+      - no-boot  ## hangs in SPL
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      YKUSHPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rock2
+      UBootWriterDriver:
+        method: rockchip
+
+  pcduino3:
+    resources:
+      RemotePlace:
+        name: pcduino3
+
+    features:
+      - flash
+      - send
+      - build
+      - no-boot-flash  ## Boots from internal NAND?
+      - bad-console ## starts at 'Unknown monitor'
+      - issue 1400
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      YKUSHPowerDriver: {}
+      USBStorageDriver: {}
+      HIDRelayDriver: {}
+      DigitalOutputRecoveryDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy:
+        send_only: True
+      UBootProviderDriver:
+        board: Linksprite_pcDuino3
+      UBootWriterDriver:
+        method: sunxi
+      SunxiUSBDriver:
+        loadaddr: 0x4a000000
+
+  pcduino3_nano:
+    resources:
+      RemotePlace:
+        name: pcduino3_nano
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      YKUSHPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: Linksprite_pcDuino3_Nano
+      UBootWriterDriver:
+        method: sunxi
+
+  samus:
+    resources:
+      RemotePlace:
+        name: samus
+
+    features:
+      - flash
+      - build
+      - variants  ## chromebook_samus_tpl
+
+    drivers:
+      NetworkPowerDriver: {}
+      SerialDriver: {}
+      ServoDriver: {}
+      ServoResetDriver: {}
+      SFEmulatorDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 25
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: chromebook_samus
+        binman_indir: /vid/software/devel/samus/bin
+      UBootWriterDriver:
+        method: em100
+
+  samus_tpl:
+    resources:
+      RemotePlace:
+        name: samus
+
+    features:
+      - flash
+      - build
+      - variants  ## chromebook_samus_tpl
+
+    drivers:
+      NetworkPowerDriver: {}
+      SerialDriver: {}
+      ServoDriver: {}
+      ServoResetDriver: {}
+      SFEmulatorDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 25
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: chromebook_samus_tpl
+        binman_indir: /vid/software/devel/samus/bin
+      UBootWriterDriver:
+        method: em100
+
+  nyan-big:
+    resources:
+      RemotePlace:
+        name: nyan-big
+
+    features:
+      - build
+      - send    ## Does not have SPI-flash image
+      - no-flash
+
+    drivers:
+      NetworkPowerDriver: {}
+      SerialDriver: {}
+      ServoDriver: {}
+      ServoResetDriver: {}
+      ServoRecoveryDriver: {}
+      SFEmulatorDriver: {}
+      TegraUSBDriver:
+        loadaddr: 0x80108000
+        bct: '/vid/software/devel/tegra/cbootimage-configs/tegra124/nvidia/norrin/PM370_Hynix_2GB_H5TC4G63AFR_PBA_924MHz_01212014.bct'
+        usb_path: 1-3.4.1
+      UBootDriver:
+        prompt: 'Tegra124 \(Nyan-big\) #'
+        login_timeout: 8
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy:
+        send_only: True
+      UBootProviderDriver:
+        board: nyan-big
+      UBootWriterDriver:
+        method: tegra
+
+  link:
+    resources:
+      RemotePlace:
+        name: link
+
+    features:
+      - build
+      - flash
+
+    drivers:
+      NetworkPowerDriver: {}
+      SerialDriver:
+        txdelay: 0.02
+      ServoDriver: {}
+      ServoResetDriver: {}
+      SFEmulatorDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 3
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: chromebook_link
+        binman_indir: /vid/software/devel/link/bin
+      UBootWriterDriver:
+        method: em100
+
+  link64:
+    resources:
+      RemotePlace:
+        name: link
+
+    features:
+      - build
+      - flash
+
+    drivers:
+      AlwaysPowerDriver: {}
+      SerialDriver:
+        txdelay: 0.02
+      ServoDriver: {}
+      ServoResetDriver: {}
+      SFEmulatorDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 3
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: chromebook_link64
+        binman_indir: /vid/software/devel/link/bin
+      UBootWriterDriver:
+        method: em100
+
+  jerry:
+    resources:
+      RemotePlace:
+        name: jerry
+
+    features:
+      - build
+      - flash
+      - no-boot  ## hangs at: Loading Environment from nowhere... OK
+
+    drivers:
+      NetworkPowerDriver: {}
+      SerialDriver: {}
+      ServoDriver: {}
+      ServoResetDriver: {}
+      SFEmulatorDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: chromebook_jerry
+      UBootWriterDriver:
+        method: em100
+
+  minnowmax:
+    resources:
+      RemotePlace:
+        name: minnowmax
+
+    features:
+      - build
+      - flash
+
+    drivers:
+      SerialDriver: {}
+      NetworkPowerDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      SFEmulatorDriver: {}
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: minnowmax
+        binman_indir: /vid/software/devel/minnowmax/bin
+      UBootWriterDriver:
+        method: em100
+
+  zybo:
+    resources:
+      RemotePlace:
+        name: zybo
+
+    features:
+      - build
+      - flash
+
+    drivers:
+      SerialDriver: {}
+      HIDRelayDriver: {}
+      DigitalOutputResetDriver: {}
+      NetworkPowerDriver: {}
+      USBSDWireDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'Zynq>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy:
+        console_needs_power: True
+        power_on_before_reset: True
+      UBootProviderDriver:
+        board: xilinx_zynq_virt
+        device_tree: zynq-zybo
+      UBootWriterDriver:
+        method: zynq
+
+  tk1:
+    resources:
+      RemotePlace:
+        name: tk1
+
+    features:
+      - build
+      - send
+      - no-flash
+      - no-boot  ## no DigitalOutputProtocol driver found in Target
+
+    drivers:
+    - SerialDriver: {}
+    - AlwaysPowerDriver: {}
+    - HIDRelayDriver:
+        name: reset_driver
+        bindings:
+          relay: reset
+    - HIDRelayDriver:
+        name: recovery_driver
+        bindings:
+          relay: recovery
+    - DigitalOutputResetDriver:
+        name: reset_output
+        bindings:
+          output: reset_driver
+    - DigitalOutputRecoveryDriver:
+        name: recovery_output
+        bindings:
+          output: recovery_driver
+    - TegraUSBDriver:
+        loadaddr: 0x80108000
+        bct: '/vid/software/devel/tegra/tegra-uboot-flasher-scripts/jetson-tk1/PM375_Hynix_2GB_H5TC4G63AFR_RDA_924MHz.bct'
+        usb_path: 4-10.1.1
+    - UBootDriver:
+        prompt: 'Tegra124 (Jetson TK1) #'
+        login_timeout: 5
+    - ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+    - UBootStrategy:
+        send_only: True
+    - UBootProviderDriver:
+        board: jetson-tk1
+    - UBootWriterDriver:
+        method: tegra
+
+#  puma:
+#    resources:
+#      RemotePlace:
+#        name: puma
+#
+#    features:
+#      - build
+#      - no-flash  ## does not seem to work with SD-wire
+#      - no-boot   ## no serial output on DB9 (115200 baud)
+#
+#    drivers:
+#      SerialDriver:
+#        txdelay: 0.01
+#      USBSDWireDriver: {}
+#      USBStorageDriver: {}
+#      NetworkPowerDriver: {}
+#      UBootDriver:
+#        prompt: '=>'
+#        login_timeout: 15
+#      ShellDriver:
+#        prompt: 'root@\w+:[^ ]+ '
+#        login_prompt: ' login: '
+#        username: 'root'
+#      UBootStrategy: {}
+#      UBootProviderDriver:
+#        board: puma-rk3399
+#        bl31: /scratch/sglass/arm-trusted-firmware/build/rk3399/release/bl31/bl31.elf
+#      UBootWriterDriver:
+#        method: rockchip
+#
+  salmon:
+    resources:
+      RemotePlace:
+        name: salmon
+
+    features:
+      - no-build    ## not in mainline
+      - no-send     ## not tested
+      - no-flash    ## does not have SD-wire
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      HIDRelayDriver: {}
+      DigitalOutputResetDriver: {}
+      AlwaysPowerDriver: {}
+      IMXUSBDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: snappermx6
+      UBootWriterDriver:
+        method: imx
+
+  xu3:
+    resources:
+      RemotePlace:
+        name: xu3
+
+    features:
+      - build
+      - no-flash ## ignores SD-wire image
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      USBStorageDriver: {}
+      NetworkPowerDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: odroid-xu3
+      UBootWriterDriver:
+        method: samsung
+        bl1: /vid/software/devel/hardkernel-xu3/sd_fuse/hardkernel_1mb_uboot/bl1.bin.hardkernel
+        bl2: /vid/software/devel/hardkernel-xu3/sd_fuse/hardkernel_1mb_uboot/bl2.bin.hardkernel.1mb_uboot
+        tzsw: /vid/software/devel/hardkernel-xu3/sd_fuse/hardkernel_1mb_uboot/tzsw.bin.hardkernel
+
+  olimex-a20:
+    resources:
+      RemotePlace:
+        name: olimex-a20
+
+    features:
+      - build
+      - no-boot   ## no console output
+      - no-send   ## USB device does not appear
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      HIDRelayDriver: {}
+      ##DigitalOutputRecoveryDriver: {}
+      NetworkPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: A20-OLinuXino_MICRO
+      UBootWriterDriver:
+        method: sunxi
+      SunxiUSBDriver:
+        loadaddr: 0x4a000000
+
+  opi_pc2:
+    resources:
+      RemotePlace:
+        name: opi_pc2
+
+    features:
+      - flash
+      - build
+      - no-boot  ## hangs in SPL: Trying to boot from MMC1
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      NetworkPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 25
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: orangepi_pc2
+        bl31: /scratch/sglass/arm-trusted-firmware/build/sun50i_a64/debug/bl31.bin
+        scp: /vid/software/devel/orange_pi/opi_pc2/scp.bin
+      UBootWriterDriver:
+        method: sunxi
+
+  bpi:
+    resources:
+      RemotePlace:
+        name: bpi
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      YKUSHPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 20
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: Bananapi
+      UBootWriterDriver:
+        method: sunxi
+
+  rpi2:
+    resources:
+      RemotePlace:
+        name: rpi2
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      YKUSHPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'U-Boot>'
+        login_timeout: 10
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rpi_2
+      UBootWriterDriver:
+        method: rpi2
+
+  edison:
+    resources:
+      RemotePlace:
+        name: edison
+
+    features:
+      - build
+      - no-flash   ## too complicated
+      - no-boot    ## UART not available (same as zynq_zybo)
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      HIDRelayDriver: {}
+      NetworkPowerDriver: {}
+      UBootDriver:
+        prompt: 'U-Boot>'
+        login_timeout: 10
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rpi_2
+      UBootWriterDriver:
+        method: rpi2
+
+  bob:
+    resources:
+      RemotePlace:
+        name: bob
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      NetworkPowerDriver: {}
+      SerialDriver: {}
+      ServoDriver: {}
+      ServoResetDriver: {}
+      SFEmulatorDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 30
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: chromebook_bob
+        bl31: /scratch/sglass/arm-trusted-firmware/build/rk3399/release/bl31/bl31.elf
+      UBootWriterDriver:
+        method: em100
+
+  lcdk:
+    resources:
+      RemotePlace:
+        name: lcdk
+
+    features:
+      - no-flash  ## ValueError: Unknown writing method davinci
+      - build
+      - no-boot
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      HIDRelayDriver: {}
+      USBSDWireDriver: {}
+      NetworkPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'U-Boot>'
+        login_timeout: 10
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: omapl138_lcdk
+      UBootWriterDriver:
+        method: davinci
+
+  ff3399:
+    resources:
+      RemotePlace:
+        name: ff3399
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      HIDRelayDriver: {}
+      DigitalOutputResetDriver: {}
+      USBSDWireDriver: {}
+      USBStorageDriver: {}
+      AlwaysPowerDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: firefly-rk3399
+        bl31: /scratch/sglass/arm-trusted-firmware/build/rk3399/release/bl31/bl31.elf
+        tee: /scratch/sglass/optee_os/out/arm-plat-rockchip/core/tee.bin
+      UBootWriterDriver:
+        method: rockchip
+
+  sn9260:
+    resources:
+      RemotePlace:
+        name: sn9260
+
+    features:
+      - no-build    ## not in mainline
+      - no-boot     ## hangs on: Start Snapper 9260 Bootstrap...
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      HIDRelayDriver: {}
+      DigitalOutputResetDriver: {}
+      AlwaysPowerDriver: {}
+      ## AT91USBDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: snapper9260
+      UBootWriterDriver:
+        method: at91
+
+  coral:
+    resources:
+      RemotePlace:
+        name: coral
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      NetworkPowerDriver: {}
+      SerialDriver:
+        txdelay: 0.02
+      ServoDriver: {}
+      ServoResetDriver: {}
+      SFEmulatorDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 40
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: chromebook_coral
+        binman_indir: /vid/software/devel/coral/bin
+      UBootWriterDriver:
+        method: em100
+
+  rpi3z:
+    resources:
+      RemotePlace:
+        name: rpi3z
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      YKUSHPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'U-Boot>'
+        login_timeout: 10
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rpi_3
+      UBootWriterDriver:
+        method: rpi3
+
+  bbb:
+    resources:
+      RemotePlace:
+        name: bbb
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      HIDRelayDriver: {}
+      DigitalOutputResetDriver: {}
+      NetworkPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        ## board: am335x_boneblack_vboot
+        board: am335x_evm
+      UBootWriterDriver:
+        method: bbb
+
+  snow:
+    resources:
+      RemotePlace:
+        name: snow
+
+    features:
+      - no-flash   ## no em100
+      - build
+      - send
+      - bad-console ## starts at '*** Warning - bad CRC'
+
+    drivers:
+      NetworkPowerDriver: {}
+      SerialDriver:
+        txdelay: 0.02
+      ServoDriver: {}
+      ServoResetDriver:
+        delay: 1.0
+      ServoRecoveryDriver: {}
+      UBootDriver:
+        prompt: 'snow #'
+        login_timeout: 40
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      SamsungUSBDriver:
+        bl1: '/vid/software/devel/exynos/snow/u-boot.bl1.bin'
+        bl1_loadaddr: 0x02021400
+        spl_loadaddr: 0x02023400
+        loadaddr: 0x43e00000
+      UBootWriterDriver:
+        method: samsung
+      UBootStrategy:
+        send_only: True
+      UBootProviderDriver:
+        board: snow
+
+  kevin:
+    resources:
+      RemotePlace:
+        name: kevin
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      NetworkPowerDriver: {}
+      SerialDriver:
+        txdelay: 0.02
+      ServoDriver: {}
+      ServoResetDriver: {}
+      ServoRecoveryDriver: {}
+      SFEmulatorDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 30
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootWriterDriver:
+        method: em100
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: chromebook_kevin
+        bl31: /scratch/sglass/arm-trusted-firmware/build/rk3399/release/bl31/bl31.elf
+
+  pine64:
+    resources:
+      RemotePlace:
+        name: pine64
+
+    features:
+      - flash
+      - build
+      - no-boot   ## no console output
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      AlwaysPowerDriver: {}
+      HIDRelayDriver: {}
+      DigitalOutputResetDriver: {}
+      USBSDWireDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: pine64_plus
+        bl31: /vid/software/devel/pine/pine_a64/bl31.bin
+        ## bl31: /scratch/sglass/arm-trusted-firmware/build/sun50i_a64/debug/bl31.bin
+        scp: /vid/software/devel/pine/pine_a64/scp.bin
+      UBootWriterDriver:
+        method: sunxi
+
+  c4:
+    resources:
+      RemotePlace:
+        name: c4
+
+    features:
+      - no-flash  ## no amlogic method
+      - build
+      - no-boot   ## cannot load software
+
+    drivers:
+      SerialDriver: {}
+      NetworkPowerDriver: {}
+      USBSDWireDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: odroid-c4
+        binman_indir: /vid/software/devel/amlogic/bin
+      UBootWriterDriver:
+        method: amlogic
+
+  rpi4:
+    resources:
+      RemotePlace:
+        name: rpi4
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      NetworkPowerDriver: {}
+      HIDRelayDriver: {}
+      DigitalOutputResetDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'U-Boot>'
+        login_timeout: 20
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rpi_4
+      UBootWriterDriver:
+        method: rpi4
+
+  rpi0:
+    resources:
+      RemotePlace:
+        name: rpi0
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      YKUSHPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'U-Boot>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rpi_0_w
+      UBootWriterDriver:
+        method: rpi0
+
+  qemu-x86:
+    resources:
+      RemotePlace:
+        name: qemu-x86
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      QEMUDriver:
+        qemu_bin: 'qemu-x86'
+        memory: '4G'
+        disk: debian32
+        ## display: fb-headless
+      UBootDriver:
+        prompt: '=>'
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootProviderDriver:
+        board: qemu-x86
+      UBootWriterDriver:
+        method: qemu-rom
+      UBootStrategy: {}
+
+  qemu-x86_64:
+    resources:
+      RemotePlace:
+        name: qemu-x86_64
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      QEMUDriver:
+        qemu_bin: 'qemu-x86_64'
+        memory: '4G'
+        disk: ubuntu
+        kvm: True
+        cpu: host
+        ## display: fb-headless
+      UBootDriver:
+        prompt: '=>'
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootProviderDriver:
+        board: qemu-x86_64
+      UBootWriterDriver:
+        method: qemu-rom
+      UBootStrategy: {}
+
+  qemu_arm:
+    resources:
+      RemotePlace:
+        name: qemu_arm
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      QEMUDriver:
+        qemu_bin: 'qemu_arm'
+        machine: 'virt'
+        memory: '512M'
+        ## display: fb-headless
+      UBootDriver:
+        prompt: '=>'
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootProviderDriver:
+        board: qemu_arm
+      UBootWriterDriver:
+        method: qemu
+      UBootStrategy: {}
+
+  play:
+    resources:
+      RemotePlace:
+        name: play
+
+    features:
+      - flash
+      - build
+
+    drivers:
+    - SerialDriver:
+        txdelay: 0.01
+    - USBSDWireDriver: {}
+    - AlwaysPowerDriver: {}
+    - HIDRelayDriver:
+        name: reset_driver
+        bindings:
+          relay: reset
+    - HIDRelayDriver:
+        name: recovery_driver
+        bindings:
+          relay: recovery
+    - DigitalOutputResetDriver:
+        name: reset_output
+        bindings:
+          output: reset_driver
+    - DigitalOutputRecoveryDriver:
+        name: recovery_output
+        bindings:
+          output: recovery_driver
+    - USBStorageDriver: {}
+    - UBootDriver:
+        prompt: '=>'
+        autoboot: "Press SPACE to abort autoboot"
+        login_timeout: 15
+        interrupt: ' '
+    - ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+    - UBootStrategy:
+        recovery_reset: True
+    - UBootProviderDriver:
+        board: am62x_beagleplay_a53
+        board_extra: am62x_beagleplay_r5
+        bl31: /scratch/sglass/trusted-firmware-a/build/k3/lite/release/bl31.bin
+        tee: /scratch/sglass/optee_os/out/arm-plat-k3/core/tee-raw.bin
+        binman_indir: /scratch/sglass/ti-linux-firmware
+    - UBootWriterDriver:
+        method: ti,am625
+
+  vbe:
+    resources:
+      RemotePlace:
+        name: ff3399
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      HIDRelayDriver: {}
+      DigitalOutputResetDriver: {}
+      USBSDWireDriver: {}
+      USBStorageDriver: {}
+      AlwaysPowerDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rk3399-generic-ddr3
+        bl31: /scratch/sglass/arm-trusted-firmware/build/rk3399/release/bl31/bl31.elf
+        tee: /scratch/sglass/optee_os/out/arm-plat-rockchip/core/tee.bin
+      UBootWriterDriver:
+        method: rockchip
+        vbe_tpl: rk3399-firefly
+
+  rpi:
+    resources:
+      RemotePlace:
+        name: rpi
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      YKUSHPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'U-Boot>'
+        login_timeout: 10
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rpi
+      UBootWriterDriver:
+        method: rpi3
+
+  vf2:
+    resources:
+      RemotePlace:
+        name: vf2
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      NetworkPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'StarFive #'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: starfive_visionfive2
+        opensbi: /vid/software/devel/riscv/fw_payload.bin
+      UBootWriterDriver:
+        method: riscv
+
+  colibrimx8:
+    resources:
+      RemotePlace:
+        name: colibrimx8
+
+    features:
+      - build
+      - send
+      - no-flash
+
+    drivers:
+      NetworkPowerDriver: {}
+      SerialDriver: {}
+      UUUDriver:
+        monitor_path: 7:933
+      IMXUSBDriver: {}
+      UBootDriver:
+        prompt: 'Colibri iMX8X #'
+        login_timeout: 5
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy:
+        send_only: True
+      UBootProviderDriver:
+        board: colibri-imx8x
+        bl31: /vid/software/devel/imx/colibri-imx8x/
+        # Need some blobs to be in the sourcedir for now
+        copy_in:
+          - /vid/software/devel/imx/colibri-imx8x/mx8qx-ahab-container.img
+          - /vid/software/devel/imx/colibri-imx8x/mx8qx-colibri-scfw-tcm.bin
+          - /vid/software/devel/imx/colibri-imx8x/bl31.bin
+        # Need to specify a particular build target for now
+        build_target: u-boot-dtb.imx
+      UBootWriterDriver:
+        method: uuu-imx
+
+  utilite:
+    resources:
+      RemotePlace:
+        name: utilite
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      NetworkPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'U-Boot>'
+        login_timeout: 10
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: cm_fx6
+      UBootWriterDriver:
+        method: mx6
+
+  rockpro64:
+    resources:
+      RemotePlace:
+        name: rockpro64
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      NetworkPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 10
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rockpro64-rk3399
+        bl31: /vid/software/devel/rk3399/rockpro64/bl31.elf
+        tee: /scratch/sglass/optee_os/out/arm-plat-rockchip/core/tee.bin
+      UBootWriterDriver:
+        method: rockchip
+
+  rock3a:
+    resources:
+      RemotePlace:
+        name: rock3a
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      NetworkPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 10
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rock-3a-rk3568
+        bl31: /vid/software/devel/rockchip/rk3568/bl31.elf
+        rockchip_tpl: /vid/software/devel/rockchip/rk3568/rk3568_ddr_1560MHz_v1.23.bin
+
+      UBootWriterDriver:
+        method: rockchip
+
+  rock5b:
+    resources:
+      RemotePlace:
+        name: rock5b
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      NetworkPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: '=>'
+        login_timeout: 10
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rock5b-rk3588
+        bl31: /vid/software/devel/rockchip/rk3588/rk3588_bl31_v1.47.elf
+        rockchip_tpl: /vid/software/devel/rockchip/rk3588/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.18.bin
+
+      UBootWriterDriver:
+        method: rockchip
+
+  rpi5:
+    resources:
+      RemotePlace:
+        name: rpi5
+
+    features:
+      - flash
+      - build
+
+    drivers:
+      SerialDriver:
+        txdelay: 0.01
+      USBSDWireDriver: {}
+      NetworkPowerDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'U-Boot>'
+        login_timeout: 20
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy: {}
+      UBootProviderDriver:
+        board: rpi_arm64
+
+      UBootWriterDriver:
+        method: rpi5
+
+  zzsoc:
+    resources:
+      RemotePlace:
+        name: zzsoc
+
+    features:
+      - build
+      - flash
+
+    drivers:
+      SerialDriver: {}
+      HIDRelayDriver: {}
+      ButtonDriver: {}
+      NetworkPowerDriver: {}
+      USBSDWireDriver: {}
+      USBStorageDriver: {}
+      UBootDriver:
+        prompt: 'Zynq>'
+        login_timeout: 15
+      ShellDriver:
+        prompt: 'root@\w+:[^ ]+ '
+        login_prompt: ' login: '
+        username: 'root'
+      UBootStrategy:
+        power_on_button: True
+      UBootProviderDriver:
+        board: xilinx_zynqmp_virt
+        device_tree: zynqmp-zcu100-revC
+      UBootWriterDriver:
+        method: zynqmp
+
+images:
+  u-boot.bin: "/tmp/b/rpi_3_32b/u-boot.bin"
+  disk-image: /vid/software/linux/ubuntu/ubuntu-16.04.6-desktop-i386.iso
+  debian32: /vid/software/linux/debian/debian-32.img
+  ubuntu: /vid/software/linux/ubuntu/ubuntu-24.04.1-desktop-amd64.iso
+
+paths:
+  uboot_build_base: "/tmp/b"
+  uboot_workdirs: "/tmp/b/workdirs"
+  uboot_source: "/scratch/sglass/cosarm/src/third_party/u-boot/files"
+
+tools:
+  buildman: "buildman"
+  qemu-x86: 'qemu-system-i386'
+  qemu-x86_64: 'qemu-system-x86_64'
+  servod: "/vid/software/devel/ubtest/standalone-hdctools/servod"
+  dut-control: "/vid/software/devel/ubtest/standalone-hdctools/dut-control"
+  qemu_arm: qemu-system-arm
+  uuu-loader: uuu
diff --git a/labgrid-sjg/kea_export.yaml b/labgrid-sjg/kea_export.yaml
new file mode 100644
index 0000000..ddd92b0
--- /dev/null
+++ b/labgrid-sjg/kea_export.yaml
@@ -0,0 +1,1117 @@
+##
+## kea lab: local resources to be exported with:
+##
+##    labgrid-exporter kea.yaml
+##
+## The devices
+
+rpi3:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb-port1
+    ## hub c4
+    match:
+      '@ID_PATH': 'pci-0000:03:00.2-usb-0:5.2.4:1.0'
+
+  USBSDWireDevice:
+    ## sdwire0
+    ## hub c9
+    match:
+      ## '@ID_PATH': 'pci-0000:03:00.2-usb-0:5.4.1.2' ??
+      'ID_SERIAL_SHORT': 'sdwire-18'
+
+  YKUSHPowerPort:
+    ## ykush 0 1
+    serial: 'YK17698'
+    index: 1
+
+opi_pc:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port4
+    ## hub c7
+    match:
+      '@ID_PATH': 'pci-0000:03:00.2-usb-0:5.3.3:1.0'
+
+  USBSDWireDevice:
+    ## sdwire2
+    ## hub c8
+    match:
+      'ID_SERIAL_SHORT': '202001064004'
+
+  NetworkPowerPort:
+    ## dli_main_port1
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.19
+    index: 1
+
+## Hangs at: Returning to boot ROM...
+rock2:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port8
+    ## hub c3
+    match:
+      '@ID_PATH': 'pci-0000:03:00.2-usb-0:5.2.3:1.0'
+
+  USBSDWireDevice:
+    ## sdwire5
+    ## hub c13
+    match:
+      'ID_SERIAL_SHORT': 'sdwireda10'
+
+  YKUSHPowerPort:
+    ## ykush 0 3
+    serial: 'YK17698'
+    index: 3
+
+## boots but ignores uSD card
+## need to try sending
+pcduino3:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port2
+    ## 1-5.3.1
+    ## hub c5
+    match:
+      '@ID_PATH': 'pci-0000:03:00.2-usb-0:5.3.1:1.0'
+
+  USBSDWireDevice:
+    ## sdwire1
+    ## hub c10
+    match:
+      'ID_SERIAL_SHORT': 'sdwire-7'
+
+  YKUSHPowerPort:
+    ## ykush 0 2 (hub c14)
+    serial: 'YK17698'
+    index: 2
+
+  SunxiUSBLoader:
+    ## ykush 0 2(hub c14)
+    ## hub c14
+    ## 1-5.1.2.2
+    match:
+      'ID_PATH': 'pci-0000:03:00.2-usb-0:5.1.2.2'
+
+  HIDRelay:
+    ## recovery
+    ## usbrelay 0 4
+    ## hub a 14
+    ## serial: 6QMBS
+    index: 4
+    match:
+      'ID_PATH': 'pci-0000:00:14.0-usb-0:10.1.2'
+
+  ## RecoveryControl:
+  ## usbrelay 0 4
+  ##  serial:
+
+pcduino3_nano:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port12
+    ## hub b2
+    match:
+      '@ID_PATH': 'pci-0000:04:00.0-usb-0:2.2.2:1.0'
+
+  USBSDWireDevice:
+    ## sdwire8
+    ## hub b12
+    match:
+      'ID_SERIAL_SHORT': 'sdwireda1'
+
+  YKUSHPowerPort:
+    ## ykush 1 1
+    serial: 'YK18511'
+    index: 1
+
+samus:
+  location: lab
+
+  Servo:
+    servo_name: samus
+    serial: 686203-00047
+    port: 9900
+    board: samus
+
+  ServoSerialPort:
+    servo_name: samus
+
+  ServoReset:
+    servo_name: samus
+
+  NetworkPowerPort:
+    ## dli_second_port3
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.22
+    index: 3
+
+  SFEmulator:
+    serial: DP025143
+    chip: W25Q64CV
+
+## Downloads but no serial output
+nyan-big:
+  location: lab
+
+  Servo:
+    servo_name: nyan-big
+    serial: 911416-00900
+    port: 9901
+    board: nyan-big
+
+  ServoSerialPort:
+    servo_name: nyan-big
+
+  ServoReset:
+    servo_name: nyan-big
+
+  ServoRecovery:
+    servo_name: nyan-big
+
+  SFEmulator:
+    serial: DP138817
+    chip: W25Q32DW
+
+  NetworkPowerPort:
+    ## dli_second_port2
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.22
+    index: 2
+
+  TegraUSBLoader:
+    ## hub e9
+    ## 1-5.1.2.2
+    match:
+      'ID_PATH': 'pci-0000:03:00.2-usb-0:3.4.1'
+
+link:
+  location: lab
+
+  Servo:
+    servo_name: link
+    serial: 905537-00223
+    port: 9902
+    board: link
+
+  ServoSerialPort:
+    servo_name: link
+
+  ServoReset:
+    servo_name: link
+
+  SFEmulator:
+    serial: DP022781
+    chip: W25Q64FV
+
+  NetworkPowerPort:
+    ## dli_second_port7
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.22
+    index: 7
+
+jerry:
+  location: lab
+
+  Servo:
+    servo_name: jerry
+    serial: 730422-00045
+    port: 9903
+    board: jerry
+
+  ServoSerialPort:
+    servo_name: jerry
+
+  ServoReset:
+    servo_name: jerry
+
+  SFEmulator:
+    serial: DP022783
+    chip: GD25LQ32
+
+  NetworkPowerPort:
+    ## dli_second_port8
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.22
+    index: 8
+
+minnowmax:
+  location: lab
+
+  USBSerialPort:
+    ## ttyusb_port7
+    ## hub b3
+    match:
+      '@ID_PATH': 'pci-0000:04:00.0-usb-0:2.2.3:1.0'
+
+  NetworkPowerPort:
+    ## dli_main_port6
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.19
+    index: 6
+
+  SFEmulator:
+    serial: DP139140
+    chip: W25Q64DW
+
+zybo:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port5
+    ## hub c1
+    match:
+      '@ID_PATH': 'pci-0000:03:00.2-usb-0:5.2.1:1.1'
+      ##ID_SERIAL_SHORT: 210279653540
+      ##ID_USB_INTERFACE_NUM: 01
+
+  USBSDWireDevice:
+    ## sdwire3
+    ## hub
+    match:
+      'ID_SERIAL_SHORT': '202001064001'
+
+  NetworkPowerPort:
+    ## dli_main_port5
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.19
+    index: 5
+
+  HIDRelay:
+    ## usbrelay 0 6
+    ##serial: 6QMBS
+    index: 6
+    match:
+      'ID_PATH': 'pci-0000:00:14.0-usb-0:10.1.2'
+
+tk1:
+  location: 'lab'
+  NetworkSerialPort:
+    ## portserver 1 1
+    ## base port 2000, 16 ports
+    host: 192.168.4.23
+    port: 2001
+    speed: 115200
+
+  reset:
+    ## reset
+    ## usbrelay 0 2
+    ##serial: 6QMBS
+    cls: HIDRelay
+    index: 2
+    match:
+      ID_PATH: pci-0000:00:14.0-usb-0:10.1.2
+
+  recovery:
+    ## recovery
+    ## usbrelay 2 7
+    ##serial:
+    cls: HIDRelay
+    index: 7
+    match:
+      ID_PATH: pci-0000:00:14.0-usb-0:10.4.2
+
+  TegraUSBLoader:
+    ## hub a 13
+    match:
+      ID_PATH: pci-0000:00:14.0-usb-0:10.1.1
+
+## puma:
+##   location: 'lab'
+##
+##   USBSerialPort:
+##     ## ttyusb_port6
+##     ## hub c2
+##     match:
+##       '@ID_PATH': 'pci-0000:03:00.2-usb-0:5.2.2:1.0'
+##
+##   USBSDWireDevice:
+##     ## sdwire4
+##     ## hub b9
+##     match:
+##       'ID_SERIAL_SHORT': '202001064005'
+##
+##   NetworkPowerPort:
+##     ## dli_main_port2
+##     model: digitalloggers_http
+##     host: http://admin:1234@192.168.4.19
+##     index: 2
+##
+##   HIDRelay:
+##     ## usbrelay 0 6=7
+##     ##serial: 6QMBS
+##     index: 7
+##     match:
+##       '@ID_PATH': pci-0000:03:00.2-usb-0:5.2.2:1.0
+
+salmon:
+  location: 'lab'
+
+  NetworkSerialPort:
+    ## portserver 1 2
+    ## base port 2000, 16 ports
+    host: 192.168.4.23
+    port: 2002
+    speed: 115200
+
+  HIDRelay:
+    ## reset
+    ## usbrelay 1 2
+    ##serial: 6AAMZ (hub d2)
+    index: 2
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:4.2.3
+
+  HIDRelay:
+    ## recovery
+    ## usbrelay 1 1
+    ##serial: 6AAMZ (hub d2)
+    index: 1
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:4.2.3
+
+  IMXUSBLoader:
+    ## hub d 3
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:4.2.2
+
+xu3:
+  location: 'lab'
+
+  USBSerialPort:
+    ## ttyusb_port10
+    ## hub b7
+    match:
+      '@ID_PATH': 'pci-0000:04:00.0-usb-0:2.3.3:1.0'
+
+  USBSDWireDevice:
+    ## sdwire7
+    ## hub b8
+    match:
+      ID_SERIAL_SHORT: '202001064002'
+
+  NetworkPowerPort:
+    ## dli_main_port3
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.19
+    index: 3
+
+olimex-a20:
+  location: 'lab'
+
+  USBSerialPort:
+    ## ttyusb_port13
+    ## hub a2
+    match:
+      ID_PATH: pci-0000:00:14.0-usb-0:10.2.2:1.0
+
+  USBSDWireDevice:
+    ## sdwire9
+    ## hub a1
+    match:
+      ID_SERIAL_SHORT: 'sdwireda2'
+
+  NetworkPowerPort:
+    ## dli_main_port4
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.19
+    index: 4
+
+  ## HIDRelay:
+    ## reset
+    ## usbrelay 3 7
+    ##serial: 8QMBS (hub e11)
+    ## index: 7
+    ## match:
+      ## ID_PATH: pci-0000:03:00.2-usb-0:3.4.3
+
+  HIDRelay:
+    ## recovery
+    ## usbrelay 3 8
+    ##serial: 8QMBS (hub e11)
+    index: 8
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:3.4.3
+
+  SunxiUSBLoader:
+    ## hub a12
+    ## send doesn't work as the board is powered from USB
+    match:
+      'ID_PATH': 'pci-0000:00:14.0-usb-0:10.4.4:1.0'
+
+## hangs after SPL
+opi_pc2:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port14
+    ## hub a3
+    match:
+      ID_PATH: pci-0000:00:14.0-usb-0:10.2.3:1.0
+
+  USBSDWireDevice:
+    ## sdwire10
+    ## hub a4
+    match:
+      'ID_SERIAL_SHORT': sdwireda3
+
+  NetworkPowerPort:
+    ## dli_main_port8
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.19
+    index: 8
+
+  SunxiUSBLoader:
+    ## hub a11
+    ## doesn't work as no recovery
+    match:
+      'ID_PATH': 'pci-0000:00:14.0-usb-0:10.4.3:1.0'  ## check this
+
+bpi:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port15
+    ## hub b13
+    match:
+      ID_PATH: pci-0000:04:00.0-usb-0:2.1.1:1.0
+
+  USBSDWireDevice:
+    ## sdwire11
+    ## hub
+    match:
+      'ID_SERIAL_SHORT': sdwireda4
+
+  YKUSHPowerPort:
+    ## ykush 1 2
+    serial: 'YK18511'
+    index: 2
+
+## critical medium error on disk
+rpi2:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port (new to labgrid)
+    ## hub c6
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:5.3.2:1.0
+
+  USBSDWireDevice:
+    ## sdwire12
+    ## hub
+    match:
+      'ID_SERIAL_SHORT': sdwireda5
+
+  YKUSHPowerPort:
+    ## ykush 1 3
+    serial: 'YK18511'
+    index: 3
+
+## No serial
+## Same problem as zynq_zybo as the serial only appears when board is powered
+edison:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port17
+    ## hub
+    match:
+      ##ID_PATH: pci-0000:03:00.2-usb-0:5.3.3:1.0
+      ID_PATH: pci-0000:00:14.0-usb-0:10.1.4:1.0
+      ##ID_SERIAL_SHORT: A903JP72
+      ##ID_USB_INTERFACE_NUM: '00'
+
+  NetworkPowerPort:
+    ## dli_second_port5
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.22
+    index: 5
+
+  HIDRelay:
+    ## recovery
+    ## usbrelay 2 5
+    ## hub a 10
+    ## serial: 7QMBS
+    index: 5
+    match:
+      'ID_PATH': 'pci-0000:00:14.0-usb-0:10.4.2'
+
+  ##IntelUSBLoader:
+    ## ykush2_port1
+    ## hube_10
+    ##match:
+      ##'ID_PATH': 'pci-0000:00:14.0-usb-0:10.4.3:1.0'  ## check this
+
+## Battery broken. Powers on with:
+## $ dut-control -p 9904 ec_uart_pty
+## ec_uart_pty:/dev/pts/41
+## $ ssh kea cu -l /dev/pts/41
+bob:
+  location: lab
+
+  Servo:
+    servo_name: bob
+    serial: 911416-00262
+    port: 9904
+    board: bob
+
+  ServoSerialPort:
+    servo_name: bob
+
+  ServoReset:
+    servo_name: bob
+
+  SFEmulator:
+    serial: DP139156
+    chip: GD25LQ32
+
+  NetworkPowerPort:
+    ## dli_fourth_port5
+    ## was dli_second_port7
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.27
+    index: 5
+
+## No response on serial
+lcdk:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port18
+    ## hub e4
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:3.2.4:1.0
+
+  USBSDWireDevice:
+    ## sdwire13
+    ## hub e3
+    match:
+      'ID_SERIAL_SHORT': 'sdwireda6'
+
+  NetworkPowerPort:
+    ## dli_second_port6
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.22
+    index: 6
+
+  HIDRelay:
+    ## reset
+    ## usbrelay 2 8
+    ## hub a 10
+    ## serial: 7QMBS
+    index: 8
+    match:
+      'ID_PATH': 'pci-0000:00:14.0-usb-0:10.4.2'
+
+  ## RecoveryControl:
+  ## usbrelay 0 4
+  ##  serial:
+
+ff3399:
+  location: 'lab'
+
+  USBSerialPort:
+    speed: 1500000
+    ## ttyusb_port19
+    ## hub e5
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:3.3.1:1.0
+
+  USBSDWireDevice:
+    ## sdwire14
+    ## hub e6
+    match:
+      ##'ID_SERIAL_SHORT': 'sdwireda7'
+      'ID_SERIAL_SHORT': 'da73'
+
+  HIDRelay:
+    ## recovery
+    ## usbrelay 2 1
+    ## hub a 10
+    ## serial: 7QMBS
+    index: 1
+    match:
+      'ID_PATH': 'pci-0000:00:14.0-usb-0:10.4.2'
+
+## stuck at "Start Snapper 9260 Bootstrap..." - needs USB boot
+sn9260:
+  location: 'lab'
+  NetworkSerialPort:
+    ## portserver 1 3
+    ## base port 2000, 16 ports
+    host: 192.168.4.23
+    port: 2003
+    speed: 115200
+
+  HIDRelay:
+    ## reset
+    ## usbrelay 2 2
+    ## hub a 10
+    ## serial: 7QMBS
+    index: 2
+    match:
+      'ID_PATH': 'pci-0000:00:14.0-usb-0:10.4.2'
+
+  HIDRelay:
+    ## recovery
+    ## usbrelay 2 3
+    ## hub a 10
+    ## serial: 7QMBS
+    index: 3
+    match:
+      'ID_PATH': 'pci-0000:00:14.0-usb-0:10.4.2'
+
+coral:
+  location: lab
+
+  Servo:
+    servo_name: coral
+    serial: 911416-00840
+    port: 9905
+    board: coral
+
+  NetworkPowerPort:
+    ## dli_second_port1
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.22
+    index: 1
+
+  ServoSerialPort:
+    servo_name: coral
+
+  ServoReset:
+    servo_name: coral
+
+  SFEmulator:
+    ## try DP034599
+    serial: DP033694
+    chip: w25q128fw
+
+rpi3z:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port20
+    ## hub f1
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:2.1.1:1.0
+
+  USBSDWireDevice:
+    ## sdwire15
+    ## hub e1
+    match:
+      'ID_SERIAL_SHORT': 'da61'
+
+  YKUSHPowerPort:
+    ## ykush 2 2
+    serial: 'YK19193'
+    index: 2
+
+bbb:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port21
+    ## hub f2
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:2.1.2:1.0
+
+  USBSDWireDevice:
+    ## sdwire16
+    ## hub f3
+    match:
+      'ID_SERIAL_SHORT': 'da62'
+
+  NetworkPowerPort:
+    ## dli_second_port4
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.22
+    index: 4
+
+  HIDRelay:
+    ## reset
+    ## usbrelay 3 6
+    ##serial: 8QMBS (hub e11)
+    index: 6
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:3.4.3
+
+snow:
+  location: lab
+
+  Servo:
+    servo_name: snow
+    serial: 911416-00558
+    port: 9906
+    board: daisy
+
+  NetworkPowerPort:
+    ## dli_fourth_port3
+    ## was dli_second_port7
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.27
+    index: 3
+
+  ServoSerialPort:
+    servo_name: snow
+
+  ServoReset:
+    servo_name: snow
+
+  ServoRecovery:
+    servo_name: snow
+
+  SamsungUSBLoader:
+    ## hub d4
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:4.2.4
+
+kevin:
+  location: lab
+
+  ## Port d1
+  Servo:
+    servo_name: kevin
+    serial: 911416-00627
+    port: 9907
+    board: kevin
+
+  NetworkPowerPort:
+    ## dli_fourth_port1
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.27
+    index: 1
+
+  ServoSerialPort:
+    servo_name: kevin
+
+  ServoReset:
+    servo_name: kevin
+
+  ServoRecovery:
+    servo_name: kevin
+
+  SFEmulator:
+    serial: DP137244
+    chip: gd25lq64
+
+## no serial output
+pine64:
+  location: 'lab'
+
+  USBSerialPort:
+    ## ttyusb_port22
+    ## hub f4
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:2.1.4:1.0
+
+  USBSDWireDevice:
+    ## sdwire17
+    ## hub f6
+    match:
+      'ID_SERIAL_SHORT': 'da63'
+
+  HIDRelay:
+    ## reset
+    ## usbrelay 2 4
+    ## hub a 10
+    ## serial: 7QMBS
+    index: 4
+    match:
+      'ID_PATH': 'pci-0000:00:14.0-usb-0:10.4.2'
+
+  SunxiUSBLoader:
+    ## hub f5
+    match:
+      'ID_PATH': 'pci-0000:03:00.2-usb-0:5.3.1.2'  ## check
+
+## no serial output
+c4:
+  location: 'lab'
+
+  USBSerialPort:
+    ## ttyusb_port23
+    ## hub f7
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:2.2.3:1.0
+
+  USBSDWireDevice:
+    ## sdwire18
+    ## hub f8
+    match:
+      'ID_SERIAL_SHORT': 'da64'
+
+  NetworkPowerPort:
+    ## dli_main_port7
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.19
+    index: 7
+
+rpi4:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port24
+    ## hub f9
+    match:
+      '@ID_PATH': 'pci-0000:03:00.2-usb-0:2.3.3:1.0'
+
+  USBSDWireDevice:
+    ## sdwire19
+    ## hub f10
+    match:
+      'ID_SERIAL_SHORT': 'sdwireda9'
+
+  NetworkPowerPort:
+    ## dli_fourth_port6
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.27
+    index: 6
+
+  HIDRelay:
+    ## reset
+    ## usbrelay 3 5
+    ##serial: 8QMBS (hub e11)
+    index: 5
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:3.4.3
+
+rpi0:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port25
+    ## hub f12
+    match:
+      '@ID_PATH': 'pci-0000:03:00.2-usb-0:2.3.4:1.0'
+
+  USBSDWireDevice:
+    ## sdwire20
+    ## hub f13
+    match:
+      'ID_SERIAL_SHORT': 'da70'
+
+  YKUSHPowerPort:
+    ## ykush2_port3
+    ## ykush 2 3
+    serial: 'YK19193'
+    index: 3
+
+qemu-x86:
+  location: 'lab'
+
+qemu-x86_64:
+  location: 'lab'
+
+qemu_arm:
+  location: 'lab'
+
+play:
+  location: 'lab'
+  USBSerialPort:
+    ## hub
+    match:
+      '@ID_PATH': pci-0000:03:00.2-usb-0:2.4.3:1.0
+
+  USBSDWireDevice:
+    ## hub
+    match:
+      ID_SERIAL_SHORT: da69
+
+  reset:
+    ## reset
+    ## usbrelay 3 5
+    ## hub e 11
+    ##serial: 8QMBS (hub e11)
+    cls: HIDRelay
+    index: 5
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:3.4.3
+
+  recovery:
+    ##recovery (USR1)
+    ##usbrelay 2 6
+    ##hub a 10
+    ##serial: 7QMBS
+    cls: HIDRelay
+    index: 6
+    match:
+      ID_PATH: pci-0000:00:14.0-usb-0:10.4.2
+
+rpi:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port??
+    ## hub e13
+    match:
+      ID_PATH: pci-0000:03:00.2-usb-0:3.1.1:1.0
+
+  USBSDWireDevice:
+    ## sdwire71
+    ## hub f16
+    match:
+      'ID_SERIAL_SHORT': 'da71'
+
+  YKUSHPowerPort:
+    ## ykush 2 1
+    serial: 'YK19193'
+    index: 1
+
+vf2:
+  location: 'lab'
+  USBSerialPort:
+    ## ttyusb_port4
+    ## hub c7
+    match:
+      '@ID_PATH': 'pci-0000:00:14.0-usb-0:9.3.4:1.0'
+
+  USBSDWireDevice:
+    ## sdwire2
+    ## hub c8
+    match:
+      'ID_SERIAL_SHORT': 'da72'
+
+  NetworkPowerPort:
+    ## dli_fourth_port7
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.27
+    index: 7
+
+colibrimx8:
+  location: 'lab'
+  NetworkSerialPort:
+    ## portserver 1 5
+    ## base port 2000, 16 ports
+    host: 192.168.4.23
+    port: 2005
+    speed: 115200
+
+  NetworkPowerPort:
+    ## dli_fourth_port8
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.27
+    index: 8
+
+  IMXUSBLoader:
+    ## hub a 13
+    match:
+      ID_PATH: pci-0000:00:14.0-usb-0:9.3.3
+
+utilite:
+  location: 'lab'
+  USBSerialPort:
+    ## hub g10
+    match:
+      '@ID_PATH': pci-0000:00:14.0-usb-0:9.3.2:1.0
+
+  NetworkPowerPort:
+    ## dli_fourth_port2
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.27
+    index: 4
+
+  USBSDWireDevice:
+    ## sdwire2
+    ## hub g9
+    match:
+      ID_SERIAL_SHORT: da74
+
+rockpro64:
+  location: 'lab'
+  USBSerialPort:
+    ## hub g9
+    speed: 1500000
+    match:
+      '@ID_PATH': pci-0000:00:14.0-usb-0:9.3.1:1.0
+
+  NetworkPowerPort:
+    ## dli_fourth_port4
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.27
+    index: 2
+
+  USBSDWireDevice:
+    ## hub g8
+    match:
+      ID_SERIAL_SHORT: da75
+
+rock3a:
+  location: 'lab'
+  USBSerialPort:
+    ## hub g9
+    speed: 1500000
+    match:
+      '@ID_PATH': pci-0000:00:14.0-usb-0:9.2.3:1.0
+
+  NetworkPowerPort:
+    ## dli_fifth_port8
+    ## Allow legacy plaintext login methods
+    ## Allow plaintext URL logins
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.37
+    index: 8
+
+  USBSDWireDevice:
+    ## hub g8
+    match:
+      ID_SERIAL_SHORT: da76
+
+rock5b:
+  location: 'lab'
+  USBSerialPort:
+    ## hub g9
+    speed: 1500000
+    match:
+      '@ID_PATH': pci-0000:00:14.0-usb-0:9.2.2:1.0
+
+  NetworkPowerPort:
+    ## dli_fifth_port4
+    ## Allow legacy plaintext login methods
+    ## Allow plaintext URL logins
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.37
+    index: 4
+
+  USBSDWireDevice:
+    ## hub g8
+    match:
+      ID_SERIAL_SHORT: da77
+
+rpi5:
+  location: 'lab'
+  USBSerialPort:
+    ## hub g3
+    match:
+      ID_PATH: pci-0000:00:14.0-usb-0:9.1.3:1.0
+
+  USBSDWireDevice:
+    match:
+      'ID_SERIAL_SHORT': 'da78'
+
+  NetworkPowerPort:
+    ## dli_fifth_port3
+    ## Allow legacy plaintext login methods
+    ## Allow plaintext URL logins
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.37
+    index: 3
+
+zzsoc:
+  location: 'lab'
+
+  USBSerialPort:
+    ## ttyusb_port6
+    ## hub c2
+    match:
+      ID_PATH: pci-0000:00:14.0-usb-0:9.4.3:1.1
+
+  USBSDWireDevice:
+    ## sdwire4
+    ## hub b9
+    match:
+      'ID_SERIAL_SHORT': '202001064005'
+
+  NetworkPowerPort:
+    ## dli_main_port2
+    model: digitalloggers_http
+    host: http://admin:1234@192.168.4.19
+    index: 2
+
+  HIDRelay:
+    ## usbrelay 0 6=7
+    ##serial: 6QMBS
+    index: 3
+    match:
+      'ID_PATH': 'pci-0000:00:14.0-usb-0:10.1.2'
diff --git a/labgrid-sjg/kea_places.yaml b/labgrid-sjg/kea_places.yaml
new file mode 100644
index 0000000..a0b90c2
--- /dev/null
+++ b/labgrid-sjg/kea_places.yaml
@@ -0,0 +1,188 @@
+# kea lab - places
+#
+# Synced with sync-places.py
+
+places:
+  rpi3:
+    matches:
+      - kea/rpi3/*
+
+  opi_pc:
+    matches:
+      - kea/opi_pc/*
+
+  rock2:
+    matches:
+      - kea/rock2/*
+
+  pcduino3:
+    matches:
+      - kea/pcduino3/*
+
+  pcduino3_nano:
+    matches:
+      - kea/pcduino3_nano/*
+
+  samus:
+    matches:
+      - kea/samus/*
+
+  nyan-big:
+    matches:
+      - kea/nyan-big/*
+
+  link:
+    matches:
+      - kea/link/*
+
+  jerry:
+    matches:
+      - kea/jerry/*
+
+  minnowmax:
+    matches:
+      - kea/minnowmax/*
+
+  tk1:
+    matches:
+      - kea/tk1/*
+
+  puma:
+    matches:
+      - kea/puma/*
+
+  salmon:
+    matches:
+      - kea/salmon/*
+
+  xu3:
+    matches:
+      - kea/xu3/*
+
+  olimex-a20:
+    matches:
+      - kea/olimex-a20/*
+
+  opi_pc2:
+    matches:
+      - kea/opi_pc2/*
+
+  bpi:
+    matches:
+      - kea/bpi/*
+
+  rpi2:
+    matches:
+      - kea/rpi2/*
+
+  edison:
+    matches:
+      - kea/edison/*
+
+  bob:
+    matches:
+      - kea/bob/*
+
+  lcdk:
+    matches:
+      - kea/lcdk/*
+
+  ff3399:
+    matches:
+      - kea/ff3399/*
+
+  sn9260:
+    matches:
+      - kea/sn9260/*
+
+  coral:
+    matches:
+      - kea/coral/*
+
+  rpi3z:
+    matches:
+      - kea/rpi3z/*
+
+  bbb:
+    matches:
+      - kea/bbb/*
+
+  snow:
+    matches:
+      - kea/snow/*
+
+  kevin:
+    matches:
+      - kea/kevin/*
+
+  pine64:
+    matches:
+      - kea/pine64/*
+
+  c4:
+    matches:
+      - kea/c4/*
+
+  rpi4:
+    matches:
+      - kea/rpi4/*
+
+  rpi0:
+    matches:
+      - kea/rpi0/*
+
+  qemu-x86:
+    matches:
+      - kea/qemu-x86/*
+
+  qemu-x86_64:
+    matches:
+      - kea/qemu-x86_64/*
+
+  qemu_arm:
+    matches:
+      - kea/qemu_arm/*
+
+  play:
+    matches:
+      - kea/play/*
+
+  rpi:
+    matches:
+      - kea/rpi/*
+
+  vf2:
+    matches:
+      - kea/vf2/*
+
+  colibrimx8:
+    matches:
+      - kea/colibrimx8/*
+
+  utilite:
+    matches:
+      - kea/utilite/*
+
+  rockpro64:
+    matches:
+      - kea/rockpro64/*
+
+  rock3a:
+    matches:
+      - kea/rock3a/*
+
+  rock5b:
+    matches:
+      - kea/rock5b/*
+
+  rpi5:
+    matches:
+      - kea/rpi5/*
+
+  zybo:
+    matches:
+      - kea/zybo/*
+
+  zzsoc:
+    matches:
+      - kea/zzsoc/*
-- 
2.43.0

