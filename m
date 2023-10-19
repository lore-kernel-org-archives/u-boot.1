Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D4ECDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18830874A4;
	Thu, 19 Oct 2023 17:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QYay4v1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EB387477; Thu, 19 Oct 2023 17:01:38 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A049387441
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7dd65052aso108458067b3.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727695; x=1698332495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fE6C55oYab3ouRm0gE7cCPJyay94jmpJf5B5CLeG+7w=;
 b=QYay4v1oW5Xn4N98wnxEy34olJSUjMgC3AHtnVcerY59iax/NCrHGCYc45rwvxirMw
 8gcaOLTQyhu68Pn3rl7IeG7WHFUOe9Vw2vaWY+zvpibx9f9KZG2VzyWfO+OBvcUo9JKI
 wYvV84KCREqkQaHGCJXuL6Y2yChuNOqlR9WfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727695; x=1698332495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fE6C55oYab3ouRm0gE7cCPJyay94jmpJf5B5CLeG+7w=;
 b=wtIa5nQsiz0yDuH5OUFGmxT2T7qXY47Rp66ytwCMIpdZV5BaxxQDB0hsRLm/NXt2kP
 ESzDbA39h8FAZTzXCq0qUUbKeP7whpzrsRNgbalWpuFKS2khhosVRmQG8YtlsD6vxjNV
 CQLVSPavqr9FxY4nSSN5mrtLQ9LxJ8hkIrdpVse5dwuvieCW/uAkOw6tX2O6tbG7s9mE
 YNa18dq6iI6RdH5VdGWc5/En7dh1W7zes3tNkoYHwyvOnMmy9F/UuZ3bx/c5ha68TSJf
 skwiQJO8oZtdMIxA/UkWSB+sA7t8WIYPmvl7p37TjY55OaTupzozfff7jQa1B1tkmjT+
 Fa6g==
X-Gm-Message-State: AOJu0YzAEPk+wmzz/NOF0eRq84o+M7zNscF5vnPMylIbctmlNC82KI7Q
 Mu9ST/tn9LpwzQ20Ylv5P4+nG9xQeQNtoguD/s72+g==
X-Google-Smtp-Source: AGHT+IEB7rAf8f5x+ooWCy8hbQKTvMfTYQU74D9vcuL3WcDmBeC7wFx2WNM0PYN1Ph8V4HlKnNzdKg==
X-Received: by 2002:a0d:d514:0:b0:5a7:bbd1:ec1d with SMTP id
 x20-20020a0dd514000000b005a7bbd1ec1dmr2667423ywd.17.1697727694999; 
 Thu, 19 Oct 2023 08:01:34 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [v4 24/24] clk_k210.c: Clean up how we handle nop
Date: Thu, 19 Oct 2023 11:01:05 -0400
Message-Id: <20231019150105.714407-24-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

Now that sandbox has <asm/barrier.h> and defines nop() there we should
include that in our driver for clarity and then remove our local nop()
from <k210/pll.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I can see that our ARM <asm/barriers.h> should be <asm/barrier.h> and
updated in a few other ways to match how the kernel is currently.  This
is not a big deal yet as this driver is only for sandbox for risc-v

Cc: Sean Anderson <seanga2@gmail.com>
---
 drivers/clk/clk_k210.c | 1 +
 include/k210/pll.h     | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk_k210.c b/drivers/clk/clk_k210.c
index c534cc07e092..b9469b93853b 100644
--- a/drivers/clk/clk_k210.c
+++ b/drivers/clk/clk_k210.c
@@ -16,6 +16,7 @@
 #include <dt-bindings/mfd/k210-sysctl.h>
 #include <k210/pll.h>
 #include <linux/bitfield.h>
+#include <asm/barrier.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/include/k210/pll.h b/include/k210/pll.h
index fd16a89cb203..175c47f6f233 100644
--- a/include/k210/pll.h
+++ b/include/k210/pll.h
@@ -16,9 +16,6 @@ struct k210_pll_config {
 #ifdef CONFIG_UNIT_TEST
 TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
 				     struct k210_pll_config *best);
-#ifndef nop
-#define nop()
-#endif
 
 #endif
 #endif /* K210_PLL_H */
-- 
2.34.1

