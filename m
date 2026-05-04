Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0175ACD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726ED846C3;
	Mon,  4 May 2026 20:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yB32g+Rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E65846B8; Mon,  4 May 2026 20:57:53 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 695EE8467A
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso2566543f8f.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921069; x=1778525869; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9K9sHZzy4t+6LmzdQnuoOq2VkGT+bcBrYGI9nPgp4Bw=;
 b=yB32g+RvRpKDOtnfVw0sYT72fSJYvKYDiUkrrQVm+cYdVHG1qBX5SbI9fRWWP/68qF
 Pmd7tXA8aRv1dbGxerHdFpTtRB3SZG4xuVpkq6m+9EMn124m4euet1NfpKfaFRJJIhiD
 yKnnqtg/Vi7EfFJweWyqTVu1KJNaL8RuluvysgdfbGflZ6kRqaPMWQB1EC8OJnBKsi8D
 CCgiA7dVFOiH2mrcehLKWKdROJOHDpYKrP99NMxSmh3wNlxaA3nGpTObcdZv//bnkvOT
 e0vljR8iTJzgAWlvujBSQ+EEvbzmASpZ2sgLdIqsc8N2ELlNWYWlhhXf8R3cFVAaXecJ
 o6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921069; x=1778525869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9K9sHZzy4t+6LmzdQnuoOq2VkGT+bcBrYGI9nPgp4Bw=;
 b=j0N6cAXJjY8AQwU723ytDWLKb9RJhhjvHLVSV8yr0r6x8bxvUGx7M86eBEoytZKP5m
 TIe/kxhNcAeh1LSNtLRxYQUTz13508Z0EaC7Cyp1IUut3SKmzefEwzlgyj1EmWkt1R5t
 TU+gXqvsmBRGW/+HmYtltBaqnuXlNk2X0XE3meK6OSCi/LgZmiCsjtbZzcGCy0z5Df0y
 E8GU7JZHsa6SH66Om4S/CcV+2O5Q/QzjZvlJf5FGhU7MXIUZEe45VM48ueuaTEi3ic3U
 +Pig4iKHk/7PfbIBp/v8bUaMfrya0nWW+jyBVGKtDzOmS+uePPxuLdSCuEKJoazavyLI
 Qhdg==
X-Gm-Message-State: AOJu0YwIyJswTEuFXmYYLsf4eF4hKHZ/JG8T5eMgaUG2kKzvVMQCWVlS
 in0gZA8sNrN2Vkn26pgeyqhs8DnL470i+vwKObfQUHLVSkGK3rV7br5nO2F0dLXegiA=
X-Gm-Gg: AeBDieuHUvgWkX2OIqNnu3N4cUHAXj/L90o/3KT77R84V6TmIonP7HDDrRe/fCLgVZR
 5LL7Xue1QbOlgAd6I5Kj8A7sPZN4MpHP1sT4xgo0kF+ShZcICLXhEgAnUwno2BC5xHoRILtwkzM
 KVIghg2xW3cpd0Y9mDpRE8hXFh/NTsLzPzihgurSYW9U9+vQSS1LP8CdoojzblgNaLvt5OPTU+B
 VB7u1Tl/fuQm0U1MkkEfSRo2FBcc3nWhQkk/52ZJVt27diDvKJ4YckMgY/ecrMlln4pBlA21mKK
 q/NanoiEj0xE89e6JY7NN3XNCtGCJIsB3kMWN2P9jtMKNjk2BHRYCSgB9m4ChI90bmIYun4hkHW
 SYyQQle4pRChe7vNGiWmrwusYEI+laHeMoHzMFECpw9IFzTjPFJrbQvE5B/zm58Hog+NVdR3SfC
 l6MhqyT303nSlJRQrNyRvlO2CpZymjj05YeHelCsU0oBj0Ag0s9nPPAjOXgOYJ7DEJjyqKdU5HM
 1U7bes=
X-Received: by 2002:a05:6000:1845:b0:44d:821:1a07 with SMTP id
 ffacd0b85a97d-44fdd45b883mr1280945f8f.13.1777921068780; 
 Mon, 04 May 2026 11:57:48 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:57:47 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 04 May 2026 20:57:35 +0200
Subject: [PATCH v2 07/15] soc: qcom: smem: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-b4-modernise-smem-v2-7-c01ec2ff3886@linaro.org>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=LbomBOPfUjoX4EjKDAA+gC8UQUprfKnG/9nuoMHuV5Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+Sc3apE7L58fZAkP5MhpL1t5a4Dh3dPDWjTu1o+J
 +zLj5/POkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBElA4zMixMEby863Tl1/li
 99de7eb/ckI3J/5k57akaz3LAjUP7nrI8D9w6XFeMydNT9PzCxXj7zP3T6/qX/EkfOlWC51vPNt
 uXJ8GAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Drop Linux headers for the U-Boot ones.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/soc/qcom/smem.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 8515b8ae7777..7143856e85c3 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -3,19 +3,17 @@
  * Copyright (c) 2015, Sony Mobile Communications AB.
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
  */
 
-#include <linux/hwspinlock.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <linux/bug.h>
 #include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_reserved_mem.h>
-#include <linux/platform_device.h>
+#include <linux/ioport.h>
 #include <linux/sizes.h>
-#include <linux/slab.h>
-#include <linux/soc/qcom/smem.h>
-#include <linux/soc/qcom/socinfo.h>
+#include <soc/qcom/smem.h>
+#include <soc/qcom/socinfo.h>
 
 /*
  * The Qualcomm shared memory system is a allocate only heap structure that
  * consists of one of more memory areas that can be accessed by the processors

-- 
2.53.0

