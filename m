Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2228F1091915
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E64A83FDB;
	Thu, 19 Mar 2026 21:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d7aSNsff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EAB983FDB; Thu, 19 Mar 2026 21:02:11 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2E383E36
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-67ba5b0e00dso456644eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950526; x=1774555326;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rK7kYrheLNMj1hTzPs3Hm+ADbVGYB7W49y9FPY+Zsy4=;
 b=d7aSNsffgOOguwaRdxEC1TeEJ47nJhhpkt/NpmPvzaO/0ea7T0X8/Zj+/YwoWgK9Gj
 qyne9uF+vhtLtN/93atwOkkrObpjzw4R8ypxFzvboWNeJ7B1gtKu6MPL5HIN7GeYct/z
 IDV/ffeXp4Jwp9sJNYoi4HQQ0Up3d9e04OVt3KhrOQhu9meRzDEjUpDAICizjv05FN4y
 76jQ5aV69qKpi3Fy8Wk1E+UnQssXZQHSg7cSAWVk22vD8YVoUDsOmiljdJ9wA2V+WEVK
 DVv13oKUuRo2xz/SpW3T+sSRVK311C3XFtw1AiCGFn0SOHSs9Uelq8GS0QNC+nYIaFrq
 8ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950526; x=1774555326;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rK7kYrheLNMj1hTzPs3Hm+ADbVGYB7W49y9FPY+Zsy4=;
 b=kkA/BM0ruXKIEYIxGPFI819sv+KGcINMkX4bNvjUxpJbIPmFiG8zU071MhQ3digaMc
 5VWSJutkwMC62do39duiZIb5Xp+vRpdVUNkgmMZwV4w4gq1fGfN1nUZ5+q7i3PPCudnp
 bB6hauHTkymbRg+oAD/c4qk7gRzR4ikPjsaDwJYWwxRdedwiF5EMBGJiUoRj605JJOEw
 zD5MzMJTX3kpdu0VrsLmbAdBEWQBQ0PwM9FuwZ/zC2mtihMQWy8cchLI9azUjoztN1u9
 EB53cTKjAElOM7Fy+4mycBz7pslaZm5BkLbvghnWHiR9v5gb0qsbC2Wrzm4qsgdx5R55
 ktfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiPRr7Y7OAwCI9+s6kMgbKNfj52OoHZFUdQk0Vp/nRxYTGXw3f+ypnsG4WLefZYMeEdIpu7xs=@lists.denx.de
X-Gm-Message-State: AOJu0Yxt8Fil+WoT9JoB2/mXMi4H6nQWEbXTIowZZ9sAjPXg6C74U+t8
 LkWqvaiyNtd5i8ofKR04KOp8NxUDBXKwubJNmR3oKwlysZjwmqE8428y+Fmzn/5AldY=
X-Gm-Gg: ATEYQzzOq1RghqtiPWwsrKrTCKzysASW3X2KCwRdBmss0lnD357bRQGJSXa1ELaLovE
 e0tP22lfgd8oRMqqFPQvtGu3v1rI5NnML84IX4Jlr50Cw3lK0ZdJKt0j+qcavUE121a8u6BJinS
 5KE5lcRnBtwm21HTJqt/RFLT3TS28zAQwkWG29FoIBEEvIjmHjQmch3K8NRzjw6ju/aql0zgWhV
 7SxCQAOB7c9nFRHKhNgseqpAHzafiV7Nxe4TmkrLqyjQAaxRKBvHGpOzV6Z489jzKTcRrr/o5b7
 EQy4u//mn1RT0EGn/ftdilKi2NrXDzckh/f/11nEyvQIMbwVnKhgqSDU+JtCUHFnAL2PyJEbYVC
 08qmyCicRd9FQ93VysZNoaNgXDQDuGup8Yz1DKhw5lab1U/StPhuBaiu4laInSW6dtkoyI/hCsE
 uAv5muQGimhDB/UP2HJAYmMhtcsKfY
X-Received: by 2002:a05:6820:4d0c:b0:67b:a91f:8f05 with SMTP id
 006d021491bc7-67c22ee4e21mr552212eaf.24.1773950526465; 
 Thu, 19 Mar 2026 13:02:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/17] arm: mediatek: clean up init code
