Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53E2C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0B1875A7;
	Wed, 29 Nov 2023 18:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cl6cq6AE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C5C586BA8; Wed, 29 Nov 2023 18:52:22 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02345875A7
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7b35d846f36so224789839f.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701280338; x=1701885138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CnyW/Ai1wq6iIg1EHemFFXI/R36avHDlkFUE8MArTuE=;
 b=Cl6cq6AE50io6oHhwm0Ng1mcl+YrSgzSQwiYiM5KnrYTC/wAHzC0FAtudtfT01vXhX
 hA/hg78NcRf1cITSheWh0f37Z5B8yMzLA/d3rWCdNPxkSp9vFrNyXT76wb3NSGpj/PR3
 oSEv9MPJ6vSJSLNr3/R3c2B2Ltq8Y85u2VFBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701280338; x=1701885138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CnyW/Ai1wq6iIg1EHemFFXI/R36avHDlkFUE8MArTuE=;
 b=aiTQyalDiHfoaSOhzBYfbRpf1wdayVTt2h+jq4fmXboLbjwUFlAsE3CIrroje3U6nx
 bWU0GND/B78A/RTYxgwOOxtpj2S6RmjA7fFteJ6tLsHCArgo+CPF7V1tmtvf8SeGbQXp
 DDO6DctSQA2zL/9k5r4MF1vodpwnFAO0oVvm65eJU0nwSTjpnOtBiRVjVdR7OP88wMgy
 zZOuWfcHIvBByNmhNSHwXeDi9va0D5ViEVAku/tyAI1aPIFhd5qXh+rhYAHrBLlUZxwj
 /8QEBPiXD3TVYePKV6i+j4rIEm5mv30zM8u0Kzs7LxwM3TwzSxwv9aC1eeVJLelDeiEL
 /+wg==
X-Gm-Message-State: AOJu0YxxPCG+ntAlBPdBzEcL3hlrYjolOInRw3ExrmlR11EOEnHBhNLR
 3ACieLE1Oq2Ih0qKmPCcStpJk3ySVhUdaIw23XI=
X-Google-Smtp-Source: AGHT+IFTsjSI0RDrCuUsHGmNZHghv92kyf6p0PyHa7RdFaKeISFKuHOrag9AbXrLP4mYjcDdXya0Rg==
X-Received: by 2002:a05:6602:3a15:b0:7b0:b46b:a6e1 with SMTP id
 by21-20020a0566023a1500b007b0b46ba6e1mr19394142iob.10.1701280338297; 
 Wed, 29 Nov 2023 09:52:18 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:f4fd:5056:45a8:b749])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a6bdd13000000b00790b6b9d14bsm50787ioc.49.2023.11.29.09.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 09:52:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Nico Huber <nico.h@gmx.de>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] x86: coreboot: Show a coreboot logo if booted from coreboot
Date: Wed, 29 Nov 2023 10:52:08 -0700
Message-ID: <20231129105207.1.Ia8c2d0b6bfb7953ea8943f41521be911a03fad6d@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
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

U-Boot shows its own logo when starting up, if a display is active. Add
a coreboot logo too, for when U-Boot is booted from coreboot.

Note that the logo's license applies:
https://coreboot.org/Logo#coreboot_Logo_License

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Nico Huber <nico.h@gmx.de>
---

 drivers/video/Kconfig           |  10 ++++++++++
 drivers/video/Makefile          |   2 ++
 drivers/video/coreboot_logo.bmp | Bin 0 -> 5724 bytes
 drivers/video/video-uclass.c    |  18 ++++++++++++++++++
 4 files changed, 30 insertions(+)
 create mode 100644 drivers/video/coreboot_logo.bmp

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6f319ba0d54..f9c289e042c 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -55,6 +55,16 @@ config VIDEO_LOGO
 	  tools/logos/u-boot_logo.bmp and looks best when the display has a
 	  black background.
 
+config VIDEO_LOGO_COREBOOT
+	bool "Show the coreboot logo on the display"
+	depends on VIDEO_LOGO && (SYS_COREBOOT || SANDBOX)
+	default y if SYS_COREBOOT
+	help
+	  This enables showing the coreboot logo on the display when a video
+	  device is probed. It appears at the top right, just below the U-Boot
+	  logo. The appearance of this logo indicates that coreboot provided
+	  the first-stage system setup.
+
 config BACKLIGHT
 	bool "Enable panel backlight uclass support"
 	default y
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index fdc29376324..f7ea7fa7fa0 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -25,6 +25,8 @@ obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
 obj-$(CONFIG_$(SPL_TPL_)SIMPLE_PANEL) += simple_panel.o
 
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.o
+obj-$(CONFIG_VIDEO_LOGO_COREBOOT) += coreboot_logo.o
+
 obj-$(CONFIG_$(SPL_TPL_)BMP) += bmp.o
 
 endif
diff --git a/drivers/video/coreboot_logo.bmp b/drivers/video/coreboot_logo.bmp
new file mode 100644
index 0000000000000000000000000000000000000000..ed74ce1de0b09a6b6a9c0d06d3f435621b82950e
GIT binary patch
literal 5724
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

literal 0
HcmV?d00001

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index f743ed74c81..a0d2627e429 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -508,6 +508,17 @@ void *video_get_u_boot_logo(void)
 	return SPLASH_START(u_boot_logo);
 }
 
+#ifdef CONFIG_VIDEO_LOGO_COREBOOT
+SPLASH_DECL(coreboot_logo);
+
+void *video_get_coreboot_logo(void)
+{
+	return SPLASH_START(coreboot_logo);
+}
+#else
+static inline void *video_get_coreboot_logo(void) { return NULL; }
+#endif
+
 static int show_splash(struct udevice *dev)
 {
 	u8 *data = SPLASH_START(u_boot_logo);
@@ -515,6 +526,13 @@ static int show_splash(struct udevice *dev)
 
 	ret = video_bmp_display(dev, map_to_sysmem(data), -4, 4, true);
 
+	if (IS_ENABLED(CONFIG_VIDEO_LOGO_COREBOOT)) {
+		void *data_cb = video_get_coreboot_logo();
+
+		ret = video_bmp_display(dev, map_to_sysmem(data_cb), -4, 200,
+					true);
+	}
+
 	return 0;
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

