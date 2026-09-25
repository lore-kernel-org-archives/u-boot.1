Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50943C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 12:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42E3860D4D;
	Fri, 25 Sep 2026 12:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y3kketoLBv_1; Fri, 25 Sep 2026 12:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4F5A360C09
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790338317;
	b=Fd+Ce8X+I+8aFDfj8U+S8CbhwU7BVLBc7f7PYnrZ3WcwdxkTyb9HVScCia5o7vPZSkRa
	 E4xlz9JQUWFlee587Mo2W6MAhJYhRJGh9o9W8WoK0cQTr7BN4/NwRlyeFQuOs+RF6A591
	 asnQt0dmvQQRyOntwd3402qVBCPzcf28NVdDubO9yfgNgPLlOI/DM5NFDdTxzMXFyj6Wq
	 jpb2wjLfpSCLjpC52AclIfANb05zN/GpEMpzNrHqJmYoQCYGrazMtUKYQwWEqddtYfnIr
	 /SCQu1ZtgJre+sEFMj4OKQ3Gl2CZoBQfgPjwe1iA4HRpKrPlZFHudpOfBPNPOETxzgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790338317;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SaTQv4KqpunHhVNgEV22qG3hP4Kmn+PgKhmesfQ4e2Y=;
	b=AGQEkaZPQ9r5sQ23Nm2rqdmUj0taiACoX15bNPHgKA1H2RLIileV7xXpkgjyJzEQx4B+
	 fE8W9SfByyaJH3jSmvvfs/a0Pahsh8XnWBIWNJlIGxGyOLYo+1garFHKW1GHkUsw3M5V6
	 CBLbNj+zBCVzsZrNIUTek8USr4+DrQSWI4nXV6xR7+YJjzmSS7kgCMVVWPrVbOnVZLHqi
	 Ev9p7CFY/XAXULh2O3HKyt6A5ibAu585MaWaG6h1RVJlk/Ygr3TQD3ju+fFk8KaXeihlO
	 XXyJYCISvjs2ZVEal+NKVIuSmKy7iN4LF+NMQ+F0AUqRnJ4B7T36P0K+UlzhMYU2DpA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790338317;
	bh=SaTQv4KqpunHhVNgEV22qG3hP4Kmn+PgKhmesfQ4e2Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ptvKhpJLsZsjURBRtC98IHfSTV+qhZ+UB4wQ1T80rRfIsyn/Drxp9MIGHmO4ERxqX
	 UWjDfzi0h4OkgHY166BOAvlMlRO6t3PI6H6yHTVV/Swurxt2PghugQDGTaezH7BoN+
	 KxztBEUVYSJlS7qnJxyMKKA+3Y+J3MVBeIu6AnZGVNi3Zdj4OHt1NzRfhVjIB/YUE0
	 llv0bwVTiOKGJwmS5d62W6txzC9zubdx1d14NPeVE8EGViVYD/tVLt2TRqxpzMwZkn
	 IFX6I0yA7avVptH3uQgXzUeDF+Kn+7fkl04xhZUVbJjRc0lBoIj2oHTK7qra3WMfdd
	 H8p/TNEMwn3jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F5A360C09;
	Fri, 25 Sep 2026 12:11:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 89E2F32F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 09:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F53340B20
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 09:12:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4eKSlXOZg2jQ for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 09:12:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 311E640B16
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790327531;
 b=tTaFfWysagIXG2f6BbpxL2owsXJNomsOYceQWnswS5seuKD+dBrgFZZ/vB5TKT8QQMDa
 9OjMwJ0V6hhbuWfsKvsa+iJZsUzX3jFAmyb5gGfB5sNWlHlSYQ4cAXdfGuwadR7o7wngi
 S3jbqDMZEr4lt1GitXS5fPk9j2WhofZo7TsSE/Wq+xCCoMJsc1oVxWzZRdRdnO15TxXeS
 tzTzYg6mfpM8AOEt54teq9dw0dJtcR6KD9pJVjSkd7SkMVhVKV+03dUIYIEys5ho3ssge
 s1Zui8QADX9QE5x/SUa0HkJchM6uGlKXc6FqOvENTVbO2LGblneWU5bKrHQuauhyNIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790327531;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=SaTQv4KqpunHhVNgEV22qG3hP4Kmn+PgKhmesfQ4e2Y=;
 b=d72ttNEyc/X3CF3XETk9v6SLpWThV+GZeCu8sWN6aVdOm1+T0bnh3HU7vladvBOXLhlw
 cMV4TYQCpw+cAdVcVK/WGGp8ZUtQNT8mVCsry1G5rNc/sZGKa/ofV+XI7ZFb9Fi3LuJNJ
 RUCNFnZzC+cGRUa+q+Tc4IzeFnlA1JwUNXICNXmAVI9uNX7HCaAO4blnWLrdZRYO+eHM0
 JHQkSCNxqVutaNMXsKYZqr4d7srPTDdmMw6NqYhHW4UxA5EntzwRlgQhHI7gSN7h1cR+x
 bba5R7tT6sYr0u2bVdZVDB1tetlGvZoXHomY6s3LEHfVUcnOeShHlfAihTo2DSXkhwQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Fkqxg8ei; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Fkqxg8ei
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 311E640B16
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 09:12:10 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so3801125e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790327528; x=1790932328;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SaTQv4KqpunHhVNgEV22qG3hP4Kmn+PgKhmesfQ4e2Y=;
 b=Fkqxg8eidjX0p7JI1Rq+N5nAh8ddNLlrVR58u67cLSjazvh8Ehw1Tryny54fiJygNX
 gPRUi1mIPkF848ODOZjUUeYcNdpxbXtoS3CG/ysbGKsiDTVRyWwDO6ma+YBMYd8bPjjq
 DFPLdQbjBHRNaeVlojvuBPR/seoARM4XqE1qwx7G3aQ7qaPtwsTevDzSP35kwowUL3g7
 8NkjoOsP8X8V6eU1uUNJiNJKHJohLucN4xoMVZEnA3Q7gGOlRQtMxsrFK84gktY+W1GI
 7RjdiW8ZR5j4Z5PUvQFNYaLxo7TMvBDTexUM/awoGFAVZ5oLDaEi5nM6ZWGwI3rUO5ok
 88/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790327528; x=1790932328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SaTQv4KqpunHhVNgEV22qG3hP4Kmn+PgKhmesfQ4e2Y=;
 b=jwSUNdDffl/c1S8odkoATDiFEE50jFMC4EUuHUb8L59DRJzp7o3sVH6pr+ls9cdRAT
 eXF3XHHDrMJc2zXRcuWd/XiU7gfDMvEm0w3HCkcVA3BPLKoBAX/ymk5HfgdosKCNCJCR
 71q7mkrz4GdGAmdBkjEmHrkIGdrHBOx8uFjrTwM24D9wHOeEh91zN3pzeu5wdjnU5kEj
 LwZMHmko1FS+j3ZUr0wABnmEVuEN/YVmANi9EAS/F42mImUSbbMMFkeMRZ3GCdx+ydRV
 FZQRdf6OSAtuTMoRT1mtqtLcFU76Y238xN60rokWrbrs/J5q2s4SX0Lck6YgPIV/0mX5
 j4AA==
