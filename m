Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A49D75E34
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2878E899AD;
	Sun, 24 Nov 2024 20:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FKHRcp8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 750C989922; Sun, 24 Nov 2024 20:18:01 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A0789578
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa549d9dffdso88846966b.2
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475879; x=1733080679; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MClsSL1e2wvBAGUc3z1v56Mq9hCHj5kkjYLV+fa+pnY=;
 b=FKHRcp8bTdvksPYjeti/dUHnWyWmux757vvmARvszFKpf650kd+LQ4oE7wQURB/C+u
 bmhMRe7JgRBUvI40s09l9yTBbHmUmhq7pmqpDC0Dnx8RflAuoz0j6DFFKIV228ddFN4o
 RQ+0jtWROSP5tqk8gMPFkuGUWLmVl2i9tn0OqyO+SMuoOFuB0Cu+GZ2W7M1oj8PILZLM
 Ga/qmMh8T8tpZF35JwTmxC6cUaREwK5S9UlO0NFW+U5tsFfOJW2qprqjuLFYV3QByvfR
 Mqeddfcyisnop1GQRY8yV/yVis/SwDl1hYCAHpV6EQkQjbf/uCDBygZ+8cguFIEUb5qk
 oKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475879; x=1733080679;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MClsSL1e2wvBAGUc3z1v56Mq9hCHj5kkjYLV+fa+pnY=;
 b=jbc9Dka4gAS7mDuMQy8wQV/bKzjh6EhEJPOkapiyzMAs88JMgcjzIvagEvI9ce+RMY
 5iZqcFGjG3cW8+w6B9AR/p1ZSWZu8oMGXYC0qtwbUsdSB7CXlkx4YmA0BEPTPlZ3H8ZT
 VeJweJBorpktnMxBuoRPKFc9o8pSQxFO7dLOftpLDk8NlGF/gC7Ykk/pPxVHSp/VX/dY
 t7kCZKF1ysruTFFcd4ugV1iuvMaFS3DQ8hfgqUCdpQKnRubBfMJ5MIH6sINMJkjRBfU1
 lQ26teZ1A47aZ3h4Hmf56zWw7DTpCaAH/pDyqgTduRAxkCJwFoettn5x4VKLBE07xNi0
 lmUg==
X-Gm-Message-State: AOJu0Ywex0UMDmx5E79TDg9svIUKj6OCAQi3RPuUPMWrKNII5H9Pf4ws
 pVKEEq7cJzP0t918Gf54pg04OfjiqaBNjVdLN6/hcPXRyao8+GyTNCpnLwJEFbg=
X-Gm-Gg: ASbGncumCAqVzb1IEe/v2jWZgNQBlBFIrC67Bw/JRpl/9zPpavJx6vWf+S+Hyzass2w
 LPu4M/BUO+KjjEO0I5UkHwfiq20sWHfRkL+SJGnUqgBs9JrJwoPoIeeRlPQkXukBXvUFQOUPgx/
 3+kPxde7zV0gv2VpLRAG9T0XQ8esASOqq3iKhXWYn39GNgY7sVZsoqrzRUO4ytS4Z1XByZwQF5m
 eLrRG9V89byvM7Qrdy6NYrtEYEP41XFN5LRTieeafzUnZMsBIRmn8ePkAhG6SuS8e2O
X-Google-Smtp-Source: AGHT+IEBRsKDMRFuYyjJcvIQVIOlhFkVGmQ49SFczY35U0JfvzIpcbSUAKMNTYsvT+qQERv8cSfqbg==
X-Received: by 2002:a17:906:18b2:b0:aa5:152a:d0a5 with SMTP id
 a640c23a62f3a-aa5152ae2a9mr960416366b.18.1732475878912; 
 Sun, 24 Nov 2024 11:17:58 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:58 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:53 +0100
Subject: [PATCH 11/15] mach-snapdragon: increase pre-relocation malloc size
 for smem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-11-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=687;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=P/QiqoWmYOMMkdpsxY7kqwwQ68XMYt+OSTz5Ofylu2o=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6pu/Sm5wuTiaTV/m6nUlMsP014QYhuxHqw7ujD3/w
 9sp+kRyRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIXx5GhuWZx7mEuBqv/7oe
 7js7/LzDBP8bS95YFP5jYe5caO2sW8jwvyqymqnxQHSu3qK199br/unXyTe4/YNfvJ4vN4VZPWR
 mEwA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Ensure we have enough space to init smem prior to relocation, since we
might parse the DDR bank layout from there.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 976c0e35fcef..5f3a1b11d8e2 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -14,9 +14,9 @@ config SYS_VENDOR
 config SYS_MALLOC_LEN
 	default 0x10000000
 
 config SYS_MALLOC_F_LEN
-	default 0x2000
+	default 0x20000
 
 config SPL_SYS_MALLOC_F
 	default y
 

-- 
2.47.0

