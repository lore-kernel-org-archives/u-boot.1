Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36170C36002
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 03:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DAB182BD9;
	Mon,  7 Apr 2025 05:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="GVcuev9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E80182BCD; Mon,  7 Apr 2025 05:38:11 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51F2182B7E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 05:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E9CF325D11;
 Mon,  7 Apr 2025 05:38:08 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtpjZ9OOXx4O; Mon,  7 Apr 2025 05:38:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1743997084; bh=O7bFhoDWsu5akqOQhXNr5iYGLGW2NgUtCUnpYme98e0=;
 h=From:To:Cc:Subject:Date;
 b=GVcuev9WGU/7kCKxxJx8KASeK9u253cRIfCAmQHSullm/XBW7QQ3K3P+ZdXDpYYw2
 /QJuhee0dsb5NPwVZuYAAWcbOngo1NWa03qEJgOmLG5iaK0weJ3MB7k0YRMqOwozQX
 1r7TulsgA+NOotPqdfseKuQJVs1HjfSlMVxFpfQOOAAAGUXUmWGg8JkwpLAAAVGeAA
 1Dpe4+4E++2BuOJKtkZ0c3RbqSmValLLc6C4FG1lxfmyN/OWCWGMX9CblA/86+NrNO
 6JxGNIPDhTCSG9AeBdFbvCkdNordMffiJwadxMe8Els3o7/DZmXWTK6Gsv59DRd/zW
 cx90KOB5S4Jwg==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Trevor Woerner <twoerner@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@denx.de>,
 Paul Kocialkowski <contact@paulk.fr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukas Funke <lukas.funke@weidmueller.com>,
 u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>
Subject: [PATCH 0/2] Fix binman_sym functionality on RISC-V port
Date: Mon,  7 Apr 2025 03:37:42 +0000
Message-ID: <20250407033744.4025-1-ziyao@disroot.org>
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

This series first defaults SPL_BINMAN_UBOOT_SYMBOLS to N on RISC-V to
prevent binman from looking for a plain proper U-Boot image, which
isn't desired since binman configuration on RISC-V wraps proper U-Boot
in a FIT image. Then we define __image_copy_start and the paired
__image_copy_end to really fix binman_sym's functionality.

I've tested building with
  - ae350_rv64_defconfig
  - ae350_rv64_spl_defconfig
  - bananapi-f3_defconfig
  - k230_canmv_defconfig
  - microchip_mpfs_icicle_defconfig

and booting successfully on
  - milkv_duo_defconfig
  - qemu-riscv64_smode_defconfig
  - qemu-riscv64_defconfig
  - sifive_unleashed_defconfig
  - starfive_visionfive2_defconfig
with either real hardware or QEMU.

Thanks for your time and review.

Yao Zi (2):
  spl: riscv: Disable SPL_BINMAN_UBOOT_SYMBOLS by default
  riscv: Provide __image_copy_{start_end} symbols in linkerscript

 arch/riscv/cpu/u-boot-spl.lds | 2 ++
 arch/riscv/cpu/u-boot.lds     | 3 +++
 common/spl/Kconfig            | 2 ++
 3 files changed, 7 insertions(+)

-- 
2.49.0

