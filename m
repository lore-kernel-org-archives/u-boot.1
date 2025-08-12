Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6B4CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 16:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ECA283564;
	Tue, 12 Aug 2025 18:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EUBxy3Th";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8842583577; Tue, 12 Aug 2025 18:29:11 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC9BF83542
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 18:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b8d0f1fb49so3369565f8f.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755016148; x=1755620948; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j8ffXI1oR2HgX6CVwfjOMlt6TcJY/9lrrPOyHKVusDc=;
 b=EUBxy3ThPEwMP0YXRKrs/sdL6oTM4iSzmUvBC4v4hxEvmmOjwn6ZJ/DzCCWxYHnwwA
 g7nbOH6IOXDyQTBKoLDsjQ4Gv+DNLx0TCSgS9OHlFpovlgkwe6Ly6pZyAEqIhMGVvDJH
 zEPkAqVt5fQxBFyx2q8P0px/k2Pf/6Q5P64oclIae9jQ+uNyksUpt5AK83Ip4C8CRNBu
 GhfXMvdZpn+aW72xgU5aTg+g/4TwyrW7L3clm48DjdZljCADvqPmZojKuy9vKVU2SZwt
 q7TC7sXbfuDn74Glm85SByprN8G2DqdQ2obr00uCUvxBZb+ekz9zNakDA6XvUcq1SJTd
 qY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755016148; x=1755620948;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j8ffXI1oR2HgX6CVwfjOMlt6TcJY/9lrrPOyHKVusDc=;
 b=X73FMnBnszEvW8ZLWUhA22nC8w7S9kV8X3QB04djDj4p+xGC1dbIY+G/U5fh21S9KT
 RIcg2jTuoXcxQbnKstQvq4OSjTZxcbO7BFPKE+2oqpI+Oxp1jL/7YAC2sr4kUidlD/Nz
 lM441OKq0j2IOoBDlGwua0DL+I8/E4As/RxwzPqmHCD6WnVuyJmCtJazAIcidj55qUTm
 FQwgg7ZH4tc0G5/CZRYGwt0z4UZE3ZQwPZRGcWr2ZRaYH07Ns/MjVxS+4oXlBXOGq4h2
 mYRWxmq7r2raCadwp6zJ1OMOJNPaUKx6VDE3NWfuxiteBggSjoYh5+r/kORZoGN0FSLi
 rDCw==
X-Gm-Message-State: AOJu0Yx2RvNjlGUNmlXRuCfSUJq8yX2RHiTE5HT3KRGGj/yeZiwEXPeL
 zNK8Di/fPHCZ55afsi3ilPgBxgsxTuAlKEjOgo/FjSNExz0G9jIJAgRhq9qpCQn2l5C3e5tB6a5
 gg2vi
X-Gm-Gg: ASbGncurYhrBZL318fwhYA1rtGt8pvVAZk+zSlXZ9en3hS1tMUCz+L/BKDXaBJRy/55
 7dL2Ixg5EtBzSTTwIsgUsm9yGyUYoZPcC6QA8aDJwWszjj/xk65YdSfkwl72u5e5l+fGnTBS/s7
 2nVTNH/lIn783GoX0i6VerkRj6tAPw3e8SlxBR2PAVlkYZ7KpyoRQTTPVarfYPbdlM9onX3rZyM
 +1tgTuW2f8++o1omKCuYHsQRKTjA6ZJzGWaXUD1Hiy1Eb/PwWpgSdRPx7fz9F09vqWmJANGdT74
 QsOo8I6wxDOwiWduhXs7rBIDUKu23b9WZL+x46rOwL4Exkytil9MovuyI8sokPnBSAgYVF1iyTh
 FMI/oA9IYKFdYZieZwkX7KkqCEEb21Nm18dGD6x0INCL6JJxNjW4=
X-Google-Smtp-Source: AGHT+IGlXgQU0qupl9vga7WFR7Gul88yp1QhUX5I3iB2NqRLoGVUdd80rfQ9KtUZ8bcAeBsjuFIlCw==
X-Received: by 2002:a05:6000:1acb:b0:3a5:39ee:2619 with SMTP id
 ffacd0b85a97d-3b917325263mr27383f8f.47.1755016148304; 
 Tue, 12 Aug 2025 09:29:08 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e586a011sm331444105e9.19.2025.08.12.09.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 09:29:07 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 12 Aug 2025 17:29:07 +0100
Subject: [PATCH] spi: npcm-fiu: Remove repeated test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-npcm_fiu_spi-v1-1-8713d9e2ea72@linaro.org>
X-B4-Tracking: v=1; b=H4sIANJrm2gC/x2NQQqDMBAAvyJ7bsCNVEO/IiJJuuoe3IZsK4L4d
 2OPMzDMAUqZSeFVHZBpY+WPFMBHBXHxMpPhd2GwtX3WDq2RFNdx4t+oiU3TBqQuYOPQQUmCVzI
 he4nLHQnt31unTBPv/0s/nOcFKepO2HUAAAA=
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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

In npcm_fiu_uma_operation to enter a code block nbytes must be non-zero.
So testing for nbytes inside the code block is redundant and can be
removed.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/spi/npcm_fiu_spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/npcm_fiu_spi.c b/drivers/spi/npcm_fiu_spi.c
index 7b8271c8bbc..761ef8c058b 100644
--- a/drivers/spi/npcm_fiu_spi.c
+++ b/drivers/spi/npcm_fiu_spi.c
@@ -273,8 +273,7 @@ static int npcm_fiu_uma_operation(struct npcm_fiu_priv *priv, const struct spi_m
 	if (op->data.dir == SPI_MEM_DATA_OUT && nbytes) {
 		memcpy(data_reg, tx, nbytes);
 
-		if (nbytes)
-			writel(data_reg[0], &regs->uma_dw0);
+		writel(data_reg[0], &regs->uma_dw0);
 		if (nbytes > DW_SIZE)
 			writel(data_reg[1], &regs->uma_dw1);
 		if (nbytes > DW_SIZE * 2)

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250812-npcm_fiu_spi-36b1e7b13818

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

