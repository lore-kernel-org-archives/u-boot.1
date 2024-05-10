Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AAAC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 12:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED56884B0;
	Fri, 10 May 2024 14:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=fancydomain.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=fancydomain.eu header.i=@fancydomain.eu header.b="W80Hi//G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1131088296; Fri, 10 May 2024 13:39:02 +0200 (CEST)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [IPv6:2a01:584:9::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1287E88131
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 13:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=fancydomain.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jasper@fancydomain.eu
From: jasper@fancydomain.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
 s=mail; t=1715341139;
 bh=1IZrh2ZRfBgPF4k/e5wALz8Y4VJQwIzC/FQevaIBabA=;
 h=From:To:Cc:Subject;
 b=W80Hi//Gjc5gmUp42JrpDaZLaCX3+gwMy4uIo6PBgUW9/Fr1kiyNJJFEGxSPk67T6
 HESXkp7Iio5zrMvAoJpyMGhlcik7oe+n5sGq228Ju7GAkMBrLUfyFs0Rnqhl7ve1CC
 ltWKmB8jWu9xIvZsWtLtAmqM+OKhyNCsMP9aEDJQu0gJ7MS1u/DtzUkifr+kpM6uqD
 fItcRAKFOR+EF6F/Zms5v7JNbRVkJ6pHwA1osjJ8fCRxGh+RmaOpqbB8aORgwDa0x2
 MpDGxmVax0psQzV87VzmIxL1A0bzcPWc7F4Mi0R45N5agTsG1CBHqVSVlCyi5WArYv
 Uc7iMyvxTV16w==
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, Jasper Orschulko <jasper@fancydomain.eu>,
 Michael Glembotzki <Michael.Glembotzki@iris-sensing.com>
Subject: [PATCH] env: Invert gd->env_valid for env_mmc_save
Date: Fri, 10 May 2024 13:38:34 +0200
Message-ID: <20240510113834.826783-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 May 2024 14:53:58 +0200
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

From: Jasper Orschulko <jasper@fancydomain.eu>

The A/B update strategy of the env's has a gap in the first 2 calls of saveenv.
The env's are stored twice on the first memory area if:
gd->env_valid == ENV_INVALID.

u-boot=> saveenv
Saving Environment to MMC... Writing to MMC(1)... OK
u-boot=> saveenv
Saving Environment to MMC... Writing to MMC(1)... OK  <-- !!!
u-boot=> saveenv
Saving Environment to MMC... Writing to redundant MMC(1)... OK
u-boot=> saveenv
Saving Environment to MMC... Writing to MMC(1)... OK

Signed-off-by: Michael Glembotzki <Michael.Glembotzki@iris-sensing.com>
Signed-off-by: Jasper Orschulko <jasper@fancydomain.eu>
---
 env/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/mmc.c b/env/mmc.c
index 7afb733e890..2bef30c973c 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -299,7 +299,7 @@ static int env_mmc_save(void)
 	ret = 0;
 
 	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
-		gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
+		gd->env_valid = gd->env_valid == ENV_VALID ? ENV_REDUND : ENV_VALID;
 
 fini:
 	fini_mmc_for_env(mmc);
-- 
2.45.0

