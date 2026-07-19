Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8D3C4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1814784AC7;
	Sun, 19 Jul 2026 20:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="PjUVysWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A7284A52; Sun, 19 Jul 2026 20:04:20 +0200 (CEST)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485FF84A4B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asrinivasan@tenstorrent.com
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-664db84f074so12614147d50.0
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784484257; x=1785089057; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=71SBDUsUN4idrFN21FPN2tmRq/w2xAijyagzX4n72wg=;
 b=PjUVysWCgljcdKMH+TPHbwafSai7euQ1KJDzfT5axD5/S+Xt6zH0wJUoC5XyyvGjiw
 H/SevckdI3M1QxjltXTcH3vNXxXKMEuib8IoeknOWAianAOKfZ13+JU6Vk+fJ2ZXkeR1
 1WQIdQLRL3dxgsUZ5uhlZSsHzGPwsU8lyb0rViiuU81OZFmVB7MRADmV4HGQovDh7pX2
 fGXtROROq9tQ3/8W/2w5AXEeAUEy97zFeC3ospqACEWsb4NuxIJeiIBs72wfqJ1qBAZv
 YjBhEeJq6pUTaadr8HN8SmXAsAXo1Hkx4H/3SV+MZXjfZrMqdTWmqN5Rx2XFUziFHftS
 zPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484257; x=1785089057;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=71SBDUsUN4idrFN21FPN2tmRq/w2xAijyagzX4n72wg=;
 b=I83+OcWbRo4JkhTsVudIF70m1GR+7QEUQeVOZMR3M4uYQhbWz8BWH2kvddNVKhrsQt
 Z56xuhHiAKJkOt5ffqj+WOt46hnfU1diYe5lRh63QiJZYlsMsEHrQwrIB/jecu2BlAXg
 fCwVbWElk0NcA0E+zoTY05Tt37+nZwm2AmuoIgfBElw1NS9uWBAS4+5+NZCoBuv2n3w/
 HrDBpAY2WYxV8Phv+2YGNmMKMjspgQuohFJBdMo2c0UgJMFnFBTVaAL+dAFyskRpF+W6
 /v5pOXKYAbQD7FmMZcCHA9KzijLArLLTANN+Ql1gfXWEQlJ4kAeHQYvLAOyED8xutiiN
 elMg==
X-Gm-Message-State: AOJu0YxUWtQ2Y2nXesh8rTCza6eEFf4i3G9M3Wzx5c9nVuSM5rY5D2wo
 k/46ajIKHMaH+VuTn8pSlrQqAr67dYawMzKU610UXX7MBVuRQmxu8kkrE9LuxETJt9U=
X-Gm-Gg: AfdE7ckGfI8hXFkESEdeXgOXTc5jOqhN16X9EhzXLDR0Mb3wLFxP2/J8GLw3krg8kjK
 qcrVumYaZ6qDpphMlU+uBZ/zSWF7s+r064yWhsNPRdiDhjNP/snIKFJ9xrSfLB69hfkc3wu6mBr
 RNWMga63eKDHpZm2kHIEtAXqGmb+h5rxmpDVKmYU9mRQYUH2WcS8kX8g8CyaQfdteeLnLtF7/fv
 clMTTUz3A860P3+hG0tSJgNDDWuTZgDG3XObHzSmWrIGlXYtsHhroebNU3/o+Agw6GbqWF4qzIX
 zH9HYoPpAPuM0AiDKjRbKtdtEw4RkZVyYhBCMFOHUrZ+g59EyaM5zB9FtslgK6Mxm3pb3MikVBH
 7c5ro4xh+du9uwR/3GE+JSRBdmuTzpJtGNo30y3rdVHkWRi+5TYkwnYHK4Cr/uR01oPqSde3E4C
 LWxWN33hTJbYyG8ooJovSRwd/xx4Ha04q3Hynt+5vp5pDpnRjel8y8+A==
X-Received: by 2002:a53:dc85:0:b0:664:ae6b:b498 with SMTP id
 956f58d0204a3-6683bdfca8amr2376032d50.77.1784484257088; 
 Sun, 19 Jul 2026 11:04:17 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:423:c42:416:fc31])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6683b513a3esm4879882d50.2.2026.07.19.11.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:04:16 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sun, 19 Jul 2026 13:03:39 -0500
Subject: [PATCH NOT-FOR-UPSTREAM 8/8] Enable biosemu and vesa video output
 in qemu riscv64 virt machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-aspeed_vbios_fixes-v1-8-c94026f28250@oss.tenstorrent.com>
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sun, 19 Jul 2026 20:36:10 +0200
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

Enable Kconfig/defconfig options for vga video output with vbios
emulation to work in the qemu riscv64 machine.

This was a patch I added just to test this feature.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 arch/riscv/Kconfig                   | 1 +
 configs/qemu-riscv64_smode_defconfig | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ad7589123c6..6166a55974c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -38,6 +38,7 @@ config TARGET_OPENPITON_RISCV64
 config TARGET_QEMU_VIRT
 	bool "Support QEMU Virt & RVVM Boards"
 	select BOARD_LATE_INIT
+	select BIOSEMU
 
 config TARGET_SIFIVE_UNLEASHED
 	bool "Support SiFive Unleashed Board"
diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
index 2ef67d40269..9e1419c3df8 100644
--- a/configs/qemu-riscv64_smode_defconfig
+++ b/configs/qemu-riscv64_smode_defconfig
@@ -21,6 +21,12 @@ CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_SPAWN=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
+CONFIG_VIDEO_ASPEED_VGA=y
+CONFIG_VIDEO_VESA=y
+CONFIG_VIDEO_PCI_DEFAULT_FB_SIZE=0x1000000
+CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
+CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
+CONFIG_FRAMEBUFFER_VESA_MODE=0x122
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
 CONFIG_UTHREAD=y

-- 
2.43.0

