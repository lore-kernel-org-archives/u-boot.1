Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E44CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1062389392;
	Wed, 23 Oct 2024 15:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="gPCs6TI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD0388934A; Wed, 23 Oct 2024 15:29:35 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385BF8933E
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431481433bdso71820425e9.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690159; x=1730294959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTagMSjjoAT3+Y1cr+1DI/oJrEfj8eDDdn9wqrx7FQ8=;
 b=gPCs6TI2a97S+A0cG3pvh31tmktLgblgZc/5wjx21g2WDzgjo/r0tKI/CHT8u1k5Qf
 K/CCgZqguZOPyxYvDzOVQK7H4xuNyNmw3n40D6BbiL+5cM3cQNtnNvkJ0j1mxoUUH2ly
 J9/r0m5XP4TlaQ+VM8GGZ5d61VlBKVK8xWVK0rdMGPzUlD2vU5gwzE1XJsR4P8vi0src
 3tk85U2dnijSFjTAsKt83Y+qi0yb5A2ES7h+1o9ieBGLNxrWZM/tq6uRJI6+OqH5zAuG
 4MEdhPontkYv3RsXvMi7jn4w5jybbHt6dGvRR/727XHlN8Cj5B7yjTWu9pCbAEdk8k0k
 N1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690159; x=1730294959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTagMSjjoAT3+Y1cr+1DI/oJrEfj8eDDdn9wqrx7FQ8=;
 b=wKDtjoRRFOz8js7GUnTcAQpHwzGBXe7+vOl8PPW7d70TnGLKU28A8SZORF9Mp5oJ/X
 +/YFFqL9TXKEN6EgNrRWtMu5kiKg3nrt9PtDoGOkPBtNj8k6PFL02WpKemLzvw8W4w/u
 hsRq+hYN/3jfv9/FHofa8h7IYL0ZzcbMlcdLfnjy+ifhC6B86FcW14H7ERppVp5mbhRH
 IGcsE9F1Jy+XKf5By1/kpB9vRWkahDAzeu9/axfF9IK/eUKrfCh5L3jP+pZUIzZH/2BE
 ZSJH/E2kmGd0dUakyam7JBP1fd2feuXFvGcwD4NHTM9V796bla4uLMJq4JHCWuBtNKjX
 doFg==
X-Gm-Message-State: AOJu0YxolIqCtfbz3RuQHM4JsZ+4tjTNjaz7/+cIKdJzvlFSzifRbeHK
 +Fkwmh4xvuwNcKTuUNN2JXRVtlf0tO1Xehkf2rHUiWB04NOy0LwHL8qnZLXFCs5vd8IG495mOVy
 9
X-Google-Smtp-Source: AGHT+IGsx7VdRfBhmn7wM22CHs/QrZAvZ+yXznUgGsCaqo0DVKiTHGFpLYTqfpzdzUF62ZEAW5F3NQ==
X-Received: by 2002:a05:600c:1e22:b0:431:53db:3d29 with SMTP id
 5b1f17b1804b1-4318415f712mr20499115e9.18.1729690158549; 
 Wed, 23 Oct 2024 06:29:18 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:18 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 26/37] arm: mach-bcm283x: Map the ARM local MMIO as well
Date: Wed, 23 Oct 2024 15:20:09 +0200
Message-ID: <20241023132116.970117-27-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

