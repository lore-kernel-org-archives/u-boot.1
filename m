Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6098FE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 09:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E67F18022E;
	Wed, 18 Dec 2024 10:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nOy07o+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9B2B80283; Wed, 18 Dec 2024 10:00:17 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 980868021D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso44727755e9.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 01:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734512415; x=1735117215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1rD+w14ueFryE66SOa1KgKpPjDoBNwxS5U4n8BV5Y3Q=;
 b=nOy07o+GzpLfk18tcOa8auUlARWBl34NnBixsUC9GCJaOi8QPRWY8WloMlyEu1rkNP
 DuybVDBiJSyAFQKoGYhiol87stZPtjbMh5SeloZmbhQV8jANkrmcg5/v70mXoMdszIHU
 4Ea3J9/CtyluJi1DkVBcXOAr6c5p2GyVRYTCt4MYDlAX006bkzJkEnmui3tQmoBYc4kZ
 +8quEAuTdL30PNohkWfChjc3TWFnirlluhDm0merdJ005vzojAF5ZQo61hFPSSdT4Ked
 8Zj4IHDEJ+kg83O9xxZPmw+sg5p5sXUKKGKNvvyR3GQVqIT5/4R5Z46WdJOywbDrr5nE
 10CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734512415; x=1735117215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1rD+w14ueFryE66SOa1KgKpPjDoBNwxS5U4n8BV5Y3Q=;
 b=Q+cRUOfh460YIyKIz7/okjhW/AQvTFbONCDsqcXDCLdZqIjSCZy4//1WM8e5rXUCtw
 IQU5mQXRTTB36Trc9yOsGF46AKskdRDQ0sBhMdOSGc9lLvbNje8qXJ8xhsSfrKPeZDkP
 ruvBhHBE1l7LzGFvjAVTHBuy37NqsCfycPRNl9n9tz67zM30l4SCroMJtOitnkwRLOgZ
 PYD/hz0c20JHZOf4nshMKv8mASiRcoHdndCav2JF3KA1EYEVTq5LUbsWAAJF7UXNeCtG
 0kl05TYWZwaNO/T605BGqeBRbqfgA0pD6cm0x4oMPFajlizm+EyCb/GV3ua3cPWNB7E1
 +h2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIob8NMCwC2sktLl8aTh2G7JmrFN2ilwG15J2S/SJLONjBQiEagU1gq/aR5Qp0m127+BT1FLg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5eYdPeu6K0kGxrhqFVpuqIcQvg1qOWpxaHSxgROXp7/seHpdr
 SebXKyLRE0PZcpXpNxyFRrw6wGyEiprTM83fGIv5KXWisKxjRzj646Dw49td2Fk=
X-Gm-Gg: ASbGncvWBrjsnj2MYZiNrgTHnUjpsbKhY9cvsvSeE+8VYLXKCkrmRea27KaQJlIJl1M
 LC2nYMq96NXvjzI4/W1EHr4jSNeS+DcZwnu/qfrRdz6PSt7SD0+mgjxl38K0UxRJDEtWM/MQRv+
 0A+vzRuJQLEvaG4LKF7LCOL6rJNNmaltrHZUjr7XbLUWCXPSE81eWSbG0I10/IWhjFzg5YCqXU8
 /gdPos/5nqpnuhT6I3QLXAdR5j3PgFtGoEx3FcJA/KRQiOi232u5uk4nYwLb7ZnHWMwypReY92o
 Nm5WnDGcQATsJ3Dx/9DtfgR1l+v1Gezpug==
X-Google-Smtp-Source: AGHT+IGdyUrEVGQimMrRyQh5OEWQF1KRAR+7H7p+L8K4wV/qNet7JZKnaP9d5WRzX+H0gmNmD+GwMA==
X-Received: by 2002:a05:6000:144a:b0:385:e8f9:e839 with SMTP id
 ffacd0b85a97d-388e4d976cdmr1450255f8f.56.1734512414541; 
 Wed, 18 Dec 2024 01:00:14 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80163b8sm13219648f8f.35.2024.12.18.01.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 01:00:14 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Vitor Soares <vitor.soares@toradex.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
Date: Wed, 18 Dec 2024 11:00:06 +0200
Message-ID: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

commit e27bddff4b97 ("imx8m: Restrict usable memory to space below 4G boundary")
tried to adjust the usable memory limits on a 4GB boundary.

ram_top is described as 'top address of RAM used by U-Boot' and we want
to preserve that. This is defined as a phys_addr_t and unfortunately
its size differs across architectures. This has lead us to a weird
state where 32bit boards define it 'SZ_4GB - 1' and 64bit boards as
'SZ_4GB' unless it was otherwise defined.

With some recent LMB changes and specifically
commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
the board fails to boot properly although the commit above is correct
since it's making sure that no memory above ram_top is usable -- but
added to our memory map so EFI can hand it over to the booted OS.

The reason for that is that during the LMB init we add all usable memory
in lmb_add_memory(). In that function any memory above ram_top gets added
as 'reserved' for LMB. With the current values tha's set to 0xFFFF_FFFF
for this board. Later LMB is trying to protect the memory area U-Boot lives
in with lmb_reserve_common(). The latter fails though since it tries to
add U-Boot top (which is 0xFFFF_FFFF as well) to U-Boot 'bottom'. This call
will fail since 1 byte of that memory range is already marked as 'reserved'.

Since we are close to the release, LMB seems to assume that the address
is rounded up and is the 'next address' and so does parsing and adding
memory ranges from DT files, bump the ram_top of the board by 1byte.

In the long run we should change all of the above and have 32b and 64b
platforms define ram_top identically.

Add a Fixes tag although the commit is correct, so people can figure out
the broken scenarios in the future.

Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Fixes: commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/mach-imx/imx8m/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 9588b8b28bf2..85dc8b51a145 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -362,7 +362,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	 * space below the 4G address boundary (which is 3GiB big),
 	 * even when the effective available memory is bigger.
 	 */
-	top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0xffffffff);
+	top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, SZ_4G);
 
 	/*
 	 * rom_pointer[0] stores the TEE memory start address.
-- 
2.45.2

