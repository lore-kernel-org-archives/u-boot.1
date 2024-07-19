Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27E9C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 389E388BD6;
	Fri, 19 Jul 2024 17:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LovoEqy6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0E388BCF; Fri, 19 Jul 2024 17:39:00 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5823788BD6
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so13348885e9.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721403537; x=1722008337;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=szKoElj3LiGC3E/TsrjpbOVIG50cBu/zHMjtEbL8kiE=;
 b=LovoEqy6UfQ8LSvOrR5eQJqPok29/AB0psUUM8umvUnHMufk5p7xk2BOSFlZybP9Nm
 C/rOIV2Uwuy0HNtwmxEQ4t15/zNJwaWn/sK8E4wWY88lujOHsj3VIJ6YdXKVG7yl2qNJ
 EGWdNDLQkgKLs1PkW5YLXHbv9q/AW0RvaD+D8ZQhVI/X8gueBpDqzXBWqLP3eNnr9rl2
 /STvMGVwg4bqMz4DuCJ1E7+vR0RWvwV26daIrcanROHC2PZaJchRu67Qiei5QOiIEcwn
 C5tHXQvJmX9Scijf3H6F2tEbw4qN0oGxITEvdMT0a/OuhF2dC6SGBHBtliu3C7mA+K6l
 l0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721403537; x=1722008337;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=szKoElj3LiGC3E/TsrjpbOVIG50cBu/zHMjtEbL8kiE=;
 b=GCbO+bllhPIJ68nv+v/AJwNrOUK8ZGUBjfJ8B872bp9zKl6aQA6NlFYPiyYBAO5mGh
 T77MoKthgeB+CwSrQISBtLYbXlYgcplb9gTBZzczRM8zYM4FAixCFxBE5m4nJfBdkkkF
 HF+LDZOv+M/T0tZuF27Rn+e/ozmt83NKFpnfLAl1d7pf8xJdh0PPg9ZEI3lcxzedIwbH
 wrhvzy2d0e7yMXveJ8EHMtdIQzRA5bCy39ee2HqxFCLCh+iGZNd2CNz/eHQcYgHjgQKN
 FeliOsiCr+WWUiN/cX/ro/d5QqSEbvboBpFICFWdKzeDJYXxiHRN25VqeXrRXOtognoe
 4b7g==
X-Gm-Message-State: AOJu0YxSIJER7kv3fKNpXU/2WQiKkcCAF5pYEGGWtS93pvxCVyg56XRR
 uLs3vdtWUx3intRERk5SpkT0DdT7UCpnUjjxiUxMo7F/Sk7Aie+tTwX70gZfD3o=
X-Google-Smtp-Source: AGHT+IGFbSI7grCgEn4wZlmbf2js/AoZySRl6AAoiomAcVRa7B/+oOi2ZAxOgTSscnb1S6VG2WOAiw==
X-Received: by 2002:a05:600c:1ca8:b0:426:54c9:dfed with SMTP id
 5b1f17b1804b1-427c371a871mr60502075e9.28.1721403536452; 
 Fri, 19 Jul 2024 08:38:56 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa9b1sm29655085e9.8.2024.07.19.08.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 08:38:55 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 19 Jul 2024 17:38:54 +0200
Subject: [PATCH] env: mmc: Fix env loading with CONFIG_SYS_MMC_ENV_PART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-fix-mmc-env-boot1-v1-1-e32b2037d4d8@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAI2ImmYC/x2MQQqAIBAAvyJ7biHFKPtKdNDcag9paEgQ/T3pO
 DAzD2RKTBlG8UCiwpljqCAbActuw0bIvjKoVum2lwZXvvE4FqRQ0MV4SbSD1053UllloHZnoir
 9z2l+3w/sP7zvYwAAAA==
To: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
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

When CONFIG_SYS_MMC_ENV_PART=2, the environment is loaded from
the USER partition (hwpart=0) instead of from the
BOOT1 partition (hwpart=2).

IS_ENABLED() cannot be used for non-boolean KConfig options.
Its documentation states:

> * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y',
> * 0 otherwise.

So in our case, IS_ENABLED(CONFIG_SYS_MMC_ENV_PART) evaluates to 0.

Because of this, the hwpart variable is never assigned and mmc_offset()
ends up switching back to the USER hwpart (0) instead of BOOT1 (2).

Fix it by using #define instead.

Tested with:

  # have CONFIG_SYS_MMC_ENV_PART=2 in defconfig
  # 1. Erase mmc0boot1
  => mmc dev 0 2
  => mmc erase 0 400
  => mmc read ${loadaddr} 0 400
  => md ${loadaddr} 4
  82000000: 00000000 00000000 00000000 00000000  ................

  # 2. Restore default environment and save to MMC
  => env default -a -f
  => saveenv

  # 3. Read back mmc0boot1 and confirm the env is present
  => mmc read ${loadaddr} 0 400
  => md ${loadaddr} 4
  82000000: 13e0632e 72646461 7469665f 3978303d  .c..addr_fit=0x9

Fixes: 5b4acb0ff79d ("env: mmc: Apply GPT only on eMMC user HW partition")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 env/mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/env/mmc.c b/env/mmc.c
index 776df0786be5..0338aa6c56ad 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -110,8 +110,9 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 	int hwpart = 0;
 	int err;
 
-	if (IS_ENABLED(CONFIG_SYS_MMC_ENV_PART))
-		hwpart = mmc_get_env_part(mmc);
+#if defined(CONFIG_SYS_MMC_ENV_PART)
+	hwpart = mmc_get_env_part(mmc);
+#endif
 
 #if defined(CONFIG_ENV_MMC_PARTITION)
 	str = CONFIG_ENV_MMC_PARTITION;

---
base-commit: 459560000736ac7c9c8b04522789c20fb45ff95a
change-id: 20240719-fix-mmc-env-boot1-a8d4b4512a29

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

