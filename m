Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5033CC61DCB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 09:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D5C483E69;
	Sat, 21 Feb 2026 10:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mlKKExVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82DF383D3D; Sat, 21 Feb 2026 10:43:07 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E0BB83DCB
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 10:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-483a233819aso24731605e9.3
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 01:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771666985; x=1772271785;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2I0WIwQmrmNMS5z4W7A+IyZgO6lMfDS/49I6LdDnFY=;
 b=mlKKExVDYZE9GYc9nNvKbq2xyL7NcVpUpzki7Fr5OoXunF5ueUeh4We8JJPa3uMjTM
 ExPfRiWaqi7/K1YmFf+8tgHuyek7/K+bcv6XqFvHwqqxGZwRiXgjZQHMLUaX60wnf01a
 mNTK4mqOaI4fQWeKndvnTNqeCC0Qh3ID4/7WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771666985; x=1772271785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z2I0WIwQmrmNMS5z4W7A+IyZgO6lMfDS/49I6LdDnFY=;
 b=NR1+5vXNyYXhpqad4bv9zqPe6eqvopIkEniC06d6sQ7TxeSxKltTnKiaurQi4WqU8F
 xU2S9xgtdSAZImVJtAHEh1wSAlSrcsRquhaH7T489Wf+znhTcsHOcWZoZDczCU8x1TIF
 iQGRu6M6UzVBvtch1BQ5QuOgMua3kJ4JGAgex15Xy1cJk8y6UzO0LYalUilx959j1iIm
 4y0Wy1s6S5w43NQso44RaPItvw6TAz5GwOkDF2MVoml1SbDze3Z3KoZ8xLavnwd2owFW
 eb9XQfhKjvWhG5YA06pNwg/yZ2OqgR33K9cqYFd3Cy07I1TrjHy78vjVqVEb3fT/3shj
 bUgA==
X-Gm-Message-State: AOJu0Yw6kGbcnIHQVI9XTGxK5D0HZUi4FvN87DVIDxBumEuvuvSQL8j7
 Fbvv/AK1rF9lWvQufCyRbImRbsZZcs81abrftUw5DxOpsNNA/+rqn5Ay8XKAdmCD060zIF4/Mxb
 f1eAYCkw=
X-Gm-Gg: AZuq6aIWPM0fNMmtepLXYpceNTQMRiuHW0RJvaTLVS52QqFFDwmsiG6oNzXXeOiGIgg
 IQQV8tLHQt8cbHck17xWMjuksmeyqZuf70NCQQrby//oqTHzVXQAch4ls97aedTpgwChDxkH9oy
 0D5hS/UODOQukS2zecgpX6GYmh8M0L7WskcPjyHB4GV1WFY4GU/ZQEAgbsBN+iwe86u259kfiJh
 yfOHuJ7hNNUoQcFANprQZKWJ+tA4ECj2TATN8c81K3mxoSD5I0PHB3N2Pm2IAoswtceV7IUb0OQ
 zV9lMXMvqlRTFOHTlI+Mlg5kVePAtO7HokayedJoy4g/ZKrQll7zef4jbHKh7fIboqCtM28iLj0
 7Yw8GCTGvlpcOU04vVNIUrfOpd7O+mLhUakwicnIJMbxCkgN9gargF+Jg8gRueDrrTq5S6qjxUL
 nnTWC+9OfoPEasHNl69mWnxQi+LFso5a9HRm9IaYAIIZQ8PgwjV720EBtzO2XuGp1qFEGdQH+ya
 IR1or3N50KDcDNfoqh1QFd7gZKAmSTZpezv3qKSDUI2EPsOgr0hrQw6VxuaSsEv7OJS7coQT5oc
 0No/oqM+4QRIbVX3IlzASzzUXChfJCdgCdE=
X-Received: by 2002:a05:600c:c8a:b0:483:71f7:2782 with SMTP id
 5b1f17b1804b1-483a95fc09emr38949375e9.12.1771666984641; 
 Sat, 21 Feb 2026 01:43:04 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42f3968sm42694225e9.19.2026.02.21.01.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 01:43:04 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 5/8] spi: stm32: clean up buffer length assignment
Date: Sat, 21 Feb 2026 10:42:19 +0100
Message-ID: <20260221094252.3103034-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v1)

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

