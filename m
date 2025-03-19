Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDC6C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 22:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0083F810F4;
	Wed, 19 Mar 2025 23:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742422104;
	bh=O0DtA49/EFv6lMPbUPy/w9ZyxiKcym/V04VPBvtA30k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HhiooIV2JX90yHmqa0ssmB6ICgtC6bR53ESI2iVAlIEweJCu3/TEJM98PQc/Kr0Cr
	 /+Tw9+lzes9f9rEDlj68feXN3Kg+cqGBtDJSodv96/2HjY1gUfj6Np5FudPy/XfZls
	 9ehJQ9U9pvV1Pl6czGsn2a7M4kqOcbM1260/nzvPXddgRKUs0eus6iQn8RIaMtipmG
	 ZdG6VV4XtKZsVoGOQrKbsROQWHko4Dl5bn94PhYrcUlDMcNUGa0ZU7gU1GEumDkvk/
	 P1C1DK8I3W7UKXCL3ldnkg9cHAZHwwmmTD4GrVXmFIrJA89FpwrFIM3zpdic4+HAvw
	 kfNXKUwgH1ZYg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5129A81101; Wed, 19 Mar 2025 23:08:23 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9AC2810F2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 23:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="bacycYEH"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5B93F101E9152; Wed, 19 Mar 2025 23:08:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742422099; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=O0DtA49/EFv6lMPbUPy/w9ZyxiKcym/V04VPBvtA30k=;
 b=bacycYEHH4SnTvh3wC23kYyBA1Ll7hnIxaQXcQiGBuxb07OlQbKqcTtI3HPySDHSXxpOaU
 ooUwL9BLQ5WXhTpKl26zHdQ3DsZ7ZBQQZJHicSTAp8/1g1EEDmlgJQ0QhDFQujbj+15y1W
 SVqqhx1ERVbmUyWe0zyhanKVXCByr4rC8E9Fu7SRhfxmVqY6s/NrsBtdmSqcflBgdUe4P6
 g2CzvfFm0szXmOZXwJd9AiFTOYJrUpVxAeT9DoKeyErvE4xlgZbBR4sVCR5gFPLlqyvL3m
 91l+lYIaRzCkgch9pB+g5+v/yUAELkTPNiAsAxRxZBCRMuh0vP3LDd7o2OKjoA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool
Date: Wed, 19 Mar 2025 23:07:52 +0100
Message-ID: <20250319220805.219001-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
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

The UUU tool excepts the interrupt-in endpoint to be ep1in, otherwise
it crashes. This is a result of the previous hard-coded EP setup in
drivers/usb/gadget/epautoconf.c which did special-case EP allocation
for SPL builds, and which was since converted to this callback, but
without the special-case EP allocation in SPL part.

This reinstates the SPL part in an isolated manner, only for NXP iMX
SoCs, only for SPL builds, and only for the ep1in interrupt-in endpoint.

Fixes: 1918b8010c32 ("usb: dwc3: gadget: Convert epautoconf workaround to match_ep callback")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
NOTE: This should go into master as a bugfix.
---
 drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e5a383407a2..477ecd02098 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1631,8 +1631,25 @@ usb_ep *dwc3_gadget_match_ep(struct usb_gadget *gadget,
 		return dwc3_find_ep(gadget, "ep1in");
 	if (usb_endpoint_is_bulk_out(desc))
 		return dwc3_find_ep(gadget, "ep2out");
-	if (usb_endpoint_is_int_in(desc))
+	if (usb_endpoint_is_int_in(desc)) {
+		/*
+		 * Special workaround for NXP UUU tool in SPL.
+		 *
+		 * The tool excepts the interrupt-in endpoint to be ep1in,
+		 * otherwise it crashes. This is a result of the previous
+		 * hard-coded EP setup in drivers/usb/gadget/epautoconf.c
+		 * which did special-case EP allocation for SPL builds,
+		 * and which was since converted to this callback, but
+		 * without the special-case EP allocation in SPL part.
+		 *
+		 * This reinstates the SPL part in an isolated manner,
+		 * only for NXP iMX SoCs, only for SPL builds, and only
+		 * for the ep1in interrupt-in endpoint.
+		 */
+		if (IS_ENABLED(CONFIG_MACH_IMX) && IS_ENABLED(CONFIG_XPL_BUILD))
+			return dwc3_find_ep(gadget, "ep1in");
 		return dwc3_find_ep(gadget, "ep3in");
+	}
 
 	return NULL;
 }
-- 
2.47.2

