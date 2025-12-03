Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83049D1BDDD
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 20:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DCB283BF4;
	Wed,  3 Dec 2025 21:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="acexgIlZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB9883C08; Wed,  3 Dec 2025 21:46:51 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130C983BF1
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 21:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4ee28771052so258161cf.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 12:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764794802; x=1765399602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GX4fdbQNybkVgtiYDfEDX2IoalG6xl/5e+0tQogMxiI=;
 b=acexgIlZuiEQ4nHF3c+YB2VvvtDZNV9Ud1RFuPlFLAog3/HQcIzd//SPyfOciAgUy5
 Ta5jK4ouIjsR5w5WgJ+VN9QVnq7GLQ0nrtl+uEe2wm4WdwHwWS35VDHZS7Zy4R7mDmWV
 dEmBhsMTTPnmHMOSpfjN5oHJ0QYhu9qUdvkdPI8i+0JfNeHtVOqS33af25tTIN5A/xmU
 iZEZ6avYee+0AceKunc3hfy/jg6sMMijZ8zRDt3eMPTRPLI3R4drdhcinT7w3aKXN+F1
 QEbCv5CVsG6lNUp6ALmeh8u7zxNsy3WQ5E0kwjgA4UPR9r81UmOxgP+gkRjIBLw+iw10
 vbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764794802; x=1765399602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GX4fdbQNybkVgtiYDfEDX2IoalG6xl/5e+0tQogMxiI=;
 b=tt7eLOonrfJigfu7qvR8ySI7SCyT+OTKeBAw14ESZyWyv8EVZCJt5R6de/a/bLNwKq
 IgyVVLSUijMPHAcT9clADQDqyX/H2AQXxakgzna1EdLbNV/4cZl1222ezRdjN4/dwpy8
 6l9fFM0/g9RNd+ElL0+96IEvyVD54zyWNovmjBZir6pv/c7gCKdGkqQOjIzj8UX7tGl+
 AbmWJ0Pxm5BDImGp7qSWq7HuhjChdBLIzRoBlJjlrCAFb/x4d50hPH4BYfhyKr6VxdLE
 0GgYzn5/y0neWEASMByvGd3RAgRPS8zYX8y+csb4JU3cCBrYE6yeuaFhQqRysG1bEzHf
 0low==
X-Gm-Message-State: AOJu0YxOLyChm0m71AfllHmlnf2l6tNsaeuzaB4YRMD2LSrR2aC7qzSP
 I9Z2xDKwM5z69Q3tN65rded5KDc+D9ZBgkDhZMT2qZM91nHX2QwnOH1xWIqMRsO4
X-Gm-Gg: ASbGnctwYmtWkYg7Mx9CCLsPNAs8St13BjPOfDldmGtw4NlCQK/+FmFDSFTxBUI/o94
 xzcqyJlasEU1x1SrSiqk8sN3RM75E1QLR4xs9A4QFvMgd5ja/YmSbLh8MfHI2iBnUATv5pyoC9b
 BhIXHAKjmPf185sI+ZnIylswPFK1zZDd8QItl+jgOkTPY6fpOLhv1jfeJmzpYBdY3bC0vgZTXqD
 hZ7iAeEzNwt2dq844r7v2rv56HUnwxjjIg2v0f1rEr6/RpKx6sgwO2qQ1KoDOguslGjt2ETYoB2
 vj9CZCrc2RfbRB1G+v4FxAVzVlf4m6G8nRfhXhHFnPJz+ySKdJtai3jqRq4Id3pFvnA6NkelYEg
 7ls+9sDVYKherCzbSp54ksUkmPxA+eO0/P1XokQLmqRPkibG2FKTks3O3d3bAJx1GN0+S+9P3Ju
 MRzUxvR8NkAY2yksXhFq4AscBHRrvhFPaZRw/mSppxuJl5cAkYZcz/Ig==
X-Google-Smtp-Source: AGHT+IEJschSUkOgd5M6sLjqhPT5frQ/z3hzoAZJ3vBp/Qur6sw7kpJUNvJ140UNfkGVgLXBgbVTCw==
X-Received: by 2002:ac8:5992:0:b0:4eb:7dac:7b8d with SMTP id
 d75a77b69052e-4f0175eb7f5mr41285071cf.6.1764794802552; 
 Wed, 03 Dec 2025 12:46:42 -0800 (PST)
Received: from localhost (pool-108-45-131-215.washdc.fios.verizon.net.
 [108.45.131.215]) by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4f01c978757sm13704201cf.28.2025.12.03.12.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 12:46:42 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] test: strlcat: Fix SPDX license
Date: Wed,  3 Dec 2025 15:46:40 -0500
Message-Id: <20251203204640.1944971-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

When I modified this code I meant to accept the LGPL offer to convert the
license to GPL. However, while there is an LGPL 2.1, the next version of
the GPL after 2.0 is 3.0. Fix the license version

Fixess: c4ac52f55d9 ("test: Add test for strlcat")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 test/lib/strlcat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/lib/strlcat.c b/test/lib/strlcat.c
index d1a0293271b..a3d4eee4795 100644
--- a/test/lib/strlcat.c
+++ b/test/lib/strlcat.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.1+
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2021 Sean Anderson <seanga2@gmail.com>
  * Copyright (C) 2011-2021 Free Software Foundation, Inc.
-- 
2.37.1

base-commit: 69c8ea98a713f88f4a6ffad9df2a72b1a767f629
branch: strlcat_license
