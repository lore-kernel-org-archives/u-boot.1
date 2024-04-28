Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD44C4345F
	for <u-boot@archiver.kernel.org>; Sun, 28 Apr 2024 14:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB3D8838B;
	Sun, 28 Apr 2024 16:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KL7d3k7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A0A88326; Sun, 28 Apr 2024 16:24:26 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954A0880F4
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 16:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heesub@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6ea1f98f3b9so1542753a34.1
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714314263; x=1714919063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oX1TUELmCSjO8mAjqI7Vf/DZPkIzECsSNREnYIFkhME=;
 b=KL7d3k7vkr3bIENazDAy3iEcP7mXLJNiK41zjTRrvHXq8+oUmCh9hro6NWFdxQO0ld
 s+1sUIyioY7PMr626o0heG8px3P3gcjMo0OGeadh5WaUkCP3Q72n/+GhkanJNRmTPzuf
 6jRd2A8KAGlQ9uVErNc8xXlkuLPPSkzRCjhT3rjtKP7NMwUyNzC9MylZdWAltvfBMxOH
 47ZviL6fByefWGso7bUrYBAbdg2yAXpPtojihW2uKSyt3hhNNyAyRWTygeDg75BvZURf
 edJBaMYKPZtWUl7Fns21QuA7XmvPGLhH6HPoP+XOOUkpjDlz5NMlQF68YdUD7bCFUN/8
 3+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714314263; x=1714919063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oX1TUELmCSjO8mAjqI7Vf/DZPkIzECsSNREnYIFkhME=;
 b=v3z58H3DpsDXzSv4ICdKmYKRnRDjVsqVdnr0QaaKcnCUxY6qVqagZEqG0k/RLXHPda
 aV1aGMCpiVWCsFtFBBq0S9OIquc9kJ0GBVxtX6pcUgxHVofCIhVXrtmhAIknqmwK7tNg
 KUgeIhhcJgX7fmHjpFsyLP47J/ryQQvIwVVLR1L5on4ad1qo5runGz8rr329Zx6t2Gw3
 u2qBJ27oB9DqiSDhkX2P19u83w5tKTw3SE6Kq/dDrmwwsbvWs6PuZ0KTOjW+w751mXPM
 HgCQHGc9s68EEpZ0ODDqMnuCFRcohFdFNzB2u1AgfpU2V9DO/WyG54liZe3YlLuBVdY8
 JowQ==
X-Gm-Message-State: AOJu0Yz3PQ+9yA2Sk4RvWOtTbM+c8PIDQ7PoBRoqKPmc1SZoz6CZWu87
 9N0/egqHh2ucZBWqHeFe1gGnRPQqQFRrlgyzwfoweZHtWZLEGrVdNC1WEg==
X-Google-Smtp-Source: AGHT+IFHRzgIPK+uAGw5C4Q/e4lfLuV42zu0UMRla7U8K0XHKs5agkY8GWvzlhJBJIyF5ea8hGTFcQ==
X-Received: by 2002:a05:6870:cd8b:b0:22e:8002:63f1 with SMTP id
 xb11-20020a056870cd8b00b0022e800263f1mr9392152oab.8.1714314262871; 
 Sun, 28 Apr 2024 07:24:22 -0700 (PDT)
Received: from heesub-ubuntu.localdomain ([58.229.217.38])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a635343000000b005f077dce0f6sm17568744pgl.31.2024.04.28.07.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Apr 2024 07:24:22 -0700 (PDT)
From: Heesub Shin <heesub@gmail.com>
To: u-boot@lists.denx.de
Cc: Heesub Shin <heesub@gmail.com>
Subject: [PATCH 3/5] dts: stm32mp157c-odyssey: fix incorrect PHY address
Date: Sun, 28 Apr 2024 23:24:04 +0900
Message-Id: <20240428142406.28445-3-heesub@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428142406.28445-1-heesub@gmail.com>
References: <20240428142406.28445-1-heesub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Apr 2024 16:40:40 +0200
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

In Odyssey board, KSZ9031 is at the PHY address 0x7, not 0x0. This
commit fixes it.

Signed-off-by: Heesub Shin <heesub@gmail.com>
---
 arch/arm/dts/stm32mp157c-odyssey.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/stm32mp157c-odyssey.dts b/arch/arm/dts/stm32mp157c-odyssey.dts
index 53ba018197..b6210cf8b2 100644
--- a/arch/arm/dts/stm32mp157c-odyssey.dts
+++ b/arch/arm/dts/stm32mp157c-odyssey.dts
@@ -81,8 +81,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
-		phy0: ethernet-phy@0 {
-			reg = <0>;
+		phy0: ethernet-phy@7 {
+			reg = <7>;
 		};
 	};
 };
-- 
2.34.1

