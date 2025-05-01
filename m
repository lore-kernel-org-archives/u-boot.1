Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C938C369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93417820EB;
	Thu,  1 May 2025 03:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="laRRzVNQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25AE5807B1; Thu,  1 May 2025 03:05:57 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3140281F0B
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8613f456960so15054739f.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061552; x=1746666352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvdGRPWel+QtTHsEQd1b+jomNFqqjZqQGfQknVlnbGU=;
 b=laRRzVNQ1Wdkq+I1W8Bb3Iw/xAX7kmS+A4iUPsoItasuxeoj4Z1o4NtNszg0RplJEs
 mhZ7cz4qGnibrhHbZCOqzT00591qORjIYEO8tKQ4xJQk9z93MVqOW2onq4jiaqrwjIKJ
 Gf6u92YoYs8/JtpEvAki7C1/SK1jhfyV+xx34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061552; x=1746666352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qvdGRPWel+QtTHsEQd1b+jomNFqqjZqQGfQknVlnbGU=;
 b=SjJO28sO1FXW5ahiDiv9zA6vS3ohlzymTqFehNCxnlrBhLV6wFS+93E4kjTiNC7s+f
 7YO68fng+QpgxJwqfdBVccMKHwqyi6YWFHKgv7DBK9MaKVY/4mgXY5p2DkUkwqlW+A+k
 vtNb9qq+HDGXOqi8v8rNDXfelZcozvi0xAn0RMzTHh/RdFPAbFnlh0ivq9rBf2CNDHBw
 lj96JffKEbe+5nESfl9/0r2yHCbAtvXpVZJ9FEi5ZFy9Uw5H2EvKE7QW4JDbclxh4Vbl
 USyExCdHIjz1tjitqV9QSZq1zzbI4s5Ph+Qz8Mf5PkfUX3vpEVRsap9CzWgqOCi8D5uY
 w1bw==
X-Gm-Message-State: AOJu0YyAey++FN9eoPqxBUSJKfUJUXdo3Y29yQyKGzDO0L6Z5dTJEi6M
 Vyk16JCJq3zGkkZ7NKePQGrIqI1IR/XcbyJI4hMmK/o1TX3D0nq1Ce+PRj6KYLCsvhTr678xdyQ
 =
X-Gm-Gg: ASbGncvBxPQZ4cAA+r02bsxsQpBp30hJUa3EQLNPFf/4LYxSRBq0/Jv5yzvRsXcinax
 3qyS62nwET/GZTOAf1ItoK2H1CgKiCszUMQ5IkJaodaVrw2O+0BS2f85Tco/taRy5kHRTbnrxKJ
 kfn+wUr1fxX3H2fPkFT3kLZ7p5EBsgPwknAAtgMUoV1JWQ2WxYFf2KThjYfXD7uIQnGyKId/8Tw
 Xtje+2gRV3QBxJfjH7bMv5bnSE8OcBx4nAa2t15PrGBipKERmMXNPCXGDLvOAsRogwqNx6OnZR1
 B/tPqAAYo/BCf35gna5ycTNrVdJVn0Nu7r+3QgcddJMpbuWn0Pl9zLpT+znoQQ7Gdjse7AH1p3d
 0bJg1K3bN5BV8
X-Google-Smtp-Source: AGHT+IGCjXdqy46jvXTNgCKYVAwn62LMQUnczMgbSBB+3i3Z54vZjG6I2GbbFF4GjpORZd6/VQSv2g==
X-Received: by 2002:a92:c24e:0:b0:3d8:1f87:9433 with SMTP id
 e9e14a558f8ab-3d9701fbd11mr7702945ab.11.1746061551759; 
 Wed, 30 Apr 2025 18:05:51 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adrian Alonso <adrian.alonso@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jason Liu <jason.hui.liu@nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2 13/22] freescale: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:38 -0600
Message-ID: <20250501010456.3930701-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/freescale/mx7dsabresd/mx7dsabresd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/freescale/mx7dsabresd/mx7dsabresd.c b/board/freescale/mx7dsabresd/mx7dsabresd.c
index 3db167c0dad..bef4f901ff7 100644
--- a/board/freescale/mx7dsabresd/mx7dsabresd.c
+++ b/board/freescale/mx7dsabresd/mx7dsabresd.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2015 Freescale Semiconductor, Inc.
  */
 
+#include <env.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/clock.h>
-- 
2.43.0

