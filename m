Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0ECD7494F
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 00:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A861E891B2;
	Wed, 30 Oct 2024 01:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="raUOwvYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BABA891BB; Wed, 30 Oct 2024 01:36:56 +0100 (CET)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF939890AE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 01:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4a47fff85d2so1934758137.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730248613; x=1730853413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AV6s831rtLg0hbTY6InA91y2ZD41Rt04Xgq8fESUe7Q=;
 b=raUOwvYi9jlkGLKFt8XnUXge6HC+uTir5QoY+fdROBxswXeTvmECa+l0qI+iJGC5dE
 I531CeJGEsan2lPMgL0lsyNAIVrXTsN/hV9OG6ks4SfLsd8e9ATOuSMMEsBP1rlR3RVH
 T5FfLXXB5eU9PYCioLFyOv1TmPUX/8qK3dbDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730248613; x=1730853413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AV6s831rtLg0hbTY6InA91y2ZD41Rt04Xgq8fESUe7Q=;
 b=K6zX0eq+t3QujKtddfNdAyZTbOKGP4MQanAeK5Q+IanPSpqbQIgBTRl/a1H5zQSXsq
 VluIY9hEckChX355yhkqS3vxBc9qM3vxvuZxNTaUShmJJ+QOpXUrU8NlzOBNWEGI0Bry
 aQGBD9IQxC9r7oBy/7e+Z8Pn6kBep9MiyTHORAHhpVU1ffkl4S0k1J7MLV6Lh8a5T7ai
 h5PWqOocMLZV1xzhgkoxl6F7wv41s5R1gyKdpAR6TifsIbylh0sE9eWpjVwRmTHEKPPv
 AeGiYIHMhW5UQm+Hut5+9pBGSYZymDdF1H2Hefw+BNcqVawejABPBZlDtRTLfHVZ8Ri0
 RuvA==
X-Gm-Message-State: AOJu0YwINeRqtmRfSn0h/8jI2Jxxg91c6Qo6iCqloBGuAAlaRSmn3CZl
 EvlBFOiQoZrLrRDJoMc1LoiE5ro+Hm7LEvfxi/TmHJD7db8emL32c7mWXSCxeKNnkemv/wEPdLr
 qVCU=
X-Google-Smtp-Source: AGHT+IFgHnYfkEBpz0Hlgt90rwJtPei7vYtgtkZSHVrFyZVfm3sLdOvZnmm3ZkH+R3+tDXGU/ATeEQ==
X-Received: by 2002:a05:6102:38d1:b0:4a5:b159:8557 with SMTP id
 ada2fe7eead31-4a900e10f6emr1846744137.4.1730248612737; 
 Tue, 29 Oct 2024 17:36:52 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.104.2])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-461323a7185sm49738771cf.83.2024.10.29.17.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 17:36:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] test/cmd/mem_copy.c: Use CONFIG_SYS_LOAD_ADDR for base
Date: Tue, 29 Oct 2024 18:36:49 -0600
Message-ID: <20241030003649.3506474-1-trini@konsulko.com>
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

When reading/writing to memory we cannot assume that a base address of
0x0 is correct and functional. So use CONFIG_SYS_LOAD_ADDR as the base
from which we add a bit more padding and being our tests.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/cmd/mem_copy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cmd/mem_copy.c b/test/cmd/mem_copy.c
index 1ba0cebbbe04..67eca328777a 100644
--- a/test/cmd/mem_copy.c
+++ b/test/cmd/mem_copy.c
@@ -21,7 +21,7 @@ struct param {
 static int do_test(struct unit_test_state *uts,
 		   const char *suffix, int d, int s, int count)
 {
-	const long addr = 0x1000;
+	const long addr = CONFIG_SYS_LOAD_ADDR + 0x1000;
 	u8 shadow[BUF_SIZE];
 	u8 *buf;
 	int i, w, bytes;
-- 
2.43.0

