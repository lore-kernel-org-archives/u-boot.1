Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF038C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7009F81E6C;
	Mon, 31 Mar 2025 14:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KrWj8eri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15B908144A; Mon, 31 Mar 2025 14:23:51 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EBB581ECA
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so29826555e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743423828; x=1744028628; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CJneWbuZmLBZW2m1oElNfYskRR5fwWXGKOiA6LQp6V0=;
 b=KrWj8eria89Ve/ygF5v6Pk2Mk6z9LB99O1XconO6lwiam3lZKN1BpAr9bL4KmUHH7W
 c6ROnM19tES4kx0TxAmN6kRwQ3C63HiRo/O2Ob7klC64U7VUjjYswpTLyk2EdAbF7ujR
 W4HryFIN2YpBo19Z+v+rese59Bg624VGl+n0A2IrJ0KFqtoo6SWacLxhgyMA5JaPTCbU
 RY8ci/6xeJ8V2aSZN1WHLJqpuz0s40ujLvn/2KDZ14pBaQIV1mdZN/U0Y82ffV6pQy7u
 cBV7t3bI47eG2SLmPRsQWXB+Y0mcCClsRqSG+oqzs/2OYT3k1ZHWLo+IqnIzALx6UvgI
 9/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743423828; x=1744028628;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJneWbuZmLBZW2m1oElNfYskRR5fwWXGKOiA6LQp6V0=;
 b=DKgd/ToZ0MNnluTS8a80z7PxID96/MKfLbb7izmGXz/zYaElav3h/f7uFY9lzb/BXf
 t06vd2T08tHjN7d2auTU+oqXieopTt97CB1fC0QDN1b0BRVT3sfDyB6U0+y/mTBXQmjG
 XjCZzdMw/jtOxNL8DMC0Zs7DKcoCnvRpbEoKncrtEejjNjkGlVTsQyXhZEgVy43g5fqX
 4Az4G0ZibHxcGcNYc0Dyo42WtCR6fKJlH+MH3K+Y50y118fAvRFocgfutrjdKLNuC8rE
 TtXcRIUxTa2xUT21nvUoswFA5ylIbTOLZoBRQB9EPmmPY0lOKlCFr1ClOTtRkpoCInlJ
 dlsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeAa3UsJXtSIy4czfE1RimyjqUuTZLIW3pwCVEzKSM/Df9aN891S/MNVbMvvsC+J87PDdjLss=@lists.denx.de
X-Gm-Message-State: AOJu0Yzbiyt6LJ+G/lLojtgZKDqD+kh8xBuPMSvlozuH9lT11GtXo7DM
 USMdUEDhjsEMLBjvfVsvo+X9gCOL6fo3HdipS+ln7vYACWaf6azqu8YOZAD+mXI=
X-Gm-Gg: ASbGncusJd9Eq7UnsM7L47cTjGLykndzvg//uFULYXudh0Lxkbm7YvD72B+uKuKqFBA
 3JD6zeqD/jKzIWfrMhXbHBwlrtTW5VkczLo2c1AFxYie+mf3asfp5n1GV63CF1m4DNPolqD2Lt3
 AgFqKUD32jC38YPhn/FUeTyJYUHmJWvGQjy9C4s9yduuaMitQAdXSL5i9ItFwJj/sWS4KE6nIiA
 FqngL99NlVyLCXeBmNe2J7KQheaLyeasBqZX1DEO+DV6tSeXNHZBB8j4Efgria6x3vJ/dQDNhCK
 3B1aE7JNjwnD61RhZcauB3wbAhcKG1HFqlp+JON3Gris5YDrVVm9pKtWLXmxPDDlJqTUpYwn2M0
 HmfnEvSs9H0G9
