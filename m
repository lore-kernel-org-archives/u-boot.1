Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC84AC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 12:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7464B84A0F;
	Mon, 20 Jul 2026 14:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="VuigZ+2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731F3838D7; Mon, 20 Jul 2026 11:53:10 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C409B844F6
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=william.bright@imd-tec.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so5246732f8f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 02:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1784541187; x=1785145987; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rfLXdv5WUFEm4ibUJQJVdmgyCqtjqXs/KcyFWuKGtvc=;
 b=VuigZ+2zRrcD6ItoSdU99t9mRfwB5/AtfSTX18Iv6P2EF1LD+KLPdR7Cy1WJpZ9MKX
 BHiFyrFYc/Y6b8KSFmnX3JNApbLttaaZzonKdE6BXoVnL0g2Jyu+ehXGKzfmdyKHorSD
 BY7qQZaxo2dLWou/vFQsDlyLTPBGmJuvzqi6Cjg3zSEOzz0TXjFt+P0Bspjrq48v0WY0
 J2epu35QCnKa2Z9Pj09JOBbZhYdqoRmqRcDoURFUqBvqwjj8wpy+vkeNqE56VyZmGwF6
 8dED5CdxAYOm/mYatFcDeP2brne3XyYEYKSYwQwGSY8cNN3dyApphVbvHRmgofxTIZC2
 GU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784541187; x=1785145987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rfLXdv5WUFEm4ibUJQJVdmgyCqtjqXs/KcyFWuKGtvc=;
 b=C8Z8oUfWEjIsTZ1EOeh9KsEBr/l61Ym4qOB3DzoxdtoA8yXvIo7lTYD3oE+a7MqCct
 Id/GbZqcplBzmnlPMNcaoyCY8eJmvCjqg6tbfhQEeJmC1Bi5yDtokLZze/SpmITGoR0U
 aOgi/5Shd+4bcflAOJVySm4YY4OlB9pP/wznpI8GuWV5i2f6R8XcyjvDcNesNzKFOC9a
 cxHjhF5arPZP/QQGddtle2yzqs98T1KMIQ2gL7vxkfTnp3bf7uP6Doi0DHmWkLVBoE+6
 twl4ciJehsxtIaD11BlyBZYkuBV6Ltt7VP2CzyctLnrwQgKACOAwO4OKE+Q5HFA3Qana
 2Jcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxX7XINJpFcw69MknrIZUCTUJ/rPiPiDHmFjRXYaeoEm4ndU7eBMQbx0o3hB50qgkRmt43p9g=@lists.denx.de
X-Gm-Message-State: AOJu0YwuUaACZ/32iWT/Fez+Z5Z5Vy80VwjOa0Yp/HhJdA3/HZmA64HB
 y2ljmDyykBxWZa623Spx2UtheflKcymuZvfAvObDSWNXfHfAIq/d7pavMLzjkxf/T0c=
X-Gm-Gg: AfdE7ckKygOehuh6xneEw/pUfWkgWgQ4p0/l80EZBg94xu843ajkcO9Ij5mEOiGj99E
 UZDX2vEdzNf3qeGkUHFM+JEVqqh28YGv+D1Sr9t6mhDXVT+LQSV7/+UYrCNTJ9zjVNo79ITCsGR
 GXa7GZl8u55CrVPXetRaBjaHiBswoS/NL1p8levhAIdsBMExNpHPy9VAbC1EIYqQdYC79ACmqDe
 BfABKrtBltuyqqIJBXTBYbs39fWD7daw76VSGchkDY0D+8ycLcrwkWRMgHiQPQ9UzH50EhY62d5
 oumQ6LgsfT9R0YcTVQ3ECE0cM0/aEpB0Rn1QlZkwb6rAy11kAL5k+RWu9sX9XLnkHzwdYaH/U/T
 xQ84fOLEoz2tIN7zguYlOYX9FyIu1OXIv50UY0MJF0c9G+5P5EZy3IB5H9b/EAUQ/h56aLKzqr7
 PGlpUS/yfYqWxngJC4dlU89MAupK21nHLXrl0g69EoETe+uYYCxhrSMtZIWf1Bc+RHRrheOA==
X-Received: by 2002:a05:6000:712:b0:47f:6f2c:7303 with SMTP id
 ffacd0b85a97d-47f6f2c73c3mr8222746f8f.33.1784541187233; 
 Mon, 20 Jul 2026 02:53:07 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm32537104f8f.11.2026.07.20.02.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 02:53:06 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Mon, 20 Jul 2026 10:52:12 +0100
Subject: [PATCH 2/3] dts: sm8550-hdk-u-boot.dtsi: Add memory entry to
 bootup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-sm8550-hdk-v1-2-84f077937303@imd-tec.com>
References: <20260720-sm8550-hdk-v1-0-84f077937303@imd-tec.com>
In-Reply-To: <20260720-sm8550-hdk-v1-0-84f077937303@imd-tec.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 20 Jul 2026 14:28:29 +0200
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

Added the memory entry to bootup.

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
 arch/arm/dts/sm8550-hdk-u-boot.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/dts/sm8550-hdk-u-boot.dtsi b/arch/arm/dts/sm8550-hdk-u-boot.dtsi
new file mode 100644
index 00000000000..4cf2ec32016
--- /dev/null
+++ b/arch/arm/dts/sm8550-hdk-u-boot.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2026, IMD Technologies Ltd. All rights reserved.
+ */
+/ {
+	/delete-node/ memory@a0000000;
+
+	memory@81200000 {
+		device_type = "memory";
+		reg = <0x0 0x81200000 0x0 0x00800000>,
+		      <0x0 0x81cf4000 0x0 0x0000c000>,
+		      <0x0 0x81f20000 0x0 0x006e0000>,
+		      <0x0 0x86e00000 0x0 0x03a00000>,
+		      <0x0 0x9b09c000 0x0 0x00064000>,
+		      <0x0 0xa2a80000 0x0 0x32000000>,
+		      <0x8 0x88000000 0x0 0x39a00000>,
+		      <0x8 0x8c000000 0x0 0xd8000000>;
+	};
+};

-- 
2.43.0

