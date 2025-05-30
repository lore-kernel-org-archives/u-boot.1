Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3766C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 21:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0FBF83423;
	Fri, 30 May 2025 23:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ajLMp4OU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A695682C38; Fri, 30 May 2025 23:23:12 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5677082C79
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 23:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso1882694b3a.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748640189; x=1749244989;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLsFYPH2khHUqePmW+Ge2L46nZ/PjuntPgRWN8z55Ow=;
 b=ajLMp4OUeteGw2jv4b/GmrdBT6DWOZpMSgNjFCWnSw/+Q1AuKBESWd9dfBu5ZytCfw
 aqjOHJbNV5vF6DpcQ1Cl4vx1Hf7t66cNbky7qybYNZ6/H8mtohCTVDb99HZRbuT93WpV
 VJQMtSS5KQFf+I3zchEnEHscdg5Pbyg+8dfTbNnjlKD2/y3vPmnNNb1HP1C6o9wXLt7V
 A3577oDptcn/1PGTE07g1HAY6f2lf3i3VE4xF2IbFXTbQbmIn6zjLM791RvD67gx/me+
 p9eOBLA7QzaOs1c58fFtc31HuBmuGHrpFJr4xmJmUUUpc/AiGtDFcDDNrb58Y7GnWyNS
 hqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748640189; x=1749244989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLsFYPH2khHUqePmW+Ge2L46nZ/PjuntPgRWN8z55Ow=;
 b=Zk/mgHbAgJKvWMC2GousCmsLJywyRR1ZVGyCLQKAmIHjadT1Atidyv8YIGsZZGOgyT
 QoGyW7P43mYJ96xo67OqbEZuE1KmQgG6pYnpQlJQc2/uEwPyIJJFrh9AZ/v/JYCKubhT
 S6d3IVFbXKmhOse/jskctKRntAO0ZaZreW97KQcJb4QKRQ6j5HfJxh+WK+RtCox4HC+9
 C7n1CFr8qBABaEbYWuKxnvL9AyMBMuf/49xT5pkgultLxsU8ve7PzTvV0cSawmSKGgGC
 DQlKlWOcn50Uyxa4b6M1PrLCKA9uE2iaFPAv2wUYxYhpDW1hU0gHHx8ETydoQqwgZJky
 +i1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4DaW4gbrAhMVOZ7snLpU3bWWmwM2+O0/4iZOKDUSxtgfvNfh04l1AQF7rW+kkXCWix870ORw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1TS8tV+sEH2jUVWQZUU4Btbbyi7iDgdWdrO9wytx+O+61wJ1j
 wynGEj3LoVRpaBrNJJ8NEY/cCZD4c4wYxkvkLzX5iahVOF1gVXGR/bMLAkIy/kUaWFc=
X-Gm-Gg: ASbGnctyJ9l/0UQd0eioHaJ5SU/QGRoPDPfSQVQ0R7dUE7FzzH4i66Hfx2WFAuYHMRH
 shBqDGYkwWgubtVtUaRlOoxtEpv7VkxyWP2GqjlDwg/dDYO+ehbIl++cL92gNUrc+51JoZAEcY/
 B++VM3nVszzxhNwvoQD7/6dgBb16CeZaPynaqSWwl1vQBeJI5gSmh8YpK6bn7gqi2zLL47K8oaQ
 BKcLs0bI7z0hWR41/oL3KnvLl5q4V8xPRUskPoydKcVMp7vbL/zQiyJM7LKN6EexHJgIVouv/n9
 8AnFCNNUc+CyMCSmHbPhENwO6NRSDzoKTy6JNDkg4afW/Ys3MYoKqafPVLa1L3sGco8FWn70JV1
 B00ZxPPtAryTlZ2sY9345V4RgXcrEYh+K0KE=
X-Google-Smtp-Source: AGHT+IGrLpdY84/PdRjtJsJyyKYcnXriJqRlZ8qlxpFnBQLPztru8DpbYcoG6/79lO3orLVoL703aA==
X-Received: by 2002:a05:6a00:1304:b0:736:4d05:2e2e with SMTP id
 d2e1a72fcca58-747c1a83646mr4601147b3a.6.1748640188834; 
 Fri, 30 May 2025 14:23:08 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affadf7bsm3594039b3a.108.2025.05.30.14.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 14:23:08 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/3] pwm: ti: am33xx: Fix build warnings in dev_dbg()
Date: Fri, 30 May 2025 14:22:31 -0700
Message-Id: <20250530212232.1686613-3-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530212232.1686613-1-sbellary@baylibre.com>
References: <20250530212232.1686613-1-sbellary@baylibre.com>
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

If CONFIG_PWM_TI_EHRPWM is enabled, it throws the build warning in
dev_dbg() due to incorrect format specifier as,

"warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but
argument 4 has type ‘fdt_addr_t’ {aka ‘unsigned int’}".

Fix this with the correct format specifier.

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 drivers/pwm/pwm-ti-ehrpwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-ti-ehrpwm.c b/drivers/pwm/pwm-ti-ehrpwm.c
index 563109ef0f80..135ea3b43212 100644
--- a/drivers/pwm/pwm-ti-ehrpwm.c
+++ b/drivers/pwm/pwm-ti-ehrpwm.c
@@ -399,7 +399,7 @@ static int ti_ehrpwm_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "regs=0x%08lx\n", priv->regs);
+	dev_dbg(dev, "regs=0x%08x\n", priv->regs);
 	return 0;
 }
 
-- 
2.34.1

