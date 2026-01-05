Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8DACD0402
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 21:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE8283D7A;
	Mon,  5 Jan 2026 22:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wHANaryQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A9783936; Mon,  5 Jan 2026 21:35:23 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE17839A5
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 21:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7ce229972f1so295077a34.3
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 12:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767645315; x=1768250115;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sldHNUCO/9tZrp/QpLA0LDrYvGz/l9QR2vSCmz4lNXE=;
 b=wHANaryQDr6n1OLkd2ce8xs6NUTG570GKGO7LDvB3VYSORfpsQPJAxiDBm3HOzxD6j
 ksU3c3WxHosiAKk7V4iurZYdSfFg/7jPACixKp5x6fuU6rGjG5LbsYTxnpni7eU0ICLW
 VwpoTKMh68tCb/cRNv67AOmkqYI6xUiRhIA+f6YHLsW5hlrzj+dXKZbnixErWd94cM0F
 8VeebGqcMHrvCPQT+AIjR2vJ7r/Fynve8o5TyQmkuNN9kntuvk6uccIqj5wYwdGJIooz
 UpCqYV2/Xapbp63xpavCH1LvKRLybnlsUkDMPaVRn3wyzXk43mHCuq6BuQLiGh5dTXUg
 pcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767645315; x=1768250115;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sldHNUCO/9tZrp/QpLA0LDrYvGz/l9QR2vSCmz4lNXE=;
 b=bnA0pbWYabPDzamkuvs8xWuP5+e63I7bI4zWaHlOJlOS41pHi9+pCeBH/E5G/CKwIm
 4StyiBJhp3CGI0eR33aLIl0FqgZoeSYz+WNFmIP8Uud6ZUO8LnjJXYNX8j0ArYwEeFMh
 pY0pQTlgr4Qq4LcWrfUQNJuLhIhF4y6/2WUUG3jgRwGE3bjQIao9zhSasOtIweynETUD
 8iH7tb45zZsZMftjab22REBD8MB9PwESnbTMX1Lmbd7rPZs0ABACxEPOEtP1rf1yAWhj
 HyAR404VAgRMOPF+2auXvdNucDC1iJh028myM9rSA9uBA+8krxey7G61ajsnEzZBDooX
 +0LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxWL5QnjXc6Nj2Ljc5zj7SbGjbSaKfbrphrYy3UR3O2/FYIspalP+XjgtccWH/eWQIhMD8Y/8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/OYZ4RvWkSBK0oahowlAyXpI4tmc9wT+bCH4mw0T5ExE9KI7L
 JXNQzvNtAtzPLRy6p/eg8tQMyhf15cIhEiBpy/GP9MeCzG5t7ZEExn9gKmoZ43svd68=
X-Gm-Gg: AY/fxX6VKRF6fKjaIJBSWV3BT6DvRMbPxSURY06BnQbcvx4wjSaQ/XuRDqSYI19uoe3
 zHBtIyZCxQltHZpVCCg58VzFRP99Mtor1fz+yVHkKma2YUTlXbaQRdqpQ8zl8T04+U048tC4yUV
 9fTeGVofHCkbhF65kbC4amHBT8o99LsldTBpCfPXzyd0x1QjWAebiY3B8cb+R89IBWABX1CBVGF
 NI4cLQ8ytFDeGLNKHVMm+b6rozA3oHwm2vvlMmoqK4S7u3CGgbDVfsFMNiBLeSn12cqvPwqHDo2
 jGGLzOzDX/Kcjdb5S2DbkMh3ao9bL09sYqUr45D/r7dtAp0vGUVIfLdv/DQoc0fTjvaX01gIcE+
 KlDjJ5GZiVWCmZgu+5etNGZ6Jw2hOjVposVu1QV2p5UEFVvgyI/Fk4nmBqNKszIdpvcqeC6bxkg
 VpsOfgD1yLKeLz5Q==
X-Google-Smtp-Source: AGHT+IGEG02Xuf1Vb8sdYcWsnixK/05LTh+TmbQ/nUl11ao9VAAd/FPhjcILovP65NoJNqNan8imnQ==
X-Received: by 2002:a05:6830:668c:b0:7c7:1e8a:c9d8 with SMTP id
 46e09a7af769-7ce46745fcamr416380a34.36.1767645314780; 
 Mon, 05 Jan 2026 12:35:14 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:df5e:737c:7b32:e5d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478ee668sm22788a34.29.2026.01.05.12.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 12:35:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Jan 2026 14:35:04 -0600
Subject: [PATCH] scripts/Makefile.autoconf: use abs_srctree for out-of-tree
 symlink
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-mtk-fix-build-after-kconfig-change-v1-1-7185a081f7c0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6DIBAAv0L23E2AKi39ivGAuuDGFg3Yponx7
 xLjcQ4zs0GmxJThJTZI9OPMcyygbgL60cVAyENh0FIbqWSNn3VCz3/svvwe0PmVEk79HD0HvAy
 rdX1/Vg/rrIESWhIV45w07b4f3tiRoHQAAAA=
X-Change-ID: 20260105-mtk-fix-build-after-kconfig-change-922538479a96
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=PYNQJK5WPmMzBuTSATGFOjoehdxHlV4vwJaWB2t34vE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXCB6GLTf2UfPnu1/RJ0nyYKgGjxkgSXaw3fvt
 WjhlqvB3XuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaVwgehYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjW8H/joU0T5yoAL8dyh0dkOwPl9Mb7lKiv7qu5xPuSf
 PeJcoA7t4a2212BnsFn/mkZeq0sCTIzeuvOgOP5MpclzpkzIpfcH2KKSWCUaPTp00Z9/SZ2q8b8
 nc64XqPdoVBTt59bVXePYW5uN46ExDaM65De98E+4UPScJwmi3ystFwEsG5KGfHcM9Or3BIU5Up
 wdPwVcrJF/yWPK2H93qXF/G0HCK1OKBefRxViTgg1JvC8g0dNdsEuzT04v3udkCIdElqTULVjHk
 C4l+w5kitgiUP17rSwkyzsJ/KVJoZ6eClrwylCg6yUMN2D26B39ao07rHBXvyq9HeVkUX9p/xb7
 d+7A=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 05 Jan 2026 22:15:13 +0100
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

Replace usage of $(srctree) with $(abs_srctree) when creating a symlink
to include/asm/arch in out of tree builds.

When building_out_of_srctree is true, $(srctree) is just "..", so the
created symlink was broken, for example:

    build-mt8365_evk/include/asm/arch -> ../arch/arm/include/asm/arch-mediatek

Which would resolve to a non-existent path:

    build-mt8365_evk/include/asm/arch/arm/include/asm/arch-mediatek

To fix, we need to use the absolute path to the source tree since we
don't know where the build tree is located relative to the source tree.

Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 scripts/Makefile.autoconf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
index e3c88badb52..47c49a018bf 100644
--- a/scripts/Makefile.autoconf
+++ b/scripts/Makefile.autoconf
@@ -138,7 +138,7 @@ ifdef building_out_of_srctree
 	else									\
 		dest=arch/$(ARCH)/include/asm/arch-$(if $(SOC),$(SOC),$(CPU));	\
 	fi;									\
-	ln -fsn $(srctree)/$$dest include/asm/arch
+	ln -fsn $(abs_srctree)/$$dest include/asm/arch
 else
 	$(Q)if [ -d arch/$(ARCH)/mach-$(SOC)/include/mach ]; then	\
 		dest=../../mach-$(SOC)/include/mach;			\

---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20260105-mtk-fix-build-after-kconfig-change-922538479a96

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

