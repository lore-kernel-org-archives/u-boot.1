Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A912CC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41CD8810F5;
	Thu,  3 Sep 2026 14:00:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UiirJnOWj_r7; Thu,  3 Sep 2026 14:00:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BA53F810E3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788444004;
	b=DGpsLC1MlbEuEogGIv18AqyVIHtW+f8+BNcJHlcn9/bkkr1LXJAB/jNxMPADS8C19W6k
	 LCNB2OHMDyBCMp0iMwOVphGcv2DvuKk5Objf+0dcxcaPNxBi2RY+HheToPI5qsbdHEzu8
	 WPWKMjaJzDxb+bcJNqwfxUvyhaIrIyD4ZOLyKizG7XjEwOI+oZTgruyV8cVYIh+MmT9HJ
	 N8rzg6f6hfrp7rnXvTVn806bfLJaxkGQXMlAcNQ9piqle/+mG7HJBnrBlhFTPQYJTrM3S
	 //V54KHt/cTFx4KgiNZLsGBu+UTy9yAwjOv/omcNJJxksK8dXAVHT+m7qJXXXMJdAZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788444004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YFoN0hNVaesSRVwollqCPHYQODIHIm5SJ2lIkgM0Jd4=;
	b=HYSeiqGwOLbyQdwRuWuYclGvDNvfZHTV2biX/jX0V2HdT2MMwtI4pECFJwzy9PEFtiM5
	 cWEI6VA9aSYDKh0LiH84eU9FwbBG4/j2s5jqV6AMLQNbStrCt7bby8JB1nBWCwHDCaeo0
	 JNcSxZ1Vs2vHjPue2mgU0gU4jW/P29Wuhmvcp65q5kepF6EGkJQW9WjcNYFYR74dp3Ctj
	 RcMzi9Ek5d5lzCTcKPuF8V0jdwSQpiE2xRuA8ugTmTQ6e6Z/ERsbFD/C+T1U7EoqtI3ne
	 TLKJFnMQdZf2W6GzJDmfLI6BDa7Xk6e2EOOOeim4M8H9XHnywJHYpg8tY4QUwGF9o2Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788444004;
	bh=YFoN0hNVaesSRVwollqCPHYQODIHIm5SJ2lIkgM0Jd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uQ8WJRdIJLuF/Qqzx9Xq7tCIy/WEIg7oZ+kLJBPIj7EC7Ylc1EGIWJwsQZxcsoO+Z
	 mAeQybuYHbfhxdvMtiuo5PdCu/QqjwMU3D6RirAQDu0Z6hAgmj0k3uhbgT51wwS66l
	 kmaK67mmh/U4w3ougOgQcQ/Xnv3COao0rZkw3sEKMBzLL1cfwtEJ0ets0IlPGYL8XV
	 2/EBq8uMzHKCFTerbxhogZKDaSPPWAYuKfuJOMIOBAl9J8sO0LD6qJg7Rd7uKrCyT8
	 ojE2Z3rBQQVIblKPALugCn9bgGFfRO9di1X69m/nOyjJTMI/0gKVwi/fPFpdsQeiu/
	 nf35pBBVRrrtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA53F810E3;
	Thu,  3 Sep 2026 14:00:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A5E42FD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E76040469
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:00:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r-wTdVh-VwyE for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:00:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7C2E940454
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788444000;
 b=n8rP3cc1/8v5vo5T8xpuUZORwpt6+/F2M1OtDx4qEDxL9AzXrVT3/Jq8A0obEJ2Y/Oom
 yuDyZDeqiMVHl2O6mLsHSpLC83gj0tr7jIIRVgyAbJt0/IEVH27WiEr8uECxww20XsrPC
 fUUqfEP10wKQL4qN1OgtkZRdE1s+R20spUvf7qe5No3N0tzrsNTZNJY4lNWc/heuotdOg
 moWycMt8nBmE2ufIMd0twiRDAk+ujwTDGEpZ6eKAHwW7HoIleXXp0oyB3vBfv6E3kYHMA
 t4vlQzWpam7ZPUJ+lGDA+Vks5zqzeGe9aJtikTpCQwRN7agmQFHkwf0of4mlJEN/pqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788444000;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=YFoN0hNVaesSRVwollqCPHYQODIHIm5SJ2lIkgM0Jd4=;
 b=X5a4aSTONhddMlalES3qpZWiTJzuIhSfQ/CNrf1vHyjE8vj2T5N3EtkJueBuXet7/Uby
 a7xLr76IotxgemQdR6zpfmt8u0OrHJVBo+KnlYdQbn1GhwctJ7TyVnQUeHmdmVA2BbOOA
 BlRoevas3Ce6zvf/JcRV4No6LTW4hOkwwbCK/bYq38/j0XHitsWGTy/U0lm1Ag9OB13+X
 wiekodf7VHpOy+xSHbIA5rflZDtA7ZYVEphQPLGLRkH1sbjDkW0nUCgr3rRXBXW7LwLsP
 DNL9XcvUp9Uba0MEgWkEeDk4dpuxgfHr9aCLaT/Mp3TQKmQAZXvFJyLyHPqEGyft5Mw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=W2grkr9+; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=W2grkr9+
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C2E940454
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:59:58 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4843f205a5bso1686646f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788443996; x=1789048796;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YFoN0hNVaesSRVwollqCPHYQODIHIm5SJ2lIkgM0Jd4=;
 b=W2grkr9+ueBcg7u0s175M/yfuNtyb0cTCKrRNLMhOv+l0BBlVaXOgS6P8rw7UqidWz
 0HSFtwO3D7QE34y11iSEwIYg3i32/oEsGrqiNFVlzcCNob9TdK3Ly4xThwDnyn8aUa8d
 o/tr6u+vwtsVjHfu5jimspVVDZ8Xx6NZOzEjYkgCqUhDh6mq2rzrzIIIafgoRTHyN2kl
 i3g8q+MRtQXkiPB8nmzpzcEN5oIc4KhapKi11Sy2mTmErpHXeSA9ky9CHvX6+E38x9ok
 cZ8xantC78FTgHZFLqP1+ED1nrY//r/giPCT0Iolus5ETzY6SUKrEeSbp+jqNUeLxgDI
 mktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443996; x=1789048796;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YFoN0hNVaesSRVwollqCPHYQODIHIm5SJ2lIkgM0Jd4=;
 b=FgnoixXB9X6VufaGJ95Pk1C5cOGI/pqJoRG1rljKG7l8H9TLUatpmw41cOJBcj9bt8
 JkbFgmqYe0rNFabHirtyZ/bLlTYZk0ZkU7SqBksCGW7r8i2ISdL6hkuFoIgZQ/ZuuEDl
 rKsjWHqsfA1L7AMTp97O/5IScUar/IrTivIukE5OsYon10EOtMTs4VqfFnad/WKt2q91
 PKBGARWYkJyMvRsDY/BISskeIRT6arABV3NayZ/LyLSXXmy4+ylc9cQe0KVAp0VF2T/1
 32XrXwBcdE4m8r+vATMvmJJwJoNhihf1SuDE94//MX4z2U2suje7HBprOejdrV1RiBws
 FbDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkheezq5fNDki/4YCJJL1aJiSi+oJWHPMHdXRKSttKwiV+P1nLNy7AA4NMyl3J7V9o6/hXnFc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mtABijGvElbUj3zJPmqWnUaJnmhe4SXWQfEjfwO9+FydR0E0CL
 IgqYh5UVr9z4bGSYW4S+5EA3ulyWaT7qFa9D5tIGEPZrcYfor+bZ5Qrip5ECwqIsEPw=
