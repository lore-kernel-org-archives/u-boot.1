Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6304EC5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F2EA40E42;
	Fri, 21 Aug 2026 13:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Db0pZPU6Fwa; Fri, 21 Aug 2026 13:16:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318169;
	bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tNae75+ksS0FfkqnlCb6XifZ9z6Gizg5LaRwapRNDsXUFFhxn0CJyJCrN8NyA2nO6
	 uXKfIZyTh92rdX7rClxgBtTzmkitEJY+18DwggNtV/01Cu47d4qc/6p9oyzN4DlHVJ
	 PMSxGPzYQ6lVccrIeoUyDWb6l2emhzAYfZyXJG5adiqJn/bAdsRE0QBGZQOu6w42k4
	 sbfPjqhSwewrMgHbeWdS3V1xnA4HV6kfnD24aGMcuYHqXE5jvCQ3uR2vLVgGvJpbGQ
	 VvaJAINrWavp5tSbpUlma4lC4oaVcV4HO8CkUeiC3ExbgcAczC3Js+byso8aQHEq2Y
	 X/tdLUvpRoXGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3A3240E3D;
	Fri, 21 Aug 2026 13:16:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 99CAA263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BF5E4094E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nX_81JoniI6h for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=nhcDIF1S
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67A7E40947
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:49 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c2193c18362so7692766b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302367; x=1787907167;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=nhcDIF1ShaIjMhf+9xvQn+QtyrQ4MCUdhB8bKg3avEC6vOEwyQvkztfYheBjIy6w7U
 gcU5/Sc3ZsHTvF2cDImdDaUEcW0Pii1HG/A18P4AF4kJAzdAl1JXyD/p5YPlISvHgVGt
 Js6jPgCgfphngxC7B/lYzh0IY023amZR1TnN8oh71A7EdNeh9hsyQAumNr0asZXo00He
 SpRvv0oNYGDDIcGv4Gw1EI5wrv5vDzhGvKdeH9NA1FaHzx1kAzjjXMshimFmbL+An6cc
 U/YDbO2L76hvKFZ+qb6H4EHWM5JX0+kD20uFbTIgoZNb0xn/bbhD5oRhp6aMzW9oPY32
 xRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302367; x=1787907167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=Hki+vIvIwV4LqZ2+vX7MZo+MCtRLSMLjKQAPvB0dB/pA85gBeFJT3YweOzRCer+JFF
 +4DEhz2ZGsuKUg/99BabCoGbt9RO7RLdpo1TmEw5KGwCEe+Npcd55dMexOhEhLGzds3U
 MmuNB4Bja1tshZ51RXNwv1hVGxUYSbcB0Qer603t+keCRYazPk67VE0nTVvuNAPTMls7
 oTUKUJg8QsDkXlQ9CNf/4bNLC311SIb4WcAkhjew1hpWJ47vxL5s5ZPx68vzAPBG3Nbv
 og51rwodi+DYuuXkPLYBoauXiMWsi0qPVfrkz1ExxKRHxQ4yl41oRqLY+U4u8OqJ0D6F
 R1zw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+AfcUMbrP9odmFg7wPcPbtRx1/wQXJlr3Xo+cv0C3XjiT3EKaSNFYRwUV8Eqwbuu7NZLOqts=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kaSJbfv95mEFSmhaZiGmMrIp0VlmD5wib4eTk+YCmmclwUupPp
 Zb2bUT6rDHX+mURV7yJTNxjilrveMkvKpeEwBpTIjbDCg9M1FNYubGtOzupRiqTFQso=
X-Gm-Gg: AR+sD10ILCwRfCzMFFdjWqc7zVaU3BIg3pa3y4n7XhcaFvSPEgy7NdjI3gPAAlZjnWC
 GAbqD52zr+1n2hoSgNAKePvaPndD0KZ7m46T3JpfJKMB/PGG+RVUZiWTmtFtNEajvjpsAwIO/Zx
 eGFJlok8Gxrbh6me+/fu7wJZL6n1J+PcawHbTxnOVHOlQANKZiA9pT4EOzBXpHBLpORocRqCmOY
 ZVSVucsm5dqXOjxEvCVh02FO/ENROlq8+9hkD7ITJbLP9vLlL32M3RjVdUXkW0sZIcJxa+MlIFP
 NA5ntA2oUrAS5OoF2yC2ZRrUBzvS0JFGwConKlbWY7sJk8WBzOw0DIYyO8n4xkzSyXYPUWHpRhX
 o+c2xTRP7QG27rMwUGbOncy0RrmAXfZpTS/CF7YgJ0IuvSPeHLfyEmC+o2oEQ2R3ydhy9sRDQoD
 hsicDs3Fe1QS4BusMSi3QWti3NQ7UIWEVVQIdlNo89vQ49AW7waEOeZS+pjPPSDWwPn8VDqAL27
 SOMw7a4/32n/FPktfgIjG9p
X-Received: by 2002:a17:907:d0c:b0:c20:38e2:b355 with SMTP id
 a640c23a62f3a-c246a6c97c1mr232577266b.4.1787302367358; 
 Fri, 21 Aug 2026 01:52:47 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b095fasm340562066b.24.2026.08.21.01.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:46 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 83/87] usb: musb-new: set endpoint capabilities
Date: Fri, 21 Aug 2026 10:47:59 +0200
Message-ID: <20260821084829.2070426-84-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:41 +0000
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

musb-new sets maxpacket directly and leaves caps empty, so
usb_gadget_ep_match_desc() rejects every endpoint once epautoconf.c comes
from the kernel.

The shared fifo endpoints need both directions, the others only the one
they are wired for. The kernel driver already gets this right.

Take the caps and the usb_ep_set_maxpacket_limit() calls from the kernel
driver.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/musb-new/musb_gadget.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb-new/musb_gadget.c b/drivers/usb/musb-new/musb_gadget.c
index 7daff5850f19..cb55f9ab458e 100644
--- a/drivers/usb/musb-new/musb_gadget.c
+++ b/drivers/usb/musb-new/musb_gadget.c
@@ -1841,17 +1841,32 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 	ep->end_point.name = ep->name;
 	INIT_LIST_HEAD(&ep->end_point.ep_list);
 	if (!epnum) {
-		ep->end_point.maxpacket = 64;
+		usb_ep_set_maxpacket_limit(&ep->end_point, 64);
+		ep->end_point.caps.type_control = 1;
 		ep->end_point.ops = &musb_g_ep0_ops;
 		musb->g.ep0 = &ep->end_point;
 	} else {
 		if (is_in)
-			ep->end_point.maxpacket = hw_ep->max_packet_sz_tx;
+			usb_ep_set_maxpacket_limit(&ep->end_point,
+						   hw_ep->max_packet_sz_tx);
 		else
-			ep->end_point.maxpacket = hw_ep->max_packet_sz_rx;
+			usb_ep_set_maxpacket_limit(&ep->end_point,
+						   hw_ep->max_packet_sz_rx);
+		ep->end_point.caps.type_iso = 1;
+		ep->end_point.caps.type_bulk = 1;
+		ep->end_point.caps.type_int = 1;
 		ep->end_point.ops = &musb_ep_ops;
 		list_add_tail(&ep->end_point.ep_list, &musb->g.ep_list);
 	}
+
+	if (!epnum || hw_ep->is_shared_fifo) {
+		ep->end_point.caps.dir_in = 1;
+		ep->end_point.caps.dir_out = 1;
+	} else if (is_in) {
+		ep->end_point.caps.dir_in = 1;
+	} else {
+		ep->end_point.caps.dir_out = 1;
+	}
 }
 
 /*
-- 
2.53.0

