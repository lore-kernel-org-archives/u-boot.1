Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92C0D16261
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D73489148;
	Mon, 14 Oct 2024 15:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Uq5motHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191A189135; Mon, 14 Oct 2024 15:12:43 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F7289159
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4311bb9d4beso27105695e9.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911559; x=1729516359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
 b=Uq5motHxLtC3gwHNsztmi9GPnbvwlLOn3BEpmvWPu2DKrt6TCGzKS+8d/SwnKzxvs1
 s4yyoKliks8oG37MFirROBEl3+3/z7eDRoHMenWAUKJFDCcl36txVaL8Fbpe6mBompjg
 MhFEcgZnTjG82+4YYRA9wnQWZ9ucKAEav+Pv6EPd9fTZL+PGEhcrFiq+DcCwac/Qz5ZS
 3aV8mkQI18sKbKrTQJteWuqGlVn0MZm1hDR8jUPy5b01zBB3bBrrwcAO7zyF0gY1hxoV
 Qqe/vEd9PwSyGSH4I/2nxPOgjHMyytsAKAw7uWYI3byeh3SDWCLSfBXaZE1eVDOrtCtG
 YhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911559; x=1729516359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
 b=WtnYbLkM0SwQFVw19JCGV/4pRKDSRqMvgpJDcN27Kiwjzc9VQaAQ/h0nJLboDEvN+s
 IaPV/D6xsO7f9qw3NcRZkReALQhqERTjRO0m4fDfuO1I+i7Jio7CjzJhJFUxRKzq2daB
 grRj8sMhVVVmmX/VMXBoHFIfZ4vK4GEPo151J2iOQjC7IOej+NKbri876bfw2LMjH1Kx
 NidIc+5LzHU4crhOIBzeUt6ecMuTMtf1nKhT3tD/LanGiQ01KGpbxfjaZSOLasFp9deT
 66/KVTwV4IkNXPfzQTot0yLuCMb8GZyqQkI0MTillqbhLqu4m1HOay1ulrwBwnZoURH4
 MoeA==
X-Gm-Message-State: AOJu0YxJiaQOmCESPOvQlVJsi2OGqgWelODPYnE27FdzIvvxlS8h5Ddj
 EcMF4AjT6eGtzEWXeE1gjEs8tJpHyHfFzRxaEW/f44+Q3KpNm6FGPw1jeddlvi0I+Q0uvfswq/1
 L
X-Google-Smtp-Source: AGHT+IGj0MwCKR2MeiqrDaVvTrocU1E8krT8EDVu8ew13wXZJYAh/affenkYThVKylu0LkiXjBZsHQ==
X-Received: by 2002:a05:600c:3584:b0:42c:cd88:d0f7 with SMTP id
 5b1f17b1804b1-431255dc85cmr71851285e9.10.1728911559521; 
 Mon, 14 Oct 2024 06:12:39 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:39 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 19/37] arm: gic-v3-its: Rename objects
Date: Mon, 14 Oct 2024 15:10:35 +0200
Message-ID: <20241014131152.267405-20-patrick.rudolph@9elements.com>
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

