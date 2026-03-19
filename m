Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51901091916
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2245840C1;
	Thu, 19 Mar 2026 21:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FHwQA0Su";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4E383FED; Thu, 19 Mar 2026 21:02:24 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA6683FED
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-67c1ff46666so347921eaf.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950538; x=1774555338;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q7RfnIzyHT2ehfoP2WV+EyIlwfYH3qlyeFb25rRfCAk=;
 b=FHwQA0SuQ20Ib+exWom8fId+LGNwb7ftoGQSpr/lZskY2QRgXLAgcPMC5k/FbMq2Pq
 UpUBu58MVZpjH5rrlgMy4p/8K5SZACN7ExRqQllsisMInOmR8I/ccyZCaHsCTOMCEk4u
 Za7ECRG+xSG+tHUmE7cgj2PpcsrtBHwBi+g6ulUDirHv1JCgxowgd0dlNTzmjZP5aZcH
 i0w1gzvCMmT9uC425Lz3AO1kZJVeAwy/ott9HgASMHYcKUeRrnJeUqhk9q2fYzqqOxyA
 Ev+K2y85Mn4CvWPS0PWLxBet5QOVvJL+zqxSEifQIeIx4i/H+tVdU1f8n5h2xcOTJWa2
 jFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950538; x=1774555338;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q7RfnIzyHT2ehfoP2WV+EyIlwfYH3qlyeFb25rRfCAk=;
 b=Z6cMN0xpTegqWKy97HHcoWqPW9ye9OEyD1B9OiUCilXEHElnND1RhGmzKscOyWRDNI
 bHAlRe24xqVHsD29rNWSUJzZvCiqWMMMRuaUnef3oPSFr0mrSuioC7YTs18gXxPlZElx
 ZV4sA+QWogBWLrgIswpELoM31/4AwdzlmJkiP6R7H895+Yt0qNwW3PXb++Jw11KPN8bZ
 b83uVlsS14PkwbgZI3m5LY12TsdVG0ncRgZzftWJ62O/ceZjgN9w18aqPWc9m6cLA2Sz
 CM5Ws1DTYxQLTYazjKSsS0YuhIk6TuW4Au6crNti1bxs+4gLYT+QrjotGDsWTo9p4SSZ
 y0vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/JYUQNrIs+6a0bysg59y18ORFlM5hWh4+6lcGoAL4yyr8QYwOry+mYSg8IlVgSql+OF9crh0=@lists.denx.de
X-Gm-Message-State: AOJu0YwkxbOf9CFRml/CLOTbhEj8Ui8isCHumBH6mITbsTxr1B4hvZ/G
 VFoiE3ioTF9+79tEzoIj6iaBI2Q4JrAewNyrRYjbQ74Xs14QBy8ODjkofLhkmArmNtg=
X-Gm-Gg: ATEYQzy/pbWn+65mgVYfHJtpf70uR5LMGXRgjC+FNMH6BQ3Fx6g5JqiROfKP4VcDTid
 TvEWn8Jpaubbv4C32+PdqmOa8tIM83ybdyPQ2aXF++VgQ40BAVJDM/yJz5gx9ABZ8+1aYp7P96K
 rHBVWLe11zlTqX9cYDJxqtELX4O7aKMewQBjp0JqCg9tD130heFYmFyVAXxhLu/WtBej6Eh4rOZ
 GqtlXjeTjMozj3/eT8ln0yi6OGeW7ZvyOeGn9/k5B8LtCQObxtmvrQ/FtnG9Z/WaxPxS1h71kPm
 Own6sYoTr6zpYVODC3ItFDBk7KRjxrm14afQt+k3T7U5O2aLlEZmyLdOhVSTR9qf0i8BUM9zaT4
 /NYoYyTQHCoHFR92Dzms/ja+O3FaLZn14kd/WHAVBF3WInOST15N967DJvRQ0Tf0dy+sPZpfeS1
 fv5YcWgTABP4SPEHy0aPZtpq+61e0hl6D9GMQBcZU=
X-Received: by 2002:a05:6820:81d2:b0:67c:df7:6ed2 with SMTP id
 006d021491bc7-67c22f22ad9mr516994eaf.16.1773950537605; 
 Thu, 19 Mar 2026 13:02:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:12 -0500
Subject: [PATCH 09/17] arm: mediatek: mt8195: drop dram_init_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-9-6171ec141f40@baylibre.com>
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=x476TIt/Pvk4bPT7TIeX4oRzYHdx5ZNygB/fusc/xzc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFYCy1792HhIWpq3klkwZGMQAYoRjESC9CuLa
 OaYH9ArNayJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxWAhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AzwUH/iRzFq4yvgElOlLWd99DgtjmyPk3C7HUDlxZIw2
 s6zvqfErDED1QdnxaI1NR/QIsRIM+a42uF2V8Qylz8bHDcuK3jDcfN7pVxGmJyBcl81Iq41gsVA
 vSTcew0SCKztEPWw1i+JyLYWDD93w4iT6/ODIb3A+GYwbVYKOJWBlzq7kep4WFNsAkli3FCqae5
 Ur8DrCnYTDiOoITtSFDE067PZmpebvKkL99ucEqQgq2mXihpiC7q00d0qAD+J1h9vcCmsvElscp
 Anb6I1iPx0+VMyVgQs5UiI29wy6t8uu8IbZ1cPLboxCrF6sPEFPYt4LXixDmVeS4z3cpLywd/TL
 x4GI=
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

Drop override of dram_init_banksize() weak function for mt8195. This is
effectively the same as the default implementation, so we do not need
to override it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8195/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8195/init.c b/arch/arm/mach-mediatek/mt8195/init.c
index 0f68c589e9a..ee463e90409 100644
--- a/arch/arm/mach-mediatek/mt8195/init.c
+++ b/arch/arm/mach-mediatek/mt8195/init.c
@@ -37,14 +37,6 @@ int dram_init(void)
 	return 0;
 }
 
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
-
-	return 0;
-}
-
 int mtk_soc_early_init(void)
 {
 	return 0;

-- 
2.43.0

