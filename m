Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509E7C61CE8
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 21:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 025DA82ADA;
	Sat,  7 Jun 2025 23:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X9KSSeTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E9B82B18; Sat,  7 Jun 2025 23:12:09 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7FC7811AC
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 23:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so27343985e9.0
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 14:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749330725; x=1749935525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8mr3lfpkS4r0H9ltZR9KgPqZLmg+PTTo9+IqkIqJwWM=;
 b=X9KSSeTfgjI5tu7kfAT6dxQW8wojgdY7ybcBaEfQeWwNTsmHaMhGcF1Y//qhqIi245
 tz9wLkz8eoNzi/C1ufnAygf3xUQYcw6BnNylVrTb1u9ARE+t9mq1Nt53+gmCyKpwjws1
 zAvEfjs8jdqUh4OL1OBPAtLLs4ZgwyjRIQeqWJ3g0eigIcXM9LCY+IRk40Iy37YHkjXM
 rZWzM4QmlCcj6Rnzs/Teyt3QtkCpv07uABApWdVxBDf3IRZDtkLhSGB9sJES5Zy6kL52
 is2vBfnCB19vo7IHjrcjHeYMiMR6ejeBpxPl6Hii+OwyU0vhYgohldEhHsD0yFvW+Cp1
 y5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749330725; x=1749935525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mr3lfpkS4r0H9ltZR9KgPqZLmg+PTTo9+IqkIqJwWM=;
 b=ionpDdswfp/HJGSoEwlQMfeUc/INj8eiv9O9FNyGK+P8BxQwPhmutAIGm7LKSlE1T5
 KOFHcNG30wJNskA5ISkEavAfPGWtXy0Go4OFmAAyiH83HSMJDkJnAWx+BovN9H13GjZI
 ayVM/w9jqyTksY/LiHyiw2cQ5KhllrYzWhMJKW0e2ZNQ17YGyjIuqd5w7jvU+VQ7KpIh
 zikIvRw+HHKhPKzXm0SUy0a73IPghCxEfYgfTJM5dT2ar3K/5M2ll8olkWhoeb9TTrzQ
 fp+w4KsZpQIaxQ0golyjvbENludg8WT+Fby/WV6xFD56uXK0xhJk/jnrW6wxFbHrgs/Z
 eDyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR6SzDtsG3hiY2GSTgv6KpEcEnY2j4apAYVw0yHFpSK1aNrtKhIAEFT3VC9fCP4hT2H7uFukA=@lists.denx.de
X-Gm-Message-State: AOJu0YyrqmwFPnn9PXTGcbhva6xsigzIhw6VzBfTwMDfrIgw/VXCUYM0
 PGSDrOZrFOe8PQ8NnxB26ZeIctqantexreHezzt7YxaJXx2IeTtomv/V
X-Gm-Gg: ASbGncvLSj1Al4HoPUbgXnjZ5UufUtZuLcgEKouPK6HLGRj2dpj1lMQfFF2rR6JGCBq
 vevZcoRY8f494GxdzlZXcua4dev7PJcMU0nQJ7jtKFD+sjjVywx/QTGar0niaMRNAPgOjxBatS2
 WpcqxVAAZ3jdStMqNl6K7opPLwbo9DdnVsbrJOYMSLBihSuX/wv84m4s0OGVZcKqsZEeMZFK5h0
 aYStnHfDFDKTz0L3Xu0B6uHu5qa9G6BEg9dfc/sPWh+Ca74OycajZ924ogL27eOSjujNKfCUATK
 +pp6in5ii6/DtzaxfL3oUjLRPd82ScfE/dr4CLOic2oEYMdWwFn7fwmhuzp1o4dUr8RLjpKfSpW
 OeZatQMRJ9apwPWeagEKQFPKe60ksUUA=
X-Google-Smtp-Source: AGHT+IEzCaip7vLdhZHl9Y3iX1621JOU/vedcnlUFEjPB10bwKtXyhXU9+OEnJulaDOYz9gJI/+5nQ==
X-Received: by 2002:a05:6000:430c:b0:3a4:eec8:c9b3 with SMTP id
 ffacd0b85a97d-3a531ca80f8mr6614619f8f.23.1749330724889; 
 Sat, 07 Jun 2025 14:12:04 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4526e155ce7sm64368245e9.10.2025.06.07.14.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 14:12:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 1/5] clk: imx: add missing linux/bug.h header for WARN
Date: Sat,  7 Jun 2025 23:11:17 +0200
Message-ID: <20250607211133.2005-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250607211133.2005-1-ansuelsmth@gmail.com>
References: <20250607211133.2005-1-ansuelsmth@gmail.com>
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

The WARN macro requires inclusion of linux/bug.h header. It does
currently work as bitfield.h includes it indirectly but this will
change when bitfield.h will be synced with new Linux version.

Explicitly include the header to fix future compilation error.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 81e19d393cf..b3926564a22 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -10,6 +10,7 @@
 #include <dm/devres.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-- 
2.48.1

