Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2632D1F9DA
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 21:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288CC889C3;
	Tue, 15 Oct 2024 23:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l1WYHQIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D0A889C3; Tue, 15 Oct 2024 23:28:42 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2A6889AA
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5366fd6fdf1so7030806e87.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729027716; x=1729632516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YGWaUSFqH1T1tRUm3mLaEMRrme2AYb0EsKI2spyEVSU=;
 b=l1WYHQIsL7HCVgjdwhgKOehPVa0c0YIjxHKoLFxoIO0jiB806Bpbrt9o7evNHmFIqq
 aFCnJiwsqvHE4FhgxiWW6peEjZ+UoGxcRasL0KZPZfgcP8WMhPvSd095fDcw4d45TOYm
 g0wsnFmC+vdmuRGfhl+QLNFoaSmCEFb+0ID0JXB6SpF49swKkvA0wbkdnlUIFOYNrSdr
 Wv8Q+yeJxdyJMFGhJDZk3YHo92Clx68qzI1Fae0bLy5QgsxCbAAumzk3z3YMIl1xYsm9
 pNkBmji0HAbmTOVP73HbuNHJ/fMieOvFI09EXDqChiJ/+56KU/dybpyJzLw0jDli361+
 kZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729027716; x=1729632516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YGWaUSFqH1T1tRUm3mLaEMRrme2AYb0EsKI2spyEVSU=;
 b=gzG+OltU0c1MNTscBp8OiJ68nVHce5XS+QdRxuz7kwi4BlepwNINWUdoG/ecHcA0Go
 h1AuVcP56oX3JiiZv9oLs0NcDuR9iUvwIaerf+mf+pD2x1XjPiwV4+MEZBhBHpVhTNAN
 JQqDr92a+KqSeXIGKyE9qwssh1cZ9XnKa0hPxgripGosyq4GFJqgXtaQJAyrX2iwcpFf
 gxmJ/qNiI2xZqpCbLB9UmsnqFrI2dluG/qpN/GrCHf9yDIgcUm7Zhb1ax6Nz6RB+WKKo
 XpTe4IcUB6MQY4C9AomUOwCg9D888y4Qr1ZPG8Pq18hq9FHt+TVJfgpWoPgoYih5eS3V
 fPqA==
X-Gm-Message-State: AOJu0YxMmHKpG+/QvNG3dswybL395qJfO7B1Fv6TJr6Q84fBN8nSbUbp
 WX8ETzlfEwD3zw7DOPMQtLte7rGlk7Zr+cKcWbBW/uYSz1vYbUH5CXiHCJ2VvSo=
X-Google-Smtp-Source: AGHT+IGR3Ou27K11dYXiQzlZSskTm3a5rezgIT4NPaBegOmRj/UmoW6a3Fx0p3giaoZNvngL32/36g==
X-Received: by 2002:a05:6512:3a91:b0:539:a353:279c with SMTP id
 2adb3069b0e04-53a03f2d542mr1408525e87.28.1729027716184; 
 Tue, 15 Oct 2024 14:28:36 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539ffff391fsm264734e87.125.2024.10.15.14.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 14:28:35 -0700 (PDT)
From: Alex Shumsky <alexthreed@gmail.com>
To: u-boot@lists.denx.de
Cc: Alex Shumsky <alexthreed@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Marek Vasut <marex@denx.de>, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Janne Grunau <j@jannau.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
Date: Wed, 16 Oct 2024 00:28:31 +0300
Message-Id: <20241015212831.61229-1-alexthreed@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Increase rng-seed size to make Linux happy and initialize rng pool instantly.
Linux 5.19+ requires 32 bytes of entropy to initialize random pool, but u-boot
currently provides only 8 bytes.
Linux 5.18 and probably some versions before it used to require 64 bytes.
Bump min value to 64 bytes to be on a safe side.

Boot with 8 byte rng-seed (Linux 6.11):
    # dmesg | grep crng
    [   12.089286] random: crng init done
Boot with 32 byte rng-seed (Linux 6.11):
    # dmesg | grep crng
    [    0.000000] random: crng init done

Linux source references:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.19#n551
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.18#n236

Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all Rockchip devices")
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Marek Vasut <marex@denx.de>
---

Changes in v5:
- add docs

Changes in v4:
- fix typos and code style

Changes in v3:
- reword warning
- increase default rng_seed_size to support older linux as well
- reword commit message

Changes in v2:
- add env config knob rng_seed_size
- add warning for small rng_seed_size
- 12-character commit SHA in Fixes

 arch/arm/mach-rockchip/board.c | 11 ++++++++++-
 common/Kconfig                 |  3 +++
 doc/usage/environment.rst      |  5 +++++
 include/fdt_support.h          |  3 ++-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 3fadf7e412..ca6404776f 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -472,9 +472,18 @@ __weak int misc_init_r(void)
 __weak int board_rng_seed(struct abuf *buf)
 {
 	struct udevice *dev;
-	size_t len = 0x8;
+	ulong len = env_get_ulong("rng_seed_size", 10, 64);
 	u64 *data;
 
+	if (len < 64) {
+		/*
+		 * rng_seed_size should be at least 32 bytes for Linux 5.19+,
+		 * or 64 for older Linux kernel versions
+		 */
+		log_warning("Value for rng_seed_size too low (%lu) and likely insufficient for the Linux RNG initialization\n",
+			    len);
+	}
+
 	data = malloc(len);
 	if (!data) {
 		printf("Out of memory\n");
diff --git a/common/Kconfig b/common/Kconfig
index 957de0c5c0..c1d06f5045 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -927,6 +927,9 @@ config BOARD_RNG_SEED
 	  new seed for use on subsequent boots, and whether or not the
 	  kernel should account any entropy from the given seed.
 
+	  Default seed size (64 bytes) can be overridden by a decimal environment
+	  variable rng_seed_size.
+
 endmenu
 
 menu "Update support"
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index cc33d3ec0f..253b25a002 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -323,6 +323,11 @@ netretry
     Useful on scripts which control the retry operation
     themselves.
 
+rng_seed_size
+    Size of random value added to device tree-node /chosen/rng-seed.
+    This variable is given as a hexadecimal number.
+    If unset, 64 bytes is used as the default.
+
 silent_linux
     If set then Linux will be told to boot silently, by
     adding 'console=' to its command line. If "yes" it will be
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 741e2360c2..02561eab15 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -202,7 +202,8 @@ int ft_board_setup(void *blob, struct bd_info *bd);
  *
  * This function is called if CONFIG_BOARD_RNG_SEED is set, and must
  * be provided by the board. It should return, via @buf, some suitable
- * seed value to pass to the kernel.
+ * seed value to pass to the kernel. Seed size could be set in a decimal
+ * environment variable rng_seed_size and defaulted to 64 bytes.
  *
  * @param buf         A struct abuf for returning the seed and its size.
  * @return            0 if ok, negative on error.
-- 
2.34.1

