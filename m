Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9F8CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9675D835FD;
	Wed, 24 Sep 2025 17:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="bbaFgbMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E21682998; Wed, 24 Sep 2025 13:31:34 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF3EC8349B
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 13:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b2e0513433bso447656766b.1
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758713487; x=1759318287; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uSDQmodJg/I49HSH15saBOf53KxqKUJGHnVcuJl/2SY=;
 b=bbaFgbMoopALh4GpsBVQDm6UrfiS70cDmTBVtDDL6w2S1ZQwy+OwH78KVAOttBGtWn
 WgNyBHudp6qVJcTgML7fFxED4Udj9iZQ96Ytx0BApq+fSHE6rY2PUZbBha7D6aJi/H9p
 K8yAPj3a70gda8ZFlX9qNl8x4UqqmEP8G+O5dMGJ0L7+v5aF2VbNOWY8oGd2MY4eRrDh
 lyQyFaKiKvbDcZ8AcQK321Wt3izCuu01HhWPJtx/lBHoedTOJA10N5+KarWRCG7CH3jw
 RozFoWDGtZYeP2YwZp2Wx8zf+UKJDAYJxOacjxfsIEGOKJypit1dt2xA65EHccpW+65A
 Tagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758713487; x=1759318287;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSDQmodJg/I49HSH15saBOf53KxqKUJGHnVcuJl/2SY=;
 b=lEY0QFfRgUiCn5i+kRUfYH+hbCy8VQpH7ERqVhOLKPoDU2LE7Rhj3Y22csdN26bUbP
 cvFf+oLy6yEduw4KTwBgcslxPjpwh9d63wp5HZh0fFIJ6/yh4cN1XtwvOOkHm8hj3/lL
 OZQLONoiukkVOgI0WoMPz5YI2Cn9qHC3cV+z/vyNRjPet5gcLMJ/esQSsZBMJ7rXIjgr
 eKAdUBf/Mc0d8ZDewCHDGEQeKgKjH27n17Wj1b7DtWuSy7n83JNeoy/jeq4FkYGDHVd9
 zOzpga2mvLcFeB2odFypGoDVeW3hM36F2x3ABcIGH0TEABpvJV3J9ravNsgZq8yL33sN
 ziqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1UIhbKogewV9RzObJM6HeEEig9yD9Nbx9EE9xGzSXItdU9XPISWVUDUrT7W3tZ5uLzAlAaj0=@lists.denx.de
X-Gm-Message-State: AOJu0YxK34IMQLbvkN4pmpR73kJ6AmHGMZMutzLjoYYbw0OGCDDfv94g
 D05GmZkciTAfKu65CPffoZUBrKVEeS0Ll+XTYt1f5rX4kRlkQ4foq04Tzg/WxXpQH/E=
X-Gm-Gg: ASbGncuUNktRnsTDK9C0dqfwpZXkVVdaAuY23rgUXmhByLiPCOGNVxG4TOdj9dZgQrA
 IaNNIvWi22t/QnmuBaHpCUK876FLIMxgG02ZbJuAY8D5hfUO9bfpr3ZVew4xE1bMsd/4bUKzR0O
 Bg6zs3NX6zWiOvzYWmGgTCQHRBCO9BCqFEM4Yv4yZl57iAhDz9QhGSKHzvZKZkVJStpUd1WdqvM
 QYWXBxW9AqiXHF0D93DNIYrAoZ5VLbHk3bJJp2jrPZbHlJzPrjV1qhH6IDGngeOmL4s75KLb+xo
 e5sKABtVUA9m1uhACnlgjz2rENUYwOY2ZBOpagmcv8j7O6eXlYiTjCC7lXXrTrlHn+BeYQkwKuX
 p7MlfqobDDPXMKlBlsf9P+frWzFCS4Z/HJmMj/qPvDqyfw1pMZWzLZJnaQjZcSNm13wquU/QPj9
 fmwotp
X-Google-Smtp-Source: AGHT+IF9LDY2WLfgpiGd+ybFZ7/D6XoFhiGvOUuvhmvVX2JY79SZ9eWbygO20ufkm6g3qXit9O3tcQ==
X-Received: by 2002:a17:907:2689:b0:b29:e717:f0af with SMTP id
 a640c23a62f3a-b3027d3fa99mr641489466b.18.1758713487274; 
 Wed, 24 Sep 2025 04:31:27 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3339789812sm96698266b.17.2025.09.24.04.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 04:31:26 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 24 Sep 2025 13:30:09 +0200
Subject: [PATCH 3/5] serial: msm-geni: Update kconfig name for
 DEBUG_UART_MSM_GENI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-2025-10-misc-v1-3-7e75842ca714@fairphone.com>
References: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
In-Reply-To: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758713484; l=908;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=AIz/hQoVV6WXlXRe6MUmReRvOUItBusLzIDwDjopSN8=;
 b=0srU8Qj8ia6YWXSxqDf6uuJ2RzIt53GO1aA/lImxeNrFnGiL9ilw2q6504+bC9zCqWaGG44De
 eS0qKKDzNtxCqHfmTFJ5fIRke3T6evp9TsDKnsvmRnm96M4NG1xWblL
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:25:44 +0200
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

The previous description "Qualcomm snapdragon" barely tells the user
anything, update the name so that it's clear which configs the user can
choose between, namely the older QUP driver, or the newer GENI driver.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 1f2f2468eb0b32327785f4fcd184b2b6f03a15f6..ccbb40b34fef16e2561bc4bb3ca3284fa700988f 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -328,7 +328,7 @@ config DEBUG_UART_MSM
 	  be available until the real driver-model serial is running.
 
 config DEBUG_UART_MSM_GENI
-	bool "Qualcomm snapdragon"
+	bool "Qualcomm GENI UART debug"
 	depends on ARCH_SNAPDRAGON
 	help
 	  Select this to enable a debug UART using the serial_msm driver. You

-- 
2.51.0

