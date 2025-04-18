Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2D1C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 17:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 911A582A81;
	Fri, 18 Apr 2025 19:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hW8+BYpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D3383212; Fri, 18 Apr 2025 19:49:46 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A52880584
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 19:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-54acc04516fso2220597e87.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744998583; x=1745603383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+92F8SLhc7OxPaIhdvKwOiLDi5EOaaWRepKchXN02R4=;
 b=hW8+BYpvOOy0NgYH1/gHBLRIQe3Fy2XGRZ9GrmfkDDz26YRpgIGSrYrcKeP2TfaoI+
 levGbrqp2Vo7xCeWJRfZH6tUWh5HsdbbxkSqSS69oCvZKPON8R159clJcGnV//CE2GS9
 LkhgdCbCz/NArIswdJ8R2TAu3RioS420XksjpDJ2iPWI4/x8kB69ctvLc9j8PwIjNdXM
 vID62vbWzwOAK3lcBG9Lio2HrAHjzSBXggwvXzO/awbt9LnU0vEQRDRJG9unoHzSxZCF
 h9IG30eLnCz8axGL7rrPMf0urxWIWna8FK46PrwX30DKxA0sKVPl20/bXC/hgl2eeTYX
 0ZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744998583; x=1745603383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+92F8SLhc7OxPaIhdvKwOiLDi5EOaaWRepKchXN02R4=;
 b=NUDTZ/kGzBIGjlkvPqNGN9Q2frQ75JMil/PRDOccccky7KFpeIw9uiKQgq0YRE6nmz
 xOl4fs0MIb0mpRiZ1IDbcREuVqgPkxl5HlNiY2+vwPvKisrOLRR0oJDUZnSY48Jwacbz
 gNcPMnnXHeYmT8OpJVf0wOq4L3VwEqCF33Gbe/iUNsP09cwy1H4F9uebEkiiNpHFPu+N
 xeSuZ+Rxr7bPqdvb63pyCN1GH/JPFcQfY9E5r5jwbkrIjbNthz0r+b/6Oxx9ppHylAyk
 gJwzX+e1jM1SSRkRm/+UKJJprcsEZwY1WDfOztM/Lvoom5iLxx1XFK58Sn4BwqB7xyIk
 SgWw==
X-Gm-Message-State: AOJu0YyZX1Uuf7t6neCafBpD4IonZ1vM7vs4Ox+oZbF+RCZztUrxCkI7
 wzeyQm1sUctj9IhG3PGwFKU1ombbAPfpHENJIcRe8kiDyocn0Mbf8omdHw==
X-Gm-Gg: ASbGncuTCJ4ju7FZ4tkypH4G95TS76nhI930GFnxBdNpDxB6L9cU55KcubeReeXc8Hu
 71NtcQmOzg+xVU8PamGbqr2QMZ5lyFqYCoA3gdjQOXgNpn89f2qxLT/ROWcylPT3nhiN7u4IQSr
 zph7GmRcKLW2Gw0PrqcGQB1Xma/nqNAJfX4Ps/pWHIYSLu9WC8SFBr7Mi2Q9quopvMAaNSy0S3J
 IdXygfz/dVaVGw6A6NyLJZNisFmPpoB6eTVVdGRGcCUO+Kg1fveC/AZa3QxLMXG7Oqk22tqKEeZ
 zRtgbHazoN742BDkuTKOqzgsMODk9XWhzWnQY6mXs25U5my8tqYGUY0CfcM+it5YhOk60xykY/Y
 +hzZdb/MM
X-Google-Smtp-Source: AGHT+IFkBZA2pQXUEPkLyBKLNa+Sy7cV+7Wt1rTAU/1+u/gsz2ez0rehIzUjsG5fSaayF98k5ggPHA==
X-Received: by 2002:a05:6512:3b1f:b0:54b:117c:118a with SMTP id
 2adb3069b0e04-54d6e66ca29mr1087191e87.55.1744998583415; 
 Fri, 18 Apr 2025 10:49:43 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d6e5f617csm242563e87.233.2025.04.18.10.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 10:49:42 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] tools: Fix potential memory leak in aisimage.c
Date: Fri, 18 Apr 2025 20:49:39 +0300
Message-Id: <20250418174939.180817-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Maks Mishin <maks.mishinFZ@gmail.com>

The 'line' variable is dynamically allocated by getline() function
during config file parsing but wasn't being freed before function
exit, causing memory leak. This was detected by static analysis.

Add missing free() call before closing the file descriptor to
prevent memory leak.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 tools/aisimage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/aisimage.c b/tools/aisimage.c
index b8b3ee32..6091c8d5 100644
--- a/tools/aisimage.c
+++ b/tools/aisimage.c
@@ -346,6 +346,7 @@ static int aisimage_generate(struct image_tool_params *params,
 		}
 
 	}
+	free(line);
 	fclose(fd);
 
 	aishdr = ais_copy_image(params, aishdr);
-- 
2.34.1
