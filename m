Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C7FC3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 15:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D667888800;
	Tue, 30 Jul 2024 17:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VkyBOurc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4D3887B9; Tue, 30 Jul 2024 17:25:45 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426478885D
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 17:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7ab76558a9so903263466b.1
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722353142; x=1722957942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aLZfXeBptLmfRdKT/HDaseMEWqjV99jTJijJWO3V3uc=;
 b=VkyBOurcjCRNmBELgcC4MfXY6XslmwYVdVyUBR5zMIQjBwN1asa6VuX9SGMRlDnyb1
 FgMMCxPGRgDOCnOx3Q6BgC8yKyEWk9DsoNYmD5O/wFanrD3oSSRQuG91Wpf9f+mhrRHc
 R8ym+XnASKzYi8xPUMvo59eivANRGNyyMiACG3md0933o0BGcIP89AfIWKkwm06dZuB+
 AkayyORHwX5HGUms32Q9v2Sz7vshqfygLSBP+/8x9PpebgEF33WpXlFHF5SOTmnumdHY
 FWqILb8IlU96G+CuNRzrC71ucZyRjXq9CYNF/ntYauHFQ5UUuwWhDvzu+CbRPBjsPQob
 2CIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722353142; x=1722957942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aLZfXeBptLmfRdKT/HDaseMEWqjV99jTJijJWO3V3uc=;
 b=SGS3CX1Rbv+e3yq4LeKDZBSlBGxzwQzsBwmWkChTxFb4/MKvRGP13B/o9Vy6UDECgE
 kgWBbyncZNfbn4/Vk/RXC0vaS+f6AdC/QalO/n5HJeRvdvwHjRPslXfJlOROQOVKXluS
 1VNAVOqJWn9WQY50+dAv7LNDutzGQdF0L1o+4U8KTCrWv3XgIpAgEcnjnTHPzLNjQTIG
 sd5AMLMQMfEaZEgzaGgpd0shNJ3u2RNFTlHF6LVYMEsMC/wuinxtGoWcTzhNzvLX6rpE
 r92Hk+HOQAsep1liiCeeyXyupVkZZ8Q6BaPqHwkiwKZl5q5Cq2OK7OhdNZZUjdb7552M
 cRjw==
X-Gm-Message-State: AOJu0YzIEJ/kXqR6i+BUUZhr3sQ+B3tBev+lhNffr+cSRREhwwTuR1kA
 +o0Stlip0Y3UXNXtwmJnaoDukrbsrYRLD/zI1ctELRnWuWmso4i1UmB48Q==
X-Google-Smtp-Source: AGHT+IGm4FtEtMqZmI7PTPRu0DAqaWOnW8UlbOoBuvK1sOTBBVjmrVSob2YT1/2Wi1w5sqpE2IIc+Q==
X-Received: by 2002:a17:907:3fa5:b0:a7a:bae8:f2b5 with SMTP id
 a640c23a62f3a-a7d85a9b845mr288485166b.36.1722353141828; 
 Tue, 30 Jul 2024 08:25:41 -0700 (PDT)
Received: from localhost.localdomain ([147.161.231.74])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab535a6sm654333466b.88.2024.07.30.08.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 08:25:40 -0700 (PDT)
From: fedorross@gmail.com
X-Google-Original-From: fedor.ross@ifm.com
To: u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Subject: [PATCHv2 1/3] i2c: imx_lpi2c: Fix a typo in bus_i2c_receive
Date: Tue, 30 Jul 2024 17:25:27 +0200
Message-Id: <20240730152529.143651-1-fedor.ross@ifm.com>
X-Mailer: git-send-email 2.34.1
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

From: Fedor Ross <fedor.ross@ifm.com>

Fix a typo in a debug message. It should be 'for' not 'fot' .

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
Cc: Heiko Schocher <hs@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
---

Changes in v2:
- Add additional '---' below SoB line to separate Cc list. This way it
  does not get included in the commit message when the patch is applied.

 drivers/i2c/imx_lpi2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index a1be841b119..3c43f61d819 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -130,7 +130,7 @@ static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
 
 	result = bus_i2c_wait_for_tx_ready(regs);
 	if (result) {
-		debug("i2c: receive wait fot tx ready: %d\n", result);
+		debug("i2c: receive wait for tx ready: %d\n", result);
 		return result;
 	}
 
-- 
2.34.1

