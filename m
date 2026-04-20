Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D88F588C2
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0FE5843D8;
	Mon, 20 Apr 2026 14:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="H2vdJzL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A082C84312; Mon, 20 Apr 2026 14:07:09 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 930AB842F4
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 14:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximilian.brune@9elements.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso33452605e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 05:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1776686827; x=1777291627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dyqi9+oOSZuy/ktekZfmEqGmAt/YUBvgDAuAXsiJpvs=;
 b=H2vdJzL6NmfvuWXCqq4e6MHxPwFqhF0YRUNelk2H2meoX13lmCEOeb3F2B2UBGD6On
 lDJ+aXtZvjqclwbPrjxZHrkhYecPf6TtRqyXwwetk0nWDsymkrFzWXNDh1cupF3/iN3c
 jGmiWplRgv3KizEVNbAhxbd8wKJNe8SRRs+o2VXbbZmdIA2RQpDab3mf2iW8br0MlBG2
 p9xTiA326M/LPI72VIrMcLSKBqnKUSFSiIMFW/rN8HA0oj5+jZMlNyiNi1AuxRnFaXKL
 9vHljOebjHd81rk4+IMi0sk/3UfGBqori5IX8kAWt+Rwi+uVjLGauy40JhchL3XuBgcE
 iUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776686827; x=1777291627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dyqi9+oOSZuy/ktekZfmEqGmAt/YUBvgDAuAXsiJpvs=;
 b=ibEf3Wze8CicTXIkYNp9bIpKKyyl27Jq9rKKh5V0OLVJMozIySTb0FFOFEd/hWv+im
 fAVzsIChKW6kTJn7nIATX0nU5RASn2k8poHBEv9m5HZzCynFS7gzJ6Duk9vUlLXnIgag
 JYEOrlOOToGu9by2Lat4LByrpIw8RTES3U0y1MInLt4BJWEd62PNpytDzrzMy+kpXPZd
 jj+Qj7qpOOabxKsCTaYnjnbNfc+5YPTDPz88FkGuT7djpFJnrPv8mR1zPABL3HVZ6GtN
 cWEf71QMYBuIALCJsZUMZ55897tE+i8Jgq799eqtv+Y22/o2RNdeVYNQSHmaRZfreZCm
 bpvg==
X-Gm-Message-State: AOJu0Yw6nDPONsotm22hPI1q2h+TqLOKqqlDUZ2OpuOEbiBq52puDqiF
 88xwYNo7dN92jEzldDg6x0Apu8QqTGGNnCQfVRXqnXiFSIyQxOzb2trrcP1Z01eCuJuW3jGv+G0
 Afvn90F4=
X-Gm-Gg: AeBDievUGmiFkahdSMNlJMGC7XZLxX1e7fR6VphL19g/NeLOD9Lfrsx7hI7qFi1pIQf
 Jey6+O5iFu9XVeaIOj0B5PDKQqNaT4TPodOBw3Jfex0b9h3rHF0OVnirsPhMxSOZeWYCBrjw3Ti
 gE1rWQYLus4QYOistx5bAFnvErwAUcSz2u+Zp5ChzF9S+TVBv1hXXn0RfNWGYQdD0UUabG6bmHm
 3FZAKZD5x7RwIthvF+hi9bpZeB3OePQwLY/slnmyWJdnjIjrwzh0NFhPpZvL2OvCAI99KXlpbEI
 F76zOYmakeUeyFP1gO43o0TZrKxuxOuzH2ogAUOBKXCM8HsljdhtAjiSfMp6YJD9DB0r8mImGos
 j7Sd5jqJy7juUnBfmQkOivMRBGny1Y6IXyr3k2Cl8cJE7vUMVsQ+d+KJSOKv64FrES+sCTHLs/4
 pnYvJ6Mi6tJViuyhpmf4V8nC0bZItFOIhDDqCmMA==
X-Received: by 2002:a05:600c:888b:b0:485:4bd1:4c64 with SMTP id
 5b1f17b1804b1-488fb796f95mr153969965e9.31.1776686826844; 
 Mon, 20 Apr 2026 05:07:06 -0700 (PDT)
Received: from mmax ([185.254.75.51]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a525a0b1asm10879945e9.2.2026.04.20.05.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:07:06 -0700 (PDT)
From: Maximilian Brune <maximilian.brune@9elements.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, andrew.goodbody@linaro.org,
 george.mccollister@konsulko.com,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] pci: correct PCI device enumeration to include all
 functions on device 0
Date: Mon, 20 Apr 2026 14:03:35 +0200
Message-ID: <20260420120335.10120-1-maximilian.brune@9elements.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416161305.24118-1-maximilian.brune@9elements.com>
References: <20260416161305.24118-1-maximilian.brune@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 14:54:39 +0200
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
devices behind these functions.

This was detected, because the XHCI controller and therefore the USB
devices were not found by u-boot on AMD/crater platform.

PCI_MASK_BUS() returns both device and function bits, so it skipps any
bdf where either device > 0 or function > 0. Using PCI_DEV() extracts
only the device number, matching the intent in only_one_child().
It therefore now checks all functions on device 0 (Linux does the same).

I build tested u-boot as coreboot payload and run it on a recent x86 AMD
platform. Devices like the XHCI controller are now found again.

Fixes: fbde868ba4aa ("pci: skip unnecessary PCIe scanning")
Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>
CC: Tom Rini <trini@konsulko.com>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>
CC: George McCollister <george.mccollister@konsulko.com>
CC: Simon Glass <sjg@chromium.org>
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

