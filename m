Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74A2D2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8841188E88;
	Wed, 16 Oct 2024 08:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="BeN91XV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EA488E5F; Wed, 16 Oct 2024 08:13:12 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC7F88E26
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a99650da839so1027584166b.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059190; x=1729663990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
 b=BeN91XV0edWFvegBN10e2OIlPOEoqoJ/H8977sRGJEYmGyPwAmPnULJmxmrfk/6o89
 58eFhmbXRNNUJFAqQ2RkIITRbqAVCZyMBvme/tKTCw+7aQQ5/J9CGAJy5RgxT6Pxdb6M
 iorb2gLRritUcgrlCzSsBYjUbk6upekBcW0pyggOZoPgKv+sAIKtHQZECRoG8YF+tGEt
 iLIAfOE12rG78BY4buz3XceBCGFjiG5r+uC3znKJDjzqB5F4joSEiu2ybQewRFDnBb0z
 5vHwC6xM/nr32nMbUR8OXqXFFaN9jbu0ld8R2LDJr/FM0zoJmiDoCA9zo2Igr0aLTIC1
 yoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059190; x=1729663990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
 b=BlJCad2OgjqiA6BPVQWXDEJiHh5qYEZidlDlfbG14T3M9EdkTQsiRZyum4WhuQw+X5
 h6uJOo0oInfadr0PPI/XYe3T3Y32TrZnGvLLILAXXhIGW/b+aoIAqSa9jzd6Pt4hm9py
 7AT1ndAdh+ubOyBi4lx//XuBZGWhY5y08n0YBu49kL4TMIAxH8j8o7D/Wgi/XKt+VrqE
 n45hlnE+ZSW72PD6nbqNbyrlMds1hD6QXQ3PF9MyQu19Cy4W3KetmtirIGQnPHeDZsyI
 wNasoLBQfXrxnwBOEpDRpXCixjX2B1lmNJnfSBYheMSRNmzoxfd7FeqlmaKZ6qfmyY6h
 38oQ==
X-Gm-Message-State: AOJu0YwxIwd+rTFNhvZ3cRpdt3kvWlGNj7AxV9YJyghFseFsYDMlPKj3
 BXM6B5xTx40BIMPJX6Awdxq9Xy3Ujfen18VAP2zFV5AuO6lWT9xCfvlZnWc4Qtjv9b1+TJWTK8I
 H
X-Google-Smtp-Source: AGHT+IG2NpelhH4v4HTQLWiJ5/W6ThQ01CMfaPPeKP0GgiWZ3F0R8evbiVt/jDL9gbMyPpo35R3zNg==
X-Received: by 2002:a17:907:7296:b0:a91:158f:6693 with SMTP id
 a640c23a62f3a-a99e39cfc56mr1323651166b.9.1729059189698; 
 Tue, 15 Oct 2024 23:13:09 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:13:09 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 19/37] arm: gic-v3-its: Rename objects
Date: Wed, 16 Oct 2024 08:04:05 +0200
Message-ID: <20241016060523.888804-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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

