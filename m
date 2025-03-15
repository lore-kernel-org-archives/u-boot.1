Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE3BC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B0D8197D;
	Sat, 15 Mar 2025 15:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZXIZ/Ovp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA6081CAF; Sat, 15 Mar 2025 15:27:42 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E9C780FF7
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso3703635e9.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048859; x=1742653659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwZftk/aTnNkPL5O9M5ktbrIo6H+d1lHm0/nJzAEbYo=;
 b=ZXIZ/Ovp/HPIfQ1ErBqRs/9vBCBd03iFU6K6T6AWBQKUrc6R1EkHP8YCaZmVMZhSFK
 Bco99Zcfi2CQ4KSh3CeeYU5XKHixo84TVmOcymut3d5n2uDIsap2xnpmQWgTg3Krdx0F
 FcNEjGeLI4j8rdDRcTuSKXUzJSPRAPmeGOHBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048859; x=1742653659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwZftk/aTnNkPL5O9M5ktbrIo6H+d1lHm0/nJzAEbYo=;
 b=YhffhT4/7Ebt5FBdLFE5+5p2w3emqxpn75GiIZpC/boSD7l7G4CtNJ06rnoIkj5Uqy
 8rC48gYR0mKWN2B46MSkAQPdl7/2QKR/kluBm05lXHs+uYLTqPazYoFsvUqo8J2xBNLQ
 GpKThrtk1ejGEmpeAIGpajE94YD48VTpeOofXF57qICBEbTZDx3B2JdTpnGFZlMsBs4j
 LvDWbjv0hwci5myeFgx2uWlVuSXkgAHEUgrUzA7mKyjzi1jbuyWzwKL6frCuT33fKqJo
 ilT5jsf71qGkfZNtXWbchSm1I4W8w5RMyuV34rKwHlEQ4779bjmH8nRPj9nG32ifoxle
 oEFA==
X-Gm-Message-State: AOJu0Yz3cshhHUgein4Gp00SqAmV1pEQtAlC01Il3KncxnpkMKjYt2pv
 xVwBW6b0DGOn7c08RS2lcuh6pgbzKhyZyPzxd5KE3LLKP9R7cd+ik/62b3n6BRx5sdL5eUCeFLS
 tpg==
X-Gm-Gg: ASbGnct8vB/VyiFEpZNXRC2HQwryPEzlCEF1SW+AI01eJxljaOsiBykhpZYuOUTSXjS
 qkQv35q4FEnr13oqsnd+yFRZj6Luz/GwU4FysVevu0+ByR7Q9YlBI3jrRTUu+P0h/YVmJufh2vB
 +4aWLFwe68HAGfDT1/R7rhlw1YCg9r7MJxk3t6WmNBuPoiHJPojA62PQpL5Tnn9hyUro6yhCQEq
 uuG8NBzBbvm7nbMx3vjIdqY+BdyYPmwgsFtmxo0tqS/61lca0NMTYX86qngei3upQwZDerOxvZU
 OEU40efSLsP8oIUlc7g5T+ZTU+3xhmWy0867PoQjJw==
X-Google-Smtp-Source: AGHT+IHuZwkTpjJJkgEJIfXsgmA2e1XPRnrurc5bK3fy8F9avxNq8Cy7whmQjeoAWnFGuYlFymU7yw==
X-Received: by 2002:a05:600c:5493:b0:43c:f6c6:578c with SMTP id
 5b1f17b1804b1-43d1ecc77f2mr87166355e9.15.1742048859451; 
 Sat, 15 Mar 2025 07:27:39 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 15/46] x86: Include stdbool.h in interrupt header
Date: Sat, 15 Mar 2025 14:25:35 +0000
Message-ID: <20250315142643.2600605-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

This makes use of a 'bool' type, so include the required header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/interrupt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/interrupt.h b/arch/x86/include/asm/interrupt.h
index e23fb2c8e72..c689fc23d08 100644
--- a/arch/x86/include/asm/interrupt.h
+++ b/arch/x86/include/asm/interrupt.h
@@ -10,6 +10,7 @@
 #ifndef __ASM_INTERRUPT_H_
 #define __ASM_INTERRUPT_H_ 1
 
+#include <stdbool.h>
 #include <asm/types.h>
 
 #define SYS_NUM_IRQS	16
-- 
2.43.0

