Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CB4CCFA04
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 451E083981;
	Wed,  5 Nov 2025 01:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gfCe8i4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3089839AD; Wed,  5 Nov 2025 01:07:58 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A1383957
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0EF4240408; 
 Wed,  5 Nov 2025 00:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762301276;
 bh=g8OnhpSPGj7eQRXos2StG/pH2m9xqAt6U8jqMtLWDFU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=gfCe8i4/+7Eywf53Wt/VDEcegPTenT33gqfKEOXaH8lGgK4+o8gJxuT4/N71pf7xF
 vmRXmx3f+00yxYdC5IckVJjWKxcyBBBGn9Q0n+qg3GHpe0RXomdNuquEVzov5wxIlx
 drDIfKBQ0UDyf0ITDiWZ7tnhONdIwUr9V5sn2hqLc53SvzrByLQb2BxftwjbxlKNfT
 YPi4I/Q6T0KvlcckAY0CkllGiCcifY1SWKzx1cr/gn930ppMRdJrvJUF8I2grMK/u9
 JUlgNl42BTUhB1cKg4mLRxhdxnbf0h2DGMfaSLlxBjijazGjQEAhQePcR27K6qMYCb
 DUhKlVveNuwtijIMF1yLBZi5ndNhxDbLsXwh4Z2BJFyOFU1H35ixWYhKQz14/WZmnl
 whd64Zub6OK+c3QPc0+EqM3Hof2U0y14Gggct2Di8XVW8ACAqJZk8kJ7RkmknY3zKo
 9rUQoW6qFDHK6IqTjfYZOphxL8LqEguOIUckRHbEMB4Ort8k1ZlDGirFRsaTKLXSmY
 D9wNtnQy2EbsHc1+QXpeIrx80V98VJqelvKdg1mg9TrkhPpvgcc4uPQhL8enHLi1gR
 NLRecBgcedX99XvgpCwUE5Oi3uSR4EHwAw21xKOp5qciyUt1e0Fi08wH7rx1tz0QUe
 Opik97FH43Kcow+hM2qAWZwc=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] usb: typos 'requird', 'current'
Date: Wed,  5 Nov 2025 01:07:51 +0100
Message-ID: <20251105000751.91889-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

%s/requird/required/
%s/current XHCI/currently XHCI/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/usb/host/usb-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index 7247245a702..1c74d6fd39a 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -134,7 +134,7 @@ int usb_alloc_device(struct usb_device *udev)
 	struct udevice *bus = udev->controller_dev;
 	struct dm_usb_ops *ops = usb_get_ops(bus);
 
-	/* This is only requird by some controllers - current XHCI */
+	/* This is only required by some controllers - currently XHCI */
 	if (!ops->alloc_device)
 		return 0;
 
-- 
2.51.0

