Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9500CC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD098391E;
	Wed,  9 Apr 2025 19:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AyNjkgtg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA67783919; Wed,  9 Apr 2025 19:17:41 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989CC81CF0
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so44962015e9.3
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744219059; x=1744823859; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vdeWn9OKlXHfCAbBkRP+aUMbrKr7KucQPlXqpRz1srY=;
 b=AyNjkgtgOt4rZVuh52thywaRB3bnxN4jah8E6AKo+fyrDJPKX2OvYAGRKK/ya7Fu6k
 gSQemZf1/kbQMDm3Z18+j0ApP3UvNyMb7KOtFf2NE7r9P7Ho7Sc/3GfBdBylHSbQcm0U
 VNlJ15FA164VxoKL9sXu9UMAS2X1PQudsYqwcClRhOqXN47xifhiLxBz9icN+iOz1DSu
 1gQfaXJBG/kGyJspabKHoJF1+XApjSAJW2+QpL//d+SiWR+pW4vKEyG7wxyMK9sRHyU2
 Qy3fGsz1nWYB/IJCknKd8Adaj8/KXsMwPG3AGF+yc2erC0S+CrLV/LgXXezFaxiPnzC+
 z8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219059; x=1744823859;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdeWn9OKlXHfCAbBkRP+aUMbrKr7KucQPlXqpRz1srY=;
 b=r/HbDKa6LLr7p5gYfk4zKkGJWc9wUofesXYYPq+9pXnM7104sRxr1D0Ud4iUh/FyaM
 fzoG0TGlPMO9EVyZgFRneFuJ0jPCNVT0SLoj1O3UYShYQOZCwALLJ+8DMTGYZT6HNzDo
 PBFqcDNN8E2UePlXGGYgkcHSoaU646PxPqQaQvSvHJlMlisKqqNk1V8wLjsXZI+Drinr
 7FYp+qu0kGTUJDuuFgi1qjBz3UTxwYbzc/D8vcL2R+DwOIWwKg7YKXvOLCjXj5T/yWsv
 wd028cd4IDCCOdr/vFQrTOP8BIG2YvO1T1eAK4fR0vGeRLxJfUMkmdAW2500TqfOvztV
 QgpA==
X-Gm-Message-State: AOJu0YyrGzO2fWly7y/7h4k2FTdiRo3qEzTGzLvZD/ILDgZo2DMea3jP
 kBhNHB+850ADg+i02bnEFgFSm2UgrLxR/ZYZKpD6DiY3JItNPf+UFVODSrtUKDBV/t/1Eu0ZroM
 tv8Y=
X-Gm-Gg: ASbGncvgPRl1xwZyPm6nTSnDHm+zG6Z/rltRNu8y4Np0tMpfkqaDSrc8Cpf07j7S0G3
 lZlSbtZOOnOoMuZUaQtURFE78xpQosVfWN2uzdQIV6UrxlzNaICvsrYeHDa315wNLbi4oTVgd8Z
 qboYXnZBcewthWEbQOyoOvmiwn0/15Mgeb5wi2sy4c4iVR2hqvLp5UXGA06RBr0amEy0WDYvRfr
 CAqh8S9wTfZbxlE3KhClRDKEvYPsZ6aUA0wblgCc946+cUtyM1Ck2Hvr+SE3W+HCoXJ0baO3a/t
 ePjxkXIgqSS2X3aPckMAKOjXN/J4SwbLqZ3uHtZi1+YDR7DBX6VYWt7Wy81vbpI7GK0+/RFQf+i
 5erz10Q==
X-Google-Smtp-Source: AGHT+IHSm7ssBkArTs68ydgUESUoAZD6doYtlEv0artEOmZ8XtYLm0iGmco1KRSwkP1QCq+//VPKGg==
X-Received: by 2002:a05:600c:4f83:b0:43c:fe15:41e1 with SMTP id
 5b1f17b1804b1-43f1ec58c00mr40489295e9.4.1744219058768; 
 Wed, 09 Apr 2025 10:17:38 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c817dsm21916455e9.23.2025.04.09.10.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 10:17:37 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 09 Apr 2025 19:17:25 +0200
