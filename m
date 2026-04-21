Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BD4F8FA8C
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070AE84337;
	Tue, 21 Apr 2026 17:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KMhkI5Jh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3BA384329; Tue, 21 Apr 2026 17:16:13 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A098422D
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so17260625e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776784571; x=1777389371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21e6ghMe1wbVLqP35TOIU3/qKtapFCNSHiY3XphdeJ0=;
 b=KMhkI5JhWwuxfFiq8xjGYS4KltTQh0NnFe4GUpqSdQ4comJLpuNwackasm5UYxdLBd
 nD4xuUQZqb0zuPx65TC1wmdYEDMhKZEsl0DIu2WGKWocvIcpTwQFtAx7FQhlJbw1HzEi
 g/ssVclmx5ZdHA5m7Fk/+4WLXnle0C0DLP5GuwuX80JK/1qcqkxRQ4CiEqblO/vJYOW8
 Of7mv3jRoy1bGnKXLqeu8Oi97/KIaWfsHl7s91pDsnshqJjz44PjColrkYkDXpr1DOCA
 JOBQDcTaFyaIjU6DAsyjfKIBI7fRc2ayGQugKd9NmImaEiTtVQxUfWEnh8I82NuSZka2
 ZFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776784571; x=1777389371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=21e6ghMe1wbVLqP35TOIU3/qKtapFCNSHiY3XphdeJ0=;
 b=p+1DcGqngIRgjnVnq579aT43mm4Pi85tAARXbUSIiw7PxL3oEd5WPctUb71Jj4A58c
 lGeJq7TjWIin8kplrfB4Ve3sVfDfDy4SX6NqgA3TGcW0sJ9GANkAGWYvxaqLDrpjKUxC
 9/U+3/NhUzBkZkXaAXSI0u7KF+zaVz1vxJFiPkhaeTeddq2y9vAubkS7P5DMUDbsS0Nw
 uPdT1aNZ7zH5yi73ipC3KZ5QlZKp8pREvIpK5YAH/1/0DibjMBcDmmmNFYNNc0BNqmAf
 GRLvL9q0pAmq4moH0yW7T16B9ECtMhdzs5LktKcUuFMCvjLmV1O7RXw8oqgOVitsdrc5
 815g==
X-Forwarded-Encrypted: i=1;
 AFNElJ97I9l0Jw8N8RKEEOFENQCTOtdXmzBfmEcWEp4n+KWGo5AkwFzCFHqRgJQQzZ2zLd7Svd3hono=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2ieBDv64OEXK8AXSKoSJcnQZyKOMUNgXIv9f3og5oOBWQ6BFt
 RnKq1kz2Dm3d1OBSBpK6n+tr1nchUyiRZ9gjEWY6efq/Nnn25B8xD0Od
X-Gm-Gg: AeBDies/ZL1ytngTHlOgbYYvhXeoh5KDgfSm0d4BlhRbR1LL/ZB2HYnV0eqYT7ypK4u
 xdEk09YeGVmPjvLxYO+IxxkDBp1zDNjDtVfWVKn/6b8xPPdCj5O3ihHknCa967gBBFLUMVAxDKv
 +k+Rb/qzO5OBBYn1CMYz1ZLRPPWYPB6zq/CCD4p3YS/O0B1tZ/l5U4rHxK1epExTqERz0qA0vVc
 BApU0MPkDXPpuyBeGIM1TBKVg4Vzr8CZQYRP5GDBXyYv62X/5QimsOOV+dcaiLavvwxDW92fCvN
 Okt07dyjyv+txq6EWHcIDMTbTRsNr/1lCflprx9s96V+ODeJoKThbwqCK0io5+EsTEbB4BgFaZy
 xLse13rxBc6y7RXY8F++KUBd/JmY/O5xYvjvkHfSu9SkXYDwmAZuGfajH3B9PIAIUaq1JVkx+rb
 dwhswtoRvhiUS4X9W6xsUo82BasMjP9yLA7BZAdwWhLs8f22Egj4BE5Z7BENNXftb5qDR4oMUXa
 1JqEejb4j5i/z5kyQAcNpifYYUE9eQbLnraacAifD7LRLDGXa/nXuT59dKtjTsIRg==
X-Received: by 2002:a05:600d:8447:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-488fb8b18d1mr185104615e9.10.1776784571171; 
 Tue, 21 Apr 2026 08:16:11 -0700 (PDT)
Received: from emanueleg-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0b4c85sm361416995e9.0.2026.04.21.08.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:16:10 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/2] board: toradex: aquila-am69: Fix 16GB dual-rank DDR
 configuration
Date: Tue, 21 Apr 2026 17:15:55 +0200
Message-ID: <20260421151604.1141082-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421151604.1141082-1-ghidoliemanuele@gmail.com>
References: <20260421151604.1141082-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The 16GB dual-rank DDR configuration uses an incorrect DDRSS_PLL_FHS_CNT
value. This makes DDR initialization hang during the DDR frequency
handshake sequence.

Update DDRSS_PLL_FHS_CNT to the correct value for the 16GB dual-rank
configuration.

Fixes: 39e014f43a15 ("board: toradex: aquila-am69: Add support for 16GB dual rank memory configuration")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/aquila-am69/aquila_ddrs_16GB_rank_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/aquila-am69/aquila_ddrs_16GB_rank_2.c b/board/toradex/aquila-am69/aquila_ddrs_16GB_rank_2.c
index c24e22b620b5..66e800ef7c89 100644
--- a/board/toradex/aquila-am69/aquila_ddrs_16GB_rank_2.c
+++ b/board/toradex/aquila-am69/aquila_ddrs_16GB_rank_2.c
@@ -14,7 +14,7 @@
 #include <linux/kernel.h>
 #include "ddrs_patch.h"
 
-#define DDRSS_PLL_FHS_CNT 3
+#define DDRSS_PLL_FHS_CNT 5
 
 #define DDRSS_CTL_268_DATA 0x01010000
 #define DDRSS_CTL_270_DATA 0x00000FFF
-- 
2.43.0

