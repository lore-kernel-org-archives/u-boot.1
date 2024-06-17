Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D700C27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AE4688271;
	Mon, 17 Jun 2024 10:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jSehmHC1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B8DE878ED; Mon, 17 Jun 2024 10:03:59 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C9787CDA
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57cc30eaf0aso1523299a12.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718611437; x=1719216237; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AJ93HwsqAXtIbUSZ7NQ6F4J0JBSryn27ujF9AziP7Ik=;
 b=jSehmHC16UZT3lhnOD8IXotkfwR1KRSWQWeTLJGJpgleiM7B1kWHgCnk0tLAnNDQNs
 7Y7EEtIQZqFCiU/vTgVTCbgQuovAP49oA48qHTJZLtmoLvMs08ZSbHSwklOGmCrCGSP7
 cLdx5tIRQwPJmEZJN4GxEFRlniNh1LJB2YAni0UfqfiIUWKMzV8MvvDaOjCWKQOJPJCU
 B+14RD8KCNi7QTa5Q6mja2dljBXpeZFNzp/lOAQixrrgtUiG3MV6BadB0uRA0bB39yvJ
 h9aOMWANHXq0yUW5q5Ssv3Eq9Z5gy3xdsoccZ660ZeNJvQeBISxb/oCL85VZMQbiuFpq
 u4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718611437; x=1719216237;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJ93HwsqAXtIbUSZ7NQ6F4J0JBSryn27ujF9AziP7Ik=;
 b=PhBg3DUtuYoNyGskK17qI5VMmZKk8m7QttNnIFXD9UwhOS1YA/WC0RU2btkBCdlWBn
 6BPQZtoZIQXh2t3SQ7Yxq33DbJQzJXqzMJ5uAdOYzm5gvaoOwpQWsh4mXhaYahMvx2/A
 LvlAoMQqNoVQoXgd8ZEICCBJUqpoRPjo5sB7Iv+TaWNM1rz3aeqCGd5Yq44PBVUUrjOm
 JvZuDrpCSuOjDBqiMo6TZZdp4oxCCSnndggKVtBuaPDzXIPUSOZs603buG717ddBRv8K
 Ajl/wptG7oEoimrHT7dVTVCw9ihOR2i4jSuNf+m8vqPGL5koWZgi6buEthiVSOWP3lwP
 fKpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWy3XagnflbVKUuyqo409IdA6EmcD78jps00uoPJ8gQRV3qnRj2bSzhj9S0OhUSu/yERLvKEY0L143+hRkwTDdEww+ww==
X-Gm-Message-State: AOJu0Yz0XBI3Ev7pzYqA7L2MJ5AaMIawaNIcoV/HiZkaxF1H27VXkk+D
 6PUsMrCle/o9647YMHAJIH/3eJBg4d6F4NslqXCorTypASecJY6h+/QIGWVoPjY=
X-Google-Smtp-Source: AGHT+IHjFTZQF5z9H3TODeXNjXOmoTqTjOSRo3JJKJoNffgIKqAKnfxKMydeDqGQaVfAcZbmy3cjVw==
X-Received: by 2002:a50:9e2e:0:b0:57c:ad96:14c8 with SMTP id
 4fb4d7f45d1cf-57cbd69022amr6846183a12.23.1718611436524; 
 Mon, 17 Jun 2024 01:03:56 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ecdd79sm493224966b.132.2024.06.17.01.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 01:03:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 17 Jun 2024 10:03:49 +0200
