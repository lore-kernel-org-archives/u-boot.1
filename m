Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC42E9D800
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 20:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1404D84148;
	Sun,  5 Apr 2026 22:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sgar1b1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2979083C5E; Sun,  5 Apr 2026 21:59:33 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DCB7807C0
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 21:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simons.philippe@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-66bb4d4fcb4so6282710a12.2
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775419171; x=1776023971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhWTMrpSUgrb26qZ5Fz0cwpV2ovz+mtA4pfgNor1d/0=;
 b=Sgar1b1XGPnOtneadxg6vir0vPoETPxpUT+HaPO5o/Cs5TXekt8dwNYq+GqT8iHpcH
 SGbBl1aYxBf76UQJWBd1OOv32JVXIWXDbn5Cepi1bgFZrYwZxDGjY3JPpHpf4g8HAaUI
 cZ6EKAuRgjoSeYBej8QzHMuLn7Uxr+hwTaaHj2Pzg/Fuuc/wQd2h9RzIHonh7ogBfknF
 kqQ4rM6S/8o6kSk0WzwKrmqvEvsO4DZQfFEJZehvfProfD4tOTKiR9B3gIVDhM/JhNeh
 HrKZOUGsxlRAW+3Yvhx3UD2oi/cCpMqWWFr4meSot9UZisnXwNIbbSbniPI8RX884pdC
 wGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775419171; x=1776023971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QhWTMrpSUgrb26qZ5Fz0cwpV2ovz+mtA4pfgNor1d/0=;
 b=SxeTGMFIjwcJ+MIjY44UFRPc6xsuZ8FXQXLc2jiQ8dwDTZvO7r1loalrLKo+zdjWia
 ZXEeYqT1z4dj4HcVSHcy3gfpvBfzR/Ky+6P+ajZXBHa2BugSSRs9ndzic9mY2YGrKYNL
 MUvMxJqCJ+Hx7zqHreLqqM1PKW84ahjpQlcTkvnn60TQgAfH2IKHQ+t6gKijsumbsvn/
 55Euc8jZQFcDbqZV7zkWbq/NEJX0YU+uc8BHlltrLGCg0DQd246Ubzlh5jPON9i0tHE/
 //7DXyasIEpWHoj7MEakBmZIAtA2KXqbAx78Er6vzLWLEgTSa1/sfZvDUsA75I/TSHi0
 14vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSlUcn6O3F4TvuoX12IAHX+MGNtaMEI+MZWVkGC5OdqJmPTWtH0MpykKsCtRa1djyUB4HLpHA=@lists.denx.de
X-Gm-Message-State: AOJu0YzbWuZ6JrxU6bBbWjkhHmgU/q9tk0n6E0fFFu+Ob8zNTP0NV3QT
 cqHB7ro2yIj8RrPbFY6GHIFa46rZ077R6OKMhgEaBfIw1X96EHdw3usa
X-Gm-Gg: AeBDieuMWLXXHY/D9uVkpLjcywd3UwA+LJ23ZjAMfMuoq7MtOjSd9deIYnBgVonIJK+
 YkWUMKRqoakHeCyXjEdFv1ZiiSxrRT85ohPshWdCQxay/SLOo8cwNnS5YDSbx3Q/Yt8TlB10e/C
 jCc8kg4VaK8D9yIltnD0+ubjAkFDdCxuggBuwce2Mqkee/zB3pSDrBCFBFEnVfXxSt9muy3a3mM
 n+h82YZFqg6iqh8UE6GTkYj7ZYRMHuBQRX/TfwZkYCNcmmtEbANmh+gVv1CVbXKaTomifOakPhF
 0Cn0fVdCH5khpM5h0O4G+Ls0tOQ7uGl5oXf+vIhL01fudO9ShtqrzuZswOydb1hQiG2jrDqufB3
 ghL0IhcSvcBVAk0G9kDtdgwoVL0G8wnsT1+qcAuPj64wWH+WeWLsry0+26o/23iCDtZ16m0fnti
 sx7z9vmKzMyzLe5ZLQrL4Hh8YORkbqu02rR52dCpUnmW/Oe05RQ9qxB5ifUTMf/ZKyCfYGD2o=
X-Received: by 2002:a17:907:e8d:b0:b9c:aba8:87d6 with SMTP id
 a640c23a62f3a-b9caba899d0mr210124866b.46.1775419170570; 
 Sun, 05 Apr 2026 12:59:30 -0700 (PDT)
Received: from bob-linux.lan (113.73-65-87.adsl-dyn.isp.belgacom.be.
 [87.65.73.113]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c97209csm421157066b.12.2026.04.05.12.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 12:59:29 -0700 (PDT)
From: Philippe Simons <simons.philippe@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Philippe Simons <simons.philippe@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 2/2] sunxi: fix DRAM_SUNXI_TPR6 default value
Date: Sun,  5 Apr 2026 21:59:27 +0200
Message-ID: <20260405195927.2837914-3-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405195927.2837914-1-simons.philippe@gmail.com>
References: <20260405195927.2837914-1-simons.philippe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Apr 2026 22:17:20 +0200
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

With LPDDR3 TPR6 parsing fix, adapt default DRAM_SUNXI_TPR6 value.
Also change LPDDR4 default value to 0x38 used by A523 boards.

Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e979ee4a2cc..a1ddc6a1fc8 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -144,7 +144,7 @@ config DRAM_SUNXI_TPR3
 
 config DRAM_SUNXI_TPR6
 	hex "DRAM TPR6 parameter"
-	default 0x3300c080
+	default 0x38c00080
 	help
 	  TPR6 value from vendor DRAM settings.
 
-- 
2.53.0

