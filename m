Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48601D111A7
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 22:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9328283A71;
	Wed, 26 Nov 2025 23:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n/9SBHsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45ABE83A26; Wed, 26 Nov 2025 21:26:41 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 984AF839D9
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 21:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477632d9326so580045e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764188798; x=1764793598;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z4tllX3Ennj4cqPQBh1fYk9XK+ezqKmIRpVe9HehXHo=;
 b=n/9SBHsO+nC6rrSjLtr8krl1qYFPDZ2mwUqtCU+kvkrt/GKktK4gqoXpYMsYiSIZq8
 fzGUzt3/n1Rky7DBJrlolw4XOfXAx1HMBVaFfU8YVxr3I2QXBuPlfaWOIuLIkS4mf/uV
 +fYVvYhDTOh0ijeoorPQ6dNdZxHez0zAUjkPaH7ZCa/hiW5WQW+TuFNWnQpnQRI0Gdq0
 e9WTi/yCdq55xHwBXrsGa8wUSsCXNqVgriHkqtedcfT0YYcThnyl9iOVTubORgaaSsk5
 Qc2fvsV2us0ws3KNIM2J/w+ZFn/mt74/8zrcP4tEZA5wJ1S+1A7VRR+IwT33zL2fGa7a
 FR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188798; x=1764793598;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4tllX3Ennj4cqPQBh1fYk9XK+ezqKmIRpVe9HehXHo=;
 b=ED9mxDqRSYVU+hSZ/aGiqJCYEKCGOyIEvLeQ1XipVHL9GP8lvH+ifr7u1PltnBrXIz
 bTPhEiIedS9m0p1lpPZRtnVYMR7JZY7Cb8elc/1FvIWnTJneV5ooEBJPTsINwoCm+iOm
 jGYlJBfedSeXM4S3kH9EkestuqB4KfDHCwOIA754JGqqNW94nPowk46TjYTGS+AXk4CN
 6usOTIv1NXdPTJFU0Es20IAq95YSuuFaEG958M6vuzfZhrxlbxEZ7RCBKOrfHtn2ZK33
 3GeDk2PIw3u2W6b0Y0RUwDQSgswOWKhPenpmjybFKYt8YZ02XnfPKHC1eap0eJNHL8yQ
 sw6Q==
X-Gm-Message-State: AOJu0YxyHe49AZ+/OkVe+INyj52leywe6XcT3EdzAzXlyruQ1Js/F5zm
 VKOOLqLA0J1EvhuQuhfucQeZfZwibGUG0gaqbjmGFlM0u4tl6bXYC7jeA9zs1AfoNpQ=
X-Gm-Gg: ASbGncvW7ed9rTo2HoOifFo64mLmbOo80DGRmAVNZiRwT0f5ouREfv19lP4GqdJsTgU
 2+6JvuX2PW3pYQzYXYdsWJ9Hai/up+f1PSbkDx/9a3GYYLhTOBB+Kl78r4dGnhTQcRsWXGzoSO4
 q32EB8XhZi7J26xHcWks3kFiRIaSL2+IPw90kCRtbwLLHudcpfKgJniDT6BSS1mRru5vXgSmYI7
 BxzMb3bnL1v8BjUcfIenwJKs5SOvfhXiYwgaxzJ+MdDb1HwLfvLRk7iyG8B41KR7vNwLOaYh832
 fTeLqunFM1FIEIBw7txIOpaDStrLWqSSLx5WyQrZjcSd53l2SmEJAks1eGpzum1kGUY1cdxInSD
 C5bAccUaVhK1OERQK8eey/8BD3tr/d8NfP4cWptbSTLjY2yCBkQ+iQIDf2q+Hsj8Kwzw9LrFVFv
 Af+J5ZQn91TtHRyiDYmQ==
X-Google-Smtp-Source: AGHT+IGHfibpoQXzwvtFkK1LauvzrkTDzV5cFbwfDL4FlX4Tg/SCae3VXLCwCYsCO0zUz4YgjyDnOg==
X-Received: by 2002:a05:600c:46cc:b0:477:7b16:5fb1 with SMTP id
 5b1f17b1804b1-477c0174856mr208098925e9.7.1764188797544; 
 Wed, 26 Nov 2025 12:26:37 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-479040b5c53sm53870925e9.2.2025.11.26.12.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 12:26:37 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 26 Nov 2025 21:25:56 +0100
Subject: [PATCH] configs: am335x_hs_evm_spi_defconfig: Remove duplicate symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-topic-am33-hs-evm-remove-duplicate-v2026-01-v1-1-5008cdb30536@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFNiJ2kC/x2NQQqDMBQFryJ/3QcmUSu9SukiJL/1Q2NCYoMg3
 t3Q5cAwc1DhLFzo0R2UuUqRuDZQt47cYtcPQ3xj0r0eldIjtpjEwQZjsBRwDcgcYmX4X/qKsxu
 jNnlCr8B2mP1g5rt1E7ViyvyW/X97vs7zAupef6d9AAAA
X-Change-ID: 20251125-topic-am33-hs-evm-remove-duplicate-v2026-01-ea48d4387ac6
To: u-boot@lists.denx.de
Cc: "Andrew F. Davis" <afd@ti.com>, Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=872; i=msp@baylibre.com;
 h=from:subject:message-id; bh=TryTJ5RMHKzQayQIE8pEkCICteG0gROhcaCfxRJ2L5U=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkz1pFxL0T18Ts99T//YkXaxJjB9H+/h6zsl8woWJ7zYv
 jJtyewpHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRLwsZ/sq9PGbVuHXlKo+k
 Gwt09zxveK+qodq9c8Ol7of/fqp+aGtl+B90w1RAS9JCcm/c7Pf8U2f/frXi5+wJyn8WeDkm/m+
 8sJ0LAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 26 Nov 2025 23:50:13 +0100
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

Remove symbols already present in the included file.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am335x_hs_evm_spi_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/configs/am335x_hs_evm_spi_defconfig b/configs/am335x_hs_evm_spi_defconfig
index df009844defad13109adf2523580181b6ed6b5ca..ad1777f2bcb45bd2c8424011adc231f0e7d4ceee 100644
--- a/configs/am335x_hs_evm_spi_defconfig
+++ b/configs/am335x_hs_evm_spi_defconfig
@@ -1,8 +1,5 @@
 #include <configs/am335x_hs_evm_defconfig>
 
-CONFIG_ARM=y
-CONFIG_ARCH_OMAP2PLUS=y
-
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI_SUPPORT=y
 

---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251125-topic-am33-hs-evm-remove-duplicate-v2026-01-ea48d4387ac6

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