X-Gm-Message-State: AFuF++nU5RYRIOWaJMKfBNPKvX0/OcQifIBwfUoqrVxn74akJlJ/BgLt
 N9k0IbjuLj43iQy2VK3sTBZUHvbv8e7drQW3gZ5592mU5UCraOypT6B7
X-Gm-Gg: AYBFou3xgFBM3kEruRF0IWsj4trbCEoPGmNPe+bwPhyKlcAvqxkHfV7YH6oRjX/k8O9
 5H1aVhFlQ3/zT5UHbvM/vVdPl6WOveUxH2XoUDn9/WpSMkcr01znE1P1EIePE0C6nHcH1gKsaXy
 DUDeAqEIoZzAWUotAB9SkPt6l8VR61P/W8jp2UZinww7zAZTSn/OzDcvFXqdtVMUPw+FCM8DPlO
 gfuSCZg8bVdklGtF+kRI0di0UPYZi96jCxfyF8izVUkv5EeWhiluxpuvzNkSKHNQEuaJQ0HNklt
 oWgZ2A8CmCPKTRX1HiXbMmb9k9DoPYXTjbquRuQCohqepW489InEPrQvQkSBUZPO1v4cYHXFI1s
 csUH7wEijrWJ4KtRiH8azLjpSf/b1+czDIGKdyUBUMNdSdE4Xbp+9g2zJg38OCdC9XZNTGaJUQy
 IvN44ieAI+9ZJVeq9nuLHIs3jIxrdpgQvO3Z73EeW4Yy7ttTbO9o+5eA==
