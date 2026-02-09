Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523BAE7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B92805D7;
	Mon,  9 Feb 2026 19:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EEAwqeKA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE1283CBD; Mon,  9 Feb 2026 19:17:15 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C316883C5E
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-385bdc72422so42910281fa.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770661033; x=1771265833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QZhkEIvA+9zhP4mmp56exH8OQIHxe4VE49DwNm4jk4=;
 b=EEAwqeKADaDOo2paEjOZrJ9KRm1aCEHotef2zEAAFoO8uBSFKKvjWQkkW7kfIWDeEb
 nv/Mb+qcb+lfWuMBIrlmrWoovvfzn/VaZ3y0HJY6CH7arakCDJ4lW+rEb6C/LMjNZJ6K
 88Uc8Jq3LiuCtjx3QS3x5YI4q+sFCGzQRWquQAYGsqtCYge08CPjVGYz0OIPcRjMj9pX
 Xt6pwMHu+ik7jDwkHpY+P2j8AucWZehGXCk5kV8WkWKZT9Hj2a0Q6yU78S21z6KRYy/C
 YZ8YNr22R+uGczRGvrx/fiFR9i+mfv3SfWjDLtgYY1UXVU0x+11+N+3PPDSMbJmZFX/9
 FZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661033; x=1771265833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0QZhkEIvA+9zhP4mmp56exH8OQIHxe4VE49DwNm4jk4=;
 b=v0kevdjH5NGsT1VDJGz+RWpPI0E/lwXgMGcm8MqMjPH3MkLXACN4wyPPxW6Jxj4TK4
 OhTt9OlNEuzFBXSkuWc40vq0megrvYBDaVS377g8uA20L+Bd/c+lebUPaaSmuzRQQLkU
 DDOhgyJ8tbfHho5c9rQa5OiPm9yZ4lQllxqlv88Xk7q4v9vUIMXqaIZldYpm+VHaavx0
 PQoWiQPfWDj1pB1AlTw0aAOO9J1j4o4Ww7UMNu1SKdwSOLI0CnqCfHHyVKw0KakVpwwi
 de2g1Eo6RXcIFAhu6PkVEcVhaqrX9C1G+uoad510dW/bWEa1rvml/M3D9aclYs5iKqNQ
 K5YA==
X-Gm-Message-State: AOJu0YwxDdNdHUxgoNj8LB348TNxD1Y6oxsJXFs/1S9LE0DJlNU7ZNA5
 +B/qPsENaM5y/Iut51EoMM193qCLqXwEiaNnfy6Gn+xIAM5T8Qug9zesmbo1vA==
X-Gm-Gg: AZuq6aLwS3quPS55vK2cYJsDqXTbrODb1E3tqbbHHAtQ5yM1pdf5g1KMA2tSLTLrxQZ
 OspoXEdtBO+1XN01JYIlk4MyowO2OZ6LhYqUDnJBOS3aZcH38gplHlp96O1JwzHPpnPwFvmuBAq
 k19BjGV836vx4lzm9OTg8MnjRuNOMh1sc1kYC54yh7sf5EyQ6QE2ge/o6roXrqPeb6703SUEjVK
 T1V6hAG4s4WNZkVhQlJmEA/SLGvABLi/zj8gi0Gp1nS4jyX3j7KTziPB4bpxvvSF9TiugKvqAGe
 voD7l+ljSnkzKtCCZMaE/9NliC09EiLE4RJrPtdELMkSwqSEOz8aiQ/+b5VvOUbvI40id9VU1gc
 UluLzzIq6Wuo1pwYmGFbpHwEWbqmPygmvE33YfmhdM93lnwTYVGLZO8goU7rBt+aDopqsD/vB6p
 1b
X-Received: by 2002:a05:651c:989:b0:37c:d689:7e1c with SMTP id
 38308e7fff4ca-386b51030ecmr39670211fa.23.1770661032813; 
 Mon, 09 Feb 2026 10:17:12 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b624d4afsm27446681fa.17.2026.02.09.10.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:17:12 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/2] video: ltl106hl02: adjust power supply name
Date: Mon,  9 Feb 2026 20:17:02 +0200
Message-ID: <20260209181702.33190-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209181702.33190-1-clamor95@gmail.com>
References: <20260209181702.33190-1-clamor95@gmail.com>
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

Rename vdd-supply to power-supply according to the latest schema.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/samsung-ltl106hl02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/samsung-ltl106hl02.c b/drivers/video/samsung-ltl106hl02.c
index 1efc9fca610..97881a1524e 100644
--- a/drivers/video/samsung-ltl106hl02.c
+++ b/drivers/video/samsung-ltl106hl02.c
@@ -93,9 +93,9 @@ static int samsung_ltl106hl02_of_to_plat(struct udevice *dev)
 	}
 
 	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
-					   "vdd-supply", &priv->vdd);
+					   "power-supply", &priv->vdd);
 	if (ret)
-		log_debug("%s: cannot get vdd-supply: error %d\n",
+		log_debug("%s: cannot get power-supply: error %d\n",
 			  __func__, ret);
 
 	ret = gpio_request_by_name(dev, "reset-gpios", 0,
-- 
2.51.0

