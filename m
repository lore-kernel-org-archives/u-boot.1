Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7E9C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 341F58770A;
	Mon, 27 Nov 2023 14:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="joBekW7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B93876D7; Mon, 27 Nov 2023 14:01:00 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4E087634
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50970c2115eso5645873e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090058; x=1701694858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxFJwKL5zDs8b5aiVb6q3SDjOsJLBc/cfLiOxsIC9AE=;
 b=joBekW7wre4X2ODfdVkmVK88Qob7OLfRImlmLvoleDMhvElX2eBIPKsCxqJDwNvhM3
 FxMLSOT+3H8Nqt56BF5e4NWJwFqF6HCyRDMF3lWHKIz8bf95Zexi9s8dBcqTtN83QIHd
 cVtJX7UWlU5FB3BxARd7VgZiyag7wE4rQ0O8n5Zjm5I8ZtVN5blO1Bg3QYTyfjo7icQD
 OY1Ihe68BRMRDu1nTwI9Y96PRXItcRUdHDKcsnqmcyOcEAZzx6MX74ZWOwHQ5FNSAwuu
 iszoiJ32CttfXdcu2gsMm5ITk5Epz6A8+07zzGzS9Wqv5Pwcnm3OjAd+gUP8wnceuQyS
 sOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090058; x=1701694858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxFJwKL5zDs8b5aiVb6q3SDjOsJLBc/cfLiOxsIC9AE=;
 b=nDhA/4Eq7Z8rtl1cUGzbIympSIZs1hJVeirc/2/tvEycAcrh9j30TBDFoE0FgpNygc
 l+GAeoiAbW1JNMODYU2SlzigvgQ7ToKS49PcQXDZi7ru9ntZfSZ674yAUYn5r5fn9JnK
 keGXxNf92rn97kRkqzXAhJiQya1cvh+VkjaEg3+CgKD+FSeQpXSh7apHGp4dW2rFH1u6
 LUlKHwLO5Qbt7cK/XOTMZXs+wkd7dQB92dm+eh9gj7joMlpaRHqagssBlkcJ7Xt2FYu2
 T/G6zqn+tuoxW0X4xPfUDNL8MBX71d+D5PXzcQsYsziBWRJcsgM3G2ppNkz25/5fw+hF
 z+Eg==
X-Gm-Message-State: AOJu0YwoiD5aBwvgxZ3wA1g5kMLG60q/UvqVjEFH4hKTgW9ZwsT8T7V+
 ZnomAimzRPJ/BcOmrrkOhicZgoMNYOvSR2+vO8g3Dw==
X-Google-Smtp-Source: AGHT+IFO/xLprvMx/c+Xnaysyla7Az9gE7OrikWrAxCNMQqahySdSuY5nXcZv5GHQdFn39D3o1Dcwg==
X-Received: by 2002:a05:6512:923:b0:50a:71e1:e1c9 with SMTP id
 f3-20020a056512092300b0050a71e1e1c9mr5745992lft.42.1701090057984; 
 Mon, 27 Nov 2023 05:00:57 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:57 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 21/43] mach-socfpga: do not overlap defines with lwip
Date: Mon, 27 Nov 2023 18:57:04 +0600
Message-Id: <20231127125726.3735-22-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

