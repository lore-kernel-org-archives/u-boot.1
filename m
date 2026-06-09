Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D590ACD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 16:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C0B848E2;
	Tue,  9 Jun 2026 18:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="f0a1Q2Bu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21228846D3; Tue,  9 Jun 2026 18:52:42 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E289848DC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 18:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490be03d47bso50237425e9.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1781023959; x=1781628759; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WTpnI26XLFFPgDYvaywE99NyzKHp+SELgRXLuWEZX0I=;
 b=f0a1Q2Buu/iVq4P4cnuSlYle+hQFYP5QEfbn8mo+VGSL8IvowKwZW8kdMyVQiX38cz
 Yc1sh3zPtFkGaIP/O08uXtUQC2+DWh/LbMFG+/BoTck6socK1XLI7Rza8EXmIaegTodS
 5VW4gAG3xPqsfIPKCwUBN4VElNuruLsrsrG7vTszGNtFwGUvRHsL3a6zf49xYIa+fx4q
 CtXbBTU1wN55DLXuhv2bwl5ZeVkQqzWrRHhhCo04L92+iH5CTwK/Zayhpp4LI7rrGunL
 VVSt5foZ0lQAPk5hWouMOWxXvruU/+0oO3amJRBZIKaFeE+LZmWjxyWiIMQCv0/Lq0ne
 hnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781023959; x=1781628759;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WTpnI26XLFFPgDYvaywE99NyzKHp+SELgRXLuWEZX0I=;
 b=LrDSoCuF/N2FvA21B2JC87oqUWxtpW+BC03hZxksyBEnn3sigHz/z/VbGgBoxgOEHR
 1Up0N4dAI8ZE9z0H8iKD9jEe2sRcOCoLvNTjix/wphMLrwNmI7m2N+SRJU9e1ZZJcyFO
 fZotP3yvRgQKRclObBMvLhlCAPMXGhZYNthLWWlSkEOOvpThoyxcW4sltMXv98K7+Hlt
 KSy2ZVS9T4nNQi/L7VWgczrVhAAPQHnTLpeKBawBVk4JUsaZ9b+AwhnNZe/gV9MKbfFJ
 bLM3pwzR/jm7Tm9ec6D7YyQWY004s1cV7Wy18toP7oNj8qN/VpawmuUFfpkOwNGZFT0q
 FYSw==
X-Gm-Message-State: AOJu0YxC8URhoDFmjrjbgHhLRpAYX6o3Qz+SUft902m6wqxWX08LY63a
 nvHIwPoxkEi2r1guH3rq9l5tpG80epQ/p5qk1yyTZs/gaz7MR21BZsJg7bBI5VIhhvA=
X-Gm-Gg: Acq92OGKjTTvCIp7rN5oqlxTTx683xzWrSbrFbfLbFWxvbeNHMH2NwGadnyrmnwzj92
 UA+zhiGnkmWzJYIYZxLerTvmxU0ZE+arFrg/j9Gd//ZFDg47Hchf92c4jT8oLCxvJTP04Y+rGWs
 cZ1qeXIeoqiGrF/RVTaPJZ05BnTFlUJXiWkL9qjP/tng2mPXYOaQ2Vxyzt9+kO8hukT1SWp3eJm
 VuRDOJF7nnhHuz1NlKMQGYpgdVMmwiOhHWvlHvNsq+V0FSnD/G+wqcQBEskuokVd8E/1l6Pj1fW
 MlBJxv73ezsK/LuTXnHzIbeyjBWnBD3nVVQ91mAY5IULfhm4PBARKW0zDgj1iXvSDN4G9q44FuD
 7q7bJ0kPIBsiZWPn12hXBvnH1xUA562xCmVBiCDO3yPTeR6v8JCautZvMu0D6uVm0BYTy9pIikM
 ZqEalehUPtgcY/DHWXvk8lESoxLq+9+1yyS5XU4DIqh9bGukFYwxA=
X-Received: by 2002:a05:600c:1c20:b0:490:6237:5200 with SMTP id
 5b1f17b1804b1-490c259eaccmr324710915e9.10.1781023959457; 
 Tue, 09 Jun 2026 09:52:39 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3b5b06sm450121115e9.3.2026.06.09.09.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 09:52:39 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 09 Jun 2026 20:52:25 +0400
Subject: [PATCH 2/4] spl: ufs: add Falcon mode load path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-atf-falcon-v1-2-2b20c5e83615@flipper.net>
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
In-Reply-To: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4691; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Fey6dgpj2K1zS1xqUgzUdtRW+kUWEQ+FVQOV2zP1qC4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRpuJyxCdvfZW9n3BV5TCztsKC3B0v1j/fNz5je+pu2z
 f0emR3aMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFQ/5mT4p1g55/ecws3zC5xWLTFS/3u7NMiC4Xxr+G1n5bM7rCSuajH8rzuwL1b
 ULjz80IE0pnX6MmKnWPYFediq8hp/kolSSjTnAgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

