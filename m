Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B96CEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C161083FC0;
	Tue, 18 Nov 2025 19:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nnc9JYOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4C783FB5; Tue, 18 Nov 2025 19:04:35 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C28C83CB9
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3ec5df386acso808295fac.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489072; x=1764093872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZH8bq6nCOm5AQJzjgbWum/PbNVqxki6R23YylkbjedE=;
 b=Nnc9JYOfKS5wIf3QyUtEMzYaUL04FD4Glikw23J/QNRTVXlYMJug9kfy13wkaqa4/A
 yKcRwN0BycBRFCfhZUXFzNa1P+Ju67mikRfHV3ULPG4TIsDFf9R33BZotocu9uCNQzkV
 fmFXGZ5ZFBDE7FaovWvVq0i9Gx/Uj5u5HvA8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489072; x=1764093872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZH8bq6nCOm5AQJzjgbWum/PbNVqxki6R23YylkbjedE=;
 b=t8qBtlTrmVUoXwKSVHKuvNMe8GJUqtxNfw2rVUXNNDWkQU2BdhedP2sbw/6BMVmoo6
 p2P2zzutXCh8Y9ISx8ZK9KaxlmKcalTAPjP8zZfWcA/RkzFEwrEpUvilcUafPuK7y2b0
 mLnKhzX2tjAUacj6W6SLpy8Q7oRKJBvNbPuKXQWoR+/3oL58thxhpKyVICbYLa3yjO4g
 6x6reSXJLsg1NHOmYv3r8R2fbsJ4dPzwnA+3WWwTuDUME+rmnT3HTs4mm9QQU82boiIX
 JlNAbgaRxsQe48D9pp+xXA95nXSvzxq/CqBRwKIQV7fyrjKyu3IBDi+6pXcyre6t67JH
 S/LA==
X-Gm-Message-State: AOJu0YxZNTOoenWuBx2lvCzPD2FLRobcpHe8BLyEALVUoCh52/1hilhZ
 vza6lVIwW5fu2QirlmJceDq6WHbp+rDd/WtvZZKf2nFhhmR0t1goVFc+iFzn6NIcCBFHHH7kUua
 1SAmJoJbfsQ==
X-Gm-Gg: ASbGncsVEayKgr8fdvHYPhPcMMBglDdklL4PGQK8VjvOo3AlJ4MHBMvCdDXtJJ67Hy5
 BIAYg3wtKmLkB+PstLT2WhHxS/Xhtj/kcCyWyp5iRG9HF/DAvnwGktbQ9Ff6AP6Od8MtQsJq6Zx
 rV2lT56uaZ23phKEI080Hh53utyOeEAHYR3gWWipwrD0CsN1uXInvsi9VEodVf1tb+ReCnKXWjK
 FwuGo0Xiu5Y+tWGC0aHZLBYUfnRfEOYZySDfosSFiIqRj4TYJbb4nuGRa8JHzCr0FViGYRN8W5d
 7rI2CcYWmHJagI35D80u4romxlu/FXtRJyW0w1UAsAwjCTF8Xc1tMvsSvegAVwgCaDgXSpWCuCx
 1e1m6r91Mb2vWgn+JBjBazUZcd1QUZxD5UA5lWlmlG5AI0J1u8X2rz+P/BnvCg3+c/YWg89IE+I
 em01ewverOdYaESkj+UeSli3cNl7UvSPcvo8U5Jw07cvAQS1RLoECLY964jRhnF3Y=
X-Google-Smtp-Source: AGHT+IG+EfFtm2JtIMCSPcVGcz4NeZ+1g2o7neZVB73mux2NoBtyVXyh8p8WORP+ScdLWLUfCZOFCA==
X-Received: by 2002:a05:6871:5826:b0:3ec:3e53:aa30 with SMTP id
 586e51a60fabf-3ec3e53ac4cmr4024587fac.24.1763489071968; 
 Tue, 18 Nov 2025 10:04:31 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522637e2sm1235298fac.12.2025.11.18.10.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Richard Hu <richard.hu@technexion.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] pico-imx6ul: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:30 -0600
Message-ID: <20251118180430.591450-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Richard Hu <richard.hu@technexion.com>
Cc: Fabio Estevam <festevam@gmail.com>
---
 include/configs/pico-imx6ul.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/pico-imx6ul.h b/include/configs/pico-imx6ul.h
index 37f4c7d8a098..21a536f9fe90 100644
--- a/include/configs/pico-imx6ul.h
+++ b/include/configs/pico-imx6ul.h
@@ -45,7 +45,6 @@
 	"image=zImage\0" \
 	"splashpos=m,m\0" \
 	"console=ttymxc5\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	"videomode=video=ctfb:x:800,y:480,depth:24,mode:0,pclk:30000,le:46,ri:210,up:22,lo:23,hs:20,vs:10,sync:0,vmode:0\0" \
-- 
2.43.0

