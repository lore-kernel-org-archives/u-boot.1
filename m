Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1049EC88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12AE980E05;
	Mon, 14 Sep 2026 14:17:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bDiZQN_j1mwN; Mon, 14 Sep 2026 14:17:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1AD7580DFD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395439;
	b=SZBOn8cEkAIAASbFC6AK7vBwNyVUOk7EwXiD4LVTLZLBZBDi3HJzhGtU+PnaD+ZVGO6D
	 QTw8uWBntXVSOaDnRcAt9DbFGeu9RLVIOmD+kEy11njAOQwMAKPfrdv7qkHz6kNXx9KKz
	 0UmSI1sNm4CktIgfYexNAYB6mMHtHYaCg1WomDnrrtHFkepxk2PGbBKS9BNWkGhb6WMFA
	 yeX08Z2Y/n0SGeLZTcLN3mgvyaM/2hX8jWFczEQfbdV/5Jq8tWJcOnV1fmB1ShdGdqWXJ
	 c6z9ffkidGb/4Bdyer6ypNBGRZ4MKExkL+JEn6h/1DU/hzO5v+D96MDBaf1zWWlJIqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rcxd0baELwlQFQQqGo9/8xTioP2MBqXUqcpIXVYC1oY=;
	b=iYXrHBSSNzKQdQ9ktOQgrMG95KhIBGbn/wTHr1eO4SLKX+36mZCuboiT7Uyo6WCCaHPL
	 8HE6WMMeFKI5+kVQi8T7wMVh8T91LJ0VlwmU2Kb/Sbi62J3Y+foi6Ydz7RshHH48gaWW3
	 L0r2kFKnnm8kTe4Jxde6emhRPml6ZRHNRjHiyB8ZEXpvUDTK8rYeZvV/2sgqO69NzW46l
	 xAfF5OVknDiVma6YironLfGoaywdUWxnQ7sbOSMjyrhobgvIvAx9YPn1sILn13y6KlfWb
	 UCRDLr9kn679CAxqzUbSzOro5DXUsNNOKFEdbfZgqJgsBLp/piScaRD4/wSZmy7dsJQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ydwi0pAI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395439;
	bh=rcxd0baELwlQFQQqGo9/8xTioP2MBqXUqcpIXVYC1oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ibtvVrISLyVPNUH8sprEMNwDYVE5P6z21Afp36t9D8jzTiq7Fk8wowFg7VE5dhdFs
	 N4uF9LDaUVpOwWfyylSPQQgvaAYa3ZrtKCUZ4SrZEW1KWt8xk58Ltm9cLLpkuzHvtH
	 /TKBiDQr4nWfZnun8OF1fln7g++zqgVYyh7/UelT4phVSf9CBKKwxVIpoGuzutQuz0
	 WVxIn8YBFN8YFru6mykY83or3/SQdQGl+RAJL60KNLRXTyc7kyV/zh0pn9mL/Z+kZJ
	 pyD0bGLQjn3zKU/EWi9pFw7LdlV9U9Y5Sd+TXVrGKTBDZ3pQWhmfiZFCaUrgH9Tkr0
	 xiCc/XNzlvqWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AD7580DFD;
	Mon, 14 Sep 2026 14:17:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DEB013AF
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC66080C0F
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H1I9BoMFe-Wu for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 07:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C2A9980A79
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789371807;
 b=kyboHbrjhJPLRdvrxwzjyuxHuXruLwMl97Ml1vP6h9LD4xlOluc0kadeDUkV7dKekw90
 Jl+sminUtLy3NDbRLTtrIAiHFgUcg3qapVhP7ULLAwxpcQTn6Jmo1cIV9jy6Xu/qijWOv
 BvJCnS00XXGlWbj8U0KfC3Zbelh8zeoDBCvGcENeBSmftOa7SoIXRGHwRK76GxMOPax2M
 7pjarm6CKSiTtKcyKKH41Djeel2cQOibpEkEqgco9r7M7NDz+RaVlyszLzJGtF40Tm1wL
 AyLjjmcnJZS4qdKeSyuz+szL6GOxBvePCJQqSIclyZGqkxt5kCHgG7PWboXeHaA4dAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789371807;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=rcxd0baELwlQFQQqGo9/8xTioP2MBqXUqcpIXVYC1oY=;
 b=JplGYpGkGl1S2OJhIknrZhjHCAYO/tZ0a6jHU7TY+iOMSIkkKztifefmC8uyLqw3mBGY
 bWoXbSXrBhCWBZ4NYHIJhucs3ZKKI44SpHeLaV9vMQs2sHLhBuSjdgv4RV3CueieuNIq8
 OIxEReeW9XhnqY4OtBAx+vyB4kLGZ5ve7ETi1OZSZmlzGgnWEyhrv5G9XojI40AGrCwFH
 O7qaYm8oSBby4gRtOMXPpZ+upouqrfahQHy1+W87Dmq5jh3d8Q/WAeDLRnoYcBwHV9ID4
 fBnP1O2q5BEl4kO/dMVuL/pRj9uxk76Q43pmc50bfI1CNlcUwLIHY6x7sydy8KX96pA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ydwi0pAI; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Ydwi0pAI
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2A9980A79
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:26 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso4878815e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 00:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789371804; x=1789976604;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rcxd0baELwlQFQQqGo9/8xTioP2MBqXUqcpIXVYC1oY=;
 b=Ydwi0pAI0+CSxMPLyUGPH7PFcfgsQcsnO9XQEkFSmP/8GEaUMu132+xTiGVIh9Dlmd
 N5AEYf9EhYuL9RFOScwEJ5ZMBJduIS9ukoV2M8bR3YE50l4jI30vbXj8+L9ZN4BzFz3A
 HFyPZvCn3xlFyxpsBtBVb+uSu8S8vw2isOQUTjOolLMnSh9tt0bYvnEUVX2MIHzhvwf6
 eN5pgTLKxdLDqmCmO4kDGUK34tYYcNf8tLWosq+oPT+dBBDJhJewre3GrBdvnnwBp3rY
 E5dTQR+zpYoo2nGQDio4LsIdHua6nq9Jc+pY2z/7dyHQ08UNGXdITnA06EMwQsbe0SSU
 A1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371804; x=1789976604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rcxd0baELwlQFQQqGo9/8xTioP2MBqXUqcpIXVYC1oY=;
 b=ODifBzkjW5V87N5REmvza4a/ynQ1zHcWzGFHXQPlgcFvJ9jXldHUNv72v3xEr3BCtf
 nCnVA0EN5osiqOVgBH0xs8RA1YORTmYbC1du2UKXCIQtwUvjj2tq6unAm7gZ7W/1sSEZ
 g5HTcZKoHnqq8D6fYn4PdJvb/uaMbiLPyoXCSXTXzLqoL3/nDxEDWNGNytMP6KSvlmYT
 aNbCOdX8gxjT2+sFjkxUKZzmFEGZJjXSV6koX2sK8HBAmFANa99l7SU5Ef6qNdTK1zaP
 Xc+UDuMd3Yx7sb9/rbIWB8hrsnU2cYQT3oC/VsSmGdINSWhmxjnkQySZmhHhLT4QLHQn
 Y8pg==
