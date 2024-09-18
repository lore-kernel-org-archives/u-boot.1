Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1226FCDD541
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA3E488FB9;
	Wed, 18 Sep 2024 17:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="OEfBE4n0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B72BA88CCA; Wed, 18 Sep 2024 17:22:52 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABD088F9B
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8a6d1766a7so892635466b.3
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672970; x=1727277770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8/tiRv6+weUx+nZM3FkLkh9Mj4S/XFFcdOhU5tGcac=;
 b=OEfBE4n0vfJ16mkm/p0MwEKgkhw1LfHlsDL2mIF9EBwc1h7JRTN52ouGM3IUoWRrTw
 FFjT2EPMfv7B5oDty9HPF/yixMutsk3kycmQWleA2FKZKeFIQdp7NNhIHjeCKFOVEqId
 v/qyJf0F4KM0GGAYQKkhj7/A+7SVNQX/iGZgevSNsm78CZpH0IHmNOAXe4fB+3DEqcPU
 /vHp6WbShAXDLY1zKk5jBXICWMU0UMuVWeTRBMRgnHKJ+Ssizo8Uou3DouvM0gmRtkSz
 KGXjvKssbxydIUcmB0P3bftv2LkWvI1XvcIvdTCLOTxX9i6DIkLq083WXSsO5MuOhclN
 8erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672970; x=1727277770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8/tiRv6+weUx+nZM3FkLkh9Mj4S/XFFcdOhU5tGcac=;
 b=ra70DMl9M4pslOBM43J8xBJ3HHreYbBYwR0wbEMI8yrRJnSqwUZ5jpzbk7rBVThZ5D
 j0zKBq57fzLaZ8kia/kN/1VLqG7oWIQ3TWZlmtMvwVTblI2AtP7gMpEqmQH3Kcr57te5
 6OSM4ltQpQBUFY/kzFEL8b0fTEWUGrI77oqsdQXi83kXpwk01/i4BphhNIkTpqcDb3/B
 2+S9qLhuJW/wlTxrL/0IqDTFQlB+ZcMJFejYJJsL/81W+fYV+ZDB071vHNWu5bkZrn9+
 3e1FfqvNkGDwMkiFnPG1RxA3ksNnRXOP58opa3tXPEtNy38HUJiwfmRJFdQTv80EVeTb
 6mMA==
X-Gm-Message-State: AOJu0YzPz49YtNmB0+EPGD7FLRmqWVv5GibrCMwc/Lp6E2PxQ3FUuLyD
 uD89fh5sLaqu+zrW32V0+RMUWzcPhx6Xon1FRIxFgiW8a4VV4VD6Ob5Hg0El2YJkbi07V14P8b8
 9
X-Google-Smtp-Source: AGHT+IENJ9eWCeIRIAyYTQ4plkrT0J6ZwDCzC/nVgEiIDceech8IY1epDiCccTu1BUUViLLxZlna8Q==
X-Received: by 2002:a17:907:e697:b0:a8d:fa3:bb24 with SMTP id
 a640c23a62f3a-a9029438205mr1948321466b.23.1726672969897; 
 Wed, 18 Sep 2024 08:22:49 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:49 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 26/35] arm: mach-bcm283x: Map the ARM local MMIO as well
Date: Wed, 18 Sep 2024 17:20:30 +0200
Message-ID: <20240918152136.3395170-27-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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

