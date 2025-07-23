Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7A1C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 11:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81F8483457;
	Wed, 23 Jul 2025 13:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eznoBf6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F5683496; Wed, 23 Jul 2025 13:32:34 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ACE583440
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 13:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45617887276so43494515e9.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753270352; x=1753875152; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G8Ur6WubS5Pcgicj90zKLKqJrMkJimX2Gc+7rHf809o=;
 b=eznoBf6OJRSFCZELoW2zmMD5S4zKUaMxUJnn678ftRTuAKbqh+3FtUWwxhS4Qxncxc
 7nvtUQHngjFqP5XOYsrMrHBvr1yKeR2HB3l7f/on4+fYvtKjoMTqQRqKgjl+WxhJla2r
 UN2LK6nHqmjFLxQsWlLtpdZUsCmkatNVyjqAkM0rtwbwaqXt4T6F3kawXfzlQg10qlKc
 eVqBaKJnQJ6kgMOu3OB8gO367+qqIS4KQciQk1bH5jjGl5PP+BJdSqu4B1wkJYjW7Gfd
 D4/1y5ftty/WYSlP/238ObygYvUg/m9/xzavcMFPAOqTN+99Fl+zkwBmkdWsxCAdWXKB
 EnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753270352; x=1753875152;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G8Ur6WubS5Pcgicj90zKLKqJrMkJimX2Gc+7rHf809o=;
 b=vo4t68Vcc99jGwLfo8EImZfpe9HOjVvx/DzpD8gP/RmQKbeoDpclRAWsRr2s+lpv5X
 q+b7zt9M/cZN6CaomCw+syOsQuc/Nn4qYkhblyp+jSXy24Mz6+7TvC70D3KBFUwYrjxV
 FenyJ3NwrNwj2AxH1XHtbh+S30O0kYWZ/bGtN6nAng7vQsjCVpwwiwS5N/7gLHZg+8/c
 RbkQiqxT4jhD4vn5fovOW9c1D8gNsl2JuAOGeHFOG15L3haq1tiikj4HEB375nduwP+I
 cBtTg/JLu5NC+biE6RqqUr4uU+Fluj8+P9bCisRaCrnjQPPjuEDe2kF106FgfoIo1Jnk
 r3Aw==
X-Gm-Message-State: AOJu0YzudByxQ/JY8/bilizuj3yuvNni4o28HoTBxEgth8cXJAQ0lPjq
 mNZ643bypzYLbtK7yF5tUz6w+N2he7EJg9TrD4Ylmnb0VqZaeLvRYeA1vnxx+KzYn0JfNl+Aknt
 Zw0It
X-Gm-Gg: ASbGnctkS/0fVnAsAlnUlhuI02h4YpHBRTot23CEtvU7Ux9FSvtWDSftxCsJiDrtmIJ
 wKdzasVeONJcffUmuS3GLs3Fkm8NfE/bbEU4R+vPox/DA0PsSr6G1SHl95fNra8oTw+nGuh8pfr
 aTuaMrBtstZzGDSxGx7Lf0CBqpyafQNmt7us47IhxjatyJAPiBlf+LoYvHaOUM0Ug/Jp7bTffa7
 mtIYH1NjXEjLL3jQ6nbCDAJwFeTFpafF5xcmI18/crlyAXalKNxcxNZRVI12Vz49XJZPvJzKou/
 R+T2ka+ePfupilDZOERt1WH4izOMGTdvV9XHbLTXNfkwfZyVREsNQP0hfcsTk3+q/nv0J+V1igb
 I8zIXMoaGzHbRUysyrmZnx+PgNI0lBa9KgAAYx7+eMv+jWswwl5s=
X-Google-Smtp-Source: AGHT+IHLfco6Ck765lYr9/VwgcPN3ZZi4FNi3K1wHiVKG0SolQm8oYlGcZA8LII7Z7kQ0p12oMFyBg==
X-Received: by 2002:a05:600c:3b1a:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-45868c8d67amr23534255e9.9.1753270351665; 
 Wed, 23 Jul 2025 04:32:31 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:5143:c98d:3163:b66b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586918303fsm21085505e9.5.2025.07.23.04.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 04:32:31 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 12:32:31 +0100
Subject: [PATCH] clk: n5x: Fix misplaced paren
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-altera-clk-v1-1-fc83094fbc07@linaro.org>
X-B4-Tracking: v=1; b=H4sIAE7IgGgC/x2N0QqDMAxFf0XyvEDtWhz7lbGHWKOGuToSEUH89
 1UfD+ce7g7GKmzwrHZQXsVkzgXqWwVppDwwSlcYvPPRNf6ONC2shGn6YONSeMSOY+gDlKAlY2y
 VchrP5EtWpqf4KfeyXS+v93H8AbjTpK11AAAA
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported an issue about the precedence of shift being higher than
mask in clk_get_emac_clk_hz. This turned out to be a misplaced paren in
one of the calculations. Fix this by placing the paren in the same place
as in the other similar calculations in the same function.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/altera/clk-n5x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 09db250ab6d..9e4e7a1d908 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -386,8 +386,8 @@ static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_id)
 		} else {
 			clock /= 1 + ((CM_REG_READL(plat,
 				       CLKMGR_PERPLL_PLLOUTDIV) &
-				       CLKMGR_PLLOUTDIV_C3CNT_MASK >>
-				       CLKMGR_PLLOUTDIV_C3CNT_OFFSET));
+				       CLKMGR_PLLOUTDIV_C3CNT_MASK) >>
+				       CLKMGR_PLLOUTDIV_C3CNT_OFFSET);
 		}
 		break;
 

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250723-altera-clk-70c485de54f4

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

