Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04247CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 15:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F5E846A7;
	Mon,  8 Jun 2026 17:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eff8AHAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3A1847C3; Mon,  8 Jun 2026 17:48:07 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CCB583EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 17:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36bdb11bf8bso2592157a91.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780933684; x=1781538484; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vwx6uzZJkHeymbQDDFdmwDGeInAjRA4WFTFJwmNNOtI=;
 b=eff8AHAo9/afPI2Rf77jk0Y9B2f4oAwGPgw1oaUeRPRSPR/EqQJ9bAl6sTOYoxaMWo
 hNcnO9bh49QUOgqa4lHT/Xrp6W3Y7UT9DJgxzR72JBSJBshXTLwgvxdeXhYuR5rKBKEa
 21xLAlerKXbenUaeoWJZdCnfl4CnzQhMDz8PUzg4pvD04ndWydG0Ubymlkt2gSLXJaBX
 WAuhexXidBS5ooeUvarxKI8zQ6nRViEE+DK3+Y7pErrafVNmhY0sdmAaCJNW86pWZVuH
 O/NVa8YpHbA1S9JhuaXIiysfdUQibbrQ2IjuqK4ayVGTu6WgDwDup3BHDeiw+0a9SkaG
 Zt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780933684; x=1781538484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vwx6uzZJkHeymbQDDFdmwDGeInAjRA4WFTFJwmNNOtI=;
 b=mWC4zGa/pTCUa1QYsZz872aP8Xh5kEHKzX1ISs84aD7pFhQ1fAPSEVtYnBPlVE0Xu6
 h0bsLMjjdGoHpLAZCRmlj6brhSwJg5BpytsEpBAEQI7pPBJiyKWoxSH8rUEkV8Eh/ZZS
 +uMzZ/LLnSvIbok0t2QGlegNkmFi2oeR9C/U9mGWCAuquy/5oJFqCPhWfqUfDoA+y/Nl
 mC8RGivd44/necMAs+j8a31GwvP1jhoGCnHESR3JZgYAj+rAdEYb5B4GEXPj0qY2OwQQ
 D8bqU9SmoNDT6ObAlIYk0XzSOXt5JE6H7lrS0SkNjNQEgcx+53VmunXBS+pmS9KQtz9Y
 Laig==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UymnInLKRrmjZ9yPtnvvoEnDXfmmfLvHLbduSUdKYxZImhqVlTMtMVKnBtTp9jl2joYRrqhQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyYYmiM3+Ai+sxsOZ3vOcphPKj2vgdMOZHoM+vee2pdNaxOwaUE
 PuQBLxu96ZM3BGGaElt0jDw+KpbiH5V8XqUsAymupnNiClmXf2y6QlOk
X-Gm-Gg: Acq92OHspp5/7nIihxeNkcH7lGFdLWa50YTu67YYjt4mj5npdUe6g39gPt9bbR6Yx0H
 nfahG6fj0Dx6XgsU2umuZyRtVNYMU2AjglWostQX3h2oJV66ype/xN+HwpwOmCkftB5m3DPl9pE
 6JmdqFhqM/NpvPCaoBWTrkBZuTWE1KVUyLcvOOXIA1jeFoTTzsQOst84PjN2+oSU7e/5bH5G051
 i/Pdp9uN3hTvxnSU+x0nw6svI4mnE9Fh6M/WdTVcSHozvxSgzkO8Z0iiHRf5gf0zt16sm2vT8fd
 ArADNDzTNh+XMAN7TPRHjhmGfkQpHO/M9zlgI4+GhgFCtkG7BO/9/929CvjXNF3Q6oKDjWAwSx1
 p+DS3MYbLvvM+MTcgHqNtLX91JCk4dIAA6ma6aY3iKB7IsuhTz98qJXzGXTDZl/4+X+QBTr6veY
 VbBphdILmxNl7rn47/22AvjXDiwxlNk3tW5We0ecwo5rhaNmYyEf8E0LGwBeAyXzMsUJ7MkNxvQ
 MnlmD57Mw2RvqslW4DkcEL5yD7i3OkaxQ==
X-Received: by 2002:a17:90b:1ccf:b0:36d:9ea4:d0b with SMTP id
 98e67ed59e1d1-370f0e49762mr16964813a91.24.1780933683567; 
 Mon, 08 Jun 2026 08:48:03 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (54.109.81.34.bc.googleusercontent.com. [34.81.109.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6bf827f1sm19778621a91.3.2026.06.08.08.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 08:48:03 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com
Cc: naveen.osdev@gmail.com, u-boot@lists.denx.de, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/2] timer: goldfish: Return error when device address is
 invalid
Date: Mon,  8 Jun 2026 15:47:48 +0000
Message-ID: <20260608154749.1190658-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260608154749.1190658-1-visitorckw@gmail.com>
References: <20260608154749.1190658-1-visitorckw@gmail.com>
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

goldfish_timer_of_to_plat() currently returns success even when
dev_read_addr() fails to find a valid address. This leaves plat->reg
unset and defers the failure to probe().

Return -EINVAL immediately when the address is FDT_ADDR_T_NONE so the
failure is reported at the of_to_plat stage where it belongs. This
aligns the driver with the recent fix introduced in the goldfish
serial driver by Naveen Kumar Chaudhary. [1]

Link: https://lore.kernel.org/u-boot/vgwnt6mnls3lf3zdm6mz5siztzkvppte4ykszbvifjzukvmksf@maaxe5agqpim/ [1]
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/timer/goldfish_timer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/timer/goldfish_timer.c b/drivers/timer/goldfish_timer.c
index 91277d7932a..59ce43fcb46 100644
--- a/drivers/timer/goldfish_timer.c
+++ b/drivers/timer/goldfish_timer.c
@@ -45,8 +45,10 @@ static int goldfish_timer_of_to_plat(struct udevice *dev)
 	fdt_addr_t addr;
 
 	addr = dev_read_addr(dev);
-	if (addr != FDT_ADDR_T_NONE)
-		plat->reg = addr;
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	plat->reg = addr;
 
 	return 0;
 }
-- 
2.54.0.1032.g2f8565e1d1-goog

