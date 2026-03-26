Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0C710A1E7E
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4343284068;
	Thu, 26 Mar 2026 12:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="qLdV+//h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2285383FAF; Thu, 26 Mar 2026 12:29:17 +0100 (CET)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82E684082
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-12776bebe9fso1645813c88.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774524553; x=1775129353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKlgcpRLZOtN3TPTkkEiMCXnctDvrLp9AqBrKjnnXww=;
 b=qLdV+//h4aHeFEh6ipFvwNUHZKv7d5fBtZVZMhfYzPlmspHOyy31HJC2vS+tpVyWbr
 CJTjwdbQ/vSXioHtEv3YhrTtVlXqCuhcZ+/sz+l18XB/WpJCstHyDE6u2fj8rSVW1no8
 0zLkzExlJVNr4WEcFWhYXZc+VqcQwNap5rBrfDKNXK05Kl5aUfyQMVFd9bwmOL3zX7uo
 h4dfQstYr70PAxOXVq1+PD7/G7u9BdBpGxd1Vus21oedZyqQpTrv1A3yScKGy3MN3nof
 ZJKCZPkwNMOVigDJyeDy4HS10q+9xDH7NCh83EWQ2+e3uxw1OqrZJ+Qi0cZ7JKV6rujj
 9bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524553; x=1775129353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OKlgcpRLZOtN3TPTkkEiMCXnctDvrLp9AqBrKjnnXww=;
 b=NBxCjGv2bCap7RSGlcqsivAkdAbFrrIYK19Ai8ef/EzDW1r8TAzk8NX4AAJ3Nyou03
 nWoNtU7VwtpIIcEDW0FyuOmiumv/sMJBL/z3ufraM7LNlcpckB9Nj7HGCZ7VL6fgm03O
 c3WnEZCmYPuoFEvtvYam09EriD4mJCLZzyZgNH+0n2M2Nn9RXAbp4mMyp1hNIO65ypkI
 r9SY4iGXj08Lq0HtoQm77iSoaiN5haUMsYxiXatZ6MJOL0+cH56sfPKOR1eVxK3gJFWl
 nH3si6Spt6TcvHzk6uehpqixas/bCvrkB2z/MAvka22UIg7HEZGVIPtkd05jlOWSjSZY
 TDUQ==
X-Gm-Message-State: AOJu0YzzOonpuNYG+xOkjxd802vkmJeMPz5xHaLub51wjtfN2cR4WmHs
 z4MJ84FZQQsrhLoSTCvdZk4J1BnJC793VTBKAqH+VUssB2XJavyBW5whmlp4fbusuN4fCiX8cqO
 77X8KTPuho8DVeso5QUSy0y6l1xY0bxEqW1bRDMqoZLuxhM6Efx5WEkRecGXNrPCSdJnRGu+azk
 Y3tJTyMP4hCS5m7uvxhL0ue/z8RQTwIIdwrHT/8jsfgo0=
X-Gm-Gg: ATEYQzxCMnVtyieZiaeRZ02aHlqBZcwfL2uYFsLk9/1mGlwbLNmqFA4F4BJerGQJxXH
 +n1i+MJtF+Y5cOhZeAdziajQz9eUb9sG4h2f1I/BkaLtvHyBP+pveFw2y0ZZ4pa0b8r0ymHgWlJ
 uBmgsVgpxdnNcayz5N7Wq1hfJ5jV0++A+Yd8i5rVUaWuWk4xo+Zvfu3D9an1t1mIN37vIBpEEzw
 Yt4I8XDtEjyM4ENxivv2b9FDs2PLOcNK6DcaueC6xuIkfAH4fUnRULhbov0PFFHl1Lk9fjpZB+d
 Na2PtfcG6UpQVD3bTSk/UlhBKGRtSvorz/Nyf2qd9r0A2tNYzpiijbgsnqAola/TYT+JnXE0law
 jV0JO4NzpQ7f47edqEsyDKOCC5rbT/v5lXO7abR8xGYBx+E7KG+b078R7RFkFwzODWmEBhRJ3su
 4zhwOO6zJvxdGm5P3MG7nQ8bmvU/KGSCFttFwoqUk0rNidBd2x3IuTxoqg8O5iO3xxZOZejNSC9
 QB85KD48usf6iYPqfihFR7xHz11PhCFvGEQlkvg
X-Received: by 2002:a05:7022:402:b0:127:3915:76b2 with SMTP id
 a92af1059eb24-12a96ec8f73mr3813568c88.27.1774524552819; 
 Thu, 26 Mar 2026 04:29:12 -0700 (PDT)
Received: from fedora (cpe-109-60-83-68.zg3.cable.xnet.hr. [109.60.83.68])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm3729221c88.11.2026.03.26.04.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:29:12 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 08/14] i2c: at91-i2c: include arch specific clk.h only for AT91
Date: Thu, 26 Mar 2026 12:26:49 +0100
Message-ID: <20260326112830.313874-8-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326112830.313874-1-robert.marko@sartura.hr>
References: <20260326112830.313874-1-robert.marko@sartura.hr>
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

Microchip LAN969x will not include any arch specific clk.h, so in order to
support it only include <asm/arch/clk.h> when AT91 is selected.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/i2c/at91_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/at91_i2c.c b/drivers/i2c/at91_i2c.c
index cfae36c74d1..6c002b21e6c 100644
--- a/drivers/i2c/at91_i2c.c
+++ b/drivers/i2c/at91_i2c.c
@@ -14,7 +14,9 @@
 #include <fdtdec.h>
 #include <i2c.h>
 #include <linux/bitops.h>
+#if IS_ENABLED(CONFIG_ARCH_AT91)
 #include <mach/clk.h>
+#endif
 
 #include "at91_i2c.h"
 
-- 
2.53.0

