Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE20107637D
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93C59840AB;
	Wed,  1 Apr 2026 16:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZkMtO+d+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E8C88408D; Wed,  1 Apr 2026 16:15:30 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F1D184010
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-483487335c2so74704745e9.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052926; x=1775657726; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CQ+gm0zG3GJxN3n1mzflNTKMTeIaXJtAS2Va848P6kE=;
 b=ZkMtO+d+98+1BZ0ac/FJqypi21K5UN92uuuRNa9qq1nhbYiRof79uCpCvrSJ+mL8LH
 0Gq7Sqzg7LQRoRRMbdqmdNY9aHKrEZf4OsDpUF0ns8ZxLmroEHjK/4ufM6TnJMtfGMdC
 v2ULkhKXx4gTZJG+VKbl/gJaMzMqUOi2vBTYGr4dz/rnkZq4f6ZWiFXhys7NX1vP5WqM
 R179OMi7X3kZ6285uTZA/N+d9FOWEu7SPrn+d6oL11HX1tqm16/TWmXS32jCiVc1EZHJ
 QGu8wlb59Ut+rZXd2kbGhZwMSZRlZyCNKiVqGzYkNjRhA8wSBOGyc1Z1NTvajdFT8wqv
 HWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052926; x=1775657726;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CQ+gm0zG3GJxN3n1mzflNTKMTeIaXJtAS2Va848P6kE=;
 b=kY45RV63g7FX+QooSzhS+AqmHOoFunRG24ybSiyR4ZScRrlBMzr3jq1K+zGPKipSUd
 bSz7afnUWduH91pc9FmS3xphxI8uyXe08t8On7lML2iD6jFwm0Z1iO3s2N7X9QY4orKQ
 jl94arhX15ALLb917yxMSnAemybZiwKoce/uvcGyrhy25ZbsahCMQWFTQUXX6wiQObOA
 +tW9gmAEVfan8DNrMnthWI4zO7ReIc4+StlXKFq4yHPlWSvRiUUMlhZwRW5RIiQ7/GdA
 v+LUQW325FSK9L7DKAYx5h1dNjd5+colLylBM7dSLGTTmIapf2bS9815kRWGGYvTLOIn
 K7nA==
X-Gm-Message-State: AOJu0YyT2MOWdFGOsqk3GKtT84ZL+/KpbOmDL6R04yvTnnM9ouSXXyac
 U6EXZuvX0P0bMgKH8UzwBy8DO0EZ8NWH759fgU7mVfWuzkr6e4kS+AP5BaL+IykcIiE=
X-Gm-Gg: ATEYQzxm7M9cs/FdsyhvQEBmf65fnlfB7WwRrhjqeoo7wVwBAIWy5IVE3SQv3aTYuYS
 jFDvQU0bzPqKXChJMIsVqYVP1ABaPWrzSie2DDPvoEsERxkGZwgrZLpLw/Y3y4O7w6eYBJ9HJr0
 EuqE+lr5YJCUZ5eO8eNT/gsy8GEdEB1YB5h+sOLtUKC4gqvo+iI513ZqDgH30vYVxJasrwB2DfX
 qBaw9zZ/zaJwyl/ea8FNv/jS/PJEmYPZNnFS5kgzemy6EzTvhuVBGEi6dP92Lj9HTqgXs7cY8lv
 cldLID/U2bSjMMiJvO/GTTq8r4i67bLbA9r2h5vFi5YiHl0QhZyTNW/DTv5YwASYMAshU9bskaz
 Gar2vnT+iiWzVWlFT5INhquR9m5TKU6mX1WDw3/mOllQVL1N9KhsEa6YAwOfIcVfH2/L/vzjEJX
 5rwey47gEoUw1AWnnda/0RPUwZLky53ZjWyHojRiTwMVyK0xKrASuFtD8k8Ed5Ze0A3Tzo
X-Received: by 2002:a05:600c:8718:b0:487:1c2:6a4f with SMTP id
 5b1f17b1804b1-488835c0534mr71519115e9.31.1775052926364; 
 Wed, 01 Apr 2026 07:15:26 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:25 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:15:18 +0200
Subject: [PATCH v2 02/11] common: add an option to skip DM pre-relocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-compat-v2-2-414d5b7f040b@linaro.org>
References: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
In-Reply-To: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=BTSZ88kTLdi5mw8IXVoDVatMv6+okA8GUUaE3nA3lEw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzGpX6IuE3OIVPuO3sCuacUv830OrME6+s2Tf2NT5xd
 y9VvHqzo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEyEo4ThD2fft3efT+01yDZv
 qwx9J3mid2ne21UH1Eq5t/i+lbhztJfhnyGX68PCp+/1F7rq7WLMFP646NDaFRLJZz3ub96nuel
 KTR0A
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

For some platforms like Qualcomm, it isn't necessary to perform a full
DM init and scan prior to relocation, it's also particularly slow since
it runs with dcache disabled and prior to building the livetree.

The only device which needs to be probed pre-reloc is the serial
port (otherwise U-Boot will panic), however this can be found through
/chosen/stdout-path.

Therefore we can avoid scanning the entire FDT and binding devices,
instead just binding the serial port and clock driver on-demand.

This decreases the total time from power on to reaching the interactive
U-Boot shell be about 50% (from ~2.8s to 1.8s).

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 Kconfig          | 12 ++++++++++++
 common/board_f.c | 11 ++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index ce25ea24a60f..2f7677f47f16 100644
--- a/Kconfig
+++ b/Kconfig
@@ -473,8 +473,20 @@ config SKIP_RELOCATE
 	help
 	  Skips relocation of U-Boot allowing for systems that have extremely
 	  limited RAM to run U-Boot.
 
+config SKIP_EARLY_DM
+	bool "Skips initialising device model pre-relocation"
+	help
+	  Enable this option to skip scanning and probing devices prior to
+	  U-Boot relocation (during board_f). Unless console support is disabled
+	  a serial port is still required, however this can be found through
+	  /chosen/stdout-path in FDT. If the serial port relies on other devices
+	  like clocks these will also be bound and probed on demand.
+
+	  This can speed up time to interactive console by about 50%, particularly
+	  when combined with OF_LIVE.
+
 endif # EXPERT
 
 config PHYS_64BIT
 	bool "64bit physical address support"
diff --git a/common/board_f.c b/common/board_f.c
index df2b0dc899bf..2713438cc18f 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -813,9 +813,18 @@ static int initf_dm(void)
 	if (!CONFIG_IS_ENABLED(SYS_MALLOC_F))
 		return 0;
 
 	bootstage_start(BOOTSTAGE_ID_ACCUM_DM_F, "dm_f");
-	ret = dm_init_and_scan(true);
+
+	/*
+	 * If SKIP_EARLY_DM is set then we just create an empty device
+	 * model, the serial port will still be bound later through
+	 * serial_find_console_or_panic() via /chosen/stdout-path
+	 */
+	if (!CONFIG_IS_ENABLED(SKIP_EARLY_DM))
+		ret = dm_init_and_scan(true);
+	else
+		ret = dm_init(false);
 	if (ret)
 		return ret;
 
 	ret = dm_autoprobe();

-- 
2.51.0

