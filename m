Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D76CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 167BE82A9E;
	Thu, 25 Sep 2025 22:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h1C+NcXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7388341C; Thu, 25 Sep 2025 22:56:19 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC48830CA
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7a4a993dea6so367073a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833776; x=1759438576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uDEuGXypBg3fMXPcI/0oPVM68g/gcL3wNfLmZ6Bz0FM=;
 b=h1C+NcXRlBwrgADRwEXphIAakrRxed3Ks2zjygYch0la1C0jZtpUgTC/Xa4krMURbW
 xgfJnomXYJto6CgvZgfhnMGt1gu+YGoJ3fmZRovr1DrtK1UlZPpGwUAiCM+UNfXMcKWL
 R0PGyKfM/V3WERUhHa2S0PsgVi1HIyjMSZ8RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833776; x=1759438576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uDEuGXypBg3fMXPcI/0oPVM68g/gcL3wNfLmZ6Bz0FM=;
 b=ey3H90+wpHihRnkYwfQtLgW8vucTe0hBxMLUlewQ5jSz2MJOkfpDjqp615pSAj2/Nw
 /BlsQQJt//uoRv6mvXZ3gGF9Xw2j7aCczAXG8FIH4JS1K4frQocVeKu5FbggsQa/LGZy
 rpmOst+Zdwf6h59dS1FIMZHRsWmg7yW79lFr/cUH8S1nxuZoZFTDHHpHl47DyOTuKwjd
 hTA6eO3E+QkBCI7aiudF/R0HEQMD4EQsM6XKAE/jG4lOy9Ptosv7Yq+DB4sgZfR3sL84
 OlrAfHKoHIVu+sxvXVVJKr0rZzo1CYZZ69+xyUs7hOwgOJJ6H5Oc6FTL8L69PtaRNnFp
 wubg==
X-Gm-Message-State: AOJu0YwxC85ouqh1QJ0/xu54v0lej2rl6d4NwUQB/RzAh1LEIpSovS2p
 50u6gFrqGZzwjy6Rd2Or/hrzBiuO1ZEBVbMKxXOOC6+sc8BLOHWEwyqgEL/lkMid1t1snpZZVWK
 pjOqi7Bo=
X-Gm-Gg: ASbGncuV7jK1ojfRQMGDxfUQxnflhWYl2OjbpHaULweV9+pH8XSNL2VPGu9vADAQdr8
 j2sfu13R5XJYvKcrDqU4Ij3Mca7yNpiuuqxhr5zBpkBqkNbQD2BxAX63XZockkLRcoVBbePZING
 kiTmNHFMqHAZmz/GBz9RYdl6aBZPpn+ZLbFFFAdYwAgkFPW3M/wP++2hwPedYQpuJ2Rk/eccz6i
 IegBtmFuOtI/EF4k7DMovBAy+nTXHAjNHQUNUglBOcqtcnZBsjsiiqisYx1HColaB4tkFtriRxd
 iNEepGelF1AxZkToK9ZLrreuDW9XLP+X3QWY6YH55Ze5qSTbJz6ES85dfMhTgX9FYWzFlk9KQwO
 z+FaMT4Z5dTy6mPPPAMYe4hhgOfeBqa6GJZSSJy4ha7ZnecgY8YJMh7SuFF8=
X-Google-Smtp-Source: AGHT+IF/MRSRr2lL0y2oMmNoVpx75RUJIX9Z1biSY8BD4nv5a/Pur8EWHrJ0voJsRGrK9xOgcU4GpQ==
X-Received: by 2002:a05:6830:4985:b0:757:7ad:243c with SMTP id
 46e09a7af769-7a04b15751cmr2697502a34.34.1758833776128; 
 Thu, 25 Sep 2025 13:56:16 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-63b28448e7dsm333679eaf.22.2025.09.25.13.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:56:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>
Subject: [PATCH] phy: marvell: Tighten MVEBU_COMPHY_SUPPORT dependencies
Date: Thu, 25 Sep 2025 14:56:14 -0600
Message-ID: <20250925205614.3562540-1-trini@konsulko.com>
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

This driver cannot link without access to functions that are defined in
files that are only build on some platforms.  Express those requirements
in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <stefan.roese@mailbox.org>
---
 drivers/phy/marvell/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
index b5f69c0a96d3..c66197de1433 100644
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@ -1,5 +1,6 @@
 config MVEBU_COMPHY_SUPPORT
 	bool "ComPhy SerDes driver"
+	depends on ARMADA_3700 || ARMADA_8K
 	help
 	  Choose this option to add support
 	  for Comphy driver.
-- 
2.43.0

