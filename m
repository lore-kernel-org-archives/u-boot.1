Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23D7CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2492783966;
	Fri, 17 Oct 2025 17:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="IQctBQXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 080A483852; Fri, 17 Oct 2025 17:27:57 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3856383804
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 0C7BC262AD;
 Fri, 17 Oct 2025 17:27:55 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FO6K5_H1sWLi; Fri, 17 Oct 2025 17:27:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714874; bh=M6fTYk4Gq6uIEvfWIzOfY8GLASkoCEsekvMugqEDalI=;
 h=From:Subject:Date:To:Cc;
 b=IQctBQXhipTRUx7K9/JxkXZdmNGu+Xc6wWZiYen5vlcqgD4eTefFO9R7eZTumJIS5
 UuC1qLFddGoNBw6ybqPsFBPyFpaoPPXBIT6pFkkMVuWc0HDZKNwTz203RUcHtYGvZw
 4malvUFoeESWu/IOf6VIqvndpiGv6GZi9815XtqGIQGmd7l2an6rVSJiIeCo5MswqF
 aV3gWvCY71W7DgPv3/M26sEbXct7JO2KapTsTu7VKP2Ip78oCrTN0LtKiwpLV8ovPv
 lZvSLbWWPlWkDu09JxCbPq9A4UbpiTVW7mhtp7Ja4sQUGeqflcqeLVn+og6iQSia/O
 ZxGDCwLD11bKQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/2] Support for Samsung Exynos 7870 pin controllers in driver
Date: Fri, 17 Oct 2025 20:57:39 +0530
Message-Id: <20251017-pinctrl-exynos7870-v1-0-beaa92f95a0c@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGtg8mgC/x3MQQqAIBBA0avIrBNULKWrRAupqQZCRSMK8e5Jy
 7f4v0DGRJhhZAUS3pQp+AbZMVgO53fktDaDEqqXQmoeyS9XOjk+rw/ZWCO4GSQKp6w2TkELY8K
 Nnn86zbV+gG9THWQAAAA=
X-Change-ID: 20251014-pinctrl-exynos7870-761e0a2847a2
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Henrik Grimler <henrik@grimler.se>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714868; l=950;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=M6fTYk4Gq6uIEvfWIzOfY8GLASkoCEsekvMugqEDalI=;
 b=YIl8uDpgK6soF9KeIQ4tbGcEbMg6NuF2d+P2uRPJ3TQAwLQxq/MuVHh6X0cZcT6IgA6V27mlV
 81F6du21/2BC2PrT+doFU73DlgcmowJaU14JblE6pJwriIX83lq1r3T
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

This patch series aims to add support for the Exynos 7870 pin
controllers. Along with that, it also introduces a way to bind the GPIO
driver along with it, as in devicetree both reside in the same node.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (2):
      pinctrl: exynos: bind GPIO driver along with pinctrl
      pinctrl: exynos78x0: add proper support for exynos7870 pinctrl

 drivers/pinctrl/exynos/pinctrl-exynos.c     | 11 ++++++
 drivers/pinctrl/exynos/pinctrl-exynos.h     |  1 +
 drivers/pinctrl/exynos/pinctrl-exynos7420.c |  1 +
 drivers/pinctrl/exynos/pinctrl-exynos78x0.c | 60 +++++++++++++++++++++++++++++
 drivers/pinctrl/exynos/pinctrl-exynos850.c  |  1 +
 5 files changed, 74 insertions(+)
---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251014-pinctrl-exynos7870-761e0a2847a2

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

