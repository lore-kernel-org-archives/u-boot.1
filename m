Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECF1C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8DAD839B1;
	Sun, 18 Jan 2026 14:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DaFY6V2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0DF8833C6; Sat, 17 Jan 2026 20:04:40 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80A582BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-5013d163e2fso33678821cf.0
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768676677; x=1769281477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYGCxea15VhkkXktpl9WRsG8WUBvnJe4DRP480Ld9uM=;
 b=DaFY6V2G2Ly7K7Ua2us7rqyVdYJsEmYsENn+qigJzU795JSViJggi+t5Oas3M7eOxl
 1/vTjwLaJ5O0AXaqCsVPVVQbrTDARBqpN5hFw3yMo6uPxujq6J5+lkhyUrKzo8QRJw+2
 /IRa4wuCOR2/qZbeBWfitAOZiqYmcODS7i+mBE7BxRF2WfqQaj++642aGWiszWovI5RK
 Unzh1/5+Fk+19rwhJeoFX2C7ts4KMAEeu/aPR3DmpgfIl9dH3CKSewEY84H5B7dWZvMx
 Dc+nbLwABBjEI597/5d1JTi5EEDmzkDCvdkK4a3eMYUnUHEwIm4dX1fB1nZmAQiKZOpv
 d/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768676677; x=1769281477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sYGCxea15VhkkXktpl9WRsG8WUBvnJe4DRP480Ld9uM=;
 b=lD+95LqWe0iDYjypiGT//zzZwii3F3akscy9PJTEvoy5yYKHhYn6liZo29hUiL5h4X
 r6OV5S2QxJ/qE2Z1aLdipEs7LUeROYIGUUt/q9K3XNvV4nTdrid7LMPxmLw9mzWHMXXE
 xCE0XCpSRPYncy67ulKCnD8Zd5JELLUhnOsIP4n9UpcElg7tFVLBuIe+fkgYvDn5ROcy
 Kjuy4iJ9ns02U+ZeT3vG4a6Igmi3zSzhGdegmwQiQI5HM5Om+IKkvdHha7U/wgS6g+vR
 CJ91QVgFm0JPAr1VgdrXetlxpw5NqiotpfkXbihrAS6fTAFC10SjCZ8OLJYmtn2BKtY+
 FfyQ==
X-Gm-Message-State: AOJu0Yxot6mzUFBGZb6T10bx0/Uajb4lebLFxMzZnyt2kDau65wuF/j2
 qwmHwUzdoG2XkburqDIxyVrxWjlNJ0deL5QIRwppvliCTvjjC79UBt+5PfnmtA==
X-Gm-Gg: AY/fxX5reuebRWObdeYhem+T2w8DucMgVeyzOf2X5kNajX27KE3WQdaHoIzR+Q+FKZ+
 76sNUz0X3LGfEP1aSsC78sZ2SMUxg4f2SHM9h8j7JUrdX6mF0QdWDiID3nCVspb6PWovhksr1uK
 DhbRm5ANCak1fwaV7Chkw1cUKFhVY0FCBcBeJ/s5hilD3Q/EXVY7kK49YkRyPfs6LNJvrvJqIzx
 Kc2NYiRfvib6JSIpCu4nOVOCvxGEfRX62057kEpkMJp8OZ+1dq1aZeSqqY15d+XlHwJxDZM2fpf
 YGD1xKrAkCkg1FRhdLqcOtV+pf2kVvV72aUaLzqWYVRXwyrV/s78pf3j/OddqFD0pxT8YGF8d1p
 PvVe2iYqLxcoGrkf9xhnlCQprJDdw3Kqo2BuLItZ6cu/UufAC9W//TmRJyk5Ll/FOU5CKtbwrxR
 p7PUldOm5jVJziP7vGiel+k1y7tBydblbWvOJitD+zWfxiiI9o1/gWp6YDmVt8TjI81ibcxXI=
X-Received: by 2002:a05:622a:1a9b:b0:501:5162:a9c with SMTP id
 d75a77b69052e-502a1f3289dmr98875951cf.57.1768676677301; 
 Sat, 17 Jan 2026 11:04:37 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:04:36 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@gentoo.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, Aniket Limaye <a-limaye@ti.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Samuel Holland <samuel@sholland.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH 03/17] configs: k1: enable early timer support
Date: Sat, 17 Jan 2026 14:01:37 -0500
Message-Id: <20260117190231.977686-4-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

From: Raymond Mao <raymond.mao@riscstar.com>

Enable CONFIG_TIMER_EARLY to allow udelay() calls during
early initialization phases. This is required for proper
timing operations before the full timer driver is available.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 configs/k1_defconfig | 2 ++
 include/configs/k1.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/configs/k1_defconfig b/configs/k1_defconfig
index f1a16735943..ca9c1d0bd8d 100644
--- a/configs/k1_defconfig
+++ b/configs/k1_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_RISCV_SMODE=y
 CONFIG_ARCH_K1=y
 CONFIG_TARGET_BANANAPI_F3=y
 CONFIG_FIT=y
@@ -42,3 +43,4 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_DEBUG_UART_NS16550=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 # CONFIG_DEBUG_SBI_CONSOLE is not set
+CONFIG_TIMER_EARLY=y
diff --git a/include/configs/k1.h b/include/configs/k1.h
index 6a26fdfcebe..d46fec8b251 100644
--- a/include/configs/k1.h
+++ b/include/configs/k1.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ * Copyright (c) 2025-2026, RISCStar Ltd.
  *
  */
 
@@ -12,4 +13,7 @@
 #define CFG_SYS_SDRAM_BASE         0x0
 #define CFG_SYS_NS16550_IER        0x40 /* UART Unit Enable */
 
+#define RISCV_MMODE_TIMER_FREQ	    24000000
+#define RISCV_SMODE_TIMER_FREQ	    24000000
+
 #endif /* __CONFIG_H */
-- 
2.25.1

