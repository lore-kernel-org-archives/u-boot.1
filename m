Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4134CDD541
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C0F588F73;
	Wed, 18 Sep 2024 17:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="QXYZjSG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B669988D4D; Wed, 18 Sep 2024 17:22:39 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D077188F7B
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d60e23b33so907807066b.0
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672957; x=1727277757; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVVkN12lSTsAxVKKZE4M7huLa/7vQ/7N6/GXIIUvUdk=;
 b=QXYZjSG169g96Vu6rGcmVW58/jZpStKTDQnTFRGuBXLesphBw7o0aBPB4UKH3dvuHF
 tZXOSMQyZa18iGpqCePOWE+cMVFqbdkrB6yP817Tl/nYAB40WHMU4SluAozhW6QhJila
 wUsMGLnflEVZxV5UyiLZmQhneas2zIXDL2x32wYFi1GXDYJd8DE1Vn0JWdBrzKzGvG3F
 hMoL0V+9/r/o1uPo3n7eb0qKGf7igwV576p32YvYAGB7RwzCkfPXhMymRDQxvPJJpewX
 KnhYaVQTWKSB0HelA6MabKzK4tRojlblZbO70ZDNS2mLpM+k1RUtBIB2tzH7Sq/wbmYQ
 chgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672957; x=1727277757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aVVkN12lSTsAxVKKZE4M7huLa/7vQ/7N6/GXIIUvUdk=;
 b=ssKVzeLLORl/zVR+FLJY81HkXsh+z8uPqiofZeZZFnhbMufqmZ7by/ktw/VUTZgQxY
 XpnPyw5V/YYx4KDUIfkBIfHYG/6/OZ6y7OJc5+CcD6afF4GibdvS6zpIve+HkekQ7e+5
 P5aFTbwkX9biXjIFikqafupIx5xYU9FpydtccM5yRqc8xfHADCpGN9/N+pBmafHBPhu7
 0qWORecl0dufWEcRA+AgbeXO3KbvTADyfO6f6NvMXr7erdCoRonchDg0LfTR3DExoo0G
 ZrpWmwXy1gEbrupb/uGF9yUCNhSn25wCugRsgHeMCBjv7rgDzJ/5xA8Q7s2Zblz+aQGL
 0rIw==
X-Gm-Message-State: AOJu0YwB8YQg5VJNnvlxJFKvzSlGLEfTOAYgjKvIS56vryeYloRrhwU1
 +jlPx1Qe2y9Oh2QX+hXyZ56JRumW04vTXl6DXgcBbMOGEATRHh5/E5ipq/mPjiF0h/kIIZjvFLt
 6
X-Google-Smtp-Source: AGHT+IGOYg9+yH/2ascGjyURXEPyRTFrHiW4obxTAigv1a9OYyKclKvz51vX76pAcIuJJd+BL0sxtA==
X-Received: by 2002:a17:907:1b05:b0:a72:69e8:f039 with SMTP id
 a640c23a62f3a-a902941d803mr2173972266b.12.1726672957163; 
 Wed, 18 Sep 2024 08:22:37 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 20/35] arm: gic-v3-its: Implement of_xlate
Date: Wed, 18 Sep 2024 17:20:24 +0200
Message-ID: <20240918152136.3395170-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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

TEST: Booted on qemu sbsa-ref that has a GICV3.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..54dbff434c 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -7,6 +7,7 @@
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
+#include <irq.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
@@ -163,8 +164,28 @@ static const struct udevice_id gic_v3_ids[] = {
 	{}
 };
 
+static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_args *args)
+{
+	if (args->args_count > 2) {
+		log_debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args_count > 0)
+		irq->id = args->args[0];
+	if (args->args_count > 1)
+		irq->flags = args->args[1];
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
2.46.0

