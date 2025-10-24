Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA755CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED72883857;
	Fri, 24 Oct 2025 19:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="L0LyRIVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A4DE83835; Fri, 24 Oct 2025 19:29:00 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D751183677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 19:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8665F26019;
 Fri, 24 Oct 2025 19:28:57 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 78C6pk3xBmKJ; Fri, 24 Oct 2025 19:28:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1761326936; bh=y570UAV7Sps9UKRtWkcjVST+V4aj+L8xoSQ9Ab9kmd4=;
 h=From:Subject:Date:To:Cc;
 b=L0LyRIVg/Y8Ry4IcvWD73Xs5Jzl9P6iMZ9cgTjsFyE2fLNXJhimJQVQB9Wq1paNIS
 ugaAtL5Id+zsJ1YrGpWdNfVFIn/lqIZohWRD3k1JpeKwr7/4xtJ1diiPuiEFJYpVT1
 SCtIfMe6U0k6juH8lCw1ugYFOeTx4m8T68Kbnk/0V8GYviyTPG4zffe2KTz+tKqRG0
 lIyu3UyrQwqU7ArB+xU/dHWD1Oj0EpWLY3+1p06yWPabQe5HZAgl55oimfEB70H+d8
 MOTDRggGePDAGTKm0TouleXTKydqjia7GYcPoPG//MCYC5xCrLISLMF2O2XP/S61PR
 I5k7Aa2w+V5Lw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/3] Support for a generic platform for all Exynos
 mobile devices
Date: Fri, 24 Oct 2025 22:58:26 +0530
Message-Id: <20251024-board-exynos-mobile-v2-0-e6fce69e60c3@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADq3+2gC/32NQQ6CMBBFr0JmbQ0t1Kor72FYAB1gEmV0igRCu
 LsVF+5cvpf89xcIKIQBzskCgiMF4j6C2SVQd2XfoiIfGUxqrE61UxWX4hVOc89B3bmiGypXO59
 nx8wcThnE5UOwoWmrXosvCz5fMT78ZEdhYJm351F/7P+TUSutrG1y5701Te0unoIwD3uWFop1X
 d//9VfVzQAAAA==
X-Change-ID: 20251017-board-exynos-mobile-7c7d43832693
To: u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Henrik Grimler <henrik@grimler.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761326916; l=3125;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=y570UAV7Sps9UKRtWkcjVST+V4aj+L8xoSQ9Ab9kmd4=;
 b=3guSdjUPWoFiOcIr52NBdulTCrcS2BQko77xWBUjZ/iivboi7BuVm46roL2d7103/JA7yIz/d
 EbgnbmM1+r9CEpnfSY5EuFLg6i8Sjua6NuprFOy+9wYZesOhzBcuMBC
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 24 Oct 2025 19:37:56 +0200
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

This patch series aims to add support for a generic platform which
intends to support multiple boards powerid by Samsung Exynos SoCs. This
series also includes initial support for three boards:
* Samsung Galaxy A2 Core
* Samsung Galaxy J6
* Samsung Galaxy J7 Prime

This patch has the following dependencies:
(NOTE: `x` indicates applied)

armv8-broken-cntfrq		- https://patch.msgid.link/20251017-armv8-broken-cntfrq-v2-1-1e043cbb657e@disroot.org
clk-exynos7870			- https://patch.msgid.link/20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org
gpio-s5p-bank-fix		- https://patch.msgid.link/20251017-gpio-s5p-bank-fix-v1-1-41050462cea5@disroot.org
i2c-hs-exynos7			- https://patch.msgid.link/20251017-i2c-hs-exynos7-v1-1-ca080895d4b6@disroot.org
mmc-dw-exynos7870		- https://patch.msgid.link/20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org
phy-usb-exynos7870		- https://patch.msgid.link/20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org
pinctrl-exynos7870		- https://patch.msgid.link/20251017-pinctrl-exynos7870-v1-0-beaa92f95a0c@disroot.org
power-pmic-regulator-s2mpu05	- https://patch.msgid.link/20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org
serial-s5p-exynos8895		- https://patch.msgid.link/20251017-serial-s5p-exynos8895-v1-1-b412dd112cfd@disroot.org
soc-pmu-exynos7			- https://patch.msgid.link/20251017-soc-pmu-exynos7-v1-1-553d18eaab0d@disroot.org
usb-dwc3-exynos7870		- https://patch.msgid.link/20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v2:
- Split patch in multiple parts (Henrik Grimler)
- Fix typos in docs and other small changes (Henrik Grimler)
- Split device-specific docs in a separate file
- Link to v1: https://lore.kernel.org/r/20251017-board-exynos-mobile-v1-1-55f47dd52fc7@disroot.org

---
Kaustabh Chakraborty (3):
      board: samsung: add support for Samsung Exynos mobile device boards
      board: samsung: exynos-mobile: add exynos7870 support and three devices
      doc: samsung: exynos-mobile: add documentation for exynos7870

 arch/arm/mach-exynos/Kconfig                       |  11 +-
 board/samsung/exynos-mobile/Kconfig                |  18 +
 board/samsung/exynos-mobile/MAINTAINERS            |   6 +
 board/samsung/exynos-mobile/Makefile               |   5 +
 .../samsung/exynos-mobile/debug-exynos7870.config  |   7 +
 board/samsung/exynos-mobile/exynos-mobile.c        | 403 +++++++++++++++++++++
 board/samsung/exynos-mobile/exynos-mobile.env      |  18 +
 configs/exynos-mobile_defconfig                    |  72 ++++
 doc/board/samsung/exynos-mobile.rst                |  45 +++
 doc/board/samsung/exynos-mobile/exynos7870.rst     |  85 +++++
 doc/board/samsung/index.rst                        |   1 +
 include/configs/exynos-mobile.h                    |  14 +
 12 files changed, 684 insertions(+), 1 deletion(-)
---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251017-board-exynos-mobile-7c7d43832693

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

