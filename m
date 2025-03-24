Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BDDC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 14:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E630480548;
	Mon, 24 Mar 2025 15:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742827216;
	bh=paMlHOOHeh9FRYFRQSoBqpRBiYZ5N6H4D8f12eY27ac=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ceLCpYrNOBZILF8zvenfnQTxxyYogRhow0RwhnR5YX2iS/T5ltUH+R2f3Ra6N/Eis
	 BFTZ7svG8WaEy/5EsstGcJs71EFe0Gd4sYvdQTCKQWMtwn4vmnPKjp2KT3DF2fJ/ev
	 qnokh0vBJDf+1LEI4ZJ+GaZafMualCdo7KHGM50FZAMd76DDd9nzk8RbUPY3JN7zoC
	 zQsBxNvDIVIcFLAUrWW2kq4o8YQxb31WFuSMZiyMEmOdzMQT0Oym2F9Kp/fcmBWgFi
	 upjLOae2fXqpZTUrDSz+BwbrcE0SFGjpuqHd8WSGWw6OqKuVVXoRBdDGI0WcW+VkYU
	 NEe9H+fKcrbTg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F2E805C3; Mon, 24 Mar 2025 15:40:15 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B93B280107
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 15:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FlLzDM/g"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6EFD11029025F; Mon, 24 Mar 2025 15:40:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742827211; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=paMlHOOHeh9FRYFRQSoBqpRBiYZ5N6H4D8f12eY27ac=;
 b=FlLzDM/gaj2G90n5ozZ+oyj92A1gxYgE2Qemo8s/PfE8q4rFrgH1vUUivnwySJzrV77TaO
 d3vs74/xfTtKBDZw44BnZ3HrWKR76kDvzWSWafBGvoFgUdoEFEpMMk3cVHzR9ZBLNNBsoh
 Qz3pKUP2BgUpxUZNjHvBr3kgCGpI0FNGbKRR8cBWDC9QDLQO4aG9qif7ij5NGJETEq5qSQ
 l6knl4wtRDWQT9r07J6l3kZHDmZb5iRu2FRjwj8sL+8aUtXR6N5A+VR3NBNGH71gCibp4v
 rg2ui1x2SU4i3VIIS19weJvxM9WXyqXeQh15g9x4LeeyYupdb+6X4LTOp8E5Cw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: dwc3: gadget: Fix excepts/expects typo
Date: Mon, 24 Mar 2025 15:39:43 +0100
Message-ID: <20250324143956.91791-1-marex@denx.de>
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

Fix the excepts typo to expects , no functional change.

Fixes: 0916053ebc56 ("usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 477ecd02098..2b01113d54c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1635,7 +1635,7 @@ usb_ep *dwc3_gadget_match_ep(struct usb_gadget *gadget,
 		/*
 		 * Special workaround for NXP UUU tool in SPL.
 		 *
-		 * The tool excepts the interrupt-in endpoint to be ep1in,
+		 * The tool expects the interrupt-in endpoint to be ep1in,
 		 * otherwise it crashes. This is a result of the previous
 		 * hard-coded EP setup in drivers/usb/gadget/epautoconf.c
 		 * which did special-case EP allocation for SPL builds,
-- 
2.47.2

