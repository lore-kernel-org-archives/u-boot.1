Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AB5CFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 06:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E39F83DFF;
	Tue,  2 Dec 2025 07:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="XAtMRDZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3825783E0E; Tue,  2 Dec 2025 07:59:41 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D5183DE0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 07:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20251202065933epoutp0181336eb298c29702b53cdba83e29e572~9U84hG0EL2628526285epoutp016
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 06:59:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20251202065933epoutp0181336eb298c29702b53cdba83e29e572~9U84hG0EL2628526285epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1764658773;
 bh=SIOSeyuyovyamwWhaZ7bJfAxj4Ff3q+5UfD3+4780AA=;
 h=From:To:Subject:Date:References:From;
 b=XAtMRDZ4CuwtPeubXC4D9cZcgc5qr5uA7ru2ZA46M3paWDbCkfF1+yMhM1phcg/qR
 sEpOOSBJsSpnpD8avLIfFDCQ+Dp4wte2NzGEJPlNcVrkprU/NArAVYJuXY4JxHfbIh
 T1ZjsE7tlc+caEFZSe/YUHi/Nm1rBLmfGn7hOx6w=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
 20251202065933epcas1p322ca54b81b654d0afa6266b9ba3f94b0~9U84V_3qI1902519025epcas1p3y;
 Tue,  2 Dec 2025 06:59:33 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.191]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4dLBTd0fRfz6B9mL; Tue,  2 Dec
 2025 06:59:33 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20251202065932epcas1p317a2fa75a3b16a4984a0c0bdf0515b5a~9U83buK7N2126121261epcas1p3J;
 Tue,  2 Dec 2025 06:59:32 +0000 (GMT)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20251202065932epsmtip23d107bc1abcb2fa3bf3118b29f6764b8~9U83Z9zEe1728217282epsmtip2E;
 Tue,  2 Dec 2025 06:59:32 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: "'Tom Rini'" <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: please pull u-boot-samsung master
Date: Tue, 2 Dec 2025 15:59:32 +0900
Message-ID: <0cdd01dc6359$36177b60$a2467220$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdxjWTW4vb10q4aTTBWAc3UIFUhLRA==
Content-Language: ko
X-CMS-MailID: 20251202065932epcas1p317a2fa75a3b16a4984a0c0bdf0515b5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251202065932epcas1p317a2fa75a3b16a4984a0c0bdf0515b5a
References: <CGME20251202065932epcas1p317a2fa75a3b16a4984a0c0bdf0515b5a@epcas1p3.samsung.com>
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

Dear Tom,

