Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DDBC369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 14:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CADC480FDE;
	Sun, 27 Apr 2025 16:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="QdRL8i/U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF75F81E0F; Sun, 27 Apr 2025 16:52:03 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6075A80FDA
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 16:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1052025BBE;
 Sun, 27 Apr 2025 16:52:01 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3BVEwiIJPwKV; Sun, 27 Apr 2025 16:52:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745765520; bh=nUtEm5Brm7N7I8jM0Px22axaqZngVigw8Q6ku7fw0AM=;
 h=From:To:Cc:Subject:Date;
 b=QdRL8i/UyoITXU4FV6+Cc60EW+evc4wMBdLDifzwqzx38GbVGbqU22IiOYTGJFrQ8
 ewLs5jmAAW16L+2PAX/CB58AD1raO21RwyzCqdewjoEpy+4J9hQg+RkNI0rj9zsaLr
 K0tNvS82Y+A2VWEbAeXZ88+Zyde7P8XCXyOqIQE9ipjtL7drjSxWg7F9Rrgnq7tT5V
 PUiGe8eiKrjjnbi4tT/Jmi7mHKEP2gMTKPZaa5f+amZtKcFPQdjSXTbUMacSrL5ecB
 QZ0qKJwp9hOqG7ENYWhTC23VklyO0d4skn8TJZtpn0pUYFo3PUkTkwe9iVRJbwDDcJ
 Xdvn6MeY8fgQA==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Anton Blanchard <antonb@tenstorrent.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Nathaniel Hourt <I@nathaniel.land>,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH 0/2] Clang compatibility improvements for RISC-V
Date: Sun, 27 Apr 2025 14:50:09 +0000
Message-ID: <20250427145011.17331-1-ziyao@disroot.org>
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

Originally reported by Nathaniel Hourt[1], U-Boot fails to boot on
JH7110 platforms (starfive_visionfive2_defconfig) when building with
Clang.

This series fixes configuration generation with Clang's preprocessor and
add an alternative codepath for RISC-V to access gd to workaround
misoptimization of Clang, which is sufficient for building images for
JH7110 boards.

Tested with

- starfive_visionfive2_defconfig
- qemu-riscv64_smode_defconfig
- sifive_unleashed_defconfig

built with either GCC 14 or LLVM 19.

Note that images built with LLVM lld are still broken and binutils ld
has to be used for now. To test the changes on JH7110 platforms, this
patch[2] must be applied for SPL to function.

[1]: https://lore.kernel.org/u-boot/932979cb47c4fded7ac19216ca172504@nathaniel.land/
[2]: https://lore.kernel.org/all/20250330162421.238483-1-heinrich.schuchardt@canonical.com/

Yao Zi (2):
  Makefile: Strip leading spaces when preprocessing generated_defconfig
  riscv: Access gd with inline assembly when building with LTO or Clang

 arch/riscv/cpu/cpu.c                 |  6 ++++++
 arch/riscv/include/asm/global_data.h | 19 +++++++++++++++++++
 common/board_r.c                     |  4 +++-
 common/init/board_init.c             |  7 +++++--
 scripts/kconfig/Makefile             |  1 +
 5 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.49.0

