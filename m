Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DEED49228
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C67058947E;
	Mon, 18 Nov 2024 15:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j2pHlNL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0847D89469; Mon, 18 Nov 2024 15:42:09 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2964B89373
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso17549225e9.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731940924; x=1732545724; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iqb07guy2f1elVpI4BvDXs8P4pWQQ2rjb+Vt9SSJmpA=;
 b=j2pHlNL1V0XXWOY0igyMscscxnCBKaWRwaDbDOAd4rnjvMWk2UKKW5JTdkSrF3CxhU
 SXZmTwS8OnGQ5HRL0gBP0eonf2qO0NwZQ8ieg/yY/wDInm3r2v0OZ3zyvomkOi5mvlhh
 a3VqVKcTUDGY3myzFYOGKZl1VOVVpA9KYk+rgh+kYWxLfW31AW649R9Pn9xyQfIfktmn
 nytaMM9bpgSMIBQNgDqjiq2XEm8XjgU6ozx6JAgP5hZph1j5osYm8KhdstB4M4CdUuCy
 PQef6hbxo4ery0ZNcdGe36+IGXGhZWqQR2/TqRhXGZKUZu26KpGjswIw4lWezHA/zDAS
 VoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731940924; x=1732545724;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqb07guy2f1elVpI4BvDXs8P4pWQQ2rjb+Vt9SSJmpA=;
 b=gWt5LMHyqShjF2QoDP0ceqt7pmPuT3F5wUwitE/YRbBfW6A6ErUaeTCIZGIG6Y5n7/
 5IxDiVQU7iUGN2x8fqAkE1LD7I0KSM0w1h2un8Q5ePyb587i5YwQosEk10zssGoEmTax
 IRHjn/1lzIXheTosY5oNesv3GKja4+lG7wlpnazlieuLUlmqRpvPUt2ITSYesjJBG+UF
 ED8t28ZWaA0NmGxNmft/8JisA3Y5B2mNPU+Irh8pmtxN+EgF4WuKYTWTnitTsZEr5prf
 17fc51nwJVmndflBx+qG5RWunvRJqWlTVhVds0VKjRzKC+1G9hXmw1kT2Gs6I3Hma6vs
 k8qw==
X-Gm-Message-State: AOJu0YykpXjd0dXum48hTR1j6EhtK74fEnFbCWo6wErMypvEz+Hg5xf3
 2NajdmE9eQtwYTcER1CtAOF4gHua1Dr4wIB/u9DoC03xLIIFWp7Ft1NlzQqHWhM=
X-Google-Smtp-Source: AGHT+IHpiaea4aZlKi6rQhX/H7SytOZebWfFBSN5vE5KJJMvHTb12/IJjPHb5IrcegmlY1Pb9DMufA==
X-Received: by 2002:a05:600c:1c1f:b0:432:d82d:6a6c with SMTP id
 5b1f17b1804b1-432df78d817mr116383805e9.30.1731940924497; 
 Mon, 18 Nov 2024 06:42:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab788e1sm156906495e9.15.2024.11.18.06.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:42:04 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 18 Nov 2024 15:42:01 +0100
Subject: [PATCH 2/2] qcom_defconfig: enable X1E80100 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-topic-x1e80100-clk-v1-2-8841e87ad81f@linaro.org>
References: <20241118-topic-x1e80100-clk-v1-0-8841e87ad81f@linaro.org>
In-Reply-To: <20241118-topic-x1e80100-clk-v1-0-8841e87ad81f@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=654;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HrIOfustaNXDpNghsf8d17OXp6ri8t/rSafVFT/Vdrw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnO1I5b/NazQYNgqH2DfndiZ5KvSP/xd2yhMUekKr7
 InMs/raJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZztSOQAKCRB33NvayMhJ0a/7D/
 4oThtHS2My0A/cFYWakOyrhimcbFV8p4DRPZ902jqALiobH8wGOeBpqagUhiNdelPRmeSx+uwAqMJX
 pYoVODdzqQ6UFvEIatiuqE+71t/mj6hzhC+xGtdGSQeYCb4OkbfwOPm5GAvBIlLh4kPLCaGVdiOJEn
 jdE2GlY++aw9h+xQ8tSOdX47bOBDjCqmEXVeDR7TAGUDTORJmsrkBdssAOGLfLprYA5/JjzcZaw1fi
 EjdCa3h+zjokK1EXXULz8H6/Dy/+FeM586sqPrsBMGmI6fIMFsott7H87jfCtIGJbM5YsODePsFL+X
 iFWUXudgNEK7yU/bNqzgSzOorBN0LGkmpgU9rDD53jPAtSdYA4iB6aqnxe/Cu0xMM62APSzL1/mELa
 QyVEaD5YUgkifvL960hA1bJwNzpvsolPippRX8KS17gO2CFilopd9LGO88WbdWl/UTgBrQURz8Rtx9
 HchkGJ4ve68oZYEDxALhJIiMBfEA88+uoHTl6JWQx10n1zxNjmnJvchOhHElGrHkovZkD9e2VrrzOh
 pakGKVrxQ3W/RlLkRzglMoBMxy5N76JSzBB9a/rke0bUgzEI0V3w0SGhgbVSy/EZMFr0lUE8sjSYCs
 XUhwr4HrUHt3ztcGi7UlI4ojhNbeWFLLSi8zR5edzlqVK2cE48S15Hd2IoKA==
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

Enable the X1E80100 clock driver in the Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ea0dd3e58018c8bf08e4a455a47e29cf1bbd3c60..295e4ea157878c7ae1a4f5efe6651b4bd962b6d9 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -51,6 +51,7 @@ CONFIG_CLK_QCOM_SM8150=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
+CONFIG_CLK_QCOM_X1E80100=y
 CONFIG_CLK_QCOM_SC7280=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y

-- 
2.34.1

