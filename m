Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A541FFD3773
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A64841DD;
	Wed, 25 Feb 2026 17:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mgU7iZ9C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7D4841DD; Wed, 25 Feb 2026 17:29:35 +0100 (CET)
Received: from mail-lf1-x141.google.com (unknown [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34AB6841D7
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lf1-x141.google.com with SMTP id
 2adb3069b0e04-59e5bfa4f33so6361487e87.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1772036913; x=1772641713;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pcxa8RuAuQ0nAmPNS8KBumLjBig8XfBZxlRBMDFBXrY=;
 b=mgU7iZ9CQcn21metBfLsCDMQVNJh9p0vsC9gFslolwzQ/eIAN9HKrMIrP/BcuHRvG8
 hvzKiSQAyPTKk1Gp1s09GO837OfS/btIdsjdxBmCx0Sp20hRuuxcPPI4FCYOHidmGV1i
 PmPQiSBvNhYJH0TVlawiqEc8lL/4Dk9DrNKRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036913; x=1772641713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pcxa8RuAuQ0nAmPNS8KBumLjBig8XfBZxlRBMDFBXrY=;
 b=kL0vxNIRI8W4GOA6huHV2VXGuryUTK9YVoSuKZNcHhY9nnoxcb2u3EZ63sqMezxtzl
 aIQlsrImuQpavCqMFkNID2KSraDSsrSL4HG2SsNwgF3Q58SR8rTll6wQlAhColvUuVCa
 KulZ/aRKtb8b56LAjJEjjn/XC/kRSVOP0/Ow2B+8tj00eBZ2hwOepvb+KyD7u/2+p8os
 xvfOy+zXgigeX7TbCpBoebscVb6vp1aep2KEHj03ctSPmvoAq2NPvC3ToIoV1AI86237
 Xh+dUXlzNTQY+B9zpUOy0X6rmyBtEYTP2/6WUdvpacYp2N6CN9sD5KDOUV6ced7Fwdsq
 yxVw==
X-Gm-Message-State: AOJu0YwH5Ks7BxVqSkoX0tdQS4M8G1S4GbwwZZ+8bSTgCEtGgvZzfLuJ
 MaQMhjC8UIWobyD8KldvcsR5822J8Pof8QCROYC81UKHe3/oMxSgqw/cDEQlGMHc8/7vF8L64K2
 2OAfPoRc=
X-Gm-Gg: ATEYQzxRRKlLquZzpyxzLbIlY+RC+7kG9uCKS+vZr1dEBItV0m70cwQahJZGr2UrZiH
 cUO8oaboobeknWXMq49o+CMFwcSP13/S1vF6GggyarK/46SL43iT0i9d5zkQ9A0VYuOTyl62LDI
 HFjoIn2WOg6HV3zFXBLYWGoyQuhncoNdwLZD/wncmfIoFW6Z/7c4xzVE7CC7xyVQsm3XVs55t1c
 AgUL1xJrPGHJWTz/+yCOxP6uOALBHThbiJuU83KAaK6bP4J6TdZvc5dEd4N1icgwA43RFkyX5VL
 SPZp7tR5YU7xi8Jtro7U8Ds1i6bCZ33GqAzXqjDAJ+hKSOgVX9IEIQhvBWZX1tWewQ6VlJ7wZks
 vAibj5p5szuAQ5kpq6SJ9o6TkQHCBuPv79ivHd6+p0ljggNVY3VnLVURrtFSpqtPOsc57T+52Sb
 QfZPQPgUjDyaBkhct/uJebIpSg+eOPambGvBfippf1r3qnmSjBqi0SbhfIG2AzqpEmFg9Fj2h9z
 meGwSzz0eh1JFbJZ4aItKR23mIspXHLlrvo0Tfji0nPX28x
X-Received: by 2002:a05:600c:c172:b0:47e:e779:36d with SMTP id
 5b1f17b1804b1-483c219fcd7mr14401395e9.23.1772036343971; 
 Wed, 25 Feb 2026 08:19:03 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.43.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm186562265e9.1.2026.02.25.08.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:19:03 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 5/9] spi: stm32: clean up buffer length assignment
Date: Wed, 25 Feb 2026 17:16:56 +0100
Message-ID: <20260225161851.2475274-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v3:
- Add Reviewed-by tag of Patrice Chotard

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

