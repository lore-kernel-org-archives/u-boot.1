Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A42CE7AE0
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFEA288D25;
	Fri,  6 Sep 2024 09:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="MenG1AlQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E029488D0C; Fri,  6 Sep 2024 09:22:59 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C76788D73
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so222460066b.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607375; x=1726212175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stNdP7VMeTMBUvY2/aSda2AXXC+WQPLPKoKFv1a1tRc=;
 b=MenG1AlQDniV3dQDcmC+ntlnd1SWs6eK8LAbII3yOaYQ9IckdLCivif3T8eUl6NkrR
 JLlWMUEs9k+Tt8NVa7yTwdiG4ANjfXXhUcb72BqIMiOxJYV4OsmcBWGZxR0Xpb54b5IA
 M0oaF+rqv08PDogDZbb9qfc45g7rOP6rcYs77VB0FWPIrrOZ4HcxiPtmIu5stdA3ZPXc
 qJpygE+TVi0wRDGmaac7kRXGzjKvzBicumv6U3k4SciNZq63O6vvgHyyZ4d7uBxndG1b
 yEsbKUGRcRvwYVCio4m0JYQrohpnO5ESEqj6SFOFc5GAggwmWmnfO/bLeQybmR8iumlh
 3ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607375; x=1726212175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stNdP7VMeTMBUvY2/aSda2AXXC+WQPLPKoKFv1a1tRc=;
 b=ejp7u+B6kboXhoUV6IRM38PnAu4y2p9VQIzdhadxGIFzOLjwEngw4ZFYCNcmo40TuQ
 Bezq5TtVWkdgmXGuz2dl5R1tEz9rG8WITcoDKezuw7CbiefzCgp2uQfLMOrXx2SQc2Cm
 1qpLdtYSFzT7dzF0uBQ+HD4/SZJTQ6WpIJBGTLyLNMUEJ6e2804+Gd1Nvkp72LbByvLm
 UlM8ZwfBj4b6pNEHCSAPE5CZNQWBEVUb3grtCqijZ7fTUhoEBEtxJ0WlAv9nF145cAgT
 PVDy0blwdXXYY7xC0SKeqU2MR0mnrmE7uwKe8qU9TlJ6TJNcebJcHCy8vvFhMVHs75vc
 CpOA==
X-Gm-Message-State: AOJu0YzXQD43kbHtIVI6++1gGW8Re96TsCe2Co0YD7OFIGTT9l4dTpyW
 v0nXzOsDARbnWfsfPDknrlvV6qc+ip3gf5N3lQKXIjlWCeaMU27BEjcPjz2gAp9tffp1Jjhfdt2
 k
X-Google-Smtp-Source: AGHT+IHbsqXKlOnarxg2K6wXRjEcTiC2TcvPDmUINohcWQuvwPNvu0LpJlPn66KUMcKy+ib+pSiY6Q==
X-Received: by 2002:a17:907:2d91:b0:a72:80b8:ba64 with SMTP id
 a640c23a62f3a-a8a88601b97mr127959466b.25.1725607374803; 
 Fri, 06 Sep 2024 00:22:54 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:54 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 21/28] arm: mach-bcm283x: Map the ARM local MMIO as well
Date: Fri,  6 Sep 2024 09:22:23 +0200
Message-ID: <20240906072231.2531491-22-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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
2.45.2

