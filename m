Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3D7CF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3168389075;
	Wed,  2 Oct 2024 11:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="CUh5UmXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E3CB8907E; Wed,  2 Oct 2024 11:52:25 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E406188F91
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cbc22e1c4so48680235e9.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862741; x=1728467541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
 b=CUh5UmXIMtp03HIor3zdPbO++mmZKXSKz7evGq1psLxoGReUJAphhcZPnmyvTBOjAx
 9lMTi/v3yLRdO/qoNvMFQV/GgH5APImnubzwWhDg69urn1Io9VbNdORCI5Q8oAMWzOSZ
 dGocRI5tZmOoO18cEAvj7wVoLZGGJ6KMGhXWCuZBFuhJJPhSrZgh8IbnyvX6bLyXb3l/
 uH7BvMMT+OgCjZ0EUWNyix+hE1ts0sMhr2nJgVv0tUlhmAv0SrpB3p1ATDgct6/COXVC
 NfNsgJFYcw5R3+417VJrrTHYJYz6Re9QziVSr+u0a9wQlexRSfLnN4t8QMQLWGlA3Dee
 oIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862741; x=1728467541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
 b=ZhgtCOjRn29mnzulPmxUGVtCSUsr1e49YLGYsRYHamjnFDpuK256z2w7AffSA6f3tr
 /eMhJbBN5chu3qMQV5IvBAwgF0jZ+wd1ybV3pU6typQUQm0oFTPX+aTCtmVjtmeBrOgE
 gUHMM/MS3/tBeAqOn/kXfyCKpHk9/hpwU+EcpcPcb0PnjOkrcNbDo0ST3rZAb9UlI/gr
 twlOH9Smt6tL8zRr4OUhn0ozXy77LpCnQwYDy2npOGbtFhXwu2Ld6xskAnSQj8QocDWm
 ZNMrTsX8XzOmJKadSaV3K837GZGMnpAaAfbcGdo51louVgICKQAz90GPo+SwNbSq4LtY
 lEBQ==
X-Gm-Message-State: AOJu0YzEnTM5HoVjWX+PRvaaZrozR0Py7iSNBAuianpVGlKFe1NuZInw
 UmCc2zKM7MxkAn6UcC39MMBS4A/taEGNo8rXi/u/q6cFw6tZFqonkTg12lmJuibFZskkJCOCo1y
 n
X-Google-Smtp-Source: AGHT+IFfZ9QIzDhHJg8KrEhxdmzD/m43IGBBfCVRb8bcy456c44XVgrW040k5TPGyMtQxd4At28VkA==
X-Received: by 2002:a05:600c:3b11:b0:426:6379:3b4f with SMTP id
 5b1f17b1804b1-42f778fd829mr17411955e9.31.1727862741278; 
 Wed, 02 Oct 2024 02:52:21 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:52:20 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 20/37] arm: gic-v3-its: Implement of_xlate
Date: Wed,  2 Oct 2024 11:47:11 +0200
Message-ID: <20241002094832.24933-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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

