Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF7FFC6160
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 14:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A0E83C65;
	Sat,  3 Jan 2026 15:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="UJ8qB66G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D55F83B6C; Sat,  3 Jan 2026 13:53:08 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB008388D
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 13:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3C79B2686D;
 Sat,  3 Jan 2026 13:53:06 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RyeEckkebjQd; Sat,  3 Jan 2026 13:53:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1767444785; bh=Juxt87MYLpsQxfIt8jjGc2FAczCn0PAviC5mUnsW8/4=;
 h=From:Subject:Date:To:Cc;
 b=UJ8qB66G10Vw/KBbzw6ZM2Vv4KrmYDyC+eZZCE2rY5mtapNubIP8Mgrq+ITHe8miu
 THQknk95B/KIT4fmIUNFcWWizLwKS4sC90s5vNGtE4nlPqm9KL7Htd6mn+SDb1VZpD
 u4fruvwfQ7I20o2meZX27+lkTO7Cq4qK/wEz3LjEMc5dtgDVuKMRAW8D4rTlPXyYGn
 G5AsUeZZfhINlZcfs/vyT3Em7daxsOXBqvQ1Ur8ZAoYBZLiimL8ZAYaEqsUwWCwsIl
 CjOqFprWYIGNREo8O8ZQZ5D7FnKkFYrdbQ8enxU6glNdRFcDxNPjQE5LmtLUj2oFaM
 JHKrMiAKyoqZA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH RESEND 0/2] Support for Samsung Exynos 7870 USB PHY device
 in driver
Date: Sat, 03 Jan 2026 18:22:47 +0530
Message-Id: <20260103-phy-usb-exynos7870-v1-0-08f3e9814b86@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Sat, 03 Jan 2026 15:42:31 +0100
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