X-Gm-Message-State: AFuF++lVYnmC4mmuatdVFn7CCHDGaA/gyF0hvSjQlhsc9HBq9IamVnM4
 5hV7GReth3qNlEomO7nFJDSUBoD3lQUlodbKDZ4w6xVnY5nelDfIxe+V
X-Gm-Gg: AYBFou1Lha3UayvC25Wz+x/4r2rqrzYs/d3uEZVw57wpSy6CQ2E7AstdiPeoxjLwhOY
 dkf+gbGjlvYyA30ew6W6cN4Y5kZzNnZr95nxUew2jSo2834sLwYRWwj5nf2oFrkQxxDQNyZ36sJ
 yPjrUgF5qGI3hUabmuICsC3LnDcauYZRs8GbwSn+4GUWIhNY6j7ZA2zNyjfZcv5kObUXwqIyRTu
 QDY3qNQ39epP34y29g3RK7JrVhU4Zox52TKo/D+y6w7V9BTm3TYVfk2ANJxXAYknJa3pe5sFLa2
 M5mOGgGXQp9ntaS0XkDaRLz9vziLvwXiWzwhivpvCIx+BIV+RSXLEz27F10/jRoQ+qgppgIjlpt
 fKM/gJNIG8Ek3i3h2kcT56zuTVLC/T2pvLjeCiIhLp3s41ujWZh1lWhuYVmAG3H9Dt0Euw/py0h
 4e/kG3XPAOcFB8P8GNM9CXLoeNtNNj6GjUS56SUbUqYy61GUIBCd8pWkJ5V+xPGyyS
