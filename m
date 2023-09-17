Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CEBCD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 19:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 821DD86587;
	Sun, 17 Sep 2023 21:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="A9LhsPCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 415D5863E5; Sun, 17 Sep 2023 21:26:50 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BE586587
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 21:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=abbaraju.manojsai@amarulasolutions.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c3d6d88231so30115045ad.0
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1694978806; x=1695583606;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvyMBJzPKZ0xddSXreBoBpborn/z50Nb5qwAv3hf+zc=;
 b=A9LhsPCjdjIR3LhNKDhN+pSTyR+Gc7aCSKO7j1I+SXxzUua4tB0/1BjeaEL5qfkOwI
 /Gm2WxdCkwmRcA7ojXsQJQNgXQUZTQzVnHhF9J4OCV9FXiORWJ6aJWEcjSUE8yrDtX+/
 k/lMchqE6EVVa+vX8+/s1/xR8oKzcRept72w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694978806; x=1695583606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvyMBJzPKZ0xddSXreBoBpborn/z50Nb5qwAv3hf+zc=;
 b=XsPKJoIhBHD4AtJjgfmchG7MJvzjFCOxjA5p4yoqMf1v8Y8m6O5YEXhUsQMNGDW3Gs
 CSOcQrWSqnQxIwdLau0kUhA4mipWL6xm67XS+iyh1Tpe8WnMD86JI6+VC065bK5FdJru
 oG+0084s3nuc3zDvcq2ipi6m9MW6e1wwLxNSV0cWjDe2lKf3kRuT1jRZxu9LShP7H3Qo
 iNgYXfPGTZmgQpr+7VV6uWlcnxgkqqt9y04NtfgEBHqQPleH9G2i+dVuLfoje6o8W59D
 KMJPdTh+0kNodVlE7FkGIeAdXSSSejDS/Pr56bThkLzhg237HDW/qcoUUuNiQZcBuM9g
 BEZg==
X-Gm-Message-State: AOJu0YyFM6bPBmyl4/ppJin2yA95NTKjPjthdh0k2d2NH1eUHORuPbeZ
 bUi4Cie8KpHEgSIBfOf5v7G4dg==
X-Google-Smtp-Source: AGHT+IE6XiLpvKQJO3JEhCiFquf1OUqpLAZXJvhn4JGvdoOqhWzgQ8pS9YlHkdDh1Er7wV86nmykaA==
X-Received: by 2002:a17:902:e9d5:b0:1c1:f1db:e86d with SMTP id
 21-20020a170902e9d500b001c1f1dbe86dmr5115475plk.7.1694978806464; 
 Sun, 17 Sep 2023 12:26:46 -0700 (PDT)
Received: from localhost.localdomain ([49.204.31.54])
 by smtp.gmail.com with ESMTPSA id
 iw7-20020a170903044700b001b83e624eecsm6976991plb.81.2023.09.17.12.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 12:26:46 -0700 (PDT)
From: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v4 3/4] rockchip: Add support to generate GZIP compressed
 U-boot binary
Date: Mon, 18 Sep 2023 00:56:27 +0530
Message-Id: <20230917192628.363502-4-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230917192628.363502-1-abbaraju.manojsai@amarulasolutions.com>
References: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
 <20230917192628.363502-1-abbaraju.manojsai@amarulasolutions.com>
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

Add support for generating a GZIP-compressed U-boot binary with the
help of binman, if CONFIG_SPL_GZIP is selected.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v4:
 - None

Changes in v3:
 - None

Changes in v2:
 - New patch for v2

 arch/arm/dts/rockchip-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index be2658e8ef..8f248f941f 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -56,10 +56,17 @@
 #else
 					arch = "arm";
 #endif
+#if defined(CONFIG_SPL_GZIP)
+					compression = "gzip";
+#else
 					compression = "none";
+#endif
 					load = <CONFIG_TEXT_BASE>;
 					entry = <CONFIG_TEXT_BASE>;
 					u-boot-nodtb {
+#if defined(CONFIG_SPL_GZIP)
+					compress = "gzip";
+#endif
 					};
 #ifdef CONFIG_SPL_FIT_SIGNATURE
 					hash {
-- 
2.25.1

