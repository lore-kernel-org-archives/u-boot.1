Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDBCC5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88E4980C79;
	Thu, 20 Aug 2026 07:15:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DVSKmhNBo2Ac; Thu, 20 Aug 2026 07:15:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787210121;
	bh=jsVdct6Rmujqo6LBBzNKNF/S8P4Pp6KkuCyiyRu4rOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kh+lJztxu+XXK14DNy+ZPvsGSXlyZQiHK9VbV/0yHy+MYnHxAN3FIefjVidwINw4b
	 4cX9jBworbUY4uxjKZcWK0X+xwaW+ECvaM9tI9VSi0bQwrXMEbuEdi4fkMI0FFZb29
	 icAQr//0/Qg3ryndpwCan/iwt8BGkrmjd+grMjTAwGZL7GVf4aNrxflaR/JpgtzTYR
	 zQ+YbTEJp84V0a0j6WvFOP4L8SnkGQNmuq7aAUg6Z8Pw+bn+YBES1iDh9fx98YJnjD
	 FHxLncbHpfSTNCXKWdfj1K/26OzIeSL+4OMWb6iW+GshpBW+sruTn3w0Hc1ERC411I
	 or5Bn9hHuGzxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D86180C32;
	Thu, 20 Aug 2026 07:15:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C086334
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A1F540262
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W8hsAS057RF4 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:15:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XMQLtZjh
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC21240055
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:16 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so16111865e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787210115; x=1787814915;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jsVdct6Rmujqo6LBBzNKNF/S8P4Pp6KkuCyiyRu4rOE=;
 b=XMQLtZjhbwhMoTBv9flt14rVjS8LyWZ6PwvAHk9HmVDaG2vXVoQSHmE8tDhFxKn0Vz
 rFAY8/yQTjZH0BaIHyUfpCUto8WtRJ6spJ1Y+w4IzBetFg2wJrUuglOEcybaQWBZ5xCO
 +A8+/o/w3HgkJ/ZDATDFAaDFjr4ocpbabgrrQwx9urFZl7XpMf3iskrt1rVlMkuGYG24
 aujKFLQptJRWhtghhCyLCucnH4fV2ddEuyfCDjo4aGiP6deeSndHlr3sGE3ITzgQftZ1
 jhBjhsUNzIB3eR7SdLfAuoFXOa3GdUXp9ycgSYvmTyLZde1JbOxcPvpsFSHZg46N5e3E
 M2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210115; x=1787814915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jsVdct6Rmujqo6LBBzNKNF/S8P4Pp6KkuCyiyRu4rOE=;
 b=Ov8DPu2PzSd/tR94Wj55fPlD1hXeaJ9WldYB2C5tzQLN+/aUChrWWCNQY6BhevdI4i
 j95rKi4begUX0/Z/EmZFYdvDUGKiNk49Ek5jjYXVR1jjEOxX0mA3NHDj4rfcLfPruP5u
 Mus8EJpzNoB0FfcHeJQXCJFdmx+NTwV6mkEX4egx0xpT/HkfPCiewyYBLMEORW66N7Ip
 4Pa/yOBPvSmkHpyvwiKwEu5ACBLnq1VNYvmtBaItz7pyZRd1fbOMYvRE39cLp2KX1Yv1
 0jH8oNn0YuQoNArdSQzxy61ukectDZJnPDk55JH07SyqJBcUYRIbyjyjVcw3BtCcfpZx
 xGMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgFjBO8lmmApLJY38oBvw/w/ly41CuYNWgQoocdhiah8zaFk0h425ZUFndokOsy0oTc2FDyVM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyqSo11DbIAkaWRsI/1hogs/JxLe59L1DI1+1DWdg1p5Y39wVZ4
 2BQQooaMuWxyICWEirygQ5d48RM5mLVtC8M/kNDXqlSx9OHbdnjSbidp
X-Gm-Gg: AR+sD11dunPtYA/mCAyoXqJSvuJQGnqfYAKUWCc7gcvZS8I0ll9wIYxsH+3OO0BFzPK
 OSZLbCn5UbUxQWF+bItnzx8S7t2ziX/ZEFeKisEOQJ2YSMKjSXuVy3TB0plZ1OIa+DNbeuYoFSo
 pWE2/Tvi05ElfjZkpYWtNb7uyRPq/D2b+sulRyE1iIKfOW+/oWAXsiCz31Mf1tp2o0OvY+xSITG
 Du4HkUo85covO9439M5hthTdhboWt2C7M5Mo1f1rgnNgHN9ZiJtxQMpu/o57dvIz0TiwY3Wxb2z
 nCt9ygzCM3mCTyySx+YHkANh/U8lIwcDcZe88rzqpNYTFEr2Xfg911EiFbNZ23g7mBAM5/veUeM
 fmCkOGPHT9X3tKPG/cnPQui4IeXEaiqW0glKIQ/lVy1xuoFpZV6bbt2Or8CZDy20jeniCNLDkVo
 7xnPrDTPyKBC5hpeIipl92p4tCag0sO8xBRt52FXOB8170H0j9GSKWiVT3YZTg8yRotg==
X-Received: by 2002:a05:600c:3490:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-499aa1d05eamr221588065e9.10.1787210114460; 
 Thu, 20 Aug 2026 00:15:14 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0d6721sm158151475e9.11.2026.08.20.00.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:15:14 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 2/4] usb: ehci-vf: drop the empty bind hook
Date: Thu, 20 Aug 2026 09:15:09 +0200
Message-ID: <20260820071511.1036506-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820071511.1036506-1-mehmet.fide@gmail.com>
References: <20260820071511.1036506-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

vf_usb_bind() only returns 0. Its comment describes a hack that keeps
the second controller from taking sequence number 0, but no such code
is there, and an empty .bind cannot influence the numbering the uclass
does. Remove it.

Fixes: 0885cdb9d154 ("usb: host: ehci-vf: Migrate Vybrid USB to driver model")
Fixes: b27347f425f7 ("usb: Update for new sequence numbers")
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-vf.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 5d27318de62..e5f9ec0fdbb 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -261,20 +261,6 @@ static const struct ehci_ops vf_ehci_ops = {
 	.init_after_reset = vf_init_after_reset
 };
 
-static int vf_usb_bind(struct udevice *dev)
-{
-	/*
-	 * Without this hack, if we return ENODEV for USB Controller 0, on
-	 * probe for the next controller, USB Controller 1 will be given a
-	 * sequence number of 0. This conflicts with our requirement of
-	 * sequence numbers while initialising the peripherals.
-	 *
-	 * FIXME: Check that this still works OK with the new sequence numbers
-	 */
-
-	return 0;
-}
-
 static int ehci_usb_probe(struct udevice *dev)
 {
 	struct usb_plat *plat = dev_get_plat(dev);
@@ -315,7 +301,6 @@ U_BOOT_DRIVER(ehci_vf) = {
 	.name = "ehci_vf",
 	.id = UCLASS_USB,
 	.of_match = vf_usb_ids,
-	.bind = vf_usb_bind,
 	.probe = ehci_usb_probe,
 	.remove = ehci_deregister,
 	.ops = &ehci_usb_ops,
-- 
2.54.0

