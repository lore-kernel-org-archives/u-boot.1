Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4E9C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 08:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48BD387947;
	Mon,  8 Apr 2024 10:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N1ePygAg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46E1879AF; Mon,  8 Apr 2024 10:49:54 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A609186E40
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 10:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6ea147a6a95so407171a34.3
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712566191; x=1713170991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1CniNeUP/B4JGx10cOVk2Yr6HgVOymiIFFDhXaDZYoc=;
 b=N1ePygAgM4z+Z0s3n8vqNnoZXf0bnhqKmI/r21g3M/c5N3naFq4UvzPj5olxuX9ml5
 5//jBxjZ+399ZGY3/ByagWHPdoIaRF1IrsVG9UFxtg3fTpblmB0SCHwIAA57Z7umuprf
 fw849gdfUiT5UbzxugjKpdjWiEztLYRJ/Q3LuU/V5aNNSe4Z3lIfJZIflB6dke8r2QMI
 4SvtzYEf3148N+VCU0VOCnkOwjwHCP8oIIxUBF2aQYtJE6CMF8khSetX4F+VgyO9tta0
 y2tcRDLcEEEekIEJ8Cu+kEpMi/lwqE9H1h9sB/+6RYkHV691XEMtIQ8pTGal0ZLz13Y9
 G5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712566191; x=1713170991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1CniNeUP/B4JGx10cOVk2Yr6HgVOymiIFFDhXaDZYoc=;
 b=BoydAmUEQJ++mX8Eiwg11BI7ySKcj+4LOLHyXVICd6YirjcRoo0+c4+cIEmq3D1VB9
 cxhFN1y6nQUZ8XUiIeEWJPab5LdJqRMJl2Ra43JMbosYIrbkEB0l5lpX99A0DM4kv+Hb
 fXLEFFHcG3IaYZLQg7CceacmIfkSyHl1OggyDShOZHeJJTeIY7hodCbN5Lz1l4Mf9PXm
 IaYgeYoZayCkXlQRQIB5VGz1JZ9CxdXgfIozEIkuV7j/HY8Ds+aEzWbveGBRgnk3qNL4
 Wdak+gZaGLc2hRsCEdOSNYNrYC2SBgY2Mv4Fvh0fHEL5drfOR8s+7jYR8msqUFzONMws
 U0gA==
X-Gm-Message-State: AOJu0Yx6k8Np4rjuQrfxpcE4ccQpQu+2ME6Q1HLMcCRvUx/eLsKZpnAS
 +dvmiHHBpauy/XahtYCzaK5reHrldxBLMFcWHoqOzIU4A9eA0Jue
X-Google-Smtp-Source: AGHT+IFNyQLw8KX2KdFeRxMdS7QGPV09D9oyb6MRn8cjAoTnZtRcng/x1oxRfES2SOFYlBVHlb62KA==
X-Received: by 2002:aca:2204:0:b0:3c5:f133:1398 with SMTP id
 b4-20020aca2204000000b003c5f1331398mr2794208oic.25.1712566191280; 
 Mon, 08 Apr 2024 01:49:51 -0700 (PDT)
Received: from localhost.localdomain ([116.89.141.171])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00218500b006ed4f616ec4sm723355pfi.57.2024.04.08.01.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 01:49:50 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Parvathi Bhogaraju <pbhogaraju@microsoft.com>
Subject: [PATCH v1] net: designware: Invalidate RX buffer cache before freeing
 the DMA descriptor
Date: Mon,  8 Apr 2024 16:49:02 +0800
Message-Id: <20240408084902.2848964-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

In IPv6 context, the ICMP and UDP checksum byte in the RX packet
is initially set to 0, recaclculated, and then re-inserted.
This process can result in a dirty cache line. To prevent issues,
it is essential to invalidate cache for the RX buffer before freeing
the descriptor for next DMA transfer.
This ensure that the dirty cache line doesn't inadvertently written back
due to cache eviction, there by corrupting the RX buffer

Signed-off-by: Parvathi Bhogaraju <pbhogaraju@microsoft.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/net/designware.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index c222197b11..03b531c667 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -554,6 +554,11 @@ static int _dw_free_pkt(struct dw_eth_dev *priv)
 	ulong desc_start = (ulong)desc_p;
 	ulong desc_end = desc_start +
 		roundup(sizeof(*desc_p), ARCH_DMA_MINALIGN);
+	ulong data_start = desc_p->dmamac_addr;
+	ulong data_end = data_start + roundup(CFG_ETH_BUFSIZE, ARCH_DMA_MINALIGN);
+
+	/* Invalidate the descriptor buffer data */
+	invalidate_dcache_range(data_start, data_end);
 
 	/*
 	 * Make the current descriptor valid again and go to
-- 
2.25.1

