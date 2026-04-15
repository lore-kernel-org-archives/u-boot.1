Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1BFF433C9
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 21:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 032AA8407E;
	Wed, 15 Apr 2026 23:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="NBmGDcZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25EF384119; Wed, 15 Apr 2026 23:37:41 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7032683B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 23:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-463f00cda04so3814325b6e.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776289057; x=1776893857;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G607aiDILTCA97m9rVwAbyxjWoAOpFrwK1210tXDBvg=;
 b=NBmGDcZZ6/01T91hhrZIvRndoYnmVbTZ1AcSLmWiS4Eu5fkuwCKRZXmxmHS6yGVC+C
 wqKASL06osSpW4ymdUD1ZHsFEgKvkic4bZMkMBk8lEEl9B1vP8B7hvfjXkRqeiU0mS1Q
 l/ob8PALgUnc5es12ZNpCZyoGL48iTnI+18GUixIi30ajQfEYkqxX1ZQZsei0dhLUpQ0
 CxZ71TdAWwpqXqYi6vloVZEX5SClkEEypenVrzm2z1ftP6vd+iPA9JbhJBGsqSZUT8pq
 hhMkxR2LKgDbMqPgLxBVWM6O82dXhGVcumyw75qTFpzjKUy2282+NdNcDffseM7bGh3n
 9gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776289057; x=1776893857;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G607aiDILTCA97m9rVwAbyxjWoAOpFrwK1210tXDBvg=;
 b=ljrzo4cJbL8ABOOpIZ+Ryc8dBl8DKsBRBxv9/tjpe4MdUEeAJ938PnjfAeAvO5NIdn
 dB7xFFdNl1udbHGC70e154nUxY5tIl4D2fKxwCIJNlPWufJUiVHzzysps84KKxO3alZ7
 Ha/VgaPDfa34N7JnOwx3eHjH7QHy5KJVh/T5Z/1F6RtVfmpzmo7rlLRNicNSBeCeOpM6
 kW0DnYlAxjwkW7H3jGIjcwJgeABuOgUIyvdyqGym4P06s0Fjfc0SlcMBdejU/jbxeizd
 FhKc9G5+SQMN3an78/IhZrLg2p7AvZR4xPo5lN0yG15o1sNS42YetYvFdQlEPide/+OQ
 um3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jxRNmfLhAPA4TQ5+9e9FDL4/0N35pLIh+TjfpoIFL0HBWMxTQS0czUZ4Q1TuiYIRiMTGma30=@lists.denx.de
X-Gm-Message-State: AOJu0YzT0vy0WtuUsgaVoDcgKcVzMgUuwPuSDsBr54SOxk+QnC78fj8Z
 7UzFSeixesTHKL8+CVP7UrYYTo1Pp5iqi0I1dq7apHJfbcNxJLu/pQ6xGpRhVtFbFEdvB/4Zf+9
 gn8CN
X-Gm-Gg: AeBDietwJb/yCNjm0W/nJiKUj8IBwuwOScoIDWXdZdgkP6SSumIGTq6k5dM14IpCUXj
 0MS6eYdn2hrEgzwrf4zRwHSFKyghqV6VimMxgqOk8IZBPt9txKAXgTXcnf2AT09+wyYJaReNL47
 g0/bu4DWYsm6chPdfQQG014JxWhdbt6mKKHSgd6xbeqdSAJsKIR764b/QDhGCRd/ezOEPpq1GyC
 0Qoc/3iCGHOA9aOktlHggMopSJpmR2l/TCq8GDMk9b175oX7di3M4CBZ/fQAXXf0TgafMdgtVij
 BLNWh0lAXA6IUrlcV6QAGbtAz42VArNpIULxX56g7ZyzUlgE4CIUFRRVbSGSmRKtTjuyG1ioCLW
 fyG+ncPjqQzz+09XnyLPi1lGrd0h0EkWKIbCKewORcuMtV9PhOp8Dk15AG8HPpWGSV/znp/0+jW
 tURiQikuQJqUgX8YI1w9kHtt6J+94L
X-Received: by 2002:a05:6808:ec5:b0:467:2a6e:adb3 with SMTP id
 5614622812f47-4789e722833mr11906312b6e.23.1776289057094; 
 Wed, 15 Apr 2026 14:37:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:5ab6:1e6d:2337:887c])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797b2046a3sm1503661b6e.2.2026.04.15.14.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 14:37:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 15 Apr 2026 16:37:27 -0500
Subject: [PATCH] lib/Kconfig: Fix SUPPORTS_FW_LOADER option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-lib-fix-supports_fw_loader-v1-1-3b27b4034981@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QrCMAxA4VcZuTbQVSfqq4iMbEs1MtaS7EcYe
 3frvPzgcFYwVmGDW7GC8iwmccgoDwW0LxqejNJlg3f+7E5lhb00GOSDNqUUdbQ6LHUfqWNFCv5
 CgfzRuSvkQVLO5T6/P/62qXlzO/6OsG1f7r31hn4AAAA=
X-Change-ID: 20260415-lib-fix-supports_fw_loader-af28afa23009
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Weijie Gao <weijie.gao@mediatek.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=m6jmfcoiyNhkuLxMZnk5IANkD9nV8QYPrz9rNhVwW5Y=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp4AUYiIhhG1+JgJA+wCAkzZmnnNU6WX21uSroO
 28cIWshmFCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeAFGBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AqAwH/1PI/FtgyBmt3G0cDPhNPJvciYk4FuRGDThBC5K
 wEWemuBSizZn0H/ks9rfjqTQo7pNzod2sPB3d12qhT7gOAJxv1j4dd2zBdy+sPWocRrM42zEgHz
 9aPHSWRFCio1BY/3pEO5Prk2lOsqKYn/u03kXTpCU1Fumu+bTdyMU2x/R40qzkB79o4VC6uOMD9
 g8Vo4qgdG4oHx0yjYhLBF1xzjIhiordBWsFYWStdExrww5cYqqPGPlDPMMQodsmpLKY8TbVrjkU
 KG3Kjcy0ARGdcRaJaXJJ0n9S1vCCskBTWh2a1p1UtNCdAg67FnZQ0ZPs6R7T7A9IbZLb5asmwZ4
 imX8=
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

Change the SUPPORTS_FW_LOADER option to be enabled by default.

This is a dependency-only option intended to be used like:
    depends on SUPPORTS_FW_LOADER

Instead of having to always remember to do both:
    depends on CMDLINE
    depends on ENV_SUPPORT

In order to actually work though, the option has to be enabled.

Reported-by: Weijie Gao <weijie.gao@mediatek.com>
Closes: https://lore.kernel.org/u-boot/20260410015311.4066075-1-weijie.gao@mediatek.com/
Fixes: 4ed440e6be80 ("fw_loader: Introduce SUPPORTS_FW_LOADER symbol")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
I tested this a bit by fiddling with a local .config. It had
CONFIG_SUPPORTS_FW_LOADER=y already because both dependencies
were met. Then I manually set CONFIG_CMDLINE=n which caused
CONFIG_SUPPORTS_FW_LOADER to disappear from the .config.
---
 lib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 4e6a0c6a1b6..0950b80ede5 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -72,7 +72,7 @@ config DYNAMIC_CRC_TABLE
 	  This can be helpful when reducing the size of the build image
 
 config SUPPORTS_FW_LOADER
-	bool
+	def_bool y
 	depends on CMDLINE
 	depends on ENV_SUPPORT
 

---
base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
change-id: 20260415-lib-fix-supports_fw_loader-af28afa23009

Best regards,
--  
David Lechner <dlechner@baylibre.com>