X-Gm-Gg: AYBFou32GfiiS2eFulQLX6Jl97fY8Aq26oPHGtl0jByInuocSWBIqvN8zGws1cQzBOA
 4Vd/zT9nhHoHQnkD+cmmxxadct5YASE7BT//seCJ+qFANN3JgrbHwk07q7i74zdwDLT5p1RlBBn
 NB/m23zUIkpEUXAYH0oNbzjG1S4MtVDYvifg/C6g6vZX8pqLkxZLbd4lwZGBDQSQTlZ7eLD3l0A
 plf/xvFF6dWNgDE1lN/7KWCHkyVl2D3rXdTJh3itgu9UpzT8excqxqzEYfkyLO2v/VSQJnCJy/M
 EX2EcbLgfKVeJo9QYJC7nGJDo/rzrATpl1KCbWHyzhWJtHQOWVkafdPoAzIXmDNCtO8UeV1blh/
 VZYWy9a7TH/5/wNVsnESj456N+EbWNYzgS+G9io+oZvcJY74lPVkNSMlCHv5OSCr7nVEUpAC3uP
 MKoT85x39TQdFx5r4UsvFPxkdMvPJ0g4/85bq7WCkPoTchMX2MunHBeHKeliGLSPyjbJ8Phr1ak
 dXU7JuSErK80e5eFUmNq/UFOrLz0vGXUm7aNQsdV65gLrZPe/mQ9abMvHzrTdTlotlx1UEFHYzP
 FvH/GkAy9OcWRyLWXgKz4gJyVmeM1O79Yn+yqr6N3tLx