X-Received: by 2002:a05:600d:8642:20b0:49f:e8bf:c38 with SMTP id
 5b1f17b1804b1-49fe8bf0d97mr53493965e9.34.1790327528277; 
 Fri, 25 Sep 2026 02:12:08 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe667ae2fsm131426595e9.13.2026.09.25.02.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 02:12:07 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: marek.vasut+usb@mailbox.org, trini@konsulko.com, mkorpershoek@kernel.org,
 stefan.eichenberger@toradex.com, hayashi.kunihiko@socionext.com,
 Tom.Hsieh@advantech.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v3] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
Date: Fri, 25 Sep 2026 11:11:44 +0200
Message-ID: <20260925091203.44385-1-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:11:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

On Verdin iMX95, with a USB hub permanently attached to the DWC3 host
port the hub itself enumerates fine but a USB stick plugged into it
fails intermittently:

  Verdin iMX95 # usb start
  starting USB...
  USB XHCI 1.10
  Device not responding to set address.

        USB device not accepting new address (error=80000000)
  Bus usb@4c100000: 2 USB Device(s) found
         scanning usb for storage devices... 0 Storage Device(s) found
  Verdin iMX95 # usb reset
  resetting USB...
  USB XHCI 1.10
  WARN endpoint is halted
  WARN endpoint is halted
  unable to get device descriptor (error=-22)

Commit c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in
both controller DT nodes") added a fallback that searches the DWC3 child
node's "clock-names" for "ref"/"ref_clk" when it isn't found on the
parent glue node, but always resolves the found index against
glue->clks, a clk_bulk populated only from the parent glue node's own
clock-names list. This is wrong since the child node's clock-names list
is not guaranteed to be in the same order as the parent's, and indeed on
Verdin iMX95 the child node has a different order than the parent node.

Fix it by looking the reference clock up by name with clk_get_by_name(),
trying the dwc3 device and then its parent glue device, so the clock is
always resolved through the device that owns the node its name was found
in. Also enable the clock before use and fail the probe if that does
not work, and disable it again on the probe error paths and in
dwc3_generic_remove() to keep the enable balanced.

Because of moving to clk_get_by_name() for receiving the reference
clock, also ensure that the parent driver is a DWC3 glue driver before
looking up the reference clock, since the parent could be a bus or root
device with unrelated clocks.

Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Tested-by: Tom Hsieh <Tom.Hsieh@advantech.com>

---
Changes in v3:
- Ensure that dev->parent->driver is not NULL (Marek)
- Return with an error if clk_enable fails. (Marek)
- Balance the clk_enable() with a clk_disable() on the probe error
  paths.
Changes in v2:
- Check if the parent driver is a DWC3 glue driver before looking up the
  reference clock. I use driver->name as this should work with all
  implementations used today and I hope this is more generic. (Marek)
- Add Tested-by from Tom
---
 drivers/usb/dwc3/dwc3-generic.c | 69 +++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2356b3bc0aa..93912d9c7f6 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -13,6 +13,7 @@
 #include <dm/device_compat.h>
 #include <dm/lists.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/usb/gadget.h>
 #include <power/regulator.h>
 #include <usb/xhci.h>
