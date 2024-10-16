Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1475D1AD3B
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6109F88FB8;
	Wed, 16 Oct 2024 12:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TO6klCFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422EB88F83; Wed, 16 Oct 2024 12:02:58 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2E0888FAF
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb4ec17f5cso28432791fa.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729072975; x=1729677775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kfe93mcSb8dNciwgSozpIqnaPSSeo6ibiWvkgrRxeoM=;
 b=TO6klCFGRg70urBrqc009pneUhD6VDy+eNftLn/dMd/9v3uocY6N3gCYpNBwq5THD6
 o76fBxXL7sZSYljMzfw+e/DZdWN8oHB9BokBuLYv+wkxJcjiS4CUHpaLXv7sm4BACUWG
 VmcgB0BBAq8x1UCi9NIDmdJlr2C9pnHrxFVaIIwW2m+RK/0FNIxmBkKQRhFTFBq3ckeB
 GOPBfqpEdLbhiqibiIP7IPnCyFqqjIlg4MwFUR48avwLu5R+uE4XXoj3VB7TVz4AvS1O
 EoT76aYkGpgpXLC2T9imrYDJMXPc1pEZ7pqe2YoloiCRsTVa4bPO9zUaX5ntUmRRpXHJ
 RBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729072975; x=1729677775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kfe93mcSb8dNciwgSozpIqnaPSSeo6ibiWvkgrRxeoM=;
 b=WMM2s8Up8afNqkagZK5a3igRnyGtqnrQKrlY2Uy/8ZgBGgmk792lI6nCHmDKCduOVU
 c8G9SQa3TSyRz2zyX+6ktKIvmwqA+hujvXEBni40CgWAdvoaHJEd6vTISwe+hVRXbYTA
 RuwCxt2VlSLly1b7V5rxfql6K8NscgmEiagsVPxjYQx7PIxnPXHgAOxbwv9T7avbYA+F
 bEYfWiUlkMXqLW6jH6W0CNbDgtR6LoegQfA1kRm0w+0COOUoZ9ZX58SHm9AhLJZqnFbK
 L3NN66EehPy2DCytYThDLJQMAFAf7PK5/YqCAG7V0mEBpLjaE+K/qklBhCYiOR0xF07x
 81Jg==
X-Gm-Message-State: AOJu0YxCBeGgLnr3KnU2Bn32cCMMN093fBVPL9V2DbGvaLezaFayW9Mj
 hJ4Kc7HULRBtz30LbXzzo5esUaW745MjUVZSj8YfuuxxhJkIiT8P/An69F9DVyk=
X-Google-Smtp-Source: AGHT+IHqSny+i+rt+AVJRWEqrPmWn1k1C3q0/C0go+Cy09rSKQKO6/SRll6/rYpodc7ZkmOqIh/U7w==
X-Received: by 2002:a05:651c:1508:b0:2fb:58b1:3731 with SMTP id
 38308e7fff4ca-2fb58b1390emr44447181fa.6.1729072974339; 
 Wed, 16 Oct 2024 03:02:54 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fb5d194029sm3798051fa.81.2024.10.16.03.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:02:52 -0700 (PDT)
From: Alex Shumsky <alexthreed@gmail.com>
To: u-boot@lists.denx.de
Cc: Alex Shumsky <alexthreed@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Marek Vasut <marex@denx.de>, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neal Gompa <neal@gompa.dev>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
Date: Wed, 16 Oct 2024 13:02:03 +0300
Message-Id: <20241016100203.629713-1-alexthreed@gmail.com>
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

Changes in v6:
- fix wording in docs and debug message

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
index 3fadf7e412..75d6693e28 100644
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
+		log_warning("Value for rng_seed_size (%lu) too low, Linux kernel RNG may fail to initialize early\n",
+			    len);
+	}
+
 	data = malloc(len);
 	if (!data) {
 		printf("Out of memory\n");
diff --git a/common/Kconfig b/common/Kconfig
index 957de0c5c0..8098f90683 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -927,6 +927,9 @@ config BOARD_RNG_SEED
 	  new seed for use on subsequent boots, and whether or not the
 	  kernel should account any entropy from the given seed.
 
+	  Default seed size (64 bytes) can be overridden by a decimal
+	  environment variable rng_seed_size.
+
 endmenu
 
 menu "Update support"
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index cc33d3ec0f..7bd9ffce8d 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -323,6 +323,11 @@ netretry
     Useful on scripts which control the retry operation
     themselves.
 
+rng_seed_size
+    Size of random value added to device-tree node /chosen/rng-seed.
+    This variable is given as a decimal number.
+    If unset, 64 bytes is used as the default.
+
 silent_linux
     If set then Linux will be told to boot silently, by
     adding 'console=' to its command line. If "yes" it will be
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 741e2360c2..9447a64e06 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -202,7 +202,8 @@ int ft_board_setup(void *blob, struct bd_info *bd);
  *
  * This function is called if CONFIG_BOARD_RNG_SEED is set, and must
  * be provided by the board. It should return, via @buf, some suitable
- * seed value to pass to the kernel.
+ * seed value to pass to the kernel. Seed size could be set in a decimal
+ * environment variable rng_seed_size and it defaults to 64 bytes.
  *
  * @param buf         A struct abuf for returning the seed and its size.
  * @return            0 if ok, negative on error.
-- 
2.34.1

