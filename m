Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B818EE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5674589184;
	Wed, 11 Sep 2024 08:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="G5KYqCw6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68FE889161; Wed, 11 Sep 2024 08:26:07 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34487891D4
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d4093722bso98658666b.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035961; x=1726640761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8/tiRv6+weUx+nZM3FkLkh9Mj4S/XFFcdOhU5tGcac=;
 b=G5KYqCw6DvIsEFqNkhcWM+wyUjVTqGy8D7BMCRGcgPhuBjKVxRmh8aIupgl+BCzpaS
 CnvCGs075WVLdDS4gV675/MITbefwC10O2rBLLIY56gW5knBbdwdzjXBjk4Cg516Ndtt
 0tS9LZvU0baz9h0jIK/0O75FnvIHylL0QAwAsULc7avPizqzH/DU57FdXurhfderofmI
 8CGcti0W7WjOCQ4wwIR/IVU7pv++6igYz0UPIiobIPCRpSbkF+/2l2XOmg5NtntOBK2C
 3SISnbzJjD42e5MS79u0TdwRUJDAnNfz6/vPtbOWUgH/JnR+ZqrZws63eWD5Aw7th+2q
 gzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035961; x=1726640761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8/tiRv6+weUx+nZM3FkLkh9Mj4S/XFFcdOhU5tGcac=;
 b=FBmRELoxs0gA1N8Dahm9NenGGZU8xDE5Q1+JRD02eIbAYarfTCeEL7Y2sHbsWtWIx9
 mdOqKMhDuebaXK3e2yPb7F2RjT3r1M0HH6gsbQlRzsfilbWNX7YpBBTcmQVthRuyc/xJ
 lcfU84Mxkh0dWE/ycBUQVa25VAE/FC3YFhBaRxSI9ul54E2VFlSxz5qTP84NECj2dd00
 iA986M1+42am1+X9AAynZ4Im7UXG05wjHD60kBFjYqTsEe7sxAXQ1SyOEleFzfvMIz/m
 gT2hr3nW/prz3uH1Nm+YQrg7NauRuFodNDee6lsrXezgQpTt8WFNryc7rgkcIifrYVN8
 G+QA==
X-Gm-Message-State: AOJu0Yxn2LUK9pa09+ZiBogn6RCVyz+aOxmy5EEjiA02TqvWwSzNHp2M
 W2G+roSUf1AKW01S8MqQC4Jdbvve4VIY7GtR142DVlm1dY/rkmgx/24wl49Mvf4XooSoOpu8sD8
 xUi4=
X-Google-Smtp-Source: AGHT+IFCUcdaAdrErNQpnw9H6YCzk7WPUTuqSwJRY7Geqg+H6BS3SWQFELt0GZaJJ7ABkyQUCTdrKQ==
X-Received: by 2002:a17:907:7292:b0:a8b:ddf4:46f1 with SMTP id
 a640c23a62f3a-a8ffae24714mr299095366b.63.1726035961639; 
 Tue, 10 Sep 2024 23:26:01 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:26:01 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 23/30] arm: mach-bcm283x: Map the ARM local MMIO as well
Date: Wed, 11 Sep 2024 08:24:13 +0200
Message-ID: <20240911062511.494855-24-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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

