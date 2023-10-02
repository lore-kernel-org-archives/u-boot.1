Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F90DE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B65087208;
	Mon,  2 Oct 2023 03:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JxlWXbEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5142887149; Mon,  2 Oct 2023 03:15:55 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C80B787154
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ae35773a04so7891724b6e.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209304; x=1696814104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFgLqAVswDSVlO/Fz2gAu84ox3z11iFF4w7Z+FcpRIs=;
 b=JxlWXbEfH+AeLS7EYXmFnzPXQkwyEwjJ6t5tk/QKgxoR2KqnupR3afm/FI0y4f3DmA
 cfp8VpDy3yt/b+I63+yWROxdvuiOft30QWgd47Z5G88QHjDPcTjsz/89aH4VkKCcU2D1
 GvzRn0F/T4wcDYMVJhVlUmQDUOZ13Q3HVXiWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209304; x=1696814104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFgLqAVswDSVlO/Fz2gAu84ox3z11iFF4w7Z+FcpRIs=;
 b=Ih4E+2RxcShZUBd87zzMmV1CaOCfFzsrMNuOF1kPHYZrTIiBmn65U16KD7UYT3jO4+
 cJckznGDzSVbsepM+DXQIFiiVVg8VIkZ6Ny5guO1j0heG/OHtHvnFeNAiowe88ZxP4Cm
 UltDTxOU76PsHwvCg+l6copNArcimpUUNIfE0CDFXvTAra1HqWEv5Bgnrx10M5ZQMMfW
 DbqbrDo5Sq1ALFTgz7V1okfTw3rEZQvP7Zz38uFkR7z/PGqQ0mey7rmMEDtkadnQn4I7
 zGCE9dpUzbHFeGeZ660UjYdjJXQm4Wa/6DTyh+uIJQsCG+GpZ+8Ki8YobLjvYT+KIlCP
 zNyw==
X-Gm-Message-State: AOJu0YytwiSXcGuP/PscksS6/i79Kwb6jQBrtAi3ezWZD1Y+KB9RpUiD
 uusBFi47ujb8MfjN0IxUy0bHCHXqGsGfcb3u7C4=
X-Google-Smtp-Source: AGHT+IEAmOdVIprVH8/rqxFh6MrzuFOlbXY7i4kt7LnsfbpKYy2Y6QGGEqVnqARo3rBcduVyty4WGA==
X-Received: by 2002:a05:6808:3bb:b0:3ad:29a4:f560 with SMTP id
 n27-20020a05680803bb00b003ad29a4f560mr10634546oie.34.1696209304384; 
 Sun, 01 Oct 2023 18:15:04 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:15:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 10/12] x86: coreboot: Enable truetype fonts
Date: Sun,  1 Oct 2023 19:14:45 -0600
Message-ID: <20231002011450.462468-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011450.462468-1-sjg@chromium.org>
References: <20231002011450.462468-1-sjg@chromium.org>
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

Truetype fonts look better in the menu, so enable them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to enable truetype fonts in coreboot

 arch/x86/dts/coreboot.dts    | 10 ++++++++++
 configs/coreboot64_defconfig |  3 ++-
 configs/coreboot_defconfig   |  3 ++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/dts/coreboot.dts b/arch/x86/dts/coreboot.dts
index 0eb31cae42c1..83beb82f37c7 100644
--- a/arch/x86/dts/coreboot.dts
+++ b/arch/x86/dts/coreboot.dts
@@ -45,4 +45,14 @@
 		bootph-some-ram;
 		compatible = "coreboot-fb";
 	};
+
+	bootstd {
+		compatible = "u-boot,boot-std";
+
+		theme {
+			font-size = <30>;
+			menu-inset = <3>;
+			menuitem-gap-y = <1>;
+		};
+	};
 };
diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 1865f623f6e6..42b46ba0d9b9 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -9,11 +9,11 @@ CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_X86_RUN_64BIT=y
 CONFIG_VENDOR_COREBOOT=y
 CONFIG_TARGET_COREBOOT=y
+CONFIG_SYS_MONITOR_BASE=0x01120000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_DEFAULTS=y
-CONFIG_SYS_MONITOR_BASE=0x01120000
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
@@ -61,6 +61,7 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_VIDEO_COPY=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_ACPI=y
 CONFIG_CMD_DHRYSTONE=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index f1728dbfb5c9..7d744e9962ae 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -7,11 +7,11 @@ CONFIG_DEFAULT_DEVICE_TREE="coreboot"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_VENDOR_COREBOOT=y
 CONFIG_TARGET_COREBOOT=y
+CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_DEFAULTS=y
-CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
@@ -55,6 +55,7 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_VIDEO_COPY=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
-- 
2.42.0.582.g8ccd20d70d-goog

