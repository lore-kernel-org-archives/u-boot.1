Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E291DF364CD
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC0083DC9;
	Sat, 11 Apr 2026 09:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bGj3Ivnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B988416F; Fri, 10 Apr 2026 15:58:34 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBF584105
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50b69bf5638so22740801cf.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829511; x=1776434311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2xuGlgsMcN8iYsXTSeYD8dNugWqvHN5Iinw6bOaLacM=;
 b=bGj3IvnbDhIcbSygo6w+BRiwzZn8E71mJPf2Fajy/8Act7gbNa4mtk9h5lTPMR/A5y
 nfBaMwGK20kPyAigsM34zTYPFSjClR4/hY+8hDtHtrEbSMbh9zecsCqEZIhxNRSb2dX7
 ZyaXdyMlqnTNar3VNPLVFpU6/obq/XjbsYU2QbCjfVx/4p9kZyufOaHiSZ35VcqEv9bv
 V/i+ZsvcDHi588Bq5OmxLaXc/HTHHkR35akcwb1U1QxNtujDDV7lkTYlBTT+dcs7GWhE
 jSfDcysIAPeOCsuUJSHdVeV/4VFPa0FrFOIZa5QCihq6UVI/3PBfp3T/orxsTNhNXILo
 6O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829511; x=1776434311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xuGlgsMcN8iYsXTSeYD8dNugWqvHN5Iinw6bOaLacM=;
 b=Hirin5robI197C1gkC+85ZNmOZjAWIq0AOLwnUrKb23Hvwg/XfRgBeZKFJ+l84X1nu
 jNuo6j3C8ndmYd3tXmfMxJ7ZeD9GX4keqmwLX13Ud15YkxbrRCiliG7biHiMKPfFGS2u
 +37a+16Uchg0UCQsLlPz6Mvch1GG5+zn5eQP8/wFGIh2FjIi2tOo6pD79hy83lbysGDT
 0nMWND5/qYh6LImim46GUR7+eykoQdvXJD14lidsjYCDpa7RtnJT+syFG7+Rw52MG5C+
 x7blzYbWyJeteoNNA247u3dRjky4CwfZz/PHxNVSN0eNLLxXDURYGdxlVaHpQ3ZfNVaN
 At5w==
X-Gm-Message-State: AOJu0Yz3i7q+now0dOUDqiW+2qYfS7A8ZXM4Qtc9bQ1GYrQl9ZiwJ0c9
 e4A9hf/ZYXpRTfYsgz0PWgCtdiDRogBnvFOoROwb+PFlGvCzGUPBU7Y3de+wIL3t
X-Gm-Gg: AeBDieu3kQaXBEUKrlw4Q4J5j1T09JzTZyDE4jxVO6BjUgVVJlnq7C+ioBbE1lpSALv
 iq6oJZzpTs5I6uHgDTTrTgcsLPD3FQgKD7kXYJQRhkOkBp0Qizd70Ce9vQmfXzFoqWqWE047ozX
 rdeSRkWzTrCJQvXWXchvhmE5EFC/xjGWce6quiSN9El2aXOeFBfYQfSvR+j67YBdX3NHQ6+JJlf
 KZtvPXqt0ZnXBsKQwrMSrvz0slyiMdlp5UuwEPmZKHtcFLDNtg+bVNEQcVRNsh3o+z8hX8nP1Bs
 ztxvQPROpgv4M6gAoWrc6s8HqaHqjQjedM3KhcMPYEvTXvHsuPgV+42M0G9h6L6BetvBdciySVs
 6X51g6KUXAfOfLiYcHK592+b+vxjkaHoNvyo1HPkk9GLNx6u4jXasogof+LSfZtGjaK3PVh/uCG
 IOKPcK48K6iz/OJWGp/zrFextflv7+fm4AFSKOKMMhOrlb
X-Received: by 2002:a05:622a:7506:b0:50d:af3a:d8ed with SMTP id
 d75a77b69052e-50dd5cc440emr36731211cf.41.1775829510779; 
 Fri, 10 Apr 2026 06:58:30 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:30 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 00/14] sc5xx Environment Cleanup and Fixes
