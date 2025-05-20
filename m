Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6CAC54799
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 11:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7902682B31;
	Tue, 20 May 2025 13:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="3Ea070/e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F04782B54; Tue, 20 May 2025 13:38:05 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F5982B72
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 13:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad5273c1fd7so893435566b.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747741082; x=1748345882;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tpMiRe07YmhwyjMYAecJT7Fu1xlUUbtaW4x2y0zRLpg=;
 b=3Ea070/e8/rc6zjoO9fF2Q5SsAGUnkVZ58vVUEYSq0lYSFHBOz9akKvwhY5Xd62cXn
 cg2hnfiGxmjOeFQ4PyXvdJvRfjgZLb1Imnu47s1k5jJIg+TlmPj6vcsuaz5XxVKoeta6
 mKxiQos8LKzpUo77I1E8pgCXCR+uhKYLVG45onuRcgONLaXc4XRlWzytOVkDQd+ZHfb+
 wXuoTVm5w9Z9SLG6E/thNFCsqUcz4FCpkcPFZzjny7nmAajjA3B+UhSKdPLl1kdcgNmF
 7SFkeQfsGyit2PCD3UrpxXZm1YthKhNQLS4snmyLtHDyoCBV1deHel0rEbQQTmu3NhlH
 G6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747741082; x=1748345882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpMiRe07YmhwyjMYAecJT7Fu1xlUUbtaW4x2y0zRLpg=;
 b=JWBqMi3cVWdZ9YHyuQCe6h3l5dw95tW9H7Kat9WoPedjMs/9SSwmpos02Wj95gN8hd
 5kgFi2v59Iyl8Pugxq8zyrgMBrGY2s5yJmBZkcj8PbeBRtgiJSFW719mGG8G1Jy0OoM9
 cWReZFgCLhxm0YaZ+NJ71OGJb/+/tajDRvIZ3HVxhtMTH8td1UtiygbQL0hiNOPABoIk
 g7iCc20wFjFRZtv0lUF5Pvin/L5SAweBNRnYuttobf0YgfaSl//IyYYvaOoesoWBhxph
 aX4P6y3gAA5twX47Nc/HYBxLD3dPQGMjlunZIY7qU0p5f8JQ7YcddvigPFumhqnJxAL/
 k2vQ==
X-Gm-Message-State: AOJu0YwE7RJ9E2/sb69z15QIQUxcXZBdxvBUY0VlbG9K/h1/Qoj3iOQF
 FPBcGGbPPyQSalzyfgIYjS814svvZS/hzIVIaBdpBtCMvFExWy+9pmvDu+u6IGIDK20=
X-Gm-Gg: ASbGnctJ1Mt2tywb+PLzpKeLKVT6IjmN7W04zFa5ppD9rB37WXfdbZEU2OMpMe+nqaH
 8P3ZU2o+IUrgUAdi7rfWfWjcBiN4q1ECHqG15geSSu4ciefOzzkqbBBgFXaugYiW5DpdmTPf+Ar
 ozdxIHdDJEkFC4xygqABTEt0kgYbe4Uoi1zGEwRDp3xKFvw54Jbm0LGmDfFeNSj0iyZmR8uVVlY
 SVnldDWEKOG/mAyCloaUhHOaje/Vq9H+vUg2g/+pQruNAeveT7vfqo6kd7PGG7bIVy7t4Lmtvxq
 N3lEsCYjzmUpSPVZVSDhnCLJvuz/Y+aMDTE/neEAks4gul7iqGO/rY/E4kXOLNbQ
X-Google-Smtp-Source: AGHT+IFilItlb91i5h2eLihnwNj5B/PXZsMR/qPUu1x4Y/+xcbWY/yvtBiI539bFbqn+fnZQbyKW1Q==
X-Received: by 2002:a17:907:db02:b0:ad5:2d05:ba12 with SMTP id
 a640c23a62f3a-ad536f9d78amr1334304666b.46.1747741082482; 
 Tue, 20 May 2025 04:38:02 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4383bdsm715331166b.122.2025.05.20.04.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:38:02 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 20 May 2025 13:36:41 +0200
Subject: [PATCH v5 3/6] ram: rockchip: Fix dependency of RAM_ROCKCHIP_DEBUG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-silent_console-v5-3-ef9583d93285@thaumatec.com>
References: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
In-Reply-To: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

The RAM_ROCKCHIP_DEBUG can be used only if DEBUG_UART is
available.
The next commit introduces changes in definition of debug
uart functions, so that DEBUG_UART is required to be defined
in order to initialize uart and use print functions.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/ram/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index 67c63ecba047..d707d09c1c8b 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -15,6 +15,7 @@ if RAM_ROCKCHIP
 
 config RAM_ROCKCHIP_DEBUG
 	bool "Rockchip ram drivers debugging"
+	depends on DEBUG_UART
 	default y
 	help
 	  This enables debugging ram driver API's for the platforms

-- 
2.43.0

