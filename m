Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FBBE9A057
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7577D83DCB;
	Thu, 19 Feb 2026 18:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OJTtmg08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95FC383CF2; Thu, 19 Feb 2026 18:52:13 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CD283DCB
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:52:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso10494075e9.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771523530; x=1772128330;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXul22mgOqTPFmE2l0Bw7pi4t5Fuo2IMZYSpgl/+DvU=;
 b=OJTtmg081Mvhl+WUhEhRy+z837V0QOLDEYNa5uoEbbCHOG6trZdpzVQle9ANiQjxg6
 j99FXvu7nu2/NBGOGEZjCTGaZTPdR3pb3QbuKVXA+ubU6bFbBkdPqK1iSABch0/Wm312
 XdWUN3p8iHjFgjJBG+1HTyIkjMEdP9CKoYQR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523530; x=1772128330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VXul22mgOqTPFmE2l0Bw7pi4t5Fuo2IMZYSpgl/+DvU=;
 b=jXuorrjjAQdzrl2G5lgJgQ9myf5ATvc6oEjHR4DWv3YosdsByN8jHm5peeKtzlKSFU
 g+u8IygaR1KiCT/Fm3yWA976WBgfvqH7s4+3y3BPHb1GNzcyz64gs8nQHqA1oUh1MQNI
 qsnYtGAl74r+Huu99xf9Yf0nkQo65LLjf862mEkZa3pFcxQTsijmJK6niMJfPSoiNE5z
 4ygX3KGMqLT+spep0LoSgc/uec6enRGdYxFemUOOZWOQjia+mwKn5vfAhdg9kLurX6r2
 L1D+l3NWqxliHl90HkDcup05wQWYy4fvkcyfnnJZNmAQXSDINlHXS9TMzgK9q1smLAVG
 cuFQ==
X-Gm-Message-State: AOJu0YxKLb0MfZgFT7cEjOgJfJbZe+TbD0Imlo4FZv0eDG/QamhSHOPs
 pk4/ReBqbNODCPWABNFJ8Q5rss5oEahGai9E/EZhu1FBg8KexoAesVoTgloBYvmHBa395qH8wpR
 bnPW0Vag=
X-Gm-Gg: AZuq6aK6xg4z2gO/2SSiZa3kBg9lAWtAabdqtRS4jn5Vex5m72G5/wZxWXQJuD7gL67
 Poj3nTJU9xXd6j95l0EQoOJIIr1B6OqJTFod2fcReU7SjxQ97Ja/SVF76Y4XrEIDTxIAbC81ptq
 ugl3DgCJcUN0IfGZhVu4AmzL/LKcxAdUCMa5G2f/JxWJ8uCWRehJNIObFV0Z4/8RMxsvQrlI+XN
 kqZoXFIZjA3OHtJqPZEDc9utv+8/QlaJHr/Ht+/+1Ovukia/Zarbrhev9ub25Ia66+cvtj5KutY
 I7i3lSgTUeVRdNZKOKIPm04lFvGXw3qhXV2MheOjGmzukHGxgOSo/PcK96sYIQsR36hz3pIm6/d
 wLae45+wpR6UxOAEZ5t6o4UgqHOQ0Cmuk7w6hSjyvtcbyRr97EY9TGhoZ0poU2Nn1i4LqBxox9U
 ZmWoCDwOFFCPZb2u4wbg3tiAqUYI42EESWs8E2jYtwCI6txJqrZtgtbtfHwjSI3mIhuZGP0oJVT
 ELR3Y47Sl2rj9MzVfCU8jteWuduGYLGKM1SwoytgL2OCWTPPKgK4h36UrCsp+CjJx+bw7hBg6Z7
 NGlZIyuXOaHwEWwdjojwhsb5
X-Received: by 2002:a05:600c:6912:b0:483:709e:f22d with SMTP id
 5b1f17b1804b1-4837108fc46mr374253345e9.27.1771523529890; 
 Thu, 19 Feb 2026 09:52:09 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b0e63sm35485005e9.2.2026.02.19.09.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:52:09 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 5/8] spi: stm32: clean up buffer length assignment
Date: Thu, 19 Feb 2026 18:51:16 +0100
Message-ID: <20260219175130.2839234-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
References: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
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

Remove redundant divisions by using the already available xferlen
variable for setting the rx/tx buffer lengths.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/spi/stm32_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index a1f31cf653c7..adba97915cd3 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -404,8 +404,8 @@ static int stm32_spi_xfer(struct udevice *slave, unsigned int bitlen,
 
 	priv->tx_buf = dout;
 	priv->rx_buf = din;
-	priv->tx_len = priv->tx_buf ? bitlen / 8 : 0;
-	priv->rx_len = priv->rx_buf ? bitlen / 8 : 0;
+	priv->tx_len = priv->tx_buf ? xferlen : 0;
+	priv->rx_len = priv->rx_buf ? xferlen : 0;
 
 	mode = SPI_FULL_DUPLEX;
 	if (!priv->tx_buf)
-- 
2.43.0

