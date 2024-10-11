Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D057CFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C750689348;
	Fri, 11 Oct 2024 12:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="ZVKXmnUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE95C89352; Fri, 11 Oct 2024 12:35:05 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA69289339
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a999521d0c3so310188866b.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642903; x=1729247703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
 b=ZVKXmnUq4X/ficiMaNVn+uIz8Pdhpp4rTCi5biiY4JMvoWpagOuCI8QGJB+mDAFqGg
 y0G2PwdTJx3ZCNPKyrAH77j45X/j9T0pPNO/0wrF9DbMxuAOTGmAuyMvlIlc7C1hiAXd
 RTld0LTeCx+fQo6GV0Lf5aPMGSTyYYrQt2ah6rH7d9KS84l+2mwC1eOPo5GFZK1XkZfX
 33uaz0sYFnF6Pd3rmpRP09xp05vXn4G2NKotkxaFK0m2ZNTswy4xtokX89ps4MhcEjER
 UkJ8kFF0ppXHu5bQ/zcJTADmI7VFCqBFsEU6oeH3Ej46hSetUj0DS2DpOJatuJaQqnFm
 +lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642903; x=1729247703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
 b=qrXy/OxrzFr5Hg6hedPkhzn9sJE3FouSrQimLKSiUgu9DCY4YoC1VufPTOkULvtexi
 GBLr83JVQHsaqrnio7NuhnRNSky9zxgeH/GDcg0puE8s2jZRRCW2jqg/sn+/9HlXJPMl
 9w/1vjGVXn5OugzuodN+2zZ6qvlAfb1Pr5CvxTTTt1pYF5Z1dGeHEHsI5Z0dEaXi1tth
 zb8L25exykOYoCMYnR2L8kOAky7RTX1JNYCbZzF2qNoAa0t+t5fApuO/xrSaxr66/qsq
 wcGl/hEo8Rt2uoZ1LntRiAUOaka7zr6HUBKr6dt8qVQKjY/3QYEPzk0Z8dLki3jTUvWq
 bOnQ==
X-Gm-Message-State: AOJu0YyMF6rcwRJZOXRQgzd1xYgQhcCi+BomC0c+Em4pcVTqVVYhSQSa
 rF2wrwVjP7xVJxidSBRbHoWAQ5G1xUVgWxlZ5a3CnYC+/rhUA8oOz9bbFor7sat3UtpZjRSxMRM
 mGrE=
X-Google-Smtp-Source: AGHT+IHmMFXgOQt6HdbOjbNwqxb1gSUXTJIPPXeMo+p0D5zo0aDi/f6I7hGGf5bbIflrEjE/ff6IVQ==
X-Received: by 2002:a17:906:c144:b0:a99:3318:e7c3 with SMTP id
 a640c23a62f3a-a99b95a997cmr169084966b.43.1728642903272; 
 Fri, 11 Oct 2024 03:35:03 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:35:03 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 20/37] arm: gic-v3-its: Implement of_xlate
Date: Fri, 11 Oct 2024 12:23:01 +0200
Message-ID: <20241011102419.12523-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changelog v6:
- Update header order

---
 arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..0d5545bfb2 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -4,6 +4,7 @@
  */
 #include <cpu_func.h>
 #include <dm.h>
+#include <irq.h>
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
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
2.46.2

