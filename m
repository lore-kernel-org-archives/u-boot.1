Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD108107BCD0
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 17:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB9B841D5;
	Fri, 13 Mar 2026 18:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JQ8uNbGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 470C384314; Fri, 13 Mar 2026 18:08:48 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F60183DA7
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 18:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-485409ab264so17305385e9.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773421725; x=1774026525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NFJ3tVUMUhuCFczRXw5NwuYqQRXv+upcISxEWtz6VbQ=;
 b=JQ8uNbGt5W+UnXPHq2miMU1Xo7tM5tkx/94GuZha1SLinSNlCunCaL6qCSyqMuVOoH
 4LcsQFHwhWhvd/gHol6kPhm7rqu/4o1IhBk4Rajjktpb4s4UfYWVbcNGNca8dSUShklU
 BhvJbr1g4gAUFWnfmM5O0YPn0Y9vpanWeJy1OPcYkWyXSSefqHPrSBwV6FqWgX+eKzDi
 quzU4OchD+pfZaPNlIXe+HwDOpcLH5xbeXtm77bPVob7K5bKp1FILW230Nx7eBlnkxbw
 lN4BdRyPA5qOYaBO54aG+3fo5vA75EASXHz89uRmiqpasHd1218EU0o0SS73DNqSrsfl
 vfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773421725; x=1774026525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFJ3tVUMUhuCFczRXw5NwuYqQRXv+upcISxEWtz6VbQ=;
 b=dWRDvyWvVI8O+QPmvwqC1v9XuRqzINaX5xp9ILK01PTwCAicKWtZyI+aYZKquIBzJ1
 8/LAYbl6R0yLbDR1lNd/AwdIn4Q+glCzgxX8lh/s3Ex7eIEe0ZIXgQ2dyK6cI2B3t+Nr
 Bg1uQNdfoWQh8KFaaA2ovlI5X6R5a+h5NnDVde+0LmuJeJEYEgpQJI4snPk8L5LUsjyQ
 Bb23ZRABW9uymMu3br4dJyu746OHcai6QyAzsUL3zJSi5xK1g0st1cLUK6+s/Q7pcp9S
 rdwMT3/y1haj1DtklrGpnJGlBAG5C3vaBT4O9GtA5uP9NGAQXBFlAdiTNYkDC37BFfj1
 0cPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7DkfdRLj82cu9NwaLPMCSzIDkBVuHXkziOU2yyWcXNjEdzECvJXe2urGhKcijyYCoabLCnR0=@lists.denx.de
X-Gm-Message-State: AOJu0YypZHTAWmCOJRNYuagt/ESQT2APtaPWeEkLP77zY+LweZBZcDk6
 BmM5gjDdfeYDvXptfS33+q+1T7waD4s4WfnVI5kO0wvZVqFAS7PIpC3k
X-Gm-Gg: ATEYQzxyGy4W6/SDilFExDIEuFq1zWuOW4GLS2i5liLqNwdSLfz8cAVOVdDFHQGq9ZX
 dUNuiQ4Jc6FH5o8+aDsf5anscHiDL6uujYfhPm2ImTKIekKdn8CycqMTSHc9TNEBcMrNBQKi0lx
 dr5NkUpYkjP0voIIHWMm1VQxR9aUcs45Bg/WM3jR2c084TMbm3fnMNzFDZH1n4TfmTjMjxuJpSQ
 fpgfTThtlK+Ws2R8gvDD20GbI9QFIN/jU0qw3SurIIAu94wieFM8/QuxEyszKi1ISsTCbHgL1Xz
 vc63gWZvu3JquAOXnd0L/VJCSX369mprZTh9gSWkGFuMSE8JBEc3wjVLaOf1PW2NuCT27cqG1D/
 ANmiSLJjpL2GGMtGuumaSdM/Y8yxEC41KFXLjaato7xKBwjhfkQQYWxrY3qQ9ixurjpxEM50Fos
 UdRfF7jauyxnZDiKqWwFjfZQkIzi9MgSn1OpZ65rCd1zMsHEvYla+Fg74NaA5hkYxPxUDH2ABZ8
 9MYBnKNlcyqX4jf7z4C8pO0KyyBlmUQWX7LeXgR42FmODn1v7haw+IgFhe4qH9rFfYjOOhgLG+k
 Ei9QF1alCfbWqsJfG99h1Y/x/9Cgg12bI2rX7Mp37V+9jMj1kDZj2qgOSOduJIadVTIpdYZqRjE
 2msPMjf06Sfm84sfYUkUcqA==
X-Received: by 2002:a05:600c:a016:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-48555b2c949mr58523355e9.12.1773421725248; 
 Fri, 13 Mar 2026 10:08:45 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4855725572csm55970165e9.2.2026.03.13.10.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 10:08:42 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Matthias Brugger <mbrugger@suse.com>,
 =?UTF-8?q?Filip=20Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>,
 u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] rpi: Update the naming for bcm2712 SoC RevD naming
Date: Fri, 13 Mar 2026 17:08:36 +0000
Message-ID: <20260313170839.2720191-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The downstream Raspberry Pi uses two namings for the revD
SoC device trees, both bcm2712d0-rpi-5-b and bcm2712-d-rpi-5-b
but it seems upstream has settled on just the later, so lets
use that as it's the name that maps both upstream and downstream.

Fixes: c15a7919725 ("board/raspberrypi: add bcm2712d0-rpi-5-b for Raspberry Pi 5")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 board/raspberrypi/rpi/rpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 7f69e5b6163..b0a1484c0fa 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -199,7 +199,7 @@ static const struct rpi_model rpi_models_new_scheme[] = {
 		"5 Model B",
 		FDTFILES(
 			[0] = DTB_DIR "bcm2712-rpi-5-b.dtb",
-			[1] = DTB_DIR "bcm2712d0-rpi-5-b.dtb"
+			[1] = DTB_DIR "bcm2712-d-rpi-5-b.dtb"
 		),
 		true,
 	},
-- 
2.53.0

