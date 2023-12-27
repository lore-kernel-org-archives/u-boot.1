Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53446C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BE987976;
	Wed, 27 Dec 2023 22:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fx8/T07s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C3EF87976; Wed, 27 Dec 2023 22:29:15 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8535C8775F
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2cca502e642so48945241fa.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703712553; x=1704317353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnG/r8QmPpperYtXmpoBsLm3fm6PP7mWSnRTf3DPd2s=;
 b=fx8/T07sEtciIEJxX+dhq6sDSACHgMM7wGnVdjANc7kDG4sQy5cO9OsBpgsVbpL3A7
 E0gP+x4L369S5fvYlfEhuj66m9Cu4IfCbzCno+9MSmvds3jRcewKgOzNZtknkPmpd5UJ
 QeRbtuwxmST7ieqIihS6t+9AwdqzMbsVplBje71UNZVQYu91V07EllY0WAwEYGtgqx2I
 IMeX3ds6f+3gYyZTCLz9lutvm3zCkLxQm9Sg8cRyuDAeQlnK2bRYhJULMMQYO/yOnx09
 2GIBxZywlCNNQUXGSvoLTeCEdxaj398YWxIyqktAq6y+6BD5d69QHjzvbv9EyOiOxZyQ
 MD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703712553; x=1704317353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnG/r8QmPpperYtXmpoBsLm3fm6PP7mWSnRTf3DPd2s=;
 b=M+oOB9hc5eswoUeTOKAaRxDHDe0tBudYLwUsZZDxM8xA0ifZINHStFaIWeCBlZjfza
 xlhCssIWqWCkf1eeNG8w7oKCOo6tR9NcR4EzFJJaVaV5ogVF0+4NA1rSYo7mATST7/Y5
 ORFhRWyqS10YXDi+E4GSx0NcLUd9Y3qUl/8rjhFG8lXyuXdV1NHPEpWFkJbmaIFZDSxK
 5zSqpQcYgoDs6TcD7ViQeR/oyANGO6rcs5EpuF2HBbdcbPGBz2GVHOMAJMpmL1iUxfJk
 mLBUsaZwBHDHyJCCBunc5tsENM3s941f0DdOfezZkLCYpvvNTpCgOWH0zcL/dnWvPCJg
 LaGQ==
X-Gm-Message-State: AOJu0YxWnynA2oxKF6EogcGq+ygATL3FWbj7vlIPnpENm+SABb67CQHs
 Zj3OYmvQokkPAzko4tzZ3j/SNdCQnGtQ5w==
X-Google-Smtp-Source: AGHT+IHCDrn4nsLgjlgsNMiKHfra9UwLNQtqZFHWzaNUZzcOkaK2SVTwPCDcKeWxTfPEcPkHmxsanw==
X-Received: by 2002:a2e:9442:0:b0:2cc:843a:eca1 with SMTP id
 o2-20020a2e9442000000b002cc843aeca1mr1494909ljh.178.1703712552738; 
 Wed, 27 Dec 2023 13:29:12 -0800 (PST)
Received: from localhost.localdomain
 ([2a05:3580:f312:6c01:1b6d:df4d:cbec:e4a2])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a2e90c8000000b002cc565cc5e3sm2559531ljg.68.2023.12.27.13.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:29:12 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v3 2/2] sunxi: restore modified memory
Date: Thu, 28 Dec 2023 00:28:43 +0300
Message-ID: <20231227212843.397349-3-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231227212843.397349-1-andrej.skvortzov@gmail.com>
References: <20231227212843.397349-1-andrej.skvortzov@gmail.com>
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

Current sunxi DRAM initialisation code does several test accesses to the
DRAM array to detect aliasing effects and so determine the correct
row/column configuration. This changes the DRAM content, which breaks
use cases like soft reset and Linux's ramoops mechanism.

Fix this problem by saving and restoring the content of the DRAM cells
that is used for the test writes.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 arch/arm/mach-sunxi/dram_helpers.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
index 661186b648..e487f87bf3 100644
--- a/arch/arm/mach-sunxi/dram_helpers.c
+++ b/arch/arm/mach-sunxi/dram_helpers.c
@@ -32,13 +32,25 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
 #ifndef CONFIG_MACH_SUNIV
 bool mctl_mem_matches_base(u32 offset, ulong base)
 {
+	u32 val_base;
+	u32 val_offset;
+	bool ret;
+
+	/* Save original values */
+	val_base = readl(base);
+	val_offset = readl(base + offset);
+
 	/* Try to write different values to RAM at two addresses */
 	writel(0, base);
 	writel(0xaa55aa55, base + offset);
 	dsb();
 	/* Check if the same value is actually observed when reading back */
-	return readl(base) ==
-	       readl(base + offset);
+	ret = readl(base) == readl(base + offset);
+
+	/* Restore original values */
+	writel(val_base, base);
+	writel(val_offset, base + offset);
+	return ret;
 }
 
 /*
-- 
2.42.0