Subject: [PATCH v3 3/3] doc: arch: arm64: describe pagetable debugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-caleb-upstreaming-v3-3-1ba35dc9179d@linaro.org>
References: <20240617-caleb-upstreaming-v3-0-1ba35dc9179d@linaro.org>
In-Reply-To: <20240617-caleb-upstreaming-v3-0-1ba35dc9179d@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=TPOgzFdhZenO6Jgr2nYHp08fJzeSlno4tUwmj5uCwUg=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmb+3oFbR+A5QkEy3+DMbs7T/R0Go6c0zME/2nf
 Dar86SbWmyJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZm/t6AAKCRAFgzErGV9k
 togPEACiNd1QYtbtPW7RxxspYzVgJimcDrsKg6M4v+LUXj/FmpoBD0IAi88K9ovWubAxmjfOneb
 Bybr7T4oIL8x5p6q4RS8fUn4x+cKJ8S2gcKitOIN2x9eET3OjrE89ekqV3eOuyGla8/LdbB81WX
 0kmKLjlukoYNfs0VbNIfk3XtVUZGND1WAA2kwc7tuLGVk2Pl0YphUfm0wk2N0nLDtq7f2gGa7Tg
 TTqCDRTIR2oTjeZnuTgsLwOTuGJODPGbtkYNVoeX5TY7kF4ogp7DX1CouwANfg/pyVq50gVshY2
 G4B7bfqWuswz7zntYtqZtldipGaShF8TYKblHb9CmVQVngLEQTnoRjRqEoR7euj2osLZ40+xqlM
 i4qsLg/107oO5oXm1GKH70+GhWHEz+0LHa8XjgzIru9sZRyyIhWcPT5KFOclQp+yyTWp40u55LS
 w+/YzfzkgzYn1hZftsFwWUXlzHmUNGcEhvpcO/TpxBn3PmxFtRUqZjmSGb3Qdywguc79uiCvM4J
 7m0Mcf3tES/0zkfp2Fcv9XMpHAwaO8qfLkHiIff9rWanM9mSkLzwQm0kmnXh/NtoyLO8DYFn5IK
 y0v6LqryRwL9gYtjreQDi0XOUo9y2Ym3eWNuxGdBOZXTA0GESPLf3vfwE4GcGZCkVrBS47Btd8M
 TCnYvH03HJoKkSw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add some brief documentation on using dump_pagetables() to print out
U-Boot's pagetables during boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/arch/arm64.rst | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/doc/arch/arm64.rst b/doc/arch/arm64.rst
index 7c0713504c47..19662be6fc6e 100644
--- a/doc/arch/arm64.rst
+++ b/doc/arch/arm64.rst
@@ -47,8 +47,57 @@ Notes
 
 6. CONFIG_ARM64 instead of CONFIG_ARMV8 is used to distinguish aarch64 and
    aarch32 specific codes.
 
+MMU
+---
+
+U-Boot uses a simple page table for MMU setup. It uses the smallest number of bits
+possible for the virtual address based on the maximum memory address (see the logic
+in ``get_tcr()``). If this is less than 39 bits, the MMU will use only 3 levels for
+address translation.
+
+As with all platforms, U-Boot on ARM64 uses a 1:1 mapping of virtual to physical addresses.
+In general, the memory map is expected to remain static once the MMU is enabled.
+
+Software pagetable walker
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+It is possible to debug the pagetable generated by U-Boot with the built in
+``dump_pagetable()`` and ``walk_pagetable()`` functions (the former being a simple
+wrapper for the latter). For example the following can be added to ``setup_all_pgtables()``
+after the first call to ``setup_pgtables()``:
+
+.. code-block:: c
+
+    dump_pagetable(gd->arch.tlb_addr, get_tcr(NULL, NULL));
+
+.. kernel-doc:: arch/arm/cpu/armv8/cache_v8.c
+   :identifiers: __pagetable_walk pagetable_print_entry
+
+The pagetable walker can be used as follows:
+
+.. kernel-doc:: arch/arm/include/asm/armv8/mmu.h
+   :identifiers: pte_walker_cb_t walk_pagetable dump_pagetable
+
+This will result in a print like the following:
+
+.. code-block:: text
+
+    Walking pagetable at 000000017df90000, va_bits: 36. Using 3 levels
+    [0x17df91000]                   |  Table |               |
+      [0x17df92000]                 |  Table |               |
+        [0x000001000 - 0x000200000] |  Pages | Device-nGnRnE | Non-shareable
+      [0x000200000 - 0x040000000]   |  Block | Device-nGnRnE | Non-shareable
+    [0x040000000 - 0x080000000]     |  Block | Device-nGnRnE | Non-shareable
+    [0x080000000 - 0x140000000]     |  Block | Normal        | Inner-shareable
+    [0x17df93000]                   |  Table |               |
+      [0x140000000 - 0x17de00000]   |  Block | Normal        | Inner-shareable
+      [0x17df94000]                 |  Table |               |
+        [0x17de00000 - 0x17dfa0000] |  Pages | Normal        | Inner-shareable
+
+For more information, please refer to the additional function documentation in
+``arch/arm/include/asm/armv8/mmu.h``.
 
 Contributors
 ------------
    * Tom Rini            <trini@ti.com>

-- 
2.45.0

