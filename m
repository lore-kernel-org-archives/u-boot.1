Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAAFC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 22:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81E8C80EB7;
	Thu,  6 Feb 2025 23:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cGcJ96a4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E36080EEF; Thu,  6 Feb 2025 23:01:32 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665AF80E94
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 23:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54411e3c610so959477e87.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 14:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738879289; x=1739484089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lWqshTVEAMInfGdpGHOM+i2FUIvd2DYlTUJpAu5mW/c=;
 b=cGcJ96a4RCzpu3QzBFMK3cUTwCw1Q2jkgp4R7zGIi9MwFj2lnn9X+yGcUDIyfWM9r7
 L2P3AUAjhft9LQJEzoE5GepmH2U2iinHSh4Lm09Si8S4vK3DYIRUOYeqprrUugInCdr8
 7DaZDV6UKpzUq/r+oiEkzljhGCzkb/EzOmLBNiKFu/qRxK1i6ftt65l+b2C1uPKXm8hX
 5o5wm5yCjw4HYgWUOc77YYK/TC8OV53wxM4EimLvdpKQN4hfql/kI0XrBV51Hl1XjvLc
 MIpWATZE/Bc3Zcbx5znNQiXGvOmBM7FCgv5yCMqNRoEPUQMsVb3q2pa7gVt0bMb213fv
 RcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879289; x=1739484089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lWqshTVEAMInfGdpGHOM+i2FUIvd2DYlTUJpAu5mW/c=;
 b=WUFMpIzpys/yMvDs29D8AP3TZ8Ue3TlZP6NlXCDRJjWepfc4CxLtNP4GiJgxf87r5q
 LUlm8GuR5EZK9lc2dRM5VohHQUqOHuBBCSkVYu3B51ifZw1UbZT4FeZGVIpBkp5alUel
 yco1SNhMAPUwB9CX/NNibZF4Vn2bSRI8qLRyXDRRR97plj3jIlGMZP2+OoxmB184W76n
 8EnUzLGXgphRLC2LP1/QEozfNgcQnkMLzzRLA23OUPf4Zd7bKsXUmicWOBl75dUbddab
 AZD3ebiGDE1N/ytzYjAgden6AAVOzspuObs7+Pz95fUNNUheqUro1Xh5kh8GN1y5rIkp
 xjPA==
X-Gm-Message-State: AOJu0YyMNkOmLrbAdS6lqD7h/WG5PHXQ1kQiWe6T3kTS3ealKF7vRsvt
 AuqlGagXl+vXbo0mHs/DozexRzMLHtPUNMJfOYiGRcbyuUVZYdR6SKMG4WkmGOU=
X-Gm-Gg: ASbGncuX4I9mEVFfdDG+uoHlpCMHFSvJxU/ZFhP+LYmDB2QQe3e+NxZXzU4GeFPFIh6
 H25qU3H3J6D/+XxbkwezP/MfZtZWFSw+Ze9RybuXYOJH38II5Ju7ZS89r9ZMS7G8SCh74kbDEgb
 7iw/NwR+WZIXby+nj+j4wP/w/49q9X1lHYguUczENkyWPbP2S78AwXFTAtGQLIUiFCv0OvP7SG1
 +Y/eHI8hpw2IVoylMvuIjuDWGXwyljt3z3SWraaTOxh74pzoBTPuckpkE8BlQJbu28LQtxAPPMf
 9SL5eYtubsMXopb1P5HZdWGzhH09qI4u4pGxnA==
X-Google-Smtp-Source: AGHT+IFiCxfhLr4hsnwp9XaJJ5HZjdgJ/aA7hz0Uaz+bBae7PgW6I2+vcizXaH/9Zh31iOx0A3NDCA==
X-Received: by 2002:a05:6512:b05:b0:540:3566:5760 with SMTP id
 2adb3069b0e04-54414ae5282mr132125e87.35.1738879289068; 
 Thu, 06 Feb 2025 14:01:29 -0800 (PST)
Received: from astra-student.rasu.local ([178.66.158.78])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54410604060sm241877e87.223.2025.02.06.14.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 14:01:27 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] common: fix: add NULL checks for xrealloc in make_string
Date: Fri,  7 Feb 2025 01:01:23 +0300
Message-Id: <20250206220123.355626-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
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

- Check return value of xrealloc for NULL.
- Free allocated memory and return NULL if xrealloc fails.
- Prevent NULL pointer dereference in strlen and strcat.

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 common/cli_hush.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index a6a8edce1f..701ceaf080 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -3626,7 +3626,13 @@ static char *make_string(char **inp, int *nonnull)
 		noeval = 1;
 	for (n = 0; inp[n]; n++) {
 		p = insert_var_value_sub(inp[n], noeval);
-		str = xrealloc(str, (len + strlen(p) + (2 * nonnull[n])));
+		char *new_str = xrealloc(str, (len + strlen(p) + (2 * nonnull[n])));
+		if (!new_str) {
+			free(str);  
+			if (p != inp[n]) free(p);  
+			return NULL;  
+		}
+		str = new_str;
 		if (n) {
 			strcat(str, " ");
 		} else {
-- 
2.30.2

