Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A63FC02190
	for <u-boot@archiver.kernel.org>; Sun,  2 Feb 2025 17:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 515448006D;
	Sun,  2 Feb 2025 18:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fjbobysK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F3280077; Sun,  2 Feb 2025 18:05:25 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6773E8003E
 for <u-boot@lists.denx.de>; Sun,  2 Feb 2025 18:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30227c56b11so38335321fa.3
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738515922; x=1739120722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TVerUSZo8j5HNfEtK2PBsKz7KK1pKmeVt++CDJFLmHo=;
 b=fjbobysKvplBMXxQZd9z+8wE18umNhoFNGSE+EbO3oB3zP7tmQrflID5gUFHmJFQsL
 sjH6x1QKgTGE/NfCm9cVoV9uXzVWD4e1/ps0nJs3Do00rhtKJdWKbhaRqVqdqaoXdkft
 QCGQ3bSwGp+PM/Z3CUeSrBdDcxu1GRUftk0an/7IwVZvRyoyYyNzOJICJvGU9gzWf0iQ
 w9ba56mkBe7x6+/K+lOGobF6E829W32fpyia0QKQerxng/EKECmdr5efGzUG9ck0F82s
 kAIxHdKx7ervnpoNDoQtx8DwAAkuylp0OvBih5s9B4FJGbdK9ci5UKK3GoS8ZnR4BRS2
 9Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738515922; x=1739120722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TVerUSZo8j5HNfEtK2PBsKz7KK1pKmeVt++CDJFLmHo=;
 b=i6kZ7I4TSv2vSdLE0Se88P0SSO7UUPqIPcxe4DA0hMm6QYOPDM/ZmfTCJwqHYv21/C
 HdJkn5lMza84yfvSrq17+VWryhRzQXWTrhp2wB1mjguBLp5qlgu6oga1uYV7xWN48szW
 +fp0BOP9IKcgVc07rkJPpSaKXTNeRF3dghQE/SrJqSArlGTy/f+j0Y0PYsIsWp3HWHzw
 pHUu5lvAwud75k8S+PoY734HqRhZ2d2nePZrgbbLW0U1p0uYQWHrFRLfuzYpRdCvVp0N
 ie4YJaEWKMaOjXPGPUv22hQrhW7wlkShZ0h1TFBmzFTplBPfVMyI5NPLpvhKYJlorm/J
 fh7Q==
X-Gm-Message-State: AOJu0Yy3IcCA6Le5l6m/Uw1yWxGMCKW9rjTmGzNO/9Yms4iGjQhYq/Vp
 r92FeTnKHgSYqQSpBG5HYy+7w2LmNSd96StjftSM7C46R2lNpXMF/NTlTQ==
X-Gm-Gg: ASbGncsMtpiHtdDYukHQDbNSPZurE1oJWSPHkpcH0HEdws4v6uZNVR1XIc6qto187bK
 HClkZSTEe7RcDlAhUXu1R/rxjbZrzZA6EkIZQoD8cuWYnIrb9+I9u/I4fZcAoioo0lb6LMysV2t
 yEQcws5sP9YHWrSPxRuew0L2JQyDeMXzJNov78lnmDuEInp6PtXvrV+TYjTVg3Zncj8ualuCvL4
 6KzlGSLQau4WQsWk4PRl4fS0l0VtMt9RyvxoQiVj518fbobqpMBuSKIIWfLr2GEN/v9pW2qdpG6
 je5/FqXzSEr60jaowKFfhf4=
X-Google-Smtp-Source: AGHT+IFbbWv7GlPpv6lr9NStnI9ZDnst/2H4IdmW6CjdH3vdWJfcr1C2vQc9PPUNTwAuOfF9Cnu7DQ==
X-Received: by 2002:a05:6512:239e:b0:543:e4ac:1df3 with SMTP id
 2adb3069b0e04-543e4be3f59mr6207854e87.16.1738515921870; 
 Sun, 02 Feb 2025 09:05:21 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-543ebeb7d46sm1030228e87.190.2025.02.02.09.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 09:05:20 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: imx8image: Fix potential memory leak
Date: Sun,  2 Feb 2025 20:05:17 +0300
Message-Id: <20250202170517.2064667-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Feb 2025 18:16:01 +0100
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

Dynamic memory, referenced by 'line', is allocated at imx8image.c:270
by calling function 'getline' and lost at imx8image.c:294.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/imx8image.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/imx8image.c b/tools/imx8image.c
index 15510d3e71..0135b19095 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -290,6 +290,7 @@ static uint32_t parse_cfg_file(image_t *param_stack, char *name)
 		}
 	}
 
+	free(line);
 	fclose(fd);
 	return 0;
 }
-- 
2.34.1

