Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B60EE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 07:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1696E8641E;
	Tue, 22 Aug 2023 09:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f749PVd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B6E78641E; Tue, 22 Aug 2023 09:51:28 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5805B86415
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso26282805ad.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692690683; x=1693295483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41ni+KuFoavetSf8sVaar/XY9NyEYCqc2d/ZuqRCiZ4=;
 b=f749PVd6RX8Iu4/MoBTN/xNGd+m4//GUCS7kGBqGKkHbpQGJgnLEaVEUU2OzgT/P5I
 dDa92EA5Cxx05RUBHvxhgeZr+caKYUzg9KGe9KWSKAa9QZ2vMDmDjzyBGo+Ms3z54FHZ
 zpiBCWnjB+HpEd08TpjEG3ooC8gAIZ2UWbjaCvFjws+SGXSZr33hnKE2HjpJSKe91xOU
 OwdrL2JjQ+qVtkxnuTu80d+DsLOM48SQTOnNa2idKK9pGmbOnjh19/5klfIeoLsl4b3A
 /2K7VIrxhBGIY6rOrgLIOQsRRNSzFyCXpH5xlcK3jjV5eM765vHWMWcmk9vGmWh7BTFo
 bCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692690683; x=1693295483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41ni+KuFoavetSf8sVaar/XY9NyEYCqc2d/ZuqRCiZ4=;
 b=cP55rN9QOATuifwkkpgt/O/L+Y74AgVUOyKhRwDyXEUyo34VHTfxITx0STPns2r+6M
 WQOTODZOahW8xDqfTtVMuJIkq9Q8jGbHGskV8kgwkGc5jKo6VjzFG8zZ+c0a73hAArQz
 GbZ9UtUeDldV1CK68OZl7E5JSoZ+oeI+roxyVLIA1WSkTdbL++Xie0WKgZ+QOx5CnN19
 b1u2ziYeOUfa4P0bjj6fnHRFPZkelc6eGkus0jK+EcseEaTa6H7xOa0yE7hnheH077oP
 5IP7vYAgXITczH8aObKahDuziucx3ICjXi3CwK61JisJDhmKjGRcG3zyqfMheNyFlBzl
 5iBA==
X-Gm-Message-State: AOJu0YyWB0BT2ONol1RLwEqDfotBKfNrslr/QG1xCkvqf2WcKvg1p7q+
 wq2xbjiy2lA1CUBbtjuOSwYdm3nmkzWJgXWbJzs=
X-Google-Smtp-Source: AGHT+IHmyXxvecUE3voubEyqcjyup2a/yCYYnKtMxHUsR9i9gBz+2wEtMDQnfPLOdrMswQHz2dKyGw==
X-Received: by 2002:a17:902:cec2:b0:1bb:35b6:448f with SMTP id
 d2-20020a170902cec200b001bb35b6448fmr7120557plg.15.1692690683330; 
 Tue, 22 Aug 2023 00:51:23 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:9d49:2d2a:63e6:8974])
 by smtp.gmail.com with ESMTPSA id
 ix21-20020a170902f81500b001bb8895848bsm8422199plb.71.2023.08.22.00.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 00:51:23 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v2 1/2] arm: stm32mp: Really fix compilation issue when
 SYS_DCACHE_OFF and/or SYS_DCACHE_SYS are enabled
Date: Tue, 22 Aug 2023 13:21:11 +0530
Message-Id: <20230822075112.717992-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
References: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
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

While 23e20b2fa6 ("arm: stm32mp: Fix compilation issue when
SYS_DCACHE_OFF and/or SYS_DCACHE_SYS are enabled") tried fixing
this issue, fix it really by adding #if checks for SYS_ICACHE_OFF
and SYS_DCACHE_OFF.

Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm/mach-stm32mp/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-stm32mp/cpu.c b/arch/arm/mach-stm32mp/cpu.c
index e2f67fc423..8ed065b389 100644
--- a/arch/arm/mach-stm32mp/cpu.c
+++ b/arch/arm/mach-stm32mp/cpu.c
@@ -90,10 +90,10 @@ static void early_enable_caches(void)
 	if (CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 		return;
 
-	if (!(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))) {
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 		gd->arch.tlb_size = PGTABLE_SIZE;
 		gd->arch.tlb_addr = (unsigned long)&early_tlb;
-	}
+#endif
 
 	/* enable MMU (default configuration) */
 	dcache_enable();
-- 
2.38.1

