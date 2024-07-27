Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF55C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE8538871E;
	Sat, 27 Jul 2024 09:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="H9S73WvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8124888210; Sat, 27 Jul 2024 09:20:24 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52686885AE
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7abe5aa9d5so274447966b.1
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064822; x=1722669622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stNdP7VMeTMBUvY2/aSda2AXXC+WQPLPKoKFv1a1tRc=;
 b=H9S73WvPyU1jJeWRXmJyiuzRZ8F8hAuzBFH/BrkDV+lV09/2LB1Pye1emV7mxSAgkb
 pGYsXv1I5bs238uZ4VOfoER1mNvXkxRq0Uc0b9TqRPMcMdb8cRRAlTlY8a/XpUMXWRL4
 wjrqkFFWqhmHzquO0Hnn8arV6slcMwIKgGTd2Z7WUzFkTRUZtz7oCV/FziDH89Cty9Gg
 KpoIheefY+h+bTKULxLLR7PuSZun7kAMs/D6cnMHcpSK7RqdT1E2/crGUtk1Q95kqovZ
 Iewd+5STJBr1r/BeHBTdBHoHlj7UkaixLK2vGpgFjJhiF7QkxF5/FAQ3GrKq/rr4iOmB
 ZJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064822; x=1722669622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stNdP7VMeTMBUvY2/aSda2AXXC+WQPLPKoKFv1a1tRc=;
 b=GBe9zKj2FVXrSK1JDT+9IQaqeGEfPL+gaWvAWFS6ckm3zEzSrL4GqZEFoZ9PP6qF3P
 h8cdeij0De6nrCZEpzsR10mH2tfQkCyjR56gwb/e5jRUQh0FOtz9aeo/faVMWeGNIgZ9
 FYgCFDIqtpPZyKdgopOgqTD3Ibkbbhk6jyy9LTn8kn/dRxxBC8SMALa1vdkdHI5p2Aa+
 l8rmIcfL7fPHZ73xFlButO27VNfTNR+v2JrpmvpCvE6v2uNM+xI72KNNIfIYeFvrrv8h
 uhlLuH0oMTkbK7LraTlGOAA4Q3XYwVfH2mX6dRkfrikt3y4hybHLt03JJEp2NyY37MAL
 SmUw==
X-Gm-Message-State: AOJu0YyguaiVlXmRrbC0W5/gle6XezCw2mFuL8rZebBnJQsCkm1FspDS
 xjhyfxuX0eRTqhjxBsHHHrjOIllRLxIDst7eUj6POG6M/NmJA34VqGYaNPpQU1GnFrP/rgwCLN8
 9SW8=
X-Google-Smtp-Source: AGHT+IEZNtWHhxVlPCmylBLHegPFBvdlhpBotj+CE7tUBcupCy5gwDZFG1H/NqTYIyk1q1CHgdhxuQ==
X-Received: by 2002:a17:906:dc8b:b0:a72:750d:ab08 with SMTP id
 a640c23a62f3a-a7d3ff560b8mr124278566b.14.1722064821821; 
 Sat, 27 Jul 2024 00:20:21 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:21 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, bmeng.cn@gmail.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 10/17] arm: mach-bcm283x: Map the ARM local MMIO as well
Date: Sat, 27 Jul 2024 09:17:11 +0200
Message-ID: <20240727071742.1735703-11-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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