Subject: [PATCH 2/6] mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-livetree-fixup-v1-2-76dfea80b07f@linaro.org>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
In-Reply-To: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ad1zaVS/5vrsXVqSNV5HLMdsqwefLS6sy11fgjHewQc=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn9qutbEY28nH+INEWUgqr2rze9JJn5XSqfSeXY
 fN35eaFt8OJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/arrQAKCRAFgzErGV9k
 tiPPD/9ZyV8IYNKvNc5o96nkmDh4IRpGB3b55pINVYTCaJg1uCguHSpa6+MqxjYDJ9U+Ucwc/Nc
 WhaVMZAUsoeHxwuWuo9aPbG6akLqzYKXyN1XBQ6uTSWCNnwQ8CDRa+yCeFIE+YbKj3mxjl1Mhr3
 7HXyEyS+/22vp+9apFi2fJi1Y/OSwWaGRXimQORQl3RA3u1iJJOeEV2Eey7ioDdqmaDwFlN6Pkb
 T97qtoxFmVHQRB2xZhJk/u3ylC4DpAM/rQCOBgxgZm/n6bJfq//+9C1pyZa5khOhdHbzXCXLXgk
 SyyWtIXRc9Aq64svXA3iGs5DkUuPPQS+8acMZFBZV7jAwgpuOchiAhE5YJYsti973fW4G47vGrj
 cRKFD8fJVIdVmRwvya2JWvA0rQZO/sxp2VbqA+x+1MQ55j73wx42Bq6YztA2zBN9a8dlkQ4uvLT
 SPzOqlph8oEDqNVNow4G63qxGa7r0WJ/3kiOTr8A5RA5jMGXVC+Jrty99tU7JgbiF6GspEln1zA
 LBVgkEkSukHFy2yQDPu8zKrASKqmltPAqqdvSpgSMgfx2iARNA07LB6AxVO/avGXpm8OXOj38e/
 J83cU9SffefG9OOtSE38BFob/UtXmioQPk3IlZARnS3VO43hSLInovFqCeRZPjyuhoTdU5uudsl
 nWF3NrOhkBS/nFg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This will now apply fixups prior to devices being bound, which makes it
possible to enable/disable devices and adjust more properties that might
be read before devices probe.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c     |  1 -
 arch/arm/mach-snapdragon/of_fixup.c  |  7 ++++++-
 arch/arm/mach-snapdragon/qcom-priv.h | 14 --------------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index deae4d323789eab75d5fe735159b4cd820c02c45..3ab75f0fce02ecffd476ebe2aa606b1a9024bbec 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -305,9 +305,8 @@ void __weak qcom_board_init(void)
 
 int board_init(void)
 {
 	show_psci_version();
-	qcom_of_fixup_nodes();
 	qcom_board_init();
 	return 0;
 }
 
diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 1ea0c18c2f2789a8aa054cd95bb9e4308d6b3384..d4e24059212c552de7fa7555d2ab8a1ea4fc4cb2 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -21,8 +21,9 @@
 
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dm/of_access.h>
 #include <dm/of.h>
+#include <event.h>
 #include <fdt_support.h>
 #include <linux/errno.h>
 #include <stdlib.h>
 #include <time.h>
@@ -149,14 +150,18 @@ static void fixup_power_domains(void)
 		func(__VA_ARGS__); \
 		debug(#func " took %lluus\n", timer_get_us() - start); \
 	} while (0)
 
-void qcom_of_fixup_nodes(void)
+static int qcom_of_fixup_nodes(void)
 {
 	time_call(fixup_usb_nodes);
 	time_call(fixup_power_domains);
+
+	return 0;
 }
 
+EVENT_SPY_SIMPLE(EVT_OF_LIVE_INIT, qcom_of_fixup_nodes);
+
 int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
 {
 	struct fdt_header *fdt = blob;
 	int node;
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 74d39197b89f4e769299b06214c26ee829ecdce0..4f398e2ba374f27811afd2ccf6e72037d0f9ee7f 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -8,19 +8,5 @@ void qcom_configure_capsule_updates(void);
 #else
 void qcom_configure_capsule_updates(void) {}
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
-#if CONFIG_IS_ENABLED(OF_LIVE)
-/**
- * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
- *
- * Adjusts nodes in the live tree to improve compatibility with U-Boot.
- */
-void qcom_of_fixup_nodes(void);
-#else
-static inline void qcom_of_fixup_nodes(void)
-{
-	log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
-}
-#endif /* OF_LIVE */
-
 #endif /* __QCOM_PRIV_H__ */

-- 
2.49.0

