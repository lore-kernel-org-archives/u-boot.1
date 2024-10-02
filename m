Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40212CF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6493189207;
	Wed,  2 Oct 2024 11:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="ECSe45Xm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D3089051; Wed,  2 Oct 2024 11:52:39 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A82008904D
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37cdb42b29dso3049630f8f.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862757; x=1728467557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTagMSjjoAT3+Y1cr+1DI/oJrEfj8eDDdn9wqrx7FQ8=;
 b=ECSe45Xmxf76GZnVZjhWnlPZLx3p3DbW2U/bgLR2g1aLltstgKYUpbx4JR6rCWszDc
 wc9Ya9UKSwN9qdYltkQNA/MRhkHkNg6+v7AsZInG0OI9qbBFiuWaqLAlGDPN3GMPm6kq
 U7aCuoWKLRkzIsdXLvx1xAaarDIO9cDTri1XGnsRyvobnsLncNRUf6ebLONo3FEhtlVJ
 OySdrLYfbo37C3S42XUTfsQIFA9jYMP4v2qVdfpSwZt/wJEuhBld5nTIB34zjh4UpVHw
 VlvHxBBKKjJl925sUlY9di0B3PcUIQXsnxAaQUoOSrA+UG4aCx7uWqSJWfus7dxR09w4
 wc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862757; x=1728467557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTagMSjjoAT3+Y1cr+1DI/oJrEfj8eDDdn9wqrx7FQ8=;
 b=D28ZfBdNlJ27zWk4kWT1SiuOuHP8T+jBMsiU2iGSI3ewZH2bia+/8Q55wfuNYkPtjV
 qLupH9YCGTMMsI07ZHnTt2CM0Ch2I5e/U6EpzGV3POh2JGi8gAesD8uuTZZNVrmHtiG7
 cy+cR2rJJPqWVDD1ORKA86elvyeUkRfGSxk4fO3vP8LOrTWB/DOjFRzbUHDdfTZ7XzG8
 HWNb3v7MUVsKrivhVknNgR2CbnYGXmdf56NTW83P2j9Uyg4KFEvkjn8UXlIAilzelS7/
 ooKyZYSOW+QHEHNXZ/n0j4ejemv4G0hXbDvyXoYlUUggSxZOaLpPeBl4pCXkpB7Zo2MY
 rU6A==
X-Gm-Message-State: AOJu0YwE9a+8m9adNAsexDUAd9xZskxmOEbAxS5poA4kS9Zf0hSzyi9n
 vab6Kx4/E/d7l5RiR0Kng1r/quLvWB5STchXvhiRARsrRTJzSJv2cBUUYVJ8YnR4u4Q0CZcUWUH
 q
X-Google-Smtp-Source: AGHT+IEVsDoWoRfE4nynaXU7XyHsTOwwY5K0zwkGZeINmNuuRS1ypkDm3YpIIrCXFhLrJ2vFtGhFaw==
X-Received: by 2002:adf:9bcf:0:b0:374:c847:83a with SMTP id
 ffacd0b85a97d-37cfb8b536cmr1457434f8f.8.1727862757088; 
 Wed, 02 Oct 2024 02:52:37 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:52:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 26/37] arm: mach-bcm283x: Map the ARM local MMIO as well
Date: Wed,  2 Oct 2024 11:47:17 +0200
Message-ID: <20241002094832.24933-27-patrick.rudolph@9elements.com>
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

