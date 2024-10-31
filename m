Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D9AD767F7
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92F3688DF1;
	Thu, 31 Oct 2024 19:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MtajTQ5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683CF88E43; Thu, 31 Oct 2024 19:37:38 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BDC2889E9
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b1601e853eso85822485a.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730399855; x=1731004655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JCZAcSLT9oUuZ9YBJRpjg5kjOb2Q6n0Fko8hdOVhfpc=;
 b=MtajTQ5AsI7zhGpL7pGR9D3FOENNJ7BxkSXXSeluvBasj4deIothKpEQv27zTxs0wh
 9K7jNbPl8ACbor1piqkDDyUkvru/PY5lgkDczxt32CMXHJmFymUTSyX2YQAO3B/2pm6v
 Sq5kcnNnpFNYfsH8ptI79niaRM3VV7ilrYJcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730399855; x=1731004655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JCZAcSLT9oUuZ9YBJRpjg5kjOb2Q6n0Fko8hdOVhfpc=;
 b=g8soNRth8YzQV6azVQXoN9KUrDa2P4alzGBsGNhVusas5UGxajLSXAvH4GLZHDno32
 PYKj+Gio+z8G/q6F03Tzz9AC7aIiase9nP17ETIGugcAQbWlDKWwtdvcEuVuxYQOgBK6
 /cxY2STKYu+S/B42ZPDshnSCXBKoJG2vv8nqJutRdANztXIlQri/LnBln/KRPbcbTIrl
 O/q1/yCPDSqRqHvD5KaKMLZ+o6ZjT2PRrmT3Qh7XRI9esDHo39gH2CAcngEHWyCrJ6gr
 KIQJgxy0edjttPe/beG7JNZm9+CW1WdObgNm8G0fFMknA69AmLQHIfGK62UQb7XJGFcF
 MNKQ==
X-Gm-Message-State: AOJu0YyduEbRoea5g4QE8U1rx3N0uPiXaI9dkeyeLCIcAcPo0QoWi2QA
 SFUWAaPaE8EJiBTz1d9dpiqR33VEkLUxaQRdnrY3ycRIxIIrSetRkVlQ3SsBdY8eTCzvcXvtCMF
 xvaI=
X-Google-Smtp-Source: AGHT+IFuAtLnH4Q92sgvjwRs2tWcmIdoKsUugwc/JMzktNZ0I7IMF20yLUeyZcl6qp1Q+D8PIroD3A==
X-Received: by 2002:a05:620a:c43:b0:7b1:4174:ac78 with SMTP id
 af79cd13be357-7b2fb89dd56mr100220485a.0.1730399855162; 
 Thu, 31 Oct 2024 11:37:35 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.104.2])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f39f7d21sm95303085a.30.2024.10.31.11.37.34
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 11:37:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] mtd: spi-nor: Guard SPI_STACKED_PARALLEL with DM_SPI check
Date: Thu, 31 Oct 2024 12:37:32 -0600
Message-ID: <20241031183732.3602102-1-trini@konsulko.com>
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

While we want to compile the SPI_STACKED_PARALLEL code everywhere we
can, it must first be guarded with an #if for DM_SPI as not all cases
where we have this code built, such as in SPL, will have the relevant
DM_SPI option enabled.

Fixes: 43423cdc5dc1 ("mtd: spi-nor: Always build SPI_STACKED_PARALLEL code")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/mtd/spi/spi-nor-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index a3a62fff213e..ec841fb13bd4 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3166,6 +3166,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		spi_nor_post_sfdp_fixups(nor, params);
 	}
 
+#if CONFIG_IS_ENABLED(DM_SPI)
 	if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
 		u64 flash_size[SNOR_FLASH_CNT_MAX] = { 0 };
 		struct udevice *dev = nor->spi->dev;
@@ -3227,6 +3228,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			params->page_size <<= 1;
 		}
 	}
+#endif
 
 	spi_nor_late_init_fixups(nor, params);
 
-- 
2.43.0

