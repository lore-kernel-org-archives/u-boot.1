Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9D3F8FA80
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8C4841D6;
	Tue, 21 Apr 2026 16:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ny3YRmtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F220842EF; Tue, 21 Apr 2026 16:10:25 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D43283C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso4036991a34.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776780622; x=1777385422;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r81xcV4hvMi5ST/aBLbp2F+dFWUUEOBZxRl1qgPe8bs=;
 b=ny3YRmtPV6dmujE1pOwqtaG7yPTz5Q9t6XU6hNm6FEEFtK11JU2jc9nUrnEwfMADOA
 mn/7F1WbZloRvQFRDJ0X5twUNhyUxKCVqw8RODPTK9llloKlCe7ZwY/SLor4LMDUpnz6
 yMbWSBuJ6u2NoN25WFUBUbwqmTIr3C+knqUXh/3+L/VPpJEIwU7+EjaMYYo+5VmDbY5B
 oSDeSOrCJxwX9UL1U2mUcf62j3kYEP2M4V2fkogH5JsZmw+BurwUICu9wkt9p1YqeK3f
 zBwq05H2FFkBphLFootWEkYJwxbSZbuXFpdrf4qFaNnpixEZktaZwHfTjn7Txyz/cFYx
 5zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776780622; x=1777385422;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r81xcV4hvMi5ST/aBLbp2F+dFWUUEOBZxRl1qgPe8bs=;
 b=hAeQmZ5tSpkrrX8M4rj42wUQOXD0v8SlMIQkYAIsfgxIiTgsIrLb57WY3t9dGCf/Ql
 SzVLJJQ7iBltgfvDIriqaeOzX7VdlzAemyM5QXbzKDFTfwVuLc4WI6Mzw8G33Xw2aKX3
 m0F5TZZSKUPxvw16+Uy4QYNP53JgVgpFG/avzfzIKLhFcxRVnKZTnIkeIgOVEfiqBdDU
 L+/8nZye3PCJ/zbtDbtKizNB3TKSW/LWu2G0hnzPttbJIoCDXx1vlgqE4QYk8n6NmzOe
 LXDK1BkY7wpH7FwQkgvU3VuogTnDG+frqwHyxVpYu3KVgwRHPP0+XUAFRsqrneIYGLC6
 +eMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/r/KAauuQ06he5bznjM0kNFYO39R/taIvqvH5k2JMrayanD+ixpaB/aLhpD0VyUK30GPqwT9c=@lists.denx.de
X-Gm-Message-State: AOJu0YzZO+mBN0gSp9ohyYol0ukqcrOhny+aP/DmFHU10FxNQVvX2LQQ
 IGoIp5FFtik5Kln4bxXXc+UPa/T0OaBbjJWzW1RHpGJ9VVAEvkj7hHSt3OwwHCyisOw=
X-Gm-Gg: AeBDievgH8lpNwoMHWK7AqalmsSyPVI1R0wECeF23R6n1S1pJcUN8WOkGH4XHvv+yeY
 ngD5IpP4MKxpPtcKt9gy8IUK0eMKjEgkCJ37EeEAwwZOoGcMcLnlv/IJ6sphMZQg44Wfapt/d0S
 V92y0t+25FBVKK+3GIM7P6XQZDUoFMyqALPghH/Daeh69XLjHhnyxZus9SgriivEjfMk5iJ1JD1
 80m4ePzQ5ly0Xi+/6GZnGwrFrgxyuS/6wEyb5lStV2lXwz/GB4eQMF7Nxpc5H6bX8x8lAdaUnna
 vFw4qxVoNnNadTtiBuGRjwEskTOqwYfc/o4XdweowdIiyYb8UxmJLWq0IHBsj8z6DrXuftDEWZF
 UzKARTIKXXT8qMFMvKnDt976IfchmOJEW82KTmYrgFcB48PttLSQz1Uz+pMRdc9FO/rUFnq3EK7
 Ho1Yv5r+3IHl7WpEFa7OBAG45BQb3uvpcfVhdfTZ0=
X-Received: by 2002:a05:6820:1787:b0:694:9252:1992 with SMTP id
 006d021491bc7-69492521c97mr3014869eaf.0.1776780622039; 
 Tue, 21 Apr 2026 07:10:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-694984114f5sm1248515eaf.7.2026.04.21.07.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:10:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 21 Apr 2026 09:09:38 -0500
Subject: [PATCH 5/5] configs: mediatek: mt8395_genio_1200_evk_ufs: remove
 CONFIG_IDENT_STRING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mtk-configs-remove-ident-string-v1-5-66d5fc3d67be@baylibre.com>
References: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
In-Reply-To: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=+EkegjoDbky4Gb7mUrDri5MbA/HM1rXAHjRxJJozd20=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp54VCtHv5cSkpLcMCsafxqBlUuGxf0lGtOVucC
 iWEhxQ2TMeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeeFQhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmNcH/RCq6LJuuSYluBW7eWQskINV4ansoT4uTVk8AZo
 LzpDDMTXz2pS+WAfVKwcPi0iwUQ8cTGZi3VsStcvTf2AE0fFezl4oQkyKBcL+jWyJcT9hnOSWa/
 QDSuJl7EFh8iNHEe4xHXa1ZLgG3F6sQ5SPdiwBlgBN78ZUJBDbMOtaODldWfh4x3y6IcoT5Eymj
 Zsj3D6n0a+sxOyfl1mJr2NptvSwOpUS00v1TONLrscRsVlHv7kA1ju59XKnlR3RhGEqB+iyi3i8
 lNdROkZHf31YNl2S5VNCoM9jt/cPd3n/D8irLXxQa1VU/SF6P2bD9zdHgeqW6xJrCfBz3WiKM0t
 lPkA=
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

Remove CONFIG_IDENT_STRING from the mt8395_genio_1200_evk_ufs defconfig.
This makes it consistent with other mediatek defconfigs and frees the
option for use by downstream users. This only affects the version string
printed by U-Boot, so it doesn't have any functional impact.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8395_genio_1200_evk_ufs_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/mt8395_genio_1200_evk_ufs_defconfig b/configs/mt8395_genio_1200_evk_ufs_defconfig
index e927365a03a..525638f5800 100644
--- a/configs/mt8395_genio_1200_evk_ufs_defconfig
+++ b/configs/mt8395_genio_1200_evk_ufs_defconfig
@@ -1,7 +1,6 @@
 #include <configs/mt8195.config>
 
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk-ufs"
-CONFIG_IDENT_STRING=" mt8395-genio-1200-evk-ufs"
 CONFIG_CMD_UFS=y
 CONFIG_PHY=y
 CONFIG_SCSI=y

-- 
2.43.0

