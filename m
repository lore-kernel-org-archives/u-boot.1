Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5EBC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563EF87605;
	Tue, 21 Nov 2023 18:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IE6H1wZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDAB6875EF; Tue, 21 Nov 2023 18:09:36 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82998875EF
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c4fdf94666so71750891fa.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586571; x=1701191371; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1KRPp0tgvUr0eLUjVh/wpEn/h+zuzTfUfA4AIZQOtjI=;
 b=IE6H1wZ2+9GseweUaeRFZiVqbbT1HK4BVE081uG9c20mQaJU7zzzYJUF2Vip/Rw+w+
 i9EqGe3WJfPgqxz6UOkexNFm1ekou5nFI+qxiLnPr052qz2vM10GVqtDBQLg6qzxVWgy
 tObYjIisvdyqSunZj06ZzddtRBWOyKjEnZBlq+SL7oAH0X7nOdDc7NemGDGnvXk1yy3d
 cpbtSea/DM2EGgvoIyLnUC1jsUtyebz9/1TnrNKLQupMIn3ECbgn5G+5HRIQftZKuDfK
 CSfr+nTdeu0h5zLRb54f8xz+smzPWnAJEI2A7chUVhQGpsk4kLeMyZccgGiWFne6twdm
 RjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586571; x=1701191371;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1KRPp0tgvUr0eLUjVh/wpEn/h+zuzTfUfA4AIZQOtjI=;
 b=YdHNBS7RajqFpymTFMUlSp152d6rjffMAOLFBqAVyA4aDTKD5EOZZ0QIGkPrizFnOP
 M/RMb6D1LQfFujwUmaxL6oMFFDe8ZQbiEn8B1JCaaeZDwABmNulvxU7inCi1AOmgajKh
 +yDkDJTEN/ObKFR4JLtdyL5CSGKcVD/BufPpXGRabvD0ZODDNSppYMNebaU8BsX0+NZ2
 Bvmqo04FzjPEiVMhzzKcF2oqVI8ioakLU72aszSsnJNa8zBh2T0Vs49L+HvaG3XhIQeB
 3m78mAjGYPM2v3UOZZq+646ftxSgIkmsoYVntYrpwPdFiZ3Tu3U9J1ihwb04E2hhKE5F
 Omsw==
X-Gm-Message-State: AOJu0YzbZMbDfke1BuHTE2uqb74qE0xO4H+l7tub3XC/ieiQzUK9uHOZ
 U90xgROPFvFW2n4enHImtYwoVg==
X-Google-Smtp-Source: AGHT+IE8jmwJAzyj8aaTXxu8dyredlRy58hxY9rDmSXWscV9hwrW3eriMNL9S3Q2a0ZteqUTUFHRMg==
X-Received: by 2002:a2e:94d7:0:b0:2c8:71dd:3bab with SMTP id
 r23-20020a2e94d7000000b002c871dd3babmr7113773ljh.0.1700586570712; 
 Tue, 21 Nov 2023 09:09:30 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:30 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:25 +0000
Subject: [PATCH 02/21] arm: allow CONFIG_LINUX_KERNEL_IMAGE_HEADER to be
 set in defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-2-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=835;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=k2vhD8r8+pFuG13z4IX3yKyLUE1DsiqoCHQGWik9ctY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ65/Xhzy3r0qs//mHF+NFR/WVJxQc9s949dzT4P2H
 8aen4ISO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBETgkwMvTwrbl2W/C8fCtP
 sO76wyxsEeXNzgeSoqXjbltpXTjw143hf9XMXfJuU/7Xzrh5KUgh38CjIbDuven6H8dn3o/ZsuF
 +gxEA
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

Let this option be enabled dynamically for boards that support multiple
mechanisms for booting U-Boot (e.g. as a first-stage or chainloaded
bootloader).

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
This patch has no dependencies

Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bd48131292e3..1add4282f336 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -81,7 +81,7 @@ config SPL_SYS_NO_VECTOR_TABLE
 
 config LINUX_KERNEL_IMAGE_HEADER
 	depends on ARM64
-	bool
+	bool "Linux kernel binary header"
 	help
 	  Place a Linux kernel image header at the start of the U-Boot binary.
 	  The format of the header is described in the Linux kernel source at

-- 
2.42.1

