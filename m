Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222CBC3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 15:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C37987808;
	Mon, 25 Dec 2023 16:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fTWi75a/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021678780F; Mon, 25 Dec 2023 16:42:10 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F004D8744F
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 16:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ccb923c4d2so11322711fa.1
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 07:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703518926; x=1704123726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxFJwKL5zDs8b5aiVb6q3SDjOsJLBc/cfLiOxsIC9AE=;
 b=fTWi75a/dZ5pOlid97zusdR7OQemOXJvph9PjjcbNFAAfgZ2OnPunWnw7WFf1/sihd
 nTomjFcIcLfR2okjrsox1Foyky9+dXZ3CvtbjvnBcn643xQOuFMeXGccbv4c5po5n4vC
 l3SiXR/gvLLVR/NF9nCCBGhpK3/yQcDOPwhKYWpupbQzW0pDSbGRAKbV31/PyNcCZoSA
 HIbHA7UPGl7/wdq8a1meUVTeBrC/iEO5Wsymo1ZSQCeXAM9HVlj09+IP9oXu0AhpzXWM
 uTZBDTIAlKMe1wQca1t7DxW2secM2hrkuxsd6qBEgt4rZRd4OUJmRxbT+8+tdHqkVRDM
 E1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703518926; x=1704123726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxFJwKL5zDs8b5aiVb6q3SDjOsJLBc/cfLiOxsIC9AE=;
 b=cuzJZGAQS8dcbW/UbSTUzNri+hFWNEwqrLZhJXnwedSr6wflZTVl+j26tZY8ADbyjD
 ZppRgA1HQJOMUp1zdFSX8TqUJ6SRBDyCWbXSt9GXS9x6gp9mb5If6Fg+UwQAdANFRAgG
 6xw1KOor1r/Ci8DOaHsrQvQChrFBBBDGB22Co2fp0/fRg+U9doCrugERpU33WwbVT4rE
 jZkgEgvg1XsFemaOv0JeWyeaIOvlKMUL4hUdYVJDIjqUsU5pUTDUZKmW5P83xyJEsAhi
 m9gVk27HpPkQg4L6M6S9lqH/j68yGDRkzR1gRMvUVxaWl2Z64On3PXMvi4KZPSnzITCo
 xp4A==
X-Gm-Message-State: AOJu0YyZhEPXpgGM/V+Bg5QsYNmzdl5EJeQavBSWdjnGlQNELFu3Yypl
 LTM2++Cm4Zq/HRIplDnI+y/I6NOrqg/g5KA8DCbe7PBYkVM=
X-Google-Smtp-Source: AGHT+IENWK3r7tbjd67gsRovSx06YsS6dW74OozUFvQu53CEWidcO3LQJksZGRzl3xf/wyzXdwmPtg==
X-Received: by 2002:a05:651c:227:b0:2cc:8b49:6dbb with SMTP id
 z7-20020a05651c022700b002cc8b496dbbmr1439501ljn.62.1703518926692; 
 Mon, 25 Dec 2023 07:42:06 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a2ebe91000000b002cca6eafc44sm1425644ljr.113.2023.12.25.07.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:42:06 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv2 6/9] mach-socfpga: do not overlap defines with lwip
Date: Mon, 25 Dec 2023 21:39:26 +0600
Message-Id: <20231225153929.8284-7-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231225153929.8284-1-maxim.uvarov@linaro.org>
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
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

Fix compilation issue with overlapping lwip and march defines.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 6 ------
 arch/arm/mach-socfpga/wrap_handoff_soc64.c         | 9 +++++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
index 902fc6bfb5..9b85e5865b 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -78,12 +78,6 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
-enum endianness {
-	LITTLE_ENDIAN = 0,
-	BIG_ENDIAN,
-	UNKNOWN_ENDIANNESS
-};
-
 int socfpga_get_handoff_size(void *handoff_address);
 int socfpga_handoff_read(void *handoff_address, void *table, u32 table_len);
 #endif
diff --git a/arch/arm/mach-socfpga/wrap_handoff_soc64.c b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
index e7cb5ea89c..df0701ec85 100644
--- a/arch/arm/mach-socfpga/wrap_handoff_soc64.c
+++ b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
@@ -10,6 +10,15 @@
 #include <errno.h>
 #include "log.h"
 
+#ifndef __ASSEMBLY__
+#include <asm/types.h>
+enum endianness {
+	LITTLE_ENDIAN = 0,
+	BIG_ENDIAN,
+	UNKNOWN_ENDIANNESS
+};
+#endif
+
 static enum endianness check_endianness(u32 handoff)
 {
 	switch (handoff) {
-- 
2.30.2

