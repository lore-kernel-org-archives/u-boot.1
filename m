Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6885AEC1112
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9433383935;
	Mon, 23 Feb 2026 18:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="R2Mj60ah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1CA83BC9; Mon, 23 Feb 2026 15:25:32 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C0C80077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E3E9F27C64;
 Mon, 23 Feb 2026 15:25:29 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3dpd7wHv9ZEX; Mon, 23 Feb 2026 15:25:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1771856729; bh=fzZTpt3oD9N2capRbAJ97EdHI9ePANN0Cy7wv9mxPlQ=;
 h=From:Subject:Date:To:Cc;
 b=R2Mj60ahQUqauaZiak04gMWefYDopJwz77DSkiooDd7ka7efTy81zToSCK7ODcOod
 5OKDuVp2Z2sgZTKwuxUzNr51JmL9X2oOshGkDIYoP3dmnLuLQAaIVcwtD3J2RAzWMs
 UL5fZPhd4TCgf4UYqDghUh2gqrmLOQMSaA7XuD/GUpuoA+UVKwTQ/4/Z8ZrQHzfDV7
 isYm06lWSt598psAl3UjGJu/TptAOtUr70S//hcMuLOTOG80yklS9uOKnZ7n0o5i3E
 CB1fYwXAv2TZz+8Op3ckkyfLUNPChUNv13n8VE37EDQAJVLmzLt776wO8+/i9WMn89
 fekLXiry4ccrw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/2] Support for Samsung Exynos 7870 USB PHY device in
 driver
Date: Mon, 23 Feb 2026 19:55:22 +0530
Message-Id: <20260223-phy-usb-exynos7870-v2-0-5e91a25ef42d@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFJjnGkC/22NQQqDMBBFr1Jm3SmTYJrQVe9RXGhMdDZGMlYU8
 e5Nhe66fA/++ztIyBwEHpcdclhYOI0F9PUCfmjGPiB3hUGTNopUhdOw4VtaDOs2JrHOEnoddeO
 rKnZ3A2U45RB5PaOvuvDAMqe8nR+L+tpfzv7LLQoJjXOmJYrknX12LDml+ZZyD/VxHB+a/LZzt
 gAAAA==
X-Change-ID: 20251014-phy-usb-exynos7870-c2f2ac44fd65
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Mon, 23 Feb 2026 18:29:27 +0100
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
Changes in v2:
- NONE (collected reviews from Mattijs, +cc Marek)
- Link to v1: https://lore.kernel.org/r/20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org

---
Kaustabh Chakraborty (2):
      phy: samsung: add enum for variants based on SoCs
      phy: samsung: add support for exynos7870 USB PHY

 drivers/phy/phy-exynos-usbdrd.c | 271 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 261 insertions(+), 10 deletions(-)
---
base-commit: 5e7624979083e2bc163e18165452d8ead462b58c
change-id: 20251014-phy-usb-exynos7870-c2f2ac44fd65

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