Date: Thu, 19 Mar 2026 15:00:03 -0500
Message-Id: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrE2iRIWriIXqYIiStkQi7q5Yf
 nl5/wWOLJODKrrA0sGOVxMg4gi6sTUDIetgSJNUJpkocfEzsmGPPZ+obbtgLpSWIi+UkhmE32Y
 pbF+zbn67XU3U+TcE9/0A970coHUAAAA=
X-Change-ID: 20260319-mtk-init-fix-dram-51bd6157bb63
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2635; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ERAcdsxl9xhdGdEeqkVGR+ln5BqBMgIe8Qt6XF2IU1s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFXGjs2B4fdjq+iHGTnO7+ei/aDoO/TBsBoUj
 T8+3Mm45jCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxVxhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AH1gH/3SYYiVUXLy3ravpWOcs4rVE2IkPaLjxet2w2Vh
 1WoXkWTc55C3Z7HqgCeSto1+aDCJdxRUifQeBChg65pKCUB6h4uT+223/EWtoMpDmGlZDIHgzsi
 4tfmHujHLcWRXnjEb2MTfJCGUXLKPz+HIYgcsYMPmGCLGeSvbHjMOgF03K6QKox6rSWPQZo9zCc
 QQ0wS8l3kyqpkzmIvZC1QMwUfGxESkQFEyjYPMfq8IKDUGlWG+AlKqn/3aNEvJVXX/Tna349X2l
 AjK8Fy565rbHQ256V3ukDyZvB/6Np1jVMM253SKUjlsXUHGDMjaE2u0N/kuIyGdtofBfjzWqI7Z
 QAmE=
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

While debugging an issue for Genio 520 EVK support [1], we found some
issue with the various init functions that have clearly been copy-pasted
between the different MediaTek SoCs. Most of this is cleaning up
duplicate or dead code.

The "fix gd->ram_top limit" patches are fixing actual bugs on a couple
of platforms that were introduced during this development cycle. It
turns out that this was the root cause of DMA not working on MCC on
on those platforms, so we should not need [2] after all.

[1]: https://lore.kernel.org/u-boot/f2545bf9-3709-40fd-8d0b-b68f4d841d02@baylibre.com/
[2]: https://lore.kernel.org/u-boot/20260317-mt8188-mt8195-disable-mmc-disable-dma-v1-1-220da4144920@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (17):
      arm: mediatek: mt7987: drop dram_init_banksize()
      arm: mediatek: mt7988: drop dram_init_banksize()
      arm: mediatek: mt8183: drop dram_init_banksize()
      arm: mediatek: mt8183: remove call to fdtdec_setup_memory_banksize()
      arm: mediatek: mt8188: drop dram_init_banksize()
      arm: mediatek: mt8188: check return value of fdtdec_setup_mem_size_base()
      arm: mediatek: mt8188: remove call to fdtdec_setup_memory_banksize()
      arm: mediatek: mt8188: fix gd->ram_top limit
      arm: mediatek: mt8195: drop dram_init_banksize()
      arm: mediatek: mt8195: check return value of fdtdec_setup_mem_size_base()
      arm: mediatek: mt8195: remove call to fdtdec_setup_memory_banksize()
      arm: mediatek: mt8195: fix gd->ram_top limit
      arm: mediatek: mt8365: drop dram_init_banksize()
      arm: mediatek: mt8512: drop dram_init_banksize()
      arm: mediatek: mt8516: drop dram_init_banksize()
      arm: mediatek: mt8518: drop dram_init_banksize()
      arm: mediatek: mt8518: remove call to fdtdec_setup_memory_banksize()

 arch/arm/mach-mediatek/mt7987/init.c |  8 --------
 arch/arm/mach-mediatek/mt7988/init.c |  8 --------
 arch/arm/mach-mediatek/mt8183/init.c | 14 --------------
 arch/arm/mach-mediatek/mt8188/init.c | 32 ++++++++------------------------
 arch/arm/mach-mediatek/mt8195/init.c | 32 ++++++++------------------------
 arch/arm/mach-mediatek/mt8365/init.c |  8 --------
 arch/arm/mach-mediatek/mt8512/init.c |  8 --------
 arch/arm/mach-mediatek/mt8516/init.c |  8 --------
 arch/arm/mach-mediatek/mt8518/init.c | 14 --------------
 9 files changed, 16 insertions(+), 116 deletions(-)
---
base-commit: a27980786cfb3c430aa1c05da8e79180c584d221
change-id: 20260319-mtk-init-fix-dram-51bd6157bb63

Best regards,
--  
David Lechner <dlechner@baylibre.com>

