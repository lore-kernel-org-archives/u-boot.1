Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E18CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6973788F47;
	Fri, 27 Sep 2024 00:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V/wr4MIY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 144AE89038; Fri, 27 Sep 2024 00:47:26 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 037378902D
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4583068795eso11096801cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390843; x=1727995643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJsKNr70SB3vwB7YlFsEZ3XRjh8wMdovjjZ0dUHho7s=;
 b=V/wr4MIYRI0D/+opJMSFZy19xyBm/Q3Vn9LpgpEHAjje/8o6ybwJD3xiwJyebVi0+B
 uxLWmnWrXXSL/wVuou/fqDqbaHCdIfzToxdUv9hdI7rLz6y3ZUDi0dXShb9NaYutePtD
 G6hFRxJ52WvdYNsVcO/XbmpSVvvQBj4g27WSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390843; x=1727995643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJsKNr70SB3vwB7YlFsEZ3XRjh8wMdovjjZ0dUHho7s=;
 b=H2sYM2wt2HsFvGRoEvqWwm2zUr43pSOGful+LtywhdZ3jNXH6lThs8eftqWhCDeISu
 i3OX29pbdThcuOzij/OwRiGOCiMe7EjyCYchms6fv/pCT0fvUrx5XvYaKbDuqwxmUi/T
 qF1liegIV9NbJMFv9IyTT2iIBKXzRSnU//m8N69GpU9lm1nf9qfFYhE9JpSz1s7twKdd
 V9lGQ5noyv9MtRldbKvRK/Xc4KdtcJbnwjRPSRwyqKnu/NYsKYDsaqPeMM4PBUBiEcQ0
 7ks5tZi9ncDLkSOqxFy3k8ZLZHnXlIvSlDEuv0zfTDBl5fm9LqNjyw5GgqMCfCcSRVCR
 fQfQ==
X-Gm-Message-State: AOJu0YyovgrAmwZXsaVPSdVIt8ZPL/0Rzk4Xe9iB6LGZp/9RbiID368z
 ngfXJtR7oLbARb0CYJSyBvEJh9jAW+cHR3UKyCpJM9ZkSsIzzN6/aSViGaOE0Ae02Ew3Mz5af0I
 6PjQQvpM=
X-Google-Smtp-Source: AGHT+IFI17g8USgpPi2EGWWv4oiFDDB9Hui+3WU5f8nSDuUH4pXvtDivIwSkXO60Wuy6ynrSyJUpYA==
X-Received: by 2002:a05:622a:5c7:b0:458:4f11:3e15 with SMTP id
 d75a77b69052e-45c9f1be853mr18087791cf.5.1727390842817; 
 Thu, 26 Sep 2024 15:47:22 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:47:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 40/42] README: Drop SoC-specific comment about SPL
Date: Fri, 27 Sep 2024 00:36:05 +0200
Message-ID: <20240926223814.1276764-41-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

This should not be in the generic README file, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 README | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/README b/README
index 54ffbd0975b..5115d28fac1 100644
--- a/README
+++ b/README
@@ -213,15 +213,7 @@ board_init_r():
 		there.
 
 	SPL-specific notes:
-	- stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined and
-		CONFIG_SYS_FSL_HAS_CCI400
-
-		Defined For SoC that has cache coherent interconnect
-		CCN-400
-
-		CONFIG_SYS_FSL_HAS_CCN504
-
-		Defined for SoC that has cache coherent interconnect CCN-504
+	- stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined
 
 The following options need to be configured:
 
-- 
2.43.0