X-Received: by 2002:a05:600c:474a:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49ce55ecebemr178599885e9.2.1788443996017; 
 Thu, 03 Sep 2026 06:59:56 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm74213505e9.4.2026.09.03.06.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:59:55 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 03 Sep 2026 15:59:34 +0200
Subject: [PATCH v2 1/2] video: remove show_splash()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-1-18c22bdd9f2d@baylibre.com>
References: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-0-18c22bdd9f2d@baylibre.com>
In-Reply-To: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-0-18c22bdd9f2d@baylibre.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

show_splash() computed the result of video_bmp_display() but discarded
it and always returned 0, so a failing splash display was silently
ignored by video_post_probe().

The helper is a single video_bmp_display() call with a single caller, so
drop it and inline it into video_post_probe(), taking the logo from
video_get_u_boot_logo(). This has the nice side effect of leaving
video_get_u_boot_logo() as the only remaining user of the logo symbols.

Since the return value was discarded, failing to draw the logo never
aborted the boot, so keep that behaviour and only add a debug message
reporting the error.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/video-uclass.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 228d6bacc58..1a268137bde 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -592,16 +592,6 @@ void *video_get_u_boot_logo(void)
 	return SPLASH_START(u_boot_logo);
 }
 
-static int show_splash(struct udevice *dev)
-{
-	u8 *data = SPLASH_START(u_boot_logo);
-	int ret;
-
-	ret = video_bmp_display(dev, map_to_sysmem(data), -4, 4, true);
-
-	return 0;
-}
-
 int video_default_font_height(struct udevice *dev)
 {
 	struct vidconsole_priv *vc_priv = dev_get_uclass_priv(dev);
@@ -721,11 +711,11 @@ static int video_post_probe(struct udevice *dev)
 
 	if (CONFIG_IS_ENABLED(VIDEO_LOGO) &&
 	    !CONFIG_IS_ENABLED(SPLASH_SCREEN) && !plat->hide_logo) {
-		ret = show_splash(dev);
-		if (ret) {
-			log_debug("Cannot show splash screen\n");
-			return ret;
-		}
+		u8 *data = video_get_u_boot_logo();
+
+		ret = video_bmp_display(dev, map_to_sysmem(data), -4, 4, true);
+		if (ret)
+			log_debug("Cannot show splash screen (err=%dE)\n", ret);
 	}
 
 	/* register cyclic as soon as the first video device is probed */

-- 
2.55.0

