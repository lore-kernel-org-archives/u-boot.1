Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE93BCCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 20:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74CDB835C6;
	Tue, 21 Oct 2025 22:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aJdUdpbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFEBD807C0; Tue, 21 Oct 2025 22:37:06 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C6C807C0
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 22:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c28f5cf0fbso1284607a34.0
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761079023; x=1761683823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=w1p92grS+fKR6x9S4DwD66q1H+CSrALpFTX/4XcVWF4=;
 b=aJdUdpbeA5XcEt+KiHCHt4URAazQby6YoSz5bX+S9412MiJjwJWTcKJkGK5+LmpWA6
 uWkv2hoI/9vbyu0uCRfsx8P5s2BGvt9PsW08xOLo4aLx520ag5+9n+7EL/MofS9/mp+z
 O8eP3byIBq3pVD88DQLwK6Y1GwglyQjl0pNiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079023; x=1761683823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w1p92grS+fKR6x9S4DwD66q1H+CSrALpFTX/4XcVWF4=;
 b=RByuVWwVuQdWmDcodJ06gSeJ0ffracGlLzQBAEc0k130XNjdUyC2u0MHc8RBtXbGg8
 n5Po/mttyBjv1RUKgIpjbTHmEBCte7JCNP/ekMEkyuBt4Ip5/FM0I7nFaG82dWXOVf8P
 A8xdwtsaFqbPqegqDsEfNVJrLmS/Yg7OyDwlI4PlwjmevWnG0l38eKj18ycTmmOxib6m
 iSAcr7VZ7Kx9ACJ1FtzCYxAOR7TBlO2TighiUSsq8c8LEgo8OGs8IDuWs2rGLUru5MnQ
 HCBnAMuPDEPI7SKPeNKErmDQjqil4SeXK5d259XAEI4PYLBmcUaja8xf0ak48jPXj8xV
 hbpQ==
X-Gm-Message-State: AOJu0YzUtSaKuO8I0mS3Ao1hDSSg5QiPMwVeon4qk4Sr0IohucOoHtJY
 hrmwU+PkBOQlfXcj+bRiOI0VlidLl/Mykn1IJvCF7bM/ewQPSmNt9sZWbrfrFVYTgVNH2mpLXNq
 Yz5w784cQlg==
X-Gm-Gg: ASbGnctFjeGsu3TXGdz4r0vmtlncr2BMdTa1A014YgFm4d4iX8I3HUH07izJkrntvdj
 tbo+trrEcoDpXdpA43O/V/SfvFit8hn0iO85Mf6Gm3/4qXWLAKWIsSQ9+y4PyD+otWRzunv1uej
 YlbIJDDXH1Tvn9XaA4uN8q7HF7ESvZjZ0Yzpam+gIRboaW5AMTGnE57LER/Mc6QDX6wovqYbjhh
 2pIeQ9t2vmIxgfoEZRbR+Yj05fxjT+hT0yf7t4FJorTnghuXb0C5ls7BAK6KNd3kXqb1Fsc2Kdo
 DxyRxxsRsdPvhy5btSwdSgEPNjd77p8dCJ4RYlIjtbNGsLi9CjE4sk+oUmRXwvegC6k7STxmIK5
 s03j8nCvTSi/L+5Lb18+KPXtMKy0NXxlesNCnN3c1nItLpp2FCm4ToHy5Lg3WFNQr513/CVnLT/
 UM70HcF6Jv/b2K9uUSkZfi1r2WpHdRAWYRKztr9cqiOnGyNeqfZxq5
X-Google-Smtp-Source: AGHT+IF+0IHLUEyjnlt8opiux4zUvtt9jsbeLXWftpoiKAhRLHMKrutpig/ar3ZDEkwRNM1PtrgKxA==
X-Received: by 2002:a05:6808:880c:b0:443:ea34:4018 with SMTP id
 5614622812f47-443ea4388b0mr5072571b6e.12.1761079023335; 
 Tue, 21 Oct 2025 13:37:03 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c28879e8e2sm4039711a34.3.2025.10.21.13.37.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 13:37:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] env: fat, ubi: Fix gd->env_valid for the first write
Date: Tue, 21 Oct 2025 14:37:01 -0600
Message-ID: <20251021203701.1274692-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

As resolved and explained in detail in commit e589d5822cac ("env: spi:
Fix gd->env_valid for the first write") and archived discussion there is
a corner case where we don't do the right thing with redundant
environments. This same exact check was present in the mmc code and
resolved with commit 813a0df27a8a ("env: Invert gd->env_valid for
env_mmc_save") and in the discussion of that patch, I noted that both
fat and ubi (and at the time, sf) were doing the same thing. Take the
time now to correct fat and ubi environment.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 env/fat.c | 2 +-
 env/ubi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/env/fat.c b/env/fat.c
index 58c279ff7690..7e1648223838 100644
--- a/env/fat.c
+++ b/env/fat.c
@@ -104,7 +104,7 @@ static int env_fat_save(void)
 	}
 
 #ifdef CONFIG_ENV_REDUNDANT
-	gd->env_valid = (gd->env_valid == ENV_REDUND) ? ENV_VALID : ENV_REDUND;
+	gd->env_valid = gd->env_valid == ENV_VALID ? ENV_REDUND : ENV_VALID;
 #endif
 
 	return 0;
diff --git a/env/ubi.c b/env/ubi.c
index f424b1a16e85..59bd96feb488 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -72,7 +72,7 @@ static int env_ubi_save(void)
 
 	puts("done\n");
 
-	gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
+	gd->env_valid = gd->env_valid == ENV_VALID ? ENV_REDUND : ENV_VALID;
 
 	return 0;
 }
-- 
2.43.0

