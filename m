Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B20C98308
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 01:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 678074072E;
	Wed, 23 Sep 2026 01:09:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5YgcbpI1BhdM; Wed, 23 Sep 2026 01:09:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 69296406F1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790125765;
	b=N+//gLMUF2L4XR2dBT+1WFIlFeJ3EtR9ZY1Dlgm7EeK8lfCMZ0LlIlYEab0tVVAopij1
	 6AyzV04FwhtZMBn0f0S5RCRKmextSZJiKecpkuR9KgE6AJ5LhmsuS7CnxG5Io0UJ0TJGj
	 G2ACEQKQeldP15u80/T0uFyIFW45dIo8GLmYe5pkN2nwX9gF3bH1ZNo5m1CtFo0vCJq9Y
	 9O7zhHMC45N2d/EeABn5ReSBxEoW9w5WuYAIT4wtN+WJFG+RKrsqgcpPqEa0lNXZI1UBP
	 YMXt3ohfXlLZeEfRNMLARmACg5d+51y/paM1jJQiGC3JTQXGrOTjrfYa2sJrQjXpwgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790125765;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YjcnUSS4jUC2QZ2636qOkwl92a+xW+BGTdyGVeb+cmo=;
	b=h5otSlsXyBtC5wWl7CnGui1r2xCh8nxI6eU5uEFFKMnmGEK9EM+SjiyIuPTeqRZGDTUx
	 n/RqTvcYhIWi0K38stAHTyD7VT+Mrmo+MRUM6U7IzlpQ5SZqphKgc7jfBuZjZf41rbWbU
	 sKg2WEkVZ6fVaQ3pNAdtqNLWBqySH4+Q3bTIXhPtIZV82zv2ibocGfCD3aYGzUkthyXWx
	 XeiYUU2AktMhFQJbxCMGeCkWOWVTaB+QiKKYjcF4xoqUmYj832b0Yw7e3QJvLEp1FkHeR
	 dZEPPbxtlauyYwt4PRbEK0YDS0s1pnsgxvQlbpxRuSyLz6pTFX3bedGZOW/H+iEczQw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790125765;
	bh=YjcnUSS4jUC2QZ2636qOkwl92a+xW+BGTdyGVeb+cmo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pOV8T3vQ/Av3CtlNzB2o5DEQTRvn0AGBmQB3PBj1WK6TCFyxP4hPlFjvEqoaZ4jV/
	 1r9B5AGvQdR0qNGMvpfzNTEbRlCXjaE9cSAS3kfp9BYmQm0zAqrfdD/AcsUXZbqV6g
	 AFbVd8bGcnwJHtWp+ohm/nDDF9P/9v0Q+iXWD+2qMi3mYZorMpgiCs0jiwddiHlu5M
	 od2o9TBkfpfNtV9pAbPmCxyG6U3Aa1XPnnsPUnU3XWcHCqpXBWybnsZeiwm+zT5tfz
	 evXXC9fo60u1/T04iOBTkGod9boWFwY4vq+WcmMM+39/F5ARWo+lDGBHy/jvNy/Ur0
	 5Rvd0AJ5vKFPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69296406F1;
	Wed, 23 Sep 2026 01:09:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E24935A
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 20:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33FF5607FB
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 20:43:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VOPqQOMn8Kdq for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 20:43:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 311F5607F6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790109815;
 b=r7K8g/U8F0PjM6ov5x1chYmjvbmnbt9CsgB4MWluiXgb7rpni/hfr/G3WZLuId0b7+8q
 b5E1s8PQ+mNFXb7KsnXXolR9VmzXoj7NW/lyBsrexlgcS/6+YvyiS3ADBaVsDPPj+1LvE
 tU/YGbl5wB3dx2BGfdJ8AkeHSB036kSg/ludxKYjKnR+LaPdK4Ja+8YLKnoh8grX9afgg
 YoycdmXGqRqAamyWHMGK2VM6BlRD783BtD2cshORg0S1JGoZWgVzNDH2N7a6jcQQS1vBK
 o15/skviV4DZkxJvYfvmylf4e9JmdUmVS4V9+eNdeWGhefRm2dGsP+JDDBebBi8/eUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790109815;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=YjcnUSS4jUC2QZ2636qOkwl92a+xW+BGTdyGVeb+cmo=;
 b=DyC1BdvMUdq3l+s57iFbKl9vI31fBAbXKOmYbLuV79HLmsaRWS/CzO3tErK8Hrwf0uu/
 rSM74M/DfI9+Epi22+AJ/oN4mJ75qkg4QDGb9jYqsxMG1SD0thjI7NEbzqRaMQl4AwjD4
 dTnPfennp2MSecJANkbdXjnPA19TRVPF64CvU8IqK4WE2AzNKf/6iW8zJnm/kVTtCRxip
 hBA9wWYyYXUKWnQtI5/CPMFIPuQa7/JHtp0DtbUWEKWBZAkB8ZIHNvMZttrYiR6J532wh
 C0tupP98okoPrpFqEnf6qwIvOZzskKxq7BC4DIpWqfnsH1yjRky1Zcn1qtlyIKDAT5A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gTMHUnQo; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gTMHUnQo
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 311F5607F6
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 20:43:34 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so1163935e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 13:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790109812; x=1790714612;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YjcnUSS4jUC2QZ2636qOkwl92a+xW+BGTdyGVeb+cmo=;
 b=gTMHUnQopfyF9iiM9d1DlPycejCQ+Q+qKxW6cSNxc6EPrC0sZ+l3Mgmpk4mVkuqjLH
 VltVULiMH0JNI3IAawalNl7UzRnNtwV4Y5mRNfsjFGqJXhshhfYajJvLaCU8U3piwNF1
 xlWoWuhqu4tUgcKYGjhuYjjgXVZqhcXd9yq2YmsNA7xkxdyJ2HxQVAISV5ULe6UbtIEu
 kBQYZ3IDaRafY+qkB6eoAWP+18VPHPni2z2C3uWOO0eaOalQGEPlOzcMR5/f1JkTwUA0
 FOWgjTn6R2GfzqaobEVdCxPo5EuL0FnBMbxi6LI1KDDKIJtRa7wCdNBG2RUP0fKVPxm4
 Cd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790109812; x=1790714612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YjcnUSS4jUC2QZ2636qOkwl92a+xW+BGTdyGVeb+cmo=;
 b=LeK0BCa2MP62b2mLHmaFCKyJuFE5FljxNDX2f1ZCSmU6fC/CuL1NNL68LNIrgmqTA6
 CFWp4H6ExhlB7ZS8s1bsQ+YMvFAlla7hm0ZSv2NdKT8583/hQsc91ZP6lG+tPVLejNyS
 Nbeno/MRVNrxQ1APNdquTh7ozL7qOCOOeVidYnwwcBgMmBS04O/XUv6/Cx8B+GLcRtdm
 zAOwYP+bZGPW/K6bLvzgmjqJwiD4BMidKjG+5wd70ZJxM+x9H4OTwBPP9qMa+Y0L13Rq
 Kz9lMZL1LHaX48EpLVrK3C2hC+b7G7cdSVVxw2VxA8EPgCPdJqEh8tVcNh41bm/kOQ47
 OXTw==
