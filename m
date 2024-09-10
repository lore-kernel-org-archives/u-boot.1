Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A4BECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F18888FB8;
	Tue, 10 Sep 2024 11:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kzE+mWda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C15CC88FBE; Tue, 10 Sep 2024 11:20:45 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE9A88FAA
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb1758e41so24603675e9.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960039; x=1726564839; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eXgKvKziNCDVpM542c0JIfC8nrp074BX8CGUocIxGCw=;
 b=kzE+mWday/i06JWRX1XRDep/KiN62fr2/nhfAecpfq8s949AqIdc+QRRnw9ozHs5fQ
 6Qpu3WmystnrY/9rNB2py2NIy27rGAtWbpWhfXf8cW3SoHZvr/vx5Z5uGzxbVnLDIdSx
 HHBL41qDWUrUyRMQZ57xCQLrSwhxe/xGThcHApaUk/kTxQM2PulbgGxJalCOljABsCH4
 1L6DRvuhGBI2cmEjrepC6xYEWm/xnWm+RaaPI8NRDOKIgBovmQEuFrxhaoX9Tg54M4ZD
 VkySw9h1Tuqg/S3rzwRKr5ywmNMA338Gha54R2h6B4wZB8WTVTlaMExwBxE4ZGjghJoA
 bArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960039; x=1726564839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXgKvKziNCDVpM542c0JIfC8nrp074BX8CGUocIxGCw=;
 b=v8AkfznFVF1ymRGZ1/o/wQwZFw/iTv1REaoa97eTX5vpCUVXQ5WJsPk++szN2KyHU0
 OVHcfCUU7oMiBSnHlYlnaOcYue05ujM52+UPVlNdsrx6ZnDkylP60DiMm0veuE4DzYvs
 wOv9/NwILpRkssheDlaKPC8EDDUyXhqGH2aR2mJwUGEjammMezczPDlHj5olIID2LeB0
 /vTLPxV5c3vRQcwp51WSOnrfgOnUzwpYN1fx9SM3lpKyddm0gNE+XTT0amuGKJuPbqnk
 QHtZ4AXL1pr49V7REgXdbMka8j2YoiJUJhUiD/CWzKG8THyB+IE4Sir7V3XZJxZ3E+jO
 lXwg==
X-Gm-Message-State: AOJu0YxcYcvdyVFNq/eJ7NemI98fq83LFv/HVSZZ2BhAvaSnEQKo3eQ5
 7N0mBp7Ww5c5p5dAa2ysNZuaZjWdb6qbZIlBNYBwpUguRP0i3KHH7YYMz8WM/z3QRRl+8thJ37M
 v
X-Google-Smtp-Source: AGHT+IEcfFPGeJr9ZN7vO0CWayr1GFbC8XmffzKCz907KBoxj8xmISWpEBzZ1NvRGfbm/cSGBHy8Sw==
X-Received: by 2002:a05:600c:4f88:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-42cae70a06bmr71771985e9.2.1725960038916; 
 Tue, 10 Sep 2024 02:20:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 10 Sep 2024 11:20:30 +0200
Subject: [PATCH 13/13] MAINTAINERS: Add myself to the list of UFS maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-13-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=696;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=NV/1x6jD/OQh3su2pTY3i9G6mDTz+ecb8+ZFijMmMPE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9bQ2/UL3ewyDN5cuG4HTngg+jF6rQcQtaW2bWC
 tV4BJbSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPWwAKCRB33NvayMhJ0c99D/
 sF1n71M0kzMJqxVAP3pYZqcPiZdLOrmlmUtoF21cE/fvxTG6htDEQ8B9HmHOzyqCij5mIp5dBE0VLh
 d/LWl2DyOhQlEqJyXf1hkvUMcbSkiXnNdslIIIzTPc4eRyYA+HXkuJ11ndGmdyHBuYB7lq893YYtN2
 fzopyafTcwsPUm1S+M0KOUOF0+WDYCh+uyfta06gRS+eejSowzR/nhJNx1yT+NnMzKAaMWyz/tAM9I
 tCnl3z8ediNiPUnR+Diqd5aa1yliY89kU6gn/iqSsehhdVZxHZKo0EHpG15j3W8uUL+oXPiL6hDYNv
 kvp21hRVevG/SLOp8AVTGXK9j/nTq+kIXlYvylhIqtGCiVe09AFc9o6sndoPeXJvBIZM4hGQWFIS+p
 LCEWm+opu+r2L4yrJwCkdMMvsvgqGtOR4lXOXs3t2Wf67rRZVYYEXIMKOz065Ohg3X37yeetrijSOp
 /U1tPP2SY185pnP8G1Nl2sixSGvMO0oBVqy4vWZvVKwIssXrmQaQ0nUWL2LnhXZbtjk5r+UPIUob9Y
 8L/NiBdPiTgDpp/fvosgcyzBvCeS2e5/GVwB/NNKSLo8V5QXkFdMdVGYzGE4RwchJxM9X8+vRE9Apt
 LgS6PMLtgFi8w0kMGopUwG19ssrdIk+V3Qf+v39VQv6WlVbGnY5LMGlDMZcg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Adding myself to continue Bhupesh's work to enhance and fix UFS
support in U-boot, especially for Qualcomm SoCs, and help review
patches and maintain the UFS subsystem.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ab39d91a55..14809c057c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1707,6 +1707,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
 F:	drivers/mtd/ubi/
 
 UFS
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
 M:	Neha Malcom Francis <n-francis@ti.com>
 S:	Maintained

-- 
2.34.1

