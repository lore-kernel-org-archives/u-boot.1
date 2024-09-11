Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF4BEE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C13891BE;
	Wed, 11 Sep 2024 08:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="blk6EiFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85FFF891BD; Wed, 11 Sep 2024 08:25:55 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C1C891B0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d64b27c45so395699666b.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035953; x=1726640753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Hm7LrTly1tAv8aPJqqBuCMQJqT1IHe+3vu9BeDpSK0=;
 b=blk6EiFVFEctAqw7d+FuXI9V73eLWwQvvbEQmHVXZUJUnj3d+ByDZ53h+PhLybYIwO
 U31qzbe4ENPY5lvVCQt/X1mbr8DkMg0GXoUqMGXuTWBHshJxnGmCRbaJ7Z7rW9g65SK4
 aCqI4pq/OEGGGzxUOcFyCIzKh/Vz2t+yEf5q756Mu9kJUPTU0QBz7XUssP1IdxvGNboe
 m8fV3HLRMSTDQxj72H463uXCrz4d7Hh9Az5g6N5xfM54nydPVq+LGQIH2iK9L99d8g83
 LIzb4rbOx2eF2kS7SwQGXxHRc5l2LJuTKvf9JHXJDgE9EfjE0SfBjTwg7sNE8tu8PuZz
 wkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035953; x=1726640753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Hm7LrTly1tAv8aPJqqBuCMQJqT1IHe+3vu9BeDpSK0=;
 b=u03kY4X6uXBcHN5MbR4WV1YZ88sNgfBLv1pKAaQhFLP/GkMgGQ1PN1brYvnXP1pzZc
 uErPhTTWN5MqJmYyGwQqAQcPQ/xomc4DcDM9PPy4qSnIOkEkzeZe7HNfw12SPjvyPz2b
 Y2gBeORBKZPrtP9Sl8zIpyduvBVjmARt4HAwenLEB0sAZo4aOpgkgEkEp9YNzbhgQStn
 nnETVw0iGw1RSZCazl0qgePFVg8IeGJj7IwGy3Vzi7gK9RVNkFjHiBu17snsfKv/wVCb
 AR6CiomHU4xNYe5AR3CUThd15wfGtt7ZLKIfBzxfo+R1uClmtHacsyyD9Y4BAv7wj2f5
 rKyA==
X-Gm-Message-State: AOJu0Yy47/1vvgAln8XI5lmcFS5+kTdBPPuKAv0iK0uVePacItf2zcgM
 P7VJqEEi8OpGK/kKV5St5G5RNh9Ls3KMCbx7Oete9WYmyHUy5T4IoBCGlVbLdb1yOahIoZMYGMF
 N
X-Google-Smtp-Source: AGHT+IHekzG/N5TP0q0u/z5z3pNc1VboWjN3XD9wYi1N2ZXDKYDmS0yDDzYdDqdzV5c8Gv6rRGhtjA==
X-Received: by 2002:a17:907:3d92:b0:a8d:4e24:5314 with SMTP id
 a640c23a62f3a-a8ffab47a36mr318373766b.24.1726035953079; 
 Tue, 10 Sep 2024 23:25:53 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:52 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 19/30] arm: gic-v3-its: Rename objects
Date: Wed, 11 Sep 2024 08:24:09 +0200
Message-ID: <20240911062511.494855-20-patrick.rudolph@9elements.com>
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

The code accesses the gic-v3 node, but not the gic-v3-its node,
thus rename the objects to clarify which node it operates on.

The following commit will make use of the gic-v3-its node for real.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
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

