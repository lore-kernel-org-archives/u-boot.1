Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9A9C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE3E82F6F;
	Wed,  2 Jul 2025 03:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rLZHZKc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B0D82F6D; Wed,  2 Jul 2025 03:04:16 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D3381E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-404e580bf09so935915b6e.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418253; x=1752023053; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hEbIhs8cZFSgjn4C3TVke1Hfkj4AZOAMpmamP2gJsEk=;
 b=rLZHZKc2Eg/wYNay12ixEGye6rWDrjdDobcdNoJ7gENESle4JaBtBXmGQ2gyb3cHiq
 Yg02MMDIZpp07CYCP3LhRuIf5T2sf0aX9xKTQ7K32llxlN3rcMaaEZ+9x+3759QRrOwi
 mLIvrqjq3+75EUZDUdzz9q3dOYadyprgmfr+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418253; x=1752023053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hEbIhs8cZFSgjn4C3TVke1Hfkj4AZOAMpmamP2gJsEk=;
 b=EEDSZJVv7Mt9mfSaYrMtUMAWQxkFp8YuID4IKIsB4tPu+5vI+l5arZrxBEGpkddPbP
 RfRYvL5L/E5O2653qwinHzYdxcZlZkOSj5EH7WvkM+Fo7cZv+U0uFHgkjlrF38drct/t
 WxVSCQOO7A51TxiJdN50bC9XNkE8Xme+Y8NLy5elF3Ii8bq//kjtSPyaYJWUezHxAxxf
 ie227Y+R1TkqBFh/1yndkav67Q+qoX0QXrBM1+C8mOGJVq7bNoiqMFEQU+yOFUGCOUcR
 xA+9LoqIewq4VbfAjuQgElJWovAKSoRd4niLoxMPZ1SyHqHvgG7RgKvrzStLezNbTu4E
 x62w==
X-Gm-Message-State: AOJu0YxbxnYMG+8GRBf9CxE/9mqBXLvGq95y3GKcZCP5oszb3nJUbmKA
 Vy8RRV/HgtFXbvdRI9vjZjTXnM8gdWU31FHC9H0F0CY0bP6QPVy4rC4pVxUfz6paq9BOMQjH+gi
 LwwGrv98=
X-Gm-Gg: ASbGncsKRrBEpsILaACFEcsRkb2Z4YBZpzCwm8v44eRQaoF2CtLj/YlA5i8m1OjP643
 eqHkRDbar1QFHVU6WboQmpgG5b3BPt2nLkf/iTTFmPa+MPhzqCJkqxVB9QKKWpawwjGx+Zq2yyF
 zL3S1zj4RtOxuu6EQfra6hls0FO0gBlCNL0uMNspyKycZlOMOyWxMcJr0Ia60vLpbp5Asrofz8t
 Y7Es8GgVdf1Xd8q9ztiCgTXPb9OlFCOEWKbFP/IYR1TdLZFMQpwkLjR+cVhy6eiguahm/6PMPwB
 aZ448hjZo2yFNnOjLlErVpV2It6RruEsDmMzY/H/Zaxtnu+1v3/dbc7iPwEaFXCbOInDM4Eu3mI
 DUYoHBk03PdlEI2cuAL1lMVM=
X-Google-Smtp-Source: AGHT+IFUWccuVT5Ck2ndrdaBpfUGaMvy2ERQCajDW0ae+2q18J3LFiy3JLR2e+J1y94sFds/jZjQew==
X-Received: by 2002:a05:6808:6552:20b0:40b:9361:cd69 with SMTP id
 5614622812f47-40b9361ce09mr269985b6e.15.1751418252628; 
 Tue, 01 Jul 2025 18:04:12 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32438b5bsm2330602b6e.44.2025.07.01.18.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH] firmware: xilinx: Tighten dependencies for ZYNQMP_FIRMWARE
Date: Tue,  1 Jul 2025 19:04:10 -0600
Message-ID: <20250702010410.18828-1-trini@konsulko.com>
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

The ZYNQMP_FIRMWARE code  cannot build without platform specific headers
being available. Express that requirement in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
---
 drivers/firmware/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 8789b1ea1415..a094e6c3afef 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -29,6 +29,7 @@ config TI_SCI_PROTOCOL
 
 config ZYNQMP_FIRMWARE
 	bool "ZynqMP Firmware interface"
+	depends on ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
 	select FIRMWARE
 	help
 	  Firmware interface driver is used by different
-- 
2.43.0

