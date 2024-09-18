Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB313CDD542
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F57488F89;
	Wed, 18 Sep 2024 17:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="K7+J+qia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D582388F89; Wed, 18 Sep 2024 17:22:37 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF4888F50
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdba33b0so8806241a12.1
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672955; x=1727277755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/rIYigK7VdzQ4KUqwavZH+9L2ud78EouKaq2G/zCPw=;
 b=K7+J+qiaodDJbUFODDjJJgOw9N3tEQ9C3w4wQsaKYfNqWNqCsDcpxdSEN0XRRfeebB
 o/gTKCixSa1LKfJ8DIHqYDGhX5cp+CH/Uly/tgHtOOtuRA/OI3IKPChfrKSGVPDpErdl
 zwBKM1TXtv1dv1AWmixLlE2lLuOCJ5dI8XGmw8kiDQeBad5KDLLgnM4YtpPuGrEXF1Ta
 /xzwUrFK+P27rTDIPVgwVbIuFLB3dqmL+4kaDkjv7+qTs2PlcKjfGJTc3GSxgPVramqw
 o7i970JL1KibAQdc0xq0M0Uk/p2SMyM20m8cWRe4y8qD7/zV+yyjDU/Pu8Euozq673j6
 KfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672955; x=1727277755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/rIYigK7VdzQ4KUqwavZH+9L2ud78EouKaq2G/zCPw=;
 b=MhGAmRKLHHNTsPHQBJyXWL8ChoWJKqWNm6JvKgMkFdfOzjw64O6ERuL3OIDBN8Z7vk
 R7yVAB97nD/e9HGCUyZGP/nnz9I+aPc9jj8i/YlE1shXJBX0msS/j3gg4kAwMHc0hnyp
 p4xxp3eoGqFTEMzyq6Fg5arTOevfChBcGGJDtihJm8PAt2L+vQhEHnq2+yuiL0m4nrI/
 ERPcUaX50ZqOZa+FmnVZJMmhMYt4NOvjVqbx2OIeNdSBp6+pGvUk7Rqh2uS7mgEA2u0Y
 m3+/gStdLtPawdczU4ejPGG5FePHbkHJOsfFokBsQuqV9B3sc6niPsYQBSap4gv3Gskq
 KjMw==
X-Gm-Message-State: AOJu0YxZZxJCHIhSIcGffoo7azy0F2dtAX8olhe0ZSluz+TPT9MdUtpR
 dflzurQZwO2faUM5pVFl7DCe5VShh04sC4C8nt6+CrzsvT/3SBT8ew/ZYJHMntmBe6QOJ1YbEy4
 V
X-Google-Smtp-Source: AGHT+IFlYudtYxYJqhpxsjyFTNhw4sOQ/UCVqJeeGZhxxyWT1HQQB6jd1nBpJd13J68HePHD5uGyAA==
X-Received: by 2002:a17:906:6a1f:b0:a8a:7062:23ef with SMTP id
 a640c23a62f3a-a90294d5249mr2236675366b.32.1726672955429; 
 Wed, 18 Sep 2024 08:22:35 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:35 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 19/35] arm: gic-v3-its: Rename objects
Date: Wed, 18 Sep 2024 17:20:23 +0200
Message-ID: <20240918152136.3395170-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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

