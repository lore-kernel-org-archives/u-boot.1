Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD1ECCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF0B839DF;
	Fri, 17 Oct 2025 17:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="mL/aiesX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 060BB8383F; Fri, 17 Oct 2025 17:30:37 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A0A83826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 00C8E26285;
 Fri, 17 Oct 2025 17:30:35 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id piSl2wMON4-w; Fri, 17 Oct 2025 17:30:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760715032; bh=+TEiEUtddFRO3jUwmk8Za7AgW3aAEyTwQVWJGpFvaOo=;
 h=From:Subject:Date:To:Cc;
 b=mL/aiesXJPXsuhhhtxdlq1L0tg4Ge4tG0uL/YpuWXvsjESnGpwFSZ9lDJkDweKLZ4
 TwEy9qGVJ7ufpd9utCW0d4xWsrBlXTbZa0aBCotLaVmO6PlAT8WH66ovu3s/8Phatx
 bGGdAbLxpeCiGfKHNeBWuwD2sRWE/GymeE1E+tgSY5zQR1PJRzT6slbFCXmSutKnxS
 nJUPBUD1jtTzTISOzMCTR79bo+iC3WJagk+0eLEYArWvg3JZT3ZZxf82PdFu3Es7/1
 0g+iPTPWCAZE4/UMrD7R4NBjlaqNEUXqemyJcaM7FGUHedjkeTAz9P8b6mH1xGSXri
 Dcdm26za4nRoA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/2] Support for Samsung Exynos 7870 DW-USB device in
 controller
Date: Fri, 17 Oct 2025 21:00:15 +0530
Message-Id: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAdh8mgC/x3MTQ5AMBBA4avIrE3SqtK4iligg9mUdOIv4u4ay
 2/x3gNCkUmgyR6IdLDwGhJ0nsG49GEmZJ8MhSqsVrrEXQb052iQrjusUrtaofXGDda4XlUEqdw
 iTXz917Z73w+OR4tMZQAAAA==
X-Change-ID: 20251014-usb-dwc3-exynos7870-5d38b538a06e
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760715023; l=763;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=+TEiEUtddFRO3jUwmk8Za7AgW3aAEyTwQVWJGpFvaOo=;
 b=77jnbYGYXq05SnJaXL3r4djP7bZnXMCEXEvoURmrmbyaNd0RTScCHnzcQxoXphHXdVPzk51vY
 yFuAuaLPwpdCDVvknL9HVA+YNHOsMo/0IMbPT7e7p1Vc6YUcQQDlta+
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

This patch series aims to add support for the Samsung Exynos 7870 DW-USB
controller. The support is added in the dwc3-generic driver.

This also has a patch which allows the driver to fall back to "otg"
dual-role mode when none is specified in devicetree.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (2):
      usb: dwc3-generic: allow fallback of dr_mode property to "otg"
      usb: dwc3-generic: add support for exynos7870

 drivers/usb/dwc3/dwc3-generic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251014-usb-dwc3-exynos7870-5d38b538a06e

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

