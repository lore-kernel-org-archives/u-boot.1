Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7998E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 132DE871F3;
	Mon,  2 Oct 2023 03:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cW6kflt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75EE3871B3; Mon,  2 Oct 2023 03:15:45 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2637C87148
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3512fae02ecso43937125ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209298; x=1696814098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WM1qvo9LeyEACs4J6mVN0OpwyJcFcOWB5mXSNpgP+PQ=;
 b=cW6kflt0Hw0r2ZJeEgyib9ZnxvLcwLbb9wpZo6nvG638N1I5muS1KTaDJNCXDle73o
 wcqF4E164KNAw3x0inCVqI9CskhMD+MhjmMRV7EFyK6+rrJwKq4RDc0qgVfgWQlJ62cg
 wJf5OwnARMswZA8J7H24oEMDvCWOcIDWb4FFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209298; x=1696814098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WM1qvo9LeyEACs4J6mVN0OpwyJcFcOWB5mXSNpgP+PQ=;
 b=FtShYffhVVH1pnxsodfO8TtZC9as0hgAs1ntCvqDdTJNbnTc8qewcyfL835RBf2R8+
 P8BxD6+Z4jotHMv17+4FOkSXuwpH3FRQTKC3s58E+KVfNpuTPQhHj/On39VQgF40lFuU
 osSuRrezYIYmsOnmkRU1CtyYQ9RujSzADLGLeK1yx7ElR6VHlI0BOBpCBdZJTlhSHkpG
 t1bldDlIs6yODzsoc1BCaHY1DJTEIqgQEftyiEry4SEvF+ijqkk5W4lVEE9PrUObPefG
 cnQhsYEHwgApbRpWFQV+wlRfGOjI2rsQ9tQJkHDC5nxUTgpaogo6jjiWooAFiKa+/ob+
 2tLw==
X-Gm-Message-State: AOJu0YyGKhqVlNl+rXa+E30J6pz2K2CuAR90EL2ZEeoK/Rhur7e6a0mD
 pH96IXMln+08CbGsvMjHM0ITdl/LNhekAP9oPfM=
X-Google-Smtp-Source: AGHT+IHOPWI4JmjklYQ/N0Avfn61XrqJKvTgY5wEjVxz1mvSdf2/AUv5KzcgaUX2NN9Ql7r02Bg8zA==
X-Received: by 2002:a05:6e02:b29:b0:34c:e16d:6793 with SMTP id
 e9-20020a056e020b2900b0034ce16d6793mr12911794ilu.14.1696209297943; 
 Sun, 01 Oct 2023 18:14:57 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 04/12] x86: coreboot: Add a boot script
Date: Sun,  1 Oct 2023 19:14:39 -0600
Message-ID: <20231001191444.v3.4.I134d949e881ebcd532e927119703b28747fe4c53@changeid>
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

Provide the user with a list of available boot options. Selecting one
causes it to be booted. Pressing <ESC> causes U-Boot to return to the
command-line prompt.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Clear the screen before booting

Changes in v2:
- Add new patch to add a coreboot boot script

 configs/coreboot64_defconfig | 1 +
 configs/coreboot_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 555d281ef3cf..1865f623f6e6 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_MONITOR_BASE=0x01120000
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
+CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index edc38f1f5923..f1728dbfb5c9 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
+CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
-- 
2.42.0.582.g8ccd20d70d-goog

