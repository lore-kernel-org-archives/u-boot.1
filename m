Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD619CF34C0
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E0B983F7D;
	Wed, 19 Nov 2025 15:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j4Zu2lMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C2E883F72; Wed, 19 Nov 2025 15:50:37 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA5DC83F42
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-450b8afe3e0so1941668b6e.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763563833; x=1764168633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f/y3WtXwPb5Zhzce6Y1wbVki1xEttmmwD38GmS5+mJ4=;
 b=j4Zu2lMY6PD0X6nb9j9GAEy1cVvveqJMcG9hGkR5pe/LRzav4jA+s9IGQ8rDOKqKJj
 2DpEr/hnn/IJYTcgBCtQBsI+mp5DYnHHVgC3+I6m0pKD15279bYnSbpayCHcEgjwv5zH
 FCy8+wkuHJl43X4UeH/16qhmOCh7b7JpCj5IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763563833; x=1764168633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/y3WtXwPb5Zhzce6Y1wbVki1xEttmmwD38GmS5+mJ4=;
 b=DfswtnpW/SWPt/IUDifhkGMqZ3rYvflA3a0k1lHsjcvcPQ0L3hUWvzC9kw4shbUjug
 cJaH578dGQUUz28AyLAKsq5r11M0epcb4zVDcNFvFnDOxn2yMmnC458agPKlKX5fkaTa
 SpomhbmLoZSB1eIxdY26DgpB+GEswD9Xa9TrY/Ez2oCueEH0RCuuAp5CNObgGOUKWVCa
 zx19CxudEU01NvZFGnXny4RiE07UfB8p0m9LGpi1kkPAfpcdel0xWlaacHUEp5p9uJ58
 wIKQCQ03Nth88Z4St5cAPQykPRXtxEBQjYULf3Fc8KneQDKJwYaauCmMd5zhiA0xmhKq
 zPgA==
X-Gm-Message-State: AOJu0YxnuUg/pJwtNL9JwKID+CAkxEJLrXV1IwYi64Cb+zyCK3FngtwG
 /TQYQRT0dTfkxta0D085nd5WUNQRpyb+n2pXpp9AweMZaPUkM8hTuWH+MtyWLXe9qTGX+mOaDDq
 W1xik/kRhqA==
X-Gm-Gg: ASbGncuuozFSj0lpo5Sl1wA5fYvclL3Y8HHHra8Gq3TWOyrCihIFklves7R5/htTGOD
 Ihsm4Hbl7+dDRu7cqKv0zFX5BN9d7euCrm3k46C06H1XMpiJovoy/jUqkXlg3kPmpYTKjiT99mq
 QORpYmFSEllNYAiD41D75UaMLvmPsiHtKdwYKnN7tW+wSRIrYOSMLbMjDtm3ePastN4ZL0SIAR6
 xRRMDJnuclkxUtVgV92FeuKiNUx3dClz5BcE8ngsxZqxwP7XjT7GKUNSkauvfYf9Z6qtai5xsaf
 d4UQOyVOGvjDYEyWFjKARYOKSwwphH7msomdy2FPDb1o/YkwDeGIGolMhdjtNDejS61ITeUH95G
 Pa54GuQOTvdWVcSR10lBGl0NKQqiy1Xn15jkYb9qGCv+XHC8QSDvfC487EHme54bBSBgQ0LaGe+
 cvn6vpmje/APTTnrcXBPp1mpb8HCy5bTGcBjwDfJ9HPxpu/09LoAI0
X-Google-Smtp-Source: AGHT+IFlEqggeK7sfpVbgEl1YGb1aR86I97tjnVwtZwhk+yGfm294RkK+LYDzBaWvk5aQG9YxzwPXg==
X-Received: by 2002:a05:6808:1506:b0:450:cf73:7703 with SMTP id
 5614622812f47-450cf73938emr4831790b6e.12.1763563833613; 
 Wed, 19 Nov 2025 06:50:33 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a29cc3dsm7840151a34.9.2025.11.19.06.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:50:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH] liteboard: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:50:32 -0600
Message-ID: <20251119145032.842160-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Marcin Niestroj <m.niestroj@grinn-global.com>

---
 include/configs/liteboard.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/liteboard.h b/include/configs/liteboard.h
index 2934c76a662a..a90d02c049f6 100644
--- a/include/configs/liteboard.h
+++ b/include/configs/liteboard.h
@@ -24,7 +24,6 @@
 	"script=boot.scr\0" \
 	"image=zImage\0" \
 	"console=ttymxc0\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_file=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	"fdt_addr=0x83000000\0" \
-- 
2.43.0

