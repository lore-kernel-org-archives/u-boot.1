Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C309FD376A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2BC84118;
	Wed, 25 Feb 2026 17:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OqsOnrqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE96084129; Wed, 25 Feb 2026 17:20:58 +0100 (CET)
Received: from mail-wm1-x32c.google.com (unknown [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F398416F
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so9949005e9.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1772036348; x=1772641148;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKC0I/zSUXCK7LI/x6OL7XjZ+Bj3ETz1H98338kwM5Q=;
 b=OqsOnrqWndfdOR+Liebc5uzruT+oofZ22EvA64nVyMDeetk2WzMiqvW/qPzB5Bte+P
 4EIJf8PZAa/coXyN65C8Od7uUZFuoiCCuQ4hEbAWhvipWyeq0I/K1hVK3Az7K9FmtwS+
 a9RaGZvFXwp97pgSAsUCUmnKFiZcKcWOlN4zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036348; x=1772641148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fKC0I/zSUXCK7LI/x6OL7XjZ+Bj3ETz1H98338kwM5Q=;
 b=Ye5rAbZKsHy/Vsy4BJ/c/gRpbQSHfC59jC+k2WCp0iRq6YUlt20VvgFPrtLNL+YBM3
 sHwzsSeNq0RUU1j9BVlJ4Kvn5R8WL43DL4tvdKRtMHg9YayIao7xO0dMWXDCGeE9eioD
 HC9dL7W0h5PUeka+ImVLkQQTY30qa6Ru+SdtX5yP0Tmc4cPp/6mJrmS58MVCLX0bpgj5
 p7FeAy6QshCtDSg8u9NJ38gi3QUG/YW6F7KQXAqtH2j7WPmOe1fbd1dEQEjwLOG7pP92
 d3WHWfwtim5nabjTei6bazchsTtKTZPyRE0tIPPbwEWlbefYAz8vgCaJIrJDrY4hVubN
 lR1Q==
X-Gm-Message-State: AOJu0Yy3BGcI4c146YbEgz8Du5TqE5QwRv5fjX1SHwSyE8gkzYgJvZ8x
 SJeZ1iZhuEFuAB9ibSisGBq5v5IXYwjWeWz7/SLePI2f0+5PaQ00/YQ/upM/lYoZeQiwNhkkzaj
 g5Tvu
X-Gm-Gg: ATEYQzzmKZb5fwiEmfrNPLGPqrt0tyHlLypoas5NY310VAIn36xahnK+W9g7FsDDS3P
 kc/8BHd3fN2eCMvJ5tcnxM3tHO/8hVX7hTRbaDTrKZmdY4deIdgwA2yUEF6dbpSbbpXAav4I2N9
 mSFueE31y3EJZYFHsBDV6zCTTxOvpk3Mzqz8BgmUcMO+jgebtdPqxPXWhoUikUG/J79TOjyzXlF
 N1il4WIXrOljWq9qOIlK89aSNFQuGqnp5BiRthCN+8AjUx9MpJsAUDC0s/KbjFmS33mVhl0swA2
 Y2SHrie/ErNRoPokchep4I7tgNEnBGhoyBF1/xCNSn+NPPa5Z6aA/l2HXBp+XKH4E9a7E2Z9qpq
 Q40QrdudP4amax63vfhaSwY8ZKw5+jrwg7v9YxhHlwFsF7Uzv9khQhfk3OlUvpXhtHzfoDFSmpJ
 ABqK5ITFvgoA5X1iA0AbvhkZdv2+ddx4R8xeinGhsNWZrtmlqmBL8jxmudkRBQ8lcRZTeW8W6/e
 +3IRmj3xw2P7OErD0QskLCEWkpVVfnvTzXZqI6JhneTTYm1
X-Received: by 2002:a05:600c:3552:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-483bd725417mr79218795e9.3.1772036348360; 
 Wed, 25 Feb 2026 08:19:08 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.43.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm186562265e9.1.2026.02.25.08.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:19:07 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 8/9] spi: stm32: extend support to STM32MP25
Date: Wed, 25 Feb 2026 17:16:59 +0100
Message-ID: <20260225161851.2475274-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
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

The SPI IP in this platform is fully compatible with the current driver
implementation, requiring only a new compatible string.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v3:
- Add Reviewed-by tag of Patrice Chotard

 drivers/spi/stm32_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index 9d095b280a70..b7bc5816cc13 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -684,6 +684,7 @@ static const struct dm_spi_ops stm32_spi_ops = {
 };
 
 static const struct udevice_id stm32_spi_ids[] = {
+	{ .compatible = "st,stm32mp25-spi", },
 	{ .compatible = "st,stm32h7-spi", },
 	{ }
 };
-- 
2.43.0

