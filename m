Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1E9C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 20:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EADC8367B;
	Wed, 13 Aug 2025 22:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eAJ+Bj5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4B6836C1; Wed, 13 Aug 2025 22:55:17 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4205A8365E
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 22:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-435de7d6d05so169902b6e.2
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755118514; x=1755723314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tkNzJmysc4Mbnj4uyRvzUPcuWuSv2pZnRdLfbJuXxnA=;
 b=eAJ+Bj5RK5cIk5n3QomKAsimUSMg0aKdiyMusKE3AjKm//NcYV3TyP4okkaUIMKA3h
 mFxP5DMplZi9KzeooRJWD5pZU35scZ95my810gX6HAd7Fkhp62ngV8Y15ZrSRf8z6t4E
 Y3CpnLOgrBW2xwh4jnrfB8W/iN//sPuns+m9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755118514; x=1755723314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tkNzJmysc4Mbnj4uyRvzUPcuWuSv2pZnRdLfbJuXxnA=;
 b=r044g7d0M5FldfY/lyMONFVyiClgWgGnt3vtu4vlrJJxA0EjiUtgkk/1kN/jt12qhZ
 Yc1Jqc9l+kvm1l5n8aY62sQsqh/phg8ijJv/oYRtTPR0gmTSXcEkamKzEfJzrmLJp02S
 RVS4I6NUz0OBx8LwluseLUmv07AhtRaeFgv9Br4IPx6UISb7GyD0tgGJr6Xu6D/LW6JQ
 sW/rhfY8j5FvbfzcJGm74hcwD6GCFs/37uaGumCvYcPTvmFPWPYNxlBHrQBcMUI7477D
 mFfu664qEVGMVLgqx5PCQhJ7Quo9uSIgk7w53oTOtfFenAt8HBC8BxXahBioeINJ7dCG
 aYew==
X-Gm-Message-State: AOJu0YzH8HZmfRVHDhxHxi29fDhpxuHLUrA69xKg8djkq1BSlRp7dzrX
 wrgTX98Ryn73UZAMWWJdmcgP5aE1+PNqltq65/Tq2rvZE3156YSu81C5wRebYXtporxZCKlOIHl
 dX2CFBTo=
X-Gm-Gg: ASbGnctkvJIFLJIBtulfE3yczzyXpmq8acH7PnQUY367qoNt5JfVKABu9NvBqxffFts
 jjdSuuP1qOSXktKtXM8fM0tDB3zFCeROffQ21bE0DNYESdC94zF0thvr6bAQC+IG9ijDShGUbIl
 mpcG6lpPT4YXZYvwspqp32Qz0S79vuG19lNlcCF6rQV4XW+hbsSNkoRGSoCks09Jaj2Rq7zpGel
 NyMzNp7yJuHKNq+FgM9yREOMxf1CBoLsD1jvC96Y5tBjLwGMiBDVRQQu0ETX6B3W1G7EWP/psUZ
 drwLtz5x8nFn7Bl8gdHDBYslxw9mDQY5kO8hktgVNpdacLtZV/Y06gnFHNx3Bxn+KpK0giRElwG
 pC/G/bh0r0OouS2RvXR6BKO6CQBVBiaUd1f1EojXCxnI/OM4JAC7Nrsn0/sI=
X-Google-Smtp-Source: AGHT+IHsLNQ5xrOkNYoWGswIDV8zVpBcSlEve+C3dmJPmkfnbAQyJVWUipbP/qTNpXOeTTokEwY5SA==
X-Received: by 2002:a05:6808:1b1f:b0:435:6e0b:5068 with SMTP id
 5614622812f47-435df818011mr494214b6e.34.1755118513933; 
 Wed, 13 Aug 2025 13:55:13 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-435ce8a91e3sm778597b6e.30.2025.08.13.13.55.12
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 13:55:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] arm: v7m: Allow SYS_ARCH_TIMER here
Date: Wed, 13 Aug 2025 14:55:10 -0600
Message-ID: <20250813205511.3420638-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

We have had an implementation of the generic timer found in many v7m
chips since 2017, but as part of the Kconfig migration forgot to allow
it as it wasn't being used at the time. Allow it to be built.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 40368abc297e..73b4aad28b50 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -445,7 +445,7 @@ config ARCH_CPU_INIT
 
 config SYS_ARCH_TIMER
 	bool "ARM Generic Timer support"
-	depends on CPU_V7A || ARM64
+	depends on CPU_V7A || CPU_V7M || ARM64
 	default y if ARM64
 	help
 	  The ARM Generic Timer (aka arch-timer) provides an architected
-- 
2.43.0

