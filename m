Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08830C5AD49
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 07:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF7C80C93;
	Sun,  8 Jun 2025 09:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QYFktj6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A55807B1; Sun,  8 Jun 2025 09:54:41 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E3480C93
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 09:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 899C1446FF
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749369278;
 bh=7ehf9jnwfs83netQ3PV9c+il9YqWJZuQ+UkKlG0F0fE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=QYFktj6Btckkt/L6/GeL0OoqxVOyMOb0j26bbVW83mNntWa7SF57uuEQj9m4NuvwR
 98EHv86i2NZbWJDuGFMZ42nHq7xNkIumkI2Nw6+NsNXb2l4c0TtCSRMGr413FSQM+1
 wIC9O3frFCujl3S1gCOW5hI4YSzZpP/Q+PQNXm6YZ68bzDKPTQgfVddgP5CTA2S8cw
 K4I4Juu3Mab38hjCHwT8bZ94em62TnkRKim9r1OiLPfdEXaqKNqIKfrgbvBXsWslZ7
 krzI8QzV3/ZSClkTQALfXjfItEXaL+8P9a6qI2TV3ZEQ3rBTcI6A+agLQYE4KOxFze
 5k7GKT8eiN/cA==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ade5b98537dso4418266b.2
 for <u-boot@lists.denx.de>; Sun, 08 Jun 2025 00:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749369278; x=1749974078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ehf9jnwfs83netQ3PV9c+il9YqWJZuQ+UkKlG0F0fE=;
 b=GaadTeq4CddY3GdaFoiw0Z+f5U5Bb343pFjkSW06YEZ8t1SBRyId7tHBfO9sWRBo9Y
 tqTzInD0bTDJ/xDMmK79Me72fz5CWmrgtfrS5Iq9DgrPW3PKPtSpZrA6dSL2EKoXPnJ3
 djuUW9wIfzkKsjdxSqC/vd8Jxbh+89qcoQUzkW3qWM/pIbBbcGNISf7Oyn/IgbMC/PXL
 ErRAYjiP13UxOcv0c75dDu5uM4XXR+IATiTKNwyuWnhH67DdugCGLTAf5CTXEBGi++NV
 M0z0gtab/JHDR6scLUQUtow31izYJ5UoABSAX8Fxs5jSaHanxo0bt9pqzYoYGTkZEhaS
 /swQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU05TUkotwAL/LmPZv+suPMZG8S+QIjiIg/2byGL4G8QQcdMb684SnQKt4Gbq5frgmr44ohDks=@lists.denx.de
X-Gm-Message-State: AOJu0YxDBnikJLpfBKd9uRVS4qLAJbpHyCNrEV/ZUfZNyMu9JDRs2jfh
 wQHmDsi9cGJK0vvlO9lCxp+Hy8IqrZUbW27eqP6lOPwBGvOQnorud+wOOyhUKk8N8kiveqn79kI
 xtiE8ro4nza+cnAvc7AvrH8K6LpCqigomYJ6/8SKhrODd8dQE4TBE1fY/7eC0ksUmcVMzDLQ=
X-Gm-Gg: ASbGncuY3TtBKKiyNEHJWw+DS7ruYvEtTM0a35q6Hsep8NIbHZFNdx8DT2iMRNBaImO
 oCZeDvKiyUCGOssrhmZh2seB12Q+aAN+bKGuvsUZEZzViSLxkXwAH3BvE9BKaXsmvlSG1+QMD9q
 BgqnJ37rW3Vptbxcguw84PWKnqcEUVLvFU29LW1N271klGoOvKMrd9SbBu6Oh2IFVHJl57aI2CZ
 qlefRuAUEOWSAOjwcqNitWaW/72yHzQrn9snIRhV9c33Zo3rY4ALQNFiPliSeciFnbavDFe5+Kb
 IbVMnfxdcJnEisfPigdkiuO5D0HaeIKzsjdTLEHefqa3XXWS0DxylWIlFsDmkoXzVNqT+PsDmsz
 c0DEVcCTi3SGmAR4FS0yYI1J5
X-Received: by 2002:a17:907:fdc1:b0:ad8:9c97:c2fc with SMTP id
 a640c23a62f3a-ade1a9057dfmr784522566b.13.1749369277802; 
 Sun, 08 Jun 2025 00:54:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ5lZHC4vg4hYBdBcMpjd62qU/fOpRBYfqJR0IH1KIvSdPvCwZzWSmCafrmq1K2geQLBWS4A==
X-Received: by 2002:a17:907:fdc1:b0:ad8:9c97:c2fc with SMTP id
 a640c23a62f3a-ade1a9057dfmr784520966b.13.1749369277424; 
 Sun, 08 Jun 2025 00:54:37 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade34ea5adesm270956066b.80.2025.06.08.00.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 00:54:36 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ying-Chun Liu <paul.liu@linaro.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/3] sandbox: fix dram_init()
Date: Sun,  8 Jun 2025 09:54:26 +0200
Message-ID: <20250608075428.32631-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
References: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
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

dram_init() must not overwrite the value of gd->ram_buf set by
setup_ram_buf() for main U-Boot or board_init_f() for SPL.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 board/sandbox/sandbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index d97945e58fc..43f4edc39e9 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -101,7 +101,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
 
 int dram_init(void)
 {
-	gd->ram_size = CFG_SYS_SDRAM_SIZE;
 	return 0;
 }
 
-- 
2.48.1

