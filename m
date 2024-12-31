Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA41BE7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 16:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABA6801CE;
	Tue, 31 Dec 2024 17:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 951878021D; Tue, 31 Dec 2024 17:50:01 +0100 (CET)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 093B6801CE
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 17:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje.mihanovic@skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
 by mx.skole.hr (mx.skole.hr) with ESMTP id 4C67282EC7;
 Tue, 31 Dec 2024 17:49:58 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v2 0/3] Initial support for PXA1908 and samsung-coreprimevelte
Date: Tue, 31 Dec 2024 17:49:11 +0100
Message-Id: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIcgdGcC/13MwQ6CMBCE4Vche7aGrojEk+9hOEAZZCNSsiWNh
 vDuVhMvHv9J5lspQAWBztlKiihB/JSCdxm5oZluMNKlJs65sMylcV4xqzwQMS4w1nHZuL49Vl1
 L6TQrenl+wWudepCweH19/Wg/6486/VPRmtw0ruLiAKBAeQl3P2I/KNXbtr0BtvsL1qsAAAA=
X-Change-ID: 20241226-coreprimevelte-1c26acfb58db
To: Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=MDxE1xk/r294E+Rxr/FeRHJx+EMIhwNbR2zy+TetsEQ=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOklCv0seY9KxLw/XWO+feaR7MeHN95NecezLvnA8zNF3
 jdWrXHf0lHKwiDGxSArpsiS+9/xGu9nka3bs5cZwMxhZQIZwsDFKQATMZ/E8Ffuwf/YrmTeDFf5
 DWw6FVG/NYKC7ir/2SEcHbuJe/nCYFtGhsZPnZc3FO97//Z6xJkVf4PT6n/eezvhGvupvwIKnSt
 udvMCAA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Mailman-Approved-At: Tue, 31 Dec 2024 17:51:37 +0100
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

Hello,

This series adds initial support for Marvell's PXA1908 ARM64 SoC and
Samsung's Galaxy Core Prime VE LTE, a smartphone based on said SoC.

On this board, U-Boot is used as a secondary bootloader to work around
certain quirks of the factory S-Boot.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v2:
- Drop arm,armv8 compatible from CPU nodes to match upstream
- Add intel,xscale-uart compatible to NS16550 and use it in serial nodes to match upstream
- Add include guards to include/configs/pxa1908.h
- Disable CONFIG_DISPLAY_CPUINFO and CONFIG_CPU
- Rebase on v2025.01-rc5
- Link to v1: https://lore.kernel.org/r/20241227-coreprimevelte-v1-0-ac8243eee4e6@skole.hr

---
Duje Mihanović (3):
      serial: ns16550: Add Intel XScale support
      arm: mmp: add initial support for PXA1908 SoC
      board: samsung: add initial support for coreprimevelte board

 MAINTAINERS                                     |   8 ++
 arch/arm/Kconfig                                |  11 +++
 arch/arm/Makefile                               |   1 +
 arch/arm/dts/Makefile                           |   2 +
 arch/arm/dts/pxa1908-samsung-coreprimevelte.dts |  74 +++++++++++++++++
 arch/arm/dts/pxa1908.dtsi                       | 106 ++++++++++++++++++++++++
 arch/arm/mach-mmp/Kconfig                       |  12 +++
 arch/arm/mach-mmp/Makefile                      |   1 +
 arch/arm/mach-mmp/board.c                       |  82 ++++++++++++++++++
 arch/arm/mach-mmp/mmu.c                         |  30 +++++++
 board/samsung/coreprimevelte/Kconfig            |  12 +++
 board/samsung/coreprimevelte/MAINTAINERS        |   6 ++
 configs/coreprimevelte_defconfig                |  18 ++++
 drivers/serial/ns16550.c                        |   1 +
 include/configs/pxa1908.h                       |  18 ++++
 15 files changed, 382 insertions(+)
---
base-commit: 4be40460758057b9a85b0303dc072c108813cdf6
change-id: 20241226-coreprimevelte-1c26acfb58db

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


