Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0F3C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 19:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9651181F6B;
	Fri, 14 Mar 2025 20:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CnSBgizJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3666681F4E; Fri, 14 Mar 2025 20:00:26 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8502E81FBC
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 20:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so294965e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741978823; x=1742583623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uH23akKVZfQljel7iB5d49nyZgab/eu4wSp6VloeLbg=;
 b=CnSBgizJasTgIP0tI6DJ6qb3Qis8/RE5l2TR6BUZ+J7zpKZU5t2XA7zwHI4cwc2Q94
 9CG4xWSieLhIaxCwbi86K3d8HUpmOgm/MaJBSQhaE0TeEzEw2/cC4JM92ua9zmomoLe+
 6mdhCOIULhYZvbmpZ3wzaoSjAaY8hs3b00UB4wM3mNZ/9OqmLHDzfo/SmjEylF/vmVuJ
 OV3HyiNeKq8z52sHES2lNHHr/51hLffvQCOOx818eZaIamrtA/3zPwavlOnufBvWnJ+v
 PlHJKSh67cEa8nt9kGUV5CkJrH/W2LZ5NtREbkdYLP/3VumWeO8PjIHidTcDmgss9A81
 2vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741978823; x=1742583623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uH23akKVZfQljel7iB5d49nyZgab/eu4wSp6VloeLbg=;
 b=PiehGXi3PF5aLaZMpwlhsUZ9IPq9PIsl8sTr1CpElXRnRX20Nqh5SPQlXfAnoQGBGE
 plOoCukZtn+qSIKzxM+H8GqhT1/7bLMsR1D0lzCrKL52EpNwcZIx41q18bTNiANp0z5q
 u5uvzpP3t2O21GyRyDIKwfQzX1cafQf8LYpyct5ijdLxUl+pwhmMtkO5qwM5w7zvi5XT
 wqWkgfwxWbUaBoDsOTJMameHZX940945TQGZz+z/54fOyA9NA9iVNpBMABRLilwx9xp7
 6LpNeuB1v+j6e0v02/cNlFnAroXEyjxgWHouQXIPuKvczwiIJMF9vIIcxWIlRL8onvoY
 O/Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtPTdCMb1YnKzAxb+lDtklUz4qB7BbQ2y/ydrK/7uGCpKUoZxtv5tUQGajouIwHNJBIxdSCWE=@lists.denx.de
X-Gm-Message-State: AOJu0YwIypga9hYuJzLmmfvqNX4QTAh/KEg+yRrPbRmx3cH9JIbLZs+4
 bsfSaI8tlVau6DvIVnrjHW7mr7YZAXAu9QMVSy6A5YzDVBS8IbCj
X-Gm-Gg: ASbGncsoiXi1F254OIvUd6bbTfoy+u+EykglzoLLNTnHmpwg7+hGXVkpK8Go4Oj7uta
 4F+uaZrFFHXnylwUpOur2tHxqETy7vM8Fgg4V/arzWoS8y/HLC5LALZFIvbRVMbzlBv1yOjDDg4
 1gaboOPcweR6e+w0yx3rhVe2r5FjD+GrrI8ZtJHmQbZbaSOi9w8J5mAEKwiDvD5ZaLMYpFQ0Ssk
 qSJomoq6HZUP80eI9otv2QcIA5k9OVfrdM/cnzmbv+HX6FeO72O/m0W+ytHFJvpJwQMg+pUW1aX
 FcYNJ9Qk3N6MyKvw44J3l8wYXpeNF3Yng5CD7v1lDqJzoVvptWPwXDkbMzQ+Ct313utgSw/L8pY
 CYXL6Eam4u7u6qw==
X-Google-Smtp-Source: AGHT+IFkCViOaSex/vYWBn5/sMbOO4fz77CvVmy0KO2n9nuJlapbsrqelZLpnkDcpULJXT27EzAXVw==
X-Received: by 2002:a05:600c:1f1b:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-43d24e78c6bmr7605305e9.10.1741978822589; 
 Fri, 14 Mar 2025 12:00:22 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffc3e67sm25547965e9.17.2025.03.14.12.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 12:00:21 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 5/6] dt-bindings: clock: drop NUM_CLOCKS define for EN7581
Date: Fri, 14 Mar 2025 19:59:25 +0100
Message-ID: <20250314185941.27834-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314185941.27834-1-ansuelsmth@gmail.com>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
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

Drop NUM_CLOCKS define for EN7581 dts/upstream/src/include. This is not a binding and
should not be placed here. Value is derived internally in the user
driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250113231030.6735-3-ansuelsmth@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>

[ upstream commit: 02d3b7557ce28c373ea1e925ae16ab5988284313 ]
---
 dts/upstream/include/dt-bindings/clock/en7523-clk.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/dts/upstream/include/dt-bindings/clock/en7523-clk.h b/dts/upstream/include/dt-bindings/clock/en7523-clk.h
index 717d23a5e5a..28e56745ccf 100644
--- a/dts/upstream/include/dt-bindings/clock/en7523-clk.h
+++ b/dts/upstream/include/dt-bindings/clock/en7523-clk.h
@@ -12,6 +12,4 @@
 #define EN7523_CLK_CRYPTO	6
 #define EN7523_CLK_PCIE		7
 
-#define EN7523_NUM_CLOCKS	8
-
 #endif /* _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_ */
-- 
2.48.1

