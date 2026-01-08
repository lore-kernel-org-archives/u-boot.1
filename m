Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92900D1D461
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB908425F;
	Thu,  8 Jan 2026 15:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fxggGUTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7BFC841B1; Thu,  8 Jan 2026 15:42:48 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FAC7841CD
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso19416785e9.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767883365; x=1768488165;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kLYe5jmAKC6pR8zEAgfsS6EHK0Qk6hVUlrVarCU79xE=;
 b=fxggGUThQ3FUEhkjY1XmJqKH2o8SJdW82g0KJ3cCFGcJjJqKekxRDpoue0NoxrFZjQ
 DuXWYxlL+0S9dnC0cWtjW5fypi/9/MpB0NCJmwKu+dL4qUdIwztGWqrYrDNSyc20vv+q
 +k72b2CmFC45uT/mqKb5NqmaXd4O+sQVsY7lVmjp8s8pwG5biCNLqSt4/qeXNbn0YTEO
 1OB336g69kpj6UF1j/R/6jWjmRTpbV/8v2/sfZiCeHHafVlFB9OBsOpU5IC/jP0UuElz
 5sPIAzv41++F5In3kbj2TD2N27e2NHL5oFRW4KDk76kf2433ONKk1qqHbFiOsof2vHKy
 kbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767883365; x=1768488165;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kLYe5jmAKC6pR8zEAgfsS6EHK0Qk6hVUlrVarCU79xE=;
 b=We+nH95MFMSZXj/6/ts/D9ClWeSm7cb+3dzTkYuYihEXDWnhhn3Mv6e5aNSwnGxgpZ
 FJK/XMGCBx19ax6PMsKPJfF310pIgNY6Ng6JiScvqpRLjCNBqlMI/LChrtlIrM3IiVfG
 QV21TegYpk87qW8zZrEb88v+qBuSWvZAlb+Jag/Wt+8XqAIpG15bEXqlc08Nbrh+MP++
 /94+DXU15wueLETejQeLz5nAy42ZEI4KoI2aeEz0g0z8Negggf/7LA+SMuYRnA5Qcl98
 EP+yZIsfJFwlo6Sttt6CX6EJ35K537WI8X1a/kBjgZwxw4e7zjJOgZ4VTJOp1zBiGJoU
 yfrQ==
X-Gm-Message-State: AOJu0YxErlbaUnGy1jotNR1rs8TFPFZxPIAwKwqGl8WIgiM2rjCEm28O
 UE8MKE7bVJHIDRH4vKVyzfLk5PLSwKrOYuZEzbYmQJXsFMrLPBgP7OhG28DCXfvFOkk=
X-Gm-Gg: AY/fxX4Fu2uk0l1vsK/jnr/c0N3uK1d5+i99E32LNkx4yFpV7nq9CRyWv6RZjvBVh/I
 Bar04UN5MSwNQQMAsoAs5YNbdz+WVJp+HECQNKvGOsA3FR2gUptEVF2huyYokLaGnvSXq79xCRU
 BsJMRT3za5Dat5C3r3jCuqBxU8Qq/CGIyVi8bmxCLM2OZ9SZ/3+27An8rdPw6t/WU28k/1Ftszc
 wuoQQKhv0CwzQaY1I4zX4MGC6Kl/Wn70sYuuTa1WFGQkktO7sBHRkuQBPExzK/Aa5INu3Jij7R2
 1W+7NZlY8oVdJ8De7ryXCtfNJQotCenTb1AH4uUsV9qodp9mCy5kD1c1afrOoV09ji38smhSoKN
 bJmGy75saq3leYARsTVw3f7bBbPmRGCXxRJynxeQ+N+oHcd0drwETCm8i6hICmW/Es8obFUFrnK
 WKjbuK8XfcW06YzMWhyevTFc3wX342mK+3NTGO534mVxmDy1RqeiMdO6nlEMsnuX2wlssL20/r4
 iQppON4n5uchjZAZFw=
X-Google-Smtp-Source: AGHT+IFEkNAO57v2zh0qXrUucNN54v2s6Wvr0LbJcmht1UmNPdSLkQzbWTXYlJrSm/o/ALq+gSIomg==
X-Received: by 2002:a05:6000:208a:b0:431:67d:53b3 with SMTP id
 ffacd0b85a97d-432c376110emr8205665f8f.43.1767883365533; 
 Thu, 08 Jan 2026 06:42:45 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16d2sm17431760f8f.13.2026.01.08.06.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:42:44 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 08 Jan 2026 15:42:47 +0100
Subject: [PATCH v2 1/3] power: regulator: common: remove unnecessary debug
 trace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-power-regulator-fix-compilation-v2-1-b00cb3268059@baylibre.com>
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
In-Reply-To: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 David Lechner <dlechner@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
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

Drop the ftrace like debug() that checkpatch --strict complains about:

  WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/regulator/regulator_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index 685d8735fa5c9a6f98cb6154cd13afcabaeab1ac..ce3d80670de045dde7e263c5301bccd744abd2f5 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -98,7 +98,6 @@ int regulator_common_set_enable(const struct udevice *dev,
 
 	if (enable && plat->startup_delay_us)
 		udelay(plat->startup_delay_us);
-	debug("%s: done\n", __func__);
 
 	if (!enable && plat->off_on_delay_us)
 		udelay(plat->off_on_delay_us);

-- 
2.50.1

