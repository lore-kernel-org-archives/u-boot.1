Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB13CCF34B7
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE7B83F42;
	Wed, 19 Nov 2025 15:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bYTOtQqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4295A83F87; Wed, 19 Nov 2025 15:50:40 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A3283EDF
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c704bdd57aso2895714a34.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763563837; x=1764168637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+zI5xihQhnZyx0af7H3iPOheo6AEuQOhBOcviuv+Kvg=;
 b=bYTOtQqJu0m8U6DeFI9hYGixLK6hQ8mENhc3+6snC+IZXdeNnNSITk+OMOaGghvCkh
 UxEg1ZuoB/POGZEefAoHQiGLIwPJcQccaaYIIrA7inF/gE1XYdNl32hECzr8nQHvFKSI
 1dvENmp3MkWKQQcfXe1y36H1hemZJA6OhIED0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763563837; x=1764168637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zI5xihQhnZyx0af7H3iPOheo6AEuQOhBOcviuv+Kvg=;
 b=Z5cwcad1EVSeoT+ebK9n4fsUnfeztnY0IQbWHrJKMCRBEaVG4i1Unuw5S/DT6mJ+g7
 JBnDnotpw01iEv59Qcz7s60gTW+kP5NbV5YRv13ABkEMFWWFGuPe8dBNxNbyEPM+ZTHM
 02aI1eCTXi3EVIxULPPQRzr0LqkdT7F6sCBxbcGU6quwXjSb3A/H0nWSW97bXeRTr5Bg
 +LUKO14U3Od1DolZSJKFe8d6tKKbnfU5oxRDzAUGgApV2tJ9WUWEYxigJN1RVM096BRM
 otW1CHWNmqojTH1num7DQQ1XWa2u7lit1HT2wfea4cf7i0rgt/i+BDHB4KW++w3pzqqK
 MjdA==
X-Gm-Message-State: AOJu0Yye1ivqzpYjTdS0sc2V+Qbr/PCl01BhH5qIQtRd/2mOgafy7bol
 0YfXBddAnP+rVyvmmq0MWI3ClSTnLyEoikzcr4R4wypGsl8TXANmt9s1cd9TMreuEX3u4KRhSOU
 RSowqR/I4Jw==
X-Gm-Gg: ASbGncsCJZPhakf2pAjOCsnzWial5ntUZr355fF2yz3UcWg280VOmoWGrX1wyfan/JH
 ojENWrU0nDUVlncLb+aM4AZLjCzr0uK2uCbqAiVshyhuIRMl3nGmNRKTl8lkFnFPpvepoxaf1tZ
 KHsD/WmtVtWKB2fHIZm7X/V+4cFhg+C4hwGfnp+H9l7rxQLWGX83sAY65T6Mw/HC9yAOAu/xkWY
 GhJCHX55CvvArWbRLd7nyqyMLM7zljpM768dL3PwSf0Ku1ybHQvYSKiLPsd9x8Ct/pWioaObQ4Z
 7lI+/vky5s74Am5yIc6Fw/ydX71olxypqwkMEropYJQkyh0x1f+O1eARDNKHLmoY2QKzj5kJaiG
 +T3ssUdLXquLL03+jxvZ5jTF3rFbEngOWPudt+i00kib9VzKbdozcuHkcb8kUKxX6OWl5TxwS1Q
 5c5L9XQ0qyn8ppvn1tgz6XR2xNGUpRhYmN+q1+cpaN9lpDfcfTJxWl
X-Google-Smtp-Source: AGHT+IE+lp4id1a7w1cBD6D25brXL5yMZc7G9MFTXcHqzd0Pio/oKgSgLNGk7ug4OAf5Uy6u/slZOg==
X-Received: by 2002:a05:6830:3155:b0:7c5:3798:fa3f with SMTP id
 46e09a7af769-7c7443b244emr10754306a34.2.1763563836819; 
 Wed, 19 Nov 2025 06:50:36 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a3bce15sm7781839a34.23.2025.11.19.06.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:50:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Parthiban Nallathambi <parthitce@gmail.com>
Subject: [PATCH] pcl063_ull: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:50:35 -0600
Message-ID: <20251119145035.842195-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Martyn Welch <martyn.welch@collabora.com>
Cc: Parthiban Nallathambi <parthitce@gmail.com>
---
 include/configs/pcl063_ull.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/pcl063_ull.h b/include/configs/pcl063_ull.h
index 0f265adc5dca..a1322a2874be 100644
--- a/include/configs/pcl063_ull.h
+++ b/include/configs/pcl063_ull.h
@@ -62,7 +62,6 @@
 
 /* Default environment */
 #define CFG_EXTRA_ENV_SETTINGS \
-	"fdt_high=0xffffffff\0" \
 	"console=ttymxc0,115200n8\0" \
 	"addcon=setenv bootargs ${bootargs} console=${console},${baudrate}\0" \
 	"fit_addr=0x82000000\0" \
-- 
2.43.0