In Falcon mode, the SPL loads a FIT image containing a Linux kernel
instead of U-boot proper, and it may need to fall back to loading U-boot
if Linux is unavailable.

Add support for images containing a Linux kernel, optionally on a
different UFS LUN and/or offset vs. U-boot proper to enable fallback.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/Kconfig   | 18 +++++++++++++++++
 common/spl/spl_ufs.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index cc819344cad2..2ce48eb981d2 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1635,6 +1635,16 @@ config SPL_UFS_RAW_U_BOOT_DEVNUM
 	  SCSI device number, which might differ from the UFS LUN if you have
 	  multiple SCSI devices attached and recognized by the SPL.
 
+config SPL_UFS_RAW_OS_DEVNUM
+	int "Falcon mode: SCSI device number of the UFS device to load OS from"
+	depends on SPL_UFS_SUPPORT && SPL_OS_BOOT
+	default SPL_UFS_RAW_U_BOOT_DEVNUM
+	help
+	  UFS devices are usually configured with multiple LUNs, which present
+	  themselves as sequentially numbered SCSI devices. This option controls
+	  which of them SPL will attempt to load a Falcon OS payload from.
+	  It allows putting Linux FITs on a different UFS LU than U-Boot.
+
 config SPL_UFS_RAW_U_BOOT_SECTOR
 	hex "Address on the UFS to load U-Boot from"
 	depends on SPL_UFS_SUPPORT
@@ -1643,6 +1653,14 @@ config SPL_UFS_RAW_U_BOOT_SECTOR
 	  Address on the block device to load U-Boot from.
 	  Units: UFS sectors (1 sector = 4096 bytes).
 
+config SPL_UFS_RAW_OS_SECTOR
+	hex "Falcon mode: address on the UFS to load OS image from"
+	depends on SPL_UFS_SUPPORT && SPL_OS_BOOT
+	default SPL_UFS_RAW_U_BOOT_SECTOR
+	help
+	  Address on the block device to load a Falcon OS FIT/image from.
+	  Units: UFS sectors (1 sector = 4096 bytes).
+
 config SPL_WATCHDOG
 	bool "Support watchdog drivers"
 	imply SPL_WDT if !HW_WATCHDOG
diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
index cef1843f40f3..5c7ec869ab0c 100644
--- a/common/spl/spl_ufs.c
+++ b/common/spl/spl_ufs.c
@@ -20,13 +20,37 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
 	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
 }
 
+static int spl_ufs_load_image_raw_os(struct spl_image_info *spl_image,
+				     struct spl_boot_device *bootdev,
+				     struct spl_load_info *load,
+				     struct blk_desc *bd)
+{
+	ulong sector = config_opt_enabled(CONFIG_SPL_OS_BOOT,
+					  CONFIG_SPL_UFS_RAW_OS_SECTOR, 0);
+	int err;
+
+	err = spl_load(spl_image, bootdev, load, 0,
+		       sector << bd->log2blksz);
+	if (err)
+		return err;
+
+	if (spl_image->os != IH_OS_LINUX && spl_image->os != IH_OS_TEE &&
+	    spl_image->os != IH_OS_ARM_TRUSTED_FIRMWARE) {
+		puts("Expected OS image is not found\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 static int spl_ufs_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
 	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
 	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
-	struct spl_load_info load;
-	struct blk_desc *bd;
+	int os_devnum;
+	struct spl_load_info load, os_load;
+	struct blk_desc *bd, *os_bd;
 	int err;
 
 	/* try to recognize storage devices immediately */
@@ -36,6 +60,35 @@ static int spl_ufs_load_image(struct spl_image_info *spl_image,
 		return -ENODEV;
 
 	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
+	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && !spl_start_uboot()) {
+		os_devnum = config_opt_enabled(CONFIG_SPL_OS_BOOT,
+					       CONFIG_SPL_UFS_RAW_OS_DEVNUM,
+					       CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM);
+		if (os_devnum == devnum) {
+			os_bd = bd;
+			os_load = load;
+		} else {
+			os_bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, os_devnum);
+			if (!os_bd) {
+				puts("spl_ufs_load_image: UFS OS device not found\n");
+				if (IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE))
+					return -ENODEV;
+				goto load_uboot;
+			}
+			spl_load_init(&os_load, spl_ufs_load_read, os_bd, os_bd->blksz);
+		}
+
+		err = spl_ufs_load_image_raw_os(spl_image, bootdev, &os_load, os_bd);
+		if (!err)
+			return 0;
+
+		puts("spl_ufs_load_image: Failed to load falcon payload\n");
+		log_debug("(error=%d)\n", err);
+		if (IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE))
+			return err;
+	}
+
+load_uboot:
 	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
 	if (err) {
 		puts("spl_ufs_load_image: ufs block read error\n");

-- 
2.53.0

