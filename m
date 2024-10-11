Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46811CFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F5B89349;
	Fri, 11 Oct 2024 12:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="EdfQuc7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817C98933E; Fri, 11 Oct 2024 12:35:04 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1389D89329
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso16010566b.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642901; x=1729247701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
 b=EdfQuc7z+tSreJwlQw8bkhNDtKaB4xwOFhAIyhflbVKeucrwblvoTT+wyD/9zRBI/A
 u8AVGA0Zx2oyHVTOcX9nwjxCvftypxneEeVEaOCtBcHxm3qx/jFUegthkJ2Inuh3LOBn
 nkl4VAq5UZM92SggVnETBaHq2Bi7GzSQF5Ey9b5oNPRsamCCGTEhGnDyWHbuKhlvC0m/
 5bDHJPe52GV30haNmsoXXJL1s3WTFSZUQbDJio6wII1HA7tU+TSWyn2fHUATr7IKqks3
 pJWAQ4qMggn5FNQRS1u7/otGsX5yyUt72WXQJW1yzHuAcY1sqrNA3KncsD3Qmuhj1hfp
 n1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642901; x=1729247701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
 b=kfngjlZozCABMMRprQdDOCIrLTLrelUv1h1bsKfAte9U6Z0XpAYyT8d3wnQxCAY6Bt
 PArenRlcxYuuYLP7bY/FLy7NaGwtLPemcVuXQZdwAT/xchyf4Xc/QSVCfL5Tmqb3WeWI
 R20afV1maz5c3fOVPAGzuCxSqu55fNLGwh5bPBxVIsUQ1CzRFLSWO0Jad/VjYycJ7bPT
 bAKppMAd4Tkt/06l/eZHhTnre79ssWxwGktvyl5++UHV9H3AoNoH1CWr1awMTjaBx8Ef
 ZgaUbzGReoiMZoATjCvD3rl1+bMgYubURNLdfYFyTGdb75fIDb5swoAOq5sBbshoNLav
 ng9g==
X-Gm-Message-State: AOJu0Yxa7gG3CJ4Z/0lL6ShcRs4I3cd/25AbvmDgIYIR7CqVDanouMRO
 O8NlxqNOXermN+mnoxiFNhtb4gJK8ozhGV59MdGOw7MZEjRcfaLsggFMR2xD/tAD9I+alRhRewb
 1jDw=
X-Google-Smtp-Source: AGHT+IELx6/9afAmAU4e05SnZVhUICTVfb+96LCeVIZV6uV7pDo0nHnPRI/3W3xE5NUNttjfNY7xeQ==
X-Received: by 2002:a17:907:970f:b0:a99:4275:baf4 with SMTP id
 a640c23a62f3a-a99b937a62fmr143435866b.18.1728642901573; 
 Fri, 11 Oct 2024 03:35:01 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:35:01 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 19/37] arm: gic-v3-its: Rename objects
Date: Fri, 11 Oct 2024 12:23:00 +0200
Message-ID: <20241011102419.12523-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

