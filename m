Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37D5E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 22:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3981805FB;
	Tue,  7 Jan 2025 23:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736290595;
	bh=g3wWwMC/gHGJbqbpZPd/dtH6LeE59rP5ZBfwAF8XwNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=msYIrXdZQKbru24TZClm4Sf84uukBgLqJC4q4LDQOAMn/cGIeyF7c4UbTziv7HqEY
	 8NSA6tGcpOX7duoCFKG0CstEwih+UE66kGiib/VbZFpyCQuyWnBBSgbsLdLfZ2JZQT
	 tPCymB+udLo+roqaIfDV3s428cEpkwktg3J1XrAoVgJPfIjmlIrTKGSrz7wVA7h8+4
	 q6IAcaV0TitekP479qGbFrcEtwrXOeEr/rErWU3kkoHIDucVnC8zw+COm8+J2bV057
	 1k0zGMikCak6/LpSA3IZySq8DS2WHg+5AAJ7CiyRvRfmgMILhKg1xcMjsJn9wFOeAz
	 K/2quzQxJ3XaA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73AC1801FD; Tue,  7 Jan 2025 23:56:34 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A0C4803DC
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 23:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="OZpQ0T4H"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2394E101ECB30; Tue,  7 Jan 2025 23:56:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736290591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3wWwMC/gHGJbqbpZPd/dtH6LeE59rP5ZBfwAF8XwNA=;
 b=OZpQ0T4HxCFJJv/yx8f6i3EMJq3aZLlFcSZ62ZnQiFIxh4amNr17rQGOrEMss9l9f1QoTf
 dlMdtV3DoUhxmU43f+q+97tkNmmz5+ZqsdDX9UfnACZtaSsPGSFd+V/wi6/DXOvxzuW6LX
 hXmhbaHGrrsxsSe+hmhFT9w76pDJozY3DPMBnwBxlaoQkmDcRyjXYWJ04+hxyivhmN2Zbl
 aBrnWzuype5diSdonabPLNvWvix5mC3afP7RFcVuQsv+P6kkyoHXZOVRc6PCljIxPsW1jD
 nFSmJSjY6sqzAmHJDl4FQm+M/SPxi7BexKe0RyyxvGpCG+rqitp+3dp7tAPEqA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] usb: ehci-mx6: Use regulator_set_enable_if_allowed
Date: Tue,  7 Jan 2025 23:56:08 +0100
Message-ID: <20250107225616.195878-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250107225616.195878-1-marex@denx.de>
References: <20250107225616.195878-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

With the commit 4fcba5d556b4 ("regulator: implement basic reference
counter") the return value of regulator_set_enable may be EALREADY or
EBUSY for fixed/gpio regulators.

Change to use the more relaxed regulator_set_enable_if_allowed to
continue if regulator already was enabled or disabled.

Based on 335799b7252a ("usb: dwc2: Use regulator_set_enable_if_allowed")

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mathieu Othacehe <othacehe@gnu.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/host/ehci-mx6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index a93fa5d5455..a8748cef7ad 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -479,9 +479,9 @@ static int mx6_init_after_reset(struct ehci_ctrl *dev)
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (priv->vbus_supply) {
 		int ret;
-		ret = regulator_set_enable(priv->vbus_supply,
-					   (type == USB_INIT_DEVICE) ?
-					   false : true);
+		ret = regulator_set_enable_if_allowed(priv->vbus_supply,
+						      (type == USB_INIT_DEVICE) ?
+						      false : true);
 		if (ret && ret != -ENOSYS) {
 			printf("Error enabling VBUS supply (ret=%i)\n", ret);
 			return ret;
-- 
2.45.2

