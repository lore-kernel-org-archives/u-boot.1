Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D5FCAC5A0
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 05:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0838083390;
	Sat, 20 Sep 2025 07:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fQvONCe9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C0083314; Sat, 20 Sep 2025 00:24:31 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07B98206E
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 00:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chalianis1@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4b7997a43ceso29592511cf.1
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758320667; x=1758925467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YPKks8TRO1wcQZGAhFzLpFz9P22SveJ2CXsQNEcIP/M=;
 b=fQvONCe9Z46Q+cpENKtKIoIvXQ48xOofKT1lZ0W6pi4oV91NjNsRqs2bBkzCZ8Ccw+
 /Fa/ZV6QVNZLyyGqPOiBtz5plIDC6O45JqTIxsNrafMVf9UgPDtB0l18WwRUNhY9QzKs
 ZXdQgKGtGIDehHMRCEkCeM/mSuVRRc7oU2NL7buLAe5rYSoHyE61GZHYpdlIO5AOakK6
 gbNZi4Pq6BIFc966z26+K7mFkUXKQ8M9lSx6RsJ3WYrjGY9eIlO0nKBsIIsd/ShCfqMP
 w4Se7ph8FhJqw0PLWe2PPju3+/wXOm4sHss/+qU/vnOvTvKc6eisWN+OgR9RzD+FSQ89
 HJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758320667; x=1758925467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YPKks8TRO1wcQZGAhFzLpFz9P22SveJ2CXsQNEcIP/M=;
 b=ax5c1/uzkas8qFAKzU4Z97QV1sRCg8/n0S7sllL4qMVJN9/NpGWhQuI8WR+XTAMD3t
 YRk1pg4aWXWk1wbI2Ko2EjuyjVmyq8Agbzgw8WKaffPEfZj5+StOnzc+yLneDX+zKt08
 4nQ3DjNS2mtiU0zbemacHG93LHj3GnA3MSEzKsRgsqUd2SRoMMfiYXzBxN1gM+NP37K5
 w/D493uWr/hpeCuLa0ZHhkOLaPmjK7EEVR1DUVAVmmcoBr2ZGCxnktDcrJ2yb4s018O0
 2t0jonpBZtrPdHcyQSk3gtAQ+wE/i2Gy/J/iMUW0qRDJr8nVlBdbbg8iLqXhgmWOMA0v
 5rNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBJ6CQN7o4pNnjr75QswLvqhlzLDuECv9d9Z47q6s4Fl9WUCKsqpsJlqli8d38KxQfEdX1NwU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6kP+nadIMf91T/qZh46iD5emV+LGek56u5euVKhvTjcvcYVvZ
 JgmHXvjrslY3L0l3YC3Ti3RfzM/yd/trzXyRmEAqBPu9ak6z6g/6oToO
X-Gm-Gg: ASbGncvLEhMRtrzN5Q6tLOiU4fCvmVgiGHvS96aJ+uT/UnCyJ1E2d8r+bgAHQZrXWRy
 CzibGX0gIfr3DPsemc2W3x5EZUMFYlcp7b0UXg4xy0PXZGLY68MUp8Q7vGAnPR0WCMoo3LHyY0v
 cHpNqa5fIdYOm30PZP3ieaZFGRzA7gq4fnswlEpVGr8x7eX4O04xmSDVRGYd8WJuzf1PB2h/a+R
 RwQapTA8jTmai2cV5AkmxlSwhNg8N/dTV7hkXZggIcR4+XbyIGS95Lzd9y0wLPDMCWA1kvI8190
 4yOd/wpK9e1UDpKs5CZuwGnG/il4Ef5QY24zovqgxak0BIFfWF7cNqp9EngpbizPKmyWN8gkg2T
 z4a1aF3D9PJthKpZqy9jOqxi3PwCDg/vRTN7IaMJ1aV3k7lT0l6CRh/l4kzIPNtHSXy2dj8cc7N
 swYs0TN3zOZnxLshOfGIEB4mPdLQ==
X-Google-Smtp-Source: AGHT+IHxATTLYBl17FNLcB7hv0a3B+2q9x0FjzMd2EewIXvlYPnfHaGDckgqlUtYrSjmXvwiqrvRRg==
X-Received: by 2002:a05:622a:1a99:b0:4b7:9506:e7b8 with SMTP id
 d75a77b69052e-4c06cbe7d78mr51310451cf.12.1758320667463; 
 Fri, 19 Sep 2025 15:24:27 -0700 (PDT)
Received: from Latitude-7490.ht.home
 ([2607:fa49:8c41:2600:a20e:e252:41bb:cc4b])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda9720984sm34227431cf.42.2025.09.19.15.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 15:24:27 -0700 (PDT)
From: chalianis1@gmail.com
To: raymond.mao@linaro.org
Cc: trini@konsulko.com, patrick.rudolph@9elements.com, u-boot@lists.denx.de,
 Chali Anis <chalianis1@gmail.com>
Subject: [PATCH] arm: mach-qemu: add support for qemu booted from TF-A.
Date: Fri, 19 Sep 2025 18:24:24 -0400
Message-Id: <20250919222424.95815-1-chalianis1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Sep 2025 07:10:46 +0200
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

From: Chali Anis <chalianis1@gmail.com>

add the ability to be booted from Arm Trusted Firmware for qemu aarch64,
to do so we need to skip NOR flash partition setup.
U-boot launched as BL33 from TF-A is supported and Tested on arm64 with
qemu-system-aarch64 and the qemu ARM64 support ARCH_SUPPORT_TFABOOT.

Signed-off-by: Chali Anis <chalianis1@gmail.com>
---
 arch/arm/mach-qemu/Kconfig             | 1 +
 board/emulation/common/qemu_mtdparts.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-qemu/Kconfig b/arch/arm/mach-qemu/Kconfig
index 9c06c6a3a5ce..316dde5145c0 100644
--- a/arch/arm/mach-qemu/Kconfig
+++ b/arch/arm/mach-qemu/Kconfig
@@ -18,6 +18,7 @@ config TARGET_QEMU_ARM_64BIT
 	bool "ARMv8, 64bit"
 	select ARM64
 	select BOARD_LATE_INIT
+	select ARCH_SUPPORT_TFABOOT
 
 config TARGET_QEMU_ARM_SBSA
 	bool "SBSA Reference"
diff --git a/board/emulation/common/qemu_mtdparts.c b/board/emulation/common/qemu_mtdparts.c
index c1501276789c..c3863d3b0479 100644
--- a/board/emulation/common/qemu_mtdparts.c
+++ b/board/emulation/common/qemu_mtdparts.c
@@ -59,6 +59,7 @@ void board_mtdparts_default(const char **mtdids, const char **mtdparts)
 			debug("mtd device = %s\n", dev->name);
 		}
 
+#ifndef CONFIG_TFABOOT
 		mtd = get_mtd_device_nm("nor0");
 		if (!IS_ERR_OR_NULL(mtd)) {
 			mtd_partition = CONFIG_MTDPARTS_NOR0;
@@ -72,6 +73,7 @@ void board_mtdparts_default(const char **mtdids, const char **mtdparts)
 			board_get_mtdparts("nor1", mtd_partition, ids, parts);
 			put_mtd_device(mtd);
 		}
+#endif
 	}
 
 	mtd_initialized = true;
-- 
2.34.1

