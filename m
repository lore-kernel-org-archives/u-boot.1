Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E78CC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB6E878FC;
	Tue, 26 Dec 2023 16:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HKiOmC91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6AD86F56; Tue, 26 Dec 2023 16:48:53 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FC1C86F87
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e49a0b5caso4846504e87.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703605730; x=1704210530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzhVvu4KOX9lb9FC/p/xGfIliODPGAPJO6VrkmdDfSU=;
 b=HKiOmC917rwYw/hzb0/cR4H1/c3lZ/kBOfCBGCeJrCidPFNp/PJJzYtUuiytBIzhfU
 pbkpmM+yr0t1DKBi+Z6LqoFjxYCewyOAxXbHH8JDbSyXqfa3AUXV9jdxTxLDuVfLG0g7
 yr0oYbJp04ciwpSpMPxid2RdCrFCQa4uOMhHo5IIGQC0MpViOIcyvzGEDr9IPJwL0c3w
 r1lxtzIfC6GkJEOf3BJBIGRO/gbnUUwtAEhsu1l+CW6XmU/kBQiHzfdLjH0b215PZWZz
 hJeZ8vGs6Hn2LTtNAkROj6iEhuFrEZnLT8q/6fK8CZoaECOd9Li5mqMFOcXWgYPIQL1O
 Z5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605730; x=1704210530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzhVvu4KOX9lb9FC/p/xGfIliODPGAPJO6VrkmdDfSU=;
 b=B79N1/DBnoFaocz/LiOPKi6OxNvu046Co2lwJ/awFespa8VrfNQNXBowBOhfCs0Mv/
 q5rpS/tlRCemT1Qxbc9+roVOqM/m8EhQuxMwkSjGhqkCfeS4uAAcePBT8TOp/5osZB3i
 7+5FRPD7mqfDn9QhqiJjtOdu92jx+NpDwzenphnpxcrR8M2Owr3o2Xk0UzeFGBW0KOMT
 QFVpFwM7DYjBLIQf63O5k4ZdNhRCvRpNQgtnnXGUu5BadAY29Fv6dVUlu0tFwzDyqv8+
 L8P+kbeTAUyjh9M0216jXyXd0FxHqfu04/DbFuUU1RFhxMJkSDXO94Y85Q6+8Ln9+MlY
 s5eQ==
X-Gm-Message-State: AOJu0Yzt4FFVp4BR0Na7mtvfwr9RNK0t+VUEfEdl/Bz+HWp6a9TU2fUr
 EMDjfwQ8bYmbJ9Nbzf0AZpi7Xen73V7DM9Qhejmp8SuGhOE=
X-Google-Smtp-Source: AGHT+IFcFFx23SCWZl2SIMPrGx9kaghJYYc81uVocO2+JluQt/6nuU1oVKWgeIvmeLJRu1xO0B7C6w==
X-Received: by 2002:a05:6512:1114:b0:50e:84a5:f794 with SMTP id
 l20-20020a056512111400b0050e84a5f794mr89589lfg.94.1703605730593; 
 Tue, 26 Dec 2023 07:48:50 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a0565123d1900b0050e743b0b2csm1089336lfv.34.2023.12.26.07.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 07:48:50 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv3 5/8] mach-socfpga: do not overlap defines with lwip
Date: Tue, 26 Dec 2023 21:46:16 +0600
Message-Id: <20231226154619.5071-6-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231226154619.5071-1-maxim.uvarov@linaro.org>
References: <20231226154619.5071-1-maxim.uvarov@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

