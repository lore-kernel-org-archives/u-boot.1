Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FE3D2069A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C98A788ED2;
	Wed, 16 Oct 2024 08:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="TdaLQEB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99CA88D70; Wed, 16 Oct 2024 08:13:26 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A37E88ED9
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso925052466b.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059204; x=1729664004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTagMSjjoAT3+Y1cr+1DI/oJrEfj8eDDdn9wqrx7FQ8=;
 b=TdaLQEB4cnNOSDr/l0h+0s13VsKUNb6kB0w81//xbs56HsfpNCaFQtm5J2JDat1yzO
 BwOchzz6sLIbiKNUMUuKNLvYtoxLXUwXBgbgYl3u7UnS/bU0sFjISGlAVHOGEzCZJ/pp
 fJoMoT/myV1JY9LR+2DNEuNBKYkgQdoukAzL5fLlQG/bOOEin6VQgRRI68HiaMCbyXwV
 zJtJE+1N/4GRAOnaDeeXvxGYuooCgLJZZ+Zp5KtTCAyvd2JehGy+biSkzJwn58CFrkED
 4VK8fHigVRWT77Goz4HGmq9vyz9DicSFfnsM9fVH0WPK9QcOX3mU4eD5KGInxnB7gEhN
 wDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059204; x=1729664004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTagMSjjoAT3+Y1cr+1DI/oJrEfj8eDDdn9wqrx7FQ8=;
 b=tVIIivvH+n5ktrMCIjnyG35HFzYxTblmsqDmlbX07ICbasykXGkL0oOJTkJhao2lAF
 61UlwMFIwNia8Mq3tJ4fnynsdzRb82Jek1nj9CXYqZNpeumxvxY58y4SZquhZxPuV3T7
 OWeD1lJeHjARS/7W3ez1Rh2rJ+ZnBMjiivvSWkk0WIJcZ/+vHyOHaoa3zq2cgkkWtzSj
 GuZ6H+dsuh8PP+lPylJN88wTTlf6Bc1gqFLCiY7CLSKywsO+eBdBjtyxmA+7Ple1vqmW
 gd870vz54z8rx0PlKUZ8RQOB9UtcxkJg8XP7ay0JVo2/cA2wQIXdXyXvuHu1UBZz/q40
 NBig==
X-Gm-Message-State: AOJu0YwTy/k7a1k22WVetPb9KRRkM8JkhT5byS6VhTAU8k63pRdcR8jV
 qxDSj+wM18kYrreiUbi2fYdnniEr8EMvMXT9PbzY2rMlc+tMzWRB4qmpULuG/AzhDCUpt4p78zQ
 u
X-Google-Smtp-Source: AGHT+IGqYn0SJJKo8Hvjg9/rqBYCQfMW9gR/PqHcVld0xetVdsrI9eJEXEjFXGfvv02TPWMH2r7rQA==
X-Received: by 2002:a17:907:d24:b0:a9a:6ab:c93b with SMTP id
 a640c23a62f3a-a9a06abcce7mr927695966b.62.1729059203727; 
 Tue, 15 Oct 2024 23:13:23 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:13:23 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 26/37] arm: mach-bcm283x: Map the ARM local MMIO as well
Date: Wed, 16 Oct 2024 08:04:12 +0200
Message-ID: <20241016060523.888804-27-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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
2.46.2

