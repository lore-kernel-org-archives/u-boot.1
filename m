Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A4CC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 16:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC2A83FCD;
	Mon,  4 Aug 2025 18:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c2/ZcxT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A5BE83FCA; Mon,  4 Aug 2025 18:57:02 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 359A983FAD
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 18:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so29535905e9.3
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754326620; x=1754931420; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=El/DASkolwd60608KneS5+xlLYv9lfLG4BngQyPLlNU=;
 b=c2/ZcxT5asIR1Ph5T+pUbOZamsmciDh8w1IzQMNmUku6EYLE9RWr31DHNqab/bx7Gs
 yFNLUIjmR6eSou2dIOSZe86LAmXxcxFWlew9OCn8ixV5fsNl6vjrpWmcYrbfrjjNiZq6
 A6H/bU98JIvH12sz29jHpMeRYrIF/N73tnjtU+MmVtF2avrjwCGkVSwC+ecBmn1pvbm2
 vd3DIvm2N2m2otsJliGqkUilr4XMezHkfonKANvHlpx06ul4IhZT5AwU987rEQ4B1o0H
 4yNzU13LOQqQsCnWItMyqSliFHZ0Weo873mGyakusPu+4GcUjOfcLuJH1rtrGjNbwonV
 Kw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754326620; x=1754931420;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=El/DASkolwd60608KneS5+xlLYv9lfLG4BngQyPLlNU=;
 b=iyJA7ObUcOQPsqbkr74sSJXiKRW0t4ntgXPx5gRk+R9o9qwb4X0BlAoSlHvcch1W9U
 vTryqmjZ3WHj3I3qDSK16MUvuwjH3QA0/ChO1wlCm+UVaFxsyx8u9jVdyEDCxpTQQccI
 KdOpygPvzMKvcbBsxU39I5mGHBfTMqLgjJIdv5Iaekm9mGW6S0VhlwSesmyEdkGBt/6S
 NwQlQrGnZ2qwwkOW2guFpWNlU5md0ii+p8nkU9pO17fJPkzlOE8IAQl2MX574cfhhtd4
 wjdvrJ3/CVqsy+XeManTYxTwt3olSNRQb36wp/GW7tPOi5A2ltlZqaQhxhI1ftmdLgPv
 MqWA==
X-Gm-Message-State: AOJu0YywEzzEbsVtXwiapfI0wcERuWPpw7keR6/eQEry4eB6bhAD7q0U
 BF/iA2l4tTYupE00XEiAC1B/ZzWFyIflv44nVb1wCqFya+t38KY9fb5XrwtOi8+NmsddpJgbUTL
 VoLwD
X-Gm-Gg: ASbGnctWwp+S7YJC151fzQ/2MM47mBoY0td3qt1GMFy4cynE9452BOWfAW0KARkVrh/
 nNgK4E0SCC2SvX3VrRKoy08EAYXkKGpy45Xv4xFSOUyomeRfHDWcRrRxLESTEevJxGBJAJ56XbI
 aW3P1u0OtVOy+V2e8xa1puPmYD7h9lP8q5FAspjMhDlcT7TpPaxkMH436bDLEi1PN5mmR4K2Ayk
 kVPbIft306zewfLPcaHDiHYejol6SMgMbBkcLyjUMLtDje0QbuRW8XF+kdQ3yH67iX/z6rKAHTd
 E+eMWZSspczRqahtzCt/0Z8Iya9Gm6hPpUw7sgcEXhkL8Rrb1YLfdOWXH+EPsfr2Ph147lttpOD
 CTCTpi4YjlKH2cVRWNHURM41+BbVB2SgG1fnCPHCoNYfgr4N5enc=
X-Google-Smtp-Source: AGHT+IHP3dV/eEBnPxbQNHAUO/IOgvm3xjT8T4HHqgFpyiCnkqs9NyhacyQWDkE01JJ3JqmShdCCww==
X-Received: by 2002:a05:600c:8b37:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-458b69c80bamr81017685e9.1.1754326619573; 
 Mon, 04 Aug 2025 09:56:59 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459c58ececdsm43054265e9.1.2025.08.04.09.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:56:59 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 17:56:56 +0100
Subject: [PATCH 2/5] net: fsl-mc: NULL check dflt_dpio before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-fsl_enetc-v1-2-0708a826f9fb@linaro.org>
References: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
In-Reply-To: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In dpio_exit there is a NULL check for dflt_dpio but it happens after
dpio_dflt has been dereferenced a number of times already. Instead move
the NULL check to first thing in the function. Also assign NULL to
dflt_dpio after free in both dpio_init and dpio_exit.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/fsl-mc/mc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fsl-mc/mc.c b/drivers/net/fsl-mc/mc.c
index 86daf0fb2bb..999a9912e2f 100644
--- a/drivers/net/fsl-mc/mc.c
+++ b/drivers/net/fsl-mc/mc.c
@@ -1178,6 +1178,7 @@ err_get_api_ver:
 		     dflt_dpio->dpio_id);
 err_create:
 	free(dflt_dpio);
+	dflt_dpio = NULL;
 err_calloc:
 	return err;
 }
@@ -1186,6 +1187,9 @@ static int dpio_exit(void)
 {
 	int err;
 
+	if (!dflt_dpio)
+		return -ENODEV;
+
 	err = dpio_disable(dflt_mc_io, MC_CMD_NO_FLAGS, dflt_dpio->dpio_handle);
 	if (err < 0) {
 		printf("dpio_disable() failed: %d\n", err);
@@ -1211,8 +1215,8 @@ static int dpio_exit(void)
 	printf("Exit: DPIO.%d\n", dflt_dpio->dpio_id);
 #endif
 
-	if (dflt_dpio)
-		free(dflt_dpio);
+	free(dflt_dpio);
+	dflt_dpio = NULL;
 
 	return 0;
 err:

-- 
2.39.5

