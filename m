Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E6CC83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 16:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D972A83544;
	Wed, 23 Jul 2025 18:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OONi/aqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1978683577; Wed, 23 Jul 2025 18:37:28 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF31833D0
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 18:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso32648f8f.0
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753288645; x=1753893445; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lpZ6EeYs+LGWNt5MketzLyae4vHBD6BLVZAXkb6Gzpk=;
 b=OONi/aqoy8YlH5e2T0JtmL8MQOb1/63111T9TtV2VjscJT1xiUFg9QBaCjlkiob9Xk
 N+NaGGXpR+WmoRFHFRw193Zy/iKJBtH+QvQJOQIh5hXHho8sHMComNfIDFV5z8HsbZpC
 g7lmeMgh7nw/HjUI5xyq7pS3EVQcjqulaU0QHaoaGE8dA1qP4YAPmtJG5T3ZntZMBnQN
 /gdhazhyqA5f/sHw/KuV4NgclLLlxAiWnp/jb2LddY8koQuTk3t06DZNTDzuC4M+Iclt
 W69gSxBe3ISn3Q/p24CPzll9uJr4ter1ESDzsL9wEOc/LEES6XrSOqGLDK7BNg8SCHxj
 2fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753288645; x=1753893445;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lpZ6EeYs+LGWNt5MketzLyae4vHBD6BLVZAXkb6Gzpk=;
 b=dUqagUI6NWfzmd6B5qcJc7pkRAgXTF6U0DeVfrK3dBkmAX0kQ5J99Zklucx+4pqAQ4
 4+miRYP88mUbrBUp+bN45UdHiFnWlOu4yQmNkpUwgT59efxwRJJ48k45rnsu73raA46x
 GBdO0HPuQnhTnYL/YII0DgJEZexaR30z0yeDYxMuo9N6xCNr6OzGvQ5LLqA/EcyHiqw3
 wVovP2mOobzQuTyJMB1zlfd18TrEit6BO9jv6M86c8Iu3S/gcojVMmeXlcpzF57Au2Ml
 bkGBa6TK2xiXXcvH4vhvy9CLIEFvKhW02JFk80Ixi69UfhX4fvhYU5gmQT8VOFL7Wd7X
 WwUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfYvS1eXWVmeKlyo8ydPcVYY7eF3SuZV8Nyo9PIa6cn26mt8uve4l3XZylzc+wrovbPJjLVc8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1hNZlD6znJPO1Ul0mXT+YkOcDpcQ4LRl0dNDXYRRLj4j2ctk/
 S8SOp/TMjrkO/FJUijxiiA9i54j/m5utjITtqBRWeExi9Db4oKDchpIaZ1p+sE9rO34=
X-Gm-Gg: ASbGncvIhPVkRRyanApBmf/Pu9kPYghc3lOY+dvXwv8Uxf2l/Lg+0nFh4iLpN1CSTMj
 nL969pxUmRpW1ioqkFsjTy5baSOSyjegjRl4C7l8n5wjbI39EP0zvZLnX02ibdCJv7Bj7b55NbB
 rC0gwTeSL0Dbu5zGP0ZmEzYxy38kFVQFqFqQCwqsrr7XE1fMhbExH8paeKzkNVNYsBOXadTjIcB
 DhOfCHiyOIAH50mwI1oejk/1A9EAaRO4v654TlXPI+ypbDZG7QdiRTm7vLwevIGcnT3Nvnujbx+
 1n5bCa16xsfkocR0b9PLQcXhBgJOL4BzY4t3cexyEboN3UhEtVA5bidwpaStCFzn2fp+WIDEkeM
 IWO5ADoPAk3XHRqMXMIlRvK/TSoZLb0RevlunOdx8gXinSNRGqsc=
X-Google-Smtp-Source: AGHT+IFD1QG5/tPpr7t1LFGKsn1FDEr7VExg5+sqDAjwyE1HY9kcu/ZwXgtvxKINttXpJlPX4VYY9g==
X-Received: by 2002:a05:6000:208a:b0:3a5:25e0:1851 with SMTP id
 ffacd0b85a97d-3b768eb077emr3485130f8f.7.1753288645430; 
 Wed, 23 Jul 2025 09:37:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cdd8:a59a:1949:12ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm16855166f8f.59.2025.07.23.09.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:37:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 17:37:24 +0100
Subject: [PATCH] clk: meson: Remove unreachable code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMMPgWgC/x2NUQqDMBAFryL73UAaEbVXKaUkm1UXNZbdIoJ4d
 6Ofw5vH7KAkTAqvYgehlZWXlOH5KAAHn3oyHDODs66ytSsNTuN3Jl2SKWNrA7q2ayJC9oNXMkF
 8wuF6zF7/JNfwE+p4uyPvz3GcPO1M3HQAAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

A second return following the first return is unreachable code so remove
it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/meson/g12a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 5d7faaa3eab..a7a42b2edb6 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -916,8 +916,6 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 			return -EINVAL;
 	case CLKID_PCIE_PLL:
 		return meson_pcie_pll_set_rate(clk, rate);
-
-		return 0;
 	case CLKID_VPU:
 		return meson_clk_set_rate_by_id(clk,
 				meson_mux_get_parent(clk, CLKID_VPU), rate,

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250723-clk_meson-3d90bc29f8dc

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

