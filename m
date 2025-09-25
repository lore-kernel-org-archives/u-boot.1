Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EA4CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA37830CA;
	Thu, 25 Sep 2025 22:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tmxmLlxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C61C7802C1; Thu, 25 Sep 2025 22:42:31 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 398AB802C1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-74526ca79beso945237a34.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758832948; x=1759437748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkD7Gt1XMYOmz+xJU7PF3mxKfjU7g00eUf+mbc2w1XU=;
 b=tmxmLlxlWRgwSaNg8sVKtpsyIs7CM3IlP66UgVf8ayi9Rbki6T6gGmPzkdTnI+hHHX
 92kEmPx4MtxCCEUEHk7Zo+kgckpmfC9C3TS6QbuhqieL6kwtxcxcHaRzCV4uIV7+n1d6
 Yexqjd6p8JJXTiRjhpsgXyxzSZSji0iBal3dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758832948; x=1759437748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkD7Gt1XMYOmz+xJU7PF3mxKfjU7g00eUf+mbc2w1XU=;
 b=EAZnUlDnlLbTyuFm4M3L2eKnEGq6L/H3bo7fm9P7OxCEcsux0O//5kWBW3876g3JjX
 JIFvZbLJKO2unB8W6wOT03oA7w9vwDZWLvfnyD6x0Ni2zCD4EBf6hdiA9fKs/OruurVu
 nlvPVNKpxoQgrWcTEkNMpyNoSreqqiqgq1fVic9MDnlKTgODkwGJIB0M9xeVAifsT5tU
 /eQ+1ol33HM2MJTusIe2VFhkhcY1OKtbwZCJiNUuB8nXFqqVeaZZ/glfsW2RJieBSkMm
 Usd/VmEi/LP5LOn4/OmhrK49Q6AwkGnZwzxAHRWCcb2NcQTJdSw/OwhLKUBKkEQEqjvQ
 wAUg==
X-Gm-Message-State: AOJu0YyvFQ6XSw7thcI4G7UZWGGD8I1sWdbt+UF8q5j6358vY9GJGo80
 4sYI+uwg2ljHSRikAQs3jt+Wlv08YeuhLavbUaU1Y9HeMBL1REjDUn8neagrc9aRuVcj+joiKRh
 fjPct6yc=
X-Gm-Gg: ASbGncs8yGG+dn1NUYti+vCPGnzHJC/YSpd56RSfzvll2oFC+KY5V2C110cpqfGY36R
 Rs/Aomz2t6kgsIHMKgtuqI5PU6lbogaVGCZMyHgmc4/NTau2kWflv7E/Ox/L1vpy53Rf2Jo9mTv
 z3QKHdeQM4S6BA/CYezxvcNCALC5XCDmiKn+/W/ZjTdNPluU8+ytx87xTvqn1DHP23xtAgsojre
 S/IoWzOrdsvq87jZG0b5RqFuQ8IqLyHA7SoarUa5/OiRf24VxAXXafY17J7/NUr8p/PcNQW8kKL
 43b/OLrfxncKtvyfFSUTl4xYYQDQQBgbGm/Fl0dMffNw/Ex8wJoS+bhkAR1mf+V7MfpkfOQUU0j
 QOJ2uc6LytfHyQTFjNwAW+MGVkGPUYE3Th6uHit4imTdXRI5sdt3asvUmoDo=
X-Google-Smtp-Source: AGHT+IHVmMJYIvUEzlB/QV6UQWeN5OZTLpvDGWjBUIitCbD6LbKNjeM9iFbrBFngt403M0Zh6zQZYA==
X-Received: by 2002:a05:6830:d81:b0:73a:6904:1b45 with SMTP id
 46e09a7af769-7a04bfacc2dmr2636685a34.8.1758832947895; 
 Thu, 25 Sep 2025 13:42:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23193c8dasm599072a34.4.2025.09.25.13.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:42:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH 2/4] usb: gadget: Tighten the dependency for DWC2 OTG support
Date: Thu, 25 Sep 2025 14:42:23 -0600
Message-ID: <20250925204225.3560724-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925204225.3560724-1-trini@konsulko.com>
References: <20250925204225.3560724-1-trini@konsulko.com>
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

The DWC2 OTG driver depends on an ARM-specific header file to compile,
so make it depend on ARM.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/gadget/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index e845e46e0b7f..3a8ef45706aa 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -105,6 +105,7 @@ config USB_GADGET_AT91
 
 config USB_GADGET_DWC2_OTG
 	bool "DesignWare USB2.0 HS OTG controller (gadget mode)"
+	depends on ARM
 	select USB_GADGET_DUALSPEED
 	help
 	  The Designware USB2.0 high-speed gadget controller
-- 
2.43.0

