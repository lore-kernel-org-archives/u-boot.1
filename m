Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CFAC2BA18
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 01:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6908B87C69;
	Fri, 21 Jun 2024 03:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GM3AsdHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2957487FC8; Fri, 21 Jun 2024 03:51:43 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 978CB80C58
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 03:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52cc5d5179aso2068738e87.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718934700; x=1719539500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gUk3LFtbVYGV0wVXyVu06IalIlwtKtkl3lMGhm/QNQw=;
 b=GM3AsdHOBpDfjhKjCSkoC2AQaM9UZbcZEamk5PLcK5sM15uzWq/tsDp2mHmYKWPqry
 abbNENPRabhVhp874PBq6jsJnu02UvmJDI2jC74aKs6Z8ia9ynBlzZurJXxkDYMKRRp1
 CycI5QK3+I/lEKE1bn1sR85S2k6BeuOHzgjfXquYdtHMMEwRD+AO/kJ5infhVIaWBwwj
 fPn7OKfE+wO7zrdW5xmfxAF9m0Tft5MXC2K/P12buKA6pyNPpBBkNkH8bAACuz7YZ7tP
 gD3oGdOMN73YyFIdJwEvyfZ0gvZzVYLqjohxLv9ik83SkylMJmrE7Ooi0RsSvyenMQIW
 6Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718934700; x=1719539500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gUk3LFtbVYGV0wVXyVu06IalIlwtKtkl3lMGhm/QNQw=;
 b=PPEe9C3FpnV1ihco7EJSvgq+Qff/y1JRWaSKigxqriP/l9gYbWWq+DYODSu+vhTFdx
 AOspgESy/hFHLciNsz2iTvVo8RSuk3VJIWtSXaOenZDCSt23xJAySRgMziOKa/S9nZN8
 mDn93zz98Ou+n209qnXaefY49F4mVsfW6aiSFk+GRZ8VPoLqIOIu5JqKSTOa2Bhz9p/q
 l+DaPwZ5PsvQauQSJ1XGsumh4v0qYKHbHB9ePc/5ZbAPlyLz/XbrCKo5noDOHTyYJiqm
 uyzQ9kmFogAFUGliXX6CvD/ZYQSRtnQtH2jCupfV39Jbu6lsbvPyG1KZX2EoliSwV9SU
 8+uA==
X-Gm-Message-State: AOJu0YxTv03+Cjr8OrHjYErBvFzEhM2C4UF3LdATwrIPfJ890RKQZhiv
 +LWMGQGswW3A4tq3rzL1wVR2SYOqxZhWBCi6pg/HLZnlDR8gd+aElPYuYWcFEQ8=
X-Google-Smtp-Source: AGHT+IGgAWfktqWbC2YfMhm//AcqfJD2xxPthnT83/Jk9C8TJ/Xhx/tJZjDPTjl39sLJD0x4bYqAPA==
X-Received: by 2002:ac2:4834:0:b0:52c:8a9b:17f4 with SMTP id
 2adb3069b0e04-52ccaa375c8mr4336811e87.37.1718934699697; 
 Thu, 20 Jun 2024 18:51:39 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::ebdd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf48b17esm28499966b.88.2024.06.20.18.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 18:51:39 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Alexey Romanov <avromanov@salutedevices.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] include/fastboot.h: add missing types.h include
Date: Fri, 21 Jun 2024 03:51:02 +0200
Message-ID: <20240621015135.1570605-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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

Fixes a compile error when building with only the TCP fastboot implementation.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/fastboot.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/fastboot.h b/include/fastboot.h
index 2ca1b907a54d..b106d6177493 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -11,8 +11,10 @@
  */
 #ifndef _FASTBOOT_H_
 #define _FASTBOOT_H_
 
+#include <linux/types.h>
+
 #define FASTBOOT_VERSION	"0.4"
 
 /*
  * Signals u-boot fastboot code to send multiple responses by
-- 
2.45.0

