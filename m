Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC1F109C058
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7281A84105;
	Wed, 25 Mar 2026 20:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kb9rQiNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C854840F1; Wed, 25 Mar 2026 20:00:50 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4940B8412A
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-467161c4b7aso65138b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465247; x=1775070047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=987/hDrolpWp1PQ0mKG7XN7YfHsnClFxfFJAXkNPBrk=;
 b=Kb9rQiNSbXaq5/1Z3t4XB7X3jfB9bDuuhWOSkWlxzdIVrOr0WNZ7zO4fTstuVg8uPV
 qWnnblTWyJBLrN5B5XTKF0f3C/YWGX5M7lly/S/DlwWtKirAX4NIHY8apML+k7l7u+6n
 mCZ7UBcbswrcgho+mGLq0XSGNqAyfTBrdfTMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465247; x=1775070047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=987/hDrolpWp1PQ0mKG7XN7YfHsnClFxfFJAXkNPBrk=;
 b=H7rcq/oHnfhEpI3a5ZSa7vCBcWpveF5XO5y0iZolGoqG3We6uLiztjwHbhdnktck09
 pp+top6/LAByHG8Ii2LvN8FWzAhgB/Hd0NYjpGL9tc2CAdC5mKvgTgSJpb0NF0Qtqyae
 P+0imzA4TtVeVtox+/BGuDC22r/DUmhi2TLRjfcnSGP5lDM6B98e51PZOPqvOCdnYkNd
 DzE3AEubx0zJlBu26yW2nap7Js2TQG6G8xGXucKbGVb45KNu7sVilvxVix05kK5IjcLG
 ePT/2+ZXa+vBdaMm6dtKE4AmM1vl7S4tixrivAZH1Sh2cLtCLtMB3SOmNDzmD9k1yFUU
 9JMA==
X-Gm-Message-State: AOJu0YzyqzkdRp8lM1YYAxwMXZDZmH/EwoozY5dEueojpzWtv3umoOOT
 twEsUIN8WOAcrNGBx/8SiUrZtBjafhZkgLcoWjzk1QuWzJnjoauIlptOOAdX5nw8hzaX4aJzSQW
 YD5CBZzY=
X-Gm-Gg: ATEYQzyk7OvK0ycgEbPOJYqb6MOfQbrVn+OQELYNc23ayU6svRlgf+ds7QabCEDgIiM
 2GyvEfssqw1IEwcIlI2JMhqtYduF46xSfa/Z2AYhoFQPlimdS+H6o5kciO9tJSebZW5LrU6qy0E
 u9yiJTKA2dBlXI0xxyJoph7Lh+KQtHWN4qh556ahCFRX0tzbKMb7ZwSVfCUIlnYfUjXtS4AYEwc
 YL3mV7XkxbTVoq7hxXNxR0oFZcikWu7gILIH75Ez5+9d/ddj83nHb9VIwKcjmT9bdx/kmBAW1eb
 8h12VT+nIbO0cDgNhyYGB+C7WJE3hRd6gMoata3/IlHVYL/XjW3NLKXRGhERaRA/4pYg+XEnGu2
 YsKjtcnGu5Kq8V+quv8pXTncQZCRwzSnG6BVr9C0MlLspqrnz49FtpChoR3YHyuU0BJasiQUTV5
 PK4nf7yBDu5/w/44LjG5/AXPfkBfzH/3Db/EKjUw2ADEmVL+cvoWkHDVP75qDMpBq26er3e8o4m
 wjMfNmJng1pbfZXlIpKzam61dTMnoiZHZ+IqBNHS7cNvau3ACs=
X-Received: by 2002:a05:6808:4f29:b0:467:1e7b:72cd with SMTP id
 5614622812f47-46a5c55621dmr2140777b6e.1.1774465246895; 
 Wed, 25 Mar 2026 12:00:46 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41cc7305739sm357454fac.0.2026.03.25.12.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH] o4-imx6ull-nano: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:45 -0600
Message-ID: <20260325190045.3428772-1-trini@konsulko.com>
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

This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
---
 board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c b/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c
index 10469aecd0bb..b55e92fb0514 100644
--- a/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c
+++ b/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c
@@ -16,11 +16,6 @@ int dram_init(void)
 	return 0;
 }
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 static int setup_fec_clock(void)
 {
 	if (IS_ENABLED(CONFIG_FEC_MXC) && !IS_ENABLED(CONFIG_CLK_IMX6Q)) {
-- 
2.43.0

