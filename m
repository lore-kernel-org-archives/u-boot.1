Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A445BC35FFF
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 12:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 952228198A;
	Thu, 20 Mar 2025 13:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="HrzpiJON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B42A980540; Thu, 20 Mar 2025 13:52:10 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A97448003E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 13:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso149768966b.0
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1742475128; x=1743079928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEYIGYd4wTmi4c0ep/Bj30cA1tMfKG0owWVfxbLLPgE=;
 b=HrzpiJONXxhNgblLKShyNd0LsI0o29xGbcipAhSjuoYzZPzfaR+4RVCjXsfe9gbLhi
 M+wamTpUTpY01Q6WKM3JYMXKXYIIq6O+Hj4Mlzcur+eVhkkNqk9yv44swgDZo5mTNFbt
 exDAZOzsUNOWMPoea5CostbZKTgmGgh1/3V5mAzQ0AECwTsqAfB91DOopg9BQNXC+OwF
 08ayMJ1HI/JrrPYlBYu22zuUUsL2ykwYSSQt+b6yJyMffy7t228q3j07FEoX5h6XlxuD
 pbiL9jiPntzrk913mXGfIg9ZDjutgzLz0/gzHNz1hl6Ww/SsoYZnmipE+LCkU18OR6Ow
 SOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742475128; x=1743079928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEYIGYd4wTmi4c0ep/Bj30cA1tMfKG0owWVfxbLLPgE=;
 b=q55XjxQqgJAKJDGGjDAlB9YTpahxUTJMXq1zWPCMCOl9HlvtRc5aBjRqc2/eO0hd6/
 X/SbemL1L/a5Sfad2Qb86Vztm0ZLMSE8htae15Ex9xQgiqhCh6oQMkL0zYAs+1aIw73N
 SRxVk1NQcp0JHroDsMwEFgzeOzz4JEVQnRx+rNgLNdqa066hokOSCSvVJNQKm+OsOocz
 DNw1K6bIX8dYdTmWy623qzCJ+gHeTb77FbzMAnAw3oke+lc95HmQZiAX6ix/kxQDnMfQ
 lbyp+8uGnHLV2FqY3xbtGDaeFCgNcp9QwVbASp/ruGv37VHec2DsYTFVRh1v5pd2wEsp
 VI4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4nFgdKIaylUvVYFhbWAjq2Qnh1PIyNElgjK5Lo5d2RC9Nzvb/3vMTUUcrM3VAfoX3zUt0jaQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+URWqxR1Y+9Rb2loaV1rhWK2vx6iP61m7fbyLc6uswSxOfvrI
 friMviah4tWMyIYjua93AjJpY6igf7c30TfjQOuIxn2N9xzl09fJhT7ucKztTGY=
X-Gm-Gg: ASbGncs9rRGoCmbQhMngl9vawoB6tC36Wskj5TNJhIY8Gwz+yZzKyH/CsE4o28mou8R
 Ds2FnfqCYKAKfvM1JqOacqDsEa5hG/dfObfSWZh4xJLD707MxVg8PguMMLnAC5/2dFPZfvoJMSn
 SwQHQaxH6gpFOp2lIBz09sVLXD0zsJp0nVxDjDJL6JOXwBrbSviN2iYYC4yFv/51mq//FhvMOmV
 jssV8DAYIi1e5eSQw7/aXJ71K5NTJZytnQumEdBVEjX5Es7zXONc7PITtEKVJlukNCLJtuy6nzI
 3BvN0U0w/S83ZM285f4hKD3i5zV4ujLVKC0EWzd+KM5YGg5NpycruPdfTTBwVpyMMryXJkUnSPU
 auTesJnWHh6TMLQMQxsnJY5Kiq5RTI7wEIumGvT5woO8=
X-Google-Smtp-Source: AGHT+IFehoPAsiwewDCcakFsLvi6MiMSlWsYqtwIeDWjDKJ1+5qxaz/h6y4SxQdJYgU0grDo5G+s0w==
X-Received: by 2002:a17:907:9629:b0:ab7:9df1:e562 with SMTP id
 a640c23a62f3a-ac3b7fc9146mr637919966b.48.1742475127980; 
 Thu, 20 Mar 2025 05:52:07 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a462basm1162284666b.133.2025.03.20.05.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 05:52:07 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 3/3] emulation: qemu-sbsa: Fill in correct ITS ID
Date: Thu, 20 Mar 2025 13:51:58 +0100
Message-ID: <20250320125201.27459-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320125201.27459-1-patrick.rudolph@9elements.com>
References: <20250320125201.27459-1-patrick.rudolph@9elements.com>
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

The ACPI IORT and ACPI MADT needs to use the same IDs when referencing
GIC ITS. The GIC-v3 ITS driver uses dev_seq(dev) to generate a unique ID
for the MADT, but qemu sbsa-ref hardcodes it.
Currently it's not the same ID, breaking interrupt routing on the OS.

Don't assume it's 0 and fetch it from the device instead.

TEST: Fixes non working IRQs in QEMU sbsa-ref.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 board/emulation/qemu-sbsa/acpi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/board/emulation/qemu-sbsa/acpi.c b/board/emulation/qemu-sbsa/acpi.c
index ba85e08fc7d..2e518f2f03f 100644
--- a/board/emulation/qemu-sbsa/acpi.c
+++ b/board/emulation/qemu-sbsa/acpi.c
@@ -10,9 +10,9 @@
 #include <asm/acpi_table.h>
 #include <asm/armv8/sec_firmware.h>
 #include <configs/qemu-sbsa.h>
-#include <dm/uclass.h>
 #include <dm/device.h>
-#include "qemu-sbsa.h"
+#include <dm/read.h>
+#include <dm/uclass.h>
 
 #define SBSAQEMU_MADT_GIC_VBASE          0x2c020000
 #define SBSAQEMU_MADT_GIC_HBASE          0x2c010000
@@ -45,13 +45,18 @@
 int acpi_fill_iort(struct acpi_ctx *ctx)
 {
 	u32 its_offset, smmu_offset;
-	u64 gic_its_base = 0;
-
-	smc_get_gic_its_base(&gic_its_base);
-	if (gic_its_base == 0)
-		return 0;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_IRQ,
+					  DM_DRIVER_GET(arm_gic_v3_its), &dev);
+	if (ret) {
+		pr_err("%s: failed to get %s irq device\n", __func__,
+		       DM_DRIVER_GET(arm_gic_v3_its)->name);
+		return ret;
+	}
 
-	u32 identifiers[] = { 0 };
+	u32 identifiers[] = { dev_seq(dev) };
 
 	its_offset = acpi_iort_add_its_group(ctx, ARRAY_SIZE(identifiers),
 					     identifiers);
-- 
2.48.1

