Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CA7C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47054886E7;
	Tue,  9 Jul 2024 11:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HjgmKOo5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4F77886CE; Tue,  9 Jul 2024 11:35:04 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85ACE87EEE
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a77e6dd7f72so308168366b.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517702; x=1721122502; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a4qIlHFLHRT0uHZsGsFMmVG2NxA1uSx/6ao4WMUHK48=;
 b=HjgmKOo5UY6x96CLR0Or3crP87+7yp8MyXLRdEBJEPW1UGMlmKFyzQ8JzfX13J/3CI
 vaMbKKPC5JfqXIdgJO7HU9lLiUtDsRr2SJ9aIn9ytFOqBjyYN+B0tWyEhGj1ZVDokm3N
 sj1fUCt652MUi4pthkqxLCv4IywD+qVKDOJu/QV1efzcj/VQwPjf1TYd4UCCnheoiZT1
 Yft8HQzBsnYASkUZy9/05JOuJxQV2T579f2g3yPsPG2e3K2GcXbdlXBu/AeRbBpjWHBQ
 DwQ+4v3W/g8CaRZpDHWmWOl53Wl+rSWUsVkd2aM/9VoUW5yvHRxEkYDKb8MFZyWaiJLI
 s3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517702; x=1721122502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4qIlHFLHRT0uHZsGsFMmVG2NxA1uSx/6ao4WMUHK48=;
 b=MfH5sbbMwTkpivoYtp+Uxn144ECh8BG3Mdysk+owxYNajFqEozEP7+ZWoyyWRpEK6n
 lK2um9+3v/rQXBTkjVLMhTdO+VvlzZewlf3bsPULsCnGvwo2VSUqjttOQzh/nL43geYq
 Jja5IrVKDTsxZloTiAns1891NHdfEjpeYkjIqLeQTdHMdFeFXPQ7xpBV4hxj80X4yc0P
 t6qhFkhT3+aOwg4m0S+/ZiCL9Q1HLPmDvAD7D5VUuBwiSffUKwS7sEA+gYi0H1PIN+Aj
 qTvFzoz1543l9VWCuXF5IwP8XITEbwV5XKX+FcmW9XSLq3RlmoKMyiAsOGFckb1ZV4FG
 t6Cg==
X-Gm-Message-State: AOJu0Yxq+rHTOetC+gNOuCSF3e0L7Oud5p2G8xHXFa9PC3uLFCR3a1i6
 S3ajbrk1IBOBW8UeJigK8L7DTswhTvDMYkfS3aHSHL0KNv+JqEg2xylccfzHfAY=
X-Google-Smtp-Source: AGHT+IG1CjlFSLBhkgRjnYLaajE6+sq+nBXzoW5FM/XjdMy81dduqFXaRAKU5fuxgRtOopA69m/75Q==
X-Received: by 2002:a17:906:4c57:b0:a6f:ab9c:7778 with SMTP id
 a640c23a62f3a-a780b6fd1e3mr119580866b.34.1720517702046; 
 Tue, 09 Jul 2024 02:35:02 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:35:01 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:43 +0200
Subject: [PATCH v4 15/21] power: regulator: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-15-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ytcguWBaqxitdrPBpkIwdvgqeKhCqrQCzGV/uOlIWAk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQ0RWpqs3GUI9vF8GDKNGV3xmxvpachpl/JK
 iIqGcrS1umJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0ENAAKCRAFgzErGV9k
 tvnfEACO/UkCD7j+TbHm7E2QkuhwmErqhhBHjdvJmNh4vkTTGndcaYw4hPBC+d8jJQCtlX4AiL4
 4KuIctWNFzipLyHDx6xH8d+S4zHWUrUO0F/eA7N3/EUZJ6jdmOfqc8w/kyWvgJQtuODQTVaoR/J
 FowyeuXJOeRfEJurxD48toKb+IgK5sYeYDVHpYwPlxVOt1zEzQ6PHTCO7cgbFouHk/lYFaccXEh
 gr0f5b8lv4L4VCWDE/rTQZfZW3g5hw5F0LTmGPik35hOVRUSkODOzmgn2fU0X+8nSxGOAj5jcY7
 PxkisQ0plZg2kfJntUyoSfiqUaU2z94vvljHTdev3c3FrCUK5styIxtf/ircr0EOc7UlLokzgKx
 wTF2wqvh0MtFfpgiERl/CsfQhclywG8yIcQr8BVqQGw6t5cK4UeXcreDVNu1qoYaMR5IykTwuCQ
 kaFFdIGy9kzVqGCd28ACCgTRmRZzLhO6IlIuDBSFzeGZ/lHXkmByvpTqGCo8XpUJg73/RJMK1n6
 IgAXQl/rXRMY+RfwRxVfY8v2U7odAZXYs+WihYKGelOQH+MdSWvV9XSW7e18jl3XvR4+qA1JPR1
 zhaygJG1hhTLKVq4TJmIW8CuBRvTrPRx0iVimK4Gb327DWso4fLEMvQ9YJ6lAmX65uutB6lMSug
 3UeRVP2p6rw5+aA==
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

Remove unused/unsupported Linux headers and add necessary U-Boot ones.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 80e304711345..5f522de44734 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -4,17 +4,14 @@
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/of_regulator.h>
+#include <dm/device_compat.h>
+#include <dm/device.h>
+#include <dm/devres.h>
+#include <dm/lists.h>
+#include <power/regulator.h>
+#include <log.h>
 
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/rpmh.h>
 

-- 
2.45.2

