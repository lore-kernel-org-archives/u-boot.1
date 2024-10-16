Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBD1D2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E9688E2D;
	Wed, 16 Oct 2024 08:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="AaRWpgSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 084C788E8E; Wed, 16 Oct 2024 08:13:14 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1657588E49
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a99543ab209so947519066b.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059191; x=1729663991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StS7Bd9wyPSpg655xcrWiCkyycmPYijDXix7NMpAQ1k=;
 b=AaRWpgSLf9/I/MazENNtWlFwVnubLZUe0WPmjWyXvAoiyH6tFl8jd9boNjALVNH8CE
 a37ikr9YeH7NrLBDoKPkBWBl//uAzD/WV/Yh+vEDbWRCzjJz/TLB6Dliak45mNVEtDxI
 +4H64do+NqD/D5Vcc3aKe9ipYGIrHXedbS3W5KQXpna7eMOu4R23PVJRKwShjRmxNiaB
 E/4PwFmOIkKb2NKSggXgARr3jTtj+MjGoKAZ4jcFS6MltdTkcR0C9OJ1cJKtdW1HjTax
 k39U0em5BeLUUWnYIClP3j+R3nnOSbAsPQx9DcKxnkRCcitm5G2fceLaqmDi/uazq9K0
 inFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059191; x=1729663991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StS7Bd9wyPSpg655xcrWiCkyycmPYijDXix7NMpAQ1k=;
 b=tQg9f+0TGVqgBI43I8zMwcmZaV3uQVcXm8c0QqD4OtTRGIrTDZTSRCnBjKvMO6iefa
 9001Etaegl0Q1+iPi+6wlYS0PGURYoU3n6bs59o6j1QFCQrUPn1SY7RRv16x//VC47XR
 REIMyrvyCeH2CAJX0jkyBNWhfWzRSlIdUkGbK9k3rlOVlsO3wLJbgBZyrVXHPBo9zHMG
 iFwHHxFaBQ1r0FcE+cBK5yTqoiSVH7/M33caq6G8PkwT0KD7tFHQXYG40Goy5Crmcnpv
 xxWjBD6pmnG7pfOMKl6itaLWOXP1XGOFVINVJA6WWSCxqGGXEN78WjbKBycmJD+G781y
 FpSQ==
X-Gm-Message-State: AOJu0YxExIPxFdZ6ILyCgb71myNSOTjq1H6zh50vPNuD+/rT2RC1///9
 zJOa9NxWhGx7isvHseYb9ZMSDWWiJZDeVVX7DyXYHaYXXZrnAC4BaMmZHqIGagTF51Ljd71H1Ur
 u
X-Google-Smtp-Source: AGHT+IFmR5oPcuSaLmdqQM+ujKJxxJ/XTNRbE8R9d0OwdjvSr2XYhYTzoakGgRMlb6bDJUr6CFH6IQ==
X-Received: by 2002:a17:907:9288:b0:a99:f167:47c7 with SMTP id
 a640c23a62f3a-a9a34e275a6mr221987266b.55.1729059191479; 
 Tue, 15 Oct 2024 23:13:11 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:13:11 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 20/37] arm: gic-v3-its: Implement of_xlate
Date: Wed, 16 Oct 2024 08:04:06 +0200
Message-ID: <20241016060523.888804-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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

