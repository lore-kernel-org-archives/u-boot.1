Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7015CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB36483A03;
	Fri, 17 Oct 2025 17:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="SbxmAPqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8188383F; Fri, 17 Oct 2025 17:31:08 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D1783826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id CB0D926292;
 Fri, 17 Oct 2025 17:31:06 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aTzoLl03IiK9; Fri, 17 Oct 2025 17:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760715066; bh=WPWQiBtlllQoqv9pZAGXpcUQ80xYcfRS2icAtZelo5A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SbxmAPqAaX9rV3dC+N+mSyOE+hYmTali27Ppltcs4UdSKMQpvKFqXSshdgKpCCLNr
 J4eW/8qO71Va9MyQzwTw3uFeKJ2FELRz1TbeLipY0OEFxPPxpovq29AwYqaCCz5oC9
 spLvf6/PAKeCLXM2NJi/s+WyVyWi9Me4r3B5gvol3j3ypOExHzUZmT+/2kxyRgsai4
 nR4pOFCTI/jlW5OOZMLOGfdKuwAxn2HuDvTm9ikMzR/6ii1UrOltKBEDglU92Qdiwq
 Uv+pKvKKophpgnBZbnC9y1Caq+VNUjVGcrlKH9OUt0VzjBuZiqLMo58mWiedCCRGxl
 SGrVTE7fiPthg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 21:00:17 +0530
Subject: [PATCH 2/2] usb: dwc3-generic: add support for exynos7870
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-usb-dwc3-exynos7870-v1-2-fe46e2ed1908@disroot.org>
References: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
In-Reply-To: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760715023; l=893;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=WPWQiBtlllQoqv9pZAGXpcUQ80xYcfRS2icAtZelo5A=;
 b=0XIm6OCG+TZj3Th47Hi5Zz5B8xQX+GNrbDG+bP7YPSynYEeiY3en+Lv4PgqclOfn0q+eBhoL1
 qCo3A5BMa7xCdWlCWp7Autf64/XPfLRhCaWVi6VeTGbewL11I0EHqpE
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

Exynos7870's DWC3 glue layer is quite simple, consisting of a few
clocks, which is handled by this driver. Add the compatible string in
here.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 1967594f48ab40963463e6f17ed58ec45ce5867c..622847a9daf8e3c5cba4e4a9414b50e8a050df55 100644
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
2.51.0

