Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC25D185F3
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A68E8414E;
	Thu,  8 Jan 2026 14:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="RAbZrO9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B2B1839F1; Thu,  8 Jan 2026 13:34:24 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE57783B8A
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 13:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7E6A126207;
 Thu,  8 Jan 2026 13:34:22 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YYV_xrM5O_NP; Thu,  8 Jan 2026 13:34:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1767875661; bh=BuOv0A1h04kv+ug4hiUjjQYjK5/DBnfPBzbTQ6tw4rw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RAbZrO9Aqpq3BDG2szWo0qxmfcfGBWnSAscwq7YGjvgwkKjowZrLIkmLJlRsEcZsy
 RRHvBYNDD8Srn41L41Atb7HQ5o8u2OHMJRvCaA4ZB19fsU/zaZxRsLHdUB87y7EBfz
 eWbCYOZTUgapo9sDfttkaA0C1g8zvNSZoT+z/onNyeH9hTunc8KXRBJQo+PdDdg/Xr
 Drz0UVxyBvn0bJi0u0ENZxzBiHDTUgG8oqJZzKYvSHqkQh2u/Q+vzTUeGtuQ8oPhiQ
 NtTD2GjCdwxlpcpuRFQh3+ceZsV2gLExTE7XQe0/krWd0iCQ5/48Nr/ENBx4Fv0XTY
 SBMycLIiswPNw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Thu, 08 Jan 2026 18:03:45 +0530
Subject: [PATCH v3 2/2] usb: dwc3-generic: add support for exynos7870
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-usb-dwc3-exynos7870-v3-2-343fa1e81e48@disroot.org>
References: <20260108-usb-dwc3-exynos7870-v3-0-343fa1e81e48@disroot.org>
In-Reply-To: <20260108-usb-dwc3-exynos7870-v3-0-343fa1e81e48@disroot.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Marek Vasut <marek.vasut@mailbox.org>
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:07 +0100
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

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index c15eda19e8f..bb11613a587 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -711,6 +711,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
 	{ .compatible = "fsl,imx8mq-dwc3" },
 	{ .compatible = "intel,tangier-dwc3" },
+	{ .compatible = "samsung,exynos7870-dwusb3" },
 	{ .compatible = "samsung,exynos850-dwusb3" },
 	{ }
 };

-- 
2.52.0

