Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D10FC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 16:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F9B88054;
	Mon, 13 May 2024 18:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LA9RVKzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F8787D57; Mon, 13 May 2024 18:59:26 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7371E87D57
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 18:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51f4d2676d1so5038313e87.3
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715619564; x=1716224364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oiqcn+SJy04OqHGsKcMnEzSFKDAp8cCnfP/sfQoyAfw=;
 b=LA9RVKzuoJMinQWneVOEXDVWH098h1YjpaqISQCb91BBY/yrjxBRg17NLa+IwO+I7o
 wZ+xjwC6y9tuQB8rZpLpCYtLUyyyvecioFO8hBjcev5PNcla4x1E8ArSvij9OrZWjBaa
 sNzkjGu0q+RzwtlsTnbQUqdQrGPNN1T02JvFXNVUDg2n+ftT0m9V5UkamkCyXONaqvwh
 4pCYzSrOZX7PiT+pTp1lUK32ZDr0lOVWke2TUFmw00Y4TupxyjbCoBhJnNMBaLdZI+yL
 rndx+pahm2gCybAN5t+opuqkxLvm0l+v3DAABAMODQ4Xo1bWWaYxglENrKWJBHWBmgZw
 c/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715619564; x=1716224364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oiqcn+SJy04OqHGsKcMnEzSFKDAp8cCnfP/sfQoyAfw=;
 b=Rvw8xmRtsVA5FCsWPMrtLkbv8iApbjdk023o45N/gLOFQKomG0Qxva5W1CVtwzTjKR
 zp3znqqT104/qdhiHNEliEE1QX2puMdgVlD3iDhvLHZOhBiPdtZhufzIPOG3z2Ptus/t
 Nf4azdTK0OENVFdS8gH4F9sD6si//Up/wr2nFAvRwY22fHYr3mz1QJEcCfpFF+Mm9CWS
 OfTH7/WHKruoLITj4mwP3CdoXGTdYn5Dr18WkE69gUS56MP57JCd5GnDhKOMEmMieQ+g
 jaQqds1HzDqQjuxskuQUQMdIQfoZDajHQg91ruaDGMGCMz6knunnDQ+UBCgf8S/lT6yd
 I79w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Pr0y9s0J064xD5aZG3dUM61kIR0HZL/Q8KTzqj3nA7V6k6AiOqRJvHNi+GCIzfVAjUhPWioUKXC49+ukVpJgPWZI+A==
X-Gm-Message-State: AOJu0YwKW86WgfVebONIDde+uMwbD+B2owrhbOXQWPBikWAoJFymakJa
 NsjlVJ9BOH7d58o6uPL9omKXqgb3gQRDz73rtsvHpYTENgUmNvEx
X-Google-Smtp-Source: AGHT+IHcnAW0ycIL/OWBOpCydBfh0tr5ZpLcbhoKMs1KGfr35y0jUCUghFkYbIj1fICGYYsFTUz+yg==
X-Received: by 2002:a05:6512:3e1e:b0:523:2ed9:edf9 with SMTP id
 2adb3069b0e04-5232ed9ef10mr2592292e87.63.1715619563388; 
 Mon, 13 May 2024 09:59:23 -0700 (PDT)
Received: from localhost.localdomain (109-252-12-58.nat.spd-mgts.ru.
 [109.252.12.58]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f35ba56fsm1811192e87.91.2024.05.13.09.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 09:59:23 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 eugen.hristev@collabora.com
Cc: maximmosk4@gmail.com,
	Maxim.Moskalets@kaspersky.com
Subject: [PATCH] arch: fix arch-rockchip/clock.h dependency
Date: Mon, 13 May 2024 19:59:16 +0300
Message-Id: <20240513165916.24259-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

This header uses u32 and should include header with this typedef.

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index f01c5aeb71..ade53e6fd9 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_ARCH_CLOCK_H
 #define _ASM_ARCH_CLOCK_H
 
+#include <common.h>
+
 struct udevice;
 
 /* define pll mode */
-- 
2.39.2

