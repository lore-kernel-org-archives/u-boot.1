Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B44C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 00:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E407180D9E;
	Thu, 17 Sep 2026 00:01:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E6MPBGJ9y8wb; Thu, 17 Sep 2026 00:01:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 589DF80E58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789603275;
	b=GBEQdjqxi5AHrjRiGIYKJada1XDSJMOHd1l8KiwFd6DpGpBLYf+2h0F/7PEwFLFVPeMX
	 djfhllxA3x1T4p7I8gM/SGaAKnTrev8hHYQa0ZxBLJQVTwEYUU8GpuU+qf5d2RaZ4oS7d
	 zSank9qjnhSrRabJXJkeEt0fZ/BaX7+MuaBTISyTRG9e6ORXw4aZSrhjKLIBqp8SSyGz7
	 xm0am+UohdMtfFOW8Np/Gly6cty+GPml6mzkSci1teBNC0WOUouXKtJzqN8t9RX5QtOgl
	 z2oqX5unkUykVpA7Puygg2DynA3ongkxGQUSLxdpEHC7dFrabdTtHVVt3ZlkSaIfKag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789603275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zrJ/6O7V02KN+Nn6DJADhN9QWqnb/HNf3Rhco6Jr6l4=;
	b=IUB4P3+P6XCTdPoSnpaoTY2xUH2h6tF6MjH8gL3jnEmK7t9kq6lPLQiH/bdLyTY1GK00
	 a2D5ioUXcftreYAj65nFNE4MmrE8qeIvN0dtXvkvnBNdhymJ1kuu1NZbZOd0d47dA2295
	 v/AVPI0aTSYteTZh9xc2PvxzsWHOFjzEUCYxm4op7j2ifj/1dP0KquZzYR0r1eoe1JQFT
	 DBoWJkBNdxWgXterizKM1T6VUD0P+V4roZ8nEV13FilS0aLtNAEAJX+etfOpTfmXNJiEU
	 mFxGmaQRhUiKO53hkbEeScrOmRtkWnLdY2aE8gjBjDn0CAvF2XG5Eot7LUnU3awcM0g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789603275;
	bh=zrJ/6O7V02KN+Nn6DJADhN9QWqnb/HNf3Rhco6Jr6l4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uNV3iSbpWJkIc+ZGxEegBUAVPe7Dulg9Q9t7+ahzQ+mjJ8dOHOJ4Fg/paJT+S0Aio
	 4C82IK28onikIQhIw9vRlSBWpFxjBYJ3abEUQfGFluGTMLsaT9gpgJuWNvAP1Z28+F
	 oFkLsvd4QbJVcRS0wl4N8hmD6LUw4ifv19+mVFR8Sq72+7sNC+cq8YNktjSan2dwfm
	 CXzoqGM934u7bSfM8u6tjHs5Bnjfbs6eer9A0eFu5EPsrazBKzDBnT9IlPNTb6/fez
	 g/77FieEStvXhQsg20Wmz5LTKKKK9TOVNhL5mV2JetzwEtsbO36PBgouyKGw2Xb/Bz
	 rNUxpqcwk//SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 589DF80E58;
	Thu, 17 Sep 2026 00:01:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E71057AD
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 18:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C49A160756
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 18:20:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mh09MJXNC-aJ for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 18:20:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 793E760668
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789582819;
 b=hhdVsMBnjSFIQ04oQuMoA4RvNib7JhsPuvG9wHScvVFlbN+vmhkXHAvQ0HbS8rLsPKaN
 MzBEgHxFuQBeGeqMkcWHtN6IlTjH54bynKxfwH5I19h2zqJ8DONr8xI6NZXQlb0VdMCl7
 5qOsdSk1B+IlMsd1NcLJASGDaYR+hQm5OukZS0xTnPKNtw+yWISvYnmf3vJW8dwzMGw1K
 RjjK/LX6qHENlR+D0npCl2vA0NhAQVnOQCT2Y9gqdiPL0MKIKAQfnz+JlTk7IqHWjFY9I
 Bf6fspo3KS120tpkY+pjSIZ5h9PsOzVe0UU6pceFzo74pjS0AWgImHZk5WK/uIKYRdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789582819;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=zrJ/6O7V02KN+Nn6DJADhN9QWqnb/HNf3Rhco6Jr6l4=;
 b=W+q1E2q4FUCuT3KRnMtubbRSJg5YAhMWKUVZdN0/nHUSKJC4E8FO90twxvVfGr1/+Isc
 aI1r+Ot57S9He7f+oIlsq85rq4OuzLlBhDZRypbV3uucMah/shWqsOUu+i8HG/08Bbrbc
 g06zfvkRp0cY0Wi2P6ZwAYoojODE9W4U1ks4F83UnxJHMAXvsmCjXzF8RRrB4oUXNJyiY
 JlnqH45yobnoZf+7qXaq0Kogd4wNrR749t+in5d4E1yDA2JanPm0Aa0ZKGZ5sNXGX+Cdw
 LtTK/osluY5BUFR3ho5Z5UcCrncdtXhCTWsJ0tNww6+lgUMaFVQUeT7DXCkYeoEB0qA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cS3RTT0S; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cS3RTT0S
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 793E760668
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 18:20:17 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so23427f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789582816; x=1790187616;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zrJ/6O7V02KN+Nn6DJADhN9QWqnb/HNf3Rhco6Jr6l4=;
 b=cS3RTT0STXiOHUU5NiA6udUffeq2tYddwEINZj/JOjlx1gWlGXzqPTC49qVR7OgbO3
 POyuzRqZtGnZ8gE9HVRyABXd08w63unKb7oESdDs3yYHEya/xLAO/XoZyCTiP0zbm2QA
 FlpuVVy06jNFX9ANBgOGs25CWHycJrmLZk4N2KR8POjAWqYfBTCygVRmEezSRkh0AX9q
 kUBhYdLfj/nZoezXp+3KwFl0tz7VdeBpZnjoHjgNyB85N8kCzIllh8vjBwHy3+x3UQLq
 8q4QrXFYMN620DP5ejqzdmuDdbALbshNFdm/UtE+shESuCZvX8B4CMig2AEI+VVHIjW3
 RIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789582816; x=1790187616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zrJ/6O7V02KN+Nn6DJADhN9QWqnb/HNf3Rhco6Jr6l4=;
 b=DKwP5hGwCiyCEGbu6F0Vaysp6D8DltF38cB5VvANWy2Kk8KJrXgxZVYPCYdGQErH/A
 vhC4Uktzooih9mz10EldaMDtgMmbLKnD1ghCKfgY9jvEXzi8hpmukEpYYc1q4OEVChzU
 kWxBXxxpWT7VcN9aqPVUpTmC3TH1MBdDy90SGI6exzAgu1p4XnLeb0MgchYa8HQSxDfu
 EogENJU9lqK1Ess4AMmYt2XmoCvbX0XAtJFCkVy27cn5ntO5WjQcX7UPMGNYju4vR5wl
 aU1TQk6wbDtsFPWTmNXC8FSPy0gbFq086yh/r1LzFu3Lf/ZC8WbUCijCZSVH8wmzoA1o
 SvYw==
