Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BE8CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F06F888DA2;
	Thu, 26 Sep 2024 10:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="KrcSEMzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2449888DC6; Thu, 26 Sep 2024 10:03:09 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25BAB88DBF
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c5b9bf9d8bso365878a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337778; x=1727942578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/rIYigK7VdzQ4KUqwavZH+9L2ud78EouKaq2G/zCPw=;
 b=KrcSEMzdUBuxX+YTYm9vFmes7mWeSar3Eqll3N/i5811o3nTehLbbSWTvoW9VvsrEi
 BE4FUI266VbbUksqi2zbHeDTQgPUqGv6haxZ0jWLkrz24yB85mq2WooUk+7H4iPMuKWq
 650DmSZj7kGWa8pVOo7XjgIO9NMJlWCP7YVo+NAN+AxhNcxxbUO913LpAopgHb8Iyj+g
 3pwsxPxODqGNfy6yBiEnI3q9Q1+8uY1W/g+FZTu4R/IlKcenudy5uUSJ1jFoxPbrUob9
 M/nl3B7y/lrR8G+fgocre4Fw1OYUk26D1aAMQA/ObNxXcCMdjXXmIZyMjLhBcROAfeIk
 2CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337778; x=1727942578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/rIYigK7VdzQ4KUqwavZH+9L2ud78EouKaq2G/zCPw=;
 b=dk72csAtouFaAWxl/j7tZXevdHg7G+Ufb5PYQuJ0mqdVqQBrbciDACBoeiWJSbGq6K
 ZD5sqY4D2WRNh2bjwBuiYIsgtljL8cDB4r7uAPOl4F327de2RGaFHpXAWET9vfTVqw6u
 BD8AgYrabr1J6B8N1bpVlukHXqQSE/U+ok8IsoULrkPD1S0jYZgLNYYbMwaZ01B/FPo9
 SIildexeEkWnGsYsvxh83/gTCAr48j9EbkouqxP569DO0ufMMF95ttXc3RJNtuMmZzwA
 KAbE+zhgJ57t0lkACay5KA2slFuMPJ7N8261V6VbUrDn7f+V7f3kidXpiUkCQUn8H7LO
 IHog==
X-Gm-Message-State: AOJu0YyKM8gO4zGCIMPFyJuT06nOQna2esZfNVQZ3pzsVI1wgX4X9yB8
 7d8i3X631ANto1cjsjqubFAj4l2jp7HX9ACJ3R8CDMZEFLiI98I4r61WhO6xgxod1Wt1GJ5cV+6
 1
X-Google-Smtp-Source: AGHT+IFxmvq4gdw15Y1EfNcez0Fa1gfnHsOaeboDzDvRbMu+XOhAWCh7m4vbwwVKKXnl23r6QNDNsA==
X-Received: by 2002:a05:6402:34c8:b0:5c7:1ef7:8a13 with SMTP id
 4fb4d7f45d1cf-5c720592f9cmr5964833a12.0.1727337778566; 
 Thu, 26 Sep 2024 01:02:58 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:02:57 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 19/36] arm: gic-v3-its: Rename objects
Date: Thu, 26 Sep 2024 09:59:07 +0200
Message-ID: <20240926080021.148031-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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
2.46.0

