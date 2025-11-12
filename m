Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E24BCD37BF
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 20:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9E0483DE0;
	Wed, 12 Nov 2025 21:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B7DKNaHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6085683D0B; Wed, 12 Nov 2025 21:03:33 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51CDD83DA7
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 21:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e3dac349easo931383fac.2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 12:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762977810; x=1763582610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dc9rU6416qG7z+PyvtkSvZLVH1VPSaD/z3/9aMZQ/fo=;
 b=B7DKNaHCYWhV7Lec2ZBfk2FB4wqCP9lgRLlfz49/s7epTBiiJS/Zejay4iKuYNuJOV
 z8osIsJvgrVK2hiMsSHp8c2g5dwK5PnThVslHBVv9asi0UM9W0TCOVt7tu5rWWVQqlNB
 4ZoPp++b0pgtHKGpoqJhz2qD7Zx64SfNTrP5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762977810; x=1763582610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dc9rU6416qG7z+PyvtkSvZLVH1VPSaD/z3/9aMZQ/fo=;
 b=in8LA5GjCzO5zAj3skDI+NYRc3WwSJNKUtlRMlfV8h+RlJCbNOdrcnXu8P5TNY814S
 U5Oq9v1AIb67GV+WayI9cGz34C0goM2KpkXgvfrhe7Yg7sAR2yLU+3HS7kcbfBlLeaNB
 4faUH0YvvKevu1oRn/xXYQ5JBUr0Z5wvVBOtjkNKbvmNOqegQyYH9I03ky8ef4IUnhYZ
 eEbt9ttttT+HoBKghdc1xikShsJujNsm6XagA1Efm3Qx5PVQtGGeXqugRu0O9nXTx5et
 gLOTXj8nO8X6fG6ydOiu57D9Az2jT8+Dz1KRRUGlizZAYTpXnIERcKYKEmhLhQkvQQ0G
 Z+Zw==
X-Gm-Message-State: AOJu0Yw7MqaT9LxyEkJ5uf9xpcxQZcqNpdgxxHhpwVhfyg3hpVH+rvln
 1ekLsvpguN1coz31Zc2TINEM8zdJLXo17AmqAKaeUTe8a0dGgCW60/m/ujiXpElevfvXzRtmCuv
 NK1fu+BUkyQ==
X-Gm-Gg: ASbGncvIPyUzdHK6vMnMBiplatIVlSTMr6Sxu5mQUZSPzg8rwSxcSXRnXO1NAoKzxx4
 4dnJ3XRMFrMjxa2OwqWqoxX0INlnbLWxF6K1hTCM3c8eo6K3ahqNKygy1U9Iw64U0AVS+J84JUl
 UghYlLAJwU5XXEc+CPiaMXlFj80jGO1WaznyY8BvYldd9zlgYkPzbNfzUU5K/92TZF7sX+Id6sj
 rIzK+PLJOlKnCxTGtTQroqiJY9kIBYKbK0bZnMH/7oSR/W26d+ABUkPctZoEA1+DGxXqpL2p7fu
 dFb1JZ9w5vkISZFLK5FbE4ki25hEtID5Lo4LlPmlOXXtuGDycIyKHJzzJUOi1UaxTf3zvPf7Wxi
 T2YX9IsZ8AplE31TVZlNAMbjYYwSJ8oSN8QglequPpVY0gMEYcR7/6dOz3zHCA+BcKKH53buoXZ
 CNfFD9yIuPT23ZI1pnuHBw9FDk/IVqW1L7NsJlM1elZg==
X-Google-Smtp-Source: AGHT+IGLLznaZy6jnlZ3FsdO6ijNx8sEblcLPg1w/d6RIXiYuG1Gefqbc9PtTViypVYVJScNMjtTIw==
X-Received: by 2002:a05:6871:4396:b0:3d3:4338:bbab with SMTP id
 586e51a60fabf-3e83408effamr2168333fac.18.1762977809911; 
 Wed, 12 Nov 2025 12:03:29 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e83281c9bbsm2169596fac.18.2025.11.12.12.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 12:03:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Subject: [PATCHv2 7/7] video: stm32: stm32_ltdc: Add missing <linux/sizes.h>
 to stm32_ltdc.c
Date: Wed, 12 Nov 2025 14:00:08 -0600
Message-ID: <20251112200315.1111980-8-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112200315.1111980-1-trini@konsulko.com>
References: <20251112200315.1111980-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This driver references the SZ_ macros while relying on an indirection
inclusion of <linux/sizes.h>. Add the missing include directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/stm32/stm32_ltdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index 0a062c8939db..1281acaaadee 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -20,6 +20,7 @@
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
+#include <linux/sizes.h>
 
 struct stm32_ltdc_priv {
 	void __iomem *regs;
-- 
2.43.0

