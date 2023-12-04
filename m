Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85400C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B0E876AE;
	Mon,  4 Dec 2023 13:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z3yNfq/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234DB8754D; Mon,  4 Dec 2023 13:07:27 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EFAA876AE
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50be58a751cso2277490e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701691644; x=1702296444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxFJwKL5zDs8b5aiVb6q3SDjOsJLBc/cfLiOxsIC9AE=;
 b=z3yNfq/DY3HjuMbj9NqOhs1DwyV0sf1OVJLSfqj3RVAa/bvL4nmG9b1gGFm+Sk4V6o
 /pdXXGNfTh2NGypQVXhuK2jCGVSxQQyrLW/3PlDf/i68FpDSLsNb2UU+v/cvBJ5T1VEB
 39gbJK+n5whB0uwUcM+5tEqxc5Oef5Vl1tt0dahiHtKM+LhhGFE58XsCKABilyWvCnXn
 syp6jdeXLK1JBB//UKyNYSyMa9J/nzP1zf5VadQZTWLYxQq6tgjuDR5qF4t043O9TJnP
 kZtDtt0vaXBplpfG4OickF3bJJ81RPwkEQddE3+hodZUXwF8Rkf+VLdqN2Wtfcegak97
 adHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691644; x=1702296444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxFJwKL5zDs8b5aiVb6q3SDjOsJLBc/cfLiOxsIC9AE=;
 b=tXPJGolJ9fpc3mvTKnP2Gi88L8NcL0wIQ2QDA97MlsbiJyfayPVWq5NI8W2A/3dyC/
 +MUpkxwfIrA0W+tX9/5rPGnjQSl8B06e8HalkxzrjayQJw3oKzVeZw+KeKhuHukYlZU0
 bF6sAn++sJw6AxpO2zfgJJaYKZKIvfNOuRY+WtTj3DGUqHIAEHAM39p8df2TAXvVbPpB
 ol8VrAjnmK6n6bPdEePLmAPIsw0Thj2KBz4Zt9xuYVP/poRnrEtlkIYOZqnJL+uL4xjU
 qfAyQWaLqo6LPjSAI+Vtk4mDeQWjoL8RxoGb8CRlsmcdz2JCh2ayllCZ7IRSRlcwdk1i
 NXKg==
X-Gm-Message-State: AOJu0YzXghseMYg9z9CTWAjD/z/8t3cmsC/3TB0MWdW1CPFBJu6g+FkF
 cxa/Mfmq0BfwW4z0xcsMi2dbK1xKoduh1i938Qv/YQ==
X-Google-Smtp-Source: AGHT+IHhQXPXqDt2zBllxlUs+JdkscM7IXBlWWcufFVbuTPbjPvmnjqs3IJwG7KFeLsFxQqYHtPAxw==
X-Received: by 2002:ac2:57c1:0:b0:50b:fd6f:1e2b with SMTP id
 k1-20020ac257c1000000b0050bfd6f1e2bmr286236lfo.3.1701691644065; 
 Mon, 04 Dec 2023 04:07:24 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a0565123ba100b0050befebf0ccsm541675lfv.292.2023.12.04.04.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:07:23 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv1 6/9] mach-socfpga: do not overlap defines with lwip
Date: Mon,  4 Dec 2023 18:04:43 +0600
Message-Id: <20231204120446.3277-7-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231204120446.3277-1-maxim.uvarov@linaro.org>
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
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

