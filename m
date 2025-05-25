Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05530C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB16782B53;
	Sun, 25 May 2025 12:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WFjoCcHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95F4582C13; Sun, 25 May 2025 12:48:18 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D8482CB6
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so10031185e9.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170095; x=1748774895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QxgmAnEciqbZ5DIcZAu2f4KPm0FGAxJxLhxr3vJMM0=;
 b=WFjoCcHQbpYorijbcbOuhfyms4FcaEfrh7Utni91Mcu4IJZr5nkgEvwfKBW0Iz5G0k
 uQSH360afqyj4jidKnw5CqE36dDIUVa+6Juf6yv4MRv5zsJFNEngjmFYUM2Tg1pPqxAm
 tatuoNhhp2Wq2U5YNPpJSHF+9duny1dznoWAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170095; x=1748774895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4QxgmAnEciqbZ5DIcZAu2f4KPm0FGAxJxLhxr3vJMM0=;
 b=wSjD4VaFdNodtormOABv5rZWnkuRbgWAvSGzIuVa1nEaR5epPLsv1PXocWnV2nQLxF
 hSTITs/E5h3SLvziFRZY4hiV3W2oqN9PjGusjcxed4M1Uw+F7PuGGLA4aaknomUzVqPQ
 5Ci9jmwFJlmQjio7REa0uuW3vboAQhEVB3cYP/KVNe5KHf1Wx6Yrjx/2+2Xa4wfCXC1/
 3Qrug2oSzT4bgvYAb2Eq8ko0xzvdo6cXqYVtqHu8ixcUe/pfmAxTRhk6vXE3UT1kjJ29
 GoSRsiVtqyTLHSiZ5HwOTdEV5WuKCdqsEtzic++pYv5bzogUvS0WdfbxdDE7jU9r2CFd
 LzCA==
X-Gm-Message-State: AOJu0YyOBaTN2BV37qDydAzxHKnneayjZQGCBz7pKuPwJ6S2Oc0RPubR
 iD4lGO6+r3vxalV1tXWF+axfPAPatlhoQdINvBkcStJMNUGtIQKf4VGXC0Hlys0XBTDPe01YXqH
 wqleMXcg9
X-Gm-Gg: ASbGncsI5T3VAgrf+2JTg9KWoOxbAfO3/TqaRGMRDUz3qS48Ttj5FTmUbXXN0kAftJE
 pSAR+RO8VO98JgnIHwN8JXlo+klPvdEA35SQW1mrBR1h7EMjANxn7A7A93bsPgMWo5zj6ueGTIv
 bXuO7GIiesH5PcjtlWbd4PP0xTlMNq8S0jl4Mgba5rr2pMeqV0Sg4G+uIaAUJpWxTy72E6+q/tk
 KCEVd6vXoCkuytRnWYoMoxxCLq4zKG8BmMaLN1DjLX4Y8lVQj7QRqvSufkRmkFjBKq3KGmAVy9L
 KIn7yvjzukGl/sUOdKgGaoLAqNQChFIE0ZnKEXtgUn1LxZdxq9ufQqKn8CYYVOWB3+EcD+0=
X-Google-Smtp-Source: AGHT+IGSkX3G1ibI4nmh7qSpVDNMepLgsorY95q4lYt53+PW7Y5AkipN4ObpK+kPajd6YQZqN3ZuxQ==
X-Received: by 2002:a05:600c:6214:b0:43c:e467:d6ce with SMTP id
 5b1f17b1804b1-44cc05358b3mr46855225e9.4.1748170095372; 
 Sun, 25 May 2025 03:48:15 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 05/25] rockchip: dts: Add an fdtmap
Date: Sun, 25 May 2025 11:47:41 +0100
Message-Id: <20250525104801.1440260-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

Add an fdtmap so it is possible to look at the image with 'binman ls'.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---

(no changes since v3)

Changes in v3:
- Add blank lines before the node

 arch/arm/dts/rockchip-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index cc2feed6464..8a37a9d8e7f 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -192,6 +192,10 @@
 #endif
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
+#endif
+
+		fdtmap {
+		};
 	};
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
@@ -224,6 +228,9 @@
 			/* Sync with u-boot,spl-payload-offset if present */
 			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
 		};
+
+		fdtmap {
+		};
 	};
 #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
 };
-- 
2.34.1

