Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E3DC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2AF831E0;
	Tue,  5 Aug 2025 16:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W/4GZlTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4306C83744; Tue,  5 Aug 2025 16:23:37 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C17A8831E0
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-af958127df5so506031466b.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754403811; x=1755008611; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CUOurUed+yID5ceKlFVVfCLElow+9pvlvCPmdYk8HeI=;
 b=W/4GZlTK2A7BSh6UafclDpCbd+2j0n3+7ReBOjAflmFOws07BvmuWkN3bCYK0u3YBK
 q2aB7dLy9hP8cJ5t/0I+9p+f8w6ou6E3Xb/lop3/8S5gZeGU9MEPgkJKsGRymWnqBQnK
 1Na7GPtqi38p+B28Zd4pf8z/6BppkGF+ZyX1lZhBEJhw0X0jVuBqXlM206Erufc6TE7w
 6aXQkvaphyqhJmNlHfXq+kNX5cAG16TSdf/WXJJSq2g1A/+KD3ebieOOXYe+AYYS/+gn
 iIUnCBT3fJxZ5GPuKUdA3DAIHN0tbfuwn45T31OrXfjyxOg7ABzxjf41bJWAnOYaGcw6
 Bf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754403811; x=1755008611;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUOurUed+yID5ceKlFVVfCLElow+9pvlvCPmdYk8HeI=;
 b=trpX+9FPyk8wIAUbv+0JaGRuMYNxbmsP3MWpw5aHDMbqbDcR9nL40/58rp1v+XCQEr
 ttY+pa3ziENWK3uGu4WQagRZM2GXuqescht2Ci19qAqBCgXcfIL++5/pJ1rw6vzlDQu3
 aseEYGOMhgfumVneFG+tcMHTtJu1P/X4vettNgn7OYcgZPzrM+o3iaOWPgauKiFL+49+
 /CNfjEl1yHgrWme74vbxzYO/akp6C+adAlwXiAApyS6zCW0f7JA3rUeZfFQ5xWWlcySZ
 kwPsGNXudm6JK4paKOYDHvDNgLRqHo85mms2QwBF94LsoFPJWmpprRaXQDk5IFKAHPfo
 jNQg==
X-Gm-Message-State: AOJu0Yy4VKipyBEkPjCICwfkI/ocEKB7ibfkiR0kkFj89TlY0G8Jassz
 bpvXI6ekIc30zPqe8kEvL5cVb1jzAqw2icTBfZnPlwRSRkjmBg4nSO2uCWL52khFQKPgWFXTWNt
 U6lek
X-Gm-Gg: ASbGncsfO6vpZte4uH1AtfFFnThI4bVlV/1Nq1ZDQ6YfI6Yz13lohmHBsYL4BF9Pj+5
 xmb/5Z7k2KrErWB73jTTiaFhGFi4e7h3YlJrD4P2qwwwt3/ge57fooISf0kiJYKriclyXajt8d3
 deMH/mlO6jAwZwSrYH/WAngcGWQuFriuRhAK0sDlgkxNT6ulOwi3+e331Dcks/5MOqSnNxeAqUP
 LJX+I8cy969/q+qsqROES1in4v6cSUNl+F0aRYMKKSPoykhmoI3YzVWv6ZU+c7Y6YJ7m6iXrcS0
 m7qyKR3G9Hm4uIAIuSdjwzNlyZSlLBdQBOFjDdGUro1cZMLqZ5IDXTlZ3G5ZnXXjPfen2Lz0h1b
 YKjV5pUGr9x/pKStZkJf6sC+qS495WxgdqyEABeBox54UcUoPQw4=
X-Google-Smtp-Source: AGHT+IGEaj/lN+0lFsLRV/kZjIJkBbaGolVqJLK+sFoB4awTDCHx395t+xTFz/1334EU2CIhQq4m8g==
X-Received: by 2002:a05:6000:2313:b0:3b7:8e91:fd7e with SMTP id
 ffacd0b85a97d-3b8d94bb1b1mr10519983f8f.49.1754403501287; 
 Tue, 05 Aug 2025 07:18:21 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4534b3sm19307801f8f.47.2025.08.05.07.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 07:18:20 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 15:18:19 +0100
Subject: [PATCH 4/4] net: mvpp2: Use field just assigned in error test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-net_mvpp2-v1-4-624ef87cadb9@linaro.org>
References: <20250805-net_mvpp2-v1-0-624ef87cadb9@linaro.org>
In-Reply-To: <20250805-net_mvpp2-v1-0-624ef87cadb9@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
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

In mvpp2_probe the code attempts to get a value for "gop-port-id" and
assigns it to port->gop_id but it then tests port->id for being equal to
-1. That is an impossible test as port->id is a field of type u8 so
cannot be negative. Change the test to port->gop_id.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/mvpp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index 3a3510f603a..f9e979c4d58 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -5353,7 +5353,7 @@ static int mvpp2_probe(struct udevice *dev)
 	} else {
 		port->gop_id = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
 					      "gop-port-id", -1);
-		if (port->id == -1) {
+		if (port->gop_id == -1) {
 			dev_err(dev, "missing gop-port-id value\n");
 			return -EINVAL;
 		}

-- 
2.39.5

