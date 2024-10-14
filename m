Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6A6D16261
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906A189198;
	Mon, 14 Oct 2024 15:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="PsS1fDhO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D657989191; Mon, 14 Oct 2024 15:12:56 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A493C8918A
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d461162b8so2853357f8f.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911573; x=1729516373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTagMSjjoAT3+Y1cr+1DI/oJrEfj8eDDdn9wqrx7FQ8=;
 b=PsS1fDhOuo1ZxAj5N8Rh7em0mj+Kk8IAvpeC+c646Rx66CCO5GfmnFUmg4wuMO3ftx
 2h4wNmN9XVcRfV/qUgOf0z/R7U4y2HoE9MHCxhmJbtsyMcr39eykreJavLPujC+kJGXf
 oedFjTgsZRmCtNOrOUI98oGpUuSS/XaC1LnuyLI/rdAHf9fdySGN/hWzrEaUhH/R8vIv
 d+POzwKrqVuZfHnDgzdx64Z5BkWxfDLIY6VjQlnXISfaYebNYWvFtBo2B5tDOttwwGe1
 yNMg4Be20nnJfxu0eXKW6NLvfeJNzK+TJ7EoKOSi66taXxl5FY7a/6Qw51Yiqxu+HXwB
 KEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911573; x=1729516373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTagMSjjoAT3+Y1cr+1DI/oJrEfj8eDDdn9wqrx7FQ8=;
 b=S53VexM2Fta6mwBL171JicwYzMN1qLwJcV+BwAKAqvhHclsuk067dND6uB+EYQvle+
 p6X4mFRFuvBQXs7ih7WetN1jdfnfDhp0ZAj9oKPjMyBtVO04jTFXJJ7/QYsQ6YIVqHMb
 U7ClCVpvzhZg2u7WHhY0gEYUcHoFJCZwgjPZpV31uRxw9XoZv/vPp47KTNvf4j1lx4b+
 dj6yqER2PqzmclvbT1PDRieCITRgqCYLoycG5MmAaQyicWehN1y3ZuvN7H+apqFUwuHD
 +ZC5bVIE7Nd/oOXvFjTZYG4rptkGILA6QWeXlyHosVckXw7CP8t6z1yrvmhFECUH4AwZ
 TSEQ==
X-Gm-Message-State: AOJu0YzQOyDIufs6Q5SCJHCbSeChanZ8JtmQ+Ia2Mru3pt3OY3qn8B9h
 zETVfP9NrZEiLnFzpzilM3QrfwnxyeOLDNv04qzZbo19I4GIPQTW3CJ9POnKCzZp2Jp3kIGOf37
 P
X-Google-Smtp-Source: AGHT+IHD2PIfwbN9bFQnD5fIwyHSzgMFiIv30PgaCPkulyZ9shBA7sLxhjdszisKg8P6RCRoT28yww==
X-Received: by 2002:adf:fa8d:0:b0:37d:501f:483f with SMTP id
 ffacd0b85a97d-37d5ff6d6afmr5298203f8f.44.1728911573407; 
 Mon, 14 Oct 2024 06:12:53 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:53 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 26/37] arm: mach-bcm283x: Map the ARM local MMIO as well
Date: Mon, 14 Oct 2024 15:10:42 +0200
Message-ID: <20241014131152.267405-27-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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

