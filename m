Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF461091915
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F35183F00;
	Thu, 19 Mar 2026 21:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ttsyclCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE94C84068; Thu, 19 Mar 2026 21:02:36 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2893C84068
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-67bbea1e090so769676eaf.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950545; x=1774555345;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CgtOhp9OAh8OfQJCOhAPHcKm/LFDQ4M8HEuweJuLJyI=;
 b=ttsyclCkVo0IkGtRw7Ju4j7e0SZP7cgA/6JYImOtDMXVHUed5JtAI3UN6M9AyCEDtk
 L6CkdoCkc3cSjBo/pM6hy9LJqOzpQET++fR9siqdNLykEvZZS7ndUY2WVF65qO5Y/LUk
 ExjToqD3gGexBgLYMd/hV74VfqozFbeJhf4d91I5tqlMfvAdJMqgiCGJZjrTtiQQUVUp
 tnIX/FXk+fp5G3Sh9yv8jMASEuaA+gAdJ4pwjmF8cKXJSPDuzNtI/ohvr6ykjIggjRsz
 tMAxtFfX8c7VzmG8iE1bbzvBtq88BTQXSh9D/PETPOMJcLFmiqrzmxvr5v0r4a6rDZOt
 N5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950545; x=1774555345;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CgtOhp9OAh8OfQJCOhAPHcKm/LFDQ4M8HEuweJuLJyI=;
 b=h3jwEYA/KPt5b7swZcloMc+Dpvm44+LuInqXOWdJ8SsEOg2mebV/y3q3r4+hE0Y30y
 EhTikociYWhkl2YS4BtcOzkN1paukGdWGR/FlX/uc9cBGWieAKsp6YPkGSPGbQxnODFL
 HpKCxdWYD+OvHpNOJEH4pCJJnq1sq1NvHhRRu0OxwvCK4ftDpcCtRdMaVx4iKMN/wkIu
 2qbdprYETZKyWxCZXNuiZoqyI27IISqOFZu4cDq/wBGKfwJRoN42OBfRS40Q9pFW8yvi
 uTneVn0jo+9ZN68ylD8sc3cY/QS2bc60C2JGV5c/mGj02O5fth0X3C7Ux1ky+JEhUZ34
 fF5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWdOInbAJyf1ESS0UHmrVmHYh5hQNhrsaz9s3IH4jj1ZxYRGwwWLOAy17aGrkrD2c+Y8I0qxs=@lists.denx.de
X-Gm-Message-State: AOJu0YyElBWjPM5oPghm5jzd8Nm3KG4rGAUQpThINabhx7noJGwTSwVr
 oV+oQMmN3M2ODgyXDN7DNexD79y2ENSQUHx+RTks8vBgISprkpENNcbefZ2KtUjf/g4=
X-Gm-Gg: ATEYQzy611oY05evEjNgM+BKA3VNhExaV5UizVoTRErtgsa+I5RciWK7VqofKnP+aSM
 J64sjA3MLx8NCPSa+n0LZ+G/Gv0h0ynxDk0Rd00OX+9Blf5YlerHGGmVTf9uPT8i02OAv250hm1
 WBU0prL+oU57ZqyxUWqlDtu3KA55wi45DO1pAKPvGoz0mW4Nwt2a1ehh7a69lLVsb4YzsRun39g
 dbWAR1gYbgvYTu3Foj+31EDhcELU9WkTn4KnBBJmCcafYEEnJ2ISg0Cw5Z4OStq94GDZglmJll3
 ZXAhF43HjMl6gcqpEdRvqzk+OlSOLOhFIhjf/eheLZ2fx6TYzVLTyLGzS5k3c1+QYiUnCcn4wvO
 Ej3NDQ4gaLFA7lW3Fzn3paXx0hBTI+wn62B8eRg2o3hiMrVo1cMhWSG7DZOFjiID20D01hwVJdq
 oWwWSiLvBNd9igWm8TgoJ6B0aMBA13vPBPcLlMycU=
X-Received: by 2002:a05:6820:1624:b0:67b:dc97:1183 with SMTP id
 006d021491bc7-67c22fbd2b6mr512068eaf.46.1773950544758; 
 Thu, 19 Mar 2026 13:02:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:18 -0500
Subject: [PATCH 15/17] arm: mediatek: mt8516: drop dram_init_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-15-6171ec141f40@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=KOfRNjhWfOBeHkK8YgnrR0bVg+2EUM4q7diwj4Up/MU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFYpn8xt8AzVEL3GVDfKt9YXW8bFEDd+dJkFN
 X0e/x/snauJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxWKRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALUIH/ioImX2SDSj67r8nAUCDVxQQUKI1n4dWkfc2Nwn
 2kmmHMYSmpiTzWU6JJU2WduRPVa13d/anomniEtl+EqWnludFR9wBUR1/gXTRcfq035DUneh8WO
 hQgUCqDK5GaLmVZeOoS2BfW0x7wEYcA2TQ320tVQYsgadRANPtecJCa8KMA71JWolEcSMKO2sjy
 N3KT8eTj/W7BAmaEzQw1KELAPujKwiSO0bwV5AEcPUORB0aV8suMxOKEy9+iECd6EFjn2fdTxPj
 TsaL7CoX1XHMr7NSkHUQk78ui98OfXXTAblkIG71/iEPYck0jFULhaCfVhRSF+6rE6KeJcSoG8p
 NgjQ=
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

Drop override of dram_init_banksize() weak function for mt8516. This is
effectively the same as the default implementation, so we do not need
to override it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8516/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8516/init.c b/arch/arm/mach-mediatek/mt8516/init.c
index 1d925dd478a..b470910da7f 100644
--- a/arch/arm/mach-mediatek/mt8516/init.c
+++ b/arch/arm/mach-mediatek/mt8516/init.c
@@ -32,14 +32,6 @@ int dram_init(void)
 	return fdtdec_setup_mem_size_base();
 }
 
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
-
-	return 0;
-}
-
 static int mtk_pll_early_init(void)
 {
 	unsigned long pll_rates[] = {

-- 
2.43.0

