Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89331C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 10:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3D382EC6;
	Fri, 27 Jun 2025 12:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BLSRKTtm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C3B182F5D; Fri, 27 Jun 2025 12:09:47 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE3D482E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 12:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so15701315e9.0
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 03:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751018978; x=1751623778; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0/KN3Ta08i5EUsRLbse7gerjKLrSqWBt7yJBAG/TYPY=;
 b=BLSRKTtmuxQSf/MasELutSOdygDmaoTBEBxtn/1SUezDRSkHq/szThLVagKDgFqzmU
 i8D1I0t+/hFGWoPxRtelAVCwa1dyxL9OKQdHRyhJUNDOB1jARS7Cpo6crZ3GOERUH8Yv
 2pap8o3m5SJjNLterX5qmS0nOilxOsBnTuOHEdG/KOeYlTTXbeaIwmm27NO066MrcQQD
 wsXiUDXwS2QQ0H9fowgm1Zi5S+XlTAkXYs+CZRHP/0nfSZKyoQGEnp1w0vLC0hrJAsuu
 SOaQBwKucBeXGfUNDymVU/+IsWmnIBuFQvUBaVvO8vD2H/wwHffXY23fyTxM7UVUnjH2
 9KTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751018978; x=1751623778;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0/KN3Ta08i5EUsRLbse7gerjKLrSqWBt7yJBAG/TYPY=;
 b=ellmGn009XPIf4ieS4nSCVFy0+FDWWz0s6R3MJ8JyqDDD3R//QItiV+vxyPogQjn40
 7pIldTDE0AhJi8RkWEE3KoTjOURdgxJCs0Zj+ttCqgc5AwU+jzATGKlJTgdi+L72PiRI
 j2/ZTeH1/zoPWVWfvw/k1m6AHWx2t0ximRQpzi0QqHv3wjI94zNcxmVd/2/Wt5HsAdCr
 +5IT/7FRPonrC6FaPZpKmRY0M+mZQekfH7CMwZqikNafoJNgwGobPx91W/qyC1omgh8d
 UxPvfXg5gMIIB2SUk23zauqOMRdd3U1FGwk2jPFrnh81wY7phJ+SjLkoHQL403Uj/RfC
 wVLw==
X-Gm-Message-State: AOJu0Yz+5+DyK/vEXa64bTVbHoINKKJTkS8FIUSeehutxgJ1T66Soegc
 kqNJrBVxgjZsYRcSUbi3GKeCYKA1UYxvH65r9IUAWgM1urPlDpMRRcYECQmQdaMrChj/QJ3uuPJ
 /5VoAFAM=
X-Gm-Gg: ASbGncsF2koqMRwm3w0n2kumxS/iydvhlNTLayPSq/AlAeE01fbUDozxINV9/q1jDcH
 fmKx3Ot3hYwoBZNkFO7fmH1sfMGTdSiX7/r9W9FW2PMU5LbsubmlLePNDOpBTy1A2Me/gjr/ir9
 ohdZO367wraPDvZCpLqAhqPY8QA0BSPZ3xJ1/ZyrbUdUOkOxHUAZIBHlPnses5/oHVOf47e9siy
 BEEb8Q2yJ76WDchkbCjPn2pMMWqnfJAHrTPjX3KRpQZ7vDAqUiohfC68NWrmn4uwgTO82yBdhQc
 Kjgl4zTZINvD9GNREUHMIn5+bZCiVx0oNYocLB9uu+emT2vsB7xqwK2876b4MMyWvaVftm7exrG
 xiLXYnjkD68VgSQ==
X-Google-Smtp-Source: AGHT+IGPzIv3XUyAkmSWQvkuYZFc1ewigbodYzX0Iay0HNdc7rIEEqJMROi4T/Qe9tSgOnMp+OhHYA==
X-Received: by 2002:a05:600c:a319:b0:442:f98e:f37 with SMTP id
 5b1f17b1804b1-4538ee559f7mr20785415e9.21.1751018978028; 
 Fri, 27 Jun 2025 03:09:38 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:c61f:677:c14a:b7e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a423abbsm46761695e9.39.2025.06.27.03.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 03:09:37 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 27 Jun 2025 11:09:36 +0100
Subject: [PATCH] boot: Ensure method_flags is initialised before use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-bootflow_fix-v1-1-f1039b2962d6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAN9tXmgC/x2NUQqDQAwFryL5diEG2kKvUopk11gD7W5JRAXx7
 l37Ocwb3g4upuJwb3YwWdS15Apd20CaOL8k6FAZCOmCV7qFWMo8vsvaj7qFiIg8IHUpEdQksku
 IxjlNZ/Rhn8VO8TWp+//P43kcP3LnUW93AAAA
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

The local variable method_flags is only assigned to in some of the
code paths leaving it possibly uninitialised at first use.
Initialise method_flags at declaration to ensure that it cannot be
used uninitialised. Also remove now redundant assignments.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 boot/bootflow.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 4054a966af8..d60e9df6a9d 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -245,7 +245,7 @@ static int iter_incr(struct bootflow_iter *iter)
 	if (iter->flags & BOOTFLOWIF_SINGLE_DEV) {
 		ret = -ENOENT;
 	} else {
-		int method_flags;
+		int method_flags = 0;
 
 		ret = 0;
 		dev = iter->dev;
@@ -264,7 +264,6 @@ static int iter_incr(struct bootflow_iter *iter)
 		} else if (IS_ENABLED(CONFIG_BOOTSTD_FULL) &&
 			   iter->flags & BOOTFLOWIF_SINGLE_MEDIA) {
 			log_debug("next in single\n");
-			method_flags = 0;
 			do {
 				/*
 				 * Move to the next bootdev child of this media
@@ -306,7 +305,6 @@ static int iter_incr(struct bootflow_iter *iter)
 				}
 			} else {
 				ret = bootdev_next_prio(iter, &dev);
-				method_flags = 0;
 			}
 		}
 		log_debug("ret=%d, dev=%p %s\n", ret, dev,

---
base-commit: 359e3012921f2fc2d43f3c4e320a752173f82b82
change-id: 20250627-bootflow_fix-b000ad021cc2

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