@@ -31,6 +32,7 @@ struct dwc3_generic_priv {
 	struct dwc3 dwc3;
 	struct phy_bulk phys;
 	struct gpio_desc *ulpi_reset;
+	struct clk ref_clk;
 };
 
 struct dwc3_generic_host_priv {
@@ -47,8 +49,7 @@ static int dwc3_generic_probe(struct udevice *dev,
 	struct dwc3_generic_plat *plat = dev_get_plat(dev);
 	struct dwc3 *dwc3 = &priv->dwc3;
 	struct dwc3_glue_data *glue = dev_get_plat(dev->parent);
-	int __maybe_unused index;
-	ofnode __maybe_unused node;
+	struct clk __maybe_unused clk;
 
 	dwc3->dev = dev;
 	dwc3->maximum_speed = plat->maximum_speed;
@@ -63,22 +64,39 @@ static int dwc3_generic_probe(struct udevice *dev,
 	 * - in top level generic node, with no subnode (i.MX8MQ)
 	 * - in generic subnode, with other clock in top level node (i.MX8MP)
 	 * - in both top level node and generic subnode (Rockchip)
-	 * Cover all the possibilities here by looking into both nodes, start
-	 * with the top level node as that seems to be used in majority of DTs
-	 * to reference the clock.
+	 * Cover all the possibilities here by looking into both nodes, the
+	 * generic node first and the top level glue node second. The clock
+	 * must be looked up on the device that owns the node it is described
+	 * in, the clock-names lists of the two nodes are unrelated (e.g. on
+	 * i.MX95 the glue node has "hsio", "suspend" while the generic
+	 * subnode has "bus_early", "ref", "suspend").
 	 */
-	node = dev_ofnode(dev->parent);
-	index = ofnode_stringlist_search(node, "clock-names", "ref");
-	if (index < 0)
-		index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
-	if (index < 0) {
-		node = dev_ofnode(dev);
-		index = ofnode_stringlist_search(node, "clock-names", "ref");
-		if (index < 0)
-			index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
+	rc = clk_get_by_name(dev, "ref", &clk);
+	if (rc)
+		rc = clk_get_by_name(dev, "ref_clk", &clk);
+	/*
+	 * Only fall back to the parent node's clocks if the parent is a
+	 * dwc3 glue wrapper. When the generic node is a top level node,
+	 * the parent is not the glue device but a bus or the root device,
+	 * and its clocks are unrelated to the controller.
+	 */
+	if (rc && dev->parent && dev->parent->driver &&
+	    strstr(dev->parent->driver->name, "dwc3")) {
+		rc = clk_get_by_name(dev->parent, "ref", &clk);
+		if (rc)
+			rc = clk_get_by_name(dev->parent, "ref_clk", &clk);
+	}
+	if (!rc) {
+		priv->ref_clk = clk;
+
+		rc = clk_enable(&priv->ref_clk);
+		if (rc) {
+			dev_err(dev, "failed to enable ref clock: %d\n", rc);
+			return rc;
+		}
+
+		dwc3->ref_clk = &priv->ref_clk;
 	}
-	if (index >= 0)
-		dwc3->ref_clk = &glue->clks.clks[index];
 #endif
 
 	/*
@@ -92,7 +110,7 @@ static int dwc3_generic_probe(struct udevice *dev,
 
 	rc = dwc3_setup_phy(dev, &priv->phys);
 	if (rc && rc != -ENOTSUPP)
-		return rc;
+		goto err_clk;
 
 	if (CONFIG_IS_ENABLED(DM_GPIO) &&
 	    device_is_compatible(dev->parent, "xlnx,zynqmp-dwc3")) {
@@ -103,13 +121,13 @@ static int dwc3_generic_probe(struct udevice *dev,
 			/* Toggle ulpi to reset the phy. */
 			rc = dm_gpio_set_value(priv->ulpi_reset, 1);
 			if (rc)
-				return rc;
+				goto err_clk;
 
 			mdelay(5);
 
 			rc = dm_gpio_set_value(priv->ulpi_reset, 0);
 			if (rc)
-				return rc;
+				goto err_clk;
 
 			mdelay(5);
 		}
@@ -124,10 +142,16 @@ static int dwc3_generic_probe(struct udevice *dev,
 	rc =  dwc3_init(dwc3);
 	if (rc) {
 		unmap_physmem(priv->base, MAP_NOCACHE);
-		return rc;
+		goto err_clk;
 	}
 
 	return 0;
+
+err_clk:
+	if (dwc3->ref_clk)
+		clk_disable(dwc3->ref_clk);
+
+	return rc;
 }
 
 static int dwc3_generic_remove(struct udevice *dev,
@@ -145,6 +169,11 @@ static int dwc3_generic_remove(struct udevice *dev,
 
 	dwc3_remove(dwc3);
 	dwc3_shutdown_phy(dev, &priv->phys);
+
+	/* Balance the clk_enable() from dwc3_generic_probe() */
+	if (dwc3->ref_clk)
+		clk_disable(dwc3->ref_clk);
+
 	unmap_physmem(dwc3->regs, MAP_NOCACHE);
 
 	return 0;
-- 
2.55.0

