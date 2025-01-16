Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE0BC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 103A98074B;
	Fri, 17 Jan 2025 00:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KT75Y9nD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A9858022B; Fri, 17 Jan 2025 00:01:43 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 519088022B
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ee29277d44so817970b6e.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737068500; x=1737673300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gyXw+LS/E0IjZvfIOmv0tX+zMKFoiXdYXxrJHpBaL10=;
 b=KT75Y9nD00shPbd01v8LKqOEW3iw84RLFTWNTS28O4qSARD4T4xKfyRcYjs2/+fty8
 379d0uHdrMCzehOvmohgSV+rXHukxPodU4mSIghZue1TU2Bdg/hVN4Y03B753upH3cUV
 YrOIV9Hqj0WZOn6ZStx5Qny/VEHbe2t6isGbnWAal8jVArma1jVfpg3vUNcUlAtvkpUH
 k5lWW5rNBslFmeT4JtxHF66OY+bF8Dz23u12UbA3HFsXa9BtBc/XREKWSJmjV04O3vqG
 6e5I5Sdv7Cn4tVb9mvlQwoujKm2ZvjqAdeY0IEpZraBywJENZCDD68xeKwEfDENhtWck
 oc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068500; x=1737673300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyXw+LS/E0IjZvfIOmv0tX+zMKFoiXdYXxrJHpBaL10=;
 b=Qx0H607wgSO8BisWkEB182J2MH1qqMHPXFlKD7sDD4t6qmRp5awADmQb1MDY0sSqoY
 VsyJ+uRaLDVpehnF20QNtTLiLsg/FrkXa2KESsntds4bTCU/y1UJghB+pMrOskLqPlOL
 4JukEJWVVVuz7BHuA6l3Y019zI8AOag/eRanugWKXQyJ1X7WqSGCDlOVnB4MeADzsIhW
 5IkblZEn6hQUM8Q7JDxrwRcU7A9qwbGfSbGQO2Pc7mujGoSNuQanJG20w/kYQ+xrJQwb
 nbB0Kbns/SBRbY2q2hW6omZTk7f4cXCt8S6erI7L5rjCDtu+hIlAf0is3WP7hD+oRStp
 hlYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWPCE+yzqHciWaMQabiBs7VMHQBbmNUFxHGFp9UvNPRsNETLZ7x25pOPUMSQ2EWDL9tyr044Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyvWAqOENDXEa1t3qSslSkRKNscsM11fDwlVr6aJ/Dxxo3uyZ59
 HHcboCy5GHuvXkuRad6cKD7heoGviINMWjqZ1wF2atGNZxNQJrsto8xVw3wXRBU=
X-Gm-Gg: ASbGncv+I41ezOhlquOKqkudhB5Yhir/VRa0T1yjs6GxCXl0ij+uis5/8IJ4RxhnqM+
 YzNUIy8RHjLnCP6QK4C91x/FJWko3SOxTihwR5C2c3o+3xz0I8Tc3NKqZ8FEnGQLsuo0VYvgqof
 4oFkgZqjJ0HeIkvo06rsu/Xh0rjdAwc20IK3y5R/zX0hs+/kRwbjIPVkXvBdlTckElxGQCVer2i
 peM15VDV9eL6HsoAi+sprW2EIkHaB+qjOAad+2SHtp15w5b+SRBZP7gwtj2oVLHRc8=
X-Google-Smtp-Source: AGHT+IGnT71Jw2raBHOA4dkwKhspXcpExcBfErqAx+1YsbAFa5vtnfAQRDL/gvtl2dX6Z02J5aSPPQ==
X-Received: by 2002:a05:6808:22ab:b0:3ea:431c:4f70 with SMTP id
 5614622812f47-3f19fb1f3a0mr509366b6e.0.1737068500131; 
 Thu, 16 Jan 2025 15:01:40 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f19da453b0sm419022b6e.6.2025.01.16.15.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 15:01:39 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 6/7] board: samsung: e850-96: Report LDFW loading failures
Date: Thu, 16 Jan 2025 17:01:29 -0600
Message-Id: <20250116230130.3337-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116230130.3337-1-semen.protsenko@linaro.org>
References: <20250116230130.3337-1-semen.protsenko@linaro.org>
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

LDFW firmware loading can fail, e.g. in case if user forgot to upload
the binary to the appropriate location (/EFI/firmware/ldfw.bin on ESP
partition). Report such errors explicitly, so that the user can notice
it early and take necessary actions. But don't return error code from
board_init() in this case, as LDFW firmware is not mandatory for board
operation and is only required for some features like TRNG.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index c5cef6f19d22..0bef68d2fb20 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -19,6 +19,11 @@ int dram_init_banksize(void)
 
 int board_init(void)
 {
-	load_ldfw();
+	int err;
+
+	err = load_ldfw();
+	if (err)
+		printf("ERROR: LDFW loading failed (%d)\n", err);
+
 	return 0;
 }
-- 
2.39.5

