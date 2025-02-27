Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A65C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 09:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E778083E;
	Thu, 27 Feb 2025 10:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y5wdf+9B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 924ED81109; Thu, 27 Feb 2025 10:49:28 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AD1F807FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rui.silva@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so365766f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 01:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740649766; x=1741254566; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49zcPuWwPT56Y9L/CSgdz6/4Ux7kB4moIUS6LUa/Hos=;
 b=Y5wdf+9BPm6tn7oPS/QkwFt6daoaGrgJjhzOhk+cuNNz5Fj5UIoknCqTXQzopCOA4o
 8/aikpWGbzRSUA56VqxHImShilH1bxgIca8BqURCOSJZhIj41MOmjjJwmrjQsW4W+4fk
 1X6c5iOGqYxWedSOWUQBolTj277uIfdnTFXduZLaSgRlvQPzacaBXkzPn5hBV4I3ZnUf
 F1h7p+k9MTC2Gxu/V9MENbIZ+zVCWKt565qDIV3wsTtZZH5E4tonRAtNNsFdy2/wAp44
 nVFiYr/ukBjmk1qMla9zzYynwuJmIh3Rv0t60c0WY4Kjyd8hxqVcNk7RAeucvzFh9gfI
 1B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740649766; x=1741254566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49zcPuWwPT56Y9L/CSgdz6/4Ux7kB4moIUS6LUa/Hos=;
 b=WCoxsUnz4/+JzFqtaWNqBCSSMJQcRXgnTmJcX+YC00kbZFhlinLMuU9Ci9WQzzLV44
 qg0kR7F/ejG+yXXR9JTlU6Xe5hXY6yVbN4dbUCkJbj+VPPH8Vbs0DfButqYwpqWWdXAz
 1mtb5inRg2z8Gc7GAMd2deRJ6SZmxGDTXfb1gz4Q2QqdN0ha+18AdW6GXjaJWYAVP3v8
 QqdhqegQlD3c5Mw0stczD5jIPrlDnvdA0RwJrBW9Om5okpwYHGJBUzM/KwlD1hpVwlcB
 jUqUSwHQ5fWAxxv7a0QgAGedasInsgXQeKPW3Z87zBflQ50wTm79NCIyvE8MjcR9CcTh
 gUCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYhI9Cg44MAXlu8w/kbnkXGZT44WaKzGCVqsuvmLkDbaJRaeBWMxsbzeCsewc5aPqU5k5j1zw=@lists.denx.de
X-Gm-Message-State: AOJu0YxG2HutTvjj1EVFzEoYMAS6aWPVKuNmeKS0EkZRbILIo6TmGwqC
 T5DX3Q1iuyLhBDezYNhh0tDA+IknS4hMmTheHhnb6eYQrZOT/9OluhEH5AGAcnY=
X-Gm-Gg: ASbGncvErjIJV1qew03uxPx3cqsitIAqa6w313bXQfVrKqvzZpWNb8FojNovXJWYmlE
 8UepHaWZzb4Y5lZaZxVZlNRYpiFtX9MuMmHXFHq6mAlIlenrBBUJywpA2mPj4XbbgphFHB0Rj1b
 49LcfiU8/6qzZXjyzCG13I6VDYXaPBPIvdtCNCrQORiWJ+xKseBLPOtIWCY3QNsJGfFCEarny3Y
 sT9glwEb82K4Izp++tHIX+gB9jtvLVThYEosOwhuLNuyaUvbTRgVOyOWUOApbqQaTCyTYjaMmEO
 eK4LMGX6xsu5OpG4YUM/xgWtfoQUeDf7v8azyvEPY7ww+f4IEOtAhLXY4IzhcBY=
X-Google-Smtp-Source: AGHT+IHICcKSKwJgm4LZrayCAKpbe739joCToMT4g62wGJSVUUN/zv6R/r2kx/P4fMl8pEw54EcHBA==
X-Received: by 2002:a5d:64ae:0:b0:38d:e420:3984 with SMTP id
 ffacd0b85a97d-390cc6324a0mr9919030f8f.39.1740649766075; 
 Thu, 27 Feb 2025 01:49:26 -0800 (PST)
Received: from arch-thunder.local (a109-49-32-45.cpe.netcabo.pt.
 [109.49.32.45]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6a4asm1506162f8f.34.2025.02.27.01.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 01:49:25 -0800 (PST)
From: Rui Miguel Silva <rui.silva@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH 1/2] mach-snapdragon: of_fixup: fix property length at writing
Date: Thu, 27 Feb 2025 09:45:49 +0000
Message-ID: <20250227094911.497219-2-rui.silva@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227094911.497219-1-rui.silva@linaro.org>
References: <20250227094911.497219-1-rui.silva@linaro.org>
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

The length of a property includes '\0' in a string type one, so
the length passed by needs to have that in account, if not,
when getting the property value it will fail because it
has the wrong size.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 arch/arm/mach-snapdragon/of_fixup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 55368dd43b66..ea956a4791d0 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -86,13 +86,13 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
 	}
 
 	/* Overwrite "phy-names" to only contain a single entry */
-	ret = of_write_prop(dwc3, "phy-names", strlen("usb2-phy"), "usb2-phy");
+	ret = of_write_prop(dwc3, "phy-names", strlen("usb2-phy") + 1, "usb2-phy");
 	if (ret) {
 		log_err("Failed to overwrite 'phy-names' property: %d\n", ret);
 		return ret;
 	}
 
-	ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed"), "high-speed");
+	ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed") + 1, "high-speed");
 	if (ret) {
 		log_err("Failed to set 'maximum-speed' property: %d\n", ret);
 		return ret;
-- 
2.48.1

