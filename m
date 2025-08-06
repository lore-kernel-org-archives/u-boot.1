Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CDEC87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 11:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45E4839E4;
	Wed,  6 Aug 2025 13:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xhVoe2lK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51B02839EC; Wed,  6 Aug 2025 13:10:59 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E635B839AF
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 13:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-459ebb6bbdfso448835e9.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754478654; x=1755083454; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+hxm2UvePGS4m4+P187GDzh0zAeennOWF1xyr1D9WTU=;
 b=xhVoe2lKUIbZk7KNVet1IS/II3Osdb5OD1IdqI8mxNySC7CvmCldSz/kLJW+Q0l27c
 GtBPighlCOnFITx7fTbEdL+J7h2Y+k6llg6QHu9ViTyhnlYwq40wefX6iEYut7rKr611
 qadrL4hbfxNOaKeJCRPa7hZU/iwq80SxVf6zmkotKGgvRX1ZZ+1In7PiAzFRTqu8YDIy
 Yu6rHtLR0G+plHkhRD9kmciO67qk4tdCGolGzKhia7Wr3vTs/9CCTPkVxov6ePs/Fj0v
 7Z0xp+wE/t7DFZq2yt40a+I+HlKwEraZL4L2Z0FOnKYqRndzhYUAIQAbjGHCd/WRypOm
 RO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754478654; x=1755083454;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+hxm2UvePGS4m4+P187GDzh0zAeennOWF1xyr1D9WTU=;
 b=kJjUMn1AGw7eUWJh8ZTLBBUi/YrZqgP5OtpoplAmzVdd3zMLg2h8ON7nY+1awy7P+4
 Ow8dt7W69Peh4LroBuAl0Tod7ZoGpsgg6F3e/d+ycGm0MiXwzcIiYee87IQzAgfjDElZ
 ZDp6Jc1DcepZ7vWW9NKqJNLLsOsuLIL5MDn4qt+wQce2AcBmvAU8kb2j0CEprx2VDh5+
 CJz8H1dHD/o5K3qk+Qqd374GVgorXE3f6CKKmVhZ6EtN2pbeOeKlX0mwedjiNzs07ABN
 /6MjiZ/zzbTj+fXczlcopI0dwPFXtRd0E90fG+eXrRpTXLh7BMDuE46bHaGwgGj1jN0X
 XBzg==
X-Gm-Message-State: AOJu0YxLIwRighNSjI4doc0z+mY7AYNQ11DI9YotlokpNoJCu8NB/dWR
 1rWKd9R74uNXmRcIr5xztJJX8g7+o+3kehFawQzWLuO8IWFj6cjN/OXiM+NxxbiA0y0=
X-Gm-Gg: ASbGncvJfML1kfYyHTlmdmSeTvZ3XE3SYaKcICSK6bYBACtqTbnrnK1gj6dQ1aJU8Aw
 QQkuJGaIWAvsAePghmqBlu9WzrTuupXySqeUOSB6TAWTTsWAE0iTAm4uMw7DURs7YNL5VQzEwU8
 xHXEGXfiSiBayMJI0TmEYwLATY4Jag+sLJlQp4jepcJFSUd7MS2M/3SWCVvRoUdnTTZmW3mbfiZ
 qyByZnyXXYfj1MtmdChyG5X9EVgJ4MAmrndi1v8crd4BPIQjaCBLLBO1AvvoD4Mb4qf1Q9qy+VW
 eaCzkAuGnr1fyoMpomIP46hWTZ9Y2p5ddHlbHdH6QOqFJ263Zdjt1vw01rzvZDJI10KMAcWTmuL
 xMndZ/5LMhB1zMkst2pf9Bjhxym/tL8gg8SDUfqo0xQND7tKZHc0=
X-Google-Smtp-Source: AGHT+IFxD3i5BtCG2ni79GRxUBW8VpjJLqL8Tx8zZe2ls5ogtEO6mbGFh7eoQhzr4hYhwTn2TxiLsg==
X-Received: by 2002:a05:600c:4e86:b0:458:f70d:ebd7 with SMTP id
 5b1f17b1804b1-459e70d6791mr18830515e9.20.1754478654073; 
 Wed, 06 Aug 2025 04:10:54 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458be70c5f7sm166457065e9.26.2025.08.06.04.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 04:10:53 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 12:10:52 +0100
Subject: [PATCH] net: axi_emac: Fix timeout test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-net_xilinx_axi-v1-1-00be06069c76@linaro.org>
X-B4-Tracking: v=1; b=H4sIADs4k2gC/x2N0QqDMAwAf0XyvEIrTFd/ZQyJNc6AxpHIKIj/v
 rrH4zjuACNlMuiqA5S+bLxJgXCrIM0ob3I8Foba13f/8I0T2vvMC0vuMbOLCSO2MYxNCFCiAY3
 coChpvrIVbSe9xEdp4vw/PV/n+QP9YonceQAAAA==
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
 drivers/net/xilinx_axi_emac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index c8038ddef1b..c46678c1f3b 100644
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
@@ -574,7 +574,7 @@ static void axi_dma_init(struct axidma_priv *priv)
 			break;
 		}
 	}
-	if (!timeout)
+	if (timeout == -1)
 		printf("%s: Timeout\n", __func__);
 }
 

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-net_xilinx_axi-9ca9a791d611

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

