Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C8AC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08CA7837B0;
	Mon, 26 May 2025 12:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Re4vyN8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FFD5837B0; Mon, 26 May 2025 12:16:27 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3E9836AB
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3da73e9cf17so20285585ab.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254583; x=1748859383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1tnMu6NUALARGuItDiwQB2LJcM4//x1W5tPh9wPgESI=;
 b=Re4vyN8gx1MHUgrq+tlVassrHzt/AxqbSFryb7YIetFCT2qzMUrUNn6io/qev+Nm/p
 gfgVImB6yHin7ou68j9s558Q+Pa4fAu9scrqYOy9wTx3Gr02AqbpTMx/GQc1FTIvrt/t
 zpL2u715btNgPggVUx8Az9rO9kxcjJNVmJC3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254583; x=1748859383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1tnMu6NUALARGuItDiwQB2LJcM4//x1W5tPh9wPgESI=;
 b=fFMvNh+PqMIsTYBove9Ly1yqJTpYCOc7mOxcNjVer+zmHJjjzYIBVek6b11/yh0X2Z
 HGslho93Fkf5+GgU9kAQn4jf3dpNZO8KjRob/1MQDI9FXqYBp+TF4EqWDpYAPCSNAZZk
 UX+dX/wiJR499qhNseExYtMZXPF2rRD06hBakCafwnRqub3bzezNxTWAjQ/DIuA8zuDT
 HY3kzuxGKWUXU2VU/VkTz72DMDp5lTy6vOMaE4H6lWosoUG9lexOrOjFLLL7RQkIikQf
 GtESHzlheTLexnzbfV/ESc5oQlI0yT22krvsnKgi1emzvDKjXrYrNrZb0bTHzp9fX00g
 EthA==
X-Gm-Message-State: AOJu0YyAJHJ0kjrfzmiLEwdg7fCjKM/sLyrkAC7jsyLV+8e+XzvijoUO
 QvnQT0+9anDfLQAOEdfzXufF7CDjsA+KclwtnXT4NxTKRgpqhTS1VEeqW8/GznE2dWXSerAAxiD
 T+uxlkoAR
X-Gm-Gg: ASbGncvcQlC2qCIy2LImyUkuDrNTQU3w2R8Llk/gKGinx/36L8HDBJzhHbWeMPIpRfP
 htt9/dRK6yS5Hp4P0GdgrCO/8prHRxSBLnfvDni6gQBdIYIeY2uh0QajJgwXu+e0P3barwbT/Ap
 cXbR1TGnT2wybUS0bjhoIL5vZA4IcvzUn4ATazxG7DcfNKkqeNKBL/kHN5/SCuiVGfjb+8jTI2N
 rCgb9jbKjUd3Y/ZzP1a8wKD2d/PdU2+RipPOyW4HZHG9oSVz6T39j+e/BzHBY4bTntrSW3LjHxj
 mWDv0VrQqAA1Ko4bW+xnS3Sg0X9e9oM4tkWwWmA8Py1MbixPhNsPGC0GWmSVWU2UqbZblFhGa5u
 WcQoTkaGGGMtf
X-Google-Smtp-Source: AGHT+IHATKWuhv1qdoOCTNR78nZQyuS0WYn5+GBgbhhxWFMKwtpAp0VK4OJFLeqcY/IQfhXChoJa0A==
X-Received: by 2002:a05:6e02:2701:b0:3d9:6485:39f0 with SMTP id
 e9e14a558f8ab-3dc9b6a9e4emr69417185ab.9.1748254583014; 
 Mon, 26 May 2025 03:16:23 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 12/25] rockchip: Update rk3399 bootph-tags for VPL
Date: Mon, 26 May 2025 04:14:58 -0600
Message-ID: <20250526101541.3254628-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

When VPL is in use, memory init happens in SPL, so there is no need to
include the DMC device before that. Adjust the tags to save space.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Unindent bootph tags

Changes in v2:
- Only enable MMC when VPM is in use.

 arch/arm/dts/rk3399-u-boot.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 587eef9504e..8b530401541 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -46,7 +46,12 @@
 	       0x0 0xffa88800 0x0 0x1800
 	       0x0 0xffa8a000 0x0 0x2000
 	       0x0 0xffa8c000 0x0 0x1000>;
+#ifdef CONFIG_VPL
+	bootph-pre-ram;
+	bootph-some-ram;
+#else
 	bootph-all;
+#endif
 	status = "okay";
 };
 
@@ -93,6 +98,10 @@
 };
 
 &sdmmc {
+#ifdef CONFIG_VPL
+	bootph-pre-sram;
+	bootph-verify;
+#endif
 	bootph-pre-ram;
 	bootph-some-ram;
 
-- 
2.43.0

