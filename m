Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B932EE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE27A87010;
	Sat, 19 Aug 2023 23:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mx6RFN9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0DD86E8E; Sat, 19 Aug 2023 23:23:26 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 837D586ED6
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7911dfc9824so80265839f.2
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480202; x=1693085002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9x3uiU5Y18KO4NomZO3T5cmrnLhli0YswUsOeEnCgHI=;
 b=mx6RFN9kRMpRIzFUtkaMRS2o2FkxqIku41BKIy9MX6EoEiVQQhMOSDDqNGKy9a5TJS
 bjqfg83/oMRsunsBtKrr+j04O19R50SwfxqYU4x723syrruWjtUlH43LHPWL7l9Kh8wa
 bzlcgPpBKfUIN6n6VFkgXdgMgfmrLVWsi2ii0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480202; x=1693085002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9x3uiU5Y18KO4NomZO3T5cmrnLhli0YswUsOeEnCgHI=;
 b=bLU65QSVJLMBk3gImRkiy5Ij/BHYyFnUbB1NSKRcSlV3DWhG+tA0OMvNCUPjy7DC4/
 lp2blyVkfRaPAbbadtSv4WAxlxLUgnHpuxME4mPesA3KKNC12WzE3gnlBkj2qay6Pwio
 aVhajFCasB5JcMaYAo3UYuni8k6smxZmsgmBg1LIcsbFXlENNHIVBi/pZECUtOB0bmml
 VAW04g2TnGN1zHh6jQNk1SVBynza1jCC8p8Y+66m+sFYuMyhBiLRuBl/yFTb95egRTtB
 6GLnMGu1nZF8S9c0FSJGONgIjrEE779va6b37bZxsAJQFcWPHjoxG2+04GmPlKm1RFeg
 +2RA==
X-Gm-Message-State: AOJu0YwIK6NFTOUaCHb8vGg4ulndtbPBkiOCIVle6SEZDF1wgJvzM+aZ
 JDOrcIzm6zdPZ5/4wBLlVaejm0MFyZVWnd0gzdc=
X-Google-Smtp-Source: AGHT+IFTbI7MwZEyZENe4zB2G5tQSM2HhVbRS0Vh3Lm21Va2pQKyoQQH7qiWCkNvCs+2Px60EF8ijQ==
X-Received: by 2002:a6b:e217:0:b0:760:e308:107e with SMTP id
 z23-20020a6be217000000b00760e308107emr3995685ioc.0.1692480202088; 
 Sat, 19 Aug 2023 14:23:22 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 05/19] x86: Allow APCI in SPL
Date: Sat, 19 Aug 2023 15:22:43 -0600
Message-ID: <20230819212309.1094440-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

This is needed so we can find the DBG2 table provided by coreboot. Add a
Kconfig so it can be enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 07e61de5b641..a9dca5f52b5a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -289,6 +289,14 @@ config ACPI
 	  not necessarily include generation of tables
 	  (see GENERATE_ACPI_TABLE), but allows for tables to be located.
 
+config SPL_ACPI
+	bool "Enable support for ACPI libraries in SPL"
+	depends on SPL && SUPPORT_ACPI
+	help
+	  Provides library functions for dealing with ACPI tables in SPL. This
+	  does not necessarily include generation of tables
+	  (see GENERATE_ACPI_TABLE), but allows for tables to be located.
+
 config GENERATE_ACPI_TABLE
 	bool "Generate an ACPI (Advanced Configuration and Power Interface) table"
 	depends on ACPI
-- 
2.42.0.rc1.204.g551eb34607-goog

