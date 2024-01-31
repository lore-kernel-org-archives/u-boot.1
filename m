Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFE3C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 07:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826468798B;
	Wed, 31 Jan 2024 08:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kkgVh7eS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A9D8798B; Wed, 31 Jan 2024 08:09:49 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C8D87A23
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 08:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40efcb37373so16900285e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 23:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706684985; x=1707289785; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GnvJ9BEJhaTmxxdSlAReQLQKslNYpYTBFduajb3Rc7A=;
 b=kkgVh7eS3FFbeD9vaYpM5f2wVt3P8tzp5qkK0Ts/0OPTNJ0xOexxtEKLwV24I+VS93
 hobKgMnjuSXawLE2cVzYVu0MQvtYIgAe7IRiTIEVEnEJuzWx/ZT0XGFCTLAcLwerZAWd
 WkjJ43noV0sfTmCDXivxdCx8+Zxl5FxzbHFJce9ZJNlr6tA/6iC6kEPo6Q7nCXxAv4pB
 wrm67khJwDmC/MO2WL6U26UiMNJdZXvsUJrKeuo39ZrYYDPvAaBwFcL080/Q7d575Mzf
 3VhTd9do3gc7FEfVQCyO3uNEg6wkPMKeOA6uxQXHFFHUs0wN7ftSIO9+Hbyv1+TcqFLj
 bxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706684985; x=1707289785;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GnvJ9BEJhaTmxxdSlAReQLQKslNYpYTBFduajb3Rc7A=;
 b=BVzCRuYRJ6OpVwAtQoCkTWojRz6eaW8jz/bPGGqdiZ9CLsaweLI25dTH4K645+25Kq
 PCZvAr0Ek3A0dvKqR1YzXEVr2XiexZmtTJHr6sPu/mN8gfR+VryZzkEGG57PzxOnQTgx
 H/WhONUb42LOd08lQX1zGp9sWhKMs1TlHXBluv+G62hwSPSG5i9i9txMcho4b79315iK
 L5m7w6xiF3b0DHTWF3C+PRuOIGppJ3D/BoWkZs6yl8pSTw24rRZ38Subhh6vSeQjgYaj
 /t1Vh7oGB94jigY7q8QOIGeWf6nXFyExQN3IZnNG80P6a3f9hQ5P9cDJmKJbbCzzU3O4
 Zwgg==
X-Gm-Message-State: AOJu0Yzz+S4J4uVNbEDNWo4kwFn7FJT0eppYH3RxnFq/Qcu7ii1qbv5p
 lo5u4RR7amri9wzsmuWYWBy/t+LDInMKD8N00isNIVV43rYfncTCzJIjCq5K9/g=
X-Google-Smtp-Source: AGHT+IHGJxIZL6rP3RBYzSVW68xBu/BeZ9z7p36l7QYkPQfyaOF9zK/c2KO3xHw4nOFRB+sRK7Sujg==
X-Received: by 2002:a05:600c:3b20:b0:40f:af67:5275 with SMTP id
 m32-20020a05600c3b2000b0040faf675275mr578888wms.4.1706684985194; 
 Tue, 30 Jan 2024 23:09:45 -0800 (PST)
Received: from localhost ([102.140.226.10]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05600c00cd00b0040f02114906sm649507wmm.16.2024.01.30.23.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 23:09:44 -0800 (PST)
Date: Wed, 31 Jan 2024 10:09:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Przemyslaw Marczak <p.marczak@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] power: regulator: Fix error code in regulator_list_autoset()
Message-ID: <06ee0d87-35f0-4fe4-87b2-e498b2263ee5@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

This condition has a bitwise & vs logical && typo so it only preserves
odd number error codes.

Fixes: 3b880757abca ("dm: regulator: uclass driver code cleanup")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/power/regulator/regulator-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 77d101f262e2..de2bb3b1cd88 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -390,7 +390,7 @@ int regulator_list_autoset(const char *list_platname[],
 		ret = regulator_autoset_by_name(list_platname[i], &dev);
 		if (ret != -EMEDIUMTYPE && verbose)
 			regulator_show(dev, ret);
-		if (ret & !error)
+		if (ret && !error)
 			error = ret;
 
 		if (list_devp)
-- 
2.43.0

