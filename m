Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A9CE8382B
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C374583CB9;
	Mon, 16 Feb 2026 20:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dGBP4JQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6F180077; Mon, 16 Feb 2026 19:45:18 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81E480077
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 19:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=filip.kokosinski@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4837634de51so11413295e9.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 10:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771267516; x=1771872316; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBrHHMsHsVptsYKgaJRMXUUBAnUQAUgMAG6PWk/ARak=;
 b=dGBP4JQ493wXgSlmvc5MQfVRdVM2hHOM3BMtzCjGdZXTjw8iWXx4DyABDVY3feyXjd
 q6nCMi8N8HgV39hko+g0fWD85kGYLoMI3RyypiV+NiqScaai4Oft6KUAby4+61DtBPvm
 SOdB8cbyKLwPJBHN8BdYD2s7xTWXWDujnDHbBgseWVXj2Kr9J7Bklzu2pZouwdVJoB9O
 w0iyvdYO2NQsQDklFUu655cAkxOpY3c6sg+ua+oW2b6qrn8QEgQCw5TAHTzPrkoTEKIE
 IELQG7m9xh4dFTb+xqxHsrWdIOaAYmsn1wYTpQVg9t8Cx6AvPgj9oV7Wd4ApnEnqI9b6
 BpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771267516; x=1771872316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iBrHHMsHsVptsYKgaJRMXUUBAnUQAUgMAG6PWk/ARak=;
 b=WJnGR6nIsF92jQRK5OnP4P6yZC0KMkKb409MV+4AQ4fDgPCxN8RCE6oGIjFyGesRcD
 pyl2KiXCaQXSvPx7U2OimTSt7ceA8YsNlt/dqnM4q1Gg3+ZfdUl9DQla3bLqmbz10lWK
 pOE9OIxqw6RbHUVfjR5MyTokeJPGGegETWJePxGdOC1RlakSzpq77b6shkO2WHtcuxU4
 V0B0opO8q8+QygTODR8U0U0+0cO6u0R5rMxyvQrEg1CB9lP/ca3h5PRpOjpW70ghi5GA
 LY+60t+gTXTu31e1VbmQ0tcyyrOolg5mDb2vSzga+GvRPN4uWOp9odv6lPt74Te9o1sP
 LD1Q==
X-Gm-Message-State: AOJu0YzlCr3DVK0jeos4Sr0fBLj4i5iATyyCCYrqkfUdVc6Ty28YpOMp
 FS5suefVjQ0nY4Yyl/5Qfm/Rx4aYpDGUVBhY8RHs9KudAstmjeGEubASTr9rKQ==
X-Gm-Gg: AZuq6aL0cycx1gnpTjfHkbzQa4iyXHTyp+LUE0NY773p970ssooC4C/PG60bs+lv05j
 x1+3rynkmZiGtPRS+z72kni4yf+i0JmWrUzfKqjUSltgeoZA9ZE8huLCvT8skVBr4wdLBQjDTbv
 +KMf2mcPfc7PfsyykFrNK6tgvRCDW8AZaZwt4vK7uaBgCu4noUJL3FdoaGsX3I7rXI0jFKkm+ak
 74nawj0AGQ0535PL0WrM9h44+1YmkrUTFgoXgn+iMjQmzA2t0CmNMhP0Yyf71WzUJTS++OgZ5oO
 nnICL5chT9bK6Dz0bn4qnib6Fnu6Ecp2c2yhCxNxZ/HKaxMTVPdKh1MEMOcHjPd49t4iEnpHclU
 ufqBuPJkXdMCzflds3cYG/lvaDe0ckEr/rqhTiTDh9s/eAd0uujoJcNw18RvID67L/Eb+WvezFN
 jo9yAIMQknzd6JHqHXuJnrZPzg8i3ysfn0+GQHNjEh8qJ/BzfGiIwZ2RTCi1vjZtRdhe/0PILCl
 WwjblDf6Ln+
X-Received: by 2002:a05:600c:474e:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-48371095fa6mr227835995e9.31.1771267515860; 
 Mon, 16 Feb 2026 10:45:15 -0800 (PST)
Received: from desktop.home (83.23.200.152.ipv4.supernova.orange.pl.
 [83.23.200.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm449404165e9.14.2026.02.16.10.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:45:15 -0800 (PST)
From: =?UTF-8?q?Filip=20Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
To: u-boot@lists.denx.de
Cc: mbrugger@suse.com, pbrobinson@gmail.com,
 =?UTF-8?q?Filip=20Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
Subject: [PATCH 2/2] board/raspberrypi: add bcm2712d0-rpi-5-b for Raspberry Pi
 5
Date: Mon, 16 Feb 2026 19:44:52 +0100
Message-ID: <20260216184452.18732-3-filip.kokosinski@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260216184452.18732-1-filip.kokosinski@gmail.com>
References: <20260216184452.18732-1-filip.kokosinski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Feb 2026 20:51:34 +0100
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

This commit adds an FDT entry for the d0 stepping of the BCM2712 SoC.
This entry is used by the v1.1 revision of the board
(revision & 0x0f == 1).

Signed-off-by: Filip Kokosiński <filip.kokosinski@gmail.com>
---
 board/raspberrypi/rpi/rpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 1b404b448f3..3d61d08f3a4 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -197,7 +197,10 @@ static const struct rpi_model rpi_models_new_scheme[] = {
 	},
 	[0x17] = {
 		"5 Model B",
-		FDTFILES(DTB_DIR "bcm2712-rpi-5-b.dtb"),
+		FDTFILES(
+			[0] = DTB_DIR "bcm2712-rpi-5-b.dtb",
+			[1] = DTB_DIR "bcm2712d0-rpi-5-b.dtb"
+		),
 		true,
 	},
 	[0x18] = {
-- 
2.51.2

