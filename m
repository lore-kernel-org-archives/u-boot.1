Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01208C369CF
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 08:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5233C82EC6;
	Fri, 18 Apr 2025 10:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OrcqT1da";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 761DA831C2; Fri, 18 Apr 2025 10:20:13 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 718A08312E
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-549967c72bcso1893450e87.3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744964410; x=1745569210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34Hw3bzEiawNOSPh2HA94AwMnzwrVdOGcJeC3XEkMqs=;
 b=OrcqT1daRl1ehRLqPixHKm+A7Qx6AMPPHx1mGaZ5OM7R8IHq8lCWJb93aFjgGMngLH
 +Ds4REnNzZOLoLopMUdBz01V1Z2A94Dah0cQMZqOneZU+rS0Ddfi/PG3f1df+OAgE1Di
 BvEBPK/9hL7DqvSWz3TC3cjKIatjbnxNxIPXHM2pnaLSDjFKuTtZf1o3mK9blsQsRrU0
 nwwijlVESZMPMUca1yGs3S6008DJDKrTZbxsLiCkwA66ucMXp3+MLt4TO7EGp5y7fL3g
 3y9J/S09tpbu46YBIo9pyU8OngGb9t2IAsQP38050uhHlIxxYwmmdLkVZfPb1aNduLCA
 yoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744964410; x=1745569210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34Hw3bzEiawNOSPh2HA94AwMnzwrVdOGcJeC3XEkMqs=;
 b=ILvWXbrpTLx1ZRdrygudCxEaaKLbytVFvpdMI8KpCT/vjg5xXEA4hPCk3WkUFok6Tq
 Jw6hqpLRVfhZCMETrcLF8iqQmFubXYDluW4ULDLLXPlTARHDz5/gqiKQNzj7Vgz+p0Ar
 NpJCXRTwdRzFF6bB/SEzhC5q5OKNxAlH+rk3ugYCad01aoLBa1z2DGGbtyo3I1k9CIA2
 s/xDIhTUDvp4FbDXTK+rCsE3enqbvRUUD+fQFRY49TmgJ6sRypPZJ9bM6vp8fbnCBV5c
 4pTzmlQAEF4lcywJDChWzBMzWnjQp4iO23D62HtpjHqWmaAPEbCtSmqOZserPR3FcJOu
 IAGg==
X-Gm-Message-State: AOJu0YxK/mKc6domR2hB1+khfkDQo9n/f7TzR9RKQgx86R+CEJ7URsx1
 KrKpOnDGIj1+wTH8q5cppCOXJ2lmaHHM83fGBxC7Zhb2NBNtuaDA5Aam6g==
X-Gm-Gg: ASbGnctWSic73nsTnNtL1baR1Bur4knkMbq0yMua+FEfIAvMfaOsJmvKqJyPq8EkEWl
 wwLqUxauZ9yElFuNM0m7gVmr1H8ujKQEQ7xdmlVya3MZdMYQ3wc+kP2WTBMz8HcEnlsrK65IGnl
 qvRnw1SMxnD2iM1pHdLDem0tlYsMIK4uYNezcX1VVwY8paWr4w8r6/VggxAlRFQMZk8Pq1rzOft
 cg3QREynKdwb2D9BQk/2NqMThGCrKTcjtUJh4sgHeydSNibWnl3LRx3mn9Hd758hefxorVJJE4H
 4OJkiUe/GfC723uobZYaH7z/C2JE09SgP7IpMV+yBwHXE3aZFdfcBaiMEUCacEIxM+5Hts6mXQd
 Y9E7t0IBp
X-Google-Smtp-Source: AGHT+IG4YA8UyDcBLo283DdFEBo20OFWU7WiRXxCpIM+Z0pofiOv2fECmAo/pO71WDgGknF83KJbxQ==
X-Received: by 2002:a05:6512:1116:b0:54b:1055:f4b2 with SMTP id
 2adb3069b0e04-54d6e566c6bmr510006e87.0.1744964410210; 
 Fri, 18 Apr 2025 01:20:10 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d6e5cfd4fsm128795e87.114.2025.04.18.01.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 01:20:09 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: Fix potential memory leak in aisimage.c
Date: Fri, 18 Apr 2025 11:19:57 +0300
Message-Id: <20250418081958.12818-3-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
References: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
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

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
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
