Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40581CCA472
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 10:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87933802C1;
	Wed,  1 Oct 2025 12:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G2BZG8oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D8F807C0; Wed,  1 Oct 2025 12:05:14 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC77D800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 12:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so51973195e9.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759313111; x=1759917911; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mex4AhjKhjpy/xGRSE+cO2uoSJpB4wSpDDJqPEc/Z34=;
 b=G2BZG8oayBYVyXIie6+FbO43lWVjCdsoX39sRCHZwQscrpuRmgmOVGMiZrHSulPjgs
 LVBR8bE7PSeYWrYDk29y66ACSSbMWj9VBfkT+8MyYqFfTvoYR3i2GwZJ+v03c6/jI/Bj
 gORjMqPle7xN0DYiA4TXqG+e8JZ8rgCtRtAu3wuoSwFzfaNb7AoByHU80jJPlzp3MSRN
 XZo3zMozoOpQrIbwrFRKJQvkDhC/Wv6MN4hPZSBtY8uZkiRelslz8q3HYVMtPklgLRKI
 pUdXZEiUSnYeMz7TVWWXMob/RB8rrnfV2N87Ey0pKBjr4IKyhYWEI0f9vhtDAA3e7/ut
 +aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759313111; x=1759917911;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mex4AhjKhjpy/xGRSE+cO2uoSJpB4wSpDDJqPEc/Z34=;
 b=ehE1ZZEjHsrt8i5pVxRssZ7ml3qF9gGTKLLg+6q3w/PslGIycbCswCS/lGeLFDdusi
 FwNZwzMCGHR1yeQveh+uZosb8HtDW16ms9pOQvlUj4wykE69byYRJRepOsc2A6ywvPbb
 SooQwa+M3zHz+/MzP8+BJjOVGKB6LMdpBHuzz0K9e7xlnMpHoggcKSwa4CSyKlO6gXhu
 Oc5HNV3jUJeU8GUZOJKSNJLW2wxrOK3OUn7kga7ZH2d7mg1R935JXkIjqdOCgWg3CPWw
 XOARcMV1EHnxW33vgHKgrE/vAreWU3ZbqRaRspNcWd0Qoymzm2TsVDXm8uF5SVrUsoxr
 So8Q==
X-Gm-Message-State: AOJu0YwY5XZ2ep2ibY8kevdMwX2TXcc6MXhqTODXoL8/l7zlxp4Q3c/Y
 Rx1Y3/GUI9VDwfzyAM9KUQNlXe9+EDl8+KsrzV+tpMkrhsOt1FeVUEgKxtwtLQY2O2Jx0F0RKp9
 iC2Z8
X-Gm-Gg: ASbGncuyg8KBE5a0/r80iHhaYYgU+wVzO6AHg5IoWs9YXBZtANVGlJxBkYM2fUGUPdb
 Pf4OZOn1Wm4eDIL20i4mFYwwLkEcSm8kg7kF1Z+kRZDgIekF2dRzLWkuhdb1/g1d4t21EfdDRyX
 CQnN48sg2GrN/7ojNoGJYuMQsZQALwu0dfvJYc4E2RY6lQgyTzNZMX3h7HvrUMibpPqj7UJDHfi
 b557d0ZipioUv9B6/Kp/N3xVmiDTj8XQDU2aP/6wOoy1qQcoLtBv36y+guRWEgpHu1lEWvDHSh2
 KfBl0QMgh0GpiyuRUxvKHMXwgnyZZg1DTMqY2aprM+qzgJsBDELXTDhsUPu8wxY3sXoV3p+kAOO
 9E7DzlGATOAt+ZyFXTrWRVqopdqP5+Fzo+JAKetDmXiK0huS2eg2ncn5Pkvs7/rqjqvvbFr/y7z
 s=
X-Google-Smtp-Source: AGHT+IH9DfwUMmUNFJmfqzcXU0aHitKbnE0qPZMVbpGOevXZqjllN+C1cOdA0sJcXrFFQ1+/QW91NQ==
X-Received: by 2002:a05:600c:8b06:b0:46e:2e93:589f with SMTP id
 5b1f17b1804b1-46e61286199mr25470525e9.14.1759313111166; 
 Wed, 01 Oct 2025 03:05:11 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a0241bsm31365785e9.11.2025.10.01.03.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 03:05:10 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 01 Oct 2025 11:05:10 +0100
Subject: [PATCH] video: nexell: unsigned parameter cannot be negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-video_nexell-v1-1-380881a4d30e@linaro.org>
X-B4-Tracking: v=1; b=H4sIANX83GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwND3bLMlNT8+LzUitScHN00S2NjM6NEg6Q0cyMloJaCotS0zAqwcdG
 xtbUAiiQWKV4AAAA=
X-Change-ID: 20251001-video_nexell-f93362a0bf72
To: u-boot@lists.denx.de
Cc: Stefan Bosch <stefan_b@posteo.net>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

The parameter 'alpha' is declared as an unsigned type so cannot be
negative. The code to test it as being less than zero will always fail
and so is redundant and should be removed.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
There is no call to this function currently in the tree so maybe it
should just be removed entirely?
---
 drivers/video/nexell/soc/s5pxx18_soc_mlc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/nexell/soc/s5pxx18_soc_mlc.c b/drivers/video/nexell/soc/s5pxx18_soc_mlc.c
index c8cf833f308836aa9205f4ed2148e41075b83c29..2c8348bf633929272d084b407dd4bc247eff21b4 100644
--- a/drivers/video/nexell/soc/s5pxx18_soc_mlc.c
+++ b/drivers/video/nexell/soc/s5pxx18_soc_mlc.c
@@ -1641,8 +1641,6 @@ void nx_mlc_set_layer_alpha256(u32 module_index, u32 layer, u32 alpha)
 	u32 register_data;
 	register struct nx_mlc_register_set *pregister;
 
-	if (alpha < 0)
-		alpha = 0;
 	if (alpha > 255)
 		alpha = 255;
 

---
base-commit: b2d5e46c67002e46ac339ef549ea18cf5adfcd87
change-id: 20251001-video_nexell-f93362a0bf72

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

