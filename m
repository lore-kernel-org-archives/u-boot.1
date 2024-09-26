Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3614CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E95D88DCF;
	Thu, 26 Sep 2024 10:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="BNb5MFE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338B488D55; Thu, 26 Sep 2024 10:03:06 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF9C388D9A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c40942358eso1263679a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337780; x=1727942580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nglbt6RXFRoSF1PZp4LFeCsmiugjPPt9pJDwHl5iBvk=;
 b=BNb5MFE+qS8Ih3zsEMLr2TIJ8iMm35GI+mLcQHCkIlx3rWunpyyVz6NVlJE5tMRYtF
 mNt1u0Zddxs58gogagiiz4TL7+/a+ZVDWxNFK0r3ipifus20IDfG5EPYRwpJOZ1Br3ch
 6QLtVJSC+BhDu77xQWYfX6S7GTqb34tmol6nhyZ0x5vQxnpW8ei4SvK+bhuRze+96wvx
 OmjxRDNftw8vE5GyKAP/TPFItkAMPWqhKugFJsNhrlDQGXUtRVjjFCzsiAZLyJP737+S
 m/45IGxDkkQ+vcaDDrgQ0TZYRnAzi4dJynjrmvhWKqufeueElz7exp2imakj+rlx8eJ2
 cqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337780; x=1727942580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nglbt6RXFRoSF1PZp4LFeCsmiugjPPt9pJDwHl5iBvk=;
 b=KK3g/9wQInTk282nbmD1ie4rN+3ITDSiktxqQYF7zw/0TOIffMt9N2CCKc7KrlDVYH
 KKihg7zblWlLJbbWJU32BlAKsBiBX8hINgwJMVefouzZfuvv//LhCGzSg6fZ5sgMFFEJ
 UWpEsfIsfRbn4ZVR0QYFDmRIYNXt7rO6Ur5HyzwH+89+mIFKVXwORJxms9BETv/iGRpg
 TCMVX4Uqan1aYo+AOWvZ+v+pvmgYaWklvcsFnCxzMy5JrO/3UA6YlszvhIAquqmoi7XX
 zLAs5XEXNHyQHBBqH+GKi3AbBsLNQckY3fyR7dhxN8GhqgQLMcwR7T6+4Dh/lF7BwzN5
 Nk4w==
X-Gm-Message-State: AOJu0YyGV/A+GI6IAIrf08WbyTKPUGAPXMxUeOI8R4AheTZHZw2JDw3W
 MPG/f80SsP1ypFNMBxQeaHKL6rv+mXu2UrIpOYmgcKixaU3Z+1V+vOutwY5febWhlviHqIZnNV2
 k
X-Google-Smtp-Source: AGHT+IHzA5WG+2hK9YWulLvpYCUUm1KdX551aCE17rd+ilxQm58J6VCuSPBltbCiIxXb9SvX/0GohA==
X-Received: by 2002:a05:6402:354f:b0:5c5:cbdd:4648 with SMTP id
 4fb4d7f45d1cf-5c8777dc632mr1928306a12.17.1727337780239; 
 Thu, 26 Sep 2024 01:03:00 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:02:59 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 20/36] arm: gic-v3-its: Implement of_xlate
Date: Thu, 26 Sep 2024 09:59:08 +0200
Message-ID: <20240926080021.148031-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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