X-Google-Smtp-Source: AGHT+IFLBTSv807k7E/1YOBg6Rdhb6OrI/r+jC9Vjb5EB3BIw9CceCn8FKDQK9sHFx7jlsC4H/ScSA==
X-Received: by 2002:a05:6000:22c8:b0:391:481a:5e75 with SMTP id
 ffacd0b85a97d-39c120dee91mr6238302f8f.22.1743423828445; 
 Mon, 31 Mar 2025 05:23:48 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b60a9ddsm11315562f8f.0.2025.03.31.05.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:23:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 31 Mar 2025 14:23:20 +0200
Subject: [PATCH v4 3/6] bootretry: check for bootretry variable changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-qcom-phones-v4-3-f52e57d3b8c6@linaro.org>
References: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
In-Reply-To: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=jwuZYBuJJ+ldxaKDFAWY5XTPAL8LwWLq3I/2ci0eJHc=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn6olNDItYx8ayWIVRlSHfF792o8gGQqh4QTLpM
 nAxlIu5+k2JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+qJTQAKCRAFgzErGV9k
 ttjeD/4pjcnL6ArvpghLbsXvkTaiTInG3EK9CJawZGZfhZxA3fGs9PfVOm0MmVZlF8t9qaSc+ew
 UxNL4eHArlbZKYVgU9jWhvnVpCvebPtIdCDuJ2i+qJt830SHO39qSt46h9KcXpktBp7fBAl5JUE
 35xeyUNr/kOGn65ZjRICEbFVYnc4y05cmWof/i3lAc8T/LcaCZugRIZ3eGyMawtvEFyFB06bSqN
 w/QlTDMS6fWIPXqZRGEfmNy3BLhmVwYAVyYyarsmSMgDlQ5QMnlbxphMgY1pyWt6p80kIOVbvC/
 4+5BcrCJsLdrpvT2FyFWR4IEPPqEJzdqLW5t3Kr/yhC2g8gj0XK2RUJFFTUBhB2JVQ9EdXOxAZO
 U3Xxva+KPkI5vGWi1uuTcsHBCkF6FPTEAOfVWgw36NwXWN6P/IiE8UBRC/ahCRf/a1T7l+Yvs7J
 OtQB6QHhE2bJplhvWqq43A8ghHMCjAE4LBjZQbUOZCG4OTHmuEpMNB2KrVp03x76TpshWAX1jrd
 AcTBpPJgIBlypNUDI9Om3BYCygRafH9qEAbjdwqwsNToOnaoe8KSjoZoif6J5hjgTifDorubxz3
 JLxmLpYg9CgbCfndskMy8TJUJ2KUpSekYPY6ptBFFlGrxo9QnMWpVmywlLmIj/gJCaBpqrSGmCi
 OLX2l9GL+XTstkw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

To enable more complex sequencing of the bootmenu, autoboot, and
bootretry, handle changes to the bootretry variable between tries. This
makes it possible to turn bootretry off (e.g. to drop to a shell) and
then back on again.

This makes it possible to have a persistent bootmenu (the only way to
navigate U-Boot on devices like smartphones which lack a physical
keyboard) by having bootcmd be defined to launch the bootmenu. This
allows for menu options like enabling USB mass storage gadget to return
back to the boot menu once the gadget is shut down.

Reviewed-by: Tom Rini <trini@konsulko.com>
Tested-by: Danila Tikhonov <danila@jiaxyga.com> # google-sunfish
Tested-by: Jens Reidel <adrian@mainlining.org> # xiaomi-davinci
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 boot/bootretry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootretry.c b/boot/bootretry.c
index 587b2de7d6b08db07e1dea512a834cb5590c2d12..a60767eaa2ee51970e4695e487ce5651575079ba 100644
--- a/boot/bootretry.c
+++ b/boot/bootretry.c
@@ -36,8 +36,10 @@ void bootretry_init_cmd_timeout(void)
  * reset command line timeout to retry_time seconds
  */
 void bootretry_reset_cmd_timeout(void)
 {
+	/* Parse changes to bootretry */
+	bootretry_init_cmd_timeout();
 	endtime = endtick(retry_time);
 }
 
 int bootretry_tstc_timeout(void)

-- 
2.49.0

