Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B614BC83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE22E82F6D;
	Wed,  2 Jul 2025 03:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Du6kunEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4016082F2B; Wed,  2 Jul 2025 03:04:18 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 320BF81E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so3306035fac.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418255; x=1752023055; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9A+EzciHkT3gmd5U2n315HfcSe67y6Prxb03EpybICc=;
 b=Du6kunEmtiIM3S9kyGvEgaNh5YJulb8e5p80vfIiGSIajbqTFVnc3nfbJzwKikzliZ
 dPEPdK/VhOC4Z46WtaA6t2DU3JCPN1TWxS5mqzN5WgZT6hoscxnJunv+6b9Ui9Ju4crT
 oahGbSXSUDngCjsRjXcZBl12bBDV+Kpg0ycus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418255; x=1752023055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9A+EzciHkT3gmd5U2n315HfcSe67y6Prxb03EpybICc=;
 b=Z7YMWlME3E81guqDGv/oQp4AWbUa1RVQ4M5b8lALAkgKDk24dvsEiaEWkwBgCur9rk
 K6Cvxo1v/g8VU6AszQlbpeS9prKwZ/OgjTfPKW8v4HWGnjn/mSwg7DGgXHfn9AyjEuu4
 mK3PMdwMsqZ17dRQILqPSQb7tXB0PF12LyhhjJAVD/JARWYBGNhZy20bcEXYvap8LwcH
 uBHjrdaXWLUMfBZrR9a0BltEixMlcUZNhTw8tQQyILa7PDiqVhLDNFM6UBUNMxSYK2vc
 QJLpDfVIR0nM6BTxu90N1NezzhIPZNuyGwopcoWV7xa1vVV7A1HJtmy5OUaS46SP0kF3
 pO9g==
X-Gm-Message-State: AOJu0YwAyg7AZOLoGN9S2EHUs0Q3OFaOWeERGAQzsZ7E3cmgYFlWgi7l
 tt8kkoqj4VEuGq26+UfT0tTL6Aoe/e2VEuvXxc0HK3eWqSgvSdhBi3778OaQi+pu6d5pz71MmWj
 zLzLDIbY=
X-Gm-Gg: ASbGncv1/QvoOATN1ykDCFS1l3aS7oQPyQ1VDqRf/yKkLHXW5KQ7LPOXKogitGVJ8M5
 sej3WTxtn/fawCykPmoaNKThNGVZNGc+EAuXi3kl1qhMG2T5nT5cd81NsbyFkCFfN3vGkZQqqcC
 f8UdWMMs9zQwW3CWLDyQw/r6OiTneBhHdfBej8EOyMpJE/oHI+6iSr99Xv5DLxoM9rpfoDSxhPN
 OKTif2bfZGd6YiJ3FpZUyHel74cS9c8hFbhdDVDIb1MC0VJUe3y5KhNCNgdHmTOtoulEPjBHRnE
 Eplx6rQSg+GiVF1OKRNpIC1T1WdbfOL+JITwWdGvUSEbGsve5gRE6jXHs0qcxjFq76kirctmgS0
 sgo8TsOBGI88jXXQv2VB2OL8=
X-Google-Smtp-Source: AGHT+IFlUjc5tVnhcp7UtIGW8xWu0IauHu3OLxaImSKLWYe2Div7AZFy8hZRYGmSZrM4I3MFWwR+eA==
X-Received: by 2002:a05:6870:e80b:b0:2e8:f216:7b23 with SMTP id
 586e51a60fabf-2f5a8cef7e7mr679765fac.37.1751418254869; 
 Tue, 01 Jul 2025 18:04:14 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afafee51bsm2318394a34.10.2025.07.01.18.04.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] dma: ti: Tighten some dependencies for some ti platforms
Date: Tue,  1 Jul 2025 19:04:13 -0600
Message-ID: <20250702010413.18852-1-trini@konsulko.com>
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

The TI EDMA3 driver cannot build without platform specific headers being
available. Express that requirement in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e8ef90e2bd6a..1fccbc96f076 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -37,6 +37,7 @@ config BCM6348_IUDMA
 
 config TI_EDMA3
 	bool "TI EDMA3 driver"
+	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE
 	select DMA_LEGACY
 	help
 	  Enable the TI EDMA3 driver for DRA7xx and AM43xx evms.
-- 
2.43.0