The following changes since commit caa740df9cae5ddc74b18b88a4fea43e27b2fdf6:

  Gitlab: Optimize the job dependency list more (2025-11-11 11:55:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to 422b15bb5b693376e345d3f32d7cec4588f3bfba:

  doc: samsung: exynos-mobile: add documentation for exynos7870 (2025-12-02
13:38:28 +0900)

----------------------------------------------------------------
Kaustabh Chakraborty (14):
      clk: exynos: provide device pointer to clk_register_* functions
      clk: exynos: add support for fixed rate and fixed factor clocks
      clk: exynos: add support for PLL1417X
      clk: exynos: add function for Samsung CMU ops->request
      clk: exynos: add support for Exynos7870 CMU
      clk: use private clk struct to access clock flags
      pinctrl: exynos: bind GPIO driver along with pinctrl
      pinctrl: exynos78x0: add proper support for exynos7870 pinctrl
      serial: s5p: add compatible for exynos8895
      soc: exynos-pmu: add support for Exynos7 PMU
      gpio: s5p: increment bank base address only if bank is initialized
      board: samsung: add support for Samsung Exynos mobile device boards
      board: samsung: exynos-mobile: add exynos7870 support and three
devices
      doc: samsung: exynos-mobile: add documentation for exynos7870

Sam Protsenko (6):
      board: samsung: e850-96: Keep public functions together
      board: samsung: e850-96: Add routines for checking boot dev
      board: samsung: e850-96: Split LDFW loading and init
      board: samsung: e850-96: Add routine for loading images over USB
      board: samsung: e850-96: Load firmwares over USB on USB boot
      board: samsung: e850-96: Enter DFU automatically on USB boot

Tom Rini (1):
      s5p4418_nanopi2: Stop disabling device tree relocation

 arch/arm/mach-exynos/Kconfig                        |  11 +-
 board/samsung/e850-96/Makefile                      |   2 +-
 board/samsung/e850-96/bootdev.c                     |  99 +++++++++
 board/samsung/e850-96/bootdev.h                     |  23 ++
 board/samsung/e850-96/e850-96.c                     |  71 +++++--
 board/samsung/e850-96/fw.c                          |  76 +++++--
 board/samsung/e850-96/fw.h                          |  10 +-
 board/samsung/exynos-mobile/Kconfig                 |  18 ++
 board/samsung/exynos-mobile/MAINTAINERS             |   6 +
 board/samsung/exynos-mobile/Makefile                |   5 +
 board/samsung/exynos-mobile/debug-exynos7870.config |   7 +
 board/samsung/exynos-mobile/exynos-mobile.c         | 403
+++++++++++++++++++++++++++++++++++
 board/samsung/exynos-mobile/exynos-mobile.env       |  18 ++
 configs/exynos-mobile_defconfig                     |  72 +++++++
 doc/board/samsung/exynos-mobile.rst                 |  45 ++++
 doc/board/samsung/exynos-mobile/exynos7870.rst      |  85 ++++++++
 doc/board/samsung/index.rst                         |   1 +
 drivers/clk/clk-uclass.c                            |   6 +-
 drivers/clk/exynos/Kconfig                          |   7 +
 drivers/clk/exynos/Makefile                         |   1 +
 drivers/clk/exynos/clk-exynos7870.c                 | 929
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++
 drivers/clk/exynos/clk-pll.c                        |   4 +-
 drivers/clk/exynos/clk-pll.h                        |   4 +-
 drivers/clk/exynos/clk.c                            |  99 +++++++--
 drivers/clk/exynos/clk.h                            |  53 +++++
 drivers/gpio/s5p_gpio.c                             |   5 +-
 drivers/pinctrl/exynos/pinctrl-exynos.c             |  11 +
 drivers/pinctrl/exynos/pinctrl-exynos.h             |   1 +
 drivers/pinctrl/exynos/pinctrl-exynos7420.c         |   1 +
 drivers/pinctrl/exynos/pinctrl-exynos78x0.c         |  60 ++++++
 drivers/pinctrl/exynos/pinctrl-exynos850.c          |   1 +
 drivers/serial/serial_s5p.c                         |   1 +
 drivers/soc/samsung/exynos-pmu.c                    |   3 +
 include/configs/exynos-mobile.h                     |  14 ++
 include/configs/s5p4418_nanopi2.h                   |   1 -
 35 files changed, 2089 insertions(+), 64 deletions(-)
 create mode 100644 board/samsung/e850-96/bootdev.c
 create mode 100644 board/samsung/e850-96/bootdev.h
 create mode 100644 board/samsung/exynos-mobile/Kconfig
 create mode 100644 board/samsung/exynos-mobile/MAINTAINERS
 create mode 100644 board/samsung/exynos-mobile/Makefile
 create mode 100644 board/samsung/exynos-mobile/debug-exynos7870.config
 create mode 100644 board/samsung/exynos-mobile/exynos-mobile.c
 create mode 100644 board/samsung/exynos-mobile/exynos-mobile.env
 create mode 100644 configs/exynos-mobile_defconfig
 create mode 100644 doc/board/samsung/exynos-mobile.rst
 create mode 100644 doc/board/samsung/exynos-mobile/exynos7870.rst
 create mode 100644 drivers/clk/exynos/clk-exynos7870.c
 create mode 100644 include/configs/exynos-mobile.h

Thanks,
Minkyu Kang.



