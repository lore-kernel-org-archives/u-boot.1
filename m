Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A20CFC617E
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 14:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 832D483C28;
	Sat,  3 Jan 2026 15:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="TOc5Qqhx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BAC583B49; Sat,  3 Jan 2026 13:29:50 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9BF83B6C
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 13:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8D19426796;
 Sat,  3 Jan 2026 13:29:47 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VkPhGB_89kJU; Sat,  3 Jan 2026 13:29:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1767443372; bh=Dd+x3c3H/rYY93X7F0Dd7WF1vcIdV4fJcgqxCwL1m6U=;
 h=From:Subject:Date:To:Cc;
 b=TOc5QqhxQYMpejQLyLO3HzZA9x1ov4+T1DYyyFOxUcyoW+gPnaAFdlB6IUheZB8yR
 oLb9h7KP2JggHm02QOSA2+2RUiSV/P5xV1LSoeFzW3xtmJoKxHspwGaOa71RlCaxIu
 K87dJ3ry1I496lNxCoUo9wCucdjxLqXMX3roBCIBVddanaevzRsKxxzOMYpvHVBoyu
 Kd9G4LOJmEpOfAHeGi1slc7vKgx2UnGHbMJtcKaZX3WHaL4dVjwfs9TGwzHMsBqD/f
 lJmSDqwoBWlkMuPgXjZRp0i3QwqXA81z9HE41bHOpjGdDkZNQZbaM9sVeeBoUWHpf0
 zKyZHRACRbErA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/2] Support for Samsung Exynos 7870 DW-USB device in
 controller
Date: Sat, 03 Jan 2026 17:58:53 +0530
Message-Id: <20260103-usb-dwc3-exynos7870-v2-0-67441680d287@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIULWWkC/22NOw6DMBAFr4K2zka2+TlUuUdEAXiBbXDkJQSEu
 HscpHQpZ6Q3bwehwCRQJTsEWljYTxHMJYFubKaBkF1kMMrkWukMX9Kie3cp0rpNXkpbKsxdats
 8tY0qCOLyGajn9aw+6sgjy+zDdp4s+mt/vfJvb9GosKesIENO35S9O5bg/Xz1YYD6OI4P+CjOM
 7gAAAA=
X-Change-ID: 20251014-usb-dwc3-exynos7870-5d38b538a06e
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

This patch series aims to add support for the Samsung Exynos 7870 DW-USB
controller. The support is added in the dwc3-generic driver.

This also has a patch which allows the driver to fall back to "otg"
dual-role mode when none is specified in devicetree.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v2:
- Clarify rationale behind [PATCH 1/2]. (Marek Vasut)
- Link to v1: https://lore.kernel.org/r/20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org

---
Kaustabh Chakraborty (2):
      usb: dwc3-generic: allow fallback of dr_mode property to "otg"
      usb: dwc3-generic: add support for exynos7870

 drivers/usb/dwc3/dwc3-generic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
---
base-commit: 5e7624979083e2bc163e18165452d8ead462b58c
change-id: 20251014-usb-dwc3-exynos7870-5d38b538a06e

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

