Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9D1F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7640284314;
	Fri, 17 Apr 2026 14:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Xuv+xrkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A12748405A; Thu, 16 Apr 2026 18:13:14 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9C0783EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 18:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximilian.brune@9elements.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so5678764f8f.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1776355988; x=1776960788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IoNMUcoV2Z9BAIJ2q8e+0qv5et7Zu1kh2NhEcLrhTv8=;
 b=Xuv+xrkKW9tzj3YryNGMvedNUWa1m9whC1RxtPoQsd2gIyCCO6gK7g3vIVf1JSmd96
 737vxXC6FxQG+uwkp/gZ2AGPXOh46q/A8xITS1qEE6UqqyUqoX59ww2jVJLqsmwCcl7z
 Y6Q+euvravaBF6yQ7FWi4UtTJj0YLfiQ+EtEfT0Wl2J9e80P+X37p/F8b/BK0t+OheOZ
 Lv0enSbrbpheRPonGT7EOex+FmUHKD8j75LNU3up0S3Al6H2/7WewC/rAjix/ZYe9HML
 yK95s134mznDZmRgaf/GcjdK2G8SjLyDY2pFhAubVJfB1RsgUduQIJllUqzhXaoJBGB5
 kcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776355988; x=1776960788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IoNMUcoV2Z9BAIJ2q8e+0qv5et7Zu1kh2NhEcLrhTv8=;
 b=aqeXhJK6QtLVyLkURfb+DCsgJ3DUHY05SeUG58T7WiZnM29A/0OAG7bqFsfnoyEQ6x
 uDjR2ilC4CEBLYh9MGXKtRlpo4eMy698HFozCx5VhW9hB60nXo7GVi8QAcm2j9lv4l5X
 ku/AizdSIthB6MzrQsX0Nqw757hSpeB8YSGtu2Etx0zoIfCTqe+psoYKV4lU4KZ0hn9D
 aOUFFlNq3hg8PD3B6zC/+AcWZ6CvI9WDUt7+YWDKn0bpTrqAQx1ixJQHtKS5T7vW/Rjx
 kxz6BTj9TK6zlR+P16zoj75zz5ySISVhUv9xobF80hzruODefjELe2BHyv2n8pxr3f1h
 Y9KA==
X-Gm-Message-State: AOJu0YyndXwV6eNBmyCUhUkIxVZO4rl2VNDLGRbRN7lSYhlkXgGdKdUU
 DoR/LPZ77Tiug5ip7jr+pcL8oCKxdAFqmZ9PoC+ddiTlrs9fMdLjz6fniAmWQVqI5K/fcpTJVbU
 vsh0mKTc=
X-Gm-Gg: AeBDietSMlX9PatUA+xWzJXZ9TIl5uuKaV/URB8aFndapPA1tknZaMQBqx9W8cjxkr1
 YEN5vwgCUwpcEpHQWxWhhKjPNeX7mKf1lVVKbkuZuEGi7Zi76sx8yFfqNfA8w3QVy3c/emcXZJO
 hIjaUQVsm35ZoxtLKOsfibKIP8glyx2CTjUiQ1p3sVAGs9GImiNiDvNX9cnMqBQ0N73SQIo4VJ+
 LxknWzc8elmJSTuMeGZyKWAgUvNu0fIqjxPVybVOOK4KOSXZdmXuxQg3qk1x+uTR6Bu9bjWTU51
 UZYmYsMJ+0RCJ4E77oy65KkPCZjubUbgubFUmgs5uWFap3Y33ToPDVprwfh8xWcOdUxc1QUHqEi
 8KiXHyFJrbpVTpKa+bHOgCsaG1tjX4TTjbKpI8mVvt79SUQjCK5dvcHLzkuiPUI8xf1toeKRf9v
 qqBFX9CYxmC0v2HM0wrnbhPQXr/pn5gcxAVc9VaVu3w+07CB3lkyMUFrlLHW6i3edH24ar
X-Received: by 2002:a5d:5f82:0:b0:43f:dfbc:8c71 with SMTP id
 ffacd0b85a97d-43fe0613a3amr134616f8f.25.1776355988161; 
 Thu, 16 Apr 2026 09:13:08 -0700 (PDT)
Received: from mmax.sec.9e.network ([185.254.75.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3566b7sm15524821f8f.11.2026.04.16.09.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 09:13:07 -0700 (PDT)
From: Maximilian Brune <maximilian.brune@9elements.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, andrew.goodbody@linaro.org,
 george.mccollister@konsulko.com,
 Maximilian Brune <maximilian.brune@9elements.com>
Subject: [PATCH] pci: correct PCI device enumeration to include all functions
 on device 0
Date: Thu, 16 Apr 2026 18:13:05 +0200
Message-ID: <20260416161305.24118-1-maximilian.brune@9elements.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Currently the implementation does not just skip all devices beside
device 0, it also skips all functions (besides 0) on device 0. This
broke basically all AMD platforms, since they have a lot of internal SOC
devices behind on these functions.

This was detected, because the XHCI controller and therefore the USB
devices were not found by u-boot on AMD/crater platform.

Fix it by checking all functions on device 0 (Linux does the same).

TEST=build u-boot as coreboot payload and run it on a recent x86 AMD
platform. Devices like the XHCI controller are now found again.
---
 drivers/pci/pci-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index 83b76d01f24..f58d542ef75 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -927,7 +927,7 @@ int pci_bind_bus_devices(struct udevice *bus)
 		if (PCI_FUNC(bdf) && !found_multi)
 			continue;
 
-		if (only_one_child(bus) && (PCI_MASK_BUS(bdf) > 0))
+		if (only_one_child(bus) && (PCI_DEV(bdf) > 0))
 			continue;
 
 		/* Check only the first access, we don't expect problems */
-- 
2.53.0

