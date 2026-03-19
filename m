Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7331091929
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 22:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE17583FD9;
	Thu, 19 Mar 2026 23:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MYtSGAdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA60483FDE; Thu, 19 Mar 2026 23:30:17 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5921983D71
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 23:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4645dde00a7so2115752b6e.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 15:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773959414; x=1774564214;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iA5E+xLdwAhqI0ZbRewNemVToGD67rEr5GTPNu+6RAw=;
 b=MYtSGAdmrqkUrdxJdhK6zEg5b7K57TgN0FzQHsKvoQK7/3oQyyEzUtQLeUn7uRgeeu
 XVq2MDOdg/tTrx/HHSEVe2fj3TH2mE4d6Vsz+O6wOWQWgAGU+NjUp9f87zltbE5QRxJ1
 CfWjlohYs8JV0o5SXmqsr6IWJe3TyMtpqLFpPLspGrKyYxAEco52SEVmkEO8h5KRgkLg
 sA+v4+O+LFjGpy1iR5PrLo672fmcIOYRLGIcv+j5Wc0Z8+w4j806OyL1uq1dte1KsC4+
 h0+9m3VcUbDY7a+42Id8LjAsGQ3BFpQQCAPyxGdgOwwIeq6eeRF1+Z/TqLZsl2avi3gZ
 zDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773959414; x=1774564214;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iA5E+xLdwAhqI0ZbRewNemVToGD67rEr5GTPNu+6RAw=;
 b=H+lJABh2i92OTrsl3NSJHrLsElPuyuD/qIB23anRE/6IRxhoSAlcxiIjeQSEpP1tRs
 8nW5u5pKPbQBlGq1S8E/Ql/Wt1FrAs+qN/tAsgjNfh8lNGK0BzHsG5owNgk4F4Gw0H9x
 MQD1Jvw0fea7QhlaBzTR/s/Zn+EOj5cz+WZP5Tajxo6UeMwE3mFowdATd8uLhGLjLr0K
 QwjS4iqmQ0nQ5RDaI/OfwVxkAnvm/zrPy9io5gSViyiOH6EEiUIHut3dw9mAXTZRjfyh
 U7DUcsrqpGBusazwJncsTszMRsMDgCq0ft1edkCsVURXB4I/PG4a/nwZ0W6LqnYVw4jH
 qHMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCjF1jCA35WpcZvgOw0GO62ZT8ygGScwTfcdMORcF3qMaB6oyyVhI00TTTNReGT7OOBQt5B0U=@lists.denx.de
X-Gm-Message-State: AOJu0Yyhrz8IwWl/ITu5UqmwyzcbXLnmmfh7Srcof+1ovzw761rHXiSs
 jFCOKml13NLNHg9xsJIWOAjnOJU+cSbYsowEVL3nuXx4jGX1OgWg8eCSfgKdH8WBTxk=
X-Gm-Gg: ATEYQzxCupl2W3iu+L50CzphHzf9tW1LcbhkKpT97TlnFl9bAkjBJ3CtyWmDMPmDo9/
 UdAGkUGe4xQFKihwSxVyLw0tpKY907XfSqhBjkFuayiigSwnXtFOTiay2Mb83m6yrMc+MkKWWMe
 fZB3nq49/rm9q7/dIaMMzVdAxJ9Lo8dI55jq7qHS/nBRZKvl4hmO9Fu+SrXNk6B0WrXlXS5JpQb
 GSSG6YTCwKp3qAHxdwCbHHJ6jCQQAyI1aDTriuZbEvFGXP+/SzH+Oh/Kh6f4VPKWPFufra42JEy
 mOi0yqUDL4pBMa1znGXCEux+/ItpRWigeBFE71p/CKcml2QB/K5JpKqEZY4FJ8YiFGx3PfjKSlB
 8JsO4vjiwQFtUTcHkA+vhLa6bEAj3E1EXzifTyesxYPEMuKiUWiLRmH5UoUTRwdwhT5qiJRk1hU
 F4k29NcXjOLgYI53AB6VHxNFiTuuA=
X-Received: by 2002:a05:6820:1b0b:b0:67c:1d62:38d with SMTP id
 006d021491bc7-67c23636e78mr533637eaf.29.1773959413736; 
 Thu, 19 Mar 2026 15:30:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6a3c:6fc:3be2:208d])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252ac65fsm208937eaf.2.2026.03.19.15.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 15:30:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 17:30:04 -0500
Subject: [PATCH] dm: regulator: fix missing quote in error message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-regulator-fix-missing-quote-v1-1-839144d65db3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QrCMAxA0V8ZeTawTS3WXxEf4hprRFtNWhHG/
 t2qjwcudwZjFTbYdzMov8Qkp4Zh1cF0oRQZJTTD2I+uXw8elWO9UcmKZ3njXcwkRXzWXBiD82G
 7IedpR9AOD+UW/e6H499WT1eeyncJy/IBj8CYqn8AAAA=
X-Change-ID: 20260319-regulator-fix-missing-quote-d69d54a69a8a
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=FKzOulcFa2sI83whLcvhUBkNZk9a5I9dQZkeNVVs0dQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvHjtQiWLQRABFtJBAVNX7ZgsgU74eDOtVs5sA
 ObM32aQ2fKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabx47RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aj4sH/2wkNlWoyRvGvjZIcHgzUya95m498K+X/xqf0wo
 jWCy9GhMwhBGFTUWzaSzBI99kf3v9kp2z5lF8q9YK+Cfild1yyqeDz+f7HqtkyyTVsHe7p3ugg+
 yQmzJa1GwHSBOo1Yjl6LbCN2oKTIs7Ug0pqozsR71aZkiVhrv/cUspFTGxNLlknjs3xdKkZJwCA
 2X5WHO3Ai0eg+7AObqRugE4ko1dOWn0khyLJ4NNm36DTft7OARrRYBP6afPfGUFLSsEWtuE7IgP
 x2hP8RTEgGf9d/T5AMNgD9L1KHJBfW5NmVa1Yp+ovsnQy7zDuwRfQeppWmbnLUVUGaJplMQ4io6
 jP9A=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Fix a missing closing quote in the error message when a regulator name
is not unique.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/regulator/regulator-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 94c52cf555b..1c7f75a9338 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -449,7 +449,7 @@ static int regulator_post_bind(struct udevice *dev)
 	}
 
 	if (!regulator_name_is_unique(dev, uc_pdata->name)) {
-		dev_err(dev, "'%s' has nonunique value: '%s\n",
+		dev_err(dev, "'%s' has nonunique value: '%s'\n",
 			property, uc_pdata->name);
 		return -EINVAL;
 	}

---
base-commit: eb00c710508d09b2a3b9aca75dd18280f1304703
change-id: 20260319-regulator-fix-missing-quote-d69d54a69a8a

Best regards,
--  
David Lechner <dlechner@baylibre.com>

