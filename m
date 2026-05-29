Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC752CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 16:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFCCF846A3;
	Fri, 29 May 2026 18:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZYx9H0oz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6F7846B4; Fri, 29 May 2026 18:29:47 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 786E884671
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 18:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45ebafde87cso5065276f8f.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780072185; x=1780676985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+rOT88uKplkiszEffBWJqWUOgehsonqhF3jXNaH3C2o=;
 b=ZYx9H0ozOsT0G6KYHzDuPDhHBAITcSrg1znAny+CeHobwe4rWDK2sb8mdRyHjtXUvS
 63FsVyJCbWKTnB3uNGUvzmhnG+tE7EERU7cEIvWzz7IfPeW48j6Apu7je32LWOYGWNMG
 Ha6bW9mK/+mkfITyXLH1+5qT2DTl+vcmczxvkbeiDGIsNJ6+HWi69IYM+roJxxNLc2Fn
 Af+ZanlxsFfOBHSauRM9dmH/s+d64NuQvhD0hllqlRnll0YKNNjfzCWe6ZaLEZ03MGjS
 6WL/i13Sx8Gs58Twdy5tX2YdYGW+Q/dtOuG35zjDU7O3x1OHC4o4A5g46CFI331E7tED
 xNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780072185; x=1780676985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rOT88uKplkiszEffBWJqWUOgehsonqhF3jXNaH3C2o=;
 b=Jpz73/PMQ2C3+8tKLjcAoN+2hMmvpMEqA+z+HfyPIqeR8WTSf9p7mOIgQp7pSRx6sg
 bhMfsV382VepfUDUZ+mULB5f3Sofgm9ph+XWYNCKEVlmehuYY5nz/pLYm3T9jT5MFpKv
 Iq3mgFOXN6eOZTbxKFHu6F4QQCFdeYGWEqSY9kdpVdGYQ4DonTmpleRk7a11yjiyWrCv
 PAZ+uXM3EWgKH7G6dT7NHNvVUGqr0YkGkMpDrT8DqZeNFU9BdIXNKTiTxMHUu1K8FgIW
 +40905e0Wu+ItaZUobgbfNM3ghyUEBY43zmF7ggUWl580MzNDI4M7u/vQR/QTs3xWa5Q
 Gg6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DMZm95TmaZXWDKNewQ75J30qMWrCErVLiBdNSJJ9mrH3MuTB7YLfZ0Fh50fVQ23sN5Jn1Ysk=@lists.denx.de
X-Gm-Message-State: AOJu0YwP7n7zXkHPkj4Mu+Rujmdlfz9hIuiawLB4ysZuI27yXZXdU1aZ
 kJf4ampHdUmG/ap25yY2+YWFZRodz+sWqK684cyCVNu+AG9P0qoosOib
X-Gm-Gg: Acq92OGTgEjA7RGTsQPdI8qE6lVfCk+yS9zr5AyR4sjOfT6OpiwBjsMVCEbuG2ZrKZe
 6b6Ur8wWvyP4+nyPdHyBA8EynhGy92W/hZwG/fp5NWxPBGyXayHOezoTCnJ7HXk8+CU11nbD9MK
 g/baaeJ84JF3QWtr+P8zFoVQuar7FtLh6THPeTFgQLy0OG6co+RIyM8OcagKTg7aeSNh0QMZ+ST
 vFYEsQdmAffrwEIegJ2svAiPeR+rUfI4DLEOi7jV5nBsIOhyaDso6qKGJHtuLv/XQbxvpgcPWXA
 RFZRviCm4cDpoFqAGBfFvNSSsaQ2e4FqP+lbG1n04mafNYZiCORCysdMtvhioPL6n/DZzNWwzLt
 qIZJwzWHKB6SK+vEnwtCLrkF/aR3y8f5798efCP7i8dTBIS9oeWrAISItA0Hb/zT4YRdgNyeqeL
 mhxQKEmRfKG+M9apKUTEC5mAf8m7oa0ETXFNsM5JPtvzJC8wjbkfBpnKwhVBF7WcRAlVjfS/bYY
 OnPJS/M8P4CTZyhqjVnOOLpAxLo0gzKCf6ZLLWT2nHb/QFzEFJUBWTy+xwlfvYcIxl9v8GxMtQt
 f0G7b+/ScCVZUcIZ7PI5CjA+/Sh2LaGPV2ICKyKeFgpbKsx1iPMYnXdCRByZgFBoMx3TN+beYVE
 kw6TyUXenbKgWavP2e5sc/ASDm89ZUDMwwQ==
X-Received: by 2002:a5d:6192:0:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-45ef6b88abemr762368f8f.30.1780072184640; 
 Fri, 29 May 2026 09:29:44 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (3.e.4.9.3.6.4.7.1.4.f.f.c.e.1.f.1.0.0.0.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:1:f1ec:ff41:7463:94e3])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-45ef3556f51sm4526541f8f.25.2026.05.29.09.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 09:29:44 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] Revert "lmb: Reinstate access to memory above ram_top"
Date: Fri, 29 May 2026 17:29:38 +0100
Message-ID: <20260529162942.281897-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.54.0
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

This reverts commit a3075db94d49f415658bf7e961e1eae90d9abc33.

This causes boot issues on Raspberry Pi 4/5 in a number of ways,
the mmc needs memory < 4Gb, the mailbox needs it < 1Gb at the
very least so there's some work to be done here for that platform.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 lib/lmb.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 8f12c6ad8e5..e2d9fe86c14 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -611,6 +611,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 static void lmb_add_memory(void)
 {
 	int i;
+	phys_addr_t bank_end;
 	phys_size_t size;
 	u64 ram_top = gd->ram_top;
 	struct bd_info *bd = gd->bd;
@@ -624,9 +625,23 @@ static void lmb_add_memory(void)
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		size = bd->bi_dram[i].size;
+		bank_end = bd->bi_dram[i].start + size;
 
-		if (size)
+		if (size) {
 			lmb_add(bd->bi_dram[i].start, size);
+
+			/*
+			 * Reserve memory above ram_top as
+			 * no-overwrite so that it cannot be
+			 * allocated
+			 */
+			if (bd->bi_dram[i].start >= ram_top)
+				lmb_reserve(bd->bi_dram[i].start, size,
+					    LMB_NOOVERWRITE);
+			else if (bank_end > ram_top)
+				lmb_reserve(ram_top, bank_end - ram_top,
+					    LMB_NOOVERWRITE);
+		}
 	}
 }
 
-- 
2.54.0

