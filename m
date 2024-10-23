Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACAACF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E316F89358;
	Wed, 23 Oct 2024 15:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Eq3+nQ6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE2C89358; Wed, 23 Oct 2024 15:29:11 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6542489345
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso6398395e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690145; x=1730294945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
 b=Eq3+nQ6hb5UkZxuem2sTmaOjyiPm4pL+czWbV18JEsOhY/JSx8PE+IYElujp9asaej
 1wjaTC3Golyd2cbgFAwCerLJbp/pzxQ98XlpiVF87kwZyanhm2Xf2/J6gCng/Qd1vHB5
 sdZmaqNKBv+1qeO2EPys/wukJWHa4OjXsX6w+752TuhHzXkE4r1SRQGV3DrRbMys3eLa
 fNUNBhJIjGLqixVfTWmS1L0fCA2tJfWbR2gx8SmyB3lneqNEEapHjHpZx0lNNjHVDaGx
 SbpGA4ZreAI95Fe9jAxQZ2V61kwXxGJN19XX6xhPq7LoDcWk9DOCH8m2Pmk+/bFm1Djd
 L1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690145; x=1730294945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
 b=MtA+6Py7il/BZ8jp/bT3+wEe3BPICKjA+rZairgGtmNC5wzIdM47N7D8HOp6IcU8rA
 EDsgoKWzkzytFtZdb2r5CbWqjMwQ5/AHUOGfPe1ugV9RWQ9ksFROo+3zj0WI0SAICl2f
 fHUo7cMqxO8SoIhKtvYkNvoYT8XMX2IQayK+73OqF8BLPyvK+eHDFwE2jYu2WWz+JGOo
 0fv8GqNhKd6cgngsiHIHCaNdy7/Z2qaZqtE7cjKHOYZI2seU1KOPLBUbB6K9DG2+6XFh
 10qx83YfmrtgSwzF2UpT/9bjPOiJ3PgIE5iAbhqlJHx730KzDuus3PR4T6zysJrJGmY2
 mJyA==
X-Gm-Message-State: AOJu0YwhHAv7rx8uvi7n8VDTp3O7ahYR1MFMJ1op3pExvVr0COQ18JEW
 uQAZ9nbxWBo3lLK8aYA6g2ehOONbV1KDjR1o2nRetrHwWi9rnDsctZaCqycWXI3AXbAgyvr6ORS
 R
X-Google-Smtp-Source: AGHT+IFRsLCac7qRAy15MMsxz4Dz9HGk8uc62bVXrXo4pUYW8ZB/4MmPI63er7CCScIuvsEmfkowAw==
X-Received: by 2002:a05:600c:3150:b0:431:4e25:fe31 with SMTP id
 5b1f17b1804b1-4317be9cea6mr42411255e9.12.1729690144818; 
 Wed, 23 Oct 2024 06:29:04 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:04 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 19/37] arm: gic-v3-its: Rename objects
Date: Wed, 23 Oct 2024 15:20:02 +0200
Message-ID: <20241023132116.970117-20-patrick.rudolph@9elements.com>
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