Date: Fri, 10 Apr 2026 09:57:55 -0400
Message-Id: <cover.1775829166.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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

This series performs a general cleanup of the default U-boot environment
for sc5xx boards, stemming from the decision to no longer store the
environment in the SPI flash. The environments for each board have been
edited to contain the minimum number of commands needed for all supported
boot modes to avoid confusion, and the default boot command synced to spi
for all boards that support it. The filesystem for the SPI flash has also
been changed from jffs2 to ubifs.

A bug with the Ethernet reset line on the sc594 has been fixed, and the
sc573 has been renamed from the EZKIT to the EZLITE to match the name of the
publically available board. EZKIT was only used internally before release.
Preliminary binman support for sc5xx boards has been removed as it was unused
and full support never added.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>

---
Changes in v4:
- Added commit with default values for fdt_addr_r, kernel_addr_r, and initrd_addr
---

Caleb Ethridge (13):
  configs: sc5xx: Do not store environment in SPI flash
  mach-sc5xx: Remove update commands from default environment
  mach-sc5xx: Update boot commands
  mach-sc5xx: Switch from tftp to wget
  mach-sc5xx: Add USB boot command
  mach-sc5xx: Remove preliminary binman support
  dts: sc594: Fix gige-reset line on EZKIT
  mach-sc5xx: sc573: Rename EZKIT board to EZLITE
  mach-sc5xx: Update image load address
  mach-sc5xx: Update SPI bootargs for ubifs
  configs: sc5xx: Set default bootcmd to SPI boot
  arm: sc5xx: Remove SC5XX_LOADADDR
  arm: sc5xx: Add fdt_addr_r, kernel_addr_r, and initrd_addr

Ozan Durgut (1):
  arm: sc5xx: add missing boot env selectors

 arch/arm/dts/Makefile                         |  2 +-
 .../dts/{sc573-ezkit.dts => sc573-ezlite.dts} |  4 +-
 arch/arm/dts/sc594-som-ezkit.dts              |  2 +-
 arch/arm/dts/sc5xx.dtsi                       | 41 --------
 arch/arm/mach-sc5xx/Kconfig                   | 47 +--------
 arch/arm/mach-sc5xx/init/dmcinit.c            |  2 +-
 board/adi/sc573-ezkit/sc573-ezkit.env         | 17 ----
 .../adi/{sc573-ezkit => sc573-ezlite}/Kconfig |  8 +-
 .../{sc573-ezkit => sc573-ezlite}/Makefile    |  2 +-
 .../sc573-ezlite.c}                           |  0
 board/adi/sc573-ezlite/sc573-ezlite.env       | 16 +++
 board/adi/sc584-ezkit/sc584-ezkit.env         |  8 +-
 board/adi/sc589-ezkit/sc589-ezkit.env         |  9 +-
 board/adi/sc589-mini/sc589-mini.env           |  9 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |  9 +-
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |  8 +-
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |  9 +-
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env | 14 ++-
 ...ezkit_defconfig => sc573-ezlite_defconfig} | 12 +--
 configs/sc584-ezkit_defconfig                 | 10 +-
 configs/sc589-ezkit_defconfig                 | 12 +--
 configs/sc589-mini_defconfig                  | 12 +--
 configs/sc594-som-ezkit-spl_defconfig         |  7 +-
 configs/sc594-som-ezlite-spl_defconfig        |  7 +-
 configs/sc598-som-ezkit-spl_defconfig         |  5 +-
 configs/sc598-som-ezlite-spl_defconfig        |  5 +-
 .../arm/adi/adi,sc5xx.yaml                    |  2 +-
 .../configs/{sc573-ezkit.h => sc573-ezlite.h} |  4 +-
 include/env/adi/adi_boot.env                  | 98 ++++++-------------
 29 files changed, 106 insertions(+), 275 deletions(-)
 rename arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts} (98%)
 delete mode 100644 board/adi/sc573-ezkit/sc573-ezkit.env
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig (92%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Makefile (79%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c} (100%)
 create mode 100644 board/adi/sc573-ezlite/sc573-ezlite.env
 rename configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} (86%)
 rename include/configs/{sc573-ezkit.h => sc573-ezlite.h} (79%)

-- 
2.34.1

