Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3375CCFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF0A8934F;
	Fri, 11 Oct 2024 12:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Cwg6q76c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C024389357; Fri, 11 Oct 2024 12:35:19 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069B789367
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso747720a12.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642915; x=1729247715; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTagMSjjoAT3+Y1cr+1DI/oJrEfj8eDDdn9wqrx7FQ8=;
 b=Cwg6q76ciYPdBRoypy1qdvu12y1rZUaX4IbFKS8I2M0odvfNBsffj5F9ZWfOyg7XOr
 edjqPxSM3cOW1lteCbDxExGxzKGkIpU6+d3JslaB9zHHx2jvKijo1OGW5NWAZDA8VLCN
 bX1+zmIMuW0GksPjrADaOulLwQZZWeiZQUOnQblenBVv9e7MUBl/55oUDBw0Xo4kguth
 hFOpXgIVxhkUBbVbq08dM6/3pRT1cNRZjZpRMV+/X+lLFB9mlu8ft9WK+jac6FNEq+y/
 MqiTa8siyYbfTD9A6jjVubBz3A/0IbUB3aO5h/FFnow+GkLwpSxdA2BX1M5cgjXiTDt0
 bfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642915; x=1729247715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTagMSjjoAT3+Y1cr+1DI/oJrEfj8eDDdn9wqrx7FQ8=;
 b=TZOr+if3EoHCwiFB+KogblhOx10LW8iVMBFHlQDOseudJDf1Xct3tC9CNgtvsj0rQ3
 xJlPQ7NGb3gA8JI/APOC8PCEot0UF0TTlw46Spoxc/kGN/dwgMn3nfW7SzGLzveOruhf
 mPU6UgbBtHETzoA7nLMU7m/B/PluofrglGhW4ARHmrqrhJ5bq5WpF0E/jZzDqgtTbEQG
 kdGeSEJxzknoVx41ATwOT0BlHI3Jdh5lBvJ36qXd+Ed/mmQ13eDwx1bZzvqXkbcmm2yi
 nN8EG5QVvVNDUO7erNfJzOdc04zUeyEQPZax/3ycdZ7l+/M1TGy1eBf+soQI7OrJlYFW
 xY/g==
X-Gm-Message-State: AOJu0YzOcEIRRsMW3fo75NMMswrCTC1pfIUamPcj/gA5JEg693UoRnSE
 CtqKQJOU+LyIMe8teaEBEPjsYFhEpF6UcMdpqiwtdVPfGi1MV/jjWVIc1uzYY1Yw6NuGvcj+3m/
 QMmc=
X-Google-Smtp-Source: AGHT+IFMSeyR2SITuA/7pUVBeqtzylrEMALnbbOuijzmNn1KLRO3oiE0TKchJCDbpL+0QkaOQBbB7Q==
X-Received: by 2002:a17:906:d253:b0:a99:4c5e:1b01 with SMTP id
 a640c23a62f3a-a99b96ade66mr188141566b.45.1728642915439; 
 Fri, 11 Oct 2024 03:35:15 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:35:15 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 26/37] arm: mach-bcm283x: Map the ARM local MMIO as well
Date: Fri, 11 Oct 2024 12:23:07 +0200
Message-ID: <20241011102419.12523-27-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

