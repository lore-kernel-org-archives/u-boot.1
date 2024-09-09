Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58921ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 13:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4806788D83;
	Mon,  9 Sep 2024 15:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wpbzlxNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191BF88D1F; Mon,  9 Sep 2024 15:23:33 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E9E88DEE
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 15:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so7802165e9.3
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725888208; x=1726493008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K7xMBYaYE2Ibn/0VK+ds2g8ad9Z8O8TKHvpQ7/fYy3g=;
 b=wpbzlxNnJ4O+/K3XL+4nvkBR4nUlWYHccKUMuEeln6Lj2NFzr4wWhKUFBA5gRl7RQ+
 heuMMEG8dnGy/QCF3Jm4YJ6J8k+HsdDfbTRDBklgodee4EpYb+MLqR3K+3vZWvOtr89v
 fxXPW1jtnAV+q08n9ioJw9aINdVtdZYdgd35qjnftgDY9TglqjCDAFRC3/UBxubWTgox
 S0nDCe2oh9T5AkycAOX/5uqvUiQpUYceX3auFSguYdCGHusGphDvUQZyG0JHHzD9VtVG
 sD2IFA4jCVW0ctNeq2/8zwE4tE+cisfQRnQoriimdLuiE4wOTuvMy1IYoQR3DzuzS4Lq
 laGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725888208; x=1726493008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K7xMBYaYE2Ibn/0VK+ds2g8ad9Z8O8TKHvpQ7/fYy3g=;
 b=rP5/yQjEajGyyDED7clL2Em3JBXf9fVd5sqFHOJVCmhDf8sbgZqjtwhf8PhtjXDsij
 06SLByGAYfg3rY+zagSwM11suZm1VE3/nCUgxQNWO858XclVk79/yfADCiNsfVk2Ty1g
 s8BPoFcPD3rhVT5DhouwZ6uZMax82mjCXnDSpCciuyO93IKj5kEgpj13Y4TBJhwgBwSj
 iQZsykTZp0mqV+slFACe5U6mpbhqofm02JsohfnqcqNJ3mICd1v+gfHL6AN4Mas/Fni3
 gowEM9jmKQjMdgiTtlJJZWzO9C0l/t7W4hMP4g+L6QpOBlwbyghwK+ql4C2sdIq0CVCW
 S5Eg==
X-Gm-Message-State: AOJu0YxjyovikcR9K0N2bCTxiaEHf/lVVYKBgyMKQf6Rz1AXlx0UDVvR
 87AqZP/slaw6oqRF9uweE137ex3E0wgU24kdMu5UB6pKvlSiwU4hP9gfddRaYccaWAsUvXKI0xe
 HQ5XZqg==
X-Google-Smtp-Source: AGHT+IEepLAavy+YAdIKgmT3nBHc9Fmm3o+0Hgm0MNhlS914qzbTbP9VNCYsP9+JC0U8yv8ek4ClBw==
X-Received: by 2002:a05:6000:542:b0:374:c57b:a90f with SMTP id
 ffacd0b85a97d-37889659729mr6399292f8f.42.1725888207546; 
 Mon, 09 Sep 2024 06:23:27 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4bd0:b9bf:1fda:1d0d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm6112189f8f.7.2024.09.09.06.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 06:23:27 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] spl: ram: fix build warning when neither RAM_DEVICE nor DFU
 are enabled
Date: Mon,  9 Sep 2024 15:22:52 +0200
Message-Id: <20240909132252.3975017-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fixes the following warning:

common/spl/spl_ram.c:19:14: warning: ‘spl_ram_load_read’ defined but not used [-Wunused-function]
   19 | static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
      |              ^~~~~~~~~~~~~~~~~

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/spl/spl_ram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 71b7a8374bb..1a5874c3949 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -16,6 +16,7 @@
 #include <spl.h>
 #include <linux/libfdt.h>
 
+#if CONFIG_IS_ENABLED(RAM_DEVICE) || CONFIG_IS_ENABLED(DFU)
 static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
 {
@@ -96,6 +97,8 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 
 	return ret;
 }
+#endif
+
 #if CONFIG_IS_ENABLED(RAM_DEVICE)
 SPL_LOAD_IMAGE_METHOD("RAM", 0, BOOT_DEVICE_RAM, spl_ram_load_image);
 #endif
-- 
2.40.1

