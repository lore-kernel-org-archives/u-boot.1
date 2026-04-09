Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2FBF364B6
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 20:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A050184099;
	Thu,  9 Apr 2026 22:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="lO1tXv0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347898416F; Thu,  9 Apr 2026 22:31:58 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ACC484099
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 22:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4648447e29bso458119b6e.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 13:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775766711; x=1776371511;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tODcl6Cfc+F/p8BB84w7SUyFVpCiPB8V9FPXgl+qtV0=;
 b=lO1tXv0tJgBfFCih5fKuvh7nXJq3PT3A/UNPJzCV1lxeC5kZvhOvbCyBfiqYmI/oTJ
 u0x/AQoT3euxUSbrJm/zKNGIWWECcKNIhRGsLoEI2iHj6xirk5u4EVWgDhFiFRU80gsX
 rTpLLpREe10dnbXH+sPnfV3L2LClHvpUaBqmuTUw9kR8Wt4YUZ8ZVLhsURm2nSzPTJ92
 jj2A91aQxEMeEr88hTU+SF4FFapzTAyfMm4f79xDfIZeHMxab4bD1rmIyyc2iy4Sihpj
 m94k9zov/EgBJ4KVIUZ1PgMuKctHA8mNWDUlndzkgiTYcwcJcSyoFX+rFK/zq0uVFWNs
 1x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775766711; x=1776371511;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tODcl6Cfc+F/p8BB84w7SUyFVpCiPB8V9FPXgl+qtV0=;
 b=hm899H0AqPwPKaxJmP32vdZ4onC7GyuRCUZ4vvhIGpLw3cDv970gIKl5EG34y2i5po
 xT1+fiXl6bQlnPPN7rfqU0jE/wKqHnIe1GBDo94KuMEEpnLXQ5+gGYLJ7hFX9x2DK6Fz
 x2bbE/RuqxV/dW+BS2sU/84EDiunXyVAw4pN1tQVAtew1A5Nhcx+4V/rGXFmCbffIagI
 kj2Pj5WUmQMluljRodD4MdeLf4vJ8LMBsqjLfOtti01Hqf2jz2Yt52V3iMNsn9WFHMXv
 8FZn32JVwXRFeVeprFwcmEtAH1gsKZKbvRYEeIe2ACKB9hmWJGusXTr81B1D7g1SvXMu
 d2TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLkI5Q5z/qCeb6gnw0TjdP0psLCNC9tjN9i3HdinpPB4R7M1m/jbw3ye5EdMOuhS7kB9n0Oqo=@lists.denx.de
X-Gm-Message-State: AOJu0YzHwG4slF7xrl4IooH8LOLUChHOAkHBpWOS673qbZkO1Y6NskoR
 eAtSL2XmOmRkSUUmpJMZ8KqyJKtRcZ2uUjWeuYoJa1o0xGiYCyZRMp/GmfZr+d1bJd8=
X-Gm-Gg: AeBDievj3bS5IoE/mrPMND2Deb4XA231ZHkLg48GfcYo8TziLoGNwyisVlz0i2Z6jS0
 ujRrXJlUyOUMQ3RMdoigOIa+1BxBYgDL9QaZPzb7D3SPx5sSWzrB3p3g3OId5P2RsJSU0UCPe2M
 bYGF77HTg9bV70GgSFueExyw/Q0c7HW6+CkgXGzBstXQ9r1sd1dTDJlrwUNtDdYv0O/MAa8HgzR
 adVL6oYJFAuAKC/RuxS5TRLW/g2d48Cko46g8whVu50fWN3/Aec/mmdzwJisG2Kx0r3yyCR4vRN
 t4fjngyFDVJq7H+dOuFhaNbtYXyJ98w4g7gDWzKD3dzq9PwcOcB3r+FC2aMXKprBTMO63FP/UZ4
 TJufiHqYY4+rrCxkzNC0UZMcUQ4rk6kQG0ZnPxGd93uUA8dVgtMzxXpVChVx6VKm7HRHhMLDkLB
 GaJIGC4jObL3o7cEOio0XQc3sTZuCF
X-Received: by 2002:a05:6808:1510:b0:45f:2788:afe2 with SMTP id
 5614622812f47-4789d04b9c4mr390436b6e.20.1775766710730; 
 Thu, 09 Apr 2026 13:31:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a101b75esm293075b6e.6.2026.04.09.13.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 13:31:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 09 Apr 2026 15:30:33 -0500
Subject: [PATCH v2 1/8] power: pmic: mtk-pwrap: fix file description
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mtk-pmic-fixes-v2-1-73e83aa6345b@baylibre.com>
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=742; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=oqrorGH6SZ+DKSDXwnUpdRbF48QvFe374dv+AtmKr2o=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp2Ax9HychH/uyZrZH2fgeytk7fQSB1VMvs66Xt
 oHuwLfBDoyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadgMfRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A43EIAIiawKeVkid7EVRowlz6yerkj6Mf0zSzZJ4EBpl
 ecNYRIlPuPAMtR999HRzPM+OAod79KmN2WSh21SczSvRwkvoapKjcsNDZR2YUQc+8sfAjJ1TgGx
 MyTX9lcQpt24E+INiLPpp7y2I+HKrPsPpRryOPE2yQmJ8hdRWCNo8BX367h32qqrbTOYWwuAbh9
 63bsoFZ1jaSLaAWCkFLEDeyL/PwMZqVcsolHbJLZfCBZDm770gcdAboxJgrWqEwa3fPeC/b75O6
 CNqPtaXT5NqR4V9mTNOevkQBm9XPUyeVLzTCFWQ7Xb6uoOrWt9uCiNrPpQ0c+Uc3GQBBNvnaqKx
 Gslo=
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

Fix the comment at the start of the file to accurately describe what
this file does. The old description was likely copied from the related
regulator driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 3e3a691d9e8..f4dfb48e93b 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * MT6357 regulator driver
+ * MediaTek PMIC Wrapper driver
  *
  * Copyright (c) 2026 BayLibre, SAS.
  * Author: Julien Masson <jmasson@baylibre.com>

-- 
2.43.0