X-Gm-Message-State: AFuF++n31DZvr8TcyuQ9VzuqkcfGnJ2r+TjE2GFJ1NfNd+w3U0PZDTkA
 Qp9K09N47s3IW65NlhKUbVlN36GxpBIeP4Jj5SzZvHjZ460JpWTNlPoL
X-Gm-Gg: AYBFou2JfRHNkmoEehQBeL8Y2TDrQJhrSln2xm2WHVGru7Zb81exbq787T81IwQZvtx
 Wj7yl4yl/ZPTW1WaD5bVVH3Gx8/1rRBPCeKGPGXmmEwxid2+4ISseNNbbkuxgFCax6SfcLal5ws
 1rxZ9xQrzU2mqXK5EohFZKJmgwoW28ks79vqy+y49Xph3PSr7IjMouOJd7fpUH4JTltUEWkPzM0
 wksfD9ByrESJG/DdKJZW6ocsGdSHIvkTuw+ZYGb5bfPd6V1/MaOf7PLbc6ilvuZcNrgw16rimJW
 JO4hvd+rLl8Ox3AfvNFAneDEHgOA7s+g3Ko9BwJBAwAXspZUQJHdItU0zUQBYBuEnke4Q/hMBsK
 bJnGc7qSSUUOOH5wvhwnn6gJkTpPKC2kOE7qeQ1mf/3PbIeEH1jd0oUjHjb5ShjxESdvd9Njr6N
 2I7Y+PJWfzEePsgFhhXJWnk/YzkeC/r2xLMh/9kQEHFjFn3i2kPY8vbgEv5JN9j1Dl
X-Received: by 2002:a05:600c:3115:b0:49f:ce73:7ab with SMTP id
 5b1f17b1804b1-49fdf34f6c0mr4389965e9.34.1790109812290; 
 Tue, 22 Sep 2026 13:43:32 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1a482bsm25922845e9.12.2026.09.22.13.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 13:43:31 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: marek.vasut+usb@mailbox.org, trini@konsulko.com, mkorpershoek@kernel.org,
 stefan.eichenberger@toradex.com, hayashi.kunihiko@socionext.com,
 Tom.Hsieh@advantech.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v2] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
Date: Tue, 22 Sep 2026 22:42:48 +0200
Message-ID: <20260922204329.311571-1-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 01:09:19 +0000
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

Because we moved to clk_get_by_name() for receiving the reference clock,
also ensure that the parent driver is a DWC3 glue driver before looking
up the reference clock, since the parent could be a bus or root device
with unrelated clocks.

Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Tested-by: Tom Hsieh <Tom.Hsieh@advantech.com>

---
Changes in v2:
- Check if the parent driver is a DWC3 glue driver before looking up the
  reference clock. I use driver->name as this should work with all
  implementations used today and I hope this is more generic. (Marek)
- Add Tested-by from Tom
---
 drivers/usb/dwc3/dwc3-generic.c | 52 +++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2356b3bc0aa..3c3ff4eb590 100644
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
@@ -63,22 +64,36 @@ static int dwc3_generic_probe(struct udevice *dev,
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
+	if (rc && dev->parent && strstr(dev->parent->driver->name, "dwc3")) {
+		rc = clk_get_by_name(dev->parent, "ref", &clk);
+		if (rc)
+			rc = clk_get_by_name(dev->parent, "ref_clk", &clk);
+	}
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
@@ -145,6 +160,11 @@ static int dwc3_generic_remove(struct udevice *dev,
 
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

