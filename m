Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EBFCCD1A5
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 19:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F13B882C84;
	Mon, 20 Oct 2025 21:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z10uBVWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7D382E34; Mon, 20 Oct 2025 21:59:08 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E697807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 21:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c2948b774cso1113086a34.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760990345; x=1761595145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hM2e+doSNUXZHi/Q0z2qC+gSRTeHTiK4vUUnFKeIgbE=;
 b=Z10uBVWTbYlUrCToIaaSaVZrIIvRkksoK4NE2IqINGuSAaFdmgFc/S3hgyb2X4xhGI
 f6+aU3dqgYO7yRNZelLrgf/yj89oJ1k39C94gqui0qdX1iV9kep3INlYnSq8QSkCbayA
 rbtL27KB7HJjp0be7Nb0DdTMqr8/kHt2K2sYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760990345; x=1761595145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hM2e+doSNUXZHi/Q0z2qC+gSRTeHTiK4vUUnFKeIgbE=;
 b=WhW46fgD7RF0fCNg7we+IsS3xLmPlqbveaYDTDrqC2WhaXJutdGpfMCc6ysFK+wPO6
 c28Laf+8fP8N3xE0SffoQh54zx35E25I4lTTNtyWNSuBqnxZYlwhH69576NmrgHeJWyW
 xaWNPu7vvjc9q/pUudreJrxxZaPNmvEqh9444PuW59hxMUko59silcMpG1eY57YKdxRF
 Yfk8OIUO7e+0HTNJgnKoDC60xHC1TKh4/uQMPS2Lv3HzM7fN6U/mkiu+Wh6Zlia+NQyG
 ao1uPxMcfdrathK2voMKT3k9g6YSzMgQY8qcpb3GJTfegVMqm0UytdANZ+5jjhhZhT35
 jO6Q==
X-Gm-Message-State: AOJu0Yz07rJ0wXU2eL2vgBuZRxLPl2MuRuyyM8RWoN73GuDnk/068RbA
 rAL11i/eRiEV7Q0B/9ovBhhk01S/AVJQQ9+dhLAl8cbkcM3hvS2QqZBzjiwhIsgvOqqJ8209skc
 F7mifO4OuWA==
X-Gm-Gg: ASbGncvlc4hUawkrtRZPl97p6bikVAtLj6ZtJ9ZJJxUUkk7gwHc3X2R5pK0owGlPQTs
 lKHcXpJE554wh3xu28pWkeKal2711hUmxnPiNg7MLNXTil0lOatQ8UISAUcqaOuKLOvgc+9u2y9
 x1bxwOJPtrgwivUVJ2GEmnpIwoemeC7Sj3uycQX6ys36wo2NLrskFZZC5n4R1+7AlhxvFo1zzCI
 ckhyMPU0K+uhQ5htZVsia91xb9QaEUeRVlZgqV1jsLMwUnKk3V8bybaO7k1CiucczYkJku1AGd6
 5oxKKAuQONX0wS8ok4AtlqH4mwfaaEhGwE+2MoeP1V8H/bRPAPjQiDTnrAr8lMkird8Ehi0DqL5
 PpWDQcBEi1J1JpBYD5pVmhyes9TZbY7d6jxUw9wo6TBO/zOLqOBiNLatMukcxs6aFrUfpa3FTae
 e4mCgF0KwiQi5pKzortv/LeDADwCgXFItqsFj8l6G1qtn0A9wkSuWO
X-Google-Smtp-Source: AGHT+IGfwl3RJrnl6aQbPZlfbWFi07hZ2kNId+eLOR8ndUQL19BywVF62jcB3NnGiqRrvCBawzrtVg==
X-Received: by 2002:a05:6808:15a1:b0:43f:7dee:4693 with SMTP id
 5614622812f47-443a2ee2817mr5790186b6e.14.1760990344920; 
 Mon, 20 Oct 2025 12:59:04 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c28879e84fsm2926751a34.7.2025.10.20.12.59.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 12:59:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] spl: Restore args file being default in falcon mode
Date: Mon, 20 Oct 2025 13:59:03 -0600
Message-ID: <20251020195903.3903589-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009115846.897186-1-anshuld@ti.com>
References: <20251009115846.897186-1-anshuld@ti.com>
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

When falcon mode is enabled and SPL_OS_BOOT_SECURE is not enabled,
restore the previous default behavior of having an args file be
expected. Platforms which are using a FIT image here and do not need
this can update at their convenience to disable this option now.

Fixes: b1a3ed068869 ("spl: make args file optional in falcon mode")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0fe5db43d5d8..24d6ce5d7399 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1219,6 +1219,7 @@ config SPL_OS_BOOT_SECURE
 config SPL_OS_BOOT_ARGS
 	bool "Allow SPL to load args for kernel in falcon mode"
 	depends on (SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT) && !SPL_OS_BOOT_SECURE
+	default y if !SPL_OS_BOOT_SECURE
 	help
 	  This option enables the SPL to load an args file (usually the FDT)
 	  alongside the kernel image in falcon boot mode.
-- 
2.43.0

