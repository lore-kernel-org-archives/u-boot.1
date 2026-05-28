Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A256CD6E44
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 13:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B29803C6;
	Thu, 28 May 2026 15:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g7xYQDww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80BC78056B; Thu, 28 May 2026 15:50:13 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5641E80398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 15:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45ebafde87cso4152177f8f.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779976211; x=1780581011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fvM3rib+gi+1B6HOLnHf/UDtNnYqiXsulg6kkM8D6xQ=;
 b=g7xYQDwwKQmhe9jhcds1H0tqkVw6sID8JkSHoVzsFqHZocCweyNRSWrfnNmqkfzCmW
 ZRFcrzAR6tuXPCH5HX+glVyM3ZMGfqz8L1mrdSdonzdfJ7ya9Q5D9tCxCLD8RrqZwgTV
 yWlwT5nYRpzZCKMdTcujwrTEH8MLtiFBHs0UBLR03atHPivicu0JyXpFsBF6TNPzKnqj
 6o9E0PdWiXzBhAORTBmFSt4frcPu3dAmsPxafIzWqBDBcu+QonivUk02I5DXMVXLK6cs
 N6/L719yuQNGRWBDyCyoqwmWAv6jtXPqFOqyZrWmYpXGoneSJjOm/tPWJI03PAn0CIXM
 Mn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976211; x=1780581011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvM3rib+gi+1B6HOLnHf/UDtNnYqiXsulg6kkM8D6xQ=;
 b=Q4HKLqAfGOgVXCz/HwrhTNT431VMWAqn02o5fWkM/uA/CZXKw38DjfVDYE0zqqR5uo
 j1mW4e/SPdvFL9gU4gUIQTWo0yEHFmi/z8DuJ0U/vh6guqwCAcgSAgCaMUdePYmv3C1z
 byOUohRVa+cJONQAQmCxmisGbLX/i9qkGzdlnMMFf42lBexG/isfk0+9xffUfmP8gXSr
 G1ZXSIt1pCyZ/ylvPZSD4TZM02GRE2D0ImC01o+h7GkTGmBMQA/76AdeMzjzHbzDbkFs
 9cokAAuO6QA1o6g4hW2XDBAElCn+x/chclpKO45pczH1CH2ffoIz9AAj9Eu87jAC0+lU
 wHKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+X7aLP53wNOinY233xR5qA5CsLyBVNn1RWthxPzih4SDoImVsig1u8CwkLU+pY/urhriuyaS0=@lists.denx.de
X-Gm-Message-State: AOJu0YwXpmxBfvv5xmWcZ2W0kNmZyANekNYBTNHIGaoTvwfIrrs5gLLL
 5aBlu18qSiAi8yFA120oaB7xqoQ2c030k9BgHItZ90WUsINB9qQ9Lm6q
X-Gm-Gg: Acq92OED9d2mYFhxRpdvoVNDh0f+LYNGTR+JNh1hFSEa+FB6+FE92BVJ1mKNOE/+mkU
 hdphXYlJ4Akd78kOV8HXSOM0U5hcxxeHGt9anej+B5TE4Wh6mQ4UwCfGkjVq4+kEniUsySdu5sw
 3DzG34oFL3IYjfXXrw6/UPdBZwninm11yM3qaEtx7qZOmgnwDPY9O+l9RUYKUWJjyndx5sbIF0R
 xRYTVv1femdhK/vpk2m9zyoVDqJxZz+TVCCee8Rt9xiOTf42fPhYlHz/156J9a1HskwGJt8ODmc
 UJKyLj/IMj/7WAPvtHkVFk1P+MNiUWFtJ/tVkGpS2SiWo98ODQnMWP8rMmW40NgpTsUMgDcmjyy
 Dp34Sp4vX4anFD9S4ll7hOBHzU4SR9Sj6bP0Ojy9zadxv5jB7kXEIct8U6gyX7hsPkdpJ5BztCr
 x8551QQbcLXvUYspuBT2XGLDZdmKh9S3/2u0OrFMN1d6J/Y0Bs+IX7N/hgkfrLF09J9wZb4yID6
 9IyoF+MG6CJlVrQnds7omKWj1ETKYPxGR1h+/Rl1XwLr+OjNt0ica73V94riGfdvg==
X-Received: by 2002:a05:6000:41c7:b0:45e:de0a:1773 with SMTP id
 ffacd0b85a97d-45ede0a1884mr9261870f8f.33.1779976210524; 
 Thu, 28 May 2026 06:50:10 -0700 (PDT)
Received: from emanueleg-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5579b8sm13966089f8f.9.2026.05.28.06.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:50:10 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@oss.nxp.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH v1] serial: lpuart: Fix RX FIFO Enable bitmask
Date: Thu, 28 May 2026 15:49:06 +0200
Message-ID: <20260528134919.10031-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The Receive FIFO Enable (RXFE) field in the LPUART FIFO register is
bit 3 on all supported architectures. The define has been wrong since
it was introduced: for non-i.MX8/i.MXRT it set bit 6, which on LS102xA
is read-only-as-zero, so the bug went unnoticed.

NXP confirmed bit 3 is correct everywhere, so drop the ARCH-based
selection.

Link: https://github.com/nxp-imx/uboot-imx/commit/9498bcc514737269bb0ca436f775460741ab8199
Link: https://lore.kernel.org/u-boot/dc163ea7-9063-4dfb-a39a-e643c0bcccf1@oss.nxp.com/
Fixes: 6209e14cb026 ("serial: lpuart: add 32-bit registers lpuart support")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/serial/serial_lpuart.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index 9fdb6503085d..3f5fadfc80a5 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -53,11 +53,7 @@
 #define FIFO_RXSIZE_MASK	0x7
 #define FIFO_RXSIZE_OFF	0
 #define FIFO_TXFE		0x80
-#if defined(CONFIG_ARCH_IMX8) || defined(CONFIG_ARCH_IMXRT)
 #define FIFO_RXFE		0x08
-#else
-#define FIFO_RXFE		0x40
-#endif
 
 #define WATER_TXWATER_OFF	0
 #define WATER_RXWATER_OFF	16
-- 
2.43.0

