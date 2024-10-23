Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FBECF5389
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A4789364;
	Wed, 23 Oct 2024 15:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="DppwmZIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 855D38933A; Wed, 23 Oct 2024 15:29:12 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5928933E
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d4821e6b4so4661760f8f.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690146; x=1730294946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKu1shEspiBGFDbULaeGm5YbhuAQEJF6cvlpQuXsf3E=;
 b=DppwmZIkAyUeDEh3985LIsFUQzDUZYmjzh1WREmfO4ca8zwrrxZrfN9UrzH+4dcYT/
 kAfP2TmeeBer2ybZ6d8WloE7CUIZIcEv7MLqqru34F4KiCICFy2oP4ol95ed/fRD+eG3
 c7WH3BFr1Kx+P1Pi3mDKeWDSUIiAF2t5becwj3MOKBawE5GDv5uwRFTgqIrU82g1ywev
 GvBqhUqW1NbhBQ/bai4abgu+3xoe92UsInp2kTOlA4/x2F3ldHL1s5LaFrCRdOPZoTSO
 JJgn6lrAxB4dgAeAdSNY9YvddXjNAqbzvkTsqgMXxzuN/YPY9QnTalVS9q14FxfT/GWe
 IQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690146; x=1730294946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MKu1shEspiBGFDbULaeGm5YbhuAQEJF6cvlpQuXsf3E=;
 b=IiWFxrOhvH3kSEr7Anrkm4pei03xvcImE2fofGEFwAXCZjFlXq7Zzt3OZT6kIQB+O0
 f6D8uMpTHvvzeT8ZWJJlHcDJczPiidFtSPUwYqt7R1irb0wZA+ExjkbAhpmjF23WI9Tq
 aYjSByJuBbrOLUWL+coF3LIpzWHXSZf15ZKUqzMITDgo1hfpJPXRY/oIRIKcMWm4XuZ6
 +10SQ2abSybYC9PKs3kHbU6wcMwo/z/Vfvl0Hsqw2UxvhIcY8tp0CKVgf96zASjj353Y
 6CZs288LOjG9QmrzkhXi1ypq4bGjgqUGxsRqJFMbt8GaX9Fegi9mBSQRL0u/BMD0AKmv
 CecA==
X-Gm-Message-State: AOJu0YzlnzE4LJo1OGdE8D1i5hJUogDrwzc0cq82VvBMMVhaLhul2BA0
 fopyUJxW15ZBVy55OVK8uPdFz6xgV75Le548MtherLM/zTtmZgwHpP9cUpyyuw5+6CUHFMxTBmO
 h
X-Google-Smtp-Source: AGHT+IFBvuEGZKWznn7uULpnrgTFSCE8ALsMzElLxazkNqNtoXZysGaQH5SryzLOD4u7WQGCJOUP3w==
X-Received: by 2002:a5d:5644:0:b0:37d:3f5c:5a83 with SMTP id
 ffacd0b85a97d-37efcf08153mr1901423f8f.19.1729690146498; 
 Wed, 23 Oct 2024 06:29:06 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:06 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 20/37] arm: gic-v3-its: Implement of_xlate
Date: Wed, 23 Oct 2024 15:20:03 +0200
Message-ID: <20241023132116.970117-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

Translate IRQs by implementing of_xlate() as required by
irq_get_by_index() to parse interrupt properties.

Map DT interrupts to ARM GIC interrupts as follows:

- Interrupt numbers ID32-ID1019 are used for SPIs
- ID0-ID15 are used for SGIs
- ID16-ID31 are used for PPIs

TEST: Booted on qemu sbsa-ref that has a GICV3.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Moritz Fischer <moritzf@google.com>
---
Changelog v9:
- Require at least 3 interrupt-cells
- Map SPI interrupts to ID32+
- Map PPI interrupts to ID16+
---
 arch/arm/lib/gic-v3-its.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..58f8bf864f 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -4,9 +4,11 @@
  */
 #include <cpu_func.h>
 #include <dm.h>
+#include <irq.h>
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
@@ -163,8 +165,30 @@ static const struct udevice_id gic_v3_ids[] = {
 	{}
 };
 
+static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_args *args)
+{
+	if (args->args_count < 3) {
+		log_debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args[0] == GIC_SPI)
+		irq->id = args->args[1] + 32;
+	else
+		irq->id = args->args[1] + 16;
+
+	irq->flags = args->args[2];
+
+	return 0;
+}
+
+static const struct irq_ops arm_gic_v3_ops = {
+	.of_xlate		=  arm_gic_v3_of_xlate,
+};
+
 U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
 	.of_match	= gic_v3_ids,
+	.ops		= &arm_gic_v3_ops,
 };
-- 
2.46.2

