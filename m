Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ECDC36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A8882FD2;
	Mon,  7 Apr 2025 19:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wCWvvPJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C26D282E66; Mon,  7 Apr 2025 19:00:03 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9043E82F7C
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so774729666b.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045201; x=1744650001; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o+CeHKfRMQChft1Yb/KHeC2rZlMyEFaELy6WossvVls=;
 b=wCWvvPJvPWraIjknuzSMq8YbuYTQoYxwwUDhfP+UhTjpdO/CDUHJAKWwwJty/6pUZR
 uGZkU8zFT624Ts0iLbNJJouCiXe3a4Tk4FXjBOZPRtShtn95+FYi6TwH9agZW9RkuQA3
 MUss7D6i5r0sYCGHHJvKPiY+CciOFjEWrzwGDblQ9GiMIct98ABhX72/sx0jLzr3zRkK
 SntXEcIlzpLK9rxyyp8laZOTjbEAtOxK8AK+wWokOHLghzd6i4SKkoyoK4SXHVKWN8uq
 HU+2EJKpKo0221KBVUWqvQ/sn/P/5PI5WaTltjfva/WEPJeG+11ncdYdKAE0/Hzt0dkk
 avfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045201; x=1744650001;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+CeHKfRMQChft1Yb/KHeC2rZlMyEFaELy6WossvVls=;
 b=LnGCSyMn4UzFbXbHk18fssz7BIwq/G4HwwVyqaC8VVf+ZP9lTfFHsnB6qFlnwBYHc/
 poXNZDPD+rNc05PAWNO8DgA+CULX5+5BdLJhGrGKT68hew8lHOGJnOxxKhFGpW/tZeDy
 MRzgA3/kUJZ7htokDI172vxvXT4pkhhbLZIzsCYRlqTgbjYb16XY9fDnGiuR5gsLA4iO
 V0Sf2RxMVUVzkbG2pCnbQbeCioF3qIGGyjXKlHyEBDjG3Kl1UPW0wCT6DSEh15CuyGNk
 wagcNRajeaN6tnLi9r6tfYD7pGQK5CYn1b153W0cbRgJYus+94SUjyiD4G5UJnA0nuLw
 PaTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRgF0l/hMuixYNDkeAoTUgmenfpm5wX63DARX0krDaIyBjzOFiWfrYZLDhf2NZwiu3D54DGSA=@lists.denx.de
X-Gm-Message-State: AOJu0YyD9ZXzJQfcStSP/Rh2gF/00FZTcH4t5ZTvrjMHiWT0HsledvHf
 Xi6Tbi9tx1NYJ1wt3UDgwL6JmsgeLVslbQL1k6u3GeDgkea/sQFFEAAm8Ga7rr8=
X-Gm-Gg: ASbGncuUh7y8t9ZrghdDIsvR7TSa/85NDT0rZ0itAsFJPE6sFlPkXYHYg3CVf3Ymh0v
 6kjLnOACcYZLpGcRQqRTZgNVoyLN9sZG0G3HDZx1Rqn8NWg4mGyI3M4w4mY9K+WXUNWFzODlaaw
 wnnAbejsG3iMqOJwEIuvHVIKpAQMmyFf0TCEBDRN0lwfxvleZPIGysQe5pnGxCoTXQCZAUIlWl7
 +sBRcG1AJsG2A9yVcKuJg4Raz3IKqDFc/CQ5rn6+K5rPjDWgfZjmEzfp2Yipyar1LGk/N1N97FR
 hxDVy9lpzvYXN23IXEo/nh2nu7dzvwzz/OvsyKqMdBuKKsF3I1k3kJmbHLDIk/GMDwwD
X-Google-Smtp-Source: AGHT+IGiNf3mX215xwU7wc+6VT4kCFg409nnoxjclu+ZjGD2oiXSXZib0xOYZSxWjCc/ogc1QxmcZQ==
X-Received: by 2002:a17:907:7d86:b0:ac4:5f1:a129 with SMTP id
 a640c23a62f3a-ac7e720cb38mr897766366b.15.1744045200941; 
 Mon, 07 Apr 2025 10:00:00 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.10.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:00:00 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:27 +0200
Subject: [PATCH 06/13] board: dragonboard410c: Drop unused linux_image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-6-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

This does not seem to be used anywhere.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 board/qualcomm/dragonboard410c/dragonboard410c.env | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.env b/board/qualcomm/dragonboard410c/dragonboard410c.env
index 57a30031f743f43d4a6389286b426b404d2f371b..eb42c0abcf11fedf7ab86d1340531b4ff5b52bf5 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.env
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.env
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 loadaddr=0x81000000
 initrd_high=0xffffffffffffffff
-linux_image=Image
 kernel_addr_r=0x81000000
 fdtfile=qcom/apq8016-sbc.dtb
 fdt_addr_r=0x83000000

-- 
2.47.2

