Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAC4F9EDE8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C29B8439C;
	Wed, 22 Apr 2026 16:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dIQD/tM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E42BD84380; Wed, 22 Apr 2026 16:32:09 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5365283F14
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-50fb1932b62so17595431cf.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868324; x=1777473124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KnABhFTiQ+hgc9Zoyavg/bcMhFeOEbPPYGyIOK6c+0=;
 b=dIQD/tM1/OEi/Z1/BvQLZwqRC+bljFD/oB0/+byQLMpXzfN0fQ6/iN+PTumgd/LRmz
 nbeRUH4d50uzwEyzLA24AXhI1i0wLjZ/VXSA6DKvB7xdH5VQrrTJKKVxPZLxmxOZLtFM
 YLn5eI9CuMGH2O4KR+7CxeJEK6Eishbq4IVd8+3bDsPKp4Ngne/QkbERdTRTdxNaZ2NX
 i7KXPK7HdSwdisYw1NOdGmPOyD/FYXjwszWvSa9cqdBd9UlB9jmVchxVYItL+rdJI9xE
 QoT8WTeFc4JBNrb+IUt90qLWMGXzwYrl5yc3OaeHFfnzcC/Qd6zNPjhjHjGYRZRXvLlp
 xdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868324; x=1777473124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4KnABhFTiQ+hgc9Zoyavg/bcMhFeOEbPPYGyIOK6c+0=;
 b=cGsllC2h0sK18DbOMUulfYvPMTeNYzyyLUoduvhSkfgpdfFG2TX1A32bYck5VCqnnM
 HqpoXszgjWlX5Yy4xKyP4adztnjYtyo9jYPd8++QXci3p/UDWB9XZv75A4vdXtB/DffP
 72TfM7Uou/4ETokP1L8orU55IWGsqi11+3C7ifmz/GW/R1VDQ2ZkwQk5mHif1YN+fpop
 FeL+Lw5VZ1YSlBjUpqr30mNel8uVRi84Pv0V4vrU3793ZdZ5rNsYA2nmspkjGKPFE9Be
 wQvLZfIXsleG8AtCahe16nFTVJdkgSuRfUkxiRFWR7fj3i9Wt9zVRrmrBgekse0imAOw
 wfOA==
X-Gm-Message-State: AOJu0YwpyS8NR8wFKK/MaQeZgVp1gvMTTw2RpzOheHH8egzRApWy2ATs
 ZrsDTtNzYT4Uvn8NW+UIfu2Zzmd6TN0ZVnpqkTo34PD5u9ZrFql+qQZDzW6o5+ZyU5M=
X-Gm-Gg: AeBDievvsm4oe119oMZ3DSscK395j/Y5FzzriDyt+7+/umvtw3AGCPT08FhssnwaBAy
 B2TU/aStPsTJDvph0z6ZX/bUIkOwwTEfE7CMTZcv1CkpWXkI1VCvw7Hzb7dy5Jm7DNrov1nmyb3
 MO48k+nLOHSTVI6nQYv3ZwXHPluq8qNnwOWpsfdDY3xEsYRCsY2S2EgKh0QR92D9kZaWAWUVBfW
 fArBaD/e5yrEb/Ri5BEwfNUMOMbivwmjBtnQ1uxY7hFRzGmtlQgyJGfRRq/w/xfq7uiS6olQ2zT
 HHH02Yg9tKJ9jWFDD0NuI7IPZrIYy4nsWigkWJrkL//HM4XN6Qhvv9Uswx6Qz0dU087sDrzI8PA
 mdOwTgRoPwNx2v/sLpXQIWRVSCh23lHJH1bzBtgwomdM1jU0vZ9hjkrJThYOP557oblypG2zcGK
 M1/kGjJWzAedwv/nZSc4RAFK4uHQmjSruAP/2CEXSB3fJB+JhDKLT3SwP58IcoVa/gS42bXcyOu
 5vHiB5Tmeto4pbTfe5iTzbAGEih+r/a
X-Received: by 2002:ac8:7f55:0:b0:50e:defb:9dc2 with SMTP id
 d75a77b69052e-50edefba0b3mr152357111cf.27.1776868323893; 
 Wed, 22 Apr 2026 07:32:03 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:32:03 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 13/16] spacemit: k1: append RISCV_MMODE_TIMERBASE
Date: Wed, 22 Apr 2026 10:31:09 -0400
Message-Id: <20260422143112.1329478-14-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Append the definition of RISCV_MMODE_TIMER_BASE & RISCV_MMODE_TIMEROFF.
Since they're required by riscv aclint timer.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 include/configs/k1.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/configs/k1.h b/include/configs/k1.h
index 8e148803dea..33cbbeb6fd6 100644
--- a/include/configs/k1.h
+++ b/include/configs/k1.h
@@ -8,12 +8,14 @@
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
-#define CFG_SYS_SDRAM_BASE	    0x0
+#define CFG_SYS_SDRAM_BASE		0x0
 
-#define CFG_SYS_NS16550_CLK	    14700000
-#define CFG_SYS_NS16550_IER	    0x40 /* UART Unit Enable */
+#define CFG_SYS_NS16550_CLK		14700000
+#define CFG_SYS_NS16550_IER		0x40 /* UART Unit Enable */
 
-#define RISCV_MMODE_TIMER_FREQ	    24000000
-#define RISCV_SMODE_TIMER_FREQ	    24000000
+#define RISCV_MMODE_TIMERBASE		0xe4000000
+#define RISCV_MMODE_TIMEROFF		0xbff8
+#define RISCV_MMODE_TIMER_FREQ		24000000
+#define RISCV_SMODE_TIMER_FREQ		24000000
 
 #endif /* __CONFIG_H */
-- 
2.25.1

