Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87261F8FA80
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 278108412A;
	Tue, 21 Apr 2026 16:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="EkSXCp55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A25839D5; Tue, 21 Apr 2026 16:24:44 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB98840A9
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4756e74f8edso2979345b6e.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776781480; x=1777386280;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hxbQRkOOCXvr4sD1tYy+uI8xaUQfCRFh5rNjQ373bxE=;
 b=EkSXCp55wrnWn7yG6hF6QjD+hEnBwEemj2uWnaFobeyN4CEXUpV8rxhLA10Sej4xgZ
 xhWdEQb6Su3tV7lzkwOAebfKzCG7mxx0AtEJkSslCivWITq3j/n+trolH9lAsufYjpPJ
 sJ3Bw9xoI6jk80pNacsWkNunLeq9qz5AiTokjvS7WFSjApkhYaAI8TRbb+mMhqDphdcO
 XgK4iXKGWtZB37uXcnQc5Zsz6Gvx8CM5soBAtLI8a90bXzcZnWk+jfmUItM79IkqBhQD
 S/oI2s3W1hoIlaT2+putf6vrCNbwvQD00MgoM0H6JzvhWuffLQoLf/dr0PzODL+qvHSx
 Kfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781480; x=1777386280;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hxbQRkOOCXvr4sD1tYy+uI8xaUQfCRFh5rNjQ373bxE=;
 b=EkbqO5ia6u7DwQU4pa3Vr8BqV+k/XAbtB1ZxCWIbCU6Ay4AlqSleOqDbwqtSJ0iMr4
 EB4NI8LwyDIdkMzogrQweyqorCVGJ5i9112F25iYv9ryMvPDTf65XHAeoLj8vzEySUNf
 FwnXdKc8eAAQItRjQwM9OlG9oarm8u+0Yc0sNCRppLSbogpiQAy/VeSwyVojqbiXCdBS
 aGOW026yBKSbGDdbmPb4LXTHSeZftinqOqbBMehkCMAcf5MQmbUukj64pxD6Tvl6MLE7
 rGbDhLbs5qcPgUQ3g8Mx+V5Dl1AbJtzFEqQvYyv0fhR3FVBXosCMnMTkSLwdGpDfm+9x
 071Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ejsbg7g4I4U34mBh+AUwP/QXSZV7Q+L4YsUsypADVAiP2zawvZ4uUpqJukKX40DJKoQbzjTs=@lists.denx.de
X-Gm-Message-State: AOJu0YxtyICWUVKllx5+u/t547lVaRzBkzdsc9lGZzcyS9dmiIxXmcoH
 23ZfRFhH8PpD/FhM//m4TRDj+q/r+V60uB7D5qemOiBEYgv/aTpTb+Wl6mXeWKJ/KX4=
X-Gm-Gg: AeBDievxrskDUkSMIvJcwQj3NvB6CPiJjS+recYzGKMVH0nINSM6qkJb4eEGNczXAZh
 FV9HoM0bQUS9UKAkAQANxZ7wnmeG9hy0qRdY5lK+2UZ4m1/z52IAlSGlqT38iuHm+9olcXfTa7B
 ULIfsn2UUy/UnERUjA7dhE2G/24U0/7v6B4MwimZfo2EhWC5S5GmXKj3c+kuSX/LPltml4S0CI1
 bM22XjMYd4LuE9XMyWM2dhHEWTnOoOWA06SLLgZQezw8BQ9PyskKTUvQs06O2onOPGXGQXfh+5E
 W7v5qeSnlEEoJvfBYH7dpEryZ4RoHo2q4YoMwEPQCAuhdI4v+mx7yCKI5aJhWmgsWSuIdvCmq0F
 mNJMV/MfEI9WSqw63HXBoaPuqjNolEXizsoc8ij/yTh95mQ3csyHzz4yxV1FHRE1Y802cPVUd8n
 ncDV3tnP4yWEanu8qekrHp9pkbXA5t9cIl1ejlQOE=
X-Received: by 2002:a05:6808:1a03:b0:467:1e7b:72cd with SMTP id
 5614622812f47-4799c917c5dmr9803301b6e.1.1776781480412; 
 Tue, 21 Apr 2026 07:24:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4799fead505sm9217965b6e.2.2026.04.21.07.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:24:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 21 Apr 2026 09:24:06 -0500
Subject: [PATCH 3/3] mmc: mtk-sd: fix msdc cmd ready check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mmc-mtk-sd-fixes-v1-3-5b840c546af2@baylibre.com>
References: <20260421-mmc-mtk-sd-fixes-v1-0-5b840c546af2@baylibre.com>
In-Reply-To: <20260421-mmc-mtk-sd-fixes-v1-0-5b840c546af2@baylibre.com>
To: "ht.lin" <ht.lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Weijie_Gao_=28=E9=AB=98=E6=83=9F=E6=9D=B0=29?=
 <Weijie.Gao@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VuR/VR8ychxBXmBAty3m1A9ta/OTMzMUF3tEYQzSxG8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp54idfKrQFWytVMRN8ukWK/QT2x0WndadGdbdE
 Ep3rVaOYfKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeeInRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AczAIAI8WsddFatPyZkChb+4U7JH9MCN/DYvXWPdNBWA
 ukmeD9TdmxzWX2H5qgqbCbhDUbRhmDM9tAELFwtBnoKMcc5+t+SC7xHs8U9P+tWFX4gII83dpQq
 JkIzFYNIcUj2bAQbIQh/WgPNBMhQaa6Z9b8/3xvn1msmdhu8VGmuVn+ayGlEf4MxpDYvbybXPZU
 sOYBDOhQJmNbz3mljzhs6KRySVuATdGu7tqPvrcvFlJRxibJCtwI+0z55AYT/Ucro6EXzOYE76A
 LqR9IfNQ91rAg7SoaI9fgZQOnWGQjAiFIRakQR4kdK3sstzKcqqqQhrR4tjSlDF1DIk5EVqPGsl
 jElc=
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

From: "ht.lin" <ht.lin@mediatek.com>

Correct the check condition in msdc_cmd_is_ready() for MSDC_PS_DAT0
polling. Without this change, it may not be able to detect if the SD
controller is busy correctly for issuing the command.

Fixes: d24b69395949 ("mmc: mtk-sd: add SD/MMC host controller driver for MT7623 SoC")
Signed-off-by: ht.lin <ht.lin@mediatek.com>
---
 drivers/mmc/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index 616cf3f360f..51c9c0a3fad 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -539,7 +539,7 @@ static bool msdc_cmd_is_ready(struct msdc_host *host)
 		return false;
 	}
 
-	if (host->last_resp_type == MMC_RSP_R1b && host->last_data_write) {
+	if (host->last_resp_type == MMC_RSP_R1b || host->last_data_write) {
 		ret = readl_poll_timeout(&host->base->msdc_ps, reg,
 					 reg & MSDC_PS_DAT0, 1000000);
 

-- 
2.43.0

