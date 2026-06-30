Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84128C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 081D084ADE;
	Tue, 30 Jun 2026 03:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="OoV4YbUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC5784ADF; Tue, 30 Jun 2026 03:20:01 +0200 (CEST)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9223884ADE
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-13b2b92b0bfso430104c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782398; x=1783387198;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=djaTaNbpaEr2mE6eyE2hkO9ngUCbSTgS3PIJz4wnr4g=;
 b=OoV4YbUD0CNnShpej8JZVH1QfEAzqlqjccKq3evJIgRUPEAt/CS1vc6zZrP2+d+smH
 xkzjum0ZWWhscHcdX3HQ8h9uWm9ZiVx8c/CnyCb1sUPwzO9PuMu+IlsTvKlDV6ZApPT5
 Xfplx0Dl490TIDx3Q95d3uN2sSl5A4eLr4yhGzyJaC2aso5cBxR13Lj0eoLLQq4mhlzQ
 y5yMjgajeuS4KQpBbWQUauQm+8Dxn9T0wAm1hitADDOc8t6Zdrs0E0UW+ojIUHmbrmrG
 t+o6IKbBIRa7fHbbduDkqff2qRi6MFRJXOikTJ9Qj9pKP/9nBMxPYnFHuvzIPM3YhH2w
 zb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782398; x=1783387198;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=djaTaNbpaEr2mE6eyE2hkO9ngUCbSTgS3PIJz4wnr4g=;
 b=Cxmq+mOFQ8NkjZ5llVeZBONx++fOl63mIa4NjjOHjvgfNtzuNmQCYPLvra/xM/5FTY
 JYodrWT9VXuMb8S6fhFIrx1fFLJVHnI9SzHmRhAswa0/tmLNPP54MExwGW5h0Rm/kZYv
 Gn+dNoohPUaHBA14bzSD0eF+9hSUsXFyF+FEh8wnjAqrXKqujYPw02v7tqU0g5H6s3hQ
 ZZLH90zvwWJomL9Quf8UaTe1Bet+6mV3NBarF72yHdWllN+CctLV2NqsuvaoyoKAL6dg
 89yq86M21pxCZ/mioTk3FclDBImEd+WcT760nhVvNsQBhEcVzSwEW9/Nr4W89C0TBjX4
 dI2Q==
X-Gm-Message-State: AOJu0YyAYBlD+AHsnQyQkKSyUyyNNT2IgK5qWtKhxNsB1jbiD/kUZqsX
 RoN1QIMn6jKHss9hY43VexZUnj7vB3bQJJjpApknfknijFvGdjJBGVTGBiBiBswDBI0=
X-Gm-Gg: AfdE7cmj2bAiPOvsgeSzt/CkhE87750p/ykqNOoD8xGZ9y7JZJv3Jqg9s0++hJTE4qa
 x6Us5IBZ49sZjzrrNPcUXVUFF+b5CGK7C/LyzIU6O5IJsf/AVRq/ATuPpAeQJQgTAPQGSjQAmOc
 HRO3itiJv57O0Gr85P13edKvsHikvZpInjmnHMG6RjJfYvAu8M805DU9wuW4gg2CEzfuXAWqIoa
 43yVT/P1FIKlONUVEuJBsMkGPzn6qiM7HyHCOexTmMGs90QLx1yc/4yKZ3bk+p8w5LXa5mjRZme
 N2BfLEQykGLAiXh/dyL2cxBwPl/8GIItVxNJm25jo0vXTuAo35k36Z0fWOTEU0xcVFJz+tK6SgC
 GQJhsnOLc/EFKMHCRIEBqOeZwHvazhJv4T0Nlhmcf1nnakN35wItEuJTYON5Uq/eHWUd6+bdvod
 DOUYZYOkyR7x+/nN3oQCSK7QJLrL2d5F3pVpxDLcFpwN5hTO+kEBK+daN4uON+MUFRSMFYESRTF
 +ji+k131Lr0SGUq5tXj9C5BqwIHrWn7mJiSg7L2nSXqALQx1rp+WQ==
X-Received: by 2002:a05:7022:1005:b0:139:f5f0:e96 with SMTP id
 a92af1059eb24-13b2a1ec872mr1004872c88.48.1782782397944; 
 Mon, 29 Jun 2026 18:19:57 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:19:57 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:08 +0800
Subject: [PATCH v5 07/14] board: k1: initialize clock and serial devices in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-7-83f13347b3ba@riscstar.com>
References: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
In-Reply-To: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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

Initialize clock and serial devices in SPL. Otherwise, the device
driver won't be loaded in SPL.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 board/spacemit/k1/spl.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index e15cf5f1abf..78f26616347 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -3,8 +3,45 @@
  * Copyright (c) 2025-2026, RISCstar Ltd.
  */
 
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <log.h>
 #include <spl.h>
 
+static void clk_early_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "clock-controller@d4090000", &dev);
+	if (ret)
+		panic("Fail to detect clock-controller@d4090000\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4050000", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4050000\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4282800", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4282800\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4015000", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4015000\n");
+
+	if (device_active(dev))
+		log_debug("clk: device is active\n");
+	else
+		log_debug("clk: device not active, probing...\n");
+}
+
+void serial_early_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_SERIAL, 0, &dev);
+	if (ret)
+		panic("Serial uclass init failed: %d\n", ret);
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -15,6 +52,8 @@ void board_init_f(ulong dummy)
 
 	riscv_cpu_setup();
 
+	clk_early_init();
+	serial_early_init();
 	preloader_console_init();
 }
 

-- 
2.51.0

