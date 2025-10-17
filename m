Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F6DCCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F49838C5;
	Fri, 17 Oct 2025 17:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="GP/VNgwB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D23683869; Fri, 17 Oct 2025 17:27:18 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C632383826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9A6522629C;
 Fri, 17 Oct 2025 17:27:16 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7_m00LdAJnYZ; Fri, 17 Oct 2025 17:27:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714836; bh=Juxt87MYLpsQxfIt8jjGc2FAczCn0PAviC5mUnsW8/4=;
 h=From:Subject:Date:To:Cc;
 b=GP/VNgwBDt0ujm4nCWq8agMHub+TnDGoG26BCfoNMYLhrx5X6MTSOnutzDBnDZ44H
 kOzhzl6nty2RXLgfbpiX35jMYL7RHvecds7iTjtOgvQk+TPNySFRy/FPUgM+3Bf9Dd
 vmk2zzW00EMup6MDze2cbUfrrHSQCJZYWDI3b0Q0FM2evyBjxXIxjdRnN8ayw0Um7Y
 K60Y5nVoB1V1oyffuzt44g77L5nWtvYRTshzJAn9yvdjxNqJ3vKp46b7tHKGxBLALT
 OicbYnIRXTIl9/DctTlw84/Wmt/Ih/WNb0y2yZ+L00gu7ef6kDsq42wLzcXjNjxhZB
 fni78emWlwGwA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/2] Support for Samsung Exynos 7870 USB PHY device in driver
Date: Fri, 17 Oct 2025 20:57:05 +0530
Message-Id: <20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAElg8mgC/x3MQQqAIBBA0avErBtQsYyuEi3KxpyNhUNRRHdPW
 r7F/w8IZSaBvnog08nCWyrQdQU+Tmkl5KUYjDKNVtriHm88ZEa67rSJ65xCb4KZvLVhaRso4Z4
 p8PVPh/F9P1ACYrhkAAAA
X-Change-ID: 20251014-phy-usb-exynos7870-c2f2ac44fd65
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714832; l=745;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=Juxt87MYLpsQxfIt8jjGc2FAczCn0PAviC5mUnsW8/4=;
 b=eVpgNcwB7oxat0G8PY8IIgDi4Qzo4xGGTgcNL18ZTSp9uleobSubKxW8ZCKkEWWk7OLaf3xlv
 QxlteTe8y3TCv5mu+qwOngzWr+vfvECfVhy7cOe3Mpd+LtqticJB7dS
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

This patch series aims to add support for the USB PHY in Exynos 7870
devices. This can be accomodated in the existing driver, the patches
implements the ability of multiple devices to be driven by the same
driver.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (2):
      phy: samsung: add enum for variants based on SoCs
      phy: samsung: add support for exynos7870 USB PHY

 drivers/phy/phy-exynos-usbdrd.c | 271 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 261 insertions(+), 10 deletions(-)
---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251014-phy-usb-exynos7870-c2f2ac44fd65

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

