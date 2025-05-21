Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FD2C54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E2183020;
	Thu, 22 May 2025 01:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a0zrJb2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8082F8300B; Thu, 22 May 2025 01:01:49 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF53682FBE
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-60b8a9be8a3so56751eaf.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868505; x=1748473305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/zmhmC+KmP1696GMSYnSuIQ0ZB/h9+llWQw2tW+5PyE=;
 b=a0zrJb2cHsto1XNz6kgz5D+FWEmWvqLVY7AECNUtt/E+L+EQcB9+wPC7uXj6Lta3rI
 uDM9cBIEP3PXAo9bhXR/N263ik1sAuhhEX4/0IQm9aAM6qVyCsQJfnztFwflhu+V0tTM
 h7o8dapmoKhJQIxLJo50P17yJUDmkHA9HmOpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868505; x=1748473305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zmhmC+KmP1696GMSYnSuIQ0ZB/h9+llWQw2tW+5PyE=;
 b=j2U8Jj1YMrYIkkYmXlaD6wEE2miWQXVXNoWUWfBJ1X7k3SKNOJsXBauhG+pnatwe31
 tPRi1MhUdhrGjywNYODp/EVN1bTOusKno4kxGGFYwfaudnamk+q2u8Ru2zUx0bW5bl18
 POC+DmlOV5iscisndhtPVeINEmTG75FdczPtLi/SZk5NCkDMMjJQDa4z8d6I1msB9qx/
 Gsu+Pxf0fhvopkgbz1r198Tao9KPZpZdvMOBjc63QxSz1PTqyAbQ3NvQacbdcfGLfE0V
 MNUzti86GfhSSRcXRyIv1ttyPnabz4+b3OKtXvtf7jyjC1pEC2UEAmb05oT927T3QnEy
 rGxA==
X-Gm-Message-State: AOJu0YwcsPZ5b5/dXzQWseygjGhH9VLN7WHYQNJ1rWSkkDTMBvOcldbm
 tuLU7okeDdD0xbn7YujLAv3LmjoGxmGg3rI/YcBgjezUpGAFKe6aqnLrYGVCjaMs5w2dAawFnKx
 ovaw3IYU=
X-Gm-Gg: ASbGnctZtmcEgHgp1YflLa83nqkcjJFVHu+HnuUDYs0cA3uty4sV5boLuThBsFAoMOJ
 dskF9Xh+Jzyfy6LGZ2o0ym8+ugaK6uElqvcnh1eQoGlBECCoBYYKSSPWM1IkeKNeYA01GSB2/4g
 ESis82HxjDQvXg7N8pu3+QhDXv1N0jQoDv+sIn45FDQO3CxjpyA9FIjmidamObmTP4h42tf0Wto
 UsJsCtyGLr3tGlVprJWiGotz22TaZNmDIzp3+GR2No7d8tCKgHcs5dqgguNw/kJW0rAQwvEysYh
 6G6oHlB5+n558h36f06Gc45mx8EFltgz39Me8gHQ7S24Thjjui7kThDyEXFdEC2O8t6Cwtv++Sn
 aYIpKW9UrbTnKjFk=
X-Google-Smtp-Source: AGHT+IFsORu4fizdgrciOAisvryeWnIaEPe/MmQmT06RH79sR0thlznFE7/J9YFLPXRCmFgMdTzDhQ==
X-Received: by 2002:a4a:ee8a:0:b0:60b:7e53:f1c3 with SMTP id
 006d021491bc7-60b7e53f688mr3371941eaf.0.1747868505400; 
 Wed, 21 May 2025 16:01:45 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.44
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 15/17] include/mmc.h: Audit include list
Date: Wed, 21 May 2025 16:51:20 -0600
Message-ID: <20250521230119.2084088-16-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

This file does not need <linux/sizes.h> nor <linux/compiler.h> so remove
them. This exposes however that a number of other files had been relying
on this implicit include for <linux/sizes.h> so add that where needed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/cpu/mpc85xx/fdt.c          | 1 +
 board/emulation/common/qemu_dfu.c       | 1 +
 board/toradex/verdin-am62/verdin-am62.c | 1 +
 drivers/mmc/mmc.c                       | 1 +
 drivers/mmc/snps_sdhci.c                | 1 +
 include/mmc.h                           | 2 --
 6 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/cpu/mpc85xx/fdt.c b/arch/powerpc/cpu/mpc85xx/fdt.c
index b2c0c517e7a0..143b7c624d27 100644
--- a/arch/powerpc/cpu/mpc85xx/fdt.c
+++ b/arch/powerpc/cpu/mpc85xx/fdt.c
@@ -13,6 +13,7 @@
 #include <time.h>
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
+#include <linux/sizes.h>
 #include <fdt_support.h>
 #include <asm/processor.h>
 #include <linux/ctype.h>
diff --git a/board/emulation/common/qemu_dfu.c b/board/emulation/common/qemu_dfu.c
index 393fcaeb7422..8a59f5ade13a 100644
--- a/board/emulation/common/qemu_dfu.c
+++ b/board/emulation/common/qemu_dfu.c
@@ -7,6 +7,7 @@
 #include <env.h>
 #include <memalign.h>
 #include <mtd.h>
+#include <linux/sizes.h>
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index 7b2eecbf659a..eca2cc8bc7f8 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -15,6 +15,7 @@
 #include <init.h>
 #include <k3-ddrss.h>
 #include <spl.h>
+#include <linux/sizes.h>
 #include <asm/arch/k3-ddr.h>
 
 #include "../common/tdx-cfg-block.h"
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index cdcf2e0c8fe0..9421a846e458 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/sizes.h>
 #include <power/regulator.h>
 #include <malloc.h>
 #include <memalign.h>
diff --git a/drivers/mmc/snps_sdhci.c b/drivers/mmc/snps_sdhci.c
index f5ede38c3c17..fe834ec29692 100644
--- a/drivers/mmc/snps_sdhci.c
+++ b/drivers/mmc/snps_sdhci.c
@@ -6,6 +6,7 @@
 #include <clk.h>
 #include <dm.h>
 #include <linux/bitfield.h>
+#include <linux/sizes.h>
 #include <sdhci.h>
 
 /* DWCMSHC specific Mode Select value */
diff --git a/include/mmc.h b/include/mmc.h
index eead666ae442..87f7ef131b63 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -11,8 +11,6 @@
 
 #include <linux/bitops.h>
 #include <linux/list.h>
-#include <linux/sizes.h>
-#include <linux/compiler.h>
 #include <linux/dma-direction.h>
 #include <cyclic.h>
 #include <part.h>
-- 
2.43.0

