Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE25C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33FB58883C;
	Fri, 31 May 2024 16:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHOE+elO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D178872E; Fri, 31 May 2024 16:20:12 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49EAB88836
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70109d34a16so1922821b3a.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165209; x=1717770009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKTUMzd12qPAu91SuyYL14lNnUxEoaRT16/KmHODrpU=;
 b=JHOE+elOlUzO8u0P0M++c+p76OHX2PUXKvEXH7iQqr4bQR1wHHC5RkA+OhXrtsNwqC
 d3+dUbpEP0znuXggF3mZ0XmqyGnz53a1GcDfFeKP84+0v/4tCLcJC9o7PKQy3YMuZeof
 HpL+ikxNtqwD0IYuh0BB7BwHC9yL5P3WziIA5+cqAkp7qz6I4pzAyFiKe61pGbFSNokQ
 D3IFeqV3jo1TyR5SrFsSACLjxn2ZKhxfMxB6NgjCGq0gxjiNU3/7Se+PVKVH6ipVztOc
 ME5fO/0jNA6qc+Sg+35TfdBF08iAtjX9uq2APOrtMAyX2NynvF5jpHQWmskXcEcgwvfQ
 uD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165209; x=1717770009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKTUMzd12qPAu91SuyYL14lNnUxEoaRT16/KmHODrpU=;
 b=KO1ODtOuKbHytwhkMVMh8o1EjjVEQAJ6EX5gvtncZWhfnWs1u7wO4nWeRl2StHO7Yv
 mt07SOER5oPtP7/N9c9MUVEffXbBkkVA/rOolDmZvLyOYv6qdHxjFqnuyedjw2giqtLA
 y0fnCEpjyNgIjjK6jSZq+wNBYDd2aFRRXYGhWJNM+Xrw3axiS7/7muxqkpZE3LQok4pa
 fEXfMqJoe/xmY2/h/YDCBzy+F8uWQht7Xvp0sAdfXDwO0pqola6v8BczuUpWqlFP6dxC
 hGceiE/YH9dEQrASUYG9ZB0ikuqkgbgcG7ZMyZXGOtY++xV+0yFA6EATqdhPBkSwJX0+
 SUPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDjcbA1lRFFRemR8farw/3+RqudgzbfNAX2c+xt57R6lnmMizDe3m08JVH/XqMSDl9P5cX1Q1hJ9nYlvcwp3m0Q7LNRQ==
X-Gm-Message-State: AOJu0YxSX/HZp6vKVDQhDcrTnz5GP6K7RUufU4WA335kQnEFHMaNgzVr
 U35UHFLg/VGNFI4ETvvXIZc6GwLvempF8/YtQ5t3fF/39AYGONKU
X-Google-Smtp-Source: AGHT+IEHrH7loJ5WfmcQ2sFn6QVmR/HPjMZ0SroFPyulhpJ5Kizx+nLv0N5TPFug68yxOY6RMyNYng==
X-Received: by 2002:a17:90a:ea93:b0:2bf:de8b:bef5 with SMTP id
 98e67ed59e1d1-2c1dc576c36mr1878349a91.12.1717165208680; 
 Fri, 31 May 2024 07:20:08 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:20:08 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de, Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH RFC v2 23/23] sysreset: rockchip: use dev_read_addr_ptr get
 cru base
Date: Fri, 31 May 2024 19:48:37 +0530
Message-ID: <20240531141837.13189-24-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531141837.13189-1-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
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

From: Andy Yan <andy.yan@rock-chips.com>

Use system api dev_read_addr_ptr to get cru reg base,
rather than rockchip private api rockchip_get_cru, which
will be cleanup later.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---
 drivers/sysreset/sysreset_rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
index 17aa191349..df6422c08b 100644
--- a/drivers/sysreset/sysreset_rockchip.c
+++ b/drivers/sysreset/sysreset_rockchip.c
@@ -8,14 +8,14 @@
 #include <errno.h>
 #include <sysreset.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru_rk3328.h>
+#include <asm/arch-rockchip/cru.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/err.h>
 
 int rockchip_sysreset_request(struct udevice *dev, enum sysreset_t type)
 {
 	struct sysreset_reg *offset = dev_get_priv(dev);
-	unsigned long cru_base = (unsigned long)rockchip_get_cru();
+	unsigned long cru_base = (unsigned long)dev_read_addr_ptr(dev->parent);
 
 	if (IS_ERR_VALUE(cru_base))
 		return (int)cru_base;
-- 
2.44.0

