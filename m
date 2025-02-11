Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82629C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 09:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98DF9800CF;
	Tue, 11 Feb 2025 10:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RM6jV97B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAB48033D; Tue, 11 Feb 2025 10:12:56 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89FA280079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 10:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5450408455dso3485297e87.0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 01:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739265174; x=1739869974; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+APdhyFyvohnN2imFhR5NCJMXLtW1K7Rrfu9fwyJdck=;
 b=RM6jV97BOuUpf+ccU/kTyNfEBy27Rp1BbdMMq4y65IwtrgkblQpOOxFMZOTHs2PL0T
 +KXaM67qEwqmGlLT+o3ruGKgPzh9j9fI/LGXQvBxrXczCT2pXH13BJYEwCkxduwUeR73
 /cjREc0vVSz1hgueVqJ/RwYDkFW8JpCtYkdrvKzBJykkqMgwDxaNv9ZJFwSAnYFE/OuE
 p53oPClHMOrfW/13L0gUHFFoddGxqSPxTwcU8HN5K0MFeQ7tCXO0bVC0CzQmo1kfgvNp
 z+fss4HruuVFDkSIBsWx25/Gc8GcTavpL2BbNbfl/ypdf/b2njmGl1QXJ/VUH53+8QGX
 1ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739265174; x=1739869974;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+APdhyFyvohnN2imFhR5NCJMXLtW1K7Rrfu9fwyJdck=;
 b=WWaVdSzvtKBhF95bpIssJtrhbrJxOLwldYOyuGct3xbdsIyvq/DzIGWVxLclAhtAH/
 MXfiDZ0Pf6Qad9kuenn21DiHYT6eMWYn4kHOHnNjG+CXpDOvi6cjCrgPnzutXYCtWh00
 tFL8cKPq8sCEIl1KPtEO5WDoty5hfhtU9haaAA2fBjuHO/mCGn9dzhpZcy2qSgQVnJcA
 i+w7VK4ANzc2SNW459E2ogebDSo6SyPCksXnq3L1Zp7Az6GvH6Xk+0N6Gpi//BOvcd8Z
 7TEnId6koEF0HxQ7dwiTbPGIqSUpgsqJvouHQ0qn/HtZS6pOVvJpUOx3P0zZeDV3oqPa
 DY1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdDSzOAWf3faJKgGMq1AXwDr8+3CJ2KsEC4DVgNbT9cv+xKiTTnKXumSe1lOMYgndp/HlhXV0=@lists.denx.de
X-Gm-Message-State: AOJu0YzLGU+xgKT0EZ2ex3mMAdj8yEYrakLJFzPcbzEUCffne3BJLn7y
 DevydMqw/j2pseUO94lNkuCRtUVv7f/341hj/NBvChkW79ATW5K62ZovF5xkC9Q=
X-Gm-Gg: ASbGncuM2YqCNHLVjVOZunTBQCdkc2o95J5NSRi++jDF+g5RFSUVVQjKdihwdW5pKFk
 7ygppnHUTJiRT2AYhoqjzA385vCtDF9FHRnpIZUPnQ0gi0HUlFD+ZbJnbNUejkx9kMemBvHe5NN
 X+7GD1Pk/Q9qiXpQmM7MxccEvI44AyaUSEnNkdGPlrNJWJkeZs9sobHtMBJUy0tVdh2HXhf5aOL
 02zU9Uu7UueYa8cY06rk5srrI0sOS1b2p67ybviFZjwTBaR0pvdudUNXmIIDhglaIQ+AAWtNV2X
 9ZAYC4Pxa16zLGISr1PH0OLUT5ERAs2vXL+WUXUd9pWntgRypUGOZNGONdw=
X-Google-Smtp-Source: AGHT+IHKbKrYSYYXTYkqjfhXWT10DcnyGhf5fOXXFV2zijdUM/IBGIHBbxS4wU8l/vTEmSAYFp8wIw==
X-Received: by 2002:a05:6512:45c:b0:545:4cb:b25d with SMTP id
 2adb3069b0e04-54504cbbb46mr2944260e87.13.1739265173615; 
 Tue, 11 Feb 2025 01:12:53 -0800 (PST)
Received: from [192.168.1.2] (c-92-34-202-163.bbcust.telenor.se.
 [92.34.202.163]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-308f645fdb3sm3018691fa.30.2025.02.11.01.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 01:12:53 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Feb 2025 10:12:51 +0100
Subject: [PATCH] configs: stm32f769-disco: Fix console cmdline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-stm32f769-uart-fix-v1-1-8d0eaf0b193a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJIUq2cC/x2MywqAIBAAfyX23IIa2eNXooPoWnvIQiuC8N+Tj
 jMw80KiyJRgrF6IdHPiPRSQdQV2NWEhZFcYlFCtUFJiOrdG+U4PeJl4oucHtdatcM4PthdQwiN
 S0f90mnP+AMPqg2dkAAAA
X-Change-ID: 20250211-stm32f769-uart-fix-66650ddf9c80
To: Vikas Manocha <vikas.manocha@st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Tom Rini <trini@konsulko.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2
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

The Linux cmdline encoded in the defconfig is wrong, the
STM32 USART driver registers as ttySTM0 not ttyS0.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 configs/stm32f769-disco_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/stm32f769-disco_defconfig b/configs/stm32f769-disco_defconfig
index 5be221afd2facb0af4a3a3f8df0f24fb34eaf10d..9edda0e36b2e92c3dbe3298a3da04bd731dac452 100644
--- a/configs/stm32f769-disco_defconfig
+++ b/configs/stm32f769-disco_defconfig
@@ -18,7 +18,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot.\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
+CONFIG_BOOTARGS="console=ttySTM0,115200n8 earlyprintk consoleblank=0 ignore_loglevel"
 CONFIG_SYS_PBSIZE=1050
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_CYCLIC_MAX_CPU_TIME_US=8000

---
base-commit: cb3612dfe3fd9a702dc3657aae15b07974f9aa0b
change-id: 20250211-stm32f769-uart-fix-66650ddf9c80

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

