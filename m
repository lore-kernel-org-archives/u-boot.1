Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABDDC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A634E810F1;
	Wed, 26 Feb 2025 12:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zr3hzC25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDCCD80977; Wed, 26 Feb 2025 12:54:12 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D948D80FB6
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so1142420666b.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570850; x=1741175650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dciG/B6io1KT8uJfWXG8NdwHO9GG90j444uif4697s=;
 b=Zr3hzC25y1+7ygcpTbQWZn4o9NxMcK1Daz6huu4bvoVZMgEbSSpydiZaSGkXxNHlXl
 zG7shxnNBBo4Ju4kfGlrfAuu3mwDL51smpB545dsbg3kKnz2iUwTEM05CELNh1aQGV48
 cQQ0nhmctaBl8cYCCDEyvtPfc4R98ruKTObIuXI3CkI5V/NyyHCAbQXO2q6wp8yY2W6K
 ypXJO1s9AajbZd0L7UuWPq6IQrQscMsVldRspMKNd5eN2emWxUSqpfXeGd9Rizk1s41i
 eD4+0enU5nuXhB0yphrhWlHY3xhAz6eZilJ+ToX6LImEVnieMyQdGa+oRbZ5p6qTQ2zm
 kgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570850; x=1741175650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dciG/B6io1KT8uJfWXG8NdwHO9GG90j444uif4697s=;
 b=N+VP8unXpUPhcM0MccMZIYI4g8BiwnjWJTte6UQikYswx66VOu/5d6Gawn0NBhHf+y
 YcL9mhGglOLpPHa4TuzXBaqYugvE2bV5GiyfsjUo2vIe8VZBXt4VjLQ490BSfwC4E8qK
 wvVfG+4WOQivcLTouOZudLPsijvgteC6FTyY4hAAsZmo3FvAseKxy5HW94cKzEJ+bG9E
 Xx1T56vJsXVM515tibNIy0ho8Ml/hAXZKJzQ25zp5cbummjgJEBQ8Sn95THnUVEfto/0
 IKH1OrsuxnrtmI51E1M96IJ13HYp3j20bHYc7ReJeIpIaYNZs9AdTUZNlhzRmbhEQoZg
 wq2Q==
X-Gm-Message-State: AOJu0YzlQeaaUFZc3kMyV4O/9RaYtD+zfT19/MK1qCPBppGBfAHTDgLE
 wdUnpDFRBaZRyWRO/p12h5keZfuhoOxfIpo/51TsBFqpQHTCpxfH
X-Gm-Gg: ASbGncthkTrpEa5BZ2ZQ5aVUQn8TNlKop1xfgghByYk1Qo5rCiiIRejREJcDZJ0nHf7
 brX9QeHzELyZLOyx2892a99KpvI4KvC0KeK3t+yJCJSpcOGf8iw2Fer3j4LYHECQINa+GnM7sj7
 dI0uEzSJxDLE5bgcjbg3H+gUeaFa+Hca8PIzwOTyY82JMBxOHuvXcMhuE9Uf6bv4EVGD6R/iwYz
 mQaVV6KmBfIzd8Xw28sYSSS7oTzU227mcu+6Hqrt0v1clvPUtfdJDel29Kg/Xp06PZJikY7HdfJ
 iKQir1pGhQb3oChK8g==
X-Google-Smtp-Source: AGHT+IEjRGqE5ICN15yYfhhW/O2dqKMju0ieab6cDTsRO6xBQVbDrhVpKGB+CM/2Ezt0WxfpRMaxag==
X-Received: by 2002:a17:906:60cd:b0:abe:dc99:7086 with SMTP id
 a640c23a62f3a-abedc99712bmr457123366b.55.1740570850196; 
 Wed, 26 Feb 2025 03:54:10 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:09 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 03/12] video: tegra20: dc: remove excessive headers
Date: Wed, 26 Feb 2025 13:53:29 +0200
Message-ID: <20250226115338.42832-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226115338.42832-1-clamor95@gmail.com>
References: <20250226115338.42832-1-clamor95@gmail.com>
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

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index d54279ebda1..54d60836b66 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -10,20 +10,11 @@
 #include <fdtdec.h>
 #include <log.h>
 #include <panel.h>
-#include <part.h>
-#include <pwm.h>
 #include <video.h>
-#include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/system.h>
-#include <asm/gpio.h>
 #include <asm/io.h>
-
 #include <asm/arch/clock.h>
-#include <asm/arch/funcmux.h>
-#include <asm/arch/pinmux.h>
 #include <asm/arch/powergate.h>
-#include <asm/arch/pwm.h>
 
 #include "tegra-dc.h"
 
-- 
2.43.0

