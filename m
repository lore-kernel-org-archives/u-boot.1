Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42B6CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 09:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE95802C1;
	Mon, 18 Aug 2025 11:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ud7tht/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1BB2803DF; Mon, 18 Aug 2025 11:24:39 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B464D80194
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 11:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b9dc5c6521so2806357f8f.1
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 02:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755509077; x=1756113877; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UUzaGZJK8OmE4L2X28GYXXAJb0dAh8Y3zCOaGzft2HQ=;
 b=Ud7tht/Bb6EWNN7AAHR9c7tRGEpgy28B7jPsMjpRS+VwT3Er1QRtZF98f2jxQyPz4H
 0YSwKJWi7FY8PYzat215ExUua3+Yj1sE3FuBxSNcxmtGYEJO7Cj4fyYAV2y1xW5js9hv
 Z+5mC2zfo4rbWgIw20nZwcv3lX3SJa8Cu0J17d9/2Lj2bf8RinGNvixBabcGpIYZh5HI
 FWUJT1ruDe+ky0pTme+4E0jz7Yq/ZPXeZZWbRKiuJSJB3fqQaog/4bYSNl6Uoh5ic1q6
 TXqYiEh4TfBxLygslOfYfHrGf+kCwVxEmE1J/fo7UoHOSx3ca6J+Hhjr7ivD0JfYlZrv
 jdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755509077; x=1756113877;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UUzaGZJK8OmE4L2X28GYXXAJb0dAh8Y3zCOaGzft2HQ=;
 b=HMFvS/Uc8Bf2uIHX7wJjWJgYcwRCfj8/7rDT7RzhRMb3SxU+4+iVDi6qozjgAlv25c
 DpGf2AQLklyVR9q+jwTsR81ci3mbv4VYDDUwuQflHI5VJ2oFT4Au126SmhdWe/CSH+Gw
 xCzlaPj1nB4jv7MA2ihrRFo08JB2hHMcwMSRStxmxxVZTjn1eU28mIsdBcjVqr4dgPOL
 o4UpW7GfcZhT+USY/nMCx9KN170fp3n/L7P6+J3v7HbknmTdwnwEz+W6Gytsa+3Pshdj
 xIHaKJ81kGRZFlNHi2vqVZ9NkVbX/MKCX6+wmeSQPH8/rRlTM6dDiFfQkcZ5611Uy5ga
 jQ3Q==
X-Gm-Message-State: AOJu0Yz691QxXhAKQ9NOPROddBpLEwqG4y4AGFihMZhYgbt4zM1mJMsr
 H55KV3GKtSEG+MRxuAC99g3cVFpIb5wPc/QPFlVqNHjD410MleUkkuj7RMMmasK85hM=
X-Gm-Gg: ASbGncuwCPgoMJKoTMM23JFXg0g8oGVXUJYiXo02oKdLqyF8DvHzJSZw4JwfdXxeIib
 DJuIYfYr+NWUKVqC76TT6eV9qxUX8zer1nmIrYUqQiPoOkohX2YU/VSJvasML952uG+6ibsyRa5
 dLgCNsHjNBD9pw9gei2tUvHmkfpyUs7XBFM9UmpFbLwyhifr/bvHtZdNnt/NzT6Ew4gsJdBLmfK
 fWFqAiGOn/hMj7BkjY7r0pDgfLMUzA4x5DFtNM9hWhc2Kf4DW9y9r/wKaE8v0E5zIxQbN6nAQLX
 eHlI9OFjswm0t21sPBE+GDNcJrGvhRBI1UCFHkcKSq0xCIcwWUZ4uMOyFN8SewyUFyWC79ziHi4
 evR3oSgatbju9Sqt9TQm1ikEQDpY7TWQxMdAFzLAwBxSDRo+4XoY=
X-Google-Smtp-Source: AGHT+IG9nVjVToauHrCp9iKbMBdh0SL6KEIGeuwTSHwU16cPu+GYLUKLRW4YfnIamKglHaJxYAW4ww==
X-Received: by 2002:a05:6000:4308:b0:3b7:911c:83f with SMTP id
 ffacd0b85a97d-3bb6636ccdamr7013216f8f.9.1755509077058; 
 Mon, 18 Aug 2025 02:24:37 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:69b5:38a0:910b:c9c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb64758561sm12216594f8f.11.2025.08.18.02.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 02:24:36 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 18 Aug 2025 10:24:36 +0100
Subject: [PATCH v2] net: axi_emac: Fix timeout test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-net_xilinx_axi-v2-1-6311cf59451d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFPxomgC/3WNQQqDMBBFryKzbkoiNDZd9R5FZIxTHWiTMhFJE
 e/e6L7L9z+Pt0IiYUpwq1YQWjhxDAXqUwV+wjCS4qEw1Lq+6Ku2KtDcZX5xyB1mVs6jw8aZwRo
 DReoxkeoFg5927Y1pJtmPj9CT81F6tIUnTnOU7xFezL7+bSxGGaV1T9pq63xj7+VCiecoI7Tbt
 v0AM2r7s8YAAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>, 
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

The timeout test in axi_dma_init is not correct due to the
post-decrement used on the timeout variable which will mean timeout is
not 0 if the timeout occurs. Make the timeout variable an int instead of
a u32 and then test for timeout being -1.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Refactor the code so it returns on success from the while loop
- Link to v1: https://lore.kernel.org/r/20250806-net_xilinx_axi-v1-1-00be06069c76@linaro.org
---
 drivers/net/xilinx_axi_emac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index c8038ddef1b..22e119370c8 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -558,7 +558,7 @@ static int axiemac_write_hwaddr(struct udevice *dev)
 /* Reset DMA engine */
 static void axi_dma_init(struct axidma_priv *priv)
 {
-	u32 timeout = 500;
+	int timeout = 500;
 
 	/* Reset the engine so the hardware starts from a known state */
 	writel(XAXIDMA_CR_RESET_MASK, &priv->dmatx->control);
@@ -571,11 +571,11 @@ static void axi_dma_init(struct axidma_priv *priv)
 		if (!((readl(&priv->dmatx->control) |
 				readl(&priv->dmarx->control))
 						& XAXIDMA_CR_RESET_MASK)) {
-			break;
+			return;
 		}
 	}
-	if (!timeout)
-		printf("%s: Timeout\n", __func__);
+
+	printf("%s: Timeout\n", __func__);
 }
 
 static int axiemac_start(struct udevice *dev)

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-net_xilinx_axi-9ca9a791d611

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

