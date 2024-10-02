Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5CDCF31AE
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFEA2890AF;
	Wed,  2 Oct 2024 11:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="dODWmJHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24279890AF; Wed,  2 Oct 2024 11:52:21 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C3688F75
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37ccc600466so2906342f8f.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862739; x=1728467539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
 b=dODWmJHihoTLUVH9jhW4qgf3GIhXb4w/6HqUptpU8JhgGKdj9EGqWJejlittt1Yv4A
 34St4O1Bhv4pb75aepZ8t0yVWT0NfSAxL9YLJGL+cwqwZSm4CMTVXGdmh+C5lQQlZp8o
 UUoX2zcumRF2JVV9B3xJIr7VyKMlvJhfv6t451AXI1nd82e+Y1xMwbdrDwCvTKZTVyAs
 zpQ3EsG6x5v0bRGui+HQACygyoJOa3YJYuhKa/6ouDm1Z1m2pYclu1mTgecWSsooUeRo
 VzlHi2i52Ot1tJwdER3gExygxXfLrqx7qNBBxathYywObcHQLS7oheB3D63R1tLf0YV6
 7eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862739; x=1728467539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
 b=u2pkFNvsvARqexLGLLQFCUG8G75AWRuh76tE4rtc9MhjrZaLYxO1tPaSbLnS77LQb5
 1zrslh9sZHr75ANb33uKX1vBKppRb9r9f2s+dHOUUU6AKliTy92Y+G+klQ4rKaM6tF56
 Fmrdy2/LVqiRJ4FoSdISof16WUNgp46QMJxr1c6c1BmphaCTX9LEI2Kq3VYT6ksaLAZ4
 O1UGiSdHeaTL8BgcNEJFjaJjlXdX3C9gop7tysAVA0UTaSiVBlUoNyy+j1tUw2SFZmgv
 q3UygSAXXqvpJkNUOQCAZrN8qAUFggX9tuJoenQrjk3eHb7Tv3VTbsGp4w6vYaa88pab
 +1Yw==
X-Gm-Message-State: AOJu0YxfhghdyEYc1xs31pPMrEkiLVkuKqT5UgdnKxYNzK2g9XOIB5Zq
 pcDvlR/DI24ZxkP8A1TU2lPHcMhrv1QfxbiMfRhWuNn0k6Zz0B6wllzzPox9cq7xBUR2I0UGFeO
 b
X-Google-Smtp-Source: AGHT+IEtxW+6e5yR3qudzxwRb6e5rbZ4V9oNrG5A3udsg6SdizIn6cb+g8RzQmY3TRju5odI23NwuQ==
X-Received: by 2002:adf:ab0c:0:b0:374:c92e:f6b1 with SMTP id
 ffacd0b85a97d-37cfb8c6b44mr1484463f8f.23.1727862738663; 
 Wed, 02 Oct 2024 02:52:18 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:52:18 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 19/37] arm: gic-v3-its: Rename objects
Date: Wed,  2 Oct 2024 11:47:10 +0200
Message-ID: <20241002094832.24933-20-patrick.rudolph@9elements.com>
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

The code accesses the gic-v3 node, but not the gic-v3-its node,
thus rename the objects to clarify which node it operates on.

The following commit will make use of the gic-v3-its node for real.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/lib/gic-v3-its.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 2cc0a32f9d..22fa46a341 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -35,10 +35,10 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
 	int ret;
 
 	ret = uclass_get_device_by_driver(UCLASS_IRQ,
-					  DM_DRIVER_GET(arm_gic_v3_its), &dev);
+					  DM_DRIVER_GET(arm_gic_v3), &dev);
 	if (ret) {
 		pr_err("%s: failed to get %s irq device\n", __func__,
-		       DM_DRIVER_GET(arm_gic_v3_its)->name);
+		       DM_DRIVER_GET(arm_gic_v3)->name);
 		return ret;
 	}
 
@@ -158,13 +158,13 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
 	return 0;
 }
 
-static const struct udevice_id gic_v3_its_ids[] = {
+static const struct udevice_id gic_v3_ids[] = {
 	{ .compatible = "arm,gic-v3" },
 	{}
 };
 
-U_BOOT_DRIVER(arm_gic_v3_its) = {
+U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
-	.of_match	= gic_v3_its_ids,
+	.of_match	= gic_v3_ids,
 };
-- 
2.46.2

