Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D015CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 09:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFFCB81E13;
	Mon, 25 Aug 2025 11:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ez4OIobP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2882C828A2; Mon, 25 Aug 2025 11:24:11 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4339C808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 11:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3c7aa4ce823so901041f8f.0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756113848; x=1756718648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0+vi+b8hZaR6aDBiktfCtPbLzvkJ3SOUj0U7Glkjt7g=;
 b=Ez4OIobP9IrwXFHv5MtLMsegXUHUtFnWDyLREDsmCImz1rv1q43N8NXk2eQch9LyF2
 +v1hyCamhHAY5VgggU21JOItaClbNOuulPPc4g+ht4RKE+JXCwUFYSnevovlZnHcP128
 Wmz591d6iFcFCpJkz7xuozhDQEha5jmVfyehErpdV3wJ3tSJlEdeYrxxKZE5OKJdLiiT
 IpPv5Y+52TjskOXaSKE5X4a8h8fHlOSt6Xd6C/bCl6Gh2WUR66P8co6ccpGXuhECT6hz
 ozxGKcOvRBOLcDz7UXVOF851ckddVUjQl3SEqTWgsBEgWyRDu/QRAPMjYu4/FnqwKAEg
 +Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756113848; x=1756718648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0+vi+b8hZaR6aDBiktfCtPbLzvkJ3SOUj0U7Glkjt7g=;
 b=RPtgU6VAQ2N/xnHbv4Ymqtvw8yS3Teikb67rfa4p4mjdhFpfgpkonTL5YlkAI3Zif5
 /a+u7F3DrGT+Er0oG7PmQ0jw9p53cvnJvuuxsFo+klSEPMxYqjfcdcIL52BWAvOaPvmb
 VY2/QagS5idPCjoLmZQil0RvIxdpBSdYRmiYUvPsLRGMeIGvxHgzOoBB+wn7Sfwu1Rdv
 knssRFd7+7Y2+WTqoKzcwBIpJxf2QFQIJRRF/lmNZReU/ubYAIQmeAIEdN/162/21j8b
 4XvMgc8w8kvQYv9fLuavU9NELE50VVnEzFIK2+kCT2IISdTo4EJFM41McJC1HOEmWTiZ
 7GbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLItTDdWccYG3izi/fh+I1PQVhN6TC2KL6u7M6auuk/WDBYaR2HC3H93F0uwnpL3imn85UOm4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyel/tFC7lGmZCA9n/qCS8tRLCs3xteDFrhqHIYDmWCeTC6LJOt
 rPbrgzUTAnczwK9CTXEiPv51GoRvx2F2KOAMGNLSHQwEQlGcVZ4SBzBy
X-Gm-Gg: ASbGncslybRC49kfS7GOnnME0sHI4ZHDji2l3m5t6N3z4Q9EYD54cVo2azWv4T1A7tL
 cLm9Rg6YcjL2AdhQATMTfaknVxU1BXeP7iDamKSKhuL5c9saepJ7l+mB3mflisrbtiJtZ3JhTX2
 FFGOQL/+7B/LqbdpAVr0+PNvkid/v+bjTRqcrYfHyx8HM0Vk2oXKB5sfsyAhNui3vVRkYPP4yXv
 slcBjL8eqTMPHV5lZT8ZNDOJ56P96yLMegqHMFLMsHG2v0TjZ698ahS86QmeMEqAZBXQNVyoALA
 fEn7M/zKufsgJp7ksqLjuyjh77ozWgc/pgG8shZHflyzzxQnAv4zt10TzbcXC9y3VDv/aMpA706
 FdS4BnJVLvGw7ZguCDoZGJy42Tk0Fn/wFqD259loJ0436PYDovPP2uzLdZDfWIwaK9A==
X-Google-Smtp-Source: AGHT+IHkyoSim0FTzjpTE9ttfSKCmFuqZvf0ZWfJXg0jdmiQmjmslcgyfwLWV8Ly/0XT3rKMMKPuyw==
X-Received: by 2002:a05:6000:2388:b0:3ca:6a35:140a with SMTP id
 ffacd0b85a97d-3ca6a351747mr668054f8f.26.1756113848291; 
 Mon, 25 Aug 2025 02:24:08 -0700 (PDT)
Received: from wpc.yadro.com (host-95-152-62-79.dsl.sura.ru. [95.152.62.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57487910sm100888575e9.15.2025.08.25.02.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 02:24:07 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de
Subject: [PATCH v1] net: xilinx: axi_emac: fix compilation error when DEBUG
 enabled
Date: Mon, 25 Aug 2025 12:22:36 +0300
Message-ID: <20250825092236.46272-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Fix GCC compiation error when DEBUG enabled:

drivers/net/xilinx_axi_emac.c:800:22: error: passing argument 1
of ‘print_buffer’ makes integer from pointer without
a cast [-Wint-conversion]
    800 |         print_buffer(&rxframe, &rxframe[0], 1, length, 16);
        |                      ^~~~~~~~
        |                      |
        |                      u8 (*)[1536] {aka unsigned char (*)[1536]}

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/net/xilinx_axi_emac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index c8038ddef1b..00de2a61e85 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -764,7 +764,7 @@ static int axiemac_recv(struct udevice *dev, int flags, uchar **packetp)
 		length = rx_bd.status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
 
 #ifdef DEBUG
-	print_buffer(&rxframe, &rxframe[0], 1, length, 16);
+	print_buffer((ulong)&rxframe, &rxframe[0], 1, length, 16);
 #endif
 
 	*packetp = rxframe;
-- 
2.48.1

