Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406BACD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B004B849D1;
	Thu, 18 Jun 2026 13:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sF+7DR0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D56980287; Thu, 18 Jun 2026 13:57:12 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F3B849C9
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4629d80fa08so868070f8f.3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783830; x=1782388630; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9K9sHZzy4t+6LmzdQnuoOq2VkGT+bcBrYGI9nPgp4Bw=;
 b=sF+7DR0J4goYiikI22gBNsLbvT5ozZoJmpjndWNvs4S8T+OBfcHYO00qYLc6rYbW0v
 Xj8yK5Q9sd57BTdZRq2NWJ08HM8RD9PVXw7MOkRFWElEKesa8ZB1VF7gpO+skDpjmUQD
 wwH189xhzApnh40k12snBzn2KEF9FnzGheid5/dq9P8gYNU14talr/lYUk1LHmUc8/BJ
 AG6f2hYFzrBatWoP1hXAu55u7uvGC0/aueCa9r2YlzWn4VPGvCJmVAccgfAMHsjvdW0d
 t2UdTB7lpsM8k0bnmADWjWErYQPzItDCdfnnyKkraAvyOhMer+YozD5b8EFgBAzNYS6C
 4+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783830; x=1782388630;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9K9sHZzy4t+6LmzdQnuoOq2VkGT+bcBrYGI9nPgp4Bw=;
 b=lFAh66ZKWCx6EhI/zymWF+X2PBYoA3nkLZO172XL+xtyUpY9eaho998ciF8qn1eRf/
 4x0hAkvqVaaBn68pd0fvGgRQRzfZfDi/eNNvuDmYp04/SucxlkzDIXrPtD5qpiEOmf0e
 Ut74qXh8KUnm4jEP8PcN6ij/wGGZ5N3gvY7Ex2Hl96SxNc7QcZeBODblcLn0btQvMTFs
 aMkjY4rpfUfnk9Q5NmYsO1PED9HLFBtn9lZv6XgLJ3rQraMr4I/NHdTRTXRUE7NWsFLs
 iKrX3PWeT/vLhDMHk+vWvS3xG99oEu6YiFM1hY5nkFfOaXW4PsKbFD/g3xncSGu/MgVn
 TBNQ==
X-Gm-Message-State: AOJu0YzwIUlmRFmk18+HD0Ne96Yn/yp15q5Hc9UHirq1PAUkcwH4gRNw
 icYYbMQW9oXtf4j+0ECuIZb4HzREyVOI04HX2fMVmIIBMcqpNm0lVS8emGSbRTJY9jM=
X-Gm-Gg: AfdE7ckNquVKC0ZSzUOk6Ibuw4PMeUTHf83YPTva9HJ4HWcsIHoB/1MWzdbJkPILlP7
 LhueQBaFhaGSeEAGYfBFq7Frdd44TaMQm92/WTG87UXAW1SPDq3bdH20UyoTyA1gObvIN79jiAc
 mAiK8XFw/38ifMYqGdXVyWATXkf9p2xp5fNHwmvJk9WeqhNsyiOd7kk3XHhDVzkgFPhb/0MMw/b
 QmFeZBsd9O3ShPNEdAVucK/rMAbz8+qpF5kQmNQWddkNkY0akLPiqOosXRrcBbFeJGfQmgI47jw
 hHcCJzIef2RZikVmogdpxK2cCiRdq9wR2EoNpwZSqUmUf2S+pGutBSdZleokig1WgNSbGXXoALk
 eviSZTy2LhIXv0m7A1EU48JpTQ7K013nhdgR1JU67rtkP8mle9hbc+Yt/+jLT0mhRYBhBsHZC7Q
 xVOtyt69T8KM8b5hMRl1quKKVHoar+xpviPK7qtYbSQpjWNHqefjNlUmQ=
X-Received: by 2002:a05:6000:2c07:b0:45e:a0ab:8bcb with SMTP id
 ffacd0b85a97d-46236e000a8mr14862677f8f.15.1781783829899; 
 Thu, 18 Jun 2026 04:57:09 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:57:08 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 18 Jun 2026 13:56:55 +0200
Subject: [PATCH v3 07/15] soc: qcom: smem: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-modernise-smem-v3-7-472391477988@linaro.org>
References: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
In-Reply-To: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizjuyxS+6dPeDH/oVbGiyhfcfGedxIH1cVE7iszC8/XV
 83jMYvuKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABN58Ibhfyrv+oUBk92EdI65
 iSVN6TQKiZ/+Znru/dkrkmveezds9WH4ze7zNuXx0y8afgfad+2Y88r47csfD7nvMO89JFLofNd
 BIxUA
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

