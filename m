Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7530CC0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 460668128B;
	Mon, 27 Jan 2025 14:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ir8nU2lJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59580812BC; Mon, 27 Jan 2025 14:41:18 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 644A381221
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 14:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso51158765e9.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737985276; x=1738590076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lDyXRVV5U6WxyptAoHTZlxUxKMH5CKzpIVq7nY8CZE8=;
 b=Ir8nU2lJvZkqMaAQOvuQF4hHflEW8H0SKS8p5JE08dgXsmzDqxUCnsECXidNJi4tXO
 UnJMVfXxun2NaXs+mbllgVivhQfdwn27DnP2ddxzwwKHgbFs8m9YGn1+rnWfuVHwcefl
 RcKVbG+FnsWG9UxpXji1+0AGqHZZZcpS8A2ZbK2xRJH9Fpl1rJCN23yy7zQ4EJto3c0L
 6rL2jMBhvUG7KDTMxroz+HItILUAgyap4k5ECgTePowG2HgOw0J5CsQa6BYnJ6edNGH9
 v+ptCWO2zhUSiU2uMTwnTclFalLDgP/JzNfqRlXS3/dzisGwru0khi1mRlxwPCotS04Q
 QFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737985276; x=1738590076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDyXRVV5U6WxyptAoHTZlxUxKMH5CKzpIVq7nY8CZE8=;
 b=gWZ9ivgj3EDwNUqW8p65Mjgm+ObDliHDs1tS2C2z+FxUM3wu4SsA7wb5yuQIrBVJWg
 YaNiwa6sfXi2GJUXMRaRxGE9oXMqDHatGSyy+dPfJiRLLeZtM5DMU3qW4vmsKyFvrq+n
 EJ/2mDZQzIIWdsGIEBTbRVc+Fa88X7+51GgC8lf8/AVz2pAbeKbftV5/P3Mn5LfNzS0S
 pzv+VA8xre/ebkPlsESvYPy2JalQhrm5Mi3Hv7lTk+v3zLMTEtARTvlQio88iYlXv8hl
 /MhD5Z6JP45jwaBd7ZQBO1hbdNEaOIARlX5o1C37jHLz9CJdy4okNxv6yKeEGOA2R7oG
 qwdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcGDHS5lRaiWDpELo2x0Oe1Mj53qzdObw+1DpdYKtclIdknPgtspNbbfsJRxQ4EPpVj567p4g=@lists.denx.de
X-Gm-Message-State: AOJu0YwkswOtXZnVFdfsBvZ5C5RQzAHTbTinaUI/lQvpNlgHEseliFRO
 aHdtyQjYvkAzqcbJQl5ffhTJ0h/H9abOJSZrZ9jLW3GFRKuS4pqW
X-Gm-Gg: ASbGncs9jkqgj2tDMIo17YVBMxhv4akBnwQ/PyHqku1beq5OqR536JboVm/w32Ewzur
 D1iBZCQP5B2eRKZpFWusQGPcbhP9PAdCSFJ4jYQMlrtCLVXs+k0Ng/tcO7L0so2RhlhDX+VpU1J
 yYkJ9reO/VrV1bOc70pjj47MftGLalt4von8P9/hM88AotZmIGJzRW0mkrSJSVjB4nC8hLf36z0
 4FS4byDGhmE++0EyH3W0VwkRj7LA035+FfmowN0LB1WNeS5Ve+xCvGZdzbSlhDsIhZL1j3+An4U
 l9Oa396Y6hS4upNtFjwBQ3bptIfsdwvNoyhgRVMPnYY3ydsTqg==
X-Google-Smtp-Source: AGHT+IEw5IYYlfM2zJR12Kq/qWGeoQ/uDKDK8b7kQqaUz0KlyLB5pu04N5W5dc1AZTJGAdGEsM4ChA==
X-Received: by 2002:a5d:648b:0:b0:385:f220:f779 with SMTP id
 ffacd0b85a97d-38bf57bfbd7mr33845537f8f.49.1737985275583; 
 Mon, 27 Jan 2025 05:41:15 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm10873900f8f.89.2025.01.27.05.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 05:41:15 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 John Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 4/8] pinctrl: mediatek: mt7988: rename reg-names to upstream
 linux format
Date: Mon, 27 Jan 2025 14:40:41 +0100
Message-ID: <20250127134046.26345-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127134046.26345-1-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
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

Rename reg-names to upstream linux format. Upstream linux drop the
"_base". To make use of upstream DTSI, align to the upstream naming.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7988.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index f2bfde547e6..ee2ad2dbe6e 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -119,8 +119,8 @@
 		      <0 0x11e00000 0 0x1000>,
 		      <0 0x11f00000 0 0x1000>,
 		      <0 0x1000b000 0 0x1000>;
-		reg-names = "gpio_base", "iocfg_tr_base", "iocfg_br_base",
-			    "iocfg_rb_base", "iocfg_lb_base", "iocfg_tl_base",
+		reg-names = "gpio", "iocfg_tr", "iocfg_br",
+			    "iocfg_rb", "iocfg_lb", "iocfg_tl",
 			    "eint";
 		gpio: gpio-controller {
 			gpio-controller;
-- 
2.47.1

