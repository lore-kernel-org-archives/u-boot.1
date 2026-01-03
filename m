Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7D2FC6160
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 14:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3BB83BF1;
	Sat,  3 Jan 2026 15:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="kHK5YJ7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6273683BF1; Sat,  3 Jan 2026 13:29:49 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B0C383B49
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 13:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 2E4E4260AF;
 Sat,  3 Jan 2026 13:29:42 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8th3iw90RhPn; Sat,  3 Jan 2026 13:29:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1767443381; bh=EX8IfSCLvNYc1BopTVbUAqZotANRKrlX63MoWlYHBBA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kHK5YJ7NQOVC/JAK/SXbDl7P/ztvPNGbAaLC3tUvKC0Zicn9Gea6s5MMTVraF8VT4
 bEKVMfN7G5N7iyX6jRVkRooiXO0UaA81QkC/ZaJfg8vCiVWE3itut/kdvFraOv8UVp
 OSk8OxUQrCnj3xeIUA1ZTwTKBRduJ1NsPhcyIdtoRqS8GMbGKfb1BjAidL83JfOSCz
 fKRVuHOhrPrZ2kCjzNazCZ2xqR5zdEOuVNrjQOVffIo+jQ5rEfztcmQi1BLsviJ/+1
 CJkoXWHTcaolUKxtNUsmQYipfZLf6cEGXOUOMQqt5QeugTxhvlFAgDeDPkRvhJ8fgd
 h5DykztB7tY3w==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sat, 03 Jan 2026 17:58:55 +0530
Subject: [PATCH v2 2/2] usb: dwc3-generic: add support for exynos7870
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260103-usb-dwc3-exynos7870-v2-2-67441680d287@disroot.org>
References: <20260103-usb-dwc3-exynos7870-v2-0-67441680d287@disroot.org>
In-Reply-To: <20260103-usb-dwc3-exynos7870-v2-0-67441680d287@disroot.org>
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

Exynos7870's DWC3 glue layer is quite simple, consisting of a few
clocks, which is handled by this driver. Add the compatible string in
here.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 1967594f48a..622847a9daf 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -710,6 +710,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
 	{ .compatible = "fsl,imx8mq-dwc3" },
 	{ .compatible = "intel,tangier-dwc3" },
+	{ .compatible = "samsung,exynos7870-dwusb3" },
 	{ .compatible = "samsung,exynos850-dwusb3" },
 	{ }
 };

-- 
2.52.0

