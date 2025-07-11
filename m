Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473B3C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 18:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6063882B07;
	Fri, 11 Jul 2025 20:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FcIRm4W+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EA8082CFA; Fri, 11 Jul 2025 20:55:18 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D450E82998
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 20:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c14138668so928468a34.2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752260114; x=1752864914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FZy3bq9SBbXFapaxwzrWDjX6twKTAYTF720YLpibbGQ=;
 b=FcIRm4W+WHtA6gu7V7fo1Xji8QoaxmFRhWSz5YfkmG02d95hCwIFiHFB/S4HkmttHl
 pnsUyiPZONQTwkhEUnspn5nf9vKUZ0UCita6jy9K1Hbn/zH5pjOu2afHftraz9JmgmN6
 Rff3LNwIwSklnUKhqmL8k3m8Fpfbub0zjcoUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752260114; x=1752864914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FZy3bq9SBbXFapaxwzrWDjX6twKTAYTF720YLpibbGQ=;
 b=wtjRc93LZXCrExn2H0DTkMq2oavnn7NIFccNUgNh/HQC8CMsBorxg3fJN9R/Bh0m6t
 SGLtv1xgUs963b9KJHpHer7UYsk6Rdl1Zd9ri8besHZuvgrb2hx1OXMDUf4hWaEVjlat
 3asd8FvmjEQp635u0oZnmR+2wE7SpYi5xCESgAOrzhPnzHEW2D41azqZl3/0qhBnOyP6
 3Q5h9ByupLt9TLbTPknRTg42dgUrD/BHfgRD0VpRcIE3XRMUAT0LmI3WZbSIXc2S4OCH
 S5D1ObwN5rv8qZKM3NK64WjiUyZiuxcYWiYBQVoElyM4XFoiTiqPlevgtAp8k1nVKC6O
 n7KQ==
X-Gm-Message-State: AOJu0Yy6esDVlNxgEHZwLxp3ET0l1rloT06m/aCdylocExYm5zkVnpH/
 Pxmr0LUEg0OJ9riCiY3fNA9Gb7LR1BMEt9LwWTcF/HqfyUIvQTkbQUVzFfmjhY8LpS3lAbiAJUB
 D/WAc7w4=
X-Gm-Gg: ASbGncuJmvGElFfT0Ro7TDTHWbLUc/klZDz3ZC74/OLK/VJOqD+WtuGqkEWHN6o++L9
 f2R2TcH2eDqiXlYg9gOQ8RldFR1KFw4ZjwXOZ9NYPpC3Z5QZb5gcRS0W8VvM0sNZHcCal6uIDnW
 IGlNcoPolMz1SXMHrLWiNiaV1h/8oaNifeA6fWSQZWvsYh2SpjL+tEUoM8bxgrD6mws57dimT38
 T9cHGy09RybthcgZOqyNcUb5ofMe1PqnJOIffwaq3T9OiZKeW3TTPvH7Cn+rcOerKqYhu2FHGOg
 rA72emm40VGdmrAGwPHZAEs7b2Orfku3xaShTIpK3M/vjELOSwrEIapct5x4b/IrBEZNHEj9wYU
 kd9+AyrTm+9mKy+7b1CbvhHQnp+xIHFfLw9d0mHGPjaFE2U1HGo9/TSpdKUw=
X-Google-Smtp-Source: AGHT+IHjtS1YiESgi/QLqTRUYOLoVdMjNZC9YtUl8NmOaheGpaIWtxoiJ8FOpn9lqHMXHGIi9DYG7Q==
X-Received: by 2002:a05:6808:300f:b0:406:7054:f7c0 with SMTP id
 5614622812f47-415122032b1mr2770499b6e.36.1752260114467; 
 Fri, 11 Jul 2025 11:55:14 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414197c2812sm632590b6e.18.2025.07.11.11.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 11:55:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Josef Holzmayr <josef.holzmayr@northern.tech>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] vexpress_ca9x4: Disable EFI_LOADER on this platform
Date: Fri, 11 Jul 2025 12:55:12 -0600
Message-ID: <20250711185512.2250368-1-trini@konsulko.com>
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

As part of upgrading to QEMU 10.0.0 we discovered that the EFI loader
tests would no longer pass CI, on this specific platform, while still
passing on real hardware. Upon further investigation it turns out that
on ARMv7 we rely on some undefined behavior with respect to enabling
unaligned access. And while this is seemingly fine on real hardware,
QEMU is now correct enough in implementation to no longer allow this. In
order to not rely on this undefined behavior we would need to implement
some MMU configuration (and then ensure proper tear-down possibly).

At the moment, the most reasonable path forward seems to be to document
this and disable the support here.

Link: https://gitlab.com/qemu-project/qemu/-/issues/2944
Signed-off-by: Tom Rini <trini@konsulko.com>
---
I believe at one point Norther was using this platform, in QEMU, for a
reference platform via EFI for using Mender. As such, this would likely
make this platform not useful anymore. I believe Ilias can better
explain what needs to be done to fix this properly but there's no one
with the available time to take care of this in the community at large,
and this is part of what's blocking updating QEMU to a newer version
that provides other platform and feature support we do want to use.
Alternatively, we could just let this platform go and remove it, if that
path makes more sense.

Cc: Josef Holzmayr <josef.holzmayr@northern.tech>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 configs/vexpress_ca9x4_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/vexpress_ca9x4_defconfig b/configs/vexpress_ca9x4_defconfig
index 67adba437bfc..6ebb37fcf2ec 100644
--- a/configs/vexpress_ca9x4_defconfig
+++ b/configs/vexpress_ca9x4_defconfig
@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="vexpress-v2p-ca9"
 CONFIG_SYS_LOAD_ADDR=0x90000000
 CONFIG_ENV_ADDR=0x47F80000
 CONFIG_SYS_MONITOR_BASE=0x40000000
+# CONFIG_EFI_LOADER is not set
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run bootflash"
 CONFIG_DEFAULT_FDT_FILE="vexpress-v2p-ca9.dtb"
@@ -20,6 +21,7 @@ CONFIG_SYS_CBSIZE=512
 CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_LAST_STAGE_INIT=y
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_XIMG is not set
@@ -55,4 +57,6 @@ CONFIG_SMC911X=y
 CONFIG_SMC911X_32_BIT=y
 CONFIG_BAUDRATE=38400
 CONFIG_DM_SERIAL=y
+CONFIG_FAT_WRITE=y
+CONFIG_FAT_RENAME=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
-- 
2.43.0

