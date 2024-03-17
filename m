Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B92C54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 04:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F8F87B71;
	Sun, 17 Mar 2024 05:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XcoFXiXm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jU4dA0Bs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7359887D09; Sun, 17 Mar 2024 05:44:31 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC2E87B30
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 05:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Ty54F0smNz9sWS;
 Sun, 17 Mar 2024 05:44:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710650669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rq4vRXvKLPE6i0i8x8OsN20yi14milVEaRngyYGfXBM=;
 b=XcoFXiXm0BZVVy+dZv0gMRvu3/h9oH2Z6HRXnD4W/Wcc/TD0CPFI8NWHcCe/ZJcmwgHo3s
 aqj9MbZ1A1o6XJ3r5x2Pfz85mjEjfNBZVIuXJKnLmL+22c9Sm3pI4+OCGqyrVWNWj/lwg6
 U1Fu8q1liVZVMMR7bfkI1TAJRSQ5XnOEPediv5PviuE2GWnRy7av6oK+ve0lfROdHFxCtb
 +GSsR89qqIGoE8fVjX8aS80WsmKiG9ySFfktF9RL1ro8KTyUCGfK6/dy/4+v+gWMyx6ph3
 bIVylfTpipcd/KWNhaO151VkF6zNB/h9is9CQXJ07V1ZbwlKB03vCWfiy8NTdQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710650667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rq4vRXvKLPE6i0i8x8OsN20yi14milVEaRngyYGfXBM=;
 b=jU4dA0BshxMGoIAWUhb11ZYWkZ+wST8c078sG5WzU/2Dt+WTWOZ74FSFQwges8PJukRSJz
 udd2x2Pyjp7eyBvggIPDEhvu/YtF8HLueNfoI6C4bM75LcyOTOrgeLnN8adLKRMnRPow6g
 8yn5uegkuWEBRWkJOVR3rxamEMBrCofwksChkajgH1xr384zJch3EL617oqrBasCC4AoPc
 32fsaFm8t9/LKhbYoXK22m6Zfjrq6J6PJ9usQA+Gqz8owhTebqJEeCMakiDbnN014WPXcF
 +hH6fqSrRZmYDeClfrO7XY/XxPKgw2uSOMrqwvbLB8MW3EJmFLnwCk681JM1XA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angus Ainslie <angus@akkea.ca>, Caleb Connolly <caleb.connolly@linaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm
Subject: [PATCH 2/2] usb: udc: dwc3: Fold dwc3_uboot_handle_interrupt into
 dm_usb_gadget_handle_interrupts
Date: Sun, 17 Mar 2024 05:42:53 +0100
Message-ID: <20240317044357.547037-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
References: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 333chcoppd4o6wwx7gin8hod3hbmx7aj
X-MBO-RS-ID: e9c5129c0132f9233a0
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

The only call site of dwc3_uboot_handle_interrupt() is the
dm_usb_gadget_handle_interrupts(), fold the former into the
later. This makes dwc3_uboot_handle_interrupt() unavailable
to be called from board code as well.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Igor Prusov <ivprusov@salutedevices.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Bosch <stefan_b@posteo.net>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: kernel@puri.sm
---
 drivers/usb/dwc3/core.c | 27 +++++++++++----------------
 include/dwc3-uboot.h    |  1 -
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 09737be9a9c..96e850b7170 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -988,18 +988,27 @@ MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
 
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
+__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
+{
+	return 1;
+}
+
 /**
- * dwc3_uboot_handle_interrupt - handle dwc3 core interrupt
+ * dm_usb_gadget_handle_interrupts - handle dwc3 core interrupt
  * @dev: device of this controller
  *
  * Invokes dwc3 gadget interrupts.
  *
  * Generally called from board file.
  */
-void dwc3_uboot_handle_interrupt(struct udevice *dev)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
 	struct dwc3 *dwc = NULL;
 
+	if (!dwc3_uboot_interrupt_status(dev))
+		return 0;
+
 	list_for_each_entry(dwc, &dwc3_list, list) {
 		if (dwc->dev != dev)
 			continue;
@@ -1007,20 +1016,6 @@ void dwc3_uboot_handle_interrupt(struct udevice *dev)
 		dwc3_gadget_uboot_handle_interrupt(dwc);
 		break;
 	}
-}
-
-#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
-__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
-{
-	return 1;
-}
-
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	if (!dwc3_uboot_interrupt_status(dev))
-		return 0;
-
-	dwc3_uboot_handle_interrupt(dev);
 
 	return 0;
 }
diff --git a/include/dwc3-uboot.h b/include/dwc3-uboot.h
index 5f13f5bcf40..3689d60ae7f 100644
--- a/include/dwc3-uboot.h
+++ b/include/dwc3-uboot.h
@@ -45,7 +45,6 @@ struct dwc3_device {
 int dwc3_uboot_init(struct dwc3_device *dev);
 void dwc3_uboot_exit(int index);
 int dwc3_uboot_interrupt_status(struct udevice *dev);
-void dwc3_uboot_handle_interrupt(struct udevice *dev);
 
 struct phy;
 #if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
-- 
2.43.0