X-Received: by 2002:a05:600c:3e1b:b0:49e:6836:5386 with SMTP id
 5b1f17b1804b1-49e7a5fb97emr14979975e9.0.1789371804047; 
 Mon, 14 Sep 2026 00:43:24 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02c92sm184611495e9.2.2026.09.14.00.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:43:23 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, lukma@denx.de,
 mkorpershoek@kernel.org, antoine.gouby@toradex.com, alice.guo@nxp.com,
 stefan.eichenberger@toradex.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 ye.li@nxp.com, xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 3/7] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
Date: Mon, 14 Sep 2026 09:42:45 +0200
Message-ID: <20260914074314.12522-4-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914074314.12522-1-eichest@gmail.com>
References: <20260914074314.12522-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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
both controller DT nodes") added a fallback that searches the DWC3
child node's "clock-names" for "ref"/"ref_clk" when it isn't found on
the parent glue node, but always resolves the found index against
glue->clks, a clk_bulk populated only from the parent glue node's own
clock-names list. This is wrong since the child node's clock-names list
is not guaranteed to be in the same order as the parent's, and indeed on
Verdin iMX95 the child node has a different order than the parent node.

Fix it by looking the reference clock up by name with clk_get_by_name(),
walking the dwc3 device first and then its parent glue device, so the
clock is always resolved through the device that owns the node its name
was found in. Also enable the clock before use, the child node's clocks
are not part of the glue node's clk_bulk and are therefore not enabled
by dwc3_glue_clk_init(), and disable it again in dwc3_generic_remove()
to keep the enable balanced.

Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 47 ++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2356b3bc0aa..704dd242553 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -31,6 +31,7 @@ struct dwc3_generic_priv {
 	struct dwc3 dwc3;
 	struct phy_bulk phys;
 	struct gpio_desc *ulpi_reset;
+	struct clk ref_clk;
 };
 
 struct dwc3_generic_host_priv {
@@ -47,8 +48,8 @@ static int dwc3_generic_probe(struct udevice *dev,
 	struct dwc3_generic_plat *plat = dev_get_plat(dev);
 	struct dwc3 *dwc3 = &priv->dwc3;
 	struct dwc3_glue_data *glue = dev_get_plat(dev->parent);
-	int __maybe_unused index;
-	ofnode __maybe_unused node;
+	struct udevice * const __maybe_unused clk_devs[] = { dev, dev->parent };
+	int __maybe_unused i;
 
 	dwc3->dev = dev;
 	dwc3->maximum_speed = plat->maximum_speed;
@@ -63,22 +64,31 @@ static int dwc3_generic_probe(struct udevice *dev,
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
+	for (i = 0; i < ARRAY_SIZE(clk_devs); i++) {
+		struct clk clk;
+
+		rc = clk_get_by_name(clk_devs[i], "ref", &clk);
+		if (rc)
+			rc = clk_get_by_name(clk_devs[i], "ref_clk", &clk);
+		if (rc)
+			continue;
+
+		priv->ref_clk = clk;
+
+		rc = clk_enable(&priv->ref_clk);
+		if (rc && rc != -ENOSYS)
+			dev_warn(dev, "failed to enable ref clock: %d\n", rc);
+
+		dwc3->ref_clk = &priv->ref_clk;
+		break;
 	}
-	if (index >= 0)
-		dwc3->ref_clk = &glue->clks.clks[index];
 #endif
 
 	/*
@@ -145,6 +155,11 @@ static int dwc3_generic_remove(struct udevice *dev,
 
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

