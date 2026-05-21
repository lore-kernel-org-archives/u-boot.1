Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31880CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 19:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65EC8487C;
	Thu, 21 May 2026 21:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FlmX2lY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B054284852; Thu, 21 May 2026 21:14:17 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A78584825
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-39397d63804so13783011fa.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779390854; x=1779995654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kbHS9HWEMsi5CNFoMsE7hRqpqGW00XyoHagEqxGozU=;
 b=FlmX2lY/AkFEyUza+NGp9LK7cSQOeE4NyVp/LgV90A3wmoYiNZFrTCbnPj3wIfDXFj
 9ux2nlX1hlKbYN2OgKMZDRDfPBt6/jA2/KBseONl/DSUsKE5G4CVuLoibOLMcPMYTE/x
 PDNA/AJBarOqYmqeGFMX/6MTg+s2cLHfzgQhTD13G/RJkUzY/+Maawiw8XMUJ9lPbrm8
 AZzxsq4O5FeIw6LeZ2jpx9FjDKp1/6NqluWvCzV/b06WCZkNBoqBQV1ZwKZVT9iPMnd2
 6I6RZDQDsxv/baH+0rY6285xrZ0gXpi4RWREKupojP0YF9A0zIql8wqs/HYL9Duz1NV9
 Vnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779390854; x=1779995654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4kbHS9HWEMsi5CNFoMsE7hRqpqGW00XyoHagEqxGozU=;
 b=nFKE3XHrRyukCcv8Y+YZZU784NwuHcCVpzmTW4Dc8Z5/pPmbURL75Uovsg/gSKYYka
 NU2EjBKaP8m8SfWY3MRzNees5/He1ZYXlYIUlDtRuTVmxtxGzjqx0hBC9wrocQ2YC3jQ
 KOltSs/kzdV11SMMntqjChq3UUsqxDieouds+RmsOkNBlvnqFhL0OX8YLzXgxh6sPtwS
 XollVMVV0c0cM3HZvmCXswg+AM45HeNZypGA+IquKCNc1HaEmM29WvpSvfeYKppEzrsx
 2FOYe2S3n9ATtww8rfwTFm4Oc2RSadsLV2ZM24nipvoRr/EhINEm47KENsuFYx3x9yOq
 v4rg==
X-Gm-Message-State: AOJu0Ywi8efOwDpxoRVUEPAirR2Mi2dQVMIQKNrtBBmp1W3oqzf589Lf
 P2XW7X9GghP6td/4OfoQJbG6GxBjbTH9QZfDk9P8ZGhaLM+ovujLIsY2y+hhgjGMBzguww==
X-Gm-Gg: Acq92OE00xTijhZTHvEDHnOp7uKMStQxfg63uihEYWT50s/VUucn1FjODJCiTbtfttu
 kJ3vEMWxZhmCZZbnhU170m7mVZ9SkFJRNQ97fB0PSjZGbIcSnD2IeWIXZ1rQM+4HBRKOPfiprfB
 jiewJi+CPC1jeBUKvDZxNzMJ8HwYyMzbR3Mc1UtDOBEzlCcu0Qb4pVQG4OWggihon1vvUa1mnZe
 MdOdTDwAQI/lb7JVMuJKLb+q0y+uLcxnWwFIdPueDSQpGrWeV5wC2Rn4ByXLjoMMmHaA/UjgJcY
 NXZ+1RQDQ6molYKwt0oSjMrdFpa57wnwT1m8UTfVRfv7pnwX+pvNitMeXIHW0i3kkzXE/DTnsg4
 H8cUh0rKEn/H8y03McaCXWtxCbsiPGfHuPOj4hxxHKHCP5J1XNIbey3jtI8e0KyYPEreg3esb38
 X6BcMg/+pSYTKY54uuiTqgXDBcPnAY0RoiLRst/lEBnPbcYlU3pkpTEFv6c/W070t1VBS0c5hm0
 I78yx83AANoEM5nc5KhJOvI3BARuwRzoM4=
X-Received: by 2002:a2e:bcc4:0:b0:394:44cc:c944 with SMTP id
 38308e7fff4ca-395d8d78a67mr603381fa.27.1779390854269; 
 Thu, 21 May 2026 12:14:14 -0700 (PDT)
Received: from lnb0tqzjk.rasu.local (109-252-125-213.nat.spd-mgts.ru.
 [109.252.125.213]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395d9442ee3sm38701fa.6.2026.05.21.12.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 12:14:12 -0700 (PDT)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] tools: image-host: fix memory leak of info.name in signature
 functions
Date: Thu, 21 May 2026 22:14:00 +0300
Message-Id: <20260521191401.29310-3-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
References: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 21:28:08 +0200
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

Static analysis reported that info.name (allocated via strdup() in
fit_image_setup_sig()) is not freed in two functions:

1. fit_image_process_sig(): info.name leaked on error path and success path
2. fit_config_process_sig(): info.name leaked on error path and success path

Fix: add free(info.name) in both error paths (after fit_image_setup_sig()
failure) and at the end of successful execution paths.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 tools/image-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/image-host.c b/tools/image-host.c
index 8b550af0dc1..1573adecc33 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -245,6 +245,7 @@ static int fit_image_process_sig(const char *keydir, const char *keyfile,
 	if (fit_image_setup_sig(&info, keydir, keyfile, fit, image_name,
 				noffset, require_keys ? "image" : NULL,
 				engine_id, algo_name))
+		free(info.name);
 		return -1;
 
 	node_name = fit_get_name(fit, noffset, NULL);
@@ -272,6 +273,7 @@ static int fit_image_process_sig(const char *keydir, const char *keyfile,
 		return -1;
 	}
 	free(value);
+	free(info.name);
 
 	/* Get keyname again, as FDT has changed and invalidated our pointer */
 	info.keyname = fdt_getprop(fit, noffset, FIT_KEY_HINT, NULL);
@@ -1094,6 +1096,7 @@ static int fit_config_process_sig(const char *keydir, const char *keyfile,
 	if (fit_image_setup_sig(&info, keydir, keyfile, fit, conf_name, noffset,
 				require_keys ? "conf" : NULL, engine_id,
 				algo_name))
+		free(info.name);
 		return -1;
 
 	ret = info.crypto->sign(&info, region, region_count, &value,
@@ -1122,6 +1125,7 @@ static int fit_config_process_sig(const char *keydir, const char *keyfile,
 	}
 	free(value);
 	free(region_prop);
+	free(info.name);
 
 	/* Get keyname again, as FDT has changed and invalidated our pointer */
 	info.keyname = fdt_getprop(fit, noffset, FIT_KEY_HINT, NULL);
-- 
2.39.2

