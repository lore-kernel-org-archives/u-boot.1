Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE64C369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E0DB84002;
	Fri, 11 Apr 2025 14:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rgX/FDuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72B8584002; Fri, 11 Apr 2025 14:48:04 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7581683FF4
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso1012255f8f.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744375682; x=1744980482; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vg4/vprd2sdTaChI4TunLLuWjsE1j/v1KJyQRDTO2tg=;
 b=rgX/FDuVzdiyUIWlaQTipll81sBJszRjb9WEY2iUkZR1mSMLGwKFV1u1Q4B2aof/p9
 Hy+UG5iKwL5NAxb1dAyKb6GEYBaUTe0AgYP/FZ3CnTjAPAUwdRHvoXBCoKjtkoWg+gBx
 YeTxc4Ti5oOibskN5Ag3JKmSzBNQCrwYQhev+LZy48RgFNIVJLYXaErvfLEcuY6iyXS/
 eD583bVH8IwHrvzT3PFRE2fS2FdiueHRNfL3EfqphleK9wZ/RkLY39AcsYFPcdfxog3q
 /wBa7K04hTEtBsulgUdZwdRfFDJWhjOsXjDr5Qrq5zEaVO98H3vugvmmOjX8cJ/JiBXW
 vkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375682; x=1744980482;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vg4/vprd2sdTaChI4TunLLuWjsE1j/v1KJyQRDTO2tg=;
 b=dfJq+4bqImb5s2yzul50pH4KTVntFm39Ih2+JdmpbRDAqHfp3vBBSR8A8PTDJ8von/
 rwiWvpr5+fUBmePR1+0FdEUYl9Gqcn6LVQERTo129clvLPOtY5RxPoDw9kw9Sja9zGMw
 Pp9YUUin54Yf1UEouGACWKYj1clpSmgIn7Ml4UW2+330Ej+tYODC21Dr0SW9stlybVde
 PzUvUg2N8dww7w2QpLug39FYVF8CqFfWsVlbFgPJ4K7rfLJxflF1Hn2ztoz2BZSaW7Fb
 lNL0JLgiv8E+H0Ysy8t4RlsUCvLSOWLTueRGsd3HMB1jUMkfTtCtZ5wI1tbZNYLWj7SL
 yUjQ==
X-Gm-Message-State: AOJu0YwAnmcfscz234zgrhcPs69ShBIncxLmAm+ePxpnz5xfI4MsmJHZ
 Ot8nTPk2hz3HTA3FhK/2i3X+QkDW9LmyKqilFSUIDYrlh9YWrzoEeFxwopkxvj0=
X-Gm-Gg: ASbGncsf+HxzQjdAoVj+8H1RQH2StowK8NtQPjwLJ4oXzp0YSe/2JjnmSeLK78LjxGW
 EYmqJ/GAreBAdxSgvK0KdbcpNJYiJYNh8HNzyxBiE5n2fzvGnTNToTangHK3E7GsVUjgxfnBTz7
 qPQspXJU7LIwsg0BwzHwlf+Omwch5s61WO6faAi0PYCHYYeTFGs/G9x0UjtlRZLnUF1jvJC8q0H
 sy71nS1lksULXeZ2SCCdhD/oKFGnkAhq4WnJgJpeXPU++uhTlr9NPtX0+vgOLohzdaL/AcvtjML
 5+Aqd0JoyBdY9z4wwVb2t+qAGUkBBnO9SrlausW5aVSITfAr+n+nei6a0PMMe0M9B49zwFa8eJR
 sUy7FtSuNiNednV+NEw==
X-Google-Smtp-Source: AGHT+IFl3pqoa3agxDnRaJbtF6ehKVO/jI7GGZAvOi/HsRl96OaMr/N8JLSLGsFQhx8s4Cs8ukM6hw==
X-Received: by 2002:a05:6000:2511:b0:390:ed04:a676 with SMTP id
 ffacd0b85a97d-39ea5216977mr2164153f8f.22.1744375681948; 
 Fri, 11 Apr 2025 05:48:01 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206264a1sm88299695e9.9.2025.04.11.05.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 05:48:01 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 14:47:45 +0200
Subject: [PATCH v2 8/8] pinctrl: qcom: qcm2290: fix off by 1 in pin_count
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-livetree-fixup-v2-8-1236823377bb@linaro.org>
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
In-Reply-To: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=BO+kMwWeHDM1FfjmeCD6YNHRYohy8G04h8L0/gvLF5M=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+Q90Cxb1ZsPiQbg47oiUJLBWYu5e6+dRPfa7v
 fJxUNbPW0SJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kPdAAKCRAFgzErGV9k
 trq0EACKMOHmXD07ydgQ74sp7tXChsnIEE6MEu/amyFbZBk1ULtGIfZXhJU2q+TQZD8LyB5pDw0
 Q6i7GRPXM4YozL5AIdwfalJ+eGq/bTB1kY2y6muGzruRY4pELQzI3peTrhQ0pZu9+PHrs5qBYH9
 anbxCoLHHfY/j0Y+C2RWC4h8Eto2QyER5Ls42K830TCzw906B4jkBJRln9tYrTL8eOuq9KfM96i
 KRpIVZrsh/wcZBb/feHJsbl/QVMgesHFBGe9ZeO7EdbeFrkrkjYHB0W9kzQGTR6Fkuzl7gk6RVC
 YLJCA+trO/l1Do9vjT3+rSicfNh2duoD20kphIuUzWc9mjPnvpJaI55y2ajE/z60o0qgob3N9DJ
 eAcSrEFlr5Cz5dmQaLfwueTfj5xAG0I99/UxOua4SPgtj0XKn7uTsgi6HGLDgmH5cg9pShtSqlq
 9Or/XbN7caThKs6PsbxRJbrTlJ5tM7jzCIJwROTuNlNf1cGpO3Fj1UY4Q8PGIAf/e4ZyTX20z10
 nQijr0lUiq0rej6zvOB/Z2AYk93DAHgWxjrTS48Wzqj6A9iNxKTiFX/4GkLaQyvpsuPTHLxrWUi
 aYAis92kTdtkhwMKhFiUeSiWN6/0gx7Z5DfPO+rV1eF+qLRwggNMTLN3vUAReBKa7Khy+5d7KcX
 a60UNTQCQaRt2aw==
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

There are 134 pins not 133, oops! This fixes the sdcard on the RB1 as
the pins now all get configured correctly.

Fixes: 0ecb8cfcb930 ("pinctrl: qcom: add qcm2290 pinctrl driver")
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-qcm2290.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcm2290.c b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
index 0c2222ce663e6d584d229e7521f88fedf8aa19da..84f76b63b93ad78182524661dba561672feb4c85 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcm2290.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
@@ -44,9 +44,9 @@ static int qcm2290_get_function_mux(__maybe_unused unsigned int pin, unsigned in
 }
 
 struct msm_pinctrl_data qcm2290_data = {
 	.pin_data = {
-		.pin_count = 133,
+		.pin_count = 134,
 		.special_pins_start = 127,
 	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = qcm2290_get_function_name,

-- 
2.49.0