X-Gm-Message-State: AFuF++kGKdE8QuIKB795iYgOAa+ZKkDspgCpQJ/CV5c+j9z+beaNm8Yn
 CMwhge0JjLiTqYL2YMiB5tEkA5KKt2v6SpliVkJlk/K3c+sQ4gIgZmLEk0fp/OS1
X-Gm-Gg: AYBFou1OE6N764gDOkblxXDOEmJQarblMQYnawGWPt4KO24DabWeaQPdbpuUEqFqXep
 B5o4/c6AJyzr+3c3WmL23SydjJ8dcEjPC2hCcmSDFoUXtDzloxrgzpWhqxM1xf7TwRKRMtjHvgb
 p1fOGktW2XR/1B7lJZSN/nQgsOhQleozH0VHdKDfQYqy7rWO2ntOrPlWpSdQglcqk+JAFoG0+cj
 0WtxFVR1br5ACA/h4jZfM91/iZa0asNSQZL3hzaDOHhD+g8hDN+70bDfN7ZhgPGp7Qa0MkjF4i7
 vi3c7gYqneFS27M2rRiDwKgvaMIAUtnEl/P9e3oR8eFlg5tWQNbrREXnqADk9LWWTnZh9lYlNQu
 E1t8OK9nKOXYs1Mqs6msz6axazUd5+u5LpnNkUUXqAblPz/4DasuMNFo180Ib1zTQFXZvjURK1u
 eEKrzMHYj5jJrJlFoEahAq3k38BTnZpOtU3I6IdnZk/buI9ngb6plj/A==
X-Received: by 2002:a05:6000:2312:b0:487:355:4619 with SMTP id
 ffacd0b85a97d-4870cf273d4mr5119826f8f.4.1789582815915; 
 Wed, 16 Sep 2026 11:20:15 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bef766dsm8584654f8f.4.2026.09.16.11.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 11:20:15 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: marek.vasut+usb@mailbox.org, trini@konsulko.com,
 stefan.eichenberger@toradex.com, hayashi.kunihiko@socionext.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
Date: Wed, 16 Sep 2026 20:16:41 +0200
Message-ID: <20260916182012.151031-1-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 00:01:14 +0000
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
in. Also enable the clock before use, and disable it again in
dwc3_generic_remove() to keep the enable balanced.

Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---

This patch was originally part of this series:
https://lore.kernel.org/all/20260914074314.12522-1-eichest@gmail.com/
Marek asked to split it out, as it is a separate bug fix.

---
 drivers/usb/dwc3/dwc3-generic.c | 44 +++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2356b3bc0aa..2982a91e3ad 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -31,6 +31,7 @@ struct dwc3_generic_priv {
 	struct dwc3 dwc3;
 	struct phy_bulk phys;
 	struct gpio_desc *ulpi_reset;
+	struct clk ref_clk;
 };
 
 struct dwc3_generic_host_priv {
@@ -47,8 +48,7 @@ static int dwc3_generic_probe(struct udevice *dev,
 	struct dwc3_generic_plat *plat = dev_get_plat(dev);
 	struct dwc3 *dwc3 = &priv->dwc3;
 	struct dwc3_glue_data *glue = dev_get_plat(dev->parent);
-	int __maybe_unused index;
-	ofnode __maybe_unused node;
+	struct clk __maybe_unused clk;
 
 	dwc3->dev = dev;
 	dwc3->maximum_speed = plat->maximum_speed;
@@ -63,22 +63,29 @@ static int dwc3_generic_probe(struct udevice *dev,
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
+	if (rc)
+		rc = clk_get_by_name(dev->parent, "ref", &clk);
+	if (rc)
+		rc = clk_get_by_name(dev->parent, "ref_clk", &clk);
+	if (!rc) {
+		priv->ref_clk = clk;
+
+		rc = clk_enable(&priv->ref_clk);
+		if (rc && rc != -ENOSYS)
+			dev_warn(dev, "failed to enable ref clock: %d\n", rc);
+
+		dwc3->ref_clk = &priv->ref_clk;
 	}
-	if (index >= 0)
-		dwc3->ref_clk = &glue->clks.clks[index];
 #endif
 
 	/*
@@ -145,6 +152,11 @@ static int dwc3_generic_remove(struct udevice *dev,
 
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

