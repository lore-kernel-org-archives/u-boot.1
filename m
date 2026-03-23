Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4151AF483D7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C90D842B6;
	Mon, 23 Mar 2026 20:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ggRoOETj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C6584088; Mon, 23 Mar 2026 20:53:13 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 226718420C
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-467161c4ba7so2787039b6e.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295590; x=1774900390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o7/q5ZvI9/Hjwji8on6+N5L2RqxDEnQkHFyKBfii+8c=;
 b=ggRoOETjMVeOTzKlL5/DTxxRWFzI2JF4ttDnwaPpdfhNpDtAckivPW2buAbq0eWPZx
 KGNoqIHWk2rsHJI/rbb3YTudMyma6cIqo0iJX6AT7o+sZIOh8QPyvMDmrxPQ9gOKZQJJ
 QLCHCzZN2w2OLy2qpbLLHyA3BC38AYwts5pBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295590; x=1774900390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7/q5ZvI9/Hjwji8on6+N5L2RqxDEnQkHFyKBfii+8c=;
 b=TIAQXFFutHIhpU/vVQ44e1VyjG7lHzZ2xA2rpkE5YVg7zZpuY3jLcVV2168BNjbXpe
 nsw9nMKS61ozriztIV9XztnDi8uMpWwHgWEbVPe8qn8u0vwJSeu/SJ9m5CEhIXbu6qPA
 dI1h3NudmNSlnBlucK252MpZa+b14aT6Y9mSCa6IuQ8MJtOw7pBVfJ7LxYut1Zy1ukGv
 gzni8uQj7ksNjHvVM1TQekBF0o9cUHb0vdhQ54oOY8smc/lVZ7eBD49mFcTe4AY7eLI7
 dOdxwwPot7yOKrOc+M5RlZ71mKZmha0MxrMQ5kYG9WDEMCV8iqmtdbjIcFCu428Nlvd1
 sXeQ==
X-Gm-Message-State: AOJu0YxkOqPqDTDzH99PururOSjFoWWs8glEVU2adGF8ocU5efLILV8U
 pS6JdsCnOH+HXECN8BGJwcPwxyApp/tWlwn66jimeQADYyvOogGxt0LaIV7h5CSAPomlCeSdvvo
 5ITlwFLY=
X-Gm-Gg: ATEYQzxJJ1J5YLv09hAXqhZ4ohLs+uuJV5FNQbX05qKHz2mKscSrYItfjJcj3VOx9j8
 6z1wb4J5huF7ELPyPvUBpG7WREhOVA2sryZUUWHMbftMPTFJF2tBPsXmrXb73NNCOSik+r3xLDJ
 Hwvy0i/W4c6bOBweW0SjM2/R9dTKD/hXenj66cZEbZTm6xLPDzilbsWogk78QCBONT2llWNCUG+
 RSq7uWD8zXMJTXZ/CM9A7gOF8PU8oH2RIbY1A21envk+HExmCWsuelhb3YGhTA3QrVHslTjsFVk
 0pRtlCvwU5vsnY8qWi7TxCz94mIVSa3PnqXx8w51KZm8/BzZZznnNYZ+2xC206udega5sBq11ve
 +TwhRGGoSxRjjrWLe3JG2q4OnVLMI4RbJAxV5vjkDzkF9OO1rXI124Myp4NHNsWZfc7pNaaQ6NY
 JjLgGf31AbuOoC5kAvCcqRGtyTuOIbGDLRe8ug+5NHBEcT+GPjlK4Y4+Tw8RIla4nCTzKlgWpEo
 H0Kd2fyqqDccImpaP5F6yo1f/nHDqzEYezHObYdsx2IkqS2441J06AXIK2aOg==
X-Received: by 2002:a05:6808:3028:b0:467:ff23:dc98 with SMTP id
 5614622812f47-46a0cfdd3c9mr487310b6e.33.1774295589770; 
 Mon, 23 Mar 2026 12:53:09 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14d64fbbsm9564301fac.9.2026.03.23.12.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:53:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] usb: gadget: Correct dependencies for USB_RENESAS_USBHS
Date: Mon, 23 Mar 2026 13:53:08 -0600
Message-ID: <20260323195308.2363626-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The USB_RENESAS_USBHS functionality can only work with DM_USB_GADGET
enabled, so express this dependency in Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/usb/gadget/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 2f79840df18c..1575956b130d 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -119,6 +119,7 @@ config USB_GADGET_DWC2_OTG
 
 config USB_RENESAS_USBHS
 	bool "Renesas R-Car USB2.0 HS controller (gadget mode)"
+	depends on DM_USB_GADGET
 	select USB_GADGET_DUALSPEED
 	help
 	  The Renesas R-Car USB 2.0 high-speed gadget controller
-- 
2.43.0

