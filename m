Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0625CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 21:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB87184119;
	Mon, 18 May 2026 23:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S0DoNnAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE3CB84694; Mon, 18 May 2026 22:48:27 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 759EA83FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 22:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=santigio2003@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso179944f8f.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 13:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779137303; x=1779742103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1QQaEYmsp5z1UKs1FX68FonzFl5BTte6DEO5FAPeQ8Q=;
 b=S0DoNnAWTRgXqdapb7rCbS6nnDUx7dQAt0OtsawNTv+zeokWjf8A68iR4MgnWLGaKc
 KBYer5riuALQFnb7IPMNGOwUoNN+Ji6DT2AbbxQsTCgCGsslB/pn0EpDMryAIF+OMXGG
 hciPMAER7eURIJ5ZRkevQi+mgoLp4CewQxpo/SR5pjHj1gsQKlosVUPcRC+hMBGl9Gwp
 rHBT3rnm7Gp07oVVgBl/+DpQkjwc8DiOw7UZsfdsDtte3JFc7wQP0sBKhHfDDz2UI+P6
 Q39R+FakcsClKWZxuqy9DjzeLC9o8w4A0VpHeBo5ncwDUVIfly5KK2xYTKtRHrkGlqpl
 cjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779137303; x=1779742103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QQaEYmsp5z1UKs1FX68FonzFl5BTte6DEO5FAPeQ8Q=;
 b=TKI0+XU/5C3NxA6sX5Q57OVmKagGOH3utYLA7KI7vVaSl6RkrMq4UAy1kbh6PguYpG
 V7nFmdhk/EsutvJO50H3URayUOnKeZmAJNE+4FdleC/VZ7KMF7yDjDPJSyawnzF9zv17
 VcYil3KeBnHCgMXrmQQ1LjqNVvTHJ/n2lAk5JiHii9iFIw1K0q3pqy415W+iwdhDAO4C
 dISH1fBKXidKS4TE1mMoStt9tkaapooQJ8p5e7GYT8FnH3HXkZbpuqhM+itHJQQ9JQOO
 zN6xHfhbSBPBSQR6LUyUwbW7rXd5if4QNifN6an3Z+QGIC7Tj4BuOWZ2UwakAqu9OlMy
 lK6w==
X-Gm-Message-State: AOJu0Yx/7F6JjrMEvsGJgsd1yYYqOLMj6i7Fi1ZHo5RoaVBuFRuUTJZJ
 jhFXul/kAAoBfFmK2rG3CLrFJHH9T9cgtQVVEpi7d6kXLNJwGeCRhc60JD0bYC6H
X-Gm-Gg: Acq92OHB9aUGhFen/brWPRLb/dNA0rim6qbADQncs47Ac70gMMi987JENZ89fqSb7FE
 uBJKZC70sFaoinoKJ4UfojN0kYuvSYrY9ZXd+1AaMdBOeax/4RBdVy+sc/B6q17yjCZPWrC3s8Y
 QD1q0MC4uh4Voqbutv8SQ/0duRszWOg7R08e55Y2LaiGInxWtAAaAh65Zh9cxGWPAPNn9z0XN7q
 MA0gKvDJN4YcyPLTpiAx1TIzbD7eyCM2N9CY+JR6om7J4T6ZOQt1YRApXJrjeY6UndRZALplXGK
 +LMmdQrS+gfE/Ss8MFlNZKIcEEeVr5EukRez3GFOKqFC/BcoLip9JW4FQzDMbvBqoaNZ/awI8wp
 Hv9Rhrb+WwbnVKdSTQXutNNgnXw0jcZRTwAFu+KKuyf4tVD+h3g7w6jnTloIhLxCle2FSWYvCUf
 tSpmAmrG1oEw+1MU0JonEZ96/c422Qcs+dqB4xehR6Ro7cBEqM3V1f2Qw=
X-Received: by 2002:a5d:584c:0:b0:446:db72:e8ec with SMTP id
 ffacd0b85a97d-45e5c587281mr26980555f8f.23.1779137303447; 
 Mon, 18 May 2026 13:48:23 -0700 (PDT)
Received: from debiano.tail0e82a2.ts.net ([193.205.210.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a178adsm42064928f8f.18.2026.05.18.13.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 13:48:23 -0700 (PDT)
From: Giovanni Santini <santigio2003@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Giovanni Santini <santigio2003@gmail.com>
Subject: [PATCH] Makefile: fix extra dash in KBUILD_CFLAGS
Date: Mon, 18 May 2026 22:46:05 +0200
Message-ID: <20260518204605.1415006-1-santigio2003@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 23:03:46 +0200
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

Remove an extra leading dash from the KBUILD_CFLAGS assignment
under the CONFIG_CC_OPTIMIZE_FOR_DEBUG conditional block. The
extra dash breaks the build when CONFIG_CC_OPTIMIZE_FOR_DEBUG
is enabled.

Fixes: 56ae3c2a44fc ("Makefile: repair CONFIG_CC_OPTIMIZE_FOR_DEBUG support")

Signed-off-by: Giovanni Santini <santigio2003@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 552328f9f2c..e3b6788f848 100644
--- a/Makefile
+++ b/Makefile
@@ -920,7 +920,7 @@ endif
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= -Os
 else ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG
--KBUILD_CFLAGS  += -Og
+KBUILD_CFLAGS  += -Og
 # Avoid false positives -Wmaybe-uninitialized
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78394
 KBUILD_CFLAGS  += -Wno-maybe-uninitialized
-- 
2.47.3

