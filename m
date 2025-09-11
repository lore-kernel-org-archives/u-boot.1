Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB318CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 21:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F2C183403;
	Thu, 11 Sep 2025 23:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YUivUdXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5485833ED; Thu, 11 Sep 2025 23:54:17 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFEA683285
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 23:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-88cdb27571eso39652039f.0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757627654; x=1758232454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cBlXkQ1ifjNwhU6A9iWMEfJTyh55663ekRVXQc3rdbg=;
 b=YUivUdXl3CVmsLsTE2wyNhe66f19ZCkNtQGPAlUjbImxPh9CV8M1hiA/bpkDeEPyGm
 uNlLApDJrl+k+KS75AKssMuFLI5JbwijxYbofhRmTcjA+MK6JsVdGeQ9e1Yty2PUhYNK
 ET5AhXWWPMLfMNESrDeSz8WC4N7bn9DMKVfTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757627654; x=1758232454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cBlXkQ1ifjNwhU6A9iWMEfJTyh55663ekRVXQc3rdbg=;
 b=ct+ykIPdzRKENUCV9Zk6qJb2/PiblFkLmOQqRKTz6NrA0Ywi9bsLho8ehkIEkYvtiX
 7f8VJqyVXLppOWyWgdbm5k+b9uvKZFBrogEMHif242mrp2+r4a2dOXhFEuDK7s3Hwc1O
 O6LM0J0quYonHAp2mSWVYXmkH5Pn2jluP3Wg5nI3R1Rj7M7OM7auXOwLNBcYZuu1PwqY
 D2da3PztwSjLmF246JyXROqKxFmtkjjPe08HB3hyEJ3O/8jtXSKPIzNtKYffrPL61p5A
 TrpO+gx14CD2Xj9rk6Nr3o550DKn49xtJHsDEDCxIhUEgppW6I0HOpcHf6sm18MQyz/W
 r2zA==
X-Gm-Message-State: AOJu0YySMh1UNtxEIJsfZpawPUg5fwXpG4B7f5lRXq0+M0KQ6JftGxUd
 nM5bKnJWsiplULazTwYR7zE3WrrNcb2WNK5i22nWT4OCoFsTF2G3pRRczAVaZAkJ2gHBuflRbR5
 GdQ1CeRg=
X-Gm-Gg: ASbGncslVYT4FUcBiLMYauVS9U/Y2zLE5UIkrQ7mrLla1Q73eCfSLfgwB5y92QvKjXv
 s7a6/dkdfhYmFxjUnzSBciJJ9EhfTBAPBr5gTyPct8E2KpnMDea+QcUuNNpBr6fp7xh6heN5ODP
 yXhOGodYQPXFHEWLywA9CXx7UIPYviytl7Hqg0dJhSp8IvWeHL+7ZZ7v8TsFqzxApn4ZYMC3PVk
 77BKp2X2v2Xe1IFZp2hjQzegY6oEGSWISge1l+9IscczzI9lgTleHPUOyT21v0LPdueJhklzwen
 Mel8F5aWHKaCh3WH+GdTXEC6bVa0itcetxJ0dE/XVzviF6qyQUzMRXPoh3RitDGq/SJPdEuih97
 ofci/QDj5rAUHh83c1rfHSQ8TqiugFAi9rCnhjmm8aWYt+qVbJ0D7qo/0Ju8=
X-Google-Smtp-Source: AGHT+IEJK1mv1mzHnTfXpo1uzQsY2FEqdJZR0mrV6JXUizrlEwt+vXC+LD9bDNFQyh4iSFoC2uqHWA==
X-Received: by 2002:a05:6602:6406:b0:887:67f3:c253 with SMTP id
 ca18e2360f4ac-89032426fccmr116722039f.5.1757627654452; 
 Thu, 11 Sep 2025 14:54:14 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88f2a7db2f1sm101517639f.0.2025.09.11.14.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:54:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 2/6] usb: gadget: Tighten requirements on
 USB_GADGET_ATMEL_USBA
Date: Thu, 11 Sep 2025 15:50:19 -0600
Message-ID: <20250911215404.3955132-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911215404.3955132-1-trini@konsulko.com>
References: <20250911215404.3955132-1-trini@konsulko.com>
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

This driver requires some mach-at91 specific header files in order to build.
Express that requirement in Kconfig as well.

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Add Marek's tag
---
 drivers/usb/gadget/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 0121f9872ae6..29c2f27fa05f 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -93,6 +93,7 @@ config USB_GADGET_PRODUCT_NUM
 
 config USB_GADGET_ATMEL_USBA
 	bool "Atmel USBA"
+	depends on ARCH_AT91
 	select USB_GADGET_DUALSPEED
 	help
 	  USBA is the integrated high-speed USB Device controller on
-- 
2.43.0

