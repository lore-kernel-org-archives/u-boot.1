Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F510CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C385788E0C;
	Thu, 26 Sep 2024 10:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="eMpoIG9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 940AC88E07; Thu, 26 Sep 2024 10:03:24 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8769F88DC0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8a7903cb7dso46574266b.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337794; x=1727942594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ca5CLSml4TpyqBPU8o3HLhzKjn60d0TyhaC/5uguI+s=;
 b=eMpoIG9c76Ak9B75FOC+cn81NF4GOdwwLLM4oevN6qFWlyou59+KsV61y82cxYRyUX
 rFZPqWwDKmx8kJ9M/9oFkQe97o6kDHAeCU30mxQcjPOiiDP/HjEc0M5zzLE2Ev5WDqtX
 2AhpJpEnCQUiDahYagV+FZDLH7PjsEYOrV26N2SmG0KPVcQw4Hgi4CIfmqWpuQ0Xc8Ax
 kyCJjF+fKqyDMctwLVjffR3bL+qJLfWcP87v+MtJXxdOoMl7/ozSCz5B9WbTOtWoNssX
 U4WzrbMZi8ArkyTRPl7KnyDO26L+UBFlkzN7cmHEE57GbZ3BSzBK2j7W8zXr24z7imiT
 50Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337794; x=1727942594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ca5CLSml4TpyqBPU8o3HLhzKjn60d0TyhaC/5uguI+s=;
 b=RK5yexsNKo+tOWIsmFBHJ864h8Lt89NIJPyr435pXPvTZU8bI58gnHTxfmhQ6/0REG
 sp2TGII2VDKucnXKBv6mzPnmvQuQ998AG/H1qX/Bi6srBD8ZiW7c5jZYHRwlb3SshtTM
 R7/yAFm8vtxd8y1XayEB3ucswrwirwpFRCmfmvoW90J2ic5X5cqKJFH3t85an7VmGaj0
 rCsvC5QtftqIr4kZ24/GCZGuvi9gXzvvlZZFY7JgK1wVPmpJyJe8BoROw/aUI6VhgFFW
 xAEqLjgUP12KjXjemzPPRi3tddGtON++xtS9wg8DX8khYD23AcyTxD2mskQMvJUGXvqq
 1/nA==
X-Gm-Message-State: AOJu0YzP/TatOAxWHuvKhtprlafCOTJceA7skoQs7R6eiUb1lm/2oKiI
 grsOJNer0yDwCMfZc2528Rcfg1kLjm95rOZ3pTOdzqqOESkU+mJql22rfQ55fqyDPWaUGJY+h+9
 HCjA=
X-Google-Smtp-Source: AGHT+IGlcjgoV/ZbD015Ad5nybC+w7+z/PqjG5s+SSYh27efPm2MAq+boFy2Gb63+eUNpNSH/Btc+A==
X-Received: by 2002:a05:6402:2185:b0:5c4:64e6:55a4 with SMTP id
 4fb4d7f45d1cf-5c7206211afmr6715960a12.12.1727337793941; 
 Thu, 26 Sep 2024 01:03:13 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:03:13 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 26/36] arm: mach-bcm283x: Map the ARM local MMIO as well
Date: Thu, 26 Sep 2024 09:59:14 +0200
Message-ID: <20240926080021.148031-27-patrick.rudolph@9elements.com>
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

Cover the "ARM local MMIO" range as well in the default MMU mapping in
order to allow future code to access the GIC-400 without crashing. For
now the GIC is not touched in u-boot, thus this change is a noop.

See [1](BCM2711 ARM Peripherals) for reference.

TEST: Enabled CONFIG_GICV2 and accessed the GIC in C code without crash.

1: https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Matthias Brugger <mbrugger@suse.com>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm/mach-bcm283x/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 1b459707bc..7a1de22e0a 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -50,7 +50,7 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
 	}, {
 		.virt = 0xfc000000UL,
 		.phys = 0xfc000000UL,
-		.size = 0x03800000UL,
+		.size = 0x04000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-- 
2.46.0

