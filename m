Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93BFF9EDE0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A388435B;
	Wed, 22 Apr 2026 16:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="csJv7HEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C8F984178; Wed, 22 Apr 2026 14:58:05 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 636E883936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 14:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximilian.brune@9elements.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso30492775e9.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1776862680; x=1777467480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e60BwJUwSBTPYoSPSX9L56xzzvHvHc09J9JBeYSXNtg=;
 b=csJv7HEfiMzU0Ce9ygq3zpSOH/tRev+OzPvFCzbi4OOzwFUdy7/YdTg/8Jg+rkYJmS
 95VEgXtuuu0QZp0s1xE0zejpcPK0MItJee3heLtpWhJtGUkBT2XAkHuS21JCmOfHYWwk
 Yphh8k+TTTKm5WnKyLd3w7WmHeJTsj/y6hGxCgCe6o80YuQAX8fanoU/l8JR5tsF3pL1
 kDV6vqiLtJRHq66rb6tF1EjgYDL6SQEOUPJ6ZwPw96JoKVLiWW1LwI605BYUj8GCuvh4
 lI3Pmq0YEm6i1v68s9ZKelZtxxmMTHYRtRqa/FvklfEPdaDUBqyfcxdLZuCwtFW0z/lj
 rfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862680; x=1777467480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e60BwJUwSBTPYoSPSX9L56xzzvHvHc09J9JBeYSXNtg=;
 b=hLUW1zOfApIbnWbbhzE0dRj8jUma1hUjiHKOlSjFgsw7AlhRGKY0kGdKaOlzCR/Kas
 kkiwOzqVE8CfU7CW5yCr3Oz53z7WRJiqF7XoeOVkL94EQlghF0bMi3vn8waca+L2Kqgh
 bHD45yG41ZCoc48NVNE0Xp4tVU9EOvxJayUcrMhyb70uf14bKTJmQUjcNrRemxZuL1UF
 4mEEpQu2nt+FSe+iC+u8GLSzYVN/C0q/bQCOvAxQ51t2MUE3T0XLE9vnnW79iiS7eVnb
 Jro8QFkrLK4SZpBtlC97MMLu7GIvKnCcLTBFWrxqduNj1w5J1yMHkDXbuuCDK6bbxjch
 BqjA==
X-Gm-Message-State: AOJu0Yx8AkryQYl2O88M9OKm+g3OlNpAwkfxmu7ebmiNFuJrmiYWV1w0
 Aynn7Bm27ST7am4T8NZHsSSSDRGL/0qVZd+6Bjww3zAEOYmqMvup/UranlWnO1MNvX4g7DicsES
 ZYwGm0fncpg==
X-Gm-Gg: AeBDietO70KdbqXGtU11w+0DqOYt7ZUoApBJf7SsUFXR1C/BX4kQCqeNC4cxNhpc5hY
 nU52sCavmf85KdBr8HPI+TvqRRzWWpIezymc67qQsjhjI2FGIilxMRQb/evr5rvijicELlQns66
 gG72n0D72jOhdDQFTWWQq16hFi6tVYiSLIWPOshKJQtg+QJFBmRiT/hR0e3O/vTrDuThjHmoV0E
 I4ptfSMEcSs+a/GKDLVqEiemGvVcZ/0nUd8cS8rn0KUrY7YV3gdavBmpIA0GsDOLh6FJYiM5rn8
 zollvdqyTP4t7SQHc4Xz/aKoiPVl3nB6necy3559R0t/KCRGEEHTYPhbkgLqoeUl+wtGyR6AiQp
 65TzKrrAHIcIqgWUkVowHmHvlP6Y2yAb2RevoiqRD6C/rz1bPUgB7sUco0FCMAa3dXBwyhTZ5dd
 DOFkvDOEsOzWjukZMpr7KDTvzy7BV6a9S2ucxHwPu8v4pc63C7NNuxOn5Oio3AR9KN4PAGyb5fm
 g1oSUwu3uIjabpEYWxa+bp0wLfqOtJ6EFG9IQCQOv/y+P43WdzzwxsyO28i
X-Received: by 2002:a05:600c:37c4:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-48a55017b71mr113152995e9.18.1776862680522; 
 Wed, 22 Apr 2026 05:58:00 -0700 (PDT)
Received: from mmax.sec.9e.network
 (p200300ed8f1a0a004662703f880fa970.dip0.t-ipconnect.de.
 [2003:ed:8f1a:a00:4662:703f:880f:a970])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7a06f3sm162384965e9.22.2026.04.22.05.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:57:59 -0700 (PDT)
From: Maximilian Brune <maximilian.brune@9elements.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, andrew.goodbody@linaro.org,
 george.mccollister@konsulko.com,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3] pci: correct PCI device enumeration to include all
 functions on device 0
Date: Wed, 22 Apr 2026 14:57:53 +0200
Message-ID: <20260422125753.29574-1-maximilian.brune@9elements.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416161305.24118-1-maximilian.brune@9elements.com>
References: <20260416161305.24118-1-maximilian.brune@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 16:44:59 +0200
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

PCI_MASK_BUS() returns both device and function bits, so it skips any
bdf where either device > 0 or function > 0. Using PCI_DEV() extracts
only the device number, matching the intent in only_one_child().
It therefore now checks all functions on device 0 (Linux does the same).

I build tested u-boot as coreboot payload and run it on a recent x86 AMD
platform. Devices like the XHCI controller are now found again.

Fixes: fbde868ba4aa ("pci: skip unnecessary PCIe scanning")
Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
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

