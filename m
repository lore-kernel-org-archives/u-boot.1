Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6630D15DB5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E6B88F2A;
	Mon, 21 Oct 2024 17:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fqT/sZiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685B088EDA; Mon, 21 Oct 2024 17:51:50 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78FEE88F01
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so6095782a12.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729525907; x=1730130707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hX8Derz//Q0gRKfQ60w7kaKVtD6nG972vkiP2Gw3Hnk=;
 b=fqT/sZiJNJmGbAbB2bs09ZtAHcuV79TRwk6SB7F0j1zUEOPFEgkiXr/K3G0v6kGNgG
 /UZSGXauS7DnzbRr7EmPsLsREokNvNjC76S+fW3f3JNQuHbP78ADUcSSYXjbxI0P+qe1
 74kqYuEbemhaJBgG3pFMe13ITUXSEOSKqOGrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729525907; x=1730130707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hX8Derz//Q0gRKfQ60w7kaKVtD6nG972vkiP2Gw3Hnk=;
 b=DydM8JQgvu5aCEwWhgk7JvTf7XU8sXAzsLByVfPfIzm+f5mVTQM+ptEINjSKStxRHV
 vQGo4r1OgQzZsXIr0/GyynSZXSFYV0ZIY2/W9d9PYCy9qY2WTJG71doxLUVJiDrRPAn8
 BMcuKamBNlX/okMhamkiLPLpOdFf3q3eE4EDNlqd32BZHUohGVCKq2ZFQdtNQnrUDOb2
 en7Za0mLOLEkxP4Sejnn0peRFR12berAKGuFRfRwXUWv/TckvPJNJsjQHucrCnPGmQi7
 uDQUvhVHmRojy/qDGA+eirjqJ94EW3HM8UM7DItfTTO9owU61YCUoAIt+Ih2e0fQ5KOA
 ux7g==
X-Gm-Message-State: AOJu0YzqZB6+EWMVamEFJilO2jYEeRLkgOFQw/p2XZpX7xYQ7hvNG/1x
 LivG2+uFuGhirLrJVkgxfR9szYSfLRpkFP62Nj/N5Bbagl8dPxzZRsdZyJ7ysdkvLqOimPzeBHK
 PA0CL
X-Google-Smtp-Source: AGHT+IHr1r8nBYrAkNDiicnbNxtm3OfvG3V+vb6nB3I7dtQE9Mp7KgqIN8wsVwCXvgL0nPJHfa3yeQ==
X-Received: by 2002:a05:6402:d0d:b0:5bf:1bd:adb3 with SMTP id
 4fb4d7f45d1cf-5ca0ac5111fmr11352206a12.14.1729525907393; 
 Mon, 21 Oct 2024 08:51:47 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d798sm2143886a12.50.2024.10.21.08.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 08:51:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Svyatoslav <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] common: Drop check for DM in initf_dm()
Date: Mon, 21 Oct 2024 17:51:29 +0200
Message-ID: <20241021155133.29557-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021155133.29557-1-sjg@chromium.org>
References: <20241021155133.29557-1-sjg@chromium.org>
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

This is enabled by all boards, so drop the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_f.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index f1bd70fdd6c..8684ed71284 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -811,9 +811,11 @@ static int initf_bootstage(void)
 
 static int initf_dm(void)
 {
-#if defined(CONFIG_DM) && CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	int ret;
 
+	if (!CONFIG_IS_ENABLED(SYS_MALLOC_F))
+		return 0;
+
 	bootstage_start(BOOTSTAGE_ID_ACCUM_DM_F, "dm_f");
 	ret = dm_init_and_scan(true);
 	bootstage_accum(BOOTSTAGE_ID_ACCUM_DM_F);
@@ -825,7 +827,6 @@ static int initf_dm(void)
 		if (ret)
 			return ret;
 	}
-#endif
 
 	return 0;
 }
-- 
2.43.0

