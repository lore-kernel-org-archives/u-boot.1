Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC884F8FA83
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF6A83693;
	Tue, 21 Apr 2026 16:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="rnRklBG8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 437D48412A; Tue, 21 Apr 2026 16:10:23 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7BE83C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-691de293326so2439015eaf.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776780619; x=1777385419;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=46DNoU8rDWBQjIwQex+rgfGEeoLpVIFDN9/MIHtgleA=;
 b=rnRklBG8h769Z31qZDqHi6crkaEtNqzDBwO8SdAqahherXL510eWukgkuw3j5sxJWK
 aNW/NSDlU6r6R9xkQCZXoeH8CB1oWhi0TqSNMNWBOpN3yZBLmiK/WTTOEHEKIWmMef+Q
 OtKeqgB+ljLrXm4QKzpPuAZ/7y3+CA/xsyK9Xpue5LYrsvhDEfnv6FmmGusBVxCdrdAx
 zWSDhX0AfyYmjZHPOqg2HRYBZDhBoWGywzhlZjIBI6o6I1VXK9SyQVi5tomZTIuQ0ucF
 PweWkYDPbXOiBzUF2mUWphP1AOLMEXuEk3gU41AMJYBZoZUuAmeRGgfonv7i0dcyxret
 5VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776780619; x=1777385419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=46DNoU8rDWBQjIwQex+rgfGEeoLpVIFDN9/MIHtgleA=;
 b=NjoUe6+szBNFAyfGfwU4mhtPSvEfVJHTCfIAHrq+j3YI5W0386P4GSSu0QmB4olHHp
 +/fgGIs+V2U4ybCM/QcpDBgUyN0O719HOp2dJ309hH9watpVrUw9hKIx6xUD8umXIRBA
 hdUxB5cLyGrRCzTSdPdIV5cN4o5xoHalxOhnKaPhYLE5J6COkOL7bbwZftA4JwmfG+KR
 7r+TOy2Xja/bwzneEvWfIK51NLdFQ8zP8atDkOCiduw//giW/wbN36BUaGdjUHxoTFbw
 a+LqS1+CUH6iC5Nu2ucsSr6BPO93B4RZ9ZJxTedmwzuz9PbYmloWjSyB/lpVssI6Am7p
 hv9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/b9DP/dmLbsEqtPrV0BX2bBaZ/MrMhAUXan7tJT3q17Q3/VP7TTa71kidenYJ9O2FV3pamocs=@lists.denx.de
X-Gm-Message-State: AOJu0YxLOK8TS3PZ5TNJLoKG0RwUWp4OZDrbMa+X/KqkQBkZ+aZn7wLm
 nilkYNZtggLmNKx8nIeQQUGP4BCRbBZSDtp0bVOXACMpBNlI8MD7r4k4FvWkprByJGX10PHm9CU
 fllap
X-Gm-Gg: AeBDieufN4NM2+EakY5lKVUz14lNf5RuRHHw5xH4QDJh6X9dS/kD9taiQymzjn/hpM1
 Gc8SzkyRo7+vrBe5mcgrzLWguv57EdCQDUbZP8UY6ad6kRB44DGZS7mCJSJpHMRAdiOdqf5Ob0O
 myuLRr7dEwCXZ3oIt4b5qZcIr9rVU0I3xQPfarbVvB+MWllWrRptJ2BX++t7m1Qb7Fpf25q54Af
 24TC3mxpSiA7swyjMEo4fgcx0RdNgnfW9uNRBOLpRdu4kVUQDWcSg3SzTnWS5znUdEocMXXTKZv
 SAOuY6gvR58aYpjqKhY1o15FriwTLjbCtBKXB1GDPC5ZOIosCOqKKH95EDmnLPAP+M8aOK1iXk2
 bqSaQcW/gtgyyspZOvljCkWx4Vzw/9pNBAG6uAVSgzIsBd6Jisle5ZaChJcAm+nKTe8ocoCaYnb
 mZ3g0nKV0yNkoaEMhfECLIzgmq+8BeehWAzf5LEog=
X-Received: by 2002:a4a:e844:0:b0:67e:36e9:79a6 with SMTP id
 006d021491bc7-69462e48a91mr11231222eaf.19.1776780619375; 
 Tue, 21 Apr 2026 07:10:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-694984114f5sm1248515eaf.7.2026.04.21.07.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:10:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 21 Apr 2026 09:09:35 -0500
Subject: [PATCH 2/5] configs: mediatek: mt8370_genio_510_evk: remove
 CONFIG_IDENT_STRING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mtk-configs-remove-ident-string-v1-2-66d5fc3d67be@baylibre.com>
References: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
In-Reply-To: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xLaxBFl/hMc1l+ZnAO8ez1aD8hEb5KlKqxW56+biuaw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp54Uuxq90XHhFcJVz8WRsPXGYRqjoRb58xoxOm
 qa36fyg/BmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeeFLhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AaTwH/Rx24TZ9TLmTT6PWe4fcm5xJoMKUy8JDjbduSuz
 uGQ8jL17tQ2DRpJyVJhpHKdiOenwePGIoIDmKAI30vLrDTWgkLVD5yOCK6HqNnZcpONiKoX6Nir
 w+IW8Yog0nBxJc0WUKFov5Hjw0U0Ye7d4l/tpq19V4pnl4nPMz2rFiU3KWZ7Edyi1an1a2Ooxh0
 6iJ7DUBDJaovL1PGY2jQ35avTnNzh1d7fc/pYp3fVN+CE1og0hgkJKt+bUM+EX5rkSAPKXLEpDd
 hc6gDt1fPt4A8N0Qj8RT/VboBlPKGiHYy5qOhBfCaleSUuyiodR0n97qHYajFb6DkQzCVkm+1wW
 5bGs=
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

Remove CONFIG_IDENT_STRING from the mt8370_genio_510_evk defconfig. This
makes it consistent with other mediatek defconfigs and frees the option
for use by downstream users. This only affects the version string
printed by U-Boot, so it doesn't have any functional impact.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8370_genio_510_evk_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/mt8370_genio_510_evk_defconfig b/configs/mt8370_genio_510_evk_defconfig
index e3530571cc4..2ddd8d2a36a 100644
--- a/configs/mt8370_genio_510_evk_defconfig
+++ b/configs/mt8370_genio_510_evk_defconfig
@@ -2,4 +2,3 @@
 
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8370-genio-510-evk"
 CONFIG_MTK_MEM_MAP_DDR_SIZE=0x100000000
-CONFIG_IDENT_STRING="mt8370-genio-510-evk"

-- 
2.43.0

