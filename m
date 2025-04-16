Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63C5C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 16:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F8582E3F;
	Wed, 16 Apr 2025 18:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="gipe13zn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C3182ED4; Wed, 16 Apr 2025 18:25:54 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EECAB82DE7
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 18:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9028825E18;
 Wed, 16 Apr 2025 18:25:49 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vvi3ubfS3Q8E; Wed, 16 Apr 2025 18:25:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1744820748; bh=stUOxacpz/C3g/YaL5BfhkVWFDrrJfzgREX2aDSzEao=;
 h=From:To:Cc:Subject:Date;
 b=gipe13zn/st+qD2qwnU/+OQvL1iDsb0xSyVZPvPnhNy6a0MliwtevLF3LMvm5eZSQ
 Umt9kzVeyYY5fzZdBkI2YDOzX0AGIEst7qFZAt+SY1oCwN6JMx2xr0nsBM5tul4Vv7
 kQ1X4FUadJY/JC9kpm8pfIWjJq0fZAItBNFzzUXtGC+KV7T7SKA3qgeuxiRs6CE0b3
 FX8QPj9a4wVcjOefBgl8vTEzdJLh2DSJqZKBwf690qrc9uYASfy3hrz7uwrp8AgRgC
 Y4UjAYHoHLlFZYnXU//+/ZUQr2o9L3zdIHcCEOEgiC86G/b4ETZab0IugJ+L+7LJtb
 VC/9w6BsgsCiQ==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Sumit Garg <sumit.garg@kernel.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 0/3] Fix binman_sym functionality on RISC-V port
Date: Wed, 16 Apr 2025 16:25:30 +0000
Message-ID: <20250416162533.1396-1-ziyao@disroot.org>
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

It's found that BINMAN_SYMBOLS_OK always evaluates to false on RISC-V,
because our linkerscripts don't define symbol __image_copy_start, on
which binman depends for determining the base address of an entry.
Binman simply bails out in case of missing the symbol.

This series contains three main changes,

1. Correct the entry type used for proper U-Boot, ensuring binman could
   find it, which is mandatory since SPL_BINMAN_UBOOT_SYMBOLS defaults
   to Y on RISC-V
2. Mark the SPL image of StarFive VisionFive2 as "no-write-symbols",
   since the SPL and proper U-Boot are split into two images.
3. Finally provide __image_copy{start,end} in RISC-V linkerscripts of
   both SPL and proper U-Boot, fixing functionality of binman_sym

I've tested building with
  - ae350_rv64_defconfig
  - ae350_rv64_spl_defconfig
  - bananapi-f3_defconfig
  - k230_canmv_defconfig
  - microchip_mpfs_icicle_defconfig
  - milkv_duo_defconfig

and booting successfully on
  - qemu-riscv64_smode_defconfig
  - qemu-riscv64_defconfig
  - sifive_unleashed_defconfig
  - starfive_visionfive2_defconfig
with either real hardware or QEMU.

Thank you Jonas Karlman for pointing out the root cause of binman
failures with SPL_BINMAN_UBOOT_SYMBOLS enabled. I'm looking forward to
further reviews.

Changed from v2
- Drop the patch which disables SPL_BINMAN_UBOOT_SYMBOLS by default on
  RISC-V
- Add patch to correct entry type of proper U-Boot in default binman
  configuration for RISC-V
- Add patch to prevent binman from relocating SPL of VisionFive 2
- Fix typo (one missing underscore) in linkerscript and collect Simon's
  r-b tag.
- Link to v1: https://lore.kernel.org/u-boot/20250407033744.4025-1-ziyao@disroot.org/

Yao Zi (3):
  riscv: dts: binman.dtsi: Switch to u-boot-nodtb entry for proper
    U-Boot
  riscv: dts: starfive: Prevent binman from relocating symbols in SPL
  riscv: Provide __image_copy_{start_end} symbols in linkerscript

 arch/riscv/cpu/u-boot-spl.lds                   | 2 ++
 arch/riscv/cpu/u-boot.lds                       | 3 +++
 arch/riscv/dts/binman.dtsi                      | 2 +-
 arch/riscv/dts/starfive-visionfive2-binman.dtsi | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.49.0

