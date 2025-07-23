Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE328C83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 10:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F618341A;
	Wed, 23 Jul 2025 12:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OKZ+e6zg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D14A83429; Wed, 23 Jul 2025 12:58:08 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB8EA83297
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 12:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45622a1829eso21222495e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753268285; x=1753873085; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fLDEJ0OyPRTkMU0HEwHZlMzhDGNT4KRgx17dAMUAZEM=;
 b=OKZ+e6zg3VHyMeQ8uFtbKPbUEq2lffNZCPP7qNTLPqiDQ6mjC1llRNgZnjS9GA9OkE
 hio+GgbYOZ4nc3xqmMEx4O3cP7ppOSZXPwSICEzzcIYwExMMMYdNRs1Rp1C8GRSEVUQp
 35xW8gI8M34xcABqUqZgh5u5ufqjXZmMjOUXpYs60JOgc8EpUhyOy/aID41eSWGzxKuP
 mExxS6Kv/Gy4jcMudxlhgO1y4lAf3uTArLgifIwXP8q6W8GI+1UwtAFu2PKPF17bVeX+
 w1d21RKCTHCo6CFT3G1fDyuxpVfRCDCLG0Z337JYhwo7L38BjiLQcePoR4R9qUBCfFrA
 wb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753268285; x=1753873085;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fLDEJ0OyPRTkMU0HEwHZlMzhDGNT4KRgx17dAMUAZEM=;
 b=HQOd+3niu9AI94sIbvx4RQY9djF5mxjcWRLLnTCu6BhLvtXAmxz8xkvKaBOJIYzgbs
 DI2poTPMaQzE+KayglxMol9LTqKRC4GlIMiHV9ZYOhCm4i6YRboLr8Ve3c8FCtHXTv3p
 3BgMddODC3ejCKNyNlNC2118i7qzKNGmtNZ245ClnZNj5yeNurNJyXeMNXGAWE5MbeX1
 M9McHsn1CLcOLYtsoO7ZFGyUqsv1tW+5TucEuSrHp95UTFjrdwXzkdkb4/fVBmzk8CV/
 Rp4ej0HMCTSCuGp0DRvDseJGRE1uR/P8sehRHaoy4U/vvIlUAP+lyTIg0ZP4kaaJIuHE
 JnDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVwr3a7FwCuEpTjS23UgLVrigQVIhsWfZQCkkVFoFrjsTzgMf+bv5/9w5ZLht0NXzFp5nOA+o=@lists.denx.de
X-Gm-Message-State: AOJu0YwanXOVPDzjoj8SROhY7ityQc9KWlr6oPxmstXffzNZzE9CBQd7
 EA84xLNCJJzmnQCo/8wm9DnXovDyaOkNoOUDq1u+BaoKNUOecaeuUYXstvGdiYKzHmI=
X-Gm-Gg: ASbGncvNiQ9d8fLSWrbXw1Tbf2ePGskp6VNrCHSoUJP/rx2zSOO2U5UMJhttiqtPRdW
 5EnSpoyRUkrPmIGckDcHX54ol1+c4K6Qlhs3wICD3cbY75LoA9pczgvfYAseQSJDP9N0dnypKef
 eAEvLhj2gU2SLWL8MxRFKoQMOgIQuzWTMKRmDadLUlJZFtaxaW9NbQ5iP22ueudFu4e9TgyU8YF
 a2SMqtfTMxboYgpXRk/eqUjkc1VOTluhgCjHEIZFVWibbvXDibgO4ZqI3kSxjtPPuyb/xOVjDfl
 3e7glu74SyIUGmqikZyQikvRchdFnBGpfg2i4k7hgUQVQhFNTdJLuPapnIuhoqdOH6ZTC6gkN7O
 1vRMCqU6otEgfDCp5yTBQJ3lyyoXsbwOaYPR2f4iTn8QpYoi93cs=
X-Google-Smtp-Source: AGHT+IGlwn+TZqAfPpqcvlArlP9PVIHXdpJ3Tac9tVHrzuW+zxMka+4iBZIsOayCTq0+0V5ohBExAA==
X-Received: by 2002:a05:600c:46d2:b0:456:19b2:6aa8 with SMTP id
 5b1f17b1804b1-45868d48911mr21717315e9.19.1753268285189; 
 Wed, 23 Jul 2025 03:58:05 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:5143:c98d:3163:b66b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45869199461sm19670865e9.8.2025.07.23.03.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 03:58:04 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 11:58:04 +0100
Subject: [PATCH] button: qcom-pmic: Fix dereference of uninitialised
 pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-button-qcom-pmic-v1-1-9c317ac71167@linaro.org>
X-B4-Tracking: v=1; b=H4sIADvAgGgC/x2NywrCMBAAf6Xs2YU2Gi3+injIY7V7SFJ3oxRK/
 72px2EYZgUlYVK4dysI/Vi55AbDqYMwufwm5NgYTG9sfzNn9N9aS8ZPKAnnxAHH0QRvL4ON8Qo
 t804JvbgcpiNMTivJIWahFy//1+O5bTuHBHN8ewAAAA==
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The pointer 'label' is declared and later dereferenced without ever
having a value assigned to it. Add an assignment to this pointer so it
will be valid later when dereferenced.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/button/button-qcom-pmic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index 85addfe32a2..b823490d6d5 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -195,8 +195,9 @@ static int button_qcom_pmic_bind(struct udevice *parent)
 			continue;
 		}
 
+		label = ofnode_get_name(node);
 		ret = device_bind_driver_to_node(parent, "qcom_pwrkey",
-						 ofnode_get_name(node),
+						 label,
 						 node, &dev);
 		if (ret) {
 			printf("Failed to bind %s! %d\n", label, ret);

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250723-button-qcom-pmic-882cb5415dd6

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

